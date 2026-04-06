require( "ui.uieditor.widgets.StartMenu.StartMenu_frame_noBG" )
require( "ui.uieditor.widgets.Lobby.Common.FE_FocusBarContainer" )
require( "ui.uieditor.widgets.PC.StartMenu.Dropdown.OptionDropdownItem" )
require( "ui.uieditor.widgets.Scrollbars.verticalScrollbar" )

local perkNames = {
	["specialty_additionalprimaryweapon"] = "Mule Kick",
	["specialty_armorvest"] = "Juggernog",
	["specialty_bloodwolf"] = "Blood Wolf Bite",
	["specialty_deadshot"] = "Deadshot",
	["specialty_doubletap2"] = "Doubletap",
	["specialty_electriccherry"] = "Electric Cherry",
	["specialty_fastreload"] = "Speed Cola",
	["specialty_phdflopper"] = "PHD Flopper",
	["specialty_quickrevive"] = "Quick Revive",
	["specialty_staminup"] = "Stamin-Up",
	["specialty_timeslip"] = "Timeslip",
	["specialty_tombstone"] = "Tombstone Soda",
	["specialty_vultureaid"] = "Vulture-Aid",
	["specialty_winterwail"] = "Winter's Wail",
	["specialty_whoswho"] = "Who's Who",
	["specialty_widowswine"] = "Widow's Wine",
	["specialty_zombshell"] = "Zombshell"
	--["specialty_flackjacket"] = "",
	--["specialty_flashprotection"] = "",
	--["specialty_immunecounteruav"] = "",
	--["specialty_loudenemies"] = "",
	--["specialty_nottargetedbyairsupport"] = "",
	--["specialty_proximityprotection"] = "",
}

local ToggleDropdown = function( dropdown, controller )
	if not dropdown.DropDownList then
		return
	end

	dropdown.inUse = not dropdown.inUse

	if dropdown.inUse then
		dropdown:setPriority( 100 )
		dropdown.m_disableNavigation = true

		MakeFocusable( dropdown.DropDownList )
		SetFocusToElement( dropdown, "DropDownList", controller )
		dropdown.DropDownList.m_disableNavigation = nil

		if type( dropdown.dropDownCurrentValue ) == "function" then
			local currentItem = dropdown.DropDownList:findItem( { value = dropdown.dropDownCurrentValue( controller, dropdown ) }, nil, false, false )

			if currentItem then
				dropdown.DropDownList:setActiveItem( currentItem )
			end
		end

		local _, screenY, _, _ = dropdown:getRect()
		local _, listHeight = dropdown.DropDownList:getLocalSize()
		
		local goUp = screenY > 725 

		if goUp then
			dropdown.DropDownList:setTopBottom( false, true, -listHeight, 0 )
			dropdown.listBackground:setTopBottom( false, true, -listHeight, 0 )
			if dropdown.Arrow then
				dropdown.Arrow:setZRot( 270 )
			end
		else
			dropdown.DropDownList:setTopBottom( true, false, 34, 34 + listHeight )
			dropdown.listBackground:setTopBottom( false, true, 0, listHeight )
			if dropdown.Arrow then
				dropdown.Arrow:setZRot( 90 )
			end
		end
	else
		dropdown:setPriority( 0 )
		dropdown.m_disableNavigation = nil

		MakeNotFocusable( dropdown.DropDownList )
		SetLoseFocusToElement( dropdown, "DropDownList", controller )
		dropdown.DropDownList.m_disableNavigation = true
	end

	dropdown:dispatchEventToParent( { name = "dropdown_triggered", widget = dropdown, inUse = dropdown.inUse, controller = controller } )
end

