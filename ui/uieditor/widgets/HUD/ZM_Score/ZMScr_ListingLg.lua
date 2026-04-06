require( "ui.uieditor.widgets.HUD.CP_DamageWidget.DamageWidgetMP_PanelContainer" )
require( "ui.uieditor.widgets.onOffImage" )

local UpdatePortraitIcon = function( self, controller, modelValue )
    local foundImage = nil

    if modelValue and modelValue >= 0 then
        for i = 1, #CoD.CharacterTable do
            local entry = CoD.CharacterTable[i].models
            
            if entry and entry.styles then
                for _, style in ipairs(entry.styles) do
                    if style.characterIndex == modelValue then
                        foundImage = style.image
                        break
                    end
                end
            end
            
            if not foundImage and entry and entry.characterIndex == modelValue then
                foundImage = entry.image
            end
            
            if foundImage then
            	break
            end
        end
    end

    if foundImage then
        self.portraitIcon.image:setImage( RegisterImage( foundImage ) )
        return
    end

    local iconModel = Engine.GetModel( self:getModel(), "zombiePlayerIcon" )
    if iconModel then
        local zombiePlayerIcon = Engine.GetModelValue( iconModel )
        local mapName = Engine.GetCurrentMap()

        if zombiePlayerIcon then
            if mapName and mapPortraidOverride and mapPortraidOverride[mapName] then
                zombiePlayerIcon = portraitIcons[zombiePlayerIcon] or zombiePlayerIcon
            end
            
            self.portraitIcon.image:setImage( RegisterImage( zombiePlayerIcon ) )
        end
    end
end

local PreLoadFunc = function( self, controller )
	local controllerModel = Engine.GetModelForController( controller )
	local characterIndexModel = Engine.GetModel( controllerModel, "SelectedCharacterIndex" )
	if not characterIndexModel then
		characterIndexModel = Engine.CreateModel( controllerModel, "SelectedCharacterIndex" )
		Engine.SetModelValue( characterIndexModel, -1 )
	end
end

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self, color )
    	local elements = { self.Glow, self.ImageGlow }
    	for i, element in ipairs( elements ) do
    		element:completeAnimation()
    		element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
    		CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    	end
    end

    local controllerModel = Engine.GetModelForController( controller )
    local colorUpdateModel = Engine.CreateModel( controllerModel, "colorUpdate" )
    local characterIndexModel = Engine.GetModel( controllerModel, "SelectedCharacterIndex" )
    
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )

    self:subscribeToModel( characterIndexModel, function( model )
        UpdatePortraitIcon( self, controller, Engine.GetModelValue( model ) )
    end )

    self.portraitIcon:linkToElementModel( self, "zombiePlayerIcon", true, function( model )
        local charIndex = Engine.GetModelValue( characterIndexModel )
        
        if charIndex == nil or charIndex < 0 then
            UpdatePortraitIcon( self, controller, charIndex )
        end
    end )
end

