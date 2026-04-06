#using scripts\codescripts\struct;

#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;

#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_perks.gsh;
#insert scripts\zm\_zm_utility.gsh;

#precache( "fx", "_t6/misc/fx_zombie_cola_dtap_on" );
#precache( "fx", "_t6/misc/fx_zombie_cola_jugg_on" );
#precache( "fx", "_t6/misc/fx_zombie_cola_on" );

#namespace zm_perks;

function init()
{
	level.perk_purchase_limit = 4;
	
	perks_register_clientfield();
	
	if( !level.enable_magic )
	{
		return;
	}
	
	initialize_custom_perk_arrays();
	
	perk_machine_spawn_init();	

	vending_weapon_upgrade_trigger = [];

	vending_triggers = GetEntArray( "zombie_vending", "targetname" );

	if( vending_triggers.size < 1 )
	{
		return;
	}
	
	level.machine_assets = [];
	
	if( !isdefined( level.custom_vending_precaching ) )
	{
		level.custom_vending_precaching = &default_vending_precaching;
	}

	[[ level.custom_vending_precaching ]]();

	zombie_utility::set_zombie_var( "zombie_perk_cost", 2000 );

	array::thread_all( vending_triggers, &vending_trigger_think );
	array::thread_all( vending_triggers, &electric_perks_dialog );
	
	if( level._custom_perks.size > 0 )
	{
		a_keys = GetArrayKeys( level._custom_perks );
		
		for( i = 0; i < a_keys.size; i++ )
		{
			perk = a_keys[i];

			if( IsFunctionPtr( level._custom_perks[perk].perk_machine_thread ) )
			{
				level thread [[ level._custom_perks[perk].perk_machine_thread ]]();
			}

			if( IsFunctionPtr( level._custom_perks[perk].perk_machine_power_override_thread ) )
			{
				if( perk != "specialty_quickrevive" && level.script == "zm_factory" )
				{
					continue;
				}
				level thread [[ level._custom_perks[perk].perk_machine_power_override_thread ]]();
			}

			else if( isdefined( level._custom_perks[perk].alias ) && isdefined( level._custom_perks[perk].radiant_machine_name ) && isdefined( level._custom_perks[perk].machine_light_effect ) )
			{
				level thread perk_machine_think( perk, level._custom_perks[perk] );	
			}
		}
	}
		
	if( IsFunctionPtr( level.quantum_bomb_register_result_func ) )
	{
		[[ level.quantum_bomb_register_result_func ]]( "give_nearest_perk", &quantum_bomb_give_nearest_perk_result, 100, &quantum_bomb_give_nearest_perk_validation );
	}

	level thread perk_hostmigration();
}

function perk_machine_think( str_key, s_custom_perk )
{	
	str_endon = str_key + PERK_END_POWER_THREAD;
	level endon( str_endon );

	str_on = s_custom_perk.alias + "_on";
	str_off = s_custom_perk.alias + "_off";
	str_notify = str_key + "_power_on";
	
	for(;;)
	{
		machine = GetEntArray( s_custom_perk.radiant_machine_name, "targetname" );
		machine_triggers = GetEntArray( s_custom_perk.radiant_machine_name, "target" );
		
		for( i = 0; i < machine.size; i++ )
		{
			machine[i] SetModel( level.machine_assets[str_key].off_model );
			machine[i] Solid();
		}
		
		level thread do_initial_power_off_callback( machine, str_key );
		array::thread_all( machine_triggers, &set_power_on, false );
	
		level waittill( str_on );
	
		for( i = 0; i < machine.size; i++ )
		{
			machine[i] SetModel( level.machine_assets[str_key].on_model );
			machine[i] Vibrate( ( 0, -100, 0 ), 0.3, 0.4, 3 );
			machine[i] PlaySound( "zmb_perks_power_on" );
			machine[i] thread perk_fx( s_custom_perk.machine_light_effect );
			machine[i] thread play_loop_on_machine();
		}
		level notify( str_notify );
		
		array::thread_all( machine_triggers, &set_power_on, true );
		if( IsFunctionPtr( level.machine_assets[str_key].power_on_callback ) )
		{
			array::thread_all( machine, level.machine_assets[str_key].power_on_callback );
		}
		
		level waittill( str_off );
			
		if( IsFunctionPtr( level.machine_assets[str_key].power_off_callback ) )
		{
			array::thread_all( machine, level.machine_assets[str_key].power_off_callback );
		}
		array::thread_all( machine, &turn_perk_off );
	}
}

function default_vending_precaching()
{	
	if( level._custom_perks.size > 0 )
	{
		a_keys = GetArrayKeys( level._custom_perks );

		for( i = 0; i < a_keys.size; i++ )
		{
			if( IsFunctionPtr( level._custom_perks[a_keys[i]].precache_func ) )
			{
				level [[ level._custom_perks[a_keys[i]].precache_func ]]();
			}
		}
	}
}

function do_initial_power_off_callback( machine_array, perkname )
{
	if( !isdefined( level.machine_assets[perkname] ) )
	{
		return;
	}

	if( !IsFunctionPtr( level.machine_assets[perkname].power_off_callback ) )
	{
		return;
	}
	
	wait 0.05;
	
	array::thread_all( machine_array, level.machine_assets[perkname].power_off_callback );
}

function use_solo_revive()
{
	if( IsFunctionPtr( level.override_use_solo_revive ) )
	{
		return [[ level.override_use_solo_revive ]]();
	}

	players = GetPlayers();
	level.using_solo_revive = ( players.size == 1 || IS_TRUE( level.force_solo_quick_revive ) ? 1 : 0 );

	return level.using_solo_revive;
}

function set_power_on( state )
{
	self.power_on = state;
}

