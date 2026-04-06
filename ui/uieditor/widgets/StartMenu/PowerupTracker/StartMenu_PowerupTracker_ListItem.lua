require( "ui.uieditor.widgets.CAC.GridItemBGBGlow" )
require( "ui.uieditor.widgets.CAC.GridItemConsumableLabel" )

local PowerUpList = {
    { name = "doublepoints", 	image = "ui_icon_powerup_tracker_doublepoints" },
    { name = "instakill",    	image = "ui_icon_powerup_tracker_instakill" },
    { name = "fullammo",      	image = "ui_icon_powerup_tracker_fullammo" },
    { name = "nuke",			image = "ui_icon_powerup_tracker_nuke" },
    { name = "deathmachine",  	image = "ui_icon_powerup_tracker_deathmachine" },
    { name = "carpenter",     	image = "ui_icon_powerup_tracker_carpenter" },
    { name = "firesale",     	image = "ui_icon_powerup_tracker_firesale" },
    { name = "blood",  			image = "ui_icon_powerup_tracker_blood" },
}

local PostLoadFunc = function( self, controller, menu )
    self:addElement( LUI.UITimer.newElementTimer( 1, true, function()
        local index = (self.gridInfoTable and self.gridInfoTable.zeroBasedIndex + 1) or 1
        local data = PowerUpList[index]
        local controllerModel = Engine.GetModelForController( controller )
        
        if data then
            self.Image:setImage( RegisterImage( data.image ) )
            
            local slotModel = Engine.CreateModel( Engine.GetModelForController( controller ), "Powerup_Selections.slot" .. index )
            local disabledModel = Engine.CreateModel( Engine.GetModelForController( controller ), "Powerup_Selections.disabled" .. index )

            self:subscribeToModel( slotModel, function( model )
                self:processEvent( { name = "update_state", menu = menu } )
            end )

			self:subscribeToModel( disabledModel, function( model )
			    self:processEvent( { name = "update_state", menu = menu } )
			end )

			self.safeIndex = index
        end
    end ) )
   
    self:registerEventHandler( "button_action_secondary", function( element, event )
	    local index = element.safeIndex or (element.gridInfoTable and element.gridInfoTable.zeroBasedIndex + 1) or 1
	    local controllerModel = Engine.GetModelForController( controller )
	    
	    local slotModel = Engine.CreateModel( controllerModel, "Powerup_Selections.slot" .. index )
	    local disabledModel = Engine.CreateModel( controllerModel, "Powerup_Selections.disabled" .. index )
	    
	    local isDisabled = Engine.GetModelValue( disabledModel ) or false
	    local newState = not isDisabled
	    
	    Engine.SetModelValue( disabledModel, newState )
	    if newState == true then
	        Engine.SetModelValue( slotModel, true )
	    end

	    Engine.PlaySound( "uin_lobby_error" )
	    element:processEvent( { name = "update_state", menu = menu } )

	    element:addElement( LUI.UITimer.newElementTimer( 10, true, function()
	        local selectedCount = 0
	        local powerupModel = Engine.GetModel( controllerModel, "Powerup_Selections" )
	        
	        for i = 1, #PowerUpList do
	            local slot = Engine.GetModel( powerupModel, "slot" .. i )
	            local val = slot and Engine.GetModelValue( slot )
	            if val == true or val == 1 then
	                selectedCount = selectedCount + 1
	            end
	        end

	        if selectedCount >= #PowerUpList then
	            for i = 1, #PowerUpList do
	                local slot = Engine.GetModel( powerupModel, "slot" .. i )
	                local disabled = Engine.GetModel( powerupModel, "disabled" .. i )
	                
	                local isRed = disabled and ( Engine.GetModelValue( disabled ) == true or Engine.GetModelValue( disabled ) == 1 )
	                if slot and not isRed then 
	                    Engine.SetModelValue( slot, false ) 
	                end
	            end
	            Engine.PlaySound( "uin_bm_keydrop_anim" )
	            element:processEvent( { name = "update_state", menu = menu } )
	        end
	    end ) )

	    return true
	end )

    self:registerEventHandler( "gain_focus", function( element, event )
	    local index = (element.gridInfoTable and element.gridInfoTable.zeroBasedIndex + 1) or 1
	    
	    local controllerModel = Engine.GetModelForController( controller )
	    local focusModel = Engine.CreateModel( controllerModel, "Powerup_Tracker_Focused_Index" )
	    
	    Engine.SetModelValue( focusModel, index )
	end )

    self:registerEventHandler( "button_action", function( element, event )
	    local controllerModel = Engine.GetModelForController( controller )
	    local index = (element.gridInfoTable and element.gridInfoTable.zeroBasedIndex + 1) or 1
	    
	    local disabledModel = Engine.GetModel( controllerModel, "Powerup_Selections.disabled" .. index )
	    if not event.internalCall and disabledModel and Engine.GetModelValue( disabledModel ) == true then
	        return true 
	    end

	    local model = Engine.GetModel( controllerModel, "Powerup_Selections.slot" .. index )
	    if model then
	        if not event.internalCall then
	            local current = Engine.GetModelValue( model )
	            Engine.SetModelValue( model, not current )
	            Engine.PlaySound( "uin_back_mode_select" )
	        end

	        local selectedCount = 0
	        local powerupModel = Engine.GetModel( controllerModel, "Powerup_Selections" )

	        for i = 1, #PowerUpList do
	            local slot = Engine.GetModel( powerupModel, "slot" .. i )
	            if slot and Engine.GetModelValue( slot ) == true then
	                selectedCount = selectedCount + 1
	            end
	        end

	        if selectedCount >= #PowerUpList then
	            for i = 1, #PowerUpList do
	                local slot = Engine.GetModel( powerupModel, "slot" .. i )
	                local disabled = Engine.GetModel( powerupModel, "disabled" .. i )
	                
	                if slot and not (disabled and Engine.GetModelValue(disabled) == true) then 
	                    Engine.SetModelValue( slot, false ) 
	                end
	            end
	            Engine.PlaySound( "uin_bm_keydrop_anim" )
	        end
	        
	        element:processEvent( { name = "update_state", menu = menu } )
	        return true
	    end
	end )
