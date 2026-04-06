#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;

#using scripts\zm\_xcdylan93\_zm_startmenu;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

REGISTER_SYSTEM_EX( "mod_fx", &__init__, &__main__, undefined )

function __init__()
{
	init_fx();

	clientfield::register( "toplayer", "dw_fired", VERSION_SHIP, 1, "counter" );
    clientfield::register( "toplayer", "lh_fired", VERSION_SHIP, 1, "counter" );

    callback::on_connect( &weapon_fired );
}

function __main__()
{
	set_default_colors();
}

function init_fx()
{
	foreach( category in array( "tesla", "wavegun", "powerup" ) )
	{
		foreach( color in array( "red", "orange", "yellow", "green", "blue", "purple", "pink", "white" ) )
		{
			switch( category )
			{
				case "tesla":
					register_effect_info( "tesla", array(
						array( "tesla_bolt", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_bolt_secondary_zmb", color ) ),
						array( "tesla_impact", sprintf( "_xcdylan93/{0}/waffe/fx_dg2_impact", color ) ),
						array( "tesla_shock", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_zmb", color ) ),
						array( "tesla_shock_secondary", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_bolt_secondary_zmb", color ) ),
						array( "tesla_shock_nonfatal", sprintf( "_xcdylan93/{0}/waffe/fx_bmode_shock_os_zod_zmb", color ) ),
						array( "tesla_shock_eyes", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_eyes_zmb", color ) ),
						array( "tesla_trail", sprintf( "_xcdylan93/{0}/waffe/fx_dg2_trail", color ) ) ) );
					break;

				case "wavegun":
					register_effect_info( "wavegun", array(
						array( "microwavegun_zap_shock_dw", sprintf( "_xcdylan93/{0}/wavegun/fx_zap_shock", color ) ),
						array( "microwavegun_zap_shock_lh", sprintf( "_xcdylan93/{0}/wavegun/fx_zap_shock", color ) ),
						array( "microwavegun_zap_shock_ug", sprintf( "_xcdylan93/{0}/wavegun/fx_zap_shock", color ) ),
						array( "microwavegun_zap_shock_eyes_dw", sprintf( "_xcdylan93/{0}/wavegun/fx_zap_shock_eyes", color ) ),
						array( "microwavegun_zap_shock_eyes_lh", sprintf( "_xcdylan93/{0}/wavegun/fx_zap_shock_eyes", color ) ),
						array( "microwavegun_zap_shock_eyes_ug", sprintf( "_xcdylan93/{0}/wavegun/fx_zap_shock_eyes", color ) ),
						array( "wavegun_impact", sprintf( "_xcdylan93/{0}/wavegun/fx_microwavegun_impact", color ) ) ) );
					break;

				case "powerup":
					register_effect_info( "powerup", array(
						array( "powerup_grabbed", sprintf( "_xcdylan93/{0}/powerups/fx_powerup_grab_green_zmb", color ) ),
						array( "powerup_grabbed_solo", sprintf( "_xcdylan93/{0}/powerups/fx_powerup_grab_green_zmb", color ) ) ) );
					break;
			}
		}
	}
}

function register_effect_info( category, fx_info )
{
    DEFAULT( level._effect, [] );
    DEFAULT( level._effect[category], [] );

    if( IsArray( fx_info[0] ) )
    {
        foreach( fx in fx_info )
        {
            DEFAULT( level._effect[category][fx[0]], [] );
            level._effect[category][fx[0]][level._effect[category][fx[0]].size] = fx[1];
        }
    }
    else
    {
        DEFAULT( level._effect[category][fx_info[0]], [] );
        level._effect[category][fx_info[0]][level._effect[category][fx_info[0]].size] = fx_info[1];
    }
}

function set_default_colors()
{
    foreach( category in array( "powerup", "tesla", "wavegun" ) )
    {
        if( isdefined( world._effect ) && isdefined( world._effect[category] ) )
        {
        	level zm_startmenu::set_effect( category, world._effect[category] );
        }
        else
        {
        	level zm_startmenu::set_effect( category, level.fx_color );
        }
    }
}

function weapon_fired()
{
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( "weapon_fired", weapon );
		if( !weapon.isdualwield )
		{
			continue;
		}

		name = weapon.rootweapon.name;
		if( StrStartsWith( name, "microwavegun" ) )
		{
			continue;
		}		

		if( IsSubStr( name, "lh" ) || IsSubStr( name, "ldw" ) )
		{
			self clientfield::increment_to_player( "lh_fired" );
		}

		else
		{
			self clientfield::increment_to_player( "dw_fired" );
		}
	}
}

/* ---------------- BLUE ---------------- */
#precache( "fx", "_xcdylan93/blue/powerups/fx_powerup_grab_green_zmb" );
#precache( "fx", "_xcdylan93/blue/waffe/fx_dg2_impact" );
#precache( "fx", "_xcdylan93/blue/waffe/fx_dg2_trail" );
#precache( "fx", "_xcdylan93/blue/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "fx", "_xcdylan93/blue/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "fx", "_xcdylan93/blue/wavegun/fx_microwavegun_impact" );
#precache( "fx", "_xcdylan93/blue/wavegun/fx_zap_shock" );
#precache( "fx", "_xcdylan93/blue/wavegun/fx_zap_shock_eyes" );

/* ---------------- GREEN ---------------- */
#precache( "fx", "_xcdylan93/green/powerups/fx_powerup_grab_green_zmb" );
#precache( "fx", "_xcdylan93/green/waffe/fx_dg2_impact" );
#precache( "fx", "_xcdylan93/green/waffe/fx_dg2_trail" );
#precache( "fx", "_xcdylan93/green/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "fx", "_xcdylan93/green/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "fx", "_xcdylan93/green/wavegun/fx_microwavegun_impact" );
#precache( "fx", "_xcdylan93/green/wavegun/fx_zap_shock" );
#precache( "fx", "_xcdylan93/green/wavegun/fx_zap_shock_eyes" );

/* ---------------- ORANGE ---------------- */
#precache( "fx", "_xcdylan93/orange/powerups/fx_powerup_grab_green_zmb" );
#precache( "fx", "_xcdylan93/orange/waffe/fx_dg2_impact" );
#precache( "fx", "_xcdylan93/orange/waffe/fx_dg2_trail" );
#precache( "fx", "_xcdylan93/orange/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "fx", "_xcdylan93/orange/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "fx", "_xcdylan93/orange/wavegun/fx_microwavegun_impact" );
#precache( "fx", "_xcdylan93/orange/wavegun/fx_zap_shock" );
#precache( "fx", "_xcdylan93/orange/wavegun/fx_zap_shock_eyes" );

/* ---------------- PINK ---------------- */
#precache( "fx", "_xcdylan93/pink/powerups/fx_powerup_grab_green_zmb" );
#precache( "fx", "_xcdylan93/pink/waffe/fx_dg2_impact" );
#precache( "fx", "_xcdylan93/pink/waffe/fx_dg2_trail" );
#precache( "fx", "_xcdylan93/pink/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "fx", "_xcdylan93/pink/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "fx", "_xcdylan93/pink/wavegun/fx_microwavegun_impact" );
#precache( "fx", "_xcdylan93/pink/wavegun/fx_zap_shock" );
#precache( "fx", "_xcdylan93/pink/wavegun/fx_zap_shock_eyes" );

/* ---------------- PURPLE ---------------- */
#precache( "fx", "_xcdylan93/purple/powerups/fx_powerup_grab_green_zmb" );
#precache( "fx", "_xcdylan93/purple/waffe/fx_dg2_impact" );
#precache( "fx", "_xcdylan93/purple/waffe/fx_dg2_trail" );
#precache( "fx", "_xcdylan93/purple/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "fx", "_xcdylan93/purple/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "fx", "_xcdylan93/purple/wavegun/fx_microwavegun_impact" );
#precache( "fx", "_xcdylan93/purple/wavegun/fx_zap_shock" );
#precache( "fx", "_xcdylan93/purple/wavegun/fx_zap_shock_eyes" );

/* ---------------- RED ---------------- */
#precache( "fx", "_xcdylan93/red/powerups/fx_powerup_grab_green_zmb" );
#precache( "fx", "_xcdylan93/red/thundergun/fx_thundergun_steam" );
#precache( "fx", "_xcdylan93/red/waffe/fx_dg2_impact" );
#precache( "fx", "_xcdylan93/red/waffe/fx_dg2_trail" );
#precache( "fx", "_xcdylan93/red/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "fx", "_xcdylan93/red/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "fx", "_xcdylan93/red/wavegun/fx_microwavegun_impact" );
#precache( "fx", "_xcdylan93/red/wavegun/fx_zap_shock" );
#precache( "fx", "_xcdylan93/red/wavegun/fx_zap_shock_eyes" );

/* ---------------- WHITE ---------------- */
#precache( "fx", "_xcdylan93/white/powerups/fx_powerup_grab_green_zmb" );
#precache( "fx", "_xcdylan93/white/waffe/fx_dg2_impact" );
#precache( "fx", "_xcdylan93/white/waffe/fx_dg2_trail" );
#precache( "fx", "_xcdylan93/white/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "fx", "_xcdylan93/white/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "fx", "_xcdylan93/white/wavegun/fx_microwavegun_impact" );
#precache( "fx", "_xcdylan93/white/wavegun/fx_zap_shock" );
#precache( "fx", "_xcdylan93/white/wavegun/fx_zap_shock_eyes" );

/* ---------------- YELLOW ---------------- */
#precache( "fx", "_xcdylan93/yellow/powerups/fx_powerup_grab_green_zmb" );
#precache( "fx", "_xcdylan93/yellow/wavegun/fx_microwavegun_impact" );
#precache( "fx", "_xcdylan93/yellow/wavegun/fx_zap_shock" );
#precache( "fx", "_xcdylan93/yellow/wavegun/fx_zap_shock_eyes" );