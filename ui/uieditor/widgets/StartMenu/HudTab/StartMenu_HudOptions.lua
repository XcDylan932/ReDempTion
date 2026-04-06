require( "ui.uieditor.widgets.Scrollbars.verticalCounter" )
require( "ui.uieditor.widgets.StartMenu.HudTab.StartMenu_HudOptions_ListItem" )

CoD.HudTable = {
	{ models = { image = "t7hud_factory_preview", name = "Black Ops III", HudIndex = 0 } },
	{ models = { image = "t7hud_preview", name = "Shadows of Evil", HudIndex = 5 } },
	{ models = { image = "t4hud_preview", name = "World at War", HudIndex = 1 } },
	{ models = { image = "t6hud_preview", name = "Black Ops II", HudIndex = 2 } },
	{ models = { image = "t8hud_preview", name = "Black Ops IV", HudIndex = 3 } },
	{ models = { image = "t10hud_preview", name = "Black Ops 6", HudIndex = 4 } }
}

DataSources.StartMenu_HudOptions = ListHelper_SetupDataSource( "StartMenu_HudOptions", function( controller )
    local HudOptions = {}
    
    local controllerModel = Engine.GetModelForController( controller )
    local HudIndexModel = Engine.GetModel( controllerModel, "SelectedHudIndex" )
    local selectedHudModel = Engine.GetModel( controllerModel, "SelectedHud" )
    local activeIndex = Engine.GetModelValue( HudIndexModel ) or 0

    if CoD.HudTable ~= nil then
        for i = 1, #CoD.HudTable do
            local HudEntry = CoD.HudTable[i]

            if HudEntry.models then
                HudEntry.models.current = ( HudEntry.models.HudIndex == activeIndex )
                HudEntry.models.action = function( element, event, controller, menu, actionParam )
				    Engine.SetModelValue( HudIndexModel, HudEntry.models.HudIndex )
				    Engine.SetModelValue( selectedHudModel, HudEntry.models.name )
				    PlaySoundSetSound( element, "menu_enter" )
				end

                table.insert( HudOptions, HudEntry )
            end
        end
    end

    return HudOptions
end, true )

local SetHudModels = function( self, controller )
	local controllerModel = Engine.GetModelForController( controller )
	local HudIndexModel = Engine.CreateModel( controllerModel, "SelectedHudIndex" )
	local selectedHudModel = Engine.CreateModel( controllerModel, "SelectedHud" )

	if Engine.GetModelValue( HudIndexModel ) == nil then
        Engine.SetModelValue( HudIndexModel, 0 )
        Engine.SetModelValue( selectedHudModel, "Black Ops III" )
    end
end

local PreLoadFunc = function( self, controller )
	SetHudModels( self, controller )
end

local PostLoadFunc = function( self, controller )
	self:subscribeToModel( Engine.GetModel( Engine.GetGlobalModel(), "fastRestart" ), function( model )
		SetHudModels( self, controller )
	end )
end

CoD.StartMenu_HudOptions = InheritFrom( LUI.UIElement )
CoD.StartMenu_HudOptions.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_HudOptions )
	self.id = "StartMenu_HudOptions"
	self.soundSet = "ChooseDecal"
	self:setLeftRight( true, false, 0, 1150 )
	self:setTopBottom( true, false, 0, 520 )
	self:makeFocusable()
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

	self.buttonList = LUI.UIList.new( menu, controller, 8, 0, nil, true, false, 0, 0, false, false )
	self.buttonList:makeFocusable()
	self.buttonList:setLeftRight( true, false, 150, 460 )
	self.buttonList:setTopBottom( true, false, 10, 420 )
	self.buttonList:setWidgetType( CoD.StartMenu_HudOptions_ListItem )
	self.buttonList:setHorizontalCount( 2 )
	self.buttonList:setVerticalCount( 2 )
	self.buttonList:setSpacing( 20 )
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
	self.buttonList:setDataSource( "StartMenu_HudOptions" )
	self:addElement( self.buttonList )

	self.buttonList.id = "buttonList"

	self:registerEventHandler( "gain_focus", function( element, event )
		if element.m_focusable and element.buttonList:processEvent( event ) then
			return true
		else
			return LUI.UIElement.gainFocus( element, event )
		end
	end )

	LUI.OverrideFunction_CallOriginalFirst( self, "close", function( element )
        local controllerModel = Engine.GetModelForController( controller )
        local finalHudIndex = Engine.GetModelValue( Engine.GetModel( controllerModel, "SelectedHudIndex" ) )

        if finalHudIndex ~= nil then
            Engine.SendMenuResponse( controller, "StartMenu_HudOptions", finalHudIndex )
        end
    end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.buttonList:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end