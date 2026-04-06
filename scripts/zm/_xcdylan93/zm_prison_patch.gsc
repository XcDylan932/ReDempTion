#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_xcdylan93\_zm_startmenu;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

REGISTER_SYSTEM_EX( "zm_prison_patch", &__init__, &__main__, undefined )

function __init__()
{
    if( level.script != "zm_prison" )
    {
        return;
    }

    clientfield::register( "toplayer", "hidelegs", VERSION_SHIP, 1, "int" );
    clientfield::register( "scriptmover", "magmagat_trail", VERSION_SHIP, 1, "int" );
    callback::on_connect( &plane_boarding );
}

function __main__()
{
    if( level.script != "zm_prison" )
    {
        return;
    }

    thread notify_players_flag( "plane_boarded" );
    thread notify_players_flag( "plane_crashed" );

    level.default_magmagat_projectile_cb = level.var_8d06fd2a.var_46a04a1e;
    level.var_8d06fd2a.var_46a04a1e = &magmagat_projectile_cb;
    level.var_7e8abe85.var_46a04a1e = &magmagat_projectile_cb;

    level waittill( "start_zombie_round_logic" );
    level.players[0] zm_startmenu::set_eye_color( ( isdefined( world._effect ) && isdefined( world._effect["eye"] ) ? world._effect["eye"] : level.fx_color ), 0 );
}

function notify_players_flag( flag )
{
    level endon( "end_game" );

    if( !level flag::exists( flag ) )
    {
        return;
    }

    for(;;)
    {
        level flag::wait_till( flag );
        players = GetPlayers();
        foreach( player in players )
        {
            player notify( flag );
        }
        level flag::wait_till_clear( flag );
    }
}

function plane_boarding()
{
    self endon( "disconnect" );

    for(;;)
    {
        self waittill( "plane_boarded" );
        wait 0.05;
        self zm_startmenu::set_player_character( self get_player_index(), 0 );
        self clientfield::set_to_player( "hidelegs", 1 );
        self waittill( "plane_crashed" );
        wait 0.1;
        self clientfield::set_to_player( "hidelegs", 0 );
        self zm_startmenu::set_player_character( self get_player_index(), 0 );
    }
}

function get_player_index()
{
    return( isdefined( self.afterlifeIndex ) ? self.afterlifeIndex : self.characterIndex );
}

function magmagat_projectile_cb( projectile, weapon )
{
    self thread [[ level.default_magmagat_projectile_cb ]]( projectile, weapon );

    if( !isdefined( projectile ) )
    {
        return;
    }

    fxorg = util::spawn_model( "tag_origin", projectile.origin );
    fxorg clientfield::set( "magmagat_trail", 1 );
    fxorg LinkTo( projectile );

    projectile waittill( "death" );
    fxorg Unlink();
    if( isdefined( fxorg ) )
    {
        fxorg clientfield::set( "magmagat_trail", 0 );
        waittillframeend;
        fxorg Delete();
    }
}