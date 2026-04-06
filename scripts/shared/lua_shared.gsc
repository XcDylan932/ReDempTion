#using scripts\shared\array_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#insert scripts\shared\shared.gsh;

#namespace lua;

REGISTER_SYSTEM( "lua", &__init__, undefined )

function __init__()
{
	util::registerclientsys( "luaprint" );

	init_camo_strings();
	init_character_strings();
    init_perk_strings();
}

function print( message )
{
	if( isdefined( self ) && IsPlayer( self ) )
	{
		self print_message( message );
	}
	else
	{
		array::run_all( GetPlayers(), &print_message, message );
	}   
}

function print_message( message )
{
	self util::setclientsysstate( "luaprint", message, self );
}

function register_camo( index, str )
{
	DEFAULT( level.camos, [] );
	level.camos[index] = str;
}

function register_character( index, str )
{
	DEFAULT( level.characters, [] );
	level.characters[index] = str;
}

function register_perk( key, str )
{
    DEFAULT( level.perknames, [] );
    level.perknames[key] = str;
}

function init_camo_strings()
{
    register_camo( 0, &"MPUI_NONE" );
    register_camo( 1, &"XCUI_CAMO_LIGHTNING_RED" );
    register_camo( 2, &"XCUI_CAMO_LIGHTNING_BLUE" );
    register_camo( 3, &"XCUI_CAMO_LIGHTNING_ORANGE" );
    register_camo( 4, &"XCUI_CAMO_LIGHTNING_GREEN" );
    register_camo( 5, &"XCUI_CAMO_LIGHTNING_PURPLE" );
    register_camo( 6, &"XCUI_CAMO_LIGHTNING_WHITE" );
    register_camo( 7, &"XCUI_CAMO_LIGHTNING_PINK" );
    register_camo( 8, &"XCUI_CAMO_LIGHTNING_YELLOW" );
    register_camo( 9, &"XCUI_CAMO_TRANSGRESSION_RED" );
    register_camo( 10, &"XCUI_CAMO_TRANSGRESSION_BLUE" );
    register_camo( 11, &"XCUI_CAMO_TRANSGRESSION_ORANGE" );
    register_camo( 12, &"XCUI_CAMO_TRANSGRESSION_GREEN" );
    register_camo( 13, &"XCUI_CAMO_TRANSGRESSION_PURPLE" );
    register_camo( 14, &"XCUI_CAMO_TRANSGRESSION_WHITE" );
    register_camo( 15, &"MPUI_CAMO_GOLD" );
    register_camo( 16, &"MPUI_CAMO_DIAMOND" );
    register_camo( 17, &"MPUI_CAMO_DARKMATTER" );
    register_camo( 18, &"XCUI_CAMO_AFTERLIFE_RED" );
    register_camo( 19, &"XCUI_CAMO_AFTERLIFE_BLUE" );
    register_camo( 20, &"XCUI_CAMO_AFTERLIFE_ORANGE" );
    register_camo( 21, &"XCUI_CAMO_AFTERLIFE_GREEN" );
    register_camo( 22, &"XCUI_CAMO_AFTERLIFE_PURPLE" );
    register_camo( 23, &"XCUI_CAMO_AFTERLIFE_WHITE" );
    register_camo( 24, &"MPUI_CAMO_WMD" );
    register_camo( 25, &"MPUI_CAMO_REDHEX" );
    register_camo( 26, &"MPUI_CAMO_ZOD_PAP" );
    register_camo( 27, &"MPUI_CAMO_CE_BO3" );
    register_camo( 28, &"MPUI_CAMO_CE_115" );
    register_camo( 29, &"MPUI_CAMO_CE_CYBORG" );
    register_camo( 30, &"MPUI_CAMO_LOYALTY" );
    register_camo( 33, &"MPUI_CAMO_CJ_TAKE_OUT" );
    register_camo( 34, &"MPUI_CAMO_URBAN" );
    register_camo( 35, &"MPUI_CAMO_NUKETOWN" );
    register_camo( 36, &"MPUI_CAMO_TRANSGRESSION" );
    register_camo( 38, &"MPUI_CAMO_STORM" );
    register_camo( 39, &"MPUI_CAMO_WARTORN" );
    register_camo( 40, &"MPUI_CAMO_PRESTIGE_EMISSIVE" );
    register_camo( 42, &"MPUI_CAMO_ETCHING" );
    register_camo( 43, &"MPUI_CAMO_ICE" );
    register_camo( 44, &"MPUI_CAMO_JUNGLE_EARTH" );
    register_camo( 45, &"MPUI_CAMO_JUNGLE_CAT" );
    register_camo( 46, &"MPUI_CAMO_JUNGLE_EMISSIVE" );
    register_camo( 47, &"MPUI_CAMO_SCORCH_CONTRAST" );
    register_camo( 48, &"MPUI_CAMO_SCORCH_GREEN" );
    register_camo( 49, &"MPUI_CAMO_SCORCH_EMISSIVE" );
    register_camo( 50, &"MPUI_CAMO_FLECKTARN_PURPLE" );
    register_camo( 51, &"MPUI_CAMO_FLECKTARN_STEALTH" );
    register_camo( 52, &"MPUI_CAMO_FLECKTARN_EMISSIVE" );
    register_camo( 53, &"MPUI_CAMO_FLECKTARN_SHINY" );
    register_camo( 54, &"MPUI_CAMO_SNOWBLO_GREEN" );
    register_camo( 55, &"MPUI_CAMO_DANTE_CRAZY" );
    register_camo( 56, &"MPUI_CAMO_DANTE_HALLUCINATION" );
    register_camo( 57, &"MPUI_CAMO_DANTE_EMISSIVE" );
    register_camo( 58, &"MPUI_CAMO_INTEGER_PURPLE" );
    register_camo( 59, &"MPUI_CAMO_INTEGER_EMISSIVE" );
    register_camo( 60, &"MPUI_CAMO_ARDENT_EMISSIVE" );
    register_camo( 61, &"MPUI_CAMO_BURNT_SHINY" );
    register_camo( 62, &"MPUI_CAMO_ARTOFWAR_GOLDINK" );
    register_camo( 63, &"MPUI_CAMO_ARTOFWAR_GEM" );
    register_camo( 64, &"MPUI_CAMO_ARTOFWAR_ANIMATION" );
    register_camo( 65, &"MPUI_CAMO_CHAMELEON_SHINY" );
    register_camo( 66, &"MPUI_CAMO_CHAMELEON_EMISSIVE" );
    register_camo( 67, &"MPUI_CAMO_HEATSTROKE_RED" );
    register_camo( 68, &"MPUI_CAMO_HEATSTROKE_EMISSIVE" );
    register_camo( 69, "Underradar" );
    register_camo( 74, &"MPUI_CAMO_BGB74" );
    register_camo( 75, &"MPUI_CAMO_DLC5_REWARD_1" );
    register_camo( 76, &"MPUI_CAMO_DLC5_REWARD_2" );
    register_camo( 77, &"MPUI_CAMO_DLC5_REWARD_3" );
    register_camo( 78, &"MPUI_CAMO_DLC5_REWARD_4" );
    register_camo( 79, &"MPUI_CAMO_DLC5_REWARD_5" );
    register_camo( 80, "Selenite" );
    register_camo( 81, &"MPUI_CAMO_ZMHD_PAP_01" );
    register_camo( 82, &"MPUI_CAMO_NIGHTMARE" );
    register_camo( 83, &"MPUI_CAMO_LOOT_SECTION9_EMISSIVE" );
    register_camo( 84, &"MPUI_CAMO_ZMHD_EVENT_01" );
    register_camo( 85, "Glacial fire" );
    register_camo( 86, &"MPUI_CAMO_PROMO_02" );
    register_camo( 87, "Crimson fire" );
    register_camo( 88, &"MPUI_CAMO_PROMO_03" );
    register_camo( 89, &"MPUI_CAMO_CODXP" );
    register_camo( 93, &"MPUI_CAMO_CODCWL_ANZ_EXCELLENCE" );
    register_camo( 95, &"MPUI_CAMO_CODCWL_ANZ_MINDFREAK" );
    register_camo( 96, &"MPUI_CAMO_CODCWL_ANZ_NV" );
    register_camo( 97, &"MPUI_CAMO_CODCWL_ANZ_ORBIT_GG" );
    register_camo( 98, &"MPUI_CAMO_CODCWL_ANZ_TAINTED_MINDS" );
    register_camo( 99, &"MPUI_CAMO_CODCWL_EU_EPSILON" );
    register_camo( 103, &"MPUI_CAMO_CODCWL_EU_INFUSED" );
    register_camo( 104, &"MPUI_CAMO_CODCWL_EU_LDLC" );
    register_camo( 105, &"MPUI_CAMO_CODCWL_EU_MILLENIUM" );
    register_camo( 106, &"MPUI_CAMO_CODCWL_EU_SPLYCE" );
    register_camo( 107, &"MPUI_CAMO_CODCWL_EU_SUPREMACY" );
    register_camo( 109, &"MPUI_CAMO_CODCWL_NA_CLOUD9" );
    register_camo( 111, &"MPUI_CAMO_CODCWL_NA_ELEVATE" );
    register_camo( 112, &"MPUI_CAMO_CODCWL_NA_ENVYUS" );
    register_camo( 113, &"MPUI_CAMO_CODCWL_NA_FAZE" );
    register_camo( 116, &"MPUI_CAMO_CODCWL_NA_OPTICGAMING" );
    register_camo( 117, &"MPUI_CAMO_CODCWL_NA_RISE_NATION" );
    register_camo( 118, "Ragequit" );
    register_camo( 119, &"MPUI_CAMO_LOOT_CONTRACT_CRYSTALS" );
    register_camo( 121, "Supernova" );
    register_camo( 122, &"MPUI_CAMO_ZMHD_EVENT_02" );
    register_camo( 123, "Abyss" );
    register_camo( 124, &"MPUI_CAMO_ZMHD_LE_01" );
    register_camo( 125, "Nebula" );
    register_camo( 126, &"MPUI_CAMO_ZM_LUCID" );
    register_camo( 131, &"MPUI_MTL_T7_CAMO_LOOT_PATRICKS_03" );
    register_camo( 132, "Circuit" );
    register_camo( 133, "Divinium" );
    register_camo( 134, &"MPUI_CAMO_CHERRY_FIZZ" );
    register_camo( 135, &"MPUI_CAMO_EMPIRE" );
    register_camo( 136, "Permafrost" );
    register_camo( 137, &"MPUI_CAMO_HONEYCOMB_AMBER" );
    register_camo( 138, &"MPUI_CAMO_WATERMELON" );
}

