CoD.ZMPrisonAfterlifeWidget = InheritFrom( LUI.UIElement )
CoD.ZMPrisonAfterlifeWidget.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZMPrisonAfterlifeWidget )
	self.id = "ZMPrisonAfterlife"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.AfterlifeGlow = LUI.UIImage.new()
	self.AfterlifeGlow:setLeftRight( true, false, 72, 129.33 )
	self.AfterlifeGlow:setTopBottom( false, true, -144.66, -116 )
	self.AfterlifeGlow:setImage( RegisterImage( "uie_t7_hud_zombie_afterlife_meter_dark" ) )
	self.AfterlifeGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.AfterlifeGlow:setRGB( 0.45, 0.98, 0.9 )
	self:addElement( self.AfterlifeGlow )

	self.AfterlifeGlowOverlay = LUI.UIImage.new()
	self.AfterlifeGlowOverlay:setLeftRight( true, false, 72, 129.33 )
	self.AfterlifeGlowOverlay:setTopBottom( false, true, -144.66, -116 )
	self.AfterlifeGlowOverlay:setImage( RegisterImage( "uie_t7_hud_zombie_afterlife_meter_glow" ) )
	self.AfterlifeGlowOverlay:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_delta" ) )
	self.AfterlifeGlowOverlay:setShaderVector( 0, 0, 1, 0, 0 )
	self.AfterlifeGlowOverlay:setShaderVector( 1, 0.3, 0.3, 0, 0 )
	self.AfterlifeGlowOverlay:setShaderVector( 2, 0, 1, 0, 0 )
	self.AfterlifeGlowOverlay:setShaderVector( 3, 0, 0, 0, 0 )
	self.AfterlifeGlowOverlay:setAlpha( 1 )
	self:addElement( self.AfterlifeGlowOverlay )

	self.AfterlifeIcon = LUI.UIImage.new()
	self.AfterlifeIcon:setLeftRight( true, false, 72, 129.33 )
	self.AfterlifeIcon:setTopBottom( false, true, -144.66, -116 )
	self.AfterlifeIcon:setImage( RegisterImage( "uie_t7_hud_zombie_afterlife_meter" ) )
	self:addElement( self.AfterlifeIcon )

	self.AfterlifeText = LUI.UIText.new()
	self.AfterlifeText:setLeftRight( true, false, 126, 148.66 )
	self.AfterlifeText:setTopBottom( false, true, -142, -119.33 )
	self.AfterlifeText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self:addElement( self.AfterlifeText )

	local Frame1 = function ( element, event )
		local Frame2 = function ( element, event )
			local Frame3 = function ( element, event )
				local Frame4 = function ( element, event )
					element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
					element:setAlpha( 1 )
					element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
				end
				
				if event.interrupted then
					Frame4( element, event )
					return 
				else
					element:beginAnimation( "keyframe", 800, false, false, CoD.TweenType.Linear )
					element:setAlpha( 0 )
					element:registerEventHandler( "transition_complete_keyframe", Frame4 )
				end
			end
			
			if event.interrupted then
				Frame3( element, event )
				return 
			else
				element:beginAnimation( "keyframe", 650, false, false, CoD.TweenType.Linear )
				element:setAlpha( 0.85 )
				element:registerEventHandler( "transition_complete_keyframe", Frame3 )
			end
		end
		
		element:beginAnimation( "keyframe", 650, false, false, CoD.TweenType.Linear )
		element:setAlpha( 0 )
		element:registerEventHandler( "transition_complete_keyframe", Frame2 )
	end
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.AfterlifeGlow:completeAnimation()
				self.AfterlifeGlow:setRGB( 0.45, 0.98, 0.9 )
				self.AfterlifeGlow:setAlpha( 0 )
				self.clipFinished( self.AfterlifeGlow, {} )

				self.AfterlifeGlowOverlay:completeAnimation()
				self.AfterlifeGlowOverlay:setAlpha( 0 )
				self.clipFinished( self.AfterlifeGlowOverlay, {} )

				self.AfterlifeIcon:completeAnimation()
				self.AfterlifeIcon:setAlpha( 0 )
				self.clipFinished( self.AfterlifeIcon, {} )

				self.AfterlifeText:completeAnimation()
				self.AfterlifeText:setAlpha( 0 )
				self.clipFinished( self.AfterlifeText, {} )
			end,

			HudStart = function ()
				self:setupElementClipCounter( 4 )

				local HudStartFrame1 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 1 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.AfterlifeGlow:completeAnimation()
				self.AfterlifeGlow:setAlpha( 0 )
				HudStartFrame1( self.AfterlifeGlow, {} )

				self.AfterlifeGlowOverlay:completeAnimation()
				self.AfterlifeGlowOverlay:setAlpha( 0 )
				HudStartFrame1( self.AfterlifeGlowOverlay, {} )

				self.AfterlifeIcon:completeAnimation()
				self.AfterlifeIcon:setAlpha( 0 )
				HudStartFrame1( self.AfterlifeIcon, {} )

				self.AfterlifeText:completeAnimation()
				self.AfterlifeText:setAlpha( 0 )
				HudStartFrame1( self.AfterlifeText, {} )
			end
		},

		HudStart = {
			DefaultClip = function ()
				self:setupElementClipCounter( 4 )

				self.AfterlifeGlow:completeAnimation()
				self.AfterlifeGlow:setAlpha( 1 )
				self.clipFinished( self.AfterlifeGlow, {} )

				self.AfterlifeGlowOverlay:completeAnimation()
				self.AfterlifeGlowOverlay:setAlpha( 1 )
				self.AfterlifeGlowOverlay:setShaderVector( 2, SetVectorComponent( 2, 1, SubtractVectorComponentFrom( 1, 1, ScaleVector( 1, CoD.GetVectorComponentFromString( 0, 1 ), CoD.GetVectorComponentFromString( 0, 2 ), CoD.GetVectorComponentFromString( 0, 3 ), CoD.GetVectorComponentFromString( 0, 4 ) ) ) ) )
				Frame1( self.AfterlifeGlowOverlay, { value = 1 } )

				self.AfterlifeIcon:completeAnimation()
				self.AfterlifeIcon:setAlpha( 1 )
				self.clipFinished( self.AfterlifeIcon, {} )

				self.AfterlifeText:completeAnimation()
				self.AfterlifeText:setAlpha( 1 )
				self.clipFinished( self.AfterlifeText, {} )
			end,

			DefaultState = function ()
				self:setupElementClipCounter( 4 )

				local DefaultFrame1 = function ( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 300, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.AfterlifeGlow:completeAnimation()
				self.AfterlifeGlow:setAlpha( 1 )
				self.clipFinished( self.AfterlifeGlow, {} )

				self.AfterlifeGlowOverlay:completeAnimation()
				self.AfterlifeGlowOverlay:setAlpha( 1 )
				self.AfterlifeGlowOverlay:setShaderVector( 2, SetVectorComponent( 2, 1, SubtractVectorComponentFrom( 1, 1, ScaleVector( 1, CoD.GetVectorComponentFromString( 0, 1 ), CoD.GetVectorComponentFromString( 0, 2 ), CoD.GetVectorComponentFromString( 0, 3 ), CoD.GetVectorComponentFromString( 0, 4 ) ) ) ) )
				Frame1( self.AfterlifeGlowOverlay, { value = 1 } )

				self.AfterlifeIcon:completeAnimation()
				self.AfterlifeIcon:setAlpha( 1 )
				DefaultFrame1( self.AfterlifeIcon, {} )

				self.AfterlifeText:completeAnimation()
				self.AfterlifeText:setAlpha( 1 )
				DefaultFrame1( self.AfterlifeText, {} )
			end
		}
	}

	self:mergeStateConditions( {
		{
			stateName = "HudStart",
			condition = function ( menu, element, event )
				if IsModelValueTrue( controller, "hudItems.playerSpawned" ) then
					if Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_VISIBLE )
					and Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_HUD_HARDCORE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_GAME_ENDED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_KILLCAM )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_UI_ACTIVE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IS_SCOPED )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_VEHICLE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC )
					and not Engine.IsVisibilityBitSet( controller, Enum.UIVisibilityBit.BIT_EMP_ACTIVE ) then
						return true
					else
						return false
					end
				else
					
				end
			end
		}
	} )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentWeapon.viewmodelWeaponName" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentWeapon.viewmodelWeaponName" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.playerSpawned" ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "hudItems.playerSpawned" } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE ), function ( model )
		menu:updateElementState( self, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE } )
	end )

	self:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "player_lives" ), function ( model )
		local modelValue = Engine.GetModelValue( model )
		if modelValue then
			Frame1( self.AfterlifeIcon, { value = 1 } )
			Frame1( self.AfterlifeGlow, { value = 1 } )
			Frame1( self.AfterlifeGlowOverlay, { value = 1 } )
			Frame1( self.AfterlifeText, { value = 1 } )
			self.AfterlifeText:setText( modelValue )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.AfterlifeGlow:close()
		element.AfterlifeGlowOverlay:close()
		element.AfterlifeIcon:close()
		element.AfterlifeText:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end