local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
		CoD.UIColors.SetElementColor( self.AbilitySwirl, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.BBGumRingBacker, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.BBGumRing000, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.BBGumRing00, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.BBGumRing0, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.BBGumRing, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.BBGumRingEdge, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.Glow1, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_BBGumMeterWidget = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_BBGumMeterWidget.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_BBGumMeterWidget )
	self.id = "ZmAmmo_BBGumMeterWidget"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 53 )
	self:setTopBottom( true, false, 0, 53 )
	
	self.AbilitySwirl = LUI.UIImage.new()
	self.AbilitySwirl:setLeftRight( true, false, -4.99, 57.87 )
	self.AbilitySwirl:setTopBottom( true, false, -4.93, 57.93 )
	self.AbilitySwirl:setRGB( 1, 0.64, 0 )
	self.AbilitySwirl:setAlpha( 0.9 )
	self.AbilitySwirl:setImage( RegisterImage( "uie_t7_core_hud_ammowidget_abilityswirl" ) )
	self.AbilitySwirl:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.AbilitySwirl )
	
	self.BBGumRingBacker = LUI.UIImage.new()
	self.BBGumRingBacker:setLeftRight( true, false, 0, 53 )
	self.BBGumRingBacker:setTopBottom( true, false, 0, 53 )
	self.BBGumRingBacker:setAlpha( 0.1 )
	self.BBGumRingBacker:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bbgummeterringbacker" ) )
	self:addElement( self.BBGumRingBacker )
	
	self.BBGumRing000 = LUI.UIImage.new()
	self.BBGumRing000:setLeftRight( true, false, 0, 53 )
	self.BBGumRing000:setTopBottom( true, false, 0, 53 )
	self.BBGumRing000:setRGB( 1, 0.85, 0 )
	self.BBGumRing000:setAlpha( 0.5 )
	self.BBGumRing000:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bbgummeterringblur3" ) )
	self.BBGumRing000:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_clock_normal" ) )
	self.BBGumRing000:setShaderVector( 1, 0.5, 0, 0, 0 )
	self.BBGumRing000:setShaderVector( 2, 0.5, 0, 0, 0 )
	self.BBGumRing000:setShaderVector( 3, 0.08, 0, 0, 0 )
	self.BBGumRing000:subscribeToGlobalModel( controller, "PerController", "bgb_timer", function ( model )
		local bgbTimer = Engine.GetModelValue( model )
		if bgbTimer then
			self.BBGumRing000:setShaderVector( 0, CoD.GetVectorComponentFromString( bgbTimer, 1 ), CoD.GetVectorComponentFromString( bgbTimer, 2 ), CoD.GetVectorComponentFromString( bgbTimer, 3 ), CoD.GetVectorComponentFromString( bgbTimer, 4 ) )
		end
	end )
	self:addElement( self.BBGumRing000 )
	
	self.BBGumRing00 = LUI.UIImage.new()
	self.BBGumRing00:setLeftRight( true, false, 0, 53 )
	self.BBGumRing00:setTopBottom( true, false, 0, 53 )
	self.BBGumRing00:setRGB( 1, 0.69, 0 )
	self.BBGumRing00:setAlpha( 0.5 )
	self.BBGumRing00:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bbgummeterringblur1" ) )
	self.BBGumRing00:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_clock_normal" ) )
	self.BBGumRing00:setShaderVector( 1, 0.5, 0, 0, 0 )
	self.BBGumRing00:setShaderVector( 2, 0.5, 0, 0, 0 )
	self.BBGumRing00:setShaderVector( 3, 0.08, 0, 0, 0 )
	self.BBGumRing00:subscribeToGlobalModel( controller, "PerController", "bgb_timer", function ( model )
		local bgbTimer = Engine.GetModelValue( model )
		if bgbTimer then
			self.BBGumRing00:setShaderVector( 0, CoD.GetVectorComponentFromString( bgbTimer, 1 ), CoD.GetVectorComponentFromString( bgbTimer, 2 ), CoD.GetVectorComponentFromString( bgbTimer, 3 ), CoD.GetVectorComponentFromString( bgbTimer, 4 ) )
		end
	end )
	self:addElement( self.BBGumRing00 )
	
	self.BBGumRing0 = LUI.UIImage.new()
	self.BBGumRing0:setLeftRight( true, false, 0, 53 )
	self.BBGumRing0:setTopBottom( true, false, 0, 53 )
	self.BBGumRing0:setRGB( 1, 0.78, 0 )
	self.BBGumRing0:setAlpha( 0.5 )
	self.BBGumRing0:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bbgummeterringblur1" ) )
	self.BBGumRing0:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_clock_normal" ) )
	self.BBGumRing0:setShaderVector( 1, 0.5, 0, 0, 0 )
	self.BBGumRing0:setShaderVector( 2, 0.5, 0, 0, 0 )
	self.BBGumRing0:setShaderVector( 3, 0.08, 0, 0, 0 )
	self.BBGumRing0:subscribeToGlobalModel( controller, "PerController", "bgb_timer", function ( model )
		local bgbTimer = Engine.GetModelValue( model )
		if bgbTimer then
			self.BBGumRing0:setShaderVector( 0, CoD.GetVectorComponentFromString( bgbTimer, 1 ), CoD.GetVectorComponentFromString( bgbTimer, 2 ), CoD.GetVectorComponentFromString( bgbTimer, 3 ), CoD.GetVectorComponentFromString( bgbTimer, 4 ) )
		end
	end )
	self:addElement( self.BBGumRing0 )
	
	self.BBGumRing = LUI.UIImage.new()
	self.BBGumRing:setLeftRight( true, false, 0, 52.89 )
	self.BBGumRing:setTopBottom( true, false, 0, 52.88 )
	self.BBGumRing:setRGB( 1, 0.96, 0.75 )
	self.BBGumRing:setAlpha( 0.75 )
	self.BBGumRing:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bbgummeterring" ) )
	self.BBGumRing:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_clock_normal" ) )
	self.BBGumRing:setShaderVector( 1, 0.5, 0, 0, 0 )
	self.BBGumRing:setShaderVector( 2, 0.5, 0, 0, 0 )
	self.BBGumRing:setShaderVector( 3, 0.08, 0, 0, 0 )
	self.BBGumRing:subscribeToGlobalModel( controller, "PerController", "bgb_timer", function ( model )
		local bgbTimer = Engine.GetModelValue( model )
		if bgbTimer then
			self.BBGumRing:setShaderVector( 0, CoD.GetVectorComponentFromString( bgbTimer, 1 ), CoD.GetVectorComponentFromString( bgbTimer, 2 ), CoD.GetVectorComponentFromString( bgbTimer, 3 ), CoD.GetVectorComponentFromString( bgbTimer, 4 ) )
		end
	end )
	self:addElement( self.BBGumRing )
	
	self.BBGumRingEdge = LUI.UIImage.new()
	self.BBGumRingEdge:setLeftRight( true, false, 0, 52.89 )
	self.BBGumRingEdge:setTopBottom( true, false, 0, 52.88 )
	self.BBGumRingEdge:setRGB( 1, 0.83, 0.08 )
	self.BBGumRingEdge:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bbgummeterring" ) )
	self.BBGumRingEdge:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_clock_normal" ) )
	self.BBGumRingEdge:setShaderVector( 1, 0.5, 0, 0, 0 )
	self.BBGumRingEdge:setShaderVector( 2, 0.5, 0, 0, 0 )
	self.BBGumRingEdge:setShaderVector( 3, 0.08, -0.22, 0, 0 )
	self.BBGumRingEdge:subscribeToGlobalModel( controller, "PerController", "bgb_timer", function ( model )
		local bgbTimer = Engine.GetModelValue( model )
		if bgbTimer then
			self.BBGumRingEdge:setShaderVector( 0, CoD.GetVectorComponentFromString( bgbTimer, 1 ), CoD.GetVectorComponentFromString( bgbTimer, 2 ), CoD.GetVectorComponentFromString( bgbTimer, 3 ), CoD.GetVectorComponentFromString( bgbTimer, 4 ) )
		end
	end )
	self:addElement( self.BBGumRingEdge )
	
	self.BBGumTexture = LUI.UIImage.new()
	self.BBGumTexture:setLeftRight( true, false, 8, 44 )
	self.BBGumTexture:setTopBottom( true, false, 8, 44 )
	self.BBGumTexture:subscribeToGlobalModel( controller, "PerController", "bgb_current", function ( model )
		local bgbCurrent = Engine.GetModelValue( model )
		if bgbCurrent then
			self.BBGumTexture:setImage( RegisterImage( GetItemImageFromIndex( bgbCurrent ) ) )
		end
	end )
	self:addElement( self.BBGumTexture )
	
	self.Glow1 = LUI.UIImage.new()
	self.Glow1:setLeftRight( true, false, -3.56, 55.44 )
	self.Glow1:setTopBottom( true, false, -2.56, 56.44 )
	self.Glow1:setRGB( 1, 0.28, 0 )
	self.Glow1:setAlpha( 0.75 )
	self.Glow1:setZRot( -4 )
	self.Glow1:setScale( 1.2 )
	self.Glow1:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.Glow1:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Glow1 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 9 )

				self.AbilitySwirl:completeAnimation()
				self.AbilitySwirl:setAlpha( 0 )
				self.clipFinished( self.AbilitySwirl, {} )

				self.BBGumRingBacker:completeAnimation()
				self.BBGumRingBacker:setAlpha( 0 )
				self.clipFinished( self.BBGumRingBacker, {} )

				self.BBGumRing000:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing000, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing000:setAlpha( 0 )
				self.clipFinished( self.BBGumRing000, {} )

				self.BBGumRing00:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing00, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing00:setAlpha( 0 )
				self.clipFinished( self.BBGumRing00, {} )

				self.BBGumRing0:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing0, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing0:setAlpha( 0 )
				self.clipFinished( self.BBGumRing0, {} )

				self.BBGumRing:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing:setAlpha( 0 )
				self.clipFinished( self.BBGumRing, {} )

				self.BBGumRingEdge:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRingEdge, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRingEdge:setAlpha( 0 )
				self.clipFinished( self.BBGumRingEdge, {} )

				self.BBGumTexture:completeAnimation()
				self.BBGumTexture:setAlpha( 0 )
				self.BBGumTexture:setScale( 1 )
				self.clipFinished( self.BBGumTexture, {} )

				self.Glow1:completeAnimation()
				self.Glow1:setAlpha( 0 )
				self.clipFinished( self.Glow1, {} )
			end
		},

		ActiveLow = {
			DefaultClip = function ()
				self:setupElementClipCounter( 9 )

				self.AbilitySwirl:completeAnimation()
				self.AbilitySwirl:setAlpha( 0 )
				self.clipFinished( self.AbilitySwirl, {} )

				self.BBGumRingBacker:completeAnimation()
				self.BBGumRingBacker:setAlpha( 0.1 )
				self.clipFinished( self.BBGumRingBacker, {} )

				self.BBGumRing000:completeAnimation()
				self.BBGumRing000:setRGB( 1, 0.07, 0 )
				self.BBGumRing000:setAlpha( 0.5 )
				self.clipFinished( self.BBGumRing000, {} )

				self.BBGumRing00:completeAnimation()
				self.BBGumRing00:setRGB( 1, 0.08, 0 )
				self.BBGumRing00:setAlpha( 0.5 )
				self.clipFinished( self.BBGumRing00, {} )

				self.BBGumRing0:completeAnimation()
				self.BBGumRing0:setRGB( 1, 0.18, 0 )
				self.BBGumRing0:setAlpha( 0.5 )
				self.clipFinished( self.BBGumRing0, {} )

				self.BBGumRing:completeAnimation()
				self.BBGumRing:setRGB( 1, 0.77, 0.75 )
				self.BBGumRing:setAlpha( 0.7 )
				self.clipFinished( self.BBGumRing, {} )

				self.BBGumRingEdge:completeAnimation()
				self.BBGumRingEdge:setRGB( 1, 0.21, 0.12 )
				self.BBGumRingEdge:setAlpha( 1 )
				self.clipFinished( self.BBGumRingEdge, {} )

				self.BBGumTexture:completeAnimation()
				self.BBGumTexture:setLeftRight( true, false, 8, 44 )
				self.BBGumTexture:setTopBottom( true, false, 8, 44 )
				self.BBGumTexture:setAlpha( 1 )
				self.clipFinished( self.BBGumTexture, {} )

				self.Glow1:beginAnimation( "keyframe", 2000, false, false, CoD.TweenType.Linear )
				self.Glow1:setAlpha( 0 )
				self.Glow1:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 1 )

				local BBGumTextureFrame2 = function ( element, event )
					local BBGumTextureFrame3 = function ( element, event )
						local BBGumTextureFrame4 = function ( element, event )
							local BBGumTextureFrame5 = function ( element, event )
								local BBGumTextureFrame6 = function ( element, event )
									local BBGumTextureFrame7 = function ( element, event )
										local BBGumTextureFrame8 = function ( element, event )
											local BBGumTextureFrame9 = function ( element, event )
												local BBGumTextureFrame10 = function ( element, event )
													if not event.interrupted then
														element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
													end
													element:setAlpha( 1 )
													element:setScale( 0 )
													if event.interrupted then
														self.clipFinished( element, event )
													else
														element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
													end
												end

												if event.interrupted then
													BBGumTextureFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 309, false, false, CoD.TweenType.Linear )
													element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame10 )
												end
											end

											if event.interrupted then
												BBGumTextureFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 169, false, false, CoD.TweenType.Linear )
												element:setScale( 1 )
												element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame9 )
											end
										end

										if event.interrupted then
											BBGumTextureFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 160, false, false, CoD.TweenType.Linear )
											element:setScale( 0.8 )
											element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame8 )
										end
									end

									if event.interrupted then
										BBGumTextureFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 149, false, false, CoD.TweenType.Linear )
										element:setScale( 1.2 )
										element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame7 )
									end
								end

								if event.interrupted then
									BBGumTextureFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 560, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame6 )
								end
							end

							if event.interrupted then
								BBGumTextureFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 139, false, false, CoD.TweenType.Linear )
								element:setScale( 1 )
								element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame5 )
							end
						end

						if event.interrupted then
							BBGumTextureFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Linear )
							element:setScale( 0.8 )
							element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame4 )
						end
					end

					if event.interrupted then
						BBGumTextureFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setScale( 1.2 )
						element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame3 )
					end
				end
				
				self.BBGumTexture:completeAnimation()
				self.BBGumTexture:setAlpha( 1 )
				self.BBGumTexture:setScale( 0 )
				BBGumTextureFrame2( self.BBGumTexture, {} )
			end
		},

		Active = {
			DefaultClip = function ()
				self:setupElementClipCounter( 9 )

				self.AbilitySwirl:completeAnimation()
				self.AbilitySwirl:setAlpha( 0 )
				self.clipFinished( self.AbilitySwirl, {} )

				self.BBGumRingBacker:completeAnimation()
				self.BBGumRingBacker:setAlpha( 0.1 )
				self.clipFinished( self.BBGumRingBacker, {} )

				self.BBGumRing000:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing000, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing000:setAlpha( 0.5 )
				self.clipFinished( self.BBGumRing000, {} )

				self.BBGumRing00:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing00, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing00:setAlpha( 0.5 )
				self.clipFinished( self.BBGumRing00, {} )

				self.BBGumRing0:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing0, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing0:setAlpha( 0.5 )
				self.clipFinished( self.BBGumRing0, {} )

				self.BBGumRing:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing:setAlpha( 0.7 )
				self.clipFinished( self.BBGumRing, {} )

				self.BBGumRingEdge:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRingEdge, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRingEdge:setAlpha( 1 )
				self.clipFinished( self.BBGumRingEdge, {} )

				self.BBGumTexture:completeAnimation()
				self.BBGumTexture:setLeftRight( true, false, 8, 44 )
				self.BBGumTexture:setTopBottom( true, false, 8, 44 )
				self.BBGumTexture:setAlpha( 1 )
				self.BBGumTexture:setScale( 1 )
				self.clipFinished( self.BBGumTexture, {} )

				self.Glow1:beginAnimation( "keyframe", 2000, false, false, CoD.TweenType.Linear )
				self.Glow1:setAlpha( 0 )
				self.Glow1:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 1 )

				local BBGumTextureFrame2 = function ( element, event )
					local BBGumTextureFrame3 = function ( element, event )
						local BBGumTextureFrame4 = function ( element, event )
							local BBGumTextureFrame5 = function ( element, event )
								local BBGumTextureFrame6 = function ( element, event )
									local BBGumTextureFrame7 = function ( element, event )
										local BBGumTextureFrame8 = function ( element, event )
											local BBGumTextureFrame9 = function ( element, event )
												local BBGumTextureFrame10 = function ( element, event )
													if not event.interrupted then
														element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
													end
													element:setAlpha( 1 )
													element:setScale( 0 )
													if event.interrupted then
														self.clipFinished( element, event )
													else
														element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
													end
												end

												if event.interrupted then
													BBGumTextureFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 309, false, false, CoD.TweenType.Linear )
													element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame10 )
												end
											end

											if event.interrupted then
												BBGumTextureFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 169, false, false, CoD.TweenType.Linear )
												element:setScale( 1 )
												element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame9 )
											end
										end

										if event.interrupted then
											BBGumTextureFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 160, false, false, CoD.TweenType.Linear )
											element:setScale( 0.8 )
											element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame8 )
										end
									end

									if event.interrupted then
										BBGumTextureFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 149, false, false, CoD.TweenType.Linear )
										element:setScale( 1.2 )
										element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame7 )
									end
								end

								if event.interrupted then
									BBGumTextureFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 560, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame6 )
								end
							end

							if event.interrupted then
								BBGumTextureFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 139, false, false, CoD.TweenType.Linear )
								element:setScale( 1 )
								element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame5 )
							end
						end

						if event.interrupted then
							BBGumTextureFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Linear )
							element:setScale( 0.8 )
							element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame4 )
						end
					end

					if event.interrupted then
						BBGumTextureFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setScale( 1.2 )
						element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame3 )
					end
				end
				
				self.BBGumTexture:completeAnimation()
				self.BBGumTexture:setAlpha( 1 )
				self.BBGumTexture:setScale( 0 )
				BBGumTextureFrame2( self.BBGumTexture, {} )
			end
		},

		Inactive = {
			DefaultClip = function ()
				self:setupElementClipCounter( 9 )

				self.AbilitySwirl:completeAnimation()
				self.AbilitySwirl:setAlpha( 0 )
				self.clipFinished( self.AbilitySwirl, {} )

				self.BBGumRingBacker:completeAnimation()
				self.BBGumRingBacker:setAlpha( 0.1 )
				self.clipFinished( self.BBGumRingBacker, {} )

				self.BBGumRing000:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing000, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing000:setAlpha( 0 )
				self.clipFinished( self.BBGumRing000, {} )

				self.BBGumRing00:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing00, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing00:setAlpha( 0 )
				self.clipFinished( self.BBGumRing00, {} )

				self.BBGumRing0:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing0, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing0:setAlpha( 0 )
				self.clipFinished( self.BBGumRing0, {} )

				self.BBGumRing:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing:setAlpha( 0 )
				self.clipFinished( self.BBGumRing, {} )

				self.BBGumRingEdge:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRingEdge, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRingEdge:setAlpha( 0 )
				self.clipFinished( self.BBGumRingEdge, {} )

				self.BBGumTexture:completeAnimation()
				self.BBGumTexture:setLeftRight( true, false, 8, 44 )
				self.BBGumTexture:setTopBottom( true, false, 8, 44 )
				self.BBGumTexture:setAlpha( 1 )
				self.clipFinished( self.BBGumTexture, {} )

				self.Glow1:beginAnimation( "keyframe", 2000, false, false, CoD.TweenType.Linear )
				self.Glow1:setAlpha( 0 )
				self.Glow1:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
			end,

			Active = function ()
				self:setupElementClipCounter( 9 )

				local AbilitySwirlFrame2 = function ( element, event )
					local AbilitySwirlFrame3 = function ( element, event )
						local AbilitySwirlFrame4 = function ( element, event )
							local AbilitySwirlFrame5 = function ( element, event )
								local AbilitySwirlFrame6 = function ( element, event )
									if not event.interrupted then
										element:beginAnimation( "keyframe", 30, false, false, CoD.TweenType.Linear )
									end
									element:setLeftRight( true, false, -4.99, 57.87 )
									element:setTopBottom( true, false, -4.93, 57.93 )
									element:setAlpha( 0 )
									element:setZRot( 631 )
									element:setScale( 1.3 )
									if event.interrupted then
										self.clipFinished( element, event )
									else
										element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
									end
								end

								if event.interrupted then
									AbilitySwirlFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0 )
									element:setZRot( 592.29 )
									element:setScale( 1.25 )
									element:registerEventHandler( "transition_complete_keyframe", AbilitySwirlFrame6 )
								end
							end

							if event.interrupted then
								AbilitySwirlFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
								element:setZRot( 476.14 )
								element:setScale( 1.11 )
								element:registerEventHandler( "transition_complete_keyframe", AbilitySwirlFrame5 )
							end
						end

						if event.interrupted then
							AbilitySwirlFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
							element:setZRot( 360 )
							element:setScale( 0.96 )
							element:registerEventHandler( "transition_complete_keyframe", AbilitySwirlFrame4 )
						end
					end

					if event.interrupted then
						AbilitySwirlFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.9 )
						element:setZRot( 248.28 )
						element:setScale( 0.82 )
						element:registerEventHandler( "transition_complete_keyframe", AbilitySwirlFrame3 )
					end
				end
				
				self.AbilitySwirl:completeAnimation()
				self.AbilitySwirl:setLeftRight( true, false, -4.99, 57.87 )
				self.AbilitySwirl:setTopBottom( true, false, -4.93, 57.93 )
				self.AbilitySwirl:setAlpha( 0 )
				self.AbilitySwirl:setZRot( 0 )
				self.AbilitySwirl:setScale( 0.5 )
				AbilitySwirlFrame2( self.AbilitySwirl, {} )

				local BBGumRingBackerFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0.1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.BBGumRingBacker:completeAnimation()
				self.BBGumRingBacker:setAlpha( 0.1 )
				BBGumRingBackerFrame2( self.BBGumRingBacker, {} )

				local BBGumRing000Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
					end
					CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
					element:setAlpha( 0.5 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.BBGumRing000:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing000, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing000:setAlpha( 0 )
				BBGumRing000Frame2( self.BBGumRing000, {} )

				local BBGumRing00Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
					end
					CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
					element:setAlpha( 0.5 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.BBGumRing00:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing00, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing00:setAlpha( 0 )
				BBGumRing00Frame2( self.BBGumRing00, {} )

				local BBGumRing0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
					end
					CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
					element:setAlpha( 0.5 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.BBGumRing0:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing0, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing0:setAlpha( 0 )
				BBGumRing0Frame2( self.BBGumRing0, {} )

				local BBGumRingFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
					end
					CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
					element:setAlpha( 0.7 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.BBGumRing:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing:setAlpha( 0 )
				BBGumRingFrame2( self.BBGumRing, {} )

				local BBGumRingEdgeFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.BBGumRingEdge:completeAnimation()
				self.BBGumRingEdge:setAlpha( 0 )
				BBGumRingEdgeFrame2( self.BBGumRingEdge, {} )

				local BBGumTextureFrame2 = function ( element, event )
					local BBGumTextureFrame3 = function ( element, event )
						local BBGumTextureFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 1 )
							element:setScale( 1 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							BBGumTextureFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
							element:setScale( 1.2 )
							element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame4 )
						end
					end

					if event.interrupted then
						BBGumTextureFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
						element:setScale( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame3 )
					end
				end
				
				self.BBGumTexture:completeAnimation()
				self.BBGumTexture:setAlpha( 1 )
				self.BBGumTexture:setScale( 1 )
				BBGumTextureFrame2( self.BBGumTexture, {} )

				local Glow1Frame2 = function ( element, event )
					local Glow1Frame3 = function ( element, event )
						local Glow1Frame4 = function ( element, event )
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
							Glow1Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", Glow1Frame4 )
						end
					end

					if event.interrupted then
						Glow1Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.65 )
						element:registerEventHandler( "transition_complete_keyframe", Glow1Frame3 )
					end
				end
				
				self.Glow1:completeAnimation()
				self.Glow1:setAlpha( 0 )
				Glow1Frame2( self.Glow1, {} )
			end
		},

		InstantActivate = {
			DefaultClip = function ()
				self:setupElementClipCounter( 0 )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 7 )

				self.BBGumRingBacker:completeAnimation()
				self.BBGumRingBacker:setAlpha( 0.1 )
				self.clipFinished( self.BBGumRingBacker, {} )

				self.BBGumRing000:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing000, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing000:setAlpha( 0.5 )
				self.clipFinished( self.BBGumRing000, {} )

				self.BBGumRing00:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing00, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing00:setAlpha( 0.5 )
				self.clipFinished( self.BBGumRing00, {} )

				self.BBGumRing0:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing0, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing0:setAlpha( 0.5 )
				self.clipFinished( self.BBGumRing0, {} )

				self.BBGumRing:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRing, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRing:setAlpha( 0.7 )
				self.clipFinished( self.BBGumRing, {} )

				self.BBGumRingEdge:completeAnimation()
				CoD.UIColors.SetElementColor( self.BBGumRingEdge, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.BBGumRingEdge:setAlpha( 1 )
				self.clipFinished( self.BBGumRingEdge, {} )

				local BBGumTextureFrame2 = function ( element, event )
					local BBGumTextureFrame3 = function ( element, event )
						local BBGumTextureFrame4 = function ( element, event )
							local BBGumTextureFrame5 = function ( element, event )
								local BBGumTextureFrame6 = function ( element, event )
									local BBGumTextureFrame7 = function ( element, event )
										local BBGumTextureFrame8 = function ( element, event )
											local BBGumTextureFrame9 = function ( element, event )
												local BBGumTextureFrame10 = function ( element, event )
													if not event.interrupted then
														element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
													end
													element:setAlpha( 1 )
													element:setScale( 0 )
													if event.interrupted then
														self.clipFinished( element, event )
													else
														element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
													end
												end

												if event.interrupted then
													BBGumTextureFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 309, false, false, CoD.TweenType.Linear )
													element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame10 )
												end
											end

											if event.interrupted then
												BBGumTextureFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 169, false, false, CoD.TweenType.Linear )
												element:setScale( 1 )
												element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame9 )
											end
										end

										if event.interrupted then
											BBGumTextureFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 160, false, false, CoD.TweenType.Linear )
											element:setScale( 0.8 )
											element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame8 )
										end
									end

									if event.interrupted then
										BBGumTextureFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 149, false, false, CoD.TweenType.Linear )
										element:setScale( 1.2 )
										element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame7 )
									end
								end

								if event.interrupted then
									BBGumTextureFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 560, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame6 )
								end
							end

							if event.interrupted then
								BBGumTextureFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 139, false, false, CoD.TweenType.Linear )
								element:setScale( 1 )
								element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame5 )
							end
						end

						if event.interrupted then
							BBGumTextureFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Linear )
							element:setScale( 0.8 )
							element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame4 )
						end
					end

					if event.interrupted then
						BBGumTextureFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setScale( 1.2 )
						element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame3 )
					end
				end
				
				self.BBGumTexture:completeAnimation()
				self.BBGumTexture:setAlpha( 1 )
				self.BBGumTexture:setScale( 0 )
				BBGumTextureFrame2( self.BBGumTexture, {} )
			end,

			Active = function ()
				self:setupElementClipCounter( 1 )

				local BBGumTextureFrame10 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 1 )
					element:setScale( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				local BBGumTextureFrame9 = function ( element, event )
					if event.interrupted then
						BBGumTextureFrame10( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 309, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame10 )
					end
				end

				local BBGumTextureFrame8 = function ( element, event )
					if event.interrupted then
						BBGumTextureFrame9( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 169, false, false, CoD.TweenType.Linear )
						element:setScale( 1 )
						element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame9 )
					end
				end

				local BBGumTextureFrame7 = function ( element, event )
					if event.interrupted then
						BBGumTextureFrame8( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 160, false, false, CoD.TweenType.Linear )
						element:setScale( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame8 )
					end
				end

				local BBGumTextureFrame2 = function ( element, event )
					local BBGumTextureFrame3 = function ( element, event )
						local BBGumTextureFrame4 = function ( element, event )
							local BBGumTextureFrame5 = function ( element, event )
								local BBGumTextureFrame6 = function ( element, event )
									if event.interrupted then
										BBGumTextureFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 149, false, false, CoD.TweenType.Linear )
										element:setScale( 1.2 )
										element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame7 )
									end
								end
								
								if event.interrupted then
									BBGumTextureFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 560, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame6 )
								end
							end

							if event.interrupted then
								BBGumTextureFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 139, false, false, CoD.TweenType.Linear )
								element:setScale( 1 )
								element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame5 )
							end
						end

						if event.interrupted then
							BBGumTextureFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Linear )
							element:setScale( 0.8 )
							element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame4 )
						end
					end

					if event.interrupted then
						BBGumTextureFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setScale( 1.2 )
						element:registerEventHandler( "transition_complete_keyframe", BBGumTextureFrame3 )
					end
				end
				
				self.BBGumTexture:completeAnimation()
				self.BBGumTexture:setAlpha( 1 )
				self.BBGumTexture:setScale( 0 )
				BBGumTextureFrame2( self.BBGumTexture, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "ActiveLow",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThan( controller, "bgb_timer", 0 ) and IsModelValueLessThan( controller, "bgb_timer", 0.25 )
			end
		},
		{
			stateName = "Active",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThan( controller, "bgb_timer", 0 )
			end
		},
		{
			stateName = "Inactive",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "bgb_display", 1 )
			end
		},
		{
			stateName = "InstantActivate",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "bgb_timer" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "bgb_timer" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "bgb_display" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "bgb_display" } )
	end )

	self:subscribeToGlobalModel( controller, "PerController", "deadSpectator.playerIndex", function ( model )
		if IsModelValueEqualTo( controller, "deadSpectator.playerIndex", -1 ) then
			SetElementStateWithNoTransitionClip( self, self, controller, "DefaultState" )
			PlayClip( self, "DefaultClip", controller )
		end
	end )

	self:subscribeToGlobalModel( controller, "PerController", "bgb_one_shot_use", function ( model )
		if IsModelValueGreaterThan( controller, "bgb_timer", 0 ) then
			SetElementState( self, self, controller, "InstantActivate" )
			SetElementState( self, self, controller, "Active" )
		elseif IsModelValueEqualTo( controller, "bgb_display", 1 ) then
			SetElementState( self, self, controller, "InstantActivate" )
			SetElementState( self, self, controller, "DefaultState" )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.BBGumRing000:close()
		element.BBGumRing00:close()
		element.BBGumRing0:close()
		element.BBGumRing:close()
		element.BBGumRingEdge:close()
		element.BBGumTexture:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end