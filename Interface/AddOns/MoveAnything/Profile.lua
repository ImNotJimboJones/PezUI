local MovAny = _G.MovAny
local MOVANY = _G.MOVANY
local _


MoveAny_ProfileReset = CreateFrame("Frame", "MoveAny_ProfileReset", UIParent)
MoveAny_ProfileReset:SetBackdrop({
	bgFile = [=[Interface\DialogFrame\UI-DialogBox-Background]=],
	edgeFile = [=[Interface\DialogFrame\UI-DialogBox-Border]=], tile = true, edgeSize = 32,
	insets = {top = 12, left = 11, bottom = 11, right = 12},
})
MoveAny_ProfileReset:SetBackdropColor(0 , 0 , 0 , 0.8)
MoveAny_ProfileReset:SetPoint("CENTER", UIParent, "CENTER", 16, -2)
MoveAny_ProfileReset:SetFrameStrata("TOOLTIP")
MoveAny_ProfileReset:SetSize(336, 120)
MoveAny_ProfileReset:Hide()

MoveAny_ProfileReset.fstring = MoveAny_ProfileReset:CreateFontString(nil, "OVERLAY")
MoveAny_ProfileReset.fstring:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
MoveAny_ProfileReset.fstring:SetText(MOVANY.PROFILE_RESET_CONFIRM)
MoveAny_ProfileReset.fstring:SetTextColor(1, 0.8, 0)
MoveAny_ProfileReset.fstring:SetShadowOffset(0, 0)
MoveAny_ProfileReset.fstring:SetPoint("TOPLEFT", MoveAny_ProfileReset, "TOPLEFT", 20 , -25)

MoveAny_ProfileReset.button1 = CreateFrame("Button", "MoveAny_ProfileResetButton1", MoveAny_ProfileReset, "UIPanelButtonTemplate")
MoveAny_ProfileReset.button1:SetPoint("BOTTOMLEFT", MoveAny_ProfileReset, "BOTTOMLEFT", 20, 20)
MoveAny_ProfileReset.button1:SetFrameLevel(MoveAny_ProfileReset:GetFrameLevel() + 2)
MoveAny_ProfileReset.button1:SetHeight(22)
MoveAny_ProfileReset.button1:SetWidth(80)
MoveAny_ProfileReset.button1:SetFrameStrata("TOOLTIP")
MoveAny_ProfileReset.button1:SetText(YES)
MoveAny_ProfileReset.button1:SetNormalFontObject("GameFontNormalSmall")
MoveAny_ProfileReset.button1:SetHighlightFontObject("GameFontHighlightSmall")
MoveAny_ProfileReset.button1:SetScript("OnClick", function() MovAny:ResetProfile() MoveAny_ProfileReset:Hide() end)

MoveAny_ProfileReset.button2 = CreateFrame("Button", "MoveAny_ProfileResetButton2", MoveAny_ProfileReset, "UIPanelButtonTemplate")
MoveAny_ProfileReset.button2:SetPoint("BOTTOMRIGHT", MoveAny_ProfileReset, "BOTTOMRIGHT",-20, 20)
MoveAny_ProfileReset.button2:SetFrameLevel(MoveAny_ProfileReset:GetFrameLevel() + 2)
MoveAny_ProfileReset.button2:SetHeight(22)
MoveAny_ProfileReset.button2:SetWidth(80)
MoveAny_ProfileReset.button2:SetFrameStrata("TOOLTIP")
MoveAny_ProfileReset.button2:SetText(NO)
MoveAny_ProfileReset.button2:SetNormalFontObject("GameFontNormalSmall")
MoveAny_ProfileReset.button2:SetHighlightFontObject("GameFontHighlightSmall")
MoveAny_ProfileReset.button2:SetScript("OnClick", function() MoveAny_ProfileReset:Hide() end)


----------------------------------------------ADD PROFILE--------------------------------

