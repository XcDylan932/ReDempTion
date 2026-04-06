require( "ui.uieditor.menus.Social.Social_Main" )
require( "ui.uieditor.widgets.StartMenu.StartMenu_Background" )
require( "ui.uieditor.widgets.StartMenu.CP.StartMenu_CampaignBG" )
require( "ui.uieditor.widgets.Lobby.Common.FE_Menu_LeftGraphics" )
require( "ui.uieditor.widgets.BackgroundFrames.GenericMenuFrame" )
require( "ui.uieditor.widgets.playercard.SelfIdentityBadge" )
require( "ui.uieditor.widgets.Lobby.Common.FE_TabBar" )
require( "ui.uieditor.widgets.StartMenu.StartMenu_CurrencyCounts" )

require( "ui.uieditor.widgets.StartMenu.T4.T4StartMenu_GameOptions_ZM" )
require( "ui.uieditor.widgets.StartMenu.T6.T6StartMenu_GameOptions_ZM" )
require( "ui.uieditor.widgets.StartMenu.T10.T10StartMenu_GameOptions_ZM" )

DataSources.StartMenuTabs = ListHelper_SetupDataSource( "StartMenuTabs", function( controller )
	local tabList = {}

	table.insert( tabList, {
		models = { tabIcon = CoD.buttonStrings.shoulderl },
		properties = { m_mouseDisabled = true }
	} )

	if Engine.IsDemoPlaying() then
		local theaterWidget = "CoD.StartMenu_GameOptions"
		if Engine.IsZombiesGame() then
			theaterWidget = "CoD.StartMenu_GameOptions_ZM"
		end
		
		table.insert( tabList, {
			models = { tabName = Engine.Localize( "MENU_THEATER_CAPS" ), tabWidget = theaterWidget, tabIcon = "" },
			properties = { tabId = "gameOptions" }
		} )

	elseif Engine.IsInGame() then
		if IsGameTypeDOA() and not InSafehouse() then
			table.insert( tabList, {
				models = { tabName = "DOA", tabWidget = "CoD.StartMenu_GameOptions_DOA", tabIcon = "" },
				properties = { tabId = "gameOptions" }
			} )

		elseif CoD.isCampaign then
			table.insert( tabList, {
				models = { tabName = SessionModeToUnlocalizedSessionModeCaps( Engine.CurrentSessionMode() ), tabWidget = "CoD.StartMenu_GameOptions_CP", tabIcon = "" },
				properties = { tabId = "gameOptions" }
			} )

			if not Engine.IsCampaignModeZombies() then
				if CoD.isSafehouse and CoD.isOnlineGame() and not IsInTrainingSim( controller ) and Dvar.ui_safehousebarracks:get() and not IsPlayerAGuest( controller ) then
					table.insert( tabList, {
						models = { tabName = "CPUI_BARRACKS_CAPS", tabWidget = "CoD.CombatRecordCP_Contents", tabIcon = "" },
						properties = { tabId = "combatRecord" }
					} )
				end
				
				if HighestMapReachedGreaterThan( controller, 1 ) or LUI.DEV ~= nil then
					table.insert( tabList, {
						models = { tabName = "CPUI_TACTICAL_MODE_CAPS", tabWidget = "CoD.StartMenu_TacticalMode", tabIcon = "" },
						properties = { tabId = "tacticalMode" }
					} )
				end
				
				if not CoD.isSafehouse and not IsPlayerAGuest( controller ) then
					table.insert( tabList, {
						models = { tabName = "CPUI_ACCOLADES", tabWidget = "CoD.MissionRecordVault_Challenges", tabIcon = "" },
						properties = { tabId = "accolades" }
					} )
				end
			end

		elseif Engine.IsZombiesGame() then
			local controllerModel = Engine.GetModelForController( controller )
			local hudIndex = Engine.GetModelValue( Engine.CreateModel( controllerModel, "SelectedHudIndex" ) ) or 0
			local targetWidget = "CoD.StartMenu_GameOptions_ZM"

			if hudIndex == 1 then
				targetWidget = "CoD.T4StartMenu_GameOptions_ZM"
			elseif hudIndex == 2 then
				targetWidget = "CoD.T6StartMenu_GameOptions_ZM"
			elseif hudIndex == 4 then
				targetWidget = "CoD.T10StartMenu_GameOptions_ZM"
			end

			table.insert( tabList, {
				models = { tabName = SessionModeToUnlocalizedSessionModeCaps( Engine.CurrentSessionMode() ), tabWidget = targetWidget, tabIcon = "" },
				properties = { tabId = "gameOptions" }
			} )

		else
			table.insert( tabList, {
				models = { tabName = SessionModeToUnlocalizedSessionModeCaps( Engine.CurrentSessionMode() ), tabWidget = "CoD.StartMenu_GameOptions", tabIcon = "" },
				properties = { tabId = "gameOptions" }
			} )
		end

	else
		if not IsPlayerAGuest( controller ) then
			table.insert( tabList, {
				models = { tabName = "MENU_TAB_IDENTITY_CAPS", tabWidget = "CoD.StartMenu_Identity", tabIcon = "" },
				properties = { tabId = "identity", disabled = Dvar.ui_execdemo_gamescom:get() }
			} )
		end

		if not IsLobbyNetworkModeLAN() and not Dvar.ui_execdemo:get() and not Engine.IsCampaignModeZombies() and not IsPlayerAGuest( controller ) then
			table.insert( tabList, {
				models = { tabName = "MENU_TAB_CHALLENGES_CAPS", tabWidget = "CoD.StartMenu_Challenges", tabIcon = "" },
				properties = { tabId = "challenges" }
			} )

			local isModdedPC = CoD.isPC and Mods_IsUsingMods()
			table.insert( tabList, {
				models = { tabName = "MENU_TAB_BARRACKS_CAPS", tabWidget = "CoD.StartMenu_Barracks", tabIcon = "", disabled = isModdedPC },
				properties = { tabId = "barracks" }
			} )

			if CommunityOptionsEnabled() then
				local mediaTabSelection = CoD.perController[controller].openMediaTabAfterClosingGroups
				CoD.perController[controller].openMediaTabAfterClosingGroups = false
				table.insert( tabList, {
					models = { tabName = "MENU_TAB_MEDIA_CAPS", tabWidget = "CoD.StartMenu_Media", tabIcon = "" },
					properties = { tabId = "media", selectIndex = mediaTabSelection }
				} )
			end
		end
	end

	local isDOA = IsGameTypeDOA() and Engine.IsInGame() and not InSafehouse()
	local optionsWidget = isDOA and "CoD.StartMenu_Options_DOA" or "CoD.StartMenu_Options"
	local demoDvar = isDOA and Dvar.ui_execdemo:get() or Dvar.ui_execdemo_gamescom:get()
	local selectIndex = demoDvar and not Engine.IsInGame() or nil

	table.insert( tabList, {
		models = { tabName = "MENU_TAB_OPTIONS_CAPS", tabWidget = optionsWidget, tabIcon = "" },
		properties = { tabId = "options", selectIndex = selectIndex }
	} )

	table.insert( tabList, {
		models = { tabIcon = CoD.buttonStrings.shoulderr },
		properties = { m_mouseDisabled = true }
	} )

	return tabList
end, true )

