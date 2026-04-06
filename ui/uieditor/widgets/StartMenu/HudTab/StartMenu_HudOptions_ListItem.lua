local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
    	local color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]
    	CoD.UIColors.SetElementColor( self.ImageGlow, "silver" )
    	CoD.UIColors.SetElementColor( self.NameGlow, color )
        CoD.UIColors.SetElementColor( self.Focus.BorderTop, color )
        CoD.UIColors.SetElementColor( self.Focus.BorderBottom, color )
        CoD.UIColors.SetElementColor( self.Focus.BorderLeft, color )
        CoD.UIColors.SetElementColor( self.Focus.BorderRight, color )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.StartMenu_HudOptions_ListItem = InheritFrom( LUI.UIElement )
CoD.StartMenu_HudOptions_ListItem.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_HudOptions_ListItem )
	self.id = "StartMenu_HudOptions_ListItem"
	self.soundSet = "default"
	self:setLeftRight( true, false, -213, 213 )
	self:setTopBottom( true, false, 0, 240 )
	self:makeFocusable()
	self:setHandleMouse( true )
	self.anyChildUsesUpdateState = true

	self.Image = LUI.UIImage.new()
	self.Image:setLeftRight( true, true, 2, -2 )
	self.Image:setTopBottom( true, true, 2, -2 )
	self.Image:setImage( RegisterImage( "blacktransparent" ) )
	self.Image:linkToElementModel( self, "image", true, function( model )
		local image = Engine.GetModelValue( model )
		if image then
			self.Image:setImage( RegisterImage( image ) )
		end
	end )
	self:addElement( self.Image )

	self.ImageGlow = LUI.UIImage.new()
	self.ImageGlow:setLeftRight( true, true, 0, 0 )
	self.ImageGlow:setTopBottom( true, true, 0, 0 )
	self.ImageGlow:setAlpha( 0.3 )
	self.ImageGlow:setImage( RegisterImage( "uie_t7_cp_hud_enemytarget_glow" ) )
	self.ImageGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ImageGlow )

	self.NameBacking = LUI.UIImage.new()
	self.NameBacking:setLeftRight( false, false, -43, 43 )
	self.NameBacking:setTopBottom( false, false, 99.5 - 217, 118 - 217 )
	self.NameBacking:setImage( RegisterImage( "$white" ) )
	self.NameBacking:setRGB( 0, 0, 0 )
	self:addElement( self.NameBacking )

	self.NameGlow = LUI.UIImage.new()
	self.NameGlow:setLeftRight( false, false, -80, 80 )
	self.NameGlow:setTopBottom( false, false, 25 + 70.5 - 217, 55 + 70.5 - 217 )
	self.NameGlow:setAlpha( 0.66 )
	self.NameGlow:setScale( 1 )
	self.NameGlow:setImage( RegisterImage( "uie_t7_cp_hud_enemytarget_glow" ) )
	self.NameGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.NameGlow )

	self.Name = LUI.UIText.new()
	self.Name:setLeftRight( false, false, -90, 90 )
	self.Name:setTopBottom( false, false, 25 + 70.5 - 217, 55 + 70.5 - 217 )
	self.Name:setTTF( "fonts/default.TTF" )
	self.Name:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.Name:setRGB( 1, 1, 1 )
	self.Name:setScale( 0.5 )
	self.Name:linkToElementModel( self, "name", true, function( model )
		local name = Engine.GetModelValue( model )
		if name then
			self.Name:setText( string.upper( name ) )
		end
	end )
	self:addElement( self.Name )

	self.Focus = LUI.UIElement.new()
	self.Focus:setLeftRight( true, true, 0, 0 )
	self.Focus:setTopBottom( true, true, 0, 0 )
	self:addElement( self.Focus )

	local glowColor = { r = 0.98, g = 0.52, b = 0.05 }

	self.Focus.BorderTop = LUI.UIImage.new()
	self.Focus.BorderTop:setLeftRight( true, true, 0, 0 )
	self.Focus.BorderTop:setTopBottom( true, false, 0, 1.5 )
	self.Focus.BorderTop:setRGB( glowColor.r, glowColor.g, glowColor.b )
	self.Focus:addElement( self.Focus.BorderTop )

	self.Focus.BorderBottom = LUI.UIImage.new()
	self.Focus.BorderBottom:setLeftRight( true, true, 0, 0 )
	self.Focus.BorderBottom:setTopBottom( false, true, -1.5, 0 )
	self.Focus.BorderBottom:setRGB( glowColor.r, glowColor.g, glowColor.b )
	self.Focus:addElement( self.Focus.BorderBottom )

	self.Focus.BorderLeft = LUI.UIImage.new()
	self.Focus.BorderLeft:setLeftRight( true, false, 0, 1.5 )
	self.Focus.BorderLeft:setTopBottom( true, true, 0, 0 )
	self.Focus.BorderLeft:setRGB( glowColor.r, glowColor.g, glowColor.b )
	self.Focus:addElement( self.Focus.BorderLeft )

	self.Focus.BorderRight = LUI.UIImage.new()
	self.Focus.BorderRight:setLeftRight( false, true, -1.5, 0 )
	self.Focus.BorderRight:setTopBottom( true, true, 0, 0 )
	self.Focus.BorderRight:setRGB( glowColor.r, glowColor.g, glowColor.b )
	self.Focus:addElement( self.Focus.BorderRight )	

	self:linkToElementModel( self, "HudIndex", true, function( model )
	    local myIndex = Engine.GetModelValue( model )
	    local controllerModel = Engine.GetModelForController( controller )
	    local HudIndexModel = Engine.GetModel( controllerModel, "SelectedHudIndex" )
	    
	    self:subscribeToModel( HudIndexModel, function( model )
	        local selectedIndex = Engine.GetModelValue( model )
	        if myIndex and selectedIndex and myIndex == selectedIndex then
	            --self.Name:setRGB( 0.98, 0.52, 0.05 )
	            CoD.UIColors.SetElementColor( self.Name, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	            self:playClip( "Selected" )
	        else
	            self.Name:setRGB( 1, 1, 1 )
	        end
	    end )
	end )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
	            self:setupElementClipCounter( 2 )

	            self.Focus:completeAnimation()
	            self.Focus:setAlpha( 0 )
	            self.clipFinished( self.Focus, {} )

	            self.Name:completeAnimation()
	            self.Name:setScale( 0.5 )
	            self.clipFinished( self.Name, {} )
	        end,

			Selected = function()
	            self:setupElementClipCounter( 3 )

	            local ImageFrame2 = function( element, event )
					local ImageFrame3 = function( element, event )
						local ImageFrame4 = function( element, event )
							element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end

						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:setScale( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ImageFrame4 )
					end

					element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
					element:setAlpha( 0.7 )
					element:setScale( 0.9 )
					element:registerEventHandler( "transition_complete_keyframe", ImageFrame3 )
				end

				self.Image:completeAnimation()
				ImageFrame2( self.Image, {} )

	            local NameFrame2 = function( element, event )
	                element:beginAnimation( "keyframe", 350, false, false, CoD.TweenType.BounceIn )
	                element:setScale( 0.5 )
	                element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
	            end

	            self.Name:completeAnimation()
	            self.Name:setScale( 0.7 )
	            NameFrame2( self.Name, {} )

	            self.Focus:completeAnimation()
	            self.Focus:setAlpha( 0 )
	            self.clipFinished( self.Focus, {} )
	        end,

			Focus = function()
				self:setupElementClipCounter( 1 )

				self.Focus:completeAnimation()
				self.Focus:setAlpha( 1 )
				self.clipFinished( self.Focus, {} )
			end,

			LoseFocus = function()
				self:setupElementClipCounter( 1 )

				local FadeOutFocus = function( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Focus:completeAnimation()
				self.Focus:setAlpha( 1 )
				FadeOutFocus( self.Focus, {} )
			end,

			GainFocus = function()
				self:setupElementClipCounter( 1 )
				local FadeInFocus = function( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Focus:completeAnimation()
				self.Focus:setAlpha( 0 )
				FadeInFocus( self.Focus, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.Image:close()
		element.ImageGlow:close()
		element.NameBacking:close()
		element.NameGlow:close()
		element.Name:close()
		element.Focus:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end