function turn_perk_off( ishidden )
{	
	self notify( "stop_loopsound" );
	
	if( !IS_TRUE( self.b_keep_when_turned_off ) )
	{
		new_machine = Spawn( "script_model", self.origin );
		new_machine.angles = self.angles;
		new_machine.targetname = self.targetname;

		if( IS_TRUE( ishidden ) )
		{
			new_machine.ishidden = true;
			new_machine Ghost();
			new_machine NotSolid();
		}
		
		self Delete();
	}

	else
	{
		perk_fx( undefined, true );
	}
}

function play_loop_on_machine()
{
	if( isdefined( level.sndPerksacolaLoopOverride ) )
	{
		return;
	}
	
	sound_ent = Spawn( "script_origin", self.origin );
	sound_ent PlayLoopSound( "zmb_perks_machine_loop" );
	sound_ent LinkTo( self );

	self waittill( "stop_loopsound" );

	sound_ent Unlink();
	sound_ent Delete();
}

function perk_fx( fx, turnOffFx )
{
	if( isdefined( turnOffFx ) )
	{
		self.perk_fx = false;
		
		if( IS_TRUE( self.b_keep_when_turned_off ) && ( isdefined( self.s_fxloc ) ) )
		{
			self.s_fxloc Delete();
		}
	}

	else
	{
		wait 3;
		
		if( !isdefined( self ) )
		{
			return;
		}
			
		if( !IS_TRUE( self.b_keep_when_turned_off ) )
		{
			if( isdefined( self ) && !IS_TRUE( self.perk_fx ) )
			{
				PlayFXOnTag( level._effect[fx], self, "tag_origin" );
				self.perk_fx = true;
			}
		}

		else
		{
			if( isdefined( self ) && ( !isdefined( self.s_fxloc ) ) )
			{
				self.s_fxloc = util::spawn_model( "tag_origin", self.origin );
				PlayFXOnTag( level._effect[fx], self.s_fxloc, "tag_origin" );
				self.perk_fx = true;
			}
		}
	}
}

function electric_perks_dialog()
{
	self endon( "death" );
	
	wait 0.05;
	level flag::wait_till( "start_zombie_round_logic" );

	players = GetPlayers();
	if( players.size == 1 )
	{
		return;
	}
	
	self endon( "warning_dialog" );
	level endon( "switch_flipped" );
	
	timer = 0;
	for(;;)
	{
		wait 0.5;
		players = GetPlayers();
		for( i = 0; i < players.size; i++ )
		{	
			if( !isdefined( players[i] ) )
			{
				continue;
			}
			
			dist = DistanceSquared( players[i].origin, self.origin );

			if( dist > SQR(70) )
			{
				timer = 0;
				continue;
			}

			if( dist < SQR(70) && timer < 3 )
			{
				wait 0.5;
				timer ++;
			}

			if( dist < SQR(70) && timer == 3 )
			{
				if( !isdefined( players[i] ) )
				{
					continue;
				}
				
				players[i] thread zm_utility::do_player_vo( "vox_start", 5 );	
				wait 3;				
				self notify( "warning_dialog" );
			}
		}
	}
}

function reset_vending_hint_string()
{
	perk = self.script_noteworthy;
	solo = use_solo_revive();
	
	if( isdefined( level._custom_perks ) )
	{
		if( isdefined( level._custom_perks[perk] ) && isdefined( level._custom_perks[perk].cost ) && isdefined( level._custom_perks[perk].hint_string ) )
		{
			if( IsFunctionPtr( level._custom_perks[perk].cost ) )
			{
				n_cost = [[level._custom_perks[perk].cost]]();
			}

			else
			{
				n_cost = level._custom_perks[perk].cost;
			}		
				
			self SetHintString( level._custom_perks[perk].hint_string, n_cost );
		}		
	}
}

function vending_trigger_can_player_use( player )
{
	if( player laststand::player_is_in_laststand() || IS_TRUE( player.intermission ) )
	{
		return false;
	}

	if( player zm_utility::in_revive_trigger() )
	{
		return false;
	}
	
	if( !player zm_magicbox::can_buy_weapon() )
	{
		return false;
	}
	
	if( player IsThrowingGrenade() )
	{
		return false;
	}
	
	if( player IsSwitchingWeapons() )
	{
		return false;
	}

	if( IS_DRINKING( player.is_drinking ) )
	{
		return false;
	}
	
	return true;		
}

