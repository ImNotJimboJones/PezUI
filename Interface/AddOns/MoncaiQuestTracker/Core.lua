--------------------------------------------------------------------------------------------------------
-- Moncaí's Quest Tracker
-- Author: Moncaí
-- Copyright (C) 2006-2010 moncai AT mgtx DOT net, all rights reserved.
-- Date: $Date: 2012-09-04 10:05:34 +0000 (Tue, 04 Sep 2012) $, $Rev: 54 $
--------------------------------------------------------------------------------------------------------
local MQT = LibStub("AceAddon-3.0"):NewAddon("MoncaiQuestTracker", "AceConsole-3.0");
_G["MQT"] = MQT;
local L = LibStub("AceLocale-3.0"):GetLocale("MoncaiQuestTracker", false);
--------------------------------------------------------------------------------------------------------
--
-- constants
-- 
--------------------------------------------------------------------------------------------------------

-- This is specific code that doesn't belong in the core at all...
MQT.WATCHFRAME_MINIMUMWIDTH = 220;
MQT.WATCHFRAME_QUEST_OFFSET = 5;
MQT.WATCHFRAME_QUEST_WITH_ITEM_HEIGHT = WATCHFRAME_LINEHEIGHT * 2;
-- si sihT

MQT.MAX_PARTY = 5

MQT.LEVEL_FORMAT = L["[%d] %s"];
MQT.MSG_C = { r = 1, g = 1, b = 0.8 }

MQT.MSG_PREFIX = "MQTm";
MQT.QST_PREFIX = "MQTq";
MQT.CMD_PREFIX = "MQTu";
MQT.LRG_PREFIX = "MQT$";
MQT.NFO_PREFIX = "MQT!";

MQT.CMD_UPDATE = "!";
MQT.CMD_BULK = "b";
MQT.CMD_PULL = "^";

MQT.MATCH3 = L["(.*): (%d+) ?/ ?(%d+)"]
MQT.MATCH1 = L[".*: (%d+) ?/ ?%d+"]
MQT.MATCHa = L["(.*): %d+ ?/ ?%d+"]

MQT.MATCHLEADERBOARD1 = " ?(%d+) ?/ ?%d+ ?.*" -- need to localize?
MQT.MATCHLEADERBOARD2 = " ?(%d+) ?/ ?(%d+) ?.*" -- need to localize?
MQT.MATCHLEADERBOARD3 = " ?(%d+) ?/ ?(%d+) ?(.*)" -- need to localize?

local DESTINATION = "PARTY" -- "PARTY" / "RAID" / "GUILD"
--------------------------------------------------------------------------------------------------------
--
-- Library Function Imports
--
--------------------------------------------------------------------------------------------------------
local ML = LibStub("MoncaiLib");
local U = ML.util;

local RGBPercToHex = U.RGBPercToHex;
local RGBToHex = U.RGBToHex;
local wrap = U.wrap;
local unwrap = U.unwrap;

local ChatThrottleLib = ChatThrottleLib;

--------------------------------------------------------------------------------------------------------
--
-- VARIABLES
--
--------------------------------------------------------------------------------------------------------
local WatchFrame

-- Saved variable
MQTC = {
	QList = { },
	ColorTitle = 1,
	ColorStatus = 0,
	AutoAdd = 1,
	Enabled = 1,
	ShowLevel = 1,
	RemoveComplete = 0,
	OnHold = 0,
	LineMax = 30,
	Communicate = 1,
};

local MQTC = MQTC; --speedup

-- Working memory variable
MQT.workspace = {
	watches = -1,
	MaxLines = 35,
	Comms = {},
	hash = {},
};
local MQTW = MQT.workspace;

--------------------------------------------------------------------------------------------------------
--
-- Buddylist
--
--------------------------------------------------------------------------------------------------------

