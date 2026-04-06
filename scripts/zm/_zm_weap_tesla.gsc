#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\util_shared;
#using scripts\shared\ai\zombie_utility;

#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_tesla;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;

function init()
{
	level.weaponZMTeslaGun = GetWeapon( "tesla_gun" );
	level.weaponZMTeslaGunUpgraded = GetWeapon( "tesla_gun_upgraded" );

	if( !zm_weapons::is_weapon_included( level.weaponZMTeslaGun ) && !IS_TRUE( level.uses_tesla_powerup ) )
	{
		return;
	}

	level._effect["tesla_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
	
	zm::register_zombie_damage_override_callback( &tesla_zombie_damage_response );
	zm_spawner::register_zombie_death_animscript_callback( &tesla_zombie_death_response );
	
	zombie_utility::set_zombie_var( "tesla_max_arcs",			5 );
	zombie_utility::set_zombie_var( "tesla_max_enemies_killed", 10 );
	zombie_utility::set_zombie_var( "tesla_radius_start",		300 );
	zombie_utility::set_zombie_var( "tesla_radius_decay",		20 );
	zombie_utility::set_zombie_var( "tesla_head_gib_chance",	75 );
	zombie_utility::set_zombie_var( "tesla_arc_travel_time",	0.11, true );
	zombie_utility::set_zombie_var( "tesla_kills_for_powerup",	10 );
	zombie_utility::set_zombie_var( "tesla_min_fx_distance",	128 );
	zombie_utility::set_zombie_var( "tesla_network_death_choke", 4 );
	
	level.tesla_lightning_params = lightning_chain::create_lightning_chain_params(
		level.zombie_vars["tesla_max_arcs"],
		level.zombie_vars["tesla_max_enemies_killed"],
		level.zombie_vars["tesla_radius_start"],
		level.zombie_vars["tesla_radius_decay"],
		level.zombie_vars["tesla_head_gib_chance"],
		level.zombie_vars["tesla_arc_travel_time"],
		level.zombie_vars["tesla_kills_for_powerup"],
		level.zombie_vars["tesla_min_fx_distance"],
		level.zombie_vars["tesla_network_death_choke"],
		undefined,
		undefined,
		"wpn_tesla_bounce"
	);

	callback::on_spawned( &on_player_spawned );
}

function tesla_damage_init( hit_location, hit_origin, player )
{
	player endon( "disconnect" );

	if( IS_TRUE( player.tesla_firing ) )
	{
		return;
	}

	if( IS_TRUE( self.zombie_tesla_hit ) )
	{
		return;
	}

	player.tesla_enemies = undefined;
	player.tesla_enemies_hit = 1;
	player.tesla_powerup_dropped = false;
	player.tesla_arc_count = 0;
	player.tesla_firing = 1;
	
	self lightning_chain::arc_damage( self, player, 1, level.tesla_lightning_params );
	
	if( player.tesla_enemies_hit >= 4 )
	{
		player thread tesla_killstreak_sound();
	}

	player.tesla_enemies_hit = 0;
	player.tesla_firing = 0;
}

function is_tesla_damage( mod, weapon )
{
	return( ( weapon == level.weaponZMTeslaGun || weapon == level.weaponZMTeslaGunUpgraded ) && ( mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" ) );
}

function enemy_killed_by_tesla()
{
	return IS_TRUE( self.tesla_death );
}

function on_player_spawned()
{
	self thread tesla_sound_thread(); 
	self thread tesla_pvp_thread();
	self thread tesla_network_choke();
	self thread tesla_fired_response();
	self thread tesla_impact_response();
}

function tesla_sound_thread()
{
	self endon( "disconnect" );
			
	for(;;)
	{
		result = self util::waittill_any_return( "grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback", "disconnect" );

		if( !isdefined( result ) )
		{
			continue;
		}

		if( ( result == "weapon_change" || result == "grenade_fire" ) && ( self GetCurrentWeapon() == level.weaponZMTeslaGun || self GetCurrentWeapon() == level.weaponZMTeslaGunUpgraded ) )
		{
			if( !isdefined( self.tesla_loop_sound ) )
			{
				self.tesla_loop_sound = Spawn( "script_origin", self.origin );
				self.tesla_loop_sound LinkTo( self );
				self thread cleanup_loop_sound( self.tesla_loop_sound );
			}
			self.tesla_loop_sound PlayLoopSound( "wpn_tesla_idle", 0.25 );
			self thread tesla_engine_sweets();

		}

		else
		{
			self notify( "weap_away" );
			if( isdefined( self.tesla_loop_sound ) )
			{
				self.tesla_loop_sound StopLoopSound( 0.25 );
			}
		}
	}
}

function cleanup_loop_sound( loop_sound )
{
	self waittill( "disconnect" );

	if( isdefined( loop_sound ) )
	{
		loop_sound Delete();
	}
}


function tesla_engine_sweets()
{
	self endon( "disconnect" ); 
	self endon( "weap_away" );

	for(;;)
	{
		wait RandomIntRange( 7, 15 );
		self play_tesla_sound( "wpn_tesla_sweeps_idle" );
	}
}

function tesla_pvp_thread()
{
	self endon( "disconnect" );
	self endon( "death" );

	for(;;)
	{
		self waittill( "weapon_pvp_attack", attacker, weapon, damage, mod );

		if( self laststand::player_is_in_laststand() )
		{
			continue;
		}

		if( weapon != level.weaponZMTeslaGun && weapon != level.weaponZMTeslaGunUpgraded )
		{
			continue;
		}

		if( mod != "MOD_PROJECTILE" && mod != "MOD_PROJECTILE_SPLASH" )
		{
			continue;
		}

		if( self == attacker )
		{
			damage = Int( self.maxhealth * 0.25 );
			if( damage < 25 )
			{
				damage = 25;
			}

			if( self.health - damage < 1 )
			{
				self.health = 1;
			}

			else
			{
				self.health -= damage;
			}
		}

		self SetElectrified( 1.0 );	
		self ShellShock( "electrocution", 1.0 );
		self PlaySound( "wpn_tesla_bounce" );
	}
}
function play_tesla_sound( emotion )
{
	self endon( "disconnect" );

	if( !isdefined( level.one_emo_at_a_time ) )
	{
		level.one_emo_at_a_time = 0;
		level.var_counter = 0;	
	}

	if( level.one_emo_at_a_time == 0 )
	{
		level.var_counter++;
		level.one_emo_at_a_time = 1;

		org = Spawn( "script_origin", self.origin );
		org LinkTo( self );
		org PlaySoundWithNotify( emotion, "sound_complete_" + level.var_counter );
		org waittill( "sound_complete_" + level.var_counter );
		org Delete();
		level.one_emo_at_a_time = 0;
	}		
}

function tesla_killstreak_sound()
{
	self endon( "disconnect" );

	self zm_audio::create_and_play_dialog( "kill", "tesla" );	
	wait 3.5;
	level util::clientNotify( "TGH" );
}

function tesla_network_choke()
{
	self endon( "disconnect" );
	self endon( "death" );

	self.tesla_network_death_choke = 0;

	for(;;)
	{
		util::wait_network_frame(2);
		self.tesla_network_death_choke = 0;
	}
}

function tesla_zombie_death_response()
{
	return self enemy_killed_by_tesla();
}

function tesla_zombie_damage_response( willBeKilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, sHitLoc, psOffsetTime, boneIndex, surfaceType )
{
	if( self is_tesla_damage( meansofdeath, weapon ) )
	{
		self thread tesla_damage_init( sHitLoc, vpoint, attacker );
		return true;
	}
	return false;
}

function tesla_fired_response()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );

	for(;;)
	{
		self waittill( "missile_fire", projectile, weapon );
		if( StrStartsWith( weapon.rootweapon.name, "tesla_gun" ) )
		{
			self thread tesla_trail( projectile );
		}
	}
}

function tesla_trail( projectile )
{
	fxorg = util::spawn_model( "tag_origin", projectile.origin, projectile.angles );
	trail = PlayFXOnTag( level get_fx_path( "tesla_trail" ), fxorg, "tag_origin" );
	fxorg LinkTo( projectile );

	self util::waittill_any_timeout( 1.5, "projectile_impact" );

	fxorg Unlink();
	waittillframeend;
	
	if( isdefined( trail ) ) trail Delete();
	if( isdefined( fxorg ) ) fxorg Delete();
}

function tesla_impact_response()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );

	for(;;)
	{
		self waittill( "projectile_impact", weapon, point );
		if( isdefined( weapon ) && StrStartsWith( weapon.name, "tesla_gun" ) )
		{
			PlayFX( level get_fx_path( "tesla_impact" ), point );
		}
	}
}

function get_fx_path( key )
{
	return( isdefined( self._effect ) && isdefined( self._effect[key] ) ? self._effect[key] : ( isdefined( level._effect ) && isdefined( level._effect[key] ) ? level._effect[key] : undefined ) );
}