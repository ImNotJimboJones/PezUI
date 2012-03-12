
MacaroonButtonDefaults = {
	["config"] = {
		["cooldownAlpha"] = 1,
		["auracolor1"] = "0;0.82;0;1",
		["macroColor"] = "1;1;1;1",
		["copyDrag"] = true,
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
		["Priest"] = {
			["Renew"] = {
				"/cast [@mouseover, exists, help, nodead] [] Renew;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Renew", -- [3]
				"Cast \"Renew\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Power Infusion"] = {
				"/cast [@mouseover, exists, help, nodead] [] Power Infusion;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Power Infusion", -- [3]
				"Cast \"Power Infusion\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Cure Disease"] = {
				"/cast [@mouseover, exists, nodead] [] Cure Disease;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Cure Disease", -- [3]
				"Cast \"Cure Disease\" on mouseover; default cast if no mouseover\n", -- [4]
				false, -- [5]
			},
			["Mana Burn"] = {
				"/cast [@mouseover, exists, harm, nodead] [] Mana Burn;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Mana Burn", -- [3]
				"Cast \"Mana Burn\" on enemy mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Binding Heal"] = {
				"#show Binding Heal\n#showtooltip Binding Heal\n/cast [@mouseover, exists, help, nodead] [@target, exists] Binding Heal;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Binding Heal", -- [3]
				"Cast \"Binding Heal\" on friendly mouseover; target cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Prayer of Mending"] = {
				"/cast [@mouseover, exists, help, nodead] [] Prayer of Mending;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Prayer of Mending", -- [3]
				"Cast \"PoM\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["MO Pain Suppression"] = {
				"/cast [@mouseover, exists, help, nodead] [] Pain Suppression;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Pain Suppression", -- [3]
				"Cast \"Heal\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["PW: Shield"] = {
				"/cast [@mouseover, exists, help, nodead] [] Power Word: Shield;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"PW: Shield", -- [3]
				"Cast \"PW: Shield\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Holy Fire"] = {
				"/cast [@mouseover, exists, harm, nodead] [] Holy Fire;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Holy Fire", -- [3]
				"Cast \"Holy Fire\" on enemy mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Levitate"] = {
				"/cast [@mouseover, exists, help, nodead] [] Levitate;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Levitate", -- [3]
				"Cast \"Levitate\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Flash Heal"] = {
				"/cast [@mouseover, exists, help, nodead] [] Flash Heal;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Flash Heal", -- [3]
				"Cast \"Flash Heal\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Prayer of Healing"] = {
				"/cast [@mouseover, exists, help, nodead] [] Prayer of Healing;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Prayer of Healing", -- [3]
				"Cast \"PoH\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Resurrection"] = {
				"/cast [@mouseover, exists, help, nodead] [] Resurrection;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Resurrection", -- [3]
				"Cast \"Resurrection\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Heal"] = {
				"/cast [@mouseover, exists, help, nodead] [] Heal;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Heal", -- [3]
				"Cast \"Heal\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Penance"] = {
				"/cast [@mouseover, exists, nodead] [] Penance;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Penance", -- [3]
				"Cast \"Penance\" on mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Smite"] = {
				"/cast [@mouseover, exists, harm, nodead] [] Smite;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Smite", -- [3]
				"Cast \"Smite\" on enemy mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Dispel Magic"] = {
				"/cast [@mouseover, exists, help, nodead] [] Dispel Magic;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Dispel Magic", -- [3]
				"Cast \"Cure Disease\" on mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Greater Heal"] = {
				"/cast [@mouseover, exists, help, nodead] [] Greater Heal;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Greater Heal", -- [3]
				"Cast \"Greater Heal\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Fear Ward"] = {
				"/cast [@mouseover, exists, help, nodead] [] Fear Ward;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Fear Ward", -- [3]
				"Cast \"Fear Ward\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Shackle Undead"] = {
				"/cast [@mouseover, exists, harm, nodead] [] Shackle Undead;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Shackle Undead", -- [3]
				"Cast \"Shackle Undead\" on enemy mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
		},
	},
	["Burning Blade"] = {
		["Lélu"] = {
			["Macros: Button 15"] = {
				"/cast [@mouseover, exists, harm, nodead] [] Holy Fire;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Holy Fire", -- [3]
				"Cast \"Holy Fire\" on enemy mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 2"] = {
				"/cast [@mouseover, exists, help, nodead] [] Greater Heal;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Greater Heal", -- [3]
				"Cast \"Greater Heal\" on mouseover. If no mouseover, default cast", -- [4]
				false, -- [5]
			},
			["Macros: Button 8"] = {
				"/cast [@mouseover, exists, help, nodead] [] Pain Suppression;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Pain Suppression", -- [3]
				"Cast \"Heal\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 4"] = {
				"/cast [@mouseover, exists, help, nodead] [] Dispel Magic;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Dispel Magic", -- [3]
				"Cast \"Dispel Magic\" on mouseover. If no mouseover, default cast", -- [4]
				false, -- [5]
			},
			["Macros: Button 11"] = {
				"/cast [@mouseover, exists, help, nodead] [] Power Word: Shield;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"PW: Shield", -- [3]
				"Cast \"PW: Shield\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 3"] = {
				"/cast [@mouseover, exists, help, nodead] [] Flash Heal;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Flash Heal", -- [3]
				"Cast \"Flash Heal\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 20"] = {
				"/cast [@mouseover, exists, harm, nodead] [] Smite;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Smite", -- [3]
				"Cast \"Smite\" on enemy mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 5"] = {
				"/cast [@mouseover, exists, nodead] [] Cure Disease;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Cure Disease", -- [3]
				"Cast \"Cure Disease\" on mouseover. If no mouseover, default cast", -- [4]
				false, -- [5]
			},
			["Macros: Button 10"] = {
				"/cast [@mouseover, exists, help, nodead] [] Power Infusion;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Power Infusion", -- [3]
				"Cast \"Power Infusion\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 1"] = {
				"/cast [@mouseover, exists, help, nodead] [] Heal;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Heal", -- [3]
				"Cast \"Heal\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 18"] = {
				"/cast [@mouseover, exists, help, nodead] [] Renew;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Renew", -- [3]
				"Cast \"Renew\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 12"] = {
				"/cast [@mouseover, exists, harm, nodead] [] Mana Burn;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Mana Burn", -- [3]
				"Cast \"Mana Burn\" on enemy mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 13"] = {
				"/cast [@mouseover, exists, harm, nodead] [] Shackle Undead;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Shackle Undead", -- [3]
				"Cast \"Shackle Undead\" on enemy mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 7"] = {
				"/cast [@mouseover, exists, help, nodead] [] Levitate;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Levitate", -- [3]
				"Cast \"Levitate\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 14"] = {
				"#show Binding Heal\n#showtooltip Binding Heal\n/cast [@mouseover, exists, help, nodead] [@target, exists] Binding Heal;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Binding Heal", -- [3]
				"Cast \"Binding Heal\" on friendly mouseover; target cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 16"] = {
				"/cast [@mouseover, exists, help, nodead] [] Prayer of Healing;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Prayer of Healing", -- [3]
				"Cast \"PoH\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 19"] = {
				"/cast [@mouseover, exists, help, nodead] [] Resurrection;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Resurrection", -- [3]
				"Cast \"Resurrection\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 6"] = {
				"/cast [@mouseover, exists, help, nodead] [] Fear Ward;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Fear Ward", -- [3]
				"Cast \"Fear Ward\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 17"] = {
				"/cast [@mouseover, exists, help, nodead] [] Prayer of Mending;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Prayer of Mending", -- [3]
				"Cast \"PoM\" on friendly mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
			["Macros: Button 9"] = {
				"/cast [@mouseover, exists, nodead] [] Penance;", -- [1]
				"INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK", -- [2]
				"Penance", -- [3]
				"Cast \"Penance\" on mouseover; default cast if no mouseover", -- [4]
				false, -- [5]
			},
		},
		["Pezzer"] = {
		},
	},
}
MacaroonItemCache = {
	["Riding Cloak of the Seer"] = "36403",
	["Voidfire Wand"] = "25939",
	["Coldrock Gauntlets of Intellect"] = "36302",
	["Ice-Bound Plate Belt"] = "33404",
	["Laughing Skull Bracelets of the Eagle"] = "24612",
	["Ancestral Hammer of the Elder"] = "25318",
	["Cracked Iron Staff"] = "33424",
	["Superior Healing Potion"] = "3928",
	["Chilled Meat"] = "43013",
	["Pauldrons of Sufferance"] = "27433",
	["Oculus of the Hidden Eye"] = "26055",
	["Fur Clothing Scraps"] = "43851",
	["Astralaan Robe of the Sorcerer"] = "24647",
	["Thread-Bare Cloth Gloves"] = "33361",
	["Laughing Skull Waistguard of the Eagle"] = "24605",
	["Witching Band"] = "24154",
	["Pungent Seal Whey"] = "33444",
	["Vicious Wand of the Invoker"] = "36657",
	["Suede Cloak of Intellect"] = "36404",
	["Astralaan Pants of Intellect"] = "24650",
	["Greater Mana Potion"] = "6149",
	["Auslese's Light Channeler"] = "24390",
	["Feralfen Hood of the Owl"] = "24633",
	["Howling Wind"] = "24504",
	["Ring of Decimation"] = "38219",
	["Tempest's Touch"] = "29317",
	["Wraps of the San'layn"] = "39676",
	["Councillor's Boots of Frozen Wrath"] = "10095",
	["Hardened Claw"] = "33547",
	["Morning Glory Dew"] = "8766",
	["Placid Lightmace of Spirit"] = "36685",
	["Reinforced Velvet Helm"] = "35572",
	["Bloodspore Robe of the Whale"] = "35965",
	["Super Healing Potion"] = "22829",
	["Caustic Claw"] = "39532",
	["Frostweave Cloth"] = "33470",
	["Netherweave Cloth"] = "21877",
	["Skein Woven Mantle"] = "35580",
	["Sethekk Oracle's Focus"] = "29334",
	["Staff of Polarities"] = "25950",
	["Necklace of Calm Skies"] = "44400",
	["Keleseth's Blade of Evocation"] = "35570",
	["Spirit Shard"] = "28558",
	["Oshu'gun Crystal Powder Sample"] = "26042",
	["Hearthstone"] = "6948",
	["Worg Haunch"] = "43011",
	["Holistic Patchwork Breeches"] = "35577",
	["Vicious Fang"] = "33546",
}
MacaroonLocale = {
	["Macaroon"] = {
	},
	["Current"] = "enUS",
}