local BuddyList = {
	colors = {
		[1] = { r = 111, g = 111, b = 255 },
		[2] = { r = 111, g = 255, b = 111 },
		[3] = { r = 255, g = 111, b = 111 },
		[4] = { r = 255, g = 255, b = 111 },
		[5] = { r = 255, g = 40, b = 40 },		
		fmt = function(self, buddynr, nr)
			return string.format(" |cff%02x%02x%02x%d|r", self[buddynr].r, self[buddynr].g, self[buddynr].b, nr)
		end,
	},
	buddies = {},
	questlb = {},
	
	cleanup = function(self, bnr)
		-- remove all possibly old references to this buddy
		for title, quest in pairs(self.questlb) do
			for idx, lb in ipairs(quest) do
				lb[bnr] = nil
			end
		end
	end,
	
	removeBuddy = function(self, name)
		local i = self.buddies[name] or 0
		if i == 0 then return end
		self.buddies[name] = nil
		self.buddies[i] = nil
		
		-- remove all references to this buddy
		self:cleanup(i)

		if MQT.db.profile.verbosebuddy then Print(L["Goodbye, "] .. name) end
	end,

	addBuddy = function(self, name)
		for i = 1, MQT.MAX_PARTY, 1 do
			if not self.buddies[i] then
				self.buddies[i] = { ["name"] = name, questlog = {}, buffer = {}, watches = {} }
				self.buddies[name] = i
				if MQT.db.profile.verbosebuddy then Print(L["Welcome to the group, "] .. name .. "!") end
				return i
			end
		end
		if MQT.db.profile.verbosebuddy then Print(L["Could not add buddy, buffer full"]) end
		return false
	end,

	insertQuestPart = function(qtable, buddy, questID, level, lbidx, lbtext)	
		local quest = qtable[questID] or {}
		quest.level = level
		local lb = quest[lbidx] or {}
		lb.leaderboard = lbtext
		lb.nr = string.gmatch(lbtext, MQT.MATCH1)() or 0 --NEEDS REVIEW!!!! which format to check for??

		quest[lbidx] = lb
		qtable[questID] = quest
	end,
	
	receiveQuestPart = function(self, buddy, questID, level, lbidx, lbtext)
--~ 		Print(("receiveQuestPart %s %s %s %s %s"):format(buddy, questID, level, lbidx, lbtext), 1, 0, 1)
		
		local bnr = self.buddies[buddy] or self:addBuddy(buddy)
		if not bnr then
			if MQT.db.profile.verbosebuddy then Print(L["Could not add buddy, buffer full"]) end
			return
		end
		lbidx = 0 + lbidx
		questID = 0 + questID
		
		self.insertQuestPart(self.buddies[bnr].buffer, buddy, questID, level, lbidx, lbtext)
		
	end,

	updateBuddyWatch = function (self, buddynr, questID, lbidx, nr)
		-- Store into easy to access thingy
		local q = self.questlb[questID] or {}
		local lb = q[lbidx] or {}
		lb[buddynr] = self.colors:fmt(buddynr, nr)
		
		q[lbidx] = lb
		self.questlb[questID] = q
	end,
	
	getBuddyWatch = function(self, questID, lbidx)
		local q = self.questlb[questID] or {}
		local lb = q[lbidx] or {}
		local str = "";
		for i = 1, MQT.MAX_PARTY, 1 do
			if lb[i] then
				str = str .. lb[i]
			end
		end
--~ 		if MQT.db.profile.debug then Print(("getBuddyWatch(%s, %s) => '%s'"):format(questID or "nil", lbidx or -1, str or "-"), 1, 0, 0) end
		return str
	end,
	
	-- packet = wrap(questID, level, suggestedGroup, title, isComplete, isDaily)
	insertQuestInfo = function(qtable, buddy, questID, level, suggestedGroup, title, isComplete, isDaily)
		local quest = qtable[questID] or {}
		quest.level = level
		quest.suggestedGroup = suggestedGroup
		quest.title = title
		quest.isComplete = isComplete
		quest.isDaily = isDaily
		qtable[questID] = quest		
	end,
	
	receiveQuestInfo = function(self, buddy, questID, level, suggestedGroup, title, isComplete, isDaily)
		local bnr = self.buddies[buddy] or self:addBuddy(buddy)
		if not bnr then
			if MQT.db.profile.verbosebuddy then Print(L["Could not add buddy, buffer full"]) end
			return
		end
		questID = 0 + questID
		
		self.insertQuestInfo(self.buddies[bnr].buffer, buddy, questID, level, suggestedGroup, title, isComplete, isDaily)
	end,
	
	updateQuestPart = function(self, buddy, questID, level, lbidx, lbtext)
		local bnr = self.buddies[buddy] or self:addBuddy(buddy)
		if not bnr then
			if MQT.db.profile.verbosebuddy then Print(L["Could not add buddy, buffer full"]) end
			return
		end
		lbidx = 0 + lbidx
		questID = 0 + questID
		
		self.insertQuestPart(self.buddies[bnr].buffer, buddy, questID, level, lbidx, lbtext)
		self.insertQuestPart(self.buddies[bnr].questlog, buddy, questID, level, lbidx, lbtext)
		self:updateBuddyWatch( bnr, questID, lbidx, string.gmatch(lbtext, MQT.MATCH1)() )
	end,
	
	propagate = function(self, buddy)
		local bnr = self.buddies[buddy] or self:addBuddy(buddy)
		if not bnr then return end
		
		self.buddies[bnr].questlog = self.buddies[bnr].buffer
		self.buddies[bnr].buffer = {}
		
		
		self:cleanup(bnr)
		
		-- insert nice new ones
		for title, quest in pairs(self.buddies[bnr].questlog) do
			for idx, lb in ipairs(quest) do
				self:updateBuddyWatch(bnr, title, idx, lb.nr or 0)
			end
		end
	end,
	
	buddyCheck = function(self)
		local name
		local list = {}
		
		--Print("BuddyCheck!");
		-- get a list of all buddies
		for i = 1, MQT.MAX_PARTY, 1 do
			local name = UnitName("party" .. i)
			if name then
				list[name] = i
			end
		end

		-- remove buddies that are no longer around
		for i = 1, MQT.MAX_PARTY, 1 do
			if self.buddies[i] and not list[self.buddies[i].name] then
				self:removeBuddy(self.buddies[i].name)
			end
		end
		
		-- add new buddies
		for k,v in pairs(list) do
			if not self.buddies[k] then
				self:addBuddy(k)
			end
		end
	end,
}
MQT.BuddyList = BuddyList

