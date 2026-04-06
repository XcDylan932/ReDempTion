require( "ui.T7.Utility.PCUtility" )
require( "ui.uieditor.util.PCUtil_Options" )
require( "ui.uieditor.widgets.PC.StartMenu.Dropdown.OptionDropdown" )
require( "ui.uieditor.widgets.PC.Utility.OptionInfoWidget" )

local wonderWeaponChecks = {
	{ prefix = "tesla_gun", displayName = "Wunderwaffe", profileVar = "GameSettings_WunderwaffeColor" },
	{ prefix = "idgun", displayName = "Apothicon", profileVar = "GameSettings_ApothiconColor" },
    { prefix = "thundergun", displayName = "Thundergun", profileVar = "GameSettings_ThundergunColor" },
    { prefix = "microwavegundw", displayName = "Wavegun", profileVar = "GameSettings_WavegunColor" },
    { prefix = "blundergat", displayName = "Blundergat", profileVar = "GameSettings_MagmagatColor" }
}

local perkNames = {
	["specialty_additionalprimaryweapon"] 	= Engine.Localize( "GAMESETTINGS_PERK_MULEKICK" ),
	["specialty_armorvest"] 				= Engine.Localize( "GAMESETTINGS_PERK_JUGGERNOG" ),
	["specialty_bloodwolf"] 				= Engine.Localize( "GAMESETTINGS_PERK_BLOODWOLF" ),
	["specialty_deadshot"] 					= Engine.Localize( "GAMESETTINGS_PERK_DEADSHOT" ),
	["specialty_doubletap2"] 				= Engine.Localize( "GAMESETTINGS_PERK_DOUBLETAP" ),
	["specialty_electriccherry"] 			= Engine.Localize( "GAMESETTINGS_PERK_ELECTRICCHERRY" ),
	["specialty_fastreload"] 				= Engine.Localize( "GAMESETTINGS_PERK_SPEEDCOLA" ),
	["specialty_phdflopper"] 				= Engine.Localize( "GAMESETTINGS_PERK_PHDFLOPPER" ),
	["specialty_quickrevive"] 				= Engine.Localize( "GAMESETTINGS_PERK_QUICKREVIVE" ),
	["specialty_staminup"] 					= Engine.Localize( "GAMESETTINGS_PERK_STAMINUP" ),
	["specialty_timeslip"] 					= Engine.Localize( "GAMESETTINGS_PERK_TIMESLIP" ),
	["specialty_tombstone"] 				= Engine.Localize( "GAMESETTINGS_PERK_TOMBSTONE" ),
	["specialty_vultureaid"] 				= Engine.Localize( "GAMESETTINGS_PERK_VULTUREAID" ),
	["specialty_winterwail"] 				= Engine.Localize( "GAMESETTINGS_PERK_WINTERWAIL" ),
	["specialty_whoswho"] 					= Engine.Localize( "GAMESETTINGS_PERK_WHOSWHO" ),
	["specialty_widowswine"] 				= Engine.Localize( "GAMESETTINGS_PERK_WIDOWSWINE" ),
	["specialty_zombshell"] 				= Engine.Localize( "GAMESETTINGS_PERK_ZOMBSHELL" )
	--["specialty_flackjacket"] = "",
	--["specialty_flashprotection"] = "",
	--["specialty_immunecounteruav"] = "",
	--["specialty_loudenemies"] = "",
	--["specialty_nottargetedbyairsupport"] = "",
	--["specialty_proximityprotection"] = "",
}

local function IsStringValid( value )
    return value and type( value ) == "string" and value ~= ""
end

