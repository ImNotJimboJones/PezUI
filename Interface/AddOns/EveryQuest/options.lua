local EveryQuest = LibStub("AceAddon-3.0"):GetAddon("EveryQuest")
local addon = EveryQuest
local L = LibStub("AceLocale-3.0"):GetLocale("EveryQuest")
local db, dbpc
local options, moduleOptions = nil, {}
local format = string.format
local sortcommon = {
	Weight = {
		type = 'range',
		name = L["Weight"],
		min = -10,
		max = 10,
		step = 1,
		order = 3,
	},
	Dir = {
		type = 'select',
		name = L["Direction"],
		style = "dropdown",
		values = { -- A hack to sort them in the menu
			L["Ascending"],
			L["Descending"],
		},
		order = 4,
	},
}
local classes = {}
FillLocalizedClassList(classes, UnitSex("player") == 3 and true or false)
local BR = LibStub("LibBabble-Race-3.0"):GetLookupTable()

local generalOptions = {
	order = 1,
	type = "group",
	name = L["EveryQuest"],
	get = function(info) return db[ info[#info] ] end,
	set = function(info, value) db[ info[#info] ] = value end,
	args = {
		intro = {
			order = 1,
			type = "description",
			name = L["EQ_DESC"],
		},
		track = {
			order = 2,
			type = 'toggle',
			name = L["Track Zone"],
			desc = L["Track zone changes and update the EveryQuest list for that zone"],
			disabled = function() return db.savezone end,
		},
		savezone = {
			order = 3,
			type = 'toggle',
			name = L["Save Zone"],
			desc = L["Saves which zone you where last looking at to load upon login"],
			disabled = function() return db.track end,
		},
		locallist = {
			order = 4,
			type = 'toggle',
			name = L["Localized Quest List"],
			desc = L["Note: Stores localized quest titles in the global database"],
			set = function(info, value) db[ info[#info] ] = value EveryQuest:SendMessage("EveryQuestDisplayChanged") EveryQuest:SendMessage("EveryQuestDataChanged") end,
		},
		locallist_help = {
			order = 5,
			type = "description",
			name = L["EQ_LOCALLIST"],
		},
		Colors = {
			get = function(info) return unpack(db.colors[ info[#info] ]) end,
			set = function(info, r, g, b, a) db.colors[ info[#info] ] = {r, g, b, a} EveryQuest:SendMessage("EveryQuestDisplayChanged") --[[EveryQuest:UpdateFrame()]] end,
			type = "group",
			order = 2,
			guiInline = true,
			name = L["Quest Colors"],
			args = {
				Unknown = {
					order = 5,
					type = 'color',
					name = L["Unknown Status"],
				},
				Failed = {
					order = 6,
					type = 'color',
					name = L["Failed or Abandoned"],
				},
				Progress = {
					order = 4,
					type = 'color',
					name = L["In Progress"],
				},
				Complete = {
					order = 3,
					type = 'color',
					name = L["Completed"],
				},
				TurnedIn = {
					order = 2,
					type = 'color',
					name = L["Turned In"],
				},
				Ignored = {
					order = 7,
					type = 'color',
					name = IGNORED,
				},
				Repeat = {
					order = 1,
					type = 'color',
					name = L["Repeatable"],
				}
			},
		},
		header = {
			order = 6,
			type = 'header',
			name = CALENDAR_TYPE_OTHER,
		},
		debug = {
			order = 7,
			type = 'toggle',
			name = L["Show Debugging Messages"],
			desc = L["Show Debugging Messages - *WARNING* Spams your default chat frame"],
			width = "double",
		},
		purgeold = {
			order = 8,
			type = 'execute',
			name = L["Purge Old data"],
			desc = L["Purge Old database data, generally used after running upgrade"],
			func = function()
				StaticPopup_Show ("EVERYQUEST_PURGEOLD")
			end,
			order = -2,
		}
	},
}
local cc = RAID_CLASS_COLORS
local filterOptions = {
	type = "group",
	name = L["Filters"],
	get = function(info) return dbpc.filters[ info[#info] ] end,
	set = function(info, value) dbpc.filters[ info[#info] ] = value EveryQuest:SendMessage("EveryQuestDisplayChanged") EveryQuest:SendMessage("EveryQuestDataChanged") end,
	args = {
		intro = {
			order = 1,
			type = "description",
			name = L["Configure filtering options for the quest list. These settings are character specific."],
		},
		UseableFilters = {
			get = function(info) return dbpc.enabledfilters[ info[#info] ] end,
			set = function(info, value) dbpc.enabledfilters[ info[#info] ] = value EveryQuest:SendMessage("EveryQuestDisplayChanged") EveryQuest:SendMessage("EveryQuestDataChanged") end,
			type = "group",
			order = 2,
			guiInline = true,
			name = L["Enable Filtering"],
			args = {
				Faction = {
					type = 'toggle',
					name = L["Faction Filter"],
				},
				Level = {
					type = 'toggle',
					name = L["Level Filter"],
				},
				Type = {
					type = 'toggle',
					name = L["Type Filter"],
				},
				Status = {
					type = 'toggle',
					name = L["Status Filter"],
				},
				Race = {
					type = 'toggle',
					name = L["Race Filter"],
				},
				Class = {
					type = 'toggle',
					name = L["Class Filter"],
				}
			},
		},
		Faction = {
			type = "group",
			order = 2,
			guiInline = true,
			disabled = function() return not dbpc.enabledfilters.Faction end,
			name = L["Show quests for specific faction"],
			desc = L["Show quests for specific faction"],
			args = {
				Alliance = {
					type = 'toggle',
					name = L["Alliance"],
					desc = L["Shows Alliance Quests"],
				},
				Horde = {
					type = 'toggle',
					name = L["Horde"],
					desc = L["Shows Horde Quests"],
				},
				SideBoth = {
					type = 'toggle',
					name = L["Both Factions"],
					desc = L["Shows quests that are available to both factions"],
				},
				SideNone = {
					type = 'toggle',
					name = L["No Side/No Data"],
					desc = L["Shows quests that don't have a side or don't have data for a specific side"],
				},
			},
		},
		Race = {
			type = "group",
			order = 3,
			guiInline = true,
			disabled = function() return not dbpc.enabledfilters.Race end,
			name = L["Show quests for specific race"],
			desc = L["Show quests for specific race"],
			args = {
				intro = {
					order = 1,
					type = "description",
					name = L["Choose which races you wish to show along with non-race specific quests."],
				},
				Alliance = {
					type = 'group',
					guiInline = true,
					name = FACTION_ALLIANCE,
					args = {
						Human = {
							type = 'toggle',
							name = BR["Human"],
							desc = format(L["Shows %s Only Quests"], BR["Human"]),
						},
						Dwarf = {
							type = 'toggle',
							name = BR["Dwarf"],
							desc = format(L["Shows %s Only Quests"], BR["Dwarf"]),
						},
						NightElf = {
							type = 'toggle',
							name = BR["Night Elf"],
							desc = format(L["Shows %s Only Quests"], BR["Night Elf"]),
						},
						Gnome = {
							type = 'toggle',
							name = BR["Gnome"],
							desc = format(L["Shows %s Only Quests"], BR["Gnome"]),
						},
						Draenei = {
							type = 'toggle',
							name = BR["Draenei"],
							desc = format(L["Shows %s Only Quests"], BR["Draenei"]),
						},
						Worgen = {
							type = 'toggle',
							name = BR["Worgen"],
							desc = format(L["Shows %s Only Quests"], BR["Worgen"]),
						},
					},
				},
				Horde = {
					type = 'group',
					guiInline = true,
					name = FACTION_HORDE,
					args = {
						Orc = {
							type = 'toggle',
							name = BR["Orc"],
							desc = format(L["Shows %s Only Quests"], BR["Orc"]),
						},
						Undead = {
							type = 'toggle',
							name = BR["Undead"],
							desc = format(L["Shows %s Only Quests"], BR["Undead"]),
						},
						Tauren = {
							type = 'toggle',
							name = BR["Tauren"],
							desc = format(L["Shows %s Only Quests"], BR["Tauren"]),
						},
						Troll = {
							type = 'toggle',
							name = BR["Troll"],
							desc = format(L["Shows %s Only Quests"], BR["Troll"]),
						},
						BloodElf = {
							type = 'toggle',
							name = BR["Blood Elf"],
							desc = format(L["Shows %s Only Quests"], BR["Blood Elf"]),
						},
						Goblin = {
							type = 'toggle',
							name = BR["Goblin"],
							desc = format(L["Shows %s Only Quests"], BR["Goblin"]),
						},
					},
				},
			},
		},
		Class = {
			type = "group",
			order = 4,
			guiInline = true,
			disabled = function() return not dbpc.enabledfilters.Class end,
			name = L["Show quests for specific class"],
			desc = L["Show quests for specific class"],
			args = {
				intro = {
					order = 1,
					type = "description",
					name = L["Choose which classes you wish to show along with non-class specific quests."],
				},
				DEATHKNIGHT = {
					type = 'toggle',
					order = 2,
					name = format("|cff%02x%02x%02x%s|r", cc["DEATHKNIGHT"].r*255, cc["DEATHKNIGHT"].g*255, cc["DEATHKNIGHT"].b*255, classes["DEATHKNIGHT"]),
					desc = format(L["Shows %s Only Quests"], format("|cff%02x%02x%02x%s|r", cc["DEATHKNIGHT"].r*255, cc["DEATHKNIGHT"].g*255, cc["DEATHKNIGHT"].b*255, classes["DEATHKNIGHT"])),
				},
				DRUID = {
					type = 'toggle',
					order = 3,
					name = format("|cff%02x%02x%02x%s|r", cc["DRUID"].r*255, cc["DRUID"].g*255, cc["DRUID"].b*255, classes["DRUID"]),
					desc = format(L["Shows %s Only Quests"], format("|cff%02x%02x%02x%s|r", cc["DRUID"].r*255, cc["DRUID"].g*255, cc["DRUID"].b*255, classes["DRUID"])),
				},
				HUNTER = {
					type = 'toggle',
					order = 4,
					name = format("|cff%02x%02x%02x%s|r", cc["HUNTER"].r*255, cc["HUNTER"].g*255, cc["HUNTER"].b*255, classes["HUNTER"]),
					desc = format(L["Shows %s Only Quests"], format("|cff%02x%02x%02x%s|r", cc["HUNTER"].r*255, cc["HUNTER"].g*255, cc["HUNTER"].b*255, classes["HUNTER"])),
				},
				MAGE = {
					type = 'toggle',
					order = 5,
					name = format("|cff%02x%02x%02x%s|r", cc["MAGE"].r*255, cc["MAGE"].g*255, cc["MAGE"].b*255, classes["MAGE"]),
					desc = format(L["Shows %s Only Quests"], format("|cff%02x%02x%02x%s|r", cc["MAGE"].r*255, cc["MAGE"].g*255, cc["MAGE"].b*255, classes["MAGE"])),
				},
				PALADIN = {
					type = 'toggle',
					order = 6,
					name = format("|cff%02x%02x%02x%s|r", cc["PALADIN"].r*255, cc["PALADIN"].g*255, cc["PALADIN"].b*255, classes["PALADIN"]),
					desc = format(L["Shows %s Only Quests"], format("|cff%02x%02x%02x%s|r", cc["PALADIN"].r*255, cc["PALADIN"].g*255, cc["PALADIN"].b*255, classes["PALADIN"])),
				},
				PRIEST = {
					type = 'toggle',
					order = 7,
					name = format("|cff%02x%02x%02x%s|r", cc["PRIEST"].r*255, cc["PRIEST"].g*255, cc["PRIEST"].b*255, classes["PRIEST"]),
					desc = format(L["Shows %s Only Quests"], format("|cff%02x%02x%02x%s|r", cc["PRIEST"].r*255, cc["PRIEST"].g*255, cc["PRIEST"].b*255, classes["PRIEST"])),
				},
				ROGUE = {
					type = 'toggle',
					order = 8,
					name = format("|cff%02x%02x%02x%s|r", cc["ROGUE"].r*255, cc["ROGUE"].g*255, cc["ROGUE"].b*255, classes["ROGUE"]),
					desc = format(L["Shows %s Only Quests"], format("|cff%02x%02x%02x%s|r", cc["ROGUE"].r*255, cc["ROGUE"].g*255, cc["ROGUE"].b*255, classes["ROGUE"])),
				},
				SHAMAN = {
					type = 'toggle',
					order = 9,
					name = format("|cff%02x%02x%02x%s|r", cc["SHAMAN"].r*255, cc["SHAMAN"].g*255, cc["SHAMAN"].b*255, classes["SHAMAN"]),
					desc = format(L["Shows %s Only Quests"], format("|cff%02x%02x%02x%s|r", cc["SHAMAN"].r*255, cc["SHAMAN"].g*255, cc["SHAMAN"].b*255, classes["SHAMAN"])),
				},
				WARLOCK = {
					type = 'toggle',
					order = 10,
					name = format("|cff%02x%02x%02x%s|r", cc["WARLOCK"].r*255, cc["WARLOCK"].g*255, cc["WARLOCK"].b*255, classes["WARLOCK"]),
					desc = format(L["Shows %s Only Quests"], format("|cff%02x%02x%02x%s|r", cc["WARLOCK"].r*255, cc["WARLOCK"].g*255, cc["WARLOCK"].b*255, classes["WARLOCK"])),
				},
				WARRIOR = {
					type = 'toggle',
					order = 11,
					name = format("|cff%02x%02x%02x%s|r", cc["WARRIOR"].r*255, cc["WARRIOR"].g*255, cc["WARRIOR"].b*255, classes["WARRIOR"]),
					desc = format(L["Shows %s Only Quests"], format("|cff%02x%02x%02x%s|r", cc["WARRIOR"].r*255, cc["WARRIOR"].g*255, cc["WARRIOR"].b*255, classes["WARRIOR"])),
				},
			},
		},
		Status = {
			type = "group",
			order = 5,
			guiInline = true,
			disabled = function() return not dbpc.enabledfilters.Status end,
			name = L["Control the display of specific quest statuses"],
			desc = L["Control the display of specific quest statuses"],
			args = {
				TurnedIn = {
					order = 1,
					type = 'toggle',
					name = function() return addon:Colorize(addon:RGB2Hex(unpack(db.colors.TurnedIn)), L["Turned In Quests"]) end,
					desc = L["Shows quests turned back into NPCs"],
					width = "double",
				},
				Completed = {
					order = 2,
					type = 'toggle',
					name = function() return addon:Colorize(addon:RGB2Hex(unpack(db.colors.Complete)), L["Completed Quests"]) end,
					desc = L["Shows completed quests still in your questlog"],
					width = "double",
				},
				InProgress = {
					order = 3,
					type = 'toggle',
					name = function() return addon:Colorize(addon:RGB2Hex(unpack(db.colors.Progress)), L["Quests In Progress"]) end,
					desc = L["Shows quests that you are on but not completed"],
					width = "double",
				},
				FailedAbandoned = {
					order = 4,
					type = 'toggle',
					name = function() return addon:Colorize(addon:RGB2Hex(unpack(db.colors.Failed)), L["Failed or Abandoned Quests"]) end,
					desc = L["Shows quests that you have failed or abandoned"],
					width = "double",
				},
				Unknown = {
					order = 5,
					type = 'toggle',
					name = function() return addon:Colorize(addon:RGB2Hex(unpack(db.colors.Unknown)), L["Unknown Status"]) end,
					desc = L["Shows quests you haven't seen before"],
					width = "double",
				},
				Ignored = {
					order = 6,
					type = 'toggle',
					name = function() return addon:Colorize(addon:RGB2Hex(unpack(db.colors.Ignored)), L["Ignored Quests"]) end,
					desc = L["Shows quests you've ignored"],
					width = "double",
				},
				example = {
					order = 7,
					type = "description",
					name = L["Example for Ignored quest: Some quests are still in Wowhead's database but are not attainable ingame anymore. Ignore them to hide them from the list."],
					width = "double",
				},
			},
		},
		Level = {
			type = "group",
			order = 6,
			guiInline = true,
			disabled = function() return not dbpc.enabledfilters.Level end,
			name = L["Filter Quests by Level"],
			args = {
				MinLevel = {
					order = 1,
					type = 'range',
					name = L["Minimum Level"],
					set = function(info, value) dbpc.filters[ info[#info] ] = value options.args.Filters.args.Level.args.MaxLevel.min = value EveryQuest:SendMessage("EveryQuestDisplayChanged") EveryQuest:SendMessage("EveryQuestDataChanged") end,
					min = 0,
					max = 80,
					step = 1,
					width = "double",
				},
				MaxLevel = {
					order = 2,
					type = 'range',
					name = L["Maximum Level"],
					set = function(info, value) dbpc.filters[ info[#info] ] = value options.args.Filters.args.Level.args.MinLevel.max = value EveryQuest:SendMessage("EveryQuestDisplayChanged") EveryQuest:SendMessage("EveryQuestDataChanged") end,
					min = 0,
					max = 80,
					step = 1,
					width = "double",
				},
			},
		},
		Type = {
			type = "group",
			order = 7,
			guiInline = true,
			disabled = function() return not dbpc.enabledfilters.Type end,
			name = L["Filter Quests by Type"],
			args = {
				NormalQuest = {
					order = 1,
					type = 'toggle',
					name = L["Normal Quests"],
					desc = L["Shows normal Blizzard soloable quests"],
				},
				GroupQuest = {
					order = 2,
					type = 'toggle',
					name = L["Group Quests"],
					desc = L["Shows 'group suggested' quests"],
				},
				DailyQuest = {
					order = 3,
					type = 'toggle',
					name = function() return addon:Colorize(addon:RGB2Hex(unpack(db.colors.Repeat)), L["Daily Quests"]) end,
					desc = L["Shows daily quests"],
				},
				WeeklyQuest = {
					order = 4,
					type = 'toggle',
					name = function() return addon:Colorize(addon:RGB2Hex(unpack(db.colors.Repeat)), L["Weekly Quests"]) end,
					desc = L["Shows weekly quests"],
				},
				DungeonQuest = {
					order = 5,
					type = 'toggle',
					name = L["Dungeon Quests"],
					desc = L["Shows dungeon quests"],
				},
				HeroicQuest = {
					order = 6,
					type = 'toggle',
					name = L["Heroic Quests"],
					desc = L["Shows heroic quests"],
				},
				RaidQuest = {
					order = 7,
					type = 'toggle',
					name = L["Raid Quests"],
					desc = L["Shows 'raid suggested' quests"],
				},
				PvpQuest = {
					order = 8,
					type = 'toggle',
					name = L["PvP Quests"],
					desc = L["Shows PVP quests"],
				},
			},
		},
	},
}

local sortOptions = {
	order = 2,
	type = "group",
	name = L["List Order"],
	args = {
		intro = {
			order = 1,
			type = "description",
			name = L["Customize how your quest list is sorted.  Higher Weight moves the items to the top of the list, lower weight goes to the bottom.  Sort order Ascending: A-Z 0-9, Descending: Z-A, 9-0."],
		},
		w = {
			type = "group",
			order = 3,
			guiInline = true,
			name = L["Order by Weekly"],
			get = function(info) return dbpc.sort["w"][ info[#info] ] end,
			set = function(info, value) dbpc.sort["w"][ info[#info] ] = value EveryQuest:UpdateSortList() EveryQuest:SendMessage("EveryQuestDisplayChanged") EveryQuest:SendMessage("EveryQuestDataChanged") end,
			args = sortcommon,
		},
		d = {
			type = "group",
			order = 4,
			guiInline = true,
			name = L["Order by Daily"],
			get = function(info) return dbpc.sort["d"][ info[#info] ] end,
			set = function(info, value) dbpc.sort["d"][ info[#info] ] = value EveryQuest:UpdateSortList() EveryQuest:SendMessage("EveryQuestDisplayChanged") EveryQuest:SendMessage("EveryQuestDataChanged") end,
			args = sortcommon,
		},
		t = {
			type = "group",
			order = 5,
			guiInline = true,
			name = L["Order by Type"],
			get = function(info) return dbpc.sort["t"][ info[#info] ] end,
			set = function(info, value) dbpc.sort["t"][ info[#info] ] = value EveryQuest:UpdateSortList() EveryQuest:SendMessage("EveryQuestDisplayChanged") EveryQuest:SendMessage("EveryQuestDataChanged") end,
			args = sortcommon,
		},
		l = {
			type = "group",
			order = 6,
			guiInline = true,
			name = L["Order by Level"],
			get = function(info) return dbpc.sort["l"][ info[#info] ] end,
			set = function(info, value) dbpc.sort["l"][ info[#info] ] = value EveryQuest:UpdateSortList() EveryQuest:SendMessage("EveryQuestDisplayChanged") EveryQuest:SendMessage("EveryQuestDataChanged") end,
			args = sortcommon,
		},
		n = {
			type = "group",
			order = 7,
			guiInline = true,
			name = L["Order by Name"],
			get = function(info) return dbpc.sort["n"][ info[#info] ] end,
			set = function(info, value) dbpc.sort["n"][ info[#info] ] = value EveryQuest:UpdateSortList() EveryQuest:SendMessage("EveryQuestDisplayChanged") EveryQuest:SendMessage("EveryQuestDataChanged") end,
			args = sortcommon,
		},
	},
}

local acr = LibStub("AceConfigRegistry-3.0")
local acd = LibStub("AceConfigDialog-3.0")

local function findPanel(name, parent)
	for i, button in next, InterfaceOptionsFrameAddOns.buttons do
		if button.element then
			if name and button.element.name == name then return button
			elseif parent and button.element.parent == parent then return button
			end
		end
	end
end

function addon:SetupOptions()
	-- InterfaceOptionsFrame:SetFrameStrata("DIALOG") 
	
	-- setup options table Mapster
	acr:RegisterOptionsTable("EveryQuest", generalOptions)
	local options = acd:AddToBlizOptions("EveryQuest", L["EveryQuest"])
	options:HookScript("OnShow", function()
		local p = findPanel("EveryQuest")
		if p and p.element.collapsed then OptionsListButtonToggle_OnClick(p.toggle) end
	end)
	
	function addon:ShowConfig()
		InterfaceOptionsFrame_OpenToCategory(options)
	end
	
	acr:RegisterOptionsTable("EveryQuest/Filters", filterOptions)
	local filters = acd:AddToBlizOptions("EveryQuest/Filters", L["Filters"], "EveryQuest")
	
	function addon:ShowFilters()
		InterfaceOptionsFrame_OpenToCategory(filters)
	end
	
	acr:RegisterOptionsTable("EveryQuest/Sort", sortOptions)
	acd:AddToBlizOptions("EveryQuest/Sort", L["List Order"], "EveryQuest")
	
	LibStub("AceConsole-3.0"):RegisterChatCommand( "everyquest", function() addon:Toggle() end)
	
	local about = LibStub("tekKonfig-AboutPanel").new("EveryQuest", "EveryQuest")
	
	function addon:ShowAbout()
		InterfaceOptionsFrame_OpenToCategory(about)
	end
	
	db = EveryQuest.db.profile
	dbpc = EveryQuest.dbpc.profile
end

function addon:RegisterModuleOptions(moduleName, optionsTable)
	acr:RegisterOptionsTable("EveryQuest/"..moduleName, optionsTable)
	acd:AddToBlizOptions("EveryQuest/"..moduleName, moduleName, "EveryQuest")
end

--- EOF ---