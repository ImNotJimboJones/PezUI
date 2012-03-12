local addonName, addon = ...

local buttons, order = addon.buttons, addon.order

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function OnClick(self, button)
	if button == 'LeftButton' then
		local toggle = _G[self.toggle]
		if toggle then
			if type(toggle) == 'function' then
				toggle()
			else
				ToggleFrame(toggle)
			end
		end
	elseif button == 'RightButton' and addon.config then
		addon.config()
	end
	UpdateMicroButtons()
end

local function OnEnter(self, motion)
	addon:OnEnter()
	if self.isMoving or not addon:IsTooltipAllowed() then return end
	GameTooltip:SetOwner(self, 'ANCHOR_NONE')
	GameTooltip:SetPoint(addon:GetAnchorInfo(self))
	GameTooltip:SetText(self.title, 1, 1, 1)
	local keyBind = self.keyBind and GetBindingKey(self.keyBind)
	if keyBind then
		GameTooltip:AppendText(NORMAL_FONT_COLOR_CODE .. " (" .. keyBind .. ")")
	end
	if GetCVarBool('showNewbieTips') then
		GameTooltip:AddLine(self.tooltip, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
	end
	if self.tooltipExtend then
		pcall(self.tooltipExtend)
	end
	GameTooltip:Show()
end

local function OnLeave(self, motion)
	addon:OnLeave()
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
end

local function OnDragStart(self, button)
	GameTooltip:Hide()
	if not (addon.db.profile.lock or IsModifierKeyDown()) then
		local y
		self.isMoving, self.x, y = self:GetFrameStrata(), self:GetCenter()
		self:ClearAllPoints()
		self:SetPoint('CENTER', UIParent, 'BOTTOMLEFT', self.x, y)
		self:SetFrameStrata('TOOLTIP')
		self:StartMoving()
	else
		addon:OnDragStart()
	end
end

local function OnDragStop(self, button)
	if self.isMoving then
		self:StopMovingOrSizing()
		self:SetFrameStrata(self.isMoving)
		local x, adj, iMax = self:GetCenter()
		if x < self.x then
			adj, iMax = -1, 1
		else
			adj, iMax = 1, #order
		end
		local new = iMax
		for index = self.order + adj, iMax, adj do
			if (buttons[order[index]]:GetCenter() - x) * adj > 0 then
				new = index - adj
				break
			end
		end
		addon:AdjustButtonOrder(self.id, new)
		self.isMoving, self.x = nil, nil
	else
		addon:OnDragStop()
	end
	if GetMouseFocus() == self then
		OnEnter(self)
	end
end

local latency, overlay, timer = 0, addon.frame:CreateTexture(nil, 'OVERLAY'), PERFORMANCEBAR_UPDATE_INTERVAL
local function OnUpdate(self, elapsed)															-- Menu button only
	timer = timer + elapsed
	if timer < PERFORMANCEBAR_UPDATE_INTERVAL then return end
	timer = 0
	local percent, _
	_, _, latency = GetNetStats()
	percent = latency / addon.db.profile.latency
	if percent <= 0.5 then
		overlay:SetVertexColor(percent + percent, 1, 0)
	elseif percent <= 1 then
		overlay:SetVertexColor(1, 1 - percent, 0)
	else
		overlay:SetVertexColor(1, 0, 0)
	end
end

--[[-----------------------------------------------------------------------------
Create buttons
-------------------------------------------------------------------------------]]
local defaultCoords, menuCoords = { 5/32, 27/32, 31/64, 58/64 }, { 4/32, 28/32, 33/64, 53/64 }

local frame = addon.frame
local function CreateButton(id, title, toggle, tooltip, keyBind, texture, texCoords)
	local button = CreateFrame('CheckButton', nil, frame)

	button.texture = button:CreateTexture(nil, 'ARTWORK')
	button.texture:SetAllPoints(button)
	button:SetCheckedTexture([[Interface\Buttons\CheckButtonHilight]])
	button:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])
	button:SetPushedTexture([[Interface\Buttons\ButtonHilight-Square]])
	button:GetPushedTexture():SetBlendMode('ADD')

	if texture then
		button.texture:SetTexture(texture)
	else
		local background = button:CreateTexture(nil, 'BACKGROUND')
		background:SetAllPoints(button)
		background:SetTexture([[Interface\BUTTONS\WHITE8X8]])
		background:SetVertexColor(0, 0, 0, 1)
	end
	button.texture:SetTexCoord(unpack(texCoords or defaultCoords))

	button:SetScript('OnClick', OnClick)
	button:SetScript('OnDragStart', OnDragStart)
	button:SetScript('OnDragStop', OnDragStop)
	button:SetScript('OnEnter', OnEnter)
	button:SetScript('OnLeave', OnLeave)

	button:SetMovable(true)
	button:RegisterForClicks('AnyUp')
	button:RegisterForDrag('LeftButton')
	button:SetButtonState('NORMAL', false)

	button.id, button.title, button.toggle, button.tooltip, button.keyBind = id, title, toggle, tooltip, keyBind
	buttons[id], buttons[title] = button, button
	return button
