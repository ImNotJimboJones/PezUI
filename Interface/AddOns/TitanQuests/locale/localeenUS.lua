--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	enUS localization file

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
local initenUS

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function initenUS()
	local L = LibStub("AceLocale-3.0"):NewLocale(TitanQuests.TitanQuests.GetAddonName(), "enUS", true)
	if not L then
		return
	end

	L["ABOUT_AUTHOR_TEXT"]                = "Author"
	L["ABOUT_TEXT"]                       = "About"
	L["ADD_TO_WATCHER_TEXT"]              = "Add to Watcher"
	L["BUTTON_LABEL"]                     = "Quests"
	L["CHOOSE_HEADER"]                    = "Choose"
	L["CLICK_BEHAVIOR_TEXT"]              = "Left Click to Watch Quest"
	L["GROUP_BEHAVIOR_TEXT"]              = "Group Sorted Quests"
	L["LEVEL_TEXT"]                       = "Level"
	L["LINK_QUEST_TEXT"]                  = "Link Quest"
	L["MEMBERS_ON_QUEST_HEADER"]          = "Party Members on Quest"
	L["MENU_TEXT"]                        = "Quests"
	L["NO_COMPLETED_QUESTS_TEXT"]         = "No completed quests"
	L["NO_DAILY_QUESTS_TEXT"]             = "No daily quests"
	L["NO_DUNGEON_QUESTS_TEXT"]           = "No dungeon quests"
	L["NO_ELITE_QUESTS_TEXT"]             = "No elite quests"
	L["NO_GROUP_QUESTS_TEXT"]             = "No group quests"
	L["NO_HEROIC_QUESTS_TEXT"]            = "No heroic quests"
	L["NO_INCOMPLETE_QUESTS_TEXT"]        = "No incomplete quests"
	L["NO_PVP_QUESTS_TEXT"]               = "No PvP quests"
	L["NO_QUESTS_TEXT"]                   = "No quests"
	L["NO_RAID_QUESTS_TEXT"]              = "No raid quests"
	L["NO_REGULAR_QUESTS_TEXT"]           = "No regular quests"
	L["OPTIONS_TEXT"]                     = "Options"
	L["PLAYER_TITLE_TEXT"]                = "Player Title"
	L["PREFIX_DUNGEON"]                   = "d"
	L["PREFIX_GROUP"]                     = "g"
	L["PREFIX_HEROIC"]                    = "h"
	L["PREFIX_PVP"]                       = "p"
	L["PREFIX_RAID"]                      = "r"
	L["PREFIX_WATCHLIST"]                 = "W"
	L["QUEST_DETAILS_OPTIONS_TEXT"]       = "Quest Options"
	L["QUEST_DETAILS_TEXT"]               = "Quest Details"
	L["QUESTLIST_TRUNCATED"]              = "Quest list too large. Some quests are not displayed."
	L["REMOVE_FROM_WATCHER_TEXT"]         = "Remove from Watcher"
	L["REWARDS_HEADER"]                   = "Rewards"
	L["SHOW_ALL_TEXT"]                    = "All (Default)"
	L["SHOW_COMPLETED_TEXT"]              = "only Completed"
	L["SHOW_DAILY_TEXT"]                  = "only Daily"
	L["SHOW_DUNGEON_TEXT"]                = "only Dungeon"
	L["SHOW_ELITE_TEXT"]                  = "only Elite"
	L["SHOW_GROUP_TEXT"]                  = "only Group"
	L["SHOW_HEROIC_TEXT"]                 = "only Heroic"
	L["SHOW_INCOMPLETE_TEXT"]             = "only Incomplete"
	L["SHOW_PVP_TEXT"]                    = "only PvP"
	L["SHOW_RAID_TEXT"]                   = "only Raid"
	L["SHOW_REGULAR_TEXT"]                = "only Regular"
	L["SHOW_TEXT"]                        = "Show"
	L["SORT_LEVEL_TEXT"]                  = "by Level"
	L["SORT_LOCATION_TEXT"]               = "by Location"
	L["SORT_TEXT"]                        = "Sort"
	L["SORT_TITLE_TEXT"]                  = "by Title (Default)"
	L["TALENT_POINTS_TEXT"]               = "Talent Points"
	L["TIMESTRING"]                       = "%X%p"
	L["TOOLTIP"]                          = "Quests Info"
	L["TOOLTIP_COMPLETED_TEXT"]           = "Completed Quests"
	L["TOOLTIP_DAILY_TEXT"]               = "Daily Quests"
	L["TOOLTIP_DUNGEON_TEXT"]             = "Dungeon Quests"
	L["TOOLTIP_ELITE_TEXT"]               = "Elite Quests"
	L["TOOLTIP_GROUP_TEXT"]               = "Group Quests"
	L["TOOLTIP_HEROIC_TEXT"]              = "Heroic Quests"
	L["TOOLTIP_HINT_OPEN_QUESTLIST"]      = "Hint: Right-click for quest list."
	L["TOOLTIP_HINT_OPEN_QUESTLOG"]       = "Hint: Left-click to open the quest log."
	L["TOOLTIP_HINT_OPEN_QUESTLOG_SHIFT"] = "Hint: Shift + left-click to open the quest log."
	L["TOOLTIP_HINT_WATCHLIST"]           = "Hint: Left-click add the quest to the watchlist."
	L["TOOLTIP_HINT_WATCHLIST_SHIFT"]     = "Hint: Shift + left-click add the quest to the watchlist."
	L["TOOLTIP_INCOMPLETE_TEXT"]          = "Incomplete Quests"
	L["TOOLTIP_PVP_TEXT"]                 = "PvP Quests"
	L["TOOLTIP_QUESTS_TEXT"]              = "Total Quests"
	L["TOOLTIP_RAID_RESET"]               = "Raid reset"
	L["TOOLTIP_RAID_TEXT"]                = "Raid Quests"
	L["TOOLTIP_REGULAR_TEXT"]             = "Regular Quests"
end

--------------------------------------------------------------------------------
-- additional locale operations                                               --
--------------------------------------------------------------------------------
TitanQuests.Locale.InitenUS = initenUS