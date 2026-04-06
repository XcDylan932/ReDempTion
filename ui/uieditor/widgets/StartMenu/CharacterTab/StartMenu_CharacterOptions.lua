require( "ui.uieditor.widgets.StartMenu.CharacterTab.StartMenu_CharacterOptions_ListItem" )

local mapName = Engine.GetCurrentMap()
local classicCharacters = {
	zm_prototype = true,
	zm_asylum = true,
	zm_sumpf = true,
	zm_theater = true,
	zm_cosmodrome = true,
	zm_temple = true,
	zm_moon = true
}

local CharacterImages = {
	ultimis = {
		"uie_zm_char_ultimis_dempsey",
		"uie_zm_char_ultimis_nikolai",
		"uie_zm_char_ultimis_richtofen",
		"uie_zm_char_ultimis_takeo"
	},
	primis = {
		"uie_zm_char_primis_dempsey",
		"uie_zm_char_primis_nikolai",
		"uie_zm_char_primis_richtofen",
		"uie_zm_char_primis_takeo"
	},
	ww2 = {
		"uie_zm_char_ww2_dempsey",
		"uie_zm_char_ww2_nikolai",
		"uie_zm_char_ww2_richtofen",
		"uie_zm_char_ww2_takeo"
	},
	drained = {
		"uie_zm_char_drained_dempsey",
		"uie_zm_char_drained_nikolai",
		"uie_zm_char_drained_richtofen",
		"uie_zm_char_drained_takeo"
	},
	zod = {
		"uie_zm_char_zod_floyd",
		"uie_zm_char_zod_jackie",
		"uie_zm_char_zod_jessica",
		"uie_zm_char_zod_nero"
	},
	pentagon = {
		"uie_zm_char_pentagon_kennedy",
		"uie_zm_char_pentagon_mcnamara",
		"uie_zm_char_pentagon_nixon",
		"uie_zm_char_pentagon_castro"
	},
	coast = {
		"uie_zm_char_coast_gellar",
		"uie_zm_char_coast_englund",
		"uie_zm_char_coast_trejo",
		"uie_zm_char_coast_rooker"
	},
	victis = {
		"uie_zm_char_victis_russman",
		"uie_zm_char_victis_stuhlinger",
		"uie_zm_char_victis_misty",
		"uie_zm_char_victis_marlton"
	},
	prison = {
		"uie_zm_char_prison_finn",
		"uie_zm_char_prison_sal",
		"uie_zm_char_prison_billy",
		"uie_zm_char_prison_weasel"
	},
	chaos = {
		"uie_zm_char_chaos_bruno",
		"uie_zm_char_chaos_diego",
		"uie_zm_char_chaos_scarlett",
		"uie_zm_char_chaos_stanton"
	},
	mansion = {
		"uie_zm_char_mansion_butler",
		"uie_zm_char_mansion_brigadier",
		"uie_zm_char_mansion_gypsy",
		"uie_zm_char_mansion_gunslinger"
	}
}

local startCrew = classicCharacters[mapName] and CharacterImages.ultimis or CharacterImages.primis

