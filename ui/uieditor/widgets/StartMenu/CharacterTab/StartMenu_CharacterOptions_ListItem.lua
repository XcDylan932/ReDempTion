local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
    	local color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]
    	CoD.UIColors.SetElementColor( self.ImageGlow, color )
        CoD.UIColors.SetElementColor( self.FocusGlow, color )
        CoD.UIColors.SetElementColor( self.NameGlow, color )
        CoD.UIColors.SetElementColor( self.Focus, color )
        CoD.UIColors.SetElementColor( self.Lightning, color )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )

    local characterIndexModel = Engine.GetModel( Engine.GetModelForController( controller ), "SelectedCharacterIndex" )

    local CheckIfSelected = function()
        local selectedIndex = Engine.GetModelValue( characterIndexModel )
        local widgetModel = self:getModel()
        
        if widgetModel then
            local myIndexModel = Engine.GetModel( widgetModel, "characterIndex" )
            if myIndexModel then
                local myIndex = Engine.GetModelValue( myIndexModel )
                
                if myIndex ~= nil and selectedIndex ~= nil and myIndex == selectedIndex then
                    self:playClip( "Selected" ) 
                else
                    self.Name:setRGB( 1, 1, 1 )
                end
            end
        end
    end

    self:subscribeToModel( characterIndexModel, CheckIfSelected )
    self:linkToElementModel( self, "characterIndex", true, CheckIfSelected )
    CheckIfSelected()
end

CoD.StartMenu_CharacterOptions_ListItem = InheritFrom( LUI.UIElement )
CoD.StartMenu_CharacterOptions_ListItem.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_CharacterOptions_ListItem )
	self.id = "StartMenu_CharacterOptions_ListItem"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 90 )
	self:setTopBottom( true, false, 0, 90 )
	self:makeFocusable()
	self:setHandleMouse( true )
	self.anyChildUsesUpdateState = true

	self.ImageGlow = LUI.UIImage.new()
	self.ImageGlow:setLeftRight( true, true, -2, 2 )
	self.ImageGlow:setTopBottom( true, true, -2, 2 )
	self.ImageGlow:setRGB( 0, 0.43, 1 )
	self.ImageGlow:setAlpha( 0.35 )
	self.ImageGlow:setZRot( 90 )
	self.ImageGlow:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.ImageGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ImageGlow )

	self.Image = LUI.UIImage.new()
	self.Image:setLeftRight( true, true, 2, -2 )
	self.Image:setTopBottom( true, true, 2, -2 )
	self.Image:setScale( 0.9 )
	self.Image:setImage( RegisterImage( "blacktransparent" ) )
	self.Image:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.Image:setShaderVector( 0, 0.3, 0.2, 0.2, 0.4 )
	self.Image:linkToElementModel( self, "image", true, function( model )
		local image = Engine.GetModelValue( model )
		if image then
			self.Image:setImage( RegisterImage( image ) )
		end
	end )
	self:addElement( self.Image )

	self.NameBacking = LUI.UIImage.new()
	self.NameBacking:setLeftRight( false, false, -43, 43 )
	self.NameBacking:setTopBottom( false, false, 29, 47.5 )
	self.NameBacking:setImage( RegisterImage( "$white" ) )
	self.NameBacking:setRGB( 0, 0, 0 )
	self:addElement( self.NameBacking )

	self.NameGlow = LUI.UIImage.new()
	self.NameGlow:setLeftRight( false, false, -70, 70 )
	self.NameGlow:setTopBottom( false, false, 25, 55 )
	self.NameGlow:setAlpha( 0.66 )
	self.NameGlow:setScale( 1 )
	self.NameGlow:setImage( RegisterImage( "uie_t7_cp_hud_enemytarget_glow" ) )
	self.NameGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.NameGlow )

	self.Name = LUI.UIText.new()
	self.Name:setLeftRight( false, false, -90, 90 )
	self.Name:setTopBottom( false, false, 25, 55 )
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

	self.FocusGlow = LUI.UIImage.new()
	self.FocusGlow:setLeftRight( true, true, -7.5, 7.5 )
	self.FocusGlow:setTopBottom( true, true, -7.5, 12.5 )
	self.FocusGlow:setAlpha( 0 )
	self.FocusGlow:setScale( 0.1 )
	self.FocusGlow:setImage( RegisterImage( "uie_t7_cp_hud_enemytarget_glow" ) )
	self.FocusGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.FocusGlow )

	self.Lightning = LUI.UIImage.new()
	self.Lightning:setLeftRight( true, true, -7.5, 7.5 )
	self.Lightning:setTopBottom( true, true, -7.5, 12.5 )
	self.Lightning:setAlpha( 0 )
	self.Lightning:setScale( 0.1 )
	self.Lightning:setImage( RegisterImage( "uie_t7_zm_derriese_hud_notification_anim" ) )
	self.Lightning:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_flipbook" ) )
	self.Lightning:setShaderVector( 0, 28, 0, 0, 0 )
	self.Lightning:setShaderVector( 1, 30, 0, 0, 0 )
	self:addElement( self.Lightning )

	self.Focus = LUI.UIImage.new()
	self.Focus:setLeftRight( true, true, -7.5, 7.5 )
	self.Focus:setTopBottom( true, true, -7.5, 12 )
	self.Focus:setImage( RegisterImage( "uie_t7_blackmarket_bribe_big_selected" ) )
	self.Focus:setRGB( 0.98, 0.52, 0.05 )
	self.Focus:setAlpha( 0 )
	self:addElement( self.Focus )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 4 )

				self.Name:completeAnimation()
	            self.Name:setScale( 0.5 )
	            self.clipFinished( self.Name, {} )

				self.FocusGlow:completeAnimation()
				self.FocusGlow:setAlpha( 0 )
				self.clipFinished( self.FocusGlow, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )

				self.Focus:completeAnimation()
				self.Focus:setAlpha( 0 )
				self.clipFinished( self.Focus, {} )
			end,

			Selected = function ()
				self:setupElementClipCounter( 5 )

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
					element:setAlpha( 0.5 )
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
	            CoD.UIColors.SetElementColor( self.Name, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	            NameFrame2( self.Name, {} )

	            local FocusGlowFrame2 = function( element, event )
	            	local FocusGlowFrame3 = function( element, event )
	            		local FocusGlowFrame4 = function( element, event )
			            	element:beginAnimation( "keyframe", 25, false, false, CoD.TweenType.Linear )
			            	element:setAlpha( 0 )
			            	element:setScale( 0.1 )
			            	element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
			            end

		            	element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
		            	element:setScale( 1.4 )
		            	element:registerEventHandler( "transition_complete_keyframe", FocusGlowFrame4 )
		            end

	            	element:beginAnimation( "keyframe", 25, false, false, CoD.TweenType.Linear )
	            	element:setAlpha( 1 )
	            	element:registerEventHandler( "transition_complete_keyframe", FocusGlowFrame3 )
	            end

	            self.FocusGlow:completeAnimation()
	            FocusGlowFrame2( self.FocusGlow, {} )

	            local LightningFrame2 = function ( element, event )
					local LightningFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 350, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						element:setScale( 0.5 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						LightningFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:setScale( 1 )
						element:registerEventHandler( "transition_complete_keyframe", LightningFrame3 )
					end
				end
				
				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				LightningFrame2( self.Lightning, {} )

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
		element.ImageGlow:close()
		element.Image:close()
		element.NameBacking:close()
		element.NameGlow:close()
		element.Name:close()
		element.FocusGlow:close()
		element.Lightning:close()
		element.Focus:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end