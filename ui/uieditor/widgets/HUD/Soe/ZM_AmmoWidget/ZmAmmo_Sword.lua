CoD.ZmAmmo_Sword = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_Sword.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_Sword )
	self.id = "ZmAmmo_Sword"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 128 )
	self:setTopBottom( true, false, 0, 32 )
	
	self.Sword0 = LUI.UIImage.new()
	self.Sword0:setLeftRight( true, false, -12, 140 )
	self.Sword0:setTopBottom( true, false, -12, 44 )
	CoD.UIColors.SetElementColor( self.Sword0, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.Sword0:setAlpha( 0.47 )
	self.Sword0:setScale( 0.8 )
	self.Sword0:setImage( RegisterImage( "uie_t7_zm_hud_ammo_swordback" ) )
	self:addElement( self.Sword0 )
	
	self.Sword = LUI.UIImage.new()
	self.Sword:setLeftRight( true, false, 0, 128 )
	self.Sword:setTopBottom( true, false, 0, 32 )
	self.Sword:setRGB( 1, 0.99, 0.93 )
	self.Sword:setScale( 0.8 )
	self.Sword:setImage( RegisterImage( "uie_t7_zm_hud_ammo_sword" ) )
	self:addElement( self.Sword )
	
	self.ClipGlow = LUI.UIImage.new()
	self.ClipGlow:setLeftRight( true, false, -38.39, 171.39 )
	self.ClipGlow:setTopBottom( true, false, -27.25, 59.25 )
	CoD.UIColors.SetElementColor( self.ClipGlow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.ClipGlow:setAlpha( 0.42 )
	self.ClipGlow:setZRot( -4 )
	self.ClipGlow:setScale( 0.9 )
	self.ClipGlow:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.ClipGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ClipGlow )
	
	self.ClipGlowTop = LUI.UIImage.new()
	self.ClipGlowTop:setLeftRight( true, false, -31.1, 164.1 )
	self.ClipGlowTop:setTopBottom( true, false, -15.5, 47.5 )
	CoD.UIColors.SetElementColor( self.ClipGlowTop, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.ClipGlowTop:setAlpha( 0.25 )
	self.ClipGlowTop:setZRot( -4 )
	self.ClipGlowTop:setScale( 0.9 )
	self.ClipGlowTop:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self:addElement( self.ClipGlowTop )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end