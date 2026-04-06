#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;

#using scripts\zm\_xcdylan93\genesis\_zm_mod_fx;
#using scripts\zm\_xcdylan93\_zm_mod_huds;
#using scripts\zm\_xcdylan93\_zm_startmenu;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

REGISTER_SYSTEM( "zm_patch", &__init__, undefined )

function __init__()
{
	thread send_weapondata_to_lua();
	thread send_perkdata_to_lua();
    level.fx_color = init_fx_color_default();
}

function send_weapondata_to_lua()
{
    controllerModel = GetUIModelForController( 0 );
    weaponsCount = CreateUIModel( controllerModel, "zombie_weapons_count" );
    SetUIModelValue( weaponsCount, 0 );

    level flag::wait_till( "weapon_table_loaded" );
    keys = GetArrayKeys( level._included_weapons );
    upgrades = GetArrayKeys( level.zombie_weapons_upgraded );

    baseIndex = 0;

    for( i = 0; i < keys.size; i++ )
    {
        weapon = level._included_weapons[ keys[i] ];

        if( !IS_TRUE( weapon.in_box ) )
        {
            continue;
        }

        if( zm_weapons::is_weapon_upgraded( weapon ) )
        {
            continue;
        }

        rootweapon = weapon.rootweapon.name;
        name = GetWeapon( rootweapon ).displayname;
        displayname = MakeLocalizedString( name );

        SetUIModelValue( CreateUIModel( controllerModel, "zombie_weapons_" + baseIndex + ".displayname" ), displayname );
        SetUIModelValue( CreateUIModel( controllerModel, "zombie_weapons_" + baseIndex + ".rootname" ), rootweapon );

        for( j = 0; j < upgrades.size; j++ )
        {
        	if( level.zombie_weapons_upgraded[ upgrades[j] ] == weapon )
        	{
        		upgradeWeapon = upgrades[j];
        		upgradeRoot = upgradeWeapon.rootweapon.name;
        		SetUIModelValue( CreateUIModel( controllerModel, "zombie_weapons_upgrade_" + baseIndex ), upgradeRoot );
        		break;
        	}
        }

        SetUIModelValue( weaponsCount, GetUIModelValue( weaponsCount ) + 1 );

        baseIndex++;
    }
}

function send_perkdata_to_lua()
{
	controllerModel = GetUIModelForController( 0 );
    perksCount = CreateUIModel( controllerModel, "zombie_perks_count" );
    SetUIModelValue( perksCount, 0 );

    level flag::wait_till( "weapon_table_loaded" );
    keys = GetArrayKeys( level._custom_perks );

    for( i = 0; i < keys.size; i++ )
    {
    	perk = level._custom_perks[ keys[i] ];
    	str_perk = keys[i];

    	SetUIModelValue( CreateUIModel( controllerModel, "zombie_perks_" + i + ".specialty" ), str_perk );
    	SetUIModelValue( perksCount, GetUIModelValue( perksCount ) + 1 );
    }
}

function init_fx_color_default()
{
    colors = [];
    colors["zm_genesis"] = "pink";

    mapname = ToLower( GetDvarString( "mapname" ) );
    return( isdefined( colors[mapname] ) ? colors[mapname] : "blue" );
}