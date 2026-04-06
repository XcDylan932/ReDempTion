local mapMagicbox = {
    zm_asylum       = { "tesla_gun", "raygun_mark2", "cymbal_monkey" },
    zm_sumpf        = { "tesla_gun", "raygun_mark2", "cymbal_monkey" },
    zm_factory      = { "tesla_gun", "cymbal_monkey" },
    zm_theater      = { "thundergun", "cymbal_monkey" },
    zm_cosmodrome   = { "thundergun", "black_hole_bomb", "smg_capacity" },
    zm_temple       = { "shrink_ray", "cymbal_monkey" },
    zm_moon         = { "quantum_bomb", "smg_capacity", "microwavegundw", "black_hole_bomb" },
    zm_tomb         = { "raygun_mark2", "cymbal_monkey" },
    zm_zod          = { "octobomb", "shotgun_fullauto", "lmg_cqb" },
    zm_castle       = { "cymbal_monkey", "shotgun_fullauto", "lmg_cqb" },
    zm_island       = { "cymbal_monkey", "shotgun_fullauto", "lmg_cqb" },
    zm_stalingrad   = { "raygun_mark3", "cymbal_monkey" },
    zm_genesis      = { "idgun_genesis_0", "thundergun", "octobomb", "hero_gravityspikes_melee", "ar_cqb" },

    zm_coast        = { "scavenger", "t5_hk21", "nesting_dolls", "humangun" },
    zm_prison       = { "t8_blundergat" }
}

local mapColors = {
    zm_prototype = { uicolor = "orange", fxcolor = "orange" },
    zm_asylum = { uicolor = "crimson", fxcolor = "red" },
    zm_sumpf = { uicolor = "lime", fxcolor = "green" },
    zm_factory = { uicolor = "blue", fxcolor = "blue" },
    zm_theater = { uicolor = "orange", fxcolor = "orange" },
    zm_cosmodrome = { uicolor = "green", fxcolor = "green" },
    zm_temple = { uicolor = "orange", fxcolor = "orange" },
    zm_moon = { uicolor = "lavender", fxcolor = "purple" },
    zm_tomb = { uicolor = "blue", fxcolor = "blue" },
    zm_zod = { uicolor = "crimson", fxcolor = "red" },
    zm_castle = { uicolor = "blue", fxcolor = "blue" },
    zm_island = { uicolor = "lime", fxcolor = "green" },
    zm_stalingrad = { uicolor = "crimson", fxcolor = "red" },
    zm_genesis = { uicolor = "purple", fxcolor = "pink" },
    
    zm_coast = { uicolor = "silver", fxcolor = "blue" },
    zm_die = { uicolor = "blue", fxcolor = "blue" },
    zm_prison = { uicolor = "orange", fxcolor = "orange" },
    zm_town = { uicolor = "orange", fxcolor = "orange" }
}

local GetDefaultUIColor = function()
    local mapName = Engine.GetCurrentMap()
    return mapColors[mapName] and mapColors[mapName].uicolor or "blue"
end

local GetDefaultFXColor = function()
    local mapName = Engine.GetCurrentMap()
    return mapColors[mapName] and mapColors[mapName].fxcolor or "blue"
end

local GetWeaponSlot = function( index )
    local currentMap = Engine.GetCurrentMap()
    if mapMagicbox[ currentMap ] then
        return mapMagicbox[ currentMap ][ index ] or ""
    end
    return ""
end

local CopyTable = function( original )
    local copy = {}
    for k, v in pairs( original ) do
        copy[k] = v
    end
    return copy
end

local standardPerks = {
    ["specialty_doubletap2"] = true,
    ["specialty_armorvest"] = true,
    ["specialty_staminup"] = true,
    ["specialty_fastreload"] = true,
    ["specialty_additionalprimaryweapon"] = true
}

local function NewMap( overrides )
    local map = {}
    for k, v in pairs( standardPerks ) do
        map[k] = v
    end
    if overrides then
        for k, v in pairs( overrides ) do
            map[k] = v
        end
    end
    return map
end

