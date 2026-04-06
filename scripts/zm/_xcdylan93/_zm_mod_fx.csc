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
    foreach( category in array( "powerup", "muzzle", "laser", "tesla", "tgun", "idgun", "magmagat" ) )
    {
        foreach( color in array( "red", "orange", "yellow", "green", "blue", "purple", "pink", "white" ) )
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

                case "tgun":
                    register_effect_info( "tgun", array(
                        array( "tgun_flash", sprintf( "_xcdylan93/{0}/thundergun/fx_thundergun_flash", color ) ),
                        array( "tgun_glow", sprintf( "_xcdylan93/{0}/thundergun/fx_thundergun_glow", color ) ),
                        array( "tgun_pers", sprintf( "_xcdylan93/{0}/thundergun/fx_thundergun_pers", color ) ),
                        array( "tgun_trail", sprintf( "_xcdylan93/{0}/thundergun/fx_thundergun_trail", color ) ) ) );
                    break;

                case "idgun":
                    register_effect_info( "idgun", array(
                        array( "idgun_pers", sprintf( "_xcdylan93/{0}/idgun/fx_idgun_pers", color ) ),
                        array( "vortex", sprintf( "_xcdylan93/{0}/idgun/fx_idgun_vortex", color ) ),
                        array( "vortex_explo", sprintf( "_xcdylan93/{0}/idgun/fx_idgun_vortex_explo", color ) ) ) );
                    break;

                case "magmagat":
                    register_effect_info( "magmagat", array(
                        array( "magma_pers", sprintf( "_xcdylan93/{0}/magmagat/fx_magma_pers", color ) ),
                        array( "magmagat_aoe", sprintf( "_xcdylan93/{0}/magmagat/fx_magmagat_aoe", color ) ),
                        array( "magmagat_trail", sprintf( "_xcdylan93/{0}/magmagat/fx_magmagat_trail_bolt", color ) ),
                        array( "fire_zombie_j_elbow_le_loop", sprintf( "_xcdylan93/{0}/fire/fx_fire_ai_human_arm_left_os", color ) ),
                        array( "fire_zombie_j_elbow_ri_loop", sprintf( "_xcdylan93/{0}/fire/fx_fire_ai_human_arm_right_os", color ) ),
                        array( "fire_zombie_j_shoulder_le_loop", sprintf( "_xcdylan93/{0}/fire/fx_fire_ai_human_arm_left_os", color ) ),
                        array( "fire_zombie_j_shoulder_ri_loop", sprintf( "_xcdylan93/{0}/fire/fx_fire_ai_human_arm_right_os", color ) ),
                        array( "fire_zombie_j_spine4_loop", sprintf( "_xcdylan93/{0}/fire/fx_fire_ai_human_torso_os", color ) ),
                        array( "fire_zombie_j_hip_le_loop", sprintf( "_xcdylan93/{0}/fire/fx_fire_ai_human_hip_left_os", color ) ),
                        array( "fire_zombie_j_hip_ri_loop", sprintf( "_xcdylan93/{0}/fire/fx_fire_ai_human_hip_right_os", color ) ),
                        array( "fire_zombie_j_knee_le_loop", sprintf( "_xcdylan93/{0}/fire/fx_fire_ai_human_leg_left_os", color ) ),
                        array( "fire_zombie_j_knee_ri_loop", sprintf( "_xcdylan93/{0}/fire/fx_fire_ai_human_leg_right_os", color ) ),
                        array( "fire_zombie_j_head_loop", sprintf( "_xcdylan93/{0}/fire/fx_fire_ai_human_head_os", color ) ),
                        array( "character_fire_death_torso", sprintf( "_xcdylan93/{0}/fire/fx_fire_torso_zmb", color ) ),
                        array( "character_fire_death_sm", sprintf( "_xcdylan93/{0}/fire/fx_fire_torso_zmb", color ) ) ) );
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
        level zm_startmenu::set_effect( i, "magmagat", "orange" );
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
    DEFAULT( level.pmod_initialized, [] );

    foreach( category in array( "muzzle", "laser", "tesla", "tgun", "idgun" ) )
    {
        if( isdefined( world._effect ) && isdefined( world._effect[category] ) && isdefined( world._effect[category][localclientnum] ) )
        {
            player zm_startmenu::set_effect( localclientnum, category, world._effect[category][localclientnum] );
        }
        else if( !IS_TRUE( level.pmod_initialized[localclientnum] ) )
        {
            player zm_startmenu::set_effect( localclientnum, category, level.fx_color );
        }
    }

    level.pmod_initialized[localclientnum] = true;
}

