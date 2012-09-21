
--============================================================================--
-- Module Initialization
--============================================================================--

-- Get MountFilter Addon via AceAddon lib
local MF = LibStub("AceAddon-3.0"):GetAddon("MountFilter");

-- Initialize MountFilter module
local Filter = MF:NewModule("Filter");


--============================================================================--
-- Private Fields
--============================================================================--

-- Name of the filter button frame
local FILTER_BUTTON_NAME = MF:GetName() .. "FilterButton";

-- Name of the filter menu frame
local FILTER_MENU_NAME = MF:GetName() .. "FilterMenu";

-- Title of the usable spell filter
local USABLE_SPELL_FILTER = "Only Usable"

-- Spell ID of the "Sea Legs" buff
local SEA_LEGS_SPELL_ID = 73701;

-- Spell ID of the Abyssal Seahorse
local ABYSSAL_SEAHORSE_SPELL_ID = 40054;


-- The button used to show the filter menu
local filterButton = nil;

-- The filter menu
local filterMenu = nil;


--============================================================================--
-- Public Fields
--============================================================================--

-- Options database
Filter.db = nil;

-- Default options
Filter.defaults = {
	char = {
		filter = {
			onlyUsable = false
		}
	}
};

--============================================================================--
-- Methods
--============================================================================--

------------------------------------------------------------
-- Resets the filter to the default settings.
------------------------------------------------------------
function Filter:ResetFilter()
	-- If no DB, do nothing
	if (not (self.db and self.db.char)) then
		return;
	end
	
	-- Reload filter defaults
	self.db.char.filter = self.defaults.char.filter;
	MF:Log("Filter menu reset");
end

------------------------------------------------------------
-- Creates and returns the filter button and menu used in
-- the mount journal. If the mount journal isn't available, 
-- this method will throw an error.
------------------------------------------------------------
function Filter:CreateFilterMenu()
	-- Create filter button
	local filterButton = CreateFrame("Button", FILTER_BUTTON_NAME, nil, "UIMenuButtonStretchTemplate");
	filterButton:SetText(FILTER);
	filterButton:SetSize(93, 22);
	filterButton.rightArrow:Show();
	
	-- Create filter menu
	local filterMenu = CreateFrame("Frame", FILTER_MENU_NAME, filterButton, "UIDropDownMenuTemplate");
	UIDropDownMenu_Initialize(filterMenu, Filter.InitializeFilterMenu, "MENU");
	
	-- Set callbacks for filter button
	filterButton:SetScript("OnClick", 
		function()
			PlaySound("igMainMenuOptionCheckBoxOn");
			ToggleDropDownMenu(1, nil, filterMenu, filterButton, 74, 15);
		end
	);
	
	-- Hook mount journal's OnHide function
	MF:GetMountJournal():HookScript("OnHide", Filter.OnMountJournalHide);
	
	
	-- Return created filter button and menu
	return filterButton, filterMenu;
end

------------------------------------------------------------
-- Sets the menu info for the filter menu at the given level.
-- This method is intended for used in 
-- UIDropDownMenu_Initialize.
-- level:	menu level
------------------------------------------------------------
function Filter:InitializeFilterMenu(level)
	-- Create info table
	local info = UIDropDownMenu_CreateInfo();
	info.keepShownOnClick = true;

	-- First menu level
	if level == 1 then
	
		-- Only Usable filter
		info.text = USABLE_SPELL_FILTER;
		info.func = function(_, _, _, value)
			Filter.db.char.filter.onlyUsable = value;
			MF:UpdateMountList();
		end
		info.disabled = false;
		info.checked = Filter.db.char.filter.onlyUsable;
		info.isNotRadio = true;
		UIDropDownMenu_AddButton(info, level)
	end
end


--============================================================================--
-- Callbacks
--============================================================================--

------------------------------------------------------------
-- Called when the module is first initialized.
------------------------------------------------------------
function Filter:OnInitialize()
	-- Load options
	local AceDB = LibStub("AceDB-3.0");
	self.db = AceDB:New("MountFilter_FilterDB", self.defaults, true);
	MF:Log("Filter DB initialized");
end

------------------------------------------------------------
-- Called when the module is enabled
------------------------------------------------------------
function Filter:OnEnable()
	MF:Log("Filter module enabled");
	
	-- Create the filter menu, if needed
	if (not filterMenu) then
		filterButton, filterMenu = self:CreateFilterMenu();
		MF:Log("Filter menu created");
	end
	
	-- Add the filter button/menu to the mount journal
	MF:AddWidgetToJournal(filterButton);
	
	-- Show filter button/menu
	filterButton:Show();
	
	-- Register filter function
	MF:RegisterFilter("Filter", self.MountFilter);
end

------------------------------------------------------------
-- Called when the module is disabled
------------------------------------------------------------
function Filter:OnDisable()
	MF:Log("Filter module disabled");
	
	-- Hide filter button/menu
	if (filterButton) then
		filterButton:Hide();
	end
	
	-- Unregister filter function
	MF:UnregisterFilter("Filter");
end

------------------------------------------------------------
-- Called when the mount journal is hidden.
-- self:	the mount journal
------------------------------------------------------------
function Filter.OnMountJournalHide(self)
	if (not MF.db.global.resetFilterOnClose) then
		return
	end
	
	-- Reset the search box
	Filter:ResetFilter();
end

------------------------------------------------------------
-- Determines whether a given mount index should be kept or
-- filtered out based on the filters selected in the filter
-- menu.
-- mountIndex:	index of the mount in question
-- return:		true if the specified index should be kept;
-- 				false if it should be filtered out
------------------------------------------------------------
function Filter.MountFilter(mountIndex)
	-- Get mount info
	local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", mountIndex);
	
	-- Filter based on usability?
	if (Filter.db.char.filter.onlyUsable) then
		local usable = IsUsableSpell(spellID);
		
		-- Return false if not usable
		if (not usable) then
			return false;
		end
		
		-- Abyssal Seahorse fix
		local abyssalSeaHorseUsable = UnitBuff("player", GetSpellInfo(SEA_LEGS_SPELL_ID));
		if (creatureID == ABYSSAL_SEAHORSE_SPELL_ID and not abyssalSeaHorseUsable) then
			return false;
		end
	end
	
	-- No filter's failed... return true
	return true;
end