MoveAny_ProfileAdd = CreateFrame("Frame", "MoveAny_ProfileAdd", UIParent)
MoveAny_ProfileAdd:SetBackdrop({
	bgFile = [=[Interface\DialogFrame\UI-DialogBox-Background]=],
	edgeFile = [=[Interface\DialogFrame\UI-DialogBox-Border]=], tile = true, edgeSize = 32,
	insets = {top = 12, left = 11, bottom = 11, right = 12},
})
MoveAny_ProfileAdd:SetBackdropColor(0 , 0 , 0 , 0.8)
MoveAny_ProfileAdd:SetPoint("CENTER", UIParent, "CENTER", 16, -2)
MoveAny_ProfileAdd:SetFrameStrata("TOOLTIP")
MoveAny_ProfileAdd:SetSize(336, 120)
MoveAny_ProfileAdd:Hide()
MoveAny_ProfileAdd:SetScript("OnShow", function(self)
		self.editBox:SetScript("OnEnterPressed", function()
			if MovAny:AddProfile(self.editBox:GetText()) then
				MoveAny_ProfileAdd:Hide()
			end
		end)
		self.editBox:SetScript("OnEscapePressed", function()
			MoveAny_ProfileAdd:Hide()
		end)
	end)

MoveAny_ProfileAdd.fstring = MoveAny_ProfileAdd:CreateFontString(nil, "OVERLAY")
MoveAny_ProfileAdd.fstring:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
MoveAny_ProfileAdd.fstring:SetText(MOVANY.PROFILE_ADD_TEXT)
MoveAny_ProfileAdd.fstring:SetTextColor(1, 0.8, 0)
MoveAny_ProfileAdd.fstring:SetShadowOffset(0, 0)
MoveAny_ProfileAdd.fstring:SetPoint("TOPLEFT", MoveAny_ProfileAdd, "TOPLEFT", 20 , -25)
MoveAny_ProfileAdd.fstring:SetMaxLines(3)

MoveAny_ProfileAdd.button1 = CreateFrame("Button", "MoveAny_ProfileAddButton1", MoveAny_ProfileAdd, "UIPanelButtonTemplate")
MoveAny_ProfileAdd.button1:SetPoint("BOTTOMLEFT", MoveAny_ProfileAdd, "BOTTOMLEFT", 20, 20)
MoveAny_ProfileAdd.button1:SetFrameLevel(MoveAny_ProfileAdd:GetFrameLevel() + 2)
MoveAny_ProfileAdd.button1:SetHeight(22)
MoveAny_ProfileAdd.button1:SetWidth(80)
MoveAny_ProfileAdd.button1:SetFrameStrata("TOOLTIP")
MoveAny_ProfileAdd.button1:SetText(MOVANY.ADD)
MoveAny_ProfileAdd.button1:SetNormalFontObject("GameFontNormalSmall")
MoveAny_ProfileAdd.button1:SetHighlightFontObject("GameFontHighlightSmall")
MoveAny_ProfileAdd.button1:SetScript("OnClick", function(self)
	if not MovAny:AddProfile(MoveAny_ProfileAdd.editBox:GetText()) then
		MoveAny_ProfileAdd:Show()
	end
end)

MoveAny_ProfileAdd.button2 = CreateFrame("Button", "MoveAny_ProfileAddButton2", MoveAny_ProfileAdd, "UIPanelButtonTemplate")
MoveAny_ProfileAdd.button2:SetPoint("BOTTOMRIGHT", MoveAny_ProfileAdd, "BOTTOMRIGHT",-20, 20)
MoveAny_ProfileAdd.button2:SetFrameLevel(MoveAny_ProfileAdd:GetFrameLevel() + 2)
MoveAny_ProfileAdd.button2:SetHeight(22)
MoveAny_ProfileAdd.button2:SetWidth(80)
MoveAny_ProfileAdd.button2:SetFrameStrata("TOOLTIP")
MoveAny_ProfileAdd.button2:SetText(CANCEL)
MoveAny_ProfileAdd.button2:SetNormalFontObject("GameFontNormalSmall")
MoveAny_ProfileAdd.button2:SetHighlightFontObject("GameFontHighlightSmall")
MoveAny_ProfileAdd.button2:SetScript("OnClick", function() MoveAny_ProfileAdd:Hide() end)