-- Sample = {
-- 	["Person1"] = {
--		["Zalazane"] = {
--			level = 9,
--			[1] = {
--				leaderboard = "Zalazane's head: 0/1",
--				nr = 0,
--			}
--		}
--	}
--	["Person2"] = { },
--	["Person3"] = nil,
-- }

function MQT.Sense(destination)
	return (GetNumSubgroupMembers() > 0)
end

function MQT.SafeAddonMessage(mtype, prefix, message, destination)
	if MQT.Sense(destination) then
		ChatThrottleLib:SendAddonMessage(mtype, prefix, message, destination)
	end
end

function MQT.Communicate()
	if not MQT.Sense(DESTINATION) then 
		return
	end
	
	if MQT.db.profile.debug then Print("MQT-Communicating", 1,0,1) end
	
	local i = 1;
	local packet;
	-- title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, displayQuestID = GetQuestLogTitle(questIndex)
	local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, displayQuestID = GetQuestLogTitle(i)

	while (title ~= nil and questID ~= nil) do
		if (not isHeader) then
			-- Send detailed questinfo here like title, isdaily etc.
			packet = wrap(questID, level, suggestedGroup or "", title, isComplete or "", isDaily or "")
			MQT.SafeAddonMessage("BULK", MQT.NFO_PREFIX, packet, DESTINATION);

			for j = 1, GetNumQuestLeaderBoards(i), 1 do
				packet = wrap(questID, level, j, GetQuestLogLeaderBoard(j,i) or "")
				MQT.SafeAddonMessage("BULK", MQT.QST_PREFIX, packet, DESTINATION);
			end
		end
		i = i + 1;
		title, level, _, suggestedGroup, isHeader, _, isComplete, isDaily, questID, displayQuestID = GetQuestLogTitle(i)
	end
	MQT.SafeAddonMessage("BULK", MQT.QST_PREFIX, wrap(0,0,0,0, MQT.CMD_UPDATE), DESTINATION); 
