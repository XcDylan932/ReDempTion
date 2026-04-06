require( "ui.uieditor.widgets.hud.Inventory.ZMPrisonShieldIcon" )

CoD.ZMPrisonPlaneQuestWidget = InheritFrom( LUI.UIElement )
CoD.ZMPrisonPlaneQuestWidget.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMPrisonPlaneQuestWidget )
	self.id = "ZMPrisonPlaneQuestWidget"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.Background = LUI.UIImage.new()
	self.Background:setLeftRight( true, false, -11, 303.33 )
	self.Background:setTopBottom( true, false, 78, 235.33 )
	self.Background:setImage( RegisterImage( "uie_t7_zm_prison_inventory_notif_background_plane" ) )
	self:addElement( self.Background )
	
	self.PlanePart01 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.PlanePart01:setLeftRight( true, false, 0, 1280 )
	self.PlanePart01:setTopBottom( true, false, 0, 720 )
	self.PlanePart01.ShieldIcon:setLeftRight( true, false, 24, 87.33 )
	self.PlanePart01.ShieldIcon:setTopBottom( true, false, 122.66, 186 )
	self.PlanePart01.ZmFxSpark20:setLeftRight( true, false, 24, 87.33 )
	self.PlanePart01.ZmFxSpark20:setTopBottom( true, false, 122.66, 186 )
	self.PlanePart01.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_laundry" ) )
	self.PlanePart01:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.Plane.clothes" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.PlanePart01, "Found", controller )
		end
	end )
	self:addElement( self.PlanePart01 )
	
	self.PlanePart02 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.PlanePart02:setLeftRight( true, false, 0, 1280 )
	self.PlanePart02:setTopBottom( true, false, 0, 720 )
	self.PlanePart02.ShieldIcon:setLeftRight( true, false, 77.33, 129.33 )
	self.PlanePart02.ShieldIcon:setTopBottom( true, false, 128.66, 180.66 )
	self.PlanePart02.ZmFxSpark20:setLeftRight( true, false, 77.33, 129.33 )
	self.PlanePart02.ZmFxSpark20:setTopBottom( true, false, 128.66, 180.66 )
	self.PlanePart02.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_tank" ) )
	self.PlanePart02:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.Plane.tank" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.PlanePart02, "Found", controller )
		end
	end )
	self:addElement( self.PlanePart02 )
	
	self.PlanePart03 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.PlanePart03:setLeftRight( true, false, 0, 1280 )
	self.PlanePart03:setTopBottom( true, false, 0, 720 )
	self.PlanePart03.ShieldIcon:setLeftRight( true, false, 122, 179.33 )
	self.PlanePart03.ShieldIcon:setTopBottom( true, false, 129.33, 186.66 )
	self.PlanePart03.ZmFxSpark20:setLeftRight( true, false, 122, 179.33 )
	self.PlanePart03.ZmFxSpark20:setTopBottom( true, false, 129.33, 186.66 )
	self.PlanePart03.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_engine" ) )
	self.PlanePart03:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.Plane.engine" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.PlanePart03, "Found", controller )
		end
	end )
	self:addElement( self.PlanePart03 )
	
	self.PlanePart04 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.PlanePart04:setLeftRight( true, false, 0, 1280 )
	self.PlanePart04:setTopBottom( true, false, 0, 720 )
	self.PlanePart04.ShieldIcon:setLeftRight( true, false, 172, 228 )
	self.PlanePart04.ShieldIcon:setTopBottom( true, false, 126.66, 182.66 )
	self.PlanePart04.ZmFxSpark20:setLeftRight( true, false, 172, 228 )
	self.PlanePart04.ZmFxSpark20:setTopBottom( true, false, 126.66, 182.66 )
	self.PlanePart04.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_valve" ) )
	self.PlanePart04:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.Plane.valves" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.PlanePart04, "Found", controller )
		end
	end )
	self:addElement( self.PlanePart04 )
	
	self.PlanePart05 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.PlanePart05:setLeftRight( true, false, 0, 1280 )
	self.PlanePart05:setTopBottom( true, false, 0, 720 )
	self.PlanePart05.ShieldIcon:setLeftRight( true, false, 222, 278 )
	self.PlanePart05.ShieldIcon:setTopBottom( true, false, 124.66, 180.66 )
	self.PlanePart05.ZmFxSpark20:setLeftRight( true, false, 222, 278 )
	self.PlanePart05.ZmFxSpark20:setTopBottom( true, false, 124.66, 180.66 )
	self.PlanePart05.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_rigging" ) )
	self.PlanePart05:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.Plane.rigging" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.PlanePart05, "Found", controller )
		end
	end )
	self:addElement( self.PlanePart05 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 6 )

				self.Background:completeAnimation()
				self.Background:setAlpha( 0 )
				self.clipFinished( self.Background, {} )

				self.PlanePart01:completeAnimation()
				self.PlanePart01:setAlpha( 0 )
				self.clipFinished( self.PlanePart01, {} )

				self.PlanePart02:completeAnimation()
				self.PlanePart02:setAlpha( 0 )
				self.clipFinished( self.PlanePart02, {} )

				self.PlanePart03:completeAnimation()
				self.PlanePart03:setAlpha( 0 )
				self.clipFinished( self.PlanePart03, {} )

				self.PlanePart04:completeAnimation()
				self.PlanePart04:setAlpha( 0 )
				self.clipFinished( self.PlanePart04, {} )

				self.PlanePart05:completeAnimation()
				self.PlanePart05:setAlpha( 0 )
				self.clipFinished( self.PlanePart05, {} )
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

				self.PlanePart01:completeAnimation()
				self.PlanePart01:setAlpha( 0 )
				NotificationPopupStart( self.PlanePart01, {} )

				self.PlanePart02:completeAnimation()
				self.PlanePart02:setAlpha( 0 )
				NotificationPopupStart( self.PlanePart02, {} )

				self.PlanePart03:completeAnimation()
				self.PlanePart03:setAlpha( 0 )
				NotificationPopupStart( self.PlanePart03, {} )

				self.PlanePart04:completeAnimation()
				self.PlanePart04:setAlpha( 0 )
				NotificationPopupStart( self.PlanePart04, {} )

				self.PlanePart05:completeAnimation()
				self.PlanePart05:setAlpha( 0 )
				NotificationPopupStart( self.PlanePart05, {} )
			end
		}
	}

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.PlaneQuest" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self, "NotificationPopup", controller )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.Background:close()
		element.PlanePart01:close()
		element.PlanePart02:close()
		element.PlanePart03:close()
		element.PlanePart04:close()
		element.PlanePart05:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end