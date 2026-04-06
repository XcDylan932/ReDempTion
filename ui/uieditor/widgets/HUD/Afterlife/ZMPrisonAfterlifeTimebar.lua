CoD.ZMPrisonAfterlifeTimebar = InheritFrom( LUI.UIElement )
CoD.ZMPrisonAfterlifeTimebar.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMPrisonAfterlifeTimebar )
	self.id = "ZMPrisonAfterlifeTimer"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true
	
	self.TimeBarBack = LUI.UIImage.new()
	self.TimeBarBack:setLeftRight( true, false, 582.66, 697.33 )
	self.TimeBarBack:setTopBottom( false, true, -108.66, -51.33 )
	self.TimeBarBack:setImage( RegisterImage( "uie_t7_hud_zombie_afterlife_meter_fill" ) )
	self:addElement( self.TimeBarBack )
	
	self.TimeBarFill = LUI.UIImage.new()
	self.TimeBarFill:setLeftRight( true, false, 582.66, 697.33 )
	self.TimeBarFill:setTopBottom( false, true, -108.66, -51.33 )
	self.TimeBarFill:setImage( RegisterImage( "uie_t7_hud_zombie_afterlife_meter" ) )
	self.TimeBarFill:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.TimeBarFill:setShaderVector( 1, 0.01, 0, 0, 0 )
	self.TimeBarFill:setShaderVector( 2, 1, 0, 0, 0 )
	self.TimeBarFill:setShaderVector( 3, 0, 0, 0, 0 )
	self.TimeBarFill:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "player_afterlife_mana" ), function ( model )
		local modelValue = Engine.GetModelValue( model )
		if modelValue then
			self.TimeBarFill:setShaderVector( 0, CoD.GetVectorComponentFromString( modelValue, 1 ), CoD.GetVectorComponentFromString( modelValue, 2 ), CoD.GetVectorComponentFromString( modelValue, 3 ), CoD.GetVectorComponentFromString( modelValue, 4 ) )
		end
	end )
	self:addElement( self.TimeBarFill )
	
	self.TimeBarFill0 = LUI.UIImage.new()
	self.TimeBarFill0:setLeftRight( true, false, 0, 564 )
	self.TimeBarFill0:setTopBottom( true, false, 0, 156 )
	self.TimeBarFill0:setAlpha( 0 )
	self.TimeBarFill0:setImage( RegisterImage( "uie_t7_hud_zombie_afterlife_meter_glow" ) )
	self.TimeBarFill0:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_delta" ) )
	self.TimeBarFill0:setShaderVector( 0, 0.43, 0.46, 0, 0 )
	self.TimeBarFill0:setShaderVector( 1, 0.02, 0.02, 0, 0 )
	self.TimeBarFill0:setShaderVector( 2, 0, 1, 0, 0 )
	self.TimeBarFill0:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.TimeBarFill0 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.TimeBarBack:completeAnimation()
				self.TimeBarBack:setAlpha( 0 )
				self.clipFinished( self.TimeBarBack, {} )

				self.TimeBarFill:completeAnimation()
				self.TimeBarFill:setAlpha( 0 )
				self.clipFinished( self.TimeBarFill, {} )

				self.TimeBarFill0:completeAnimation()
				self.TimeBarFill0:setAlpha( 0 )
				self.clipFinished( self.TimeBarFill0, {} )
			end
		},

		Visible = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.TimeBarBack:completeAnimation()
				self.TimeBarBack:setAlpha( 1 )
				self.clipFinished( self.TimeBarBack, {} )

				self.TimeBarFill:completeAnimation()
				self.TimeBarFill:setAlpha( 1 )
				self.TimeBarFill:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.TimeBarFill:setShaderVector( 1, 0.01, 0, 0, 0 )
				self.TimeBarFill:setShaderVector( 2, 1, 0, 0, 0 )
				self.TimeBarFill:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.TimeBarFill, {} )

				self.TimeBarFill0:completeAnimation()
				self.TimeBarFill0:setAlpha( 0 )
				self.clipFinished( self.TimeBarFill0, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Visible",
			condition = function( menu, element, event )
				return IsModelValueGreaterThan( controller, "afterlife_hud", 0 )
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "afterlife_hud" ), function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "afterlife_hud" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.TimeBarBack:close()
		element.TimeBarFill:close()
		element.TimeBarFill0:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end