end

local FREQ = 60
local SPDFREQ = 5;
local tick = 55
local speedup = false;

-- Speed up the notification
function MQT.Notify()
	speedup = true;
end

function MQT.Update(self, elapsed)
	-- if QuestHelper then MQT.QuestHelperUpdateTimer(elapsed); end;

	tick = tick + elapsed;
	if (tick >= FREQ or (speedup and tick >= SPDFREQ)) then
		--Print("Comm channel open...");
		tick = 0;
		speedup = false;
		if (GetNumSubgroupMembers() > 0 or MQT.db.profile.debug) then -- 0 DEBUG!!
			MQT.Communicate();
		end
	end
end

function MQT.Event(this, event, arg1, arg2, arg3, arg4, ...)
	local player = UnitName("player");
	local message = arg1;
	
	if ( event == "UI_INFO_MESSAGE" ) then
		local questUpdateText = gsub(message, "(.*): %d+ ?/ ?%d+","%1", 1);

		if ( questUpdateText ~= message) then
		
			--Print("UI Message looks like a quest objective");
			
			local title, level, idx, qid, nrentries, lbtext, lb, questID, _;
			questTitle = nil
			nrentries = GetNumQuestLogEntries()
			lbtext = string.gmatch(message, MQT.MATCHa)();
			
			for i=1, nrentries, 1 do
				for j = 1, GetNumQuestLeaderBoards(i), 1 do
					lb = string.gmatch( GetQuestLogLeaderBoard(j,i) or "", MQT.MATCHa)() -- BUG leaderboard can be nil
					--Print("~" .. (lbtext or "") .."~?=~" .. (lb or "") .. "~")
					if (lbtext == lb) then
						title, level, _, _, _, _, _, _, questID, _ = GetQuestLogTitle(i)
						idx = j;
						qid = i;
						break
					end
				end
				if (title) then break end
			end
			-- if we have title, ship it off :)
			if (title) then
				packet = wrap(questID, level, idx, message, MQT.CMD_UPDATE)

				-- go send
				MQT.SafeAddonMessage("ALERT", MQT.QST_PREFIX, packet, DESTINATION);
				-- ChatThrottleLib:SendAddonMessage("NORMAL", MQT_CMD_PREFIX, MQT_CMD_UPDATE, "RAID");

				-- autotrack
				--Print(string.format("Adding %d: %s", idx, questTitle));
				
				AddQuestWatch(qid, true, true);
				QuestLog_Update();
				WatchFrame_Update();
				
			else
				if MQT.db.profile.debug then Print("Title not found") end
			end
		
			local msg, n, m = string.gmatch(message, "(.*): ?(%d+) ?/ ?(%d+)")();

			if msg and n and m then
				local str;
				if m-n > 0 then
					str = string.format(L["needs %1$d more %2$s "], m-n, msg);
				else
					str = string.format(L["is finished with %s "], msg);
				end
				MQT.SafeAddonMessage("ALERT", MQT.MSG_PREFIX, str, DESTINATION);
				str = string.gsub(str, L["needs"], L["need"]);
				str = string.gsub(str, L["is finished"], L["are finished"]);
				if MQT.db.profile.verbosechat then Print(string.format("%s %s",L["You"],str)) end
			end
			
		else
			local messag = string.gsub(message, "Disco", "disco");
			MQT.SafeAddonMessage("ALERT", MQT.MSG_PREFIX, L["has "] .. messag, DESTINATION);
			Print(message);
		end

	elseif ( event == "QUEST_LOG_UPDATE" or event == "UPDATE_FACTION" or event == "UNIT_QUEST_LOG_CHANGED") then
		-- currently not registered
		MQT.Notify();
		
	elseif ( event == "VARIABLES_LOADED" ) then
		-- show splash banner here?
		
	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
		BuddyList:buddyCheck()
		MQT.Notify()
		
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		BuddyList:buddyCheck()
		if GetNumSubgroupMembers() > 1 then
			if MQT.db.profile.verbosebuddy then Print(L["Let's Party!"]) end
			MQT.Notify()
		end
		
	elseif ( event == "CHAT_MSG_ADDON" and (arg4 ~= player or MQT.db.profile.debug) ) then
		
		if arg1 == MQT.MSG_PREFIX then
			if MQT.db.profile.verbosechat then Print(string.format("%s %s", arg4, arg2), MQT.MSG_C.r, MQT.MSG_C.g, MQT.MSG_C.b) end
		elseif  arg1 == MQT.NFO_PREFIX then
			-- packet = wrap(questID, level, suggestedGroup, title, isComplete, isDaily)
			local questID, level, suggestedGroup, title, isComplete, isDaily = unwrap(arg2)
			BuddyList:receiveQuestInfo(arg4, questID, level, suggestedGroup, title, isComplete, isDaily)
			
		elseif arg1 == MQT.QST_PREFIX then
			-- receive quest message
			
			local title, level, idx, str, cmd = unwrap(arg2);
			-- convert idx to number
			idx = 0 + idx;

			if cmd == MQT.CMD_UPDATE then
				--Print("Piggyback Update received from " .. arg4)
				
				if (title ~= "0") then
					BuddyList:updateQuestPart(arg4, title, level, idx, str)
				--else
				--	Print("Gots a naught packet m'lord, from " .. arg4)
				else
					BuddyList:propagate(arg4)
				end
				WatchFrame_Update()
			else
				BuddyList:receiveQuestPart(arg4, title, level, idx, str)
			end
			
		elseif arg1 == MQT.CMD_PREFIX then
			if arg2 == MQT.CMD_UPDATE then
				-- update aanroepen hier
				Print("Update received from " .. arg4);
				BuddyList:propagate(arg4)
				WatchFrame_Update()
			else
				if MQT.db.profile.debug then Print(L["Command not found"]) end
			end
		end
	end	
	
