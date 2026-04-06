require( "ui.uieditor.widgets.Lobby.Common.FE_ButtonPanelShaderContainer" )
require( "ui.uieditor.widgets.CAC.Customization.CustomizationItem_ND" )
require( "ui.uieditor.widgets.Scrollbars.verticalCounter" )
require( "ui.uieditor.widgets.CAC.GridItemButtonBackdropSymbols" )
require( "ui.uieditor.widgets.CAC.cac_3dTitleIntermediary" )
require( "ui.uieditor.widgets.CAC.cac_ElemsSideList" )
require( "ui.uieditor.widgets.CAC.BlackMarketItemDescription" )
require( "ui.uieditor.widgets.CAC.MenuSelectScreen.WeaponNameWidget" )
require( "ui.uieditor.widgets.BackgroundFrames.GenericMenuFrame" )
require( "ui.uieditor.widgets.Lobby.Common.FE_TabBar" )
require( "ui.uieditor.widgets.TabbedWidgets.WeaponGroupsTabWidget" )
require( "ui.uieditor.widgets.PC.Utility.XCamMouseControl" )
require( "ui.uieditor.widgets.CAC.cac_LockBig" )

DataSources.XcDylanCACCustomizationTabs = DataSourceHelpers.ListSetup( "XcDylanCACCustomizationTabs", function( controller )
    local tabList = {}
    
    local isGunsmith = CoD.perController[controller].gunsmithCamoIndexModel
    local isEditingBuildKit = CoD.perController[controller].editingWeaponBuildKits
    
    local isNotEditingKit = false
    if isGunsmith then
        isNotEditingKit = not isEditingBuildKit
    end

    local weaponIndex = CoD.CACUtility.EmptyItemIndex
    if isGunsmith or CoD.perController[controller].gunsmithReticleIndexModel or isEditingBuildKit then
        weaponIndex = CoD.GetCustomization( controller, "weapon_index" )
    else
        weaponIndex = CoD.CACUtility.GetItemEquippedInSlot( CoD.perController[controller].weaponCategory, controller, CoD.perController[controller].classModel )
    end

    local sessionMode = Engine.CurrentSessionMode()
    local weaponRef = ""
    if sessionMode < Enum.eModes.MODE_COUNT then
        weaponRef = Engine.GetItemRef( weaponIndex, sessionMode )
    else
        weaponRef = Engine.GetItemRef( weaponIndex, Enum.eModes.MODE_MULTIPLAYER )
    end

    local addTab = function( name, filterEnum )
        local isSelected = false
        
        if filterEnum < Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_MODE_COUNT then
            if filterEnum == sessionMode then
                isSelected = not isNotEditingKit
            end
        end

        table.insert( tabList, {
            models = { tabName = name, tabIcon = "", breadcrumbCount = 0 },
            properties = { filterEnum = filterEnum, filterString = CoD.WeaponOptionFilterToString( filterEnum ), selectIndex = isSelected }
        } )
    end

    table.insert( tabList, {
        models = { tabIcon = CoD.buttonStrings.shoulderl },
        properties = { m_mouseDisabled = true }
    } )

    if CoD.perController[controller].customizationType == Enum.eWeaponOptionGroup.WEAPONOPTION_GROUP_RETICLE then
        addTab( "MENU_CAMPAIGN_CAPS", Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_CP )
        addTab( "MENU_MULTIPLAYER_CAPS", Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_MP )
        addTab( "MENU_ZOMBIES_CAPS", Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_ZM )
        
        if IsLive() then
            addTab( "MENU_BLACK_MARKET", Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_BM )
        end
    else
        addTab( "XcDylan93", Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_CP )
        addTab( "Multiplayer", Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_MP )
        addTab( "Zombies", Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_ZM )
        addTab( "PayToWin", Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_BM )
        addTab( "Extras", Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_EXTRAS )
    end

    table.insert( tabList, {
        models = { tabIcon = CoD.buttonStrings.shoulderr },
        properties = { m_mouseDisabled = true }
    } )

    return tabList
end, false )

