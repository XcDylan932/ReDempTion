require( "ui.uieditor.widgets.HUD.LuaPrint" )
require( "ui.uieditor.widgets.StartMenu.GumTracker.StartMenu_GumTracker" )

---------- T7 Widgets ----------
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmoContainerFactory" )
require( "ui.uieditor.widgets.HUD.ZM_RoundWidget.ZmRndContainer" )

---------- Soe Widgets ----------
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_PlayerLivesIndicator" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmoContainer" )

---------- T4 Widgets ----------
require( "ui.uieditor.widgets.HUD.T4.T4AmmoWidget.T4AmmoContainer" )
require( "ui.uieditor.widgets.HUD.T4.T4NotificationWidget.T4Notification" )
require( "ui.uieditor.widgets.HUD.T4.T4PerksWidget.T4PerksContainer" )
require( "ui.uieditor.widgets.HUD.T4.T4RoundWidget.T4RoundContainer" )
require( "ui.uieditor.widgets.HUD.T4.T4ScoreWidget.T4ScoreContainer" )
require( "ui.uieditor.widgets.HUD.T4.T4ScoreboardWidget.T4Scoreboard" )

---------- T6 Widgets ----------
require( "ui.uieditor.widgets.HUD.T6.T6AmmoWidget.T6AmmoContainer" )
require( "ui.uieditor.widgets.HUD.T6.T6PerksWidget.T6PerksContainer" )
require( "ui.uieditor.widgets.HUD.T6.T6RoundWidget.T6RoundContainer" )
require( "ui.uieditor.widgets.HUD.T6.T6ScoreWidget.T6ScoreContainer" )
require( "ui.uieditor.widgets.HUD.T6.T6ScoreboardWidget.T6Scoreboard" )

---------- T8 Widgets ----------
require( "ui.uieditor.widgets.HUD.T8.T8AmmoWidget.T8AmmoContainer" )
require( "ui.uieditor.widgets.HUD.T8.T8NotificationWidget.T8Notification" )
require( "ui.uieditor.widgets.HUD.T8.T8PerksWidget.T8PerksContainer" )
require( "ui.uieditor.widgets.HUD.T8.T8ScoreWidget.T8ScoreContainer" )
require( "ui.uieditor.widgets.HUD.T8.T8ScoreboardWidget.T8Scoreboard" )

---------- T10 Widgets ----------
require( "ui.uieditor.widgets.HUD.T10.T10AmmoWidget.T10AmmoContainer" )
require( "ui.uieditor.widgets.HUD.T10.T10NotificationWidget.T10Notification" )
require( "ui.uieditor.widgets.HUD.T10.T10PerksWidget.T10PerksContainer" )
require( "ui.uieditor.widgets.HUD.T10.T10PopupWidget.T10PopupScore" )
require( "ui.uieditor.widgets.HUD.T10.T10RoundWidget.T10RoundContainer" )
require( "ui.uieditor.widgets.HUD.T10.T10ScoreWidget.T10ScoreContainer" )
require( "ui.uieditor.widgets.HUD.T10.T10ScoreboardWidget.T10Scoreboard" )

---------- Kingslayer Powerups ----------
require( "ui.uieditor.widgets.HUD.KingslayerPowerupsWidget.KingslayerPowerupsContainer" )
require( "ui.uieditor.widgets.HUD.KingslayerPowerupsWidget.KingslayerPowerupsListItem" )

local hudIndicies = {
    ["zm_die"] = 2,
    --["zm_prison"] = 5,
    ["zm_town"] = 2,
    ["zm_zod"] = 5
}

local AddNotification = function( menu, notificationsList, notifyData )
    local data = CoD.GetScriptNotifyData( notifyData )
    local localizedTitle = Engine.Localize( data[1], data[2], data[3], data[4] )
    notificationsList:appendNotification( {
        clip = "TextandImageBasic",
        title = localizedTitle,
        description = ""
    } )
end

local PreLoadFunc = function( self, controller )
    local mapName = Engine.GetCurrentMap()
    local hudIndex = hudIndicies[ mapName ] or 0
    local controllerModel = Engine.GetModelForController( controller )
    local SelectedHudModel = Engine.GetModel( controllerModel, "SelectedHudIndex" )
    if not SelectedHudModel then
        SelectedHudModel = Engine.CreateModel( controllerModel, "SelectedHudIndex" )
    end
    Engine.SetModelValue( SelectedHudModel, hudIndex )
