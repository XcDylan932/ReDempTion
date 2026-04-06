#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\_character_customization;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;

#namespace multi_extracam;

function autoexec campfireoverride()
{
	if( !isdefined( world.campfire_characters ) )
	{
		world.campfire_characters = SpawnStruct();
		world.campfire_characters.character_sets = [];
		world.campfire_characters.character_sets[0] = array( "c_zom_der_dempsey_mpc_fb", "c_zom_der_nikolai_mpc_fb", "c_zom_der_richtofen_mpc_fb", "c_zom_der_takeo_mpc_fb" );
		world.campfire_characters.character_sets[1] = array( "c_t7_zm_dlchd_waw_dempsey_mpc_fb", "c_t7_zm_dlchd_nikolai_waw_mpc_fb", "c_t7_zm_dlchd_richtofen_waw_mpc_fb", "c_t7_zm_dlchd_waw_takeo_mpc_fb" );
		world.campfire_characters.character_sets[2] = array( "ww2_char_mp_m43_base_pb", "ww2_char_mp_ruswinter_base_pb", "ww2_char_mp_valtunic_base_pb", "ww2_char_mp_regiment_base_pb" );
		world.campfire_characters.character_sets[3] = array( "c_sat_usa_pl_amber_drained_mpc_fb", "c_sat_rus_pl_magenta_drained_mpc_fb", "c_sat_ger_pl_purple_drained_mpc_fb", "c_sat_jpn_pl_scarlet_drained_mpc_fb" );
		world.campfire_characters.character_sets[4] = array( "floyd_fb", "jackie_fb", "jessica_fb", "nero_fb" );
		world.campfire_characters.character_sets[5] = array( "t5_jfk_fb", "t5_mcnamara_fb", "t5_nixon_fb", "t5_castro_fb" );
		world.campfire_characters.character_sets[6] = array( "t5_smg_fb", "t5_eng_fb", "t5_trejo_fb", "t5_rooker_fb" );
		world.campfire_characters.character_sets[7] = array( "c8_zm_russman_fullbody", "c8_zm_stuhlinger_fullbody", "c8_zm_misty_fullbody", "c8_zm_marlton_fullbody" );
		world.campfire_characters.character_sets[8] = array( "c_zom_player_oleary_fb", "c_zom_player_deluca_fb", "c_zom_player_handsome_fb", "c_zom_player_arlington_fb" );
		world.campfire_characters.character_sets[9] = array( "c_t8_zmb_hero_bruno_mpc_fb", "c_t8_zmb_hero_diego_mpc_fb", "c_t8_zmb_hero_scarlett_mpc_fb", "c_t8_zmb_hero_stanton_mpc_fb" );
		world.campfire_characters.character_sets[10] = array( "c_t8_zmb_dlc1_butler_mpc_fb", "c_t8_zmb_dlc1_brigadier_mpc_fb", "c_t8_zmb_dlc1_gypsy_mpc_fb", "c_t8_zmb_dlc1_gunslinger_mpc_fb" );
	}
	callback::on_localclient_connect( &on_connect );
}

function on_connect( localclientnum )
{
	waittillframeend;
	zm_lobby_room( localclientnum );
	if( isdefined( level.client_menus ) && isdefined( level.client_menus[localclientnum] ) && isdefined( level.client_menus[localclientnum]["Main"] ) )
	{
		level.client_menus[localclientnum]["Main"].default_camera = level.client_menus[localclientnum]["Main"].camera_function;
		level.client_menus[localclientnum]["Main"].camera_function = &lobby_main;
		level.client_menus[localclientnum]["Pregame_Main"].default_camera = level.client_menus[localclientnum]["Pregame_Main"].camera_function;
		level.client_menus[localclientnum]["Pregame_Main"].camera_function = &lobby_main;
	}
}

function lobby_main( localclientnum, menu_name, state )
{
	if( StrStartsWith( state, "zm" ) )
	{
		level notify( "new_lobby" );
		SetPBGActiveBank( localclientnum, 1 );
		SetStreamerRequest( 0, "core_frontend_zm_lobby" );
		camera_ent = struct::get( "zm_frontend_camera" );
		if( isdefined( camera_ent ) )
		{
			PlayMainCamXCam( localclientnum, "zm_lobby_cam", 0, "default", "", camera_ent.origin, camera_ent.angles );
		}
		zm_lobby_room( localclientnum );
	}
	else
	{
		level thread [[ level.client_menus[localclientnum][menu_name].default_camera ]]( localclientnum, menu_name, state );
	}
}

function zm_lobby_room( localclientnum )
{
	s_scene = struct::get_script_bundle( "scene", "cin_fe_zm_forest_vign_sitting" );
	if( !isdefined( s_scene ) )
	{
		return;
	}
	s_params = SpawnStruct();
	s_params.scene = s_scene.name;
	s_params.sessionmode = 0;
	if( isdefined( level.zm_lobby_data_struct ) )
	{
		set_campfire_character( localclientnum, level.zm_lobby_data_struct );
		character_customization::update( localclientnum, level.zm_lobby_data_struct, s_params );
	}
}

function set_campfire_character( localclientnum, struct )
{
	DEFAULT( world.character_bodymodels, [] );
	if( !isdefined( world.character_bodymodels[localclientnum] ) )
	{
		world.character_bodymodels[localclientnum] = get_random_character();
	}
	struct.bodymodel = world.character_bodymodels[localclientnum];
	if( isdefined( struct.bodymodel ) )
	{
		struct.charactermodel SetModel( struct.bodymodel );
	}
	struct.mode_render_options = GetCharacterModeRenderOptions( 0 );
	struct.body_render_options = GetCharacterBodyRenderOptions( 0, 0, 0, 0, 0 );
	struct.helmet_render_options = GetCharacterHelmetRenderOptions( 0, 0, 0, 0, 0 );
	struct.head_render_options = GetCharacterHeadRenderOptions( 0 );
}

function get_random_character()
{
	index = RandomInt(4);
	set = array::random( array( 0, 4, 5, 6, 7, 8, 9, 10 ) );
	if( set == 0 )
	{
		set = RandomInt(4);
	}
	return world.campfire_characters.character_sets[set][index];
}

// EXISTING CODE DO NOT CHANGE
function extracam_reset_index( localclientnum, index )
{
	if( !isdefined( level.camera_ents ) || !isdefined( level.camera_ents[localclientnum] ) )
	{
		return;
	}
	if( isdefined( level.camera_ents[localclientnum][index] ) )
	{
		level.camera_ents[localclientnum][index] ClearExtraCam();
		level.camera_ents[localclientnum][index] Delete();
		level.camera_ents[localclientnum][index] = undefined;
	}
}

function extracam_init_index( localclientnum, target, index )
{
	camerastruct = struct::get( target );
	return extracam_init_item( localclientnum, camerastruct, index );
}

function extracam_init_item( localclientnum, copy_ent, index )
{
	DEFAULT( level.camera_ents, [] );
	DEFAULT( level.camera_ents[localclientnum], [] );
	if( isdefined( level.camera_ents[localclientnum][index] ) )
	{
		level.camera_ents[localclientnum][index] ClearExtraCam();
		level.camera_ents[localclientnum][index] Delete();
		level.camera_ents[localclientnum][index] = undefined;
	}
	if( isdefined( copy_ent ) )
	{
		level.camera_ents[localclientnum][index] = Spawn( localclientnum, copy_ent.origin, "script_origin" );
		level.camera_ents[localclientnum][index].angles = copy_ent.angles;
		level.camera_ents[localclientnum][index] SetExtraCam( index );
		return level.camera_ents[localclientnum][index];
	}
	return undefined;
}