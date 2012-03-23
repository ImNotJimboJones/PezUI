-- Texture slicing code copied from Rabbit, who copied from !BeatyCase, who thanked Phanx.
-- Default texture from Svelte
local NAME, addon = ...
addon.NAME = NAME
local L = addon.L
local frame = CreateFrame("Frame", "XLootFrame", UIParent)
frame:Hide()
local _G, opt = _G
local XUI = LibStub('X-UI')

-- Default options
local defaults = {
	frame_scale = 1.0,
	frame_alpha = 1.0,

	quality_color_frame = false,
	quality_color_loot = true,

	loot_texts_info = true,
	loot_texts_bind  = true,

	font_size_loot = 12,
	font_size_info = 10,

	loot_highlight = true,
	
	loot_alpha = 1.0,
	loot_collapse = false,
	
	frame_snap = true,
	frame_snap_offset_x = 0,
	frame_snap_offset_y = 0,
	
	frame_width_automatic = true,
	frame_width = 150,

	frame_position_x = GetScreenWidth()/2,
	frame_position_y = GetScreenHeight()/2,

	autoloot_coin = 'never',
	autoloot_quest = 'never',
	
	frame_draggable = true,

	linkall_threshold = 2, -- Quality from 0 - 6, Poor - Artifact
	linkall_channel = 'RAID',
	linkall_show = 'auto',

	frame_color_border = { .7, .7, .7 },
	frame_color_backdrop = { 0, 0, 0, .9 },
	frame_color_gradient = { .5, .5, .5, .6 },
	loot_color_border = { .5, .5, .5 },
	loot_color_backdrop = { 0, 0, 0, .9 },
	loot_color_gradient = { .5, .5, .5, .6 },
	loot_color_info = { .5, .5, .5 },

	skin = 'smooth'
}

addon.defaults = defaults

-- CLI output
local print, wprint = print, print
local x_prefix = '|c2244dd22XLoot|r'
local function xprint(text) wprint(('%s: %s'):format(x_prefix, text)) end
local function xfprint(pattern, ...) xprint(pattern:format(...)) end

-- Custom skins
-- To add your own, simply make XLoot a dependency then call XLootFrame:RegisterSkin(name, skin_table)
-- skin_table being a table with these keys:
-- [required] texture - Path to texture
-- [optional] name - Shown in UI, name provided to RegisterSkin used by default
-- [optional] size, size_highlight
-- [optional] row_spacing
-- [optional] frame_color_*, loot_color_* -- See above
-- [optional] color_mod - Multiplier for border quality colors
-- [optional] padding, padding_highlight - Padding refers to how far outward (or inward) the border should be offset from the frame

-- Tweaking Masque skins
-- To keep from having to change this file, call XLootFrame:RegisterMasqueTweak(skin_name, skin_table)
-- following the same rules as custom skins

local skin = { }
local skins = { }
local masque_tweaks = { }
addon.skins = skins

do
	local base = {
		color_mod = .75,
		row_spacing = 2,
	}
	local svelte = {
		name = ('|c2244dd22%s|r'):format("XLoot: Svelte"),
		texture = [[Interface\AddOns\XLoot1.0\textures\svelte_square]],
	}
	local legacy = {
		name = ('|c2244dd22%s|r'):format(L.config.skin_legacy),
		row_spacing = 3,
		
		texture = [[Interface\AddOns\XLoot1.0\textures\svelte_modified]],
		size = 14,
		size_highlight = 12,
		
		color_mod = .85,
		frame_color_border = { .5, .5, .5 },
		frame_color_backdrop = { .0, .0, .0, .7 },
		frame_color_gradient = { .5, .5, .5, .3 },
		loot_color_border = { .5, .5, .5 },
		loot_color_backdrop = { .0, .0, .0, .9 },
		loot_color_gradient = { .5, .5, .5, .4 },
	}
	local smooth = {
		name = ('|c2244dd22%s|r'):format(L.config.skin_smooth),
		row_spacing = 3,
		
		texture = [[Interface\AddOns\XLoot1.0\textures\border_smooth]],
		size = 14,
		size_highlight = 6,
		padding = 1,
		padding_highlight = -1,
		
		color_mod = .9,
		frame_color_border = { .5, .5, .5 },
		frame_color_backdrop = { .0, .0, .0, .7 },
		frame_color_gradient = { .5, .5, .5, .3 },
		loot_color_border = { .5, .5, .5 },
		loot_color_backdrop = { .0, .0, .0, .9 },
		loot_color_gradient = { .5, .5, .5, .4 },
	}
	local mt = { __index = base }
	function XLootFrame:RegisterSkin(skin_name, skin_table)
		setmetatable(skin_table, mt)
		skins[skin_name] = skin_table
	end
	XLootFrame:RegisterSkin('svelte', svelte)
	XLootFrame:RegisterSkin('legacy', legacy)
	XLootFrame:RegisterSkin('smooth', smooth)
	
	-- Masque skins
	local MasqueSkins = XUI:SkinsFromMasque()
	if MasqueSkins then
		for name, skin in pairs(MasqueSkins) do
			XLootFrame:RegisterSkin(name, skin)
		end
	elseif LibStub('Masque', true) then
		xprint("Use of masque skins requires the beta version of Masque.")
	end
	
	function XLootFrame:RegisterMasqueTweak(masque_name, tweak_table)
		masque_tweaks[masque_name] = tweak_table
		if skins[masque_name] then
			for k, v in pairs(tweak_table) do
				skins[masque_name][k] = v
			end
		end
	end
	XLootFrame:RegisterMasqueTweak('simpleSquare', { size = 12, row_spacing = 4 })
	XLootFrame:RegisterMasqueTweak('Caith', { size = 12, row_spacing = 4 })
	XLootFrame:RegisterMasqueTweak('Svelte Shadow', { size = 14 })
	XLootFrame:RegisterMasqueTweak('Square Shadow', { size = 16 })
