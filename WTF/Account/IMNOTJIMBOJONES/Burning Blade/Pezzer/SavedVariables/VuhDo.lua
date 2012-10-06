
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
			["ch"] = {
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
			["coh"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
		},
		["knownOnly"] = true,
		["subIncOnlyCastTime"] = true,
		["isGroupWise"] = false,
		["refresh"] = 800,
		["animate"] = true,
		["isCooldown"] = true,
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
	["IS_READY_CHECK_DISABLED"] = false,
	["CLUSTER"] = {
		["REFRESH"] = 180,
		["CHAIN_MAX_JUMP"] = 3,
		["RANGE_JUMP"] = 11,
		["DISPLAY_DESTINATION"] = 2,
		["CONE_DEGREES"] = 360,
		["IS_NUMBER"] = true,
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
			["USE_SHADOW"] = false,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
		},
		["THRESH_GOOD"] = 5,
		["COOLDOWN_SPELL"] = "",
		["BELOW_HEALTH_PERC"] = 85,
		["THRESH_FAIR"] = 3,
	},
	["OMIT_MAIN_ASSIST"] = false,
	["RES_ANNOUNCE_TEXT"] = "Rezing vuhdo...",
	["LOCK_IN_FIGHT"] = true,
	["IS_CLIQUE_COMPAT_MODE"] = false,
	["VERSION"] = 4,
	["DETECT_DEBUFFS_IGNORE_DURATION"] = true,
	["SCAN_RANGE"] = "1",
	["PARSE_COMBAT_LOG"] = true,
	["ON_MOUSE_UP"] = false,
	["OMIT_TARGET"] = false,
	["IS_SHOW_GCD"] = false,
	["BLIZZ_UI_HIDE_FOCUS"] = true,
	["DETECT_DEBUFFS_IGNORE_NO_HARM"] = true,
	["DETECT_DEBUFFS_IGNORE_BY_CLASS"] = true,
	["IS_DC_SHIELD_DISABLED"] = false,
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
			["USE_SHADOW"] = true,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
		},
		["max_num"] = 3,
		["isColor"] = false,
		["COUNTER_TEXT"] = {
			["X_ADJUST"] = -10,
			["USE_MONO"] = false,
			["Y_ADJUST"] = -15,
			["ANCHOR"] = "TOPLEFT",
			["USE_OUTLINE"] = false,
			["SCALE"] = 70,
			["COLOR"] = {
				["TG"] = 1,
				["R"] = 0,
				["TB"] = 0,
				["G"] = 0,
				["TR"] = 0,
				["TO"] = 1,
				["useOpacity"] = true,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 1,
				["B"] = 0,
			},
			["USE_SHADOW"] = true,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
		},
		["isStacks"] = false,
		["yAdjust"] = -34,
		["version"] = 19,
		["point"] = "TOPRIGHT",
		["timer"] = true,
		["isName"] = false,
		["xAdjust"] = -2,
		["STORED_SETTINGS"] = {
			["Blood Corruption: Earth"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Blackout"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Crush Armor"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Cho's Blast"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Torment"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Tetanus"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gravity Core"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Mangle"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Lightning Rod"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Twilight Shift"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ravage"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Toxic Link"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Pursuit"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fading Light"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Lightning Conductor"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Grievous Throw"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Blaze of Glory"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ice Storm"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Decapitate"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Constricting Chains"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Blood Corruption: Death"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Electrical Storm"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Jagged Tear"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Burning Blood"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gall's Blast"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Toxic Torment"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Degenerative Bite"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Lash of Anguish"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Sunder Armor"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Shockwave"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Biting Chill"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Burning Wound"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Whispers of Hethiss"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Shattered Ice"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fieroblast"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Devouring Flames"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Poison Soaked Shell"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Flame Breath"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Black Blood of Go'rath"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Consuming Darkness"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Waterlogged"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Grasping Tendrils"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Flash Freeze"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Plucked"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Corruption: Accelerated"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Melt Armor"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Break"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Flame Shock"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Parasitic Infection"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Searing Seeds"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Frozen"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Searing Plasma"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Degeneration"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Frostburn Formula"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Disrupting Shadows"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Toxic Spores"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Incineration Security Measure"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Twilight Barrage"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Wrack"] = {
				["isStacks"] = false,
				["isAliveTime"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["timer"] = true,
				["isFullDuration"] = true,
				["isColor"] = false,
			},
			["Crystal Prison Trap Effect"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Heroic Will"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Soothing Breeze"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Flame Torrent"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Body Slam"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Low Health"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Siphon Soul"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["The Widow's Kiss"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Roaring Flame"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Deep Corruption"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Engulfing Magic"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Malevolent Strikes"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Sonic Breath"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ice Patch"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ice Tomb"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Slicing Gale"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gushing Wound"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gravity Crush"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Blistering Heat"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Faded Into Twilight"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Searing Flame"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fiery Grip"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Twilight Burst"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Bloodletting"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Hydro Lance"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Brutal Strike"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Watery Entrenchment"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Degradation"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
		},
	},
	["SHOW_PLAYER_TAGS"] = true,
	["SHOW_OVERHEAL"] = true,
	["UPDATE_HOTS_MS"] = 250,
	["OMIT_DFT_MTS"] = false,
	["BLIZZ_UI_HIDE_PLAYER"] = true,
	["HIDE_PANELS_SOLO"] = false,
	["CURRENT_PROFILE"] = "25",
	["EMERGENCY_TRIGGER"] = 100,
	["SHOW_INCOMING"] = true,
	["IS_SHARE"] = true,
	["OMIT_FOCUS"] = false,
	["HIDE_EMPTY_BUTTONS"] = true,
	["MAX_EMERGENCIES"] = 5,
	["OMIT_SELF"] = false,
	["LOCK_CLICKS_THROUGH"] = false,
	["AUTO_PROFILES"] = {
		["1"] = "Solo",
		["15"] = "25",
		["40"] = "40",
		["5"] = "5",
		["25"] = "25",
		["10"] = "10",
	},
	["IS_ALWAYS_OVERWRITE_PROFILE"] = false,
	["BLIZZ_UI_HIDE_RAID_MGR"] = false,
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
	["OMIT_MAIN_TANKS"] = false,
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
			["y"] = 147.9444427490234,
			["x"] = 960.0803833007813,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOP",
			["height"] = 41.00000381469727,
			["growth"] = "TOP",
			["width"] = 106,
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
				3, -- [3]
				4, -- [4]
				5, -- [5]
			},
			["sort"] = 6,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["inFight"] = true,
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["relativePoint"] = "TOPLEFT",
			["point"] = "TOPLEFT",
			["y"] = -100,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
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
				["useBackground"] = true,
				["textSize"] = 10,
				["useText"] = true,
				["O"] = 0.4,
				["B"] = 1,
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
				["useOpacity"] = true,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["maxChars"] = 0,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 9,
				["textSize"] = 9,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1,
			["barHeight"] = 21,
			["maxColumnsWhenStructured"] = 5,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["borderGapX"] = 14,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 5,
			["manaBarHeight"] = 3,
			["totSpacing"] = 3,
			["isDamFlash"] = true,
			["showHeaders"] = false,
			["totWidth"] = 30,
			["showTot"] = false,
			["isPlayerOnTop"] = true,
			["sideRightWidth"] = 6,
			["isTarClassColBack"] = false,
			["targetOrientation"] = 1,
			["columnSpacing"] = 18,
			["borderGapY"] = 10,
			["barWidth"] = 78,
			["rowSpacing"] = 6,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 1,
			["xAdjust"] = 2,
			["_spacing"] = 18.00000381469727,
			["showPetOwners"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = false,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
		},
	}, -- [1]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 99.99999237060547,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 130.9999847412109,
			["growth"] = "TOPLEFT",
			["width"] = 110,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 0,
			["ordering"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["relativePoint"] = "TOPLEFT",
			["point"] = "TOPLEFT",
			["y"] = -100,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
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
				["useBackground"] = true,
				["textSize"] = 10,
				["useText"] = true,
				["O"] = 0.4,
				["B"] = 1,
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
			["barTexture"] = "VuhDo - Polished Wood",
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["useOpacity"] = true,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["maxChars"] = 0,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 8,
				["textSize"] = 12,
			},
		},
		["HOTS"] = {
			["size"] = 76,
		},
		["SCALING"] = {
			["headerHeight"] = 16,
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1,
			["barHeight"] = 26,
			["maxColumnsWhenStructured"] = 8,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = false,
			["showTarget"] = true,
			["borderGapX"] = 5,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["manaBarHeight"] = 3,
			["totSpacing"] = 3,
			["isDamFlash"] = true,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["showTot"] = false,
			["isPlayerOnTop"] = true,
			["sideRightWidth"] = 6,
			["isTarClassColBack"] = false,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["barWidth"] = 100,
			["rowSpacing"] = 2,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["yAdjust"] = 0,
			["xAdjust"] = 0,
			["_spacing"] = 21,
			["showPetOwners"] = true,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 1,
			["verbose"] = false,
		},
	}, -- [2]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 99.99999237060547,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 124.7500076293945,
			["growth"] = "TOPLEFT",
			["width"] = 85,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 1,
			["sort"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["relativePoint"] = "TOPLEFT",
			["point"] = "TOPLEFT",
			["y"] = -100,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
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
				["useBackground"] = true,
				["textSize"] = 10,
				["useText"] = true,
				["O"] = 0.4,
				["B"] = 1,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["useOpacity"] = true,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["maxChars"] = 0,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 8,
				["textSize"] = 10,
			},
			["barTexture"] = "VuhDo - Polished Wood",
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1,
			["barHeight"] = 25,
			["maxColumnsWhenStructured"] = 8,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = false,
			["showTarget"] = false,
			["borderGapX"] = 5,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["manaBarHeight"] = 3,
			["totSpacing"] = 3,
			["isDamFlash"] = true,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["showTot"] = false,
			["isPlayerOnTop"] = true,
			["sideRightWidth"] = 6,
			["isTarClassColBack"] = false,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["barWidth"] = 75,
			["rowSpacing"] = 2,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["yAdjust"] = 0,
			["xAdjust"] = 0,
			["_spacing"] = 18,
			["showPetOwners"] = true,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 1,
			["verbose"] = false,
		},
	}, -- [3]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 99.99999237060547,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 124.7500076293945,
			["growth"] = "TOPLEFT",
			["width"] = 85,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["relativePoint"] = "TOPLEFT",
			["point"] = "TOPLEFT",
			["y"] = -100,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
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
				["useBackground"] = true,
				["textSize"] = 10,
				["useText"] = true,
				["O"] = 0.4,
				["B"] = 1,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["useOpacity"] = true,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["maxChars"] = 0,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 8,
				["textSize"] = 10,
			},
			["barTexture"] = "VuhDo - Polished Wood",
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1,
			["barHeight"] = 25,
			["maxColumnsWhenStructured"] = 8,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = false,
			["showTarget"] = true,
			["borderGapX"] = 5,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["manaBarHeight"] = 3,
			["totSpacing"] = 3,
			["isDamFlash"] = true,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["showTot"] = false,
			["isPlayerOnTop"] = true,
			["sideRightWidth"] = 6,
			["isTarClassColBack"] = false,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["barWidth"] = 75,
			["rowSpacing"] = 2,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["yAdjust"] = 0,
			["xAdjust"] = 0,
			["_spacing"] = 18,
			["showPetOwners"] = true,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 1,
			["verbose"] = false,
		},
	}, -- [4]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["relativePoint"] = "TOPLEFT",
			["point"] = "TOPLEFT",
			["y"] = -100,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
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
				["useBackground"] = true,
				["textSize"] = 10,
				["useText"] = true,
				["O"] = 0.4,
				["B"] = 1,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["useOpacity"] = true,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["maxChars"] = 0,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 8,
				["textSize"] = 10,
			},
			["barTexture"] = "VuhDo - Polished Wood",
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1,
			["barHeight"] = 25,
			["maxColumnsWhenStructured"] = 8,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["borderGapX"] = 5,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["manaBarHeight"] = 3,
			["totSpacing"] = 3,
			["isDamFlash"] = true,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["showTot"] = false,
			["isPlayerOnTop"] = true,
			["sideRightWidth"] = 6,
			["isTarClassColBack"] = false,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["barWidth"] = 75,
			["rowSpacing"] = 2,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["yAdjust"] = 0,
			["xAdjust"] = 0,
			["showPetOwners"] = true,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 1,
			["verbose"] = false,
		},
	}, -- [5]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["relativePoint"] = "TOPLEFT",
			["point"] = "TOPLEFT",
			["y"] = -100,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
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
				["useBackground"] = true,
				["textSize"] = 10,
				["useText"] = true,
				["O"] = 0.4,
				["B"] = 1,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["useOpacity"] = true,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["maxChars"] = 0,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 8,
				["textSize"] = 10,
			},
			["barTexture"] = "VuhDo - Polished Wood",
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1,
			["barHeight"] = 25,
			["maxColumnsWhenStructured"] = 8,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["borderGapX"] = 5,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["manaBarHeight"] = 3,
			["totSpacing"] = 3,
			["isDamFlash"] = true,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["showTot"] = false,
			["isPlayerOnTop"] = true,
			["sideRightWidth"] = 6,
			["isTarClassColBack"] = false,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["barWidth"] = 75,
			["rowSpacing"] = 2,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["yAdjust"] = 0,
			["xAdjust"] = 0,
			["showPetOwners"] = true,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 1,
			["verbose"] = false,
		},
	}, -- [6]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["relativePoint"] = "TOPLEFT",
			["point"] = "TOPLEFT",
			["y"] = -100,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
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
				["useBackground"] = true,
				["textSize"] = 10,
				["useText"] = true,
				["O"] = 0.4,
				["B"] = 1,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["useOpacity"] = true,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["maxChars"] = 0,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 8,
				["textSize"] = 10,
			},
			["barTexture"] = "VuhDo - Polished Wood",
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1,
			["barHeight"] = 25,
			["maxColumnsWhenStructured"] = 8,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["borderGapX"] = 5,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["manaBarHeight"] = 3,
			["totSpacing"] = 3,
			["isDamFlash"] = true,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["showTot"] = false,
			["isPlayerOnTop"] = true,
			["sideRightWidth"] = 6,
			["isTarClassColBack"] = false,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["barWidth"] = 75,
			["rowSpacing"] = 2,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["yAdjust"] = 0,
			["xAdjust"] = 0,
			["showPetOwners"] = true,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 1,
			["verbose"] = false,
		},
	}, -- [7]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["relativePoint"] = "TOPLEFT",
			["point"] = "TOPLEFT",
			["y"] = -100,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
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
				["useBackground"] = true,
				["textSize"] = 10,
				["useText"] = true,
				["O"] = 0.4,
				["B"] = 1,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["useOpacity"] = true,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["maxChars"] = 0,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 8,
				["textSize"] = 10,
			},
			["barTexture"] = "VuhDo - Polished Wood",
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1,
			["barHeight"] = 25,
			["maxColumnsWhenStructured"] = 8,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["borderGapX"] = 5,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["manaBarHeight"] = 3,
			["totSpacing"] = 3,
			["isDamFlash"] = true,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["showTot"] = false,
			["isPlayerOnTop"] = true,
			["sideRightWidth"] = 6,
			["isTarClassColBack"] = false,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["barWidth"] = 75,
			["rowSpacing"] = 2,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["yAdjust"] = 0,
			["xAdjust"] = 0,
			["showPetOwners"] = true,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 1,
			["verbose"] = false,
		},
	}, -- [8]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["relativePoint"] = "TOPLEFT",
			["point"] = "TOPLEFT",
			["y"] = -100,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
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
				["useBackground"] = true,
				["textSize"] = 10,
				["useText"] = true,
				["O"] = 0.4,
				["B"] = 1,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["useOpacity"] = true,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["maxChars"] = 0,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 8,
				["textSize"] = 10,
			},
			["barTexture"] = "VuhDo - Polished Wood",
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1,
			["barHeight"] = 25,
			["maxColumnsWhenStructured"] = 8,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["borderGapX"] = 5,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["manaBarHeight"] = 3,
			["totSpacing"] = 3,
			["isDamFlash"] = true,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["showTot"] = false,
			["isPlayerOnTop"] = true,
			["sideRightWidth"] = 6,
			["isTarClassColBack"] = false,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["barWidth"] = 75,
			["rowSpacing"] = 2,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["yAdjust"] = 0,
			["xAdjust"] = 0,
			["showPetOwners"] = true,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 1,
			["verbose"] = false,
		},
	}, -- [9]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["POSITION"] = {
			["y"] = 668,
			["x"] = 100,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 0,
			["isReverse"] = false,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["relativePoint"] = "TOPLEFT",
			["point"] = "TOPLEFT",
			["y"] = -100,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
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
				["useBackground"] = true,
				["textSize"] = 10,
				["useText"] = true,
				["O"] = 0.4,
				["B"] = 1,
			},
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["useOpacity"] = true,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["maxChars"] = 0,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 8,
				["textSize"] = 10,
			},
			["barTexture"] = "VuhDo - Polished Wood",
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1,
			["barHeight"] = 25,
			["maxColumnsWhenStructured"] = 8,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["borderGapX"] = 5,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["manaBarHeight"] = 3,
			["totSpacing"] = 3,
			["isDamFlash"] = true,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["showTot"] = false,
			["isPlayerOnTop"] = true,
			["sideRightWidth"] = 6,
			["isTarClassColBack"] = false,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["borderGapY"] = 5,
			["barWidth"] = 75,
			["rowSpacing"] = 2,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["yAdjust"] = 0,
			["xAdjust"] = 0,
			["showPetOwners"] = true,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 1,
			["verbose"] = false,
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
		["classColorsName"] = true,
		["HEALTH_TEXT"] = {
			["TR"] = 1,
			["TO"] = 1,
			["TB"] = 0,
			["useText"] = false,
			["TG"] = 0,
		},
		["BARS"] = {
			["useOpacity"] = true,
			["R"] = 0.7,
			["useBackground"] = true,
			["O"] = 1,
			["G"] = 0.7,
			["B"] = 0.7,
		},
		["TEXT"] = {
			["TR"] = 1,
			["TO"] = 1,
			["TB"] = 0,
			["useText"] = true,
			["TG"] = 0.82,
		},
	},
	["HOTS"] = {
		["BARS"] = {
			["radioValue"] = 1,
			["width"] = 25,
		},
		["SLOTS"] = {
			"Mend Pet", -- [1]
			[10] = "BOUQUET_AOE Advice",
		},
		["COUNTER_TEXT"] = {
			["X_ADJUST"] = -25,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_MONO"] = false,
			["Y_ADJUST"] = 0,
			["SCALE"] = 66,
			["USE_SHADOW"] = false,
			["ANCHOR"] = "TOPLEFT",
			["USE_OUTLINE"] = true,
		},
		["TIMER_TEXT"] = {
			["X_ADJUST"] = 25,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_MONO"] = false,
			["Y_ADJUST"] = 0,
			["SCALE"] = 60,
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
		["iconRadioValue"] = 2,
	},
	["BAR_COLORS"] = {
		["OVERHEAL_TEXT"] = {
			["useOpacity"] = true,
			["TO"] = 1,
			["TB"] = 0.8,
			["TR"] = 0.8,
			["useText"] = true,
			["TG"] = 1,
		},
		["HOT7"] = {
			["useBackground"] = true,
			["R"] = 1,
			["O"] = 0.75,
			["G"] = 1,
			["B"] = 1,
		},
		["CLUSTER_FAIR"] = {
			["TG"] = 1,
			["R"] = 0.8,
			["TB"] = 0,
			["G"] = 0.8,
			["TR"] = 1,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["HOT1"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["R"] = 1,
			["TB"] = 0.6,
			["G"] = 0.3,
			["TR"] = 1,
			["useText"] = true,
			["TO"] = 1,
			["isClock"] = false,
			["isFullDuration"] = false,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0.3,
		},
		["useDebuffIconBossOnly"] = true,
		["EMERGENCY"] = {
			["TG"] = 0.82,
			["R"] = 1,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["BAR_FRAMES"] = {
			["useOpacity"] = true,
			["R"] = 0,
			["useBackground"] = true,
			["O"] = 0.7,
			["G"] = 0,
			["B"] = 0,
		},
		["RAID_ICONS"] = {
			["1"] = {
				["TG"] = 1,
				["R"] = 1,
				["TB"] = 0.607,
				["G"] = 0.976,
				["TR"] = 0.98,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.305,
			},
			["filterOnly"] = false,
			["3"] = {
				["TG"] = 0.674,
				["R"] = 0.788,
				["TB"] = 0.921,
				["G"] = 0.29,
				["TR"] = 1,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.8,
			},
			["2"] = {
				["TG"] = 0.827,
				["R"] = 1,
				["TB"] = 0.419,
				["G"] = 0.513,
				["TR"] = 1,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.039,
			},
			["enable"] = false,
			["4"] = {
				["TG"] = 1,
				["R"] = 0,
				["TB"] = 0.698,
				["G"] = 0.8,
				["TR"] = 0.698,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.015,
			},
			["7"] = {
				["TG"] = 0.627,
				["R"] = 0.8,
				["TB"] = 0.619,
				["G"] = 0.184,
				["TR"] = 1,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.129,
			},
			["6"] = {
				["TG"] = 0.831,
				["R"] = 0.121,
				["TB"] = 1,
				["G"] = 0.69,
				["TR"] = 0.662,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.972,
			},
			["8"] = {
				["TG"] = 0.231,
				["R"] = 0.847,
				["TB"] = 0.231,
				["G"] = 0.866,
				["TR"] = 0.231,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.89,
			},
			["5"] = {
				["TG"] = 0.87,
				["R"] = 0.466,
				["TB"] = 1,
				["G"] = 0.717,
				["TR"] = 0.725,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.8,
			},
		},
		["useDebuffIcon"] = false,
		["HOT9"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["R"] = 0.3,
			["TB"] = 1,
			["G"] = 1,
			["TR"] = 0.6,
			["useText"] = true,
			["TO"] = 1,
			["isClock"] = false,
			["isFullDuration"] = false,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 1,
		},
		["TAPPED"] = {
			["TG"] = 0.4,
			["R"] = 0.4,
			["TB"] = 0.4,
			["G"] = 0.4,
			["TR"] = 0.4,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.4,
		},
		["HOT_CHARGE_3"] = {
			["TG"] = 1,
			["R"] = 0.3,
			["TB"] = 0.6,
			["G"] = 1,
			["TR"] = 0.6,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0.3,
		},
		["CLUSTER_GOOD"] = {
			["TG"] = 1,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0.8,
			["TR"] = 0,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["DEBUFF3"] = {
			["TG"] = 0.957,
			["R"] = 0.4,
			["TB"] = 1,
			["G"] = 0.4,
			["TR"] = 0.329,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.8,
		},
		["INCOMING"] = {
			["TG"] = 0.82,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = false,
			["useText"] = false,
			["O"] = 0.33,
			["B"] = 0,
		},
		["HOT6"] = {
			["useBackground"] = true,
			["R"] = 1,
			["O"] = 0.75,
			["G"] = 1,
			["B"] = 1,
		},
		["TARGET_ENEMY"] = {
			["TG"] = 0,
			["R"] = 1,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["DEBUFF4"] = {
			["TG"] = 0,
			["R"] = 0.7,
			["TB"] = 1,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.7,
		},
		["DEBUFF6"] = {
			["TG"] = 0.5,
			["R"] = 0.6,
			["TB"] = 0,
			["G"] = 0.3,
			["TR"] = 0.8,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["TARGET_NEUTRAL"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 0,
			["G"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["TARGET_FRIEND"] = {
			["TG"] = 1,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 1,
			["TR"] = 0,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["NO_EMERGENCY"] = {
			["TG"] = 0.82,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.4,
		},
		["HOTS"] = {
			["useColorText"] = true,
			["WARNING"] = {
				["enabled"] = false,
				["lowSecs"] = 3,
				["R"] = 0.5,
				["TB"] = 0.6,
				["G"] = 0.2,
				["TR"] = 1,
				["TO"] = 1,
				["TG"] = 0.6,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 1,
				["B"] = 0.2,
			},
			["isPumpDivineAegis"] = false,
			["isFadeOut"] = false,
			["isFlashWhenLow"] = false,
			["showShieldAbsorb"] = true,
			["useColorBack"] = true,
		},
		["GCD_BAR"] = {
			["useBackground"] = true,
			["R"] = 0.4,
			["O"] = 0.5,
			["G"] = 0.4,
			["B"] = 0.4,
		},
		["IRRELEVANT"] = {
			["TG"] = 0.82,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = false,
			["useText"] = false,
			["O"] = 0.2,
			["B"] = 0.4,
		},
		["HOT2"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["R"] = 1,
			["TB"] = 0.6,
			["G"] = 1,
			["TR"] = 1,
			["useText"] = true,
			["TO"] = 1,
			["isClock"] = false,
			["isFullDuration"] = false,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0.3,
		},
		["DEAD"] = {
			["TG"] = 0,
			["B"] = 0.301,
			["TB"] = 0.015,
			["G"] = 0.301,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.5,
			["R"] = 0.301,
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
		["OFFLINE"] = {
			["TG"] = 0.576,
			["R"] = 0.298,
			["TB"] = 0.576,
			["G"] = 0.298,
			["TR"] = 0.576,
			["TO"] = 0.58,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.21,
			["B"] = 0.298,
		},
		["OUTRANGED"] = {
			["TG"] = 0,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0,
			["TO"] = 0.5,
			["useOpacity"] = true,
			["useBackground"] = false,
			["useText"] = false,
			["O"] = 0.25,
			["B"] = 0,
		},
		["DEBUFF1"] = {
			["TG"] = 1,
			["R"] = 0,
			["TB"] = 0.6860000000000001,
			["G"] = 0.592,
			["TR"] = 0,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.8,
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
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["modeBack"] = 1,
		},
		["HOT_CHARGE_4"] = {
			["TG"] = 1,
			["R"] = 0.8,
			["TB"] = 1,
			["G"] = 0.8,
			["TR"] = 1,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0.8,
		},
		["DEBUFF2"] = {
			["TG"] = 0,
			["R"] = 0.8,
			["TB"] = 0,
			["G"] = 0.4,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.4,
		},
		["DEBUFF0"] = {
			["useBackground"] = false,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["HOT8"] = {
			["useBackground"] = true,
			["R"] = 1,
			["O"] = 0.75,
			["G"] = 1,
			["B"] = 1,
		},
		["HOT10"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["R"] = 0.3,
			["TB"] = 0.3,
			["G"] = 1,
			["TR"] = 0.6,
			["useText"] = true,
			["TO"] = 1,
			["isClock"] = false,
			["isFullDuration"] = false,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0.3,
		},
		["THREAT"] = {
			["LOW"] = {
				["useBackground"] = true,
				["R"] = 0,
				["O"] = 1,
				["G"] = 1,
				["B"] = 1,
			},
			["HIGH"] = {
				["useBackground"] = true,
				["R"] = 1,
				["O"] = 1,
				["G"] = 0,
				["B"] = 1,
			},
		},
		["HOT4"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["R"] = 0.3,
			["TB"] = 1,
			["G"] = 0.3,
			["TR"] = 0.6,
			["useText"] = true,
			["TO"] = 1,
			["isClock"] = false,
			["isFullDuration"] = false,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 1,
		},
		["HOT3"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["TR"] = 1,
			["useText"] = true,
			["TO"] = 1,
			["isClock"] = false,
			["isFullDuration"] = false,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 1,
		},
		["HOT5"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 0.3,
			["TR"] = 1,
			["useText"] = true,
			["TO"] = 1,
			["isClock"] = false,
			["isFullDuration"] = false,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 1,
		},
		["LIFE_LEFT"] = {
			["GOOD"] = {
				["useBackground"] = true,
				["R"] = 0,
				["O"] = 1,
				["G"] = 1,
				["B"] = 0,
			},
			["LOW"] = {
				["useBackground"] = true,
				["R"] = 1,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["FAIR"] = {
				["useBackground"] = true,
				["R"] = 1,
				["O"] = 1,
				["G"] = 1,
				["B"] = 0,
			},
		},
		["HOT_CHARGE_2"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 0.6,
			["G"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0.3,
		},
	},
}
VUHDO_SPELL_ASSIGNMENTS = {
	["altshift14"] = {
		"alt-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrlshift15"] = {
		"alt-ctrl-shift-", -- [1]
		"15", -- [2]
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
	["altctrlshift16"] = {
		"alt-ctrl-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altctrl13"] = {
		"alt-ctrl-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["shift3"] = {
		"shift-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["ctrl12"] = {
		"ctrl-", -- [1]
		"12", -- [2]
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
	["alt2"] = {
		"alt-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["shift14"] = {
		"shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrl14"] = {
		"alt-ctrl-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altshift16"] = {
		"alt-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrl9"] = {
		"ctrl-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["13"] = {
		"", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["altshift8"] = {
		"alt-shift-", -- [1]
		"8", -- [2]
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
	["altctrl16"] = {
		"alt-ctrl-", -- [1]
		"16", -- [2]
		"", -- [3]
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
	["altshift10"] = {
		"alt-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altshift11"] = {
		"alt-shift-", -- [1]
		"11", -- [2]
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
	["ctrlshift10"] = {
		"ctrl-shift-", -- [1]
		"10", -- [2]
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
	["ctrl2"] = {
		"ctrl-", -- [1]
		"2", -- [2]
		"menu", -- [3]
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
	["altctrl6"] = {
		"alt-ctrl-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["altctrl1"] = {
		"alt-ctrl-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["altctrl5"] = {
		"alt-ctrl-", -- [1]
		"5", -- [2]
		"menu", -- [3]
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
	["12"] = {
		"", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["ctrlshift5"] = {
		"ctrl-shift-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["alt8"] = {
		"alt-", -- [1]
		"8", -- [2]
		"", -- [3]
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
	["alt10"] = {
		"alt-", -- [1]
		"10", -- [2]
		"", -- [3]
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
	["ctrl5"] = {
		"ctrl-", -- [1]
		"5", -- [2]
		"menu", -- [3]
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
	["ctrlshift3"] = {
		"ctrl-shift-", -- [1]
		"3", -- [2]
		"focus", -- [3]
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
	["alt1"] = {
		"alt-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["altshift9"] = {
		"alt-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["ctrlshift7"] = {
		"ctrl-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
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
	["altctrl7"] = {
		"alt-ctrl-", -- [1]
		"7", -- [2]
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
		"menu", -- [3]
	},
	["alt14"] = {
		"alt-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["alt4"] = {
		"alt-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["alt9"] = {
		"alt-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["1"] = {
		"", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["15"] = {
		"", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altctrlshift3"] = {
		"alt-ctrl-shift-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["2"] = {
		"", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["5"] = {
		"", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["4"] = {
		"", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["7"] = {
		"", -- [1]
		"7", -- [2]
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
	["8"] = {
		"", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["shift13"] = {
		"shift-", -- [1]
		"13", -- [2]
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
	["altctrlshift10"] = {
		"alt-ctrl-shift-", -- [1]
		"10", -- [2]
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
	["ctrlshift2"] = {
		"ctrl-shift-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
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
	["shift2"] = {
		"shift-", -- [1]
		"2", -- [2]
		"assist", -- [3]
	},
	["3"] = {
		"", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["ctrl6"] = {
		"ctrl-", -- [1]
		"6", -- [2]
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
	["altctrlshift2"] = {
		"alt-ctrl-shift-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["ctrlshift11"] = {
		"ctrl-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["ctrlshift1"] = {
		"ctrl-shift-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["altctrlshift9"] = {
		"alt-ctrl-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["shift4"] = {
		"shift-", -- [1]
		"4", -- [2]
		"menu", -- [3]
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
	["ctrl4"] = {
		"ctrl-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["ctrl3"] = {
		"ctrl-", -- [1]
		"3", -- [2]
		"focus", -- [3]
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
	["ctrl8"] = {
		"ctrl-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl15"] = {
		"alt-ctrl-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altctrlshift14"] = {
		"alt-ctrl-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["alt12"] = {
		"alt-", -- [1]
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
	["ctrl12"] = {
		"ctrl-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrl16"] = {
		"alt-ctrl-", -- [1]
		"16", -- [2]
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
	["alt2"] = {
		"alt-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["shift14"] = {
		"shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrl14"] = {
		"alt-ctrl-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altshift6"] = {
		"alt-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["altshift11"] = {
		"alt-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["altctrlshift6"] = {
		"alt-ctrl-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["altshift8"] = {
		"alt-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["ctrlshift4"] = {
		"ctrl-shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["ctrl2"] = {
		"ctrl-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["altctrlshift16"] = {
		"alt-ctrl-shift-", -- [1]
		"16", -- [2]
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
	["ctrlshift15"] = {
		"ctrl-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altshift16"] = {
		"alt-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altshift10"] = {
		"alt-shift-", -- [1]
		"10", -- [2]
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
	["13"] = {
		"", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["ctrlshift10"] = {
		"ctrl-shift-", -- [1]
		"10", -- [2]
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
	["altctrlshift14"] = {
		"alt-ctrl-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrl3"] = {
		"alt-ctrl-", -- [1]
		"3", -- [2]
		"", -- [3]
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
		"", -- [3]
	},
	["altctrl6"] = {
		"alt-ctrl-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["altctrl1"] = {
		"alt-ctrl-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["altshift5"] = {
		"alt-shift-", -- [1]
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
	["shift8"] = {
		"shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["shift1"] = {
		"shift-", -- [1]
		"1", -- [2]
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
	["ctrlshift16"] = {
		"ctrl-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["12"] = {
		"", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["ctrlshift5"] = {
		"ctrl-shift-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["ctrlshift9"] = {
		"ctrl-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["altshift12"] = {
		"alt-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altshift4"] = {
		"alt-shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["alt10"] = {
		"alt-", -- [1]
		"10", -- [2]
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
	["16"] = {
		"", -- [1]
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
	["ctrl5"] = {
		"ctrl-", -- [1]
		"5", -- [2]
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
	["ctrlshift3"] = {
		"ctrl-shift-", -- [1]
		"3", -- [2]
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
	["alt1"] = {
		"alt-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["altshift9"] = {
		"alt-shift-", -- [1]
		"9", -- [2]
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
	["altctrl7"] = {
		"alt-ctrl-", -- [1]
		"7", -- [2]
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
	["alt4"] = {
		"alt-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["alt9"] = {
		"alt-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["1"] = {
		"", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["15"] = {
		"", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altctrlshift3"] = {
		"alt-ctrl-shift-", -- [1]
		"3", -- [2]
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
	["7"] = {
		"", -- [1]
		"7", -- [2]
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
	["8"] = {
		"", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["shift13"] = {
		"shift-", -- [1]
		"13", -- [2]
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
	["altctrlshift10"] = {
		"alt-ctrl-shift-", -- [1]
		"10", -- [2]
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
	["shift2"] = {
		"shift-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["3"] = {
		"", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["ctrl6"] = {
		"ctrl-", -- [1]
		"6", -- [2]
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
	["altshift2"] = {
		"alt-shift-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["altctrlshift2"] = {
		"alt-ctrl-shift-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["ctrlshift11"] = {
		"ctrl-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["ctrlshift1"] = {
		"ctrl-shift-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["altctrlshift9"] = {
		"alt-ctrl-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["shift4"] = {
		"shift-", -- [1]
		"4", -- [2]
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
	["alt8"] = {
		"alt-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["ctrl3"] = {
		"ctrl-", -- [1]
		"3", -- [2]
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
	["ctrl8"] = {
		"ctrl-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl15"] = {
		"alt-ctrl-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl4"] = {
		"ctrl-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["alt12"] = {
		"alt-", -- [1]
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
	["CONFIG"] = {
		["SWATCH_COLOR_BUFF_OUT"] = {
			["TG"] = 0,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0.8,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["SHOW_LABEL"] = false,
		["REFRESH_SECS"] = 1,
		["SWATCH_COLOR_BUFF_COOLDOWN"] = {
			["TG"] = 0.6,
			["R"] = 0.3,
			["TB"] = 0.6,
			["G"] = 0.3,
			["TR"] = 0.6,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.3,
		},
		["SWATCH_COLOR_BUFF_OKAY"] = {
			["TG"] = 0.8,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["SHOW"] = false,
		["PANEL_BG_COLOR"] = {
			["useBackground"] = true,
			["useOpacity"] = false,
			["R"] = 0,
			["useText"] = false,
			["O"] = 0.5,
			["G"] = 0,
			["B"] = 0,
		},
		["SWATCH_COLOR_BUFF_LOW"] = {
			["TG"] = 0.7,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0,
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
			["useOpacity"] = false,
			["R"] = 0,
			["useText"] = false,
			["O"] = 0.5,
			["G"] = 0,
			["B"] = 0,
		},
		["BAR_COLORS_BACKGROUND"] = true,
		["USE_COMBINED"] = true,
		["SWATCH_BG_COLOR"] = {
			["useBackground"] = true,
			["useOpacity"] = false,
			["R"] = 0,
			["useText"] = false,
			["O"] = 1,
			["G"] = 0,
			["B"] = 0,
		},
		["WHEEL_SMART_BUFF"] = false,
		["REBUFF_MIN_MINUTES"] = 3,
		["SWATCH_BORDER_COLOR"] = {
			["useBackground"] = true,
			["useOpacity"] = false,
			["R"] = 0.8,
			["useText"] = false,
			["O"] = 0,
			["G"] = 0.8,
			["B"] = 0.8,
		},
		["REBUFF_AT_PERCENT"] = 25,
		["PANEL_MAX_BUFFS"] = 5,
		["POSITION"] = {
			["y"] = -100,
			["x"] = 100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
	},
	["Trueshot Aura"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["B"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["buff"] = "Trueshot Aura",
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Aspect"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["B"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["filter"] = {
			[999] = true,
		},
		["enabled"] = false,
		["buff"] = "Aspect of the Hawk",
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
		["useText"] = true,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["B"] = 0,
	}, -- [1]
	{
		["TG"] = 0.5,
		["R"] = 1,
		["TB"] = 0.25,
		["G"] = 0.5,
		["TR"] = 1,
		["TO"] = 1,
		["useText"] = true,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["B"] = 0.25,
	}, -- [2]
	{
		["TG"] = 1,
		["R"] = 1,
		["TB"] = 0,
		["G"] = 1,
		["TR"] = 1,
		["TO"] = 1,
		["useText"] = true,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["B"] = 0,
	}, -- [3]
	{
		["TG"] = 1,
		["R"] = 0,
		["TB"] = 1,
		["G"] = 1,
		["TR"] = 0,
		["TO"] = 1,
		["useText"] = true,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["B"] = 1,
	}, -- [4]
	nil, -- [5]
	{
		["TG"] = 0.5,
		["R"] = 0.5,
		["TB"] = 0.5,
		["G"] = 0.5,
		["TR"] = 0.5,
		["TO"] = 1,
		["useText"] = true,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["B"] = 0.5,
	}, -- [6]
	[0] = {
		["TG"] = 0,
		["R"] = 0,
		["TB"] = 1,
		["G"] = 0,
		["TR"] = 0,
		["TO"] = 1,
		["useText"] = true,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["B"] = 1,
	},
}
VUHDO_SPELLS_KEYBOARD = {
	["SPELL15"] = "",
	["SPELL6"] = "",
	["SPELL13"] = "",
	["HOSTILE_WHEEL"] = {
		["alt1"] = {
			"ALT-", -- [1]
			"-w3", -- [2]
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
		["altctrl1"] = {
			"ALT-CTRL-", -- [1]
			"-w9", -- [2]
			"", -- [3]
		},
		["ctrl1"] = {
			"CTRL-", -- [1]
			"-w5", -- [2]
			"", -- [3]
		},
		["altctrlshift2"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w16", -- [2]
			"", -- [3]
		},
		["altshift2"] = {
			"ALT-SHIFT-", -- [1]
			"-w12", -- [2]
			"", -- [3]
		},
		["alt2"] = {
			"ALT-", -- [1]
			"-w4", -- [2]
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
		["1"] = {
			"", -- [1]
			"-w1", -- [2]
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
	["WHEEL"] = {
		["alt1"] = {
			"ALT-", -- [1]
			"-w3", -- [2]
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
		["altctrl1"] = {
			"ALT-CTRL-", -- [1]
			"-w9", -- [2]
			"", -- [3]
		},
		["ctrl1"] = {
			"CTRL-", -- [1]
			"-w5", -- [2]
			"", -- [3]
		},
		["altctrlshift2"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w16", -- [2]
			"", -- [3]
		},
		["altshift2"] = {
			"ALT-SHIFT-", -- [1]
			"-w12", -- [2]
			"", -- [3]
		},
		["alt2"] = {
			"ALT-", -- [1]
			"-w4", -- [2]
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
		["1"] = {
			"", -- [1]
			"-w1", -- [2]
			"", -- [3]
		},
		["ctrlshift2"] = {
			"CTRL-SHIFT-", -- [1]
			"-w14", -- [2]
			"", -- [3]
		},
	},
	["SPELL8"] = "",
	["SPELL1"] = "",
	["SPELL11"] = "",
}
VUHDO_SPELL_CONFIG = {
	["IS_LOAD_HOTS"] = false,
	["IS_FIRE_HOT"] = false,
	["IS_AUTO_FIRE"] = true,
	["IS_FIRE_CUSTOM_2"] = false,
	["IS_FIRE_GLOVES"] = false,
	["IS_FIRE_TRINKET_1"] = false,
	["IS_CANCEL_CURRENT"] = false,
	["autoBattleRez"] = true,
	["IS_KEEP_STANCE"] = false,
	["IS_FIRE_TRINKET_2"] = false,
	["IS_AUTO_TARGET"] = false,
	["smartCastModi"] = "all",
	["FIRE_CUSTOM_1_SPELL"] = "",
	["FIRE_CUSTOM_2_SPELL"] = "",
	["IS_TOOLTIP_INFO"] = false,
	["IS_FIRE_CUSTOM_1"] = false,
	["IS_FIRE_OUT_FIGHT"] = false,
}
VUHDO_BUFF_ORDER = {
	["Trueshot Aura"] = 1,
	["Aspect"] = 2,
}
VUHDO_SPEC_LAYOUTS = {
	["1"] = "",
	["selected"] = "",
	["2"] = "",
}
VUHDO_GROUP_SIZE = 1
VUHDO_RAID = {
	["pet"] = {
		["visible"] = 1,
		["targetUnit"] = "pettarget",
		["group"] = 0,
		["classId"] = 22,
		["range"] = true,
		["unit"] = "pet",
		["isVehicle"] = false,
		["powertype"] = 2,
		["healthmax"] = 236242,
		["isAltPower"] = false,
		["baseRange"] = true,
		["sortMaxHp"] = 236242,
		["number"] = 1,
		["zone"] = "Shrine of Two Moons",
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 100,
		["power"] = 100,
		["aggro"] = false,
		["map"] = "ValeofEternalBlossoms",
		["threatPerc"] = 0,
		["isPet"] = true,
		["class"] = "WARRIOR",
		["health"] = 236242,
		["className"] = "Jolteon",
		["debuff"] = 0,
		["ownerUnit"] = "player",
		["fullName"] = "Jolteon",
		["name"] = "Jolteon",
	},
	["player"] = {
		["visible"] = 1,
		["powertype"] = 2,
		["targetUnit"] = "target",
		["group"] = 1,
		["classId"] = 22,
		["range"] = true,
		["unit"] = "player",
		["number"] = 1,
		["debuff"] = 0,
		["healthmax"] = 337489,
		["isAltPower"] = false,
		["baseRange"] = true,
		["sortMaxHp"] = 337489,
		["isVehicle"] = false,
		["class"] = "HUNTER",
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 100,
		["power"] = 100,
		["petUnit"] = "pet",
		["zone"] = "Shrine of Two Moons",
		["threatPerc"] = 0,
		["isPet"] = false,
		["map"] = "ValeofEternalBlossoms",
		["health"] = 337489,
		["className"] = "Hunter",
		["fullName"] = "Pezzer",
		["aggro"] = false,
		["role"] = 62,
		["name"] = "Pezzer",
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
			["FILE"] = "Interface\\AddOns\\VuhDo\\Images\\white_square_16_16",
			["WIDTH"] = 2,
		},
		["SIDE_LEFT"] = {
			["turnAxis"] = false,
			["vertical"] = true,
			["invertGrowth"] = false,
			["TEXTURE"] = "VuhDo - Plain White",
		},
		["MANA_BAR"] = {
			["turnAxis"] = false,
			["invertGrowth"] = false,
			["TEXTURE"] = "VuhDo - Pipe, light",
		},
		["SIDE_RIGHT"] = {
			["turnAxis"] = false,
			["vertical"] = true,
			["invertGrowth"] = false,
			["TEXTURE"] = "VuhDo - Plain White",
		},
		["HEALTH_BAR"] = {
			["turnAxis"] = false,
			["vertical"] = false,
			["invertGrowth"] = false,
		},
		["BAR_BORDER"] = {
			["FILE"] = "Interface\\AddOns\\VuhDo\\Images\\white_square_16_16",
			["ADJUST"] = 0,
			["WIDTH"] = 1,
		},
		["SWIFTMEND_INDICATOR"] = {
			["SCALE"] = 1.2,
		},
	},
	["BOUQUETS"] = {
		["THREAT_BAR"] = "",
		["MOUSEOVER_HIGHLIGHT"] = "",
		["AGGRO_BAR"] = "",
		["BACKGROUND_BAR"] = "Background: Solid",
		["DAMAGE_FLASH_BAR"] = "",
		["CLUSTER_BORDER"] = "",
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
		["SIDE_LEFT"] = "",
		["THREAT_MARK"] = "",
		["MANA_BAR"] = "",
		["BAR_BORDER"] = "Border: Multi + Aggro",
		["SIDE_RIGHT"] = "",
		["HEALTH_BAR"] = "Health (generic, class col)",
		["SWIFTMEND_INDICATOR"] = "Role Icon",
		["INCOMING_BAR"] = "",
	},
}
VUHDO_EVENT_TIMES = nil
