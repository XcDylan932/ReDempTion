#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace zm_weap_microwavegun;

REGISTER_SYSTEM( "zm_weap_microwavegun", &__init__, undefined )

function __init__()
{
	clientfield::register( "actor", "toggle_microwavegun_hit_response", VERSION_DLC5, 1, "int" );
	clientfield::register( "actor", "toggle_microwavegun_expand_response", VERSION_DLC5, 1, "int" );
	clientfield::register( "clientuimodel", "hudItems.showDpadLeft_WaveGun", VERSION_DLC5, 1, "int" );
	clientfield::register( "clientuimodel", "hudItems.dpadLeftAmmo", VERSION_DLC5, 5, "int" );
	clientfield::register( "scriptmover", "wavegun_trail", VERSION_DLC5, 1, "int" );
	clientfield::register( "scriptmover", "zapgun_trail", VERSION_DLC5, 1, "int" );
	clientfield::register( "toplayer", "wavegun_fired", VERSION_DLC5, 1, "counter" );
	clientfield::register( "toplayer", "zapgundw_fired", VERSION_DLC5, 1, "counter" );
	clientfield::register( "toplayer", "zapgunlh_fired", VERSION_DLC5, 1, "counter" );

	zm_spawner::register_zombie_damage_callback( &microwavegun_zombie_damage_response );
	zm_spawner::register_zombie_death_animscript_callback( &microwavegun_zombie_death_response );

	zombie_utility::set_zombie_var( "microwavegun_cylinder_radius", 180 );
	zombie_utility::set_zombie_var( "microwavegun_sizzle_range", 480 );

	level._effect["microwavegun_zap_shock_dw"] = "dlc5/zmb_weapon/fx_zap_shock_dw";
	level._effect["microwavegun_zap_shock_eyes_dw"] = "dlc5/zmb_weapon/fx_zap_shock_eyes_dw";
	level._effect["microwavegun_zap_shock_lh"] = "dlc5/zmb_weapon/fx_zap_shock_lh";
	level._effect["microwavegun_zap_shock_eyes_lh"] = "dlc5/zmb_weapon/fx_zap_shock_eyes_lh";
	level._effect["microwavegun_zap_shock_ug"] = "dlc5/zmb_weapon/fx_zap_shock_ug";
	level._effect["microwavegun_zap_shock_eyes_ug"] = "dlc5/zmb_weapon/fx_zap_shock_eyes_ug";

	animationstatenetwork::registernotetrackhandlerfunction( "expand", &handle_wavegun_expand_notetrack );
	animationstatenetwork::registernotetrackhandlerfunction( "explode", &handle_wavegun_explode_notetrack );

	level._microwaveable_objects = [];

	level.w_microwavegun = GetWeapon( "microwavegun" );
	level.w_microwavegun_upgraded = GetWeapon( "microwavegun_upgraded" );
	level.w_microwavegundw = GetWeapon( "microwavegundw" );
	level.w_microwavegundw_upgraded = GetWeapon( "microwavegundw_upgraded" );

	callback::on_connect( &on_player_connect );
	callback::on_spawned( &on_player_spawned );
}

function on_player_connect()
{
	self thread wait_for_microwavegun_fired();
}

function on_player_spawned()
{
	self thread monitor_wavegun_status();
}

function monitor_wavegun_status()
{
	self notify( "monitor_wavegun_status" );
	self endon( "monitor_wavegun_status" );
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( "weapon_give", weapon );
		weapon = zm_weapons::get_nonalternate_weapon( weapon );

		if( weapon == level.w_microwavegundw || weapon == level.w_microwavegundw_upgraded )
		{
			self clientfield::set_player_uimodel( "hudItems.showDpadLeft_WaveGun", 1 );
			self.has_upgraded_wavegun = zm_weapons::is_weapon_upgraded( weapon );
			self thread monitor_wavegun_ammo_hud();
		}

		else if( !self zm_weapons::has_weapon_or_upgrade( level.w_microwavegundw ) )
		{
			self clientfield::set_player_uimodel( "hudItems.showDpadLeft_WaveGun", 0 );
			self clientfield::set_player_uimodel( "hudItems.dpadLeftAmmo", 0 );
			self notify( "stop_wavegun_ammo_monitor" );
			self.has_upgraded_wavegun = undefined;
		}
	}
}

