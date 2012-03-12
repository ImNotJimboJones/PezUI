if( GetLocale() == "zhCN" ) then

	--Trinket Items
	KHT_ADWT = "上古德莱尼作战咒符";
	KHT_ATOS = "迅捷之灰舌符咒";
	KHT_BERSERK_CALL = "狂暴者的召唤";
	KHT_BLADEFIST = "刃拳的宽容";
	KHT_BLOODLUST = "嗜血胸针";
	KHT_ARKELOS = "阿尔凯洛斯之核";
	KHT_DARK_MAD = "暗月卡片：疯狂";
	KHT_DARK_WRATH = "暗月卡片：怒火";
	KHT_DEVIL_EYE = "魔暴龙眼";
	KHT_DST = "龙脊奖章";
--	KHT_EMPTY_MUG = "Empty Mug of Direbrew";
	KHT_HOURGLASS = "分解者的沙漏";
	KHT_MOTB = "背叛者的疯狂";
	KHT_OGRE = "食人魔殴斗者的徽章";
	KHT_SKY_CROSS = "天空卫队银十字勋章";
	KHT_TALON_ALAR = "奥之爪";
	KHT_TTP = "泰罗卡精准石板";
	KHT_TSUNAMI_TALISMAN = "海啸护符";
	KHT_UNITING = "联合护符";
	KHT_HERO_MEDALLION = "赞达拉英雄勋章";

	--Pet Abilities
--	KHT_PET_INTIM = "Pet "..GetSpellInfo(19577);					-- Pet Intimidation
	
	--Traps
	KHT_TRAP = "陷阱";
--	KHT_VENOMOUS = "Venomous Snake";
	KHT_AURA = "光环";
	KHT_PRIMED = "效果";

	--Stings
	KHT_STING = "钉刺";
	KHT_WYVERN_TEXT = GetSpellInfo(19386).."(沉睡)";

	--Other
	KHT_DONE = "完成";

	--Status Text---------------------------------------
	KHT_ON = "on";
	KHT_OFF = "off";
	--Slash Text
	KHT_SLASH_HELP = {
		[1] = "Kharthus's Hunter Timers "..KHT_VERSION,
		[2] = "命令: /kht",
		[3] = "/kht "..KHT_ON.."/"..KHT_OFF,
		[4] = "/kht menu (显示配置菜单)命令: ",
		[5] = "/kht reset (重设计时条位置)",
		[6] = "/kht resetpos (重设计时条框位置)",
		[7] = "/kht delay <time> (time单位为微秒)",
		[8] = "/kht flash <timeleft> (倒计时在<timeleft>秒时闪烁计时条, 0 为关闭)",
		[9] = "/kht step <step> (<step>为闪烁频率)",
		[10] = "/kht barcolor r g b (设定计时条颜色. r, g, b 取值范围: 0 - 1)",
		[11] = "/kht barendcolor r g b (设定计时末尾颜色. r, g, b 取值范围: 0 - 1)",
		[12] = "/kht setbgcolor r g b a (设定背景颜色. r, g, b, a 取值范围: 0 - 10)",
		[13] = "/kht colorchange on/off (开/关自动变换颜色)",
		[14] = "/kht up/down (向上/下移动计时条)",
		[15] = "/kht scale % (缩放比例. /kht scale 100 = 100% 比例)",
		[16] = "/kht lock/unlock (锁定/解锁计时条位置)",
		[17] = "/kht status",
		[18] = "/kht clear all (resets all options to defaults)",
		[19] = "/kht debug (debug info for testing purposes)"
	};
	KHT_STATUS_STRINGS = {
		[1] = "|cFFFFFF00Kharthus's Hunter Timers "..KHT_VERSION.."|r",
		[2] = "|cFFFFFF00状态:|r %s",
		[3] = "|cFFFFFF00射击延时:|r %dms",
		[4] = "|cFFFFFF00闪烁时间:|r %ds |cFFFFFF00频率:|r %f",
		[5] = "|cFFFFFF00计时条颜色:|r %s |cFFFFFF00计时末尾颜色:|r %s",
		[6] = "|cFFFFFF00颜色变换:|r %s |cFFFFFF00增长:|r %s",
		[7] = "|cFFFFFF00缩放比例:|r %d%%"
	};

	KHT_OPTIONS_COLOR_CHANGE = "自动变换颜色";
	KHT_OPTIONS_MILI = "ms";
	KHT_OPTIONS_LOCK = "锁定计时条";
	KHT_OPTIONS_BAR_DIST = "计时条间隔";
	KHT_OPTIONS_SCALE = "缩放比例";
	KHT_OPTIONS_FLASH = "闪烁时间";
	KHT_OPTIONS_STEP = "闪烁频率";
	KHT_OPTIONS_BARSTART = "计时起始颜色";
	KHT_OPTIONS_BAREND = "计时结尾颜色";
	KHT_OPTIONS_BACKDROP = "背景颜色";
	KHT_OPTIONS_TIMERS_TEXT = "计时器";
	KHT_OPTIONS_BARS_TEXT = "计时条";
	KHT_OPTIONS_DECIMALS = "小数位";
	KHT_OPTIONS_SHOT_DELAY = "射击延时";
	KHT_OPTIONS_SHOW_TEX = "显示图标";
	KHT_OPTIONS_LARGE_TEX = "大图标";
	KHT_OPTIONS_APPEND = "显示作用目标";
	KHT_OPTIONS_BORDER = "边框颜色";
	KHT_OPTIONS_TEXT_COLOR = "文本颜色";
	KHT_OPTIONS_TIME_COLOR = "时间颜色";
	KHT_OPTIONS_TARGET_COLOR = "目标文本颜色";
	KHT_OPTIONS_OVERALL_OPACITY = "透明度";
	KHT_OPTIONS_HIDE_TEXT = "隐藏文本";
	KHT_OPTIONS_HIDE_TIME = "隐藏时间";
	KHT_OPTIONS_HIDE_GAP = "隐藏间隙";
	KHT_OPTIONS_BAR_THICKNESS = "计时条粗细";
	KHT_OPTIONS_HIDE_PADDING = "隐藏内边框";
	KHT_OPTIONS_STICKY = "自动射击";
--	KHT_OPTIONS_DOWN = "Cascade Bars Down";

	--Options moved to globals because they dealt with other variables

end
