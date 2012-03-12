if( GetLocale() == "ruRU" ) then

	--Trinket Items
	KHT_ADWT = "Древний дренейский военный талисман";
	KHT_ATOS = "Талисман Быстроты пеплоуста";
	KHT_BERSERK_CALL = "Зов берсерка";
	KHT_BLADEFIST = "Кристалл Острорука";
	KHT_BLOODLUST = "Брошь Кровожадности";
	KHT_ARKELOS = "Сердцевина Ар'келоса";
	KHT_DARK_MAD = "Карта Новолуния: Безумие";
	KHT_DARK_WRATH = "Карта Новолуния: Гнев";
	KHT_DEVIL_EYE = "Глаз девизавра";
	KHT_DST = "Трофей из драконьего хребта";
	KHT_EMPTY_MUG = "Пустая кружка Худовара";
	KHT_HOURGLASS = "Песочные часы Расплетающего";
	KHT_MOTB = "Безумие Предателя";
	KHT_OGRE = "Знак Мучителя огров";
	KHT_SKY_CROSS = "Серебряный Крест Стража Небес";
	KHT_TALON_ALAR = "Коготь Ала'ра";
	KHT_TTP = "Табличка меткости Террокара";
	KHT_TSUNAMI_TALISMAN = "Талисман Цунами";
	KHT_UNITING = "Объединяющий оберег";
	KHT_HERO_MEDALLION = "Геройский медальон зандаларов";

	--Pet Abilities
	KHT_PET_INTIM = GetSpellInfo(19577).." Пита";

	--Traps
	KHT_TRAP = "ловушка";
	KHT_VENOMOUS = "Ядовитая змея";
	KHT_AURA = "дух";
--	KHT_PRIMED = "primed";

	--Stings
	KHT_STING = "Жало";
	KHT_WYVERN_TEXT = GetSpellInfo(19386).." (Спит)";

	--Other
	KHT_DONE = "готово!"

	--Status Text---------------------------------------
	KHT_ON = "вкл";
	KHT_OFF = "выкл";
	--Slash Text
	KHT_SLASH_HELP = {
		[1] = "Kharthus's Hunter Timers "..KHT_VERSION,
		[2] = "Команды: /kht",
		[3] = "/kht "..KHT_ON.."/"..KHT_OFF,
		[4] = "/kht menu (открыть основное меню аддона)",
		[5] = "/kht reset (сбросить все видимые полоски)",
		[6] = "/kht resetpos (сбросить позицию области полосок)",
		[7] = "/kht delay <time> (время в мс)",
		[8] = "/kht flash <timeleft> (время в секундах до мигания полоски, 0 для отключения)",
		[9] = "/kht step <step> (более высокий шаг означает быстрое мигание)",
		[10] = "/kht barcolor r g b (где r, g, b - числа от 0 до 1)",
		[11] = "/kht barendcolor r g b (где r, g, b - числа от 0 до 1)",
		[12] = "/kht setbgcolor r g b a (где r, g, b, а - числа от 0 до 10)",
		[13] = "/kht colorchange "..KHT_ON.."/"..KHT_OFF.." (функция смены цвета)",
		[14] = "/kht up/down (накладывать полоски сверху или снизу)",
		[15] = "/kht scale % (/kht scale 100 = 100% масштаб)",
		[16] = "/kht lock/unlock (закрепить или открепить область)",
		[17] = "/kht status",
		[18] = "/kht clear all (установить все настройки по умолчанию)",
		[19] = "/kht debug (отображать отладочную информацию)"
	};
	KHT_STATUS_STRINGS = {
		[1] = "|cFFFFFF00Kharthus's Hunter Timers "..KHT_VERSION.."|r",
		[2] = "|cFFFFFF00Статус:|r %s",
		[3] = "|cFFFFFF00Задержка выстрела:|r %dмс", 
		[4] = "|cFFFFFF00Время сверкания:|r %ds |cFFFFFF00Шаг:|r %f",
		[5] = "|cFFFFFF00Цвет полосы:|r %s |cFFFFFF00Цвет конца полосы:|r %s",
		[6] = "|cFFFFFF00Смена цвета:|r %s |cFFFFFF00Прирост:|r %s",
		[7] = "|cFFFFFF00Масштаб:|r %d%%"
	};

	KHT_OPTIONS_COLOR_CHANGE = "Смена цвета";
	KHT_OPTIONS_MILI = "мс";
	KHT_OPTIONS_LOCK = "Закрепить";
	KHT_OPTIONS_BAR_DIST = "Промежуток между полосами";
	KHT_OPTIONS_SCALE = "Масштаб";
	KHT_OPTIONS_FLASH = "Время сверкания";
	KHT_OPTIONS_STEP = "Шаг сверкания";
	KHT_OPTIONS_BARSTART = "Цвет начала полосы";
	KHT_OPTIONS_BAREND = "Цвет конца полосы";
	KHT_OPTIONS_BACKDROP = "Цвет фона";
	KHT_OPTIONS_TIMERS_TEXT = "Таймеры";
	KHT_OPTIONS_BARS_TEXT = "Полосы";
	KHT_OPTIONS_DECIMALS = "Десятичный";
	KHT_OPTIONS_SHOT_DELAY = "Задержка выстрела";
	KHT_OPTIONS_SHOW_TEX = "Показать текстуру";
	KHT_OPTIONS_LARGE_TEX = "Большая текстура";
	KHT_OPTIONS_APPEND = "Добавлять цель";
	KHT_OPTIONS_BORDER = "Цвет края";
	KHT_OPTIONS_TEXT_COLOR = "Цвет текста";
	KHT_OPTIONS_TIME_COLOR = "Цвет времени";
	KHT_OPTIONS_TARGET_COLOR = "Цвет цели";
	KHT_OPTIONS_OVERALL_OPACITY = "Прозрачность";
	KHT_OPTIONS_HIDE_TEXT = "Скрыть текст";
	KHT_OPTIONS_HIDE_TIME = "Скрыть время";
	KHT_OPTIONS_HIDE_GAP = "Скрыть Gap";
	KHT_OPTIONS_BAR_THICKNESS = "Толщина полос";
	KHT_OPTIONS_HIDE_PADDING = "Скрыть заполнение";
	KHT_OPTIONS_STICKY = "Клейкий авто-выстрел";
	KHT_OPTIONS_DOWN = "Каскад полос вниз";

	--Options moved to globals because they dealt with other variables
	-- Translated by StingerSoft
end

