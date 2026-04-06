require( "ui.uieditor.widgets.HUD.T10.T10AmmoWidget.T10AmmoEquipment" )
require( "ui.uieditor.widgets.HUD.T10.T10AmmoWidget.T10AmmoInfo" )
require( "ui.uieditor.widgets.HUD.ZM_AmmoWidget.ZmAmmo_BBGumMeterWidget" )

local aatIcons = {
    ["t7_icon_zm_aat_dead_wire"] = "ui_icons_elementaldamage_electrical",
    ["t7_icon_zm_aat_blast_furnace"] = "ui_icons_elementaldamage_fire",
    ["t7_icon_zm_aat_fire_works"] = "ui_icons_elementaldamage_pyro",
    ["t7_icon_zm_aat_thunder_wall"] = "ui_icons_elementaldamage_storm",
    ["t7_icon_zm_aat_turned"] = "ui_icons_elementaldamage_toxic"
}

local weaponRarities = {
	upgrade = { r = 0.5, g = 0.2, b = 0.5 },
	aat = { r = 0.7, g = 0.3, b = 0 },
	wonder = { r = 0.7, g = 0.5, b = 0 }
}

local wonderWeapons = {
	["elemental_bow_zm"] = true,
	["elemental_bow_demongate_zm"] = true,
	["elemental_bow_rune_prison_zm"] = true,
	["elemental_bow_storm_zm"] = true,
	["elemental_bow_wolf_howl_zm"] = true,
	["hero_mirg2000_zm"] = true,
	["hero_mirg2000_upgraded_zm"] = true,
	["idgun_0_zm"] = true,
	["idgun_1_zm"] = true,
	["idgun_2_zm"] = true,
	["idgun_3_zm"] = true,
	["idgun_genesis_0_zm"] = true,
	["idgun_genesis_0_upgraded_zm"] = true,
	["microwavegundw_zm"] = true,
	["microwavegundw_upgraded_zm"] = true,
	["ray_gun_zm"] = true,
	["ray_gun_upgraded_zm"] = true,
	["raygun_mark2_zm"] = true,
	["raygun_mark2_upgraded_zm"] = true,
	["raygun_mark3_zm"] = true,
	["raygun_mark3_upgraded_zm"] = true,
	["shrink_ray_zm"] = true,
	["shrink_ray_upgraded_zm"] = true,
	["staff_air_zm"] = true,
	["staff_air_upgraded_zm"] = true,
	["staff_fire_zm"] = true,
	["staff_fire_upgraded_zm"] = true,
	["staff_lightning_zm"] = true,
	["staff_lightning_upgraded_zm"] = true,
	["staff_water_zm"] = true,
	["staff_water_upgraded_zm"] = true,
	["tesla_gun_zm"] = true,
	["tesla_gun_upgraded_zm"] = true,
	["thundergun_zm"] = true,
	["thundergun_upgraded_zm"] = true
}

local gumColors = {
	blue = { r = 48/255, g = 148/255, b = 210/255 },
	green = { r = 76/255, g = 230/255, b = 80/255 },
	orange = { r = 228/255, g = 142/255, b = 55/255 },
	purple = { r = 150/255, g = 70/255, b = 189/255 }
}

