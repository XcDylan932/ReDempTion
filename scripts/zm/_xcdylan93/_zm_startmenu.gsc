#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\lua_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#precache( "menu", "StartMenu_CamoOptions" );
#precache( "menu", "StartMenu_CharacterOptions" );
#precache( "menu", "StartMenu_PerkOptions" );
#precache( "menu", "StartMenu_PowerupOptions");
#precache( "menu", "GameSettings" );

#namespace zm_startmenu;

REGISTER_SYSTEM( "zm_startmenu", &__init__, undefined )

function __init__()
{
	gamesettings = array( "ChangeAll", "Tritium", "Laser", "Powerup", "Muzzle", "Eye", "Waffe", "Tgun", "Squid", "Wavegun", "Magmagat" );
	for( i = 0; i < GetDvarInt( "com_maxclients" ); i++ )
	{
		foreach( setting in gamesettings )
		{
			clientfield::register( "world", sprintf( "GameSettings_{0}{1}", setting, i ), VERSION_SHIP, 3, "int" );
		}
	}

	register_menu_input_func( "MagicboxPatch", &toggle_magicbox_patch );
	register_menu_input_func( "MagicboxOrder", &set_magicbox_order );

	register_menu_input_func( "PerkPatch", &toggle_perk_patch );
	register_menu_input_func( "PerkOrder", &set_perk_order );

	register_menu_input_func( "ChangeAll", &change_all );
	register_menu_input_func( "TritiumColor", &set_tritium_color );
	register_menu_input_func( "LaserColor", &set_laser_color );
	register_menu_input_func( "PowerupColor", &set_powerup_color );
	register_menu_input_func( "MuzzleColor", &set_muzzle_color );
	register_menu_input_func( "EyeColor", &set_eye_color );

	register_menu_input_func( "WunderwaffeColor", &set_waffe_color );
	register_menu_input_func( "ThundergunColor", &set_thundergun_color );
	register_menu_input_func( "ApothiconColor", &set_apothicon_color );
	register_menu_input_func( "WavegunColor", &set_wavegun_color );
	register_menu_input_func( "MagmagatColor", &set_magmagat_color );

	register_menu_input_func( "StartMenu_CamoOptions", &set_weapon_camo );
	register_menu_input_func( "StartMenu_CharacterOptions", &set_player_character );
	register_menu_input_func( "StartMenu_PerkOptions", &set_player_perkicons );
	register_menu_input_func( "StartMenu_PowerupOptions", &set_player_powerupicons );

	callback::on_connect( &on_connect );

	init_gamesettings();
	level.localizedstrings = init_localized_strings();
	level.colors = array( "red", "orange", "yellow", "green", "blue", "purple", "pink", "white" );
}

function init_gamesettings()
{
	level.GameSettings = [];

	setting_keys = array( "powerup", "muzzle", "eye", "waffe", "tgun", "squid", "wavegun", "magmagat", "tritium", "laser", "changeall" );
	color_keys = array( "red", "orange", "yellow", "green", "blue", "purple", "pink", "white" );

	for( setting = 0; setting < setting_keys.size; setting++ )
	{
		level.GameSettings[setting_keys[setting]] = [];

		for( color = 0; color < color_keys.size; color++ )
		{
			level.GameSettings[setting_keys[setting]][color_keys[color]] = color;
		}
	}
}

function register_menu_input_func( menu, input_func )
{
	DEFAULT( level.menu_handlers, [] );
	level.menu_handlers[menu] = SpawnStruct();
	level.menu_handlers[menu].input_func = input_func;
}

function on_connect()
{
	self thread startmenu_input_handler();
	self thread on_connect_character();
}

function startmenu_input_handler()
{
	level endon( "end_game" );
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( "menuresponse", menu, response );

		if( menu === "GameSettings" )
		{
			tokens = StrTok( response, "|" );
			menu = tokens[0];
			response = tokens[1];
		}

		if( isdefined( level.menu_handlers[menu] ) )
		{
			if( IsFunctionPtr( level.menu_handlers[menu].input_func ) )
			{
				self thread [[ level.menu_handlers[menu].input_func ]]( response );
			}
		}
	}
}

function on_connect_character()
{
	self endon( "disconnect" );

	level flag::wait_till( "start_zombie_round_logic" );
	
	sets = [];
	sets["zm_prototype"] = 1;
	sets["zm_asylum"] = 1;
	sets["zm_sumpf"] = 1;
	sets["zm_theater"] = 1;
	sets["zm_cosmodrome"] = 1;
	sets["zm_temple"] = 1;
	sets["zm_moon"] = 1;
	sets["zm_zod"] = 4;
	sets["zm_coast"] = 6;
	sets["zm_die"] = 7;
	sets["zm_prison"] = 8;

	set_index = ( isdefined( sets[level.script] ) ? sets[level.script] : 0 );
	self set_player_character( set_index * 4 + self.characterIndex, 0 );
	self thread monitor_afterlife_reset_playermodel();
}

