KHT_VERSION = "v"..GetAddOnMetadata("KHunterTimers", "Version");

--Abilities-----------------------------------------
--Shots
KHT_AUTO_SHOT = GetSpellInfo(75);			-- Auto Shot
KHT_CONC_SHOT = GetSpellInfo(5116);		-- Concussive Shot
KHT_SCATTER = GetSpellInfo(19503);			-- Scatter Shot
KHT_SILENCE_SHOT = GetSpellInfo(34490);		-- Silencing Shot
KHT_BLACK_ARROW = GetSpellInfo(3674);		-- Black Arrow
KHT_CHIMERA = GetSpellInfo(53209);			-- Chimera Shot
KHT_MULTI = GetSpellInfo(2643);			-- Multi-Shot
KHT_COBRA = GetSpellInfo(77767);			-- Cobra Shot
KHT_EXPL_SHOT = GetSpellInfo(53301);		-- Explosive Shot
KHT_WIDOW_VENOM = GetSpellInfo(82654);		-- Widow Venom

--Buffs
KHT_HUNTERS_MARK = GetSpellInfo(1130);		-- Hunter's Mark
KHT_MISDIRECTION = GetSpellInfo(34477);		-- Misdirection
KHT_RAPID_FIRE = GetSpellInfo(3045);		-- Rapid Fire
KHT_CAMO = GetSpellInfo(51753);			-- Camouflage

--Pet Skills
KHT_CALL = GetSpellInfo(53434);			-- Call of the Wild
KHT_STAND = GetSpellInfo(53478);			-- Last Stand
KHT_RABID = GetSpellInfo(53401);			-- Rabid
KHT_ROAR = GetSpellInfo(53480);			-- Roar of Sacrifice
KHT_SERENITY = GetSpellInfo(50318);		-- Serenity Dust
KHT_BITE = GetSpellInfo(54680);			-- Monstrous Bite
KHT_BITE_PROC = GetSpellInfo(54681);		-- Monstrous Strength
KHT_TENDON = GetSpellInfo(50271);			-- Tendon Rip
KHT_DASH = GetSpellInfo(1850);			-- Dash
KHT_CARRION = GetSpellInfo(54044);			-- Carrion Feeder
KHT_FURIOUS = GetSpellInfo(24604);			-- Furious Howl
KHT_WARP = GetSpellInfo(35346);			-- Time Warp
KHT_SHIELD = GetSpellInfo(26064);			-- Shell Shield
KHT_CULLING = GetSpellInfo(70893);			-- Culling the Herd
KHT_COWER = GetSpellInfo(1742);			-- Cower
KHT_ANKLE = GetSpellInfo(50433);			-- Ankle Crack
KHT_RECOVERY = GetSpellInfo(53517);		-- Roar of Recovery
KHT_SPIRIT_MEND = GetSpellInfo(90361);		-- Spirit Mend
KHT_COURAGE = GetSpellInfo(93435);			-- Roar of Courage
KHT_WEB = GetSpellInfo(4167);				-- Web
KHT_VENOM_WEB = GetSpellInfo(54706);		-- Venom Web Spray
KHT_WEB_WRAP = GetSpellInfo(96201);		-- Web Wrap

--Racials
KHT_ARCANE = GetSpellInfo(25046);			-- Arcane Torrent
KHT_BERSERKING = GetSpellInfo(26297);		-- Berserking
KHT_BLOOD_FURY = GetSpellInfo(20572);		-- Blood Fury
KHT_STONEFORM = GetSpellInfo(20594);		-- Stoneform
KHT_WAR_STOMP = GetSpellInfo(20549);		-- War Stomp
KHT_HEROISM, _, KHT_HEROISM_ICON = GetSpellInfo(32182);		-- Heroism
KHT_BLOODLUST, _, KHT_BLOODLUST_ICON = GetSpellInfo(2825);		-- Bloodlust
KHT_TIME_WARP, _, KHT_TIME_WARP_ICON = GetSpellInfo(80353);		-- Time Warp

