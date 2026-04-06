require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_PropSparks" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_DpadIconSide" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_HologramSmallFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_ParticleFX" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadIconMineFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadIconBgmFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadIconBottomFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadIconPistolFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_FlickerLoopFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_GlowLoopFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadIconLeftFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadMeterPistolFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadAmmoNumbersFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadLeftAmmoNumberWidgetFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetStalingrad.ZmAmmo_DpadIconShieldStalingrad" )
require( "ui.uieditor.widgets.onOffImage" )

local function ShouldShowDpadAmmo( controller, ammoValue )
    local isBlockedMap = IsMapName( "zm_island" ) or IsMapName( "zm_tomb" ) or IsMapName( "zm_moon" )
    local hasCorrectAmmo = IsModelValueEqualTo( controller, "hudItems.actionSlot1ammo", ammoValue )
    
    return hasCorrectAmmo and not isBlockedMap
end

local PreLoadFunc = function ( self, controller )
	local hudItemsModel = Engine.GetModel( Engine.GetModelForController( controller ), "hudItems" )
	Engine.CreateModel( hudItemsModel, "actionSlot0ammo" )
	Engine.CreateModel( hudItemsModel, "actionSlot1ammo" )
	Engine.CreateModel( hudItemsModel, "actionSlot2ammo" )
	Engine.CreateModel( hudItemsModel, "actionSlot3ammo" )
	--[[Engine.CreateModel( hudItemsModel, "dpadLeftAmmo" )
	Engine.CreateModel( hudItemsModel, "showDpadRight_Spider" )
	Engine.CreateModel( hudItemsModel, "showDpadRight_DragonStrike" )
	Engine.CreateModel( hudItemsModel, "showDpadRight_Gateworm" )
	Engine.CreateModel( hudItemsModel, "showDpadRight_Chicken" )
	Engine.CreateModel( hudItemsModel, "showDpadRight_Drone" )
	Engine.CreateModel( hudItemsModel, "showDpadLeft_Staff" )
	Engine.CreateModel( hudItemsModel, "showDpadDown_PES" )
	Engine.CreateModel( hudItemsModel, "showDpadDown_HackTool" )
	Engine.CreateModel( hudItemsModel, "showDpadLeft_WaveGun" )--]]
end

