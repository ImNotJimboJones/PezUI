--[[
Name: LibQuestEvents-1.0
Revision: $Revision: 93 $
Author(s): David Lynch (kemayo@gmail.com)
Website: http://www.wowace.com/wiki/LibQuestEvents-1.0
Documentation: http://www.wowace.com/wiki/LibQuestEvents-1.0
SVN: http://svn.wowace.com/wowace/trunk/LibQuestEvents-1.0/
Description: Abstracts out questlog events.
License: LGPL v2.1
]]

local MAJOR_VERSION = "LibQuestEvents-1.0"
local MINOR_VERSION = tonumber(("$Revision: 93 $"):match("%d+")) or 0

-- #AUTODOC_NAMESPACE lib

local lib, oldMinor = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

-- local Spew = Spew and Spew
local function Debug(...) --[[if Spew then Spew("QuestEvents", ...) end]] end

local DUNGEON = LFG_TYPE_DUNGEON
local HEROIC = DUNGEON_DIFFICULTY2
local tagWeight = {
	[ELITE] = 1,
	[GROUP] = 2,
	[PVP] = 3,
	[RAID] = 4,
	[DUNGEON] = 5,
	[HEROIC] = 6,
	[DAILY] = 7,
}

local _G = _G
local GetQuestLink = _G.GetQuestLink
local GetQuestLogTitle = _G.GetQuestLogTitle
local GetQuestLogSelection = _G.GetQuestLogSelection
local GetNumQuestLogEntries = _G.GetNumQuestLogEntries
local GetQuestLogQuestText = _G.GetQuestLogQuestText
local GetNumQuestLeaderBoards = _G.GetNumQuestLeaderBoards

local new, del, deepDel, doAll
do
	local list = setmetatable({}, {__mode='k'})
	function new(...)
		local t = next(list)
		if t then
			list[t] = nil
			for i = 1, select('#', ...) do
				t[i] = select(i, ...)
			end
			return t
		else
			return { ... }
		end
	end
	function del(t)
		setmetatable(t, nil)
		table.wipe(t)
		list[t] = true
		return nil
	end
	function deepDel(t)
		if type(t) ~= "table" then
			return nil
		end
		for k,v in pairs(t) do
			t[k] = deepDel(v)
		end
		return del(t)
	end
	function doAll(func, ...)
		for i=1, select('#', ...) do
			func(select(i, ...))
		end
	end
end

local frame
if lib.frame then
	frame = lib.frame
	frame:UnregisterAllEvents()
	frame:SetScript("OnEvent", nil)
	frame:SetScript("OnUpdate", nil)
else
	frame = CreateFrame("Frame", MAJOR_VERSION .. "_Frame")
	lib.frame = frame
end

frame:RegisterEvent("QUEST_LOG_UPDATE")
-- frame:RegisterEvent("UNIT_QUEST_LOG_CHANGED")

frame:SetScript("OnEvent", function(this, event, ...)
	-- Spew(event, ...)
	if event == "UNIT_QUEST_LOG_CHANGED" then
		if ... ~= "player" then
			return
		end
	end
	this["QUEST_LOG_UPDATE"](lib, ...)
	
end)

-- this is just a throttler for QUEST_LOG_UPDATE
local timeSoFar = 0
frame:SetScript("OnUpdate", function(this, timeSinceLast)
	timeSoFar = timeSoFar + timeSinceLast
	if timeSoFar > 0.1 then
		timeSoFar = 0
		frame:Hide()
		frame:QUEST_LOG_UPDATE()
	end
end)

if lib.callbacks then
	lib:UnhookDialogs()
else
	lib.callbacks = LibStub("CallbackHandler-1.0"):New(lib, nil, nil, "UnregisterAll")
end

-- Sorts a table of quests by level, with quests of the same level ordered
-- by elite, dungeon or raid tags, i.e. normal < elite < dungeon < raid.
-- Quests of the same level and tag are sorted alphabetically by title.
local questSort = function(a, b)
	local q = lib.quests
	local aa = (q[a].level * 8) + (q[a].tag and tagWeight[q[a].tag] or 0)
	local bb = (q[b].level * 8) + (q[b].tag and tagWeight[q[b].tag] or 0)
	if aa == bb then
		return q[a].title < q[b].title
	end
	return aa < bb
end

-- Various data tables:
lib.quests = lib.quests or new()

