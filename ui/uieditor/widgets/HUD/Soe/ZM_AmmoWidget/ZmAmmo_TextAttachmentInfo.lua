local HideAttachments = function( element )
	element:setState( "Collapsed" )
end

local UpdateAttachmentText = function( self, slot1, slot2, slot3 )
	local combinedText = ""
	local activeCount = 0

	if slot1 and slot1 ~= "" then
		combinedText = Engine.Localize( slot1 )
		activeCount = activeCount + 1
	end
	
	if slot2 and slot2 ~= "" then
		local localized = Engine.Localize( slot2 )
		combinedText = ( combinedText == "" ) and localized or ( combinedText .. " + " .. localized )
		activeCount = activeCount + 1
	end

	if slot3 and slot3 ~= "" then
		local localized = Engine.Localize( slot3 )
		combinedText = ( combinedText == "" ) and localized or ( combinedText .. " + " .. localized )
		activeCount = activeCount + 1
	end

	self:setState( "DefaultState" )
	self.Attachments:setText( combinedText )

	if self.collapseTimer then
		self.collapseTimer:close()
	end

	if activeCount > 0 then
		self.collapseTimer = LUI.UITimer.new( 3000, "start_collapse", true, self )
		self:addElement( self.collapseTimer )
	end
end

local PostLoadFunc = function( self, controller, menu )
	self.UpdateAttachments = UpdateAttachmentText
	self:registerEventHandler( "start_collapse", HideAttachments )
end

CoD.ZmAmmo_TextAttachmentInfo = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_TextAttachmentInfo.new = function ( menu, controller )
	local self = LUI.UIHorizontalList.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = 5
	} )
	self:setAlignment( LUI.Alignment.Right )

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.ZmAmmo_TextAttachmentInfo )
	self.id = "ZmAmmo_TextAttachmentInfo"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 296 )
	self:setTopBottom( true, false, 0, 18 )
	
	self.Attachments = LUI.UITightText.new()
	self.Attachments:setLeftRight( false, true, -115.5, 0 )
	self.Attachments:setTopBottom( false, true, -20, 0 )
	self.Attachments:setText( Engine.Localize( "Attachments here" ) )
	self.Attachments:setTTF( "fonts/RefrigeratorDeluxe-Regular.ttf" )
	self.Attachments:setLetterSpacing( 0.5 )
	self:addElement( self.Attachments )
	
	self.WeaponNameStrokeLbl = LUI.UITightText.new()
	self.WeaponNameStrokeLbl:setLeftRight( false, true, -235.5, -120.5 )
	self.WeaponNameStrokeLbl:setTopBottom( false, true, -20, 0 )
	self.WeaponNameStrokeLbl:setTTF( "fonts/RefrigeratorDeluxe-Regular.ttf" )
	self.WeaponNameStrokeLbl:setMaterial( LUI.UIImage.GetCachedMaterial( "sw4_2d_uie_font_cached_glow" ) )
	self.WeaponNameStrokeLbl:setShaderVector( 0, 0, 0, 0, 0 )
	self.WeaponNameStrokeLbl:setShaderVector( 1, 0, 0, 0, 0 )
	self.WeaponNameStrokeLbl:setShaderVector( 2, 1, 0, 0, 0 )
	self.WeaponNameStrokeLbl:setLetterSpacing( 0.5 )
	self.WeaponNameStrokeLbl:subscribeToGlobalModel( controller, "CurrentWeapon", "weaponName", function ( model )
		local weaponName = Engine.GetModelValue( model )
		if weaponName then
			self.WeaponNameStrokeLbl:setText( Engine.Localize( weaponName ) )
		end
	end )
	self:addElement( self.WeaponNameStrokeLbl )
	
	self.clipsPerState = {
		DefaultState = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.Attachments:completeAnimation()
				self.Attachments:setAlpha( 1 )
				self.clipFinished( self.Attachments, {} )

				self.WeaponNameStrokeLbl:completeAnimation()
				self.WeaponNameStrokeLbl:setAlpha( 1 )
				self.clipFinished( self.WeaponNameStrokeLbl, {} )
			end
		},

		Collapsed = {
			DefaultClip = function ()
				self:setupElementClipCounter( 2 )

				self.Attachments:completeAnimation()
				self.Attachments:setAlpha( 0 )
				self.clipFinished( self.Attachments, {} )

				self.WeaponNameStrokeLbl:completeAnimation()
				self.WeaponNameStrokeLbl:setAlpha( 1 )
				self.clipFinished( self.WeaponNameStrokeLbl, {} )
			end
		}
	}

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.WeaponNameStrokeLbl:close()
		if element.collapseTimer then
			element.collapseTimer:close()
		end
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end