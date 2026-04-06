#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_score;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#precache( "menu", "StartMenu_Main" );
#precache( "string", "T10_UI_SCORE_EVENT_ELIMINATION" );
#precache( "string", "T10_UI_SCORE_EVENT_CRITICAL_KILL" );
#precache( "string", "T10_UI_SCORE_EVENT_MELEE_KILL" );
#precache( "string", "T10_UI_SCORE_EVENT_BURNED_KILL" );
#precache( "string", "T10_UI_POWERUP_EVENT_CARPENTER" );
#precache( "string", "T10_UI_POWERUP_EVENT_FREE_PERK" );
#precache( "string", "T10_UI_POWERUP_EVENT_NUKE" );
#precache( "string", "T10_UI_POWERUP_EVENT_BONUS_POINTS" );

#namespace zm_mod_huds;

REGISTER_SYSTEM_EX( "zm_mod_huds", &__init__, &__main__, undefined )

function autoexec ignore_systems()
{
	if( GetDvarString( "mapname" ) == "zm_die" )
	{
		system::ignore( "zm_t6_hud" );
		system::ignore( "zm_pregame_menu" );
	}
}

function __init__()
{
	zm::register_zombie_damage_override_callback( &zombie_death_points_callback );
	level.powerup_notify = init_powerup_notify_strings();
}

function __main__()
{
	level._powerup_grab_check = &powerup_grab_check;
}

function init_powerup_notify_strings()
{
	notifications = [];
	notifications["carpenter"] = &"T10_UI_POWERUP_EVENT_CARPENTER";
	notifications["free_perk"] = &"T10_UI_POWERUP_EVENT_FREE_PERK";
	notifications["nuke"] = &"T10_UI_POWERUP_EVENT_NUKE";
	notifications["bonus_points_player"] = &"T10_UI_POWERUP_EVENT_BONUS_POINTS";
	notifications["bonus_points_team"] = &"T10_UI_POWERUP_EVENT_BONUS_POINTS";
	return notifications;
}

function powerup_grab_check( player )
{
	if( IS_TRUE( self.only_affects_grabber ) )
	{
		player send_powerup_notification( self );
	}

	else
	{
		array::run_all( GetPlayers(), &send_powerup_notification, self );
	}

	return true;
}

function send_powerup_notification( powerup )
{
	if( isdefined( level.powerup_notify[powerup.powerup_name] ) )
	{
		self LUINotifyEvent( &"zombie_notification", 1, level.powerup_notify[powerup.powerup_name] );
	}
}

function zombie_death_points_callback( death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffesettime, boneindex, surfacetype )
{
	if( isdefined( self ) && self.archetype === "zombie" && self.team === level.zombie_team )
	{
		if( death && isdefined( attacker ) && IsPlayer( attacker ) )
		{
			player_points = zm_score::get_zombie_death_player_points();
			kill_bonus = get_points_kill_bonus( mod, shitloc );
			points = kill_bonus[0];
			text = kill_bonus[1];

			if( level.zombie_vars[attacker.team]["zombie_powerup_insta_kill_on"] == 1 && mod == "MOD_UNKNOWN" )
			{
				points *= 2;
			}

			player_points += points;
			player_points *= level.zombie_vars[attacker.team]["zombie_point_scalar"];

			attacker LUINotifyEvent( &"score_event", 2, text, player_points );
		}
	}
	
	return false;
}

function get_points_kill_bonus( mod, shitloc )
{
	if( mod == "MOD_MELEE" )
	{
		return array( level.zombie_vars["zombie_score_bonus_melee"], &"T10_UI_SCORE_EVENT_MELEE_KILL" );
	}

	if( mod == "MOD_BURNED" )
	{
		return array( level.zombie_vars["zombie_score_bonus_burn"], &"T10_UI_SCORE_EVENT_BURNED_KILL" );
	}

	if( isdefined( shitloc ) )
    {
		switch( shitloc )
		{
			case "head":
			case "helmet":
				return array( level.zombie_vars["zombie_score_bonus_head"], &"T10_UI_SCORE_EVENT_CRITICAL_KILL" );
		
			case "neck":
				return array( level.zombie_vars["zombie_score_bonus_neck"], &"T10_UI_SCORE_EVENT_ELIMINATION" );
		
			case "torso_upper":
			case "torso_lower":
				return array( level.zombie_vars["zombie_score_bonus_torso"], &"T10_UI_SCORE_EVENT_ELIMINATION" );
		}
    }

	return array( 0, &"T10_UI_SCORE_EVENT_ELIMINATION" );
}