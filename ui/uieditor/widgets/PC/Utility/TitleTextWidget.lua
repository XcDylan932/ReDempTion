require( "ui.uieditor.widgets.CAC.cac_ItemTitleGlow" )

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
	    local color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]
	    CoD.UIColors.SetElementColor( self.titleGlow, color )
	end

	local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
	self:subscribeToModel( colorUpdateModel, function( model )
	    self:UpdateColors()
	end )

	self:UpdateColors()
end

CoD.TitleTextWidget = InheritFrom( LUI.UIElement )
CoD.TitleTextWidget.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.TitleTextWidget )
	self.id = "TitleTextWidget"
	self.soundSet = "CAC_EditLoadout"
	self:setLeftRight( true, false, 0, 400 )
	self:setTopBottom( true, false, 0, 34 )
	
	self.titleGlow = CoD.cac_ItemTitleGlow.new( menu, controller )
	self.titleGlow:setLeftRight( true, true, -2, 3 )
	self.titleGlow:setTopBottom( true, true, -3, 3 )
	self.titleGlow:setRGB( 0.9, 0.9, 0.9 )
	self:addElement( self.titleGlow )
	
	self.itemName = LUI.UITightText.new()
	self.itemName:setLeftRight( true, false, 3, 72.8 )
	self.itemName:setTopBottom( false, false, -15, 17 )
	self.itemName:setRGB( 0, 0, 0 )
	self.itemName:setText( Engine.Localize( "MENU_NEW" ) )
	self.itemName:setTTF( "fonts/escom.ttf" )
	self.itemName:setMaterial( LUI.UIImage.GetCachedMaterial( "sw4_2d_uie_font_cached_glow" ) )
	self.itemName:setShaderVector( 0, 0.06, 0, 0, 0 )
	self.itemName:setShaderVector( 1, 0.02, 0, 0, 0 )
	self.itemName:setShaderVector( 2, 1, 0, 0, 0 )
	self.itemName:setLetterSpacing( 0.6 )

	LUI.OverrideFunction_CallOriginalFirst( self.itemName, "setText", function ( element, controller )
		ScaleWidgetToLabel( self, element, 5 )
	end )
	self:addElement( self.itemName )
	
	self.Glow = LUI.UIImage.new()
	self.Glow:setLeftRight( true, true, -52.93, 49.07 )
	self.Glow:setTopBottom( false, false, -30, 43 )
	self.Glow:setAlpha( 0.14 )
	self.Glow:setImage( RegisterImage( "uie_t7_menu_cac_glow" ) )
	self.Glow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Glow )
	
	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.titleGlow:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end