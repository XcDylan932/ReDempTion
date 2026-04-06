require( "ui.uieditor.widgets.StartMenu.GumTracker.StartMenu_GumTracker_ListItem" )

local ResetBGBModels = function( self, controller, menu, playSound )
	local controllerModel = Engine.GetModelForController( controller )
	local bgbModel = Engine.GetModel( controllerModel, "BGB_Selections" )

	if bgbModel then
		for i = 1, 5 do
			local slot = Engine.GetModel( bgbModel, "slot" .. i )
			if slot then
				Engine.SetModelValue( slot, false )
			end
		end

		if playSound then
			Engine.PlaySound( "uin_bm_cycle_item_hit" )
		end

		if self.ButtonList then
			self.ButtonList:dispatchEventToChildren( { name = "update_state", menu = menu } )
		end
	end
end

local PreLoadFunc = function( self, controller )
    local controllerModel = Engine.GetModelForController( controller )
    local bgbSelection = Engine.CreateModel( controllerModel, "BGB_Selections" )

    for i = 1, 5 do
        local slot = Engine.CreateModel( bgbSelection, "slot" .. i )
        if Engine.GetModelValue( slot ) == nil then
            Engine.SetModelValue( slot, false )
        end
    end
end

local PostLoadFunc = function( self, controller, menu )
    self.ResetButton:registerEventHandler( "button_action", function( element, event )
        ResetBGBModels( self, controller, menu, true )
        return true
    end )

    local initialTrigger = true 

    self:subscribeToModel( Engine.GetModel( Engine.GetGlobalModel(), "fastRestart" ), function( model )
        if initialTrigger then
            initialTrigger = false
            return 
        end
        
        ResetBGBModels( self, controller, menu, false )
    end )
end

CoD.StartMenu_GumTracker = InheritFrom( LUI.UIElement )
CoD.StartMenu_GumTracker.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_GumTracker )
	self.id = "StartMenu_GumTracker"
	self.soundSet = "Default"
	self:setLeftRight( true, false, 0, 368 )
	self:setTopBottom( true, false, 0, 149 )
	self:makeFocusable()
	self.anyChildUsesUpdateState = true
	
	self.ButtonList = LUI.UIList.new( menu, controller, 9, 0, nil, false, false, 0, 0, false, false )
	self.ButtonList:setLeftRight( true, false, 7, 363 )
	self.ButtonList:setTopBottom( true, false, 46.48, 155.48 )
	self.ButtonList:setWidgetType( CoD.StartMenu_GumList )
	self.ButtonList:setHorizontalCount( 5 )
	self.ButtonList:setSpacing( 8 )
	self.ButtonList:setDataSource( "BubbleGumBuffs" )
	self.ButtonList:makeFocusable()
	self:addElement( self.ButtonList )

	self.ResetButton = LUI.UIElement.new()
	self.ResetButton:setLeftRight( true, false, 375 - 5, 450 - 5 )
	local listCenter = 78.48
	self.ResetButton:setTopBottom( true, false, listCenter - 20, listCenter + 20 )
	self.ResetButton:makeFocusable()
	self.ResetButton:setHandleMouse( true )

	local resetBG = LUI.UIImage.new()
	resetBG:setLeftRight( true, true, 0, 0 )
	resetBG:setTopBottom( true, true, 0, 0 )
	CoD.UIColors.SetElementColor( resetBG, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	resetBG:setRGB( 0.99, 0.05, 0.12 )
	resetBG:setAlpha( 0.9 )
	resetBG:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	resetBG:setShaderVector( 0, 0.3, 0.3, 0.3, 0.3 )
	self.ResetButton:addElement( resetBG )

	local resetLabel = LUI.UIText.new()
	resetLabel:setLeftRight( true, true, 0, 0 )
	resetLabel:setTopBottom( false, false, -15, 15 )
	resetLabel:setTTF( "fonts/escom.ttf" )
	resetLabel:setText( "RESET" )
	resetLabel:setRGB( 0.16, 0.16, 0.16 )
	resetLabel:setScale( 0.85 )
	self.ResetButton:addElement( resetLabel )

	local UpdateButtonVisibility = function()
        local isVisible = not( Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
        and Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE )
        and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
        and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE ) )
        
        if isVisible then
            self.ResetButton:setAlpha( 1 )
        else
            self.ResetButton:setAlpha( 0 )
        end
    end
    local bits = { 
        Enum.UIVisibilityBit.BIT_HUD_VISIBLE, 
        Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE, 
        Enum.UIVisibilityBit.BIT_GAME_ENDED, 
        Enum.UIVisibilityBit.BIT_UI_ACTIVE 
    }
    for _, bit in ipairs( bits ) do
        self.ResetButton:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. bit ), function( model )
            UpdateButtonVisibility()
        end )
    end
    UpdateButtonVisibility()
	self:addElement( self.ResetButton )

	LUI.OverrideFunction_CallOriginalFirst( self.ButtonList, "addListItem", function ( list, widget )
	    local count = list.itemCount or 0
	    widget.myManualIndex = count + 1 
	end )

	self.ButtonList.id = "BubbleGumBuffs"

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ButtonList:close()
		element.ResetButton:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end