local mapPerks = {
    ["zm_prototype"]  = NewMap(),
    ["zm_asylum"]     = NewMap(),
    ["zm_sumpf"]      = NewMap(),
    ["zm_factory"]    = NewMap(),
    ["zm_theater"]    = NewMap(),
    ["zm_cosmodrome"] = NewMap(),
    ["zm_temple"]     = NewMap(),
    ["zm_moon"]       = NewMap(),
    ["zm_tomb"]       = NewMap(),
    ["zm_zod"]        = NewMap(),
    ["zm_castle"]     = NewMap(),
    ["zm_island"]     = NewMap(),
    ["zm_stalingrad"] = NewMap(),
    ["zm_genesis"]    = NewMap(),
    ["zm_coast"]      = NewMap(),
    ["zm_die"]        = NewMap(),
    ["zm_prison"]     = NewMap( { ["specialty_additionalprimaryweapon"] = false } ),
    ["zm_town"]       = NewMap()
}

local VerifyPerk = function( perk )
    local mapName = Engine.GetCurrentMap()
    if mapPerks[mapName] and mapPerks[mapName][perk] == true then
        return perk
    end
    return ""
end

local initialSettings = {
    GameSettings_ChangeAll = GetDefaultFXColor(),
    GameSettings_TritiumColor = GetDefaultFXColor(),
    GameSettings_LaserColor = GetDefaultFXColor(),
    GameSettings_PowerupColor = GetDefaultFXColor(),
    GameSettings_MuzzleColor = GetDefaultFXColor(),
    GameSettings_EyeColor = GetDefaultFXColor(),

    GameSettings_WunderwaffeColor = GetDefaultFXColor(),
    GameSettings_ThundergunColor = GetDefaultFXColor(),
    GameSettings_ApothiconColor = GetDefaultFXColor(),
    GameSettings_WavegunColor = GetDefaultFXColor(),
    GameSettings_MagmagatColor = GetDefaultFXColor(),

    GameSettings_MagicboxPatch = 1,
    GameSettings_MagicboxSlot1 = GetWeaponSlot(1),
    GameSettings_MagicboxSlot2 = GetWeaponSlot(2),
    GameSettings_MagicboxSlot3 = GetWeaponSlot(3),
    GameSettings_MagicboxSlot4 = GetWeaponSlot(4),
    GameSettings_MagicboxSlot5 = GetWeaponSlot(5),
    GameSettings_PerkPatch = 1,
    GameSettings_PerkSlot1 = "specialty_doubletap2",
    GameSettings_PerkSlot2 = "specialty_armorvest",
    GameSettings_PerkSlot3 = "specialty_staminup",
    GameSettings_PerkSlot4 = "specialty_fastreload",
    GameSettings_PerkSlot5 = "specialty_additionalprimaryweapon"
}

CoD.PCUtil.GlobalSettings = CopyTable( initialSettings )
CoD.PCUtil.GameOptions = {}
for i = 0, 3 do
    CoD.PCUtil.GameOptions[i] = {
        colorSettings_UI = GetDefaultUIColor()
    }
end

CoD.PCUtil.ResetGlobalSettings = function()
    for key, value in pairs( initialSettings ) do
        if string.find( key, "Magicbox" ) or string.find( key, "PerkPatch" ) then
            CoD.PCUtil.GlobalSettings[key] = value
        elseif string.find( key,"PerkSlot" ) then
            CoD.PCUtil.GlobalSettings[key] = VerifyPerk( value )
        end
    end
end

