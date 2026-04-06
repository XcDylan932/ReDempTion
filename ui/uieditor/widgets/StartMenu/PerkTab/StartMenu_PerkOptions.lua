require( "ui.uieditor.widgets.Scrollbars.verticalCounter" )
require( "ui.uieditor.widgets.StartMenu.PerkTab.StartMenu_PerkOptions_ListItem" )
require( "ui.uieditor.widgets.StartMenu.PerkTab.StartMenu_PowerupOptions_ListItem" )

CoD.PerkIconsTable = {
    { models = { name = "Black Ops III", perksIndex = 1 } },
    { models = { name = "Shadows of Evil", perksIndex = 2 } },
    { models = { name = "Black Ops", perksIndex = 3 } },
    { models = { name = "Black Ops II", perksIndex = 4 } },
    { models = { name = "Black Ops IV", perksIndex = 5 } },
    { models = { name = "Black Ops VI", perksIndex = 6 } },
}

CoD.PowerupIconsTable = {
	{ models = { name = "Black Ops III", powerupsIndex = 1 } },
	{ models = { name = "Shadows of Evil", powerupsIndex = 2 } },
	{ models = { name = "Black Ops", powerupsIndex = 3 } },
	{ models = { name = "Black Ops II", powerupsIndex = 4 } },
	{ models = { name = "Black Ops IV", powerupsIndex = 5 } },
	{ models = { name = "Black Ops VI", powerupsIndex = 6 } },
}

DataSources.StartMenu_PerkOptions = ListHelper_SetupDataSource( "StartMenu_PerkOptions", function( controller )
    local perkOptions = {}
    
    local controllerModel = Engine.GetModelForController( controller )
    local perksIndexModel = Engine.GetModel( controllerModel, "SelectedPerksIndex" )
    local selectedPerksModel = Engine.GetModel( controllerModel, "SelectedPerkIcons" )
    local activeIndex = Engine.GetModelValue( perksIndexModel ) or 0

    if CoD.PerkIconsTable ~= nil then
        for i = 1, #CoD.PerkIconsTable do
            local perksEntry = CoD.PerkIconsTable[i]

            if perksEntry.models then
                perksEntry.models.current = ( perksEntry.models.perksIndex == activeIndex )
                perksEntry.models.action = function( element, event, controller, menu, actionParam )
				    Engine.SetModelValue( perksIndexModel, perksEntry.models.perksIndex )
				    Engine.SetModelValue( selectedPerksModel, perksEntry.models.name )
				    PlaySoundSetSound( element, "menu_enter" )
				end

                table.insert( perkOptions, perksEntry )
            end
        end
    end

    return perkOptions
end, true )

DataSources.StartMenu_PowerupOptions = ListHelper_SetupDataSource( "StartMenu_PowerupOptions", function( controller )
    local powerupOptions = {}
    
    local controllerModel = Engine.GetModelForController( controller )
    local powerupsIndexModel = Engine.GetModel( controllerModel, "SelectedPowerupsIndex" )
    local selectedPowerupsModel = Engine.GetModel( controllerModel, "SelectedPowerupIcons" )
    local activeIndex = Engine.GetModelValue( powerupsIndexModel ) or 0

    if CoD.PowerupIconsTable ~= nil then
        for i = 1, #CoD.PowerupIconsTable do
            local powerupsEntry = CoD.PowerupIconsTable[i]

            if powerupsEntry.models then
                powerupsEntry.models.current = ( powerupsEntry.models.powerupsIndex == activeIndex )
                powerupsEntry.models.action = function( element, event, controller, menu, actionParam )
				    Engine.SetModelValue( powerupsIndexModel, powerupsEntry.models.powerupsIndex )
				    Engine.SetModelValue( selectedPowerupsModel, powerupsEntry.models.name )
				    PlaySoundSetSound( element, "menu_enter" )
				end

                table.insert( powerupOptions, powerupsEntry )
            end
        end
    end

    return powerupOptions
end, true )

local SetPerksModels = function( self, controller )
	local controllerModel = Engine.GetModelForController( controller )
	local perksIndexModel = Engine.CreateModel( controllerModel, "SelectedPerksIndex" )
	local selectedPerksModel = Engine.CreateModel( controllerModel, "SelectedPerkIcons" )

	if Engine.GetModelValue( perksIndexModel ) == nil then
        Engine.SetModelValue( perksIndexModel, 0 )
        Engine.SetModelValue( selectedPerksModel, "Default" )
    end
end

