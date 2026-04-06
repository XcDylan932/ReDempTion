local portraitIcons = {
    uie_t7_zm_hud_score_char1     = "ui_icon_hero_portrait_draft_nikolai",
    uie_t7_zm_hud_score_char1_old = "ui_icon_specialist_portrait_nikolai_ultimus",
    uie_t7_zm_hud_score_char2     = "ui_icon_hero_portrait_draft_takeo",
    uie_t7_zm_hud_score_char2_old = "ui_icon_specialist_portrait_takeo_ultimus",
    uie_t7_zm_hud_score_char3     = "ui_icon_hero_portrait_draft_dempsey",
    uie_t7_zm_hud_score_char3_old = "ui_icon_specialist_portrait_dempsey_ultimus",
    uie_t7_zm_hud_score_char4     = "ui_icon_hero_portrait_draft_richtofen",
    uie_t7_zm_hud_score_char4_old = "ui_icon_specialist_portrait_richtofen_ultimus",
    uie_t7_zm_hud_score_char5     = "ui_icon_hero_portrait_draft_jessica",
    uie_t7_zm_hud_score_char6     = "ui_icon_hero_portrait_draft_jack",
    uie_t7_zm_hud_score_char7     = "ui_icon_hero_portrait_draft_nero",
    uie_t7_zm_hud_score_char8     = "ui_icon_hero_portrait_draft_floyd"
}

local mapPortraidOverride = {
	zm_prototye = true,
	zm_asylum = true,
	zm_sumpf = true,
	zm_factory = true,
	zm_theater = true,
	zm_cosmodrome = true,
	zm_temple = true,
	zm_moon = true,
	zm_tomb = true,
	zm_zod = true,
	zm_castle = true,
	zm_island = true,
	zm_stalingrad = true,
	zm_genesis = true
}

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
	self.UpdateColors = function( self )
        local elements = { self.ScoreText, self.ScoreBG }
        for _, element in ipairs( elements ) do
            if element then
                element:completeAnimation()
                element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
                CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
            end
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

    self.PortraitImage:linkToElementModel( self, "zombiePlayerIcon", true, function( model )
        local charIndex = Engine.GetModelValue( characterIndexModel )
        
        if charIndex == nil or charIndex < 0 then
            UpdatePortraitIcon( self, controller, charIndex )
        end
    end )
end

CoD.T8SelfScore = InheritFrom( LUI.UIElement )
CoD.T8SelfScore.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.T8SelfScore )
	self.id = "T8SelfScore"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.ScoreBGGlow = LUI.UIImage.new()
	self.ScoreBGGlow:setLeftRight( true, false, 25.5, 237 )
	self.ScoreBGGlow:setTopBottom( false, true, -96, -23 )
	self.ScoreBGGlow:setImage( RegisterImage( "t8_hud_ammowidget_bg_glow" ) )
	self.ScoreBGGlow:setYRot( 180 )
	self.ScoreBGGlow:setAlpha( 0.5 )
	self:addElement( self.ScoreBGGlow )

	self.ScoreBG = LUI.UIImage.new()
	self.ScoreBG:setLeftRight( true, false, 25.5, 237 )
	self.ScoreBG:setTopBottom( false, true, -96, -23 )
	self.ScoreBG:setImage( RegisterImage( "t8_hud_ammowidget_bg" ) )
	self.ScoreBG:setYRot( 180 )
	self:addElement( self.ScoreBG )

	self.PortraitImage = LUI.UIImage.new()
	self.PortraitImage:setLeftRight( true, false, 19, 103 )
	self.PortraitImage:setTopBottom( false, true, -96 - 10, -22 + 10 )
	self.PortraitImage:setScale( 0.67 )
	self.PortraitImage:setImage( RegisterImage( "blacktransparent" ) )
	self.PortraitImage:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.PortraitImage:setShaderVector( 0, 0.3, 0.2, 0.2, 0.4 )
	self:addElement( self.PortraitImage )

	self.ScoreText = LUI.UIText.new()
	self.ScoreText:setLeftRight( true, false, 91, 237 )
	self.ScoreText:setTopBottom( false, true, -77.5 + 5, -47.5 + 5 )
	self.ScoreText:setTTF( "fonts/skorzhen.ttf" )
	self.ScoreText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.ScoreText:linkToElementModel( self, "playerScore", true, function( model )
		local playerScore = Engine.GetModelValue( model )

		if playerScore then
			self.ScoreText:setText( Engine.Localize( playerScore ) )
		end
	end )
	self:addElement( self.ScoreText )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.ScoreBGGlow:close()
		element.ScoreBG:close()
		element.PortraitImage:close()
		element.ScoreText:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end