local GetUIColorSettings = function( controller )
    local options = {}
    
    local hudIndexModel = Engine.GetModel( Engine.GetModelForController( controller ), "selectedHudIndex" )
    local hudIndex = hudIndexModel and Engine.GetModelValue( hudIndexModel ) or 0

    local fixedColors = {
        { value = "crimson",  display = "GAMESETTINGS_CRIMSON" },
        { value = "red",      display = "GAMESETTINGS_RED" },
        { value = "orange",   display = "GAMESETTINGS_ORANGE" },
        { value = "gold",     display = "GAMESETTINGS_GOLD" },
        { value = "yellow",   display = "GAMESETTINGS_YELLOW" },
        { value = "lime",     display = "GAMESETTINGS_LIME" },
        { value = "green",    display = "GAMESETTINGS_GREEN" },
        { value = "teal",     display = "GAMESETTINGS_TEAL" },
        { value = "cyan",     display = "GAMESETTINGS_CYAN" },
        { value = "blue",     display = "GAMESETTINGS_BLUE" },
        { value = "lavender", display = "GAMESETTINGS_LAVENDER" },
        { value = "purple",   display = "GAMESETTINGS_PURPLE" },
        { value = "magenta",  display = "GAMESETTINGS_MAGENTA" },
        { value = "pink",     display = "GAMESETTINGS_PINK" },
        { value = "silver",   display = "GAMESETTINGS_SILVER" },
        { value = "white",    display = "GAMESETTINGS_WHITE" }
    }

    for _, color in ipairs( fixedColors ) do
        table.insert( options, { models = { value = color.value, valueDisplay = Engine.Localize( color.display ) } } )
    end

    return options
end

local GetFXColorSettings = function( controller, exclude )
    local colors = { "red", "orange", "yellow", "green", "blue", "purple", "pink", "white" }
    local options = {}

    for _, color in ipairs( colors ) do
        if not ( exclude and color == exclude ) then
            table.insert( options, { 
                models = { 
                    value = color, 
                    valueDisplay = Engine.Localize( "GAMESETTINGS_" .. string.upper( color ) ) 
                } 
            } )
        end
    end
    return options
end

local GetZombieWeaponsList = function( controller )
    local controllerModel = Engine.GetModelForController(0)
    local weaponsCountModel = Engine.GetModel( controllerModel, "zombie_weapons_count" )
    local count = Engine.GetModelValue( weaponsCountModel ) or 0

    local weaponList = {}

    for i = 0, count do
        local rootName = Engine.GetModelValue( Engine.GetModel( controllerModel, "zombie_weapons_" .. i .. ".rootname" ) )
        local displayName = Engine.GetModelValue( Engine.GetModel( controllerModel, "zombie_weapons_" .. i .. ".displayname" ) )

        if rootName and IsStringValid( rootName ) and displayName and IsStringValid( displayName ) then
		    table.insert( weaponList, {
		        models = { value = rootName, valueDisplay = displayName }
		    } )
		end

    end

    table.sort( weaponList, function( a, b )
	    return a.models.valueDisplay < b.models.valueDisplay
	end )

    return weaponList
end

local GetZombiePerkList = function( controller )
	local mapName = Engine.GetCurrentMap()
	local controllerModel = Engine.GetModelForController( 0 )
	local perksCountModel = Engine.GetModel( controllerModel, "zombie_perks_count" )
	local perksCount = Engine.GetModelValue( perksCountModel ) or 0
	local perksList = {}

	for i = 0, perksCount do
        local perkModel = Engine.GetModel( controllerModel, "zombie_perks_" .. i .. ".specialty" )
        local perk = perkModel and Engine.GetModelValue( perkModel )
        
        if mapName == "zm_factory" and perk == "specialty_deadshot" then
        elseif mapName == "zm_prison" and perk == "specialty_additionalprimaryweapon" then

        elseif perk and perk ~= "" then            
            local displayName = perkNames[ perk ] or perk
            if displayName and displayName ~= "" then
                table.insert( perksList, {
                    models = { value = perk, valueDisplay = displayName }
                } )
            end
        end
    end

	table.sort( perksList, function( a, b )
	    return a.models.valueDisplay < b.models.valueDisplay
	end )

	return perksList
end

