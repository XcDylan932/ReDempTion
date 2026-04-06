#using scripts\codescripts\struct;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_zm_weapons;

#insert scripts\shared\shared.gsh;
#insert scripts\zm\_zm_weap_tesla.gsh;

function init()
{
	level.weaponZMTeslaGun = GetWeapon( "tesla_gun" );
	level.weaponZMTeslaGunUpgraded = GetWeapon( "tesla_gun_upgraded" );

	if( !zm_weapons::is_weapon_included( level.weaponZMTeslaGun ) && !IS_TRUE( level.uses_tesla_powerup ) )
	{
		return;
	}

	level thread player_init();
	level thread tesla_notetrack_think();
}

function player_init()
{
	util::waitforclient(0);

	level.tesla_play_fx = [];
	level.tesla_play_rail = true;

	players = GetLocalPlayers();
	for ( i = 0; i < players.size; i++ )
	{
		level.tesla_play_fx[i] = false;
		players[i] thread tesla_fx_rail(i);
		players[i] thread tesla_happy(i);
		players[i] thread tesla_change_watcher(i);
	}
}

function tesla_fx_rail( localclientnum )
{
	self endon( "disconnect" );
	self endon( "entityshutdown" );

	for(;;)
	{
		waitrealtime( RandomFloatRange( 8, 12 ) );

		if( !level.tesla_play_fx[localclientnum] || !level.tesla_play_rail )
		{
			continue;
		}

		currentweapon = GetCurrentWeapon( localclientnum );
		if( currentweapon != level.weaponZMTeslaGun && currentweapon != level.weaponZMTeslaGunUpgraded )
		{
			continue;
		}

		if( IsADS( localclientnum ) || IsThrowingGrenade( localclientnum ) || IsMeleeing( localclientnum ) || IsOnTurret( localclientnum ) )
		{
			continue;
		}

		if( GetWeaponAmmoClip( localclientnum, currentweapon ) <= 0 )
		{
			continue;
		}

		fx = self get_fx_path( "tesla_rail" );
		PlayViewmodelFX( localclientnum, fx, "tag_flash" );
		PlaySound( localclientnum, "wpn_tesla_effects", ( 0, 0, 0 ) );
	}
}

function tesla_fx_tube( localclientnum )
{
	self endon( "disconnect" );
	self endon( "entityshutdown" );
	self endon( "weapon_change" );

	for(;;)
	{
		waitrealtime(0.1);

		w_current = GetCurrentWeapon( localclientnum );
		n_ammo = GetWeaponAmmoClip( localclientnum, w_current );

		if( n_ammo <= 0 )
		{
			if( isdefined( self.tesla_fxid ) )
			{
				self clear_tesla_tube( localclientnum );
			}
			continue;
		}

		tags = [];
		if( w_current == level.weaponZMTeslaGunUpgraded )
		{
			switch ( n_ammo )
			{
				case 1:
				case 2:
					tags = array( "tag_power", "tag_bulb_1" );
					fxid = 1;
					break;
				case 3:
				case 4:
					tags = array( "tag_power", "tag_bulb_1", "tag_bulb_2" );
					fxid = 2;
					break;
				default:
					tags = array( "tag_power", "tag_bulb_1", "tag_bulb_2", "tag_bulb_3" );
					fxid = 3;
					break;
			}
		}
		else
		{
			switch ( n_ammo )
			{
				case 1:
					tags = array( "tag_power", "tag_bulb_1" );
					fxid = 1;
					break;
				case 2:
					tags = array( "tag_power", "tag_bulb_1", "tag_bulb_2" );
					fxid = 2;
					break;
				default:
					tags = array( "tag_power", "tag_bulb_1", "tag_bulb_2", "tag_bulb_3" );
					fxid = 3;
					break;
			}
		}

		if( self.tesla_fxid === fxid )
		{
			continue;
		}

		if( isdefined( self.tesla_fxid ) )
		{
			self clear_tesla_tube( localclientnum );
		}

		self.tesla_fxid = fxid;
		self.tesla_fx = [];

		fx = self get_fx_path( "tesla_tube" );
		for( i = 0; i < tags.size; i++ )
		{
			if( ViewmodelHasTag( localclientnum, tags[i] ) )
			{
				self.tesla_fx[i] = PlayViewmodelFX( localclientnum, fx, tags[i] );
			}
		}
	}
}

