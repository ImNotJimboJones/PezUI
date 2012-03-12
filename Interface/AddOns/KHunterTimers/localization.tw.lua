if( GetLocale() == "zhTW" ) then

	--Trinket Items
	KHT_ADWT = "遠古德萊尼戰爭咒符";
	KHT_ATOS = "灰舌迅捷咒符";
	KHT_BERSERK_CALL = "狂戰士的吶喊";
	KHT_BLADEFIST = "刃拳飾物";
	KHT_BLOODLUST = "嗜血胸針";
	KHT_ARKELOS = "阿其羅斯核心";
	KHT_DARK_MAD = "暗月卡:瘋狂";
	KHT_DARK_WRATH = "暗月卡:狂怒";
	KHT_DEVIL_EYE = "魔暴龍眼";
	KHT_DST = "龍脊戰利品";
	KHT_EMPTY_MUG = "空的恐酒酒杯";
	KHT_HOURGLASS = "破壞者沙漏";
	KHT_MOTB = "背叛者的狂熱";
	KHT_OGRE = "巨魔槌兵徽�";
	KHT_SKY_CROSS = "禦天者銀十字徽�";
	KHT_TALON_ALAR = "歐爾之爪";
	KHT_TTP = "泰洛卡精密石板";
	KHT_TSUNAMI_TALISMAN = "海嘯咒符";
	KHT_UNITING = "聯合符咒";
	KHT_HERO_MEDALLION = "贊達拉英雄勳�";

	--Pet Abilities
--	KHT_PET_INTIM = "Pet "..GetSpellInfo(19577);					-- Pet Intimidation
	
	--Traps
	KHT_TRAP = "陷阱";
--	KHT_VENOMOUS = "Venomous Snake";
	KHT_AURA = "光環";
	KHT_PRIMED = "效果";

	--Stings
	KHT_STING = "釘刺";
	KHT_WYVERN_TEXT = GetSpellInfo(19386).."(沉睡)";

	--Other
	KHT_DONE = "完成!";

	--Status Text---------------------------------------
	KHT_ON = "on";
	KHT_OFF = "off";
	--Slash Text
	KHT_SLASH_HELP = {
		[1] = "Kharthus's Hunter Timers "..KHT_VERSION,
		[2] = "命令: /kht",
		[3] = "/kht "..KHT_ON.."/"..KHT_OFF,
		[4] = "/kht menu (顯示設置目錄)命令: ",
		[5] = "/kht reset (重設計時條位置)",
		[6] = "/kht resetpos (重設計時條框位置)",
		[7] = "/kht delay <time> (time單位為微秒)",
		[8] =  "/kht flash <timeleft> (倒計時在<timeleft>秒時閃爍計時條, 0 為關閉)",
		[9] =  "/kht step <step> (<step>為閃爍頻率)",
		[10] = "/kht barcolor r g b (設定計時條顏色. r, g, b 取值範圍: 0 - 1)",
		[11] = "/kht barendcolor r g b (設定計時末尾顏色. r, g, b 取值範圍: 0 - 1)",
		[12] = "/kht setbgcolor r g b a (設定背景顏色. r, g, b, a 取值範圍: 0 - 10)",
		[13] = "/kht colorchange on/off (開/關自動變換顏色)",
		[14] = "/kht up/down (向上/下移動計時條)",
		[15] = "/kht scale % (縮放比例. /kht scale 100 = 100% 比例)",
		[16] = "/kht lock/unlock (鎖定/解鎖計時條位置)",
		[17] = "/kht status",
		[18] = "/kht clear all (resets all options to defaults)",
		[19] = "/kht debug (debug info for testing purposes)"
	};
	KHT_STATUS_STRINGS = {
		[1] = "|cFFFFFF00Kharthus's Hunter Timers "..KHT_VERSION.."|r",
		[2] = "|cFFFFFF00狀態:|r %s",
		[3] = "|cFFFFFF00射擊延時:|r %dms",
		[4] = "|cFFFFFF00閃爍時間:|r %ds |cFFFFFF00頻率:|r %f",
		[5] = "|cFFFFFF00計時條顏色:|r %s |cFFFFFF00計時末尾顏色:|r %s",
		[6] = "|cFFFFFF00顏色變換:|r %s |cFFFFFF00增長:|r %s",
		[7] = "|cFFFFFF00縮放比例:|r %d%%"
	};

	KHT_OPTIONS_COLOR_CHANGE = "自動變換顏色";
	KHT_OPTIONS_MILI = "ms";
	KHT_OPTIONS_LOCK = "鎖定計時條";
	KHT_OPTIONS_BAR_DIST = "計時條間隔";
	KHT_OPTIONS_SCALE = "縮放比例";
	KHT_OPTIONS_FLASH = "閃爍時間";
	KHT_OPTIONS_STEP = "閃爍頻率";
	KHT_OPTIONS_BARSTART = "計時起始顏色";
	KHT_OPTIONS_BAREND = "計時結尾顏色";
	KHT_OPTIONS_BACKDROP = "背景顏色";
	KHT_OPTIONS_TIMER_TEXT = "計時器";
	KHT_OPTIONS_BARS_TEXT = "計時條";
	KHT_OPTIONS_DECIMALS = "小數位";
	KHT_OPTIONS_SHOT_DELAY = "射擊延時";
	KHT_OPTIONS_SHOW_TEX = "顯示圖示";
	KHT_OPTIONS_LARGE_TEX = "大圖示";
	KHT_OPTIONS_APPEND = "顯示作用目標";
	KHT_OPTIONS_BORDER = "邊框顏色";
	KHT_OPTIONS_TEXT_COLOR = "文本顏色";
	KHT_OPTIONS_TIME_COLOR = "時間顏色";
	KHT_OPTIONS_TARGET_COLOR = "目標文字顏色";
	KHT_OPTIONS_OVERALL_OPACITY = "透明度";
	KHT_OPTIONS_HIDE_TEXT = "隱藏文字";
	KHT_OPTIONS_HIDE_TIME = "隱藏時間";
	KHT_OPTIONS_HIDE_GAP = "隱藏間隙";
	KHT_OPTIONS_BAR_THICKNESS = "計時條粗細";
	KHT_OPTIONS_HIDE_PADDING = "隱藏內邊框";
	KHT_OPTIONS_STICKY = "依附自動射擊";
--	KHT_OPTIONS_DOWN = "Cascade Bars Down";

	--Options moved to globals because they dealt with other variables

end
