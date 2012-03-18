--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	deDE localization file

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
local initdeDE

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function initdeDE()
	local L = LibStub("AceLocale-3.0"):NewLocale(TitanQuests.TitanQuests.GetAddonName(), "deDE")
	if not L then
		return
	end
	
	L["ABOUT_AUTHOR_TEXT"]                = "Author"
	L["ABOUT_TEXT"]                       = "\195\156ber"
	L["ADD_TO_WATCHER_TEXT"]              = "Quest verfolgen"
	L["BUTTON_LABEL"]                     = "Quests"
	L["CHOOSE_HEADER"]                    = "Auswahl"
	L["CLICK_BEHAVIOR_TEXT"]              = "Linksklick um Quests zu verfolgen"
	L["GROUP_BEHAVIOR_TEXT"]              = "Sortierte Quests gruppieren"
	L["LEVEL_TEXT"]                       = "Level"
	L["LINK_QUEST_TEXT"]                  = "Quest verlinken"
	L["MEMBERS_ON_QUEST_HEADER"]          = "Mitglieder mit gleicher Quest"
	L["MENU_TEXT"]                        = "Quests"
	L["NO_COMPLETED_QUESTS_TEXT"]         = "Keine abgeschlossene Quests"
	L["NO_DAILY_QUESTS_TEXT"]             = "Keine t\195\164glichen Quests"
	L["NO_DUNGEON_QUESTS_TEXT"]           = "Keine Instanzen-Quests"
	L["NO_ELITE_QUESTS_TEXT"]             = "Keine Elite-Quests"
	L["NO_GROUP_QUESTS_TEXT"]             = "Keine Gruppen-Quests"
	L["NO_HEROIC_QUESTS_TEXT"]            = "Keine heroischen Quests"
	L["NO_INCOMPLETE_QUESTS_TEXT"]        = "Keine unvollst\195\164ndigen Quests"
	L["NO_PVP_QUESTS_TEXT"]               = "Keine PvP-Quests"
	L["NO_QUESTS_TEXT"]                   = "Keine Quests"
	L["NO_RAID_QUESTS_TEXT"]              = "Keine Schlachtzugs-Quests"
	L["NO_REGULAR_QUESTS_TEXT"]           = "Keine regul\195\164ren Quests"
	L["OPTIONS_TEXT"]                     = "Optionen"
	L["PLAYER_TITLE_TEXT"]                = "Spieler Titel"
	L["PREFIX_DUNGEON"]                   = "d"
	L["PREFIX_GROUP"]                     = "g"
	L["PREFIX_HEROIC"]                    = "h"
	L["PREFIX_PVP"]                       = "p"
	L["PREFIX_RAID"]                      = "r"
	L["PREFIX_WATCHLIST"]                 = "W"
	L["QUEST_DETAILS_OPTIONS_TEXT"]       = "Quest Optionen"
	L["QUEST_DETAILS_TEXT"]               = "Quest Details"
	L["QUESTLIST_TRUNCATED"]              = "Questliste ist zu lang. Einige Quests werden nicht angezeigt."
	L["REMOVE_FROM_WATCHER_TEXT"]         = "Quest nicht l\195\164nger verfolgen"
	L["REWARDS_HEADER"]                   = "Belohnungen"
	L["SHOW_ALL_TEXT"]                    = "Alle (Standard)"
	L["SHOW_COMPLETED_TEXT"]              = "nur abgeschlossene Quests"
	L["SHOW_DAILY_TEXT"]                  = "nur t\195\164gliche Quests"
	L["SHOW_DUNGEON_TEXT"]                = "nur Instanzen-Quests"
	L["SHOW_ELITE_TEXT"]                  = "nur Elite-Quests"
	L["SHOW_GROUP_TEXT"]                  = "nur Gruppen-Quests"
	L["SHOW_HEROIC_TEXT"]                 = "nur heroische Quests"
	L["SHOW_INCOMPLETE_TEXT"]             = "nur unvollst\195\164ndigen Quests"
	L["SHOW_PVP_TEXT"]                    = "nur PvP-Quests"
	L["SHOW_RAID_TEXT"]                   = "nur Schlachtzugs-Quests"
	L["SHOW_REGULAR_TEXT"]                = "nur regul\195\164re Quests"
	L["SHOW_TEXT"]                        = "Anzeige"
	L["SORT_LEVEL_TEXT"]                  = "nach Level"
	L["SORT_LOCATION_TEXT"]               = "nach Zonen"
	L["SORT_TEXT"]                        = "Sortieren"
	L["SORT_TITLE_TEXT"]                  = "nach Bezeichnung (Standard)"
	L["TALENT_POINTS_TEXT"]               = "Talentpunkte"
	L["TIMESTRING"]                       = "%X"
	L["TOOLTIP"]                          = "Quest Infos"
	L["TOOLTIP_COMPLETED_TEXT"]           = "Abgeschlossene Quests"
	L["TOOLTIP_DAILY_TEXT"]               = "T\195\164gliche Quests"
	L["TOOLTIP_DUNGEON_TEXT"]             = "Instanzen-Quests"
	L["TOOLTIP_ELITE_TEXT"]               = "Elite-Quests"
	L["TOOLTIP_GROUP_TEXT"]               = "Gruppen-Quests"
	L["TOOLTIP_HEROIC_TEXT"]              = "Heroische Quests"
	L["TOOLTIP_HINT_OPEN_QUESTLIST"]      = "Hinweis: Rechtsklick f\195\188r Quest-Liste."
	L["TOOLTIP_HINT_OPEN_QUESTLOG"]       = "Hinweis: Linksklick um das Questlog zu \195\182ffnen."
	L["TOOLTIP_HINT_OPEN_QUESTLOG_SHIFT"] = "Hinweis: Shift + Linksklick um das Questlog zu \195\182ffnen."
	L["TOOLTIP_HINT_WATCHLIST"]           = "Hinweis: Linksklick um die Quest zu verfolgen."
	L["TOOLTIP_HINT_WATCHLIST_SHIFT"]     = "Hinweis: Shift + Linksklick um die Quest zu verfolgen."
	L["TOOLTIP_INCOMPLETE_TEXT"]          = "Nicht abgeschlossene Quests"
	L["TOOLTIP_PVP_TEXT"]                 = "PvP-Quests"
	L["TOOLTIP_QUESTS_TEXT"]              = "Quests insgeamt"
	L["TOOLTIP_RAID_RESET"]               = "Schlachtzugs-Reset"
	L["TOOLTIP_RAID_TEXT"]                = "Schlachtzugs-Quests"
	L["TOOLTIP_REGULAR_TEXT"]             = "Regul\195\164re Quests"
end

--------------------------------------------------------------------------------
-- additional locale operations                                               --
--------------------------------------------------------------------------------
TitanQuests.Locale.InitdeDE = initdeDE