--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	TitanQuests::WoWIntegration class.

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
local init
local staticInit
-- private functions
local onClick
local onEnter
local onEvent
local onInitEvent
-- private attributes
local Button
-- links
local Dialog
local QuestList
local TitanPanelIntegration
local TitanQuestsBase

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function createFrame()
	-- we can't use the onLoad script handler here, because onLoad is called
	-- during the CreateFrame() call; hence we perform the onLoad
	-- functionality in registerFrame()
	-- see http://www.wowwiki.com/API_CreateFrame

	Button = TitanPanelIntegration.CreateFrame()

	Button:RegisterEvent("PLAYER_ENTERING_WORLD")

	Button:SetScript("OnEvent", onInitEvent)
	Button:SetScript("OnEnter", onEnter)
	Button:SetScript("OnClick", onClick)
end

function init()
	-- replace the event hooks (switch the handling from initial initialization to
	-- the active event handling)
	Button:UnregisterEvent("PLAYER_ENTERING_WORLD")
	Button:RegisterEvent("QUEST_LOG_UPDATE")
	Button:SetScript("OnEvent", onEvent)
end

function onClick(frame, button)
	Dialog.OnClick(frame, button)
	TitanPanelIntegration.OnClick(frame, button)
end

function onEnter(frame)
	TitanPanelIntegration.OnEnter(frame)
end

function onEvent()
	-- we have to update the questlist on every update-event, since we need
	-- the accurate number of quests for the TitanQuest's buttontext (max
	-- number as well as number of completed quests) and each of the
	-- QUEST_LOG_UPDATE event could change the state of a quest from
	-- complete to incomplete
	-- furthermore, we need to work with the QUEST_LOG_UPDATE event since
	-- this is the only event which can be used to be reliably used for
	-- quest progress (according to wowwiki the QUEST_PROGRESS event is only
	-- thrown when progressing a quest by talking to an NPC, not by killing
	-- a quest target which might also change the quest state from
	-- incomplete to complete)
	-- we just flag the questlist dirty here rather than updating the
	-- questlist directly, since QUEST_LOG_UPDATE events are thrown
	-- rather often and this would result in unnecessary questlist updates
	QuestList.FlagDirty()
	
	-- update the button text, since a number of complete/total quests
	-- could have been changed
	TitanPanelIntegration.UpdateButtonDisplay()
end

function onInitEvent()
	TitanQuestsBase.Init()
end

function staticInit()
	-- initialize links
	Dialog                = TitanQuests.Dialog
	TitanPanelIntegration = TitanQuests.TitanPanelIntegration
	TitanQuestsBase       = TitanQuests.TitanQuests
	QuestList             = TitanQuests.QuestList
end

--------------------------------------------------------------------------------
-- WoWIntegration class definition                                            --
--------------------------------------------------------------------------------
TitanQuests.WoWIntegration = {
	-- operations
	CreateFrame = createFrame,
	Init        = init,
	StaticInit  = staticInit
}