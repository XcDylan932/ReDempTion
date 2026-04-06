CoD.ZmAmmo_DpadMeterSword = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadMeterSword.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadMeterSword )
	self.id = "ZmAmmo_DpadMeterSword"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 48 )
	self:setTopBottom( true, false, 0, 56 )
	
	self.SwordRingBack = LUI.UIImage.new()
	self.SwordRingBack:setLeftRight( true, false, 4, 44 )
	self.SwordRingBack:setTopBottom( true, false, 4, 52 )
	self.SwordRingBack:setRGB( 0.11, 0.11, 0.11 )
	self.SwordRingBack:setAlpha( 0 )
	self.SwordRingBack:setImage( RegisterImage( "uie_t7_zm_hud_ammo_dpadmtr" ) )
	self:addElement( self.SwordRingBack )
	
	self.SwordRing = LUI.UIImage.new()
	self.SwordRing:setLeftRight( true, false, -22, 64 )
	self.SwordRing:setTopBottom( true, false, -14.5, 71.5 )
	self.SwordRing:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_dpadmtr" ) )
	self.SwordRing:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_clock_normal" ) )
	self.SwordRing:setShaderVector( 1, 0.5, 0, 0, 0 )
	self.SwordRing:setShaderVector( 2, 0.5, 0, 0, 0 )
	self.SwordRing:setShaderVector( 3, 0.05, 0, 0, 0 )
	self.SwordRing:setScale( 0.87 )
	self.SwordRing:subscribeToGlobalModel( controller, "PerController", "zmhud.swordEnergy", function ( model )
		local zmhudSwordEnergy = Engine.GetModelValue( model )
		if zmhudSwordEnergy then
			self.SwordRing:setShaderVector( 0, AdjustStartEnd( 0.06, 0.94, CoD.GetVectorComponentFromString( zmhudSwordEnergy, 1 ), CoD.GetVectorComponentFromString( zmhudSwordEnergy, 2 ), CoD.GetVectorComponentFromString( zmhudSwordEnergy, 3 ), CoD.GetVectorComponentFromString( zmhudSwordEnergy, 4 ) ) )
		end
	end )
	self:addElement( self.SwordRing )
	
	self.SwordRingGlow = LUI.UIImage.new()
	self.SwordRingGlow:setLeftRight( true, false, -22, 64 )
	self.SwordRingGlow:setTopBottom( true, false, -14.5, 71.5 )
	--self.SwordRingGlow:setImage( RegisterImage( "uie_t7_zm_hud_ammo_dpadmtr_new_flash" ) )
	self.SwordRingGlow:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_dpadmtr_flash" ) )
	self.SwordRingGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_clock_add" ) )
	self.SwordRingGlow:setShaderVector( 1, 0.5, 0, 0, 0 )
	self.SwordRingGlow:setShaderVector( 2, 0.5, 0, 0, 0 )
	self.SwordRingGlow:setShaderVector( 3, 0.05, 0, 0, 0 )
	self.SwordRingGlow:subscribeToGlobalModel( controller, "PerController", "zmhud.swordEnergy", function ( model )
		local zmhudSwordEnergy = Engine.GetModelValue( model )
		if zmhudSwordEnergy then
			self.SwordRingGlow:setShaderVector( 0, AdjustStartEnd( 0.06, 0.94, CoD.GetVectorComponentFromString( zmhudSwordEnergy, 1 ), CoD.GetVectorComponentFromString( zmhudSwordEnergy, 2 ), CoD.GetVectorComponentFromString( zmhudSwordEnergy, 3 ), CoD.GetVectorComponentFromString( zmhudSwordEnergy, 4 ) ) )
		end
	end )
	self:addElement( self.SwordRingGlow )
	
	self.AbilitySwirl = LUI.UIImage.new()
	self.AbilitySwirl:setLeftRight( true, false, -6, 54 )
	self.AbilitySwirl:setTopBottom( true, false, -2, 58 )
	CoD.UIColors.SetElementColor( self.AbilitySwirl, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.AbilitySwirl:setAlpha( 0 )
	self.AbilitySwirl:setYRot( 17 )
	self.AbilitySwirl:setZRot( -267 )
	self.AbilitySwirl:setImage( RegisterImage( "uie_t7_core_hud_ammowidget_abilityswirl" ) )
	self.AbilitySwirl:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.AbilitySwirl )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.SwordRingBack:completeAnimation()
				self.SwordRingBack:setAlpha( 0 )
				self.clipFinished( self.SwordRingBack, {} )

				self.SwordRing:completeAnimation()
				self.SwordRing:setAlpha( 0 )
				self.clipFinished( self.SwordRing, {} )

				self.SwordRingGlow:completeAnimation()
				self.SwordRingGlow:setAlpha( 0 )
				self.clipFinished( self.SwordRingGlow, {} )

				self.AbilitySwirl:completeAnimation()
				self.AbilitySwirl:setAlpha( 0 )
				self.clipFinished( self.AbilitySwirl, {} )
			end
		},

		Ready = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.SwordRing:completeAnimation()
				CoD.UIColors.SetElementColor( self.SwordRing, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.SwordRing:setAlpha( 1 )
				self.clipFinished( self.SwordRing, {} )

				local SwordRingGlowFrame2 = function ( element, event )
					local SwordRingGlowFrame3 = function ( element, event )
						local SwordRingGlowFrame4 = function ( element, event )
							local SwordRingGlowFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 379, false, true, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end

							if event.interrupted then
								SwordRingGlowFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 360, true, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", SwordRingGlowFrame5 )
							end
						end

						if event.interrupted then
							SwordRingGlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 280, false, true, CoD.TweenType.Linear )
							element:setAlpha( 0 )
							element:registerEventHandler( "transition_complete_keyframe", SwordRingGlowFrame4 )
						end
					end

					if event.interrupted then
						SwordRingGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 280, true, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", SwordRingGlowFrame3 )
					end
				end
				
				self.SwordRingGlow:completeAnimation()
				self.SwordRingGlow:setAlpha( 0 )
				SwordRingGlowFrame2( self.SwordRingGlow, {} )

				local AbilitySwirlFrame2 = function ( element, event )
					local AbilitySwirlFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 280, false, true, CoD.TweenType.Linear )
						end
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 0 )
						element:setZRot( 300 )
						element:setScale( 2 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						AbilitySwirlFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 280, true, false, CoD.TweenType.Linear )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 1 )
						element:setZRot( 0 )
						element:setScale( 1 )
						element:registerEventHandler( "transition_complete_keyframe", AbilitySwirlFrame3 )
					end
				end
				
				self.AbilitySwirl:completeAnimation()
				CoD.UIColors.SetElementColor( self.AbilitySwirl, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.AbilitySwirl:setAlpha( 0 )
				self.AbilitySwirl:setZRot( -300 )
				self.AbilitySwirl:setScale( 0.5 )
				AbilitySwirlFrame2( self.AbilitySwirl, {} )
			end
		},

		Charge = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.SwordRing:completeAnimation()
				self.SwordRing:setRGB( 1, 1, 1 )
				self.SwordRing:setAlpha( 1 )
				self.clipFinished( self.SwordRing, {} )

				self.SwordRingGlow:completeAnimation()
				self.SwordRingGlow:setAlpha( 0 )
				self.clipFinished( self.SwordRingGlow, {} )
			end,

			UpdateCharge = function ()
				self:setupElementClipCounter( 2 )

				local SwordRingFrame2 = function ( element, event )
					local SwordRingFrame3 = function ( element, event )
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
					
					if event.interrupted then
						SwordRingFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.25 )
						element:registerEventHandler( "transition_complete_keyframe", SwordRingFrame3 )
					end
				end
				
				self.SwordRing:completeAnimation()
				self.SwordRing:setAlpha( 1 )
				SwordRingFrame2( self.SwordRing, {} )

				self.SwordRingGlow:completeAnimation()
				self.SwordRingGlow:setAlpha( 0 )
				self.clipFinished( self.SwordRingGlow, {} )
			end
		},

		InUse = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.SwordRing:completeAnimation()
				self.SwordRing:setRGB( 1, 1, 1 )
				self.SwordRing:setAlpha( 1 )
				self.clipFinished( self.SwordRing, {} )

				self.SwordRingGlow:completeAnimation()
				self.SwordRingGlow:setAlpha( 0 )
				self.clipFinished( self.SwordRingGlow, {} )
			end
		},

		InUseLow = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.SwordRing:completeAnimation()
				self.SwordRing:setRGB( 0.95, 0, 0.01 )
				self.SwordRing:setAlpha( 1 )
				self.clipFinished( self.SwordRing, {} )

				self.SwordRingGlow:completeAnimation()
				self.SwordRingGlow:setAlpha( 0 )
				self.clipFinished( self.SwordRingGlow, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualToEitherValue( controller, "zmhud.swordState", 2, 6 )
			end
		},
		{
			stateName = "Charge",
			condition = function ( menu, element, event )
				return IsModelValueEqualToEitherValue( controller, "zmhud.swordState", 1, 5 )
			end
		},
		{
			stateName = "InUse",
			condition = function ( menu, element, event )
				return IsHeroWeaponOrGadgetEnergyAtLeast( controller, 0.1 ) and IsModelValueEqualToEitherValue( controller, "zmhud.swordState", 3, 7 )
			end
		},
		{
			stateName = "InUseLow",
			condition = function ( menu, element, event )
				return IsModelValueEqualToEitherValue( controller, "zmhud.swordState", 3, 7 )
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordState" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "zmhud.swordState" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "playerAbilities.playerGadget3.powerRatio" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "playerAbilities.playerGadget3.powerRatio" } )
	end )

	self:subscribeToGlobalModel( controller, "PerController", "zmhud.swordChargeUpdate", function ( model )
		if IsSelfInState( self, "Charge" ) then
			PlayClip( self, "UpdateCharge", controller )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.SwordRing:close()
		element.SwordRingGlow:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end