end

-- Plugins
local plugins = {}

function XLootFrame:RegisterPlugin(plugin)
	table.insert(plugins, plugin)

end

function PluginTrigger(what, ...)
	for _, plugin in ipairs(plugins) do
		if plugin[what] then
			plugin[what](plugin, ...)
		end
	end
end



-----------------------
-- Soulbind scanning --
-----------------------
local function GetBindOn(item)
	if not XLootTooltip then CreateFrame('GameTooltip', 'XLootTooltip', UIParent, 'GameTooltipTemplate') end
	local tt = XLootTooltip
	tt:SetOwner(UIParent, 'ANCHOR_NONE')
	tt:SetHyperlink(item)
	if XLootTooltip:NumLines() > 1 and XLootTooltipTextLeft2:GetText() then
		local t = XLootTooltipTextLeft2:GetText()
		tt:Hide()
		if t == ITEM_BIND_ON_PICKUP then
			return 'pickup'
		elseif t == ITEM_BIND_ON_EQUIP then
			return 'equip'
		elseif t == ITEM_BIND_ON_USE then
			return 'use'
		end
	end
	tt:Hide()
	return nil
end

local bop, boe, bou
local function BindText(bind)
	if not bop then
		bop = ('|cffff4422%s|r '):format(L.bind_on_pickup_short)
		boe = ('|cff44ff44%s|r '):format(L.bind_on_equip_short)
		bou = ('|cff2244ff%s|r '):format(L.bind_on_use_short)
	end
	local out = bind == 'pickup' and bop or bind == 'equip' and boe or bind == 'use' and bou or ''
	return out
end

--------------
-- Link-all --
--------------

local LinkLoot, LinkDropdown
do
	local output = { }
	function LinkLoot(channel, isExtraChannel)
		local output, key, buffer = output, 1
		local sf = string.format

		if UnitExists('target') then
			output[1] = sf('%s:', UnitName('target'))
		end

		local linkthreshold, reached = opt.linkall_threshold
		for i=1, GetNumLootItems() do
			if LootSlotIsItem(i) then
				local texture, item, quantity, rarity = GetLootSlotInfo(i)
				local link = GetLootSlotLink(i)
				if rarity >= linkthreshold then
					reached = true
					buffer = sf('%s%s%s', (output[key] and output[key].." " or ""), (quantity > 1 and quantity.."x" or ""), link)
					if strlen(buffer) > 255 then
						key = key + 1
						output[key] = (quantity > 1 and quantity.."x" or "")..link
					else
						output[key] = buffer
					end
				end
			end
		end

		if not reached then
			xprint(L.linkall_threshold_missed)
			return false
		end

		for k, v in pairs(output) do
			v  = string.gsub(v, "\n", " ", 1, true) -- DIE NEWLINES, DIE A HORRIBLE DEATH
			SendChatMessage(v, channel)
			output[k] = nil
		end

		return true
	end

	
	local function Click(dropdown, channel)
		LinkLoot(channel)
	end
	
	LinkDropdown = CreateFrame('Frame', 'XLootLinkDropdown')
	LinkDropdown.displayMode = 'MENU'
	local channels = {
		{ 'SAY', CHAT_MSG_SAY },
		{ 'PARTY', CHAT_MSG_PARTY },
		{ 'RAID', CHAT_MSG_RAID },
		{ 'RAID_WARNING', CHAT_MSG_RAID_WARNING },
		{ 'GUILD', CHAT_MSG_GUILD },
		{ 'OFFICER', CHAT_MSG_OFFICER },
	}
	local info = { }
	LinkDropdown.initialize = function(self, level)
		for i, c in ipairs(channels) do
			wipe(info)
			info.text = c[2]
			info.arg1 = c[1]
			info.func = Click
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, 1)
		end
	end