end

function MQT.OnInitialize(self)
	local f,w;
	self.db = { profile = {} } -- prevent nil errors
	
	--self:SetEnabledState(false);
	
	-- Initialize my library
	ML:init();

	Print(L["Moncaí's Quest Tracker loading, stand by..."]);

	if (self.Event == nil) then Print(L["PANIC!"]) end
	
	f = CreateFrame("Frame", "MQTEvent");
	f:SetScript("OnEvent", function(...) MQT.Event(...) end);
	f:SetScript("OnUpdate", function(...) MQT.Update(...) end);
	f:RegisterEvent("UI_INFO_MESSAGE");
	f:RegisterEvent("CHAT_MSG_ADDON");
	f:RegisterEvent("PARTY_MEMBERS_CHANGED");
	f:RegisterEvent("PLAYER_ENTERING_WORLD");
	
	MQTW.frame = f;
	
	
	local hooks = ML.api.hooking:new(self);
	self.hooks = hooks;

	hooks:HookGlobal("WATCHFRAME_MINIMUMWIDTH");
	hooks:HookGlobal("WATCHFRAME_QUEST_OFFSET");
	hooks:HookGlobal("WATCHFRAME_QUEST_WITH_ITEM_HEIGHT");
	--3.3: Loop through in place for the most part
	hooks:HookGlobals(self.builtins);
	
	WatchFrame = _G["WatchFrame"]
--~ 	MQT.WatchFrame = WatchFrame	
--~ 	local dummy = CreateFrame("Button", "MoncaiQuestTrackerDummy", UIParent)
--~ 	dummy:SetFrameStrata("LOW")
--~ 	dummy:Hide()
--~ 	_G["WatchFrame"] = dummy
	
	-- Floater to dock the frame on
	local floater = CreateFrame("Button", "MoncaiQuestTrackerFloater", UIParent)
	MQT.floater = floater
	
	floater:SetFrameStrata("LOW")
	floater:Hide()
	floater:SetPoint("CENTER")
	floater:SetMovable(true)
	floater:SetUserPlaced(true)
	floater:SetWidth(16)
	floater:SetHeight(16)
	floater:SetFrameLevel(3)
	local floater_tex = floater:CreateTexture()
	floater_tex:SetAllPoints()
	floater_tex:SetTexture(.8, .8, .3)
	floater_tex:SetParent(floater)