function vending_trigger_think()
{
	self endon( "death" );

	wait 0.05;

	perk = self.script_noteworthy;
	solo = false;
	start_on = false;
	level.revive_machine_is_solo = false;	

	if( isdefined( perk ) && perk == PERK_QUICK_REVIVE )
	{
		level flag::wait_till( "start_zombie_round_logic" );
		solo = use_solo_revive();

		self endon( "stop_quickrevive_logic" );
		level.quick_revive_trigger = self;

		if( solo )
		{
			if( !IS_TRUE( level.revive_machine_is_solo ) )
			{
				if( !IS_TRUE( level.initial_quick_revive_power_off ) )
				{
					start_on = true;
				}

				players = GetPlayers();
				foreach( player in players )
				{
					if( !isdefined( player.lives ) )
					{
						player.lives = 0;
					}
				}

				level zm::set_default_laststand_pistol( true );
			}

			level.revive_machine_is_solo = true;
		}
	}

	self SetHintString( &"ZOMBIE_NEED_POWER" );
	self SetCursorHint( "HINT_NOICON" );
	self UseTriggerRequireLookAt();

	cost = level.zombie_vars["zombie_perk_cost"];
	
	if( isdefined( level._custom_perks[perk] ) && isdefined( level._custom_perks[perk].cost ) )
	{
		if( IsInt( level._custom_perks[perk].cost ) )
		{
			cost = level._custom_perks[perk].cost;
		}

		else
		{
			cost = [[ level._custom_perks[perk].cost ]]();
		}
	}

	self.cost = cost;

	if( !start_on )
	{
		notify_name = perk + "_power_on";
		level waittill( notify_name );
	}

	start_on = false;

	if( !isdefined( level._perkmachinenetworkchoke ) )
	{
		level._perkmachinenetworkchoke = 0;
	}

	else
	{
		level._perkmachinenetworkchoke ++;
	}
	
	for( i = 0; i < level._perkmachinenetworkchoke; i ++ )
	{
		util::wait_network_frame();
	}
	
	self thread zm_audio::sndPerksJingles_Timer();
	self thread check_player_has_perk(perk);
	
	if( isdefined( level._custom_perks[perk] ) && isdefined( level._custom_perks[perk].hint_string ) )
	{
		self SetHintString( level._custom_perks[perk].hint_string, cost );
	}

	for(;;)
	{
		self waittill( "trigger", player );
		index = zm_utility::get_player_index( player );

		if( !vending_trigger_can_player_use( player ) )
		{
			wait 0.1;
			continue;
		}

		if( player HasPerk( perk ) || player has_perk_paused( perk ) )
		{
			self PlaySound( "evt_perk_deny" );
			player zm_audio::create_and_play_dialog( "general", "sigh" );
			continue;
		}

		if( IsFunctionPtr( level.custom_perk_validation ) )
		{
			valid = self [[ level.custom_perk_validation ]]( player );
			
			if( !valid )
			{
				continue;
			}
		}
		
		current_cost = self.cost;
		if( player zm_pers_upgrades_functions::is_pers_double_points_active() )
		{
			current_cost = player zm_pers_upgrades_functions::pers_upgrade_double_points_cost( current_cost );
		}

		if( !player zm_score::can_player_purchase( current_cost ) )
		{
			self PlaySound( "evt_perk_deny" );
			player zm_audio::create_and_play_dialog( "general", "outofmoney" );
			continue;
		}

		if( !player zm_utility::can_player_purchase_perk() )
		{
			self PlaySound( "evt_perk_deny" );
			player zm_audio::create_and_play_dialog( "general", "sigh" );
			continue;
		}

		PlaySoundAtPosition( "evt_bottle_dispense", self.origin );
		player zm_score::minus_to_player_score( current_cost );
		perkHash = -1;

		if( isdefined( level._custom_perks[perk] ) && isdefined( level._custom_perks[perk].hash_id ) )
		{
			perkHash = level._custom_perks[perk].hash_id;
		}
		player RecordMapEvent( ZM_MAP_EVENT_PERK_MACHINE_USED, GetTime(), self.origin, level.round_number, perkHash );
		
		player.perk_purchased = perk;
		player notify( "perk_purchased", perk );
		
		self thread zm_audio::sndPerksJingles_Player(1);
		self thread vending_trigger_post_think( player, perk );
	}
}

function vending_trigger_post_think( player, perk )
{
	player endon( "disconnect" );
	player endon( "end_game" );
	player endon( "perk_abort_drinking" );

	gun = player perk_give_bottle_begin( perk );
	evt = player util::waittill_any_return( "fake_death", "death", "player_downed", "weapon_change_complete", "perk_abort_drinking", "disconnect" );
	
	if(evt == "weapon_change_complete" )
	{
		player thread wait_give_perk( perk, true );
	}
	
	player perk_give_bottle_end( gun, perk );

	if( player laststand::player_is_in_laststand() || IS_TRUE( player.intermission ) )
	{
		return;
	}

	player notify( "burp" );
	
	if( IS_TRUE( level.pers_upgrade_cash_back ) )
	{
		player zm_pers_upgrades_functions::cash_back_player_drinks_perk();
	}

	if( IS_TRUE( level.pers_upgrade_perk_lose ) )
	{
		player thread zm_pers_upgrades_functions::pers_upgrade_perk_lose_bought();
	}
	
	if( IsFunctionPtr( level.perk_bought_func ) )
	{
		player [[ level.perk_bought_func ]]( perk );
	}

	player.perk_purchased = undefined;

	if( !IS_TRUE( self.power_on ) )
	{
		wait 1; 
		perk_pause( self.script_noteworthy );
	}
}

function wait_give_perk( perk, bought )
{
	self endon( "player_downed" );
	self endon( "disconnect" );
	self endon( "end_game" );
	self endon( "perk_abort_drinking" );

	self util::waittill_any_timeout( 0.5, "burp", "player_downed", "disconnect", "end_game", "perk_abort_drinking" );
	self give_perk( perk, bought );
}

function return_retained_perks()
{
	if( isdefined( self._retain_perks_array ) )
	{
		keys = GetArrayKeys( self._retain_perks_array );
		foreach( perk in keys )
		{
			if( IS_TRUE( self._retain_perks_array[perk] ) )
			{
				self give_perk( perk, false );
			}
		}
	}
}

function give_perk_presentation( perk )
{
	self endon( "player_downed" );
	self endon( "disconnect" );
	self endon( "end_game" );
	self endon( "perk_abort_drinking" );

	self zm_audio::playerExert( "burp" );

	if( IS_TRUE( level.remove_perk_vo_delay ) )
	{
		self zm_audio::create_and_play_dialog( "perk", perk );
	}

	else
	{
		self util::delay( 1.5, undefined, &zm_audio::create_and_play_dialog, "perk", perk );
	}

	self SetBlur( 9, 0.1 );
	wait 0.1;
	self SetBlur( 0, 0.1 );
}

function give_perk( perk, bought )
{
	self SetPerk( perk );
	self.num_perks++;

	if( IS_TRUE( bought ) )
	{
		self thread give_perk_presentation( perk );

		self notify( "perk_bought", perk );
		self zm_stats::increment_challenge_stat( "SURVIVALIST_BUY_PERK" );
	}
	
	if( isdefined( level._custom_perks[perk] ) && IsFunctionPtr( level._custom_perks[perk].player_thread_give ) )
	{
		self thread [[ level._custom_perks[perk].player_thread_give ]]();
	}

	self set_perk_clientfield( perk, PERK_STATE_OWNED );

	demo::bookmark( "zm_player_perk", GetTime(), self );

	self zm_stats::increment_client_stat( "perks_drank" );
	self zm_stats::increment_client_stat( perk + "_drank" );
	self zm_stats::increment_player_stat( perk + "_drank" );
	self zm_stats::increment_player_stat( "perks_drank" );
	
	DEFAULT( self.perk_history, [] );
	array::add( self.perk_history, perk, false );
	
	DEFAULT( self.perks_active, [] );
	ARRAY_ADD( self.perks_active, perk );
	
	self notify( "perk_acquired" );	

	self thread perk_think( perk );
}

