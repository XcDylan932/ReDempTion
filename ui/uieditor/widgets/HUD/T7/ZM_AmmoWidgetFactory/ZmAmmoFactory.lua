require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_PropFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_ClipInfoFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_EquipContainerFactory" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmoFactory_AttachmentInfo" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_BBGumMeterWidget" )

local PreLoadFunc = function ( self, controller )
	Engine.CreateModel( Engine.GetModelForController( controller ), "currentWeapon.aatIcon" )
end

local PostLoadFunc = function ( self, controller, menu )
	if not Engine.GetModelValue( Engine.CreateModel( Engine.GetModelForController( controller ), "currentWeapon.aatIcon" ) ) then
		self.AATIcon:setImage( RegisterImage( "blacktransparent" ) )
	end

	self.UpdateColors = function( self )
        local elements = { self.GlowMultiply, self.GlowBlueOverlay, self.GlowNotif, self.Flsh }
        for _, element in ipairs( elements ) do
            if element then
                element:completeAnimation()
                element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
                CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
            end
        end
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmoFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmoFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmoFactory )
	self.id = "ZmAmmoFactory"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 430 )
	self:setTopBottom( true, false, 0, 247 )
	self.anyChildUsesUpdateState = true
	
	self.GlowMultiply = LUI.UIImage.new()
	self.GlowMultiply:setLeftRight( true, false, 54, 515 )
	self.GlowMultiply:setTopBottom( true, false, 52.25, 215.75 )
	self.GlowMultiply:setRGB( 0.37, 0.41, 0.47 )
	self.GlowMultiply:setAlpha( 0.4 )
	self.GlowMultiply:setZRot( -4 )
	self.GlowMultiply:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.GlowMultiply:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_multiply" ) )
	self:addElement( self.GlowMultiply )
	
	self.ZmAmmoProp0 = CoD.ZmAmmo_PropFactory.new( menu, controller )
	self.ZmAmmoProp0:setLeftRight( true, false, 162.34, 395.65 )
	self.ZmAmmoProp0:setTopBottom( true, false, 62, 206 )
	self:addElement( self.ZmAmmoProp0 )

	self.GlowBlueOverlay = LUI.UIImage.new()
	self.GlowBlueOverlay:setLeftRight( true, false, 167.43, 338.42 )
	self.GlowBlueOverlay:setTopBottom( true, false, 69.38, 209.88 )
	self.GlowBlueOverlay:setRGB( 0, 0.59, 1 )
	self.GlowBlueOverlay:setAlpha( 0.23 )
	self.GlowBlueOverlay:setZRot( -4 )
	self.GlowBlueOverlay:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self:addElement( self.GlowBlueOverlay )
	
	self.ZmAmmoClipInfo0 = CoD.ZmAmmo_ClipInfoFactory.new( menu, controller )
	self.ZmAmmoClipInfo0:setLeftRight( true, false, 162.34, 297.34 )
	self.ZmAmmoClipInfo0:setTopBottom( true, false, 117.5, 174.5 )
	self.ZmAmmoClipInfo0:setYRot( -30 )
	self:addElement( self.ZmAmmoClipInfo0 )
	
	self.ZmAmmoEquipContainer0 = CoD.ZmAmmo_EquipContainerFactory.new( menu, controller )
	self.ZmAmmoEquipContainer0:setLeftRight( true, false, 220.35, 292.5 )
	self.ZmAmmoEquipContainer0:setTopBottom( true, false, 94.78, 146 )
	self.ZmAmmoEquipContainer0:setYRot( -30 )
	self.ZmAmmoEquipContainer0:mergeStateConditions( {
		{
			stateName = "OffsetLeft",
			condition = function ( menu, element, event )
				return IsAnyMapName( "zm_tomb", "zm_moon" )
			end
		}
	} )
	self:addElement( self.ZmAmmoEquipContainer0 )
	
	self.ZmAmmoAttachmentInfo0 = CoD.ZmAmmoFactory_AttachmentInfo.new( menu, controller )
	self.ZmAmmoAttachmentInfo0:setLeftRight( true, false, -40, 276 )
	self.ZmAmmoAttachmentInfo0:setTopBottom( true, false, 148, 186 )
	self.ZmAmmoAttachmentInfo0:setYRot( -40 )
	self:addElement( self.ZmAmmoAttachmentInfo0 )
	
	self.GlowNotif = LUI.UIImage.new()
	self.GlowNotif:setLeftRight( true, false, 14.35, 465.42 )
	self.GlowNotif:setTopBottom( true, false, -22.12, 238.12 )
	self.GlowNotif:setRGB( 0, 0.25, 1 )
	self.GlowNotif:setAlpha( 0 )
	self.GlowNotif:setImage( RegisterImage( "uie_t7_zm_hud_notif_glowfilm" ) )
	self.GlowNotif:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.GlowNotif )
	
	self.Flsh = LUI.UIImage.new()
	self.Flsh:setLeftRight( true, false, 14.35, 423.34 )
	self.Flsh:setTopBottom( true, false, 103.25, 176 )
	self.Flsh:setRGB( 0.05, 0, 0.62 )
	self.Flsh:setAlpha( 0 )
	self.Flsh:setImage( RegisterImage( "uie_t7_zm_hud_notif_txtstreak" ) )
	self.Flsh:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Flsh )
	
	self.ZmAmmoBBGumMeterWidget = CoD.ZmAmmo_BBGumMeterWidget.new( menu, controller )
	self.ZmAmmoBBGumMeterWidget:setLeftRight( true, false, 320, 373 )
	self.ZmAmmoBBGumMeterWidget:setTopBottom( true, false, 16, 69 )
	self.ZmAmmoBBGumMeterWidget:setScale( 1.4 )
	self:addElement( self.ZmAmmoBBGumMeterWidget )
	
	self.AATIcon = LUI.UIImage.new()
	self.AATIcon:setLeftRight( true, false, 277.34, 325.34 )
	self.AATIcon:setTopBottom( true, false, 193, 241 )
	self.AATIcon:setYRot( -40 )
	self.AATIcon:setScale( 0.7 )
	self.AATIcon:subscribeToGlobalModel( controller, "CurrentWeapon", "aatIcon", function ( model )
		local aatIcon = Engine.GetModelValue( model )
		if aatIcon then
			self.AATIcon:setImage( RegisterImage( aatIcon ) )
		end
	end )
	self:addElement( self.AATIcon )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.GlowMultiply:completeAnimation()
				self.GlowMultiply:setAlpha( 0 )
				self.clipFinished( self.GlowMultiply, {} )

				self.ZmAmmoProp0:completeAnimation()
				self.ZmAmmoProp0:setLeftRight( true, false, 164.69, 398 )
				self.ZmAmmoProp0:setTopBottom( true, false, 62, 206 )
				self.ZmAmmoProp0:setRGB( 0.65, 0.53, 0.43 )
				self.ZmAmmoProp0:setAlpha( 0 )
				self.clipFinished( self.ZmAmmoProp0, {} )

				self.GlowBlueOverlay:completeAnimation()
				self.GlowBlueOverlay:setAlpha( 0 )
				self.clipFinished( self.GlowBlueOverlay, {} )

				self.ZmAmmoClipInfo0:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:completeAnimation()
				self.ZmAmmoClipInfo0.TotalAmmo:completeAnimation()
				self.ZmAmmoClipInfo0.ClipDual:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:setAlpha( 0 )
				self.ZmAmmoClipInfo0.TotalAmmo:setAlpha( 0 )
				self.ZmAmmoClipInfo0.ClipDual:setAlpha( 0 )
				self.clipFinished( self.ZmAmmoClipInfo0, {} )

				self.ZmAmmoEquipContainer0:completeAnimation()
				self.ZmAmmoEquipContainer0:setAlpha( 0 )
				self.clipFinished( self.ZmAmmoEquipContainer0, {} )

				self.ZmAmmoAttachmentInfo0:completeAnimation()
				self.ZmAmmoAttachmentInfo0:setLeftRight( true, false, 0, 316 )
				self.ZmAmmoAttachmentInfo0:setTopBottom( true, false, 163, 201 )
				self.ZmAmmoAttachmentInfo0:setAlpha( 0 )
				self.clipFinished( self.ZmAmmoAttachmentInfo0, {} )

				self.GlowNotif:completeAnimation()
				self.GlowNotif:setAlpha( 0 )
				self.clipFinished( self.GlowNotif, {} )

				self.Flsh:completeAnimation()
				self.Flsh:setAlpha( 0 )
				self.clipFinished( self.Flsh, {} )

				self.ZmAmmoBBGumMeterWidget:completeAnimation()
				self.ZmAmmoBBGumMeterWidget:setAlpha( 0 )
				self.clipFinished( self.ZmAmmoBBGumMeterWidget, {} )

				self.AATIcon:completeAnimation()
				self.AATIcon:setAlpha( 0 )
				self.clipFinished( self.AATIcon, {} )
			end,

			HudStart = function ()
				self:setupElementClipCounter( 9 )

				local GlowMultiplyFrame2 = function ( element, event )
					local GlowMultiplyFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0.4 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						GlowMultiplyFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 449, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", GlowMultiplyFrame3 )
					end
				end
				
				self.GlowMultiply:completeAnimation()
				self.GlowMultiply:setAlpha( 0 )
				GlowMultiplyFrame2( self.GlowMultiply, {} )

				local ZmAmmoProp0Frame2 = function ( element, event )
					local ZmAmmoProp0Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 640, false, true, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 164.69, 398 )
						element:setTopBottom( true, false, 62, 206 )
						element:setRGB( 1, 1, 1 )
						element:setAlpha( 1 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoProp0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoProp0Frame3 )
					end
				end
				
				self.ZmAmmoProp0:completeAnimation()
				self.ZmAmmoProp0:setLeftRight( true, false, 196.69, 430 )
				self.ZmAmmoProp0:setTopBottom( true, false, 45.54, 189.54 )
				self.ZmAmmoProp0:setRGB( 0.28, 0.16, 0.05 )
				self.ZmAmmoProp0:setAlpha( 0 )
				self.ZmAmmoProp0:setZoom( -46 )
				ZmAmmoProp0Frame2( self.ZmAmmoProp0, {} )

				local ZmAmmoClipInfo0Frame2 = function ( element, event )
					local ZmAmmoClipInfo0Frame3 = function ( element, event )
						local ZmAmmoClipInfo0Frame4 = function ( element, event )
							local ZmAmmoClipInfo0Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 220, false, false, CoD.TweenType.Bounce )
									element.Clip:beginAnimation( "subkeyframe", 220, false, false, CoD.TweenType.Bounce )
									element.TotalAmmo:beginAnimation( "subkeyframe", 220, false, false, CoD.TweenType.Bounce )
									element.ClipDual:beginAnimation( "subkeyframe", 220, false, false, CoD.TweenType.Bounce )
								end
								element.Clip:setAlpha( 1 )
								element.TotalAmmo:setAlpha( 1 )
								element.ClipDual:setAlpha( 1 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end

							if event.interrupted then
								ZmAmmoClipInfo0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 240, false, false, CoD.TweenType.Bounce )
								element.TotalAmmo:beginAnimation( "subkeyframe", 240, false, false, CoD.TweenType.Bounce )
								element.TotalAmmo:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", ZmAmmoClipInfo0Frame5 )
							end
						end

						if event.interrupted then
							ZmAmmoClipInfo0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Bounce )
							element.Clip:beginAnimation( "subkeyframe", 259, false, false, CoD.TweenType.Bounce )
							element.Clip:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoClipInfo0Frame4 )
						end
					end

					if event.interrupted then
						ZmAmmoClipInfo0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 720, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoClipInfo0Frame3 )
					end
				end
				
				self.ZmAmmoClipInfo0:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:completeAnimation()
				self.ZmAmmoClipInfo0.TotalAmmo:completeAnimation()
				self.ZmAmmoClipInfo0.ClipDual:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:setAlpha( 0 )
				self.ZmAmmoClipInfo0.TotalAmmo:setAlpha( 0 )
				self.ZmAmmoClipInfo0.ClipDual:setAlpha( 0 )
				ZmAmmoClipInfo0Frame2( self.ZmAmmoClipInfo0, {} )

				local ZmAmmoEquipContainer0Frame2 = function ( element, event )
					local ZmAmmoEquipContainer0Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 230, false, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoEquipContainer0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1210, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoEquipContainer0Frame3 )
					end
				end
				
				self.ZmAmmoEquipContainer0:completeAnimation()
				self.ZmAmmoEquipContainer0:setAlpha( 0 )
				ZmAmmoEquipContainer0Frame2( self.ZmAmmoEquipContainer0, {} )

				local ZmAmmoAttachmentInfo0Frame2 = function ( element, event )
					local ZmAmmoAttachmentInfo0Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 199, false, true, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, -40, 276 )
						element:setTopBottom( true, false, 148, 186 )
						element:setAlpha( 1 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoAttachmentInfo0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1360, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 50, 366 )
						element:setTopBottom( true, false, 138, 176 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoAttachmentInfo0Frame3 )
					end
				end
				
				self.ZmAmmoAttachmentInfo0:completeAnimation()
				self.ZmAmmoAttachmentInfo0:setLeftRight( true, false, 40, 356 )
				self.ZmAmmoAttachmentInfo0:setTopBottom( true, false, 153, 191 )
				self.ZmAmmoAttachmentInfo0:setAlpha( 0 )
				self.ZmAmmoAttachmentInfo0:setZoom( -41 )
				ZmAmmoAttachmentInfo0Frame2( self.ZmAmmoAttachmentInfo0, {} )

				local GlowNotifFrame2 = function ( element, event )
					local GlowNotifFrame3 = function ( element, event )
						local GlowNotifFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 269, false, false, CoD.TweenType.Bounce )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							GlowNotifFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 70, false, false, CoD.TweenType.Bounce )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", GlowNotifFrame4 )
						end
					end

					if event.interrupted then
						GlowNotifFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", GlowNotifFrame3 )
					end
				end
				
				self.GlowNotif:completeAnimation()
				self.GlowNotif:setAlpha( 0 )
				GlowNotifFrame2( self.GlowNotif, {} )

				local FlshFrame2 = function ( element, event )
					local FlshFrame3 = function ( element, event )
						local FlshFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 299, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 14.35, 423.34 )
							element:setTopBottom( true, false, 103.25, 176 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							FlshFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 14.35, 423.34 )
							element:setTopBottom( true, false, 103.25, 176 )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", FlshFrame4 )
						end
					end

					if event.interrupted then
						FlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 939, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", FlshFrame3 )
					end
				end
				
				self.Flsh:completeAnimation()
				self.Flsh:setLeftRight( true, false, 223.01, 287 )
				self.Flsh:setTopBottom( true, false, 108, 171.5 )
				self.Flsh:setAlpha( 0 )
				FlshFrame2( self.Flsh, {} )

				local ZmAmmoBBGumMeterWidgetFrame2 = function ( element, event )
					local ZmAmmoBBGumMeterWidgetFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 269, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoBBGumMeterWidgetFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 870, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoBBGumMeterWidgetFrame3 )
					end
				end
				
				self.ZmAmmoBBGumMeterWidget:completeAnimation()
				self.ZmAmmoBBGumMeterWidget:setAlpha( 0 )
				ZmAmmoBBGumMeterWidgetFrame2( self.ZmAmmoBBGumMeterWidget, {} )

				local AATIconFrame2 = function ( element, event )
					local AATIconFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 240, true, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						AATIconFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1379, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", AATIconFrame3 )
					end
				end
				
				self.AATIcon:completeAnimation()
				self.AATIcon:setAlpha( 0 )
				AATIconFrame2( self.AATIcon, {} )
			end,

			HudStart_NoReserve = function ()
				self:setupElementClipCounter( 9 )

				local GlowMultiplyFrame2 = function ( element, event )
					local GlowMultiplyFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0.4 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						GlowMultiplyFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 449, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", GlowMultiplyFrame3 )
					end
				end
				
				self.GlowMultiply:completeAnimation()
				self.GlowMultiply:setAlpha( 0 )
				GlowMultiplyFrame2( self.GlowMultiply, {} )

				local ZmAmmoProp0Frame2 = function ( element, event )
					local ZmAmmoProp0Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 640, false, true, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 164.69, 398 )
						element:setTopBottom( true, false, 62, 206 )
						element:setRGB( 1, 1, 1 )
						element:setAlpha( 1 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoProp0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoProp0Frame3 )
					end
				end
				
				self.ZmAmmoProp0:completeAnimation()
				self.ZmAmmoProp0:setLeftRight( true, false, 196.69, 430 )
				self.ZmAmmoProp0:setTopBottom( true, false, 45.54, 189.54 )
				self.ZmAmmoProp0:setRGB( 0.28, 0.16, 0.05 )
				self.ZmAmmoProp0:setAlpha( 0 )
				self.ZmAmmoProp0:setZoom( -46 )
				ZmAmmoProp0Frame2( self.ZmAmmoProp0, {} )

				local ZmAmmoClipInfo0Frame2 = function ( element, event )
					local ZmAmmoClipInfo0Frame3 = function ( element, event )
						local ZmAmmoClipInfo0Frame4 = function ( element, event )
							local ZmAmmoClipInfo0Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 220, false, false, CoD.TweenType.Bounce )
									element.Clip:beginAnimation( "subkeyframe", 220, false, false, CoD.TweenType.Bounce )
									element.ClipDual:beginAnimation( "subkeyframe", 220, false, false, CoD.TweenType.Bounce )
								end
								element.Clip:setAlpha( 1 )
								element.ClipDual:setAlpha( 1 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end

							if event.interrupted then
								ZmAmmoClipInfo0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 240, false, false, CoD.TweenType.Bounce )
								element:registerEventHandler( "transition_complete_keyframe", ZmAmmoClipInfo0Frame5 )
							end
						end

						if event.interrupted then
							ZmAmmoClipInfo0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Bounce )
							element.Clip:beginAnimation( "subkeyframe", 259, false, false, CoD.TweenType.Bounce )
							element.Clip:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoClipInfo0Frame4 )
						end
					end

					if event.interrupted then
						ZmAmmoClipInfo0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 720, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoClipInfo0Frame3 )
					end
				end
				
				self.ZmAmmoClipInfo0:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:completeAnimation()
				self.ZmAmmoClipInfo0.ClipDual:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:setAlpha( 0 )
				self.ZmAmmoClipInfo0.ClipDual:setAlpha( 0 )
				ZmAmmoClipInfo0Frame2( self.ZmAmmoClipInfo0, {} )

				local ZmAmmoEquipContainer0Frame2 = function ( element, event )
					local ZmAmmoEquipContainer0Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 230, false, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoEquipContainer0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1210, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoEquipContainer0Frame3 )
					end
				end
				
				self.ZmAmmoEquipContainer0:completeAnimation()
				self.ZmAmmoEquipContainer0:setAlpha( 0 )
				ZmAmmoEquipContainer0Frame2( self.ZmAmmoEquipContainer0, {} )

				local ZmAmmoAttachmentInfo0Frame2 = function ( element, event )
					local ZmAmmoAttachmentInfo0Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 199, false, true, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, -40, 276 )
						element:setTopBottom( true, false, 148, 186 )
						element:setAlpha( 1 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoAttachmentInfo0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1360, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 50, 366 )
						element:setTopBottom( true, false, 138, 176 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoAttachmentInfo0Frame3 )
					end
				end
				
				self.ZmAmmoAttachmentInfo0:completeAnimation()
				self.ZmAmmoAttachmentInfo0:setLeftRight( true, false, 40, 356 )
				self.ZmAmmoAttachmentInfo0:setTopBottom( true, false, 153, 191 )
				self.ZmAmmoAttachmentInfo0:setAlpha( 0 )
				self.ZmAmmoAttachmentInfo0:setZoom( -41 )
				ZmAmmoAttachmentInfo0Frame2( self.ZmAmmoAttachmentInfo0, {} )

				local GlowNotifFrame2 = function ( element, event )
					local GlowNotifFrame3 = function ( element, event )
						local GlowNotifFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 269, false, false, CoD.TweenType.Bounce )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							GlowNotifFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 70, false, false, CoD.TweenType.Bounce )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", GlowNotifFrame4 )
						end
					end

					if event.interrupted then
						GlowNotifFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", GlowNotifFrame3 )
					end
				end
				
				self.GlowNotif:completeAnimation()
				self.GlowNotif:setAlpha( 0 )
				GlowNotifFrame2( self.GlowNotif, {} )

				local FlshFrame2 = function ( element, event )
					local FlshFrame3 = function ( element, event )
						local FlshFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 299, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 14.35, 423.34 )
							element:setTopBottom( true, false, 103.25, 176 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							FlshFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 14.35, 423.34 )
							element:setTopBottom( true, false, 103.25, 176 )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", FlshFrame4 )
						end
					end

					if event.interrupted then
						FlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 939, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", FlshFrame3 )
					end
				end
				
				self.Flsh:completeAnimation()
				self.Flsh:setLeftRight( true, false, 223.01, 287 )
				self.Flsh:setTopBottom( true, false, 108, 171.5 )
				self.Flsh:setAlpha( 0 )
				FlshFrame2( self.Flsh, {} )

				local ZmAmmoBBGumMeterWidgetFrame2 = function ( element, event )
					local ZmAmmoBBGumMeterWidgetFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 269, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoBBGumMeterWidgetFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 870, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoBBGumMeterWidgetFrame3 )
					end
				end
				
				self.ZmAmmoBBGumMeterWidget:completeAnimation()
				self.ZmAmmoBBGumMeterWidget:setAlpha( 0 )
				ZmAmmoBBGumMeterWidgetFrame2( self.ZmAmmoBBGumMeterWidget, {} )

				local AATIconFrame2 = function ( element, event )
					local AATIconFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 240, true, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						AATIconFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1379, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", AATIconFrame3 )
					end
				end
				
				self.AATIcon:completeAnimation()
				self.AATIcon:setAlpha( 0 )
				AATIconFrame2( self.AATIcon, {} )
			end,

			HudStart_NoAmmo = function ()
				self:setupElementClipCounter( 9 )

				local GlowMultiplyFrame2 = function ( element, event )
					local GlowMultiplyFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0.4 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						GlowMultiplyFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 449, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", GlowMultiplyFrame3 )
					end
				end
				
				self.GlowMultiply:completeAnimation()
				self.GlowMultiply:setAlpha( 0 )
				GlowMultiplyFrame2( self.GlowMultiply, {} )

				local ZmAmmoProp0Frame2 = function ( element, event )
					local ZmAmmoProp0Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 640, false, true, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 164.69, 398 )
						element:setTopBottom( true, false, 62, 206 )
						element:setRGB( 1, 1, 1 )
						element:setAlpha( 1 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoProp0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoProp0Frame3 )
					end
				end
				
				self.ZmAmmoProp0:completeAnimation()
				self.ZmAmmoProp0:setLeftRight( true, false, 196.69, 430 )
				self.ZmAmmoProp0:setTopBottom( true, false, 45.54, 189.54 )
				self.ZmAmmoProp0:setRGB( 0.28, 0.16, 0.05 )
				self.ZmAmmoProp0:setAlpha( 0 )
				self.ZmAmmoProp0:setZoom( -46 )
				ZmAmmoProp0Frame2( self.ZmAmmoProp0, {} )

				local ZmAmmoClipInfo0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Bounce )
					end
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoClipInfo0:beginAnimation( "keyframe", 720, false, false, CoD.TweenType.Linear )
				self.ZmAmmoClipInfo0:registerEventHandler( "transition_complete_keyframe", ZmAmmoClipInfo0Frame2 )

				local ZmAmmoEquipContainer0Frame2 = function ( element, event )
					local ZmAmmoEquipContainer0Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 230, false, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoEquipContainer0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1210, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoEquipContainer0Frame3 )
					end
				end
				
				self.ZmAmmoEquipContainer0:completeAnimation()
				self.ZmAmmoEquipContainer0:setAlpha( 0 )
				ZmAmmoEquipContainer0Frame2( self.ZmAmmoEquipContainer0, {} )

				local ZmAmmoAttachmentInfo0Frame2 = function ( element, event )
					local ZmAmmoAttachmentInfo0Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 199, false, true, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, -40, 276 )
						element:setTopBottom( true, false, 148, 186 )
						element:setAlpha( 1 )
						element:setZoom( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoAttachmentInfo0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1360, false, false, CoD.TweenType.Linear )
						element:setLeftRight( true, false, 50, 366 )
						element:setTopBottom( true, false, 138, 176 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoAttachmentInfo0Frame3 )
					end
				end
				
				self.ZmAmmoAttachmentInfo0:completeAnimation()
				self.ZmAmmoAttachmentInfo0:setLeftRight( true, false, 40, 356 )
				self.ZmAmmoAttachmentInfo0:setTopBottom( true, false, 153, 191 )
				self.ZmAmmoAttachmentInfo0:setAlpha( 0 )
				self.ZmAmmoAttachmentInfo0:setZoom( -41 )
				ZmAmmoAttachmentInfo0Frame2( self.ZmAmmoAttachmentInfo0, {} )

				local GlowNotifFrame2 = function ( element, event )
					local GlowNotifFrame3 = function ( element, event )
						local GlowNotifFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 269, false, false, CoD.TweenType.Bounce )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							GlowNotifFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 70, false, false, CoD.TweenType.Bounce )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", GlowNotifFrame4 )
						end
					end

					if event.interrupted then
						GlowNotifFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", GlowNotifFrame3 )
					end
				end
				
				self.GlowNotif:completeAnimation()
				self.GlowNotif:setAlpha( 0 )
				GlowNotifFrame2( self.GlowNotif, {} )

				local FlshFrame2 = function ( element, event )
					local FlshFrame3 = function ( element, event )
						local FlshFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 299, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 14.35, 423.34 )
							element:setTopBottom( true, false, 103.25, 176 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end

						if event.interrupted then
							FlshFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Linear )
							element:setLeftRight( true, false, 14.35, 423.34 )
							element:setTopBottom( true, false, 103.25, 176 )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", FlshFrame4 )
						end
					end

					if event.interrupted then
						FlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 939, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", FlshFrame3 )
					end
				end
				
				self.Flsh:completeAnimation()
				self.Flsh:setLeftRight( true, false, 223.01, 287 )
				self.Flsh:setTopBottom( true, false, 108, 171.5 )
				self.Flsh:setAlpha( 0 )
				FlshFrame2( self.Flsh, {} )

				local ZmAmmoBBGumMeterWidgetFrame2 = function ( element, event )
					local ZmAmmoBBGumMeterWidgetFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 269, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoBBGumMeterWidgetFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 870, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoBBGumMeterWidgetFrame3 )
					end
				end
				
				self.ZmAmmoBBGumMeterWidget:completeAnimation()
				self.ZmAmmoBBGumMeterWidget:setAlpha( 0 )
				ZmAmmoBBGumMeterWidgetFrame2( self.ZmAmmoBBGumMeterWidget, {} )

				local AATIconFrame2 = function ( element, event )
					local AATIconFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 240, true, false, CoD.TweenType.Bounce )
						end
						element:setAlpha( 1 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						AATIconFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 1379, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", AATIconFrame3 )
					end
				end
				
				self.AATIcon:completeAnimation()
				self.AATIcon:setAlpha( 0 )
				AATIconFrame2( self.AATIcon, {} )
			end
		},

		HudStart_NoAmmo = {
			DefaultClip = function ()
				self:setupElementClipCounter( 8 )

				self.GlowMultiply:completeAnimation()
				self.GlowMultiply:setAlpha( 0.4 )
				self.clipFinished( self.GlowMultiply, {} )

				self.ZmAmmoProp0:completeAnimation()
				self.ZmAmmoProp0:setLeftRight( true, false, 164.69, 398 )
				self.ZmAmmoProp0:setTopBottom( true, false, 62, 206 )
				self.ZmAmmoProp0:setRGB( 1, 1, 1 )
				self.ZmAmmoProp0:setAlpha( 1 )
				self.ZmAmmoProp0:setZoom( 0 )
				self.clipFinished( self.ZmAmmoProp0, {} )

				self.ZmAmmoEquipContainer0:completeAnimation()
				self.ZmAmmoEquipContainer0:setAlpha( 1 )
				self.clipFinished( self.ZmAmmoEquipContainer0, {} )

				self.ZmAmmoAttachmentInfo0:completeAnimation()
				self.ZmAmmoAttachmentInfo0:setLeftRight( true, false, -40, 276 )
				self.ZmAmmoAttachmentInfo0:setTopBottom( true, false, 148, 186 )
				self.ZmAmmoAttachmentInfo0:setAlpha( 1 )
				self.ZmAmmoAttachmentInfo0:setZoom( 0 )
				self.clipFinished( self.ZmAmmoAttachmentInfo0, {} )

				self.GlowNotif:completeAnimation()
				self.GlowNotif:setAlpha( 0 )
				self.clipFinished( self.GlowNotif, {} )

				self.Flsh:completeAnimation()
				self.Flsh:setAlpha( 0 )
				self.clipFinished( self.Flsh, {} )

				self.ZmAmmoBBGumMeterWidget:completeAnimation()
				self.ZmAmmoBBGumMeterWidget:setAlpha( 1 )
				self.clipFinished( self.ZmAmmoBBGumMeterWidget, {} )

				self.AATIcon:completeAnimation()
				self.AATIcon:setAlpha( 1 )
				self.clipFinished( self.AATIcon, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 8 )

				local GlowMultiplyFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 490, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.GlowMultiply:completeAnimation()
				self.GlowMultiply:setAlpha( 0.4 )
				GlowMultiplyFrame2( self.GlowMultiply, {} )

				local ZmAmmoProp0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 779, true, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 196.69, 430 )
					element:setTopBottom( true, false, 45.54, 189.54 )
					element:setRGB( 0.28, 0.16, 0.05 )
					element:setAlpha( 0 )
					element:setZoom( -46 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoProp0:completeAnimation()
				self.ZmAmmoProp0:setLeftRight( true, false, 164.69, 398 )
				self.ZmAmmoProp0:setTopBottom( true, false, 62, 206 )
				self.ZmAmmoProp0:setRGB( 1, 1, 1 )
				self.ZmAmmoProp0:setAlpha( 1 )
				self.ZmAmmoProp0:setZoom( 0 )
				ZmAmmoProp0Frame2( self.ZmAmmoProp0, {} )

				local GlowBlueOverlayFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 349, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.GlowBlueOverlay:completeAnimation()
				self.GlowBlueOverlay:setAlpha( 0.23 )
				GlowBlueOverlayFrame2( self.GlowBlueOverlay, {} )

				self.ZmAmmoClipInfo0:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
				self.ZmAmmoClipInfo0:registerEventHandler( "transition_complete_keyframe", self.clipFinished )

				local ZmAmmoEquipContainer0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 360, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoEquipContainer0:completeAnimation()
				self.ZmAmmoEquipContainer0:setAlpha( 1 )
				ZmAmmoEquipContainer0Frame2( self.ZmAmmoEquipContainer0, {} )

				local ZmAmmoAttachmentInfo0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 370, true, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 50, 366 )
					element:setTopBottom( true, false, 138, 176 )
					element:setAlpha( 0 )
					element:setZoom( -41 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoAttachmentInfo0:completeAnimation()
				self.ZmAmmoAttachmentInfo0:setLeftRight( true, false, -40, 276 )
				self.ZmAmmoAttachmentInfo0:setTopBottom( true, false, 148, 186 )
				self.ZmAmmoAttachmentInfo0:setAlpha( 1 )
				self.ZmAmmoAttachmentInfo0:setZoom( 0 )
				ZmAmmoAttachmentInfo0Frame2( self.ZmAmmoAttachmentInfo0, {} )

				local ZmAmmoBBGumMeterWidgetFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 810, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoBBGumMeterWidget:completeAnimation()
				self.ZmAmmoBBGumMeterWidget:setAlpha( 1 )
				ZmAmmoBBGumMeterWidgetFrame2( self.ZmAmmoBBGumMeterWidget, {} )

				local AATIconFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 360, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.AATIcon:completeAnimation()
				self.AATIcon:setAlpha( 1 )
				AATIconFrame2( self.AATIcon, {} )
			end
		},

		HudStart_NoReserve = {
			DefaultClip = function ()
				self:setupElementClipCounter( 9 )

				self.GlowMultiply:completeAnimation()
				self.GlowMultiply:setAlpha( 0.4 )
				self.clipFinished( self.GlowMultiply, {} )

				self.ZmAmmoProp0:completeAnimation()
				self.ZmAmmoProp0:setLeftRight( true, false, 164.69, 398 )
				self.ZmAmmoProp0:setTopBottom( true, false, 62, 206 )
				self.ZmAmmoProp0:setRGB( 1, 1, 1 )
				self.ZmAmmoProp0:setAlpha( 1 )
				self.ZmAmmoProp0:setZoom( 0 )
				self.clipFinished( self.ZmAmmoProp0, {} )

				self.ZmAmmoClipInfo0:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:completeAnimation()
				self.ZmAmmoClipInfo0.TotalAmmo:completeAnimation()
				self.ZmAmmoClipInfo0.ClipDual:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:setAlpha( 1 )
				self.ZmAmmoClipInfo0.TotalAmmo:setAlpha( 1 )
				self.ZmAmmoClipInfo0.ClipDual:setAlpha( 1 )
				self.clipFinished( self.ZmAmmoClipInfo0, {} )

				self.ZmAmmoEquipContainer0:completeAnimation()
				self.ZmAmmoEquipContainer0:setAlpha( 1 )
				self.clipFinished( self.ZmAmmoEquipContainer0, {} )

				self.ZmAmmoAttachmentInfo0:completeAnimation()
				self.ZmAmmoAttachmentInfo0:setLeftRight( true, false, -40, 276 )
				self.ZmAmmoAttachmentInfo0:setTopBottom( true, false, 148, 186 )
				self.ZmAmmoAttachmentInfo0:setAlpha( 1 )
				self.ZmAmmoAttachmentInfo0:setZoom( 0 )
				self.clipFinished( self.ZmAmmoAttachmentInfo0, {} )

				self.GlowNotif:completeAnimation()
				self.GlowNotif:setAlpha( 0 )
				self.clipFinished( self.GlowNotif, {} )

				self.Flsh:completeAnimation()
				self.Flsh:setAlpha( 0 )
				self.clipFinished( self.Flsh, {} )

				self.ZmAmmoBBGumMeterWidget:completeAnimation()
				self.ZmAmmoBBGumMeterWidget:setAlpha( 1 )
				self.clipFinished( self.ZmAmmoBBGumMeterWidget, {} )

				self.AATIcon:completeAnimation()
				self.AATIcon:setAlpha( 1 )
				self.clipFinished( self.AATIcon, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 8 )

				local GlowMultiplyFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 490, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.GlowMultiply:completeAnimation()
				self.GlowMultiply:setAlpha( 0.4 )
				GlowMultiplyFrame2( self.GlowMultiply, {} )

				local ZmAmmoProp0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 779, true, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 196.69, 430 )
					element:setTopBottom( true, false, 45.54, 189.54 )
					element:setRGB( 0.28, 0.16, 0.05 )
					element:setAlpha( 0 )
					element:setZoom( -46 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoProp0:completeAnimation()
				self.ZmAmmoProp0:setLeftRight( true, false, 164.69, 398 )
				self.ZmAmmoProp0:setTopBottom( true, false, 62, 206 )
				self.ZmAmmoProp0:setRGB( 1, 1, 1 )
				self.ZmAmmoProp0:setAlpha( 1 )
				self.ZmAmmoProp0:setZoom( 0 )
				ZmAmmoProp0Frame2( self.ZmAmmoProp0, {} )

				local GlowBlueOverlayFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 349, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.GlowBlueOverlay:completeAnimation()
				self.GlowBlueOverlay:setAlpha( 0.23 )
				GlowBlueOverlayFrame2( self.GlowBlueOverlay, {} )

				local ZmAmmoClipInfo0Frame2 = function ( element, event )
					local ZmAmmoClipInfo0Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Bounce )
							element.Clip:beginAnimation( "subkeyframe", 259, false, false, CoD.TweenType.Bounce )
							element.ClipDual:beginAnimation( "subkeyframe", 259, false, false, CoD.TweenType.Bounce )
						end
						element.Clip:setAlpha( 0 )
						element.ClipDual:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end

					if event.interrupted then
						ZmAmmoClipInfo0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
						element.Clip:beginAnimation( "subkeyframe", 79, false, false, CoD.TweenType.Linear )
						element.ClipDual:beginAnimation( "subkeyframe", 79, false, false, CoD.TweenType.Linear )
						element.Clip:setAlpha( 0 )
						element.ClipDual:setAlpha( 0.58 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoClipInfo0Frame3 )
					end
				end
				
				self.ZmAmmoClipInfo0:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:completeAnimation()
				self.ZmAmmoClipInfo0.ClipDual:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:setAlpha( 1 )
				self.ZmAmmoClipInfo0.ClipDual:setAlpha( 1 )
				ZmAmmoClipInfo0Frame2( self.ZmAmmoClipInfo0, {} )

				local ZmAmmoEquipContainer0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 360, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoEquipContainer0:completeAnimation()
				self.ZmAmmoEquipContainer0:setAlpha( 1 )
				ZmAmmoEquipContainer0Frame2( self.ZmAmmoEquipContainer0, {} )

				local ZmAmmoAttachmentInfo0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 370, true, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 50, 366 )
					element:setTopBottom( true, false, 138, 176 )
					element:setAlpha( 0 )
					element:setZoom( -41 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoAttachmentInfo0:completeAnimation()
				self.ZmAmmoAttachmentInfo0:setLeftRight( true, false, -40, 276 )
				self.ZmAmmoAttachmentInfo0:setTopBottom( true, false, 148, 186 )
				self.ZmAmmoAttachmentInfo0:setAlpha( 1 )
				self.ZmAmmoAttachmentInfo0:setZoom( 0 )
				ZmAmmoAttachmentInfo0Frame2( self.ZmAmmoAttachmentInfo0, {} )

				local ZmAmmoBBGumMeterWidgetFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 810, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoBBGumMeterWidget:completeAnimation()
				self.ZmAmmoBBGumMeterWidget:setAlpha( 1 )
				ZmAmmoBBGumMeterWidgetFrame2( self.ZmAmmoBBGumMeterWidget, {} )

				local AATIconFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 360, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.AATIcon:completeAnimation()
				self.AATIcon:setAlpha( 1 )
				AATIconFrame2( self.AATIcon, {} )
			end
		},

		HudStart = {
			DefaultClip = function ()
				self:setupElementClipCounter( 9 )

				self.GlowMultiply:completeAnimation()
				self.GlowMultiply:setAlpha( 0.4 )
				self.clipFinished( self.GlowMultiply, {} )

				self.ZmAmmoProp0:completeAnimation()
				self.ZmAmmoProp0:setLeftRight( true, false, 164.69, 398 )
				self.ZmAmmoProp0:setTopBottom( true, false, 62, 206 )
				self.ZmAmmoProp0:setRGB( 1, 1, 1 )
				self.ZmAmmoProp0:setAlpha( 1 )
				self.ZmAmmoProp0:setZoom( 0 )
				self.clipFinished( self.ZmAmmoProp0, {} )

				self.ZmAmmoClipInfo0:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:completeAnimation()
				self.ZmAmmoClipInfo0.TotalAmmo:completeAnimation()
				self.ZmAmmoClipInfo0.ClipDual:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:setAlpha( 1 )
				self.ZmAmmoClipInfo0.TotalAmmo:setAlpha( 1 )
				self.ZmAmmoClipInfo0.ClipDual:setAlpha( 1 )
				self.clipFinished( self.ZmAmmoClipInfo0, {} )

				self.ZmAmmoEquipContainer0:completeAnimation()
				self.ZmAmmoEquipContainer0:setAlpha( 1 )
				self.clipFinished( self.ZmAmmoEquipContainer0, {} )

				self.ZmAmmoAttachmentInfo0:completeAnimation()
				self.ZmAmmoAttachmentInfo0:setLeftRight( true, false, -40, 276 )
				self.ZmAmmoAttachmentInfo0:setTopBottom( true, false, 148, 186 )
				self.ZmAmmoAttachmentInfo0:setAlpha( 1 )
				self.ZmAmmoAttachmentInfo0:setZoom( 0 )
				self.clipFinished( self.ZmAmmoAttachmentInfo0, {} )

				self.GlowNotif:completeAnimation()
				self.GlowNotif:setAlpha( 0 )
				self.clipFinished( self.GlowNotif, {} )

				self.Flsh:completeAnimation()
				self.Flsh:setAlpha( 0 )
				self.clipFinished( self.Flsh, {} )

				self.ZmAmmoBBGumMeterWidget:completeAnimation()
				self.ZmAmmoBBGumMeterWidget:setAlpha( 1 )
				self.clipFinished( self.ZmAmmoBBGumMeterWidget, {} )

				self.AATIcon:completeAnimation()
				self.AATIcon:setAlpha( 1 )
				self.clipFinished( self.AATIcon, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 8 )

				local GlowMultiplyFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 490, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.GlowMultiply:completeAnimation()
				self.GlowMultiply:setAlpha( 0.4 )
				GlowMultiplyFrame2( self.GlowMultiply, {} )

				local ZmAmmoProp0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 779, true, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 196.69, 430 )
					element:setTopBottom( true, false, 45.54, 189.54 )
					element:setRGB( 0.28, 0.16, 0.05 )
					element:setAlpha( 0 )
					element:setZoom( -46 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoProp0:completeAnimation()
				self.ZmAmmoProp0:setLeftRight( true, false, 164.69, 398 )
				self.ZmAmmoProp0:setTopBottom( true, false, 62, 206 )
				self.ZmAmmoProp0:setRGB( 1, 1, 1 )
				self.ZmAmmoProp0:setAlpha( 1 )
				self.ZmAmmoProp0:setZoom( 0 )
				ZmAmmoProp0Frame2( self.ZmAmmoProp0, {} )

				local GlowBlueOverlayFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 349, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.GlowBlueOverlay:completeAnimation()
				self.GlowBlueOverlay:setAlpha( 0.23 )
				GlowBlueOverlayFrame2( self.GlowBlueOverlay, {} )

				local ZmAmmoClipInfo0Frame2 = function ( element, event )
					local ZmAmmoClipInfo0Frame3 = function ( element, event )
						local ZmAmmoClipInfo0Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Bounce )
								element.Clip:beginAnimation( "subkeyframe", 140, false, false, CoD.TweenType.Bounce )
								element.TotalAmmo:beginAnimation( "subkeyframe", 140, false, false, CoD.TweenType.Bounce )
								element.ClipDual:beginAnimation( "subkeyframe", 140, false, false, CoD.TweenType.Bounce )
							end
							element.Clip:setAlpha( 0 )
							element.TotalAmmo:setAlpha( 0 )
							element.ClipDual:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoClipInfo0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Bounce )
							element.TotalAmmo:beginAnimation( "subkeyframe", 120, false, false, CoD.TweenType.Bounce )
							element.ClipDual:beginAnimation( "subkeyframe", 120, false, false, CoD.TweenType.Bounce )
							element.TotalAmmo:setAlpha( 0 )
							element.ClipDual:setAlpha( 0.28 )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoClipInfo0Frame4 )
						end
					end

					if event.interrupted then
						ZmAmmoClipInfo0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 79, false, false, CoD.TweenType.Linear )
						element.Clip:beginAnimation( "subkeyframe", 79, false, false, CoD.TweenType.Linear )
						element.TotalAmmo:beginAnimation( "subkeyframe", 79, false, false, CoD.TweenType.Linear )
						element.ClipDual:beginAnimation( "subkeyframe", 79, false, false, CoD.TweenType.Linear )
						element.Clip:setAlpha( 0 )
						element.TotalAmmo:setAlpha( 0.11 )
						element.ClipDual:setAlpha( 0.58 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoClipInfo0Frame3 )
					end
				end
				
				self.ZmAmmoClipInfo0:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:completeAnimation()
				self.ZmAmmoClipInfo0.TotalAmmo:completeAnimation()
				self.ZmAmmoClipInfo0.ClipDual:completeAnimation()
				self.ZmAmmoClipInfo0.Clip:setAlpha( 1 )
				self.ZmAmmoClipInfo0.TotalAmmo:setAlpha( 1 )
				self.ZmAmmoClipInfo0.ClipDual:setAlpha( 1 )
				ZmAmmoClipInfo0Frame2( self.ZmAmmoClipInfo0, {} )

				local ZmAmmoEquipContainer0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 360, false, false, CoD.TweenType.Bounce )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoEquipContainer0:completeAnimation()
				self.ZmAmmoEquipContainer0:setAlpha( 1 )
				ZmAmmoEquipContainer0Frame2( self.ZmAmmoEquipContainer0, {} )

				local ZmAmmoAttachmentInfo0Frame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 370, true, false, CoD.TweenType.Linear )
					end
					element:setLeftRight( true, false, 50, 366 )
					element:setTopBottom( true, false, 138, 176 )
					element:setAlpha( 0 )
					element:setZoom( -41 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoAttachmentInfo0:completeAnimation()
				self.ZmAmmoAttachmentInfo0:setLeftRight( true, false, -40, 276 )
				self.ZmAmmoAttachmentInfo0:setTopBottom( true, false, 148, 186 )
				self.ZmAmmoAttachmentInfo0:setAlpha( 1 )
				self.ZmAmmoAttachmentInfo0:setZoom( 0 )
				ZmAmmoAttachmentInfo0Frame2( self.ZmAmmoAttachmentInfo0, {} )

				local ZmAmmoBBGumMeterWidgetFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 810, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.ZmAmmoBBGumMeterWidget:completeAnimation()
				self.ZmAmmoBBGumMeterWidget:setAlpha( 1 )
				ZmAmmoBBGumMeterWidgetFrame2( self.ZmAmmoBBGumMeterWidget, {} )

				local AATIconFrame2 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 360, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.AATIcon:completeAnimation()
				self.AATIcon:setAlpha( 1 )
				AATIconFrame2( self.AATIcon, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "HudStart_NoAmmo",
			condition = function ( menu, element, event )
				return not WeaponUsesAmmo( controller )
			end
		},
		{
			stateName = "HudStart_NoReserve",
			condition = function ( menu, element, event )
				return ModelValueStartsWith( controller, "currentWeapon.viewmodelWeaponName", "elemental_bow" )
			end
		},
		{
			stateName = "HudStart",
			condition = function ( menu, element, event )
				return true
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.weapon" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.weapon" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.equippedWeaponReference" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.equippedWeaponReference" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.viewmodelWeaponName" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.viewmodelWeaponName" } )
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.ZmAmmoProp0:close()
		element.ZmAmmoClipInfo0:close()
		element.ZmAmmoEquipContainer0:close()
		element.ZmAmmoAttachmentInfo0:close()
		element.ZmAmmoBBGumMeterWidget:close()
		element.AATIcon:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end