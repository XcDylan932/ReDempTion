require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_DpadLeftAmmoDigitsFactory" )

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        self.NumberGlowBackground:completeAnimation()
        self.NumberGlowBackground:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
        CoD.UIColors.SetElementColor( self.NumberGlowBackground, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_DpadLeftAmmoNumberWidgetFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadLeftAmmoNumberWidgetFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadLeftAmmoNumberWidgetFactory )
	self.id = "ZmAmmo_DpadLeftAmmoNumberWidgetFactory"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 24 )
	self:setTopBottom( true, false, 0, 24 )
	self.anyChildUsesUpdateState = true
	
	self.NumberGlowBackground = LUI.UIImage.new()
	self.NumberGlowBackground:setLeftRight( true, false, -9.5, 33.5 )
	self.NumberGlowBackground:setTopBottom( true, false, -6.5, 31 )
	self.NumberGlowBackground:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_number_glow" ) )
	self:addElement( self.NumberGlowBackground )
	
	self.TensDigit = CoD.ZmAmmo_DpadLeftAmmoDigitsFactory.new( menu, controller )
	self.TensDigit:setLeftRight( true, false, 2.17, 15.17 )
	self.TensDigit:setTopBottom( true, false, 3, 21 )
	self.TensDigit:setScale( 1.2 )
	self.TensDigit:mergeStateConditions( {
		{
			stateName = "Show9",
			condition = function ( menu, element, event )
				return IsModelTensDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 9 )
			end
		},
		{
			stateName = "Show8",
			condition = function ( menu, element, event )
				return IsModelTensDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 8 )
			end
		},
		{
			stateName = "Show7",
			condition = function ( menu, element, event )
				return IsModelTensDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 7 )
			end
		},
		{
			stateName = "Show6",
			condition = function ( menu, element, event )
				return IsModelTensDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 6 )
			end
		},
		{
			stateName = "Show5",
			condition = function ( menu, element, event )
				return IsModelTensDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 5 )
			end
		},
		{
			stateName = "Show4",
			condition = function ( menu, element, event )
				return IsModelTensDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 4 )
			end
		},
		{
			stateName = "Show3",
			condition = function ( menu, element, event )
				return IsModelTensDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 3 )
			end
		},
		{
			stateName = "Show2",
			condition = function ( menu, element, event )
				return IsModelTensDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 2 )
			end
		},
		{
			stateName = "Show1",
			condition = function ( menu, element, event )
				return IsModelTensDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 1 )
			end
		},
		{
			stateName = "Show0",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Faded",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		},
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		}
	} )
	self.TensDigit:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.dpadLeftAmmo" ), function ( model )
		menu:updateElementState( self.TensDigit, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.dpadLeftAmmo" } )
	end )
	self:addElement( self.TensDigit )
	
	self.OnesDigit = CoD.ZmAmmo_DpadLeftAmmoDigitsFactory.new( menu, controller )
	self.OnesDigit:setLeftRight( true, false, 10.17, 21.17 )
	self.OnesDigit:setTopBottom( true, false, 3, 21 )
	self.OnesDigit:setScale( 1.2 )
	self.OnesDigit:mergeStateConditions( {
		{
			stateName = "Show9",
			condition = function ( menu, element, event )
				return IsModelOnesDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 9 )
			end
		},
		{
			stateName = "Show8",
			condition = function ( menu, element, event )
				return IsModelOnesDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 8 )
			end
		},
		{
			stateName = "Show7",
			condition = function ( menu, element, event )
				return IsModelOnesDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 7 )
			end
		},
		{
			stateName = "Show6",
			condition = function ( menu, element, event )
				return IsModelOnesDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 6 )
			end
		},
		{
			stateName = "Show5",
			condition = function ( menu, element, event )
				return IsModelOnesDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 5 )
			end
		},
		{
			stateName = "Show4",
			condition = function ( menu, element, event )
				return IsModelOnesDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 4 )
			end
		},
		{
			stateName = "Show3",
			condition = function ( menu, element, event )
				return IsModelOnesDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 3 )
			end
		},
		{
			stateName = "Show2",
			condition = function ( menu, element, event )
				return IsModelOnesDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 2 )
			end
		},
		{
			stateName = "Show1",
			condition = function ( menu, element, event )
				return IsModelOnesDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 1 )
			end
		},
		{
			stateName = "Show0",
			condition = function ( menu, element, event )
				return IsModelOnesDigitEqualTo( controller, "hudItems.dpadLeftAmmo", 0 ) and IsModelValueGreaterThan( controller, "hudItems.dpadLeftAmmo", 0 )
			end
		},
		{
			stateName = "Faded",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		},
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		}
	} )
	self.OnesDigit:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.dpadLeftAmmo" ), function ( model )
		menu:updateElementState( self.OnesDigit, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.dpadLeftAmmo" } )
	end )
	self:addElement( self.OnesDigit )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.TensDigit:completeAnimation()
				self.TensDigit:setAlpha( 0 )
				self.clipFinished( self.TensDigit, {} )

				self.OnesDigit:completeAnimation()
				self.OnesDigit:setAlpha( 0 )
				self.clipFinished( self.OnesDigit, {} )
			end
		},

		Visible = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.TensDigit:completeAnimation()
				self.TensDigit:setAlpha( 1 )
				self.clipFinished( self.TensDigit, {} )

				self.OnesDigit:completeAnimation()
				self.OnesDigit:setAlpha( 1 )
				self.clipFinished( self.OnesDigit, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.TensDigit:close()
		element.OnesDigit:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end