--Set/Item Procs
KHT_CHAMPION, _, KHT_CHAMPION_ICON = GetSpellInfo(35081);				-- Band of the Eternal Champion
KHT_BEASTLORD, _, KHT_BEASTLORD_ICON = GetSpellInfo(37482);				-- Beast Lord 4-piece bonus
KHT_BEAST_4PC = "Beast Lord 4-piece bonus";
KHT_EXPOSE_DS, _, KHT_EXPOSE_DS_ICON = GetSpellInfo(23577);				-- Dragonstalker 8-piece bonus
KHT_DRAGON_8PC = "Dragonstalker 8-piece bonus";
KHT_HEROIC, _, KHT_HEROIC_ICON = GetSpellInfo(37612);					-- Desolation 4-piece bonus
KHT_DESOLATION_4PC = "Desolation 4-piece bonus";
KHT_PRIMAL, _, KHT_PRIMAL_ICON = GetSpellInfo(24255);					-- ZG fist weapons
KHT_ZG = "ZG fist weapons"
KHT_SANTOS, _, KHT_SANTOS_ICON = GetSpellInfo(38293);					-- Don Santos' Famous Hunting Rifle
KHT_DON_SANTOS = "Don Santos' Famous Hunting Rifle";
KHT_SKYFIRE, _, KHT_SKYFIRE_ICON = GetSpellInfo(39959);				-- Thundering Skyfire Diamond
KHT_THUNDER = "Thundering Skyfire Diamond";
KHT_PRECISION, _, KHT_PRECISION_ICON = GetSpellInfo(64861);				-- Scourgestalker 4-piece bonus
KHT_SCOURGE = "Scourgestalker 4-piece bonus";
KHT_ASHEN_VERDICT, _, KHT_ASHEN_VERDICT_ICON = GetSpellInfo(72412);		-- Ashen Verdict ring
KHT_ASHEN = "Ashen Band of Vengeance";
KHT_BLOOD_HUNT_2PC, _, KHT_BLOOD_HUNT_2PC_ICON = GetSpellInfo(70728);		-- Blood Hunter 2-piece bonus
KHT_BLOOD_HUNT_4PC, _, KHT_BLOOD_HUNT_4PC_ICON = GetSpellInfo(71007);		-- Blood Hunter 4-piece bonus
KHT_BLOOD_HUNTER = "Blood Hunter 2/4-piece bonuses";
KHT_WINDRUNNER_4PC, _, KHT_WINDRUNNER_4PC_ICON = GetSpellInfo(68130);		-- Windrunner 4-piece bonus
KHT_WINDRUNNER = "Windrunner 4-piece bonus";
KHT_HYP_SPEED, _, KHT_HYP_SPEED_ICON = GetSpellInfo(54758);				-- Hyperspeed Accelerators
KHT_HYPER = "Hyperspeed Accelerators";
KHT_FLAMEWAKER_4PC, _, KHT_FLAMEWAKER_4PC_ICON = GetSpellInfo(99060);		-- Flamewaker 4-piece bonus
KHT_FLAMEWAKER = "Flamewaker 4-piece bonus";
KHT_WYRMSTALKER_4PC, _, KHT_WYRMSTALKER_4PC_ICON = GetSpellInfo(105919);	-- Wyrmstalker 4-piece bonus
KHT_WYRMSTALKER = "Wyrmstalker 4-piece bonus";

