require( "ui.uieditor.widgets.HUD.core_AmmoWidget.AmmoWidgetMP_EquipGlow" )
require( "ui.uieditor.widgets.HUD.Soe.ZM_AmmoWidget.ZmAmmo_EquipTac" )

local PostLoadFunc = function( self, controller, menu )
	self.UpdateColors = function( self )
        local color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]        
        local elements = {
            self.TacticalRing,
            self.LethalRing,
            self.LethalGlow,
            self.TacticalGlow,
            self.TacticalGlowTop,
			self.LethalGlowTop
        }

        for _, element in ipairs( elements ) do
            if element then
                element:completeAnimation()
                element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
                CoD.UIColors.SetElementColor( element, color )
            end
        end
    end

	local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
end

CoD.ZmAmmo_EquipContainer = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_EquipContainer.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_EquipContainer )
	self.id = "ZmAmmo_EquipContainer"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 72 )
	self:setTopBottom( true, false, 0, 51 )
	self.anyChildUsesUpdateState = true
	
	self.TacticalRing = LUI.UIImage.new()
	self.TacticalRing:setLeftRight( true, false, 4.65, 40.65 )
	self.TacticalRing:setTopBottom( true, false, 7.07, 43.07 )
	CoD.UIColors.SetElementColor( self.TacticalRing, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.TacticalRing:setAlpha( 0.77 )
	self.TacticalRing:setImage( RegisterImage( "uie_t7_zm_hud_ammo_elminvcrc" ) )
	self.TacticalRing:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.TacticalRing )
	
	self.LethalRing = LUI.UIImage.new()
	self.LethalRing:setLeftRight( true, false, 27.65, 63.65 )
	self.LethalRing:setTopBottom( true, false, 7.07, 43.07 )
	CoD.UIColors.SetElementColor( self.LethalRing, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.LethalRing:setAlpha( 0.59 )
	self.LethalRing:setImage( RegisterImage( "uie_t7_zm_hud_ammo_elminvcrc" ) )
	self.LethalRing:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.LethalRing )
	
	self.LethalGlow = CoD.AmmoWidgetMP_EquipGlow.new( menu, controller )
	self.LethalGlow:setLeftRight( true, false, 24.84, 72.99 )
	self.LethalGlow:setTopBottom( true, false, 4.07, 52.22 )
	self.LethalGlow:mergeStateConditions( {
		{
			stateName = "Shown",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThan( controller, "currentPrimaryOffhand.primaryOffhandCount", 0 )
			end
		}
	} )
	self.LethalGlow:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentPrimaryOffhand.primaryOffhandCount" ), function ( model )
		menu:updateElementState( self.LethalGlow, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentPrimaryOffhand.primaryOffhandCount" } )
	end )
	self:addElement( self.LethalGlow )
	
	self.TacticalGlow = CoD.AmmoWidgetMP_EquipGlow.new( menu, controller )
	self.TacticalGlow:setLeftRight( true, false, 2, 50.15 )
	self.TacticalGlow:setTopBottom( true, false, 2, 50.15 )
	self.TacticalGlow:mergeStateConditions( {
		{
			stateName = "Shown",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThan( controller, "currentSecondaryOffhand.secondaryOffhandCount", 0 )
			end
		}
	} )
	self.TacticalGlow:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentSecondaryOffhand.secondaryOffhandCount" ), function ( model )
		menu:updateElementState( self.TacticalGlow, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentSecondaryOffhand.secondaryOffhandCount" } )
	end )
	self:addElement( self.TacticalGlow )
	
	self.TacticalItem = CoD.ZmAmmo_EquipTac.new( menu, controller )
	self.TacticalItem:setLeftRight( true, false, 13.15, 50.15 )
	self.TacticalItem:setTopBottom( true, false, 4.07, 36.07 )
	self.TacticalItem:setRGB( 1, 0.99, 0.93 )
	self.TacticalItem:setAlpha( 0.79 )
	self.TacticalItem:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.TacticalItem:subscribeToGlobalModel( controller, "CurrentSecondaryOffhand", "secondaryOffhand", function ( model )
		local secondaryOffhand = Engine.GetModelValue( model )
		if secondaryOffhand then
			self.TacticalItem.Tactical0:setImage( RegisterImage( secondaryOffhand ) )
		end
	end )
	self.TacticalItem:subscribeToGlobalModel( controller, "CurrentSecondaryOffhand", "secondaryOffhand", function ( model )
		local secondaryOffhand = Engine.GetModelValue( model )
		if secondaryOffhand then
			self.TacticalItem.Tactical1b:setImage( RegisterImage( secondaryOffhand ) )
		end
	end )
	self.TacticalItem:subscribeToGlobalModel( controller, "CurrentSecondaryOffhand", "secondaryOffhand", function ( model )
		local secondaryOffhand = Engine.GetModelValue( model )
		if secondaryOffhand then
			self.TacticalItem.Tactical1:setImage( RegisterImage( secondaryOffhand ) )
		end
	end )
	self.TacticalItem:subscribeToGlobalModel( controller, "CurrentSecondaryOffhand", "secondaryOffhand", function ( model )
		local secondaryOffhand = Engine.GetModelValue( model )
		if secondaryOffhand then
			self.TacticalItem.Tactical2b:setImage( RegisterImage( secondaryOffhand ) )
		end
	end )
	self.TacticalItem:subscribeToGlobalModel( controller, "CurrentSecondaryOffhand", "secondaryOffhand", function ( model )
		local secondaryOffhand = Engine.GetModelValue( model )
		if secondaryOffhand then
			self.TacticalItem.Tactical2:setImage( RegisterImage( secondaryOffhand ) )
		end
	end )
	self.TacticalItem:subscribeToGlobalModel( controller, "CurrentSecondaryOffhand", "secondaryOffhand", function ( model )
		local secondaryOffhand = Engine.GetModelValue( model )
		if secondaryOffhand then
			self.TacticalItem.Tactical3b:setImage( RegisterImage( secondaryOffhand ) )
		end
	end )
	self.TacticalItem:subscribeToGlobalModel( controller, "CurrentSecondaryOffhand", "secondaryOffhand", function ( model )
		local secondaryOffhand = Engine.GetModelValue( model )
		if secondaryOffhand then
			self.TacticalItem.Tactical3:setImage( RegisterImage( secondaryOffhand ) )
		end
	end )
	self.TacticalItem:mergeStateConditions( {
		{
			stateName = "Single",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "currentSecondaryOffhand.secondaryOffhandCount", 1 )
			end
		},
		{
			stateName = "Double",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "currentSecondaryOffhand.secondaryOffhandCount", 2 )
			end
		},
		{
			stateName = "Triple",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "currentSecondaryOffhand.secondaryOffhandCount", 3 )
			end
		},
		{
			stateName = "Quad",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThanOrEqualTo( controller, "currentSecondaryOffhand.secondaryOffhandCount", 4 )
			end
		}
	} )
	self.TacticalItem:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentSecondaryOffhand.secondaryOffhandCount" ), function ( model )
		menu:updateElementState( self.TacticalItem, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentSecondaryOffhand.secondaryOffhandCount" } )
	end )
	self:addElement( self.TacticalItem )
	
	self.LethalItem = CoD.ZmAmmo_EquipTac.new( menu, controller )
	self.LethalItem:setLeftRight( true, false, 37.15, 74.15 )
	self.LethalItem:setTopBottom( true, false, 3.82, 35.82 )
	self.LethalItem:setRGB( 1, 0.99, 0.93 )
	self.LethalItem:setAlpha( 0.79 )
	self.LethalItem:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.LethalItem:subscribeToGlobalModel( controller, "CurrentPrimaryOffhand", "primaryOffhand", function ( model )
		local primaryOffhand = Engine.GetModelValue( model )
		if primaryOffhand then
			self.LethalItem.Tactical0:setImage( RegisterImage( primaryOffhand ) )
		end
	end )
	self.LethalItem:subscribeToGlobalModel( controller, "CurrentPrimaryOffhand", "primaryOffhand", function ( model )
		local primaryOffhand = Engine.GetModelValue( model )
		if primaryOffhand then
			self.LethalItem.Tactical1b:setImage( RegisterImage( primaryOffhand ) )
		end
	end )
	self.LethalItem:subscribeToGlobalModel( controller, "CurrentPrimaryOffhand", "primaryOffhand", function ( model )
		local primaryOffhand = Engine.GetModelValue( model )
		if primaryOffhand then
			self.LethalItem.Tactical1:setImage( RegisterImage( primaryOffhand ) )
		end
	end )
	self.LethalItem:subscribeToGlobalModel( controller, "CurrentPrimaryOffhand", "primaryOffhand", function ( model )
		local primaryOffhand = Engine.GetModelValue( model )
		if primaryOffhand then
			self.LethalItem.Tactical2b:setImage( RegisterImage( primaryOffhand ) )
		end
	end )
	self.LethalItem:subscribeToGlobalModel( controller, "CurrentPrimaryOffhand", "primaryOffhand", function ( model )
		local primaryOffhand = Engine.GetModelValue( model )
		if primaryOffhand then
			self.LethalItem.Tactical2:setImage( RegisterImage( primaryOffhand ) )
		end
	end )
	self.LethalItem:subscribeToGlobalModel( controller, "CurrentPrimaryOffhand", "primaryOffhand", function ( model )
		local primaryOffhand = Engine.GetModelValue( model )
		if primaryOffhand then
			self.LethalItem.Tactical3b:setImage( RegisterImage( primaryOffhand ) )
		end
	end )
	self.LethalItem:subscribeToGlobalModel( controller, "CurrentPrimaryOffhand", "primaryOffhand", function ( model )
		local primaryOffhand = Engine.GetModelValue( model )
		if primaryOffhand then
			self.LethalItem.Tactical3:setImage( RegisterImage( primaryOffhand ) )
		end
	end )
	self.LethalItem:mergeStateConditions( {
		{
			stateName = "Single",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "currentPrimaryOffhand.primaryOffhandCount", 1 )
			end
		},
		{
			stateName = "Double",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "currentPrimaryOffhand.primaryOffhandCount", 2 )
			end
		},
		{
			stateName = "Triple",
			condition = function ( menu, element, event )
				return IsModelValueEqualTo( controller, "currentPrimaryOffhand.primaryOffhandCount", 3 )
			end
		},
		{
			stateName = "Quad",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThanOrEqualTo( controller, "currentPrimaryOffhand.primaryOffhandCount", 4 )
			end
		}
	} )
	self.LethalItem:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentPrimaryOffhand.primaryOffhandCount" ), function ( model )
		menu:updateElementState( self.LethalItem, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentPrimaryOffhand.primaryOffhandCount" } )
	end )
	self:addElement( self.LethalItem )
	
	self.TacticalGlowTop = CoD.AmmoWidgetMP_EquipGlow.new( menu, controller )
	self.TacticalGlowTop:setLeftRight( true, false, 6.65, 41.44 )
	self.TacticalGlowTop:setTopBottom( true, false, 2, 50.15 )
	self.TacticalGlowTop:setAlpha( 0.97 )
	CoD.UIColors.SetElementColor( self.TacticalGlowTop.Image0, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.TacticalGlowTop.Image0:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.TacticalGlowTop:mergeStateConditions( {
		{
			stateName = "Shown",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThan( controller, "currentSecondaryOffhand.secondaryOffhandCount", 0 )
			end
		}
	} )
	self.TacticalGlowTop:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentSecondaryOffhand.secondaryOffhandCount" ), function ( model )
		menu:updateElementState( self.TacticalGlowTop, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentSecondaryOffhand.secondaryOffhandCount" } )
	end )
	self:addElement( self.TacticalGlowTop )
	
	self.LethalGlowTop = CoD.AmmoWidgetMP_EquipGlow.new( menu, controller )
	self.LethalGlowTop:setLeftRight( true, false, 30.85, 65.65 )
	self.LethalGlowTop:setTopBottom( true, false, 1, 49.15 )
	self.LethalGlowTop:setAlpha( 0.97 )
	CoD.UIColors.SetElementColor( self.LethalGlowTop.Image0, CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] )
	self.LethalGlowTop.Image0:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self.LethalGlowTop:mergeStateConditions( {
		{
			stateName = "Shown",
			condition = function ( menu, element, event )
				return IsModelValueGreaterThan( controller, "currentPrimaryOffhand.primaryOffhandCount", 0 )
			end
		}
	} )
	self.LethalGlowTop:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "currentPrimaryOffhand.primaryOffhandCount" ), function ( model )
		menu:updateElementState( self.LethalGlowTop, { name = "model_validation", menu = menu, modelValue = Engine.GetModelValue( model ), modelName = "currentPrimaryOffhand.primaryOffhandCount" } )
	end )
	self:addElement( self.LethalGlowTop )
	
	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.LethalGlow:close()
		element.TacticalGlow:close()
		element.TacticalItem:close()
		element.LethalItem:close()
		element.TacticalGlowTop:close()
		element.LethalGlowTop:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end