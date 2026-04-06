require( "ui.uieditor.widgets.HUD.UIColors" )
require( "ui.uieditor.widgets.HUD.core_AmmoWidget.AmmoWidgetMP_EquipGlow" )
require( "ui.uieditor.widgets.HUD.T7.ZM_AmmoWidgetFactory.ZmAmmo_EquipTacFactory" )

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        local colorName = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"]
        local elements = { self.LethalGlow, self.TacticalGlow, self.LethalGlowTop, self.TacticalGlowTop, self.TacticalRing, self.LethalRing }

        for _, element in ipairs( elements ) do
            if element then
                element:completeAnimation()
                element:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
                CoD.UIColors.SetElementColor( element, colorName )

                if element.Image0 then
                    element.Image0:completeAnimation()
                    element.Image0:beginAnimation( "keyframe", 1000, false, false, CoD.TweenType.Linear )
                    CoD.UIColors.SetElementColor( element.Image0, colorName )
                end
            end
        end
    end

    local colorUpdateModel = Engine.CreateModel( Engine.GetModelForController( controller ), "colorUpdate" )
    self:subscribeToModel( colorUpdateModel, function( model )
        self:UpdateColors()
    end )
    
    self:UpdateColors()
end

CoD.ZmAmmo_EquipContainerFactory = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_EquipContainerFactory.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_EquipContainerFactory )
	self.id = "ZmAmmo_EquipContainerFactory"
	self.soundSet = "HUD"
	self:setLeftRight( true, false, 0, 72 )
	self:setTopBottom( true, false, 0, 51 )
	self.anyChildUsesUpdateState = true
	
	self.LethalGlow = CoD.AmmoWidgetMP_EquipGlow.new( menu, controller )
	self.LethalGlow:setLeftRight( true, false, 24.84, 72.99 )
	self.LethalGlow:setTopBottom( true, false, 4.07, 52.22 )
	self.LethalGlow:setAlpha( 0.5 )
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
	self.TacticalGlow:setAlpha( 0.5 )
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
	
	self.LethalGlowTop = CoD.AmmoWidgetMP_EquipGlow.new( menu, controller )
	self.LethalGlowTop:setLeftRight( true, false, 30.85, 65.65 )
	self.LethalGlowTop:setTopBottom( true, false, 1, 49.15 )
	self.LethalGlowTop:setAlpha( 0.5 )
	self.LethalGlowTop.Image0:setRGB( 0, 0.35, 0.58 )
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
	
	self.TacticalGlowTop = CoD.AmmoWidgetMP_EquipGlow.new( menu, controller )
	self.TacticalGlowTop:setLeftRight( true, false, 6.65, 41.44 )
	self.TacticalGlowTop:setTopBottom( true, false, 2, 50.15 )
	self.TacticalGlowTop:setAlpha( 0.5 )
	self.TacticalGlowTop.Image0:setRGB( 0, 0.35, 0.58 )
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
	
	self.TacticalRing = LUI.UIImage.new()
	self.TacticalRing:setLeftRight( true, false, 4.65, 40.65 )
	self.TacticalRing:setTopBottom( true, false, 7.07, 43.07 )
	self.TacticalRing:setRGB( 0.19, 0.99, 0.96 )
	self.TacticalRing:setAlpha( 0 )
	self.TacticalRing:setImage( RegisterImage( "uie_t7_zm_hud_ammo_elminvcrc" ) )
	self.TacticalRing:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.TacticalRing )
	
	self.LethalRing = LUI.UIImage.new()
	self.LethalRing:setLeftRight( true, false, 27.65, 63.65 )
	self.LethalRing:setTopBottom( true, false, 7.07, 43.07 )
	self.LethalRing:setRGB( 0.19, 0.99, 0.96 )
	self.LethalRing:setAlpha( 0 )
	self.LethalRing:setImage( RegisterImage( "uie_t7_zm_hud_ammo_elminvcrc" ) )
	self.LethalRing:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.LethalRing )
	
	self.TacticalItem = CoD.ZmAmmo_EquipTacFactory.new( menu, controller )
	self.TacticalItem:setLeftRight( true, false, 7.15, 44.15 )
	self.TacticalItem:setTopBottom( true, false, 4.07, 36.07 )
	self.TacticalItem:setRGB( 1, 0.99, 0.93 )
	self.TacticalItem:setAlpha( 0.79 )
	self.TacticalItem:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "uie_aberration" ) )
	self.TacticalItem:setShaderVector( 0, 0.2, 0, 0, 0 )
	self.TacticalItem:setShaderVector( 1, 0, 0, 0, 0 )
	self.TacticalItem:setShaderVector( 2, 0, 0, 0, 0 )
	self.TacticalItem:setShaderVector( 3, 0, 0, 0, 0 )
	self.TacticalItem:setShaderVector( 4, 0, 0, 0, 0 )
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
	
	self.LethalItem = CoD.ZmAmmo_EquipTacFactory.new( menu, controller )
	self.LethalItem:setLeftRight( true, false, 37.15, 74.15 )
	self.LethalItem:setTopBottom( true, false, 3.82, 35.82 )
	self.LethalItem:setRGB( 1, 0.99, 0.93 )
	self.LethalItem:setAlpha( 0.79 )
	self.LethalItem:setRFTMaterial( LUI.UIImage.GetCachedMaterial( "uie_aberration" ) )
	self.LethalItem:setShaderVector( 0, 0.2, 0, 0, 0 )
	self.LethalItem:setShaderVector( 1, 0, 0, 0, 0 )
	self.LethalItem:setShaderVector( 2, 0, 0, 0, 0 )
	self.LethalItem:setShaderVector( 3, 0, 0, 0, 0 )
	self.LethalItem:setShaderVector( 4, 0, 0, 0, 0 )
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
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 0 )
			end
		},

		OffsetLeft = {
			DefaultClip = function ()
				self:setupElementClipCounter( 10 )

				self.LethalGlow:completeAnimation()
				self.LethalGlow:setLeftRight( true, false, 14.84, 62.99 )
				self.LethalGlow:setTopBottom( true, false, 4.07, 52.22 )
				self.clipFinished( self.LethalGlow, {} )

				self.TacticalGlow:completeAnimation()
				self.TacticalGlow:setLeftRight( true, false, -8, 40.15 )
				self.TacticalGlow:setTopBottom( true, false, 2, 50.15 )
				self.clipFinished( self.TacticalGlow, {} )

				self.LethalGlowTop:completeAnimation()
				self.LethalGlowTop:setLeftRight( true, false, 20.85, 55.65 )
				self.LethalGlowTop:setTopBottom( true, false, 1, 49.15 )
				self.clipFinished( self.LethalGlowTop, {} )

				self.TacticalGlowTop:completeAnimation()
				self.TacticalGlowTop:setLeftRight( true, false, -3.35, 31.44 )
				self.TacticalGlowTop:setTopBottom( true, false, 2, 50.15 )
				self.clipFinished( self.TacticalGlowTop, {} )

				self.TacticalRing:completeAnimation()
				self.TacticalRing:setLeftRight( true, false, 4.65, 40.65 )
				self.TacticalRing:setTopBottom( true, false, 0.07, 36.07 )
				self.clipFinished( self.TacticalRing, {} )

				self.LethalRing:completeAnimation()
				self.LethalRing:setLeftRight( true, false, 27.65, 63.65 )
				self.LethalRing:setTopBottom( true, false, 0.07, 36.07 )
				self.clipFinished( self.LethalRing, {} )

				self.TacticalItem:completeAnimation()
				self.TacticalItem:setLeftRight( true, false, -2.85, 34.15 )
				self.TacticalItem:setTopBottom( true, false, 4.07, 36.07 )
				self.clipFinished( self.TacticalItem, {} )

				self.LethalItem:completeAnimation()
				self.LethalItem:setLeftRight( true, false, 27.15, 64.15 )
				self.LethalItem:setTopBottom( true, false, 3.82, 35.82 )
				self.clipFinished( self.LethalItem, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.LethalGlow:close()
		element.TacticalGlow:close()
		element.LethalGlowTop:close()
		element.TacticalGlowTop:close()
		element.TacticalItem:close()
		element.LethalItem:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end