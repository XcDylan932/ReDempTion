local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        self.BulbSmFill:completeAnimation()
        self.BulbSmFill:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
        CoD.UIColors.SetElementColor( self.BulbSmFill, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_HologramSmallFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_HologramSmallFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_HologramSmallFactory )
	self.id = "ZmAmmo_HologramSmallFactory"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 269 )
	self:setTopBottom( true, false, 0, 209 )
	
	self.BulbSmFill = LUI.UIImage.new()
	self.BulbSmFill:setLeftRight( true, false, 0, 269.32 )
	self.BulbSmFill:setTopBottom( true, false, 0, 209.18 )
	self.BulbSmFill:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_projection_small" ) )
	self:addElement( self.BulbSmFill )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				local BulbSmFillFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				self.BulbSmFill:completeAnimation()
				self.BulbSmFill:setAlpha( 0.8 )
				BulbSmFillFrame2( self.BulbSmFill, {} )

				self.nextClip = "DefaultClip"
			end
		},

		WeaponDual = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				self.BulbSmFill:completeAnimation()
				self.BulbSmFill:setAlpha( 0 )
				self.clipFinished( self.BulbSmFill, {} )

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