CoD.CharacterTable = {
    {
    	models = {
    		image = startCrew[1],
    		name = Engine.Localize( "GAMESETTINGS_CHAR_DEMPSEY" ),
    		characterIndex = 0,
    		styles = {
    			{ image = CharacterImages.primis[1], name = Engine.Localize( "GAMESETTINGS_CHAR_PRIMIS" ), characterIndex = 0 },
    			{ image = CharacterImages.ultimis[1], name = Engine.Localize( "GAMESETTINGS_CHAR_ULTIMIS" ), characterIndex = 4 },
    			{ image = CharacterImages.ww2[1], name = Engine.Localize( "GAMESETTINGS_CHAR_WW2" ), characterIndex = 8 },
    			{ image = CharacterImages.drained[1], name = Engine.Localize( "GAMESETTINGS_CHAR_DRAINED" ), characterIndex = 12 }
    		}
    	}
    },
    {
    	models = {
    		image = startCrew[2],
    		name = Engine.Localize( "GAMESETTINGS_CHAR_NIKOLAI" ),
    		characterIndex = 1,
    		styles = {
    			{ image = CharacterImages.primis[2], name = Engine.Localize( "GAMESETTINGS_CHAR_PRIMIS" ), characterIndex = 1 },
    			{ image = CharacterImages.ultimis[2], name = Engine.Localize( "GAMESETTINGS_CHAR_ULTIMIS" ), characterIndex = 5 },
    			{ image = CharacterImages.ww2[2], name = Engine.Localize( "GAMESETTINGS_CHAR_WW2" ), characterIndex = 9 },
    			{ image = CharacterImages.drained[2], name = Engine.Localize( "GAMESETTINGS_CHAR_DRAINED" ), characterIndex = 13 }
    		}
    	}
    },
    {
    	models = {
    		image = startCrew[3],
    		name = Engine.Localize( "GAMESETTINGS_CHAR_RICHTOFEN" ),
    		characterIndex = 2,
    		styles = {
    			{ image = CharacterImages.primis[3], name = Engine.Localize( "GAMESETTINGS_CHAR_PRIMIS" ), characterIndex = 2 },
    			{ image = CharacterImages.ultimis[3], name = Engine.Localize( "GAMESETTINGS_CHAR_ULTIMIS" ), characterIndex = 6 },
    			{ image = CharacterImages.ww2[3], name = Engine.Localize( "GAMESETTINGS_CHAR_WW2" ), characterIndex = 10 },
    			{ image = CharacterImages.drained[3], name = Engine.Localize( "GAMESETTINGS_CHAR_DRAINED" ), characterIndex = 14 }
    		}
    	}
    },
    {
    	models = {
    		image = startCrew[4],
    		name = Engine.Localize( "GAMESETTINGS_CHAR_TAKEO" ),
    		characterIndex = 3,
    		styles = {
    			{ image = CharacterImages.primis[4], name = Engine.Localize( "GAMESETTINGS_CHAR_PRIMIS" ), characterIndex = 3 },
    			{ image = CharacterImages.ultimis[4], name = Engine.Localize( "GAMESETTINGS_CHAR_ULTIMIS" ), characterIndex = 7 },
    			{ image = CharacterImages.ww2[4], name = Engine.Localize( "GAMESETTINGS_CHAR_WW2" ), characterIndex = 11 },
    			{ image = CharacterImages.drained[4], name = Engine.Localize( "GAMESETTINGS_CHAR_DRAINED" ), characterIndex = 15 }
    		}
    	}
    },

    { models = { image = CharacterImages.zod[1], name = Engine.Localize( "GAMESETTINGS_CHAR_BOXER" ), characterIndex = 16 } },
    { models = { image = CharacterImages.zod[2], name = Engine.Localize( "GAMESETTINGS_CHAR_DETECTIVE" ), characterIndex = 17 } },
    { models = { image = CharacterImages.zod[3], name = Engine.Localize( "GAMESETTINGS_CHAR_FEMME" ), characterIndex = 18 } },
    { models = { image = CharacterImages.zod[4], name = Engine.Localize( "GAMESETTINGS_CHAR_MAGICIAN" ), characterIndex = 19 } },

    { models = { image = CharacterImages.pentagon[1], name = Engine.Localize( "GAMESETTINGS_CHAR_KENNEDY" ), characterIndex = 20 } },
    { models = { image = CharacterImages.pentagon[2], name = Engine.Localize( "GAMESETTINGS_CHAR_MCNMARA" ), characterIndex = 21 } },
    { models = { image = CharacterImages.pentagon[3], name = Engine.Localize( "GAMESETTINGS_CHAR_NIXON" ), characterIndex = 22 } },
    { models = { image = CharacterImages.pentagon[4], name = Engine.Localize( "GAMESETTINGS_CHAR_CASTRO" ), characterIndex = 23 } },

    { models = { image = CharacterImages.coast[1], name = Engine.Localize( "GAMESETTINGS_CHAR_GELLAR" ), characterIndex = 24 } },
    { models = { image = CharacterImages.coast[2], name = Engine.Localize( "GAMESETTINGS_CHAR_ENGLUND" ), characterIndex = 25 } },
    { models = { image = CharacterImages.coast[3], name = Engine.Localize( "GAMESETTINGS_CHAR_TREJO" ), characterIndex = 26 } },
    { models = { image = CharacterImages.coast[4], name = Engine.Localize( "GAMESETTINGS_CHAR_ROOKER" ), characterIndex = 27 } },

    { models = { image = CharacterImages.victis[1], name = Engine.Localize( "GAMESETTINGS_CHAR_RUSSMAN" ), characterIndex = 28 } },
    { models = { image = CharacterImages.victis[2], name = Engine.Localize( "GAMESETTINGS_CHAR_STUHLINGER" ), characterIndex = 29 } },
    { models = { image = CharacterImages.victis[3], name = Engine.Localize( "GAMESETTINGS_CHAR_MISTY" ), characterIndex = 30 } },
    { models = { image = CharacterImages.victis[4], name = Engine.Localize( "GAMESETTINGS_CHAR_MARLTON" ), characterIndex = 31 } },

    { models = { image = CharacterImages.prison[1], name = Engine.Localize( "GAMESETTINGS_CHAR_FINN" ), characterIndex = 32 } },
    { models = { image = CharacterImages.prison[2], name = Engine.Localize( "GAMESETTINGS_CHAR_SAL" ), characterIndex = 33 } },
    { models = { image = CharacterImages.prison[3], name = Engine.Localize( "GAMESETTINGS_CHAR_BILLY" ), characterIndex = 34 } },
    { models = { image = CharacterImages.prison[4], name = Engine.Localize( "GAMESETTINGS_CHAR_WEASEL" ), characterIndex = 35 } },

    { models = { image = CharacterImages.chaos[1], name = Engine.Localize( "GAMESETTINGS_CHAR_BRUNO" ), characterIndex = 36 } },
    { models = { image = CharacterImages.chaos[2], name = Engine.Localize( "GAMESETTINGS_CHAR_DIEGO" ), characterIndex = 37 } },
    { models = { image = CharacterImages.chaos[3], name = Engine.Localize( "GAMESETTINGS_CHAR_SCARLETT" ), characterIndex = 38 } },
    { models = { image = CharacterImages.chaos[4], name = Engine.Localize( "GAMESETTINGS_CHAR_STANTON" ), characterIndex = 39 } },

    { models = { image = CharacterImages.mansion[1], name = Engine.Localize( "GAMESETTINGS_CHAR_BUTLER" ), characterIndex = 40 } },
    { models = { image = CharacterImages.mansion[2], name = Engine.Localize( "GAMESETTINGS_CHAR_BRIGADIER" ), characterIndex = 41 } },
    { models = { image = CharacterImages.mansion[3], name = Engine.Localize( "GAMESETTINGS_CHAR_GYPSY" ), characterIndex = 42 } },
    { models = { image = CharacterImages.mansion[4], name = Engine.Localize( "GAMESETTINGS_CHAR_GUNSLINGER" ), characterIndex = 43 } },
}