local strGumColor = {
	[190] = "orange", -- zm_bgb_tone_death
	[191] = "orange", -- zm_bgb_soda_fountain
	[192] = "purple", -- zm_bgb_reign_drops
	[193] = "blue", -- zm_bgb_power_vacuum
	[194] = "purple", -- zm_bgb_idle_eyes
	[195] = "orange", -- zm_bgb_flavor_hexed
	[196] = "purple", -- zm_bgb_eye_candy
	[197] = "purple", -- zm_bgb_extra_credit
	[201] = "purple", -- zm_bgb_alchemical_antithesis
	[202] = "blue", -- zm_bgb_always_done_swiftly
	[203] = "purple", -- zm_bgb_anywhere_but_here
	[204] = "blue", -- zm_bgb_armamental_accomplishment
	[205] = "orange", -- zm_bgb_arms_grace
	[206] = "green", -- zm_bgb_arsenal_accelerator
	[207] = "green", -- zm_bgb_coagulant
	[208] = "blue", -- zm_bgb_danger_closest
	[209] = "blue", -- zm_bgb_firing_on_all_cylinders
	[210] = "orange", -- zm_bgb_impatient
	[211] = "purple", -- zm_bgb_in_plain_sight
	[212] = "blue", -- zm_bgb_lucky_crit
	[213] = "purple", -- zm_bgb_now_you_see_me
	[214] = "green", -- zm_bgb_stock_option
	[215] = "green", -- zm_bgb_sword_flay
	[216] = "blue", -- zm_bgb_aftertaste
	[217] = "orange", -- zm_bgb_burned_out
	[218] = "purple", -- zm_bgb_cache_back
	[219] = "purple", -- zm_bgb_dead_of_nuclear_winter
	[220] = "purple", -- zm_bgb_ephemeral_enhancement
	[221] = "purple", -- zm_bgb_im_feelin_lucky
	[222] = "purple", -- zm_bgb_immolation_liquidation
	[223] = "purple", -- zm_bgb_kill_joy
	[224] = "purple", -- zm_bgb_killing_time
	[225] = "purple", -- zm_bgb_licensed_contractor
	[226] = "purple", -- zm_bgb_on_the_house
	[227] = "orange", -- zm_bgb_perkaholic
	[228] = "purple", -- zm_bgb_phoenix_up
	[229] = "orange", -- zm_bgb_pop_shocks
	[230] = "purple", -- zm_bgb_respin_cycle
	[231] = "orange", -- zm_bgb_unquenchable
	[232] = "orange", -- zm_bgb_wall_power
	[233] = "purple", -- zm_bgb_whos_keeping_score
	[234] = "purple", -- zm_bgb_crawl_space
	[235] = "purple", -- zm_bgb_fatal_contraption
	[236] = "blue", -- zm_bgb_head_drama
	[237] = "green", -- zm_bgb_undead_man_walking
	[238] = "purple", -- zm_bgb_fear_in_headlights
	[239] = "green", -- zm_bgb_secret_shopper
	[240] = "blue", -- zm_bgb_temporal_gift
	[241] = "orange", -- zm_bgb_unbearable
	[242] = "orange", -- zm_bgb_crate_power
	[243] = "green", -- zm_bgb_disorderly_combat
	[244] = "blue", -- zm_bgb_projectile_vomiting
	[245] = "green", -- zm_bgb_shopping_free
	[246] = "orange", -- zm_bgb_slaughter_slide
	[247] = "purple", -- zm_bgb_bullet_boost
	[248] = "purple", -- zm_bgb_mind_blown
	[249] = "blue", -- zm_bgb_near_death_experience
	[250] = "green", -- zm_bgb_newtonian_negation
	[251] = "green", -- zm_bgb_profit_sharing
	[252] = "purple", -- zm_bgb_round_robbin
	[253] = "orange", -- zm_bgb_self_medication
	[254] = "blue", -- zm_bgb_board_games
	[255] = "green" -- zm_bgb_board_to_death
}

local SetWeaponName = function( controller, element )
	local weaponNameModel = Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weaponName" )
	local weaponName = Engine.GetModelValue( weaponNameModel )

	if weaponName ~= nil then
		element:setText( Engine.Localize( weaponName ) )
	end
end

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        local elements = { self.AmmoBG1, self.T10GumMeterBG01, self.AmmoEquipment.Background1 }
        for _, element in ipairs( elements ) do
            if element then
                --element:completeAnimation()
                --element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
                CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
            end
        end
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )

    if self.AmmoInfo and self.AmmoInfo.AmmoClip then
        LUI.OverrideFunction_CallOriginalFirst( self.AmmoInfo.AmmoClip, "setText", function( element )
            local currentText = element:getText()
            if not currentText then return end
            
            local textStr = tostring( currentText )
            local length = #textStr
            
            local ammoInDWClipModel = Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.ammoInDWClip" )
            
            if ammoInDWClipModel then
                local ammoInDWClip = Engine.GetModelValue( ammoInDWClipModel )
                local offset = (ammoInDWClip ~= -1) and 5 or 3
                length = math.max(0, length - offset)

                local shift = (length * 22)

                if self.PAPImage and self.AATImage then
                    self.PAPImage:setLeftRight( false, true, -251.5 - shift, -235 - shift )
                    self.AATImage:setLeftRight( false, true, -271.5 - shift, -255 - shift )
                end
            end
        end )
    end
end

