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
    self:linkToElementModel( self, "clientNum", true, function( model )
        local clientNum = Engine.GetModelValue( model )
        if clientNum ~= nil then
            local clientModel = Engine.GetModelForController( clientNum )
            if clientModel then
                local charIndexModel = Engine.GetModel( clientModel, "SelectedCharacterIndex" )
                if charIndexModel then
                    self:subscribeToModel( charIndexModel, function( model )
                        local charIndex = Engine.GetModelValue( model )
                        UpdatePortraitIcon( self, controller, charIndex )
                    end )
                end
            end
        end
    end )

    self.portraitIcon:linkToElementModel( self, "zombiePlayerIcon", true, function( model )
        local charIndex = Engine.GetModelValue( characterIndexModel )
        
        if charIndex == nil or charIndex < 0 then
            UpdatePortraitIcon( self, controller, charIndex )
        end
    end )
end


CoD.ZMScr_ListingSm = InheritFrom( LUI.UIElement )
CoD.ZMScr_ListingSm.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMScr_ListingSm )
	self.id = "ZMScr_ListingSm"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 85 )
	self:setTopBottom( true, false, 0, 35 )
	self.anyChildUsesUpdateState = true
	
	self.Panel = CoD.DamageWidgetMP_PanelContainer.new( menu, controller )
	self.Panel:setLeftRight( true, false, 0.5, 28.5 )
	self.Panel:setTopBottom( false, false, -15, 14 )
	self.Panel:setRGB( 0.61, 0.61, 0.61 )
	self.Panel.PanelAmmo0:setShaderVector( 0, 30, 10, 0, 0 )
	self:addElement( self.Panel )
	
	self.Label3 = LUI.UITightText.new()
	self.Label3:setLeftRight( true, false, 30, 59 )
	self.Label3:setTopBottom( true, false, 2.25, 30.25 )
	self.Label3:setTTF( "fonts/WEARETRIPPINShort.ttf" )
	self.Label3:setLetterSpacing( 0.5 )
	self.Label3:linkToElementModel( self, "clientNum", true, function ( model )
		local clientNum = Engine.GetModelValue( model )
		if clientNum then
			self.Label3:setRGB( ZombieClientScoreboardColor( clientNum ) )
		end
	end )
	self.Label3:linkToElementModel( self, "playerScore", true, function ( model )
		local playerScore = Engine.GetModelValue( model )
		if playerScore then
			self.Label3:setText( Engine.Localize( playerScore ) )
		end
	end )
	LUI.OverrideFunction_CallOriginalFirst( self.Label3, "setText", function ( element, controller )
		ScaleWidgetToLabel( self, element, 0 )
	end )
	self:addElement( self.Label3 )
	
	local portraitIcon = CoD.onOffImage.new( menu, controller )
	portraitIcon:setLeftRight( true, false, 2.28, 26 )
	portraitIcon:setTopBottom( true, false, 4.25, 27.97 )
	portraitIcon:linkToElementModel( self, nil, false, function ( model )
		if model then
			portraitIcon:setModel( model, controller )
		end
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
	
	local wearableIcon = CoD.onOffImage.new( menu, controller )
	wearableIcon:setLeftRight( true, false, 2.28, 26 )
	wearableIcon:setTopBottom( true, false, 4.25, 27.97 )
	wearableIcon:linkToElementModel( self, nil, false, function ( model )
		if model then
			wearableIcon:setModel( model, controller )
		end
	end )
	wearableIcon:linkToElementModel( self, "zombieWearableIcon", true, function ( model )
		local zombieWearableIcon = Engine.GetModelValue( model )
		if zombieWearableIcon and wearableIcon.image then
			wearableIcon.image:setImage( RegisterImage( zombieWearableIcon ) )
		end
	end )
	wearableIcon:mergeStateConditions( {
		{
			stateName = "On",
			condition = function ( menu, element, event )
				return not IsSelfModelValueEqualTo( element, controller, "zombieWearableIcon", "blacktransparent" )
			end
		}
	} )
	wearableIcon:linkToElementModel( wearableIcon, "zombieWearableIcon", true, function ( model )
		menu:updateElementState( wearableIcon, {
			name = "model_validation",
			menu = menu,
			modelValue = Engine.GetModelValue( model ),
			modelName = "zombieWearableIcon"
		} )
	end )
	self:addElement( wearableIcon )
	self.wearableIcon = wearableIcon
	
	self.Glow = LUI.UIImage.new()
	self.Glow:setLeftRight( true, true, 9, -5 )
	self.Glow:setTopBottom( true, false, 0, 34.5 )
	self.Glow:setAlpha( 0.2 )
	self.Glow:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.Glow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Glow )
	
	self.Image0 = LUI.UIImage.new()
	self.Image0:setLeftRight( true, false, 0, 20 )
	self.Image0:setTopBottom( false, true, -20, 0 )
	self.Image0:linkToElementModel( self, "zombieInventoryIcon", true, function ( model )
		local zombieInventoryIcon = Engine.GetModelValue( model )
		if zombieInventoryIcon then
			self.Image0:setImage( RegisterImage( zombieInventoryIcon ) )
		end
	end )
	self:addElement( self.Image0 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.Label3:completeAnimation()
				self.Label3:setAlpha( 0 )
				self.clipFinished( self.Label3, {} )

				self.portraitIcon:completeAnimation()
				self.portraitIcon:setAlpha( 0 )
				self.clipFinished( self.portraitIcon, {} )

				self.wearableIcon:completeAnimation()
				self.wearableIcon:setAlpha( 0 )
				self.clipFinished( self.wearableIcon, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				self.clipFinished( self.Glow, {} )

				self.Image0:completeAnimation()
				self.Image0:setLeftRight( true, false, 0, 20 )
				self.Image0:setTopBottom( false, true, -20, 0 )
				self.Image0:setAlpha( 0 )
				self.clipFinished( self.Image0, {} )
			end,

			Visible = function ()
				self:setupElementClipCounter( 6 )

				local PanelFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				PanelFrame2( self.Panel, {} )

				local Label3Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Label3:completeAnimation()
				self.Label3:setAlpha( 0 )
				Label3Frame2( self.Label3, {} )

				local portraitIconFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.portraitIcon:completeAnimation()
				self.portraitIcon:setAlpha( 0 )
				portraitIconFrame2( self.portraitIcon, {} )

				local wearableIconFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.wearableIcon:completeAnimation()
				self.wearableIcon:setAlpha( 0 )
				wearableIconFrame2( self.wearableIcon, {} )

				local GlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 0.2 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				GlowFrame2( self.Glow, {} )

				local Image0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Image0:completeAnimation()
				self.Image0:setAlpha( 0 )
				Image0Frame2( self.Image0, {} )
			end,

			VisibleTomb = function ()
				self:setupElementClipCounter( 6 )

				local PanelFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				PanelFrame2( self.Panel, {} )

				local Label3Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Label3:completeAnimation()
				self.Label3:setAlpha( 0 )
				Label3Frame2( self.Label3, {} )

				local portraitIconFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.portraitIcon:completeAnimation()
				self.portraitIcon:setAlpha( 0 )
				portraitIconFrame2( self.portraitIcon, {} )

				local wearableIconFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.wearableIcon:completeAnimation()
				self.wearableIcon:setAlpha( 0 )
				wearableIconFrame2( self.wearableIcon, {} )

				local GlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 0.2 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				GlowFrame2( self.Glow, {} )

				local Image0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Bounce )
					end
					element:setLeftRight( true, false, -13.72, 6.28 )
					element:setTopBottom( false, true, -27.03, -7.03 )
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Image0:completeAnimation()
				self.Image0:setLeftRight( true, false, -13.72, 6.28 )
				self.Image0:setTopBottom( false, true, -27.03, -7.03 )
				self.Image0:setAlpha( 0 )
				Image0Frame2( self.Image0, {} )
			end
		},

		VisibleTomb = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 1 )
				self.clipFinished( self.Panel, {} )

				self.Label3:completeAnimation()
				self.Label3:setAlpha( 1 )
				self.clipFinished( self.Label3, {} )

				self.portraitIcon:completeAnimation()
				self.portraitIcon:setAlpha( 1 )
				self.clipFinished( self.portraitIcon, {} )

				self.wearableIcon:completeAnimation()
				self.wearableIcon:setAlpha( 1 )
				self.clipFinished( self.wearableIcon, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0.2 )
				self.clipFinished( self.Glow, {} )

				self.Image0:completeAnimation()
				self.Image0:setLeftRight( true, false, -13.72, 6.28 )
				self.Image0:setTopBottom( false, true, -27.03, -7.03 )
				self.Image0:setAlpha( 1 )
				self.clipFinished( self.Image0, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 6 )

				local PanelFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Panel:completeAnimation()
				self.Panel:setAlpha( 1 )
				PanelFrame2( self.Panel, {} )

				local Label3Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Label3:completeAnimation()
				self.Label3:setAlpha( 1 )
				Label3Frame2( self.Label3, {} )

				local portraitIconFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.portraitIcon:completeAnimation()
				self.portraitIcon:setAlpha( 1 )
				portraitIconFrame2( self.portraitIcon, {} )

				local wearableIconFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.wearableIcon:completeAnimation()
				self.wearableIcon:setAlpha( 1 )
				wearableIconFrame2( self.wearableIcon, {} )

				local GlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0.2 )
				GlowFrame2( self.Glow, {} )

				local Image0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, -13.72, 6.28 )
					element:setTopBottom( false, true, -27.03, -7.03 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Image0:completeAnimation()
				self.Image0:setLeftRight( true, false, -13.72, 6.28 )
				self.Image0:setTopBottom( false, true, -27.03, -7.03 )
				self.Image0:setAlpha( 1 )
				Image0Frame2( self.Image0, {} )
			end
		},

		Visible = {
			DefaultClip = function ()
				self:setupElementClipCounter( 6 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 1 )
				self.clipFinished( self.Panel, {} )

				self.Label3:completeAnimation()
				self.Label3:setAlpha( 1 )
				self.clipFinished( self.Label3, {} )

				self.portraitIcon:completeAnimation()
				self.portraitIcon:setAlpha( 1 )
				self.clipFinished( self.portraitIcon, {} )

				self.wearableIcon:completeAnimation()
				self.wearableIcon:setAlpha( 1 )
				self.clipFinished( self.wearableIcon, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0.2 )
				self.clipFinished( self.Glow, {} )

				self.Image0:completeAnimation()
				self.Image0:setAlpha( 1 )
				self.clipFinished( self.Image0, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 6 )

				local PanelFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Panel:completeAnimation()
				self.Panel:setAlpha( 1 )
				PanelFrame2( self.Panel, {} )

				local Label3Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Label3:completeAnimation()
				self.Label3:setAlpha( 1 )
				Label3Frame2( self.Label3, {} )

				local portraitIconFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.portraitIcon:completeAnimation()
				self.portraitIcon:setAlpha( 1 )
				portraitIconFrame2( self.portraitIcon, {} )

				local wearableIconFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.wearableIcon:completeAnimation()
				self.wearableIcon:setAlpha( 1 )
				wearableIconFrame2( self.wearableIcon, {} )

				local GlowFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0.2 )
				GlowFrame2( self.Glow, {} )

				local Image0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Image0:completeAnimation()
				self.Image0:setAlpha( 1 )
				Image0Frame2( self.Image0, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "VisibleTomb",
			condition = function ( menu, element, event )
				local isVisible
				if not IsSelfModelValueEqualTo( element, controller, "playerScoreShown", 0 ) then
					isVisible = IsMapName( "zm_tomb" )
				else
					isVisible = false
				end
				return isVisible
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
		element.portraitIcon:close()
		element.wearableIcon:close()
		element.Label3:close()
		element.Glow:close()
		element.Image0:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end