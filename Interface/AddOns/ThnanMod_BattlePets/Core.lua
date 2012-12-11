--[[ Plugin Variables ]]--

local _, WPT = ...;
WPT.pluginName = "BattlePets";
WPT.slashCommandTag = WPT.L.slashCmdTag;
WPT.config = {};
local config = WPT.config;

--[[ Default Config Values ]]--

config.enabled = true;
config.showLevelInWorld = true;
config.showLevelInBattle = true;
config.showLevelInMinimap = false;
config.colorReleaseDialog = true;

--[[ Saved Variable handlers ]]--

local currentDataVersion = 1;

--[[ version nil
global.enabled
]]--
--[[ version 1
global.enabled
global.showLevelInWorld
global.showLevelInBattle
global.showLevelInMinimap
global.colorReleaseDialog
]]--

function WPT:loadSavedVars(global, realm, character)
	if type(global) == "table" then
		if not global.dataVersion then
			config.enabled = global.enabled;
		elseif global.dataVersion == 1 then
			config.enabled = global.enabled;
			config.showLevelInWorld = global.showLevelInWorld;
			config.showLevelInBattle = global.showLevelInBattle;
			config.showLevelInMinimap = global.showLevelInMinimap;
			config.colorReleaseDialog = global.colorReleaseDialog;
		end
	end
end

function WPT:storeSavedVars()
	local global = {};
	global.dataVersion = currentDataVersion;
	global.enabled = config.enabled;
	global.showLevelInWorld = config.showLevelInWorld;
	global.showLevelInBattle = config.showLevelInBattle;
	global.showLevelInMinimap = config.showLevelInMinimap;
	global.colorReleaseDialog = config.colorReleaseDialog;
	return global, nil, nil;
end

--[[ Register With Framework ]]--

ThnanMod:registerPlugin(WPT);