#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_xcdylan93\_zm_startmenu;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

REGISTER_SYSTEM_EX( "mod_fx", &__init__, &__main__, undefined )

function __init__()
{
    init_fx();
	callback::on_localplayer_spawned( &on_spawned );

    clientfield::register( "toplayer", "dw_fired", VERSION_SHIP, 1, "counter", &dw_fired, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
    clientfield::register( "toplayer", "lh_fired", VERSION_SHIP, 1, "counter", &lh_fired, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
}

function __main__()
{
    set_default_colors();
}

function init_fx()
{
    foreach( category in array( "powerup", "muzzle", "laser", "tesla", "wavegun" ) )
    {
        foreach( color in array( "red", "orange", "yellow", "green", "blue", "purple", "pink" ) )
        {
            switch( category )
            {
                 case "powerup":
                    register_effect_info( "powerup", array(
                        array( "powerup_on", sprintf( "_xcdylan93/{0}/powerups/fx_powerup_on_green_zmb", color ) ),
                        array( "powerup_on_solo", sprintf( "_xcdylan93/{0}/powerups/fx_powerup_on_green_zmb", color ) ) ) );
                    break;

                case "muzzle":
                    register_effect_info( "muzzle", array("muz_flash", sprintf( "_xcdylan93/{0}/muzzle/fx_muzflash_{0}", color ) ) );
                    break;

                case "laser":
                    register_effect_info( "laser", array( "laser_fx", sprintf( "_xcdylan93/{0}/laser/fx_laser_{0}", color ) ) );
                    break;

                case "tesla":
                    register_effect_info( "tesla", array(
                        array( "beast_shock", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_zmb", color ) ),
                        array( "death_ray_shock_eyes", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_eyes_zmb", color ) ),
                        array( "ee_quest_keeper_shocked", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_zmb", color ) ),
                        array( "elem_storm_shock", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_zmb", color ) ),
                        array( "elem_storm_shock_eyes", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_eyes_zmb", color ) ),
                        array( "elem_storm_shock_nonfatal", sprintf( "_xcdylan93/{0}/waffe/fx_bmode_shock_os_zod_zmb", color ) ),
                        array( "skull_turret_shock_eyes", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_eyes_zmb", color ) ),
                        array( "tesla_bolt", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_bolt_secondary_zmb", color ) ),
                        array( "tesla_death_cherry", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_zmb", color ) ),
                        array( "tesla_flash", sprintf( "_xcdylan93/{0}/waffe/fx_dg2_flash", color ) ),
                        array( "tesla_pers", sprintf( "_xcdylan93/{0}/waffe/fx_dg2_pers", color ) ),
                        array( "tesla_rail", sprintf( "_xcdylan93/{0}/waffe/fx_dg2_rail", color ) ),
                        array( "tesla_shock", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_zmb", color ) ),
                        array( "tesla_shock_cherry", sprintf( "_xcdylan93/{0}/waffe/fx_bmode_shock_os_zod_zmb", color ) ),
                        array( "tesla_shock_eyes", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_eyes_zmb", color ) ),
                        array( "tesla_shock_eyes_cherry", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_eyes_zmb", color ) ),
                        array( "tesla_shock_nonfatal", sprintf( "_xcdylan93/{0}/waffe/fx_bmode_shock_os_zod_zmb", color ) ),
                        array( "tesla_shock_secondary", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_bolt_secondary_zmb", color ) ),
                        array( "tesla_tube", sprintf( "_xcdylan93/{0}/waffe/fx_dg2_tube", color ) ),
                        array( "turret_zombie_shock", sprintf( "_xcdylan93/{0}/waffe/fx_tesla_shock_zmb", color ) ) ) );
                    break;

                case "wavegun":
                    register_effect_info( "wavegun", array(
                        array( "microwavegun_sizzle_blood_eyes", sprintf( "_xcdylan93/{0}/wavegun/fx_sizzle_blood_eyes", color ) ),
                        array( "mivrowavegun_sizzle_death_mist", sprintf( "_xcdylan93/{0}/wavegun/fx_sizzle_mist", color ) ),
                        array( "microwavegun_sizzle_death_mist_low_g", sprintf( "_xcdylan93/{0}/wavegun/fx_sizzle_mist_low_g", color ) ),
                        array( "wavegun_flash", sprintf( "_xcdylan93/{0}/wavegun/fx_microwavegun_view", color ) ),
                        array( "wavegun_trail", sprintf( "_xcdylan93/{0}/wavegun/fx_microwavegun_trail", color ) ),
                        array( "zapgun_trail", sprintf( "_xcdylan93/{0}/wavegun/fx_microwavegun_dw_trail", color ) ),
                        array( "zapgundw_flash", sprintf( "_xcdylan93/{0}/wavegun/fx_microwavegun_dw", color ) ),
                        array( "zapgunlh_flash", sprintf( "_xcdylan93/{0}/wavegun/fx_microwavegun_lh", color ) ) ) );
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
    DEFAULT( world._effect, [] );
    for( i = 0; i < GetDvarInt( "com_maxclients" ); i++ )
    {
        level zm_startmenu::set_effect( i, "powerup", level.fx_color );
    }
    color = ( isdefined( world._effect ) && isdefined( world._effect["eye"] ) ? world._effect["eye"] : level.fx_color );
    level._override_eye_fx = sprintf( "_xcdylan93/{0}/eyes/{0}_zombie_eyes", color );
}

function on_spawned( localclientnum )
{
    player = GetLocalPlayer( localclientnum );
    
    player thread action_monitor( localclientnum );
    player thread weapon_change( localclientnum );
    player thread weapon_fired( localclientnum );
    player thread ads_monitor( localclientnum );

    DEFAULT( player._effect, [] );
    DEFAULT( level.player_initialized, [] );

    foreach( category in array( "muzzle", "laser", "tesla", "wavegun" ) )
    {
        if( isdefined( world._effect ) && isdefined( world._effect[category] ) && isdefined( world._effect[category][localclientnum] ) )
        {
            player zm_startmenu::set_effect( localclientnum, category, world._effect[category][localclientnum] );
        }
        else if( !IS_TRUE( level.player_initialized[localclientnum] ) )
        {
            player zm_startmenu::set_effect( localclientnum, category, level.fx_color );
        }
    }

    level.player_initialized[localclientnum] = true;
}

function action_monitor( localclientnum )
{
    self endon( "disconnect" );
    self endon( "entityshutdown" );

    for(;;)
    {
        weapon = GetCurrentWeapon( localclientnum );
        self thread action_kill_fx( localclientnum );
        self util::waittill_any( "weapon_change", "kill_action", "new_wonder_color", "new_laser_color" );
    }
}

function action_kill_fx( localclientnum )
{
    self notify( "action_kill" );
    self endon( "action_kill" );
    self endon( "disconnect" );
    self endon( "entityshutdown" );
    self endon( "weapon_change" );

    for(;;)
    {
        if( IsThrowingGrenade( localclientnum ) || IsMeleeing( localclientnum ) )
        {
            self delete_weapon_fx( localclientnum );
            self delete_laser_fx( localclientnum );

            if( IsThrowingGrenade( localclientnum ) )
            {
                while( IsThrowingGrenade( localclientnum ) )
                {
                    wait 0.016;
                }
            }

            else if( IsMeleeing( localclientnum ) )
            {
                while( IsMeleeing( localclientnum ) )
                {
                    wait 0.016;
                }
            }

            self notify( "kill_action" );
        }

        wait 0.05;
    }
}

function weapon_change( localclientnum )
{
    self endon( "disconnect" );
    self endon( "entityshutdown" );

    waveguns = array( "microwavegun", "microwavegun_upgraded", "microwavegundw", "microwavegundw_upgraded" );

    for(;;)
    {
        self util::waittill_any( "weapon_change", "kill_action", "new_wonder_color", "new_laser_color" );

        waittillframeend;

        self delete_weapon_fx( localclientnum );
        self thread laser_fx( localclientnum );

        weapon = GetCurrentWeapon( localclientnum );

        if( !isdefined( weapon ) || weapon.isgrenadeweapon || weapon.name == "none" )
        {
            continue;
        }
        
        if( IsInArray( waveguns, weapon.name ) )
        {
            if( isdefined( world.wavegun_colors ) && isdefined( world.wavegun_colors[localclientnum] ) )
            {
                self zm_startmenu::set_shader_constant( localclientnum, 0, world.wavegun_colors[localclientnum] * 16 );
            }
        }

        else
        {
            if( isdefined( world.tritium_colors ) && isdefined( world.tritium_colors[localclientnum] ) )
            {
                self zm_startmenu::set_shader_constant( localclientnum, 0, world.tritium_colors[localclientnum] * 16 );
            }
        }
    }
}

function weapon_fired( localclientnum )
{
	self endon( "disconnect" );
    self endon( "entityshutdown" );

	for(;;)
	{
		self waittill( "weapon_fired" );

        weapon = GetCurrentWeapon( localclientnum );
        if( zm_weapons::is_wonder_weapon( weapon ) )
        {
            continue;
        }
        if( weapon.isdualwield )
        {
            continue;
        }

		if( isdefined( self.muz_fx ) )
		{
			DeleteFX( localclientnum, self.muz_fx, 0 );
			self.muz_fx = undefined;
		}

        fx = self get_fx_path( "muz_flash" );
		if( isdefined( fx ) )
		{
			if( ViewmodelHasTag( localclientnum, "tag_flash" ) )
			{
				self.muz_fx = PlayViewmodelFX( localclientnum, fx, "tag_flash" );
			}
		}
	}
}

function dw_fired( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if( isdefined( self.dw_flash_fx ) )
    {
        DeleteFX( localclientnum, self.dw_flash_fx );
        self.dw_flash_fx = undefined;
    }

    if( newval )
    {
        fx = self get_fx_path( "muz_flash" );
        if( isdefined( fx ) )
        {
            if( ViewmodelHasTag( localclientnum, "tag_flash" ) )
            {
                self.dw_flash_fx = PlayViewmodelFX( localclientnum, fx, "tag_flash" );
            }
        }
    }
}

function lh_fired( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if( isdefined( self.lh_flash_fx ) )
    {
        DeleteFX( localclientnum, self.lh_flash_fx );
        self.lh_flash_fx = undefined;
    }

    if( newval )
    {
        fx = self get_fx_path( "muz_flash" );
        if( isdefined( fx ) )
        {
            if( ViewmodelHasTag( localclientnum, "tag_flash_le" ) )
            {
                self.lh_flash_fx = PlayViewmodelFX( localclientnum, fx, "tag_flash_le" );
            }
        }
    }
}

function delete_weapon_fx( localclientnum )
{
    if( isdefined( self.weapon_fx ) )
    {
        if( IsArray( self.weapon_fx ) )
        {
            foreach( fx in self.weapon_fx )
            {
                DeleteFX( localclientnum, fx, 0 );
            }   
        }
        else
        {
            DeleteFX( localclientnum, self.weapon_fx, 0 );
        }
        
        self.weapon_fx = undefined;
    }
}

function ads_monitor( localclientnum )
{
    self endon( "disconnect" );
    self endon( "entityshutdown" );

    for(;;)
    {
        ads = IsADS( localclientnum );
        if( !isdefined( self.isads ) || self.isads != ads )
        {
            self.isads = ads;
            self laser_fx( localclientnum );
        }
        wait 0.016;
    }
}

function laser_fx( localclientnum )
{
    self delete_laser_fx( localclientnum );

    if( !IS_TRUE( self.isads ) && ViewmodelHasLaser( localclientnum ) )
    {
        if( ViewmodelHasTag( localclientnum, "tag_laser1" ) )
        {
            fx = self get_fx_path( "laser_fx" );
            if( isdefined( fx ) )
            {
                 self.laser_fx = PlayViewmodelFX( localclientnum, fx, "tag_laser1" );
            }
        }
    }
}

function delete_laser_fx( localclientnum )
{
    if( isdefined( self.laser_fx ) )
    {
        DeleteFX( localclientnum, self.laser_fx );
        self.laser_fx = undefined;
    }
}

function ViewmodelHasLaser( localclientnum )
{
    foreach( tag in array( "tag_dbal", "tag_dbal_attach", "tag_lower_attach", "tag_laser_attach" ) )
    {
        if( ViewmodelHasTag( localclientnum, tag ) )
        {
            return true;
        }
    }
    return false;
}

function get_fx_path( key )
{
    return( isdefined( self._effect ) && isdefined( self._effect[key] ) ? self._effect[key] : ( isdefined( level._effect ) && isdefined( level._effect[key] ) ? level._effect[key] : undefined ) );
}

/* ---------------- BLUE ---------------- */
#precache( "client_fx", "_xcdylan93/blue/eyes/blue_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/blue/laser/fx_laser_blue" );
#precache( "client_fx", "_xcdylan93/blue/muzzle/fx_muzflash_blue" );
#precache( "client_fx", "_xcdylan93/blue/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "client_fx", "_xcdylan93/blue/wavegun/fx_microwavegun_dw" );
#precache( "client_fx", "_xcdylan93/blue/wavegun/fx_microwavegun_dw_trail" );
#precache( "client_fx", "_xcdylan93/blue/wavegun/fx_microwavegun_lh" );
#precache( "client_fx", "_xcdylan93/blue/wavegun/fx_microwavegun_trail" );
#precache( "client_fx", "_xcdylan93/blue/wavegun/fx_microwavegun_view" );
#precache( "client_fx", "_xcdylan93/blue/wavegun/fx_sizzle_blood_eyes" );
#precache( "client_fx", "_xcdylan93/blue/wavegun/fx_sizzle_mist" );
#precache( "client_fx", "_xcdylan93/blue/wavegun/fx_sizzle_mist_low_g" );

/* ---------------- GREEN ---------------- */
#precache( "client_fx", "_xcdylan93/green/eyes/green_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/green/laser/fx_laser_green" );
#precache( "client_fx", "_xcdylan93/green/muzzle/fx_muzflash_green" );
#precache( "client_fx", "_xcdylan93/green/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "client_fx", "_xcdylan93/green/wavegun/fx_microwavegun_dw" );
#precache( "client_fx", "_xcdylan93/green/wavegun/fx_microwavegun_dw_trail" );
#precache( "client_fx", "_xcdylan93/green/wavegun/fx_microwavegun_lh" );
#precache( "client_fx", "_xcdylan93/green/wavegun/fx_microwavegun_trail" );
#precache( "client_fx", "_xcdylan93/green/wavegun/fx_microwavegun_view" );
#precache( "client_fx", "_xcdylan93/green/wavegun/fx_sizzle_blood_eyes" );
#precache( "client_fx", "_xcdylan93/green/wavegun/fx_sizzle_mist" );
#precache( "client_fx", "_xcdylan93/green/wavegun/fx_sizzle_mist_low_g" );

/* ---------------- ORANGE ---------------- */
#precache( "client_fx", "_xcdylan93/orange/eyes/orange_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/orange/laser/fx_laser_orange" );
#precache( "client_fx", "_xcdylan93/orange/muzzle/fx_muzflash_orange" );
#precache( "client_fx", "_xcdylan93/orange/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "client_fx", "_xcdylan93/orange/wavegun/fx_microwavegun_dw" );
#precache( "client_fx", "_xcdylan93/orange/wavegun/fx_microwavegun_dw_trail" );
#precache( "client_fx", "_xcdylan93/orange/wavegun/fx_microwavegun_lh" );
#precache( "client_fx", "_xcdylan93/orange/wavegun/fx_microwavegun_trail" );
#precache( "client_fx", "_xcdylan93/orange/wavegun/fx_microwavegun_view" );
#precache( "client_fx", "_xcdylan93/orange/wavegun/fx_sizzle_blood_eyes" );
#precache( "client_fx", "_xcdylan93/orange/wavegun/fx_sizzle_mist" );
#precache( "client_fx", "_xcdylan93/orange/wavegun/fx_sizzle_mist_low_g" );

/* ---------------- PINK ---------------- */
#precache( "client_fx", "_xcdylan93/pink/eyes/pink_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/pink/laser/fx_laser_pink" );
#precache( "client_fx", "_xcdylan93/pink/muzzle/fx_muzflash_pink" );
#precache( "client_fx", "_xcdylan93/pink/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "client_fx", "_xcdylan93/pink/wavegun/fx_microwavegun_dw" );
#precache( "client_fx", "_xcdylan93/pink/wavegun/fx_microwavegun_dw_trail" );
#precache( "client_fx", "_xcdylan93/pink/wavegun/fx_microwavegun_lh" );
#precache( "client_fx", "_xcdylan93/pink/wavegun/fx_microwavegun_trail" );
#precache( "client_fx", "_xcdylan93/pink/wavegun/fx_microwavegun_view" );
#precache( "client_fx", "_xcdylan93/pink/wavegun/fx_sizzle_blood_eyes" );
#precache( "client_fx", "_xcdylan93/pink/wavegun/fx_sizzle_mist" );
#precache( "client_fx", "_xcdylan93/pink/wavegun/fx_sizzle_mist_low_g" );

/* ---------------- PURPLE ---------------- */
#precache( "client_fx", "_xcdylan93/purple/eyes/purple_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/purple/laser/fx_laser_purple" );
#precache( "client_fx", "_xcdylan93/purple/muzzle/fx_muzflash_purple" );
#precache( "client_fx", "_xcdylan93/purple/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "client_fx", "_xcdylan93/purple/wavegun/fx_microwavegun_dw" );
#precache( "client_fx", "_xcdylan93/purple/wavegun/fx_microwavegun_dw_trail" );
#precache( "client_fx", "_xcdylan93/purple/wavegun/fx_microwavegun_lh" );
#precache( "client_fx", "_xcdylan93/purple/wavegun/fx_microwavegun_trail" );
#precache( "client_fx", "_xcdylan93/purple/wavegun/fx_microwavegun_view" );
#precache( "client_fx", "_xcdylan93/purple/wavegun/fx_sizzle_blood_eyes" );
#precache( "client_fx", "_xcdylan93/purple/wavegun/fx_sizzle_mist" );
#precache( "client_fx", "_xcdylan93/purple/wavegun/fx_sizzle_mist_low_g" );

/* ---------------- RED ---------------- */
#precache( "client_fx", "_xcdylan93/red/eyes/red_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/red/laser/fx_laser_red" );
#precache( "client_fx", "_xcdylan93/red/muzzle/fx_muzflash_red" );
#precache( "client_fx", "_xcdylan93/red/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "client_fx", "_xcdylan93/red/wavegun/fx_microwavegun_dw" );
#precache( "client_fx", "_xcdylan93/red/wavegun/fx_microwavegun_dw_trail" );
#precache( "client_fx", "_xcdylan93/red/wavegun/fx_microwavegun_lh" );
#precache( "client_fx", "_xcdylan93/red/wavegun/fx_microwavegun_trail" );
#precache( "client_fx", "_xcdylan93/red/wavegun/fx_microwavegun_view" );
#precache( "client_fx", "_xcdylan93/red/wavegun/fx_sizzle_blood_eyes" );
#precache( "client_fx", "_xcdylan93/red/wavegun/fx_sizzle_mist" );
#precache( "client_fx", "_xcdylan93/red/wavegun/fx_sizzle_mist_low_g" );

/* ---------------- WHITE ---------------- */
#precache( "client_fx", "_xcdylan93/white/eyes/white_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/white/laser/fx_laser_white" );
#precache( "client_fx", "_xcdylan93/white/muzzle/fx_muzflash_white" );
#precache( "client_fx", "_xcdylan93/white/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_tesla_shock_eyes_zmb" );
#precache( "client_fx", "_xcdylan93/white/wavegun/fx_microwavegun_dw" );
#precache( "client_fx", "_xcdylan93/white/wavegun/fx_microwavegun_dw_trail" );
#precache( "client_fx", "_xcdylan93/white/wavegun/fx_microwavegun_lh" );
#precache( "client_fx", "_xcdylan93/white/wavegun/fx_microwavegun_trail" );
#precache( "client_fx", "_xcdylan93/white/wavegun/fx_microwavegun_view" );
#precache( "client_fx", "_xcdylan93/white/wavegun/fx_sizzle_blood_eyes" );
#precache( "client_fx", "_xcdylan93/white/wavegun/fx_sizzle_mist" );
#precache( "client_fx", "_xcdylan93/white/wavegun/fx_sizzle_mist_low_g" );

/* ---------------- YELLOW ---------------- */
#precache( "client_fx", "_xcdylan93/yellow/eyes/yellow_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/yellow/laser/fx_laser_yellow" );
#precache( "client_fx", "_xcdylan93/yellow/muzzle/fx_muzflash_yellow" );
#precache( "client_fx", "_xcdylan93/yellow/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/yellow/wavegun/fx_microwavegun_dw" );
#precache( "client_fx", "_xcdylan93/yellow/wavegun/fx_microwavegun_dw_trail" );
#precache( "client_fx", "_xcdylan93/yellow/wavegun/fx_microwavegun_lh" );
#precache( "client_fx", "_xcdylan93/yellow/wavegun/fx_microwavegun_trail" );
#precache( "client_fx", "_xcdylan93/yellow/wavegun/fx_microwavegun_view" );
#precache( "client_fx", "_xcdylan93/yellow/wavegun/fx_sizzle_blood_eyes" );
#precache( "client_fx", "_xcdylan93/yellow/wavegun/fx_sizzle_mist" );
#precache( "client_fx", "_xcdylan93/yellow/wavegun/fx_sizzle_mist_low_g" );