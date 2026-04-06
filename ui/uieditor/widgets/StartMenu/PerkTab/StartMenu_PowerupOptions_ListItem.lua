CoD.PowerupImages = {
	---------------------- BO3 ----------------------
	{
		powerup_instant_kill = "specialty_giant_killjoy_zombies",
		powerup_double_points = "specialty_giant_2x_zombies",
		powerup_fire_sale = "specialty_giant_firesale_zombies",
		powerup_mini_gun = "t7_hud_zm_powerup_giant_deathmachine",
		powerup_zombie_blood = "t7_zm_hd_specialty_zmblood"
	},

	---------------------- SOE ----------------------
	{
		powerup_instant_kill = "specialty_instakill_zombies",
		powerup_double_points = "specialty_2x_zombies",
		powerup_fire_sale = "specialty_firesale_zombies",
		powerup_mini_gun = "t7_hud_zm_powerup_deathmachine",
		powerup_zombie_blood = "t7_zm_hd_specialty_zmblood"
	},

	---------------------- BO1 ----------------------
	{
		powerup_instant_kill = "t5_specialty_instakill_zombies",
		powerup_double_points = "t5_specialty_2x_zombies",
		powerup_fire_sale = "t5_specialty_firesale_zombies",
		powerup_mini_gun = "t5_specialty_deathmachine_zombies",
		powerup_zombie_blood = "t5_specialty_zombieblood_zombies"
	},

	---------------------- BO2 ----------------------
	{
		powerup_instant_kill = "t6_specialty_instakill_zombies",
		powerup_double_points = "t6_specialty_2x_zombies",
		powerup_fire_sale = "t6_specialty_firesale_zombies",
		powerup_mini_gun = "t6_specialty_deathmachine_zombies",
		powerup_zombie_blood = "t6_specialty_zomblood_zombies"
	},

	---------------------- BO4 ----------------------
	{
		powerup_instant_kill = "t8_specialty_instakill_zombies",
		powerup_double_points = "t8_specialty_2x_zombies",
		powerup_fire_sale = "t8_specialty_firesale_zombies",
		powerup_mini_gun = "t8_specialty_deathmachine_zombies",
		powerup_zombie_blood = "t8_specialty_zomblood_zombies"
	},

	---------------------- BO6 ----------------------
	{
		powerup_instant_kill = "t10_specialty_instakill_zombies",
		powerup_double_points = "t10_specialty_2x_zombies",
		powerup_fire_sale = "t10_specialty_firesale_zombies",
		powerup_mini_gun = "t10_specialty_deathmachine_zombies",
		powerup_zombie_blood = "t10_specialty_zomblood_zombies"
	},
}

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
    	CoD.UIColors.SetElementColor( self.NameGlow, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.Focus.BorderTop, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.Focus.BorderBottom, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.Focus.BorderLeft, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        CoD.UIColors.SetElementColor( self.Focus.BorderRight, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )

        for _, element in ipairs( self.powerupLightning ) do
        	CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        end

        for _, element in ipairs( self.powerupFocusGlow ) do
        	CoD.UIColors.SetElementColor( element, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
        end
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )

    local powerupsIndexModel = Engine.GetModel( Engine.GetModelForController( controller ), "SelectedPowerupsIndex" )

    local CheckIfSelected = function()
        local selectedIndex = Engine.GetModelValue( powerupsIndexModel )
        local widgetModel = self:getModel()
        
        if widgetModel then
            local myIndexModel = Engine.GetModel( widgetModel, "powerupsIndex" )
            if myIndexModel then
                local myIndex = Engine.GetModelValue( myIndexModel )
                
                if myIndex ~= nil and selectedIndex ~= nil and myIndex == selectedIndex then
                    self:playClip( "Selected" ) 
                else
                    self.Name:setRGB( 1, 1, 1 )
                end
            end
        end
    end

    self:subscribeToModel( powerupsIndexModel, CheckIfSelected )
    self:linkToElementModel( self, "powerupsIndex", true, CheckIfSelected )
    CheckIfSelected()
end

CoD.StartMenu_PowerupOptions_ListItem = InheritFrom( LUI.UIElement )
CoD.StartMenu_PowerupOptions_ListItem.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_PowerupOptions_ListItem )
	self.id = "StartMenu_PowerupOptions_ListItem"
	self.soundSet = "default"
	self:setLeftRight( true, false, -100, 100 )
	self:setTopBottom( true, false, 0, 90 )
	self:makeFocusable()
	self:setHandleMouse( true )
	self.anyChildUsesUpdateState = true

	local powerupOrder = {
		"powerup_instant_kill",
		"powerup_double_points",
		"powerup_fire_sale",
		"powerup_mini_gun",
		"powerup_zombie_blood"
	}

	self.powerupIcons = {}
	self.powerupLightning = {}
	self.powerupFocusGlow = {}

    for i, powerupKey in ipairs( powerupOrder ) do

    	local leftPos = -55 + ( i * 45 ) 

        local powerupIcon = LUI.UIImage.new()
        powerupIcon:setLeftRight( true, false, leftPos, leftPos + 40 )
        powerupIcon:setTopBottom( false, false, -20, 20 ) 
        powerupIcon:setImage( RegisterImage( "blacktransparent" ) )
        powerupIcon:linkToElementModel( self, "powerupsIndex", true, function( model )
            local powerupsIndex = Engine.GetModelValue( model )
            if powerupsIndex and CoD.PowerupImages[ powerupsIndex ] then
                local imageName = CoD.PowerupImages[ powerupsIndex ][ powerupKey ]
                if imageName then
                    powerupIcon:setImage( RegisterImage( imageName ) )
                end
            end
        end )
        self:addElement( powerupIcon )

        local Lightning = LUI.UIImage.new()
        Lightning:setLeftRight( true, false, leftPos - 7.5, leftPos + 47.5 )
        Lightning:setTopBottom( false, false, -27.5, 32.5 )
        Lightning:setAlpha( 0 )
        Lightning:setScale( 0.1 )
        Lightning:setImage( RegisterImage( "uie_t7_zm_derriese_hud_notification_anim" ) )
        Lightning:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_flipbook" ) )
        Lightning:setShaderVector( 0, 28, 0, 0, 0 )
        Lightning:setShaderVector( 1, 30, 0, 0, 0 )
        self:addElement( Lightning )

        local FocusGlow = LUI.UIImage.new()
        FocusGlow:setLeftRight( true, false, leftPos - 7.5, leftPos + 47.5 )
        FocusGlow:setTopBottom( false, false, -27.5, 32.5 )
        FocusGlow:setAlpha( 0 )
        FocusGlow:setScale( 0.1 )
        FocusGlow:setImage( RegisterImage( "uie_t7_cp_hud_enemytarget_glow" ) )
        FocusGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
        self:addElement( FocusGlow )

        table.insert( self.powerupIcons, powerupIcon )
        table.insert( self.powerupLightning, Lightning )
        table.insert( self.powerupFocusGlow, FocusGlow )
    end

	self.NameBacking = LUI.UIImage.new()
	self.NameBacking:setLeftRight( false, false, -110, 110 )
	self.NameBacking:setTopBottom( false, false, 29, 47.5 )
	self.NameBacking:setImage( RegisterImage( "$white" ) )
	self.NameBacking:setRGB( 0, 0, 0 )
	self:addElement( self.NameBacking )

	self.NameGlow = LUI.UIImage.new()
	self.NameGlow:setLeftRight( false, false, -120, 120 )
	self.NameGlow:setTopBottom( false, false, 25, 55 )
	self.NameGlow:setAlpha( 0.66 )
	self.NameGlow:setScale( 1 )
	self.NameGlow:setImage( RegisterImage( "uie_t7_cp_hud_enemytarget_glow" ) )
	self.NameGlow:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.NameGlow )

	self.Name = LUI.UIText.new()
	self.Name:setLeftRight( false, false, -90, 90 )
	self.Name:setTopBottom( false, false, 25, 55 )
	self.Name:setTTF( "fonts/default.TTF" )
	self.Name:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_CENTER )
	self.Name:setRGB( 1, 1, 1 )
	self.Name:setScale( 0.5 )
	self.Name:linkToElementModel( self, "name", true, function( model )
		local name = Engine.GetModelValue( model )
		if name then
			self.Name:setText( string.upper( name ) )
		end
	end )
	self:addElement( self.Name )

	self.Focus = LUI.UIElement.new()
	self.Focus:setLeftRight( true, true, -12, 12 )
	self.Focus:setTopBottom( true, true, 24, 3 )
	self:addElement( self.Focus )

	local thickness = 1.5
	local glowColor = { r = 0.98, g = 0.52, b = 0.05 }

	self.Focus.BorderTop = LUI.UIImage.new()
	self.Focus.BorderTop:setLeftRight( true, true, 0, 0 )
	self.Focus.BorderTop:setTopBottom( true, false, 0, thickness )
	self.Focus.BorderTop:setRGB( glowColor.r, glowColor.g, glowColor.b )
	self.Focus:addElement( self.Focus.BorderTop )

	self.Focus.BorderBottom = LUI.UIImage.new()
	self.Focus.BorderBottom:setLeftRight( true, true, 0, 0 )
	self.Focus.BorderBottom:setTopBottom( false, true, -thickness, 0 )
	self.Focus.BorderBottom:setRGB( glowColor.r, glowColor.g, glowColor.b )
	self.Focus:addElement( self.Focus.BorderBottom )

	self.Focus.BorderLeft = LUI.UIImage.new()
	self.Focus.BorderLeft:setLeftRight( true, false, 0, thickness )
	self.Focus.BorderLeft:setTopBottom( true, true, 0, 0 )
	self.Focus.BorderLeft:setRGB( glowColor.r, glowColor.g, glowColor.b )
	self.Focus:addElement( self.Focus.BorderLeft )

	self.Focus.BorderRight = LUI.UIImage.new()
	self.Focus.BorderRight:setLeftRight( false, true, -thickness, 0 )
	self.Focus.BorderRight:setTopBottom( true, true, 0, 0 )
	self.Focus.BorderRight:setRGB( glowColor.r, glowColor.g, glowColor.b )
	self.Focus:addElement( self.Focus.BorderRight )	

	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function()
	            self:setupElementClipCounter( 5 )

	            self.Name:completeAnimation()
	            self.Name:setScale( 0.5 )
	            self.clipFinished( self.Name, {} )

	            for _, element in ipairs( self.powerupIcons ) do
                    element:completeAnimation()
                    element:setScale( 1 )
                    element:setAlpha( 1 )
                    self.clipFinished( element, {} )
                end

                for _, element in ipairs( self.powerupLightning ) do
                	element:completeAnimation()
                	element:setScale( 0.1 )
                	element:setAlpha( 0 )
                	self.clipFinished( element, {} )
                end

                for _, element in ipairs( self.powerupFocusGlow ) do
                	element:completeAnimation()
                	element:setScale( 0.1 )
                	element:setAlpha( 0 )
                	self.clipFinished( element, {} )
                end

                self.Focus:completeAnimation()
	            self.Focus:setAlpha( 0 )
	            self.clipFinished( self.Focus, {} )
	        end,

	        Selected = function()
			    self:setupElementClipCounter( 3 )

			    local parentList = self:getParent()
			    if parentList then
			    	parentList.m_inputDisabled = true
			    end

			    local NameFrame2 = function( element, event )
	                element:beginAnimation( "keyframe", 550, false, false, CoD.TweenType.BounceIn )
	                element:setScale( 0.5 )
	                element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
	            end

	            self.Name:completeAnimation()
	            self.Name:setScale( 0.7 )
	            CoD.UIColors.SetElementColor( self.Name, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	            NameFrame2( self.Name, {} )

			    for i, element in ipairs( self.powerupIcons ) do
			    	local IconFrame2 = function( element, event )
			    		local IconFrame3 = function( element, event )
			    			element:beginAnimation( "keyframe", 100, false, false, CoD.TweenType.BounceIn )
			    			element:setScale( 1 )
			    			element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
			    		end

			    		element:beginAnimation( "keyframe", 100 + ( i * 35 ), false, false, CoD.TweenType.BounceOut )
			    		element:setScale( 1.2 )
			    		element:registerEventHandler( "transition_complete_keyframe", IconFrame3 )
			    	end

			    	element:completeAnimation()
			    	IconFrame2( element, {} )
			    end

			    for i, element in ipairs( self.powerupLightning ) do

				    local LightningFrame2 = function ( element, event )
				    	local LightningFrame3 = function ( element, event )
					        if not event.interrupted then
					            element:beginAnimation( "keyframe", 350 + ( i * 35 ), false, false, CoD.TweenType.Linear )
					        end
					        element:setAlpha( 0 )
					        element:setScale( 0.5 )
					        element:registerEventHandler( "transition_complete_keyframe", function( element, event )
					            if i == #self.powerupLightning then
					                
					                local parentList = self:getParent()
					                if parentList then
					                    parentList.m_inputDisabled = false
					                end
					            end
					            
					            self.clipFinished( element, event )
					        end )
					    end

				        if event.interrupted then
				            LightningFrame3( element, event )
				            return 
				        else
				            element:beginAnimation( "keyframe", 50 + ( i * 35 ), false, false, CoD.TweenType.Linear )
				            element:setAlpha( 1 )
				            element:setScale( 1 )
				            element:registerEventHandler( "transition_complete_keyframe", LightningFrame3 )
				        end
				    end

				    element:completeAnimation()
				    element:setAlpha( 0 )
				    element:setScale( 1 )
				    LightningFrame2( element, {} )
				end

			    for i, element in ipairs( self.powerupFocusGlow ) do

					local FocusGlowFrame2 = function( element, event )
		            	local FocusGlowFrame3 = function( element, event )
		            		local FocusGlowFrame4 = function( element, event )
				            	element:beginAnimation( "keyframe", 25 + ( i * 35 ), false, false, CoD.TweenType.Linear )
				            	element:setAlpha( 0 )
				            	element:setScale( 0.1 )
				            	element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
				            end

			            	element:beginAnimation( "keyframe", 50 + ( i * 35 ), false, false, CoD.TweenType.Linear )
			            	element:setScale( 1.4 )
			            	element:registerEventHandler( "transition_complete_keyframe", FocusGlowFrame4 )
			            end

		            	element:beginAnimation( "keyframe", 25 + ( i * 35 ), false, false, CoD.TweenType.Linear )
		            	element:setAlpha( 1 )
		            	element:registerEventHandler( "transition_complete_keyframe", FocusGlowFrame3 )
		            end

		            element:completeAnimation()
		            FocusGlowFrame2( element, {} )
				end

			    self.Focus:completeAnimation()
			    self.Focus:setAlpha( 0 )
			    self.clipFinished( self.Focus, {} )
			end,

			Focus = function()
				self:setupElementClipCounter( 1 )

				self.Focus:completeAnimation()
				self.Focus:setAlpha( 0.5 )
				self.clipFinished( self.Focus, {} )
			end,

			LoseFocus = function()
				self:setupElementClipCounter( 1 )

				local FadeOutFocus = function( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Focus:completeAnimation()
				self.Focus:setAlpha( 0.5 )
				FadeOutFocus( self.Focus, {} )
			end,

			GainFocus = function()
				self:setupElementClipCounter( 1 )
				local FadeInFocus = function( element, event )
					if not event.interrupted then
						element:beginAnimation( "keyframe", 50, false, false, CoD.TweenType.Linear )
					end
					element:setAlpha( 0.5 )
					if event.interrupted then
						self.clipFinished( element, event )
					else
						element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
					end
				end
				
				self.Focus:completeAnimation()
				self.Focus:setAlpha( 0 )
				FadeInFocus( self.Focus, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		for i, element in ipairs( self.powerupIcons ) do
			element:close()
		end
		for _, element in ipairs( self.powerupLightning ) do
			element:close()
		end
		for _, element in ipairs( self.powerupFocusGlow ) do
			element:close()
		end
		element.Focus:close()
		element.NameBacking:close()
		element.NameGlow:close()
		element.Name:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end