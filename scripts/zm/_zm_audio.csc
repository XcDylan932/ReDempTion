#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace zm_audio;

REGISTER_SYSTEM_EX( "zm_audio", &__init__, &__main__, undefined )

function __init__()
{
	clientfield::register( "allplayers", "charindex", 1, 6, "int", &charindex_cb, 0, 1 );
	clientfield::register( "toplayer", "isspeaking", 1, 1, "int", &isspeaking_cb, 0, 1 );
	DEFAULT( level.exert_sounds, [] );
	level.exert_sounds[0]["playerbreathinsound"] = "vox_exert_generic_inhale";
	level.exert_sounds[0]["playerbreathoutsound"] = "vox_exert_generic_exhale";
	level.exert_sounds[0]["playerbreathgaspsound"] = "vox_exert_generic_exhale";
	level.exert_sounds[0]["falldamage"] = "vox_exert_generic_pain";
	level.exert_sounds[0]["mantlesoundplayer"] = "vox_exert_generic_mantle";
	level.exert_sounds[0]["meleeswipesoundplayer"] = "vox_exert_generic_knifeswipe";
	level.exert_sounds[0]["dtplandsoundplayer"] = "vox_exert_generic_pain";
	level thread gameover_snapshot();
	callback::on_spawned( &on_player_spawned );
}

function __main__()
{
	setup_personality_character_exerts();
}

function on_player_spawned( localclientnum ){}

function delay_set_exert_id( newval )
{
	self endon( "entityshutdown" );
	self endon( "sndendexertoverride" );
	wait 0.5;
	self.player_exert_id = newval;
}

function charindex_cb( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if( isdefined( world.character_bodymodels ) && isdefined( world.campfire_characters ) )
	{
		set = Int( newval / 4 );
		index = Int( newval % 4 );
		world.character_bodymodels[localclientnum] = world.campfire_characters.character_sets[set][index];
	}
	id = ( newval <= 15 ? ( newval % 4 ) + 1 : newval + 1 );
	if( !bnewent )
	{
		self.player_exert_id = id;
		self._first_frame_exert_id_recieved = 1;
		self notify( "sndendexertoverride" );
	}
	else if( !isdefined( self._first_frame_exert_id_recieved ) )
	{
		self._first_frame_exert_id_recieved = 1;
		self thread delay_set_exert_id( id );
	}
	SetUIModelValue( CreateUIModel( GetUIModelForController( localclientnum ), "SelectedCharacterIndex" ), newval );
}

function isspeaking_cb( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if( !bnewent )
	{
		self.isspeaking = newval;
	}
	else
	{
		self.isspeaking = 0;
	}
}

function zmbmuslooper()
{
	ent = Spawn( 0, (0, 0, 0), "script_origin" );
	PlaySound( 0, "mus_zmb_gamemode_start", (0, 0, 0) );
	wait 10;
	ent PlayLoopSound( "mus_zmb_gamemode_loop", 0.05 );
	ent thread waitfor_music_stop();
}

function waitfor_music_stop()
{
	level waittill( "stpm" );
	self StopAllLoopSounds(0.1);
	PlaySound( 0, "mus_zmb_gamemode_end", (0, 0, 0) );
	wait 1;
	self Delete();
}

function playerfalldamagesound( client_num, firstperson )
{
	self playerexert( client_num, "falldamage" );
}

function clientvoicesetup()
{
	callback::on_localclient_connect( &audio_player_connect );
	players = GetLocalPlayers();
	for( i = 0; i < players.size; i++ )
	{
		thread audio_player_connect(i);
	}
}

function audio_player_connect( localclientnum )
{
	thread sndvonotifyplain( localclientnum, "playerbreathinsound" );
	thread sndvonotifyplain( localclientnum, "playerbreathoutsound" );
	thread sndvonotifyplain( localclientnum, "playerbreathgaspsound" );
	thread sndvonotifyplain( localclientnum, "mantlesoundplayer" );
	thread sndvonotifyplain( localclientnum, "meleeswipesoundplayer" );
	thread sndvonotifydtp( localclientnum, "dtplandsoundplayer" );
}

function playerexert( localclientnum, exert )
{
	if( IS_TRUE( self.isspeaking ) || IS_TRUE( self.beast_mode ) )
	{
		return;
	}

	id = level.exert_sounds[0][exert];
	if( isdefined( self.player_exert_id ) && isdefined( level.exert_sounds[self.player_exert_id][exert] ) )
	{
		id = level.exert_sounds[self.player_exert_id][exert];
	}

	if( isdefined( id ) )
	{
		if( IsArray( id ) )
		{
			id = array::random( id );
		}
		self PlaySound( localclientnum, id );
	}
}