function perk_set_max_health_if_jugg( str_perk, set_preMaxHealth, clamp_health_to_max_health )
{
	n_max_total_health = undefined;
			
	switch( str_perk )
	{
		case PERK_JUGGERNOG:
			if( set_preMaxHealth )
			{
				self.preMaxHealth = self.maxhealth;
			}
			n_max_total_health = self.maxhealth + level.zombie_vars["zombie_perk_juggernaut_health"];
			break;

		case "jugg_upgrade":
			if( set_preMaxHealth )
			{
				self.preMaxHealth = self.maxhealth;
			}

			if( self HasPerk(PERK_JUGGERNOG) )
			{
				n_max_total_health += level.zombie_vars["zombie_perk_juggernaut_health"];
			}

			else
			{
				n_max_total_health = level.zombie_vars["player_base_health"];
			}
			break;
			
		case "health_reboot":
			n_max_total_health = level.zombie_vars["player_base_health"];

			if( isdefined(self.n_player_health_boost) )
			{
				n_max_total_health += self.n_player_health_boost;
			}
			
			if( self HasPerk( PERK_JUGGERNOG ) )
			{
				n_max_total_health += level.zombie_vars["zombie_perk_juggernaut_health"];
			}
	}

	if( isdefined( n_max_total_health ) )
	{
		if( self zm_pers_upgrades_functions::pers_jugg_active() )
		{
			n_max_total_health = n_max_total_health + level.pers_jugg_upgrade_health_bonus;
		}

		self.maxhealth = n_max_total_health;
		self SetmaxHealth( n_max_total_health );

		if( IS_TRUE( clamp_health_to_max_health ) )
		{
			if( self.health > self.maxhealth )
			{
				self.health = self.maxhealth;
			}
		}
	}
}

function check_player_has_perk( perk )
{
	self endon( "death" );

	dist = SQR(128);
	for(;;)
	{
		players = GetPlayers();
		for( i = 0; i < players.size; i++ )
		{
			if( DistanceSquared( players[i].origin, self.origin ) < dist )
			{
				if( !players[i] HasPerk( perk ) && self vending_trigger_can_player_use( players[i] ) && !players[i] has_perk_paused( perk ) && !players[i] zm_utility::in_revive_trigger() && !( zm_equipment::is_equipment_that_blocks_purchase( players[i] GetCurrentWeapon() ) ) && !players[i] zm_equipment::hacker_active() )
				{
					self SetInvisibleToPlayer( players[i], false );
				}

				else
				{
					self SetInvisibleToPlayer( players[i], true );
				}
			}
		}

		wait 0.1;
	}
}

function vending_set_hintstring( perk ){}

function perk_think( perk )
{
	self endon( "disconnect" );

	perk_str = perk + "_stop";
	
	result = self util::waittill_any_return( "fake_death", "death", "player_downed", perk_str );

	while( self bgb::lost_perk_override( perk ) )
	{
		result = self util::waittill_any_return( "fake_death", "death", "player_downed", perk_str );
	}
	
	do_retain = true;
	
	if( use_solo_revive() && perk == PERK_QUICK_REVIVE )
	{
		do_retain = false;
	}

	if( do_retain )
	{
		if( IS_TRUE( self._retain_perks ) )
		{
			return;
		}

		else if( isdefined( self._retain_perks_array ) && IS_TRUE( self._retain_perks_array[perk] ) )
		{
			return;
		}
	}

	self UnSetPerk( perk );
	self.num_perks--;
	
	if( isdefined( level._custom_perks[perk] ) && IsFunctionPtr( level._custom_perks[perk].player_thread_take ) )
	{
		self thread [[ level._custom_perks[perk].player_thread_take ]]( false, perk_str, result );
	}	
	
	self set_perk_clientfield( perk, PERK_STATE_NOT_OWNED );
	self.perk_purchased = undefined;

	if( IsFunctionPtr( level.perk_lost_func ) )
	{
		self [[ level.perk_lost_func ]]( perk );
	}

	if( isdefined( self.perks_active ) && IsInArray( self.perks_active, perk ) )
	{
		ArrayRemoveValue( self.perks_active, perk, false );
	}
	
	self notify( "perk_lost" );
}

function set_perk_clientfield( perk, state )
{
	if( isdefined( level._custom_perks[perk] ) && IsFunctionPtr( level._custom_perks[perk].clientfield_set ) )
	{
		self [[ level._custom_perks[perk].clientfield_set ]]( state );
	}	
}

function perk_hud_destroy( perk )
{
	self.perk_hud[perk] zm_utility::destroy_hud();
	self.perk_hud[perk] = undefined;
}

function perk_hud_grey( perk, grey_on_off )
{
	self.perk_hud[perk].alpha = ( grey_on_off ? 0.3 : 1 );
}

function perk_give_bottle_begin( perk )
{
	self zm_utility::increment_is_drinking();
	self zm_utility::disable_player_move_states( true );

	original_weapon = self GetCurrentWeapon();
	weapon = "";
	
	if( isdefined( level._custom_perks[perk] ) && isdefined( level._custom_perks[perk].perk_bottle_weapon ) )
	{
		weapon = level._custom_perks[perk].perk_bottle_weapon;
	}	

	self GiveWeapon( weapon );
	self SwitchToWeapon( weapon );

	return original_weapon;
}

