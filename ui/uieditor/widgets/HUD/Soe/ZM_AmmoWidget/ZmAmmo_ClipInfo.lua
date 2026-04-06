require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_Clip" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_Total" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_Sword" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_SwordElectric" )

CoD.ZmAmmo_ClipInfo = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_ClipInfo.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_ClipInfo )
	self.id = "ZmAmmo_ClipInfo"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 135 )
	self:setTopBottom( true, false, 0, 57 )
	self.anyChildUsesUpdateState = true
	
	self.Clip = CoD.ZmAmmo_Clip.new( menu, controller )
	self.Clip:setLeftRight( true, false, 0, 108 )
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
	
	self.TotalAmmo = CoD.ZmAmmo_Total.new( menu, controller )
	self.TotalAmmo:setLeftRight( true, false, 57, 165 )
	self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
	self:addElement( self.TotalAmmo )
	
	self.Sword = CoD.ZmAmmo_Sword.new( menu, controller )
	self.Sword:setLeftRight( true, false, 364.17, 492.17 )
	self.Sword:setTopBottom( true, false, 8, 40 )
	self:addElement( self.Sword )
	
	self.ZmAmmoSwordElectric = CoD.ZmAmmo_SwordElectric.new( menu, controller )
	self.ZmAmmoSwordElectric:setLeftRight( true, false, 364.17, 492.17 )
	self.ZmAmmoSwordElectric:setTopBottom( true, false, 7.5, 39.5 )
	self:addElement( self.ZmAmmoSwordElectric )
	
	self.ClipDual = CoD.ZmAmmo_Clip.new( menu, controller )
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
	self:addElement( self.ClipDual )
	
	self.ZmFxFlsh = LUI.UIImage.new()
	self.ZmFxFlsh:setLeftRight( true, false, -4.77, 123.39 )
	self.ZmFxFlsh:setTopBottom( true, false, -22, 69 )
	self.ZmFxFlsh:setAlpha( 0 )
	self.ZmFxFlsh:setImage( RegisterImage( "uie_t7_zm_hud_rnd_flsh1" ) )
	self.ZmFxFlsh:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxFlsh )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, -135, -27 )
				self.Clip:setTopBottom( false, true, -57, -9 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, -76, 32 )
				self.TotalAmmo:setTopBottom( false, true, -52.5, -4.5 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ZmAmmoSwordElectric:completeAnimation()
				self.ZmAmmoSwordElectric:setLeftRight( true, false, 364.17, 492.17 )
				self.ZmAmmoSwordElectric:setTopBottom( true, false, 7.5, 39.5 )
				self.clipFinished( self.ZmAmmoSwordElectric, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			WeaponDual = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

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

			Sword = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, 261, 362 )
				self.Clip:setTopBottom( false, true, -49, -1 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, 292, 350 )
				self.TotalAmmo:setTopBottom( false, true, -37, -7 )
				self.TotalAmmo:setRGB( 1, 1, 1 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 6, 134 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 240, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -6.16, 152 )
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
						element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -6.16, 152 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.38 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			HeroWeapon = function ()
				self:setupElementClipCounter( 5 )

				local ClipFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, true, true, CoD.TweenType.Back )
					end
					element:setLeftRight( true, false, 21, 129 )
					element:setTopBottom( true, false, 0, 48 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				ClipFrame2( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end
		},

		ElectricSword = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, 261, 362 )
				self.Clip:setTopBottom( false, true, -49, -1 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, 292, 350 )
				self.TotalAmmo:setTopBottom( false, true, -37, -7 )
				self.TotalAmmo:setRGB( 1, 1, 1 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 363, 491 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ZmAmmoSwordElectric:completeAnimation()
				self.ZmAmmoSwordElectric:setLeftRight( true, false, 7, 135 )
				self.ZmAmmoSwordElectric:setTopBottom( true, false, 7.5, 39.5 )
				self.clipFinished( self.ZmAmmoSwordElectric, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			WeaponDual = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -63, 45 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -74, 159 )
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
				self.ZmFxFlsh:setLeftRight( true, false, -74, 159 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.33 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			Weapon = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, 0, 159 )
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
				self.ZmFxFlsh:setLeftRight( true, false, 0, 159 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.32 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			HeroWeapon = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 21, 129 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 374.17, 482.17 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 14, 129 )
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
				self.ZmFxFlsh:setLeftRight( true, false, 14, 129 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.48 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		},

		Sword = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, 261, 362 )
				self.Clip:setTopBottom( false, true, -49, -1 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, 292, 350 )
				self.TotalAmmo:setTopBottom( false, true, -37, -7 )
				self.TotalAmmo:setRGB( 1, 1, 1 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 6, 134 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ZmAmmoSwordElectric:completeAnimation()
				self.ZmAmmoSwordElectric:setLeftRight( true, false, 364.17, 492.17 )
				self.ZmAmmoSwordElectric:setTopBottom( true, false, 7.5, 39.5 )
				self.clipFinished( self.ZmAmmoSwordElectric, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			WeaponDual = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -63, 45 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -74, 159 )
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
				self.ZmFxFlsh:setLeftRight( true, false, -74, 159 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.33 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			Weapon = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, 0, 159 )
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
				self.ZmFxFlsh:setLeftRight( true, false, 0, 159 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.32 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			HeroWeapon = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 21, 129 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 374.17, 482.17 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 14, 129 )
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
				self.ZmFxFlsh:setLeftRight( true, false, 14, 129 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.48 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		},

		HeroWeapon = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 21, 129 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ZmAmmoSwordElectric:completeAnimation()
				self.ZmAmmoSwordElectric:setLeftRight( true, false, 364.17, 492.17 )
				self.ZmAmmoSwordElectric:setTopBottom( true, false, 7.5, 39.5 )
				self.clipFinished( self.ZmAmmoSwordElectric, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			WeaponDual = function ()
				self:setupElementClipCounter( 5 )

				local ClipFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, true, true, CoD.TweenType.Back )
					end
					element:setLeftRight( true, false, 0, 108 )
					element:setTopBottom( true, false, 0, 48 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 21, 129 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				ClipFrame2( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -63, 45 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 240, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -63, 37.16 )
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
						element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlshFrame3 )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -63, 37.16 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.28 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			Sword = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, 261, 362 )
				self.Clip:setTopBottom( false, true, -49, -1 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, 292, 350 )
				self.TotalAmmo:setTopBottom( false, true, -37, -7 )
				self.TotalAmmo:setRGB( 1, 1, 1 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 6, 134 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, 0, 134 )
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
				self.ZmFxFlsh:setLeftRight( true, false, 0, 134 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.38 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			Weapon = function ()
				self:setupElementClipCounter( 5 )

				local ClipFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, true, true, CoD.TweenType.Back )
					end
					element:setLeftRight( true, false, 0, 108 )
					element:setTopBottom( true, false, 0, 48 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 21, 129 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				ClipFrame2( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end
		},

		WeaponDoesNotUseAmmo = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

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

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ZmAmmoSwordElectric:completeAnimation()
				self.ZmAmmoSwordElectric:setLeftRight( true, false, 364.17, 492.17 )
				self.ZmAmmoSwordElectric:setTopBottom( true, false, 7.5, 39.5 )
				self.clipFinished( self.ZmAmmoSwordElectric, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			WeaponDual = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

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

			Sword = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, 261, 362 )
				self.Clip:setTopBottom( false, true, -49, -1 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, 292, 350 )
				self.TotalAmmo:setTopBottom( false, true, -37, -7 )
				self.TotalAmmo:setRGB( 1, 1, 1 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 6, 134 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -25, 159 )
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
				self.ZmFxFlsh:setLeftRight( true, false, -25, 159 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.29 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			HeroWeapon = function ()
				self:setupElementClipCounter( 4 )

				local ClipFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, true, true, CoD.TweenType.Back )
					end
					element:setLeftRight( true, false, 21, 129 )
					element:setTopBottom( true, false, 0, 48 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				ClipFrame2( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )
			end
		},

		WeaponDual = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ZmAmmoSwordElectric:completeAnimation()
				self.ZmAmmoSwordElectric:setLeftRight( true, false, 364.17, 492.17 )
				self.ZmAmmoSwordElectric:setTopBottom( true, false, 7.5, 39.5 )
				self.clipFinished( self.ZmAmmoSwordElectric, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, -63, 45 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			Sword = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, 261, 362 )
				self.Clip:setTopBottom( false, true, -49, -1 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, 292, 350 )
				self.TotalAmmo:setTopBottom( false, true, -37, -7 )
				self.TotalAmmo:setRGB( 1, 1, 1 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 6, 134 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, -24, 168 )
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
				self.ZmFxFlsh:setLeftRight( true, false, -24, 168 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.36 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			Weapon = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

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
			end,

			HeroWeapon = function ()
				self:setupElementClipCounter( 5 )

				local ClipFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, true, true, CoD.TweenType.Back )
					end
					element:setLeftRight( true, false, 21, 129 )
					element:setTopBottom( true, false, 0, 48 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				ClipFrame2( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setLeftRight( true, false, -35, 59 )
					element:setTopBottom( true, false, -21.5, 69.5 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setLeftRight( true, false, -35, 59 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 1 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end
		},

		Weapon = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, -135, -27 )
				self.Clip:setTopBottom( false, true, -57, -9 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, -76, 32 )
				self.TotalAmmo:setTopBottom( false, true, -52.5, -4.5 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ZmAmmoSwordElectric:completeAnimation()
				self.ZmAmmoSwordElectric:setLeftRight( true, false, 364.17, 492.17 )
				self.ZmAmmoSwordElectric:setTopBottom( true, false, 7.5, 39.5 )
				self.clipFinished( self.ZmAmmoSwordElectric, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				self.ZmFxFlsh:completeAnimation()
				self.ZmFxFlsh:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh, {} )
			end,

			WeaponDual = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

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

			Sword = function ()
				self:setupElementClipCounter( 5 )

				self.Clip:completeAnimation()
				self.Clip:setLeftRight( false, true, 261, 362 )
				self.Clip:setTopBottom( false, true, -49, -1 )
				self.Clip:setAlpha( 1 )
				self.clipFinished( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( false, true, 292, 350 )
				self.TotalAmmo:setTopBottom( false, true, -37, -7 )
				self.TotalAmmo:setRGB( 1, 1, 1 )
				self.TotalAmmo:setAlpha( 1 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 6, 134 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )

				local ZmFxFlshFrame2 = function ( element, event )
					local ZmFxFlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( true, false, -25, 159 )
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
				self.ZmFxFlsh:setLeftRight( true, false, -25, 159 )
				self.ZmFxFlsh:setTopBottom( true, false, -21.5, 69.5 )
				self.ZmFxFlsh:setAlpha( 0.29 )
				ZmFxFlshFrame2( self.ZmFxFlsh, {} )
			end,

			HeroWeapon = function ()
				self:setupElementClipCounter( 4 )

				local ClipFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, true, true, CoD.TweenType.Back )
					end
					element:setLeftRight( true, false, 21, 129 )
					element:setTopBottom( true, false, 0, 48 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Clip:completeAnimation()
				self.Clip:setLeftRight( true, false, 0, 108 )
				self.Clip:setTopBottom( true, false, 0, 48 )
				ClipFrame2( self.Clip, {} )

				self.TotalAmmo:completeAnimation()
				self.TotalAmmo:setLeftRight( true, false, 59, 167 )
				self.TotalAmmo:setTopBottom( true, false, 4.5, 52.5 )
				self.clipFinished( self.TotalAmmo, {} )

				self.Sword:completeAnimation()
				self.Sword:setLeftRight( true, false, 364.17, 492.17 )
				self.Sword:setTopBottom( true, false, 8, 40 )
				self.clipFinished( self.Sword, {} )

				self.ClipDual:completeAnimation()
				self.ClipDual:setLeftRight( true, false, 396, 504 )
				self.ClipDual:setTopBottom( true, false, 0, 48 )
				self.clipFinished( self.ClipDual, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "ElectricSword",
			condition = function ( menu, element, event )
				local isElectricSword = ModelValueStartsWith( controller, "currentWeapon.viewmodelWeaponName", "glaive_apothicon_" )
				if isElectricSword then
					isElectricSword = IsModelValueGreaterThanOrEqualTo( controller, "zmhud.swordState", 5 )
					if isElectricSword then
						isElectricSword = not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
					end
				end
				return isElectricSword
			end
		},
		{
			stateName = "Sword",
			condition = function ( menu, element, event )
				return ModelValueStartsWith( controller, "currentWeapon.viewmodelWeaponName", "glaive_" ) and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
			end
		},
		{
			stateName = "HeroWeapon",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "currentWeapon.viewmodelWeaponName", "zod_riotshield_zm" )
			end
		},
		{
			stateName = "WeaponDoesNotUseAmmo",
			condition = function ( menu, element, event )
				return not WeaponUsesAmmo( controller )
			end
		},
		{
			stateName = "WeaponDual",
			condition = function ( menu, element, event )
				return WeaponUsesAmmo( controller ) and IsModelValueGreaterThanOrEqualTo( controller, "currentWeapon.ammoInDWClip", 0 )
			end
		},
		{
			stateName = "Weapon",
			condition = function ( menu, element, event )
				return WeaponUsesAmmo( controller )
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.viewmodelWeaponName" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.viewmodelWeaponName" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmhud.swordState" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "zmhud.swordState" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weapon" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.weapon" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.ammoInDWClip" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.ammoInDWClip" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.Clip:close()
		element.TotalAmmo:close()
		element.Sword:close()
		element.ZmAmmoSwordElectric:close()
		element.ClipDual:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end