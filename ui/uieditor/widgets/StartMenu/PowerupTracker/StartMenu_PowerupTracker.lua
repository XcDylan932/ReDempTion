require( "ui.uieditor.widgets.StartMenu.PowerupTracker.StartMenu_PowerupTracker_ListItem" )

local PowerUpList = {
    { name = "doublepoints", 	image = "ui_icon_powerup_tracker_doublepoints" },
    { name = "instakill",    	image = "ui_icon_powerup_tracker_instakill" },
    { name = "fullammo",      	image = "ui_icon_powerup_tracker_fullammo" },
    { name = "nuke",			image = "ui_icon_powerup_tracker_nuke" },
    { name = "deathmachine",  	image = "ui_icon_powerup_tracker_deathmachine" },
    { name = "firesale",     	image = "ui_icon_powerup_tracker_firesale" },
    { name = "carpenter",     	image = "ui_icon_powerup_tracker_carpenter" },
    { name = "blood",  			image = "ui_icon_powerup_tracker_blood" },
}

DataSources.PowerupList = DataSourceHelpers.ListSetup( "PowerupList", function ( controller )
    local tabList = {}

    for _, data in ipairs( PowerUpList ) do
        table.insert( tabList, { models = { name = data.name, image = data.image, } } )
    end
    return tabList
end, true )

local ResetPowerupModels = function( self, controller, menu, restart )
    local controllerModel = Engine.GetModelForController( controller )
    local powerupModel = Engine.GetModel( controllerModel, "Powerup_Selections" )

    if powerupModel then
        for i = 1, #PowerUpList do
            local slot = Engine.GetModel( powerupModel, "slot" .. i )
            local disabled = Engine.GetModel( powerupModel, "disabled" .. i )
            
            if slot and disabled then
                local isDisabled = Engine.GetModelValue( disabled ) or false
                
                if not restart or not isDisabled then
                    Engine.SetModelValue( slot, false )
                end

                if not restart then
                    Engine.SetModelValue( disabled, false )
                end
            end
        end

        if not restart then
            Engine.PlaySound( "uin_bm_cycle_item_hit" )
        end

        if self.ButtonList then
        	self.ButtonList:updateDataSource()
            self.ButtonList:dispatchEventToChildren( { name = "update_state", menu = menu } )
        end
    end
end

local PreLoadFunc = function( self, controller )
    local controllerModel = Engine.GetModelForController( controller )
    local powerupSelection = Engine.CreateModel( controllerModel, "Powerup_Selections" )

	for i = 1, #PowerUpList do
	    local slot = Engine.CreateModel( powerupSelection, "slot" .. i )
	    local disabled = Engine.CreateModel( powerupSelection, "disabled" .. i )
	    
	    if Engine.GetModelValue( slot ) == nil then
	    	Engine.SetModelValue( slot, false )
	    end
	    if Engine.GetModelValue( disabled ) == nil then
	    	Engine.SetModelValue( disabled, false )
	    end
	end
end

local PostLoadFunc = function( self, controller, menu )
	self.ResetButton:registerEventHandler( "button_action", function( element, event )
		ResetPowerupModels( self, controller, menu, false )
		return true
	end )
end

CoD.StartMenu_PowerupTracker = InheritFrom( LUI.UIElement )
CoD.StartMenu_PowerupTracker.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_PowerupTracker )
	self.id = "StartMenu_PowerupTracker"
	self.soundSet = "Default"
	self:setLeftRight( true, false, 0, 368 + 200 )
	self:setTopBottom( true, false, 0, 149 )
	self:makeFocusable()
	self.anyChildUsesUpdateState = true
	
	self.ButtonList = LUI.UIList.new( menu, controller, 9, 0, nil, false, false, 0, 0, false, false )
	self.ButtonList:setLeftRight( true, false, 7, 363 + 200 )
	self.ButtonList:setTopBottom( true, false, 46.48, 155.48 )
	self.ButtonList:setWidgetType( CoD.StartMenu_PowerupList )
	self.ButtonList:setHorizontalCount( 8 )
	self.ButtonList:setSpacing( 8 )
	self.ButtonList:setDataSource( "PowerupList" )
	self:addElement( self.ButtonList )

	self.ResetButton = LUI.UIElement.new()
	self.ResetButton:setLeftRight( true, false, 575 + 10, 650 + 10 )
	local listCenter = 78.48
	self.ResetButton:setTopBottom( true, false, listCenter - 20, listCenter + 20 )
	self.ResetButton:makeFocusable()
	self.ResetButton:setHandleMouse( true )

	local resetBG = LUI.UIImage.new()
	resetBG:setLeftRight( true, true, 0, 0 )
	resetBG:setTopBottom( true, true, 0, 0 )
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
	self:addElement( self.ResetButton )

	menu:AddButtonCallbackFunction( self.ButtonList, controller, Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE, "F", function( element, event, controller, model )
		self.ButtonList:processEvent( { name = "button_action_secondary", controller = controller } )
		ProcessListAction( self, element, controller )
		return true
	end, function( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE, "^1Disable Powerup" )
		return true
	end, false )

	LUI.OverrideFunction_CallOriginalFirst( self.ButtonList, "addListItem", function ( list, widget )
	    local count = list.itemCount or 0
	    widget.myManualIndex = count + 1 
	end )

	self.ButtonList.id = "PowerupList"
	self.ButtonList:makeFocusable()

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ButtonList:close()
		element.ResetButton:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end