DataSources.StartMenu_CharacterOptions = ListHelper_SetupDataSource( "StartMenu_CharacterOptions", function( controller )
    local characterOptions = {}
    
    local controllerModel = Engine.GetModelForController( controller )
    local characterIndexModel = Engine.GetModel( controllerModel, "SelectedCharacterIndex" )
    local selectedCharacterModel = Engine.GetModel( controllerModel, "SelectedCharacter" )
    local activeIndex = Engine.GetModelValue( characterIndexModel ) or -1

    if CoD.CharacterTable ~= nil then
        for i = 1, #CoD.CharacterTable do
            local characterEntry = CoD.CharacterTable[i]

            if characterEntry.models then
            	local isCurrent = ( characterEntry.models.characterIndex == activeIndex )
                
                if not isCurrent and characterEntry.models.styles then
                    for _, style in ipairs(characterEntry.models.styles) do
                        if style.characterIndex == activeIndex then
                            isCurrent = true
                            break
                        end
                    end
                end
                
                characterEntry.models.current = isCurrent
                characterEntry.models.action = function( element, event, controller, menu, actionParam )
				    if characterEntry.models.styles then
				    	local parentMenu = element:getParent()
				        CoD.perController[controller].SelectedCharacterStyles = characterEntry.models.styles
				        CoD.perController[controller].CurrentCharacterMenu = menu
				        CoD.perController[controller].SelectedCharacterName = characterEntry.models.name
				        parentMenu:setAlpha( 0 )
				        parentMenu.m_inputDisabled = true
				        local popup = OpenPopup( parentMenu, "StartMenu_CharacterStyles", controller )
				        popup.myParent = parentMenu
				    else
				        Engine.SetModelValue( characterIndexModel, characterEntry.models.characterIndex )
				        Engine.SetModelValue( selectedCharacterModel, characterEntry.models.name )
				    end
				    PlaySoundSetSound( element, "menu_enter" )
				end

                table.insert( characterOptions, characterEntry )
            end
        end
    end

    return characterOptions
end, true )

