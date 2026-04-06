require( "ui.uieditor.widgets.BackgroundFrames.GenericMenuFrame" )
require( "ui.uieditor.widgets.Lobby.Common.FE_Menu_LeftGraphics" )
require( "ui.uieditor.widgets.Lobby.Common.FE_TabBar" )
require( "ui.uieditor.widgets.playercard.SelfIdentityBadge" )

require( "ui.uieditor.widgets.StartMenu.CamoTab.StartMenu_CamoOptions" )
require( "ui.uieditor.widgets.StartMenu.CharacterTab.StartMenu_CharacterOptions" )
require( "ui.uieditor.widgets.StartMenu.HudTab.StartMenu_HudOptions" )
require( "ui.uieditor.widgets.StartMenu.PerkTab.StartMenu_PerkOptions" )
require( "ui.uieditor.widgets.StartMenu.SettingsTab.StartMenu_GameSettings" )

local UpdateAndGetWidth = function( element, text )
    element:setText( text )
    return element:getTextWidth()
end

local RefreshEquippedText = function( self, controller )
    local tabName = self.currentActiveTab
    local controllerModel = Engine.GetModelForController( controller )
    local startX = 64
    local currentX = startX
    local padding = 2 
    local color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]

    self.descLabel:setText("")
    self.descValue:setText("")
    self.descLabel2:setText("")
    self.descValue2:setText("")
    
    self.descLabel:setAlpha(0)
    self.descValue:setAlpha(0)
    self.descLabel2:setAlpha(0)
    self.descValue2:setAlpha(0)

    if not tabName or tabName == "Settings" then
    	return
    end

    if tabName == "Icons" then
        local perkVal = Engine.Localize( Engine.GetModelValue( Engine.CreateModel( controllerModel, "SelectedPerkIcons" ) ) or "None" )
        local powerupVal = Engine.Localize( Engine.GetModelValue( Engine.CreateModel( controllerModel, "SelectedPowerupIcons" ) ) or "None" )

        local w1 = UpdateAndGetWidth( self.descLabel, "Perks: " )
        self.descLabel:setLeftRight( true, false, currentX, currentX + w1 )
        self.descLabel:setAlpha(1)
        currentX = currentX + w1 + padding

        local w2 = UpdateAndGetWidth( self.descValue, perkVal )
        self.descValue:setLeftRight( true, false, currentX, currentX + w2 )
        CoD.UIColors.SetElementColor( self.descValue, color )
        currentX = currentX + w2 + padding

        local w3 = UpdateAndGetWidth( self.descLabel2, " | Powerups: " )
        self.descLabel2:setLeftRight( true, false, currentX, currentX + w3 )
        self.descLabel2:setAlpha(1)
        currentX = currentX + w3 + padding

        local w4 = UpdateAndGetWidth( self.descValue2, powerupVal )
        self.descValue2:setLeftRight( true, false, currentX, currentX + w4 )
        CoD.UIColors.SetElementColor( self.descValue2, color )
    else
        local targetModel = Engine.GetModel( controllerModel, "Selected" .. tabName )
        if targetModel then
            local modelValue = Engine.Localize( Engine.GetModelValue( targetModel ) or "None" )
            if modelValue ~= "" then
                local w1 = UpdateAndGetWidth( self.descLabel, "Equipped: " )
                self.descLabel:setLeftRight( true, false, currentX, currentX + w1 )
                self.descLabel:setAlpha(1)
                currentX = currentX + w1 + padding

                local w2 = UpdateAndGetWidth( self.descValue, modelValue )
                self.descValue:setLeftRight( true, false, currentX, currentX + w2 )
                CoD.UIColors.SetElementColor( self.descValue, color )
            end
        end
    end

    if self.playClip then
        self:playClip( "UpdateText" )
    end
end

local PostLoadFunc = function( self, controller )
	self:registerEventHandler( "menu_opened", function()
		return true
	end )
	self.disableLeaderChangePopupShutdown = true
	self.disableDarkenElement = true
	self.disablePopupOpenCloseAnim = true
	SetControllerModelValue( controller, "forceScoreboard", 0 )

	self.TabFrame:linkToElementModel( self.FETabBar.Tabs.grid, "tabWidget", true, function( model )
		local modelValue = Engine.GetModelValue( model )
		if modelValue then
			self.TabFrame:changeFrameWidget( modelValue )
		end
	end )

	self.MenuFrame:linkToElementModel( self.FETabBar.Tabs.grid, "tabName", true, function( model )
        local tabName = Engine.GetModelValue( model )
        if tabName then
            self.MenuFrame.titleLabel:setText( string.upper( tabName ) )
            self.MenuFrame.cac3dTitleIntermediary0.FE3dTitleContainer0.MenuTitle.TextBox1.Label0:setText( string.upper( tabName ) )
        else
            self.MenuFrame.titleLabel:setText( "" )
            self.MenuFrame.cac3dTitleIntermediary0.FE3dTitleContainer0.MenuTitle.TextBox1.Label0:setText( "" )
        end
    end )

    self:linkToElementModel( self.FETabBar.Tabs.grid, nil, false, function( model )
	    local tabNameModel = Engine.GetModel( model, "tabName" )
	    if tabNameModel then
	        local tabName = Engine.GetModelValue( tabNameModel )
	        self.currentActiveTab = tabName 
	        RefreshEquippedText( self, controller )
	    end
	end )

	local controllerModel = Engine.GetModelForController( controller )

    local modelsToWatch = { "SelectedCamo", "SelectedCharacter", "SelectedPerkIcons", "SelectedPowerupIcons", "SelectedHUD" }
    for _, modelName in ipairs( modelsToWatch ) do
        self:subscribeToModel( Engine.CreateModel( controllerModel, modelName ), function( model )
            RefreshEquippedText( self, controller )
        end, false )
    end
