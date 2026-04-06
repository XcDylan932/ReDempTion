require( "ui.uieditor.widgets.Lobby.Common.FE_FocusBarContainer" )

local SetupDropdownInput = function ( element, controller, menu )
    CoD.Menu.AddButtonCallbackFunction( menu, element, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, nil, function ( element, menu, controller, model )
        element:processEvent( { name = "lose_focus", controller = controller } )
        return element:dispatchEventToParent( { name = "dropdown_item_cancelled", element = element } )
    end )

    CoD.Menu.AddButtonCallbackFunction( menu, element, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function ( element, menu, controller, model )
        if not menu.m_disableNavigation and element:AcceptGamePadButtonInputFromModelCallback( controller ) then
            element:processEvent( { name = "lose_focus", controller = controller } )
            return element:dispatchEventToParent( { name = "dropdown_item_selected", element = element } )
        end
    end )

    element.m_dropdownItem = true
end

local PostLoadFunc = function( self, controller, menu )
    if CoD.isPC then
        SetupDropdownInput( self, controller, menu )
    end

    self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "colorSettings_UI" ), function( model )
        local color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]
        CoD.UIColors.SetElementColor( self.FocusBarT.FEFocusBarSolid, color )
        CoD.UIColors.SetElementColor( self.FocusBarT.Glow2, color )
        CoD.UIColors.SetElementColor( self.FocusBarB.FEFocusBarSolid, color )
        CoD.UIColors.SetElementColor( self.FocusBarB.Glow2, color )
        self.FocusBarT.FEFocusBarAdd:setAlpha( 0 )
        self.FocusBarB.FEFocusBarAdd:setAlpha( 0 )
    end )
end

CoD.OptionDropdownItem = InheritFrom( LUI.UIElement )
CoD.OptionDropdownItem.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.OptionDropdownItem )
	self.id = "OptionDropdownItem"
	self.soundSet = "none"
	self:setLeftRight( true, false, 0, 250 )
	self:setTopBottom( true, false, 0, 24 )
	self:makeFocusable()
	self:setHandleMouse( true )
	self.anyChildUsesUpdateState = true
	
	self.fullbacking = LUI.UIImage.new()
	self.fullbacking:setLeftRight( true, true, 0, 0 )
	self.fullbacking:setTopBottom( true, true, 0, 0 )
	self.fullbacking:setRGB( 0, 0, 0 )
	self:addElement( self.fullbacking )
	
	self.labelText = LUI.UIText.new()
	self.labelText:setLeftRight( true, false, 6.2, 243 )
	self.labelText:setTopBottom( true, false, 0, 24 )
	self.labelText:setTTF( "fonts/default.ttf" )
	self.labelText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.labelText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self.labelText:linkToElementModel( self, "valueDisplay", true, function ( model )
		local valueDisplay = Engine.GetModelValue( model )
		if valueDisplay then
			self.labelText:setText( Engine.Localize( valueDisplay ) )
		end
	end )
    self.labelText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "colorSettings_UI" ), function( model )
        local value = Engine.GetModelValue( model )
        if value then
            CoD.UIColors.SetElementColor( self.labelText, value )
        end
    end )
	self:addElement( self.labelText )
	
	self.FocusBarT = CoD.FE_FocusBarContainer.new( menu, controller )
	self.FocusBarT:setLeftRight( true, true, -2, 2 )
	self.FocusBarT:setTopBottom( true, false, -1, 3 )
	self.FocusBarT:setAlpha( 0 )
	self.FocusBarT:setZoom( 1 )
    self.FocusBarT.FEFocusBarSolid:setImage( RegisterImage( "uie_t7_menu_frontend_barfocussolidfull" ) )
	self:addElement( self.FocusBarT )
	
	self.FocusBarB = CoD.FE_FocusBarContainer.new( menu, controller )
	self.FocusBarB:setLeftRight( true, true, -2, 2 )
	self.FocusBarB:setTopBottom( false, true, -2, 2 )
	self.FocusBarB:setAlpha( 0 )
	self.FocusBarB:setZoom( 1 )
	self:addElement( self.FocusBarB )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.labelText:completeAnimation()
				self.labelText:setLeftRight( true, false, 6.2, 243 )
				self.labelText:setTopBottom( true, false, 0, 24 )
                CoD.UIColors.SetElementColor( self.labelText, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.labelText:setAlpha( 0.75 )
				self.clipFinished( self.labelText, {} )

				self.FocusBarT:completeAnimation()
				self.FocusBarT:setAlpha( 0 )
				self.clipFinished( self.FocusBarT, {} )

				self.FocusBarB:completeAnimation()
				self.FocusBarB:setAlpha( 0 )
				self.clipFinished( self.FocusBarB, {} )
			end,
			Focus = function ()
				self:setupElementClipCounter( 4 )

				self.fullbacking:completeAnimation()
				self.fullbacking:setAlpha( 1 )
				self.clipFinished( self.fullbacking, {} )

				self.labelText:completeAnimation()
				self.labelText:setLeftRight( true, false, 6.2, 240 )
				self.labelText:setTopBottom( true, false, 0, 24 )
				self.labelText:setRGB( 1, 1, 1 )
				self.labelText:setAlpha( 1 )
				self.clipFinished( self.labelText, {} )

				self.FocusBarT:completeAnimation()
				self.FocusBarT:setAlpha( 1 )
				self.clipFinished( self.FocusBarT, {} )

				self.FocusBarB:completeAnimation()
				self.FocusBarB:setAlpha( 1 )
				self.clipFinished( self.FocusBarB, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.FocusBarT:close()
		element.FocusBarB:close()
		element.labelText:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end