end

local button = CreateButton(1, CHARACTER_BUTTON, 'CharacterFrame', NEWBIE_TOOLTIP_CHARACTER, 'TOGGLECHARACTER0', nil, { 0.1, 0.9, 0.0666, 0.9 })
button:SetScript('OnEvent', function(self)
	SetPortraitTexture(self.texture, 'player')
end)
button:RegisterEvent('PLAYER_ENTERING_WORLD')
button:RegisterEvent('UNIT_PORTRAIT_UPDATE')

CreateButton(2, SPELLBOOK_ABILITIES_BUTTON, 'SpellBookFrame', NEWBIE_TOOLTIP_SPELLBOOK, 'TOGGLESPELLBOOK', [[Interface\Buttons\UI-MicroButton-Spellbook-Up]])
CreateButton(3, TALENTS_BUTTON, 'ToggleTalentFrame', NEWBIE_TOOLTIP_TALENTS, 'TOGGLETALENTS', [[Interface\Buttons\UI-MicroButton-Talents-Up]])
CreateButton(4, ACHIEVEMENT_BUTTON, 'ToggleAchievementFrame', NEWBIE_TOOLTIP_ACHIEVEMENT, 'TOGGLEACHIEVEMENT', [[Interface\Buttons\UI-MicroButton-Achievement-Up]])
CreateButton(5, QUESTLOG_BUTTON, 'QuestLogFrame', NEWBIE_TOOLTIP_QUESTLOG, 'TOGGLEQUESTLOG', [[Interface\Buttons\UI-MicroButton-Quest-Up]])

button = CreateButton(6, SOCIAL_BUTTON, 'FriendsFrame', NEWBIE_TOOLTIP_SOCIAL, 'TOGGLESOCIAL', nil, { 6/32, 24/32, 5/32, 29/32 })
button.texture:SetTexture([[Interface\ChatFrame\UI-ChatIcon-BattleBro-Up]])
local count = button:CreateFontString(nil, 'OVERLAY')
count:SetFont(FriendsMicroButtonCount:GetFont())
count:SetTextColor(FriendsMicroButtonCount:GetTextColor())
count:SetShadowOffset(1, -1)
count:SetPoint('BOTTOM', 0, 1)
button.count = count
button:SetScript('OnEvent', function(self)
	local _, numBNetOnline = BNGetNumFriends()
	local _, numWoWOnline = GetNumFriends()
	self.count:SetText(numBNetOnline + numWoWOnline)
end)
button:RegisterEvent('BN_FRIEND_INFO_CHANGED')
button:RegisterEvent('BN_FRIEND_LIST_SIZE_CHANGED')
button:RegisterEvent('FRIENDLIST_UPDATE')
button:RegisterEvent('PLAYER_ENTERING_WORLD')