CoD.PCUtil.SetOptionValue = function( optionModel, controller, value )
    if not optionModel then
		return
	end

	local profileVarModel = Engine.GetModel( optionModel, "profileVarName" )
	if not profileVarModel then
		return
	end

	local shouldDirtyOptions = true
	local profileVarName = Engine.GetModelValue( profileVarModel )

	local profileTypeModel = Engine.GetModel( optionModel, "profileType" )
	if profileTypeModel then
		local profileType = Engine.GetModelValue( profileTypeModel )

		if profileType == "user" then
			Engine.SetProfileVar( controller, profileVarName, value )
			Engine.SendMenuResponse( controller, "GameOptions", profileVarName .. "|" .. tostring( value ) )

		elseif profileType == "function" then
			local setFunctionModel = Engine.GetModel( optionModel, "setFunction" )
			if setFunctionModel then
				local targetController = controller
				local optionControllerModel = Engine.GetModel( optionModel, "optionController" )

				if optionControllerModel then
					targetController = Engine.GetModelValue( optionControllerModel )
				end

				local setValueFunction = Engine.GetModelValue( setFunctionModel )
				setValueFunction( targetController, value )
			end

		else
			Engine.SetHardwareProfileValue( profileVarName, value )
		end

    elseif profileVarName == "colorSettings_UI" then
        CoD.PCUtil.GameOptions[controller][profileVarName] = value

        local controllerModel = Engine.GetModelForController( controller )
        local optionModel = Engine.CreateModel( controllerModel, "colorSettings_UI" )
        --local rainbowToggle = Engine.CreateModel( controllerModel, "rainbow_enabled" )
        
        Engine.SetModelValue( optionModel, value )
        --Engine.SetModelValue( rainbowToggle, (value == "rainbow") and 1 or 0 )
        Engine.SetModelValue( Engine.CreateModel( controllerModel, "colorUpdate" ), math.random( 1, 1000 ) )

        shouldDirtyOptions = false

    elseif string.find( profileVarName, "^GameSettings_" ) then
        CoD.PCUtil.GlobalSettings[profileVarName] = value

        local shortKey = profileVarName:gsub( "GameSettings_", "" )

        if shortKey == "ChangeAll" then
            local settingsToUpdate = { "TritiumColor", "LaserColor", "PowerupColor", "MuzzleColor", "EyeColor", "WunderwaffeColor", "ThundergunColor", "ApothiconColor", "WavegunColor", "MagmagatColor" } 
            
            for _, setting in pairs( settingsToUpdate ) do
                local fullKey = "GameSettings_" .. setting
                CoD.PCUtil.GlobalSettings[fullKey] = value
            end

            for i = 0, 3 do
                local controllerModel = Engine.GetModelForController(i)
                if controllerModel then
                    CoD.PCUtil.GameOptions[i].colorSettings_UI = value
                    Engine.SetModelValue( Engine.CreateModel( controllerModel, "colorSettings_UI" ), value )
                    Engine.SetModelValue( Engine.CreateModel( controllerModel, "colorUpdate" ), math.random( 1, 1000 ) )
                end
            end

            Engine.SendMenuResponse( 0, "GameSettings", "ChangeAll|" .. tostring( value ) )
            return

        elseif not string.find( shortKey, "Magicbox" ) and not string.find( shortKey, "Perk" ) then
            Engine.SendMenuResponse( 0, "GameSettings", shortKey .. "|" .. tostring( value ) )
        end
        
        shouldDirtyOptions = false

    elseif CoD.PCUtil.GameOptions[ profileVarName ] and CoD.PCUtil.GameOptions[ profileVarName ] ~= value then

        Engine.SetDvar( profileVarName, value )
        CoD.PCUtil.GameOptions[ profileVarName ] = value
        Engine.SendMenuResponse( controller, "GameOptions", profileVarName .. "|" .. tostring( value ) )

        shouldDirtyOptions = false

	else
		Engine.SetHardwareProfileValue( profileVarName, value )
	end

	if shouldDirtyOptions then
		CoD.PCUtil.DirtyOptions( controller )
	end
end