function init_character_strings()
{
	register_character( 0, &"GAMESETTINGS_CHAR_DEMPSEY_FULL" );
	register_character( 1, &"GAMESETTINGS_CHAR_NIKOLAI_FULL" );
	register_character( 2, &"GAMESETTINGS_CHAR_RICHTOFEN_FULL" );
	register_character( 3, &"GAMESETTINGS_CHAR_TAKEO_FULL" );

    register_character( 4, &"GAMESETTINGS_CHAR_DEMPSEY_FULL" );
    register_character( 5, &"GAMESETTINGS_CHAR_NIKOLAI_FULL" );
    register_character( 6, &"GAMESETTINGS_CHAR_RICHTOFEN_FULL" );
    register_character( 7, &"GAMESETTINGS_CHAR_TAKEO_FULL" );

    register_character( 8, &"GAMESETTINGS_CHAR_DEMPSEY_FULL" );
    register_character( 9, &"GAMESETTINGS_CHAR_NIKOLAI_FULL" );
    register_character( 10, &"GAMESETTINGS_CHAR_RICHTOFEN_FULL" );
    register_character( 11, &"GAMESETTINGS_CHAR_TAKEO_FULL" );

    register_character( 12, &"GAMESETTINGS_CHAR_DEMPSEY_FULL" );
    register_character( 13, &"GAMESETTINGS_CHAR_NIKOLAI_FULL" );
    register_character( 14, &"GAMESETTINGS_CHAR_RICHTOFEN_FULL" );
    register_character( 15, &"GAMESETTINGS_CHAR_TAKEO_FULL" );

	register_character( 16, &"GAMESETTINGS_CHAR_BOXER_FULL" );
	register_character( 17, &"GAMESETTINGS_CHAR_DETECTIVE_FULL" );
	register_character( 18, &"GAMESETTINGS_CHAR_FEMME_FULL" );
	register_character( 19, &"GAMESETTINGS_CHAR_MAGICIAN_FULL" );

	register_character( 20, &"GAMESETTINGS_CHAR_KENNEDY_FULL" );
	register_character( 21, &"GAMESETTINGS_CHAR_MCNMARA_FULL" );
	register_character( 22, &"GAMESETTINGS_CHAR_NIXON_FULL" );
	register_character( 23, &"GAMESETTINGS_CHAR_CASTRO_FULL" );

	register_character( 24, &"GAMESETTINGS_CHAR_GELLAR_FULL" );
	register_character( 25, &"GAMESETTINGS_CHAR_ENGLUND_FULL" );
	register_character( 26, &"GAMESETTINGS_CHAR_TREJO_FULL" );
	register_character( 27, &"GAMESETTINGS_CHAR_ROOKER_FULL" );

	register_character( 28, &"GAMESETTINGS_CHAR_RUSSMAN_FULL" );
	register_character( 29, &"GAMESETTINGS_CHAR_STUHLINGER_FULL" );
	register_character( 30, &"GAMESETTINGS_CHAR_MISTY_FULL" );
	register_character( 31, &"GAMESETTINGS_CHAR_MARLTON_FULL" );

	register_character( 32, &"GAMESETTINGS_CHAR_FINN_FULL" );
	register_character( 33, &"GAMESETTINGS_CHAR_SAL_FULL" );
	register_character( 34, &"GAMESETTINGS_CHAR_BILLY_FULL" );
	register_character( 35, &"GAMESETTINGS_CHAR_WEASEL_FULL" );

	register_character( 36, &"GAMESETTINGS_CHAR_BRUNO_FULL" );
	register_character( 37, &"GAMESETTINGS_CHAR_DIEGO_FULL" );
	register_character( 38, &"GAMESETTINGS_CHAR_SCARLETT_FULL" );
	register_character( 39, &"GAMESETTINGS_CHAR_STANTON_FULL" );

	register_character( 40, &"GAMESETTINGS_CHAR_BUTLER_FULL" );
	register_character( 41, &"GAMESETTINGS_CHAR_BRIGADIER_FULL" );
	register_character( 42, &"GAMESETTINGS_CHAR_GYPSY_FULL" );
	register_character( 43, &"GAMESETTINGS_CHAR_GUNSLINGER_FULL" );
}

