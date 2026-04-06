#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_zm_utility;

#insert scripts\shared\shared.gsh;

#namespace zm_weapons;

REGISTER_SYSTEM( "zm_weapons", &__init__, undefined )

function __init__()
{
	level flag::init( "weapon_table_loaded" );
	level flag::init( "weapon_wallbuys_created" );
	callback::on_localclient_connect( &on_player_connect );
}

function private on_player_connect( localclientnum )
{
	if( GetMigrationStatus( localclientnum ) )
	{
		return;
	}
	resetweaponcosts( localclientnum );
	level flag::wait_till( "weapon_table_loaded" );
	level flag::wait_till( "weapon_wallbuys_created" );
	foreach( weaponcost in level.weapon_costs )
	{
		player_cost = compute_player_weapon_ammo_cost( weaponcost.weapon, weaponcost.ammo_cost, weaponcost.upgraded );
		setweaponcosts (localclientnum, weaponcost.weapon, weaponcost.cost, weaponcost.ammo_cost, player_cost );
	}
}

function is_weapon_included( weapon )
{
	return isdefined( level._included_weapons ) && isdefined( level._included_weapons[weapon.rootweapon] );
}

function compute_player_weapon_ammo_cost( weapon, cost, upgraded, n_base_non_wallbuy_cost = 750, n_upgraded_non_wallbuy_cost = 5000 )
{
	w_root = weapon.rootweapon;
	if( upgraded )
	{
		if( is_wallbuy( level.zombie_weapons_upgraded[w_root] ) )
		{
			n_ammo_cost = 4000;
		}
		else
		{
			n_ammo_cost = n_upgraded_non_wallbuy_cost;
		}
	}
	else
	{
		if( is_wallbuy( w_root ) )
		{
			n_ammo_cost = cost;
			n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
		}
		else
		{
			n_ammo_cost = n_base_non_wallbuy_cost;
		}
	}
	return n_ammo_cost;
}

function include_weapon( weapon_name, display_in_box, cost, ammo_cost, upgraded = 0, is_wonder_weapon = 0 )
{
	DEFAULT( level._included_weapons, [] );
	weapon = GetWeapon( weapon_name );
	level._included_weapons[weapon] = weapon;
	level._included_weapons[weapon].in_box = display_in_box;
	level._included_weapons[weapon].is_wonder_weapon = is_wonder_weapon;
	DEFAULT( level.weapon_costs, [] );
	if( !isdefined( level.weapon_costs[weapon_name] ) )
	{
		level.weapon_costs[weapon_name] = SpawnStruct();
		level.weapon_costs[weapon_name].weapon = weapon;
	}
	level.weapon_costs[weapon_name].cost = cost;
	if( !isdefined( ammo_cost ) || ammo_cost == 0 )
	{
		ammo_cost = zm_utility::round_up_to_ten( Int( cost * 0.5 ) );
	}
	level.weapon_costs[weapon_name].ammo_cost = ammo_cost;
	level.weapon_costs[weapon_name].upgraded = upgraded;
	if( isdefined( display_in_box ) && !display_in_box )
	{
		return;
	}
	if( !isdefined( level._resetzombieboxweapons ) )
	{
		level._resetzombieboxweapons = 1;
		ResetZombieBoxWeapons();
	}
	if( !isdefined( weapon.worldmodel ) )
	{
		thread util::error( sprintf( "Missing worldmodel for weapon {0} (or weapon may be missing from fastfile).", weapon_name ) );
		return;
	}
	AddZombieBoxWeapon( weapon, weapon.worldmodel, weapon.isdualwield );
}

function include_upgraded_weapon( weapon_name, upgrade_name, display_in_box, cost, ammo_cost )
{
	include_weapon( upgrade_name, display_in_box, cost, ammo_cost, 1 );
	DEFAULT( level.zombie_weapons_upgraded, [] );
	weapon = GetWeapon( weapon_name );
	upgrade = GetWeapon( upgrade_name );
	level.zombie_weapons_upgraded[upgrade] = weapon;
}

function is_weapon_upgraded( weapon )
{
	return isdefined( level.zombie_weapons_upgraded[weapon.rootweapon] );
}

function is_wonder_weapon( weapon )
{
	if( !isdefined( weapon ) )
	{
		return false;
	}

	if( is_weapon_upgraded( weapon ) )
	{
		if( isdefined( level.zombie_weapons_upgraded[weapon] ) )
		{
			weapon = level.zombie_weapons_upgraded[weapon];
		}
	}
	
	return isdefined( level._included_weapons ) && isdefined( level._included_weapons[weapon] ) && IS_TRUE( level._included_weapons[weapon].is_wonder_weapon );
}