DataSources.StartMenu_CharacterStyles = ListHelper_SetupDataSource( "StartMenu_CharacterStyles", function( controller )
    local stylesList = {}
    local activeStyles = CoD.perController[controller].SelectedCharacterStyles or {}
    local baseName = CoD.perController[controller].SelectedCharacterName or "Testing"
    local controllerModel = Engine.GetModelForController( controller )
    local characterIndexModel = Engine.GetModel( controllerModel, "SelectedCharacterIndex" )
    local selectedCharacterModel = Engine.GetModel( controllerModel, "SelectedCharacter" )

    for i, style in ipairs( activeStyles ) do
	    table.insert( stylesList, {
	        models = {
	            image = style.image,
	            name = style.name,
	            characterIndex = style.characterIndex
	        },
	        properties = {
	        	action = function( element, event, controller, menu, param )
	        		Engine.SetModelValue( characterIndexModel, style.characterIndex )
	        		Engine.SetModelValue( selectedCharacterModel, style.name .. " " .. baseName )
	                PlaySoundSetSound( element, "menu_enter" )
			        local timer = LUI.UITimer.new( 500, "close_after_delay", true, element )
			        element:addElement( timer )
			        element:registerEventHandler( "close_after_delay", function( sender, event )
			            GoBack( param, controller )
			            timer:close()
			        end )
	            end
	        }
	    } )
	end
    return stylesList
end, true )

local SetCharacterModels = function( self, controller )
	local controllerModel = Engine.GetModelForController( controller )
	local characterIndexModel = Engine.CreateModel( controllerModel, "SelectedCharacterIndex" )
	local selectedCharacterModel = Engine.CreateModel( controllerModel, "SelectedCharacter" )

	if Engine.GetModelValue( characterIndexModel ) == nil then
        Engine.SetModelValue( characterIndexModel, -1 )
        Engine.SetModelValue( selectedCharacterModel, "Random" )
    end
end

local PreLoadFunc = function( self, controller )
	SetCharacterModels( self, controller )
end

local PostLoadFunc = function( self, controller )
	self:subscribeToModel( Engine.GetModel( Engine.GetGlobalModel(), "fastRestart" ), function( model )
		SetCharacterModels( self, controller )
	end )
end

