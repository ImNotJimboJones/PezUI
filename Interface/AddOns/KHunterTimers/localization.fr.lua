if( GetLocale() == "frFR" ) then

	--Trinket Items
	KHT_ADWT = "Ancien talisman de guerre draene\195\175";
	KHT_ATOS = "Talisman de rapidit\195\169 cendrelangue";
	KHT_BERSERK_CALL = "Appel du berserker";
	KHT_BLADEFIST = "Placa de Garrafilada";
	KHT_BLOODLUST = "Broche sanguinaire";
	KHT_ARKELOS = "Noyau d'Ar'kelos";
	KHT_DARK_MAD = "Carte de Sombrelune : Folie";
	KHT_DARK_WRATH = "Carte de Sombrelune : Courroux";
	KHT_DEVIL_EYE = "Oeil de diablosaure";
	KHT_DST = "Troph\195\169e Epine-de-dragon";
	KHT_EMPTY_MUG = "Chope de navrebi\195\168re vide";
	KHT_HOURGLASS = "Sablier du d\195\169trameur";
	KHT_MOTB = "Folie du tra\195\174tre";
	KHT_OGRE = "Insigne de marteleur ogre";
	KHT_SKY_CROSS = "Croix d'argent de la Garde-ciel";
	KHT_TALON_ALAR = "Serre d'Al'Ar";
	KHT_TTP = "Tablette de pr\195\169cision de Terokkar";
	KHT_TSUNAMI_TALISMAN = "Talisman du tsunami";
	KHT_UNITING = "Charme d'unification";
	KHT_HERO_MEDALLION = "M\195\169daillon de h\195\169ros zandalarien";

	--Pet Abilities
--	KHT_PET_INTIM = "Pet "..GetSpellInfo(19577);					-- Pet Intimidation

	--Traps
	KHT_TRAP = "Pi\195\168ge";
	KHT_VENOMOUS = "Serpent venimeux";
	KHT_AURA = "aura";
	KHT_PRIMED = "pos\195\169";
	
	--Stings
	KHT_STING = "Morsure|Piq\195\187re";
--	KHT_WYVERN_TEXT = GetSpellInfo(19386).." (Sleep)";
	
	--Other
	KHT_DONE = "Fini!";
	
	--Status Text---------------------------------------
	KHT_ON = "on";
	KHT_OFF = "off";
	--Slash Text
	KHT_SLASH_HELP = {
		[1] = "Kharthus's Hunter Timers "..KHT_VERSION,
		[2] = "Commands: /kht",
		[3] = "/kht "..KHT_ON.."/"..KHT_OFF,
		[4] = "/kht menu (bring up the gui menu)",
		[5] = "/kht reset (resets all the visible bars)",
		[6] = "/kht resetpos (resets the bar frame position)",
		[7] = "/kht delay <time> (time is in milliseconds)",
		[8] =  "/kht flash <timeleft> (timeleft in seconds to flash the bar, 0 for off)",
		[9] =  "/kht step <step> (higher step means faster flashing when time is low)",
		[10] = "/kht barcolor r g b (where r, g, b are between 0 and 1)",
		[11] = "/kht barendcolor r g b (where r, g, b are between 0 and 1)",
		[12] = "/kht setbgcolor r g b a (where r, g, b, a are between 0 and 10)",
		[13] = "/kht colorchange "..KHT_ON.."/"..KHT_OFF.." (color change feature)",
		[14] = "/kht up/down (cascade bars up or down)",
		[15] = "/kht scale % (/kht scale 100 = 100% scale)",
		[16] = "/kht lock/unlock (lock or unlock the frame)",
		[17] = "/kht status",
		[18] = "/kht clear all (resets all options to defaults)",
		[19] = "/kht debug (debug info for testing purposes)"
	};
	KHT_STATUS_STRINGS = {
		[1] = "|cFFFFFF00Kharthus's Hunter Timers "..KHT_VERSION.."|r",
		[2] = "|cFFFFFF00Status:|r %s",
		[3] = "|cFFFFFF00Shot delay:|r %dms", 
		[4] = "|cFFFFFF00Flash time:|r %ds |cFFFFFF00Step:|r %f",
		[5] = "|cFFFFFF00Barcolor:|r %s |cFFFFFF00Barcolorend:|r %s",
		[6] = "|cFFFFFF00Colorchange:|r %s |cFFFFFF00Growth:|r %s",
		[7] = "|cFFFFFF00Scale:|r %d%%"
	};
	
	KHT_OPTIONS_COLOR_CHANGE = "Color Change";
	KHT_OPTIONS_MILI = "ms";
	KHT_OPTIONS_LOCK = "Lock";
	KHT_OPTIONS_BAR_DIST = "Distance Between Bars";
	KHT_OPTIONS_SCALE = "Scale";
	KHT_OPTIONS_FLASH = "Flash Time";
	KHT_OPTIONS_STEP = "Flash Step";
	KHT_OPTIONS_BARSTART = "Bar Start Color";
	KHT_OPTIONS_BAREND = "Bar End Color";
	KHT_OPTIONS_BACKDROP = "Backdrop Color";
	KHT_OPTIONS_TIMERS_TEXT = "Timers";
	KHT_OPTIONS_BARS_TEXT = "Bars";
	KHT_OPTIONS_DECIMALS = "Decimals";
	KHT_OPTIONS_SHOT_DELAY = "Shot Delay";
	KHT_OPTIONS_SHOW_TEX = "Show Textures";
	KHT_OPTIONS_LARGE_TEX = "Large Textures";
	KHT_OPTIONS_APPEND = "Append Target";
	KHT_OPTIONS_BORDER = "Border Color";
	KHT_OPTIONS_TEXT_COLOR = "Text Color";
	KHT_OPTIONS_TIME_COLOR = "Time Color";
	KHT_OPTIONS_TARGET_COLOR = "Target Text Color";
	KHT_OPTIONS_OVERALL_OPACITY = "Overall Opacity";
	KHT_OPTIONS_HIDE_TEXT = "Hide Text";
	KHT_OPTIONS_HIDE_TIME = "Hide Time";
	KHT_OPTIONS_HIDE_GAP = "Hide Gap";
	KHT_OPTIONS_BAR_THICKNESS = "Bar Thickness";
	KHT_OPTIONS_HIDE_PADDING = "Hide Padding";
	KHT_OPTIONS_STICKY = "Sticky Auto Shot";
--	KHT_OPTIONS_DOWN = "Cascade Bars Down";

	--Options moved to globals because they dealt with other variables
		
end
	
