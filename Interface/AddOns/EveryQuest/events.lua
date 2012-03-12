local addon = LibStub("AceAddon-3.0"):GetAddon("EveryQuest")
local L = LibStub("AceLocale-3.0"):GetLocale("EveryQuest")
local QE = LibStub("LibQuestEvents-1.0")
local format = string.format
local db, dbpc
local list, module
local recentcompleted, recentcategory

function addon:EventsEnable()
	self:RegisterEvent("PLAYER_LOGIN")
	-- self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("QUEST_PROGRESS")
	self:RegisterEvent("QUEST_COMPLETE")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterMessage("EveryQuestDisplayChanged", "UpdateFrame")
	
	QE.RegisterCallback(self, "Quest_Abandoned", "Abandon")
	QE.RegisterCallback(self, "Quest_Gained", "Gained")
	QE.RegisterCallback(self, "Quest_Complete", "Complete")
	QE.RegisterCallback(self, "Quest_Failed", "Failed")
	addon:SecureHook("GetQuestReward")
	db = EveryQuest.db.profile
	dbpc = EveryQuest.dbpc.profile
end

function addon:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	local str = self:GetReleaseString()
	if str ~= nil then
		self:Print(str)
	end
end

-- function addon:PLAYER_ENTERING_WORLD()
	-- self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	-- self:ZONE_CHANGED_NEW_AREA()
-- end

function addon:QUEST_PROGRESS()
	self:Debug("QUEST_PROGRESS - " .. GetTitleText())
	recentquest = GetQuestID()
end

function addon:QUEST_COMPLETE()
	self:Debug("QUEST_COMPLETE - " .. GetTitleText())
	recentquest = GetQuestID()
end

function addon:ZONE_CHANGED_NEW_AREA()
	--self:Debug("ZONE_CHANGED_NEW_AREA - " .. GetRealZoneText())
	if db.track then
		local continent = nil
		if not WorldMapFrame:IsShown() then
			continent = GetCurrentMapContinent()
		end
		list, module = self:GetListIdByName(GetRealZoneText(), continent)
		if list ~= nil then
			addon.list = list
		end
		if module ~= nil then
			addon.module = module
		end
		self:Debug(format("ZoneChanged(%s) list id: %d module id: %s", GetRealZoneText(), list, module))
		addon.listsorted = false
		addon:SendMessage("EveryQuestDisplayChanged", addon.module, addon.list)
		-- self:UpdateFrame(zoneid, zonegroup)
	end
end

function addon:Abandon(event, title, uid)
	self:AddQuest(uid, completed)
	self:Debug("QUEST_ABANDON - questid:"..tostring(uid))
	dbpc.history[uid].status = -1
	dbpc.history[uid].abandoned = time()
	dbpc.history[uid]["imported"] = nil
	addon:SendMessage("EveryQuestDisplayChanged")
	addon:SendMessage("EveryQuestDataChanged")
	-- self:UpdateFrame()
end

function addon:Gained(event, title, uid)
	self:AddQuest(uid)
	dbpc.history[uid].status = 0
	self:Debug("QE_Quest_Gained - questid:"..tostring(uid))
	dbpc.history[uid]["imported"] = nil
	addon:SendMessage("EveryQuestDisplayChanged")
	addon:SendMessage("EveryQuestDataChanged")
	-- self:UpdateFrame()
end

function addon:Complete(event, title, uid)
	-- Complete as in completed all the objectives
	self:AddQuest(uid)
	dbpc.history[uid].status = 1
	dbpc.history[uid]["imported"] = nil
	dbpc.history[uid].abandoned = nil
	dbpc.history[uid].failed = nil
	self:Debug("QE_Quest_Complete - questid:"..tostring(uid))
	addon:SendMessage("EveryQuestDisplayChanged")
	addon:SendMessage("EveryQuestDataChanged")
	-- self:UpdateFrame()
end

function addon:Failed(event, title, uid)
	self:AddQuest(uid)
	dbpc.history[uid].status = -1
	dbpc.history[uid].failed = time()
	self:Debug("QE_Quest_Failed - questid:"..tostring(uid))
	dbpc.history[uid]["imported"] = nil
	addon:SendMessage("EveryQuestDisplayChanged")
	addon:SendMessage("EveryQuestDataChanged")
	-- self:UpdateFrame()
end

function addon:GetQuestReward(...)
	addon:Debug("Hooked GetQuestReward")
	addon:TurnedIn(recentquest)
end

function addon:TurnedIn(uid)
	local daily, weekly, repeatable = self:AddQuest(uid)
	self:Debug("QuestTurnedIn - questid:"..tostring(uid).." zoneid:"..tostring(zone))
	dbpc.history[uid].status = 2
	dbpc.history[uid].completed = time()
	if daily or weekly or repeatable then
		if dbpc.history[uid].count ~= nil then
			dbpc.history[uid].count = dbpc.history[uid].count +1
		else
			dbpc.history[uid].count = 1
		end
	end
	dbpc.history[uid]["imported"] = nil
	dbpc.history[uid].abandoned = nil
	dbpc.history[uid].failed = nil
	addon:SendMessage("EveryQuestDisplayChanged")
	addon:SendMessage("EveryQuestDataChanged")
	-- self:UpdateFrame()
end