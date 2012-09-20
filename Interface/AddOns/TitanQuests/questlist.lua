--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	TitanQuests::QuestList class.

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 3
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]

--------------------------------------------------------------------------------
-- QuestList definition                                                       --
--------------------------------------------------------------------------------
--[[
QuestList[i] = {
	["index"]     = quest index in the quest log (aka not the questID!) - integer
	["title"]     = quest title - string
	["objective"] = quest objective - string
	["level"]     = quest level - integer
	["tag"]       = quest tag - ELITE, GROUP, LFG_TYPE_DUNGEON, RAID, PVP, nil
	["complete"]  = quest is completed - integer (-1 = failed, 1 = complete, nil = incomplete)
	["daily"]     = quest is a daily quest - true/false
	["location"]  = quest location - string
	["group"]     = number of suggested group members for the quest - integer
	["money"]     = required money to solve the quest - integer
	["rewards"]   =  {
		["money"]   = money gained when solving the quest - integer
		["talents"] = talent points gained when solving the quest - integer
		["title"]   = title gained, when solving the quest - string
		["items"][i] = {
			["name"]     = item name - string
			["texture"]  = item texture - string
			["usable"]   = whether the item is usable by the player - bool
			["numItems"] = number of the item which is rewarded - integer
			["quality"]  = item quality - integer
			["type"]     = item type - string
			["subtype"]  = item sub type - string
			["link"]     = item link - string
		}
		["choices"][i] = {
			["name"]     = item name - string
			["texture"]  = item texture - string
			["usable"]   = whether the item is usable by the player - bool
			["numItems"] = number of the item which is rewarded - integer
			["quality"]  = item quality - integer
			["type"]     = item type - string
			["subtype"]  = item sub type - string
			["link"]     = item link - string
		}
		["spell"] = {
			["name"]    = spell name - string
			["texture"] = spell texture - string
			["link"]    = spell Link - string / nil, if no link is available for that spell
		}
	}
}
]]

--------------------------------------------------------------------------------
-- Declarations                                                               --
--------------------------------------------------------------------------------
-- to prevent tainting the glypth UI
local _
-- public functions
local flagDirty
local getNumQuests
local getQuestList
local init
local setSortOrder
-- private functions
local addCountedQuest
local clearCache
local doesFilterMatch
local getFilteredQuestList
local getQuestObjectives
local getQuestRewards
local resetQuestCount
local sort
local updateQuests
-- private attributes
local CachedQuestList
local CachedQuestListFilter
local IsDirty
local LastSortOrder
local NumCompleteQuests
local NumDailyQuests
local NumDungeonQuests
local NumEliteQuests
local NumGroupQuests
local NumHeroicQuests
local NumIncompleteQuests
local NumPVPQuests
local NumQuests
local NumRaidQuests
local NumRegularQuests
local QuestList
local SortOrder

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function addCountedQuest(tag)
	if tag == ELITE then
		NumEliteQuests = NumEliteQuests + 1
	elseif tag == GROUP then
		NumGroupQuests = NumGroupQuests + 1
	elseif tag == LFG_TYPE_DUNGEON then
		NumDungeonQuests = NumDungeonQuests + 1
	elseif tag == RAID then
		NumRaidQuests = NumRaidQuests + 1
	elseif tag == PVP then
		NumPVPQuests = NumPVPQuests + 1
	elseif tag == PLAYER_DIFFICULTY2 then
		NumHeroicQuests = NumHeroicQuests + 1
	else
		NumRegularQuests = NumRegularQuests + 1
	end
end

function clearCache()
	CachedQuestList = {}
	CachedQuestListFilter = nil
end

function doesFilterMatch(filter, entry)
	if filter == "elite" then
		return entry.tag == ELITE
	elseif filter == "group" then
		return entry.tag == GROUP
	elseif filter == "dungeon" then
		return entry.tag == LFG_TYPE_DUNGEON
	elseif filter == "raid" then
		return entry.tag == RAID
	elseif filter == "pvp" then
		return entry.tag == PVP
	elseif filter == "regular" then
		return entry.tag == nil
	elseif filter == "heroic" then
		return entry.tag == PLAYER_DIFFICULTY2
	elseif filter == "completed" then
		return entry.complete == 1
	elseif filter == "incomplete" then
		return entry.complete == nil
	elseif filter == "daily" then
		return entry.daily == true
	end

	-- by definition any undefined filter, "all" and nil always match any entry
	return true
