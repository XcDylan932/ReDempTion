#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#insert scripts\shared\shared.gsh;

#namespace lua;

REGISTER_SYSTEM( "lua", &__init__, undefined )

function __init__()
{
	util::register_system( "luaprint", &LuaPrint );
}

function print( localclientnum, message )
{
	LuaPrint( localclientnum, message );
}

function LuaPrint( localclientnum, message )
{
	SetUIModelValue( CreateUIModel( GetUIModelForController( localclientnum ), "luaprint" ), message );
}