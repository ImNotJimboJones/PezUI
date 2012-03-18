--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	TitanQuests::Utilities class.

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
-- Declarations                                                               --
--------------------------------------------------------------------------------
-- public functions
local displayQuest
local getColoredMoneyText
local getItemString
local getNoQuestText
local getQuestPartyMembers
local getQuestTagPrefix
local getQuestText
local init
local isTooltipItem
local splitTextLines
local toggleQuestLog
local wrapText
-- private functions
local getBlueText
local getQuestWatchPrefix
local getQuestCompleteText
-- links
local TitanQuestsLocale

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function displayQuest(questIndex)
	SelectQuestLogEntry(questIndex)
	QuestLog_SetSelection(questIndex)
	-- updates the quest list screen - if it isn't called, we end up with visual glitches (incorrect selection, wrong colors)
	QuestLog_Update()

	if not QuestLogFrame:IsVisible() then
		ShowUIPanel(QuestLogFrame)
	end
end

function getBlueText(text)
	return "|cff0000ff"..text..FONT_COLOR_CODE_CLOSE
end

function getColoredMoneyText(money)
	-- GetCoinText() ensures the compatibility between changes in WoW and
	-- also provides correctly localized text
	local separatedMoneyText = GetCoinText(money, ";")

	-- separate the text elements
	local coins = {}
	local coin
	for coin in string.gmatch(separatedMoneyText, "%d+%s%a+") do
		table.insert(coins, coin.." ")
	end
	local goldText, silverText, copperText
	goldText   = coins[1]
	silverText = coins[2]
	copperText = coins[3]

	-- split up money
	local copper = money % COPPER_PER_SILVER
	money = money - copper
	money = money / COPPER_PER_SILVER
	local silver = money % SILVER_PER_GOLD
	money = money - silver
	money = money / SILVER_PER_GOLD
	local gold = money

	-- set proper text variables, if money doesn't consist of all three coin
	-- types
	if gold == 0 then
		copperText = silverText
		silverText = goldText
		goldText = ""
	end
	if silver == 0 then
		copperText = silverText
		silverText = ""
	end
	if copper == 0 then
		copperText = ""
	end

	-- colorize the text output
	if goldText ~= "" then
		goldText = "|cff"..format("%02x", 204)..format("%02x", 153)..format("%02x", 0)..goldText..FONT_COLOR_CODE_CLOSE
	end
	if silverText ~= "" then
		silverText = "|cff"..format("%02x", 204)..format("%02x", 204)..format("%02x", 204)..silverText..FONT_COLOR_CODE_CLOSE
	end
	if copperText ~= "" then
		copperText = "|cff"..format("%02x", 204)..format("%02x", 102)..format("%02x", 0)..copperText..FONT_COLOR_CODE_CLOSE
	end

	return goldText..silverText..copperText
end

function getItemString(link)
	return string.sub(link, string.find(link, "|H") + 2, string.find(link, "|h") - 1)
end

function getNoQuestText(filter)
	if filter == "all" then
		return TitanQuestsLocale["NO_QUESTS_TEXT"]
	elseif filter == "dungeon" then
		return TitanQuestsLocale["NO_DUNGEON_QUESTS_TEXT"]
	elseif filter == "elite" then
		return TitanQuestsLocale["NO_ELITE_QUESTS_TEXT"]
	elseif filter == "group" then
		return TitanQuestsLocale["NO_GROUP_QUESTS_TEXT"]
	elseif filter == "heroic" then
		return TitanQuestsLocale["NO_HEROIC_QUESTS_TEXT"]
	elseif filter == "pvp" then
		return TitanQuestsLocale["NO_PVP_QUESTS_TEXT"]
	elseif filter == "raid" then
		return TitanQuestsLocale["NO_RAID_QUESTS_TEXT"]
	elseif filter == "regular" then
		return TitanQuestsLocale["NO_REGULAR_QUESTS_TEXT"]
	elseif filter == "daily" then
		return TitanQuestsLocale["NO_DAILY_QUESTS_TEXT"]
	elseif filter == "completed" then
		return TitanQuestsLocale["NO_COMPLETED_QUESTS_TEXT"]
	elseif filter == "incomplete" then
		return TitanQuestsLocale["NO_INCOMPLETE_QUESTS_TEXT"]
	end
end

function getQuestCompleteText(isComplete)
	local completeTag

	if isComplete == 1 then
		completeTag = TitanUtils_GetGreenText(" ("..COMPLETE..")")
	elseif isComplete == -1 then
		completeTag = TitanUtils_GetRedText(" ("..FAILED..")")
	else
		completeTag = ""
	end

	return completeTag
end

