require( "ui.uieditor.widgets.hud.Inventory.ZMPrisonNotifKey" )
require( "ui.uieditor.widgets.hud.Inventory.ZMPrisonShieldWidget" )
require( "ui.uieditor.widgets.hud.Inventory.ZMPrisonAcidGatWidget" )
require( "ui.uieditor.widgets.hud.Inventory.ZMPrisonRefuelWidget" )
require( "ui.uieditor.widgets.hud.Inventory.ZMPrisonPlaneQuestWidget" )

local AddImage = function( self, controller, options, image )
	local self = LUI.UIImage.new( self, controller )

	self:setLeftRight( true, false, options.left, options.right )
	self:setTopBottom( false, true, options.top, options.bottom )
	self:setImage( RegisterImage( "$blacktransparent" ) )
	if options.scale then
		self:setScale( options.scale )
	end
	if options.zrot then
		self:setZRot( options.zrot )
	end
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), options.clientfield ), function ( model )
		if Engine.GetModelValue( model ) == 1 then
			self:setImage( RegisterImage( image ) )
		else
			self:setImage( RegisterImage( "$blacktransparent" ) )
		end
	end )
	return self
end

local AddImagePlane = function( self, controller, options, image )
	local self = LUI.UIImage.new( self, controller )

	self:setLeftRight( true, false, options.left, options.right )
	self:setTopBottom( false, true, options.top, options.bottom )
	self:setImage( RegisterImage( "$blacktransparent" ) )
	if options.scale then
		self:setScale( options.scale )
	end
	if options.zrot then
		self:setZRot( options.zrot )
	end
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), options.clientfield ), function ( model )
		if Engine.GetModelValue( model ) == 1 then
			self:setImage( RegisterImage( image ) )
		else
			self:setImage( RegisterImage( "$blacktransparent" ) )
		end
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "switch_inv_to_fuel" ), function ( model )
		if Engine.GetModelValue( model ) then
			self:setImage( RegisterImage( "$blacktransparent" ) )
		end
	end )
	return self
end

