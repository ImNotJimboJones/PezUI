
ThreatPlatesDB = {
	["char"] = {
		["Pezzer - Burning Blade"] = {
			["welcome"] = true,
			["spec"] = {
				["primary"] = false,
			},
			["specInfo"] = {
				{
					3, -- [1]
					7, -- [2]
					31, -- [3]
					["name"] = "Survival",
					["role"] = "DAMAGER",
				}, -- [1]
				{
					33, -- [1]
					2, -- [2]
					6, -- [3]
					["name"] = "Beast Mastery",
					["role"] = "DAMAGER",
				}, -- [2]
			},
			["specName"] = {
				"Beast Mastery", -- [1]
				"Marksmanship", -- [2]
				"Survival", -- [3]
			},
		},
	},
	["profileKeys"] = {
		["Pezzer - Burning Blade"] = "Default",
	},
	["global"] = {
		["version"] = "6.008",
	},
	["profiles"] = {
		["Default"] = {
			["nameplate"] = {
				["toggle"] = {
					["Totem"] = true,
				},
				["scale"] = {
					["Elite"] = 0.75,
					["Boss"] = 0.75,
					["Neutral"] = 0.75,
					["Normal"] = 0.75,
				},
			},
			["comboWidget"] = {
				["ON"] = true,
			},
			["friendlyClass"] = true,
			["uniqueSettings"] = {
				[33] = {
				},
				[34] = {
				},
				[38] = {
				},
				[40] = {
				},
				[41] = {
				},
				[42] = {
				},
				[48] = {
				},
				[49] = {
				},
				[50] = {
				},
				["list"] = {
					"Shadow Fiend", -- [1]
					"Spirit Wolf", -- [2]
					"Ebon Gargoyle", -- [3]
					"Water Elemental", -- [4]
					"Treant", -- [5]
					"Viper", -- [6]
					"Venomous Snake", -- [7]
					"Army of the Dead Ghoul", -- [8]
					"Shadowy Apparition", -- [9]
					"Shambling Horror", -- [10]
					"Web Wrap", -- [11]
					"Immortal Guardian", -- [12]
					"Marked Immortal Guardian", -- [13]
					"Empowered Adherent", -- [14]
					"Deformed Fanatic", -- [15]
					"Reanimated Adherent", -- [16]
					"Reanimated Fanatic", -- [17]
					"Bone Spike", -- [18]
					"Onyxian Whelp", -- [19]
					"Gas Cloud", -- [20]
					"Volatile Ooze", -- [21]
					"Darnavan", -- [22]
					"Val'kyr Shadowguard", -- [23]
					"Kinetic Bomb", -- [24]
					"Lich King", -- [25]
					"Raging Spirit", -- [26]
					"Drudge Ghoul", -- [27]
					"Living Inferno", -- [28]
					"Living Ember", -- [29]
					"Fanged Pit Viper", -- [30]
					"Canal Crab", -- [31]
					"Muddy Crawfish", -- [32]
					"", -- [33]
					"", -- [34]
					"", -- [35]
					"", -- [36]
					"", -- [37]
					"", -- [38]
					"", -- [39]
					"", -- [40]
					"", -- [41]
					"", -- [42]
					"", -- [43]
					"", -- [44]
					"", -- [45]
					"", -- [46]
					"", -- [47]
					"", -- [48]
					"", -- [49]
					"", -- [50]
				},
			},
			["text"] = {
				["amount"] = false,
			},
			["debuffWidget"] = {
				["mode"] = "blacklistMine",
			},
			["cacheClass"] = true,
			["cache"] = {
			},
			["settings"] = {
				["eliteicon"] = {
					["scale"] = 16,
				},
				["elitehealthborder"] = {
					["texture"] = "TP_HealthBarEliteOverlayThin",
				},
				["level"] = {
					["align"] = "LEFT",
					["show"] = false,
					["x"] = 49,
					["y"] = 1,
					["vertical"] = "CENTER",
					["size"] = 11,
				},
				["normal"] = {
					["threatcolor"] = {
						["LOW"] = {
							["a"] = 0,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0,
						},
					},
				},
				["healthbar"] = {
					["texture"] = "Minimalist",
				},
				["healthborder"] = {
					["texture"] = "TP_HealthBarOverlayThin",
				},
				["dps"] = {
					["threatcolor"] = {
						["LOW"] = {
							["a"] = 0,
						},
					},
				},
				["tank"] = {
					["threatcolor"] = {
						["HIGH"] = {
							["a"] = 0,
						},
					},
				},
				["castbar"] = {
					["texture"] = "Minimalist",
				},
			},
			["friendlyClassIcon"] = true,
			["targetWidget"] = {
				["theme"] = "arrows",
			},
			["tidyplatesFade"] = true,
			["blizzFade"] = {
				["amount"] = 0,
			},
			["castbarColor"] = {
				["r"] = 0.6705882352941176,
				["g"] = 0.8274509803921568,
				["b"] = 0.4509803921568628,
			},
			["classWidget"] = {
				["ON"] = false,
			},
			["allowClass"] = true,
			["threat"] = {
				["scaleType"] = {
					["Normal"] = 0,
					["Boss"] = 0,
				},
				["dps"] = {
					["scale"] = {
						["MEDIUM"] = 0.9500000000000001,
						["LOW"] = 0.75,
						["HIGH"] = 1.15,
					},
				},
				["useType"] = false,
				["tank"] = {
					["scale"] = {
						["MEDIUM"] = 0.9500000000000001,
						["LOW"] = 1.15,
						["HIGH"] = 0.75,
					},
				},
				["useHPColor"] = false,
			},
		},
	},
}
