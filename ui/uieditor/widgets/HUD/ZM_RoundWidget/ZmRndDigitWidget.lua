require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2Ext" )

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
    	local elements = { 
    		self.Nine,
    		self.NineGlow,
	    	self.Eight,
	    	self.EightGlow,
	    	self.Seven,
	    	self.SevenGlow,
	    	self.Six,
	    	self.SixGlow,
	    	self.Five,
	    	self.FiveGlow,
	    	self.Four,
	    	self.FourGlow,
	    	self.Three,
	    	self.ThreeGlow,
	    	self.Two,
	    	self.TwoGlow,
	    	self.One,
	    	self.OneGlow,
	    	self.Zero,
	    	self.ZeroGlow,
	    	self.ZmFxSpark2Ext0,
			self.ZmFxSpark2Ext00
		}
        for _, element in ipairs( elements ) do
            CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        end
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmRndDigitWidget = InheritFrom( LUI.UIElement )
CoD.ZmRndDigitWidget.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmRndDigitWidget )
	self.id = "ZmRndDigitWidget"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 56 )
	self:setTopBottom( true, false, 0, 80 )
	
	self.Nine = LUI.UIImage.new()
	self.Nine:setLeftRight( true, false, 0, 56 )
	self.Nine:setTopBottom( true, false, 0, 80 )
	self.Nine:setAlpha( 0 )
	self.Nine:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr9" ) )
	self.Nine:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Nine )
	
	self.NineLight = LUI.UIImage.new()
	self.NineLight:setLeftRight( true, false, 0, 56 )
	self.NineLight:setTopBottom( true, false, 0, 80 )
	self.NineLight:setAlpha( 0 )
	self.NineLight:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr9_act" ) )
	self.NineLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.NineLight:setShaderVector( 0, 1, 0, 0, 0 )
	self.NineLight:setShaderVector( 1, 0, 0, 0, 0 )
	self.NineLight:setShaderVector( 2, 1, 0, 0, 0 )
	self.NineLight:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.NineLight )
	
	self.NineGlow = LUI.UIImage.new()
	self.NineGlow:setLeftRight( true, false, 0, 56 )
	self.NineGlow:setTopBottom( true, false, 0, 80 )
	self.NineGlow:setAlpha( 0 )
	self.NineGlow:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr9_glow" ) )
	self.NineGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.NineGlow )
	
	self.Eight = LUI.UIImage.new()
	self.Eight:setLeftRight( true, false, 0, 56 )
	self.Eight:setTopBottom( true, false, 0, 80 )
	self.Eight:setAlpha( 0 )
	self.Eight:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr8" ) )
	self.Eight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Eight )
	
	self.EightLight = LUI.UIImage.new()
	self.EightLight:setLeftRight( true, false, 0, 56 )
	self.EightLight:setTopBottom( true, false, 0, 80 )
	self.EightLight:setAlpha( 0 )
	self.EightLight:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr8_act" ) )
	self.EightLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.EightLight:setShaderVector( 0, 1, 0, 0, 0 )
	self.EightLight:setShaderVector( 1, 0, 0, 0, 0 )
	self.EightLight:setShaderVector( 2, 1, 0, 0, 0 )
	self.EightLight:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.EightLight )
	
	self.EightGlow = LUI.UIImage.new()
	self.EightGlow:setLeftRight( true, false, 0, 56 )
	self.EightGlow:setTopBottom( true, false, 0, 80 )
	self.EightGlow:setAlpha( 0 )
	self.EightGlow:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr8_glow" ) )
	self.EightGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.EightGlow )
	
	self.Seven = LUI.UIImage.new()
	self.Seven:setLeftRight( true, false, 0, 56 )
	self.Seven:setTopBottom( true, false, 0, 80 )
	self.Seven:setAlpha( 0 )
	self.Seven:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr7" ) )
	self.Seven:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Seven )
	
	self.SevenLight = LUI.UIImage.new()
	self.SevenLight:setLeftRight( true, false, 0, 56 )
	self.SevenLight:setTopBottom( true, false, 0, 80 )
	self.SevenLight:setAlpha( 0 )
	self.SevenLight:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr7_act" ) )
	self.SevenLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.SevenLight:setShaderVector( 0, 1, 0, 0, 0 )
	self.SevenLight:setShaderVector( 1, 0, 0, 0, 0 )
	self.SevenLight:setShaderVector( 2, 1, 0, 0, 0 )
	self.SevenLight:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.SevenLight )
	
	self.SevenGlow = LUI.UIImage.new()
	self.SevenGlow:setLeftRight( true, false, 0, 56 )
	self.SevenGlow:setTopBottom( true, false, 0, 80 )
	self.SevenGlow:setAlpha( 0 )
	self.SevenGlow:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr7_glow" ) )
	self.SevenGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.SevenGlow )
	
	self.Six = LUI.UIImage.new()
	self.Six:setLeftRight( true, false, 0, 56 )
	self.Six:setTopBottom( true, false, 0, 80 )
	self.Six:setAlpha( 0 )
	self.Six:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr6" ) )
	self:addElement( self.Six )
	
	self.SixLight = LUI.UIImage.new()
	self.SixLight:setLeftRight( true, false, 0, 56 )
	self.SixLight:setTopBottom( true, false, 0, 80 )
	self.SixLight:setAlpha( 0 )
	self.SixLight:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr6_act" ) )
	self.SixLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.SixLight:setShaderVector( 0, 1, 0, 0, 0 )
	self.SixLight:setShaderVector( 1, 0, 0, 0, 0 )
	self.SixLight:setShaderVector( 2, 1, 0, 0, 0 )
	self.SixLight:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.SixLight )
	
	self.SixGlow = LUI.UIImage.new()
	self.SixGlow:setLeftRight( true, false, 0, 56 )
	self.SixGlow:setTopBottom( true, false, 0, 80 )
	self.SixGlow:setAlpha( 0 )
	self.SixGlow:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr6_glow" ) )
	self.SixGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.SixGlow )
	
	self.Five = LUI.UIImage.new()
	self.Five:setLeftRight( true, false, 0, 56 )
	self.Five:setTopBottom( true, false, 0, 80 )
	self.Five:setAlpha( 0 )
	self.Five:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr5" ) )
	self.Five:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Five )
	
	self.FiveLight = LUI.UIImage.new()
	self.FiveLight:setLeftRight( true, false, 0, 56 )
	self.FiveLight:setTopBottom( true, false, 0, 80 )
	self.FiveLight:setAlpha( 0 )
	self.FiveLight:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr5_act" ) )
	self.FiveLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.FiveLight:setShaderVector( 0, 1, 0, 0, 0 )
	self.FiveLight:setShaderVector( 1, 0, 0, 0, 0 )
	self.FiveLight:setShaderVector( 2, 1, 0, 0, 0 )
	self.FiveLight:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.FiveLight )
	
	self.FiveGlow = LUI.UIImage.new()
	self.FiveGlow:setLeftRight( true, false, 0, 56 )
	self.FiveGlow:setTopBottom( true, false, 0, 80 )
	self.FiveGlow:setAlpha( 0 )
	self.FiveGlow:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr5_glow" ) )
	self.FiveGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.FiveGlow )
	
	self.Four = LUI.UIImage.new()
	self.Four:setLeftRight( true, false, 0, 56 )
	self.Four:setTopBottom( true, false, 0, 80 )
	self.Four:setAlpha( 0 )
	self.Four:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr4" ) )
	self.Four:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Four )
	
	self.FourLight = LUI.UIImage.new()
	self.FourLight:setLeftRight( true, false, 0, 56 )
	self.FourLight:setTopBottom( true, false, 0, 80 )
	self.FourLight:setAlpha( 0 )
	self.FourLight:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr4_act" ) )
	self.FourLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.FourLight:setShaderVector( 0, 1, 0, 0, 0 )
	self.FourLight:setShaderVector( 1, 0, 0, 0, 0 )
	self.FourLight:setShaderVector( 2, 1, 0, 0, 0 )
	self.FourLight:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.FourLight )
	
	self.FourGlow = LUI.UIImage.new()
	self.FourGlow:setLeftRight( true, false, 0, 56 )
	self.FourGlow:setTopBottom( true, false, 0, 80 )
	self.FourGlow:setAlpha( 0 )
	self.FourGlow:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr4_glow" ) )
	self.FourGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.FourGlow )
	
	self.Three = LUI.UIImage.new()
	self.Three:setLeftRight( true, false, 0, 56 )
	self.Three:setTopBottom( true, false, 0, 80 )
	self.Three:setAlpha( 0 )
	self.Three:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr3" ) )
	self.Three:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Three )
	
	self.ThreeLight = LUI.UIImage.new()
	self.ThreeLight:setLeftRight( true, false, 0, 56 )
	self.ThreeLight:setTopBottom( true, false, 0, 80 )
	self.ThreeLight:setAlpha( 0 )
	self.ThreeLight:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr3_act" ) )
	self.ThreeLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.ThreeLight:setShaderVector( 0, 1, 0, 0, 0 )
	self.ThreeLight:setShaderVector( 1, 0, 0, 0, 0 )
	self.ThreeLight:setShaderVector( 2, 1, 0, 0, 0 )
	self.ThreeLight:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.ThreeLight )
	
	self.ThreeGlow = LUI.UIImage.new()
	self.ThreeGlow:setLeftRight( true, false, 0, 56 )
	self.ThreeGlow:setTopBottom( true, false, 0, 80 )
	self.ThreeGlow:setAlpha( 0 )
	self.ThreeGlow:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr3_glow" ) )
	self.ThreeGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ThreeGlow )
	
	self.Two = LUI.UIImage.new()
	self.Two:setLeftRight( true, false, 0, 56 )
	self.Two:setTopBottom( true, false, 0, 80 )
	self.Two:setAlpha( 0 )
	self.Two:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr2" ) )
	self:addElement( self.Two )
	
	self.TwoLight = LUI.UIImage.new()
	self.TwoLight:setLeftRight( true, false, 0, 56 )
	self.TwoLight:setTopBottom( true, false, 0, 80 )
	self.TwoLight:setAlpha( 0 )
	self.TwoLight:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr2_act" ) )
	self.TwoLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.TwoLight:setShaderVector( 0, 1, 0, 0, 0 )
	self.TwoLight:setShaderVector( 1, 0, 0, 0, 0 )
	self.TwoLight:setShaderVector( 2, 1, 0, 0, 0 )
	self.TwoLight:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.TwoLight )
	
	self.TwoGlow = LUI.UIImage.new()
	self.TwoGlow:setLeftRight( true, false, 0, 56 )
	self.TwoGlow:setTopBottom( true, false, 0, 80 )
	self.TwoGlow:setAlpha( 0 )
	self.TwoGlow:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr2_glow" ) )
	self.TwoGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.TwoGlow )
	
	self.One = LUI.UIImage.new()
	self.One:setLeftRight( true, false, 0, 56 )
	self.One:setTopBottom( true, false, 0, 80 )
	self.One:setAlpha( 0 )
	self.One:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr1" ) )
	self.One:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.One )
	
	self.OneLight = LUI.UIImage.new()
	self.OneLight:setLeftRight( true, false, 0, 56 )
	self.OneLight:setTopBottom( true, false, 0, 80 )
	self.OneLight:setAlpha( 0 )
	self.OneLight:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr1_act" ) )
	self.OneLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.OneLight:setShaderVector( 0, 1, 0, 0, 0 )
	self.OneLight:setShaderVector( 1, 0, 0, 0, 0 )
	self.OneLight:setShaderVector( 2, 1, 0, 0, 0 )
	self.OneLight:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.OneLight )
	
	self.OneGlow = LUI.UIImage.new()
	self.OneGlow:setLeftRight( true, false, 0, 56 )
	self.OneGlow:setTopBottom( true, false, 0, 80 )
	self.OneGlow:setAlpha( 0 )
	self.OneGlow:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr1_glow" ) )
	self.OneGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.OneGlow )
	
	self.Zero = LUI.UIImage.new()
	self.Zero:setLeftRight( true, false, 0, 56 )
	self.Zero:setTopBottom( true, false, 0, 80 )
	self.Zero:setAlpha( 0 )
	self.Zero:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr0" ) )
	self.Zero:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_blend" ) )
	self:addElement( self.Zero )
	
	self.ZeroLight = LUI.UIImage.new()
	self.ZeroLight:setLeftRight( true, false, 0, 56 )
	self.ZeroLight:setTopBottom( true, false, 0, 80 )
	self.ZeroLight:setAlpha( 0 )
	self.ZeroLight:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr0_act" ) )
	self.ZeroLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.ZeroLight:setShaderVector( 0, 1, 0, 0, 0 )
	self.ZeroLight:setShaderVector( 1, 0, 0, 0, 0 )
	self.ZeroLight:setShaderVector( 2, 1, 0, 0, 0 )
	self.ZeroLight:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.ZeroLight )
	
	self.ZeroGlow = LUI.UIImage.new()
	self.ZeroGlow:setLeftRight( true, false, 0, 56 )
	self.ZeroGlow:setTopBottom( true, false, 0, 80 )
	self.ZeroGlow:setAlpha( 0 )
	self.ZeroGlow:setImage( RegisterImage( "uie_t7_zm_hud_rnd_nmbr0_glow" ) )
	self.ZeroGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZeroGlow )
	
	self.ZmFxSpark2Ext0 = CoD.ZmFx_Spark2Ext.new( menu, controller )
	self.ZmFxSpark2Ext0:setLeftRight( true, false, -17.56, 94.44 )
	self.ZmFxSpark2Ext0:setTopBottom( true, false, -137.29, 30.71 )
	self.ZmFxSpark2Ext0:setAlpha( 0 )
	self.ZmFxSpark2Ext0:setZRot( 9 )
	self.ZmFxSpark2Ext0:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxSpark2Ext0 )
	
	self.ZmFxSpark2Ext00 = CoD.ZmFx_Spark2Ext.new( menu, controller )
	self.ZmFxSpark2Ext00:setLeftRight( true, false, -3.56, 108.44 )
	self.ZmFxSpark2Ext00:setTopBottom( true, false, -128, 40 )
	self.ZmFxSpark2Ext00:setAlpha( 0 )
	self.ZmFxSpark2Ext00:setZRot( 9 )
	self.ZmFxSpark2Ext00:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxSpark2Ext00 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 0 )
			end
		},

		One = {
			DefaultClip = function ()
				self:setupElementClipCounter( 31 )

				self.Nine:completeAnimation()
				self.Nine:setAlpha( 0 )
				self.clipFinished( self.Nine, {} )

				self.NineLight:completeAnimation()
				self.NineLight:setAlpha( 0 )
				self.clipFinished( self.NineLight, {} )

				self.NineGlow:completeAnimation()
				self.NineGlow:setAlpha( 0 )
				self.clipFinished( self.NineGlow, {} )

				self.Eight:completeAnimation()
				self.Eight:setAlpha( 0 )
				self.clipFinished( self.Eight, {} )

				self.EightLight:completeAnimation()
				self.EightLight:setAlpha( 0 )
				self.clipFinished( self.EightLight, {} )

				self.EightGlow:completeAnimation()
				self.EightGlow:setAlpha( 0 )
				self.clipFinished( self.EightGlow, {} )

				self.Seven:completeAnimation()
				self.Seven:setAlpha( 0 )
				self.clipFinished( self.Seven, {} )

				self.SevenLight:completeAnimation()
				self.SevenLight:setAlpha( 0 )
				self.clipFinished( self.SevenLight, {} )

				self.SevenGlow:completeAnimation()
				self.SevenGlow:setAlpha( 0 )
				self.clipFinished( self.SevenGlow, {} )

				self.Six:completeAnimation()
				self.Six:setAlpha( 0 )
				self.clipFinished( self.Six, {} )

				self.SixLight:completeAnimation()
				self.SixLight:setAlpha( 0 )
				self.clipFinished( self.SixLight, {} )

				self.SixGlow:completeAnimation()
				self.SixGlow:setAlpha( 0 )
				self.clipFinished( self.SixGlow, {} )

				self.Five:completeAnimation()
				self.Five:setAlpha( 0 )
				self.clipFinished( self.Five, {} )

				self.FiveLight:completeAnimation()
				self.FiveLight:setAlpha( 0 )
				self.clipFinished( self.FiveLight, {} )

				self.FiveGlow:completeAnimation()
				self.FiveGlow:setAlpha( 0 )
				self.clipFinished( self.FiveGlow, {} )

				self.Four:completeAnimation()
				self.Four:setAlpha( 0 )
				self.clipFinished( self.Four, {} )

				self.FourLight:completeAnimation()
				self.FourLight:setAlpha( 0 )
				self.clipFinished( self.FourLight, {} )

				self.FourGlow:completeAnimation()
				self.FourGlow:setAlpha( 0 )
				self.clipFinished( self.FourGlow, {} )

				self.Three:completeAnimation()
				self.Three:setAlpha( 0 )
				self.clipFinished( self.Three, {} )

				self.ThreeLight:completeAnimation()
				self.ThreeLight:setAlpha( 0 )
				self.clipFinished( self.ThreeLight, {} )

				self.ThreeGlow:completeAnimation()
				self.ThreeGlow:setAlpha( 0 )
				self.clipFinished( self.ThreeGlow, {} )

				self.Two:completeAnimation()
				self.Two:setAlpha( 0 )
				self.clipFinished( self.Two, {} )

				self.TwoLight:completeAnimation()
				self.TwoLight:setAlpha( 0 )
				self.clipFinished( self.TwoLight, {} )

				self.TwoGlow:completeAnimation()
				self.TwoGlow:setAlpha( 0 )
				self.clipFinished( self.TwoGlow, {} )

				local OneFrame2 = function ( element, event )
					local OneFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1509, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						OneFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1500, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", OneFrame3 )
					end
				end
				
				self.One:completeAnimation()
				self.One:setAlpha( 0 )
				OneFrame2( self.One, {} )

				local OneLightFrame2 = function ( element, event )
					local OneLightFrame3 = function ( element, event )
						local OneLightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 2210, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
							element:setShaderVector( 0, 1, 0, 0, 0 )
							element:setShaderVector( 1, 0, 0, 0, 0 )
							element:setShaderVector( 2, 1.16, 0, 0, 0 )
							element:setShaderVector( 3, 0.26, 0, 0, 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							OneLightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 610, false, false, CoD.TweenType.Linear )
							element:setShaderVector( 2, 1.16, 0, 0, 0 )
							element:registerEventHandler( "transition_complete_keyframe", OneLightFrame4 )
						end
					end
					
					if event.interrupted then
						OneLightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", OneLightFrame3 )
					end
				end
				
				self.OneLight:completeAnimation()
				self.OneLight:setAlpha( 1 )
				self.OneLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.OneLight:setShaderVector( 0, 1, 0, 0, 0 )
				self.OneLight:setShaderVector( 1, 0, 0, 0, 0 )
				self.OneLight:setShaderVector( 2, 0, 0, 0, 0 )
				self.OneLight:setShaderVector( 3, 0.26, 0, 0, 0 )
				OneLightFrame2( self.OneLight, {} )

				local OneGlowFrame2 = function ( element, event )
					local OneGlowFrame3 = function ( element, event )
						local OneGlowFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1009, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							OneGlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1509, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", OneGlowFrame4 )
						end
					end
					
					if event.interrupted then
						OneGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 490, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", OneGlowFrame3 )
					end
				end
				
				self.OneGlow:completeAnimation()
				self.OneGlow:setAlpha( 0 )
				OneGlowFrame2( self.OneGlow, {} )

				self.Zero:completeAnimation()
				self.Zero:setAlpha( 0 )
				self.clipFinished( self.Zero, {} )

				self.ZeroLight:completeAnimation()
				self.ZeroLight:setAlpha( 0 )
				self.clipFinished( self.ZeroLight, {} )

				self.ZeroGlow:completeAnimation()
				self.ZeroGlow:setAlpha( 0 )
				self.clipFinished( self.ZeroGlow, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							local ZmFxSpark2Ext0Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 449, false, false, CoD.TweenType.Linear )
								end
								element:setLeftRight( true, false, -13.56, 98.44 )
								element:setTopBottom( true, false, -75.29, 92.71 )
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 610, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, -13.56, 98.44 )
								element:setTopBottom( true, false, -75.29, 92.71 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.8 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 109, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, -17.56, 94.44 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -137.29, 30.71 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )
			end
		},

		Two = {
			DefaultClip = function ()
				self:setupElementClipCounter( 29 )

				self.Nine:completeAnimation()
				self.Nine:setAlpha( 0 )
				self.clipFinished( self.Nine, {} )

				self.NineLight:completeAnimation()
				self.NineLight:setAlpha( 0 )
				self.clipFinished( self.NineLight, {} )

				self.NineGlow:completeAnimation()
				self.NineGlow:setAlpha( 0 )
				self.clipFinished( self.NineGlow, {} )

				self.Eight:completeAnimation()
				self.Eight:setAlpha( 0 )
				self.clipFinished( self.Eight, {} )

				self.EightLight:completeAnimation()
				self.EightLight:setAlpha( 0 )
				self.clipFinished( self.EightLight, {} )

				self.EightGlow:completeAnimation()
				self.EightGlow:setAlpha( 0 )
				self.clipFinished( self.EightGlow, {} )

				self.Seven:completeAnimation()
				self.Seven:setAlpha( 0 )
				self.clipFinished( self.Seven, {} )

				self.SevenLight:completeAnimation()
				self.SevenLight:setAlpha( 0 )
				self.clipFinished( self.SevenLight, {} )

				self.SevenGlow:completeAnimation()
				self.SevenGlow:setAlpha( 0 )
				self.clipFinished( self.SevenGlow, {} )

				self.Six:completeAnimation()
				self.Six:setAlpha( 0 )
				self.clipFinished( self.Six, {} )

				self.SixLight:completeAnimation()
				self.SixLight:setAlpha( 0 )
				self.clipFinished( self.SixLight, {} )

				self.SixGlow:completeAnimation()
				self.SixGlow:setAlpha( 0 )
				self.clipFinished( self.SixGlow, {} )

				self.Five:completeAnimation()
				self.Five:setAlpha( 0 )
				self.clipFinished( self.Five, {} )

				self.FiveLight:completeAnimation()
				self.FiveLight:setAlpha( 0 )
				self.clipFinished( self.FiveLight, {} )

				self.FiveGlow:completeAnimation()
				self.FiveGlow:setAlpha( 0 )
				self.clipFinished( self.FiveGlow, {} )

				self.Four:completeAnimation()
				self.Four:setAlpha( 0 )
				self.clipFinished( self.Four, {} )

				self.FourLight:completeAnimation()
				self.FourLight:setAlpha( 0 )
				self.clipFinished( self.FourLight, {} )

				self.FourGlow:completeAnimation()
				self.FourGlow:setAlpha( 0 )
				self.clipFinished( self.FourGlow, {} )

				self.Three:completeAnimation()
				self.Three:setAlpha( 0 )
				self.clipFinished( self.Three, {} )

				self.ThreeLight:completeAnimation()
				self.ThreeLight:setAlpha( 0 )
				self.clipFinished( self.ThreeLight, {} )

				self.ThreeGlow:completeAnimation()
				self.ThreeGlow:setAlpha( 0 )
				self.clipFinished( self.ThreeGlow, {} )

				local TwoFrame2 = function ( element, event )
					local TwoFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1519, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						TwoFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1500, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", TwoFrame3 )
					end
				end
				
				self.Two:completeAnimation()
				self.Two:setAlpha( 0 )
				TwoFrame2( self.Two, {} )

				local TwoLightFrame2 = function ( element, event )
					local TwoLightFrame3 = function ( element, event )
						local TwoLightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
							element:setShaderVector( 0, 1, 0, 0, 0 )
							element:setShaderVector( 1, 0, 0, 0, 0 )
							element:setShaderVector( 2, 1, 0, 0, 0 )
							element:setShaderVector( 3, 0.22, 0, 0, 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							TwoLightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 810, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.55 )
							element:setShaderVector( 2, 1, 0, 0, 0 )
							element:registerEventHandler( "transition_complete_keyframe", TwoLightFrame4 )
						end
					end
					
					if event.interrupted then
						TwoLightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", TwoLightFrame3 )
					end
				end
				
				self.TwoLight:completeAnimation()
				self.TwoLight:setAlpha( 0 )
				self.TwoLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.TwoLight:setShaderVector( 0, 1, 0, 0, 0 )
				self.TwoLight:setShaderVector( 1, 0, 0, 0, 0 )
				self.TwoLight:setShaderVector( 2, 0, 0, 0, 0 )
				self.TwoLight:setShaderVector( 3, 0.22, 0, 0, 0 )
				TwoLightFrame2( self.TwoLight, {} )

				local TwoGlowFrame2 = function ( element, event )
					local TwoGlowFrame3 = function ( element, event )
						local TwoGlowFrame4 = function ( element, event )
							local TwoGlowFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 1009, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								TwoGlowFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 1379, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", TwoGlowFrame5 )
							end
						end
						
						if event.interrupted then
							TwoGlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 430, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", TwoGlowFrame4 )
						end
					end
					
					if event.interrupted then
						TwoGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", TwoGlowFrame3 )
					end
				end
				
				self.TwoGlow:completeAnimation()
				self.TwoGlow:setAlpha( 0 )
				TwoGlowFrame2( self.TwoGlow, {} )

				self.One:completeAnimation()
				self.One:setAlpha( 0 )
				self.clipFinished( self.One, {} )

				self.OneLight:completeAnimation()
				self.OneLight:setAlpha( 0 )
				self.clipFinished( self.OneLight, {} )

				self.OneGlow:completeAnimation()
				self.OneGlow:setAlpha( 0 )
				self.clipFinished( self.OneGlow, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							local ZmFxSpark2Ext0Frame5 = function ( element, event )
								local ZmFxSpark2Ext0Frame6 = function ( element, event )
									local ZmFxSpark2Ext0Frame7 = function ( element, event )
										local ZmFxSpark2Ext0Frame8 = function ( element, event )
											local ZmFxSpark2Ext0Frame9 = function ( element, event )
												local ZmFxSpark2Ext0Frame10 = function ( element, event )
													if not event.interrupted then
														element:beginAnimation( "keyframe", 359, false, false, CoD.TweenType.Linear )
													end
													element:setLeftRight( true, false, -7.56, 104.44 )
													element:setTopBottom( true, false, -86, 82 )
													element:setAlpha( 0 )
													if event.interrupted then
														self.clipFinished( element, event )
													else
														element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
													end
												end
												
												if event.interrupted then
													ZmFxSpark2Ext0Frame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
													element:setLeftRight( true, false, -7.56, 104.44 )
													element:setTopBottom( true, false, -86, 82 )
													element:setAlpha( 0.7 )
													element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame10 )
												end
											end
											
											if event.interrupted then
												ZmFxSpark2Ext0Frame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
												element:setLeftRight( true, false, -12.56, 99.44 )
												element:setTopBottom( true, false, -82.54, 85.46 )
												element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame9 )
											end
										end
										
										if event.interrupted then
											ZmFxSpark2Ext0Frame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 139, false, false, CoD.TweenType.Linear )
											element:setLeftRight( true, false, -20.56, 91.44 )
											element:setTopBottom( true, false, -77, 91 )
											element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame8 )
										end
									end
									
									if event.interrupted then
										ZmFxSpark2Ext0Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
										element:setLeftRight( true, false, -16.56, 95.44 )
										element:setTopBottom( true, false, -92, 76 )
										element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame7 )
									end
								end
								
								if event.interrupted then
									ZmFxSpark2Ext0Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -11.56, 100.44 )
									element:setTopBottom( true, false, -113, 55 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame6 )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 159, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, -10.56, 101.44 )
								element:setTopBottom( true, false, -128, 40 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -19.56, 92.44 )
							element:setTopBottom( true, false, -132.29, 35.71 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, -29.56, 82.44 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -121.29, 46.71 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext00, {} )
			end
		},

		Three = {
			DefaultClip = function ()
				self:setupElementClipCounter( 32 )

				self.Nine:completeAnimation()
				self.Nine:setAlpha( 0 )
				self.clipFinished( self.Nine, {} )

				self.NineLight:completeAnimation()
				self.NineLight:setAlpha( 0 )
				self.clipFinished( self.NineLight, {} )

				self.NineGlow:completeAnimation()
				self.NineGlow:setAlpha( 0 )
				self.clipFinished( self.NineGlow, {} )

				self.Eight:completeAnimation()
				self.Eight:setAlpha( 0 )
				self.clipFinished( self.Eight, {} )

				self.EightLight:completeAnimation()
				self.EightLight:setAlpha( 0 )
				self.clipFinished( self.EightLight, {} )

				self.EightGlow:completeAnimation()
				self.EightGlow:setAlpha( 0 )
				self.clipFinished( self.EightGlow, {} )

				self.Seven:completeAnimation()
				self.Seven:setAlpha( 0 )
				self.clipFinished( self.Seven, {} )

				self.SevenLight:completeAnimation()
				self.SevenLight:setAlpha( 0 )
				self.clipFinished( self.SevenLight, {} )

				self.SevenGlow:completeAnimation()
				self.SevenGlow:setAlpha( 0 )
				self.clipFinished( self.SevenGlow, {} )

				self.Six:completeAnimation()
				self.Six:setAlpha( 0 )
				self.clipFinished( self.Six, {} )

				self.SixLight:completeAnimation()
				self.SixLight:setAlpha( 0 )
				self.clipFinished( self.SixLight, {} )

				self.SixGlow:completeAnimation()
				self.SixGlow:setAlpha( 0 )
				self.clipFinished( self.SixGlow, {} )

				self.Five:completeAnimation()
				self.Five:setAlpha( 0 )
				self.clipFinished( self.Five, {} )

				self.FiveLight:completeAnimation()
				self.FiveLight:setAlpha( 0 )
				self.clipFinished( self.FiveLight, {} )

				self.FiveGlow:completeAnimation()
				self.FiveGlow:setAlpha( 0 )
				self.clipFinished( self.FiveGlow, {} )

				self.Four:completeAnimation()
				self.Four:setAlpha( 0 )
				self.clipFinished( self.Four, {} )

				self.FourLight:completeAnimation()
				self.FourLight:setAlpha( 0 )
				self.clipFinished( self.FourLight, {} )

				self.FourGlow:completeAnimation()
				self.FourGlow:setAlpha( 0 )
				self.clipFinished( self.FourGlow, {} )

				local ThreeFrame2 = function ( element, event )
					local ThreeFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1480, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ThreeFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1529, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ThreeFrame3 )
					end
				end
				
				self.Three:completeAnimation()
				self.Three:setAlpha( 0 )
				ThreeFrame2( self.Three, {} )

				local ThreeLightFrame2 = function ( element, event )
					local ThreeLightFrame3 = function ( element, event )
						local ThreeLightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 2000, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
							element:setShaderVector( 0, 1, 0, 0, 0 )
							element:setShaderVector( 1, 0, 0, 0, 0 )
							element:setShaderVector( 2, 1, 0, 0, 0 )
							element:setShaderVector( 3, 0.21, 0, 0, 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ThreeLightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 810, false, false, CoD.TweenType.Linear )
							element:setShaderVector( 2, 1, 0, 0, 0 )
							element:registerEventHandler( "transition_complete_keyframe", ThreeLightFrame4 )
						end
					end
					
					if event.interrupted then
						ThreeLightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ThreeLightFrame3 )
					end
				end
				
				self.ThreeLight:completeAnimation()
				self.ThreeLight:setAlpha( 1 )
				self.ThreeLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.ThreeLight:setShaderVector( 0, 1, 0, 0, 0 )
				self.ThreeLight:setShaderVector( 1, 0, 0, 0, 0 )
				self.ThreeLight:setShaderVector( 2, 0, 0, 0, 0 )
				self.ThreeLight:setShaderVector( 3, 0.21, 0, 0, 0 )
				ThreeLightFrame2( self.ThreeLight, {} )

				local ThreeGlowFrame2 = function ( element, event )
					local ThreeGlowFrame3 = function ( element, event )
						local ThreeGlowFrame4 = function ( element, event )
							local ThreeGlowFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								ThreeGlowFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 1529, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", ThreeGlowFrame5 )
							end
						end
						
						if event.interrupted then
							ThreeGlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 279, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", ThreeGlowFrame4 )
						end
					end
					
					if event.interrupted then
						ThreeGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ThreeGlowFrame3 )
					end
				end
				
				self.ThreeGlow:completeAnimation()
				self.ThreeGlow:setAlpha( 0 )
				ThreeGlowFrame2( self.ThreeGlow, {} )

				self.Two:completeAnimation()
				self.Two:setAlpha( 0 )
				self.clipFinished( self.Two, {} )

				self.TwoLight:completeAnimation()
				self.TwoLight:setAlpha( 0 )
				self.clipFinished( self.TwoLight, {} )

				self.TwoGlow:completeAnimation()
				self.TwoGlow:setAlpha( 0 )
				self.clipFinished( self.TwoGlow, {} )

				self.One:completeAnimation()
				self.One:setAlpha( 0 )
				self.clipFinished( self.One, {} )

				self.OneLight:completeAnimation()
				self.OneLight:setAlpha( 0 )
				self.clipFinished( self.OneLight, {} )

				self.OneGlow:completeAnimation()
				self.OneGlow:setAlpha( 0 )
				self.clipFinished( self.OneGlow, {} )

				self.Zero:completeAnimation()
				self.Zero:setAlpha( 0 )
				self.clipFinished( self.Zero, {} )

				self.ZeroLight:completeAnimation()
				self.ZeroLight:setAlpha( 0 )
				self.clipFinished( self.ZeroLight, {} )

				self.ZeroGlow:completeAnimation()
				self.ZeroGlow:setAlpha( 0 )
				self.clipFinished( self.ZeroGlow, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							local ZmFxSpark2Ext0Frame5 = function ( element, event )
								local ZmFxSpark2Ext0Frame6 = function ( element, event )
									local ZmFxSpark2Ext0Frame7 = function ( element, event )
										local ZmFxSpark2Ext0Frame8 = function ( element, event )
											local ZmFxSpark2Ext0Frame9 = function ( element, event )
												local ZmFxSpark2Ext0Frame10 = function ( element, event )
													local ZmFxSpark2Ext0Frame11 = function ( element, event )
														local ZmFxSpark2Ext0Frame12 = function ( element, event )
															local ZmFxSpark2Ext0Frame13 = function ( element, event )
																local ZmFxSpark2Ext0Frame14 = function ( element, event )
																	if not event.interrupted then
																		element:beginAnimation( "keyframe", 2240, false, false, CoD.TweenType.Linear )
																	end
																	element:setLeftRight( true, false, -19.56, 92.44 )
																	element:setTopBottom( true, false, -72, 96 )
																	element:setAlpha( 0 )
																	if event.interrupted then
																		self.clipFinished( element, event )
																	else
																		element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
																	end
																end
																
																if event.interrupted then
																	ZmFxSpark2Ext0Frame14( element, event )
																	return 
																else
																	element:beginAnimation( "keyframe", 470, false, false, CoD.TweenType.Linear )
																	element:setLeftRight( true, false, -18.73, 93.27 )
																	element:setAlpha( 0 )
																	element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame14 )
																end
															end
															
															if event.interrupted then
																ZmFxSpark2Ext0Frame13( element, event )
																return 
															else
																element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
																element:setLeftRight( true, false, -18.56, 93.44 )
																element:setTopBottom( true, false, -72, 96 )
																element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame13 )
															end
														end
														
														if event.interrupted then
															ZmFxSpark2Ext0Frame12( element, event )
															return 
														else
															element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
															element:setLeftRight( true, false, -2.56, 109.44 )
															element:setTopBottom( true, false, -86, 82 )
															element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame12 )
														end
													end
													
													if event.interrupted then
														ZmFxSpark2Ext0Frame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
														element:setLeftRight( true, false, -3.56, 108.44 )
														element:setTopBottom( true, false, -95, 73 )
														element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame11 )
													end
												end
												
												if event.interrupted then
													ZmFxSpark2Ext0Frame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 109, false, false, CoD.TweenType.Linear )
													element:setLeftRight( true, false, -16, 96 )
													element:setTopBottom( true, false, -103, 65 )
													element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame10 )
												end
											end
											
											if event.interrupted then
												ZmFxSpark2Ext0Frame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Linear )
												element:setLeftRight( true, false, -11, 101 )
												element:setTopBottom( true, false, -110, 58 )
												element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame9 )
											end
										end
										
										if event.interrupted then
											ZmFxSpark2Ext0Frame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 110, false, false, CoD.TweenType.Linear )
											element:setLeftRight( true, false, -5, 107 )
											element:setTopBottom( true, false, -120, 48 )
											element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame8 )
										end
									end
									
									if event.interrupted then
										ZmFxSpark2Ext0Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
										element:setLeftRight( true, false, -10, 102 )
										element:setTopBottom( true, false, -135, 33 )
										element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame7 )
									end
								end
								
								if event.interrupted then
									ZmFxSpark2Ext0Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -19, 93 )
									element:setTopBottom( true, false, -137, 31 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame6 )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 69, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, -26.06, 85.94 )
								element:setTopBottom( true, false, -127, 41 )
								element:setAlpha( 0.8 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 40, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0.29 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 129, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, -31, 81 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -120, 48 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext00, {} )
			end
		},

		Four = {
			DefaultClip = function ()
				self:setupElementClipCounter( 32 )

				self.Nine:completeAnimation()
				self.Nine:setAlpha( 0 )
				self.clipFinished( self.Nine, {} )

				self.NineLight:completeAnimation()
				self.NineLight:setAlpha( 0 )
				self.clipFinished( self.NineLight, {} )

				self.NineGlow:completeAnimation()
				self.NineGlow:setAlpha( 0 )
				self.clipFinished( self.NineGlow, {} )

				self.Eight:completeAnimation()
				self.Eight:setAlpha( 0 )
				self.clipFinished( self.Eight, {} )

				self.EightLight:completeAnimation()
				self.EightLight:setAlpha( 0 )
				self.clipFinished( self.EightLight, {} )

				self.EightGlow:completeAnimation()
				self.EightGlow:setAlpha( 0 )
				self.clipFinished( self.EightGlow, {} )

				self.Seven:completeAnimation()
				self.Seven:setAlpha( 0 )
				self.clipFinished( self.Seven, {} )

				self.SevenLight:completeAnimation()
				self.SevenLight:setAlpha( 0 )
				self.clipFinished( self.SevenLight, {} )

				self.SevenGlow:completeAnimation()
				self.SevenGlow:setAlpha( 0 )
				self.clipFinished( self.SevenGlow, {} )

				self.Six:completeAnimation()
				self.Six:setAlpha( 0 )
				self.clipFinished( self.Six, {} )

				self.SixLight:completeAnimation()
				self.SixLight:setAlpha( 0 )
				self.clipFinished( self.SixLight, {} )

				self.SixGlow:completeAnimation()
				self.SixGlow:setAlpha( 0 )
				self.clipFinished( self.SixGlow, {} )

				self.Five:completeAnimation()
				self.Five:setAlpha( 0 )
				self.clipFinished( self.Five, {} )

				self.FiveLight:completeAnimation()
				self.FiveLight:setAlpha( 0 )
				self.clipFinished( self.FiveLight, {} )

				self.FiveGlow:completeAnimation()
				self.FiveGlow:setAlpha( 0 )
				self.clipFinished( self.FiveGlow, {} )

				local FourFrame2 = function ( element, event )
					local FourFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1539, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						FourFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1480, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", FourFrame3 )
					end
				end
				
				self.Four:completeAnimation()
				self.Four:setAlpha( 0 )
				FourFrame2( self.Four, {} )

				local FourLightFrame2 = function ( element, event )
					local FourLightFrame3 = function ( element, event )
						local FourLightFrame4 = function ( element, event )
							local FourLightFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 649, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
								element:setShaderVector( 0, 1, 0, 0, 0 )
								element:setShaderVector( 1, 0, 0, 0, 0 )
								element:setShaderVector( 2, 1, 0, 0, 0 )
								element:setShaderVector( 3, 0.22, 0, 0, 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								FourLightFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 379, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", FourLightFrame5 )
							end
						end
						
						if event.interrupted then
							FourLightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 850, false, false, CoD.TweenType.Linear )
							element:setShaderVector( 2, 1, 0, 0, 0 )
							element:registerEventHandler( "transition_complete_keyframe", FourLightFrame4 )
						end
					end
					
					if event.interrupted then
						FourLightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", FourLightFrame3 )
					end
				end
				
				self.FourLight:completeAnimation()
				self.FourLight:setAlpha( 1 )
				self.FourLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.FourLight:setShaderVector( 0, 1, 0, 0, 0 )
				self.FourLight:setShaderVector( 1, 0, 0, 0, 0 )
				self.FourLight:setShaderVector( 2, 0, 0, 0, 0 )
				self.FourLight:setShaderVector( 3, 0.22, 0, 0, 0 )
				FourLightFrame2( self.FourLight, {} )

				local FourGlowFrame2 = function ( element, event )
					local FourGlowFrame3 = function ( element, event )
						local FourGlowFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							FourGlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1779, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", FourGlowFrame4 )
						end
					end
					
					if event.interrupted then
						FourGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 239, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", FourGlowFrame3 )
					end
				end
				
				self.FourGlow:completeAnimation()
				self.FourGlow:setAlpha( 0 )
				FourGlowFrame2( self.FourGlow, {} )

				self.Three:completeAnimation()
				self.Three:setAlpha( 0 )
				self.clipFinished( self.Three, {} )

				self.ThreeLight:completeAnimation()
				self.ThreeLight:setAlpha( 0 )
				self.clipFinished( self.ThreeLight, {} )

				self.ThreeGlow:completeAnimation()
				self.ThreeGlow:setAlpha( 0 )
				self.clipFinished( self.ThreeGlow, {} )

				self.Two:completeAnimation()
				self.Two:setAlpha( 0 )
				self.clipFinished( self.Two, {} )

				self.TwoLight:completeAnimation()
				self.TwoLight:setAlpha( 0 )
				self.clipFinished( self.TwoLight, {} )

				self.TwoGlow:completeAnimation()
				self.TwoGlow:setAlpha( 0 )
				self.clipFinished( self.TwoGlow, {} )

				self.One:completeAnimation()
				self.One:setAlpha( 0 )
				self.clipFinished( self.One, {} )

				self.OneLight:completeAnimation()
				self.OneLight:setAlpha( 0 )
				self.clipFinished( self.OneLight, {} )

				self.OneGlow:completeAnimation()
				self.OneGlow:setAlpha( 0 )
				self.clipFinished( self.OneGlow, {} )

				self.Zero:completeAnimation()
				self.Zero:setAlpha( 0 )
				self.clipFinished( self.Zero, {} )

				self.ZeroLight:completeAnimation()
				self.ZeroLight:setAlpha( 0 )
				self.clipFinished( self.ZeroLight, {} )

				self.ZeroGlow:completeAnimation()
				self.ZeroGlow:setAlpha( 0 )
				self.clipFinished( self.ZeroGlow, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							local ZmFxSpark2Ext0Frame5 = function ( element, event )
								local ZmFxSpark2Ext0Frame6 = function ( element, event )
									if not event.interrupted then
										element:beginAnimation( "keyframe", 149, false, false, CoD.TweenType.Linear )
									end
									element:setLeftRight( true, false, -4.56, 107.44 )
									element:setTopBottom( true, false, -117.29, 50.71 )
									element:setAlpha( 0 )
									if event.interrupted then
										self.clipFinished( element, event )
									else
										element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
									end
								end
								
								if event.interrupted then
									ZmFxSpark2Ext0Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 129, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -4.56, 107.44 )
									element:setTopBottom( true, false, -117.29, 50.71 )
									element:setAlpha( 0.43 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame6 )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, -14.67, 97.33 )
								element:setTopBottom( true, false, -111.03, 56.97 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 429, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -25.56, 86.44 )
							element:setTopBottom( true, false, -104.29, 63.71 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, -22.59, 89.41 )
						element:setTopBottom( true, false, -127.27, 40.73 )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, -21.56, 90.44 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -135.29, 32.71 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				local ZmFxSpark2Ext00Frame2 = function ( element, event )
					local ZmFxSpark2Ext00Frame3 = function ( element, event )
						local ZmFxSpark2Ext00Frame4 = function ( element, event )
							local ZmFxSpark2Ext00Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 470, false, false, CoD.TweenType.Linear )
								end
								element:setLeftRight( true, false, -10.56, 101.44 )
								element:setTopBottom( true, false, -76, 92 )
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext00Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext00Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 519, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -10.56, 101.44 )
							element:setTopBottom( true, false, -76, 92 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext00Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, -5.9, 106.1 )
						element:setTopBottom( true, false, -117.91, 50.09 )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setLeftRight( true, false, -4.56, 107.44 )
				self.ZmFxSpark2Ext00:setTopBottom( true, false, -130, 38 )
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				ZmFxSpark2Ext00Frame2( self.ZmFxSpark2Ext00, {} )
			end
		},

		Five = {
			DefaultClip = function ()
				self:setupElementClipCounter( 32 )

				self.Nine:completeAnimation()
				self.Nine:setAlpha( 0 )
				self.clipFinished( self.Nine, {} )

				self.NineLight:completeAnimation()
				self.NineLight:setAlpha( 0 )
				self.clipFinished( self.NineLight, {} )

				self.NineGlow:completeAnimation()
				self.NineGlow:setAlpha( 0 )
				self.clipFinished( self.NineGlow, {} )

				self.Eight:completeAnimation()
				self.Eight:setAlpha( 0 )
				self.clipFinished( self.Eight, {} )

				self.EightLight:completeAnimation()
				self.EightLight:setAlpha( 0 )
				self.clipFinished( self.EightLight, {} )

				self.EightGlow:completeAnimation()
				self.EightGlow:setAlpha( 0 )
				self.clipFinished( self.EightGlow, {} )

				self.Seven:completeAnimation()
				self.Seven:setAlpha( 0 )
				self.clipFinished( self.Seven, {} )

				self.SevenLight:completeAnimation()
				self.SevenLight:setAlpha( 0 )
				self.clipFinished( self.SevenLight, {} )

				self.SevenGlow:completeAnimation()
				self.SevenGlow:setAlpha( 0 )
				self.clipFinished( self.SevenGlow, {} )

				self.Six:completeAnimation()
				self.Six:setAlpha( 0 )
				self.clipFinished( self.Six, {} )

				self.SixLight:completeAnimation()
				self.SixLight:setAlpha( 0 )
				self.clipFinished( self.SixLight, {} )

				self.SixGlow:completeAnimation()
				self.SixGlow:setAlpha( 0 )
				self.clipFinished( self.SixGlow, {} )

				local FiveFrame2 = function ( element, event )
					local FiveFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1529, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						FiveFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1490, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", FiveFrame3 )
					end
				end
				
				self.Five:completeAnimation()
				self.Five:setAlpha( 0 )
				FiveFrame2( self.Five, {} )

				local FiveLightFrame2 = function ( element, event )
					local FiveLightFrame3 = function ( element, event )
						local FiveLightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1019, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
							element:setShaderVector( 0, 1, 0, 0, 0 )
							element:setShaderVector( 1, 0, 0, 0, 0 )
							element:setShaderVector( 2, 1, 0, 0, 0 )
							element:setShaderVector( 3, 0.2, 0, 0, 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							FiveLightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 810, false, false, CoD.TweenType.Linear )
							element:setShaderVector( 2, 1, 0, 0, 0 )
							element:registerEventHandler( "transition_complete_keyframe", FiveLightFrame4 )
						end
					end
					
					if event.interrupted then
						FiveLightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", FiveLightFrame3 )
					end
				end
				
				self.FiveLight:completeAnimation()
				self.FiveLight:setAlpha( 1 )
				self.FiveLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.FiveLight:setShaderVector( 0, 1, 0, 0, 0 )
				self.FiveLight:setShaderVector( 1, 0, 0, 0, 0 )
				self.FiveLight:setShaderVector( 2, 0, 0, 0, 0 )
				self.FiveLight:setShaderVector( 3, 0.2, 0, 0, 0 )
				FiveLightFrame2( self.FiveLight, {} )

				local FiveGlowFrame2 = function ( element, event )
					local FiveGlowFrame3 = function ( element, event )
						local FiveGlowFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							FiveGlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1649, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", FiveGlowFrame4 )
						end
					end
					
					if event.interrupted then
						FiveGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 370, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", FiveGlowFrame3 )
					end
				end
				
				self.FiveGlow:completeAnimation()
				self.FiveGlow:setAlpha( 0 )
				FiveGlowFrame2( self.FiveGlow, {} )

				self.Four:completeAnimation()
				self.Four:setAlpha( 0 )
				self.clipFinished( self.Four, {} )

				self.FourLight:completeAnimation()
				self.FourLight:setAlpha( 0 )
				self.clipFinished( self.FourLight, {} )

				self.FourGlow:completeAnimation()
				self.FourGlow:setAlpha( 0 )
				self.clipFinished( self.FourGlow, {} )

				self.Three:completeAnimation()
				self.Three:setAlpha( 0 )
				self.clipFinished( self.Three, {} )

				self.ThreeLight:completeAnimation()
				self.ThreeLight:setAlpha( 0 )
				self.clipFinished( self.ThreeLight, {} )

				self.ThreeGlow:completeAnimation()
				self.ThreeGlow:setAlpha( 0 )
				self.clipFinished( self.ThreeGlow, {} )

				self.Two:completeAnimation()
				self.Two:setAlpha( 0 )
				self.clipFinished( self.Two, {} )

				self.TwoLight:completeAnimation()
				self.TwoLight:setAlpha( 0 )
				self.clipFinished( self.TwoLight, {} )

				self.TwoGlow:completeAnimation()
				self.TwoGlow:setAlpha( 0 )
				self.clipFinished( self.TwoGlow, {} )

				self.One:completeAnimation()
				self.One:setAlpha( 0 )
				self.clipFinished( self.One, {} )

				self.OneLight:completeAnimation()
				self.OneLight:setAlpha( 0 )
				self.clipFinished( self.OneLight, {} )

				self.OneGlow:completeAnimation()
				self.OneGlow:setAlpha( 0 )
				self.clipFinished( self.OneGlow, {} )

				self.Zero:completeAnimation()
				self.Zero:setAlpha( 0 )
				self.clipFinished( self.Zero, {} )

				self.ZeroLight:completeAnimation()
				self.ZeroLight:setAlpha( 0 )
				self.clipFinished( self.ZeroLight, {} )

				self.ZeroGlow:completeAnimation()
				self.ZeroGlow:setAlpha( 0 )
				self.clipFinished( self.ZeroGlow, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							local ZmFxSpark2Ext0Frame5 = function ( element, event )
								local ZmFxSpark2Ext0Frame6 = function ( element, event )
									local ZmFxSpark2Ext0Frame7 = function ( element, event )
										local ZmFxSpark2Ext0Frame8 = function ( element, event )
											local ZmFxSpark2Ext0Frame9 = function ( element, event )
												local ZmFxSpark2Ext0Frame10 = function ( element, event )
													local ZmFxSpark2Ext0Frame11 = function ( element, event )
														if not event.interrupted then
															element:beginAnimation( "keyframe", 289, false, false, CoD.TweenType.Linear )
														end
														element:setLeftRight( true, false, -22.56, 89.44 )
														element:setTopBottom( true, false, -73.29, 94.71 )
														element:setAlpha( 0 )
														if event.interrupted then
															self.clipFinished( element, event )
														else
															element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
														end
													end
													
													if event.interrupted then
														ZmFxSpark2Ext0Frame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
														element:setLeftRight( true, false, -22.56, 89.44 )
														element:setTopBottom( true, false, -73.29, 94.71 )
														element:setAlpha( 0.59 )
														element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame11 )
													end
												end
												
												if event.interrupted then
													ZmFxSpark2Ext0Frame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
													element:setLeftRight( true, false, -18.56, 93.44 )
													element:setTopBottom( true, false, -72.29, 95.71 )
													element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame10 )
												end
											end
											
											if event.interrupted then
												ZmFxSpark2Ext0Frame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
												element:setLeftRight( true, false, -9.56, 102.44 )
												element:setTopBottom( true, false, -75.29, 92.71 )
												element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame9 )
											end
										end
										
										if event.interrupted then
											ZmFxSpark2Ext0Frame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
											element:setLeftRight( true, false, -5.56, 106.44 )
											element:setTopBottom( true, false, -82.29, 85.71 )
											element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame8 )
										end
									end
									
									if event.interrupted then
										ZmFxSpark2Ext0Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
										element:setLeftRight( true, false, -7.56, 104.44 )
										element:setTopBottom( true, false, -94.29, 73.71 )
										element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame7 )
									end
								end
								
								if event.interrupted then
									ZmFxSpark2Ext0Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -14.09, 97.91 )
									element:setTopBottom( true, false, -110.82, 57.18 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame6 )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 290, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, -23.56, 88.44 )
								element:setTopBottom( true, false, -110.29, 57.71 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 179, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -22.56, 89.44 )
							element:setTopBottom( true, false, -133.29, 34.71 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, -15.45, 96.55 )
						element:setTopBottom( true, false, -136.61, 31.39 )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, -7.56, 104.44 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -140.29, 27.71 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext00, {} )
			end
		},

		Six = {
			DefaultClip = function ()
				self:setupElementClipCounter( 32 )

				self.Nine:completeAnimation()
				self.Nine:setAlpha( 0 )
				self.clipFinished( self.Nine, {} )

				self.NineLight:completeAnimation()
				self.NineLight:setAlpha( 0 )
				self.clipFinished( self.NineLight, {} )

				self.NineGlow:completeAnimation()
				self.NineGlow:setAlpha( 0 )
				self.clipFinished( self.NineGlow, {} )

				self.Eight:completeAnimation()
				self.Eight:setAlpha( 0 )
				self.clipFinished( self.Eight, {} )

				self.EightLight:completeAnimation()
				self.EightLight:setAlpha( 0 )
				self.clipFinished( self.EightLight, {} )

				self.EightGlow:completeAnimation()
				self.EightGlow:setAlpha( 0 )
				self.clipFinished( self.EightGlow, {} )

				self.Seven:completeAnimation()
				self.Seven:setAlpha( 0 )
				self.clipFinished( self.Seven, {} )

				self.SevenLight:completeAnimation()
				self.SevenLight:setAlpha( 0 )
				self.clipFinished( self.SevenLight, {} )

				self.SevenGlow:completeAnimation()
				self.SevenGlow:setAlpha( 0 )
				self.clipFinished( self.SevenGlow, {} )

				local SixFrame2 = function ( element, event )
					local SixFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1549, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						SixFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1470, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", SixFrame3 )
					end
				end
				
				self.Six:completeAnimation()
				self.Six:setAlpha( 0 )
				SixFrame2( self.Six, {} )

				local SixLightFrame2 = function ( element, event )
					local SixLightFrame3 = function ( element, event )
						local SixLightFrame4 = function ( element, event )
							local SixLightFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 509, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
								element:setShaderVector( 0, 1, 0, 0, 0 )
								element:setShaderVector( 1, 0, 0, 0, 0 )
								element:setShaderVector( 2, 1, 0, 0, 0 )
								element:setShaderVector( 3, 0.2, 0, 0, 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								SixLightFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 629, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", SixLightFrame5 )
							end
						end
						
						if event.interrupted then
							SixLightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 720, false, false, CoD.TweenType.Linear )
							element:setShaderVector( 2, 1, 0, 0, 0 )
							element:registerEventHandler( "transition_complete_keyframe", SixLightFrame4 )
						end
					end
					
					if event.interrupted then
						SixLightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 159, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", SixLightFrame3 )
					end
				end
				
				self.SixLight:completeAnimation()
				self.SixLight:setAlpha( 1 )
				self.SixLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.SixLight:setShaderVector( 0, 1, 0, 0, 0 )
				self.SixLight:setShaderVector( 1, 0, 0, 0, 0 )
				self.SixLight:setShaderVector( 2, 0, 0, 0, 0 )
				self.SixLight:setShaderVector( 3, 0.2, 0, 0, 0 )
				SixLightFrame2( self.SixLight, {} )

				local SixGlowFrame2 = function ( element, event )
					local SixGlowFrame3 = function ( element, event )
						local SixGlowFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							SixGlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1600, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", SixGlowFrame4 )
						end
					end
					
					if event.interrupted then
						SixGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 419, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", SixGlowFrame3 )
					end
				end
				
				self.SixGlow:completeAnimation()
				self.SixGlow:setAlpha( 0 )
				SixGlowFrame2( self.SixGlow, {} )

				self.Five:completeAnimation()
				self.Five:setAlpha( 0 )
				self.clipFinished( self.Five, {} )

				self.FiveLight:completeAnimation()
				self.FiveLight:setAlpha( 0 )
				self.clipFinished( self.FiveLight, {} )

				self.FiveGlow:completeAnimation()
				self.FiveGlow:setAlpha( 0 )
				self.clipFinished( self.FiveGlow, {} )

				self.Four:completeAnimation()
				self.Four:setAlpha( 0 )
				self.clipFinished( self.Four, {} )

				self.FourLight:completeAnimation()
				self.FourLight:setAlpha( 0 )
				self.clipFinished( self.FourLight, {} )

				self.FourGlow:completeAnimation()
				self.FourGlow:setAlpha( 0 )
				self.clipFinished( self.FourGlow, {} )

				self.Three:completeAnimation()
				self.Three:setAlpha( 0 )
				self.clipFinished( self.Three, {} )

				self.ThreeLight:completeAnimation()
				self.ThreeLight:setAlpha( 0 )
				self.clipFinished( self.ThreeLight, {} )

				self.ThreeGlow:completeAnimation()
				self.ThreeGlow:setAlpha( 0 )
				self.clipFinished( self.ThreeGlow, {} )

				self.Two:completeAnimation()
				self.Two:setAlpha( 0 )
				self.clipFinished( self.Two, {} )

				self.TwoLight:completeAnimation()
				self.TwoLight:setAlpha( 0 )
				self.clipFinished( self.TwoLight, {} )

				self.TwoGlow:completeAnimation()
				self.TwoGlow:setAlpha( 0 )
				self.clipFinished( self.TwoGlow, {} )

				self.One:completeAnimation()
				self.One:setAlpha( 0 )
				self.clipFinished( self.One, {} )

				self.OneLight:completeAnimation()
				self.OneLight:setAlpha( 0 )
				self.clipFinished( self.OneLight, {} )

				self.OneGlow:completeAnimation()
				self.OneGlow:setAlpha( 0 )
				self.clipFinished( self.OneGlow, {} )

				self.Zero:completeAnimation()
				self.Zero:setAlpha( 0 )
				self.clipFinished( self.Zero, {} )

				self.ZeroLight:completeAnimation()
				self.ZeroLight:setAlpha( 0 )
				self.clipFinished( self.ZeroLight, {} )

				self.ZeroGlow:completeAnimation()
				self.ZeroGlow:setAlpha( 0 )
				self.clipFinished( self.ZeroGlow, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							local ZmFxSpark2Ext0Frame5 = function ( element, event )
								local ZmFxSpark2Ext0Frame6 = function ( element, event )
									local ZmFxSpark2Ext0Frame7 = function ( element, event )
										local ZmFxSpark2Ext0Frame8 = function ( element, event )
											local ZmFxSpark2Ext0Frame9 = function ( element, event )
												local ZmFxSpark2Ext0Frame10 = function ( element, event )
													local ZmFxSpark2Ext0Frame11 = function ( element, event )
														if not event.interrupted then
															element:beginAnimation( "keyframe", 340, false, false, CoD.TweenType.Linear )
														end
														element:setLeftRight( true, false, -21.56, 90.44 )
														element:setTopBottom( true, false, -96.29, 71.71 )
														element:setAlpha( 0 )
														if event.interrupted then
															self.clipFinished( element, event )
														else
															element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
														end
													end
													
													if event.interrupted then
														ZmFxSpark2Ext0Frame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
														element:setLeftRight( true, false, -21.56, 90.44 )
														element:setTopBottom( true, false, -96.29, 71.71 )
														element:setAlpha( 0.65 )
														element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame11 )
													end
												end
												
												if event.interrupted then
													ZmFxSpark2Ext0Frame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 19, false, false, CoD.TweenType.Linear )
													element:setLeftRight( true, false, -16.76, 95.24 )
													element:setTopBottom( true, false, -102.69, 65.31 )
													element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame10 )
												end
											end
											
											if event.interrupted then
												ZmFxSpark2Ext0Frame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
												element:setLeftRight( true, false, -15.56, 96.44 )
												element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame9 )
											end
										end
										
										if event.interrupted then
											ZmFxSpark2Ext0Frame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 110, false, false, CoD.TweenType.Linear )
											element:setLeftRight( true, false, -7.56, 104.44 )
											element:setTopBottom( true, false, -104.29, 63.71 )
											element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame8 )
										end
									end
									
									if event.interrupted then
										ZmFxSpark2Ext0Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Linear )
										element:setLeftRight( true, false, -14.21, 97.79 )
										element:setTopBottom( true, false, -78.46, 89.54 )
										element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame7 )
									end
								end
								
								if event.interrupted then
									ZmFxSpark2Ext0Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -23.56, 88.44 )
									element:setTopBottom( true, false, -73.29, 94.71 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame6 )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 129, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, -25.52, 86.48 )
								element:setTopBottom( true, false, -94.65, 73.35 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 340, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -25.56, 86.44 )
							element:setTopBottom( true, false, -105.29, 62.71 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 159, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, -14, 98 )
						element:setTopBottom( true, false, -127.05, 40.95 )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, -8.56, 103.44 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -137.29, 30.71 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext00, {} )
			end
		},

		Seven = {
			DefaultClip = function ()
				self:setupElementClipCounter( 32 )

				self.Nine:completeAnimation()
				self.Nine:setAlpha( 0 )
				self.clipFinished( self.Nine, {} )

				self.NineLight:completeAnimation()
				self.NineLight:setAlpha( 0 )
				self.clipFinished( self.NineLight, {} )

				self.NineGlow:completeAnimation()
				self.NineGlow:setAlpha( 0 )
				self.clipFinished( self.NineGlow, {} )

				self.Eight:completeAnimation()
				self.Eight:setAlpha( 0 )
				self.clipFinished( self.Eight, {} )

				self.EightLight:completeAnimation()
				self.EightLight:setAlpha( 0 )
				self.clipFinished( self.EightLight, {} )

				self.EightGlow:completeAnimation()
				self.EightGlow:setAlpha( 0 )
				self.clipFinished( self.EightGlow, {} )

				local SevenFrame2 = function ( element, event )
					local SevenFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1559, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						SevenFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1450, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", SevenFrame3 )
					end
				end
				
				self.Seven:completeAnimation()
				self.Seven:setAlpha( 0 )
				SevenFrame2( self.Seven, {} )

				local SevenLightFrame2 = function ( element, event )
					local SevenLightFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 929, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
						element:setShaderVector( 0, 1, 0, 0, 0 )
						element:setShaderVector( 1, 0, 0, 0, 0 )
						element:setShaderVector( 2, 1, 0, 0, 0 )
						element:setShaderVector( 3, 0.2, 0, 0, 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						SevenLightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1080, false, false, CoD.TweenType.Linear )
						element:setShaderVector( 2, 1, 0, 0, 0 )
						element:registerEventHandler( "transition_complete_keyframe", SevenLightFrame3 )
					end
				end
				
				self.SevenLight:completeAnimation()
				self.SevenLight:setAlpha( 1 )
				self.SevenLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.SevenLight:setShaderVector( 0, 1, 0, 0, 0 )
				self.SevenLight:setShaderVector( 1, 0, 0, 0, 0 )
				self.SevenLight:setShaderVector( 2, 0, 0, 0, 0 )
				self.SevenLight:setShaderVector( 3, 0.2, 0, 0, 0 )
				SevenLightFrame2( self.SevenLight, {} )

				local SevenGlowFrame2 = function ( element, event )
					local SevenGlowFrame3 = function ( element, event )
						local SevenGlowFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 990, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							SevenGlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1529, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", SevenGlowFrame4 )
						end
					end
					
					if event.interrupted then
						SevenGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 490, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", SevenGlowFrame3 )
					end
				end
				
				self.SevenGlow:completeAnimation()
				self.SevenGlow:setAlpha( 0 )
				SevenGlowFrame2( self.SevenGlow, {} )

				self.Six:completeAnimation()
				self.Six:setAlpha( 0 )
				self.clipFinished( self.Six, {} )

				self.SixLight:completeAnimation()
				self.SixLight:setAlpha( 0 )
				self.clipFinished( self.SixLight, {} )

				self.SixGlow:completeAnimation()
				self.SixGlow:setAlpha( 0 )
				self.clipFinished( self.SixGlow, {} )

				self.Five:completeAnimation()
				self.Five:setAlpha( 0 )
				self.clipFinished( self.Five, {} )

				self.FiveLight:completeAnimation()
				self.FiveLight:setAlpha( 0 )
				self.clipFinished( self.FiveLight, {} )

				self.FiveGlow:completeAnimation()
				self.FiveGlow:setAlpha( 0 )
				self.clipFinished( self.FiveGlow, {} )

				self.Four:completeAnimation()
				self.Four:setAlpha( 0 )
				self.clipFinished( self.Four, {} )

				self.FourLight:completeAnimation()
				self.FourLight:setAlpha( 0 )
				self.clipFinished( self.FourLight, {} )

				self.FourGlow:completeAnimation()
				self.FourGlow:setAlpha( 0 )
				self.clipFinished( self.FourGlow, {} )

				self.Three:completeAnimation()
				self.Three:setAlpha( 0 )
				self.clipFinished( self.Three, {} )

				self.ThreeLight:completeAnimation()
				self.ThreeLight:setAlpha( 0 )
				self.clipFinished( self.ThreeLight, {} )

				self.ThreeGlow:completeAnimation()
				self.ThreeGlow:setAlpha( 0 )
				self.clipFinished( self.ThreeGlow, {} )

				self.Two:completeAnimation()
				self.Two:setAlpha( 0 )
				self.clipFinished( self.Two, {} )

				self.TwoLight:completeAnimation()
				self.TwoLight:setAlpha( 0 )
				self.clipFinished( self.TwoLight, {} )

				self.TwoGlow:completeAnimation()
				self.TwoGlow:setAlpha( 0 )
				self.clipFinished( self.TwoGlow, {} )

				self.One:completeAnimation()
				self.One:setAlpha( 0 )
				self.clipFinished( self.One, {} )

				self.OneLight:completeAnimation()
				self.OneLight:setAlpha( 0 )
				self.clipFinished( self.OneLight, {} )

				self.OneGlow:completeAnimation()
				self.OneGlow:setAlpha( 0 )
				self.clipFinished( self.OneGlow, {} )

				self.Zero:completeAnimation()
				self.Zero:setAlpha( 0 )
				self.clipFinished( self.Zero, {} )

				self.ZeroLight:completeAnimation()
				self.ZeroLight:setAlpha( 0 )
				self.clipFinished( self.ZeroLight, {} )

				self.ZeroGlow:completeAnimation()
				self.ZeroGlow:setAlpha( 0 )
				self.clipFinished( self.ZeroGlow, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							local ZmFxSpark2Ext0Frame5 = function ( element, event )
								local ZmFxSpark2Ext0Frame6 = function ( element, event )
									local ZmFxSpark2Ext0Frame7 = function ( element, event )
										if not event.interrupted then
											element:beginAnimation( "keyframe", 480, false, false, CoD.TweenType.Linear )
										end
										element:setLeftRight( true, false, -11.56, 100.44 )
										element:setTopBottom( true, false, -73.29, 94.71 )
										element:setAlpha( 0 )
										if event.interrupted then
											self.clipFinished( element, event )
										else
											element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
										end
									end
									
									if event.interrupted then
										ZmFxSpark2Ext0Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
										element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame7 )
									end
								end
								
								if event.interrupted then
									ZmFxSpark2Ext0Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 480, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -11.56, 100.44 )
									element:setTopBottom( true, false, -73.29, 94.71 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame6 )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 250, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -7.56, 104.44 )
							element:setTopBottom( true, false, -132.29, 35.71 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, -29.56, 82.44 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -121.29, 46.71 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext00, {} )
			end
		},

		Eight = {
			DefaultClip = function ()
				self:setupElementClipCounter( 32 )

				self.Nine:completeAnimation()
				self.Nine:setAlpha( 0 )
				self.clipFinished( self.Nine, {} )

				self.NineLight:completeAnimation()
				self.NineLight:setAlpha( 0 )
				self.clipFinished( self.NineLight, {} )

				self.NineGlow:completeAnimation()
				self.NineGlow:setAlpha( 0 )
				self.clipFinished( self.NineGlow, {} )

				local EightFrame2 = function ( element, event )
					local EightFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1529, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						EightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1470, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", EightFrame3 )
					end
				end
				
				self.Eight:completeAnimation()
				self.Eight:setAlpha( 0 )
				EightFrame2( self.Eight, {} )

				local EightLightFrame2 = function ( element, event )
					local EightLightFrame3 = function ( element, event )
						local EightLightFrame4 = function ( element, event )
							local EightLightFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 549, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
								element:setShaderVector( 0, 1, 0, 0, 0 )
								element:setShaderVector( 1, 0, 0, 0, 0 )
								element:setShaderVector( 2, 1, 0, 0, 0 )
								element:setShaderVector( 3, 0.2, 0, 0, 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								EightLightFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 360, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", EightLightFrame5 )
							end
						end
						
						if event.interrupted then
							EightLightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 999, false, false, CoD.TweenType.Linear )
							element:setShaderVector( 2, 1, 0, 0, 0 )
							element:registerEventHandler( "transition_complete_keyframe", EightLightFrame4 )
						end
					end
					
					if event.interrupted then
						EightLightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", EightLightFrame3 )
					end
				end
				
				self.EightLight:completeAnimation()
				self.EightLight:setAlpha( 1 )
				self.EightLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.EightLight:setShaderVector( 0, 1, 0, 0, 0 )
				self.EightLight:setShaderVector( 1, 0, 0, 0, 0 )
				self.EightLight:setShaderVector( 2, 0, 0, 0, 0 )
				self.EightLight:setShaderVector( 3, 0.2, 0, 0, 0 )
				EightLightFrame2( self.EightLight, {} )

				local EightGlowFrame2 = function ( element, event )
					local EightGlowFrame3 = function ( element, event )
						local EightGlowFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							EightGlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1490, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", EightGlowFrame4 )
						end
					end
					
					if event.interrupted then
						EightGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 509, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", EightGlowFrame3 )
					end
				end
				
				self.EightGlow:completeAnimation()
				self.EightGlow:setAlpha( 0 )
				EightGlowFrame2( self.EightGlow, {} )

				self.Seven:completeAnimation()
				self.Seven:setAlpha( 0 )
				self.clipFinished( self.Seven, {} )

				self.SevenLight:completeAnimation()
				self.SevenLight:setAlpha( 0 )
				self.clipFinished( self.SevenLight, {} )

				self.SevenGlow:completeAnimation()
				self.SevenGlow:setAlpha( 0 )
				self.clipFinished( self.SevenGlow, {} )

				self.Six:completeAnimation()
				self.Six:setAlpha( 0 )
				self.clipFinished( self.Six, {} )

				self.SixLight:completeAnimation()
				self.SixLight:setAlpha( 0 )
				self.clipFinished( self.SixLight, {} )

				self.SixGlow:completeAnimation()
				self.SixGlow:setAlpha( 0 )
				self.clipFinished( self.SixGlow, {} )

				self.Five:completeAnimation()
				self.Five:setAlpha( 0 )
				self.clipFinished( self.Five, {} )

				self.FiveLight:completeAnimation()
				self.FiveLight:setAlpha( 0 )
				self.clipFinished( self.FiveLight, {} )

				self.FiveGlow:completeAnimation()
				self.FiveGlow:setAlpha( 0 )
				self.clipFinished( self.FiveGlow, {} )

				self.Four:completeAnimation()
				self.Four:setAlpha( 0 )
				self.clipFinished( self.Four, {} )

				self.FourLight:completeAnimation()
				self.FourLight:setAlpha( 0 )
				self.clipFinished( self.FourLight, {} )

				self.FourGlow:completeAnimation()
				self.FourGlow:setAlpha( 0 )
				self.clipFinished( self.FourGlow, {} )

				self.Three:completeAnimation()
				self.Three:setAlpha( 0 )
				self.clipFinished( self.Three, {} )

				self.ThreeLight:completeAnimation()
				self.ThreeLight:setAlpha( 0 )
				self.clipFinished( self.ThreeLight, {} )

				self.ThreeGlow:completeAnimation()
				self.ThreeGlow:setAlpha( 0 )
				self.clipFinished( self.ThreeGlow, {} )

				self.Two:completeAnimation()
				self.Two:setAlpha( 0 )
				self.clipFinished( self.Two, {} )

				self.TwoLight:completeAnimation()
				self.TwoLight:setAlpha( 0 )
				self.clipFinished( self.TwoLight, {} )

				self.TwoGlow:completeAnimation()
				self.TwoGlow:setAlpha( 0 )
				self.clipFinished( self.TwoGlow, {} )

				self.One:completeAnimation()
				self.One:setAlpha( 0 )
				self.clipFinished( self.One, {} )

				self.OneLight:completeAnimation()
				self.OneLight:setAlpha( 0 )
				self.clipFinished( self.OneLight, {} )

				self.OneGlow:completeAnimation()
				self.OneGlow:setAlpha( 0 )
				self.clipFinished( self.OneGlow, {} )

				self.Zero:completeAnimation()
				self.Zero:setAlpha( 0 )
				self.clipFinished( self.Zero, {} )

				self.ZeroLight:completeAnimation()
				self.ZeroLight:setAlpha( 0 )
				self.clipFinished( self.ZeroLight, {} )

				self.ZeroGlow:completeAnimation()
				self.ZeroGlow:setAlpha( 0 )
				self.clipFinished( self.ZeroGlow, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							local ZmFxSpark2Ext0Frame5 = function ( element, event )
								local ZmFxSpark2Ext0Frame6 = function ( element, event )
									local ZmFxSpark2Ext0Frame7 = function ( element, event )
										local ZmFxSpark2Ext0Frame8 = function ( element, event )
											local ZmFxSpark2Ext0Frame9 = function ( element, event )
												local ZmFxSpark2Ext0Frame10 = function ( element, event )
													if not event.interrupted then
														element:beginAnimation( "keyframe", 360, false, false, CoD.TweenType.Linear )
													end
													element:setLeftRight( true, false, -15.56, 96.44 )
													element:setTopBottom( true, false, -76, 92 )
													element:setAlpha( 0 )
													if event.interrupted then
														self.clipFinished( element, event )
													else
														element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
													end
												end
												
												if event.interrupted then
													ZmFxSpark2Ext0Frame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
													element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame10 )
												end
											end
											
											if event.interrupted then
												ZmFxSpark2Ext0Frame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 129, false, false, CoD.TweenType.Linear )
												element:setLeftRight( true, false, -15.56, 96.44 )
												element:setTopBottom( true, false, -76, 92 )
												element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame9 )
											end
										end
										
										if event.interrupted then
											ZmFxSpark2Ext0Frame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
											element:setTopBottom( true, false, -88, 80 )
											element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame8 )
										end
									end
									
									if event.interrupted then
										ZmFxSpark2Ext0Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 139, false, false, CoD.TweenType.Linear )
										element:setLeftRight( true, false, -6.56, 105.44 )
										element:setTopBottom( true, false, -99.29, 68.71 )
										element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame7 )
									end
								end
								
								if event.interrupted then
									ZmFxSpark2Ext0Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 160, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -17.56, 94.44 )
									element:setTopBottom( true, false, -107.29, 60.71 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame6 )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 219, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, -29.56, 82.44 )
								element:setTopBottom( true, false, -118.29, 49.71 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 239, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -24.56, 87.44 )
							element:setTopBottom( true, false, -130.29, 37.71 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, -19.56, 92.44 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -137.29, 30.71 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				local ZmFxSpark2Ext00Frame2 = function ( element, event )
					local ZmFxSpark2Ext00Frame3 = function ( element, event )
						local ZmFxSpark2Ext00Frame4 = function ( element, event )
							local ZmFxSpark2Ext00Frame5 = function ( element, event )
								local ZmFxSpark2Ext00Frame6 = function ( element, event )
									local ZmFxSpark2Ext00Frame7 = function ( element, event )
										local ZmFxSpark2Ext00Frame8 = function ( element, event )
											local ZmFxSpark2Ext00Frame9 = function ( element, event )
												local ZmFxSpark2Ext00Frame10 = function ( element, event )
													if not event.interrupted then
														element:beginAnimation( "keyframe", 360, false, false, CoD.TweenType.Linear )
													end
													element:setLeftRight( true, false, -17, 95 )
													element:setTopBottom( true, false, -76, 92 )
													element:setAlpha( 0 )
													if event.interrupted then
														self.clipFinished( element, event )
													else
														element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
													end
												end
												
												if event.interrupted then
													ZmFxSpark2Ext00Frame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
													element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame10 )
												end
											end
											
											if event.interrupted then
												ZmFxSpark2Ext00Frame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 129, false, false, CoD.TweenType.Linear )
												element:setLeftRight( true, false, -17, 95 )
												element:setTopBottom( true, false, -76, 92 )
												element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame9 )
											end
										end
										
										if event.interrupted then
											ZmFxSpark2Ext00Frame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
											element:setLeftRight( true, false, -31, 81 )
											element:setTopBottom( true, false, -82.29, 85.71 )
											element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame8 )
										end
									end
									
									if event.interrupted then
										ZmFxSpark2Ext00Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 139, false, false, CoD.TweenType.Linear )
										element:setLeftRight( true, false, -28, 84 )
										element:setTopBottom( true, false, -94.29, 73.71 )
										element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame7 )
									end
								end
								
								if event.interrupted then
									ZmFxSpark2Ext00Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 160, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -17.56, 94.44 )
									element:setTopBottom( true, false, -111.29, 56.71 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame6 )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext00Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 219, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, -3.56, 108.44 )
								element:setTopBottom( true, false, -118.29, 49.71 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext00Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 239, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -6.56, 105.44 )
							element:setTopBottom( true, false, -134.29, 33.71 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext00Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setLeftRight( true, false, -19.56, 92.44 )
				self.ZmFxSpark2Ext00:setTopBottom( true, false, -137.29, 30.71 )
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				ZmFxSpark2Ext00Frame2( self.ZmFxSpark2Ext00, {} )
			end
		},

		Nine = {
			DefaultClip = function ()
				self:setupElementClipCounter( 32 )

				local NineFrame2 = function ( element, event )
					local NineFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1460, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						NineFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1549, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", NineFrame3 )
					end
				end
				
				self.Nine:completeAnimation()
				self.Nine:setAlpha( 0 )
				NineFrame2( self.Nine, {} )

				local NineLightFrame2 = function ( element, event )
					local NineLightFrame3 = function ( element, event )
						local NineLightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1009, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
							element:setShaderVector( 0, 1, 0, 0, 0 )
							element:setShaderVector( 1, 0, 0, 0, 0 )
							element:setShaderVector( 2, 1, 0, 0, 0 )
							element:setShaderVector( 3, 0.2, 0, 0, 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							NineLightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 149, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", NineLightFrame4 )
						end
					end
					
					if event.interrupted then
						NineLightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 850, false, false, CoD.TweenType.Linear )
						element:setShaderVector( 2, 1, 0, 0, 0 )
						element:registerEventHandler( "transition_complete_keyframe", NineLightFrame3 )
					end
				end
				
				self.NineLight:completeAnimation()
				self.NineLight:setAlpha( 1 )
				self.NineLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.NineLight:setShaderVector( 0, 1, 0, 0, 0 )
				self.NineLight:setShaderVector( 1, 0, 0, 0, 0 )
				self.NineLight:setShaderVector( 2, 0, 0, 0, 0 )
				self.NineLight:setShaderVector( 3, 0.2, 0, 0, 0 )
				NineLightFrame2( self.NineLight, {} )

				local NineGlowFrame2 = function ( element, event )
					local NineGlowFrame3 = function ( element, event )
						local NineGlowFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							NineGlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1620, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", NineGlowFrame4 )
						end
					end
					
					if event.interrupted then
						NineGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 389, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", NineGlowFrame3 )
					end
				end
				
				self.NineGlow:completeAnimation()
				self.NineGlow:setAlpha( 0 )
				NineGlowFrame2( self.NineGlow, {} )

				self.Eight:completeAnimation()
				self.Eight:setAlpha( 0 )
				self.clipFinished( self.Eight, {} )

				self.EightLight:completeAnimation()
				self.EightLight:setAlpha( 0 )
				self.clipFinished( self.EightLight, {} )

				self.EightGlow:completeAnimation()
				self.EightGlow:setAlpha( 0 )
				self.clipFinished( self.EightGlow, {} )

				self.Seven:completeAnimation()
				self.Seven:setAlpha( 0 )
				self.clipFinished( self.Seven, {} )

				self.SevenLight:completeAnimation()
				self.SevenLight:setAlpha( 0 )
				self.clipFinished( self.SevenLight, {} )

				self.SevenGlow:completeAnimation()
				self.SevenGlow:setAlpha( 0 )
				self.clipFinished( self.SevenGlow, {} )

				self.Six:completeAnimation()
				self.Six:setAlpha( 0 )
				self.clipFinished( self.Six, {} )

				self.SixLight:completeAnimation()
				self.SixLight:setAlpha( 0 )
				self.clipFinished( self.SixLight, {} )

				self.SixGlow:completeAnimation()
				self.SixGlow:setAlpha( 0 )
				self.clipFinished( self.SixGlow, {} )

				self.Five:completeAnimation()
				self.Five:setAlpha( 0 )
				self.clipFinished( self.Five, {} )

				self.FiveLight:completeAnimation()
				self.FiveLight:setAlpha( 0 )
				self.clipFinished( self.FiveLight, {} )

				self.FiveGlow:completeAnimation()
				self.FiveGlow:setAlpha( 0 )
				self.clipFinished( self.FiveGlow, {} )

				self.Four:completeAnimation()
				self.Four:setAlpha( 0 )
				self.clipFinished( self.Four, {} )

				self.FourLight:completeAnimation()
				self.FourLight:setAlpha( 0 )
				self.clipFinished( self.FourLight, {} )

				self.FourGlow:completeAnimation()
				self.FourGlow:setAlpha( 0 )
				self.clipFinished( self.FourGlow, {} )

				self.Three:completeAnimation()
				self.Three:setAlpha( 0 )
				self.clipFinished( self.Three, {} )

				self.ThreeLight:completeAnimation()
				self.ThreeLight:setAlpha( 0 )
				self.clipFinished( self.ThreeLight, {} )

				self.ThreeGlow:completeAnimation()
				self.ThreeGlow:setAlpha( 0 )
				self.clipFinished( self.ThreeGlow, {} )

				self.Two:completeAnimation()
				self.Two:setAlpha( 0 )
				self.clipFinished( self.Two, {} )

				self.TwoLight:completeAnimation()
				self.TwoLight:setAlpha( 0 )
				self.clipFinished( self.TwoLight, {} )

				self.TwoGlow:completeAnimation()
				self.TwoGlow:setAlpha( 0 )
				self.clipFinished( self.TwoGlow, {} )

				self.One:completeAnimation()
				self.One:setAlpha( 0 )
				self.clipFinished( self.One, {} )

				self.OneLight:completeAnimation()
				self.OneLight:setAlpha( 0 )
				self.clipFinished( self.OneLight, {} )

				self.OneGlow:completeAnimation()
				self.OneGlow:setAlpha( 0 )
				self.clipFinished( self.OneGlow, {} )

				self.Zero:completeAnimation()
				self.Zero:setAlpha( 0 )
				self.clipFinished( self.Zero, {} )

				self.ZeroLight:completeAnimation()
				self.ZeroLight:setAlpha( 0 )
				self.clipFinished( self.ZeroLight, {} )

				self.ZeroGlow:completeAnimation()
				self.ZeroGlow:setAlpha( 0 )
				self.clipFinished( self.ZeroGlow, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							local ZmFxSpark2Ext0Frame5 = function ( element, event )
								local ZmFxSpark2Ext0Frame6 = function ( element, event )
									local ZmFxSpark2Ext0Frame7 = function ( element, event )
										if not event.interrupted then
											element:beginAnimation( "keyframe", 590, false, false, CoD.TweenType.Linear )
										end
										element:setLeftRight( true, false, -8.56, 103.44 )
										element:setTopBottom( true, false, -120.9, 47.1 )
										element:setAlpha( 0 )
										if event.interrupted then
											self.clipFinished( element, event )
										else
											element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
										end
									end
									
									if event.interrupted then
										ZmFxSpark2Ext0Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 30, false, false, CoD.TweenType.Linear )
										element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame7 )
									end
								end
								
								if event.interrupted then
									ZmFxSpark2Ext0Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 159, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -8.56, 103.44 )
									element:setTopBottom( true, false, -120.9, 47.1 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame6 )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, -19.91, 92.09 )
								element:setTopBottom( true, false, -107.78, 60.22 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 299, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -30.56, 81.44 )
							element:setTopBottom( true, false, -107.9, 60.1 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, -22.56, 89.44 )
						element:setTopBottom( true, false, -130, 38 )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, -4.56, 107.44 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -135, 33 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				local ZmFxSpark2Ext00Frame2 = function ( element, event )
					local ZmFxSpark2Ext00Frame3 = function ( element, event )
						local ZmFxSpark2Ext00Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 590, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, -19.56, 92.44 )
							element:setTopBottom( true, false, -71, 97 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext00Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 670, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -19.56, 92.44 )
							element:setTopBottom( true, false, -71, 97 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext00Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setLeftRight( true, false, 4.44, 116.44 )
				self.ZmFxSpark2Ext00:setTopBottom( true, false, -135, 33 )
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				ZmFxSpark2Ext00Frame2( self.ZmFxSpark2Ext00, {} )
			end
		},

		Zero = {
			DefaultClip = function ()
				self:setupElementClipCounter( 32 )

				self.Nine:completeAnimation()
				self.Nine:setAlpha( 0 )
				self.clipFinished( self.Nine, {} )

				self.NineLight:completeAnimation()
				self.NineLight:setAlpha( 0 )
				self.clipFinished( self.NineLight, {} )

				self.NineGlow:completeAnimation()
				self.NineGlow:setAlpha( 0 )
				self.clipFinished( self.NineGlow, {} )

				self.Eight:completeAnimation()
				self.Eight:setAlpha( 0 )
				self.clipFinished( self.Eight, {} )

				self.EightLight:completeAnimation()
				self.EightLight:setAlpha( 0 )
				self.clipFinished( self.EightLight, {} )

				self.EightGlow:completeAnimation()
				self.EightGlow:setAlpha( 0 )
				self.clipFinished( self.EightGlow, {} )

				self.Seven:completeAnimation()
				self.Seven:setAlpha( 0 )
				self.clipFinished( self.Seven, {} )

				self.SevenLight:completeAnimation()
				self.SevenLight:setAlpha( 0 )
				self.clipFinished( self.SevenLight, {} )

				self.SevenGlow:completeAnimation()
				self.SevenGlow:setAlpha( 0 )
				self.clipFinished( self.SevenGlow, {} )

				self.Six:completeAnimation()
				self.Six:setAlpha( 0 )
				self.clipFinished( self.Six, {} )

				self.SixLight:completeAnimation()
				self.SixLight:setAlpha( 0 )
				self.clipFinished( self.SixLight, {} )

				self.SixGlow:completeAnimation()
				self.SixGlow:setAlpha( 0 )
				self.clipFinished( self.SixGlow, {} )

				self.Five:completeAnimation()
				self.Five:setAlpha( 0 )
				self.clipFinished( self.Five, {} )

				self.FiveLight:completeAnimation()
				self.FiveLight:setAlpha( 0 )
				self.clipFinished( self.FiveLight, {} )

				self.FiveGlow:completeAnimation()
				self.FiveGlow:setAlpha( 0 )
				self.clipFinished( self.FiveGlow, {} )

				self.Four:completeAnimation()
				self.Four:setAlpha( 0 )
				self.clipFinished( self.Four, {} )

				self.FourLight:completeAnimation()
				self.FourLight:setAlpha( 0 )
				self.clipFinished( self.FourLight, {} )

				self.FourGlow:completeAnimation()
				self.FourGlow:setAlpha( 0 )
				self.clipFinished( self.FourGlow, {} )

				self.Three:completeAnimation()
				self.Three:setAlpha( 0 )
				self.clipFinished( self.Three, {} )

				self.ThreeLight:completeAnimation()
				self.ThreeLight:setAlpha( 0 )
				self.clipFinished( self.ThreeLight, {} )

				self.ThreeGlow:completeAnimation()
				self.ThreeGlow:setAlpha( 0 )
				self.clipFinished( self.ThreeGlow, {} )

				self.Two:completeAnimation()
				self.Two:setAlpha( 0 )
				self.clipFinished( self.Two, {} )

				self.TwoLight:completeAnimation()
				self.TwoLight:setAlpha( 0 )
				self.clipFinished( self.TwoLight, {} )

				self.TwoGlow:completeAnimation()
				self.TwoGlow:setAlpha( 0 )
				self.clipFinished( self.TwoGlow, {} )

				self.One:completeAnimation()
				self.One:setAlpha( 0 )
				self.clipFinished( self.One, {} )

				self.OneLight:completeAnimation()
				self.OneLight:setAlpha( 0 )
				self.clipFinished( self.OneLight, {} )

				self.OneGlow:completeAnimation()
				self.OneGlow:setAlpha( 0 )
				self.clipFinished( self.OneGlow, {} )

				local ZeroFrame2 = function ( element, event )
					local ZeroFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1500, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZeroFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1529, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZeroFrame3 )
					end
				end
				
				self.Zero:completeAnimation()
				self.Zero:setAlpha( 0 )
				ZeroFrame2( self.Zero, {} )

				local ZeroLightFrame2 = function ( element, event )
					local ZeroLightFrame3 = function ( element, event )
						local ZeroLightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1019, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
							element:setShaderVector( 0, 1, 0, 0, 0 )
							element:setShaderVector( 1, 0, 0, 0, 0 )
							element:setShaderVector( 2, 1.08, 0, 0, 0 )
							element:setShaderVector( 3, 0.21, -0.23, 0, 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZeroLightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 810, false, false, CoD.TweenType.Linear )
							element:setShaderVector( 2, 1.08, 0, 0, 0 )
							element:registerEventHandler( "transition_complete_keyframe", ZeroLightFrame4 )
						end
					end
					
					if event.interrupted then
						ZeroLightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setShaderVector( 2, 0.26, 0, 0, 0 )
						element:registerEventHandler( "transition_complete_keyframe", ZeroLightFrame3 )
					end
				end
				
				self.ZeroLight:completeAnimation()
				self.ZeroLight:setAlpha( 1 )
				self.ZeroLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.ZeroLight:setShaderVector( 0, 1, 0, 0, 0 )
				self.ZeroLight:setShaderVector( 1, 0, 0, 0, 0 )
				self.ZeroLight:setShaderVector( 2, 0, 0, 0, 0 )
				self.ZeroLight:setShaderVector( 3, 0.21, -0.23, 0, 0 )
				ZeroLightFrame2( self.ZeroLight, {} )

				local ZeroGlowFrame2 = function ( element, event )
					local ZeroGlowFrame3 = function ( element, event )
						local ZeroGlowFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZeroGlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1019, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZeroGlowFrame4 )
						end
					end
					
					if event.interrupted then
						ZeroGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZeroGlowFrame3 )
					end
				end
				
				self.ZeroGlow:completeAnimation()
				self.ZeroGlow:setAlpha( 0 )
				ZeroGlowFrame2( self.ZeroGlow, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							local ZmFxSpark2Ext0Frame5 = function ( element, event )
								local ZmFxSpark2Ext0Frame6 = function ( element, event )
									local ZmFxSpark2Ext0Frame7 = function ( element, event )
										local ZmFxSpark2Ext0Frame8 = function ( element, event )
											local ZmFxSpark2Ext0Frame9 = function ( element, event )
												if not event.interrupted then
													element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
												end
												element:setLeftRight( true, false, -21.56, 90.44 )
												element:setTopBottom( true, false, -73, 95 )
												element:setAlpha( 0 )
												if event.interrupted then
													self.clipFinished( element, event )
												else
													element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
												end
											end
											
											if event.interrupted then
												ZmFxSpark2Ext0Frame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
												element:setLeftRight( true, false, -21.56, 90.44 )
												element:setTopBottom( true, false, -73, 95 )
												element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame9 )
											end
										end
										
										if event.interrupted then
											ZmFxSpark2Ext0Frame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
											element:setLeftRight( true, false, -28, 84 )
											element:setTopBottom( true, false, -79.83, 88.17 )
											element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame8 )
										end
									end
									
									if event.interrupted then
										ZmFxSpark2Ext0Frame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
										element:setLeftRight( true, false, -34.56, 77.44 )
										element:setTopBottom( true, false, -88, 80 )
										element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame7 )
									end
								end
								
								if event.interrupted then
									ZmFxSpark2Ext0Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 110, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -36.08, 75.92 )
									element:setTopBottom( true, false, -98.38, 69.62 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame6 )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 159, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, -33.56, 78.44 )
								element:setTopBottom( true, false, -120.29, 47.71 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, -28, 84 )
							element:setTopBottom( true, false, -128, 40 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, -14.56, 97.44 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -137.29, 30.71 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				local ZmFxSpark2Ext00Frame2 = function ( element, event )
					local ZmFxSpark2Ext00Frame3 = function ( element, event )
						local ZmFxSpark2Ext00Frame4 = function ( element, event )
							local ZmFxSpark2Ext00Frame5 = function ( element, event )
								local ZmFxSpark2Ext00Frame6 = function ( element, event )
									if not event.interrupted then
										element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
									end
									element:setLeftRight( true, false, -10, 102 )
									element:setTopBottom( true, false, -74.01, 94.01 )
									element:setAlpha( 0 )
									if event.interrupted then
										self.clipFinished( element, event )
									else
										element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
									end
								end
								
								if event.interrupted then
									ZmFxSpark2Ext00Frame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Linear )
									element:setLeftRight( true, false, -10, 102 )
									element:setTopBottom( true, false, -74.01, 94.01 )
									element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame6 )
								end
							end
							
							if event.interrupted then
								ZmFxSpark2Ext00Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 289, false, false, CoD.TweenType.Linear )
								element:setLeftRight( true, false, 4.44, 116.44 )
								element:setTopBottom( true, false, -94, 74 )
								element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame5 )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext00Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 159, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 1.57, 113.57 )
							element:setTopBottom( true, false, -113.45, 54.55 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext00Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setLeftRight( true, false, -3.56, 108.44 )
				self.ZmFxSpark2Ext00:setTopBottom( true, false, -128, 40 )
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				ZmFxSpark2Ext00Frame2( self.ZmFxSpark2Ext00, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ZmFxSpark2Ext0:close()
		element.ZmFxSpark2Ext00:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end