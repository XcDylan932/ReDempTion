require( "ui.uieditor.widgets.Scrollbars.verticalCounter" )
require( "ui.uieditor.widgets.StartMenu.CamoTab.StartMenu_CamoOptions_ListItem" )

CoD.CamoTable = {
    { models = { image = "menu_cac_none", name = "MPUI_NONE", camoIndex = 0 } },

    { models = { image = "menu_camo_lightning_red", name = "XCUI_CAMO_LIGHTNING_RED", camoIndex = 1 } },
    { models = { image = "menu_camo_lightning_blue", name = "XCUI_CAMO_LIGHTNING_BLUE", camoIndex = 2 } },
    { models = { image = "menu_camo_lightning_orange", name = "XCUI_CAMO_LIGHTNING_ORANGE", camoIndex = 3 } },
    { models = { image = "menu_camo_lightning_green", name = "XCUI_CAMO_LIGHTNING_GREEN", camoIndex = 4 } },
    { models = { image = "menu_camo_lightning_purple", name = "XCUI_CAMO_LIGHTNING_PURPLE", camoIndex = 5 } },
    { models = { image = "menu_camo_lightning_white", name = "XCUI_CAMO_LIGHTNING_WHITE", camoIndex = 6 } },
    { models = { image = "menu_camo_lightning_pink", name = "XCUI_CAMO_LIGHTNING_PINK", camoIndex = 7 } },
    { models = { image = "menu_camo_lightning_yellow", name = "XCUI_CAMO_LIGHTNING_YELLOW", camoIndex = 8 } },

    { models = { image = "menu_camo_transgression_red", name = "XCUI_CAMO_TRANSGRESSION_RED", camoIndex = 9 } },
    { models = { image = "menu_camo_transgression_blue", name = "XCUI_CAMO_TRANSGRESSION_BLUE", camoIndex = 10 } },
    { models = { image = "menu_camo_transgression_orange", name = "XCUI_CAMO_TRANSGRESSION_ORANGE", camoIndex = 11 } },
    { models = { image = "menu_camo_transgression_green", name = "XCUI_CAMO_TRANSGRESSION_GREEN", camoIndex = 12 } },
    { models = { image = "menu_camo_transgression_purple", name = "XCUI_CAMO_TRANSGRESSION_PURPLE", camoIndex = 13 } },
    { models = { image = "menu_camo_transgression_white", name = "XCUI_CAMO_TRANSGRESSION_WHITE", camoIndex = 14 } },

    { models = { image = "menu_camo_afterlife_red", name = "XCUI_CAMO_AFTERLIFE_RED", camoIndex = 18 } },
    { models = { image = "menu_camo_afterlife_blue", name = "XCUI_CAMO_AFTERLIFE_BLUE", camoIndex = 19 } },
    { models = { image = "menu_camo_zod_pap_pattern", name = "XCUI_CAMO_AFTERLIFE_ORANGE", camoIndex = 20 } },
    { models = { image = "menu_camo_afterlife_green", name = "XCUI_CAMO_AFTERLIFE_GREEN", camoIndex = 21 } },
    { models = { image = "menu_camo_afterlife_purple", name = "XCUI_CAMO_AFTERLIFE_PURPLE", camoIndex = 22 } },
    { models = { image = "menu_camo_afterlife_white", name = "XCUI_CAMO_AFTERLIFE_WHITE", camoIndex = 23 } },

    --{ models = { image = "menu_camo_jungletek_pattern", name = "MPUI_CAMO_JUNGLETEK", camoIndex = 1 } },
    --{ models = { image = "menu_camo_ash_pattern", name = "MPUI_CAMO_ASH", camoIndex = 2 } },
    --{ models = { image = "menu_camo_flectarn_pattern", name = "MPUI_CAMO_FLECTARN", camoIndex = 3 } },
    --{ models = { image = "menu_camo_heatstroke_pattern", name = "MPUI_CAMO_HEATSTROKE", camoIndex = 4 } },
    --{ models = { image = "menu_camo_snowjob_pattern", name = "MPUI_CAMO_SNOWJOB", camoIndex = 5 } },
    --{ models = { image = "menu_camo_dante_pattern", name = "MPUI_CAMO_DANTE", camoIndex = 6 } },
    --{ models = { image = "menu_camo_integer_pattern", name = "MPUI_CAMO_INTEGER", camoIndex = 7 } },
    --{ models = { image = "menu_camo_speed6_pattern", name = "MPUI_CAMO_6SPEED", camoIndex = 8 } },
    --{ models = { image = "menu_camo_interpol_pattern", name = "MPUI_CAMO_INTERPOL", camoIndex = 9 } },
    --{ models = { image = "menu_camo_ardent_pattern", name = "MPUI_CAMO_ARDENT", camoIndex = 10 } },
    --{ models = { image = "menu_camo_burnt_pattern", name = "MPUI_CAMO_BURNT", camoIndex = 11 } },
    --{ models = { image = "menu_camo_bliss_pattern", name = "MPUI_CAMO_BLISS", camoIndex = 12 } },
    --{ models = { image = "menu_camo_battle_pattern", name = "MPUI_CAMO_BATTLE", camoIndex = 13 } },
    --{ models = { image = "menu_camo_chameleon_pattern", name = "MPUI_CAMO_CHAMELEON", camoIndex = 14 } },
    { models = { image = "menu_camo_gold_pattern", name = "MPUI_CAMO_GOLD", camoIndex = 15 } },
    { models = { image = "menu_camo_diamond_pattern", name = "MPUI_CAMO_DIAMOND", camoIndex = 16 } },
    { models = { image = "menu_camo_darkmatter_pattern", name = "MPUI_CAMO_DARKMATTER", camoIndex = 17 } },
    --{ models = { image = "menu_camo_arctic_pattern", name = "MPUI_CAMO_ARCTIC", camoIndex = 18 } },
    --{ models = { image = "menu_camo_jungle_pattern", name = "MPUI_CAMO_JUNGLE", camoIndex = 19 } },
    --{ models = { image = "menu_camo_huntsman_pattern", name = "MPUI_CAMO_HUNTSMAN", camoIndex = 20 } },
    --{ models = { image = "menu_camo_woodlums_pattern", name = "MPUI_CAMO_WOODLUMS", camoIndex = 21 } },
    --{ models = { image = "menu_camo_contagious_pattern", name = "MPUI_CAMO_CONTAGIOUS", camoIndex = 22 } },
    --{ models = { image = "menu_camo_fear_pattern", name = "MPUI_CAMO_FEAR", camoIndex = 23 } },
    { models = { image = "menu_camo_wmd_pattern", name = "MPUI_CAMO_WMD", camoIndex = 24 } },
    { models = { image = "menu_camo_redhex_pattern", name = "MPUI_CAMO_REDHEX", camoIndex = 25 } },
    { models = { image = "menu_camo_zod_pap_pattern", name = "MPUI_CAMO_ZOD_PAP", camoIndex = 26 } },
    { models = { image = "menu_camo_ce_bo3_pattern", name = "MPUI_CAMO_CE_BO3", camoIndex = 27 } },
    { models = { image = "menu_camo_ce_115_pattern", name = "MPUI_CAMO_CE_115", camoIndex = 28 } },
    { models = { image = "menu_camo_ce_cyborg_pattern", name = "MPUI_CAMO_CE_CYBORG", camoIndex = 29 } },
    { models = { image = "menu_camo_loyalty_pattern", name = "MPUI_CAMO_LOYALTY", camoIndex = 30 } },
    --{ models = { image = "$white", name = "placeholder", camoIndex = 31 } },
    --{ models = { image = "$white", name = "placeholder", camoIndex = 32 } },
    { models = { image = "menu_camo_cj_take_out_pattern", name = "MPUI_CAMO_CJ_TAKE_OUT", camoIndex = 33 } },
    { models = { image = "menu_camo_urban", name = "MPUI_CAMO_URBAN", camoIndex = 34 } },
    { models = { image = "menu_camo_nuketown_pattern", name = "MPUI_CAMO_NUKETOWN", camoIndex = 35 } },
    { models = { image = "menu_camo_transgression_pattern", name = "MPUI_CAMO_TRANSGRESSION", camoIndex = 36 } },
    --{ models = { image = "$white", name = "placeholder", camoIndex = 37 } },
    { models = { image = "menu_camo_storm_pattern", name = "MPUI_CAMO_STORM", camoIndex = 38 } },
    { models = { image = "menu_camo_wartorn_pattern", name = "MPUI_CAMO_WARTORN", camoIndex = 39 } },
    { models = { image = "menu_camo_prestige_emissive_pattern", name = "MPUI_CAMO_PRESTIGE_EMISSIVE", camoIndex = 40 } },
    --{ models = { image = "$white", name = "placeholder", camoIndex = 41 } },
    { models = { image = "menu_camo_etching_pattern", name = "MPUI_CAMO_ETCHING", camoIndex = 42 } },
    { models = { image = "menu_camo_ice_pattern", name = "MPUI_CAMO_ICE", camoIndex = 43 } },
    { models = { image = "menu_camo_jungle_earth_pattern", name = "MPUI_CAMO_JUNGLE_EARTH", camoIndex = 44 } },
    { models = { image = "menu_camo_jungle_cat_pattern", name = "MPUI_CAMO_JUNGLE_CAT", camoIndex = 45 } },
    { models = { image = "menu_camo_jungle_emissive_pattern", name = "MPUI_CAMO_JUNGLE_EMISSIVE", camoIndex = 46 } },
    { models = { image = "menu_camo_scorch_contrast_pattern", name = "MPUI_CAMO_SCORCH_CONTRAST", camoIndex = 47 } },
    { models = { image = "menu_camo_scorch_green_pattern", name = "MPUI_CAMO_SCORCH_GREEN", camoIndex = 48 } },
    { models = { image = "menu_camo_scorch_emissive_pattern", name = "MPUI_CAMO_SCORCH_EMISSIVE", camoIndex = 49 } },
    { models = { image = "menu_camo_flecktarn_purple_pattern", name = "MPUI_CAMO_FLECKTARN_PURPLE", camoIndex = 50 } },
    { models = { image = "menu_camo_flecktarn_stealth_pattern", name = "MPUI_CAMO_FLECKTARN_STEALTH", camoIndex = 51 } },
    { models = { image = "menu_camo_flecktarn_emissive_pattern", name = "MPUI_CAMO_FLECKTARN_EMISSIVE", camoIndex = 52 } },
    { models = { image = "menu_camo_flecktarn_shiny_pattern", name = "MPUI_CAMO_FLECKTARN_SHINY", camoIndex = 53 } },
    { models = { image = "menu_camo_snowblo_green_pattern", name = "MPUI_CAMO_SNOWBLO_GREEN", camoIndex = 54 } },
    { models = { image = "menu_camo_dante_crazy_pattern", name = "MPUI_CAMO_DANTE_CRAZY", camoIndex = 55 } },
    { models = { image = "menu_camo_dante_hallucination_pattern", name = "MPUI_CAMO_DANTE_HALLUCINATION", camoIndex = 56 } },
    { models = { image = "menu_camo_dante_emissive_pattern", name = "MPUI_CAMO_DANTE_EMISSIVE", camoIndex = 57 } },
    { models = { image = "menu_camo_integer_purple_pattern", name = "MPUI_CAMO_INTEGER_PURPLE", camoIndex = 58 } },
    { models = { image = "menu_camo_integer_emissive_pattern", name = "MPUI_CAMO_INTEGER_EMISSIVE", camoIndex = 59 } },
    { models = { image = "menu_camo_ardent_emissive_pattern", name = "MPUI_CAMO_ARDENT_EMISSIVE", camoIndex = 60 } },
    { models = { image = "menu_camo_burnt_shiny_pattern", name = "MPUI_CAMO_BURNT_SHINY", camoIndex = 61 } },
    { models = { image = "menu_camo_artofwar_goldink_pattern", name = "MPUI_CAMO_ARTOFWAR_GOLDINK", camoIndex = 62 } },
    { models = { image = "menu_camo_artofwar_gem_pattern", name = "MPUI_CAMO_ARTOFWAR_GEM", camoIndex = 63 } },
    { models = { image = "menu_camo_artofwar_animation_pattern", name = "MPUI_CAMO_ARTOFWAR_ANIMATION", camoIndex = 64 } },
    { models = { image = "menu_camo_chameleon_shiny_pattern", name = "MPUI_CAMO_CHAMELEON_SHINY", camoIndex = 65 } },
    { models = { image = "menu_camo_chameleon_emissive_pattern", name = "MPUI_CAMO_CHAMELEON_EMISSIVE", camoIndex = 66 } },
    { models = { image = "menu_camo_heatstroke_red_pattern", name = "MPUI_CAMO_HEATSTROKE_RED", camoIndex = 67 } },
    { models = { image = "menu_camo_heatstroke_emissive_pattern", name = "MPUI_CAMO_HEATSTROKE_EMISSIVE", camoIndex = 68 } },
    { models = { image = "menu_camo_underradar", name = "Underradar", camoIndex = 69 } },
    --{ models = { image = "menu_camo_placeholder_pattern_02", name = "MPUI_CAMO_PLACEHOLDER_02", camoIndex = 70 } },
    --{ models = { image = "menu_camo_placeholder_pattern_03", name = "MPUI_CAMO_PLACEHOLDER_03", camoIndex = 71 } },
    --{ models = { image = "menu_camo_placeholder_pattern_04", name = "MPUI_CAMO_PLACEHOLDER_04", camoIndex = 72 } },
    --{ models = { image = "menu_camo_placeholder_pattern_05", name = "MPUI_CAMO_PLACEHOLDER_05", camoIndex = 73 } },
    { models = { image = "menu_camo_BGB74_pattern", name = "MPUI_CAMO_BGB74", camoIndex = 74 } },
    { models = { image = "menu_camo_zm_dlc2_pap01", name = "MPUI_CAMO_DLC5_REWARD_1", camoIndex = 75 } },
    { models = { image = "menu_camo_zm_dlc2_pap02", name = "MPUI_CAMO_DLC5_REWARD_2", camoIndex = 76 } },
    { models = { image = "menu_camo_zm_dlc2_pap03", name = "MPUI_CAMO_DLC5_REWARD_3", camoIndex = 77 } },
    { models = { image = "menu_camo_zm_dlc2_pap04", name = "MPUI_CAMO_DLC5_REWARD_4", camoIndex = 78 } },
    { models = { image = "menu_camo_zm_dlc2_pap05", name = "MPUI_CAMO_DLC5_REWARD_5", camoIndex = 79 } },
    { models = { image = "menu_camo_zm_dlc2_pap06", name = "Selenite", camoIndex = 80 } },
    { models = { image = "menu_camo_pap_island", name = "MPUI_CAMO_ZMHD_PAP_01", camoIndex = 81 } },
    { models = { image = "menu_camo_nightmare", name = "MPUI_CAMO_NIGHTMARE", camoIndex = 82 } },
    { models = { image = "menu_camo_loot_section9_emissive_pattern", name = "MPUI_CAMO_LOOT_SECTION9_EMISSIVE", camoIndex = 83 } },
    { models = { image = "menu_camo_dlc3_pap_base", name = "MPUI_CAMO_ZMHD_EVENT_01", camoIndex = 84 } },
    { models = { image = "menu_camo_dlc3_pap_01", name = "Glacial fire", camoIndex = 85 } },
    { models = { image = "menu_camo_dlc3_pap_02", name = "MPUI_CAMO_PROMO_02", camoIndex = 86 } },
    { models = { image = "menu_camo_dlc3_pap_03", name = "Crimson fire", camoIndex = 87 } },
    { models = { image = "menu_camo_dlc3_pap_04", name = "MPUI_CAMO_PROMO_03", camoIndex = 88 } },
    { models = { image = "menu_camo_codxp", name = "MPUI_CAMO_CODXP", camoIndex = 89 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 90 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 91 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 92 } },
    { models = { image = "menu_camo_cwl_excellence", name = "MPUI_CAMO_CODCWL_ANZ_EXCELLENCE", camoIndex = 93 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 94 } },
    { models = { image = "menu_camo_cwl_mindfreak", name = "MPUI_CAMO_CODCWL_ANZ_MINDFREAK", camoIndex = 95 } },
    { models = { image = "menu_camo_cwl_nv", name = "MPUI_CAMO_CODCWL_ANZ_NV", camoIndex = 96 } },
    { models = { image = "menu_camo_cwl_orbit", name = "MPUI_CAMO_CODCWL_ANZ_ORBIT_GG", camoIndex = 97 } },
    { models = { image = "menu_camo_cwl_tainted_minds", name = "MPUI_CAMO_CODCWL_ANZ_TAINTED_MINDS", camoIndex = 98 } },
    { models = { image = "menu_camo_cwl_epsilon", name = "MPUI_CAMO_CODCWL_EU_EPSILON", camoIndex = 99 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 100 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 101 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 102 } },
    { models = { image = "menu_camo_cwl_infused", name = "MPUI_CAMO_CODCWL_EU_INFUSED", camoIndex = 103 } },
    { models = { image = "menu_camo_cwl_ldlc", name = "MPUI_CAMO_CODCWL_EU_LDLC", camoIndex = 104 } },
    { models = { image = "menu_camo_cwl_millenium", name = "MPUI_CAMO_CODCWL_EU_MILLENIUM", camoIndex = 105 } },
    { models = { image = "menu_camo_cwl_splyce", name = "MPUI_CAMO_CODCWL_EU_SPLYCE", camoIndex = 106 } },
    { models = { image = "menu_camo_cwl_supremacy", name = "MPUI_CAMO_CODCWL_EU_SUPREMACY", camoIndex = 107 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 108 } },
    { models = { image = "menu_camo_cwl_cloud9", name = "MPUI_CAMO_CODCWL_NA_CLOUD9", camoIndex = 109 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 110 } },
    { models = { image = "menu_camo_cwl_elevate", name = "MPUI_CAMO_CODCWL_NA_ELEVATE", camoIndex = 111 } },
    { models = { image = "menu_camo_cwl_envyus", name = "MPUI_CAMO_CODCWL_NA_ENVYUS", camoIndex = 112 } },
    { models = { image = "menu_camo_cwl_faze", name = "MPUI_CAMO_CODCWL_NA_FAZE", camoIndex = 113 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 114 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 115 } },
    { models = { image = "menu_camo_cwl_opticgaming", name = "MPUI_CAMO_CODCWL_NA_OPTICGAMING", camoIndex = 116 } },
    { models = { image = "menu_camo_cwl_rise_nation", name = "MPUI_CAMO_CODCWL_NA_RISE_NATION", camoIndex = 117 } },
    { models = { image = "menu_camo_loot_contract", name = "Ragequit", camoIndex = 118 } },
    { models = { image = "menu_camo_loot_contract_crystals", name = "MPUI_CAMO_LOOT_CONTRACT_CRYSTALS", camoIndex = 119 } },
    --{ models = { image = "menu_camo_cwl_base", name = "MPUI_CAMO_CODCWL", camoIndex = 120 } },
    { models = { image = "menu_camo_pap_dlc4_01", name = "Supernova", camoIndex = 121 } },
    { models = { image = "menu_camo_pap_dlc4_02", name = "MPUI_CAMO_ZMHD_EVENT_02", camoIndex = 122 } },
    { models = { image = "menu_camo_pap_dlc4_03", name = "Abyss", camoIndex = 123 } },
    { models = { image = "menu_camo_pap_dlc4_04", name = "MPUI_CAMO_ZMHD_LE_01", camoIndex = 124 } },
    { models = { image = "menu_camo_pap_dlc4_05", name = "Nebula", camoIndex = 125 } },
    { models = { image = "menu_camo_zmb_lucid_emissive", name = "MPUI_CAMO_ZM_LUCID", camoIndex = 126 } },
    --{ models = { image = "menu_camo_placeholder_pattern_24", name = "MPUI_CAMO_PLACEHOLDER_24", camoIndex = 127 } },
    --{ models = { image = "menu_camo_placeholder_pattern_25", name = "MPUI_CAMO_PLACEHOLDER_25", camoIndex = 128 } },
    --{ models = { image = "menu_camo_placeholder_pattern_26", name = "MPUI_CAMO_PLACEHOLDER_26", camoIndex = 129 } },
    --{ models = { image = "menu_camo_placeholder_pattern_27", name = "MPUI_CAMO_PLACEHOLDER_27", camoIndex = 130 } },
    { models = { image = "menu_camo_patricks_03", name = "MPUI_MTL_T7_CAMO_LOOT_PATRICKS_03", camoIndex = 131 } },
    { models = { image = "menu_camo_pap_bo1", name = "Circuit", camoIndex = 132 } },
    { models = { image = "menu_camo_pap_tomb", name = "Divinium", camoIndex = 133 } },
    { models = { image = "menu_camo_summertime_cherry_fiz", name = "MPUI_CAMO_CHERRY_FIZZ", camoIndex = 134 } },
    { models = { image = "menu_camo_summertime_vip_bubbles", name = "MPUI_CAMO_EMPIRE", camoIndex = 135 } },
    { models = { image = "menu_camo_winter_soviet_blue", name = "Permafrost", camoIndex = 136 } },
    { models = { image = "menu_camo_honeycomb", name = "MPUI_CAMO_HONEYCOMB_AMBER", camoIndex = 137 } },
    { models = { image = "menu_camo_watermelon", name = "MPUI_CAMO_WATERMELON", camoIndex = 138 } },
}