--~ 	local WatchFrame_tex = WatchFrame:CreateTexture()
--~ 	WatchFrame_tex:SetAllPoints()
--~ 	WatchFrame_tex:SetTexture(.3, .8, .3)
--~ 	WatchFrame_tex:SetParent(WatchFrame)

--~ 	local WatchFrameLines_tex = WatchFrameLines:CreateTexture()
--~ 	WatchFrameLines_tex:SetAllPoints()
--~ 	WatchFrameLines_tex:SetTexture(.8, .3, .3)
--~ 	WatchFrameLines_tex:SetParent(WatchFrameLines)

	
	floater.moved = function(self)
		if self.moving then return; end
		self.moving = true
		
		local x, y = self:GetCenter()
		local w, h = UIParent:GetWidth(), UIParent:GetHeight()
 		local anchor = (y < h*.45 and "BOTTOM" or y > h*.55 and "TOP" or "")..(x < w*.45 and "LEFT" or x > w*.55 and "RIGHT" or "")
		local height = (y <= h*.50 and (h-y) or y > h*.50 and y)
		floater.up = (y <= h*.55)
		
		if floater.wantedsize then
			height = floater.wantedsize
		end
		
		WatchFrame:ClearAllPoints()
		if anchor ~= "" then
			WatchFrame:SetPoint(anchor, self, "CENTER")
		else
			WatchFrame:SetPoint("CENTER", self, "CENTER")
		end
		WatchFrameLines:SetHeight(height)
		WatchFrame:SetHeight(height)
		WatchFrame:SetWidth(WatchFrame.collapsed and WATCHFRAME_COLLAPSEDWIDTH or WATCHFRAME_EXPANDEDWIDTH);

--~ 		Print(("done at height %d size %d x%d y%d h%d"):format(WatchFrame:GetHeight(), floater.wantedsize or -1, x, y, h))
--~ 		Print(("now at height %d"):format(WatchFrame:GetHeight()))

		self.moving = nil
	end
	floater.reset = function(self)
		self:ClearAllPoints();
		self:SetPoint("CENTER", nil, "CENTER", 100, 100)
 		self:moved()
	end
	floater:RegisterForDrag("LeftButton")
	floater:SetScript("OnDragStart", function(self) 
		if self:IsVisible() then
			self:StartMoving()
			floater:SetScript("OnUpdate", self.moved)
		end
	end)
	floater:SetScript("OnDragStop", function(self) 
		if self:IsVisible() then
			floater:SetScript("OnUpdate", nil)
			self:StopMovingOrSizing()
			self:moved()
		end
	end)
	floater.state = -1;
end

function MQT.Floater_Update()
	local floater = MQT.floater
	
	if MQT.db.profile.float then
		if floater.state ~= 1 then
			WatchFrame:SetMovable(true)
			WatchFrame:SetUserPlaced(true)
		end
		if MQT.db.profile.floatfixed then
			floater:Hide()
			floater:moved()
			WatchFrame_OnSizeChanged()
		else
			floater:Show()
			floater:moved()
			WatchFrame_OnSizeChanged()
		end
		floater.state = 1
	else 
		if floater.state ~= 0 then
			floater:Hide()
			WatchFrame:ClearAllPoints()
			WatchFrame:SetPoint("TOPRIGHT", MinimapCluster, "BOTTOMRIGHT", 0, 0)
			floater.state = 0			
			if WatchFrame:IsUserPlaced() then WatchFrame:SetUserPlaced(false) end
			if WatchFrame:IsMovable() then WatchFrame:SetMovable(false) end
			UIParent_ManageFramePositions()
		end
	end
end

-- revert to defaults here
function MQT.defaults()

