CoD.ZMPrisonShieldIcon = InheritFrom( LUI.UIElement )
CoD.ZMPrisonShieldIcon.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMPrisonShieldIcon )
	self.id = "ZMPrisonShieldIcon"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.ZmFxSpark20 = CoD.ZmFx_Spark2.new( menu, controller )
	self.ZmFxSpark20:setRGB( 1, 0.4, 0.05 )
	self.ZmFxSpark20:setAlpha( 0 )
	self.ZmFxSpark20:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmFxSpark20.Image0:setShaderVector( 1, 0, 0.4, 0, 0 )
	self.ZmFxSpark20.Image00:setShaderVector( 1, 0, -0.2, 0, 0 )
	self:addElement( self.ZmFxSpark20 )

	self.ShieldIcon = LUI.UIImage.new()
	self.ShieldIcon:setAlpha( 0 )
	self:addElement( self.ShieldIcon )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )

				self.ShieldIcon:completeAnimation()
				self.ShieldIcon:setAlpha( 0 )
				self.clipFinished( self.ShieldIcon, {} )
			end,

			Found = function()
				self:setupElementClipCounter( 2 )

				local SparkFrame1 = function( element, event )
					local SparkFrame2 = function( element, event )
						local SparkFrame3 = function( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 1 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							SparkFrame3( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", SparkFrame3 )
						end
					end

					if event.interrupted then
						SparkFrame2( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", SparkFrame2 )
					end
				end
				
				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				SparkFrame1( self.ZmFxSpark20, {} )

				local ShieldFrame1 = function( element, event )
					local ShieldFrame2 = function( element, event )
						local ShieldFrame3 = function( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 1 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ShieldFrame3( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", ShieldFrame3 )
						end
					end

					if event.interrupted then
						ShieldFrame2( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ShieldFrame2 )
					end
				end
				
				self.ShieldIcon:completeAnimation()
				self.ShieldIcon:setAlpha( 0 )
				ShieldFrame1( self.ShieldIcon, {} )
			end,

			Reset = function()
				self:setupElementClipCounter( 2 )

				self.ShieldIcon:completeAnimation()
				self.ShieldIcon:setAlpha( 0 )
				self.clipFinished( self.ShieldIcon, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ShieldIcon, {} )
			end
		},

		Found = {
			DefaultClip = function()
				self:setupElementClipCounter( 1 )
				
				self.ShieldIcon:completeAnimation()
				self.ShieldIcon:setAlpha( 1 )
				self.clipFinished( self.ShieldIcon, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.ShieldIcon:close()
		element.ZmFxSpark20:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end