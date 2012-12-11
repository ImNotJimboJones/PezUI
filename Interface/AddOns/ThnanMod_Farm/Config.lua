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
function config:setHideInCombat(value)
	if (value and not config.hideInCombat) then
		config.hideInCombat = true;
	elseif (not value and config.hideInCombat) then
		config.hideInCombat = false;
	end
end

--[[ Create Config Panel ]]--

local factory = ThnanMod.Config;

local configPanel = factory:createConfigPanel(L.pluginName, L.pluginDescription);
FRM.configPanel = configPanel;

local showAutomaticallyCheckBox = factory:createCheckBox(configPanel, L.showAutomaticallyCheckBoxLabel, L.showAutomaticallyCheckBoxTooltip, "local");
showAutomaticallyCheckBox:setBelow(configPanel.subtitle);

local hideInCombatCheckBox = factory:createCheckBox(configPanel, L.hideInCombatCheckBoxLabel, L.hideInCombatCheckBoxTooltip, "global");
hideInCombatCheckBox:setBelow(showAutomaticallyCheckBox);

configPanel.default = function(self)
	config:setShowAutomatically(true);
	config:setHideInCombat(true);
end
configPanel.okay = function(self)
	config:setShowAutomatically(showAutomaticallyCheckBox:GetChecked());
	config:setHideInCombat(hideInCombatCheckBox:GetChecked());
end
configPanel.refresh = function(self)
	showAutomaticallyCheckBox:SetChecked(config.showAutomatically);
	hideInCombatCheckBox:SetChecked(config.hideInCombat);
end