function perk_give_bottle_end( original_weapon, perk )
{
	self endon( "perk_abort_drinking" );

	self zm_utility::enable_player_move_states();
	
	weapon = "";
	
	if( isdefined( level._custom_perks[perk] ) && isdefined( level._custom_perks[perk].perk_bottle_weapon ) )
	{
		weapon = level._custom_perks[perk].perk_bottle_weapon;
	}	
	
	if( self laststand::player_is_in_laststand() || IS_TRUE( self.intermission ) )
	{
		self TakeWeapon( weapon );
		return;
	}

	self TakeWeapon( weapon );

	if( self zm_utility::is_multiple_drinking() )
	{
		self zm_utility::decrement_is_drinking();
		return;
	}

	else if( original_weapon != level.weaponNone && !zm_utility::is_placeable_mine( original_weapon ) && !zm_equipment::is_equipment_that_blocks_purchase( original_weapon ) )
	{
		self zm_weapons::switch_back_primary_weapon( original_weapon );
		
		if( zm_utility::is_melee_weapon( original_weapon ) )
		{
			self zm_utility::decrement_is_drinking();
			return;
		}
	}

	else 
	{
		self zm_weapons::switch_back_primary_weapon();
	}

	self waittill( "weapon_change_complete" );

	if( !self laststand::player_is_in_laststand() && !IS_TRUE( self.intermission ) )
	{
		self zm_utility::decrement_is_drinking();
	}
}

function perk_abort_drinking( post_delay )
{
	if( IS_TRUE( self.is_drinking ) )
	{
		self notify( "perk_abort_drinking" );
		self zm_utility::decrement_is_drinking();
		self zm_utility::enable_player_move_states();

		if( isdefined( post_delay ) )
		{
			wait post_delay;
		}
	}
}

function give_random_perk()
{
	random_perk = undefined;
	a_str_perks = GetArrayKeys( level._custom_perks );

	if( level.round_number < 100 && IS_TRUE( level.patched_perkorder ) && isdefined( level.patched_perks_array ) )
	{
		for( i = 0; i < level.patched_perks_array.size; i++ )
		{
			if( IsInArray( a_str_perks, level.patched_perks_array[i] ) && !self HasPerk( level.patched_perks_array[i] ) )
			{
				random_perk = level.patched_perks_array[i];
				self give_perk( random_perk );
				return random_perk;
			}
		}
	}

	perks = [];
	for( i = 0; i < a_str_perks.size; i++ )
	{
		perk = a_str_perks[i];

		if( isdefined( self.perk_purchased ) && self.perk_purchased == perk )
		{
			continue;
		}

		if( !self HasPerk( perk ) && !self has_perk_paused( perk ) )
		{
			perks[perks.size] = perk;
		}
	}

	if( perks.size > 0 )
	{
		perks = array::randomize( perks );
		random_perk = perks[0];
		self give_perk( random_perk );
	}

	else
	{
		self PlaySoundToPlayer( level.zmb_laugh_alias, self );
	}

	return random_perk;
}

function lose_random_perk()
{
	a_str_perks = GetArrayKeys( level._custom_perks );

	perks = [];
	for( i = 0; i < a_str_perks.size; i++ )
	{
		perk = a_str_perks[i];

		if( isdefined( self.perk_purchased ) && self.perk_purchased == perk )
		{
			continue;
		}

		if( self HasPerk( perk ) || self has_perk_paused( perk ) )
		{
			perks[perks.size] = perk;
		}
	}

	if( perks.size > 0 )
	{
		perks = array::randomize( perks );
		perk = perks[0];

		perk_str = perk + "_stop";
		self notify( perk_str );

		if( use_solo_revive() && perk == PERK_QUICK_REVIVE )
		{
			self.lives--;
		}
	}
}

function update_perk_hud()
{
	if( isdefined( self.perk_hud ) )
	{
		keys = GetArrayKeys( self.perk_hud );
		for( i = 0; i < self.perk_hud.size; i++ )
		{
			self.perk_hud[keys[i]].x = i * 30;
		}
	}
}

function quantum_bomb_give_nearest_perk_validation( position )
{
	vending_triggers = GetEntArray( "zombie_vending", "targetname" );

	range_squared = SQR(180);
	for( i = 0; i < vending_triggers.size; i++ )
	{
		if( DistanceSquared( vending_triggers[i].origin, position ) < range_squared )
		{
			return true;
		}
	}

	return false;
}

function quantum_bomb_give_nearest_perk_result( position )
{
	[[ level.quantum_bomb_play_mystery_effect_func ]]( position );

	vending_triggers = GetEntArray( "zombie_vending", "targetname" );

	nearest = 0;
	for( i = 1; i < vending_triggers.size; i++ )
	{
		if( DistanceSquared( vending_triggers[i].origin, position ) < DistanceSquared( vending_triggers[nearest].origin, position ) )
		{
			nearest = i;
		}
	}

	players = GetPlayers();
	perk = vending_triggers[nearest].script_noteworthy;
	for( i = 0; i < players.size; i++ )
	{
		player = players[i];

		if( player.sessionstate == "spectator" || player laststand::player_is_in_laststand() )
		{
			continue;
		}

		if( !player HasPerk( perk ) && ( !isdefined( player.perk_purchased ) || player.perk_purchased != perk ) )
		{
			if( player == self )
			{
				self thread zm_audio::create_and_play_dialog( "kill", "quant_good" );
			}
			
			player give_perk( perk );
			player [[ level.quantum_bomb_play_player_effect_func ]]();
		}
	}
}

function perk_pause( perk )
{
	if( IS_TRUE( level.dont_unset_perk_when_machine_paused ) )
	{
		return;
	}
	
	players = GetPlayers();
	for( j = 0; j < players.size; j++ )
	{
		player = players[j];
		if( !isdefined( player.disabled_perks ) )
		{
			player.disabled_perks=[];
		}

		player.disabled_perks[perk] = IS_TRUE( player.disabled_perks[perk] ) || player HasPerk( perk ); 
		if( player.disabled_perks[perk] )
		{
			player UnSetPerk( perk );
			player set_perk_clientfield( perk, PERK_STATE_PAUSED );

			if( isdefined( level._custom_perks[perk] ) && IsFunctionPtr( level._custom_perks[perk].player_thread_take ) )
			{
				player thread [[ level._custom_perks[perk].player_thread_take ]]( true );
			}		
		}
	}
}

