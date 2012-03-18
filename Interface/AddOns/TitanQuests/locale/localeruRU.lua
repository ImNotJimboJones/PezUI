--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	ruRU localization file

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
local initruRU

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function initruRU()
	local L = LibStub("AceLocale-3.0"):NewLocale(TitanQuests.TitanQuests.GetAddonName(), "ruRU")
	if not L then
		return
	end

	L["ABOUT_AUTHOR_TEXT"]                = "Автор"
	L["ABOUT_TEXT"]                       = "Об аддоне"
	L["ADD_TO_WATCHER_TEXT"]              = "Отслеживать"
	L["BUTTON_LABEL"]                     = "Задания"
	L["CHOOSE_HEADER"]                    = "Выбор"
	L["CLICK_BEHAVIOR_TEXT"]              = "Нажмите ЛКМ, чтобы посмотреть задание"
	L["GROUP_BEHAVIOR_TEXT"]              = "Сортировать задания"
	L["LEVEL_TEXT"]                       = "Уровень"
	L["LINK_QUEST_TEXT"]                  = "Ссылка на задание"
	L["MEMBERS_ON_QUEST_HEADER"]          = "Члены группы на задания"
	L["OPTIONS_TEXT"]                     = "Настройки"
	L["PLAYER_TITLE_TEXT"]                = "Титул игрока"
	L["PREFIX_DUNGEON"]                   = "П"
	L["PREFIX_HEROIC"]                    = "П+"
	L["PREFIX_PVP"]                       = "PvP"
	L["PREFIX_RAID"]                      = "р"
	L["PREFIX_WATCHLIST"]                 = "О"
	L["QUEST_DETAILS_OPTIONS_TEXT"]       = "Настройки задания"
	L["QUEST_DETAILS_TEXT"]               = "Подробности задания"
	L["REMOVE_FROM_WATCHER_TEXT"]         = "Прекратить отслеживать"
	L["REWARDS_HEADER"]                   = "Награды"
	L["SHOW_ALL_TEXT"]                    = "Все (по умолчанию)"
	L["SHOW_COMPLETED_TEXT"]              = "только выполненные"
	L["SHOW_DUNGEON_TEXT"]                = "только подземелье"
	L["SHOW_ELITE_TEXT"]                  = "только элитные"
	L["SHOW_INCOMPLETE_TEXT"]             = "только невыполненные"
	L["SHOW_PVP_TEXT"]                    = "только PvP"
	L["SHOW_RAID_TEXT"]                   = "только рейд"
	L["SHOW_REGULAR_TEXT"]                = "только регулярные"
	L["SHOW_TEXT"]                        = "Показывать"
	L["SORT_LEVEL_TEXT"]                  = "по уровню"
	L["SORT_LOCATION_TEXT"]               = "по местности"
	L["SORT_TEXT"]                        = "Сортировать"
	L["SORT_TITLE_TEXT"]                  = "по названию (по умолчанию)"
	L["TALENT_POINTS_TEXT"]               = "Очки талантов"
	L["TOOLTIP_COMPLETED_TEXT"]           = "Выполненых заданий"
	L["TOOLTIP_DAILY_TEXT"]               = "Ежедневных заданий"
	L["TOOLTIP_DUNGEON_TEXT"]             = "Заданий в Подземелье"
	L["TOOLTIP_ELITE_TEXT"]               = "Элитных Заданий"
	L["TOOLTIP_HINT_OPEN_QUESTLIST"]      = "Подсказка: нажмите ПКМ для отображения списка заданий."
	L["TOOLTIP_INCOMPLETE_TEXT"]          = "Невыполненых заданий"
	L["TOOLTIP_PVP_TEXT"]                 = "PvP заданий"
	L["TOOLTIP_QUESTS_TEXT"]              = "Всего заданий"
	L["TOOLTIP_RAID_TEXT"]                = "Рейдовых заданий"
	L["TOOLTIP_REGULAR_TEXT"]             = "Обычных заданий"
end

--------------------------------------------------------------------------------
-- additional locale operations                                               --
--------------------------------------------------------------------------------
TitanQuests.Locale.InitruRU = initruRU