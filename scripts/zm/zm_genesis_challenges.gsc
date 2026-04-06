#using scripts\codescripts\struct;

#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;

#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace zm_genesis_challenges;

REGISTER_SYSTEM( "zm_genesis_challenges", &__init__, undefined )

function __init__()
{
	callback::on_spawned( &on_player_spawned );
}

function init_clientfields()
{
	clientfield::register( "clientuimodel", "trialWidget.visible", VERSION_DLC4, 1, "int" );
	clientfield::register( "clientuimodel", "trialWidget.progress", VERSION_DLC4, 7, "float" );
	clientfield::register( "clientuimodel", "trialWidget.icon", VERSION_DLC4, 2, "int" );
	clientfield::register( "toplayer", "challenge1state", VERSION_DLC4, 2, "int" );
	clientfield::register( "toplayer", "challenge2state", VERSION_DLC4, 2, "int" );
	clientfield::register( "toplayer", "challenge3state", VERSION_DLC4, 2, "int" );
	clientfield::register( "toplayer", "challenge_board_eyes", VERSION_DLC4, 1, "int" );
	clientfield::register( "scriptmover", "challenge_board_base", VERSION_DLC4, 1, "int" );
	clientfield::register( "scriptmover", "challenge_board_reward", VERSION_DLC4, 1, "int" );
}

function main()
{
	level flag::init( "all_challenges_completed" );
	level flag::init( "flag_init_player_challenges" );
	if( GetDvarInt( "splitscreen_playerCount" ) > 2 )
	{
		array::run_all( GetEntArray( "t_lookat_challenge_1", "targetname" ), &Delete );
		array::run_all( GetEntArray( "t_lookat_challenge_2", "targetname" ), &Delete );
		array::run_all( GetEntArray( "t_lookat_challenge_3", "targetname" ), &Delete );
		array::thread_all( struct::get_array( "s_challenge_trigger" ), &struct::delete );
	}
	else
	{
		level.s_challenges = SpawnStruct();
		level.s_challenges.a_challenge_1 = array(
			register_challenge( 1, &"ZM_GENESIS_CHALLENGE_1_1", 10, "update_challenge_trap_kills", &trap_kill_challenge ),
			//register_challenge( 1, &"ZM_GENESIS_CHALLENGE_1_2", 15, "update_challenge_beam_kills", &beam_kill_challenge ),
			register_challenge( 1, &"ZM_GENESIS_CHALLENGE_1_5", 10, "update_challenge_fury_headshots", &fury_headshot_challenge ),
			register_challenge( 1, &"ZM_GENESIS_CHALLENGE_1_8", 1, "update_challenge_shield_acquisition", &shield_acquisition_challenge ),
			//register_challenge( 1, &"ZM_GENESIS_CHALLENGE_1_10", 1, "update_challenge_keeper_altar_construction", &keeper_altar_construction_challenge ),
			register_challenge( 1, &"ZM_GENESIS_CHALLENGE_3_6", 1, "update_challenge_no_kill_corrupteng", &no_kill_corrupteng_challenge )
		);
		level.s_challenges.a_challenge_2 = array(
			register_challenge( 2, &"ZM_GENESIS_CHALLENGE_2_2", 10, "update_challenge_turret_ricochet", &turret_ricochet_challenge ),
			register_challenge( 2, &"ZM_GENESIS_CHALLENGE_2_7", 1, "update_challenge_survive_nacht", &survive_nacht_challenge ),
			register_challenge( 2, &"ZM_GENESIS_CHALLENGE_2_8", 15, "update_challenge_spider_kills", &spider_kills_challenge ),
			register_challenge( 2, &"ZM_GENESIS_CHALLENGE_1_9", 10, "update_challenge_riotshield_spider_kills", &riotshield_spider_kill_challenge ),
			register_challenge( 2, &"ZM_GENESIS_CHALLENGE_2_10", 10, "update_challenge_flinger_kills", &flinger_kill_challenge ),
			register_challenge( 2, &"ZM_GENESIS_CHALLENGE_2_11", 1, "update_challenge_island_mastery", &island_mastery_challenge )
		);
		level.s_challenges.a_challenge_3 = array(
			register_challenge( 3, &"ZM_GENESIS_CHALLENGE_3_1", 5, "update_challenge_other_island_kills", &other_island_kills_challenge ),
			register_challenge( 3, &"ZM_GENESIS_CHALLENGE_3_2", 1, "update_challenge_mechz_damage", &mechz_damage_challenge ),
			register_challenge( 3, &"ZM_GENESIS_CHALLENGE_3_3", 1, "update_challenge_3shot_margwa_kill", &three_shot_margwa_kill_challenge ),
			register_challenge( 3, &"ZM_GENESIS_CHALLENGE_3_3", 1, "update_challenge_3shot_margwa_kill", &three_shot_margwa_kill_challenge )
			//register_challenge( 3, &"ZM_GENESIS_CHALLENGE_3_4", 1, "update_challenge_elemental_margwa_kills", &elemental_margwa_kill_challenge ),
			//register_challenge( 3, &"ZM_GENESIS_CHALLENGE_3_9", 3, "update_challenge_apothicon_marwa_kill", &apothicon_margwa_kill_challenge ),
			//register_challenge( 3, &"ZM_GENESIS_CHALLENGE_2_9", 1, "update_challenge_survive_apothicon", &survive_apothicon_challenge )
		);

		zm_spawner::register_zombie_death_event_callback( &zombie_death_trial_monitor );
		zm_spawner::register_zombie_damage_callback( &check_non_melee_damage_trial );
		level._margwa_damage_cb = &function_ca31caac;
		level thread all_challenges_completed();
		level flag::set( "flag_init_player_challenges" );
	}
}

