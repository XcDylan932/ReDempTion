require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark1Img" )

local swordIcon = {
	["default"] = "uie_t7_zm_derriese_hud_ammo_icon_gun",
	["zm_zod"] = "uie_t7_zm_hud_ammo_dpadicnswrd_new",
	["zm_castle"] = "t7_hud_zm_hud_ammo_icon_spike",
	["zm_island"] = "t7_hud_zm_hud_ammo_icon_skull_weapon",
	["zm_stalingrad"] = "uie_t7_zm_dragon_gauntlet_ammo_icon_gun",
	["zm_genesis"] = "t7_hud_zm_hud_ammo_icon_spike"
}

local swordReady = {
	["default"] = "uie_t7_zm_derriese_hud_ammo_icon_gun_ready",
	["zm_zod"] = "uie_t7_zm_hud_ammo_dpadicnswrd_new_ready",
	["zm_castle"] = "t7_hud_zm_hud_ammo_icon_spike_ready",
	["zm_island"] = "t7_hud_zm_hud_ammo_icon_skull_weapon_ready",
	["zm_stalingrad"] = "uie_t7_zm_dragon_gauntlet_ammo_icon_gun_ready",
	["zm_genesis"] = "t7_hud_zm_hud_ammo_icon_spike_ready"
}

