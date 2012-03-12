local addon = LibStub("AceAddon-3.0"):GetAddon("EveryQuest")
local L = LibStub("AceLocale-3.0"):GetLocale("EveryQuest")


local format = string.format

function addon:SetupFrames()
	local db = addon.db.profile
	---------------------------------------------------------------------
	--- Setup Frames
	EveryQuestTitleText:SetText(L["EveryQuest Log"]) -- Main frame title
	EveryQuestExitButton:SetText(CLOSE)
	BINDING_HEADER_eqTITLE = L["EveryQuest"] -- Key Binding group name
	BINDING_NAME_eqTOGGLE = L["Toggle Frame"] -- Frame toggle key binding name
	addon.frames = {}
	-- Create the "EQ" toggle button for the questlog frame
	addon.frames.Show = CreateFrame("Button",nil, QuestLogFrame, "UIPanelButtonTemplate")
	addon.frames.Show:SetWidth(28)
	addon.frames.Show:SetHeight(18)
	addon.frames.Show:SetText("EQ")
	addon.frames.Show:Show()
	addon.frames.Show:ClearAllPoints()
	addon.frames.Show:SetPoint("TOPLEFT",QuestLogFrame, "TOPLEFT",75,-15)
	addon.frames.Show:SetScript("OnClick", function() addon:Toggle()	end)
	
	local icon = CreateFrame("Button", nil, EveryQuestFrame)
	icon:SetHeight(35)
	icon:SetWidth(60)
	icon:SetNormalTexture("Interface\\AddOns\\EveryQuest\\Images\\wh_icon")
	icon:SetHighlightTexture("Interface\\AddOns\\EveryQuest\\Images\\wh_icon_hover")
	-- icon:SetHighlightTexture("Interface\\InventoryItems\\NOART")
	icon:GetHighlightTexture():SetTexCoord(0.05, .92, 0.16, .71)
	icon:GetNormalTexture():SetTexCoord(0.05, .92, 0.16, .71)
	icon:GetHighlightTexture():SetBlendMode("BLEND")
	icon:SetPoint("TOPRIGHT",-36,-36)
	icon:SetScript("OnClick", function()
										  addon:ShowAbout()
									  end)
	addon.frames.icon = icon
	
	
	addon.frames.ShownTT = CreateFrame("Frame",nil, EveryQuestFrame)
	addon.frames.ShownTT:SetWidth(122)
	addon.frames.ShownTT:SetBackdropColor(1,0,0,1)
	addon.frames.ShownTT:SetHeight(21)
	addon.frames.ShownTT:Show()
	addon.frames.ShownTT:ClearAllPoints()
	addon.frames.ShownTT:SetPoint("BOTTOMLEFT",EveryQuestFrame, "BOTTOMLEFT",18,5)
	addon.frames.ShownTT:EnableMouse(1)
	addon.frames.ShownTT:SetScript("OnLeave", function() GameTooltip:Hide() end)
	addon.frames.ShownTT:SetScript("OnEnter", function()
		--GameTooltip:SetOwner(addon.frames.ShownTT, "ANCHOR_TOPRIGHT");
		GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
		GameTooltip:SetText(format(L["%d Shown"], addon.countShown), 1, 1, 1) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(addon:RGB2Hex(unpack(db.colors.TurnedIn)), format(L["%d Turned In"], addon.countTurnedIn))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(addon:RGB2Hex(unpack(db.colors.Complete)), format(L["%d Completed"], addon.countComplete))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(addon:RGB2Hex(unpack(db.colors.Progress)), format(L["%d In Progress"], addon.countProgress))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(addon:RGB2Hex(unpack(db.colors.Failed)), format(L["%d Failed/Abandoned"], addon.countFailed))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(addon:RGB2Hex(unpack(db.colors.Unknown)), format(L["%d Unknown"], addon.countUnknown))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize(addon:RGB2Hex(unpack(db.colors.Ignored)), format(L["%d Ignored"], addon.countIgnored))) -- Main frame list count tooltip
		GameTooltip:AddLine(addon:Colorize("ffffff", format(L["%d Hidden"], addon.countHidden))) -- Main frame list count tooltip
		GameTooltip:Show() 
	end)
	-- Create the List toggle button to toggle between quest history and quests in a category
	addon.frames.Shown = addon.frames.ShownTT:CreateFontString(nil,"ARTWORK","GameFontNormal")
	--addon.frames.Shown = CreateFrame("FontString", nil, EveryQuestFrame)
	addon.frames.Shown:SetWidth(122)
	addon.frames.Shown:SetHeight(21)
	addon.frames.Shown:SetText(" ")
	addon.frames.Shown:Show()
	addon.frames.Shown:ClearAllPoints()
	addon.frames.Shown:SetPoint("BOTTOMLEFT",addon.frames.ShownTT, "BOTTOMLEFT",0,0)
	--addon.frames.ShownTT:SetScript("OnClick", function() addon:List("toggle") end)

	addon.frames.Filters = CreateFrame("Button",nil, EveryQuestFrame, "UIPanelButtonTemplate")
	addon.frames.Filters:SetWidth(60)
	addon.frames.Filters:SetHeight(21)
	addon.frames.Filters:SetText(L["Filters"]) -- Main frame button
	addon.frames.Filters:Show()
	addon.frames.Filters:ClearAllPoints()
	addon.frames.Filters:SetPoint("BOTTOMLEFT",EveryQuestFrame, "BOTTOMLEFT",140,5)
	addon.frames.Filters:SetScript("OnClick", function() self:ShowFilters() end)
	
	addon.frames.Options = CreateFrame("Button",nil, EveryQuestFrame, "UIPanelButtonTemplate")
	addon.frames.Options:SetWidth(60)
	addon.frames.Options:SetHeight(21)
	addon.frames.Options:SetText(L["Options"]) -- Main frame button
	addon.frames.Options:Show()
	addon.frames.Options:ClearAllPoints()
	addon.frames.Options:SetPoint("TOPLEFT",addon.frames.Filters, "TOPRIGHT",0,0)
	addon.frames.Options:SetScript("OnClick", function() self:ShowConfig() end)

	local CurZone = CreateFrame("Button",nil, EveryQuestFrame, "UIPanelButtonTemplate")
	CurZone:SetWidth(64)
	CurZone:SetHeight(64)
	CurZone:SetPoint("TOPLEFT",EveryQuestFrame, "TOPLEFT",5,-4)
	CurZone:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	CurZone._normal = CurZone:CreateTexture(nil, "BACKGROUND")
	CurZone._normal:SetTexture([[Interface\Addons\EveryQuest\Images\book_up]])
	CurZone._normal:SetTexCoord(0, 1, 0, 1)
	CurZone._normal:SetAllPoints(CurZone)
	CurZone:SetNormalTexture(CurZone._normal)
	
	CurZone._pushed = CurZone:CreateTexture(nil, "BACKGROUND")
	CurZone._pushed:SetTexture([[Interface\Addons\EveryQuest\Images\book_down]])
	CurZone._pushed:SetTexCoord(0, 1, 0, 1)
	CurZone._pushed:SetAllPoints(CurZone)
	CurZone:SetPushedTexture(CurZone._pushed)

	CurZone:SetScript("OnClick", function()
		local continent = nil
		if not WorldMapFrame:IsShown() then
			continent = GetCurrentMapContinent()
		end
		local list, module = self:GetListIdByName(GetRealZoneText(), continent)
		if list ~= nil then
			addon.list = list
		end
		if module ~= nil then
			addon.module = module
		end
		self:Debug(format("CurZone(%s) list id: %d module id: %s", GetRealZoneText(), list, module))
		addon.listsorted = false
		addon:SendMessage("EveryQuestDisplayChanged", addon.module, addon.list)
	end)
	addon.frames.CurZone = CurZone

	
	local button = CreateFrame("Button", "EveryQuestTitle1", EveryQuestFrame,"EveryQuestTitleButtonTemplate")
	button:SetID(1)
	button:SetNormalFontObject(GameFontNormalLeft)
	button:Hide()
	button:ClearAllPoints()
	button:SetPoint("TOPLEFT", EveryQuestFrame, 19, -75)
	for i = 2, 27 do
		button = CreateFrame("Button", "EveryQuestTitle" .. i, EveryQuestFrame,"EveryQuestTitleButtonTemplate")
		button:SetID(i)
		button:SetNormalFontObject(GameFontNormalLeft)
		button:Hide()
		button:ClearAllPoints()
		button:SetPoint("TOPLEFT", getglobal("EveryQuestTitle" .. (i-1)), "BOTTOMLEFT", 0, 1)
	end
	
	-- Zone Menu creation
	addon.frames.Menu = CreateFrame("Frame", "EQ_Menu", EveryQuestFrame, "UIDropDownMenuTemplate")
	addon.frames.Menu:Show()
	_G["EQDropdown"] = addon.frames.Menu
	addon.frames.Menu:ClearAllPoints()
	addon.frames.Menu:SetPoint("TOPLEFT", 70,-40)
	UIDropDownMenu_SetWidth(EQ_Menu, 170, 0)
	UIDropDownMenu_SetButtonWidth(EQ_Menu, 20)
	EQ_MenuButton:SetScript("OnClick", function(self, button, down)
		ToggleDropDownMenu(1, nil, EveryQuest_ZoneMenu, self:GetName(), 0, 0)
	end)
	
	UIDropDownMenu_SetText(EQ_Menu, L["- Select -"]) -- Starting dropdown menu text
	tinsert(UISpecialFrames,"EveryQuestFrame")
	
	if IsAddOnLoaded("Carbonite") == nil then
		EveryQuestFrame:SetScale(QuestLogFrame:GetScale())
	end
	
	local LDB = LibStub("LibDataBroker-1.1", true)
	local launcher = LDB:NewDataObject("EveryQuest", {
		type = "launcher",
		icon = "Interface\\AddOns\\EveryQuest\\icon",
		OnClick = function(clickedframe, button)
			if button == "RightButton" then addon:ShowConfig() else addon:Toggle() end
		end,
		OnTooltipShow = function(tt) 
			tt:AddLine(L["EveryQuest"]) -- LDB Tooltip title
			tt:AddLine(L["Click to toggle the main window"]) -- LDB click help: toggle
			tt:AddLine(L["Right-click to open the options menu"]) -- LDB right-click help: options
		end,
	})
end