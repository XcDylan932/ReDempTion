local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        self.ReflectAnim:completeAnimation()
        self.ReflectAnim:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
        CoD.UIColors.SetElementColor( self.ReflectAnim, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_FlickerLoopFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_FlickerLoopFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_FlickerLoopFactory )
	self.id = "ZmAmmo_FlickerLoopFactory"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 127 )
	self:setTopBottom( true, false, 0, 127 )
	
	self.ReflectAnim = LUI.UIImage.new()
	self.ReflectAnim:setLeftRight( true, false, 0, 126.85 )
	self.ReflectAnim:setTopBottom( true, false, 0, 126.85 )
	self.ReflectAnim:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_dpadbasereflect" ) )
	self:addElement( self.ReflectAnim )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				local ReflectAnimFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0.2 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ReflectAnim:completeAnimation()
				self.ReflectAnim:setAlpha( 0.6 )
				ReflectAnimFrame2( self.ReflectAnim, {} )

				self.nextClip = "DefaultClip"
			end
		},

		WeaponDual = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				local ReflectAnimFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0.2 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ReflectAnim:completeAnimation()
				self.ReflectAnim:setAlpha( 1 )
				ReflectAnimFrame2( self.ReflectAnim, {} )

				self.nextClip = "DefaultClip"
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "WeaponDual",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThanOrEqualTo( controller, "currentWeapon.ammoInDWClip", 0 )
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.ammoInDWClip" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.ammoInDWClip" } )
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end