local L = LibStub("AceLocale-3.0"):GetLocale("Broker_MailBox")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDB = LibStub("AceDB-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local LibQTip = LibStub("LibQTip-1.0")
MailBox = LibStub("AceAddon-3.0"):NewAddon("Broker_MailBox", "AceEvent-3.0", "AceHook-3.0")
local MailBox = MailBox
MailBox.L = L
MailBox.addonPath = "Interface\\Addons\\Broker_MailBox"

local fontLine = CreateFont("Broker_MailBoxFontLine")
local fontWhite = CreateFont("Broker_MailBoxFontWhite")

local GetInboxNumItems = GetInboxNumItems
local GetLatestThreeSenders = GetLatestThreeSenders
local GetTime = GetTime
local gsub = string.gsub
local HasNewMail = HasNewMail
local ipairs = ipairs
local pairs = pairs
local PlaySoundFile = PlaySoundFile
local strfind = string.find
local strformat = string.format
local tinsert = table.insert

local zoneevent
local lastclose
local closedelay = 5
local ignorenext = false
local pendmail
local checked
local files = {
	iconnomail = MailBox.addonPath.."\\nomail.tga",
	iconnew = MailBox.addonPath.."\\newmail.tga",
	soundpath = MailBox.addonPath.."\\mail.mp3",
}

local defaults = {
	profile = {
		playsounds = true,
		showminimap = false,
		chatalerts = true,
		textformat = "both",
		showtext = true,
		showcount = true,
	},
	char = {
		new = 0,
		total = 0,
	}
}

local opts = {
	type = "group",
	name = "Broker_MailBox",
	handler = Broker_MailBox,
	args = {
		general = {
			order = 1,
			type = "group",
			name = "General Settings",
			cmdInline = true,
			args = {
				["minimap"] = {
					type = "toggle", name = "Default Minimap", desc = "Show Blizzard's minimap icon. Requires ReloadUI.", order = 1, -- Locale
					get = function() return MailBox.db.profile.showminimap end, set = function(k, v) MailBox.db.profile.showminimap = v MailBox:MMMailShow(MiniMapMailFrame) end,
				},
				["sound"] = {
					type = "toggle", name = "Use Sound", desc = "Play a sound when mail is received.", order = 2, -- Locale
					get = function() return MailBox.db.profile.playsounds end, set = function(k, v) MailBox.db.profile.playsounds = v end,
				},
				["chat"] = {
					type = "toggle", name = "Chat Alert", desc = "Print a chat message when mail is received.", order = 3, -- Locale
					get = function() return MailBox.db.profile.chatalerts end, set = function(k, v) MailBox.db.profile.chatalerts = v end,
				},
				["textformat"] = {
					type = "select",
					style = "dropdown",
					name = "Text Format", -- Locale
					desc = "Bar text formatting.", -- Locale
					order = 4,
					get = function() return MailBox.db.profile.textformat end,
					set = function(k, v) MailBox.db.profile.textformat = v; MailBox:Update() end,
					values = function()
							return {
								["text"] = "text",
								["number"] = "number",
								["both"] = "both",
							} -- Locale
						end,
				},
			}
		}
	}
}

-- ACE Methods
function MailBox:OnInitialize()
	pendmail = 0
	self.db = AceDB:New("Broker_MailBoxDB", defaults, "Default")
	self:SetupOptions()

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("MAIL_CLOSED")
	self:RegisterEvent("UPDATE_PENDING_MAIL")
	self:RegisterEvent("CHAT_MSG_SYSTEM")

	self:RegisterEvent("MAIL_SHOW")
	self:RegisterEvent("MAIL_INBOX_UPDATE")
	self:Hook(MiniMapMailFrame, "Show", "MMMailShow", true)
	if not self.db.profile.showminimap and MiniMapMailFrame:IsVisible() then MiniMapMailFrame:Hide() end
end

-- Embedding LibSpecialEvents-2.0
function MailBox:PLAYER_ENTERING_WORLD()
	zoneevent = true
end

function MailBox:MAIL_CLOSED()
	lastclose = GetTime()
end

function MailBox:SetupOptions()
	opts.args.profile = AceDBOptions:GetOptionsTable(self.db)
	opts.args.profile.order = -2

	AceConfig:RegisterOptionsTable("Broker_MailBox", opts)

	self.optionsFrames = {}
	self.optionsFrames.general = AceConfigDialog:AddToBlizOptions("Broker_MailBox", nil, nil, "general")
	self.optionsFrames.profile = AceConfigDialog:AddToBlizOptions("Broker_MailBox", "Profiles", "Broker_MailBox", "profile")
end

function MailBox:MMMailShow(object)
	if self.db.profile.showminimap then return self.hooks[object].Show(object) end
end

function MailBox:UPDATE_PENDING_MAIL()
	if lastclose and (lastclose + closedelay) > GetTime() then ignorenext = true end

	if zoneevent then
		zoneevent = false
		self:Update()
		return
	end

	if ignorenext then
		ignorenext = false
		return
	end

	self:Mail_Received()
end

-- Events that don't fire UPDATE_PENDING_MAIL like they should
local brokenevents = {
	[ERR_AUCTION_WON_S]		= false,
	[ERR_AUCTION_SOLD_S]	= false,
	[ERR_AUCTION_OUTBID_S]	= true,
	[ERR_AUCTION_EXPIRED_S]	= false,
	[ERR_AUCTION_REMOVED_S]	= false,
}
local eventnames = {
	[ERR_AUCTION_WON_S]		= "WON",
	[ERR_AUCTION_SOLD_S]	= "SOLD",
	[ERR_AUCTION_OUTBID_S]	= "OUTBID",
	[ERR_AUCTION_EXPIRED_S]	= "EXPIRED",
	[ERR_AUCTION_REMOVED_S]	= "REMOVED",
}
local aucstr = {}

if GetLocale() == "zhTW" then
	for i in pairs(brokenevents) do aucstr[i] = gsub(i, "%%s", "(.+)") end
else
	for i in pairs(brokenevents) do aucstr[i] = gsub(i, "%%[^%s]+", "(.+)") end
end

function MailBox:CHAT_MSG_SYSTEM(msg)
	if not msg then return end

	for i, searchstr in pairs(aucstr) do
		local _, _, item = strfind(msg, searchstr)
		if item then
			if brokenevents[i] then
				self:Mail_Received()
				return
			end
		end
	end
end
-- End Embed

function MailBox:MAIL_SHOW()
	checked = true
	self:Update()
end

function MailBox:MAIL_INBOX_UPDATE()
	self.db.char.new = 0
	self.db.char.total = GetInboxNumItems()
	self:Update()
end

function MailBox:Mail_Received()
	if not messagenum then messagenum = 1 end
	if messagenum < 2 then
		pendmail = pendmail + 1
		self.db.char.new, self.db.char.total = self.db.char.new + 1, self.db.char.total + 1
		if checked then self.db.char.total = GetInboxNumItems() + self.db.char.new end
		if self.db.profile.playsounds then PlaySoundFile(files.soundpath) end
		if self.db.profile.chatalerts then print(strformat(L["New Mail Received (%d/%d)"], self.db.char.new, self.db.char.total)) end

		self:Update()
		messagenum = messagenum + 1
	else 
		messagenum = 1 
	end
end

-- Creating LDB plugin.
MailBox.plugin = LibStub("LibDataBroker-1.1"):NewDataObject("Broker_MailBox", {
						type = "data source",
						icon = files.iconnomail,
						label = "MailBox",
						text = "Initializing...",
						OnEnter = function(button) MailBox:OnEnter(button) end,
						OnLeave = function(button) MailBox:OnLeave(button) end,
						OnClick = function(frame, msg) if msg == "RightButton" then MailBox:ShowConfig() end end,
						})

function MailBox:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.profile)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.general)
end

