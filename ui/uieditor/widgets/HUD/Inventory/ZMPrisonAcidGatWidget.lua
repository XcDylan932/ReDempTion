require( "ui.uieditor.widgets.hud.Inventory.ZMPrisonShieldIcon" )

CoD.ZMPrisonAcidGatWidget = InheritFrom( LUI.UIElement )
CoD.ZMPrisonAcidGatWidget.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMPrisonAcidGatWidget )
	self.id = "ZMPrisonAcidGatWidget"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.Background = LUI.UIImage.new()
	self.Background:setLeftRight( true, false, -15, 244.66 )
	self.Background:setTopBottom( true, false, 137.33, 313.33 )
	self.Background:setImage( RegisterImage( "uie_t7_zm_prison_inventory_notif_background" ) )
	self:addElement( self.Background )
	
	self.AcidGatPart01 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.AcidGatPart01:setLeftRight( true, false, 0, 1280 )
	self.AcidGatPart01:setTopBottom( true, false, 0, 720 )
	self.AcidGatPart01.ShieldIcon:setLeftRight( true, false, 50, 101.33 )
	self.AcidGatPart01.ShieldIcon:setTopBottom( true, false, 194, 245.33 )
	self.AcidGatPart01.ZmFxSpark20:setLeftRight( true, false, 50, 101.33 )
	self.AcidGatPart01.ZmFxSpark20:setTopBottom( true, false, 194, 245.33 )
	self.AcidGatPart01.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_acidkit_fuse" ) )
	self.AcidGatPart01:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.AcidGat.engine" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.AcidGatPart01, "Found", controller )
		end
	end )
	self:addElement( self.AcidGatPart01 )
	
	self.AcidGatPart02 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.AcidGatPart02:setLeftRight( true, false, 0, 1280 )
	self.AcidGatPart02:setTopBottom( true, false, 0, 720 )
	self.AcidGatPart02.ShieldIcon:setLeftRight( true, false, 112.66, 166 )
	self.AcidGatPart02.ShieldIcon:setTopBottom( true, false, 194, 247.33 )
	self.AcidGatPart02.ZmFxSpark20:setLeftRight( true, false, 112.66, 166 )
	self.AcidGatPart02.ZmFxSpark20:setTopBottom( true, false, 194, 247.33 )
	self.AcidGatPart02.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_acidkit_case" ) )
	self.AcidGatPart02:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.AcidGat.suitcase" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.AcidGatPart02, "Found", controller )
		end
	end )
	self:addElement( self.AcidGatPart02 )
	
	self.AcidGatPart03 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.AcidGatPart03:setLeftRight( true, false, 0, 1280 )
	self.AcidGatPart03:setTopBottom( true, false, 0, 720 )
	self.AcidGatPart03.ShieldIcon:setLeftRight( true, false, 167.33, 217.33 )
	self.AcidGatPart03.ShieldIcon:setTopBottom( true, false, 196.66, 246.66 )
	self.AcidGatPart03.ZmFxSpark20:setLeftRight( true, false, 167.33, 217.33 )
	self.AcidGatPart03.ZmFxSpark20:setTopBottom( true, false, 196.66, 246.66 )
	self.AcidGatPart03.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_acidkit_blood" ) )
	self.AcidGatPart03:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.AcidGat.iv" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.AcidGatPart03, "Found", controller )
		end
	end )
	self:addElement( self.AcidGatPart03 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 4 )

				self.Background:completeAnimation()
				self.Background:setAlpha( 0 )
				self.clipFinished( self.Background, {} )

				self.AcidGatPart01:completeAnimation()
				self.AcidGatPart01:setAlpha( 0 )
				self.clipFinished( self.AcidGatPart01, {} )

				self.AcidGatPart02:completeAnimation()
				self.AcidGatPart02:setAlpha( 0 )
				self.clipFinished( self.AcidGatPart02, {} )

				self.AcidGatPart03:completeAnimation()
				self.AcidGatPart03:setAlpha( 0 )
				self.clipFinished( self.AcidGatPart03, {} )
			end,

			NotificationPopup = function()
				self:setupElementClipCounter( 4 )

				local NotificationPopupStart = function( element, event )
					local NotificationPopupFadeIn = function( element, event )
						local NotificationPopupPause = function( element, event )
							local NotificationPopupFadeOut = function( element, event )
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

					if event.interrupted then
						NotificationPopupFadeIn( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", NotificationPopupFadeIn )
					end
				end
				
				self.Background:completeAnimation()
				self.Background:setAlpha( 0 )
				NotificationPopupStart( self.Background, {} )

				self.AcidGatPart01:completeAnimation()
				self.AcidGatPart01:setAlpha( 0 )
				NotificationPopupStart( self.AcidGatPart01, {} )

				self.AcidGatPart02:completeAnimation()
				self.AcidGatPart02:setAlpha( 0 )
				NotificationPopupStart( self.AcidGatPart02, {} )

				self.AcidGatPart03:completeAnimation()
				self.AcidGatPart03:setAlpha( 0 )
				NotificationPopupStart( self.AcidGatPart03, {} )
			end
		}
	}
	
	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.AcidGat" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self, "NotificationPopup", controller )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.Background:close()
		element.AcidGatPart01:close()
		element.AcidGatPart02:close()
		element.AcidGatPart03:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end