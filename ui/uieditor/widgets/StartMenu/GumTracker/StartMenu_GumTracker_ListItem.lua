require( "ui.uieditor.widgets.CAC.GridItemBGBGlow" )
require( "ui.uieditor.widgets.CAC.GridItemConsumableLabel" )

local PostLoadFunc = function( self, controller, menu )
    self:addElement( LUI.UITimer.newElementTimer( 10, true, function()
        local slotNum = self.myManualIndex or ( self.gridInfoTable and self.gridInfoTable.zeroBasedIndex + 1 ) or 1
        local model = Engine.GetModel( Engine.GetModelForController( controller ), "BGB_Selections.slot" .. slotNum )
        if model then
            self:subscribeToModel( model, function( model )
                self:processEvent( { name = "update_state", menu = menu } )
            end )
        end
    end ) )

    self:registerEventHandler( "button_action", function( element, event )
        local controllerModel = Engine.GetModelForController( controller )
        local slotNum = element.myManualIndex or ( element.gridInfoTable and element.gridInfoTable.zeroBasedIndex + 1 ) or 1
        local model = Engine.GetModel( controllerModel, "BGB_Selections.slot" .. slotNum )
        
        if model then
            local curr = Engine.GetModelValue( model )
            
            Engine.SetModelValue( model, not curr )
            Engine.PlaySound( "uin_back_mode_select" )

            local selectedCount = 0
            local bgbModel = Engine.GetModel( controllerModel, "BGB_Selections" )
            for i = 1, 5 do
                local slot = Engine.GetModel( bgbModel, "slot" .. i )
                if slot and Engine.GetModelValue( slot ) == true then
                    selectedCount = selectedCount + 1
                end
            end

            if selectedCount >= 5 then
                for i = 1, 5 do
                    local slot = Engine.GetModel( bgbModel, "slot" .. i )
                    if slot then
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

CoD.StartMenu_GumList = InheritFrom( LUI.UIElement )
CoD.StartMenu_GumList.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_GumList )
	self.id = "StartMenu_GumList"
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
	self.Selected:setRGB( 0, 1, 0 )
	self.Selected:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.Selected:setShaderVector( 0, 0.3, 0.3, 0.3, 0.3 )
	self:addElement( self.Selected )

	self.BubbleGumBuffImage = LUI.UIImage.new()
	self.BubbleGumBuffImage:setLeftRight( false, false, -32, 32 )
	self.BubbleGumBuffImage:setTopBottom( true, false, 0, 64 )
	self.BubbleGumBuffImage:setScale( 0.9 )
	self:addElement( self.BubbleGumBuffImage )

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
	            self.Selected:setAlpha( 0 )
	            self.clipFinished( self.Selected, {} )

	            self.Focus:completeAnimation()
	            self.Focus:setAlpha( 0 )
	            self.clipFinished( self.Focus, {} )
	        end,

	        Focus = function ()
	            self:setupElementClipCounter( 2 )

	            self.Selected:completeAnimation()
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
	            self.Selected:setAlpha( 1 )
	            self.clipFinished( self.Selected, {} )

	            self.Focus:completeAnimation()
	            self.Focus:setAlpha( 0 )
	            self.clipFinished( self.Focus, {} )
	        end,

	        Focus = function ()
	            self:setupElementClipCounter( 2 )

	            self.Selected:completeAnimation()
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
	        stateName = "Selected",
	        condition = function ( menu, element, event )
	            local slotNum = element.myManualIndex or ( element.gridInfoTable and element.gridInfoTable.zeroBasedIndex + 1 )  or 1
	            local model = Engine.GetModel( Engine.GetModelForController( controller ), "BGB_Selections.slot" .. slotNum )
	            local val = model and Engine.GetModelValue( model )
	            return val == true
	        end
	    }
	} )
	
	self.BubbleGumBuffImage:linkToElementModel( self, "itemIndex", true, function ( model )
		local itemIndex = Engine.GetModelValue( model )
		if itemIndex then
			self.BubbleGumBuffImage:setImage( RegisterImage( GetItemImageFromIndex( itemIndex ) ) )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.Selected:close()
		element.BubbleGumBuffImage:close()
		element.Focus:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end