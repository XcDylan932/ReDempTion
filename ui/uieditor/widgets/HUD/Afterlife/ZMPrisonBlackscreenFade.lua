CoD.ZMPrisonBlackscreenFade = InheritFrom( LUI.UIElement )
CoD.ZMPrisonBlackscreenFade.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMPrisonBlackscreenFade )
	self.id = "ZMPrisonBlackscreenFade"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.Background = LUI.UIImage.new()
	self.Background:setLeftRight( true, false, 0, 1280 )
	self.Background:setTopBottom( true, false, 0, 720 )
	self.Background:setImage( RegisterImage( "$black2d" ) )
	self.Background:setAlpha( 1 )
	self:addElement( self.Background )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )

				self.Background:completeAnimation()
				self.Background:setAlpha( 0 )
				self.clipFinished( self.Background, {} )
			end,

			IntroAnim = function()
				self:setupElementClipCounter( 1 )

				local BackgroundFrame2 = function( element, event )
					local BackgroundFrame3 = function( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 800, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						BackgroundFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 3250, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", BackgroundFrame3 )
					end
				end
				
				self.Background:completeAnimation()
				self.Background:setAlpha( 1 )
				BackgroundFrame2( self.Background, {} )
			end
		}
	}

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "IntroFadeIn" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self, "IntroAnim", controller )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.Background:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end