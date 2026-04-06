#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared; 
#using scripts\shared\ai\zombie_utility;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_weap_thundergun.gsh;

#precache( "fx", STR_KNOCKBACK_GROUND );
#precache( "fx", STR_SMOKE_CLOUD );

#namespace zm_weap_thundergun;

REGISTER_SYSTEM_EX( "zm_weap_thundergun", &__init__, &__main__, undefined )

function __init__()
{
	level.weaponZMThunderGun = GetWeapon( "thundergun" );
	level.weaponZMThunderGunUpgraded = GetWeapon( "thundergun_upgraded" );
	if( level.script != "zm_temple" )
	{
		clientfield::register( "scriptmover", "thundergun_trail", VERSION_SHIP, 1, "int" );
	}
}
	
function __main__()
{
	level._effect["thundergun_knockdown_ground"]	= STR_KNOCKBACK_GROUND;
	level._effect["thundergun_smoke_cloud"]			= STR_SMOKE_CLOUD;

	zombie_utility::set_zombie_var( "thundergun_cylinder_radius",		180 );
	zombie_utility::set_zombie_var( "thundergun_fling_range",			480 );
	zombie_utility::set_zombie_var( "thundergun_gib_range",				900 );
	zombie_utility::set_zombie_var( "thundergun_gib_damage",			75 );
	zombie_utility::set_zombie_var( "thundergun_knockdown_range",		1200 );
	zombie_utility::set_zombie_var( "thundergun_knockdown_damage",		15 );

	level.thundergun_gib_refs = []; 
	level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "guts"; 
	level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "right_arm"; 
	level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "left_arm"; 

	level.basic_zombie_thundergun_knockdown = &zombie_knockdown;
	
	DEFAULT(level.override_thundergun_damage_func, &override_thundergun_damage_func);
	
	callback::on_spawned( &wait_for_thundergun_fired );
}

function wait_for_thundergun_fired()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );

	for(;;)
	{
		self waittill( "missile_fire", missile, weapon );

		if( weapon == level.weaponZMThunderGun || weapon == level.weaponZMThunderGunUpgraded )
		{
			self thread tgun_trail_fx( missile );
			self thread thundergun_fired();

			view_pos = self GetTagOrigin( "tag_flash" ) - self GetPlayerViewHeight();
			view_angles = self GetTagAngles( "tag_flash" );

			n_ammo = self GetWeaponAmmoClip( weapon );
			if( n_ammo <= 0 )
			{
				PlayFXOnTag( level._effect["tgun_steam"], self, "tag_brass" );
			}
			PlayFX( level._effect["thundergun_smoke_cloud"], view_pos, AnglesToForward( view_angles ), AnglesToUp( view_angles ) );
		}
	}
}

function tgun_trail_fx( projectile )
{
    if( !isdefined( projectile ) )
    {
    	return;
    }

    fxorg = util::spawn_model( "tag_origin", projectile.origin, projectile.angles );
    fxorg LinkTo( projectile );
    fxorg clientfield::set( "thundergun_trail", 1 ); 

    projectile util::waittill_any_timeout( 2, "death" );
    fxorg Unlink();
    if( isdefined( fxorg ) )
    {
        fxorg clientfield::set( "thundergun_trail", 0 );
        wait 0.1; 
        fxorg Delete();
    }
}

function thundergun_network_choke()
{
	level.thundergun_network_choke_count++;
	
	if( !( level.thundergun_network_choke_count % 10 ) )
	{
		util::wait_network_frame(3);
	}
}

function thundergun_fired()
{
	PhysicsExplosionCylinder( self.origin, 600, 240, 1 );
	self thread thundergun_affect_ais();
}

function thundergun_affect_ais()
{
	if( !isdefined( level.thundergun_knockdown_enemies ) )
	{
		level.thundergun_knockdown_enemies = [];
		level.thundergun_knockdown_gib = [];
		level.thundergun_fling_enemies = [];
		level.thundergun_fling_vecs = [];
	}

	self thundergun_get_enemies_in_range();

	level.thundergun_network_choke_count = 0;
	for( i = 0; i < level.thundergun_fling_enemies.size; i++ )
	{		
		level.thundergun_fling_enemies[i] thread thundergun_fling_zombie( self, level.thundergun_fling_vecs[i], i );
	}

	for( i = 0; i < level.thundergun_knockdown_enemies.size; i++ )
	{		
		level.thundergun_knockdown_enemies[i] thread thundergun_knockdown_zombie( self, level.thundergun_knockdown_gib[i] );
	}

	level.thundergun_knockdown_enemies = [];
	level.thundergun_knockdown_gib = [];
	level.thundergun_fling_enemies = [];
	level.thundergun_fling_vecs = [];
}