function perk_unpause( perk )
{
	if( IS_TRUE( level.dont_unset_perk_when_machine_paused ) )
	{
		return;
	}

	if( !isdefined( perk ) )
	{
		return;
	}

	players = GetPlayers();
	for( j = 0; j < players.size; j++ )
	{
		player = players[j];
		if( isdefined( player.disabled_perks ) && IS_TRUE( player.disabled_perks[perk] ) )
		{
			player.disabled_perks[perk] = false;
			player set_perk_clientfield( perk, PERK_STATE_OWNED );
			player SetPerk( perk );

			player perk_set_max_health_if_jugg( perk, false, false );
			
			if( isdefined( level._custom_perks[perk] ) && IsFunctionPtr( level._custom_perks[perk].player_thread_give ) )
			{
				player thread [[ level._custom_perks[perk].player_thread_give ]]();
			}			
		}
	}
}

function perk_pause_all_perks( power_zone )
{
	vending_triggers = GetEntArray( "zombie_vending", "targetname" );
	foreach( trigger in vending_triggers )
	{
		if( !isdefined( power_zone ) )
		{
			perk_pause( trigger.script_noteworthy );
		}

		else if( trigger.script_int === power_zone )
		{
			perk_pause( trigger.script_noteworthy );
		}		
	}
}

function perk_unpause_all_perks( power_zone )
{
	vending_triggers = GetEntArray( "zombie_vending", "targetname" );
	foreach( trigger in vending_triggers )
	{
		if( !isdefined( power_zone ) )
		{
			perk_unpause( trigger.script_noteworthy );
		}

		else if( trigger.script_int === power_zone )
		{
			perk_unpause( trigger.script_noteworthy );
		}
	}
}

function has_perk_paused( perk )
{
	return isdefined( self.disabled_perks ) && IS_TRUE( self.disabled_perks[perk] );
}

function getVendingMachineNotify()
{
	if( !isdefined( self ) )
	{
		return "";
	}
	
	str_perk = undefined;
	
	if( isdefined( level._custom_perks[self.script_noteworthy] ) && isdefined( isdefined( level._custom_perks[self.script_noteworthy].alias ) ) )
	{
		str_perk = level._custom_perks[self.script_noteworthy].alias;
	}	
	
	return str_perk;
}

function perk_machine_removal( machine, replacement_model )
{
	if( !isdefined( machine ) )
	{
		return;
	}	

	trig = GetEnt( machine, "script_noteworthy" );
	machine_model = undefined;

	if( isdefined( trig ) )
	{
		trig notify( "warning_dialog" );

		if( isdefined( trig.target ) )
		{
			parts = GetEntArray( trig.target, "targetname" );
			for( i = 0; i < parts.size; i++ )
			{
				if( parts[i].classname === "script_model" )
				{
					machine_model = parts[i];
				}

				else if( parts[i].script_noteworthy === "clip" )
				{
					model_clip = parts[i];
				}

				else
				{
					parts[i] Delete();
				}		
			}
		}
		
		if( isdefined( replacement_model ) && isdefined( machine_model ) )
		{
			machine_model SetModel( replacement_model );
		}

		else if( !isdefined( replacement_model ) && isdefined( machine_model ) )
		{
			machine_model Delete();

			if( isdefined( model_clip ) )
			{
				model_clip Delete();
			}

			if( isdefined( trig.clip ) )
			{
				trig.clip Delete();
			}
		}
		
		if( isdefined( trig.bump ) )
		{
			trig.bump Delete();
		}
	
		trig Delete();		
	}
}

