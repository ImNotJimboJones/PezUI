local addonName, addon = ...;

addon.L = {};
local L = addon.L;

L.pluginName = "Farm";
L.slashCmdTag = "farm";
L.slashCmdShow = "show";
L.pluginDescription = "Adds a button panel for farming tasks.\n\nThis config panel can be accessed directly by typing /ThnanMod farm.\nThe tool panel can be shown at any time by typing /ThnanMod farm show.";
L.growCheckTitle = "Grow Check";
L.growCheckDescription = "This button will target any plant needing attention.";
L.farmWindowLabelText = "Farming Tool Panel";

L.sunsongRanchName = "Sunsong Ranch";

L.showAutomaticallyCheckBoxLabel = "Show Farm Window on Farm";
L.showAutomaticallyCheckBoxTooltip = "This option will cause the farm tool panel to appear when zoning in to Sunsong Ranch";

--[[ Template for other localizations ]]--

local locale = GetLocale();

--[[

if (locale == "<locale code>") then
	L.pluginName = "Farm";
	L.slashCmdTag = "farm";
	L.slashCmdShow = "show";
	L.pluginDescription = "Adds a button panel for farming tasks.\n\nThis config panel can be accessed directly by typing /ThnanMod farm.\nThe tool panel can be shown at any time by typing /ThnanMod farm show.";
	L.growCheckTitle = "Grow Check";
	L.growCheckDescription = "This button will target any plant needing attention.";
	L.farmWindowLabelText = "Farming Tool Panel";

	L.sunsongRanchName = "Sunsong Ranch";

	L.showAutomaticallyCheckBoxLabel = "Show Farm Window on Farm";
	L.showAutomaticallyCheckBoxTooltip = "This option will cause the farm tool panel to appear when zoning in to Sunsong Ranch";
end

--]]

if (locale == "ptBR") then
	L.sunsongRanchName = "Fazenda Sol Cantante";
end

if (locale == "frFR") then
	L.sunsongRanchName = "Ferme Chant du Soleil";
end

if (locale == "deDE") then
	L.sunsongRanchName = "Gehöft Sonnensang";
end

if (locale == "itIT") then
	L.sunsongRanchName = "Tenuta Cantasole";
end

if (locale == "koKR") then
	L.sunsongRanchName = "태양노래 농장";
end

if (locale == "esES" or locale == "esMX") then
	L.sunsongRanchName = "Rancho Cantosol";
end

if (locale == "ruRU") then
	L.sunsongRanchName = "Ферма Солнечной Песни";
end

if (locale == "zhCN") then
	L.sunsongRanchName = "日歌农场";
end

if (locale == "zhTW") then
	L.sunsongRanchName = "日歌農莊";
end