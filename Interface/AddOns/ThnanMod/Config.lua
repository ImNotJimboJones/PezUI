local _, TMPrivate = ...;
local L = TMPrivate.L;

ThnanMod.Config = {};
local config = ThnanMod.Config;

-- config panel

local panelWidth = 623;
function config:createConfigPanel(nameText, subtitleText)
	local panel = CreateFrame("Frame");
	panel.name = nameText;
	
	if TMPrivate.rootConfigPanel then
		panel.parent = TMPrivate.rootConfigPanel.name;
	end
	
	panel.title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	panel.title:SetPoint("TOPLEFT", 16, -16);
	panel.title:SetJustifyH("LEFT");
	panel.title:SetJustifyV("TOP");
	panel.title:SetText(nameText);
	
	panel.subtitle = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	panel.subtitle:SetPoint("TOPLEFT", panel.title, "BOTTOMLEFT", 0, -16);
	panel.subtitle:SetWidth(panelWidth - 32);
	panel.subtitle:SetJustifyH("LEFT");
	panel.subtitle:SetJustifyV("TOP");
	panel.subtitle:SetNonSpaceWrap(false);
	panel.subtitle:SetText(subtitleText);
	
	InterfaceOptions_AddCategory(panel);
	
	return panel;
end

-- component helper functions

local function component_setBelow(self, otherComponent, xOffset, yOffset)
	if (type(xOffset) ~= "number") then
		xOffset = 0;
	end
	if (type(yOffset) ~= "number") then
		yOffset = -8;
	end
	
	self:SetPoint("TOPLEFT", otherComponent, "BOTTOMLEFT", xOffset, yOffset);
end
local function component_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT");
	GameTooltip:SetText(self.titleText);
	if self.tooltipText then
		GameTooltip:AddLine(self.tooltipText, 1, 1, 1, true);
	end
	if self.valueType ~= nil then
		if self.valueType == "global" then
			GameTooltip:AddLine(L.globalValue, 0, 1, 1, true);
		elseif self.valueType == "realm" then
			GameTooltip:AddLine(L.realmValue, 0, 1, 1, true);
		elseif self.valueType == "local" then
			GameTooltip:AddLine(L.localValue, 0, 1, 1, true);
		end
	end
	GameTooltip:Show();
end
local function component_OnLeave(self)
	GameTooltip:Hide();
end

-- check box

local checkBoxCount = 0;
function config:createCheckBox(parent, titleText, tooltipText, valueType)
	local checkBox = CreateFrame("CheckButton", titleText.."CheckBox"..checkBoxCount, parent, "InterfaceOptionsCheckButtonTemplate");
	checkBoxCount = checkBoxCount + 1;

	_G[checkBox:GetName().."Text"]:SetText(titleText);
	
	checkBox.titleText = titleText;
	checkBox.tooltipText = tooltipText;
	checkBox.valueType = valueType;
	
	checkBox.setBelow = component_setBelow;
	checkBox:SetScript("OnEnter", component_OnEnter);
	checkBox:SetScript("OnLeave", component_OnLeave);
	
	return checkBox;
end

-- text box

local function textBoxWrapper_GetText(self)
	return self.textBox:GetText();
end
local function textBoxWrapper_SetText(self, text)
	self.textBox:SetText(text);
end
local function textBoxWrapper_GetNumber(self)
	return self.textBox:GetNumber();
end
local function textBoxWrapper_SetMaxLetters(self, max)
	self.textBox:SetMaxLetters(max);
end
function config:createTextBox(parent, titleText, tooltipText, valueType)
	local wrapper = CreateFrame("Frame", nil, parent);
	
	wrapper.textBox = CreateFrame("EditBox", nil, wrapper, "InputBoxTemplate");
	wrapper.textBox:SetPoint("TOPLEFT", wrapper, "TOPLEFT");
	wrapper.textBox:SetAutoFocus(false);
	wrapper.textBox:SetHeight(20);
	wrapper.textBox:SetWidth(100);
	wrapper.textBox.titleText = titleText;
	wrapper.textBox.tooltipText = tooltipText;
	wrapper.textBox.valueType = valueType;
	wrapper.textBox:SetScript("OnEnter", component_OnEnter);
	wrapper.textBox:SetScript("OnLeave", component_OnLeave);
	
	wrapper.titleString = wrapper:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	wrapper.titleString:SetPoint("LEFT", wrapper.textBox, "RIGHT", 4, 0);
	wrapper.titleString:SetText("|cFFFFFFFF"..titleText.."|r");
	
	wrapper.titleText = titleText;
	wrapper.tooltipText = tooltipText;
	wrapper.valueType = valueType;
	
	wrapper.setBelow = component_setBelow;
	wrapper:SetScript("OnEnter", component_OnEnter);
	wrapper:SetScript("OnLeave", component_OnLeave);
	wrapper.GetText = textBoxWrapper_GetText;
	wrapper.SetText = textBoxWrapper_SetText;
	wrapper.GetNumber = textBoxWrapper_GetNumber;
	wrapper.SetMaxLetters = textBoxWrapper_SetMaxLetters;
	
	wrapper:SetHeight(wrapper.textBox:GetHeight());
	wrapper:SetWidth(wrapper.textBox:GetWidth() + wrapper.titleString:GetWidth() + 4);
	
	return wrapper;
end

-- label

function config:createLabel(parent, text)
	local label = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	label:SetJustifyH("LEFT");
	label:SetJustifyV("TOP");
	label:SetText(text);
	label.setBelow = component_setBelow;
	
	return label;
end

--[[ Config change methods ]]--

local configValues = TMPrivate.configValues;

function configValues:setDailyResetTime(value)
	if type(value) == "number" and value ~= configValues.dailyResetTime then
		if value >= 0 and value < 24 then
			configValues.dailyResetTime = value;
		end
	end
end

--[[ Create Root Panel ]]--

TMPrivate.rootConfigPanel = config:createConfigPanel(TMPrivate.addonName, L.configPanelText);
local configPanel = TMPrivate.rootConfigPanel;

local dailyResetTimeTextBox = config:createTextBox(configPanel, L.dailyResetTimeLabel, L.dailyResetTimeTooltip, "realm");
dailyResetTimeTextBox:setBelow(configPanel.subtitle);
dailyResetTimeTextBox:SetMaxLetters(2);

function configPanel:default()
	configValues:setDailyResetTime(11);
end
function configPanel:okay()
	configValues:setDailyResetTime(dailyResetTimeTextBox:GetNumber());
end
function configPanel:refresh()
	dailyResetTimeTextBox:SetText(configValues.dailyResetTime);
end