function thundergun_get_enemies_in_range()
{
	view_pos = self GetWeaponMuzzlePoint();
	zombies = array::get_all_closest( view_pos, GetAITeamArray( level.zombie_team ), undefined, undefined, level.zombie_vars["thundergun_knockdown_range"] );
	
	if ( !isdefined( zombies ) )
	{
		return;
	}

	knockdown_range_squared = level.zombie_vars["thundergun_knockdown_range"] * level.zombie_vars["thundergun_knockdown_range"];
	gib_range_squared = level.zombie_vars["thundergun_gib_range"] * level.zombie_vars["thundergun_gib_range"];
	fling_range_squared = level.zombie_vars["thundergun_fling_range"] * level.zombie_vars["thundergun_fling_range"];
	cylinder_radius_squared = level.zombie_vars["thundergun_cylinder_radius"] * level.zombie_vars["thundergun_cylinder_radius"];

	forward_view_angles = self GetWeaponForwardDir();
	end_pos = view_pos + VectorScale( forward_view_angles, level.zombie_vars["thundergun_knockdown_range"] );

	for( i = 0; i < zombies.size; i++ )
	{
		if( !isdefined( zombies[i] ) || !IsAlive( zombies[i] ) )
		{
			continue;
		}

		test_origin = zombies[i] GetCentroid();
		test_range_squared = DistanceSquared( view_pos, test_origin );
		if( test_range_squared > knockdown_range_squared )
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

		if( test_range_squared < fling_range_squared )
		{
			level.thundergun_fling_enemies[level.thundergun_fling_enemies.size] = zombies[i];

			dist_mult = ( fling_range_squared - test_range_squared ) / fling_range_squared;
			fling_vec = VectorNormalize( test_origin - view_pos );

			if( 5000 < test_range_squared )
			{
				fling_vec = fling_vec + VectorNormalize( test_origin - radial_origin );
			}

			fling_vec = ( fling_vec[0], fling_vec[1], Abs( fling_vec[2] ) );
			fling_vec = VectorScale( fling_vec, 100 + 100 * dist_mult );

			level.thundergun_fling_vecs[level.thundergun_fling_vecs.size] = fling_vec;

			zombies[i] thread setup_thundergun_vox( self, true, false, false );
		}

		else if( test_range_squared < gib_range_squared )
		{
			level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
			level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = true;

			zombies[i] thread setup_thundergun_vox( self, false, true, false );
		}

		else
		{
			level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
			level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = false;

			zombies[i] thread setup_thundergun_vox( self, false, false, true );
		}
	}
}

function thundergun_fling_zombie( player, fling_vec, index )
{
	if( !isdefined( self ) || !IsAlive( self ) )
	{
		return;
	}

	if( IsFunctionPtr( self.thundergun_fling_func ) )
	{
		self [[ self.thundergun_fling_func ]]( player );
		return;
	}
	
	self.deathpoints_already_given = true;
	self DoDamage( self.health + 666, player.origin, player );

	if( self.health <= 0 )
	{
		if( isdefined( player ) && IsFunctionPtr( level.hero_power_update ) )
		{
			level thread [[ level.hero_power_update ]]( player, self );
		}
		
		points = 10;
		if( !index )
		{
			points = zm_score::get_zombie_death_player_points();
		}

		else if ( 1 == index )
		{
			points = 30;
		}
		player zm_score::player_add_points( "thundergun_fling", points );
		
		self StartRagdoll();
		self LaunchRagdoll( fling_vec );

		self.thundergun_death = true;
	}
}

function zombie_knockdown( player, gib )
{
	if( gib && !self.gibbed )
	{
		self.a.gib_ref = array::random( level.thundergun_gib_refs );
		self thread zombie_death::do_gib();
	}

	if( IsFunctionPtr( level.override_thundergun_damage_func ) )
	{
		self [[ level.override_thundergun_damage_func ]]( player, gib );
	}

	else
	{
		damage = level.zombie_vars["thundergun_knockdown_damage"];
		self PlaySound( "fly_thundergun_forcehit" );
		self.thundergun_handle_pain_notetracks = &handle_thundergun_pain_notetracks;
		self DoDamage( damage, player.origin, player );
		self AnimCustom( &playThundergunPainAnim );
	}
}

