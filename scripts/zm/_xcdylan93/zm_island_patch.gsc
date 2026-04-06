#using scripts\shared\system_shared;
#insert scripts\shared\shared.gsh;

REGISTER_SYSTEM_EX( "zm_island_patch", undefined, &__main__, undefined )

function __main__()
{
    if( level.script != "zm_island" )
    {
        return;
    }
    
    level.custom_random_perk_weights = &island_random_perk_weights;
}

function island_random_perk_weights()
{
    keys = GetArrayKeys( level._random_perk_machine_perk_list );
    ArrayInsert( keys, "specialty_electriccherry", 0 );
    return keys;
}