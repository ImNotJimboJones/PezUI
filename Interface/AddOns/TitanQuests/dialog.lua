--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	TitanQuests::Dialog class.

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
local getButtonText
local getTooltipText
local onClick
local prepareRightClickMenu
local staticInit
-- private functions
local addQuestItem
local addQuestRewards
local areLocationHeadersActive
local clickQuest
local clickQuestDetails
local containsRewards
local createAboutDialog
local createFilterDialog
local createLevel1Menu
local createOptionDialog
local createSingleQuestDialog
local createSortDialog
local getQuestButton
local setFilter
local setSortOrder
local toggleClickBehavior
local toggleGroupBehavior
local toggleWatchStatus
-- links
local QuestList
local TitanQuestsBase
local TitanQuestsLocale
local TitanLocale
local Utilities

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function addQuestItem(rewardItem)
	local _, _, _, hex = GetItemQualityColor(rewardItem.quality)

	-- itemname
	local text = hex..rewardItem.name..FONT_COLOR_CODE_CLOSE

	-- itemcount
	if rewardItem.numItems > 1 then
		text = text..TitanUtils_GetHighlightText(" x"..rewardItem.numItems)
	end

	-- type/subtype
	local typeText = rewardItem.type..":"..rewardItem.subtype
	if rewardItem.usable then
		typeText = TitanUtils_GetHighlightText(typeText)
	else
		typeText = "|cff"..format("%02x", 204)..format("%02x", 0)..format("%02x", 0)..typeText..FONT_COLOR_CODE_CLOSE
	end
	text = text.."    "..typeText

	-- construct itemstring
	local itemString = Utilities.GetItemString(rewardItem.link)

	-- create button
	info = {}
	info.icon = rewardItem.texture
	info.text = text
	info.checked = function() return Utilities.IsTooltipItem(itemString) end
	info.func = function() SetItemRef(itemString, rewardItem.link, "RightButton") end
	info.keepShownOnClick = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
end

function addQuestRewards(rewards)
	if not containsRewards(rewards) then
		return	-- no rewards, so nothing to display
	end

	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL)

	-- add rewards header
	local info = {}
	info.text = TitanQuestsLocale["REWARDS_HEADER"]
	info.isTitle = true
	info.notCheckable = true
	info.notClickable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- add money reward
	local money = rewards.money
	if money > 0 then
		info = {}
		info.text = Utilities.GetColoredMoneyText(money)
		info.notCheckable = true
		info.notClickable = true
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end

	-- add item rewards
	local numRewards = #rewards.items
	for i = 1, numRewards do
		addQuestItem(rewards.items[i])
	end

	-- add spell reward
	if rewards.spell then
		info = {}
		info.text = TitanUtils_GetHighlightText(rewards.spell.name)
		info.icon = rewards.spell.texture
		if rewards.spell.link then
			info.checked = function() return Utilities.IsTooltipItem(Utilities.GetItemString(rewards.spell.link)) end
			info.func = function() SetItemRef(rewards.spell.name, rewards.spell.link, "RightButton") end
		else
			info.notCheckable = true
			info.notClickable = true
		end
		info.keepShownOnClick = true
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end

	-- add item choices
	local numChoices = #rewards.choices
	if numChoices > 0 then
		-- add choices header
		info = {}
		info.text = TitanQuestsLocale["CHOOSE_HEADER"]..": "
		info.notCheckable = true
		info.notClickable = true
		info.keepShownOnClick = true
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {}
		for i = 1, numChoices do
			addQuestItem(rewards.choices[i])
		end
	end

	-- add talent points
	if rewards.talents > 0 then
		info = {}
		info.text = TitanQuestsLocale["TALENT_POINTS_TEXT"]..": "..rewards.talents
		info.notCheckable = true
		info.notClickable = true
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	end

	-- add rewarded title
	if rewards.title then
		info = {}
		info.text = TitanQuestsLocale["PLAYER_TITLE_TEXT"]..": "..rewards.title
		info.notCheckable = true
		info.notClickable = true
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	end
end

function areLocationHeadersActive()
	return TitanQuestsBase.GetSortOrder() == "location" and TitanQuestsBase.IsGrouped()
end

function clickQuest(questListEntry, button)
	if (TitanQuestsBase.IsClickBehavior() and not IsShiftKeyDown()) or (not TitanQuestsBase.IsClickBehavior() and IsShiftKeyDown()) then
		toggleWatchStatus(questListEntry, button)
	else
		clickQuestDetails(questListEntry.index)
	end
