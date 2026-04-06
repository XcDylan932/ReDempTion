require( "ui.uieditor.widgets.GameSettings.GameSettings_ChangedIndicator" )
require( "ui.uieditor.widgets.CAC.NewBreadcrumbCount" )

local PostLoadFunc = function ( self, controller )
    self.getWidthInList = function ( element )
        local width = 0
        local extraPadding = 50
        
        if element.currentState == "NavButton" then
            width = element.buttonText:getTextWidth()
        else
            width = element.text:getTextWidth()
        end
        
        return width + extraPadding
    end

    self:setHandleMouse( true )

    self.UpdateColors = function( self )
        local colorValue = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]
        
        if colorValue then
            CoD.UIColors.SetElementColor( self.FETabFocus, colorValue )
            CoD.UIColors.SetElementColor( self.Glow2, colorValue )
            CoD.UIColors.SetElementColor( self.glitch, colorValue )
            CoD.UIColors.SetElementColor( self.glitch2, colorValue )
            
            if self.currentState ~= "Active" then
                CoD.UIColors.SetElementColor( self.text, colorValue )
            end
        end
    end

    LUI.OverrideFunction_CallOriginalFirst( self, "setState", function( element, stateName )
        element.currentState = stateName
        element:UpdateColors()
    end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "colorUpdate" ), function( model )
        self:UpdateColors()
    end )
    
    self:UpdateColors()
end

