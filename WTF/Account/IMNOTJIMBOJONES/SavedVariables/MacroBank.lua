
MacroBankDB = {
	["profileKeys"] = {
		["Xëthra - Burning Blade"] = "Default",
		["Lélu - Burning Blade"] = "Default",
		["Pezzer - Burning Blade"] = "Default",
	},
	["DBVersion"] = 5,
	["global"] = {
		["Macros"] = {
			{
				"Encounters", -- [1]
				{
					{
						"Target Left Foot", -- [1]
						"Left Foot", -- [2]
						"INV_BOOTS_CLOTH_31", -- [3]
						"/tar Left Foot\n", -- [4]
					}, -- [1]
					{
						"Target Right Foot", -- [1]
						"Right Foot", -- [2]
						"INV_BOOTS_CLOTH_31V2", -- [3]
						"/tar Right Foot\n", -- [4]
					}, -- [2]
					{
						"Tranq Shambling Horror", -- [1]
						"Shambling Horror", -- [2]
						"INV_MISC_QUESTIONMARK", -- [3]
						"#show\n/tar Shambling Horror\n/cast Tranquilizing Shot\n", -- [4]
					}, -- [3]
				}, -- [2]
			}, -- [1]
			{
				"Fun", -- [1]
				{
					{
						"Strip", -- [1]
						"Strip", -- [2]
						"SPELL_MISC_EMOTIONHAPPY", -- [3]
						"\n/run function f(x) PickupInventoryItem(x) PutItemInBackpack() end;\n/run if GetContainerNumFreeSlots(0) >= 11 then f(1) f(3) f(4) f(5) f(6) f(7) f(8) f(9) f(10) f(15) f(19) else print('Not enough bag space to strip') end;\n/dance", -- [4]
					}, -- [1]
				}, -- [2]
			}, -- [2]
			{
				"General", -- [1]
				{
					{
						"Exra Action Button", -- [1]
						"Exra Action", -- [2]
						"SPELL_FROST_FROSTWARD", -- [3]
						"/click ExtraActionButton1\n", -- [4]
					}, -- [1]
					{
						"Shoot !", -- [1]
						"Shoot", -- [2]
						"INV_MISC_QUESTIONMARK", -- [3]
						"/cast !Shoot", -- [4]
					}, -- [2]
					{
						"Target/Assist Focus", -- [1]
						"Assist Focus", -- [2]
						"ABILITY_HUNTER_MARKEDFORDEATH", -- [3]
						"/target [target=focus, harm, nodead]\n/target [target=focustarget, harm, nodead]\n/startattack", -- [4]
					}, -- [3]
					{
						"Trinket (Both)", -- [1]
						"Trinket (Both)", -- [2]
						"INV_MISC_QUESTIONMARK", -- [3]
						"#show\n#showtooltip\n/run UIErrorsFrame:Hide();\n/console Sound_EnableSFX 0\n/use 13\n/use 14\n/console Sound_EnableSFX 1\n/run UIErrorsFrame:Clear();\n/run UIErrorsFrame:Show();\n", -- [4]
					}, -- [4]
					{
						"Trinket (Bottom)", -- [1]
						"Trinket (Bottom)", -- [2]
						"INV_MISC_QUESTIONMARK", -- [3]
						"#show\n#showtooltip\n/use 14\n", -- [4]
					}, -- [5]
					{
						"Trinket (Top)", -- [1]
						"Trinket (Top)", -- [2]
						"INV_MISC_QUESTIONMARK", -- [3]
						"#show\n#showtooltip\n/use 13\n", -- [4]
					}, -- [6]
				}, -- [2]
			}, -- [3]
			{
				"Hunter", -- [1]
				{
					{
						"Kill Shot w/ stopcast", -- [1]
						"Kill Shot", -- [2]
						"INV_MISC_QUESTIONMARK", -- [3]
						"#show\n#showtooltip\n/stopcasting\n/stopcasting\n/stopcasting\n/cast Kill Shot", -- [4]
					}, -- [1]
					{
						"Pet Assist", -- [1]
						"Pet Assist", -- [2]
						"ABILITY_DRUID_CHALLANGINGROAR", -- [3]
						"/petattack [@focus, exists, harm, nodead] [@focustarget, exists, harm, nodead]\n", -- [4]
					}, -- [2]
					{
						"RC + Wing Clip", -- [1]
						"RC+WC", -- [2]
						"INV_MISC_QUESTIONMARK", -- [3]
						"#show Wing Clip\n#showtooltip Wing Clip\n/cast Raptor Strike\n/cast Wing Clip\n/stopcasting", -- [4]
					}, -- [3]
					{
						"Silence Focus", -- [1]
						"Silence Focus", -- [2]
						"INV_MISC_QUESTIONMARK", -- [3]
						"#show Silencing Shot\n#showtooltip Silencing Shot\n/stopcasting\n/stopcasting\n/stopcasting\n/cast [@focus, exists, harm, nodead] [@focustarget, exists, harm, nodead] Silencing Shot", -- [4]
					}, -- [4]
				}, -- [2]
			}, -- [4]
		},
	},
	["profiles"] = {
		["Default"] = {
		},
	},
}
