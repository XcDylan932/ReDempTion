require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2Ext" )
require( "ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Flsh1" )

local PreLoadFunc = function ( self, controller )
	Engine.CreateModel( Engine.GetModelForController( controller ), "player_lives" )
end

local PostLoadFunc = function( self, controller )
	local mapName = Engine.GetCurrentMap()
	local indicateLives = mapName == "zm_zod" or mapName == "zm_prison"
	local controllerModel = Engine.GetModelForController( controller )
	local playerLivesModel = Engine.GetModel( controllerModel, "player_lives" )
	local playerLives = Engine.GetModelValue( playerLivesModel )
	if not indicateLives then
		Engine.SetModelValue( playerLivesModel, 0 )
	end
end

CoD.ZmAmmo_PlayerLivesIndicator = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_PlayerLivesIndicator.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_PlayerLivesIndicator )
	self.id = "ZmAmmo_PlayerLivesIndicator"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 50 )
	self:setTopBottom( true, false, 0, 50 )
	
	self.BeastInactive = LUI.UIImage.new()
	self.BeastInactive:setLeftRight( true, false, 0, 50 )
	self.BeastInactive:setTopBottom( true, false, 0, 50 )
	self.BeastInactive:setImage( RegisterImage( "uie_t7_zm_zod_decal_symbol_beast_shuboth_inactive" ) )
	self:addElement( self.BeastInactive )
	
	self.BeastBlue = LUI.UIImage.new()
	self.BeastBlue:setLeftRight( true, false, 0, 50 )
	self.BeastBlue:setTopBottom( true, false, 0, 50 )
	self.BeastBlue:setAlpha( 0.7 )
	self.BeastBlue:setImage( RegisterImage( "uie_t7_zm_zod_decal_symbol_beast_shuboth_blue" ) )
	self:addElement( self.BeastBlue )
	
	self.BeastLight = LUI.UIImage.new()
	self.BeastLight:setLeftRight( true, false, 0, 50 )
	self.BeastLight:setTopBottom( true, false, 0, 50 )
	self.BeastLight:setImage( RegisterImage( "uie_t7_zm_zod_decal_symbol_beast_shuboth_light" ) )
	self.BeastLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self.BeastLight:setShaderVector( 0, 1, 0, 0, 0 )
	self.BeastLight:setShaderVector( 1, 0, 0, 0, 0 )
	self.BeastLight:setShaderVector( 2, 1, 0, 0, 0 )
	self.BeastLight:setShaderVector( 3, 0.2, 0, 0, 0 )
	self:addElement( self.BeastLight )
	
	self.BeastGlow = LUI.UIImage.new()
	self.BeastGlow:setLeftRight( true, false, 0, 50 )
	self.BeastGlow:setTopBottom( true, false, 0, 50 )
	self.BeastGlow:setRGB( 1, 0.53, 0 )
	self.BeastGlow:setImage( RegisterImage( "uie_t7_zm_zod_decal_symbol_beast_shuboth_glow" ) )
	self.BeastGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.BeastGlow )
	
	self.ZmFxSpark2Ext0 = CoD.ZmFx_Spark2Ext.new( menu, controller )
	self.ZmFxSpark2Ext0:setLeftRight( true, false, 5.33, 48 )
	self.ZmFxSpark2Ext0:setTopBottom( true, false, -52, 12 )
	self.ZmFxSpark2Ext0:setZRot( 9 )
	self.ZmFxSpark2Ext0:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxSpark2Ext0 )
	
	self.ZmFxSpark2Ext00 = CoD.ZmFx_Spark2Ext.new( menu, controller )
	self.ZmFxSpark2Ext00:setLeftRight( true, false, 12.33, 55 )
	self.ZmFxSpark2Ext00:setTopBottom( true, false, -37, 27 )
	self.ZmFxSpark2Ext00:setZRot( 9 )
	self.ZmFxSpark2Ext00:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxSpark2Ext00 )
	
	self.ZmFxSpark2Ext000 = CoD.ZmFx_Spark2Ext.new( menu, controller )
	self.ZmFxSpark2Ext000:setLeftRight( true, false, 13.89, 56.56 )
	self.ZmFxSpark2Ext000:setTopBottom( true, false, -32, 32 )
	self.ZmFxSpark2Ext000:setAlpha( 0 )
	self.ZmFxSpark2Ext000:setZRot( 9 )
	self.ZmFxSpark2Ext000:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxSpark2Ext000 )
	
	self.ZmFxSpark2Ext0000 = CoD.ZmFx_Spark2Ext.new( menu, controller )
	self.ZmFxSpark2Ext0000:setLeftRight( true, false, 1.26, 43.93 )
	self.ZmFxSpark2Ext0000:setTopBottom( true, false, -16.89, 47.11 )
	self.ZmFxSpark2Ext0000:setZRot( 9 )
	self.ZmFxSpark2Ext0000:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxSpark2Ext0000 )
	
	self.ZmFxFlsh10 = CoD.ZmFx_Flsh1.new( menu, controller )
	self.ZmFxFlsh10:setLeftRight( true, false, 0, 50 )
	self.ZmFxFlsh10:setTopBottom( true, false, -11, 65 )
	self.ZmFxFlsh10:setRGB( 0.71, 0.57, 0.32 )
	self.ZmFxFlsh10:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxFlsh10 )
	
	self.GlowOrangeOver = LUI.UIImage.new()
	self.GlowOrangeOver:setLeftRight( true, false, -1.4, 46.59 )
	self.GlowOrangeOver:setTopBottom( true, false, -15.85, 69.85 )
	self.GlowOrangeOver:setRGB( 1, 0.31, 0 )
	self.GlowOrangeOver:setZRot( -84 )
	self.GlowOrangeOver:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.GlowOrangeOver:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.GlowOrangeOver )
	
	self.ZmFxSpark2Ext00000 = CoD.ZmFx_Spark2Ext.new( menu, controller )
	self.ZmFxSpark2Ext00000:setLeftRight( true, false, -15.45, 56.56 )
	self.ZmFxSpark2Ext00000:setTopBottom( true, false, -49, 59 )
	self.ZmFxSpark2Ext00000:setRGB( 0, 0.89, 1 )
	self.ZmFxSpark2Ext00000:setYRot( 180 )
	self.ZmFxSpark2Ext00000:setZRot( 9 )
	self.ZmFxSpark2Ext00000:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.ZmFxSpark2Ext00000 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 0 )
			end
		},

		Hidden = {
			DefaultClip = function ()
				self:setupElementClipCounter( 11 )

				self.BeastInactive:completeAnimation()
				self.BeastInactive:setAlpha( 0 )
				self.clipFinished( self.BeastInactive, {} )

				self.BeastBlue:completeAnimation()
				self.BeastBlue:setAlpha( 0 )
				self.clipFinished( self.BeastBlue, {} )

				self.BeastLight:completeAnimation()
				self.BeastLight:setAlpha( 0 )
				self.clipFinished( self.BeastLight, {} )

				self.BeastGlow:completeAnimation()
				self.BeastGlow:setAlpha( 0 )
				self.clipFinished( self.BeastGlow, {} )

				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext00, {} )

				self.ZmFxSpark2Ext000:completeAnimation()
				self.ZmFxSpark2Ext000:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext000, {} )

				self.ZmFxSpark2Ext0000:completeAnimation()
				self.ZmFxSpark2Ext0000:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0000, {} )

				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh10, {} )

				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setAlpha( 0 )
				self.clipFinished( self.GlowOrangeOver, {} )

				self.ZmFxSpark2Ext00000:completeAnimation()
				self.ZmFxSpark2Ext00000:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext00000, {} )
			end
		},

		Unavailable = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.BeastInactive:completeAnimation()
				self.BeastInactive:setAlpha( 0.8 )
				self.clipFinished( self.BeastInactive, {} )

				self.BeastBlue:completeAnimation()
				self.BeastBlue:setAlpha( 0 )
				self.clipFinished( self.BeastBlue, {} )

				self.BeastLight:completeAnimation()
				self.BeastLight:setAlpha( 0 )
				self.clipFinished( self.BeastLight, {} )

				self.BeastGlow:completeAnimation()
				self.BeastGlow:setAlpha( 0 )
				self.clipFinished( self.BeastGlow, {} )

				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext00, {} )

				self.ZmFxSpark2Ext0000:completeAnimation()
				self.ZmFxSpark2Ext0000:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0000, {} )

				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh10, {} )

				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setAlpha( 0 )
				self.clipFinished( self.GlowOrangeOver, {} )

				self.ZmFxSpark2Ext00000:completeAnimation()
				self.ZmFxSpark2Ext00000:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext00000, {} )
			end
		},

		Available = {
			DefaultClip = function ()
				self:setupElementClipCounter( 11 )

				local BeastInactiveFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 529, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.BeastInactive:completeAnimation()
				self.BeastInactive:setAlpha( 0.8 )
				BeastInactiveFrame2( self.BeastInactive, {} )

				local BeastBlueFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 529, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.BeastBlue:completeAnimation()
				self.BeastBlue:setAlpha( 0 )
				BeastBlueFrame2( self.BeastBlue, {} )

				local BeastLightFrame9 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 230, false, false, CoD.TweenType.Linear )
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

				local BeastLightFrame8 = function ( element, event )
					if event.interrupted then
						BeastLightFrame9( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 230, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", BeastLightFrame9 )
					end
				end

				local BeastLightFrame7 = function ( element, event )
					if event.interrupted then
						BeastLightFrame8( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastLightFrame8 )
					end
				end

				local BeastLightFrame6 = function ( element, event )
					if event.interrupted then
						BeastLightFrame7( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 219, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", BeastLightFrame7 )
					end
				end

				local BeastLightFrame5 = function ( element, event )
					if event.interrupted then
						BeastLightFrame6( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", BeastLightFrame6 )
					end
				end

				local BeastLightFrame4 = function ( element, event )
					if event.interrupted then
						BeastLightFrame5( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastLightFrame5 )
					end
				end

				local BeastLightFrame3 = function ( element, event )
					if event.interrupted then
						BeastLightFrame4( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 589, false, false, CoD.TweenType.Linear )
						element:setShaderVector( 2, 1, 0, 0, 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastLightFrame4 )
					end
				end

				local BeastLightFrame2 = function ( element, event )
					if event.interrupted then
						BeastLightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 119, false, false, CoD.TweenType.Linear )
						element:setShaderVector( 0, 1, 0, 0, 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastLightFrame3 )
					end
				end
				
				self.BeastLight:completeAnimation()
				self.BeastLight:setAlpha( 1 )
				self.BeastLight:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
				self.BeastLight:setShaderVector( 0, 0, 0, 0, 0 )
				self.BeastLight:setShaderVector( 1, 0, 0, 0, 0 )
				self.BeastLight:setShaderVector( 2, 0, 0, 0, 0 )
				self.BeastLight:setShaderVector( 3, 0.2, 0, 0, 0 )
				BeastLightFrame2( self.BeastLight, {} )

				local BeastGlowFrame39 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 840, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				local BeastGlowFrame38 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame39( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 690, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame39 )
					end
				end

				local BeastGlowFrame37 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame38( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 709, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame38 )
					end
				end

				local BeastGlowFrame36 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame37( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 649, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame37 )
					end
				end

				local BeastGlowFrame35 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame36( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 670, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame36 )
					end
				end

				local BeastGlowFrame34 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame35( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 610, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame35 )
					end
				end

				local BeastGlowFrame33 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame34( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 510, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame34 )
					end
				end

				local BeastGlowFrame32 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame33( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 659, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame33 )
					end
				end

				local BeastGlowFrame31 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame32( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 639, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame32 )
					end
				end

				local BeastGlowFrame30 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame31( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 690, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame31 )
					end
				end

				local BeastGlowFrame29 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame30( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 710, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame30 )
					end
				end

				local BeastGlowFrame28 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame29( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 649, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame29 )
					end
				end

				local BeastGlowFrame27 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame28( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 670, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame28 )
					end
				end

				local BeastGlowFrame26 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame27( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 610, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame27 )
					end
				end

				local BeastGlowFrame25 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame26( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 509, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame26 )
					end
				end

				local BeastGlowFrame24 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame25( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 800, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame25 )
					end
				end

				local BeastGlowFrame23 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame24( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 840, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame24 )
					end
				end

				local BeastGlowFrame22 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame23( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 689, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame23 )
					end
				end

				local BeastGlowFrame21 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame22( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 710, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame22 )
					end
				end

				local BeastGlowFrame20 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame21( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 650, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame21 )
					end
				end

				local BeastGlowFrame19 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame20( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 670, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame20 )
					end
				end

				local BeastGlowFrame18 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame19( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 609, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame19 )
					end
				end

				local BeastGlowFrame17 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame18( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 510, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame18 )
					end
				end

				local BeastGlowFrame16 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame17( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 659, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame17 )
					end
				end

				local BeastGlowFrame15 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame16( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 639, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame16 )
					end
				end

				local BeastGlowFrame14 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame15( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 690, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame15 )
					end
				end

				local BeastGlowFrame13 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame14( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 710, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame14 )
					end
				end

				local BeastGlowFrame12 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame13( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 650, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame13 )
					end
				end

				local BeastGlowFrame11 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame12( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 670, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame12 )
					end
				end

				local BeastGlowFrame10 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame11( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 609, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame11 )
					end
				end

				local BeastGlowFrame9 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame10( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 509, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame10 )
					end
				end

				local BeastGlowFrame8 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame9( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 460, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame9 )
					end
				end

				local BeastGlowFrame7 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame8( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 230, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame8 )
					end
				end

				local BeastGlowFrame6 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame7( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 230, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame7 )
					end
				end

				local BeastGlowFrame5 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame6( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame6 )
					end
				end

				local BeastGlowFrame4 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame5( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 219, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame5 )
					end
				end

				local BeastGlowFrame3 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame4( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame4 )
					end
				end

				local BeastGlowFrame2 = function ( element, event )
					if event.interrupted then
						BeastGlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame3 )
					end
				end
				
				self.BeastGlow:beginAnimation( "keyframe", 709, false, false, CoD.TweenType.Linear )
				self.BeastGlow:setAlpha( 0 )
				self.BeastGlow:registerEventHandler( "transition_complete_keyframe", BeastGlowFrame2 )

				local ZmFxSpark2Ext0Frame5 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 180, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, -2.67, 40 )
					element:setTopBottom( true, false, -25, 39 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				local ZmFxSpark2Ext0Frame4 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext0Frame5( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 170, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, -2.67, 40 )
						element:setTopBottom( true, false, -25, 39 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame5 )
					end
				end

				local ZmFxSpark2Ext0Frame3 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext0Frame4( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, -1.67, 41 )
						element:setTopBottom( true, false, -37, 27 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame4 )
					end
				end

				local ZmFxSpark2Ext0Frame2 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setLeftRight( true, false, 7.33, 50 )
				self.ZmFxSpark2Ext0:setTopBottom( true, false, -51, 13 )
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				ZmFxSpark2Ext0Frame2( self.ZmFxSpark2Ext0, {} )

				local ZmFxSpark2Ext00Frame6 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 189, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 5.33, 48 )
					element:setTopBottom( true, false, -28, 36 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				local ZmFxSpark2Ext00Frame5 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext00Frame6( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 5.33, 48 )
						element:setTopBottom( true, false, -28, 36 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame6 )
					end
				end

				local ZmFxSpark2Ext00Frame4 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext00Frame5( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 9.53, 52.2 )
						element:setTopBottom( true, false, -33.4, 30.6 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame5 )
					end
				end

				local ZmFxSpark2Ext00Frame3 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext00Frame4( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame4 )
					end
				end

				local ZmFxSpark2Ext00Frame2 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext00Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setLeftRight( true, false, 12.33, 55 )
				self.ZmFxSpark2Ext00:setTopBottom( true, false, -37, 27 )
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				ZmFxSpark2Ext00Frame2( self.ZmFxSpark2Ext00, {} )

				local ZmFxSpark2Ext000Frame5 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 23.89, 66.56 )
					element:setTopBottom( true, false, -22, 42 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				local ZmFxSpark2Ext000Frame4 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext000Frame5( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 23.89, 66.56 )
						element:setTopBottom( true, false, -22, 42 )
						element:setAlpha( 0.55 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext000Frame5 )
					end
				end

				local ZmFxSpark2Ext000Frame3 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext000Frame4( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 139, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 21.52, 64.19 )
						element:setTopBottom( true, false, -24.11, 39.89 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext000Frame4 )
					end
				end

				local ZmFxSpark2Ext000Frame2 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext000Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 80, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 14.89, 57.56 )
						element:setTopBottom( true, false, -30, 34 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext000Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext000:beginAnimation( "keyframe", 460, false, false, CoD.TweenType.Linear )
				self.ZmFxSpark2Ext000:setLeftRight( true, false, 13.89, 56.56 )
				self.ZmFxSpark2Ext000:setTopBottom( true, false, -32, 32 )
				self.ZmFxSpark2Ext000:setAlpha( 0 )
				self.ZmFxSpark2Ext000:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext000Frame2 )

				local ZmFxSpark2Ext0000Frame7 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 119, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 14.33, 57 )
					element:setTopBottom( true, false, -16.89, 47.11 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				local ZmFxSpark2Ext0000Frame6 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext0000Frame7( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 14.33, 57 )
						element:setTopBottom( true, false, -16.89, 47.11 )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0000Frame7 )
					end
				end

				local ZmFxSpark2Ext0000Frame5 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext0000Frame6( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 139, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 11.78, 54.45 )
						element:setTopBottom( true, false, -14.71, 49.29 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0000Frame6 )
					end
				end

				local ZmFxSpark2Ext0000Frame4 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext0000Frame5( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 7.33, 50 )
						element:setTopBottom( true, false, -10.89, 53.11 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0000Frame5 )
					end
				end

				local ZmFxSpark2Ext0000Frame3 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext0000Frame4( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0000Frame4 )
					end
				end

				local ZmFxSpark2Ext0000Frame2 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext0000Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 9, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0000Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext0000:beginAnimation( "keyframe", 569, false, false, CoD.TweenType.Linear )
				self.ZmFxSpark2Ext0000:setLeftRight( true, false, 1.26, 43.93 )
				self.ZmFxSpark2Ext0000:setTopBottom( true, false, -16.89, 47.11 )
				self.ZmFxSpark2Ext0000:setAlpha( 0 )
				self.ZmFxSpark2Ext0000:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext0000Frame2 )

				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh10, {} )

				local GlowOrangeOverFrame6 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 220, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				local GlowOrangeOverFrame5 = function ( element, event )
					if event.interrupted then
						GlowOrangeOverFrame6( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame6 )
					end
				end

				local GlowOrangeOverFrame4 = function ( element, event )
					if event.interrupted then
						GlowOrangeOverFrame5( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 70, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame5 )
					end
				end

				local GlowOrangeOverFrame3 = function ( element, event )
					if event.interrupted then
						GlowOrangeOverFrame4( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 110, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame4 )
					end
				end

				local GlowOrangeOverFrame2 = function ( element, event )
					if event.interrupted then
						GlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1159, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", GlowOrangeOverFrame3 )
					end
				end
				
				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setAlpha( 0 )
				GlowOrangeOverFrame2( self.GlowOrangeOver, {} )

				local ZmFxSpark2Ext00000Frame4 = function ( element, event )
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

				local ZmFxSpark2Ext00000Frame3 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext00000Frame4( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 339, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.7 )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00000Frame4 )
					end
				end

				local ZmFxSpark2Ext00000Frame2 = function ( element, event )
					if event.interrupted then
						ZmFxSpark2Ext00000Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmFxSpark2Ext00000Frame3 )
					end
				end
				
				self.ZmFxSpark2Ext00000:completeAnimation()
				self.ZmFxSpark2Ext00000:setAlpha( 0 )
				ZmFxSpark2Ext00000Frame2( self.ZmFxSpark2Ext00000, {} )
			end
		},

		HiddenNotZod = {
			DefaultClip = function ()
				self:setupElementClipCounter( 11 )

				self.BeastInactive:completeAnimation()
				self.BeastInactive:setAlpha( 0 )
				self.clipFinished( self.BeastInactive, {} )

				self.BeastBlue:completeAnimation()
				self.BeastBlue:setAlpha( 0 )
				self.clipFinished( self.BeastBlue, {} )

				self.BeastLight:completeAnimation()
				self.BeastLight:setAlpha( 0 )
				self.clipFinished( self.BeastLight, {} )

				self.BeastGlow:completeAnimation()
				self.BeastGlow:setAlpha( 0 )
				self.clipFinished( self.BeastGlow, {} )

				self.ZmFxSpark2Ext0:completeAnimation()
				self.ZmFxSpark2Ext0:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0, {} )

				self.ZmFxSpark2Ext00:completeAnimation()
				self.ZmFxSpark2Ext00:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext00, {} )

				self.ZmFxSpark2Ext000:completeAnimation()
				self.ZmFxSpark2Ext000:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext000, {} )

				self.ZmFxSpark2Ext0000:completeAnimation()
				self.ZmFxSpark2Ext0000:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext0000, {} )

				self.ZmFxFlsh10:completeAnimation()
				self.ZmFxFlsh10:setAlpha( 0 )
				self.clipFinished( self.ZmFxFlsh10, {} )

				self.GlowOrangeOver:completeAnimation()
				self.GlowOrangeOver:setAlpha( 0 )
				self.clipFinished( self.GlowOrangeOver, {} )

				self.ZmFxSpark2Ext00000:completeAnimation()
				self.ZmFxSpark2Ext00000:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark2Ext00000, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
		    stateName = "Hidden",
		    condition = function ( menu, element, event )
		        if not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE ) 
		        or not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE ) then
		            return true
		        end

		        return Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_KILLCAM )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
	            or Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE )
		    end
		},
		{
			stateName = "Unavailable",
			condition = function ( menu, element, event )
				return not IsModelValueGreaterThan( controller, "player_lives", 0 )
			end
		},
		{
			stateName = "Available",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "player_lives" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "player_lives" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ZmFxSpark2Ext0:close()
		element.ZmFxSpark2Ext00:close()
		element.ZmFxSpark2Ext000:close()
		element.ZmFxSpark2Ext0000:close()
		element.ZmFxFlsh10:close()
		element.ZmFxSpark2Ext00000:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end