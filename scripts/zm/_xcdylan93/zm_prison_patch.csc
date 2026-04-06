#using scripts\shared\ai\zombie;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

REGISTER_SYSTEM_EX( "zm_prison_patch", &__init__, &__main__, undefined )

function __init__()
{
	if( ToLower( GetDvarString( "mapname" ) ) != "zm_prison" )
	{
		return;
	}

	clientfield::register( "toplayer", "hidelegs", VERSION_SHIP, 1, "int", &hide_legs, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "scriptmover", "magmagat_trail", VERSION_SHIP, 1, "int", &magmagat_trail_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
}

function __main__()
{
	if( ToLower( GetDvarString( "mapname" ) ) != "zm_prison" )
	{
		return;
	}
		
	remove_archetype_spawn_function( "zombie", &zombieclientutils::zombie_override_burn_fx );
}

function hide_legs( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    func = ( newval ? &HideViewlegs : &ShowViewlegs );
    self [[ func ]]();
}

function magmagat_trail_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	self endon( "entityshutdown" );

	if( isdefined( self.magmagat_trail_fx ) )
	{
		DeleteFX( localclientnum, self.magmagat_trail_fx, 1 );
		self.magmagat_trail_fx = undefined;
	}

	if( newval )
	{
		self.magmagat_trail_fx = PlayFXOnTag( localclientnum, level._effect["magmagat_trail"], self, "tag_origin" );
	}
}

function remove_archetype_spawn_function( archetype, spawn_func )
{
    if( !isdefined( level.spawn_funcs ) || !isdefined( level.spawn_funcs[archetype] ) )
    {
        return;
    }

    for( i = level.spawn_funcs[archetype].size - 1; i >= 0; i-- )
    {
        if( level.spawn_funcs[archetype][i]["function"] == spawn_func )
        {
            ArrayRemoveIndex( level.spawn_funcs[archetype], i );
        }
    }
}