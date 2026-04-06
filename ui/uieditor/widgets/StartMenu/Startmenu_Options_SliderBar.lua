require( "ui.uieditor.widgets.StartMenu.StartMenu_frame_noBG" )
require( "ui.uieditor.widgets.Lobby.Common.FE_FocusBarContainer" )
require( "ui.uieditor.widgets.Lobby.Common.FE_TitleNumBrdr" )
require( "ui.uieditor.widgets.StartMenu.StartMenu_Options_SliderBar_Bar" )

local UpdateSliderFromMouse = function( self, event )
	local left, top, right, bottom = self.FilledPartBg:getRect()
	local barWidth = right - left

	self:processEvent( { name = "slider_updated", fraction = CoD.ClampColor( event.x - left, 0, barWidth ) / barWidth, controller = event.controller } )
end

local RedrawSliderUI = function( self )
	local left, top, right, bottom = self.FilledPartBg:getLocalRect()
	local barWidth = right - left
    local knobOffset = self.m_fraction * barWidth
    
	local valueText = string.format( self.m_formatString, self.m_currentValue )
	if valueText == string.format( self.m_formatString, -0 ) then
		valueText = "0.00"
	end
	self.numeric:setText( valueText )

	self.Bar:setLeftRight( true, false, left + knobOffset - self.m_markerHalfWidth, left + knobOffset + self.m_markerHalfWidth )
	self.FilledPart:setLeftRight( true, false, left, left + knobOffset )
end

local PostLoadFunc = function( self, controller, menu )
	self.m_forceMouseEventDispatch = true
	local left, top, right, bottom = self.Bar:getLocalRect()
	
	self.m_markerHalfWidth = ( right - left ) / 2
	self.m_formatString = "%.2f"
	self.m_speedMaxMultiplier = 8
	self.m_ownerController = controller

	self:registerEventHandler( "leftmouseup", UpdateSliderFromMouse )
	self:registerEventHandler( "mousedrag", UpdateSliderFromMouse )

	self:registerEventHandler( "options_refresh", function( element, event )
		if type( element.sliderRefresh ) == "function" then
			element.sliderRefresh( controller, element )
			RedrawSliderUI( element )
		end
	end )

	self:registerEventHandler( "slider_updated", function( element, event )
		if type( element.sliderUpdated ) == "function" then
			element.sliderUpdated( controller, element, event.fraction )
			RedrawSliderUI( element )
		end
	end )

	self:registerEventHandler( "update_bar", function( element, event )
		if element.m_slideDirection then
			element:processEvent( { name = "slider_updated", fraction = CoD.ClampColor( element.m_fraction + element.m_currentSpeed * element.m_slideDirection * event.timeElapsed / 1000, 0, 1 ), controller = element.m_ownerController } )
		end
	end )

	local function HandleArrowPress( direction )
		if not self.m_disableNavigation then
			if not self.m_beat then
				self.m_slideDirection = direction
				self:addElement( self.m_timer )
				self.m_currentSpeed = self.m_sliderSpeed
				self.m_speedMax = self.m_sliderSpeed * self.m_speedMaxMultiplier * self.m_range
				self.m_beat = true
				self:addElement( self.m_heartbeat )
			else
				self.m_heartbeat:reset()
				self.m_currentSpeed = math.min( self.m_currentSpeed * 1.1, self.m_speedMax )
			end
		end
	end

	CoD.Menu.AddButtonCallbackFunction( menu, self, controller, Enum.LUIButton.LUI_KEY_LEFT, "LEFTARROW", function()
		HandleArrowPress(-1)
	end )

	CoD.Menu.AddButtonCallbackFunction( menu, self, controller, Enum.LUIButton.LUI_KEY_RIGHT, "RIGHTARROW", function()
		HandleArrowPress(1)
	end )
    
    self:registerEventHandler( "lose_focus", function( element, event )
        element.m_slideDirection = nil
        element.m_timer:close()
    end)
    
	self.m_timer = LUI.UITimer.new( 1, "update_bar", false )
	self.m_heartbeat = LUI.UITimer.new( 100, "check_pulse", false )
end