end

local PostLoadFunc = function( self, controller )
    local controllerModel = Engine.GetModelForController( controller )
    local colorUpdateModel = Engine.GetModel( controllerModel, "colorUpdate" )
    if not colorUpdateModel then
        colorUpdateModel = Engine.CreateModel( controllerModel, "colorUpdate" )
        Engine.SetModelValue( colorUpdateModel, 0 )
    end

    self:subscribeToModel( colorUpdateModel, function( model )
        local colorSettingsModel = Engine.GetModel( controllerModel, "colorSettings_UI" )
        local colorValue = Engine.GetModelValue( colorSettingsModel )
        
        if colorValue then
            CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] = colorValue

            if self.UpdateColors then
                self:UpdateColors()
            else
            end
        end
    end )

    self:subscribeToModel( Engine.GetModel( controllerModel, "SelectedHudIndex" ), function( model )
        local index = Engine.GetModelValue( model )
        local mapName = Engine.GetCurrentMap()

        if index then
            local isT7  = index == 0
            local isSoe = index == 5
            local isT4  = index == 1
            local isT6  = index == 2
            local isT8  = index == 3
            local isT10 = index == 4
            local isBo3 = isT7 or isSoe
            local isClassic = isT4 or isT6

            --[[local gumLeftRight = {
                [0] = { leftAnchor = false, rightAnchor = false, left = -184, right = 184 }
            }--]]

            local gumTopBottom = {
                [0] = { topAnchor = true, bottomAnchor = false, top = 36, bottom = 185 },
                [1] = { topAnchor = true, bottomAnchor = false, top = 236, bottom = 385 },
                [3] = { topAnchor = true, bottomAnchor = false, top = 236, bottom = 385 },
                [4] = { topAnchor = true, bottomAnchor = false, top = 36, bottom = 185 }
            }

            local afterlifeLeftRight = {
                [0] = { leftAnchor = true, rightAnchor = false, left = 40, right = 240 },
                [1] = { leftAnchor = true, rightAnchor = false, left = 65 + 20, right = 265 + 20 },
                [2] = { leftAnchor = true, rightAnchor = false, left = 65 + 40, right = 265 + 40 },
                [3] = { leftAnchor = true, rightAnchor = false, left = -10, right = 190 },
                [4] = { leftAnchor = true, rightAnchor = false, left = 15, right = 215 }
            }

            local afterlifeTopBottom = {
                [0] = { topAnchor = false, bottomAnchor = true, top = -25, bottom = 25 },
                [1] = { topAnchor = false, bottomAnchor = true, top = 50, bottom = 100 },
                [2] = { topAnchor = false, bottomAnchor = true, top = 50, bottom = 100 },
                [3] = { topAnchor = false, bottomAnchor = true, top = -25, bottom = 25 },
                [4] = { topAnchor = false, bottomAnchor = true, top = 0, bottom = 50 }
            }

            local beastmodeLeftRight = {
                [0] = { leftAnchor = true, rightAnchor = false, left = 196, right = 246 },
                [4] = { leftAnchor = true, rightAnchor = false, left = 196 - 100, right = 246 - 100 }
            }

            local beastmodeTopBottom = {
                [0] = { topAnchor = false, bottomAnchor = true, top = -146.25, bottom = -96.25 },
                [1] = { topAnchor = false, bottomAnchor = true, top = -146.25 + 70, bottom = -96.25 + 70 },
                [2] = { topAnchor = false, bottomAnchor = true, top = -146.25 + 70, bottom = -96.25 + 70 },
                [4] = { topAnchor = false, bottomAnchor = true, top = -146.25 + 20, bottom = -96.25 + 20 }
            }

            local SetElementVisibility = function( element, visible )
                if element then
                    element:setAlpha( visible and 1 or 0 )
                end
            end

            local UpdateGumPosition = function( element, hudIndex )
                if element then
                    --local lr = gumLeftRight[ hudIndex ] or gumLeftRight[0]
                    local tb = gumTopBottom[ hudIndex ] or gumTopBottom[0]

                    --element:setLeftRight( lr.leftAnchor, lr.rightAnchor, lr.left, lr.right )
                    element:setTopBottom( tb.topAnchor, tb.bottomAnchor, tb.top, tb.bottom )
                end
            end

            local UpdateAfterlifePosition = function( element, hudIndex )
                if element then
                    local lr = afterlifeLeftRight[ hudIndex ] or afterlifeLeftRight[0]
                    local tb = afterlifeTopBottom[ hudIndex ] or afterlifeTopBottom[0]

                    element:setLeftRight( lr.leftAnchor, lr.rightAnchor, lr.left, lr.right )
                    element:setTopBottom( tb.topAnchor, tb.bottomAnchor, tb.top, tb.bottom )
                end
            end

            local UpdateBeastmodePosition = function( element, hudIndex )
                if element then
                    local lr = beastmodeLeftRight[ hudIndex ] or beastmodeLeftRight[0]
                    local tb = beastmodeTopBottom[ hudIndex ] or beastmodeTopBottom[0]

                    element:setLeftRight( lr.leftAnchor, lr.rightAnchor, lr.left, lr.right )
                    element:setTopBottom( tb.topAnchor, tb.bottomAnchor, tb.top, tb.bottom )
                end
            end

            UpdateGumPosition( self.BubbleGumPackInGame, index )
            UpdateAfterlifePosition( self.AfterlifeWidget, index )
            UpdateBeastmodePosition( self.PlayerLivesIndicator, index )

            ---------- SOE Visibility ----------
            SetElementVisibility( self.ZodAmmo, isSoe )
            SetElementVisibility( self.PlayerLivesIndicator, mapName == "zm_zod" or ( isSoe and mapName ~= "zm_prison" ) )
            SetElementVisibility( self.ZmAmmoPlayerLivesIndicator, false )
            SetElementVisibility( self.ZmAmmoPlayerLivesIndicator0, false )
            
            ---------- T7 Visibility ----------
            SetElementVisibility( self.ZMPerksContainerFactory, isBo3 )
            SetElementVisibility( self.ZMPerksContainer, isBo3 )
            SetElementVisibility( self.Rounds, isBo3 )
            SetElementVisibility( self.Ammo, false )
            SetElementVisibility( self.T7Ammo, isT7 )
            SetElementVisibility( self.Score, isBo3 )
            --SetElementVisibility( self.fullscreenContainer, isT7 )
            SetElementVisibility( self.Notifications, true )
            SetElementVisibility( self.ZmNotifBGBContainerFactory, true )
            --SetElementVisibility( self.CursorHint, isT7 )
            --SetElementVisibility( self.ConsoleCenter, isT7 )
            --SetElementVisibility( self.DeadSpectate, isT7 )
            SetElementVisibility( self.MPScore, false )
            --SetElementVisibility( self.ZMPrematchCountdown0, isT7 )
            SetElementVisibility( self.ScoreboardWidget, isBo3 )
            --SetElementVisibility( self.ZMBeastBar, isT7 )
            --SetElementVisibility( self.RocketShieldBlueprintWidget, isT7 )
            --SetElementVisibility( self.IngameChatClientContainer, isT7 )
            --SetElementVisibility( self.IngameChatClientContainer0, isT7 )
            SetElementVisibility( self.SidequestIconInventoryWidget, isBo3 )
            --SetElementVisibility( self.SidequestNotificationList, isT7 )

            ---------- T4 Visibility ----------
            SetElementVisibility( self.T4Ammo, isT4 )
            SetElementVisibility( self.T4Notification, isT4 )
            SetElementVisibility( self.T4Perks, isT4 )
            SetElementVisibility( self.T4Rounds, isT4 )
            SetElementVisibility( self.T4Score, isT4 )
            SetElementVisibility( self.T4Scoreboard, isT4 )

            ---------- T6 Visibility ----------
            SetElementVisibility( self.T6Ammo, isT6 )
            SetElementVisibility( self.T6Perks, isT6 )
            SetElementVisibility( self.T6Rounds, isT6 )
            SetElementVisibility( self.T6Score, isT6 )
            SetElementVisibility( self.T6Scoreboard, isT6 )

            ---------- T8 Visibility ----------
            SetElementVisibility( self.T8Ammo, isT8 )
            SetElementVisibility( self.T8Notification, isT8 )
            SetElementVisibility( self.T8Perks, isT8 )
            SetElementVisibility( self.T8Rounds, isT8 )
            SetElementVisibility( self.T8Scoreboard, isT8 )
            SetElementVisibility( self.T8Score, isT8 )

            ---------- T10 Visibility ----------
            SetElementVisibility( self.T10Ammo, isT10 )
            SetElementVisibility( self.T10Notification, isT10 )
            SetElementVisibility( self.T10Perks, isT10 )
            SetElementVisibility( self.T10PopupScore, isT10 )
            SetElementVisibility( self.T10Rounds, isT10 )
            SetElementVisibility( self.T10Score, isT10 )
            SetElementVisibility( self.T10Scoreboard, isT10 )
        end
    end )

    if not CoD.GameMessages then
      CoD.GameMessages = {}
    end
    CoD.GameMessages.ObituaryWindowUpdateVisibility = function( element, event )
        element:setAlpha( 0 )
    end
