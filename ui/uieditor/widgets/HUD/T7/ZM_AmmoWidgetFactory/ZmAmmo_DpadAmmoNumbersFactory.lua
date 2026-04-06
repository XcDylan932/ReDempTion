CoD.ZmAmmo_DpadAmmoNumbersFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadAmmoNumbersFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadAmmoNumbersFactory )
	self.id = "ZmAmmo_DpadAmmoNumbersFactory"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 18 )
	self:setTopBottom( true, false, 0, 18 )
	
	self.SymbolZ = LUI.UIImage.new()
	self.SymbolZ:setLeftRight( true, false, -14, 18 )
	self.SymbolZ:setTopBottom( true, false, -19, 36 )
	self.SymbolZ:setAlpha( 0 )
	self.SymbolZ:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_z_blue" ) )
	self.SymbolZ:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.SymbolZ )
	
	self.Number5 = LUI.UIImage.new()
	self.Number5:setLeftRight( true, false, -26, 31 )
	self.Number5:setTopBottom( true, false, -20, 36 )
	self.Number5:setAlpha( 0 )
	self.Number5:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_number5" ) )
	self.Number5:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number5 )
	
	self.Number4 = LUI.UIImage.new()
	self.Number4:setLeftRight( true, false, -26, 31 )
	self.Number4:setTopBottom( true, false, -20, 36 )
	self.Number4:setAlpha( 0 )
	self.Number4:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_number4" ) )
	self.Number4:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number4 )
	
	self.Number3 = LUI.UIImage.new()
	self.Number3:setLeftRight( true, false, -26, 31 )
	self.Number3:setTopBottom( true, false, -20, 36 )
	self.Number3:setAlpha( 0 )
	self.Number3:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_number3" ) )
	self.Number3:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number3 )
	
	self.Number2 = LUI.UIImage.new()
	self.Number2:setLeftRight( true, false, -26, 31 )
	self.Number2:setTopBottom( true, false, -20, 36 )
	self.Number2:setAlpha( 0 )
	self.Number2:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_number2" ) )
	self.Number2:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number2 )
	
	self.Number1 = LUI.UIImage.new()
	self.Number1:setLeftRight( true, false, -26, 31 )
	self.Number1:setTopBottom( true, false, -20, 36 )
	self.Number1:setAlpha( 0 )
	self.Number1:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_number1" ) )
	self.Number1:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number1 )
	
	self.Number0 = LUI.UIImage.new()
	self.Number0:setLeftRight( true, false, -26, 31 )
	self.Number0:setTopBottom( true, false, -20, 36 )
	self.Number0:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_number0" ) )
	self:addElement( self.Number0 )
	
	self.SymbolCrossBlue = LUI.UIImage.new()
	self.SymbolCrossBlue:setLeftRight( true, false, -26, 31 )
	self.SymbolCrossBlue:setTopBottom( true, false, -20, 37 )
	self.SymbolCrossBlue:setAlpha( 0 )
	self.SymbolCrossBlue:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_emptycross" ) )
	self.SymbolCrossBlue:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.SymbolCrossBlue )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolCrossBlue:completeAnimation()
				self.SymbolCrossBlue:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossBlue, {} )
			end
		},

		ShowZ = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 1 )
				self.clipFinished( self.SymbolZ, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolCrossBlue:completeAnimation()
				self.SymbolCrossBlue:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossBlue, {} )
			end
		},
		ShowCross = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolCrossBlue:completeAnimation()
				self.SymbolCrossBlue:setAlpha( 1 )
				self.clipFinished( self.SymbolCrossBlue, {} )
			end
		},

		Show5 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 1 )
				self.clipFinished( self.Number5, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolCrossBlue:completeAnimation()
				self.SymbolCrossBlue:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossBlue, {} )
			end
		},

		Show4 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 1 )
				self.clipFinished( self.Number4, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolCrossBlue:completeAnimation()
				self.SymbolCrossBlue:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossBlue, {} )
			end
		},

		Show3 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 1 )
				self.clipFinished( self.Number3, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolCrossBlue:completeAnimation()
				self.SymbolCrossBlue:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossBlue, {} )
			end
		},

		Show2 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 1 )
				self.clipFinished( self.Number2, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolCrossBlue:completeAnimation()
				self.SymbolCrossBlue:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossBlue, {} )
			end
		},

		Show1 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 1 )
				self.clipFinished( self.Number1, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolCrossBlue:completeAnimation()
				self.SymbolCrossBlue:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossBlue, {} )
			end
		},

		Show0 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 1 )
				self.clipFinished( self.Number0, {} )

				self.SymbolCrossBlue:completeAnimation()
				self.SymbolCrossBlue:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossBlue, {} )
			end
		},

		Hidden = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.SymbolZ:completeAnimation()
				self.SymbolZ:setAlpha( 0 )
				self.clipFinished( self.SymbolZ, {} )

				self.Number5:completeAnimation()
				self.Number5:setAlpha( 0 )
				self.clipFinished( self.Number5, {} )

				self.Number4:completeAnimation()
				self.Number4:setAlpha( 0 )
				self.clipFinished( self.Number4, {} )

				self.Number3:completeAnimation()
				self.Number3:setAlpha( 0 )
				self.clipFinished( self.Number3, {} )

				self.Number2:completeAnimation()
				self.Number2:setAlpha( 0 )
				self.clipFinished( self.Number2, {} )

				self.Number1:completeAnimation()
				self.Number1:setAlpha( 0 )
				self.clipFinished( self.Number1, {} )

				self.Number0:completeAnimation()
				self.Number0:setAlpha( 0 )
				self.clipFinished( self.Number0, {} )

				self.SymbolCrossBlue:completeAnimation()
				self.SymbolCrossBlue:setAlpha( 0 )
				self.clipFinished( self.SymbolCrossBlue, {} )
			end
		}
	}
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end