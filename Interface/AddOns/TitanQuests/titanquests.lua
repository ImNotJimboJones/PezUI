--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	TitanQuests::TitanQuests class.

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
local createFrame
local getAddonName
local getArtworkPath
local getAuthor
local getFilter
local getIconName
local getSortOrder
local getTitle
local getTitanPanelID
local getVersion
local init
local isClickBehavior
local isGrouped
local isShowIcon
local isShowLabelText
local setFilter
local setSortOrder
local staticInit
local toggleClickBehavior
local toggleGroupBehavior
local toggleShowIcon
local toggleShowLabelText
-- compositions
local Configuration
local Database
local Dialog
local Locale
local QuestList
local TitanPanelIntegration
local Utilities
local WoWIntegration

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function createFrame()
	TitanQuests.WoWIntegration.CreateFrame()
end

function getAddonName()
	return Configuration.ADDON_NAME
end

function getArtworkPath()
	return Configuration.ARTWORK_PATH
end

function getAuthor()
	return Configuration.AUTHOR
end

function getFilter()
	return Database.Get("filter")
end

function getIconName()
	return Configuration.ICON_NAME
end

function getSortOrder()
	return Database.Get("sort")
end

function getTitle()
	return Configuration.TITLE
end

function getTitanPanelID()
	return Configuration.TITAN_PANEL_ID
end

function getVersion()
	return Configuration.VERSION
end

function init()
	QuestList.Init()
	TitanPanelIntegration.Init()
	WoWIntegration.Init()

	setSortOrder(getSortOrder())
end

function isClickBehavior()
	return Database.Get("clickBehavior")
end

function isGrouped()
	return Database.Get("grouped")
end

function isShowIcon()
	return Database.Get("ShowIcon")
end

function isShowLabelText()
	return Database.Get("ShowLabelText")
end

function setFilter(value)
	Database.Set("filter", value)
end

function setSortOrder(value)
	Database.Set("sort", value)
	QuestList.SetSortOrder(value)
end

function staticInit()
	-- initialize links
	Configuration         = TitanQuests.Configuration
	Database              = TitanQuests.Database
	Dialog                = TitanQuests.Dialog
	Locale                = TitanQuests.Locale
	QuestList             = TitanQuests.QuestList
	TitanPanelIntegration = TitanQuests.TitanPanelIntegration
	Utilities             = TitanQuests.Utilities
	WoWIntegration        = TitanQuests.WoWIntegration

	Configuration.StaticInit()
	Database.StaticInit()
	Locale.StaticInit()
	Dialog.StaticInit() -- must be initialized after locale
	TitanPanelIntegration.StaticInit()
	Utilities.StaticInit()
	WoWIntegration.StaticInit()
end

function toggleClickBehavior()
	Database.Toggle("clickBehavior")
end

function toggleGroupBehavior()
	Database.Toggle("grouped")
end

function toggleShowIcon()
	TitanPanelRightClickMenu_ToggleVar( { getTitanPanelID(), "ShowIcon" } )
end

function toggleShowLabelText()
	TitanPanelRightClickMenu_ToggleVar( { getTitanPanelID(), "ShowLabelText" } )
end

--------------------------------------------------------------------------------
-- namespace                                                                  --
--------------------------------------------------------------------------------
TitanQuests = {}

--------------------------------------------------------------------------------
-- TitanQuests class definition                                               --
--------------------------------------------------------------------------------
TitanQuests.TitanQuests = {
	-- operations
	CreateFrame         = createFrame,
	GetAddonName        = getAddonName,
	GetArtworkPath      = getArtworkPath,
	GetAuthor           = getAuthor,
	GetFilter           = getFilter,
	GetIconName         = getIconName,
	GetSortOrder        = getSortOrder,
	GetTitanPanelID     = getTitanPanelID,
	GetTitle            = getTitle,
	GetVersion          = getVersion,
	Init                = init,
	IsClickBehavior     = isClickBehavior,
	IsGrouped           = isGrouped,
	IsShowIcon          = isShowIcon,
	IsShowLabelText     = isShowLabelText,
	SetFilter           = setFilter,
	SetSortOrder        = setSortOrder,
	StaticInit          = staticInit,
	ToggleClickBehavior = toggleClickBehavior,
	ToggleGroupBehavior = toggleGroupBehavior,
	ToggleShowIcon      = toggleShowIcon,
	ToggleShowLabelText = toggleShowLabelText
}