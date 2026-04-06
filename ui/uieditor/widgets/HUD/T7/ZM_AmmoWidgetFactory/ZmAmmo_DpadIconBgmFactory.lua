CoD.ZmAmmo_DpadIconBgmFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadIconBgmFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadIconBgmFactory )
	self.id = "ZmAmmo_DpadIconBgmFactory"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 16 )
	self:setTopBottom( true, false, 0, 16 )
	
	self.IconImgBgmBaseInvalid = LUI.UIImage.new()
	self.IconImgBgmBaseInvalid:setLeftRight( false, false, -56, 59 )
	self.IconImgBgmBaseInvalid:setTopBottom( false, false, -42, 48 )
	self.IconImgBgmBaseInvalid:setAlpha( 0 )
	self.IconImgBgmBaseInvalid:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_dpadmtr_top_unavailable" ) )
	self:addElement( self.IconImgBgmBaseInvalid )
	
	self.IconImgBgmBaseNew = LUI.UIImage.new()
	self.IconImgBgmBaseNew:setLeftRight( false, false, -56, 59 )
	self.IconImgBgmBaseNew:setTopBottom( false, false, -42, 48 )
	self.IconImgBgmBaseNew:setAlpha( 0 )
	self.IconImgBgmBaseNew:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_dpadmtr_top_flash" ) )
	self:addElement( self.IconImgBgmBaseNew )
	
	self.IconImgBgmDisabled = LUI.UIImage.new()
	self.IconImgBgmDisabled:setLeftRight( false, false, -16.5, 19.5 )
	self.IconImgBgmDisabled:setTopBottom( false, false, -18, 18 )
	self.IconImgBgmDisabled:setAlpha( 0 )
	self.IconImgBgmDisabled:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_icon_ggb_inactive" ) )
	self:addElement( self.IconImgBgmDisabled )
	
	self.IconImgBgmActive = LUI.UIImage.new()
	self.IconImgBgmActive:setLeftRight( false, false, -16.5, 19.5 )
	self.IconImgBgmActive:setTopBottom( false, false, -18, 18 )
	self.IconImgBgmActive:setAlpha( 0 )
	self.IconImgBgmActive:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_icon_ggb" ) )
	self:addElement( self.IconImgBgmActive )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.IconImgBgmDisabled:completeAnimation()
				self.IconImgBgmDisabled:setAlpha( 0 )
				self.clipFinished( self.IconImgBgmDisabled, {} )

				self.IconImgBgmActive:completeAnimation()
				self.IconImgBgmActive:setAlpha( 0 )
				self.clipFinished( self.IconImgBgmActive, {} )
			end,

			Ready = function ()
				self:setupElementClipCounter( 2 )

				local IconImgBgmBaseNewFrame2 = function ( element, event )
					local IconImgBgmBaseNewFrame3 = function ( element, event )
						local IconImgBgmBaseNewFrame4 = function ( element, event )
							local IconImgBgmBaseNewFrame5 = function ( element, event )
								local IconImgBgmBaseNewFrame6 = function ( element, event )
									local IconImgBgmBaseNewFrame7 = function ( element, event )
										local IconImgBgmBaseNewFrame8 = function ( element, event )
											local IconImgBgmBaseNewFrame9 = function ( element, event )
												local IconImgBgmBaseNewFrame10 = function ( element, event )
													local IconImgBgmBaseNewFrame11 = function ( element, event )
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
														IconImgBgmBaseNewFrame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														element:setAlpha( 1 )
														element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame11 )
													end
												end

												if event.interrupted then
													IconImgBgmBaseNewFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
													element:setAlpha( 0.3 )
													element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame10 )
												end
											end

											if event.interrupted then
												IconImgBgmBaseNewFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
												element:setAlpha( 1 )
												element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame9 )
											end
										end

										if event.interrupted then
											IconImgBgmBaseNewFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.3 )
											element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame8 )
										end
									end

									if event.interrupted then
										IconImgBgmBaseNewFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame7 )
									end
								end

								if event.interrupted then
									IconImgBgmBaseNewFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.3 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame6 )
								end
							end

							if event.interrupted then
								IconImgBgmBaseNewFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame5 )
							end
						end

						if event.interrupted then
							IconImgBgmBaseNewFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.3 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame4 )
						end
					end

					if event.interrupted then
						IconImgBgmBaseNewFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame3 )
					end
				end
				
				self.IconImgBgmBaseNew:completeAnimation()
				self.IconImgBgmBaseNew:setAlpha( 0 )
				IconImgBgmBaseNewFrame2( self.IconImgBgmBaseNew, {} )

				self.IconImgBgmActive:completeAnimation()
				self.IconImgBgmActive:setAlpha( 1 )
				self.clipFinished( self.IconImgBgmActive, {} )
			end
		},

		InvalidUse = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				local IconImgBgmBaseInvalidFrame2 = function ( element, event )
					local IconImgBgmBaseInvalidFrame3 = function ( element, event )
						local IconImgBgmBaseInvalidFrame4 = function ( element, event )
							local IconImgBgmBaseInvalidFrame5 = function ( element, event )
								local IconImgBgmBaseInvalidFrame6 = function ( element, event )
									local IconImgBgmBaseInvalidFrame7 = function ( element, event )
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
										IconImgBgmBaseInvalidFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseInvalidFrame7 )
									end
								end

								if event.interrupted then
									IconImgBgmBaseInvalidFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseInvalidFrame6 )
								end
							end

							if event.interrupted then
								IconImgBgmBaseInvalidFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseInvalidFrame5 )
							end
						end

						if event.interrupted then
							IconImgBgmBaseInvalidFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseInvalidFrame4 )
						end
					end

					if event.interrupted then
						IconImgBgmBaseInvalidFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseInvalidFrame3 )
					end
				end
				
				self.IconImgBgmBaseInvalid:completeAnimation()
				self.IconImgBgmBaseInvalid:setAlpha( 0 )
				IconImgBgmBaseInvalidFrame2( self.IconImgBgmBaseInvalid, {} )
			end,

			Active = function ()
				self:setupElementClipCounter( 0 )
			end
		},

		Ready = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				self.IconImgBgmActive:completeAnimation()
				self.IconImgBgmActive:setAlpha( 1 )
				self.clipFinished( self.IconImgBgmActive, {} )
			end,

			Activate = function ()
				self:setupElementClipCounter( 1 )

				self.IconImgBgmActive:completeAnimation()
				self.IconImgBgmActive:setAlpha( 1 )
				self.clipFinished( self.IconImgBgmActive, {} )
			end
		},

		New = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				local IconImgBgmBaseNewFrame2 = function ( element, event )
					local IconImgBgmBaseNewFrame3 = function ( element, event )
						local IconImgBgmBaseNewFrame4 = function ( element, event )
							local IconImgBgmBaseNewFrame5 = function ( element, event )
								local IconImgBgmBaseNewFrame6 = function ( element, event )
									local IconImgBgmBaseNewFrame7 = function ( element, event )
										local IconImgBgmBaseNewFrame8 = function ( element, event )
											local IconImgBgmBaseNewFrame9 = function ( element, event )
												local IconImgBgmBaseNewFrame10 = function ( element, event )
													local IconImgBgmBaseNewFrame11 = function ( element, event )
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
														IconImgBgmBaseNewFrame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														element:setAlpha( 1 )
														element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame11 )
													end
												end

												if event.interrupted then
													IconImgBgmBaseNewFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
													element:setAlpha( 0.3 )
													element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame10 )
												end
											end

											if event.interrupted then
												IconImgBgmBaseNewFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
												element:setAlpha( 1 )
												element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame9 )
											end
										end

										if event.interrupted then
											IconImgBgmBaseNewFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.3 )
											element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame8 )
										end
									end

									if event.interrupted then
										IconImgBgmBaseNewFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame7 )
									end
								end

								if event.interrupted then
									IconImgBgmBaseNewFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.3 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame6 )
								end
							end

							if event.interrupted then
								IconImgBgmBaseNewFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame5 )
							end
						end

						if event.interrupted then
							IconImgBgmBaseNewFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.3 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame4 )
						end
					end

					if event.interrupted then
						IconImgBgmBaseNewFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame3 )
					end
				end
				
				self.IconImgBgmBaseNew:completeAnimation()
				self.IconImgBgmBaseNew:setAlpha( 0 )
				IconImgBgmBaseNewFrame2( self.IconImgBgmBaseNew, {} )

				self.IconImgBgmActive:completeAnimation()
				self.IconImgBgmActive:setAlpha( 1 )
				self.clipFinished( self.IconImgBgmActive, {} )
			end
		},

		Unavailable = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.IconImgBgmDisabled:completeAnimation()
				self.IconImgBgmDisabled:setRGB( 0.35, 0.35, 0.35 )
				self.IconImgBgmDisabled:setAlpha( 1 )
				self.clipFinished( self.IconImgBgmDisabled, {} )

				self.IconImgBgmActive:completeAnimation()
				self.IconImgBgmActive:setAlpha( 0 )
				self.clipFinished( self.IconImgBgmActive, {} )
			end,

			Ready = function ()
				self:setupElementClipCounter( 2 )

				local IconImgBgmBaseNewFrame2 = function ( element, event )
					local IconImgBgmBaseNewFrame3 = function ( element, event )
						local IconImgBgmBaseNewFrame4 = function ( element, event )
							local IconImgBgmBaseNewFrame5 = function ( element, event )
								local IconImgBgmBaseNewFrame6 = function ( element, event )
									local IconImgBgmBaseNewFrame7 = function ( element, event )
										local IconImgBgmBaseNewFrame8 = function ( element, event )
											local IconImgBgmBaseNewFrame9 = function ( element, event )
												local IconImgBgmBaseNewFrame10 = function ( element, event )
													local IconImgBgmBaseNewFrame11 = function ( element, event )
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
														IconImgBgmBaseNewFrame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														element:setAlpha( 1 )
														element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame11 )
													end
												end

												if event.interrupted then
													IconImgBgmBaseNewFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
													element:setAlpha( 0.3 )
													element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame10 )
												end
											end

											if event.interrupted then
												IconImgBgmBaseNewFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
												element:setAlpha( 1 )
												element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame9 )
											end
										end

										if event.interrupted then
											IconImgBgmBaseNewFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.3 )
											element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame8 )
										end
									end

									if event.interrupted then
										IconImgBgmBaseNewFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame7 )
									end
								end

								if event.interrupted then
									IconImgBgmBaseNewFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.3 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame6 )
								end
							end

							if event.interrupted then
								IconImgBgmBaseNewFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame5 )
							end
						end

						if event.interrupted then
							IconImgBgmBaseNewFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.3 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame4 )
						end
					end

					if event.interrupted then
						IconImgBgmBaseNewFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgBgmBaseNewFrame3 )
					end
				end
				
				self.IconImgBgmBaseNew:completeAnimation()
				self.IconImgBgmBaseNew:setAlpha( 0 )
				IconImgBgmBaseNewFrame2( self.IconImgBgmBaseNew, {} )

				self.IconImgBgmActive:completeAnimation()
				self.IconImgBgmActive:setAlpha( 1 )
				self.clipFinished( self.IconImgBgmActive, {} )
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

	self:subscribeToGlobalModel( controller, "PerController", "bgb_activations_remaining", function ( model )
		PlayClip( self, "Activate", controller )
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end