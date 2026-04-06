#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#insert scripts\shared\shared.gsh;

REGISTER_SYSTEM_EX( "zm_factory_patch", undefined, &__main__, undefined )

function autoexec ignore_systems()
{
    if( ToLower( GetDvarString( "mapname" ) ) === "zm_factory" )
    {
        system::ignore( "zm_factory_vo" );
    }
}

function __main__()
{
    if( level.script != "zm_factory" )
    {
        return;
    }

    level.default_special_powerup_func = level.powerup_special_drop_override;
    level.powerup_special_drop_override = &powerup_special_drop_override;

    thread deadshot_power_override();
    thread staminup_power_override();
}

function powerup_special_drop_override()
{
    if( level.round_number <= 25 )
    {
        count = 0;
        perk_keys = GetArrayKeys( level._custom_perks );
        players = GetPlayers();
        foreach( player in players )
        {
            if( player.num_perks >= 4 )
            {
                foreach( perk in perk_keys )
                {
                    if( !player HasPerk( perk ) )
                    {
                        count++;
                        break;
                    }
                }
            }
        }
        if( count == players.size )
        {
            return "free_perk";
        }
    }

    if( IsFunctionPtr( level.default_special_powerup_func ) )
    {
        return [[ level.default_special_powerup_func ]]();
    }
}

function deadshot_power_override()
{
    zm_perks::perk_machine_removal( "specialty_deadshot" );
    level._custom_perks = array::remove_index( level._custom_perks, "specialty_deadshot", 1 );
}

function staminup_power_override()
{
    level waittill( "start_zombie_round_logic" );
    t_stam = GetEnt( "specialty_staminup", "script_noteworthy" );
    t_stam SetHintString( &"" );
    level flag::wait_till( "snow_ee_completed" );
    level thread enable_staminup_machine();
}

function enable_staminup_machine()
{
    s_perk = level._custom_perks["specialty_staminup"];
    machine = GetEntArray( s_perk.radiant_machine_name, "targetname" );
    machine_triggers = GetEntArray( s_perk.radiant_machine_name, "target" );
    for( i = 0; i < machine.size; i++ )
    {
        machine[i] SetModel( level.machine_assets["specialty_staminup"].on_model );
        machine[i] Vibrate( ( 0, -100, 0 ), 0.3, 0.4, 3 );
        machine[i] PlaySound( "zmb_perks_power_on" );
        machine[i] thread zm_perks::perk_fx( s_perk.machine_light_effect );
        machine[i] thread zm_perks::play_loop_on_machine();
    }
    level notify( "specialty_staminup_power_on" );
    array::thread_all( machine_triggers, &zm_perks::set_power_on, 1 );
    if( IsFunctionPtr( level.machine_assets["specialty_staminup"].power_on_callback ) )
    {
        array::thread_all( machine, level.machine_assets["specialty_staminup"].power_on_callback );
    }
}