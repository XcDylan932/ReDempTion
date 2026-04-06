#using scripts\codescripts\struct;

#using scripts\shared\ai\zombie_vortex;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\visionset_mgr_shared;

#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;

#namespace idgun;

REGISTER_SYSTEM_EX( "idgun", &__init__, &__main__, undefined )

function __init__()
{
	callback::on_connect( &function_2bd571b9 );
	callback::on_spawned( &wait_for_idgun_fired );
	zm::register_player_damage_callback( &function_b618ee82 );
}

function __main__()
{
	if( !isdefined( level.idgun_weapons ) )
	{
		if( !isdefined( level.idgun_weapons ) )
		{
			level.idgun_weapons = [];
		}

		else if( !IsArray( level.idgun_weapons ) )
		{
			level.idgun_weapons = array( level.idgun_weapons );
		}

		level.idgun_weapons[level.idgun_weapons.size] = GetWeapon("idgun");
	}

	level zm::register_vehicle_damage_callback( &idgun_apply_vehicle_damage );
}

function is_idgun_damage( weapon )
{
	if( isdefined( level.idgun_weapons ) )
	{
		if( IsInArray( level.idgun_weapons, weapon ) )
		{
			return true;
		}
	}
	return false;
}

function function_9b7ac6a9( weapon )
{
	return is_idgun_damage( weapon ) && zm_weapons::is_weapon_upgraded( weapon );
}

function function_6fbe2b2c( v_vortex_origin )
{
	v_nearest_navmesh_point = GetClosestPointOnNavMesh( v_vortex_origin, 36, 15 );

	if( isdefined( v_nearest_navmesh_point ) )
	{
		f_distance = Distance( v_vortex_origin, v_nearest_navmesh_point );

		if( f_distance < 41 )
		{
			v_vortex_origin += ( 0, 0, 36 );
		}
	}

	return v_vortex_origin;
}

function function_2bd571b9()
{
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( "projectile_impact", weapon, position, radius, attacker, normal );

		position = function_6fbe2b2c( position + ( normal * 20 ) );

		if( is_idgun_damage( weapon ) )
		{
			var_12edbbc6 = radius * 1.8;

			if( function_9b7ac6a9( weapon ) )
			{
				thread zombie_vortex::start_timed_vortex(position, radius, 9, 10, var_12edbbc6, self, weapon, 1, undefined, 0, 2); // upgrade
			}
			else
			{
				thread zombie_vortex::start_timed_vortex(position, radius, 4, 5, var_12edbbc6, self, weapon, 1, undefined, 0, 1); // unpap
			}

			level notify( "hash_2751215d", position, weapon, self );
		}

		wait 0.05;
	}
}

function wait_for_idgun_fired()
{
	self endon( "disconnect" );
	self endon( "spawned_player" );

	for(;;)
	{
		self waittill( "missile_fire", missile, weapon );

		if( is_idgun_damage( weapon ) )
		{
			self thread idgun_trail_fx( missile, level._effect["idgun_trail"] );
			PlayFXOnTag( level._effect["idgun_flash"], self, "tag_flash" );
		}
	}
}

function idgun_trail_fx( projectile, str_fx )
{
	if( !isdefined( projectile ) )
	{
		return;
	}

	fxorg = util::spawn_model( "tag_origin", projectile.origin, projectile.angles );
	fx = PlayFXOnTag( str_fx, fxorg, "tag_origin" );

	for(;;)
	{
		pos = projectile.origin;
		wait 0.05;

		if( !isdefined( projectile ) )
		{
			break;
		}

		new_pos = projectile.origin;
		if( new_pos == pos )
		{
			break;
		}

		fxorg MoveTo( new_pos, 0.05 );
	}

	if( isdefined( fxorg ) ) fxorg Delete();
	wait 2;
	if( isdefined( fx ) ) fx Delete();
}

function function_b618ee82( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime )
{
	if( is_idgun_damage( sweapon ) )
	{
		return 0;
	}
	return -1;
}

function idgun_apply_vehicle_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
	if( isdefined( weapon ) )
	{
		if( is_idgun_damage ( weapon ) && ( !( isdefined( self.veh_idgun_allow_damage ) && self.veh_idgun_allow_damage ) ) )
		{
			idamage = 0;
		}
	}
	return idamage;
}