function register_challenge( n_challenge_index, str_challenge_info, n_count, str_challenge_notify, func_think )
{
	s_challenge = SpawnStruct();
	s_challenge.n_index = n_challenge_index;
	s_challenge.str_info = str_challenge_info;
	s_challenge.n_count = n_count;
	s_challenge.str_notify = str_challenge_notify;
	s_challenge.func_think = func_think;
	return s_challenge;
}

function on_player_connect()
{
	level flag::wait_till( "flag_init_player_challenges" );
	self flag::init( "flag_player_collected_reward_1" );
	self flag::init( "flag_player_collected_reward_2" );
	self flag::init( "flag_player_collected_reward_3" );
	self flag::init( "flag_player_completed_challenge_1" );
	self flag::init( "flag_player_completed_challenge_2" );
	self flag::init( "flag_player_completed_challenge_3" );
	self flag::init( "flag_player_initialized_reward" );
	self.s_challenges = SpawnStruct();
	self.s_challenges.a_challenge_1 = [];
	self.s_challenges.a_challenge_2 = [];
	self.s_challenges.a_challenge_3 = [];
	self.s_challenges.a_challenge_1 = array::random( level.s_challenges.a_challenge_1 );
	self.s_challenges.a_challenge_2 = array::random( level.s_challenges.a_challenge_2 );
	self.s_challenges.a_challenge_3 = array::random( level.s_challenges.a_challenge_3 );
	ArrayRemoveValue( level.s_challenges.a_challenge_1, self.s_challenges.a_challenge_1 );
	ArrayRemoveValue( level.s_challenges.a_challenge_2, self.s_challenges.a_challenge_2 );
	ArrayRemoveValue( level.s_challenges.a_challenge_3, self.s_challenges.a_challenge_3 );
	self thread player_challenge_init();
}

function on_player_disconnect()
{
	level flag::wait_till( "flag_init_player_challenges" );
	array::add( level.s_challenges.a_challenge_1, self.s_challenges.a_challenge_1 );
	array::add( level.s_challenges.a_challenge_2, self.s_challenges.a_challenge_2 );
	array::add( level.s_challenges.a_challenge_3, self.s_challenges.a_challenge_3 );
}

function on_player_spawned()
{
	self.a_island_progress = [];
	self thread monitor_round_reset();
	self thread monitor_board_activation();
}

function monitor_board_activation()
{
	self endon( "death" );
	level flag::wait_till_all( array( "start_zombie_round_logic", "challenge_boards_ready" ) );
	self clientfield::set_to_player( "challenge_board_eyes", 1 );
}

function monitor_round_reset()
{
	self endon( "disconnect" );
	for(;;)
	{
		self init_player_island_progress();
		level waittill( "end_of_round" );
	}
}

function init_player_island_progress()
{
	self.a_island_progress["prison_island"] = 0;
	self.a_island_progress["asylum_island"] = 0;
	self.a_island_progress["temple_island"] = 0;
	self.a_island_progress["prototype_island"] = 0;
	self.a_island_progress["start_island"] = 0;
}

function update_challenge_description_ui( str_new_description )
{
	if( self.challenge_text !== str_new_description )
	{
		self.challenge_text = str_new_description;
		self LUINotifyEvent( &"trial_set_description", 1, self.challenge_text );
	}
}

function update_interaction_hints( player, n_challenge_index )
{
	switch( n_challenge_index )
	{
		case 1:
			player update_challenge_description_ui( player.s_challenges.a_challenge_1.str_info );
			break;
		
		case 2:
			player update_challenge_description_ui( player.s_challenges.a_challenge_2.str_info );
			break;
		
		case 3:
			player update_challenge_description_ui( player.s_challenges.a_challenge_3.str_info );
			break;
	}
}

