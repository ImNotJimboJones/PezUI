local addonName, addon = ...;

addon.L = {};
local L = addon.L;

L.slashCmdTag = "farm";
L.slashCmdShow = "show";
L.growCheckTitle = "Grow Check";
L.growCheckDescription = "This button will target any plant needing attention.";
L.dropToolsTitle = "Drop All Tools";
L.dropToolsDescription = "This button will drop all farm tools in your inventory.";
L.farmWindowLabelText = "Farming Tool Panel";
L.farmWindowForecastLabel = "Forecast";
L.farmWindowForecastChange = "(Update in %d:%02d)"; -- %d = hours, %02d = minutes
L.forecastSeedButtonTooltip = "If you plant this seed today, you will get extra crops tomorrow";
L.forecastSeedNoInfoTooltip = "No forecast information available for today's seed. Talk to Jogu the Drunk to learn about tomorrow's crops";
L.forecastCropButtonTooltip = "If you harvest this crop today, you will get more than usual";
L.forecastCropNoInfoTooltip = "No forecast information available for today's crop. You should have talked to Jogu yesterday!";
L.farmWindowShowInCombatError = "Sorry, can't do that in combat. Try again later!";

L.pluginName = "Farm";
L.pluginDescription = "Adds a button panel for farming tasks.\n\nThis config panel can be accessed directly by typing /ThnanMod farm.\nThe tool panel can be shown at any time by typing /ThnanMod farm show.";
L.visibilityLabelText = "Visibility Options";
L.dropLabelText = "Tool Drop Options";
L.showAutomaticallyCheckBoxLabel = "Show farm window on farm";
L.showAutomaticallyCheckBoxTooltip = "This option will cause the farm tool panel to appear when entering Sunsong Ranch and disappear when leaving.";
L.hideInCombatCheckBoxLabel = "Hide in combat";
L.hideInCombatCheckBoxTooltip = "This option will cause the farm tool panel to hide when entering combat and reappear when leaving combat.";
L.hideWhenEmptyCheckBoxLabel = "Hide when you don't have seeds/tools";
L.hideWhenEmptyCheckBoxTooltip = "This option will cause the farm tool panel to hide when you don't have seeds or tools in your inventory and reappear when you acquire a seed or tool.";
L.hideInVehicleCheckBoxLabel = "Hide in \"vehicle\" plants";
L.hideInVehicleCheckBoxTooltip = "This option will cause the farm tool panel to hide when entering plant \"vehicles\" and reappear when leaving.";
L.dropOnRightClickCheckBoxLabel = "Drop tool on right click";
L.dropOnRightClickCheckBoxTooltip = "This option will make right clicking a tool button drop that tool."
L.dropOnLeavingFarmCheckBoxLabel = "Drop tools when leaving farm";
L.dropOnLeavingFarmCheckBoxTooltip = "This option will make you drop all the farm tools when you leave the farm.";


L.sunsongRanchName = "Sunsong Ranch";
L.joguPredictsGreenCabbage = "Oooh... ooooh! My senses are tingling! I see... huge Green Cabbages in your future."; -- unconfirmed
L.joguPredictsScallion = "Have I ever told you that I hate Scallions? Hate 'em!\n\n<Jogu lets out a loud belch.>\n\nUnfortunately for me, they're going to be in high season tomorrow.";
L.joguPredictsRedBlossomLeek = "Shpring for a leek, and you might get two."; -- unconfirmed
L.joguPredictsWhiteTurnip = "Fields of white turnips. Raw and shipicy!"; -- unconfirmed
L.joguPredictsWitchberry = "Which berries should you plant? Witchberries, of course!"; -- unconfirmed
L.joguPredictsJuicycrunchCarrot = "You ever heard of a juicycrunch carrot? They'll never be juicier than tomorrow."; -- unconfirmed
L.joguPredictsMoguPumpkin = "Pumpkins! It'sh gonna be huge, gigantic pumpkins!";
L.joguPredictsPinkTurnip = "I'm seeing Pink Turnipsh in your future.";
L.joguPredictsJadeSquash = "Jade Squash grow the color of milky jade. Conditionsh will be perfect tomorrow for growing thish vegetable... I think.";
L.joguPredictsStripedMelon = "Striped melons are quite juishy this time of year! Put some sheeds in the ground, and you will reap the harvest on the morrow.";

--[[ Template for other localizations ]]--

local locale = GetLocale();

