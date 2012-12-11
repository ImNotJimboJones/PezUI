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

function config:setShowLevelInWorld(value)
	if (value and not config.showLevelInWorld) then
		config.showLevelInWorld = true;
	elseif (not value and config.showLevelInWorld) then
		config.showLevelInWorld = false;
	end
end

function config:setShowLevelInBattle(value)
	if (value and not config.showLevelInBattle) then
		config.showLevelInBattle = true;
	elseif (not value and config.showLevelInBattle) then
		config.showLevelInBattle = false;
	end
end

function config:setShowLevelInMinimap(value)
	if (value and not config.showLevelInMinimap) then
		config.showLevelInMinimap = true;
	elseif (not value and config.showLevelInMinimap) then
		config.showLevelInMinimap = false;
	end
end

function config:setColorReleaseDialog(value)
	if (value and not config.colorReleaseDialog) then
		config.colorReleaseDialog = true;
	elseif (not value and config.colorReleaseDialog) then
		config.colorReleaseDialog = false;
		WPT:resetReleaseDialog();
	end
end

--[[ Create Config Panel ]]--

local factory = ThnanMod.Config;

local configPanel = factory:createConfigPanel(L.pluginName, L.pluginDescription);
WPT.configPanel = configPanel;

local enabledCheckBox = factory:createCheckBox(configPanel, L.enabledCheckBoxLabel, L.enabledCheckBoxTooltip, "global");
enabledCheckBox:setBelow(configPanel.subtitle);

local levelInWorldCheckBox = factory:createCheckBox(configPanel, L.levelInWorldCheckBoxLabel, L.levelInWorldCheckBoxTooltip, "global");
levelInWorldCheckBox:setBelow(enabledCheckBox);

local levelInBattleCheckBox = factory:createCheckBox(configPanel, L.levelInBattleCheckBoxLabel, L.levelInBattleCheckBoxTooltip, "global");
levelInBattleCheckBox:setBelow(levelInWorldCheckBox);

local levelInMinimapCheckBox = factory:createCheckBox(configPanel, L.levelInMinimapCheckBoxLabel, L.levelInMinimapCheckBoxTooltip, "global");
levelInMinimapCheckBox:setBelow(levelInBattleCheckBox);

local colorReleaseDialogCheckBox = factory:createCheckBox(configPanel, L.colorReleaseDialogCheckBoxLabel, L.colorReleaseDialogCheckBoxTooltip, "global");
colorReleaseDialogCheckBox:setBelow(levelInMinimapCheckBox);

function configPanel:default()
	config:setEnabled(true);
	config:setShowLevelInWorld(true);
	config:setShowLevelInBattle(true);
	config:setShowLevelInMinimap(false);
	config:setColorReleaseDialog(true);
end

function configPanel:okay()
	config:setEnabled(enabledCheckBox:GetChecked());
	config:setShowLevelInWorld(levelInWorldCheckBox:GetChecked());
	config:setShowLevelInBattle(levelInBattleCheckBox:GetChecked());
	config:setShowLevelInMinimap(levelInMinimapCheckBox:GetChecked());
	config:setColorReleaseDialog(colorReleaseDialogCheckBox:GetChecked());
end

function configPanel:refresh()
	enabledCheckBox:SetChecked(config.enabled);
	levelInWorldCheckBox:SetChecked(config.showLevelInWorld);
	levelInBattleCheckBox:SetChecked(config.showLevelInBattle);
	levelInMinimapCheckBox:SetChecked(config.showLevelInMinimap);
	colorReleaseDialogCheckBox:SetChecked(config.colorReleaseDialog);
end