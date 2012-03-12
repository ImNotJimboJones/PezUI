--KHT globals

KHT_NUM_BARS = 11;
KHT_NUM_OPTIONS = 11;
KHT_NUM_LABELS = 11;
KHT_NUM_SLIDERS = 7;

KHT_NUM_TIMERS = {
	[1] = 11,		-- Beast
	[2] = 14,		-- Marks
	[3] = 18,		-- Surv
	[4] = 22,		-- Pets
	[5] = 23,		-- Misc
	[6] = 43		-- Trinkets
};

KHT_OPTIONS_TIMERS = {
	[1] = {		-- Beast
		[1]  = KHT_BEAST,
		[2]  = KHT_BW,
		[3]  = KHT_COBRA_STRIKES,
		[4]  = KHT_FEED_PET,
		[5]  = KHT_FOCUS_FIRE,
		[6]  = KHT_PET_FRENZY,
		[7]  = KHT_INTIM,
		[8]  = KHT_KILLING_STREAK,
		[9]  = KHT_MEND_PET,
		[10] = KHT_SCARE_BEAST,
		[11] = KHT_WIDOW_VENOM
	},
	[2] = {		-- Marks
		[1]  = KHT_MARKS,
		[2]  = KHT_AUTO_SHOT,
		[3]  = KHT_CONC_BARRAGE,
		[4]  = KHT_CONC_SHOT,
		[5]  = KHT_FLARE,
		[6]  = KHT_HUNTERS_MARK,
		[7]  = KHT_STEADY,
		[8]  = KHT_MARKED,
		[9]  = KHT_MASTER_MARKS,
		[10] = KHT_PIERCING,
		[11] = KHT_RAPID_FIRE,
		[12] = KHT_RAPID_KILLING,
		[13] = KHT_SERPENT,
		[14] = KHT_SILENCE_SHOT
	},
	[3] = {		-- Surv
		[1]  = KHT_SURV,
		[2]  = KHT_BLACK_ARROW,
		[3]  = KHT_CAMO,
		[4]  = KHT_COUNTER,
		[5]  = KHT_DETERRENCE,
		[6]  = KHT_ENTRAPMENT,
		[7]  = KHT_EXPL_SHOT,
		[8]  = KHT_EXPL_TRAP,
		[9]  = KHT_FREEZING_TRAP,
		[10] = KHT_FROST_TRAP,
		[11] = KHT_IMMO_TRAP,
		[12] = KHT_LOCK_LOAD,
		[13] = KHT_MISDIRECTION,
		[14] = KHT_SCATTER,
		[15] = KHT_SNAKE_TRAP,
		[16] = KHT_SNIPER,
		[17] = KHT_WING_CLIP,
		[18] = KHT_WYVERN
	},
	[4] = {		-- Pets
		[1]  = KHT_PETS,
		[2]  = KHT_ANKLE,
		[3]  = KHT_CALL,
		[4]  = KHT_CARRION,
		[5]  = KHT_COWER,
		[6]  = KHT_CULLING,
		[7]  = KHT_DASH,
		[8]  = KHT_FURIOUS,
		[9]  = KHT_STAND,
		[10] = KHT_BITE,
		[11] = KHT_RABID,
		[12] = KHT_COURAGE,
		[13] = KHT_RECOVERY,
		[14] = KHT_ROAR,
		[15] = KHT_SERENITY,
		[16] = KHT_SHIELD,
		[17] = KHT_SPIRIT_MEND,
		[18] = KHT_TENDON,
		[19] = KHT_WARP,
		[20] = KHT_VENOM_WEB,
		[21] = KHT_WEB,
		[22] = KHT_WEB_WRAP
	},
	[5] = {		-- Misc
		[1]  = KHT_MISC,
		[2]  = KHT_ARCANE,
		[3]  = KHT_ASHEN,
		[4]  = KHT_CHAMPION,
		[5]  = KHT_BEAST_4PC,
		[6]  = KHT_BERSERKING,
		[7]  = KHT_BLOOD_FURY,
		[8]  = KHT_BLOOD_HUNTER,
		[9]  = KHT_BLOODLUST,
		[10] = KHT_DESOLATION_4PC,
		[11] = KHT_DON_SANTOS,
		[12] = KHT_DRAGON_8PC,
		[13] = KHT_FLAMEWAKER,
		[14] = KHT_HEROISM,
		[15] = KHT_HYPER,
		[16] = KHT_SCOURGE,
		[17] = KHT_STONEFORM,
		[18] = KHT_THUNDER,
		[19] = KHT_TIME_WARP,
		[20] = KHT_WAR_STOMP,
		[21] = KHT_WINDRUNNER,
		[22] = KHT_WYRMSTALKER,
		[23] = KHT_ZG
	},
	[6] = {		-- Trinkets
		[1]  = KHT_TRINKETS,
		[2]  = KHT_ABACUS,
		[3]  = KHT_ADWT,
		[4]  = KHT_ANVIL,
		[5]  = KHT_ATOS,
		[6]  = KHT_SWARMGUARD,
		[7]  = KHT_BERSERK_CALL,
		[8]  = KHT_BLADEFIST,
		[9]  = KHT_BLOODLUST_BROOCH,
		[10] = KHT_ARKELOS,
		[11] = KHT_DARK_GREAT,
		[12] = KHT_DARK_MAD,
		[13] = KHT_DARK_WRATH,
		[14] = KHT_DEATHBRINGER,
		[15] = KHT_VERDICT,
		[16] = KHT_DEVIL_EYE,
		[17] = KHT_DST,
		[18] = KHT_EARTHSTRIKE,
		[19] = KHT_EMPTY_MUG,
		[20] = KHT_GRIM_TOLL,
		[21] = KHT_HOURGLASS,
		[22] = KHT_HUNGERER,
		[23] = KHT_INCISOR,
		[24] = KHT_JOM_GABBAR,
		[25] = KHT_KISS_SPIDER,
		[26] = KHT_LOATHEB,
		[27] = KHT_MOTB,
		[28] = KHT_METEORITE,
		[29] = KHT_MIRROR,
		[30] = KHT_MJOLNIR,
		[31] = KHT_NEEDLE,
		[32] = KHT_NIGHTSEYE,
		[33] = KHT_OGRE,
		[34] = KHT_PYRITE_INFUSER,
		[35] = KHT_SHARP_SCALE,
		[36] = KHT_SIGNET_EDWARD,
		[37] = KHT_SKY_CROSS,
		[38] = KHT_TALON_ALAR,
		[39] = KHT_TTP,
		[40] = KHT_TSUNAMI_TALISMAN,
		[41] = KHT_UNITING,
		[42] = KHT_FANGED_SKULL,
		[43] = KHT_HERO_MEDALLION
	}
};

