require( "ui.uieditor.widgets.HUD.KingslayerPowerupsWidget.KingslayerPowerupsListItem" )

CoD.PowerUps.ClientFieldNames = {
	{
		clientFieldName = "powerup_instant_kill",
		image = {
			[1] = "specialty_giant_killjoy_zombies",
			[2] = "specialty_instakill_zombies",
			[3] = "t5_specialty_instakill_zombies",
			[4] = "t6_specialty_instakill_zombies",
			[5] = "t8_specialty_instakill_zombies",
			[6] = "t10_specialty_instakill_zombies"
		}
	},
	{
		clientFieldName = "powerup_double_points",
		image = {
			[1] = "specialty_giant_2x_zombies",
			[2] = "specialty_2x_zombies",
			[3] = "t5_specialty_2x_zombies",
			[4] = "t6_specialty_2x_zombies",
			[5] = "t8_specialty_2x_zombies",
			[6] = "t10_specialty_2x_zombies"
		}
	},
	{
		clientFieldName = "powerup_fire_sale",
		image = {
			[1] = "specialty_giant_firesale_zombies",
			[2] = "specialty_firesale_zombies",
			[3] = "t5_specialty_firesale_zombies",
			[4] = "t6_specialty_firesale_zombies",
			[5] = "t8_specialty_firesale_zombies",
			[6] = "t10_specialty_firesale_zombies"
		}
	},
	{
		clientFieldName = "powerup_mini_gun",
		image = {
			[1] = "t7_hud_zm_powerup_giant_deathmachine",
			[2] = "t7_hud_zm_powerup_deathmachine",
			[3] = "t5_specialty_deathmachine_zombies",
			[4] = "t6_specialty_deathmachine_zombies",
			[5] = "t8_specialty_deathmachine_zombies",
			[6] = "t10_specialty_deathmachine_zombies"
		}
	},
	{
		clientFieldName = "powerup_zombie_blood",
		image = {
			[1] = "t7_zm_hd_specialty_zmblood",
			[2] = "t7_zm_hd_specialty_zmblood",
			[3] = "t5_specialty_zombieblood_zombies",
			[4] = "t6_specialty_zomblood_zombies",
			[5] = "t8_specialty_zomblood_zombies",
			[6] = "t10_specialty_zomblood_zombies"
		}
	}
}

CoD.PowerUps.Update = function( self, event )
	local powerupStateModel = Engine.GetModel( Engine.GetModelForController( event.controller ), event.name .. ".state" )
	local powerupTimeModel = Engine.GetModel( Engine.GetModelForController( event.controller ), event.name .. ".time" )
	if powerupStateModel ~= nil then
		Engine.SetModelValue( powerupStateModel, event.newValue )
	end
end

local PreLoadFunc = function( self, controller )
	local controllerModel = Engine.GetModelForController( controller )
	local selectedHudModel = Engine.GetModel( controllerModel, "SelectedHudIndex" )
	local selectedPowerupsModel = Engine.GetModel( controllerModel, "SelectedPowerupsIndex" )
	if not selectedPowerupsModel then
		selectedPowerupsModel = Engine.CreateModel( controllerModel, "SelectedPowerupsIndex" )
		Engine.SetModelValue( selectedPowerupsModel, 1 )
	end
	if not selectedHudModel then
		selectedHudModel = Engine.CreateModel( controllerModel, "SelectedHudIndex" )
		Engine.SetModelValue( selectedHudModel, 0 )
	end

	for index = 1, #CoD.PowerUps.ClientFieldNames do
		local stateModel = Engine.CreateModel( Engine.GetModelForController( controller ), CoD.PowerUps.ClientFieldNames[index].clientFieldName .. ".state" )
		local timeModel = Engine.CreateModel( controllerModel, CoD.PowerUps.ClientFieldNames[index].clientFieldName .. ".time" )
		Engine.SetModelValue( stateModel, 0 )
		Engine.SetModelValue( timeModel, 0 )
	end
end

local PostLoadFunc = function( self, controller, menu )
	for index = 1, #CoD.PowerUps.ClientFieldNames do
		local powerupStateModel = Engine.GetModel( Engine.GetModelForController( controller ), CoD.PowerUps.ClientFieldNames[index].clientFieldName .. ".state" )
		local powerupTimeModel = Engine.GetModel( Engine.GetModelForController( controller ), CoD.PowerUps.ClientFieldNames[index].clientFieldName .. ".time" )
		
		if powerupStateModel ~= nil then
			self.PowerupList:subscribeToModel( powerupStateModel, function( model )
				self.PowerupList:updateDataSource()
			end )
		end
		if powerupTimeModel ~= nil then
			self.PowerupList:subscribeToModel( powerupTimeModel, function( model )
				self.PowerupList:updateDataSource()
			end )
		end
	end
