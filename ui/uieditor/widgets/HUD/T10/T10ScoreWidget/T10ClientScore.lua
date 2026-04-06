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

CoD.T10ClientScore = InheritFrom( LUI.UIElement )
CoD.T10ClientScore.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.T10ClientScore )
	self.id = "T10ClientScore"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.Circle = LUI.UIImage.new()
	self.Circle:setLeftRight( true, false, 53.5, 84 )
	self.Circle:setTopBottom( false, true, -132, -101.5 )
	self.Circle:setImage( RegisterImage( "hud_icon_minimap_player_squad_circle" ) )
	self.Circle:linkToElementModel( self, "clientNum", true, function( model )
		local clientNum = Engine.GetModelValue( model )

		if clientNum then
			self.Circle:setRGB( ZombieClientScoreboardColor( clientNum ) )
		end
	end )
	self:addElement( self.Circle )

	self.CircleText = LUI.UIText.new()
	self.CircleText:setLeftRight( true, false, 53.5 - 100, 84 + 100 )
	self.CircleText:setTopBottom( false, true, -132, -101.5 )
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
	self.PortraitBG:setLeftRight( true, false, 27, 58 )
	self.PortraitBG:setTopBottom( false, true, -125, -91 )
	self.PortraitBG:setImage( RegisterImage( "ui_icon_portrait_background" ) )
	self.PortraitBG:setRGB( 1, 0, 0 )
	self:addElement( self.PortraitBG )

	self.Portrait = LUI.UIImage.new()
	self.Portrait:setLeftRight( true, false, 27, 58 )
	self.Portrait:setTopBottom( false, true, -125, -91 )
	self.Portrait:setImage( RegisterImage( "blacktransparent" ) )
	self.Portrait:linkToElementModel( self, "zombiePlayerIcon", true, function( model )
		local zombiePlayerIcon = Engine.GetModelValue( model )
		local mapName = Engine.GetCurrentMap()

		if zombiePlayerIcon then
			if mapName and mapPortraidOverride[ mapName ] then
				zombiePlayerIcon = portraitIcons[ zombiePlayerIcon ] or zombiePlayerIcon
			end

			self.Portrait:setImage( RegisterImage( zombiePlayerIcon ) )
		end
	end )
	self:addElement( self.Portrait )

	self.PortraitOutline = LUI.UIImage.new()
	self.PortraitOutline:setLeftRight( true, false, 27, 58 )
	self.PortraitOutline:setTopBottom( false, true, -125, -91 )
	self.PortraitOutline:setImage( RegisterImage( "ui_icon_portrait_outline" ) )
	self.PortraitOutline:setRGB( 0.70, 0.35, 0.35 )
	self:addElement( self.PortraitOutline )

	self.NameShadow = LUI.UIText.new()
	self.NameShadow:setLeftRight( true, true, -322, 0 )
	self.NameShadow:setTopBottom( false, true, -124 - 8, -109.5 + 8 )
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
	self.Name:setLeftRight( true, true, -322, 0 )
	self.Name:setTopBottom( false, true, -124 - 8, -109.5 + 8 )
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
	self.ScoreIcon:setLeftRight( true, false, 152, 168 )
	self.ScoreIcon:setTopBottom( false, true, -106, -90.5 )
	self.ScoreIcon:setImage( RegisterImage( "ui_icons_zombie_squad_info_essence" ) )
	self:addElement( self.ScoreIcon )

	self.ScoreShadow = LUI.UIText.new()
	self.ScoreShadow:setLeftRight( true, true, -203, 0 )
	self.ScoreShadow:setTopBottom( false, true, -112, -82.5 )
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
	self.Score:setLeftRight( true, true, -203, 0 )
	self.Score:setTopBottom( false, true, -112, -82.5 )
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

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 10 )

				self.Circle:completeAnimation()
				self.Circle:setAlpha( 0 )
				self.clipFinished( self.Circle, {} )

				self.CircleText:completeAnimation()
				self.CircleText:setAlpha( 0 )
				self.clipFinished( self.CircleText, {} )

				self.PortraitBG:completeAnimation()
				self.PortraitBG:setAlpha( 0 )
				self.clipFinished( self.PortraitBG, {} )

				self.Portrait:completeAnimation()
				self.Portrait:setAlpha( 0 )
				self.clipFinished( self.Portrait, {} )

				self.PortraitOutline:completeAnimation()
				self.PortraitOutline:setAlpha( 0 )
				self.clipFinished( self.PortraitOutline, {} )

				self.NameShadow:completeAnimation()
				self.NameShadow:setAlpha( 0 )
				self.clipFinished( self.NameShadow, {} )

				self.Name:completeAnimation()
				self.Name:setAlpha( 0 )
				self.clipFinished( self.Name, {} )

				self.ScoreIcon:completeAnimation()
				self.ScoreIcon:setAlpha( 0 )
				self.clipFinished( self.ScoreIcon, {} )

				self.ScoreShadow:completeAnimation()
				self.ScoreShadow:setAlpha( 0 )
				self.clipFinished( self.ScoreShadow, {} )

				self.Score:completeAnimation()
				self.Score:setAlpha( 0 )
				self.clipFinished( self.Score, {} )
			end
		},

		Visible = {
			DefaultClip = function()
				self:setupElementClipCounter( 10 )

				self.Circle:completeAnimation()
				self.Circle:setAlpha( 1 )
				self.clipFinished( self.Circle, {} )

				self.CircleText:completeAnimation()
				self.CircleText:setAlpha( 1 )
				self.clipFinished( self.CircleText, {} )

				self.PortraitBG:completeAnimation()
				self.PortraitBG:setAlpha( 1 )
				self.clipFinished( self.PortraitBG, {} )

				self.Portrait:completeAnimation()
				self.Portrait:setAlpha( 1 )
				self.clipFinished( self.Portrait, {} )

				self.PortraitOutline:completeAnimation()
				self.PortraitOutline:setAlpha( 1 )
				self.clipFinished( self.PortraitOutline, {} )

				self.NameShadow:completeAnimation()
				self.NameShadow:setAlpha( 1 )
				self.clipFinished( self.NameShadow, {} )

				self.Name:completeAnimation()
				self.Name:setAlpha( 1 )
				self.clipFinished( self.Name, {} )

				self.ScoreIcon:completeAnimation()
				self.ScoreIcon:setAlpha( 1 )
				self.clipFinished( self.ScoreIcon, {} )

				self.ScoreShadow:completeAnimation()
				self.ScoreShadow:setAlpha( 1 )
				self.clipFinished( self.ScoreShadow, {} )

				self.Score:completeAnimation()
				self.Score:setAlpha( 1 )
				self.clipFinished( self.Score, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Visible",
			condition = function( menu, element, event )
				return not IsSelfModelValueEqualTo( element, controller, "playerScoreShown", 0 )
			end
		}
	} )

	self:linkToElementModel( self, "playerScoreShown", true, function( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "playerScoreShown" } )
	end )

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