CoD.ZMPrisonInventoryWidget = InheritFrom( LUI.UIElement )
CoD.ZMPrisonInventoryWidget.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMPrisonInventoryWidget )
	self.id = "ZMPrisonInventory"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.InventoryBG = LUI.UIImage.new()
	self.InventoryBG:setLeftRight( true, false, 0, 1280 )
	self.InventoryBG:setTopBottom( false, true, -184, 0 )
	self.InventoryBG:setImage( RegisterImage( "uie_t7_zm_prison_inventory_background_plane" ) )
	self:addElement( self.InventoryBG )

	self.InventoryBG:addElement( AddImage( self, controller, { left = 19.33, right = 141.33, top = -133.33, bottom = -11.33, clientfield = "questItem.WardensKey" }, "uie_t7_zm_prison_inventory_key" ) )
	self.InventoryBG:addElement( AddImagePlane( self, controller, { left = 180, right = 292, top = -121.33, bottom = -9.33, clientfield = "questItem.Plane.clothes" }, "uie_t7_zm_prison_inventory_laundry" ) )
	self.InventoryBG:addElement( AddImagePlane( self, controller, { left = 403.33, right = 510, top = -114, bottom = -7.33, clientfield = "questItem.Plane.engine" }, "uie_t7_zm_prison_inventory_engine" ) )
	self.InventoryBG:addElement( AddImagePlane( self, controller, { left = 302.66, right = 390.66, top = -108.66, bottom = -20.66, clientfield = "questItem.Plane.tank" }, "uie_t7_zm_prison_inventory_tank" ) )
	self.InventoryBG:addElement( AddImagePlane( self, controller, { left = 515.33, right = 618, top = -116, bottom = -13.33, clientfield = "questItem.Plane.valves" }, "uie_t7_zm_prison_inventory_valve" ) )
	self.InventoryBG:addElement( AddImagePlane( self, controller, { left = 626.66, right = 726.66, top = -118, bottom = -18, clientfield = "questItem.Plane.rigging" }, "uie_t7_zm_prison_inventory_rigging" ) )
	self.InventoryBG:addElement( AddImage( self, controller, { left = 194, right = 279.33, top = -107.33, bottom = -22, clientfield = "questItem.Refuel.01" }, "uie_t7_zm_prison_inventory_fuel" ) )
	self.InventoryBG:addElement( AddImage( self, controller, { left = 304, right = 389.33, top = -107.33, bottom = -22, clientfield = "questItem.Refuel.02" }, "uie_t7_zm_prison_inventory_fuel" ) )
	self.InventoryBG:addElement( AddImage( self, controller, { left = 414, right = 499.33, top = -107.33, bottom = -22, clientfield = "questItem.Refuel.03" }, "uie_t7_zm_prison_inventory_fuel" ) )
	self.InventoryBG:addElement( AddImage( self, controller, { left = 526.66, right = 612, top = -107.33, bottom = -22, clientfield = "questItem.Refuel.04" }, "uie_t7_zm_prison_inventory_fuel" ) )
	self.InventoryBG:addElement( AddImage( self, controller, { left = 636, right = 721.33, top = -107.33, bottom = -22, clientfield = "questItem.Refuel.05" }, "uie_t7_zm_prison_inventory_fuel" ) )
	self.InventoryBG:addElement( AddImage( self, controller, { left = 761.33, right = 847.33, top = -106.66, bottom = -20.66, clientfield = "questItem.ZombieShield.dolly" }, "uie_t7_zm_prison_inventory_zshield_dolly" ) )
	self.InventoryBG:addElement( AddImage( self, controller, { left = 838.66, right = 928, top = -109.33, bottom = -20, clientfield = "questItem.ZombieShield.door" }, "uie_t7_zm_prison_inventory_zshield_door" ) )
	self.InventoryBG:addElement( AddImage( self, controller, { left = 923.33, right = 995.33, top = -98, bottom = -26, clientfield = "questItem.ZombieShield.shackles" }, "uie_t7_zm_prison_inventory_zshield_shackles" ) )
	self.InventoryBG:addElement( AddImage( self, controller, { left = 1018, right = 1115.33, top = -108, bottom = -10.66, clientfield = "questItem.AcidGat.engine" }, "uie_t7_zm_prison_inventory_acidkit_fuse" ) )
	self.InventoryBG:addElement( AddImage( self, controller, { left = 1102, right = 1202.66, top = -103.33, bottom = -2.66, clientfield = "questItem.AcidGat.suitcase" }, "uie_t7_zm_prison_inventory_acidkit_case" ) )
	self.InventoryBG:addElement( AddImage( self, controller, { left = 1164.66, right = 1288, top = -120, bottom = -0.66, clientfield = "questItem.AcidGat.iv" }, "uie_t7_zm_prison_inventory_acidkit_blood" ) )

	self.KeyWidget = CoD.ZMPrisonNotifKey.new( self, controller )
	self.KeyWidget:setLeftRight( true, true, 0, 0 )
	self.KeyWidget:setTopBottom( true, true, 0, 0 )
	self:addElement( self.KeyWidget )

	self.PlaneQuestWidget = CoD.ZMPrisonPlaneQuestWidget.new( self, controller )
	self.PlaneQuestWidget:setLeftRight( true, true, 0, 0 )
	self.PlaneQuestWidget:setTopBottom( true, true, 0, 0 )
	self:addElement( self.PlaneQuestWidget )

	self.RefuelWidget = CoD.ZMPrisonRefuelWidget.new( self, controller )
	self.RefuelWidget:setLeftRight( true, true, 0, 0 )
	self.RefuelWidget:setTopBottom( true, true, 0, 0 )
	self:addElement( self.RefuelWidget )

	self.ShieldWidget = CoD.ZMPrisonShieldWidget.new( self, controller )
	self.ShieldWidget:setLeftRight( true, true, 0, 0 )
	self.ShieldWidget:setTopBottom( true, true, 0, 0 )
	self:addElement( self.ShieldWidget )

	self.AcidGatWidget = CoD.ZMPrisonAcidGatWidget.new( self, controller )
	self.AcidGatWidget:setLeftRight( true, true, 0, 0 )
	self.AcidGatWidget:setTopBottom( true, true, 0, 0 )
	self:addElement( self.AcidGatWidget )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.InventoryBG:completeAnimation()
				self.InventoryBG:setAlpha( 0 )
				self.clipFinished( self.InventoryBG, {} )

				self.KeyWidget:completeAnimation()
				self.KeyWidget:setAlpha( 1 )
				self.clipFinished( self.KeyWidget, {} )

				self.ShieldWidget:completeAnimation()
				self.ShieldWidget:setAlpha( 1 )
				self.clipFinished( self.ShieldWidget, {} )
			end
		},
		Visible = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.InventoryBG:completeAnimation()
				self.InventoryBG:setAlpha( 1 )
				self.clipFinished( self.InventoryBG, {} )

				self.KeyWidget:completeAnimation()
				self.KeyWidget:setAlpha( 0 )
				self.clipFinished( self.KeyWidget, {} )

				self.ShieldWidget:completeAnimation()
				self.ShieldWidget:setAlpha( 0 )
				self.clipFinished( self.ShieldWidget, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Visible",
			condition = function ( menu, element, event )
				if Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED ) then
					return true
				else
					return false
				end
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED } )
	end )

	self.InventoryBG:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "switch_inv_to_fuel" ), function ( model )
		if Engine.GetModelValue( model ) == 1 then
			self.InventoryBG:setImage( RegisterImage( "uie_t7_zm_prison_inventory_background_fuel" ) )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.InventoryBG:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end