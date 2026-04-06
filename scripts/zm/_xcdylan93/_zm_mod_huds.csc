#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_weapons;
#insert scripts\shared\shared.gsh;

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
	callback::on_localplayer_spawned( &on_spawned );
}

function __main__()
{
	LuiLoad( "ui.uieditor.widgets.HUD.HudInject" );
}

function on_spawned( localclientnum )
{
	self thread set_stock_max( localclientnum );
	self thread set_dw_clip_max( localclientnum );
	self thread set_weapon_class( localclientnum );
}

function set_stock_max( localclientnum )
{
	self endon( "disconnect" );
	self endon( "entityshutdown" );
	self notify( "set_stock_max" );
	self endon( "set_stock_max" );

	controllerModel = GetUIModelForController( localclientnum );
	stockMaxModel = CreateUIModel( controllerModel, "currentWeapon.ammoStockMax" );

	for(;;)
	{
		wait 0.016;

		current_weapon = GetCurrentWeapon( localclientnum );
		stockMax = current_weapon.maxammo;

		if( GetUIModelValue( stockMaxModel ) === stockMax )
		{
			continue;
		}

		SetUIModelValue( stockMaxModel, stockMax );
	}
}

function set_dw_clip_max( localclientnum )
{
	self endon( "disconnect" );
	self endon( "entityshutdown" );
	self notify( "set_dw_clip_max" );
	self endon( "set_dw_clip_max" );

	controllerModel = GetUIModelForController( localclientnum );
	clipMaxDwModel = CreateUIModel( controllerModel, "currentWeapon.clipMaxAmmoDW" );

	for(;;)
	{
		wait 0.01;

		current_weapon = GetCurrentWeapon( localclientnum );
		clipMaxDW = current_weapon.dualwieldweapon.clipsize;

		if( GetUIModelValue( clipMaxDwModel ) === clipMaxDW )
		{
			continue;
		}

		SetUIModelValue( clipMaxDwModel, clipMaxDW );
	}
}

function set_weapon_class( localclientnum )
{
	self endon( "disconnect" );
	self endon( "entityshutdown" );
	self notify( "set_weapon_class" );
	self endon( "set_weapon_class" );

	controllerModel = GetUIModelForController( localclientnum );
	weaponClassModel = CreateUIModel( controllerModel, "currentWeapon.weaponClass" );

	for(;;)
	{
		self waittill( "weapon_change" );

		weapon = GetCurrentWeapon( localclientnum );
		weaponClass = weapon.weapclass;

		if( zm_weapons::is_wonder_weapon( weapon ) )
		{
			weaponClass = "wonderweapon";
		}

		if( !isdefined( weaponClass ) )
		{
			continue;
		}

		if( GetUIModelValue( weaponClassModel ) === weaponClass )
		{
			continue;
		}

		SetUIModelValue( weaponClassModel, weaponClass );
	}
}