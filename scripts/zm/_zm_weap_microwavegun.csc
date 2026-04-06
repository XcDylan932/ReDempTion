#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace zm_weap_microwavegun;

REGISTER_SYSTEM( "zm_weap_microwavegun", &__init__, undefined )

function __init__()
{
	clientfield::register( "actor", "toggle_microwavegun_hit_response", VERSION_DLC5, 1, "int", &microwavegun_zombie_initial_hit_response, 0, 0 );
	clientfield::register( "actor", "toggle_microwavegun_expand_response", VERSION_DLC5, 1, "int", &microwavegun_zombie_expand_response, 0, 0 );
	clientfield::register( "clientuimodel", "hudItems.showDpadLeft_WaveGun", VERSION_DLC5, 1, "int", undefined, 0, 0 );
	clientfield::register( "clientuimodel", "hudItems.dpadLeftAmmo", VERSION_DLC5, 5, "int", undefined, 0, 0 );
	clientfield::register( "scriptmover", "wavegun_trail", VERSION_DLC5, 1, "int", &wavegun_trail_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "scriptmover", "zapgun_trail", VERSION_DLC5, 1, "int", &zapgun_trail_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "toplayer", "wavegun_fired", VERSION_DLC5, 1, "counter", &wavegun_fired, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "toplayer", "zapgundw_fired", VERSION_DLC5, 1, "counter", &zapgundw_fired, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "toplayer", "zapgunlh_fired", VERSION_DLC5, 1, "counter", &zapgunlh_fired, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );

	level._effect["microwavegun_sizzle_blood_eyes"] = "dlc5/zmb_weapon/fx_sizzle_blood_eyes";
	level._effect["microwavegun_sizzle_death_mist"] = "dlc5/zmb_weapon/fx_sizzle_mist";
	level._effect["microwavegun_sizzle_death_mist_low_g"] = "dlc5/zmb_weapon/fx_sizzle_mist_low_g";
}

function microwavegun_create_hit_response_fx( localclientnum, tag, effect )
{
	if( !isdefined( self._microwavegun_hit_response_fx[localclientnum][tag] ) )
	{
		self._microwavegun_hit_response_fx[localclientnum][tag] = PlayFXOnTag( localclientnum, effect, self, tag );
	}
}

function microwavegun_delete_hit_response_fx( localclientnum, tag )
{
	if( isdefined( self._microwavegun_hit_response_fx[localclientnum][tag] ) )
	{
		DeleteFX( localclientnum, self._microwavegun_hit_response_fx[localclientnum][tag], 0 );
		self._microwavegun_hit_response_fx[localclientnum][tag] = undefined;
	}
}

function microwavegun_bloat( localclientnum )
{
	self endon( "entityshutdown" );
	durationmsec = 2500;
	tag_pos = self GetTagOrigin( "J_SpineLower" );
	bloat_max_fraction = 1;
	if( !isdefined( tag_pos ) )
	{
		durationmsec = 1000;
	}
	self MapShaderConstant( localclientnum, 0, "scriptVector6", 0, 0, 0, 0 );
	begin_time = GetRealTime();
	for(;;)
	{
		age = GetRealTime() - begin_time;
		bloat_fraction = age / durationmsec;
		if( bloat_fraction > bloat_max_fraction )
		{
			bloat_fraction = bloat_max_fraction;
		}
		if( !isdefined( self ) )
		{
			return;
		}
		self MapShaderConstant( localclientnum, 0, "scriptVector6", 4 * bloat_fraction, 0, 0, 0 );
		if( bloat_fraction >= bloat_max_fraction )
		{
			break;
		}
		waitrealtime( 0.05 );
	}
}

function microwavegun_zombie_initial_hit_response( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
	if( IsFunctionPtr( self.microwavegun_zombie_hit_response ) )
	{
		self [[ self.microwavegun_zombie_hit_response ]]( localclientnum, newval, bnewent );
		return;
	}
	if( localclientnum != 0 )
	{
		return;
	}
	DEFAULT( self._microwavegun_hit_response_fx, [] );
	self.microwavegun_initial_hit_response = 1;
	players = GetLocalPlayers();
	for( i = 0; i < players.size; i++ )
	{
		DEFAULT( self._microwavegun_hit_response_fx[i], [] );
		if( newval )
		{
			fx = players[i] get_fx_path( "microwavegun_sizzle_blood_eyes" );
			self microwavegun_create_hit_response_fx( i, "J_Eyeball_LE", fx );
			PlaySound( 0, "wpn_mgun_impact_zombie", self.origin );
		}
	}
}

