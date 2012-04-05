local NAME, addon = ...

local locales = {
	enUS = {
		config_groups = {
			interaction = "Interaction",
			appearance = "Appearance",
			size = "Size and Transparency",
			general = "General",
		},
		config_panels = {
			options = "Options"
		},
		config = {
			autoloot_coin = "Auto loot coin",
			autoloot_quest = "Auto loot quest items",
			when_never = "Never",
			when_solo = "Solo",
			when_always = "Always",
			when_auto = "Automatic",
			frame_scale = "Frame scale",
			frame_scale_low = "Small",
			frame_scale_high = "Large",
			frame_alpha = "Frame transparency",
			frame_alpha_low = "Transparent",
			frame_alpha_high = "Opaque",
			frame_color_border = "Frame border color",
			frame_color_backdrop = "Frame backdrop color",
			frame_color_gradient = "Frame gradient color",
			frame_width_automatic = "Automatically expand frame",
			frame_width = "Frame width",
			loot_highlight = "Highlight slots on mouseover",
			loot_alpha = "Slot transparency",
			loot_alpha_low = "Transparent",
			loot_alpha_high = "Opaque",
			loot_color_border = "Loot border color",
			loot_color_backdrop = "Loot backdrop color",
			loot_color_gradient = "Loot gradient color",
			loot_color_info = "Information font color",
			loot_collapse = "Collapse looted slots",
			quality_color_frame = "Color frame border by top quality",
			quality_color_loot = "Color loot border by quality",
			loot_texts_info = "Show detailed information",
			loot_texts_bind = "Show loot bind type",
			font_size_loot = "Loot font size",
			font_size_info = "Information font size",
			frame_snap = "Snap frame to mouse",
			frame_snap_offset_x = "Horizontal snap offset",
			frame_snap_offset_y = "Vertical snap offset",
			frame_draggable = "Loot frame draggable",
			linkall_threshold = "Minimum chat link quality",
			linkall_channel = "Default chat link channel",
			linkall_show = "Link button visibility",
			skin = "Skin",
			skin_default = "XLoot: Default",
			skin_legacy = "XLoot: Legacy",
			skin_smooth = "XLoot: Smooth",
		},
		linkall_threshold_missed = "No loot meets your quality threshold",
		button_link = "Link",
		button_close = "Close",
		bind_on_use_short = "BoU",
		bind_on_equip_short = "BoE",
		bind_on_pickup_short = "BoP"
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
-- See: http://wow.curseforge.com/addons/xloot-1-0/localization/ to create or fix translations
locales.ptBR.config = {
}
locales.ptBR.config_groups = {
}
locales.ptBR.config_panels = {
}

locales.frFR["bind_on_equip_short"] = "LqE" -- Needs review
locales.frFR["bind_on_pickup_short"] = "LqR" -- Needs review
locales.frFR["bind_on_use_short"] = "LqU" -- Needs review
locales.frFR["button_close"] = "Fermer" -- Needs review
locales.frFR["button_link"] = "Lien" -- Needs review
locales.frFR["linkall_threshold_missed"] = "Aucun butin ne rencontre votre seuil de qualité" -- Needs review
locales.frFR.config = {
	frame_alpha = "Transparence du cadre", -- Needs review
	frame_alpha_high = "Opaque", -- Needs review
	frame_alpha_low = "Transparent", -- Needs review
	frame_scale = "Échelle du cadre", -- Needs review
	frame_scale_high = "Large", -- Needs review
	frame_scale_low = "Petite", -- Needs review
	frame_width = "Largeur de cadre", -- Needs review
	loot_alpha = "Transparence d'emplacement", -- Needs review
	loot_alpha_high = "Opaque", -- Needs review
	loot_alpha_low = "Transparent", -- Needs review
	skin = "Skin", -- Needs review
	skin_default = "XLoot : défaut", -- Needs review
	skin_legacy = "XLoot : héritage", -- Needs review
}
locales.frFR.config_groups = {
	appearance = "Apparence", -- Needs review
	general = "Général", -- Needs review
	interaction = "Interaction", -- Needs review
	size = "Taille et Transparence", -- Needs review
}
locales.frFR.config_panels = {
	options = "Options", -- Needs review
}

locales.deDE["button_close"] = "Schliessen" -- Needs review
locales.deDE.config = {
	frame_scale_high = "Groß", -- Needs review
	frame_scale_low = "Klein", -- Needs review
}
locales.deDE.config_groups = {
	appearance = "Aussehen", -- Needs review
}
locales.deDE.config_panels = {
}

locales.koKR.config = {
}
locales.koKR.config_groups = {
}
locales.koKR.config_panels = {
}

locales.esMX.config = {
}
locales.esMX.config_groups = {
}
locales.esMX.config_panels = {
}

locales.ruRU["bind_on_equip_short"] = "ПпН" -- Needs review
locales.ruRU["bind_on_pickup_short"] = "ПпП" -- Needs review
locales.ruRU["bind_on_use_short"] = "ПпИ" -- Needs review
locales.ruRU["button_close"] = "Закрыть" -- Needs review
locales.ruRU["button_link"] = "Ссылка" -- Needs review
locales.ruRU["linkall_threshold_missed"] = "Нет добычи соответствующей требованиям качества" -- Needs review
locales.ruRU.config = {
	font_size_info = "Размер шрифта для информации", -- Needs review
	font_size_loot = "Размер шрифта для добычи", -- Needs review
	frame_alpha = "Прозрачность окошка", -- Needs review
	frame_alpha_high = "Непрозрачный", -- Needs review
	frame_alpha_low = "Прозрачный", -- Needs review
	frame_color_backdrop = "Цвет фона окошка", -- Needs review
	frame_color_border = "Цвет рамки окошка", -- Needs review
	frame_color_gradient = "Цвет градиента окошка", -- Needs review
	frame_draggable = "Окошко добычи передвигаемо", -- Needs review
	frame_scale = "Размер окошка", -- Needs review
	frame_scale_high = "Большой", -- Needs review
	frame_scale_low = "Маленький", -- Needs review
	frame_snap = "Привязать окошко к мыши", -- Needs review
	frame_snap_offset_x = "Смещение по горизонтали", -- Needs review
	frame_snap_offset_y = "Смещение по вертикали", -- Needs review
	frame_width = "Ширина окошка", -- Needs review
	frame_width_automatic = "Автоматически расширять окошко", -- Needs review
	linkall_channel = "Чат для отображения по умолчанию", -- Needs review
	linkall_threshold = "Минимальная ссылка в чате", -- Needs review
	loot_alpha = "Прозрачность ячейки", -- Needs review
	loot_alpha_high = "Непрозрачная", -- Needs review
	loot_alpha_low = "Прозрачная", -- Needs review
	loot_collapse = "Свернуть собранные ячейки", -- Needs review
	loot_color_backdrop = "Фоновый цвет для добычи", -- Needs review
	loot_color_border = "Цвет для рамки добычи", -- Needs review
	loot_color_gradient = "Цвет градиента добычи", -- Needs review
	loot_color_info = "Цвет шрифта информации", -- Needs review
	loot_highlight = "Подсвечивать ячейки при наведении мыши", -- Needs review
	loot_texts_bind = "Показывать добычу по типу", -- Needs review
	loot_texts_info = "Показывать подробную информацию", -- Needs review
	quality_color_frame = "Окрашивать рамку окошка по наивысшему качеству", -- Needs review
	quality_color_loot = "Окрашивать рамку добычи по качеству", -- Needs review
	skin = "Шкурка", -- Needs review
	skin_default = "XLoot: Стандарт", -- Needs review
	skin_legacy = "XLoot: Наследие", -- Needs review
}
locales.ruRU.config_groups = {
	appearance = "Внешний вид", -- Needs review
	general = "Главные", -- Needs review
	interaction = "Взаимодействие", -- Needs review
	size = "Размеры и прозрачность", -- Needs review
}
locales.ruRU.config_panels = {
	options = "Настройки", -- Needs review
}

locales.zhCN["bind_on_equip_short"] = "装绑" -- Needs review
locales.zhCN["bind_on_pickup_short"] = "拾绑" -- Needs review
locales.zhCN["bind_on_use_short"] = "用绑" -- Needs review
locales.zhCN["button_close"] = "关闭" -- Needs review
locales.zhCN["button_link"] = "链接" -- Needs review
locales.zhCN["linkall_threshold_missed"] = "所有物品都低于最低品质限制" -- Needs review
locales.zhCN.config = {
	font_size_info = "物品信息字体大小", -- Needs review
	font_size_loot = "物品名称字体大小", -- Needs review
	frame_alpha = "拾取框透明度", -- Needs review
	frame_alpha_high = "不透明",
	frame_alpha_low = "透明",
	frame_color_backdrop = "拾取框背景颜色", -- Needs review
	frame_color_border = "拾取框边框颜色", -- Needs review
	frame_color_gradient = "拾取框渐变颜色", -- Needs review
	frame_draggable = "可拖动更改拾取框位置", -- Needs review
	frame_scale = "拾取框缩放", -- Needs review
	frame_scale_high = "大",
	frame_scale_low = "小",
	frame_snap = "鼠标位置打开拾取框", -- Needs review
	frame_snap_offset_x = "水平偏移", -- Needs review
	frame_snap_offset_y = "垂直偏移", -- Needs review
	frame_width = "拾取框宽度", -- Needs review
	frame_width_automatic = "自动调整拾取框宽度", -- Needs review
	linkall_channel = "默认发送物品链接到频道", -- Needs review
	linkall_threshold = "发送链接的物品品质最低为", -- Needs review
	loot_alpha = "物品单元格透明度", -- Needs review
	loot_alpha_high = "不透明",
	loot_alpha_low = "透明",
	loot_collapse = "重复物品合并显示", -- Needs review
	loot_color_backdrop = "物品单元格背景颜色", -- Needs review
	loot_color_border = "物品单元格边框颜色", -- Needs review
	loot_color_gradient = "物品单元格渐变颜色", -- Needs review
	loot_color_info = "物品信息字体颜色", -- Needs review
	loot_highlight = "高亮鼠标指向的物品", -- Needs review
	loot_texts_bind = "显示物品绑定类型", -- Needs review
	loot_texts_info = "显示物品详细信息(部位/类型等)", -- Needs review
	quality_color_frame = "根据最高物品品质着色拾取框边框", -- Needs review
	quality_color_loot = "根据物品品质着色物品单元格边框", -- Needs review
	skin = "外观",
	skin_default = "XLoot: 默认", -- Needs review
	skin_legacy = "XLoot: 经典", -- Needs review
}
locales.zhCN.config_groups = {
	appearance = "外观",
	general = "常规", -- Needs review
	interaction = "互动",
	size = "大小与透明度",
}
locales.zhCN.config_panels = {
	options = "选项",
}

locales.esES.config = {
}
locales.esES.config_groups = {
}
locales.esES.config_panels = {
}

locales.zhTW["bind_on_equip_short"] = "裝備後綁定"
locales.zhTW["bind_on_pickup_short"] = "拾取後綁定"
locales.zhTW["bind_on_use_short"] = "使用後綁定"
locales.zhTW["button_close"] = "關閉"
locales.zhTW["button_link"] = "連結"
locales.zhTW["linkall_threshold_missed"] = "拾取沒有達到你的品質門檻"
locales.zhTW.config = {
	font_size_info = "訊息字型大小",
	font_size_loot = "拾取字型大小",
	frame_alpha = "框架透明度",
	frame_alpha_high = "不透明",
	frame_alpha_low = "透明",
	frame_color_backdrop = "框架背景顏色",
	frame_color_border = "框架邊框顏色",
	frame_color_gradient = "框架傾斜顏色",
	frame_draggable = "可移動拾取框架",
	frame_scale = "框架縮放",
	frame_scale_high = "大",
	frame_scale_low = "小",
	frame_snap = "依附至鼠標",
	frame_snap_offset_x = "依附水平偏移",
	frame_snap_offset_y = "依附垂直偏移",
	frame_width = "框架寬度",
	frame_width_automatic = "自動延伸框架",
	linkall_channel = "預設廣播頻道",
	linkall_threshold = "可連結到頻道的最低品質",
	loot_alpha = "格子透明度",
	loot_alpha_high = "不透明",
	loot_alpha_low = "透明",
	loot_collapse = "折疊拾取格子",
	loot_color_backdrop = "拾取框背景顏色",
	loot_color_border = "拾取框邊框顏色",
	loot_color_gradient = "拾取框傾斜顏色",
	loot_color_info = "細節訊息顏色",
	loot_highlight = "高亮在滑鼠懸停",
	loot_texts_bind = "顯示拾取綁定類型",
	loot_texts_info = "顯示細節訊息",
	quality_color_frame = "以最高品質上色框架",
	quality_color_loot = "以品質上色拾取框架",
	skin = "外觀",
	skin_default = "XLoot: 預設",
	skin_legacy = "XLoot: 傳統",
}
locales.zhTW.config_groups = {
	appearance = "外觀",
	general = "一般",
	interaction = "互動",
	size = "大小與透明度",
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