CoD.PCUtil.GetOptionInfo = function( optionModel, controller )
    if not optionModel then
        return nil
    end

    local profileVarModel = Engine.GetModel( optionModel, "profileVarName" )
    if not profileVarModel then
        return nil
    end

    local profileVarName = Engine.GetModelValue( profileVarModel )
    local optionInfo = { profileVarName = profileVarName }

    local lowValueModel = Engine.GetModel( optionModel, "lowValue" )
    local highValueModel = Engine.GetModel( optionModel, "highValue" )

    if lowValueModel and highValueModel then
        optionInfo.lowValue = Engine.GetModelValue( lowValueModel )
        optionInfo.highValue = Engine.GetModelValue( highValueModel )
    else
        local low, high = 0, 1
        if Dvar[profileVarName] then
            low, high = Dvar[profileVarName]:getDomain()
        end
        optionInfo.lowValue = low or 0
        optionInfo.highValue = high or 1
    end

    local widgetTypeModel = Engine.GetModel( optionModel, "widgetType" )
    if widgetTypeModel then
        optionInfo.widgetType = Engine.GetModelValue( widgetTypeModel )
        if optionInfo.widgetType == "slider" then
            local sliderSpeedModel = Engine.GetModel( optionModel, "sliderSpeed" )
            if sliderSpeedModel then
                optionInfo.sliderSpeed = Engine.GetModelValue( sliderSpeedModel )
            else
                local valueRange = optionInfo.highValue - optionInfo.lowValue
                optionInfo.sliderSpeed = 0.1 / ( valueRange > 0 and valueRange or 1 )
            end
        end
    end

    local currentValue
    if string.find( profileVarName, "^GameSettings_" ) then
        currentValue = CoD.PCUtil.GlobalSettings[profileVarName]
    elseif CoD.PCUtil.GameOptions[controller] and CoD.PCUtil.GameOptions[controller][profileVarName] ~= nil then
        currentValue = CoD.PCUtil.GameOptions[controller][profileVarName]
    end

    if currentValue == nil then
        local profileTypeModel = Engine.GetModel( optionModel, "profileType" )
        local profileType = profileTypeModel and Engine.GetModelValue( profileTypeModel ) or ""
        
        local valStr
        if profileType == "user" then
            valStr = Engine.ProfileValueAsString( controller, profileVarName )
        elseif profileType == "function" then
            local getFn = Engine.GetModelValue( Engine.GetModel( optionModel, "getFunction" ) )
            valStr = getFn and getFn( controller ) or ""
        else
            valStr = Engine.GetHardwareProfileValueAsString( profileVarName )
        end
        
        local numValue = tonumber( valStr )
        currentValue = ( numValue ~= nil ) and numValue or valStr
    end

    optionInfo.currentValue = currentValue

    local d_val = tostring( currentValue )
    local datasourceModel = Engine.GetModel( optionModel, "datasource" )
    
    if datasourceModel then
        local dsName = Engine.GetModelValue( datasourceModel )
        local ds = DataSources[dsName]
        
        if ds then
            local items = {}
            if type( ds.getWidgetType ) == "function" then
                local count = ds.getCount( optionModel ) or 0
                for i = 1, count do
                    local itemModel = ds.getItem( controller, optionModel, i )
                    local iVal = Engine.GetModelValue( Engine.GetModel( itemModel, "value" ) )
                    if iVal == currentValue then
                        d_val = Engine.GetModelValue( Engine.GetModel( itemModel, "valueDisplay" ) )
                        break
                    end
                end
            elseif type( ds.prepare ) == "function" then
                local status, listData = pcall( ds.prepare, controller, nil ) 
                if status and type( listData ) == "table" then
                    for _, item in ipairs( listData ) do
                        if item.models and item.models.value == currentValue then
                            d_val = item.models.valueDisplay
                            break
                        end
                    end
                end
            end
        end
    end

    optionInfo.currentValueDisplay = d_val
    local displayModel = Engine.CreateModel( optionModel, "currentValueDisplay" )
    Engine.SetModelValue( displayModel, d_val )

    return optionInfo
end

CoD.PCUtil.GetWidgetTypeForOption = function( controller, optionModel )
    if not optionModel then
        return nil
    end

    local widgetTypeModel = Engine.GetModel( optionModel, "widgetType" )
    if not widgetTypeModel then
        return nil
    end

    local widgetType = Engine.GetModelValue( widgetTypeModel )

    local types = {
        ["dropdown"] = CoD.OptionDropdown,
        ["checkbox"] = CoD.StartMenu_Options_CheckBoxOption,
        ["slider"]   = CoD.StartMenu_Options_SliderBar,
        ["spacer"]   = CoD.VerticalListSpacer,
        ["button"]   = CoD.button,
        ["header"]   = CoD.SettingsHeader
    }

    return types[ widgetType ]
end

CoD.PCUtil.OptionsDropdownRefresh = function( controller, widget, list )
    local model = widget:getModel()
    local profileVarName = Engine.GetModelValue( Engine.GetModel( model, "profileVarName" ) )
    
    local val = CoD.PCUtil.GlobalSettings[profileVarName]
    if val == nil then
        val = CoD.PCUtil.GameOptions[controller][profileVarName]
    end

    if val ~= nil then
        local datasourceName = Engine.GetModelValue( Engine.GetModel( model, "datasource" ) )
        local datasource = DataSources[datasourceName]
        if datasource then
            local listData = datasource.prepare( controller, widget )
            for _, item in ipairs( listData ) do
                if item.models.value == val then
                    return item.models.valueDisplay
                end
            end
        end
        return tostring( val )
    end

    return CoD.PCUtil.GetOptionInfo( model, controller ).currentValueDisplay
end

CoD.PCUtil.OptionsDropdownCurrentValue = function( controller, widget )
    local model = widget:getModel()
    local profileVarName = Engine.GetModelValue( Engine.GetModel( model, "profileVarName" ) )
    
    if CoD.PCUtil.GlobalSettings[profileVarName] ~= nil then
        return CoD.PCUtil.GlobalSettings[profileVarName]
    end

    return CoD.PCUtil.GetOptionInfo( model, controller ).currentValue
end