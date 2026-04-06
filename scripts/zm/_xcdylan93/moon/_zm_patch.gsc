#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;

#using scripts\zm\_xcdylan93\moon\_zm_mod_fx;
#using scripts\zm\_xcdylan93\_zm_mod_huds;
#using scripts\zm\_xcdylan93\_zm_mod_zombie;
#using scripts\zm\_xcdylan93\_zm_startmenu;
#using scripts\zm\_xcdylan93\zm_moon_patch;

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
	level.pack_a_punch_camo_index = 5;
	level.givecustomloadout = &give_start_weapons;
}

function precache_strings()
{
	perk_strings = [];
	perk_strings["specialty_additionalprimaryweapon"] = array( &"ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON", 4000 );
	perk_strings["specialty_deadshot"] = array( &"ZOMBIE_PERK_DEADSHOT", 1500 );
	perk_strings["specialty_doubletap2"] = array( &"ZOMBIE_PERK_DOUBLETAP", 2000 );
	perk_strings["specialty_fastreload"] = array( &"ZOMBIE_PERK_FASTRELOAD", 3000 );
	perk_strings["specialty_armorvest"] = array( &"ZOMBIE_PERK_JUGGERNAUT", 2500 );
	perk_strings["specialty_staminup"] = array( &"ZOMBIE_PERK_MARATHON", 2000 );
	perk_strings["specialty_quickrevive"] = array( &"ZOMBIE_PERK_QUICKREVIVE", 1500 );
	perk_strings["specialty_widowswine"] = array( &"ZOMBIE_PERK_WIDOWSWINE", 4000 );

	level waittill( "all_players_connected" );

	trig = Spawn( "trigger_radius", ( 0, 0, 0 ), 0, 16, 16 );
	trig SetInvisibleToAll();

	register_string( trig, &"ZOMBIE_PERK_PACKAPUNCH", 5000 );
	register_string( trig, &"ZOMBIE_PERK_PACKAPUNCH_AAT", 2500 );
	register_string( trig, &"ZOMBIE_EQUIP_GASMASK_HOWTO" );

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

function give_start_weapons( takeallweapons, alreadyspawned )
{
	self GiveWeapon( level.weaponbasemelee );
	self zm_weapons::weapon_give( level.start_weapon, 0, 0, 1, 0 );
	self GiveMaxAmmo( level.start_weapon );
	self zm_weapons::weapon_give( level.super_ee_weapon, 0, 0, 1, 1 );
}

function init_starting_chest_location()
{
	if( !isdefined( level.patched_start_chest_name ) )
	{
		return;
	}

	wait 0.05;
	level.random_pandora_box_start = false;
	level.start_chest_name = level.patched_start_chest_name;
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
	start_name["zm_moon"] 			= "chest_0";

	if( isdefined( start_name[level.script] ) )
	{
		return start_name[level.script];
	}

	return undefined;
}

function init_patched_magicbox_order_default()
{
	order = [];
	order["zm_moon"] 		= array( "quantum_bomb", "smg_capacity", "microwavegundw", "black_hole_bomb" );

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
	colors["zm_moon"] = "purple";
	return( isdefined( colors[level.script] ) ? colors[level.script] : "blue" );
}