function monitor_afterlife_reset_playermodel()
{
    self endon( "disconnect" );
    
    for(;;)
    {
        result = self util::waittill_any_return( "player_exit_beastmode", "player_revived", "zombie_blood", "zombie_blood_over" );
        if( result == "player_revived" && level.script != "zm_prison" )
        {
        	continue;
        }

        wait 0.1;
        if( isdefined( self.afterlifeIndex ) )
        {
            self set_player_character( self.afterlifeIndex, 0 );
        }

        if( level.script == "zm_prison" && isdefined( self.papcamoIndex ) )
        {
        	self update_all_weapons_camo( self.papcamoIndex );
        }
    }
}

function set_weapon_camo( index = 0, print = 1, weapon = self GetCurrentWeapon() )
{
	index = Int( index );

    options = get_unpacked_weapon_options( weapon );
	if( !isdefined( options ) || options[0] == index )
	{
		return;
	}

    if( weapon.altweapon.name != "none" )
    {
    	if( weapon.isaltmode )
    	{
    		self IPrintLnBold( &"XCUI_ERR_ALTWEAPON" );
    		return;
    	}
    	self set_altweapon_camo( options[0], index );
    }
    else
    {
    	self UpdateWeaponOptions( weapon, self CalcWeaponOptions( index, 0, options[1] ) );
    }

    self.papcamoIndex = index;
    if( level.players.size == 1 )
    {
    	level.pack_a_punch_camo_index = index;
    }
    
    if( print )
    {
    	camo = MakeLocalizedString( level.camos[index] );
    	self lua::print( sprintf( &"XCUI_CAMO_APPLIED", camo ) );
    }
}

function set_altweapon_camo( n_current, n_target )
{
	if( isdefined( n_current ) && n_current != n_target )
	{
		n_difference = n_target - n_current;
		b_fwd = n_difference > 0;

		for( i = 0; i < Abs( n_difference ); i++ )
		{
			self NextPlayerRenderOption( "camo", b_fwd );
		}
	}
}

function get_unpacked_weapon_options( weapon = self GetCurrentWeapon() )
{
    weapon_options = self GetWeaponOptions( weapon );

    for( reticle = 0; reticle < 50; reticle++ )
    {
        for( camo = 0; camo < 256; camo++ )
        {
            test_options = self CalcWeaponOptions( camo, 0, reticle );
            if( weapon_options == test_options )
            {
                return array( camo, reticle ); 
            }
        }
    }
    return undefined;
}

function update_all_weapons_camo( index )
{
	weapons = self GetWeaponsListPrimaries();
	foreach( weapon in weapons )
	{
		if( weapon.altweapon.name != "none" )
		{
			continue;
		}
		self set_weapon_camo( index, 0, weapon );
	}
}

function set_player_character( index, print = 1 )
{
	if( Int( index ) < 0 )
	{
		return;
	}

	val = ( isdefined( index ) ? Int( index ) : RandomInt(4) );
	type = Int( val % 4 );
	style = Int( val / 4 );

	if( self.afterlifeIndex !== val )
	{
		PlayFX( level._effect["teleport_splash"], self.origin );
		PlayFX( level._effect["teleport_aoe"], self.origin );
	}

	self.afterlifeIndex = val;
	self.voxIndex = ( val <= 15 ? val % 4 : val );
	self.zm_random_char = self.voxIndex;
	self zm_audio::setexertvoice( val );

	if( print )
    {
    	self lua::print( sprintf( &"XCUI_CHARACTER_APPLIED", MakeLocalizedString( level.characters[val] ) ) );
    }

	if( IsFunctionPtr( level.zombiemode_gasmask_set_player_model ) && self zm_equipment::has_player_equipment( GetWeapon( "equip_gasmask" ) ) )
	{
		self [[ level.zombiemode_gasmask_set_player_model ]]();
		return;
	}

    self SetCharacterBodyType( type );
    self SetCharacterBodyStyle( style );
    self SetCharacterHelmetStyle( 0 );
}

function set_player_perkicons( val )
{
	self lua::print( sprintf( &"XCUI_PERKICONS_APPLIED", GetLocalizedString( val ) ) );
}

function set_player_powerupicons( val )
{
	self lua::print( sprintf( &"XCUI_POWERUPICONS_APPLIED", GetLocalizedString( val ) ) );
}

function toggle_magicbox_patch( b_enable = 0 )
{
	b_enable = Int( b_enable );
	if( level.patched_magicbox !== b_enable )
	{
		level.patched_magicbox = b_enable;
		lua::print( sprintf( &"XCUI_FORCE_MAGICBOX", MakeLocalizedString( ( b_enable ? &"XCUI_ENABLED" : &"XCUI_DISABLED" ) ) ) );
	}
}