KHT_OPTIONS_BARS = {
	[1] = KHT_OPTIONS_LOCK,
	[2] = KHT_OPTIONS_COLOR_CHANGE,
	[3] = KHT_OPTIONS_SHOW_TEX,
	[4] = KHT_OPTIONS_LARGE_TEX,
	[5] = KHT_OPTIONS_HIDE_GAP,
	[6] = KHT_OPTIONS_APPEND,
	[7] = KHT_OPTIONS_HIDE_PADDING,
	[8] = KHT_OPTIONS_HIDE_TEXT,
	[9] = KHT_OPTIONS_HIDE_TIME,
	[10] = KHT_OPTIONS_STICKY,
	[11] = KHT_OPTIONS_DOWN
};

KHT_OPTIONS_LABELS = {
	[1] = KHT_OPTIONS_BARS_TEXT,
	[2] = KHT_OPTIONS_BORDER,
	[3] = KHT_OPTIONS_BARSTART,
	[4] = KHT_OPTIONS_TEXT_COLOR,
	[5] = KHT_OPTIONS_BACKDROP,
	[6] = KHT_OPTIONS_BAREND,
	[7] = KHT_OPTIONS_TIME_COLOR,
	[8] = KHT_OPTIONS_SHOT_DELAY,
	[9] = KHT_OPTIONS_MILI,
	[10] = KHT_OPTIONS_TARGET_COLOR,
	[11] = KHT_OPTIONS_TEXTURE
};

KHT_OPTIONS_SLIDER = {
	[1] = KHT_OPTIONS_BAR_DIST,
	[2] = KHT_OPTIONS_SCALE,
	[3] = KHT_OPTIONS_DECIMALS,
	[4] = KHT_OPTIONS_FLASH,
	[5] = KHT_OPTIONS_STEP,
	[6] = KHT_OPTIONS_OVERALL_OPACITY,
	[7] = KHT_OPTIONS_BAR_THICKNESS
};

KHT_OPTIONS_SLIDER_ENDS = {
	[1] = {
		[1] = "0",
		[2] = "10"
	},
	[2] = {
		[1] = "50%",
		[2] = "150%"
	},
	[3] = {
		[1] = KHT_OFF,
		[2] = "3"
	},
	[4] = {
		[1] = KHT_OFF,
		[2] = "10"
	},
	[5] = {
		[1] = "0.01",
		[2] = "0.05"
	},
	[6] = {
		[1] = "0%",
		[2] = "100%"
	},
	[7] = {
		[1] = "10",
		[2] = "32"
	}
};
