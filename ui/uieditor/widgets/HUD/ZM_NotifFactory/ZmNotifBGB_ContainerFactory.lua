require("ui.uieditor.widgets.CPLevels.RamsesStation.WoundedSoldiers.woundedSoldier_Panel")
require("ui.uieditor.widgets.HUD.ZM_Notif.ZmNotif1_CursorHint")
require("ui.uieditor.widgets.HUD.ZM_NotifFactory.ZmNotif1Factory")
require("ui.uieditor.widgets.HUD.ZM_FX.ZmFx_Spark2")
require("ui.uieditor.widgets.HUD.ZM_AmmoWidgetFactory.ZmAmmo_ParticleFX")
require("ui.uieditor.widgets.ZMInventoryStalingrad.ZmNotif1_Notification_CursorHint")
require("ui.uieditor.widgets.ZMInventoryStalingrad.GameTimeWidget")

local PreLoadFunc = function( self, controller )
    local hudModel = Engine.GetModelForController( controller )
    local timeModel = Engine.CreateModel( hudModel, "hudItems.time" )
    Engine.CreateModel( timeModel, "round_complete_time" )
end

local PostLoadFunc = function( self, controller )
    self.notificationQueueEmptyModel = Engine.CreateModel( Engine.GetModelForController( controller ), "NotificationQueueEmpty" )
    self.notificationInProgress = false
    self.nextNotification = nil

    self.playNotification = function( element, data )
    	local controllerModel = Engine.GetModelForController( controller )
	    local hudIndexModel = Engine.GetModel( controllerModel, "SelectedHudIndex" )
	    local HudIndex = hudIndexModel and Engine.GetModelValue( hudIndexModel ) or 0
	    local playPowerupNotification = HudIndex == 0 or HudIndex == 2 or HudIndex == 5
	    local displayTitle = data.title

	    displayTitle = string.gsub( displayTitle, "NUKE%!", "Kaboom!" )
	    displayTitle = string.gsub( displayTitle, "CARPENTER%!", "Carpenter!" )
	    displayTitle = string.gsub( displayTitle, "FREE PERK%!", "Free Perk!" )
	    displayTitle = string.gsub( displayTitle, "BONUS POINTS%!", "Bonus Points!" )
	    
	    element.ZmNotif1CursorHint0.CursorHintText:setText( data.description )
	    element.ZmNotifFactory.Label1:setText( displayTitle )
	    element.ZmNotifFactory.Label2:setText( displayTitle )

        local currentClip = data.clip
        if currentClip == "TextandImageBGB" or currentClip == "TextandImageBGBToken" or currentClip == "TextandTimeAttack" then
            element.bgbTexture:setImage( data.bgbImage )
            element.bgbTextureLabel:setText( data.bgbImageText or "" )
            element.bgbTextureLabelBlur:setText( data.bgbImageText or "" )

            if currentClip == "TextandTimeAttack" then
                element.xpaward.Label1:setText( data.xpAward )
                element.xpaward.Label2:setText( data.xpAward )
                element.CursorHint.CursorHintText:setText( data.rewardText )
            end

        elseif not playPowerupNotification and currentClip == "TextandImageBasic" then
        	return
        end

        element:playClip( currentClip )
    end

    self.appendNotification = function( element, data )
	    local isQueueEmpty = Engine.GetModelValue( element.notificationQueueEmptyModel )
	    if element.notificationInProgress or not isQueueEmpty then
	        if element.nextNotification == nil then
	            element.nextNotification = LUI.ShallowCopy( data )
	        else
	            local lastNode = element.nextNotification
	            while lastNode.next do
	                lastNode = lastNode.next
	            end
	            lastNode.next = LUI.ShallowCopy( data )
	        end
	    else
	        element:playNotification( LUI.ShallowCopy( data ) )
	    end
	end

    LUI.OverrideFunction_CallOriginalSecond( self, "playClip", function( element )
        element.notificationInProgress = true
    end )

    self:registerEventHandler( "clip_over", function( element, event )
        element.notificationInProgress = false
        
        if element.nextNotification then
            element:playNotification( element.nextNotification )
            element.nextNotification = element.nextNotification.next
        end
    end )

    self:subscribeToModel( self.notificationQueueEmptyModel, function( model )
        if Engine.GetModelValue( model ) == true then
            self:processEvent( { name = "clip_over" } )
        end
    end )

    local timerPath = Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.time.round_complete_time" )
    self.Last5RoundTime.GameTimer:subscribeToModel( timerPath, function( model )
        local timeVal = Engine.GetModelValue( model )
        if timeVal then
            self.Last5RoundTime.GameTimer:setupServerTime( 0 - ( timeVal * 1000 ) )
        end
    end )

    self.UpdateColors = function( self )
	    local color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]
	    local elements = {
	    	self.bgbGlowOrangeOver,
	    	self.bgbAbilitySwirl,
			self.Flsh,
			self.ZmFxSpark20,
			self.ZmNotif1CursorHint0.CursorHintText,
			self.ZmNotifFactory.Label1,
			self.ZmNotifFactory.Label2,
			self.ZmNotifFactory.Glow,
			self.bgbTextureLabel,
			self.bgbTextureLabelBlur,
			self.xpaward.Label1,
			self.xpaward.Label2,
			self.CursorHint.CursorHintText,
			self.basicImageBacking,
			self.TimeAttack,
			self.Lightning,
			self.Lightning2,
			self.Lightning3,
			self.xpaward.Flckr,
			self.xpaward.Glow
		}
	    
	    for _, element in ipairs( elements ) do
	    	CoD.UIColors.SetElementColor( element, color )
	    end
	end

	local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
	self:subscribeToModel( colorUpdateModel, function( model )
	    self:UpdateColors()
	end )

	self:UpdateColors()
end

