local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        local elements = { self.p1, self.p2, self.p3 }
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

CoD.ZmAmmo_ParticleFX = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_ParticleFX.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_ParticleFX )
	self.id = "ZmAmmo_ParticleFX"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 143 )
	self:setTopBottom( true, false, 0, 75 )
	
	self.p1 = LUI.UIImage.new()
	self.p1:setLeftRight( true, false, 0, 143.48 )
	self.p1:setTopBottom( true, false, 0, 74.61 )
	self.p1:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_projection_p1" ) )
	self.p1:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_tile_scroll_normal" ) )
	self.p1:setShaderVector( 0, 1, 1, 0, 0 )
	self.p1:setShaderVector( 1, 0.05, 0, 0, 0 )
	self:addElement( self.p1 )
	
	self.p2 = LUI.UIImage.new()
	self.p2:setLeftRight( true, false, 0, 143.48 )
	self.p2:setTopBottom( true, false, 0, 74.61 )
	self.p2:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_projection_p2" ) )
	self.p2:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_tile_scroll_normal" ) )
	self.p2:setShaderVector( 0, 1, 1, 0, 0 )
	self.p2:setShaderVector( 1, 0.3, 0, 0, 0 )
	self:addElement( self.p2 )
	
	self.p3 = LUI.UIImage.new()
	self.p3:setLeftRight( true, false, 0, 143.48 )
	self.p3:setTopBottom( true, false, 0, 74.61 )
	self.p3:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_projection_p3" ) )
	self.p3:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_tile_scroll_normal" ) )
	self.p3:setShaderVector( 0, 1, 1, 0, 0 )
	self.p3:setShaderVector( 1, 0.7, 0, 0, 0 )
	self:addElement( self.p3 )
	
	self.mask = LUI.UIImage.new()
	self.mask:setLeftRight( true, false, 0, 143 )
	self.mask:setTopBottom( true, false, 0, 74.61 )
	self.mask:setRGB( 0, 0, 0 )
	self.mask:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_projection_mask" ) )
	self:addElement( self.mask )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 0 )
			end
		}
	}
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end