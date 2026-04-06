--[[local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        self.ScoreText:completeAnimation()
        self.ScoreText:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
        CoD.UIColors.SetElementColor( self.ScoreText, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end--]]

--[[ local UpdatePortraitIcon = function( self, controller, modelValue )
    if modelValue and modelValue >= 0 then
        local charEntry = CoD.CharacterTable[modelValue + 1]
        if charEntry and charEntry.models and charEntry.models.image then
            self.PortraitImage:setImage( RegisterImage( charEntry.models.image ) )
            return
        end
    end

    local iconModel = Engine.GetModel( self:getModel(), "zombiePlayerIcon" )
    if iconModel then
        local zombiePlayerIcon = Engine.GetModelValue( iconModel )
        local mapName = Engine.GetCurrentMap()

        if zombiePlayerIcon then
            if mapName and mapPortraidOverride and mapPortraidOverride[mapName] then
                zombiePlayerIcon = portraitIcons[zombiePlayerIcon] or zombiePlayerIcon
            end
            
            self.PortraitImage:setImage( RegisterImage( zombiePlayerIcon ) )
        end
    end
end ]]
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
        self.PortraitImage:setImage( RegisterImage( foundImage ) )
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
            
            self.PortraitImage:setImage( RegisterImage( zombiePlayerIcon ) )
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
    -- 1. Get the models
    local controllerModel = Engine.GetModelForController( controller )
    local characterIndexModel = Engine.GetModel( controllerModel, "SelectedCharacterIndex" )

    -- 2. Character Selection Subscription (Custom Character)
    self:subscribeToModel( characterIndexModel, function( model )
        UpdatePortraitIcon( self, controller, Engine.GetModelValue( model ) )
    end )

    -- 3. Default Icon Subscription (Fallback)
    self.PortraitImage:linkToElementModel( self, "zombiePlayerIcon", true, function( model )
        local charIndex = Engine.GetModelValue( characterIndexModel )
        
        -- ONLY apply the default map icon if the custom character index is invalid
        if charIndex == nil or charIndex < 0 then
            UpdatePortraitIcon( self, controller, charIndex )
        end
    end )
end

CoD.T8ClientScore = InheritFrom( LUI.UIElement )
CoD.T8ClientScore.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.T8ClientScore )
	self.id = "T8ClientScore"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true
	
	self.ScoreBG = LUI.UIImage.new()
	self.ScoreBG:setLeftRight( true, false, 25, 153.5 )
	self.ScoreBG:setTopBottom( false, true, -172.5, -114.5 )
	self.ScoreBG:setImage( RegisterImage( "t8_hud_playercard_sm_bg" ) )
	self:addElement( self.ScoreBG )

	self.PortraitImage = LUI.UIImage.new()
	self.PortraitImage:setLeftRight( true, false, 19, 87 )
	self.PortraitImage:setTopBottom( false, true, -172 - 10, -112.5 + 10 )
	self.PortraitImage:setScale( 0.67 )
	self.PortraitImage:setImage( RegisterImage( "blacktransparent" ) )
	self.PortraitImage:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.PortraitImage:setShaderVector( 0, 0.3, 0.2, 0.2, 0.4 )
	--[[self.PortraitImage:linkToElementModel( self, "zombiePlayerIcon", true, function ( model )
		local zombiePlayerIcon = Engine.GetModelValue( model )
		
		if zombiePlayerIcon then
			if zombiePlayerIcon == "uie_t7_zm_hud_score_char1" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_nikolai" ) )

			elseif zombiePlayerIcon == "uie_t7_zm_hud_score_char1_old" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_specialist_portrait_nikolai_ultimus" ) )

			elseif zombiePlayerIcon == "uie_t7_zm_hud_score_char2" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_takeo" ) )

			elseif zombiePlayerIcon == "uie_t7_zm_hud_score_char2_old" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_specialist_portrait_takeo_ultimus" ) )

			elseif zombiePlayerIcon == "uie_t7_zm_hud_score_char3" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_dempsey" ) )

			elseif zombiePlayerIcon == "uie_t7_zm_hud_score_char3_old" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_specialist_portrait_dempsey_ultimus" ) )

			elseif zombiePlayerIcon == "uie_t7_zm_hud_score_char4" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_richtofen" ) )

			elseif zombiePlayerIcon == "uie_t7_zm_hud_score_char4_old" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_specialist_portrait_richtofen_ultimus" ) )

			elseif zombiePlayerIcon == "uie_t7_zm_hud_score_char5" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_jessica" ) )

			elseif zombiePlayerIcon == "uie_t7_zm_hud_score_char6" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_jack" ) )

			elseif zombiePlayerIcon == "uie_t7_zm_hud_score_char7" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_nero" ) )

			elseif zombiePlayerIcon == "uie_t7_zm_hud_score_char8" then
				self.PortraitImage:setImage( RegisterImage( "ui_icon_hero_portrait_draft_floyd" ) )
			end
		end
	end )--]]
	self:addElement( self.PortraitImage )

	self.ScoreTextGlow = LUI.UIImage.new()
	self.ScoreTextGlow:setLeftRight( true, false, 64, 150.5 )
	self.ScoreTextGlow:setTopBottom( false, true, -155, -130 )
	self.ScoreTextGlow:setAlpha( 0.3 )
	self.ScoreTextGlow:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.ScoreTextGlow:linkToElementModel( self, "clientNum", true, function ( model )
		local clientNum = Engine.GetModelValue( model )

		if clientNum then
			self.ScoreTextGlow:setRGB( ZombieClientScoreboardColor( clientNum ) )
		end
	end )
	self:addElement( self.ScoreTextGlow )

	self.ScoreText = LUI.UIText.new()
	self.ScoreText:setLeftRight( true, false, 64, 150.5 )
	self.ScoreText:setTopBottom( false, true, -150, -135 )
	self.ScoreText:setTTF( "fonts/skorzhen.ttf" )
	self.ScoreText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	--[[self.ScoreText:linkToElementModel( self, "clientNum", true, function ( model )
		local clientNum = Engine.GetModelValue( model )

		if clientNum then
			self.ScoreText:setRGB( ZombieClientScoreboardColor( clientNum ) )
		end
	end )--]]
	self.ScoreText:linkToElementModel( self, "playerScore", true, function ( model )
		local playerScore = Engine.GetModelValue( model )

		if playerScore then
			self.ScoreText:setText( Engine.Localize( playerScore ) )
		end
	end )
	self:addElement( self.ScoreText )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.ScoreBG:completeAnimation()
				self.ScoreBG:setAlpha( 0 )
				self.clipFinished( self.ScoreBG, {} )

				self.PortraitImage:completeAnimation()
				self.PortraitImage:setAlpha( 0 )
				self.clipFinished( self.PortraitImage, {} )

				self.ScoreTextGlow:completeAnimation()
				self.ScoreTextGlow:setAlpha( 0 )
				self.clipFinished( self.ScoreTextGlow, {} )

				self.ScoreText:completeAnimation()
				self.ScoreText:setAlpha( 0 )
				self.clipFinished( self.ScoreText, {} )
			end
		},
		Visible = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.ScoreBG:completeAnimation()
				self.ScoreBG:setAlpha( 1 )
				self.clipFinished( self.ScoreBG, {} )

				self.PortraitImage:completeAnimation()
				self.PortraitImage:setAlpha( 1 )
				self.clipFinished( self.PortraitImage, {} )

				self.ScoreTextGlow:completeAnimation()
				self.ScoreTextGlow:setAlpha( 0.3 )
				self.clipFinished( self.ScoreTextGlow, {} )

				self.ScoreText:completeAnimation()
				self.ScoreText:setAlpha( 1 )
				self.clipFinished( self.ScoreText, {} )
			end
		}
	}

	self:mergeStateConditions( {
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
		element.ScoreBG:close()
		element.PortraitImage:close()
		element.ScoreTextGlow:close()
		element.ScoreText:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end
