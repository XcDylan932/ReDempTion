#using scripts\codescripts\struct;

#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace zombie_vortex;

REGISTER_SYSTEM( "vortex", &__init__, undefined )

function __init__()
{
	visionset_mgr::register_visionset_info( "zm_idgun_vortex" + "_visionset", 1, 30, undefined, "zm_idgun_vortex" );
	visionset_mgr::register_overlay_info_style_speed_blur( "zm_idgun_vortex" + "_blur", 1, 1, 0.08, 0.75, 0.9 );
	clientfield::register( "scriptmover", "vortex_start", VERSION_SHIP, 2, "counter", &start_vortex, 0, 0 );
	clientfield::register( "allplayers", "vision_blur", VERSION_SHIP, 1, "int", &vision_blur, 0, 0 );
}

function start_vortex( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	self endon( "entityshutdown" );
	self endon( "disconnect" );

	if( !isdefined( newval ) || newval == 0 )
	{
		return;
	}

	e_player = GetLocalPlayer( localclientnum );
	vortex_org = self.origin;
	newval = newval - oldval;
	n_vortex_time = ( newval == 2 ? 10 : 5 );
	str_fx_vortex = e_player get_fx_path( "vortex" );
	if( isdefined( str_fx_vortex ) )
	{
		vortex_fx_handle = PlayFX( localclientnum, str_fx_vortex, vortex_org );
	}
	SetFXIgnorePause( localclientnum, vortex_fx_handle, 1 );
	PlaySound( 0, "wpn_idgun_portal_start", vortex_org );
	audio::playloopat( "wpn_idgun_portal_loop", vortex_org );
	self thread vortex_shake_and_rumble( localclientnum, vortex_org );
	str_fx_explo = e_player get_fx_path( "vortex_explo" );
	self thread explode_vortex( localclientnum, vortex_fx_handle, vortex_org, str_fx_explo, n_vortex_time );
}

function vortex_shake_and_rumble( localclientnum, v_vortex_origin )
{
	self endon( "vortex_stop" );

	for(;;)
	{
		self PlayRumbleOnEntity( localclientnum, "zod_idgun_vortex_interior" );
		wait 0.075;
	}
}

function vision_blur( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if( newval )
	{
		EnableSpeedBlur( localclientnum, 0.1, 0.5, 0.75 );
	}

	else
	{
		DisableSpeedBlur( localclientnum );
	}
}

function explode_vortex( localclientnum, vortex_fx_handle, vortex_org, str_fx_explo, n_vortex_time )
{
	e_player = GetLocalPlayer( localclientnum );
	n_starttime = e_player GetClientTime();
	n_currtime = e_player GetClientTime() - n_starttime;
	n_vortex_time = n_vortex_time * 1000;
	while( isdefined( e_player ) && n_currtime < n_vortex_time )
	{
		wait 0.05;
		if( isdefined( e_player ) )
		{
			n_currtime = e_player GetClientTime() - n_starttime;
		}
	}
	StopFX( localclientnum, vortex_fx_handle );
	audio::stoploopat( "wpn_idgun_portal_loop", vortex_org );
	PlaySound( 0, "wpn_idgun_portal_stop", vortex_org );
	wait 0.15;
	self notify( "vortex_stop" );
	if( isdefined( str_fx_explo ) )
	{
		vortex_explo = PlayFX( localclientnum, str_fx_explo, vortex_org );
	}
	SetFXIgnorePause( localclientnum, vortex_explo, 1 );
	PlaySound( 0, "wpn_idgun_portal_explode", vortex_org );
	wait 0.05;
	if( isdefined( self ) )
	{
		self PlayRumbleOnEntity( localclientnum, "zod_idgun_vortex_shockwave" );
	}
	vision_blur( localclientnum, undefined, 1 );
	wait 0.1;
	vision_blur( localclientnum, undefined, 0 );
}

function get_fx_path( key )
{
	return( isdefined( self._effect ) && isdefined( self._effect[key] ) ? self._effect[key] : ( isdefined( level._effect ) && isdefined( level._effect[key] ) ? level._effect[key] : undefined ) );
}