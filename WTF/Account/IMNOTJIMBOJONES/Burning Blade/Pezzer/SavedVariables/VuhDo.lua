
VUHDO_CONFIG = {
	["SMARTCAST_CLEANSE"] = true,
	["RANGE_SPELL"] = "",
	["BLIZZ_UI_HIDE_PARTY"] = true,
	["OMIT_PLAYER_TARGETS"] = false,
	["BLIZZ_UI_HIDE_TARGET"] = true,
	["DIRECTION"] = {
		["isAlways"] = false,
		["isDistanceText"] = false,
		["enable"] = true,
		["isDeadOnly"] = false,
		["scale"] = 76,
	},
	["STANDARD_TOOLTIP"] = true,
	["AOE_ADVISOR"] = {
		["subInc"] = true,
		["config"] = {
			["poh"] = {
				["enable"] = true,
				["thresh"] = 20000,
			},
			["coh"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
			["ef"] = {
				["enable"] = true,
				["thresh"] = 8000,
			},
			["tq"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
			["hr"] = {
				["enable"] = false,
				["thresh"] = 10000,
			},
			["wg"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
			["lod"] = {
				["enable"] = true,
				["thresh"] = 8000,
			},
			["ch"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
		},
		["knownOnly"] = true,
		["subIncOnlyCastTime"] = true,
		["isCooldown"] = true,
		["refresh"] = 800,
		["animate"] = true,
		["isGroupWise"] = false,
	},
	["LOCK_PANELS"] = true,
	["DEBUFF_TOOLTIP"] = true,
	["RANGE_PESSIMISTIC"] = true,
	["SMARTCAST_RESURRECT"] = true,
	["BLIZZ_UI_HIDE_PET"] = true,
	["SMARTCAST_BUFF"] = false,
	["HIDE_PANELS_PARTY"] = false,
	["SHOW_PANELS"] = true,
	["HIDE_EMPTY_PANELS"] = true,
	["RANGE_CHECK_DELAY"] = 260,
	["SHOW_MINIMAP"] = false,
	["DETECT_DEBUFFS_IGNORE_MOVEMENT"] = true,
	["IS_SCAN_TALENTS"] = true,
	["OMIT_OWN_GROUP"] = false,
	["MODE"] = 1,
	["BLIZZ_UI_HIDE_RAID"] = false,
	["DETECT_DEBUFFS_REMOVABLE_ONLY"] = true,
	["IS_READY_CHECK_DISABLED"] = true,
	["CLUSTER"] = {
		["REFRESH"] = 180,
		["CHAIN_MAX_JUMP"] = 3,
		["DISPLAY_DESTINATION"] = 2,
		["BELOW_HEALTH_PERC"] = 85,
		["CONE_DEGREES"] = 360,
		["RANGE"] = 30,
		["MODE"] = 1,
		["DISPLAY_SOURCE"] = 2,
		["TEXT"] = {
			["X_ADJUST"] = 40,
			["USE_MONO"] = false,
			["Y_ADJUST"] = 22,
			["ANCHOR"] = "BOTTOMRIGHT",
			["USE_OUTLINE"] = true,
			["SCALE"] = 85,
			["COLOR"] = {
				["TG"] = 1,
				["B"] = 0,
				["TB"] = 1,
				["G"] = 0,
				["TR"] = 1,
				["TO"] = 1,
				["R"] = 0,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_SHADOW"] = false,
		},
		["THRESH_GOOD"] = 5,
		["COOLDOWN_SPELL"] = "",
		["IS_NUMBER"] = true,
		["THRESH_FAIR"] = 3,
	},
	["OMIT_MAIN_ASSIST"] = false,
	["RES_ANNOUNCE_TEXT"] = "Rezing vuhdo...",
	["LOCK_IN_FIGHT"] = true,
	["IS_CLIQUE_COMPAT_MODE"] = false,
	["VERSION"] = 4,
	["DETECT_DEBUFFS_IGNORE_DURATION"] = true,
	["CUSTOM_DEBUFF"] = {
		["animate"] = true,
		["scale"] = 0.8,
		["STORED"] = {
			"Consuming Darkness", -- [1]
			"Constricting Chains", -- [2]
			"Parasitic Infection", -- [3]
			"Mangle", -- [4]
			"Poison Soaked Shell", -- [5]
			"Lightning Conductor", -- [6]
			"Incineration Security Measure", -- [7]
			"Flash Freeze", -- [8]
			"Biting Chill", -- [9]
			"Searing Flame", -- [10]
			"Roaring Flame", -- [11]
			"Sonic Breath", -- [12]
			"Break", -- [13]
			"Low Health", -- [14]
			"Blackout", -- [15]
			"Devouring Flames", -- [16]
			"Engulfing Magic", -- [17]
			"Malevolent Strikes", -- [18]
			"Hydro Lance", -- [19]
			"Waterlogged", -- [20]
			"Frozen", -- [21]
			"Flame Torrent", -- [22]
			"Lightning Rod", -- [23]
			"Gravity Core", -- [24]
			"Gravity Crush", -- [25]
			"Cho's Blast", -- [26]
			"Gall's Blast", -- [27]
			"Ice Patch", -- [28]
			"Soothing Breeze", -- [29]
			"Toxic Spores", -- [30]
			"Slicing Gale", -- [31]
			"Ice Storm", -- [32]
			"Corruption: Accelerated", -- [33]
			"Electrical Storm", -- [34]
			"Plucked", -- [35]
			"Grievous Throw", -- [36]
			"Flame Shock", -- [37]
			"Flame Breath", -- [38]
			"Siphon Soul", -- [39]
			"Body Slam", -- [40]
			"Lash of Anguish", -- [41]
			"Ravage", -- [42]
			"Decapitate", -- [43]
			"Bloodletting", -- [44]
			"Whispers of Hethiss", -- [45]
			"Toxic Link", -- [46]
			"Pursuit", -- [47]
			"Toxic Torment", -- [48]
			"Burning Blood", -- [49]
			"Frostburn Formula", -- [50]
			"Wrack", -- [51]
			"The Widow's Kiss", -- [52]
			"Fieroblast", -- [53]
			"Gushing Wound", -- [54]
			"Crystal Prison Trap Effect", -- [55]
			"Jagged Tear", -- [56]
			"Torment", -- [57]
			"Blaze of Glory", -- [58]
			"Searing Seeds", -- [59]
			"Burning Wound", -- [60]
			"Melt Armor", -- [61]
			"Crush Armor", -- [62]
			"Ice Tomb", -- [63]
			"Watery Entrenchment", -- [64]
			"Shattered Ice", -- [65]
			"Twilight Barrage", -- [66]
			"Shockwave", -- [67]
			"Sunder Armor", -- [68]
			"Brutal Strike", -- [69]
			"Degeneration", -- [70]
			"Heroic Will", -- [71]
			"Twilight Shift", -- [72]
			"Twilight Burst", -- [73]
			"Faded Into Twilight", -- [74]
			"Fading Light", -- [75]
			"Deep Corruption", -- [76]
			"Disrupting Shadows", -- [77]
			"Black Blood of Go'rath", -- [78]
			"Grasping Tendrils", -- [79]
			"Fiery Grip", -- [80]
			"Searing Plasma", -- [81]
			"Blood Corruption: Death", -- [82]
			"Blood Corruption: Earth", -- [83]
			"Degradation", -- [84]
			"Degenerative Bite", -- [85]
			"Blistering Heat", -- [86]
			"Tetanus", -- [87]
		},
		["isIcon"] = true,
		["selected"] = "",
		["TIMER_TEXT"] = {
			["X_ADJUST"] = 20,
			["USE_MONO"] = false,
			["Y_ADJUST"] = 26,
			["ANCHOR"] = "BOTTOMRIGHT",
			["USE_OUTLINE"] = false,
			["SCALE"] = 85,
			["COLOR"] = {
				["TG"] = 1,
				["R"] = 0,
				["TB"] = 1,
				["G"] = 0,
				["TR"] = 1,
				["TO"] = 1,
				["useOpacity"] = true,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 1,
				["B"] = 0,
			},
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_SHADOW"] = true,
		},
		["yAdjust"] = -34,
		["isColor"] = false,
		["version"] = 19,
		["isStacks"] = false,
		["STORED_SETTINGS"] = {
			["Blood Corruption: Earth"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blackout"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Crush Armor"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Cho's Blast"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Torment"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Tetanus"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gravity Core"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Mangle"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lightning Rod"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Twilight Shift"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Melt Armor"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Toxic Link"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pursuit"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fading Light"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lightning Conductor"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Grievous Throw"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blaze of Glory"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ice Storm"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Decapitate"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Grasping Tendrils"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blood Corruption: Death"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Electrical Storm"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Jagged Tear"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flash Freeze"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gall's Blast"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Toxic Torment"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Degenerative Bite"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lash of Anguish"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sunder Armor"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shockwave"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Biting Chill"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Burning Wound"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Whispers of Hethiss"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shattered Ice"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fieroblast"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Devouring Flames"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Degradation"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Watery Entrenchment"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Black Blood of Go'rath"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Consuming Darkness"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Waterlogged"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Twilight Burst"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Constricting Chains"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Bloodletting"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Brutal Strike"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ravage"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Break"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flame Shock"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Faded Into Twilight"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Searing Seeds"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Disrupting Shadows"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Searing Plasma"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Degeneration"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frostburn Formula"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frozen"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gushing Wound"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Slicing Gale"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Twilight Barrage"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Wrack"] = {
				["isStacks"] = false,
				["isAliveTime"] = true,
				["isFullDuration"] = true,
				["isIcon"] = true,
				["timer"] = true,
				["isColor"] = false,
				["animate"] = true,
			},
			["Crystal Prison Trap Effect"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Heroic Will"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Soothing Breeze"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flame Torrent"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Body Slam"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ice Tomb"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ice Patch"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sonic Breath"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Malevolent Strikes"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Deep Corruption"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Engulfing Magic"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Roaring Flame"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["The Widow's Kiss"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Siphon Soul"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Low Health"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Incineration Security Measure"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Toxic Spores"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gravity Crush"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blistering Heat"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Parasitic Infection"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Searing Flame"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fiery Grip"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Corruption: Accelerated"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Plucked"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Hydro Lance"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Burning Blood"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flame Breath"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Poison Soaked Shell"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
		},
		["COUNTER_TEXT"] = {
			["X_ADJUST"] = -10,
			["USE_MONO"] = false,
			["Y_ADJUST"] = -15,
			["ANCHOR"] = "TOPLEFT",
			["USE_OUTLINE"] = false,
			["SCALE"] = 70,
			["COLOR"] = {
				["TG"] = 1,
				["B"] = 0,
				["TB"] = 0,
				["G"] = 0,
				["TR"] = 0,
				["TO"] = 1,
				["R"] = 0,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_SHADOW"] = true,
		},
		["point"] = "TOPRIGHT",
		["timer"] = true,
		["isName"] = false,
		["xAdjust"] = -2,
		["max_num"] = 3,
	},
	["PARSE_COMBAT_LOG"] = true,
	["ON_MOUSE_UP"] = false,
	["OMIT_TARGET"] = false,
	["IS_SHOW_GCD"] = false,
	["BLIZZ_UI_HIDE_FOCUS"] = true,
	["DETECT_DEBUFFS_IGNORE_NO_HARM"] = true,
	["DETECT_DEBUFFS_IGNORE_BY_CLASS"] = true,
	["OMIT_MAIN_TANKS"] = false,
	["SCAN_RANGE"] = "1",
	["SHOW_PLAYER_TAGS"] = true,
	["SHOW_OVERHEAL"] = true,
	["UPDATE_HOTS_MS"] = 250,
	["OMIT_DFT_MTS"] = false,
	["BLIZZ_UI_HIDE_PLAYER"] = true,
	["HIDE_PANELS_SOLO"] = false,
	["CURRENT_PROFILE"] = "Default 10",
	["EMERGENCY_TRIGGER"] = 100,
	["SHOW_INCOMING"] = true,
	["IS_SHARE"] = true,
	["OMIT_FOCUS"] = false,
	["HIDE_EMPTY_BUTTONS"] = true,
	["MAX_EMERGENCIES"] = 5,
	["OMIT_SELF"] = false,
	["LOCK_CLICKS_THROUGH"] = false,
	["BLIZZ_UI_HIDE_RAID_MGR"] = false,
	["IS_ALWAYS_OVERWRITE_PROFILE"] = false,
	["AUTO_PROFILES"] = {
		["1"] = "Default Solo 2",
		["40"] = "Default 40",
		["5"] = "Default 5",
		["25"] = "Default 25",
		["10"] = "Default 10",
	},
	["THREAT"] = {
		["AGGRO_USE_TEXT"] = false,
		["AGGRO_TEXT_LEFT"] = ">>",
		["IS_TANK_MODE"] = false,
		["AGGRO_TEXT_RIGHT"] = "<<",
		["AGGRO_REFRESH_MS"] = 300,
	},
	["SHOW_TEXT_OVERHEAL"] = true,
	["IS_USE_BUTTON_FACADE"] = false,
	["SHOW_OWN_INCOMING"] = true,
	["IS_DC_SHIELD_DISABLED"] = false,
	["RES_IS_SHOW_TEXT"] = true,
}
VUHDO_PANEL_SETUP = {
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 120.7808685302734,
			["x"] = 722.76708984375,
			["orientation"] = "TOP",
			["relativePoint"] = "BOTTOMLEFT",
			["scale"] = 1,
			["height"] = 85,
			["growth"] = "TOP",
			["width"] = 354.9999694824219,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 0.7,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["groups"] = {
				1, -- [1]
				2, -- [2]
			},
			["sort"] = 1,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 0,
				["useOpacity"] = true,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["R"] = 1,
				["TB"] = 0.38,
				["barTexture"] = "LiteStepLite",
				["G"] = 1,
				["TR"] = 1,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["B"] = 1,
				["O"] = 0.4,
				["useText"] = true,
				["textSize"] = 10,
				["useBackground"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["file"] = "Interface\\None",
				["O"] = 0,
				["insets"] = 1,
			},
			["barTexture"] = "Minimalist",
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["maxChars"] = 0,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["textSize"] = 9,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 12,
				["useOpacity"] = true,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["rowSpacing"] = 5,
			["targetWidth"] = 30,
			["scale"] = 1,
			["barHeight"] = 35,
			["barWidth"] = 65,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["targetSpacing"] = 3,
			["targetOrientation"] = 1,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 2,
			["sideLeftWidth"] = 6,
			["sideRightWidth"] = 6,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["manaBarHeight"] = 3,
			["headerWidth"] = 100,
			["isPlayerOnTop"] = true,
			["showHeaders"] = false,
			["isDamFlash"] = true,
			["showTot"] = false,
			["totWidth"] = 30,
			["totSpacing"] = 3,
			["isTarClassColBack"] = false,
			["arrangeHorizontal"] = true,
			["isTarClassColText"] = true,
			["damFlashFactor"] = 0.75,
			["maxColumnsWhenStructured"] = 5,
			["alignBottom"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["_spacing"] = 21.00000190734863,
			["xAdjust"] = 2,
			["showPetOwners"] = false,
		},
	}, -- [1]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 32.51734161376953,
			["x"] = 722.65283203125,
			["orientation"] = "TOP",
			["relativePoint"] = "BOTTOMLEFT",
			["scale"] = 1,
			["height"] = 30,
			["growth"] = "TOP",
			["width"] = 115.9999923706055,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 0.7,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
			["groups"] = {
				40, -- [1]
			},
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 0,
				["useOpacity"] = true,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["R"] = 1,
				["TB"] = 0.38,
				["barTexture"] = "LiteStepLite",
				["G"] = 1,
				["TR"] = 1,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["B"] = 1,
				["O"] = 0.4,
				["useText"] = true,
				["textSize"] = 10,
				["useBackground"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["file"] = "Interface\\None",
				["O"] = 0,
				["insets"] = 1,
			},
			["barTexture"] = "Minimalist",
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["maxChars"] = 0,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["textSize"] = 7,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 9,
				["useOpacity"] = true,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["rowSpacing"] = 50,
			["targetWidth"] = 30,
			["scale"] = 1,
			["barHeight"] = 20,
			["barWidth"] = 50,
			["columnSpacing"] = 6,
			["borderGapY"] = 5,
			["targetSpacing"] = 3,
			["targetOrientation"] = 1,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 2,
			["sideLeftWidth"] = 6,
			["sideRightWidth"] = 6,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["manaBarHeight"] = 3,
			["headerWidth"] = 100,
			["isPlayerOnTop"] = true,
			["showHeaders"] = false,
			["isDamFlash"] = true,
			["showTot"] = false,
			["totWidth"] = 30,
			["totSpacing"] = 3,
			["isTarClassColBack"] = false,
			["arrangeHorizontal"] = true,
			["isTarClassColText"] = true,
			["damFlashFactor"] = 0.75,
			["maxColumnsWhenStructured"] = 6,
			["alignBottom"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 0,
			["_spacing"] = 16.00000190734863,
			["xAdjust"] = 2,
			["showPetOwners"] = false,
		},
	}, -- [2]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 99.99999237060547,
			["orientation"] = "TOPLEFT",
			["relativePoint"] = "BOTTOMLEFT",
			["scale"] = 1,
			["height"] = 124.7500076293945,
			["growth"] = "TOP",
			["width"] = 85,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 0.7,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 0,
				["useOpacity"] = true,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["R"] = 1,
				["TB"] = 0.38,
				["barTexture"] = "LiteStepLite",
				["G"] = 1,
				["TR"] = 1,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["B"] = 1,
				["O"] = 0.4,
				["useText"] = true,
				["textSize"] = 10,
				["useBackground"] = true,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["maxChars"] = 0,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["textSize"] = 9,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 12,
				["useOpacity"] = true,
			},
			["barTexture"] = "Minimalist",
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["file"] = "Interface\\None",
				["O"] = 0,
				["insets"] = 1,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["rowSpacing"] = 5,
			["targetWidth"] = 30,
			["scale"] = 1,
			["barHeight"] = 35,
			["barWidth"] = 65,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["targetSpacing"] = 3,
			["targetOrientation"] = 1,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 2,
			["sideLeftWidth"] = 6,
			["sideRightWidth"] = 6,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["manaBarHeight"] = 3,
			["headerWidth"] = 100,
			["isPlayerOnTop"] = true,
			["showHeaders"] = false,
			["isDamFlash"] = true,
			["showTot"] = false,
			["totWidth"] = 30,
			["totSpacing"] = 3,
			["isTarClassColBack"] = false,
			["arrangeHorizontal"] = true,
			["isTarClassColText"] = true,
			["damFlashFactor"] = 0.75,
			["maxColumnsWhenStructured"] = 5,
			["alignBottom"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["_spacing"] = 18,
			["xAdjust"] = 2,
			["showPetOwners"] = false,
		},
	}, -- [3]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 99.99999237060547,
			["orientation"] = "TOPLEFT",
			["relativePoint"] = "BOTTOMLEFT",
			["scale"] = 1,
			["height"] = 124.7500076293945,
			["growth"] = "TOP",
			["width"] = 85,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 0.7,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 0,
				["useOpacity"] = true,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["R"] = 1,
				["TB"] = 0.38,
				["barTexture"] = "LiteStepLite",
				["G"] = 1,
				["TR"] = 1,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["B"] = 1,
				["O"] = 0.4,
				["useText"] = true,
				["textSize"] = 10,
				["useBackground"] = true,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["maxChars"] = 0,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["textSize"] = 9,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 12,
				["useOpacity"] = true,
			},
			["barTexture"] = "Minimalist",
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["file"] = "Interface\\None",
				["O"] = 0,
				["insets"] = 1,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["rowSpacing"] = 5,
			["targetWidth"] = 30,
			["scale"] = 1,
			["barHeight"] = 35,
			["barWidth"] = 65,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["targetSpacing"] = 3,
			["targetOrientation"] = 1,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 2,
			["sideLeftWidth"] = 6,
			["sideRightWidth"] = 6,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["manaBarHeight"] = 3,
			["headerWidth"] = 100,
			["isPlayerOnTop"] = true,
			["showHeaders"] = false,
			["isDamFlash"] = true,
			["showTot"] = false,
			["totWidth"] = 30,
			["totSpacing"] = 3,
			["isTarClassColBack"] = false,
			["arrangeHorizontal"] = true,
			["isTarClassColText"] = true,
			["damFlashFactor"] = 0.75,
			["maxColumnsWhenStructured"] = 5,
			["alignBottom"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["_spacing"] = 18,
			["xAdjust"] = 2,
			["showPetOwners"] = false,
		},
	}, -- [4]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["orientation"] = "TOPLEFT",
			["relativePoint"] = "BOTTOMLEFT",
			["scale"] = 1,
			["height"] = 200,
			["growth"] = "TOP",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 0.7,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 0,
				["useOpacity"] = true,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["R"] = 1,
				["TB"] = 0.38,
				["barTexture"] = "LiteStepLite",
				["G"] = 1,
				["TR"] = 1,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["B"] = 1,
				["O"] = 0.4,
				["useText"] = true,
				["textSize"] = 10,
				["useBackground"] = true,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["maxChars"] = 0,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["textSize"] = 9,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 12,
				["useOpacity"] = true,
			},
			["barTexture"] = "Minimalist",
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["file"] = "Interface\\None",
				["O"] = 0,
				["insets"] = 1,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["rowSpacing"] = 5,
			["targetWidth"] = 30,
			["scale"] = 1,
			["barHeight"] = 35,
			["barWidth"] = 65,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["targetSpacing"] = 3,
			["targetOrientation"] = 1,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 2,
			["sideLeftWidth"] = 6,
			["sideRightWidth"] = 6,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["manaBarHeight"] = 3,
			["headerWidth"] = 100,
			["isPlayerOnTop"] = true,
			["showHeaders"] = false,
			["isDamFlash"] = true,
			["showTot"] = false,
			["totWidth"] = 30,
			["totSpacing"] = 3,
			["isTarClassColBack"] = false,
			["arrangeHorizontal"] = true,
			["isTarClassColText"] = true,
			["damFlashFactor"] = 0.75,
			["maxColumnsWhenStructured"] = 5,
			["alignBottom"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["xAdjust"] = 2,
			["showPetOwners"] = false,
		},
	}, -- [5]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["orientation"] = "TOPLEFT",
			["relativePoint"] = "BOTTOMLEFT",
			["scale"] = 1,
			["height"] = 200,
			["growth"] = "TOP",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 0.7,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 0,
				["useOpacity"] = true,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["R"] = 1,
				["TB"] = 0.38,
				["barTexture"] = "LiteStepLite",
				["G"] = 1,
				["TR"] = 1,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["B"] = 1,
				["O"] = 0.4,
				["useText"] = true,
				["textSize"] = 10,
				["useBackground"] = true,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["maxChars"] = 0,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["textSize"] = 9,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 12,
				["useOpacity"] = true,
			},
			["barTexture"] = "Minimalist",
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["file"] = "Interface\\None",
				["O"] = 0,
				["insets"] = 1,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["rowSpacing"] = 5,
			["targetWidth"] = 30,
			["scale"] = 1,
			["barHeight"] = 35,
			["barWidth"] = 65,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["targetSpacing"] = 3,
			["targetOrientation"] = 1,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 2,
			["sideLeftWidth"] = 6,
			["sideRightWidth"] = 6,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["manaBarHeight"] = 3,
			["headerWidth"] = 100,
			["isPlayerOnTop"] = true,
			["showHeaders"] = false,
			["isDamFlash"] = true,
			["showTot"] = false,
			["totWidth"] = 30,
			["totSpacing"] = 3,
			["isTarClassColBack"] = false,
			["arrangeHorizontal"] = true,
			["isTarClassColText"] = true,
			["damFlashFactor"] = 0.75,
			["maxColumnsWhenStructured"] = 5,
			["alignBottom"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["xAdjust"] = 2,
			["showPetOwners"] = false,
		},
	}, -- [6]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["orientation"] = "TOPLEFT",
			["relativePoint"] = "BOTTOMLEFT",
			["scale"] = 1,
			["height"] = 200,
			["growth"] = "TOP",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 0.7,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 0,
				["useOpacity"] = true,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["R"] = 1,
				["TB"] = 0.38,
				["barTexture"] = "LiteStepLite",
				["G"] = 1,
				["TR"] = 1,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["B"] = 1,
				["O"] = 0.4,
				["useText"] = true,
				["textSize"] = 10,
				["useBackground"] = true,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["maxChars"] = 0,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["textSize"] = 9,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 12,
				["useOpacity"] = true,
			},
			["barTexture"] = "Minimalist",
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["file"] = "Interface\\None",
				["O"] = 0,
				["insets"] = 1,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["rowSpacing"] = 5,
			["targetWidth"] = 30,
			["scale"] = 1,
			["barHeight"] = 35,
			["barWidth"] = 65,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["targetSpacing"] = 3,
			["targetOrientation"] = 1,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 2,
			["sideLeftWidth"] = 6,
			["sideRightWidth"] = 6,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["manaBarHeight"] = 3,
			["headerWidth"] = 100,
			["isPlayerOnTop"] = true,
			["showHeaders"] = false,
			["isDamFlash"] = true,
			["showTot"] = false,
			["totWidth"] = 30,
			["totSpacing"] = 3,
			["isTarClassColBack"] = false,
			["arrangeHorizontal"] = true,
			["isTarClassColText"] = true,
			["damFlashFactor"] = 0.75,
			["maxColumnsWhenStructured"] = 5,
			["alignBottom"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["xAdjust"] = 2,
			["showPetOwners"] = false,
		},
	}, -- [7]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["orientation"] = "TOPLEFT",
			["relativePoint"] = "BOTTOMLEFT",
			["scale"] = 1,
			["height"] = 200,
			["growth"] = "TOP",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 0.7,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 0,
				["useOpacity"] = true,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["R"] = 1,
				["TB"] = 0.38,
				["barTexture"] = "LiteStepLite",
				["G"] = 1,
				["TR"] = 1,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["B"] = 1,
				["O"] = 0.4,
				["useText"] = true,
				["textSize"] = 10,
				["useBackground"] = true,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["maxChars"] = 0,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["textSize"] = 9,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 12,
				["useOpacity"] = true,
			},
			["barTexture"] = "Minimalist",
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["file"] = "Interface\\None",
				["O"] = 0,
				["insets"] = 1,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["rowSpacing"] = 5,
			["targetWidth"] = 30,
			["scale"] = 1,
			["barHeight"] = 35,
			["barWidth"] = 65,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["targetSpacing"] = 3,
			["targetOrientation"] = 1,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 2,
			["sideLeftWidth"] = 6,
			["sideRightWidth"] = 6,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["manaBarHeight"] = 3,
			["headerWidth"] = 100,
			["isPlayerOnTop"] = true,
			["showHeaders"] = false,
			["isDamFlash"] = true,
			["showTot"] = false,
			["totWidth"] = 30,
			["totSpacing"] = 3,
			["isTarClassColBack"] = false,
			["arrangeHorizontal"] = true,
			["isTarClassColText"] = true,
			["damFlashFactor"] = 0.75,
			["maxColumnsWhenStructured"] = 5,
			["alignBottom"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["xAdjust"] = 2,
			["showPetOwners"] = false,
		},
	}, -- [8]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["orientation"] = "TOPLEFT",
			["relativePoint"] = "BOTTOMLEFT",
			["scale"] = 1,
			["height"] = 200,
			["growth"] = "TOP",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 0.7,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 0,
				["useOpacity"] = true,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["R"] = 1,
				["TB"] = 0.38,
				["barTexture"] = "LiteStepLite",
				["G"] = 1,
				["TR"] = 1,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["B"] = 1,
				["O"] = 0.4,
				["useText"] = true,
				["textSize"] = 10,
				["useBackground"] = true,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["maxChars"] = 0,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["textSize"] = 9,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 12,
				["useOpacity"] = true,
			},
			["barTexture"] = "Minimalist",
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["file"] = "Interface\\None",
				["O"] = 0,
				["insets"] = 1,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["rowSpacing"] = 5,
			["targetWidth"] = 30,
			["scale"] = 1,
			["barHeight"] = 35,
			["barWidth"] = 65,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["targetSpacing"] = 3,
			["targetOrientation"] = 1,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 2,
			["sideLeftWidth"] = 6,
			["sideRightWidth"] = 6,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["manaBarHeight"] = 3,
			["headerWidth"] = 100,
			["isPlayerOnTop"] = true,
			["showHeaders"] = false,
			["isDamFlash"] = true,
			["showTot"] = false,
			["totWidth"] = 30,
			["totSpacing"] = 3,
			["isTarClassColBack"] = false,
			["arrangeHorizontal"] = true,
			["isTarClassColText"] = true,
			["damFlashFactor"] = 0.75,
			["maxColumnsWhenStructured"] = 5,
			["alignBottom"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["xAdjust"] = 2,
			["showPetOwners"] = false,
		},
	}, -- [9]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["orientation"] = "TOPLEFT",
			["relativePoint"] = "BOTTOMLEFT",
			["scale"] = 1,
			["height"] = 200,
			["growth"] = "TOP",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 0.7,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 0,
				["useOpacity"] = true,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["R"] = 1,
				["TB"] = 0.38,
				["barTexture"] = "LiteStepLite",
				["G"] = 1,
				["TR"] = 1,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["B"] = 1,
				["O"] = 0.4,
				["useText"] = true,
				["textSize"] = 10,
				["useBackground"] = true,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["maxChars"] = 0,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["textSize"] = 9,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 12,
				["useOpacity"] = true,
			},
			["barTexture"] = "Minimalist",
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["file"] = "Interface\\None",
				["O"] = 0,
				["insets"] = 1,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["rowSpacing"] = 5,
			["targetWidth"] = 30,
			["scale"] = 1,
			["barHeight"] = 35,
			["barWidth"] = 65,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["targetSpacing"] = 3,
			["targetOrientation"] = 1,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 2,
			["sideLeftWidth"] = 6,
			["sideRightWidth"] = 6,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["manaBarHeight"] = 3,
			["headerWidth"] = 100,
			["isPlayerOnTop"] = true,
			["showHeaders"] = false,
			["isDamFlash"] = true,
			["showTot"] = false,
			["totWidth"] = 30,
			["totSpacing"] = 3,
			["isTarClassColBack"] = false,
			["arrangeHorizontal"] = true,
			["isTarClassColText"] = true,
			["damFlashFactor"] = 0.75,
			["maxColumnsWhenStructured"] = 5,
			["alignBottom"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["xAdjust"] = 2,
			["showPetOwners"] = false,
		},
	}, -- [10]
	["RAID_ICON_FILTER"] = {
		true, -- [1]
		true, -- [2]
		true, -- [3]
		true, -- [4]
		true, -- [5]
		true, -- [6]
		true, -- [7]
		true, -- [8]
	},
	["PANEL_COLOR"] = {
		["TEXT"] = {
			["TR"] = 1,
			["TO"] = 1,
			["TB"] = 0,
			["useText"] = true,
			["TG"] = 0.82,
		},
		["HEALTH_TEXT"] = {
			["TR"] = 1,
			["TO"] = 1,
			["TB"] = 0,
			["useText"] = false,
			["TG"] = 0,
		},
		["BARS"] = {
			["useBackground"] = true,
			["R"] = 0.7,
			["B"] = 0.7,
			["G"] = 0.7,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["classColorsName"] = true,
	},
	["HOTS"] = {
		["iconRadioValue"] = 2,
		["SLOTS"] = {
			"Mend Pet", -- [1]
			[10] = "BOUQUET_AOE Advice",
		},
		["BARS"] = {
			["radioValue"] = 1,
			["width"] = 25,
		},
		["TIMER_TEXT"] = {
			["X_ADJUST"] = 25,
			["SCALE"] = 60,
			["USE_MONO"] = false,
			["Y_ADJUST"] = 0,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_SHADOW"] = false,
			["ANCHOR"] = "BOTTOMRIGHT",
			["USE_OUTLINE"] = true,
		},
		["radioValue"] = 20,
		["SLOTCFG"] = {
			["1"] = {
				["scale"] = 1,
				["mine"] = true,
				["others"] = false,
			},
			["3"] = {
				["scale"] = 1,
				["mine"] = true,
				["others"] = false,
			},
			["2"] = {
				["scale"] = 1,
				["mine"] = true,
				["others"] = false,
			},
			["5"] = {
				["scale"] = 1,
				["mine"] = true,
				["others"] = false,
			},
			["4"] = {
				["scale"] = 1,
				["mine"] = true,
				["others"] = false,
			},
			["7"] = {
				["scale"] = 1,
				["mine"] = true,
				["others"] = false,
			},
			["6"] = {
				["scale"] = 1,
				["mine"] = true,
				["others"] = false,
			},
			["9"] = {
				["scale"] = 1,
				["mine"] = true,
				["others"] = false,
			},
			["8"] = {
				["scale"] = 1,
				["mine"] = true,
				["others"] = false,
			},
			["10"] = {
				["scale"] = 1.5,
				["mine"] = true,
				["others"] = false,
			},
		},
		["stacksRadioValue"] = 3,
		["COUNTER_TEXT"] = {
			["X_ADJUST"] = -25,
			["SCALE"] = 66,
			["USE_MONO"] = false,
			["Y_ADJUST"] = 0,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_SHADOW"] = false,
			["ANCHOR"] = "TOPLEFT",
			["USE_OUTLINE"] = true,
		},
	},
	["BAR_COLORS"] = {
		["OVERHEAL_TEXT"] = {
			["TR"] = 0.8,
			["TO"] = 1,
			["TB"] = 0.8,
			["useOpacity"] = true,
			["useText"] = true,
			["TG"] = 1,
		},
		["HOT7"] = {
			["useBackground"] = true,
			["R"] = 1,
			["B"] = 1,
			["O"] = 0.75,
			["G"] = 1,
		},
		["TARGET"] = {
			["TG"] = 1,
			["R"] = 0,
			["TB"] = 1,
			["G"] = 1,
			["modeText"] = 2,
			["TR"] = 1,
			["B"] = 0,
			["TO"] = 1,
			["useOpacity"] = true,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["modeBack"] = 1,
		},
		["HOT1"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["B"] = 0.3,
			["TB"] = 0.6,
			["G"] = 0.3,
			["TR"] = 1,
			["R"] = 1,
			["TO"] = 1,
			["isClock"] = false,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["useDebuffIconBossOnly"] = true,
		["EMERGENCY"] = {
			["TG"] = 0.82,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["BAR_FRAMES"] = {
			["useBackground"] = true,
			["R"] = 0,
			["B"] = 0,
			["G"] = 0,
			["O"] = 0.7,
			["useOpacity"] = true,
		},
		["RAID_ICONS"] = {
			["1"] = {
				["TG"] = 1,
				["B"] = 0.305,
				["TB"] = 0.607,
				["G"] = 0.976,
				["TR"] = 0.98,
				["TO"] = 1,
				["R"] = 1,
				["useBackground"] = true,
				["O"] = 1,
				["useText"] = true,
			},
			["filterOnly"] = false,
			["3"] = {
				["TG"] = 0.674,
				["B"] = 0.8,
				["TB"] = 0.921,
				["G"] = 0.29,
				["TR"] = 1,
				["TO"] = 1,
				["R"] = 0.788,
				["useBackground"] = true,
				["O"] = 1,
				["useText"] = true,
			},
			["2"] = {
				["TG"] = 0.827,
				["B"] = 0.039,
				["TB"] = 0.419,
				["G"] = 0.513,
				["TR"] = 1,
				["TO"] = 1,
				["R"] = 1,
				["useBackground"] = true,
				["O"] = 1,
				["useText"] = true,
			},
			["enable"] = false,
			["4"] = {
				["TG"] = 1,
				["B"] = 0.015,
				["TB"] = 0.698,
				["G"] = 0.8,
				["TR"] = 0.698,
				["TO"] = 1,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["useText"] = true,
			},
			["7"] = {
				["TG"] = 0.627,
				["B"] = 0.129,
				["TB"] = 0.619,
				["G"] = 0.184,
				["TR"] = 1,
				["TO"] = 1,
				["R"] = 0.8,
				["useBackground"] = true,
				["O"] = 1,
				["useText"] = true,
			},
			["6"] = {
				["TG"] = 0.831,
				["B"] = 0.972,
				["TB"] = 1,
				["G"] = 0.6899999999999999,
				["TR"] = 0.662,
				["TO"] = 1,
				["R"] = 0.121,
				["useBackground"] = true,
				["O"] = 1,
				["useText"] = true,
			},
			["8"] = {
				["TG"] = 0.231,
				["B"] = 0.89,
				["TB"] = 0.231,
				["G"] = 0.866,
				["TR"] = 0.231,
				["TO"] = 1,
				["R"] = 0.847,
				["useBackground"] = true,
				["O"] = 1,
				["useText"] = true,
			},
			["5"] = {
				["TG"] = 0.87,
				["B"] = 0.8,
				["TB"] = 1,
				["G"] = 0.717,
				["TR"] = 0.725,
				["TO"] = 1,
				["R"] = 0.466,
				["useBackground"] = true,
				["O"] = 1,
				["useText"] = true,
			},
		},
		["useDebuffIcon"] = true,
		["HOT9"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["B"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["TR"] = 0.6,
			["R"] = 0.3,
			["TO"] = 1,
			["isClock"] = false,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["TAPPED"] = {
			["TG"] = 0.4,
			["B"] = 0.4,
			["TB"] = 0.4,
			["G"] = 0.4,
			["TR"] = 0.4,
			["TO"] = 1,
			["R"] = 0.4,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["HOT_CHARGE_3"] = {
			["TG"] = 1,
			["B"] = 0.3,
			["TB"] = 0.6,
			["G"] = 1,
			["TR"] = 0.6,
			["TO"] = 1,
			["R"] = 0.3,
			["useBackground"] = true,
			["O"] = 1,
			["useText"] = true,
		},
		["CLUSTER_GOOD"] = {
			["TG"] = 1,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 0.8,
			["TR"] = 0,
			["TO"] = 1,
			["R"] = 0,
			["useBackground"] = true,
			["O"] = 1,
			["useText"] = true,
		},
		["DEBUFF3"] = {
			["TG"] = 0.957,
			["B"] = 0.8,
			["TB"] = 1,
			["G"] = 0.4,
			["TR"] = 0.329,
			["TO"] = 1,
			["R"] = 0.4,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["INCOMING"] = {
			["TG"] = 0.82,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 0,
			["useBackground"] = false,
			["useText"] = false,
			["O"] = 0.33,
			["useOpacity"] = true,
		},
		["HOT6"] = {
			["useBackground"] = true,
			["R"] = 1,
			["B"] = 1,
			["O"] = 0.75,
			["G"] = 1,
		},
		["TARGET_ENEMY"] = {
			["TG"] = 0,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["DEBUFF4"] = {
			["TG"] = 0,
			["B"] = 0.7,
			["TB"] = 1,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 0.7,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["DEBUFF1"] = {
			["TG"] = 1,
			["B"] = 0.8,
			["TB"] = 0.6860000000000001,
			["G"] = 0.592,
			["TR"] = 0,
			["TO"] = 1,
			["R"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["TARGET_NEUTRAL"] = {
			["TG"] = 1,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["R"] = 1,
		},
		["TARGET_FRIEND"] = {
			["TG"] = 1,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 1,
			["TR"] = 0,
			["TO"] = 1,
			["R"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["NO_EMERGENCY"] = {
			["TG"] = 0.82,
			["B"] = 0.4,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["HOTS"] = {
			["useColorText"] = true,
			["useColorBack"] = true,
			["isPumpDivineAegis"] = false,
			["isFadeOut"] = false,
			["isFlashWhenLow"] = false,
			["showShieldAbsorb"] = true,
			["WARNING"] = {
				["TG"] = 0.6,
				["lowSecs"] = 3,
				["B"] = 0.2,
				["TB"] = 0.6,
				["G"] = 0.2,
				["TR"] = 1,
				["TO"] = 1,
				["R"] = 0.5,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 1,
				["enabled"] = false,
			},
		},
		["GCD_BAR"] = {
			["useBackground"] = true,
			["R"] = 0.4,
			["B"] = 0.4,
			["O"] = 0.5,
			["G"] = 0.4,
		},
		["IRRELEVANT"] = {
			["TG"] = 0.82,
			["B"] = 0.4,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 0,
			["useBackground"] = false,
			["useText"] = false,
			["O"] = 0.2,
			["useOpacity"] = true,
		},
		["HOT2"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["B"] = 0.3,
			["TB"] = 0.6,
			["G"] = 1,
			["TR"] = 1,
			["R"] = 1,
			["TO"] = 1,
			["isClock"] = false,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["DEAD"] = {
			["TG"] = 0.5,
			["B"] = 0.3,
			["TB"] = 0.5,
			["G"] = 0.3,
			["TR"] = 0.5,
			["TO"] = 1,
			["R"] = 0.3,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.5,
			["useOpacity"] = true,
		},
		["HOT5"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["B"] = 1,
			["TB"] = 1,
			["G"] = 0.3,
			["TR"] = 1,
			["R"] = 1,
			["TO"] = 1,
			["isClock"] = false,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["OFFLINE"] = {
			["TG"] = 0.576,
			["B"] = 0.298,
			["TB"] = 0.576,
			["G"] = 0.298,
			["TR"] = 0.576,
			["TO"] = 0.58,
			["R"] = 0.298,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.21,
			["useOpacity"] = true,
		},
		["OUTRANGED"] = {
			["TG"] = 0,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0,
			["TO"] = 0.5,
			["R"] = 0,
			["useBackground"] = false,
			["useText"] = false,
			["O"] = 0.25,
			["useOpacity"] = true,
		},
		["CHARMED"] = {
			["TG"] = 0.31,
			["B"] = 0.263,
			["TB"] = 0.31,
			["G"] = 0.082,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 0.51,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["HOT3"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["B"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["TR"] = 1,
			["R"] = 1,
			["TO"] = 1,
			["isClock"] = false,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["HOT4"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["B"] = 1,
			["TB"] = 1,
			["G"] = 0.3,
			["TR"] = 0.6,
			["R"] = 0.3,
			["TO"] = 1,
			["isClock"] = false,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["DEBUFF2"] = {
			["TG"] = 0,
			["B"] = 0.4,
			["TB"] = 0,
			["G"] = 0.4,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 0.8,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["DEBUFF0"] = {
			["useBackground"] = false,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["HOT8"] = {
			["useBackground"] = true,
			["R"] = 1,
			["B"] = 1,
			["O"] = 0.75,
			["G"] = 1,
		},
		["HOT10"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["B"] = 0.3,
			["TB"] = 0.3,
			["G"] = 1,
			["TR"] = 0.6,
			["R"] = 0.3,
			["TO"] = 1,
			["isClock"] = false,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["THREAT"] = {
			["LOW"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 1,
				["O"] = 1,
				["G"] = 1,
			},
			["HIGH"] = {
				["useBackground"] = true,
				["R"] = 1,
				["B"] = 1,
				["O"] = 1,
				["G"] = 0,
			},
		},
		["HOT_CHARGE_4"] = {
			["TG"] = 1,
			["B"] = 0.8,
			["TB"] = 1,
			["G"] = 0.8,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 0.8,
			["useBackground"] = true,
			["O"] = 1,
			["useText"] = true,
		},
		["CLUSTER_FAIR"] = {
			["TG"] = 1,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 0.8,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 0.8,
			["useBackground"] = true,
			["O"] = 1,
			["useText"] = true,
		},
		["DEBUFF6"] = {
			["TG"] = 0.5,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 0.3,
			["TR"] = 0.8,
			["TO"] = 1,
			["R"] = 0.6,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["LIFE_LEFT"] = {
			["GOOD"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["O"] = 1,
				["G"] = 1,
			},
			["LOW"] = {
				["useBackground"] = true,
				["R"] = 1,
				["B"] = 0,
				["O"] = 1,
				["G"] = 0,
			},
			["FAIR"] = {
				["useBackground"] = true,
				["R"] = 1,
				["B"] = 0,
				["O"] = 1,
				["G"] = 1,
			},
		},
		["HOT_CHARGE_2"] = {
			["TG"] = 1,
			["B"] = 0.3,
			["TB"] = 0.6,
			["G"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 1,
			["useBackground"] = true,
			["O"] = 1,
			["useText"] = true,
		},
	},
}
VUHDO_SPELL_ASSIGNMENTS = {
	["altshift14"] = {
		"alt-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["shift3"] = {
		"shift-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["altctrlshift15"] = {
		"alt-ctrl-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl12"] = {
		"ctrl-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["alt12"] = {
		"alt-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrl13"] = {
		"alt-ctrl-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["alt13"] = {
		"alt-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["altshift13"] = {
		"alt-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["alt6"] = {
		"alt-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["altctrlshift12"] = {
		"alt-ctrl-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrl15"] = {
		"alt-ctrl-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl8"] = {
		"ctrl-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl5"] = {
		"alt-ctrl-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["altshift16"] = {
		"alt-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altctrlshift9"] = {
		"alt-ctrl-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["altctrlshift6"] = {
		"alt-ctrl-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrl3"] = {
		"ctrl-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["alt8"] = {
		"alt-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["ctrl2"] = {
		"ctrl-", -- [1]
		"2", -- [2]
		"menu", -- [3]
	},
	["altctrl16"] = {
		"alt-ctrl-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altctrl1"] = {
		"alt-ctrl-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["altctrl14"] = {
		"alt-ctrl-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["shift8"] = {
		"shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altshift6"] = {
		"alt-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["shift4"] = {
		"shift-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["ctrl9"] = {
		"ctrl-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["shift15"] = {
		"shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl11"] = {
		"ctrl-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["13"] = {
		"", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["ctrlshift1"] = {
		"ctrl-shift-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["ctrlshift14"] = {
		"ctrl-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["alt15"] = {
		"alt-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["shift7"] = {
		"shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["altctrlshift5"] = {
		"alt-ctrl-shift-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["ctrlshift4"] = {
		"ctrl-shift-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["altctrl3"] = {
		"alt-ctrl-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["shift16"] = {
		"shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altshift15"] = {
		"alt-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altshift1"] = {
		"alt-shift-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["altctrlshift2"] = {
		"alt-ctrl-shift-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["ctrlshift6"] = {
		"ctrl-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["altshift2"] = {
		"alt-shift-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["ctrl15"] = {
		"ctrl-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl16"] = {
		"ctrl-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrlshift15"] = {
		"ctrl-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altshift12"] = {
		"alt-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrlshift11"] = {
		"alt-ctrl-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["shift6"] = {
		"shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["16"] = {
		"", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrl6"] = {
		"ctrl-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["3"] = {
		"", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["ctrl4"] = {
		"ctrl-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["shift1"] = {
		"shift-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["altshift4"] = {
		"alt-shift-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["shift2"] = {
		"shift-", -- [1]
		"2", -- [2]
		"assist", -- [3]
	},
	["alt5"] = {
		"alt-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["altctrl11"] = {
		"alt-ctrl-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["alt3"] = {
		"alt-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["ctrlshift16"] = {
		"ctrl-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["shift9"] = {
		"shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["altctrlshift7"] = {
		"alt-ctrl-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrlshift13"] = {
		"ctrl-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["shift10"] = {
		"shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altctrl7"] = {
		"alt-ctrl-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrlshift12"] = {
		"ctrl-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["ctrl7"] = {
		"ctrl-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["alt4"] = {
		"alt-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["ctrlshift5"] = {
		"ctrl-shift-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["shift11"] = {
		"shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["1"] = {
		"", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["altctrlshift3"] = {
		"alt-ctrl-shift-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["ctrlshift2"] = {
		"ctrl-shift-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["ctrl1"] = {
		"ctrl-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["ctrlshift8"] = {
		"ctrl-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["ctrl5"] = {
		"ctrl-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["altctrl10"] = {
		"alt-ctrl-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altctrlshift4"] = {
		"alt-ctrl-shift-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["alt14"] = {
		"alt-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["ctrlshift3"] = {
		"ctrl-shift-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["7"] = {
		"", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["alt1"] = {
		"alt-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["8"] = {
		"", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altshift9"] = {
		"alt-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["2"] = {
		"", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["ctrlshift7"] = {
		"ctrl-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["4"] = {
		"", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["alt9"] = {
		"alt-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["6"] = {
		"", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["9"] = {
		"", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["15"] = {
		"", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altctrlshift10"] = {
		"alt-ctrl-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altctrlshift8"] = {
		"alt-ctrl-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrlshift1"] = {
		"alt-ctrl-shift-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["shift13"] = {
		"shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["11"] = {
		"", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["altctrl12"] = {
		"alt-ctrl-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["5"] = {
		"", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["altctrl2"] = {
		"alt-ctrl-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["altctrlshift13"] = {
		"alt-ctrl-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["ctrl14"] = {
		"ctrl-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrl8"] = {
		"alt-ctrl-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["alt10"] = {
		"alt-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["alt11"] = {
		"alt-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["12"] = {
		"", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["alt16"] = {
		"alt-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["shift12"] = {
		"shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altshift5"] = {
		"alt-shift-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["altctrl6"] = {
		"alt-ctrl-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrlshift11"] = {
		"ctrl-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["ctrlshift10"] = {
		"ctrl-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altshift11"] = {
		"alt-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["altshift10"] = {
		"alt-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["alt7"] = {
		"alt-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrl10"] = {
		"ctrl-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altshift3"] = {
		"alt-shift-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["altctrl4"] = {
		"alt-ctrl-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["altctrlshift14"] = {
		"alt-ctrl-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altshift8"] = {
		"alt-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl9"] = {
		"alt-ctrl-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["shift5"] = {
		"shift-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["14"] = {
		"", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altshift7"] = {
		"alt-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["shift14"] = {
		"shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["alt2"] = {
		"alt-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["altctrlshift16"] = {
		"alt-ctrl-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrlshift9"] = {
		"ctrl-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["ctrl13"] = {
		"ctrl-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["10"] = {
		"", -- [1]
		"10", -- [2]
		"", -- [3]
	},
}
VUHDO_HOSTILE_SPELL_ASSIGNMENTS = {
	["altshift14"] = {
		"alt-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["shift3"] = {
		"shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["alt13"] = {
		"alt-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["alt6"] = {
		"alt-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["alt8"] = {
		"alt-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl13"] = {
		"alt-ctrl-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["altctrlshift15"] = {
		"alt-ctrl-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altshift13"] = {
		"alt-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["alt12"] = {
		"alt-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrlshift12"] = {
		"alt-ctrl-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrl15"] = {
		"alt-ctrl-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl8"] = {
		"ctrl-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altshift2"] = {
		"alt-shift-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["altshift16"] = {
		"alt-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altshift11"] = {
		"alt-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["13"] = {
		"", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["ctrl3"] = {
		"ctrl-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["ctrlshift9"] = {
		"ctrl-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["shift16"] = {
		"shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altctrlshift16"] = {
		"alt-ctrl-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altctrl1"] = {
		"alt-ctrl-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["altctrl14"] = {
		"alt-ctrl-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["shift8"] = {
		"shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altshift6"] = {
		"alt-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["shift4"] = {
		"shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["ctrl9"] = {
		"ctrl-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["shift15"] = {
		"shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl11"] = {
		"ctrl-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["altctrlshift6"] = {
		"alt-ctrl-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrlshift1"] = {
		"ctrl-shift-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["ctrlshift14"] = {
		"ctrl-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["alt15"] = {
		"alt-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["shift7"] = {
		"shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["altctrlshift5"] = {
		"alt-ctrl-shift-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["ctrl4"] = {
		"ctrl-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["altctrl3"] = {
		"alt-ctrl-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["ctrl2"] = {
		"ctrl-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["altshift15"] = {
		"alt-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altshift1"] = {
		"alt-shift-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["altctrlshift2"] = {
		"alt-ctrl-shift-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["ctrlshift6"] = {
		"ctrl-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["altctrl5"] = {
		"alt-ctrl-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["ctrl15"] = {
		"ctrl-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl16"] = {
		"ctrl-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrlshift15"] = {
		"ctrl-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altshift12"] = {
		"alt-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrlshift11"] = {
		"alt-ctrl-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["shift6"] = {
		"shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["16"] = {
		"", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altctrl7"] = {
		"alt-ctrl-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["altctrlshift3"] = {
		"alt-ctrl-shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["altctrlshift14"] = {
		"alt-ctrl-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["shift1"] = {
		"shift-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["altshift4"] = {
		"alt-shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["shift2"] = {
		"shift-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["alt5"] = {
		"alt-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["altctrl11"] = {
		"alt-ctrl-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["alt3"] = {
		"alt-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["ctrlshift16"] = {
		"ctrl-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["shift9"] = {
		"shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["altctrlshift7"] = {
		"alt-ctrl-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrlshift13"] = {
		"ctrl-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["shift10"] = {
		"shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["ctrl6"] = {
		"ctrl-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrlshift12"] = {
		"ctrl-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["ctrl7"] = {
		"ctrl-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["alt4"] = {
		"alt-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["alt11"] = {
		"alt-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["shift11"] = {
		"shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["1"] = {
		"", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["3"] = {
		"", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["5"] = {
		"", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["ctrl1"] = {
		"ctrl-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["ctrlshift8"] = {
		"ctrl-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["ctrl5"] = {
		"ctrl-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["altctrl10"] = {
		"alt-ctrl-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altctrlshift4"] = {
		"alt-ctrl-shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["alt14"] = {
		"alt-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["ctrlshift3"] = {
		"ctrl-shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["7"] = {
		"", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["alt1"] = {
		"alt-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["8"] = {
		"", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altshift9"] = {
		"alt-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["2"] = {
		"", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["ctrlshift2"] = {
		"ctrl-shift-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["4"] = {
		"", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["alt9"] = {
		"alt-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["6"] = {
		"", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["9"] = {
		"", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["15"] = {
		"", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altctrlshift10"] = {
		"alt-ctrl-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altctrlshift8"] = {
		"alt-ctrl-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrlshift1"] = {
		"alt-ctrl-shift-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["shift13"] = {
		"shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["11"] = {
		"", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["altctrl12"] = {
		"alt-ctrl-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["ctrlshift7"] = {
		"ctrl-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["altctrl2"] = {
		"alt-ctrl-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["altctrlshift13"] = {
		"alt-ctrl-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["ctrl14"] = {
		"ctrl-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrl8"] = {
		"alt-ctrl-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["alt10"] = {
		"alt-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["ctrlshift5"] = {
		"ctrl-shift-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["12"] = {
		"", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["alt16"] = {
		"alt-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["shift12"] = {
		"shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altshift5"] = {
		"alt-shift-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["altctrl6"] = {
		"alt-ctrl-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrlshift11"] = {
		"ctrl-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["ctrlshift10"] = {
		"ctrl-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altctrlshift9"] = {
		"alt-ctrl-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["altshift10"] = {
		"alt-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["alt7"] = {
		"alt-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrl10"] = {
		"ctrl-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altshift3"] = {
		"alt-shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["altctrl4"] = {
		"alt-ctrl-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["ctrlshift4"] = {
		"ctrl-shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["altshift8"] = {
		"alt-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl9"] = {
		"alt-ctrl-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["shift5"] = {
		"shift-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["14"] = {
		"", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altshift7"] = {
		"alt-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["shift14"] = {
		"shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["alt2"] = {
		"alt-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["altctrl16"] = {
		"alt-ctrl-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrl12"] = {
		"ctrl-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["ctrl13"] = {
		"ctrl-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["10"] = {
		"", -- [1]
		"10", -- [2]
		"", -- [3]
	},
}
VUHDO_MM_SETTINGS = {
	["enabled"] = 1,
	["drag"] = "CIRCLE",
	["position"] = 0,
}
VUHDO_PLAYER_TARGETS = {
}
VUHDO_MAINTANK_NAMES = {
}
VUHDO_BUFF_SETTINGS = {
	["Aspect"] = {
		["missingColor"] = {
			["TG"] = 1,
			["B"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["R"] = 1,
		},
		["buff"] = "Aspect of the Hawk",
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Trueshot Aura"] = {
		["missingColor"] = {
			["TG"] = 1,
			["B"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["R"] = 1,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["CONFIG"] = {
		["SWATCH_COLOR_BUFF_OUT"] = {
			["TG"] = 0,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0.8,
			["TO"] = 1,
			["R"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["SHOW_LABEL"] = false,
		["REFRESH_SECS"] = 1,
		["SWATCH_COLOR_BUFF_COOLDOWN"] = {
			["TG"] = 0.6,
			["B"] = 0.3,
			["TB"] = 0.6,
			["G"] = 0.3,
			["TR"] = 0.6,
			["TO"] = 1,
			["R"] = 0.3,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["SWATCH_COLOR_BUFF_OKAY"] = {
			["TG"] = 0.8,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0,
			["TO"] = 1,
			["R"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["SHOW"] = false,
		["PANEL_BG_COLOR"] = {
			["useBackground"] = true,
			["B"] = 0,
			["R"] = 0,
			["G"] = 0,
			["O"] = 0.5,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["SWATCH_COLOR_BUFF_LOW"] = {
			["TG"] = 0.7,
			["B"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["R"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["VERSION"] = 3,
		["SCALE"] = 1,
		["BAR_COLORS_TEXT"] = true,
		["BAR_COLORS_IN_FIGHT"] = false,
		["HIGHLIGHT_COOLDOWN"] = true,
		["HIDE_CHARGES"] = false,
		["COMPACT"] = true,
		["PANEL_BORDER_COLOR"] = {
			["useBackground"] = true,
			["B"] = 0,
			["R"] = 0,
			["G"] = 0,
			["O"] = 0.5,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["BAR_COLORS_BACKGROUND"] = true,
		["POSITION"] = {
			["y"] = -100,
			["x"] = 100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["SWATCH_BG_COLOR"] = {
			["useBackground"] = true,
			["B"] = 0,
			["R"] = 0,
			["G"] = 0,
			["O"] = 1,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["PANEL_MAX_BUFFS"] = 5,
		["REBUFF_MIN_MINUTES"] = 3,
		["SWATCH_BORDER_COLOR"] = {
			["useBackground"] = true,
			["B"] = 0.8,
			["R"] = 0.8,
			["G"] = 0.8,
			["O"] = 0,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["REBUFF_AT_PERCENT"] = 25,
		["WHEEL_SMART_BUFF"] = false,
		["USE_COMBINED"] = true,
	},
}
VUHDO_POWER_TYPE_COLORS = {
	{
		["TG"] = 0,
		["R"] = 1,
		["TB"] = 0,
		["G"] = 0,
		["TR"] = 1,
		["TO"] = 1,
		["B"] = 0,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["useText"] = true,
	}, -- [1]
	{
		["TG"] = 0.5,
		["R"] = 1,
		["TB"] = 0.25,
		["G"] = 0.5,
		["TR"] = 1,
		["TO"] = 1,
		["B"] = 0.25,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["useText"] = true,
	}, -- [2]
	{
		["TG"] = 1,
		["R"] = 1,
		["TB"] = 0,
		["G"] = 1,
		["TR"] = 1,
		["TO"] = 1,
		["B"] = 0,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["useText"] = true,
	}, -- [3]
	{
		["TG"] = 1,
		["R"] = 0,
		["TB"] = 1,
		["G"] = 1,
		["TR"] = 0,
		["TO"] = 1,
		["B"] = 1,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["useText"] = true,
	}, -- [4]
	nil, -- [5]
	{
		["TG"] = 0.5,
		["R"] = 0.5,
		["TB"] = 0.5,
		["G"] = 0.5,
		["TR"] = 0.5,
		["TO"] = 1,
		["B"] = 0.5,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["useText"] = true,
	}, -- [6]
	[0] = {
		["TG"] = 0,
		["R"] = 0,
		["TB"] = 1,
		["G"] = 0,
		["TR"] = 0,
		["TO"] = 1,
		["B"] = 1,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["useText"] = true,
	},
}
VUHDO_SPELLS_KEYBOARD = {
	["SPELL15"] = "",
	["SPELL6"] = "",
	["SPELL13"] = "",
	["HOSTILE_WHEEL"] = {
		["1"] = {
			"", -- [1]
			"-w1", -- [2]
			"", -- [3]
		},
		["altctrl2"] = {
			"ALT-CTRL-", -- [1]
			"-w10", -- [2]
			"", -- [3]
		},
		["shift1"] = {
			"SHIFT-", -- [1]
			"-w7", -- [2]
			"", -- [3]
		},
		["2"] = {
			"", -- [1]
			"-w2", -- [2]
			"", -- [3]
		},
		["ctrl2"] = {
			"CTRL-", -- [1]
			"-w6", -- [2]
			"", -- [3]
		},
		["shift2"] = {
			"SHIFT-", -- [1]
			"-w8", -- [2]
			"", -- [3]
		},
		["altshift1"] = {
			"ALT-SHIFT-", -- [1]
			"-w11", -- [2]
			"", -- [3]
		},
		["alt1"] = {
			"ALT-", -- [1]
			"-w3", -- [2]
			"", -- [3]
		},
		["altctrl1"] = {
			"ALT-CTRL-", -- [1]
			"-w9", -- [2]
			"", -- [3]
		},
		["alt2"] = {
			"ALT-", -- [1]
			"-w4", -- [2]
			"", -- [3]
		},
		["altshift2"] = {
			"ALT-SHIFT-", -- [1]
			"-w12", -- [2]
			"", -- [3]
		},
		["altctrlshift2"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w16", -- [2]
			"", -- [3]
		},
		["altctrlshift1"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w15", -- [2]
			"", -- [3]
		},
		["ctrlshift1"] = {
			"CTRL-SHIFT-", -- [1]
			"-w13", -- [2]
			"", -- [3]
		},
		["ctrl1"] = {
			"CTRL-", -- [1]
			"-w5", -- [2]
			"", -- [3]
		},
		["ctrlshift2"] = {
			"CTRL-SHIFT-", -- [1]
			"-w14", -- [2]
			"", -- [3]
		},
	},
	["SPELL3"] = "",
	["SPELL4"] = "",
	["SPELL2"] = "",
	["SPELL16"] = "",
	["INTERNAL"] = {
	},
	["SPELL7"] = "",
	["SPELL12"] = "",
	["SPELL5"] = "",
	["SPELL9"] = "",
	["SPELL10"] = "",
	["version"] = 2,
	["SPELL14"] = "",
	["SPELL11"] = "",
	["SPELL8"] = "",
	["SPELL1"] = "",
	["WHEEL"] = {
		["1"] = {
			"", -- [1]
			"-w1", -- [2]
			"", -- [3]
		},
		["altctrl2"] = {
			"ALT-CTRL-", -- [1]
			"-w10", -- [2]
			"", -- [3]
		},
		["shift1"] = {
			"SHIFT-", -- [1]
			"-w7", -- [2]
			"", -- [3]
		},
		["2"] = {
			"", -- [1]
			"-w2", -- [2]
			"", -- [3]
		},
		["ctrl2"] = {
			"CTRL-", -- [1]
			"-w6", -- [2]
			"", -- [3]
		},
		["shift2"] = {
			"SHIFT-", -- [1]
			"-w8", -- [2]
			"", -- [3]
		},
		["altshift1"] = {
			"ALT-SHIFT-", -- [1]
			"-w11", -- [2]
			"", -- [3]
		},
		["alt1"] = {
			"ALT-", -- [1]
			"-w3", -- [2]
			"", -- [3]
		},
		["altctrl1"] = {
			"ALT-CTRL-", -- [1]
			"-w9", -- [2]
			"", -- [3]
		},
		["alt2"] = {
			"ALT-", -- [1]
			"-w4", -- [2]
			"", -- [3]
		},
		["altshift2"] = {
			"ALT-SHIFT-", -- [1]
			"-w12", -- [2]
			"", -- [3]
		},
		["altctrlshift2"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w16", -- [2]
			"", -- [3]
		},
		["altctrlshift1"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w15", -- [2]
			"", -- [3]
		},
		["ctrlshift1"] = {
			"CTRL-SHIFT-", -- [1]
			"-w13", -- [2]
			"", -- [3]
		},
		["ctrl1"] = {
			"CTRL-", -- [1]
			"-w5", -- [2]
			"", -- [3]
		},
		["ctrlshift2"] = {
			"CTRL-SHIFT-", -- [1]
			"-w14", -- [2]
			"", -- [3]
		},
	},
}
VUHDO_SPELL_CONFIG = {
	["IS_LOAD_HOTS"] = false,
	["IS_FIRE_OUT_FIGHT"] = false,
	["IS_AUTO_FIRE"] = true,
	["IS_FIRE_CUSTOM_2"] = false,
	["IS_FIRE_GLOVES"] = false,
	["IS_FIRE_TRINKET_1"] = false,
	["IS_CANCEL_CURRENT"] = false,
	["autoBattleRez"] = true,
	["IS_KEEP_STANCE"] = false,
	["IS_FIRE_TRINKET_2"] = false,
	["IS_AUTO_TARGET"] = false,
	["IS_FIRE_HOT"] = false,
	["FIRE_CUSTOM_1_SPELL"] = "",
	["FIRE_CUSTOM_2_SPELL"] = "",
	["IS_TOOLTIP_INFO"] = false,
	["IS_FIRE_CUSTOM_1"] = false,
	["smartCastModi"] = "all",
}
VUHDO_BUFF_ORDER = {
	["01Trueshot Aura"] = 1,
	["02Aspect"] = 2,
}
VUHDO_SPEC_LAYOUTS = {
	["1"] = "",
	["selected"] = "",
	["2"] = "",
}
VUHDO_GROUP_SIZE = 10
VUHDO_RAID = {
	["raid5"] = {
		["number"] = 5,
		["baseRange"] = false,
		["targetUnit"] = "raid5target",
		["group"] = 1,
		["classId"] = 23,
		["range"] = false,
		["unit"] = "raid5",
		["powertype"] = 0,
		["debuff"] = 0,
		["healthmax"] = 200805,
		["isAltPower"] = false,
		["sortMaxHp"] = 200805,
		["isVehicle"] = false,
		["class"] = "PALADIN",
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 24777,
		["power"] = 18569,
		["petUnit"] = "raidpet5",
		["zone"] = "Sulfuron Keep Courtyard",
		["threatPerc"] = 0,
		["isPet"] = false,
		["map"] = "Hyjal",
		["health"] = 126459,
		["className"] = "Paladin",
		["fullName"] = "Scirocco",
		["aggro"] = false,
		["role"] = 60,
		["name"] = "Scirocco",
	},
	["raid7"] = {
		["number"] = 7,
		["class"] = "HUNTER",
		["targetUnit"] = "raid7target",
		["group"] = 2,
		["classId"] = 22,
		["range"] = false,
		["unit"] = "raid7",
		["isAltPower"] = false,
		["powertype"] = 2,
		["healthmax"] = 144673,
		["baseRange"] = false,
		["zone"] = "Ascendant's Rise",
		["sortMaxHp"] = 144673,
		["map"] = "Hyjal",
		["dead"] = true,
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 100,
		["power"] = 0,
		["petUnit"] = "raidpet7",
		["isVehicle"] = false,
		["threatPerc"] = 0,
		["isPet"] = false,
		["debuff"] = 0,
		["name"] = "Simfraya",
		["className"] = "Hunter",
		["fullName"] = "Simfraya",
		["role"] = 62,
		["aggro"] = false,
		["health"] = 138,
	},
	["raid4"] = {
		["number"] = 4,
		["class"] = "PALADIN",
		["targetUnit"] = "raid4target",
		["group"] = 1,
		["classId"] = 23,
		["range"] = false,
		["unit"] = "raid4",
		["isAltPower"] = false,
		["powertype"] = 0,
		["healthmax"] = 139849,
		["baseRange"] = false,
		["zone"] = "Hyjal",
		["sortMaxHp"] = 139849,
		["map"] = "Hyjal",
		["dead"] = true,
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 60150,
		["power"] = 2053,
		["petUnit"] = "raidpet4",
		["isVehicle"] = false,
		["threatPerc"] = 0,
		["isPet"] = false,
		["debuff"] = 0,
		["name"] = "Bourrne",
		["className"] = "Paladin",
		["fullName"] = "Bourrne",
		["role"] = 63,
		["aggro"] = false,
		["health"] = 1,
	},
	["raid9"] = {
		["number"] = 9,
		["baseRange"] = false,
		["targetUnit"] = "raid9target",
		["group"] = 2,
		["classId"] = 29,
		["range"] = false,
		["unit"] = "raid9",
		["powertype"] = 6,
		["debuff"] = 0,
		["healthmax"] = 155109,
		["isAltPower"] = false,
		["sortMaxHp"] = 155109,
		["isVehicle"] = false,
		["class"] = "DEATHKNIGHT",
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 130,
		["power"] = 0,
		["petUnit"] = "raidpet9",
		["zone"] = "Flamebreach",
		["threatPerc"] = 0,
		["isPet"] = false,
		["map"] = "Hyjal",
		["health"] = 93109,
		["className"] = "Death Knight",
		["fullName"] = "Lozeke",
		["aggro"] = false,
		["role"] = 61,
		["name"] = "Lozeke",
	},
	["player"] = {
		["visible"] = 1,
		["class"] = "HUNTER",
		["isAltPower"] = false,
		["targetUnit"] = "target",
		["group"] = 2,
		["classId"] = 22,
		["range"] = true,
		["unit"] = "player",
		["baseRange"] = true,
		["powertype"] = 2,
		["healthmax"] = 149629,
		["number"] = 10,
		["zone"] = "Mount Hyjal",
		["sortMaxHp"] = 149629,
		["map"] = "Hyjal",
		["dead"] = true,
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 100,
		["power"] = 1,
		["petUnit"] = "pet",
		["isVehicle"] = false,
		["threatPerc"] = 0,
		["isPet"] = false,
		["debuff"] = 0,
		["name"] = "Pezzer",
		["className"] = "Hunter",
		["fullName"] = "Pezzer",
		["role"] = 62,
		["aggro"] = false,
		["health"] = 179,
	},
	["raid1"] = {
		["number"] = 1,
		["baseRange"] = false,
		["targetUnit"] = "raid1target",
		["group"] = 1,
		["classId"] = 26,
		["range"] = false,
		["unit"] = "raid1",
		["powertype"] = 0,
		["debuff"] = 0,
		["healthmax"] = 142845,
		["isAltPower"] = false,
		["sortMaxHp"] = 142845,
		["isVehicle"] = false,
		["class"] = "SHAMAN",
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 25475,
		["power"] = 18038,
		["petUnit"] = "raidpet1",
		["zone"] = "Sulfuron Span",
		["threatPerc"] = 0,
		["isPet"] = false,
		["map"] = "Hyjal",
		["health"] = 88655,
		["className"] = "Shaman",
		["fullName"] = "Raei",
		["aggro"] = false,
		["role"] = 61,
		["name"] = "Raei",
	},
	["raid3"] = {
		["number"] = 3,
		["baseRange"] = false,
		["targetUnit"] = "raid3target",
		["group"] = 1,
		["classId"] = 27,
		["range"] = false,
		["unit"] = "raid3",
		["powertype"] = 0,
		["debuff"] = 0,
		["healthmax"] = 151555,
		["isAltPower"] = false,
		["sortMaxHp"] = 151555,
		["isVehicle"] = false,
		["class"] = "DRUID",
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 33941,
		["power"] = 21782,
		["petUnit"] = "raidpet3",
		["zone"] = "Flamebreach",
		["threatPerc"] = 0,
		["isPet"] = false,
		["map"] = "Hyjal",
		["health"] = 78771,
		["className"] = "Druid",
		["fullName"] = "Tastyteets",
		["aggro"] = false,
		["role"] = 63,
		["name"] = "Tastyteets",
	},
	["raid6"] = {
		["number"] = 6,
		["baseRange"] = false,
		["targetUnit"] = "raid6target",
		["group"] = 2,
		["classId"] = 28,
		["range"] = false,
		["unit"] = "raid6",
		["powertype"] = 0,
		["debuff"] = 0,
		["healthmax"] = 154059,
		["isAltPower"] = false,
		["sortMaxHp"] = 154059,
		["isVehicle"] = false,
		["class"] = "PRIEST",
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 5428,
		["power"] = 5415,
		["petUnit"] = "raidpet6",
		["zone"] = "Flamebreach",
		["threatPerc"] = 0,
		["isPet"] = false,
		["map"] = "Hyjal",
		["health"] = 80311,
		["className"] = "Priest",
		["fullName"] = "Sunali",
		["aggro"] = false,
		["role"] = 62,
		["name"] = "Sunali",
	},
	["raid2"] = {
		["number"] = 2,
		["baseRange"] = false,
		["targetUnit"] = "raid2target",
		["group"] = 1,
		["classId"] = 23,
		["range"] = false,
		["unit"] = "raid2",
		["powertype"] = 0,
		["debuff"] = 0,
		["healthmax"] = 176691,
		["isAltPower"] = false,
		["sortMaxHp"] = 176691,
		["isVehicle"] = false,
		["class"] = "PALADIN",
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 24972,
		["power"] = 15950,
		["petUnit"] = "raidpet2",
		["zone"] = "Flamebreach",
		["threatPerc"] = 0,
		["isPet"] = false,
		["map"] = "Hyjal",
		["health"] = 100696,
		["className"] = "Paladin",
		["fullName"] = "Tulkás",
		["aggro"] = false,
		["role"] = 60,
		["name"] = "Tulkás",
	},
	["raid8"] = {
		["number"] = 8,
		["baseRange"] = false,
		["targetUnit"] = "raid8target",
		["group"] = 2,
		["classId"] = 21,
		["range"] = false,
		["unit"] = "raid8",
		["powertype"] = 3,
		["debuff"] = 0,
		["healthmax"] = 148965,
		["isAltPower"] = false,
		["sortMaxHp"] = 148965,
		["isVehicle"] = false,
		["class"] = "ROGUE",
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 100,
		["power"] = 100,
		["petUnit"] = "raidpet8",
		["zone"] = "Sulfuron Span",
		["threatPerc"] = 0,
		["isPet"] = false,
		["map"] = "Hyjal",
		["health"] = 90859,
		["className"] = "Rogue",
		["fullName"] = "Slice",
		["aggro"] = false,
		["role"] = 61,
		["name"] = "Slice",
	},
}
VUHDO_INDICATOR_CONFIG = {
	["CUSTOM"] = {
		["THREAT_BAR"] = {
			["invertGrowth"] = false,
			["turnAxis"] = false,
			["HEIGHT"] = 4,
			["WARN_AT"] = 85,
			["TEXTURE"] = "VuhDo - Polished Wood",
		},
		["MOUSEOVER_HIGHLIGHT"] = {
			["TEXTURE"] = "VuhDo - Aluminium",
		},
		["AGGRO_BAR"] = {
			["TEXTURE"] = "VuhDo - Polished Wood",
		},
		["BACKGROUND_BAR"] = {
			["TEXTURE"] = "VuhDo - Minimalist",
		},
		["CLUSTER_BORDER"] = {
			["WIDTH"] = 2,
			["FILE"] = "Interface\\AddOns\\VuhDo\\Images\\white_square_16_16",
		},
		["SWIFTMEND_INDICATOR"] = {
			["SCALE"] = 0.699,
		},
		["BAR_BORDER"] = {
			["FILE"] = "Interface\\AddOns\\VuhDo\\Images\\white_square_16_16",
			["ADJUST"] = 0,
			["WIDTH"] = 1,
		},
		["MANA_BAR"] = {
			["turnAxis"] = false,
			["invertGrowth"] = false,
			["TEXTURE"] = "VuhDo - Pipe, light",
		},
		["HEALTH_BAR"] = {
			["turnAxis"] = false,
			["vertical"] = false,
			["invertGrowth"] = false,
		},
		["SIDE_RIGHT"] = {
			["turnAxis"] = false,
			["vertical"] = true,
			["invertGrowth"] = false,
			["TEXTURE"] = "VuhDo - Plain White",
		},
		["SIDE_LEFT"] = {
			["turnAxis"] = false,
			["vertical"] = true,
			["invertGrowth"] = false,
			["TEXTURE"] = "VuhDo - Plain White",
		},
	},
	["BOUQUETS"] = {
		["THREAT_BAR"] = "",
		["MOUSEOVER_HIGHLIGHT"] = "",
		["AGGRO_BAR"] = "",
		["BACKGROUND_BAR"] = "Background: Solid",
		["INCOMING_BAR"] = "",
		["SWIFTMEND_INDICATOR"] = "Role Icon",
		["HEALTH_BAR_PANEL"] = {
			"", -- [1]
			"", -- [2]
			"", -- [3]
			"", -- [4]
			"", -- [5]
			"", -- [6]
			"", -- [7]
			"", -- [8]
			"", -- [9]
			"", -- [10]
		},
		["CLUSTER_BORDER"] = "",
		["THREAT_MARK"] = "",
		["BAR_BORDER"] = "Border: Multi + Aggro",
		["SIDE_RIGHT"] = "",
		["MANA_BAR"] = "Manabars: Mana only",
		["HEALTH_BAR"] = "Health (generic, class col)",
		["SIDE_LEFT"] = "",
		["DAMAGE_FLASH_BAR"] = "",
	},
}
VUHDO_EVENT_TIMES = nil