end

local HookHud = function( hudName )
    local CallOriginal = LUI.createMenu[ hudName ]
    if CallOriginal and type( CallOriginal ) == "function" then
        LUI.createMenu[ hudName ] = function( controller )
            local self = CallOriginal( controller )

            if PreLoadFunc then
                PreLoadFunc( self, controller )
            end

            self.LuaPrint = CoD.LuaPrint.new( self, controller )
            self.LuaPrint:setLeftRight( true, true, 0, 0 )
            self.LuaPrint:setTopBottom( true, true, 0, 0 )
            self:addElement( self.LuaPrint )

            self.KingslayerPowerupsContainer = CoD.KingslayerPowerupsContainer.new( self, controller )
            self.KingslayerPowerupsContainer:setLeftRight( true, true, 0, 0 )
            self.KingslayerPowerupsContainer:setTopBottom( true, true, 0, 0 )
            self:addElement( self.KingslayerPowerupsContainer )

            self.T7Ammo = CoD.ZmAmmoContainerFactory.new( self, controller )
            self.T7Ammo:setLeftRight( false, true, -427, 3 )
            self.T7Ammo:setTopBottom( false, true, -232, 0 )
            self:addElement( self.T7Ammo )

            self.GumTracker = CoD.StartMenu_GumTracker.new( self, controller )
            self.GumTracker:setLeftRight( true, false, 456, 824 )
            self.GumTracker:setTopBottom( true, false, -50, 100 )
            self.GumTracker:setScale( 0.75 )
            local UpdateTrackerVisibility = function()
                local isVisible = Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
                and Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE )
                and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
                and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE )
                
                if isVisible then
                    local FadeTransitionFrame1 = function( element, event )
                        local FadeTransitionFrame2 = function( element, event )
                            local FadeTransitionFrame3 = function( element, event )
                                if not event.interrupted then
                                    element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
                                    element:setAlpha( 0 )
                                end
                            end

                            if not event.interrupted then
                                element:beginAnimation( "keyframe", 3500, false, false, CoD.TweenType.Linear )
                                element:registerEventHandler( "transition_complete_keyframe", FadeTransitionFrame3 )
                            end
                        end

                        if not event.interrupted then
                            element:beginAnimation( "keyframe", 500, false, false, CoD.TweenType.Linear )
                            element:setAlpha( 1 )
                            element:registerEventHandler( "transition_complete_keyframe", FadeTransitionFrame2 )
                        end
                    end

                    self.GumTracker:completeAnimation()
                    self.GumTracker:setAlpha( 0 )
                    FadeTransitionFrame1( self.GumTracker, {} )
                else
                    self.GumTracker:completeAnimation()
                    self.GumTracker:setAlpha( 0 )
                end
            end
            local bits = { 
                Enum.UIVisibilityBit.BIT_HUD_VISIBLE, 
                Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE, 
                Enum.UIVisibilityBit.BIT_GAME_ENDED, 
                Enum.UIVisibilityBit.BIT_UI_ACTIVE 
            }
            for _, bit in ipairs( bits ) do
                self.GumTracker:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. bit ), function( model )
                    UpdateTrackerVisibility()
                end )
            end
            UpdateTrackerVisibility()
            self:addElement( self.GumTracker )

            ---------- SOE Elements ----------
            self.ZodAmmo = CoD.ZmAmmoContainer.new( self, controller )
            self.ZodAmmo:setLeftRight( false, true, -424, 6 )
            self.ZodAmmo:setTopBottom( false, true, -245.5, 3 )
            self:addElement( self.ZodAmmo )

            self.PlayerLivesIndicator = CoD.ZmAmmo_PlayerLivesIndicator.new( self, controller )
            self.PlayerLivesIndicator:setLeftRight( true, false, 196, 246 )
            self.PlayerLivesIndicator:setTopBottom( false, true, -146.25, -96.25 )
            self.PlayerLivesIndicator:setScale( 1.4 )
            self.PlayerLivesIndicator:setYRot( -20 )
            self:addElement( self.PlayerLivesIndicator )

            ---------- T4 Elements ----------
            self.T4Font1 = LUI.UIText.new()
            self.T4Font1:setLeftRight( true, false, -1280, -1000 )
            self.T4Font1:setTopBottom( true, false, -720, -700 )
            self.T4Font1:setTTF( "fonts/itc_legacy_sans_bold.ttf" )
            self.T4Font1:setText( "T4Font" )
            self:addElement( self.T4Font1 )

            self.T4Ammo = CoD.T4AmmoContainer.new( self, controller )
            self.T4Ammo:setLeftRight( true, true, 0, 0 )
            self.T4Ammo:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T4Ammo )

            self.T4Notification = CoD.T4Notification.new( self, controller )
            self.T4Notification:setLeftRight( true, true, 0, 0 )
            self.T4Notification:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T4Notification )

            self.T4Perks = CoD.T4PerksContainer.new( self, controller )
            self.T4Perks:setLeftRight( true, true, 0, 0 )
            self.T4Perks:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T4Perks )

            self.T4Rounds = CoD.T4RoundContainer.new( self, controller )
            self.T4Rounds:setLeftRight( true, true, 0, 0 )
            self.T4Rounds:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T4Rounds )

            self.T4Score = CoD.T4ScoreContainer.new( self, controller )
            self.T4Score:setLeftRight( true, true, 0, 0 )
            self.T4Score:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T4Score )

            self.T4Scoreboard = CoD.T4Scoreboard.new( self, controller )
            self.T4Scoreboard:setLeftRight( true, true, 0, 0 )
            self.T4Scoreboard:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T4Scoreboard )

            ---------- T6 Elements ----------
            self.T6Font1 = LUI.UIText.new()
            self.T6Font1:setLeftRight( true, false, -1280, -1000 )
            self.T6Font1:setTopBottom( true, false, -720, -700 )
            self.T6Font1:setTTF( "fonts/bigFont.ttf" )
            self.T6Font1:setText( "T6Font" )
            self:addElement( self.T6Font1 )

            self.T6Ammo = CoD.T6AmmoContainer.new( self, controller )
            self.T6Ammo:setLeftRight( true, true, 0, 0 )
            self.T6Ammo:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T6Ammo )

            self.T6Perks = CoD.T6PerksContainer.new( self, controller )
            self.T6Perks:setLeftRight( true, true, 0, 0 )
            self.T6Perks:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T6Perks )

            self.T6Rounds = CoD.T6RoundContainer.new( self, controller )
            self.T6Rounds:setLeftRight( true, true, 0, 0 )
            self.T6Rounds:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T6Rounds )

            self.T6Score = CoD.T6ScoreContainer.new( self, controller )
            self.T6Score:setLeftRight( true, true, 0, 0 )
            self.T6Score:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T6Score )

            self.T6Scoreboard = CoD.T6Scoreboard.new( self, controller )
            self.T6Scoreboard:setLeftRight( true, true, 0, 0 )
            self.T6Scoreboard:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T6Scoreboard )

            ---------- T8 Elements ----------
            self.T8Font1 = LUI.UIText.new()
            self.T8Font1:setLeftRight( true, false, -1280, -1000 )
            self.T8Font1:setTopBottom( true, false, -720, -700 )
            self.T8Font1:setTTF( "fonts/0arame_mono_stencil.ttf" )
            self.T8Font1:setText( "T8Font" )
            self:addElement( self.T8Font1 )

            self.T8Font2 = LUI.UIText.new()
            self.T8Font2:setLeftRight( true, false, -1280, -1000 )
            self.T8Font2:setTopBottom( true, false, -720, -700 )
            self.T8Font2:setTTF( "fonts/dinnext_regular.ttf" )
            self.T8Font2:setText( "T8Font" )
            self:addElement( self.T8Font2 )

            self.T8Font3 = LUI.UIText.new()
            self.T8Font3:setLeftRight( true, false, -1280, -1000 )
            self.T8Font3:setTopBottom( true, false, -720, -700 )
            self.T8Font3:setTTF( "fonts/notosans_bold.ttf" )
            self.T8Font3:setText( "T8Font" )
            self:addElement( self.T8Font3 )

            self.T8Font4 = LUI.UIText.new()
            self.T8Font4:setLeftRight( true, false, -1280, -1000 )
            self.T8Font4:setTopBottom( true, false, -720, -700 )
            self.T8Font4:setTTF( "fonts/skorzhen.ttf" )
            self.T8Font4:setText( "T8Font" )
            self:addElement( self.T8Font4 )

            self.T8Font5 = LUI.UIText.new()
            self.T8Font5:setLeftRight( true, false, -1280, -1000 )
            self.T8Font5:setTopBottom( true, false, -720, -700 )
            self.T8Font5:setTTF( "fonts/ttmussels_demibold.ttf" )
            self.T8Font5:setText( "T8Font" )
            self:addElement( self.T8Font5 )

            self.T8Ammo = CoD.T8AmmoContainer.new( self, controller )
            self.T8Ammo:setLeftRight( true, true, 0, 0 )
            self.T8Ammo:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T8Ammo )

            self.T8Notification = CoD.T8Notification.new( self, controller )
            self.T8Notification:setLeftRight( true, true, 0, 0 )
            self.T8Notification:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T8Notification )

            self.T8Perks = CoD.T8PerksContainer.new( self, controller )
            self.T8Perks:setLeftRight( true, true, 0, 0 )
            self.T8Perks:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T8Perks )

            self.T8Rounds = CoD.ZmRndContainer.new( self, controller )
            self.T8Rounds:setLeftRight( true, false, -32, 192 ) 
            self.T8Rounds:setTopBottom( true, false, 0, 160 ) 
            self.T8Rounds:setScale( 0.8 )
            self:addElement( self.T8Rounds )

            self.T8Score = CoD.T8ScoreContainer.new( self, controller )
            self.T8Score:setLeftRight( true, true, 0, 0 )
            self.T8Score:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T8Score )

            self.T8Scoreboard = CoD.T8Scoreboard.new( self, controller )
            self.T8Scoreboard:setLeftRight( true, true, 0, 0 )
            self.T8Scoreboard:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T8Scoreboard )

            ---------- T10 Elements ----------
            self.T10Font1 = LUI.UIText.new()
            self.T10Font1:setLeftRight( true, false, -1280, -1000 )
            self.T10Font1:setTopBottom( true, false, -720, -700 )
            self.T10Font1:setTTF( "fonts/kairos_sans_w1g_cn.ttf" )
            self.T10Font1:setText( "T10Font" )
            self:addElement( self.T10Font1 )

            self.T10Font2 = LUI.UIText.new()
            self.T10Font2:setLeftRight( true, false, -1280, -1000 )
            self.T10Font2:setTopBottom( true, false, -720, -700 )
            self.T10Font2:setTTF( "fonts/kairos_sans_w1g_cn_bold.ttf" )
            self.T10Font2:setText( "T10Font" )
            self:addElement( self.T10Font2 )
            
            self.T10Font3 = LUI.UIText.new()
            self.T10Font3:setLeftRight( true, false, -1280, -1000 )
            self.T10Font3:setTopBottom( true, false, -720, -700 )
            self.T10Font3:setTTF( "fonts/kairos_sans_w1g_cn_medium.ttf" )
            self.T10Font3:setText( "T10Font" )
            self:addElement( self.T10Font3 )
            
            self.T10Font4 = LUI.UIText.new()
            self.T10Font4:setLeftRight( true, false, -1280, -1000 )
            self.T10Font4:setTopBottom( true, false, -720, -700 )
            self.T10Font4:setTTF( "fonts/monospac821_bt_wgl4_1.ttf" )
            self.T10Font4:setText( "T10Font" )
            self:addElement( self.T10Font4 )

            self.T10Font5 = LUI.UIText.new()
            self.T10Font5:setLeftRight( true, false, -1280, -1000 )
            self.T10Font5:setTopBottom( true, false, -720, -700 )
            self.T10Font5:setTTF( "fonts/noto_sans_cond_med.ttf" )
            self.T10Font5:setText( "T10Font" )
            self:addElement( self.T10Font5 )

            self.T10Ammo = CoD.T10AmmoContainer.new( self, controller )
            self.T10Ammo:setLeftRight( true, true, 0, 0 )
            self.T10Ammo:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T10Ammo )

            self.T10Notification = CoD.T10Notification.new( self, controller )
            self.T10Notification:setLeftRight( true, true, 0, 0 )
            self.T10Notification:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T10Notification )

            self.T10Perks = CoD.T10PerksContainer.new( self, controller )
            self.T10Perks:setLeftRight( true, true, 0, 0 )
            self.T10Perks:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T10Perks )

            self.T10PopupScore = CoD.T10PopupScore.new( self, controller )
            self.T10PopupScore:setLeftRight( true, true, 0, 0 )
            self.T10PopupScore:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T10PopupScore )

            self.T10Rounds = CoD.T10RoundContainer.new( self, controller )
            self.T10Rounds:setLeftRight( true, true, 0, 0 )
            self.T10Rounds:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T10Rounds )

            self.T10Score = CoD.T10ScoreContainer.new( self, controller )
            self.T10Score:setLeftRight( true, true, 0, 0 )
            self.T10Score:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T10Score )

            self.T10Scoreboard = CoD.T10Scoreboard.new( self, controller )
            self.T10Scoreboard:setLeftRight( true, true, 0, 0 )
            self.T10Scoreboard:setTopBottom( true, true, 0, 0 )
            self:addElement( self.T10Scoreboard )

            LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
                element.LuaPrint:close()
                element.KingslayerPowerupsContainer:close()
                element.T7Ammo:close()
                element.GumTracker:close()

                element.ZodAmmo:close()
                element.PlayerLivesIndicator:close()

                element.T4Font1:close()
                element.T4Ammo:close()
                element.T4Notification:close()
                element.T4Perks:close()
                element.T4Rounds:close()
                element.T4Score:close()
                element.T4Scoreboard:close()

                element.T6Font1:close()
                element.T6Ammo:close()
                element.T6Perks:close()
                element.T6Rounds:close()
                element.T6Score:close()
                element.T6Scoreboard:close()

                element.T8Font1:close()
                element.T8Font2:close()
                element.T8Font3:close()
                element.T8Font4:close()
                element.T8Font5:close()
                element.T8Ammo:close()
                element.T8Notification:close()
                element.T8Perks:close()
                element.T8Rounds:close()
                element.T8Score:close()
                element.T8Scoreboard:close()

                element.T10Font1:close()
                element.T10Font2:close()
                element.T10Font3:close()
                element.T10Font4:close()
                element.T10Font5:close()
                element.T10Ammo:close()
                element.T10Notification:close()
                element.T10Perks:close()
                element.T10PopupScore:close()
                element.T10Rounds:close()
                element.T10Score:close()
                element.T10Scoreboard:close()
            end )

            if PostLoadFunc then
                PostLoadFunc( self, controller )
            end

            return self
        end
    end