function playThundergunPainAnim()
{
	self notify( "end_play_thundergun_pain_anim" );	
	self endon( "killanimscript" );
	self endon( "death" );
	self endon( "end_play_thundergun_pain_anim" );

	if( IS_TRUE( self.marked_for_death ) )
	{
		return;
	}	

	if( self.damageYaw <= -135 || self.damageYaw >= 135 )
	{
		fallAnim = ( self.missingLegs ? "zm_thundergun_fall_front_crawl" : "zm_thundergun_fall_front" );
		getupAnim = "zm_thundergun_getup_belly_early";
	}

	else if( self.damageYaw > -135 && self.damageYaw < -45 )
	{
		fallAnim = "zm_thundergun_fall_left";
		getupAnim = "zm_thundergun_getup_belly_early";
	}

	else if( self.damageYaw > 45 && self.damageYaw < 135 )
	{
		fallAnim = "zm_thundergun_fall_right";
		getupAnim = "zm_thundergun_getup_belly_early";
	}

	else
	{
		fallAnim = "zm_thundergun_fall_back";
		getupAnim = ( RandomInt(100) < 50 ? "zm_thundergun_getup_back_early" : "zm_thundergun_getup_back_late" );
	}

	self SetAnimStateFromASD( fallAnim );
	self zombie_shared::DoNoteTracks( "thundergun_fall_anim", self.thundergun_handle_pain_notetracks );

	if( !isdefined( self ) || !IsAlive( self ) || self.missingLegs || IS_TRUE( self.marked_for_death ) )
	{
		return;
	}	
		
	self SetAnimStateFromASD( getupAnim );
	self zombie_shared::DoNoteTracks( "thundergun_getup_anim" );
}

function thundergun_knockdown_zombie( player, gib )
{
	self endon( "death" );
	PlaySoundAtPosition( "wpn_thundergun_proj_impact", self.origin );

	if( !isdefined( self ) || !IsAlive( self ) )
	{
		return;
	}

	if( IsFunctionPtr( self.thundergun_knockdown_func ) )
	{
		self [[ self.thundergun_knockdown_func ]]( player, gib );
	}
}


function handle_thundergun_pain_notetracks( note )
{
	if( note == "zombie_knockdown_ground_impact" )
	{
		PlayFX( level._effect["thundergun_knockdown_ground"], self.origin, AnglesToForward( self.angles ), AnglesToUp( self.angles ) );
		self PlaySound( "fly_thundergun_forcehit" );
	}
}

function is_thundergun_damage()
{
	return( self.damageweapon == level.weaponZMThunderGun || self.damageweapon == level.weaponZMThunderGunUpgraded ) && ( self.damagemod != "MOD_GRENADE" && self.damagemod != "MOD_GRENADE_SPLASH" );
}

function enemy_killed_by_thundergun()
{
	return IS_TRUE( self.thundergun_death );
}

function thundergun_sound_thread()
{
	self endon( "disconnect" );
	self waittill( "spawned_player" ); 

	for(;;)
	{
		result = self util::waittill_any_return( "grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback", "disconnect" );

		if( !isdefined( result ) )
		{
			continue;
		}

		if( ( result == "weapon_change" || result == "grenade_fire" ) && self GetCurrentWeapon() == level.weaponZMThunderGun )
		{
			self PlayLoopSound( "tesla_idle", 0.25 );

		}

		else
		{
			self notify( "weap_away" );
			self StopLoopSound( 0.25 );
		}
	}
}

function setup_thundergun_vox( player, fling, gib, knockdown )
{
	if( !isdefined( self ) || !IsAlive( self ) )
	{
		return;
	}
	
	if( fling )
	{
		if( 30 > RandomIntRange( 1, 100 ) )
		{
			player zm_audio::create_and_play_dialog( "kill", "thundergun" );
		}
	}
}

function override_thundergun_damage_func(player,gib)
{
	self zombie_utility::setup_zombie_knockdown( player ); 
}