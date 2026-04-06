#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_xcdylan93\_zm_startmenu;
#using scripts\zm\_zm_utility;

#insert scripts\shared\shared.gsh;

#precache( "fx", "_xcdylan93/dlc1/castle/fx_rune_magma_orb_exp" );

REGISTER_SYSTEM_EX( "zm_moon_patch", undefined, &__main__, undefined )

function __main__()
{
    if( level.script != "zm_moon" )
    {
        return;
    }

    gasmask_ptr_override();
    level thread destroy_earth();
}

function gasmask_ptr_override()
{
    level.zombiemode_gasmask_reset_player_model = &gasmask_reset_player_model;
    level.zombiemode_gasmask_reset_player_viewmodel = undefined;
    level.zombiemode_gasmask_change_player_headmodel = undefined;
    level.zombiemode_gasmask_set_player_model = &gasmask_set_player_model;
    level.zombiemode_gasmask_set_player_viewmodel = undefined;
    level._do_player_or_npc_playvox_override = undefined;
}

function destroy_earth()
{
    level endon( "game_ended" );

    level waittill( "start_zombie_round_logic" );
    zm_utility::play_sound_2d( "evt_earth_explode" );
    wait 4.3;
    level clientfield::increment( "rocket_explode" );
    util::wait_network_frame(2);
    exploder::exploder( "fxexp_2012" );
    wait 2;
    PlayFX( "_xcdylan93/dlc1/castle/fx_rune_magma_orb_exp", level.pack_a_punch.triggers[0].origin );
    exploder::exploder("fxexp_600");
    exploder::exploder("fxexp_601");
    zm_utility::play_sound_2d( "vox_xcomp_quest_laugh" );
    level util::set_lighting_state(1);
    wait 1.15;
    exploder::kill_exploder( "fxexp_601" );
    level flag::wait_till_clear( "enter_nml" );
    wait 0.2;
    level clientfield::increment( "show_destroyed_earth" );

    for(;;)
    {
        level flag::wait_till( "enter_nml" );
        wait 0.2;
        level clientfield::increment( "hide_earth" );
        level flag::wait_till_clear( "enter_nml" );
        wait 0.2;
        level clientfield::increment( "show_earth" );
    }
}

function gasmask_reset_player_model( entity_num )
{
    if( isdefined( self.afterlifeIndex ) )
    {
        self zm_startmenu::set_player_character( self.afterlifeIndex, 0 );
    }
    else
    {
        self SetCharacterBodyType( self.characterIndex );
    }
}

function gasmask_set_player_model( entity_num )
{
    self SetCharacterBodyType(5);
}