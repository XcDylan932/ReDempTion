require( "ui.uieditor.widgets.HUD.UIColors" )
require( "ui.uieditor.util.PCUtil_Options" )
require( "ui.uieditor.widgets.Lobby.Common.FE_HelpItemsLabel" )

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        local elements = { self.FEButtonIdle, self.FEButtonFocus, self.Glow, self.btnDisplayText, self.Glow2, self.Arrow }
        for _, element in ipairs( elements ) do
            if element then
                CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
            end
        end
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
    self:UpdateColors()
end

CoD.List1ButtonLarge_PH = InheritFrom( LUI.UIElement )
CoD.List1ButtonLarge_PH.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.List1ButtonLarge_PH )
	self.id = "List1ButtonLarge_PH"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 280 )
	self:setTopBottom( true, false, 0, 32 )
	self:makeFocusable()
	self:setHandleMouse( true )
	self.anyChildUsesUpdateState = true
	
	self.FEButtonIdle = LUI.UIImage.new()
	self.FEButtonIdle:setLeftRight( true, true, -1, 1 )
	self.FEButtonIdle:setTopBottom( false, false, -16, 16 )
	self.FEButtonIdle:setAlpha( 0.8 )
	self.FEButtonIdle:setZoom( 10 )
	self.FEButtonIdle:setImage( RegisterImage( "uie_t7_menu_frontend_buttonidlefull" ) )
	self.FEButtonIdle:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_nineslice_add" ) )
	self.FEButtonIdle:setShaderVector( 0, 0.03, 0.25, 0, 0 )
	self.FEButtonIdle:setupNineSliceShader( 8, 8 )
	self:addElement( self.FEButtonIdle )
	
	self.FEButtonFocus = LUI.UIImage.new()
	self.FEButtonFocus:setLeftRight( true, true, -8, 8 )
	self.FEButtonFocus:setTopBottom( false, false, -20, 20 )
	self.FEButtonFocus:setAlpha( 0 )
	self.FEButtonFocus:setZoom( 10 )
	self.FEButtonFocus:setImage( RegisterImage( "uie_t7_menu_frontend_buttonfocusfull" ) )
	self.FEButtonFocus:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_nineslice_add" ) )
	self.FEButtonFocus:setShaderVector( 0, 0.2, 0.5, 0.38, 0.2 )
	self.FEButtonFocus:setupNineSliceShader( 60, 20 )
	self:addElement( self.FEButtonFocus )
	
	self.Glow = LUI.UIImage.new()
	self.Glow:setLeftRight( true, true, -41, 56 )
	self.Glow:setTopBottom( true, false, -23, 54 )
	self.Glow:setRGB( 0.88, 1, 0.04 )
	self.Glow:setAlpha( 0 )
	self.Glow:setImage( RegisterImage( "uie_t7_cp_hud_enemytarget_glow" ) )
	self.Glow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Glow )
	
	self.btnDisplayText = LUI.UIText.new()
	self.btnDisplayText:setLeftRight( true, false, 12, 284 )
	self.btnDisplayText:setTopBottom( true, false, 7, 27 )
	self.btnDisplayText:setRGB( 0.79, 0.79, 0.79 )
	self.btnDisplayText:setAlpha( 0 )
	self.btnDisplayText:setZoom( 10 )
	self.btnDisplayText:setTTF( "fonts/escom.ttf" )
	self.btnDisplayText:setLetterSpacing( 1 )
	self.btnDisplayText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.btnDisplayText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	LUI.OverrideFunction_CallOriginalFirst( self.btnDisplayText, "setText", function( element, controller )
		ScaleWidgetToLabel( self, element, 0 )
	end )
	self:addElement( self.btnDisplayText )
	
	self.btnDisplayTextStroke = LUI.UIText.new()
	self.btnDisplayTextStroke:setLeftRight( true, false, 12, 284 )
	self.btnDisplayTextStroke:setTopBottom( true, false, 7, 27 )
	self.btnDisplayTextStroke:setRGB( 0, 0, 0 )
	self.btnDisplayTextStroke:setAlpha( 0.7 )
	self.btnDisplayTextStroke:setZoom( 10 )
	self.btnDisplayTextStroke:setTTF( "fonts/escom.ttf" )
	self.btnDisplayTextStroke:setMaterial( LUI.UIImage.GetCachedMaterial( "sw4_2d_uie_font_cached_glow" ) )
	self.btnDisplayTextStroke:setShaderVector( 0, 0.08, 0, 0, 0 )
	self.btnDisplayTextStroke:setShaderVector( 1, 0, 0, 0, 0 )
	self.btnDisplayTextStroke:setShaderVector( 2, 1, 0, 0, 0 )
	self.btnDisplayTextStroke:setLetterSpacing( 1 )
	self.btnDisplayTextStroke:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.btnDisplayTextStroke:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	LUI.OverrideFunction_CallOriginalFirst( self.btnDisplayTextStroke, "setText", function ( element, controller )
		TrimLabelIfLanguageReversed( self, element )
	end )
	self:addElement( self.btnDisplayTextStroke )
	
	self.FEHelpItemsLabel0 = CoD.FE_HelpItemsLabel.new( menu, controller )
	self.FEHelpItemsLabel0:setLeftRight( false, true, 0, 20 )
	self.FEHelpItemsLabel0:setTopBottom( false, false, -10, 10 )
	self:addElement( self.FEHelpItemsLabel0 )
	
	self.Arrow = LUI.UIImage.new()
	self.Arrow:setLeftRight( true, false, -20, -12 )
	self.Arrow:setTopBottom( true, false, 12, 20 )
	self.Arrow:setAlpha( 0 )
	self.Arrow:setZoom( 10 )
	self.Arrow:setImage( RegisterImage( "uie_t7_menu_frontend_buttonfocusarrow" ) )
	self.Arrow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Arrow )
	
	self.Glow2 = LUI.UIImage.new()
	self.Glow2:setLeftRight( true, true, -29, 49 )
	self.Glow2:setTopBottom( true, false, -24.29, 58.12 )
	self.Glow2:setAlpha( 0 )
	self.Glow2:setImage( RegisterImage( "uie_t7_cp_hud_enemytarget_glow" ) )
	self.Glow2:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
    self.Glow2:setRGB( 0, 0, 1 )
	self:addElement( self.Glow2 )
	
	self.btnDisplayText:linkToElementModel( self, "displayText", true, function ( model )
		local displayText = Engine.GetModelValue( model )
		if displayText then
			self.btnDisplayText:setText( Engine.Localize( LocalizeToUpperString( displayText ) ) )
		end
	end )

	self.btnDisplayTextStroke:linkToElementModel( self, "displayText", true, function ( model )
		local displayText = Engine.GetModelValue( model )
		if displayText then
			self.btnDisplayTextStroke:setText( Engine.Localize( LocalizeToUpperString( displayText ) ) )
		end
	end )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.FEButtonIdle:completeAnimation()
				self.FEButtonIdle:setAlpha( 1 )
				self.FEButtonIdle:setZoom( 0 )
				self.clipFinished( self.FEButtonIdle, {} )

				self.FEButtonFocus:completeAnimation()
				self.FEButtonFocus:setLeftRight( true, true, -8, 8 )
				self.FEButtonFocus:setTopBottom( false, false, -7, 8 )
				self.FEButtonFocus:setAlpha( 0 )
				self.FEButtonFocus:setZoom( 0 )
				self.clipFinished( self.FEButtonFocus, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				self.clipFinished( self.Glow, {} )

				self.btnDisplayText:completeAnimation()
				self.btnDisplayText:setAlpha( 1 )
				self.btnDisplayText:setZoom( 0 )
				self.clipFinished( self.btnDisplayText, {} )

				self.btnDisplayTextStroke:completeAnimation()
				self.btnDisplayTextStroke:setAlpha( 0 )
				self.btnDisplayTextStroke:setZoom( 0 )
				self.clipFinished( self.btnDisplayTextStroke, {} )

				self.FEHelpItemsLabel0:completeAnimation()
				self.FEHelpItemsLabel0:setAlpha( 1 )
				self.clipFinished( self.FEHelpItemsLabel0, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setLeftRight( true, false, 3, 11 )
				self.Arrow:setTopBottom( true, false, 12, 20 )
				self.Arrow:setAlpha( 0 )
				self.clipFinished( self.Arrow, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )
			end,

			Focus = function ()
				self:setupElementClipCounter( 7 )

				self.FEButtonIdle:completeAnimation()
				self.FEButtonIdle:setAlpha( 0 )
				self.FEButtonIdle:setZoom( 10 )
				self.clipFinished( self.FEButtonIdle, {} )

				self.FEButtonFocus:completeAnimation()
				self.FEButtonFocus:setLeftRight( true, true, -8, 8 )
				self.FEButtonFocus:setTopBottom( false, false, -20, 20 )
				self.FEButtonFocus:setAlpha( 1 )
				self.FEButtonFocus:setZoom( 10 )
				self.clipFinished( self.FEButtonFocus, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0.45 )
				self.clipFinished( self.Glow, {} )

				self.btnDisplayText:completeAnimation()
				self.btnDisplayText:setAlpha( 0 )
				self.btnDisplayText:setZoom( -305 )
				self.clipFinished( self.btnDisplayText, {} )

				self.btnDisplayTextStroke:completeAnimation()
				self.btnDisplayTextStroke:setAlpha( 1 )
				self.btnDisplayTextStroke:setZoom( 10 )
				self.clipFinished( self.btnDisplayTextStroke, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setLeftRight( true, false, -20, -12 )
				self.Arrow:setTopBottom( true, false, 12, 20 )
				self.Arrow:setAlpha( 1 )
				self.clipFinished( self.Arrow, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 1 )
				self.clipFinished( self.Glow2, {} )
			end,

			LoseFocus = function ()
				self:setupElementClipCounter( 7 )

				local FEButtonIdleFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 1 )
					element:setZoom( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.FEButtonIdle:completeAnimation()
				self.FEButtonIdle:setAlpha( 0 )
				self.FEButtonIdle:setZoom( 10 )
				FEButtonIdleFrame2( self.FEButtonIdle, {} )

				local FEButtonFocusFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, true, -8, 8 )
					element:setTopBottom( false, false, -20, 20 )
					element:setAlpha( 0 )
					element:setZoom( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.FEButtonFocus:completeAnimation()
				self.FEButtonFocus:setLeftRight( true, true, -8, 8 )
				self.FEButtonFocus:setTopBottom( false, false, -20, 20 )
				self.FEButtonFocus:setAlpha( 1 )
				self.FEButtonFocus:setZoom( 10 )
				FEButtonFocusFrame2( self.FEButtonFocus, {} )

				local GlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0.45 )
				GlowFrame2( self.Glow, {} )

				local btnDisplayTextFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 1 )
					element:setZoom( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.btnDisplayText:completeAnimation()
				self.btnDisplayText:setAlpha( 0 )
				self.btnDisplayText:setZoom( 10 )
				btnDisplayTextFrame2( self.btnDisplayText, {} )

				local btnDisplayTextStrokeFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					element:setZoom( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.btnDisplayTextStroke:completeAnimation()
				self.btnDisplayTextStroke:setAlpha( 1 )
				self.btnDisplayTextStroke:setZoom( 10 )
				btnDisplayTextStrokeFrame2( self.btnDisplayTextStroke, {} )

				local ArrowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 3, 11 )
					element:setTopBottom( true, false, 12, 20 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Arrow:completeAnimation()
				self.Arrow:setLeftRight( true, false, -20, -12 )
				self.Arrow:setTopBottom( true, false, 12, 20 )
				self.Arrow:setAlpha( 1 )
				ArrowFrame2( self.Arrow, {} )

				local Glow2Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 1 )
				Glow2Frame2( self.Glow2, {} )
			end,

			GainFocus = function ()
				self:setupElementClipCounter( 7 )

				local FEButtonIdleFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					element:setZoom( 10 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.FEButtonIdle:completeAnimation()
				self.FEButtonIdle:setAlpha( 1 )
				self.FEButtonIdle:setZoom( 0 )
				FEButtonIdleFrame2( self.FEButtonIdle, {} )

				local FEButtonFocusFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, true, -8, 8 )
					element:setTopBottom( false, false, -20, 20 )
					element:setAlpha( 1 )
					element:setZoom( 10 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.FEButtonFocus:completeAnimation()
				self.FEButtonFocus:setLeftRight( true, true, -8, 8 )
				self.FEButtonFocus:setTopBottom( false, false, -20, 20 )
				self.FEButtonFocus:setAlpha( 0 )
				self.FEButtonFocus:setZoom( 0 )
				FEButtonFocusFrame2( self.FEButtonFocus, {} )

				local GlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0.45 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				GlowFrame2( self.Glow, {} )

				local btnDisplayTextFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					element:setZoom( 10 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.btnDisplayText:completeAnimation()
				self.btnDisplayText:setAlpha( 1 )
				self.btnDisplayText:setZoom( 0 )
				btnDisplayTextFrame2( self.btnDisplayText, {} )

				local btnDisplayTextStrokeFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 1 )
					element:setZoom( 10 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.btnDisplayTextStroke:completeAnimation()
				self.btnDisplayTextStroke:setAlpha( 0 )
				self.btnDisplayTextStroke:setZoom( 0 )
				btnDisplayTextStrokeFrame2( self.btnDisplayTextStroke, {} )

				local ArrowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, -20, -12 )
					element:setTopBottom( true, false, 12, 20 )
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Arrow:completeAnimation()
				self.Arrow:setLeftRight( true, false, 3, 11 )
				self.Arrow:setTopBottom( true, false, 12, 20 )
				self.Arrow:setAlpha( 0 )
				ArrowFrame2( self.Arrow, {} )

				local Glow2Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				Glow2Frame2( self.Glow2, {} )
			end,

			Intro = function ()
				self:setupElementClipCounter( 8 )

				local FEButtonIdleFrame2 = function ( element, event )
					local FEButtonIdleFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 239, false, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 1 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						FEButtonIdleFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", FEButtonIdleFrame3 )
					end
				end
				
				self.FEButtonIdle:completeAnimation()
				self.FEButtonIdle:setAlpha( 0 )
				self.FEButtonIdle:setZoom( 0 )
				FEButtonIdleFrame2( self.FEButtonIdle, {} )

				self.FEButtonFocus:completeAnimation()
				self.FEButtonFocus:setLeftRight( true, true, -8, 8 )
				self.FEButtonFocus:setTopBottom( false, false, -7, 8 )
				self.FEButtonFocus:setAlpha( 0 )
				self.FEButtonFocus:setZoom( 0 )
				self.clipFinished( self.FEButtonFocus, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				self.clipFinished( self.Glow, {} )

				local btnDisplayTextFrame2 = function ( element, event )
					local btnDisplayTextFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 299, false, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 1 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						btnDisplayTextFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 119, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", btnDisplayTextFrame3 )
					end
				end
				
				self.btnDisplayText:completeAnimation()
				self.btnDisplayText:setAlpha( 0 )
				self.btnDisplayText:setZoom( 0 )
				btnDisplayTextFrame2( self.btnDisplayText, {} )

				self.btnDisplayTextStroke:completeAnimation()
				self.btnDisplayTextStroke:setAlpha( 0 )
				self.btnDisplayTextStroke:setZoom( 0 )
				self.clipFinished( self.btnDisplayTextStroke, {} )

				local FEHelpItemsLabel0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.FEHelpItemsLabel0:completeAnimation()
				self.FEHelpItemsLabel0:setAlpha( 0 )
				FEHelpItemsLabel0Frame2( self.FEHelpItemsLabel0, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setLeftRight( true, false, 3, 11 )
				self.Arrow:setTopBottom( true, false, 12, 20 )
				self.Arrow:setAlpha( 0 )
				self.clipFinished( self.Arrow, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )
			end
		},

		Disabled = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.FEButtonIdle:completeAnimation()
				self.FEButtonIdle:setAlpha( 0.3 )
				self.FEButtonIdle:setZoom( 0 )
				self.clipFinished( self.FEButtonIdle, {} )

				self.FEButtonFocus:completeAnimation()
				self.FEButtonFocus:setLeftRight( true, true, -8, 8 )
				self.FEButtonFocus:setTopBottom( false, false, -7, 8 )
				self.FEButtonFocus:setAlpha( 0 )
				self.FEButtonFocus:setZoom( 0 )
				self.clipFinished( self.FEButtonFocus, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				self.clipFinished( self.Glow, {} )

				self.btnDisplayText:completeAnimation()
				self.btnDisplayText:setAlpha( 0.1 )
				self.btnDisplayText:setZoom( 0 )
				self.clipFinished( self.btnDisplayText, {} )

				self.btnDisplayTextStroke:completeAnimation()
				self.btnDisplayTextStroke:setAlpha( 0 )
				self.btnDisplayTextStroke:setZoom( 0 )
				self.clipFinished( self.btnDisplayTextStroke, {} )

				self.FEHelpItemsLabel0:completeAnimation()
				self.FEHelpItemsLabel0:setAlpha( 1 )
				self.clipFinished( self.FEHelpItemsLabel0, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setLeftRight( true, false, 3, 11 )
				self.Arrow:setTopBottom( true, false, 12, 20 )
				self.Arrow:setAlpha( 0 )
				self.clipFinished( self.Arrow, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )
			end,

			Intro = function ()
				self:setupElementClipCounter( 8 )

				local FEButtonIdleFrame2 = function ( element, event )
					local FEButtonIdleFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 0.3 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						FEButtonIdleFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", FEButtonIdleFrame3 )
					end
				end
				
				self.FEButtonIdle:completeAnimation()
				self.FEButtonIdle:setAlpha( 0 )
				self.FEButtonIdle:setZoom( 0 )
				FEButtonIdleFrame2( self.FEButtonIdle, {} )

				self.FEButtonFocus:completeAnimation()
				self.FEButtonFocus:setLeftRight( true, true, -8, 8 )
				self.FEButtonFocus:setTopBottom( false, false, -7, 8 )
				self.FEButtonFocus:setAlpha( 0 )
				self.FEButtonFocus:setZoom( 0 )
				self.clipFinished( self.FEButtonFocus, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				self.clipFinished( self.Glow, {} )

				local btnDisplayTextFrame2 = function ( element, event )
					local btnDisplayTextFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 0.1 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						btnDisplayTextFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", btnDisplayTextFrame3 )
					end
				end
				
				self.btnDisplayText:completeAnimation()
				self.btnDisplayText:setAlpha( 0 )
				self.btnDisplayText:setZoom( 0 )
				btnDisplayTextFrame2( self.btnDisplayText, {} )

				self.btnDisplayTextStroke:completeAnimation()
				self.btnDisplayTextStroke:setAlpha( 0 )
				self.btnDisplayTextStroke:setZoom( 0 )
				self.clipFinished( self.btnDisplayTextStroke, {} )

				local FEHelpItemsLabel0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.FEHelpItemsLabel0:completeAnimation()
				self.FEHelpItemsLabel0:setAlpha( 0 )
				FEHelpItemsLabel0Frame2( self.FEHelpItemsLabel0, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setLeftRight( true, false, 3, 11 )
				self.Arrow:setTopBottom( true, false, 12, 20 )
				self.Arrow:setAlpha( 0 )
				self.clipFinished( self.Arrow, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )
			end
		},

		Fake = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.FEButtonIdle:completeAnimation()
				self.FEButtonIdle:setAlpha( 0 )
				self.clipFinished( self.FEButtonIdle, {} )

				self.FEButtonFocus:completeAnimation()
				self.FEButtonFocus:setAlpha( 0 )
				self.clipFinished( self.FEButtonFocus, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				self.clipFinished( self.Glow, {} )

				self.btnDisplayText:completeAnimation()
				self.btnDisplayText:setAlpha( 0 )
				self.clipFinished( self.btnDisplayText, {} )

				self.btnDisplayTextStroke:completeAnimation()
				self.btnDisplayTextStroke:setAlpha( 0 )
				self.clipFinished( self.btnDisplayTextStroke, {} )

				self.FEHelpItemsLabel0:completeAnimation()
				self.FEHelpItemsLabel0:setAlpha( 0 )
				self.clipFinished( self.FEHelpItemsLabel0, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setAlpha( 0 )
				self.clipFinished( self.Arrow, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )
			end,

			Focus = function ()
				self:setupElementClipCounter( 8 )

				self.FEButtonIdle:completeAnimation()
				self.FEButtonIdle:setAlpha( 0 )
				self.clipFinished( self.FEButtonIdle, {} )

				self.FEButtonFocus:completeAnimation()
				self.FEButtonFocus:setAlpha( 0 )
				self.clipFinished( self.FEButtonFocus, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				self.clipFinished( self.Glow, {} )

				self.btnDisplayText:completeAnimation()
				self.btnDisplayText:setAlpha( 0 )
				self.clipFinished( self.btnDisplayText, {} )

				self.btnDisplayTextStroke:completeAnimation()
				self.btnDisplayTextStroke:setAlpha( 0 )
				self.clipFinished( self.btnDisplayTextStroke, {} )

				self.FEHelpItemsLabel0:completeAnimation()
				self.FEHelpItemsLabel0:setAlpha( 0 )
				self.clipFinished( self.FEHelpItemsLabel0, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setAlpha( 0 )
				self.clipFinished( self.Arrow, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )
			end
		},

		DisabledHelpItemsLabel = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.FEButtonIdle:completeAnimation()
				self.FEButtonIdle:setAlpha( 0.3 )
				self.FEButtonIdle:setZoom( 0 )
				self.clipFinished( self.FEButtonIdle, {} )

				self.FEButtonFocus:completeAnimation()
				self.FEButtonFocus:setLeftRight( true, true, -8, 8 )
				self.FEButtonFocus:setTopBottom( false, false, -7, 8 )
				self.FEButtonFocus:setAlpha( 0 )
				self.FEButtonFocus:setZoom( 0 )
				self.clipFinished( self.FEButtonFocus, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				self.clipFinished( self.Glow, {} )

				self.btnDisplayText:completeAnimation()
				self.btnDisplayText:setAlpha( 0.1 )
				self.btnDisplayText:setZoom( 0 )
				self.clipFinished( self.btnDisplayText, {} )

				self.btnDisplayTextStroke:completeAnimation()
				self.btnDisplayTextStroke:setAlpha( 0 )
				self.btnDisplayTextStroke:setZoom( 0 )
				self.clipFinished( self.btnDisplayTextStroke, {} )

				self.FEHelpItemsLabel0:completeAnimation()
				self.FEHelpItemsLabel0:setAlpha( 0 )
				self.clipFinished( self.FEHelpItemsLabel0, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setLeftRight( true, false, 3, 11 )
				self.Arrow:setTopBottom( true, false, 12, 20 )
				self.Arrow:setAlpha( 0 )
				self.clipFinished( self.Arrow, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )
			end,

			Intro = function ()
				self:setupElementClipCounter( 8 )

				local FEButtonIdleFrame2 = function ( element, event )
					local FEButtonIdleFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 0.3 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						FEButtonIdleFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", FEButtonIdleFrame3 )
					end
				end
				
				self.FEButtonIdle:completeAnimation()
				self.FEButtonIdle:setAlpha( 0 )
				self.FEButtonIdle:setZoom( 0 )
				FEButtonIdleFrame2( self.FEButtonIdle, {} )

				self.FEButtonFocus:completeAnimation()
				self.FEButtonFocus:setLeftRight( true, true, -8, 8 )
				self.FEButtonFocus:setTopBottom( false, false, -7, 8 )
				self.FEButtonFocus:setAlpha( 0 )
				self.FEButtonFocus:setZoom( 0 )
				self.clipFinished( self.FEButtonFocus, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				self.clipFinished( self.Glow, {} )

				local btnDisplayTextFrame2 = function ( element, event )
					local btnDisplayTextFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 0.1 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						btnDisplayTextFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", btnDisplayTextFrame3 )
					end
				end
				
				self.btnDisplayText:completeAnimation()
				self.btnDisplayText:setAlpha( 0 )
				self.btnDisplayText:setZoom( 0 )
				btnDisplayTextFrame2( self.btnDisplayText, {} )

				self.btnDisplayTextStroke:completeAnimation()
				self.btnDisplayTextStroke:setAlpha( 0 )
				self.btnDisplayTextStroke:setZoom( 0 )
				self.clipFinished( self.btnDisplayTextStroke, {} )

				local FEHelpItemsLabel0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.FEHelpItemsLabel0:completeAnimation()
				self.FEHelpItemsLabel0:setAlpha( 0 )
				FEHelpItemsLabel0Frame2( self.FEHelpItemsLabel0, {} )

				self.Arrow:completeAnimation()
				self.Arrow:setLeftRight( true, false, 3, 11 )
				self.Arrow:setTopBottom( true, false, 12, 20 )
				self.Arrow:setAlpha( 0 )
				self.clipFinished( self.Arrow, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Disabled",
			condition = function ( menu, element, event )
				return IsDisabled( element, controller ) and not PropertyIsTrue( self, "hideHelpItemLabel" )
			end
		},
		{
			stateName = "Fake",
			condition = function ( menu, element, event )
				return PropertyIsTrue( self, "fake" )
			end
		},
		{
			stateName = "DisabledHelpItemsLabel",
			condition = function ( menu, element, event )
				return IsDisabled( element, controller ) and PropertyIsTrue( self, "hideHelpItemLabel" )
			end
		}
	} )

	self:linkToElementModel( self, "disabled", true, function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "disabled" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.FEHelpItemsLabel0:close()
		element.btnDisplayText:close()
		element.btnDisplayTextStroke:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end