end

function flagDirty()
	LastSortOrder = "unsorted"
	IsDirty = true
	clearCache()
end

function getFilteredQuestList(filter)
	if filter == CachedQuestListFilter then
		return CachedQuestList
	end

	clearCache()

	for key, entry in ipairs(QuestList) do
		if doesFilterMatch(filter, entry) then
			table.insert(CachedQuestList, entry)
		end
	end

	CachedQuestListFilter = filter

	return CachedQuestList
end

function getNumQuests()
	updateQuests()
	return NumQuests, NumCompleteQuests, NumIncompleteQuests, NumRegularQuests, NumGroupQuests, NumPVPQuests, NumDungeonQuests, NumEliteQuests, NumRaidQuests, NumHeroicQuests, NumDailyQuests
end

function getQuestList(filter)
	updateQuests()
	sort()

	if not filter or filter == "all" then
		return QuestList
	end

	return getFilteredQuestList(filter)
end

function getQuestObjectives(questIndex)
	local numObjectives = GetNumQuestLeaderBoards(questIndex)

	local success = true

	if numObjectives == 0 then
		return nil, success
	end

	local text, finished, entry
	local objectives = {}

	for i = 1, numObjectives do
		-- GetQuestLogLeaderBoard() can return an incomplete text
		-- under some circumstances (which are unknown)
		-- calling it twice, does not improve the situation)
		-- it seems to be a general issue with that function
		-- with no known workaround
		text, _, finished = GetQuestLogLeaderBoard(i, questIndex)
		if text == "" then
			success = false
		end
		entry = {
			["text"]     = text,
			["finished"] = finished
		}
		table.insert(objectives, entry)
	end

	return objectives, success
end

function getQuestRewards()
	local rewards = {}
	local success = true

	rewards["money"]   = GetQuestLogRewardMoney()
	rewards["talents"] = GetQuestLogRewardTalents()
	rewards["title"]   = GetQuestLogRewardTitle()

	-- get quest item rewards
	local itemRewards = {}
	local numRewards = GetNumQuestLogRewards()
	local itemTexture, numItems, itemQuality, isUsable, itemLink, itemName, itemType, itemSubType
	local entry
	for i = 1, numRewards do
		itemName, itemTexture, numItems, itemQuality, isUsable = GetQuestLogRewardInfo(i)
		itemLink = GetQuestLogItemLink("reward", i)
		if itemLink ~= nil then
			_ , _, _, _, _, itemType, itemSubType = GetItemInfo(itemLink)
			entry = {
				["name"]     = itemName,
				["texture"]  = itemTexture,
				["usable"]   = isUsable,
				["numItems"] = numItems,
				["quality"]  = itemQuality,
				["type"]     = itemType,
				["subtype"]  = itemSubType,
				["link"]     = itemLink
			}
			table.insert(itemRewards, entry)
		else
			-- can happen, if items have not been cached yet
			success = false
		end
	end
	rewards["items"] = itemRewards

	-- get choosable item rewards
	local itemChoices = {}
	local numChoices = GetNumQuestLogChoices()
	for i = 1, numChoices do
		itemName, itemTexture, numItems, itemQuality, isUsable = GetQuestLogChoiceInfo(i)
		itemLink = GetQuestLogItemLink("choice", i)
		if itemLink ~= nil then
			_ , _, _, _, _, itemType, itemSubType = GetItemInfo(itemLink)
			entry = {
				["name"]     = itemName,
				["texture"]  = itemTexture,
				["usable"]   = isUsable,
				["numItems"] = numItems,
				["quality"]  = itemQuality,
				["type"]     = itemType,
				["subtype"]  = itemSubType,
				["link"]     = itemLink
			}
			table.insert(itemChoices, entry)
		else
			-- can happen, if items have not been cached yet
			success = false
		end
	end
	rewards["choices"] = itemChoices

	-- get spell reward
	local spellTexture, spellName = GetQuestLogRewardSpell()
	if spellTexture then
		-- spellLink can be nil, if there is no lower level spell in the
		-- player's spellbook yet (for instance for new tradeskills
		-- earned by a quest)
		local spellLink = GetSpellLink(spellName)
		rewards["spell"] = {
			["name"]    = spellName,
			["texture"] = spellTexture,
			["link"]    = spellLink
		}
	end

	return rewards, success
