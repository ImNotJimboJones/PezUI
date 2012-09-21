
--============================================================================--
-- Addon Initialization
--============================================================================--

-- initialize AceAddon object
local MF = LibStub("AceAddon-3.0"):NewAddon(
	"MountFilter", 
	"AceConsole-3.0", 
	"AceEvent-3.0",
	"AceHook-3.0",
	"AceTimer-3.0"
);

-- Set default state to disabled
MF:SetDefaultModuleState(false);


--============================================================================--
-- Private Fields
--============================================================================--

-- Slash commands
local SLASH_COMMANDS = {
	"mountfilter",
	"mf"
};

-- Name of the Blizzard Mount Journal addon
local MOUNT_JOURNAL_ADDON = "Blizzard_PetJournal";

-- Height (in pixels) of the mount buttons in the Mount Journal
local MOUNT_BUTTON_HEIGHT = 46;

-- Lowest level required by a player to ride a mount
local MINIMUM_MOUNT_LEVEL = 20;


-- Name of Blizzard's function to update the mount journal's mount list
local JOURNAL_UPDATE_FUNC = "MountJournal_UpdateMountList";

-- Name of Blizzard's function to select a mount in the mount journal
local MOUNT_SELECT_FUNC = "MountJournal_Select";

-- Name of Blizzard's function to update the mount display in the mount journal
local UPDATE_MOUNT_DISPLAY_FUNC = "MountJournal_UpdateMountDisplay";

-- Name of Blizzard's callback called when a scroll frame has been scrolled
local ON_SCROLL_FRAME_VALUE_CHANGED_FUNC = "HybridScrollFrame_OnValueChanged";


-- Width of the mount journal's mount count frame
local MOUNT_COUNT_WIDTH = 130;


-- Margin between widgets placed on the mount journal
local WIDGET_MARGIN = 5;

-- Horizontal offset of next widget placed on the mount journal
local widgetOffset = 20;


-- Delay between automatic mount list updates
local UPDATE_TIMER_DELAY = 2;

-- Timer used to update the mount journal
local updateTimer = nil;


-- List of filtered mount indexes
local mountList = nil;

-- List of mount filter functions
local filters = {};


-- Number of times the mount list has been updated (for debugging)
local updateCount = 0;

--============================================================================--
-- Public Fields
--============================================================================--

-- Options database
MF.db = nil;

-- Default options
MF.defaults = {
	global = {
		debug = false,
		mountOnEnter = true,
		resetSearchOnClose = false,
		resetFilterOnClose = false,
		mountCountStyle = 1
	}
};


--============================================================================--
-- Accessors
--============================================================================--

------------------------------------------------------------
-- Returns the addon's slash commands.
-- return: the slash commands 
------------------------------------------------------------
function MF:GetSlashCommands()
	return SLASH_COMMANDS;
end

------------------------------------------------------------
-- Returns a reference to the Mount Journal.
-- return: 	the Mount Journal; nil if the Mount Journal 
-- 			isn't available
------------------------------------------------------------
function MF:GetMountJournal()
	return MountJournal;
end


--============================================================================--
-- Methods
--============================================================================--

------------------------------------------------------------
-- Adds a mount filter widget to the mount journal. If the
-- mount journal isn't available, an error will be thrown.
-- widget:	the widget
------------------------------------------------------------
function MF:AddWidgetToJournal(widget)
	-- No mount journal?
	if (not MountJournal) then
		error("Mount journal not available");
	end
	
	-- No widget?
	if (not widget) then
		return
	end
	
	
	-- Set widget parent
	widget:SetParent(MountJournal);
	
	-- Set widget point
	local vOffset = 21.5 + (widget:GetHeight() / 2);
	local hOffset = widgetOffset;
	widget:SetPoint("TOPRIGHT", MountJournal, "TOPRIGHT", -hOffset, -vOffset);
	
	-- Update widget offset
	widgetOffset = widgetOffset + widget:GetWidth() + WIDGET_MARGIN;
	MF:Log("Added ".. tostring(widget:GetName()) .." to mount journal");
