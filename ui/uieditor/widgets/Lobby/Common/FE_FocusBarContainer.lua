require( "ui.uieditor.widgets.HUD.UIColors" )
require( "ui.uieditor.util.PCUtil_Options" )

local PostLoadFunc = function( self, controller, menu )
    self.UpdateColors = function( self )
        local color = "orange" 
        
        if CoD.PCUtil and CoD.PCUtil.GameOptions and CoD.PCUtil.GameOptions[controller] then
            color = CoD.PCUtil.GameOptions[controller]["colorSettings_UI"] or "orange"
        end

        local modelValue = Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "colorSettings_UI" ) )
        if modelValue and modelValue ~= "" then
            color = modelValue
        end

        CoD.UIColors.SetElementColor( self.FEFocusBarSolid, color )
        CoD.UIColors.SetElementColor( self.Glow2, color )
        CoD.UIColors.SetElementColor( self.FEFocusBarAdd, color )
    end

    local controllerModel = Engine.GetModelForController( controller )
    
    self:subscribeToModel( Engine.CreateModel( controllerModel, "colorSettings_UI" ), function( model )
        self:UpdateColors()
    end )
    
    self:subscribeToModel( Engine.CreateModel( controllerModel, "colorUpdate" ), function( model )
        self:UpdateColors()
    end )

    self:UpdateColors()
end

CoD.FE_FocusBarContainer = InheritFrom( LUI.UIElement )
CoD.FE_FocusBarContainer.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.FE_FocusBarContainer )
	self.id = "FE_FocusBarContainer"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 96 )
	self:setTopBottom( true, false, 0, 8 )
	
	self.FEFocusBarSolid = LUI.UIImage.new()
	self.FEFocusBarSolid:setLeftRight( true, true, 0, 0 )
	self.FEFocusBarSolid:setTopBottom( false, false, -4, 4 )
	self.FEFocusBarSolid:setRGB( 0, 0, 0 )
	self.FEFocusBarSolid:setAlpha( 0 )
	self.FEFocusBarSolid:setImage( RegisterImage( "uie_t7_menu_frontend_barfocussolidfull" ) )
	self.FEFocusBarSolid:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_nineslice_normal" ) )
	self.FEFocusBarSolid:setShaderVector( 0, 0.04, 0.5, 0, 0 )
	self.FEFocusBarSolid:setupNineSliceShader( 4, 4 )
	self:addElement( self.FEFocusBarSolid )
	
	self.Glow2 = LUI.UIImage.new()
	self.Glow2:setLeftRight( true, true, -31, 37 )
	self.Glow2:setTopBottom( true, false, -3.21, 11.21 )
	self.Glow2:setRGB( 1, 0.99, 0 )
	self.Glow2:setAlpha( 0.7 )
	self.Glow2:setImage( RegisterImage( "uie_t7_cp_hud_enemytarget_glow" ) )
	self.Glow2:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_add" ) )
	self:addElement( self.Glow2 )
	
	self.FEFocusBarAdd = LUI.UIImage.new()
	self.FEFocusBarAdd:setLeftRight( true, true, 0, 0 )
	self.FEFocusBarAdd:setTopBottom( false, false, -4, 4 )
	self.FEFocusBarAdd:setRGB( 1, 0.9, 0.8 )
	self.FEFocusBarAdd:setAlpha( 0 )
	self.FEFocusBarAdd:setImage( RegisterImage( "uie_t7_menu_frontend_barfocusfull" ) )
	self.FEFocusBarAdd:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_nineslice_add" ) )
	self.FEFocusBarAdd:setShaderVector( 0, 0.04, 0.9, 0, 0 )
	self.FEFocusBarAdd:setupNineSliceShader( 4, 4 )
	self:addElement( self.FEFocusBarAdd )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 1 )

				local Glow2Frame2 = function ( element, event )
					local Glow2Frame3 = function ( element, event )
						if not event.interrupted then
							element:beginAnimation( "keyframe", 319, false, false, CoD.TweenType.Linear )
						end
						element:setAlpha( 0.69 )
						if event.interrupted then
							self.clipFinished( element, event )
						else
							element:registerEventHandler( "transition_complete_keyframe", self.clipFinished )
						end
					end
					
					if event.interrupted then
						Glow2Frame3( element, event )
						return 
					else
						element:beginAnimation( "keyframe", 620, false, false, CoD.TweenType.Linear )
						element:setAlpha( 0.84 )
						element:registerEventHandler( "transition_complete_keyframe", Glow2Frame3 )
					end
				end
				
				self.Glow2:completeAnimation()
				self.Glow2:setAlpha( 0.69 )
				Glow2Frame2( self.Glow2, {} )

				self.nextClip = "DefaultClip"
			end
		}
	}
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end