DataSources.ModGameSettings = DataSourceHelpers.ListSetup( "ModGameSettings", function( controller )
	local tabList = {}
	local currentMap = Engine.GetCurrentMap()
	local magicboxPatchRound = 20
	local perkPatchRound = 100
	local roundsPlayed = Engine.GetRoundsPlayed( controller )

	table.insert( tabList, { models = { label = Engine.Localize( "GAMESETTINGS_COLOR_SETTINGS" ), widgetType = "header" } } )

	if Engine.IsLobbyHost( Enum.LobbyType.LOBBY_TYPE_GAME ) then
		table.insert( tabList, {
			models = { label = Engine.Localize( "GAMESETTINGS_CHANGE_ALL" ), description = Engine.Localize( "GAMESETTINGS_CHANGE_ALL_DESC" ), profileVarName = "GameSettings_ChangeAll", datasource = "GameSettings_ChangeAll", widgetType = "dropdown" },
			properties = CoD.PCUtil.OptionsGenericDropdownProperties
		} )
	end

	table.insert( tabList, {
        models = { label = Engine.Localize( "GAMESETTINGS_UI_COLOR" ), description = Engine.Localize( "GAMESETTINGS_UI_COLOR_DESC" ), profileVarName = "colorSettings_UI", datasource = "ColorSettings_UI", widgetType = "dropdown" },
        properties = CoD.PCUtil.OptionsGenericDropdownProperties
    } )

    table.insert( tabList, {
		models = { label = Engine.Localize( "GAMESETTINGS_TRITIUM_COLOR" ), description = Engine.Localize( "GAMESETTINGS_TRITIUM_COLOR_DESC" ), profileVarName = "GameSettings_TritiumColor", datasource = "GameSettings_TritiumColor", widgetType = "dropdown" },
		properties = CoD.PCUtil.OptionsGenericDropdownProperties
	} )

	table.insert( tabList, {
		models = { label = Engine.Localize( "GAMESETTINGS_LASER_COLOR" ), description = Engine.Localize( "GAMESETTINGS_LASER_COLOR_DESC" ), profileVarName = "GameSettings_LaserColor", datasource = "GameSettings_LaserColor", widgetType = "dropdown" },
		properties = CoD.PCUtil.OptionsGenericDropdownProperties
	} )

	table.insert( tabList, { models = { label = Engine.Localize( "GAMESETTINGS_FX_SETTINGS" ), widgetType = "header" } } )

	local currentWeapons = GetZombieWeaponsList( 0 )

    for _, check in ipairs( wonderWeaponChecks ) do
        local isWaffe = ( check.prefix == "tesla_gun" )
        local shouldShow = isWaffe

        if not shouldShow then
            for _, weapon in ipairs( currentWeapons ) do
                local rootName = string.lower( weapon.models.value )
                if string.find( rootName, check.prefix ) then
                    shouldShow = true
                    break
                end
            end
        end

        if shouldShow then
            local finalDisplayName = isWaffe and "Dead Wire / Waffe" or check.displayName
            local descPrefix = isWaffe and "" or "the "
			local weaponDatasource = "ColorSettings_WonderWeapon"
			if isWaffe then
				weaponDatasource = "ColorSettings_Wunderwaffe"
			elseif check.prefix == "idgun" then
				weaponDatasource = "ColorSettings_Squid"
			elseif check.prefix == "blundergat" then
				weaponDatasource = "ColorSettings_Magmagat"
			end

			table.insert( tabList, {
			    models = { label = Engine.Localize( "GAMESETTINGS_WEAPON", finalDisplayName ), description = Engine.Localize( "GAMESETTINGS_WEAPON_DESC", descPrefix .. finalDisplayName ), profileVarName = check.profileVar, datasource = weaponDatasource, widgetType = "dropdown" },
			    properties = CoD.PCUtil.OptionsGenericDropdownProperties
			} )
        end
    end

    table.insert( tabList, {
    	models = { label = Engine.Localize( "GAMESETTINGS_MUZZLEFLASH" ), description = Engine.Localize( "GAMESETTINGS_MUZZLEFLASH_DESC" ), profileVarName = "GameSettings_MuzzleColor", datasource = "GameSettings_MuzzleColor", widgetType = "dropdown" },
    	properties = CoD.PCUtil.OptionsGenericDropdownProperties
    } )

	if Engine.IsLobbyHost( Enum.LobbyType.LOBBY_TYPE_GAME ) then
		table.insert( tabList, {
	    	models = { label = Engine.Localize( "GAMESETTINGS_POWERUPS" ), description = Engine.Localize( "GAMESETTINGS_POWERUPS_DESC" ), profileVarName = "GameSettings_PowerupColor", datasource = "GameSettings_PowerupColor", widgetType = "dropdown" },
	    	properties = CoD.PCUtil.OptionsGenericDropdownProperties
	    } )

	    table.insert( tabList, {
	    	models = { label = Engine.Localize( "GAMESETTINGS_EYES" ), description = Engine.Localize( "GAMESETTINGS_EYES_DESC" ), profileVarName = "GameSettings_EyeColor", datasource = "GameSettings_EyeColor", widgetType = "dropdown" },
	    	properties = CoD.PCUtil.OptionsGenericDropdownProperties
	    } )

	    if roundsPlayed < magicboxPatchRound then
		    table.insert( tabList, { models = { label = Engine.Localize( "GAMESETTINGS_MAGICBOX_SETTINGS" ), widgetType = "header" } } )

		    table.insert( tabList, {
			    models = { label = Engine.Localize( "GAMESETTINGS_FORCE_MAGICBOX" ), description = Engine.Localize( "GAMESETTINGS_FORCE_MAGICBOX_DESC" ), profileVarName = "GameSettings_MagicboxPatch", widgetType = "checkbox" },
			    properties = CoD.PCUtil.OptionsGenericCheckboxProperties
			} )

	        for i = 1, 5 do
	            table.insert( tabList, {
	                models = { label = Engine.Localize( "GAMESETTINGS_WEAPON_SLOT", i ), description = Engine.Localize( "GAMESETTINGS_WEAPON_SLOT_DESC", i ), profileVarName = "GameSettings_MagicboxSlot" .. i, datasource = "MagicboxOptions", widgetType = "dropdown" },
	                properties = CoD.PCUtil.OptionsGenericDropdownProperties
	            } )
	        end
	    end

	    if roundsPlayed < perkPatchRound then
	        table.insert( tabList, { models = { label = Engine.Localize( "GAMESETTINGS_PERK_SETTINGS" ), widgetType = "header" } } )

			table.insert( tabList, {
			    models = { label = Engine.Localize( "GAMESETTINGS_FORCE_PERK_ORDER" ), description = Engine.Localize( "GAMESETTINGS_FORCE_PERK_ORDER_DESC" ), profileVarName = "GameSettings_PerkPatch", widgetType = "checkbox" },
			    properties = CoD.PCUtil.OptionsGenericCheckboxProperties
			} )

	        for i = 1, 5 do
	            table.insert( tabList, {
	                models = { label = Engine.Localize( "GAMESETTINGS_PERK_SLOT", i ), description = Engine.Localize( "GAMESETTINGS_PERK_SLOT_DESC", i ), profileVarName = "GameSettings_PerkSlot" .. i, datasource = "PerkOptions", widgetType = "dropdown" },
	                properties = CoD.PCUtil.OptionsGenericDropdownProperties
	            } )
	        end
	   
			table.insert( tabList, { models = { widgetType = "spacer" } } )
			table.insert( tabList, { models = { widgetType = "spacer" } } )
			table.insert( tabList, { models = { widgetType = "spacer" } } )
			table.insert( tabList, { models = { widgetType = "spacer" } } )
			table.insert( tabList, { models = { widgetType = "spacer" } } )
			table.insert( tabList, { models = { widgetType = "spacer" } } )
		end
	end

	return tabList

end, true )

