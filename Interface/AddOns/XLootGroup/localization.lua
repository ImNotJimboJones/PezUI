local NAME, addon = ...

local locales = {
	enUS = {
		anchor = "Group Rolls",
		config_panels = {
			options = "Options"
		},
		config_groups = {
			tracking = "Roll Tracking",
			expiration = "Completed roll expiration"
		},
		config = {
			text_outline = "Outline text",
			text_time = "Show time remaining",
			role_icon = "Show role icons",
			win_icon = "Show winning type icon",
			show_undecided = "Show undecided",
			scale = "Scale",
			direction = "Growth direction",
			small = "Small",
			large = "Large",
			short = "Short",
			long = "Long",
			roll_width = "Roll frame width",
			roll_button_size = "Roll button size",
			track_all = "Track all rolls",
			track_player_roll = "Track items you roll on",
			track_by_threshold = "Track items by minimum quality",
			expire_won = "Won rolls",
			expire_lost = "Lost/Passed rolls"
		},
		undecided = "Undecided"
	},
	-- Possibly localized
	ptBR = {},
	frFR = {},
	deDE = {},
	koKR = {},
	esMX = {},
	ruRU = {},
	zhCN = {},
	esES = {},
	zhTW = {},
}

-- Automatically inserted translations
-- See: http://wow.curseforge.com/addons/xlootgroup/localization/ to create or fix translations
locales.ptBR.config = {
}
locales.ptBR.config_panels = {
}

locales.frFR["roll_anchor"] = "Jets de groupe" -- Needs review
locales.frFR["watch_anchor"] = "Suivi des jets" -- Needs review
locales.frFR.config = {
	direction = "Direction d'ajout", -- Needs review
	large = "Large", -- Needs review
	roll_button_size = "Taille des boutons de jet", -- Needs review
	roll_width = "Largeur des cadres de jet", -- Needs review
	scale = "Échelle", -- Needs review
	small = "Petit", -- Needs review
	text_outline = "Texte avec contour", -- Needs review
	track_all = "Suivre tous les jets", -- Needs review
	track_by_threshold = "Suivre les objets selon une qualité min.", -- Needs review
	track_player_roll = "Suivre les objets sur lesquels vous jouez", -- Needs review
}
locales.frFR.config_panels = {
	options = "Options", -- Needs review
}

locales.deDE.config = {
	direction = "Wachstumsrichtung", -- Needs review
	large = "Groß", -- Needs review
	roll_button_size = "Würfelschaltergröße", -- Needs review
	roll_width = "Würfelrahmenbreite", -- Needs review
	scale = "Skalieren", -- Needs review
	small = "Klein", -- Needs review
	text_outline = "Outline Text", -- Needs review
}
locales.deDE.config_panels = {
	options = "Optionen", -- Needs review
}

locales.koKR.config = {
}
locales.koKR.config_panels = {
}

locales.esMX.config = {
}
locales.esMX.config_panels = {
}

locales.ruRU["roll_anchor"] = "Выборы группы"
locales.ruRU["watch_anchor"] = "Отслеживание бросков" -- Needs review
locales.ruRU.config = {
	direction = "Направление роста",
	large = "Большой",
	roll_button_size = "Размер кнопки броска",
	roll_width = "Ширина рамки броска",
	scale = "Масштаб",
	small = "Маленький",
	text_outline = "Контур текста",
	track_all = "Отслеживать все броски",
	track_by_threshold = "Отслеживать предметы по минимальному качеству", -- Needs review
	track_player_roll = "Отслеживать ваши броски",
}
locales.ruRU.config_panels = {
	options = "Настройки",
}

locales.zhCN["roll_anchor"] = "队伍Roll点"
locales.zhCN["watch_anchor"] = "Roll点追踪"
locales.zhCN.config = {
	direction = "增长方向",
	large = "大",
	roll_button_size = "Roll点按钮大小",
	roll_width = "Roll点框体宽度",
	scale = "缩放",
	small = "小",
	text_outline = "文字描边",
	track_all = "追踪所有Roll点",
	track_by_threshold = "按最低品质追踪物品",
	track_player_roll = "追踪你Roll的物品",
}
locales.zhCN.config_panels = {
	options = "选项",
}

locales.esES.config = {
}
locales.esES.config_panels = {
}

locales.zhTW["roll_anchor"] = "隊伍擲骰"
locales.zhTW["watch_anchor"] = "擲骰追蹤"
locales.zhTW.config = {
	direction = "延伸方向",
	large = "大",
	roll_button_size = "擲骰按鈕尺寸",
	roll_width = "擲骰框架寬長",
	scale = "縮放",
	small = "小",
	text_outline = "字體輪廓",
	track_all = "追蹤全部擲骰",
	track_by_threshold = "追蹤物品的最低品質",
	track_player_roll = "追蹤你擲骰的物品",
}
locales.zhTW.config_panels = {
	options = "選項",
}


local L = locales[GetLocale()] and locales[GetLocale()] or locales.enUS
if L ~= locales.enUS then
	setmetatable(L, { __index = locales.enUS })
	for k, v in pairs(L) do	
		if type(v) == 'table' then
			setmetatable(v, { __index = locales.enUS[k] })
		end
	end
end
addon.L = L
