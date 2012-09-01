local NAME, addon = ...
addon.NAME = NAME
XLootGroup = addon

local L = addon.L
local me = UnitName('player')

local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or _G.RAID_CLASS_COLORS
local opt, anchor
local GetLootRollItemInfo, GetLootRollItemLink, RollOnLoot, UnitGroupRolesAssigned, print =
	GetLootRollItemInfo, GetLootRollItemLink, RollOnLoot, UnitGroupRolesAssigned, print

addon.defaults = {
	text_outline = true,
	text_time = false,
	role_icon = true,
	win_icon = false,
	show_undecided = false,

	roll_button_size = 28,
	roll_width = 325,

	roll_anchor = {
		direction = 'up',
		visible = true,
		scale = 1.0,
		x = UIParent:GetWidth() * .85,
		y = UIParent:GetHeight() * .6
	},

	track_all = true,
	track_player_roll = false,
	track_by_threshold = false,
	track_threshold = 3,

	expire_won = 20,
	expire_lost = 10
}

---------------------------------------------------------------------------
-- Skinning
---------------------------------------------------------------------------
local Skinner = {}
LibStub('X-Skin'):SetupSkins(Skinner, {
	row = {},
	item = {},
	anchor = {}
})
local skin
local skin_default = {
	name = ('|c2244dd22%s|r'):format('Smooth'),
	texture = [[Interface\AddOns\XLootGroup\textures\border_smooth]],
	bar_texture = [[Interface\AddOns\XLootGroup\textures\bar]],
	color_mod = .85,
	size = 14,
	padding = 1,
}
local skins_base = {
	anchor = { r = .6, g = .6, b = .6, a = .8 },
	row = { gradient = false },
	item = { backdrop = false }
}
addon.skin_default = skin_default

local function CompileSkins()
	local skins = Skinner._skins
	if XLootFrame and XLootFrame.skin then
		skin = XLootFrame.skin
	else
		skin = skin_default
	end
	for which,subskin in pairs(skins) do
		wipe(subskin)
		for k,v in pairs(skin_default) do
			subskin[k] = skin[k]
		end
		for k,v in pairs(skins_base[which]) do
			subskin[k] = v
		end
	end
	addon.skin = skin
end

addon.bars = {}

---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------
-- Since # doesn't work for non-contiguous tables
local function count(table)
	local i = 0
	for k,v in pairs(table) do
		i = i + 1
	end
	return i
end

-- Tack role icon on to player name and return class colors
local white = { r = 1, g = 1, b = 1 }
local dimensions = {
	HEALER = '48:64',
	DAMAGER = '16:32',
	TANK = '32:48'
}
local string_format = string.format
local function FancyPlayerName(name)
	local c = RAID_CLASS_COLORS[select(2, UnitClass(name))] or white
	local role = UnitGroupRolesAssigned(name)
	if role ~= 'NONE' and opt.role_icon then
		name = string_format('\124TInterface\\LFGFRAME\\LFGROLE:12:12:-1:0:64:16:%s:0:16\124t%s', dimensions[role], name)
	end
	return name, c.r, c.g, c.b
end

local types = {
	need = NEED,
	greed = GREED,
	disenchant = ROLL_DISENCHANT,
	pass = PASS
}

local rolls, canceled, completed, unknownid_to_rollid = { }, { }, { }, { }