local PostLoadFunc = function( self, controller )
	self:registerEventHandler( "menu_opened", function()
		return true
	end )

	self.disableLeaderChangePopupShutdown = true

	if CoD.isCampaign then
		self:setModel( Engine.CreateModel( Engine.GetModelForController( controller ), "StartMenu_Main" ) )
	end

	if CoD.isZombie then
		self.disableDarkenElement = true
	end

	self:registerEventHandler( "open_migration_menu", function( element, event )
		CloseAllOccludingMenus( element, controller )
		StartMenuResumeGame( element, event.controller )
		GoBack( element, event.controller )
	end )

	if CoD.isSafehouse and CoD.isOnlineGame() then
		SetGlobalModelValue( "combatRecordMode", "cp" )
	end

	SetControllerModelValue( controller, "forceScoreboard", 0 )

    self:subscribeToModel( Engine.GetModel( Engine.GetGlobalModel(), "fastRestart" ), function( model )
		local powerupModel = Engine.GetModel( Engine.GetModelForController( controller ), "Powerup_Selections" )
		if powerupModel then
			for i = 1, 8 do
				local slotModel = Engine.GetModel( powerupModel, "slot" .. i )
				local disabledModel = Engine.GetModel( powerupModel, "disabled" .. i )

				if slotModel and disabledModel then
					if not Engine.GetModelValue( disabledModel ) then
						Engine.SetModelValue( slotModel, false )
					end
				end
			end
		end
	end )