local SetPowerupModels = function( self, controller )
	local controllerModel = Engine.GetModelForController( controller )
	local powerupsIndexModel = Engine.CreateModel( controllerModel, "SelectedPowerupsIndex" )
	local selectedPowerupsModel = Engine.CreateModel( controllerModel, "SelectedPowerupIcons" )

	if Engine.GetModelValue( powerupsIndexModel ) == nil then
		Engine.SetModelValue( powerupsIndexModel, 0 )
		Engine.SetModelValue( selectedPowerupsModel, "Default" )
	end
end

local PreLoadFunc = function( self, controller )
	SetPerksModels( self, controller )
	SetPowerupModels( self, controller )
end

local PostLoadFunc = function( self, controller )
	self:subscribeToModel( Engine.GetModel( Engine.GetGlobalModel(), "fastRestart" ), function( model )
		SetPerksModels( self, controller )
		SetPowerupModels( self, controller )
	end )
end

CoD.StartMenu_PerkOptions = InheritFrom( LUI.UIElement )
CoD.StartMenu_PerkOptions.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_PerkOptions )
	self.id = "StartMenu_PerkOptions"
	self.soundSet = "ChooseDecal"
	self:setLeftRight( true, false, 0, 1150 )
	self:setTopBottom( true, false, 0, 520 )
	self:makeFocusable()
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

	self.buttonList = LUI.UIList.new( menu, controller, 8, 0, nil, true, false, 0, 0, false, false )
	self.buttonList:makeFocusable()
	self.buttonList:setLeftRight( false, false, 0 - 200, 0 - 200 )
	self.buttonList:setTopBottom( true, false, 10, 0 )
	self.buttonList:setWidgetType( CoD.StartMenu_PerkOptions_ListItem )
	self.buttonList:setHorizontalCount( 1 )
	self.buttonList:setVerticalCount( 5 )
	self.buttonList:setSpacing( 3 )
	self.buttonList:setVerticalCounter( CoD.verticalCounter )
	self.buttonList:registerEventHandler( "gain_focus", function( element, event )
		local retval = nil
		if element.gainFocus then
			retval = element:gainFocus( event )
		elseif element.super.gainFocus then
			retval = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS )
		return retval
	end )
	self.buttonList:registerEventHandler( "lose_focus", function( element, event )
		local retval = nil
		if element.loseFocus then
			retval = element:loseFocus( event )
		elseif element.super.loseFocus then
			retval = element.super:loseFocus( event )
		end
		return retval
	end )
	menu:AddButtonCallbackFunction( self.buttonList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function( element, event, controller, model )
		ProcessListAction( self, element, controller )
		return true
	end, function( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT" )
		return true
	end, false )
	self.buttonList:setDataSource( "StartMenu_PerkOptions" )
	self:addElement( self.buttonList )

	self.buttonList2 = LUI.UIList.new( menu, controller, 8, 0, nil, true, false, 0, 0, false, false )
	self.buttonList2:makeFocusable()
	self.buttonList2:setLeftRight( false, false, 0 + 200, 0 + 200 )
	self.buttonList2:setTopBottom( true, false, 10, 0 )
	self.buttonList2:setWidgetType( CoD.StartMenu_PowerupOptions_ListItem )
	self.buttonList2:setHorizontalCount( 1 )
	self.buttonList2:setVerticalCount( 5 )
	self.buttonList2:setSpacing( 3 )
	self.buttonList2:setVerticalCounter( CoD.verticalCounter )
	self.buttonList2:registerEventHandler( "gain_focus", function( element, event )
		local retval = nil
		if element.gainFocus then
			retval = element:gainFocus( event )
		elseif element.super.gainFocus then
			retval = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS )
		return retval
	end )
	self.buttonList2:registerEventHandler( "lose_focus", function( element, event )
		local retval = nil
		if element.loseFocus then
			retval = element:loseFocus( event )
		elseif element.super.loseFocus then
			retval = element.super:loseFocus( event )
		end
		return retval
	end )
	menu:AddButtonCallbackFunction( self.buttonList2, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function( element, event, controller, model )
		ProcessListAction( self, element, controller )
		return true
	end, function( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT" )
		return true
	end, false )
	self.buttonList2:setDataSource( "StartMenu_PowerupOptions" )
	self:addElement( self.buttonList2 )

	self.buttonList.id = "buttonList"
	self.buttonList2.id = "buttonList2"

	self:registerEventHandler( "gain_focus", function( element, event )
		if element.m_focusable and element.buttonList:processEvent( event ) then
			return true
		else
			return LUI.UIElement.gainFocus( element, event )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.buttonList:close()
		element.buttonList2:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end