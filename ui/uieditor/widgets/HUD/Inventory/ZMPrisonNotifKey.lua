CoD.ZMPrisonNotifKey = InheritFrom( LUI.UIElement )
CoD.ZMPrisonNotifKey.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMPrisonNotifKey )
	self.id = "ZMPrisonNotifKey"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.Background = LUI.UIImage.new()
	self.Background:setLeftRight( true, false, -15, 137.33 )
	self.Background:setTopBottom( true, false, 214.66, 375.33 )
	self.Background:setImage( RegisterImage( "uie_t7_zm_prison_inventory_notif_background_small" ) )
	self.Background:setAlpha( 0.95 )
	self:addElement( self.Background )

	self.ZmFxSpark20 = CoD.ZmFx_Spark2.new( menu, controller )
	self.ZmFxSpark20:setLeftRight( true, false, 47.33, 104.66 )
	self.ZmFxSpark20:setTopBottom( true, false, 264, 321.33 )
	self.ZmFxSpark20:setRGB( 1, 0.4, 0.05 )
	self.ZmFxSpark20:setAlpha( 0 )
	self.ZmFxSpark20:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmFxSpark20.Image0:setShaderVector( 1, 0, 0.4, 0, 0 )
	self.ZmFxSpark20.Image00:setShaderVector( 1, 0, -0.2, 0, 0 )
	self:addElement( self.ZmFxSpark20 )

	self.KeyIcon = LUI.UIImage.new()
	self.KeyIcon:setLeftRight( true, false, 47.33, 104.66 )
	self.KeyIcon:setTopBottom( true, false, 264, 321.33 )
	self.KeyIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_key" ) )
	self:addElement( self.KeyIcon )

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.Background:completeAnimation()
				self.Background:setAlpha( 0 )
				self.clipFinished( self.Background, {} )

				self.KeyIcon:completeAnimation()
				self.KeyIcon:setAlpha( 0 )
				self.clipFinished( self.KeyIcon, {} )
			end,

			NotificationPopup = function ()
				self:setupElementClipCounter( 3 )

				local NotificationPopupFadeIn = function ( element, event )
					local NotificationPopupPause = function ( element, event )
						local NotificationPopupFadeOut = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							NotificationPopupFadeOut( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2500, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", NotificationPopupFadeOut )
						end
					end

					if event.interrupted then
						NotificationPopupPause( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", NotificationPopupPause )
					end
				end
				
				self.Background:completeAnimation()
				self.Background:setAlpha( 0 )
				NotificationPopupFadeIn( self.Background, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				NotificationPopupFadeIn( self.ZmFxSpark20, {} )

				self.KeyIcon:completeAnimation()
				self.KeyIcon:setAlpha( 0 )
				NotificationPopupFadeIn( self.KeyIcon, {} )
			end
		}
	}

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.Wardenskey" ), function ( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self, "NotificationPopup", controller )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.Background:close()
		element.ZmFxSpark20:close()
		element.KeyIcon:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end