function monitor_wavegun_ammo_hud()
{
	self notify( "monitor_wavegun_ammo" );
	self endon( "monitor_wavegun_ammo" );
	self endon( "stop_wavegun_ammo_monitor" );
	self endon( "disconnect" );

	for(;;)
	{
		if( isdefined( self.has_upgraded_wavegun ) )
		{
			if( self.has_upgraded_wavegun )
			{
				ammocount = self GetAmmoCount( level.w_microwavegun_upgraded );
			}
			else
			{
				ammocount = self GetAmmoCount( level.w_microwavegun );
			}
			self clientfield::set_player_uimodel( "hudItems.dpadLeftAmmo", ammocount );
		}
		else
		{
			self clientfield::set_player_uimodel( "hudItems.dpadLeftAmmo", 0 );
		}
		wait 0.05;
	}
}

function add_microwaveable_object( entity )
{
	array::add(level._microwaveable_objects, entity, 0);
}

function remove_microwaveable_object( entity )
{
	ArrayRemoveValue( level._microwaveable_objects, entity );
}

function wait_for_microwavegun_fired()
{
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( "missile_fire", projectile, weapon );
		switch( weapon.name )
		{
			case "microwavegun":
			case "microwavegun_upgraded":
				self clientfield::increment_to_player( "wavegun_fired" );
				self thread wavegun_trail_fx( projectile, "wavegun_trail", 1, -1, 1000 );
				self thread microwavegun_fired( weapon == level.w_microwavegun_upgraded );
				break;

			case "microwavegundw":
			case "microwavegundw_upgraded":
				self clientfield::increment_to_player( "zapgundw_fired" );
				self thread wavegun_trail_fx( projectile, "zapgun_trail", 12, -3, 4200 );
				break;

			case "microwavegunlh":
			case "microwavegunlh_upgraded":
				self clientfield::increment_to_player( "zapgunlh_fired" );
				self thread wavegun_trail_fx( projectile, "zapgun_trail", -12, -3, 4200 );
				break;
		}
	}
}

function wavegun_trail_fx( projectile, cf_name, right_offset, up_offset, speed )
{
    if( !isdefined( projectile ) )
    {
    	return;
    }

    muzzle_point = self GetWeaponMuzzlePoint();
    v_player_ang = self GetPlayerAngles();
    
    v_right = AnglesToRight( v_player_ang );
    v_start_offset = VectorScale( v_right, right_offset );
    v_start = muzzle_point + v_start_offset + ( 0, 0, up_offset );

    fxorg = Spawn( "script_model", v_start );
    fxorg SetModel( "tag_origin" );
    fxorg clientfield::set( cf_name, 1 );

    v_fwd = AnglesToForward( v_player_ang );
    v_end_offset = VectorScale( v_fwd, speed );
    v_end = projectile.origin + v_end_offset;
    
    fxorg MoveTo( v_end, 2 ); 

    result = projectile util::waittill_any_timeout( 2, "death" );
    if( result != "timeout" )
    {
    	PlayFX( level._effect["wavegun_impact"], projectile.origin );
    }

    if( isdefined( fxorg ) )
    {
    	fxorg clientfield::set( cf_name, 0 );
	    waittillframeend;
	    fxorg Delete();
    }
}

