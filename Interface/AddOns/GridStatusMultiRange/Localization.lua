--[[--------------------------------------------------------------------
	GridStatusMultiRange Localization
----------------------------------------------------------------------]]

local _, ns = ...

if Grid:GetModule("GridRange", true) then -- old version of Grid, quit.
	ns.noLoad = true
	return
end

local L = setmetatable({ }, { __index = Grid.L })
ns.L = L

local LOCALE = GetLocale()

if LOCALE == "deDE" then

	L["(%d+) yd range"] = "(%d+) Meter Reichweite"
	L["More than %d yards away"] = "Mehr als %d meter entfernt"
	L["%d yards"] = "%d meter"
	L["<range>"] = "<entfernung>"

elseif LOCALE == "esES" or LOCALE == "esMX" then

	L["(%d+) yd range"] = "Alcance de (%d+) m"
	L["More than %d yards away"] = "Más de %d metros"
	L["%d yards"] = "%d metros"
	L["<range>"] = "<rango>"

elseif LOCALE == "frFR" then

	L["(%d+) yd range"] = "(%d+) m de portée"
	L["More than %d yards away"] = "À plus de %d mètres"
	L["%d yards"] = "%d mètres"
	L["<range>"] = "<portée>"

elseif LOCALE == "ptBR" then

	L["(%d+) yd range"] = "Alcance de (%d+) m"
	L["More than %d yards away"] = "Mais de %d metros"
	L["%d yards"] = "%d metros"
	L["<range>"] = "<alcance>"

elseif LOCALE == "ruRU" then

	L["(%d+) yd range"] = "Радиус действия: (%d+) м"
	L["More than %d yards away"] = "Дальше чем %d м."
	L["%d yards"] = "%d м."
	L["<range>"] = "<расстояние>"

elseif LOCALE == "koKR" then

	L["(%d+) yd range"] = "(%d+)미터"
	L["More than %d yards away"] = "%d 미터 이상"
	L["%d yards"] = "%d 미터"
	L["<range>"] = "<범위>"

elseif LOCALE == "zhCN" then

	L["(%d+) yd range"] = "(%d+)码射程"
	L["Seconds between range checks"] = "多少秒检测一次距离"
	L["More than %d yards away"] = "距离超过%d码"
	L["%d yards"] = "%d码"
	L["<range>"] = "<距离>"

elseif LOCALE == "zhTW" then

	L["(%d+) yd range"] = "(%d+)碼距離"
	L["More than %d yards away"] = "距離超過%d碼"
	L["%d yards"] = "%d 碼"
	L["<range>"] = "<距離>"

end