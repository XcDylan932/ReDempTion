require( "ui.uieditor.widgets.hud.Inventory.ZMPrisonShieldIcon" )

CoD.ZMPrisonRefuelWidget = InheritFrom( LUI.UIElement )
CoD.ZMPrisonRefuelWidget.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMPrisonRefuelWidget )
	self.id = "ZMPrisonRefuelWidget"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.Background = LUI.UIImage.new()
	self.Background:setLeftRight( true, false, -11, 303.33 )
	self.Background:setTopBottom( true, false, 78, 235.33 )
	self.Background:setImage( RegisterImage( "uie_t7_zm_prison_inventory_notif_background_fuel" ) )
	self:addElement( self.Background )
	
	self.Part01 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.Part01:setLeftRight( true, false, 0, 1280 )
	self.Part01:setTopBottom( true, false, 0, 720 )
	self.Part01.ShieldIcon:setLeftRight( true, false, 30, 84.66 )
	self.Part01.ShieldIcon:setTopBottom( true, false, 128, 182.66 )
	self.Part01.ZmFxSpark20:setLeftRight( true, false, 30, 84.66 )
	self.Part01.ZmFxSpark20:setTopBottom( true, false, 128, 182.66 )
	self.Part01.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_fuel" ) )
	self.Part01:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.Refuel.01" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.Part01, "Found", controller )
		else
			PlayClip( self.Part01, "Reset", controller )
		end
	end )
	self:addElement( self.Part01 )
	
	self.Part02 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.Part02:setLeftRight( true, false, 0, 1280 )
	self.Part02:setTopBottom( true, false, 0, 720 )
	self.Part02.ShieldIcon:setLeftRight( true, false, 77.33, 132 )
	self.Part02.ShieldIcon:setTopBottom( true, false, 128, 182.66 )
	self.Part02.ZmFxSpark20:setLeftRight( true, false, 77.33, 132 )
	self.Part02.ZmFxSpark20:setTopBottom( true, false, 128, 182.66 )
	self.Part02.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_fuel" ) )
	self.Part02:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.Refuel.02" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.Part02, "Found", controller )
		else
			PlayClip( self.Part02, "Reset", controller )
		end
	end )
	self:addElement( self.Part02 )
	
	self.Part03 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.Part03:setLeftRight( true, false, 0, 1280 )
	self.Part03:setTopBottom( true, false, 0, 720 )
	self.Part03.ShieldIcon:setLeftRight( true, false, 124.66, 179.33 )
	self.Part03.ShieldIcon:setTopBottom( true, false, 128, 182.66 )
	self.Part03.ZmFxSpark20:setLeftRight( true, false, 124.66, 179.33 )
	self.Part03.ZmFxSpark20:setTopBottom( true, false, 128, 182.66 )
	self.Part03.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_fuel" ) )
	self.Part03:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.Refuel.03" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.Part03, "Found", controller )
		else
			PlayClip( self.Part03, "Reset", controller )
		end
	end )
	self:addElement( self.Part03 )
	
	self.Part04 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.Part04:setLeftRight( true, false, 0, 1280 )
	self.Part04:setTopBottom( true, false, 0, 720 )
	self.Part04.ShieldIcon:setLeftRight( true, false, 172.66, 227.33 )
	self.Part04.ShieldIcon:setTopBottom( true, false, 128, 182.66 )
	self.Part04.ZmFxSpark20:setLeftRight( true, false, 172.66, 227.33 )
	self.Part04.ZmFxSpark20:setTopBottom( true, false, 128, 182.66 )
	self.Part04.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_fuel" ) )
	self.Part04:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.Refuel.04" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.Part04, "Found", controller )
		else
			PlayClip( self.Part04, "Reset", controller )
		end
	end )
	self:addElement( self.Part04 )
	
	self.Part05 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.Part05:setLeftRight( true, false, 0, 1280 )
	self.Part05:setTopBottom( true, false, 0, 720 )
	self.Part05.ShieldIcon:setLeftRight( true, false, 220.66, 275.33 )
	self.Part05.ShieldIcon:setTopBottom( true, false, 128, 182.66 )
	self.Part05.ZmFxSpark20:setLeftRight( true, false, 220.66, 275.33 )
	self.Part05.ZmFxSpark20:setTopBottom( true, false, 128, 182.66 )
	self.Part05.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_fuel" ) )
	self.Part05:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.Refuel.05" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.Part05, "Found", controller )
		else
			PlayClip( self.Part05, "Reset", controller )
		end
	end )
	self:addElement( self.Part05 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 6 )

				self.Background:completeAnimation()
				self.Background:setAlpha( 0 )
				self.clipFinished( self.Background, {} )

				self.Part01:completeAnimation()
				self.Part01:setAlpha( 0 )
				self.clipFinished( self.Part01, {} )

				self.Part02:completeAnimation()
				self.Part02:setAlpha( 0 )
				self.clipFinished( self.Part02, {} )

				self.Part03:completeAnimation()
				self.Part03:setAlpha( 0 )
				self.clipFinished( self.Part03, {} )

				self.Part04:completeAnimation()
				self.Part04:setAlpha( 0 )
				self.clipFinished( self.Part04, {} )

				self.Part05:completeAnimation()
				self.Part05:setAlpha( 0 )
				self.clipFinished( self.Part05, {} )
			end,

			NotificationPopup = function()
				self:setupElementClipCounter( 6 )

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

				self.Part01:completeAnimation()
				self.Part01:setAlpha( 0 )
				NotificationPopupStart( self.Part01, {} )

				self.Part02:completeAnimation()
				self.Part02:setAlpha( 0 )
				NotificationPopupStart( self.Part02, {} )

				self.Part03:completeAnimation()
				self.Part03:setAlpha( 0 )
				NotificationPopupStart( self.Part03, {} )

				self.Part04:completeAnimation()
				self.Part04:setAlpha( 0 )
				NotificationPopupStart( self.Part04, {} )

				self.Part05:completeAnimation()
				self.Part05:setAlpha( 0 )
				NotificationPopupStart( self.Part05, {} )
			end
		}
	}

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.RefuelQuest" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self, "NotificationPopup", controller )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.Background:close()
		element.Part01:close()
		element.Part02:close()
		element.Part03:close()
		element.Part04:close()
		element.Part05:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end