DataSources.ColorSettings_UI = DataSourceHelpers.ListSetup( "ColorSettings_UI", function( controller )
	return GetUIColorSettings( controller )
end, true )

DataSources.GameSettings_TritiumColor = DataSourceHelpers.ListSetup( "GameSettings_TritiumColor", function( controller )
	return GetFXColorSettings( controller )
end, true )

DataSources.GameSettings_LaserColor = DataSourceHelpers.ListSetup( "GameSettings_LaserColor", function( controller )
	return GetFXColorSettings( controller )
end, true )

DataSources.GameSettings_ChangeAll = DataSourceHelpers.ListSetup( "GameSettings_ChangeAll", function( controller )
	return GetFXColorSettings( controller )
end, true )

DataSources.MagicboxOptions = DataSourceHelpers.ListSetup( "MagicboxOptions", function( controller )
	return GetZombieWeaponsList( controller )
end, true )

DataSources.PerkOptions = DataSourceHelpers.ListSetup( "PerkOptions", function( controller )
	return GetZombiePerkList( controller )
end, true )

DataSources.ColorSettings_Wunderwaffe = DataSourceHelpers.ListSetup( "ColorSettings_Wunderwaffe", function( controller )
	return GetFXColorSettings( controller, "yellow" )
end, true )

DataSources.ColorSettings_Squid = DataSourceHelpers.ListSetup( "ColorSettings_Squid", function( controller )
	local colors = { "red", "orange", "blue", "purple", "pink", "white" }
	local options = {}

	for _, color in ipairs( colors ) do
		table.insert( options, {
			models = {
				value = color,
				valueDisplay = Engine.Localize( "GAMESETTINGS_" .. string.upper( color ) )
			}
		} )
	end
	return options
end, true )