end

function clickQuestDetails(questIndex)
	Utilities.DisplayQuest(questIndex)
	TitanPanelRightClickMenu_Close()
end

function containsRewards(rewards)
	return rewards.money > 0 or rewards.talents >0 or rewards.title ~= nil or #rewards.items > 0 or #rewards.choices >0 or rewards.spell ~= nil
end

function getButtonText()
	local numQuests, numCompleteQuests = QuestList.GetNumQuests()

	-- create string for Titan bar display
	local buttonRichText = TitanUtils_GetGreenText(numCompleteQuests.."/")..TitanUtils_GetHighlightText(numQuests)

	-- Return our button label
	return TitanQuestsLocale["BUTTON_LABEL"]..": ", buttonRichText
end

function getQuestButton(questListEntry)
	local button

	-- Get the quest button
	for i = 1, UIDROPDOWNMENU_MAXBUTTONS do
		button = getglobal("DropDownList1Button"..i)
		if type(button.value) == "table" then
			if button.value == questListEntry then
				break
			end
		end
		button = nil
	end

	return button
end

function getTooltipText()
	local numQuests, numCompleteQuests, numIncompleteQuests, numRegularQuests, numGroupQuests, numPVPQuests, numDungeonQuests, numEliteQuests, numRaidQuests, numHeroicQuests, numDailyQuests = QuestList.GetNumQuests()

	local tooltipRichText = ""
	tooltipRichText = tooltipRichText..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_QUESTS_TEXT"])..": "..TitanUtils_GetHighlightText(numQuests).."\n"
	tooltipRichText = tooltipRichText.."   "..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_ELITE_TEXT"]).." ("..Utilities.GetQuestTagPrefix(ELITE).."): "..TitanUtils_GetHighlightText(numEliteQuests).."\n"
	tooltipRichText = tooltipRichText.."   "..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_GROUP_TEXT"]).." ("..Utilities.GetQuestTagPrefix(GROUP).."): "..TitanUtils_GetHighlightText(numGroupQuests).."\n"
	tooltipRichText = tooltipRichText.."   "..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_HEROIC_TEXT"]).." ("..Utilities.GetQuestTagPrefix(PLAYER_DIFFICULTY2).."): "..TitanUtils_GetHighlightText(numHeroicQuests).."\n"
	tooltipRichText = tooltipRichText.."   "..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_DUNGEON_TEXT"]).." ("..Utilities.GetQuestTagPrefix(LFG_TYPE_DUNGEON).."): "..TitanUtils_GetHighlightText(numDungeonQuests).."\n"
	tooltipRichText = tooltipRichText.."   "..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_RAID_TEXT"]).." ("..Utilities.GetQuestTagPrefix(RAID).."): "..TitanUtils_GetHighlightText(numRaidQuests).."\n"
	tooltipRichText = tooltipRichText.."   "..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_PVP_TEXT"]).." ("..Utilities.GetQuestTagPrefix(PVP).."): "..TitanUtils_GetHighlightText(numPVPQuests).."\n"
	tooltipRichText = tooltipRichText.."   "..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_REGULAR_TEXT"])..": "..TitanUtils_GetHighlightText(numRegularQuests).."\n"
	tooltipRichText = tooltipRichText.."\n"
	tooltipRichText = tooltipRichText..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_DAILY_TEXT"]).." (*): "..TitanUtils_GetHighlightText(numDailyQuests).."\n"
	tooltipRichText = tooltipRichText.."\n"
	tooltipRichText = tooltipRichText..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_COMPLETED_TEXT"])..": "..TitanUtils_GetHighlightText(numCompleteQuests).."\n"
	tooltipRichText = tooltipRichText..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_INCOMPLETE_TEXT"])..": "..TitanUtils_GetHighlightText(numIncompleteQuests).."\n"
	tooltipRichText = tooltipRichText.."\n"
	tooltipRichText = tooltipRichText..TitanUtils_GetNormalText(TitanQuestsLocale["TOOLTIP_RAID_RESET"]..": "..date(TitanQuestsLocale["TIMESTRING"], time() + GetQuestResetTime())).."\n"
	tooltipRichText = tooltipRichText.."\n"
	tooltipRichText = tooltipRichText..TitanUtils_GetGreenText(TitanQuestsLocale["TOOLTIP_HINT_OPEN_QUESTLOG"]).."\n"
	tooltipRichText = tooltipRichText..TitanUtils_GetGreenText(TitanQuestsLocale["TOOLTIP_HINT_OPEN_QUESTLIST"])

	return tooltipRichText