local SetupDropdownEvents = function( dropdown, controller, menu )
	dropdown:setForceMouseEventDispatch( true )

	dropdown:registerEventHandler( "dropdown_item_selected", function( element, event )
		if type( element.dropDownItemSelected ) == "function" and element.inUse then
			element.currentValueText:setText( Engine.Localize( element.dropDownItemSelected( controller, element, event.element ) ) )
		end

		ToggleDropdown( element, controller )
		UpdateState( element, event )

		element.DropDownList:updateDataSource()
		CoD.Menu.UpdateButtonShownState( element, menu, controller, Enum.LUIButton.LUI_KEY_XBY_PSTRIANGLE )

		return true
	end )

	dropdown:registerEventHandler( "dropdown_item_cancelled", function( element, event )
		if element.inUse then
			ToggleDropdown( element, controller )
			UpdateState( element, event )
			return true
		end
		return false
	end )

	dropdown:registerEventHandler( "options_refresh", function( element, event )
		element.DropDownList:updateDataSource()

		if type( element.dropDownRefresh ) == "function" then
			element.currentValueText:setText( Engine.Localize( element.dropDownRefresh( controller, element, element.DropDownList ) ) )
		end

		UpdateState( element, event )
	end )

	dropdown.listBackground:setHandleMouseButton( true )

	dropdown.listBackground:registerEventHandler( "leftmouseup", function( element, event )
		if event.inside then
			element.m_clickedInside = nil
		end
	end )

	dropdown.listBackground:registerEventHandler( "leftmousedown", function( element, event )
		element.m_clickedInside = true
	end )

	dropdown.listBackground:registerEventHandler( "leftclick_outside", function( element, event )
		if dropdown.inUse and not element.m_clickedInside then
			ToggleDropdown( dropdown, controller )
			UpdateState( dropdown, event )
			return true
		end

		element.m_clickedInside = nil
		return false
	end )

	dropdown:registerEventHandler( "mouse_left_click", function( element, event )
		if event.element.m_dropdownItem then
			return element:dispatchEventToParent( event )
		end
		return true
	end )

	menu:AddButtonCallbackFunction( dropdown, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function( element, focusElement, controller, _ )
		if dropdown.disabled then
			return false
		end

		if focusElement.m_disableNavigation then
			return false
		end

		if not focusElement:AcceptGamePadButtonInputFromModelCallback( controller ) then
			return false
		end

		if not dropdown.inUse then
			ToggleDropdown( dropdown, controller )
			UpdateState( dropdown, { name = "update_state", controller = controller } )
		end

		return true
	end )
end

local function Capitalize( str )
    if not str or str == "" then
    	return ""
    end
    local clean = tostring( str ):gsub( "^.*_", "" ):gsub( "_", " " )
    return clean:gsub( "(%a)([%w_']*)", function( first, rest )
        return first:upper() .. rest:lower()
    end )
end

