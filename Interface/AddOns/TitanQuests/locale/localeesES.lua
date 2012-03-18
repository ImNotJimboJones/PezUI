--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	esES localization file

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
local initesES

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function initesES()
	local L = LibStub("AceLocale-3.0"):NewLocale(TitanQuests.TitanQuests.GetAddonName(), "esES")
	if not L then
		return
	end

	L["ABOUT_TEXT"]                       = "Acerca de..."
	L["ADD_TO_WATCHER_TEXT"]              = "Añadir al Tracker"
	L["BUTTON_LABEL"]                     = "Misiones"
	L["CLICK_BEHAVIOR_TEXT"]              = "Click-Izq para ver la Misión"
	L["GROUP_BEHAVIOR_TEXT"]              = "Quests Ordenadas por Grupos"
	L["LEVEL_TEXT"]                       = "Nivel"
	L["LINK_QUEST_TEXT"]                  = "Linkea la Misión"
	L["MEMBERS_ON_QUEST_HEADER"]          = "Miembros del grupo haciendo la misión"
	L["OPTIONS_TEXT"]                     = "Opciones"
	L["QUEST_DETAILS_OPTIONS_TEXT"]       = "Opciones de la Misión"
	L["QUEST_DETAILS_TEXT"]               = "Detalles de la Misión"
	L["REMOVE_FROM_WATCHER_TEXT"]         = "Quitar del Tracker"
	L["REWARDS_HEADER"]                   = "Recompensas"
	L["SHOW_ALL_TEXT"]                    = "Todas (por defecto)"
	L["SHOW_COMPLETED_TEXT"]              = "sólo Completadas"
	L["SHOW_DUNGEON_TEXT"]                = "sólo Mazmorra"
	L["SHOW_ELITE_TEXT"]                  = "sólo Elite"
	L["SHOW_INCOMPLETE_TEXT"]             = "sólo Incompletas"
	L["SHOW_PVP_TEXT"]                    = "sólo PvP"
	L["SHOW_RAID_TEXT"]                   = "sólo Banda"
	L["SHOW_REGULAR_TEXT"]                = "sólo Normales"
	L["SHOW_TEXT"]                        = "Mostrar"
	L["SORT_LEVEL_TEXT"]                  = "por Nivel"
	L["SORT_LOCATION_TEXT"]               = "por Lugar"
	L["SORT_TEXT"]                        = "Ordenar"
	L["SORT_TITLE_TEXT"]                  = "por Título (por defecto)"
	L["TOOLTIP_COMPLETED_TEXT"]           = "Misiones Completadas"
	L["TOOLTIP_DAILY_TEXT"]               = "Misiones Diarias"
	L["TOOLTIP_DUNGEON_TEXT"]             = "Misiones de Mazmorra"
	L["TOOLTIP_ELITE_TEXT"]               = "Misiones Elite"
	L["TOOLTIP_HINT_OPEN_QUESTLIST"]      = "Consejo: click-derecho para ver la lista de misiones."
	L["TOOLTIP_INCOMPLETE_TEXT"]          = "Misiones Incompletas"
	L["TOOLTIP_PVP_TEXT"]                 = "Misiones PvP"
	L["TOOLTIP_QUESTS_TEXT"]              = "Total de misiones"
	L["TOOLTIP_RAID_TEXT"]                = "Misiones de Banda"
	L["TOOLTIP_REGULAR_TEXT"]             = "Misiones Normales"
end

--------------------------------------------------------------------------------
-- additional locale operations                                               --
--------------------------------------------------------------------------------
TitanQuests.Locale.InitesES = initesES