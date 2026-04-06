local PostLoadFunc = function( self, controller, menu )
	self.UpdateColors = function( self )
		CoD.UIColors.SetElementColor( self.GlowOrangeOver, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_DpadIconSide = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadIconSide.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadIconSide )
	self.id = "ZmAmmo_DpadIconSide"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 16 )
	self:setTopBottom( true, false, 0, 16 )
	
	self.IconImgShieldBaseInvalid = LUI.UIImage.new()
	self.IconImgShieldBaseInvalid:setLeftRight( false, false, -55, 62 )
	self.IconImgShieldBaseInvalid:setTopBottom( false, false, -50, 45 )
	self.IconImgShieldBaseInvalid:setAlpha( 0 )
	self.IconImgShieldBaseInvalid:setImage( RegisterImage( "uie_t7_zm_hud_ammo_nobubblegum" ) )
	self:addElement( self.IconImgShieldBaseInvalid )
	
	self.IconImgShieldBaseNew = LUI.UIImage.new()
	self.IconImgShieldBaseNew:setLeftRight( false, false, -55, 62 )
	self.IconImgShieldBaseNew:setTopBottom( false, false, -50, 45 )
	self.IconImgShieldBaseNew:setAlpha( 0 )
	self.IconImgShieldBaseNew:setImage( RegisterImage( "uie_t7_zm_hud_ammo_newbubblegum" ) )
	self:addElement( self.IconImgShieldBaseNew )
	
	self.IconImgShieldDisabled = LUI.UIImage.new()
	self.IconImgShieldDisabled:setLeftRight( false, false, -14, 20 )
	self.IconImgShieldDisabled:setTopBottom( false, false, -23, 11 )
	self.IconImgShieldDisabled:setAlpha( 0 )
	self.IconImgShieldDisabled:setImage( RegisterImage( "uie_t7_zm_hud_ammo_dpadicnshld_new_inactive" ) )
	self:addElement( self.IconImgShieldDisabled )
	
	self.IconImgShieldActive = LUI.UIImage.new()
	self.IconImgShieldActive:setLeftRight( false, false, -14, 20 )
	self.IconImgShieldActive:setTopBottom( false, false, -23, 11 )
	self.IconImgShieldActive:setAlpha( 0 )
	self.IconImgShieldActive:setImage( RegisterImage( "uie_t7_zm_hud_ammo_dpadicnshld_new" ) )
	self:addElement( self.IconImgShieldActive )
	
	self.GlowOrangeOver = LUI.UIImage.new()
	self.GlowOrangeOver:setLeftRight( false, false, -4.43, 11.43 )
	self.GlowOrangeOver:setTopBottom( false, false, -24, 12 )
	CoD.UIColors.SetElementColor( self.GlowOrangeOver, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.GlowOrangeOver:setAlpha( 0 )
	self.GlowOrangeOver:setZRot( 89 )
	self.GlowOrangeOver:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.GlowOrangeOver:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.GlowOrangeOver )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				self.IconImgShieldDisabled:completeAnimation()
				self.IconImgShieldDisabled:setAlpha( 0 )
				self.clipFinished( self.IconImgShieldDisabled, {} )
			end,

			Ready = function ()
				self:setupElementClipCounter( 2 )

				local IconImgShieldBaseNewFrame2 = function ( element, event )
					local IconImgShieldBaseNewFrame3 = function ( element, event )
						local IconImgShieldBaseNewFrame4 = function ( element, event )
							local IconImgShieldBaseNewFrame5 = function ( element, event )
								local IconImgShieldBaseNewFrame6 = function ( element, event )
									local IconImgShieldBaseNewFrame7 = function ( element, event )
										local IconImgShieldBaseNewFrame8 = function ( element, event )
											local IconImgShieldBaseNewFrame9 = function ( element, event )
												local IconImgShieldBaseNewFrame10 = function ( element, event )
													local IconImgShieldBaseNewFrame11 = function ( element, event )
														if not event.interrupted then
															element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														end
														element:setAlpha( 0 )
														if event.interrupted then
															self.clipFinished( element, event )
														else
															element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
														end
													end

													if event.interrupted then
														IconImgShieldBaseNewFrame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														element:setAlpha( 1 )
														element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame11 )
													end
												end

												if event.interrupted then
													IconImgShieldBaseNewFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
													element:setAlpha( 0.3 )
													element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame10 )
												end
											end

											if event.interrupted then
												IconImgShieldBaseNewFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
												element:setAlpha( 1 )
												element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame9 )
											end
										end

										if event.interrupted then
											IconImgShieldBaseNewFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.3 )
											element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame8 )
										end
									end

									if event.interrupted then
										IconImgShieldBaseNewFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame7 )
									end
								end

								if event.interrupted then
									IconImgShieldBaseNewFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.3 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame6 )
								end
							end

							if event.interrupted then
								IconImgShieldBaseNewFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame5 )
							end
						end

						if event.interrupted then
							IconImgShieldBaseNewFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.3 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame4 )
						end
					end

					if event.interrupted then
						IconImgShieldBaseNewFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame3 )
					end
				end
				
				self.IconImgShieldBaseNew:completeAnimation()
				self.IconImgShieldBaseNew:setAlpha( 0 )
				IconImgShieldBaseNewFrame2( self.IconImgShieldBaseNew, {} )

				self.IconImgShieldActive:completeAnimation()
				self.IconImgShieldActive:setAlpha( 1 )
				self.clipFinished( self.IconImgShieldActive, {} )
			end
		},

		InvalidUse = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				local IconImgShieldBaseInvalidFrame2 = function ( element, event )
					local IconImgShieldBaseInvalidFrame3 = function ( element, event )
						local IconImgShieldBaseInvalidFrame4 = function ( element, event )
							local IconImgShieldBaseInvalidFrame5 = function ( element, event )
								local IconImgShieldBaseInvalidFrame6 = function ( element, event )
									local IconImgShieldBaseInvalidFrame7 = function ( element, event )
										if not event.interrupted then
											element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
										end
										element:setAlpha( 0 )
										if event.interrupted then
											self.clipFinished( element, event )
										else
											element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
										end
									end

									if event.interrupted then
										IconImgShieldBaseInvalidFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseInvalidFrame7 )
									end
								end

								if event.interrupted then
									IconImgShieldBaseInvalidFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseInvalidFrame6 )
								end
							end

							if event.interrupted then
								IconImgShieldBaseInvalidFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseInvalidFrame5 )
							end
						end

						if event.interrupted then
							IconImgShieldBaseInvalidFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseInvalidFrame4 )
						end
					end

					if event.interrupted then
						IconImgShieldBaseInvalidFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseInvalidFrame3 )
					end
				end
				
				self.IconImgShieldBaseInvalid:completeAnimation()
				self.IconImgShieldBaseInvalid:setAlpha( 0 )
				IconImgShieldBaseInvalidFrame2( self.IconImgShieldBaseInvalid, {} )
			end,

			Active = function ()
				self:setupElementClipCounter( 0 )
			end
		},

		Ready = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				self.IconImgShieldActive:completeAnimation()
				self.IconImgShieldActive:setAlpha( 1 )
				self.clipFinished( self.IconImgShieldActive, {} )
			end,

			Activate = function ()
				self:setupElementClipCounter( 2 )

				self.IconImgShieldActive:completeAnimation()
				self.IconImgShieldActive:setAlpha( 1 )
				self.clipFinished( self.IconImgShieldActive, {} )

				local GlowOrangeOverFrame2 = function ( element, event )
					local GlowOrangeOverFrame3 = function ( element, event )
						local GlowOrangeOverFrame4 = function ( element, event )
							local GlowOrangeOverFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 850, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end

							if event.interrupted then
								GlowOrangeOverFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame5 )
							end
						end

						if event.interrupted then
							GlowOrangeOverFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0 )
							element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame4 )
						end
					end

					if event.interrupted then
						GlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame3 )
					end
				end
				
				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setAlpha( 0 )
				GlowOrangeOverFrame2( self.GlowOrangeOver, {} )
			end
		},

		New = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				local IconImgShieldBaseNewFrame2 = function ( element, event )
					local IconImgShieldBaseNewFrame3 = function ( element, event )
						local IconImgShieldBaseNewFrame4 = function ( element, event )
							local IconImgShieldBaseNewFrame5 = function ( element, event )
								local IconImgShieldBaseNewFrame6 = function ( element, event )
									local IconImgShieldBaseNewFrame7 = function ( element, event )
										local IconImgShieldBaseNewFrame8 = function ( element, event )
											local IconImgShieldBaseNewFrame9 = function ( element, event )
												local IconImgShieldBaseNewFrame10 = function ( element, event )
													local IconImgShieldBaseNewFrame11 = function ( element, event )
														if not event.interrupted then
															element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														end
														element:setAlpha( 0 )
														if event.interrupted then
															self.clipFinished( element, event )
														else
															element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
														end
													end

													if event.interrupted then
														IconImgShieldBaseNewFrame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														element:setAlpha( 1 )
														element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame11 )
													end
												end

												if event.interrupted then
													IconImgShieldBaseNewFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
													element:setAlpha( 0.3 )
													element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame10 )
												end
											end

											if event.interrupted then
												IconImgShieldBaseNewFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
												element:setAlpha( 1 )
												element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame9 )
											end
										end

										if event.interrupted then
											IconImgShieldBaseNewFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.3 )
											element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame8 )
										end
									end

									if event.interrupted then
										IconImgShieldBaseNewFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame7 )
									end
								end

								if event.interrupted then
									IconImgShieldBaseNewFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.3 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame6 )
								end
							end

							if event.interrupted then
								IconImgShieldBaseNewFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame5 )
							end
						end

						if event.interrupted then
							IconImgShieldBaseNewFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.3 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame4 )
						end
					end

					if event.interrupted then
						IconImgShieldBaseNewFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame3 )
					end
				end
				
				self.IconImgShieldBaseNew:completeAnimation()
				self.IconImgShieldBaseNew:setAlpha( 0 )
				IconImgShieldBaseNewFrame2( self.IconImgShieldBaseNew, {} )

				self.IconImgShieldActive:completeAnimation()
				self.IconImgShieldActive:setAlpha( 1 )
				self.clipFinished( self.IconImgShieldActive, {} )
			end
		},

		Unavailable = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.IconImgShieldDisabled:completeAnimation()
				self.IconImgShieldDisabled:setRGB( 0.35, 0.35, 0.35 )
				self.IconImgShieldDisabled:setAlpha( 1 )
				self.clipFinished( self.IconImgShieldDisabled, {} )

				self.IconImgShieldActive:completeAnimation()
				self.IconImgShieldActive:setAlpha( 0 )
				self.clipFinished( self.IconImgShieldActive, {} )
			end,

			Ready = function ()
				self:setupElementClipCounter( 2 )

				local IconImgShieldBaseNewFrame2 = function ( element, event )
					local IconImgShieldBaseNewFrame3 = function ( element, event )
						local IconImgShieldBaseNewFrame4 = function ( element, event )
							local IconImgShieldBaseNewFrame5 = function ( element, event )
								local IconImgShieldBaseNewFrame6 = function ( element, event )
									local IconImgShieldBaseNewFrame7 = function ( element, event )
										local IconImgShieldBaseNewFrame8 = function ( element, event )
											local IconImgShieldBaseNewFrame9 = function ( element, event )
												local IconImgShieldBaseNewFrame10 = function ( element, event )
													local IconImgShieldBaseNewFrame11 = function ( element, event )
														if not event.interrupted then
															element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														end
														element:setAlpha( 0 )
														if event.interrupted then
															self.clipFinished( element, event )
														else
															element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
														end
													end
													
													if event.interrupted then
														IconImgShieldBaseNewFrame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														element:setAlpha( 1 )
														element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame11 )
													end
												end

												if event.interrupted then
													IconImgShieldBaseNewFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
													element:setAlpha( 0.3 )
													element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame10 )
												end
											end

											if event.interrupted then
												IconImgShieldBaseNewFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
												element:setAlpha( 1 )
												element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame9 )
											end
										end

										if event.interrupted then
											IconImgShieldBaseNewFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.3 )
											element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame8 )
										end
									end

									if event.interrupted then
										IconImgShieldBaseNewFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame7 )
									end
								end

								if event.interrupted then
									IconImgShieldBaseNewFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.3 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame6 )
								end
							end

							if event.interrupted then
								IconImgShieldBaseNewFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame5 )
							end
						end

						if event.interrupted then
							IconImgShieldBaseNewFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.3 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame4 )
						end
					end

					if event.interrupted then
						IconImgShieldBaseNewFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgShieldBaseNewFrame3 )
					end
				end
				
				self.IconImgShieldBaseNew:completeAnimation()
				self.IconImgShieldBaseNew:setAlpha( 0 )
				IconImgShieldBaseNewFrame2( self.IconImgShieldBaseNew, {} )

				self.IconImgShieldActive:completeAnimation()
				self.IconImgShieldActive:setAlpha( 1 )
				self.clipFinished( self.IconImgShieldActive, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "InvalidUse",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return true
			end
		},
		{
			stateName = "New",
			condition = function ( menu, element, event )
				return true
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return true
			end
		}
	} )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end