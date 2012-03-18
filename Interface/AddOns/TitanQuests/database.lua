--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	TitanQuests::Database class.

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
-- Database definition                                                        --
--------------------------------------------------------------------------------
--[[
database entires:
	sort          = "level", "location", "title"
	filter        = "all", "dungeon", "elite", "group", "heroic", "pvp", "raid", "regular", "daily", "completed", "incomplete"
	clickBehavior = true/false
	ShowLabelText = true/false -- must be called "ShowLabelText" since it's being used in TitanPanelTemplate.lua: TitanPanelButton_SetButtonText()
	ShowIcon      = true/false -- must be called "ShowLabelText" since it's being used in TitanPanelTemplate.lua: TitanPanelButton_SetComboButtonWidth()
	grouped       = true/false
	version       = integer
]]

--------------------------------------------------------------------------------
-- Declarations                                                               --
--------------------------------------------------------------------------------
-- public functions
local get
local getDefaultList
local set
local staticInit
local toggle
local upgrade
-- private function
local upgradePre30000To30000
-- links
local TitanQuestsBase

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function get(key)
	return TitanGetVar(TitanQuestsBase.GetTitanPanelID(), key)
end

function getDefaultList()
	local defaultlist = {
		sort          = "title",
		filter        = "all",
		clickBehavior = true,
		ShowLabelText = true,
		ShowIcon      = true,
		grouped       = true,
		version       = 30000
	}
	return defaultlist
end

function set(key, value)
	TitanSetVar(TitanQuestsBase.GetTitanPanelID(), key, value)
end

function staticInit()
	TitanQuestsBase = TitanQuests.TitanQuests
end

function toggle(key)
	set(key, not get(key))
end

function upgrade()
	upgradePre30000To30000()
end

function upgradePre30000To30000()
	-- currentVersion is nil, if running for the first time or using a pre
	-- 3.00.00 version
	local currentVersion = get("version")
	if currentVersion and currentVersion >= 30000 then
		return -- already up-to-date
	end

	-- set version number
	set("version", 30000)

	if not TitanPluginSettings[TitanQuestsBase.GetTitanPanelID()] then
		return -- no previous settings, nothing to upgrade
	end

	-- convert values to bool
	set("ShowIcon", not not get("ShowIcon"))
	set("ShowLabelText", not not get("ShowLabelText"))

	-- convert values to bool and rename varialbes
	set("grouped", not not get("GroupBehavior"))
	set("clickBehavior", not not get("ClickBehavior"))

	-- convert sort values
	local sort
	if get("SortByLevel") then
		sort = "level"
	elseif get("SortByLocation") then
		sort = "location"
	elseif get("SortByTitle") then
		sort = "title"
	end
	set("sort", sort)

	-- convert show values
	local filter
	if get("ShowElite") then
		filter = "elite"
	elseif get("ShowGroup") then
		filter = "group"
	elseif get("ShowDungeon") then
		filter = "dungeon"
	elseif get("ShowRaid") then
		filter = "raid"
	elseif get("ShowDungeon") then
		filter = "pvp"
	elseif get("ShowRegular") then
		filter = "regular"
	elseif get("ShowCompleted") then
		filter = "completed"
	elseif get("ShowIncomplete") then
		filter = "incomplete"
	elseif get("ShowAll") then
		filter = "all"
	end
	set("filter", filter)
end

--------------------------------------------------------------------------------
-- Database class definition                                                 --
--------------------------------------------------------------------------------
TitanQuests.Database = {
	-- operations
	Get            = get,
	GetDefaultList = getDefaultList,
	Set            = set,
	StaticInit     = staticInit,
	Toggle         = toggle,
	Upgrade        = upgrade
}