function set_challenge_state( n_challenge_index, n_state )
{
	self clientfield::set_to_player( "challenge" + n_challenge_index + "state", n_state );
}

function monitor_challenge_hint_interactions( trigger )
{
	self notify( "monitor_challenge_hint_interactions" );
	self endon( "monitor_challenge_hint_interactions" );
	for(;;)
	{
		wait 0.5;
		if( !isdefined( self ) )
		{
			break;
		}
		if( !isdefined( trigger ) || Distance( self.origin, trigger.stub.origin ) > trigger.stub.radius )
		{
			self clientfield::set_player_uimodel( "trialWidget.visible", 0 );
			break;
		}
	}
}

function init_challenge_boards()
{
	level flag::init( "challenge_boards_ready" );
	level.a_e_challenge_boards = [];
	for( x = 0; x < 4; x++ )
	{
		str_name = "challenge_board_" + x;
		e_board = GetEnt( str_name, "targetname" );
		ARRAY_ADD( level.a_e_challenge_boards, e_board );
		v_origin = e_board GetTagOrigin( "tag_fx_skull_top" );
		v_angles = e_board GetTagAngles( "tag_fx_skull_top" );
		e_board thread scene::play( "p7_fxanim_zm_gen_challenge_prizestone_close_bundle", e_board );
		wait 0.2;
		e_board clientfield::set( "challenge_board_base", 1 );
	}
	level flag::set( "challenge_boards_ready" );
	for( i = 1; i <= 3; i++ )
	{
		foreach( t_lookat in GetEntArray( "t_lookat_challenge_" + i, "targetname" ) )
		{
			t_lookat SetInvisibleToAll();
		}
	}
}

function player_challenge_init()
{
	self endon("disconnect");
	self thread monitor_challenge_progress( self.s_challenges.a_challenge_1 );
	self thread monitor_challenge_progress( self.s_challenges.a_challenge_2 );
	self thread monitor_challenge_progress( self.s_challenges.a_challenge_3 );
	self thread player_trial_complete_notification( self.s_challenges.a_challenge_1.n_index, "flag_player_completed_challenge_1" );
	self thread player_trial_complete_notification( self.s_challenges.a_challenge_2.n_index, "flag_player_completed_challenge_2" );
	self thread player_trial_complete_notification( self.s_challenges.a_challenge_3.n_index, "flag_player_completed_challenge_3" );
	self thread monitor_player_trial_completion();
	a_inactive_tiers = [];
	a_active_trigger_entities = [];
	n_player_id = self GetEntityNumber();
	for( i = 1; i <= 3; i++ )
	{
		foreach( t_lookat in GetEntArray( "t_lookat_challenge_" + i, "targetname" ) )
		{
			if( t_lookat.script_int == n_player_id )
			{
				t_lookat SetVisibleToPlayer( self );
				a_active_trigger_entities[i] = t_lookat;
				break;
			}
			a_inactive_tiers[i] = i;
		}
		self thread update_challenge_board_display( i, n_player_id );
	}
	foreach( s_challenge in struct::get_array( "s_challenge_trigger" ) )
	{
		if( s_challenge.script_int == n_player_id )
		{
			s_challenge initialize_challenge_unitrigger( a_active_trigger_entities, a_inactive_tiers );
			break;
		}
	}
}

function initialize_challenge_unitrigger( a_active_trigger_entities, a_inactive_tiers )
{
	self zm_unitrigger::create_unitrigger( "", 128, &challenge_trigger_think );
	self.s_unitrigger.require_look_at = 0;
	self.s_unitrigger.inactive_reassess_time = 0.1;
	zm_unitrigger::unitrigger_force_per_player_triggers( self.s_unitrigger, 1 );
	self.s_unitrigger.a_inactive_tiers = a_inactive_tiers;
	self.a_active_trigger_entities = a_active_trigger_entities;
	self thread monitor_challenge_trigger_state();
}