function microwavegun_fired( upgraded )
{
	if( !isdefined( level.microwavegun_sizzle_enemies ) )
	{
		level.microwavegun_sizzle_enemies = [];
		level.microwavegun_sizzle_vecs = [];
	}
	self microwavegun_get_enemies_in_range( upgraded, 0 );
	self microwavegun_get_enemies_in_range( upgraded, 1 );
	level.microwavegun_network_choke_count = 0;
	for( i = 0; i < level.microwavegun_sizzle_enemies.size; i++ )
	{
		microwavegun_network_choke();
		level.microwavegun_sizzle_enemies[i] thread microwavegun_sizzle_zombie( self, level.microwavegun_sizzle_vecs[i], i );
	}
	level.microwavegun_sizzle_enemies = [];
	level.microwavegun_sizzle_vecs = [];
}

function microwavegun_network_choke()
{
	level.microwavegun_network_choke_count++;
	if( !level.microwavegun_network_choke_count % 10 )
	{
		util::wait_network_frame(3);
	}
}

function microwavegun_get_enemies_in_range( upgraded, microwaveable_objects )
{
	view_pos = self GetWeaponMuzzlePoint();
	test_list = [];
	range = level.zombie_vars["microwavegun_sizzle_range"];
	cylinder_radius = level.zombie_vars["microwavegun_cylinder_radius"];
	if( microwaveable_objects )
	{
		test_list = level._microwaveable_objects;
		range *= 10;
		cylinder_radius *= 10;
	}
	else
	{
		test_list = zombie_utility::get_round_enemy_array();
	}
	zombies = util::get_array_of_closest( view_pos, test_list, undefined, undefined, range );
	if( !isdefined( zombies ) )
	{
		return;
	}
	sizzle_range_squared = SQR( range );
	cylinder_radius_squared = SQR( cylinder_radius );
	forward_view_angles = self GetWeaponForwardDir();
	end_pos = view_pos + VectorScale( forward_view_angles, range );
	for( i = 0; i < zombies.size; i++ )
	{
		if( !isdefined( zombies[i] ) || ( IsAI( zombies[i] ) && !IsAlive( zombies[i] ) ) )
		{
			continue;
		}
		test_origin = zombies[i] GetCentroid();
		test_range_squared = DistanceSquared( view_pos, test_origin );
		if( test_range_squared > sizzle_range_squared )
		{
			return;
		}
		normal = VectorNormalize( test_origin - view_pos );
		dot = VectorDot( forward_view_angles, normal );
		if( 0 > dot )
		{
			continue;
		}
		radial_origin = PointOnSegmentNearestToPoint( view_pos, end_pos, test_origin );
		if( DistanceSquared( test_origin, radial_origin ) > cylinder_radius_squared )
		{
			continue;
		}
		if( 0 == zombies[i] DamageConeTrace( view_pos, self ) )
		{
			continue;
		}
		if( IsAI( zombies[i] ) )
		{
			level.microwavegun_sizzle_enemies[level.microwavegun_sizzle_enemies.size] = zombies[i];
			dist_mult = ( sizzle_range_squared - test_range_squared ) / sizzle_range_squared;
			sizzle_vec = VectorNormalize( test_origin - view_pos );
			if( 5000 < test_range_squared )
			{
				sizzle_vec = sizzle_vec + ( VectorNormalize( test_origin - radial_origin ) );
			}
			sizzle_vec = ( sizzle_vec[0], sizzle_vec[1], Abs( sizzle_vec[2] ) );
			sizzle_vec = VectorScale( sizzle_vec, 100 + ( 100 * dist_mult ) );
			level.microwavegun_sizzle_vecs[level.microwavegun_sizzle_vecs.size] = sizzle_vec;
			continue;
		}
		zombies[i] notify( "microwaved", self );
	}
}

