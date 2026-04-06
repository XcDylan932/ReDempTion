CoD.UIColors = {}

CoD.UIColors.Colors = {
	["rainbow"] = { r = 255/255, g = 100/255, b = 100/255 },
	["crimson"] = { r = 220/255, g = 20/255,   b = 60/255 },
	["red"] 	= { r = 255/255, g = 100/255, b = 100/255 },
	["orange"] 	= { r = 255/255, g = 115/255, b = 0/255 },
	["yellow"] 	= { r = 255/255, g = 243/255, b = 99/255 },
	["gold"] 	= { r = 255/255, g = 200/255, b = 0/255 },
	["lime"] 	= { r = 180/255, g = 255/255, b = 0/255 },
	["green"] 	= { r = 99/255, g = 255/255, b = 114/255 },
	["teal"]    = { r = 0/255,   g = 150/255, b = 150/255 },
	["cyan"] 	= { r = 0/255,   g = 255/255, b = 255/255 },
	["blue"] 	= { r = 99/255,  g = 203/255, b = 255/255 },
	["lavender"] = { r = 200/255, g = 160/255, b = 255/255 },
	["purple"] 	= { r = 169/255, g = 99/255, b = 255/255 },
	["magenta"] = { r = 255/255, g = 100/255,   b = 255/255 },
	["pink"] 	= { r = 255/255, g = 138/255, b = 251/255 },
	["silver"] = { r = 180/255, g = 190/255, b = 210/255 },
	["white"] 	= { r = 255/255, g = 255/255, b = 255/255 },
}

CoD.UIColors.SetElementColor = function( element, color )
	if element and color then
		local colorKey = string.lower( tostring( color ) )
		
		if CoD.UIColors.Colors[colorKey] then
			local copy = CoD.UIColors.Colors[colorKey]
			element:setRGB( copy.r, copy.g, copy.b )
		else
			local fallback = CoD.UIColors.Colors["orange"]
			element:setRGB( fallback.r, fallback.g, fallback.b )
		end
	end
end