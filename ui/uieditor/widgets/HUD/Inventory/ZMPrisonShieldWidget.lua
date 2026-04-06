require( "ui.uieditor.widgets.hud.Inventory.ZMPrisonShieldIcon" )

CoD.ZMPrisonShieldWidget = InheritFrom( LUI.UIElement )
CoD.ZMPrisonShieldWidget.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMPrisonShieldWidget )
	self.id = "ZMPrisonShieldWidget"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.Background = LUI.UIImage.new()
	self.Background:setLeftRight( true, false, -15, 244.66 )
	self.Background:setTopBottom( true, false, 137.33, 313.33 )
	self.Background:setImage( RegisterImage( "uie_t7_zm_prison_inventory_notif_background" ) )
	self:addElement( self.Background )
	
	self.ShieldPart01 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.ShieldPart01:setLeftRight( true, false, 0, 1280 )
	self.ShieldPart01:setTopBottom( true, false, 0, 720 )
	self.ShieldPart01.ShieldIcon:setLeftRight( true, false, 55, 106.33 )
	self.ShieldPart01.ShieldIcon:setTopBottom( true, false, 194, 245.33 )
	self.ShieldPart01.ZmFxSpark20:setLeftRight( true, false, 55, 106.33 )
	self.ShieldPart01.ZmFxSpark20:setTopBottom( true, false, 194, 245.33 )
	self.ShieldPart01.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_zshield_dolly" ) )
	self.ShieldPart01:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.ZombieShield.dolly" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.ShieldPart01, "Found", controller )
		end
	end )
	self:addElement( self.ShieldPart01 )
	
	self.ShieldPart02 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.ShieldPart02:setLeftRight( true, false, 0, 1280 )
	self.ShieldPart02:setTopBottom( true, false, 0, 720 )
	self.ShieldPart02.ShieldIcon:setLeftRight( true, false, 112.66, 166 )
	self.ShieldPart02.ShieldIcon:setTopBottom( true, false, 194, 247.33 )
	self.ShieldPart02.ZmFxSpark20:setLeftRight( true, false, 112.66, 166 )
	self.ShieldPart02.ZmFxSpark20:setTopBottom( true, false, 194, 247.33 )
	self.ShieldPart02.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_zshield_door" ) )
	self.ShieldPart02:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.ZombieShield.door" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.ShieldPart02, "Found", controller )
		end
	end )
	self:addElement( self.ShieldPart02 )
	
	self.ShieldPart03 = CoD.ZMPrisonShieldIcon.new( menu, controller )
	self.ShieldPart03:setLeftRight( true, false, 0, 1280 )
	self.ShieldPart03:setTopBottom( true, false, 0, 720 )
	self.ShieldPart03.ShieldIcon:setLeftRight( true, false, 167.33, 217.33 )
	self.ShieldPart03.ShieldIcon:setTopBottom( true, false, 196.66, 246.66 )
	self.ShieldPart03.ZmFxSpark20:setLeftRight( true, false, 167.33, 217.33 )
	self.ShieldPart03.ZmFxSpark20:setTopBottom( true, false, 196.66, 246.66 )
	self.ShieldPart03.ShieldIcon:setImage( RegisterImage( "uie_t7_zm_prison_inventory_zshield_shackles" ) )
	self.ShieldPart03:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.ZombieShield.shackles" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self.ShieldPart03, "Found", controller )
		end
	end )
	self:addElement( self.ShieldPart03 )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
				self:setupElementClipCounter( 4 )

				self.Background:completeAnimation()
				self.Background:setAlpha( 0 )
				self.clipFinished( self.Background, {} )

				self.ShieldPart01:completeAnimation()
				self.ShieldPart01:setAlpha( 0 )
				self.clipFinished( self.ShieldPart01, {} )

				self.ShieldPart02:completeAnimation()
				self.ShieldPart02:setAlpha( 0 )
				self.clipFinished( self.ShieldPart02, {} )

				self.ShieldPart03:completeAnimation()
				self.ShieldPart03:setAlpha( 0 )
				self.clipFinished( self.ShieldPart03, {} )
			end,

			NotificationPopup = function()
				self:setupElementClipCounter( 4 )

				local PopupFrame1 = function( element, event )
					local PopupFrame2 = function( element, event )
						local PopupFrame3 = function( element, event )
							local PopupFrame4 = function( element, event )
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
								PopupFrame4( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 2500, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", PopupFrame4 )
							end
						end

						if event.interrupted then
							PopupFrame3( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", PopupFrame3 )
						end
					end

					if event.interrupted then
						PopupFrame2( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0 )
						element:registerEventHandler( "transition_complete_keyframe", PopupFrame2 )
					end
				end
				
				self.Background:completeAnimation()
				self.Background:setAlpha( 0 )
				PopupFrame1( self.Background, {} )

				self.ShieldPart01:completeAnimation()
				self.ShieldPart01:setAlpha( 0 )
				PopupFrame1( self.ShieldPart01, {} )

				self.ShieldPart02:completeAnimation()
				self.ShieldPart02:setAlpha( 0 )
				PopupFrame1( self.ShieldPart02, {} )

				self.ShieldPart03:completeAnimation()
				self.ShieldPart03:setAlpha( 0 )
				PopupFrame1( self.ShieldPart03, {} )
			end
		}
	}

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "questItem.ZombieShield" ), function( model )
		if Engine.GetModelValue( model ) == 1 then
			PlayClip( self, "NotificationPopup", controller )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.Background:close()
		element.ShieldPart01:close()
		element.ShieldPart02:close()
		element.ShieldPart03:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end