MoveAny_ProfileAdd.editBox = CreateFrame("EditBox", "MoveAny_ProfileAddEditBox", MoveAny_ProfileAdd)
MoveAny_ProfileAdd.editBox:SetPoint("CENTER", MoveAny_ProfileAdd, "BOTTOM", 0, 60)
MoveAny_ProfileAdd.editBox:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
MoveAny_ProfileAdd.editBox:SetFrameLevel(MoveAny_ProfileAdd:GetFrameLevel() + 1)
MoveAny_ProfileAdd.editBox:SetAutoFocus(false)
MoveAny_ProfileAdd.editBox:SetFrameStrata("TOOLTIP")
MoveAny_ProfileAdd.editBox:SetText("")
MoveAny_ProfileAdd.editBox:SetWidth(130)
MoveAny_ProfileAdd.editBox:SetHeight(30)
MoveAny_ProfileAdd.editBox:SetBackdrop({
	bgFile = [=[Interface\DialogFrame\UI-DialogBox-Background]=],
	edgeFile = [=[Interface\DialogFrame\UI-DialogBox-Border]=], tile = true, tileSize = 0, edgeSize = 18,
	insets = {top = 2, left = 1, bottom = 1, right = 2},
})
	
	
--[[StaticPopupDialogs["MOVEANYTHING_PROFILE_ADD"] = {
	preferredIndex = 3,
	text = MOVANY.PROFILE_ADD_TEXT,
	button1 = TEXT(MOVANY.ADD),
	button2 = TEXT(CANCEL),
	OnShow = function(self)
		self.editBox:SetScript("OnEnterPressed", function()
			if MovAny:AddProfile(self.editBox:GetText()) then
				StaticPopup_Hide("MOVEANYTHING_PROFILE_ADD")
			end
		end)
		self.editBox:SetScript("OnEscapePressed", function()
			StaticPopup_Hide("MOVEANYTHING_PROFILE_ADD")
		end)
	end,
	OnAccept = function(self)
		if not MovAny:AddProfile(self.editBox:GetText()) then
			StaticPopup_Show("MOVEANYTHING_PROFILE_ADD")
		end
	end,
	hasEditBox = true,
	timeout = 0,
	exclusive = 0,
	showAlert = 1,
	whileDead = 1,
	hideOnEscape = 1,
}]]


------------------------DELETE----------------------------------

MoveAny_ProfileDelete = CreateFrame("Frame", "MoveAny_ProfileDelete", UIParent)
MoveAny_ProfileDelete:SetBackdrop({
	bgFile = [=[Interface\DialogFrame\UI-DialogBox-Background]=],
	edgeFile = [=[Interface\DialogFrame\UI-DialogBox-Border]=], tile = true, edgeSize = 32,
	insets = {top = 12, left = 11, bottom = 11, right = 12},
})
MoveAny_ProfileDelete:SetBackdropColor(0 , 0 , 0 , 0.8)
MoveAny_ProfileDelete:SetPoint("CENTER", UIParent, "CENTER", 16, -2)
MoveAny_ProfileDelete:SetFrameStrata("TOOLTIP")
MoveAny_ProfileDelete:SetSize(336, 120)
MoveAny_ProfileDelete:Hide()

MoveAny_ProfileDelete.fstring = MoveAny_ProfileDelete:CreateFontString(nil, "OVERLAY")
MoveAny_ProfileDelete.fstring:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
MoveAny_ProfileDelete.fstring:SetText(MOVANY.PROFILE_DELETE_TEXT)
MoveAny_ProfileDelete.fstring:SetTextColor(1, 0.8, 0)
MoveAny_ProfileDelete.fstring:SetShadowOffset(0, 0)
MoveAny_ProfileDelete.fstring:SetPoint("TOPLEFT", MoveAny_ProfileDelete, "TOPLEFT", 20 , -25)

MoveAny_ProfileDelete.button1 = CreateFrame("Button", "MoveAny_ProfileDeleteButton1", MoveAny_ProfileDelete, "UIPanelButtonTemplate")
MoveAny_ProfileDelete.button1:SetPoint("BOTTOMLEFT", MoveAny_ProfileReset, "BOTTOMLEFT", 20, 20)
MoveAny_ProfileDelete.button1:SetFrameLevel(MoveAny_ProfileDelete:GetFrameLevel() + 2)
MoveAny_ProfileDelete.button1:SetHeight(22)
MoveAny_ProfileDelete.button1:SetWidth(80)
MoveAny_ProfileDelete.button1:SetFrameStrata("TOOLTIP")
MoveAny_ProfileDelete.button1:SetText(MOVANY.DELETE)
MoveAny_ProfileDelete.button1:SetNormalFontObject("GameFontNormalSmall")
MoveAny_ProfileDelete.button1:SetHighlightFontObject("GameFontHighlightSmall")
MoveAny_ProfileDelete.button1:SetScript("OnClick", function() MovAny:DeleteProfile(MovAny:GetProfileName()) MoveAny_ProfileDelete:Hide() end)

