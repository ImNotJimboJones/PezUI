local addonName, addon = ...

addon.L = {};
local L = addon.L;

L.slashCmdTag = "pets";
L.caught = "Best Quality: %s"; -- %s = pet rarity name
L.alsoCaught = "Also Caught: %s"; -- %s = pet rarity name
L.caughtLevel = "(lvl %d)"; -- %d = level
L.notCaught = "None Captured";
L.confirmationDialogPetInfoString = "%s (%s, lvl %d)"; -- first %s = pet name, second %s = pet rarity, %d = level

L.pluginName = "Battle Pets";
L.pluginDescription = "Adds a line to wild pet tooltips telling you if you've caught the pet or not. This line will be colored and labled according to the highest rarity pet of that type you own.\n\nThis config panel can be accessed directly by typing \"/ThnanMod pets\"";
L.enabledCheckBoxLabel = "Enabled";
L.enabledCheckBoxTooltip = "Controls if tooltip lines are added to wild pets.";
L.levelInWorldCheckBoxLabel = "Show pet level in world tooltips";
L.levelInWorldCheckBoxTooltip = "Enabling this option will cause world tooltips to include the level of the highest rarity pet";
L.levelInBattleCheckBoxLabel = "Show pet level in battle tooltips";
L.levelInBattleCheckBoxTooltip = "Enabling this option will cause battle tooltips to include the level of the highest rarity pet";
L.levelInMinimapCheckBoxLabel = "Show pet level in minimap tooltips";
L.levelInMinimapCheckBoxTooltip = "Enabling this option will cause minimap tooltips to include the level of the highest rarity pet";
L.colorReleaseDialogCheckBoxLabel = "Color release dialog text";
L.colorReleaseDialogCheckBoxTooltip = "This option causes rarity and level info for the pet being released to appear in the release dialog";
L.showAdditionalPetsCheckBoxLabel = "Show Additional Pets";
L.showAdditionalPetsCheckBoxTooltip = "This option causes world and battle tooltips to include all pets.";

--[[ Template for other localizations ]]--

-- local locale = GetLocale();

--[[

if (locale == "<locale code>") then
	L.slashCmdTag = "pets";
	L.caught = "Best Quality: %s"; -- %s = pet rarity name
	L.alsoCaught = "Also Caught: %s"; -- %s = pet rarity name
	L.caughtLevel = "(lvl %d)"; -- %d = level
	L.notCaught = "None Captured";
	L.confirmationDialogPetInfoString = "%s (%s, lvl %d)"; -- first %s = pet name, second %s = pet rarity, %d = level
	
	L.pluginName = "Battle Pets";
	L.pluginDescription = "Adds a line to wild pet tooltips telling you if you've caught the pet or not. This line will be colored and labled according to the highest rarity pet of that type you own.\n\nThis config panel can be accessed directly by typing \"/ThnanMod pets\"";
	L.enabledCheckBoxLabel = "Enabled";
	L.enabledCheckBoxTooltip = "Controls if tooltip lines are added to wild pets.";
	L.levelInWorldCheckBoxLabel = "Show pet level in world tooltips";
	L.levelInWorldCheckBoxTooltip = "Enabling this option will cause world tooltips to include the level of the highest rarity pet";
	L.levelInBattleCheckBoxLabel = "Show pet level in battle tooltips";
	L.levelInBattleCheckBoxTooltip = "Enabling this option will cause battle tooltips to include the level of the highest rarity pet";
	L.levelInMinimapCheckBoxLabel = "Show pet level in minimap tooltips";
	L.levelInMinimapCheckBoxTooltip = "Enabling this option will cause minimap tooltips to include the level of the highest rarity pet";
	L.colorReleaseDialogCheckBoxLabel = "Color release dialog text";
	L.colorReleaseDialogCheckBoxTooltip = "This option causes rarity and level info for the pet being released to appear in the release dialog";
	L.showAdditionalPetsCheckBoxLabel = "Show Additional Pets";
	L.showAdditionalPetsCheckBoxTooltip = "This option causes world and battle tooltips to include all pets.";
end

--]]