--Talent Procs
KHT_COBRA_STRIKES, _, KHT_COBRA_STRIKES_ICON = GetSpellInfo(53257);		-- Cobra Strikes
KHT_CONC_BARRAGE, _, KHT_CONC_BARRAGE_ICON = GetSpellInfo(35101);		-- Concussive Barrage
KHT_STEADY, _, KHT_STEADY_ICON = GetSpellInfo(53220);					-- Improved Steady Shot
KHT_LOCK_LOAD, _, KHT_LOCK_LOAD_ICON = GetSpellInfo(56453);				-- Lock and Load
KHT_RAPID_KILLING, _, KHT_RAPID_KILLING_ICON = GetSpellInfo(35098);		-- Rapid Killing
KHT_PIERCING, _, KHT_PIERCING_ICON = GetSpellInfo(63468);				-- Piercing Shots
KHT_MASTER_MARKS = GetSpellInfo(34485);								-- Master Marksman
KHT_READY_SET, _, KHT_READY_SET_ICON = GetSpellInfo(82925);
KHT_FIRE, _, KHT_FIRE_ICON = GetSpellInfo(82926);
KHT_FOCUS_FIRE = GetSpellInfo(82692);								-- Focus Fire
KHT_KILLING_STREAK, _, KHT_KILLING_ICON = GetSpellInfo(94006);			-- Killing Streak
KHT_SNIPER, _, KHT_SNIPER_ICON = GetSpellInfo(53302);					-- Sniper Training
KHT_MARKED, _, KHT_MARKED_ICON = GetSpellInfo(88691);					-- Marked for Death