CoD.T10AmmoContainer = InheritFrom( LUI.UIElement )
CoD.T10AmmoContainer.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.T10AmmoContainer )
	self.id = "T10AmmoContainer"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.AmmoBG1 = LUI.UIImage.new()
	self.AmmoBG1:setLeftRight( false, true, -318, -151 )
	self.AmmoBG1:setTopBottom( false, true, -63, -25.5 )
	self.AmmoBG1:setImage( RegisterImage( "ximage_69c2bf3c1b482b9" ) )
	self.AmmoBG1:setRGB( 0.3, 0.3, 0.3 )
	--[[self.AmmoBG1:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.viewmodelWeaponName" ), function( model )
		local name = Engine.GetModelValue( model )
		local aat = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.aatIcon" ) )
		local r, g, b = 0.3, 0.3, 0.3
		local colorData = nil

		if name then
			if wonderWeapons[ name ] then
				colorData = weaponRarities.wonder
			elseif string.find( name, "_upgraded" ) or string.find( name, "_up$" ) then
				if aat and aat ~= "blacktransparent" then
					colorData = weaponRarities.aat
				else
					colorData = weaponRarities.upgrade
				end
			end
		end

		if colorData then
			r, g, b = colorData.r, colorData.g, colorData.b
		end

		self.AmmoBG1:setRGB( r, g, b )
	end )--]]
	self:addElement( self.AmmoBG1 )

	self.AmmoBG2 = LUI.UIImage.new()
	self.AmmoBG2:setLeftRight( false, true, -318, -151 )
	self.AmmoBG2:setTopBottom( false, true, -63, -25.5 )
	self.AmmoBG2:setImage( RegisterImage( "ximage_df73a47b7b0ecca" ) )
	self.AmmoBG2:setAlpha( 0.7 )
	self:addElement( self.AmmoBG2 )

	self.StockBG = LUI.UIImage.new()
	self.StockBG:setLeftRight( false, true, -318, -151 )
	self.StockBG:setTopBottom( false, true, -63, -25.5 )
	self.StockBG:setImage( RegisterImage( "ximage_9b1b03086b597f" ) )
	self.StockBG:setAlpha( 0.3 )
	self:addElement( self.StockBG )

	self.AmmoEquipment = CoD.T10AmmoEquipment.new( menu, controller )
	self.AmmoEquipment:setLeftRight( true, true, 0, 0 )
	self.AmmoEquipment:setTopBottom( true, true, 0, 0 )
	self:addElement( self.AmmoEquipment )

	self.AmmoInfo = CoD.T10AmmoInfo.new( menu, controller )
	self.AmmoInfo:setLeftRight( true, true, 0, 0 )
	self.AmmoInfo:setTopBottom( true, true, 0, 0 )
	self:addElement( self.AmmoInfo )

	self.WeaponName = LUI.UIText.new()
	self.WeaponName:setLeftRight( true, true, 0, 213 )
	self.WeaponName:setTopBottom( false, true, -58 - 29, -25 - 29 )
	self.WeaponName:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	self.WeaponName:setTTF( "fonts/kairos_sans_w1g_cn.ttf" )
	self.WeaponName:setScale( 0.5 )
	self.WeaponName:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weaponName" ), function( model )
		SetWeaponName( controller, self.WeaponName )
	end )
	self:addElement( self.WeaponName )

	self.PAPImage = LUI.UIImage.new()
    self.PAPImage:setLeftRight( false, true, -251.5, -235 )
    self.PAPImage:setTopBottom( false, true, -56, -40 )
	self.PAPImage:setImage( RegisterImage( "blacktransparent" ) )
	self.PAPImage:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "t10_pack_a_punch_tier" ), function( model )
		local tier = Engine.GetModelValue( model )
		
		if tier then
			if tier > 0 then
				self.PAPImage:setImage( RegisterImage( "jup_ui_icons_pap_level" .. tostring( tier ) ) )
			else
				self.PAPImage:setImage( RegisterImage( "blacktransparent" ) )
			end
		end
	end )
	self:addElement( self.PAPImage )

	self.AATImage = LUI.UIImage.new()
    self.AATImage:setLeftRight( false, true, -271.5, -255 )
    self.AATImage:setTopBottom( false, true, -56, -40 )
	self.AATImage:setImage( RegisterImage( "blacktransparent" ) )
	self.AATImage:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.aatIcon" ), function( model )
		local aatIcon = Engine.GetModelValue( model )

		if aatIcon then
			if aatIcons[ aatIcon ] then
				aatIcon = aatIcons[ aatIcon ]
			else
				aatIcon = "blacktransparent"
			end

			self.AATImage:setImage( RegisterImage( aatIcon ) )
		end
	end )
	self:addElement( self.AATImage )

	self.T10GumMeterBG00 = LUI.UIImage.new()
	self.T10GumMeterBG00:setLeftRight( false, true, -55 - 10, -6 - 10 )
    self.T10GumMeterBG00:setTopBottom( true, false, 566 + 10, 619 - 10 )
	--self.T10GumMeterBG:setRGB( 0.3, 0.3, 0.3 )
	self.T10GumMeterBG00:setAlpha( 0.8 )
	self.T10GumMeterBG00:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "bgb_current" ), function( model )
	    local modelValue = Engine.GetModelValue( model )
	    if modelValue then
	        if modelValue > 0 then
	            self.T10GumMeterBG00:setImage( RegisterImage( "ximage_69c2bf3c1b482b9" ) )
	        else
	            self.T10GumMeterBG00:setImage( RegisterImage( "$blacktransparent" ) )
	        end
	    end
	end )
	self:addElement( self.T10GumMeterBG00 )

	self.T10GumMeterBG01 = LUI.UIImage.new()
	self.T10GumMeterBG01:setLeftRight( false, true, -55 - 10, -6 - 10 )
    self.T10GumMeterBG01:setTopBottom( true, false, 566 + 10, 619 - 10 )
	self.T10GumMeterBG01:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "bgb_current" ), function( model )
	    local modelValue = Engine.GetModelValue( model )
	    if modelValue then
	        if modelValue > 0 then
	            self.T10GumMeterBG01:setImage( RegisterImage( "ximage_df73a47b7b0ecca" ) )
	            CoD.UIColors.SetElementColor( self.T10GumMeterBG01, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	            --[[local colorName = strGumColor[modelValue]
	            local color = gumColors[colorName] or { r = 1, g = 1, b = 1 }
	            self.T10GumMeterBG01:setRGB( color.r, color.g, color.b )
	            self.T10GumMeterBG01:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_delta" ) )
				self.T10GumMeterBG01:setShaderVector( 0, 0, 1, 0, 0 )
				self.T10GumMeterBG01:setShaderVector( 1, 0, 0.3, 0, 0 )
				self.T10GumMeterBG01:setShaderVector( 2, 0, 1, 0, 0 )
				self.T10GumMeterBG01:setShaderVector( 3, 0, 0.8, 0, 0 )--]]
	        else
	            self.T10GumMeterBG01:setImage( RegisterImage( "$blacktransparent" ) )
	        end
	    end
	end )
	self:addElement( self.T10GumMeterBG01 )

	self.T10GumMeter = CoD.ZmAmmo_BBGumMeterWidget.new( menu, controller )
    self.T10GumMeter:setLeftRight( false, true, -106 + 25 - 10, -56 + 25 - 10 )
    self.T10GumMeter:setTopBottom( true, false, 486 + 80, 539 + 80 )
    --self.T10GumMeter:setScale( 1.4 )
    self:addElement( self.T10GumMeter )

    self.T10GumsRemaining = LUI.UIText.new()
	self.T10GumsRemaining:setLeftRight( false, true, -106 + 21.5 + 60 - 10, -96 + 21.5 + 60 - 10 )
	self.T10GumsRemaining:setTopBottom( true, false, 504.5 + 42.5 + 37.5, 520.5 + 42.5 + 37.5 )
	self.T10GumsRemaining:setTTF( "fonts/kairos_sans_w1g_cn_bold.ttf" )
	self.T10GumsRemaining:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.T10GumsRemaining:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "bgb_activations_remaining" ), function( model )
	    local modelValue = Engine.GetModelValue( model )
	    if modelValue then
	        if modelValue > 0 and modelValue < 6 then
	            self.T10GumsRemaining:setText( modelValue )
	        else
	            self.T10GumsRemaining:setText( "" )
	        end
	    end
	end )
	self:addElement( self.T10GumsRemaining )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 12 )

				self.AmmoBG1:completeAnimation()
				self.AmmoBG1:setAlpha( 0 )
				self.clipFinished( self.AmmoBG1, {} )

				self.AmmoBG2:completeAnimation()
				self.AmmoBG2:setAlpha( 0 )
				self.clipFinished( self.AmmoBG2, {} )

				self.StockBG:completeAnimation()
				self.StockBG:setAlpha( 0 )
				self.clipFinished( self.StockBG, {} )

				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 0 )
				self.clipFinished( self.AmmoEquipment, {} )

				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 0 )
				self.clipFinished( self.AmmoInfo, {} )

				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 0 )
				self.clipFinished( self.WeaponName, {} )

				self.PAPImage:completeAnimation()
				self.PAPImage:setAlpha( 0 )
				self.clipFinished( self.PAPImage, {} )

				self.AATImage:completeAnimation()
				self.AATImage:setAlpha( 0 )
				self.clipFinished( self.AATImage, {} )

				self.T10GumMeterBG00:completeAnimation()
				self.T10GumMeterBG00:setAlpha( 0 )
				self.clipFinished( self.T10GumMeterBG00, {} )

				self.T10GumMeterBG01:completeAnimation()
				self.T10GumMeterBG01:setAlpha( 0 )
				self.clipFinished( self.T10GumMeterBG01, {} )

				self.T10GumMeter:completeAnimation()
				self.T10GumMeter:setAlpha( 0 )
				self.clipFinished( self.T10GumMeter, {} )

				self.T10GumsRemaining:completeAnimation()
				self.T10GumsRemaining:setAlpha( 0 )
				self.clipFinished( self.T10GumsRemaining, {} )
			end,

			HudStart = function()
				self:setupElementClipCounter( 12 )

				local HudStartTransition = function( element, alpha, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
	
					element:setAlpha( alpha )
	
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				self.AmmoBG1:completeAnimation()
				self.AmmoBG1:setAlpha( 0 )
				HudStartTransition( self.AmmoBG1, 1, {} )

				self.AmmoBG2:completeAnimation()
				self.AmmoBG2:setAlpha( 0 )
				HudStartTransition( self.AmmoBG2, 0.7, {} )

				self.StockBG:completeAnimation()
				self.StockBG:setAlpha( 0 )
				HudStartTransition( self.StockBG, 0.3, {} )

				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 0 )
				HudStartTransition( self.AmmoEquipment, 1, {} )

				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 0 )
				HudStartTransition( self.AmmoInfo, 1, {} )

				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 0 )
				HudStartTransition( self.WeaponName, 1, {} )

				self.PAPImage:completeAnimation()
				self.PAPImage:setAlpha( 0 )
				HudStartTransition( self.PAPImage, 1, {} )

				self.AATImage:completeAnimation()
				self.AATImage:setAlpha( 0 )
				HudStartTransition( self.AATImage, 1, {} )

				self.T10GumMeterBG00:completeAnimation()
				self.T10GumMeterBG00:setAlpha( 0 )
				HudStartTransition( self.T10GumMeterBG00, 1, {} )

				self.T10GumMeterBG01:completeAnimation()
				self.T10GumMeterBG01:setAlpha( 0 )
				HudStartTransition( self.T10GumMeterBG01, 1, {} )

				self.T10GumMeter:completeAnimation()
				self.T10GumMeter:setAlpha( 0 )
				HudStartTransition( self.T10GumMeter, 1, {} )

				self.T10GumsRemaining:completeAnimation()
				self.T10GumsRemaining:setAlpha( 0 )
				HudStartTransition( self.T10GumsRemaining, 1, {} )
			end
		},

		HudStart = {
			DefaultClip = function()
				self:setupElementClipCounter( 12 )

				self.AmmoBG1:completeAnimation()
				self.AmmoBG1:setAlpha( 1 )
				self.clipFinished( self.AmmoBG1, {} )

				self.AmmoBG2:completeAnimation()
				self.AmmoBG2:setAlpha( 0.7 )
				self.clipFinished( self.AmmoBG2, {} )

				self.StockBG:completeAnimation()
				self.StockBG:setAlpha( 0.3 )
				self.clipFinished( self.StockBG, {} )

				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 1 )
				self.clipFinished( self.AmmoEquipment, {} )

				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 1 )
				self.clipFinished( self.AmmoInfo, {} )

				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 1 )
				self.clipFinished( self.WeaponName, {} )

				self.PAPImage:completeAnimation()
				self.PAPImage:setAlpha( 1 )
				self.clipFinished( self.PAPImage, {} )

				self.AATImage:completeAnimation()
				self.AATImage:setAlpha( 1 )
				self.clipFinished( self.AATImage, {} )

				self.T10GumMeterBG00:completeAnimation()
				self.T10GumMeterBG00:setAlpha( 1 )
				self.clipFinished( self.T10GumMeterBG00, {} )

				self.T10GumMeterBG01:completeAnimation()
				self.T10GumMeterBG01:setAlpha( 1 )
				self.clipFinished( self.T10GumMeterBG01, {} )

				self.T10GumMeter:completeAnimation()
				self.T10GumMeter:setAlpha( 1 )
				self.clipFinished( self.T10GumMeter, {} )

				self.T10GumsRemaining:completeAnimation()
				self.T10GumsRemaining:setAlpha( 1 )
				self.clipFinished( self.T10GumsRemaining, {} )
			end,

			DefaultState = function()
				self:setupElementClipCounter( 12 )
				
				local DefaultStateTransition = function( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
	
					element:setAlpha( 0 )
	
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				self.AmmoBG1:completeAnimation()
				self.AmmoBG1:setAlpha( 1 )
				DefaultStateTransition( self.AmmoBG1, {} )

				self.AmmoBG2:completeAnimation()
				self.AmmoBG2:setAlpha( 0.7 )
				DefaultStateTransition( self.AmmoBG2, {} )

				self.StockBG:completeAnimation()
				self.StockBG:setAlpha( 0.3 )
				DefaultStateTransition( self.StockBG, {} )

				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 1 )
				DefaultStateTransition( self.AmmoEquipment, {} )

				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 1 )
				DefaultStateTransition( self.AmmoInfo, {} )

				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 1 )
				DefaultStateTransition( self.WeaponName, {} )

				self.PAPImage:completeAnimation()
				self.PAPImage:setAlpha( 1 )
				DefaultStateTransition( self.PAPImage, {} )

				self.AATImage:completeAnimation()
				self.AATImage:setAlpha( 1 )
				DefaultStateTransition( self.AATImage, {} )

				self.T10GumMeterBG00:completeAnimation()
				self.T10GumMeterBG00:setAlpha( 1 )
				DefaultStateTransition( self.T10GumMeterBG00, {} )

				self.T10GumMeterBG01:completeAnimation()
				self.T10GumMeterBG01:setAlpha( 1 )
				DefaultStateTransition( self.T10GumMeterBG01, {} )

				self.T10GumMeter:completeAnimation()
				self.T10GumMeter:setAlpha( 1 )
				DefaultStateTransition( self.T10GumMeter, {} )

				self.T10GumsRemaining:completeAnimation()
				self.T10GumsRemaining:setAlpha( 1 )
				DefaultStateTransition( self.T10GumsRemaining, {} )
			end
		},

		Inactive = {
			DefaultClip = function()
				self:setupElementClipCounter( 12 )

				self.AmmoBG1:completeAnimation()
				self.AmmoBG1:setAlpha( 1 )
				self.clipFinished( self.AmmoBG1, {} )

				self.AmmoBG2:completeAnimation()
				self.AmmoBG2:setAlpha( 0.7 )
				self.clipFinished( self.AmmoBG2, {} )

				self.StockBG:completeAnimation()
				self.StockBG:setAlpha( 0.3 )
				self.clipFinished( self.StockBG, {} )

				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 1 )
				self.clipFinished( self.AmmoEquipment, {} )

				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 1 )
				self.clipFinished( self.AmmoInfo, {} )

				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 1 )
				self.clipFinished( self.WeaponName, {} )

				self.PAPImage:completeAnimation()
				self.PAPImage:setAlpha( 1 )
				self.clipFinished( self.PAPImage, {} )

				self.AATImage:completeAnimation()
				self.AATImage:setAlpha( 1 )
				self.clipFinished( self.AATImage, {} )

				self.T10GumMeterBG00:completeAnimation()
				self.T10GumMeterBG00:setAlpha( 0 )
				self.clipFinished( self.T10GumMeterBG00, {} )

				self.T10GumMeterBG01:completeAnimation()
				self.T10GumMeterBG01:setAlpha( 0 )
				self.clipFinished( self.T10GumMeterBG01, {} )

				self.T10GumMeter:completeAnimation()
				self.T10GumMeter:setAlpha( 0 )
				self.clipFinished( self.T10GumMeter, {} )

				self.T10GumsRemaining:completeAnimation()
				self.T10GumsRemaining:setAlpha( 0 )
				self.clipFinished( self.T10GumsRemaining, {} )
			end,

			DefaultState = function()
				self:setupElementClipCounter( 12 )
				
				local DefaultStateTransition = function( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
	
					element:setAlpha( 0 )
	
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				self.AmmoBG1:completeAnimation()
				self.AmmoBG1:setAlpha( 1 )
				DefaultStateTransition( self.AmmoBG1, {} )

				self.AmmoBG2:completeAnimation()
				self.AmmoBG2:setAlpha( 0.7 )
				DefaultStateTransition( self.AmmoBG2, {} )

				self.StockBG:completeAnimation()
				self.StockBG:setAlpha( 0.3 )
				DefaultStateTransition( self.StockBG, {} )

				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 1 )
				DefaultStateTransition( self.AmmoEquipment, {} )

				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 1 )
				DefaultStateTransition( self.AmmoInfo, {} )

				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 1 )
				DefaultStateTransition( self.WeaponName, {} )

				self.PAPImage:completeAnimation()
				self.PAPImage:setAlpha( 1 )
				DefaultStateTransition( self.PAPImage, {} )

				self.AATImage:completeAnimation()
				self.AATImage:setAlpha( 1 )
				DefaultStateTransition( self.AATImage, {} )

				self.T10GumMeterBG00:completeAnimation()
				self.T10GumMeterBG00:setAlpha( 0 )
				DefaultStateTransition( self.T10GumMeterBG00, {} )

				self.T10GumMeterBG01:completeAnimation()
				self.T10GumMeterBG01:setAlpha( 0 )
				DefaultStateTransition( self.T10GumMeterBG01, {} )

				self.T10GumMeter:completeAnimation()
				self.T10GumMeter:setAlpha( 0 )
				DefaultStateTransition( self.T10GumMeter, {} )

				self.T10GumsRemaining:completeAnimation()
				self.T10GumsRemaining:setAlpha( 0 )
				DefaultStateTransition( self.T10GumsRemaining, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Inactive",
			condition = function( menu, element, event )
				if IsModelValueTrue( controller, "hudItems.playerSpawned" ) then
					if Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
					and Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE )
					and not IsModelValueEqualTo( controller, "bgb_display", 1 )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_KILLCAM )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE ) then
						return true
					else
						return false
					end
				end
			end
		},
		{
			stateName = "HudStart",
			condition = function( menu, element, event )
				if IsModelValueTrue( controller, "hudItems.playerSpawned" ) then
					if Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
					and Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_KILLCAM )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE ) then
						return true
					else
						return false
					end
				end
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.playerSpawned" ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.playerSpawned" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE } )
	end )

	--[[self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "bgb_timer" ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "bgb_timer" } )
	end )--]]

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "bgb_display" ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "bgb_display" } )
	end )

	--[[self:subscribeToGlobalModel( controller, "PerController", "deadSpectator.playerIndex", function( model )
		if IsModelValueEqualTo( controller, "deadSpectator.playerIndex", -1 ) then
			SetElementStateWithNoTransitionClip( self, self, controller, "DefaultState" )
			PlayClip( self, "DefaultClip", controller )
		end
	end )

	self:subscribeToGlobalModel( controller, "PerController", "bgb_one_shot_use", function( model )
		if IsModelValueGreaterThan( controller, "bgb_timer", 0 ) then
			SetElementState( self, self, controller, "DefaultState" )
			SetElementState( self, self, controller, "DefaultState" )
		elseif IsModelValueEqualTo( controller, "bgb_display", 1 ) then
			SetElementState( self, self, controller, "DefaultState" )
			SetElementState( self, self, controller, "DefaultState" )
		end
	end )--]]

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.AmmoBG1:close()
		element.AmmoBG2:close()
		element.StockBG:close()
		element.AmmoEquipment:close()
		element.AmmoInfo:close()
		element.WeaponName:close()
		element.PAPImage:close()
		element.AATImage:close()
		element.T10GumMeterBG00:close()
		element.T10GumMeterBG01:close()
		element.T10GumMeter:close()
		element.T10GumsRemaining:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end