end

--------------------
-- Frame creation --
--------------------
local font = STANDARD_TEXT_FONT

-- Universal events
local function OnDragStart()
	if opt.frame_draggable then
		XLootFrame:StartMoving()
	end
end

local function OnDragStop()
	XLootFrame:StopMovingOrSizing()
	opt.frame_position_x = XLootFrame:GetLeft()
	opt.frame_position_y = XLootFrame:GetTop()
end

-- Colors
local function Darken(mult, ...)
	local r, g, b, a = ...
	if type(r) == 'table' then
		r, g, b, a = unpack(r)
	end
	return r * mult, g * mult, b * mult, a or 1
end

local function GetColor(self, key, mult)
	local opt, skin, t = self.opt, self.skin
	local raw, default = rawget(opt, key), defaults[key]
	-- Use options if different from defaults
	if raw and (raw[1] ~= default[1] or raw[2] ~= default[2] or raw[3] ~= default[3] or raw[4] ~= default[4]) then
		t = raw
	-- Use skin if options are defaults
	elseif skin[key] then
		t = skin[key]
	-- Use defaults
	else
		t = defaults[key]
	end
	-- Darken
	if mult then
		return Darken(mult, t)
	end
	return unpack(t)
end

-- Build individual loot row
local mouse_focus
local BuildRow
do
	-- Text helpers
	local function smalltext(text, size, ext)
		text:SetFont(font, size or 10, ext or '')
		text:SetDrawLayer'OVERLAY'
		text:SetHeight(10)
		text:SetJustifyH'LEFT'
		text.ext = ext
	end

	local function textpoints(text, item, row, x)
		text:SetPoint('LEFT', item, 'RIGHT', x, 0)
		text:SetPoint('RIGHT', row, 'RIGHT', -4, 0)
	end

	local function OffsetText(self, text, y)
		text:SetPoint('TOP', self, 0, y)
	end
	
	-- Color overrides
	local function SetBorderColor(self, r, g, b, a)
		self:_SetBorderColor(r, g, b, a or 1)
		self.frame_item:SetBorderColor(r, g, b, a or 1)
	end

	local function SetHighlightColor(self, r, g, b)
		self:SetHighlightColor(r, g, b)
		self.frame_item:SetHighlightColor(r, g, b)
	end

	-- Frame events
	local ShowTooltip
	do
		local function show(self)
			local f
			if LootSlotIsItem(self.slot) then
				f = GameTooltip.SetLootItem
			elseif LootSlotIsCurrency(self.slot) then
				f = GameTooltip.SetLootCurrency
			else
				return nil
			end
			GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 32, 0)
			f(GameTooltip, self.slot)
			CursorUpdate(self)
		end
		
		function ShowTooltip(self)
			pcall(show, self)
		end
	end		
	
	local function HighlightEnter(self)
		if self._highlights then
			self.frame_item:ShowHighlight()
		end
	end
	
	local function HighlightLeave(self)
		if self._highlights then
			self.frame_item:HideHighlight()
		end
	end
	
	local function OnEnter(self)
		HighlightEnter(self)
		mouse_focus = self
		self:ShowTooltip()
	end

	local function OnLeave(self)
		mouse_focus = nil
		HighlightLeave(self)
		GameTooltip:Hide()
		ResetCursor()
	end

	local function OnClick(self, button)
		if IsModifiedClick() then
			HandleModifiedItemClick(GetLootSlotLink(self.slot))
		else
			pcall(LootButton_OnClick, self, button)
		end
	end
	
	-- Appearance/skin updates
	local function UpdateAppearance(self)
		local owner, opt = self.owner, self.owner.opt
		-- Colors
		self:SetBorderColor(owner:GetColor('loot_color_border'))
		self:SetBackdropColor(owner:GetColor('loot_color_backdrop', 0.7))
		self:SetGradientColor(owner:GetColor('loot_color_gradient'))
		self.frame_item:SetGradientColor(owner:GetColor('loot_color_gradient'))
		self.text_info:SetTextColor(owner:GetColor('loot_color_info'))
		self:SetAlpha(opt.loot_alpha)
		
		-- Text
		self.text_name:SetFont(font, opt.font_size_loot)
		self.text_info:SetFont(font, opt.font_size_info)
		
		-- Calculated row height
		owner.row_height = self:GetHeight() + owner.skin.row_spacing
		
		-- Highlight textures
		if opt.loot_highlight then
			if not self._highlights then
				owner:Highlight(self, 'row_highlight')
				owner:Highlight(self.frame_item, 'item_highlight')
			end
			self:SetHighlightColor(.8, .8, .8, .8)
			self.frame_item:SetHighlightColor(.8, .8, .8, .8)
		elseif self._highlights then
			self:SetHighlightColor(0, 0, 0, 0)
			self.frame_item:SetHighlightColor(0, 0, 0, 0)
		end
	end

	-- Update slot with loot
	local function Update(self, is_item, icon, name, link, quantity, quality, locked, isQuestItem, questId, isActive)
		local r, g, b, hex
		local owner, opt = self.owner, self.owner.opt
		local text_info, text_name, text_bind = '', '', ''
		
		-- Items
		local layout = 'simple'
		if is_item then
			r, g, b, hex = GetItemQualityColor(quality)
			
			text_name = ('|c%s%s|r'):format(hex, name)
			
			if opt.loot_texts_info then -- This is a bit gnarly
				local _, _, _, _, _, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(link)
				local equip = itemType == ENCHSLOT_WEAPON and ENCHSLOT_WEAPON or itemEquipLoc ~= '' and _G[itemEquipLoc] or ''
				local itemtype = (itemSubType == 'Junk' and quality > 0) and MISCELLANEOUS or itemSubType
				text_info = ((type(equip) == 'string' and equip ~= '') and equip..', ' or '') .. itemtype
				layout = 'detailed'
			end
			
			if opt.loot_texts_bind then
				text_bind = BindText(GetBindOn(link))
			end
			
		-- Currency
		else
			r, g, b = .4, .4, .4
			text_name = name:gsub('\n', ', ')
		end
		
		-- Strings
		self.text_name:SetText(text_name)
		self.text_info:SetText(text_info)
		self.text_bind:SetText(text_bind)
		self.text_quantity:SetText(quantity > 1 and quantity or nil)

		-- Icon
		self.texture_item:SetTexture(icon)
		if locked then
			self.texture_item:SetVertexColor(.5, .1, .1)
		else
			self.texture_item:SetVertexColor(1, 1, 1)
		end
		
		-- Layout
		if self.layout ~= layout then
			self.layout = layout
			if layout == 'simple' then
				self:OffsetText(self.text_name, -9)
			else
				self:OffsetText(self.text_name, -5)
				self:OffsetText(self.text_info, -15)
			end
		end

		-- Quality coloring
		if opt.quality_color_loot then
			self:SetBorderColor(Darken(owner.skin.color_mod, r, g, b))
		end
		
		-- Quest icon
		if questId then
			self.texture_bang:Show()
		else
			self.texture_bang:Hide()
		end
		
		-- Attach
		if self.i == 1 then
			self:SetPoint('TOP', 0, -10)
		else
			self:SetPoint('TOP', owner.rows[self.i-1], 'BOTTOM', 0, owner.skin.row_offset)
		end
		
		self:Show()
		
		return max(self.text_info:GetStringWidth(), self.text_name:GetStringWidth())
	end

	-- Factory
	function BuildRow(frame, i)
		local frame_name = frame:GetName()..'Button'..i
		local fake = frame.fake
		-- Create frames
		local row = CreateFrame('Button', fake and nil or frame_name, frame)
		local item = CreateFrame('Frame', nil, row)
		local tex = item:CreateTexture(nil, 'BACKGROUND')
		local bang = item:CreateTexture(nil, 'OVERLAY')

		-- Create fontstrings
		local name = row:CreateFontString(fake and nil or frame_name..'Text')
		local info = row:CreateFontString()
		local bind = item:CreateFontString()
		local quantity = item:CreateFontString()

		-- Setup fontstrings
		smalltext(name, opt.font_size_loot)
		smalltext(info, opt.font_size_info)
		smalltext(bind, 8, 'outline')
		smalltext(quantity, 10, 'outline')
		textpoints(name, item, row, 2)
		textpoints(info, item, row, 8)
		bind:SetPoint('BOTTOMLEFT', 2, 2)
		quantity:SetPoint('BOTTOMRIGHT', -2, 2)
		quantity:SetJustifyH('RIGHT')

		-- Align frames
		row:SetHeight(30)
		row:SetPoint('LEFT', 10, 0)
		row:SetPoint('RIGHT', -10, 0)

		item:SetPoint('LEFT', 0, 0)
		item:SetHeight(34)
		item:SetWidth(34)
		tex:SetPoint('TOPLEFT', 3, -3)
		tex:SetPoint('BOTTOMRIGHT', -3, 3)
		tex:SetTexCoord(.07,.93,.07,.93)
		bang:SetPoint('BOTTOMRIGHT')
		bang:SetWidth(16)
		bang:SetHeight(16)
		bang:SetTexture([[Interface\Minimap\ObjectIcons.blp]])
		bang:SetTexCoord(1/8, 2/8, 1/8, 2/8)

		-- Skin row
		frame:Skin(row)
		frame:Skin(item, 'item')

		-- Wire row
		if fake then
			row:RegisterForClicks()
			row:SetScript('OnEnter', HighlightEnter)
			row:SetScript('OnLeave', HighlightLeave)
		else
			row:RegisterForDrag('LeftButton')
			row:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
			row:SetScript('OnDragStart', OnDragStart)
			row:SetScript('OnDragStop', OnDragStop)
			row:SetScript('OnClick', OnClick)
			row:SetScript('OnEnter', OnEnter)
			row:SetScript('OnLeave', OnLeave)
		end

		-- Set references
		row.text_name = name
		row.text_info = info
		row.text_bind = bind
		row.text_quantity = quantity
		row.frame_item = item
		row.texture_item = tex
		row.texture_bang = bang
		row.owner = frame
		row.i = i

		-- Helpers
		row.SetTexts = SetTexts
		row.SetIcon = SetIcon
		row.OffsetText = OffsetText
		row.ShowTooltip = ShowTooltip
		row.UpdateAppearance = UpdateAppearance
		row.Update = Update
		
		-- Overrides
		row.SetBorderColor, row._SetBorderColor = SetBorderColor, row.SetBorderColor

		-- Apply appearance
		row:UpdateAppearance()
		
		return row
	end
