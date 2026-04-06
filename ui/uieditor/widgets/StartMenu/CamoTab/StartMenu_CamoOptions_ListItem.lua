local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        CoD.UIColors.SetElementColor( self.FocusGlow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.NameGlow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.Focus, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.Lightning, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )

    local camoIndexModel = Engine.GetModel( Engine.GetModelForController( controller ), "SelectedCamoIndex" )

    local CheckIfSelected = function()
        local selectedIndex = Engine.GetModelValue( camoIndexModel )
        local widgetModel = self:getModel()
        
        if widgetModel then
            local myIndexModel = Engine.GetModel( widgetModel, "camoIndex" )
            if myIndexModel then
                local myIndex = Engine.GetModelValue( myIndexModel )
                
                if myIndex ~= nil and selectedIndex ~= nil and myIndex == selectedIndex then
                    self:playClip( "Selected" )
                else
                    self.Name:setRGB( 0.7, 0.7, 0.7 )
                end
            end
        end
    end

    self:subscribeToModel( camoIndexModel, CheckIfSelected )
    self:linkToElementModel( self, "camoIndex", true, CheckIfSelected )
    CheckIfSelected()
end

CoD.StartMenu_CamoOptions_ListItem = InheritFrom( LUI.UIElement )
CoD.StartMenu_CamoOptions_ListItem.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_CamoOptions_ListItem )
	self.id = "StartMenu_CamoOptions_ListItem"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 90 )
	self:setTopBottom( true, false, 0, 90 )
	self:makeFocusable()
	self:setHandleMouse( true )
	self.anyChildUsesUpdateState = true

	self.Image = LUI.UIImage.new()
	self.Image:setLeftRight( false, false, -42.5, 42.5 )
	self.Image:setTopBottom( false, false, -42.5, 29 )
	self.Image:setImage( RegisterImage( "blacktransparent" ) )
	self.Image:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.Image:setShaderVector( 0, 0.1, 0.1, 0.1, 0 )
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
	self.NameBacking:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.NameBacking:setShaderVector( 0, 0.1, 0, 0.1, 0 )
	self.NameBacking:setRGB( 0, 0, 0 )
	self:addElement( self.NameBacking )

	self.NameGlow = LUI.UIImage.new()
	self.NameGlow:setLeftRight( false, false, -60, 60 )
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
	self.Name:setRGB( 0.7, 0.7, 0.7 )
	self.Name:setScale( 0.5 )
	self.Name:linkToElementModel( self, "name", true, function( model )
		local name = Engine.GetModelValue( model )
		if name then
			self.Name:setText( Engine.Localize( LocalizeToUpperString( name ) ) )
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
	self.Focus:setTopBottom( true, true, -7.5, 12.5 )
	self.Focus:setImage( RegisterImage( "uie_t7_blackmarket_bribe_big_selected" ) )
	self.Focus:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.Focus:setAlpha( 0 )
	self:addElement( self.Focus )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 4 )

				self.Image:completeAnimation()
				self.Image:setAlpha( 1 )
				self.clipFinished( self.Image, {} )

				self.Name:completeAnimation()
	            self.Name:setScale( 0.5 )
	            self.clipFinished( self.Name, {} )

	            self.FocusGlow:completeAnimation()
				self.FocusGlow:setAlpha( 0 )
				self.clipFinished( self.FocusGlow, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )
			end,

			Selected = function ()
				self:setupElementClipCounter( 5 )

				local parentList = self:getParent()
			    if parentList then
			        parentList.m_inputDisabled = true
			    end

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
	                element:registerEventHandler( "transition_complete_keyframe", function( element, event )
	                	local parentList = self:getParent()
		                if parentList then
		                    parentList.m_inputDisabled = false
		                end
		                self.clipFinished( element, event )
	                end )
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
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
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
				self.Focus:setAlpha( 0.5 )
				self.clipFinished( self.Focus, {} )
			end,

			LoseFocus = function()
				self:setupElementClipCounter( 2 )

				local FocusFrame1 = function( element, event )
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
				FocusFrame1( self.Focus, {} )
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