end;

function MQT.OnToggle(self)
	QuestLog_Update();
	WatchFrame_Update();
	MQT.Floater_Update();
end;

local fragcount = 0;
MQT.Refresh = function(self) 
	MQT.OnToggle(self)
	fragcount = fragcount + 1
	if MQT.db.profile.debug then Print("Aaaaah, refreshing for the " .. fragcount .. "th time!") end --DEBUG
	
	--[[if MQT.db.profile.removecomplete then
		local numQuestWatches = GetNumQuestWatches();
		for i = 1, numQuestWatches do
			local questTitle, _, _, _, _, _, isComplete = GetQuestLogTitle(i);

			if isComplete and MQT.db.profile.removecomplete then
				RemoveQuestWatch(i)
				return
			end			
		end
	end]]
end

function MQT.OnEnable(self)
	self.hooks:enable();
	self:OnToggle();
	Print(L["Moncaí's Quest Tracker enabled"]);
	if not MQTC.QList then
		MQTC.Qlist = {}
	end
end;

function MQT.OnDisable(self)
	self.hooks:disable();
	self:OnToggle();
	Print(L["Moncaí's Quest Tracker disabled"]);
end;

function MQT.Toggle(self)
	if self:IsEnabled() then
		self:Disable();
	else
		self:Enable();
	end;
end;

function MQT.FitLine(line, maxwidth)
	local text, curlen;
	text = line:GetText();
	curlen = line:GetStringWidth();
	if (curlen > maxwidth) then
		local firstpart, lastword, suc = text, "", false;

		for w,x in text:gmatch(L["(.*)(: ?.*)"]) do
			firstpart, lastword = w, x;
		end
		local lalen = 4;
		for word in firstpart:gmatch(L["([^ ]+)$"]) do
			lalen = word:len();
		end
		lastword = firstpart:sub(firstpart:len() - (lalen-1)) .. lastword; 
		firstpart = firstpart:sub(1, firstpart:len() - (lalen+1)); -- eat a space
		--Print(string.format("We have `%s` `%s` now split up.",firstpart, lastword));

		line:SetText(firstpart .. "..." .. lastword);
		curlen = line:GetStringWidth();
		local fl = firstpart:len() -1;
		while (curlen > maxwidth and fl > 0) do
			firstpart = firstpart:sub(1, fl);
			fl = fl-1;
			line:SetText(firstpart .. "..." .. lastword);
			curlen = line:GetStringWidth();
		end
		if (fl <= 0) then
			line:SetText("< " .. lastword);			
		end
	end
end

function MQT.FitTitle(line, maxwidth)
	local text, curlen;
	text = line:GetText();
	curlen = line:GetStringWidth();
	if (curlen > maxwidth) then
		-- change (Complete) to (|cff00ff00C|r) and (Failed) to (|cffff0000F|r)
		text = text:gsub("%(Complete%)", "|cff00ff00C|r")
		text = text:gsub("%(Failed%)", "|cffff0000F|r")
		line:SetText(text)
		MQT.FitLine(line, maxwidth)
	end
end

local uwlevel = 0;

function MQT.UpdateWatches(arg)
	uwlevel = uwlevel + 1
	if MQT.strudel then Print(("MQT.UpdateWatches (%d, %s)"):format(uwlevel, arg or "nil")) end
	
	MQTW.watches = 0;

	-- Take over sort order by Blizzard
	local W = MQTW;
	local idx;
	local done = {};
	local num = MQT.hooks.global.originals["GetNumQuestWatches"]();
	local GetQuestIndexForWatch = MQT.hooks.global.originals["GetQuestIndexForWatch"];	
	for i = 1, num, 1 do
		W.watches = W.watches + 1
		idx = GetQuestIndexForWatch(i) -- result may have become nil as per ticket #32
		if idx then
			W.hash[W.watches] = idx;
			done[idx] = true;
		end
	end

	MQT.EnumWatches(done);
	
	uwlevel = uwlevel - 1
end