function set_magicbox_order( value )
{
	a_new_order = [];
    a_weapons = StrTok( value, "," );
    valid_count = 0;

    for( i = 0; i < a_weapons.size; i++ )
    {
    	weapon = GetWeapon( a_weapons[i] );
    	if( isdefined( level.zombie_weapons[weapon] ) && IS_TRUE( level.zombie_weapons[weapon].is_in_box ) )
    	{
    		a_new_order[a_new_order.size] = weapon;
    		if( level.patched_magicbox_order[i] !== weapon )
    		{
    			name = weapon.displayname;
    			lua::print( sprintf( &"XCUI_MAGICBOX_CHANGE", i + 1, MakeLocalizedString( name ) ) );
    		}
    	}
    }

    level.patched_magicbox_order = a_new_order;
}

function toggle_perk_patch( b_enable = 0 )
{
	b_enable = Int( b_enable );
	if( level.patched_perkorder !== b_enable )
	{
		level.patched_perkorder = b_enable;
		lua::print( sprintf( &"XCUI_FORCE_PERKORDER", MakeLocalizedString( ( b_enable ? &"XCUI_ENABLED" : &"XCUI_DISABLED" ) ) ) );
	}
}

function set_perk_order( value )
{
	a_new_order = [];
	a_perks = StrTok( value, "," );

	for( i = 0; i < a_perks.size; i++ )
	{
		perk = a_perks[i];
		if( IsInArray( GetArrayKeys( level._custom_perks ), perk ) )
		{
			a_new_order[a_new_order.size] = perk;
		}
		else
		{
			if( isdefined( level.perknames ) && IsInArray( GetArrayKeys( level.perknames ), perk ) )
			{
				name = level.perknames[perk];
				name = MakeLocalizedString( name );
			}
			else
			{
				name = perk;
			}
			lua::print( sprintf( &"XCUI_PERK_FAIL", name ) );
		}
	}

	if( a_new_order.size )
	{
		for( i = 0; i < a_new_order.size; i++ )
		{
			perk = a_new_order[i];
			if( level.patched_perks_array[i] !== perk )
			{
				if( isdefined( level.perknames ) && IsInArray( GetArrayKeys( level.perknames ), perk ) )
				{
					name = level.perknames[perk];
					name = MakeLocalizedString( name );
				}
				else
				{
					name = perk;
				}
				lua::print( sprintf( &"XCUI_PERKORDER_CHANGE", i + 1, name ) );
			}
		}
	}

	level.patched_perks_array = a_new_order;
}

function change_all( val, print = 1 )
{
	level clientfield::set( sprintf( "GameSettings_ChangeAll{0}", self.entity_num ), level.GameSettings["changeall"][val] );

	color_funcs = array( &set_tritium_color, &set_laser_color, &set_powerup_color, &set_muzzle_color, &set_eye_color, &set_waffe_color, &set_thundergun_color, &set_apothicon_color, &set_wavegun_color, &set_magmagat_color );
	foreach( ptr in color_funcs )
	{
		if( IsFunctionPtr( ptr ) )
		{
			self [[ ptr ]]( val, 0 );
		}
	}
	
	camo = [];
	camo["red"] = 1;
	camo["blue"] = 2;
	camo["orange"] = 3;
	camo["green"] = 4;
	camo["purple"] = 5;
	camo["white"] = 6;
	camo["pink"] = 7;
	camo["yellow"] = 8;

	players = GetPlayers();
	array::thread_all( players, &update_all_weapons_camo, camo[val] );
	
	if( print )
	{
		lua::print( sprintf( &"XCUI_ALLCOLORS_CHANGE", GetLocalizedString( val ) ) );
	}
}

function set_tritium_color( val, print = 1 )
{
	level clientfield::set( sprintf( "GameSettings_Tritium{0}", self.entity_num ), level.GameSettings["tritium"][val] );

	if( print )
	{
		self lua::print( sprintf( &"XCUI_SIGHT_CHANGE", GetLocalizedString( val ) ) );
	}
}

function set_laser_color( val, print = 1 )
{
	level clientfield::set( sprintf( "GameSettings_Laser{0}", self.entity_num ), level.GameSettings["laser"][val] );

	if( print )
	{
		self lua::print( sprintf( &"XCUI_LASER_CHANGE", GetLocalizedString( val ) ) );
	}
}

function set_powerup_color( val, print = 1 )
{
	level clientfield::set( sprintf( "GameSettings_Powerup{0}", self.entity_num ), level.GameSettings["powerup"][val] );
	level set_effect( "powerup", val );

	if( print )
	{
		lua::print( sprintf( &"XCUI_POWERUP_CHANGE", GetLocalizedString( val ) ) );
	}
}

