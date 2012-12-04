local addonName, addon = ...

addon.L = {};
local L = addon.L;

L.slashCmdTag = "pets";
L.caught = "Best Quality: %s"; -- %s = pet rarity name
L.notCaught = "None Captured";
L.pluginName = "Battle Pets";
L.pluginDescription = "Adds a line to wild pet tooltips telling you if you've caught the pet or not. This line will be colored and labled according to the highest rarity pet of that type you own.\n\nThis config panel can be accessed directly by typing \"/ThnanMod pets\"";
L.enabledCheckBoxLabel = "Enabled";
L.enabledCheckBoxTooltip = "Controls if tooltip lines are added to wild pets.";

--[[ Template for other localizations ]]--

-- local locale = GetLocale();

--[[

if (locale == "<locale code>") then
	L.slashCmdTag = "pets";
	L.caught = "Best Quality: %s"; -- %s = pet rarity name
	L.notCaught = "None Captured";
	L.pluginName = "Battle Pets";
	L.pluginDescription = "Adds a line to wild pet tooltips telling you if you've caught the pet or not. This line will be colored and labled according to the highest rarity pet of that type you own.\n\nThis config panel can be accessed directly by typing \"/ThnanMod pets\"";
	L.enabledCheckBoxLabel = "Enabled";
	L.enabledCheckBoxTooltip = "Controls if tooltip lines are added to wild pets.";
end

--]]