function monitor_challenge_trigger_state()
{
	for(;;)
	{
		self waittill( "trigger_activated", e_who );
		n_player_id = e_who GetEntityNumber();
		if( self.script_int == n_player_id )
		{
			if( e_who flag::get( "flag_player_initialized_reward" ) )
			{
				if( self.e_reward_model.n_challenge == 2 )
				{
					w_current = e_who GetCurrentWeapon();
					if( zm_utility::is_placeable_mine( w_current ) || zm_equipment::is_equipment( w_current ) || w_current == level.weaponnone || IS_TRUE( w_current.isheroweapon ) || IS_TRUE( w_current.isgadget ) )
					{
						continue;
					}
					if( e_who bgb::is_enabled( "zm_bgb_disorderly_combat" ) )
					{
						continue;
					}
				}
				else if( self.e_reward_model.n_challenge == 3 )
				{
					a_perks = e_who GetPerks();
					if( a_perks.size == level._custom_perks.size )
					{
						continue;
					}
				}
				e_who PlayRumbleOnEntity( "zm_stalingrad_interact_rumble" );
				self.s_unitrigger.playertrigger[e_who.entity_num] SetHintStringForPlayer( e_who, "" );
				e_who player_give_reward( self.e_reward_model, n_player_id );
				if( isdefined( self.e_reward_model ) )
				{
					self.e_reward_model Delete();
				}
			}
			else
			{
				for( i = 1; i <= 3; i++ )
				{
					if( e_who is_looking_at( self.a_active_trigger_entities[i].origin, 15, 0 ) && Distance( e_who.origin, self.origin ) < 500 )
					{
						if( IS_TRUE( e_who.b_is_reward_in_progress ) )
						{
							break;
						}
						if( e_who flag::get( "flag_player_completed_challenge_" + i ) && !e_who flag::get( "flag_player_collected_reward_" + i ) )
						{
							e_who PlayRumbleOnEntity( "zm_stalingrad_interact_rumble" );
							self.s_unitrigger.playertrigger[e_who.entity_num] SetHintStringForPlayer( e_who, "" );
							self trigger_reward_delivery( e_who, i );
							break;
						}
					}
				}
			}
		}
	}
}

function trigger_reward_delivery( e_player, n_challenge )
{
	e_player endon( "disconnect" );
	v_reward_angles = ( 0, 90, 0 );
	a_reward_structs = struct::get_array( "s_challenge_reward" );
	n_player_id = e_player GetEntityNumber();
	foreach( s_reward in a_reward_structs )
	{
		if( s_reward.script_int == n_player_id )
		{
			break;
		}
	}
	switch( n_challenge )
	{
		case 1:
			str_reward_model = "p7_zm_power_up_max_ammo";
			s_reward.v_offset = ( 0, 0, 6 );
			s_reward.v_rotation_offset = v_reward_angles;
			break;

		case 2:
			str_reward_model = array::random( array( "lmg_cqb_upgraded", "ar_damage_upgraded", "smg_versatile_upgraded" ) );
			v_offset_vec = ( AnglesToRight( s_reward.angles ) * 5 ) + ( AnglesToForward( s_reward.angles ) * -2 );
			s_reward.v_offset = v_offset_vec + ( 0, 0, 1 );
			s_reward.v_rotation_offset = v_reward_angles;
			break;

		case 3:
			str_reward_model = "zombie_pickup_perk_bottle";
			v_offset_vec = AnglesToForward( s_reward.angles ) * -2;
			s_reward.v_offset = v_offset_vec + ( 0, 0, 7 );
			s_reward.v_rotation_offset = v_reward_angles;
			break;

	}
	e_player.b_is_reward_in_progress = 1;
	e_board = level.a_e_challenge_boards[n_player_id];
	e_board scene::play( "p7_fxanim_zm_gen_challenge_prizestone_open_bundle", e_board );
	e_board clientfield::set( "challenge_board_reward", 1 );
	self spawn_reward_item( e_player, s_reward, str_reward_model, 30 );
	self.e_reward_model clientfield::set( "powerup_fx", 1 );
	self.e_reward_model.n_challenge = n_challenge;
	e_player flag::set( "flag_player_initialized_reward" );
	self thread reset_prizestone_after_delay( e_player, -30, n_player_id );
}

function reset_prizestone_after_delay( e_player, n_dist, n_player_id )
{
	self endon( "clear_existing_reward" );
	self.e_reward_model MoveZ( n_dist, 12, 6 );
	self.e_reward_model waittill( "movedone" );
	if( isdefined( e_player ) )
	{
		e_player flag::clear( "flag_player_initialized_reward" );
		e_player.b_is_reward_in_progress = undefined;
	}
	if( isdefined( self.e_reward_model ) )
	{
		self.e_reward_model Delete();
	}
	close_prizestone_logic( n_player_id );
}

function spawn_reward_item( e_player, s_reward, str_model_name, n_rise_distance )
{
	if( isdefined( self.e_reward_model ) )
	{
		self notify( "clear_existing_reward" );
	}
	v_spawn_origin = s_reward.origin + s_reward.v_offset;
	v_spawn_angles = s_reward.angles + s_reward.v_rotation_offset;
	switch( str_model_name )
	{
		case "ar_damage_upgraded":
		case "lmg_cqb_upgraded":
		case "smg_versatile_upgraded":
			self.e_reward_model = zm_utility::spawn_buildkit_weapon_model( e_player, GetWeapon( str_model_name ), undefined, v_spawn_origin, v_spawn_angles );
			self.e_reward_model.str_weapon_name = str_model_name;
			break;

		default:
			self.e_reward_model = util::spawn_model( str_model_name, v_spawn_origin, v_spawn_angles );
			break;

	}
	self.e_reward_model MoveZ( n_rise_distance, 1 );
	PlaySoundAtPosition( "evt_prize_rise", self.origin );
	self.e_reward_model waittill( "movedone" );
}