local PostLoadFunc = function( self, controller, menu )
    if CoD.isPC then
        SetupDropdownEvents( self, controller, menu )
    end

    local UpdateAll = function()
        local model = self:getModel()
        if not model then
        	return
        end

        local profileVarModel = Engine.GetModel( model, "profileVarName" )
        if not profileVarModel then
        	return
        end
        
        local profileVarName = Engine.GetModelValue( profileVarModel )
        local customVal = CoD.PCUtil.GlobalSettings[profileVarName] 

		if not customVal and CoD.PCUtil.GameOptions[controller] then
		    customVal = CoD.PCUtil.GameOptions[controller][profileVarName]
		end
		
        local validColors = { white = true, blue = true, green = true, orange = true, yellow = true, purple = true, pink = true, red = true }
        local isColorOption = type( customVal ) == "string" and validColors[customVal]
        local colorValue = isColorOption and customVal or CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]

        if colorValue then
            local colorElements = { self.listBackground, self.currentValueText, self.Arrow, self.frameOutline, self.FocusBarT.FEFocusBarSolid, self.FocusBarB.FEFocusBarSolid }
            for _, element in ipairs( colorElements ) do
                if element then CoD.UIColors.SetElementColor( element, colorValue ) end
            end

            if self.FocusBarT and self.FocusBarT.FEFocusBarAdd then
            	self.FocusBarT.FEFocusBarAdd:setAlpha( 0 )
            end

            if self.FocusBarB and self.FocusBarB.FEFocusBarAdd then
            	self.FocusBarB.FEFocusBarAdd:setAlpha( 0 )
            end
        end

        local isGlobalCustom = CoD.PCUtil.GlobalSettings[profileVarName] ~= nil
        local isLocalCustom = ( CoD.PCUtil.GameOptions[controller] and CoD.PCUtil.GameOptions[controller][profileVarName] ~= nil )

        if isGlobalCustom or isLocalCustom then
            if isColorOption then
                self.currentValueText:setText( Capitalize( customVal ) )
                return 
            end

            local foundMatch = false
            local controllerModel = Engine.GetModelForController( 0 )
            
            local weaponsCount = Engine.GetModelValue( Engine.GetModel( controllerModel, "zombie_weapons_count" ) ) or 0
            for i = 0, weaponsCount - 1 do
                local weaponBase = "zombie_weapons_" .. i
                if Engine.GetModelValue( Engine.GetModel( controllerModel, weaponBase .. ".rootname" ) ) == customVal then
                    local displayModel = Engine.GetModel( controllerModel, weaponBase .. ".displayname" )
                    if displayModel then
                        self.currentValueText:setText( Engine.Localize( Engine.GetModelValue( displayModel ) ) )
                        foundMatch = true
                        break
                    end
                end
            end

            if not foundMatch then
                local perksCount = Engine.GetModelValue( Engine.GetModel( controllerModel, "zombie_perks_count" ) ) or 0
                for i = 0, perksCount - 1 do
                    local perkBase = "zombie_perks_" .. i
                    if Engine.GetModelValue( Engine.GetModel( controllerModel, perkBase .. ".specialty" ) ) == customVal then
                        local displayName = perkNames[customVal] or Engine.GetModelValue( Engine.GetModel( controllerModel, perkBase .. ".displayname" ) )
                        if displayName then
                            self.currentValueText:setText( Engine.Localize( displayName ) )
                            foundMatch = true
                            break
                        end
                    end
                end
            end

            if not foundMatch then
                self.currentValueText:setText( Capitalize( tostring( customVal ) ) )
            end
        else
            local valModel = Engine.GetModel( model, "currentValueDisplay" )
            local val = valModel and Engine.GetModelValue( valModel )
            if val then
                self.currentValueText:setText( Engine.Localize( val ) )
            end
        end
    end

    self.UpdateAll = UpdateAll

    self:registerEventHandler( "dropdown_item_selected", function( element, event )
        if type( element.dropDownItemSelected ) == "function" and element.inUse then
            element.dropDownItemSelected( controller, element, event.element )
            UpdateAll()
        end
        ToggleDropdown( element, controller )
        UpdateState( element, event )
        if element.DropDownList then element.DropDownList:updateDataSource() end
        return true
    end )

    self:subscribeToElementModel( self, "currentValueDisplay", UpdateAll )
    self:subscribeToElementModel( self, "profileVarName", UpdateAll )
    
    local colorUpdateModel = Engine.GetModel( Engine.GetModelForController( controller ), "colorUpdate" )
    if colorUpdateModel then
        self:subscribeToModel( colorUpdateModel, UpdateAll )
    end
    
    UpdateAll()
end