function microwavegun_sizzle_zombie( player, sizzle_vec, index )
{
	if( !isdefined( self ) || !IsAlive( self ) )
	{
		return;
	}
	if( IsFunctionPtr( self.microwavegun_sizzle_func ) )
	{
		self [[ self.microwavegun_sizzle_func ]]( player );
		return;
	}
	self.no_gib = 1;
	self.gibbed = 1;
	self.skipautoragdoll = 1;
	self.microwavegun_death = 1;
	self DoDamage( self.health + 666, player.origin, player );
	if( self.health <= 0 )
	{
		points = 10;
		if( !index )
		{
			points = zm_score::get_zombie_death_player_points();
		}
		else if( 1 == index )
		{
			points = 30;
		}
		player zm_score::player_add_points( "thundergun_fling", points );
		instant_explode = 0;
		if( self.isdog )
		{
			self.a.nodeath = undefined;
			instant_explode = 1;
		}
		if( IS_TRUE( self.is_traversing ) || IS_TRUE( self.in_the_ceiling ) )
		{
			self.deathanim = undefined;
			instant_explode = 1;
		}
		if( instant_explode )
		{
			if( self.animname !== "astro_zombie" )
			{
				self thread setup_microwavegun_vox( player );
			}
			self clientfield::set( "toggle_microwavegun_expand_response", 1 );
			self thread microwavegun_sizzle_death_ending();
		}
		else
		{
			if( self.animname !== "astro_zombie" )
			{
				self thread setup_microwavegun_vox( player, 6 );
			}
			self clientfield::set( "toggle_microwavegun_hit_response", 1 );
			self.nodeathragdoll = 1;
			self.handle_death_notetracks = &microwavegun_handle_death_notetracks;
		}
	}
}

function microwavegun_handle_death_notetracks( note )
{
	if( note == "expand" )
	{
		self clientfield::set( "toggle_microwavegun_expand_response", 1 );
	}
	else if( note == "explode" )
	{
		self clientfield::set( "toggle_microwavegun_expand_response", 0 );
		self thread microwavegun_sizzle_death_ending();
	}
}

function microwavegun_sizzle_death_ending()
{
	if( !isdefined( self ) )
	{
		return;
	}
	self Ghost();
	wait 0.1;
	self zm_utility::self_delete();
}

function microwavegun_dw_zombie_hit_response_internal( mod, damageweapon, player )
{
	player endon( "disconnect" );
	if( !isdefined( self ) || !IsAlive( self ) )
	{
		return;
	}
	if( self.isdog )
	{
		self.a.nodeath = undefined;
	}
	if( IS_TRUE( self.is_traversing ) )
	{
		self.deathanim = undefined;
	}
	self.skipautoragdoll = 1;
	self.microwavegun_dw_death = 1;
	self thread microwavegun_zap_death_fx( damageweapon );
	if( IsFunctionPtr( self.microwavegun_zap_damage_func ) )
	{
		self [[ self.microwavegun_zap_damage_func ]]( player );
		return;
	}
	self DoDamage( self.health + 666, self.origin, player );
	player zm_score::player_add_points( "death", "", "" );
	if( RandomInt(101) >= 75 )
	{
		player thread zm_audio::create_and_play_dialog( "kill", "micro_dual" );
	}
}

function microwavegun_zap_get_shock_fx( weapon )
{
	if( weapon == GetWeapon( "microwavegundw" ) )
	{
		return level._effect["microwavegun_zap_shock_dw"];
	}
	if( weapon == GetWeapon( "microwavegunlh" ) )
	{
		return level._effect["microwavegun_zap_shock_lh"];
	}
	return level._effect["microwavegun_zap_shock_ug"];
}

function microwavegun_zap_get_shock_eyes_fx( weapon )
{
	if( weapon == GetWeapon( "microwavegundw" ) )
	{
		return level._effect["microwavegun_zap_shock_eyes_dw"];
	}
	if( weapon == GetWeapon( "microwavegunlh" ) )
	{
		return level._effect["microwavegun_zap_shock_eyes_lh"];
	}
	return level._effect["microwavegun_zap_shock_eyes_ug"];
}

