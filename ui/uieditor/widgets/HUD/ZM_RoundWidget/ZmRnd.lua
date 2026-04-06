require( "ui.uieditor.widgets.HUD.ZM_Panels.ZmPanel_RndExt" )
require( "ui.uieditor.widgets.HUD.ZM_RoundWidget.ZmRndDigits" )
require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Flsh1" )
require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2Ext" )
require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2" )

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
    	local elements = {
    		self.Mrk1Def,
    		self.Mrk2Def,
    		self.Mrk3Def,
    		self.Mrk4Def,
    		self.Mrk5Def,
    		self.GlowOrangeOver,
			self.ZmFxFlsh10,
			self.ZmFxSpark2Ext0,
			self.ZmFxSpark20
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

CoD.ZmRnd = InheritFrom( LUI.UIElement )
CoD.ZmRnd.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmRnd )
	self.id = "ZmRnd"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 224 )
	self:setTopBottom( true, false, 0, 200 )
	self.anyChildUsesUpdateState = true
	
	self.Panel = CoD.ZmPanel_RndExt.new( menu, controller )
	self.Panel:setLeftRight( true, false, 0, 224 )
	self.Panel:setTopBottom( true, false, 0, 200 )
	self.Panel:setRGB( 0.61, 0.61, 0.61 )
	self.Panel:setAlpha( 0 )
	self:addElement( self.Panel )
	
	self.RndDigits = CoD.ZmRndDigits.new( menu, controller )
	self.RndDigits:setLeftRight( true, false, 44, 150 )
	self.RndDigits:setTopBottom( true, false, 84, 164 )
	self.RndDigits:linkToElementModel( self, nil, false, function ( model )
		self.RndDigits:setModel( model, controller )
	end )
	self:addElement( self.RndDigits )
	
	self.Mrk1Def = LUI.UIImage.new()
	self.Mrk1Def:setLeftRight( true, false, 40, 72 )
	self.Mrk1Def:setTopBottom( true, false, 84, 172 )
	self.Mrk1Def:setImage( RegisterImage( "uie_t7_zm_hud_rnd_mrk1def" ) )
	self:addElement( self.Mrk1Def )
	
	self.Mrk2Def = LUI.UIImage.new()
	self.Mrk2Def:setLeftRight( true, false, 65, 89 )
	self.Mrk2Def:setTopBottom( true, false, 75, 163 )
	self.Mrk2Def:setImage( RegisterImage( "uie_t7_zm_hud_rnd_mrk2def" ) )
	self:addElement( self.Mrk2Def )
	
	self.Mrk3Def = LUI.UIImage.new()
	self.Mrk3Def:setLeftRight( true, false, 85, 109 )
	self.Mrk3Def:setTopBottom( true, false, 80, 168 )
	self.Mrk3Def:setImage( RegisterImage( "uie_t7_zm_hud_rnd_mrk3def" ) )
	self:addElement( self.Mrk3Def )
	
	self.Mrk4Def = LUI.UIImage.new()
	self.Mrk4Def:setLeftRight( true, false, 105, 129 )
	self.Mrk4Def:setTopBottom( true, false, 80, 152 )
	self.Mrk4Def:setAlpha( 0 )
	self.Mrk4Def:setImage( RegisterImage( "uie_t7_zm_hud_rnd_mrk4def" ) )
	self:addElement( self.Mrk4Def )
	
	self.Mrk5Def = LUI.UIImage.new()
	self.Mrk5Def:setLeftRight( true, false, 40, 136 )
	self.Mrk5Def:setTopBottom( true, false, 88, 160 )
	self.Mrk5Def:setAlpha( 0 )
	self.Mrk5Def:setImage( RegisterImage( "uie_t7_zm_hud_rnd_mrk5def" ) )
	self:addElement( self.Mrk5Def )
	
	self.Mrk1Act = LUI.UIImage.new()
	self.Mrk1Act:setLeftRight( true, false, 40, 72 )
	self.Mrk1Act:setTopBottom( true, false, 84, 172 )
	self.Mrk1Act:setAlpha( 0 )
	self.Mrk1Act:setImage( RegisterImage( "uie_t7_zm_hud_rnd_mrk1act" ) )
	self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
	self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
	self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
	self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
	self:addElement( self.Mrk1Act )
	
	self.Mrk2Act = LUI.UIImage.new()
	self.Mrk2Act:setLeftRight( true, false, 65, 89 )
	self.Mrk2Act:setTopBottom( true, false, 75, 163 )
	self.Mrk2Act:setAlpha( 0 )
	self.Mrk2Act:setImage( RegisterImage( "uie_t7_zm_hud_rnd_mrk2act" ) )
	self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
	self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
	self.Mrk2Act:setShaderVector( 2, 1.08, 0, 0, 0 )
	self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
	self:addElement( self.Mrk2Act )
	
	self.Mrk3Act = LUI.UIImage.new()
	self.Mrk3Act:setLeftRight( true, false, 85, 109 )
	self.Mrk3Act:setTopBottom( true, false, 80, 168 )
	self.Mrk3Act:setAlpha( 0 )
	self.Mrk3Act:setImage( RegisterImage( "uie_t7_zm_hud_rnd_mrk3act" ) )
	self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
	self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
	self.Mrk3Act:setShaderVector( 2, 1.15, 0, 0, 0 )
	self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
	self:addElement( self.Mrk3Act )
	
	self.Mrk4Act = LUI.UIImage.new()
	self.Mrk4Act:setLeftRight( true, false, 105, 129 )
	self.Mrk4Act:setTopBottom( true, false, 80, 152 )
	self.Mrk4Act:setAlpha( 0 )
	self.Mrk4Act:setImage( RegisterImage( "uie_t7_zm_hud_rnd_mrk4act" ) )
	self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
	self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
	self.Mrk4Act:setShaderVector( 2, 1, 0, 0, 0 )
	self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
	self:addElement( self.Mrk4Act )
	
	self.Mrk5Act = LUI.UIImage.new()
	self.Mrk5Act:setLeftRight( true, false, 40, 136 )
	self.Mrk5Act:setTopBottom( true, false, 88, 160 )
	self.Mrk5Act:setAlpha( 0 )
	self.Mrk5Act:setImage( RegisterImage( "uie_t7_zm_hud_rnd_mrk5act" ) )
	self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
	self.Mrk5Act:setShaderVector( 1, 0.35, 0, 0, 0 )
	self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
	self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
	self:addElement( self.Mrk5Act )
	
	self.GlowOrangeOver = LUI.UIImage.new()
	self.GlowOrangeOver:setLeftRight( true, false, 43, 152 )
	self.GlowOrangeOver:setTopBottom( true, false, 104.5, 137.5 )
	self.GlowOrangeOver:setRGB( 1, 0.31, 0 )
	self.GlowOrangeOver:setAlpha( 0 )
	self.GlowOrangeOver:setZRot( -84 )
	self.GlowOrangeOver:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.GlowOrangeOver:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.GlowOrangeOver )
	
	self.ZmFxFlsh10 = CoD.ZmFx_Flsh1.new( menu, controller )
	self.ZmFxFlsh10:setLeftRight( true, false, -57.5, 257.5 )
	self.ZmFxFlsh10:setTopBottom( true, false, 0, 216 )
	self.ZmFxFlsh10:setRGB( 0, 0, 0 )
	self.ZmFxFlsh10:setAlpha( 0 )
	self.ZmFxFlsh10:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxFlsh10 )
	
	self.ZmFxSpark2Ext0 = CoD.ZmFx_Spark2Ext.new( menu, controller )
	self.ZmFxSpark2Ext0:setLeftRight( true, false, 54, 166 )
	self.ZmFxSpark2Ext0:setTopBottom( true, false, 12, 180 )
	self.ZmFxSpark2Ext0:setAlpha( 0 )
	self.ZmFxSpark2Ext0:setZRot( 9 )
	self:addElement( self.ZmFxSpark2Ext0 )
	
	self.ZmFxSpark20 = CoD.ZmFx_Spark2.new( menu, controller )
	self.ZmFxSpark20:setLeftRight( true, false, 32, 162 )
	self.ZmFxSpark20:setTopBottom( true, false, -33, 183 )
	self.ZmFxSpark20:setAlpha( 0 )
	self.ZmFxSpark20:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmFxSpark20.Image0:setShaderVector( 1, 0, 1.37, 0, 0 )
	self.ZmFxSpark20.Image00:setShaderVector( 1, 0, -0.62, 0, 0 )
	self:addElement( self.ZmFxSpark20 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				self.clipFinished( self.RndDigits, {} )

				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 0 )
				self.clipFinished( self.Mrk1Def, {} )

				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 0 )
				self.clipFinished( self.Mrk2Def, {} )

				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 0 )
				self.clipFinished( self.Mrk3Def, {} )

				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 0 )
				self.clipFinished( self.Mrk4Def, {} )

				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 0 )
				self.clipFinished( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 1 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.35, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 1.5, 110.5 )
				self.GlowOrangeOver:setTopBottom( true, false, 107.5, 140.5 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( -79 )
				self.clipFinished( self.GlowOrangeOver, {} )

				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh10, {} )

				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 5, 117 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -40, 128 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )
			end,

			Rnd1 = function ()
				self:setupElementClipCounter( 16 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				self.clipFinished( self.RndDigits, {} )

				local Mrk1DefFrame2 = function ( element, event )
					local Mrk1DefFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 789, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						Mrk1DefFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1320, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", Mrk1DefFrame3 )
					end
				end
				
				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 0 )
				Mrk1DefFrame2( self.Mrk1Def, {} )

				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 0 )
				self.clipFinished( self.Mrk2Def, {} )

				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 0 )
				self.clipFinished( self.Mrk3Def, {} )

				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 0 )
				self.clipFinished( self.Mrk4Def, {} )

				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 0 )
				self.clipFinished( self.Mrk5Def, {} )

				local Mrk1ActFrame2 = function ( element, event )
					local Mrk1ActFrame3 = function ( element, event )
						local Mrk1ActFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1009, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
							element:setShaderVector( 0, 1, 0, 0, 0 )
							element:setShaderVector( 1, 0, 0, 0, 0 )
							element:setShaderVector( 2, 1.25, 0, 0, 0 )
							element:setShaderVector( 3, 0.21, 0, 0, 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							Mrk1ActFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1209, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", Mrk1ActFrame4 )
						end
					end
					
					if event.interrupted then
						Mrk1ActFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 899, false, true, CoD.TweenType.Linear )
						element:setShaderVector( 2, 1.25, 0, 0, 0 )
						element:registerEventHandler( "transition_complete_keyframe", Mrk1ActFrame3 )
					end
				end
				
				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 1 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				Mrk1ActFrame2( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.35, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				local GlowOrangeOverFrame2 = function ( element, event )
					local GlowOrangeOverFrame3 = function ( element, event )
						local GlowOrangeOverFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1019, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 1.5, 110.5 )
							element:setTopBottom( true, false, 107.5, 140.5 )
							element:setAlpha( 0 )
							element:setZRot( -79 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							GlowOrangeOverFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2230, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame4 )
						end
					end
					
					if event.interrupted then
						GlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 889, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame3 )
					end
				end
				
				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 1.5, 110.5 )
				self.GlowOrangeOver:setTopBottom( true, false, 107.5, 140.5 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( -79 )
				GlowOrangeOverFrame2( self.GlowOrangeOver, {} )

				local ZmFxFlsh10Frame2 = function ( element, event )
					local ZmFxFlsh10Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1110, false, false, CoD.TweenType.Linear )
						end
						element:setRGB( 0, 0, 0 )
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmFxFlsh10Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 600, false, false, CoD.TweenType.Linear )
						--element:setRGB( 0.9, 0.73, 0.68 )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlsh10Frame3 )
					end
				end
				
				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setRGB( 0, 0, 0 )
				self.ZmFxFlsh10:setAlpha( 1 )
				ZmFxFlsh10Frame2( self.ZmFxFlsh10, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 17, 129 )
						element:setTopBottom( true, false, 19, 187 )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 680, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 17, 129 )
						element:setTopBottom( true, false, 19, 187 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 5, 117 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -40, 128 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )
			end
		},

		Rnd1 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				self.clipFinished( self.RndDigits, {} )

				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 1 )
				self.clipFinished( self.Mrk1Def, {} )

				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 0 )
				self.clipFinished( self.Mrk2Def, {} )

				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 0 )
				self.clipFinished( self.Mrk3Def, {} )

				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 0 )
				self.clipFinished( self.Mrk4Def, {} )

				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 0 )
				self.clipFinished( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 0 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.35, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 1.5, 110.5 )
				self.GlowOrangeOver:setTopBottom( true, false, 107.5, 140.5 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( -79 )
				self.clipFinished( self.GlowOrangeOver, {} )

				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh10, {} )

				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 17, 129 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, 19, 187 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )
			end,

			Rnd2 = function ()
				self:setupElementClipCounter( 16 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				self.clipFinished( self.RndDigits, {} )

				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 1 )
				self.clipFinished( self.Mrk1Def, {} )

				local Mrk2DefFrame2 = function ( element, event )
					local Mrk2DefFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 869, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						Mrk2DefFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1240, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", Mrk2DefFrame3 )
					end
				end
				
				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 0 )
				Mrk2DefFrame2( self.Mrk2Def, {} )

				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 0 )
				self.clipFinished( self.Mrk3Def, {} )

				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 0 )
				self.clipFinished( self.Mrk4Def, {} )

				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 0 )
				self.clipFinished( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 0 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				local Mrk2ActFrame2 = function ( element, event )
					local Mrk2ActFrame3 = function ( element, event )
						local Mrk2ActFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1009, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
							element:setShaderVector( 0, 1, 0, 0, 0 )
							element:setShaderVector( 1, 0, 0, 0, 0 )
							element:setShaderVector( 2, 1.08, 0, 0, 0 )
							element:setShaderVector( 3, 0.21, 0, 0, 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							Mrk2ActFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1429, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", Mrk2ActFrame4 )
						end
					end
					
					if event.interrupted then
						Mrk2ActFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 680, false, true, CoD.TweenType.Linear )
						element:setShaderVector( 2, 1.08, 0, 0, 0 )
						element:registerEventHandler( "transition_complete_keyframe", Mrk2ActFrame3 )
					end
				end
				
				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 1 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				Mrk2ActFrame2( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.35, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				local GlowOrangeOverFrame2 = function ( element, event )
					local GlowOrangeOverFrame3 = function ( element, event )
						local GlowOrangeOverFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1019, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 23, 132 )
							element:setTopBottom( true, false, 99.5, 132.5 )
							element:setAlpha( 0 )
							element:setZRot( -82 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							GlowOrangeOverFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2230, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame4 )
						end
					end
					
					if event.interrupted then
						GlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 889, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame3 )
					end
				end
				
				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 23, 132 )
				self.GlowOrangeOver:setTopBottom( true, false, 99.5, 132.5 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( -82 )
				GlowOrangeOverFrame2( self.GlowOrangeOver, {} )

				local ZmFxFlsh10Frame2 = function ( element, event )
					local ZmFxFlsh10Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1110, false, false, CoD.TweenType.Linear )
						end
						element:setRGB( 0, 0, 0 )
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmFxFlsh10Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 600, false, false, CoD.TweenType.Linear )
						--element:setRGB( 0.9, 0.73, 0.68 )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlsh10Frame3 )
					end
				end
				
				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setRGB( 0, 0, 0 )
				self.ZmFxFlsh10:setAlpha( 1 )
				ZmFxFlsh10Frame2( self.ZmFxFlsh10, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 38, 150 )
							element:setTopBottom( true, false, 12, 180 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 620, false, true, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 38, 150 )
							element:setTopBottom( true, false, 12, 180 )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 29.79, 141.79 )
						element:setTopBottom( true, false, -44.53, 123.47 )
						element:setAlpha( 0.45 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 29, 141 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -50, 118 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )
			end
		},

		Rnd2 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				self.clipFinished( self.RndDigits, {} )

				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 1 )
				self.clipFinished( self.Mrk1Def, {} )

				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 1 )
				self.clipFinished( self.Mrk2Def, {} )

				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 0 )
				self.clipFinished( self.Mrk3Def, {} )

				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 0 )
				self.clipFinished( self.Mrk4Def, {} )

				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 0 )
				self.clipFinished( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 0 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 1.08, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.35, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 23, 132 )
				self.GlowOrangeOver:setTopBottom( true, false, 99.5, 132.5 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( -82 )
				self.clipFinished( self.GlowOrangeOver, {} )

				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh10, {} )

				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 38, 150 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, 12, 180 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )
			end,

			Rnd3 = function ()
				self:setupElementClipCounter( 15 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				self.clipFinished( self.RndDigits, {} )

				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 1 )
				self.clipFinished( self.Mrk1Def, {} )

				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 1 )
				self.clipFinished( self.Mrk2Def, {} )

				local Mrk3DefFrame2 = function ( element, event )
					local Mrk3DefFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 869, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						Mrk3DefFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1240, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", Mrk3DefFrame3 )
					end
				end
				
				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 0 )
				Mrk3DefFrame2( self.Mrk3Def, {} )

				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 0 )
				self.clipFinished( self.Mrk4Def, {} )

				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 0 )
				self.clipFinished( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 0 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 1.08, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				local Mrk3ActFrame2 = function ( element, event )
					local Mrk3ActFrame3 = function ( element, event )
						local Mrk3ActFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
							element:setShaderVector( 0, 1, 0, 0, 0 )
							element:setShaderVector( 1, 0, 0, 0, 0 )
							element:setShaderVector( 2, 1.15, 0, 0, 0 )
							element:setShaderVector( 3, 0.26, 0, 0, 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							Mrk3ActFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1439, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", Mrk3ActFrame4 )
						end
					end
					
					if event.interrupted then
						Mrk3ActFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 680, false, true, CoD.TweenType.Linear )
						element:setShaderVector( 2, 1.15, 0, 0, 0 )
						element:registerEventHandler( "transition_complete_keyframe", Mrk3ActFrame3 )
					end
				end
				
				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 1 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				Mrk3ActFrame2( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.35, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				local GlowOrangeOverFrame2 = function ( element, event )
					local GlowOrangeOverFrame3 = function ( element, event )
						local GlowOrangeOverFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1019, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 43, 152 )
							element:setTopBottom( true, false, 104.5, 137.5 )
							element:setAlpha( 0 )
							element:setZRot( -84 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							GlowOrangeOverFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2230, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame4 )
						end
					end
					
					if event.interrupted then
						GlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 889, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame3 )
					end
				end
				
				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 43, 152 )
				self.GlowOrangeOver:setTopBottom( true, false, 104.5, 137.5 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( -84 )
				GlowOrangeOverFrame2( self.GlowOrangeOver, {} )

				local ZmFxFlsh10Frame2 = function ( element, event )
					local ZmFxFlsh10Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1110, false, false, CoD.TweenType.Linear )
						end
						element:setRGB( 0, 0, 0 )
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmFxFlsh10Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 600, false, false, CoD.TweenType.Linear )
						--element:setRGB( 0.9, 0.73, 0.68 )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlsh10Frame3 )
					end
				end
				
				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setRGB( 0, 0, 0 )
				self.ZmFxFlsh10:setAlpha( 1 )
				ZmFxFlsh10Frame2( self.ZmFxFlsh10, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 54, 166 )
							element:setTopBottom( true, false, 12, 180 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 620, false, true, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 54, 166 )
							element:setTopBottom( true, false, 12, 180 )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 49.44, 161.44 )
						element:setTopBottom( true, false, -43.62, 124.38 )
						element:setAlpha( 0.45 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 49, 161 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -49, 119 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )
			end
		},

		Rnd3 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 15 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				self.clipFinished( self.RndDigits, {} )

				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 1 )
				self.clipFinished( self.Mrk1Def, {} )

				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 1 )
				self.clipFinished( self.Mrk2Def, {} )

				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 1 )
				self.clipFinished( self.Mrk3Def, {} )

				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 0 )
				self.clipFinished( self.Mrk4Def, {} )

				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 0 )
				self.clipFinished( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 0 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 1.08, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 1.15, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.35, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 43, 152 )
				self.GlowOrangeOver:setTopBottom( true, false, 104.5, 137.5 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( -84 )
				self.clipFinished( self.GlowOrangeOver, {} )

				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh10, {} )

				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 54, 166 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, 12, 180 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0, {} )
			end,

			Rnd4 = function ()
				self:setupElementClipCounter( 16 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				self.clipFinished( self.RndDigits, {} )

				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 1 )
				self.clipFinished( self.Mrk1Def, {} )

				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 1 )
				self.clipFinished( self.Mrk2Def, {} )

				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 1 )
				self.clipFinished( self.Mrk3Def, {} )

				local Mrk4DefFrame2 = function ( element, event )
					local Mrk4DefFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 869, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						Mrk4DefFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1240, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", Mrk4DefFrame3 )
					end
				end
				
				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 0 )
				Mrk4DefFrame2( self.Mrk4Def, {} )

				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 0 )
				self.clipFinished( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 0 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 1.08, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 1.15, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				local Mrk4ActFrame2 = function ( element, event )
					local Mrk4ActFrame3 = function ( element, event )
						local Mrk4ActFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
							element:setShaderVector( 0, 1, 0, 0, 0 )
							element:setShaderVector( 1, 0, 0, 0, 0 )
							element:setShaderVector( 2, 1.12, 0, 0, 0 )
							element:setShaderVector( 3, 0.35, 0, 0, 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							Mrk4ActFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1439, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", Mrk4ActFrame4 )
						end
					end
					
					if event.interrupted then
						Mrk4ActFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 680, false, false, CoD.TweenType.Linear )
						element:setShaderVector( 2, 1.12, 0, 0, 0 )
						element:registerEventHandler( "transition_complete_keyframe", Mrk4ActFrame3 )
					end
				end
				
				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 1 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				Mrk4ActFrame2( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.35, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				local GlowOrangeOverFrame2 = function ( element, event )
					local GlowOrangeOverFrame3 = function ( element, event )
						local GlowOrangeOverFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1019, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 76, 160 )
							element:setTopBottom( true, false, 95, 128 )
							element:setAlpha( 0 )
							element:setZRot( -93 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							GlowOrangeOverFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2230, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame4 )
						end
					end
					
					if event.interrupted then
						GlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 889, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame3 )
					end
				end
				
				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 76, 160 )
				self.GlowOrangeOver:setTopBottom( true, false, 95, 128 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( -93 )
				GlowOrangeOverFrame2( self.GlowOrangeOver, {} )

				local ZmFxFlsh10Frame2 = function ( element, event )
					local ZmFxFlsh10Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1110, false, false, CoD.TweenType.Linear )
						end
						element:setRGB( 0, 0, 0 )
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmFxFlsh10Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 600, false, false, CoD.TweenType.Linear )
						--element:setRGB( 0.9, 0.73, 0.68 )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlsh10Frame3 )
					end
				end
				
				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setRGB( 0, 0, 0 )
				self.ZmFxFlsh10:setAlpha( 1 )
				ZmFxFlsh10Frame2( self.ZmFxFlsh10, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 71.5, 183.5 )
							element:setTopBottom( true, false, -4, 164 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 620, false, true, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 71.5, 183.5 )
							element:setTopBottom( true, false, -4, 164 )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 73.78, 185.78 )
						element:setTopBottom( true, false, -45.03, 122.97 )
						element:setAlpha( 0.45 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 74, 186 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -49, 119 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )
			end
		},

		Rnd4 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				self.clipFinished( self.RndDigits, {} )

				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 1 )
				self.clipFinished( self.Mrk1Def, {} )

				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 1 )
				self.clipFinished( self.Mrk2Def, {} )

				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 1 )
				self.clipFinished( self.Mrk3Def, {} )

				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 1 )
				self.clipFinished( self.Mrk4Def, {} )

				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 0 )
				self.clipFinished( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 0 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 1.08, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 1.15, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.35, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 76, 160 )
				self.GlowOrangeOver:setTopBottom( true, false, 95, 128 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( -93 )
				self.clipFinished( self.GlowOrangeOver, {} )

				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setRGB( 0, 0, 0 )
				self.ZmFxFlsh10:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh10, {} )

				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 71.5, 183.5 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -4, 164 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )
			end,

			Rnd5 = function ()
				self:setupElementClipCounter( 16 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				self.clipFinished( self.RndDigits, {} )

				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 1 )
				self.clipFinished( self.Mrk1Def, {} )

				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 1 )
				self.clipFinished( self.Mrk2Def, {} )

				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 1 )
				self.clipFinished( self.Mrk3Def, {} )

				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 1 )
				self.clipFinished( self.Mrk4Def, {} )

				local Mrk5DefFrame2 = function ( element, event )
					local Mrk5DefFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 869, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						Mrk5DefFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1240, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", Mrk5DefFrame3 )
					end
				end
				
				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 0 )
				Mrk5DefFrame2( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 0 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 1.08, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 1.15, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 1.12, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				local Mrk5ActFrame2 = function ( element, event )
					local Mrk5ActFrame3 = function ( element, event )
						local Mrk5ActFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							element:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
							element:setShaderVector( 0, 1.15, 0, 0, 0 )
							element:setShaderVector( 1, 0.22, 0, 0, 0 )
							element:setShaderVector( 2, 1, 0, 0, 0 )
							element:setShaderVector( 3, 0, 0, 0, 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							Mrk5ActFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1439, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", Mrk5ActFrame4 )
						end
					end
					
					if event.interrupted then
						Mrk5ActFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 680, false, false, CoD.TweenType.Linear )
						element:setShaderVector( 0, 1.15, 0, 0, 0 )
						element:setShaderVector( 1, 0.22, 0, 0, 0 )
						element:registerEventHandler( "transition_complete_keyframe", Mrk5ActFrame3 )
					end
				end
				
				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 1 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.11, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				Mrk5ActFrame2( self.Mrk5Act, {} )

				local GlowOrangeOverFrame2 = function ( element, event )
					local GlowOrangeOverFrame3 = function ( element, event )
						local GlowOrangeOverFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 1019, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 20, 158 )
							element:setTopBottom( true, false, 107.25, 140.25 )
							element:setAlpha( 0 )
							element:setZRot( -214 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							GlowOrangeOverFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2230, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame4 )
						end
					end
					
					if event.interrupted then
						GlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 889, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame3 )
					end
				end
				
				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 20, 158 )
				self.GlowOrangeOver:setTopBottom( true, false, 107.25, 140.25 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( -214 )
				GlowOrangeOverFrame2( self.GlowOrangeOver, {} )

				local ZmFxFlsh10Frame2 = function ( element, event )
					local ZmFxFlsh10Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1110, false, false, CoD.TweenType.Linear )
						end
						element:setRGB( 0, 0, 0 )
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmFxFlsh10Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 600, false, false, CoD.TweenType.Linear )
						--element:setRGB( 0.9, 0.73, 0.68 )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlsh10Frame3 )
					end
				end
				
				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setRGB( 0, 0, 0 )
				self.ZmFxFlsh10:setAlpha( 1 )
				ZmFxFlsh10Frame2( self.ZmFxFlsh10, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 85, 197 )
							element:setTopBottom( true, false, 8, 176 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 620, false, true, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 85, 197 )
							element:setTopBottom( true, false, 8, 176 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, -0.71, 111.29 )
						element:setTopBottom( true, false, -41.24, 126.76 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, -9, 103 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -46, 122 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )
			end
		},

		Rnd5 = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				self.clipFinished( self.RndDigits, {} )

				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 1 )
				self.clipFinished( self.Mrk1Def, {} )

				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 1 )
				self.clipFinished( self.Mrk2Def, {} )

				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 1 )
				self.clipFinished( self.Mrk3Def, {} )

				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 1 )
				self.clipFinished( self.Mrk4Def, {} )

				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 1 )
				self.clipFinished( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 0 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 1.08, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 1.15, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 1.12, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, -0.13, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.11, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 20, 158 )
				self.GlowOrangeOver:setTopBottom( true, false, 107.25, 140.25 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( -214 )
				self.clipFinished( self.GlowOrangeOver, {} )

				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setRGB( 0, 0, 0 )
				self.ZmFxFlsh10:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh10, {} )

				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 85, 197 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, 8, 176 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )
			end,

			Digits = function ()
				self:setupElementClipCounter( 16 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				local RndDigitsFrame2 = function ( element, event )
					local RndDigitsFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 389, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						RndDigitsFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 310, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", RndDigitsFrame3 )
					end
				end
				
				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 0 )
				RndDigitsFrame2( self.RndDigits, {} )

				local Mrk1DefFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 209, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 1 )
				Mrk1DefFrame2( self.Mrk1Def, {} )

				local Mrk2DefFrame2 = function ( element, event )
					local Mrk2DefFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 159, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						Mrk2DefFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 119, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", Mrk2DefFrame3 )
					end
				end
				
				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 1 )
				Mrk2DefFrame2( self.Mrk2Def, {} )

				local Mrk3DefFrame2 = function ( element, event )
					local Mrk3DefFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						Mrk3DefFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 219, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", Mrk3DefFrame3 )
					end
				end
				
				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 1 )
				Mrk3DefFrame2( self.Mrk3Def, {} )

				local Mrk4DefFrame2 = function ( element, event )
					local Mrk4DefFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						Mrk4DefFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 310, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", Mrk4DefFrame3 )
					end
				end
				
				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 1 )
				Mrk4DefFrame2( self.Mrk4Def, {} )

				local Mrk5DefFrame2 = function ( element, event )
					local Mrk5DefFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 170, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						Mrk5DefFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 379, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", Mrk5DefFrame3 )
					end
				end
				
				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 1 )
				Mrk5DefFrame2( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 0 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 1.08, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 1.15, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 1.12, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, 1.15, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.22, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				local GlowOrangeOverFrame2 = function ( element, event )
					local GlowOrangeOverFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1320, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 25, 163 )
						element:setTopBottom( true, false, 58.5, 179.5 )
						element:setAlpha( 0 )
						element:setZRot( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						GlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 620, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame3 )
					end
				end
				
				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 25, 163 )
				self.GlowOrangeOver:setTopBottom( true, false, 58.5, 179.5 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( 0 )
				GlowOrangeOverFrame2( self.GlowOrangeOver, {} )

				local ZmFxFlsh10Frame2 = function ( element, event )
					local ZmFxFlsh10Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 1110, false, false, CoD.TweenType.Linear )
						end
						element:setRGB( 0, 0, 0 )
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmFxFlsh10Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 600, false, false, CoD.TweenType.Linear )
						--element:setRGB( 0.9, 0.73, 0.68 )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxFlsh10Frame3 )
					end
				end
				
				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setRGB( 0, 0, 0 )
				self.ZmFxFlsh10:setAlpha( 1 )
				ZmFxFlsh10Frame2( self.ZmFxFlsh10, {} )

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					local ZmFxSpark2Ext0Frame3 = function ( element, event )
						local ZmFxSpark2Ext0Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 199, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 77, 189 )
							element:setTopBottom( true, false, 9, 177 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmFxSpark2Ext0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 620, false, true, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 77, 189 )
							element:setTopBottom( true, false, 9, 177 )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 11.35, 123.35 )
						element:setTopBottom( true, false, 8.09, 176.09 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 5, 117 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, 8, 176 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				local ZmFxSpark20Frame2 = function ( element, event )
					local ZmFxSpark20Frame3 = function ( element, event )
						local ZmFxSpark20Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 780, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmFxSpark20Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 779, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame4 )
						end
					end
					
					if event.interrupted then
						ZmFxSpark20Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark20Frame3 )
					end
				end
				
				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				ZmFxSpark20Frame2( self.ZmFxSpark20, {} )
			end
		},

		Digits = {
			DefaultClip = function ()
				self:setupElementClipCounter( 16 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.RndDigits:completeAnimation()
				self.RndDigits:setAlpha( 1 )
				self.clipFinished( self.RndDigits, {} )

				self.Mrk1Def:completeAnimation()
				self.Mrk1Def:setAlpha( 0 )
				self.clipFinished( self.Mrk1Def, {} )

				self.Mrk2Def:completeAnimation()
				self.Mrk2Def:setAlpha( 0 )
				self.clipFinished( self.Mrk2Def, {} )

				self.Mrk3Def:completeAnimation()
				self.Mrk3Def:setAlpha( 0 )
				self.clipFinished( self.Mrk3Def, {} )

				self.Mrk4Def:completeAnimation()
				self.Mrk4Def:setAlpha( 0 )
				self.clipFinished( self.Mrk4Def, {} )

				self.Mrk5Def:completeAnimation()
				self.Mrk5Def:setAlpha( 0 )
				self.clipFinished( self.Mrk5Def, {} )

				self.Mrk1Act:completeAnimation()
				self.Mrk1Act:setAlpha( 0 )
				self.Mrk1Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk1Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 2, 1.25, 0, 0, 0 )
				self.Mrk1Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk1Act, {} )

				self.Mrk2Act:completeAnimation()
				self.Mrk2Act:setAlpha( 0 )
				self.Mrk2Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk2Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 2, 1.08, 0, 0, 0 )
				self.Mrk2Act:setShaderVector( 3, 0.21, 0, 0, 0 )
				self.clipFinished( self.Mrk2Act, {} )

				self.Mrk3Act:completeAnimation()
				self.Mrk3Act:setAlpha( 0 )
				self.Mrk3Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk3Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 2, 1.15, 0, 0, 0 )
				self.Mrk3Act:setShaderVector( 3, 0.26, 0, 0, 0 )
				self.clipFinished( self.Mrk3Act, {} )

				self.Mrk4Act:completeAnimation()
				self.Mrk4Act:setAlpha( 0 )
				self.Mrk4Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk4Act:setShaderVector( 0, 1, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 1, 0, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 2, 1.12, 0, 0, 0 )
				self.Mrk4Act:setShaderVector( 3, 0.35, 0, 0, 0 )
				self.clipFinished( self.Mrk4Act, {} )

				self.Mrk5Act:completeAnimation()
				self.Mrk5Act:setAlpha( 0 )
				self.Mrk5Act:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.Mrk5Act:setShaderVector( 0, 1.15, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 1, 0.22, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 2, 1, 0, 0, 0 )
				self.Mrk5Act:setShaderVector( 3, 0, 0, 0, 0 )
				self.clipFinished( self.Mrk5Act, {} )

				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setLeftRight( true, false, 25, 163 )
				self.GlowOrangeOver:setTopBottom( true, false, 58.5, 179.5 )
				self.GlowOrangeOver:setAlpha( 0 )
				self.GlowOrangeOver:setZRot( 0 )
				self.clipFinished( self.GlowOrangeOver, {} )

				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setRGB( 0, 0, 0 )
				self.ZmFxFlsh10:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh10, {} )

				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 77, 189 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, 9, 177 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "Rnd1",
			condition = function ( menu, element, event )
				return IsSelfModelValueEqualTo( element, controller, "roundsPlayed", Engine.GetGametypeSetting( "startRound" ) + 1 )
			end
		},
		{
			stateName = "Rnd2",
			condition = function ( menu, element, event )
				return IsSelfModelValueEqualTo( element, controller, "roundsPlayed", Engine.GetGametypeSetting( "startRound" ) + 2 )
			end
		},
		{
			stateName = "Rnd3",
			condition = function ( menu, element, event )
				return IsSelfModelValueEqualTo( element, controller, "roundsPlayed", Engine.GetGametypeSetting( "startRound" ) + 3 )
			end
		},
		{
			stateName = "Rnd4",
			condition = function ( menu, element, event )
				return IsSelfModelValueEqualTo( element, controller, "roundsPlayed", Engine.GetGametypeSetting( "startRound" ) + 4 )
			end
		},
		{
			stateName = "Rnd5",
			condition = function ( menu, element, event )
				return IsSelfModelValueEqualTo( element, controller, "roundsPlayed", Engine.GetGametypeSetting( "startRound" ) + 5 )
			end
		},
		{
			stateName = "Digits",
			condition = function ( menu, element, event )
				return IsSelfModelValueGreaterThanOrEqualTo( element, controller, "roundsPlayed", Engine.GetGametypeSetting( "startRound" ) + 6 )
			end
		}
	} )

	self:linkToElementModel( self, "roundsPlayed", true, function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "roundsPlayed" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.Panel:close()
		element.RndDigits:close()
		element.ZmFxFlsh10:close()
		element.ZmFxSpark2Ext0:close()
		element.ZmFxSpark20:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end