MoveAny_ProfileDelete.button2 = CreateFrame("Button", "MoveAny_ProfileDeleteButton2", MoveAny_ProfileDelete, "UIPanelButtonTemplate")
MoveAny_ProfileDelete.button2:SetPoint("BOTTOMRIGHT", MoveAny_ProfileDelete, "BOTTOMRIGHT",-20, 20)
MoveAny_ProfileDelete.button2:SetFrameLevel(MoveAny_ProfileDelete:GetFrameLevel() + 2)
MoveAny_ProfileDelete.button2:SetHeight(22)
MoveAny_ProfileDelete.button2:SetWidth(80)
MoveAny_ProfileDelete.button2:SetFrameStrata("TOOLTIP")
MoveAny_ProfileDelete.button2:SetText(CANCEL)
MoveAny_ProfileDelete.button2:SetNormalFontObject("GameFontNormalSmall")
MoveAny_ProfileDelete.button2:SetHighlightFontObject("GameFontHighlightSmall")
MoveAny_ProfileDelete.button2:SetScript("OnClick", function() MoveAny_ProfileDelete:Hide() end)


--[[StaticPopupDialogs["MOVEANYTHING_PROFILE_RENAME"] = {
	preferredIndex = 3,
	text = MOVANY.PROFILE_RENAME_TEXT,
	button1 = TEXT(MOVANY.RENAME),
	button2 = TEXT(CANCEL),
	OnShow = function(self)
		self.pn = MovAny:GetProfileName()
		self.editBox:SetScript("OnEnterPressed", function()
			if self.pn == self.editBox:GetText() or MovAny:RenameProfile(self.pn, self.editBox:GetText()) then
				StaticPopup_Hide("MOVEANYTHING_PROFILE_RENAME")
			end
		end)
		self.editBox:SetScript("OnEscapePressed", function()
			StaticPopup_Hide("MOVEANYTHING_PROFILE_RENAME")
		end)
	end,
	OnAccept = function(self)
		if self.pn ~= self.editBox:GetText() and not MovAny:RenameProfile(self.pn, self.editBox:GetText()) then
			StaticPopup_Show("MOVEANYTHING_PROFILE_RENAME")
		end
	end,
	hasEditBox = true,
	timeout = 0,
	exclusive = 0,
	showAlert = 1,
	whileDead = 1,
	hideOnEscape = 1,
}]]

------------------------------RENAME_PROFILE------------------------------------
MoveAny_ProfileRename = CreateFrame("Frame", "MoveAny_ProfileRename", UIParent)
MoveAny_ProfileRename:SetBackdrop({
	bgFile = [=[Interface\DialogFrame\UI-DialogBox-Background]=],
	edgeFile = [=[Interface\DialogFrame\UI-DialogBox-Border]=], tile = true, edgeSize = 32,
	insets = {top = 12, left = 11, bottom = 11, right = 12},
})
MoveAny_ProfileRename:SetBackdropColor(0 , 0 , 0 , 0.8)
MoveAny_ProfileRename:SetPoint("CENTER", UIParent, "CENTER", 16, -2)
MoveAny_ProfileRename:SetFrameStrata("TOOLTIP")
MoveAny_ProfileRename:SetSize(336, 120)
MoveAny_ProfileRename:Hide()
MoveAny_ProfileRename:SetScript("OnShow", function(self)
		self.pn = MovAny:GetProfileName()
		self.editBox:SetScript("OnEnterPressed", function()
			if self.pn == self.editBox:GetText() or MovAny:RenameProfile(self.pn, self.editBox:GetText()) then
				self:Hide()
			end
		end)
		self.editBox:SetScript("OnEscapePressed", function()
			self:Hide()
		end)
	end)