--Trinket Spells
KHT_ABACUS, _, KHT_ABACUS_ICON = GetSpellInfo(33807);					-- Abacus of Violent Odds
KHT_ADWT = "Ancient Draenei War Talisman";
KHT_FEROCITY, _, KHT_FEROCITY_ICON = GetSpellInfo(33667);				-- Ancient Draenei War Talisman and Bladefist's Breath
KHT_ANVIL = "Anvil of Titans";
KHT_TORMENT, _, KHT_TORMENT_ICON = GetSpellInfo(60065);				-- Anvil of Titans and Mirror of Truth
KHT_ATOS = "Ashtongue Talisman of Swiftness";
KHT_ASHTONGUE, _, KHT_ASHTONGUE_ICON = GetSpellInfo(40487);				-- Ashtongue Talisman of Swiftness
KHT_SWARMGUARD, _, KHT_SWARMGUARD_ICON = GetSpellInfo(26480);			-- Badge of the Swarmguard
KHT_BERSERK_CALL = "Berserker's Call";
KHT_BERSERKER, _, KHT_BERSERKER_ICON = GetSpellInfo(43716);				-- Berserker's Call
KHT_BLADEFIST = "Bladefist's Breath";
KHT_BLOODLUST_BROOCH = "Bloodlust Brooch";
KHT_LUST, _, KHT_LUST_ICON = GetSpellInfo(35166);						-- Bloodlust Brooch
KHT_ARKELOS = "Core of Ar'kelos";
KHT_ANCIENT_POWER, _, KHT_ANCIENT_POWER_ICON = GetSpellInfo(35733);		-- Core of Ar'kelos
KHT_DARK_GREAT = "Darkmoon Card: Greatness";
KHT_GREATNESS, _, KHT_GREATNESS_ICON = GetSpellInfo(60233);				-- Darkmoon Card: Greatness
KHT_DARK_MAD = "Darkmoon Card: Madness";
KHT_DELUSIONAL, _, KHT_DELUSIONAL_ICON = GetSpellInfo(40997);			-- Darkmoon Card: Madness
KHT_KLEPTOMANIA, _, KHT_KLEPTOMANIA_ICON = GetSpellInfo(40998);			-- Darkmoon Card: Madness
KHT_MANIC, _, KHT_MANIC_ICON = GetSpellInfo(41005);					-- Darkmoon Card: Madness
KHT_MARTYR, _, KHT_MARTYR_ICON = GetSpellInfo(41011);					-- Darkmoon Card: Madness
KHT_NARCISSISM, _, KHT_NARCISSIM_ICON = GetSpellInfo(41009);			-- Darkmoon Card: Madness
KHT_PARANOIA, _, KHT_PARANOIA_ICON = GetSpellInfo(41002);				-- Darkmoon Card: Madness
KHT_DARK_WRATH = "Darkmoon Card: Wrath";
KHT_WRATH, _, KHT_WRATH_ICON = GetSpellInfo(39443);					-- Darkmoon Card: Wrath
KHT_VERDICT = "Death's Verdict";
KHT_PARAGON, _, KHT_PARAGON_ICON = GetSpellInfo(67703);				-- Death's Verdict
KHT_DEVIL_EYE = "Devilsaur Eye";
KHT_DEVILSAUR, _, KHT_DEVILSAUR_ICON = GetSpellInfo(24352);				-- Devilsaur Eye
KHT_DST = "Dragonspine Trophy";
KHT_DRAGON, _, KHT_DRAGON_ICON = GetSpellInfo(34775);					-- Dragonspine Trophy
KHT_EARTHSTRIKE, _, KHT_EARTHSTRIKE_ICON = GetSpellInfo(25891);			-- Earthstrike
KHT_EMPTY_MUG = "Empty Mug of Direbrew";
KHT_DIREBREW, _, KHT_DIREBREW_ICON = GetSpellInfo(51955);				-- Empty Mug of Direbrew
KHT_GRIM_TOLL, _, KHT_GRIM_TOLL_ICON = GetSpellInfo(60437);				-- Grim Toll
KHT_HOURGLASS = "Hourglass of the Unraveller";
KHT_UNRAVELLER, _, KHT_UNRAVELLER_ICON = GetSpellInfo(33649);			-- Hourglass of the Unraveller
KHT_INCISOR, _, KHT_INCISOR_ICON = GetSpellInfo(60299);				-- Incisor Fragment
KHT_JOM_GABBAR, _, KHT_JOM_GABBAR_ICON = GetSpellInfo(29604);			-- Jom Gabbar
KHT_KISS_SPIDER, _, KHT_KISS_SPIDER_ICON = GetSpellInfo(28866);			-- Kiss of the Spider
KHT_LOATHEB, _, KHT_LOATHEB_ICON = GetSpellInfo(60439);				-- Loatheb's Shadow
KHT_MOTB = "Madness of the Betrayer";
KHT_MADNESS, _, KHT_MADNESS_ICON = GetSpellInfo(40477);				-- Madness of the Betrayer
KHT_METEORITE, _, KHT_METEORITE_ICON = GetSpellInfo(60302);				-- Meteorite Whetstone
KHT_MIRROR = "Mirror of Truth";
KHT_MJOLNIR, _, KHT_MJOLNIR_ICON = GetSpellInfo(65019);				-- Mjolnir Runestone
KHT_NIGHTSEYE, _, KHT_NIGHTSEYE_ICON = GetSpellInfo(31047);				-- Nightseye Panther
KHT_OGRE = "Ogre Mauler's Badge";
KHT_BURNING_HATRED, _, KHT_BURNING_HATRED_ICON = GetSpellInfo(32362);		-- Ogre Mauler's Badge and Uniting Charm
KHT_PYRITE_INFUSER = "Pyrite Infuser";
KHT_PYRITE, _, KHT_PYRITE_ICON = GetSpellInfo(65014);					-- Pyrite Infuser
KHT_SIGNET_EDWARD = "Signet of Edward the Odd";
KHT_EDWARD, _, KHT_EDWARD_ICON = GetSpellInfo(60318);					-- Signet of Edward the Odd
KHT_SKY_CROSS = "Skyguard Silver Cross";
KHT_SKYGUARD, _, KHT_SKYGUARD_ICON = GetSpellInfo(41261);				-- Skyguard Silver Cross
KHT_TALON_ALAR = "Talon of Al'ar";
KHT_TALON, _, KHT_TALON_ICON = GetSpellInfo(37508);					-- Talon of Al'ar
KHT_TTP = "Terokkar Tablet of Precision";
--KHT_HEROISM, _, KHT_HEROISM_ICON = GetSpellInfo(39200);				-- Terokkar Tablet of Precision
KHT_TSUNAMI_TALISMAN = "Tsunami Talisman";
KHT_TSUNAMI, _, KHT_TSUNAMI_ICON = GetSpellInfo(42084);				-- Tsunami Talisman
KHT_UNITING = "Uniting Charm";
KHT_HERO_MEDALLION = "Zandalarian Hero Medallion";
KHT_ZHM, _, KHT_ZHM_ICON = GetSpellInfo(24661);						-- Zandalarian Hero Medallion
KHT_NEEDLE = "Needle-Encrusted Scorpion";
KHT_NES, _, KHT_NES_ICON = GetSpellInfo(71403);						-- Needle-Encrusted Scorpion
KHT_DEATHBRINGER = "Deathbringer's Will";
KHT_DEATH_AGI, _, KHT_DEATH_AGI_ICON = GetSpellInfo(71485);				-- Deathbringer's Will
KHT_DEATH_AP, _, KHT_DEATH_AP_ICON = GetSpellInfo(71486);				-- Deathbringer's Will
KHT_DEATH_CRIT, _, KHT_DEATH_CRIT_ICON = GetSpellInfo(71491);			-- Deathbringer's Will
KHT_FANGED_SKULL = "Whispering Fanged Skull";
KHT_FANGED, _, KHT_FANGED_ICON = GetSpellInfo(71401);					-- Whispering Fanged Skull
KHT_SHARP_SCALE = "Sharpened Twilight Scale";
KHT_STS, _, KHT_STS_ICON = GetSpellInfo(75458);						-- Sharpened Twilight Scale
KHT_HUNGERER = "The Hungerer";
KHT_HUNGER, _, KHT_HUNGER_ICON = GetSpellInfo(96911);					-- The Hungerer

