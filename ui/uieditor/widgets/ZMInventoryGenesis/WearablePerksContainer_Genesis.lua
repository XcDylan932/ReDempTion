require( "ui.uieditor.widgets.HUD.ZM_Perks.PerkListItemFactory" )

local wearablePerks = {
	"specialty_purple_staminup_zombies",
	"specialty_purple_juggernaut_zombies"
}

local layouts = {
    [0] = { left = 0,    right = 74,   top = 0,   bottom = 36,  spacing = 2,   scale = 1 },
    [1] = { left = -130, right = -56,  top = -80, bottom = -44, spacing = 9,   scale = 1 },
    [2] = { left = -120, right = -46,  top = -80, bottom = -44, spacing = 2,   scale = 1 },
    [3] = { left = 115,  right = 189,  top = -5,  bottom = 31,  spacing = 3.5, scale = 1 },
    [4] = { left = -113, right = -39,  top = -12, bottom = 24,  spacing = 2,   scale = 0.8 }
}

DataSources.ZMWearablePerks = ListHelper_SetupDataSource( "ZMWearablePerks", function ( controller )
	local wearableIconsModel = Engine.GetModel( Engine.GetModelForController( controller ), "zmInventory.wearable_perk_icons" )
	local wearablePerkList = {}
	
	if wearableIconsModel then
		local wearableIconsValue = Engine.GetModelValue( wearableIconsModel )
		for index, image in ipairs( wearablePerks ) do
			if CoD.BitUtility.IsBitwiseAndNonZero( wearableIconsValue, index ) then
				table.insert( wearablePerkList, {
					models = { image = image, newPerk = true, status = 1 },
					properties = {}
				} )
			end
		end
	end
	
	return wearablePerkList
end )

local UpdateWearablePerksPostion = function( self, hudIndex )
	local currentLayout = layouts[hudIndex] or layouts[0]
	self.GridLayout0:setLeftRight( true, false, currentLayout.left, currentLayout.right )
	self.GridLayout0:setTopBottom( true, false, currentLayout.top , currentLayout.bottom )
	self.GridLayout0:setSpacing( currentLayout.spacing )
	self.GridLayout0:setScale( currentLayout.scale )
end

local PostLoadFunc = function ( self, controller, menu )
	local controllerModel = Engine.GetModelForController( controller )
	local wearableIconsModel = Engine.CreateModel( controllerModel, "zmInventory.wearable_perk_icons" )

	if wearableIconsModel then
		self.GridLayout0:subscribeToModel( wearableIconsModel, function( model )
			if Engine.GetModelValue( model ) ~= nil then
				self.GridLayout0:updateDataSource()
			end
		end )
	end

	local HudIndexModel = Engine.GetModel( controllerModel, "SelectedHudIndex" )
	if not HudIndexModel then
		HudIndexModel = Engine.CreateModel( controllerModel, "SelectedHudIndex" )
		Engine.SetModelValue( HudIndexModel, 0 )
	end
	self:subscribeToModel( HudIndexModel, function( model )
		local modelValue = Engine.GetModelValue( model )
		if modelValue then
			UpdateWearablePerksPostion( self, modelValue )
		end
	end )
end

CoD.WearablePerksContainer_Genesis = InheritFrom( LUI.UIElement )
CoD.WearablePerksContainer_Genesis.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.WearablePerksContainer_Genesis )
	self.id = "WearablePerksContainer_Genesis"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 74 )
	self:setTopBottom( true, false, 0, 36 )
	self.anyChildUsesUpdateState = true
	
	self.GridLayout0 = LUI.GridLayout.new( menu, controller, false, 9, 0, 2, 0, nil, nil, false, false, 0, 0, false, false )
	self.GridLayout0:setLeftRight( true, false, 0, 74 )
	self.GridLayout0:setTopBottom( true, false, 0, 36 )
	self.GridLayout0:setWidgetType( CoD.PerkListItemFactory )
	self.GridLayout0:setHorizontalCount( 2 )
	self.GridLayout0:setDataSource( "ZMWearablePerks" )
	self:addElement( self.GridLayout0 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				self.GridLayout0:completeAnimation()
				self.GridLayout0:setAlpha( 1 )
				self.clipFinished( self.GridLayout0, {} )
			end
		},

		Invisible = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				self.GridLayout0:completeAnimation()
				self.GridLayout0:setAlpha( 0 )
				self.clipFinished( self.GridLayout0, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Invisible",
			condition = function ( menu, element, event )
				if not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
				and Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE ) then
					return false
				else
					return true
				end
			end
		}
	} )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.GridLayout0:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end