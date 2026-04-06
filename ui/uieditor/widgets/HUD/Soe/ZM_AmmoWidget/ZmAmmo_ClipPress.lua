CoD.ZmAmmo_ClipPress = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_ClipPress.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_ClipPress )
	self.id = "ZmAmmo_ClipPress"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 108 )
	self:setTopBottom( true, false, 0, 42 )
	
	self.Clip0 = LUI.UIText.new()
	self.Clip0:setLeftRight( true, false, -4, 104 )
	self.Clip0:setTopBottom( true, false, -11, 53 )
	self.Clip0:setRGB( 1, 0, 0.13 )
	self.Clip0:setTTF( "fonts/WEARETRIPPINShort.ttf" )
	self.Clip0:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.Clip0:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.Clip0:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self.Clip0:subscribeToGlobalModel( controller, "CurrentWeapon", "ammoInClip", function ( model )
		local ammoInClip = Engine.GetModelValue( model )
		if ammoInClip then
			self.Clip0:setText( Engine.Localize( ammoInClip ) )
		end
	end )
	self:addElement( self.Clip0 )
	
	self.ClipGlowTop = LUI.UIImage.new()
	self.ClipGlowTop:setLeftRight( true, false, 7.9, 100.1 )
	self.ClipGlowTop:setTopBottom( true, false, -15.75, 57.75 )
	self.ClipGlowTop:setRGB( 1, 0.32, 0 )
	self.ClipGlowTop:setAlpha( 0 )
	self.ClipGlowTop:setZRot( -4 )
	self.ClipGlowTop:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.ClipGlowTop:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ClipGlowTop )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setAlpha( 0 )
				self.clipFinished( self.ClipGlowTop, {} )
			end
		},

		NoAmmoPress = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				local Clip0Frame2 = function ( element, event )
					local Clip0Frame3 = function ( element, event )
						local Clip0Frame4 = function ( element, event )
							local Clip0Frame5 = function ( element, event )
								local Clip0Frame6 = function ( element, event )
									local Clip0Frame7 = function ( element, event )
										local Clip0Frame8 = function ( element, event )
											local Clip0Frame9 = function ( element, event )
												local Clip0Frame10 = function ( element, event )
													if not event.interrupted then
														element:beginAnimation( "keyframe", 109, false, false, CoD.TweenType.Linear )
													end
													element:setLeftRight( true, false, -56.5, 167.39 )
													element:setTopBottom( true, false, -43.45, 89.23 )
													element:setAlpha( 0 )
													if event.interrupted then
														self.clipFinished( element, event )
													else
														element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
													end
												end

												if event.interrupted then
													Clip0Frame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 119, false, false, CoD.TweenType.Linear )
													element:setLeftRight( true, false, -46.5, 148.39 )
													element:setTopBottom( true, false, -34.45, 81.04 )
													element:setAlpha( 0.84 )
													element:registerEventHandler( "transition_complete_keyframe", Clip0Frame10 )
												end
											end

											if event.interrupted then
												Clip0Frame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
												element:setLeftRight( true, false, -25.25, 126.2 )
												element:setTopBottom( true, false, -22.73, 67.02 )
												element:setAlpha( 1 )
												element:registerEventHandler( "transition_complete_keyframe", Clip0Frame9 )
											end
										end

										if event.interrupted then
											Clip0Frame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 20, false, false, CoD.TweenType.Linear )
											element:setLeftRight( true, false, -19.94, 120.65 )
											element:setTopBottom( true, false, -19.79, 63.52 )
											element:setAlpha( 0.75 )
											element:registerEventHandler( "transition_complete_keyframe", Clip0Frame8 )
										end
									end

									if event.interrupted then
										Clip0Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
										element:setLeftRight( true, false, -16.4, 116.95 )
										element:setTopBottom( true, false, -17.84, 61.18 )
										element:setAlpha( 0.09 )
										element:registerEventHandler( "transition_complete_keyframe", Clip0Frame7 )
									end
								end

								if event.interrupted then
									Clip0Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -14.62, 115.1 )
									element:setTopBottom( true, false, -16.86, 60.01 )
									element:setAlpha( 0.5 )
									element:registerEventHandler( "transition_complete_keyframe", Clip0Frame6 )
								end
							end

							if event.interrupted then
								Clip0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, -9.31, 109.55 )
								element:setTopBottom( true, false, -13.93, 56.51 )
								element:setAlpha( 0.25 )
								element:registerEventHandler( "transition_complete_keyframe", Clip0Frame5 )
							end
						end

						if event.interrupted then
							Clip0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -7.54, 107.7 )
							element:setTopBottom( true, false, -12.95, 55.34 )
							element:setAlpha( 0.72 )
							element:registerEventHandler( "transition_complete_keyframe", Clip0Frame4 )
						end
					end

					if event.interrupted then
						Clip0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, -5.77, 105.85 )
						element:setTopBottom( true, false, -11.98, 54.17 )
						element:setAlpha( 0.08 )
						element:registerEventHandler( "transition_complete_keyframe", Clip0Frame3 )
					end
				end
				
				self.Clip0:completeAnimation()
				self.Clip0:setLeftRight( true, false, -4, 104 )
				self.Clip0:setTopBottom( true, false, -11, 53 )
				self.Clip0:setAlpha( 0 )
				Clip0Frame2( self.Clip0, {} )

				local ClipGlowTopFrame2 = function ( element, event )
					local ClipGlowTopFrame3 = function ( element, event )
						local ClipGlowTopFrame4 = function ( element, event )
							local ClipGlowTopFrame5 = function ( element, event )
								local ClipGlowTopFrame6 = function ( element, event )
									local ClipGlowTopFrame7 = function ( element, event )
										if not event.interrupted then
											element:beginAnimation( "keyframe", 170, false, false, CoD.TweenType.Bounce )
										end
										element:setAlpha( 0 )
										if event.interrupted then
											self.clipFinished( element, event )
										else
											element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
										end
									end
									
									if event.interrupted then
										ClipGlowTopFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
										element:registerEventHandler( "transition_complete_keyframe", ClipGlowTopFrame7 )
									end
								end

								if event.interrupted then
									ClipGlowTopFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 20, false, false, CoD.TweenType.Bounce )
									element:setAlpha( 1 )
									element:registerEventHandler( "transition_complete_keyframe", ClipGlowTopFrame6 )
								end
							end

							if event.interrupted then
								ClipGlowTopFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Bounce )
								element:setAlpha( 0.46 )
								element:registerEventHandler( "transition_complete_keyframe", ClipGlowTopFrame5 )
							end
						end

						if event.interrupted then
							ClipGlowTopFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ClipGlowTopFrame4 )
						end
					end

					if event.interrupted then
						ClipGlowTopFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ClipGlowTopFrame3 )
					end
				end
				
				self.ClipGlowTop:completeAnimation()
				self.ClipGlowTop:setAlpha( 0 )
				ClipGlowTopFrame2( self.ClipGlowTop, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.Clip0:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end