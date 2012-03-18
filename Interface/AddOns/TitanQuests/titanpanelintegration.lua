--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	TitanQuests::TitanPanelIntegration class.

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
local getButtonText         -- only accessible via global function
local getTooltipText        -- only accessible via global function
local init
local onClick
local onEnter
local prepareRightClickMenu -- only accessible via global function
local staticInit
local syncPluginSettings    -- only accessible via global function 
local updateButtonDisplay
local void                  -- only accessible via global functions
-- private functions
local registerPlugin
-- private attributes
local OrgTitanVariablesSyncPluginSettings
-- links
local Database
local Dialog
local TitanQuestsBase
local TitanQuestsLocale

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function createFrame()
	-- We need a frame which the Titan Quests button is attached to due to
	-- the code in TitanUtils_GetButtonIDFromMenu() which checks whether a
	-- button is a child or a top level button by taking the button's
	-- parent and checking whether a name is specified. If the button's
	-- parent has a name, it is considered being a child button, which would
	-- be incorrect in our case and would result in the
	-- right-click menu not being shown.
	-- Furthermore, we must explicitly set the parent to UIParent since it
	-- does not default to UIParent, if set to nil, which will result in the
	-- button text font being larger than the button text on other titan
	-- panel buttons.
	local frame = CreateFrame("Frame", nil, UIParent)

	-- the button name must be set to:
	-- "TitanPanel"..TitanQuestsBase.GetTitanPanelID().."Button"
	-- otherwise it wouldn't be recognized by TitanPanel
	-- see TitanPanel/TitanUtils.lua: TitanUtils_GetButton()
	-- Furthermore, we can't set the parent to nil, since
	-- otherwise internal functions which call button:GetParent():GetName()
	-- would crash
	-- we can't use UIParent here either, since UIParent:GetName() would
	-- return "UIParent" and cause problems in
	-- TitanUtils_GetButtonIDFromMenu()
	local button = CreateFrame("Button", "TitanPanel"..TitanQuestsBase.GetTitanPanelID().."Button", frame, "TitanPanelComboTemplate")

	registerPlugin(button)

	return button
end

function getButtonText()
	return Dialog.GetButtonText()
end

function getTooltipText()
	return Dialog.GetTooltipText()
end

function init()
	-- activate the proper functions after initialization is complete
	TitanQuests_GetButtonText                  = getButtonText
	TitanQuests_GetTooltipText                 = getTooltipText
	TitanPanelRightClickMenu_PrepareQuestsMenu = prepareRightClickMenu
end

function onClick(frame, button)
	TitanPanelButton_OnClick(frame, button)
end

function onEnter(frame)
	TitanPanelButton_OnEnter(frame)
end

function prepareRightClickMenu()
	Dialog.PrepareRightClickMenu()
end

function registerPlugin(button)
	button.registry = {
		id                  = TitanQuestsBase.GetTitanPanelID(),
		version             = TitanQuestsBase.GetVersion(),
		menuText            = TitanQuestsLocale["MENU_TEXT"],
		buttonTextFunction  = "TitanQuests_GetButtonText",
		tooltipTitle        = TitanQuestsLocale["TOOLTIP"],
		tooltipTextFunction = "TitanQuests_GetTooltipText",
		icon                = TitanQuestsBase.GetArtworkPath()..TitanQuestsBase.GetIconName(),
		iconWidth           = 16,
		savedVariables      = Database.GetDefaultList()
	}
end

function staticInit()
	-- initialize links
	Dialog          = TitanQuests.Dialog
	Database        = TitanQuests.Database
	TitanQuestsBase = TitanQuests.TitanQuests

	TitanQuestsLocale = LibStub("AceLocale-3.0"):GetLocale(TitanQuestsBase.GetAddonName())

	-- hook into TitanPanels sync-variables method to provide db upgrade
	-- functionality
	OrgTitanVariablesSyncPluginSettings = TitanVariables_SyncPluginSettings
	TitanVariables_SyncPluginSettings   = syncPluginSettings
end

function syncPluginSettings()
	Database.Upgrade()
	OrgTitanVariablesSyncPluginSettings()
end

function updateButtonDisplay()
	TitanPanelButton_UpdateButton(TitanQuestsBase.GetTitanPanelID())
	TitanPanelButton_UpdateTooltip()
end

function void()
	-- empty function performing nothing
end

--------------------------------------------------------------------------------
-- TitanPanelIntegration class definition                                     --
--------------------------------------------------------------------------------
TitanQuests.TitanPanelIntegration = {
	-- operations
	CreateFrame         = createFrame,
	Init                = init,
	OnClick             = onClick,
	OnEnter             = onEnter,
	StaticInit          = staticInit,
	UpdateButtonDisplay = updateButtonDisplay
}

--------------------------------------------------------------------------------
-- globals used for TitanPanel itnegration                                    --
--------------------------------------------------------------------------------
-- we have to use globals here rather than TitanQuests.TitanPanelIntegration.xxx
-- because TitanPanel accessing these functions using _G[]
TitanQuests_GetButtonText                  = void -- in TitanPanelTemplate.lua: TitanPanelButton_SetTooltip
TitanQuests_GetTooltipText                 = void -- in TitanPanelTemplate.lua: TitanPanelButton_SetButtonText
TitanPanelRightClickMenu_PrepareQuestsMenu = void -- in TitanUtils.lua: TitanRightClickMenu_OnLoad