local PreLoadFunc = function( self, controller )
    CoD.perController[controller].customizationType = Enum.eWeaponOptionGroup.WEAPONOPTION_GROUP_CAMO
    
    local camoModel = CoD.perController[controller].gunsmithCamoIndexModel
    self:setModel( camoModel )
    
    local camoValue = Engine.GetModelValue( camoModel )
    local variantModel = CoD.perController[controller].gunsmithVariantModel
    local weaponIndex = CoD.GetCustomization( controller, "weapon_index" )
    local weaponRef = Engine.GetItemRef( weaponIndex, Enum.eModes.MODE_MULTIPLAYER )
    
    local weaponAttachments = CoD.CraftUtility.Gunsmith.GetWeaponPlusAttachmentsForVariant( controller, variantModel )
    local modeAbbr = CoD.CraftUtility.GetModeAbbreviation()
    local loadoutSlot = CoD.CraftUtility.GetLoadoutSlot( controller )
    
    local storeRoot = Engine.CreateModel( Engine.GetModelForController( controller ), "StoreRoot" )
    Engine.CreateModel( storeRoot, "InventoryItemPurchaseSuccessful" )
end

local OnTabChanged = function( element, tabData, controller )
    if element.selectionList and tabData.filterString then
        DataSources.GunsmithWeaponOptions.setCurrentFilterItem( "camo" .. "_" .. tabData.filterString )
        element.selectionList:updateDataSource()
        element.selectionList:setActiveItem( element.selectionList:getItemAt(1) )
    end
end

local PostLoadFunc = function( self, controller )
    local weaponIndex = CoD.GetCustomization( controller, "weapon_index" )
    
    CoD.GunsmithWeaponOptionsTable = {}
    CoD.GunsmithWeaponOptionsTable = CoD.GetGunsmithWeaponOptionsTable( controller, CoD.GunsmithWeaponOptionsTable, Enum.eWeaponOptionGroup.WEAPONOPTION_GROUP_CAMO, weaponIndex, 0, true )
    
    self.tabChanged = OnTabChanged
    
    local currentMode = Engine.CurrentSessionMode()
    if currentMode == Enum.eModes.MODE_INVALID then
        currentMode = Enum.eModes.MODE_CAMPAIGN
    end
    
    local defaultCategory = "camo"
    local filterString = CoD.WeaponOptionFilterToString( currentMode )
    
    local startingTab = self.categoryTabs.Tabs.grid:findItem( nil, { filterEnum = currentMode }, false, false )
    if startingTab then
        self.categoryTabs.Tabs.grid:setActiveItem( startingTab )
    else
        local fallbackTab = self.categoryTabs.Tabs.grid:getItemAt(2)
        self.categoryTabs.Tabs.grid:setActiveItem( fallbackTab )
        filterString = CoD.WeaponOptionFilterToString( fallbackTab.filterEnum )
    end
    
    for filterIndex = Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_FIRST, Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_COUNT - 1 do
        local tabItem = self.categoryTabs.Tabs.grid:findItem( nil, { filterEnum = filterIndex }, false, false )
        if tabItem then
            local camoOptionType = CoD.CACUtility.GetWeaponOptionTypeForName( "camo" )
            local breadcrumbModel = tabItem:getModel( controller, "breadcrumbCount" )
            
            if breadcrumbModel then
                if filterIndex < Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_MODE_COUNT then
                    Engine.SetModelValue( breadcrumbModel, Engine.WeaponOptionNewItemCount( controller, weaponIndex, camoOptionType, tabItem.filterEnum ) )
                else
                    Engine.SetModelValue( breadcrumbModel, Engine.WeaponOptionNewModeAgnosticItemCount( controller, weaponIndex, camoOptionType, tabItem.filterEnum ) )
                end
            end
        end
    end
    
    DataSources.GunsmithWeaponOptions.setCurrentFilterItem( defaultCategory .. "_" .. filterString )
    self.selectionList:updateDataSource()
    
    self.originalOcclusionChange = self.m_eventHandlers.occlusion_change
    self:registerEventHandler( "occlusion_change", function( element, event )
        if not event.occluded and event.occludedBy and event.occludedBy.id == "Menu.PurchaseInventoryItemComplete" then
            CoD.GunsmithWeaponOptionsTable = {}
            CoD.GunsmithWeaponOptionsTable = CoD.GetGunsmithWeaponOptionsTable( controller, CoD.GunsmithWeaponOptionsTable, Enum.eWeaponOptionGroup.WEAPONOPTION_GROUP_CAMO )
            
            ForceNotifyControllerModel( controller, "StoreRoot.InventoryItemPurchaseSuccessful" )
            
            local extrasTab = element.categoryTabs.Tabs.grid:findItem( nil, { filterEnum = Enum.WeaponOptionFilter.WEAPONOPTION_FILTER_EXTRAS }, false, false )
            if extrasTab then
                local currentWeapon = CoD.GetCustomization( controller, "weapon_index" )
                local camoType = CoD.CACUtility.GetWeaponOptionTypeForName( "camo" )
                Engine.SetModelValue( extrasTab:getModel( controller, "breadcrumbCount" ), Engine.WeaponOptionNewModeAgnosticItemCount( controller, currentWeapon, camoType, extrasTab.filterEnum ) )
            end
        end
        element:originalOcclusionChange( event )
    end )