function MailBox:Update()
	local showt = self.db.profile.textformat == "both" or self.db.profile.textformat == "text"
	local showc = self.db.profile.textformat == "both" or self.db.profile.textformat == "number"
	local hasmail = self.db.char.total > 0 or (HasNewMail() and not checked)
	local numstr = (self.db.char.total > 0) and strformat(showt and "(%u/%u)" or "%u/%u", self.db.char.new, self.db.char.total) or showt and "(0)" or "0"
	local colorstr = hasmail and "|cff00ff00" or ""
	local txtstr = hasmail and L["New Mail"] or L["No Mail"]

	MailBox.plugin.text = (colorstr .. (showt and txtstr or "") .. (showt and showc and " " or "") .. (showc and numstr or ""))
	MailBox.plugin.icon = hasmail and files.iconnew or files.iconnomail
end

function MailBox:OnEnter(button)
	local tooltip = LibQTip:Acquire("Broker_MailBoxTooltip", 2, "LEFT", "RIGHT")
	self.tooltip = tooltip

	MailBox:ShowTooltip(button)
end

function MailBox:OnLeave(button)
	LibQTip:Release(self.tooltip)
	self.tooltip = nil
end

function MailBox:ShowTooltip(button)
	local hasmail = self.db.char.total > 0 or (HasNewMail() and not checked)
	local colorstr = hasmail and "|cff00ff00" or ""
	local txtstr = hasmail and L["New Mail"] or L["No Mail"]

	local tooltip = LibQTip:Acquire("Broker_MailBoxTooltip", 2, "LEFT", "RIGHT")
	self.tooltip = tooltip

	local fontName, fontHeight, fontFlags = tooltip.headerFont:GetFont()
	fontLine:SetFont(fontName, fontHeight, fontFlags)
	fontLine:SetTextColor(1, 1, 0.5)
	fontLine:SetJustifyH("LEFT")
	fontLine:SetJustifyV("MIDDLE")

	fontName, fontHeight, fontFlags = tooltip.regularFont:GetFont()
	fontWhite:SetFont(fontName, fontHeight, fontFlags)
	fontWhite:SetTextColor(1, 1, 1)
	fontWhite:SetJustifyH("RIGHT")
	fontWhite:SetJustifyV("MIDDLE")

	tooltip:AddHeader(colorstr..txtstr)
	tooltip:SetFont(fontLine)

	tooltip:AddLine(L["New"])
	tooltip:SetCell(2, 2, self.db.char.new or "No data", fontWhite)
	tooltip:AddLine(L["Total"])
	tooltip:SetCell(3, 2, self.db.char.total, fontWhite)

	if hasmail then
		local s1, s2, s3 = GetLatestThreeSenders()
		tooltip:AddSeparator()
		if s1 or s2 or s3 then
			tooltip:AddLine(HAVE_MAIL_FROM)

			if s1 then tooltip:AddLine(s1) end
			if s2 then tooltip:AddLine(s2) end
			if s3 then tooltip:AddLine(s3) end
		else
			tooltip:AddLine(HAVE_MAIL)
		end
	end

	if _G.TipTac and _G.TipTac.AddModifiedTip then
		-- Pass true as second parameter because hooking OnHide causes C stack overflows
		_G.TipTac:AddModifiedTip(tooltip, true)
	end
	tooltip:SmartAnchorTo(button)
	tooltip:Show()
end
