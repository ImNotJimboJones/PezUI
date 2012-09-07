
XLootDB = {
	["namespaces"] = {
		["XLootMasterDB"] = {
			["profiles"] = {
				["Default"] = {
					["mlthreshold"] = 5,
					["mlrolls"] = true,
					["announce"] = {
						["group"] = 1,
						["guild"] = 1,
						["rw"] = 4,
					},
				},
			},
		},
		["XLootMonitorDB"] = {
			["profiles"] = {
				["Default"] = {
					["selfqualitythreshold"] = 2,
					["lock"] = true,
					["AnchorsAway"] = {
						["loot"] = {
							["threshold"] = 6,
							["timeout"] = 15,
							["lock"] = true,
							["anchor"] = false,
							["attach"] = {
								["self"] = "TOPLEFT",
								["x"] = 0,
								["target"] = "TOPLEFT",
								["y"] = 0,
							},
							["scale"] = 0.9,
							["pos"] = {
								["y"] = 1226.189575195313,
								["x"] = 46.32804107666016,
							},
						},
					},
					["qualitythreshold"] = 2,
				},
			},
		},
		["XLootGroupDB"] = {
			["profiles"] = {
				["Default"] = {
					["faderows"] = false,
					["AnchorsAway"] = {
						["roll"] = {
							["threshold"] = 10000,
							["timeout"] = 10000,
							["lock"] = false,
							["anchor"] = false,
							["attach"] = {
								["self"] = "TOPLEFT",
								["x"] = 0,
								["target"] = "BOTTOMLEFT",
								["y"] = 0,
							},
							["scale"] = 1.25,
							["pos"] = {
								["y"] = 494.4313659667969,
								["x"] = 62.04246139526367,
							},
						},
					},
					["nametrunc"] = 30,
				},
			},
		},
	},
}
