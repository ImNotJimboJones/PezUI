
VUHDO_CONFIG = {
	["SMARTCAST_CLEANSE"] = true,
	["RANGE_SPELL"] = "",
	["BLIZZ_UI_HIDE_PARTY"] = 3,
	["OMIT_PLAYER_TARGETS"] = false,
	["BLIZZ_UI_HIDE_TARGET"] = 3,
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
			["ch"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
			["poh"] = {
				["enable"] = true,
				["thresh"] = 20000,
			},
			["lod"] = {
				["enable"] = true,
				["thresh"] = 8000,
			},
			["cb"] = {
				["enable"] = false,
				["thresh"] = 10000,
			},
			["ef"] = {
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
	["BLIZZ_UI_HIDE_PET"] = 3,
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
	["BLIZZ_UI_HIDE_RAID"] = 2,
	["DETECT_DEBUFFS_REMOVABLE_ONLY"] = true,
	["IS_READY_CHECK_DISABLED"] = false,
	["CLUSTER"] = {
		["BELOW_HEALTH_PERC"] = 85,
		["CHAIN_MAX_JUMP"] = 3,
		["REFRESH"] = 180,
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
		["RANGE_JUMP"] = 11,
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
	["BLIZZ_UI_HIDE_FOCUS"] = 3,
	["DETECT_DEBUFFS_IGNORE_NO_HARM"] = true,
	["DETECT_DEBUFFS_IGNORE_BY_CLASS"] = true,
	["RES_IS_SHOW_TEXT"] = true,
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
			"Exhale", -- [88]
			"Pheromones of Zeal", -- [89]
			"Convert", -- [90]
			"Noise Cancelling", -- [91]
			"Unseen Strike", -- [92]
			"Overwhelming Assault", -- [93]
			"Storm Unleashed", -- [94]
			"Wind Step", -- [95]
			"Pheromones", -- [96]
			"Pungency", -- [97]
			"Crush", -- [98]
			"Weak Points", -- [99]
			"Amber Prison", -- [100]
			"Residue", -- [101]
			"Corrosive Resin", -- [102]
			"Parasitic Growth", -- [103]
			"Reshape Life", -- [104]
			"Fixate", -- [105]
			"Eyes of the Empress", -- [106]
			"Cry of Terror", -- [107]
			"Sticky Resin", -- [108]
			"Trapped!", -- [109]
			"Poison Bomb", -- [110]
			"Poison-Drenched Armor", -- [111]
			"Poison Fumes", -- [112]
			"Consuming Terror", -- [113]
			"Visions of Demise", -- [114]
			"Heart of Fear", -- [115]
			"Dissonance Field", -- [116]
			"Sha Corruption", -- [117]
			"Dismantled Armor", -- [118]
			"Arterial Bleeding", -- [119]
			"Gouge Throat", -- [120]
			"Riposte", -- [121]
			"Gale Force Winds", -- [122]
			"Stunning Strike", -- [123]
			"Slam", -- [124]
			"Burning Sting", -- [125]
			"Mortal Rend", -- [126]
			"Grievous Whirl", -- [127]
			"Petrified", -- [128]
			"Smoke Bomb", -- [129]
			"Sundering Bite", -- [130]
			"Ground Slam", -- [131]
			"Pyroblast", -- [132]
			"Troll Rush", -- [133]
			"Jasper Chains", -- [134]
			"Amethyst Pool", -- [135]
			"Jasper Petrification", -- [136]
			"Cobalt Petrification", -- [137]
			"Amethyst Petrification", -- [138]
			"Cobalt Mine Blast", -- [139]
			"Rend Flesh", -- [140]
			"Jade Petrification", -- [141]
			"Lightning Lash", -- [142]
			"Epicenter", -- [143]
			"Flaming Spear", -- [144]
			"Wildfire Spark", -- [145]
			"Arcane Shock", -- [146]
			"Arcane Resonance", -- [147]
			"Arcane Velocity", -- [148]
			"Lightning Charge", -- [149]
			"Shadowburn", -- [150]
			"Voodoo Doll", -- [151]
			"Frail Soul", -- [152]
			"Crossed Over", -- [153]
			"Soul Sever", -- [154]
			"Maddening Shout", -- [155]
			"Pillaged", -- [156]
			"Pinned Down", -- [157]
			"Pillage", -- [158]
			"Robbed Blind", -- [159]
			"Overcharged", -- [160]
			"Closed Circuit", -- [161]
			"Arcing Energy", -- [162]
			"Destabilizing Energies", -- [163]
			"Devastating Arc", -- [164]
			"Stomp", -- [165]
			"Focused Assault", -- [166]
			"Focused Defense", -- [167]
			"Impeding Thrust", -- [168]
			"Energizing Smash", -- [169]
			"Focused Energy", -- [170]
			"Aggressive Behavior", -- [171]
			"Unleashed Wrath", -- [172]
			"Bitter Thoughts", -- [173]
			"Touch of Sha", -- [174]
			"Lightning Prison", -- [175]
			"Corrupted Essence", -- [176]
			"Defiled Ground", -- [177]
			"Purified", -- [178]
			"Cleansing Waters", -- [179]
			"Overwhelming Corruption", -- [180]
			"Dread Shadows", -- [181]
			"Nightmares", -- [182]
			"Shadow Breath", -- [183]
			"Sunbeam", -- [184]
			"Terrorize", -- [185]
			"Fright", -- [186]
			"Bathed in Light", -- [187]
			"Spray", -- [188]
			"Scary Fog", -- [189]
			"Breath of Fear", -- [190]
			"Ominous Cackle", -- [191]
			"Dread Spray", -- [192]
			"Naked and Afraid", -- [193]
			"Waterspout", -- [194]
			"Huddle in Terror", -- [195]
			"Eternal Darkness", -- [196]
			"Sha Globe", -- [197]
			"Penetrating Bolt", -- [198]
			"Reaching Attack", -- [199]
			"Electrified Waters", -- [200]
			"Focused Lightning", -- [201]
			"Ionization", -- [202]
			"Static Wound", -- [203]
			"Thundering Throw", -- [204]
			"Charge", -- [205]
			"Triple Puncture", -- [206]
			"Stone Gaze", -- [207]
			"Sand Trap", -- [208]
			"Venom Bolt Volley", -- [209]
			"Deadly Plague", -- [210]
			"Mortal Strike", -- [211]
			"Frozen Bolt", -- [212]
			"Hex of Confusion", -- [213]
			"Blazing Sunlight", -- [214]
			"Rending Charge", -- [215]
			"Dire Fixation", -- [216]
			"Frostbite", -- [217]
			"Body Heat", -- [218]
			"Soul Fragment", -- [219]
			"Ensnared", -- [220]
			"Entrapped", -- [221]
			"Shadowed Soul", -- [222]
			"Marked Soul", -- [223]
			"Twisted Fate", -- [224]
			"Quicksand", -- [225]
			"Kick Shell", -- [226]
			"Quake Stomp", -- [227]
			"Sonic Screech", -- [228]
			"Slashing Talons", -- [229]
			"Crystal Shell", -- [230]
			"Cinders", -- [231]
			"Consuming Flames", -- [232]
			"Ignite Flesh", -- [233]
			"Frozen Solid", -- [234]
			"Icy Ground", -- [235]
			"Consuming Magic", -- [236]
			"Arctic Freeze", -- [237]
			"Rot Armor", -- [238]
			"Suppression", -- [239]
			"Slimed", -- [240]
			"Feed Pool", -- [241]
			"Lesson of Icarus", -- [242]
			"Screech", -- [243]
			"Arterial Cut", -- [244]
			"Serious Wound", -- [245]
			"Force of Will Precast", -- [246]
			"Blue Beam Precast", -- [247]
			"Red Beam Precast", -- [248]
			"Yellow Beam Precast", -- [249]
			"Life Drain", -- [250]
			"Dark Parasite", -- [251]
			"Infrared Light", -- [252]
			"Blue Rays", -- [253]
			"Bright Light", -- [254]
			"Lingering Gaze", -- [255]
			"Fully Mutated", -- [256]
			"Keen Eyesight", -- [257]
			"Impaired Eyesight", -- [258]
			"Improved Synapses", -- [259]
			"Dulled Synapses", -- [260]
			"Thick Bones", -- [261]
			"Fragile Bones", -- [262]
			"Clear Mind", -- [263]
			"Clouded Mind", -- [264]
			"Malformed Blood", -- [265]
			"Explosive Slam", -- [266]
			"Touch of the Animus", -- [267]
			"Matter Swap", -- [268]
			"Anima Font", -- [269]
			"Anima Ring", -- [270]
			"Crimson Wake", -- [271]
			"Scorched", -- [272]
			"Arcing Lightning", -- [273]
			"Dead Zone", -- [274]
			"Impale", -- [275]
			"Freeze", -- [276]
			"Frozen Blood", -- [277]
			"Storm Cloud", -- [278]
			"Burning Cinders", -- [279]
			"Rushing Winds", -- [280]
			"Wind Storm", -- [281]
			"Lightning Storm", -- [282]
			"Icy Shadows", -- [283]
			"Flames of Passion", -- [284]
			"Serpent's Vitality", -- [285]
			"Fan of Flames", -- [286]
			"Corrupted Healing", -- [287]
			"Beast of Nightmares", -- [288]
			"Slumber Spores", -- [289]
			"Static Shock", -- [290]
			"Summon Ball Lightning", -- [291]
			"Discharged Energy", -- [292]
			"Overcharge", -- [293]
			"Overloaded Circuits", -- [294]
			"Lightning Bolt", -- [295]
			"Crashing Thunder", -- [296]
			"Electrical Shock", -- [297]
			"Maim", -- [298]
		},
		["isIcon"] = true,
		["selected"] = "",
		["TIMER_TEXT"] = {
			["X_ADJUST"] = -10,
			["USE_MONO"] = false,
			["Y_ADJUST"] = -15,
			["ANCHOR"] = "TOPLEFT",
			["USE_OUTLINE"] = false,
			["SCALE"] = 45,
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
			["USE_SHADOW"] = true,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
		},
		["COUNTER_TEXT"] = {
			["X_ADJUST"] = 15,
			["USE_MONO"] = false,
			["Y_ADJUST"] = 25,
			["ANCHOR"] = "BOTTOMRIGHT",
			["USE_OUTLINE"] = false,
			["SCALE"] = 70,
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
		["isStacks"] = true,
		["yAdjust"] = -34,
		["version"] = 21,
		["point"] = "TOPRIGHT",
		["timer"] = true,
		["isName"] = false,
		["xAdjust"] = -2,
		["STORED_SETTINGS"] = {
			["Dismantled Armor"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flame Breath"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Crush Armor"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ensnared"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Pinned Down"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gravity Core"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Electrical Shock"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Lightning Rod"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Twilight Shift"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Melt Armor"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Touch of the Animus"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Infrared Light"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gale Force Winds"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Amethyst Pool"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Corruption: Accelerated"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Blaze of Glory"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Focused Assault"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Poison-Drenched Armor"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Electrical Storm"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Bathed in Light"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flash Freeze"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Jade Petrification"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Crystal Shell"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Consuming Flames"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Impeding Thrust"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Epicenter"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Anima Font"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Stunning Strike"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Degenerative Bite"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Nightmares"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ground Slam"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Destabilizing Energies"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Burning Wound"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Flame Shock"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Devouring Flames"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Corrupted Essence"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Entrapped"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Body Heat"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Pillaged"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Deadly Plague"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Lingering Gaze"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Searing Plasma"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Degeneration"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Burning Cinders"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Amethyst Petrification"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flame Torrent"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Summon Ball Lightning"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fully Mutated"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ionization"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Searing Flame"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Marked Soul"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Bloodletting"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Smoke Bomb"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Poison Soaked Shell"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Charge"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Noise Cancelling"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lightning Charge"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Jasper Chains"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Arterial Cut"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Overwhelming Corruption"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Robbed Blind"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Engulfing Magic"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Quake Stomp"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Freeze"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Clouded Mind"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Breath of Fear"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blue Beam Precast"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Waterspout"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Crimson Wake"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Overloaded Circuits"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ominous Cackle"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frozen Bolt"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Sha Globe"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flames of Passion"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Burning Sting"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Impale"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Arcing Energy"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Arcane Resonance"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Rushing Winds"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Explosive Slam"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Pillage"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gall's Blast"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Reshape Life"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Toxic Torment"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Overwhelming Assault"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Visions of Demise"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Brutal Strike"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Flaming Spear"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Screech"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Life Drain"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Icy Ground"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Mortal Strike"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Rend Flesh"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Impaired Eyesight"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Dead Zone"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Searing Seeds"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Pungency"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Disrupting Shadows"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Frostburn Formula"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Wrack"] = {
				["isStacks"] = true,
				["isAliveTime"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isFullDuration"] = true,
				["isIcon"] = true,
			},
			["Cobalt Mine Blast"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Heroic Will"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Body Slam"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Storm Cloud"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Hex of Confusion"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Suppression"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Dread Spray"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Static Wound"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Kick Shell"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Incineration Security Measure"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Corrupted Healing"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Siphon Soul"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Blood Corruption: Earth"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Overcharged"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sonic Breath"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Stone Gaze"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Unleashed Wrath"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Dulled Synapses"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Keen Eyesight"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Toxic Link"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Crossed Over"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fading Light"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Shadowburn"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Thundering Throw"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ice Storm"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Corrosive Resin"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gouge Throat"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Grasping Tendrils"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Arcing Lightning"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Penetrating Bolt"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Red Beam Precast"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Slumber Spores"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Quicksand"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Sha Corruption"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sundering Bite"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Serpent's Vitality"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Lash of Anguish"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Weak Points"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Anima Ring"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Shockwave"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Slam"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blazing Sunlight"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Shattered Ice"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Consuming Darkness"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Stomp"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Soul Sever"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Break"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Sunbeam"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Faded Into Twilight"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Cry of Terror"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Closed Circuit"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Eternal Darkness"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Rending Charge"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fan of Flames"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Soothing Breeze"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Thick Bones"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Trapped!"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Petrified"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Deep Corruption"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Focused Defense"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Toxic Spores"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Blistering Heat"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Dissonance Field"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fiery Grip"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Dread Shadows"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lightning Storm"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Hydro Lance"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Bright Light"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fixate"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Poison Bomb"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Terrorize"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Arcane Shock"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Mangle"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Watery Entrenchment"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Force of Will Precast"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Cho's Blast"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Torment"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Troll Rush"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fragile Bones"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Reaching Attack"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Amber Prison"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Maddening Shout"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Plucked"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Focused Energy"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Parasitic Growth"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Cinders"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Riposte"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Overcharge"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Arcane Velocity"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Triple Puncture"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Cleansing Waters"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Icy Shadows"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Blue Rays"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Lightning Conductor"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Convert"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Soul Fragment"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Serious Wound"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Scary Fog"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sunder Armor"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Whispers of Hethiss"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Tetanus"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Pheromones of Zeal"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Twisted Fate"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Spray"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fright"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Storm Unleashed"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Decapitate"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Huddle in Terror"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Constricting Chains"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Burning Blood"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Blood Corruption: Death"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Jagged Tear"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Parasitic Infection"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Exhale"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frail Soul"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Arterial Bleeding"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frozen"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Scorched"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Consuming Terror"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Grievous Whirl"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Beast of Nightmares"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Sand Trap"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Touch of Sha"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Wildfire Spark"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Purified"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Dire Fixation"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Slashing Talons"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Frozen Blood"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Frozen Solid"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Low Health"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Arctic Freeze"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Aggressive Behavior"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blackout"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Discharged Energy"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Eyes of the Empress"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["The Widow's Kiss"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Frostbite"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Biting Chill"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Roaring Flame"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Rot Armor"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Residue"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Malevolent Strikes"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Focused Lightning"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ignite Flesh"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fieroblast"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Bitter Thoughts"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lightning Lash"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Electrified Waters"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Unseen Strike"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Black Blood of Go'rath"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Voodoo Doll"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Waterlogged"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Clear Mind"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Crush"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Wind Storm"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ravage"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Lesson of Icarus"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Crashing Thunder"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Yellow Beam Precast"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Pursuit"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Naked and Afraid"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Grievous Throw"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Improved Synapses"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Static Shock"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Twilight Burst"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Malformed Blood"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Lightning Prison"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Defiled Ground"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Twilight Barrage"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Dark Parasite"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Crystal Prison Trap Effect"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Energizing Smash"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Poison Fumes"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ice Patch"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Mortal Rend"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Cobalt Petrification"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pyroblast"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sticky Resin"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Matter Swap"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Shadow Breath"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shadowed Soul"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ice Tomb"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Pheromones"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Slimed"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Feed Pool"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Slicing Gale"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gushing Wound"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gravity Crush"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Jasper Petrification"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Heart of Fear"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Degradation"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Devastating Arc"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sonic Screech"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Venom Bolt Volley"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Wind Step"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Consuming Magic"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Lightning Bolt"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Maim"] = {
				["isStacks"] = true,
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
	["BLIZZ_UI_HIDE_PLAYER"] = 3,
	["HIDE_PANELS_SOLO"] = false,
	["CURRENT_PROFILE"] = "Solo",
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
	["BLIZZ_UI_HIDE_RAID_MGR"] = 2,
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
	["OMIT_MAIN_TANKS"] = false,
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
			["y"] = 148.0755462646484,
			["x"] = 959.913330078125,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOP",
			["height"] = 90,
			["growth"] = "TOP",
			["width"] = 150.0000610351563,
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
				1, -- [1]
			},
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
				["textSizeLife"] = 14,
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
			["maxColumnsWhenStructured"] = 1,
			["barHeight"] = 60,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["borderGapX"] = 15,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 1,
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
			["columnSpacing"] = 10,
			["barWidth"] = 120,
			["borderGapY"] = 15,
			["rowSpacing"] = 10,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["xAdjust"] = 2,
			["_spacing"] = 25.99999618530273,
			["showPetOwners"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
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
			["y"] = 1.869642853736877,
			["x"] = 960.260009765625,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "BOTTOM",
			["height"] = 84.99999237060547,
			["growth"] = "BOTTOM",
			["width"] = 110.0000305175781,
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
			["sort"] = 1,
			["groups"] = {
				81, -- [1]
			},
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
			["barTexture"] = "Minimalist",
			["TEXT"] = {
				["outline"] = false,
				["USE_MONO"] = false,
				["useText"] = true,
				["useOpacity"] = true,
				["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\Emblem.ttf",
				["maxChars"] = 0,
				["USE_SHADOW"] = true,
				["textSizeLife"] = 12,
				["textSize"] = 10,
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
			["maxColumnsWhenStructured"] = 1,
			["barHeight"] = 35,
			["damFlashFactor"] = 0.75,
			["isTarClassColText"] = true,
			["targetSpacing"] = 3,
			["targetWidth"] = 30,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["borderGapX"] = 20,
			["sideLeftWidth"] = 6,
			["headerWidth"] = 100,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 1,
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
			["columnSpacing"] = 8,
			["barWidth"] = 70,
			["borderGapY"] = 25,
			["rowSpacing"] = 8,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["xAdjust"] = 2,
			["_spacing"] = 22.0000057220459,
			["showPetOwners"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
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
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
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
				["textSizeLife"] = 12,
				["textSize"] = 9,
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1.25,
			["maxColumnsWhenStructured"] = 2,
			["barHeight"] = 35,
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
			["maxRowsWhenLoose"] = 2,
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
			["columnSpacing"] = 5,
			["barWidth"] = 65,
			["borderGapY"] = 5,
			["rowSpacing"] = 5,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["xAdjust"] = 2,
			["_spacing"] = 18,
			["showPetOwners"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
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
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
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
				["textSizeLife"] = 12,
				["textSize"] = 9,
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1.25,
			["maxColumnsWhenStructured"] = 2,
			["barHeight"] = 35,
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
			["maxRowsWhenLoose"] = 2,
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
			["columnSpacing"] = 5,
			["barWidth"] = 65,
			["borderGapY"] = 5,
			["rowSpacing"] = 5,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["showTags"] = true,
			["position"] = "CENTER+CENTER",
			["yAdjust"] = 2,
			["xAdjust"] = 2,
			["_spacing"] = 18,
			["showPetOwners"] = false,
		},
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
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
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
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
			["ordering"] = 0,
			["sort"] = 1,
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
				["textSizeLife"] = 12,
				["textSize"] = 9,
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1.25,
			["maxColumnsWhenStructured"] = 2,
			["barHeight"] = 35,
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
			["maxRowsWhenLoose"] = 2,
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
			["columnSpacing"] = 5,
			["barWidth"] = 65,
			["borderGapY"] = 5,
			["rowSpacing"] = 5,
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
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
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
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
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
			["ordering"] = 0,
			["sort"] = 1,
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
				["textSizeLife"] = 12,
				["textSize"] = 9,
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1.25,
			["maxColumnsWhenStructured"] = 2,
			["barHeight"] = 35,
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
			["maxRowsWhenLoose"] = 2,
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
			["columnSpacing"] = 5,
			["barWidth"] = 65,
			["borderGapY"] = 5,
			["rowSpacing"] = 5,
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
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
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
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
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
			["ordering"] = 0,
			["sort"] = 1,
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
				["textSizeLife"] = 12,
				["textSize"] = 9,
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1.25,
			["maxColumnsWhenStructured"] = 2,
			["barHeight"] = 35,
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
			["maxRowsWhenLoose"] = 2,
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
			["columnSpacing"] = 5,
			["barWidth"] = 65,
			["borderGapY"] = 5,
			["rowSpacing"] = 5,
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
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
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
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
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
			["ordering"] = 0,
			["sort"] = 1,
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
				["textSizeLife"] = 12,
				["textSize"] = 9,
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1.25,
			["maxColumnsWhenStructured"] = 2,
			["barHeight"] = 35,
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
			["maxRowsWhenLoose"] = 2,
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
			["columnSpacing"] = 5,
			["barWidth"] = 65,
			["borderGapY"] = 5,
			["rowSpacing"] = 5,
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
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
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
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
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
			["ordering"] = 0,
			["sort"] = 1,
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
				["textSizeLife"] = 12,
				["textSize"] = 9,
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1.25,
			["maxColumnsWhenStructured"] = 2,
			["barHeight"] = 35,
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
			["maxRowsWhenLoose"] = 2,
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
			["columnSpacing"] = 5,
			["barWidth"] = 65,
			["borderGapY"] = 5,
			["rowSpacing"] = 5,
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
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
			["verbose"] = false,
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
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
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
			["ordering"] = 0,
			["sort"] = 1,
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
				["textSizeLife"] = 12,
				["textSize"] = 9,
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
			["alignBottom"] = false,
			["arrangeHorizontal"] = false,
			["scale"] = 1.25,
			["maxColumnsWhenStructured"] = 2,
			["barHeight"] = 35,
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
			["maxRowsWhenLoose"] = 2,
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
			["columnSpacing"] = 5,
			["barWidth"] = 65,
			["borderGapY"] = 5,
			["rowSpacing"] = 5,
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
		["LIFE_TEXT"] = {
			["show"] = true,
			["hideIrrelevant"] = false,
			["position"] = 3,
			["showTotalHp"] = false,
			["mode"] = 2,
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
		["DIRECTION"] = {
			["useBackground"] = true,
			["R"] = 1,
			["G"] = 0.4,
			["O"] = 1,
			["B"] = 0.4,
		},
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
				["TB"] = 0.6979,
				["G"] = 0.8,
				["TR"] = 0.6979,
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
				["G"] = 0.6899,
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
		["useDebuffIcon"] = true,
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
		["SHIELD"] = {
			["TG"] = 0.52,
			["B"] = 1,
			["TB"] = 1,
			["G"] = 0.52,
			["TR"] = 0.35,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = false,
			["O"] = 1,
			["R"] = 0.35,
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
			["TB"] = 0.035,
			["G"] = 0.301,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.5,
			["R"] = 0.301,
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
	["ctrlshift5"] = {
		"ctrl-shift-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["shift3"] = {
		"shift-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["ctrl1"] = {
		"ctrl-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["ctrl5"] = {
		"ctrl-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["altctrlshift4"] = {
		"alt-ctrl-shift-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["alt4"] = {
		"alt-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["1"] = {
		"", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["3"] = {
		"", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["2"] = {
		"", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["ctrlshift2"] = {
		"ctrl-shift-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["4"] = {
		"", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["altctrlshift1"] = {
		"alt-ctrl-shift-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["altctrlshift5"] = {
		"alt-ctrl-shift-", -- [1]
		"5", -- [2]
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
	["shift2"] = {
		"shift-", -- [1]
		"2", -- [2]
		"assist", -- [3]
	},
	["altshift1"] = {
		"alt-shift-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["altctrl1"] = {
		"alt-ctrl-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["altshift2"] = {
		"alt-shift-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["altctrlshift2"] = {
		"alt-ctrl-shift-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["ctrlshift3"] = {
		"ctrl-shift-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["ctrlshift1"] = {
		"ctrl-shift-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["altctrl4"] = {
		"alt-ctrl-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["shift4"] = {
		"shift-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["altctrl2"] = {
		"alt-ctrl-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["ctrl4"] = {
		"ctrl-", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["altshift3"] = {
		"alt-shift-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["ctrlshift4"] = {
		"ctrl-shift-", -- [1]
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
	["shift5"] = {
		"shift-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["alt5"] = {
		"alt-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["5"] = {
		"", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["alt3"] = {
		"alt-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["alt1"] = {
		"alt-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["alt2"] = {
		"alt-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["ctrl3"] = {
		"ctrl-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["altctrlshift3"] = {
		"alt-ctrl-shift-", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["altctrl5"] = {
		"alt-ctrl-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["altshift5"] = {
		"alt-shift-", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
}
VUHDO_HOSTILE_SPELL_ASSIGNMENTS = {
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
	["Legacy of the White Tiger"] = {
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
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
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
	["Legacy of the Emperor"] = {
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
		["enabled"] = false,
		["filter"] = {
			[999] = true,
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
	["Stance"] = {
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
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
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
		["ctrl2"] = {
			"CTRL-", -- [1]
			"-w6", -- [2]
			"", -- [3]
		},
		["2"] = {
			"", -- [1]
			"-w2", -- [2]
			"", -- [3]
		},
		["ctrlshift2"] = {
			"CTRL-SHIFT-", -- [1]
			"-w14", -- [2]
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
		["shift1"] = {
			"SHIFT-", -- [1]
			"-w7", -- [2]
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
		["ctrl2"] = {
			"CTRL-", -- [1]
			"-w6", -- [2]
			"", -- [3]
		},
		["2"] = {
			"", -- [1]
			"-w2", -- [2]
			"", -- [3]
		},
		["ctrlshift2"] = {
			"CTRL-SHIFT-", -- [1]
			"-w14", -- [2]
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
		["shift1"] = {
			"SHIFT-", -- [1]
			"-w7", -- [2]
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
	["Legacy of the Emperor"] = 1,
	["Legacy of the White Tiger"] = 2,
	["Stance"] = 3,
}
VUHDO_SPEC_LAYOUTS = {
	["1"] = "",
	["selected"] = "",
	["2"] = "",
}
VUHDO_GROUP_SIZE = 1
VUHDO_RAID = {
	["player"] = {
		["visible"] = 1,
		["map"] = "Orgrimmar",
		["targetUnit"] = "target",
		["group"] = 1,
		["classId"] = 30,
		["range"] = true,
		["unit"] = "player",
		["number"] = 1,
		["debuff"] = 0,
		["healthmax"] = 6580,
		["baseRange"] = true,
		["isVehicle"] = false,
		["sortMaxHp"] = 6580,
		["class"] = "MONK",
		["zone"] = "Orgrimmar",
		["debuffName"] = "",
		["threat"] = 0,
		["powermax"] = 4715,
		["power"] = 4715,
		["petUnit"] = "pet",
		["powertype"] = 0,
		["threatPerc"] = 0,
		["isPet"] = false,
		["fullName"] = "Broccori",
		["health"] = 6580,
		["className"] = "Monk",
		["connected"] = 1,
		["aggro"] = false,
		["role"] = 63,
		["name"] = "Broccori",
	},
}
VUHDO_INDICATOR_CONFIG = {
	["BOUQUETS"] = {
		["THREAT_BAR"] = "",
		["MOUSEOVER_HIGHLIGHT"] = "",
		["AGGRO_BAR"] = "",
		["BACKGROUND_BAR"] = "Background: Solid",
		["SIDE_LEFT"] = "",
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
		["DAMAGE_FLASH_BAR"] = "",
		["THREAT_MARK"] = "",
		["BAR_BORDER"] = "Border: Multi + Aggro",
		["SIDE_RIGHT"] = "",
		["MANA_BAR"] = "Manabars: Mana only",
		["HEALTH_BAR"] = "Health (generic, solid)",
		["CLUSTER_BORDER"] = "",
		["INCOMING_BAR"] = "",
	},
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
		["BAR_BORDER"] = {
			["FILE"] = "Interface\\AddOns\\VuhDo\\Images\\white_square_16_16",
			["ADJUST"] = 0,
			["WIDTH"] = 1,
		},
		["SIDE_RIGHT"] = {
			["turnAxis"] = false,
			["vertical"] = true,
			["invertGrowth"] = false,
			["TEXTURE"] = "VuhDo - Plain White",
		},
		["HOT_BARS"] = {
			["turnAxis"] = false,
			["vertical"] = false,
			["invertGrowth"] = false,
		},
		["HEALTH_BAR"] = {
			["turnAxis"] = false,
			["vertical"] = false,
			["invertGrowth"] = false,
		},
		["MANA_BAR"] = {
			["turnAxis"] = false,
			["invertGrowth"] = false,
			["TEXTURE"] = "VuhDo - Pipe, light",
		},
		["SWIFTMEND_INDICATOR"] = {
			["SCALE"] = 0.699,
		},
	},
	["TEXT_INDICATORS"] = {
		["OVERHEAL_TEXT"] = {
			["TEXT_PROVIDER"] = {
				"OVERHEAL_KILO_PLUS_N_K", -- [1]
				"OVERHEAL_KILO_PLUS_N_K", -- [2]
				"OVERHEAL_KILO_PLUS_N_K", -- [3]
				"OVERHEAL_KILO_PLUS_N_K", -- [4]
				"OVERHEAL_KILO_PLUS_N_K", -- [5]
				"OVERHEAL_KILO_PLUS_N_K", -- [6]
				"OVERHEAL_KILO_PLUS_N_K", -- [7]
				"OVERHEAL_KILO_PLUS_N_K", -- [8]
				"OVERHEAL_KILO_PLUS_N_K", -- [9]
				"OVERHEAL_KILO_PLUS_N_K", -- [10]
			},
		},
		["SIDE_RIGHT"] = {
			["TEXT_PROVIDER"] = {
				[0] = "",
			},
			["TEXT"] = {
				["X_ADJUST"] = 4,
				["USE_MONO"] = false,
				["Y_ADJUST"] = 0,
				["ANCHOR"] = "BOTTOM",
				["USE_OUTLINE"] = true,
				["SCALE"] = 18,
				["COLOR"] = {
					["TG"] = 1,
					["B"] = 0,
					["TB"] = 1,
					["G"] = 0,
					["TR"] = 1,
					["TO"] = 1,
					["useOpacity"] = true,
					["useText"] = true,
					["useBackground"] = true,
					["O"] = 1,
					["R"] = 0,
				},
				["USE_SHADOW"] = false,
				["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			},
		},
		["THREAT_BAR"] = {
			["TEXT_PROVIDER"] = {
				[0] = "",
			},
			["TEXT"] = {
				["X_ADJUST"] = 7,
				["USE_MONO"] = false,
				["Y_ADJUST"] = 2,
				["ANCHOR"] = "RIGHT",
				["USE_OUTLINE"] = false,
				["SCALE"] = 20,
				["COLOR"] = {
					["TG"] = 0,
					["B"] = 0,
					["TB"] = 0,
					["G"] = 0,
					["TR"] = 1,
					["TO"] = 1,
					["useOpacity"] = true,
					["useText"] = true,
					["useBackground"] = true,
					["O"] = 1,
					["R"] = 0,
				},
				["USE_SHADOW"] = true,
				["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			},
		},
		["MANA_BAR"] = {
			["TEXT_PROVIDER"] = {
				[0] = "",
			},
			["TEXT"] = {
				["X_ADJUST"] = 7,
				["USE_MONO"] = false,
				["Y_ADJUST"] = 2,
				["ANCHOR"] = "RIGHT",
				["USE_OUTLINE"] = false,
				["SCALE"] = 20,
				["COLOR"] = {
					["TG"] = 0.55,
					["B"] = 0,
					["TB"] = 1,
					["G"] = 0,
					["TR"] = 0.36,
					["TO"] = 1,
					["useOpacity"] = true,
					["useText"] = true,
					["useBackground"] = true,
					["O"] = 1,
					["R"] = 0,
				},
				["USE_SHADOW"] = true,
				["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			},
		},
		["SIDE_LEFT"] = {
			["TEXT_PROVIDER"] = {
				[0] = "",
			},
			["TEXT"] = {
				["X_ADJUST"] = 3,
				["USE_MONO"] = false,
				["Y_ADJUST"] = 0,
				["ANCHOR"] = "BOTTOM",
				["USE_OUTLINE"] = true,
				["SCALE"] = 18,
				["COLOR"] = {
					["TG"] = 1,
					["B"] = 0,
					["TB"] = 1,
					["G"] = 0,
					["TR"] = 1,
					["TO"] = 1,
					["useOpacity"] = true,
					["useText"] = true,
					["useBackground"] = true,
					["O"] = 1,
					["R"] = 0,
				},
				["USE_SHADOW"] = false,
				["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			},
		},
	},
}
VUHDO_EVENT_TIMES = nil