end

local hudList = {
    "T7Hud_ZM",
    "T7Hud_zm_castle",
    "T7Hud_zm_dlc5",
    "T7Hud_zm_factory",
    "T7Hud_zm_genesis",
    "T7Hud_zm_island",
    "T7Hud_zm_stalingrad",    
    "T7Hud_zm_tomb"
}

for _, name in ipairs( hudList ) do
    HookHud( name )
end

local mapNames = {
    zm_prototype    = "Nacht Der Untoten",
    zm_asylum       = "Verruckt",
    zm_sumpf        = "Shi No Numa",
    zm_factory      = "The Giant",
    zm_theater      = "Kino Der Toten",
    zm_cosmodrome   = "Ascension",
    zm_temple       = "Shangri-la",
    zm_moon         = "Moon",
    zm_tomb         = "Origins",
    zm_zod          = "Shadows of Evil",
    zm_castle       = "Der Eisendrache",
    zm_island       = "Zetsubou No Shima",
    zm_stalingrad   = "Gorod Krovi",
    zm_genesis      = "Revelations",

    zm_coast        = "Call of the Dead",
    zm_die          = "Die Rise",
    zm_prison       = "Mob of the Dead",
    zm_town         = "Town"
}

local mapName = Engine.GetCurrentMap()
if mapNames[ mapName ] then
    CoD.UsermapName = mapNames[ mapName ]
end