function getQuestPartyMembers(questID)
	local numPartyMembers = GetNumPartyMembers()
	local membersOnQuest = ""

	for i = 1, numPartyMembers do
		if IsUnitOnQuest(questID, "party"..i) then
			membersOnQuest = membersOnQuest..UnitName("party"..i).." "
		end
	end

	return membersOnQuest
end

function getQuestTagPrefix(tag)
	if tag == ELITE then
		return "+"
	elseif tag == GROUP then
		return TitanQuestsLocale["PREFIX_GROUP"]
	elseif tag == LFG_TYPE_DUNGEON then
		return TitanQuestsLocale["PREFIX_DUNGEON"]
	elseif tag == RAID then
		return TitanQuestsLocale["PREFIX_RAID"]
	elseif tag == PVP then
		return TitanQuestsLocale["PREFIX_PVP"]
	elseif tag == PLAYER_DIFFICULTY2 then
		return TitanQuestsLocale["PREFIX_HEROIC"]
	else -- regular quest
		return ""
	end
end

function getQuestText(questListEntry, locationHeadersActive)
	local locationText = ""
	if not locationHeadersActive then
		locationText = TitanUtils_GetNormalText("  ["..questListEntry.location.."]")
	end

	local level           = questListEntry.level
	local tag             = getQuestTagPrefix(questListEntry.tag)
	local title           = questListEntry.title
	local numGroupMembers = questListEntry.group

	local dailyPrefix = ""
	if questListEntry.daily then
		dailyPrefix = "*"
	end

	local groupMemberText = ""
	if numGroupMembers > 0 then
		groupMemberText = " ["..numGroupMembers.."]"
	end

	local questTextPrefix    = TitanUtils_GetColoredText("["..level..tag..dailyPrefix.."]  ", GetQuestDifficultyColor(level))
	local completedText      = getQuestCompleteText(questListEntry.complete)
	local questWatchedPrefix = getBlueText(getQuestWatchPrefix(questListEntry.index))

	return questTextPrefix..title..groupMemberText..completedText..locationText..questWatchedPrefix
end

function getQuestWatchPrefix(questIndex)
	local questWatched

	if IsQuestWatched(questIndex) then
		questWatched = " ("..TitanQuestsLocale["PREFIX_WATCHLIST"]..")"
	else
		questWatched = ""
	end

	return questWatched
end

function isTooltipItem(itemString)
	local _, currentItem = ItemRefTooltip:GetItem()
	if currentItem == nil then
		return false
	end
	return getItemString(currentItem) == itemString
end

function splitTextLines(text, linesPerEntry)
	local pos = 0
	local returnarray = {}

	for i = 1, linesPerEntry do
		pos = string.find(text, "\n", pos + 1, true)
		if not pos then
			break	-- not enough new lines
		end
	end

	while pos do
		-- insert next entry
		table.insert(returnarray, string.sub(text, 1, pos - 1))

		-- get remaining text
		text = string.sub(text, pos + 1)

		-- go to next end position
		for i = 1, linesPerEntry do
			pos = string.find(text, "\n", pos + 1, true)
			if not pos then
				break	-- not enough new lines
			end
		end
	end

	-- insert the last entry
	table.insert(returnarray, text)

	return returnarray
end

function staticInit()
	TitanQuestsLocale = LibStub("AceLocale-3.0"):GetLocale(TitanQuests.TitanQuests.GetAddonName())
end

function toggleQuestLog()
	if QuestLogFrame:IsVisible() then
		HideUIPanel(QuestLogFrame)
	else
		ShowUIPanel(QuestLogFrame)
	end
end

-- source: http://lua-users.org/wiki/StringRecipes (date: 10-27-2010)
-- slightly adapted (removed indentation support, do not split numbers or
-- whitespace separated non-letters)
function wrapText(text, width)
	width = width or 78

	local here = 1
	return text:gsub("(%s+)()(%a+%S*)()",
		function (_, st, word, fi)
			if fi-here > width then
				here = st
				return "\n"..word
			end
		end
		)
end

--------------------------------------------------------------------------------
-- Utilities class definition                                            --
--------------------------------------------------------------------------------
TitanQuests.Utilities = {
	-- operations
	DisplayQuest         = displayQuest,
	GetColoredMoneyText  = getColoredMoneyText,
	GetItemString        = getItemString,
	GetNoQuestText       = getNoQuestText,
	GetQuestPartyMembers = getQuestPartyMembers,
	GetQuestTagPrefix    = getQuestTagPrefix,
	GetQuestText         = getQuestText,
	IsTooltipItem        = isTooltipItem,
	SplitTextLines       = splitTextLines,
	StaticInit           = staticInit,
	ToggleQuestLog       = toggleQuestLog,
	WrapText             = wrapText
}