function perk_machine_spawn_init()
{
	match_string = "";

	location = level.scr_zm_map_start_location;
	if(( location == "default" || location == "" ) && isdefined( level.default_start_location ) )
	{
		location = level.default_start_location;
	}		

	match_string = level.scr_zm_ui_gametype + "_perks_" + location;

	a_s_spawn_pos = [];
	if( isdefined( level.override_perk_targetname ) )
	{
		structs = struct::get_array( level.override_perk_targetname );
	}

	else
	{
		structs = struct::get_array( "zm_perk_machine" );
	}
	
	foreach( struct in structs )
	{
		if( isdefined( struct.script_string ) )
		{
			tokens = StrTok( struct.script_string," " );
			foreach( token in tokens )
			{
				if( token == match_string )
				{
					a_s_spawn_pos[a_s_spawn_pos.size] =	struct;
				}
			}
		}

		else
		{
			a_s_spawn_pos[a_s_spawn_pos.size] =	struct;
		}	
	}			
		
	if( a_s_spawn_pos.size == 0 )
	{
		return;
	}
	
	if( IS_TRUE( level.randomize_perk_machine_location ) )
	{
		a_s_random_perk_locs = struct::get_array( "perk_random_machine_location" );
	
		if( a_s_random_perk_locs.size > 0 )
		{
			a_s_random_perk_locs = array::randomize( a_s_random_perk_locs );
		}
	
		n_random_perks_assigned = 0;
	}

	foreach( s_spawn_pos in a_s_spawn_pos )
	{
		perk = s_spawn_pos.script_noteworthy;
		if( isdefined( perk ) && isdefined( s_spawn_pos.model ) )
		{
			if( IS_TRUE( level.randomize_perk_machine_location ) && a_s_random_perk_locs.size > 0 && isdefined( s_spawn_pos.script_notify ) )
			{
				s_new_loc = a_s_random_perk_locs[n_random_perks_assigned];
				
				s_spawn_pos.origin = s_new_loc.origin;
				s_spawn_pos.angles = s_new_loc.angles;
				
				if( isdefined( s_new_loc.script_int ) )
				{
					s_spawn_pos.script_int = s_new_loc.script_int;
				}
					
				if( isdefined( s_new_loc.target ) )
				{
					s_tell_location = struct::get( s_new_loc.target );
					
					if( isdefined( s_tell_location ) )
					{
						util::spawn_model( "p7_zm_perk_bottle_broken_" + perk , s_tell_location.origin, s_tell_location.angles );
					}
				}
				
				n_random_perks_assigned++;
			}
			
			t_use = Spawn( "trigger_radius_use", s_spawn_pos.origin + ( 0, 0, 60 ), 0, 40, 80 );
			t_use.targetname = "zombie_vending";			
			t_use.script_noteworthy = perk;
			
			if( isdefined( s_spawn_pos.script_int ) )
			{
				t_use.script_int = s_spawn_pos.script_int;
			}	
			
			t_use TriggerIgnoreTeam();
	
			perk_machine = Spawn( "script_model", s_spawn_pos.origin );
			if( !isdefined( s_spawn_pos.angles ) )
			{
				s_spawn_pos.angles = ( 0, 0, 0 );
			}
			perk_machine.angles = s_spawn_pos.angles;
			perk_machine SetModel( s_spawn_pos.model );
			
			if( IS_TRUE( level._no_vending_machine_bump_trigs ) )
			{
				bump_trigger = undefined;
			}

			else
			{
				bump_trigger = Spawn( "trigger_radius", s_spawn_pos.origin + ( 0, 0, 20 ), 0, 40, 80 );
				bump_trigger.script_activated = 1;
				bump_trigger.script_sound = "zmb_perks_bump_bottle";
				bump_trigger.targetname = "audio_bump_trigger";
			}

			if(IS_TRUE( level._no_vending_machine_auto_collision ) )
			{
				collision = undefined;	
			}

			else
			{
				collision = Spawn( "script_model", s_spawn_pos.origin, 1 );
				collision.angles = s_spawn_pos.angles;
				collision SetModel( "zm_collision_perks1" );
				collision.script_noteworthy = "clip";
				collision DisconnectPaths();
			}
			
			t_use.clip = collision;
			t_use.machine = perk_machine;
			t_use.bump = bump_trigger;
			
			if( isdefined( s_spawn_pos.script_notify ) )
			{
				perk_machine.script_notify = s_spawn_pos.script_notify;
			}
			
			if( isdefined( s_spawn_pos.target ) )
			{
				perk_machine.target = s_spawn_pos.target;
			}
			
			if( isdefined( s_spawn_pos.blocker_model ) )
			{
				t_use.blocker_model = s_spawn_pos.blocker_model;
			}
			
			if( isdefined( s_spawn_pos.script_int ) )
			{
				perk_machine.script_int = s_spawn_pos.script_int;
			}
				
			if( isdefined( s_spawn_pos.turn_on_notify ) )
			{
				perk_machine.turn_on_notify = s_spawn_pos.turn_on_notify;
			}
				
			t_use.script_sound = "mus_perks_speed_jingle";
			t_use.script_string = "speedcola_perk";
			t_use.script_label = "mus_perks_speed_sting";
			t_use.target = "vending_sleight";
			perk_machine.script_string = "speedcola_perk";
			perk_machine.targetname = "vending_sleight";
			if( isdefined( bump_trigger ) )
			{
				bump_trigger.script_string = "speedcola_perk";
			}
			
			if( isdefined( level._custom_perks[perk] ) && IsFunctionPtr( level._custom_perks[perk].perk_machine_set_kvps ) )
			{
				[[ level._custom_perks[perk].perk_machine_set_kvps ]]( t_use, perk_machine, bump_trigger, collision );
			}			
		}
	}	
}	

function get_perk_machine_start_state( perk )
{
	if( IS_TRUE( level.vending_machines_powered_on_at_start ) )
	{
		return true;
	}

	if( perk == PERK_QUICK_REVIVE )
	{
		return level.revive_machine_is_solo;
	}

	return false;
}

function perks_register_clientfield()
{
	if( IS_TRUE( level.zombiemode_using_perk_intro_fx ) )
	{
		clientfield::register( "scriptmover", "clientfield_perk_intro_fx" , VERSION_SHIP , 1 ,"int" );
	}
	
	if( isdefined( level._custom_perks ) )
	{
		a_keys = GetArrayKeys( level._custom_perks );
		
		for( i = 0; i < a_keys.size; i++ )
		{
			if( IsFunctionPtr( level._custom_perks[a_keys[i]].clientfield_register ) )
			{
				level [[ level._custom_perks[a_keys[i]].clientfield_register ]]();
			}
		}
	}
}

function thread_bump_trigger()
{
	for(;;)
	{
		self waittill( "trigger", player );
		player PlaySound( self.script_sound );
		
		while( zm_utility::is_player_valid( player ) && player IsTouching( self ) )
		{
			wait 0.5;
		}
	}	
}

function players_are_in_perk_area( perk_machine )
{
	perk_area_origin = level.quick_revive_default_origin;
	
	if( isdefined( perk_machine._linked_ent ) )
	{
		perk_area_origin = perk_machine._linked_ent.origin;
		
		if( isdefined( perk_machine._linked_ent_offset ) )
		{
			perk_area_origin += perk_machine._linked_ent_offset;
		}
	}

	in_area = false;
	players = GetPlayers();
	dist_check = SQR(96);
	
	foreach( player in players )
	{
		if( DistanceSquared( player.origin, perk_area_origin ) < dist_check )
		{
			return true;
		}
	}
	
	return false;
}

function perk_hostmigration()
{
	level endon( "end_game" );
	
	level notify( "perk_hostmigration" );
	level endon( "perk_hostmigration" );
		
	for(;;)
	{
		level waittill( "host_migration_end" );
		
		if( isdefined( level._custom_perks ) && level._custom_perks.size > 0 )
		{
			a_keys = GetArrayKeys( level._custom_perks );

			foreach( key in a_keys )
			{
				if( isdefined( level._custom_perks[key].radiant_machine_name ) && isdefined( level._custom_perks[key].machine_light_effect ) )
				{
					level thread host_migration_func( level._custom_perks[key], key );
				}
			}
		}
	}
}