end

------------------------------------------------------------
-- Determines whether a mount filter function has been
-- registered with a given name.
-- name:	the name
------------------------------------------------------------
function MF:IsFilterRegistered(name)
	return filters[name];
end

------------------------------------------------------------
-- Registers a mount filter function.
-- name:	a name with which the function will be registered
-- filter: 	the filter function
------------------------------------------------------------
function MF:RegisterFilter(name, filter)
	-- Verify name is string
	if (type(name) ~= "string") then
		error("Expected string for argument: name");
	end
	
	-- Verify filter is a function
	if (type(filter) ~= "function") then
		error("Expected function for argument: filter");
	end
	
	-- Filter already registered for given name?
	if (self:IsFilterRegistered(name)) then
		error("Filter already registered for given name: "..name);
	end
	
	-- Add the filter to the filter registry
	filters[name] = filter;
	MF:Log("Registered filter: "..name);
end

------------------------------------------------------------
-- Removes a registered filter function.
-- name:	the name with which the filter function was
-- 			registered
------------------------------------------------------------
function MF:UnregisterFilter(name)
	-- Verify name is string
	if (type(name) ~= "string") then
		error("Expected string for argument: name");
	end
	
	-- If no filter registered with given name, do nothing
	if (not filters[name]) then
		return;
	end
		
	-- Remove filter from registry
	filters[name] = nil;
	MF:Log("Unregistered filter: "..name);
end

------------------------------------------------------------
-- Closes the Mount Journal. If the Mount Journal is not
-- visible, this method will do nothing.
------------------------------------------------------------
function MF:CloseMountJournal()
	if (MountJournal and MountJournal:IsVisible()) then
		PetJournalParentCloseButton:Click();
	end
end

------------------------------------------------------------
-- Summons the selected mount. If no mount is selected, or 
-- the selected mount is already active, this method will 
-- simply short-circuit return: true if the mount was 
-- summoned; false if the mount is already active
------------------------------------------------------------
function MF:SummonMount()
	-- Get selected mount index
	local mountIndex = MountJournal_FindSelectedIndex();
	
	-- No mount selected?
	if (not mountIndex) then
		return false;
	end
	
	-- Get mount info
	local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", mountIndex);

	-- Selected mount already active?
	if (active) then
		return false;
	end

	-- Summon mount
	MF:Log("Summoning "..creatureName);
	CallCompanion("MOUNT", mountIndex);
	return true;
end

