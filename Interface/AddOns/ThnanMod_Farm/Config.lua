local _, FRM = ...;

--[[ Config Variables ]]--

local config = FRM.config;
local L = FRM.L;

--[[ Config change methods ]]--

function config:setShowAutomatically(value)
	if (value and not config.showAutomatically) then
		config.showAutomatically = true;
		FRM:farmWindowAutoShowEvent("config");
	elseif (not value and config.showAutomatically) then
		config.showAutomatically = false;
		FRM:farmWindowAutoShowEvent("config");
	end
end
function config:setHideInCombat(value)
	if (value and not config.hideInCombat) then
		config.hideInCombat = true;
		FRM:farmWindowAutoShowEvent("config");
	elseif (not value and config.hideInCombat) then
		config.hideInCombat = false;
		FRM:farmWindowAutoShowEvent("config");
	end
end
function config:setHideWhenEmpty(value)
	if (value and not config.hideWhenEmpty) then
		config.hideWhenEmpty = true;
		FRM:farmWindowAutoShowEvent("config");
	elseif (not value and config.hideWhenEmpty) then
		config.hideWhenEmpty = false;
		FRM:farmWindowAutoShowEvent("config");
	end
end
function config:setHideInVehicle(value)
	if (value and not config.hideInVehicle) then
		config.hideInVehicle = true;
		FRM:farmWindowAutoShowEvent("config");
	elseif (not value and config.hideInVehicle) then
		config.hideInVehicle = false;
		FRM:farmWindowAutoShowEvent("config");
	end
end
function config:setDropOnRightClick(value)
	if (value and not config.dropOnRightClick) then
		config.dropOnRightClick = true;
	elseif (not value and config.dropOnRightClick) then
		config.dropOnRightClick = false;
	end
end
function config:setDropOnLeavingFarm(value)
	if (value and not config.dropOnLeavingFarm) then
		config.dropOnLeavingFarm = true;
	elseif (not value and config.dropOnLeavingFarm) then
		config.dropOnLeavingFarm = false;
	end
end

--[[ Create Config Panel ]]--

local factory = ThnanMod.Config;

local configPanel = factory:createConfigPanel(L.pluginName, L.pluginDescription);
FRM.configPanel = configPanel;

local visibilityLabel = factory:createLabel(configPanel, L.visibilityLabelText);
visibilityLabel:setBelow(configPanel.subtitle);

local showAutomaticallyCheckBox = factory:createCheckBox(configPanel, L.showAutomaticallyCheckBoxLabel, L.showAutomaticallyCheckBoxTooltip, "local");
showAutomaticallyCheckBox:setBelow(visibilityLabel);

local hideInCombatCheckBox = factory:createCheckBox(configPanel, L.hideInCombatCheckBoxLabel, L.hideInCombatCheckBoxTooltip, "global");
hideInCombatCheckBox:setBelow(showAutomaticallyCheckBox);

local hideWhenEmptyCheckBox = factory:createCheckBox(configPanel, L.hideWhenEmptyCheckBoxLabel, L.hideWhenEmptyCheckBoxTooltip, "global");
hideWhenEmptyCheckBox:setBelow(hideInCombatCheckBox);

local hideInVehicleCheckBox = factory:createCheckBox(configPanel, L.hideInVehicleCheckBoxLabel, L.hideInVehicleCheckBoxTooltip, "global");
hideInVehicleCheckBox:setBelow(hideWhenEmptyCheckBox);

local dropLabel = factory:createLabel(configPanel, L.dropLabelText);
dropLabel:setBelow(hideInVehicleCheckBox);

local dropOnRightClickCheckBox = factory:createCheckBox(configPanel, L.dropOnRightClickCheckBoxLabel, L.dropOnRightClickCheckBoxTooltip, "global");
dropOnRightClickCheckBox:setBelow(dropLabel);

local dropOnLeavingFarmCheckBox = factory:createCheckBox(configPanel, L.dropOnLeavingFarmCheckBoxLabel, L.dropOnLeavingFarmCheckBoxTooltip, "local");
dropOnLeavingFarmCheckBox:setBelow(dropOnRightClickCheckBox);

configPanel.default = function(self)
	config:setShowAutomatically(true);
	config:setHideInCombat(true);
	config:setHideWhenEmpty(true);
	config:setHideInVehicle(true);
	config:setDropOnRightClick(true);
	config:setDropOnLeavingFarm(true);
end
configPanel.okay = function(self)
	config:setShowAutomatically(showAutomaticallyCheckBox:GetChecked());
	config:setHideInCombat(hideInCombatCheckBox:GetChecked());
	config:setHideWhenEmpty(hideWhenEmptyCheckBox:GetChecked());
	config:setHideInVehicle(hideInVehicleCheckBox:GetChecked());
	config:setDropOnRightClick(dropOnRightClickCheckBox:GetChecked());
	config:setDropOnLeavingFarm(dropOnLeavingFarmCheckBox:GetChecked());
end
configPanel.refresh = function(self)
	showAutomaticallyCheckBox:SetChecked(config.showAutomatically);
	hideInCombatCheckBox:SetChecked(config.hideInCombat);
	hideWhenEmptyCheckBox:SetChecked(config.hideWhenEmpty);
	hideInVehicleCheckBox:SetChecked(config.hideInVehicle);
	dropOnRightClickCheckBox:SetChecked(config.dropOnRightClick);
	dropOnLeavingFarmCheckBox:SetChecked(config.dropOnLeavingFarm);
end