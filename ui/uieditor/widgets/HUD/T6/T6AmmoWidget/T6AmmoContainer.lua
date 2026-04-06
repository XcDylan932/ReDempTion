require( "ui.uieditor.widgets.HUD.T6.T6AmmoWidget.T6AmmoEquipment" )
require( "ui.uieditor.widgets.HUD.T6.T6AmmoWidget.T6AmmoInfo" )
require( "ui.uieditor.widgets.HUD.ZM_AmmoWidget.ZmAmmo_BBGumMeterWidget" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadIconBottomFactory" )

local AATIconData = {
    t7_icon_zm_aat_blast_furnace = { name = "Blast Furnace", color = "orange" },
    t7_icon_zm_aat_dead_wire = { name = "Dead Wire", color = "blue" },
    t7_icon_zm_aat_fire_works = { name = "Fireworks", color = "purple" },
    t7_icon_zm_aat_thunder_wall = { name = "Thunderwall", color = "white" },
    t7_icon_zm_aat_turned = { name = "Turned", color = "green" }
}

local SetWeaponName = function ( controller, element )
	local weaponName = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weaponName" ) )
	if weaponName ~= nil then
		element:setText( Engine.Localize( weaponName ) )
	end
end

local SetAATName = function( controller, element )
    local aatIconModel = Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.aatIcon" )
    
    if aatIconModel then
        local aatIcon = Engine.GetModelValue( aatIconModel )
        local aatData = AATIconData[ aatIcon ]
        
        if aatData then
            CoD.UIColors.SetElementColor( element, aatData.color )
            element:setText( aatData.name )
        elseif aatIcon and aatIcon ~= "blacktransparent" then
            CoD.UIColors.SetElementColor( element, "white" )
            element:setText( aatIcon )
        else
            element:setText("")
        end
    end
end

local SetAATImage = function( controller, element )
	local weaponName = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weaponName" ) )
	local aatIcon = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.aatIcon" ) )
	if weaponName ~= nil and aatIcon ~= nil then
		element:setImage( RegisterImage( aatIcon ) )
	else
		element:setImage( RegisterImage( "blacktransparent" ) )
	end
end

CoD.T6AmmoContainer = InheritFrom( LUI.UIElement )
CoD.T6AmmoContainer.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.T6AmmoContainer )
	self.id = "T6AmmoContainer"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.AmmoBG = LUI.UIImage.new()
	self.AmmoBG:setLeftRight( false, true, -300, 0 )
    self.AmmoBG:setTopBottom( false, true, -140, 10 )
	self.AmmoBG:setImage( RegisterImage( "hud_dpad_blood" ) )
	self.AmmoBG:setRGB( 0.21, 0, 0 )
	self:addElement( self.AmmoBG )

	self.DpadBG = LUI.UIImage.new()
	self.DpadBG:setLeftRight( true, false, 1204 - 52, 1228 + 52 )
    self.DpadBG:setTopBottom( true, false, 644 - 52, 668 + 52 )
	self.DpadBG:setImage( RegisterImage( "lui_dpad_circle" ) )
	self:addElement( self.DpadBG )

	self.DpadUp = LUI.UIImage.new()
	self.DpadUp:setLeftRight( true, false, 1212, 1220 )
	self.DpadUp:setTopBottom( true, false, 644, 652 )
	self.DpadUp:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordState" ), function ( model )
	    local swordState = Engine.GetModelValue( model )
	    if swordState and swordState > 0 then
	    	self.DpadUp:setImage( RegisterImage( "blacktransparent" ) )
	    else
	    	self.DpadUp:setImage( RegisterImage( "lui_arrow_global" ) )
	    end
	end )
	self:addElement( self.DpadUp )

	self.DpadDown = LUI.UIImage.new()
	self.DpadDown:setLeftRight( true, false, 1212, 1220 )
    self.DpadDown:setTopBottom( true, false, 660, 668 )
	self.DpadDown:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordState" ), function ( model )
	    local swordState = Engine.GetModelValue( model )
	    if swordState and swordState > 0 then
	    	self.DpadDown:setImage( RegisterImage( "blacktransparent" ) )
	    else
	    	self.DpadDown:setImage( RegisterImage( "lui_arrow_global" ) )
	    end
	end )
	self.DpadDown:setZRot( 180 )
	self:addElement( self.DpadDown )

	self.DpadLeft = LUI.UIImage.new()
	self.DpadLeft:setLeftRight( true, false, 1204, 1212 )
    self.DpadLeft:setTopBottom( true, false, 652, 660 )
	self.DpadLeft:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordState" ), function ( model )
	    local swordState = Engine.GetModelValue( model )
	    if swordState and swordState > 0 then
	    	self.DpadLeft:setImage( RegisterImage( "blacktransparent" ) )
	    else
	    	self.DpadLeft:setImage( RegisterImage( "lui_arrow_global" ) )
	    end
	end )
	self.DpadLeft:setZRot( 90 )
	self:addElement( self.DpadLeft )

	self.DpadRight = LUI.UIImage.new()
	self.DpadRight:setLeftRight( true, false, 1220, 1228 )
    self.DpadRight:setTopBottom( true, false, 652, 660 )
	self.DpadRight:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordState" ), function ( model )
	    local swordState = Engine.GetModelValue( model )
	    if swordState and swordState > 0 then
	    	self.DpadRight:setImage( RegisterImage( "blacktransparent" ) )
	    else
	    	self.DpadRight:setImage( RegisterImage( "lui_arrow_global" ) )
	    end
	end )
	self.DpadRight:setZRot( -90 )
	self:addElement( self.DpadRight )

	self.ShieldHealth = LUI.UIImage.new()
	self.ShieldHealth:setLeftRight( true, false, 1212 - 5, 1220 + 5 )
	self.ShieldHealth:setTopBottom( true, false, 660 - 5 + 15, 668 + 5 + 15 )
	self.ShieldHealth:setImage( RegisterImage( "blacktransparent" ) )
	self.ShieldHealth:setRGB( 1, 1, 1 )
	self.ShieldHealth:setScale( 0.9 )
	self.ShieldHealth:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_delta_normal" ) )
	self.ShieldHealth:setShaderVector( 0, 0, 1, 0, 0 )
	self.ShieldHealth:setShaderVector( 1, 0, 0, 0, 0 )
	self.ShieldHealth:setShaderVector( 3, 0, 0, 0, 0 )
	self.ShieldHealth:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown" ), function( model )
		local showDpadDown = Engine.GetModelValue( model )

		if showDpadDown then
			if showDpadDown == 1 then
				self.ShieldHealth:setImage( RegisterImage( "uie_t7_mp_icon_header_emblem" ) )
			else
				self.ShieldHealth:setImage( RegisterImage( "blacktransparent" ) )
			end
		end
	end )
	self.ShieldHealth:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "ZMInventory.shield_health" ), function( model )
		local shield_health = Engine.GetModelValue( model )

		if shield_health then
			self.ShieldHealth:setShaderVector( 2, SetVectorComponent( 2, 1, SubtractVectorComponentFrom( 1, 0.5, ScaleVector( 0.5,
				CoD.GetVectorComponentFromString( shield_health, 1 ),
				CoD.GetVectorComponentFromString( shield_health, 2 ),
				CoD.GetVectorComponentFromString( shield_health, 3 ),
				CoD.GetVectorComponentFromString( shield_health, 4 ) ) ) ) )
		end
	end )
	self:addElement( self.ShieldHealth )

	self.DpadIconMine = LUI.UIImage.new()
    self.DpadIconMine:setLeftRight( true, false, 1220 - 5 + 15, 1228 + 5 + 15 )
    self.DpadIconMine:setTopBottom( true, false, 652 - 5, 660 + 5 )
	self.DpadIconMine:setImage( RegisterImage( "blacktransparent" ) )
	self.DpadIconMine:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function( model )
		local actionSlot3ammo = Engine.GetModelValue( model )

		if actionSlot3ammo then
			if actionSlot3ammo > 0 then
				self.DpadIconMine:setImage( RegisterImage( "t7_hud_mp_inventory_bouncingbetty" ) )
			else
				self.DpadIconMine:setImage( RegisterImage( "blacktransparent" ) )
			end
		end
	end )
	self:addElement( self.DpadIconMine )

	self.DpadIconMineCountText = LUI.UIText.new()
    self.DpadIconMineCountText:setLeftRight( true, false, 1220 - 5 + 32, 1228 + 5 + 32 )
    self.DpadIconMineCountText:setTopBottom( true, false, 652 - 5, 660 + 5 )
	self.DpadIconMineCountText:setText( Engine.Localize( "" ) )
	self.DpadIconMineCountText:setTTF( "fonts/bigFont.ttf" )
	self.DpadIconMineCountText:setScale( 0.75 )
	self.DpadIconMineCountText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.DpadIconMineCountText:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.actionSlot3ammo" ), function( model )
		local actionSlot3ammo = Engine.GetModelValue( model )

		if actionSlot3ammo then
			if actionSlot3ammo > 0 then
				self.DpadIconMineCountText:setText( Engine.Localize( actionSlot3ammo ) )
			else
				self.DpadIconMineCountText:setText( Engine.Localize( "" ) )
			end
		end
	end )
	self:addElement( self.DpadIconMineCountText )

	--[[self.SpecialImageBG = LUI.UIImage.new()
	self.SpecialImageBG:setLeftRight( false, true, -50 - 230, 0 - 230 )
	self.SpecialImageBG:setTopBottom( false, true, -50, 0 )
	self.SpecialImageBG:setImage( RegisterImage( "blacktransparent" ) )
	self.SpecialImageBG:setScale( 0.75 )
	self.SpecialImageBG:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordEnergy" ), function( model )
		local swordEnergy = Engine.GetModelValue( model )
		if swordEnergy then
			if swordEnergy > 0 then
				self.SpecialImageBG:setImage( RegisterImage( "uie_t7_core_hud_ammowidget_panelcircle" ) )
			else
				self.SpecialImageBG:setImage( RegisterImage( "blacktransparent" ) )
			end
		end
	end )
	self:addElement( self.SpecialImageBG )

	self.SpecialImage = LUI.UIImage.new()
	self.SpecialImage:setLeftRight( false, true, -50 - 230, 0 - 230 )
	self.SpecialImage:setTopBottom( false, true, -50, 0 )
	self.SpecialImage:setImage( RegisterImage( "blacktransparent" ) )
	self.SpecialImage:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_multiply" ) )
	self.SpecialImage:setScale( 0.8 )
	self.SpecialImage:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordEnergy" ), function( model )
		local swordEnergy = Engine.GetModelValue( model )

		if swordEnergy then
			if swordEnergy > 0 then
				self.SpecialImage:setImage( RegisterImage( "i_mtl_p7_zm_bgb_icon_arsenal_acelerator_c" ) )
			else
				self.SpecialImage:setImage( RegisterImage( "blacktransparent" ) )
			end
		end
	end )
	self:addElement( self.SpecialImage )

	self.SpecialMeter = LUI.UIImage.new()
	self.SpecialMeter:setLeftRight( false, true, -50 - 230, 0 - 230 )
	self.SpecialMeter:setTopBottom( false, true, -50, 0 )
	self.SpecialMeter:setImage( RegisterImage( "blacktransparent" ) )
	self.SpecialMeter:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_clock_normal" ) )
	self.SpecialMeter:setShaderVector( 1, 0.5, 0, 0, 0 )
	self.SpecialMeter:setShaderVector( 2, 0.5, 0, 0, 0 )
	self.SpecialMeter:setShaderVector( 3, 0.08, 0, 0, 0 )
	self.SpecialMeter:setRGB( 1, 1, 0 )
	self.SpecialMeter:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordEnergy" ), function( model )
		local swordEnergy = Engine.GetModelValue( model )

		if swordEnergy then
			if swordEnergy > 0 then
				self.SpecialMeter:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bbgummeterring" ) )
			else
				self.SpecialMeter:setImage( RegisterImage( "blacktransparent" ) )
			end

			self.SpecialMeter:setShaderVector( 0,
				CoD.GetVectorComponentFromString( swordEnergy, 1 ),
				CoD.GetVectorComponentFromString( swordEnergy, 2 ),
				CoD.GetVectorComponentFromString( swordEnergy, 3 ),
				CoD.GetVectorComponentFromString( swordEnergy, 4 ) )
		end
	end )
	self:addElement( self.SpecialMeter )--]]

	local specialScale = 0.65
	local offsetLR = 1040
	local offsetTB = 570

	self.DpadIconSword = CoD.ZmAmmo_DpadIconPistolFactory.new( menu, controller )
	self.DpadIconSword:setLeftRight( true, false, 158.81 + offsetLR, 190.81 + offsetLR )
	self.DpadIconSword:setTopBottom( true, false, 68 + offsetTB, 100 + offsetTB )
	self.DpadIconSword:setScale( specialScale )
	self:addElement( self.DpadIconSword )

	self.ZmAmmoDpadMeterPistol = CoD.ZmAmmo_DpadMeterPistolFactory.new( menu, controller )
	self.ZmAmmoDpadMeterPistol:setLeftRight( true, false, 154 - 1.5 + offsetLR, 202 - 1.5 + offsetLR )
	self.ZmAmmoDpadMeterPistol:setTopBottom( true, false, 58 - 1 + offsetTB, 114 - 1 + offsetTB )
	self.ZmAmmoDpadMeterPistol:setScale( specialScale )
	self:addElement( self.ZmAmmoDpadMeterPistol )

	self.WeaponName = LUI.UIText.new()
	self.WeaponName:setLeftRight( true, true, 0 + 10, -131 + 10 )
	self.WeaponName:setTopBottom( false, true, -118, -88 )
	self.WeaponName:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	self.WeaponName:setTTF( "fonts/bigFont.ttf" )
	self.WeaponName:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weaponName" ), function( model )
		SetWeaponName( controller, self.WeaponName )
	end )
	self:addElement( self.WeaponName )

	self.ImageAAT = LUI.UIImage.new()
	self.ImageAAT:setLeftRight( false, true, -155 - 0, -105 - 0 )
	self.ImageAAT:setTopBottom( false, true, -64.5, -14.5 )
	self.ImageAAT:setScale( 0.44 )
	self.ImageAAT:setImage( RegisterImage( "blacktransparent" ) )
	self.ImageAAT:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weaponName" ), function ( model ) 
		SetAATImage( controller, self.ImageAAT )
	end )
	self.ImageAAT:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.aatIcon" ), function ( model )
		SetAATImage( controller, self.ImageAAT )
	end )
	self:addElement( self.ImageAAT )

	self.NameAAT = LUI.UIText.new()
	self.NameAAT:setLeftRight( true, true, 131, 0 )
	self.NameAAT:setTopBottom( false, true, -54, -24 )
	self.NameAAT:setScale( 0.75 )
	self.NameAAT:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	self.NameAAT:setTTF( "fonts/bigFont.ttf" )
	self.NameAAT:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weaponName" ), function ( model ) 
		SetAATName( controller, self.NameAAT )
	end	)
	self.NameAAT:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.aatIcon" ), function ( model )
		SetAATName( controller, self.NameAAT )
	end )
	self:addElement( self.NameAAT )

	self.AmmoEquipment = CoD.T6AmmoEquipment.new( menu, controller )
	self.AmmoEquipment:setLeftRight( true, true, 0, 0 )
	self.AmmoEquipment:setTopBottom( true, true, 0, 0 )
	self:addElement( self.AmmoEquipment )

	self.AmmoInfo = CoD.T6AmmoInfo.new( menu, controller )
	self.AmmoInfo:setLeftRight( true, true, 0, 0 )
	self.AmmoInfo:setTopBottom( true, true, 0, 0 )
	self:addElement( self.AmmoInfo )

	self.T6GumMeter = CoD.ZmAmmo_BBGumMeterWidget.new( menu, controller )
    self.T6GumMeter:setLeftRight( false, true, -106 + 15, -56 + 15 )
    self.T6GumMeter:setTopBottom( true, false, 486 + 80, 539 + 80 )
    --self.T6GumMeter:setScale( 1.4 )
    self:addElement( self.T6GumMeter )

    self.T6GumsRemaining = LUI.UIText.new()
	self.T6GumsRemaining:setLeftRight( false, true, -106 + 21.5 + 15, -96 + 21.5 + 15 )
	self.T6GumsRemaining:setTopBottom( true, false, 504.5 + 42.5 + 80, 520.5 + 42.5 + 80 )
	self.T6GumsRemaining:setTTF( "fonts/bigFont.ttf" )
	self.T6GumsRemaining:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.T6GumsRemaining:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "bgb_activations_remaining" ), function( model )
	    local modelValue = Engine.GetModelValue( model )
	    if modelValue then
	        if modelValue > 0 and modelValue < 6 then
	            self.T6GumsRemaining:setText( modelValue )
	        else
	            self.T6GumsRemaining:setText( "" )
	        end
	    end
	end )
	self:addElement( self.T6GumsRemaining )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 18 )
				
				self.AmmoBG:completeAnimation()
				self.AmmoBG:setAlpha( 0 )
				self.clipFinished( self.AmmoBG, {} )

				self.DpadBG:completeAnimation()
				self.DpadBG:setAlpha( 0 )
				self.clipFinished( self.DpadBG, {} )

				self.DpadUp:completeAnimation()
				self.DpadUp:setAlpha( 0 )
				self.clipFinished( self.DpadUp, {} )

				self.DpadDown:completeAnimation()
				self.DpadDown:setAlpha( 0 )
				self.clipFinished( self.DpadDown, {} )

				self.DpadLeft:completeAnimation()
				self.DpadLeft:setAlpha( 0 )
				self.clipFinished( self.DpadLeft, {} )

				self.DpadRight:completeAnimation()
				self.DpadRight:setAlpha( 0 )
				self.clipFinished( self.DpadRight, {} )

				self.ShieldHealth:completeAnimation()
				self.ShieldHealth:setAlpha( 0 )
				self.clipFinished( self.ShieldHealth, {} )

				self.DpadIconMine:completeAnimation()
				self.DpadIconMine:setAlpha( 0 )
				self.clipFinished( self.DpadIconMine, {} )

				self.DpadIconMineCountText:completeAnimation()
				self.DpadIconMineCountText:setAlpha( 0 )
				self.clipFinished( self.DpadIconMineCountText, {} )

				--[[self.SpecialImageBG:completeAnimation()
				self.SpecialImageBG:setAlpha( 0 )
				self.clipFinished( self.SpecialImageBG, {} )

				self.SpecialImage:completeAnimation()
				self.SpecialImage:setAlpha( 0 )
				self.clipFinished( self.SpecialImage, {} )

				self.SpecialMeter:completeAnimation()
				self.SpecialMeter:setAlpha( 0 )
				self.clipFinished( self.SpecialMeter, {} )--]]

				self.DpadIconSword:completeAnimation()
				self.DpadIconSword:setAlpha( 0 )
				self.clipFinished( self.DpadIconSword, {} )

				self.ZmAmmoDpadMeterPistol:completeAnimation()
				self.ZmAmmoDpadMeterPistol:setAlpha( 0 )
				self.clipFinished( self.ZmAmmoDpadMeterPistol, {} )

				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 0 )
				self.clipFinished( self.WeaponName, {} )

				self.ImageAAT:completeAnimation()
				self.ImageAAT:setAlpha( 0 )
				self.clipFinished( self.ImageAAT, {} )

				self.NameAAT:completeAnimation()
				self.NameAAT:setAlpha( 0 )
				self.clipFinished( self.NameAAT, {} )

				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 0 )
				self.clipFinished( self.AmmoEquipment, {} )

				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 0 )
				self.clipFinished( self.AmmoInfo, {} )

				self.T6GumMeter:completeAnimation()
				self.T6GumMeter:setAlpha( 0 )
				self.clipFinished( self.T6GumMeter, {} )

				self.T6GumsRemaining:completeAnimation()
				self.T6GumsRemaining:setAlpha( 0 )
				self.clipFinished( self.T6GumsRemaining, {} )
			end,

			HudStart = function()
				self:setupElementClipCounter( 18 )
	
				local HudStartTransition = function( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
	
					element:setAlpha( 1 )
	
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				self.AmmoBG:completeAnimation()
				self.AmmoBG:setAlpha( 0 )
				HudStartTransition( self.AmmoBG, {} )

				self.DpadBG:completeAnimation()
				self.DpadBG:setAlpha( 0 )
				HudStartTransition( self.DpadBG, {} )

				self.DpadUp:completeAnimation()
				self.DpadUp:setAlpha( 0 )
				HudStartTransition( self.DpadUp, {} )

				self.DpadDown:completeAnimation()
				self.DpadDown:setAlpha( 0 )
				HudStartTransition( self.DpadDown, {} )

				self.DpadLeft:completeAnimation()
				self.DpadLeft:setAlpha( 0 )
				HudStartTransition( self.DpadLeft, {} )

				self.DpadRight:completeAnimation()
				self.DpadRight:setAlpha( 0 )
				HudStartTransition( self.DpadRight, {} )

				self.ShieldHealth:completeAnimation()
				self.ShieldHealth:setAlpha( 0 )
				HudStartTransition( self.ShieldHealth, {} )

				self.DpadIconMine:completeAnimation()
				self.DpadIconMine:setAlpha( 0 )
				HudStartTransition( self.DpadIconMine, {} )

				self.DpadIconMineCountText:completeAnimation()
				self.DpadIconMineCountText:setAlpha( 0 )
				HudStartTransition( self.DpadIconMineCountText, {} )

				--[[self.SpecialImageBG:completeAnimation()
				self.SpecialImageBG:setAlpha( 0 )
				HudStartTransition( self.SpecialImageBG, {} )

				self.SpecialImage:completeAnimation()
				self.SpecialImage:setAlpha( 0 )
				HudStartTransition( self.SpecialImage, {} )

				self.SpecialMeter:completeAnimation()
				self.SpecialMeter:setAlpha( 0 )
				HudStartTransition( self.SpecialMeter, {} )--]]

				self.DpadIconSword:completeAnimation()
				self.DpadIconSword:setAlpha( 0 )
				self.clipFinished( self.DpadIconSword, {} )

				self.ZmAmmoDpadMeterPistol:completeAnimation()
				self.ZmAmmoDpadMeterPistol:setAlpha( 0 )
				self.clipFinished( self.ZmAmmoDpadMeterPistol, {} )

				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 0 )
				HudStartTransition( self.WeaponName, {} )

				self.ImageAAT:completeAnimation()
				self.ImageAAT:setAlpha( 0 )
				HudStartTransition( self.ImageAAT, {} )

				self.NameAAT:completeAnimation()
				self.NameAAT:setAlpha( 0 )
				HudStartTransition( self.NameAAT, {} )

				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 0 )
				HudStartTransition( self.AmmoEquipment, {} )

				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 0 )
				HudStartTransition( self.AmmoInfo, {} )

				self.T6GumMeter:completeAnimation()
				self.T6GumMeter:setAlpha( 0 )
				HudStartTransition( self.T6GumMeter, {} )

				self.T6GumsRemaining:completeAnimation()
				self.T6GumsRemaining:setAlpha( 0 )
				HudStartTransition( self.T6GumsRemaining, {} )
			end
		},

		HudStart = {
			DefaultClip = function()
				self:setupElementClipCounter( 18 )
				
				self.AmmoBG:completeAnimation()
				self.AmmoBG:setAlpha( 1 )
				self.clipFinished( self.AmmoBG, {} )
				
				self.DpadBG:completeAnimation()
				self.DpadBG:setAlpha( 1 )
				self.clipFinished( self.DpadBG, {} )
				
				self.DpadUp:completeAnimation()
				self.DpadUp:setAlpha( 1 )
				self.clipFinished( self.DpadUp, {} )
				
				self.DpadDown:completeAnimation()
				self.DpadDown:setAlpha( 1 )
				self.clipFinished( self.DpadDown, {} )
				
				self.DpadLeft:completeAnimation()
				self.DpadLeft:setAlpha( 1 )
				self.clipFinished( self.DpadLeft, {} )
				
				self.DpadRight:completeAnimation()
				self.DpadRight:setAlpha( 1 )
				self.clipFinished( self.DpadRight, {} )
				
				self.ShieldHealth:completeAnimation()
				self.ShieldHealth:setAlpha( 1 )
				self.clipFinished( self.ShieldHealth, {} )
				
				self.DpadIconMine:completeAnimation()
				self.DpadIconMine:setAlpha( 1 )
				self.clipFinished( self.DpadIconMine, {} )
				
				self.DpadIconMineCountText:completeAnimation()
				self.DpadIconMineCountText:setAlpha( 1 )
				self.clipFinished( self.DpadIconMineCountText, {} )

				--[[self.SpecialImageBG:completeAnimation()
				self.SpecialImageBG:setAlpha( 1 )
				self.clipFinished( self.SpecialImageBG, {} )

				self.SpecialImage:completeAnimation()
				self.SpecialImage:setAlpha( 1 )
				self.clipFinished( self.SpecialImage, {} )

				self.SpecialMeter:completeAnimation()
				self.SpecialMeter:setAlpha( 1 )
				self.clipFinished( self.SpecialMeter, {} )--]]

				self.DpadIconSword:completeAnimation()
				self.DpadIconSword:setAlpha( 1 )
				self.clipFinished( self.DpadIconSword, {} )

				self.ZmAmmoDpadMeterPistol:completeAnimation()
				self.ZmAmmoDpadMeterPistol:setAlpha( 1 )
				self.clipFinished( self.ZmAmmoDpadMeterPistol, {} )
				
				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 1 )
				self.clipFinished( self.WeaponName, {} )

				self.ImageAAT:completeAnimation()
				self.ImageAAT:setAlpha( 1 )
				self.clipFinished( self.ImageAAT, {} )

				self.NameAAT:completeAnimation()
				self.NameAAT:setAlpha( 1 )
				self.clipFinished( self.NameAAT, {} )
				
				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 1 )
				self.clipFinished( self.AmmoEquipment, {} )
				
				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 1 )
				self.clipFinished( self.AmmoInfo, {} )

				self.T6GumMeter:completeAnimation()
				self.T6GumMeter:setAlpha( 1 )
				self.clipFinished( self.T6GumMeter, {} )

				self.T6GumsRemaining:completeAnimation()
				self.T6GumsRemaining:setAlpha( 1 )
				self.clipFinished( self.T6GumsRemaining, {} )
			end,

			DefaultState = function()
				self:setupElementClipCounter( 18 )
	
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

				self.AmmoBG:completeAnimation()
				self.AmmoBG:setAlpha( 1 )
				DefaultStateTransition( self.AmmoBG, {} )
				
				self.DpadBG:completeAnimation()
				self.DpadBG:setAlpha( 1 )
				DefaultStateTransition( self.DpadBG, {} )
				
				self.DpadUp:completeAnimation()
				self.DpadUp:setAlpha( 1 )
				DefaultStateTransition( self.DpadUp, {} )
				
				self.DpadDown:completeAnimation()
				self.DpadDown:setAlpha( 1 )
				DefaultStateTransition( self.DpadDown, {} )
				
				self.DpadLeft:completeAnimation()
				self.DpadLeft:setAlpha( 1 )
				DefaultStateTransition( self.DpadLeft, {} )
				
				self.DpadRight:completeAnimation()
				self.DpadRight:setAlpha( 1 )
				DefaultStateTransition( self.DpadRight, {} )
				
				self.ShieldHealth:completeAnimation()
				self.ShieldHealth:setAlpha( 1 )
				DefaultStateTransition( self.ShieldHealth, {} )
				
				self.DpadIconMine:completeAnimation()
				self.DpadIconMine:setAlpha( 1 )
				DefaultStateTransition( self.DpadIconMine, {} )
				
				self.DpadIconMineCountText:completeAnimation()
				self.DpadIconMineCountText:setAlpha( 1 )
				DefaultStateTransition( self.DpadIconMineCountText, {} )

				--[[self.SpecialImageBG:completeAnimation()
				self.SpecialImageBG:setAlpha( 1 )
				DefaultStateTransition( self.SpecialImageBG, {} )

				self.SpecialImage:completeAnimation()
				self.SpecialImage:setAlpha( 1 )
				DefaultStateTransition( self.SpecialImage, {} )

				self.SpecialMeter:completeAnimation()
				self.SpecialMeter:setAlpha( 1 )
				DefaultStateTransition( self.SpecialMeter, {} )--]]

				self.DpadIconSword:completeAnimation()
				self.DpadIconSword:setAlpha( 1 )
				self.clipFinished( self.DpadIconSword, {} )

				self.ZmAmmoDpadMeterPistol:completeAnimation()
				self.ZmAmmoDpadMeterPistol:setAlpha( 1 )
				self.clipFinished( self.ZmAmmoDpadMeterPistol, {} )
				
				self.WeaponName:completeAnimation()
				self.WeaponName:setAlpha( 1 )
				DefaultStateTransition( self.WeaponName, {} )

				self.ImageAAT:completeAnimation()
				self.ImageAAT:setAlpha( 1 )
				DefaultStateTransition( self.ImageAAT, {} )

				self.NameAAT:completeAnimation()
				self.NameAAT:setAlpha( 1 )
				DefaultStateTransition( self.NameAAT, {} )
				
				self.AmmoEquipment:completeAnimation()
				self.AmmoEquipment:setAlpha( 1 )
				DefaultStateTransition( self.AmmoEquipment, {} )
				
				self.AmmoInfo:completeAnimation()
				self.AmmoInfo:setAlpha( 1 )
				DefaultStateTransition( self.AmmoInfo, {} )

				self.T6GumMeter:completeAnimation()
				self.T6GumMeter:setAlpha( 1 )
				DefaultStateTransition( self.T6GumMeter, {} )

				self.T6GumsRemaining:completeAnimation()
				self.T6GumsRemaining:setAlpha( 1 )
				DefaultStateTransition( self.T6GumsRemaining, {} )
			end
		}
	}

	self:mergeStateConditions( {
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

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.viewmodelWeaponName" ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.viewmodelWeaponName" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.playerSpawned" ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.playerSpawned" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.AmmoBG:close()
		element.DpadBG:close()
		element.DpadUp:close()
		element.DpadDown:close()
		element.DpadLeft:close()
		element.DpadRight:close()
		element.ShieldHealth:close()
		element.DpadIconMine:close()
		element.DpadIconMineCountText:close()
		--[[element.SpecialImageBG:close()
		element.SpecialImage:close()
		element.SpecialMeter:close()--]]
		element.DpadIconSword:close()
		element.ZmAmmoDpadMeterPistol:close()
		element.WeaponName:close()
		element.ImageAAT:close()
		element.NameAAT:close()
		element.AmmoEquipment:close()
		element.AmmoInfo:close()
		element.T6GumMeter:close()
		element.T6GumsRemaining:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end