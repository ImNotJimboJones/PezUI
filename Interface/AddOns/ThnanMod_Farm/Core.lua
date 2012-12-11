--[[ Plugin Variables ]]--

local _, FRM = ...;
FRM.pluginName = "Farm";
FRM.slashCommandTag = FRM.L.slashCmdTag;
FRM.config = {};
local config = FRM.config;

--[[ Default Config Values ]]--

config.showAutomatically = true;
config.hideInCombat = true;

--[[ Saved Variable Handlers ]]--

function FRM:loadSavedVars(global, realm, character)
	if (type(global) == "table") then
		config.hideInCombat = global.hideInCombat;
	end
	if (type(character) == "table") then
		config.showAutomatically = character.showAutomatically;
	end
end

function FRM:storeSavedVars()
	local global = {};
	global.hideInCombat = config.hideInCombat;
	local character = {};
	character.showAutomatically = config.showAutomatically;
	
	return global, nil, character;
end

--[[ Register With Framework ]]--

ThnanMod:registerPlugin(FRM);

--[[ Slash Command Handler ]]--

function FRM:slashCommandCalled(msg)
	if msg:lower() == FRM.L.slashCmdShow:lower() then
		FRM:showFarmFrame();
	else
		InterfaceOptionsFrame_OpenToCategory(FRM.configPanel);
	end
end