function tesla_change_watcher( localclientnum )
{
	self endon( "disconnect" );
	self endon( "entityshutdown" );

	for(;;)
	{
		result = self util::waittill_any_return( "weapon_change", "tesla_tube_clear", "new_wonder_color", "weapon_fired" );

		w_current = GetCurrentWeapon( localclientnum );
		if( w_current == level.weaponZMTeslaGun || w_current == level.weaponZMTeslaGunUpgraded )
		{
			if( result != "weapon_fired" )
			{
				self clear_tesla_pers( localclientnum );
				self thread tesla_pers_fx( localclientnum );
			}
			else
			{
				self thread tesla_fired( localclientnum );
			}

			self clear_tesla_tube( localclientnum );
			self thread tesla_fx_tube( localclientnum );
			self thread tesla_action_monitor( localclientnum );
		}
		else
		{
			self clear_tesla_tube( localclientnum );
			self clear_tesla_pers( localclientnum );
		}
	}
}

function tesla_pers_fx( localclientnum )
{
	if( isdefined( self.tesla_pers_fx ) )
		return;

	fx = self get_fx_path( "tesla_pers" );
	self.tesla_pers_fx = PlayViewmodelFX( localclientnum, fx, "tag_fx" );
}

function clear_tesla_pers( localclientnum )
{
	if( isdefined( self.tesla_pers_fx ) )
	{
		DeleteFX( localclientnum, self.tesla_pers_fx, 1 );
		self.tesla_pers_fx = undefined;
	}
}

function clear_tesla_tube( localclientnum )
{
	if( isdefined( self.tesla_fx ) )
	{
		foreach( fx in self.tesla_fx )
		{
			DeleteFX( localclientnum, fx, 1 );
		}
		self.tesla_fx = undefined;
		self.tesla_fxid = undefined;
	}
}

function tesla_fired( localclientnum )
{
	if( isdefined( self.tesla_flash ) )
	{
		DeleteFX( localclientnum, self.tesla_flash, 1 );
		self.tesla_flash = undefined;
	}

	if( ViewmodelHasTag( localclientnum, "tag_flash" ) )
	{
		fx = self get_fx_path( "tesla_flash" );
		self.tesla_flash = PlayViewmodelFX( localclientnum, fx, "tag_flash" );
	}
}

function tesla_action_monitor( localclientnum )
{
	self endon( "disconnect" );
	self endon( "weapon_change" );
	self notify( "clear_tesla_tube" );
	self endon( "clear_tesla_tube" );

	for(;;)
	{
		if( IsThrowingGrenade( localclientnum ) || IsMeleeing( localclientnum ) )
		{
			self clear_tesla_tube( localclientnum );

			while ( IsThrowingGrenade( localclientnum ) || IsMeleeing( localclientnum ) )
			{
				wait 0.05;
			}

			self notify( "tesla_tube_clear" );
		}
		wait 0.05;
	}
}

function tesla_notetrack_think()
{
	for(;;)
	{
		level waittill( "notetrack", localclientnum, note );

		switch( note )
		{
			case "tesla_play_fx_off":
				level.tesla_play_fx[localclientnum] = false;
				break;

			case "tesla_play_fx_on":
				level.tesla_play_fx[localclientnum] = true;
				break;
		}
	}
}

function tesla_happy( localclientnum )
{
	for(;;)
	{
		level waittill( "TGH" );

		currentweapon = GetCurrentWeapon( localclientnum );
		if( currentweapon == level.weaponZMTeslaGun || currentweapon == level.weaponZMTeslaGunUpgraded )
		{
			PlaySound( localclientnum, "wpn_tesla_happy", ( 0, 0, 0 ) );
			level.tesla_play_rail = false;
			waitrealtime( 2 );
			level.tesla_play_rail = true;
		}
	}
}

function get_fx_path( key )
{
	return( isdefined( self._effect ) && isdefined( self._effect[key] ) ? self._effect[key] : ( isdefined( level._effect ) && isdefined( level._effect[key] ) ? level._effect[key] : undefined ) );
}