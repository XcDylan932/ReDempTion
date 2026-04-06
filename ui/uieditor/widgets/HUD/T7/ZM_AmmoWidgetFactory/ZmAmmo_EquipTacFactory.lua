local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        local elements = { self.Tactical0, self.Tactical1, self.Tactical2, self.Tactical3 }
        for _, element in ipairs( elements ) do
            if element then
                element:completeAnimation()
                element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
                CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
            end
        end
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_EquipTacFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_EquipTacFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_EquipTacFactory )
	self.id = "ZmAmmo_EquipTacFactory"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 37 )
	self:setTopBottom( true, false, 0, 32 )

	local color = CoD.UIColors.Colors["red"]
	
	self.Tactical0 = LUI.UIImage.new()
	self.Tactical0:setLeftRight( true, false, 13.75, 39.25 )
	self.Tactical0:setTopBottom( true, false, 1, 26.5 )
	self.Tactical0:setImage( RegisterImage( "uie_t7_zm_hud_inv_icntact" ) )
	self:addElement( self.Tactical0 )
	
	self.Tactical1b = LUI.UIImage.new()
	self.Tactical1b:setLeftRight( true, false, 9, 34.5 )
	self.Tactical1b:setTopBottom( true, false, 2, 27.5 )
	self.Tactical1b:setRGB( 0, 0, 0 )
	self.Tactical1b:setImage( RegisterImage( "uie_t7_zm_hud_inv_icntact" ) )
	self:addElement( self.Tactical1b )
	
	self.Tactical1 = LUI.UIImage.new()
	self.Tactical1:setLeftRight( true, false, 8, 33.5 )
	self.Tactical1:setTopBottom( true, false, 3, 28.5 )
	self.Tactical1:setImage( RegisterImage( "uie_t7_zm_hud_inv_icntact" ) )
	self:addElement( self.Tactical1 )
	
	self.Tactical2b = LUI.UIImage.new()
	self.Tactical2b:setLeftRight( true, false, 3, 28.5 )
	self.Tactical2b:setTopBottom( true, false, 4, 29.5 )
	self.Tactical2b:setRGB( 0, 0, 0 )
	self.Tactical2b:setImage( RegisterImage( "uie_t7_zm_hud_inv_icntact" ) )
	self:addElement( self.Tactical2b )
	
	self.Tactical2 = LUI.UIImage.new()
	self.Tactical2:setLeftRight( true, false, 2, 27.5 )
	self.Tactical2:setTopBottom( true, false, 5, 30.5 )
	self.Tactical2:setImage( RegisterImage( "uie_t7_zm_hud_inv_icntact" ) )
	self:addElement( self.Tactical2 )
	
	self.Tactical3b = LUI.UIImage.new()
	self.Tactical3b:setLeftRight( true, false, -3, 22.5 )
	self.Tactical3b:setTopBottom( true, false, 6, 31.5 )
	self.Tactical3b:setRGB( 0, 0, 0 )
	self.Tactical3b:setImage( RegisterImage( "uie_t7_zm_hud_inv_icntact" ) )
	self:addElement( self.Tactical3b )
	
	self.Tactical3 = LUI.UIImage.new()
	self.Tactical3:setLeftRight( true, false, -4, 21.5 )
	self.Tactical3:setTopBottom( true, false, 7, 32.5 )
	self.Tactical3:setRGB( color.r, color.g, color.b )
	self.Tactical3:setImage( RegisterImage( "uie_t7_zm_hud_inv_icntact" ) )
	self:addElement( self.Tactical3 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.Tactical0:completeAnimation()
				self.Tactical0:setLeftRight( true, false, 13.75, 39.25 )
				self.Tactical0:setTopBottom( true, false, 1, 26.5 )
				self.Tactical0:setAlpha( 0 )
				self.clipFinished( self.Tactical0, {} )

				self.Tactical1b:completeAnimation()
				self.Tactical1b:setLeftRight( true, false, 9, 34.5 )
				self.Tactical1b:setTopBottom( true, false, 2, 27.5 )
				self.Tactical1b:setAlpha( 0 )
				self.clipFinished( self.Tactical1b, {} )

				self.Tactical1:completeAnimation()
				self.Tactical1:setLeftRight( true, false, 8, 33.5 )
				self.Tactical1:setTopBottom( true, false, 3, 28.5 )
				self.Tactical1:setAlpha( 0 )
				self.clipFinished( self.Tactical1, {} )

				self.Tactical2b:completeAnimation()
				self.Tactical2b:setLeftRight( true, false, 3, 28.5 )
				self.Tactical2b:setTopBottom( true, false, 4, 29.5 )
				self.Tactical2b:setAlpha( 0 )
				self.clipFinished( self.Tactical2b, {} )

				self.Tactical2:completeAnimation()
				self.Tactical2:setLeftRight( true, false, 2, 27.5 )
				self.Tactical2:setTopBottom( true, false, 5, 30.5 )
				self.Tactical2:setAlpha( 0 )
				self.clipFinished( self.Tactical2, {} )

				self.Tactical3b:completeAnimation()
				self.Tactical3b:setLeftRight( true, false, -3, 22.5 )
				self.Tactical3b:setTopBottom( true, false, 6, 31.5 )
				self.Tactical3b:setAlpha( 0 )
				self.clipFinished( self.Tactical3b, {} )

				self.Tactical3:completeAnimation()
				self.Tactical3:setLeftRight( true, false, -4, 21.5 )
				self.Tactical3:setTopBottom( true, false, 7, 32.5 )
				self.Tactical3:setAlpha( 0 )
				self.clipFinished( self.Tactical3, {} )
			end
		},

		Single = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.Tactical0:completeAnimation()
				self.Tactical0:setLeftRight( true, false, -4, 21.5 )
				self.Tactical0:setTopBottom( true, false, 7, 32.5 )
				self.Tactical0:setAlpha( 1 )
				self.clipFinished( self.Tactical0, {} )

				self.Tactical1b:completeAnimation()
				self.Tactical1b:setLeftRight( true, false, -9, 16.5 )
				self.Tactical1b:setTopBottom( true, false, 8, 33.5 )
				self.Tactical1b:setAlpha( 0 )
				self.clipFinished( self.Tactical1b, {} )

				self.Tactical1:completeAnimation()
				self.Tactical1:setLeftRight( true, false, -10, 15.5 )
				self.Tactical1:setTopBottom( true, false, 9, 34.5 )
				self.Tactical1:setRGB( 1, 0.62, 0.11 )
				self.Tactical1:setAlpha( 0 )
				self.clipFinished( self.Tactical1, {} )

				self.Tactical2b:completeAnimation()
				self.Tactical2b:setLeftRight( true, false, -15, 10.5 )
				self.Tactical2b:setTopBottom( true, false, 10, 35.5 )
				self.Tactical2b:setAlpha( 0 )
				self.clipFinished( self.Tactical2b, {} )

				self.Tactical2:completeAnimation()
				self.Tactical2:setLeftRight( true, false, -16, 9.5 )
				self.Tactical2:setTopBottom( true, false, 11, 36.5 )
				self.Tactical2:setAlpha( 0 )
				self.clipFinished( self.Tactical2, {} )

				self.Tactical3b:completeAnimation()
				self.Tactical3b:setLeftRight( true, false, -21, 4.5 )
				self.Tactical3b:setTopBottom( true, false, 12, 37.5 )
				self.Tactical3b:setAlpha( 0 )
				self.clipFinished( self.Tactical3b, {} )

				self.Tactical3:completeAnimation()
				self.Tactical3:setLeftRight( true, false, -22, 3.5 )
				self.Tactical3:setTopBottom( true, false, 13, 38.5 )
				self.Tactical3:setAlpha( 0 )
				self.clipFinished( self.Tactical3, {} )
			end
		},

		Double = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.Tactical0:completeAnimation()
				self.Tactical0:setLeftRight( true, false, 1.75, 27.25 )
				self.Tactical0:setTopBottom( true, false, 5, 30.5 )
				self.Tactical0:setAlpha( 1 )
				self.clipFinished( self.Tactical0, {} )

				self.Tactical1b:completeAnimation()
				self.Tactical1b:setLeftRight( true, false, -3, 22.5 )
				self.Tactical1b:setTopBottom( true, false, 6, 31.5 )
				self.Tactical1b:setAlpha( 1 )
				self.clipFinished( self.Tactical1b, {} )

				self.Tactical1:completeAnimation()
				self.Tactical1:setLeftRight( true, false, -4, 21.5 )
				self.Tactical1:setTopBottom( true, false, 7, 32.5 )
				self.Tactical1:setAlpha( 1 )
				self.clipFinished( self.Tactical1, {} )

				self.Tactical2b:completeAnimation()
				self.Tactical2b:setLeftRight( true, false, -9, 16.5 )
				self.Tactical2b:setTopBottom( true, false, 8, 33.5 )
				self.Tactical2b:setAlpha( 0 )
				self.clipFinished( self.Tactical2b, {} )

				self.Tactical2:completeAnimation()
				self.Tactical2:setLeftRight( true, false, -10, 15.5 )
				self.Tactical2:setTopBottom( true, false, 9, 34.5 )
				self.Tactical2:setAlpha( 0 )
				self.clipFinished( self.Tactical2, {} )

				self.Tactical3b:completeAnimation()
				self.Tactical3b:setLeftRight( true, false, -15, 10.5 )
				self.Tactical3b:setTopBottom( true, false, 10, 35.5 )
				self.Tactical3b:setAlpha( 0 )
				self.clipFinished( self.Tactical3b, {} )

				self.Tactical3:completeAnimation()
				self.Tactical3:setLeftRight( true, false, -16, 9.5 )
				self.Tactical3:setTopBottom( true, false, 11, 36.5 )
				self.Tactical3:setAlpha( 0 )
				self.clipFinished( self.Tactical3, {} )
			end
		},

		Triple = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.Tactical0:completeAnimation()
				self.Tactical0:setLeftRight( true, false, 7.75, 33.25 )
				self.Tactical0:setTopBottom( true, false, 3, 28.5 )
				self.Tactical0:setAlpha( 1 )
				self.clipFinished( self.Tactical0, {} )

				self.Tactical1b:completeAnimation()
				self.Tactical1b:setLeftRight( true, false, 3, 28.5 )
				self.Tactical1b:setTopBottom( true, false, 4, 29.5 )
				self.Tactical1b:setAlpha( 1 )
				self.clipFinished( self.Tactical1b, {} )

				self.Tactical1:completeAnimation()
				self.Tactical1:setLeftRight( true, false, 2, 27.5 )
				self.Tactical1:setTopBottom( true, false, 5, 30.5 )
				self.Tactical1:setAlpha( 1 )
				self.clipFinished( self.Tactical1, {} )

				self.Tactical2b:completeAnimation()
				self.Tactical2b:setLeftRight( true, false, -3, 22.5 )
				self.Tactical2b:setTopBottom( true, false, 6, 31.5 )
				self.Tactical2b:setAlpha( 1 )
				self.clipFinished( self.Tactical2b, {} )

				self.Tactical2:completeAnimation()
				self.Tactical2:setLeftRight( true, false, -4, 21.5 )
				self.Tactical2:setTopBottom( true, false, 7, 32.5 )
				self.Tactical2:setAlpha( 1 )
				self.clipFinished( self.Tactical2, {} )

				self.Tactical3b:completeAnimation()
				self.Tactical3b:setLeftRight( true, false, -9, 16.5 )
				self.Tactical3b:setTopBottom( true, false, 8, 33.5 )
				self.Tactical3b:setAlpha( 0 )
				self.clipFinished( self.Tactical3b, {} )

				self.Tactical3:completeAnimation()
				self.Tactical3:setLeftRight( true, false, -10, 15.5 )
				self.Tactical3:setTopBottom( true, false, 9, 34.5 )
				self.Tactical3:setAlpha( 0 )
				self.clipFinished( self.Tactical3, {} )
			end
		},

		Quad = {
			DefaultClip = function ()
				self:setupElementClipCounter( 7 )

				self.Tactical0:completeAnimation()
				self.Tactical0:setLeftRight( true, false, 13.75, 39.25 )
				self.Tactical0:setTopBottom( true, false, 1, 26.5 )
				self.Tactical0:setAlpha( 1 )
				self.clipFinished( self.Tactical0, {} )

				self.Tactical1b:completeAnimation()
				self.Tactical1b:setLeftRight( true, false, 9, 34.5 )
				self.Tactical1b:setTopBottom( true, false, 2, 27.5 )
				self.Tactical1b:setAlpha( 1 )
				self.clipFinished( self.Tactical1b, {} )

				self.Tactical1:completeAnimation()
				self.Tactical1:setLeftRight( true, false, 8, 33.5 )
				self.Tactical1:setTopBottom( true, false, 3, 28.5 )
				self.Tactical1:setAlpha( 1 )
				self.clipFinished( self.Tactical1, {} )

				self.Tactical2b:completeAnimation()
				self.Tactical2b:setLeftRight( true, false, 3, 28.5 )
				self.Tactical2b:setTopBottom( true, false, 4, 29.5 )
				self.Tactical2b:setAlpha( 1 )
				self.clipFinished( self.Tactical2b, {} )

				self.Tactical2:completeAnimation()
				self.Tactical2:setLeftRight( true, false, 2, 27.5 )
				self.Tactical2:setTopBottom( true, false, 5, 30.5 )
				self.Tactical2:setAlpha( 1 )
				self.clipFinished( self.Tactical2, {} )

				self.Tactical3b:completeAnimation()
				self.Tactical3b:setLeftRight( true, false, -3, 22.5 )
				self.Tactical3b:setTopBottom( true, false, 6, 31.5 )
				self.Tactical3b:setAlpha( 1 )
				self.clipFinished( self.Tactical3b, {} )

				self.Tactical3:completeAnimation()
				self.Tactical3:setLeftRight( true, false, -4, 21.5 )
				self.Tactical3:setTopBottom( true, false, 7, 32.5 )
				self.Tactical3:setAlpha( 1 )
				self.clipFinished( self.Tactical3, {} )
			end
		}
	}
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end