function close_prizestone_logic( n_player_id )
{
	e_board = level.a_e_challenge_boards[n_player_id];
	e_board scene::play( "p7_fxanim_zm_gen_challenge_prizestone_close_bundle", e_board );
	e_board clientfield::set( "challenge_board_reward", 0 );
}

function update_challenge_board_display( n_challenge, n_player_id )
{
	self endon( "disconnect" );
	self flag::wait_till( "flag_player_completed_challenge_" + n_challenge );
	str_model = "p7_zm_gen_challenge_medal_0" + n_challenge;
	e_board = level.a_e_challenge_boards[n_player_id];
	e_board Attach( str_model, get_medal_attach_tag( n_challenge ) );
}

function get_medal_attach_tag( n_challenge )
{
	switch( n_challenge )
	{
		case 1:
			return "tag_medal_easy";
		case 2:
			return "tag_medal_med";
		default:
			return "tag_medal_hard";
	}
}

function player_trial_complete_notification( n_challenge_index, str_flag_name )
{
	self endon( "disconnect" );
	self flag::wait_till( str_flag_name );
	switch( n_challenge_index )
	{
		case 1:
			str_challenge_label = self.s_challenges.a_challenge_1.str_info;
			break;

		case 2:
			str_challenge_label = self.s_challenges.a_challenge_2.str_info;
			break;

		case 3:
			str_challenge_label = self.s_challenges.a_challenge_3.str_info;
			break;
	}
	self LUINotifyEvent( &"trial_complete", 3, &"ZM_GENESIS_CHALLENGE_COMPLETE", str_challenge_label, n_challenge_index - 1 );
}

function challenge_trigger_think( e_player )
{
	if( self.stub.related_parent.script_int == e_player GetEntityNumber() )
	{
		is_interacting = 0;
		if( e_player flag::get( "flag_player_initialized_reward" ) )
		{
			self SetHintStringForPlayer( e_player, &"ZM_GENESIS_CHALLENGE_REWARD_TAKE" );
			if( self.stub.related_parent.e_reward_model.n_challenge == 3 )
			{
				a_perks = e_player GetPerks();
				if( a_perks.size == level._custom_perks.size )
				{
					self SetHintStringForPlayer( e_player, "" );
				}
			}
			is_interacting = 1;
			return true;
		}
		for( i = 1; i <= 3; i++ )
		{
			if( e_player is_looking_at( self.stub.related_parent.a_active_trigger_entities[i].origin, 15, 0 ) && Distance( e_player.origin, self.stub.origin ) < 500 )
			{
				self update_interaction_hints( e_player, i );
				e_player clientfield::set_player_uimodel( "trialWidget.icon", i - 1 );
				e_player clientfield::set_player_uimodel( "trialWidget.visible", 1 );
				e_player clientfield::set_player_uimodel( "trialWidget.progress", e_player.a_challenge_progress[i] );
				e_player thread monitor_challenge_hint_interactions( self );
				if( !e_player flag::get( "flag_player_completed_challenge_" + i ) )
				{
					self SetHintStringForPlayer( e_player, "" );
					is_interacting = 1;
					return true;
				}
				if( !e_player flag::get( "flag_player_collected_reward_" + i ) && !IS_TRUE( e_player.b_is_reward_in_progress ) )
				{
					self SetHintStringForPlayer( e_player, &"ZM_GENESIS_CHALLENGE_REWARD" );
					is_interacting = 1;
					return true;
				}
				self SetHintStringForPlayer( e_player, "" );
				is_interacting = 1;
				return true;
			}
		}
		if( !is_interacting )
		{
			self SetHintStringForPlayer( e_player, "" );
			e_player clientfield::set_player_uimodel( "trialWidget.visible", 0 );
			return false;
		}
	}
	else
	{
		self SetHintStringForPlayer( e_player, "" );
		return false;
	}
}

function is_looking_at( origin, n_fov_angle = 90, do_trace, e_ignore )
{
	n_fov_angle = AbsAngleClamp360( n_fov_angle );
	dot = Cos( n_fov_angle * 0.5 );
	return self util::is_player_looking_at( origin, dot, do_trace, e_ignore );
}

