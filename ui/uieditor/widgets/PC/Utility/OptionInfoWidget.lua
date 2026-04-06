require( "ui.uieditor.widgets.PC.Utility.TitleTextWidget" )

CoD.OptionInfoWidget = InheritFrom( LUI.UIElement )
CoD.OptionInfoWidget.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.OptionInfoWidget )
	self.id = "OptionInfoWidget"
	self.soundSet = "CAC_EditLoadout"
	self:setLeftRight( true, false, 0, 400 )
	self:setTopBottom( true, false, 0, 300 )
	self.anyChildUsesUpdateState = true
	
	self.description = LUI.UIText.new()
	self.description:setLeftRight( true, true, 10, 0 )
	self.description:setTopBottom( true, false, 45, 70 )
	self.description:setRGB( 0.74, 0.74, 0.74 )
	self.description:setText( Engine.Localize( "MENU_NEW" ) )
	self.description:setTTF( "fonts/default.ttf" )
	self.description:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.description:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )

	LUI.OverrideFunction_CallOriginalFirst( self.description, "setText", function ( element, controller )
		SetStateFromText( self, element, "DefaultState", "Hidden" )
	end )
	self:addElement( self.description )
	
	self.title = CoD.TitleTextWidget.new( menu, controller )
	self.title:setLeftRight( true, false, 0, 400 )
	self.title:setTopBottom( true, false, 0, 34 )
	self.title.itemName:setText( Engine.Localize( "MENU_NEW" ) )
	self:addElement( self.title )

	self.image = LUI.UIImage.new()
	self.image:setLeftRight( true, false, 0, 200 )
	self.image:setTopBottom( true, false, 80, 280 )
	self.image:setImage( RegisterImage( "blacktransparent" ) )
	self:addElement( self.image )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.description:completeAnimation()
				self.description:setAlpha( 1 )
				self.clipFinished( self.description, {} )

				self.title:completeAnimation()
				self.title:setAlpha( 1 )
				self.clipFinished( self.title, {} )

				self.image:completeAnimation()
				self.image:setAlpha( 1 )
				self.clipFinished( self.image, {} )
			end
		},

		Hidden = {
			DefaultClip = function ()
				self:setupElementClipCounter( 3 )

				self.description:completeAnimation()
				self.description:setAlpha( 0 )
				self.clipFinished( self.description, {} )

				self.title:completeAnimation()
				self.title:setAlpha( 0 )
				self.clipFinished( self.title, {} )

				self.image:completeAnimation()
				self.image:setAlpha( 0 )
				self.clipFinished( self.image, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.title:close()
		element.image:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end