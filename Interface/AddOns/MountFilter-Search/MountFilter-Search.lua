
--============================================================================--
-- Module Initialization
--============================================================================--

-- Get MountFilter Addon via AceAddon lib
local MF = LibStub("AceAddon-3.0"):GetAddon("MountFilter");

-- Initialize MountFilter module
local Search = MF:NewModule("Search");


--============================================================================--
-- Private Fields
--============================================================================--

-- Name of the search box frame
local SEARCH_BOX_NAME = MF:GetName() .. "SearchBox";


--============================================================================--
-- Public Fields
--============================================================================--

-- The search box used to filter mounts
Search.searchBox = nil;


--============================================================================--
-- Methods
--============================================================================--

------------------------------------------------------------
-- Clears the contents of the search box. If the search box
-- isn't available, this method will do nothing.
------------------------------------------------------------
function Search:ClearSearchBox()
	-- If no search box, do nothing
	if (not self.searchBox) then
		return;
	end
	
	-- Clear search box
	self.searchBox:SetText(SEARCH);
	MF:Log("Search box cleared");
end

------------------------------------------------------------
-- Creates and returns a search box for filtering the Mount 
-- Journal's mount list. If the mount journal isn't
-- available, this method will throw an error.
------------------------------------------------------------
function Search:CreateSearchBox()
	-- Create search box
	local searchBox = CreateFrame("EditBox", SEARCH_BOX_NAME, UIParent, "SearchBoxTemplate");
	searchBox:SetSize(150, 22);
	
	-- Set callbacks for search box
	searchBox:SetScript("OnTextChanged", Search.OnTextChanged);
	searchBox:SetScript("OnEnterPressed", Search.OnEnterPressed);
	
	
	-- Hook mount journal's OnHide function
	MF:GetMountJournal():HookScript("OnHide", Search.OnMountJournalHide);
	
	-- Return created search box
	return searchBox;
end


--============================================================================--
-- Callbacks
--============================================================================--

------------------------------------------------------------
-- Called when the module is enabled
------------------------------------------------------------
function Search:OnEnable()
	MF:Log("Search module enabled");
	
	-- Create the search box, if needed
	if (not self.searchBox) then
		self.searchBox = self:CreateSearchBox();
		MF:Log("Search box created");
	end
	
	-- Add search box to the mount journal
	MF:AddWidgetToJournal(self.searchBox);
	
	-- Show search box
	self.searchBox:Show();
	
	-- Register filter function
	MF:RegisterFilter("Search", self.MountFilter);
end

------------------------------------------------------------
-- Called when the module is disabled
------------------------------------------------------------
function Search:OnDisable()
	MF:Log("Search module disabled");
	
	-- Hide search box
	if (self.searchBox) then
		self.searchBox:Hide();
	end
	
	-- Unregister filter function
	MF:UnregisterFilter("Search");
end

------------------------------------------------------------
-- Called when the contents of the search box have changed.
-- self: 		the search box
-- userInput: 	true if the change was due to user input;
--				false otherwise
------------------------------------------------------------
function Search.OnTextChanged(self, userInput)
	MF:Log("Search text changed");
	
	-- Update mount list
	MF:UpdateMountList();
end

------------------------------------------------------------
-- Called when the the 'Enter' key is pressed while the
-- search box has focus.
-- self:	the search box
------------------------------------------------------------
function Search.OnEnterPressed(self)
	MF:Log("Enter pressed");
	if (not MF.db.global.mountOnEnter) then
		return;
	end

	-- Summon mount
	-- If successful, close the MountJournal
	if (MF:SummonMount()) then
		MF:CloseMountJournal();
	end
end

------------------------------------------------------------
-- Called when the mount journal is hidden.
-- self:	the mount journal
------------------------------------------------------------
function Search.OnMountJournalHide(self)
	if (not MF.db.global.resetSearchOnClose) then
		return
	end
	
	-- Reset the search box
	Search:ClearSearchBox();
end

------------------------------------------------------------
-- Determines whether a given mount index should be kept or
-- filtered out based on the current text in the search box.
-- mountIndex:	index of the mount in question
-- return:		true if the specified index should be kept;
-- 				false if it should be filtered out
------------------------------------------------------------
function Search.MountFilter(mountIndex)
	-- Get search string
	local searchString = (Search.searchBox and Search.searchBox:GetText()) or "";
	
	
	-- If empty search string, return true
	if (#searchString < 1 or searchString == SEARCH) then 
		return true;
	end
		
	-- Get mount info
	local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", mountIndex);
		
	-- Check for string match
	return  (string.find(strlower(creatureName), strlower(searchString)))
end
