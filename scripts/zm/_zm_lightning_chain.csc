#using scripts\codescripts\struct;

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\shared\archetype_shared\archetype_shared.gsh;

#using scripts\zm\_zm_weapons;

#namespace lightning_chain;

REGISTER_SYSTEM( "lightning_chain", &__init__, undefined )

#define FX_LC_BOLT 				"zombie/fx_tesla_bolt_secondary_zmb"
#define FX_LC_SHOCK 			"zombie/fx_tesla_shock_zmb"
#define FX_LC_SHOCK_SECONDARY 	"zombie/fx_tesla_bolt_secondary_zmb"
#define FX_LC_SHOCK_EYES	 	"zombie/fx_tesla_shock_eyes_zmb"
#define FX_LC_SHOCK_NONFATAL	"zombie/fx_bmode_shock_os_zod_zmb"
	

#precache( "client_fx", FX_LC_BOLT 			);
#precache( "client_fx", FX_LC_SHOCK 			);
#precache( "client_fx", FX_LC_SHOCK_SECONDARY 	);
#precache( "client_fx", FX_LC_SHOCK_EYES	 	);
#precache( "client_fx", FX_LC_SHOCK_NONFATAL	 	);


function __init__()
{
	level._effect["tesla_bolt"]				= FX_LC_BOLT;
	level._effect["tesla_shock"]			= FX_LC_SHOCK;
	level._effect["tesla_shock_secondary"]	= FX_LC_SHOCK_SECONDARY;
	level._effect["tesla_shock_nonfatal"]	= FX_LC_SHOCK_NONFATAL;
	level._effect["tesla_shock_eyes"]		= FX_LC_SHOCK_EYES;
	
	clientfield::register( "actor", "lc_fx", VERSION_SHIP, 2, "int", &lc_shock_fx, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "vehicle", "lc_fx", VERSION_SHIP, 2, "int", &lc_shock_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	
	clientfield::register( "actor", "lc_death_fx", VERSION_SHIP, 2, "int", &lc_play_death_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );	
	clientfield::register( "vehicle", "lc_death_fx", VERSION_TU8, 2, "int", &lc_play_death_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
}

function lc_shock_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	self endon( "entityshutdown" );
	self util::waittill_dobj( localclientnum );
	
	if( newval )
	{
		if( !isdefined( self.lc_shock_fx ) )
		{
			str_tag = ( !self IsAI() ? "tag_origin" : "J_SpineUpper" );
			str_fx = ( newval > 1 ? "tesla_shock_secondary" : "tesla_shock" );
			fx_path = GetLocalPlayer( localclientnum ) get_fx_path( str_fx );

			self.lc_shock_fx = PlayFXOnTag( localclientnum, fx_path, self, str_tag );
			self PlaySound( 0, "zmb_electrocute_zombie" );
		}
	}
	else
	{
		if( isdefined( self.lc_shock_fx ) )
		{
			StopFX( localclientnum, self.lc_shock_fx );
			self.lc_shock_fx = undefined;
		}
	}
}

function lc_play_death_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	self endon( "entityshutdown" );
	self util::waittill_dobj( localclientnum );
		
	fx_path = GetLocalPlayer( localclientnum ) get_fx_path( ( newval == 2 ? "tesla_shock_secondary" : ( newval == 3 ? "tesla_shock_nonfatal" : "tesla_shock" ) ) );
	PlayFXOnTag( localclientnum, fx_path, self, ( IS_TRUE( self.isdog ) ? "J_Spine1" : ( self.archetype !== "zombie" ? "tag_origin" : "J_SpineUpper" ) ) );
}

function get_fx_path( key )
{
    return( isdefined( self._effect ) && isdefined( self._effect[key] ) ? self._effect[key] : ( isdefined( level._effect ) && isdefined( level._effect[key] ) ? level._effect[key] : undefined ) );
}