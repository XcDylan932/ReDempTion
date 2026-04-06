require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_TextAttachmentInfo" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_TextAttachmentInfoFire" )
require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2blue" )

local UpdateWeaponSelect = function ( self, controller )
	local currentWeaponModel = Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon" )
	if currentWeaponModel == nil then
		return 
	end
	local weaponName = Engine.GetModelValue( Engine.GetModel( currentWeaponModel, "weaponName" ) )
	if self.currentWeapon ~= weaponName then
		self.AttachmentInfo:UpdateAttachments( self.currentAttachment1, self.currentAttachment2, self.currentAttachment3 )
		self.currentWeapon = weaponName
		self:setState( "DefaultState" )
		self:setState( "NoAttachments" )
	end
end

local PreLoadFunc = function ( self, controller )
	Engine.CreateModel( Engine.GetModelForController( controller ), "currentWeapon.aat" )
end

local PostLoadFunc = function ( self, controller )
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.updateWeaponSelect" ), function ( model )
		UpdateWeaponSelect( self, controller )
	end )
end

CoD.ZmAmmoFactory_AttachmentInfo = InheritFrom( LUI.UIElement )
CoD.ZmAmmoFactory_AttachmentInfo.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmoFactory_AttachmentInfo )
	self.id = "ZmAmmoFactory_AttachmentInfo"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 316 )
	self:setTopBottom( true, false, 0, 38 )
	self.anyChildUsesUpdateState = true
	
	self.AttachmentInfo = CoD.ZmAmmo_TextAttachmentInfo.new( menu, controller )
	self.AttachmentInfo:setLeftRight( false, true, -296, 0 )
	self.AttachmentInfo:setTopBottom( false, true, -27, -9 )
	self.AttachmentInfo:setRGB( 1, 0.99, 0.93 )
	self.AttachmentInfo:setAlpha( 0 )
	self:addElement( self.AttachmentInfo )
	
	self.AttachmentInfoFireRate = CoD.ZmAmmo_TextAttachmentInfoFire.new( menu, controller )
	self.AttachmentInfoFireRate:setLeftRight( false, true, -296, 0 )
	self.AttachmentInfoFireRate:setTopBottom( false, true, -27, -9 )
	self.AttachmentInfoFireRate:setRGB( 1, 0.99, 0.93 )
	self:addElement( self.AttachmentInfoFireRate )
	
	self.ZmFxSpark20 = CoD.ZmFx_Spark2blue.new( menu, controller )
	self.ZmFxSpark20:setLeftRight( true, false, 140, 316 )
	self.ZmFxSpark20:setTopBottom( true, false, 0.38, 37.25 )
	self.ZmFxSpark20:setAlpha( 0 )
	self.ZmFxSpark20:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmFxSpark20.Image0:setShaderVector( 1, 0, 0.4, 0, 0 )
	self.ZmFxSpark20.Image00:setShaderVector( 1, 0, -0.2, 0, 0 )
	self:addElement( self.ZmFxSpark20 )
	
	self.Flsh = LUI.UIImage.new()
	self.Flsh:setLeftRight( true, false, 291, 316 )
	self.Flsh:setTopBottom( true, false, 7.25, 30 )
	self.Flsh:setRGB( 0, 0.78, 1 )
	self.Flsh:setAlpha( 0 )
	self.Flsh:setImage( RegisterImage( "uie_t7_zm_hud_notif_txtstreak" ) )
	self.Flsh:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Flsh )
	
	self.Label0 = LUI.UITightText.new()
	self.Label0:setLeftRight( false, true, -200, 0 )
	self.Label0:setTopBottom( true, false, 30, 50 )
	self.Label0:setRGB( 1, 0.87, 0.54 )
	self.Label0:setTTF( "fonts/RefrigeratorDeluxe-Regular.ttf" )
	self.Label0:subscribeToGlobalModel( controller, "CurrentWeapon", "aat", function ( model )
		local aat = Engine.GetModelValue( model )
		if aat then
			self.Label0:setText( LocalizeString( aat ) )
		end
	end )
	self:addElement( self.Label0 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				local AttachmentInfoFrame2 = function ( element, event )
					local AttachmentInfoFrame3 = function ( element, event )
						local AttachmentInfoFrame4 = function ( element, event )
							local AttachmentInfoFrame5 = function ( element, event )
								local AttachmentInfoFrame6 = function ( element, event )
									if not event.interrupted then
										element:beginAnimation( "keyframe", 119, false, false, CoD.TweenType.Linear )
									end
									element:setAlpha( 0 )
									if event.interrupted then
										self.clipFinished( element, event )
									else
										element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
									end
								end

								if event.interrupted then
									AttachmentInfoFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 80, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0 )
									element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame6 )
								end
							end

							if event.interrupted then
								AttachmentInfoFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0.93 )
								element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame5 )
							end
						end

						if event.interrupted then
							AttachmentInfoFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0 )
							element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame4 )
						end
					end

					if event.interrupted then
						AttachmentInfoFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2000, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame3 )
					end
				end
				
				self.AttachmentInfo:completeAnimation()
				self.AttachmentInfo:setAlpha( 1 )
				AttachmentInfoFrame2( self.AttachmentInfo, {} )

				local AttachmentInfoFireRateFrame2 = function ( element, event )
					local AttachmentInfoFireRateFrame3 = function ( element, event )
						local AttachmentInfoFireRateFrame4 = function ( element, event )
							local AttachmentInfoFireRateFrame5 = function ( element, event )
								local AttachmentInfoFireRateFrame6 = function ( element, event )
									local AttachmentInfoFireRateFrame7 = function ( element, event )
										if not event.interrupted then
											element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
										end
										element:setAlpha( 1 )
										if event.interrupted then
											self.clipFinished( element, event )
										else
											element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
										end
									end

									if event.interrupted then
										AttachmentInfoFireRateFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 69, false, false, CoD.TweenType.Linear )
										element:setAlpha( 0 )
										element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame7 )
									end
								end

								if event.interrupted then
									AttachmentInfoFireRateFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 30, false, false, CoD.TweenType.Linear )
									element:setAlpha( 1 )
									element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame6 )
								end
							end

							if event.interrupted then
								AttachmentInfoFireRateFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0 )
								element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame5 )
							end
						end

						if event.interrupted then
							AttachmentInfoFireRateFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.67 )
							element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame4 )
						end
					end

					if event.interrupted then
						AttachmentInfoFireRateFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2000, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame3 )
					end
				end
				
				self.AttachmentInfoFireRate:completeAnimation()
				self.AttachmentInfoFireRate:setAlpha( 0 )
				AttachmentInfoFireRateFrame2( self.AttachmentInfoFireRate, {} )

				local ZmFxSpark20Frame2 = function ( element, event )
					local ZmFxSpark20Frame3 = function ( element, event )
						local ZmFxSpark20Frame4 = function ( element, event )
							local ZmFxSpark20Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
								end
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
								element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame5 )
							end
						end

						if event.interrupted then
							ZmFxSpark20Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Bounce )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame4 )
						end
					end

					if event.interrupted then
						ZmFxSpark20Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2029, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame3 )
					end
				end
				
				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				ZmFxSpark20Frame2( self.ZmFxSpark20, {} )

				local FlshFrame2 = function ( element, event )
					local FlshFrame3 = function ( element, event )
						local FlshFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 0, 187 )
							element:setTopBottom( true, false, 7.25, 30 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							FlshFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 210, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 23.17, 214.5 )
							element:setTopBottom( true, false, 7.29, 30.04 )
							element:setAlpha( 0.79 )
							element:registerEventHandler( "transition_complete_keyframe", FlshFrame4 )
						end
					end

					if event.interrupted then
						FlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 104.25, 310.75 )
						element:setTopBottom( true, false, 7.44, 30.19 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", FlshFrame3 )
					end
				end
				
				self.Flsh:beginAnimation( "keyframe", 1950, false, false, CoD.TweenType.Linear )
				self.Flsh:setLeftRight( true, false, 291, 316 )
				self.Flsh:setTopBottom( true, false, 7.25, 30 )
				self.Flsh:setAlpha( 0 )
				self.Flsh:registerEventHandler( "transition_complete_keyframe", FlshFrame2 )
			end,

			NoAttachments = function ()
				self:setupElementClipCounter( 4 )

				local AttachmentInfoFrame2 = function ( element, event )
					local AttachmentInfoFrame3 = function ( element, event )
						local AttachmentInfoFrame4 = function ( element, event )
							local AttachmentInfoFrame5 = function ( element, event )
								local AttachmentInfoFrame6 = function ( element, event )
									local AttachmentInfoFrame7 = function ( element, event )
										local AttachmentInfoFrame8 = function ( element, event )
											local AttachmentInfoFrame9 = function ( element, event )
												local AttachmentInfoFrame10 = function ( element, event )
													if not event.interrupted then
														element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
													end
													element:setAlpha( 0 )
													if event.interrupted then
														self.clipFinished( element, event )
													else
														element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
													end
												end

												if event.interrupted then
													AttachmentInfoFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
													element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame10 )
												end
											end

											if event.interrupted then
												AttachmentInfoFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
												element:setAlpha( 0.7 )
												element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame9 )
											end
										end

										if event.interrupted then
											AttachmentInfoFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
											element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame8 )
										end
									end

									if event.interrupted then
										AttachmentInfoFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
										element:setAlpha( 0 )
										element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame7 )
									end
								end

								if event.interrupted then
									AttachmentInfoFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 20, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame6 )
								end
							end

							if event.interrupted then
								AttachmentInfoFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0.7 )
								element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame5 )
							end
						end

						if event.interrupted then
							AttachmentInfoFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame4 )
						end
					end

					if event.interrupted then
						AttachmentInfoFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame3 )
					end
				end
				
				self.AttachmentInfo:completeAnimation()
				self.AttachmentInfo:setAlpha( 1 )
				AttachmentInfoFrame2( self.AttachmentInfo, {} )

				local AttachmentInfoFireRateFrame2 = function ( element, event )
					local AttachmentInfoFireRateFrame3 = function ( element, event )
						local AttachmentInfoFireRateFrame4 = function ( element, event )
							local AttachmentInfoFireRateFrame5 = function ( element, event )
								local AttachmentInfoFireRateFrame6 = function ( element, event )
									local AttachmentInfoFireRateFrame7 = function ( element, event )
										local AttachmentInfoFireRateFrame8 = function ( element, event )
											local AttachmentInfoFireRateFrame9 = function ( element, event )
												local AttachmentInfoFireRateFrame10 = function ( element, event )
													if not event.interrupted then
														element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
													end
													element:setAlpha( 1 )
													if event.interrupted then
														self.clipFinished( element, event )
													else
														element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
													end
												end

												if event.interrupted then
													AttachmentInfoFireRateFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
													element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame10 )
												end
											end

											if event.interrupted then
												AttachmentInfoFireRateFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
												element:setAlpha( 0 )
												element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame9 )
											end
										end

										if event.interrupted then
											AttachmentInfoFireRateFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 30, false, false, CoD.TweenType.Linear )
											element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame8 )
										end
									end

									if event.interrupted then
										AttachmentInfoFireRateFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
										element:setAlpha( 0.8 )
										element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame7 )
									end
								end

								if event.interrupted then
									AttachmentInfoFireRateFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame6 )
								end
							end

							if event.interrupted then
								AttachmentInfoFireRateFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0 )
								element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame5 )
							end
						end

						if event.interrupted then
							AttachmentInfoFireRateFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame4 )
						end
					end

					if event.interrupted then
						AttachmentInfoFireRateFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame3 )
					end
				end
				
				self.AttachmentInfoFireRate:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
				self.AttachmentInfoFireRate:setAlpha( 0 )
				self.AttachmentInfoFireRate:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame2 )

				local ZmFxSpark20Frame2 = function ( element, event )
					local ZmFxSpark20Frame3 = function ( element, event )
						local ZmFxSpark20Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
							end
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
							element:beginAnimation( "keyframe", 110, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.85 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame4 )
						end
					end

					if event.interrupted then
						ZmFxSpark20Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame3 )
					end
				end
				
				self.ZmFxSpark20:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
				self.ZmFxSpark20:setAlpha( 0 )
				self.ZmFxSpark20:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame2 )

				local FlshFrame2 = function ( element, event )
					local FlshFrame3 = function ( element, event )
						local FlshFrame4 = function ( element, event )
							local FlshFrame5 = function ( element, event )
								local FlshFrame6 = function ( element, event )
									if not event.interrupted then
										element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
									end
									element:setLeftRight( true, false, 0, 124 )
									element:setTopBottom( true, false, 7.44, 30.19 )
									element:setAlpha( 0 )
									if event.interrupted then
										self.clipFinished( element, event )
									else
										element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
									end
								end

								if event.interrupted then
									FlshFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, 0, 124 )
									element:setTopBottom( true, false, 7.44, 30.19 )
									element:setAlpha( 0.1 )
									element:registerEventHandler( "transition_complete_keyframe", FlshFrame6 )
								end
							end

							if event.interrupted then
								FlshFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 109, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, 25.39, 162.4 )
								element:setTopBottom( true, false, 7.4, 30.15 )
								element:setAlpha( 0.6 )
								element:registerEventHandler( "transition_complete_keyframe", FlshFrame5 )
							end
						end

						if event.interrupted then
							FlshFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 30, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 81.24, 246.88 )
							element:setTopBottom( true, false, 7.32, 30.07 )
							element:setAlpha( 0.91 )
							element:registerEventHandler( "transition_complete_keyframe", FlshFrame4 )
						end
					end

					if event.interrupted then
						FlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 151.16, 269.92 )
						element:setTopBottom( true, false, 7.3, 30.05 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", FlshFrame3 )
					end
				end
				
				self.Flsh:completeAnimation()
				self.Flsh:setLeftRight( true, false, 291, 316 )
				self.Flsh:setTopBottom( true, false, 7.25, 30 )
				self.Flsh:setAlpha( 0 )
				FlshFrame2( self.Flsh, {} )
			end
		},

		NoAttachments = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.AttachmentInfo:completeAnimation()
				self.AttachmentInfo:setAlpha( 0 )
				self.clipFinished( self.AttachmentInfo, {} )

				self.AttachmentInfoFireRate:completeAnimation()
				self.AttachmentInfoFireRate:setAlpha( 1 )
				self.clipFinished( self.AttachmentInfoFireRate, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.Flsh:completeAnimation()
				self.Flsh:setAlpha( 0 )
				self.clipFinished( self.Flsh, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 4 )

				local AttachmentInfoFrame2 = function ( element, event )
					local AttachmentInfoFrame3 = function ( element, event )
						local AttachmentInfoFrame4 = function ( element, event )
							local AttachmentInfoFrame5 = function ( element, event )
								local AttachmentInfoFrame6 = function ( element, event )
									local AttachmentInfoFrame7 = function ( element, event )
										local AttachmentInfoFrame8 = function ( element, event )
											local AttachmentInfoFrame9 = function ( element, event )
												local AttachmentInfoFrame10 = function ( element, event )
													if not event.interrupted then
														element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
													end
													element:setAlpha( 1 )
													if event.interrupted then
														self.clipFinished( element, event )
													else
														element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
													end
												end

												if event.interrupted then
													AttachmentInfoFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
													element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame10 )
												end
											end

											if event.interrupted then
												AttachmentInfoFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
												element:setAlpha( 0 )
												element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame9 )
											end
										end

										if event.interrupted then
											AttachmentInfoFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 30, false, false, CoD.TweenType.Linear )
											element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame8 )
										end
									end

									if event.interrupted then
										AttachmentInfoFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
										element:setAlpha( 0.8 )
										element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame7 )
									end
								end

								if event.interrupted then
									AttachmentInfoFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame6 )
								end
							end

							if event.interrupted then
								AttachmentInfoFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0 )
								element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame5 )
							end
						end

						if event.interrupted then
							AttachmentInfoFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame4 )
						end
					end

					if event.interrupted then
						AttachmentInfoFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame3 )
					end
				end
				
				self.AttachmentInfo:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
				self.AttachmentInfo:setAlpha( 0 )
				self.AttachmentInfo:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFrame2 )

				local AttachmentInfoFireRateFrame2 = function ( element, event )
					local AttachmentInfoFireRateFrame3 = function ( element, event )
						local AttachmentInfoFireRateFrame4 = function ( element, event )
							local AttachmentInfoFireRateFrame5 = function ( element, event )
								local AttachmentInfoFireRateFrame6 = function ( element, event )
									local AttachmentInfoFireRateFrame7 = function ( element, event )
										local AttachmentInfoFireRateFrame8 = function ( element, event )
											local AttachmentInfoFireRateFrame9 = function ( element, event )
												local AttachmentInfoFireRateFrame10 = function ( element, event )
													if not event.interrupted then
														element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
													end
													element:setAlpha( 0 )
													if event.interrupted then
														self.clipFinished( element, event )
													else
														element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
													end
												end

												if event.interrupted then
													AttachmentInfoFireRateFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
													element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame10 )
												end
											end

											if event.interrupted then
												AttachmentInfoFireRateFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
												element:setAlpha( 0.7 )
												element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame9 )
											end
										end

										if event.interrupted then
											AttachmentInfoFireRateFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
											element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame8 )
										end
									end

									if event.interrupted then
										AttachmentInfoFireRateFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
										element:setAlpha( 0 )
										element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame7 )
									end
								end

								if event.interrupted then
									AttachmentInfoFireRateFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 20, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame6 )
								end
							end

							if event.interrupted then
								AttachmentInfoFireRateFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0.7 )
								element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame5 )
							end
						end

						if event.interrupted then
							AttachmentInfoFireRateFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame4 )
						end
					end

					if event.interrupted then
						AttachmentInfoFireRateFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", AttachmentInfoFireRateFrame3 )
					end
				end
				
				self.AttachmentInfoFireRate:completeAnimation()
				self.AttachmentInfoFireRate:setAlpha( 1 )
				AttachmentInfoFireRateFrame2( self.AttachmentInfoFireRate, {} )

				local ZmFxSpark20Frame2 = function ( element, event )
					local ZmFxSpark20Frame3 = function ( element, event )
						local ZmFxSpark20Frame4 = function ( element, event )
							local ZmFxSpark20Frame5 = function ( element, event )
								local ZmFxSpark20Frame6 = function ( element, event )
									local ZmFxSpark20Frame7 = function ( element, event )
										if not event.interrupted then
											element:beginAnimation( "keyframe", 70, false, false, CoD.TweenType.Linear )
										end
										element:setAlpha( 0 )
										if event.interrupted then
											self.clipFinished( element, event )
										else
											element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
										end
									end

									if event.interrupted then
										ZmFxSpark20Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 69, false, false, CoD.TweenType.Linear )
										element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame7 )
									end
								end

								if event.interrupted then
									ZmFxSpark20Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 20, false, false, CoD.TweenType.Linear )
									element:setAlpha( 1 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame6 )
								end
							end

							if event.interrupted then
								ZmFxSpark20Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 10, false, false, CoD.TweenType.Linear )
								element:setAlpha( 0.49 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame5 )
							end
						end

						if event.interrupted then
							ZmFxSpark20Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame4 )
						end
					end

					if event.interrupted then
						ZmFxSpark20Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame3 )
					end
				end
				
				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				ZmFxSpark20Frame2( self.ZmFxSpark20, {} )

				local FlshFrame2 = function ( element, event )
					local FlshFrame3 = function ( element, event )
						local FlshFrame4 = function ( element, event )
							local FlshFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
								end
								element:setLeftRight( true, false, 0, 80 )
								element:setTopBottom( true, false, 7.44, 30.19 )
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								FlshFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, 49.99, 149.21 )
								element:registerEventHandler( "transition_complete_keyframe", FlshFrame5 )
							end
						end

						if event.interrupted then
							FlshFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 30, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 133.3, 264.57 )
							element:registerEventHandler( "transition_complete_keyframe", FlshFrame4 )
						end
					end

					if event.interrupted then
						FlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 203.89, 286.61 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", FlshFrame3 )
					end
				end
				
				self.Flsh:completeAnimation()
				self.Flsh:setLeftRight( true, false, 298, 316 )
				self.Flsh:setTopBottom( true, false, 7.44, 30.19 )
				self.Flsh:setAlpha( 0 )
				FlshFrame2( self.Flsh, {} )
			end
		},

		HeroWeapon = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.AttachmentInfo:completeAnimation()
				self.AttachmentInfo:setAlpha( 0 )
				self.clipFinished( self.AttachmentInfo, {} )

				self.AttachmentInfoFireRate:completeAnimation()
				self.AttachmentInfoFireRate:setAlpha( 0.5 )
				self.clipFinished( self.AttachmentInfoFireRate, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.Flsh:completeAnimation()
				self.Flsh:setAlpha( 0 )
				self.clipFinished( self.Flsh, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.AttachmentInfo:close()
		element.AttachmentInfoFireRate:close()
		element.ZmFxSpark20:close()
		element.Label0:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end