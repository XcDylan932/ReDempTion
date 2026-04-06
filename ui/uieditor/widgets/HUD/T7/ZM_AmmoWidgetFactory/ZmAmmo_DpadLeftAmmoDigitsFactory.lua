CoD.ZmAmmo_DpadLeftAmmoDigitsFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_DpadLeftAmmoDigitsFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_DpadLeftAmmoDigitsFactory )
	self.id = "ZmAmmo_DpadLeftAmmoDigitsFactory"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 12 )
	self:setTopBottom( true, false, 0, 18 )
	
	self.Number9 = LUI.UIImage.new()
	self.Number9:setLeftRight( true, false, -15, 26 )
	self.Number9:setTopBottom( true, false, -10, 29 )
	self.Number9:setAlpha( 0 )
	self.Number9:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_noglow_number9" ) )
	self.Number9:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number9 )
	
	self.Number8 = LUI.UIImage.new()
	self.Number8:setLeftRight( true, false, -15, 26 )
	self.Number8:setTopBottom( true, false, -10, 29 )
	self.Number8:setAlpha( 0 )
	self.Number8:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_noglow_number8" ) )
	self.Number8:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number8 )
	
	self.Number7 = LUI.UIImage.new()
	self.Number7:setLeftRight( true, false, -15, 26 )
	self.Number7:setTopBottom( true, false, -10, 29 )
	self.Number7:setAlpha( 0 )
	self.Number7:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_noglow_number7" ) )
	self.Number7:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number7 )
	
	self.Number6 = LUI.UIImage.new()
	self.Number6:setLeftRight( true, false, -15, 26 )
	self.Number6:setTopBottom( true, false, -10, 29 )
	self.Number6:setAlpha( 0 )
	self.Number6:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_noglow_number6" ) )
	self.Number6:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number6 )
	
	self.Number5 = LUI.UIImage.new()
	self.Number5:setLeftRight( true, false, -15, 26 )
	self.Number5:setTopBottom( true, false, -10, 29 )
	self.Number5:setAlpha( 0 )
	self.Number5:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_noglow_number5" ) )
	self.Number5:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number5 )
	
	self.Number4 = LUI.UIImage.new()
	self.Number4:setLeftRight( true, false, -15, 26 )
	self.Number4:setTopBottom( true, false, -10, 29 )
	self.Number4:setAlpha( 0 )
	self.Number4:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_noglow_number4" ) )
	self.Number4:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number4 )
	
	self.Number3 = LUI.UIImage.new()
	self.Number3:setLeftRight( true, false, -15, 26 )
	self.Number3:setTopBottom( true, false, -10, 29 )
	self.Number3:setAlpha( 0 )
	self.Number3:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_noglow_number3" ) )
	self.Number3:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number3 )
	
	self.Number2 = LUI.UIImage.new()
	self.Number2:setLeftRight( true, false, -15, 26 )
	self.Number2:setTopBottom( true, false, -10, 29 )
	self.Number2:setAlpha( 0 )
	self.Number2:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_noglow_number2" ) )
	self.Number2:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number2 )
	
	self.Number1 = LUI.UIImage.new()
	self.Number1:setLeftRight( true, false, -15, 26 )
	self.Number1:setTopBottom( true, false, -10, 29 )
	self.Number1:setAlpha( 0 )
	self.Number1:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_noglow_number1" ) )
	self.Number1:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Number1 )
	
	self.Number0 = LUI.UIImage.new()
	self.Number0:setLeftRight( true, false, -15, 26 )
	self.Number0:setTopBottom( true, false, -10, 29 )
	self.Number0:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_noglow_number0" ) )
	self:addElement( self.Number0 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.Number9:completeAnimation()
				self.Number9:setAlpha( 0 )
				self.clipFinished( self.Number9, {} )

				self.Number8:completeAnimation()
				self.Number8:setAlpha( 0 )
				self.clipFinished( self.Number8, {} )

				self.Number7:completeAnimation()
				self.Number7:setAlpha( 0 )
				self.clipFinished( self.Number7, {} )

				self.Number6:completeAnimation()
				self.Number6:setAlpha( 0 )
				self.clipFinished( self.Number6, {} )

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
			end
		},

		Show9 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.Number9:completeAnimation()
				self.Number9:setAlpha( 1 )
				self.clipFinished( self.Number9, {} )

				self.Number8:completeAnimation()
				self.Number8:setAlpha( 0 )
				self.clipFinished( self.Number8, {} )

				self.Number7:completeAnimation()
				self.Number7:setAlpha( 0 )
				self.clipFinished( self.Number7, {} )

				self.Number6:completeAnimation()
				self.Number6:setAlpha( 0 )
				self.clipFinished( self.Number6, {} )

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
			end
		},

		Show8 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.Number9:completeAnimation()
				self.Number9:setAlpha( 0 )
				self.clipFinished( self.Number9, {} )

				self.Number8:completeAnimation()
				self.Number8:setAlpha( 1 )
				self.clipFinished( self.Number8, {} )

				self.Number7:completeAnimation()
				self.Number7:setAlpha( 0 )
				self.clipFinished( self.Number7, {} )

				self.Number6:completeAnimation()
				self.Number6:setAlpha( 0 )
				self.clipFinished( self.Number6, {} )

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
			end
		},

		Show7 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.Number9:completeAnimation()
				self.Number9:setAlpha( 0 )
				self.clipFinished( self.Number9, {} )

				self.Number8:completeAnimation()
				self.Number8:setAlpha( 0 )
				self.clipFinished( self.Number8, {} )

				self.Number7:completeAnimation()
				self.Number7:setAlpha( 1 )
				self.clipFinished( self.Number7, {} )

				self.Number6:completeAnimation()
				self.Number6:setAlpha( 0 )
				self.clipFinished( self.Number6, {} )

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
			end
		},

		Show6 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.Number9:completeAnimation()
				self.Number9:setAlpha( 0 )
				self.clipFinished( self.Number9, {} )

				self.Number8:completeAnimation()
				self.Number8:setAlpha( 0 )
				self.clipFinished( self.Number8, {} )

				self.Number7:completeAnimation()
				self.Number7:setAlpha( 0 )
				self.clipFinished( self.Number7, {} )

				self.Number6:completeAnimation()
				self.Number6:setAlpha( 1 )
				self.clipFinished( self.Number6, {} )

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
			end
		},

		Show5 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.Number9:completeAnimation()
				self.Number9:setAlpha( 0 )
				self.clipFinished( self.Number9, {} )

				self.Number8:completeAnimation()
				self.Number8:setAlpha( 0 )
				self.clipFinished( self.Number8, {} )

				self.Number7:completeAnimation()
				self.Number7:setAlpha( 0 )
				self.clipFinished( self.Number7, {} )

				self.Number6:completeAnimation()
				self.Number6:setAlpha( 0 )
				self.clipFinished( self.Number6, {} )

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
			end
		},

		Show4 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.Number9:completeAnimation()
				self.Number9:setAlpha( 0 )
				self.clipFinished( self.Number9, {} )

				self.Number8:completeAnimation()
				self.Number8:setAlpha( 0 )
				self.clipFinished( self.Number8, {} )

				self.Number7:completeAnimation()
				self.Number7:setAlpha( 0 )
				self.clipFinished( self.Number7, {} )

				self.Number6:completeAnimation()
				self.Number6:setAlpha( 0 )
				self.clipFinished( self.Number6, {} )

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
			end
		},

		Show3 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.Number9:completeAnimation()
				self.Number9:setAlpha( 0 )
				self.clipFinished( self.Number9, {} )

				self.Number8:completeAnimation()
				self.Number8:setAlpha( 0 )
				self.clipFinished( self.Number8, {} )

				self.Number7:completeAnimation()
				self.Number7:setAlpha( 0 )
				self.clipFinished( self.Number7, {} )

				self.Number6:completeAnimation()
				self.Number6:setAlpha( 0 )
				self.clipFinished( self.Number6, {} )

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
			end
		},

		Show2 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

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
			end
		},

		Show1 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.Number9:completeAnimation()
				self.Number9:setAlpha( 0 )
				self.clipFinished( self.Number9, {} )

				self.Number8:completeAnimation()
				self.Number8:setAlpha( 0 )
				self.clipFinished( self.Number8, {} )

				self.Number7:completeAnimation()
				self.Number7:setAlpha( 0 )
				self.clipFinished( self.Number7, {} )

				self.Number6:completeAnimation()
				self.Number6:setAlpha( 0 )
				self.clipFinished( self.Number6, {} )

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
			end
		},

		Show0 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

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
			end
		},

		Faded = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.Number9:completeAnimation()
				self.Number9:setAlpha( 0 )
				self.clipFinished( self.Number9, {} )

				self.Number8:completeAnimation()
				self.Number8:setAlpha( 0 )
				self.clipFinished( self.Number8, {} )

				self.Number7:completeAnimation()
				self.Number7:setAlpha( 0 )
				self.clipFinished( self.Number7, {} )

				self.Number6:completeAnimation()
				self.Number6:setAlpha( 0 )
				self.clipFinished( self.Number6, {} )

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
				self.Number0:setAlpha( 0.2 )
				self.clipFinished( self.Number0, {} )
			end
		},

		Hidden = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.Number9:completeAnimation()
				self.Number9:setAlpha( 0 )
				self.clipFinished( self.Number9, {} )

				self.Number8:completeAnimation()
				self.Number8:setAlpha( 0 )
				self.clipFinished( self.Number8, {} )

				self.Number7:completeAnimation()
				self.Number7:setAlpha( 0 )
				self.clipFinished( self.Number7, {} )

				self.Number6:completeAnimation()
				self.Number6:setAlpha( 0 )
				self.clipFinished( self.Number6, {} )

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
			end
		}
	}
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end