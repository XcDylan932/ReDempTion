#using scripts\codescripts\struct;
#using scripts\shared\ai\animation_selector_table_evaluators;
#using scripts\shared\ai\archetype_cover_utility;
#using scripts\shared\ai\archetype_damage_effects;
#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\behavior_state_machine_planners_utility;
#using scripts\shared\ai\zombie;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\player_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;

#using_animtree( "all_player" );

#namespace frontend;

function callback_actorspawnedfrontend( spawner )
{
	self thread spawner::spawn_think( spawner );
}

function main()
{
	level.callbackstartgametype = &callback_void;
	level.callbackplayerconnect = &callback_playerconnect;
	level.callbackplayerdisconnect = &callback_void;
	level.callbackentityspawned = &callback_void;
	level.callbackactorspawned = &callback_actorspawnedfrontend;
	level.orbis = GetDvarString( "orbisGame" ) == "true";
	level.durango = GetDvarString( "durangoGame" ) == "true";
	level.frontend_characters = init_frontend_characters();
	scene::add_scene_func( "sb_frontend_black_market", &black_market_play, "play" );
	clientfield::register( "world", "first_time_flow", 1, GetMinBitCountForNum(1), "int" );
	clientfield::register( "world", "cp_bunk_anim_type", 1, GetMinBitCountForNum(1), "int" );
	clientfield::register( "actor", "zombie_has_eyes", 1, 1, "int" );
	clientfield::register( "scriptmover", "dni_eyes", 1000, 1, "int" );
	level.weaponnone = GetWeapon( "none" );
	level thread zm_frontend_zombie_logic();
	level thread set_current_safehouse_on_client();
	level thread reset_frontend_character_models();
}

function reset_frontend_character_models()
{
	wait 1;
	
	character = undefined;
	if( isdefined( level.frontend_characters ) )
	{
		if( !IsArray( level.frontend_characters ) )
		{
			level.frontend_characters = array( level.frontend_characters );
		}

		character = array::random( level.frontend_characters );
	}
	
	if( isdefined( character ) )
	{
		lobby_guys = GetEntArray( "sb_frontend_pressstart_character", "targetname" );
		foreach( guy in lobby_guys )
		{
			guy SetModel( character );
			guy SetHighDetail(1);
		}
	}
}

function init_frontend_characters()
{	
	candidates = array(
		// "c_t8_zmb_hero_bruno_mpc_fb",
		// "c_t8_zmb_hero_diego_mpc_fb",
		// "c_t8_zmb_hero_scarlett_mpc_fb",
		// "c_t8_zmb_hero_stanton_mpc_fb",
		// "t5_eng_fb",
		// "t5_smg_fb",
		// "t5_rooker_fb",
		// "t5_trejo_fb",
		// "c_t8_zmb_dlc1_brigadier_mpc_fb",
		// "c_t8_zmb_dlc1_butler_mpc_fb",
		// "c_t8_zmb_dlc1_gunslinger_mpc_fb",
		// "c_t8_zmb_dlc1_gypsy_mpc_fb",
		// "t5_castro_fb",
		// "t5_jfk_fb",
		// "t5_mcnamara_fb",
		// "t5_nixon_fb",
		// "c_zom_player_handsome_fb",
		// "c_zom_player_oleary_fb",
		// "c_zom_player_deluca_fb",
		// "c_zom_player_arlington_fb",
		"c8_zm_marlton_fullbody",
		"c8_zm_misty_fullbody",
		"c8_zm_russman_fullbody",
		"c8_zm_stuhlinger_fullbody",
		"ww2_char_mp_m43_base_pb",
		"ww2_char_mp_ruswinter_base_pb",
		"ww2_char_mp_valtunic_base_pb",
		"ww2_char_mp_regiment_base_pb",
		"floyd_fb",
		"jackie_fb",
		"jessica_fb",
		"nero_fb"
	);
	return candidates;
}

function callback_void(){}

function set_current_safehouse_on_client()
{
	wait 0.05;
	if( world.is_first_time_flow !== 0 )
	{
		world.cp_bunk_anim_type = 0;
		level clientfield::set("first_time_flow", 1);
	}
	else
	{
		world.cp_bunk_anim_type = ( RandomInt(2) ? 0 : 1 );
		level clientfield::set( "cp_bunk_anim_type", world.cp_bunk_anim_type );
	}
}

