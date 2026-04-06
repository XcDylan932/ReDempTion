local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        self.GlowAnim:completeAnimation()
        self.GlowAnim:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
        CoD.UIColors.SetElementColor( self.GlowAnim, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_GlowLoopFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_GlowLoopFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_GlowLoopFactory )
	self.id = "ZmAmmo_GlowLoopFactory"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 60 )
	self:setTopBottom( true, false, 0, 60 )
	
	self.GlowAnim = LUI.UIImage.new()
	self.GlowAnim:setLeftRight( true, false, 0, 60 )
	self.GlowAnim:setTopBottom( true, false, 0, 60 )
	self.GlowAnim:setImage( RegisterImage( "uie_t7_zm_derriese_hud_ammo_dpadbaseglowanim" ) )
	self:addElement( self.GlowAnim )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				local GlowAnimFrame49 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 0, 60 )
					element:setTopBottom( true, false, -33, 27 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				local GlowAnimFrame48 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame49( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -33, 27 )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame49 )
					end
				end

				local GlowAnimFrame47 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame48( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -32.01, 27.99 )
						element:setAlpha( 0.06 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame48 )
					end
				end

				local GlowAnimFrame46 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame47( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -31.02, 28.98 )
						element:setAlpha( 0.12 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame47 )
					end
				end

				local GlowAnimFrame45 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame46( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -29.92, 30.08 )
						element:setAlpha( 0.18 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame46 )
					end
				end

				local GlowAnimFrame44 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame45( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -28.82, 31.18 )
						element:setAlpha( 0.25 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame45 )
					end
				end

				local GlowAnimFrame43 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame44( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -28.38, 31.62 )
						element:setAlpha( 0.1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame44 )
					end
				end

				local GlowAnimFrame42 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame43( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -27.83, 32.17 )
						element:setAlpha( 0.31 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame43 )
					end
				end

				local GlowAnimFrame41 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame42( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -26.84, 33.16 )
						element:setAlpha( 0.37 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame42 )
					end
				end

				local GlowAnimFrame40 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame41( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -26.29, 33.71 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame41 )
					end
				end

				local GlowAnimFrame39 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame40( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -25.74, 34.26 )
						element:setAlpha( 0.44 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame40 )
					end
				end

				local GlowAnimFrame38 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame39( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -25.19, 34.81 )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame39 )
					end
				end

				local GlowAnimFrame37 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame38( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -24.75, 35.25 )
						element:setAlpha( 0.5 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame38 )
					end
				end

				local GlowAnimFrame36 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame37( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -23.76, 36.24 )
						element:setAlpha( 0.56 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame37 )
					end
				end

				local GlowAnimFrame35 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame36( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -23.21, 36.79 )
						element:setAlpha( 0.2 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame36 )
					end
				end

				local GlowAnimFrame34 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame35( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -22.66, 37.34 )
						element:setAlpha( 0.63 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame35 )
					end
				end

				local GlowAnimFrame33 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame34( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -21.67, 38.33 )
						element:setAlpha( 0.69 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame34 )
					end
				end

				local GlowAnimFrame32 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame33( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -21.12, 38.88 )
						element:setAlpha( 0.5 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame33 )
					end
				end

				local GlowAnimFrame31 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame32( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -20.57, 39.43 )
						element:setAlpha( 0.75 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame32 )
					end
				end

				local GlowAnimFrame30 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame31( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -20.13, 39.87 )
						element:setAlpha( 0.4 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame31 )
					end
				end

				local GlowAnimFrame29 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame30( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -19.58, 40.42 )
						element:setAlpha( 0.81 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame30 )
					end
				end

				local GlowAnimFrame28 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame29( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -19.03, 40.97 )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame29 )
					end
				end

				local GlowAnimFrame27 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame28( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -18.48, 41.52 )
						element:setAlpha( 0.88 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame28 )
					end
				end

				local GlowAnimFrame26 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame27( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -18.04, 41.96 )
						element:setAlpha( 0.7 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame27 )
					end
				end

				local GlowAnimFrame25 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame26( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -17.6, 42.4 )
						element:setAlpha( 0.93 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame26 )
					end
				end

				local GlowAnimFrame24 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame25( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -17.05, 42.95 )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame25 )
					end
				end

				local GlowAnimFrame23 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame24( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -16.5, 43.5 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame24 )
					end
				end

				local GlowAnimFrame22 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame23( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -16.06, 43.94 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame23 )
					end
				end

				local GlowAnimFrame21 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame22( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -15.51, 44.49 )
						element:setAlpha( 0.4 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame22 )
					end
				end

				local GlowAnimFrame20 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame21( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -14.96, 45.04 )
						element:setAlpha( 0.1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame21 )
					end
				end

				local GlowAnimFrame19 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame20( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -14.41, 45.59 )
						element:setAlpha( 0.87 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame20 )
					end
				end

				local GlowAnimFrame18 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame19( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -13.97, 46.03 )
						element:setAlpha( 0.4 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame19 )
					end
				end

				local GlowAnimFrame17 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame18( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -13.42, 46.58 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame18 )
					end
				end

				local GlowAnimFrame16 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame17( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -12.43, 47.57 )
						element:setAlpha( 0.75 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame17 )
					end
				end

				local GlowAnimFrame15 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame16( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -11.44, 48.56 )
						element:setAlpha( 0.2 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame16 )
					end
				end

				local GlowAnimFrame14 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame15( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -10.45, 49.55 )
						element:setAlpha( 0.63 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame15 )
					end
				end

				local GlowAnimFrame13 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame14( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -9.9, 50.1 )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame14 )
					end
				end

				local GlowAnimFrame12 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame13( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -9.24, 50.76 )
						element:setAlpha( 0.56 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame13 )
					end
				end

				local GlowAnimFrame11 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame12( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -8.58, 51.42 )
						element:setAlpha( 0.62 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame12 )
					end
				end

				local GlowAnimFrame10 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame11( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -7.92, 52.08 )
						element:setAlpha( 0.48 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame11 )
					end
				end

				local GlowAnimFrame9 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame10( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -7.26, 52.74 )
						element:setAlpha( 0.54 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame10 )
					end
				end

				local GlowAnimFrame8 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame9( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -6.6, 53.4 )
						element:setAlpha( 0.4 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame9 )
					end
				end

				local GlowAnimFrame7 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame8( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 70, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -5.94, 54.06 )
						element:setAlpha( 0.46 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame8 )
					end
				end

				local GlowAnimFrame6 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame7( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -5.17, 54.83 )
						element:setAlpha( 0.31 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame7 )
					end
				end

				local GlowAnimFrame5 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame6( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -4.51, 55.49 )
						element:setAlpha( 0.37 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame6 )
					end
				end

				local GlowAnimFrame4 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame5( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -3.63, 56.37 )
						element:setAlpha( 0.22 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame5 )
					end
				end

				local GlowAnimFrame3 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame4( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 70, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -2.97, 57.03 )
						element:setAlpha( 0.28 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame4 )
					end
				end

				local GlowAnimFrame2 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -2.2, 57.8 )
						element:setAlpha( 0.13 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame3 )
					end
				end
				
				self.GlowAnim:completeAnimation()
				self.GlowAnim:setLeftRight( true, false, 0, 60 )
				self.GlowAnim:setTopBottom( true, false, 0, 60 )
				self.GlowAnim:setAlpha( 0 )
				GlowAnimFrame2( self.GlowAnim, {} )

				self.nextClip = "DefaultClip"
			end
		},

		WeaponDual = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				local GlowAnimFrame49 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 0, 60 )
					element:setTopBottom( true, false, -33, 27 )
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end

				local GlowAnimFrame48 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame49( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -33, 27 )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame49 )
					end
				end

				local GlowAnimFrame47 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame48( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -32.01, 27.99 )
						element:setAlpha( 0.06 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame48 )
					end
				end

				local GlowAnimFrame46 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame47( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -31.02, 28.98 )
						element:setAlpha( 0.12 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame47 )
					end
				end

				local GlowAnimFrame45 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame46( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -29.92, 30.08 )
						element:setAlpha( 0.18 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame46 )
					end
				end

				local GlowAnimFrame44 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame45( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -28.82, 31.18 )
						element:setAlpha( 0.25 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame45 )
					end
				end

				local GlowAnimFrame43 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame44( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -28.38, 31.62 )
						element:setAlpha( 0.1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame44 )
					end
				end

				local GlowAnimFrame42 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame43( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -27.83, 32.17 )
						element:setAlpha( 0.31 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame43 )
					end
				end

				local GlowAnimFrame41 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame42( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -26.84, 33.16 )
						element:setAlpha( 0.37 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame42 )
					end
				end

				local GlowAnimFrame40 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame41( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -26.29, 33.71 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame41 )
					end
				end

				local GlowAnimFrame39 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame40( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -25.74, 34.26 )
						element:setAlpha( 0.44 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame40 )
					end
				end

				local GlowAnimFrame38 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame39( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -25.19, 34.81 )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame39 )
					end
				end

				local GlowAnimFrame37 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame38( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -24.75, 35.25 )
						element:setAlpha( 0.5 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame38 )
					end
				end

				local GlowAnimFrame36 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame37( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -23.76, 36.24 )
						element:setAlpha( 0.56 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame37 )
					end
				end

				local GlowAnimFrame35 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame36( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -23.21, 36.79 )
						element:setAlpha( 0.2 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame36 )
					end
				end

				local GlowAnimFrame34 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame35( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -22.66, 37.34 )
						element:setAlpha( 0.63 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame35 )
					end
				end

				local GlowAnimFrame33 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame34( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -21.67, 38.33 )
						element:setAlpha( 0.69 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame34 )
					end
				end

				local GlowAnimFrame32 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame33( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -21.12, 38.88 )
						element:setAlpha( 0.5 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame33 )
					end
				end

				local GlowAnimFrame31 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame32( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -20.57, 39.43 )
						element:setAlpha( 0.75 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame32 )
					end
				end

				local GlowAnimFrame30 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame31( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -20.13, 39.87 )
						element:setAlpha( 0.4 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame31 )
					end
				end

				local GlowAnimFrame29 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame30( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -19.58, 40.42 )
						element:setAlpha( 0.81 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame30 )
					end
				end

				local GlowAnimFrame28 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame29( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -19.03, 40.97 )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame29 )
					end
				end

				local GlowAnimFrame27 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame28( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -18.48, 41.52 )
						element:setAlpha( 0.88 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame28 )
					end
				end

				local GlowAnimFrame26 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame27( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -18.04, 41.96 )
						element:setAlpha( 0.7 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame27 )
					end
				end

				local GlowAnimFrame25 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame26( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -17.6, 42.4 )
						element:setAlpha( 0.93 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame26 )
					end
				end

				local GlowAnimFrame24 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame25( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -17.05, 42.95 )
						element:setAlpha( 0.6 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame25 )
					end
				end

				local GlowAnimFrame23 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame24( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -16.5, 43.5 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame24 )
					end
				end

				local GlowAnimFrame22 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame23( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -16.06, 43.94 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame23 )
					end
				end

				local GlowAnimFrame21 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame22( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -15.51, 44.49 )
						element:setAlpha( 0.4 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame22 )
					end
				end

				local GlowAnimFrame20 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame21( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -14.96, 45.04 )
						element:setAlpha( 0.1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame21 )
					end
				end

				local GlowAnimFrame19 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame20( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -14.41, 45.59 )
						element:setAlpha( 0.87 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame20 )
					end
				end

				local GlowAnimFrame18 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame19( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 49, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -13.97, 46.03 )
						element:setAlpha( 0.4 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame19 )
					end
				end

				local GlowAnimFrame17 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame18( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -13.42, 46.58 )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame18 )
					end
				end

				local GlowAnimFrame16 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame17( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -12.43, 47.57 )
						element:setAlpha( 0.75 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame17 )
					end
				end

				local GlowAnimFrame15 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame16( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 89, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -11.44, 48.56 )
						element:setAlpha( 0.2 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame16 )
					end
				end

				local GlowAnimFrame14 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame15( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -10.45, 49.55 )
						element:setAlpha( 0.63 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame15 )
					end
				end

				local GlowAnimFrame13 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame14( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -9.9, 50.1 )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame14 )
					end
				end

				local GlowAnimFrame12 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame13( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -9.24, 50.76 )
						element:setAlpha( 0.56 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame13 )
					end
				end

				local GlowAnimFrame11 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame12( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 59, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -8.58, 51.42 )
						element:setAlpha( 0.62 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame12 )
					end
				end

				local GlowAnimFrame10 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame11( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -7.92, 52.08 )
						element:setAlpha( 0.48 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame11 )
					end
				end

				local GlowAnimFrame9 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame10( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -7.26, 52.74 )
						element:setAlpha( 0.54 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame10 )
					end
				end

				local GlowAnimFrame8 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame9( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -6.6, 53.4 )
						element:setAlpha( 0.4 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame9 )
					end
				end

				local GlowAnimFrame7 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame8( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 70, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -5.94, 54.06 )
						element:setAlpha( 0.46 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame8 )
					end
				end

				local GlowAnimFrame6 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame7( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -5.17, 54.83 )
						element:setAlpha( 0.31 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame7 )
					end
				end

				local GlowAnimFrame5 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame6( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -4.51, 55.49 )
						element:setAlpha( 0.37 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame6 )
					end
				end

				local GlowAnimFrame4 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame5( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -3.63, 56.37 )
						element:setAlpha( 0.22 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame5 )
					end
				end

				local GlowAnimFrame3 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame4( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 70, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -2.97, 57.03 )
						element:setAlpha( 0.28 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame4 )
					end
				end

				local GlowAnimFrame2 = function ( element, event )
					if event.interrupted then
						GlowAnimFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 200, false, false, CoD.TweenType.Linear )
						element:setTopBottom( true, false, -2.2, 57.8 )
						element:setAlpha( 0.13 )
						element:registerEventHandler( "transition_complete_keyframe", GlowAnimFrame3 )
					end
				end
				
				self.GlowAnim:completeAnimation()
				self.GlowAnim:setLeftRight( true, false, 0, 60 )
				self.GlowAnim:setTopBottom( true, false, 0, 60 )
				self.GlowAnim:setAlpha( 0 )
				GlowAnimFrame2( self.GlowAnim, {} )

				self.nextClip = "DefaultClip"
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "WeaponDual",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThanOrEqualTo( controller, "currentWeapon.ammoInDWClip", 0 )
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.ammoInDWClip" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.ammoInDWClip" } )
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end