#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\lua_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#namespace zm_startmenu;

REGISTER_SYSTEM( "zm_startmenu", &__init__, undefined )

function __init__()
{
	gamesettings = array(
		array( "ChangeAll", &change_all ),
		array( "Laser", &set_laser ),
		array( "Tritium", &set_tritium ),
		array( "Powerup", &set_powerup ),
		array( "Muzzle", &set_muzzle ),
		array( "Eye", &set_eye ),
		array( "Waffe", &set_waffe ),
		array( "Tgun", &set_tgun ),
		array( "Squid", &set_squid ),
		array( "Wavegun", &set_wavegun ),
		array( "Magmagat", &set_magmagat )
	);
	for( i = 0; i < GetDvarInt( "com_maxclients" ); i++ )
	{
		foreach( setting in gamesettings )
		{
			clientfield::register( "world", sprintf( "GameSettings_{0}{1}", setting[0], i ), VERSION_SHIP, 3, "int", setting[1], !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
		}
	}

	callback::on_localclient_connect( &on_connect );

	level.colors = array( "red", "orange", "yellow", "green", "blue", "purple", "pink", "white" );

	register_color_func( &set_tritium, 	array( 0, 1, 2, 3, 4, 5, 6, 7 ) );
	register_color_func( &set_laser, 	array( 0, 1, 2, 3, 4, 5, 6, 7 ) );
	register_color_func( &set_powerup, 	array( 0, 1, 2, 3, 4, 5, 6, 7 ) );
	register_color_func( &set_muzzle, 	array( 0, 1, 2, 3, 4, 5, 6, 7 ) );
	register_color_func( &set_eye, 		array( 0, 1, 2, 3, 4, 5, 6, 7 ) );
	register_color_func( &set_waffe, 	array( 0, 1, 1, 3, 4, 5, 6, 7 ) );
	register_color_func( &set_tgun, 	array( 0, 1, 2, 3, 4, 5, 6, 7 ) );
	register_color_func( &set_squid, 	array( 0, 1, 1, 4, 4, 5, 6, 7 ) );
	register_color_func( &set_wavegun, 	array( 0, 1, 2, 3, 4, 5, 6, 7 ) );
	register_color_func( &set_magmagat, array( 1, 1, 1, 4, 4, 5, 5, 1 ) );
}

function on_connect( localclientnum )
{
	player = GetLocalPlayer( localclientnum );
	player init_shader_constants( localclientnum );

	tint = get_tint_index();
	
	DEFAULT( world.idgun_colors, [] );
	DEFAULT( world.idgun_colors[localclientnum], tint );

	DEFAULT( world.tgun_colors, [] );
	DEFAULT( world.tgun_colors[localclientnum], tint );

	DEFAULT( world.wavegun_colors, [] );
	DEFAULT( world.wavegun_colors[localclientnum], tint );

	DEFAULT( world.gat_colors, [] );
	DEFAULT( world.gat_colors[localclientnum], tint );

	DEFAULT( world.tritium_colors, [] );
	DEFAULT( world.tritium_colors[localclientnum], tint );
}

function get_tint_index()
{
	maps = [];
	maps["zm_prototype"] = 1;
	maps["zm_asylum"] = 0;
	maps["zm_sumpf"] = 3;
	maps["zm_theater"] = 1;
	maps["zm_cosmodrome"] = 3;
	maps["zm_temple"] = 1;
	maps["zm_moon"] = 5;
	maps["zm_zod"] = 0;
	maps["zm_island"] = 3;
	maps["zm_stalingrad"] = 0;
	maps["zm_genesis"] = 6;
	maps["zm_prison"] = 1;
	maps["zm_town"] = 1;

	mapname = ToLower( GetDvarString( "mapname" ) );
	return( isdefined( maps[mapname] ) ? maps[mapname] : 4 );
}

function init_shader_constants( localclientnum )
{
	for( i = 0; i < 8; i++ )
	{
		self MapShaderConstant( localclientnum, "scriptVector" + i, i );
	}
}

function set_shader_constant( localclientnum, index, x = 0, y = 0, z = 0, w = 0 )
{
	self setshaderconstant( localclientnum, index, x, y, z, w );
}

function set_effect( localclientnum, category, color )
{
	DEFAULT( world._effect, [] );
	DEFAULT( world._effect[category], [] );
	world._effect[category][localclientnum] = color;

	if( !isdefined( level._effect ) || !isdefined( level._effect[category] ) || !IsArray( level._effect[category] ) )
	{
		return;
	}

	color_index = get_color_index( color );
	if( !isdefined( color_index ) )
	{
		return;
	}

	keys = GetArrayKeys( level._effect[category] );
	foreach( alias in keys )
	{
		DEFAULT( self._effect, [] );
		
		if( IsArray( level._effect[category][alias] ) )
		{
			path = level._effect[category][alias][color_index];
			
			if( isdefined( path ) )
			{
				self._effect[alias] = path;
			}
		}
	}
}

function get_color_index( color )
{
	if( IsInArray( level.colors, color ) )
	{
		for( i = 0; i < level.colors.size; i++ )
		{
			if( color == level.colors[i] )
			{
				return i;
			}
		}
	}
	return undefined;
}

function register_color_func( ptr, colors )
{
	DEFAULT( level.color_funcs, [] );
	struct = SpawnStruct();
	struct.ptr = ptr;
	struct.colors = colors;
	level.color_funcs[level.color_funcs.size] = struct;
}

function change_all( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	foreach( struct in level.color_funcs )
	{
		ptr = struct.ptr;
		if( IsFunctionPtr( ptr ) )
		{
			val = struct.colors[newval];
			[[ ptr ]]( localclientnum, oldval, val, bnewent, binitialsnap, fieldname, bwastimejump );
		}
	}
}

function set_tritium( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = GetLocalPlayer( localclientnum );
    player set_shader_constant( localclientnum, 0, newval * 16 );
    
    world.tritium_colors[localclientnum] = newval;
}

function set_laser( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = GetLocalPlayer( localclientnum );
    player set_effect( localclientnum, "laser", level.colors[newval] );
    player notify( "new_laser_color" );
}

function set_powerup( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level set_effect( localclientnum, "powerup", level.colors[newval] );
}

function set_muzzle( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = GetLocalPlayer( localclientnum );
    player set_effect( localclientnum, "muzzle", level.colors[newval] );
}

function set_eye( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    color_name = level.colors[newval];
    level._override_eye_fx = sprintf( "_xcdylan93/{0}/eyes/{0}_zombie_eyes", color_name );
    world._effect["eye"]   = color_name;
}

function set_waffe( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = GetLocalPlayer( localclientnum );
    color  = level.colors[newval];

    player set_effect( localclientnum, "tesla", color );
    player notify( "new_wonder_color" );
}

function set_tgun( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{	
    player = GetLocalPlayer( localclientnum );
    color  = level.colors[newval];

    player set_effect( localclientnum, "tgun", color );
    player set_shader_constant( localclientnum, 0, newval * 16 );
    
    player notify( "new_wonder_color" );
    world.tgun_colors[localclientnum] = newval;
}

function set_squid( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = GetLocalPlayer( localclientnum );
    
    player set_effect( localclientnum, "idgun", level.colors[newval] );

    color_idx = array( 0, 1, 1, 4, 4, 5, 6, 7 )[newval];
    tint      = array( 3, 2, 2, 1, 1, 0, 4, -1 )[newval];

    player set_shader_constant( localclientnum, 2, 0, 1, tint );
    world.idgun_colors[localclientnum] = newval;
}

function set_wavegun( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = GetLocalPlayer( localclientnum );
    color  = level.colors[newval];

    player set_effect( localclientnum, "wavegun", color );
    player set_shader_constant( localclientnum, 0, newval * 16 );
    
    world.wavegun_colors[localclientnum] = newval;
}

function set_magmagat( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = GetLocalPlayer( localclientnum );
    
    level set_effect( localclientnum, "magmagat", level.colors[newval] );

    tint = array( 1, 1, 1, 3, 3, 4, 4, 1 )[newval];
    
    player set_shader_constant( localclientnum, 2, 0, 1, tint );
    player notify( "new_wonder_color" );
    
    world.gat_colors[localclientnum] = newval;
}