function host_migration_func( s_custom_perk, keyName )
{
	a_machines = GetEntArray( s_custom_perk.radiant_machine_name, "targetname" );	
	
	foreach( perk in a_machines )
	{
		if( perk.model === level.machine_assets[keyName].on_model )
		{
			perk perk_fx( undefined, true );
			perk thread perk_fx( s_custom_perk.machine_light_effect );
		}
	}
}

function spare_change( str_trigger = "audio_bump_trigger", str_sound = "zmb_perks_bump_bottle" )
{
	a_t_audio = GetEntArray( str_trigger, "targetname" );
	foreach( t_audio_bump in a_t_audio )
	{
		if( t_audio_bump.script_sound === str_sound )
		{
			t_audio_bump thread check_for_change();
		}
	}
}

function check_for_change()
{
	self endon( "death" );
	
	for(;;)
	{
		self waittill( "trigger", player );

		if( player GetStance() == "prone" )
		{
			player zm_score::add_to_player_score( 100 );
			zm_utility::play_sound_at_pos( "purchase", player.origin );
			break;
		}

		wait 0.1;
	}
}

function get_perk_array()
{
	perk_array = [];
	
	if( level._custom_perks.size > 0 )
	{
		a_keys = GetArrayKeys( level._custom_perks );
		
		for( i = 0; i < a_keys.size; i++ )
		{
			if( self HasPerk( a_keys[i] ) )
			{
				perk_array[perk_array.size] = a_keys[i];
			}
		}
	}

	return perk_array;
}

function initialize_custom_perk_arrays()
{
	DEFAULT( level._custom_perks, [] );
}

function register_revive_success_perk_func( revive_func )
{
	DEFAULT( level.a_revive_success_perk_func, [] );
	level.a_revive_success_perk_func[level.a_revive_success_perk_func.size] = revive_func;
}

function register_perk_basic_info( str_perk, str_alias, n_perk_cost, str_hint_string, w_perk_bottle_weapon )
{	
	_register_undefined_perk( str_perk );
	
	level._custom_perks[str_perk].alias = str_alias;
	level._custom_perks[str_perk].hash_id = HashString(str_alias);
	level._custom_perks[str_perk].cost = n_perk_cost;
	level._custom_perks[str_perk].hint_string = str_hint_string;
	level._custom_perks[str_perk].perk_bottle_weapon = w_perk_bottle_weapon;
	
}

function register_perk_machine( str_perk, func_perk_machine_setup, func_perk_machine_thread )
{	
	_register_undefined_perk( str_perk );
	
	if( !IsFunctionPtr( level._custom_perks[str_perk].perk_machine_set_kvps ) )
	{
		level._custom_perks[str_perk].perk_machine_set_kvps = func_perk_machine_setup;
	}
	
	if( !IsFunctionPtr( level._custom_perks[str_perk].perk_machine_thread ) && isdefined( func_perk_machine_thread ) )
	{
		level._custom_perks[str_perk].perk_machine_thread = func_perk_machine_thread;
	}	
}

function register_perk_machine_power_override( str_perk, func_perk_machine_power_override )
{	
	_register_undefined_perk( str_perk );
	
	if( !IsFunctionPtr( level._custom_perks[str_perk].perk_machine_power_override_thread ) && isdefined( func_perk_machine_power_override ) )
	{
		level._custom_perks[str_perk].perk_machine_power_override_thread = func_perk_machine_power_override;
	}	
}

function register_perk_precache_func( str_perk, func_precache )
{
	_register_undefined_perk( str_perk );
	
	if( !IsFunctionPtr( level._custom_perks[str_perk].precache_func ) )
	{
		level._custom_perks[str_perk].precache_func = func_precache;
	}
}

function register_perk_threads( str_perk, func_give_player_perk, func_take_player_perk )
{
	_register_undefined_perk( str_perk );
	
	if( !IsFunctionPtr( level._custom_perks[str_perk].player_thread_give ) )
	{
		level._custom_perks[str_perk].player_thread_give = func_give_player_perk;
	}
	
	if( !IsFunctionPtr( level._custom_perks[str_perk].player_thread_take ) && isdefined( func_take_player_perk ) )
	{
		level._custom_perks[str_perk].player_thread_take = func_take_player_perk;
	}
}

function register_perk_clientfields( str_perk, func_clientfield_register, func_clientfield_set )
{
	_register_undefined_perk( str_perk );
	
	if( !IsFunctionPtr( level._custom_perks[str_perk].clientfield_register ) )
	{
		level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
	}
	
	if( !IsFunctionPtr( level._custom_perks[str_perk].clientfield_set ) )
	{
		level._custom_perks[str_perk].clientfield_set = func_clientfield_set;
	}		
}

function register_perk_host_migration_params( str_perk, str_radiant_name, str_effect_name )
{
	_register_undefined_perk( str_perk );
	
	if( !isdefined( level._custom_perks[str_perk].radiant_name ) )
	{
		level._custom_perks[str_perk].radiant_machine_name = str_radiant_name;
	}
	
	if( !isdefined( level._custom_perks[str_perk].light_effect ) )
	{
		level._custom_perks[str_perk].machine_light_effect = str_effect_name;
	}	
}

function _register_undefined_perk( str_perk )
{
	DEFAULT( level._custom_perks, [] );
	
	if( !isdefined( level._custom_perks[str_perk] ) )
	{
		level._custom_perks[str_perk] = SpawnStruct();
	}	
}

function register_perk_damage_override_func( func_damage_override )
{
	DEFAULT( level.perk_damage_override, [] );
	array::add( level.perk_damage_override, func_damage_override, false );
}