CoD.ZmAmmo_PropFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_PropFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()
	local isZod = Engine.GetCurrentMap() == "zm_zod"

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_PropFactory )
	self.id = "ZmAmmo_PropFactory"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 233 )
	self:setTopBottom( true, false, 0, 144 )
	self.anyChildUsesUpdateState = true
	
	self.ZmAmmoHologramSmallFactory = CoD.ZmAmmo_HologramSmallFactory.new( menu, controller )
	self.ZmAmmoHologramSmallFactory:setLeftRight( true, false, -10.87, 258.45 )
	self.ZmAmmoHologramSmallFactory:setTopBottom( true, false, -25.27, 183.92 )
	self:addElement( self.ZmAmmoHologramSmallFactory )
	
	self.BulbLgFill = LUI.UIImage.new()
	self.BulbLgFill:setLeftRight( true, false, -13.57, 261.15 )
	self.BulbLgFill:setTopBottom( true, false, -26.27, 185.05 )
	self.BulbLgFill:setAlpha( 0 )
	self.BulbLgFill:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_projection_lrg" ) )
	self:addElement( self.BulbLgFill )
	
	self.ZmAmmoParticleFX = CoD.ZmAmmo_ParticleFX.new( menu, controller )
	self.ZmAmmoParticleFX:setLeftRight( true, false, 31.33, 174.81 )
	self.ZmAmmoParticleFX:setTopBottom( true, false, 42.09, 116.7 )
	self.ZmAmmoParticleFX:setXRot( 1 )
	self.ZmAmmoParticleFX:setYRot( 1 )
	self.ZmAmmoParticleFX:setZRot( -10 )
	self.ZmAmmoParticleFX:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmAmmoParticleFX.p2:setAlpha( 0 )
	self.ZmAmmoParticleFX.p3:setAlpha( 0 )
	self:addElement( self.ZmAmmoParticleFX )
	
	self.ZmAmmoParticleFX2 = CoD.ZmAmmo_ParticleFX.new( menu, controller )
	self.ZmAmmoParticleFX2:setLeftRight( true, false, 31.33, 174.81 )
	self.ZmAmmoParticleFX2:setTopBottom( true, false, 39.7, 114.3 )
	self.ZmAmmoParticleFX2:setZRot( -10 )
	self.ZmAmmoParticleFX2:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmAmmoParticleFX2.p1:setAlpha( 0 )
	self.ZmAmmoParticleFX2.p3:setAlpha( 0 )
	self:addElement( self.ZmAmmoParticleFX2 )
	
	self.ZmAmmoParticleFX3 = CoD.ZmAmmo_ParticleFX.new( menu, controller )
	self.ZmAmmoParticleFX3:setLeftRight( true, false, 31.33, 174.81 )
	self.ZmAmmoParticleFX3:setTopBottom( true, false, 40.7, 115.3 )
	self.ZmAmmoParticleFX3:setZRot( -10 )
	self.ZmAmmoParticleFX3:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmAmmoParticleFX3.p1:setAlpha( 0 )
	self.ZmAmmoParticleFX3.p2:setAlpha( 0 )
	self:addElement( self.ZmAmmoParticleFX3 )
	
	self.ZmAmmoPropSparks = CoD.ZmAmmo_PropSparks.new( menu, controller )
	self.ZmAmmoPropSparks:setLeftRight( true, false, 17.81, 160.81 )
	self.ZmAmmoPropSparks:setTopBottom( true, false, 44.35, 119.35 )
	self:addElement( self.ZmAmmoPropSparks )
	
	self.DpadElement = LUI.UIImage.new()
	self.DpadElement:setLeftRight( true, false, 122.96, 249.66 )
	self.DpadElement:setTopBottom( true, false, 11, 152.7 )
	self.DpadElement:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_dpadbase" ) )
	self:addElement( self.DpadElement )
	
	self.DpadIconWpn = CoD.ZmAmmo_DpadIconSide.new( menu, controller )
	self.DpadIconWpn:setLeftRight( true, false, 140, 156 )
	self.DpadIconWpn:setTopBottom( true, false, 76, 92 )
	self.DpadIconWpn:setAlpha( 0 )
	self.DpadIconWpn:mergeStateConditions( {
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )
	self.DpadIconWpn:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "SelectedHudIndex" ), function ( model )
		menu:updateElementState( self.DpadIconWpn, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "SelectedHudIndex" } )
	end )
	self:addElement( self.DpadIconWpn )
	
	self.DpadIconChicken = CoD.ZmAmmo_DpadIconMineFactory.new( menu, controller )
	self.DpadIconChicken:setLeftRight( true, false, 198, 214 )
	self.DpadIconChicken:setTopBottom( true, false, 83, 99 )
	if self.DpadIconChicken.IconImgMineDisabled then
		self.DpadIconChicken.IconImgMineDisabled:setImage( RegisterImage( "uie_t7_zm_genesis_hud_ammo_icon_chicken_inactive" ) )
	end
	if self.DpadIconChicken.IconImgMineActive then
		self.DpadIconChicken.IconImgMineActive:setImage( RegisterImage( "uie_t7_zm_genesis_hud_ammo_icon_chicken" ) )
	end
	self.DpadIconChicken:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight_Chicken", 1 ) and IsModelValueGreaterThan( controller, "hudItems.actionSlot3ammo", 0 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight_Chicken", 1 )
			end
		}
	} )
	self.DpadIconChicken:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadRight_Chicken" ), function ( model )
		menu:updateElementState( self.DpadIconChicken, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadRight_Chicken" } )
	end )
	self.DpadIconChicken:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( model )
		menu:updateElementState( self.DpadIconChicken, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.actionSlot3ammo" } )
	end )
	self:addElement( self.DpadIconChicken )
	
	self.DpadIconGateworm = CoD.ZmAmmo_DpadIconMineFactory.new( menu, controller )
	self.DpadIconGateworm:setLeftRight( true, false, 198, 214 )
	self.DpadIconGateworm:setTopBottom( true, false, 83, 99 )
	if self.DpadIconGateworm.IconImgMineDisabled then
		self.DpadIconGateworm.IconImgMineDisabled:setImage( RegisterImage( "uie_t7_zm_genesis_hud_ammo_icon_gateworm_inactive" ) )
	end
	if self.DpadIconGateworm.IconImgMineActive then
		self.DpadIconGateworm.IconImgMineActive:setImage( RegisterImage( "uie_t7_zm_genesis_hud_ammo_icon_gateworm" ) )
	end
	self.DpadIconGateworm:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight_Gateworm", 1 ) and IsModelValueGreaterThan( controller, "hudItems.actionSlot3ammo", 0 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight_Gateworm", 1 )
			end
		}
	} )
	self.DpadIconGateworm:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadRight_Gateworm" ), function ( model )
		menu:updateElementState( self.DpadIconGateworm, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadRight_Gateworm" } )
	end )
	self.DpadIconGateworm:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( model )
		menu:updateElementState( self.DpadIconGateworm, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.actionSlot3ammo" } )
	end )
	self:addElement( self.DpadIconGateworm )
	
	self.DpadIconBgm = CoD.ZmAmmo_DpadIconBgmFactory.new( menu, controller )
	self.DpadIconBgm:setLeftRight( true, false, 168, 184 )
	self.DpadIconBgm:setTopBottom( true, false, 41, 57 )
	self.DpadIconBgm:setScale( 0.91 )
	self.DpadIconBgm:subscribeToGlobalModel( controller, "PerController", "bgb_invalid_use", function ( model )
		PulseElementToStateAndBack( self.DpadIconBgm, "InvalidUse" )
	end )
	self.DpadIconBgm:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThan( controller, "bgb_activations_remaining", 0 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadUp", 1 )
			end
		}
	} )
	self.DpadIconBgm:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "bgb_activations_remaining" ), function ( model )
		menu:updateElementState( self.DpadIconBgm, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "bgb_activations_remaining" } )
	end )
	self.DpadIconBgm:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadUp" ), function ( model )
		menu:updateElementState( self.DpadIconBgm, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadUp" } )
	end )
	self:addElement( self.DpadIconBgm )
	
	self.DpadIconMine = CoD.ZmAmmo_DpadIconMineFactory.new( menu, controller )
	self.DpadIconMine:setLeftRight( true, false, 198, 214 )
	self.DpadIconMine:setTopBottom( true, false, 83, 99 )
	self.DpadIconMine:setScale( 0.85 )
	self.DpadIconMine:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight", 1 ) and IsModelValueGreaterThan( controller, "hudItems.actionSlot3ammo", 0 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight", 1 )
			end
		}
	} )
	self.DpadIconMine:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadRight" ), function ( model )
		menu:updateElementState( self.DpadIconMine, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadRight" } )
	end )
	self.DpadIconMine:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( model )
		menu:updateElementState( self.DpadIconMine, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.actionSlot3ammo" } )
	end )
	self:addElement( self.DpadIconMine )
	
	self.DpadIconSpider = CoD.ZmAmmo_DpadIconMineFactory.new( menu, controller )
	self.DpadIconSpider:setLeftRight( true, false, 198, 214 )
	self.DpadIconSpider:setTopBottom( true, false, 83, 99 )
	self.DpadIconSpider:setScale( 0.85 )
	if self.DpadIconSpider.IconImgMineDisabled then
		self.DpadIconSpider.IconImgMineDisabled:setImage( RegisterImage( "uie_t7_zm_island_hud_ammo_icon_spider_inactive" ) )
	end
	if self.DpadIconSpider.IconImgMineActive then
		self.DpadIconSpider.IconImgMineActive:setImage( RegisterImage( "uie_t7_zm_island_hud_ammo_icon_spider" ) )
	end
	self.DpadIconSpider:subscribeToGlobalModel( controller, "PerController", "dragon_strike_invalid_use", function ( model )
		PulseElementToStateAndBack( self.DpadIconSpider, "InvalidUse" )
	end )
	self.DpadIconSpider:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight_Spider", 1 ) and IsModelValueGreaterThan( controller, "hudItems.actionSlot3ammo", 0 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight_Spider", 1 )
			end
		}
	} )
	self.DpadIconSpider:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadRight_Spider" ), function ( model )
		menu:updateElementState( self.DpadIconSpider, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadRight_Spider" } )
	end )
	self.DpadIconSpider:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( model )
		menu:updateElementState( self.DpadIconSpider, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.actionSlot3ammo" } )
	end )
	self:addElement( self.DpadIconSpider )
	
	self.DpadIconDragonStrike = CoD.ZmAmmo_DpadIconMineFactory.new( menu, controller )
	self.DpadIconDragonStrike:setLeftRight( true, false, 198, 214 )
	self.DpadIconDragonStrike:setTopBottom( true, false, 83, 99 )
	self.DpadIconDragonStrike:setScale( 0.85 )
	if self.DpadIconDragonStrike.IconImgMineDisabled then
		self.DpadIconDragonStrike.IconImgMineDisabled:setImage( RegisterImage( "uie_t7_icon_inventory_dlc3_dragonstrike_console" ) )
	end
	if self.DpadIconDragonStrike.IconImgMineActive then
		self.DpadIconDragonStrike.IconImgMineActive:setImage( RegisterImage( "uie_t7_icon_inventory_dlc3_dragonstrike_console" ) )
	end
	self.DpadIconDragonStrike:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight_DragonStrike", 1 ) and IsModelValueGreaterThan( controller, "hudItems.actionSlot3ammo", 0 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight_DragonStrike", 1 )
			end
		}
	} )
	self.DpadIconDragonStrike:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadRight_DragonStrike" ), function ( model )
		menu:updateElementState( self.DpadIconDragonStrike, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadRight_DragonStrike" } )
	end )
	self.DpadIconDragonStrike:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( model )
		menu:updateElementState( self.DpadIconDragonStrike, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.actionSlot3ammo" } )
	end )
	self:addElement( self.DpadIconDragonStrike )
	
	self.DpadIconDrone = CoD.ZmAmmo_DpadIconMineFactory.new( menu, controller )
	self.DpadIconDrone:setLeftRight( true, false, 198, 214 )
	self.DpadIconDrone:setTopBottom( true, false, 83, 99 )
	self.DpadIconDrone:setScale( 0.85 )
	if self.DpadIconDrone.IconImgMineDisabled then
		self.DpadIconDrone.IconImgMineDisabled:setImage( RegisterImage( "uie_t7_zm_hd_hud_ammo_icon_drone_inactive" ) )
	end
	if self.DpadIconDrone.IconImgMineActive then
		self.DpadIconDrone.IconImgMineActive:setImage( RegisterImage( "uie_t7_zm_hd_hud_ammo_icon_drone_active" ) )
	end
	self.DpadIconDrone:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight_Drone", 1 ) and IsModelValueGreaterThan( controller, "hudItems.actionSlot3ammo", 0 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadRight_Drone", 1 )
			end
		}
	} )
	self.DpadIconDrone:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadRight_Drone" ), function ( model )
		menu:updateElementState( self.DpadIconDrone, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadRight_Drone" } )
	end )
	self.DpadIconDrone:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( model )
		menu:updateElementState( self.DpadIconDrone, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.actionSlot3ammo" } )
	end )
	self:addElement( self.DpadIconDrone )
	
	self.DpadIconPES = CoD.ZmAmmo_DpadIconBottomFactory.new( menu, controller )
	self.DpadIconPES:setLeftRight( true, false, 163, 178 )
	self.DpadIconPES:setTopBottom( true, false, 113, 128 )
	self.DpadIconPES.IconImgShieldDisabled:setScale( 0.8 )
	self.DpadIconPES.IconImgShieldActive:setScale( 0.8 )
	self.DpadIconPES:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadDown_PES", 1 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )
	self.DpadIconPES:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown_PES" ), function ( model )
		menu:updateElementState( self.DpadIconPES, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadDown_PES" } )
	end )
	self:addElement( self.DpadIconPES )
	
	self.DpadIconHackTool = CoD.ZmAmmo_DpadIconBottomFactory.new( menu, controller )
	self.DpadIconHackTool:setLeftRight( true, false, 163, 178 )
	self.DpadIconHackTool:setTopBottom( true, false, 113, 128 )
	self.DpadIconHackTool.IconImgShieldDisabled:setScale( 0.8 )
	self.DpadIconHackTool.IconImgShieldDisabled:setImage( RegisterImage( "uie_t7_zm_hud_ammo_icon_hack" ) )
	self.DpadIconHackTool.IconImgShieldActive:setScale( 0.8 )
	self.DpadIconHackTool.IconImgShieldActive:setImage( RegisterImage( "uie_t7_zm_hud_ammo_icon_hack_active" ) )
	self.DpadIconHackTool:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadDown_HackTool", 1 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )
	self.DpadIconHackTool:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown_HackTool" ), function ( model )
		menu:updateElementState( self.DpadIconHackTool, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadDown_HackTool" } )
	end )
	self:addElement( self.DpadIconHackTool )
	
	self.DpadIconShield = CoD.ZmAmmo_DpadIconShieldStalingrad.new( menu, controller )
	self.DpadIconShield:setLeftRight( true, false, 163, 178 )
	self.DpadIconShield:setTopBottom( true, false, 113, 128 )
	self.DpadIconShield:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadDown", 1 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )
	self.DpadIconShield:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown" ), function ( model )
		menu:updateElementState( self.DpadIconShield, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadDown" } )
	end )
	self:addElement( self.DpadIconShield )
	
	self.DpadIconSword = CoD.ZmAmmo_DpadIconPistolFactory.new( menu, controller )
	self.DpadIconSword:setLeftRight( true, false, 158.81, 190.81 )
	self.DpadIconSword:setTopBottom( true, false, 68, 100 )
	self:addElement( self.DpadIconSword )
	
	self.ZmAmmoFlickerLoopFactory = CoD.ZmAmmo_FlickerLoopFactory.new( menu, controller )
	self.ZmAmmoFlickerLoopFactory:setLeftRight( true, false, 122.58, 249.42 )
	self.ZmAmmoFlickerLoopFactory:setTopBottom( true, false, 26, 152.85 )
	self:addElement( self.ZmAmmoFlickerLoopFactory )
	
	self.ZmAmmoGlowLoopFactory = CoD.ZmAmmo_GlowLoopFactory.new( menu, controller )
	self.ZmAmmoGlowLoopFactory:setLeftRight( true, false, 119, 179 )
	self.ZmAmmoGlowLoopFactory:setTopBottom( true, false, 65.39, 125.39 )
	self.ZmAmmoGlowLoopFactory:setScale( 0.8 )
	self:addElement( self.ZmAmmoGlowLoopFactory )
	
	self.DpadIconStaff = CoD.ZmAmmo_DpadIconLeftFactory.new( menu, controller )
	self.DpadIconStaff:setLeftRight( false, false, 17, 33 )
	self.DpadIconStaff:setTopBottom( false, false, 1, 17 )
	if self.DpadIconStaff.IconImgMineDisabled then
		self.DpadIconStaff.IconImgMineDisabled:setImage( RegisterImage( "uie_t7_zm_hd_hud_ammo_icon_staff_inactive" ) )
	end
	if self.DpadIconStaff.IconImgMineActive then
		self.DpadIconStaff.IconImgMineActive:setImage( RegisterImage( "uie_t7_zm_hd_hud_ammo_icon_staff_active" ) )
	end
	self.DpadIconStaff:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadLeft_Staff", 1 ) and IsModelValueGreaterThan( controller, "hudItems.dpadLeftAmmo", 0 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadLeft_Staff", 1 )
			end
		}
	} )
	self.DpadIconStaff:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadLeft_Staff" ), function ( model )
		menu:updateElementState( self.DpadIconStaff, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadLeft_Staff" } )
	end )
	self.DpadIconStaff:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.dpadLeftAmmo" ), function ( model )
		menu:updateElementState( self.DpadIconStaff, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.dpadLeftAmmo" } )
	end )
	self:addElement( self.DpadIconStaff )
	
	--[[self.DpadIconWaveGun = CoD.ZmAmmo_DpadIconLeftFactory.new( menu, controller )
	self.DpadIconWaveGun:setLeftRight( false, false, 17, 33 )
	self.DpadIconWaveGun:setTopBottom( false, false, 1, 17 )
	if self.DpadIconWaveGun.IconImgMineDisabled then
		self.DpadIconWaveGun.IconImgMineDisabled:setImage( RegisterImage( "uie_t7_zm_hud_ammo_icon_wavegun" ) )
	end
	if self.DpadIconWaveGun.IconImgMineActive then
		self.DpadIconWaveGun.IconImgMineActive:setImage( RegisterImage( "uie_t7_zm_hud_ammo_icon_wavegun_active" ) )
	end
	self.DpadIconWaveGun:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadLeft_WaveGun", 1 ) and IsModelValueGreaterThan( controller, "hudItems.dpadLeftAmmo", 0 )
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadLeft_WaveGun", 1 )
			end
		}
	} )
	self.DpadIconWaveGun:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadLeft_WaveGun" ), function ( model )
		menu:updateElementState( self.DpadIconWaveGun, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadLeft_WaveGun" } )
	end )
	self.DpadIconWaveGun:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.dpadLeftAmmo" ), function ( model )
		menu:updateElementState( self.DpadIconWaveGun, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.dpadLeftAmmo" } )
	end )
	self:addElement( self.DpadIconWaveGun )--]]
	
	self.ZmAmmoDpadMeterPistol = CoD.ZmAmmo_DpadMeterPistolFactory.new( menu, controller )
	self.ZmAmmoDpadMeterPistol:setLeftRight( true, false, 154, 202 )
	self.ZmAmmoDpadMeterPistol:setTopBottom( true, false, 58, 114 )
	self.ZmAmmoDpadMeterPistol:setScale( 0.95 )
	self:addElement( self.ZmAmmoDpadMeterPistol )
	
	self.DpadAmmoNumbersRight = CoD.ZmAmmo_DpadAmmoNumbersFactory.new( menu, controller )
	self.DpadAmmoNumbersRight:setLeftRight( true, false, 223, 241 )
	self.DpadAmmoNumbersRight:setTopBottom( true, false, 82, 100 )
	self.DpadAmmoNumbersRight:mergeStateConditions( {
		{
			stateName = "ShowZ",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Show5",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.actionSlot3ammo", 5 )
			end
		},
		{
			stateName = "Show4",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.actionSlot3ammo", 4 )
			end
		},
		{
			stateName = "Show3",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.actionSlot3ammo", 3 )
			end
		},
		{
			stateName = "Show2",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.actionSlot3ammo", 2 )
			end
		},
		{
			stateName = "Show1",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.actionSlot3ammo", 1 )
			end
		},
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		}
	} )
	self.DpadAmmoNumbersRight:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( model )
		menu:updateElementState( self.DpadAmmoNumbersRight, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.actionSlot3ammo" } )
	end )
	self:addElement( self.DpadAmmoNumbersRight )
	
	self.DpadAmmoNumbersBottom = CoD.ZmAmmo_DpadAmmoNumbersFactory.new( menu, controller )
	self.DpadAmmoNumbersBottom:setLeftRight( true, false, 169, 187 )
	self.DpadAmmoNumbersBottom:setTopBottom( true, false, 134.7, 152.7 )
	self.DpadAmmoNumbersBottom:mergeStateConditions( {
	    {
	        stateName = "ShowZ",
	        condition = function( menu, element, event )
	        	return AlwaysFalse()
	        end
	    },
	    {
	        stateName = "Show5",
	        condition = function( menu, element, event )
	        	return ShouldShowDpadAmmo( controller, 5 )
	        end
	    },
	    {
	        stateName = "Show4",
	        condition = function( menu, element, event )
	        	return ShouldShowDpadAmmo( controller, 4 )
	        end
	    },
	    {
	        stateName = "Show3",
	        condition = function( menu, element, event )
	        	return ShouldShowDpadAmmo( controller, 3 )
	        end
	    },
	    {
	        stateName = "Show2",
	        condition = function( menu, element, event )
	        	return ShouldShowDpadAmmo( controller, 2 )
	        end
	    },
	    {
	        stateName = "Show1",
	        condition = function( menu, element, event )
	        	return ShouldShowDpadAmmo( controller, 1 )
	        end
	    },
	    {
	        stateName = "Show0",
	        condition = function( menu, element, event ) 
	            return IsModelValueEqualTo( controller, "hudItems.showDpadDown", 1 ) 
				and not ( IsMapName( "zm_island" ) or IsMapName( "zm_tomb" ) or IsMapName( "zm_moon" ) )
	        end
	    },
	    {
	        stateName = "Hidden",
	        condition = function( menu, element, event )
	        	return AlwaysTrue()
	        end
	    }
	})
	self.DpadAmmoNumbersBottom:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot1ammo" ), function ( model )
		menu:updateElementState( self.DpadAmmoNumbersBottom, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.actionSlot1ammo" } )
	end )
	self.DpadAmmoNumbersBottom:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown" ), function ( model )
		menu:updateElementState( self.DpadAmmoNumbersBottom, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadDown" } )
	end )
	self:addElement( self.DpadAmmoNumbersBottom )
	
	self.DpadAmmoNumbersTop = CoD.ZmAmmo_DpadAmmoNumbersFactory.new( menu, controller )
	self.DpadAmmoNumbersTop:setLeftRight( true, false, 174.81, 192.81 )
	self.DpadAmmoNumbersTop:setTopBottom( true, false, 19, 37 )
	self.DpadAmmoNumbersTop:mergeStateConditions( {
		{
			stateName = "ShowZ",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "bgb_activations_remaining", 7 )
			end
		},
		{
			stateName = "ShowCross",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "bgb_activations_remaining", 6 )
			end
		},
		{
			stateName = "Show5",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "bgb_activations_remaining", 5 )
			end
		},
		{
			stateName = "Show4",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "bgb_activations_remaining", 4 )
			end
		},
		{
			stateName = "Show3",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "bgb_activations_remaining", 3 )
			end
		},
		{
			stateName = "Show2",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "bgb_activations_remaining", 2 )
			end
		},
		{
			stateName = "Show1",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "bgb_activations_remaining", 1 )
			end
		},
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		}
	} )
	self.DpadAmmoNumbersTop:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "bgb_activations_remaining" ), function ( model )
		menu:updateElementState( self.DpadAmmoNumbersTop, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "bgb_activations_remaining" } )
	end )
	self:addElement( self.DpadAmmoNumbersTop )
	
	self.DpadIconCounter = CoD.onOffImage.new( menu, controller )
	self.DpadIconCounter:setLeftRight( true, false, 100.3, 141.5 )
	self.DpadIconCounter:setTopBottom( true, false, 66.4, 107.6 )
	self.DpadIconCounter.image:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_dpadbase_left" ) )
	self.DpadIconCounter:mergeStateConditions( {
		{
			stateName = "On",
			condition = function ( menu, element, event )
				return IsAnyMapName( "zm_tomb", "zm_moon" )
			end
		}
	} )
	self.DpadIconCounter:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "SelectedHudIndex" ), function ( model )
		menu:updateElementState( self.DpadIconCounter, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "SelectedHudIndex" } )
	end )
	self:addElement( self.DpadIconCounter )
	
	self.DpadAmmoNumbersLeft = CoD.ZmAmmo_DpadLeftAmmoNumberWidgetFactory.new( menu, controller )
	self.DpadAmmoNumbersLeft:setLeftRight( true, false, 105.5, 129.5 )
	self.DpadAmmoNumbersLeft:setTopBottom( true, false, 72, 96 )
	self.DpadAmmoNumbersLeft:setXRot( 2 )
	self.DpadAmmoNumbersLeft:setYRot( -20 )
	self.DpadAmmoNumbersLeft:setScale( 1.1 )
	self.DpadAmmoNumbersLeft:mergeStateConditions( {
		{
			stateName = "Visible",
			condition = function ( menu, element, event )
				return IsAnyMapName( "zm_tomb", "zm_moon" )
			end
		}
	} )
	self.DpadAmmoNumbersLeft:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "SelectedHudIndex" ), function( model )
		menu:updateElementState( self.DpadAmmoNumbersLeft, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "SelectedHudIndex" } )
	end )
	self:addElement( self.DpadAmmoNumbersLeft )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				self.BulbLgFill:completeAnimation()
				self.BulbLgFill:setAlpha( 0 )
				self.clipFinished( self.BulbLgFill, {} )
			end
		},

		WeaponDual = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				self.BulbLgFill:completeAnimation()
				self.BulbLgFill:setAlpha( 0.93 )
				self.clipFinished( self.BulbLgFill, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "WeaponDual",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThanOrEqualTo( controller, "currentWeapon.ammoInDWClip", 0 )
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.ammoInDWClip" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.ammoInDWClip" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ZmAmmoHologramSmallFactory:close()
		element.ZmAmmoParticleFX:close()
		element.ZmAmmoParticleFX2:close()
		element.ZmAmmoParticleFX3:close()
		element.ZmAmmoPropSparks:close()
		element.DpadIconWpn:close()
		element.DpadIconChicken:close()
		element.DpadIconGateworm:close()
		element.DpadIconBgm:close()
		element.DpadIconMine:close()
		element.DpadIconSpider:close()
		element.DpadIconDragonStrike:close()
		element.DpadIconDrone:close()
		element.DpadIconPES:close()
		element.DpadIconHackTool:close()
		element.DpadIconShield:close()
		element.DpadIconSword:close()
		element.ZmAmmoFlickerLoopFactory:close()
		element.ZmAmmoGlowLoopFactory:close()
		element.DpadIconStaff:close()
		--element.DpadIconWaveGun:close()
		element.ZmAmmoDpadMeterPistol:close()
		element.DpadAmmoNumbersRight:close()
		element.DpadAmmoNumbersBottom:close()
		element.DpadAmmoNumbersTop:close()
		element.DpadIconCounter:close()
		element.DpadAmmoNumbersLeft:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end