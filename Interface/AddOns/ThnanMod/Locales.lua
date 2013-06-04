local _, addon = ...;
addon.L = {};
local L = addon.L;

L.slashCommand = "/ThnanMod";
L.loaded = "loaded. Type %s for options and an important notice."; -- %s = slashCommand

L.configPanelText = "Many options appear here; please, peruse at your leisure.\n\nFor North American servers, the correct daily reset time is 11. For Oceanic servers, it is 17. Much apologisings to other regions, but I don't know what your times should be. If you do, please let me know.\
\n THIS MOD HAS BEEN SPLIT INTO SEPARATE PROJECTS FOR EACH MODULE. Future updates will only be available through the other projects. See the website for more information.";
L.dailyResetTimeLabel = "Daily reset time in GMT"
L.dailyResetTimeTooltip = "This is the GMT timezone hour that daily quests will reset.";

L.globalValue = "This value is shared between all characters";
L.realmValue = "This value is shared only between characters on this server";
L.localValue = "This value is set only for this character";

--[[ Template for other localizations ]]--

-- local locale = GetLocale();

--[[

if (locale == "<locale code>") then
	L.slashCommand = "/ThnanMod";
	L.loaded = "loaded. Type %s for options."; -- %s = slashCommand
	
	L.configPanelText = "Many options appear here; please, peruse at your leisure.\n\nFor North American servers, the correct daily reset time is 11. For Oceanic servers, it is 17. Much apologisings to other regions, but I don't know what your times should be. If you do, please let me know.";
	L.dailyResetTimeLabel = "Daily reset time in GMT"
	L.dailyResetTimeTooltip = "This is the GMT timezone hour that daily quests will reset.";
	
	L.globalValue = "This value is shared between all characters";
	L.realmValue = "This value is shared only between characters on this server";
	L.localValue = "This value is set only for this character";
end

--]]