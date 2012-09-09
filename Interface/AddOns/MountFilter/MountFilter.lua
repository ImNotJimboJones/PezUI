-- initialize AceAddon-3.0 object
MountFilter = LibStub("AceAddon-3.0"):NewAddon(
	"MountFilter", 
	"AceConsole-3.0", 
	"AceEvent-3.0",
	"AceHook-3.0"
)


--============================================================================--
-- Constants
--============================================================================--

-- Name of the Blizzard Mount Journal addon
local MOUNT_JOURNAL_ADDON = "Blizzard_PetJournal"

-- Height (in pixels) of the mount buttons in the Mount Journal
local MOUNT_BUTTON_HEIGHT = 46;

-- Lowest level required by a player to ride a mount
local PLAYER_MOUNT_LEVEL = 20


--============================================================================--
-- Fields
--============================================================================--

-- Debug mode (enables logging)
local debug = false

-- The search box used to filter mounts
local searchBox

-- A list of mount indexes
local mountList


--============================================================================--
-- Methods
--============================================================================--

--------------------------------------------------------------------------------
-- Initializes the search box in the Mount Journal. If the Mount Journal isn't
-- available or the search box already exists, this method will throw an error.
--------------------------------------------------------------------------------
function MountFilter:CreateSearchBox()
	-- Search box already exists?
	if (searchBox) then
		MountFilter:Log("Search box exists... Throwing error")
		error("Search box already exists");
	end
	
	-- No Mount Journal?
	if (not MountJournal) then
		MountFilter:Log("Mount Journal not available... Throwing error")
		error("Mount Journal not available")
	end
	
	-- Create search box
	MountFilter:Log("Creating MountFilter search box...");
	searchBox = CreateFrame("EditBox", "MountFilterSearchBox", MountJournal, "SearchBoxTemplate")
	searchBox:SetPoint("TOPRIGHT", MountJournal, "TOPRIGHT", -20, -35)
	searchBox:SetSize(150, 20)
	
	-- Set callbacks for search box
	searchBox:SetScript("OnTextChanged", 
		function(self, userInput) 
			MountFilter:FilterMounts(self:GetText())
		end
	)
	searchBox:SetScript("OnEnterPressed", 
		function() 
			if (MountFilter:SummonMount()) then
				searchBox:ClearFocus()
				PetJournalParentCloseButton:Click()
			end
		end
	)
end

--------------------------------------------------------------------------------
-- Summons the selected mount. If no mount is selected, or the selected mount
-- is already active, this method will simply short-circuit
-- return: true if the mount was summoned; false if the mount is already active
--------------------------------------------------------------------------------
function MountFilter:SummonMount()
	-- Get selected mount index
	local mountIndex = MountJournal_FindSelectedIndex()
	
	-- No mount selected?
	if (not mountIndex) then
		return false
	end
	
	-- Get mount info
	local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", mountIndex)

	-- Summon mount
	if (not active) then
		MountFilter:Log("Summoning "..creatureName)
		CallCompanion("MOUNT", mountIndex)
		return true
	end
end

--------------------------------------------------------------------------------
-- Creates required function hooks
--------------------------------------------------------------------------------
function MountFilter:CreateHooks()
	-- When mount list updated by Bliz, update it our way
	MountFilter:RawHook("MountJournal_UpdateMountList", "UpdateMountJournal", true)
	
	-- Override Blizzard's MountJournal_Select function to allow deselection
	MountFilter:RawHook("MountJournal_Select", "Select", true)
end

