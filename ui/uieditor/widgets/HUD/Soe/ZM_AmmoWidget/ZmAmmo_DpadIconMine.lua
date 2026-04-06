CoD.ZmAmmo_DpadIconMine = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadIconMine.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadIconMine )
	self.id = "ZmAmmo_DpadIconMine"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 16 )
	self:setTopBottom( true, false, 0, 16 )
	
	self.IconImgMineBaseInvalid = LUI.UIImage.new()
	self.IconImgMineBaseInvalid:setLeftRight( false, false, -42, 46 )
	self.IconImgMineBaseInvalid:setTopBottom( false, false, -71, 66 )
	self.IconImgMineBaseInvalid:setAlpha( 0 )
	self.IconImgMineBaseInvalid:setImage( RegisterImage( "uie_t7_zm_hud_ammo_nomine" ) )
	self:addElement( self.IconImgMineBaseInvalid )
	
	self.IconImgMineBaseNew = LUI.UIImage.new()
	self.IconImgMineBaseNew:setLeftRight( false, false, -43, 46 )
	self.IconImgMineBaseNew:setTopBottom( false, false, -71, 66 )
	self.IconImgMineBaseNew:setAlpha( 0 )
	self.IconImgMineBaseNew:setImage( RegisterImage( "uie_t7_zm_hud_ammo_newmine" ) )
	self:addElement( self.IconImgMineBaseNew )
	
	self.IconImgMineDisabled = LUI.UIImage.new()
	self.IconImgMineDisabled:setLeftRight( false, false, -19, 19 )
	self.IconImgMineDisabled:setTopBottom( false, false, -22, 15 )
	self.IconImgMineDisabled:setAlpha( 0 )
	self.IconImgMineDisabled:setImage( RegisterImage( "uie_t7_zm_hud_ammo_dpadicnmine_new_inactive" ) )
	self:addElement( self.IconImgMineDisabled )
	
	self.IconImgMineActive = LUI.UIImage.new()
	self.IconImgMineActive:setLeftRight( false, false, -19, 19 )
	self.IconImgMineActive:setTopBottom( false, false, -22, 15 )
	self.IconImgMineActive:setAlpha( 0 )
	self.IconImgMineActive:setImage( RegisterImage( "uie_t7_zm_hud_ammo_dpadicnmine_new" ) )
	self:addElement( self.IconImgMineActive )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.IconImgMineDisabled:completeAnimation()
				self.IconImgMineDisabled:setAlpha( 0 )
				self.clipFinished( self.IconImgMineDisabled, {} )

				self.IconImgMineActive:completeAnimation()
				self.IconImgMineActive:setAlpha( 0 )
				self.clipFinished( self.IconImgMineActive, {} )
			end,

			Ready = function ()
				self:setupElementClipCounter( 2 )

				local IconImgMineBaseNewFrame2 = function ( element, event )
					local IconImgMineBaseNewFrame3 = function ( element, event )
						local IconImgMineBaseNewFrame4 = function ( element, event )
							local IconImgMineBaseNewFrame5 = function ( element, event )
								local IconImgMineBaseNewFrame6 = function ( element, event )
									local IconImgMineBaseNewFrame7 = function ( element, event )
										local IconImgMineBaseNewFrame8 = function ( element, event )
											local IconImgMineBaseNewFrame9 = function ( element, event )
												local IconImgMineBaseNewFrame10 = function ( element, event )
													local IconImgMineBaseNewFrame11 = function ( element, event )
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
														IconImgMineBaseNewFrame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														element:setAlpha( 1 )
														element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame11 )
													end
												end

												if event.interrupted then
													IconImgMineBaseNewFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
													element:setAlpha( 0.3 )
													element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame10 )
												end
											end

											if event.interrupted then
												IconImgMineBaseNewFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
												element:setAlpha( 1 )
												element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame9 )
											end
										end

										if event.interrupted then
											IconImgMineBaseNewFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.3 )
											element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame8 )
										end
									end

									if event.interrupted then
										IconImgMineBaseNewFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame7 )
									end
								end

								if event.interrupted then
									IconImgMineBaseNewFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.3 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame6 )
								end
							end

							if event.interrupted then
								IconImgMineBaseNewFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame5 )
							end
						end

						if event.interrupted then
							IconImgMineBaseNewFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.3 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame4 )
						end
					end

					if event.interrupted then
						IconImgMineBaseNewFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame3 )
					end
				end
				
				self.IconImgMineBaseNew:completeAnimation()
				self.IconImgMineBaseNew:setAlpha( 0 )
				IconImgMineBaseNewFrame2( self.IconImgMineBaseNew, {} )

				self.IconImgMineActive:completeAnimation()
				self.IconImgMineActive:setAlpha( 1 )
				self.clipFinished( self.IconImgMineActive, {} )
			end
		},

		InvalidUse = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				local IconImgMineBaseInvalidFrame2 = function ( element, event )
					local IconImgMineBaseInvalidFrame3 = function ( element, event )
						local IconImgMineBaseInvalidFrame4 = function ( element, event )
							local IconImgMineBaseInvalidFrame5 = function ( element, event )
								local IconImgMineBaseInvalidFrame6 = function ( element, event )
									local IconImgMineBaseInvalidFrame7 = function ( element, event )
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
										IconImgMineBaseInvalidFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseInvalidFrame7 )
									end
								end

								if event.interrupted then
									IconImgMineBaseInvalidFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseInvalidFrame6 )
								end
							end

							if event.interrupted then
								IconImgMineBaseInvalidFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseInvalidFrame5 )
							end
						end

						if event.interrupted then
							IconImgMineBaseInvalidFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseInvalidFrame4 )
						end
					end

					if event.interrupted then
						IconImgMineBaseInvalidFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseInvalidFrame3 )
					end
				end
				
				self.IconImgMineBaseInvalid:completeAnimation()
				self.IconImgMineBaseInvalid:setAlpha( 0 )
				IconImgMineBaseInvalidFrame2( self.IconImgMineBaseInvalid, {} )
			end,

			Active = function ()
				self:setupElementClipCounter( 0 )
			end
		},

		Ready = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				self.IconImgMineActive:completeAnimation()
				self.IconImgMineActive:setAlpha( 1 )
				self.clipFinished( self.IconImgMineActive, {} )
			end
		},

		New = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				local IconImgMineBaseNewFrame2 = function ( element, event )
					local IconImgMineBaseNewFrame3 = function ( element, event )
						local IconImgMineBaseNewFrame4 = function ( element, event )
							local IconImgMineBaseNewFrame5 = function ( element, event )
								local IconImgMineBaseNewFrame6 = function ( element, event )
									local IconImgMineBaseNewFrame7 = function ( element, event )
										local IconImgMineBaseNewFrame8 = function ( element, event )
											local IconImgMineBaseNewFrame9 = function ( element, event )
												local IconImgMineBaseNewFrame10 = function ( element, event )
													local IconImgMineBaseNewFrame11 = function ( element, event )
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
														IconImgMineBaseNewFrame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														element:setAlpha( 1 )
														element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame11 )
													end
												end

												if event.interrupted then
													IconImgMineBaseNewFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
													element:setAlpha( 0.3 )
													element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame10 )
												end
											end

											if event.interrupted then
												IconImgMineBaseNewFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
												element:setAlpha( 1 )
												element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame9 )
											end
										end

										if event.interrupted then
											IconImgMineBaseNewFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.3 )
											element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame8 )
										end
									end

									if event.interrupted then
										IconImgMineBaseNewFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame7 )
									end
								end

								if event.interrupted then
									IconImgMineBaseNewFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.3 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame6 )
								end
							end

							if event.interrupted then
								IconImgMineBaseNewFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame5 )
							end
						end

						if event.interrupted then
							IconImgMineBaseNewFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.3 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame4 )
						end
					end

					if event.interrupted then
						IconImgMineBaseNewFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame3 )
					end
				end
				
				self.IconImgMineBaseNew:completeAnimation()
				self.IconImgMineBaseNew:setAlpha( 0 )
				IconImgMineBaseNewFrame2( self.IconImgMineBaseNew, {} )

				self.IconImgMineActive:completeAnimation()
				self.IconImgMineActive:setAlpha( 1 )
				self.clipFinished( self.IconImgMineActive, {} )
			end
		},

		Unavailable = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.IconImgMineDisabled:completeAnimation()
				self.IconImgMineDisabled:setRGB( 0.35, 0.35, 0.35 )
				self.IconImgMineDisabled:setAlpha( 1 )
				self.clipFinished( self.IconImgMineDisabled, {} )

				self.IconImgMineActive:completeAnimation()
				self.IconImgMineActive:setAlpha( 0 )
				self.clipFinished( self.IconImgMineActive, {} )
			end,

			Ready = function ()
				self:setupElementClipCounter( 2 )

				local IconImgMineBaseNewFrame2 = function ( element, event )
					local IconImgMineBaseNewFrame3 = function ( element, event )
						local IconImgMineBaseNewFrame4 = function ( element, event )
							local IconImgMineBaseNewFrame5 = function ( element, event )
								local IconImgMineBaseNewFrame6 = function ( element, event )
									local IconImgMineBaseNewFrame7 = function ( element, event )
										local IconImgMineBaseNewFrame8 = function ( element, event )
											local IconImgMineBaseNewFrame9 = function ( element, event )
												local IconImgMineBaseNewFrame10 = function ( element, event )
													local IconImgMineBaseNewFrame11 = function ( element, event )
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
														IconImgMineBaseNewFrame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														element:setAlpha( 1 )
														element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame11 )
													end
												end

												if event.interrupted then
													IconImgMineBaseNewFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
													element:setAlpha( 0.3 )
													element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame10 )
												end
											end

											if event.interrupted then
												IconImgMineBaseNewFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
												element:setAlpha( 1 )
												element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame9 )
											end
										end

										if event.interrupted then
											IconImgMineBaseNewFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.3 )
											element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame8 )
										end
									end

									if event.interrupted then
										IconImgMineBaseNewFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
										element:setAlpha( 1 )
										element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame7 )
									end
								end

								if event.interrupted then
									IconImgMineBaseNewFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.3 )
									element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame6 )
								end
							end

							if event.interrupted then
								IconImgMineBaseNewFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame5 )
							end
						end

						if event.interrupted then
							IconImgMineBaseNewFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.3 )
							element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame4 )
						end
					end

					if event.interrupted then
						IconImgMineBaseNewFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", IconImgMineBaseNewFrame3 )
					end
				end
				
				self.IconImgMineBaseNew:completeAnimation()
				self.IconImgMineBaseNew:setAlpha( 0 )
				IconImgMineBaseNewFrame2( self.IconImgMineBaseNew, {} )

				self.IconImgMineActive:completeAnimation()
				self.IconImgMineActive:setAlpha( 1 )
				self.clipFinished( self.IconImgMineActive, {} )
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