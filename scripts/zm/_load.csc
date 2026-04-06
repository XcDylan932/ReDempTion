#using scripts\codescripts\struct;

#using scripts\shared\abilities\_ability_player;
#using scripts\shared\archetype_shared\archetype_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfaceanim_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\footsteps_shared;
#using scripts\shared\load_shared;
#using scripts\shared\music_shared;
#using scripts\shared\_oob;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;

//#using scripts\zm\_xcdylan93\genesis\_zm_patch;
//#using scripts\zm\_xcdylan93\moon\_zm_patch;
#using scripts\zm\_xcdylan93\_zm_patch;

#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\gametypes\_weaponobjects;
#using scripts\zm\_ambient;
#using scripts\zm\_callbacks;
#using scripts\zm\_destructible;
#using scripts\zm\_global_fx;
#using scripts\zm\_radiant_live_update;
#using scripts\zm\_sticky_grenade;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_traps;
#using scripts\zm\_zm_playerhealth;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace load;

function main()
{
	zm::init();
	level thread server_time();
	level thread util::init_utility();
	util::register_system( "levelNotify", &levelnotifyhandler );
	register_clientfields();
	level.createFX_disable_fx = GetDvarInt( "disable_fx" ) == 1;
	if( IS_TRUE( level._uses_sticky_grenades ) )
	{
		level thread _sticky_grenade::main();
	}
	system::wait_till( "all" );
	level thread load::art_review();
	level flagsys::set( "load_main_complete" );
}

function server_time()
{
	for(;;)
	{
		level.serverTime = GetServerTime(0);
		wait 0.01;
	}
}

function register_clientfields()
{
	clientfield::register( "allplayers", "zmbLastStand", VERSION_SHIP, 1, "int", &zm::Laststand, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "clientuimodel", "zmhud.swordEnergy", VERSION_SHIP, 7, "float", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "clientuimodel", "zmhud.swordState", VERSION_SHIP, 4, "int", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "clientuimodel", "zmhud.swordChargeUpdate", VERSION_SHIP, 1, "counter", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
}

function levelnotifyhandler( localclientnum, state, oldState )
{
	if( state != "" )
	{
		level notify( state, localclientnum );
	}
}

function warnMissileLocking( localclientnum, set ){}
function warnMissileLocked( localclientnum, set ){}
function warnMissileFired( localclientnum, set ){}