end

function onClick(_, button)
	if button == "LeftButton" then
		Utilities.ToggleQuestLog()
	end
end

function prepareRightClickMenu()
	if UIDROPDOWNMENU_MENU_LEVEL == 1 then
		createLevel1Menu()
	elseif UIDROPDOWNMENU_MENU_LEVEL == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "options" then
			createOptionDialog()
		else
			createSingleQuestDialog()
		end
	elseif UIDROPDOWNMENU_MENU_LEVEL == 3 then
		if UIDROPDOWNMENU_MENU_VALUE == "displayAbout" then
			createAboutDialog()
		elseif UIDROPDOWNMENU_MENU_VALUE == "sort" then
			createSortDialog()
		else -- UIDROPDOWNMENU_MENU_VALUE == "filter"
			createFilterDialog()
		end
	end
end

function staticInit()
	QuestList       = TitanQuests.QuestList
	TitanQuestsBase = TitanQuests.TitanQuests
	Utilities       = TitanQuests.Utilities

	TitanQuestsLocale = LibStub("AceLocale-3.0"):GetLocale(TitanQuestsBase.GetAddonName())
	TitanLocale       = LibStub("AceLocale-3.0"):GetLocale("Titan")
end

function createAboutDialog()
	local aboutText = TitanQuestsBase.GetTitle().."\n"
	aboutText = aboutText..TitanUtils_GetNormalText(TitanQuestsLocale["ABOUT_AUTHOR_TEXT"]..": ")..TitanUtils_GetHighlightText("["..TitanQuestsBase.GetAuthor().."]")

	local info = {}
	info.text = aboutText
	info.notCheckable = true
	info.notClickable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
end

function createFilterDialog()
	local info = { }
	info.notCheckable = true
	info.text = TitanQuestsLocale["SHOW_TEXT"]
	info.isTitle = 1
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- show only elite
	info = {}
	info.text = TitanQuestsLocale["SHOW_ELITE_TEXT"]
	info.func = function() setFilter("elite") end
	info.checked = function() return TitanQuestsBase.GetFilter() == "elite" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	
	-- show only group
	info = {}
	info.text = TitanQuestsLocale["SHOW_GROUP_TEXT"]
	info.func = function() setFilter("group") end
	info.checked = function() return TitanQuestsBase.GetFilter() == "group" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	
	-- show only dungeon
	info = {}
	info.text = TitanQuestsLocale["SHOW_DUNGEON_TEXT"]
	info.func = function() setFilter("dungeon") end
	info.checked = function() return TitanQuestsBase.GetFilter() == "dungeon" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- show only raid
	info = {}
	info.text = TitanQuestsLocale["SHOW_RAID_TEXT"]
	info.func = function() setFilter("raid") end
	info.checked = function() return TitanQuestsBase.GetFilter() == "raid" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	
	-- show only pvp
	info = {}
	info.text = TitanQuestsLocale["SHOW_PVP_TEXT"]
	info.func = function() setFilter("pvp") end
	info.checked = function() return TitanQuestsBase.GetFilter() == "pvp" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	
	-- show only regular
	info = {}
	info.text = TitanQuestsLocale["SHOW_REGULAR_TEXT"]
	info.func = function() setFilter("regular") end
	info.checked = function() return TitanQuestsBase.GetFilter() == "regular" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- show only regular
	info = {}
	info.text = TitanQuestsLocale["SHOW_HEROIC_TEXT"]
	info.func = function() setFilter("heroic") end
	info.checked = function() return TitanQuestsBase.GetFilter() == "heroic" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- show only completed
	info = {}
	info.text = TitanQuestsLocale["SHOW_COMPLETED_TEXT"]
	info.func = function() setFilter("completed") end
	info.checked = function() return TitanQuestsBase.GetFilter() == "completed" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- show only incomplete
	info = {}
	info.text = TitanQuestsLocale["SHOW_INCOMPLETE_TEXT"]
	info.func = function() setFilter("incomplete") end
	info.checked = function() return TitanQuestsBase.GetFilter() == "incomplete" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- show only daily
	info = {}
	info.text = TitanQuestsLocale["SHOW_DAILY_TEXT"]
	info.func = function() setFilter("daily") end
	info.checked = function() return TitanQuestsBase.GetFilter() == "daily" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- show all
	info = {}
	info.text = TitanQuestsLocale["SHOW_ALL_TEXT"]
	info.func = function() setFilter("all") end
	info.checked = function() return TitanQuestsBase.GetFilter() == "all" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
