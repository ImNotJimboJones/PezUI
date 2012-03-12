
CombuctorDB2 = {
	["version"] = "2.2.4",
	["global"] = {
		["maxScale"] = 1.5,
	},
	["profiles"] = {
		["Pezzer - Burning Blade"] = {
			["inventory"] = {
				["position"] = {
					"RIGHT", -- [1]
				},
				["h"] = 516.2667236328125,
				["showBags"] = true,
				["exclude"] = {
					["All"] = {
						"All", -- [1]
						"Shards", -- [2]
					},
				},
				["bags"] = {
					-2, -- [1]
					0, -- [2]
					1, -- [3]
					2, -- [4]
					3, -- [5]
					4, -- [6]
				},
				["sets"] = {
					"All", -- [1]
				},
				["w"] = 384.0000305175781,
				["leftSideFilter"] = true,
			},
			["bank"] = {
				["h"] = 512,
				["showBags"] = false,
				["exclude"] = {
					["All"] = {
						"All", -- [1]
						"Shards", -- [2]
						"Ammo", -- [3]
						"Keys", -- [4]
					},
				},
				["sets"] = {
					"All", -- [1]
					"Equipment", -- [2]
					"Trade Goods", -- [3]
					"Miscellaneous", -- [4]
				},
				["w"] = 512,
				["bags"] = {
					-1, -- [1]
					5, -- [2]
					6, -- [3]
					7, -- [4]
					8, -- [5]
					9, -- [6]
					10, -- [7]
					11, -- [8]
				},
			},
		},
	},
}
CombuctorVersion = nil