function player_give_reward( e_reward_model, n_player_id )
{
	switch( e_reward_model.n_challenge )
	{
		case 1:
			level thread zm_powerups::specific_powerup_drop( "full_ammo", self.origin );
			PlaySoundAtPosition( "evt_grab_powerup", self.origin );
			break;

		case 2:
			if( isdefined( e_reward_model.str_weapon_name ) )
			{
				weapon = GetWeapon( e_reward_model.str_weapon_name );
			}
			self thread swap_weapon( weapon );
			PlaySoundAtPosition( "evt_grab_weapon", self.origin );
			break;

		case 3:
			self zm_perks::give_random_perk();
			PlaySoundAtPosition( "evt_grab_perk", self.origin );
			break;
	}
	self flag::set( "flag_player_collected_reward_" + e_reward_model.n_challenge );
	self flag::clear( "flag_player_initialized_reward" );
	self set_challenge_state( e_reward_model.n_challenge, 2 );
	level thread close_prizestone_logic( n_player_id );
	self.b_is_reward_in_progress = undefined;
}

function swap_weapon( weapon )
{
	w_current = self GetCurrentWeapon();
	if( !zm_utility::is_player_valid( self ) )
	{
		return;
	}
	if( IS_TRUE( self.is_drinking ) )
	{
		return;
	}
	if( zm_utility::is_placeable_mine( w_current ) || zm_equipment::is_equipment( w_current ) || w_current == level.weaponnone )
	{
		return;
	}
	if( !self HasWeapon( weapon.rootweapon, 1 ) )
	{
		if( w_current.type === "melee" )
		{
			self replace_melee_weapon( weapon );
		}
		else
		{
			self take_old_weapon_and_give_new( w_current, weapon );
		}
	}
	else
	{
		self GiveMaxAmmo( weapon );
	}
}

function take_old_weapon_and_give_new( w_current, weapon )
{
	a_primaries = self GetWeaponsListPrimaries();
	if( isdefined( a_primaries ) && a_primaries.size >= zm_utility::get_player_weapon_limit( self ) )
	{
		self TakeWeapon( w_current );
	}
	w_new = self zm_weapons::give_build_kit_weapon( weapon );
	self GiveWeapon( w_new );
	self SwitchToWeapon( w_new );
}

function replace_melee_weapon( weapon )
{
	a_weapons = self GetWeaponsList(1);
	foreach( w_current in a_weapons )
	{
		if( w_current.type === "melee" )
		{
			self TakeWeapon( w_current );
			break;
		}
	}
	w_new = self zm_weapons::give_build_kit_weapon( weapon );
	self GiveWeapon( w_new );
}

function trap_kill_challenge()
{
	self endon( "flag_player_completed_challenge_1" );
	self endon( "disconnect" );
	DEFAULT( self.n_flogger_trap_kills, 0 );
	DEFAULT( self.n_electric_trap_kills, 0 );
	self thread monitor_flogger_trap_kills();
	self thread monitor_electric_trap_kills();
}

function monitor_flogger_trap_kills()
{
	self endon( "flag_player_completed_challenge_1" );
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "flogger_killed_zombie", ai_zombie, e_attacker );
		if( e_attacker === self && self.n_flogger_trap_kills < 5 )
		{
			self.n_flogger_trap_kills++;
			self notify( "update_challenge_trap_kills" );
		}
	}
}

function monitor_electric_trap_kills()
{
	self endon( "flag_player_completed_challenge_1" );
	self endon( "disconnect" );
	for(;;)
	{
		self waittill( "zombie_zapped" );
		if( self.n_electric_trap_kills < 5 )
		{
			self.n_electric_trap_kills++;
			self notify( "update_challenge_trap_kills" );
		}
	}
}

function beam_kill_challenge()
{
	self endon( "flag_player_completed_challenge_1" );
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "beam_killed_zombie", e_attacker );
		if( e_attacker === self )
		{
			self notify( "update_challenge_beam_kills" );
		}
	}
}

function fury_headshot_challenge()
{
	self endon( "flag_player_completed_challenge_1" );
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "trial_fury_headshot", e_attacker );
		if( e_attacker === self )
		{
			self notify( "update_challenge_fury_headshots" );
		}
	}
}

function shield_acquisition_challenge()
{
	self endon( "flag_player_completed_challenge_1" );
	self endon( "disconnect" );
	for(;;)
	{
		self waittill( "new_equipment", weapon );
		if( weapon === level.weaponriotshield )
		{
			self notify( "update_challenge_shield_acquisition" );
		}
	}
}

function riotshield_spider_kill_challenge()
{
	self endon( "flag_player_completed_challenge_2" );
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "hash_92ad8590", e_attacker );
		if( e_attacker === self )
		{
			self notify( "update_challenge_riotshield_spider_kills" );
		}
	}
}

function keeper_altar_construction_challenge()
{
	self endon( "flag_player_completed_challenge_1" );
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "hash_7e8efe7c" );
		self notify( "update_challenge_keeper_altar_construction" );
	}
}