DataSources.ColorSettings_Magmagat = DataSourceHelpers.ListSetup( "ColorSettings_Magmagat", function( controller )
	local colors = { "orange", "blue", "purple" }
	local options = {}

	for _, color in ipairs( colors ) do
		table.insert( options, {
			models = { value = color, valueDisplay = Engine.Localize( "GAMESETTINGS_" .. string.upper( color ) ) }
		} )
	end
	return options
end, true )

DataSources.ColorSettings_WonderWeapon = DataSourceHelpers.ListSetup( "ColorSettings_WonderWeapon", function( controller )
	return GetFXColorSettings( controller )
end, true )

DataSources.GameSettings_PowerupColor = DataSourceHelpers.ListSetup( "GameSettings_PowerupColor", function( controller )
	return GetFXColorSettings( controller )
end, true )

DataSources.GameSettings_MuzzleColor = DataSourceHelpers.ListSetup( "GameSettings_MuzzleColor", function( controller )
	return GetFXColorSettings( controller )
end, true )

DataSources.GameSettings_EyeColor = DataSourceHelpers.ListSetup( "GameSettings_EyeColor", function( controller )
	return GetFXColorSettings( controller )
end, true )

DataSources.ModGameSettings.getWidgetTypeForItem = function( controller, optionModel, _ )
	return CoD.PCUtil.GetWidgetTypeForOption( controller, optionModel )
end

local PostLoadFunc = function( self, controller, menu )
    self:registerEventHandler( "dropdown_triggered", function( element, event )
        if event.inUse then
            self.activeDropdown = event.widget
            element.OptionsList.m_disableNavigation = true
        else
            self.activeDropdown = nil
            element.OptionsList.m_disableNavigation = false
        end

        for i = 1, element.OptionsList.requestedRowCount, 1 do
            local listItem = element.OptionsList:getItemAtPosition( i, 1 )
            if listItem then
                if event.inUse then
                    if listItem ~= event.widget then
                        listItem.m_inputDisabled = true
                        listItem.m_focusable = false
                        listItem:setHandleMouse( false )
                        listItem:setPriority( -10 )
                        listItem:processEvent( { name = "lose_focus", controller = controller } )
                    else
                    	listItem.m_focusable = true
                    	listItem:setAlpha( 1 )
                    	listItem:setPriority( 1000 )
                    end
                else
                    listItem.m_inputDisabled = false
                    listItem.m_focusable = true
                    listItem:setHandleMouse( true )
                    listItem:setAlpha( 1 )
                    listItem:setPriority( -10 )
                end
            end
        end
    end )
