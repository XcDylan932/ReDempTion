local portraitIcons = {
    uie_t7_zm_hud_score_char1     = "ui_icon_operators_nikolai",
    uie_t7_zm_hud_score_char1_old = "ui_icon_operators_nikolai_waw",
    uie_t7_zm_hud_score_char2     = "ui_icon_operators_takeo",
    uie_t7_zm_hud_score_char2_old = "ui_icon_operators_takeo_waw",
    uie_t7_zm_hud_score_char3     = "ui_icon_operators_dempsey",
    uie_t7_zm_hud_score_char3_old = "ui_icon_operators_dempsey_waw",
    uie_t7_zm_hud_score_char4     = "ui_icon_operators_richtofen",
    uie_t7_zm_hud_score_char4_old = "ui_icon_operators_richtofen_waw",
    uie_t7_zm_hud_score_char5     = "ui_icon_operators_jessica",
    uie_t7_zm_hud_score_char6     = "ui_icon_operators_jack",
    uie_t7_zm_hud_score_char7     = "ui_icon_operators_nero",
    uie_t7_zm_hud_score_char8     = "ui_icon_operators_floyd"
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
        self.Portrait:setImage( RegisterImage( foundImage ) )
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
            
            self.Portrait:setImage( RegisterImage( zombiePlayerIcon ) )
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
		local elements = { self.Circle, self.PortraitBG, self.PortraitOutline }
		for _, element in ipairs( elements ) do
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

    self.Portrait:linkToElementModel( self, "zombiePlayerIcon", true, function( model )
        local charIndex = Engine.GetModelValue( characterIndexModel )
        
        if charIndex == nil or charIndex < 0 then
            UpdatePortraitIcon( self, controller, charIndex )
        end
    end )
end

CoD.T10SelfScore = InheritFrom( LUI.UIElement )
CoD.T10SelfScore.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.T10SelfScore )
	self.id = "T10SelfScore"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.Circle = LUI.UIImage.new()
	self.Circle:setLeftRight( true, false, 74, 111.5 )
	self.Circle:setTopBottom( false, true, -67.5, -30 )
	self.Circle:setImage( RegisterImage( "hud_icon_minimap_player_squad_circle" ) )
	self:addElement( self.Circle )

	self.CircleText = LUI.UIText.new()
	self.CircleText:setLeftRight( true, false, 74 - 100, 111.5 + 100 )
	self.CircleText:setTopBottom( false, true, -67.5, -30 )
	self.CircleText:setText( Engine.Localize( "" ) )
	self.CircleText:setTTF( "fonts/kairos_sans_w1g_cn_bold.ttf" )
	self.CircleText:setRGB( 0, 0, 0 )
	self.CircleText:setScale( 0.5 )
	self.CircleText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.CircleText:linkToElementModel( self, "clientNum", true, function( model )
		local clientNum = Engine.GetModelValue( model )

		if clientNum then
			self.CircleText:setText( Engine.Localize( clientNum + 1 ) )
		end
	end )
	self:addElement( self.CircleText )

	self.PortraitBG = LUI.UIImage.new()
	self.PortraitBG:setLeftRight( true, false, 27, 80 )
	self.PortraitBG:setTopBottom( false, true, -79, -19 )
	self.PortraitBG:setImage( RegisterImage( "ui_icon_portrait_background" ) )
	self.PortraitBG:setRGB( 1, 0, 0 )
	self:addElement( self.PortraitBG )

	self.Portrait = LUI.UIImage.new()
	self.Portrait:setLeftRight( true, false, 27, 80 )
	self.Portrait:setTopBottom( false, true, -79, -19 )
	self.Portrait:setImage( RegisterImage( "blacktransparent" ) )
	--[[self.Portrait:linkToElementModel( self, "zombiePlayerIcon", true, function( model )
		local zombiePlayerIcon = Engine.GetModelValue( model )
		local mapName = Engine.GetCurrentMap()

		if zombiePlayerIcon then
			if mapName and mapPortraidOverride[ mapName ] then
				zombiePlayerIcon = portraitIcons[ zombiePlayerIcon ] or zombiePlayerIcon
			end

			self.Portrait:setImage( RegisterImage( zombiePlayerIcon ) )
		end
	end )--]]
	self:addElement( self.Portrait )

	self.PortraitOutline = LUI.UIImage.new()
	self.PortraitOutline:setLeftRight( true, false, 27, 80 )
	self.PortraitOutline:setTopBottom( false, true, -79, -19 )
	self.PortraitOutline:setImage( RegisterImage( "ui_icon_portrait_outline" ) )
	self.PortraitOutline:setRGB( 0.70, 0.35, 0.35 )
	self:addElement( self.PortraitOutline )

	self.NameShadow = LUI.UIText.new()
	self.NameShadow:setLeftRight( true, true, -290, 0 )
	self.NameShadow:setTopBottom( false, true, -68, -31 )
	self.NameShadow:setTTF( "fonts/noto_sans_cond_med.ttf" )
	self.NameShadow:setMaterial( LUI.UIImage.GetCachedMaterial( "sw4_2d_uie_font_cached_glow" ) )
	self.NameShadow:setShaderVector( 0, 0.1, 0, 0, 0 )
	self.NameShadow:setShaderVector( 1, 0.1, 0, 0, 0 )
	self.NameShadow:setShaderVector( 2, 1, 0, 0, 0 )
	self.NameShadow:setScale( 0.5 )
	self.NameShadow:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.NameShadow:setRGB( 0.3, 0.3, 0.3 )
	self.NameShadow:linkToElementModel( self, "playerName", true, function( model )
		local name = Engine.GetModelValue( model )

		if name then
			self.NameShadow:setText( Engine.Localize( name ) )
		end
	end )
	self:addElement( self.NameShadow )

	self.Name = LUI.UIText.new()
	self.Name:setLeftRight( true, true, -290, 0 )
	self.Name:setTopBottom( false, true, -68, -31 )
	self.Name:setTTF( "fonts/noto_sans_cond_med.ttf" )
	self.Name:setScale( 0.5 )
	self.Name:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.Name:linkToElementModel( self, "playerName", true, function( model )
		local name = Engine.GetModelValue( model )

		if name then
			self.Name:setText( Engine.Localize( name ) )
		end
	end )
	self:addElement( self.Name )

	self.ScoreIcon = LUI.UIImage.new()
	self.ScoreIcon:setLeftRight( true, false, 151 - 68, 172 - 68 )
	self.ScoreIcon:setTopBottom( false, true, -39, -18.5 )
	self.ScoreIcon:setImage( RegisterImage( "ui_icons_zombie_squad_info_essence" ) )
	self:addElement( self.ScoreIcon )

	self.ScoreShadow = LUI.UIText.new()
	self.ScoreShadow:setLeftRight( true, true, -199 - 65, 0 - 65 )
	self.ScoreShadow:setTopBottom( false, true, -46, -9 )
	self.ScoreShadow:setTTF( "fonts/kairos_sans_w1g_cn.ttf" )
	self.ScoreShadow:setMaterial( LUI.UIImage.GetCachedMaterial( "sw4_2d_uie_font_cached_glow" ) )
	self.ScoreShadow:setShaderVector( 0, 0.2, 0, 0, 0 )
	self.ScoreShadow:setShaderVector( 1, 0.1, 0, 0, 0 )
	self.ScoreShadow:setShaderVector( 2, 1, 0, 0, 0 )
	self.ScoreShadow:setRGB( 0.1, 0.1, 0.1 )
	self.ScoreShadow:setScale( 0.5 )
	self.ScoreShadow:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.ScoreShadow:linkToElementModel( self, "playerScore", true, function( model )
		local score = Engine.GetModelValue( model )

		if score then
			self.ScoreShadow:setText( Engine.Localize( score ) )
		end
	end )
	self:addElement( self.ScoreShadow )

	self.Score = LUI.UIText.new()
	self.Score:setLeftRight( true, true, -199 - 65, 0 - 65 )
	self.Score:setTopBottom( false, true, -46, -9 )
	self.Score:setTTF( "fonts/kairos_sans_w1g_cn.ttf" )
	self.Score:setRGB( 0.9, 0.80, 0.2 )
	self.Score:setScale( 0.5 )
	self.Score:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.Score:linkToElementModel( self, "playerScore", true, function( model )
		local score = Engine.GetModelValue( model )

		if score then
			self.Score:setText( Engine.Localize( score ) )
		end
	end )
	self:addElement( self.Score )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.Circle:close()
		element.CircleText:close()
		element.PortraitBG:close()
		element.Portrait:close()
		element.PortraitOutline:close()
		element.NameShadow:close()
		element.Name:close()
		element.ScoreIcon:close()
		element.ScoreShadow:close()
		element.Score:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end