end

LUI.createMenu.StartMenu_Main = function( controller )
	local self = CoD.Menu.NewForUIEditor( "StartMenu_Main" )

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self.soundSet = "ChooseDecal"
	self:setOwner( controller )
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, true, 0, 0 )
	self:playSound( "menu_open", controller )
	self.buttonModel = Engine.CreateModel( Engine.GetModelForController( controller ), "StartMenu_Main.buttonPrompts" )
	self.anyChildUsesUpdateState = true
	
	self.StartMenuBackground0 = CoD.StartMenu_Background.new( self, controller )
	self.StartMenuBackground0:setLeftRight( true, true, 0, 0 )
	self.StartMenuBackground0:setTopBottom( true, true, 0, 0 )
	self.StartMenuBackground0:mergeStateConditions( {
		{
			stateName = "InGame",
			condition = function( menu, element, event )
				return IsInGame()
			end
		}
	} )
	self:addElement( self.StartMenuBackground0 )
	
	self.BlackBG = LUI.UIImage.new()
	self.BlackBG:setLeftRight( true, true, 0, 0 )
	self.BlackBG:setTopBottom( true, true, 0, 0 )
	self.BlackBG:setImage( RegisterImage( "uie_fe_cp_background" ) )
	self:addElement( self.BlackBG )
	
	self.StartMenuCampaignBG = CoD.StartMenu_CampaignBG.new( self, controller )
	self.StartMenuCampaignBG:setLeftRight( true, true, 0, 0 )
	self.StartMenuCampaignBG:setTopBottom( true, true, 0, 0 )
	self.StartMenuCampaignBG:setAlpha( 0 )
	self:addElement( self.StartMenuCampaignBG )
	
	self.MenuTitleBackground = LUI.UIImage.new()
	self.MenuTitleBackground:setLeftRight( true, true, 0, 0 )
	self.MenuTitleBackground:setTopBottom( false, false, -336, -276 )
	self.MenuTitleBackground:setRGB( 0.12, 0.13, 0.19 )
	self.MenuTitleBackground:setAlpha( 0 )
	self:addElement( self.MenuTitleBackground )
	
	self.TitleText = LUI.UIText.new()
	self.TitleText:setLeftRight( true, false, 64, 1280 )
	self.TitleText:setTopBottom( true, false, 31, 75 )
	self.TitleText:setAlpha( 0 )
	self.TitleText:setText( Engine.Localize( "Menu" ) )
	self.TitleText:setTTF( "fonts/escom.ttf" )
	self.TitleText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.TitleText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self:addElement( self.TitleText )
	
	self.ButtonBarBackground = LUI.UIImage.new()
	self.ButtonBarBackground:setLeftRight( true, true, -3.63, 0 )
	self.ButtonBarBackground:setTopBottom( false, false, 302, 332 )
	self.ButtonBarBackground:setRGB( 0.12, 0.13, 0.19 )
	self.ButtonBarBackground:setAlpha( 0 )
	self:addElement( self.ButtonBarBackground )
	
	self.FEMenuLeftGraphics = CoD.FE_Menu_LeftGraphics.new( self, controller )
	self.FEMenuLeftGraphics:setLeftRight( true, false, 19, 71 )
	self.FEMenuLeftGraphics:setTopBottom( true, false, 86, 703.25 )
	self:addElement( self.FEMenuLeftGraphics )
	
	self.TabFrame = LUI.UIFrame.new( self, controller, 0, 0, false )
	self.TabFrame:setLeftRight( false, false, -574, 576 )
	self.TabFrame:setTopBottom( false, false, -221, 299 )
	self:addElement( self.TabFrame )
	
	self.MenuFrame = CoD.GenericMenuFrame.new( self, controller )
	self.MenuFrame:setLeftRight( true, true, 0, 0 )
	self.MenuFrame:setTopBottom( true, true, 0, 0 )
	self.MenuFrame.titleLabel:setText( Engine.Localize( "MENU_MENU_CAPS" ) )
	self.MenuFrame.cac3dTitleIntermediary0.FE3dTitleContainer0.MenuTitle.TextBox1.Label0:setText( Engine.Localize( "MENU_MENU_CAPS" ) )
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
	
	self.CategoryListPanel = LUI.UIImage.new()
	self.CategoryListPanel:setLeftRight( true, true, 0, 0 )
	self.CategoryListPanel:setTopBottom( false, false, -274, -235 )
	self.CategoryListPanel:setRGB( 0, 0, 0 )
	self:addElement( self.CategoryListPanel )
	
	self.FETabBar = CoD.FE_TabBar.new( self, controller )
	self.FETabBar:setLeftRight( true, true, 0, 1217 )
	self.FETabBar:setTopBottom( true, false, 85, 126 )
	self.FETabBar.Tabs.grid:setHorizontalCount( 8 )
	self.FETabBar.Tabs.grid:setDataSource( "StartMenuTabs" )
	self:addElement( self.FETabBar )
	
	self.StartMenuCurrencyCounts = CoD.StartMenu_CurrencyCounts.new( self, controller )
	self.StartMenuCurrencyCounts:setLeftRight( false, true, -653.81, -449.81 )
	self.StartMenuCurrencyCounts:setTopBottom( true, false, 37, 67 )
	self:addElement( self.StartMenuCurrencyCounts )
	
	self.TabFrame:linkToElementModel( self.FETabBar.Tabs.grid, "tabWidget", true, function( model )
	    local tabWidget = Engine.GetModelValue( model )
	    if tabWidget then
	        self.TabFrame:changeFrameWidget( tabWidget )
	        
	        local currentWidget = self.TabFrame.framedWidget
	        if currentWidget and currentWidget.PowerupTracker and currentWidget.PowerupTracker.ButtonList then
	            
	            currentWidget.PowerupTracker.ButtonList:registerEventHandler( "list_active_changed", function( element, event )
	                local controllerModel = Engine.GetModelForController( controller )
	                local focusModel = Engine.CreateModel( controllerModel, "Powerup_Tracker_Focused_Index" )
	                
	                if element.savedActiveIndex then
	                    Engine.SetModelValue( focusModel, element.savedActiveIndex + 1 )
	                end
	            end )
	            
	            local focusModel = Engine.CreateModel( Engine.GetModelForController( controller ), "Powerup_Tracker_Focused_Index" )
	            Engine.SetModelValue( focusModel, 1 )
	        end
	    end
	end )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 4 )

				self.StartMenuBackground0:completeAnimation()
				self.StartMenuBackground0:setAlpha( 1 )
				self.clipFinished( self.StartMenuBackground0, {} )

				self.BlackBG:completeAnimation()
				self.BlackBG:setAlpha( 0.9 )
				self.clipFinished( self.BlackBG, {} )

				self.StartMenuCampaignBG:completeAnimation()
				self.StartMenuCampaignBG:setAlpha( 0 )
				self.clipFinished( self.StartMenuCampaignBG, {} )

				self.StartMenuCurrencyCounts:completeAnimation()
				self.StartMenuCurrencyCounts:setAlpha( 0 )
				self.clipFinished( self.StartMenuCurrencyCounts, {} )
			end
		},

		IsFrontEnd = {
			DefaultClip = function()
				self:setupElementClipCounter( 4 )

				self.StartMenuBackground0:completeAnimation()
				self.StartMenuBackground0:setAlpha( 1 )
				self.clipFinished( self.StartMenuBackground0, {} )

				self.BlackBG:completeAnimation()
				self.BlackBG:setAlpha( 0.9 )
				self.clipFinished( self.BlackBG, {} )

				self.StartMenuCampaignBG:completeAnimation()
				self.StartMenuCampaignBG:setAlpha( 0 )
				self.clipFinished( self.StartMenuCampaignBG, {} )

				self.StartMenuCurrencyCounts:completeAnimation()
				self.StartMenuCurrencyCounts:setAlpha( 1 )
				self.clipFinished( self.StartMenuCurrencyCounts, {} )
			end
		},

		Zombies = {
			DefaultClip = function()
				self:setupElementClipCounter( 4 )

				self.StartMenuBackground0:completeAnimation()
				self.StartMenuBackground0:setAlpha( 0.9 )
				self.clipFinished( self.StartMenuBackground0, {} )

				self.BlackBG:completeAnimation()
				self.BlackBG:setAlpha( 0.6 )
				self.clipFinished( self.BlackBG, {} )

				self.StartMenuCampaignBG:completeAnimation()
				self.StartMenuCampaignBG:setAlpha( 0 )
				self.clipFinished( self.StartMenuCampaignBG, {} )

				self.StartMenuCurrencyCounts:completeAnimation()
				self.StartMenuCurrencyCounts:setAlpha( 0 )
				self.clipFinished( self.StartMenuCurrencyCounts, {} )
			end
		},

		Campaign = {
			DefaultClip = function()
				self:setupElementClipCounter( 3 )

				self.BlackBG:completeAnimation()
				self.BlackBG:setAlpha( 0 )
				self.clipFinished( self.BlackBG, {} )

				self.StartMenuCampaignBG:completeAnimation()
				self.StartMenuCampaignBG:setAlpha( 1 )
				self.clipFinished( self.StartMenuCampaignBG, {} )

				self.StartMenuCurrencyCounts:completeAnimation()
				self.StartMenuCurrencyCounts:setAlpha( 0 )
				self.clipFinished( self.StartMenuCurrencyCounts, {} )
			end
		},

		Ingame = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )

				self.StartMenuCurrencyCounts:completeAnimation()
				self.StartMenuCurrencyCounts:setAlpha( 0 )
				self.clipFinished( self.StartMenuCurrencyCounts, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "IsFrontEnd",
			condition = function( menu, element, event )
				return InFrontend()
			end
		},
		{
			stateName = "Zombies",
			condition = function( menu, element, event )
				return IsZombies()
			end
		},
		{
			stateName = "Campaign",
			condition = function( menu, element, event )
				return IsCampaign()
			end
		},
		{
			stateName = "Ingame",
			condition = function( menu, element, event )
				return IsInGame()
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyNav" ), function( model )
		self:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "lobbyRoot.lobbyNav" } )
	end )

	self:registerEventHandler( "menu_loaded", function( menu, event )
	    local handled = nil
	    PlaySoundSetSound( self, "menu_enter" )
	    FileshareGetSlots( self, menu, controller )
	    SetHeadingKickerTextToGameMode( "" )
	    PrepareOpenMenuInSafehouse( controller )
	    if not handled then
	        handled = menu:dispatchEventToChildren( event )
	    end
	    return handled
	end )

	self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, nil, function( element, event, controller, menu )
		RefreshLobbyRoom( event, controller )
		StartMenuGoBack( event, controller )
		return true
	end, function( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK" )
		return true
	end, false )

	self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_START, "M", function( element, event, controller, menu )
		RefreshLobbyRoom( event, controller )
		StartMenuGoBack( event, controller )
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
		else
			
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
		RefreshLobbyRoom( event, controller )
		StartMenuGoBack( event, controller )
		return true
	end, function( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_NONE, "" )
		return true
	end, false, true )

	self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE, "F", function( element, menu, controller, model )
	    local controllerModel = Engine.GetModelForController( controller )
	    local focusModel = Engine.GetModel( controllerModel, "Powerup_Tracker_Focused_Index" )
	    
	    if focusModel then
	        local index = Engine.GetModelValue( focusModel )
	        
	        if index and index > 0 then
	            local disabledModel = Engine.CreateModel( controllerModel, "Powerup_Selections.disabled" .. index )
	            local slotModel = Engine.CreateModel( controllerModel, "Powerup_Selections.slot" .. index )
	            
	            local currentState = Engine.GetModelValue( disabledModel ) or false
	            local newState = not currentState
	            
	            Engine.SetModelValue( disabledModel, newState )
	            if newState == true then
	                Engine.SetModelValue( slotModel, true )
	            end
	            
	            Engine.PlaySound( "uin_bm_keyburn_done" )
	            
	            if self.TabFrame and self.TabFrame.framedWidget and self.TabFrame.framedWidget.PowerupTracker then
	                local list = self.TabFrame.framedWidget.PowerupTracker.ButtonList
	                if list and list.activeWidget then
	                    list.activeWidget:processEvent( { name = "button_action", controller = controller, internalCall = true } )
	                end
	            end
	            return true
	        end
	    end
	end, function( element, menu, controller )
	    if self.TabFrame and self.TabFrame.framedWidget then
	        local widget = self.TabFrame.framedWidget
	        if widget.PowerupTracker ~= nil and widget.PowerupTracker.ButtonList ~= nil then
	            CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE, "^1Disable Powerup" )
	            return true
	        end
	    end
	    return false
	end, false )

	self.TabFrame.id = "TabFrame"
	self.MenuFrame:setModel( self.buttonModel, controller )

	self:processEvent( { name = "menu_loaded", controller = controller } )
	self:processEvent( { name = "update_state", menu = self } )
	if not self:restoreState() then
		self.TabFrame:processEvent( { name = "gain_focus", controller = controller } )
	end

	LUI.OverrideFunction_CallOriginalFirst( self, "close", function( element )
	    local function GetVal( key )
	    	return CoD.PCUtil and CoD.PCUtil.GlobalSettings and CoD.PCUtil.GlobalSettings[key] or ""
	    end

	    local boxOrder = "MagicboxOrder|"
	    for i = 1, 5 do
	        boxOrder = boxOrder .. GetVal( "GameSettings_MagicboxSlot" .. i ) .. ( i < 5 and "," or "" )
	    end
	    
	    local perkOrder = "PerkOrder|"
	    for i = 1, 5 do
	        perkOrder = perkOrder .. GetVal( "GameSettings_PerkSlot" .. i ) .. ( i < 5 and "," or "" )
	    end

	    Engine.SendMenuResponse( 0, "GameSettings", "MagicboxPatch|" .. tostring( GetVal( "GameSettings_MagicboxPatch" ) ) )
	    Engine.SendMenuResponse( 0, "GameSettings", "PerkPatch|" .. tostring( GetVal( "GameSettings_PerkPatch" ) ) )
	   	Engine.SendMenuResponse( 0, "GameSettings", boxOrder )
	    Engine.SendMenuResponse( 0, "GameSettings", perkOrder )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.StartMenuBackground0:close()
		element.StartMenuCampaignBG:close()
		element.FEMenuLeftGraphics:close()
		element.MenuFrame:close()
		element.SelfIdentityBadge:close()
		element.FETabBar:close()
		element.StartMenuCurrencyCounts:close()
		element.TabFrame:close()
		Engine.UnsubscribeAndFreeModel( Engine.GetModel( Engine.GetModelForController( controller ), "StartMenu_Main.buttonPrompts" ) )
	end )

	if PostLoadFunc then
		PostLoadFunc( self, controller )
	end
	
	return self
end