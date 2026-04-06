local swordReady = {
	["default"] = "uie_t7_zm_derriese_hud_ammo_icon_gun_ready",
	["zm_zod"] = "uie_t7_zm_hud_ammo_dpadicnswrd_new_ready",
	["zm_castle"] = "t7_hud_zm_hud_ammo_icon_spike_ready",
	["zm_island"] = "t7_hud_zm_hud_ammo_icon_skull_weapon_ready",
	["zm_stalingrad"] = "uie_t7_zm_dragon_gauntlet_ammo_icon_gun_ready",
	["zm_genesis"] = "t7_hud_zm_hud_ammo_icon_spike_ready"
}

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self, color )
    	CoD.UIColors.SetElementColor( self.SpecialBG, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    	CoD.UIColors.SetElementColor( self.SpecialImage, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    	CoD.UIColors.SetElementColor( self.SpecialMeter, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local controllerModel = Engine.GetModelForController( controller )
    local colorUpdateModel = Engine.CreateModel( controllerModel, "colorUpdate" )
    
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.T8AmmoEquipment = InheritFrom( LUI.UIElement )
CoD.T8AmmoEquipment.new = function ( menu, controller )
	local self = LUI.UIElement.new()
	local mapName = Engine.GetCurrentMap()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.T8AmmoEquipment )
	self.id = "T8AmmoEquipment"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	local lethalOffsetLR = 75
	local lethalOffsetTB = -57

	self.LethalImage = LUI.UIImage.new()
	self.LethalImage:setLeftRight( false, true, -306 + lethalOffsetLR, -252.5 + lethalOffsetLR )
	self.LethalImage:setTopBottom( false, true, -85.5 + lethalOffsetTB, -32 + lethalOffsetTB )
	self.LethalImage:setImage( RegisterImage( "blacktransparent" ) )
	self.LethalImage:setScale( 0.6 )
	self.LethalImage:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentPrimaryOffhand.primaryOffhand" ), function ( model )
		local primaryOffhand = Engine.GetModelValue( model )

		if primaryOffhand then
			if primaryOffhand == "uie_t7_zm_hud_inv_icnlthl" then
				self.LethalImage:setImage( RegisterImage( "t7_hud_icon_menu_frag" ) )

			elseif primaryOffhand == "uie_t7_zm_hud_inv_widowswine" then
				self.LethalImage:setImage( RegisterImage( "t7_hud_icon_menu_zmb_semtex" ) )

			else
				self.LethalImage:setImage( RegisterImage( primaryOffhand ) )
			end
		end
	end )
	self:addElement( self.LethalImage )

	self.LethalCountBG = LUI.UIImage.new()
	self.LethalCountBG:setLeftRight( false, true, -279.5 + lethalOffsetLR, -259 + lethalOffsetLR )
	self.LethalCountBG:setTopBottom( false, true, -50.5 + lethalOffsetTB, -38 + lethalOffsetTB )
	self.LethalCountBG:setImage( RegisterImage( "$white" ) )
	self.LethalCountBG:setRGB( 0, 0, 0 )
	self.LethalCountBG:setAlpha( 0.88 )
	self:addElement( self.LethalCountBG )

	self.LethalCountText = LUI.UIText.new()
	self.LethalCountText:setLeftRight( false, true, -279.5 + lethalOffsetLR, -259 + lethalOffsetLR )
	self.LethalCountText:setTopBottom( false, true, -50.5 + lethalOffsetTB, -38 + lethalOffsetTB )
	self.LethalCountText:setText( Engine.Localize( "0" ) )
	self.LethalCountText:setTTF( "fonts/0arame_mono_stencil.ttf" )
	self.LethalCountText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.LethalCountText:setScale( 0.66 )
	self.LethalCountText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentPrimaryOffhand.primaryOffhandCount" ), function ( model )
		local primaryOffhandCount = Engine.GetModelValue( model )

		if primaryOffhandCount then
			self.LethalCountText:setText( Engine.Localize( primaryOffhandCount ) )
		end
	end )
	self:addElement( self.LethalCountText )

	local taticalOffestLR = 175
	local taticalOffestTB = -57

	self.TacticalImage = LUI.UIImage.new()
	self.TacticalImage:setLeftRight( false, true, -359 + taticalOffestLR - 5, -305.5 + taticalOffestLR - 5 )
	self.TacticalImage:setTopBottom( false, true, -85.5 + taticalOffestTB + 3, -32 + taticalOffestTB + 3 )
	self.TacticalImage:setImage( RegisterImage( "blacktransparent" ) )
	self.TacticalImage:setScale( 0.5 )
	self.TacticalImage:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentSecondaryOffhand.secondaryOffhand" ), function ( model )
		local secondaryOffhand = Engine.GetModelValue( model )

		if secondaryOffhand then
			if secondaryOffhand == "hud_cymbal_monkey_bo3" then
				self.TacticalImage:setImage( RegisterImage( "ui_icon_inventory_cymbal_monkey" ) )
			else
				self.TacticalImage:setImage( RegisterImage( secondaryOffhand ) )
			end
		end
	end )
	self:addElement( self.TacticalImage )

	self.TacticalCountBG = LUI.UIImage.new()
	self.TacticalCountBG:setLeftRight( false, true, -332.5 + taticalOffestLR, -312 + taticalOffestLR )
	self.TacticalCountBG:setTopBottom( false, true, -50.5 + taticalOffestTB, -38 + taticalOffestTB )
	self.TacticalCountBG:setImage( RegisterImage( "$white" ) )
	self.TacticalCountBG:setRGB( 0, 0, 0 )
	self.TacticalCountBG:setAlpha( 0.88 )
	self:addElement( self.TacticalCountBG )

	self.TacticalCountText = LUI.UIText.new()
	self.TacticalCountText:setLeftRight( false, true, -332.5 + taticalOffestLR, -312 + taticalOffestLR )
	self.TacticalCountText:setTopBottom( false, true, -50.5 + taticalOffestTB, -38 + taticalOffestTB )
	self.TacticalCountText:setText( Engine.Localize( "0" ) )
	self.TacticalCountText:setTTF( "fonts/0arame_mono_stencil.ttf" )
	self.TacticalCountText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.TacticalCountText:setScale( 0.66 )
	self.TacticalCountText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentSecondaryOffhand.secondaryOffhandCount" ), function ( model )
		local secondaryOffhandCount = Engine.GetModelValue( model )

		if secondaryOffhandCount then
			self.TacticalCountText:setText( Engine.Localize( secondaryOffhandCount ) )
		end
	end )
	self:addElement( self.TacticalCountText )

	local specialOffsetLR = 115
	local specialOffsetTB = 0

	self.SpecialBG = LUI.UIImage.new()
	self.SpecialBG:setLeftRight( false, true, -412 + specialOffsetLR, -358.5 + specialOffsetLR )
	self.SpecialBG:setTopBottom( false, true, -85.5 + specialOffsetTB, -32 + specialOffsetTB )
	self.SpecialBG:setImage( RegisterImage( "t8_hud_hero_weapon_bg" ) )
	self:addElement( self.SpecialBG )

	self.SpecialImage = LUI.UIImage.new()
	self.SpecialImage:setLeftRight( false, true, -412 + specialOffsetLR - 5, -358.5 + specialOffsetLR + 5 )
	self.SpecialImage:setTopBottom( false, true, -85.5 + specialOffsetTB - 1.5, -32 + specialOffsetTB - 1.5 )
	self.SpecialImage:setImage( RegisterImage( swordReady[mapName] or swordReady["default"] ) )
	self.SpecialImage:setAlpha( 0.77 )
	self.SpecialImage:setScale( 1.18 )
	self:addElement( self.SpecialImage )

	self.SpecialMeterBG = LUI.UIImage.new()
	self.SpecialMeterBG:setLeftRight( false, true, -416 + specialOffsetLR, -354.5 + specialOffsetLR )
	self.SpecialMeterBG:setTopBottom( false, true, -94.5 + specialOffsetTB, -68 + specialOffsetTB )
	self.SpecialMeterBG:setImage( RegisterImage( "t8_hud_hero_weapon_progress_bg" ) )
	self:addElement( self.SpecialMeterBG )

	self.SpecialMeter = LUI.UIImage.new()
	self.SpecialMeter:setLeftRight( false, true, -416 + specialOffsetLR, -354.5 + specialOffsetLR )
	self.SpecialMeter:setTopBottom( false, true, -92.5 - 1 + specialOffsetTB, -29 - 1 + specialOffsetTB )
	self.SpecialMeter:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bbgummeterring" ) )
	self.SpecialMeter:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_clock_normal" ) )
	self.SpecialMeter:setZRot( 90 )
	self.SpecialMeter:setShaderVector( 0, 0.5, 0, 0, 0 )
	self.SpecialMeter:setShaderVector( 1, 0.75, 0, 0, 0 )
	self.SpecialMeter:setShaderVector( 2, 0.5, 0, 0, 0 )
	self.SpecialMeter:setShaderVector( 3, 0.075, 0, 0, 0 )
	self.SpecialMeter:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordEnergy" ), function ( model )
		local swordEnergy = Engine.GetModelValue( model )

		if swordEnergy then
			self.SpecialMeter:setShaderVector( 0, AdjustStartEnd( 0, 0.5,
				CoD.GetVectorComponentFromString( swordEnergy, 1 ),
				CoD.GetVectorComponentFromString( swordEnergy, 2 ),
				CoD.GetVectorComponentFromString( swordEnergy, 3 ),
				CoD.GetVectorComponentFromString( swordEnergy, 4 ) ) )
		end
	end )
	self:addElement( self.SpecialMeter )

	self.SpecialCountBG = LUI.UIImage.new()
	self.SpecialCountBG:setLeftRight( false, true, -385.5 + specialOffsetLR, -365 + specialOffsetLR )
	self.SpecialCountBG:setTopBottom( false, true, -50.5 + specialOffsetTB, -38 + specialOffsetTB )
	self.SpecialCountBG:setImage( RegisterImage( "$white" ) )
	self.SpecialCountBG:setRGB( 0, 0, 0 )
	self.SpecialCountBG:setAlpha( 0.88 )
	self:addElement( self.SpecialCountBG )

	self.SpecialCountText = LUI.UIText.new()
	self.SpecialCountText:setLeftRight( false, true, -385.5 + specialOffsetLR, -365 + specialOffsetLR )
	self.SpecialCountText:setTopBottom( false, true, -50.5 + specialOffsetTB, -38 + specialOffsetTB )
	self.SpecialCountText:setText( Engine.Localize( "0" ) )
	self.SpecialCountText:setTTF( "fonts/0arame_mono_stencil.ttf" )
	self.SpecialCountText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.SpecialCountText:setScale( 0.66 )
	self.SpecialCountText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordEnergy" ), function ( model )
		local swordEnergy = Engine.GetModelValue( model )

		if swordEnergy then
			if swordEnergy < 1 then
				self.SpecialCountText:setText( Engine.Localize( "0" ) )
			else
				self.SpecialCountText:setText( Engine.Localize( "1" ) )
			end
		end
	end )
	self:addElement( self.SpecialCountText )

	self.MineImage = LUI.UIImage.new()
	self.MineImage:setLeftRight( false, true, -239.5 + 110, -213.5 + 110 )
	self.MineImage:setTopBottom( false, true, -122, -96 )
	self.MineImage:setImage( RegisterImage( "blacktransparent" ) )
	self.MineImage:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( model )
		local actionSlot3ammo = Engine.GetModelValue( model )

		if actionSlot3ammo then
			if actionSlot3ammo > 0 then
				self.MineImage:setImage( RegisterImage( "t7_hud_icon_menu_bouncebetty" ) )
			else
				self.MineImage:setImage( RegisterImage( "blacktransparent" ) )
			end
		end
	end )
	self:addElement( self.MineImage )

	self.MineCountBG = LUI.UIImage.new()
	self.MineCountBG:setLeftRight( false, true, -225 + 5 + 110, -208 + 5 + 110 )
	self.MineCountBG:setTopBottom( false, true, -109, -95 )
	self.MineCountBG:setImage( RegisterImage( "$white" ) )
	self.MineCountBG:setRGB( 0, 0, 0 )
	self.MineCountBG:setAlpha( 0.88 )
	self:addElement( self.MineCountBG )

	self.MineCountText = LUI.UIText.new()
	self.MineCountText:setLeftRight( false, true, -239.5 + 10 + 5 + 110, -213.5 + 10 + 5 + 110 )
	self.MineCountText:setTopBottom( false, true, -114 + 6.5, -101.5 + 6.5 )
	self.MineCountText:setText( Engine.Localize( "" ) )
	self.MineCountText:setTTF( "fonts/0arame_mono_stencil.ttf" )
	self.MineCountText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.MineCountText:setScale( 0.66 )
	self.MineCountText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function ( model )
		local actionSlot3ammo = Engine.GetModelValue( model )

		if actionSlot3ammo then
			if actionSlot3ammo > 0 then
				self.MineCountText:setText( Engine.Localize( actionSlot3ammo ) )
			else
				self.MineCountText:setText( Engine.Localize( "" ) )
			end
		end
	end )
	self:addElement( self.MineCountText )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.LethalImage:close()
		element.LethalCountBG:close()
		element.LethalCountText:close()
		element.TacticalImage:close()
		element.TacticalCountBG:close()
		element.TacticalCountText:close()
		element.SpecialBG:close()
		element.SpecialImage:close()
		element.SpecialMeterBG:close()
		element.SpecialMeter:close()
		element.SpecialCountBG:close()
		element.SpecialCountText:close()
		element.MineImage:close()
		element.MineCountBG:close()
		element.MineCountText:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end