------------------------------------------------------------
-- Updates the filtered list of mounts.
------------------------------------------------------------
function MF:UpdateMountList()
	MF:Log("Updating mount list...");
	
	-- Increment counter
	updateCount = updateCount + 1;
	
	-- Get total number of mounts
	local mountTotal = GetNumCompanions("MOUNT");
	
	-- Initialize new mount list
	local newMountList = {};
	
	-- For every mount...
	for mountIndex=1, mountTotal do
	
		-- For every filter...
		local keep = true;
		for filterName, filter in pairs(filters) do
		
			-- Apply filter
			local result = filter(mountIndex);
			
			-- If failed, break out of loop
			if (not result) then
				keep = false;
				break;
			end
		end
		
		-- Add to new mount list?
		if (keep) then
			table.insert(newMountList, mountIndex);
		end
		
	end
	
	-- Replace old mount list with new
	mountList = newMountList;
	MF:Log("Mount list updated("..updateCount.."): "..#mountList.."/"..mountTotal.." mounts");
	
	-- Update mount journal
	self:UpdateMountJournal();
end

------------------------------------------------------------
-- Determines if a mount is in the filtered mount list.
-- mountIndex: index of the mount to search for
-- return: 	true if the mount was found in the mount list; 
-- 			false otherwise
------------------------------------------------------------
function MF:InMountList(mountIndex)
	-- Look at every mount index in the mount list until we find our mount
	for i=1, #mountList do
		if (mountList[i] == mountIndex) then
			return true;
		end
	end
	
	-- No mount found
	return false;
end

------------------------------------------------------------
-- Creates required function hooks.
------------------------------------------------------------
function MF:CreateHooks()
	MF:Log("Creating hooks...");
	-- When Bliz tries to update the mount journal, update it our way
	self:RawHook(JOURNAL_UPDATE_FUNC, MF.UpdateMountJournal, true);
	
	-- Override Blizzard's mount button select function to allow deselection
	self:RawHook(MOUNT_SELECT_FUNC, function(mountIndex) self:Select(mountIndex) end, true);
	
	-- Hook to HybridScrollFrame's OnValueChanged function so we can update the 
	-- scroll frame's buttons after the offset has changed
	self:SecureHook(ON_SCROLL_FRAME_VALUE_CHANGED_FUNC, MF.OnScrollFrameValueChanged);
	
	-- Hook to Blizzard's mount display update function
	-- so we can hide the "no mount" message if needed
	self:SecureHook(UPDATE_MOUNT_DISPLAY_FUNC, MF.OnUpdateMountDisplay);
	
	-- Hook to the mount journal's show/hide events
	MountJournal:HookScript("OnShow", MF.OnMountJournalShow);
	MountJournal:HookScript("OnHide", MF.OnMountJournalHide);
end

------------------------------------------------------------
-- Sends a log message to the console, if debug mode is 
-- enabled.
-- msg:	debug message
------------------------------------------------------------
function MF:Log(msg)
	if (self.db and self.db.global.debug) then
		self:Print("|cffffe00a<|r|cffff7d0aDebug|r|cffffe00a>|r "..tostring(msg));
	end
end


--============================================================================--
-- Callbacks
--============================================================================--

------------------------------------------------------------
-- Called when the addon is first initialized.
------------------------------------------------------------
function MF:OnInitialize()
	-- Load options
	local AceDB = LibStub("AceDB-3.0");
	self.db = AceDB:New("MountFilterDB", self.defaults, true);
	MF:Log("MountFilter DB Initialized");
end

------------------------------------------------------------
-- Called when the addon is enabled.
------------------------------------------------------------
function MF:OnEnable()
	-- If mount journal addon hasn't been loaded, register an event callback to
	-- call this function when it does load.
	if (not IsAddOnLoaded(MOUNT_JOURNAL_ADDON)) then
		MF:Log("Registering event to call OnEnable() after mount journal has loaded");
		self:RegisterEvent("ADDON_LOADED", 
			function(eventName, addonName)
				if (addonName == MOUNT_JOURNAL_ADDON) then
					MF:Log("Mount journal Loaded");
					self:UnregisterEvent("ADDON_LOADED");
					self:OnEnable();
				end
			end
		);
		return;
	end
	
	MF:Log("Addon Enabled");


	-- Create hooks
	self:CreateHooks();
	
	-- Enable modules
	MF:Log("Enabling modules...");
	local modules = self.orderedModules;
	for i, module in pairs(self.orderedModules) do
		module:Enable();
	end
	
	-- Update mount list
	self:UpdateMountList();
end

------------------------------------------------------------
-- Called when the addon is disabled
------------------------------------------------------------
function MF:OnDisable()
	-- Disable modules
	local modules = self.orderedModules;
	for i, module in pairs(self.orderedModules) do
		module:Enable();
	end

	-- Remove all hooks
	self:UnhookAll();
end


--============================================================================--
-- Hooks and Overrides
--============================================================================--

------------------------------------------------------------
-- Updates the Mount Journal's buttons to reflect the 
-- filtered mount list. This method is meant to override 
-- MountJournal_UpdateMountList. When called, if the mount
-- journal isn't available Blizzard's default function will
-- be called.
------------------------------------------------------------
function MF:UpdateMountJournal()
	MF:Log("Updating Mount Journal...");
	
	-- If Mount Journal not available, call Bliz function
	if (not MountJournal) then
		MF:Log("Mount Journal not available... calling "..JOURNAL_UPDATE_FUNC);
		return MF.hooks[JOURNAL_UPDATE_FUNC]();
	end
	
	-- If no mount list, call Bliz function
	if (not mountList) then
		MF:Log("mountList not initialized... calling "..JOURNAL_UPDATE_FUNC);
		return MF.hooks[JOURNAL_UPDATE_FUNC]();
	end
	
	
	local scrollFrame = MountJournal.ListScrollFrame;
	local scrollFrameOffset = HybridScrollFrame_GetOffset(scrollFrame);
	local buttons = scrollFrame.buttons;
	local mountCount = #mountList;
	local playerLevel = UnitLevel("player");
	
	
	-- For each scroll frame button
	for buttonIndex=1, #buttons do
		local button = buttons[buttonIndex];
		local mountIndex = mountList[buttonIndex + scrollFrameOffset];
		
		-- If theres a mount for the button...
		if (mountIndex) then
		
			-- Get mount info
			local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", mountIndex);
			--MF:Log(buttonIndex..": "..creatureName);
			
			-- Set button attributes
			button.name:SetText(creatureName);
			button.icon:SetTexture(icon);
			button.index = mountIndex;
			button.spellID = spellID;
			button.active = active;
			button:SetEnabled(true);
			
			-- If ridable and active, show active texture
			if (active and playerLevel >= MINIMUM_MOUNT_LEVEL) then
				button.DragButton.ActiveTexture:Show();
			else
				button.DragButton.ActiveTexture:Hide();
			end
			
			-- If mount selected, show selected texture
			if (MountJournal.selectedSpellID == spellID) then
				button.selected = true;
				button.selectedTexture:Show();
			else
				button.selected = false;
				button.selectedTexture:Hide();
			end
			
			-- Ridable...
			if (playerLevel >= MINIMUM_MOUNT_LEVEL) then
				button.DragButton:SetEnabled(true);
				button.additionalText = nil;
				button.icon:SetDesaturated(false);
				button.icon:SetAlpha(1.0);
				button.name:SetFontObject("GameFontNormal");
				
			-- Not ridable...
			else
				button.DragButton:SetEnabled(false);
				button.additionalText = MOUNT_JOURNAL_CANT_USE;
				button.icon:SetDesaturated(true);
				button.icon:SetAlpha(0.5);
				button.name:SetFontObject("GameFontDisable");
			end
			
			
			-- Show button
			button:Show();
			
			
			-- Update tooltip if needed
			if (button.showingTooltip) then
				MountJournalMountButton_UpdateTooltip(button);
			end
			
		
		-- No mount for button...
		else
			-- Clear button attributes
			button.name:SetText("");
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
			button:Hide();
		end
	end
	
	-- Set scroll frame height (in pixels)
	local totalHeight = MOUNT_BUTTON_HEIGHT * mountCount;
	HybridScrollFrame_Update(scrollFrame, totalHeight, scrollFrame:GetHeight());
	
	-- Update mount count text
	MF:UpdateMountCount();
	
	-- Update selection
	MF:UpdateSelection();
	
	MF:Log("Mount Journal Updated");
end

------------------------------------------------------------
-- Updates the mount total listed in the mount journal.
------------------------------------------------------------
function MF:UpdateMountCount()
	-- Get display style
	local displayStyle = self.db.global.mountCountStyle or 1;

	-- Get total number of mounts
	local totalMounts = GetNumCompanions("MOUNT");
	
	if (displayStyle == 1) then
		MountJournal.MountCount:SetWidth(MOUNT_COUNT_WIDTH);
		MountJournal.MountCount.Count:SetText(#mountList);
		
	elseif (displayStyle == 2) then
		MountJournal.MountCount:SetWidth(MOUNT_COUNT_WIDTH + 25);
		MountJournal.MountCount.Count:SetText(#mountList.."/"..totalMounts);
	
	elseif (displayStyle == 3) then
		MountJournal.MountCount:SetWidth(MOUNT_COUNT_WIDTH);
		MountJournal.MountCount.Count:SetText(totalMounts);
	end
	
	MF:Log("Mount count updated (style "..displayStyle..")");
end

------------------------------------------------------------
-- Updates the selection in the mount journal. If the 
-- previous selection is no longer available (filtered out), 
-- or there was no previous selection, the first mount in 
-- the list will be selected. If there are no mounts 
-- available, the selection will be cleared.
------------------------------------------------------------
function MF:UpdateSelection()
	-- Get selected mount index
	local selectedMountIndex = MountJournal_FindSelectedIndex();
	
	-- If no previous selection...
	if (not selectedMountIndex) then
	
		-- If mount list empty, do nothing
		if (#mountList < 1) then
			return;
		end
		
		-- Select first mount
		self:Select(mountList[1]);
		return
	end
	
	-- If previously selected mount no longer available...
	if (not self:InMountList(selectedMountIndex)) then
		
		-- If mount list contains a mount, select first
		if (mountList[1]) then
			self:Select(mountList[1]);
		
		-- Otherwise, clear selection
		else
			self:Select(0);
		end
	end
end

------------------------------------------------------------
-- Selects a specified mount in the mount journal. This 
-- method is meant to override MountJournal_Select in order 
-- to add deselection support. 
-- self:		the scroll frame
-- mountIndex:	index of the mount to select; false to deselect
------------------------------------------------------------
function MF:Select(mountIndex)
	MF:Log("Selecting "..tostring(mountIndex).."...");
	
	-- Valid selection?
	if (mountIndex and mountIndex >= 1) then
		self.hooks[MOUNT_SELECT_FUNC](mountIndex);
	else
		MountJournal.selectedSpellID = 0;
		MountJournal_UpdateMountList();
		MountJournal_UpdateMountDisplay();
	end
end

------------------------------------------------------------
-- Hides the "no mounts" message in the mount display. This 
-- method is meant to be called after the the mount 
-- journal's mount display has been updated.
------------------------------------------------------------
function MF.OnUpdateMountDisplay()
	MF:Log("Bliz updated mount display");
	if  (UnitLevel("player") >= MINIMUM_MOUNT_LEVEL) then
		MountJournal.MountDisplay.NoMounts:Hide();
	end
end

------------------------------------------------------------
-- Ensures that the mount journal is updated (our way)
-- whenever the mount journal's scroll frame is scrolled.
-- self:	the scroll frame
-- value:	scroll value
------------------------------------------------------------
function MF.OnScrollFrameValueChanged(self, value)
	-- if self isn't the mount journal's scroll frame, do nothing
	if (self ~= MountJournal.ListScrollFrame) then
		return;
	end

	MF:Log("Mount journal's scroll frame value changed");
	
	-- Update mount journal
	MF:UpdateMountJournal();
end

------------------------------------------------------------
-- Ensures that the mount journal is updated (our way)
-- whenever the mount journal is loaded, and creates a timer
-- to continue updating it periodically.
------------------------------------------------------------
function MF.OnMountJournalShow()
	MF:Log("Mount journal opened");
	
	-- Update mount list
	MF:UpdateMountList();

	-- Schedule timer to periodically update the mount list 
	updateTimer = MF:ScheduleRepeatingTimer(
		function()
			MF:Log("Auto-update timer fired");
			MF:UpdateMountList();
		end,
		UPDATE_TIMER_DELAY
	);
	MF:Log("Auto-update timer registered");
end

------------------------------------------------------------
-- Removes the mount list update timer.
------------------------------------------------------------
function MF.OnMountJournalHide()
	MF:Log("Mount journal opened");
	
	-- Cancel mount list update timer
	local timerCanceled = MF:CancelTimer(updateTimer, true);
	if (timerCanceled) then
		MF:Log("Auto-update timer canceled");
	else
		MF:CancelAllTimers();
		error("Failed to cancel auto-update timer (all timers canceled as result)");
	end
end
