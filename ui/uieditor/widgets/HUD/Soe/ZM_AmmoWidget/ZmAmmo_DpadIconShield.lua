require( "ui.uieditor.widgets.HUD.ZM_AmmoWidgetStalingrad.ZmAmmo_DpadIconShieldIconStalingrad" )

CoD.ZmAmmo_DpadIconShield = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadIconShield.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadIconShield )
	self.id = "ZmAmmo_DpadIconShield"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 16 )
	self:setTopBottom( true, false, 0, 16 )
	self.anyChildUsesUpdateState = true
	
	self.IconImgShieldBaseInvalid = LUI.UIImage.new()
	self.IconImgShieldBaseInvalid:setLeftRight( false, false, -56, 63 )
	self.IconImgShieldBaseInvalid:setTopBottom( false, false, -53, 42 )
	self.IconImgShieldBaseInvalid:setAlpha( 0 )
	self.IconImgShieldBaseInvalid:setImage( RegisterImage( "uie_t7_zm_hud_ammo_nobubblegum" ) )
	self:addElement( self.IconImgShieldBaseInvalid )
	
	self.IconImgShieldBaseNew = LUI.UIImage.new()
	self.IconImgShieldBaseNew:setLeftRight( false, false, -56, 63 )
	self.IconImgShieldBaseNew:setTopBottom( false, false, -53, 42 )
	self.IconImgShieldBaseNew:setAlpha( 0 )
	self.IconImgShieldBaseNew:setImage( RegisterImage( "uie_t7_zm_hud_ammo_newbubblegum" ) )
	self:addElement( self.IconImgShieldBaseNew )
	
	self.IconImgShieldDisabled = LUI.UIImage.new()
	self.IconImgShieldDisabled:setLeftRight( false, false, -18, 25 )
	self.IconImgShieldDisabled:setTopBottom( false, false, -21.5, 21.5 )
	self.IconImgShieldDisabled:setAlpha( 0 )
	self.IconImgShieldDisabled:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_icon_shield_inactive" ) )
	self:addElement( self.IconImgShieldDisabled )
	
	self.IconImgShieldActive = CoD.ZmAmmo_DpadIconShieldIconStalingrad.new( menu, controller )
	self.IconImgShieldActive:setLeftRight( false, false, -19.5, 26.5 )
	self.IconImgShieldActive:setTopBottom( false, false, -29, 17 )
	self.IconImgShieldActive:setAlpha( 0 )
	self:addElement( self.IconImgShieldActive )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.IconImgShieldDisabled:completeAnimation()
				self.IconImgShieldDisabled:setAlpha( 0 )
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
				self:setupElementClipCounter( 1 )

				self.IconImgShieldActive:completeAnimation()
				self.IconImgShieldActive:setAlpha( 1 )
				self.clipFinished( self.IconImgShieldActive, {} )
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

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.IconImgShieldActive:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end