--[[ 	MQT.EnumWatches()
	adds the rest of the quests
]]
function MQT.EnumWatches(done)
	local skip = done or {};
	
	local numEntries, numQuests = GetNumQuestLogEntries();
	local questTitle, _, isHeader;
	local MQTC = MQTC;
	local W = MQTW;
	
	for i=1, numEntries + numQuests, 1 do
		-- title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, displayQuestID = GetQuestLogTitle(questIndex)
		local title, _, _, _, isHeader, _, _, _, questID, _ = GetQuestLogTitle(i);

		if not questID then Print(i); break; end
		if (not isHeader) and (not skip[i]) then
			if (MQTC.QList[questID] == true) or IsQuestWatched(i) then
				W.watches = W.watches + 1;
				W.hash[W.watches] = i;
				MQTC.QList[questID] = true;
			end
		end
	end
end

-------------------------------------------------------------------------------
--
-- Builtins override
--
-------------------------------------------------------------------------------

MQT.builtins = {};
local fun = MQT.builtins;

function fun.IsQuestWatched(questIndex)
	-- title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, displayQuestID = GetQuestLogTitle(questIndex)
	local _, _, _, _, _, isHeader, _, _, _, questID, _ = GetQuestLogTitle(questIndex);
	return ( (not isHeader) and ( (MQTC.QList[questID] == true) or MQT.hooks.global.originals["IsQuestWatched"](questIndex) ) );
end


function fun.AddQuestWatch(questIndex, timer, hey)
	MQT.hooks.global.originals["AddQuestWatch"](questIndex, timer);

	--local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, displayQuestID = GetQuestLogTitle(questIndex)
	local title, _, _, _, _, _, _, _, questID, _ = GetQuestLogTitle(questIndex);
	--Print(string.format("Really adding %d:%d:%s now", questIndex or -1, questID or -1, title or "nil"));
	
	if not questID then
		Print( ("AddQuestWatch received bogus questID %s %s"):format(questIndex, title))
		return
	end
	
	
	-- timer is set only when invoked from auto_watch thingy
	if (hey and not MQTC.QList[questID]) then
		if MQT.db.profile.verbosechat then Print(L["Hey, you're working on %s, I'll add it!"]:format(title)) end
	end

	MQTC.QList[questID] = true;
	
	MQT.UpdateWatches(("AddQuestWatch(%d,%s,%s)"):format(questIndex or -1, (timer and "true") or "false", (hey and "true") or "false"))
end

function fun.RemoveQuestWatch(questIndex)
	if not questIndex then return end
	
	MQT.hooks.global.originals["RemoveQuestWatch"](questIndex);
	
	local title, _, questID
	title, _, _, _, _, _, _, _, questID, _, _ = GetQuestLogTitle(questIndex);
	--local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, displayQuestID, startEvent = GetQuestLogTitle(questIndex)
	--Print(string.format("Really removing %d:%d:%s now", questIndex or -1, questID or -1, title or "nil"));

	if not questID then return; end
	
	MQTC.QList[questID] = nil;
	MQT.UpdateWatches(("RemoveQuestWatch(%d)"):format(questIndex or -1))
end

function fun.GetQuestIndexForWatch(questIndex)
	return MQTW.hash[questIndex];
end

function fun.GetNumQuestWatches() 
	MQT.UpdateWatches("GetNumQuestWatches() ");
	return MQTW.watches;
end

-------------------------------------------------------------------------------
-- test
-------------------------------------------------------------------------------

function Test() 
	local i=0;
	while (GetQuestLogTitle(i+1) ~= nil) do
		i = i + 1;
		local questTitle, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(i);
		if (not isHeader) then
			DEFAULT_CHAT_FRAME:AddMessage(questTitle .. " [" .. level .. "]");
		else
			DEFAULT_CHAT_FRAME:AddMessage("## " .. questTitle .. " ##");
		end
	end
	
	local numEntries, numQuests = GetNumQuestLogEntries()
	DEFAULT_CHAT_FRAME:AddMessage(numEntries .. " entries containing " .. numQuests .. " quests in your quest log.");
end
