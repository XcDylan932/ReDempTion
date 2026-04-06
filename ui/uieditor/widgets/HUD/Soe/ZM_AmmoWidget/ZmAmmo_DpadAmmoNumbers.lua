local PostLoadFunc = function( self, controller, menu )
	self.UpdateColors = function( self )
		local elements = { self.Number5, self.Number4, self.Number3, self.Number2, self.Number1, self.Number0, self.SymbolZ, self.SymbolCross }
		for _, element in ipairs( elements ) do
			element:completeAnimation()
			element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
			CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
		end
    end

    local controllerModel = Engine.GetModelForController( controller )
    local colorUpdateModel = Engine.CreateModel( controllerModel, "colorUpdate" )

    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_DpadAmmoNumbers = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadAmmoNumbers.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadAmmoNumbers )
	self.id = "ZmAmmo_DpadAmmoNumbers"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 18 )
	self:setTopBottom( true, false, 0, 18 )

	self.Number5Shadow = LUI.UIImage.new()
	self.Number5Shadow:setLeftRight( true, false, -26 + 1, 31 + 1 )
	self.Number5Shadow:setTopBottom( true, false, -20, 36 )
	self.Number5Shadow:setAlpha( 0 )
	self.Number5Shadow:setImage( RegisterImage( "uie_t7_zm_hud_ammo_number5" ) )
	self:addElement( self.Number5Shadow )
	
	self.Number5 = LUI.UIImage.new()
	self.Number5:setLeftRight( true, false, -26, 31 )
	self.Number5:setTopBottom( true, false, -20, 36 )
	self.Number5:setAlpha( 0 )
	self.Number5:setImage( RegisterImage( "uie_t7_zm_hud_ammo_number5" ) )
	self.Number5:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Number5 )

	self.Number4Shadow = LUI.UIImage.new()
	self.Number4Shadow:setLeftRight( true, false, -26 + 1, 31 + 1 )
	self.Number4Shadow:setTopBottom( true, false, -20, 36 )
	self.Number4Shadow:setAlpha( 0 )
	self.Number4Shadow:setImage( RegisterImage( "uie_t7_zm_hud_ammo_number4" ) )
	self:addElement( self.Number4Shadow )
	
	self.Number4 = LUI.UIImage.new()
	self.Number4:setLeftRight( true, false, -26, 31 )
	self.Number4:setTopBottom( true, false, -20, 36 )
	self.Number4:setAlpha( 0 )
	self.Number4:setImage( RegisterImage( "uie_t7_zm_hud_ammo_number4" ) )
	self.Number4:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Number4 )

	self.Number3Shadow = LUI.UIImage.new()
	self.Number3Shadow:setLeftRight( true, false, -26 + 1, 31 + 1 )
	self.Number3Shadow:setTopBottom( true, false, -20, 36 )
	self.Number3Shadow:setAlpha( 0 )
	self.Number3Shadow:setImage( RegisterImage( "uie_t7_zm_hud_ammo_number3" ) )
	self:addElement( self.Number3Shadow )
	
	self.Number3 = LUI.UIImage.new()
	self.Number3:setLeftRight( true, false, -26, 31 )
	self.Number3:setTopBottom( true, false, -20, 36 )
	self.Number3:setAlpha( 0 )
	self.Number3:setImage( RegisterImage( "uie_t7_zm_hud_ammo_number3" ) )
	self.Number3:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Number3 )

	self.Number2Shadow = LUI.UIImage.new()
	self.Number2Shadow:setLeftRight( true, false, -26 + 1, 31 + 1 )
	self.Number2Shadow:setTopBottom( true, false, -20, 36 )
	self.Number2Shadow:setScale( 1.0 )
	self.Number2Shadow:setAlpha( 0 )
	self.Number2Shadow:setImage( RegisterImage( "uie_t7_zm_hud_ammo_number2" ) )
	self:addElement( self.Number2Shadow )
	
	self.Number2 = LUI.UIImage.new()
	self.Number2:setLeftRight( true, false, -26, 31 )
	self.Number2:setTopBottom( true, false, -20, 36 )
	self.Number2:setAlpha( 0 )
	self.Number2:setImage( RegisterImage( "uie_t7_zm_hud_ammo_number2" ) )
	self.Number2:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Number2 )

	self.Number1Shadow = LUI.UIImage.new()
	self.Number1Shadow:setLeftRight( true, false, -26 + 1, 31 + 1 )
	self.Number1Shadow:setTopBottom( true, false, -20, 36 )
	self.Number1Shadow:setAlpha( 0 )
	self.Number1Shadow:setImage( RegisterImage( "uie_t7_zm_hud_ammo_number1" ) )
	self:addElement( self.Number1Shadow )
	
	self.Number1 = LUI.UIImage.new()
	self.Number1:setLeftRight( true, false, -26, 31 )
	self.Number1:setTopBottom( true, false, -20, 36 )
	self.Number1:setAlpha( 0 )
	self.Number1:setImage( RegisterImage( "uie_t7_zm_hud_ammo_number1" ) )
	self.Number1:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Number1 )

	self.Number0Shadow = LUI.UIImage.new()
	self.Number0Shadow:setLeftRight( true, false, -26 + 1, 31 + 1 )
	self.Number0Shadow:setTopBottom( true, false, -20, 36 )
	self.Number0Shadow:setAlpha( 0 )
	self:addElement( self.Number0Shadow )
	
	self.Number0 = LUI.UIImage.new()
	self.Number0:setLeftRight( true, false, -26, 31 )
	self.Number0:setTopBottom( true, false, -20, 36 )
	self.Number0:setAlpha( 0 )
	self.Number0:setImage( RegisterImage( "uie_t7_zm_hud_ammo_number0" ) )
	self.Number0:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Number0 )

	self.SymbolZShadow = LUI.UIImage.new()
	self.SymbolZShadow:setLeftRight( true, false, -17.55 + 1, 24 + 1 )
	self.SymbolZShadow:setTopBottom( true, false, -20, 34 )
	self.SymbolZShadow:setAlpha( 0 )
	self.SymbolZShadow:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_z_orange" ) )
	self:addElement( self.SymbolZShadow )
	
	self.SymbolZ = LUI.UIImage.new()
	self.SymbolZ:setLeftRight( true, false, -17.55, 24 )
	self.SymbolZ:setTopBottom( true, false, -20, 34 )
	self.SymbolZ:setAlpha( 0 )
	self.SymbolZ:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_z_orange" ) )
	self.SymbolZ:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.SymbolZ )

	self.SymbolCrossShadow = LUI.UIImage.new()
	self.SymbolCrossShadow:setLeftRight( true, false, -26 + 1, 31 + 1 )
	self.SymbolCrossShadow:setTopBottom( true, false, -20, 37 )
	self.SymbolCrossShadow:setAlpha( 0 )
	self.SymbolCrossShadow:setImage( RegisterImage( "uie_t7_zm_hud_ammo_emptycross" ) )
	self:addElement( self.SymbolCrossShadow )
	
	self.SymbolCross = LUI.UIImage.new()
	self.SymbolCross:setLeftRight( true, false, -26, 31 )
	self.SymbolCross:setTopBottom( true, false, -20, 37 )
	self.SymbolCross:setAlpha( 0 )
	self.SymbolCross:setImage( RegisterImage( "uie_t7_zm_hud_ammo_emptycross" ) )
	self.SymbolCross:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.SymbolCross )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Number5Shadow:completeAnimation()
				self.Number5Shadow:setAlpha( 0 )
				self.clipFinished( self.Number5Shadow, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4Shadow:completeAnimation()
				self.Number4Shadow:setAlpha( 0 )
				self.clipFinished( self.Number4Shadow, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3Shadow:completeAnimation()
				self.Number3Shadow:setAlpha( 0 )
				self.clipFinished( self.Number3Shadow, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2Shadow:completeAnimation()
				self.Number2Shadow:setAlpha( 0 )
				self.clipFinished( self.Number2Shadow, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1Shadow:completeAnimation()
				self.Number1Shadow:setAlpha( 0 )
				self.clipFinished( self.Number1Shadow, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0Shadow:completeAnimation()
				self.Number0Shadow:setAlpha( 0 )
				self.clipFinished( self.Number0Shadow, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolZShadow:completeAnimation()
				self.SymbolZShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolZShadow, {} )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.SymbolCrossShadow:completeAnimation()
				self.SymbolCrossShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossShadow, {} )

				self.SymbolCross:completeAnimation()
				self.SymbolCross:setAlpha( 0 )
				self.clipFinished( self.SymbolCross, {} )
			end
		},

		ShowZ = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Number5Shadow:completeAnimation()
				self.Number5Shadow:setAlpha( 0 )
				self.clipFinished( self.Number5Shadow, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4Shadow:completeAnimation()
				self.Number4Shadow:setAlpha( 0 )
				self.clipFinished( self.Number4Shadow, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3Shadow:completeAnimation()
				self.Number3Shadow:setAlpha( 0 )
				self.clipFinished( self.Number3Shadow, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2Shadow:completeAnimation()
				self.Number2Shadow:setAlpha( 0 )
				self.clipFinished( self.Number2Shadow, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1Shadow:completeAnimation()
				self.Number1Shadow:setAlpha( 0 )
				self.clipFinished( self.Number1Shadow, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0Shadow:completeAnimation()
				self.Number0Shadow:setAlpha( 0 )
				self.clipFinished( self.Number0Shadow, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolZShadow:completeAnimation()
				self.SymbolZShadow:setAlpha( 1 )
				self.clipFinished( self.SymbolZShadow, {} )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 1 )
				self.clipFinished( self.SymbolZ, {} )

				self.SymbolCrossShadow:completeAnimation()
				self.SymbolCrossShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossShadow, {} )

				self.SymbolCross:completeAnimation()
				self.SymbolCross:setAlpha( 0 )
				self.clipFinished( self.SymbolCross, {} )
			end
		},

		ShowCross = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Number5Shadow:completeAnimation()
				self.Number5Shadow:setAlpha( 0 )
				self.clipFinished( self.Number5Shadow, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4Shadow:completeAnimation()
				self.Number4Shadow:setAlpha( 0 )
				self.clipFinished( self.Number4Shadow, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3Shadow:completeAnimation()
				self.Number3Shadow:setAlpha( 0 )
				self.clipFinished( self.Number3Shadow, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2Shadow:completeAnimation()
				self.Number2Shadow:setAlpha( 0 )
				self.clipFinished( self.Number2Shadow, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1Shadow:completeAnimation()
				self.Number1Shadow:setAlpha( 0 )
				self.clipFinished( self.Number1Shadow, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0Shadow:completeAnimation()
				self.Number0Shadow:setAlpha( 0 )
				self.clipFinished( self.Number0Shadow, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolZShadow:completeAnimation()
				self.SymbolZShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolZShadow, {} )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.SymbolCrossShadow:completeAnimation()
				self.SymbolCrossShadow:setAlpha( 1 )
				self.clipFinished( self.SymbolCrossShadow, {} )

				self.SymbolCross:completeAnimation()
				self.SymbolCross:setAlpha( 1 )
				self.clipFinished( self.SymbolCross, {} )
			end
		},

		Show5 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Number5Shadow:completeAnimation()
				self.Number5Shadow:setAlpha( 1 )
				self.clipFinished( self.Number5Shadow, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 1 )
				self.clipFinished( self.Number5, {} )

				self.Number4Shadow:completeAnimation()
				self.Number4Shadow:setAlpha( 0 )
				self.clipFinished( self.Number4Shadow, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3Shadow:completeAnimation()
				self.Number3Shadow:setAlpha( 0 )
				self.clipFinished( self.Number3Shadow, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2Shadow:completeAnimation()
				self.Number2Shadow:setAlpha( 0 )
				self.clipFinished( self.Number2Shadow, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1Shadow:completeAnimation()
				self.Number1Shadow:setAlpha( 0 )
				self.clipFinished( self.Number1Shadow, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0Shadow:completeAnimation()
				self.Number0Shadow:setAlpha( 0 )
				self.clipFinished( self.Number0Shadow, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolZShadow:completeAnimation()
				self.SymbolZShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolZShadow, {} )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.SymbolCrossShadow:completeAnimation()
				self.SymbolCrossShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossShadow, {} )

				self.SymbolCross:completeAnimation()
				self.SymbolCross:setAlpha( 0 )
				self.clipFinished( self.SymbolCross, {} )
			end
		},

		Show4 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Number5Shadow:completeAnimation()
				self.Number5Shadow:setAlpha( 0 )
				self.clipFinished( self.Number5Shadow, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4Shadow:completeAnimation()
				self.Number4Shadow:setAlpha( 1 )
				self.clipFinished( self.Number4Shadow, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 1 )
				self.clipFinished( self.Number4, {} )

				self.Number3Shadow:completeAnimation()
				self.Number3Shadow:setAlpha( 0 )
				self.clipFinished( self.Number3Shadow, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2Shadow:completeAnimation()
				self.Number2Shadow:setAlpha( 0 )
				self.clipFinished( self.Number2Shadow, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1Shadow:completeAnimation()
				self.Number1Shadow:setAlpha( 0 )
				self.clipFinished( self.Number1Shadow, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0Shadow:completeAnimation()
				self.Number0Shadow:setAlpha( 0 )
				self.clipFinished( self.Number0Shadow, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolZShadow:completeAnimation()
				self.SymbolZShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolZShadow, {} )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.SymbolCrossShadow:completeAnimation()
				self.SymbolCrossShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossShadow, {} )

				self.SymbolCross:completeAnimation()
				self.SymbolCross:setAlpha( 0 )
				self.clipFinished( self.SymbolCross, {} )
			end
		},

		Show3 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Number5Shadow:completeAnimation()
				self.Number5Shadow:setAlpha( 0 )
				self.clipFinished( self.Number5Shadow, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4Shadow:completeAnimation()
				self.Number4Shadow:setAlpha( 0 )
				self.clipFinished( self.Number4Shadow, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3Shadow:completeAnimation()
				self.Number3Shadow:setAlpha( 1 )
				self.clipFinished( self.Number3Shadow, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 1 )
				self.clipFinished( self.Number3, {} )

				self.Number2Shadow:completeAnimation()
				self.Number2Shadow:setAlpha( 0 )
				self.clipFinished( self.Number2Shadow, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1Shadow:completeAnimation()
				self.Number1Shadow:setAlpha( 0 )
				self.clipFinished( self.Number1Shadow, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0Shadow:completeAnimation()
				self.Number0Shadow:setAlpha( 0 )
				self.clipFinished( self.Number0Shadow, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolZShadow:completeAnimation()
				self.SymbolZShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolZShadow, {} )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.SymbolCrossShadow:completeAnimation()
				self.SymbolCrossShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossShadow, {} )

				self.SymbolCross:completeAnimation()
				self.SymbolCross:setAlpha( 0 )
				self.clipFinished( self.SymbolCross, {} )
			end
		},

		Show2 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Number5Shadow:completeAnimation()
				self.Number5Shadow:setAlpha( 0 )
				self.clipFinished( self.Number5Shadow, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4Shadow:completeAnimation()
				self.Number4Shadow:setAlpha( 0 )
				self.clipFinished( self.Number4Shadow, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3Shadow:completeAnimation()
				self.Number3Shadow:setAlpha( 0 )
				self.clipFinished( self.Number3Shadow, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2Shadow:completeAnimation()
				self.Number2Shadow:setAlpha( 1 )
				self.clipFinished( self.Number2Shadow, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 1 )
				self.clipFinished( self.Number2, {} )

				self.Number1Shadow:completeAnimation()
				self.Number1Shadow:setAlpha( 0 )
				self.clipFinished( self.Number1Shadow, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0Shadow:completeAnimation()
				self.Number0Shadow:setAlpha( 0 )
				self.clipFinished( self.Number0Shadow, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolZShadow:completeAnimation()
				self.SymbolZShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolZShadow, {} )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.SymbolCrossShadow:completeAnimation()
				self.SymbolCrossShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossShadow, {} )

				self.SymbolCross:completeAnimation()
				self.SymbolCross:setAlpha( 0 )
				self.clipFinished( self.SymbolCross, {} )
			end
		},

		Show1 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Number5Shadow:completeAnimation()
				self.Number5Shadow:setAlpha( 0 )
				self.clipFinished( self.Number5Shadow, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4Shadow:completeAnimation()
				self.Number4Shadow:setAlpha( 0 )
				self.clipFinished( self.Number4Shadow, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3Shadow:completeAnimation()
				self.Number3Shadow:setAlpha( 0 )
				self.clipFinished( self.Number3Shadow, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2Shadow:completeAnimation()
				self.Number2Shadow:setAlpha( 0 )
				self.clipFinished( self.Number2Shadow, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1Shadow:completeAnimation()
				self.Number1Shadow:setAlpha( 1 )
				self.clipFinished( self.Number1Shadow, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 1 )
				self.clipFinished( self.Number1, {} )

				self.Number0Shadow:completeAnimation()
				self.Number0Shadow:setAlpha( 0 )
				self.clipFinished( self.Number0Shadow, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolZShadow:completeAnimation()
				self.SymbolZShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolZShadow, {} )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.SymbolCrossShadow:completeAnimation()
				self.SymbolCrossShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossShadow, {} )

				self.SymbolCross:completeAnimation()
				self.SymbolCross:setAlpha( 0 )
				self.clipFinished( self.SymbolCross, {} )
			end
		},

		Show0 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Number5Shadow:completeAnimation()
				self.Number5Shadow:setAlpha( 0 )
				self.clipFinished( self.Number5Shadow, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4Shadow:completeAnimation()
				self.Number4Shadow:setAlpha( 0 )
				self.clipFinished( self.Number4Shadow, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3Shadow:completeAnimation()
				self.Number3Shadow:setAlpha( 0 )
				self.clipFinished( self.Number3Shadow, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2Shadow:completeAnimation()
				self.Number2Shadow:setAlpha( 0 )
				self.clipFinished( self.Number2Shadow, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1Shadow:completeAnimation()
				self.Number1Shadow:setAlpha( 0 )
				self.clipFinished( self.Number1Shadow, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0Shadow:completeAnimation()
				self.Number0Shadow:setAlpha( 1 )
				self.clipFinished( self.Number0Shadow, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 1 )
				self.clipFinished( self.Number0, {} )

				self.SymbolZShadow:completeAnimation()
				self.SymbolZShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolZShadow, {} )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.SymbolCrossShadow:completeAnimation()
				self.SymbolCrossShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossShadow, {} )

				self.SymbolCross:completeAnimation()
				self.SymbolCross:setAlpha( 0 )
				self.clipFinished( self.SymbolCross, {} )
			end
		},

		Hidden = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Number5Shadow:completeAnimation()
				self.Number5Shadow:setAlpha( 0 )
				self.clipFinished( self.Number5Shadow, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4Shadow:completeAnimation()
				self.Number4Shadow:setAlpha( 0 )
				self.clipFinished( self.Number4Shadow, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3Shadow:completeAnimation()
				self.Number3Shadow:setAlpha( 0 )
				self.clipFinished( self.Number3Shadow, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2Shadow:completeAnimation()
				self.Number2Shadow:setAlpha( 0 )
				self.clipFinished( self.Number2Shadow, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1Shadow:completeAnimation()
				self.Number1Shadow:setAlpha( 0 )
				self.clipFinished( self.Number1Shadow, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0Shadow:completeAnimation()
				self.Number0Shadow:setAlpha( 0 )
				self.clipFinished( self.Number0Shadow, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolZShadow:completeAnimation()
				self.SymbolZShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolZShadow, {} )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.SymbolCrossShadow:completeAnimation()
				self.SymbolCrossShadow:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossShadow, {} )

				self.SymbolCross:completeAnimation()
				self.SymbolCross:setAlpha( 0 )
				self.clipFinished( self.SymbolCross, {} )
			end
		}
	}
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end