CoD.paintshopTabWidget = InheritFrom( LUI.UIElement )
CoD.paintshopTabWidget.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.paintshopTabWidget )
	self.id = "paintshopTabWidget"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 200 )
	self:setTopBottom( true, false, 0, 38 )
	self.anyChildUsesUpdateState = true
	
	self.FETabFocus = LUI.UIImage.new()
	self.FETabFocus:setLeftRight( true, true, -2, 2 )
	self.FETabFocus:setTopBottom( true, true, -5, 5 )
	self.FETabFocus:setAlpha( 0 )
	self.FETabFocus:setImage( RegisterImage( "uie_t7_menu_cac_buttontabfocusfull" ) )
	self.FETabFocus:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_nineslice_add" ) )
	self.FETabFocus:setShaderVector( 0, 0.47, 0.5, 0.42, 0.33 )
	self.FETabFocus:setupNineSliceShader( 96, 24 )
	self:addElement( self.FETabFocus )
	
	self.FETabIdle = LUI.UIImage.new()
	self.FETabIdle:setLeftRight( true, true, -1, 1 )
	self.FETabIdle:setTopBottom( true, true, -2, 2 )
	self.FETabIdle:setImage( RegisterImage( "uie_t7_menu_cac_buttontabidlefull" ) )
	self.FETabIdle:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_nineslice_add" ) )
	self.FETabIdle:setShaderVector( 0, 0.04, 0.19, 0, 0 )
	self.FETabIdle:setupNineSliceShader( 8, 8 )
	self:addElement( self.FETabIdle )
	
	self.Glow2 = LUI.UIImage.new()
	self.Glow2:setLeftRight( true, true, -82, 104 )
	self.Glow2:setTopBottom( true, false, -23.29, 58.12 )
	self.Glow2:setRGB( 0.91, 1, 0 )
	self.Glow2:setAlpha( 0 )
	self.Glow2:setImage( RegisterImage( "uie_t7_cp_hud_enemytarget_glow" ) )
	self.Glow2:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Glow2 )
	
	self.text = LUI.UIText.new()
	self.text:setLeftRight( true, true, 0, 0 )
	self.text:setTopBottom( false, false, -9, 12 )
	self.text:setAlpha( 0.7 )
	self.text:setTTF( "fonts/escom.ttf" )
	self.text:setLetterSpacing( 2 )
	self.text:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.text:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self.text:linkToElementModel( self, "tabName", true, function ( model )
		local tabName = Engine.GetModelValue( model )
		if tabName then
			self.text:setText( Engine.Localize( tabName ) )
		end
	end )
	self:addElement( self.text )
	
	self.textDark = LUI.UIText.new()
	self.textDark:setLeftRight( true, true, 0, 0 )
	self.textDark:setTopBottom( false, false, -9, 12 )
	self.textDark:setRGB( 0, 0, 0 )
	self.textDark:setAlpha( 0 )
	self.textDark:setTTF( "fonts/escom.ttf" )
	self.textDark:setMaterial( LUI.UIImage.GetCachedMaterial( "sw4_2d_uie_font_cached_glow" ) )
	self.textDark:setShaderVector( 0, 0.08, 0, 0, 0 )
	self.textDark:setShaderVector( 1, 0, 0, 0, 0 )
	self.textDark:setShaderVector( 2, 1, 0, 0, 0 )
	self.textDark:setLetterSpacing( 2 )
	self.textDark:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.textDark:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self.textDark:linkToElementModel( self, "tabName", true, function ( model )
		local tabName = Engine.GetModelValue( model )
		if tabName then
			self.textDark:setText( Engine.Localize( tabName ) )
		end
	end )
	self:addElement( self.textDark )
	
	self.glitch = LUI.UIImage.new()
	self.glitch:setLeftRight( true, true, 0, 0 )
	self.glitch:setTopBottom( true, true, 0, 0 )
	self.glitch:setRGB( 1, 0.38, 0 )
	self.glitch:setAlpha( 0 )
	self.glitch:setImage( RegisterImage( "uie_t7_effect_glitches_menu10" ) )
	self.glitch:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.glitch )
	
	self.glitch2 = LUI.UIImage.new()
	self.glitch2:setLeftRight( true, true, 0, 0 )
	self.glitch2:setTopBottom( true, true, 0, 0 )
	self.glitch2:setRGB( 1, 0.38, 0 )
	self.glitch2:setAlpha( 0 )
	self.glitch2:setImage( RegisterImage( "uie_t7_effect_glitches_menu8" ) )
	self.glitch2:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.glitch2 )
	
	self.buttonText = LUI.UIText.new()
	self.buttonText:setLeftRight( true, true, 4, -4 )
	self.buttonText:setTopBottom( false, false, -14, 15 )
	self.buttonText:setAlpha( 0 )
	self.buttonText:setTTF( "fonts/escom.ttf" )
	self.buttonText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.buttonText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self.buttonText:linkToElementModel( self, "tabIcon", true, function ( model )
		local tabIcon = Engine.GetModelValue( model )
		if tabIcon then
			self.buttonText:setText( Engine.Localize( tabIcon ) )
		end
	end )
	self:addElement( self.buttonText )
	
	self.GameSettingsChangedIndicator = CoD.GameSettings_ChangedIndicator.new( menu, controller )
	self.GameSettingsChangedIndicator:setLeftRight( true, false, 4, 34 )
	self.GameSettingsChangedIndicator:setTopBottom( true, false, -15, 15 )
	self.GameSettingsChangedIndicator:linkToElementModel( self, nil, false, function ( model )
		self.GameSettingsChangedIndicator:setModel( model, controller )
	end )
	self:addElement( self.GameSettingsChangedIndicator )
	
	self.breadcrumbCount = CoD.NewBreadcrumbCount.new( menu, controller )
	self.breadcrumbCount:setLeftRight( false, true, -22, -4 )
	self.breadcrumbCount:setTopBottom( true, false, -5, 13 )
	self.breadcrumbCount:linkToElementModel( self, nil, false, function ( model )
		self.breadcrumbCount:setModel( model, controller )
	end )
	self.breadcrumbCount:linkToElementModel( self, "breadcrumbCount", true, function ( model )
		local _breadcrumbCount = Engine.GetModelValue( model )
		if _breadcrumbCount then
			self.breadcrumbCount.countText:setText( Engine.Localize( _breadcrumbCount ) )
		end
	end )
	self.breadcrumbCount:mergeStateConditions( {
		{
			stateName = "Visible",
			condition = function ( menu, element, event )
				return IsSelfModelValueGreaterThan( element, controller, "breadcrumbCount", 0 )
			end
		}
	} )
	self.breadcrumbCount:linkToElementModel( self.breadcrumbCount, "breadcrumbCount", true, function ( model )
		menu:updateElementState( self.breadcrumbCount, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( model ),
			modelName = "breadcrumbCount"
		} )
	end )
	self:addElement( self.breadcrumbCount )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.FETabFocus:completeAnimation()
				self.FETabFocus:setAlpha( 0 )
				self.clipFinished( self.FETabFocus, {} )

				self.FETabIdle:completeAnimation()
				self.FETabIdle:setAlpha( 1 )
				self.clipFinished( self.FETabIdle, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )

				self.text:completeAnimation()
				self.text:setAlpha( 0.7 )
				self.clipFinished( self.text, {} )

				self.textDark:completeAnimation()
				self.textDark:setLeftRight( true, true, 0, 0 )
				self.textDark:setTopBottom( false, false, -9, 12 )
				self.textDark:setAlpha( 0 )
				self.clipFinished( self.textDark, {} )

				self.glitch:completeAnimation()
				self.glitch:setAlpha( 0 )
				self.clipFinished( self.glitch, {} )

				self.glitch2:completeAnimation()
				self.glitch2:setAlpha( 0 )
				self.clipFinished( self.glitch2, {} )

				self.buttonText:completeAnimation()
				self.buttonText:setAlpha( 0 )
				self.clipFinished( self.buttonText, {} )
			end,

			Active = function ()
				self:setupElementClipCounter( 7 )

				self.FETabFocus:completeAnimation()
				self.FETabFocus:setAlpha( 1 )
				self.clipFinished( self.FETabFocus, {} )

				self.FETabIdle:completeAnimation()
				self.FETabIdle:setAlpha( 0 )
				self.clipFinished( self.FETabIdle, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 1 )
				self.clipFinished( self.Glow2, {} )

				self.text:completeAnimation()
				self.text:setAlpha( 0 )
				self.clipFinished( self.text, {} )

				self.textDark:completeAnimation()
				self.textDark:setAlpha( 1 )
				self.clipFinished( self.textDark, {} )

				self.glitch:completeAnimation()
				self.glitch:setAlpha( 0 )
				self.clipFinished( self.glitch, {} )

				self.glitch2:completeAnimation()
				self.glitch2:setAlpha( 0 )
				self.clipFinished( self.glitch2, {} )
			end,

			GainActive = function ()
				self:setupElementClipCounter( 7 )

				local FETabFocusFrame2 = function ( element, event )
					local FETabFocusFrame3 = function ( element, event )
						local FETabFocusFrame4 = function ( element, event )
							local FETabFocusFrame5 = function ( element, event )
								local FETabFocusFrame6 = function ( element, event )
									if not event.interrupted then
										element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
									end
									element:setAlpha( 1 )
									if event.interrupted then
										self.clipFinished( element, event )
									else
										element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
									end
								end
								
								if event.interrupted then
									FETabFocusFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.7 )
									element:registerEventHandler( "transition_complete_keyframe", FETabFocusFrame6 )
								end
							end
							
							if event.interrupted then
								FETabFocusFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0 )
								element:registerEventHandler( "transition_complete_keyframe", FETabFocusFrame5 )
							end
						end
						
						if event.interrupted then
							FETabFocusFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.32 )
							element:registerEventHandler( "transition_complete_keyframe", FETabFocusFrame4 )
						end
					end
					
					if event.interrupted then
						FETabFocusFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", FETabFocusFrame3 )
					end
				end
				
				self.FETabFocus:completeAnimation()
				self.FETabFocus:setAlpha( 0.37 )
				FETabFocusFrame2( self.FETabFocus, {} )

				self.FETabIdle:completeAnimation()
				self.FETabIdle:setAlpha( 0 )
				self.clipFinished( self.FETabIdle, {} )

				local Glow2Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 1 )
				Glow2Frame2( self.Glow2, {} )

				self.text:completeAnimation()
				self.text:setAlpha( 0 )
				self.clipFinished( self.text, {} )

				local textDarkFrame2 = function ( element, event )
					local textDarkFrame3 = function ( element, event )
						local textDarkFrame4 = function ( element, event )
							local textDarkFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 1 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								textDarkFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", textDarkFrame5 )
							end
						end
						
						if event.interrupted then
							textDarkFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.09 )
							element:registerEventHandler( "transition_complete_keyframe", textDarkFrame4 )
						end
					end
					
					if event.interrupted then
						textDarkFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", textDarkFrame3 )
					end
				end
				
				self.textDark:completeAnimation()
				self.textDark:setAlpha( 0 )
				textDarkFrame2( self.textDark, {} )

				local glitchFrame2 = function ( element, event )
					local glitchFrame3 = function ( element, event )
						local glitchFrame4 = function ( element, event )
							local glitchFrame5 = function ( element, event )
								local glitchFrame6 = function ( element, event )
									local glitchFrame7 = function ( element, event )
										if not event.interrupted then
											element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
										end
										element:setAlpha( 0 )
										if event.interrupted then
											self.clipFinished( element, event )
										else
											element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
										end
									end
									
									if event.interrupted then
										glitchFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", glitchFrame7 )
									end
								end
								
								if event.interrupted then
									glitchFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 20, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", glitchFrame6 )
								end
							end
							
							if event.interrupted then
								glitchFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0 )
								element:registerEventHandler( "transition_complete_keyframe", glitchFrame5 )
							end
						end
						
						if event.interrupted then
							glitchFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", glitchFrame4 )
						end
					end
					
					if event.interrupted then
						glitchFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", glitchFrame3 )
					end
				end
				
				self.glitch:completeAnimation()
				self.glitch:setAlpha( 0 )
				glitchFrame2( self.glitch, {} )

				local glitch2Frame2 = function ( element, event )
					local glitch2Frame3 = function ( element, event )
						local glitch2Frame4 = function ( element, event )
							local glitch2Frame5 = function ( element, event )
								local glitch2Frame6 = function ( element, event )
									local glitch2Frame7 = function ( element, event )
										if not event.interrupted then
											element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
										end
										element:setAlpha( 0 )
										if event.interrupted then
											self.clipFinished( element, event )
										else
											element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
										end
									end
									
									if event.interrupted then
										glitch2Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
										element:registerEventHandler( "transition_complete_keyframe", glitch2Frame7 )
									end
								end
								
								if event.interrupted then
									glitch2Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
									element:setAlpha( 1 )
									element:registerEventHandler( "transition_complete_keyframe", glitch2Frame6 )
								end
							end
							
							if event.interrupted then
								glitch2Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", glitch2Frame5 )
							end
						end
						
						if event.interrupted then
							glitch2Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0 )
							element:registerEventHandler( "transition_complete_keyframe", glitch2Frame4 )
						end
					end
					
					if event.interrupted then
						glitch2Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", glitch2Frame3 )
					end
				end
				
				self.glitch2:completeAnimation()
				self.glitch2:setAlpha( 1 )
				glitch2Frame2( self.glitch2, {} )
			end,

			LoseActive = function ()
				self:setupElementClipCounter( 7 )

				local FETabFocusFrame2 = function ( element, event )
					local FETabFocusFrame3 = function ( element, event )
						local FETabFocusFrame4 = function ( element, event )
							local FETabFocusFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								FETabFocusFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0.37 )
								element:registerEventHandler( "transition_complete_keyframe", FETabFocusFrame5 )
							end
						end
						
						if event.interrupted then
							FETabFocusFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 20, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0 )
							element:registerEventHandler( "transition_complete_keyframe", FETabFocusFrame4 )
						end
					end
					
					if event.interrupted then
						FETabFocusFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.54 )
						element:registerEventHandler( "transition_complete_keyframe", FETabFocusFrame3 )
					end
				end
				
				self.FETabFocus:completeAnimation()
				self.FETabFocus:setAlpha( 1 )
				FETabFocusFrame2( self.FETabFocus, {} )

				local FETabIdleFrame2 = function ( element, event )
					local FETabIdleFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						FETabIdleFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", FETabIdleFrame3 )
					end
				end
				
				self.FETabIdle:completeAnimation()
				self.FETabIdle:setAlpha( 0 )
				FETabIdleFrame2( self.FETabIdle, {} )

				local Glow2Frame2 = function ( element, event )
					local Glow2Frame3 = function ( element, event )
						local Glow2Frame4 = function ( element, event )
							local Glow2Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 20, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								Glow2Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 30, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0 )
								element:registerEventHandler( "transition_complete_keyframe", Glow2Frame5 )
							end
						end
						
						if event.interrupted then
							Glow2Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.78 )
							element:registerEventHandler( "transition_complete_keyframe", Glow2Frame4 )
						end
					end
					
					if event.interrupted then
						Glow2Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", Glow2Frame3 )
					end
				end
				
				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 1 )
				Glow2Frame2( self.Glow2, {} )

				local textFrame2 = function ( element, event )
					local textFrame3 = function ( element, event )
						local textFrame4 = function ( element, event )
							local textFrame5 = function ( element, event )
								local textFrame6 = function ( element, event )
									local textFrame7 = function ( element, event )
										local textFrame8 = function ( element, event )
											if not event.interrupted then
												element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
											end
											element:setAlpha( 0.7 )
											if event.interrupted then
												self.clipFinished( element, event )
											else
												element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
											end
										end
										
										if event.interrupted then
											textFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0 )
											element:registerEventHandler( "transition_complete_keyframe", textFrame8 )
										end
									end
									
									if event.interrupted then
										textFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
										element:setAlpha( 0.24 )
										element:registerEventHandler( "transition_complete_keyframe", textFrame7 )
									end
								end
								
								if event.interrupted then
									textFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0 )
									element:registerEventHandler( "transition_complete_keyframe", textFrame6 )
								end
							end
							
							if event.interrupted then
								textFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0.28 )
								element:registerEventHandler( "transition_complete_keyframe", textFrame5 )
							end
						end
						
						if event.interrupted then
							textFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.2 )
							element:registerEventHandler( "transition_complete_keyframe", textFrame4 )
						end
					end
					
					if event.interrupted then
						textFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", textFrame3 )
					end
				end
				
				self.text:completeAnimation()
				self.text:setAlpha( 0 )
				textFrame2( self.text, {} )

				local textDarkFrame2 = function ( element, event )
					local textDarkFrame3 = function ( element, event )
						local textDarkFrame4 = function ( element, event )
							local textDarkFrame5 = function ( element, event )
								local textDarkFrame6 = function ( element, event )
									if not event.interrupted then
										element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
									end
									element:setAlpha( 0 )
									if event.interrupted then
										self.clipFinished( element, event )
									else
										element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
									end
								end
								
								if event.interrupted then
									textDarkFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.48 )
									element:registerEventHandler( "transition_complete_keyframe", textDarkFrame6 )
								end
							end
							
							if event.interrupted then
								textDarkFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0 )
								element:registerEventHandler( "transition_complete_keyframe", textDarkFrame5 )
							end
						end
						
						if event.interrupted then
							textDarkFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.35 )
							element:registerEventHandler( "transition_complete_keyframe", textDarkFrame4 )
						end
					end
					
					if event.interrupted then
						textDarkFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", textDarkFrame3 )
					end
				end
				
				self.textDark:completeAnimation()
				self.textDark:setAlpha( 1 )
				textDarkFrame2( self.textDark, {} )

				local glitchFrame2 = function ( element, event )
					local glitchFrame3 = function ( element, event )
						local glitchFrame4 = function ( element, event )
							local glitchFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								glitchFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", glitchFrame5 )
							end
						end
						
						if event.interrupted then
							glitchFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", glitchFrame4 )
						end
					end
					
					if event.interrupted then
						glitchFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", glitchFrame3 )
					end
				end
				
				self.glitch:completeAnimation()
				self.glitch:setAlpha( 0 )
				glitchFrame2( self.glitch, {} )

				local glitch2Frame2 = function ( element, event )
					local glitch2Frame3 = function ( element, event )
						local glitch2Frame4 = function ( element, event )
							local glitch2Frame5 = function ( element, event )
								local glitch2Frame6 = function ( element, event )
									local glitch2Frame7 = function ( element, event )
										if not event.interrupted then
											element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
										end
										element:setAlpha( 0 )
										if event.interrupted then
											self.clipFinished( element, event )
										else
											element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
										end
									end
									
									if event.interrupted then
										glitch2Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
										element:setAlpha( 0.34 )
										element:registerEventHandler( "transition_complete_keyframe", glitch2Frame7 )
									end
								end
								
								if event.interrupted then
									glitch2Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", glitch2Frame6 )
								end
							end
							
							if event.interrupted then
								glitch2Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0 )
								element:registerEventHandler( "transition_complete_keyframe", glitch2Frame5 )
							end
						end
						
						if event.interrupted then
							glitch2Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", glitch2Frame4 )
						end
					end
					
					if event.interrupted then
						glitch2Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", glitch2Frame3 )
					end
				end
				
				self.glitch2:completeAnimation()
				self.glitch2:setAlpha( 0 )
				glitch2Frame2( self.glitch2, {} )
			end,

			Over = function ()
				self:setupElementClipCounter( 8 )

				self.FETabFocus:completeAnimation()
				self.FETabFocus:setAlpha( 0 )
				self.clipFinished( self.FETabFocus, {} )

				self.FETabIdle:completeAnimation()
				self.FETabIdle:setAlpha( 1 )
				self.clipFinished( self.FETabIdle, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0.8 )
				self.clipFinished( self.Glow2, {} )

				self.text:completeAnimation()
				self.text:setAlpha( 0.7 )
				self.clipFinished( self.text, {} )

				self.textDark:completeAnimation()
				self.textDark:setAlpha( 0 )
				self.clipFinished( self.textDark, {} )

				self.glitch:completeAnimation()
				self.glitch:setAlpha( 0 )
				self.clipFinished( self.glitch, {} )

				self.glitch2:completeAnimation()
				self.glitch2:setAlpha( 0 )
				self.clipFinished( self.glitch2, {} )

				self.buttonText:completeAnimation()
				self.buttonText:setAlpha( 0 )
				self.clipFinished( self.buttonText, {} )
			end,

			GainOver = function ()
				self:setupElementClipCounter( 8 )

				self.FETabFocus:completeAnimation()
				self.FETabFocus:setAlpha( 0 )
				self.clipFinished( self.FETabFocus, {} )

				self.FETabIdle:completeAnimation()
				self.FETabIdle:setAlpha( 1 )
				self.clipFinished( self.FETabIdle, {} )

				local Glow2Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0.8 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				Glow2Frame2( self.Glow2, {} )

				self.text:completeAnimation()
				self.text:setAlpha( 0.7 )
				self.clipFinished( self.text, {} )

				self.textDark:completeAnimation()
				self.textDark:setAlpha( 0 )
				self.clipFinished( self.textDark, {} )

				self.glitch:completeAnimation()
				self.glitch:setAlpha( 0 )
				self.clipFinished( self.glitch, {} )

				self.glitch2:completeAnimation()
				self.glitch2:setAlpha( 0 )
				self.clipFinished( self.glitch2, {} )

				self.buttonText:completeAnimation()
				self.buttonText:setAlpha( 0 )
				self.clipFinished( self.buttonText, {} )
			end,

			LoseOver = function ()
				self:setupElementClipCounter( 8 )

				self.FETabFocus:completeAnimation()
				self.FETabFocus:setAlpha( 0 )
				self.clipFinished( self.FETabFocus, {} )

				self.FETabIdle:completeAnimation()
				self.FETabIdle:setAlpha( 1 )
				self.clipFinished( self.FETabIdle, {} )

				local Glow2Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0.8 )
				Glow2Frame2( self.Glow2, {} )

				self.text:completeAnimation()
				self.text:setAlpha( 0.7 )
				self.clipFinished( self.text, {} )

				self.textDark:completeAnimation()
				self.textDark:setAlpha( 0 )
				self.clipFinished( self.textDark, {} )

				self.glitch:completeAnimation()
				self.glitch:setAlpha( 0 )
				self.clipFinished( self.glitch, {} )

				self.glitch2:completeAnimation()
				self.glitch2:setAlpha( 0 )
				self.clipFinished( self.glitch2, {} )

				self.buttonText:completeAnimation()
				self.buttonText:setAlpha( 0 )
				self.clipFinished( self.buttonText, {} )
			end
		},

		NavButton = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.FETabFocus:completeAnimation()
				self.FETabFocus:setAlpha( 0 )
				self.clipFinished( self.FETabFocus, {} )

				self.FETabIdle:completeAnimation()
				self.FETabIdle:setAlpha( 1 )
				self.clipFinished( self.FETabIdle, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )

				self.text:completeAnimation()
				self.text:setAlpha( 0 )
				self.clipFinished( self.text, {} )

				self.textDark:completeAnimation()
				self.textDark:setLeftRight( false, false, -100, 100 )
				self.textDark:setTopBottom( false, false, -9, 12 )
				self.textDark:setAlpha( 0 )
				self.clipFinished( self.textDark, {} )

				self.glitch:completeAnimation()
				self.glitch:setAlpha( 0 )
				self.clipFinished( self.glitch, {} )

				self.glitch2:completeAnimation()
				self.glitch2:setAlpha( 0 )
				self.clipFinished( self.glitch2, {} )

				self.buttonText:completeAnimation()
				self.buttonText:setAlpha( 1 )
				self.clipFinished( self.buttonText, {} )
			end
		},

		NavButtonHiddenPrompt = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.FETabFocus:completeAnimation()
				self.FETabFocus:setAlpha( 0 )
				self.clipFinished( self.FETabFocus, {} )

				self.FETabIdle:completeAnimation()
				self.FETabIdle:setAlpha( 1 )
				self.clipFinished( self.FETabIdle, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )

				self.text:completeAnimation()
				self.text:setAlpha( 0 )
				self.clipFinished( self.text, {} )

				self.textDark:completeAnimation()
				self.textDark:setAlpha( 0 )
				self.clipFinished( self.textDark, {} )

				self.glitch:completeAnimation()
				self.glitch:setAlpha( 0 )
				self.clipFinished( self.glitch, {} )

				self.glitch2:completeAnimation()
				self.glitch2:setAlpha( 0 )
				self.clipFinished( self.glitch2, {} )

				self.buttonText:completeAnimation()
				self.buttonText:setAlpha( 0 )
				self.clipFinished( self.buttonText, {} )
			end
		},

		Disabled = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.FETabFocus:completeAnimation()
				self.FETabFocus:setAlpha( 0 )
				self.clipFinished( self.FETabFocus, {} )

				self.FETabIdle:completeAnimation()
				self.FETabIdle:setAlpha( 0.5 )
				self.clipFinished( self.FETabIdle, {} )

				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0 )
				self.clipFinished( self.Glow2, {} )

				self.text:completeAnimation()
				self.text:setAlpha( 0.4 )
				self.clipFinished( self.text, {} )

				self.textDark:completeAnimation()
				self.textDark:setAlpha( 0 )
				self.clipFinished( self.textDark, {} )

				self.glitch:completeAnimation()
				self.glitch:setAlpha( 0 )
				self.clipFinished( self.glitch, {} )

				self.glitch2:completeAnimation()
				self.glitch2:setAlpha( 0 )
				self.clipFinished( self.glitch2, {} )

				self.buttonText:completeAnimation()
				self.buttonText:setAlpha( 0 )
				self.clipFinished( self.buttonText, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "NavButton",
			condition = function ( menu, element, event )
				return ShouldDisplayButton( element, controller ) and IsGamepad( controller )
			end
		},
		{
			stateName = "NavButtonHiddenPrompt",
			condition = function ( menu, element, event )
				return ShouldDisplayButton( element, controller ) and not IsGamepad( controller )
			end
		},
		{
			stateName = "Disabled",
			condition = function ( menu, element, event )
				return IsDisabled( element, controller )
			end
		}
	} )

	self:linkToElementModel( self, "tabIcon", true, function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "tabIcon" } )
	end )

	if self.m_eventHandlers.input_source_changed then
		local existingInputHandler = self.m_eventHandlers.input_source_changed
		self:registerEventHandler( "input_source_changed", function ( element, event )
			event.menu = event.menu or menu
			element:updateState( event )
			return existingInputHandler( element, event )
		end )
	else
		self:registerEventHandler( "input_source_changed", LUI.UIElement.updateState )
	end

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "LastInput" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "LastInput" } )
	end )

	self:linkToElementModel( self, "disabled", true, function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "disabled" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.GameSettingsChangedIndicator:close()
		element.breadcrumbCount:close()
		element.text:close()
		element.textDark:close()
		element.buttonText:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end