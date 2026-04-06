CoD.ZmAmmo_DpadIconShieldIconStalingrad = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadIconShieldIconStalingrad.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadIconShieldIconStalingrad )
	self.id = "ZmAmmo_DpadIconShieldIconStalingrad"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 46 )
	self:setTopBottom( true, false, 0, 46 )
	
	self.Fill = LUI.UIImage.new()
	self.Fill:setLeftRight( true, false, 14, 31 )
	self.Fill:setTopBottom( true, false, 13.5, 34.5 )
	self.Fill:setRGB( 0.68, 0.68, 0.68 )
	self.Fill:setAlpha( 0.8 )
	self.Fill:setImage( RegisterImage( "uie_t7_icon_inventory_dlc3_dragonshield_fill" ) )
	self.Fill:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_delta" ) )
	self.Fill:setShaderVector( 0, 0, 1, 0, 0 )
	self.Fill:setShaderVector( 1, 0, 0, 0, 0 )
	self.Fill:setShaderVector( 3, 0.02, 0, 0, 0 )
	self.Fill:subscribeToGlobalModel( controller, "ZMInventory", "shield_health", function ( model )
		local shieldHealth = Engine.GetModelValue( model )
		if shieldHealth then
			self.Fill:setShaderVector( 2, SetVectorComponent( 2, 1, SubtractVectorComponentFrom( 1, 0.7, ScaleVector( 0.5, CoD.GetVectorComponentFromString( shieldHealth, 1 ), CoD.GetVectorComponentFromString( shieldHealth, 2 ), CoD.GetVectorComponentFromString( shieldHealth, 3 ), CoD.GetVectorComponentFromString( shieldHealth, 4 ) ) ) ) )
		end
	end )
	self:addElement( self.Fill )
	
	self.Outline = LUI.UIImage.new()
	self.Outline:setLeftRight( false, false, -10, 9 )
	self.Outline:setTopBottom( false, false, -10, 12 )
	self.Outline:setImage( RegisterImage( "uie_t7_icon_inventory_dlc3_dragonshield_outline" ) )
	self:addElement( self.Outline )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 0 )
			end,

			Ready = function ()
				self:setupElementClipCounter( 0 )
			end
		},

		AlmostFull = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.Fill:completeAnimation()
				self.Fill:setRGB( 0.47, 1, 1 )
				self.clipFinished( self.Fill, {} )

				self.Outline:completeAnimation()
				self.Outline:setRGB( 0.81, 0.99, 1 )
				self.clipFinished( self.Outline, {} )
			end
		},

		Middle = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.Fill:completeAnimation()
				self.Fill:setRGB( 1, 1, 0.73 )
				self.clipFinished( self.Fill, {} )

				self.Outline:completeAnimation()
				self.Outline:setRGB( 1, 0.84, 0.17 )
				self.clipFinished( self.Outline, {} )
			end
		},

		Low = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.Fill:completeAnimation()
				self.Fill:setRGB( 1, 0.49, 0.24 )
				self.clipFinished( self.Fill, {} )

				self.Outline:completeAnimation()
				self.Outline:setRGB( 0.52, 0.23, 0 )
				self.clipFinished( self.Outline, {} )
			end
		},

		NoHealth = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				self.Outline:completeAnimation()
				self.Outline:setRGB( 0.2, 0.2, 0.2 )
				self.clipFinished( self.Outline, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "AlmostFull",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThan( controller, "zmInventory.shield_health", 0.66 )
			end
		},
		{
			stateName = "Middle",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThan( controller, "zmInventory.shield_health", 0.33 )
			end
		},
		{
			stateName = "Low",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThan( controller, "zmInventory.shield_health", 0 )
			end
		},
		{
			stateName = "NoHealth",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "zmInventory.shield_health" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "zmInventory.shield_health" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.Fill:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end