function action_monitor( localclientnum )
{
    self endon( "disconnect" );
    self endon( "entityshutdown" );

    for(;;)
    {
        weapon = GetCurrentWeapon( localclientnum );
        if( isdefined( weapon ) && StrStartsWith( weapon.name, "idgun" ) )
		{
			self thread play_idgun_breath( localclientnum );
		}
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

    idguns = array( "idgun_0", "idgun_1", "idgun_2", "idgun_3", "idgun_genesis_0", "idgun_genesis_0_upgraded" );
    thunderguns = array( "thundergun", "thundergun_upgraded" );
    waveguns = array( "microwavegun", "microwavegun_upgraded", "microwavegundw", "microwavegundw_upgraded" );
    blundergats = array( "t8_magmagat", "t8_magmagat_upgraded", "t8_blundersplat", "t8_blundersplat_upgraded" );

    for(;;)
    {
        self util::waittill_any( "weapon_change", "kill_action", "new_wonder_color", "new_laser_color" );

        waittillframeend;

        self delete_weapon_fx( localclientnum );
        self thread laser_fx( localclientnum );

        weapon = GetCurrentWeapon( localclientnum );

        if( !isdefined( weapon ) || weapon.isgrenadeweapon || weapon.name == "none" || IS_TRUE( self.afterlife ) )
        {
            continue;
        }
        
        if( IsInArray( idguns, weapon.name ) )
        {
            if( isdefined( world.idgun_colors ) && isdefined( world.idgun_colors[localclientnum] ) )
            {
                tint = array( 3, 2, 2, 1, 1, 0, 4, -1 )[world.idgun_colors[localclientnum]];
                self zm_startmenu::set_shader_constant( localclientnum, 2, 0, 1, tint );
            }
        }

        else if( IsInArray( thunderguns, weapon.name ) )
        {
            if( isdefined( world.tgun_colors ) && isdefined( world.tgun_colors[localclientnum] ) )
            {
                self zm_startmenu::set_shader_constant( localclientnum, 0, world.tgun_colors[localclientnum] * 16 );
            }
        }

        else if( IsInArray( waveguns, weapon.name ) )
        {
            if( isdefined( world.wavegun_colors ) && isdefined( world.wavegun_colors[localclientnum] ) )
            {
                self zm_startmenu::set_shader_constant( localclientnum, 0, world.wavegun_colors[localclientnum] * 16 );
            }
        }

        else if( IsInArray( blundergats, weapon.name ) )
        {
            if( isdefined( world.gat_colors ) && isdefined( world.gat_colors[localclientnum] ) )
            {
                tint = array( 1, 1, 1, 3, 3, 4, 4, 1 )[world.gat_colors[localclientnum]];
                self zm_startmenu::set_shader_constant( localclientnum, 2, 0, 1, tint );
                if( weapon.name == "t8_magmagat_upgraded" || weapon.name == "t8_blundersplat_upgraded" )
                {
                    self.weapon_fx = PlayViewmodelFX( localclientnum, level._effect["magma_pers"], "tag_hammer_animate" );
                }
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

function play_idgun_breath( localclientnum )
{
    self notify( "play_idgun_breath" );
    self endon( "play_idgun_breath" );
    self endon( "disconnect" );
    self endon( "entityshutdown" );
    self endon( "weapon_change" );

    tubes = array( "tag_tube_back_left_animate", "tag_tube_back_right_animate", "tag_tube_front_left_animate", "tag_tube_front_right_animate", "tag_tube_mid_left_animate", "tag_tube_mid_right_animate" );
    
    for(;;)
    {
    	wait 1;

        PlaySound( localclientnum, "pod_inhale_stg1" );
        
        if( isdefined( self.weapon_fx ) )
        {
            self delete_weapon_fx( localclientnum );
        }

        wait 3;

        PlaySound( localclientnum, "pod_exhale_stg1" );
        self.weapon_fx = [];
        tubes = array::randomize( tubes );

        for( i = 0; i < tubes.size; i++ )
        {
            if( ViewmodelHasTag( localclientnum, tubes[i] ) )
            {
                self.weapon_fx[i] = PlayViewmodelFX( localclientnum, level._effect["idgun_pers"], tubes[i] );
            }
            wait 0.15;
        }

        wait RandomFloatRange( 2.5, 4.5 ); 
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
#precache( "client_fx", "_xcdylan93/blue/fire/fx_fire_ai_human_arm_left_os" );
#precache( "client_fx", "_xcdylan93/blue/fire/fx_fire_ai_human_arm_right_os" );
#precache( "client_fx", "_xcdylan93/blue/fire/fx_fire_ai_human_head_os" );
#precache( "client_fx", "_xcdylan93/blue/fire/fx_fire_ai_human_hip_left_os" );
#precache( "client_fx", "_xcdylan93/blue/fire/fx_fire_ai_human_hip_right_os" );
#precache( "client_fx", "_xcdylan93/blue/fire/fx_fire_ai_human_leg_left_os" );
#precache( "client_fx", "_xcdylan93/blue/fire/fx_fire_ai_human_leg_right_os" );
#precache( "client_fx", "_xcdylan93/blue/fire/fx_fire_ai_human_torso_os" );
#precache( "client_fx", "_xcdylan93/blue/fire/fx_fire_torso_zmb" );
#precache( "client_fx", "_xcdylan93/blue/idgun/fx_idgun_pers" );
#precache( "client_fx", "_xcdylan93/blue/idgun/fx_idgun_vortex" );
#precache( "client_fx", "_xcdylan93/blue/idgun/fx_idgun_vortex_explo" );
#precache( "client_fx", "_xcdylan93/blue/laser/fx_laser_blue" );
#precache( "client_fx", "_xcdylan93/blue/magmagat/fx_magma_pers" );
#precache( "client_fx", "_xcdylan93/blue/magmagat/fx_magmagat_aoe" );
#precache( "client_fx", "_xcdylan93/blue/magmagat/fx_magmagat_trail_bolt" );
#precache( "client_fx", "_xcdylan93/blue/muzzle/fx_muzflash_blue" );
#precache( "client_fx", "_xcdylan93/blue/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/blue/thundergun/fx_thundergun_flash" );
#precache( "client_fx", "_xcdylan93/blue/thundergun/fx_thundergun_glow" );
#precache( "client_fx", "_xcdylan93/blue/thundergun/fx_thundergun_pers" );
#precache( "client_fx", "_xcdylan93/blue/thundergun/fx_thundergun_trail" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/blue/waffe/fx_tesla_shock_eyes_zmb" );

/* ---------------- GREEN ---------------- */
#precache( "client_fx", "_xcdylan93/green/eyes/green_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/green/laser/fx_laser_green" );
#precache( "client_fx", "_xcdylan93/green/muzzle/fx_muzflash_green" );
#precache( "client_fx", "_xcdylan93/green/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/green/thundergun/fx_thundergun_flash" );
#precache( "client_fx", "_xcdylan93/green/thundergun/fx_thundergun_glow" );
#precache( "client_fx", "_xcdylan93/green/thundergun/fx_thundergun_pers" );
#precache( "client_fx", "_xcdylan93/green/thundergun/fx_thundergun_trail" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/green/waffe/fx_tesla_shock_eyes_zmb" );

/* ---------------- ORANGE ---------------- */
#precache( "client_fx", "_xcdylan93/orange/eyes/orange_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/orange/fire/fx_fire_ai_human_arm_left_os" );
#precache( "client_fx", "_xcdylan93/orange/fire/fx_fire_ai_human_arm_right_os" );
#precache( "client_fx", "_xcdylan93/orange/fire/fx_fire_ai_human_head_os" );
#precache( "client_fx", "_xcdylan93/orange/fire/fx_fire_ai_human_hip_left_os" );
#precache( "client_fx", "_xcdylan93/orange/fire/fx_fire_ai_human_hip_right_os" );
#precache( "client_fx", "_xcdylan93/orange/fire/fx_fire_ai_human_leg_left_os" );
#precache( "client_fx", "_xcdylan93/orange/fire/fx_fire_ai_human_leg_right_os" );
#precache( "client_fx", "_xcdylan93/orange/fire/fx_fire_ai_human_torso_os" );
#precache( "client_fx", "_xcdylan93/orange/fire/fx_fire_torso_zmb" );
#precache( "client_fx", "_xcdylan93/orange/idgun/fx_idgun_pers" );
#precache( "client_fx", "_xcdylan93/orange/idgun/fx_idgun_vortex" );
#precache( "client_fx", "_xcdylan93/orange/idgun/fx_idgun_vortex_explo" );
#precache( "client_fx", "_xcdylan93/orange/laser/fx_laser_orange" );
#precache( "client_fx", "_xcdylan93/orange/magmagat/fx_magma_pers" );
#precache( "client_fx", "_xcdylan93/orange/magmagat/fx_magmagat_aoe" );
#precache( "client_fx", "_xcdylan93/orange/magmagat/fx_magmagat_trail_bolt" );
#precache( "client_fx", "_xcdylan93/orange/muzzle/fx_muzflash_orange" );
#precache( "client_fx", "_xcdylan93/orange/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/orange/thundergun/fx_thundergun_flash" );
#precache( "client_fx", "_xcdylan93/orange/thundergun/fx_thundergun_glow" );
#precache( "client_fx", "_xcdylan93/orange/thundergun/fx_thundergun_pers" );
#precache( "client_fx", "_xcdylan93/orange/thundergun/fx_thundergun_trail" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/orange/waffe/fx_tesla_shock_eyes_zmb" );

/* ---------------- PINK ---------------- */
#precache( "client_fx", "_xcdylan93/pink/eyes/pink_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/pink/idgun/fx_idgun_pers" );
#precache( "client_fx", "_xcdylan93/pink/idgun/fx_idgun_vortex" );
#precache( "client_fx", "_xcdylan93/pink/idgun/fx_idgun_vortex_explo" );
#precache( "client_fx", "_xcdylan93/pink/laser/fx_laser_pink" );
#precache( "client_fx", "_xcdylan93/pink/muzzle/fx_muzflash_pink" );
#precache( "client_fx", "_xcdylan93/pink/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/pink/thundergun/fx_thundergun_flash" );
#precache( "client_fx", "_xcdylan93/pink/thundergun/fx_thundergun_glow" );
#precache( "client_fx", "_xcdylan93/pink/thundergun/fx_thundergun_pers" );
#precache( "client_fx", "_xcdylan93/pink/thundergun/fx_thundergun_trail" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/pink/waffe/fx_tesla_shock_eyes_zmb" );

/* ---------------- PURPLE ---------------- */
#precache( "client_fx", "_xcdylan93/purple/eyes/purple_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/purple/fire/fx_fire_ai_human_arm_left_os" );
#precache( "client_fx", "_xcdylan93/purple/fire/fx_fire_ai_human_arm_right_os" );
#precache( "client_fx", "_xcdylan93/purple/fire/fx_fire_ai_human_head_os" );
#precache( "client_fx", "_xcdylan93/purple/fire/fx_fire_ai_human_hip_left_os" );
#precache( "client_fx", "_xcdylan93/purple/fire/fx_fire_ai_human_hip_right_os" );
#precache( "client_fx", "_xcdylan93/purple/fire/fx_fire_ai_human_leg_left_os" );
#precache( "client_fx", "_xcdylan93/purple/fire/fx_fire_ai_human_leg_right_os" );
#precache( "client_fx", "_xcdylan93/purple/fire/fx_fire_ai_human_torso_os" );
#precache( "client_fx", "_xcdylan93/purple/fire/fx_fire_torso_zmb" );
#precache( "client_fx", "_xcdylan93/purple/idgun/fx_idgun_pers" );
#precache( "client_fx", "_xcdylan93/purple/idgun/fx_idgun_vortex" );
#precache( "client_fx", "_xcdylan93/purple/idgun/fx_idgun_vortex_explo" );
#precache( "client_fx", "_xcdylan93/purple/laser/fx_laser_purple" );
#precache( "client_fx", "_xcdylan93/purple/magmagat/fx_magma_pers" );
#precache( "client_fx", "_xcdylan93/purple/magmagat/fx_magmagat_aoe" );
#precache( "client_fx", "_xcdylan93/purple/magmagat/fx_magmagat_trail_bolt" );
#precache( "client_fx", "_xcdylan93/purple/muzzle/fx_muzflash_purple" );
#precache( "client_fx", "_xcdylan93/purple/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/purple/thundergun/fx_thundergun_flash" );
#precache( "client_fx", "_xcdylan93/purple/thundergun/fx_thundergun_glow" );
#precache( "client_fx", "_xcdylan93/purple/thundergun/fx_thundergun_pers" );
#precache( "client_fx", "_xcdylan93/purple/thundergun/fx_thundergun_trail" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/purple/waffe/fx_tesla_shock_eyes_zmb" );

/* ---------------- RED ---------------- */
#precache( "client_fx", "_xcdylan93/red/eyes/red_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/red/idgun/fx_idgun_pers" );
#precache( "client_fx", "_xcdylan93/red/idgun/fx_idgun_vortex" );
#precache( "client_fx", "_xcdylan93/red/idgun/fx_idgun_vortex_explo" );
#precache( "client_fx", "_xcdylan93/red/laser/fx_laser_red" );
#precache( "client_fx", "_xcdylan93/red/muzzle/fx_muzflash_red" );
#precache( "client_fx", "_xcdylan93/red/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/red/thundergun/fx_thundergun_flash" );
#precache( "client_fx", "_xcdylan93/red/thundergun/fx_thundergun_glow" );
#precache( "client_fx", "_xcdylan93/red/thundergun/fx_thundergun_pers" );
#precache( "client_fx", "_xcdylan93/red/thundergun/fx_thundergun_trail" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/red/waffe/fx_tesla_shock_eyes_zmb" );

/* ---------------- WHITE ---------------- */
#precache( "client_fx", "_xcdylan93/white/eyes/white_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/white/idgun/fx_idgun_pers" );
#precache( "client_fx", "_xcdylan93/white/idgun/fx_idgun_vortex" );
#precache( "client_fx", "_xcdylan93/white/idgun/fx_idgun_vortex_explo" );
#precache( "client_fx", "_xcdylan93/white/laser/fx_laser_white" );
#precache( "client_fx", "_xcdylan93/white/muzzle/fx_muzflash_white" );
#precache( "client_fx", "_xcdylan93/white/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/white/thundergun/fx_thundergun_flash" );
#precache( "client_fx", "_xcdylan93/white/thundergun/fx_thundergun_glow" );
#precache( "client_fx", "_xcdylan93/white/thundergun/fx_thundergun_pers" );
#precache( "client_fx", "_xcdylan93/white/thundergun/fx_thundergun_trail" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_bmode_shock_os_zod_zmb" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_dg2_flash" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_dg2_pers" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_dg2_rail" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_dg2_tube" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_tesla_bolt_secondary_zmb" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_tesla_shock_zmb" );
#precache( "client_fx", "_xcdylan93/white/waffe/fx_tesla_shock_eyes_zmb" );

/* ---------------- YELLOW ---------------- */
#precache( "client_fx", "_xcdylan93/yellow/eyes/yellow_zombie_eyes" );
#precache( "client_fx", "_xcdylan93/yellow/laser/fx_laser_yellow" );
#precache( "client_fx", "_xcdylan93/yellow/muzzle/fx_muzflash_yellow" );
#precache( "client_fx", "_xcdylan93/yellow/powerups/fx_powerup_on_green_zmb" );
#precache( "client_fx", "_xcdylan93/yellow/thundergun/fx_thundergun_flash" );
#precache( "client_fx", "_xcdylan93/yellow/thundergun/fx_thundergun_glow" );
#precache( "client_fx", "_xcdylan93/yellow/thundergun/fx_thundergun_pers" );
#precache( "client_fx", "_xcdylan93/yellow/thundergun/fx_thundergun_trail" );