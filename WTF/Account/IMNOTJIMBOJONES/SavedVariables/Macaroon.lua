
MacaroonButtonDefaults = {
	["config"] = {
		["cooldownAlpha"] = 1,
		["auracolor1"] = "0;0.82;0;1",
		["macroColor"] = "1;1;1;1",
		["copyDrag"] = false,
		["rangeInd"] = true,
		["auraInd"] = false,
		["muteSFX"] = false,
		["countText"] = true,
		["downClicks"] = false,
		["bindText"] = true,
		["upClicks"] = true,
		["bindColor"] = "1;1;1;1",
		["countColor"] = "1;1;1;1",
		["buffcolor"] = "0;0.8;0;1",
		["spellCounts"] = false,
		["auraText"] = false,
		["rangecolor"] = "0.7;0.15;0.15;1",
		["cdText"] = false,
		["clearerrors"] = false,
		["macroText"] = true,
		["auracolor2"] = "1;0.1;0.1;1",
		["cdcolor2"] = "1;0.1;0.1;1",
		["cdcolor1"] = "1;0.82;0;1",
		["debuffcolor"] = "0.8;0;0;1",
	},
}
MacaroonMacroMaster = nil
MacaroonMacroVault = {
	["Main Vault"] = {
		["Hunter"] = {
			["WC + RS"] = {
				"/cast Raptor Strike\n/cast Wing Clip\n/stopcasting", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"WC + RS", -- [3]
				"Wing Clip + Raptor Strike", -- [4]
				true, -- [5]
			},
		},
	},
	["Burning Blade"] = {
		["Pezzer"] = {
			["Test: Button 1"] = {
				"#show Ice Trap\n/cast Ice Trap", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"", -- [3]
				"", -- [4]
				false, -- [5]
			},
			["Spell Bar: Button 26"] = {
				"/cast Raptor Strike\n/cast Wing Clip\n/stopcasting", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"WC + RS", -- [3]
				"Wing Clip + Raptor Strike", -- [4]
				true, -- [5]
			},
			["ScreenGrid: Button 4"] = {
				"/screengrid 40", -- [1]
				"INTERFACE\\ICONS\\SPELL_FROST_FIRERESISTANCETOTEM", -- [2]
				"SG 40", -- [3]
				"", -- [4]
				false, -- [5]
			},
			["ScreenGrid: Button 5"] = {
				"/screengrid 80", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"SG 80", -- [3]
				"", -- [4]
				false, -- [5]
			},
			["Spell Bar: Button 1"] = {
				"/cast Misdirection()", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"", -- [3]
				"", -- [4]
				false, -- [5]
			},
			["ScreenGrid: Button 1"] = {
				"/screengrid 0", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"SG 0", -- [3]
				"", -- [4]
				false, -- [5]
			},
			["Keybinds: Button 7"] = {
				"/cast [@focus] Misdirection;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"", -- [3]
				"", -- [4]
				false, -- [5]
			},
			["ScreenGrid: Button 3"] = {
				"/screengrid 20", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"SG 20", -- [3]
				"", -- [4]
				false, -- [5]
			},
			["ScreenGrid: Button 6"] = {
				"/screengrid 50", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"50", -- [3]
				"", -- [4]
				false, -- [5]
			},
			["ScreenGrid: Button 2"] = {
				"/screengrid 10", -- [1]
				"INTERFACE\\ICONS\\SPELL_FROST_FIRERESISTANCETOTEM", -- [2]
				"SG 10", -- [3]
				"", -- [4]
				false, -- [5]
			},
			["Spell Bar: Button 2"] = {
				"/cast [@player] Master's Call", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"", -- [3]
				"", -- [4]
				false, -- [5]
			},
		},
	},
}
MacaroonItemCache = {
	["Belt of the Beloved Companion"] = "77241",
	["Kiroptyric Sigil"] = "77113",
	["Sporebeard Gauntlets"] = "78362",
}
MacaroonLocale = {
	["Macaroon"] = {
	},
	["Current"] = "enUS",
}