end

DataSources.ModSettingsTabs = ListHelper_SetupDataSource( "ModSettingsTabs", function( controller )
	local tabList = {}

	table.insert( tabList, {
		models = { tabIcon = CoD.buttonStrings.shoulderl },
		properties = { m_mouseDisabled = true }
	} )

	table.insert( tabList, {
		models = { tabName = "Settings", tabWidget = "CoD.StartMenu_GameSettings" },
		properties = { tabId = "gameOptions" }
	} )

	table.insert( tabList, {
		models = { tabName = "Camo", tabWidget = "CoD.StartMenu_CamoOptions" },
		properties = { tabId = "gameOptions" }
	} )

	table.insert( tabList, {
		models = { tabName = "Character", tabWidget = "CoD.StartMenu_CharacterOptions" },
		properties = { tabId = "gameOptions" }
	} )

	table.insert( tabList, {
		models = { tabName = "Icons", tabWidget = "CoD.StartMenu_PerkOptions" },
		properties = { tabId = "gameOptions" }
	} )

	table.insert( tabList, {
		models = { tabName = "HUD", tabWidget = "CoD.StartMenu_HudOptions" },
		properties = { tabId = "gameOptions" }
	} )

	table.insert( tabList, {
		models = { tabIcon = CoD.buttonStrings.shoulderr },
		properties = { m_mouseDisabled = true }
	} )

	return tabList
end, true )

