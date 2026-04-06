require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_ClipFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_TotalFactory" )

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        self.ZmFxFlsh:completeAnimation()
        self.ZmFxFlsh:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
        CoD.UIColors.SetElementColor( self.ZmFxFlsh, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_ClipInfoFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_ClipInfoFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_ClipInfoFactory )
	self.id = "ZmAmmo_ClipInfoFactory"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 135 )
	self:setTopBottom( true, false, 0, 57 )
	self.anyChildUsesUpdateState = true
	
	self.Clip = CoD.ZmAmmo_ClipFactory.new( menu, controller )
	self.Clip:setLeftRight( true, false, -12, 96 )
	self.Clip:setTopBottom( true, false, 0, 48 )
	self.Clip:setZoom( 3 )
	self.Clip:subscribeToGlobalModel( controller, "CurrentWeapon", "ammoInClip", function ( model )
		local ammoInClip = Engine.GetModelValue( model )
		if ammoInClip then
			self.Clip.Clip:setText( Engine.Localize( ammoInClip ) )
		end
	end )
	self.Clip:mergeStateConditions( {
		{
			stateName = "Invisible",
			condition = function ( menu, element, event )
				return ModelValueStartsWithAny( controller, "currentWeapon.equippedWeaponReference", "dragon_gauntlet" )
			end
		},
		{
			stateName = "LowAmmo",
			condition = function ( menu, element, event )
				return IsLowAmmoClip( controller ) and WeaponHasAmmo( controller )
			end
		},
		{
			stateName = "NoAmmo",
			condition = function ( menu, element, event )
				local hasAmmo
				if not WeaponHasAmmo( controller ) then
					hasAmmo = WeaponUsesAmmo( controller )
				else
					hasAmmo = false
				end
				return hasAmmo
			end
		}
	} )
	self.Clip:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.equippedWeaponReference" ), function ( model )
		menu:updateElementState( self.Clip, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.equippedWeaponReference" } )
	end )
	self.Clip:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.ammoStock" ), function ( model )
		menu:updateElementState( self.Clip, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.ammoStock" } )
	end )
	self.Clip:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.ammoInClip" ), function ( model )
		menu:updateElementState( self.Clip, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.ammoInClip" } )
	end )
	self.Clip:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weapon" ), function ( model )
		menu:updateElementState( self.Clip, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.weapon" } )
	end )
	self:addElement( self.Clip )
	
	self.TotalAmmo = CoD.ZmAmmo_TotalFactory.new( menu, controller )
	self.TotalAmmo:setLeftRight( true, false, 57, 165 )
	self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
	self:addElement( self.TotalAmmo )
	
	self.ClipDual = CoD.ZmAmmo_ClipFactory.new( menu, controller )
	self.ClipDual:setLeftRight( true, false, 396, 504 )
	self.ClipDual:setTopBottom( true, false, 0, 48 )
	self.ClipDual:setZoom( 3 )
	self.ClipDual:subscribeToGlobalModel( controller, "CurrentWeapon", "ammoInDWClip", function ( model )
		local ammoInDWClip = Engine.GetModelValue( model )
		if ammoInDWClip then
			self.ClipDual.Clip:setText( Engine.Localize( ammoInDWClip ) )
		end
	end )
	self.ClipDual:mergeStateConditions( {
		{
			stateName = "LowAmmo",
			condition = function ( menu, element, event )
				return WeaponHasAmmo( controller ) and IsLowAmmoDWClip( controller )
			end
		},
		{
			stateName = "NoAmmo",
			condition = function ( menu, element, event )
				local hasAmmo
				if not WeaponHasAmmo( controller ) then
					hasAmmo = WeaponUsesAmmo( controller )
				else
					hasAmmo = false
				end
				return hasAmmo
			end
		}
	} )
	self.ClipDual:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.ammoStock" ), function ( model )
		menu:updateElementState( self.ClipDual, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.ammoStock" } )
	end )
	self.ClipDual:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.ammoInClip" ), function ( model )
		menu:updateElementState( self.ClipDual, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.ammoInClip" } )
	end )
	self.ClipDual:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.ammoInDWClip" ), function ( model )
		menu:updateElementState( self.ClipDual, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.ammoInDWClip" } )
	end )
	self.ClipDual:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weapon" ), function ( model )
		menu:updateElementState( self.ClipDual, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.weapon" } )
	end )
	self.ClipDual:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.equippedWeaponReference" ), function ( model )
		menu:updateElementState( self.ClipDual, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.equippedWeaponReference" } )
	end )
	self:addElement( self.ClipDual )
	
	self.ZmFxFlsh = LUI.UIImage.new()
	self.ZmFxFlsh:setLeftRight( true, false, -4.77, 123.39 )
	self.ZmFxFlsh:setTopBottom( true, false, -22, 69 )
	self.ZmFxFlsh:setRGB( 0, 0.42, 1 )
	self.ZmFxFlsh:setAlpha( 0 )
	self.ZmFxFlsh:setImage( RegisterImage( "uie_t7_zm_hud_rnd_flsh1" ) )
	self.ZmFxFlsh:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxFlsh )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, -147, -39 )
				self.Clip:setTopBottom( false, true, -57, -9 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, -76, 32 )
				self.TotalAmmo:setTopBottom( false, true, -52.5, -4.5 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			WeaponDual = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, -5, 103 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 58, 166 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -63, 45 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 270, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -73.08, 55.08 )
						element:setTopBottom( true, false, -21.5, 69.5 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -73.08, 55.08 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.38 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			WeaponDualOffsetLeft = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, -25, 83 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 38, 146 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -83, 25 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 270, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -73.08, 55.08 )
						element:setTopBottom( true, false, -21.5, 69.5 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, -73.08, 55.08 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -83.08, 45.08 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.38 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		},

		WeaponDoesNotUseAmmo = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, -135, -27 )
				self.Clip:setTopBottom( false, true, -57, -9 )
				self.Clip:setAlpha( 0 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, -76, 32 )
				self.TotalAmmo:setTopBottom( false, true, -52.5, -4.5 )
				self.TotalAmmo:setAlpha( 0 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			WeaponDual = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, -2, 106 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -63, 45 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -66, 48 )
						element:setTopBottom( true, false, -21.5, 69.5 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -66, 48 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.37 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			WeaponDualOffsetLeft = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, -12, 96 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 49, 157 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -73, 35 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -66, 48 )
						element:setTopBottom( true, false, -21.5, 69.5 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -66, 48 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.37 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		},

		WeaponDual = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, -2, 106 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -63, 45 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			Weapon = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, -12, 96 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 4, 168 )
						element:setTopBottom( true, false, -21.5, 69.5 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, 4, 168 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.36 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		},

		Weapon = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, -147, -39 )
				self.Clip:setTopBottom( false, true, -57, -9 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, -76, 32 )
				self.TotalAmmo:setTopBottom( false, true, -52.5, -4.5 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			WeaponDual = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, -5, 103 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -63, 45 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -66, 48 )
						element:setTopBottom( true, false, -21.5, 69.5 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -66, 48 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.37 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		},

		WeaponDualOffsetLeft = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, -22, 86 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 39, 147 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -83, 25 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -14.77, 113.39 )
				self.ZmFxFlsh:setTopBottom( true, false, -22, 69 )
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			WeaponOffsetLeft = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, -32, 76 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 39, 147 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, -6, 158 )
						element:setTopBottom( true, false, -21.5, 69.5 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -6, 158 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.36 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		},

		WeaponOffsetLeft = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, -32, 76 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 39, 147 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 386, 494 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -14.77, 113.39 )
				self.ZmFxFlsh:setTopBottom( true, false, -22, 69 )
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			WeaponDualOffsetLeft = function ()
				self:setupElementClipCounter( 4 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, -160, -52 )
				self.Clip:setTopBottom( false, true, -57, -9 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, -96, 12 )
				self.TotalAmmo:setTopBottom( false, true, -52.5, -4.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -83, 25 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -76, 38 )
						element:setTopBottom( true, false, -21.5, 69.5 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmFxFlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -76, 38 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.37 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "WeaponDoesNotUseAmmo",
			condition = function ( menu, element, event )
				return not WeaponUsesAmmo( controller )
			end
		},
		{
			stateName = "WeaponDual",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThanOrEqualTo( controller, "currentWeapon.ammoInDWClip", 0 ) and not IsAnyMapName( "zm_tomb", "zm_moon" )
			end
		},
		{
			stateName = "Weapon",
			condition = function ( menu, element, event )
				return not IsAnyMapName( "zm_tomb", "zm_moon" )
			end
		},
		{
			stateName = "WeaponDualOffsetLeft",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThanOrEqualTo( controller, "currentWeapon.ammoInDWClip", 0 ) and IsAnyMapName( "zm_tomb", "zm_moon" )
			end
		},
		{
			stateName = "WeaponOffsetLeft",
			condition = function ( menu, element, event )
				return IsAnyMapName( "zm_tomb", "zm_moon" )
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weapon" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.weapon" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.equippedWeaponReference" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.equippedWeaponReference" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.ammoInDWClip" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.ammoInDWClip" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.Clip:close()
		element.TotalAmmo:close()
		element.ClipDual:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end