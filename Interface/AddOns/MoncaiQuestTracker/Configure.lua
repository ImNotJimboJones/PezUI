local ML = LibStub("MoncaiLib");
local MQT = LibStub("AceAddon-3.0"):GetAddon("MoncaiQuestTracker");
local L = LibStub("AceLocale-3.0"):GetLocale("MoncaiQuestTracker", false);
local CFG = MQT:NewModule("MQT_Configure");
local MQTC = MQTC;
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigCmd = LibStub("AceConfigCmd-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

--------------------------------------------------------------------------------------------------------
--
-- Initialize
--
--------------------------------------------------------------------------------------------------------
local defaults = {
	profile = {
		colortitle = true,
		showlevel = true,
		questhelper = true,
		removecomplete = false,
		hidecompletedobjectives = false,
		verbosebuddy = false,
		verbosechat = true,
		debug = false,
		fixedwidth = false,
		widthwhenfixed = 220,
		float = false,
		floatfixed = false,
		itemleft = false,
		displayqid = false,
	}
}

local db

local function setter(info, val)
	db.profile[info[#info]] = val
	-- refresh here
	MQT:Refresh();
end

local function qh_setter(info, val)
	if val then MQT.QH:Enable() else MQT.QH:Disable() end
	setter(info, val)
end

local function getter(info)
	return db.profile[info[#info]]
end

local optionstable = {
	type = "group",
	args = {
		general = {
			type = "group",
			name = "General",
			args = {
				colortitle = {
					name = "Color Titles",
					desc = "Enable or disable quest title coloring. If enabled, will color regular quests according to difficulty, daily quests appear in blue.",
					type = "toggle",
					set = setter, get = getter, width = "full",
				},

				showlevel = {
					name = "Quest level always",
					desc = "Enable or disable the display of the quest level in tracker and questlog, even when not in colorblind mode.",
					type = "toggle",
					set = setter, get = getter, width = "full",
				},
				displayqid = {
					name = "Display Quest IDs",
					desc = "Enable or disable the display of quest ID's in the questlog.",
					type = "toggle",
					set = setter, get = getter, width = "full",				
				},
				
				--[[removecomplete = {
					name = "Remove completed quests",
					desc = "Enable or disable the removal of completed quests from the tracker.",
					type = "toggle",
					set = setter, get = getter, width = "full",
				},]]

				--[[hidecompletedobjectives = {
					name = "Hide completed objectives",
					desc = "Enable or disable the removal of completed objectives from the tracker.",
					type = "toggle",
					set = setter, get = getter, width = "full",
				},]]

				--[[fixture = {
					type = "group",
					name = "Fixed width",
					args = {
						fixedwidth = {
							name = "Enable",
							desc = "Enable or disable a fixed width when using the simple tracker.",
							type = "toggle",
							set = setter, get = getter, width = "full",
						},
						
						widthwhenfixed = {
							name = "Width",
							desc = "Set the desired width when in simple mode.",
							type = "range", min = 100, max = 500, step = 10,
							set = setter, get = getter, width = "full",
						},
					},
				},]]
			},
		},
		placement = {
			type = "group",
			name = "Placement",
			args = {
				itemleft = {
					name = "Show items on left side of the tracker",
					desc = "Some like it the other way around",
					type = "toggle",
					set = setter, get = getter, width = "full",
				},
				float = {
					name = "Float the tracker",
					desc = "Detach the tracker from the MinimapCluster",
					type = "toggle",
					set = setter, get = getter, width = "full",
				},
				floatfixed = {
					name = "Hide floater",
					desc = "Hide the placement rectangle and keep current position. To toggle this you can also Right Click the Collapse/Expand Button.",
					type = "toggle",
					set = setter, get = getter, width = "full",
				},
				floatreset = {
					name = "Reset floater",
					desc = "Reset the floater if it accidentally went off the screen",
					type = "execute",
					func = function() MQT.floater:reset() end
				}
			},
		},
		verbosity = {
			type = "group",
			name = "Verbosity",
			args = {
				verbosebuddy = {
					name = "Group welcome messages",
					desc = "Enable or disable verbose messages.",
					type = "toggle",
					set = setter, get = getter, width = "full",
				},

				verbosechat = {
					name = "Quest progress in chat frame",
					desc = "Enable or disable quest progress updates.",
					type = "toggle",
					set = setter, get = getter, width = "full",
				},
				
				debug = {
					name = "Debug messages",
					desc = "Enable or disable debug messages.",
					type = "toggle",
					set = setter, get = getter, width = "full",
				},
				
			},
		},
	},
}

function CFG.OnInitialize(self)	
	-- create savedvariables database
	db = LibStub("AceDB-3.0"):New("MQTdb", defaults)
	
	if IsAddOnLoaded("QuestHelper") then
		local verinfo = GetAddOnMetadata("QuestHelper", "Version")
		optionstable.args.general.args.questhelper = {
			name = "Integrate with Quest Helper " .. verinfo,
			desc = "Enable or disable questhelper integration.",
			type = "toggle",
			set = qh_setter, get = getter, width = "full",
		}
	end
	
	-- set up profiles
	optionstable.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(db)

	AceConfig:RegisterOptionsTable("MoncaiQuestTracker", optionstable, {"mqtc"})
	self.frames = {}
	self.frames.general = AceConfigDialog:AddToBlizOptions("MoncaiQuestTracker", L["Moncaí Questtracker"], nil, "general")
	self.frames.placement = AceConfigDialog:AddToBlizOptions("MoncaiQuestTracker", "Placement", L["Moncaí Questtracker"], "placement")
	self.frames.verbosity = AceConfigDialog:AddToBlizOptions("MoncaiQuestTracker", "Verbosity", L["Moncaí Questtracker"], "verbosity")
	self.frames.profiles = AceConfigDialog:AddToBlizOptions("MoncaiQuestTracker", "Profiles", L["Moncaí Questtracker"], "profiles")

	MQT:RegisterChatCommand("rl", function() ReloadUI(); end, true);
	MQT:RegisterChatCommand("mqtt", function() MQT:Toggle(); end, true);
	MQT:RegisterChatCommand("mqt", function() 
		InterfaceOptionsFrame_OpenToCategory(self.frames.profiles); 
		InterfaceOptionsFrame_OpenToCategory(self.frames.general); 
	end, true);
	
	LibStub("LibAboutPanel").new(L["Moncaí Questtracker"], "MoncaiQuestTracker");
	
	MQT.db = db
	self.db = db
	self.optionstable = optionstable
	
	-- no need to refresh here... MQT:Refresh();
end

function CFG.OnEnable(self)
	if self.db.profile.debug then Print("Hello Config!") end
end

function CFG.OnDisable(self)
	if self.db.profile.debug then Print("This is not happening!") end
end