MoveAny_ProfileRename.fstring = MoveAny_ProfileRename:CreateFontString(nil, "OVERLAY")
MoveAny_ProfileRename.fstring:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
MoveAny_ProfileRename.fstring:SetText(MOVANY.PROFILE_RENAME_TEXT)
MoveAny_ProfileRename.fstring:SetTextColor(1, 0.8, 0)
MoveAny_ProfileRename.fstring:SetShadowOffset(0, 0)
MoveAny_ProfileRename.fstring:SetPoint("TOPLEFT", MoveAny_ProfileRename, "TOPLEFT", 20 , -25)

MoveAny_ProfileRename.button1 = CreateFrame("Button", "MoveAny_ProfileRenameButton1", MoveAny_ProfileRename, "UIPanelButtonTemplate")
MoveAny_ProfileRename.button1:SetPoint("BOTTOMLEFT", MoveAny_ProfileReset, "BOTTOMLEFT", 20, 20)
MoveAny_ProfileRename.button1:SetFrameLevel(MoveAny_ProfileRename:GetFrameLevel() + 2)
MoveAny_ProfileRename.button1:SetHeight(22)
MoveAny_ProfileRename.button1:SetWidth(80)
MoveAny_ProfileRename.button1:SetFrameStrata("TOOLTIP")
MoveAny_ProfileRename.button1:SetText(MOVANY.RENAME)
MoveAny_ProfileRename.button1:SetNormalFontObject("GameFontNormalSmall")
MoveAny_ProfileRename.button1:SetHighlightFontObject("GameFontHighlightSmall")
MoveAny_ProfileRename.button1:SetScript("OnClick", function() 
	if self.pn ~= self.editBox:GetText() and not MovAny:RenameProfile(self.pn, self.editBox:GetText()) then
		MoveAny_ProfileRename:Show()
	end 
end)

MoveAny_ProfileRename.button2 = CreateFrame("Button", "MoveAny_ProfileRenameButton2", MoveAny_ProfileRename, "UIPanelButtonTemplate")
MoveAny_ProfileRename.button2:SetPoint("BOTTOMRIGHT", MoveAny_ProfileRename, "BOTTOMRIGHT",-20, 20)
MoveAny_ProfileRename.button2:SetFrameLevel(MoveAny_ProfileRename:GetFrameLevel() + 2)
MoveAny_ProfileRename.button2:SetHeight(22)
MoveAny_ProfileRename.button2:SetWidth(80)
MoveAny_ProfileRename.button2:SetFrameStrata("TOOLTIP")
MoveAny_ProfileRename.button2:SetText(CANCEL)
MoveAny_ProfileRename.button2:SetNormalFontObject("GameFontNormalSmall")
MoveAny_ProfileRename.button2:SetHighlightFontObject("GameFontHighlightSmall")
MoveAny_ProfileRename.button2:SetScript("OnClick", function() MoveAny_ProfileRename:Hide() end)

MoveAny_ProfileRename.editBox = CreateFrame("EditBox", "MoveAny_ProfileRenameEditBox", MoveAny_ProfileRename)
MoveAny_ProfileRename.editBox:SetPoint("CENTER", MoveAny_ProfileRename, "BOTTOM", 0, 60)
MoveAny_ProfileRename.editBox:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
MoveAny_ProfileRename.editBox:SetFrameLevel(MoveAny_ProfileRename:GetFrameLevel() + 1)
MoveAny_ProfileRename.editBox:SetAutoFocus(false)
MoveAny_ProfileRename.editBox:SetFrameStrata("TOOLTIP")
MoveAny_ProfileRename.editBox:SetText("")
MoveAny_ProfileRename.editBox:SetWidth(130)
MoveAny_ProfileRename.editBox:SetHeight(30)
MoveAny_ProfileRename.editBox:SetBackdrop({
	bgFile = [=[Interface\DialogFrame\UI-DialogBox-Background]=],
	edgeFile = [=[Interface\DialogFrame\UI-DialogBox-Border]=], tile = true, tileSize = 0, edgeSize = 18,
	insets = {top = 2, left = 1, bottom = 1, right = 2},
})