function sndvonotifydtp( localclientnum, notifystring )
{
	level notify( "kill_sndVoNotifyDTP" + localclientnum + notifystring );
	level endon( "kill_sndVoNotifyDTP" + localclientnum + notifystring );
	player = undefined;
	while( !isdefined( player ) )
	{
		player = GetNonPredictedLocalPlayer( localclientnum );
		wait 0.05;
	}

	player endon( "disconnect" );
	for(;;)
	{
		player waittill( notifystring, surfacetype );
		player playerexert( localclientnum, notifystring );
	}
}

function sndmeleeswipe( localclientnum, notifystring )
{
	player = undefined;
	while( !isdefined( player ) )
	{
		player = GetNonPredictedLocalPlayer( localclientnum );
		wait 0.05;
	}

	player endon( "disconnect" );
	for(;;)
	{
		player waittill( notifystring );
		currentweapon = GetCurrentWeapon( localclientnum );
		if( IS_TRUE( level.sndnomeleeonclient ) )
		{
			return;
		}
		if( IS_TRUE( player.is_player_zombie ) )
		{
			PlaySound( 0, "zmb_melee_whoosh_zmb_plr", player.origin );
			continue;
		}
		if( currentweapon.name == "bowie_knife" )
		{
			PlaySound( 0, "zmb_bowie_swing_plr", player.origin );
			continue;
		}
		if( currentweapon.name == "spoon_zm_alcatraz" )
		{
			PlaySound( 0, "zmb_spoon_swing_plr", player.origin );
			continue;
		}
		if( currentweapon.name == "spork_zm_alcatraz" )
		{
			PlaySound( 0, "zmb_spork_swing_plr", player.origin );
			continue;
		}
		PlaySound( 0, "zmb_melee_whoosh_plr", player.origin );
	}
}

function sndvonotifyplain( localclientnum, notifystring )
{
	level notify( "kill_sndVoNotifyPlain" + localclientnum + notifystring );
	level endon( "kill_sndVoNotifyPlain" + localclientnum + notifystring );

	player = undefined;
	while( !isdefined( player ) )
	{
		player = GetNonPredictedLocalPlayer( localclientnum );
		wait 0.05;
	}

	player endon( "disconnect" );
	for(;;)
	{
		player waittill( notifystring );
		if( IS_TRUE( player.is_player_zombie ) )
		{
			continue;
		}
		player playerexert( localclientnum, notifystring );
	}
}

function end_gameover_snapshot()
{
	level util::waittill_any( "demo_jump", "demo_player_switch", "snd_clear_script_duck" );
	wait 1;
	audio::snd_set_snapshot( "default" );
	level thread gameover_snapshot();
}

function gameover_snapshot()
{
	level waittill( "zesn" );
	audio::snd_set_snapshot( "zmb_game_over" );
	level thread end_gameover_snapshot();
}

function sndsetzombiecontext( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if( newval == 1 )
	{
		self SetSoundEntContext( "grass", "no_grass" );
	}
	else
	{
		self SetSoundEntContext( "grass", "in_grass" );
	}
}

function sndzmblaststand( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if( newval )
	{
		PlaySound( localclientnum, "chr_health_laststand_enter", (0, 0, 0) );
		self.inlaststand = 1;
		SetSoundContext( "laststand", "active" );
		if( !IsSplitScreen() )
		{
			ForceAmbientRoom( "sndHealth_LastStand" );
		}
	}
	else
	{
		if( IS_TRUE( self.inlaststand ) )
		{
			PlaySound( localclientnum, "chr_health_laststand_exit", (0, 0, 0) );
			self.inlaststand = 0;
			if( !IsSplitScreen() )
			{
				ForceAmbientRoom("");
			}
		}
		SetSoundContext( "laststand", "" );
	}
}

function setup_personality_character_exerts()
{
	for( exertIndex = 1; exertIndex <= 44; exertIndex++ )
	{
		if( exertIndex >= 5 && exertIndex <= 16 )
		{
			continue;
		}
		init_player_sounds( exertIndex, 1, "playerbreathinsound", "_exert_inhale_" );
		init_player_sounds( exertIndex, 1, "playerbreathoutsound", "_exert_exhale_" );
		init_player_sounds( exertIndex, 5, "meleeswipesoundplayer", "_exert_knife_swipe_" );
		init_player_sounds( exertIndex, 7, "mantlesoundplayer", "_exert_grunt_" );
		init_player_sounds( exertIndex, 4, "falldamage", "_exert_pain_" );
	}
}

function init_player_sounds( exertIndex, n_sounds, category, vox_str )
{
    charIndex = exertIndex - 1;
    DEFAULT( level.exert_sounds, [] );
    DEFAULT( level.exert_sounds[exertIndex], [] );
    level.exert_sounds[exertIndex][category] = [];
    for( soundIndex = 0; soundIndex < n_sounds; soundIndex++ )
    {
        level.exert_sounds[exertIndex][category][soundIndex] = "vox_plr_" + charIndex + vox_str + soundIndex;
    }
}