end

DataSources.KingslayerPowerups = DataSourceHelpers.ListSetup( "KingslayerPowerups", function( controller, element )	
	local powerups = {}

	local styleModel = Engine.GetModel( Engine.GetModelForController( controller ), "SelectedPowerupsIndex" )
	local styleIndex = Engine.GetModelValue( styleModel ) or 1

	for index = 1, #CoD.PowerUps.ClientFieldNames do
		local fieldData = CoD.PowerUps.ClientFieldNames[ index ]
		local powerupState = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), fieldData.clientFieldName .. ".state" ) )
		local powerupTime = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), fieldData.clientFieldName .. ".time" ) )

		if powerupState and powerupState > 0 then
			table.insert( powerups, {
				models = { image = fieldData.image[ styleIndex ], state = powerupState, time = powerupTime }
			} )
		end
	end
	return powerups
end, true )

CoD.KingslayerPowerupsContainer = InheritFrom( LUI.UIElement )
CoD.KingslayerPowerupsContainer.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.KingslayerPowerupsContainer )
	self.id = "KingslayerPowerupsContainer"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )

	local powerupsTopBottom = {
	    [0] = { topAnchor = false, bottomAnchor = true, top = 70, bottom = -18.5 },
	    [3] = { topAnchor = false, bottomAnchor = true, top = -20, bottom = -108.5 },
	    [4] = { topAnchor = false, bottomAnchor = true, top = 30, bottom = -58.5 }
	}

	self.PowerupList = LUI.UIList.new( menu, controller, 17, 0, nil, false, false, 0, 0, false, false )
	self.PowerupList:makeFocusable()
	self.PowerupList:setLeftRight( false, false, 0, 0 )
	self.PowerupList:setTopBottom( false, true, 0, -88.5 )
	self.PowerupList:setWidgetType( CoD.KingslayerPowerupsListItem )
	self.PowerupList:setHorizontalCount( 5 )
	self.PowerupList:setDataSource( "KingslayerPowerups" )
	self.PowerupList:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "SelectedHudIndex" ), function( model )
		local value = Engine.GetModelValue( model ) or 0
		if value then
			local tb = powerupsTopBottom[ value ] or powerupsTopBottom[0]
			self.PowerupList:setTopBottom( tb.topAnchor, tb.bottomAnchor, tb.top, tb.bottom )
		end
	end )
	self:addElement( self.PowerupList )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "SelectedPowerupsIndex" ), function( model )
		self.PowerupList:updateDataSource()
	end )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )

				self.PowerupList:completeAnimation()
				self.PowerupList:setAlpha( 1 )
				self.clipFinished( self.PowerupList, {} )
			end,

			Hidden = function()
				self:setupElementClipCounter( 1 )
	
				local HiddenTransition = function( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
	
					element:setAlpha( 0 )
	
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				self.PowerupList:completeAnimation()
				self.PowerupList:setAlpha( 1 )
				HiddenTransition( self.PowerupList, {} )
			end
		},

		Hidden = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )

				self.PowerupList:completeAnimation()
				self.PowerupList:setAlpha( 0 )
				self.clipFinished( self.PowerupList, {} )
			end,

			DefaultState = function()
				self:setupElementClipCounter( 1 )

				local DefaultStateTransition = function( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
	
					element:setAlpha( 1 )
	
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				self.PowerupList:completeAnimation()
				self.PowerupList:setAlpha( 0 )
				DefaultStateTransition( self.PowerupList, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Hidden",
			condition = function( menu, element, event )
				local isVisible = Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
				and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE )
					
				return not isVisible
			end
		}
	} )

	local visBits = {
		Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE,
		Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN,
		Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM,
		Enum.UIVisibilityBit.BIT_EMP_ACTIVE,
		Enum.UIVisibilityBit.BIT_GAME_ENDED,
		Enum.UIVisibilityBit.BIT_HUD_VISIBLE,
		Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE,
		Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC,
		Enum.UIVisibilityBit.BIT_IN_VEHICLE,
		Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED,
		Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE,
		Enum.UIVisibilityBit.BIT_IS_SCOPED,
		Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN,
		Enum.UIVisibilityBit.BIT_UI_ACTIVE
	}

	for _, bit in ipairs( visBits ) do
		self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. bit ), function( model )
			menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. bit } )
		end )
	end

	self.PowerupList.id = "PowerupList"

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.PowerupList:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end