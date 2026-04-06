#using scripts\codescripts\struct;

#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\music_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace zm_audio;

REGISTER_SYSTEM_EX( "zm_audio", &__init__, &__main__, undefined )

function __init__()
{
	clientfield::register( "allplayers", "charindex", VERSION_SHIP, 6, "int" );
	clientfield::register( "toplayer", "isspeaking", VERSION_SHIP, 1, "int" );
	level.audio_get_mod_type = &get_mod_type;
	level zmbvox();
	callback::on_connect( &init_audio_functions );
	level thread sndannouncer_init();
}

function __main__()
{
	setup_personality_character_exerts();
}

function setexertvoice( id )
{
	self.player_exert_id = ( id <= 15 ? ( id % 4 ) + 1 : id + 1 );
	self clientfield::set( "charindex", id );
}

function playerexert( exert, notifywait = 0 )
{
	if( IS_TRUE( self.isspeaking ) || IS_TRUE( self.isexerting ) || IS_TRUE( self.beastmode ) )
	{
		return;
	}
	id = level.exert_sounds[0][exert];
	if( isdefined( self.player_exert_id ) )
	{
		if( !isdefined( level.exert_sounds ) || !isdefined( level.exert_sounds[self.player_exert_id] ) || !isdefined( level.exert_sounds[self.player_exert_id][exert] ) )
		{
			return;
		}
		if( IsArray( level.exert_sounds[self.player_exert_id][exert] ) )
		{
			id = array::random( level.exert_sounds[self.player_exert_id][exert] );
		}
		else
		{
			id = level.exert_sounds[self.player_exert_id][exert];
		}
	}
	if( isdefined( id ) )
	{
		self.isexerting = 1;
		if( notifywait )
		{
			self PlaySoundWithNotify( id, "done_exerting" );
			self waittill( "done_exerting" );
			self.isexerting = 0;
		}
		else
		{
			self thread exert_timer();
			self PlaySound( id );
		}
	}
}

function exert_timer()
{
	self endon( "disconnect" );

	wait RandomFloatRange( 1.5, 3 );
	self.isexerting = 0;
}

function zmbvox()
{
	level.votimer = [];
	level.vox = zmbvoxcreate();
	if( IsFunctionPtr( level._zmbvoxlevelspecific ) )
	{
		level thread [[ level._zmbvoxlevelspecific ]]();
	}
	if( IsFunctionPtr( level._zmbvoxgametypespecific ) )
	{
		level thread [[ level._zmbvoxgametypespecific ]]();
	}
	announcer_ent = Spawn( "script_origin", (0, 0, 0) );
	level.vox zmbvoxinitspeaker( "announcer", "vox_zmba_", announcer_ent );
	level.exert_sounds[0]["burp"] = "evt_belch";
	level.exert_sounds[0]["hitmed"] = "null";
	level.exert_sounds[0]["hitlrg"] = "null";
	if( IsFunctionPtr( level.setupcustomcharacterexerts ) )
	{
		[[ level.setupcustomcharacterexerts ]]();
	}
}

function init_audio_functions()
{
	self thread zombie_behind_vox();
	self thread player_killstreak_timer();
	if( IsFunctionPtr( level._custom_zombie_oh_shit_vox_func ) )
	{
		self thread [[ level._custom_zombie_oh_shit_vox_func ]]();
	}
	else
	{
		self thread oh_shit_vox();
	}
}

function zombie_behind_vox()
{
	level endon( "unloaded" );
	self endon( "death_or_disconnect" );
	if( !isdefined( level._zbv_vox_last_update_time ) )
	{
		level._zbv_vox_last_update_time = 0;
		level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
	}

	for(;;)
	{
		wait 1;
		t = GetTime();
		if( t > ( level._zbv_vox_last_update_time + 1000 ) )
		{
			level._zbv_vox_last_update_time = t;
			level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
		}
		zombs = level._audio_zbv_shared_ent_list;
		played_sound = 0;
		for( i = 0; i < zombs.size; i++ )
		{
			if( !isdefined( zombs[i] ) )
			{
				continue;
			}
			if( zombs[i].isdog )
			{
				continue;
			}
			dist = 150;
			z_dist = 50;
			alias = level.vox_behind_zombie;
			if( isdefined( zombs[i].zombie_move_speed ) )
			{
				switch( zombs[i].zombie_move_speed )
				{
					case "walk":
						dist = 150;
						break;

					case "run":
						dist = 175;
						break;

					case "sprint":
						dist = 200;
						break;
				}
			}
			if( DistanceSquared( zombs[i].origin, self.origin ) < SQR(dist) )
			{
				yaw = self zm_utility::getyawtospot( zombs[i].origin );
				z_diff = self.origin[2] - zombs[i].origin[2];
				if( yaw < -95 || yaw > 95 && Abs( z_diff ) < 50 )
				{
					zombs[i] notify( "bhtn_action_notify", "behind" );
					played_sound = 1;
					break;
				}
			}
		}
		if( played_sound )
		{
			wait 3.5;
		}
	}
}

function oh_shit_vox()
{
	self endon( "death_or_disconnect" );
	
	for(;;)
	{
		wait 1;
		players = GetPlayers();
		zombs = zombie_utility::get_round_enemy_array();
		if( players.size >= 1 )
		{
			close_zombs = 0;
			for( i = 0; i < zombs.size; i++ )
			{
				if( !isdefined( zombs[i].favoriteenemy ) || zombs[i].favoriteenemy === self )
				{
					if( DistanceSquared( zombs[i].origin, self.origin ) < 62500 )
					{
						close_zombs++;
					}
				}
			}
			if( close_zombs > 4 )
			{
				self create_and_play_dialog( "general", "oh_shit" );
				wait 4;
			}
		}
	}
}

function player_killstreak_timer()
{
	self endon( "disconnect" );
	self endon( "death" );
	if( GetDvarString( "zombie_kills" ) == "" )
	{
		SetDvar( "zombie_kills", "7" );
	}
	if( GetDvarString( "zombie_kill_timer" ) == "" )
	{
		SetDvar( "zombie_kill_timer", "5" );
	}
	kills = GetDvarInt( "zombie_kills" );
	time = GetDvarInt( "zombie_kill_timer" );
	if( !isdefined( self.timerisrunning ) )
	{
		self.timerisrunning = 0;
		self.killcounter = 0;
	}
	
	for(;;)
	{
		self waittill( "zom_kill", zomb );
		if( IS_TRUE( zomb._black_hole_bomb_collapse_death ) )
		{
			continue;
		}
		if( IS_TRUE( zomb.microwavegun_death ) )
		{
			continue;
		}
		self.killcounter++;
		if( self.timerisrunning != 1 )
		{
			self.timerisrunning = 1;
			self thread timer_actual( kills, time );
		}
	}
}