do
	local orig_abandon_onaccept, orig_abandon_items_onaccept, abandon_onaccept, abandon_items_onaccept
	local orig_AcceptQuest = AcceptQuest
	function AcceptQuest()
		lib.npc = UnitName("npc")
		lib.npc_is_player = UnitIsPlayer("npc")
		return orig_AcceptQuest()
	end

	function lib:UnhookDialogs()
		StaticPopupDialogs["ABANDON_QUEST"].OnAccept = orig_abandon_onaccept
		StaticPopupDialogs["ABANDON_QUEST_WITH_ITEMS"].OnAccept = orig_abandon_items_onaccept
	end
	function abandon_onaccept()
		local name = GetAbandonQuestName()
		local uid = lib:GetQuestIDByName(name)
		orig_abandon_onaccept()
		lib.callbacks:Fire("Quest_Abandoned", name, uid)
	end
	function abandon_items_onaccept()
		local name = GetAbandonQuestName()
		local uid = lib:GetQuestIDByName(name)
		orig_abandon_items_onaccept()
		lib.callbacks:Fire("Quest_Abandoned", name, uid)
	end
	orig_abandon_onaccept = StaticPopupDialogs["ABANDON_QUEST"].OnAccept
	orig_abandon_items_onaccept = StaticPopupDialogs["ABANDON_QUEST_WITH_ITEMS"].OnAccept
	StaticPopupDialogs["ABANDON_QUEST"].OnAccept = abandon_onaccept
	StaticPopupDialogs["ABANDON_QUEST_WITH_ITEMS"].OnAccept = abandon_items_onaccept
end

local uid_zone_map = {}

function frame:QUEST_LOG_UPDATE()
	local quests, old_quests = new(), lib.quests
	
	-- The quest log is scanned:
	local numEntries, numQuests = GetNumQuestLogEntries()
	local zone
	
	Debug("entries", numEntries, numQuests)

	if numEntries > 0 then
		local quest_count, id, overflow_handled = 0, 0, false
		while quest_count < numQuests do
			id = id + 1
			local name, level, tag, group, header, collapsed, complete, daily, unique_id = GetQuestLogTitle(id)
			Debug("Scan", name, header, collapsed, unique_id)
			if header then
				zone = name or (UNKNOWN .. " " .. id)
			else
				quest_count = quest_count + 1
				if id > numEntries then
					Debug("Overflow", name, uid_zone_map[unique_id])
					zone = uid_zone_map[unique_id] or UNKNOWN
					if zone == UNKNOWN and not overflow_handled then
						overflow_handled = true
					end
				else
					-- it's in a real zone; remember this in case things get collapsed later
					uid_zone_map[unique_id] = zone
				end
				local q = new()
				
				q.unique_id = unique_id
				q.id = id
				q.title = name
				q.level = level
				q.tag = tag
				q.group = group
				q.daily = daily
				if daily and not tag then
					q.tag = DAILY
				end
				q.complete = complete -- 1, -1, nil
				q.zone = zone
				
				quests[unique_id] = q
			end
			if id == numQuests * 2 then
				-- just in case, to avoid infinite loops (I don't trust whiles)
				quest_count = numQuests
			end
		end
	end
	
	lib.quests = quests

	table.sort(quests, questSort)
	
	-- Event firing
	local changed = false
	if lib.firstDone then
		for uid, quest in pairs(quests) do
			if not old_quests[uid] then
				-- Gained a quest
				lib.callbacks:Fire("Quest_Gained", quest.title, uid, GetNumQuestLeaderBoards(quest.id), quest.zone, lib.npc, lib.npc_is_player)
				changed = true
			else
				local oldquest = old_quests[uid]
				--Completed?
				if oldquest.complete ~= quest.complete then
					if quest.complete == 1 then
						lib.callbacks:Fire("Quest_Complete", quest.title, uid)
					elseif quest.complete == -1 then
						lib.callbacks:Fire("Quest_Failed", quest.title, uid)
					end
					changed = true
				end
			end
		end
		for uid, oldquest in pairs(old_quests) do
			-- Lost a quest?
			if not quests[uid] then
				lib.callbacks:Fire("Quest_Lost", oldquest.title, uid, oldquest.zone)
				changed = true
			end
		end
	else
		changed = true
		lib.firstDone = true

		lib.callbacks:Fire("Ready")
	end
	
	if changed then
		lib.callbacks:Fire("Update")
	end
	
	-- clean up junk tables
	
	doAll(deepDel, old_quests)
end

function lib:GetQuestIDByName(name)
	for uid, q in pairs(lib.quests) do
		if q.title == name then
			name = uid
			break
		end
	end
	return name
end