CoD.StartMenu_CharacterOptions = InheritFrom( LUI.UIElement )
CoD.StartMenu_CharacterOptions.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_CharacterOptions )
	self.id = "StartMenu_CharacterOptions"
	self.soundSet = "ChooseDecal"
	self:setLeftRight( true, false, 0, 1150 )
	self:setTopBottom( true, false, 0, 520 )
	self:makeFocusable()
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

	self.buttonList = LUI.UIList.new( menu, controller, 10, 0, nil, true, false, 0, 0, false, false )
	self.buttonList:makeFocusable()
    self.buttonList:setLeftRight( true, false, 100 + 70, 600 + 70 )
    self.buttonList:setTopBottom( true, false, 30 + 25, 500 + 25 )
    self.buttonList:setDataSource( "StartMenu_CharacterOptions" )
	self.buttonList:setWidgetType( CoD.StartMenu_CharacterOptions_ListItem )
    self.buttonList:setVerticalCounter( CoD.verticalCounter )
    self.buttonList:setVerticalScrollbar( CoD.verticalScrollbar )
	self.buttonList:setHorizontalCount( 8 )
	self.buttonList:setVerticalCount( 5 )
	self.buttonList:setSpacing( 10 )
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
        local finalCharacterIndex = Engine.GetModelValue( Engine.GetModel( controllerModel, "SelectedCharacterIndex" ) )

        if finalCharacterIndex ~= nil then
            Engine.SendMenuResponse( controller, "StartMenu_CharacterOptions", finalCharacterIndex )
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

LUI.createMenu.StartMenu_CharacterStyles = function( controller )
    local self = CoD.Menu.NewForUIEditor( "StartMenu_CharacterStyles" )

    if PreLoadFunc then
    	PreLoadFunc( self, controller )
    end

    self.soundSet = "ChooseDecal"
    self:setUseStencil( false )
    self:setOwner( controller )
    self:setLeftRight( false, false, -300, 300 )
    self:setTopBottom( false, false, -200, 200 )
    self:playSound( "menu_open", controller )
    self:makeFocusable()
    self.buttonModel = Engine.CreateModel( Engine.GetModelForController( controller ), "StartMenu_CharacterStyles.buttonPrompts" )
    self.disableDarkenElement = true
	self.disablePopupOpenCloseAnim = false
    self.onlyChildrenFocusable = true
    self.anyChildUsesUpdateState = true

    self.buttonList = LUI.UIList.new( self, controller, 10, 0, nil, true, false, 0, 0, false, false )
	self.buttonList:makeFocusable()
    self.buttonList:setLeftRight( true, false, 100 + 70, 600 + 70 )
    self.buttonList:setTopBottom( true, false, 30, 500 )
    self.buttonList:setDataSource( "StartMenu_CharacterStyles" )
	self.buttonList:setWidgetType( CoD.StartMenu_CharacterOptions_ListItem )
    self.buttonList:setHorizontalCount( 8 )
	self.buttonList:setVerticalCount( 5 )
	self.buttonList:setSpacing( 3 )
	self.buttonList:registerEventHandler( "gain_focus", function( element, event )
		local retval = nil
		if element.gainFocus then
			retval = element:gainFocus( event )
		elseif element.super.gainFocus then
			retval = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, self, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS )
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
	self:addElement( self.buttonList )

	self:registerEventHandler( "menu_opened", function ( element, event )
	    element.buttonList:processEvent( { name = "gain_focus", controller = controller } )
	end )
    
    self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, nil, function ( element, event, controller, model )
	    GoBack( self, controller )
	    return true
	end, function ( element, menu, controller )
	    CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK" )
	    return true
	end, false )

	self:AddButtonCallbackFunction( self.buttonList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function( element, event, controller, model )
		ProcessListAction( self, element, controller )
		return true
	end, function( element, self, controller )
		CoD.Menu.SetButtonLabel( self, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT" )
		return true
	end, false )

	self.buttonList.id = "buttonList"

	self:registerEventHandler( "gain_focus", function( element, event )
		if element.m_focusable and element.buttonList:processEvent( event ) then
			return true
		else
			return LUI.UIElement.gainFocus( element, event )
		end
	end )

	LUI.OverrideFunction_CallOriginalFirst( self, "close", function( element )
		local parentMenu = element.myParent
		if parentMenu then
			parentMenu:setAlpha( 1 )
			parentMenu.m_inputDisabled = nil
			if parentMenu.buttonList then
				parentMenu.buttonList:processEvent( { name = "gain_focus", controller = controller } )
			end
		end 
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.buttonList:close()
		Engine.UnsubscribeAndFreeModel( Engine.GetModel( Engine.GetModelForController( controller ), "StartMenu_Character.buttonPrompts" ) )
	end )

	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end

    return self
end