end

function init()
	flagDirty() -- initially the quest list is dirty (i.e. unsorted)
	setSortOrder("unsorted")
end

function resetQuestCount()
	NumCompleteQuests   = 0
	NumDailyQuests      = 0
	NumDungeonQuests    = 0
	NumEliteQuests      = 0
	NumGroupQuests      = 0
	NumHeroicQuests     = 0
	NumIncompleteQuests = 0
	NumPVPQuests        = 0
	NumQuests           = 0
	NumRaidQuests       = 0
	NumRegularQuests    = 0
end

function setSortOrder(order)
	SortOrder = order
end

function sort()
	if SortOrder == LastSortOrder then
		return	-- already sorted
	end

	if SortOrder == "level" then
		table.sort(QuestList, function(a, b) return (a.level < b.level) end)
	elseif SortOrder == "location" then
		table.sort(QuestList, function(a, b) return (a.location < b.location) end)
	else -- SortOrder == "title"
		table.sort(QuestList, function(a, b) return (a.title < b.title) end)
	end

	LastSortOrder = SortOrder
	clearCache()
end

function updateQuests()
	if not IsDirty then
		return
	end

	local previousQuest = GetQuestLogSelection()

	resetQuestCount()

	-- we must expand the questlog to ensure that we get all quests even if
	-- the player has collapsed some of the headers
	ExpandQuestHeader(0)

	local location
	local title, level, tag, suggestedGroup, isHeader, isComplete, isDaily
	local questIndex
	local entry
	local objective
	local objectives
	local rewards
	local rewardsSuccess
	local objectivesSuccess

	local numEntries
	numEntries, NumQuests = GetNumQuestLogEntries()

	QuestList = {}
	clearCache()

	NumIncompleteQuests = NumQuests

	local dirty = false

	for questIndex = 1, numEntries do
		title, level, tag, suggestedGroup, isHeader, _, isComplete, isDaily = GetQuestLogTitle(questIndex)

		if isComplete == 1 then
			NumIncompleteQuests = NumIncompleteQuests - 1
		end

		if isDaily == 1 then
			NumDailyQuests = NumDailyQuests + 1
		end

		if isHeader then
			location = title
		else
			addCountedQuest(tag)
			SelectQuestLogEntry(questIndex) -- required for GetQuestLogRequiredMoney and GetQuestLogQuestText
			_, objective = GetQuestLogQuestText()
			rewards, rewardsSuccess = getQuestRewards()
			objectives, objectivesSuccess = getQuestObjectives(questIndex)
			if not rewardsSuccess or not objectivesSuccess then
				dirty = true
			end
			
			entry = {
				["index"]      = questIndex,
				["title"]      = title,
				["objective"]  = objective,
				["objectives"] = objectives,
				["level"]      = level,
				["tag"]        = tag,
				["complete"]   = isComplete,
				["daily"]      = not not isDaily,	-- make boolean (could be 1 or nil)
				["location"]   = location,
				["group"]      = suggestedGroup,
				["money"]      = GetQuestLogRequiredMoney(),
				["rewards"]    = rewards
			}
			table.insert(QuestList, entry)
		end
	end

	SelectQuestLogEntry(previousQuest)

	NumCompleteQuests = NumQuests - NumIncompleteQuests
	IsDirty = dirty
end

--------------------------------------------------------------------------------
-- QuestList class definition                                                 --
--------------------------------------------------------------------------------
TitanQuests.QuestList = {
	-- operations
	FlagDirty    = flagDirty,
	GetNumQuests = getNumQuests,
	GetQuestList = getQuestList,
	Init         = init,
	SetSortOrder = setSortOrder
}