---------------------------------------------------------------------------
-- Frame creation
---------------------------------------------------------------------------
local mouse_focus, CreateRollFrame
do
	-- Add a specific roll type to the tooltip
	local function RollLines(players)
		local me = UnitName('player')
		local sf = string.format
		for player, roll in pairs(players) do
			local text, r, g, b, color = FancyPlayerName(player)
			if roll ~= true then
				if mouse_focus.winner == player then
					color = '44ff22'
				elseif player == me then
					color = 'ff2244'
				else
					color = 'CCCCCC'
				end
				GameTooltip:AddLine(sf('   |cff%s%s|r  %s', color, roll, text), r, g, b)
			else
				GameTooltip:AddLine('   '..text, r, g, b)
			end
		end
	end

	-- Add roll status or summary to tooltip
	local plist = {}
	local function AddTooltipLines(self, clean, full)
		local rolls_player = self.rolls_player
		if next(rolls_player) then
			local list
			if clean then
				GameTooltip:AddLine('.', 0, 0, 0)
				-- Players who haven't rolled yet
				-- Only shown when "clean", or showing on frame mouseover
				if opt.show_undecided then
					list = wipe(plist)
					local in_raid,num_raid,num_party = IsInRaid(),GetNumGroupMembers(),GetNumSubgroupMembers() 
					if in_raid then
						for i = 1, num_raid do
							local name = UnitName('raid'..i)
							if not rolls_player[name] then
								list[name] = true
							end
						end
					else
						for i = 1, num_party do
							local name = UnitName('party'..i)
							if not rolls_player[name] then
								list[name] = true
							end
						end
					end
					if not rolls_player[me] then
						list[me] = true
					end
				end
			end
			local rolls_type = self.rolls_type
			if count(rolls_type.need) > 0 then
				GameTooltip:AddLine(NEED, .2, 1, .1)
				RollLines(rolls_type.need)
			end
			if count(rolls_type.greed) > 0 then
				GameTooltip:AddLine(GREED, .1, .2, 1)
				RollLines(rolls_type.greed)
			end
			if count(rolls_type.disenchant) > 0 then
				GameTooltip:AddLine(ROLL_DISENCHANT, 1, .2, 1)
				RollLines(rolls_type.disenchant)
			end
			if count(rolls_type.pass) > 0 then
				GameTooltip:AddLine(PASS, .7, .7, .7)
				RollLines(rolls_type.pass)
			end
			if list and next(list) then
				GameTooltip:AddLine(L.undecided, .7, .3, .2)
				RollLines(list)
			end
			GameTooltip:Show()
			return true
		end
	end

	---------------------------------------------------------------------------
	-- Roll buttons
	---------------------------------------------------------------------------
	local CreateRollButton
	do
		local function OnClick(self)
			RollOnLoot(self.parent.rollid, self.type)
		end
		
		local function Toggle(self, status)
			if status then
				self:Enable()
				self:SetAlpha(1)
			else
				self:Disable()
				self:SetAlpha(.6)
			end
			SetDesaturation(self:GetNormalTexture(), not status)
		end

		local function OnEnter(self)
			mouse_focus = self
			GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT')
			if not AddTooltipLines(self.parent) and self:IsEnabled() ~= 0 then
				GameTooltip:SetText(self.label)
				GameTooltip:Show()
			end
		end

		local function OnLeave(self)
			mouse_focus = nil
			GameTooltip:Hide()
		end

		local function SetText(self, text)
			if text and text > 0 then
				self.text:SetText(text)
			else
				self.text:SetText()
			end
		end

		local path = [[Interface\Buttons\UI-GroupLoot-%s-%s]]
		function CreateRollButton(parent, roll, label, tex, to, x, y)
			local b = CreateFrame('Button', nil, parent)
			b:SetPoint('LEFT', to, 'RIGHT', x, y)
			b:SetWidth(opt.roll_button_size)
			b:SetHeight(opt.roll_button_size)
			b:SetNormalTexture(path:format(tex, 'Up'))
			if tex ~= 'Pass' then
				b:SetHighlightTexture(path:format(tex, 'Highlight'))
				b:SetPushedTexture(path:format(tex, 'Down'))
			else
				b:SetHighlightTexture(path:format(tex, 'Up'))
				b:GetNormalTexture():SetVertexColor(0.8, 0.7, 0.7)
				b:GetHighlightTexture():SetAlpha(0.5)
			end
			b.parent = parent

			local text = b:CreateFontString(nil, 'OVERLAY')
			text:SetFont([[Fonts\FRIZQT__.TTF]], 12, 'THICKOUTLINE')
			text:SetPoint("CENTER", -x + 1, -y)
			b.text = text

			b:SetScript('OnEnter', OnEnter)
			b:SetScript('OnLeave', OnLeave)
			b:SetScript('OnClick', OnClick)
			b:SetMotionScriptsWhileDisabled(true)
			b.OnEnter = OnEnter
			b.Toggle = Toggle
			b.type = roll
			b.label = label
			b.SetText = SetText

			return b
		end
	end

	---------------------------------------------------------------------------
	-- Roll frames
	---------------------------------------------------------------------------
	-- Events
	local function OnEnter(self)
		mouse_focus = self
		GameTooltip:SetOwner(self.icon_frame, 'ANCHOR_TOPLEFT', 28, 0)
		GameTooltip:SetHyperlink(self.link)
		AddTooltipLines(self, true)
		if IsShiftKeyDown() then
			GameTooltip_ShowCompareItem()
		end
		if IsModifiedClick('DRESSUP') then
			ShowInspectCursor()
		else
			ResetCursor()
		end
	end

	local function OnLeave(self)
		mouse_focus = nil
		GameTooltip:Hide()
	end

	local function OnClick(self, button)
		if IsControlKeyDown() then
			DressUpItemLink(self.link)
		elseif IsShiftKeyDown() then
			ChatEdit_InsertLink(self.link)
		end
	end

	-- Status bar update
	local max, sf = math.max, string.format
	local function BarUpdate(self)
		local parent = self.parent
		if parent.winner then
			self.spark:Hide()
			self:SetValue(0)
			return
		end
		local time = GetTime()
		if not parent.fake and GetLootRollTimeLeft(parent.rollid) == 0 then
			local ended = parent.rollended
			if ended then
				if time - ended > 10 then
					anchor:Pop(parent)
				end
			else
				parent.rollended = time
			end
		end
		local remaining = self.expires - time
		if remaining < -4 then
			anchor:Pop(parent)
		else
			local now, length = max(remaining, -1), self.length
			self.spark:SetPoint('CENTER', self, 'LEFT', (now / length) * self:GetWidth(), 0)
			self:SetValue(now)
			self.spark:Show()
			if opt.text_time then
				parent.text_time:SetText(sf('%.0f', remaining))
			end
		end
	end

	local function Popped(self)
		rolls[self.rollid] = nil
	end

	-- Create roll frame
	function CreateRollFrame()
		-- Base frame
		local frame = CreateFrame('Button', nil, UIParent)
		frame:SetFrameLevel(anchor:GetFrameLevel())
		frame:SetHeight(24)
		frame:SetWidth(addon.opt.roll_width)
		frame:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
		frame:SetScript('OnEnter', OnEnter)
		frame:SetScript('OnLeave', OnLeave)
		frame:SetScript('OnClick', OnClick)
		frame.OnEnter = OnEnter
		frame.Start = Start
		frame.Popped = Popped
		
		-- Overlay (For skin border)
		local overlay = CreateFrame('frame', nil, frame)
		overlay:SetFrameLevel(frame:GetFrameLevel())
		overlay:SetAllPoints()
		Skinner:Skin(overlay, 'row')

		-- Item icon (For skin border)
		local icon_frame = CreateFrame('Frame', nil, frame)
		icon_frame:SetPoint('LEFT', 0, 0)
		icon_frame:SetWidth(28)
		icon_frame:SetHeight(28)
		Skinner:Skin(icon_frame, 'item')

		-- Item texture
		local icon = icon_frame:CreateTexture(nil, 'BACKGROUND')
		icon:SetPoint('TOPLEFT', 3, -3)
		icon:SetPoint('BOTTOMRIGHT', -3, 3)
		icon:SetTexCoord(.07,.93,.07,.93)
		
		-- Timer bar
		local bar = CreateFrame('StatusBar', nil, frame)
		bar:SetFrameLevel(frame:GetFrameLevel())
		local pad = skin.padding or skin_default.padding
		bar:SetPoint('TOPRIGHT', -pad - 3, -pad - 3)
		bar:SetPoint('BOTTOMRIGHT', -pad - 3, pad + 3)
		bar:SetPoint('LEFT', icon_frame, 'RIGHT', -pad, 0)
		bar:SetStatusBarTexture(skin.bar_texture or skin_default.bar_texture)
		bar:SetScript('OnUpdate', BarUpdate)
		bar.parent = frame
		-- Reference bar for quick re-skinning when XLoot skin changes
		table.insert(addon.bars, bar)
		
		local spark = bar:CreateTexture(nil, 'OVERLAY')
		spark:SetWidth(14)
		spark:SetHeight(38)
		spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
		spark:SetBlendMode('ADD')
		bar.spark = spark

		-- Bind text
		local bind = icon_frame:CreateFontString(nil, 'OVERLAY')
		bind:SetPoint('BOTTOM', 0, 1)
		bind:SetFont([[Fonts\FRIZQT__.TTF]], 8, 'THICKOUTLINE')

		-- Time text
		local time = icon_frame:CreateFontString(nil, 'OVERLAY')
		time:SetPoint('CENTER', 0, 2)
		time:SetFont([[Fonts\FRIZQT__.TTF]], 12, 'OUTLINE')

		-- Roll buttons
		local n = CreateRollButton(frame, 1, NEED, 'Dice', icon_frame, 3, -1)
		local g = CreateRollButton(frame, 2, GREED, 'Coin', n, 0, -2)
		local d = CreateRollButton(frame, 3, ROLL_DISENCHANT, 'DE', g, 0, 2)
		local p = CreateRollButton(frame, 0, PASS, 'Pass', d, 0, 2)

		-- Roll status text
		local status = frame:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		status:SetHeight(16)
		status:SetJustifyH('LEFT')
		if opt.text_outline then
			local f, s = status:GetFont()
			status:SetFont(f, s, 'OUTLINE')
		end
		status:SetPoint('LEFT', icon_frame, 'RIGHT', 1, 0)
		status:SetPoint('RIGHT', p, 'RIGHT', 2, 0)

		-- Loot name/link
		local loot = frame:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		loot:SetHeight(16)
		loot:SetJustifyH('LEFT')
		if addon.opt.text_outline then
			local f, s = loot:GetFont()
			loot:SetFont(f, s, 'OUTLINE')
		end
		loot:SetPoint('LEFT', p, 'RIGHT', 3, -1)
		loot:SetPoint('RIGHT', frame, 'RIGHT', -5, 0)

		-- Frame references
		frame.need, frame.greed, frame.disenchant, frame.pass = n, g, d, p
		frame.text_bind = bind
		frame.text_status = status
		frame.text_loot = loot
		frame.text_time = time
		frame.overlay = overlay
		frame.bar = bar
		frame.icon = icon
		frame.icon_frame = icon_frame
		frame.Update = UpdateRow

		-- Roll data
		frame.rolls_player = {}
		frame.rolls_type = {
			need = {},
			greed = {},
			disenchant = {},
			pass = {}
		}

		return frame
	end
