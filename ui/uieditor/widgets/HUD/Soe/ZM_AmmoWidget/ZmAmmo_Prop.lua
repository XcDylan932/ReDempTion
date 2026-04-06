require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_DpadAmmoNumbers" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_DpadIconBgm" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_DpadIconMine" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_DpadIconSide" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_DpadIconShield" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_DpadIconSword" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_DpadMeterSword" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadIconBottomFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadIconMineFactory" )

local colorToImageMap = {
    lavender = "purple",
    cyan     = "blue",
    lime     = "green",
    gold     = "yellow",
    magenta  = "pink",
    crimson  = "red",
	teal 	 = "blue",
	silver	 = "white",
}

local PreLoadFunc = function ( self, controller )
	local hudItemsModel = Engine.GetModel( Engine.GetModelForController( controller ), "hudItems" )
	Engine.CreateModel( hudItemsModel, "actionSlot0ammo" )
	Engine.CreateModel( hudItemsModel, "actionSlot1ammo" )
	Engine.CreateModel( hudItemsModel, "actionSlot2ammo" )
	Engine.CreateModel( hudItemsModel, "actionSlot3ammo" )
end

local PostLoadFunc = function( self, controller, menu )
	self.UpdateColors = function( self )
        local color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]
        local imageSuffix = colorToImageMap[color] or color
        
        local elements = {
            self.BulbSmFill,
            self.BulbSmEdge,
            self.BulbLgFill,
            self.BulbLgEdge,
            self.BulbFlmnt,
            self.Glow1
        }

        for _, element in ipairs( elements ) do
            if element then
                element:completeAnimation()
                element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
                CoD.UIColors.SetElementColor( element, color )
            end
        end

        if self.DpadElement then
        	self.DpadElement:setImage( RegisterImage( "uie_t7_zm_hud_ammo_dpadelement_" .. imageSuffix ) )
        end
    end

	local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_Prop = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_Prop.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_Prop )
	self.id = "ZmAmmo_Prop"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 233 )
	self:setTopBottom( true, false, 0, 144 )
	self.anyChildUsesUpdateState = true
	
	self.BulbSmFill = LUI.UIImage.new()
	self.BulbSmFill:setLeftRight( true, false, 4.31, 172.31 )
	self.BulbSmFill:setTopBottom( true, false, 34, 122 )
	self.BulbSmFill:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bulbsmfill" ) )
	self:addElement( self.BulbSmFill )
	
	self.BulbSmEdge = LUI.UIImage.new()
	self.BulbSmEdge:setLeftRight( true, false, 4.31, 172.31 )
	self.BulbSmEdge:setTopBottom( true, false, 34, 122 )
	self.BulbSmEdge:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bulbsmedge" ) )
	self.BulbSmEdge:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.BulbSmEdge )
	
	self.BulbLgFill = LUI.UIImage.new()
	self.BulbLgFill:setLeftRight( true, false, -39.69, 160.31 )
	self.BulbLgFill:setTopBottom( true, false, 29, 125 )
	self.BulbLgFill:setAlpha( 0 )
	self.BulbLgFill:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bulblrgfill" ) )
	self:addElement( self.BulbLgFill )
	
	self.BulbLgEdge = LUI.UIImage.new()
	self.BulbLgEdge:setLeftRight( true, false, -40.69, 159.31 )
	self.BulbLgEdge:setTopBottom( true, false, 29, 125 )
	self.BulbLgEdge:setAlpha( 0 )
	self.BulbLgEdge:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bulblrgedge" ) )
	self.BulbLgEdge:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.BulbLgEdge )
	
	self.BulbFlmnt = LUI.UIImage.new()
	self.BulbFlmnt:setLeftRight( true, false, 9.31, 169.31 )
	self.BulbFlmnt:setTopBottom( true, false, 37, 125 )
	self.BulbFlmnt:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bulbflmnt" ) )
	self.BulbFlmnt:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_multiply" ) )
	self:addElement( self.BulbFlmnt )
	
	self.Glow1 = LUI.UIImage.new()
	self.Glow1:setLeftRight( true, false, 0, 191 )
	self.Glow1:setTopBottom( true, false, 28, 122 )
	CoD.UIColors.SetElementColor( self.Glow1, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.Glow1:setAlpha( 0.23 )
	self.Glow1:setZRot( -4 )
	self.Glow1:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self:addElement( self.Glow1 )
	
	self.DpadElement = LUI.UIImage.new()
	self.DpadElement:setLeftRight( true, false, 125.96, 252.66 )
	self.DpadElement:setTopBottom( true, false, 23.65, 150.35 )
	self.DpadElement:setImage( RegisterImage( "uie_t7_zm_hud_ammo_dpadelement_new" ) )
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
	self:addElement( self.DpadIconWpn )
	
	self.DpadIconBgm = CoD.ZmAmmo_DpadIconBgm.new( menu, controller )
	self.DpadIconBgm:setLeftRight( true, false, 171.31, 187.31 )
	self.DpadIconBgm:setTopBottom( true, false, 41, 57 )
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
	
	self.DpadIconMine = CoD.ZmAmmo_DpadIconMine.new( menu, controller )
	self.DpadIconMine:setLeftRight( true, false, 200.21, 216.21 )
	self.DpadIconMine:setTopBottom( true, false, 87, 103 )
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

	if not ( Engine.GetCurrentMap() == "zm_zod" ) then
		self.DpadIconSpider = CoD.ZmAmmo_DpadIconMineFactory.new( menu, controller )
		self.DpadIconSpider:setLeftRight( true, false, 198, 214 )
		self.DpadIconSpider:setTopBottom( true, false, 83, 99 )
		self.DpadIconSpider:setScale( 0.85 )
		if self.DpadIconSpider.IconImgMineDisabled then
			self.DpadIconSpider.IconImgMineDisabled:setImage( RegisterImage( "uie_t7_zm_island_hud_ammo_icon_spider_inactive" ) )
		end
		if self.DpadIconSpider.IconImgMineActive then
			self.DpadIconSpider.IconImgMineActive:setImage( RegisterImage( "uie_t7_zm_island_hud_ammo_icon_spider" ) )
			CoD.UIColors.SetElementColor( self.DpadIconSpider.IconImgMineActive, "orange" )
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
			CoD.UIColors.SetElementColor( self.DpadIconDragonStrike.IconImgMineActive, "orange" )
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
			CoD.UIColors.SetElementColor( self.DpadIconDrone.IconImgMineActive, "orange" )
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
		if self.DpadIconPES.IconImgShieldDisabled then
			self.DpadIconPES.IconImgShieldDisabled:setScale( 0.8 )
		end
		if self.DpadIconPES.IconImgShieldActive then
			self.DpadIconPES.IconImgShieldActive:setScale( 0.8 )
			CoD.UIColors.SetElementColor( self.DpadIconPES.IconImgShieldActive, "orange" )
		end
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
		if self.DpadIconHackTool.IconImgShieldDisabled then
			self.DpadIconHackTool.IconImgShieldDisabled:setScale( 0.8 )
			self.DpadIconHackTool.IconImgShieldDisabled:setImage( RegisterImage( "uie_t7_zm_hud_ammo_icon_hack" ) )
		end
		if self.DpadIconHackTool.IconImgShieldActive then
			self.DpadIconHackTool.IconImgShieldActive:setScale( 0.8 )
			self.DpadIconHackTool.IconImgShieldActive:setImage( RegisterImage( "uie_t7_zm_hud_ammo_icon_hack_active" ) )
			CoD.UIColors.SetElementColor( self.DpadIconHackTool.IconImgShieldActive, "orange" )
		end
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
	end
	
	self.DpadIconShld = CoD.ZmAmmo_DpadIconShield.new( menu, controller )
	self.DpadIconShld:setLeftRight( true, false, 166.31, 181.31 )
	self.DpadIconShld:setTopBottom( true, false, 122, 137 )
	self.DpadIconShld:mergeStateConditions( {
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
	self.DpadIconShld:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown" ), function ( model )
		menu:updateElementState( self.DpadIconShld, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadDown" } )
	end )
	self:addElement( self.DpadIconShld )
	
	self.DpadIconSword = CoD.ZmAmmo_DpadIconSword.new( menu, controller )
	self.DpadIconSword:setLeftRight( true, false, 160.31, 192.31 )
	self.DpadIconSword:setTopBottom( true, false, 72, 104 )
	self:addElement( self.DpadIconSword )
	
	self.ZmAmmoDpadMeterSword0 = CoD.ZmAmmo_DpadMeterSword.new( menu, controller )
	self.ZmAmmoDpadMeterSword0:setLeftRight( true, false, 156, 204 )
	self.ZmAmmoDpadMeterSword0:setTopBottom( true, false, 62, 118 )
	self:addElement( self.ZmAmmoDpadMeterSword0 )
	
	self.DpadAmmoNumbersRight = CoD.ZmAmmo_DpadAmmoNumbers.new( menu, controller )
	self.DpadAmmoNumbersRight:setLeftRight( true, false, 225.31, 243.31 )
	self.DpadAmmoNumbersRight:setTopBottom( true, false, 85, 103 )
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
	
	self.DpadAmmoNumbersTop = CoD.ZmAmmo_DpadAmmoNumbers.new( menu, controller )
	self.DpadAmmoNumbersTop:setLeftRight( true, false, 171.31, 189.31 )
	self.DpadAmmoNumbersTop:setTopBottom( true, false, 132.35, 150.35 )
	self.DpadAmmoNumbersTop:mergeStateConditions( {
		{
			stateName = "ShowZ",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Show5",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.actionSlot1ammo", 5 )
			end
		},
		{
			stateName = "Show4",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.actionSlot1ammo", 4 )
			end
		},
		{
			stateName = "Show3",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.actionSlot1ammo", 3 )
			end
		},
		{
			stateName = "Show2",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.actionSlot1ammo", 2 )
			end
		},
		{
			stateName = "Show1",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.actionSlot1ammo", 1 )
			end
		},
		{
			stateName = "Show0",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "hudItems.showDpadDown", 1 )
			end
		},
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		}
	} )
	self.DpadAmmoNumbersTop:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot1ammo" ), function ( model )
		menu:updateElementState( self.DpadAmmoNumbersTop, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.actionSlot1ammo" } )
	end )
	self.DpadAmmoNumbersTop:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown" ), function ( model )
		menu:updateElementState( self.DpadAmmoNumbersTop, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.showDpadDown" } )
	end )
	self:addElement( self.DpadAmmoNumbersTop )
	
	self.DpadAmmoNumbersBottom = CoD.ZmAmmo_DpadAmmoNumbers.new( menu, controller )
	self.DpadAmmoNumbersBottom:setLeftRight( true, false, 172.31, 190.31 )
	self.DpadAmmoNumbersBottom:setTopBottom( true, false, 25, 43 )
	self.DpadAmmoNumbersBottom:mergeStateConditions( {
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
	self.DpadAmmoNumbersBottom:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "bgb_activations_remaining" ), function ( model )
		menu:updateElementState( self.DpadAmmoNumbersBottom, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "bgb_activations_remaining" } )
	end )
	self:addElement( self.DpadAmmoNumbersBottom )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.BulbSmFill:completeAnimation()
				self.BulbSmFill:setAlpha( 1 )
				self.clipFinished( self.BulbSmFill, {} )

				self.BulbSmEdge:completeAnimation()
				self.BulbSmEdge:setAlpha( 1 )
				self.clipFinished( self.BulbSmEdge, {} )

				self.BulbLgFill:completeAnimation()
				self.BulbLgFill:setAlpha( 0 )
				self.clipFinished( self.BulbLgFill, {} )

				self.BulbLgEdge:completeAnimation()
				self.BulbLgEdge:setAlpha( 0 )
				self.clipFinished( self.BulbLgEdge, {} )
			end
		},

		WeaponDual = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.BulbSmFill:completeAnimation()
				self.BulbSmFill:setAlpha( 0 )
				self.clipFinished( self.BulbSmFill, {} )

				self.BulbSmEdge:completeAnimation()
				self.BulbSmEdge:setAlpha( 0 )
				self.clipFinished( self.BulbSmEdge, {} )

				self.BulbLgFill:completeAnimation()
				self.BulbLgFill:setAlpha( 0.93 )
				self.clipFinished( self.BulbLgFill, {} )

				self.BulbLgEdge:completeAnimation()
				self.BulbLgEdge:setAlpha( 1 )
				self.clipFinished( self.BulbLgEdge, {} )
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
	    local widgetsToClose = {
	        "DpadIconWpn",
	        "DpadIconBgm",
	        "DpadIconMine",
	        "DpadIconSpider", 
	        "DpadIconDragonStrike",
	        "DpadIconDrone",
	        "DpadIconPES", 
	        "DpadIconHackTool",
	        "DpadIconShld",
	        "DpadIconSword", 
	        "ZmAmmoDpadMeterSword0",
	        "DpadAmmoNumbersRight", 
	        "DpadAmmoNumbersTop",
	        "DpadAmmoNumbersBottom"
	    }

	    for _, widgetName in ipairs( widgetsToClose ) do
	        if element[widgetName] then
	            element[widgetName]:close()
	        end
	    end
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end