require( "ui.uieditor.widgets.HUD.ZM_Perks.PerkListItemFactory" )
require( "ui.uieditor.widgets.HUD.ZM_Perks.ZMPerksTable" )

local activePerksTable = CoD.ZMPerksTable[5]

local GetPerkIndex = function( perksList, perkCF )
	if perksList ~= nil then
		for index = 1, #perksList do
			if perksList[index].properties.key == perkCF then
				return index
			end
		end
	end

	return nil
end

local HandlePerksList = function( element, controller )
	if not element.perksList then
		element.perksList = {}
	end

	local tableUpdated = false
	local perksParentModel = Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.perks" )
	
	for key, value in pairs( activePerksTable ) do
		local perkStatus = Engine.GetModelValue( Engine.GetModel( perksParentModel, key ) )

		if perkStatus ~= nil and perkStatus > 0 then
			local existingIndex = GetPerkIndex( element.perksList, key )
			
			if not existingIndex then
				table.insert( element.perksList, {
					models = { image = value, status = perkStatus, newPerk = false },
					properties = { key = key }
				} )
				tableUpdated = true
			else
				local item = element.perksList[ existingIndex ]
				if item.models.image ~= value or item.models.status ~= perkStatus then
					item.models.image = value
					item.models.status = perkStatus
					tableUpdated = true
					
					local listModel = Engine.GetModel( Engine.GetModel( Engine.GetModelForController( controller ), "ZMPerksFactory" ), tostring( existingIndex ) )
					if listModel then
						Engine.SetModelValue( Engine.GetModel( listModel, "image" ), value )
						Engine.SetModelValue( Engine.GetModel( listModel, "status" ), perkStatus )
					end
				end
			end
		else
			local existingIndex = GetPerkIndex( element.perksList, key )
			if existingIndex then
				table.remove( element.perksList, existingIndex )
				tableUpdated = true
			end
		end
	end

	return tableUpdated
end

--[[ DataSources.T8Perks = DataSourceHelpers.ListSetup( "T8Perks", function( controller, element )
	local perks = {}

	HandlePerksList( element, controller )

	for index = 1, 4 do
		table.insert( perks, {
			models = { image = "blacktransparent" }
		} )
	end

	for index = 1, #element.perksList do
		if index <= 4 then
			perks[ index ] = element.perksList[ index ]
		end
	end

	return perks
end, true ) ]]

DataSources.T8Perks = DataSourceHelpers.ListSetup( "T8Perks", function ( controller, element )
	HandlePerksList( element, controller )
	return element.perksList
end, true )

--[[ DataSources.T8Perks2 = DataSourceHelpers.ListSetup( "T8Perks2", function( controller, element )
	local perks = {}

	HandlePerksList( element, controller )

	if #element.perksList <= 4 then
		return perks
	end

	for index = 1, #element.perksList do
		if index > 4 then
			table.insert( perks, element.perksList[ index ] )
		end
	end

	return perks
end, true ) ]]

local PreLoadFunc = function( self, controller )
	local controllerModel = Engine.GetModelForController( controller )
	local selectedPerksModel = Engine.GetModel( controllerModel, "SelectedPerksIndex" )
	if not selectedPerksModel then
		selectedPerksModel = Engine.CreateModel( controllerModel, "SelectedPerksIndex" )
		Engine.SetModelValue( selectedPerksModel, 0 )
	end

	local perksParentModel = Engine.CreateModel( Engine.GetModelForController( controller ), "hudItems.perks" )
	
	local masterKeys = {}
	for _, styleTable in ipairs( CoD.ZMPerksTable ) do
		for k, _ in pairs( styleTable ) do
			masterKeys[k] = true
		end
	end

	for key, _ in pairs( masterKeys ) do
		self:subscribeToModel( Engine.CreateModel( perksParentModel, key ), function( model )
			if HandlePerksList( self.PerkList, controller ) then
				self.PerkList:updateDataSource()
			end
			--[[ if HandlePerksList( self.PerkList2, controller ) then
				self.PerkList2:updateDataSource()
			end ]]
		end, false )
	end
end