local swordFlash = {
	["default"] = "uie_t7_zm_derriese_hud_ammo_icon_gun_readyflash",
	["zm_zod"] = "uie_t7_zm_hud_ammo_dpadicnswrd_electric_ready",
	["zm_castle"] = "t7_hud_zm_hud_ammo_icon_spike_readyflash",
	["zm_island"] = "t7_hud_zm_hud_ammo_icon_skull_weapon_readyflash",
	["zm_stalingrad"] = "uie_t7_zm_dragon_gauntlet_ammo_icon_gun_readyflash",
	["zm_genesis"] = "t7_hud_zm_hud_ammo_icon_spike_readyflash"
}

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        local elements = { self.ZmFxSpark1Img0, self.Lightning, self.DpadIconSwordReady, self.DpadIconSwordReady0 }
        for _, element in ipairs( elements ) do
            if element then
                element:completeAnimation()
                element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
                CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
            end
        end
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_DpadIconPistolFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadIconPistolFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()
	local mapName = Engine.GetCurrentMap()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadIconPistolFactory )
	self.id = "ZmAmmo_DpadIconPistolFactory"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 32 )
	self:setTopBottom( true, false, 0, 32 )
	
	self.DpadIconSword = LUI.UIImage.new()
	self.DpadIconSword:setLeftRight( true, false, -16.75, 48.25 )
	self.DpadIconSword:setTopBottom( true, false, -15.75, 49.25 )
	self.DpadIconSword:setAlpha( 0 )
	self.DpadIconSword:setZoom( 4 )
	self.DpadIconSword:setImage( RegisterImage( swordIcon[mapName] or swordIcon["default"] ) )
	self:addElement( self.DpadIconSword )
	
	self.ZmFxSpark1Img0 = CoD.ZmFx_Spark1Img.new( menu, controller )
	self.ZmFxSpark1Img0:setLeftRight( true, false, -33.94, 46.72 )
	self.ZmFxSpark1Img0:setTopBottom( true, false, -77.44, 40.56 )
	self.ZmFxSpark1Img0:setRGB( 0, 0.89, 1 )
	self.ZmFxSpark1Img0:setAlpha( 0 )
	self.ZmFxSpark1Img0:setYRot( 180 )
	self.ZmFxSpark1Img0:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmFxSpark1Img0.Image00:setShaderVector( 0, 10, 2, 0, 0 )
	self.ZmFxSpark1Img0.Image00:setShaderVector( 1, 30, 0, 0, 0 )
	self:addElement( self.ZmFxSpark1Img0 )
	
	self.DpadIconSwordReady = LUI.UIImage.new()
	self.DpadIconSwordReady:setLeftRight( true, false, -16, 47.5 )
	self.DpadIconSwordReady:setTopBottom( true, false, -14.5, 48 )
	self.DpadIconSwordReady:setImage( RegisterImage( swordReady[mapName] or swordReady["default"] ) )
	self:addElement( self.DpadIconSwordReady )
	
	self.DpadIconSwordReady0 = LUI.UIImage.new()
	self.DpadIconSwordReady0:setLeftRight( true, false, -15.63, 46.72 )
	self.DpadIconSwordReady0:setTopBottom( true, false, -14.35, 48 )
	self.DpadIconSwordReady0:setAlpha( 0 )
	self.DpadIconSwordReady0:setImage( RegisterImage( swordFlash[mapName] or swordFlash["default"] ) )
	self:addElement( self.DpadIconSwordReady0 )
	
	self.Lightning = LUI.UIImage.new()
	self.Lightning:setLeftRight( true, false, -67.86, 99.36 )
	self.Lightning:setTopBottom( true, false, -67.72, 73.72 )
	self.Lightning:setAlpha( 0 )
	self.Lightning:setImage( RegisterImage( "uie_t7_zm_derriese_hud_notification_anim" ) )
	self.Lightning:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_flipbook" ) )
	self.Lightning:setShaderVector( 0, 28, 0, 0, 0 )
	self.Lightning:setShaderVector( 1, 30, 0, 0, 0 )
	self:addElement( self.Lightning )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 5 )

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

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
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
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1080, false, false, CoD.TweenType.Linear )
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
						DpadIconSwordReadyFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 119, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", DpadIconSwordReadyFrame3 )
					end
				end
				
				self.DpadIconSwordReady:completeAnimation()
				--self.DpadIconSwordReady:setRGB( 1, 1, 1 )
				CoD.UIColors.SetElementColor( self.DpadIconSwordReady, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.DpadIconSwordReady:setAlpha( 0 )
				DpadIconSwordReadyFrame2( self.DpadIconSwordReady, {} )

				local DpadIconSwordReady0Frame2 = function ( element, event )
					local DpadIconSwordReady0Frame3 = function ( element, event )
						local DpadIconSwordReady0Frame4 = function ( element, event )
							local DpadIconSwordReady0Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 289, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end

							if event.interrupted then
								DpadIconSwordReady0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 290, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", DpadIconSwordReady0Frame5 )
							end
						end

						if event.interrupted then
							DpadIconSwordReady0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 289, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0 )
							element:registerEventHandler( "transition_complete_keyframe", DpadIconSwordReady0Frame4 )
						end
					end

					if event.interrupted then
						DpadIconSwordReady0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 280, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", DpadIconSwordReady0Frame3 )
					end
				end
				
				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setAlpha( 0 )
				DpadIconSwordReady0Frame2( self.DpadIconSwordReady0, {} )

				local LightningFrame2 = function ( element, event )
					local LightningFrame3 = function ( element, event )
						local LightningFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 409, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							LightningFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 519, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", LightningFrame4 )
						end
					end

					if event.interrupted then
						LightningFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 119, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", LightningFrame3 )
					end
				end
				
				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				LightningFrame2( self.Lightning, {} )
			end,

			InUse = function ()
				self:setupElementClipCounter( 2 )

				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setRGB( 1, 1, 1 )
				self.DpadIconSwordReady:setAlpha( 1 )
				self.clipFinished( self.DpadIconSwordReady, {} )
			end
		},

		Charge = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setRGB( 1, 1, 1 )
				self.DpadIconSwordReady:setAlpha( 0.3 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady0, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
			end
		},

		InUse = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setRGB( 1, 1, 1 )
				self.DpadIconSwordReady:setAlpha( 1 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setRGB( 1, 1, 1 )
				self.DpadIconSwordReady0:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady0, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
			end
		},

		Unavailable = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.DpadIconSword:completeAnimation()
				self.DpadIconSword:setAlpha( 1 )
				self.clipFinished( self.DpadIconSword, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setAlpha( 0 )
				self.clipFinished( self.DpadIconSwordReady0, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
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
							element:setRGB( 0, 0.8, 1 )
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
				self.ZmFxSpark1Img0:setRGB( 0, 0.8, 1 )
				self.ZmFxSpark1Img0:setAlpha( 0.82 )
				ZmFxSpark1Img0Frame2( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				self.DpadIconSwordReady:setRGB( 1, 1, 1 )
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

				local LightningFrame2 = function ( element, event )
					local LightningFrame3 = function ( element, event )
						local LightningFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 539, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							LightningFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 530, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", LightningFrame4 )
						end
					end

					if event.interrupted then
						LightningFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", LightningFrame3 )
					end
				end
				
				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				LightningFrame2( self.Lightning, {} )
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
				self:setupElementClipCounter( 4 )

				self.ZmFxSpark1Img0:completeAnimation()
				self.ZmFxSpark1Img0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark1Img0, {} )

				self.DpadIconSwordReady:completeAnimation()
				--self.DpadIconSwordReady:setRGB( 1, 0.46, 0 )
				CoD.UIColors.SetElementColor( self.DpadIconSwordReady, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.DpadIconSwordReady:setAlpha( 1 )
				self.clipFinished( self.DpadIconSwordReady, {} )

				self.DpadIconSwordReady0:completeAnimation()
				self.DpadIconSwordReady0:setRGB( 0, 0.97, 1 )
				self.DpadIconSwordReady0:setAlpha( 1 )
				self.clipFinished( self.DpadIconSwordReady0, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
			end
		},

		ElectricInUse = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

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

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
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