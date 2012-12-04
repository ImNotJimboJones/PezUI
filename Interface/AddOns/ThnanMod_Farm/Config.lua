local _, FRM = ...;

--[[ Config Variables ]]--

local config = FRM.config;
local L = FRM.L;

--[[ Config change methods ]]--

function config:setShowAutomatically(value)
	if (value and not config.showAutomatically) then
		config.showAutomatically = true;
	elseif (not value and config.showAutomatically) then
		config.showAutomatically = false;
	end
end

--[[ Create Config Panel ]]--

local factory = ThnanMod.Config;

local configPanel = factory:createConfigPanel(L.pluginName, L.pluginDescription);
FRM.configPanel = configPanel;

local showAutomaticallyCheckBox = factory:createCheckBox(configPanel, L.showAutomaticallyCheckBoxLabel, L.showAutomaticallyCheckBoxTooltip, "local");

showAutomaticallyCheckBox:setBelow(configPanel.subtitle);

configPanel.default = function(self)
	config:setShowAutomatically(true);
end
configPanel.okay = function(self)
	config:setShowAutomatically(showAutomaticallyCheckBox:GetChecked());
end
configPanel.refresh = function(self)
	showAutomaticallyCheckBox:SetChecked(config.showAutomatically);
end