Broker_XPTracker = LibStub( "AceAddon-3.0"):NewAddon( "Broker_XPTracker", "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("Broker_XPTracker")
local LSM = LibStub("LibSharedMedia-3.0")
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local LibQTip = LibStub("LibQTip-1.0")

local LDB_ANCHOR, tooltip, nameColumn, levelColumn, xpColumn, restColumn, xpphColumn, partyList, guiltList, dataobj
local MAJOR_VERSION = "1.1"
local frame = CreateFrame("frame")
local counter = 0

local timeCharCreation = 0
local timeCurrentLevel = 0
local timeSession  = time()

local xpLastGain      = 0        -- last xp gain
local xpLevelInitial  = nil      -- xp in current level at session start
local xpLevelCurrent  = 0        -- current xp
local xpSession       = 0        -- total xp earned this session
local xpAccumulated   = 0        -- xp earned this session before current level
local inited 			 = false
local garbageCollectedTime = time()
local levelupList		 = {}
local currentLevelup	 = nil

local string_format = string.format
                
local options = {
	name = "Broker_XPTracker",
	handler = Broker_XPTracker,
	type = "group",
	childGroups = "tab",
	get = "getValue",
	set = "setValue",
	args = {
		LDB = {
			name = L["LDB Text"],
			type = "group",
			order = 1,
			args = {
				showRemainingXP = {
					name = L["Remaining XP"],
					desc = L["if checked the remaining XP for this level is shown in LDB text"],
					type = "toggle",
					width = "full",
					order = 1,
				},
				showRestBonus = {
					name = L["Rest bonus"],
					desc = L["if checked the rest bonus is shown if there is any"],
					type = "toggle",
					width = "full",
					order = 2,
				},
				showXPph = {
					name = L["XP per Hour"],
					desc = L["if checked the XP per hour rate is shown"],
					type = "toggle",
					width = "full",
					order = 3,
				},
				showEtl = {
					name = L["Expected time to level up"],
					desc = L["if checked the expected time to level based on session is shown"],
					type = "toggle",
					width = "full",
					order = 4,
				},
			},
		},
		Sync = {
			name = L["Sync"],
			type = "group",
			order = 2,
			args ={
				showPartyProgress = {
					name = L["Show Party Progress"],
					type = "toggle",
					width = "full",
					order = 1,
				},
				showGuildProgress  = {
					name = L["Show Guild Progress"],
					type = "toggle",
					width = "full",
					order = 2,
				},
				sendToGuild  = {
					name = L["Send to guild"],
					type = "toggle",
					width = "full",
				},
				sendToParty  = {
					name = L["Send to party"],
					type = "toggle",
					width = "full",
					order = 3,
				},
				expiration = {
					name = L["List Fadeout"],
					type = "range",
					min = 5,
					max = 60,
					step = 1,
					width = "full",
					order = 4,
				},
				notifyLevelUp = {
					name = L["Notify on level up"],
					desc = L["notifies if someone has a level up"],
					type = "toggle",
					width = "full",
					order = 5,
				},
				dingSound = {
					name = L["Levelup Notify Sound"],
					type = "select",
					dialogControl = 'LSM30_Sound',
					values = LSM:HashTable("sound"),
					order = 6,
					width = "full",
				},
				levelupExpiration = {
					name = L["Levelup Fadeout"],
					type = "range",
					min = 5,
					max = 600,
					step = 1,
					width = "full",
					order = 7,
				},  
			},
		},
	}
}

local defaults = {
	profile = {
		showPartyProgress	= true,
		showGuildProgress = true,
		showRemainingXP	= true,
		showRestBonus		= true,
		showXPph				= true,
		showEtl				= true,
		sendToGuild			= true,
		sendToParty			= true,
		expiration			= 15,
		notifyLevelUp		= true,
		levelupExpiration	= 60,
		dingSound			= "None",
	}
}

function Broker_XPTracker:getValue(info)
	return self.db.profile[info[#info]]
end

function Broker_XPTracker:setValue(info,value)
	self.db.profile[info[#info]] = value
end

function Broker_XPTracker:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("Broker_XPTrackerDB", defaults, "Default")
	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
	
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Broker_XPTracker", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Broker_XPTracker","Broker_XPTracker")
	
	self.dataobj = ldb:NewDataObject( "Broker_XPTracker", {
			type = "data source",
			icon = [[Interface\Icons\INV_Misc_Book_02]],
			text = "XPT",
			OnClick = function( clickedframe, button)
				if IsShiftKeyDown() then
					if button == "LeftButton" then
--						Broker_XPTracker:SendUpdate(true)
					end
				else
					if button == "RightButton" then
						InterfaceOptionsFrame_OpenToCategory( Broker_XPTracker.optionsFrame)
					elseif button =="LeftButton" and currentLevelup ~= nil then
						Broker_XPTracker:shiftLevelUpList()
						Broker_XPTracker:UpdateText()
					end
				end
			end,
			OnEnter = function(tt)
				local tooltip
				local new = false
				if LibQTip:IsAcquired("Broker_XPTrackerTooltip") then
					tooltip = Broker_XPTracker.tooltip
					tooltip:Clear()
				else
            	tooltip = LibQTip:Acquire("Broker_XPTrackerTooltip")
					new = true
				end 
            Broker_XPTracker.tooltip = tooltip
            Broker_XPTracker:PrepareTooltip(tooltip, new) 
				tooltip:SetAutoHideDelay( 0.5, tt)
            tooltip:SmartAnchorTo(tt)
				tooltip:UpdateScrolling() 
            tooltip:Show()
			end,
			OnLeave = function(tt)
			end,
		}
	)
	self.partyList = {}
	self.guildList = {}
	self:RegisterComm( "Broker_XPTracker", "OnCommReceive")
	inited = true
end

function Broker_XPTracker:shiftLevelUpList()
	currentLevelup = tremove(levelupList,1)
	if currentLevelup ~= nil and currentLevelup.expire < time() then
		self:shiftLevelUpList()
	end
end

function Broker_XPTracker:OnEnable()
	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("TIME_PLAYED_MSG")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	frame:SetScript("OnUpdate", self.OnUpdate)
	
	RequestTimePlayed()
	self:ResetSession()
	self:UpdateText()
end

function Broker_XPTracker:formatTime( seconds)
	return SecondsToTime(seconds, false, false, 4)
end

function Broker_XPTracker:addOwnStatusLine( tooltip, label, value)
	local line = tooltip:AddLine()
	tooltip:SetCell( line, nameColumn, self:RGBtoText( 0.9, 0.9, 0, 1) .. label, 3)
	tooltip:SetCell( line, restColumn, value, 2)
end

function Broker_XPTracker:PrepareTooltip(tooltip, new)
	if not LibQTip:IsAcquired("Broker_XPTrackerTooltip") then
		return
	end
	local timeAbsTotal = time() - timeCharCreation
	local timeAbsLevel = time() - timeCurrentLevel
	local timeAbsSession = time() - timeSession
	local xpLevelMax = UnitXPMax("player")
	local xpLevelLeft = xpLevelMax - xpLevelCurrent
	local xpRested = GetXPExhaustion() or 0
	local xpphLevel = xpLevelCurrent / timeAbsLevel * 3600
	
	if new then
		nameColumn	= tooltip:AddColumn("LEFT")
		levelColumn	= tooltip:AddColumn("CENTER")
		xpColumn		= tooltip:AddColumn("RIGHT")
		restColumn	= tooltip:AddColumn("RIGHT")
		xpphColumn	= tooltip:AddColumn("RIGHT")
	end
	

	self:addOwnStatusLine( tooltip, L["Total time played:"], self:formatTime(timeAbsTotal))
	self:addOwnStatusLine( tooltip, L["Time on this level:"], self:formatTime(timeAbsLevel))
	self:addOwnStatusLine( tooltip, L["Time this session:"], self:formatTime(timeAbsSession))
	tooltip:AddLine(" ")
	self:addOwnStatusLine( tooltip, L["XP Status:"], xpLevelCurrent .. " / " .. xpLevelMax)
	self:addOwnStatusLine( tooltip, L["Rest XP:"], string_format("%d (%.1f%%)", xpRested, xpRested / xpLevelMax * 100))
	tooltip:AddLine(" ")
	self:addOwnStatusLine( tooltip, L["XP/hour this level:"], string_format("%.1f", xpphLevel))
	self:addOwnStatusLine( tooltip, L["XP/hour this session:"], self:getXPSessionperHour( timeAbsSession))
	tooltip:AddLine(" ")
	self:addOwnStatusLine( tooltip, L["Time to level for this level:"], xpLevelCurrent > 0 and self:formatTime(xpLevelLeft * timeAbsLevel / xpLevelCurrent) or "inf.")
	self:addOwnStatusLine( tooltip, L["Time to level for this session:"], self:getTimeToLevel())
	tooltip:AddLine(" "," "," "," "," ")
	
	if self.db.profile.showPartyProgress and GetNumPartyMembers()>0 then
		local line = tooltip:AddLine()
		tooltip:SetCell( line, nameColumn, self:RGBtoText( 0.5, 0.5, 1, 1) .. L["Party"], 5)
		line = tooltip:AddLine(
			self:RGBtoText( 1, 1, 0, 1) .. L["Character"],
			self:RGBtoText( 1, 1, 0, 1) .. L["Lvl"],
			self:RGBtoText( 1, 1, 0, 1) .. L["XP-Status"],
			self:RGBtoText( 1, 1, 0, 1) .. L["Rest bonus"],
			self:RGBtoText( 1, 1, 0, 1) .. L["XP/h"]
		)
		for name, data in pairs( self.partyList) do
			if data ~= nil then
				local line = tooltip:AddLine()
				tooltip:SetCell( line, nameColumn, self:getClasscolor( data.class) .. name)
				tooltip:SetCell( line, levelColumn, data.level)
				tooltip:SetCell( line, xpColumn, self:RGBtoText( 0.5, 1, 0.5, 1) .. data.xp)
				tooltip:SetCell( line, restColumn, self:RGBtoText( 0.6, 0.6, 1, 1) .. data.rest)
				tooltip:SetCell( line, xpphColumn, data.xpph)
			end
		end
		tooltip:AddLine(" ")
	end
	
	if self.db.profile.showGuildProgress and IsInGuild() then
		local line = tooltip:AddLine()
		tooltip:SetCell( line, nameColumn, self:RGBtoText( 0.2, 1, 0.2, 1) .. L["Guild"], 5)
		line = tooltip:AddLine(
			self:RGBtoText( 1, 1, 0, 1) .. L["Character"],
			self:RGBtoText( 1, 1, 0, 1) .. L["Lvl"],
			self:RGBtoText( 1, 1, 0, 1) .. L["XP-Status"],
			self:RGBtoText( 1, 1, 0, 1) .. L["Rest bonus"],
			self:RGBtoText( 1, 1, 0, 1) .. L["XP/h"]
		)
		for name, data in pairs( self.guildList) do
			if data ~= nil then
				local line = tooltip:AddLine()
				tooltip:SetCell( line, nameColumn, self:getClasscolor( data.class) .. name)
				tooltip:SetCell( line, levelColumn, data.level)
				tooltip:SetCell( line, xpColumn, self:RGBtoText( 0.5, 1, 0.5, 1) .. data.xp)
				tooltip:SetCell( line, restColumn, self:RGBtoText( 0.6, 0.6, 1, 1) .. data.rest)
				tooltip:SetCell( line, xpphColumn, data.xpph)
			end
		end
		tooltip:AddLine(" ")
	end
end

function Broker_XPTracker:getClasscolor( class)
	local c = RAID_CLASS_COLORS[class]
	if (c) then
		c = format("|c00%02X%02X%02X", 255 * c.r, 255 * c.g, 255 * c.b)
	else
		c = "|c00808080"
	end
	return c
end

function Broker_XPTracker:getXPSessionperHour( timeAbsSession)
	local xpphSession = 0
	if xpSession > 0 then
		xpphSession = xpSession / timeAbsSession * 3600
	end
	return string_format("%.1f", xpphSession) 
end

function Broker_XPTracker:getTimeToLevel()
	local xpLevelMax = UnitXPMax("player")
	local xpLevelLeft = xpLevelMax - xpLevelCurrent
	local timeAbsSession = time() - timeSession
	return xpSession > 0 and self:formatTime(xpLevelLeft * timeAbsSession / xpSession) or "inf."
end

function Broker_XPTracker:UpdateText()
	if not inited then return end
	local status = ""
	if currentLevelup ~= nil then
		 status = L["Ding! Name has leveled to Level time ago"]( currentLevelup.name, self:getClasscolor( currentLevelup.class), currentLevelup.level, self:formatTime( time() - currentLevelup.timeLevelUp))
	elseif IsXPUserDisabled() then
		if self.db.profile.showRemainingXP then
			status = self:RGBtoText( 0.6, 0.6, 0, 1) .. L["RemXP: "] .. L["leveling disabled"]
		end
	elseif UnitLevel("player") == MAX_PLAYER_LEVEL then
		if self.db.profile.showRemainingXP then
			status = self:RGBtoText( 0.6, 0.6, 0, 1) .. L["RemXP: "] .. L["maxLevel reached"]
		end
	else
		local xpLevelMax = UnitXPMax("player")
		local xpLevelLeft = xpLevelMax - xpLevelCurrent
		local xpRested = GetXPExhaustion() or 0
		local timeAbsSession = time() - timeSession
		
		if self.db.profile.showRemainingXP then
			status = status .. self:RGBtoText( 0.6, 0.6, 0, 1) .. L["RemXP: "] .. self:RGBtoText( 1, 1, 1, 1) .. xpLevelLeft .. " " 
		end
		if self.db.profile.showRestBonus and xpRested>0 then
			status = status .. self:RGBtoText( 0.6, 0.6, 0, 1) .. L["Rest: "] ..  self:RGBtoText( 0.4, 0.4, 1, 1) .. string_format("%d (%.1f%%)", xpRested, xpRested / xpLevelMax * 100) .. " "
		end
		if self.db.profile.showXPph then
			status = status .. self:RGBtoText( 0.6, 0.6, 0, 1) .. L["XP/h: "] .. self:RGBtoText( 1, 1, 0, 1) .. self:getXPSessionperHour( timeAbsSession) .. " "
		end
		if self.db.profile.showEtl then
			status = status .. self:RGBtoText( 0.6, 0.6, 0, 1) .. L["Etl: "] .. self:RGBtoText( 1, 1, 0, 1) .. self:getTimeToLevel() .. " "
		end
	end
	Broker_XPTracker.dataobj.text = status
end

function Broker_XPTracker:RefreshConfig()
	self:UpdateText()
	self:PrepareTooltip( LDB_ANCHOR, false)
end

function Broker_XPTracker:OnUpdate( elapsed)
	counter = counter + elapsed
	if counter > 1 then
		if currentLevelup ~= nil and currentLevelup.expire < time() then
			Broker_XPTracker:shiftLevelUpList()	
		end
		Broker_XPTracker:UpdateText()
		counter = 0
	end
	if garbageCollectedTime + 60 < time() then
		Broker_XPTracker:garbageCollect()
		garbageCollectedTime = time()
	end 
end

function Broker_XPTracker:garbageCollect()
	local i = 0
	for name, data in pairs( self.guildList) do
		if data ~= nil then
			if data.expire < time() then
				self.guildList[name] = nil
			else
				i = i + 1 
			end
		end 
	end
	if i == 0 then
		wipe( self.guildList)
	end
end  

function Broker_XPTracker:PLAYER_LEVEL_UP()
	xpAccumulated = xpAccumulated + UnitXPMax("player") - xpLevelInitial
	xpLevelInitial = 0
	timeCurrentLevel = time()
	self:UpdateText()
	self:PrepareTooltip( LDB_ANCHOR, false)
	if UnitLevel("player") == MAX_PLAYER_LEVEL then
		self:SendRemove()
	else
		self:SendUpdate(true)
	end
end

function Broker_XPTracker:PLAYER_XP_UPDATE()
	local xpNew = UnitXP("player")
	xpLastGain = math.max(0, xpNew - xpLevelCurrent)
	xpLevelCurrent = xpNew
	xpSession = xpLevelCurrent - xpLevelInitial + xpAccumulated
	self:UpdateText()
	self:PrepareTooltip( LDB_ANCHOR, false)
	self:SendUpdate(false)
end

function Broker_XPTracker:TIME_PLAYED_MSG(event, arg1, arg2)
	timeCharCreation = time() - arg1
	timeCurrentLevel = time() - arg2
	self:SendUpdate(false)
end

function Broker_XPTracker:ResetSession()
	timeSession  = time()
	xpLastGain = 0
	xpLevelInitial = UnitXP("player")
	xpLevelCurrent = xpLevelInitial
	xpSession = 0
	xpAccumulated = 0
end

function Broker_XPTracker:RGBtoText(iRed, iGreen, iBlue, iAlpha)
	local strColour;
	iAlpha = floor(iAlpha * 255);
	iRed = floor(iRed * 255);
	iGreen = floor(iGreen * 255);
	iBlue = floor(iBlue * 255);
	strColour = format("|c%2x%2x%2x%2x", iAlpha, iRed, iGreen, iBlue);
	return strColour;
end

function Broker_XPTracker:PARTY_MEMBERS_CHANGED()
	if GetNumPartyMembers() == 0 then
		wipe( self.partyList)
	elseif self.db.profile.sendToParty then
		self:SendCommMessage( "Broker_XPTracker", self:getMessage("UPDATE",false), "PARTY")
	end
end

function Broker_XPTracker:getMessage( msgType, isLevelUp)
	local xpRested = GetXPExhaustion() or 0
	local timeAbsSession = time() - timeSession
	local stringLevelUp = "false"
	local xpLevelMax = UnitXPMax("player")
	local level = UnitLevel("player")

	if isLevelUp then
		stringLevelUp = "true"
		level = level + 1
	end
	local localizedclass, englishclass = UnitClass("player")
	
	return	string_format( "%s:%s:%s:%s:%d:%s:%s:%s:%s",
		MAJOR_VERSION,
		UnitName( "player"),
		englishclass,
		msgType,
		level,
		xpLevelCurrent .. " / " .. xpLevelMax,
		string_format("%d (%.1f%%)", xpRested, xpRested / xpLevelMax * 100),
		self:getXPSessionperHour( timeAbsSession),
		stringLevelUp
	)
end

function Broker_XPTracker:SendUpdate( isLevelUp)
	if UnitLevel("player") ~= MAX_PLAYER_LEVEL then
		local msg = self:getMessage( "UPDATE", isLevelUp)
		if IsInGuild() and self.db.profile.sendToGuild then
			self:SendCommMessage( "Broker_XPTracker", msg, "GUILD")
		end
		if GetNumPartyMembers()>0 and self.db.profile.sendToParty then
			self:SendCommMessage( "Broker_XPTracker", msg, "PARTY")
		end
--		self:OnCommReceive( "Broker_XPTracker", msg, "PARTY", UnitName("player"))
	end
end

function Broker_XPTracker:SendRemove()
	local localizedclass, englishclass = UnitClass("player")
	local msg = self:getMessage( "LOGOUT", isLevelUp)
	if IsInGuild() then
		self:SendCommMessage( "Broker_XPTracker", msg, "GUILD")
	end
	if GetNumPartyMembers()>0 then
		self:SendCommMessage( "Broker_XPTracker", msg, "PARTY")
	end
end
         
function Broker_XPTracker:OnCommReceive( prefix, msg, how, who)
--	self:Print( msg)
	if who == UnitName( "player") then return end
	local version, name, class, cmd, lvl, xp, rest, xpph, isLevelUp = strsplit(":",msg)
	if version ~= MAJOR_VERSION then return end
	
	if cmd == "LOGOUT" then
		if how == "PARTY" then
			self.partyList[name] = nil
		elseif how == "GUILD" then
			self.guildList[name] = nil
		end
	end
	
	if cmd == "UPDATE" then
		if how == "PARTY" then
			self.partyList[name] = {
				class = class,
				level	= lvl,
				xp = xp,
				rest = rest,
				xpph = xpph,
				expire = time() + self.db.profile.expiration * 60,
			}
		elseif how == "GUILD" then
			self.guildList[name] = {
				class = class,
				level	= lvl,
				xp = xp,
				rest = rest,
				xpph = xpph,
				expire = time() + self.db.profile.expiration * 60, 
			}
		end
	end
	if isLevelUp == "true" and self.db.profile.notifyLevelUp then
		tinsert( levelupList, {
			name = name,
			class = class,
			level = lvl,
			timeLevelUp = time(),
			expire = time() + self.db.profile.levelupExpiration
		})
		PlaySoundFile( LSM:Fetch( "sound", self.db.profile.dingSound))
		if currentLevelup == nil then
			self:shiftLevelUpList()
			self:UpdateText()
		end 
	end
end