end

CoD.StartMenu_GameSettings = InheritFrom( LUI.UIElement )
CoD.StartMenu_GameSettings.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_GameSettings )
	self.id = "StartMenu_GameSettings"
	self.soundSet = "ChooseDecal"
	self:setLeftRight( true, false, 0, 1100 )
	self:setTopBottom( true, false, 0, 600 )
	self:makeFocusable()
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

	self.ListBG = LUI.UIImage.new()
	self.ListBG:setLeftRight( true, false, 2 - 30, 498 + 30 )
	self.ListBG:setTopBottom( true, false, 45, 575 )
	self.ListBG:setImage( RegisterImage( "$white" ) )
	self.ListBG:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.ListBG:setShaderVector( 0, 0.1, 0.1, 0.1, 0.1 )
	self.ListBG:setRGB( 0, 0, 0 )
	self.ListBG:setAlpha( 0.45 )
	self:addElement( self.ListBG )

	self.OptionsList = LUI.UIList.new( menu, controller, 0, 0, nil, false, false, 0, 0, false, false )
	self.OptionsList:makeFocusable()
	self.OptionsList:setLeftRight( true, false, 0, 500 )
	self.OptionsList:setTopBottom( true, false, 30 + 50, 506 + 50 )
	self.OptionsList:setDataSource( "ModGameSettings" )
	self.OptionsList:setWidgetType( CoD.OptionDropdown )
	self.OptionsList:setVerticalScrollbar( CoD.verticalScrollbar )
	self.OptionsList:setVerticalCount( 14 )
	self.OptionsList:setSpacing( 0 )
	self:addElement( self.OptionsList )

	self.InfoBG = LUI.UIImage.new()
	self.InfoBG:setLeftRight( true, false, 550 - 30 - 6, 950 + 30 - 6 )
	self.InfoBG:setTopBottom( true, false, 60, 300 )
	self.InfoBG:setImage( RegisterImage( "$white" ) )
	self.InfoBG:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_feather_edges" ) )
	self.InfoBG:setShaderVector( 0, 0.1, 0.1, 0.1, 0.1 )
	self.InfoBG:setRGB( 0, 0, 0 )
	self.InfoBG:setAlpha( 0.45 )
	self:addElement( self.InfoBG )
	
	self.OptionInfo = CoD.OptionInfoWidget.new( menu, controller )
	self.OptionInfo:setLeftRight( true, false, 550, 950 )
	self.OptionInfo:setTopBottom( true, false, 30 + 50, 330 + 50 )
	self:addElement( self.OptionInfo )

	self:addElement( LUI.UITimer.newElementTimer( 100, true, function()
	    self.OptionsList:dispatchEventToChildren( { name = "force_lock_check", controller = controller } )
	end ) )

	self.OptionInfo:linkToElementModel( self.OptionsList, "description", true, function( model )
		local description = Engine.GetModelValue( model )
		if description then
			self.OptionInfo.description:setText( Engine.Localize( description ) )
		end
	end )

	self.OptionInfo:linkToElementModel( self.OptionsList, "label", true, function( model )
		local label = Engine.GetModelValue( model )
		if label then
			self.OptionInfo.title.itemName:setText( Engine.Localize( label ) )
		end
	end )

	self.OptionsList.id = "OptionsList"

	self:registerEventHandler( "gain_focus", function( element, event )
		if element.m_focusable and element.OptionsList:processEvent( event ) then
			return true

		else
			return LUI.UIElement.gainFocus( element, event )
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.ListBG:close()
		element.OptionsList:close()
		element.InfoBG:close()
		element.OptionInfo:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end