function zm_frontend_zombie_logic()
{
	heads = array( "zom_head_fdr02_org1", "zom_head_fdr03_org1", "zom_head_fdr04_org1", "c_t8_zmb_ofc_zombie_male_head1", "c_t8_zmb_ofc_zombie_male_head2", "c_t8_zmb_ofc_zombie_male_head3", "c_t8_zmb_ofc_zombie_male_head4", "c_t8_zmb_ofc_zombie_male_head5", "c_t8_zmb_ofc_zombie_male_head6" );
	cosmo_heads = array( "c_zom_dlchd_cosmo_cosmon_head", "c_zom_dlchd_cosmo_cosmon_head2", "c_zom_dlchd_cosmo_cosmon_head3", "c_zom_dlchd_cosmo_cosmon_head4", "c_zom_dlchd_cosmo_cosmon_head5" );
	moon_heads = array( "c_t7_zm_dlchd_moon_tech_head", "c_t7_zm_dlchd_moon_tech_head2", "c_t7_zm_dlchd_moon_tech_head3", "c_t7_zm_dlchd_moon_tech_head4" );
	hats = array( "zom_m34cap_org1", "zom_m40helmet_net1", "zom_m40helmet_org1", "zom_m40helmet_org2", "zom_m40officercap_org1", "zom_m42cap_org1", "zom_m43cap_org1", "zom_m43cap_org2", "zom_m43overseacap_org1" );
	moon_hats = array( "c_t7_zm_dlchd_moon_tech_cap", "c_t7_zm_dlchd_moon_tech_cap_green", "c_t7_zm_dlchd_moon_tech_cap_orange" );
	bodies = array(
		array( "c_zom_dlchd_pro_honorguard_zombie_body2", heads, hats ),
		array( "c_zom_dlchd_pro_honorguard_zombie_body1", heads, hats ),
		array( "zom_snipera_body", heads, hats ),
		array( "zom_infantrya_body", heads, hats ),
		array( "c_t8_zmb_ofc_zombie_male_body1", cosmo_heads ),
		array( "c_t8_zmb_ofc_zombie_male_body2", cosmo_heads, hats ),
		array( "c_t8_zmb_ofc_zombie_male_body3", cosmo_heads ),
		array( "c_t7_zm_dlchd_shangrila_fem_body", array( "c_t7_zm_dlchd_shangrila_fem_head" ) ),
		array( "c_t7_zm_dlchd_shangrila_nva_body", array( "c_t7_zm_dlchd_shangrila_nva_head", "c_t7_zm_dlchd_shangrila_nva_head2" ) ),
		array( "c_t7_zm_dlchd_shangrila_vietcong_body", array( "c_t7_zm_dlchd_shangrila_vietcong_head" ) ),
		array( "c_t7_zm_dlchd_moon_tech_body1", moon_heads, moon_hats ),
		array( "c_t7_zm_dlchd_moon_tech_body2", moon_heads, moon_hats )
	);
	special_bodies = array(
		"c_t7_zm_dlchd_shangrila_napalm_mini_fb",
		"c_t7_zm_dlchd_shangrila_sonic_mini_fb"
	);

	wait 5;
	a_sp_zombie = GetEntArray( "sp_zombie_frontend", "targetname" );

	for(;;)
	{
		a_sp_zombie = array::randomize( a_sp_zombie );
		foreach( sp_zombie in a_sp_zombie )
		{
			while( GetAICount() >= 20 )
			{
				wait 1;
			}

			ai_zombie = sp_zombie SpawnFromSpawner();
			if( isdefined( ai_zombie ) )
			{
				if( RandomInt(100) < 10 )
				{
					ai_zombie DetachAll();
					ai_zombie SetModel( array::random( special_bodies ) );
				}
				else
				{
					wait 0.05;
					body = array::random( bodies );
					ai_zombie SetModel( body[0] );
					ai_zombie.head = array::random( body[1] );
					ai_zombie.hatmodel = undefined;
					if( isdefined( body[2] ) && body[2].size && RandomInt(10) > 3 )
					{
						ai_zombie.hatmodel = array::random( body[2] );
					}
					ai_zombie DetachAll();
					ai_zombie Attach( ai_zombie.head, "", 1 );
					if( isdefined( ai_zombie.hatmodel ) )
					{
						ai_zombie Attach( ai_zombie.hatmodel, "", 1 );
					}
				}

				ai_zombie SetHighDetail(1);
				ai_zombie SetAvoidanceMask( "avoid all" );
				ai_zombie PushActors(0);
				ai_zombie clientfield::set( "zombie_has_eyes", 1 );
				ai_zombie.delete_on_path_end = 1;
				ai_zombie.disabletargetservice = 1;
				ai_zombie.ignoreall = 1;
				sp_zombie.count++;
			}
			wait RandomFloatRange( 3, 8 );
		}
	}
}

function callback_playerconnect()
{
	self thread black_market_dialog();
}

function black_market_play( a_ents )
{
	level.blackmarketsceneorigin = self.origin;
	level.blackmarketsceneangles = self.angles;
	level.blackmarketdealer = a_ents["sb_frontend_black_market_character"];
	level.blackmarketdealertumbler = a_ents["lefthand"];
	level.blackmarketdealerpistol = a_ents["righthand"];
	level scene::stop( "sb_frontend_black_market" );
	level.blackmarketdealer clientfield::set( "dni_eyes", 1 );
}

