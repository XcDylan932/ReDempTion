require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_ClipPress" )
require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2" )

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        local elements = { self.ClipGlowTop, self.ClipGlow, self.ZmFxSpark20, self.Lightning }
        for _, element in ipairs( elements ) do
            if element then
                element:completeAnimation()
                element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
                CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
            end
        end
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_ClipFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_ClipFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_ClipFactory )
	self.id = "ZmAmmo_ClipFactory"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 108 )
	self:setTopBottom( true, false, 0, 48 )
	self.anyChildUsesUpdateState = true
	
	self.ClipGlowTop = LUI.UIImage.new()
	self.ClipGlowTop:setLeftRight( true, false, 15.4, 89.6 )
	self.ClipGlowTop:setTopBottom( true, false, -13.75, 62 )
	self.ClipGlowTop:setRGB( 0.33, 0.54, 1 )
	self.ClipGlowTop:setAlpha( 0.75 )
	self.ClipGlowTop:setZRot( -4 )
	self.ClipGlowTop:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self:addElement( self.ClipGlowTop )
	
	self.ClipGlow = LUI.UIImage.new()
	self.ClipGlow:setLeftRight( true, false, 22.5, 83.28 )
	self.ClipGlow:setTopBottom( true, false, -9, 53.5 )
	self.ClipGlow:setRGB( 0, 0.53, 0.82 )
	self.ClipGlow:setAlpha( 0.3 )
	self.ClipGlow:setZRot( -4 )
	self.ClipGlow:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.ClipGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ClipGlow )
	
	self.Clip = LUI.UIText.new()
	self.Clip:setLeftRight( true, false, 0, 108 )
	self.Clip:setTopBottom( true, false, -9, 55 )
	self.Clip:setText( Engine.Localize( "33" ) )
	self.Clip:setTTF( "fonts/WEARETRIPPINShort.ttf" )
	self.Clip:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "uie_aberration" ) )
	self.Clip:setShaderVector( 0, 0.2, 1, 0, 0 )
	self.Clip:setShaderVector( 1, 0, 0, 0, 0 )
	self.Clip:setShaderVector( 2, 0, 0, 0, 0 )
	self.Clip:setShaderVector( 3, 0, 0, 0, 0 )
	self.Clip:setShaderVector( 4, 0, 0, 0, 0 )
	self.Clip:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.Clip:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self:addElement( self.Clip )
	
	self.ClipContainerPress00 = CoD.ZmAmmo_ClipPress.new( menu, controller )
	self.ClipContainerPress00:setLeftRight( false, false, -51, 57 )
	self.ClipContainerPress00:setTopBottom( false, false, -22, 20 )
	self.ClipContainerPress00:setAlpha( 0 )
	self.ClipContainerPress00:mergeStateConditions( {
		{
			stateName = "NoAmmoPress",
			condition = function ( menu, element, event )
				return PulseNoAmmo( controller )
			end
		}
	} )
	self.ClipContainerPress00:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.pulseNoAmmo" ), function ( model )
		menu:updateElementState( self.ClipContainerPress00, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.pulseNoAmmo" } )
	end )
	self:addElement( self.ClipContainerPress00 )
	
	self.ZmFxSpark20 = CoD.ZmFx_Spark2.new( menu, controller )
	self.ZmFxSpark20:setLeftRight( true, false, 26.27, 81.73 )
	self.ZmFxSpark20:setTopBottom( true, false, -40, 55 )
	self.ZmFxSpark20:setRGB( 0, 0.67, 1 )
	self.ZmFxSpark20:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmFxSpark20.Image0:setShaderVector( 1, 0, 0.4, 0, 0 )
	self.ZmFxSpark20.Image00:setShaderVector( 1, 0, -0.2, 0, 0 )
	self:addElement( self.ZmFxSpark20 )
	
	self.Lightning = LUI.UIImage.new()
	self.Lightning:setLeftRight( true, false, -20.5, 130.5 )
	self.Lightning:setTopBottom( true, false, -59, 85 )
	self.Lightning:setAlpha( 0 )
	self.Lightning:setImage( RegisterImage( "uie_t7_zm_derriese_hud_notification_anim" ) )
	self.Lightning:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_flipbook" ) )
	self.Lightning:setShaderVector( 0, 28, 0, 0, 0 )
	self.Lightning:setShaderVector( 1, 30, 0, 0, 0 )
	self:addElement( self.Lightning )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setLeftRight( true, false, 25.8, 108 )
				self.ClipGlowTop:setTopBottom( true, false, -18.38, 64.38 )
				self.ClipGlowTop:setAlpha( 0.75 )
				self.clipFinished( self.ClipGlowTop, {} )

				self.ClipGlow:completeAnimation()
				self.ClipGlow:setLeftRight( true, false, 44.01, 87.79 )
				self.ClipGlow:setTopBottom( true, false, 1, 45.25 )
				self.ClipGlow:setAlpha( 0.1 )
				self.clipFinished( self.ClipGlow, {} )

				self.Clip:completeAnimation()
				self.Clip:setRGB( 1, 0.99, 0.93 )
				self.clipFinished( self.Clip, {} )

				self.ClipContainerPress00:completeAnimation()
				self.ClipContainerPress00:setAlpha( 0 )
				self.clipFinished( self.ClipContainerPress00, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
			end,

			NoAmmo = function ()
				self:setupElementClipCounter( 6 )

				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setRGB( 1, 0.33, 0.36 )
				self.clipFinished( self.ClipGlowTop, {} )

				self.ClipGlow:completeAnimation()
				self.ClipGlow:setRGB( 0.48, 0.06, 0.05 )
				self.clipFinished( self.ClipGlow, {} )

				self.Clip:completeAnimation()
				self.Clip:setRGB( 1, 0.49, 0.49 )
				self.clipFinished( self.Clip, {} )

				self.ClipContainerPress00:completeAnimation()
				self.ClipContainerPress00:setAlpha( 1 )
				self.clipFinished( self.ClipContainerPress00, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
			end
		},

		Invisible = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setAlpha( 0 )
				self.clipFinished( self.ClipGlowTop, {} )

				self.ClipGlow:completeAnimation()
				self.ClipGlow:setAlpha( 0 )
				self.clipFinished( self.ClipGlow, {} )

				self.Clip:completeAnimation()
				self.Clip:setRGB( 0, 0, 0 )
				self.clipFinished( self.Clip, {} )

				self.ClipContainerPress00:completeAnimation()
				self.ClipContainerPress00:setAlpha( 0 )
				self.clipFinished( self.ClipContainerPress00, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
			end
		},

		LowAmmo = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setRGB( 1, 0.33, 0.36 )
				self.clipFinished( self.ClipGlowTop, {} )

				self.ClipGlow:completeAnimation()
				self.ClipGlow:setRGB( 0.48, 0.06, 0.05 )
				self.clipFinished( self.ClipGlow, {} )

				local ClipFrame2 = function ( element, event )
					local ClipFrame3 = function ( element, event )
						local ClipFrame4 = function ( element, event )
							local ClipFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Linear )
								end
								element:setRGB( 1, 0.99, 0.93 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end

							if event.interrupted then
								ClipFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Linear )
								element:setRGB( 1, 0.99, 0.93 )
								element:registerEventHandler( "transition_complete_keyframe", ClipFrame5 )
							end
						end

						if event.interrupted then
							ClipFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 460, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ClipFrame4 )
						end
					end

					if event.interrupted then
						ClipFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setRGB( 1, 0.49, 0.49 )
						element:registerEventHandler( "transition_complete_keyframe", ClipFrame3 )
					end
				end
				
				self.Clip:completeAnimation()
				self.Clip:setRGB( 1, 0.99, 0.93 )
				ClipFrame2( self.Clip, {} )

				self.ClipContainerPress00:completeAnimation()
				self.ClipContainerPress00:setAlpha( 0 )
				self.clipFinished( self.ClipContainerPress00, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 6 )

				local ClipGlowTopFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 0, 0.75, 1 )
					CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setRGB( 1, 0.33, 0.36 )
				ClipGlowTopFrame2( self.ClipGlowTop, {} )

				local ClipGlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 0, 0.91, 1 )
					CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipGlow:completeAnimation()
				self.ClipGlow:setRGB( 0.48, 0.06, 0.05 )
				ClipGlowFrame2( self.ClipGlow, {} )

				local ClipFrame2 = function ( element, event )
					local ClipFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 329, false, false, CoD.TweenType.Bounce )
						end
						element:setRGB( 1, 0.99, 0.93 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ClipFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 170, false, false, CoD.TweenType.Linear )
						element:setRGB( 1, 0.93, 0.87 )
						element:setZoom( 46 )
						element:registerEventHandler( "transition_complete_keyframe", ClipFrame3 )
					end
				end
				
				self.Clip:completeAnimation()
				self.Clip:setRGB( 1, 0.49, 0.49 )
				self.Clip:setZoom( 0 )
				ClipFrame2( self.Clip, {} )

				local ClipContainerPress00Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipContainerPress00:completeAnimation()
				self.ClipContainerPress00:setAlpha( 0 )
				ClipContainerPress00Frame2( self.ClipContainerPress00, {} )

				local ZmFxSpark20Frame2 = function ( element, event )
					local ZmFxSpark20Frame3 = function ( element, event )
						local ZmFxSpark20Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 399, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 5, 105 )
							element:setTopBottom( true, false, -75, 60.5 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							ZmFxSpark20Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 390, false, true, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 5, 105 )
							element:setTopBottom( true, false, -75, 60.5 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame4 )
						end
					end

					if event.interrupted then
						ZmFxSpark20Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 16, 94 )
						element:setTopBottom( true, false, -9, 53.5 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame3 )
					end
				end
				
				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setLeftRight( true, false, 18, 92 )
				self.ZmFxSpark20:setTopBottom( true, false, -9, 60.5 )
				self.ZmFxSpark20:setAlpha( 0.52 )
				ZmFxSpark20Frame2( self.ZmFxSpark20, {} )

				local LightningFrame2 = function ( element, event )
					local LightningFrame3 = function ( element, event )
						local LightningFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							LightningFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", LightningFrame4 )
						end
					end

					if event.interrupted then
						LightningFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", LightningFrame3 )
					end
				end
				
				self.Lightning:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
				self.Lightning:setAlpha( 0 )
				self.Lightning:registerEventHandler( "transition_complete_keyframe", LightningFrame2 )
			end
		},

		NoAmmo = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setRGB( 1, 0.33, 0.36 )
				self.clipFinished( self.ClipGlowTop, {} )

				self.ClipGlow:completeAnimation()
				self.ClipGlow:setRGB( 0.48, 0.06, 0.05 )
				self.clipFinished( self.ClipGlow, {} )

				self.Clip:completeAnimation()
				self.Clip:setRGB( 1, 0.49, 0.49 )
				self.clipFinished( self.Clip, {} )

				self.ClipContainerPress00:completeAnimation()
				self.ClipContainerPress00:setAlpha( 1 )
				self.clipFinished( self.ClipContainerPress00, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 6 )

				local ClipGlowTopFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 0, 0.75, 1 )
					CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setRGB( 1, 0.33, 0.36 )
				ClipGlowTopFrame2( self.ClipGlowTop, {} )

				local ClipGlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 0, 0.91, 1 )
					CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipGlow:completeAnimation()
				self.ClipGlow:setRGB( 0.48, 0.06, 0.05 )
				ClipGlowFrame2( self.ClipGlow, {} )

				

				local ClipFrame2 = function ( element, event )
					local ClipFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 329, false, false, CoD.TweenType.Bounce )
						end
						element:setRGB( 1, 0.99, 0.93 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ClipFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 170, false, false, CoD.TweenType.Linear )
						element:setRGB( 1, 0.93, 0.87 )
						element:setZoom( 46 )
						element:registerEventHandler( "transition_complete_keyframe", ClipFrame3 )
					end
				end
				
				self.Clip:completeAnimation()
				self.Clip:setRGB( 1, 0.49, 0.49 )
				self.Clip:setZoom( 0 )
				ClipFrame2( self.Clip, {} )

				local ClipContainerPress00Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipContainerPress00:completeAnimation()
				self.ClipContainerPress00:setAlpha( 0 )
				ClipContainerPress00Frame2( self.ClipContainerPress00, {} )

				local ZmFxSpark20Frame2 = function ( element, event )
					local ZmFxSpark20Frame3 = function ( element, event )
						local ZmFxSpark20Frame4 = function ( element, event )
							local ZmFxSpark20Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 30, false, false, CoD.TweenType.Linear )
								end
								element:setLeftRight( true, false, 5, 105 )
								element:setTopBottom( true, false, -75, 60.5 )
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end

							if event.interrupted then
								ZmFxSpark20Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 399, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame5 )
							end
						end

						if event.interrupted then
							ZmFxSpark20Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 390, false, true, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 5, 105 )
							element:setTopBottom( true, false, -75, 60.5 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame4 )
						end
					end

					if event.interrupted then
						ZmFxSpark20Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 16, 94 )
						element:setTopBottom( true, false, -9, 53.5 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame3 )
					end
				end
				
				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setLeftRight( true, false, 18, 92 )
				self.ZmFxSpark20:setTopBottom( true, false, -9, 60.5 )
				self.ZmFxSpark20:setAlpha( 0.52 )
				ZmFxSpark20Frame2( self.ZmFxSpark20, {} )

				local LightningFrame2 = function ( element, event )
					local LightningFrame3 = function ( element, event )
						local LightningFrame4 = function ( element, event )
							local LightningFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								LightningFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", LightningFrame5 )
							end
						end

						if event.interrupted then
							LightningFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", LightningFrame4 )
						end
					end

					if event.interrupted then
						LightningFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", LightningFrame3 )
					end
				end
				
				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				LightningFrame2( self.Lightning, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Invisible",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "LowAmmo",
			condition = function ( menu, element, event )
				return true
			end
		},
		{
			stateName = "NoAmmo",
			condition = function ( menu, element, event )
				return true
			end
		}
	} )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ClipContainerPress00:close()
		element.ZmFxSpark20:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end