end

LUI.createMenu.GunsmithCamoSelect = function( controller )
	local self = CoD.Menu.NewForUIEditor( "GunsmithCamoSelect" )

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self.soundSet = "default"
	self:setOwner( controller )
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, true, 0, 0 )
	self:playSound( "menu_open", controller )
	self.buttonModel = Engine.CreateModel( Engine.GetModelForController( controller ), "GunsmithCamoSelect.buttonPrompts" )
	self.anyChildUsesUpdateState = true
	
	local LeftPanel = CoD.FE_ButtonPanelShaderContainer.new( self, controller )
	LeftPanel:setLeftRight( true, false, 64, 427 )
	LeftPanel:setTopBottom( true, false, 126, 720 )
	LeftPanel:setRGB( 0.5, 0.5, 0.5 )
	self:addElement( LeftPanel )
	self.LeftPanel = LeftPanel
	
	local selectionList = LUI.UIList.new( self, controller, 8, 0, nil, true, false, 0, 0, false, false )
	selectionList:makeFocusable()
	selectionList:setLeftRight( true, false, 74.5, 414.5 )
	selectionList:setTopBottom( true, false, 137, 593 )
	selectionList:setWidgetType( CoD.CustomizationItem_ND )
	selectionList:setHorizontalCount( 3 )
	selectionList:setVerticalCount( 4 )
	selectionList:setSpacing( 8 )
	selectionList:setVerticalCounter( CoD.verticalCounter )
	selectionList:setDataSource( "GunsmithWeaponOptions" )
	selectionList:linkToElementModel( selectionList, "isPackage", true, function( model )
		CoD.Menu.UpdateButtonShownState( selectionList, self, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS )
	end )
	selectionList:linkToElementModel( selectionList, "itemIndex", true, function( model )
		CoD.Menu.UpdateButtonShownState( selectionList, self, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS )
	end )
	selectionList:linkToElementModel( selectionList, "isBMClassified", true, function( model )
		CoD.Menu.UpdateButtonShownState( selectionList, self, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS )
	end )
	selectionList:registerEventHandler( "list_item_gain_focus", function( element, event )
		if Gunsmith_IsCamoNew( self, element, controller ) then
			Gunsmith_SetWeaponOptionAsOld( self, element, controller )
			UpdateSelfElementState( self, element, controller )
			Gunsmith_FocusCamo( self, element, controller )
		else
			Gunsmith_FocusCamo( self, element, controller )
		end
		return nil
	end )
	selectionList:registerEventHandler( "gain_focus", function( element, event )
		local result = nil
		if element.gainFocus then
			result = element:gainFocus( event )
		elseif element.super.gainFocus then
			result = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, self, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS )
		return result
	end )
	selectionList:registerEventHandler( "lose_focus", function( element, event )
		local result = nil
		if element.loseFocus then
			result = element:loseFocus( event )
		elseif element.super.loseFocus then
			result = element.super:loseFocus( event )
		end
		return result
	end )
	self:AddButtonCallbackFunction( selectionList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function( element, menu, controller, model )
		if IsSelfModelValueTrue( element, controller, "isPackage" ) then
			OpenBuyInventoryItemDialog( self, element, controller, "CamoBlacksmith" )
			return true
		elseif not IsGunsmithItemWeaponOptionLocked( menu, element, controller ) and not IsSelfModelValueTrue( element, controller, "isBMClassified" ) then
			Gunsmith_SelectCamo( self, element, controller )
			GoBack( self, controller )
			ClearMenuSavedState( menu )
			return true
		end
	end, function( element, menu, controller )
		if IsSelfModelValueTrue( element, controller, "isPackage" ) then
			CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT" )
			return true
		elseif not IsGunsmithItemWeaponOptionLocked( menu, element, controller ) and not IsSelfModelValueTrue( element, controller, "isBMClassified" ) then
			CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT" )
			return true
		else
			return false
		end
	end, false )
	selectionList:subscribeToGlobalModel( controller, "PerController", "StoreRoot.InventoryItemPurchaseSuccessful", function( model )
		UpdateDataSource( self, selectionList, controller )
	end )
	selectionList:mergeStateConditions( {
		{
			stateName = "Equipped",
			condition = function( menu, element, event )
				return Gunsmith_IsCamoEquipped( menu, element, controller )
			end
		},
		{
			stateName = "New",
			condition = function( menu, element, event )
				return Gunsmith_IsCamoNew( menu, element, controller )
			end
		},
		{
			stateName = "bmContracts",
			condition = function( menu, element, event )
				return IsGunsmithItemWeaponOptionLocked( menu, element, controller ) and IsSpecialContractCamo( element, controller )
			end
		},
		{
			stateName = "Locked",
			condition = function( menu, element, event )
				return IsGunsmithItemWeaponOptionLocked( menu, element, controller )
			end
		}
	} )
	selectionList:linkToElementModel( selectionList, "isBMClassified", true, function( model )
		self:updateElementState( selectionList, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "isBMClassified" } )
	end )
	selectionList:linkToElementModel( selectionList, "isChallengeClassified", true, function( model )
		self:updateElementState( selectionList, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "isChallengeClassified" } )
	end )
	selectionList:linkToElementModel( selectionList, "isPackage", true, function( model )
		self:updateElementState( selectionList, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "isPackage" } )
	end )
	selectionList:linkToElementModel( selectionList, "itemIndex", true, function( model )
		self:updateElementState( selectionList, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "itemIndex" } )
	end )
	selectionList:linkToElementModel( selectionList, "weaponOptionTypeName", true, function( model )
		self:updateElementState( selectionList, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "weaponOptionTypeName" } )
	end )
	self:addElement( selectionList )
	self.selectionList = selectionList
	
	local GridItemButtonBackdropSymbols = CoD.GridItemButtonBackdropSymbols.new( self, controller )
	GridItemButtonBackdropSymbols:setLeftRight( true, false, 98, 1192.67 )
	GridItemButtonBackdropSymbols:setTopBottom( true, false, 144.5, 601.5 )
	GridItemButtonBackdropSymbols:setAlpha( 0 )
	GridItemButtonBackdropSymbols:setZoom( -7.02 )
	self:addElement( GridItemButtonBackdropSymbols )
	self.GridItemButtonBackdropSymbols = GridItemButtonBackdropSymbols
	
	local cac3dTitleIntermediary0 = CoD.cac_3dTitleIntermediary.new( self, controller )
	cac3dTitleIntermediary0:setLeftRight( true, false, -72, 537 )
	cac3dTitleIntermediary0:setTopBottom( true, false, -4, 142 )
	cac3dTitleIntermediary0:setAlpha( 0 )
	cac3dTitleIntermediary0:subscribeToGlobalModel( controller, "Customization", "weapon_index", function( model )
		local weaponIndex = Engine.GetModelValue( model )
		if weaponIndex then
			cac3dTitleIntermediary0.FE3dTitleContainer0.MenuTitle.TextBox1.Label0:setText( LocalizeWeaponNameIntoString( "MENU_GUNSMITH_CAMO_SELECT_TITLE", "mp", controller, weaponIndex ) )
		end
	end )
	self:addElement( cac3dTitleIntermediary0 )
	self.cac3dTitleIntermediary0 = cac3dTitleIntermediary0
	
	local CategoryListLine0 = LUI.UIImage.new()
	CategoryListLine0:setLeftRight( true, false, -11, 1293 )
	CategoryListLine0:setTopBottom( true, false, 80, 88 )
	CategoryListLine0:setRGB( 0.9, 0.9, 0.9 )
	CategoryListLine0:setImage( RegisterImage( "uie_t7_menu_cac_tabline" ) )
	self:addElement( CategoryListLine0 )
	self.CategoryListLine0 = CategoryListLine0
	
	local ElemsSideList = CoD.cac_ElemsSideList.new( self, controller )
	ElemsSideList:setLeftRight( true, false, 4.13, 72 )
	ElemsSideList:setTopBottom( true, false, -11, 659 )
	self:addElement( ElemsSideList )
	self.ElemsSideList = ElemsSideList
	
	local itemDescription = CoD.BlackMarketItemDescription.new( self, controller )
	itemDescription:setLeftRight( true, false, 448, 832 )
	itemDescription:setTopBottom( true, false, 175, 197 )
	itemDescription.weaponDescTextBox:setText( LocalizeIntoString( "MPUI_BLACKMARKET_ITEM_CLASSIFIED_DESC", "MENU_CAMO" ) )
	itemDescription:mergeStateConditions( {
		{
			stateName = "NotVisible",
			condition = function( menu, element, event )
				return ShouldHideClassifiedDescription( element, controller )
			end
		}
	} )
	itemDescription:linkToElementModel( itemDescription, "ref", true, function( model )
		self:updateElementState( itemDescription, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "ref" } )
	end )
	self:addElement( itemDescription )
	self.itemDescription = itemDescription
	
	local limitedEditionCamoDescription = CoD.BlackMarketItemDescription.new( self, controller )
	limitedEditionCamoDescription:setLeftRight( true, false, 448, 832 )
	limitedEditionCamoDescription:setTopBottom( true, false, 175, 197 )
	limitedEditionCamoDescription.weaponDescTextBox:setText( Engine.Localize( "MPUI_LIMITED_CAMO_ITEM_CLASSIFIED_DESC" ) )
	limitedEditionCamoDescription:mergeStateConditions( {
		{
			stateName = "NotVisible",
			condition = function( menu, element, event )
				return ShouldHideClassifiedLimitedEditionCamoDescription( element, controller )
			end
		}
	} )
	limitedEditionCamoDescription:linkToElementModel( limitedEditionCamoDescription, "ref", true, function( model )
		self:updateElementState( limitedEditionCamoDescription, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "ref" } )
	end )
	self:addElement( limitedEditionCamoDescription )
	self.limitedEditionCamoDescription = limitedEditionCamoDescription
	
	local WeaponNameWidget0 = CoD.WeaponNameWidget.new( self, controller )
	WeaponNameWidget0:setLeftRight( true, false, 449, 782 )
	WeaponNameWidget0:setTopBottom( true, false, 137, 171 )
	WeaponNameWidget0:mergeStateConditions( {
		{
			stateName = "NoText",
			condition = function( menu, element, event )
				return ShouldHideItemWeaponOptionInGunsmith( element, controller )
			end
		}
	} )
	WeaponNameWidget0:linkToElementModel( WeaponNameWidget0, "itemIndex", true, function( model )
		self:updateElementState( WeaponNameWidget0, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "itemIndex" } )
	end )
	self:addElement( WeaponNameWidget0 )
	self.WeaponNameWidget0 = WeaponNameWidget0
	
	local MenuFrame = CoD.GenericMenuFrame.new( self, controller )
	MenuFrame:setLeftRight( true, true, 0, 0 )
	MenuFrame:setTopBottom( true, true, 0, 0 )
	MenuFrame.cac3dTitleIntermediary0.FE3dTitleContainer0.MenuTitle.TextBox1.FeatureIcon.FeatureIcon:setImage( RegisterImage( "uie_t7_mp_icon_header_gunsmith" ) )
	MenuFrame:subscribeToGlobalModel( controller, "Customization", "weapon_index", function( model )
		local weaponIndex = Engine.GetModelValue( model )
		if weaponIndex then
			MenuFrame.titleLabel:setText( LocalizeWeaponNameIntoString( "MENU_GUNSMITH_CAMO_SELECT_TITLE", "mp", controller, weaponIndex ) )
		end
	end )
	MenuFrame:subscribeToGlobalModel( controller, "Customization", "weapon_index", function( model )
		local weaponIndex = Engine.GetModelValue( model )
		if weaponIndex then
			MenuFrame.cac3dTitleIntermediary0.FE3dTitleContainer0.MenuTitle.TextBox1.Label0:setText( LocalizeWeaponNameIntoString( "MENU_GUNSMITH_CAMO_SELECT_TITLE", "mp", controller, weaponIndex ) )
		end
	end )
	self:addElement( MenuFrame )
	self.MenuFrame = MenuFrame
	
	local categoryTabs = CoD.FE_TabBar.new( self, controller )
	categoryTabs:setLeftRight( true, false, 0, 2497 )
	categoryTabs:setTopBottom( true, false, 85, 126 )
	categoryTabs.Tabs.grid:setWidgetType( CoD.WeaponGroupsTabWidget )
	categoryTabs.Tabs.grid:setHorizontalCount( 7 )
	categoryTabs.Tabs.grid:setDataSource( "XcDylanCACCustomizationTabs" )
	categoryTabs:registerEventHandler( "list_active_changed", function( element, event )
		CallCustomElementFunction_Self( self, "tabChanged", element, controller )
		UpdateElementState( self, "WeaponNameWidget0", controller )
		UpdateElementState( self, "progressionInfo", controller )
		UpdateElementState( self, "itemDescription", controller )
		return nil
	end )
	self:addElement( categoryTabs )
	self.categoryTabs = categoryTabs
	
	local XCamMouseControl = CoD.XCamMouseControl.new( self, controller )
	XCamMouseControl:setLeftRight( false, true, -772, 0 )
	XCamMouseControl:setTopBottom( true, true, 223.5, -197.5 )
	self:addElement( XCamMouseControl )
	self.XCamMouseControl = XCamMouseControl
	
	local LockIcon = CoD.cac_LockBig.new( self, controller )
	LockIcon:setLeftRight( false, false, 159, 255 )
	LockIcon:setTopBottom( true, false, 14, 684 )
	LockIcon:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "NotAvailable",
			condition = function( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )

	LockIcon:linkToElementModel( LockIcon, "isBMClassified", true, function( model )
		self:updateElementState( LockIcon, { name = "model_validation", menu = self, modelValue = Engine.GetModelValue( model ), modelName = "isBMClassified" } )
	end )
	self:addElement( LockIcon )
	self.LockIcon = LockIcon
	
	itemDescription:linkToElementModel( selectionList, nil, false, function( model )
		itemDescription:setModel( model, controller )
	end )

	limitedEditionCamoDescription:linkToElementModel( selectionList, nil, false, function( model )
		limitedEditionCamoDescription:setModel( model, controller )
	end )

	WeaponNameWidget0:linkToElementModel( selectionList, nil, false, function( model )
		WeaponNameWidget0:setModel( model, controller )
	end )
	WeaponNameWidget0:linkToElementModel( selectionList, "name", true, function( model )
		local nameValue = Engine.GetModelValue( model )
		if nameValue then
			WeaponNameWidget0.weaponNameLabel:setText( Engine.Localize( nameValue ) )
		end
	end )

	LockIcon:linkToElementModel( selectionList, nil, false, function( model )
		LockIcon:setModel( model, controller )
	end )

	self:registerEventHandler( "menu_loaded", function( element, event )
		ShowHeaderKickerAndIcon( self )
		SetHeadingKickerText( "MENU_PLAY_LOCAL" )
		return element:dispatchEventToChildren( event )
	end )

	self:registerEventHandler( "menu_opened", function( element, event )
		if not IsLAN() then
			SetHeadingKickerText( "MPUI_PUBLIC_MATCH_LOBBY" )
		end
		return element:dispatchEventToChildren( event )
	end )

	self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, nil, function( element, menu, controller, model )
		GoBack( self, controller )
		ClearMenuSavedState( menu )
		SetPerControllerTableProperty( controller, "customizationType", nil )
		return true
	end, function( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBB_PSCIRCLE, "MENU_BACK" )
		return true
	end, false )

	self:AddButtonCallbackFunction( self, controller, Enum.LUIButton.LUI_KEY_RSTICK_PRESSED, nil, function( element, menu, controller, model )
		if CACShowRotatePrompt( self, element, controller ) then
			return true
		end
	end, function( element, menu, controller )
		if CACShowRotatePrompt( self, element, controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_RSTICK_PRESSED, "PLATFORM_EMBLEM_ROTATE_LAYER" )
			return true
		else
			return false
		end
	end, false )

	selectionList.id = "selectionList"
	MenuFrame:setModel( self.buttonModel, controller )
	self:processEvent( { name = "menu_loaded", controller = controller } )
	self:processEvent( { name = "update_state", menu = self } )
	
	if not self:restoreState() then
		self.selectionList:processEvent( { name = "gain_focus", controller = controller } )
	end

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.LeftPanel:close()
		element.selectionList:close()
		element.GridItemButtonBackdropSymbols:close()
		element.cac3dTitleIntermediary0:close()
		element.ElemsSideList:close()
		element.itemDescription:close()
		element.limitedEditionCamoDescription:close()
		element.WeaponNameWidget0:close()
		element.MenuFrame:close()
		element.categoryTabs:close()
		element.XCamMouseControl:close()
		element.LockIcon:close()
		Engine.UnsubscribeAndFreeModel( Engine.GetModel( Engine.GetModelForController( controller ), "GunsmithCamoSelect.buttonPrompts" ) )
	end )

	if PostLoadFunc then
		PostLoadFunc( self, controller )
	end
	
	return self
end