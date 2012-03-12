local EveryQuest = LibStub("AceAddon-3.0"):GetAddon("EveryQuest")
local L = LibStub("AceLocale-3.0"):GetLocale("EveryQuest")
local buildnumber
_, buildnumber = GetBuildInfo()
local MODNAME = "Query"
local Query = EveryQuest:NewModule(MODNAME, "AceEvent-3.0")
local db, dbpc
local doqueryauto = false
local queryready = false
local myquery = false
local clrimportchk = false
local unknowns = 0
local addcount = 0
local completedquests = {}

local queryOptions = {
	type = "group",
	disabled = tonumber(buildnumber) < 10623,
	name = L["Server Query"],
	args = {
		intro = {
			order = 1,
			type = "description",
			name = L["EQ_QUERY"] .. "\n", -- Query Options
		},
		doquery = {
			order = 2,
			type = "execute",
			name = L["Query Server"], -- Query Options
			desc = L["Query Server"], -- Query Options
			func = function() Query:DoQuery() end,
		},
		doqueryauto = {
			order = 3,
			type = 'toggle',
			name = L["Auto Populate"], -- Query Options
			desc = L["Once the server responds, automatically start the import of quest data"], -- Query Options
			get = function(info) return doqueryauto end,
			set = function(info, value) doqueryauto = value end,
		},
		step2 = {
			order = 4,
			type = "description",
			name = L["EQ_QUERY2"] .. "\n", -- Query Options
		},
		dopopulate = {
			order = 5,
			type = "execute",
			name = L["Populate History"], -- Query Options
			desc = L["Once you recieve the server responce, populate the database with your completed quests."], -- Query Options
			func = function() Query:DoPopulate() end,
			disabled = function () if (queryready == false and doqueryauto == true) then return true else return false end end,
		},
		trailer = {
			order = 7,
			type = "description",
			name = L["EQ_QUERY_TRAILER"] .. "\n", -- Query Options
		},
		clearimportcheck = {
			order = 8,
			type = "toggle",
			name = L["Clear Import Confirm"], -- Query Options
			get = function(info) return clrimportchk end,
			set = function(info, value) clrimportchk = value end,
		},
		clearimport = {
			order = 9,
			type = "execute",
			name = L["Clear Imported Data"], -- Query Options
			desc = L["Delete any quest tagged as being imported."], -- Query Options
			func = function() Query:ClearPopulated() end,
			disabled = function () if clrimportchk == true then return false else return true end end,
		},
		clearimportdesc = {
			order = 10,
			type = "description",
			name = L["EQ_CLEARIMPORTDESC"] .. "\n", -- Query Options
		},
	}
}

function Query:OnInitialize()
	db = EveryQuest.db.profile
	dbpc = EveryQuest.dbpc.profile.history
	EveryQuest:RegisterModuleOptions(L["Server Query"], queryOptions)
	Query:RegisterEvent("QUEST_QUERY_COMPLETE")
	if EveryQuest.db.profile.querytime == nil then
		EveryQuest.db.profile.querytime = time() - 61
	end
end

function Query:DoQuery()
	local now = time()
	if (EveryQuest.db.profile.querytime and EveryQuest.db.profile.querytime + 61 >= now) or true then
		EveryQuest.db.profile.querytime = now
		EveryQuest:Print(L["Querying Server for your quest history"])
		QueryQuestsCompleted()
		myquery = true
	end
end

function Query:QUEST_QUERY_COMPLETE()
	queryready = true
	--LibStub("AceConfigRegistry-3.0"):NotifyChange("EveryQuest: " .. MODNAME)
	if myquery then
		if doqueryauto then
			self:DoPopulate()
		else
			EveryQuest:Print(L["Ready to populate your quest history from server"])
		end
	end
	myquery = false
end

function Query:DoPopulate()
	unknowns = 0
	addcount = 0
	doqueryauto = false
	EveryQuest:Print(L["Populating your quest history from the server, this may take a while and might freeze your game."])
	GetQuestsCompleted(completedquests)
	-- if EveryQuest.db.profile.unknowns then
		-- for k,v in pairs(EveryQuest.db.profile.unknowns) do
			-- if string.sub(tostring(v), -5) == "query" or v == true then
				-- EveryQuest.db.profile.unknowns[k] = nil
			-- end
		-- end
	-- end
	for v,_ in pairs(completedquests) do
		-- print(v)
		self:SetCompleted(v)
	end
	if unknowns > 0 then
		EveryQuest:Error(string.format(L["Populate History: %d quests not found in the database."], unknowns))
		EveryQuest:Error(L["Consider uploading your WTF\\Account\\{account name}\\SavedVariables\\EveryQuest.lua to http://wow.kandarz.com/everyquest/upload.html"])
	end
	EveryQuest:Print(string.format(L["Added %d quests to your database"], addcount))
	EveryQuest:SendMessage("EveryQuestDisplayChanged")
	EveryQuest:SendMessage("EveryQuestDataChanged")
end

--- Sets a quest to completed status (no longer in the quest log)
-- @param uid Unique ID for a quest
-- @usage EveryQuest:GetFont(uid)
function Query:SetCompleted(uid)
	if uid ~= nil and type(uid) == "number" then
		-- EveryQuest:Debug("Query:SetCompleted - " .. tostring(uid))
		-- EveryQuest:AddQuest(uid)

		-- EveryQuest:Debug("Query:SetCompleted - zoneid:"..tostring(zone))
		-- if EveryQuest.db.profile.unknowns then
			-- EveryQuest.db.profile.unknowns[uid] = nil
		-- end
		if EveryQuest.dbpc.profile.history[uid] == nil then
			EveryQuest.dbpc.profile.history[uid] = {}
		end
		-- if (EveryQuest.dbpc.profile.history[uid].status ~= nil and EveryQuest.dbpc.profile.history[uid].status < 2) or (uid ~= nil) then
		if EveryQuest.dbpc.profile.history[uid].status == nil or EveryQuest.dbpc.profile.history[uid].status < 2 then
			if EveryQuest.dbpc.profile.history[uid].completed == nil then
				EveryQuest.dbpc.profile.history[uid]["imported"] = 3
			end
			EveryQuest.dbpc.profile.history[uid].status = 2
			addcount = addcount + 1
			if daily then
				if EveryQuest.dbpc.profile.history[uid].count ~= nil then
					EveryQuest.dbpc.profile.history[uid].count = EveryQuest.dbpc.history[uid].count +1
				else
					EveryQuest.dbpc.profile.history[uid].count = 1
				end
			end
		end
		
	-- else
		-- unknowns = unknowns + 1
		-- if EveryQuest.db.profile.unknowns == nil then
			-- EveryQuest.db.profile.unknowns = {}
		-- end
		-- EveryQuest.db.profile.unknowns[uid] = EVERYQUEST_RELEASE_REVISION .. "||" .. date("%x") .. "||query"
		--EveryQuest:Error("Populate History: Unable to get Quest Information from DB")
	end
end

--- Clear all quests imported from the server.
-- @usage EveryQuest:ClearPopulated()
function Query:ClearPopulated()
	local count = 0
	for questid, quest in pairs(dbpc) do -- each quest in the zone
		if (quest["imported"] ~= nil and quest["imported"] == 3) then
			dbpc[questid] = nil
			count = count + 1
		end
	end
	EveryQuest:SendMessage("EveryQuestDisplayChanged")
	EveryQuest:SendMessage("EveryQuestDataChanged")
	EveryQuest:Print(string.format(L["Deleted %d quests from your database"], count))
	clrimportchk = false
end

--- EOF ---