require( "ui.uieditor.widgets.StartMenu.StartMenu_frame_noBG" )
require( "ui.uieditor.widgets.Lobby.Common.FE_FocusBarContainer" )

local PostLoadFunc = function ( self, controller, menu )
	self:registerEventHandler( "options_refresh", function ( element, event )
		element:processEvent( { name = "update_state", controller = event.controller } )
	end )

	CoD.Menu.AddButtonCallbackFunction( menu, self, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function ( element, menu, controller, model )
		if not self.disabled and not menu.m_disableNavigation and menu:AcceptGamePadButtonInputFromModelCallback( controller ) then
			if type( self.checkboxAction ) == "function" then
				self.checkboxAction( controller, self )
				self:processEvent( { name = "update_state", controller = controller } )
			end
			return true
		else
		end
	end )

    self.UpdateColors = function( self )
        local color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]
        CoD.UIColors.SetElementColor( self.fullBorder, "white" )
        CoD.UIColors.SetElementColor( self.fullBacking, "white" )
        CoD.UIColors.SetElementColor( self.fullBorder, "white" )
        CoD.UIColors.SetElementColor( self.CheckboxBkg, color )
        CoD.UIColors.SetElementColor( self.checkboxBacking, color )
        CoD.UIColors.SetElementColor( self.checkboxCheck, color )
        CoD.UIColors.SetElementColor( self.FocusBarT, color )
        CoD.UIColors.SetElementColor( self.FocusBarB, color )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.StartMenu_Options_CheckBoxOption = InheritFrom( LUI.UIElement )