function turret_ricochet_challenge()
{
	self endon( "flag_player_completed_challenge_2" );
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "hash_b1a8571a", e_attacker );
		if( e_attacker === self )
		{
			self notify( "update_challenge_turret_ricochet" );
		}
	}
}

function survive_nacht_challenge()
{
	self endon( "flag_player_completed_challenge_2" );
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "hash_e15c8839", e_attacker );
		if( e_attacker === self )
		{
			self notify( "update_challenge_survive_nacht" );
		}
	}
}

function spider_kills_challenge()
{
	self endon( "flag_player_completed_challenge_2" );
	self endon( "disconnect" );
	for(;;)
	{
		self waittill( "player_killed_spider" );
		self notify( "update_challenge_spider_kills" );
	}
}

function survive_apothicon_challenge()
{
	self endon( "flag_player_completed_challenge_3" );
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "hash_8dbe1895", e_attacker );
		if( e_attacker === self )
		{
			self notify( "update_challenge_survive_apothicon" );
		}
	}
}

function flinger_kill_challenge()
{
	self endon( "flag_player_completed_challenge_2" );
	self endon( "disconnect" );
	for(;;)
	{
		self waittill( "flinger_kill" );
		self notify( "update_challenge_flinger_kills" );
	}
}

function island_mastery_challenge()
{
	self endon( "flag_player_completed_challenge_2" );
	self endon( "disconnect" );
	for(;;)
	{
		self waittill( "trial_island_mastery_complete" );
		self notify( "update_challenge_island_mastery" );
	}
}

function other_island_kills_challenge()
{
	self endon( "flag_player_completed_challenge_3" );
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "other_island_kill", e_attacker );
		if( e_attacker === self )
		{
			self notify( "update_challenge_other_island_kills" );
		}
	}
}

function mechz_damage_challenge()
{
	spawner::add_archetype_spawn_function( "mechz", &monitor_mechz_death, self );
	self thread monitor_mechz_damage();
}

function monitor_mechz_death( e_player )
{
	e_player endon( "flag_player_completed_challenge_3" );
	e_player endon( "disconnect" );
	self endon( "damage_player" );
	self waittill( "death", e_attacker, n_damage, w_weapon, v_point, v_dir );
	if( e_attacker === e_player )
	{
		e_attacker notify( "update_challenge_mechz_damage" );
	}
}

function monitor_mechz_damage()
{
	self endon( "flag_player_completed_challenge_3" );
	self endon( "disconnect" );
	self endon( "update_challenge_mechz_damage" );
	for(;;)
	{
		self waittill( "damage", n_damage, e_attacker );
		if( e_attacker.archetype === "mechz" || e_attacker.archetype === "margwa" )
		{
			e_attacker notify( "damage_player" );
		}
	}
}

function three_shot_margwa_kill_challenge()
{
	self endon( "flag_player_completed_challenge_3" );
	self endon( "disconnect" );
	for(;;)
	{
		self waittill( "3shot_margwa_kill" );
		self notify( "update_challenge_3shot_margwa_kill" );
	}
}

function elemental_margwa_kill_challenge()
{
	self endon( "flag_player_completed_challenge_3" );
	self endon( "disconnect" );
	b_killed_fire_margwa = false;
	b_killed_shadow_margwa = false;
	for(;;)
	{
		str_result = self util::waittill_any_return( "flag_player_completed_challenge_3", "disconnect", "fire_margwa_death", "shadow_margwa_death" );
		if( str_result == "fire_margwa_death" )
		{
			b_killed_fire_margwa = true;
		}
		else if( str_result == "shadow_margwa_death" )
		{
			b_killed_shadow_margwa = true;
		}
		if( b_killed_fire_margwa && b_killed_shadow_margwa )
		{
			self notify( "update_challenge_elemental_margwa_kills" );
		}
	}
}

function no_kill_corrupteng_challenge()
{
	self endon( "flag_player_completed_challenge_1" );
	self endon( "disconnect" );
	for(;;)
	{
		level waittill( "hash_9a954bfc", e_attacker );
		if( e_attacker === self )
		{
			self notify( "update_challenge_no_kill_corrupteng" );
		}
	}
}

function apothicon_margwa_kill_challenge()
{
	self endon( "flag_player_completed_challenge_3" );
	self endon( "disconnect" );
	for(;;)
	{
		self waittill( "apothicon_margwa_kill" );
		self notify( "update_challenge_apothicon_marwa_kill" );
	}
}

