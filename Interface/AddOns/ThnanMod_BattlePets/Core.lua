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
config.showLevelInItems = true;
config.colorReleaseDialog = true;
config.showAdditionalPets = true;

--[[ Saved Variable handlers ]]--

local currentDataVersion = 3;

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
--[[ version 2
global.enabled
global.showLevelInWorld
global.showLevelInBattle
global.showLevelInMinimap
global.colorReleaseDialog
global.showAdditionalPets
]]--
--[[ version 3
global.enabled
global.showLevelInWorld
global.showLevelInBattle
global.showLevelInMinimap
global.showLevelInItems
global.colorReleaseDialog
global.showAdditionalPets
]]--

function WPT:loadSavedVars(global, realm, character)
	if type(global) == "table" then
		if not global.dataVersion then
			global.dataVersion = 0;
		end
		config.enabled = global.enabled;
		if global.dataVersion >= 1 then
			config.showLevelInWorld = global.showLevelInWorld;
			config.showLevelInBattle = global.showLevelInBattle;
			config.showLevelInMinimap = global.showLevelInMinimap;
			config.colorReleaseDialog = global.colorReleaseDialog;
		end
		if global.dataVersion >= 2 then
			config.showAdditionalPets = global.showAdditionalPets;
		end
		if global.dataVersion == 3 then
			config.showLevelInItems = global.showLevelInItems;
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
	global.showLevelInItems = config.showLevelInItems;
	global.colorReleaseDialog = config.colorReleaseDialog;
	global.showAdditionalPets = config.showAdditionalPets;
	return global, nil, nil;
end

--[[ Register With Framework ]]--

ThnanMod:registerPlugin(WPT);