CoD.StartMenu_Options_CheckBoxOption.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_Options_CheckBoxOption )
	self.id = "StartMenu_Options_CheckBoxOption"
	self.soundSet = "ChooseDecal"
	self:setLeftRight( true, false, 0, 500 )
	self:setTopBottom( true, false, 0, 34 )
	self:makeFocusable()
	self:setHandleMouse( true )
	self.anyChildUsesUpdateState = true
	
	self.fullBacking = LUI.UIImage.new()
	self.fullBacking:setLeftRight( true, true, 0, 0 )
	self.fullBacking:setTopBottom( true, true, 0, 0 )
	self.fullBacking:setRGB( 0.1, 0.1, 0.1 )
	self.fullBacking:setAlpha( 0 )
	self:addElement( self.fullBacking )
	
	self.fullBorder = CoD.StartMenu_frame_noBG.new( menu, controller )
	self.fullBorder:setLeftRight( true, true, 0, 0 )
	self.fullBorder:setTopBottom( true, true, 0, 0 )
	self.fullBorder:setRGB( 0.87, 0.37, 0 )
    CoD.UIColors.SetElementColor( self.fullBorder, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.fullBorder:setAlpha( 0 )
	self:addElement( self.fullBorder )
	
	self.checkboxBacking = CoD.StartMenu_frame_noBG.new( menu, controller )
	self.checkboxBacking:setLeftRight( true, true, -8.5, -443.5 )
	self.checkboxBacking:setTopBottom( true, true, -13, 13 )
	self.checkboxBacking:setScale( 0.3 )
	self:addElement( self.checkboxBacking )
	
	self.CheckboxBkg = LUI.UIImage.new()
	self.CheckboxBkg:setLeftRight( true, false, 14.75, 33.25 )
	self.CheckboxBkg:setTopBottom( true, false, 8.25, 25.75 )
	self.CheckboxBkg:setAlpha( 0 )
	self.CheckboxBkg:setImage( RegisterImage( "uie_t7_menu_cacselection_checkbox_empty" ) )
	self:addElement( self.CheckboxBkg )
	
	self.checkboxCheck = LUI.UIImage.new()
	self.checkboxCheck:setLeftRight( true, false, 14.75, 33.25 )
	self.checkboxCheck:setTopBottom( true, false, 8.25, 25.75 )
	self.checkboxCheck:setImage( RegisterImage( "uie_t7_menu_cacselection_checkbox" ) )
	self:addElement( self.checkboxCheck )
	
	self.labelText = LUI.UITightText.new()
	self.labelText:setLeftRight( true, false, 47, 500 )
	self.labelText:setTopBottom( true, false, 4.5, 29.5 )
	self.labelText:setTTF( "fonts/default.ttf" )
	self.labelText:linkToElementModel( self, "label", true, function ( model )
		local label = Engine.GetModelValue( model )
		if label then
			self.labelText:setText( Engine.Localize( label ) )
		end
	end )
	self:addElement( self.labelText )
	
	self.StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new( menu, controller )
	self.StartMenuframenoBG00:setLeftRight( true, true, 0, 0 )
	self.StartMenuframenoBG00:setTopBottom( true, true, 0, 0 )
	self:addElement( self.StartMenuframenoBG00 )
	
	self.FocusBarT = CoD.FE_FocusBarContainer.new( menu, controller )
	self.FocusBarT:setLeftRight( true, true, 2, 0 )
	self.FocusBarT:setTopBottom( true, false, 0 + 100, 4 + 100 )
	self.FocusBarT:setAlpha( 0 )
	self.FocusBarT:setZoom( 1 )
	self:addElement( self.FocusBarT )
	
	self.FocusBarB = CoD.FE_FocusBarContainer.new( menu, controller )
	self.FocusBarB:setLeftRight( true, true, 0, 0 )
	self.FocusBarB:setTopBottom( false, true, -5.5, 0 )
	self.FocusBarB:setAlpha( 0 )
	self.FocusBarB:setZoom( 1 )
	self:addElement( self.FocusBarB )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.fullBorder:completeAnimation()
				self.fullBorder:setAlpha( 0 )
				self.clipFinished( self.fullBorder, {} )

				self.checkboxBacking:completeAnimation()
				self.checkboxBacking:setRGB( 0.78, 0.78, 0.78 )
				self.clipFinished( self.checkboxBacking, {} )

				self.CheckboxBkg:completeAnimation()
				self.CheckboxBkg:setRGB( 1, 1, 1 )
				self.CheckboxBkg:setAlpha( 1 )
				self.clipFinished( self.CheckboxBkg, {} )

				self.checkboxCheck:completeAnimation()
				self.checkboxCheck:setRGB( 1, 0.45, 0 )
                CoD.UIColors.SetElementColor( self.checkboxCheck, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.checkboxCheck:setAlpha( 0 )
				self.clipFinished( self.checkboxCheck, {} )

				self.labelText:completeAnimation()
				self.labelText:setRGB( 1, 1, 1 )
				self.labelText:setAlpha( 1 )
				self.clipFinished( self.labelText, {} )

				self.FocusBarT:completeAnimation()
				self.FocusBarT:setAlpha( 0 )
				self.clipFinished( self.FocusBarT, {} )

				self.FocusBarB:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
				self.FocusBarB:setAlpha( 0 )
				self.FocusBarB:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
			end,

			Focus = function ()
				self:setupElementClipCounter( 7 )

				self.fullBorder:completeAnimation()
				self.fullBorder:setAlpha( 1 )
				self.clipFinished( self.fullBorder, {} )

				self.checkboxBacking:completeAnimation()
				self.checkboxBacking:setRGB( 0.87, 0.37, 0 )
                CoD.UIColors.SetElementColor( self.checkboxBacking, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.clipFinished( self.checkboxBacking, {} )

				self.CheckboxBkg:completeAnimation()
				self.CheckboxBkg:setRGB( 1, 0.41, 0 )
                CoD.UIColors.SetElementColor( self.CheckboxBkg, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.CheckboxBkg:setAlpha( 1 )
				self.clipFinished( self.CheckboxBkg, {} )

				self.checkboxCheck:completeAnimation()
				self.checkboxCheck:setAlpha( 0 )
				self.clipFinished( self.checkboxCheck, {} )

				self.labelText:completeAnimation()
				self.labelText:setRGB( 1, 1, 1 )
				self.labelText:setAlpha( 1 )
				self.clipFinished( self.labelText, {} )

				self.FocusBarT:completeAnimation()
				self.FocusBarT:setLeftRight( true, true, 0, 0 )
				self.FocusBarT:setTopBottom( true, false, 0, 4 )
				self.FocusBarT:setAlpha( 1 )
				self.clipFinished( self.FocusBarT, {} )

				self.FocusBarB:completeAnimation()
				self.FocusBarB:setLeftRight( true, true, 0, 0 )
				self.FocusBarB:setTopBottom( false, true, -5.5, 0 )
				self.FocusBarB:setAlpha( 1 )
				self.clipFinished( self.FocusBarB, {} )
			end
		},

		Checked = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.fullBorder:completeAnimation()
				self.fullBorder:setAlpha( 0 )
				self.clipFinished( self.fullBorder, {} )

				self.checkboxBacking:completeAnimation()
				self.checkboxBacking:setRGB( 0.78, 0.78, 0.78 )
				self.clipFinished( self.checkboxBacking, {} )

				self.CheckboxBkg:completeAnimation()
				self.CheckboxBkg:setRGB( 1, 1, 1 )
				self.CheckboxBkg:setAlpha( 0.5 )
				self.clipFinished( self.CheckboxBkg, {} )

				local checkboxCheckFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
					end
					element:setRGB( 1, 1, 1 )
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.checkboxCheck:completeAnimation()
				self.checkboxCheck:setRGB( 1, 1, 1 )
				self.checkboxCheck:setAlpha( 1 )
				checkboxCheckFrame2( self.checkboxCheck, {} )

				self.labelText:completeAnimation()
				self.labelText:setRGB( 1, 1, 1 )
				self.labelText:setAlpha( 1 )
				self.clipFinished( self.labelText, {} )

				self.FocusBarT:completeAnimation()
				self.FocusBarT:setAlpha( 0 )
				self.clipFinished( self.FocusBarT, {} )

				self.FocusBarB:completeAnimation()
				self.FocusBarB:setAlpha( 0 )
				self.clipFinished( self.FocusBarB, {} )
			end,

			Focus = function ()
				self:setupElementClipCounter( 7 )

				self.fullBorder:completeAnimation()
				self.fullBorder:setAlpha( 1 )
				self.clipFinished( self.fullBorder, {} )

				self.checkboxBacking:completeAnimation()
                CoD.UIColors.SetElementColor( self.checkboxBacking, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.clipFinished( self.checkboxBacking, {} )

				self.CheckboxBkg:completeAnimation()
				self.CheckboxBkg:setRGB( 1, 1, 1 )
				self.CheckboxBkg:setAlpha( 0 )
				self.clipFinished( self.CheckboxBkg, {} )

				local checkboxCheckFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
					end
					element:setRGB( 0.98, 0.44, 0.04 )
                    CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.checkboxCheck:completeAnimation()
                CoD.UIColors.SetElementColor( self.checkboxCheck, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.checkboxCheck:setAlpha( 1 )
				checkboxCheckFrame2( self.checkboxCheck, {} )

				self.labelText:completeAnimation()
				self.labelText:setRGB( 1, 1, 1 )
				self.labelText:setAlpha( 1 )
				self.clipFinished( self.labelText, {} )

				local FocusBarTFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, true, 0, 0 )
					element:setTopBottom( true, false, 0, 4 )
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.FocusBarT:completeAnimation()
				self.FocusBarT:setLeftRight( true, true, 0, 0 )
				self.FocusBarT:setTopBottom( true, false, 0, 4 )
				self.FocusBarT:setAlpha( 1 )
				FocusBarTFrame2( self.FocusBarT, {} )

				local FocusBarBFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, true, 0, 0 )
					element:setTopBottom( false, true, -5.5, 0 )
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.FocusBarB:completeAnimation()
				self.FocusBarB:setLeftRight( true, true, 0, 0 )
				self.FocusBarB:setTopBottom( false, true, -5.5, 0 )
				self.FocusBarB:setAlpha( 1 )
				FocusBarBFrame2( self.FocusBarB, {} )
			end
		},

		Disabled = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.checkboxBacking:completeAnimation()
				self.checkboxBacking:setRGB( 0.2, 0.2, 0.2 )
				self.clipFinished( self.checkboxBacking, {} )

				self.CheckboxBkg:completeAnimation()
				self.CheckboxBkg:setRGB( 0.2, 0.2, 0.2 )
				self.clipFinished( self.CheckboxBkg, {} )

				self.checkboxCheck:completeAnimation()
				self.checkboxCheck:setRGB( 0.2, 0.2, 0.2 )
				self.checkboxCheck:setAlpha( 0 )
				self.clipFinished( self.checkboxCheck, {} )

				self.labelText:completeAnimation()
				self.labelText:setRGB( 0.2, 0.2, 0.2 )
				self.clipFinished( self.labelText, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Checked",
			condition = function ( menu, element, event )
				return CheckBoxOptionChecked( element, event )
			end
		},
		{
			stateName = "Disabled",
			condition = function ( menu, element, event )
				return IsDisabled( element, controller )
			end
		}
	} )

	self:linkToElementModel( self, "disabled", true, function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "disabled" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.fullBorder:close()
		element.checkboxBacking:close()
		element.StartMenuframenoBG00:close()
		element.FocusBarT:close()
		element.FocusBarB:close()
		element.labelText:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end