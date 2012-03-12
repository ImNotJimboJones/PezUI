if( GetLocale() == "koKR" ) then

	--Set/Item Procs
	KHT_BEAST_4PC = "야수제왕의 갑옷 4세트 효과";
	KHT_DRAGON_8PC = "용추적자 갑옷 8세트 효과";
	KHT_DESOLATION_4PC = "황량함의 방어구 4세트 효과";
	KHT_ZG = "줄구룹 장착 무기"
	KHT_DON_SANTOS = "돈 산토스의 유명한 사냥용 소총";
	KHT_THUNDER = "천둥치는 하늘불꽃 다이아몬드";
	KHT_SCOURGE = "스컬지추적자 전투장비 4세트 효과";
	KHT_ASHEN = "복수의 잿빛 고리";
	KHT_BLOOD_HUNTER = "안카하르 피사냥꾼 전투장비 2/4세트 효과";
	KHT_WINDRUNNER = "윈드러너의 전투장비 4세트 효과";
	KHT_HYPER = "번개 가속기";

	--Trinket Spells
	KHT_ADWT = "고대 드레나이 전투 부적";
	KHT_ANVIL = "티탄의 모루";
	KHT_ATOS = "신속의 잿빛혓바닥 부적";
	KHT_BERSERK_CALL = "광전사의 부름";
	KHT_BLADEFIST = "블레이드 피스트의 관용";
	KHT_BLOODLUST_BROOCH = "피의 욕망 브로치";
	KHT_ARKELOS = "알켈로스의 핵";
	KHT_DARK_GREAT = "다크문 카드: 위대함";
	KHT_DARK_MAD = "다크문 카드: 광기";
	KHT_DARK_WRATH = "다크문 카드: 진노";
	KHT_VERDICT = "죽음의 선고";
	KHT_DEVIL_EYE = "데빌사우루스 눈";
	KHT_DST = "용의 뼈 전리품";
	KHT_EMPTY_MUG = "빈 다이어브루 맥주잔";
	KHT_HOURGLASS = "해결사의 모래시계";
	KHT_MOTB = "배신자의 광기";
	KHT_MIRROR = "진실의 거울";
	KHT_OGRE = "오우거 투사의 휘장";
	KHT_PYRITE_INFUSER = "황철광 주입기";
	KHT_SIGNET_EDWARD = "외팔이 에드워드의 인장";
	KHT_SKY_CROSS = "하늘경비대 은빛 훈장";
	KHT_TALON_ALAR = "알라르의 갈퀴발톱";
	KHT_TTP = "정밀함의 테로카르 서판";
	KHT_TSUNAMI_TALISMAN = "대해일의 부적";
	KHT_UNITING = "결속의 부적";
	KHT_HERO_MEDALLION = "잔달라의 영웅 메달";
	KHT_NEEDLE = "바늘 박힌 전갈";
	KHT_DEATHBRINGER = "죽음인도자의 의지";
	KHT_FANGED_SKULL = "속삭이는 송곳니 해골";

	--Pet Abilities
	KHT_PET_INTIM = "소환수 "..GetSpellInfo(19577);			-- Pet Intimidation

	--Traps
	KHT_VENOMOUS = "독사";
	KHT_AURA = "효과";
	KHT_PRIMED = "설치";

	--Stings
	KHT_STING = "쐐기";
	KHT_WYVERN_TEXT = GetSpellInfo(19386).." (잠)";				-- Wyvern Sting (Sleep)

	--Other
	KHT_DONE = "완료!"

	--Status Text---------------------------------------
	KHT_ON = "on";
	KHT_OFF = "off";
	--Slash Text
	KHT_SLASH_HELP = {
		[1] = "Kharthus's Hunter Timers "..KHT_VERSION,
		[2] = "명령어: /kht",
		[3] = "/kht "..KHT_ON.."/"..KHT_OFF.." (KHT 기능 켜기/끄기)", 
		[4] = "/kht menu (설정 창 열기)",
		[5] = "/kht reset (바 초기화)",
		[6] = "/kht resetpos (기준점 위치 초기화)",
		[7] = "/kht delay <time> (사격 지연 시간, time 값은 1/100초 단위)",
		[8] = "/kht flash <timeleft> (깜박임 시작 시간, timeleft 값은 1초 단위, 0은 끄기)",
		[9] = "/kht step <step> (깜박임 간격, step 값이 높을 수록 빨리 깜박임)",
		[10] = "/kht barcolor r g b (r, g, b 는 0 에서 1 사이)",
		[11] = "/kht barendcolor r g b (r, g, b 값은 0 에서 1 사이)",
		[12] = "/kht setbgcolor r g b a (r, g, b, a 값은는 0 에서 1 사이)",
		[13] = "/kht colorchange "..KHT_ON.."/"..KHT_OFF.." (색 변화 켜기/끄기)",
		[14] = "/kht up/down (바를 기준점 위/아래로 이동)",
		[15] = "/kht scale % (/kht scale 100 = 100% 크기)",
		[16] = "/kht lock/unlock (기준점 이동 가능/불가능)",
		[17] = "/kht status (현재 설정값 출력)",
		[18] = "/kht clear all (모든 설정 초기화)",
		[19] = "/kht debug (디버그 정보)"
	};
	KHT_STATUS_STRINGS = {
		[1] = "|cFFFFFF00Kharthus's Hunter Timers "..KHT_VERSION.."|r",
		[2] = "|cFFFFFF00동작상태:|r %s",
		[3] = "|cFFFFFF00사격 지연:|r %dms", 
		[4] = "|cFFFFFF00깜박임 시간:|r %d초 |cFFFFFF00간격:|r %f",
		[5] = "|cFFFFFF00바 색:|r %s |cFFFFFF00마침 색:|r %s",
		[6] = "|cFFFFFF00색 변화:|r %s |cFFFFFF00방향:|r %s",
		[7] = "|cFFFFFF00크기:|r %d%%"
	};

	KHT_OPTIONS_COLOR_CHANGE = "색 변화";
	KHT_OPTIONS_MILI = "ms";
	KHT_OPTIONS_LOCK = "잠금";
	KHT_OPTIONS_BAR_DIST = "바 간격";
	KHT_OPTIONS_SCALE = "크기";
	KHT_OPTIONS_FLASH = "깜박임 시간";
	KHT_OPTIONS_STEP = "깜박임 간격";
	KHT_OPTIONS_BARSTART = "시작 색";
	KHT_OPTIONS_BAREND = "마침 색";
	KHT_OPTIONS_BACKDROP = "배경 색";
	KHT_OPTIONS_TIMERS_TEXT = "기술과 효과";
	KHT_OPTIONS_BARS_TEXT = "바 설정";
	KHT_OPTIONS_DECIMALS = "소수점";
	KHT_OPTIONS_SHOT_DELAY = "사격 지연";
	KHT_OPTIONS_SHOW_TEX = "그림 표시";
	KHT_OPTIONS_LARGE_TEX = "큰 그림";
	KHT_OPTIONS_APPEND = "바에 대상 표시";
	KHT_OPTIONS_BORDER = "테두리 색";
	KHT_OPTIONS_TEXT_COLOR = "글자 색";
	KHT_OPTIONS_TIME_COLOR = "시간 색";
	KHT_OPTIONS_TARGET_COLOR = "대상 글자 색";
	KHT_OPTIONS_OVERALL_OPACITY = "투명도";
	KHT_OPTIONS_HIDE_TEXT = "글자 숨김";
	KHT_OPTIONS_HIDE_TIME = "시간 숨김";
	KHT_OPTIONS_HIDE_GAP = "틈 숨김";
	KHT_OPTIONS_BAR_THICKNESS = "바 두께";
	KHT_OPTIONS_HIDE_PADDING = "여백 숨김";
	KHT_OPTIONS_STICKY = "자동 사격 고정";
	KHT_OPTIONS_DOWN = "기준점 아래로 정렬";
	KHT_OPTIONS_TEXTURE = "바 텍스쳐";

	KHT_BEAST = "야수 조련 타이머 사용";
	KHT_MARKS = "징표 타이머 사용";
	KHT_SURV = "생존 타이머 사용";
	KHT_PETS = "소환수 타이머 사용";
	KHT_MISC = "장신구 타이머 사용";
	KHT_TRINKETS = "장신구";

	--Options moved to globals because they dealt with other variables
		
end

