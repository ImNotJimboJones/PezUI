--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	frFR localization file

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
local initfrFR

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function initfrFR()
	local L = LibStub("AceLocale-3.0"):NewLocale(TitanQuests.TitanQuests.GetAddonName(), "frFR")
	if not L then
		return
	end
 
	L["ABOUT_AUTHOR_TEXT"]           = "Author"
	L["ABOUT_TEXT"]                  = "A propos"
	L["ADD_TO_WATCHER_TEXT"]         = "Ajouter \195\160 la surveillance"
	L["BUTTON_LABEL"]                = "Qu\195\170tes"
	L["LEVEL_TEXT"]                  = "Level"
	L["LINK_QUEST_TEXT"]             = "Lier la qu\195\170te"
	L["MEMBERS_ON_QUEST_HEADER"]     = "Membre du parti dans qu\195\170tes"
	L["MENU_TEXT"]                   = "Qu\195\170tes"
	L["OPTIONS_TEXT"]                = "Options"
	L["QUEST_DETAILS_OPTIONS_TEXT"]  = "Quest Options"
	L["QUEST_DETAILS_TEXT"]          = "D\195\168tails de la qu\195\170te"
	L["REMOVE_FROM_WATCHER_TEXT"]    = "Enlever de la surveillance"
	L["REWARDS_HEADER"]              = "Prix"
	L["SHOW_ALL_TEXT"]               = "Tout (D\195\168faut)"
	L["SHOW_COMPLETED_TEXT"]         = "seulement Compl\195\168t\195\168es"
	L["SHOW_DUNGEON_TEXT"]           = "seulement Donjons"
	L["SHOW_ELITE_TEXT"]             = "seulement Elites"
	L["SHOW_GROUP_TEXT"]             = "seulement Groups"
	L["SHOW_INCOMPLETE_TEXT"]        = "seulement Non Compl\195\168t\195\168es"
	L["SHOW_PVP_TEXT"]               = "seulement JcJ"
	L["SHOW_RAID_TEXT"]              = "seulement Raids"
	L["SHOW_REGULAR_TEXT"]           = "seulement Normales"
	L["SHOW_TEXT"]                   = "Afficher"
	L["SORT_LEVEL_TEXT"]             = "par Niveau"
	L["SORT_LOCATION_TEXT"]          = "par Localisation"
	L["SORT_TEXT"]                   = "Trier"
	L["SORT_TITLE_TEXT"]             = "Par Titre (D\195\168faut)"
	L["TIMESTRING"]                  = "%X"
	L["TOOLTIP"]                     = "Infos Qu\195\170tes"
	L["TOOLTIP_COMPLETED_TEXT"]      = "# de qu\195\170tes actuellement termin\195\168es"
	L["TOOLTIP_DUNGEON_TEXT"]        = "# de qu\195\170tes Donjon"
	L["TOOLTIP_ELITE_TEXT"]          = "# de qu\195\170tes Elite"
	L["TOOLTIP_GROUP_TEXT"]          = "# de qu\195\170\tes Group"
	L["TOOLTIP_HINT_OPEN_QUESTLIST"] = "Astuce: Clic-droit pour la liste des qu\195\170tes."
	L["TOOLTIP_INCOMPLETE_TEXT"]     = "# de qu\195\170tes non actuellement termin\195\168es"
	L["TOOLTIP_PVP_TEXT"]            = "# de qu\195\170tes JcJ"
	L["TOOLTIP_QUESTS_TEXT"]         = "# de qu\195\170tes"
	L["TOOLTIP_RAID_TEXT"]           = "# de qu\195\170tes Raid"
	L["TOOLTIP_REGULAR_TEXT"]        = "# de qu\195\170tes normales"
end


--------------------------------------------------------------------------------
-- additional locale operations                                               --
--------------------------------------------------------------------------------
TitanQuests.Locale.InitfrFR = initfrFR