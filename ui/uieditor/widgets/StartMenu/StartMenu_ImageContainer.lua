local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        CoD.UIColors.SetElementColor( self.ImageContainer, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.StartMenu_ImageContainer = InheritFrom( LUI.UIElement )
CoD.StartMenu_ImageContainer.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_ImageContainer )
	self.id = "StartMenu_ImageContainer"
	self.soundSet = "ChooseDecal"
	self:setLeftRight( true, false, 0, 297 )
	self:setTopBottom( true, false, 0, 137 )
	
	self.ImageContainer = LUI.UIImage.new()
	self.ImageContainer:setLeftRight( true, true, 0, 0 )
	self.ImageContainer:setTopBottom( true, true, 0, 0 )
    self.ImageContainer:setRGB( 0, 1, 0 )
	self:addElement( self.ImageContainer )
	
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