end

function createLevel1Menu()
	-- create a title (for consistency with other plugins)
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TitanQuestsBase.GetTitanPanelID()].menuText)

	-- get quest list
	local questlist = QuestList.GetQuestList(TitanQuestsBase.GetFilter())

	local groupID = ""
	local lastGroupID = ""

	-- create a configuration entry
	local info = {}
	info.text = TitanQuestsLocale["OPTIONS_TEXT"]
	info.value = "options"
	info.hasArrow = true
	info.notCheckable = true
	UIDropDownMenu_AddButton(info)

	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL)

	if #questlist == 0 then
		info = {}
		info.text = Utilities.GetNoQuestText(TitanQuestsBase.GetFilter())
		info.notCheckable = true
		info.notClickable = true
		UIDropDownMenu_AddButton(info)
	end

	-- check if grouping is required
	local grouped = TitanQuestsBase.IsGrouped()
	local sortOrder = TitanQuestsBase.GetSortOrder()
	local needsGrouping = grouped and sortOrder ~= "title"

	-- output quest list to menu
	local height
	local exceedsHeight
	for key, entry in ipairs(questlist) do
		info = {}
		if TitanUtils_GetRealPosition("Quests") == TITAN_PANEL_PLACE_TOP then
			height = _G["DropDownList"..1]:GetBottom()
			exceedsHeight = height and height <= 100
		else
			height = _G["DropDownList"..1]:GetTop()
			exceedsHeight = height and height > GetScreenHeight() * 0.9
		end
		-- bottom seems not to be set when opening the questlist for
		-- the first time - presumably because the dropdown list hasn't
		-- been positioned yet
		if exceedsHeight then
			info.isTitle = true
			info.notCheckable = true
			info.text = TitanUtils_GetGreenText(TitanQuestsLocale["QUESTLIST_TRUNCATED"])
			UIDropDownMenu_AddButton(info)
			break
		end

		if needsGrouping then
			if sortOrder == "location" then
				groupID = entry.location
			else -- sortOrder == "level"
				groupID = TitanQuestsLocale["LEVEL_TEXT"].." "..entry.level
			end
		end

		if groupID ~= lastGroupID then
			info.text = groupID
			info.isTitle = true
			info.notCheckable = true
			UIDropDownMenu_AddButton(info)
			info = {}
			lastGroupID = groupID
		end

		info.checked          = function() return IsQuestWatched(entry.index) end
		info.text             = Utilities.GetQuestText(entry, areLocationHeadersActive())
		info.value            = entry
		info.hasArrow         = true
		info.func             = function(button) clickQuest(entry, button) end
		info.keepShownOnClick = true
		UIDropDownMenu_AddButton(info)
	end

	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL)

	-- left-click hint
	info = {}
	if TitanQuestsBase.IsClickBehavior() then
		info.text = TitanUtils_GetGreenText(TitanQuestsLocale["TOOLTIP_HINT_WATCHLIST"])
	else
		info.text = TitanUtils_GetGreenText(TitanQuestsLocale["TOOLTIP_HINT_OPEN_QUESTLOG"])
	end
	info.notCheckable = true
	info.notClickable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- shift-left-click hint
	info = {}
	if TitanQuestsBase.IsClickBehavior() then
		info.text = TitanUtils_GetGreenText(TitanQuestsLocale["TOOLTIP_HINT_OPEN_QUESTLOG_SHIFT"])
	else
		info.text = TitanUtils_GetGreenText(TitanQuestsLocale["TOOLTIP_HINT_WATCHLIST_SHIFT"])
	end
	info.notCheckable = true
	info.notClickable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
end