function black_market_dialog()
{
	self endon( "disconnect" );
	
	for(;;)
	{
		self waittill( "menuresponse", menu, response );
		if( menu != "BlackMarket" )
		{
			continue;
		}

		switch( response )
		{
			case "greeting":
				thread play_black_market_greeting_animations();
				break;

			case "greeting_first":
				play_black_market_dialog( "vox_mark_greeting_first" );
				break;

			case "greeting_broke":
				thread play_black_market_broke_animations();
				break;
			
			case "roll":
				play_black_market_dialog( "vox_mark_roll_in_progress" );
				break;
			
			case "complete_common":
				play_black_market_dialog( "vox_mark_complete_common" );
				break;
			
			case "complete_rare":
				play_black_market_dialog( "vox_mark_complete_rare" );
				break;
			
			case "complete_legendary":
				play_black_market_dialog( "vox_mark_complete_legendary" );
				break;

			case "complete_epic":
				play_black_market_dialog( "vox_mark_complete_epic" );
				break;

			case "burn_duplicates":
				thread play_black_market_burn_animations();
				break;

			case "stopsounds":
				level.blackmarketdealer StopSounds();
				break;

			case "closed":
				level.blackmarketdealer StopSounds();
				level.blackmarketdealer thread animation::stop(0.2);
				level.blackmarketdealertumbler thread animation::stop(0.2);
				level.blackmarketdealerpistol thread animation::stop(0.2);
				level.blackmarketdealer notify( "closed" );
				break;
		}
	}
}

function play_black_market_dialog( dialogalias )
{
	if( !isdefined( dialogalias ) )
	{
		return;
	}
	level.blackmarketdealer StopSounds();
	level.blackmarketdealer PlaySoundOnTag( dialogalias, "J_Head" );
}

function play_black_market_1st_greeting()
{
	if( getlocalprofileint( "com_firsttime_blackmarket" ) )
	{
		return false;
	}
	level.blackmarketdealer endon( "closed" );
	play_black_market_animations( "pb_black_marketeer_1st_time_greeting_", "o_black_marketeer_tumbler_1st_time_greeting_", "o_black_marketeer_pistol_1st_time_greeting_", "01" );
	level.blackmarketdealer waittill( "finished_black_market_animation" );
	setlocalprofilevar( "com_firsttime_blackmarket", 1 );
	return true;
}

function play_black_market_greeting_animations()
{
	level.blackmarketdealer endon( "closed" );
	if( play_black_market_1st_greeting() )
	{
		return;
	}
	animnumber = pick_black_market_anim(11);
	play_black_market_animations( "pb_black_marketeer_greeting_", "o_black_marketeer_tumbler_greeting_", "o_black_marketeer_pistol_greeting_", animnumber );
}

function play_black_market_broke_animations()
{
	level.blackmarketdealer endon( "closed" );
	if( play_black_market_1st_greeting() )
	{
		return;
	}
	animnumber = pick_black_market_anim(10);
	play_black_market_animations( "pb_black_marketeer_insufficient_funds_", "o_black_marketeer_tumbler_insufficient_funds_", "o_black_marketeer_pistol_insufficient_funds_", animnumber );
}

function play_black_market_burn_animations()
{
	animnumber = pick_black_market_anim(6);
	play_black_market_animations( "pb_black_marketeer_burn_dupes_", "o_black_marketeer_tumbler_burn_dupes_", "o_black_marketeer_pistol_burn_dupes_", animnumber );
}

function pick_black_market_anim( animcount )
{
	animnumber = RandomInt( animcount );
	return( animnumber < 10 ? "0"+animnumber : animnumber );
}

function play_black_market_animations( dealeranim, tumbleranim, pistolanim, animnumber = "" )
{
	level.blackmarketdealer StopSounds();
	level.blackmarketdealer thread play_black_market_animation( dealeranim + animnumber, "pb_black_marketeer_idle", level.blackmarketsceneorigin, level.blackmarketsceneangles );
	level.blackmarketdealertumbler thread play_black_market_animation( tumbleranim + animnumber, "o_black_marketeer_tumbler_idle", level.blackmarketdealer, "tag_origin" );
	level.blackmarketdealerpistol thread play_black_market_animation( pistolanim + animnumber, "o_black_marketeer_pistol_idle", level.blackmarketdealer, "tag_origin" );
}

function play_black_market_animation( animname, idleanimname, originent, tagangles )
{
	self notify( "play_black_market_animation" );
	self endon( "play_black_market_animation" );
	level.blackmarketdealer endon( "closed" );
	self thread animation::stop(0.2);
	self animation::play( animname, originent, tagangles, 1, 0.2, 0.2 );
	self notify( "finished_black_market_animation" );
	self thread animation::play( idleanimname, originent, tagangles, 1, 0.2, 0 );
}