function microwavegun_zombie_expand_response( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
	if( IsFunctionPtr( self.microwavegun_zombie_hit_response ) )
	{
		self [[ self.microwavegun_zombie_hit_response ]]( localclientnum, newval, bnewent );
		return;
	}
	if( localclientnum != 0 )
	{
		return;
	}
	DEFAULT( self._microwavegun_hit_response_fx, [] );
	initial_hit_occurred = IS_TRUE( self.microwavegun_initial_hit_response );
	players = GetLocalPlayers();
	for( i = 0; i < players.size; i++ )
	{
		DEFAULT( self._microwavegun_hit_response_fx[i], [] );
		if( newval && initial_hit_occurred )
		{
			PlaySound( 0, "wpn_mgun_impact_zombie", self.origin );
			self thread microwavegun_bloat(i);
			continue;
		}
		self thread microwavegun_bloat(i);
		if( initial_hit_occurred )
		{
			self microwavegun_delete_hit_response_fx( i, "J_Eyeball_LE" );
		}
		tag_pos = self GetTagOrigin( "J_SpineLower" );
		tag_angles = self GetTagAngles( "J_SpineLower" );
		if( !isdefined( tag_pos ) )
		{
			tag_pos = self GetTagOrigin( "J_Spine1" );
			tag_angles = self GetTagAngles( "J_Spine1" );
		}
		fx = ( IS_TRUE( self.in_low_g ) ? players[i] get_fx_path( "microwavegun_sizzle_death_mist_low_g" ) : players[i] get_fx_path( "microwavegun_sizzle_death_mist" ) );
		if( isdefined( tag_pos ) )
		{
			PlayFX( i, fx, tag_pos, AnglesToForward( tag_angles ), AnglesToUp( tag_angles ) );
		}
		PlaySound( 0, "wpn_mgun_explode_zombie", self.origin );
	}
}

function wavegun_trail_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	self endon( "entityshutdown" );

	if( isdefined( self.wavegun_trail_fx ) )
	{
		DeleteFX( localclientnum, self.wavegun_trail_fx, 1 );
		self.wavegun_trail_fx = undefined;
	}

	if( newval )
	{
		fx = GetLocalPlayer( localclientnum ) get_fx_path( "wavegun_trail" );
		self.wavegun_trail_fx = PlayFXOnTag( localclientnum, fx, self, "tag_origin" );
	}
}

function zapgun_trail_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	self endon( "entityshutdown" );
	
	if( isdefined( self.zapgun_trail_fx ) )
	{
		DeleteFX( localclientnum, self.zapgun_trail_fx, 1 );
		self.zapgun_trail_fx = undefined;
	}

	if( newval )
	{
		fx = GetLocalPlayer( localclientnum ) get_fx_path( "zapgun_trail" );
		self.zapgun_trail_fx = PlayFXOnTag( localclientnum, fx, self, "tag_origin" );
	}
}

function wavegun_fired( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if( isdefined( self.wavegun_flash_fx ) )
	{
		StopFX( localclientnum, self.wavegun_flash_fx );
		self.wavegun_flash_fx = undefined;
	}

	if( newval )
	{
		fx = self get_fx_path( "wavegun_flash" );
		self.wavegun_flash_fx = PlayViewmodelFX( localclientnum, fx, "tag_flash" );
	}
}

function zapgundw_fired( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if( isdefined( self.zapgundw_flash_fx ) )
	{
		StopFX( localclientnum, self.zapgundw_flash_fx );
		self.zapgundw_flash_fx = undefined;
	}

	if( newval )
	{
		fx = self get_fx_path( "zapgundw_flash" );
		self.zapgundw_flash_fx = PlayViewmodelFX( localclientnum, fx, "tag_flash" );
	}
}

function zapgunlh_fired( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if( isdefined( self.zapgunlh_flash_fx ) )
	{
		StopFX( localclientnum, self.zapgunlh_flash_fx );
		self.zapgunlh_flash_fx = undefined;
	}

	if( newval )
	{
		fx = self get_fx_path( "zapgunlh_flash" );
		self.zapgunlh_flash_fx = PlayViewmodelFX( localclientnum, fx, "tag_flash_le" );
	}
}

function get_fx_path( key )
{
	return( isdefined( self._effect[key] ) ? self._effect[key] : level._effect[key] );
}