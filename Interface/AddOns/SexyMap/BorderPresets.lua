
local _, addon = ...
addon.borderPresets = {
	["Blue Rune Circles"] = {
		borders = {
			{
				["r"] = 0.3098039215686275,
				["name"] = "Rune 1",
				["scale"] = 1.4,
				["rotSpeed"] = -30,
				["g"] = 0.4784313725490196,
				["texture"] = "SPELLS\\AURARUNE256.BLP",
			},
			{
				["a"] = 0.3799999952316284,
				["r"] = 0.196078431372549,
				["rotSpeed"] = 60,
				["scale"] = 2.1,
				["name"] = "Rune 2",
				["g"] = 0.2901960784313725,
				["texture"] = "SPELLS\\AuraRune_A.blp",
			},
			{
				["a"] = 0.3,
				["name"] = "Fade",
				["scale"] = 1.6,
				["r"] = 0,
				["g"] = 0.2235294117647059,
				["texture"] = "SPELLS\\T_VFX_HERO_CIRCLE.BLP",
			},
		},
		shape = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga"
	},
	["Diablo by Zork"] = {
		borders = {
			{
				["name"] = "Ring",
				["scale"] = 1.45,
				["rotation"] = 225,
				["texture"] = "INTERFACE\\ADDONS\\SEXYMAP\\MEDIA\\MAP_OVERLAY.TGA",
				["blendMode"] = "BLEND",
				["width"] = 364,
				["height"] = 182,
			},
			{
				["name"] = "Gloss",
				["scale"] = 0.84,
				["disableRotation"] = true,
				["texture"] = "INTERFACE\\ADDONS\\SEXYMAP\\MEDIA\\MAP_GLOSS.TGA",
				["r"] = 0.9,
				["g"] = 0.95,
			},
			{
				["name"] = "Inner Shadow",
				["scale"] = 0.84,
				["disableRotation"] = true,
				["texture"] = "INTERFACE\\ADDONS\\SEXYMAP\\MEDIA\\MAP_INNERSHADOW.TGA",
				["blendMode"] = "BLEND",
				["drawLayer"] = "OVERLAY",
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			{
				["name"] = "Cogwheel",
				["scale"] = 1.37,
				["rotSpeed"] = 60,
				["blendMode"] = "BLEND",
				["texture"] = "INTERFACE\\ADDONS\\SEXYMAP\\MEDIA\\ZAHNRAD.TGA",
				["drawLayer"] = "BACKGROUND",
				["r"] = 0.18823529411765,
				["g"] = 0.17254901960784,
				["b"] = 0.13725490196078,
				["a"] = 0.95,
			},
		},
		shape = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga"
	},
	["Faded Square by Renaitre"] = {
		["borders"] = {
			{
				["r"] = 0,
				["scale"] = 1.47,
				["g"] = 0,
				["rotation"] = 225,
				["blendMode"] = "BLEND",
				["name"] = "RenaitreFadeBorder",
				["b"] = 0,
				["texture"] = "Interface\\Addons\\SexyMap\\media\\RenaitreFadeBorder",
			},
			{
				["scale"] = 1.47,
				["g"] = 0,
				["rotation"] = 225,
				["name"] = "RenaitreFadeNormal",
				["drawLayer"] = "HIGHLIGHT",
				["blendMode"] = "BLEND",
				["r"] = 0.4235294117647059,
				["texture"] = "Interface\\Addons\\SexyMap\\media\\RenaitreFadeNormal",
			},
			{
				["drawLayer"] = "OVERLAY",
				["name"] = "RenaitreFadeGloss",
				["scale"] = 1.48,
				["rotation"] = 225,
				["texture"] = "Interface\\Addons\\SexyMap\\media\\RenaitreFadeGloss",
			},
		},
		["shape"] = "Interface\\BUTTONS\\WHITE8X8",
	},
	["Electric"] = {
		["borders"] = {
				{
					["hNudge"] = -38,
					["scale"] = 0.42,
					["vNudge"] = 40,
					["rotation"] = 180,
					["name"] = "LightningNW",
					["texture"] = "Spells\\lightning_new.blp",
				},
				{
					["hNudge"] = 36,
					["scale"] = 0.42,
					["vNudge"] = 40,
					["rotation"] = 270,
					["name"] = "LightningNE",
					["texture"] = "Spells\\lightning_new.blp",
				},
				{
					["rotation"] = 90,
					["hNudge"] = -38,
					["name"] = "LightningSW",
					["scale"] = 0.42,
					["vNudge"] = -35,
					["texture"] = "Spells\\lightning_new.blp",
				},
				{
					["hNudge"] = 36,
					["scale"] = 0.42,
					["vNudge"] = -35,
					["name"] = "LightningSE",
					["texture"] = "Spells\\lightning_new.blp",
				},
		},
		["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\diamond",
	},
	["Space by Ruka"] = {
		["borders"] = {
			{
				["a"] = 0.5600000023841858,
				["rotSpeed"] = -20,
				["scale"] = 1.6,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Galaxy",
				["texture"] = "environments\\stars\\deepholmsky_nebula01.blp",
			},
			{
				["a"] = 0.7800000011920929,
				["hNudge"] = -45,
				["rotSpeed"] = 5,
				["scale"] = 1.2,
				["vNudge"] = 65,
				["name"] = "Star",
				["blendMode"] = "BLEND",
				["texture"] = "environments\\stars\\galaxy_02.blp",
			},
			{
				["a"] = 0.6400000154972076,
				["hNudge"] = -45,
				["rotSpeed"] = 5,
				["scale"] = 0.3,
				["vNudge"] = -65,
				["blendMode"] = "BLEND",
				["name"] = "Planet 1",
				["texture"] = "environments\\stars\\hellfireplanet_blue01.blp",
			},
			{
				["hNudge"] = -80,
				["rotSpeed"] = 15,
				["scale"] = 0.3,
				["blendMode"] = "BLEND",
				["name"] = "Planet 2",
				["texture"] = "environments\\stars\\hellfireplanet_red01.blp",
			},
			{
				["a"] = 0.9200000017881393,
				["hNudge"] = 80,
				["rotSpeed"] = 10,
				["scale"] = 0.3,
				["blendMode"] = "BLEND",
				["rotation"] = 179,
				["name"] = "Planet 3",
				["texture"] = "environments\\stars\\bladesedgeplanet04.blp",
			},
			{
				["a"] = 0.75,
				["hNudge"] = 45,
				["rotSpeed"] = 15,
				["scale"] = 0.4,
				["vNudge"] = -65,
				["name"] = "Vortex",
				["texture"] = "environments\\stars\\deathsky_vortexcloud01",
			},
			{
				["hNudge"] = 45,
				["rotSpeed"] = 10,
				["scale"] = 0.3,
				["vNudge"] = 65,
				["rotation"] = 0,
				["name"] = "Planet 4",
				["texture"] = "environments\\stars\\hellfireplanet03.blp",
			},
		},
		["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\largecircle",
	},
	["Blue Rune Diamond"] = {
		borders = {
			{
				["scale"] = 1.62,
				["g"] = 0.3450980392156863,
				["name"] = "Rune",
				["drawLayer"] = "BACKGROUND",
				["r"] = 0,
				["texture"] = "SPELLS\\AuraRune256b.blp",
			},
			{
				["a"] = 0.06999999284744263,
				["r"] = 0.3294117647058824,
				["scale"] = 2.1,
				["g"] = 0.5333333333333333,
				["name"] = "Inner Circle",
				["disableRotation"] = true,
				["texture"] = "Interface\\GLUES\\MODELS\\UI_Tauren\\gradientCircle.blp",
			},
		},
		shape = "Interface\\AddOns\\SexyMap\\shapes\\diamond"
	},
	["Burning Sun"] = {
		borders = {
			{
				["b"] = 0.04313725490196078,
				["name"] = "Main",
				["scale"] = 1.82,
				["rotSpeed"] = 21,
				["g"] = 0.2901960784313725,
				["texture"] = "PARTICLES\\GENERICGLOW5.BLP",
			},
			{
				["b"] = 0.3529411764705882,
				["name"] = "Second",
				["scale"] = 1.62,
				["rotSpeed"] = -18,
				["g"] = 0.8705882352941177,
				["texture"] = "PARTICLES\\GENERICGLOW5.BLP",
			},
			{
				["a"] = 0.449999988079071,
				["name"] = "Tint",
				["b"] = 0.3254901960784314,
				["scale"] = 1.35,
				["g"] = 0.6705882352941176,
				["texture"] = "SPELLS\\T_VFX_HERO_CIRCLE.BLP",
			},
		},
		shape = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga"
	},
	["Jewels"] = {
		borders = {
			{
				["b"] = 0.7058823529411764,
				["scale"] = 0.8800000000000001,
				["g"] = 0.6392156862745098,
				["disableRotation"] = true,
				["name"] = "Square",
				["blendMode"] = "BLEND",
				["drawLayer"] = "BACKGROUND",
				["r"] = 0.615686274509804,
				["texture"] = "TILESET\\EXPANSION01\\EVERSONG\\SwathSmallStones.blp",
			},
			{
				["rotSpeed"] = 118,
				["r"] = 0.6823529411764706,
				["scale"] = 0.8800000000000001,
				["g"] = 0.8666666666666667,
				["disableRotation"] = true,
				["name"] = "Square Glow",
				["rotation"] = 66,
				["drawLayer"] = "BORDER",
				["texture"] = "Interface\\Minimap\\Ping\\ping5.blp",
			},
		},
		shape = "SPELLS\\T_VFX_BORDER"
	},
	["Blue Square Glow"] = {
		borders = {
			{
				["rotSpeed"] = 10,
				["r"] = 0.3411764705882353,
				["scale"] = 0.73,
				["g"] = 0.4705882352941176,
				["disableRotation"] = true,
				["name"] = "Square Overlay",
				["rotation"] = 66,
				["texture"] = "World\\GENERIC\\ACTIVEDOODADS\\WORLDTREEPORTALS\\TWISTEDNETHER8.BLP",
			},
			{
				["rotSpeed"] = -14,
				["scale"] = 1.9,
				["g"] = 0.7215686274509804,
				["disableRotation"] = true,
				["name"] = "Circle 2",
				["drawLayer"] = "BACKGROUND",
				["r"] = 0.3607843137254902,
				["texture"] = "World\\GENERIC\\ACTIVEDOODADS\\INSTANCEPORTAL\\GENERICGLOW2.BLP",
			},
		},
		shape = "Interface\\BUTTONS\\WHITE8X8"
	},
	["Rustic"] = {
		["borders"] = {
		},
		["backdrop"] = {
			["show"] = true,
			["textureColor"] = {
				["r"] = 1,
				["g"] = 0.9215686274509803,
				["b"] = 0.6627450980392157,
			},
			["settings"] = {
				["edgeSize"] = 28,
				["edgeFile"] = "Interface\\LFGFrame\\LFGBorder.blp",
				["tile"] = false,
				["bgFile"] = "World\\EXPANSION02\\DOODADS\\Ulduar\\UL_SpinningRoomRings_Ring07.blp",
				["insets"] = {
					["top"] = 9,
					["right"] = 9,
					["left"] = 9,
					["bottom"] = 9,
				},
			},
			["borderColor"] = {
				["g"] = 0.7607843137254902,
				["b"] = 0.7176470588235294,
			},
			["scale"] = 1.25,
		},
		["shape"] = "SPELLS\\T_VFX_BORDER",
	},
	Parchment = {
		borders = {
			{
				["scale"] = 0.8200000000000001,
				["disableRotation"] = true,
				["blendMode"] = "BLEND",
				["drawLayer"] = "BACKGROUND",
				["name"] = "Parchment",
				["texture"] = "Interface\\AchievementFrame\\UI-Achievement-Parchment.blp",
			},
			{
				["a"] = 0.3799999952316284,
				["r"] = 0.2,
				["scale"] = 0.9000000000000001,
				["g"] = 0.09803921568627451,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Tint",
				["blendMode"] = "BLEND",
				["b"] = 0,
				["texture"] = "Interface\\BUTTONS\\WHITE8X8.BLP",
			},
			{
				["disableRotation"] = true,
				["r"] = 0.6313725490196078,
				["name"] = "Parchment 2",
				["b"] = 0.6313725490196078,
				["scale"] = 0.8200000000000001,
				["g"] = 0.6313725490196078,
				["texture"] = "Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal.blp",
			},
		},
		shape = "SPELLS\\T_VFX_BORDER"
	},
	["Stargate"] = {
		["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga",
		["borders"] = {
			{
				["scale"] = 1.4,
				["g"] = 0.6862745098039216,
				["name"] = "Rune 1",
				["r"] = 0.5764705882352941,
				["texture"] = "SPELLS\\AURARUNE256.BLP",
			},
			{
				["a"] = 0.3799999952316284,
				["g"] = 0.6588235294117647,
				["rotation"] = 105,
				["name"] = "Rune 2",
				["scale"] = 2.05,
				["r"] = 0.2823529411764706,
				["texture"] = "SPELLS\\AuraRune_A.blp",
			},
			{
				["a"] = 0.3,
				["name"] = "Fade",
				["scale"] = 1.6,
				["r"] = 0,
				["g"] = 0.2235294117647059,
				["texture"] = "SPELLS\\T_VFX_HERO_CIRCLE.BLP",
			},
			{
				["rotSpeed"] = -120,
				["name"] = "Rune 3",
				["b"] = 0.3529411764705882,
				["scale"] = 1.65,
				["r"] = 0.1137254901960784,
				["g"] = 0.1686274509803922,
				["texture"] = "SPELLS\\AuraRune_B.blp",
			},
		},
	},
	["Simple Square"] = {
		["borders"] = {
		},
		["backdrop"] = {
			["show"] = true,
			["textureColor"] = {
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["settings"] = {
				["edgeSize"] = 17,
				["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
				["tile"] = false,
				["insets"] = {
					["top"] = 4,
					["right"] = 4,
					["left"] = 4,
					["bottom"] = 4,
				},
			},
			["borderColor"] = {
			},
			["scale"] = 1.07,
		},
		["shape"] = "Interface\\BUTTONS\\WHITE8X8",
	},
	["Rogue"] = {
		["borders"] = {
			{
				["rotSpeed"] = -32,
				["name"] = "Rogue Rune 2",
				["b"] = 0,
				["scale"] = 2.13,
				["r"] = 0.1450980392156863,
				["g"] = 0.00392156862745098,
				["texture"] = "SPELLS\\RogueRune2.blp",
			},
			{
				["r"] = 0.6,
				["scale"] = 0.8900000000000001,
				["g"] = 0.2078431372549019,
				["disableRotation"] = true,
				["name"] = "Glow",
				["b"] = 0.09411764705882353,
				["texture"] = "SPELLS\\White-Circle.blp",
			},
		},
		["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga",
	},
	["Ruins"] = {
		["borders"] = {
		},
		["backdrop"] = {
			["show"] = true,
			["textureColor"] = {
				["b"] = 1,
				["g"] = 1,
				["r"] = 1,
			},
			["settings"] = {
				["bgFile"] = "World\\ENVIRONMENT\\DOODAD\\STRANGLETHORN\\TROLLRUINS\\TEX\\GARY\\GP_SNKNTMP_ATARBORDER.blp",
				["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border.blp",
				["tile"] = false,
				["edgeSize"] = 23,
				["insets"] = {
					["top"] = 5,
					["right"] = 5,
					["left"] = 5,
					["bottom"] = 5,
				},
			},
			["borderColor"] = {
				["b"] = 0.7254901960784314,
				["g"] = 0.8627450980392157,
			},
			["scale"] = 1.42,
		},
		["shape"] = "SPELLS\\T_VFX_BORDER",
	},
	["Wood Framed"] = {
		["borders"] = {
		},
		["backdrop"] = {
			["show"] = true,
			["textureColor"] = {
				["b"] = 1,
				["g"] = 1,
				["r"] = 1,
			},
			["settings"] = {
				["bgFile"] = "Interface\\AchievementFrame\\UI-Achievement-StatsBackground.blp",
				["edgeFile"] = "Interface\\AchievementFrame\\UI-Achievement-WoodBorder.blp",
				["tile"] = false,
				["edgeSize"] = 28,
				["insets"] = {
					["top"] = 4,
					["right"] = 4,
					["left"] = 4,
					["bottom"] = 4,
				},
			},
			["borderColor"] = {
				["b"] = 0.7254901960784314,
				["g"] = 0.8627450980392157,
			},
			["scale"] = 1.17,
		},
		["shape"] = "SPELLS\\T_VFX_BORDER",
	},
	["Emerald Portal by Korryna"] = {
		["borders"] = {
			{
				["hNudge"] = 2,
				["rotSpeed"] = 80,
				["r"] = 0,
				["scale"] = 1.17,
				["g"] = 0.4745098039215686,
				["vNudge"] = -1,
				["name"] = "Moss Ring CW",
				["b"] = 0.01568627450980392,
				["texture"] = "XTEXTURES\\splash\\splash.blp",
			},
			{
				["scale"] = 1.6,
				["g"] = 0.9725490196078431,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Outer Glow",
				["b"] = 0.3490196078431372,
				["texture"] = "Textures\\moonglare.blp",
			},
			{
				["a"] = 0.09000003337860107,
				["name"] = "Map Glow",
				["b"] = 0.4431372549019608,
				["scale"] = 1.07,
				["r"] = 0.807843137254902,
				["texture"] = "Textures\\Moon02Glare.blp",
			},
			{
				["a"] = 0.7199999988079071,
				["hNudge"] = 41,
				["rotSpeed"] = 6,
				["scale"] = 1.22,
				["g"] = 0.8705882352941177,
				["vNudge"] = 38,
				["drawLayer"] = "OVERLAY",
				["rotation"] = 45,
				["disableRotation"] = false,
				["r"] = 0.1725490196078431,
				["name"] = "Glare UR",
				["texture"] = "SPELLS\\AURA_01.blp",
			},
			{
				["a"] = 0.2599999904632568,
				["hNudge"] = -57,
				["rotSpeed"] = -60,
				["b"] = 0.05098039215686274,
				["scale"] = 0.8400000000000001,
				["g"] = 0.4156862745098039,
				["vNudge"] = 32,
				["r"] = 0,
				["name"] = "Nature Rune UL",
				["texture"] = "SPELLS\\Nature_Rune_128.blp",
			},
			{
				["a"] = 0.1800000071525574,
				["hNudge"] = 39,
				["rotSpeed"] = 60,
				["b"] = 0.1176470588235294,
				["scale"] = 0.8700000000000001,
				["g"] = 0.4313725490196079,
				["vNudge"] = -45,
				["name"] = "Nature Rune LR",
				["r"] = 0.4823529411764706,
				["texture"] = "SPELLS\\Nature_Rune_128.blp",
			},
			{
				["a"] = 0.1200000047683716,
				["hNudge"] = 53,
				["rotSpeed"] = 60,
				["b"] = 0.7764705882352941,
				["scale"] = 0.78,
				["vNudge"] = 39,
				["name"] = "Nature Rune UR",
				["r"] = 0.2941176470588235,
				["texture"] = "SPELLS\\Nature_Rune_128.blp",
			},
			{
				["a"] = 0.09000003337860107,
				["hNudge"] = -48,
				["rotSpeed"] = -60,
				["b"] = 0.4352941176470588,
				["scale"] = 0.8500000000000001,
				["vNudge"] = -45,
				["name"] = "Nature Rune LL",
				["r"] = 0.7607843137254902,
				["texture"] = "SPELLS\\Nature_Rune_128.blp",
			},
			{
				["a"] = 0.14000004529953,
				["rotSpeed"] = -20,
				["name"] = "Nature Rune Large CCW",
				["b"] = 0.07450980392156863,
				["scale"] = 1.81,
				["r"] = 0.09019607843137255,
				["g"] = 0.3372549019607843,
				["texture"] = "SPELLS\\Nature_Rune_128.blp",
			},
			{
				["a"] = 0.6599999964237213,
				["rotSpeed"] = -300,
				["b"] = 0.01568627450980392,
				["scale"] = 1.45,
				["g"] = 0.4666666666666667,
				["drawLayer"] = "BACKGROUND",
				["blendMode"] = "BLEND",
				["r"] = 0,
				["name"] = "Edge Shimmer CCW",
				["texture"] = "SPELLS\\SHOCKWAVE_INVERTGREY.BLP",
			},
			{
				["a"] = 0.5800000131130219,
				["rotSpeed"] = 240,
				["b"] = 0.06666666666666667,
				["scale"] = 1.46,
				["g"] = 0.3098039215686275,
				["drawLayer"] = "BORDER",
				["name"] = "Edge Shimmer CW",
				["r"] = 0.02352941176470588,
				["texture"] = "SPELLS\\SHOCKWAVE_INVERTGREY.BLP",
			},
			{
				["a"] = 0.5,
				["scale"] = 1.58,
				["rotation"] = 231,
				["blendMode"] = "BLEND",
				["drawLayer"] = "BACKGROUND",
				["name"] = "Background Leaves",
				["texture"] = "SPELLS\\TREANTLEAVES.BLP",
			},
		},
		["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga",
	},
	["Shamanism by Jaygoody"] = {
		["borders"] = {
			{
				["hNudge"] = 65,
				["scale"] = 0.4,
				["vNudge"] = 65,
				["disableRotation"] = true,
				["name"] = "Rune Earth",
				["texture"] = "World\\GENERIC\\PASSIVEDOODADS\\ShamanStone\\SHAMANSTONEEARTH.blp",
			},
			{
				["disableRotation"] = true,
				["hNudge"] = -65,
				["name"] = "Rune Air",
				["scale"] = 0.35,
				["texture"] = "World\\GENERIC\\PASSIVEDOODADS\\ShamanStone\\ShamanStoneAir.blp",
				["vNudge"] = -65,
			},
			{
				["hNudge"] = 65,
				["scale"] = 0.35,
				["g"] = 0.984313725490196,
				["vNudge"] = -65,
				["disableRotation"] = true,
				["name"] = "Rune Water",
				["r"] = 0.4392156862745098,
				["texture"] = "World\\GENERIC\\PASSIVEDOODADS\\ShamanStone\\ShamanStoneWater.blp",
			},
			{
				["hNudge"] = -65,
				["scale"] = 0.35,
				["vNudge"] = 65,
				["disableRotation"] = true,
				["name"] = "Rune Fire",
				["texture"] = "World\\GENERIC\\PASSIVEDOODADS\\ShamanStone\\ShamanStoneFlame.blp",
			},
			{
				["rotSpeed"] = 60,
				["scale"] = 1.79,
				["drawLayer"] = "BORDER",
				["name"] = "Outer Rings",
				["disableRotation"] = false,
				["rotation"] = 184,
				["texture"] = "SPELLS\\Shockwave4.blp",
			},
			{
				["a"] = 0.75,
				["rotSpeed"] = 40,
				["scale"] = 1.12,
				["g"] = 0.5568627450980392,
				["drawLayer"] = "BORDER",
				["name"] = "Outer Glow",
				["disableRotation"] = true,
				["r"] = 0,
				["texture"] = "World\\ENVIRONMENT\\DOODAD\\GENERALDOODADS\\ELEMENTALRIFTS\\Shockwave_blue.blp",
			},
			{
				["a"] = 0.3700000047683716,
				["name"] = "Edge Radiance",
				["rotSpeed"] = -300,
				["b"] = 0,
				["scale"] = 1.49,
				["g"] = 0.6313725490196078,
				["texture"] = "SPELLS\\SHOCKWAVE_INVERTGREY.BLP",
			},
			{
				["a"] = 0.5,
				["hNudge"] = -65,
				["b"] = 0,
				["g"] = 0.2313725490196079,
				["vNudge"] = 65,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Glow Fire",
				["disableRotation"] = true,
				["texture"] = "SPELLS\\GENERICGLOW64.BLP",
			},
			{
				["a"] = 0.4700000286102295,
				["hNudge"] = -65,
				["b"] = 0.9333333333333334,
				["scale"] = 1.11,
				["g"] = 0,
				["vNudge"] = -65,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Glow Air",
				["disableRotation"] = false,
				["texture"] = "SPELLS\\GENERICGLOW64.BLP",
			},
			{
				["a"] = 0.5100000202655792,
				["hNudge"] = 65,
				["r"] = 0,
				["scale"] = 1.11,
				["g"] = 0.04705882352941176,
				["vNudge"] = -65,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Glow Water",
				["texture"] = "SPELLS\\GENERICGLOW64.BLP",
			},
			{
				["a"] = 0.4000000357627869,
				["hNudge"] = 65,
				["b"] = 0,
				["scale"] = 1.1,
				["vNudge"] = 65,
				["drawLayer"] = "BACKGROUND",
				["name"] = "Glow Earth",
				["r"] = 0.2588235294117647,
				["texture"] = "SPELLS\\GENERICGLOW64.BLP",
			},
		},
		["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga",
	},
}