function zombie_death_trial_monitor( e_attacker )
{
	if( IsPlayer( e_attacker ) )
	{
		if( self.archetype === "apothicon_fury" )
		{
			if( zm_utility::is_headshot( self.damageweapon, self.damagelocation, self.damagemod ) )
			{
				level notify( "trial_fury_headshot", e_attacker );
			}
		}
		if( isdefined( self.traversal ) )
		{
			if( isdefined( self.traversal.startnode ) )
			{
				if( self.traversal.startnode.script_noteworthy === "flinger_traversal" )
				{
					e_attacker notify( "flinger_kill" );
				}
			}
		}
		if( self.archetype === "zombie" )
		{
			self thread track_island_kill_progress( e_attacker );
		}
		if( isdefined( e_attacker.var_a3d40b8 ) && isdefined( self.var_a3d40b8 ) )
		{
			if( e_attacker.var_a3d40b8 !== self.var_a3d40b8 )
			{
				level notify( "other_island_kill", e_attacker );
			}
		}
		if( self.archetype === "margwa" )
		{
			if( self.shots_fired[e_attacker.playernum] <= 3 )
			{
				e_attacker notify( "3shot_margwa_kill" );
			}
			if( self.var_f9ebd43e === "fire" )
			{
				e_attacker notify( "fire_margwa_death" );
			}
			else if( self.var_f9ebd43e === "shadow" )
			{
				e_attacker notify( "shadow_margwa_death" );
			}
			if( self.zone_name === "apothicon_interior_zone" )
			{
				e_attacker notify( "apothicon_margwa_kill" );
			}
		}
	}
	else if( isdefined( e_attacker ) && e_attacker.archetype === "turret" )
	{
		if( isdefined( e_attacker.activated_by_player ) )
		{
			e_attacker.activated_by_player notify( "autoturret_killed_zombie" );
			level notify( "autoturret_killed_zombie" );
			self thread track_island_kill_progress( e_attacker.activated_by_player );
		}
	}
}

function track_island_kill_progress( player )
{
    if( !isdefined( self.var_a3d40b8 ) )
    {
        return;
    }

    switch( self.var_a3d40b8 )
    {
        case "asylum_island":
        case "prison_island":
        case "prototype_island":
        case "start_island":
        case "temple_island":
            
            player.a_island_progress[self.var_a3d40b8]++;
            b_mastery_achieved = true;
            a_island_keys = GetArrayKeys( player.a_island_progress );
            
            foreach( str_key in a_island_keys )
            {
                if( player.a_island_progress[str_key] < 5 )
                {
                    b_mastery_achieved = false;
                    break;
                }
            }
            
            if( b_mastery_achieved )
            {
                player notify( "trial_island_mastery_complete" );
            }
            break;
    }
}

function check_non_melee_damage_trial( str_mod, str_hit_location, v_hit_origin, e_player, n_amount, w_weapon, v_direction, str_tag, str_model, str_part, n_flags, e_inflictor, n_chargelevel )
{
	if( IsPlayer( e_inflictor ) )
	{
		if( !IS_TRUE( zm_utility::is_melee_weapon( w_weapon ) ) )
		{
			level notify( "non_melee_damage" );
		}
	}
	return false;
}

function monitor_challenge_progress( s_challenge )
{
	self endon( "disconnect" );
	if( IsFunctionPtr( s_challenge.func_think ) )
	{
		self thread [[ s_challenge.func_think ]]();
	}
	n_remaining_count = s_challenge.n_count;
	DEFAULT( self.a_challenge_progress, [] );
	self.a_challenge_progress[s_challenge.n_index] = 0;
	n_total_goal = n_remaining_count;
	while( n_remaining_count > 0 )
	{
		self waittill( s_challenge.str_notify );
		n_remaining_count--;
		self.a_challenge_progress[s_challenge.n_index] = 1 - ( n_remaining_count / n_total_goal );
	}
	self set_challenge_state( s_challenge.n_index, 1 );
	self flag::set( "flag_player_completed_challenge_" + s_challenge.n_index );
}

function monitor_player_trial_completion()
{
	self endon( "disconnect" );
	a_flags = array( "flag_player_completed_challenge_1", "flag_player_completed_challenge_2", "flag_player_completed_challenge_3" );
	self flag::wait_till_all( a_flags );
	level notify( "player_finished_all_trials" );
}

function all_challenges_completed()
{
	level.n_players_finished_all_trials = 0;
	callback::on_disconnect( &check_completion_on_disconnect );
	for(;;)
	{
		level waittill( "player_finished_all_trials" );
		level.n_players_finished_all_trials++;
		if( level.n_players_finished_all_trials >= level.players.size )
		{
			level flag::set( "all_challenges_completed" );
			break;
		}
	}
}

function check_completion_on_disconnect()
{
	if( level.n_players_finished_all_trials >= level.players.size )
	{
		level flag::set( "all_challenges_completed" );
	}
}

function function_ca31caac( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex )
{
	if( IsPlayer( attacker ) )
	{
		DEFAULT( self.shots_fired, [] );
		DEFAULT( self.shots_fired[attacker.playernum], 0 );
		self.shots_fired[attacker.playernum]++;
	}
}