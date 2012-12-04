--[[ Config Variables ]]--

local _, WPT = ...;
local config = WPT.config;
local L = WPT.L;

--[[ Config change methods ]]--

function config:setEnabled(value)
	if (value and not config.enabled) then
		config.enabled = true;
	elseif (not value and config.enabled) then
		config.enabled = false;
	end
end

--[[ Create Config Panel ]]--

local factory = ThnanMod.Config;

local configPanel = factory:createConfigPanel(L.pluginName, L.pluginDescription);
WPT.configPanel = configPanel;

local enabledCheckBox = factory:createCheckBox(configPanel, L.enabledCheckBoxLabel, L.enabledCheckBoxTooltip, "global");

enabledCheckBox:setBelow(configPanel.subtitle);

function configPanel:default()
	config:setEnabled(true);
end

function configPanel:okay()
	config:setEnabled(enabledCheckBox:GetChecked());
end

function configPanel:refresh()
	enabledCheckBox:SetChecked(config.enabled);
end