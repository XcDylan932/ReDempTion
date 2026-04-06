#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_weap_thundergun.gsh;

#namespace zm_weap_thundergun;
	
REGISTER_SYSTEM_EX( "zm_weap_thundergun", &__init__, &__main__, undefined )

function __init__()
{
	level.weaponZMThunderGun = GetWeapon( "thundergun" );
	level.weaponZMThunderGunUpgraded = GetWeapon( "thundergun_upgraded" );
	clientfield::register( "scriptmover", "thundergun_trail", VERSION_SHIP, 1, "int", &thundergun_trail_fx, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
}

function __main__()
{	
	callback::on_localplayer_spawned( &localplayer_spawned );
}

function localplayer_spawned( localclientnum )
{
	self thread watch_for_thunderguns( localclientnum );
}

function watch_for_thunderguns( localclientnum )
{
	self notify( "watch_for_thunderguns" );
	self endon( "watch_for_thunderguns" );
	self endon( "disconnect" );
	self endon( "entityshutdown" );

	for(;;)
	{
		result = self util::waittill_any_return( "weapon_change", "tgun_glow_clear", "new_wonder_color", "weapon_fired" );
		
        w_current = GetCurrentWeapon( localclientnum );
		if( w_current == level.weaponZMThunderGun || w_current == level.weaponZMThunderGunUpgraded ) {
			
            if( result != "weapon_fired" )
            {
                self clear_tgun_pers( localclientnum );
                self thread tgun_pers_fx( localclientnum ); 
            }
			else
			{
				self thread play_tgun_flash( localclientnum );
			}

            self clear_tgun_glow( localclientnum );
			self thread thundergun_fx_power_cell( localclientnum );
			self thread tgun_action_monitor( localclientnum );
		}
        else 
        {
            self clear_tgun_pers( localclientnum );
            self clear_tgun_glow( localclientnum );
        }
	}
}

function tgun_pers_fx( localclientnum )
{
    if( isdefined( self.tgun_pers_fx ) )
    {
        return;
    }

    fx = self get_fx_path( "tgun_pers" );
    if( isdefined( fx ) )
    {
    	self.tgun_pers_fx = PlayViewmodelFX( localclientnum, fx, "tag_weapon" );
    }
}

function clear_tgun_pers( localclientnum )
{
	if( isdefined( self.tgun_pers_fx ) )
	{
		DeleteFX( localclientnum, self.tgun_pers_fx, 1 );
		self.tgun_pers_fx = undefined;
	}
}

function play_tgun_flash( localclientnum )
{
	if( isdefined( self.tgun_flash ) )
	{
		DeleteFX( localclientnum, self.tgun_flash );
		self.tgun_flash = undefined;
	}

	if( ViewmodelHasTag( localclientnum, "tag_flash" ) )
	{
		fx = self get_fx_path( "tgun_flash" );
		if( isdefined( fx ) )
		{
			self.tgun_flash = PlayViewmodelFX( localclientnum, fx, "tag_flash" );
		}
	}
}

function thundergun_trail_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
	if( isdefined( self.tgun_trail_fx ) )
	{
		StopFX( localclientnum, self.tgun_trail_fx );
		self.tgun_trail_fx = undefined;
	}

	if( newval )
	{
		fx = self get_fx_path( "tgun_trail" );
		if( isdefined( fx ) )
		{
			self.tgun_trail_fx = PlayFXOnTag( localclientnum, fx, self, "tag_origin" );
		}
	}
}

function thundergun_fx_power_cell( localclientnum )
{
	self endon( "disconnect" );
	self endon( "weapon_change" );
	self endon( "entityshutdown" );

	n_old_ammo = -1;
	for(;;)
	{
		tags = undefined;
		waitrealtime( 0.1 );
		w_current = GetCurrentWeapon( localclientnum );
		n_ammo = GetWeaponAmmoClip( localclientnum, w_current );
		if( n_old_ammo > 0 && n_old_ammo != n_ammo )
		{
			PlaySound( localclientnum, "wpn_thunder_breath", ( 0, 0, 0 ) );
		}
		n_old_ammo = n_ammo;
        
		if( n_ammo <= 0 )
		{
			if( isdefined( self.tgun_fxid ) )
			{
				self clear_tgun_glow( localclientnum );
			}
            
            self clear_tgun_pers( localclientnum ); 
			continue;
		}
        
        if( !isdefined( self.tgun_pers_fx ) )
        {
            self thread tgun_pers_fx( localclientnum );
        }

		tags = [];
		switch( n_ammo )
		{
			case 1:
				tags[0] = "tag_bulb4";
				fxid = 1;
				break;

			case 2:
				tags[0] = "tag_bulb3";
				tags[1] = "tag_bulb4";
				fxid = 2;
				break;

			case 3:
				tags[0] = "tag_bulb2";
				tags[1] = "tag_bulb3";
				tags[2] = "tag_bulb4";
				fxid = 3;
				break;

			case 4:
				tags[0] = "tag_bulb1";
				tags[1] = "tag_bulb2";
				tags[2] = "tag_bulb3";
				tags[3] = "tag_bulb4";
				fxid = 4;
				break;
		}
        
		if( self.tgun_fxid === fxid )
		{
			tags = undefined;
			continue;
		}

		else
		{
			if( isdefined( self.tgun_fxid ) )
			{
				self clear_tgun_glow( localclientnum );
			}
			self.tgun_fxid = fxid;
			self.tgun_fx = [];
			fx = self get_fx_path( "tgun_glow" );
			if( isdefined( fx ) )
			{
				for( i = 0; i < tags.size; i++ )
				{
					if( ViewmodelHasTag( localclientnum, tags[i] ) )
					{
						self.tgun_fx[i] = PlayViewmodelFX( localclientnum, fx, tags[i] );
					}
				}
			}
		}
	}
}

function clear_tgun_glow( localclientnum )
{
	if( isdefined( self.tgun_fx ) )
	{
		foreach( fx in self.tgun_fx )
		{
			DeleteFX( localclientnum, fx, 1 );
			fx = undefined;
		}
		self.tgun_fx = undefined;
		self.tgun_fxid = undefined;
	}
}

function tgun_action_monitor( localclientnum )
{
	self endon( "disconnect" );
	self endon( "weapon_change" );
	self notify( "clear_tgun_glow" );
	self endon( "clear_tgun_glow" );

	for(;;)
	{
		if( IsThrowingGrenade( localclientnum ) || IsMeleeing( localclientnum ) )
		{
			self clear_tgun_glow( localclientnum );
			if( IsThrowingGrenade( localclientnum ) )
			{
				while( IsThrowingGrenade( localclientnum ) )
				{
					wait 0.016;
				}
			}
			else if( IsMeleeing( localclientnum ) )
			{
				while( IsMeleeing( localclientnum ) )
				{
					wait 0.016;
				}
			}
			self notify( "tgun_glow_clear" );
		}
		wait 0.05;
	}
}

function get_fx_path( key )
{
	return( isdefined( self._effect ) && isdefined( self._effect[key] ) ? self._effect[key] : ( isdefined( level._effect ) && isdefined( level._effect[key] ) ? level._effect[key] : undefined ) );
}