--[[ local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        self.Background:completeAnimation()
        self.Background:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
        CoD.UIColors.SetElementColor( self.Background, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end ]]

CoD.T8PerksContainer = InheritFrom( LUI.UIElement )
CoD.T8PerksContainer.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.T8PerksContainer )
	self.id = "T8PerksContainer"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	--[[ self.Background = LUI.UIImage.new()
	self.Background:setLeftRight( false, false, -119.5, 119.5 )
	self.Background:setTopBottom( false, true, -69, -33 )
	self.Background:setImage( RegisterImage( "t8_hud_perks_frame" ) )
	self:addElement( self.Background ) ]]
	
	--[[ self.PerkList = LUI.UIList.new( menu, controller, 6.5, 0, nil, false, false, 0, 0, false, false )
	self.PerkList:makeFocusable()
	self.PerkList:setLeftRight( false, false, 0, 0 )
	self.PerkList:setTopBottom( false, true, 0, -49.5 )
	self.PerkList:setWidgetType( CoD.PerkListItemFactory )
	self.PerkList:setHorizontalCount( 4 )
	self.PerkList:setDataSource( "T8Perks" )
	self:addElement( self.PerkList ) ]]

	self.PerkList = LUI.UIList.new( menu, controller, 3.5, 0, nil, false, false, 0, 0, false, false )
	self.PerkList:makeFocusable()
	self.PerkList:setLeftRight( true, false, 245.5, 0 )
	self.PerkList:setTopBottom( false, true, 0, -30 )
	self.PerkList:setWidgetType( CoD.PerkListItemFactory )
	self.PerkList:setVerticalCount( 3 )
	self.PerkList:setHorizontalCount( 10 )
	self.PerkList:setDataSource( "T8Perks" )
	self:addElement( self.PerkList )

	--[[ self.PerkList2 = LUI.UIList.new( menu, controller, 3.5, 0, nil, false, false, 0, 0, false, false )
	self.PerkList2:makeFocusable()
	self.PerkList2:setLeftRight( true, false, 245.5, 0 )
	self.PerkList2:setTopBottom( false, true, 0, -30 )
	self.PerkList2:setWidgetType( CoD.PerkListItemFactory )
	self.PerkList2:setVerticalCount( 3 )
	self.PerkList2:setHorizontalCount( 7 )
	self.PerkList2:setDataSource( "T8Perks2" )
	self:addElement( self.PerkList2 ) ]]

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "SelectedPerksIndex" ), function( model )
		local val = Engine.GetModelValue( model )
		if val and CoD.ZMPerksTable[ val ] then
			activePerksTable = CoD.ZMPerksTable[ val ]
			HandlePerksList( self.PerkList, controller )
			self.PerkList:updateDataSource()
			--[[ HandlePerksList( self.PerkList2, controller )
			self.PerkList2:updateDataSource() ]]
		end
	end )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )

				--[[ self.Background:completeAnimation()
				self.Background:setAlpha( 1 )
				self.clipFinished( self.Background, {} ) ]]

				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 1 )
				self.clipFinished( self.PerkList, {} )

				--[[ self.PerkList2:completeAnimation()
				self.PerkList2:setAlpha( 1 )
				self.clipFinished( self.PerkList2, {} ) ]]
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

				--[[ self.Background:completeAnimation()
				self.Background:setAlpha( 1 )
				HiddenTransition( self.Background, {} ) ]]

				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 1 )
				HiddenTransition( self.PerkList, {} )

				--[[ self.PerkList2:completeAnimation()
				self.PerkList2:setAlpha( 1 )
				HiddenTransition( self.PerkList2, {} ) ]]
			end
		},

		Hidden = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )

				--[[ self.Background:completeAnimation()
				self.Background:setAlpha( 0 )
				self.clipFinished( self.Background, {} ) ]]

				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 0 )
				self.clipFinished( self.PerkList, {} )

				--[[ self.PerkList2:completeAnimation()
				self.PerkList2:setAlpha( 0 )
				self.clipFinished( self.PerkList2, {} ) ]]
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

				--[[ self.Background:completeAnimation()
				self.Background:setAlpha( 0 )
				DefaultStateTransition( self.Background, {} ) ]]

				self.PerkList:completeAnimation()
				self.PerkList:setAlpha( 0 )
				DefaultStateTransition( self.PerkList, {} )

				--[[ self.PerkList2:completeAnimation()
				self.PerkList2:setAlpha( 0 )
				DefaultStateTransition( self.PerkList2, {} ) ]]
			end
		}
	}
	
	self:mergeStateConditions( {
		{
			stateName = "Hidden",
			condition = function( menu, element, event )
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

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_AMMO_COUNTER_HIDE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_PLAYER_IN_AFTERLIFE } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN } )
	end )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE } )
	end )

	self.PerkList.id = "PerkList"
	--self.PerkList2.id = "PerkList2"

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		--element.Background:close()
		element.PerkList:close()
		--element.PerkList2:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end