--------------------------------------------------------------------------------
-- Updates the list of mount indexes based on a given search string and updates
-- the Mount Journal.
-- searchString: search string used to filter mount list
--------------------------------------------------------------------------------
function MountFilter:FilterMounts(searchString)
	-- Cope with "Search" text in empty search box
	if (searchString == SEARCH) then 
		searchString = ""
	end
	
	MountFilter:Log("Updating mount list with search string: '"..searchString.."'")
	
	-- Initialize mount list
	mountList = {}
	
	-- Get number of mounts in list
	local mountTotal = GetNumCompanions("MOUNT")
	
	-- For each mount in the parent list...
	for mountIndex=1, mountTotal do
		
		-- Get mount info
		local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", mountIndex)
		
		-- Check for string match
		if (string.find(strlower(creatureName), strlower(searchString))) then
			-- Add mount index to mount list
			table.insert(mountList, mountIndex)
			MountFilter:Log("Match: "..creatureName)
		end
	end
	
	MountFilter:Log("Mount listed updated: "..#mountList.."/"..mountTotal.." mounts")

	-- Update Mount Journal
	MountFilter:UpdateMountJournal()
end

--------------------------------------------------------------------------------
-- Updates the Mount Journal's buttons to reflect the filtered mount list. This
-- method is meant to override MountJournal_UpdateMountList. When called, if the 
-- Mount Journal is not available, or the mount list has not been initialized, 
-- Blizzard's default function will be called.
--------------------------------------------------------------------------------
function MountFilter:UpdateMountJournal()
	MountFilter:Log("Updating Mount Journal...")
	
	-- If Mount Journal not available, call Bliz function
	if (not MountJournal) then
		return self.hooks["MountJournal_UpdateMountList"]()
	end
	
	-- If no mount list, call Bliz function
	if (not mountList) then
		return self.hooks["MountJournal_UpdateMountList"]()
	end
	
	
	local scrollFrame = MountJournal.ListScrollFrame
	local scrollFrameOffset = HybridScrollFrame_GetOffset(scrollFrame)
	local buttons = scrollFrame.buttons
	local mountCount = #mountList
	local playerLevel = UnitLevel("player")
	
	
	-- For each scroll frame button
	for buttonIndex=1, #buttons do
		local button = buttons[buttonIndex]
		local mountIndex = mountList[buttonIndex + scrollFrameOffset]
		
		-- If theres a mount for the button...
		if (mountIndex) then
			-- Get mount info
			local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", mountIndex);
			MountFilter:Log(buttonIndex..": "..creatureName)
			
			-- Set button attributes
			button.name:SetText(creatureName)
			button.icon:SetTexture(icon)
			button.index = mountIndex
			button.spellID = spellID
			button.active = active
			button:SetEnabled(true);
			
			-- If mount active, show active texture
			if (active and playerLevel >= PLAYER_MOUNT_LEVEL) then
				button.DragButton.ActiveTexture:Show()
			else
				button.DragButton.ActiveTexture:Hide()
			end
			
			-- If mount selected, show selected texture
			if (MountJournal.selectedSpellID == spellID) then
				button.selected = true
				button.selectedTexture:Show()
			else
				button.selected = false
				button.selectedTexture:Hide()
			end
			
			-- Ridable...
			if (playerLevel >= PLAYER_MOUNT_LEVEL) then
				button.DragButton:SetEnabled(true)
				button.additionalText = nil
				button.icon:SetDesaturated(false)
				button.icon:SetAlpha(1.0)
				button.name:SetFontObject("GameFontNormal")
				
			-- Not ridable...
			else
				button.DragButton:SetEnabled(false)
				button.additionalText = MOUNT_JOURNAL_CANT_USE
				button.icon:SetDesaturated(true)
				button.icon:SetAlpha(0.5)
				button.name:SetFontObject("GameFontDisable")
			end
			
			-- Show button
			button:Show()
			
			
			-- Update tooltip if needed
			if (button.showingTooltip) then
				MountJournalMountButton_UpdateTooltip(button)
			end
			
		
		-- No mount for button...
		else
			-- Clear button attributes
			button.name:SetText("")
			button.icon:SetTexture("Interface\\PetBattles\\MountJournalEmptyIcon");
			button.index = mountIndex;
			button.spellID = 0;
			button.selected = false;
			button.DragButton.ActiveTexture:Hide();
			button.selectedTexture:Hide();
			button:SetEnabled(false);
			button.DragButton:SetEnabled(false);
			button.icon:SetDesaturated(true);
			button.icon:SetAlpha(0.5);

			-- Hide button
			button:Hide()
		end
	end
	
	-- Set scroll frame height (in pixels)
	local totalHeight = MOUNT_BUTTON_HEIGHT * mountCount
	HybridScrollFrame_Update(scrollFrame, totalHeight, scrollFrame:GetHeight());
	
	-- Update selection
	MountFilter:UpdateSelection()
end

--------------------------------------------------------------------------------
-- Updates the selection in the Mount Journal. If the previous selection is no
-- longer available (filtered out), or there was no previous selection, the first 
-- mount in the list will be selected. If there are no mounts available, the
-- selection will be cleared.
--------------------------------------------------------------------------------
function MountFilter:UpdateSelection()
	MountFilter:Log("Updating Selection...")
	
	-- Get selected mount index
	local selectedMountIndex = MountJournal_FindSelectedIndex()
	
	-- If no previous selection...
	if (not selectedMountIndex) then
	
		-- Mount list empty...
		if (#mountList < 1) then
			-- Do nothing
			MountFilter:Log("No update")
			return
		end
		
		-- Select first mount
		MountFilter:Log("None -> "..mountList[1])
		return MountJournal_Select(mountList[1])
	end
	
	-- If previously selected mount no longer available...
	if (not MountFilter:InMountList(selectedMountIndex)) then
		
		-- If mount list contains a mount, select first
		if (mountList[1]) then
			MountFilter:Log(selectedMountIndex.." -> "..mountList[1])
			MountJournal_Select(mountList[1])
		
		-- Otherwise, clear selection
		else
			MountFilter:Log(selectedMountIndex.." -> None")
			MountJournal_Select(0)
		end
	end
	
	MountFilter:Log("No update")
end

--------------------------------------------------------------------------------
-- Sets the selected mount in the Mount Journal. This method is meant to override 
-- MountJournal_Select in order to add deselection support.
-- mountIndex: index of the mount to select; false to deselect
--------------------------------------------------------------------------------
function MountFilter:Select(mountIndex)
	MountFilter:Log("Selecting "..tostring(mountIndex).."...")
	
	-- Valid selection?
	if (mountIndex and mountIndex >= 1) then
		self.hooks["MountJournal_Select"](mountIndex)
	else
		MountJournal.selectedSpellID = 0;
		MountJournal_UpdateMountList();
		MountJournal_UpdateMountDisplay();
	end
	
	-- If player of appropriate level, hide no mounts message
	if  (UnitLevel("player") >= PLAYER_MOUNT_LEVEL) then
		MountJournal.MountDisplay.NoMounts:Hide();
	end
end

--------------------------------------------------------------------------------
-- Determines if a mount is in the filtered mount list.
-- mountIndex: index of the mount to search for
-- return: true if the mount was found in the mount list; false otherwise
--------------------------------------------------------------------------------
function MountFilter:InMountList(mountIndex)
	MountFilter:Log("Checking mount list for "..tostring(mountIndex).."...")
	-- If mount list not initialized (no filter applied), return true
	if (not mountList) then
		MountFilter:Log("Mount list not initialized... returning true")
		return true
	end
	
	-- Look at ever mount index in the mount list until we find our mount
	for i=1, #mountList do
		if (mountList[i] == mountIndex) then
			MountFilter:Log("Found")
			return true
		end
	end
	
	-- No mount found
	MountFilter:Log("Not Found")
	return false
end

--------------------------------------------------------------------------------
-- Sends a log message to the console, if debug mode is enabled.
-- msg: debug message
--------------------------------------------------------------------------------
function MountFilter:Log(msg)
	if (debug) then
		MountFilter:Print("|cffffe00a<|r|cffff7d0aDebug|r|cffffe00a>|r "..tostring(msg))
	end
end


--============================================================================--
-- Ace functions
--============================================================================--

--------------------------------------------------------------------------------
-- Called when the addon is first loaded by the game client
--------------------------------------------------------------------------------
function MountFilter:OnInitialize()
	MountFilter:Log("Initializing...");
	-- Nothing to do
end

--------------------------------------------------------------------------------
-- Called when the addon is enabled
--------------------------------------------------------------------------------
function MountFilter:OnEnable()
	MountFilter:Log("Enabled...");
	
	-- If Mount Journal addon hasn't been loaded, register an event callback to
	-- call this function when it does load.
	if (not IsAddOnLoaded(MOUNT_JOURNAL_ADDON)) then
		MountFilter:Log("Registering event to call OnEnable() after Mount Journal has loaded");
		MountFilter:RegisterEvent("ADDON_LOADED", 
			function(eventName, addonName)
				if (addonName == MOUNT_JOURNAL_ADDON) then
					MountFilter:Log("Mount Journal Loaded");
					MountFilter:Log("Unregistering ADDON_LOADED callback");
					MountFilter:UnregisterEvent("ADDON_LOADED")
					MountFilter:OnEnable()
				end
			end
		)
		return
	end
	
	-- Create the search box (if needed)
	if (not searchBox) then
		MountFilter:CreateSearchBox()
	end
	
	-- Show search box
	searchBox:Show()
	
	-- Create hooks
	MountFilter:CreateHooks()
end

--------------------------------------------------------------------------------
-- Called when the addon is disabled
--------------------------------------------------------------------------------
function MountFilter:OnDisable()
	MountFilter:Log("Disabled...");
	
	-- Remove all hooks
	MountJournal:UnhookAll()
	
	-- Hide search box
	if (searchBox) then
		searchBox:Hide()
	end
end