function init()
{
	spawn_list = [];
	spawnable_weapon_spawns = struct::get_array( "weapon_upgrade" );
	spawnable_weapon_spawns = ArrayCombine( spawnable_weapon_spawns, struct::get_array( "bowie_upgrade" ), 1, 0 );
	spawnable_weapon_spawns = ArrayCombine( spawnable_weapon_spawns, struct::get_array( "sickle_upgrade" ), 1, 0 );
	spawnable_weapon_spawns = ArrayCombine( spawnable_weapon_spawns, struct::get_array( "tazer_upgrade" ), 1, 0 );
	spawnable_weapon_spawns = ArrayCombine( spawnable_weapon_spawns, struct::get_array( "buildable_wallbuy" ), 1, 0 );
	if( IS_TRUE( level.use_autofill_wallbuy ) )
	{
		spawnable_weapon_spawns = ArrayCombine( spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0 );
	}
	if( !IS_TRUE( level.headshots_only ) )
	{
		spawnable_weapon_spawns = ArrayCombine( spawnable_weapon_spawns, struct::get_array( "claymore_purchase" ), 1, 0 );
	}
	location = level.scr_zm_map_start_location;
	if( location == "default" || location == "" && isdefined( level.default_start_location ) )
	{
		location = level.default_start_location;
	}
	match_string = level.scr_zm_ui_gametype;
	if( "" != location )
	{
		match_string = match_string + "_" + location;
	}
	match_string_plus_space = " " + match_string;
	for( i = 0; i < spawnable_weapon_spawns.size; i++ )
	{
		spawnable_weapon = spawnable_weapon_spawns[i];
		spawnable_weapon.weapon = GetWeapon( spawnable_weapon.zombie_weapon_upgrade );
		if( isdefined( spawnable_weapon.zombie_weapon_upgrade ) && spawnable_weapon.weapon.isgrenadeweapon && IS_TRUE( level.headshots_only ) )
		{
			continue;
		}
		if( !isdefined( spawnable_weapon.script_noteworthy ) || spawnable_weapon.script_noteworthy == "" )
		{
			spawn_list[spawn_list.size] = spawnable_weapon;
			continue;
		}
		matches = StrTok( spawnable_weapon.script_noteworthy, "," );
		for( j = 0; j < matches.size; j++ )
		{
			if( matches[j] == match_string || matches[j] == match_string_plus_space )
			{
				spawn_list[spawn_list.size] = spawnable_weapon;
			}
		}
	}
	level._active_wallbuys = [];
	for( i = 0; i < spawn_list.size; i++ )
	{
		spawn_list[i].script_label = spawn_list[i].zombie_weapon_upgrade + "_" + spawn_list[i].origin;
		level._active_wallbuys[spawn_list[i].script_label] = spawn_list[i];
		numbits = ( isdefined( level._wallbuy_override_num_bits ) ? level._wallbuy_override_num_bits : 2 );
		clientfield::register( "world", spawn_list[i].script_label, 1, numbits, "int", &wallbuy_callback, 0, 1 );
		target_struct = struct::get( spawn_list[i].target );
		if( spawn_list[i].targetname == "buildable_wallbuy" )
		{
			bits = 4;
			if( isdefined( level.buildable_wallbuy_weapons ) )
			{
				bits = GetMinBitCountForNum( level.buildable_wallbuy_weapons.size + 1 );
			}
			clientfield::register( "world", spawn_list[i].script_label + "_idx", 1, bits, "int", &wallbuy_callback_idx, 0, 1 );
		}
	}
	level flag::set( "weapon_wallbuys_created" );
	callback::on_localclient_connect( &wallbuy_player_connect );
}

function is_wallbuy( w_to_check )
{
	w_base = w_to_check.rootweapon;
	foreach( s_wallbuy in level._active_wallbuys )
	{
		if( s_wallbuy.weapon == w_base )
		{
			return true;
		}
	}
	if( isdefined( level._additional_wallbuy_weapons ) )
	{
		if( IsInArray( level._additional_wallbuy_weapons, w_base ) )
		{
			return true;
		}
	}
	return false;
}

function wallbuy_player_connect( localclientnum )
{
	keys = GetArrayKeys( level._active_wallbuys );
	for( i = 0; i < keys.size; i++ )
	{
		wallbuy = level._active_wallbuys[keys[i]];
		fx = level._effect["870mcs_zm_fx"];
		if( isdefined( level._effect[wallbuy.zombie_weapon_upgrade + "_fx"] ) )
		{
			fx = level._effect[wallbuy.zombie_weapon_upgrade + "_fx"];
		}
		target_struct = struct::get( wallbuy.target );
		target_model = zm_utility::spawn_buildkit_weapon_model( localclientnum, wallbuy.weapon, undefined, target_struct.origin, target_struct.angles );
		target_model Hide();
		target_model.parent_struct = target_struct;
		wallbuy.models[localclientnum] = target_model;
	}
}

