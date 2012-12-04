local _, TMPrivate = ...;
local L = TMPrivate.L;

ThnanMod.Config = {};
local config = ThnanMod.Config;

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

local function component_setBelow(self, otherComponent, xOffset, yOffset)
	if (type(xOffset) ~= "number") then
		xOffset = 0;
	end
	if (type(yOffset) ~= "number") then
		yOffset = -8;
	end
	
	self:SetPoint("TOPLEFT", otherComponent, "BOTTOMLEFT", xOffset, yOffset);
end

local function checkBox_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
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
local function checkBox_OnLeave(self)
	GameTooltip:Hide();
end
local checkBoxCount = 0;
function config:createCheckBox(parent, titleText, tooltipText, valueType)
	local checkBox = CreateFrame("CheckButton", titleText.."CheckBox"..checkBoxCount, parent, "InterfaceOptionsCheckButtonTemplate");
	checkBoxCount = checkBoxCount + 1;

	_G[checkBox:GetName().."Text"]:SetText(titleText);
	
	checkBox.titleText = titleText;
	checkBox.tooltipText = tooltipText;
	checkBox.valueType = valueType;
	
	checkBox.setBelow = component_setBelow;
	
	checkBox:SetScript("OnEnter", checkBox_OnEnter);
	checkBox:SetScript("OnLeave", checkBox_OnLeave);
	
	return checkBox;
end

--[[ Create Root Panel ]]--

TMPrivate.rootConfigPanel = config:createConfigPanel(TMPrivate.addonName, L.configPanelText);