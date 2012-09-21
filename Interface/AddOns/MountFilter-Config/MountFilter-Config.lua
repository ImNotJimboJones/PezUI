
--============================================================================--
-- Module Initialization
--============================================================================--

-- Get MountFilter Addon via AceAddon lib
local MF = LibStub("AceAddon-3.0"):GetAddon("MountFilter");

-- Initialize MountFilter module
local Config = MF:NewModule("Config");


-- Define function for automated order numbers
local order = -1;
local function Order()
	order = order + 1;
	return order;
end

-- Define options table
Config.options = {
	type = "group",
	args = {
	
		-- Addon Description
		description = {
			order = Order(),
			type = "description",
			name = MF:GetName() .. " is a simple addon that adds filtering capabilies to the Mount Journal. Hopefully, more filters features will be available in the near future!",
		},
		
		-- Option Header
		optionsHeader = {
			order = Order(),
			type = "header",
			name = "Options"
		},
		
		-- Row 1: 
		mountOnEnter = {
			order = Order(),
			type = "toggle",
			name = "Mount on 'Enter'",
			desc = "Pressing 'Enter' in the search box will summon the selected mount and close the Mount Journal",
			get = function() return MF.db.global.mountOnEnter; end,
			set = function(info, enabled) MF.db.global.mountOnEnter = enabled; end
		},
		space1 = {
			order = Order(),
			width = "normal",
			type = "description",
			name = ""
		},
		mountTotal = {
			order = Order(),
			type = "select",
			name = "Mount Total",
			desc = "Value to be displayed in the Mount Journal's \"Total Mounts\" area",
			style = "dropdown",
			values = {
				"Filtered",
				"Filtered / Total",
				"Total"
			},
			get = function() return MF.db.global.mountCountStyle; end,
			set = function(info, value) MF.db.global.mountCountStyle = value; end
		},
		newLine1 = {
			order = Order(),
			type = "description",
			name = ""
		},
		
		-- Row 2:
		resetSearchOnClose = {
			order = Order(),
			type = "toggle",
			name = "Reset Search on Close",
			desc = "The search box will be cleared when the Mount Journal is closed",
			get = function() return MF.db.global.resetSearchOnClose; end,
			set = function(info, enabled) MF.db.global.resetSearchOnClose = enabled; end
		},
		newLine2 = {
			order = Order(),
			type = "description",
			name = ""
		},
		
		-- Row 3:
		resetFilterOnClose = {
			order = Order(),
			type = "toggle",
			name = "Reset Filter on Close",
			desc = "The Filter options will be reset when the Mount Journal is closed",
			get = function() return MF.db.global.resetFilterOnClose; end,
			set = function(info, enabled) MF.db.global.resetFilterOnClose = enabled; end
		},
		newLine3 = {
			order = Order(),
			type = "description",
			name = "\n"
		},
		
		-- Debug Header
		debugHeader = {
			order = Order(),
			type = "header",
			name = "Debug"
		},
		debug = {
			order = Order(),
			type = "toggle",
			name = "Debug Mode",
			desc = "Enables debug spam",
			get = function() return MF.db.global.debug; end,
			set = function(info, enabled) MF.db.global.debug = enabled; end
		}
	}
};

-- Load AceConfig libs
local AceConfig = LibStub("AceConfig-3.0");
local AceConfigDialog = LibStub("AceConfigDialog-3.0");

-- Register options table and add it to bliz interface options
AceConfig:RegisterOptionsTable(MF:GetName(), Config.options, MF:GetSlashCommands());
AceConfigDialog:AddToBlizOptions(MF:GetName());