DataSources.StartMenu_CamoOptions = ListHelper_SetupDataSource( "StartMenu_CamoOptions", function( controller )
    local camoOptions = {}
    
    local controllerModel = Engine.GetModelForController( controller )
    local camoIndexModel = Engine.GetModel( controllerModel, "SelectedCamoIndex" )
    local selectedCamoModel = Engine.GetModel( controllerModel, "SelectedCamo" )
    local activeIndex = Engine.GetModelValue( camoIndexModel ) or 0

    if CoD.CamoTable ~= nil then
        for i = 1, #CoD.CamoTable do
            local camoEntry = CoD.CamoTable[i]

            if camoEntry.models then
                camoEntry.models.current = (camoEntry.models.camoIndex == activeIndex)
                camoEntry.models.action = function( element, event, controller, menu, actionParam )
				    Engine.SetModelValue( camoIndexModel, camoEntry.models.camoIndex )
				    Engine.SetModelValue( selectedCamoModel, camoEntry.models.name )
				    PlaySoundSetSound( element, "menu_enter" )
				end

                table.insert( camoOptions, camoEntry )
            end
        end
    end

    return camoOptions
end, true )

local SetCamoModels = function( self, controller )
	local controllerModel = Engine.GetModelForController( controller )
	local camoIndexModel = Engine.CreateModel( controllerModel, "SelectedCamoIndex" )
	local selectedCamoModel = Engine.CreateModel( controllerModel, "SelectedCamo" )

	if Engine.GetModelValue( camoIndexModel ) == nil then
        Engine.SetModelValue( camoIndexModel, 0 )
        Engine.SetModelValue( selectedCamoModel, "None" )
    end
