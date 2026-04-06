#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;

#using scripts\zm\_xcdylan93\_zm_mod_fx;
#using scripts\zm\_xcdylan93\_zm_mod_huds;
#using scripts\zm\_xcdylan93\_zm_mod_zombie;
#using scripts\zm\_xcdylan93\_zm_startmenu;
#using scripts\zm\_xcdylan93\_zm_trap_timer;
#using scripts\zm\_xcdylan93\zm_factory_patch;
#using scripts\zm\_xcdylan93\zm_island_patch;
#using scripts\zm\_xcdylan93\zm_prison_patch;
#using scripts\zm\_xcdylan93\zm_temple_patch;

#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

REGISTER_SYSTEM_EX( "zm_patch", &__init__, &__main__, undefined )

function __init__()
{
	level.patched_start_chest_name = init_patched_start_chest_name();
	level.patched_magicbox = true;
	level.patched_magicbox_order = init_patched_magicbox_order_default();
	level.patched_perkorder = true;
	level.patched_perks_array = init_patched_perk_order_default();
	level.fx_color = init_fx_color_default();
}

function __main__()
{
	level thread init_starting_chest_location();
	level thread init_patched_magicbox();
	level thread precache_strings();
	level thread init_sounds();
	thread pap_camo();

	level.givecustomloadout = &give_start_weapons;
}

function precache_strings()
{
	map_strings = [];
	map_strings["zm_sumpf"] = array( &"ZOMBIE_ZIPLINE_ACTIVATE" );
	map_strings["zm_theater"] = array( &"ZM_THEATER_START_CORE", &"ZM_THEATER_LINK_CORE", &"ZM_THEATER_LINK_PAD", &"ZM_THEATER_USE_TELEPORTER" );
	map_strings["zm_cosmodrome"] = array( &"ZM_COSMODROME_LANDER_NO_CONNECTIONS", &"ZM_COSMODROME_LANDER_CALL", &"ZM_COSMODROME_WAITING_AUTHORIZATION", &"ZM_COSMODROME_LANDER_AT_STATION", &"ZM_COSMODROME_DOOR_CLOSED" );
	map_strings["zm_temple"] = array( &"ZM_TEMPLE_DESTINATION_NOT_OPEN" );
	map_strings["zm_moon"] = array( &"ZOMBIE_EQUIP_GASMASK_HOWTO" );
	map_strings["zm_genesis"] = array( &"ZM_GENESIS_POWER_COST" );

	perk_strings = [];
	perk_strings["specialty_additionalprimaryweapon"] = array( &"ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON", 4000 );
	perk_strings["specialty_whoswho"] = array( &"ZOMBIE_PERK_CHUGABUD", 2000 );
	perk_strings["specialty_deadshot"] = array( &"ZOMBIE_PERK_DEADSHOT", 1500 );
	perk_strings["specialty_phdflopper"] = array( &"ZOMBIE_PERK_DIVETONUKE", 2000 );
	perk_strings["specialty_doubletap2"] = array( &"ZOMBIE_PERK_DOUBLETAP", 2000 );
	perk_strings["specialty_fastreload"] = array( &"ZOMBIE_PERK_FASTRELOAD", 3000 );
	perk_strings["specialty_armorvest"] = array( &"ZOMBIE_PERK_JUGGERNAUT", 2500 );
	perk_strings["specialty_staminup"] = array( &"ZOMBIE_PERK_MARATHON", 2000 );
	perk_strings["specialty_quickrevive"] = array( &"ZOMBIE_PERK_QUICKREVIVE", 1500 );
	perk_strings["specialty_tombstone"] = array( &"ZOMBIE_PERK_TOMBSTONE", 2000 );
	perk_strings["specialty_vultureaid"] = array( &"ZOMBIE_PERK_VULTURE", 3000 );
	perk_strings["specialty_widowswine"] = array( &"ZOMBIE_PERK_WIDOWSWINE", 4000 );

	level waittill( "all_players_connected" );

	trig = Spawn( "trigger_radius", ( 0, 0, 0 ), 0, 16, 16 );
	trig SetInvisibleToAll();

	register_string( trig, &"ZOMBIE_PERK_PACKAPUNCH", 5000 );
	register_string( trig, &"ZOMBIE_PERK_PACKAPUNCH", 1000 );
	register_string( trig, &"ZOMBIE_PERK_PACKAPUNCH_AAT", 2500 );
	register_string( trig, &"ZOMBIE_PERK_PACKAPUNCH_AAT", 500 );

	perk_keys = GetArrayKeys( perk_strings );
	foreach( key in GetArrayKeys( level._custom_perks ) )
	{
		if( IsInArray( perk_keys, key ) )
		{
			str = perk_strings[key][0];
			cost = perk_strings[key][1];
			register_string( trig, str, cost );
		}
	}
	register_string( trig, &"ZOMBIE_RANDOM_PERK_BUY", 1500 );

	if( isdefined( map_strings[level.script] ) )
	{
		foreach( str in map_strings[level.script] )
		{
			register_string( trig, str );
		}
	}

	register_string( trig, &"ZM_GENESIS_USE_TURRET", 2000 );
	register_string( trig, &"ZOMBIE_AUTO_TURRET", 1500 );
	register_string( trig, &"ZOMBIE_BUTTON_BUY_TRAP", 1000 );
	register_string( trig, &"ZM_GENESIS_POWER_COST", 500 );
	register_string( trig, &"ZM_TEMPLE_MINECART_COST", 250 );

	trig Delete();
}

