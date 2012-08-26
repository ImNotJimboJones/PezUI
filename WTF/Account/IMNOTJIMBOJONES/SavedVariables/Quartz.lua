
Quartz3DB = {
	["namespaces"] = {
		["Swing"] = {
			["profiles"] = {
				["Default"] = {
					["swingposition"] = "free",
					["y"] = 287,
					["durationtext"] = false,
					["remainingtext"] = false,
					["x"] = 688,
					["swingheight"] = 2,
				},
				["HUNTER"] = {
					["y"] = 305,
					["x"] = 645,
					["remainingtext"] = false,
					["swingposition"] = "free",
					["durationtext"] = false,
					["swingheight"] = 2,
				},
			},
		},
		["Buff"] = {
		},
		["Interrupt"] = {
			["profiles"] = {
				["Default"] = {
					["interruptcolor"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						1, -- [4]
					},
				},
				["HUNTER"] = {
					["interruptcolor"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						1, -- [4]
					},
				},
			},
		},
		["Flight"] = {
		},
		["Pet"] = {
			["profiles"] = {
				["Default"] = {
					["h"] = 10,
					["w"] = 620,
					["y"] = 1240,
					["x"] = 3530.000247955319,
					["scale"] = 0.2000000029802322,
					["hidenametext"] = true,
					["hideicon"] = true,
				},
				["HUNTER"] = {
					["y"] = 1240,
					["h"] = 10,
					["hideicon"] = true,
					["scale"] = 0.2000000029802322,
					["x"] = 3530.000247955319,
					["w"] = 620,
					["hidenametext"] = true,
				},
			},
		},
		["EnemyCasts"] = {
		},
		["Player"] = {
			["profiles"] = {
				["Default"] = {
					["h"] = 15,
					["w"] = 230,
					["hideicon"] = true,
					["hidetimetext"] = true,
					["x"] = 683,
					["texture"] = "Steel",
					["y"] = 330,
				},
				["HUNTER"] = {
					["hideicon"] = true,
					["h"] = 15,
					["y"] = 350,
					["x"] = 641,
					["w"] = 245,
					["hidetimetext"] = true,
				},
			},
		},
		["GCD"] = {
			["profiles"] = {
				["Default"] = {
					["sparkcolor"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						1, -- [4]
					},
					["deplete"] = true,
				},
				["HUNTER"] = {
					["sparkcolor"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						1, -- [4]
					},
				},
			},
		},
		["Focus"] = {
			["profiles"] = {
				["Default"] = {
					["h"] = 17,
					["w"] = 198,
					["hideicon"] = true,
					["iconposition"] = "right",
					["texture"] = "Runes",
					["x"] = 420,
					["hidetimetext"] = true,
					["y"] = 342,
				},
				["HUNTER"] = {
					["y"] = 314,
					["x"] = 413,
					["hidetimetext"] = true,
					["hideicon"] = true,
					["w"] = 180,
					["iconposition"] = "right",
				},
			},
		},
		["Target"] = {
			["profiles"] = {
				["Default"] = {
					["h"] = 17,
					["w"] = 198,
					["y"] = 342,
					["texture"] = "Runes",
					["x"] = 978,
					["hidetimetext"] = true,
					["hideicon"] = true,
				},
				["HUNTER"] = {
					["hideicon"] = true,
					["x"] = 932.3998413085938,
					["y"] = 314,
					["w"] = 180,
					["hidetimetext"] = true,
				},
			},
		},
		["Range"] = {
		},
		["Mirror"] = {
			["profiles"] = {
				["Default"] = {
					["mirrortextcolor"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						1, -- [4]
					},
					["mirrortexture"] = "Steel",
					["mirrorwidth"] = 150,
					["mirrorposition"] = "top",
				},
				["HUNTER"] = {
					["mirrorposition"] = "top",
				},
			},
		},
		["Latency"] = {
			["profiles"] = {
				["Default"] = {
					["lagtext"] = false,
					["lagcolor"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						1, -- [4]
					},
					["lagalpha"] = 0.6000000238418579,
				},
				["HUNTER"] = {
					["lagcolor"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						1, -- [4]
					},
					["lagtext"] = false,
					["lagalpha"] = 0.6000000238418579,
				},
			},
		},
	},
	["profileKeys"] = {
		["Pezzer - Burning Blade"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["borderalpha"] = 0.5,
			["failcolor"] = {
				nil, -- [1]
				nil, -- [2]
				nil, -- [3]
				1, -- [4]
			},
			["backgroundalpha"] = 0.75,
			["modules"] = {
				["Swing"] = false,
				["Buff"] = false,
				["Timer"] = false,
				["Pet"] = false,
				["Latency"] = false,
			},
			["castingcolor"] = {
				nil, -- [1]
				0.4901960784313725, -- [2]
				nil, -- [3]
				1, -- [4]
			},
		},
		["HUNTER"] = {
			["modules"] = {
				["Timer"] = false,
				["Swing"] = false,
				["Buff"] = false,
			},
			["failcolor"] = {
				nil, -- [1]
				nil, -- [2]
				nil, -- [3]
				1, -- [4]
			},
			["backgroundalpha"] = 0.75,
			["borderalpha"] = 0.5,
		},
	},
}