button = CreateButton(7, GUILD, 'ToggleGuildFrame', NEWBIE_TOOLTIP_GUILDTAB, 'TOGGLEGUILDTAB')
button.overlay = button:CreateTexture(nil, 'OVERLAY')
button.overlay:SetTexCoord(unpack(defaultCoords))
button.overlay:SetAllPoints()
button.overlay:Hide()
button:SetScript('OnEvent', function(self, event)
	if select(10, GetGuildLogoInfo()) then
		self.overlay:Show()
		SetSmallGuildTabardTextures('player', self.overlay, self.texture)
	else
		self.overlay:Hide()
		self.texture:SetTexture([[Interface\Buttons\UI-MicroButton-Socials-Up]])
		self.texture:SetVertexColor(1, 1, 1, 1)
	end
end)
button:RegisterEvent('GUILDTABARD_UPDATE')
button:RegisterEvent('PLAYER_ENTERING_WORLD')
button:RegisterEvent('PLAYER_GUILD_UPDATE')

button = CreateButton(8, PLAYER_V_PLAYER, 'TogglePVPFrame', NEWBIE_TOOLTIP_PVP, 'TOGGLECHARACTER4', nil, { 4/64, 38/64, 2/64, 38/64 })
button:SetScript('OnEvent', function(self, event)
	self.texture:SetTexture([[Interface\TargetingFrame\UI-PVP-]] .. UnitFactionGroup('player'))
	self:UnregisterEvent(event)
	self:SetScript('OnEvent', nil)
end)
button:RegisterEvent('PLAYER_ENTERING_WORLD')

CreateButton(9, DUNGEONS_BUTTON, 'ToggleLFDParentFrame', NEWBIE_TOOLTIP_LFGPARENT, 'TOGGLELFGPARENT', [[Interface\Buttons\UI-MicroButton-LFG-Up]])

button = CreateButton(10, MAINMENU_BUTTON, 'GameMenuFrame', NEWBIE_TOOLTIP_MAINMENU, 'TOGGLEGAMEMENU', ([[Interface\AddOns\%s\MainMenu]]):format(addonName), menuCoords)
overlay:SetParent(button)
overlay:SetAllPoints()
overlay:SetTexture(([[Interface\AddOns\%s\LatencyOverlay]]):format(addonName))
overlay:SetTexCoord(unpack(menuCoords))
button:SetScript('OnUpdate', OnUpdate)
button.tooltipExtend = function()
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(MAINMENUBAR_LATENCY_LABEL:format(latency), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	GameTooltip:AddLine(MAINMENUBAR_FPS_LABEL:format(GetFramerate()), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
end

CreateButton(11, HELP_BUTTON, 'ToggleHelpFrame', NEWBIE_TOOLTIP_HELP, nil, [[Interface\Buttons\UI-MicroButton-Help-Up]])

--[[-----------------------------------------------------------------------------
Hooks
-------------------------------------------------------------------------------]]
local watchedFrames = {
	['CharacterFrame'] = buttons[1],
	['SpellBookFrame'] = buttons[2],
	['PlayerTalentFrame'] = buttons[3],
	['AchievementFrame'] = buttons[4],
	['QuestLogFrame'] = buttons[5],
	['FriendsFrame'] = buttons[6],
	['GuildFrame'] = buttons[7],
	['PVPParentFrame'] = buttons[8],
	['LFDParentFrame'] = buttons[9],
	['GameMenuFrame'] = buttons[10],
	['AudioOptionsFrame'] = buttons[10],
	['InterfaceOptionsFrame'] = buttons[10],
	['KeyBindingFrame'] = buttons[10],
	['MacroFrame'] = buttons[10],
	['VideoOptionsFrame'] = buttons[10],
	['HelpFrame'] = buttons[11]
}

local function UpdateMicroButtons()
	for id = 1, #buttons do
		buttons[id]:SetChecked(false)
	end
	for name, button in pairs(watchedFrames) do
		if _G[name] and _G[name]:IsVisible() then
			button:SetChecked(true)
		end
	end
end

hooksecurefunc('HideUIPanel', function(frame)
	if frame and not watchedFrames[frame:GetName()] then return end
	UpdateMicroButtons()
end)

hooksecurefunc('ShowUIPanel', function(frame)
	frame = frame and watchedFrames[frame:GetName()]
	if not frame then return end
	frame:SetChecked(true)
end)

hooksecurefunc('UpdateMicroButtons', UpdateMicroButtons)
