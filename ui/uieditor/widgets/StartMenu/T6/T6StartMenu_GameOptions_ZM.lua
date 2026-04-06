require( "ui.uieditor.widgets.StartMenu.GumTracker.StartMenu_GumTracker" )
require( "ui.uieditor.widgets.StartMenu.PowerupTracker.StartMenu_PowerupTracker" )
require( "ui.uieditor.widgets.StartMenu.T6.T6StartMenu_Options" )
require( "ui.uieditor.widgets.Lobby.Common.T6ButtonListItem" )

DataSources.StartMenuGameOptions = ListHelper_SetupDataSource( "StartMenuGameOptions", function ( controller )
	local options = {}

	if CoD.isZombie then
		table.insert( options, {
			models = { displayText = "MENU_RESUMEGAME_CAPS", action = StartMenuGoBack_ListElement }
		} )

		if Engine.IsLobbyHost( Enum.LobbyType.LOBBY_TYPE_GAME ) then
			table.insert( options, {
				models = { displayText = "MENU_RESTART_LEVEL_CAPS", action = RestartGame }
			} )
		end

		table.insert( options, {
			models = {
				displayText = "^7MOD OPTIONS",
				action = function( self, element, controller, actionParam, menu )
					NavigateToMenu( menu, "StartMenu_ModSettings_Main", true, controller )
				end
			}
		} )

		if Engine.IsLobbyHost( Enum.LobbyType.LOBBY_TYPE_GAME ) then
			table.insert( options, {
				models = { displayText = "MENU_END_GAME_CAPS", action = QuitGame_MP }
			} )
		else
			table.insert( options, {
				models = { displayText = "MENU_QUIT_GAME_CAPS", action = QuitGame_MP }
			} )
		end
	end

	return options
end, true )

CoD.T6StartMenu_GameOptions_ZM = InheritFrom( LUI.UIElement )
CoD.T6StartMenu_GameOptions_ZM.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.T6StartMenu_GameOptions_ZM )
	self.id = "T6StartMenu_GameOptions_ZM"
	self.soundSet = "ChooseDecal"
	self:setLeftRight( true, false, 0, 1150 )
	self:setTopBottom( true, false, 0, 520 )
	self:makeFocusable()
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	
	self.buttonList = LUI.UIList.new( menu, controller, 0, 0, nil, true, false, 0, 0, false, false )
	self.buttonList:makeFocusable()
	self.buttonList:setLeftRight( true, false, 12, 292 )
	self.buttonList:setTopBottom( true, false, 4.91, 172.91 )
	self.buttonList:setWidgetType( CoD.T6ButtonListItem )
	self.buttonList:setVerticalCount( 5 )
	self.buttonList:setDataSource( "StartMenuGameOptions" )
	self.buttonList:registerEventHandler( "gain_focus", function ( element, event )
		local retVal = nil

		if element.gainFocus then
			retVal = element:gainFocus( event )
		elseif element.super.gainFocus then
			retVal = element.super:gainFocus( event )
		end

		CoD.Menu.UpdateButtonShownState( element, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS )

		return retVal
	end )
	self.buttonList:registerEventHandler( "lose_focus", function ( element, event )
		local retVal = nil

		if element.loseFocus then
			retVal = element:loseFocus( event )
		elseif element.super.loseFocus then
			retVal = element.super:loseFocus( event )
		end

		return retVal
	end )
	menu:AddButtonCallbackFunction( self.buttonList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function ( element, menu, controller, model )
		ProcessListAction( self, element, controller )

		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT" )

		return true
	end, false )
	self:addElement( self.buttonList )

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
			DefaultClip = function ()
				self:setupElementClipCounter( 0 )
			end
		},

		CP_PauseMenu = {
			DefaultClip = function ()
				self:setupElementClipCounter( 0 )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "CP_PauseMenu",
			condition = function ( menu, element, event )
				return IsCampaign()
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyNav" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "lobbyRoot.lobbyNav" } )
	end )

	self.buttonList.id = "buttonList"
	
	self:registerEventHandler( "gain_focus", function ( element, event )
		if element.m_focusable and element.buttonList:processEvent( event ) then
			return true
		else
			return LUI.UIElement.gainFocus( element, event )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.buttonList:close()
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