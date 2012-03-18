--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	mxMX localization file

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
local initmxMX

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function initmxMX()
	local L = LibStub("AceLocale-3.0"):NewLocale(TitanQuests.TitanQuests.GetAddonName(), "mxMX")
	if not L then
		return
	end

	L["ABOUT_TEXT"]                       = "Sobre"
	L["ADD_TO_WATCHER_TEXT"]              = "A�adir al visor"
	L["CLICK_BEHAVIOR_TEXT"]              = "Click-Izq para ver los Quest"
	L["GROUP_BEHAVIOR_TEXT"]              = "Quests Ordenada por Grupo"
	L["LEVEL_TEXT"]                       = "Nivel"
	L["LINK_QUEST_TEXT"]                  = "Linkea el Quest"
	L["MEMBERS_ON_QUEST_HEADER"]          = "Miembro del partido en quest"
	L["OPTIONS_TEXT"]                     = "Opciones"
	L["QUEST_DETAILS_OPTIONS_TEXT"]       = "Opciones de Quest"
	L["QUEST_DETAILS_TEXT"]               = "Detalles de Quest"
	L["REMOVE_FROM_WATCHER_TEXT"]         = "Quitar del visor"
	L["REWARDS_HEADER"]                   = "Recompensas"
	L["SHOW_ALL_TEXT"]                    = "Toadas (Defecto)"
	L["SHOW_COMPLETED_TEXT"]              = "solo Completadas"
	L["SHOW_DUNGEON_TEXT"]                = "solo Dungeon"
	L["SHOW_ELITE_TEXT"]                  = "solo Elite"
	L["SHOW_INCOMPLETE_TEXT"]             = "solo Incompletas"
	L["SHOW_PVP_TEXT"]                    = "solo PvP"
	L["SHOW_RAID_TEXT"]                   = "solo Raid"
	L["SHOW_REGULAR_TEXT"]                = "solo Regular"
	L["SHOW_TEXT"]                        = "Mostrar"
	L["SORT_LEVEL_TEXT"]                  = "por Nivel"
	L["SORT_LOCATION_TEXT"]               = "por Sitio"
	L["SORT_TITLE_TEXT"]                  = "por Titulo (Defecto)"
	L["TOOLTIP_COMPLETED_TEXT"]           = "# de quests completados"
	L["TOOLTIP_DUNGEON_TEXT"]             = "# de quests de Dungeon"
	L["TOOLTIP_ELITE_TEXT"]               = "# de quest Elite"
	L["TOOLTIP_HINT_OPEN_QUESTLIST"]      = "Sugerencia: click-derecho para ver la lista de quest."
	L["TOOLTIP_INCOMPLETE_TEXT"]          = "# de quests incompletos"
	L["TOOLTIP_PVP_TEXT"]                 = "# de quests de PvP"
	L["TOOLTIP_QUESTS_TEXT"]              = "# de quests"
	L["TOOLTIP_RAID_TEXT"]                = "# de quests de Raid"
	L["TOOLTIP_REGULAR_TEXT"]             = "# de quests Regulares"
end

--------------------------------------------------------------------------------
-- additional locale operations                                               --
--------------------------------------------------------------------------------
TitanQuests.Locale.InitmxMX = initmxMX