--[[

if (locale == "<locale code>") then
	L.slashCmdTag = "farm";
	L.slashCmdShow = "show";
	L.growCheckTitle = "Grow Check";
	L.growCheckDescription = "This button will target any plant needing attention.";
	L.dropToolsTitle = "Drop All Tools";
	L.dropToolsDescription = "This button will drop all farm tools in your inventory.";
	L.farmWindowLabelText = "Farming Tool Panel";
	L.farmWindowForecastLabel = "Forecast";
	L.farmWindowForecastChange = "(Update in %d:%02d)"; -- %d = hours, %02d = minutes
	L.forecastSeedButtonTooltip = "If you plant this seed today, you will get extra crops tomorrow";
	L.forecastSeedNoInfoTooltip = "No forecast information available for today's seed. Talk to Jogu the Drunk to learn about tomorrow's crops";
	L.forecastCropButtonTooltip = "If you harvest this crop today, you will get more than usual";
	L.forecastCropNoInfoTooltip = "No forecast information available for today's crop. You should have talked to Jogu yesterday!";
	L.farmWindowShowInCombatError = "Sorry, can't do that in combat. Try again later!";
	
	L.pluginName = "Farm";
	L.pluginDescription = "Adds a button panel for farming tasks.\n\nThis config panel can be accessed directly by typing /ThnanMod farm.\nThe tool panel can be shown at any time by typing /ThnanMod farm show.";
	L.visibilityLabelText = "Visibility Options";
	L.dropLabelText = "Tool Drop Options";
	L.showAutomaticallyCheckBoxLabel = "Show farm window on farm";
	L.showAutomaticallyCheckBoxTooltip = "This option will cause the farm tool panel to appear when entering Sunsong Ranch and disappear when leaving.";
	L.hideInCombatCheckBoxLabel = "Hide in combat";
	L.hideInCombatCheckBoxTooltip = "This option will cause the farm tool panel to hide when entering combat and reappear when leaving combat.";
	L.hideWhenEmptyCheckBoxLabel = "Hide when you don't have seeds/tools";
	L.hideWhenEmptyCheckBoxTooltip = "This option will cause the farm tool panel to hide when you don't have seeds or tools in your inventory and reappear when you acquire a seed or tool.";
	L.hideInVehicleCheckBoxLabel = "Hide in \"vehicle\" plants";
	L.hideInVehicleCheckBoxTooltip = "This option will cause the farm tool panel to hide when entering plant \"vehicles\" and reappear when leaving.";
	L.dropOnRightClickCheckBoxLabel = "Drop tool on right click";
	L.dropOnRightClickCheckBoxTooltip = "This option will make right clicking a tool button drop that tool."
	L.dropOnLeavingFarmCheckBoxLabel = "Drop tools when leaving farm";
	L.dropOnLeavingFarmCheckBoxTooltip = "This option will make you drop all the farm tools when you leave the farm.";
end

--]]

if (locale == "ptBR") then
	L.sunsongRanchName = "Fazenda Sol Cantante";
	L.joguPredictsGreenCabbage = "";
	L.joguPredictsScallion = "";
	L.joguPredictsRedBlossomLeek = "";
	L.joguPredictsWhiteTurnip = "";
	L.joguPredictsWitchberry = "";
	L.joguPredictsJuicycrunchCarrot = "";
	L.joguPredictsMoguPumpkin = "";
	L.joguPredictsPinkTurnip = "";
	L.joguPredictsJadeSquash = "Abóborash de Jade ficam da cor de jade leitoso. Ash condichões eshtarão perfeitash amanhã para plantar esshe vegetal... Eu acho.";
	L.joguPredictsStripedMelon = "Melõesh lishtrados shão bem shuculentosh nesha eshtachão! Plante umash shementes e vochê terá shua colheita amanhã.";
end

if (locale == "frFR") then
	L.sunsongRanchName = "Ferme Chant du Soleil";
	L.joguPredictsGreenCabbage = "";
	L.joguPredictsScallion = "";
	L.joguPredictsRedBlossomLeek = "";
	L.joguPredictsWhiteTurnip = "";
	L.joguPredictsWitchberry = "";
	L.joguPredictsJuicycrunchCarrot = "";
	L.joguPredictsMoguPumpkin = "";
	L.joguPredictsPinkTurnip = "";
	L.joguPredictsJadeSquash = "";
	L.joguPredictsStripedMelon = "";
end