CoD.ZMScr_ListingLg = InheritFrom( LUI.UIElement )
CoD.ZMScr_ListingLg.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMScr_ListingLg )
	self.id = "ZMScr_ListingLg"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 134 )
	self:setTopBottom( true, false, 0, 58 )
	self.anyChildUsesUpdateState = true
	
	local Panel = CoD.DamageWidgetMP_PanelContainer.new( menu, controller )
	Panel:setLeftRight( true, false, 0, 45 )
	Panel:setTopBottom( false, false, -18.25, 28.75 )
	Panel:setRGB( 0.61, 0.61, 0.61 )
	Panel.PanelAmmo0:setShaderVector( 0, 30, 10, 0, 0 )
	self:addElement( Panel )
	self.Panel = Panel
	
	local Score = LUI.UITightText.new()
	Score:setLeftRight( true, false, 45, 102 )
	Score:setTopBottom( true, false, 7.5, 44.5 )
	Score:setTTF( "fonts/WEARETRIPPINShort.ttf" )
	Score:linkToElementModel( self, "clientNum", true, function ( model )
		local clientNum = Engine.GetModelValue( model )
		if clientNum then
			Score:setRGB( ZombieClientScoreboardColor( clientNum ) )
		end
	end )
	Score:linkToElementModel( self, "playerScore", true, function ( model )
		local playerScore = Engine.GetModelValue( model )
		if playerScore then
			Score:setText( Engine.Localize( playerScore ) )
		end
	end )

	LUI.OverrideFunction_CallOriginalFirst( Score, "setText", function( element, controller )
		ScaleWidgetToLabel( self, element, 0 )
	end )
	self:addElement( Score )
	self.Score = Score

	self.ImageGlow = LUI.UIImage.new()
	self.ImageGlow:setLeftRight( true, false, 2 - 8, 43 + 8 )
	self.ImageGlow:setTopBottom( true, false, 13.22 - 8, 54.22 + 8 )
	self.ImageGlow:setRGB( 0, 0.43, 1 )
	self.ImageGlow:setAlpha( 0.35 )
	self.ImageGlow:setZRot( 90 )
	self.ImageGlow:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.ImageGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ImageGlow:mergeStateConditions( {
		{
			stateName = "On",
			condition = function ( menu, element, event )
				return IsSelfModelValueEqualTo( element, controller, "zombieWearableIcon", "blacktransparent" )
			end
		}
	} )
	self.ImageGlow:linkToElementModel( self.ImageGlow, "zombieWearableIcon", true, function ( model )
		menu:updateElementState( self.ImageGlow, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( model ),
			modelName = "zombieWearableIcon"
		} )
	end )
	self:addElement( self.ImageGlow )
	
	local portraitIcon = CoD.onOffImage.new( menu, controller )
	portraitIcon:setLeftRight( true, false, 2, 43 )
	portraitIcon:setTopBottom( true, false, 13.22, 54.22 )
	portraitIcon:linkToElementModel( self, nil, false, function ( model )
		portraitIcon:setModel( model, controller )
	end )
	portraitIcon:mergeStateConditions( {
		{
			stateName = "On",
			condition = function ( menu, element, event )
				return IsSelfModelValueEqualTo( element, controller, "zombieWearableIcon", "blacktransparent" )
			end
		}
	} )
	portraitIcon:linkToElementModel( portraitIcon, "zombieWearableIcon", true, function ( model )
		menu:updateElementState( portraitIcon, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( model ),
			modelName = "zombieWearableIcon"
		} )
	end )
	self:addElement( portraitIcon )
	self.portraitIcon = portraitIcon
	
	local portraitIcon0 = CoD.onOffImage.new( menu, controller )
	portraitIcon0:setLeftRight( true, false, 2, 43 )
	portraitIcon0:setTopBottom( true, false, 13.22, 54.22 )
	portraitIcon0:linkToElementModel( self, nil, false, function ( model )
		portraitIcon0:setModel( model, controller )
	end )
	portraitIcon0:linkToElementModel( self, "zombieWearableIcon", true, function ( model )
	    local zombieWearableIcon = Engine.GetModelValue( model )
	    if zombieWearableIcon then
	        if string.match( zombieWearableIcon, "_helmet$" ) then
	            portraitIcon0.image:setImage( RegisterImage( "uie_t7_zm_hud_score_char3_old_helmet" ) )
	        else
	            --portraitIcon0.image:setImage( RegisterImage( zombieWearableIcon ) )
	            portraitIcon0.image:setImage( RegisterImage( "blacktransparent" ) )
	        end
	    end
	end )
	portraitIcon0:mergeStateConditions( {
		{
			stateName = "On",
			condition = function ( menu, element, event )
				return not IsSelfModelValueEqualTo( element, controller, "zombieWearableIcon", "blacktransparent" )
			end
		}
	} )
	portraitIcon0:linkToElementModel( portraitIcon0, "zombieWearableIcon", true, function ( model )
		menu:updateElementState( portraitIcon0, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( model ),
			modelName = "zombieWearableIcon"
		} )
	end )
	self:addElement( portraitIcon0 )
	self.portraitIcon0 = portraitIcon0
	
	local Image0 = LUI.UIImage.new()
	Image0:setLeftRight( true, false, 0, 28 )
	Image0:setTopBottom( false, true, -28, 0 )
	Image0:linkToElementModel( self, "zombieInventoryIcon", true, function ( model )
		local zombieInventoryIcon = Engine.GetModelValue( model )
		if zombieInventoryIcon then
			Image0:setImage( RegisterImage( zombieInventoryIcon ) )
		end
	end )
	self:addElement( Image0 )
	self.Image0 = Image0
	
	local Glow = LUI.UIImage.new()
	Glow:setLeftRight( true, true, 14, -7 )
	Glow:setTopBottom( true, false, 2, 50 )
	Glow:setAlpha( 0.42 )
	Glow:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	Glow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( Glow )
	self.Glow = Glow
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( Panel, {} )

				Score:completeAnimation()
				self.Score:setAlpha( 0 )
				self.clipFinished( Score, {} )

				Image0:completeAnimation()
				self.Image0:setAlpha( 0 )
				self.clipFinished( Image0, {} )

				Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				self.clipFinished( Glow, {} )
			end,

			Visible = function ()
				self:setupElementClipCounter( 4 )

				local PanelFrame2 = function ( Panel, event )
					if not event.interrupted then
						Panel:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					Panel:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( Panel, event )
					else
						Panel:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				PanelFrame2( Panel, {} )
				local ScoreFrame2 = function ( Score, event )
					if not event.interrupted then
						Score:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					Score:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( Score, event )
					else
						Score:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Score:completeAnimation()
				self.Score:setAlpha( 0 )
				ScoreFrame2( Score, {} )
				local Image0Frame2 = function ( Image0, event )
					if not event.interrupted then
						Image0:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					Image0:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( Image0, event )
					else
						Image0:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Image0:completeAnimation()
				self.Image0:setAlpha( 0 )
				Image0Frame2( Image0, {} )
				local GlowFrame2 = function ( Glow, event )
					if not event.interrupted then
						Glow:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					Glow:setAlpha( 0.42 )
					if event.interrupted then
						self.clipFinished( Glow, event )
					else
						Glow:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				GlowFrame2( Glow, {} )
			end,

			VisibleTomb = function ()
				self:setupElementClipCounter( 4 )

				local PanelFrame2 = function ( Panel, event )
					if not event.interrupted then
						Panel:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					Panel:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( Panel, event )
					else
						Panel:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				PanelFrame2( Panel, {} )
				local ScoreFrame2 = function ( Score, event )
					if not event.interrupted then
						Score:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					Score:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( Score, event )
					else
						Score:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Score:completeAnimation()
				self.Score:setAlpha( 0 )
				ScoreFrame2( Score, {} )
				local Image0Frame2 = function ( Image0, event )
					if not event.interrupted then
						Image0:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					Image0:setLeftRight( true, false, -21, 7 )
					Image0:setTopBottom( false, true, -31.78, -3.78 )
					Image0:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( Image0, event )
					else
						Image0:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Image0:completeAnimation()
				self.Image0:setLeftRight( true, false, -21, 7 )
				self.Image0:setTopBottom( false, true, -31.78, -3.78 )
				self.Image0:setAlpha( 0 )
				Image0Frame2( Image0, {} )
				local GlowFrame2 = function ( Glow, event )
					if not event.interrupted then
						Glow:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					Glow:setAlpha( 0.42 )
					if event.interrupted then
						self.clipFinished( Glow, event )
					else
						Glow:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				GlowFrame2( Glow, {} )
			end
		},

		VisibleTomb = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				Panel:completeAnimation()
				self.Panel:setAlpha( 1 )
				self.clipFinished( Panel, {} )

				Score:completeAnimation()
				self.Score:setAlpha( 1 )
				self.clipFinished( Score, {} )

				Image0:completeAnimation()
				self.Image0:setLeftRight( true, false, -21, 7 )
				self.Image0:setTopBottom( false, true, -31.78, -3.78 )
				self.Image0:setAlpha( 1 )
				self.clipFinished( Image0, {} )

				Glow:completeAnimation()
				self.Glow:setAlpha( 0.42 )
				self.clipFinished( Glow, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 4 )

				local PanelFrame2 = function ( Panel, event )
					if not event.interrupted then
						Panel:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					Panel:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( Panel, event )
					else
						Panel:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Panel:completeAnimation()
				self.Panel:setAlpha( 1 )
				PanelFrame2( Panel, {} )
				local ScoreFrame2 = function ( Score, event )
					if not event.interrupted then
						Score:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					Score:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( Score, event )
					else
						Score:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Score:completeAnimation()
				self.Score:setAlpha( 1 )
				ScoreFrame2( Score, {} )
				local Image0Frame2 = function ( Image0, event )
					if not event.interrupted then
						Image0:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					Image0:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( Image0, event )
					else
						Image0:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Image0:completeAnimation()
				self.Image0:setAlpha( 1 )
				Image0Frame2( Image0, {} )
				local GlowFrame2 = function ( Glow, event )
					if not event.interrupted then
						Glow:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					Glow:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( Glow, event )
					else
						Glow:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Glow:completeAnimation()
				self.Glow:setAlpha( 0.42 )
				GlowFrame2( Glow, {} )
			end
		},

		Visible = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				Panel:completeAnimation()
				self.Panel:setAlpha( 1 )
				self.clipFinished( Panel, {} )

				Score:completeAnimation()
				self.Score:setAlpha( 1 )
				self.clipFinished( Score, {} )

				Image0:completeAnimation()
				self.Image0:setAlpha( 1 )
				self.clipFinished( Image0, {} )

				Glow:completeAnimation()
				self.Glow:setAlpha( 0.42 )
				self.clipFinished( Glow, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 4 )

				local PanelFrame2 = function ( Panel, event )
					if not event.interrupted then
						Panel:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					Panel:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( Panel, event )
					else
						Panel:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Panel:completeAnimation()
				self.Panel:setAlpha( 1 )
				PanelFrame2( Panel, {} )
				local ScoreFrame2 = function ( Score, event )
					if not event.interrupted then
						Score:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					Score:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( Score, event )
					else
						Score:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Score:completeAnimation()
				self.Score:setAlpha( 1 )
				ScoreFrame2( Score, {} )
				local Image0Frame2 = function ( Image0, event )
					if not event.interrupted then
						Image0:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					Image0:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( Image0, event )
					else
						Image0:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Image0:completeAnimation()
				self.Image0:setAlpha( 1 )
				Image0Frame2( Image0, {} )
				local GlowFrame2 = function ( Glow, event )
					if not event.interrupted then
						Glow:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					Glow:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( Glow, event )
					else
						Glow:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				Glow:completeAnimation()
				self.Glow:setAlpha( 0.42 )
				GlowFrame2( Glow, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "VisibleTomb",
			condition = function ( menu, element, event )
				local isTomb
				if not IsSelfModelValueEqualTo( element, controller, "playerScoreShown", 0 ) then
					isTomb = IsMapName( "zm_tomb" )
				else
					isTomb = false
				end
				return isTomb
			end
		},
		{
			stateName = "Visible",
			condition = function ( menu, element, event )
				return not IsSelfModelValueEqualTo( element, controller, "playerScoreShown", 0 )
			end
		}
	} )
	self:linkToElementModel( self, "playerScoreShown", true, function ( model )
		menu:updateElementState( self, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( model ),
			modelName = "playerScoreShown"
		} )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.Panel:close()
		element.ImageGlow:close()
		element.portraitIcon:close()
		element.Score:close()
		element.Image0:close()
		element.Glow:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end