function player_zombie_kill_vox( hit_location, player, mod, zombie )
{
	weapon = player GetCurrentWeapon();
	dist = DistanceSquared( player.origin, zombie.origin );
	DEFAULT( level.zombie_vars[player.team]["zombie_insta_kill"], 0 );
	instakill = level.zombie_vars[player.team]["zombie_insta_kill"];
	death = [[ level.audio_get_mod_type ]]( hit_location, mod, weapon, zombie, instakill, dist, player );
	if( !isdefined( death ) )
	{
		return undefined;
	}
	if( !IS_TRUE( player.force_wait_on_kill_line ) )
	{
		player.force_wait_on_kill_line = 1;
		player create_and_play_dialog( "kill", death );
		wait 2;
		if( isdefined( player ) )
		{
			player.force_wait_on_kill_line = 0;
		}
	}
}

function get_response_chance( event )
{
	if( !isdefined( level.response_chances[event] ) )
	{
		return 0;
	}
	return level.response_chances[event];
}

function get_mod_type( impact, mod, weapon, zombie, instakill, dist, player )
{
	close_dist = 4096;
	med_dist = 15376;
	far_dist = 160000;

	if( weapon.name == "hero_annihilator" )
		return "annihilator";

	if( zm_utility::is_placeable_mine( weapon ) )
		return( !instakill ? "betty" : "weapon_instakill" );

	if( zombie.damageweapon.name == "cymbal_monkey" )
		return( instakill ? "weapon_instakill" : "monkey" );

	if( weapon.name == "ray_gun" && dist > far_dist )
		return( !instakill ? "raygun" : "weapon_instakill" );

	if( zm_utility::is_headshot( weapon, impact, mod ) && dist >= far_dist )
		return "headshot";

	if( mod == "MOD_MELEE" || mod == "MOD_UNKNOWN" && dist < close_dist )
		return( !instakill ? "melee" : "melee_instakill" );

	if( zm_utility::is_explosive_damage( mod ) && weapon.name != "ray_gun" && !IS_TRUE( zombie.is_on_fire ) )
		return( !instakill ? "explosive" : "weapon_instakill" );

	if( weapon.doesfiredamage && ( mod == "MOD_BURNED" || mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" ) )
		return( !instakill ? "flame" : "weapon_instakill" );

	if( mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" )
		return( !instakill ? "bullet" : "weapon_instakill" );

	if( instakill )
		return "default";

	if( mod != "MOD_MELEE" && zombie.missinglegs )
		return "crawler";

	if( mod != "MOD_BURNED" && dist < close_dist )
		return "close";

	return "default";
}

function timer_actual( kills, time )
{
	self endon( "disconnect" );
	self endon( "death" );

	timer = GetTime() + ( time * 1000 );
	while( GetTime() < timer )
	{
		if( self.killcounter > kills )
		{
			self create_and_play_dialog( "kill", "streak" );
			wait 1;
			self.killcounter = 0;
			timer = -1;
		}
		wait 0.1;
	}
	wait 10;
	self.killcounter = 0;
	self.timerisrunning = 0;
}

function zmbvoxcreate()
{
	vox = SpawnStruct();
	vox.speaker = [];
	return vox;
}

function zmbvoxinitspeaker( speaker, prefix, ent )
{
	ent.zmbvoxid = speaker;
	if( !isdefined( self.speaker[speaker] ) )
	{
		self.speaker[speaker] = SpawnStruct();
		self.speaker[speaker].alias = [];
	}
	self.speaker[speaker].prefix = prefix;
	self.speaker[speaker].ent = ent;
}

function custom_kill_damaged_vo( player )
{
	self notify( "sound_damage_player_updated" );
	self endon( "sound_damage_player_updated" );
	self endon( "death" );
	
	self.sound_damage_player = player;
	wait 2;
	self.sound_damage_player = undefined;
}

function loadplayervoicecategories( table )
{
	//DEFAULT( level.votimer, [] );
	//DEFAULT( level.sndplayervox, [] );
	level.votimer = [];
	level.sndplayervox = [];
	index = 0;
	row = TableLookupRow( table, index );
	while( isdefined( row ) )
	{
		category = checkstringvalid( row[0] );
		subcategory = checkstringvalid( row[1] );
		suffix = checkstringvalid( row[2] );
		percentage = Int( row[3] );
		if( percentage <= 0 )
		{
			percentage = 100;
		}
		response = checkstringtrue( row[4] );
		if( IS_TRUE( response ) )
		{
			for( i = 0; i < 4; i++ )
			{
				zmbvoxadd( category, subcategory + "_resp_" + i, suffix + "_resp_" + i, 50, 0 );
			}
		}
		delaybeforeplayagain = checkintvalid( row[5] );
		zmbvoxadd( category, subcategory, suffix, percentage, response, delaybeforeplayagain );
		index++;
		row = TableLookupRow( table, index );
	}
}

function checkstringvalid( str )
{
	if( str != "" )
	{
		return str;
	}
	return undefined;
}

function checkstringtrue( str )
{
	if( !isdefined( str ) )
	{
		return false;
	}
	if( str != "" )
	{
		if( ToLower( str ) == "true" )
		{
			return true;
		}
	}
	return false;
}

function checkintvalid( value, defaultvalue = 0 )
{
	if( !isdefined( value ) )
	{
		return defaultvalue;
	}
	if( value == "" )
	{
		return defaultvalue;
	}
	return Int( value );
}

function zmbvoxadd( category, subcategory, suffix, percentage, response, delaybeforeplayagain = 0 )
{
	vox = level.sndplayervox;
	DEFAULT( vox[category], [] );
	vox[category][subcategory] = SpawnStruct();
	vox[category][subcategory].suffix = suffix;
	vox[category][subcategory].percentage = percentage;
	vox[category][subcategory].response = response;
	vox[category][subcategory].delaybeforeplayagain = delaybeforeplayagain;
	zm_utility::create_vox_timer( subcategory );
}

function create_and_play_dialog( category, subcategory, force_variant )
{
	if( !isdefined( level.sndplayervox ) )
	{
		return;
	}
	if( !isdefined( level.sndplayervox[category] ) )
	{
		return;
	}
	if( !isdefined( level.sndplayervox[category][subcategory] ) )
	{
		return;
	}
	if( IS_TRUE( level.sndvoxoverride ) || ( IS_TRUE( self.isspeaking ) && !IS_TRUE( self.b_wait_if_busy ) ) )
	{
		return;
	}
	suffix = level.sndplayervox[category][subcategory].suffix;
	percentage = level.sndplayervox[category][subcategory].percentage;
	prefix = shouldplayerspeak( self, category, subcategory, percentage );
	if( !isdefined( prefix ) )
	{
		return;
	}
	sound_to_play = self zmbvoxgetlinevariant( prefix, suffix, force_variant );
	if( isdefined( sound_to_play ) )
	{
		self thread do_player_or_npc_playvox( sound_to_play, category, subcategory );
	}
}

function do_player_or_npc_playvox( sound_to_play, category, subcategory )
{
	self endon( "death_or_disconnect" );

	if( self flag::exists( "in_beastmode" ) && self flag::get( "in_beastmode" ) )
	{
		return;
	}
	DEFAULT( self.isspeaking, 0 );
	if( self.isspeaking )
	{
		return;
	}
	waittime = 1;
	if( !self arenearbyspeakersactive() || IS_TRUE( self.ignorenearbyspkrs ) )
	{
		self.speakingline = sound_to_play;
		self.isspeaking = 1;
		if( IsPlayer( self ) )
		{
			self clientfield::set_to_player( "isspeaking", 1 );
		}
		playbacktime = SoundGetPlaybackTime( sound_to_play );
		if( !isdefined( playbacktime ) )
		{
			return;
		}
		if( playbacktime >= 0 )
		{
			playbacktime = playbacktime * 0.001;
		}
		else
		{
			playbacktime = 1;
		}
		if( IsFunctionPtr( level._do_player_or_npc_playvox_override ) )
		{
			self thread [[ level._do_player_or_npc_playvox_override ]]( sound_to_play, playbacktime );
			wait playbacktime;
		}
		else if( !self istestclient() )
		{
			self PlaySoundOnTag( sound_to_play, "J_Head" );
			wait playbacktime;
		}
		if( IsPlayer( self ) && isdefined( self.last_vo_played_time ) )
		{
			if( GetTime() < ( self.last_vo_played_time + 5000 ) )
			{
				self.last_vo_played_time = GetTime();
				waittime = 7;
			}
		}
		wait waittime;
		self.isspeaking = 0;
		if( IsPlayer( self ) )
		{
			self clientfield::set_to_player( "isspeaking", 0 );
		}
		if( !level flag::get( "solo_game" ) && IS_TRUE( level.sndplayervox[category][subcategory].response ) )
		{
			if( IS_TRUE( level.vox_response_override ) )
			{
				level thread setup_response_line_override( self, category, subcategory );
			}
			else
			{
				level thread setup_response_line( self, category, subcategory );
			}
		}
	}
}

function setup_response_line_override( player, category, subcategory )
{
	player_index = ( isdefined( player.voxIndex ) ? player.voxIndex : player.characterIndex );
    char_pos = player_index % 4;

    switch( char_pos )
    {
        case 0:
        case 1:
            level setup_hero_rival( player, player_index + 1, player_index + 2, category, subcategory );
            break;

        case 2:
            level setup_hero_rival( player, player_index + 1, player_index - 2, category, subcategory );
            break;

        case 3:
            level setup_hero_rival( player, player_index - 3, player_index - 2, category, subcategory );
            break;
    }
}

function setup_hero_rival( player, hero, rival, category, type )
{
	players = GetPlayers();
	hero_player = undefined;
	rival_player = undefined;
	foreach( ent in players )
	{
		ent_index = ( isdefined( ent.voxIndex ) ? ent.voxIndex : ent.characterIndex );
		if( ent_index == hero )
		{
			hero_player = ent;
			continue;
		}
		if( ent_index == rival )
		{
			rival_player = ent;
		}
	}
	if( isdefined( hero_player ) && isdefined( rival_player ) )
	{
		if( RandomInt(100) > 50 )
		{
			hero_player = undefined;
		}
		else
		{
			rival_player = undefined;
		}
	}
	if( isdefined( hero_player ) && DistanceSquared( player.origin, hero_player.origin ) < 250000 )
	{
		hero_player create_and_play_dialog( category, type + "_hr" );
	}
	else if( isdefined( rival_player ) && DistanceSquared( player.origin, rival_player.origin ) < 250000 )
	{
		rival_player create_and_play_dialog( category, type + "_riv" );
	}
}

function setup_response_line( player, category, subcategory )
{
	players = array::get_all_closest( player.origin, level.activeplayers );
	players_that_can_respond = array::exclude( players, player );
	if( players_that_can_respond.size == 0 )
	{
		return;
	}
	player_to_respond = players_that_can_respond[0];
	if( DistanceSquared( player.origin, player_to_respond.origin ) < 250000 )
	{
		player_to_respond create_and_play_dialog( category, subcategory + "_resp_" + ( isdefined( player.voxIndex ) ? player.voxIndex : player.characterIndex ) );
	}
}

function shouldplayerspeak( player, category, subcategory, percentage )
{
	if( !isdefined( player ) )
	{
		return undefined;
	}
	if( !player zm_utility::is_player() )
	{
		return undefined;
	}
	if( player zm_utility::is_player() )
	{
		if( player.sessionstate != "playing" )
		{
			return undefined;
		}
		if( player laststand::player_is_in_laststand() && ( subcategory != "revive_down" || subcategory != "revive_up" ) )
		{
			return undefined;
		}
		if( player IsPlayerUnderwater() )
		{
			return undefined;
		}
	}
	if( IS_TRUE( player.dontspeak ) )
	{
		return undefined;
	}
	if( percentage < RandomIntRange( 1, 101 ) )
	{
		return undefined;
	}
	if( isvoxoncooldown( player, category, subcategory ) )
	{
		return undefined;
	}
	index = ( isdefined( player.voxIndex ) ? player.voxIndex : player.characterIndex );
	return "vox_plr_" + index + "_";
}

function isvoxoncooldown( player, category, subcategory )
{
	if( level.sndplayervox[category][subcategory].delaybeforeplayagain <= 0 )
	{
		return false;
	}
	fullname = category + subcategory;
	DEFAULT( player.voxtimer, [] );
	if( !isdefined( player.voxtimer[fullname] ) )
	{
		player.voxtimer[fullname] = GetTime();
		return false;
	}
	time = GetTime();
	if( ( time - player.voxtimer[fullname] ) <= ( level.sndplayervox[category][subcategory].delaybeforeplayagain * 1000 ) )
	{
		return true;
	}
	player.voxtimer[fullname] = time;
	return false;
}

function zmbvoxgetlinevariant( prefix, suffix, force_variant )
{
	if( !isdefined( self.sound_dialog ) )
	{
		self.sound_dialog = [];
		self.sound_dialog_available = [];
	}
	if( !isdefined( self.sound_dialog[suffix] ) )
	{
		num_variants = zm_spawner::get_number_variants( prefix + suffix );
		if( num_variants <= 0 )
		{
			return undefined;
		}
		for( i = 0; i < num_variants; i++ )
		{
			self.sound_dialog[suffix][i] = i;
		}
		self.sound_dialog_available[suffix] = [];
	}
	if( self.sound_dialog_available[suffix].size <= 0 )
	{
		for( i = 0; i < self.sound_dialog[suffix].size; i++ )
		{
			self.sound_dialog_available[suffix][i] = self.sound_dialog[suffix][i];
		}
	}
	variation = array::random( self.sound_dialog_available[suffix] );
	ArrayRemoveValue( self.sound_dialog_available[suffix], variation );
	if( isdefined( force_variant ) )
	{
		variation = force_variant;
	}
	return prefix + suffix + "_" + variation;
}

function arenearbyspeakersactive( radius = 1000 )
{
	nearbyspeakeractive = 0;
	speakers = GetPlayers();
	foreach( person in speakers )
	{
		if( self == person )
		{
			continue;
		}
		if( person zm_utility::is_player() )
		{
			if( person.sessionstate != "playing" )
			{
				continue;
			}
			if( person laststand::player_is_in_laststand() )
			{
				continue;
			}
		}
		if( IS_TRUE( person.isspeaking ) && !IS_TRUE( person.ignorenearbyspkrs ) )
		{
			if( DistanceSquared( self.origin, person.origin ) < SQR(radius) )
			{
				nearbyspeakeractive = 1;
			}
		}
	}
	return nearbyspeakeractive;
}

function musicstate_create( statename, playtype = 1, ... )
{
	if( !isdefined( level.musicsystem ) )
	{
		level.musicsystem = SpawnStruct();
		level.musicsystem.queue = 0;
		level.musicsystem.currentplaytype = 0;
		level.musicsystem.currentset = undefined;
		level.musicsystem.states = [];
	}
	level.musicsystem.states[statename] = SpawnStruct();
	level.musicsystem.states[statename].playtype = playtype;
	level.musicsystem.states[statename].musarray = [];
	for( i = 0; i < vararg.size; i++ )
	{
		level.musicsystem.states[statename].musarray[i] = vararg[i];
	}
}

function sndmusicsystem_createstate( state, statename, playtype = 1, delay = 0 )
{
	if( !isdefined( level.musicsystem ) )
	{
		level.musicsystem = SpawnStruct();
		level.musicsystem.ent = Spawn( "script_origin", (0, 0, 0) );
		level.musicsystem.queue = 0;
		level.musicsystem.currentplaytype = 0;
		level.musicsystem.currentstate = undefined;
		level.musicsystem.states = [];
	}
	m = level.musicsystem;
	if( !isdefined( m.states[state] ) )
	{
		m.states[state] = SpawnStruct();
		m.states[state] = array();
	}
	m.states[state][m.states[state].size].statename = statename;
	m.states[state][m.states[state].size].playtype = playtype;
}

function sndmusicsystem_playstate( state )
{
	if( !isdefined( level.musicsystem ) )
	{
		return;
	}
	m = level.musicsystem;
	if( !isdefined( m.states[state] ) )
	{
		return;
	}
	s = level.musicsystem.states[state];
	playtype = s.playtype;
	if( m.currentplaytype > 0 )
	{
		if( playtype == 1 )
		{
			return;
		}
		else
		{
			if( playtype == 2 )
			{
				level thread sndmusicsystem_queuestate( state );
			}
			else if( playtype > m.currentplaytype || ( playtype == 3 && m.currentplaytype == 3 ) )
			{
				if( IS_TRUE( level.musicsystemoverride ) && playtype != 5 )
				{
					return;
				}
				level sndmusicsystem_stopandflush();
				level thread playstate( state );
			}
		}
	}
	else if( !IS_TRUE( level.musicsystemoverride ) || playtype == 5 )
	{
		level thread playstate( state );
	}
}

function playstate( state )
{
	level endon( "sndstatestop" );

	m = level.musicsystem;
	musarray = level.musicsystem.states[state].musarray;
	if( musarray.size <= 0 )
	{
		return;
	}
	mustoplay = array::random( musarray );
	m.currentplaytype = m.states[state].playtype;
	m.currentstate = state;
	wait 0.1;
	if( IsFunctionPtr( level.sndplaystateoverride ) )
	{
		perplayer = level [[ level.sndplaystateoverride ]]( state );
		if( !IS_TRUE( perplayer ) )
		{
			music::setmusicstate( mustoplay );
		}
	}
	else
	{
		music::setmusicstate( mustoplay );
	}
	aliasname = "mus_" + mustoplay + "_intro";
	playbacktime = SoundGetPlaybackTime( aliasname );
	if( !isdefined( playbacktime ) || playbacktime <= 0 )
	{
		waittime = 1;
	}
	else
	{
		waittime = playbacktime * 0.001;
	}
	wait waittime;
	m.currentplaytype = 0;
	m.currentstate = undefined;
}

function sndmusicsystem_queuestate( state )
{
	level endon( "sndqueueflush" );
	m = level.musicsystem;
	count = 0;
	if( IS_TRUE( m.queue ) )
	{
		return;
	}
	m.queue = 1;
	while( m.currentplaytype > 0 )
	{
		wait 0.5;
		count++;
		if( count >= 25 )
		{
			m.queue = 0;
			return;
		}
	}
	level thread playstate( state );
	m.queue = 0;
}

function sndmusicsystem_stopandflush()
{
	level notify( "sndqueueflush" );
	level.musicsystem.queue = 0;
	level notify( "sndstatestop" );
	level.musicsystem.currentplaytype = 0;
	level.musicsystem.currentstate = undefined;
}

function sndmusicsystem_isabletoplay()
{
	if( !isdefined( level.musicsystem ) )
	{
		return false;
	}
	if( !isdefined( level.musicsystem.currentplaytype ) )
	{
		return false;
	}
	if( level.musicsystem.currentplaytype >= 4 )
	{
		return false;
	}
	return true;
}

function sndmusicsystem_locationsinit( locationarray )
{
	if( !isdefined( locationarray ) || locationarray.size <= 0 )
	{
		return;
	}
	level.musicsystem.locationarray = locationarray;
	level thread sndmusicsystem_locations( locationarray );
}

function sndmusicsystem_locations( locationarray )
{
	numcut = 0;
	level.sndlastzone = undefined;
	m = level.musicsystem;
	
	for(;;)
	{
		level waittill( "newzoneactive", activezone );
		wait 0.1;
		if( !sndlocationshouldplay( locationarray, activezone ) )
		{
			continue;
		}
		level thread sndmusicsystem_playstate( activezone );
		locationarray = sndcurrentlocationarray( locationarray, activezone, numcut, 3 );
		level.sndlastzone = activezone;
		if( numcut >= 3 )
		{
			numcut = 0;
		}
		else
		{
			numcut++;
		}
		level waittill( "between_round_over" );
	}
}

function sndlocationshouldplay( array, activezone )
{
	shouldplay = 0;
	if( level.musicsystem.currentplaytype >= 3 )
	{
		level thread sndlocationqueue( activezone );
		return shouldplay;
	}
	foreach( place in array )
	{
		if( place == activezone )
		{
			shouldplay = 1;
		}
	}
	if( shouldplay == 0 )
	{
		return shouldplay;
	}
	if( zm_zonemgr::any_player_in_zone( activezone ) )
	{
		shouldplay = 1;
	}
	else
	{
		shouldplay = 0;
	}
	return shouldplay;
}

function sndcurrentlocationarray( current_array, activezone, numcut, num )
{
	if( numcut >= num )
	{
		current_array = level.musicsystem.locationarray;
	}
	foreach( place in current_array )
	{
		if( place == activezone )
		{
			ArrayRemoveValue( current_array, place );
			break;
		}
	}
	return current_array;
}

function sndlocationqueue( zone )
{
	level endon( "newzoneactive" );
	while( level.musicsystem.currentplaytype >= 3 )
	{
		wait 0.5;
	}
	level notify( "newzoneactive", zone );
}

function sndmusicsystem_eesetup( state, ... )
{
	sndeearray = vararg;

	if( sndeearray.size > 0 )
	{
		level.sndeemax = sndeearray.size;
		level.sndeecount = 0;
		
		foreach( origin in sndeearray )
		{
			if( isdefined( origin ) )
			{
				level thread sndmusicsystem_eewait( origin, state );
			}
		}
	}
}

function sndmusicsystem_eewait( origin, state )
{
	temp_ent = Spawn( "script_origin", origin );
	temp_ent PlayLoopSound( "zmb_meteor_loop" );
	temp_ent thread secretuse( "main_music_egg_hit", ( 0, 255, 0 ), &sndmusicsystem_eeoverride );
	temp_ent waittill( "main_music_egg_hit", player );
	temp_ent StopLoopSound(1);
	player PlaySound( "zmb_meteor_activate" );
	level.sndeecount++;
	if( level.sndeecount >= level.sndeemax )
	{
		level notify( "hash_a1b1dadb" );
		level thread sndmusicsystem_playstate( state );
	}
	temp_ent Delete();
}

function sndmusicsystem_eeoverride( arg1, arg2 )
{
	if( isdefined( level.musicsystem.currentplaytype ) && level.musicsystem.currentplaytype >= 4 )
	{
		return false;
	}
	return true;
}

function secretuse( notify_string, color, qualifier_func, arg1, arg2 )
{
	waittillframeend;
	
	for(;;)
	{
		if( !isdefined( self ) )
		{
			return;
		}
		players = level.players;
		foreach( player in players )
		{
			qualifier_passed = 1;
			if( IsFunctionPtr( qualifier_func ) )
			{
				qualifier_passed = player [[ qualifier_func ]]( arg1, arg2 );
			}
			if( qualifier_passed && DistanceSquared( self.origin, player.origin ) < 4096 )
			{
				if( player laststand::is_facing( self ) )
				{
					if( player UseButtonPressed() )
					{
						self notify( notify_string, player );
						return;
					}
				}
			}
		}
		wait 0.1;
	}
}

function sndannouncer_init()
{
	DEFAULT( level.zmannouncerprefix, "vox_zmba_" );
	sndannouncervoxadd( "carpenter", "powerup_carpenter_0" );
	sndannouncervoxadd( "insta_kill", "powerup_instakill_0" );
	sndannouncervoxadd( "double_points", "powerup_doublepoints_0" );
	sndannouncervoxadd( "nuke", "powerup_nuke_0" );
	sndannouncervoxadd( "full_ammo", "powerup_maxammo_0" );
	sndannouncervoxadd( "fire_sale", "powerup_firesale_0" );
	sndannouncervoxadd( "minigun", "powerup_death_machine_0" );
	sndannouncervoxadd( "boxmove", "event_magicbox_0" );
	sndannouncervoxadd( "dogstart", "event_dogstart_0" );
}

function sndannouncervoxadd( type, suffix )
{
	DEFAULT( level.zmannouncervox, [] );
	level.zmannouncervox[type] = suffix;
}

function sndannouncerplayvox( type, player )
{
	if( !isdefined( level.zmannouncervox[type] ) )
	{
		return;
	}
	prefix = level.zmannouncerprefix;
	suffix = level.zmannouncervox[type];
	if( !IS_TRUE( level.zmannouncertalking ) )
	{
		if( !isdefined( player ) )
		{
			level.zmannouncertalking = 1;
			temp_ent = Spawn( "script_origin", (0, 0, 0) );
			temp_ent PlaySoundWithNotify( prefix + suffix, prefix + suffix + "wait" );
			temp_ent waittill( prefix + suffix + "wait" );
			wait 0.05;
			temp_ent Delete();
			level.zmannouncertalking = 0;
		}
		else
		{
			player PlaySoundToPlayer( prefix + suffix, player );
		}
	}
}

function zmbaivox_notifyconvert()
{
	self endon( "death" );
	self endon( "disconnect" );
	level endon( "game_ended" );

	self thread zmbaivox_playdeath();
	self thread zmbaivox_playelectrocution();

	vox_priorities = [];
	vox_priorities["death"] = 10;
	vox_priorities["pain"] = 9;
	vox_priorities["behind"] = 9;
	vox_priorities["attack_melee"] = 8;
	vox_priorities["electrocute"] = 7;
	vox_priorities["close"] = 6;

	ambient_notes = array( "ambient", "crawler", "sprint", "taunt", "teardown" );

	for(;;)
	{
		self waittill( "bhtn_action_notify", note );

		if( note == "death" && IS_TRUE( self.bgb_tone_death ) )
		{
			note = "death_whimsy";
		}

		if( note == "attack_melee_zhd" )
		{
			note = "attack_melee";
		}

		priority = vox_priorities[note];

		if( isdefined( priority ) )
		{
			if( note == "attack_melee" && ( self.animname === "zombie" || self.animname === "quad_zombie" ) )
			{
				continue;
			}

			level thread zmbaivox_playvox( self, note, 1, priority, ( note == "attack_melee" ) );
		}
		else 
		{
			if( isdefined( level._zmbaivox_specialtype ) && isdefined( level._zmbaivox_specialtype[note] ) || IsInArray( ambient_notes, note ) )
			{
				level thread zmbaivox_playvox( self, note, 0 );
			}
		}
	}
}

function zmbaivox_playvox( zombie, type, override, priority = 1, delayambientvox = 0 )
{
	zombie endon( "death" );

	if( !isdefined( zombie ) )
	{
		return;
	}
	if( !isdefined( zombie.voiceprefix ) )
	{
		return;
	}
	DEFAULT( zombie.currentvoxpriority, 1 );
	DEFAULT( self.delayambientvox, 0 );
	if( IsInArray( array( "ambient", "sprint", "crawler" ), type ) && IS_TRUE( self.delayambientvox ) )
	{
		return;
	}
	if( delayambientvox )
	{
		self.delayambientvox = 1;
		self thread zmbaivox_ambientdelay();
	}
	alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;
	if( sndisnetworksafe() )
	{
		if( IS_TRUE( override ) )
		{
			if( isdefined( zombie.currentvox ) && priority > zombie.currentvoxpriority )
			{
				zombie StopSound( zombie.currentvox );
			}
			if( type == "death" || type == "death_whimsy" )
			{
				zombie PlaySound( alias );
				return;
			}
		}
		if( zombie.talking === 1 && priority < zombie.currentvoxpriority )
		{
			return;
		}
		zombie.talking = 1;
		if( zombie is_last_zombie() && type == "ambient" )
		{
			alias = alias + "_loud";
		}
		zombie.currentvox = alias;
		zombie.currentvoxpriority = priority;
		zombie PlaySoundOnTag( alias, "j_head" );
		playbacktime = SoundGetPlaybackTime( alias );
		if( !isdefined( playbacktime ) )
		{
			playbacktime = 1;
		}
		if( playbacktime >= 0 )
		{
			playbacktime = playbacktime * 0.001;
		}
		else
		{
			playbacktime = 1;
		}
		wait playbacktime;
		zombie.talking = 0;
		zombie.currentvox = undefined;
		zombie.currentvoxpriority = 1;
	}
}

function zmbaivox_playdeath()
{
	self endon( "disconnect" );

	self waittill( "death", attacker, meansofdeath );
	if( isdefined( self ) )
	{
		if( IS_TRUE( self.bgb_tone_death ) )
		{
			level thread zmbaivox_playvox( self, "death_whimsy", 1 );
		}
		else
		{
			level thread zmbaivox_playvox( self, "death", 1 );
		}
	}
}

function zmbaivox_playelectrocution()
{
	self endon( "disconnect" );
	self endon( "death" );
	
	for(;;)
	{
		self waittill( "damage", amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon );
		if( IsInArray( array( "zombie_beast_lightning_dwl", "zombie_beast_lightning_dwl2", "zombie_beast_lightning_dwl3" ), weapon.name ) )
		{
			self notify( "bhtn_action_notify", "electrocute" );
		}
	}
}

function zmbaivox_ambientdelay()
{
	self notify( "sndambientdelay" );
	self endon( "sndambientdelay" );
	self endon( "death" );
	self endon( "disconnect" );
	wait 2;
	self.delayambientvox = 0;
}

function networksafereset()
{
	for(;;)
	{
		level._numzmbaivox = 0;
		util::wait_network_frame();
	}
}

function sndisnetworksafe()
{
	if( !isdefined( level._numzmbaivox ) )
	{
		level thread networksafereset();
	}
	if( level._numzmbaivox >= 2 )
	{
		return false;
	}
	level._numzmbaivox++;
	return true;
}

function is_last_zombie()
{
	return zombie_utility::get_current_zombie_count() <= 1;
}

function sndradiosetup( alias_prefix, is_sequential = 0, ... )
{
	radio = SpawnStruct();
	radio.counter = 1;
	radio.alias_prefix = alias_prefix;
	radio.isplaying = 0;
	radio.array = vararg;
	radio.array = array::remove_undefined( radio.array );

	if( radio.array.size > 0 )
	{
		for( i = 0; i < radio.array.size; i++ )
		{
			level thread sndradiowait( radio.array[i], radio, is_sequential, i + 1 );
		}
	}
}

function sndradiowait( origin, radio, is_sequential, num )
{
	temp_ent = Spawn( "script_origin", origin );
	temp_ent thread secretuse( "sndRadioHit", ( 0, 0, 255 ), &sndradio_override, radio );
	temp_ent waittill( "sndradiohit", player );
	if( !IS_TRUE( is_sequential ) )
	{
		radionum = num;
	}
	else
	{
		radionum = radio.counter;
	}
	radioalias = radio.alias_prefix + radionum;
	radiolinecount = zm_spawner::get_number_variants( radioalias );
	if( radiolinecount > 0 )
	{
		radio.isplaying = 1;
		for( i = 0; i < radiolinecount; i++ )
		{
			temp_ent PlaySound( radioalias + "_" + i );
			playbacktime = SoundGetPlaybackTime( radioalias + "_" + i );
			if( !isdefined( playbacktime ) )
			{
				playbacktime = 1;
			}
			if( playbacktime >= 0 )
			{
				playbacktime = playbacktime * 0.001;
			}
			else
			{
				playbacktime = 1;
			}
			wait playbacktime;
		}
	}
	radio.counter++;
	radio.isplaying = 0;
	temp_ent Delete();
}

function sndradio_override( arg1, arg2 )
{
	if( isdefined( arg1 ) && arg1.isplaying == 1 )
	{
		return false;
	}
	return true;
}

function sndperksjingles_timer()
{
	self endon( "death" );
	if( isdefined( self.sndjinglecooldown ) )
	{
		self.sndjinglecooldown = 0;
	}
	
	for(;;)
	{
		wait RandomFloatRange( 30, 60 );
		if( RandomIntRange( 0, 100 ) <= 10 && !IS_TRUE( self.sndjinglecooldown ) )
		{
			self thread sndperksjingles_player(0);
		}
	}
}

function sndperksjingles_player( type )
{
	self endon( "death" );
	if( !isdefined( self.sndjingleactive ) )
	{
		self.sndjingleactive = 0;
	}
	alias = self.script_sound;
	if( type == 1 )
	{
		alias = self.script_label;
	}
	if( isdefined( level.musicsystem ) && level.musicsystem.currentplaytype >= 4 )
	{
		return;
	}
	self.str_jingle_alias = alias;
	if( !IS_TRUE( self.sndjingleactive ) )
	{
		self.sndjingleactive = 1;
		self PlaySoundWithNotify( alias, "sndDone" );
		playbacktime = SoundGetPlaybackTime( alias );
		if( !isdefined( playbacktime ) || playbacktime <= 0 )
		{
			waittime = 1;
		}
		else
		{
			waittime = playbacktime * 0.001;
		}
		wait waittime;
		if( type == 0 )
		{
			self.sndjinglecooldown = 1;
			self thread sndperksjingles_cooldown();
		}
		self.sndjingleactive = 0;
	}
}

function sndperksjingles_cooldown()
{
	self endon( "death" );
	if( isdefined( self.var_1afc1154 ) )
	{
		while( IS_TRUE( self.var_1afc1154 ) )
		{
			wait 1;
		}
	}
	wait 45;
	self.sndjinglecooldown = 0;
}

function sndconversation_init( name, specialendon = undefined )
{
	DEFAULT( level.sndconversations, [] );
	level.sndconversations[name] = SpawnStruct();
	level.sndconversations[name].specialendon = specialendon;
}

function sndconversation_addline( name, line, player_or_random, ignoreplayer = 5 )
{
	thisconvo = level.sndconversations[name];

	if( !isdefined( thisconvo.line ) )
	{
		thisconvo.line = [];
		thisconvo.player = [];
		thisconvo.ignoreplayer = [];
	}

	thisconvo.line[thisconvo.line.size] = line;
	thisconvo.player[thisconvo.player.size] = player_or_random;
	thisconvo.ignoreplayer[thisconvo.ignoreplayer.size] = ignoreplayer;
}

function sndconversation_play( name )
{
	level endon( "sndconvointerrupt" );

	thisconvo = level.sndconversations[name];	
	if( isdefined( thisconvo.specialendon ) )
	{
		level endon( thisconvo.specialendon );
	}

	while( isanyonetalking() )
	{
		wait 0.5;
	}
	while( IS_TRUE( level.sndvoxoverride ) )
	{
		wait 0.5;
	}
	level.sndvoxoverride = 1;
	for( i = 0; i < thisconvo.line.size; i++ )
	{
		if( thisconvo.player[i] == 4 )
		{
			speaker = getrandomcharacter( thisconvo.ignoreplayer[i] );
		}
		else
		{
			speaker = getspecificcharacter( thisconvo.player[i] );
		}
		if( !isdefined( speaker ) )
		{
			continue;
		}
		if( iscurrentspeakerabletotalk( speaker ) )
		{
			level.currentconvoplayer = speaker;
			if( isdefined( level.vox_name_complete ) )
			{
				level.currentconvoline = thisconvo.line[i];
			}
			else
			{
				player_index = ( isdefined( speaker.voxIndex ) ? speaker.voxIndex : speaker.characterIndex );
				level.currentconvoline = "vox_plr_" + player_index + "_" + thisconvo.line[i];
				speaker thread sndconvointerrupt();
			}
			speaker PlaySoundOnTag( level.currentconvoline, "J_Head" );
			waitplaybacktime( level.currentconvoline );
			level notify( "sndconvolinedone" );
		}
	}
	level.sndvoxoverride = 0;
	level notify( "sndconversationdone" );
	level.currentconvoline = undefined;
	level.currentconvoplayer = undefined;
}

function sndconvostopcurrentconversation()
{
	level notify( "sndconvointerrupt" );
	level notify( "sndconversationdone" );
	level.sndvoxoverride = 0;
	if( isdefined( level.currentconvoplayer ) && isdefined( level.currentconvoline ) )
	{
		level.currentconvoplayer StopSound( level.currentconvoline );
		level.currentconvoline = undefined;
		level.currentconvoplayer = undefined;
	}
}

function waitplaybacktime( alias )
{
	playbacktime = SoundGetPlaybackTime( alias );
	if( !isdefined( playbacktime ) )
	{
		playbacktime = 1;
	}
	if( playbacktime >= 0 )
	{
		playbacktime = playbacktime * 0.001;
	}
	else
	{
		playbacktime = 1;
	}
	wait playbacktime;
}

function iscurrentspeakerabletotalk( player )
{
	if( !isdefined( player ) )
	{
		return false;
	}
	if( player.sessionstate != "playing" )
	{
		return false;
	}
	if( IS_TRUE( player.laststand ) )
	{
		return false;
	}
	return true;
}

function getrandomcharacter( ignore )
{
	array = level.players;
	array::randomize( array );
	foreach( guy in array )
	{
		if( ( guy.characterIndex % 4 ) == ignore )
		{
			continue;
		}
		return guy;
	}
	return undefined;
}

function getspecificcharacter( charindex )
{
	foreach( guy in level.players )
	{
		if( ( guy.characterIndex % 4 ) == charindex )
		{
			return guy;
		}
	}
	return undefined;
}

function isanyonetalking()
{
	foreach( player in level.players )
	{
		if( IS_TRUE( player.isspeaking ) )
		{
			return true;
		}
	}
	return false;
}

function sndconvointerrupt()
{
	level endon( "sndconvolinedone" );
	
	for(;;)
	{
		if( !isdefined( self ) )
		{
			return;
		}
		max_dist_squared = 0;
		check_pos = self.origin;
		count = 0;
		foreach( player in level.players )
		{
			if( self == player )
			{
				continue;
			}
			if( Distance2DSquared( player.origin, self.origin ) >= 810000 )
			{
				count++;
			}
		}
		if( count == ( level.players.size - 1 ) )
		{
			break;
		}
		wait 0.25;
	}
	level thread sndconvostopcurrentconversation();
}

function water_vox()
{
	self endon( "death" );
	self endon( "disconnect" );
	level endon( "end_game" );

	self.voxunderwatertime = 0;
	self.voxemergebreath = 0;
	self.voxdrowning = 0;
	
	for(;;)
	{
		if( self IsPlayerUnderwater() )
		{
			if( !self.voxunderwatertime && !self.voxemergebreath )
			{
				self vo_clear_underwater();
				self.voxunderwatertime = GetTime();
			}
			else if( self.voxunderwatertime )
			{
				if( GetTime() > ( self.voxunderwatertime + 3000 ) )
				{
					self.voxunderwatertime = 0;
					self.voxemergebreath = 1;
				}
			}
		}
		else
		{
			if( self.voxdrowning )
			{
				self playerexert( "underwater_gasp" );
				self.voxdrowning = 0;
				self.voxemergebreath = 0;
			}
			if( self.voxemergebreath )
			{
				self playerexert( "underwater_emerge" );
				self.voxemergebreath = 0;
			}
			else
			{
				self.voxunderwatertime = 0;
			}
		}
		wait 0.05;
	}
}

function vo_clear_underwater()
{
	if( level flag::exists( "abcd_speaking" ) )
	{
		if( level flag::get( "abcd_speaking" ) )
		{
			return;
		}
	}
	if( level flag::exists( "shadowman_speaking" ) )
	{
		if( level flag::get( "shadowman_speaking" ) )
		{
			return;
		}
	}
	self StopSounds();
	self notify( "stop_vo_convo" );
	self.str_vo_being_spoken = "";
	self.n_vo_priority = 0;
	self.isspeaking = 0;
	level.sndvoxoverride = 0;
	b_in_a_e_speakers = 0;
	foreach( e_checkme in level.a_e_speakers )
	{
		if( e_checkme == self )
		{
			b_in_a_e_speakers = 1;
			break;
		}
	}
	if( IS_TRUE( b_in_a_e_speakers ) )
	{
		ArrayRemoveValue( level.a_e_speakers, self );
	}
}

function sndplayerhitalert( e_victim, str_meansofdeath, e_inflictor, weapon )
{
	if( !IS_TRUE( level.sndzhdaudio ) )
	{
		return;
	}
	if( !IsPlayer( self ) )
	{
		return;
	}
	if( !checkforvalidmod( str_meansofdeath ) )
	{
		return;
	}
	if( !checkforvalidweapon( weapon ) )
	{
		return;
	}
	if( !checkforvalidaitype( e_victim ) )
	{
		return;
	}
	str_alias = "zmb_hit_alert";
	self thread sndplayerhitalert_playsound( str_alias );
}

function sndplayerhitalert_playsound( str_alias )
{
	self endon( "disconnect" );

	if( self.hitsoundtracker )
	{
		self.hitsoundtracker = 0;
		self PlaySoundToPlayer( str_alias, self );
		wait 0.05;
		self.hitsoundtracker = 1;
	}
}

function checkforvalidmod( str_meansofdeath )
{
	if( !isdefined( str_meansofdeath ) )
	{
		return false;
	}
	return !IsInArray( array( "MOD_CRUSH", "MOD_GRENADE_SPLASH", "MOD_HIT_BY_OBJECT", "MOD_MELEE", "MOD_MELEE_ASSASSINATE", "MOD_MELEE_WEAPON_BUTT" ), str_meansofdeath );
}

function checkforvalidweapon( weapon )
{
	return true;
}

function checkforvalidaitype( e_victim )
{
	return true;
}

function setup_personality_character_exerts()
{
	for( exert = 1; exert <= 44; exert++ )
	{
		if( exert >= 5 && exert <= 16 )
		{
			continue;
		}
		init_player_sounds( exert, 5, "hitmed", "exert_pain" );
		init_player_sounds( exert, 5, "hitlrg", "exert_pain" );
		init_player_sounds( exert, 7, "burp", "exert_burp" );
		init_player_sounds( exert, 4, "drowning", "exert_underwater_air_low" );
		init_player_sounds( exert, 4, "cough", "exert_cough" );
		init_player_sounds( exert, 2, "underwater_emerge", "exert_underwater_emerge" );
		init_player_sounds( exert, 2, "underwater_gasp", "exert_underwater_gasp" );
	}
}

function init_player_sounds( exert, n_sounds, category, alias )
{
    character = exert - 1;
    DEFAULT( level.exert_sounds, [] );
    DEFAULT( level.exert_sounds[exert], [] );
    level.exert_sounds[exert][category] = [];
    for( sound = 0; sound < n_sounds; sound++ )
    {
        //level.exert_sounds[exert][category][sound] = "vox_plr_" + character + alias + sound;
        level.exert_sounds[exert][category][sound] = sprintf( "vox_plr_{0}_{1}_{2}", character, alias, sound );
    }
}