--[[StaticPopupDialogs["MOVEANYTHING_PROFILE_SAVE_AS"] = {
	preferredIndex = 3,
	text = MOVANY.PROFILE_SAVE_AS_TEXT,
	button1 = TEXT(MOVANY.SAVE),
	button2 = TEXT(CANCEL),
	OnShow = function(self)
		self.pn = MovAny:GetProfileName()
		self.editBox:SetScript("OnEnterPressed", function()
			if MovAny:CopyProfile(self.pn, self.editBox:GetText()) then
				StaticPopup_Hide("MOVEANYTHING_PROFILE_SAVE_AS")
			end
		end)
		self.editBox:SetScript("OnEscapePressed", function()
			StaticPopup_Hide("MOVEANYTHING_PROFILE_SAVE_AS")
		end)
	end,
	OnAccept = function(self)
		if not MovAny:CopyProfile(self.pn, self.editBox:GetText()) then
			StaticPopup_Show("MOVEANYTHING_PROFILE_SAVE_AS")
		end
	end,
	hasEditBox = true,
	timeout = 0,
	exclusive = 0,
	showAlert = 1,
	whileDead = 1,
	hideOnEscape = 1,
}]]

MoveAny_SaveAs = CreateFrame("Frame", "MoveAny_SaveAs", UIParent)
MoveAny_SaveAs:SetBackdrop({
	bgFile = [=[Interface\DialogFrame\UI-DialogBox-Background]=],
	edgeFile = [=[Interface\DialogFrame\UI-DialogBox-Border]=], tile = true, edgeSize = 32,
	insets = {top = 12, left = 11, bottom = 11, right = 12},
})
MoveAny_SaveAs:SetBackdropColor(0 , 0 , 0 , 0.8)
MoveAny_SaveAs:SetPoint("CENTER", UIParent, "CENTER", 16, -2)
MoveAny_SaveAs:SetFrameStrata("TOOLTIP")
MoveAny_SaveAs:SetSize(336, 120)
MoveAny_SaveAs:Hide()
MoveAny_SaveAs:SetScript("OnShow", function(self)
		self.pn = MovAny:GetProfileName()
		self.editBox:SetScript("OnEnterPressed", function()
			if MovAny:CopyProfile(self.pn, self.editBox:GetText()) then
				MoveAny_SaveAs:Hide()
			end
		end)
		self.editBox:SetScript("OnEscapePressed", function()
			MoveAny_SaveAs:Hide()
		end)
	end)

MoveAny_SaveAs.fstring = MoveAny_SaveAs:CreateFontString(nil, "OVERLAY")
MoveAny_SaveAs.fstring:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
MoveAny_SaveAs.fstring:SetText(MOVANY.PROFILE_SAVE_AS_TEXT)
MoveAny_SaveAs.fstring:SetTextColor(1, 0.8, 0)
MoveAny_SaveAs.fstring:SetShadowOffset(0, 0)
MoveAny_SaveAs.fstring:SetPoint("TOPLEFT", MoveAny_SaveAs, "TOPLEFT", 20 , -25)

MoveAny_SaveAs.button1 = CreateFrame("Button", "MoveAny_SaveAsButton1", MoveAny_SaveAs, "UIPanelButtonTemplate")
MoveAny_SaveAs.button1:SetPoint("BOTTOMLEFT", MoveAny_ProfileReset, "BOTTOMLEFT", 20, 20)
MoveAny_SaveAs.button1:SetFrameLevel(MoveAny_SaveAs:GetFrameLevel() + 2)
MoveAny_SaveAs.button1:SetHeight(22)
MoveAny_SaveAs.button1:SetWidth(80)
MoveAny_SaveAs.button1:SetFrameStrata("TOOLTIP")
MoveAny_SaveAs.button1:SetText(MOVANY.SAVE)
MoveAny_SaveAs.button1:SetNormalFontObject("GameFontNormalSmall")
MoveAny_SaveAs.button1:SetHighlightFontObject("GameFontHighlightSmall")
MoveAny_SaveAs.button1:SetScript("OnClick", function() 
	if not MovAny:CopyProfile(self.pn, self.editBox:GetText()) then
		MoveAny_SaveAs:Show()
	end
end)