function createOptionDialog()
	-- sort selection
	local info = {}
	info.text = TitanQuestsLocale["SORT_TEXT"]
	info.value = "sort"
	info.hasArrow = true
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	
	-- show selection
	info = {}
	info.text = TitanQuestsLocale["SHOW_TEXT"]
	info.value = "filter"
	info.hasArrow = true
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	
	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL)
	
	-- toggle click behavior
	info = {}
	info.text = TitanQuestsLocale["CLICK_BEHAVIOR_TEXT"]
	info.keepShownOnClick = true
	info.func = function() toggleClickBehavior() end
	info.checked = function() return TitanQuestsBase.IsClickBehavior() end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
			
	-- toggle grouping
	info = {}
	info.text = TitanQuestsLocale["GROUP_BEHAVIOR_TEXT"]
	info.func = function() toggleGroupBehavior() end
	info.checked = function() return TitanQuestsBase.IsGrouped() end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	
	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL)
	
	-- toggle icon
	-- we can't use TitanPanelRightClickMenu_AddToggleIcon() here, since it only works with top-level menus
	info = {}
	info.text = TitanLocale["TITAN_PANEL_MENU_SHOW_ICON"]
	info.func = function() TitanQuestsBase.ToggleShowIcon() end
	info.checked = function() return TitanQuestsBase.IsShowIcon() end
	info.keepShownOnClick = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	
	-- toggle Label text
	-- we can't use TitanPanelRightClickMenu_AddToggleLabelText() here, since it only works with top-level menus
	info = {}
	info.text = TitanLocale["TITAN_PANEL_MENU_SHOW_LABEL_TEXT"]
	info.func = function() TitanQuestsBase.ToggleShowLabelText() end
	info.checked = function() return TitanQuestsBase.IsShowLabelText() end
	info.keepShownOnClick = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	
	-- Hide Titan Panel Quests
	info = {}
	info.text = TitanLocale["TITAN_PANEL_MENU_HIDE"]
	info.func = function()
		TitanPanelRightClickMenu_Hide(TitanQuestsBase.GetTitanPanelID())
		TitanPanelRightClickMenu_Close()
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	
	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL)
	
	-- info about plugin
	info = {}
	info.text = TitanQuestsLocale["ABOUT_TEXT"]
	info.value = "displayAbout"
	info.hasArrow = true
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
end

function createSingleQuestDialog()
	-- gather required quest information
	local questListEntry         = UIDROPDOWNMENU_MENU_VALUE
	local questIndex             = questListEntry.index
	local questTitle, questLevel = questListEntry.title, questListEntry.level
	local moneyRequired          = questListEntry.moneyRequired
	local questObjective         = questListEntry.objective
	local questObjectives        = questListEntry.objectives

	local info = {}
	info.text = questTitle
	info.isTitle = true
	info.notClickable = true
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	if moneyRequired then
		info = {}
		local money = Utilities.GetColoredMoneyText(moneyRequired)
		info.text = money
		info.notClickable = true
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	end

	info = {}
	info.notClickable = true
	info.notCheckable = true
	-- generate one button for every each line, to prevent too long
	-- text garbling the menu layout
	-- we can't combine more than one line here, since otherwise
	-- the text would look garbled too beginning with text in 3
	-- lines
	if questObjectives then
		for key, entry in ipairs(questObjectives) do
			local text = Utilities.WrapText(entry.text, 65)
			local textarray = Utilities.SplitTextLines(text, 1)
			for _, textline in ipairs(textarray) do
				if entry.finished then
					info.text = TitanUtils_GetGreenText(textline)
				else
					info.text = textline
				end
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
			end
		end
	else
		local text = Utilities.WrapText(questObjective, 65)
		local textarray = Utilities.SplitTextLines(text, 1)
		for _, textline in ipairs(textarray) do
			info.text = TitanUtils_GetHighlightText(textline)
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
		end
	end
	
	addQuestRewards(questListEntry.rewards)

	-- Show the quest party members, if player is in a party and there is
	-- at least one more member having the same quest
	local questPartyMembers = Utilities.GetQuestPartyMembers(questIndex)
	if questPartyMembers ~= "" then
		TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL)

		-- display header
		info = {}
		info.text = TitanQuestsLocale["MEMBERS_ON_QUEST_HEADER"]
		info.notCheckable = true
		info.notClickable = true
		info.isTitle = true
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

		-- display group member info
		info = {}
		info.notCheckable = true
		info.notClickable = true
		info.text = TitanUtils_GetHighlightText(questPartyMembers)
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
 	end

	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL)

	-- Header for options stuff
	info = {}
	info.text = TitanQuestsLocale["QUEST_DETAILS_OPTIONS_TEXT"]
	info.isTitle = true
	info.notCheckable = true
	info.notClickable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- Add/Remove quest from Quest Tracker
	info = {}
	info.notCheckable = true
	info.func = function() toggleWatchStatus(questListEntry, getQuestButton(questListEntry)) end
	if IsQuestWatched(questIndex) then
		info.text = TitanQuestsLocale["REMOVE_FROM_WATCHER_TEXT"]
	else
		info.text = TitanQuestsLocale["ADD_TO_WATCHER_TEXT"]
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	
	-- share quest
	if GetQuestLogPushable() then
		info = {}
		info.text = SHARE_QUEST
		info.notCheckable = true
		info.func = function ()
			local previousQuest = GetQuestLogSelection()
			SelectQuestLogEntry(questIndex)
			QuestLogPushQuest()
			SelectQuestLogEntry(previousQuest)
		end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	end

	-- abandon quest
	info = {}
	info.text = ABANDON_QUEST
	info.notCheckable = true
	info.func = function ()	
			TitanPanelRightClickMenu_Close()
			local previousQuest = GetQuestLogSelection()
			SelectQuestLogEntry(questIndex)
			SetAbandonQuest()
			StaticPopup_Show("ABANDON_QUEST", GetAbandonQuestName())
			SelectQuestLogEntry(previousQuest)
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL)

	-- quest details
	info = {}
	info.value = questListEntry
	info.notCheckable = true
	info.text = TitanQuestsLocale["QUEST_DETAILS_TEXT"]
	info.func = function() clickQuestDetails(questIndex) end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- link quest
	info = {}
	info.notCheckable = true
	info.text = TitanQuestsLocale["LINK_QUEST_TEXT"]
	info.func = function () ChatFrameEditBox:Insert(GetQuestLink(questIndex)) end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
