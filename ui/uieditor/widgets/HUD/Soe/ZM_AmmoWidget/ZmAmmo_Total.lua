require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2" )

local PostLoadFunc = function( self, controller, menu )
	self.UpdateColors = function( self )
        local color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]        
        local elements = {
            self.TotalGlowMult,
            self.TotalBack,
            self.TotalElem,
            self.TotalGlow,
            self.TotalGlowTop
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

CoD.ZmAmmo_Total = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_Total.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_Total )
	self.id = "ZmAmmo_Total"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 108 )
	self:setTopBottom( true, false, 0, 48 )
	self.anyChildUsesUpdateState = true
	
	self.TotalGlowMult = LUI.UIImage.new()
	self.TotalGlowMult:setLeftRight( true, false, -9.29, 86.49 )
	self.TotalGlowMult:setTopBottom( true, false, -7, 59 )
	CoD.UIColors.SetElementColor( self.TotalGlowMult, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.TotalGlowMult:setAlpha( 0.58 )
	self.TotalGlowMult:setZRot( -4 )
	self.TotalGlowMult:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.TotalGlowMult:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_multiply" ) )
	self:addElement( self.TotalGlowMult )
	
	self.TotalBack = LUI.UIText.new()
	self.TotalBack:setLeftRight( true, false, 10.71, 76.9 )
	self.TotalBack:setTopBottom( true, false, 3, 47 )
	CoD.UIColors.SetElementColor( self.TotalBack, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.TotalBack:setAlpha( 0.38 )
	self.TotalBack:setXRot( 180 )
	self.TotalBack:setYRot( 180 )
	self.TotalBack:setZoom( -20 )
	self.TotalBack:setTTF( "fonts/RefrigeratorDeluxe-Regular.ttf" )
	self.TotalBack:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.TotalBack:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self.TotalBack:subscribeToGlobalModel( controller, "CurrentWeapon", "ammoStock", function ( model )
		local ammoStock = Engine.GetModelValue( model )
		if ammoStock then
			self.TotalBack:setText( Engine.Localize( ammoStock ) )
		end
	end )
	self:addElement( self.TotalBack )
	
	self.TotalElem = LUI.UIImage.new()
	self.TotalElem:setLeftRight( true, false, 25, 65 )
	self.TotalElem:setTopBottom( true, false, 8, 44 )
	CoD.UIColors.SetElementColor( self.TotalElem, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.TotalElem:setZoom( -10 )
	self.TotalElem:setImage( RegisterImage( "uie_t7_zm_hud_ammo_elmttlamo" ) )
	self.TotalElem:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.TotalElem )
	
	self.TotalGlow = LUI.UIImage.new()
	self.TotalGlow:setLeftRight( true, false, 10.71, 86.49 )
	self.TotalGlow:setTopBottom( true, false, -7, 59 )
	CoD.UIColors.SetElementColor( self.TotalGlow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.TotalGlow:setAlpha( 0.21 )
	self.TotalGlow:setZRot( -4 )
	self.TotalGlow:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.TotalGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.TotalGlow )
	
	self.TotalGlowTop = LUI.UIImage.new()
	self.TotalGlowTop:setLeftRight( true, false, 15.8, 70.2 )
	self.TotalGlowTop:setTopBottom( true, false, -6, 55.5 )
	CoD.UIColors.SetElementColor( self.TotalGlowTop, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.TotalGlowTop:setAlpha( 0.18 )
	self.TotalGlowTop:setZRot( -4 )
	self.TotalGlowTop:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self:addElement( self.TotalGlowTop )
	
	self.Total = LUI.UIText.new()
	self.Total:setLeftRight( true, false, 7.71, 73.9 )
	self.Total:setTopBottom( true, false, 4, 48 )
	self.Total:setRGB( 1, 0.99, 0.93 )
	self.Total:setAlpha( 0.94 )
	self.Total:setTTF( "fonts/WEARETRIPPINShort.ttf" )
	self.Total:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.Total:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self.Total:subscribeToGlobalModel( controller, "CurrentWeapon", "ammoStock", function ( model )
		local ammoStock = Engine.GetModelValue( model )
		if ammoStock then
			self.Total:setText( Engine.Localize( ammoStock ) )
		end
	end )
	self:addElement( self.Total )
	
	self.ZmFxSpark20 = CoD.ZmFx_Spark2.new( menu, controller )
	self.ZmFxSpark20:setLeftRight( true, false, 5.21, 82.41 )
	self.ZmFxSpark20:setTopBottom( true, false, -7, 56 )
	self.ZmFxSpark20:setAlpha( 0 )
	self.ZmFxSpark20:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmFxSpark20.Image0:setShaderVector( 1, 0, 0.4, 0, 0 )
	self.ZmFxSpark20.Image00:setShaderVector( 1, 0, -0.2, 0, 0 )
	self:addElement( self.ZmFxSpark20 )
	
	self.ZmFxFlsh = LUI.UIImage.new()
	self.ZmFxFlsh:setLeftRight( true, false, -0.79, 86.38 )
	self.ZmFxFlsh:setTopBottom( true, false, -9.5, 57.5 )
	self.ZmFxFlsh:setAlpha( 0 )
	self.ZmFxFlsh:setImage( RegisterImage( "uie_t7_zm_hud_rnd_flsh1" ) )
	self.ZmFxFlsh:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxFlsh )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.TotalBack:completeAnimation()
				self.TotalBack:setAlpha( 0.1 )
				self.clipFinished( self.TotalBack, {} )

				self.TotalElem:completeAnimation()
				CoD.UIColors.SetElementColor( self.TotalElem, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.TotalElem:setAlpha( 1 )
				self.clipFinished( self.TotalElem, {} )

				self.TotalGlow:completeAnimation()
				CoD.UIColors.SetElementColor( self.TotalGlow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.TotalGlow:setAlpha( 0.48 )
				self.clipFinished( self.TotalGlow, {} )

				self.TotalGlowTop:completeAnimation()
				CoD.UIColors.SetElementColor( self.TotalGlowTop, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.TotalGlowTop:setAlpha( 0.27 )
				self.clipFinished( self.TotalGlowTop, {} )

				self.Total:completeAnimation()
				self.Total:setRGB( 1, 0.99, 0.93 )
				self.Total:setAlpha( 0.94 )
				self.Total:setZoom( 0 )
				self.clipFinished( self.Total, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			NoAmmo = function ()
				self:setupElementClipCounter( 5 )

				self.TotalElem:completeAnimation()
				self.TotalElem:setRGB( 1, 0.15, 0 )
				self.clipFinished( self.TotalElem, {} )

				self.TotalGlow:completeAnimation()
				self.TotalGlow:setRGB( 0.79, 0.26, 0.25 )
				self.clipFinished( self.TotalGlow, {} )

				self.TotalGlowTop:completeAnimation()
				self.TotalGlowTop:setRGB( 1, 0.33, 0.36 )
				self.clipFinished( self.TotalGlowTop, {} )

				self.Total:completeAnimation()
				self.Total:setRGB( 1, 0.49, 0.49 )
				self.Total:setZoom( 0 )
				self.clipFinished( self.Total, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 219, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0, 0 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setRGB( 1, 0, 0 )
				self.ZmFxFlsh:setAlpha( 0.42 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			HeroWeapon = function ()
				self:setupElementClipCounter( 5 )

				local TotalBackFrame2 = function ( element, event )
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
				
				self.TotalBack:completeAnimation()
				self.TotalBack:setAlpha( 0.1 )
				TotalBackFrame2( self.TotalBack, {} )

				local TotalElemFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.54, 0 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalElem:completeAnimation()
				self.TotalElem:setRGB( 1, 0.54, 0 )
				self.TotalElem:setAlpha( 1 )
				TotalElemFrame2( self.TotalElem, {} )

				local TotalGlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 0.79, 0.5, 0.25 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalGlow:completeAnimation()
				self.TotalGlow:setRGB( 0.79, 0.5, 0.25 )
				self.TotalGlow:setAlpha( 0.48 )
				TotalGlowFrame2( self.TotalGlow, {} )

				local TotalGlowTopFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.97, 0.33 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalGlowTop:completeAnimation()
				self.TotalGlowTop:setRGB( 1, 0.97, 0.33 )
				self.TotalGlowTop:setAlpha( 0.27 )
				TotalGlowTopFrame2( self.TotalGlowTop, {} )

				local TotalFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.99, 0.93 )
					element:setAlpha( 0 )
					element:setZoom( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Total:completeAnimation()
				self.Total:setRGB( 1, 0.99, 0.93 )
				self.Total:setAlpha( 0.94 )
				self.Total:setZoom( 0 )
				TotalFrame2( self.Total, {} )
			end,

			AmmoPickup = function ()
				self:setupElementClipCounter( 7 )

				local TotalBackFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 10.71, 76.9 )
					element:setTopBottom( true, false, 3, 47 )
					element:setAlpha( 0.1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalBack:completeAnimation()
				self.TotalBack:setLeftRight( true, false, 10.71, 76.9 )
				self.TotalBack:setTopBottom( true, false, 38, 82 )
				self.TotalBack:setAlpha( 0.1 )
				TotalBackFrame2( self.TotalBack, {} )

				local TotalElemFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 25, 65 )
					element:setTopBottom( true, false, 8, 44 )
					element:setRGB( 1, 0.54, 0 )
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalElem:completeAnimation()
				self.TotalElem:setLeftRight( true, false, 25, 65 )
				self.TotalElem:setTopBottom( true, false, 43, 79 )
				self.TotalElem:setRGB( 1, 0.54, 0 )
				self.TotalElem:setAlpha( 0.49 )
				TotalElemFrame2( self.TotalElem, {} )

				self.TotalGlow:completeAnimation()
				self.TotalGlow:setAlpha( 0.48 )
				self.clipFinished( self.TotalGlow, {} )

				self.TotalGlowTop:completeAnimation()
				self.TotalGlowTop:setAlpha( 0.27 )
				self.clipFinished( self.TotalGlowTop, {} )

				local TotalFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 7.71, 73.9 )
					element:setTopBottom( true, false, 4, 48 )
					element:setRGB( 1, 0.99, 0.93 )
					element:setAlpha( 0.94 )
					element:setZoom( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Total:completeAnimation()
				self.Total:setLeftRight( true, false, 7.71, 73.9 )
				self.Total:setTopBottom( true, false, 34, 78 )
				self.Total:setRGB( 1, 0.99, 0.93 )
				self.Total:setAlpha( 0.05 )
				self.Total:setZoom( 0 )
				TotalFrame2( self.Total, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end
		},

		NoAmmo = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.TotalBack:completeAnimation()
				self.TotalBack:setAlpha( 0.1 )
				self.clipFinished( self.TotalBack, {} )

				self.TotalElem:completeAnimation()
				self.TotalElem:setRGB( 1, 0.15, 0 )
				self.TotalElem:setAlpha( 1 )
				self.clipFinished( self.TotalElem, {} )

				self.TotalGlow:completeAnimation()
				self.TotalGlow:setRGB( 0.79, 0.26, 0.25 )
				self.TotalGlow:setAlpha( 0.48 )
				self.clipFinished( self.TotalGlow, {} )

				self.TotalGlowTop:completeAnimation()
				self.TotalGlowTop:setRGB( 1, 0.33, 0.36 )
				self.TotalGlowTop:setAlpha( 0.27 )
				self.clipFinished( self.TotalGlowTop, {} )

				self.Total:completeAnimation()
				self.Total:setRGB( 1, 0.49, 0.49 )
				self.Total:setAlpha( 0.94 )
				self.Total:setZoom( 0 )
				self.clipFinished( self.Total, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setRGB( 1, 1, 1 )
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 6 )

				local TotalElemFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Linear )
					end
					element:setRGB( 1, 0.54, 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalElem:completeAnimation()
				self.TotalElem:setRGB( 1, 0.15, 0 )
				TotalElemFrame2( self.TotalElem, {} )

				local TotalGlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Linear )
					end
					element:setRGB( 0.79, 0.5, 0.25 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalGlow:completeAnimation()
				self.TotalGlow:setRGB( 0.79, 0.26, 0.25 )
				TotalGlowFrame2( self.TotalGlow, {} )

				local TotalGlowTopFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Linear )
					end
					element:setRGB( 1, 0.97, 0.33 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalGlowTop:completeAnimation()
				self.TotalGlowTop:setRGB( 1, 0.33, 0.36 )
				TotalGlowTopFrame2( self.TotalGlowTop, {} )

				local TotalFrame2 = function ( element, event )
					local TotalFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Bounce )
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
						TotalFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
						element:setRGB( 1, 0.94, 0.88 )
						element:setZoom( 25 )
						element:registerEventHandler( "transition_complete_keyframe", TotalFrame3 )
					end
				end
				
				self.Total:completeAnimation()
				self.Total:setRGB( 1, 0.49, 0.49 )
				self.Total:setZoom( 0 )
				TotalFrame2( self.Total, {} )

				local ZmFxSpark20Frame2 = function ( element, event )
					local ZmFxSpark20Frame3 = function ( element, event )
						local ZmFxSpark20Frame4 = function ( element, event )
							local ZmFxSpark20Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 499, false, false, CoD.TweenType.Linear )
								end
								element:setLeftRight( true, false, 14.21, 91.41 )
								element:setTopBottom( true, false, -49, 56 )
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
								element:beginAnimation( "keyframe", 319, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0.87 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame5 )
							end
						end

						if event.interrupted then
							ZmFxSpark20Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
							element:setTopBottom( true, false, -49, 56 )
							element:setAlpha( 0.95 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame4 )
						end
					end

					if event.interrupted then
						ZmFxSpark20Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -16.13, 56 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame3 )
					end
				end
				
				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setLeftRight( true, false, 14.21, 91.41 )
				self.ZmFxSpark20:setTopBottom( true, false, -7, 56 )
				self.ZmFxSpark20:setAlpha( 0.67 )
				ZmFxSpark20Frame2( self.ZmFxSpark20, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 289, false, false, CoD.TweenType.Linear )
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
						element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.85 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setRGB( 1, 1, 1 )
				self.ZmFxFlsh:setAlpha( 0.35 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			HeroWeapon = function ()
				self:setupElementClipCounter( 5 )

				local TotalBackFrame2 = function ( element, event )
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
				
				self.TotalBack:completeAnimation()
				self.TotalBack:setAlpha( 0.1 )
				TotalBackFrame2( self.TotalBack, {} )

				local TotalElemFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.15, 0 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalElem:completeAnimation()
				self.TotalElem:setRGB( 1, 0.15, 0 )
				self.TotalElem:setAlpha( 1 )
				TotalElemFrame2( self.TotalElem, {} )

				local TotalGlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 0.79, 0.26, 0.25 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalGlow:completeAnimation()
				self.TotalGlow:setRGB( 0.79, 0.26, 0.25 )
				self.TotalGlow:setAlpha( 0.48 )
				TotalGlowFrame2( self.TotalGlow, {} )

				local TotalGlowTopFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.33, 0.36 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalGlowTop:completeAnimation()
				self.TotalGlowTop:setRGB( 1, 0.33, 0.36 )
				self.TotalGlowTop:setAlpha( 0.27 )
				TotalGlowTopFrame2( self.TotalGlowTop, {} )

				local TotalFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.49, 0.49 )
					element:setAlpha( 0 )
					element:setZoom( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Total:completeAnimation()
				self.Total:setRGB( 1, 0.49, 0.49 )
				self.Total:setAlpha( 0.94 )
				self.Total:setZoom( 0 )
				TotalFrame2( self.Total, {} )
			end
		},

		HeroWeapon = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.TotalBack:completeAnimation()
				self.TotalBack:setAlpha( 0 )
				self.clipFinished( self.TotalBack, {} )

				self.TotalElem:completeAnimation()
				self.TotalElem:setAlpha( 0 )
				self.clipFinished( self.TotalElem, {} )

				self.TotalGlow:completeAnimation()
				self.TotalGlow:setAlpha( 0 )
				self.clipFinished( self.TotalGlow, {} )

				self.TotalGlowTop:completeAnimation()
				self.TotalGlowTop:setAlpha( 0 )
				self.clipFinished( self.TotalGlowTop, {} )

				self.Total:completeAnimation()
				self.Total:setAlpha( 0 )
				self.clipFinished( self.Total, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 5 )

				local TotalBackFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 0.1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalBack:completeAnimation()
				self.TotalBack:setAlpha( 0 )
				TotalBackFrame2( self.TotalBack, {} )

				local TotalElemFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.54, 0 )
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalElem:completeAnimation()
				self.TotalElem:setRGB( 1, 0.54, 0 )
				self.TotalElem:setAlpha( 0 )
				TotalElemFrame2( self.TotalElem, {} )

				local TotalGlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 0.79, 0.5, 0.25 )
					element:setAlpha( 0.48 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalGlow:completeAnimation()
				self.TotalGlow:setRGB( 0.79, 0.5, 0.25 )
				self.TotalGlow:setAlpha( 0 )
				TotalGlowFrame2( self.TotalGlow, {} )

				local TotalGlowTopFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.97, 0.33 )
					element:setAlpha( 0.27 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalGlowTop:completeAnimation()
				self.TotalGlowTop:setRGB( 1, 0.97, 0.33 )
				self.TotalGlowTop:setAlpha( 0 )
				TotalGlowTopFrame2( self.TotalGlowTop, {} )

				local TotalFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.99, 0.93 )
					element:setAlpha( 0.94 )
					element:setZoom( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Total:completeAnimation()
				self.Total:setRGB( 1, 0.99, 0.93 )
				self.Total:setAlpha( 0 )
				self.Total:setZoom( 0 )
				TotalFrame2( self.Total, {} )
			end,

			NoAmmo = function ()
				self:setupElementClipCounter( 5 )

				local TotalBackFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 0.1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalBack:completeAnimation()
				self.TotalBack:setAlpha( 0 )
				TotalBackFrame2( self.TotalBack, {} )

				local TotalElemFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.15, 0 )
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalElem:completeAnimation()
				self.TotalElem:setRGB( 1, 0.15, 0 )
				self.TotalElem:setAlpha( 0 )
				TotalElemFrame2( self.TotalElem, {} )

				local TotalGlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 0.79, 0.26, 0.25 )
					element:setAlpha( 0.48 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalGlow:completeAnimation()
				self.TotalGlow:setRGB( 0.79, 0.26, 0.25 )
				self.TotalGlow:setAlpha( 0 )
				TotalGlowFrame2( self.TotalGlow, {} )

				local TotalGlowTopFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.33, 0.36 )
					element:setAlpha( 0.27 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.TotalGlowTop:completeAnimation()
				self.TotalGlowTop:setRGB( 1, 0.33, 0.36 )
				self.TotalGlowTop:setAlpha( 0 )
				TotalGlowTopFrame2( self.TotalGlowTop, {} )

				local TotalFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setRGB( 1, 0.49, 0.49 )
					element:setAlpha( 0.94 )
					element:setZoom( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Total:completeAnimation()
				self.Total:setRGB( 1, 0.49, 0.49 )
				self.Total:setAlpha( 0 )
				self.Total:setZoom( 0 )
				TotalFrame2( self.Total, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "NoAmmo",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "HeroWeapon",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "currentWeapon.viewmodelWeaponName", "zod_riotshield_zm" )
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.viewmodelWeaponName" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.viewmodelWeaponName" } )
	end )

	self:subscribeToGlobalModel( controller, "PerController", "hudItems.ammoPickedUp", function ( model )
		PlayClip( self, "AmmoPickup", controller )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ZmFxSpark20:close()
		element.TotalBack:close()
		element.Total:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end