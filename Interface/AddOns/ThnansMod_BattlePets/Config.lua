--[[--------------------------------------------------------------------
	Thnan's Mod - Battle Pets
	Copyright (c) 2013 Thnan

	This addon is freely available, and its source code freely viewable,
	but it is not "open source software" and you may not distribute it,
	with or without modifications, without permission from its author.

	See the included License file for more information!
----------------------------------------------------------------------]]
local addonName, addon = ...;

local AceEvent = LibStub("AceEvent-3.0");
local AceLocale = LibStub("AceLocale-3.0");
local AceDB = LibStub("AceDB-3.0");
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0");
local AceConfigDialog = LibStub("AceConfigDialog-3.0");
local LibModuleDBShare = LibStub("LibModuleDBShare-1.0");

local L = AceLocale:GetLocale(addonName);

local defaults = {
	profile = {
		showAllPets = false,
		replaceDefaultLine = false,
		["**"] = {
			enabled = true,
			includeLevel = true,
			includeBreed = true,
		},
		minimapTooltips = {
			includeLevel = false,
			includeBreed = false,
		},
		colorReleaseText = true,
		showBreedInJournal = true,
		showBreedInBattle = true,
		useBreedLetterCodes = true,
		showHighestZones = true,
	},
};

local configPanelOptions = {
	type = "group",
	name = L.battlePetsTitle,
	get =	function(info)
				if #info > 2 then
					return addon.db.profile[info[2]][info[3]];
				else
					return addon.db.profile[info[2]];
				end
			end,
	set =	function(info, val)
				if #info > 2 then
					addon.db.profile[info[2]][info[3]] = val;
				else
					addon.db.profile[info[2]] = val;
				end
			end,
	args = {
		tooltipOptions = {
			type = "group",
			name = L.tooltipOptionsLabel,
			order = 1,
			inline = true,
			args = {
				showAllPets = {
					type = "toggle",
					name = L.showAllPetsLabel,
					desc = L.showAllPetsDesc,
					order = 1,
				},
				replaceDefaultLine = {
					type = "toggle",
					name = L.replaceDefaultLineLabel,
					desc = L.replaceDefaultLineDesc,
					order = 2,
				},
				worldTooltips = {
					type = "group",
					name = L.worldTooltipsLabel,
					order = 3,
					inline = true,
					args = {
						enabled = {
							type = "toggle",
							name = L.enabledLabel,
							desc = (L.enabledDesc):format((L.worldTooltipsLabel):lower()),
							order = 1,
						},
						includeLevel = {
							type = "toggle",
							name = L.includeLevelLabel,
							desc = (L.includeLevelDesc):format((L.worldTooltipsLabel):lower()),
							order = 2,
						},
						includeBreed = {
							type = "toggle",
							name = L.includeBreedLabel,
							desc = (L.includeBreedDesc):format((L.worldTooltipsLabel):lower()),
							order = 3,
						},
					},
				},
				minimapTooltips = {
					type = "group",
					name = L.minimapTooltipsLabel,
					order = 4,
					inline = true,
					args = {
						enabled = {
							type = "toggle",
							name = L.enabledLabel,
							desc = (L.enabledDesc):format((L.minimapTooltipsLabel):lower()),
							order = 1,
						},
						includeLevel = {
							type = "toggle",
							name = L.includeLevelLabel,
							desc = (L.includeLevelDesc):format((L.minimapTooltipsLabel):lower()),
							order = 2,
						},
						includeBreed = {
							type = "toggle",
							name = L.includeBreedLabel,
							desc = (L.includeBreedDesc):format((L.minimapTooltipsLabel):lower()),
							order = 3,
						},
					},
				},
				battleTooltips = {
					type = "group",
					name = L.battleTooltipsLabel,
					order = 5,
					inline = true,
					args = {
						enabled = {
							type = "toggle",
							name = L.enabledLabel,
							desc = (L.enabledDesc):format((L.battleTooltipsLabel):lower()),
							order = 1,
						},
						includeLevel = {
							type = "toggle",
							name = L.includeLevelLabel,
							desc = (L.includeLevelDesc):format((L.battleTooltipsLabel):lower()),
							order = 2,
						},
						includeBreed = {
							type = "toggle",
							name = L.includeBreedLabel,
							desc = (L.includeBreedDesc):format((L.battleTooltipsLabel):lower()),
							order = 3,
						},
					},
				},
				itemTooltips = {
					type = "group",
					name = L.itemTooltipsLabel,
					order = 6,
					inline = true,
					args = {
						enabled = {
							type = "toggle",
							name = L.enabledLabel,
							desc = (L.enabledDesc):format((L.itemTooltipsLabel):lower()),
							order = 1,
						},
						includeLevel = {
							type = "toggle",
							name = L.includeLevelLabel,
							desc = (L.includeLevelDesc):format((L.itemTooltipsLabel):lower()),
							order = 2,
						},
						includeBreed = {
							type = "toggle",
							name = L.includeBreedLabel,
							desc = (L.includeBreedDesc):format((L.itemTooltipsLabel):lower()),
							order = 3,
						},
					},
				},
			},
		},
		breedIDOptions = {
			type = "group",
			name = L.breedIDOptionsLabel,
			order = 2,
			inline = true,
			args = {
				showBreedInJournal = {
					type = "toggle",
					name = L.showBreedInJournalLabel,
					desc = L.showBreedInJournalDesc,
					order = 1,
				},
				showBreedInBattle = {
					type = "toggle",
					name = L.showBreedInBattleLabel,
					desc = L.showBreedInBattleDesc,
					order = 2,
				},
				useBreedLetterCodes = {
					type = "toggle",
					name = L.useBreedLetterCodesLabel,
					desc = L.useBreedLetterCodesDesc,
					order = 3,
				},
			},
		},
		miscOptions = {
			type = "group",
			name = L.miscOptionsLabel,
			order = 3,
			inline = true,
			args = {
				colorReleaseText = {
					type = "toggle",
					name = L.colorReleaseTextLabel,
					desc = L.colorReleaseTextDesc,
					order = 1,
				},
				showHighestZones = {
					type = "toggle",
					name = L.showHighestZonesLabel,
					desc = L.showHighestZonesDesc,
					order = 2,
				},
			},
		},
	},
};

local initDBTbl = {};

local configFrame = nil;

local function petsCmdHandler(message, editBox)
	InterfaceOptionsFrame_OpenToCategory(configFrame);
end

function initDBTbl:initDB(event, name)
	if name == addonName then
		AceEvent.UnregisterEvent(initDBTbl, "ADDON_LOADED");
		initDBTbl = nil;
		addon.db = AceDB:New("THNANSMOD_BATTLEPETS_SAVED", defaults, true);
		local group = LibModuleDBShare:GetGroup(L.thnansModTitle);
		if not group then
			group = LibModuleDBShare:NewGroup(L.thnansModTitle, L.thnansModDescription, addon.db);
			group:EnableSlashCommand("THNANSMOD", {"/thnansmod", "/tmod", L.thnansModSlashCmd, L.thnansModShortSlashCmd});
		else
			group:AddDB(addon.db);
		end
		AceConfigRegistry:RegisterOptionsTable(addonName, configPanelOptions);
		configFrame = AceConfigDialog:AddToBlizOptions(addonName, L.battlePetsTitle, L.thnansModTitle);
		group:AddSecondaryCommand("pets", petsCmdHandler);
		group:AddSecondaryCommand(L.petsSlashCmd, petsCmdHandler, true);
	end
end

AceEvent.RegisterEvent(initDBTbl, "ADDON_LOADED", "initDB");
