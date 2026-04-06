CoD.VerticalListSpacer = InheritFrom( LUI.UIElement )
CoD.VerticalListSpacer.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.VerticalListSpacer )
	self.id = "VerticalListSpacer"
	self.soundSet = "ChooseDecal"

	self:setLeftRight( true, false, 0, 500 )
	self:setTopBottom( true, false, 0, 34 )
	self:linkToElementModel( self, "height", true, function ( model )
		SetVerticaListSpacerHeight( self, model )
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end

local PostLoadFunc = function( self, controller, menu )
	self.UpdateColors = function( self )
        CoD.UIColors.SetElementColor( self.labelStroke, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.SettingsHeader = InheritFrom( LUI.UIElement )
CoD.SettingsHeader.new = function ( menu, controller )
    local self = LUI.UIElement.new()

    if PreLoadFunc then
    	PreLoadFunc( self, controller )
    end

    self:setUseStencil( false )
    self:setClass( CoD.SettingsHeader )
    self.id = "SettingsHeader"
    self.soundSet = "ChooseDecal"
    self:setLeftRight( true, false, 0, 500 )
    self:setTopBottom( true, false, 0, 40 )

    self.labelBG = LUI.UIImage.new()
    self.labelBG:setLeftRight( true, false, 2, 498 )
    self.labelBG:setTopBottom( true, false, 0, 40 )
    self.labelBG:setImage( RegisterImage( "$white" ) )
    self.labelBG:setRGB( 0, 0, 0 )
    self.labelBG:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.labelBG:setShaderVector( 0, 0.1, 0.5, 0.1, 0.5 )
    self:addElement( self.labelBG )

    self.label = LUI.UIText.new()
    self.label:setLeftRight( true, false, 5 + 1, 500 + 1 )
    self.label:setTopBottom( true, false, 5 + 0.5, 35 + 0.5 )
    self.label:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    self.label:setTTF( "fonts/ttmussels_demibold.ttf" )
    self.label:setLetterSpacing( 2 )
    self.label:setRGB( 0.66, 0.66, 0.66 )
    self.label:linkToElementModel( self, "label", true, function( model )
        local val = Engine.GetModelValue( model )
        if val then self.label:setText( Engine.Localize( val ) ) end
    end )
    self:addElement( self.label )

    self.labelStroke = LUI.UIText.new()
    self.labelStroke:setLeftRight( true, false, 5, 500 )
    self.labelStroke:setTopBottom( true, false, 5, 35 )
    self.labelStroke:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
    self.labelStroke:setTTF( "fonts/ttmussels_demibold.ttf" )
    self.labelStroke:setMaterial( LUI.UIImage.GetCachedMaterial( "sw4_2d_uie_font_cached_glow" ) )
	self.labelStroke:setShaderVector( 0, 0, 0, 0, 0 )
	self.labelStroke:setShaderVector( 1, 0, 0, 0, 0 )
	self.labelStroke:setShaderVector( 2, 1, 0, 0, 0 )
	self.labelStroke:setLetterSpacing( 2 )
    self.labelStroke:setRGB( 0, 0, 0 )
    self.labelStroke:linkToElementModel( self, "label", true, function( model )
        local val = Engine.GetModelValue( model )
        if val then self.labelStroke:setText( Engine.Localize( val ) ) end
    end )
    self:addElement( self.labelStroke )

    LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.labelBG:close()
		element.label:close()
		element.labelStroke:close()
	end )

	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end

    return self
end