function set_muzzle_color( val, print = 1 )
{	
	level clientfield::set( sprintf( "GameSettings_Muzzle{0}", self.entity_num ), level.GameSettings["muzzle"][val] );
	if( print )
	{
		self lua::print( sprintf( &"XCUI_FLASH_CHANGE", GetLocalizedString( val ) ) );
	}
	DEFAULT( world._effect, [] );
	world._effect["eye"] = val;
}

function set_eye_color( val, print = 1 )
{
	level clientfield::set( sprintf( "GameSettings_Eye{0}", self.entity_num ), level.GameSettings["eye"][val] );
	if( print )
	{
		lua::print( sprintf( &"XCUI_EYE_CHANGE", GetLocalizedString( val ) ) );
	}
}

function set_waffe_color( val, print = 1 )
{
	color = ( val == "yellow" ? "orange" : val );
	level clientfield::set( sprintf( "GameSettings_Waffe{0}", self.entity_num ), level.GameSettings["waffe"][color] );
	level set_effect( "tesla", color );

	if( print )
	{
		self lua::print( sprintf( &"XCUI_WAFFE_CHANGE", GetLocalizedString( color ) ) );
	}
}

function set_thundergun_color( val, print = 1 )
{
	level clientfield::set( sprintf( "GameSettings_Tgun{0}", self.entity_num ), level.GameSettings["tgun"][val] );
	level set_effect( "tgun", val );

	if( print )
	{
		self lua::print( sprintf( &"XCUI_TGUN_CHANGE", GetLocalizedString( val ) ) );
	}
}

function set_apothicon_color( val, print = 1 )
{
	color = ( val == "green" ? "blue" : ( val == "yellow" ? "orange" : val ) );
	level clientfield::set( sprintf( "GameSettings_Squid{0}", self.entity_num ), level.GameSettings["squid"][color] );
	level set_effect( "idgun", color );

	if( print )
	{
		self lua::print( sprintf( &"XCUI_SQUID_CHANGE", GetLocalizedString( color ) ) );
	}
}

function set_wavegun_color( val, print = 1 )
{
	level clientfield::set( sprintf( "GameSettings_Wavegun{0}", self.entity_num ), level.GameSettings["wavegun"][val] );
	level set_effect( "wavegun", val );

	if( print )
	{
		self lua::print( sprintf( &"XCUI_WAVEGUN_CHANGE", GetLocalizedString( val ) ) );
	}
}

function set_magmagat_color( val, print = 1 )
{
	color = ( val == "red" ? "orange" : ( val == "yellow" ? "orange" : ( val == "green" ? "blue" : ( val == "pink" ? "purple" : ( val == "white" ? "orange" : val ) ) ) ) );
	level clientfield::set( sprintf( "GameSettings_Magmagat{0}", self.entity_num ), level.GameSettings["magmagat"][color] );
	level set_effect( "magmagat", color );

	if( print )
	{
		self lua::print( sprintf( &"XCUI_BLUNDERGAT_CHANGE", GetLocalizedString( val ) ) );
	}
}

function set_effect( category, color )
{
	DEFAULT( world._effect, [] );
    world._effect[category] = color;

    color_index = get_color_index( color );
    foreach( alias in GetArrayKeys( level._effect[category] ) )
    {
        DEFAULT( self._effect, [] );
        self._effect[alias] = level._effect[category][alias][color_index];
    }
}

function get_color_index( color )
{
	if( IsInArray( level.colors, color ) )
	{
		for( i = 0; i < level.colors.size; i++ )
		{
			if( color == level.colors[i] )
			{
				return i;
			}
		}
	}
	return undefined;
}

function GetLocalizedString( val )
{
	if( IsInArray( GetArrayKeys( level.localizedstrings ), val ) )
	{
		return MakeLocalizedString( level.localizedstrings[val] );
	}
	return MakeLocalizedString( &"XCUI_UNKNOWN" );
}

function init_localized_strings()
{
	localizedstrings = [];
	localizedstrings["red"] 	= &"GAMESETTINGS_RED";
	localizedstrings["orange"] 	= &"GAMESETTINGS_ORANGE";
	localizedstrings["yellow"] 	= &"GAMESETTINGS_YELLOW";
	localizedstrings["green"] 	= &"GAMESETTINGS_GREEN";
	localizedstrings["blue"] 	= &"GAMESETTINGS_BLUE";
	localizedstrings["purple"] 	= &"GAMESETTINGS_PURPLE";
	localizedstrings["pink"] 	= &"GAMESETTINGS_PINK";
	localizedstrings["white"] 	= &"GAMESETTINGS_WHITE";
	return localizedstrings;
}