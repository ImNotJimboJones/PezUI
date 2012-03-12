
NeedToKnow_Settings = nil
NeedToKnow_CharSettings = {
	["Locked"] = true,
	["Specs"] = {
		"G1", -- [1]
		"G2", -- [2]
	},
	["Profiles"] = {
		["G1"] = {
			["nGroups"] = 4,
			["FontSize"] = 12,
			["BarTexture"] = "Minimalist",
			["BarFont"] = "Friz Quadrata TT",
			["name"] = "Pezzer-Burning Blade.1",
			["BkgdColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.54, -- [4]
			},
			["Groups"] = {
				{
					["Enabled"] = true,
					["NumberBars"] = 1,
					["Position"] = {
						"TOPLEFT", -- [1]
						"BOTTOMLEFT", -- [2]
						659.9999, -- [3]
						252.0001, -- [4]
					},
					["Scale"] = 1,
					["Bars"] = {
						{
							["buffcd_duration"] = 0,
							["BuffOrDebuff"] = "HARMFUL",
							["append_usable"] = false,
							["show_time"] = true,
							["AuraName"] = "Serpent Sting",
							["Unit"] = "target",
							["blink_label"] = "Serpent String",
							["OnlyMine"] = true,
							["vct_enabled"] = false,
							["show_spark"] = true,
							["show_text_user"] = "",
							["show_icon"] = true,
							["Enabled"] = true,
							["blink_boss"] = false,
							["show_all_stacks"] = false,
							["BarColor"] = {
								["a"] = 1,
								["b"] = 0.102,
								["g"] = 0.6,
								["r"] = 0.0784,
							},
							["append_cd"] = true,
							["bDetectExtends"] = false,
							["buffcd_reset_spells"] = "",
							["blink_ooc"] = false,
							["TimeFormat"] = "Fmt_SingleUnit",
							["show_mypip"] = false,
							["vct_color"] = {
								["a"] = 0.3,
								["b"] = 0,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["MissingBlink"] = {
								["a"] = 0.5,
								["b"] = 0.102,
								["g"] = 0.102,
								["r"] = 0.902,
							},
							["show_count"] = true,
							["usable_duration"] = 0,
							["blink_enabled"] = true,
							["show_text"] = true,
							["vct_extra"] = 0,
							["vct_spell"] = "",
						}, -- [1]
					},
					["FixedDuration"] = 0,
					["Width"] = 233.2998,
				}, -- [1]
				{
					["Enabled"] = false,
					["NumberBars"] = 3,
					["Position"] = {
						"TOPLEFT", -- [1]
						"TOPLEFT", -- [2]
						100, -- [3]
						-100, -- [4]
					},
					["Scale"] = 1,
					["Bars"] = {
						{
							["buffcd_duration"] = 0,
							["append_usable"] = false,
							["BuffOrDebuff"] = "HELPFUL",
							["show_time"] = true,
							["AuraName"] = "",
							["Unit"] = "player",
							["blink_label"] = "",
							["OnlyMine"] = true,
							["vct_enabled"] = false,
							["blink_enabled"] = false,
							["show_text_user"] = "",
							["show_icon"] = false,
							["show_all_stacks"] = false,
							["blink_boss"] = false,
							["Enabled"] = true,
							["append_cd"] = true,
							["show_count"] = true,
							["bDetectExtends"] = false,
							["buffcd_reset_spells"] = "",
							["blink_ooc"] = true,
							["TimeFormat"] = "Fmt_SingleUnit",
							["show_mypip"] = false,
							["vct_color"] = {
								["a"] = 0.3,
								["b"] = 0,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["MissingBlink"] = {
								["a"] = 0.5,
								["b"] = 0.1,
								["g"] = 0.1,
								["r"] = 0.9,
							},
							["BarColor"] = {
								["a"] = 1,
								["b"] = 0.6,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["usable_duration"] = 0,
							["show_spark"] = true,
							["show_text"] = true,
							["vct_extra"] = 0,
							["vct_spell"] = "",
						}, -- [1]
						{
							["buffcd_duration"] = 0,
							["append_usable"] = false,
							["BuffOrDebuff"] = "HELPFUL",
							["show_time"] = true,
							["AuraName"] = "",
							["Unit"] = "player",
							["blink_label"] = "",
							["OnlyMine"] = true,
							["vct_enabled"] = false,
							["blink_enabled"] = false,
							["show_text_user"] = "",
							["show_icon"] = false,
							["show_all_stacks"] = false,
							["blink_boss"] = false,
							["Enabled"] = true,
							["append_cd"] = true,
							["show_count"] = true,
							["bDetectExtends"] = false,
							["buffcd_reset_spells"] = "",
							["blink_ooc"] = true,
							["TimeFormat"] = "Fmt_SingleUnit",
							["show_mypip"] = false,
							["vct_color"] = {
								["a"] = 0.3,
								["b"] = 0,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["MissingBlink"] = {
								["a"] = 0.5,
								["b"] = 0.1,
								["g"] = 0.1,
								["r"] = 0.9,
							},
							["BarColor"] = {
								["a"] = 1,
								["b"] = 0.6,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["usable_duration"] = 0,
							["show_spark"] = true,
							["show_text"] = true,
							["vct_extra"] = 0,
							["vct_spell"] = "",
						}, -- [2]
						{
							["buffcd_duration"] = 0,
							["append_usable"] = false,
							["BuffOrDebuff"] = "HELPFUL",
							["show_time"] = true,
							["AuraName"] = "",
							["Unit"] = "player",
							["blink_label"] = "",
							["OnlyMine"] = true,
							["vct_enabled"] = false,
							["blink_enabled"] = false,
							["show_text_user"] = "",
							["show_icon"] = false,
							["show_all_stacks"] = false,
							["blink_boss"] = false,
							["Enabled"] = true,
							["append_cd"] = true,
							["show_count"] = true,
							["bDetectExtends"] = false,
							["buffcd_reset_spells"] = "",
							["blink_ooc"] = true,
							["TimeFormat"] = "Fmt_SingleUnit",
							["show_mypip"] = false,
							["vct_color"] = {
								["a"] = 0.3,
								["b"] = 0,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["MissingBlink"] = {
								["a"] = 0.5,
								["b"] = 0.1,
								["g"] = 0.1,
								["r"] = 0.9,
							},
							["BarColor"] = {
								["a"] = 1,
								["b"] = 0.6,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["usable_duration"] = 0,
							["show_spark"] = true,
							["show_text"] = true,
							["vct_extra"] = 0,
							["vct_spell"] = "",
						}, -- [3]
					},
					["FixedDuration"] = 0,
					["Width"] = 270,
				}, -- [2]
				{
					["Enabled"] = false,
					["NumberBars"] = 3,
					["Position"] = {
						"TOPLEFT", -- [1]
						"TOPLEFT", -- [2]
						100, -- [3]
						-100, -- [4]
					},
					["Scale"] = 1,
					["Bars"] = {
						{
							["buffcd_duration"] = 0,
							["append_usable"] = false,
							["BuffOrDebuff"] = "HELPFUL",
							["show_time"] = true,
							["AuraName"] = "",
							["Unit"] = "player",
							["blink_label"] = "",
							["OnlyMine"] = true,
							["vct_enabled"] = false,
							["blink_enabled"] = false,
							["show_text_user"] = "",
							["show_icon"] = false,
							["show_all_stacks"] = false,
							["blink_boss"] = false,
							["Enabled"] = true,
							["append_cd"] = true,
							["show_count"] = true,
							["bDetectExtends"] = false,
							["buffcd_reset_spells"] = "",
							["blink_ooc"] = true,
							["TimeFormat"] = "Fmt_SingleUnit",
							["show_mypip"] = false,
							["vct_color"] = {
								["a"] = 0.3,
								["b"] = 0,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["MissingBlink"] = {
								["a"] = 0.5,
								["b"] = 0.1,
								["g"] = 0.1,
								["r"] = 0.9,
							},
							["BarColor"] = {
								["a"] = 1,
								["b"] = 0.6,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["usable_duration"] = 0,
							["show_spark"] = true,
							["show_text"] = true,
							["vct_extra"] = 0,
							["vct_spell"] = "",
						}, -- [1]
						{
							["buffcd_duration"] = 0,
							["append_usable"] = false,
							["BuffOrDebuff"] = "HELPFUL",
							["show_time"] = true,
							["AuraName"] = "",
							["Unit"] = "player",
							["blink_label"] = "",
							["OnlyMine"] = true,
							["vct_enabled"] = false,
							["blink_enabled"] = false,
							["show_text_user"] = "",
							["show_icon"] = false,
							["show_all_stacks"] = false,
							["blink_boss"] = false,
							["Enabled"] = true,
							["append_cd"] = true,
							["show_count"] = true,
							["bDetectExtends"] = false,
							["buffcd_reset_spells"] = "",
							["blink_ooc"] = true,
							["TimeFormat"] = "Fmt_SingleUnit",
							["show_mypip"] = false,
							["vct_color"] = {
								["a"] = 0.3,
								["b"] = 0,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["MissingBlink"] = {
								["a"] = 0.5,
								["b"] = 0.1,
								["g"] = 0.1,
								["r"] = 0.9,
							},
							["BarColor"] = {
								["a"] = 1,
								["b"] = 0.6,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["usable_duration"] = 0,
							["show_spark"] = true,
							["show_text"] = true,
							["vct_extra"] = 0,
							["vct_spell"] = "",
						}, -- [2]
						{
							["buffcd_duration"] = 0,
							["append_usable"] = false,
							["BuffOrDebuff"] = "HELPFUL",
							["show_time"] = true,
							["AuraName"] = "",
							["Unit"] = "player",
							["blink_label"] = "",
							["OnlyMine"] = true,
							["vct_enabled"] = false,
							["blink_enabled"] = false,
							["show_text_user"] = "",
							["show_icon"] = false,
							["show_all_stacks"] = false,
							["blink_boss"] = false,
							["Enabled"] = true,
							["append_cd"] = true,
							["show_count"] = true,
							["bDetectExtends"] = false,
							["buffcd_reset_spells"] = "",
							["blink_ooc"] = true,
							["TimeFormat"] = "Fmt_SingleUnit",
							["show_mypip"] = false,
							["vct_color"] = {
								["a"] = 0.3,
								["b"] = 0,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["MissingBlink"] = {
								["a"] = 0.5,
								["b"] = 0.1,
								["g"] = 0.1,
								["r"] = 0.9,
							},
							["BarColor"] = {
								["a"] = 1,
								["b"] = 0.6,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["usable_duration"] = 0,
							["show_spark"] = true,
							["show_text"] = true,
							["vct_extra"] = 0,
							["vct_spell"] = "",
						}, -- [3]
					},
					["FixedDuration"] = 0,
					["Width"] = 270,
				}, -- [3]
				{
					["Enabled"] = false,
					["NumberBars"] = 3,
					["Position"] = {
						"TOPLEFT", -- [1]
						"TOPLEFT", -- [2]
						100, -- [3]
						-100, -- [4]
					},
					["Scale"] = 1,
					["Bars"] = {
						{
							["buffcd_duration"] = 0,
							["append_usable"] = false,
							["BuffOrDebuff"] = "HELPFUL",
							["show_time"] = true,
							["AuraName"] = "",
							["Unit"] = "player",
							["blink_label"] = "",
							["OnlyMine"] = true,
							["vct_enabled"] = false,
							["blink_enabled"] = false,
							["show_text_user"] = "",
							["show_icon"] = false,
							["show_all_stacks"] = false,
							["blink_boss"] = false,
							["Enabled"] = true,
							["append_cd"] = true,
							["show_count"] = true,
							["bDetectExtends"] = false,
							["buffcd_reset_spells"] = "",
							["blink_ooc"] = true,
							["TimeFormat"] = "Fmt_SingleUnit",
							["show_mypip"] = false,
							["vct_color"] = {
								["a"] = 0.3,
								["b"] = 0,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["MissingBlink"] = {
								["a"] = 0.5,
								["b"] = 0.1,
								["g"] = 0.1,
								["r"] = 0.9,
							},
							["BarColor"] = {
								["a"] = 1,
								["b"] = 0.6,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["usable_duration"] = 0,
							["show_spark"] = true,
							["show_text"] = true,
							["vct_extra"] = 0,
							["vct_spell"] = "",
						}, -- [1]
						{
							["buffcd_duration"] = 0,
							["append_usable"] = false,
							["BuffOrDebuff"] = "HELPFUL",
							["show_time"] = true,
							["AuraName"] = "",
							["Unit"] = "player",
							["blink_label"] = "",
							["OnlyMine"] = true,
							["vct_enabled"] = false,
							["blink_enabled"] = false,
							["show_text_user"] = "",
							["show_icon"] = false,
							["show_all_stacks"] = false,
							["blink_boss"] = false,
							["Enabled"] = true,
							["append_cd"] = true,
							["show_count"] = true,
							["bDetectExtends"] = false,
							["buffcd_reset_spells"] = "",
							["blink_ooc"] = true,
							["TimeFormat"] = "Fmt_SingleUnit",
							["show_mypip"] = false,
							["vct_color"] = {
								["a"] = 0.3,
								["b"] = 0,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["MissingBlink"] = {
								["a"] = 0.5,
								["b"] = 0.1,
								["g"] = 0.1,
								["r"] = 0.9,
							},
							["BarColor"] = {
								["a"] = 1,
								["b"] = 0.6,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["usable_duration"] = 0,
							["show_spark"] = true,
							["show_text"] = true,
							["vct_extra"] = 0,
							["vct_spell"] = "",
						}, -- [2]
						{
							["buffcd_duration"] = 0,
							["append_usable"] = false,
							["BuffOrDebuff"] = "HELPFUL",
							["show_time"] = true,
							["AuraName"] = "",
							["Unit"] = "player",
							["blink_label"] = "",
							["OnlyMine"] = true,
							["vct_enabled"] = false,
							["blink_enabled"] = false,
							["show_text_user"] = "",
							["show_icon"] = false,
							["show_all_stacks"] = false,
							["blink_boss"] = false,
							["Enabled"] = true,
							["append_cd"] = true,
							["show_count"] = true,
							["bDetectExtends"] = false,
							["buffcd_reset_spells"] = "",
							["blink_ooc"] = true,
							["TimeFormat"] = "Fmt_SingleUnit",
							["show_mypip"] = false,
							["vct_color"] = {
								["a"] = 0.3,
								["b"] = 0,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["MissingBlink"] = {
								["a"] = 0.5,
								["b"] = 0.1,
								["g"] = 0.1,
								["r"] = 0.9,
							},
							["BarColor"] = {
								["a"] = 1,
								["b"] = 0.6,
								["g"] = 0.6,
								["r"] = 0.6,
							},
							["usable_duration"] = 0,
							["show_spark"] = true,
							["show_text"] = true,
							["vct_extra"] = 0,
							["vct_spell"] = "",
						}, -- [3]
					},
					["FixedDuration"] = 0,
					["Width"] = 270,
				}, -- [4]
			},
			["BarPadding"] = 2.131,
			["BarSpacing"] = 3,
			["bUncompressed"] = true,
		},
		["G2"] = {
			["nGroups"] = 4,
			["name"] = "Pezzer-Burning Blade.2",
			["BkgdColor"] = {
				nil, -- [1]
				nil, -- [2]
				nil, -- [3]
				0.54, -- [4]
			},
			["BarTexture"] = "Minimalist",
			["BarPadding"] = 2.131,
			["Groups"] = {
				{
					["NumberBars"] = 1,
					["Position"] = {
						"CENTER", -- [1]
						"CENTER", -- [2]
						-87.86369999999999, -- [3]
						-186.2607, -- [4]
					},
					["Scale"] = 1.2222,
					["Bars"] = {
						{
							["blink_enabled"] = true,
							["blink_boss"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["blink_ooc"] = false,
							["AuraName"] = "Serpent Sting",
							["Unit"] = "target",
							["blink_label"] = "Serpent Sting",
							["show_icon"] = true,
							["BarColor"] = {
								["b"] = 0.1255,
								["g"] = 0.6706,
								["r"] = 0.1059,
							},
							["show_count"] = false,
						}, -- [1]
					},
					["Width"] = 191.0725,
				}, -- [1]
				{
					["Enabled"] = false,
					["Position"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						-300, -- [4]
					},
				}, -- [2]
				{
					["Enabled"] = false,
					["Position"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						-400, -- [4]
					},
				}, -- [3]
				{
					["Enabled"] = false,
					["Position"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						-500, -- [4]
					},
				}, -- [4]
			},
		},
	},
}
