if( GetLocale() == "deDE" ) then

	--Trinket Items
	KHT_ADWT = "Uralter Kriegstalisman der Draenei";
	KHT_ATOS = "Aschenzungentalisman der Schnelligkeit";
	KHT_BERSERK_CALL = "Ruf des Berserkers";
	KHT_BLADEFIST = "Messerfausts Breite";
	KHT_BLOODLUST = "Kampfrauschbrosche";
	KHT_ARKELOS = "Kern von Ar'kelos";
	KHT_DARK_MAD = "Dunkelmond-Karte: Wahnsinn";
	KHT_DARK_WRATH = "Dunkelmond-Karte: Zorn";
	KHT_DEVIL_EYE = "Auge eines Teufelssauriers";
	KHT_DST = "Drachenwirbeltroph\195\164e";
	KHT_EMPTY_MUG = "Leerer D\195\188sterbr\195\164ubecher";
	KHT_HOURGLASS = "Stundenglas des Entwirrers";
	KHT_MOTB = "Wahnsinn des Verr\195\164ters";
	KHT_OGRE = "Abzeichen des Ogerraufers";
	KHT_SKY_CROSS = "Silberkreuz der Himmelswache";
	KHT_TALON_ALAR = "Al'ars Kralle";
	KHT_TTP = "Terokkarschrifttafel der Pr\195\164zision";
	KHT_TSUNAMI_TALISMAN = "Tsunamitalisman";
	KHT_UNITING = "Vereinigender Gl\195\188cksbringer";
	KHT_HERO_MEDALLION = "Heldenmedaillon der Zandalari";

	--Pet Abilities
	KHT_PET_INTIM = "Tier "..GetSpellInfo(19577);					-- Pet Intimidation

	--Traps
	KHT_TRAP = "falle";
	KHT_VENOMOUS = "Giftige Schlange";
	KHT_AURA = "-Aura";
	KHT_PRIMED = "gelegt";
	
	--Stings
	KHT_STING = "biss|stich|Stich";		-- needs to be "biss" or "stich" or "Stich"
	KHT_WYVERN_TEXT = GetSpellInfo(19386).." (Schlaf)";
	
	--Other
	KHT_DONE = "Fertig!"
	
	--Status Text---------------------------------------
	KHT_ON = "an";
	KHT_OFF = "aus";
	--Slash Text
	KHT_SLASH_HELP = {
		[1] = "Kharthus's Hunter Timers "..KHT_VERSION,
		[2] = "Befehle: /kht",
		[3] = "/kht "..KHT_ON.."/"..KHT_OFF,
		[4] = "/kht menu (zeigt das KHT Men\195\188)",
		[5] = "/kht reset (resets all the visible bars)",
		[6] = "/kht resetpos (resets the bar frame position)",
		[7] = "/kht delay <Zeit> (Zeit in Milisekunden f\195\188r Lagverz\195\182gerung)",
		[8] =  "/kht flash <Zeit> (\195\188brige Zeit in Sekunden, ab der die Leiste blinkt, 0 f\195\188r Aus)",
		[9] =  "/kht step <Schritt> (Gr\195\182ssere Schritte bedeutet schnelleres Blinken wenn Zeit abl\195\164uft)",
		[10] = "/kht barcolor r g b (Leistenfarbe, r, g, b Werte zwischen 0 und 1)",
		[11] = "/kht barendcolor r g b (Leisten-Endfarbe, r, g, b Werte zwischen 0 und 1)",
		[12] = "/kht setbgcolor r g b a (Hintergrundfarbe, r, g, b, a Werte zwischen 0 und 10)",
		[13] = "/kht colorchange "..KHT_ON.."/"..KHT_OFF.." (color change feature)",
		[14] = "/kht up/down (cascade bars up or down)",
		[15] = "/kht scale % (/kht scale 100 = 100% Skalierung)",
		[16] = "/kht lock/unlock (lock or unlock the frame)",
		[17] = "/kht status",
		[18] = "/kht clear all (resets all options to defaults)",
		[19] = "/kht debug (debug info for testing purposes)"
	};
	KHT_STATUS_STRINGS = {
		[1] = "|cFFFFFF00Kharthus's Hunter Timers "..KHT_VERSION.."|r",
		[2] = "|cFFFFFF00Status:|r %s",
		[3] = "|cFFFFFF00Schuss Verz\195\182gerung:|r %dms", 
		[4] = "|cFFFFFF00Flash time:|r %ds |cFFFFFF00Step:|r %f",
		[5] = "|cFFFFFF00Leistenfarbe:|r %s |cFFFFFF00Leisten-Endfarbe:|r %s",
		[6] = "|cFFFFFF00Farb\195\164nderung:|r %s |cFFFFFF00Vergr\195\182sserung:|r %s",
		[7] = "|cFFFFFF00Skalierung:|r %d%%"
	};
	
	KHT_OPTIONS_COLOR_CHANGE = "Farb\195\164nderung";
	KHT_OPTIONS_MILI = "ms";
	KHT_OPTIONS_LOCK = "Sperren";
	KHT_OPTIONS_BAR_DIST = "Abstand zwischen Leisten";
	KHT_OPTIONS_SCALE = "Skalierung";
	KHT_OPTIONS_FLASH = "Blink Zeit";
	KHT_OPTIONS_STEP = "Blink Schritte";
	KHT_OPTIONS_BARSTART = "Leiste Anfangsfarbe";
	KHT_OPTIONS_BAREND = "Leiste Endfarbe";
	KHT_OPTIONS_BACKDROP = "Hintergrundfarbe";
	KHT_OPTIONS_TIMERS_TEXT = "Timer";
	KHT_OPTIONS_BARS_TEXT = "Leisten";
	KHT_OPTIONS_DECIMALS = "Dezimalstellen";
	KHT_OPTIONS_SHOT_DELAY = "Schuss Verz\195\182gerung";
	KHT_OPTIONS_SHOW_TEX = "Zeige Texturen";
	KHT_OPTIONS_LARGE_TEX = "Grosse Texturen";
	KHT_OPTIONS_APPEND = "Ziel anh\195\164ngen";
	KHT_OPTIONS_BORDER = "Rahmenfarbe";
	KHT_OPTIONS_TEXT_COLOR = "Text Farbe";
	KHT_OPTIONS_TIME_COLOR = "Zeit Farbe";
	KHT_OPTIONS_TARGET_COLOR = "Ziel Text Farbe";
	KHT_OPTIONS_OVERALL_OPACITY = "Durchsichtigkeit";
	KHT_OPTIONS_HIDE_TEXT = "Verstecke Text";
	KHT_OPTIONS_HIDE_TIME = "Verstecke Zeit";
	KHT_OPTIONS_HIDE_GAP = "Verstecke L\195\188cke";
	KHT_OPTIONS_BAR_THICKNESS = "Leistendicke";
	KHT_OPTIONS_HIDE_PADDING = "Verstecke Padding";
--	KHT_OPTIONS_STICKY = "Sticky Auto Shot";
--	KHT_OPTIONS_DOWN = "Cascade Bars Down";

	-- Beutju
	
	--Options moved to globals because they dealt with other variables
		
end
	