end

local string_format = string.format
local function UpdateRollStatus(frame)
	if frame.winner then return end
	local r, rt = frame.rolls_player, frame.rolls_type

	local n, g, d, p, num, rtype = count(rt.need), count(rt.greed), count(rt.disenchant), count(rt.pass), 0

	if n > 0 then
		num = n
		rtype = 'need'
	elseif g > 0 or d > 0 then
		num = g + d
		rtype = 'greed'
	elseif p > 0 then
		num = p
		rtype = 'pass'
	end

	if not rtype then
		return
	end

	local r, g, b, mytype = .7, .7, .7, r[me]
	if mytype == rtype or (mytype == 'disenchant' and rtype == 'greed') then
		r, g, b = .2, 1, .1
	elseif mytype and mytype ~= 'pass' then
		r, g, b = 1, .2, .1
	end
	frame.text_status:SetText(string_format('%s: %s', types[rtype], num))
	frame.text_status:SetTextColor(r, g, b)
end

---------------------------------------------------------------------------
-- Roll tracking
---------------------------------------------------------------------------
local math_max = math.max
local function winroll(t)
	local win = 0
	for k,v in pairs(t) do
		win = math_max(win, type(v) == 'number' and v or 0)
	end
	return win
end

local string_format = string.format
local function rollevent(event, chat_event, ...)
	local link = ...
	local name = GetItemInfo(link)

	-- Roll type selected (First frame without selection by player)
	local frame
	if event == 'selected' then
		local item, who, rtype = ...
		-- Update roll data
		for k,v in pairs(rolls) do
			if v.link == item and not v.rolls_player[who] then
				frame = v
				frame.rolls_player[who] = rtype
				frame.rolls_type[rtype][who] = true

				if canceled[frame.rollid] or completed[frame.rollid] then
					UpdateRollStatus(frame)
				else
					frame[rtype]:SetText(count(frame.rolls_type[rtype]))
				end
				if mouse_focus == frame[rtype] then
					frame[rtype]:OnEnter()
				end
				break
			end
		end

	-- All pass (First frame without any selections but pass)
	elseif event == 'allpass' then
		local item = ...
		for k,v in pairs(rolls) do
			if v.link == item and count(v.rolls_type.need) == 0 and count(v.rolls_type.greed) == 0 and count(v.rolls_type.disenchant) == 0 then
				frame = v
				frame.winner = true
				frame.text_status:SetText(string_format('%s: %s', PASS, ALL))
				frame.text_status:SetTextColor(.7, .7, .7)
				frame.bar.expires = GetTime()
				anchor:Expire(frame, opt.expire_lost)
				break
			end
		end

	-- Rolled (Only store roll)
	elseif event == 'rolled' then
		local item, who, rtype, roll = ...
		for k,v in pairs(rolls) do
			if v.link == item and v.rolls_player[who] == rtype then
				frame = v
				frame.rolls_type[rtype][who] = roll
				break
			end
		end

	-- Won (frame with matching winner roll)
	elseif event == 'won' then
		local item, who = ...
		-- Sigh
		local ftemp
		for k,v in pairs(rolls) do
			if v.link == item then
				ftemp = v
				local rtype = v.rolls_player[who]
				if rtype and rtype ~= 'pass' then
					local rt = v.rolls_type
					local roll = rt[rtype][who]
					local n, g, d = winroll(rt.need), winroll(rt.greed) or winroll(rt.disenchant)
					if rtype == 'need' then
						if winroll(rt.need) == roll then
							frame = v
							break
						end
					else
						if winroll(rt.greed) == roll or winroll(rt.disenchant) == roll then
							frame = v
							break
						end
					end
				end
			end
		end
		-- Roll that we didn't catch any events for but matched
		if ftemp and not frame then
			frame = ftemp
			frame.rolls_player[who] = true
			frame.rolls_type.pass[who] = 0
		end
		if frame then
			frame.winner = who
			local player, r, g, b = FancyPlayerName(who)
			if opt.win_icon then
				local win_type = frame.rolls_player[who]
				if win_type == 'need' then
					player = [[|TInterface\Buttons\UI-GroupLoot-Dice-Up:16:16:-1:-1|t]]..player
				elseif win_type == 'greed' then
					player = [[|TInterface\Buttons\UI-GroupLoot-Coin-Up:16:16:-1:-2|t]]..player
				elseif win_type == 'disenchant' then
					player = [[|TInterface\Buttons\UI-GroupLoot-DE-Up:16:16:-1:-1|t]]..player
				end
			end
			frame.text_status:SetText(player)
			frame.text_status:SetTextColor(r, g, b)
			frame.bar.expires = GetTime()
			anchor:Expire(frame, who == me and opt.expire_won or opt.expire_lost)
		end
	end
	-- Refresh tooltip
	if frame and mouse_focus == frame then
		frame:OnEnter()
	end