CoD.OptionDropdown = InheritFrom( LUI.UIElement )
CoD.OptionDropdown.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.OptionDropdown )
	self.id = "OptionDropdown"
	self.soundSet = "none"
	self:setLeftRight( true, false, 0, 500 )
	self:setTopBottom( true, false, 0, 34 )
	self:makeFocusable()
	self:setHandleMouse( true )
	self.anyChildUsesUpdateState = true
	
	self.listBackground = LUI.UIImage.new()
	self.listBackground:setLeftRight( true, false, 250, 519 - 18 )
	self.listBackground:setTopBottom( true, false, 34, 292 )
	self.listBackground:setRGB( 0, 0, 0 )
	self.listBackground:setAlpha( 0 )
	self:addElement( self.listBackground )
	
	self.fullBacking = LUI.UIImage.new()
	self.fullBacking:setLeftRight( true, true, -1000, 1000 )
	self.fullBacking:setTopBottom( true, true, -1000, 1000 )
	self.fullBacking:setRGB( 0, 0, 0 )
	self.fullBacking:setAlpha( 0 )
	self:addElement( self.fullBacking )
	
	self.StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new( menu, controller )
	self.StartMenuframenoBG00:setLeftRight( true, true, 0, 0 )
	self.StartMenuframenoBG00:setTopBottom( true, true, 0, 0 )
	self:addElement( self.StartMenuframenoBG00 )
	
	self.labelText = LUI.UIText.new()
	self.labelText:setLeftRight( true, false, 9.34, 285 )
	self.labelText:setTopBottom( true, false, 4.5, 29.5 )
	self.labelText:setTTF( "fonts/default.ttf" )
	self.labelText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.labelText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self:addElement( self.labelText )
	
	self.dropdownBacking = LUI.UIImage.new()
	self.dropdownBacking:setLeftRight( true, false, 250, 491 )
	self.dropdownBacking:setTopBottom( true, false, 7.25, 26.75 )
	self.dropdownBacking:setRGB( 0.1, 0.1, 0.1 )
	self.dropdownBacking:setAlpha( 0 )
	self:addElement( self.dropdownBacking )
	
	self.currentValueText = LUI.UIText.new()
	self.currentValueText:setLeftRight( true, false, 255, 470 )
	self.currentValueText:setTopBottom( true, false, 4.25, 29.25 )
	self.currentValueText:setText( Engine.Localize( "" ) )
	self.currentValueText:setTTF( "fonts/default.ttf" )
	self.currentValueText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.currentValueText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self.currentValueText:linkToElementModel( self, "currentValueDisplay", true, function( model )
	    if self.UpdateAll then
	        self:UpdateAll()
	    end
	end )
	self:addElement( self.currentValueText )
	
	self.FocusBarB = CoD.FE_FocusBarContainer.new( menu, controller )
	self.FocusBarB:setLeftRight( true, true, 0, 0 )
	self.FocusBarB:setTopBottom( false, true, -5.5, 0 )
	self.FocusBarB:setAlpha( 0 )
	self.FocusBarB:setZoom( 1 )
	self:addElement( self.FocusBarB )
	
	self.FocusBarT = CoD.FE_FocusBarContainer.new( menu, controller )
	self.FocusBarT:setLeftRight( true, true, 2, 0 )
	self.FocusBarT:setTopBottom( true, false, 0, 4 )
	self.FocusBarT:setAlpha( 0 )
	self.FocusBarT:setZoom( 1 )
	self:addElement( self.FocusBarT )
	
	self.DropDownList = LUI.UIList.new( menu, controller, 2, 0, nil, true, false, 1, 0, false, true )
	self.DropDownList:makeFocusable()
	self.DropDownList:setLeftRight( false, true, -251, 0 )
	self.DropDownList:setTopBottom( true, false, 34, 292 )
	self.DropDownList:setAlpha( 0 )
	self.DropDownList:setWidgetType( CoD.OptionDropdownItem )
	self.DropDownList:setVerticalCount( 10 )
	self.DropDownList:setVerticalScrollbar( CoD.verticalScrollbar )
	self:addElement( self.DropDownList )
	
	self.Arrow = LUI.UIImage.new()
	self.Arrow:setLeftRight( true, true, 468.12, -1 )
	self.Arrow:setTopBottom( true, true, 4.5, -4.5 )
	self.Arrow:setZRot( 90 )
	self.Arrow:setScale( 0.6 )
	self.Arrow:setImage( RegisterImage( "uie_characterminiselectorarrow" ) )
	self:addElement( self.Arrow )
	
	self.frameOutline = CoD.StartMenu_frame_noBG.new( menu, controller )
	self.frameOutline:setLeftRight( true, true, 0, 0 )
	self.frameOutline:setTopBottom( true, true, 0, 0 )
	CoD.UIColors.SetElementColor( self.frameOutline, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.frameOutline:setAlpha( 0 )
	self:addElement( self.frameOutline )
	
	self.labelText:linkToElementModel( self, "label", true, function( model )
		local label = Engine.GetModelValue( model )
		if label then
			self.labelText:setText( Engine.Localize( label ) )
		end
	end )

	self.DropDownList:linkToElementModel( self, "datasource", true, function( model )
		local datasource = Engine.GetModelValue( model )
		if datasource then
			self.DropDownList:setDataSource( datasource )
		end
	end )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 7 )

				self.listBackground:completeAnimation()
				self.listBackground:setAlpha( 0 )
				self.clipFinished( self.listBackground, {} )

				self.currentValueText:completeAnimation()
				self.currentValueText:setAlpha( 0.5 )
				self.clipFinished( self.currentValueText, {} )

				self.FocusBarB:completeAnimation()
				self.FocusBarB:setAlpha( 0 )
				self.clipFinished( self.FocusBarB, {} )

				self.FocusBarT:completeAnimation()
				self.FocusBarT:setLeftRight( true, true, 0, 0 )
				self.FocusBarT:setTopBottom( true, false, 0, 4 )
				self.FocusBarT:setAlpha( 0 )
				self.clipFinished( self.FocusBarT, {} )

				self.DropDownList:completeAnimation()
				self.DropDownList:setAlpha( 0 )
				self.clipFinished( self.DropDownList, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setZRot( 90 )
				self.clipFinished( self.Arrow, {} )

				self.frameOutline:completeAnimation()
				self.frameOutline:setAlpha( 0 )
				self.clipFinished( self.frameOutline, {} )
			end,

			Focus = function()
				self:setupElementClipCounter( 7 )

				self.listBackground:completeAnimation()
				self.listBackground:setAlpha( 0 )
				self.clipFinished( self.listBackground, {} )

				self.currentValueText:completeAnimation()
				self.currentValueText:setAlpha( 1 )
				self.clipFinished( self.currentValueText, {} )

				self.FocusBarB:completeAnimation()
				self.FocusBarB:setAlpha( 1 )
				self.clipFinished( self.FocusBarB, {} )

				self.FocusBarT:completeAnimation()
				self.FocusBarT:setAlpha( 1 )
				self.clipFinished( self.FocusBarT, {} )

				self.DropDownList:completeAnimation()
				self.DropDownList:setAlpha( 0 )
				self.clipFinished( self.DropDownList, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setZRot( 90 )
				self.clipFinished( self.Arrow, {} )

				self.frameOutline:completeAnimation()
				self.frameOutline:setAlpha( 1 )
				self.clipFinished( self.frameOutline, {} )
			end
		},

		Disabled = {
		    DefaultClip = function()
		        self:setupElementClipCounter( 3 )

		        self.labelText:completeAnimation()
		        self.labelText:setAlpha( 0.3 )
		        self.clipFinished( self.labelText, {} )

		        self.currentValueText:completeAnimation()
		        self.currentValueText:setAlpha( 0.3 )
		        self.clipFinished( self.currentValueText, {} )

		        self.Arrow:completeAnimation()
		        self.Arrow:setAlpha( 0 )
		        self.clipFinished( self.Arrow, {} )
		    end
		},

		InUse = {
			DefaultClip = function()
				self:setupElementClipCounter( 5 )

				self.listBackground:completeAnimation()
				self.listBackground:setAlpha( 1 )
				self.clipFinished( self.listBackground, {} )

				self.FocusBarB:completeAnimation()
				self.FocusBarB:setAlpha( 0 )
				self.clipFinished( self.FocusBarB, {} )

				self.FocusBarT:completeAnimation()
				self.FocusBarT:setAlpha( 0 )
				self.clipFinished( self.FocusBarT, {} )

				self.DropDownList:completeAnimation()
				self.DropDownList:setAlpha( 1 )
				self.clipFinished( self.DropDownList, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setZRot( 270 )
				self.clipFinished( self.Arrow, {} )
			end
		}
	}

	self:mergeStateConditions( {
	    {
	    	stateName = "Disabled",
	    	condition = function( menu, element, event )
	    		return IsDisabled( element, controller )
	    	end
	    },
	    {
	        stateName = "InUse",
	        condition = function( menu, element, event )
	            return DropDownListIsInUse( element )
	        end
	    }
	} )

	self:linkToElementModel( self, "disabled", true, function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "disabled" } )
	end )

	LUI.OverrideFunction_CallOriginalFirst( self, "setState", function( element, controller )
		if IsInDefaultState( element ) then
			MakeElementNotFocusable( self, "DropDownList", controller )
		end
	end )

	self.DropDownList.id = "DropDownList"

	self:registerEventHandler( "gain_focus", function( element, event )
		if element.m_focusable and element.DropDownList:processEvent( event ) then
			return true
		else
			return LUI.UIElement.gainFocus( element, event )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.StartMenuframenoBG00:close()
		element.FocusBarB:close()
		element.FocusBarT:close()
		element.DropDownList:close()
		element.frameOutline:close()
		element.labelText:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end