if (locale == "deDE") then
	L.sunsongRanchName = "Gehöft Sonnensang";
	L.joguPredictsGreenCabbage = "";
	L.joguPredictsScallion = "";
	L.joguPredictsRedBlossomLeek = "";
	L.joguPredictsWhiteTurnip = "";
	L.joguPredictsWitchberry = "";
	L.joguPredictsJuicycrunchCarrot = "";
	L.joguPredictsMoguPumpkin = "";
	L.joguPredictsPinkTurnip = "";
	L.joguPredictsJadeSquash = "";
	L.joguPredictsStripedMelon = "";
end

if (locale == "itIT") then
	L.sunsongRanchName = "Tenuta Cantasole";
	L.joguPredictsGreenCabbage = "";
	L.joguPredictsScallion = "";
	L.joguPredictsRedBlossomLeek = "";
	L.joguPredictsWhiteTurnip = "";
	L.joguPredictsWitchberry = "";
	L.joguPredictsJuicycrunchCarrot = "";
	L.joguPredictsMoguPumpkin = "";
	L.joguPredictsPinkTurnip = "";
	L.joguPredictsJadeSquash = "";
	L.joguPredictsStripedMelon = "";
end

if (locale == "koKR") then
	L.sunsongRanchName = "태양노래 농장";
	L.joguPredictsGreenCabbage = "";
	L.joguPredictsScallion = "";
	L.joguPredictsRedBlossomLeek = "";
	L.joguPredictsWhiteTurnip = "";
	L.joguPredictsWitchberry = "";
	L.joguPredictsJuicycrunchCarrot = "";
	L.joguPredictsMoguPumpkin = "";
	L.joguPredictsPinkTurnip = "";
	L.joguPredictsJadeSquash = "";
	L.joguPredictsStripedMelon = "";
end

if (locale == "esES" or locale == "esMX") then
	L.sunsongRanchName = "Rancho Cantosol";
	L.joguPredictsGreenCabbage = "";
	L.joguPredictsScallion = "";
	L.joguPredictsRedBlossomLeek = "";
	L.joguPredictsWhiteTurnip = "";
	L.joguPredictsWitchberry = "";
	L.joguPredictsJuicycrunchCarrot = "";
	L.joguPredictsMoguPumpkin = "";
	L.joguPredictsPinkTurnip = "";
	L.joguPredictsJadeSquash = "Losh calabacinesh de jade son del color del jade claro. Mañana lash condicionesh para cultivarlosh serán perfectash... en mi opinión.";
	L.joguPredictsStripedMelon = "¡Losh melonesh a rayash eshtán muy jugoshosh en eshta época del año! Planta semillash en la tierra y mañana tendrásh la cosecha.";
end

if (locale == "ruRU") then
	L.sunsongRanchName = "Ферма Солнечной Песни";
	L.joguPredictsGreenCabbage = "";
	L.joguPredictsScallion = "";
	L.joguPredictsRedBlossomLeek = "";
	L.joguPredictsWhiteTurnip = "";
	L.joguPredictsWitchberry = "";
	L.joguPredictsJuicycrunchCarrot = "";
	L.joguPredictsMoguPumpkin = "";
	L.joguPredictsPinkTurnip = "";
	L.joguPredictsJadeSquash = "";
	L.joguPredictsStripedMelon = "";
end

if (locale == "zhCN") then
	L.sunsongRanchName = "日歌农场";
	L.joguPredictsGreenCabbage = "";
	L.joguPredictsScallion = "";
	L.joguPredictsRedBlossomLeek = "";
	L.joguPredictsWhiteTurnip = "";
	L.joguPredictsWitchberry = "";
	L.joguPredictsJuicycrunchCarrot = "";
	L.joguPredictsMoguPumpkin = "";
	L.joguPredictsPinkTurnip = "";
	L.joguPredictsJadeSquash = "";
	L.joguPredictsStripedMelon = "";
end

if (locale == "zhTW") then
	L.sunsongRanchName = "日歌農莊";
	L.joguPredictsGreenCabbage = "";
	L.joguPredictsScallion = "";
	L.joguPredictsRedBlossomLeek = "";
	L.joguPredictsWhiteTurnip = "";
	L.joguPredictsWitchberry = "";
	L.joguPredictsJuicycrunchCarrot = "";
	L.joguPredictsMoguPumpkin = "";
	L.joguPredictsPinkTurnip = "";
	L.joguPredictsJadeSquash = "";
	L.joguPredictsStripedMelon = "";
end