CoD.StartMenu_Options_SliderBar = InheritFrom( LUI.UIElement )
CoD.StartMenu_Options_SliderBar.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_Options_SliderBar )
	self.id = "StartMenu_Options_SliderBar"
	self.soundSet = "ChooseDecal"
	self:setLeftRight( true, false, 0, 500 )
	self:setTopBottom( true, false, 0, 40 )
	self:makeFocusable()
	self:setHandleMouse( true )
	self.anyChildUsesUpdateState = true
	
	self.fullBacking = LUI.UIImage.new()
	self.fullBacking:setLeftRight( true, true, 0, 0 )
	self.fullBacking:setTopBottom( true, true, 0, 0 )
	self.fullBacking:setRGB( 0.1, 0.1, 0.1 )
	self.fullBacking:setAlpha( 0 )
	self:addElement( self.fullBacking )
	
	self.frameOutline = CoD.StartMenu_frame_noBG.new( menu, controller )
	self.frameOutline:setLeftRight( true, true, 0, 0 )
	self.frameOutline:setTopBottom( true, true, 0, 0 )
    CoD.UIColors.SetElementColor( self.frameOutline, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.frameOutline:setAlpha( 0 )
	self:addElement( self.frameOutline )
	
	self.label = LUI.UIText.new()
	self.label:setLeftRight( true, false, 8, 235 )
	self.label:setTopBottom( true, false, 5.5, 30.5 )
	self.label:setTTF( "fonts/default.ttf" )
	self.label:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.label:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self:addElement( self.label )
	
	self.numeric = LUI.UITightText.new()
	self.numeric:setLeftRight( true, false, 448, 498 )
	self.numeric:setTopBottom( true, false, 5.5, 30.5 )
	self.numeric:setText( Engine.Localize( "MENU_NEW" ) )
	self.numeric:setTTF( "fonts/default.ttf" )
	self:addElement( self.numeric )
	
	self.FilledPartBg = LUI.UIImage.new()
	self.FilledPartBg:setLeftRight( true, false, 254.41, 434.41 )
	self.FilledPartBg:setTopBottom( false, false, -0.5, 0.5 )
	self.FilledPartBg:setRGB( 0.55, 0.55, 0.55 )
	self.FilledPartBg:setAlpha( 0 )
	self:addElement( self.FilledPartBg )
	
	self.FilledPart = LUI.UIImage.new()
	self.FilledPart:setLeftRight( true, false, 256.41, 378.41 )
	self.FilledPart:setTopBottom( false, false, -2.2, 2.2 )
	CoD.UIColors.SetElementColor( self.FilledPart, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self:addElement( self.FilledPart )
	
	self.StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new( menu, controller )
	self.StartMenuframenoBG00:setLeftRight( true, true, 0, 0 )
	self.StartMenuframenoBG00:setTopBottom( true, true, 0, 0 )
	self:addElement( self.StartMenuframenoBG00 )
	
	self.FocusBarT = CoD.FE_FocusBarContainer.new( menu, controller )
	self.FocusBarT:setLeftRight( true, true, 0, 0 )
	self.FocusBarT:setTopBottom( true, false, 0, 4 )
	self.FocusBarT:setAlpha( 0 )
	self.FocusBarT:setZoom( 1 )
	self:addElement( self.FocusBarT )
	
	self.FocusBarB = CoD.FE_FocusBarContainer.new( menu, controller )
	self.FocusBarB:setLeftRight( true, true, 0, 0 )
	self.FocusBarB:setTopBottom( false, true, -5.5, 0 )
	self.FocusBarB:setAlpha( 0 )
	self.FocusBarB:setZoom( 1 )
	self:addElement( self.FocusBarB )
	
	self.FETitleNumBrdr0 = CoD.FE_TitleNumBrdr.new( menu, controller )
	self.FETitleNumBrdr0:setLeftRight( true, true, 252.41, -60.59 )
	self.FETitleNumBrdr0:setTopBottom( true, true, 15.5, -15.5 )
	self:addElement( self.FETitleNumBrdr0 )
	
	self.Bar = CoD.StartMenu_Options_SliderBar_Bar.new( menu, controller )
	self.Bar:setLeftRight( true, false, 378.41, 384.41 )
	self.Bar:setTopBottom( false, false, -10.5, 10.5 )
    CoD.UIColors.SetElementColor( self.Bar, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self:addElement( self.Bar )
	
	self.label:linkToElementModel( self, "label", true, function( model )
		local value = Engine.GetModelValue( model )
		if value then
			self.label:setText( Engine.Localize( value ) )
		end
	end )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 9 )

				self.frameOutline:completeAnimation()
				self.frameOutline:setAlpha( 0 )
				self.clipFinished( self.frameOutline, {} )

				self.label:completeAnimation()
				self.label:setAlpha( 1 )
				self.clipFinished( self.label, {} )

				self.numeric:completeAnimation()
				self.numeric:setAlpha( 0.5 )
				self.clipFinished( self.numeric, {} )

				self.FilledPartBg:completeAnimation()
				self.FilledPartBg:setLeftRight( true, false, 254.41, 434.41 )
				self.FilledPartBg:setTopBottom( false, false, -0.5, 0.5 )
				self.FilledPartBg:setAlpha( 0 )
				self.clipFinished( self.FilledPartBg, {} )

				self.FilledPart:completeAnimation()
				self.FilledPart:setRGB( 0.5, 0.5, 0.5 )
				self.clipFinished( self.FilledPart, {} )

				self.FocusBarT:completeAnimation()
				self.FocusBarT:setAlpha( 0 )
				self.clipFinished( self.FocusBarT, {} )

				self.FocusBarB:completeAnimation()
				self.FocusBarB:setAlpha( 0 )
				self.clipFinished( self.FocusBarB, {} )

				self.FETitleNumBrdr0:completeAnimation()
				self.FETitleNumBrdr0:setLeftRight( true, true, 252.41, -60.59 )
				self.FETitleNumBrdr0:setTopBottom( true, true, 15.5, -15.5 )
				self.clipFinished( self.FETitleNumBrdr0, {} )

				self.Bar:completeAnimation()
				self.Bar:setRGB( 0.5, 0.5, 0.5 )
				self.clipFinished( self.Bar, {} )
			end,
			
			Focus = function ()
				self:setupElementClipCounter( 9 )

				self.frameOutline:completeAnimation()
				CoD.UIColors.SetElementColor( self.frameOutline, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.frameOutline:setAlpha( 1 )
				self.clipFinished( self.frameOutline, {} )

				self.label:completeAnimation()
				self.label:setAlpha( 1 )
				self.clipFinished( self.label, {} )

				self.numeric:completeAnimation()
				self.numeric:setAlpha( 1 )
				self.clipFinished( self.numeric, {} )

				self.FilledPartBg:completeAnimation()
				self.FilledPartBg:setLeftRight( true, false, 254.41, 434.41 )
				self.FilledPartBg:setTopBottom( false, false, -0.5, 0.5 )
				self.FilledPartBg:setAlpha( 0 )
				self.clipFinished( self.FilledPartBg, {} )

				self.FilledPart:completeAnimation()
				CoD.UIColors.SetElementColor( self.FilledPart, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.clipFinished( self.FilledPart, {} )

				self.FocusBarT:completeAnimation()
				self.FocusBarT:setLeftRight( true, true, 0, 0 )
				self.FocusBarT:setTopBottom( true, false, 0, 5.5 )
				self.FocusBarT:setAlpha( 1 )
				self.clipFinished( self.FocusBarT, {} )

				self.FocusBarB:completeAnimation()
				self.FocusBarB:setLeftRight( true, true, 0, 0 )
				self.FocusBarB:setTopBottom( false, true, -5.5, 0 )
				self.FocusBarB:setAlpha( 1 )
				self.clipFinished( self.FocusBarB, {} )

				self.FETitleNumBrdr0:completeAnimation()
				self.FETitleNumBrdr0:setLeftRight( true, true, 252.41, -60.59 )
				self.FETitleNumBrdr0:setTopBottom( true, true, 15.5, -15.5 )
				self.FETitleNumBrdr0:setAlpha( 1 )
				self.clipFinished( self.FETitleNumBrdr0, {} )

				self.Bar:completeAnimation()
				CoD.UIColors.SetElementColor( self.Bar, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.clipFinished( self.Bar, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.frameOutline:close()
		element.StartMenuframenoBG00:close()
		element.FocusBarT:close()
		element.FocusBarB:close()
		element.FETitleNumBrdr0:close()
		element.Bar:close()
		element.label:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end