LUI.createMenu.StartMenu_ModSettings_Main = function( controller )
	local self = CoD.Menu.NewForUIEditor( "StartMenu_ModSettings_Main" )

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self.soundSet = "ChooseDecal"
	self:setOwner( controller )
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, true, 0, 0 )
	self:playSound( "menu_open", controller )
	self.buttonModel = Engine.CreateModel( Engine.GetModelForController( controller ), "StartMenu_ModSettings_Main.buttonPrompts" )
	self.anyChildUsesUpdateState = true

	self.Background = CoD.StartMenu_Background.new( self, controller )
	self.Background:setLeftRight( true, true, 0, 0 )
	self.Background:setTopBottom( true, true, 0, 0 )
	self.Background:mergeStateConditions( {
		{
			stateName = "InGame",
			condition = function( menu, element, event )
				return IsInGame()
			end
		}
	} )
	self:addElement( self.Background )

	self.BlackBG = LUI.UIImage.new()
	self.BlackBG:setLeftRight( true, true, 0, 0 )
	self.BlackBG:setTopBottom( true, true, 0, 0 )
	self.BlackBG:setAlpha( 0.6 )
	self.BlackBG:setImage( RegisterImage( "uie_fe_cp_background" ) )
	self:addElement( self.BlackBG )

	self.FEMenuLeftGraphics = CoD.FE_Menu_LeftGraphics.new( self, controller )
	self.FEMenuLeftGraphics:setLeftRight( true, false, 19, 71 )
	self.FEMenuLeftGraphics:setTopBottom( true, false, 86, 703.25 )
	self:addElement( self.FEMenuLeftGraphics )

	self.TabFrame = LUI.UIFrame.new( self, controller, 0, 0, false )
	self.TabFrame:setLeftRight( false, false, -575, 575 )
	self.TabFrame:setTopBottom( false, false, -221, 299 )
	self:addElement( self.TabFrame )

	self.CategoryListPanel = LUI.UIImage.new()
	self.CategoryListPanel:setLeftRight( false, false, -640, 640 )
	self.CategoryListPanel:setTopBottom( false, false, -276, -237 )
	self.CategoryListPanel:setRGB( 0, 0, 0 )
	self:addElement( self.CategoryListPanel )

	self.MenuFrame = CoD.GenericMenuFrame.new( self, controller )
	self.MenuFrame:setLeftRight( true, true, 0, 0 )
	self.MenuFrame:setTopBottom( true, true, 0, 0 )
	self:addElement( self.MenuFrame )

	self.SelfIdentityBadge = CoD.SelfIdentityBadge.new( self, controller )
	self.SelfIdentityBadge:setLeftRight( false, true, -435, -92 )
	self.SelfIdentityBadge:setTopBottom( true, false, 24, 84 )
	self.SelfIdentityBadge:subscribeToGlobalModel( controller, "PerController", "identityBadge", function( model )
		self.SelfIdentityBadge:setModel( model, controller )
	end )
	self.SelfIdentityBadge:subscribeToGlobalModel( controller, "PerController", nil, function( model )
		self.SelfIdentityBadge.CallingCard.CallingCardsFrameWidget:setModel( model, controller )
	end )
	self:addElement( self.SelfIdentityBadge )

	self.FETabBar = CoD.FE_TabBar.new( self, controller )
	self.FETabBar:setLeftRight( true, true, 0, 1217 )
	self.FETabBar:setTopBottom( true, false, 85, 126 )
	self.FETabBar.Tabs.grid:setHorizontalCount( 8 )
	self.FETabBar.Tabs.grid:setDataSource( "ModSettingsTabs" )
	self:addElement( self.FETabBar )

    self.descLabel = LUI.UIText.new()
    self.descLabel:setTopBottom( true, false, 72.5, 84.5 )
    self.descLabel:setTTF( "fonts/default.TTF" )
    self:addElement( self.descLabel )

    self.descValue = LUI.UIText.new()
    self.descValue:setTopBottom( true, false, 72.5, 84.5 )
    self.descValue:setTTF( "fonts/default.TTF" )
    CoD.UIColors.SetElementColor( self.descValue, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    self:addElement( self.descValue )

    self.descLabel2 = LUI.UIText.new()
    self.descLabel2:setTopBottom( true, false, 72.5, 84.5 )
    self.descLabel2:setTTF( "fonts/default.TTF" )
    self:addElement( self.descLabel2 )

    self.descValue2 = LUI.UIText.new()
    self.descValue2:setTopBottom( true, false, 72.5, 84.5 )
    self.descValue2:setTTF( "fonts/default.TTF" )
    CoD.UIColors.SetElementColor( self.descValue2, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    self:addElement( self.descValue2 )

	self.clipsPerState = {
	    DefaultState = {
	        DefaultClip = function()
	            self:setupElementClipCounter( 0 )
	        end,
	        
	        UpdateText = function()
			    self:setupElementClipCounter( 2 )
			    
			    local valueElements = { self.descValue, self.descValue2 }
			    for _, element in ipairs( valueElements ) do
			        element:completeAnimation()
			        element:setAlpha(0) 
			        
			        local currentText = element:getText()
			        if currentText and currentText ~= "" then
			            element:beginAnimation( "fade_in", 200 ) 
			            element:setAlpha(1)
			        else
			            element:setAlpha(0)
			        end
			    end
			    self.clipFinished( self.descValue, {} )
			end
	    }
	}

	self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, nil, function( element, event, controller, menu )
	    GoBack( event, controller )
	    return true
	end, function( element, menu, controller )
	    CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK" )
	    return true
	end, false )

	self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_START, "M", function( element, event, controller, menu )
	    GoBack( event, controller )
	    return true
	end, function( element, menu, controller )
	    CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_START, "MENU_DISMISS_MENU" )
	    return true
	end, false )

	self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, nil, function( element, event, controller, menu )
	    PlaySoundSetSound( self, "list_action" )
	    return true
	end, function( element, menu, controller )
	    CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT" )
	    return true
	end, false )

	self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE, "S", function( element, event, controller, menu )
	    if IsInGame() and not IsLobbyNetworkModeLAN() and not IsDemoPlaying() then
	        OpenPopup( self, "Social_Main", controller, "", "" )
	        return true
	    end
	end, function( element, menu, controller )
	    if IsInGame() and not IsLobbyNetworkModeLAN() and not IsDemoPlaying() then
	        CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE, "MENU_SOCIAL" )
	        return true
	    else
	        return false
	    end
	end, false )

	self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_NONE, "ESCAPE", function( element, event, controller, menu )
	    GoBack( event, controller )
	    return true
	end, function( element, menu, controller )
	    CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_NONE, "" )
	    return true
	end, false, true )

	self.TabFrame.id = "TabFrame"

	self.MenuFrame:setModel( self.buttonModel, controller )

	self:processEvent( { name = "menu_loaded", controller = controller } )
	self:processEvent( { name = "update_state", menu = self } )

	if not self:restoreState() then
		self.TabFrame:processEvent( { name = "gain_focus", controller = controller } )
	end

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.Background:close()
		element.BlackBG:close()
		element.FEMenuLeftGraphics:close()
		element.TabFrame:close()
		element.CategoryListPanel:close()
		element.MenuFrame:close()
		element.SelfIdentityBadge:close()
		element.FETabBar:close()
		Engine.UnsubscribeAndFreeModel( Engine.GetModel( Engine.GetModelForController( controller ), "StartMenu_ModSettings_Main.buttonPrompts" ) )
	end )

	if PostLoadFunc then
		PostLoadFunc( self, controller )
	end
	
	return self
end