function wallbuy_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if( binitialsnap )
	{
		while( !isdefined( level._active_wallbuys ) || !isdefined( level._active_wallbuys[fieldname] ) )
		{
			wait 0.05;
		}
	}
	struct = level._active_wallbuys[fieldname];
	switch( newval )
	{
		case 0:
			struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin;
			struct.models[localclientnum].angles = struct.models[localclientnum].parent_struct.angles;
			struct.models[localclientnum] Hide();
			break;
		case 1:
			if( binitialsnap )
			{
				if( !isdefined( struct.models ) )
				{
					while( !isdefined( struct.models ) )
					{
						wait 0.05;
					}
					while( !isdefined( struct.models[localclientnum] ) )
					{
						wait 0.05;
					}
				}
				struct.models[localclientnum] Show();
				struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin;
			}
			else
			{
				wait 0.05;
				if( localclientnum == 0 )
				{
					PlaySound( localclientnum, "zmb_weap_wall", struct.origin );
				}
				vec_offset = ( 0, 0, 0 );
				if( isdefined( struct.models[localclientnum].parent_struct.script_vector ) )
				{
					vec_offset = struct.models[localclientnum].parent_struct.script_vector;
				}
				struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin + ( ( AnglesToRight( struct.models[localclientnum].angles + vec_offset ) ) * 8 );
				struct.models[localclientnum] Show();
				struct.models[localclientnum] MoveTo( struct.models[localclientnum].parent_struct.origin, 1 );
			}
			break;
		case 2:
			if( IsFunctionPtr( level.wallbuy_callback_hack_override ) )
			{
				struct.models[localclientnum] [[ level.wallbuy_callback_hack_override ]]();
			}
			break;
	}
}

function wallbuy_callback_idx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	basefield = GetSubStr( fieldname, 0, fieldname.size - 4 );
	struct = level._active_wallbuys[basefield];
	if( newval == 0 )
	{
		if( isdefined( struct.models[localclientnum] ) )
		{
			struct.models[localclientnum] Hide();
		}
	}
	else if( newval > 0 )
	{
		weaponname = level.buildable_wallbuy_weapons[newval - 1];
		weapon = GetWeapon( weaponname );
		if( !isdefined( struct.models ) )
		{
			struct.models = [];
		}
		if( !isdefined( struct.models[localclientnum] ) )
		{
			target_struct = struct::get( struct.target );
			model = undefined;
			if( isdefined( level.buildable_wallbuy_weapon_models[weaponname] ) )
			{
				model = level.buildable_wallbuy_weapon_models[weaponname];
			}
			angles = target_struct.angles;
			if( isdefined( level.buildable_wallbuy_weapon_angles[weaponname] ) )
			{
				switch( level.buildable_wallbuy_weapon_angles[weaponname] )
				{
					case 90:
						angles = VectortoAngles( AnglesToRight( angles ) );
						break;
					case 180:
						angles = VectortoAngles( AnglesToForward( angles ) * -1 );
						break;
					case 270:
						angles = VectortoAngles( AnglesToRight( angles ) * -1 );
						break;
				}
			}
			target_model = zm_utility::spawn_buildkit_weapon_model( localclientnum, weapon, undefined, target_struct.origin, angles );
			target_model Hide();
			target_model.parent_struct = target_struct;
			struct.models[localclientnum] = target_model;
			if( isdefined( struct.fx[localclientnum] ) )
			{
				StopFX( localclientnum, struct.fx[localclientnum] );
				struct.fx[localclientnum] = undefined;
			}
			fx = level._effect["870mcs_zm_fx"];
			if( isdefined( level._effect[weaponname + "_fx"] ) )
			{
				fx = level._effect[weaponname + "_fx"];
			}
			struct.fx[localclientnum] = PlayFX( localclientnum, fx, struct.origin, AnglesToForward( struct.angles ), AnglesToUp( struct.angles ), 0.1 );
			level notify( "wallbuy_updated" );
		}
	}
}

function checkstringvalid( str )
{
	return( str != "" ? str : undefined );
}