--Pet Abilities
KHT_PET_INTIM = "Pet "..GetSpellInfo(19577);					-- Pet Intimidation
KHT_INTIM = GetSpellInfo(24394);							-- Intimidation
KHT_BW = GetSpellInfo(19574);								-- Bestial Wrath
KHT_FEED_PET = GetSpellInfo(6991);							-- Feed Pet
KHT_MEND_PET = GetSpellInfo(136);							-- Mend Pet
KHT_PET_FRENZY, _, KHT_PET_FRENZY_ICON = GetSpellInfo(19615);	-- Frenzy

--Traps
KHT_FROST_TRAP = GetSpellInfo(13809);						-- Frost Trap
KHT_EXPL_TRAP = GetSpellInfo(13813);						-- Explosive Trap
KHT_IMMO_TRAP = GetSpellInfo(13795);						-- Immolation Trap
KHT_FREEZING_TRAP = GetSpellInfo(1499);						-- Freezing Trap
KHT_SNAKE_TRAP = GetSpellInfo(34600);						-- Snake Trap
KHT_VENOMOUS = "Venomous Snake";
KHT_ENTRAPMENT, _, KHT_ENTRAPMENT_ICON = GetSpellInfo(19185);	-- Entrapment
KHT_AURA = "aura";
KHT_PRIMED = "primed";

--Melee Abilities
KHT_WING_CLIP = GetSpellInfo(2974);						-- Wing Clip
KHT_COUNTER = GetSpellInfo(19306);							-- Counterattack
KHT_DETERRENCE = GetSpellInfo(19263);						-- Deterrence

--Stings
KHT_STING = "Sting";
KHT_WYVERN = GetSpellInfo(19386);							-- Wyvern Sting
KHT_WYVERN_TEXT = GetSpellInfo(19386).." (Sleep)";			-- Wyvern Sting (Sleep)
KHT_SERPENT = GetSpellInfo(1978);							-- Serpent Sting

--Other
KHT_FLARE = GetSpellInfo(1543);							-- Flare
KHT_SCARE_BEAST = GetSpellInfo(1513);						-- Scare Beast
KHT_DONE = "Done!"

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
	[8] = "/kht flash <timeleft> (timeleft in seconds to flash the bar, 0 for off)",
	[9] = "/kht step <step> (higher step means faster flashing when time is low)",
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
KHT_OPTIONS_DOWN = "Cascade Bars Down";
KHT_OPTIONS_TEXTURE = "Bar Texture";

KHT_BEAST = "Enable 'Beast Mastery' Timers";
KHT_MARKS = "Enable 'Marksmanship' Timers";
KHT_SURV = "Enable 'Survival' Timers";
KHT_PETS = "Enable 'Pet' Timers";
KHT_MISC = "Enable 'Miscellaneous' Timers";
KHT_TRINKETS = "Enable 'Trinket' Timers";

--Options moved to globals because they dealt with other variables
