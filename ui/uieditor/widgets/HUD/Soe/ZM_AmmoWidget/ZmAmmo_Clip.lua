require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_ClipPress" )
require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2" )

local PostLoadFunc = function( self, controller, menu )
	if not Engine.GetModelValue( Engine.CreateModel( Engine.GetModelForController( controller ), "currentWeapon.aatIcon" ) ) then
		self.AATIcon:setImage( RegisterImage( "blacktransparent" ) )
	end

    self.UpdateColors = function( self )
    	local color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]
        local elements = {
        	self.TotalGlowMult,
	    	self.ClipElem,
	    	self.ClipGlow,
	    	self.ClipGlowTop,
	    	self.ZmFxSpark20,
	    	self.ClipBack
    	}

        for _, element in ipairs( elements ) do
            if element then
                element:completeAnimation()
                element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
                CoD.UIColors.SetElementColor( element, color )
            end
        end
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_Clip = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_Clip.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_Clip )
	self.id = "ZmAmmo_Clip"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 108 )
	self:setTopBottom( true, false, 0, 48 )
	self.anyChildUsesUpdateState = true
	
	self.TotalGlowMult = LUI.UIImage.new()
	self.TotalGlowMult:setLeftRight( true, false, 5, 100.78 )
	self.TotalGlowMult:setTopBottom( true, false, -21, 67 )
	CoD.UIColors.SetElementColor( self.TotalGlowMult, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.TotalGlowMult:setAlpha( 0.58 )
	self.TotalGlowMult:setZRot( -4 )
	self.TotalGlowMult:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.TotalGlowMult:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_multiply" ) )
	self:addElement( self.TotalGlowMult )
	
	self.ClipBack = LUI.UIText.new()
	self.ClipBack:setLeftRight( true, false, 1, 109 )
	self.ClipBack:setTopBottom( true, false, -9, 55 )
	CoD.UIColors.SetElementColor( self.ClipBack, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.ClipBack:setAlpha( 0.2 )
	self.ClipBack:setXRot( 180 )
	self.ClipBack:setYRot( 180 )
	self.ClipBack:setZoom( -20 )
	self.ClipBack:setTTF( "fonts/RefrigeratorDeluxe-Regular.ttf" )
	self.ClipBack:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.ClipBack:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self.ClipBack:subscribeToGlobalModel( controller, "CurrentWeapon", "ammoInClip", function ( model )
		local ammoInClip = Engine.GetModelValue( model )
		if ammoInClip then
			self.ClipBack:setText( Engine.Localize( ammoInClip ) )
		end
	end )
	self:addElement( self.ClipBack )
	
	self.ClipElem = LUI.UIImage.new()
	self.ClipElem:setLeftRight( true, false, 18, 90 )
	self.ClipElem:setTopBottom( true, false, -13, 59 )
	CoD.UIColors.SetElementColor( self.ClipElem, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.ClipElem:setAlpha( 0.98 )
	self.ClipElem:setZoom( -10 )
	self.ClipElem:setImage( RegisterImage( "uie_t7_zm_hud_ammo_elmclipamo" ) )
	self.ClipElem:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ClipElem )
	
	self.ClipGlow = LUI.UIImage.new()
	self.ClipGlow:setLeftRight( true, false, -15.39, 123.39 )
	self.ClipGlow:setTopBottom( true, false, -22, 64.5 )
	CoD.UIColors.SetElementColor( self.ClipGlow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.ClipGlow:setAlpha( 0.42 )
	self.ClipGlow:setZRot( -4 )
	self.ClipGlow:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.ClipGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ClipGlow )
	
	self.ClipGlowTop = LUI.UIImage.new()
	self.ClipGlowTop:setLeftRight( true, false, 5.5, 97.7 )
	self.ClipGlowTop:setTopBottom( true, false, -13, 60.5 )
	CoD.UIColors.SetElementColor( self.ClipGlowTop, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.ClipGlowTop:setAlpha( 0.25 )
	self.ClipGlowTop:setZRot( -4 )
	self.ClipGlowTop:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self:addElement( self.ClipGlowTop )
	
	self.Clip = LUI.UIText.new()
	self.Clip:setLeftRight( true, false, -1, 107 )
	self.Clip:setTopBottom( true, false, -9, 55 )
	self.Clip:setRGB( 1, 0, 0.12 )
	self.Clip:setText( Engine.Localize( "33" ) )
	self.Clip:setTTF( "fonts/WEARETRIPPINShort.ttf" )
	self.Clip:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
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
	self.ZmFxSpark20:setLeftRight( true, false, 5, 105 )
	self.ZmFxSpark20:setTopBottom( true, false, -94.5, 60.5 )
	self.ZmFxSpark20:setAlpha( 0 )
	self.ZmFxSpark20:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmFxSpark20.Image0:setShaderVector( 1, 0, 0.4, 0, 0 )
	self.ZmFxSpark20.Image00:setShaderVector( 1, 0, -0.2, 0, 0 )
	self:addElement( self.ZmFxSpark20 )
	
	self.ZmFxFlsh = LUI.UIImage.new()
	self.ZmFxFlsh:setLeftRight( true, false, -4.77, 123.39 )
	self.ZmFxFlsh:setTopBottom( true, false, -22, 69 )
	self.ZmFxFlsh:setAlpha( 0 )
	self.ZmFxFlsh:setImage( RegisterImage( "uie_t7_zm_hud_rnd_flsh1" ) )
	self.ZmFxFlsh:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxFlsh )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.ClipBack:completeAnimation()
				CoD.UIColors.SetElementColor( self.ClipBack, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.clipFinished( self.ClipBack, {} )

				self.ClipElem:completeAnimation()
				CoD.UIColors.SetElementColor( self.ClipElem, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.clipFinished( self.ClipElem, {} )

				self.ClipGlow:completeAnimation()
				CoD.UIColors.SetElementColor( self.ClipGlow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.clipFinished( self.ClipGlow, {} )

				self.ClipGlowTop:completeAnimation()
				CoD.UIColors.SetElementColor( self.ClipGlowTop, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.clipFinished( self.ClipGlowTop, {} )

				self.Clip:completeAnimation()
				self.Clip:setRGB( 1, 0.99, 0.93 )
				self.clipFinished( self.Clip, {} )

				self.ClipContainerPress00:completeAnimation()
				self.ClipContainerPress00:setAlpha( 0 )
				self.clipFinished( self.ClipContainerPress00, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			NoAmmo = function ()
				self:setupElementClipCounter( 7 )

				self.ClipElem:completeAnimation()
				self.ClipElem:setRGB( 1, 0.15, 0 )
				self.clipFinished( self.ClipElem, {} )

				self.ClipGlow:completeAnimation()
				self.ClipGlow:setRGB( 0.48, 0.06, 0.05 )
				self.clipFinished( self.ClipGlow, {} )

				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setRGB( 1, 0.33, 0.36 )
				self.clipFinished( self.ClipGlowTop, {} )

				self.Clip:completeAnimation()
				self.Clip:setRGB( 1, 0.49, 0.49 )
				self.clipFinished( self.Clip, {} )

				self.ClipContainerPress00:completeAnimation()
				self.ClipContainerPress00:setAlpha( 1 )
				self.clipFinished( self.ClipContainerPress00, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 280, false, false, CoD.TweenType.Bounce )
						end
						element:setRGB( 1, 0, 0 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setRGB( 1, 0, 0 )
				self.ZmFxFlsh:setAlpha( 0.29 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		},

		LowAmmo = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.ClipElem:completeAnimation()
				self.ClipElem:setRGB( 1, 0.15, 0 )
				self.clipFinished( self.ClipElem, {} )

				self.ClipGlow:completeAnimation()
				self.ClipGlow:setRGB( 0.48, 0.06, 0.05 )
				self.clipFinished( self.ClipGlow, {} )

				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setRGB( 1, 0.33, 0.36 )
				self.clipFinished( self.ClipGlowTop, {} )

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

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 569, false, false, CoD.TweenType.Linear )
						end
						element:setRGB( 1, 0, 0 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.27 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setRGB( 1, 0, 0 )
				self.ZmFxFlsh:setAlpha( 0 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )

				self.nextClip = "DefaultClip"
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 8 )

				self.ClipBack:completeAnimation()
				self.ClipBack:setRGB( 1, 0.41, 0 )
				self.clipFinished( self.ClipBack, {} )

				local ClipElemFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 230, false, false, CoD.TweenType.Linear )
					end
					element:setRGB( 1, 0.54, 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipElem:completeAnimation()
				self.ClipElem:setRGB( 1, 0.15, 0 )
				ClipElemFrame2( self.ClipElem, {} )

				local ClipGlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 0.79, 0.48, 0.25 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipGlow:completeAnimation()
				self.ClipGlow:setRGB( 0.48, 0.06, 0.05 )
				ClipGlowFrame2( self.ClipGlow, {} )

				local ClipGlowTopFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.97, 0.33 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setRGB( 1, 0.33, 0.36 )
				ClipGlowTopFrame2( self.ClipGlowTop, {} )

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
							element:setTopBottom( true, false, -75, 60.5 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame4 )
						end
					end

					if event.interrupted then
						ZmFxSpark20Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame3 )
					end
				end
				
				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setLeftRight( true, false, 5, 105 )
				self.ZmFxSpark20:setTopBottom( true, false, -9, 60.5 )
				self.ZmFxSpark20:setAlpha( 0.52 )
				ZmFxSpark20Frame2( self.ZmFxSpark20, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 829, false, false, CoD.TweenType.Bounce )
						end
						element:setRGB( 1, 1, 1 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setRGB( 1, 1, 1 )
				self.ZmFxFlsh:setAlpha( 0.46 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		},

		NoAmmo = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.ClipElem:completeAnimation()
				self.ClipElem:setRGB( 1, 0.15, 0 )
				self.clipFinished( self.ClipElem, {} )

				self.ClipGlow:completeAnimation()
				self.ClipGlow:setRGB( 0.48, 0.06, 0.05 )
				self.clipFinished( self.ClipGlow, {} )

				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setRGB( 1, 0.33, 0.36 )
				self.clipFinished( self.ClipGlowTop, {} )

				self.Clip:completeAnimation()
				self.Clip:setRGB( 1, 0.49, 0.49 )
				self.clipFinished( self.Clip, {} )

				self.ClipContainerPress00:completeAnimation()
				self.ClipContainerPress00:setAlpha( 1 )
				self.clipFinished( self.ClipContainerPress00, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setRGB( 1, 1, 1 )
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 8 )

				self.ClipBack:completeAnimation()
				self.ClipBack:setRGB( 1, 0.41, 0 )
				self.clipFinished( self.ClipBack, {} )

				local ClipElemFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 230, false, false, CoD.TweenType.Linear )
					end
					element:setRGB( 1, 0.54, 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipElem:completeAnimation()
				self.ClipElem:setRGB( 1, 0.15, 0 )
				ClipElemFrame2( self.ClipElem, {} )

				local ClipGlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 0.79, 0.48, 0.25 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipGlow:completeAnimation()
				self.ClipGlow:setRGB( 0.48, 0.06, 0.05 )
				ClipGlowFrame2( self.ClipGlow, {} )

				local ClipGlowTopFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.97, 0.33 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setRGB( 1, 0.33, 0.36 )
				ClipGlowTopFrame2( self.ClipGlowTop, {} )

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
								element:setAlpha( 0.07 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame5 )
							end
						end

						if event.interrupted then
							ZmFxSpark20Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 390, false, true, CoD.TweenType.Linear )
							element:setTopBottom( true, false, -75, 60.5 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame4 )
						end
					end

					if event.interrupted then
						ZmFxSpark20Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame3 )
					end
				end
				
				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setLeftRight( true, false, 5, 105 )
				self.ZmFxSpark20:setTopBottom( true, false, -9, 60.5 )
				self.ZmFxSpark20:setAlpha( 0.52 )
				ZmFxSpark20Frame2( self.ZmFxSpark20, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 829, false, false, CoD.TweenType.Bounce )
						end
						element:setRGB( 1, 1, 1 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setRGB( 1, 1, 1 )
				self.ZmFxFlsh:setAlpha( 0.46 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ClipContainerPress00:close()
		element.ZmFxSpark20:close()
		element.ClipBack:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end