local NAME, addon = ...

local locales = {
	enUS = {
		anchor = "Group Rolls",
		alert_anchor = "Loot Popups",
		config_panels = {
			options = "Options"
		},
		config_groups = {
			tracking = "Roll Tracking",
			expiration = "Completed roll expiration",
			tooltip = "Tooltip",
			alerts = "Loot popups (Requires reload)",
		},
		config = {
			text_outline = "Outline text",
			text_time = "Show time remaining",
			anchor_pretty = "Pretty anchors",
			role_icon = "Show role icons",
			win_icon = "Show winning type icon",
			show_decided = "Show decided",
			show_undecided = "Show undecided",
			alert_skin = "Apply skin",
			alert_offset = "Vertical spacing",
			alpha = "Transparency",
			alpha_low = "Transparent",
			alpha_high = "Opaque",
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
locales.frFR["undecided"] = "Non décidé" -- Needs review
locales.frFR["watch_anchor"] = "Suivi des jets" -- Needs review
locales.frFR.config = {
	direction = "Direction d'ajout", -- Needs review
	expire_lost = "Jets perdus/ignorés", -- Needs review
	expire_won = "Jets gagnés", -- Needs review
	large = "Large", -- Needs review
	long = "Long", -- Needs review
	roll_button_size = "Taille des boutons de jet", -- Needs review
	roll_width = "Largeur des cadres de jet", -- Needs review
	scale = "Échelle", -- Needs review
	short = "Court", -- Needs review
	show_undecided = "Afficher les non décidés", -- Needs review
	small = "Petit", -- Needs review
	text_outline = "Texte avec contour", -- Needs review
	text_time = "Afficher temps restant", -- Needs review
	track_all = "Suivre tous les jets", -- Needs review
	track_by_threshold = "Suivre les objets selon une qualité min.", -- Needs review
	track_player_roll = "Suivre les objets sur lesquels vous jouez", -- Needs review
}
locales.frFR.config_panels = {
	expiration = "Expiration des jets terminés", -- Needs review
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
locales.zhCN["undecided"] = "未ROLL" -- Needs review
locales.zhCN["watch_anchor"] = "Roll点追踪"
locales.zhCN.config = {
	direction = "增长方向",
	expire_lost = "失败/放弃 的ROLL点", -- Needs review
	expire_won = "胜利的ROLL点", -- Needs review
	large = "大",
	long = "长", -- Needs review
	roll_button_size = "Roll点按钮大小",
	roll_width = "Roll点框体宽度",
	scale = "缩放",
	short = "短", -- Needs review
	show_undecided = "显示未ROLL", -- Needs review
	small = "小",
	text_outline = "文字描边",
	text_time = "显示剩余时间", -- Needs review
	track_all = "追踪所有Roll点",
	track_by_threshold = "按最低品质追踪物品",
	track_player_roll = "追踪你Roll的物品",
	win_icon = "显示胜利类型图标", -- Needs review
}
locales.zhCN.config_panels = {
	expiration = "ROLL点时间结束", -- Needs review
	options = "选项",
}

locales.esES.config = {
}
locales.esES.config_panels = {
}

locales.zhTW["roll_anchor"] = "隊伍擲骰"
locales.zhTW["undecided"] = "未決的"
locales.zhTW["watch_anchor"] = "擲骰追蹤"
locales.zhTW.config = {
	direction = "延伸方向",
	expire_lost = "輸/放棄 擲骰",
	expire_won = "贏得擲骰",
	large = "大",
	long = "長",
	roll_button_size = "擲骰按鈕尺寸",
	roll_width = "擲骰框架寬長",
	scale = "縮放",
	short = "短",
	show_undecided = "顯示未決的",
	small = "小",
	text_outline = "字體輪廓",
	text_time = "顯示剩餘時間",
	track_all = "追蹤全部擲骰",
	track_by_threshold = "追蹤物品的最低品質",
	track_player_roll = "追蹤你擲骰的物品",
	win_icon = "顯示獲勝類型的圖標",
}
locales.zhTW.config_panels = {
	expiration = "已完成擲骰的顯示時間",
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
