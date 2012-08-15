
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
								["y"] = 0,
								["target"] = "BOTTOMLEFT",
							},
							["scale"] = 0.8500000000000001,
							["pos"] = {
								["y"] = 1027.365966796875,
								["x"] = 83.97510528564453,
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
					["nametrunc"] = 30,
					["AnchorsAway"] = {
						["roll"] = {
							["threshold"] = 10000,
							["timeout"] = 10000,
							["lock"] = false,
							["anchor"] = false,
							["attach"] = {
								["self"] = "TOPLEFT",
								["x"] = 0,
								["y"] = 0,
								["target"] = "BOTTOMLEFT",
							},
							["scale"] = 1.25,
							["pos"] = {
								["y"] = 494.4313659667969,
								["x"] = 62.04246139526367,
							},
						},
					},
					["faderows"] = false,
				},
			},
		},
	},
}
