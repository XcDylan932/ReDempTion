local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        self.ScoreText:completeAnimation()
        self.ScoreText:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
        CoD.UIColors.SetElementColor( self.ScoreText, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.T6ClientScore = InheritFrom( LUI.UIElement )
CoD.T6ClientScore.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.T6ClientScore )
	self.id = "T6ClientScore"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.ScoreBG = LUI.UIImage.new()
	self.ScoreBG:setLeftRight( false, true, -158 - 50, 0 - 50 )
	self.ScoreBG:setTopBottom( false, true, -155, -115 )
	self.ScoreBG:setImage( RegisterImage( "blacktransparent" ) )
	self.ScoreBG:setRGB( 0.21, 0, 0 )
	self.ScoreBG:linkToElementModel( self, "clientNum", true, function ( model )
		local clientNum = Engine.GetModelValue( model )

		if clientNum then
			if clientNum == Engine.GetClientNum( controller ) then
				self.ScoreBG:setImage( RegisterImage( "scorebar_zom_5" ) )
			else
				self.ScoreBG:setImage( RegisterImage( "blacktransparent" ) )
			end
		end
	end )
	self:addElement( self.ScoreBG )

	self.ScoreText = LUI.UIText.new()
	-- Anchor it to the Right (false, true)
	-- -250 (Left edge of the box) to -10 (Right edge of the box)
	-- This creates a box that is 240 pixels wide, ending 10 pixels from the screen edge
	self.ScoreText:setLeftRight( false, true, -380 + 50, -145 + 50 ) 
	self.ScoreText:setTopBottom( false, true, -152.5, -115 )
	self.ScoreText:setTTF( "fonts/bigFont.ttf" )
	-- CHANGE THIS TO RIGHT
	self.ScoreText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )

	self.ScoreText:linkToElementModel( self, "playerScore", true, function ( model )
		local playerScore = Engine.GetModelValue( model )

		if playerScore then
			self.ScoreText:setText( Engine.Localize( playerScore ) )
		end
	end )

	self.ScoreText:linkToElementModel( self, "clientNum", true, function ( model )
		local clientNum = Engine.GetModelValue( model )
		if clientNum then
			if clientNum == Engine.GetClientNum( controller ) then
				-- Standard position (Anchored false, true)
				self.ScoreText:setLeftRight( false, true, -380 + 50, -145 + 50 )
			else
				-- Offset position
				self.ScoreText:setLeftRight( false, true, -380 + 7.5, -145 + 7.5 )
			end
		end
	end )

	self:addElement( self.ScoreText )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.ScoreBG:completeAnimation()
				self.ScoreBG:setAlpha( 0 )
				self.clipFinished( self.ScoreBG, {} )

				self.ScoreText:completeAnimation()
				self.ScoreText:setAlpha( 0 )
				self.clipFinished( self.ScoreText, {} )
			end
		},
		Visible = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.ScoreBG:completeAnimation()
				self.ScoreBG:setAlpha( 1 )
				self.clipFinished( self.ScoreBG, {} )

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
		element.ScoreText:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end