CoD.ZmNotifBGB_ContainerFactory = InheritFrom( LUI.UIElement )
CoD.ZmNotifBGB_ContainerFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmNotifBGB_ContainerFactory )
	self.id = "ZmNotifBGB_ContainerFactory"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 312 )
	self:setTopBottom( true, false, 0, 32 )
	self.anyChildUsesUpdateState = true
	
	self.Panel = CoD.woundedSoldier_Panel.new( menu, controller )
	self.Panel:setLeftRight( false, false, -156, 156 )
	self.Panel:setTopBottom( true, false, 3.67, 254.33 )
	self.Panel:setRGB( 0.84, 0.78, 0.72 )
	self.Panel:setAlpha( 0 )
	self.Panel:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "uie_scene_blur_pass_2" ) )
	self.Panel:setShaderVector( 0, 30, 0, 0, 0 )
	self.Panel.Image1:setShaderVector( 0, 10, 10, 0, 0 )
	self:addElement( self.Panel )
	
	self.basicImageBacking = LUI.UIImage.new()
	self.basicImageBacking:setLeftRight( false, false, -124, 124 )
	self.basicImageBacking:setTopBottom( true, false, 5, 253 )
	self.basicImageBacking:setAlpha( 0 )
	self.basicImageBacking:setImage( RegisterImage( "$blacktransparent" ) )
	self:addElement( self.basicImageBacking )
	
	self.TimeAttack = LUI.UIImage.new()
	self.TimeAttack:setLeftRight( true, false, 370, 498 )
	self.TimeAttack:setTopBottom( true, false, 92.5, 220.5 )
	self.TimeAttack:setAlpha( 0 )
	self.TimeAttack:setImage( RegisterImage( "uie_t7_icon_dlc3_time_attack" ) )
	self:addElement( self.TimeAttack )
	
	self.basicImage = LUI.UIImage.new()
	self.basicImage:setLeftRight( false, false, -123 + 45, 125 - 45 )
	self.basicImage:setTopBottom( true, false, 13 + 135, 221 - 41 )
	self.basicImage:setAlpha( 0 )
	self.basicImage:setImage( RegisterImage( "$black" ) )
	self.basicImage:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.basicImage:setShaderVector( 0, 0.2, 0.2, 0.2, 0.2 )
	self:addElement( self.basicImage )
	
	self.bgbGlowOrangeOver = LUI.UIImage.new()
	self.bgbGlowOrangeOver:setLeftRight( false, false, -103.18, 103.34 )
	self.bgbGlowOrangeOver:setTopBottom( false, false, -183.84, 124.17 )
	self.bgbGlowOrangeOver:setRGB( 0, 0.43, 1 )
	self.bgbGlowOrangeOver:setAlpha( 0 )
	self.bgbGlowOrangeOver:setZRot( 90 )
	self.bgbGlowOrangeOver:setImage( RegisterImage( "uie_t7_core_hud_mapwidget_panelglow" ) )
	self.bgbGlowOrangeOver:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.bgbGlowOrangeOver )
	
	self.bgbTexture = LUI.UIImage.new()
	self.bgbTexture:setLeftRight( false, false, -89.33, 90.67 )
	self.bgbTexture:setTopBottom( true, false, -3.5, 176.5 )
	self.bgbTexture:setAlpha( 0 )
	self.bgbTexture:setScale( 1.1 )
	self.bgbTexture:setImage( RegisterImage( "uie_t7_zm_hud_ammo_bbgumtexture" ) )
	self:addElement( self.bgbTexture )
	
	self.bgbTextureLabelBlur = LUI.UIText.new()
	self.bgbTextureLabelBlur:setLeftRight( false, false, -46.88, 40.22 )
	self.bgbTextureLabelBlur:setTopBottom( true, false, 63.5, 149.5 )
	self.bgbTextureLabelBlur:setRGB( 0.24, 0.11, 0.01 )
	self.bgbTextureLabelBlur:setAlpha( 0 )
	self.bgbTextureLabelBlur:setScale( 0.7 )
	self.bgbTextureLabelBlur:setText( Engine.Localize( "MP_X2" ) )
	self.bgbTextureLabelBlur:setTTF( "fonts/FoundryGridnik-Bold.ttf" )
	self.bgbTextureLabelBlur:setMaterial( LUI.UIImage.GetCachedMaterial( "sw4_2d_uie_font_cached_glow" ) )
	self.bgbTextureLabelBlur:setShaderVector( 0, 0.11, 0, 0, 0 )
	self.bgbTextureLabelBlur:setShaderVector( 1, 0.94, 0, 0, 0 )
	self.bgbTextureLabelBlur:setShaderVector( 2, 0, 0, 0, 0 )
	self.bgbTextureLabelBlur:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	self.bgbTextureLabelBlur:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self:addElement( self.bgbTextureLabelBlur )
	
	self.bgbTextureLabel = LUI.UIText.new()
	self.bgbTextureLabel:setLeftRight( false, false, -46.88, 40.22 )
	self.bgbTextureLabel:setTopBottom( true, false, 63.5, 149.5 )
	self.bgbTextureLabel:setRGB( 1, 0.89, 0.12 )
	self.bgbTextureLabel:setAlpha( 0 )
	self.bgbTextureLabel:setScale( 0.7 )
	self.bgbTextureLabel:setText( Engine.Localize( "MP_X2" ) )
	self.bgbTextureLabel:setTTF( "fonts/FoundryGridnik-Bold.ttf" )
	self.bgbTextureLabel:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	self.bgbTextureLabel:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self:addElement( self.bgbTextureLabel )
	
	self.bgbAbilitySwirl = LUI.UIImage.new()
	self.bgbAbilitySwirl:setLeftRight( false, false, -63.43, 75.43 )
	self.bgbAbilitySwirl:setTopBottom( true, false, 19.64, 156.5 )
	self.bgbAbilitySwirl:setRGB( 0, 0.39, 1 )
	self.bgbAbilitySwirl:setAlpha( 0 )
	self.bgbAbilitySwirl:setImage( RegisterImage( "uie_t7_core_hud_ammowidget_abilityswirl" ) )
	self.bgbAbilitySwirl:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.bgbAbilitySwirl )
	
	self.ZmNotif1CursorHint0 = CoD.ZmNotif1_CursorHint.new( menu, controller )
	self.ZmNotif1CursorHint0:setLeftRight( false, false, -256, 256 )
	self.ZmNotif1CursorHint0:setTopBottom( true, false, 197.5, 217.5 )
	self.ZmNotif1CursorHint0:setAlpha( 0 )
	self.ZmNotif1CursorHint0:setScale( 1.4 )
	self.ZmNotif1CursorHint0.FEButtonPanel0:setAlpha( 0.27 )
	self.ZmNotif1CursorHint0.CursorHintText:setText( Engine.Localize( "MENU_NEW" ) )
	self:addElement( self.ZmNotif1CursorHint0 )
	
	self.ZmNotifFactory = CoD.ZmNotif1Factory.new( menu, controller )
	self.ZmNotifFactory:setLeftRight( false, false, -112, 112 )
	self.ZmNotifFactory:setTopBottom( true, false, 138.5, 193.5 )
	self.ZmNotifFactory:setAlpha( 0 )
	self.ZmNotifFactory.Label2:setText( Engine.Localize( "MENU_NEW" ) )
	self.ZmNotifFactory.Label1:setText( Engine.Localize( "MENU_NEW" ) )
	self:addElement( self.ZmNotifFactory )
	
	self.Glow = LUI.UIImage.new()
	self.Glow:setLeftRight( false, false, -205, 205 )
	self.Glow:setTopBottom( true, false, 18.5, 258.5 )
	self.Glow:setAlpha( 0 )
	self.Glow:setImage( RegisterImage( "uie_t7_zm_hud_notif_glowfilm" ) )
	self.Glow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Glow )
	
	self.ZmFxSpark20 = CoD.ZmFx_Spark2.new( menu, controller )
	self.ZmFxSpark20:setLeftRight( false, false, -102, 101.34 )
	self.ZmFxSpark20:setTopBottom( true, false, 73.5, 225.5 )
	self.ZmFxSpark20:setRGB( 0, 0, 0 )
	self.ZmFxSpark20:setAlpha( 0 )
	self.ZmFxSpark20:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmFxSpark20.Image0:setShaderVector( 1, 0, 0.4, 0, 0 )
	self.ZmFxSpark20.Image00:setShaderVector( 1, 0, -0.2, 0, 0 )
	self:addElement( self.ZmFxSpark20 )
	
	self.Flsh = LUI.UIImage.new()
	self.Flsh:setLeftRight( false, false, -219.65, 219.34 )
	self.Flsh:setTopBottom( true, false, 146.25, 180.75 )
	self.Flsh:setRGB( 0.73, 0.35, 0 )
	self.Flsh:setAlpha( 0 )
	self.Flsh:setImage( RegisterImage( "uie_t7_zm_hud_notif_txtstreak" ) )
	self.Flsh:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Flsh )
	
	self.ZmAmmoParticleFX1left = CoD.ZmAmmo_ParticleFX.new( menu, controller )
	self.ZmAmmoParticleFX1left:setLeftRight( true, false, -17.74, 125.74 )
	self.ZmAmmoParticleFX1left:setTopBottom( true, false, 132.89, 207.5 )
	self.ZmAmmoParticleFX1left:setAlpha( 0 )
	self.ZmAmmoParticleFX1left:setXRot( 1 )
	self.ZmAmmoParticleFX1left:setYRot( 1 )
	self.ZmAmmoParticleFX1left:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmAmmoParticleFX1left.p2:setAlpha( 0 )
	self.ZmAmmoParticleFX1left.p3:setAlpha( 0 )
	self:addElement( self.ZmAmmoParticleFX1left )
	
	self.ZmAmmoParticleFX2left = CoD.ZmAmmo_ParticleFX.new( menu, controller )
	self.ZmAmmoParticleFX2left:setLeftRight( true, false, -17.74, 125.74 )
	self.ZmAmmoParticleFX2left:setTopBottom( true, false, 130.5, 205.11 )
	self.ZmAmmoParticleFX2left:setAlpha( 0 )
	self.ZmAmmoParticleFX2left:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmAmmoParticleFX2left.p1:setAlpha( 0 )
	self.ZmAmmoParticleFX2left.p3:setAlpha( 0 )
	self:addElement( self.ZmAmmoParticleFX2left )
	
	self.ZmAmmoParticleFX3left = CoD.ZmAmmo_ParticleFX.new( menu, controller )
	self.ZmAmmoParticleFX3left:setLeftRight( true, false, -17.74, 125.74 )
	self.ZmAmmoParticleFX3left:setTopBottom( true, false, 131.5, 206.11 )
	self.ZmAmmoParticleFX3left:setAlpha( 0 )
	self.ZmAmmoParticleFX3left:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmAmmoParticleFX3left.p1:setAlpha( 0 )
	self.ZmAmmoParticleFX3left.p2:setAlpha( 0 )
	self:addElement( self.ZmAmmoParticleFX3left )
	
	self.ZmAmmoParticleFX1right = CoD.ZmAmmo_ParticleFX.new( menu, controller )
	self.ZmAmmoParticleFX1right:setLeftRight( true, false, 204.52, 348 )
	self.ZmAmmoParticleFX1right:setTopBottom( true, false, 129, 203.6 )
	self.ZmAmmoParticleFX1right:setAlpha( 0 )
	self.ZmAmmoParticleFX1right:setXRot( 1 )
	self.ZmAmmoParticleFX1right:setYRot( 1 )
	self.ZmAmmoParticleFX1right:setZRot( 180 )
	self.ZmAmmoParticleFX1right:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmAmmoParticleFX1right.p2:setAlpha( 0 )
	self.ZmAmmoParticleFX1right.p3:setAlpha( 0 )
	self:addElement( self.ZmAmmoParticleFX1right )
	
	self.ZmAmmoParticleFX2right = CoD.ZmAmmo_ParticleFX.new( menu, controller )
	self.ZmAmmoParticleFX2right:setLeftRight( true, false, 204.52, 348 )
	self.ZmAmmoParticleFX2right:setTopBottom( true, false, 126.6, 201.21 )
	self.ZmAmmoParticleFX2right:setAlpha( 0 )
	self.ZmAmmoParticleFX2right:setZRot( 180 )
	self.ZmAmmoParticleFX2right:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmAmmoParticleFX2right.p1:setAlpha( 0 )
	self.ZmAmmoParticleFX2right.p3:setAlpha( 0 )
	self:addElement( self.ZmAmmoParticleFX2right )
	
	self.ZmAmmoParticleFX3right = CoD.ZmAmmo_ParticleFX.new( menu, controller )
	self.ZmAmmoParticleFX3right:setLeftRight( true, false, 204.52, 348 )
	self.ZmAmmoParticleFX3right:setTopBottom( true, false, 127.6, 202.21 )
	self.ZmAmmoParticleFX3right:setAlpha( 0 )
	self.ZmAmmoParticleFX3right:setZRot( 180 )
	self.ZmAmmoParticleFX3right:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.ZmAmmoParticleFX3right.p1:setAlpha( 0 )
	self.ZmAmmoParticleFX3right.p2:setAlpha( 0 )
	self:addElement( self.ZmAmmoParticleFX3right )
	
	self.Lightning = LUI.UIImage.new()
	self.Lightning:setLeftRight( true, false, 102, 192 )
	self.Lightning:setTopBottom( true, false, 33.21, 201.21 )
	self.Lightning:setAlpha( 0 )
	self.Lightning:setImage( RegisterImage( "uie_t7_zm_derriese_hud_notification_anim" ) )
	self.Lightning:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_flipbook" ) )
	self.Lightning:setShaderVector( 0, 28, 0, 0, 0 )
	self.Lightning:setShaderVector( 1, 30, 0, 0, 0 )
	self:addElement( self.Lightning )
	
	self.Lightning2 = LUI.UIImage.new()
	self.Lightning2:setLeftRight( true, false, 102, 192 )
	self.Lightning2:setTopBottom( true, false, 33.21, 201.21 )
	self.Lightning2:setAlpha( 0 )
	self.Lightning2:setImage( RegisterImage( "uie_t7_zm_derriese_hud_notification_anim" ) )
	self.Lightning2:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_flipbook" ) )
	self.Lightning2:setShaderVector( 0, 28, 0, 0, 0 )
	self.Lightning2:setShaderVector( 1, 30, 0, 0, 0 )
	self:addElement( self.Lightning2 )
	
	self.Lightning3 = LUI.UIImage.new()
	self.Lightning3:setLeftRight( true, false, 102, 192 )
	self.Lightning3:setTopBottom( true, false, 33.21, 201.21 )
	self.Lightning3:setAlpha( 0 )
	self.Lightning3:setImage( RegisterImage( "uie_t7_zm_derriese_hud_notification_anim" ) )
	self.Lightning3:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_flipbook" ) )
	self.Lightning3:setShaderVector( 0, 28, 0, 0, 0 )
	self.Lightning3:setShaderVector( 1, 30, 0, 0, 0 )
	self:addElement( self.Lightning3 )
	
	self.bgbTextureLabelBlur0 = LUI.UIText.new()
	self.bgbTextureLabelBlur0:setLeftRight( false, false, -46.88, 40.22 )
	self.bgbTextureLabelBlur0:setTopBottom( true, false, 63.5, 149.5 )
	self.bgbTextureLabelBlur0:setRGB( 0.24, 0.11, 0.01 )
	self.bgbTextureLabelBlur0:setAlpha( 0 )
	self.bgbTextureLabelBlur0:setScale( 0.7 )
	self.bgbTextureLabelBlur0:setText( Engine.Localize( "MP_X2" ) )
	self.bgbTextureLabelBlur0:setTTF( "fonts/FoundryGridnik-Bold.ttf" )
	self.bgbTextureLabelBlur0:setMaterial( LUI.UIImage.GetCachedMaterial( "sw4_2d_uie_font_cached_glow" ) )
	self.bgbTextureLabelBlur0:setShaderVector( 0, 0.11, 0, 0, 0 )
	self.bgbTextureLabelBlur0:setShaderVector( 1, 0.94, 0, 0, 0 )
	self.bgbTextureLabelBlur0:setShaderVector( 2, 0, 0, 0, 0 )
	self.bgbTextureLabelBlur0:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	self.bgbTextureLabelBlur0:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self:addElement( self.bgbTextureLabelBlur0 )
	
	self.bgbTextureLabel0 = LUI.UIText.new()
	self.bgbTextureLabel0:setLeftRight( false, false, -46.88, 40.22 )
	self.bgbTextureLabel0:setTopBottom( true, false, 63.5, 149.5 )
	self.bgbTextureLabel0:setRGB( 1, 0.89, 0.12 )
	self.bgbTextureLabel0:setAlpha( 0 )
	self.bgbTextureLabel0:setScale( 0.7 )
	self.bgbTextureLabel0:setText( Engine.Localize( "MP_X2" ) )
	self.bgbTextureLabel0:setTTF( "fonts/FoundryGridnik-Bold.ttf" )
	self.bgbTextureLabel0:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_RIGHT )
	self.bgbTextureLabel0:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_TOP )
	self:addElement( self.bgbTextureLabel0 )
	
	self.xpaward = CoD.ZmNotif1Factory.new( menu, controller )
	self.xpaward:setLeftRight( false, false, -112, 112 )
	self.xpaward:setTopBottom( true, false, 328.5, 383.5 )
	self.xpaward:setAlpha( 0 )
	self.xpaward.Label2:setText( Engine.Localize( "GROUPS_SEARCH_SIZE_RANGE_4" ) )
	self.xpaward.Label1:setText( Engine.Localize( "GROUPS_SEARCH_SIZE_RANGE_4" ) )
	self:addElement( self.xpaward )
	
	self.CursorHint = CoD.ZmNotif1_Notification_CursorHint.new( menu, controller )
	self.CursorHint:setLeftRight( true, false, -99, 413 )
	self.CursorHint:setTopBottom( true, false, 340, 372 )
	self.CursorHint:setAlpha( 0 )
	self.CursorHint.CursorHintText:setText( "" )
	self:addElement( self.CursorHint )
	
	self.Last5RoundTime = CoD.GameTimeWidget.new( menu, controller )
	self.Last5RoundTime:setLeftRight( true, false, 752, 880 )
	self.Last5RoundTime:setTopBottom( true, false, 0, 96 )
	self.Last5RoundTime:setAlpha( 0 )
	self.Last5RoundTime.TimeElasped:setText( Engine.Localize( "DLC3_TIME_CURRENT" ) )
	self.Last5RoundTime:mergeStateConditions( {
		{
			stateName = "Visible",
			condition = function ( menu, element, event )
				return IsZombies() and not IsModelValueEqualTo( controller, "hudItems.time.round_complete_time", 0 )
			end
		}
	} )
	self.Last5RoundTime:subscribeToModel( Engine.GetModel( Engine.GetGlobalModel(), "lobbyRoot.lobbyNav" ), function ( model )
		menu:updateElementState( self.Last5RoundTime, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "lobbyRoot.lobbyNav" } )
	end )
	self.Last5RoundTime:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.time.round_complete_time" ), function ( model )
		menu:updateElementState( self.Last5RoundTime, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.time.round_complete_time" } )
	end )
	self:addElement( self.Last5RoundTime )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 13 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.basicImageBacking:beginAnimation( "keyframe", 4369, false, false, CoD.TweenType.Linear )
				self.basicImageBacking:setAlpha( 0 )
				self.basicImageBacking:registerEventHandler( "transition_complete_keyframe", self.clipFinished )

				self.basicImage:beginAnimation( "keyframe", 4369, false, false, CoD.TweenType.Linear )
				self.basicImage:setAlpha( 0 )
				self.basicImage:registerEventHandler( "transition_complete_keyframe", self.clipFinished )

				self.bgbGlowOrangeOver:completeAnimation()
				self.bgbGlowOrangeOver:setAlpha( 0 )
				self.clipFinished( self.bgbGlowOrangeOver, {} )

				self.bgbTexture:completeAnimation()
				self.bgbTexture:setAlpha( 0 )
				self.clipFinished( self.bgbTexture, {} )

				self.bgbAbilitySwirl:completeAnimation()
				self.bgbAbilitySwirl:setAlpha( 0 )
				self.clipFinished( self.bgbAbilitySwirl, {} )

				self.ZmNotif1CursorHint0:completeAnimation()
				self.ZmNotif1CursorHint0:setAlpha( 0 )
				self.clipFinished( self.ZmNotif1CursorHint0, {} )

				self.ZmNotifFactory:completeAnimation()
				self.ZmNotifFactory:setAlpha( 0 )
				self.clipFinished( self.ZmNotifFactory, {} )

				self.Glow:completeAnimation()
				self.Glow:setAlpha( 0 )
				self.clipFinished( self.Glow, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setRGB( 0, 0, 0 )
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				self.Flsh:completeAnimation()
				CoD.UIColors.SetElementColor( self.Flsh, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.Flsh:setAlpha( 0 )
				self.clipFinished( self.Flsh, {} )

				self.CursorHint:beginAnimation( "keyframe", 3769, false, false, CoD.TweenType.Linear )
				self.CursorHint:setAlpha( 0 )
				self.CursorHint:registerEventHandler( "transition_complete_keyframe", self.clipFinished )

				self.Last5RoundTime:beginAnimation( "keyframe", 6780, false, false, CoD.TweenType.Linear )
				self.Last5RoundTime:setAlpha( 0 )
				self.Last5RoundTime:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
			end,

			TextandImageBGB = function ()
				self:setupElementClipCounter( 22 )

				local PanelFrame2 = function ( element, event )
					local PanelFrame3 = function ( element, event )
						local PanelFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 680, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							PanelFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2850, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", PanelFrame4 )
						end
					end
					
					if event.interrupted then
						PanelFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 560, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", PanelFrame3 )
					end
				end
				
				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				PanelFrame2( self.Panel, {} )

				self.basicImageBacking:completeAnimation()
				self.basicImageBacking:setAlpha( 0 )
				self.clipFinished( self.basicImageBacking, {} )

				self.basicImage:completeAnimation()
				self.basicImage:setAlpha( 0 )
				self.clipFinished( self.basicImage, {} )

				local bgbGlowOrangeOverFrame2 = function ( element, event )
					local bgbGlowOrangeOverFrame3 = function ( element, event )
						local bgbGlowOrangeOverFrame4 = function ( element, event )
							local bgbGlowOrangeOverFrame5 = function ( element, event )
								local bgbGlowOrangeOverFrame6 = function ( element, event )
									local bgbGlowOrangeOverFrame7 = function ( element, event )
										local bgbGlowOrangeOverFrame8 = function ( element, event )
											local bgbGlowOrangeOverFrame9 = function ( element, event )
												local bgbGlowOrangeOverFrame10 = function ( element, event )
													local bgbGlowOrangeOverFrame11 = function ( element, event )
														local bgbGlowOrangeOverFrame12 = function ( element, event )
															local bgbGlowOrangeOverFrame13 = function ( element, event )
																local bgbGlowOrangeOverFrame14 = function ( element, event )
																	if not event.interrupted then
																		element:beginAnimation( "keyframe", 720, true, false, CoD.TweenType.Bounce )
																	end
																	element:setAlpha( 0 )
																	if event.interrupted then
																		self.clipFinished( element, event )
																	else
																		element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
																	end
																end
																
																if event.interrupted then
																	bgbGlowOrangeOverFrame14( element, event )
																	return 
																else
																	element:beginAnimation( "keyframe", 109, false, false, CoD.TweenType.Linear )
																	element:setAlpha( 0.75 )
																	element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame14 )
																end
															end
															
															if event.interrupted then
																bgbGlowOrangeOverFrame13( element, event )
																return 
															else
																element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Linear )
																element:setAlpha( 1 )
																element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame13 )
															end
														end
														
														if event.interrupted then
															bgbGlowOrangeOverFrame12( element, event )
															return 
														else
															element:beginAnimation( "keyframe", 539, false, false, CoD.TweenType.Linear )
															element:setAlpha( 0.8 )
															element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame12 )
														end
													end
													
													if event.interrupted then
														bgbGlowOrangeOverFrame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														element:setAlpha( 0.36 )
														element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame11 )
													end
												end
												
												if event.interrupted then
													bgbGlowOrangeOverFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 519, false, false, CoD.TweenType.Linear )
													element:setAlpha( 0.8 )
													element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame10 )
												end
											end
											
											if event.interrupted then
												bgbGlowOrangeOverFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 579, false, false, CoD.TweenType.Linear )
												element:setAlpha( 0.36 )
												element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame9 )
											end
										end
										
										if event.interrupted then
											bgbGlowOrangeOverFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 480, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.8 )
											element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame8 )
										end
									end
									
									if event.interrupted then
										bgbGlowOrangeOverFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 340, false, false, CoD.TweenType.Linear )
										element:setAlpha( 0.33 )
										element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame7 )
									end
								end
								
								if event.interrupted then
									bgbGlowOrangeOverFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.75 )
									element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame6 )
								end
							end
							
							if event.interrupted then
								bgbGlowOrangeOverFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame5 )
							end
						end
						
						if event.interrupted then
							bgbGlowOrangeOverFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 159, true, false, CoD.TweenType.Bounce )
							element:setAlpha( 0.75 )
							element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame4 )
						end
					end
					
					if event.interrupted then
						bgbGlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame3 )
					end
				end
				
				self.bgbGlowOrangeOver:completeAnimation()
				self.bgbGlowOrangeOver:setAlpha( 0 )
				bgbGlowOrangeOverFrame2( self.bgbGlowOrangeOver, {} )

				local bgbTextureFrame2 = function ( element, event )
					local bgbTextureFrame3 = function ( element, event )
						local bgbTextureFrame4 = function ( element, event )
							local bgbTextureFrame5 = function ( element, event )
								local bgbTextureFrame6 = function ( element, event )
									local bgbTextureFrame7 = function ( element, event )
										local bgbTextureFrame8 = function ( element, event )
											local bgbTextureFrame9 = function ( element, event )
												if not event.interrupted then
													element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
												end
												element:setAlpha( 0 )
												element:setScale( 0.5 )
												if event.interrupted then
													self.clipFinished( element, event )
												else
													element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
												end
											end
											
											if event.interrupted then
												bgbTextureFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 340, false, false, CoD.TweenType.Linear )
												element:setAlpha( 0 )
												element:setScale( 0.57 )
												element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame9 )
											end
										end
										
										if event.interrupted then
											bgbTextureFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.77 )
											element:setScale( 1.2 )
											element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame8 )
										end
									end
									
									if event.interrupted then
										bgbTextureFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
										element:setScale( 0.82 )
										element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame7 )
									end
								end
								
								if event.interrupted then
									bgbTextureFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 3170, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame6 )
								end
							end
							
							if event.interrupted then
								bgbTextureFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 40, false, false, CoD.TweenType.Linear )
								element:setScale( 0.7 )
								element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame5 )
							end
						end
						
						if event.interrupted then
							bgbTextureFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 159, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:setScale( 1.2 )
							element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame4 )
						end
					end
					
					if event.interrupted then
						bgbTextureFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame3 )
					end
				end
				
				self.bgbTexture:completeAnimation()
				self.bgbTexture:setAlpha( 0 )
				self.bgbTexture:setScale( 0.5 )
				bgbTextureFrame2( self.bgbTexture, {} )

				local bgbAbilitySwirlFrame2 = function ( element, event )
					local bgbAbilitySwirlFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 139, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						element:setZRot( 360 )
						element:setScale( 1.7 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						bgbAbilitySwirlFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 280, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:setZRot( 240 )
						element:setScale( 1.7 )
						element:registerEventHandler( "transition_complete_keyframe", bgbAbilitySwirlFrame3 )
					end
				end
				
				self.bgbAbilitySwirl:completeAnimation()
				self.bgbAbilitySwirl:setAlpha( 0 )
				self.bgbAbilitySwirl:setZRot( 0 )
				self.bgbAbilitySwirl:setScale( 1 )
				bgbAbilitySwirlFrame2( self.bgbAbilitySwirl, {} )

				local ZmNotif1CursorHint0Frame2 = function ( element, event )
					local ZmNotif1CursorHint0Frame3 = function ( element, event )
						local ZmNotif1CursorHint0Frame4 = function ( element, event )
							local ZmNotif1CursorHint0Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 1069, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								ZmNotif1CursorHint0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 2849, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", ZmNotif1CursorHint0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmNotif1CursorHint0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 329, false, false, CoD.TweenType.Bounce )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", ZmNotif1CursorHint0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmNotif1CursorHint0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 119, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmNotif1CursorHint0Frame3 )
					end
				end
				
				self.ZmNotif1CursorHint0:completeAnimation()
				self.ZmNotif1CursorHint0:setAlpha( 0 )
				ZmNotif1CursorHint0Frame2( self.ZmNotif1CursorHint0, {} )

				local ZmNotifFactoryFrame2 = function ( element, event )
					local ZmNotifFactoryFrame3 = function ( element, event )
						local ZmNotifFactoryFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 869, false, false, CoD.TweenType.Bounce )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmNotifFactoryFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3240, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmNotifFactoryFrame4 )
						end
					end
					
					if event.interrupted then
						ZmNotifFactoryFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmNotifFactoryFrame3 )
					end
				end
				
				self.ZmNotifFactory:completeAnimation()
				self.ZmNotifFactory:setAlpha( 0 )
				ZmNotifFactoryFrame2( self.ZmNotifFactory, {} )

				local GlowFrame2 = function ( element, event )
					local GlowFrame3 = function ( element, event )
						local GlowFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 800, false, false, CoD.TweenType.Linear )
							end
							CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							GlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3359, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", GlowFrame4 )
						end
					end
					
					if event.interrupted then
						GlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowFrame3 )
					end
				end
				
				self.Glow:completeAnimation()
				CoD.UIColors.SetElementColor( self.Glow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.Glow:setAlpha( 0 )
				GlowFrame2( self.Glow, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				local FlshFrame2 = function ( element, event )
					local FlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 609, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( false, false, -219.65, 219.34 )
						element:setTopBottom( true, false, 146.25, 180.75 )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						FlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", FlshFrame3 )
					end
				end
				
				self.Flsh:completeAnimation()
				self.Flsh:setLeftRight( false, false, -219.65, 219.34 )
				self.Flsh:setTopBottom( true, false, 146.25, 180.75 )
				CoD.UIColors.SetElementColor( self.Flsh, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.Flsh:setAlpha( 0.36 )
				FlshFrame2( self.Flsh, {} )

				local ZmAmmoParticleFX1leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX1leftFrame3 = function ( element, event )
						local ZmAmmoParticleFX1leftFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX1leftFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1leftFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX1leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX1left:completeAnimation()
				self.ZmAmmoParticleFX1left:setAlpha( 0 )
				ZmAmmoParticleFX1leftFrame2( self.ZmAmmoParticleFX1left, {} )

				local ZmAmmoParticleFX2leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX2leftFrame3 = function ( element, event )
						local ZmAmmoParticleFX2leftFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX2leftFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2leftFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX2leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX2left:completeAnimation()
				self.ZmAmmoParticleFX2left:setAlpha( 0 )
				ZmAmmoParticleFX2leftFrame2( self.ZmAmmoParticleFX2left, {} )

				local ZmAmmoParticleFX3leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX3leftFrame3 = function ( element, event )
						local ZmAmmoParticleFX3leftFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX3leftFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3leftFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX3leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX3left:completeAnimation()
				self.ZmAmmoParticleFX3left:setAlpha( 0 )
				ZmAmmoParticleFX3leftFrame2( self.ZmAmmoParticleFX3left, {} )

				local ZmAmmoParticleFX1rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX1rightFrame3 = function ( element, event )
						local ZmAmmoParticleFX1rightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 204.52, 348 )
							element:setTopBottom( true, false, 129, 203.6 )
							element:setAlpha( 0 )
							element:setZRot( 180 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX1rightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1rightFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX1rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX1right:completeAnimation()
				self.ZmAmmoParticleFX1right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX1right:setTopBottom( true, false, 129, 203.6 )
				self.ZmAmmoParticleFX1right:setAlpha( 0 )
				self.ZmAmmoParticleFX1right:setZRot( 180 )
				ZmAmmoParticleFX1rightFrame2( self.ZmAmmoParticleFX1right, {} )

				local ZmAmmoParticleFX2rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX2rightFrame3 = function ( element, event )
						local ZmAmmoParticleFX2rightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 204.52, 348 )
							element:setTopBottom( true, false, 126.6, 201.21 )
							element:setAlpha( 0 )
							element:setZRot( 180 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX2rightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2rightFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX2rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX2right:completeAnimation()
				self.ZmAmmoParticleFX2right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX2right:setTopBottom( true, false, 126.6, 201.21 )
				self.ZmAmmoParticleFX2right:setAlpha( 0 )
				self.ZmAmmoParticleFX2right:setZRot( 180 )
				ZmAmmoParticleFX2rightFrame2( self.ZmAmmoParticleFX2right, {} )

				local ZmAmmoParticleFX3rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX3rightFrame3 = function ( element, event )
						local ZmAmmoParticleFX3rightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 204.52, 348 )
							element:setTopBottom( true, false, 127.6, 202.21 )
							element:setAlpha( 0 )
							element:setZRot( 180 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX3rightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0 )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3rightFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX3rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX3right:completeAnimation()
				self.ZmAmmoParticleFX3right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX3right:setTopBottom( true, false, 127.6, 202.21 )
				self.ZmAmmoParticleFX3right:setAlpha( 1 )
				self.ZmAmmoParticleFX3right:setZRot( 180 )
				ZmAmmoParticleFX3rightFrame2( self.ZmAmmoParticleFX3right, {} )

				local LightningFrame2 = function ( element, event )
					local LightningFrame3 = function ( element, event )
						local LightningFrame4 = function ( element, event )
							local LightningFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 679, false, false, CoD.TweenType.Linear )
								end
								element:setLeftRight( true, false, 38.67, 280 )
								element:setTopBottom( true, false, -22.5, 193.5 )
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								LightningFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 150, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", LightningFrame5 )
							end
						end
						
						if event.interrupted then
							LightningFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 109, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", LightningFrame4 )
						end
					end
					
					if event.interrupted then
						LightningFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", LightningFrame3 )
					end
				end
				
				self.Lightning:completeAnimation()
				self.Lightning:setLeftRight( true, false, 38.67, 280 )
				self.Lightning:setTopBottom( true, false, -22.5, 193.5 )
				self.Lightning:setAlpha( 0 )
				LightningFrame2( self.Lightning, {} )

				self.Lightning2:completeAnimation()
				self.Lightning2:setAlpha( 0 )
				self.clipFinished( self.Lightning2, {} )

				self.Lightning3:completeAnimation()
				self.Lightning3:setAlpha( 0 )
				self.clipFinished( self.Lightning3, {} )

				self.CursorHint:beginAnimation( "keyframe", 3769, false, false, CoD.TweenType.Linear )
				self.CursorHint:setAlpha( 0 )
				self.CursorHint:registerEventHandler( "transition_complete_keyframe", self.clipFinished )

				self.Last5RoundTime:completeAnimation()
				self.Last5RoundTime:setAlpha( 0 )
				self.clipFinished( self.Last5RoundTime, {} )
			end,

			TextandImageBGBToken = function ()
				self:setupElementClipCounter( 24 )

				local PanelFrame2 = function ( element, event )
					local PanelFrame3 = function ( element, event )
						local PanelFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 680, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							PanelFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2850, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", PanelFrame4 )
						end
					end
					
					if event.interrupted then
						PanelFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 560, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", PanelFrame3 )
					end
				end
				
				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				PanelFrame2( self.Panel, {} )

				self.basicImageBacking:completeAnimation()
				self.basicImageBacking:setAlpha( 0 )
				self.clipFinished( self.basicImageBacking, {} )

				self.basicImage:completeAnimation()
				self.basicImage:setAlpha( 0 )
				self.clipFinished( self.basicImage, {} )

				local bgbGlowOrangeOverFrame2 = function ( element, event )
					local bgbGlowOrangeOverFrame3 = function ( element, event )
						local bgbGlowOrangeOverFrame4 = function ( element, event )
							local bgbGlowOrangeOverFrame5 = function ( element, event )
								local bgbGlowOrangeOverFrame6 = function ( element, event )
									local bgbGlowOrangeOverFrame7 = function ( element, event )
										local bgbGlowOrangeOverFrame8 = function ( element, event )
											local bgbGlowOrangeOverFrame9 = function ( element, event )
												local bgbGlowOrangeOverFrame10 = function ( element, event )
													local bgbGlowOrangeOverFrame11 = function ( element, event )
														local bgbGlowOrangeOverFrame12 = function ( element, event )
															local bgbGlowOrangeOverFrame13 = function ( element, event )
																local bgbGlowOrangeOverFrame14 = function ( element, event )
																	if not event.interrupted then
																		element:beginAnimation( "keyframe", 720, true, false, CoD.TweenType.Bounce )
																	end
																	element:setAlpha( 0 )
																	if event.interrupted then
																		self.clipFinished( element, event )
																	else
																		element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
																	end
																end
																
																if event.interrupted then
																	bgbGlowOrangeOverFrame14( element, event )
																	return 
																else
																	element:beginAnimation( "keyframe", 109, false, false, CoD.TweenType.Linear )
																	element:setAlpha( 0.75 )
																	element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame14 )
																end
															end
															
															if event.interrupted then
																bgbGlowOrangeOverFrame13( element, event )
																return 
															else
																element:beginAnimation( "keyframe", 120, false, false, CoD.TweenType.Linear )
																element:setAlpha( 1 )
																element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame13 )
															end
														end
														
														if event.interrupted then
															bgbGlowOrangeOverFrame12( element, event )
															return 
														else
															element:beginAnimation( "keyframe", 539, false, false, CoD.TweenType.Linear )
															element:setAlpha( 0.8 )
															element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame12 )
														end
													end
													
													if event.interrupted then
														bgbGlowOrangeOverFrame11( element, event )
														return 
													else
														element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
														element:setAlpha( 0.36 )
														element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame11 )
													end
												end
												
												if event.interrupted then
													bgbGlowOrangeOverFrame10( element, event )
													return 
												else
													element:beginAnimation( "keyframe", 519, false, false, CoD.TweenType.Linear )
													element:setAlpha( 0.8 )
													element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame10 )
												end
											end
											
											if event.interrupted then
												bgbGlowOrangeOverFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 579, false, false, CoD.TweenType.Linear )
												element:setAlpha( 0.36 )
												element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame9 )
											end
										end
										
										if event.interrupted then
											bgbGlowOrangeOverFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 480, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.8 )
											element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame8 )
										end
									end
									
									if event.interrupted then
										bgbGlowOrangeOverFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 340, false, false, CoD.TweenType.Linear )
										element:setAlpha( 0.33 )
										element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame7 )
									end
								end
								
								if event.interrupted then
									bgbGlowOrangeOverFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
									element:setAlpha( 0.75 )
									element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame6 )
								end
							end
							
							if event.interrupted then
								bgbGlowOrangeOverFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 60, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame5 )
							end
						end
						
						if event.interrupted then
							bgbGlowOrangeOverFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 159, true, false, CoD.TweenType.Bounce )
							element:setAlpha( 0.75 )
							element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame4 )
						end
					end
					
					if event.interrupted then
						bgbGlowOrangeOverFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", bgbGlowOrangeOverFrame3 )
					end
				end
				
				self.bgbGlowOrangeOver:completeAnimation()
				self.bgbGlowOrangeOver:setAlpha( 0 )
				bgbGlowOrangeOverFrame2( self.bgbGlowOrangeOver, {} )

				local bgbTextureFrame2 = function ( element, event )
					local bgbTextureFrame3 = function ( element, event )
						local bgbTextureFrame4 = function ( element, event )
							local bgbTextureFrame5 = function ( element, event )
								local bgbTextureFrame6 = function ( element, event )
									local bgbTextureFrame7 = function ( element, event )
										local bgbTextureFrame8 = function ( element, event )
											local bgbTextureFrame9 = function ( element, event )
												if not event.interrupted then
													element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
												end
												element:setAlpha( 0 )
												element:setScale( 0.5 )
												if event.interrupted then
													self.clipFinished( element, event )
												else
													element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
												end
											end
											
											if event.interrupted then
												bgbTextureFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 340, false, false, CoD.TweenType.Linear )
												element:setAlpha( 0 )
												element:setScale( 0.57 )
												element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame9 )
											end
										end
										
										if event.interrupted then
											bgbTextureFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.77 )
											element:setScale( 1.2 )
											element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame8 )
										end
									end
									
									if event.interrupted then
										bgbTextureFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
										element:setScale( 0.82 )
										element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame7 )
									end
								end
								
								if event.interrupted then
									bgbTextureFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 3170, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame6 )
								end
							end
							
							if event.interrupted then
								bgbTextureFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 40, false, false, CoD.TweenType.Linear )
								element:setScale( 0.7 )
								element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame5 )
							end
						end
						
						if event.interrupted then
							bgbTextureFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 159, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:setScale( 1.2 )
							element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame4 )
						end
					end
					
					if event.interrupted then
						bgbTextureFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", bgbTextureFrame3 )
					end
				end
				
				self.bgbTexture:completeAnimation()
				self.bgbTexture:setAlpha( 0 )
				self.bgbTexture:setScale( 0.5 )
				bgbTextureFrame2( self.bgbTexture, {} )

				local bgbTextureLabelBlurFrame2 = function ( element, event )
					local bgbTextureLabelBlurFrame3 = function ( element, event )
						local bgbTextureLabelBlurFrame4 = function ( element, event )
							local bgbTextureLabelBlurFrame5 = function ( element, event )
								local bgbTextureLabelBlurFrame6 = function ( element, event )
									local bgbTextureLabelBlurFrame7 = function ( element, event )
										local bgbTextureLabelBlurFrame8 = function ( element, event )
											local bgbTextureLabelBlurFrame9 = function ( element, event )
												if not event.interrupted then
													element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
												end
												element:setAlpha( 0 )
												element:setScale( 0.5 )
												if event.interrupted then
													self.clipFinished( element, event )
												else
													element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
												end
											end
											
											if event.interrupted then
												bgbTextureLabelBlurFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 340, false, false, CoD.TweenType.Linear )
												element:setAlpha( 0 )
												element:setScale( 0.57 )
												element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelBlurFrame9 )
											end
										end
										
										if event.interrupted then
											bgbTextureLabelBlurFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.77 )
											element:setScale( 1.2 )
											element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelBlurFrame8 )
										end
									end
									
									if event.interrupted then
										bgbTextureLabelBlurFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
										element:setScale( 0.82 )
										element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelBlurFrame7 )
									end
								end
								
								if event.interrupted then
									bgbTextureLabelBlurFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 3170, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelBlurFrame6 )
								end
							end
							
							if event.interrupted then
								bgbTextureLabelBlurFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 40, false, false, CoD.TweenType.Linear )
								element:setScale( 0.7 )
								element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelBlurFrame5 )
							end
						end
						
						if event.interrupted then
							bgbTextureLabelBlurFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 159, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:setScale( 1.2 )
							element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelBlurFrame4 )
						end
					end
					
					if event.interrupted then
						bgbTextureLabelBlurFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelBlurFrame3 )
					end
				end
				
				self.bgbTextureLabelBlur:completeAnimation()
				self.bgbTextureLabelBlur:setAlpha( 0 )
				self.bgbTextureLabelBlur:setScale( 0.5 )
				bgbTextureLabelBlurFrame2( self.bgbTextureLabelBlur, {} )

				local bgbTextureLabelFrame2 = function ( element, event )
					local bgbTextureLabelFrame3 = function ( element, event )
						local bgbTextureLabelFrame4 = function ( element, event )
							local bgbTextureLabelFrame5 = function ( element, event )
								local bgbTextureLabelFrame6 = function ( element, event )
									local bgbTextureLabelFrame7 = function ( element, event )
										local bgbTextureLabelFrame8 = function ( element, event )
											local bgbTextureLabelFrame9 = function ( element, event )
												if not event.interrupted then
													element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
												end
												element:setAlpha( 0 )
												element:setScale( 0.5 )
												if event.interrupted then
													self.clipFinished( element, event )
												else
													element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
												end
											end
											
											if event.interrupted then
												bgbTextureLabelFrame9( element, event )
												return 
											else
												element:beginAnimation( "keyframe", 340, false, false, CoD.TweenType.Linear )
												element:setAlpha( 0 )
												element:setScale( 0.57 )
												element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelFrame9 )
											end
										end
										
										if event.interrupted then
											bgbTextureLabelFrame8( element, event )
											return 
										else
											element:beginAnimation( "keyframe", 99, false, false, CoD.TweenType.Linear )
											element:setAlpha( 0.77 )
											element:setScale( 1.2 )
											element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelFrame8 )
										end
									end
									
									if event.interrupted then
										bgbTextureLabelFrame7( element, event )
										return 
									else
										element:beginAnimation( "keyframe", 29, false, false, CoD.TweenType.Linear )
										element:setScale( 0.82 )
										element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelFrame7 )
									end
								end
								
								if event.interrupted then
									bgbTextureLabelFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 3170, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelFrame6 )
								end
							end
							
							if event.interrupted then
								bgbTextureLabelFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 40, false, false, CoD.TweenType.Linear )
								element:setScale( 0.7 )
								element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelFrame5 )
							end
						end
						
						if event.interrupted then
							bgbTextureLabelFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 159, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:setScale( 1.2 )
							element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelFrame4 )
						end
					end
					
					if event.interrupted then
						bgbTextureLabelFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", bgbTextureLabelFrame3 )
					end
				end
				
				self.bgbTextureLabel:completeAnimation()
				self.bgbTextureLabel:setAlpha( 0 )
				self.bgbTextureLabel:setScale( 0.5 )
				bgbTextureLabelFrame2( self.bgbTextureLabel, {} )

				local bgbAbilitySwirlFrame2 = function ( element, event )
					local bgbAbilitySwirlFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 139, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						element:setZRot( 360 )
						element:setScale( 1.7 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						bgbAbilitySwirlFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 280, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:setZRot( 240 )
						element:setScale( 1.7 )
						element:registerEventHandler( "transition_complete_keyframe", bgbAbilitySwirlFrame3 )
					end
				end
				
				self.bgbAbilitySwirl:completeAnimation()
				self.bgbAbilitySwirl:setAlpha( 0 )
				self.bgbAbilitySwirl:setZRot( 0 )
				self.bgbAbilitySwirl:setScale( 1 )
				bgbAbilitySwirlFrame2( self.bgbAbilitySwirl, {} )

				local ZmNotif1CursorHint0Frame2 = function ( element, event )
					local ZmNotif1CursorHint0Frame3 = function ( element, event )
						local ZmNotif1CursorHint0Frame4 = function ( element, event )
							local ZmNotif1CursorHint0Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 1069, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								ZmNotif1CursorHint0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 2849, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", ZmNotif1CursorHint0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmNotif1CursorHint0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 329, false, false, CoD.TweenType.Bounce )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", ZmNotif1CursorHint0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmNotif1CursorHint0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 119, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmNotif1CursorHint0Frame3 )
					end
				end
				
				self.ZmNotif1CursorHint0:completeAnimation()
				self.ZmNotif1CursorHint0:setAlpha( 0 )
				ZmNotif1CursorHint0Frame2( self.ZmNotif1CursorHint0, {} )

				local ZmNotifFactoryFrame2 = function ( element, event )
					local ZmNotifFactoryFrame3 = function ( element, event )
						local ZmNotifFactoryFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 869, false, false, CoD.TweenType.Bounce )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmNotifFactoryFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3240, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmNotifFactoryFrame4 )
						end
					end
					
					if event.interrupted then
						ZmNotifFactoryFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmNotifFactoryFrame3 )
					end
				end
				
				self.ZmNotifFactory:completeAnimation()
				self.ZmNotifFactory:setAlpha( 0 )
				ZmNotifFactoryFrame2( self.ZmNotifFactory, {} )

				local GlowFrame2 = function ( element, event )
					local GlowFrame3 = function ( element, event )
						local GlowFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 800, false, false, CoD.TweenType.Linear )
							end
							CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							GlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3359, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", GlowFrame4 )
						end
					end
					
					if event.interrupted then
						GlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowFrame3 )
					end
				end
				
				self.Glow:completeAnimation()
				CoD.UIColors.SetElementColor( self.Glow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.Glow:setAlpha( 0 )
				GlowFrame2( self.Glow, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				local FlshFrame2 = function ( element, event )
					local FlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 609, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( false, false, -219.65, 219.34 )
						element:setTopBottom( true, false, 146.25, 180.75 )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						FlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", FlshFrame3 )
					end
				end
				
				self.Flsh:completeAnimation()
				self.Flsh:setLeftRight( false, false, -219.65, 219.34 )
				self.Flsh:setTopBottom( true, false, 146.25, 180.75 )
				CoD.UIColors.SetElementColor( self.Flsh, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.Flsh:setAlpha( 0.36 )
				FlshFrame2( self.Flsh, {} )

				local ZmAmmoParticleFX1leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX1leftFrame3 = function ( element, event )
						local ZmAmmoParticleFX1leftFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX1leftFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1leftFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX1leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX1left:completeAnimation()
				self.ZmAmmoParticleFX1left:setAlpha( 0 )
				ZmAmmoParticleFX1leftFrame2( self.ZmAmmoParticleFX1left, {} )

				local ZmAmmoParticleFX2leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX2leftFrame3 = function ( element, event )
						local ZmAmmoParticleFX2leftFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX2leftFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2leftFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX2leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX2left:completeAnimation()
				self.ZmAmmoParticleFX2left:setAlpha( 0 )
				ZmAmmoParticleFX2leftFrame2( self.ZmAmmoParticleFX2left, {} )

				local ZmAmmoParticleFX3leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX3leftFrame3 = function ( element, event )
						local ZmAmmoParticleFX3leftFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX3leftFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3leftFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX3leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX3left:completeAnimation()
				self.ZmAmmoParticleFX3left:setAlpha( 0 )
				ZmAmmoParticleFX3leftFrame2( self.ZmAmmoParticleFX3left, {} )

				local ZmAmmoParticleFX1rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX1rightFrame3 = function ( element, event )
						local ZmAmmoParticleFX1rightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 204.52, 348 )
							element:setTopBottom( true, false, 129, 203.6 )
							element:setAlpha( 0 )
							element:setZRot( 180 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX1rightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1rightFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX1rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX1right:completeAnimation()
				self.ZmAmmoParticleFX1right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX1right:setTopBottom( true, false, 129, 203.6 )
				self.ZmAmmoParticleFX1right:setAlpha( 0 )
				self.ZmAmmoParticleFX1right:setZRot( 180 )
				ZmAmmoParticleFX1rightFrame2( self.ZmAmmoParticleFX1right, {} )

				local ZmAmmoParticleFX2rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX2rightFrame3 = function ( element, event )
						local ZmAmmoParticleFX2rightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 204.52, 348 )
							element:setTopBottom( true, false, 126.6, 201.21 )
							element:setAlpha( 0 )
							element:setZRot( 180 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX2rightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2rightFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX2rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX2right:completeAnimation()
				self.ZmAmmoParticleFX2right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX2right:setTopBottom( true, false, 126.6, 201.21 )
				self.ZmAmmoParticleFX2right:setAlpha( 0 )
				self.ZmAmmoParticleFX2right:setZRot( 180 )
				ZmAmmoParticleFX2rightFrame2( self.ZmAmmoParticleFX2right, {} )

				local ZmAmmoParticleFX3rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX3rightFrame3 = function ( element, event )
						local ZmAmmoParticleFX3rightFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 440, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 204.52, 348 )
							element:setTopBottom( true, false, 127.6, 202.21 )
							element:setAlpha( 0 )
							element:setZRot( 180 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmAmmoParticleFX3rightFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 3720, false, false, CoD.TweenType.Linear )
							element:setAlpha( 0 )
							element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3rightFrame4 )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX3rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 90, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX3right:completeAnimation()
				self.ZmAmmoParticleFX3right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX3right:setTopBottom( true, false, 127.6, 202.21 )
				self.ZmAmmoParticleFX3right:setAlpha( 0 )
				self.ZmAmmoParticleFX3right:setZRot( 180 )
				ZmAmmoParticleFX3rightFrame2( self.ZmAmmoParticleFX3right, {} )

				local LightningFrame2 = function ( element, event )
					local LightningFrame3 = function ( element, event )
						local LightningFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 679, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 38.67, 280 )
							element:setTopBottom( true, false, -22.5, 193.5 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							LightningFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 260, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", LightningFrame4 )
						end
					end
					
					if event.interrupted then
						LightningFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", LightningFrame3 )
					end
				end
				
				self.Lightning:completeAnimation()
				self.Lightning:setLeftRight( true, false, 38.67, 280 )
				self.Lightning:setTopBottom( true, false, -22.5, 193.5 )
				self.Lightning:setAlpha( 0 )
				LightningFrame2( self.Lightning, {} )

				self.Lightning2:completeAnimation()
				self.Lightning2:setAlpha( 0 )
				self.clipFinished( self.Lightning2, {} )

				self.Lightning3:completeAnimation()
				self.Lightning3:setAlpha( 0 )
				self.clipFinished( self.Lightning3, {} )

				self.CursorHint:beginAnimation( "keyframe", 3769, false, false, CoD.TweenType.Linear )
				self.CursorHint:setAlpha( 0 )
				self.CursorHint:registerEventHandler( "transition_complete_keyframe", self.clipFinished )

				self.Last5RoundTime:completeAnimation()
				self.Last5RoundTime:setAlpha( 0 )
				self.clipFinished( self.Last5RoundTime, {} )
			end,

			TextandImageBasic = function ()
				self:setupElementClipCounter( 23 )

				self.Panel:completeAnimation()
				self.Panel:setAlpha( 0 )
				self.clipFinished( self.Panel, {} )

				self.basicImageBacking:completeAnimation()
				self.basicImageBacking:setAlpha( 0 )
				self.basicImageBacking:setZRot( -10 )
				self.clipFinished( self.basicImageBacking, {} )

				self.TimeAttack:beginAnimation( "keyframe", 540, false, false, CoD.TweenType.Linear )
				self.TimeAttack:setAlpha( 0 )
				self.TimeAttack:registerEventHandler( "transition_complete_keyframe", self.clipFinished )

				local basicImageFrame2 = function ( element, event )
					local basicImageFrame3 = function ( element, event )
						local basicImageFrame4 = function ( element, event )
							local basicImageFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 679, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								basicImageFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 1970, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", basicImageFrame5 )
							end
						end
						
						if event.interrupted then
							basicImageFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 290, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", basicImageFrame4 )
						end
					end
					
					if event.interrupted then
						basicImageFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", basicImageFrame3 )
					end
				end
				
				self.basicImage:completeAnimation()
				self.basicImage:setAlpha( 0 )
				basicImageFrame2( self.basicImage, {} )

				self.bgbGlowOrangeOver:completeAnimation()
				self.bgbGlowOrangeOver:setAlpha( 0 )
				self.clipFinished( self.bgbGlowOrangeOver, {} )

				self.bgbTexture:completeAnimation()
				self.bgbTexture:setAlpha( 0 )
				self.clipFinished( self.bgbTexture, {} )

				self.bgbAbilitySwirl:completeAnimation()
				self.bgbAbilitySwirl:setAlpha( 0 )
				self.bgbAbilitySwirl:setZRot( 0 )
				self.bgbAbilitySwirl:setScale( 1 )
				self.clipFinished( self.bgbAbilitySwirl, {} )

				self.ZmNotif1CursorHint0:completeAnimation()
				self.ZmNotif1CursorHint0:setAlpha( 0 )
				self.clipFinished( self.ZmNotif1CursorHint0, {} )

				local ZmNotifFactoryFrame2 = function ( element, event )
					local ZmNotifFactoryFrame3 = function ( element, event )
						local ZmNotifFactoryFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 869, false, false, CoD.TweenType.Bounce )
							end
							element:setRGB( 1, 1, 1 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmNotifFactoryFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2240, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmNotifFactoryFrame4 )
						end
					end
					
					if event.interrupted then
						ZmNotifFactoryFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmNotifFactoryFrame3 )
					end
				end
				
				self.ZmNotifFactory:completeAnimation()
				self.ZmNotifFactory:setRGB( 1, 1, 1 )
				self.ZmNotifFactory:setAlpha( 0 )
				ZmNotifFactoryFrame2( self.ZmNotifFactory, {} )

				self.Glow:completeAnimation()
				CoD.UIColors.SetElementColor( self.Glow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.Glow:setAlpha( 0 )
				self.clipFinished( self.Glow, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				local FlshFrame2 = function ( element, event )
					local FlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 609, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( false, false, -219.65, 219.34 )
						element:setTopBottom( true, false, 146.25, 180.75 )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						FlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", FlshFrame3 )
					end
				end
				
				self.Flsh:completeAnimation()
				self.Flsh:setLeftRight( false, false, -219.65, 219.34 )
				self.Flsh:setTopBottom( true, false, 146.25, 180.75 )
				CoD.UIColors.SetElementColor( self.Flsh, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.Flsh:setAlpha( 0.36 )
				FlshFrame2( self.Flsh, {} )

				local ZmAmmoParticleFX1leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX1leftFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX1leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX1left:completeAnimation()
				self.ZmAmmoParticleFX1left:setAlpha( 1 )
				ZmAmmoParticleFX1leftFrame2( self.ZmAmmoParticleFX1left, {} )

				local ZmAmmoParticleFX2leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX2leftFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX2leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX2left:completeAnimation()
				self.ZmAmmoParticleFX2left:setAlpha( 1 )
				ZmAmmoParticleFX2leftFrame2( self.ZmAmmoParticleFX2left, {} )

				local ZmAmmoParticleFX3leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX3leftFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX3leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX3left:completeAnimation()
				self.ZmAmmoParticleFX3left:setAlpha( 1 )
				ZmAmmoParticleFX3leftFrame2( self.ZmAmmoParticleFX3left, {} )

				local ZmAmmoParticleFX1rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX1rightFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 204.52, 348 )
						element:setTopBottom( true, false, 129, 203.6 )
						element:setAlpha( 0 )
						element:setZRot( 180 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX1rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX1right:completeAnimation()
				self.ZmAmmoParticleFX1right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX1right:setTopBottom( true, false, 129, 203.6 )
				self.ZmAmmoParticleFX1right:setAlpha( 1 )
				self.ZmAmmoParticleFX1right:setZRot( 180 )
				ZmAmmoParticleFX1rightFrame2( self.ZmAmmoParticleFX1right, {} )

				local ZmAmmoParticleFX2rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX2rightFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 204.52, 348 )
						element:setTopBottom( true, false, 126.6, 201.21 )
						element:setAlpha( 0 )
						element:setZRot( 180 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX2rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX2right:completeAnimation()
				self.ZmAmmoParticleFX2right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX2right:setTopBottom( true, false, 126.6, 201.21 )
				self.ZmAmmoParticleFX2right:setAlpha( 1 )
				self.ZmAmmoParticleFX2right:setZRot( 180 )
				ZmAmmoParticleFX2rightFrame2( self.ZmAmmoParticleFX2right, {} )

				local ZmAmmoParticleFX3rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX3rightFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 204.52, 348 )
						element:setTopBottom( true, false, 127.6, 202.21 )
						element:setAlpha( 0 )
						element:setZRot( 180 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX3rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX3right:completeAnimation()
				self.ZmAmmoParticleFX3right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX3right:setTopBottom( true, false, 127.6, 202.21 )
				self.ZmAmmoParticleFX3right:setAlpha( 0 )
				self.ZmAmmoParticleFX3right:setZRot( 180 )
				ZmAmmoParticleFX3rightFrame2( self.ZmAmmoParticleFX3right, {} )

				self.Lightning:completeAnimation()
				self.Lightning:setLeftRight( true, false, 110.67, 200.67 )
				self.Lightning:setTopBottom( true, false, 8.5, 176.5 )
				self.Lightning:setAlpha( 0 )
				self.clipFinished( self.Lightning, {} )

				local Lightning2Frame2 = function ( element, event )
					local Lightning2Frame3 = function ( element, event )
						local Lightning2Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 35.74, 125.74 )
							element:setTopBottom( true, false, 62.25, 230.25 )
							element:setAlpha( 0 )
							element:setZRot( 40 )
							element:setScale( 0.7 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							Lightning2Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2360, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", Lightning2Frame4 )
						end
					end
					
					if event.interrupted then
						Lightning2Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", Lightning2Frame3 )
					end
				end
				
				self.Lightning2:completeAnimation()
				self.Lightning2:setLeftRight( true, false, 35.74, 125.74 )
				self.Lightning2:setTopBottom( true, false, 62.25, 230.25 )
				self.Lightning2:setAlpha( 0 )
				self.Lightning2:setZRot( 40 )
				self.Lightning2:setScale( 0.7 )
				Lightning2Frame2( self.Lightning2, {} )

				local Lightning3Frame2 = function ( element, event )
					local Lightning3Frame3 = function ( element, event )
						local Lightning3Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 186, 276 )
							element:setTopBottom( true, false, 60.5, 228.5 )
							element:setAlpha( 0 )
							element:setZRot( -40 )
							element:setScale( 0.7 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							Lightning3Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2360, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", Lightning3Frame4 )
						end
					end
					
					if event.interrupted then
						Lightning3Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", Lightning3Frame3 )
					end
				end
				
				self.Lightning3:completeAnimation()
				self.Lightning3:setLeftRight( true, false, 186, 276 )
				self.Lightning3:setTopBottom( true, false, 60.5, 228.5 )
				self.Lightning3:setAlpha( 0 )
				self.Lightning3:setZRot( -40 )
				self.Lightning3:setScale( 0.7 )
				Lightning3Frame2( self.Lightning3, {} )

				self.CursorHint:beginAnimation( "keyframe", 3769, false, false, CoD.TweenType.Linear )
				self.CursorHint:setAlpha( 0 )
				self.CursorHint:registerEventHandler( "transition_complete_keyframe", self.clipFinished )

				self.Last5RoundTime:completeAnimation()
				self.Last5RoundTime:setAlpha( 0 )
				self.clipFinished( self.Last5RoundTime, {} )
			end,

			TextandTimeAttack = function ()
				self:setupElementClipCounter( 24 )

				local PanelFrame2 = function ( element, event )
					local PanelFrame3 = function ( element, event )
						local PanelFrame4 = function ( element, event )
							local PanelFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 679, false, false, CoD.TweenType.Linear )
								end
								CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								PanelFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 1850, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", PanelFrame5 )
							end
						end
						
						if event.interrupted then
							PanelFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 110, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", PanelFrame4 )
						end
					end
					
					if event.interrupted then
						PanelFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 449, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.8 )
						element:registerEventHandler( "transition_complete_keyframe", PanelFrame3 )
					end
				end
				
				self.Panel:completeAnimation()
				CoD.UIColors.SetElementColor( self.Panel, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.Panel:setAlpha( 0 )
				PanelFrame2( self.Panel, {} )

				local basicImageBackingFrame2 = function ( element, event )
					local basicImageBackingFrame3 = function ( element, event )
						local basicImageBackingFrame4 = function ( element, event )
							local basicImageBackingFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 600, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								element:setZRot( 10 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								basicImageBackingFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 1879, false, false, CoD.TweenType.Linear )
								element:setZRot( 5.7 )
								element:registerEventHandler( "transition_complete_keyframe", basicImageBackingFrame5 )
							end
						end
						
						if event.interrupted then
							basicImageBackingFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 310, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:setZRot( -7.78 )
							element:registerEventHandler( "transition_complete_keyframe", basicImageBackingFrame4 )
						end
					end
					
					if event.interrupted then
						basicImageBackingFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", basicImageBackingFrame3 )
					end
				end
				
				self.basicImageBacking:completeAnimation()
				self.basicImageBacking:setAlpha( 0 )
				self.basicImageBacking:setZRot( -10 )
				basicImageBackingFrame2( self.basicImageBacking, {} )

				local TimeAttackFrame2 = function ( element, event )
					local TimeAttackFrame3 = function ( element, event )
						local TimeAttackFrame4 = function ( element, event )
							local TimeAttackFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 559, false, false, CoD.TweenType.Linear )
								end
								element:setLeftRight( true, false, 75.67, 237.67 )
								element:setTopBottom( true, false, 44, 206 )
								element:setAlpha( 0 )
								element:setScale( 0.8 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								TimeAttackFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 110, false, false, CoD.TweenType.Linear )
								element:setAlpha( 1 )
								element:registerEventHandler( "transition_complete_keyframe", TimeAttackFrame5 )
							end
						end
						
						if event.interrupted then
							TimeAttackFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 1839, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", TimeAttackFrame4 )
						end
					end
					
					if event.interrupted then
						TimeAttackFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 449, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.95 )
						element:registerEventHandler( "transition_complete_keyframe", TimeAttackFrame3 )
					end
				end
				
				self.TimeAttack:completeAnimation()
				self.TimeAttack:setLeftRight( true, false, 75.67, 237.67 )
				self.TimeAttack:setTopBottom( true, false, 44, 206 )
				self.TimeAttack:setAlpha( 0 )
				self.TimeAttack:setScale( 0.8 )
				TimeAttackFrame2( self.TimeAttack, {} )

				local basicImageFrame2 = function ( element, event )
					local basicImageFrame3 = function ( element, event )
						local basicImageFrame4 = function ( element, event )
							local basicImageFrame5 = function ( element, event )
								local basicImageFrame6 = function ( element, event )
									if not event.interrupted then
										element:beginAnimation( "keyframe", 679, false, true, CoD.TweenType.Linear )
									end
									element:setAlpha( 0 )
									if event.interrupted then
										self.clipFinished( element, event )
									else
										element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
									end
								end
								
								if event.interrupted then
									basicImageFrame6( element, event )
									return 
								else
									element:beginAnimation( "keyframe", 1630, false, false, CoD.TweenType.Linear )
									element:registerEventHandler( "transition_complete_keyframe", basicImageFrame6 )
								end
							end
							
							if event.interrupted then
								basicImageFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 339, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", basicImageFrame5 )
							end
						end
						
						if event.interrupted then
							basicImageFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 290, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", basicImageFrame4 )
						end
					end
					
					if event.interrupted then
						basicImageFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", basicImageFrame3 )
					end
				end
				
				self.basicImage:completeAnimation()
				self.basicImage:setAlpha( 0 )
				basicImageFrame2( self.basicImage, {} )

				self.bgbGlowOrangeOver:completeAnimation()
				self.bgbGlowOrangeOver:setAlpha( 0 )
				self.clipFinished( self.bgbGlowOrangeOver, {} )

				self.bgbTexture:completeAnimation()
				self.bgbTexture:setAlpha( 0 )
				self.clipFinished( self.bgbTexture, {} )

				self.bgbAbilitySwirl:completeAnimation()
				self.bgbAbilitySwirl:setAlpha( 0 )
				self.bgbAbilitySwirl:setZRot( 0 )
				self.bgbAbilitySwirl:setScale( 1 )
				self.clipFinished( self.bgbAbilitySwirl, {} )

				local ZmNotif1CursorHint0Frame2 = function ( element, event )
					local ZmNotif1CursorHint0Frame3 = function ( element, event )
						local ZmNotif1CursorHint0Frame4 = function ( element, event )
							local ZmNotif1CursorHint0Frame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 1069, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								ZmNotif1CursorHint0Frame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 1849, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", ZmNotif1CursorHint0Frame5 )
							end
						end
						
						if event.interrupted then
							ZmNotif1CursorHint0Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 329, false, false, CoD.TweenType.Bounce )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", ZmNotif1CursorHint0Frame4 )
						end
					end
					
					if event.interrupted then
						ZmNotif1CursorHint0Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 119, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmNotif1CursorHint0Frame3 )
					end
				end
				
				self.ZmNotif1CursorHint0:completeAnimation()
				self.ZmNotif1CursorHint0:setAlpha( 0 )
				ZmNotif1CursorHint0Frame2( self.ZmNotif1CursorHint0, {} )

				local ZmNotifFactoryFrame2 = function ( element, event )
					local ZmNotifFactoryFrame3 = function ( element, event )
						local ZmNotifFactoryFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 869, false, false, CoD.TweenType.Bounce )
							end
							element:setRGB( 1, 1, 1 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							ZmNotifFactoryFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2240, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", ZmNotifFactoryFrame4 )
						end
					end
					
					if event.interrupted then
						ZmNotifFactoryFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 259, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", ZmNotifFactoryFrame3 )
					end
				end
				
				self.ZmNotifFactory:completeAnimation()
				self.ZmNotifFactory:setRGB( 1, 1, 1 )
				self.ZmNotifFactory:setAlpha( 0 )
				ZmNotifFactoryFrame2( self.ZmNotifFactory, {} )

				local GlowFrame2 = function ( element, event )
					local GlowFrame3 = function ( element, event )
						local GlowFrame4 = function ( element, event )
							local GlowFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 799, false, false, CoD.TweenType.Linear )
								end
								CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								GlowFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 2049, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", GlowFrame5 )
							end
						end
						
						if event.interrupted then
							GlowFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 310, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", GlowFrame4 )
						end
					end
					
					if event.interrupted then
						GlowFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 140, false, false, CoD.TweenType.Bounce )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", GlowFrame3 )
					end
				end
				
				self.Glow:completeAnimation()
				CoD.UIColors.SetElementColor( self.Glow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.Glow:setAlpha( 0 )
				GlowFrame2( self.Glow, {} )

				self.ZmFxSpark20:completeAnimation()
				self.ZmFxSpark20:setAlpha( 0 )
				self.clipFinished( self.ZmFxSpark20, {} )

				local FlshFrame2 = function ( element, event )
					local FlshFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 609, false, false, CoD.TweenType.Bounce )
						end
						element:setLeftRight( false, false, -219.65, 219.34 )
						element:setTopBottom( true, false, 146.25, 180.75 )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						FlshFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 39, false, false, CoD.TweenType.Linear )
						CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", FlshFrame3 )
					end
				end
				
				self.Flsh:completeAnimation()
				self.Flsh:setLeftRight( false, false, -219.65, 219.34 )
				self.Flsh:setTopBottom( true, false, 146.25, 180.75 )
				CoD.UIColors.SetElementColor( self.Flsh, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
				self.Flsh:setAlpha( 0.36 )
				FlshFrame2( self.Flsh, {} )

				local ZmAmmoParticleFX1leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX1leftFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX1leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX1left:completeAnimation()
				self.ZmAmmoParticleFX1left:setAlpha( 1 )
				ZmAmmoParticleFX1leftFrame2( self.ZmAmmoParticleFX1left, {} )

				local ZmAmmoParticleFX2leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX2leftFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX2leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX2left:completeAnimation()
				self.ZmAmmoParticleFX2left:setAlpha( 1 )
				ZmAmmoParticleFX2leftFrame2( self.ZmAmmoParticleFX2left, {} )

				local ZmAmmoParticleFX3leftFrame2 = function ( element, event )
					local ZmAmmoParticleFX3leftFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX3leftFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3leftFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX3left:completeAnimation()
				self.ZmAmmoParticleFX3left:setAlpha( 1 )
				ZmAmmoParticleFX3leftFrame2( self.ZmAmmoParticleFX3left, {} )

				local ZmAmmoParticleFX1rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX1rightFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 204.52, 348 )
						element:setTopBottom( true, false, 129, 203.6 )
						element:setAlpha( 0 )
						element:setZRot( 180 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX1rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX1rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX1right:completeAnimation()
				self.ZmAmmoParticleFX1right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX1right:setTopBottom( true, false, 129, 203.6 )
				self.ZmAmmoParticleFX1right:setAlpha( 1 )
				self.ZmAmmoParticleFX1right:setZRot( 180 )
				ZmAmmoParticleFX1rightFrame2( self.ZmAmmoParticleFX1right, {} )

				local ZmAmmoParticleFX2rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX2rightFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 204.52, 348 )
						element:setTopBottom( true, false, 126.6, 201.21 )
						element:setAlpha( 0 )
						element:setZRot( 180 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX2rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX2rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX2right:completeAnimation()
				self.ZmAmmoParticleFX2right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX2right:setTopBottom( true, false, 126.6, 201.21 )
				self.ZmAmmoParticleFX2right:setAlpha( 1 )
				self.ZmAmmoParticleFX2right:setZRot( 180 )
				ZmAmmoParticleFX2rightFrame2( self.ZmAmmoParticleFX2right, {} )

				local ZmAmmoParticleFX3rightFrame2 = function ( element, event )
					local ZmAmmoParticleFX3rightFrame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
						end
						element:setLeftRight( true, false, 204.52, 348 )
						element:setTopBottom( true, false, 127.6, 202.21 )
						element:setAlpha( 0 )
						element:setZRot( 180 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						ZmAmmoParticleFX3rightFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2930, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", ZmAmmoParticleFX3rightFrame3 )
					end
				end
				
				self.ZmAmmoParticleFX3right:completeAnimation()
				self.ZmAmmoParticleFX3right:setLeftRight( true, false, 204.52, 348 )
				self.ZmAmmoParticleFX3right:setTopBottom( true, false, 127.6, 202.21 )
				self.ZmAmmoParticleFX3right:setAlpha( 0 )
				self.ZmAmmoParticleFX3right:setZRot( 180 )
				ZmAmmoParticleFX3rightFrame2( self.ZmAmmoParticleFX3right, {} )

				local LightningFrame2 = function ( element, event )
					local LightningFrame3 = function ( element, event )
						local LightningFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 110.67, 200.67 )
							element:setTopBottom( true, false, 8.5, 176.5 )
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							LightningFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2360, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", LightningFrame4 )
						end
					end
					
					if event.interrupted then
						LightningFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", LightningFrame3 )
					end
				end
				
				self.Lightning:completeAnimation()
				self.Lightning:setLeftRight( true, false, 110.67, 200.67 )
				self.Lightning:setTopBottom( true, false, 8.5, 176.5 )
				self.Lightning:setAlpha( 0 )
				LightningFrame2( self.Lightning, {} )

				local Lightning2Frame2 = function ( element, event )
					local Lightning2Frame3 = function ( element, event )
						local Lightning2Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 35.74, 125.74 )
							element:setTopBottom( true, false, 62.25, 230.25 )
							element:setAlpha( 0 )
							element:setZRot( 40 )
							element:setScale( 0.7 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							Lightning2Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2360, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", Lightning2Frame4 )
						end
					end
					
					if event.interrupted then
						Lightning2Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", Lightning2Frame3 )
					end
				end
				
				self.Lightning2:completeAnimation()
				self.Lightning2:setLeftRight( true, false, 35.74, 125.74 )
				self.Lightning2:setTopBottom( true, false, 62.25, 230.25 )
				self.Lightning2:setAlpha( 0 )
				self.Lightning2:setZRot( 40 )
				self.Lightning2:setScale( 0.7 )
				Lightning2Frame2( self.Lightning2, {} )

				local Lightning3Frame2 = function ( element, event )
					local Lightning3Frame3 = function ( element, event )
						local Lightning3Frame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
							end
							element:setLeftRight( true, false, 186, 276 )
							element:setTopBottom( true, false, 60.5, 228.5 )
							element:setAlpha( 0 )
							element:setZRot( -40 )
							element:setScale( 0.7 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							Lightning3Frame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 2360, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", Lightning3Frame4 )
						end
					end
					
					if event.interrupted then
						Lightning3Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", Lightning3Frame3 )
					end
				end
				
				self.Lightning3:completeAnimation()
				self.Lightning3:setLeftRight( true, false, 186, 276 )
				self.Lightning3:setTopBottom( true, false, 60.5, 228.5 )
				self.Lightning3:setAlpha( 0 )
				self.Lightning3:setZRot( -40 )
				self.Lightning3:setScale( 0.7 )
				Lightning3Frame2( self.Lightning3, {} )

				local xpawardFrame2 = function ( element, event )
					local xpawardFrame3 = function ( element, event )
						local xpawardFrame4 = function ( element, event )
							local xpawardFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
								end
								element:setLeftRight( false, false, -112, 112 )
								element:setTopBottom( true, false, 328.5, 383.5 )
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								xpawardFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 1590, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", xpawardFrame5 )
							end
						end
						
						if event.interrupted then
							xpawardFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 770, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", xpawardFrame4 )
						end
					end
					
					if event.interrupted then
						xpawardFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", xpawardFrame3 )
					end
				end
				
				self.xpaward:completeAnimation()
				self.xpaward:setLeftRight( false, false, -112, 112 )
				self.xpaward:setTopBottom( true, false, 328.5, 383.5 )
				self.xpaward:setAlpha( 0 )
				xpawardFrame2( self.xpaward, {} )

				local CursorHintFrame2 = function ( element, event )
					local CursorHintFrame3 = function ( element, event )
						local CursorHintFrame4 = function ( element, event )
							local CursorHintFrame5 = function ( element, event )
								if not event.interrupted then
									element:beginAnimation( "keyframe", 340, false, false, CoD.TweenType.Linear )
								end
								element:setAlpha( 0 )
								if event.interrupted then
									self.clipFinished( element, event )
								else
									element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
								end
							end
							
							if event.interrupted then
								CursorHintFrame5( element, event )
								return 
							else
								element:beginAnimation( "keyframe", 3349, false, false, CoD.TweenType.Linear )
								element:registerEventHandler( "transition_complete_keyframe", CursorHintFrame5 )
							end
						end
						
						if event.interrupted then
							CursorHintFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 439, false, false, CoD.TweenType.Linear )
							element:setAlpha( 1 )
							element:registerEventHandler( "transition_complete_keyframe", CursorHintFrame4 )
						end
					end
					
					if event.interrupted then
						CursorHintFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 2660, false, false, CoD.TweenType.Linear )
						element:registerEventHandler( "transition_complete_keyframe", CursorHintFrame3 )
					end
				end
				
				self.CursorHint:completeAnimation()
				self.CursorHint:setAlpha( 0 )
				CursorHintFrame2( self.CursorHint, {} )

				local Last5RoundTimeFrame2 = function ( element, event )
					local Last5RoundTimeFrame3 = function ( element, event )
						local Last5RoundTimeFrame4 = function ( element, event )
							if not event.interrupted then
								element:beginAnimation( "keyframe", 330, false, false, CoD.TweenType.Linear )
							end
							element:setAlpha( 0 )
							if event.interrupted then
								self.clipFinished( element, event )
							else
								element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
							end
						end
						
						if event.interrupted then
							Last5RoundTimeFrame4( element, event )
							return 
						else
							element:beginAnimation( "keyframe", 6149, false, false, CoD.TweenType.Linear )
							element:registerEventHandler( "transition_complete_keyframe", Last5RoundTimeFrame4 )
						end
					end
					
					if event.interrupted then
						Last5RoundTimeFrame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
						element:setAlpha( 1 )
						element:registerEventHandler( "transition_complete_keyframe", Last5RoundTimeFrame3 )
					end
				end
				
				self.Last5RoundTime:completeAnimation()
				self.Last5RoundTime:setAlpha( 0 )
				Last5RoundTimeFrame2( self.Last5RoundTime, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.Panel:close()
		element.ZmNotif1CursorHint0:close()
		element.ZmNotifFactory:close()
		element.ZmFxSpark20:close()
		element.ZmAmmoParticleFX1left:close()
		element.ZmAmmoParticleFX2left:close()
		element.ZmAmmoParticleFX3left:close()
		element.ZmAmmoParticleFX1right:close()
		element.ZmAmmoParticleFX2right:close()
		element.ZmAmmoParticleFX3right:close()
		element.xpaward:close()
		element.CursorHint:close()
		element.Last5RoundTime:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end