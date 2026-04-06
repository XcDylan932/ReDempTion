require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark1Img" )

local PostLoadFunc = function( self, controller, menu )
	self.UpdateColors = function( self )
		CoD.UIColors.SetElementColor( self.GlowOrangeOver, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_DpadIconSword = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadIconSword.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadIconSword )
	self.id = "ZmAmmo_DpadIconSword"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 32 )
	self:setTopBottom( true, false, 0, 32 )
	
	self.DpadIconSword = LUI.UIImage.new()
	self.DpadIconSword:setLeftRight( true, false, 0, 38 )
	self.DpadIconSword:setTopBottom( true, false, 0, 38 )
	self.DpadIconSword:setAlpha( 0 )
	self.DpadIconSword:setZoom( 4 )
	self.DpadIconSword:setImage( RegisterImage( "uie_t7_zm_hud_ammo_dpadicnswrd_new" ) )
	self:addElement( self.DpadIconSword )
	
	self.ZmFxSpark1Img0 = CoD.ZmFx_Spark1Img.new( menu, controller )
	self.ZmFxSpark1Img0:setLeftRight( true, false, -33.94, 46.72 )
	self.ZmFxSpark1Img0:setTopBottom( true, false, -77.44, 40.56 )
	self.ZmFxSpark1Img0:setAlpha( 0 )
	self.ZmFxSpark1Img0:setYRot( 180 )
	self.ZmFxSpark1Img0:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmFxSpark1Img0.Image00:setShaderVector( 0, 10, 2, 0, 0 )
	self.ZmFxSpark1Img0.Image00:setShaderVector( 1, 30, 0, 0, 0 )
	self:addElement( self.ZmFxSpark1Img0 )
	
	self.DpadIconSwordReady = LUI.UIImage.new()
	self.DpadIconSwordReady:setLeftRight( true, false, -19, 51 )
	self.DpadIconSwordReady:setTopBottom( true, false, -17, 53 )
	self.DpadIconSwordReady:setAlpha( 0 )
	self.DpadIconSwordReady:setImage( RegisterImage( "uie_t7_zm_hud_ammo_dpadicnswrd_new_ready" ) )
	self:addElement( self.DpadIconSwordReady )
	
	self.DpadIconSwordReady0 = LUI.UIImage.new()
	self.DpadIconSwordReady0:setLeftRight( true, false, -19, 51 )
	self.DpadIconSwordReady0:setTopBottom( true, false, -17, 53 )
	self.DpadIconSwordReady0:setAlpha( 0 )
	self.DpadIconSwordReady0:setImage( RegisterImage( "uie_t7_zm_hud_ammo_dpadicnswrd_electric_ready" ) )
	self:addElement( self.DpadIconSwordReady0 )
	
	self.GlowOrangeOver = LUI.UIImage.new()
	self.GlowOrangeOver:setLeftRight( false, false, -22.75, 19 )
	self.GlowOrangeOver:setTopBottom( false, false, -17, 19 )
	CoD.UIColors.SetElementColor( self.GlowOrangeOver, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.GlowOrangeOver:setAlpha( 0 )
	self.GlowOrangeOver:setZRot( -54 )
	self.GlowOrangeOver:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.GlowOrangeOver:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.GlowOrangeOver )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.DpadIconSword:completeAnimation()
				self.DpadIconSword:setAlpha( 0 )
				self.clipFinished( self.DpadIconSword, {} )

				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady0, {} )
			end
		},

		Ready = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				local ZmFxSpark1Img0Frame2 = function ( element, event )
					local ZmFxSpark1Img0Frame3 = function ( element, event )
						local ZmFxSpark1Img0Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 629, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							ZmFxSpark1Img0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 489, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.8 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark1Img0Frame4 )
						end
					end

					if event.interrupted then
						ZmFxSpark1Img0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark1Img0Frame3 )
					end
				end
				
				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0.82 )
				ZmFxSpark1Img0Frame2( self.ZmFxSpark1Img0, {} )

				local DpadIconSwordReadyFrame2 = function ( element, event )
					local DpadIconSwordReadyFrame3 = function ( element, event )
						local DpadIconSwordReadyFrame4 = function ( element, event )
							local DpadIconSwordReadyFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 590, false, false, CoD.TweenType.Linear )
								end
								--element:setRGB( 1, 1, 1 )
								element:setAlpha( 1 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end

							if event.interrupted then
								DpadIconSwordReadyFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 240, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", DpadIconSwordReadyFrame5 )
							end
						end

						if event.interrupted then
							DpadIconSwordReadyFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.28 )
							element:registerEventHandler( "transition_complete_keyframe", DpadIconSwordReadyFrame4 )
						end
					end

					if event.interrupted then
						DpadIconSwordReadyFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", DpadIconSwordReadyFrame3 )
					end
				end
				
				self.DpadIconSwordReady:completeAnimation()
				--self.DpadIconSwordReady:setRGB( 1, 1, 1 )
				CoD.UIColors.SetElementColor( self.DpadIconSwordReady, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.DpadIconSwordReady:setAlpha( 0 )
				DpadIconSwordReadyFrame2( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady0, {} )

				local GlowOrangeOverFrame2 = function ( element, event )
					local GlowOrangeOverFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 599, true, false, CoD.TweenType.Bounce )
						end
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						GlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 300, true, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame3 )
					end
				end
				
				self.GlowOrangeOver:completeAnimation()
				CoD.UIColors.SetElementColor( self.GlowOrangeOver, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.GlowOrangeOver:setAlpha( 0 )
				GlowOrangeOverFrame2( self.GlowOrangeOver, {} )
			end,

			InUse = function ()
				self:setupElementClipCounter( 2 )

				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setAlpha( 1 )
				self.clipFinished( self.DpadIconSwordReady, {} )
			end
		},

		Charge = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setRGB( 1, 1, 1 )
				--CoD.UIColors.SetElementColor( self.DpadIconSwordReady, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.DpadIconSwordReady:setAlpha( 1 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady0, {} )
			end
		},

		InUse = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setRGB( 1, 1, 1 )
				self.DpadIconSwordReady:setAlpha( 1 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady0, {} )
			end
		},

		Unavailable = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.DpadIconSword:completeAnimation()
				self.DpadIconSword:setAlpha( 1 )
				self.clipFinished( self.DpadIconSword, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady0, {} )
			end
		},

		ElectricReady = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				local ZmFxSpark1Img0Frame2 = function ( element, event )
					local ZmFxSpark1Img0Frame3 = function ( element, event )
						local ZmFxSpark1Img0Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 629, false, false, CoD.TweenType.Linear )
							end
							CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							ZmFxSpark1Img0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 489, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.8 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark1Img0Frame4 )
						end
					end

					if event.interrupted then
						ZmFxSpark1Img0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark1Img0Frame3 )
					end
				end
				
				self.ZmFxSpark1Img0:completeAnimation()
				CoD.UIColors.SetElementColor( self.ZmFxSpark1Img0, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.ZmFxSpark1Img0:setAlpha( 0.82 )
				ZmFxSpark1Img0Frame2( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				--self.DpadIconSwordReady:setRGB( 1, 1, 1 )
				CoD.UIColors.SetElementColor( self.DpadIconSwordReady, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.DpadIconSwordReady:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				local DpadIconSwordReady0Frame2 = function ( element, event )
					local DpadIconSwordReady0Frame3 = function ( element, event )
						local DpadIconSwordReady0Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 240, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 1 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							DpadIconSwordReady0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.28 )
							element:registerEventHandler( "transition_complete_keyframe", DpadIconSwordReady0Frame4 )
						end
					end

					if event.interrupted then
						DpadIconSwordReady0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", DpadIconSwordReady0Frame3 )
					end
				end
				
				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setAlpha( 0 )
				DpadIconSwordReady0Frame2( self.DpadIconSwordReady0, {} )

				local GlowOrangeOverFrame2 = function ( element, event )
					local GlowOrangeOverFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 420, true, false, CoD.TweenType.Bounce )
						end
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						GlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, true, false, CoD.TweenType.Bounce )
						element:setAlpha( 0.57 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame3 )
					end
				end
				
				self.GlowOrangeOver:completeAnimation()
				CoD.UIColors.SetElementColor( self.GlowOrangeOver, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.GlowOrangeOver:setAlpha( 0 )
				GlowOrangeOverFrame2( self.GlowOrangeOver, {} )
			end,

			InUse = function ()
				self:setupElementClipCounter( 3 )

				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setAlpha( 1 )
				self.clipFinished( self.DpadIconSwordReady0, {} )
			end
		},

		ElectricCharge = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setRGB( 1, 1, 1 )
				--CoD.UIColors.SetElementColor( self.DpadIconSwordReady, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.DpadIconSwordReady:setAlpha( 1 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setRGB( 1, 1, 1 )
				--CoD.UIColors.SetElementColor( self.DpadIconSwordReady0, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.DpadIconSwordReady0:setAlpha( 1 )
				self.clipFinished( self.DpadIconSwordReady0, {} )
			end
		},

		ElectricInUse = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setRGB( 1, 1, 1 )
				self.DpadIconSwordReady:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setRGB( 1, 1, 1 )
				self.DpadIconSwordReady0:setAlpha( 1 )
				self.clipFinished( self.DpadIconSwordReady0, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Ready",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "zmhud.swordState", 2 )
			end
		},
		{
			stateName = "Charge",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "zmhud.swordState", 1 )
			end
		},
		{
			stateName = "InUse",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "zmhud.swordState", 3 )
			end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "zmhud.swordState", 4 )
			end
		},
		{
			stateName = "ElectricReady",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "zmhud.swordState", 6 )
			end
		},
		{
			stateName = "ElectricCharge",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "zmhud.swordState", 5 )
			end
		},
		{
			stateName = "ElectricInUse",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "zmhud.swordState", 7 )
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordState" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "zmhud.swordState" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ZmFxSpark1Img0:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end