function microwavegun_zap_head_gib( weapon )
{
	self endon( "death" );
	zm_net::network_safe_play_fx_on_tag( "microwavegun_zap_death_fx", 2, microwavegun_zap_get_shock_eyes_fx( weapon ), self, "J_Eyeball_LE" );
}

function microwavegun_zap_death_fx( weapon )
{
	zm_net::network_safe_play_fx_on_tag( "microwavegun_zap_death_fx", 2, microwavegun_zap_get_shock_fx( weapon ), self, ( self.isdog ? "J_Spine1" : "J_SpineUpper" ) );
	self PlaySound( "wpn_imp_tesla" );
	if( IS_TRUE( self.head_gibbed ) )
	{
		return;
	}
	if( IsFunctionPtr( self.microwavegun_zap_head_gib_func ) )
	{
		self thread [[ self.microwavegun_zap_head_gib_func ]]( weapon );
	}
	else if( self.animname !== "quad_zombie" )
	{
		self thread microwavegun_zap_head_gib( weapon );
	}
}

function microwavegun_zombie_damage_response( str_mod, str_hit_location, v_hit_origin, e_attacker, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel )
{
	if( self is_microwavegun_dw_damage() )
	{
		self thread microwavegun_dw_zombie_hit_response_internal( str_mod, self.damageweapon, e_attacker );
		return true;
	}
	return false;
}

function microwavegun_zombie_death_response()
{
	if( self enemy_killed_by_dw_microwavegun() )
	{
		if( isdefined( self.attacker ) && IsFunctionPtr( level.hero_power_update ) )
		{
			level thread [[ level.hero_power_update ]]( self.attacker, self );
		}
		return true;
	}
	if( self enemy_killed_by_microwavegun() )
	{
		if( isdefined( self.attacker ) && IsFunctionPtr( level.hero_power_update ) )
		{
			level thread [[ level.hero_power_update ]]( self.attacker, self );
		}
		return true;
	}
	return false;
}

function is_microwavegun_dw_damage()
{
	return isdefined( self.damageweapon ) && IsInArray( array( "microwavegundw", "microwavegundw_upgraded", "microwavegunlh", "microwavegunlh_upgraded" ), self.damageweapon.name ) && self.damagemod == "MOD_IMPACT";
}

function enemy_killed_by_dw_microwavegun()
{
	return IS_TRUE( self.microwavegun_dw_death );
}

function is_microwavegun_damage()
{
	return isdefined( self.damageweapon ) && ( self.damageweapon == level.w_microwavegun || self.damageweapon == level.w_microwavegun_upgraded ) && ( self.damagemod != "MOD_GRENADE" && self.damagemod != "MOD_GRENADE_SPLASH" );
}

function enemy_killed_by_microwavegun()
{
	return IS_TRUE( self.microwavegun_death );
}

function microwavegun_sound_thread()
{
	self endon( "disconnect" );
	self waittill( "spawned_player" );
	for(;;)
	{
		result = self util::waittill_any_return( "grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback" );
		if( !isdefined( result ) )
		{
			continue;
		}
		if( result == "weapon_change" || result == "grenade_fire" && self GetCurrentWeapon() == level.w_microwavegun )
		{
			self PlayLoopSound( "tesla_idle", 0.25 );
			continue;
		}
		self notify( "weap_away" );
		self StopLoopSound(0.25);
	}
}

function setup_microwavegun_vox( player, waittime = 0.05 )
{
	level notify( "force_end_microwave_vox" );
	level endon( "force_end_microwave_vox" );
	wait waittime;
	if( isdefined( player ) && RandomInt(100) < 50 )
	{
		player thread zm_audio::create_and_play_dialog( "kill", "micro_single" );
	}
}

function handle_wavegun_expand_notetrack( entity )
{
	self clientfield::set( "toggle_microwavegun_expand_response", 1 );
}

function handle_wavegun_explode_notetrack( entity )
{
	self clientfield::set( "toggle_microwavegun_expand_response", 0 );
	self thread microwavegun_sizzle_death_ending();
}