function init_sounds()
{
	level waittill( "start_zombie_round_logic" );
	zm_audio::loadplayervoicecategories( "gamedata/audio/zm/zm_mod_vox.csv" );
}

function register_string( trig, string, insert )
{
	if( !isdefined( insert ) )
	{
		trig SetHintString( string );
	}
	else
	{
		trig SetHintString( string, insert );
	}
	waittillframeend;
}

function pap_camo()
{
	level flag::wait_till( "start_zombie_round_logic" );
	
	camos["zm_prototype"] = 3;
	camos["zm_asylum"] = 1;
	camos["zm_sumpf"] = 4;
	camos["zm_theater"] = 3;
	camos["zm_cosmodrome"] = 4;
	camos["zm_temple"] = 3;
	camos["zm_moon"] = 5;
	camos["zm_zod"] = 1;
	camos["zm_island"] = 4;
	camos["zm_stalingrad"] = 1;
	camos["zm_genesis"] = 5;

	camos["zm_prison"] = 20;
	camos["zm_town"] = 3;

	level.pack_a_punch_camo_index = ( isdefined( camos[level.script] ) ? camos[level.script] : 2 );
	level.pack_a_punch_camo_index_number_variants = 1;
}

function give_start_weapons( takeallweapons, alreadyspawned )
{
	self GiveWeapon( level.weaponbasemelee );
	self zm_weapons::weapon_give( level.start_weapon, 0, 0, 1, 0 );
	self GiveMaxAmmo( level.start_weapon );
	self zm_weapons::weapon_give( level.super_ee_weapon, 0, 0, 1, 1 );
}

function init_starting_chest_location()
{
	level endon( "end_game" );

	if( !isdefined( level.patched_start_chest_name ) )
	{
		return;
	}

	// because 3arc did some fuckshit with kino...
	while( !level flag::get( "start_zombie_round_logic" ) )
	{
		level.random_pandora_box_start = false;
		level.start_chest_name = level.patched_start_chest_name;
		wait 0.05;
	}
}

function init_patched_magicbox()
{
    level endon( "end_game" );

    level.customrandomweaponweightssave = level.customrandomweaponweights;

    while( level.round_number < 20 )
    {
		level.customrandomweaponweights = &customrandomweaponweights;
        wait 1; 
    }

    level.customrandomweaponweights = level.customrandomweaponweightssave;
}

