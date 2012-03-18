--[[
	Titan Panel [Quests] for World of Warcraft(tm).

	TitanQuests::Configuration class.

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
local staticInit

--------------------------------------------------------------------------------
-- Function definitions                                                       --
--------------------------------------------------------------------------------
function staticInit()
	TitanQuests.Configuration.ADDON_NAME     = "TitanQuests"
	TitanQuests.Configuration.ARTWORK_PATH   = "Interface\\AddOns\\TitanQuests\\artwork\\"
	TitanQuests.Configuration.AUTHOR         = GetAddOnMetadata(TitanQuests.Configuration.ADDON_NAME, "Author")
	TitanQuests.Configuration.ICON_NAME      = "titanquests"
	-- we do not change this to ADDON_NAME, since otherwise Titan Panel
	-- would remain two db-tables (one for previous Titan Quests releases
	-- using the "Quests" identifier and one for new Titan Quests releases
	-- using the "TitanQuests" identifier)
	TitanQuests.Configuration.TITAN_PANEL_ID = "Quests"
	TitanQuests.Configuration.TITLE          = GetAddOnMetadata(TitanQuests.Configuration.ADDON_NAME, "Title")
	TitanQuests.Configuration.VERSION        = GetAddOnMetadata(TitanQuests.Configuration.ADDON_NAME, "Version")
end

--------------------------------------------------------------------------------
-- Configuration class definition                                             --
--------------------------------------------------------------------------------
TitanQuests.Configuration = {
	-- attributes
	ADDON_NAME,
	ARTWORK_PATH,
	AUTHOR,
	ICON_NAME,
	TITAN_PANEL_ID,
	TITLE,
	VERSION,

	-- operations
	StaticInit = staticInit
}