end

function createSortDialog()
	local info = {}
	info.notCheckable = true
	info.text = TitanQuestsLocale["SORT_TEXT"]
	info.isTitle = true
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- sort by location
	info = {}
	info.text = TitanQuestsLocale["SORT_LOCATION_TEXT"]
	info.func = function() setSortOrder("location") end
	info.checked = function() return TitanQuestsBase.GetSortOrder() == "location" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- sort by level
	info = {}
	info.text = TitanQuestsLocale["SORT_LEVEL_TEXT"]
	info.func = function() setSortOrder("level") end
	info.checked = function() return TitanQuestsBase.GetSortOrder() == "level" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

	-- sort by title
	info = {}
	info.text = TitanQuestsLocale["SORT_TITLE_TEXT"]
	info.func = function() setSortOrder("title") end
	info.checked =  function() return TitanQuestsBase.GetSortOrder() == "title" end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
end

function setFilter(filter)
	-- we close the dropdown list, since otherwise the questlist with the previous sort setting would still be visible
	-- updating the questlist here directly would require too much work and not be worth the affort
	TitanPanelRightClickMenu_Close()
	TitanQuestsBase.SetFilter(filter)
end

function setSortOrder(order)
	-- we close the dropdown list, since otherwise the questlist with the previous sort setting would still be visible
	-- updating the questlist here directly would require too much work and not be worth the affort
	TitanPanelRightClickMenu_Close()
	TitanQuestsBase.SetSortOrder(order)
end

function toggleClickBehavior()
	-- we close the dropdown list, since otherwise the questlist with the previous group setting would still be visible
	-- updating the questlist here directly would require too much work and not be worth the effort
	TitanPanelRightClickMenu_Close()
	TitanQuestsBase.ToggleClickBehavior()
end

function toggleGroupBehavior()
	-- we close the dropdown list, since otherwise the questlist with the previous group setting would still be visible
	-- updating the questlist here directly would require too much work and not be worth the effort
	TitanPanelRightClickMenu_Close()
	TitanQuestsBase.ToggleGroupBehavior()
end

function toggleWatchStatus(questListEntry, button)
	local questIndex = questListEntry.index

	-- Add/Remove quest from Quest Tracker
	if IsQuestWatched(questIndex) then
		RemoveQuestWatch(questIndex)
		getglobal(button:GetName().."Check"):Hide()
	else
		AddQuestWatch(questIndex)
		getglobal(button:GetName().."Check"):Show()
	end

	-- update watcher tag
	button:SetText(Utilities.GetQuestText(questListEntry))

	-- we close the second level drop down list, since otherwise we would
	-- have to manually update the text and checkbox for the "track quest"
	-- line
	getglobal("DropDownList2"):Hide()

	WatchFrame_Update()
end

--------------------------------------------------------------------------------
-- Dialog class definition                                                    --
--------------------------------------------------------------------------------
TitanQuests.Dialog = {
	-- operations
	GetButtonText         = getButtonText,
	GetTooltipText        = getTooltipText,
	OnClick               = onClick,
	PrepareRightClickMenu = prepareRightClickMenu,
	StaticInit            = staticInit
}