function init_perk_strings()
{
    register_perk( "specialty_additionalprimaryweapon", &"GAMESETTINGS_PERK_MULEKICK" );
    register_perk( "specialty_armorvest", &"GAMESETTINGS_PERK_JUGGERNOG" );
    register_perk( "specialty_deadshot", &"GAMESETTINGS_PERK_DEADSHOT" );
    register_perk( "specialty_doubletap2", &"GAMESETTINGS_PERK_DOUBLETAP" );
    register_perk( "specialty_electriccherry", &"GAMESETTINGS_PERK_ELECTRICCHERRY" );
    register_perk( "specialty_fastreload", &"GAMESETTINGS_PERK_SPEEDCOLA" );
    register_perk( "specialty_phdflopper", &"GAMESETTINGS_PERK_PHDFLOPPER" );
    register_perk( "specialty_quickrevive", &"GAMESETTINGS_PERK_QUICKREVIVE" );
    register_perk( "specialty_staminup", &"GAMESETTINGS_PERK_STAMINUP" );
    register_perk( "specialty_tombstone", &"GAMESETTINGS_PERK_TOMBSTONE" );
    register_perk( "specialty_vultureaid", &"GAMESETTINGS_PERK_VULTUREAID" );
    register_perk( "specialty_whoswho", &"GAMESETTINGS_PERK_WHOSWHO" );
    register_perk( "specialty_widowswine", &"GAMESETTINGS_PERK_WIDOWSWINE" );
}