function load_weapon_spec_from_table( table, first_row )
{
	gametype = GetDvarString( "ui_gametype" );
	index = 1;
	row = TableLookupRow( table, index );
	while( isdefined( row ) )
	{
		weapon_name = checkstringvalid( row[0] );
		upgrade_name = checkstringvalid( row[1] );
		hint = checkstringvalid( row[2] );
		cost = Int( row[3] );
		weaponvo = checkstringvalid( row[4] );
		weaponvoresp = checkstringvalid( row[5] );
		ammo_cost = undefined;
		if( "" != row[6] )
		{
			ammo_cost = Int( row[6] );
		}
		create_vox = checkstringvalid( row[7] );
		is_zcleansed = ToLower( row[8] ) == "true";
		in_box = ToLower( row[9] ) == "true";
		upgrade_in_box = ToLower( row[10] ) == "true";
		is_limited = ToLower( row[11] ) == "true";
		limit = Int( row[12] );
		upgrade_limit = Int( row[13] );
		content_restrict = row[14];
		wallbuy_autospawn = ToLower( row[15] ) == "true";
		weapon_class = checkstringvalid( row[16] );
		is_wonder_weapon = ToLower( row[18] ) == "true";
		force_attachments = ToLower( row[19] );
		include_weapon( weapon_name, in_box, cost, ammo_cost, 0, is_wonder_weapon );
		if( isdefined( upgrade_name ) )
		{
			include_upgraded_weapon( weapon_name, upgrade_name, upgrade_in_box, cost, 4500 );
		}
		index++;
		row = TableLookupRow( table, index );
	}
	level flag::set( "weapon_table_loaded" );
}

function autofill_wallbuys_init()
{
	wallbuys = struct::get_array( "wallbuy_autofill" );
	if( !isdefined( wallbuys ) || wallbuys.size == 0 || !isdefined( level.wallbuy_autofill_weapons ) || level.wallbuy_autofill_weapons.size == 0 )
	{
		return;
	}
	level.use_autofill_wallbuy = 1;
	array_keys["all"] = GetArrayKeys( level.wallbuy_autofill_weapons["all"] );
	index = 0;
	class_all = [];
	level.active_autofill_wallbuys = [];
	foreach( wallbuy in wallbuys )
	{
		weapon_class = wallbuy.script_string;
		weapon = undefined;
		if( isdefined( weapon_class ) && weapon_class != "" )
		{
			if( !isdefined( array_keys[weapon_class] ) && isdefined( level.wallbuy_autofill_weapons[weapon_class] ) )
			{
				array_keys[weapon_class] = GetArrayKeys( level.wallbuy_autofill_weapons[weapon_class] );
			}
			if( isdefined( array_keys[weapon_class] ) )
			{
				for( i = 0; i < array_keys[weapon_class].size; i++ )
				{
					if( level.wallbuy_autofill_weapons["all"][array_keys[weapon_class][i]] )
					{
						weapon = array_keys[weapon_class][i];
						level.wallbuy_autofill_weapons["all"][weapon] = 0;
						break;
					}
				}
			}
			else
			{
				continue;
			}
		}
		else
		{
			class_all[class_all.size] = wallbuy;
			continue;
		}
		if( !isdefined( weapon ) )
		{
			continue;
		}
		wallbuy.zombie_weapon_upgrade = weapon.name;
		wallbuy.weapon = weapon;
		right = AnglesToRight( wallbuy.angles );
		wallbuy.origin = wallbuy.origin - ( right * 2 );
		wallbuy.target = "autofill_wallbuy_" + index;
		target_struct = SpawnStruct();
		target_struct.targetname = wallbuy.target;
		target_struct.angles = wallbuy.angles;
		target_struct.origin = wallbuy.origin;
		model = wallbuy.weapon.worldmodel;
		target_struct.model = model;
		target_struct struct::init();
		level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
		index++;
	}
	foreach( wallbuy in class_all )
	{
		weapon_name = undefined;
		for( i = 0; i < array_keys["all"].size; i++ )
		{
			if( level.wallbuy_autofill_weapons["all"][array_keys["all"][i]] )
			{
				weapon = array_keys["all"][i];
				level.wallbuy_autofill_weapons["all"][weapon] = 0;
				break;
			}
		}
		if( !isdefined( weapon ) )
		{
			break;
		}
		wallbuy.zombie_weapon_upgrade = weapon.name;
		wallbuy.weapon = weapon;
		right = AnglesToRight( wallbuy.angles );
		wallbuy.origin = wallbuy.origin - ( right * 2 );
		wallbuy.target = "autofill_wallbuy_" + index;
		target_struct = SpawnStruct();
		target_struct.targetname = wallbuy.target;
		target_struct.angles = wallbuy.angles;
		target_struct.origin = wallbuy.origin;
		model = wallbuy.weapon.worldmodel;
		target_struct.model = model;
		target_struct struct::init();
		level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
		index++;
	}
}