end

---------------------------------------------------------------------------
-- Group events
---------------------------------------------------------------------------
local function start(id, length, unknownid, ongoing)
	if id and canceled[id] or completed[id] then return end -- Failsafe?
	
	--[[ MoP build16036: START_LOOT_ROLL has an arg3, it matches LOOT_ITEM_AVAILABLE:arg2 and LOOT_ROLLS_COMPLETE:arg1 
		It's some kind of item identifier but I haven't found out what item attribute it relates to (it's not itemid).
		In any case we need it so we can expire roll frames for items when LOOT_ROLLS_COMPLETE fires, so populate a reverse lookup table
		and use it to expire rollid when LOOT_ROLLS_COMPLETE fires
	]]
	if unknownid then unknownid_to_rollid[unknownid]=id end
	
	local icon, name, count, quality, bop, need, greed, de = GetLootRollItemInfo(id)
	local link = GetLootRollItemLink(id)
	local r, g, b = GetItemQualityColor(quality)

	local start = length
	if ongoing then
		if quality == 2 then
			length = 60000
		else
			length = 180000
		end
	end
	length, start = length/1000, start/1000

	local frame = anchor:Push()
	rolls[id] = frame

	frame.need:Show()
	frame.greed:Show()
	frame.disenchant:Show()
	frame.pass:Show()
	frame.text_status:Hide()
	frame.text_status:SetText()
	if opt.text_time then
		frame.text_time:Show()
	else
		frame.text_time:Hide()
	end

	frame.need:Toggle(need)
	frame.greed:Toggle(greed)
	frame.disenchant:Toggle(de)

	frame.need:SetText()
	frame.greed:SetText()
	frame.pass:SetText()
	frame.disenchant:SetText()

	local bar = frame.bar
	bar.length = length
	bar.expires = GetTime() + start

	frame.link = link
	frame.rollid = id
	frame.rollended = nil
	frame.quality = quality
	frame.expires = bar.expires
	frame.winner = nil
	wipe(frame.rolls_player)
	for k,v in pairs(frame.rolls_type) do
		wipe(v)
	end

	frame.text_bind:SetText(bop and '|cffff4422BoP' or '')
	frame.text_loot:SetText(name)

	frame.text_loot:SetVertexColor(r, g, b)
	frame.overlay:SetBorderColor(r, g, b)
	frame.icon_frame:SetBorderColor(r, g, b)
	bar:SetStatusBarColor(r, g, b, .7)
	frame.icon:SetTexture(icon)

	bar:SetMinMaxValues(0, length)
	bar:SetValue(start)


	return frame
end

local function cancel(id)
	canceled[id] = true

	for k,v in pairs(anchor.children) do
		if v.rollid == id then
			local frame = v
			if opt.track_all or 
			(opt.track_player_roll and frame.rolls_player[me] and frame.rolls_player[me] ~= 'pass') or
			(opt.track_by_threshold and frame.quality >= opt.track_threshold) then
				frame.need:Hide()
				frame.greed:Hide()
				frame.disenchant:Hide()
				frame.pass:Hide()
				frame.text_status:Show()
				UpdateRollStatus(frame)
			else
				anchor:Pop(frame)
			end
			break
		end
	end
end

local function complete(unknownid)
	local rollid = unknownid_to_rollid[unknownid]
	if rollid then
		completed[rollid] = true
		for k,v in pairs(anchor.children) do
			if v.rollid == rollid then
				local frame = v
				if opt.track_all or 
				(opt.track_player_roll and frame.rolls_player[me] and frame.rolls_player[me] ~= 'pass') or
				(opt.track_by_threshold and frame.quality >= opt.track_threshold) then
					UpdateRollStatus(frame)
					frame.winner = true
					frame.bar.expires = GetTime()
					anchor:Expire(frame, opt.expire_lost)
				else
					anchor:Pop(frame)
				end
				break
			end
		end
	end
	unknownid_to_rollid[unknownid] = nil
end

-- To avoid a OnUpdate for every mouseoverable frame, use modifier events
local function modifier(self, modifier, state)
	if mouse_focus and MouseIsOver(mouse_focus) and mouse_focus.OnEnter then
		mouse_focus:OnEnter()
	end
end

---------------------------------------------------------------------------
-- AddOn setup and events
---------------------------------------------------------------------------
LibStub('X-Profile'):Setup(addon, 'XLootGroup_Options')
function addon:OnProfileChanged(options)
	opt = options
	addon.opt = opt
end

-- Update skins when XLoot skin changes
function addon:SkinUpdate()
	CompileSkins()
	Skinner:Reskin()
	local pad = skin.padding or skin_default.padding
	local tex = skin.bar_texture or skin_default.bar_texture
	local p, n = pad + 3, -pad - 3
	for _,bar in pairs(addon.bars) do
		bar:ClearAllPoints()
		bar:SetPoint('TOPRIGHT', n, n)
		bar:SetPoint('BOTTOMRIGHT', n, p)
		bar:SetPoint('LEFT', bar.parent.icon_frame, 'RIGHT', -pad, 0)
		bar:SetStatusBarTexture(tex)
		local link = bar.parent.link
		if link then
			local r, g, b = GetItemQualityColor(select(3, GetItemInfo(link)))
			bar.parent.overlay:SetBorderColor(r, g, b)
			bar.parent.icon_frame:SetBorderColor(r, g, b)
		end
	end

end

-- Move anchors when scale changes
function addon:ConfigSave()
	local mod = anchor:GetScale() / anchor.data.scale
	anchor:Scale(anchor.data.scale)
	anchor.data.x = anchor.data.x * mod
	anchor.data.y = anchor.data.y * mod
	anchor:Position()
	anchor:Restack()
	for _,frame in pairs(anchor.children) do
		frame:SetWidth(opt.roll_width)
		frame.need:SetWidth(opt.roll_button_size)
		frame.need:SetHeight(opt.roll_button_size)
		frame.greed:SetWidth(opt.roll_button_size)
		frame.greed:SetHeight(opt.roll_button_size)
		frame.disenchant:SetWidth(opt.roll_button_size)
		frame.disenchant:SetHeight(opt.roll_button_size)
		frame.pass:SetWidth(opt.roll_button_size)
		frame.pass:SetHeight(opt.roll_button_size)
	end
end

function addon:OnLoad()
	XStack = LibStub('X-Stack')

	-- Create Roll anchor
	anchor = XStack:CreateStaticStack(CreateRollFrame, addon.L.anchor, opt.roll_anchor)
	anchor:SetFrameLevel(7)
	anchor:Scale(opt.roll_anchor.scale)
	addon.anchor = anchor

	-- Expire rolls
	local pip_frame = CreateFrame('Frame')
	local timer = 0
	pip_frame:SetScript('OnUpdate', function(self, elapsed)
		if timer < 1 then
			timer = timer + elapsed
		else
			timer = 0
			local time = GetTime()
			-- Extend expiration for mouseovered frames
			if mouse_focus and mouse_focus.aexpire and (mouse_focus.aexpire - time) < 5 then
				mouse_focus.aexpire = time + 5
			end
			for i, frame in ipairs(anchor.expiring) do
				if frame.aexpire and time > frame.aexpire then
					anchor:Pop(frame)
					table.remove(anchor.expiring, i)
				end
			end
			if count(anchor.expiring) == 0 then
				self:Hide()
			end
		end
	end)
	anchor.expiring = {}
	function anchor:Expire(frame, time)
		pip_frame:Show()
		table.insert(self.expiring, frame)
		frame.aexpire = GetTime() + time
	end
	
	-- Register events
	anchor:RegisterEvent('START_LOOT_ROLL')
	anchor:RegisterEvent('CANCEL_LOOT_ROLL')
	anchor:RegisterEvent('MODIFIER_STATE_CHANGED')
	anchor:RegisterEvent('LOOT_ROLLS_COMPLETE')
	anchor:SetScript('OnEvent', function(_, e, ...)
		if e == 'MODIFIER_STATE_CHANGED' then
			modifier(...)
		elseif e == 'START_LOOT_ROLL' then
			start(...) -- rollid, timeremain, uknownid
		elseif e == 'CANCEL_LOOT_ROLL' then
			cancel(...)
		elseif e == 'LOOT_ROLLS_COMPLETE' then
			complete(...)
		end
	end)

	UIParent:UnregisterEvent("START_LOOT_ROLL")
	UIParent:UnregisterEvent("CANCEL_LOOT_ROLL")

	LibStub('LootEvents'):RegisterGroupCallback(rollevent)
	LibStub('X-Config'):Setup(addon, 'XLootGroupOptionPanel')
	
	-- Register as XLoot plugin for skin callback
	if XLootFrame and XLootFrame.RegisterPlugin then
		XLootFrame:RegisterPlugin(addon)
	end

	-- Compile XSkin skin sets
	CompileSkins()

	-- Skin anchor
	Skinner:Skin(anchor, 'row')
	anchor:SetBorderColor(.4, .4, .4)

	-- Find and show active rolls
	local in_raid,in_party = IsInRaid(),IsInGroup()
	if (in_raid or in_party) and (GetLootMethod() == 'group' or GetLootMethod() == 'needbeforegreed') then
		for i=1,300 do
			local time = GetLootRollTimeLeft(i)
			if time > 0 and time < 300000 then -- MoP build 16030: if the masterlooter 'request roll' repeatedly for the same item GetLootRollTimeLeft() returns huge time for past rolls.
				start(i, time, nil, true) -- MoP: START_LOOT_ROLL has 3 args no idea what arg3 is but it's type number
			end
		end
	end
end

-- Slash command for toggling anchors
local function option_handler(msg)
	if msg == 'reset' then
		addon:ResetProfile()
		addon.anchor:Position()
	elseif msg == 'opt' or msg == 'options' then
		addon:ShowOptions()
	else
		if anchor:IsShown() then
			anchor:Hide()
		else
			anchor:Show()
		end
	end
end
SLASH_XLOOTGROUP1 = '/xlg'
SLASH_XLOOTGROUP2 = '/xlootgroup'
SlashCmdList['XLOOTGROUP'] = option_handler