end

CoD.StartMenu_PowerupList = InheritFrom( LUI.UIElement )
CoD.StartMenu_PowerupList.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_PowerupList )
	self.id = "StartMenu_PowerupList"
	self.soundSet = "Default"
	self:setLeftRight( true, false, 0, 64 )
	self:setTopBottom( true, false, 0, 109 )
	self:makeFocusable()
	self:setHandleMouse( true )
	self.anyChildUsesUpdateState = true

	self.Selected = LUI.UIImage.new()
	self.Selected:setLeftRight( false, false, -37.5, 37.5 )
	self.Selected:setTopBottom( false, false, -60, 15 )
	self.Selected:setImage( RegisterImage( "$white" ) )
	self.Selected:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.Selected:setShaderVector( 0, 0.3, 0.3, 0.3, 0.3 )
	self:addElement( self.Selected )

    self.Image = LUI.UIImage.new()
    self.Image:setLeftRight( false, false, -32, 32 )
    self.Image:setTopBottom( true, false, 0, 64 )
    self:addElement( self.Image )

	self.Focus = LUI.UIImage.new()
	self.Focus:setLeftRight( false, false, -37.5, 37.5 )
	self.Focus:setTopBottom( false, false, -60, 15 )
	self.Focus:setImage( RegisterImage( "uie_t7_blackmarket_bribe_big_selected" ) )
	self.Focus:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.Focus:setAlpha( 1 )
	self:addElement( self.Focus )

	
	self.clipsPerState = {
	    DefaultState = {
	        DefaultClip = function ()
	            self:setupElementClipCounter( 2 )

	            self.Selected:completeAnimation()
	            self.Selected:setRGB( 0, 1, 0 )
	            self.Selected:setAlpha( 0 )
	            self.clipFinished( self.Selected, {} )

	            self.Focus:completeAnimation()
	            self.Focus:setAlpha( 0 )
	            self.clipFinished( self.Focus, {} )
	        end,

	        Focus = function ()
	            self:setupElementClipCounter( 2 )

	            self.Selected:completeAnimation()
	            self.Selected:setRGB( 0, 1, 0 )
	            self.Selected:setAlpha( 0 )
	            self.clipFinished( self.Selected, {} )

	            self.Focus:completeAnimation()
	            self.Focus:setAlpha( 1 )
	            self.clipFinished( self.Focus, {} )
	        end
	    },

	    Selected = {
	        DefaultClip = function ()
	            self:setupElementClipCounter( 2 )

	            self.Selected:completeAnimation()
	            self.Selected:setRGB( 0, 1, 0 )
	            self.Selected:setAlpha( 1 )
	            self.clipFinished( self.Selected, {} )

	            self.Focus:completeAnimation()
	            self.Focus:setAlpha( 0 )
	            self.clipFinished( self.Focus, {} )
	        end,

	        Focus = function ()
	            self:setupElementClipCounter( 2 )

	            self.Selected:completeAnimation()
	            self.Selected:setRGB( 0, 1, 0 )
	            self.Selected:setAlpha( 1 )
	            self.clipFinished( self.Selected, {} )

	            self.Focus:completeAnimation()
	            self.Focus:setAlpha( 1 )
	            self.clipFinished( self.Focus, {} )
	        end
	    },

	    Disabled = {
	    	DefaultClip = function()
	    		self:setupElementClipCounter( 2 )

	    		self.Selected:completeAnimation()
	    		self.Selected:setRGB( 1, 0, 0 )
	    		self.Selected:setAlpha( 1 )
	    		self.clipFinished( self.Selected, {} )

	    		self.Focus:completeAnimation()
	    		self.Focus:setAlpha( 0 )
	    		self.clipFinished( self.Focus, {} )
	    	end,

	    	Focus = function()
	    		self:setupElementClipCounter( 2 )

	    		self.Selected:completeAnimation()
	    		self.Selected:setRGB( 1, 0, 0 )
	    		self.Selected:setAlpha( 1 )
	    		self.clipFinished( self.Selected, {} )

	    		self.Focus:completeAnimation()
	    		self.Focus:setAlpha( 1 )
	    		self.clipFinished( self.Focus, {} )
	    	end
	    }
	}

    self:mergeStateConditions( {
    	{
	        stateName = "Disabled",
	        condition = function ( menu, element, event )
	            local index = ( element.gridInfoTable and element.gridInfoTable.zeroBasedIndex + 1 ) or 1
	            local model = Engine.GetModel( Engine.GetModelForController( controller ), "Powerup_Selections.disabled" .. index )
	            return model and Engine.GetModelValue( model ) == true
	        end
	    },
        {
            stateName = "Selected",
            condition = function ( menu, element, event )
                local index = ( element.gridInfoTable and element.gridInfoTable.zeroBasedIndex + 1 ) or 1
                local model = Engine.GetModel( Engine.GetModelForController( controller ), "Powerup_Selections.slot" .. index )
                return model and Engine.GetModelValue( model ) == true
            end
        }
    } )
	
	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.Selected:close()
		element.Image:close()
		element.Focus:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end