function customrandomweaponweights( akeys )
{
	if( IS_TRUE( level.patched_magicbox ) && isdefined( level.patched_magicbox_order ) )
	{
		akeysnew = [];

		for( i = 0; i < level.patched_magicbox_order.size; i++ )
		{
			akeysnew[akeysnew.size] = level.patched_magicbox_order[i];
		}

		akeys = ArrayCombine( akeysnew, akeys, false, false );
	}

	return akeys;
}

function init_patched_start_chest_name()
{
	start_name = [];
	start_name["zm_factory"] 		= "chest_2";
	start_name["zm_theater"] 		= "crematorium_chest";
	start_name["zm_temple"] 		= "start_chest";
	start_name["zm_moon"] 			= "chest_0";
	start_name["zm_zod"] 			= "canal_chest";
	start_name["zm_castle"] 		= "lower_courtyard_chest";
	start_name["zm_stalingrad"] 	= "basement_chest";
	start_name["zm_genesis"] 		= "temple_chest";

	start_name["zm_coast"] 			= "chest_3";
	start_name["zm_prison"] 		= "start_chest";

	if( isdefined( start_name[level.script] ) )
	{
		return start_name[level.script];
	}

	return undefined;
}

function init_patched_magicbox_order_default()
{
	order = [];
	order["zm_asylum"] 		= array( "tesla_gun", "raygun_mark2", "cymbal_monkey" );
	order["zm_sumpf"] 		= array( "tesla_gun", "raygun_mark2", "cymbal_monkey" );
	order["zm_factory"] 	= array( "tesla_gun", "cymbal_monkey" );
	order["zm_theater"] 	= array( "thundergun", "cymbal_monkey" );
	order["zm_cosmodrome"] 	= array( "thundergun", "black_hole_bomb", "smg_capacity" );
	order["zm_temple"] 		= array( "shrink_ray", "cymbal_monkey" );
	order["zm_moon"] 		= array( "quantum_bomb", "smg_capacity", "microwavegundw", "black_hole_bomb" );
	order["zm_tomb"] 		= array( "raygun_mark2", "cymbal_monkey" );
	order["zm_zod"] 		= array( "octobomb", "shotgun_fullauto", "lmg_cqb" );
	order["zm_castle"] 		= array( "cymbal_monkey", "shotgun_fullauto", "lmg_cqb" );
	order["zm_island"] 		= array( "cymbal_monkey", "shotgun_fullauto", "lmg_cqb" );
	order["zm_stalingrad"] 	= array( "raygun_mark3", "cymbal_monkey" );
	order["zm_genesis"] 	= array( "idgun_genesis_0", "thundergun", "octobomb", "hero_gravityspikes_melee", "ar_cqb" );

	order["zm_coast"] 		= array( "scavenger", "t5_hk21", "nesting_dolls", "humangun" );
	order["zm_prison"] 		= array( "t8_blundergat" );

	if( isdefined( order[level.script] ) )
	{
		weapons = [];

		for( i = 0; i < order[level.script].size; i++ )
		{
			weapons[weapons.size] = GetWeapon( order[level.script][i] );
		}

		return weapons;
	}

	return undefined;
}

function init_patched_perk_order_default()
{
	return array( "specialty_doubletap2", "specialty_armorvest", "specialty_staminup", "specialty_fastreload", "specialty_additionalprimaryweapon" );
}

function init_fx_color_default()
{
	colors = [];
	colors["zm_prototype"] = "orange";
	colors["zm_asylum"] = "red";
	colors["zm_sumpf"] = "green";
	colors["zm_theater"] = "orange";
	colors["zm_cosmodrome"] = "green";
	colors["zm_temple"] = "orange";
	colors["zm_moon"] = "purple";
	colors["zm_zod"] = "red";
	colors["zm_island"] = "green";
	colors["zm_stalingrad"] = "red";
	colors["zm_genesis"] = "pink";

	colors["zm_prison"] = "orange";
	colors["zm_town"] = "orange";

	return( isdefined( colors[level.script] ) ? colors[level.script] : "blue" );
}