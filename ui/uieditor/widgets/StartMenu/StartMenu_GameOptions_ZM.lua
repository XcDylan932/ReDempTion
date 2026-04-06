require( "ui.uieditor.menus.StartMenu.StartMenu_ModSettings_Main" )
require( "ui.uieditor.widgets.Lobby.Common.List1ButtonLarge_PH" )
require( "ui.uieditor.widgets.StartMenu.GumTracker.StartMenu_GumTracker" )
require( "ui.uieditor.widgets.StartMenu.PowerupTracker.StartMenu_PowerupTracker" )
require( "ui.uieditor.widgets.Utilities.ProgressBar_Rank" )
require( "ui.uieditor.widgets.ZMPromotional.ZM_PromoIconList" )

DataSources.ModStartMenuGameOptions = ListHelper_SetupDataSource( "ModStartMenuGameOptions", function( controller )
	local menuOptions = {}

	if Engine.IsDemoPlaying() then
		local demoSegmentCount = Engine.GetDemoSegmentCount()
		local isHighlightReelMode = Engine.IsDemoHighlightReelMode()
		local isClipPlaying = Engine.IsDemoClipPlaying()

		if not IsDemoRestrictedBasicMode() then
			table.insert( menuOptions, {
				models = { displayText = Engine.ToUpper( Engine.Localize( "MENU_UPLOAD_CLIP", demoSegmentCount ) ), action = StartMenuUploadClip, disabledFunction = IsUploadClipButtonDisabled },
				properties = { hideHelpItemLabel = true }
			} )
		end

		if isHighlightReelMode then
			table.insert( menuOptions, {
				models = { displayText = Engine.ToUpper( Engine.Localize( "MENU_DEMO_CUSTOMIZE_HIGHLIGHT_REEL" ) ), action = StartMenuOpenCustomizeHighlightReel, disabledFunction = IsCustomizeHighlightReelButtonDisabled }
			} )
		end

		table.insert( menuOptions, {
			models = { displayText = Engine.ToUpper( Engine.Localize( "MENU_JUMP_TO_START" ) ), action = StartMenuJumpToStart, disabledFunction = IsJumpToStartButtonDisabled },
			properties = { hideHelpItemLabel = true }
		} )

		local endDemoLabel
		if isClipPlaying then
			endDemoLabel = Engine.Localize( "MENU_END_CLIP" )
		else
			endDemoLabel = Engine.Localize( "MENU_END_FILM" )
		end

		table.insert( menuOptions, {
			models = { displayText = Engine.ToUpper( endDemoLabel ), action = StartMenuEndDemo }
		} )

	elseif CoD.isCampaign then
		table.insert( menuOptions, {
			models = { displayText = "MENU_RESUMEGAME_CAPS", action = StartMenuGoBack_ListElement }
		} )

		local isInTrainingSim = CoD.SafeGetModelValue( Engine.GetModelForController( controller ), "safehouse.inTrainingSim" ) or 0

		if Engine.IsLobbyHost( Enum.LobbyType.LOBBY_TYPE_GAME ) then
			if not CoD.isSafehouse and controller == Engine.GetPrimaryController() then
				table.insert( menuOptions, {
					models = { displayText = "MENU_RESTART_MISSION_CAPS", action = RestartMission }
				} )

				if LUI.DEV ~= nil then
					table.insert( menuOptions, {
						models = { displayText = "MENU_RESTART_CHECKPOINT_CAPS", action = RestartFromCheckpoint }
					} )
				end
			end

			if controller == Engine.GetPrimaryController() then
				table.insert( menuOptions, {
					models = { displayText = "MENU_CHANGE_DIFFICULTY_CAPS", action = OpenDifficultySelect }
				} )
			end

			if CoD.isSafehouse and isInTrainingSim == 1 then
				table.insert( menuOptions, {
					models = { displayText = "MENU_END_TRAINING_SIM", action = EndTrainingSim }
				} )
			elseif controller == Engine.GetPrimaryController() then
				local quitLabel = Engine.DvarBool( 0, "ui_blocksaves" ) and "MENU_EXIT_CAPS" or "MENU_SAVE_AND_QUIT_CAPS"
				table.insert( menuOptions, {
					models = { displayText = quitLabel, action = SaveAndQuitGame }
				} )
			end
		elseif CoD.isSafehouse and isInTrainingSim == 1 then
			table.insert( menuOptions, {
				models = { displayText = "MENU_END_TRAINING_SIM", action = EndTrainingSim }
			} )
		else
			table.insert( menuOptions, {
				models = { displayText = "MENU_LEAVE_PARTY_AND_EXIT_CAPS", action = QuitGame }
			} )
		end

	elseif CoD.isMultiplayer then
		if Engine.Team( controller, "name" ) ~= "TEAM_SPECTATOR"
			and Engine.GetGametypeSetting( "disableClassSelection" ) ~= 1 then

			table.insert( menuOptions, {
				models = { displayText = "MPUI_CHOOSE_CLASS_BUTTON_CAPS", action = ChooseClass }
			} )
		end

		if not Engine.GameModeIsMode( CoD.GAMEMODE_PUBLIC_MATCH )
		and not Engine.GameModeIsMode( CoD.GAMEMODE_LEAGUE_MATCH )
		and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_ROUND_END_KILLCAM )
		and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_FINAL_KILLCAM )
		and CoD.IsTeamChangeAllowed() then
			table.insert( menuOptions, {
				models = { displayText = "MPUI_CHANGE_TEAM_BUTTON_CAPS", action = ChooseTeam }
			} )
		end

		if controller == 0 then
			local quitGameLabel = "MENU_QUIT_GAME_CAPS"

			if Engine.IsLobbyHost( Enum.LobbyType.LOBBY_TYPE_GAME ) and not CoD.isOnlineGame() then
				quitGameLabel = "MENU_END_GAME_CAPS"
			end

			table.insert( menuOptions, {
				models = { displayText = quitGameLabel, action = QuitGame_MP }
			} )
		end

	elseif CoD.isZombie then
		table.insert( menuOptions, {
			models = { displayText = "MENU_RESUMEGAME_CAPS", action = StartMenuGoBack_ListElement }
		} )

		if Engine.IsLobbyHost( Enum.LobbyType.LOBBY_TYPE_GAME ) then
			table.insert( menuOptions, {
				models = { displayText = "MENU_RESTART_LEVEL_CAPS", action = RestartGame }
			} )
		end

		table.insert( menuOptions, {
			models = {
				displayText = "^7MOD OPTIONS",
				action = function( self, element, controller, actionParam, menu )
					NavigateToMenu( menu, "StartMenu_ModSettings_Main", true, controller )
				end
			}
		} )

		if Engine.IsLobbyHost( Enum.LobbyType.LOBBY_TYPE_GAME ) == true then
			table.insert( menuOptions, {
				models = { displayText = "MENU_END_GAME_CAPS", action = QuitGame_MP }
			} )
		else
			table.insert( menuOptions, {
				models = { displayText = "MENU_QUIT_GAME_CAPS", action = QuitGame_MP }
			} )
		end
	end

	return menuOptions