end

-- Build frame
local BuildFrame
do
	-- Frame snapping
	local function SnapToCursor(self)
		local x, y = GetCursorPosition()
		local f = self
		local s = f:GetEffectiveScale()

		if opt.frame_snap then
			-- Horizontal position
			if not f:IsShown() then
				x = (x / s) - 30
				local sWidth, fWidth, uWidth = GetScreenWidth(), f:GetWidth(), UIParent:GetWidth()
				if uWidth > sWidth then sWidth = uWidth end
				if x + fWidth > sWidth then x = sWidth - fWidth end
				if x < 0 then x = 0 end
				x = x + opt.frame_snap_offset_x
			else
				x = f:GetLeft() or x
			end

			-- Vertical position
			y = (y / s) + 30
			local sHeight, fHeight, uHeight = GetScreenHeight(), f:GetHeight(), UIParent:GetHeight()
			if uHeight > sHeight then sHeight = uHeight end
			if y > sHeight then y = sHeight end
			if y - fHeight < 0 then y = fHeight end
			y = y + opt.frame_snap_offset_y
		else
			x = opt.frame_position_x or x
			y = opt.frame_position_y or y
		end

		-- Apply
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
	end

	
	-- Link loot menu
	local function LinkClick(self, button)
		if button == 'RightButton' then
			ToggleDropDownMenu(1, nil, LinkDropdown, self)--, GetCursorPosition())
		else
			LinkLoot(self:GetParent().opt.linkall_channel)
		end
	end
	
	-- Bottom buttons
	local function BottomButton(frame, name, text, justify)
		local b = CreateFrame('Button', name, frame)
		b.text = b:CreateFontString(name..'Text', 'DIALOG', 'GameFontNormalSmall')
		b.text:SetText('|c22AAAAAA'..text)
		b.text:SetJustifyH(justify)
		b.text:SetAllPoints(b)
		b:SetFrameLevel(8)
		b:SetHeight(16)
		b:SetHighlightTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]])
		b:ClearAllPoints()
		b:SetPoint('BOTTOM', 0, 3)
		b:SetHitRectInsets(-4, -4, 3, -2)
		b:Show()
		return b
	end

	local function UpdateHeight(self)
		if self.row_height then
			self:SetHeight(26 + #self.slots * self.row_height)
		end
	end

	local function UpdateWidth(self, width_max)
		local width = self.opt.frame_width_automatic and (width_max + 70) or (self.opt.frame_width + 50)
		self:SetWidth(width)
		width = width * 0.5 - 10
		self.link:SetWidth(width)
		self.close:SetWidth(width)
	end

	local function UpdateLinkButton(self)
		local default, show, now = self.opt.linkall_channel, self.opt.linkall_show, false
		if show == 'auto' then
			if default == 'SAY' or
				((default == 'GUILD' or default == 'OFFICER') and IsInGuild()) or
				((default == 'RAID' or default == 'RAID_WARNING') and GetNumRaidMembers() > 0) or
				(default == 'PARTY' and GetNumPartyMembers() > 0)
			then
				now = true
			end
		elseif show == 'always' then
			now = true
		end
		if now then
			self.link:Show()
		else
			self.link:Hide()
		end
	end
	
	local function SizeAndColor(self, max_width, max_quality)
		-- Update frame
		self:UpdateLinkButton()
		self:UpdateHeight()
		self:UpdateWidth(max_width)
		
		-- Color frame
		if self.opt.quality_color_frame then
			self.overlay:SetBorderColor(GetItemQualityColor(max_quality))
		end
	end
	
	-- Update skin/appearance
	local function UpdateAppearance(self)
		self.skin.row_offset = self.skin.row_spacing * -1
		
		local skins, skin = self._skins, self.skin
		skins.default.size = skin.size
		skins.default.padding = skin.padding
		skins.default.texture = skin.texture
		
		skins.item.size = skin.size
		skins.item.padding = skin.padding
		skins.item.texture = skin.texture
		
		skins.item_highlight.size = skin.size_highlight or skin.size
		skins.item_highlight.texture = skin.texture_highlight or nil
		skins.item_highlight.padding = skin.padding_highlight or skin.padding
		
		skins.row_highlight.size = skin.size_highlight or skin.size
		skins.row_highlight.texture = skin.texture_highlight or nil
		skins.row_highlight.padding = skin.padding_highlight or skin.padding
		
		self:Reskin()
		
		local overlay = self.overlay

		-- Update colors/other
		self:SetScale(self.opt.frame_scale)
		overlay:SetAlpha(self.opt.frame_alpha)
		overlay:SetBorderColor(self:GetColor('frame_color_border'))
		overlay:SetGradientColor(self:GetColor('frame_color_gradient'))
		overlay:SetBackdropColor(self:GetColor('frame_color_backdrop', 0.7))
		
		-- Update loot frames
		for i, row in ipairs(self.rows) do
			row:UpdateAppearance()
		end
		
		-- Resize frame
		if #self.slots > 0 and self.opt.frame_width_automatic then
			local max_width, max = 0, math.max
			for i, slot in ipairs(self.slots) do
				max_width = max(max_width, slot.text_name:GetStringWidth(), slot.text_info:GetStringWidth())
			end
			self:UpdateWidth(max_width)
		end
	end

	-- Factory
	function BuildFrame(f)
		local name = f:GetName()
		-- Setup frame
		f:SetFrameStrata('DIALOG')
		f:SetFrameLevel(5)
		f:EnableMouse(1)
		
		-- Skin helpers
		f.UpdateAppearance = UpdateAppearance
		
		-- Set up frame skins
		XUI:SetupSkins(f, {
			default = { },
			item = { backdrop = false },
			row_highlight = { type = 'highlight' },
			item_highlight = { type = 'highlight', layer = 'OVERLAY' },
		}, 'default')
		
		-- Use a secondary frame for backdrop/border to allow the "frame" opacity to be changed
		local overlay = CreateFrame('Frame', nil, f)
		overlay:SetFrameLevel(5)
		overlay:SetAllPoints()
		f:Skin(overlay)

		-- Link all button
		local lb = BottomButton(f, name..'Link', L.button_link, 'MIDDLE')
		lb:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
		lb:SetPoint('LEFT', 6, 0)

		-- Close button
		local cb = BottomButton(f, name..'Close', L.button_close, 'MIDDLE')
		cb:SetPoint('RIGHT', -6, 0)

		-- Events
		if not f.fake then
			f:SetMovable(1)
			f:RegisterForDrag('LeftButton')
			f:SetScript('OnDragStart', OnDragStart)
			f:SetScript('OnDragStop', OnDragStop)
			lb:SetScript('OnClick', LinkClick)
			cb:SetScript('OnClick', function() CloseLoot() end)
			f.SnapToCursor = SnapToCursor
		end

		f.overlay = overlay
		f.close = cb
		f.link = lb
		f.SetAlpha, f._SetAlpha = function(self, alpha) b:SetAlpha(alpha) end, f.SetAlpha
		f.UpdateHeight = UpdateHeight
		f.UpdateWidth = UpdateWidth
		f.UpdateLinkButton = UpdateLinkButton
		f.SizeAndColor = SizeAndColor
		f.GetColor = GetColor
		f.rows = setmetatable({ }, { __index = function(t, k)
			local row = BuildRow(f, k)
			t[k] = row
			return row
		end })
		f.slots_index = { }
		f.slots = { }

		f:UpdateAppearance()
		f.built = true
	end
end

-- Main loot handler
function XLootFrame:Update()
	local numloot = GetNumLootItems()
	if numloot == 0 then return nil end
	local max = math.max

	-- Construct frame
	if not self.built then
		BuildFrame(self)
	end

	-- References
	local rows, slots, slots_index = self.rows, wipe(self.slots), wipe(self.slots_index)
	
	-- Autolooting options
	local party = (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0)
	local auto_coin, auto_quest, auto_space = self.opt.autoloot_coin, self.opt.autoloot_quest
	auto_coin = auto_coin == 'always' or (auto_coin == 'solo' and not party)
	auto_quest = auto_quest == 'always' or (auto_quest == 'solo' and not party)
	
	-- Update rows
	local max_quality, max_width, our_slot, slot = 0, 0, 0
	for slot = 1, numloot do
		local _, icon, name, quantity, quality, locked, isQuestItem, questId, isActive = pcall(GetLootSlotInfo, slot)
		if icon then -- Occasionally WoW will open loot with empty or invalid slots
			local looted = false
			
			-- Autolooting coin
			if auto_coin and LootSlotIsCoin(slot) then
				LootSlot(slot)
				looted = true
				
			-- Autolooting quest items
			elseif auto_quest and isQuestItem then
				-- Cache available space
				if auto_space == nil then
					local open = 0
					for i = 1, NUM_BAG_SLOTS do
						open = open + GetContainerNumFreeSlots(i)
					end
					auto_space = open
				end
				-- We have room
				if auto_space > 0 then
					LootSlot(slot)
					auto_space = auto_space - 1
						-- This could prevent autolooting more quest items from the same loot
						-- but is faster than checking stack information each time
						-- and will only affect this loot
					looted = true
				-- We might have a partial stack
				else
					local cur = GetItemCount(name)
					local loot = false
					if cur > 0 then
						local stack = select(8, GetItemInfo(name))
						local partial = cur % stack
						if partial + quantity <= stack then
							LootSlot(slot)
							looted = true
						end
					end
				end
			end
				
			-- Initialize slot
			if not looted then
				our_slot = our_slot + 1 -- Incriment visible slots
				row = rows[our_slot] -- Acquire row
				slots[our_slot] = row -- Place in active list
				
				--local icon, name, quantity, quality, locked, isQuestItem, questId, isActive = GetLootSlotInfo(slot)
				-- Row data
				local is_item, link = LootSlotIsItem(slot)
				if is_item then
					link = GetLootSlotLink(slot)
				end
				
				-- Default UI and tooltip data
				row.item = link
				row.quality = quality
				row.slot = slot
				row.frame_slot = our_slot
				row:SetID(slot)
				
				-- Update row
				local width = row:Update(is_item, icon, name, link, quantity, quality, locked, isQuestItem, questId, isActive)
				
				max_width = max(width, max_width)
				max_quality = max(quality, max_quality)
			end
		end
	end
	
	-- Exit if we autolooted everything
	if our_slot == 0 then
		CloseLoot()
		return nil
	end
	
	self:SizeAndColor(max_width, max_quality)

	-- Show
	self:SnapToCursor()
	self:Show()
end

local function clear(slot)
	if not slot then return nil end
	slot.slot = nil
	slot.item = nil
	slot.quality = nil
	slot:Hide()
end

local function Closed(self)
	if type(self.slots) == 'table' then
		for i, slot in pairs(self.slots) do
			clear(slot)
		end
		wipe(self.slots)
	end
	self:Hide()
	StaticPopup_Hide('LOOT_BIND')
	if UIDropDownMenu_GetCurrentDropDown() == LinkDropdown then
		CloseDropDownMenus()
	end
end

local loot = { }
local function Opened(self)
	if GetNumLootItems() > 0 then
		self:Update()
		if not self:IsShown() and IsFishingLoot() then
			PlaySound('FISHING REEL IN')
		end
	else
		CloseLoot()
	end
end

local function Cleared(self, slot)
	local slots = self.slots
	for id, row in ipairs(slots) do
		if row.slot == slot then
			clear(row)
			if self.opt.loot_collapse then
				local prev, next = slots[id-1], slots[id+1]
				if prev and next then
					next:SetPoint('TOP', prev, 'BOTTOM', nil, self.skin.row_offset)
				elseif next then
					next:SetPoint('TOP', 0, -10)
				end
				table.remove(slots, id)
				self:UpdateHeight()
			end
		end
	end
end

-- Show compare tooltip when shift pressed
-- Without using OnUpdate for all frames
local function ModifierStateChanged(self, modifier, state)
	if (GetNumLootItems() ~= 0) and mouse_focus and MouseIsOver(mouse_focus) then
		mouse_focus:ShowTooltip()
	end
end

---------------------------------------
--    Profiles and initialization    --
---------------------------------------

function addon:OnLoad()
	-- Event handling
	local events = {
		LOOT_OPENED = Opened,
		LOOT_SLOT_CLEARED = Cleared,
		LOOT_CLOSED = Closed,
		MODIFIER_STATE_CHANGED = ModifierStateChanged
	}
	for e in pairs(events) do
		frame:RegisterEvent(e)
		LootFrame:UnregisterEvent(e)
	end
	XLootFrame:SetScript('OnEvent', function(self, e, ...) if events[e] then events[e](self, ...) end end)
	
	-- Option frame
	LibStub('X-Config'):Setup(addon, 'XLootOptionPanel')
end

function addon:OnProfileChanged(options)
	opt = options
	frame.opt = opt
	frame.skin = skins[opt.skin] or skins.smooth
	
	-- Refresh frame appearance
	if frame.UpdateAppearance then
		frame:UpdateAppearance()
	end

	PluginTrigger('SkinUpdate')
end

LibStub('X-Profile'):Setup(addon, 'XLoot_Options')

--------------------------
--    Configuration     --
--------------------------

-- Preview frame
local preview = CreateFrame('Frame', 'XLootFramePreview')
preview.opt = { }
preview.fake = true

-- Preview handler
local preview_loot = {
	{ 43491 },
	{ 52722, 10 },
	{ 31304 },
	{ 37254 },
	{ 13262, 1, true },
	{ 61958 },
	{ 29590, 1, false, true },
}
-- Activate items
for i, t in ipairs(preview_loot) do
	GetItemInfo(t[1])
end
function preview:Update()
	if not self.built or not addon.config.panels.options or not addon.config.panels.options:IsVisible() then return nil end
	self:UpdateAppearance()
	local max_width, max_quality, max = 0, 0, math.max
	for i, t in ipairs(preview_loot) do
		local id, quantity, locked, quest = unpack(t)
		local name, link, quality, _, _, _, _, _, _, icon = GetItemInfo(id)
		if name then -- Skip invalid items
			local row = self.rows[i]
			self.slots[i] = row
			
			local width = row:Update(true, icon, name, link, quantity or 1, quality, locked, nil, quest)
			max_width = max(width, max_width)
			max_quality = max(quality, max_quality)
		end
	end
	self:SizeAndColor(max_width, max_quality)
	self:Show()
end


local function cache(key, value, initial)
	if key == 'skin' then
		preview.skin = skins[value]
	end
	preview.opt[key] = value
	if not initial then
		preview:Update()
	end
end

-- Configuration callbacks
function addon:ConfigSet(key, value)
	local default = defaults[key]
	-- Force boolean
	if type(default) == 'boolean' then
		value = value and true or false
	end
	-- Update
	opt[key] = value
end

function addon:ConfigGet(key, initial)
	local v = opt[key]
	if key == 'skin' and not skins[v] then
		v = 'smooth'
	end
	cache(key, v, initial)
	return v
end

function addon:ConfigSave()
	frame.skin = skins[opt.skin]
	if frame.built then
		XLootFrame:UpdateAppearance()
	end
	PluginTrigger('SkinUpdate')
end

function addon:ConfigDefault()
	wipe(opt)
end

-- Set up preview frame
function addon:ConfigBuilt()
	local f = preview
	f:SetParent(self.config.panels.options)
	f:SetPoint('LEFT', self.config.panels.options, 'RIGHT')
	BuildFrame(f)
	f:Show()
end

-- function addon:ConfigPanelShow(panel)
	-- preview:Update()
-- end

function addon:ConfigPanelRefresh(panel)
	preview:Update()
end

function addon:OnOptionModified(key, value)
	cache(key, value)
end

local function option_handler(msg)
	if not addon:SlashHandler(msg) then
		addon:ShowOptions()
	end
	--local what, arg, data = string.split(' ', msg, 3)
	--local what, arg, data = msg:match'^(%w+)%s?([A-Za-z\_]*)%s?(.*)$'
end
SLASH_XLOOT1 = '/xloot'
SlashCmdList['XLOOT'] = option_handler