MoveAny_SaveAs.button2 = CreateFrame("Button", "MoveAny_SaveAsButton2", MoveAny_SaveAs, "UIPanelButtonTemplate")
MoveAny_SaveAs.button2:SetPoint("BOTTOMRIGHT", MoveAny_SaveAs, "BOTTOMRIGHT",-20, 20)
MoveAny_SaveAs.button2:SetFrameLevel(MoveAny_SaveAs:GetFrameLevel() + 2)
MoveAny_SaveAs.button2:SetHeight(22)
MoveAny_SaveAs.button2:SetWidth(80)
MoveAny_SaveAs.button2:SetFrameStrata("TOOLTIP")
MoveAny_SaveAs.button2:SetText(CANCEL)
MoveAny_SaveAs.button2:SetNormalFontObject("GameFontNormalSmall")
MoveAny_SaveAs.button2:SetHighlightFontObject("GameFontHighlightSmall")
MoveAny_SaveAs.button2:SetScript("OnClick", function() MoveAny_SaveAs:Hide() end)

MoveAny_SaveAs.editBox = CreateFrame("EditBox", "MoveAny_SaveAsEditBox", MoveAny_SaveAs)
MoveAny_SaveAs.editBox:SetPoint("CENTER", MoveAny_SaveAs, "BOTTOM", 0, 60)
MoveAny_SaveAs.editBox:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
MoveAny_SaveAs.editBox:SetFrameLevel(MoveAny_SaveAs:GetFrameLevel() + 1)
MoveAny_SaveAs.editBox:SetAutoFocus(false)
MoveAny_SaveAs.editBox:SetFrameStrata("TOOLTIP")
MoveAny_SaveAs.editBox:SetText("")
MoveAny_SaveAs.editBox:SetWidth(130)
MoveAny_SaveAs.editBox:SetHeight(30)
MoveAny_SaveAs.editBox:SetBackdrop({
	bgFile = [=[Interface\DialogFrame\UI-DialogBox-Background]=],
	edgeFile = [=[Interface\DialogFrame\UI-DialogBox-Border]=], tile = true, tileSize = 0, edgeSize = 18,
	insets = {top = 2, left = 1, bottom = 1, right = 2},
})


--[[StaticPopupDialogs["MOVEANYTHING_PROFILE_DELETE"] = {
	preferredIndex = 3,
	text = MOVANY.PROFILE_DELETE_TEXT,
	button1 = TEXT(MOVANY.DELETE),
	button2 = TEXT(CANCEL),
	OnAccept = function(self)
		MovAny:DeleteProfile(MovAny:GetProfileName())
	end,
	timeout = 0,
	exclusive = 0,
	showAlert = 1,
	whileDead = 1,
	hideOnEscape = 1
}]]

function MovAny:ResetProfile(readOnly)
	local f
	for i, v in pairs(self.userData) do
		f = _G[i]
		if f and f.MAHooked then
			self:ResetFrame(i, true, true)
		end
	end
	self.API:ClearElementsUserData()
	self:ReanchorRelatives()
	if not readOnly then
		table.wipe(self.userData)
		MADB.profiles[self:GetProfileName()].frames = self.userData
	end
	self:UpdateGUIIfShown(true)
end

function MovAny:GetProfileName()
	local char = MADB.characters[self:GetCharacterIndex()]
	if char and char.profile then
		return char.profile
	else
		return "default"
	end
end

function MovAny:CopyProfile(fromName, toName)
	if fromName == toName then
		return
	end
	if MADB.profiles[toName] == nil then
		self:AddProfile(toName, true)
	end
	local l, vm, e
	local curProfileName = self:GetProfileName()
	for i, val in pairs(MADB.profiles[fromName].frames) do
		l = MA_tcopy(val)
		l.cat = nil
		data = self.lVirtualMovers[i]
		if data and data.excludes then
			MADB.profiles[toName].frames[data.excludes] = nil
		end
		
		if toName == curProfileName then
			e = self.API:GetElement(i)
			if e then
				e:SetUserData(l)
			end
		end
		
		MADB.profiles[toName].frames[i] = l
	end
	return true
end

