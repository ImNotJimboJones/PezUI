-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

function MRTUIUtils_FilterButton_SetType(button, type, text, checkedState, handler, iconPath)
	local normalText = _G[button:GetName().."NormalText"];
	local normalTexture = _G[button:GetName().."NormalTexture"];
	local checkbox = _G[button:GetName() .. "Checkbox"];
	local iconTexture = _G[button:GetName().."IconTexture"];

	if ( type == "class" ) then
		checkbox:Hide();
		button:SetText(text);
		iconTexture:SetTexture(nil);
		normalText:SetPoint("LEFT", button, "LEFT", 6, 0);
		normalTexture:SetAlpha(1.0);
		button:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight", "ADD")	
	elseif ( type == "checkbox" ) then
		checkbox:Show();
		checkbox:SetChecked(checkedState or false);
		handler(checkedState or false);
		iconTexture:SetTexture(nil);
		button:SetText(HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE);
		normalText:SetPoint("LEFT", checkbox, "RIGHT", 2, 0);
		normalTexture:SetAlpha(0.2);
		button:SetHighlightTexture(nil);
	elseif ( type == "command" ) then
		checkbox:Hide();
		iconTexture:SetTexture(iconPath);
		button:SetText(HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE);
		normalText:SetPoint("LEFT", iconTexture, "RIGHT", 2, 0);
		normalTexture:SetAlpha(0.2);
		button:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight", "ADD");
	elseif ( type == "subclass" ) then
		checkbox:Hide();
		iconTexture:SetTexture(nil);
		button:SetText(HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE);
		normalText:SetPoint("LEFT", button, "LEFT", 12, 0);
		normalTexture:SetAlpha(0.4);
		button:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight", "ADD");
	end
	button.type = type; 
end

function MRTUIUtils_GetStringWidth(dummy, text)
	dummy:Show();
	dummy:Hide();
	dummy:SetText(text);
	return dummy:GetWidth();
end

function MRTUIUtils_GetFormattedStringWidth(dummy, ...)
	dummy:Show();
	dummy:Hide();
	dummy:SetFormattedText(...);
	return dummy:GetWidth();	
end

function MRTUIUtils_GetInfoStringWidth(text)
	return MRTUIUtils_GetStringWidth(MRTSkillFrameLineInfoDummyString, text);
end

function MRTUIUtils_GetNormalStringWidth(text)
	return MRTUIUtils_GetStringWidth(MRTSkillFrameDummyString, text);
end

function MRTUIUtils_GetNormalFormattedStringWidth(...)
	return MRTUIUtils_GetFormattedStringWidth(MRTSkillFrameDummyString, ...);
end


-----
-- Methods to let addons get at the state of 'have materials' for the tradeskill window.
-----
function MRTUIUtils_GetTradeSkillOnlyShowMakeable()
	-- return MRTSkillFrameAvailableFilterCheckButton:GetChecked();
	return false;
end

function MRTUIUtils_SetTradeSkillOnlyShowMakeable(value)
	-- MRTSkillFrameAvailableFilterCheckButton:SetChecked(value);
	-- TradeSkillOnlyShowMakeable(MRTSkillFrameAvailableFilterCheckButton:GetChecked());
	-- Do nothing for now
end


