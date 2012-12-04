local _, addon = ...;
addon.L = {};
local L = addon.L;

L.slashCommand = "/ThnanMod";
L.loaded = "loaded. Type %s for options."; -- %s = slashCommand
L.configPanelText = "Many options appear here; please, peruse at your leisure.";

L.globalValue = "This value is shared between all characters";
L.realmValue = "This value is shared only between characters on this server";
L.localValue = "This value is set only for this character";

--[[ Template for other localizations ]]--

-- local locale = GetLocale();

--[[

if (locale == "<locale code>") then
	L.slashCommand = "/ThnanMod";
	L.loaded = "loaded. Type %s for options."; -- %s = slashCommand
	L.configPanelText = "Many options appear here; please, peruse at your leisure.";

	L.globalValue = "This value is shared between all characters";
	L.realmValue = "This value is shared only between characters on this server";
	L.localValue = "This value is set only for this character";
end

--]]