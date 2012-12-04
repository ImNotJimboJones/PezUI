--[[ Plugin Variables ]]--

local _, WPT = ...;
WPT.pluginName = "BattlePets";
WPT.slashCommandTag = WPT.L.slashCmdTag;
WPT.config = {};
local config = WPT.config;

--[[ Default Config Values ]]--

config.enabled = true;

--[[ Saved Variable handlers ]]--

function WPT:loadSavedVars(global, realm, character)
	if type(global) == "table" then
		config.enabled = global.enabled;
	end
end

function WPT:storeSavedVars()
	local global = {};
	global.enabled = config.enabled;
	
	return global, nil, nil;
end

--[[ Register With Framework ]]--

ThnanMod:registerPlugin(WPT);