end, true )


CoD.StartMenu_GameOptions_ZM = InheritFrom( LUI.UIElement )
CoD.StartMenu_GameOptions_ZM.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_GameOptions_ZM )
	self.id = "StartMenu_GameOptions_ZM"
	self.soundSet = "ChooseDecal"
	self:setLeftRight( true, false, 0, 1150 )
	self:setTopBottom( true, false, 0, 520 )
	self:makeFocusable()
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	
	self.buttonList = LUI.UIList.new( menu, controller, 2, 0, nil, true, false, 0, 0, false, false )
	self.buttonList:makeFocusable()
	self.buttonList:setLeftRight( true, false, 12, 292 )
	self.buttonList:setTopBottom( true, false, 4.91, 172.91 )
	self.buttonList:setWidgetType( CoD.List1ButtonLarge_PH )
	self.buttonList:setVerticalCount( 5 )
	self.buttonList:setDataSource( "ModStartMenuGameOptions" )
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
	menu:AddButtonCallbackFunction( self.buttonList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function( element, menu, controller, model )
		ProcessListAction( self, element, controller )
		return true
	end, function( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT" )
		return true
	end, false )
	self:addElement( self.buttonList )
	
	self.rankProgress = CoD.ProgressBar_Rank.new( menu, controller )
	self.rankProgress:setLeftRight( true, false, 4.87, 1147.87 )
	self.rankProgress:setTopBottom( true, false, 451, 517 )
	self:addElement( self.rankProgress )
	
	self.Pixel2001 = LUI.UIImage.new()
	self.Pixel2001:setLeftRight( true, false, -36, 0 )
	self.Pixel2001:setTopBottom( true, false, 106, 110 )
	self.Pixel2001:setYRot( -180 )
	self.Pixel2001:setImage( RegisterImage( "uie_t7_menu_frontend_pixelist" ) )
	self.Pixel2001:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Pixel2001 )
	
	self.Pixel20 = LUI.UIImage.new()
	self.Pixel20:setLeftRight( true, false, -36.13, -0.13 )
	self.Pixel20:setTopBottom( true, false, 486, 490 )
	self.Pixel20:setYRot( -180 )
	self.Pixel20:setImage( RegisterImage( "uie_t7_menu_frontend_pixelist" ) )
	self.Pixel20:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Pixel20 )
	
	self.Pixel200 = LUI.UIImage.new()
	self.Pixel200:setLeftRight( true, false, 1146.87, 1182.87 )
	self.Pixel200:setTopBottom( true, false, 486, 490 )
	self.Pixel200:setImage( RegisterImage( "uie_t7_menu_frontend_pixelist" ) )
	self.Pixel200:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Pixel200 )
	
	self.Pixel2000 = LUI.UIImage.new()
	self.Pixel2000:setLeftRight( true, false, 1145.87, 1181.87 )
	self.Pixel2000:setTopBottom( true, false, 34, 38 )
	self.Pixel2000:setImage( RegisterImage( "uie_t7_menu_frontend_pixelist" ) )
	self.Pixel2000:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Pixel2000 )
	
	self.Pixel2002 = LUI.UIImage.new()
	self.Pixel2002:setLeftRight( true, false, 1146.87, 1182.87 )
	self.Pixel2002:setTopBottom( true, false, 386, 390 )
	self.Pixel2002:setImage( RegisterImage( "uie_t7_menu_frontend_pixelist" ) )
	self.Pixel2002:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Pixel2002 )
	
	self.ZombacusBG = LUI.UIImage.new()
	self.ZombacusBG:setLeftRight( true, false, -38 + 8, 188 - 8 ) 
	self.ZombacusBG:setTopBottom( true, false, 300, 345 )
	self.ZombacusBG:setImage( RegisterImage( "$white" ) )
	self.ZombacusBG:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.ZombacusBG:setShaderVector( 0, 0.5, 0.5, 0.5, 0.5 ) 
	self.ZombacusBG:setRGB( 0.71, 0.75, 0.82 )
	self.ZombacusBG:setAlpha( 0.25 )
	self:addElement( self.ZombacusBG )

	self.ZombacusDividerTop = LUI.UIImage.new()
	self.ZombacusDividerTop:setLeftRight( true, false, -38 + 22, 188 - 22 ) 
	self.ZombacusDividerTop:setTopBottom( true, false, 299 + 7, 300 + 7 )
	self.ZombacusDividerTop:setImage( RegisterImage( "$white" ) )
	self.ZombacusDividerTop:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.ZombacusDividerTop:setShaderVector( 0, 0.2, 0.2, 0.2, 0.2 )
	self.ZombacusDividerTop:setRGB( 0.7, 0.7, 0.7 )
	self.ZombacusDividerTop:setAlpha( 0.8 )
	self:addElement( self.ZombacusDividerTop )

	self.ZombacusDividerBottom = LUI.UIImage.new()
	self.ZombacusDividerBottom:setLeftRight( true, false, -38 + 22, 450 ) 
	self.ZombacusDividerBottom:setTopBottom( true, false, 345 - 7, 346 - 7 )
	self.ZombacusDividerBottom:setImage( RegisterImage( "$white" ) )
	self.ZombacusDividerBottom:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.ZombacusDividerBottom:setShaderVector( 0, 0.2, 0.2, 0.2, 0.2 )
	self.ZombacusDividerBottom:setRGB( 0.7, 0.7, 0.7 )
	self.ZombacusDividerBottom:setAlpha( 0.8 )
	self:addElement( self.ZombacusDividerBottom )

	self.ZombacusShadow = LUI.UIText.new()
	self.ZombacusShadow:setLeftRight( true, false, 7 + 10, 368 + 10 ) 
	self.ZombacusShadow:setTopBottom( true, false, 280 + 25, 315 + 25 )
	self.ZombacusShadow:setTTF( "fonts/DeathSpirit.ttf" )
	self.ZombacusShadow:setText( "ZOMBACUS" )
	self.ZombacusShadow:setRGB( 0.71, 0.75, 0.82 )
	self.ZombacusShadow:setAlignment( LUI.Alignment.Left )
	self:addElement( self.ZombacusShadow )

	self.Zombacus = LUI.UIText.new()
	self.Zombacus:setLeftRight( true, false, 7 + 10, 368 + 10 ) 
	self.Zombacus:setTopBottom( true, false, 280 + 25, 315 + 25 )
	self.Zombacus:setTTF( "fonts/DeathSpirit.ttf" )
	self.Zombacus:setText( "ZOMBACUS" )
	self.Zombacus:setRGB( 0.38, 0.05, 0.05 )
	self.Zombacus:setAlignment( LUI.Alignment.Left )
	self.Zombacus:setAlpha( 0.95 )
	self:addElement( self.Zombacus )

	self.GumTrackerBG = LUI.UIImage.new()
	self.GumTrackerBG:setLeftRight( true, false, -70, 427 ) 
	self.GumTrackerBG:setTopBottom( true, false, 315, 465 )
	self.GumTrackerBG:setImage( RegisterImage( "$white" ) )
	self.GumTrackerBG:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.GumTrackerBG:setShaderVector( 0, 0.5, 0.5, 0.5, 0.5 ) 
	self.GumTrackerBG:setRGB( 0.71, 0.75, 0.82 )
	self.GumTrackerBG:setAlpha( 0.2 )
	self:addElement( self.GumTrackerBG )

	self.GumTracker = CoD.StartMenu_GumTracker.new( menu, controller )
	self.GumTracker:setLeftRight( true, false, 0, 368 + 100 )
	self.GumTracker:setTopBottom( true, false, 400 - 85, 550 - 85 )
	self:addElement( self.GumTracker )

	self.TrackerDivider = LUI.UIImage.new()
	self.TrackerDivider:setLeftRight( true, false, -38 + 22, 666 ) 
	self.TrackerDivider:setTopBottom( true, false, 345 - 7 + 100, 346 - 7 + 100 )
	self.TrackerDivider:setImage( RegisterImage( "$white" ) )
	self.TrackerDivider:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.TrackerDivider:setShaderVector( 0, 0.2, 0.2, 0.2, 0.2 )
	self.TrackerDivider:setRGB( 0.7, 0.7, 0.7 )
	self.TrackerDivider:setAlpha( 0.8 )
	self:addElement( self.TrackerDivider )

	self.PowerupTrackerBG = LUI.UIImage.new()
	self.PowerupTrackerBG:setLeftRight( true, false, -70, 666 ) 
	self.PowerupTrackerBG:setTopBottom( true, false, 400, 550 )
	self.PowerupTrackerBG:setImage( RegisterImage( "$white" ) )
	self.PowerupTrackerBG:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.PowerupTrackerBG:setShaderVector( 0, 0.5, 0.5, 0.5, 0.5 ) 
	self.PowerupTrackerBG:setRGB( 0.71, 0.75, 0.82 )
	self.PowerupTrackerBG:setAlpha( 0.2 )
	self:addElement( self.PowerupTrackerBG )

	self.PowerupTracker = CoD.StartMenu_PowerupTracker.new( menu, controller )
	self.PowerupTracker:setLeftRight( true, false, 0, 368 + 300 )
	self.PowerupTracker:setTopBottom( true, false, 400, 550 )
	self:addElement( self.PowerupTracker )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )

				self.rankProgress:completeAnimation()
				self.rankProgress:setLeftRight( true, false, 4.87, 1147.87 )
				self.rankProgress:setTopBottom( true, false, 451, 517 )
				self.clipFinished( self.rankProgress, {} )
			end
		},
		CP_PauseMenu = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )

				self.rankProgress:completeAnimation()
				self.rankProgress:setLeftRight( true, false, 12, 307 )
				self.rankProgress:setTopBottom( true, false, 172.91, 238.91 )
				self.clipFinished( self.rankProgress, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "CP_PauseMenu",
			condition = function( menu, element, event )
				return IsCampaign()
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyNav" ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "lobbyRoot.lobbyNav" } )
	end )

	self.buttonList.id = "buttonList"

	self:registerEventHandler( "gain_focus", function( element, event )
		if element.m_focusable and element.buttonList:processEvent( event ) then
			return true
		else
			return LUI.UIElement.gainFocus( element, event )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.buttonList:close()
		element.rankProgress:close()
		element.ZombacusBG:close()
		element.ZombacusDividerTop:close()
		element.ZombacusDividerBottom:close()
		element.ZombacusShadow:close()
		element.Zombacus:close()
		element.GumTrackerBG:close()
		element.GumTracker:close()
		element.TrackerDivider:close()
		element.PowerupTrackerBG:close()
		element.PowerupTracker:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end