end

local PreLoadFunc = function( self, controller )
	SetCamoModels( self, controller )
end

local PostLoadFunc = function( self, controller )
	self:subscribeToModel( Engine.GetModel( Engine.GetGlobalModel(), "fastRestart" ), function( model )
		SetCamoModels( self, controller )
	end )
end

CoD.StartMenu_CamoOptions = InheritFrom( LUI.UIElement )
CoD.StartMenu_CamoOptions.new = function( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.StartMenu_CamoOptions )
	self.id = "StartMenu_CamoOptions"
	self.soundSet = "ChooseDecal"
	self:setLeftRight( true, false, 0, 1150 )
	self:setTopBottom( true, false, 0, 520 )
	self:makeFocusable()
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

	self.buttonList = LUI.UIList.new( menu, controller, 8, 0, nil, true, false, 0, 0, false, false )
	self.buttonList:makeFocusable()
    self.buttonList:setLeftRight( true, false, 100, 600 )
    self.buttonList:setTopBottom( true, false, 30, 500 )
    self.buttonList:setDataSource( "StartMenu_CamoOptions" )
	self.buttonList:setWidgetType( CoD.StartMenu_CamoOptions_ListItem )
    self.buttonList:setVerticalCounter( CoD.verticalCounter )
    self.buttonList:setVerticalScrollbar( CoD.verticalScrollbar )
	self.buttonList:setHorizontalCount( 10 )
	self.buttonList:setVerticalCount( 5 )
	self.buttonList:setSpacing( 3 )
	self.buttonList:registerEventHandler( "gain_focus", function( element, event )
		local retval = nil
		if element.gainFocus then
			retval = element:gainFocus( event )
		elseif element.super.gainFocus then
			retval = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, menu, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS )
		return retval
	end )
	self.buttonList:registerEventHandler( "lose_focus", function( element, event )
		local retval = nil
		if element.loseFocus then
			retval = element:loseFocus( event )
		elseif element.super.loseFocus then
			retval = element.super:loseFocus( event )
		end
		return retval
	end )
	menu:AddButtonCallbackFunction( self.buttonList, controller, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "ENTER", function( element, event, controller, model )
        ProcessListAction( self, element, controller )
        return true
    end, function( element, menu, controller )
        CoD.Menu.SetButtonLabel( menu, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "MENU_SELECT" )
        return true
    end, false )
    self:addElement( self.buttonList )

	self.buttonList.id = "buttonList"

	self:registerEventHandler( "gain_focus", function( element, event )
		if element.m_focusable and element.buttonList:processEvent( event ) then
			return true
		else
			return LUI.UIElement.gainFocus( element, event )
		end
	end )

    LUI.OverrideFunction_CallOriginalFirst( self, "close", function( element )
        local controllerModel = Engine.GetModelForController( controller )
        local finalCamoIndex = Engine.GetModelValue( Engine.GetModel( controllerModel, "SelectedCamoIndex" ) )

        if finalCamoIndex ~= nil then
            Engine.SendMenuResponse( controller, "StartMenu_CamoOptions", finalCamoIndex )
        end
    end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function( element )
		element.buttonList:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end