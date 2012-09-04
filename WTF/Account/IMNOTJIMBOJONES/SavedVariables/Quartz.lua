
Quartz3DB = {
	["namespaces"] = {
		["Swing"] = {
			["profiles"] = {
				["Default"] = {
					["swingposition"] = "free",
					["y"] = 287,
					["x"] = 688,
					["remainingtext"] = false,
					["durationtext"] = false,
					["swingheight"] = 2,
				},
				["HUNTER"] = {
					["y"] = 305,
					["x"] = 645,
					["remainingtext"] = false,
					["swingheight"] = 2,
					["durationtext"] = false,
					["swingposition"] = "free",
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
					["x"] = 3530.000247955319,
					["scale"] = 0.2000000029802322,
					["hidenametext"] = true,
					["y"] = 1240,
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
		["Player"] = {
			["profiles"] = {
				["Default"] = {
					["h"] = 17,
					["w"] = 225,
					["y"] = 390,
					["x"] = 842,
					["texture"] = "Steel",
					["hidetimetext"] = true,
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
		["EnemyCasts"] = {
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
					["h"] = 15,
					["y"] = 390,
					["x"] = 575,
					["hidetimetext"] = true,
					["texture"] = "Runes",
				},
				["HUNTER"] = {
					["y"] = 314,
					["x"] = 413,
					["iconposition"] = "right",
					["hideicon"] = true,
					["w"] = 180,
					["hidetimetext"] = true,
				},
			},
		},
		["Target"] = {
			["profiles"] = {
				["Default"] = {
					["h"] = 15,
					["y"] = 390,
					["iconposition"] = "left",
					["hidetimetext"] = true,
					["x"] = 1135,
					["texture"] = "Runes",
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
		["Range"] = {
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
			["castingcolor"] = {
				nil, -- [1]
				0.4901960784313725, -- [2]
				nil, -- [3]
				1, -- [4]
			},
			["modules"] = {
				["Swing"] = false,
				["Buff"] = false,
				["Timer"] = false,
				["Pet"] = false,
				["Latency"] = false,
			},
			["backgroundalpha"] = 0.75,
		},
		["HUNTER"] = {
			["modules"] = {
				["Timer"] = false,
				["Swing"] = false,
				["Buff"] = false,
			},
			["borderalpha"] = 0.5,
			["backgroundalpha"] = 0.75,
			["failcolor"] = {
				nil, -- [1]
				nil, -- [2]
				nil, -- [3]
				1, -- [4]
			},
		},
	},
}