function MovAny:AddProfile(pn, silent, dontUpdate)
	if MADB.profiles[pn] then
		if not silent then
			maPrint(string.format(MOVANY.PROFILE_ALREADY_EXISTS, pn))
		end
		return
	end
	MADB.profiles[pn] = {name = pn, frames = {}}
	
	if not dontUpdate then
		MovAny_OptionsOnShow()
	end
	return true
end

function MovAny:DeleteProfile(pn)
	if pn == "default" then
		maPrint(string.format(MOVANY.PROFILE_CANT_DELETE_DEFAULT, pn))
		return
	end
	local current
	if self:GetProfileName() == pn then
		self:ResetProfile()
		current = true
	end
	
	MADB.profiles[pn] = nil
	for name, char in pairs(MADB.characters) do
		if char and char.profile == pn then
			char.profile = nil
		end
	end
	if current then
		self.userData = MADB.profiles[self:GetProfileName()].frames
		
		local e
		for i, v in pairs(self.userData) do
			e = self.API:GetElement(i)
			if e then
				e:SetUserData(v)
			end
		end
		
		self:SyncAllFrames(true)
		self:UpdateGUIIfShown(true)
	end
	MovAny_OptionsOnShow()
	return true
end

function MovAny:RenameProfile(pn, nn)
	if pn == nn or nn == "default" or nn == "" then
		return
	end
	local p = MADB.profiles[pn]
	if type(p) ~= "table" then
		return
	end
	p.name = nn
	MADB.profiles[nn] = p
	MADB.profiles[pn] = nil
	for i, v in pairs(MADB.characters) do
		if v.profile == pn then
			v.profile = nn
		end
	end
	MovAny_OptionsOnShow()
	return true
end

function MovAny:UpdateProfile()
	if self.userData then
		self:ResetProfile(true)
		self.API:ClearElementsUserData()
	end
	self.userData = MADB.profiles[self:GetProfileName()].frames
	
	local e
	for i, v in pairs(self.userData) do
		e = self.API:GetElement(i)
		if e then
			e:SetUserData(v)
		end
	end
	self:SyncAllFrames(true)
	self:UpdateGUIIfShown(true)
end

function MovAny:RemoveUnavalibleFrames()
	for k, v in pairs(MADB.profiles[self:GetProfileName()].frames) do
		if DeleteThatFrameOpt[k] then
			wipe(MADB.profiles[self:GetProfileName()].frames[k]) -- = nil
		end
	end
end

function MovAny:ChangeProfile(profile)
	self:ResetProfile(true)
	--self:VerifyData()
	local char = MADB.characters[self:GetCharacterIndex()]
	if not char then
		char = {}
		MADB.characters[self:GetCharacterIndex()] = char
	end
	
	char.profile = profile ~= "default" and profile or nil
	self.userData = MADB.profiles[self:GetProfileName()].frames
	
	local e, f
	for i, v in pairs(self.userData) do
		e = self.API:GetElement(i)
		if e then
			e.SetUserData(v)
		else
			e = self.API:AddElementIfNew(i)
		end
	end
	
	self:SyncAllFrames(true)
	self:UpdateGUIIfShown(true)
end

function MovAny:CleanProfile(pn)
	local p = MADB.profiles[pn]
	if type(p) == "table" and type(p.frames) == "table" then
		local f
		for i, v in pairs(p.frames) do
			f = _G[i]
			if f and f.IsUserPlaced and f:IsUserPlaced() and (f:IsMovable() or f:IsResizable()) then
				if f:IsUserPlaced() then
					if not f.MAWasUserPlaced then
						f:SetUserPlaced(nil)
					else
						f.MAWasUserPlaced = nil
					end
				end
				if f:IsMovable() then
					if not f.MAWasMovable then
						f:SetMovable(nil)
					else
						f.MAWasMovable = nil
					end
				end
				if f:IsResizable() then
					if not f.MAWasResizable then
						f:SetResizable(nil)
					else
						f.MAWasResizable = nil
					end
				end
			end
			v.ignoreFramePositionManager = nil
			v.cat = nil
			v.orgScale = nil
			v.orgAlpha = nil
			v.orgPos = nil
			v.MANAGED_FRAME = nil
			v.UIPanelWindows = nil
		end
	end
end