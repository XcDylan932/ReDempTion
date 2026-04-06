#using scripts\codescripts\struct;

#using scripts\shared\abilities\_ability_player;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\archetype_shared\archetype_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\load_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\music_shared;
#using scripts\shared\_oob;
#using scripts\shared\scene_shared;
#using scripts\shared\serverfaceanim_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;

//#using scripts\zm\_xcdylan93\genesis\_zm_patch;
//#using scripts\zm\_xcdylan93\moon\_zm_patch;
#using scripts\zm\_xcdylan93\_zm_patch;

#using scripts\zm\gametypes\_clientids;
#using scripts\zm\gametypes\_scoreboard;
#using scripts\zm\gametypes\_serversettings;
#using scripts\zm\gametypes\_shellshock;
#using scripts\zm\gametypes\_spawnlogic;
#using scripts\zm\gametypes\_spectating;
#using scripts\zm\gametypes\_weaponobjects;
#using scripts\zm\_art;
#using scripts\zm\_callbacks;
#using scripts\zm\_destructible;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_behavior;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_bot;
#using scripts\zm\_zm_clone;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_playerhealth;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_traps;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace load;

function main()
{
	zm::init();
	level._loadStarted = true;
	register_clientfields();
	level.aiTriggerSpawnFlags = GetAITriggerFlags();
	level.vehicleTriggerSpawnFlags = GetVehicleTriggerFlags();
	level thread start_intro_screen_zm(); 	
	system::wait_till( "all" );
	level thread load::art_review();
 	level flagsys::set( "load_main_complete" );
}

function start_intro_screen_zm()
{
	players = GetPlayers();
	for( i = 0; i < players.size; i++ )
	{
		players[i] lui::screen_fade_out( 0, undefined );
		players[i] FreezeControls( true );
	}
	wait 1;
}

function register_clientfields()
{
	clientfield::register( "allplayers", "zmbLastStand", VERSION_SHIP, 1, "int" );
	clientfield::register( "clientuimodel", "zmhud.swordEnergy", VERSION_SHIP, 7, "float" );
	clientfield::register( "clientuimodel", "zmhud.swordState", VERSION_SHIP, 4, "int" );
	clientfield::register( "clientuimodel", "zmhud.swordChargeUpdate", VERSION_SHIP, 1, "counter" );
}