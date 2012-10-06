local ZGV = ZygorGuidesViewer
if not ZGV then return end

local L = ZGV.L

local tinsert=tinsert

ZGV.ItemScore = {}
local ItemScore = ZGV.ItemScore
local IS = ItemScore

local function flip_array(arr)
	local flipped = {}
	for i,name in ipairs(arr) do flipped[name]=i end
	return flipped
end

ItemScore.items_in_guides = {}

-- Blizzard will NOT play nice... Items only return localized data, how fun. Delocalize everything into numbers, then...
local itemclasses = flip_array({GetAuctionItemClasses()})
local itemweapsubclasses = flip_array({GetAuctionItemSubClasses(1)})
local itemarmsubclasses = flip_array({GetAuctionItemSubClasses(2)})
local class_ids = {"WEAPON","ARMOR"}
local weap_ids = {"AXE","TH_AXE","BOW","GUN","MACE","TH_MACE","TH_POLE","SWORD","TH_SWORD","TH_STAFF","FIST","MISCWEAP","DAGGER","THROWN","XBOW","WAND"}
local arm_ids = {"MISCARM","CLOTH","LEATHER","MAIL","PLATE","SHIELD","RELIC"}

-- Sorry for twohanders being "TH" and not "2H", it was easier to write that way.
-- Offhands are MISCARM.
local rules = {
	["DEATHKNIGHT"] = {
		[1] = { --BLOOD
			itemtypes={ TH_POLE=1,TH_AXE=1,TH_MACE=1,TH_SWORD=1, PLATE=1 },
			stats = { DPS={weight=22}, STRENGTH={weight=20}, STAMINA={weight=18}, PARRY={weight=15}, DODGE={weight=15}, MASTERY={weight=16}, HIT={weight=14,default=12,hitcap=15,category=CR_HIT_MELEE}, EXPERTISE={weight=14,default=10,expcap=7.5}, ATTACK_POWER={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_POWER=1 },
		},
		[2] = { --FROST
			itemtypes={ TH_POLE=1,TH_AXE=1,TH_MACE=1,TH_SWORD=1, AXE=2,MACE=2,SWORD=2, PLATE=1 },
			stats = { DPS={weight=22}, STRENGTH={weight=20}, HIT={weight=18,default=18,hitcap=7.5,autohitcap=27,category=CR_HIT_MELEE}, EXPERTISE={weight=18,default=16,expcap=7.5}, MASTERY={weight=16}, HASTE={weight=16}, ATTACK_POWER={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_POWER=1,DODGE=1,PARRY=1,SPELL_PENETRATION=1 },
		},
		[3] = { --UNHOLY
			itemtypes={ TH_POLE=1,TH_AXE=1,TH_MACE=1,TH_SWORD=1, PLATE=1 },
			stats = { DPS={weight=22}, STRENGTH={weight=20}, HIT={weight=18,default=18,hitcap=7.5,category=CR_HIT_MELEE}, HASTE={weight=16}, CRIT={weight=14}, MASTERY={weight=12}, EXPERTISE={weight=18,default=10,expcap=7.5}, ATTACK_POWER={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_POWER=1,DODGE=1,PARRY=1,SPELL_PENETRATION=1 },
		}
	},
	["DRUID"] = {
		[1] = { --BALANCE
			itemtypes={ DAGGER=1,MACE=1,MISCWEAP=1, TH_STAFF=1, LEATHER=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, HIT={weight=16,default=16,hitcap=15,category=CR_HIT_SPELL}, SPIRIT={weight=16,hitcap=15}, HASTE={weight=14}, MASTERY={weight=10}, CRIT={weight=12} },
			badstats = { STRENGTH=1,AGILITY=1,EXPERTISE=1,DODGE=1,PARRY=1 },
		},
		[2] = { --FERAL
			itemtypes={ TH_POLE=1,TH_STAFF=1, LEATHER=1 },
			stats = { DPS={weight=22}, AGILITY={weight=20}, MASTERY={weight=18}, CRIT={weight=16}, HASTE={weight=12}, EXPERTISE={weight=16,default=16,expcap=7.5}, HIT={weight=14,default=8,hitcap=7.5,category=CR_HIT_MELEE}, ATTACK_POWER={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_POWER=1,SPELL_PENETRATION=1 },
		},
		[3] = { --GUARDIAN
			itemtypes={ TH_POLE=1,TH_STAFF=1, LEATHER=1 },
			stats = { DPS={weight=22}, AGILITY={weight=20}, STAMINA={weight=20}, DODGE={weight=18}, MASTERY={weight=18}, EXPERTISE={weight=14,default=12,expcap=7.5}, CRIT={weight=16}, HIT={weight=14,default=10,hitcap=7.5,category=CR_HIT_MELEE}, HASTE={weight=12}, ATTACK_POWER={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_POWER=1,SPELL_PENETRATION=1 },
		},
		[4] = { --RESTORATION
			itemtypes={ DAGGER=1,MACE=1,MISCWEAP=1, TH_STAFF=1, LEATHER=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, MASTERY={weight=14}, HASTE={weight=16}, CRIT={weight=14}, SPIRIT={weight=18} },
			badstats = { STRENGTH=1,AGILITY=1,HIT=1,EXPERTISE=1,SPELL_PENETRATION=1,DODGE=1,PARRY=1 },
		}
	},
	["HUNTER"] = {  -- all 3 identical
		[1] = { --BEAST MASTERY
			itemtypes={BOW=1,XBOW=1,GUN=1,LEATHER=-50,MAIL=40 },
			stats = { DPS={weight=22}, AGILITY={weight=20}, HIT={weight=18,default=18,hitcap=7.5,category=CR_HIT_RANGED}, EXPERTISE={weight=16,default=16,expcap=7.5}, CRIT={weight=14}, MASTERY={weight=12}, HASTE={weight=10}, ATTACK_POWER={weight=10} },
			badstats = { STRENGTH=1,INTELLECT=1,SPIRIT=1,SPELL_POWER=1,SPELL_PENETRATION=1,DODGE=1,PARRY=1 },
		},
		[2] = { --MARKSMANSHIP,SURVIVAL
			itemtypes={BOW=1,XBOW=1,GUN=1, LEATHER=-50,MAIL=40 },
			stats = { DPS={weight=22}, AGILITY={weight=20}, HIT={weight=18,default=18,hitcap=7.5,category=CR_HIT_RANGED}, EXPERTISE={weight=16,default=16,expcap=7.5}, CRIT={weight=14}, MASTERY={weight=12}, ATTACK_POWER={weight=10}, HASTE={weight=10} },
			badstats = { STRENGTH=1,INTELLECT=1,SPIRIT=1,SPELL_POWER=1,SPELL_PENETRATION=1,DODGE=1,PARRY=1 },
		},
		[3] = { --MARKSMANSHIP,SURVIVAL
			itemtypes={BOW=1,XBOW=1,GUN=1, LEATHER=-50,MAIL=40 },
			stats = { DPS={weight=22}, AGILITY={weight=20}, HIT={weight=18,default=18,hitcap=7.5,category=CR_HIT_RANGED}, EXPERTISE={weight=16,default=16,expcap=7.5}, CRIT={weight=14}, MASTERY={weight=12}, ATTACK_POWER={weight=10}, HASTE={weight=10} },
			badstats = { STRENGTH=1,INTELLECT=1,SPIRIT=1,SPELL_POWER=1,SPELL_PENETRATION=1,DODGE=1,PARRY=1 },
		},
	},
	["MONK"] = {
		[1] = { --BREWMASTER-TANK
			itemtypes={ TH_POLE=1,TH_STAFF=1,FIST=1,AXE=1,SWORD=1,LEATHER=1 },
			stats = { DPS={weight=22}, AGILITY={weight=20}, STAMINA={weight=18}, DODGE={weight=16}, MASTERY={weight=14}, EXPERTISE={weight=12,default=12,expcap=7.5}, CRIT={weight=12}, HIT={weight=10,default=10,hitcap=7.5,category=CR_HIT_MELEE}, HASTE={weight=3}, ATTACK_POWER={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_POWER=1,SPELL_PENETRATION=1 },
		},
		[2] = { --MISTWEAVER-HEAL
			itemtypes={ TH_POLE=1,TH_STAFF=1,FIST=1,AXE=1,SWORD=1,LEATHER=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, SPIRIT={weight=16}, HASTE={weight=14}, MASTERY={weight=14}, CRIT={weight=12} },
			badstats = { STRENGTH=1,AGILITY=1,EXPERTISE=1,DODGE=1,PARRY=1 },
		},
		[3] = { --WINDWALKER-DPS
			itemtypes={ TH_POLE=1,TH_STAFF=1,FIST=1,AXE=1,SWORD=1,LEATHER=1 },
			stats = { DPS={weight=22}, AGILITY={weight=20}, MASTERY={weight=18}, HIT={weight=16,default=16,specialhitcap=7.5,hitcap=15,autohitcap=27,category=CR_HIT_MELEE}, EXPERTISE={weight=14,default=14,expcap=7.5}, HASTE={weight=12}, ATTACK_POWER={weight=10}, CRIT={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_PENETRATION=1,SPELL_POWER=1,DODGE=1,PARRY=1 },
		}
	},
	["MAGE"] = {  -- all 3 identical
		[1] = {
			itemtypes={ DAGGER=1,SWORD=1,TH_STAFF=1, WAND=1, MISCARM=1, CLOTH=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, HIT={weight=18,default=18,hitcap=15,category=CR_HIT_SPELL}, CRIT={weight=16}, HASTE={weight=14}, MASTERY={weight=12} },
			badstats = { STRENGTH=1,AGILITY=1,SPIRIT=1,EXPERTISE=1,DODGE=1,PARRY=1 },
		},
		[2] = {
			itemtypes={ DAGGER=1,SWORD=1,TH_STAFF=1, WAND=1, MISCARM=1, CLOTH=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, HIT={weight=18,default=18,hitcap=15,category=CR_HIT_SPELL}, CRIT={weight=16}, HASTE={weight=14}, MASTERY={weight=12} },
			badstats = { STRENGTH=1,AGILITY=1,SPIRIT=1,EXPERTISE=1,DODGE=1,PARRY=1 },
		},
		[3] = {
			itemtypes={ DAGGER=1,SWORD=1,TH_STAFF=1, WAND=1, MISCARM=1, CLOTH=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, HIT={weight=18,default=18,hitcap=15,category=CR_HIT_SPELL}, CRIT={weight=16}, HASTE={weight=14}, MASTERY={weight=12} },
			badstats = { STRENGTH=1,AGILITY=1,SPIRIT=1,EXPERTISE=1,DODGE=1,PARRY=1 },
		}
	},
	["PALADIN"] = {
		[1] = { --HOLY
			itemtypes={ AXE=1,MACE=1,SWORD=1, SHIELD=1, MISCARM=1, MAIL=-50,PLATE=40 },
			stats = { SPIRIT={weight=20}, SPELL_POWER={weight=18},INTELLECT={weight=18}, HASTE={weight=16}, CRIT={weight=14}, MASTERY={weight=16} },
			badstats = { AGILITY=1,STRENGTH=1,EXPERTISE=1,HIT=1,SPELL_PENETRATION=1,DODGE=1,PARRY=1 },
		},
		[2] = { --PROTECTION
			itemtypes={ AXE=1,MACE=1,SWORD=1, SHIELD=1, MAIL=-50,PLATE=40 },
			stats = { DPS={weight=22}, STRENGTH={weight=20}, STAMINA={weight=20}, MASTERY={weight=14}, DODGE={weight=16}, PARRY={weight=16}, HIT={weight=12,default=12,hitcap=7.5,category=CR_HIT_MELEE}, EXPERTISE={weight=12,default=12,expcap=7.5}, ATTACK_POWER={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_POWER=1,AGILITY=1,SPELL_PENETRATION=1 },
		},
		[3] = { --RETRIBUTION
			itemtypes={ TH_POLE=1,TH_AXE=1,TH_MACE=1,TH_SWORD=1, MAIL=-50,PLATE=40 },
			stats = { DPS={weight=22}, STRENGTH={weight=20}, HIT={weight=18,default=18,hitcap=7.5,category=CR_HIT_MELEE}, EXPERTISE={weight=18,default=16,expcap=7.5}, MASTERY={weight=14}, CRIT={weight=12}, HASTE={weight=16}, ATTACK_POWER={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_POWER=1,DODGE=1,PARRY=1,SPELL_PENETRATION=1 },
		}
	},
	["PRIEST"] = {
		[1] = { --DISCIPLINE
			itemtypes={ DAGGER=1,MACE=1,TH_STAFF=1, WAND=1, MISCARM=1, CLOTH=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, SPIRIT={weight=16}, HASTE={weight=14}, CRIT={weight=14}, MASTERY={weight=14} },
			badstats = { STRENGTH=1,AGILITY=1,EXPERTISE=1,HIT=1,DODGE=1,PARRY=1 },
		},
		[2] = { --HOLY
			itemtypes={ DAGGER=1,MACE=1,TH_STAFF=1, WAND=1, MISCARM=1, CLOTH=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, SPIRIT={weight=16}, HASTE={weight=14}, MASTERY={weight=14}, CRIT={weight=12} },
			badstats = { STRENGTH=1,AGILITY=1,EXPERTISE=1,HIT=1,DODGE=1,PARRY=1 },
		},
		[3] = { --SHADOW
			itemtypes={ DAGGER=1,MACE=1,TH_STAFF=1, WAND=1, MISCARM=1, CLOTH=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, HIT={weight=18,default=18,hitcap=15,category=CR_HIT_SPELL}, SPIRIT={weight=18,spellhitcap=15}, HASTE={weight=16}, CRIT={weight=12}, MASTERY={weight=14} },
			badstats = { STRENGTH=1,AGILITY=1,EXPERTISE=1,DODGE=1,PARRY=1 },
		}
	},
	["ROGUE"] = {
		[1] = { --ASSASSINATION
			itemtypes={ DAGGER=2,LEATHER=1 },
			stats = { DPS={weight=22}, AGILITY={weight=20}, MASTERY={weight=18}, HIT={weight=16,default=16,specialhitcap=7.5,hitcap=15,autohitcap=27,category=CR_HIT_SPELL}, EXPERTISE={weight=14,default=14,expcap=7.5}, HASTE={weight=12}, ATTACK_POWER={weight=10}, CRIT={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_PENETRATION=1,SPELL_POWER=1,DODGE=1,PARRY=1 },
		},
		[2] = { --COMBAT
			itemtypes={ DAGGER=2,FIST=2,AXE=2,MACE=2,SWORD=2, LEATHER=1 },
			stats = { DAMAGE={weight=22,onlyinslot="MAINHAND"}, DPS={weight=22,onlyinslot="OFFHAND"}, AGILITY={weight=20}, HIT={weight=16,default=16,hitcap=7.5,poisonhitcap=15,autohitcap=27,category=CR_HIT_MELEE}, EXPERTISE={weight=14,default=14,expcap=7.5}, MASTERY={weight=12}, ATTACK_POWER={weight=10}, HASTE={weight=10}, CRIT={weight=8} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_PENETRATION=1,SPELL_POWER=1,DODGE=1,PARRY=1 },
		},
		[3] = { --SUBTLETY
			itemtypes={ DAGGER=2,FIST=2,AXE=2,MACE=2,SWORD=2, LEATHER=1 },
			stats = { DPS={weight=22}, AGILITY={weight=20}, HIT={weight=16,default=16,hitcap=7.5,poisonhitcap=15,autohitcap=27,category=CR_HIT_MELEE}, HASTE={weight=14}, EXPERTISE={weight=14,default=14,expcap=7.5}, CRIT={weight=12}, ATTACK_POWER={weight=10}, MASTERY={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_PENETRATION=1,SPELL_POWER=1,DODGE=1,PARRY=1 },
		}
	},
	["SHAMAN"] = {
		[1] = { --ELEMENTAL
			itemtypes={ DAGGER=1,FIST=1,AXE=1,MACE=1,TH_STAFF=1,MISCARM=1,SHIELD=1, LEATHER=-50,MAIL=40, },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, SPIRIT={weight=16,spellhitcap=15}, HIT={weight=16,default=16,hitcap=15,category=CR_HIT_SPELL}, HASTE={weight=14}, MASTERY={weight=14}, CRIT={weight=12} },
			badstats = { STRENGTH=1,AGILITY=1,EXPERTISE=1,DODGE=1,PARRY=1 },
		},
		[2] = { --ENHANCEMENT:
			itemtypes={ DAGGER=2,FIST=2,AXE=2,MACE=2,TH_STAFF=1,TH_AXE=1,TH_MACE=1,MISCARM=1, LEATHER=-50,MAIL=40, }, --dual from 10?
			stats = { DPS={weight=22}, AGILITY={weight=20}, HIT={weight=18,default=18,specialhitcap=7.5,hitcap=15,autohitcap=27,category=CR_HIT_SPELL}, EXPERTISE={weight=14,default=14,expcap=7.5}, MASTERY={weight=12}, ATTACK_POWER={weight=10}, CRIT={weight=10},HASTE={weight=8}, },
			badstats = { INTELLECT=1,SPIRIT=1,DODGE=1,PARRY=1 },
		},
		[3] = { --RESTORATION
			itemtypes={ DAGGER=1,FIST=1,AXE=1,MACE=1,TH_STAFF=1,MISCARM=1,SHIELD=1, LEATHER=-50,MAIL=40, },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, SPIRIT={weight=16}, HASTE={weight=14}, CRIT={weight=12}, MASTERY={weight=10} },
			badstats = { STRENGTH=1,AGILITY=1,HIT=1,EXPERTISE=1,SPELL_PENETRATION=1,DODGE=1,PARRY=1 },
		}
	},
	["WARLOCK"] = {
		[1] = { --AFFLICTION
			itemtypes={ SWORD=1,DAGGER=1,TH_STAFF=1,WAND=1, MISCARM=1, CLOTH=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, HIT={weight=16,default=16,hitcap=15,category=CR_HIT_SPELL}, CRIT={weight=14}, MASTERY={weight=12}  },
			badstats = { STRENGTH=1,AGILITY=1,SPIRIT=1,EXPERTISE=1,DODGE=1,PARRY=1 },
		},
		[2] = { --DEMONOLOGY
			itemtypes={ SWORD=1,DAGGER=1,TH_STAFF=1,WAND=1, MISCARM=1, CLOTH=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, HIT={weight=16,default=16,hitcap=15,category=CR_HIT_SPELL}, MASTERY={weight=14}, HASTE={weight=12}, CRIT={weight=10} },
			badstats = { STRENGTH=1,AGILITY=1,SPIRIT=1,EXPERTISE=1,DODGE=1,PARRY=1 },
		},
		[3] = { --DESTRUCTION
			itemtypes={ SWORD=1,DAGGER=1,TH_STAFF=1,WAND=1, MISCARM=1, CLOTH=1 },
			stats = { INTELLECT={weight=20}, SPELL_POWER={weight=18}, HIT={weight=16,default=16,hitcap=15,category=CR_HIT_SPELL}, HASTE={weight=14}, CRIT={weight=12}, MASTERY={weight=10}  },
			badstats = { STRENGTH=1,AGILITY=1,SPIRIT=1,EXPERTISE=1,DODGE=1,PARRY=1 },
		}
	},
	["WARRIOR"] = {
		[1] = { --ARMS
			itemtypes={ TH_POLE=1,TH_STAFF=1,TH_AXE=1,TH_MACE=1,TH_SWORD=1, MAIL=-50,PLATE=40 },
			stats = { DPS={weight=22}, STRENGTH={weight=20}, HIT={weight=18,default=18,hitcap=7.5,category=CR_HIT_MELEE}, EXPERTISE={weight=16,default=16,expcap=7.5}, CRIT={weight=14}, MASTERY={weight=14}, HASTE={weight=12}, ATTACK_POWER={weight=10} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_POWER=1,DODGE=1,PARRY=1,SPELL_PENETRATION=1 },
		},
		[2] = { --FURY
			itemtypes={ TH_AXE=38,TH_MACE=38,TH_SWORD=38, DAGGER=1,FIST=1,AXE=1,MACE=1,SWORD=1, MAIL=-50,PLATE=40 },  -- duals...
			stats = { DPS={weight=22}, STRENGTH={weight=20}, EXPERTISE={weight=18,default=18,expcap=7.5}, HIT={weight=18,default=18,hitcap=16,autohitcap=27,category=CR_HIT_MELEE}, CRIT={weight=16}, HASTE={weight=12} , ATTACK_POWER={weight=10}, MASTERY={weight=14}},
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_POWER=1,DODGE=1,PARRY=1,SPELL_PENETRATION=1 },
		},
		[3] = { --PROT
			itemtypes={ DAGGER=1,FIST=1,AXE=1,MACE=1,SWORD=1, MAIL=-50,PLATE=40, SHIELD=1 },
			stats = { DPS={weight=22}, STRENGTH={weight=20}, MASTERY={weight=18}, DODGE={weight=14}, PARRY={weight=16}, STAMINA={weight=18}, EXPERTISE={weight=12,default=12,expcap=7.5}, ATTACK_POWER={weight=10}, HIT={weight=10,default=10,hitcap=7.5,category=CR_HIT_MELEE} },
			badstats = { INTELLECT=1,SPIRIT=1,SPELL_POWER=1,SPELL_PENETRATION=1 },
		}
	},
}


ItemScore.rules = rules

do -- Add HIT/CRIT variants
	for class,classrules in pairs(rules) do
		for spec,rule in pairs(classrules) do
			for dataname,data in pairs(rule) do  if dataname=="stats" or dataname=="badstats" then
				-- add _RATING
				local ratings={"HIT","CRIT","DODGE","PARRY","HASTE","MASTERY","EXPERTISE"}
				for i,stat in ipairs(ratings) do  data[stat.."_RATING"]=data[stat]  data[stat]=nil  end

				-- add melee/spell/ranged -- not needed. All Crit/hit rating is just CRIT_RATING or HIT_RATING. The different kinds can be gathered from char menu
			--[[	data.CRIT_MELEE_RATING = data.CRIT_RATING --not needed currently, everything is "HIT_RATING"
				data.CRIT_RANGED_RATING = data.CRIT_RATING
				data.CRIT_SPELL_RATING = data.CRIT_RATING
				data.HIT_MELEE_RATING = data.HIT_RATING
				data.HIT_RANGED_RATING = data.HIT_RATING
				data.HIT_SPELL_RATING = data.HIT_RATING--]]

				data.DAMAGE_PER_SECOND = data.DPS  data.DPS=nil
			end  end
		end
	end
end

-- Artificial "bonuses" on items with special properties that can't be processed automatically.
local special_item_stats = {
	[869] = { --Dazzling Longsword: "Chance on hit: Decrease the armor of the target by 100 for 30 sec.  While affected, the target cannot stealth or turn invisible."
		STRENGTH=7,STAMINA=7
	}
}

local itembase = {}
setmetatable(itembase,{__index=function(tab,key) tab[key]={} return tab[key] end })

itembase.weapon = { 869, 9392, 65947, 1265, 18310, 9401, 13034, 9424, 62201, 33270, 33271 }
itembase.armor = { }
itembase.all = { 869, 9392, 65947, 1265, 18310, 9401, 13034, 9424, 62201, 33270, 33271 }
ItemScore.itembase = itembase

ItemScore.DATA={itemclasses,itemweapsubclasses,itemarmsubclasses,class_ids,weap_ids,arm_ids}
ItemScore.debug=1

function ItemScore:Debug(...)
	local str = ...
	ZGV:Debug("|cffffdd00ItemScore>|cfff8f0ff ".. str, select(2,...) )
end

local item={}

local SC_NORULES = "no rules"
local SC_BADSLOT = "bad slot"
local SC_NOTYET = "not ready"
local SC_BADITEM = "bad item"
local SC_NOTFORU = "not for you"
local SC_LEVELREQ = "level req"
local SC_BADSTAT = "bad stat"

local Gratuity = LibStub("LibGratuity-3.0")

local ItemCache = {}
ItemScore.ItemCache = ItemCache

function Detemplate(s)
	return s :gsub("([%-%+%.])","%%%1") :gsub("%%d","(%%d+)") :gsub("%%s","(.-)") :gsub("%%%.%d+f","([0-9%%.]+)")
end

ZGVI_DAMAGE_TEMPLATE = DAMAGE_TEMPLATE :gsub("%%d","(%%d+)") :gsub(" %- "," %%- ")
ZGVI_DAMAGE_TEMPLATE_WITH_SCHOOL = DAMAGE_TEMPLATE_WITH_SCHOOL :gsub("%%d","(%%d+)") :gsub(" %- "," %%- ")
ZGVI_WEAPON_SPEED_TEMPLATE = WEAPON_SPEED.." ([0-9%.]+)"

function GetItemStatsWithTooltip(itemid)
	if ItemCache[itemid] then return ItemCache[itemid] end
	if not itemid then return end
	local name,link,quality,ilevel, reqlevel, class, subclass, maxstack, equipslot, texture, vendorprice = GetItemInfo(itemid)
	if not name then return nil end
	local item = {info={name=name,link=link,quality=quality,ilevel=ilevel,reqlevel=reqlevel,class=class,subclass=subclass,equipslot=equipslot,vendorprice=vendorprice}, stats={}, tooltip={}}
	GetItemStats("item:"..itemid,item.stats)
	Gratuity:SetHyperlink("|Hitem:"..itemid.."|h[q]|h")
	local n = Gratuity:NumLines()
	if n <= 1 then return end
	for i=1,n do
		local line=Gratuity:GetLine(i)
		if line then
			local d1,d2 = line:match(ZGVI_DAMAGE_TEMPLATE)  if d1 and d2 then item.stats.DAMAGE1,item.stats.DAMAGE2,item.stats.DAMAGE = tonumber(d1),tonumber(d2),(tonumber(d1)+tonumber(d2))/2 end
			local s1 = line:match(ZGVI_WEAPON_SPEED_TEMPLATE)  if s1 then item.stats.SPEED = tonumber(s1) end
			tinsert(item.tooltip,line)
		end
		local line=Gratuity:GetLine(i,true)  --right line
		if line then
			local d1,d2 = line:match(ZGVI_DAMAGE_TEMPLATE)  if d1 and d2 then item.stats.DAMAGE1,item.stats.DAMAGE2,item.stats.DAMAGE = tonumber(d1),tonumber(d2),(tonumber(d1)+tonumber(d2))/2 end
			local s1 = line:match(ZGVI_WEAPON_SPEED_TEMPLATE)  if s1 then item.stats.SPEED = tonumber(s1) end
			tinsert(item.tooltip,line)
		end
	end

	ItemCache[itemid]=item
	return item
end

function ItemScore:SetFilters(playerclass,playerspec,playerlevel)
	local gettree = ZGV.Expansion_Mists and GetSpecialization or GetPrimaryTalentTree
	if not playerclass or not playerspec then playerclass,playerspec = (select(2,UnitClass("player")) or "WARRIOR"),(gettree() or 1) end
	if not playerlevel then playerlevel=UnitLevel("player") or 1 end
	self.playerclass = playerclass
	self.playerspec = playerspec
	self.playerlevel = playerlevel
end

function ItemScore:PushFilters()
	self.old_playerclass = self.playerclass
	self.old_playerspec = self.playerspec
	self.old_playerlevel = self.playerlevel
end

function ItemScore:PopFilters()
	self.playerclass = self.old_playerclass
	self.playerspec = self.old_playerspec
	self.playerlevel = self.old_playerlevel
end

-- EVIL ASSUMPTION: Let's use a different slot, INVTYPE_2HWEAPON, for two-handers. And INVTYPE_SHIELD for shields.

function ItemScore:GetItemScore(itemid, invslot, verbose, itemlink)

	local value=0 -- returns with the ItemScore if nothing is returned before.

	if not rules[self.playerclass] then return -1,SC_NORULES,"no rules for ".. self.playerclass end
	local rule = rules[self.playerclass][self.playerspec]
	if not rule then return -1,SC_NORULES,"no rules for ".. self.playerclass.." ".. self.playerspec end

	--self:Debug("PlayerClassSpec %s %d",playerclass,playerspec)
	local item

	local function _with_debug(code,reason)
		if verbose then self:Debug("Item dropped: |cff88ffff%d %s type: %s  slot: %s  ==  |cffff0000[%s] %s",itemid,item.info.link,item.info.subclass,item.info.equipslot,code,reason) end
		return -1,code,reason
	end


	item = GetItemStatsWithTooltip(itemid)
	if not item then return _with_debug(SC_NOTYET,"item not found (yet)") end
	
	if item.info.reqlevel>self.playerlevel then return _with_debug(SC_LEVELREQ,"|cffff4400 level req "..item.info.reqlevel) end

	if invslot then -- does the shoe fit?
		local bad=false
		local itemslot = item.info.equipslot
		if (invslot=="INVTYPE_WEAPONMAINHAND" and (itemslot=="INVTYPE_WEAPON" or itemslot=="INVTYPE_WEAPONMAINHAND"))
		or (invslot=="INVTYPE_WEAPONOFFHAND" and (itemslot=="INVTYPE_WEAPON" or itemslot=="INVTYPE_WEAPONOFFHAND"))
		or (invslot=="INVTYPE_RANGED" and (itemslot=="INVTYPE_RANGED" or itemslot=="INVTYPE_RANGEDRIGHT" or itemslot=="INVTYPE_THROWN"))
		or (invslot=="INVTYPE_CHEST" and itemslot=="INVTYPE_ROBE") then
			-- it's OK!
		elseif invslot~=item.info.equipslot then
			bad=true
		end
		if bad then  return _with_debug(SC_BADSLOT,"|cffff8888 item for "..item.info.equipslot.." doesn't match slot "..invslot)  end
	end

	local total,worn = GetAverageItemLevel()
	local inguides = ItemScore.items_in_guides[itemid]
	local dungeondata = inguides and ZGV.Dungeons[inguides.dungeon]
	if dungeondata then
		if dungeondata.minLevel and dungeondata.minLevel>self.playerlevel then  return _with_debug(SC_NOTFORU,"|cffff0000 level must be ".. dungeondata.minLevel.." to enter dungeon")  end
		if dungeondata.min_ilevel and dungeondata.min_ilevel>total then  return _with_debug(SC_NOTFORU,"|cffff0088 itemlevel must be "..dungeondata.min_ilevel.." to get this")  end
		if dungeondata.isHoliday then  return _with_debug(SC_NOTFORU,"|cffff88ff holiday dungeons not supported")  end
		if dungeondata.expansionLevel>GetExpansionLevel() then  return _with_debug(SC_NOTFORU,"don't have expansion")  end
	end

	-- Rings, trinkets, necklaces and cloaks are good for everyone.
	if item.info.equipslot~="INVTYPE_FINGER"
	and item.info.equipslot~="INVTYPE_TRINKET"
	and item.info.equipslot~="INVTYPE_NECK"
	and item.info.equipslot~="INVTYPE_CLOAK"
	then
		-- Determine item class
		local class = class_ids[itemclasses[item.info.class] or 0] or item.info.class
		local subclass = item.info.subclass
		if class=="WEAPON" then
			local cl = weap_ids[itemweapsubclasses[item.info.subclass] or 0]
			if not cl then return _with_debug(SC_BADITEM,("Unknown weapon subclass %s"):format(item.info.subclass)) end
			subclass = cl
		elseif class=="ARMOR" then
			local cl = arm_ids[itemarmsubclasses[item.info.subclass] or 0]
			if not cl then return _with_debug(SC_BADITEM,("Unknown armor subclass %s"):format(item.info.subclass)) end
			subclass = cl
		else
			return _with_debug(SC_BADITEM,("Unknown item class %s"):format(class))
		end

		-- Okay, type ascertained. Is it proper for the player at all?
		local uselevel = rule.itemtypes[subclass]
		--self:Debug("Use at level: %d",uselevel or 0)

		if uselevel==40 and self.playerlevel<50 and self.playerlevel>39 then value=value+100 end --allows hunter/pally/warr/sham to transition from mail->plate from level 40 to 50

		if not uselevel then return -1,SC_NOTFORU,"|cffcc0000 type "..subclass.." bad for ".. self.playerclass.. self.playerspec end
		if (uselevel>0 and self.playerlevel<uselevel) or (uselevel<0 and self.playerlevel>=-uselevel) then return _with_debug(SC_NOTFORU,"|cffff88aa not usable yet at level ".. self.playerlevel) end
	end

	local special = special_item_stats[itemid]
	if special then
		for statname,statvalue in pairs(special) do  item.stats["ITEM_MOD_"..statname]=statvalue  end
	end

	if verbose then self:Debug("Stat analysis: |cff88ffff%d %s type: %s  slot: %s",itemid,item.info.link,item.info.subclass,item.info.equipslot) end

	if itemlink then --Itemlink is needed because for items that are [ITEM OF THE BEAR] the itemid does not include the of the Bear.
		local stat, statvalue
		local prefixTable=GetItemStats(itemlink)
		for stat,statvalue in pairs(prefixTable) do
			if not item.stats[stat] then
				item.stats[stat]=statvalue
			end
		end
	end

	if self.playerlevel<GetMaxPlayerLevel() then
		if self.playerlevel <= 80 and item.info.quality==7 then value = value +10000 end --BoA Heirlooms. They give exp boost so they are very good.
		value = value + item.info.ilevel * 1 -- Item score is only used to make sure value ~=0
	else
		if item.info.ilevel < GetMaxPlayerLevel()*4 then return -1,"Low Item Level" end -- prevent level 1 item from being suggested over a lvl 80 item with 1 badstat
		value= value + item.info.ilevel * 20  -- that's a good start
	end

	for statname,statvalue in pairs(item.stats) do
		if statname:find("^ITEM_MOD_") then
			statname = statname:gsub("^ITEM_MOD_","") :gsub("_SHORT$","") :gsub("_NAME$","")

			if statname=="HIT_RATING" and rule.stats.HIT_RATING then -- if above hit rating cap for each class then make the weight half.
				local hitTable=rule.stats.HIT_RATING
				local currentHit=GetCombatRatingBonus(hitTable.category)+GetHitModifier()
				local default=hitTable.default
				if currentHit > (hitTable.hitcap or 0) or self.playerlevel<GetMaxPlayerLevel() then
					rule.stats.HIT_RATING.weight=default/2 -- set to half importance if hit is over cap or if player is under max level
				else
					rule.stats.HIT_RATING.weight=default
				end
			end

		if statname=="EXPERTISE_RATING" and rule.stats.EXPERTISE_RATING then -- expertise cap of 7.5 makes exp worth half just like ^
				local expTable=rule.stats.EXPERTISE_RATING
				local currentExp=GetExpertise()  --First REturn
				local default=expTable.default
				if currentExp >= (expTable.expcap or 0) or self.playerlevel<GetMaxPlayerLevel() then
					rule.stats.EXPERTISE_RATING.weight=default/2
				else
					rule.stats.EXPERTISE_RATING.weight=default
				end
			end

			local statrule = rule.stats[statname]
			if statrule then
				if (statrule.onlyinslot==invslot) or not statrule.onlyinslot then
					if statname=="DAMAGE_PER_SECOND" or statname=="DAMAGE" then statvalue=statvalue*0.3 end  -- upscaling dps/damage
					value = value + statvalue*(statrule.weight or 1)
					if verbose then  self:Debug("  + |cff00ff00%.1f %s%s|r: |cffaaaaaa * %.1f = |cffffffff%.1f|r",statvalue,statname,special and special[statname] and " (special)" or "", statrule.weight or 1, statvalue*(statrule.weight or 1))  end
				end
			elseif rule.badstats[statname] then
				if verbose then  self:Debug("  + |cffffff00%.1f %s%s|r: |cffff0000REJECTED",statvalue,statname,special and special[statname] and " (special)" or "")  end
				if self.playerlevel==GetMaxPlayerLevel() then return -1,SC_BADSTAT,"useless stat: "..statname end
			else
				--self:Debug("Bonus for |cffffbb00%s%s|r: none",statname,special and special[statname] and " (special)" or "" )
			end
		elseif statname:find("^EMPTY_SOCKET") then
			statname = statname:gsub("^EMPTY_SOCKET_","")--statname is the color of the slot RED/BLUE/YELLOW/META... Can add special rules for each color if desired.
			value=value+item.info.ilevel
		end
	end

	if verbose then  self:Debug("  = |cffccff88%d",value) end

	return value
end

-- Selecting Best Quest reward --
local glowFrame1, glowFrame2, glowFrame3, questRewardInfoMissing
local currentEquipped = {}

local function RemoveGlow()
	if glowFrame1 then
		glowFrame1:Hide()
		glowFrame1=nil

		if glowFrame2 then
			glowFrame2:Hide()
			glowFrame2=nil
				if glowFrame3 then
				glowFrame3:Hide()
				glowFrame3=nil
			end
		end
	end
end

local function QuestRewardGlow(reward)
	if ZGV.db.profile.autoselectitem and ZGV.db.profile.autoturnin then
		GetQuestReward(reward.questindex)
	else
		local b = _G["QuestInfoItem"..reward.questindex]
		local questframe = QuestFrameRewardPanel

		if not glowFrame1 then
			glowFrame1=CreateFrame("Frame","GlowFrame1",questframe)

			glowFrame1:SetBackdrop({bgFile="",edgeFile=ZGV.DIR.."\\Skins\\glowborder", edgeSize=5})
			glowFrame1:SetSize(109,45)
			glowFrame1:SetPoint("CENTER",b,"CENTER",19,2)
			glowFrame1:SetFrameStrata("HIGH")
			glowFrame1:Show()
		elseif not glowFrame2 then
			glowFrame2=CreateFrame("Frame","GlowFrame2",questframe)

			glowFrame2:SetBackdrop({bgFile="",edgeFile=ZGV.DIR.."\\Skins\\glowborder", edgeSize=5})
			glowFrame2:SetSize(109,45)
			glowFrame2:SetPoint("CENTER",b,"CENTER",19,2)
			glowFrame2:SetFrameStrata("HIGH")
			glowFrame2:Show()
		else
			glowFrame3=CreateFrame("Frame","GlowFrame3",questframe)

			glowFrame3:SetBackdrop({bgFile="",edgeFile=ZGV.DIR.."\\Skins\\glowborder", edgeSize=5})
			glowFrame3:SetSize(109,45)
			glowFrame3:SetPoint("CENTER",b,"CENTER",19,2)
			glowFrame3:SetFrameStrata("HIGH")
			glowFrame3:Show()
		end
	end
end

local function GetQuestReward()
	local rewards=GetNumQuestChoices()
	local highSell=0
	local highSellIndex
	local upgradeIndex = {}
	local bestUpgradeAmount=0
	questRewardInfoMissing=false

	local item = {}

	ZGV:Debug("Finding Quest Rewards, ".. rewards .. " choices.")

	if rewards > 0 then
		for index=1, rewards do
			local name,_,numItems,quality,isUsable=GetQuestItemInfo("choice",index)
			local link= GetQuestItemLink("choice",index)

			if not link or not name then
				questRewardInfoMissing=true
				return
			end

			local itemid= tonumber(link:match("item:(%d+)"))
			local price= select(11,GetItemInfo(itemid))
			local equipslot= select(9,GetItemInfo(itemid))

			item[index]={
				["name"] = name,
				["numItems"] = numItems,
				["quality"] = quality,
				["isUsable"] = isUsable,
				["link"] = link,
				["id"] = itemid,
				["price"] = price,
				["questindex"] = index,
				["equipslot"] = equipslot
			}

			if item[index].isUsable then -- Only find Item Score if you can use the item
				local questScore = ItemScore:GetItemScore(item[index].id)
				if item[index].equipslot:match("^INV") == nil then
					return
				end

				local equippedID,equippedID2=ItemScore:GetItemInSlot(item[index].equipslot)
				local equippedScore,equippedScore2

				ZGV:Debug("Reward ".. item[index].link .. " scored "..questScore)

				if (item[index].equipslot=="INVTYPE_WEAPON" and ZGV.ItemScore.playerdualwield) or (equipslot=="INVTYPE_2HWEAPON" and ZGV.ItemScore.playerdual2h) then
					equippedID2=ItemScore:GetItemInSlot("INVTYPE_WEAPONOFFHAND")
				end

				if equippedID then
					equippedScore=currentEquipped[equippedID].score
					ZGV:Debug("Current equipped item(s) are " .. currentEquipped[equippedID].link .. " scored at " .. equippedScore)
				else
					ZGV:Debug("No Item equipped in the slot: " .. item[index].equipslot)
				end

				if equippedID2 then
					equippedScore2=currentEquipped[equippedID2].score
					ZGV:Debug("Current equipped item(s) are " .. currentEquipped[equippedID2].link .. " scored at " .. equippedScore2)
				end

				--local equippedScore = ItemScore:GetItemScore(equippedID,nil,nil,currentEquipped[equippedID].link)
				if equippedScore then
					if questScore > equippedScore then -- Is questItem better than what player has
						local itemUpgradeAmount = questScore-equippedScore

						if itemUpgradeAmount > bestUpgradeAmount then -- if better than best upgrade.
							bestUpgradeAmount = itemUpgradeAmount
							upgradeIndex[1] = index

							local j=2
							while upgradeIndex[j] ~= nil do --remove upgrades that were equal but worse than best.
								upgradeIndex[j]=nil
								j=j+1
							end
						elseif itemUpgradeAmount == bestUpgradeAmount then -- if two items upgrade the same amount then put both in table
							local j=1
							while upgradeIndex[j] ~= nil do
								j=j+1
							end

							upgradeIndex[j] = index
						end
					end
				else -- no item in slot
					local itemUpgradeAmount = questScore

					if itemUpgradeAmount > bestUpgradeAmount then -- if better than best upgrade.
						bestUpgradeAmount = itemUpgradeAmount
						upgradeIndex[1] = index

						local j=2
						while upgradeIndex[j] ~= nil do --remove upgrades that were equal but worse than best.
							upgradeIndex[j]=nil
							j=j+1
						end
					elseif itemUpgradeAmount == bestUpgradeAmount then -- if two items upgrade the same amount then put both in table
						local j=1
						while upgradeIndex[j] ~= nil do
							j=j+1
						end

						upgradeIndex[j] = index
					end
				end
				if equippedScore2 then
					if questScore > equippedScore2 then -- Is questItem better than what player has
						local itemUpgradeAmount = questScore-equippedScore2

						if itemUpgradeAmount > bestUpgradeAmount then -- if better than best upgrade.
							bestUpgradeAmount = itemUpgradeAmount
							upgradeIndex[1] = index

							local j=2
							while upgradeIndex[j] ~= nil do --remove upgrades that were equal but worse than best.
								upgradeIndex[j]=nil
								j=j+1
							end
						elseif itemUpgradeAmount == bestUpgradeAmount then -- if two items upgrade the same amount then put both in table
							local j=1
							while upgradeIndex[j] ~= nil do
								j=j+1
							end

							upgradeIndex[j] = index
						end
					end
				elseif equipslot=="INVTYPE_TRINKET" or equipslot=="INVTYPE_FINGER" --no item in a 2nd slot
				   or (equipslot=="INVTYPE_WEAPON" and ZGV.ItemScore.playerdualwield) --dual wielding
				   or (equipslot=="INVTYPE_2HWEAPON" and ZGV.ItemScore.playerdual2h) then --dual wielding 2handers! lovely.

					local itemUpgradeAmount = questScore

					if itemUpgradeAmount > bestUpgradeAmount then -- if better than best upgrade.
						bestUpgradeAmount = itemUpgradeAmount
						upgradeIndex[1] = index

						local j=2
						while upgradeIndex[j] ~= nil do --remove upgrades that were equal but worse than best.
							upgradeIndex[j]=nil
							j=j+1
						end
					elseif itemUpgradeAmount == bestUpgradeAmount then -- if two items upgrade the same amount then put both in table
						local j=1
						while upgradeIndex[j] ~= nil do
							j=j+1
						end

						upgradeIndex[j] = index
					end
				end
			else
				--Can't use item so only price matters.
			end

			if item[index].price > highSell then
				highSell=item[index].price
				highSellIndex = index
			end
		end

		if upgradeIndex[1] then
			local index=1
			while upgradeIndex[index] ~= nil do
				ZGV:Debug("Upgrades found. Glow on: "..item[upgradeIndex[index]].link)
				QuestRewardGlow(item[upgradeIndex[index]])
				index=index+1
			end
		else
			ZGV:Debug("High Sell item at " .. highSell .. "c")
			QuestRewardGlow(item[highSellIndex])
		end

	else
		--No choice on Quest Rewards.
	end
end

--Auto Equipping the best items for your spec -- 
--I would redo this whole system if I had time since I know how to program better now.
--It works, but might be hard to maintain. Espcially for other people. ~Errc
local lastBagScanTime = 0
local ItemSlots = {}
local FindBestItem, autoEquipButton,runTwice
local savedUpgrade,findMore,totalUpgrades=0
local NoSpecTimer=0

local function equipItem()
			if savedUpgrade.spot2 then
				PickupContainerItem(savedUpgrade.bag,savedUpgrade.slot)

				if savedUpgrade.equipslot=="INVTYPE_FINGER" then
					EquipCursorItem(INVSLOT_FINGER2)
				elseif savedUpgrade.equipslot=="INVTYPE_TRINKET" then
					EquipCursorItem(INVSLOT_TRINKET2)
				elseif savedUpgrade.equipslot=="INVTYPE_WEAPON" or savedUpgrade.equipslot=="INVTYPE_2HWEAPON"  then
					EquipCursorItem(INVSLOT_OFFHAND)
				end
			else
				EquipItemByName(savedUpgrade.id)
			end
end

local function setNotUpgrade(id)
	local link=select(2,GetItemInfo(id))
	ZGV.db.profile.notUpgrades[id]={1,link}
end

local function createConfirmBox()
	local confirmBox=CreateFrame("Frame","ConfirmBox",UIParent)
		confirmBox:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, edgeSize=32, tileSize = 1, insets = { left = 11, right = 12, top = 10, bottom = 11 }})
		confirmBox:SetBackdropColor(1,0,0,1)
		confirmBox:SetWidth(400)
		confirmBox:ClearAllPoints()
		confirmBox:SetPoint("TOP",0,-100)
		confirmBox:SetFrameStrata("DIALOG")
		confirmBox:Hide()
	
	ItemScore.box=confirmBox

	local text=confirmBox:CreateFontString("ConfirmBox_Text","ARTWORK","SystemFont_Med2")
		text:ClearAllPoints()
		text:SetPoint("TOP",0,-20)

	local editBox1=CreateFrame("EditBox","ConfirmBox_EditBox1",confirmBox)
		editBox1:SetHeight(10)
		editBox1:ClearAllPoints()
		editBox1:SetPoint("TOP",0,-37)
		editBox1:SetFontObject("SystemFont_Med2")
		editBox1:SetHyperlinksEnabled(true)
		editBox1:Disable()
		editBox1:SetJustifyH("CENTER")
		editBox1:SetAutoFocus(false)
		editBox1:ClearFocus()
		editBox1:SetWidth(400)
		editBox1:SetHistoryLines(1)

	local text2=confirmBox:CreateFontString("ConfirmBox_Text2","ARTWORK","SystemFont_Med2")
		text2:ClearAllPoints()
		text2:SetPoint("TOP",0,-50)
		ConfirmBox_Text2:SetText("with")

	local editBox2=CreateFrame("EditBox","ConfirmBox_EditBox2",confirmBox)
		editBox2:SetHeight(10)
		editBox2:ClearAllPoints()
		editBox2:SetPoint("TOP",0,-65)
		editBox2:SetFontObject("SystemFont_Med2")
		editBox2:SetHyperlinksEnabled(true)
		editBox2:Disable()
		editBox2:SetJustifyH("CENTER")
		editBox2:SetAutoFocus(false)
		editBox2:ClearFocus()
		editBox2:SetWidth(400)
		editBox2:SetHistoryLines(1)

	local checkbutton=CreateFrame("CheckButton", "ConfirmBox_CheckButton",confirmBox,"UICheckButtonTemplate")
		checkbutton:SetSize(20,20)
		checkbutton:ClearAllPoints()
		checkbutton:SetPoint("BOTTOM",confirmBox,"BOTTOMLEFT",25,10)
		_G[checkbutton:GetName() .. "Text"]:SetText("Don't show again")

	local acceptbutton=CreateFrame("Button", "ConfirmBox_AcceptButton",confirmBox,"UIPanelButtonTemplate")
		acceptbutton:SetSize(100,15)
		acceptbutton:ClearAllPoints()
		acceptbutton:SetPoint("LEFT",checkbutton,"RIGHT",135,0)
		acceptbutton:SetText("Accept")

	local declinebutton=CreateFrame("Button", "ConfirmBox_DeclineButton",confirmBox,"UIPanelButtonTemplate")
		declinebutton:SetSize(100,15)
		declinebutton:ClearAllPoints()
		declinebutton:SetPoint("LEFT",acceptbutton,"RIGHT",10,0)
		declinebutton:SetText("Decline")

	local zgname = ZygorGuidesViewer_L("Main")["zgname"]
	StaticPopupDialogs["AutoEquip"] = {
		text = "Do you want "..zgname.." to automatically equip items without confirmation?",
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			totalUpgrades=0
			ZGV.db.profile.autogear=true
			ZGV.db.profile.autogearframe=false
			checkbutton:SetChecked(false)
			FindBestItem()
		end,
		OnCancel = function()
			totalUpgrades=0
			equipItem()
			ZGV.db.profile.autogear=false
			ZGV.db.profile.autogearframe=false
			checkbutton:SetChecked(false)
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}

	local function escaped()
		confirmBox:Hide()
		StaticPopup_DisplayedFrames[6]=nil
	end

	local function declined(self,key)
		local checked=checkbutton:GetChecked()
		if key=="LeftButton" then
			if checked then
				ZGV.db.profile.autogear=false
				ZGV.db.profile.autogearframe=false
				checkbutton:SetChecked(false)
				totalUpgrades=0
			end
			setNotUpgrade(savedUpgrade.id)

			confirmBox:Hide()
			StaticPopup_DisplayedFrames[6]=nil
			if totalUpgrades > 1 then
				findMore=true
				FindBestItem()
			else
				findMore=false
			end
		end
	end

	local function showTooltip(self,linkData)
		GameTooltip:SetOwner(self,"ANCHOR_BOTTOMLEFT")
		GameTooltip:SetHyperlink(linkData)
		GameTooltip:Show()
	end

	local function hideTooltip()
		GameTooltip:Hide()
	end

	local function accepted()
		local checked=checkbutton:GetChecked()

		if savedUpgrade.overid then
			setNotUpgrade(savedUpgrade.overid)
		end

		if checked then
			StaticPopup_Show ("AutoEquip")
			confirmBox:Hide()
		else
			equipItem()
			if totalUpgrades > 1 then
				findMore=true
				confirmBox:Hide()
			else
				findMore=false
				confirmBox:Hide()
			end
		end
		StaticPopup_DisplayedFrames[6]=nil
	end

	acceptbutton:SetScript("OnClick",accepted)
	declinebutton:SetScript("OnClick",declined)

	hooksecurefunc("StaticPopup_EscapePressed",escaped)
	editBox1:SetScript("OnHyperlinkEnter", showTooltip)
	editBox1:SetScript("OnHyperlinkLeave", hideTooltip)

	editBox2:SetScript("OnHyperlinkEnter", showTooltip)
	editBox2:SetScript("OnHyperlinkLeave", hideTooltip)
end

function showReplaceBox(upgrade)
	local zgname = ZygorGuidesViewer_L("Main")["zgname"]

	ConfirmBox.hideOnEscape=true -- tricking the game to think a static popup is displayed so that escape works correctly.
	StaticPopup_DisplayedFrames[6]=ConfirmBox

	ConfirmBox_Text:SetText(zgname.." would like to replace")
	ConfirmBox_Text2:Show()
	ConfirmBox_EditBox2:Show()
	ConfirmBox_EditBox1:SetText(upgrade.over)
	if(ConfirmBox_EditBox1:GetNumLetters()< 5) then return end --Stange error on login where current items do not get parsed in time
	--ConfirmBox_EditBox1:SetWidth(ConfirmBox_EditBox1:GetNumLetters()*8)
	ConfirmBox_EditBox2:SetText(upgrade.link)
	--ConfirmBox_EditBox2:SetWidth(ConfirmBox_EditBox2:GetNumLetters()*8)
	ConfirmBox:SetHeight(125)
	ConfirmBox:Show()
	savedUpgrade=upgrade
end

function showEquipBox(upgrade)
	local zgname = ZygorGuidesViewer_L("Main")["zgname"]

	ConfirmBox.hideOnEscape=true -- tricking the game to think a static popup is displayed so that escape works correctly.
	StaticPopup_DisplayedFrames[6]=ConfirmBox

	ConfirmBox_Text2:Hide()
	ConfirmBox_EditBox2:Hide()
	ConfirmBox_Text:SetText(zgname.." would like to equip")
	ConfirmBox_EditBox1:SetText(upgrade.link)
	--ConfirmBox_EditBox1:SetWidth(ConfirmBox_EditBox1:GetNumLetters()*8)
	ConfirmBox:SetHeight(90)
	ConfirmBox:Show()
	savedUpgrade=upgrade
end

function showSpecBox(upgrade)
	local zgname = ZygorGuidesViewer_L("Main")["zgname"]

	ConfirmBox.hideOnEscape=true -- tricking the game to think a static popup is displayed so that escape works correctly.
	StaticPopup_DisplayedFrames[6]=ConfirmBox

	ConfirmBox_Text2:Hide()
	ConfirmBox_EditBox2:Hide()
	ConfirmBox_Text:SetText(zgname.." would like to equip")
	ConfirmBox_EditBox1:SetText(upgrade.link)
	--ConfirmBox_EditBox1:SetWidth(ConfirmBox_EditBox1:GetNumLetters()*8)
	ConfirmBox:SetHeight(90)
	ConfirmBox:Show()
	savedUpgrade=upgrade
end


local function slotToSlotNum(itemslot)
	itemslot = itemslot:gsub("^INVTYPE_","")
	itemslot = itemslot:sub(1,1) .. itemslot:sub(2):lower()

	if itemslot=="Hand" then itemslot="Hands"
	elseif itemslot=="Cloak" then itemslot="Back"
	elseif itemslot=="Robe" then itemslot="Chest" -- in case we try to compare to a robe item
	elseif itemslot=="Relic" then -- relic users use ranged slot, otherwise we most certainly don't have a relic.
		if UnitHasRelicSlot("player") then itemslot="Ranged" else return end
	elseif itemslot=="Ranged" then -- relic users don't use ranged.
		if UnitHasRelicSlot("player") then return else itemslot="MainHand" end
	elseif itemslot=="Shield" or itemslot=="Weaponoffhand" or itemslot=="Holdable" then itemslot="SecondaryHand"
	elseif itemslot=="Weapon" or itemslot=="Weaponmainhand" or itemslot=="2hweapon" then itemslot="MainHand"
	elseif itemslot=="Rangedright" or itemslot=="Thrown" then itemslot="Ranged"
	end

	local slot1,slot2,_,relic

	if itemslot=="Trinket" then
		slot1 = GetInventorySlotInfo("Trinket0Slot")
		slot2 = GetInventorySlotInfo("Trinket1Slot")
	elseif itemslot=="Finger" then
		slot1 = GetInventorySlotInfo("Finger0Slot")
		slot2 = GetInventorySlotInfo("Finger1Slot")
	else
		slot1,_,_ = GetInventorySlotInfo(itemslot.."Slot")
	end

	return slot1,slot2
end

local function getItemScore(slot)
	local id , id2 = ItemScore:GetItemInSlot(slot)
	local link,equipslot, link2, ZGItemScore, ZGItemScore2,quality,slot1,slot2
	if id then
		slot1=slotToSlotNum(slot)
		link = GetInventoryItemLink("player", slot1)
		quality = select(3,GetItemInfo(id))
		equipslot = select(9,GetItemInfo(id))
		ZGItemScore = ItemScore:GetItemScore(id,nil,nil,link)

		if ZGV.ItemScore.playerdual2h and equipslot=="INVTYPE_2HWEAPON" then
			equipslot = "INVTYPE_WEAPON"
		end

		currentEquipped[id]={["link"]=link,["equipslot"]=equipslot,["score"]=ZGItemScore,["id"]=id}
	end
	if id2 then
		slot1,slot2=slotToSlotNum(slot)
		link2 = GetInventoryItemLink("player", slot2)
		quality = select(3,GetItemInfo(id2))
		ZGItemScore2 = ItemScore:GetItemScore(id2,nil,nil,link2)

		if ZGV.ItemScore.playerdual2h and equipslot=="INVTYPE_2HWEAPON" then
			equipslot = "INVTYPE_WEAPON"
		end

		currentEquipped[id2]={["link"]=link2,["equipslot"]=equipslot,["score"]=ZGItemScore2,["id"]=id}
	end
end

local Invtypes = {}
local function setCurrentEquipped()
	currentEquipped = {}
	

	for i=1, #ItemSlots do
		getItemScore(ItemSlots[i])
	end
	AutoEquipTable = { ["currentEquipped"]=currentEquipped, ["ItemSlots"]=ItemSlots, ["notUpgrades"]=ZGV.db.profile.notUpgrades}
end

local function EquipUpgrades(betterItem)
	if ZGV.Config.Running or ZGV.Tutorial.Running then schedule(5.0,"BAG_UPDATE",FindBestItem) return end -- If config or Tutorial is running then dont show items.
	
	local zgname = ZygorGuidesViewer_L("Main")["zgname"]

	local hasitem=false --Just a fix until system is redone.

	for slot,table in pairs(betterItem) do if betterItem[slot].id then hasitem=true break end end
	
	if UnitLevel("player") >= 10 and not GetSpecialization() and hasitem then --If we don't have a spec then don't show upgrades.
		StaticPopupDialogs["ZygorNoSpec"] = {
			text = "To utilize the "..zgname.." gear system, you must first select a specialization.",
			button1 = "Okay",
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
		}
		if GetTime()-NoSpecTimer > 3600 then
			StaticPopup_Show ("ZygorNoSpec")
			NoSpecTimer=GetTime()
		end
		return
	else
		NoSpecTimer=0 --reset timer once they have spec. Incase they decide to unlearn specs again...
	end
	
	totalUpgrades=0
	local slot,table
	if betterItem then
		for slot,table in pairs(betterItem) do
		totalUpgrades=totalUpgrades+1
			if betterItem[slot].over then
				if (ZGV.db.profile.autogear or autoEquipButton) and not ZGV.db.profile.autogearframe then
					savedUpgrade=betterItem[slot]
					equipItem()
					print(zgname..": Equipping ",betterItem[slot].link," over ", betterItem[slot].over..".")
				elseif ZGV.db.profile.autogearframe then
					showReplaceBox(betterItem[slot])
				end

			else
				if (ZGV.db.profile.autogear or autoEquipButton) and not ZGV.db.profile.autogearframe then
					savedUpgrade=betterItem[slot]
					equipItem()
					print(zgname..": Equipping ",betterItem[slot].link..".")
				elseif ZGV.db.profile.autogearframe then
					showEquipBox(betterItem[slot])
				end
			end
		end
	end
end

function FindBestItem()
	local itemid, quality, link, class, equipslot, bag, slot
	local betterItem = {}--[INVTYPE].id/.score/.link

	for bag=0, NUM_BAG_SLOTS do
		for slot=1, GetContainerNumSlots(bag) do
			itemid=GetContainerItemID(bag,slot)
			if itemid and not ZGV.db.profile.notUpgrades[itemid] then
				link=GetContainerItemLink(bag,slot)
				quality=select(3,GetItemInfo(itemid))
				equipslot=select(9,GetItemInfo(itemid))
				--class=select(6,GetItemInfo(itemid))
				if quality and equipslot then
					if quality>0 then
						if equipslot:match("^INV") ~= nil and 
						equipslot ~= "INVTYPE_BAG" and --bags are bad
						equipslot ~= "INVTYPE_AMMO" and --ammo even worse
						equipslot ~= "INVTYPE_TABARD" and -- don't allow tabards or shirts in.
						equipslot ~="INVTYPE_BODY" then 
							local bagGearScore,_,a = ItemScore:GetItemScore(itemid,nil,nil,link)
							if not bagGearScore then return end --returning is not the best option, but gets rid of any problem childs.

							if ZGV.ItemScore.playerdual2h and equipslot=="INVTYPE_2HWEAPON" then
								equipslot = "INVTYPE_WEAPON"
							end

							local equippedID,equippedID2 = ItemScore:GetItemInSlot(equipslot)							
							if equipslot=="INVTYPE_RANGEDRIGHT" then equipslot = "INVTYPE_WEAPON" end

							if equipslot=="INVTYPE_WEAPON" and (ZGV.ItemScore.playerdualwield or ZGV.ItemScore.playerdual2h) then
								if currentEquipped[equippedID] then
									if currentEquipped[equippedID].equipslot~="INVTYPE_2HWEAPON" then
										equippedID2=ItemScore:GetItemInSlot("INVTYPE_WEAPONOFFHAND")
									else
										bagGearScore=-1
										--itemid=0
									end

									else 
										equippedID2=ItemScore:GetItemInSlot("INVTYPE_WEAPONOFFHAND")
									end
							elseif (ZGV.ItemScore.playerdualwield or ZGV.ItemScore.playerdual2h) and equipslot=="INVTYPE_2HWEAPON" then
								if currentEquipped[equippedID] and (currentEquipped[equippedID].equipslot=="INVTYPE_WEAPON" or currentEquipped[equippedID].equipslot=="INVTYPE_WEAPONMAINHAND") then
									bagGearScore=-1 -- dont equip a 2h if dual wielding.
									--itemid=0
								end
							end

							if not ZGV.ItemScore.playerdualwield and not ZGV.ItemScore.playerdual2h then --Caster using 1H+OH or 2H
								local testID=0
								if equipslot=="INVTYPE_HOLDABLE" then
									testID=ItemScore:GetItemInSlot("INVTYPE_2HWEAPON") or 0
									if currentEquipped[testID] and currentEquipped[testID].equipslot=="INVTYPE_2HWEAPON" then
										bagGearScore=-1
										--itemid=0 --if a 2h is equipped then don't equip a offhand holdable item
									end
								elseif equipslot=="INVTYPE_2HWEAPON" then
									testID=ItemScore:GetItemInSlot("INVTYPE_HOLDABLE") or 0
									if currentEquipped[testID] and currentEquipped[equippedID] then
										bagGearScore=-1
										--itemid=0 -- don't equip a 2h if mainhand and offhand are equipped
									end
								end
							end

							if bagGearScore > 0 then
								if equippedID then
									if currentEquipped[equippedID] and bagGearScore > currentEquipped[equippedID].score then
										if not betterItem[equipslot] or bagGearScore > betterItem[equipslot].score then
											betterItem[equipslot] = {["link"]=link,["equipslot"]=equipslot,["score"]=bagGearScore,["id"]=itemid,["over"]=currentEquipped[equippedID].link, ["overid"]=currentEquipped[equippedID].id}
											currentEquipped[itemid] = {["link"]=link,["equipslot"]=equipslot,["score"]=bagGearScore,["id"]=itemid}
										end
									elseif equipslot~="INVTYPE_TRINKET" and equipslot~="INVTYPE_FINGER" and equipslot~="INVTYPE_WEAPON" then
										setNotUpgrade(itemid)
									end
								else
									if not betterItem[equipslot] or bagGearScore > betterItem[equipslot].score then
										betterItem[equipslot] = {["link"]=link,["equipslot"]=equipslot,["score"]=bagGearScore,["id"]=itemid}
										currentEquipped[itemid] = {["link"]=link,["equipslot"]=equipslot,["score"]=bagGearScore,["id"]=itemid}
									end
								end

								if equippedID2 then
									if currentEquipped[equippedID] and currentEquipped[equippedID2] and bagGearScore > currentEquipped[equippedID2].score and currentEquipped[equippedID2].score < currentEquipped[equippedID].score then
										betterItem[equipslot] = {["link"]=link,["equipslot"]=equipslot,["score"]=bagGearScore,["id"]=itemid,["bag"]=bag,["slot"]=slot,["spot2"]=true,["over"]=currentEquipped[equippedID2].link, ["overid"]=currentEquipped[equippedID].id}
										currentEquipped[itemid] = {["link"]=link,["equipslot"]=equipslot,["score"]=bagGearScore,["id"]=itemid}
									elseif currentEquipped[equippedID] and bagGearScore < currentEquipped[equippedID].score then
										setNotUpgrade(itemid)
									end
								elseif equipslot=="INVTYPE_TRINKET" or equipslot=="INVTYPE_FINGER" or (equipslot=="INVTYPE_WEAPON" and (ZGV.ItemScore.playerdualwield or ZGV.ItemScore.playerdual2h)) then
									if not betterItem[equipslot] or bagGearScore >= betterItem[equipslot].score then
										betterItem[equipslot] = {["link"]=link,["equipslot"]=equipslot,["score"]=bagGearScore,["id"]=itemid,["bag"]=bag,["slot"]=slot,["spot2"]=true,["over"]=nil}
										currentEquipped[itemid] = {["link"]=link,["equipslot"]=equipslot,["score"]=bagGearScore,["id"]=itemid}
									end
								end
							else
								setNotUpgrade(itemid)
							end
						end
					else
						setNotUpgrade(itemid)
					end
				end
			end
		end
	end
	EquipUpgrades(betterItem)
end

local function bagUpdate()
	if ZGV.db.profile.autogear or runTwice or findMore then
		runTwice=false
		FindBestItem()
	end
end

local function canDualWield()
	-- do they know Dual Wield? All but warriors.
	if (IsSpellKnown(674) and ZGV.ItemScore.playerclass~="HUNTER")  --Hunter, DK but we do not want hunters to dual wield.
	or IsSpellKnown(86629) --Shaman
	or IsSpellKnown(124146) then --Monk
		ZGV.ItemScore.playerdualwield=true
	else
		ZGV.ItemScore.playerdualwield=false
	end

	if IsSpellKnown(46917) then --warrior Titan's Grip. Special handling for 2h dual wielding
		ZGV.ItemScore.playerdual2h=true --fury dual wield 2h
	elseif IsSpellKnown(23588) then --Warrior onehand dual wield in fury. When is this prefered?
		ZGV.ItemScore.playerdualwield=true -- fury dual wield 1h
	end
end

local eventFrame=CreateFrame("Frame")

local function OnEvent(self,event)
	if event == "PLAYER_ENTERING_WORLD" then
		ItemScore:SetFilters()
		if not ItemScore.box then 
			createConfirmBox()--ConfirmDialog Box for autogear once at startup
		end
		canDualWield()
		schedule(3.0,"PLAYER_ENTERING_WORLD",setCurrentEquipped) -- allow game to finish setup before anything
		schedule(7.0,"BAG_UPDATE",bagUpdate)

		eventFrame:RegisterEvent("BAG_UPDATE") -- only want this even after the player has entered the world.
		eventFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	elseif event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_SPECIALIZATION_CHANGED" then
		ItemScore:SetFilters()
		setCurrentEquipped()
		canDualWield()
		ZGV.db.profile.notUpgrades = {}
		if ZGV.db.profile.autogear and not tasks["PLAYER_ENTERING_WORLD"] then schedule(.5,"ACTIVE_TALENT_GROUP_CHANGED",FindBestItem) end
	elseif event == "PLAYER_EQUIPMENT_CHANGED" then
		--schedule(.2,"PLAYER_EQUIPMENT_CHANGED",setCurrentEquipped)
		setCurrentEquipped()
	elseif event == "BAG_UPDATE" then
		if not tasks["PLAYER_ENTERING_WORLD"] then
			schedule(.1,"BAG_UPDATE",bagUpdate)
		end
	elseif event == "QUEST_COMPLETE" then --Quest item suggestion system
		GetQuestReward() -- questRewardInfoMissing
	elseif event == "QUEST_ITEM_UPDATE" then
		if questRewardInfoMissing then
			schedule(.01,"QUEST_ITEM_UPDATE",GetQuestReward)
		end
	elseif event == "QUEST_FINISHED" then
		RemoveGlow()
	end
end

tasks = {}
function schedule(time,name,func,...) --Different Scheduler because I want to know what tasks are in the queue sometimes.
	local t = {}
	t.func=func
	t.time=GetTime()+time
	tasks[name]=t
end

local function OnUpdate()
	for event,table in pairs(tasks) do
		local val=tasks[event]
		if val.time <=GetTime() then
			tasks[event]=nil
			val.func()
		end
	end
end

eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
eventFrame:RegisterEvent("QUEST_COMPLETE")
eventFrame:RegisterEvent("QUEST_FINISHED")
--eventFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
eventFrame:RegisterEvent("QUEST_ITEM_UPDATE")
eventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
eventFrame:SetScript("OnUpdate",OnUpdate)
eventFrame:SetScript("OnEvent",OnEvent)

-- Get item suggestions FROM CACHE.
-- Results: SC_NOTYET when the query has just been, or already was, scheduled for caching.
-- Proper results if it's in the cache already.
-- The cache will schedule re-requesting if needed.
function ItemScore:GetBestItems(invslot,count,verbose)
	invslot=invslot or "INVTYPE_WEAPON"
	count=count or 10

	if not self.cached then  self:CacheItems("fast")  end

	-- If we have a match in the cache, use that.
	results = self.ResultsCache:Get(invslot)
	if results==SC_NOTYET then return SC_NOTYET -- just/already scheduled
	elseif results then return results
	else error("WTF? No results, no cache, no nothing?") end

	--return ItemScore:GetBestItems_NoCache(invslot,count,playerclass,playerspec,playerlevel,verbose)
end

-- REMEMBER: invslot is USEFUL slot - for armor this doesn't matter, but for weapons it does.
-- Use INVSLOT_2HWEAPON to find two-handers (even if there's no two-hand "slot")
-- Use INVSLOT_WEAPONMAINHAND to find one-handers (any-hand or main-hand)
-- Use INVSLOT_WEAPONOFFHAND to find off-handers (any-hand or off-hand)
-- Use INVSLOT_RANGED to find off-handers (any-hand or off-hand)
-- Use INVSLOT_HOLDABLE, INVSLOT_SHIELD

function ItemScore:GetBestItems_NoCache(invslot,count,verbose,item_id_order)
	local results

	results={}
	local notyet=false
	for n,itemid in ipairs(itembase[invslot]) do
		local score,code,desc = self:GetItemScore(itemid, invslot)  -- not verbose, there'll be time for that

		--self:Debug(("Item score: |cff00ffff%d %s|r  Score: %s%s %s %s  (Spec: %s)"):format(itemid,GetItemInfo(itemid) or "?",(score>0 and "" or "|cffff8888"),score or "?", code or "", desc or "", playerclass..playerspec))

		-- If it's not cached, then keep trying all items (so that they get cached), but prepare to fail.
		if code==SC_NOTYET then  notyet=true  end
		if code==SC_NORULES then  return SC_NORULES,desc end

		if score>=0 or verbose then
			tinsert (results,{item=itemid,score=score,desc=desc,code=code})
		end
	end

	if item_id_order then  --debugging only!!
		table.sort(results,function(a,b)  return a.item<b.item  end)
	else
		table.sort(results,function(a,b)  return a.score>b.score  end)
	end

	if not verbose and #results>count then  while #results>count do tremove(results) end  end

	-- If some items were not cached, fail now.
	if notyet then return SC_NOTYET end

	if ZGV.db.profile.debug and verbose then
		self:Debug("Spec: ".. self.playerclass.. self.playerspec.."  Slot: "..invslot)
		for k,item in ipairs(results) do
			local name,link,quality,iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(item.item)
			if ZGV.db.profile.debug then
				if item_id_order then
					self:Debug(("|cffbbff00##%d. %s|r  Score: %s%.1f %s %s"):format(item.item,link,(item.score>0 and "" or "|cffff8888"),item.score or "-666", item.code or "", item.desc or ""))
				else
					self:Debug(("|cffbbff00#%d. %s|r##%d  Score: %s%.1f %s %s"):format(k,link,item.item,(item.score>0 and "" or "|cffff8888"),item.score or "-666", item.code or "", item.desc or ""))
				end
			end
			if item.score>0 then self:GetItemScore(item.item,invslot,verbose) end --just to print debug
		end
		self:Debug("END OF Spec: ".. self.playerclass.. self.playerspec.."  Slot: "..invslot)
	end

	return results
end

--[[
function ItemScore:ParseGuides()
	assert(false,"THIS IS DEPRECATED.")
	IS:Debug("Parsing Gear Guides...")
	for i,guide in ipairs(ZGV.registeredguides) do
		if guide.title:match("^Gear Guide") then
			guide:Parse(true)
			if guide.items then
				IS:Debug("Parsing gear from %d %s",guide.num,guide.title)
				for id,step in pairs(guide.items) do self.items_in_guides[id]=guide end
			else
				IS:Debug("Guide, y u no have gear!? %d %s",guide.num,guide.title)
			end
		end
	end
end
--]]

function ItemScore:ParseItemDatabase()
	if not self.Items then return end
	for dungeon,data in pairs(self.Items) do
		for i,itemset in ipairs(data) do
			for j,item in ipairs(itemset) do
				local boss = itemset.boss
				local quest = itemset.quest
				self.items_in_guides[item]={dungeon=data.dungeon,dungeonmap=data.dungeonmap,heroic=data.heroic,boss=boss,quest=quest}

				-- hack to update dungeons
				if data.dungeon and data.dungeonmap then
					local dungeon = ZGV.Dungeons[data.dungeon]
					if dungeon then
						dungeon.map=data.dungeonmap
						dungeon.floor=data.floor
					end
				end
			end
		end
	end
end

--[[
function ItemScore:ImproviseItems(from,to)
	local items = { 869, 9392, 65947, 1265, 18310, 9401, 13034, 9424, 62201, 33270, 33271 }
	for i,id in ipairs(items) do self.items_in_guides[id]={dungeon=4,boss=1} end
	for id=from,to do
		self.items_in_guides[id]={dungeon=4,boss=1}
	end
end

-- NOT adding current gear anymore; just compare upon results, that should be fine.
function ItemScore:AddCurrentGear()
	for i=1,25 do
		local id = GetInventoryItemID("player",i)
		if id and not self.items_in_guides[id] then
			self:AddItem(id)
			self.items_in_guides[id]={own=1}
		end
	end
end
--]]

--[[
	So here's how we handle item caching.
	Running through ALL the items concerned, we check if there's any unknowns.
	Each known item is removed from the queue (Lua handles nilling removals safely).
	Each unknown has already generated a cache request within the game, so we just total those, per run.
	If the number of cache requests exceeds a limit, we abort so as not to generate too many requests. The game should have that safe, but might not. Typical.
	The caching is restarted in the next frame, and again if an item is still nil - then it's still being cached, we count it as if it generated a new request
	- so that if a subsequent run gives the very same nils as before (typical if results didn't arrive yet), we don't send any new requests till those are done.

	In a nutshell: Check all items, abort after <limit> blanks, retry, never exceed <limit> blanks in one run.
--]]


ItemScore.cache_cached=0
ItemScore.cache_total=0
ItemScore.cache_done=0

--  - Threading removed here. Look in revisions <3769.

local request_limit = 500  -- starting low (500), set to 5000 to speed up at the cost of brief lockup
local this_turn_limit = 500

--local requests_pending = 0
local cache_queue = {}
ItemScore.cache_queue = cache_queue
local waited=0

local all_fine_until = 0


function ItemScore:AddItem(id,item)
	if not item then item = GetItemStatsWithTooltip(id) end
	if not item then return end
	for i,iid in ipairs(itembase.all) do if iid==id then return end end  -- already known
	local slot = item.info.equipslot

	tinsert(itembase.all,id)

	if slot:find("WEAPON") then
		tinsert(itembase.weapon,id)
	else
		tinsert(itembase.armor,id)
	end

	-- Most items (armor and jewelry) are identified by their slot. That works for them, but not for weapons.
	-- Weapons are a goddamn nightmare.

	if slot=="INVTYPE_ROBE" then tinsert(itembase["INVTYPE_CHEST"],id)
	elseif slot=="INVTYPE_RANGEDRIGHT" then tinsert(itembase["INVTYPE_RANGED"],id)
	elseif slot=="INVTYPE_WEAPON" then tinsert(itembase["INVTYPE_WEAPONMAINHAND"],id)  tinsert(itembase["INVTYPE_WEAPONOFFHAND"],id)
	else tinsert(itembase[slot],id)
	end
end

local function ItemScoreFrameCacheWorker()
	local self=ItemScore

	--[[
	if requests_pending>=request_limit then
		IS:Debug("Awaiting for request results.");
		waited=waited+1
		if waited>=20 then requests_pending=0 end  -- oh hell, let's spam it.
		return false
	end
	-- Let's spam it totally.
	--]]

	waited=0

	local requests_pending = 0
	local this_turn = 0

	if next(cache_queue) then
		for id,i in pairs(cache_queue) do while(1) do
			local item = GetItemStatsWithTooltip(id)

			if item then
				-- it's cached already? cool.
				cache_queue[id]=nil
				self.cache_done = self.cache_done + 1
				--IS:Debug("Cached %d %s",id,name)

				if not item.info.equipslot then  ItemCache[id]=nil  break  end
				-- trash non-equipment

				self:AddItem(id,item)
			else
				self.cache_cached = self.cache_cached + 1
				requests_pending = requests_pending + 1
				--IS:Debug("Requested %d",id)

				-- Too many items returned nils? Stop, hammertime.
				if requests_pending>=request_limit then return false,ItemScore.cache_done,ItemScore.cache_total,requests_pending end
			end

			this_turn = this_turn + 1
			if this_turn>this_turn_limit then return false,ItemScore.cache_done,ItemScore.cache_total,requests_pending end  -- Don't lag the game, caching or not.

			break
		end end
	end

	if not ItemScore.cached then
		if self.cache_done==self.cache_total then
			return true,ItemScore.cache_done,ItemScore.cache_total,requests_pending
		elseif requests_pending>0 then
			--IS:Debug("Caching turn done, but requests pending...")
			return false,ItemScore.cache_done,ItemScore.cache_total,requests_pending
		else
			--IS:Debug("WTF? Caching done but not all cached?")
			return true,ItemScore.cache_done,ItemScore.cache_total,requests_pending
		end
	end
end

local olddone=0
local samedone=0

local function ItemScoreFrameOnUpdate()
	if not ItemScore.cached and ItemScore.caching then
		local complete,done,total,pending = ItemScoreFrameCacheWorker()
		if ZGV.db.profile.debug_itemscore then IS:Debug("ItemScore caching: cached %d/%d, requested %d, pending: %d  (looped? %d)",done or -1,total or -1,ItemScore.cache_cached or -1,pending or -1,samedone) end
		if olddone==done then samedone=samedone+1 else samedone=0 end   olddone=done
		if samedone>100 then complete=true IS:Debug("FAILED TO CACHE, LOOPED.") end
		if complete then
			IS:Debug("ItemScore caching DONE.")
			ItemScore.cached = true
			ItemScore.caching = false
			--ItemScore.Frame:SetScript("OnUpdate",nil)
		end
	elseif not ItemScore.ResultsCache.cache_is_clean then
		ItemScore.ResultsCache:CacheOne()
	end
	if ItemScore.new_results_are_available then
		ItemScore:UpdateCharacterFramePane()
	end
end

--[[
local function ItemScoreFrameOnEvent(frame,event)
	if event=="GET_ITEM_INFO_RECEIVED" and not ItemScore.cached then
		requests_pending = max(0,requests_pending - 1)
		IS:Debug("Item info received, now requests pending: %d",requests_pending)
	end
end
--]]

function ItemScore:CacheItems(how)
	if how=="fast" then request_limit=5000 end

	if self.cached or self.caching or self.thread then return end
	--self:ParseGuides()
	self:ParseItemDatabase()
	--self.thread = coroutine.create(self.Threaded_CacheItems)

	self.caching = true

	-- prepare for caching
	ItemScore.cache_total = 0
	for id,guide in pairs(self.items_in_guides) do
		cache_queue[id]=1
		ItemScore.cache_total = ItemScore.cache_total + 1
	end
	IS:Debug("%d items set for caching",ItemScore.cache_total)

	--self.Frame:SetScript("OnEvent",ItemScoreFrameOnEvent)
	--self.Frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
end


-- Since it takes a while to analyze even one slot, we'll have to cache results.
ItemScore.ResultsCache = { results={}, cache_is_clean=true }

function ItemScore.ResultsCache:Get(invslot,nocache)
	local index = ("%s%d-%d %s"):format(ItemScore.playerclass,ItemScore.playerspec,ItemScore.playerlevel,invslot)
	local result = self.results[index]

	if nocache then result=nil end

	-- if results are ready, just return them...
	if result and type(result)=="table" then
		return result.result or result.code or SC_NOTYET
	end  -- could be results, could be SC_NOTYET in code, could be still queued.

	ItemScore:Debug("Requesting cache of "..index)

	-- ... but if no results are available, queue them up.
	self.results[index]={desc="queued"}
	self.cache_is_clean=false
	return SC_NOTYET
end

function ItemScore.ResultsCache:CacheOne()
	if self.cache_is_clean then return end
	for index,v in pairs(self.results) do
		if v.desc=="queued" or v.desc==SC_NOTYET then
			ItemScore:Debug("Caching queued "..index)
			local class,spec,level,slot = index:match("^(.-)(%d+)%-(%d+) (.+)$")
			ItemScore:SetFilters(class,tonumber(spec),tonumber(level))
			local result,desc = ItemScore:GetBestItems_NoCache(slot,10)
			local code
			if type(result)=="number" then result,code = nil,result end
			self.results[index] = {result=result,desc=desc,code=code}
			ItemScore.new_results_are_available = not not result
			if result then ItemScore:Debug("Notifying display of new results") end
			ItemScore:Debug("Cache is not yet clean")
			return true
		end
	end
	self.cache_is_clean=true
	ItemScore:Debug("Cache is now clean.")
end

function ItemScore.ResultsCache:Clear(key)
end



----------------- CHARACTER FRAME POPUPS

local function ZygorGearFinderButton_OnClick()
end

local CHAIN = ZGV.ChainCall

ItemSlots = { --localized above
	"INVTYPE_HEAD",
	"INVTYPE_NECK",
	"INVTYPE_SHOULDER",
	"INVTYPE_CLOAK",
	"INVTYPE_CHEST",
	"INVTYPE_WRIST",
	"INVTYPE_HAND",
	"INVTYPE_WAIST",
	"INVTYPE_LEGS",
	"INVTYPE_FEET",
	"INVTYPE_FINGER",
	"INVTYPE_TRINKET",
	"INVTYPE_2HWEAPON",
	"INVTYPE_WEAPONMAINHAND",
	"INVTYPE_WEAPONOFFHAND",
	"INVTYPE_SHIELD",
	"INVTYPE_HOLDABLE",
	"INVTYPE_RANGED",
}
if not ZGV.Expansion_Mists then tinsert(ItemSlots,"INVTYPE_RELIC") end

function ItemScore:ItemSlotToInvSlot(itemslot)
end

function ItemScore:GetItemInSlot(itemslot)
	itemslot = itemslot:gsub("^INVTYPE_","")
	itemslot = itemslot:sub(1,1) .. itemslot:sub(2):lower()

	if itemslot=="Hand" then itemslot="Hands"
	elseif itemslot=="Cloak" then itemslot="Back"
	elseif itemslot=="Robe" then itemslot="Chest" -- in case we try to compare to a robe item
	-- remove these once we're deep into Expansion_Mists
	elseif itemslot=="Relic" then -- relic users use ranged slot, otherwise we most certainly don't have a relic.
		if UnitHasRelicSlot("player") then itemslot="Ranged" else return end
	elseif itemslot=="Ranged" then -- relic users don't use ranged.
		if UnitHasRelicSlot("player") then return else itemslot="MainHand" end
	-- end removal
	elseif itemslot=="Shield" or itemslot=="Weaponoffhand" or itemslot=="Holdable" then itemslot="SecondaryHand"
	elseif itemslot=="Weapon" or itemslot=="Weaponmainhand" or itemslot=="2hweapon" then itemslot="MainHand"
	elseif itemslot=="Rangedright" or itemslot=="Thrown" then itemslot="MainHand"
	end

	local slot1,slot2,_,relic

	if itemslot=="Trinket" then
		slot1 = GetInventorySlotInfo("Trinket0Slot")
		slot2 = GetInventorySlotInfo("Trinket1Slot")
	elseif itemslot=="Finger" then
		slot1 = GetInventorySlotInfo("Finger0Slot")
		slot2 = GetInventorySlotInfo("Finger1Slot")
	else
		slot1,_,_ = GetInventorySlotInfo(itemslot.."Slot")
	end

	local id1,id2
	if slot1 then id1 = GetInventoryItemID("player",slot1) end
	if slot2 then id2 = GetInventoryItemID("player",slot2) end

	return id1,id2
end

local shiftkeydown,ctrlkeydown

local function SetUp_ZygorGearFinderFrame()
	--[[
	frame.ZygorGearFinderButton = CreateFrame("BUTTON","ZGVCharacterGearFinderButton",frame,"UIPanelButtonTemplate")
	ZGV.ChainCall (frame.ZygorGearFinderButton) :SetSize(30,45) :SetPoint("TOPRIGHT",frame,"TOPRIGHT",-147,-22) :SetText("ZGF") :SetScript("OnClick",ZygorGearFinderButton_OnClick) :Show()
	--]]

	local frame = PaperDollFrame

	-- Sidebar tab button:
	--tinsert(PAPERDOLL_SIDEBARS,{name=L['Zygor Gear Finder'],frame="ZygorGearFinderFrame",icon=ZGV.DIR.."\\Skins\\zglogo",		texCoords = {0,1,0,0.25} })
	tinsert(PAPERDOLL_SIDEBARS,{name=L['Zygor Gear Finder'],frame="ZygorGearFinderFrame",icon=ZGV.DIR.."\\Skins\\guideicons-big",		texCoords = {0,0.25,0.75,1.0} })

	PaperDollSidebarTab4 = CreateFrame("BUTTON","ZGVCharacterGearFinderButton",PaperDollSidebarTabs,"PaperDollSidebarTabTemplate",4)
	--PaperDollSidebarTab4:SetPoint("RIGHT",PaperDollSidebarTab1,"LEFT",-4,0)
	PaperDollSidebarTab4:SetPoint("LEFT",PaperDollSidebarTab3,"RIGHT",4,0)
	PaperDollSidebarTab4:SetScript("OnLoad",nil)
	PaperDollSidebarTab4.Icon:SetSize(24,24)
	PaperDollSidebarTab4.Icon:SetPoint("BOTTOM",PaperDollSidebarTab4,"BOTTOM",0,2)
	PaperDollSidebarTab3:SetPoint("BOTTOMRIGHT",PaperDollSidebarTabs,"BOTTOMRIGHT",-60,0)
	frame.ZygorGearFinderButton = PaperDollSidebarTab4

	PaperDollSidebarTabs:SetWidth(168+30)

	ZygorGearFinderAutoEquipButton = CHAIN(CreateFrame("Button", "ZygorGearFinderAutoEquipButton", frame, nil))
		:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",10,8) :SetSize(25,25)
		:SetScript("OnClick",function() NoSpecTimer=0 runTwice=true autoEquipButton=true FindBestItem() runTwice=false autoEquipButton=false end)
		:SetNormalTexture(ZGV.DIR.."\\Skins\\guideicons-big")
		:SetScript("OnEnter",function(self) CHAIN(GameTooltip):SetOwner(self,"ANCHOR_RIGHT") :SetText("Equip Best Items") :Show() end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
		.__END
	ZygorGearFinderAutoEquipButton:GetNormalTexture():SetTexCoord(0,0.25,0.25,0.50)

	ZygorGearFinderPopoutButton = CHAIN(CreateFrame("Button", "ZygorGearFinderPopoutButton", frame, nil))
		:SetPoint("TOPRIGHT",frame,"TOPRIGHT",-10,-32) :SetSize(25,25)
		:SetScript("OnClick",function() CharacterFrameExpandButton:Click() PaperDollSidebarTab4:Click() end)
		:SetNormalTexture(ZGV.DIR.."\\Skins\\guideicons-big")
		:SetScript("OnEnter",function(self) CHAIN(GameTooltip):SetOwner(self,"ANCHOR_RIGHT") :SetText("Zygor Gear Guides") :Show() end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
		.__END
	ZygorGearFinderPopoutButton:GetNormalTexture():SetTexCoord(0,0.25,0.75,1.0)


	-- Sidebar contents:

	ZygorGearFinderFrame = CHAIN(CreateFrame("ScrollFrame","ZygorGearFinderFrame",frame,"UIPanelScrollFrameTemplate2"))
		:SetPoint("TOPLEFT",CharacterFrameInsetRight,"TOPLEFT",4,-4) :SetPoint("BOTTOMRIGHT",CharacterFrameInsetRight,"BOTTOMRIGHT",-27,2)
		:Hide()
		.__END

	ZygorGearFinderFrame.ScrollChild = CHAIN(CreateFrame("FRAME","ZygorGearFinderFrameScrollChild",ZygorGearFinderFrame))
		:SetSize(170,0)
		:SetPoint("TOPLEFT")
		.__END

	ZygorGearFinderFrame:SetScrollChild(ZygorGearFinderFrame.ScrollChild)

	--[[
	ZygorGearFinderFrame.scrollBar = CHAIN(CreateFrame("SLIDER","ZygorGearFinderFrameScrollBar",ZygorGearFinderFrame,"HybridScrollBarTemplate"))
		:SetPoint("TOPLEFT",ZygorGearFinderFrame,"TOPRIGHT",4,-13)
		:SetPoint("BOTTOMLEFT",ZygorGearFinderFrame,"BOTTOMRIGHT",4,14)
		:SetFrameLevel(CharacterFrameInsetRight:GetFrameLevel()+1)
		.__END
	ZygorGearFinderFrame.scrollBar.doNotHide=1
	--]]

	ZygorGearFinderFrame.Header = CHAIN(ZygorGearFinderFrame.ScrollChild:CreateFontString(nil,nil,"SystemFont_Shadow_Small"))
		:SetPoint("TOPLEFT",ZygorGearFinderFrame.ScrollChild,"TOPLEFT",0,-1) :SetPoint("RIGHT",ZygorGearFinderFrame.ScrollChild,"RIGHT",0,0)
		:SetJustifyH("CENTER") :SetJustifyV("TOP")
		:SetText(L['itemfinder_header'])
		:SetFont(ZGV.DIR.."\\Skins\\SegoeUI.TTF",12)
		:SetTextColor(1,0.8,0)
		.__END

	--[[
	ZygorGearFinderFrame.RefreshButton = CHAIN(CreateFrame("BUTTON","ZygorGearFinderFrame_Refresh", ZygorGearFinderFrame.ScrollChild, "ZygorGuidesViewer_Default_Button"))
		:SetBackdrop({bgFile=nil,edgeFile=ZGV.DIR.."\\Skins\\Default\\midnight\\border-glow", tile = true, edgeSize=10, tileSize = 10, insets = { left = 10, right = 10, top = 10, bottom = 10 }})  :SetBackdropBorderColor(1,1,1,0)
		:SetSize(70,20)
		:SetPoint("TOP",ZygorGearFinderFrame.Header,"BOTTOM",0,-2)
		:SetAttribute("tooltip",L['itemfinder_refresh_desc'])
		:SetText(L['itemfinder_refresh'])
		:SetScript("OnClick",function(self,but)
			ItemScore:RefreshResults()
		end)
		.__END
	--]]

	-- set up "best dungeon" button
	local bestdungbutton = CHAIN(CreateFrame("BUTTON","ZygorGearFinderFrame_BestDungeon", ZygorGearFinderFrame.ScrollChild ,"ZygorGearFinderFrame_ItemFrame"))
		:SetPoint("TOPLEFT",ZygorGearFinderFrame.ScrollChild,"TOPLEFT",0,-ZygorGearFinderFrame.Header:GetHeight()-5) :SetPoint("RIGHT",ZygorGearFinderFrame.ScrollChild,"RIGHT",0,0)
		.__END
	bestdungbutton.BgTop:Hide()
	bestdungbutton.BgBottom:Hide()
	bestdungbutton.BgMiddle:Hide()
	bestdungbutton.Slot:SetFont(ZGV.DIR.."\\Skins\\SegoeUI.TTF",12)  --STANDARD_TEXT_FONT
	bestdungbutton.Label.Text:SetFont(ZGV.DIR.."\\Skins\\SegoeUI.TTF",11)
	ZGV.AssignButtonTexture(bestdungbutton.Dungeon,ZGV.SkinDir.."titlebuttons",11,16)

	ZygorGearFinderFrame.BestDungButton = bestdungbutton


	-- set up item buttons
	ZygorGearFinderFrame.Items = {}

	for i,slot in ipairs(ItemSlots) do
		local itembutton = CHAIN(CreateFrame("BUTTON","ZygorGearFinderFrame_Item"..i, ZygorGearFinderFrame.ScrollChild ,"ZygorGearFinderFrame_ItemFrame"))
			.__END
		--[[
		local itembutton = CHAIN(ZygorGearFinderFrame:CreateFontString(nil,nil,"SystemFont_Shadow_Small"))
			:SetJustifyH("LEFT") :SetJustifyV("TOP")
			--:SetFont(STANDARD_TEXT_FONT,9)
			--:SetTextColor(1.0,0.8,0.0)
			:SetText(slot)
			:SetSize(0,20)
			.__END
			--]]
		itembutton.Slot:SetFont(ZGV.DIR.."\\Skins\\SegoeUI.TTF",12)  --STANDARD_TEXT_FONT
		--itembutton.Slot:SetShadowColor(1,1,1,1)  --STANDARD_TEXT_FONT
		--itembutton.Slot:SetShadowOffset(0.8,0)  --STANDARD_TEXT_FONT
		itembutton.Label.Text:SetFont(ZGV.DIR.."\\Skins\\SegoeUI.TTF",11)
		ZGV.AssignButtonTexture(itembutton.Dungeon,ZGV.SkinDir.."titlebuttons",11,16)
		itembutton.Dungeon:SetFrameLevel(itembutton.Label:GetFrameLevel()+1)
		if i==1 then
			CHAIN(itembutton) :SetPoint("TOPLEFT",bestdungbutton,"BOTTOMLEFT",0,-6) :SetPoint("RIGHT",ZygorGearFinderFrame.ScrollChild,"RIGHT",0,0)
		else
			CHAIN(itembutton) :SetPoint("TOPLEFT",ZygorGearFinderFrame.Items[i-1],"BOTTOMLEFT",0,0) :SetPoint("RIGHT",ZygorGearFinderFrame.ScrollChild,"RIGHT",0,0)
		end

		itembutton.slot = slot

		if ZGV.db.profile.debug then
			local testbutton = CHAIN(CreateFrame("BUTTON","ZygorGearFinderFrame_Test"..i, itembutton, "UIPanelButtonTemplate"))
				:SetSize(10,10)
				:SetPoint("BOTTOMRIGHT")
				:SetScale(0.7)
				:SetScript("OnClick",function(self,but)
					local itype,id,link = GetCursorInfo()
					local slot = self:GetParent().slot
					if itype=="item" then ItemScore:GetItemScore(id,slot,"verbose") return end
					--else
					ItemScore:GetBestItems_NoCache(slot,50,"verbose",IsShiftKeyDown())
					ItemScore:Debug("OWN ITEM(s):")
					local item1,item2 = ItemScore:GetItemInSlot(slot)
					if item1 then ItemScore:GetItemScore(item1,slot,"verbose") end
					if item2 then ItemScore:GetItemScore(item2,slot,"verbose") end
				end)
				:SetScript("OnENTER",function(self) local tip=ShoppingTooltip1  tip:SetOwner(self,"RIGHT") tip:SetText("Click to test\nShift-click to sort by ID") tip:Show() end)
				.__END
		end

		ZygorGearFinderFrame.Items[i] = itembutton
	end

	ZygorGearFinderFrame:SetScript("OnLoad",function(self)
		--HybridScrollFrame_OnLoad(self)
		ScrollFrame_OnLoad(self);
		ScrollFrame_OnScrollRangeChanged(self);
		self.ScrollBar.scrollStep = 50;
		self.initialOffsetY = 0
	end )
	ZygorGearFinderFrame:SetScript("OnShow",function(self)
		--HybridScrollFrame_CreateButtons(self, "PlayerTitleButtonTemplate")
		ItemScore:RefreshResults()
	end )
	ZygorGearFinderFrame:SetScript("OnUpdate",function(self)
		local function maybeshowbutton(but)
			if but:IsShown() then
				if but.dungeonData and but:IsMouseOver() then
					if not but.ismouseover then
						UIFrameFadeIn(but.Dungeon, 0.2, but.Dungeon:GetAlpha(), 1.0)
					end
					if shiftkeydown~=IsShiftKeyDown() then
						but:GetScript("OnEnter")(but)
						shiftkeydown=IsShiftKeyDown()
					end
					if ctrlkeydown~=IsControlKeyDown() then
						ctrlkeydown=IsControlKeyDown()
						if ctrlkeydown then ShowInspectCursor() else ResetCursor() end
					end
				elseif not but:IsMouseOver() and but.ismouseover then
					UIFrameFadeOut(but.Dungeon, 0.2, but.Dungeon:GetAlpha(), 0.0)
				end
				but.ismouseover=but:IsMouseOver()
			end
		end
		for b,but in ipairs(self.Items) do maybeshowbutton(but) end
		maybeshowbutton(ZygorGearFinderFrame.BestDungButton)
	end )
end

local function CharacterFrame_OnShow_Hook()
	if not ZygorGearFinderFrame then
		SetUp_ZygorGearFinderFrame()
	end

	if CharacterFrame.Expanded then ZygorGearFinderPopoutButton:Hide() else ZygorGearFinderPopoutButton:Show() end

	for i,itembutton in ipairs(ZygorGearFinderFrame.Items) do  itembutton.dirty = true  end
end

function ItemScore:RefreshResults()
	ItemScore.ResultsCache.results = {}

	-- update/cache suggestions
	for i,slot in ipairs(ItemSlots) do
		ZGV.ItemScore:GetBestItems(v)
	end

	for i,itembutton in ipairs(ZygorGearFinderFrame.Items) do  itembutton.dirty = true  end

	ItemScore:UpdateCharacterFramePane()
end

function ItemScore:UpdateCharacterFramePane()
	if not ZygorGearFinderFrame or not ZygorGearFinderFrame:IsVisible() then return end

	self:Debug("Display: new results are supposedly in")

	self.new_results_are_available = nil

	local classrules = rules[self.playerclass][self.playerspec]
	local some_are_unknown = false
	for i,slot in ipairs(ItemSlots) do
		local itembutton = ZygorGearFinderFrame.Items[i]

		if itembutton.dirty then
			--print(slot,"dirty",classrules.itemtypes.TH_STAFF,classrules.itemtypes.TH_SWORD)

			-- reject unavailable types
			local types = classrules.itemtypes
			if  (slot=="INVTYPE_SHIELD" and not types.SHIELD)
			or (slot=="INVTYPE_RELIC" and not types.RELIC)
			or (slot=="INVTYPE_RANGED" and not types.BOW and not types.WAND)
			or (slot=="INVTYPE_THROWN" and not types.THROWN)
			or (slot=="INVTYPE_HOLDABLE" and not types.MISCARM)
			or (slot=="INVTYPE_WEAPONOFFHAND" and not types.MISCWEAP)
			or (slot=="INVTYPE_2HWEAPON" and not types.TH_STAFF and not types.TH_SWORD)
			then
				itembutton:Hide()
				itembutton:SetHeight(0.001)
				itembutton.dirty = nil
				--print(slot,"rejected")
			else
				itembutton:Show()
				itembutton:SetHeight(35)
				itembutton:SetSlot(slot)

				local result = ZGV.ItemScore:GetBestItems(slot,10)

				if result==SC_NOTYET then

					itembutton:SetText("...")
					some_are_unknown = true
					-- staying dirty

				elseif type(result)=="table" then
					if result[1] then

						local bestitem = result[1]
						local bestitemid = bestitem.item

						-- gauge own item(s), for comparison
						local item1,item2 = self:GetItemInSlot(slot)
						if item2 and not item1 then item1,item2=item2,item1 end
						local score1,info1,score2,info2

						if slot=="INVTYPE_WEAPONMAINHAND" then  -- exclude twohands from comparison; their stats trump onehanders always, so no onehanders would ever pop up
							local ownitemdata = GetItemStatsWithTooltip(item1)
							if ownitemdata and ownitemdata.info.equipslot=="INVTYPE_2HWEAPON" then  -- it's a twohander and mustn't be compared at all
								item1,score1=nil,0
							end
						end

						-- get scores for own items
						if item1 then  score1,info1 = self:GetItemScore(item1,slot)  end   score1=score1 or 0
						if item2 then  score2,info2 = self:GetItemScore(item2,slot)  end   score2=score2 or 0
						if score1>score2 and score2>0 then score1,score2=score2,score1 end
						-- now we have the worse item's score in score1, the better's in score2. Either is -1 or 0 if there's no (valid) item there.

						--print("slot",slot,"own",item1,item2,"scored",score1,score2)

						if bestitem.score>score1 or (score2>0 and bestitem.score>score2) then
							local data = self.items_in_guides[bestitemid]

							if not data then error("wtf, no data for item? "..bestitemid) end

							itembutton:SetItem(bestitemid)
							assert(type(data.dungeon)=="number","Item "..bestitemid.." has weird dungeon "..type(data.dungeon)..": "..data.dungeon)
							itembutton:SetDungeon(data.dungeon,data.boss,data.quest)
							itembutton:SetAlpha(1.0)
							itembutton.scorediff = bestitem.score-score1
							-- valid suggestion
						else
							itembutton:SetText(ZGV.L['itemfinder_noupgrade'],ZGV.L['itemfinder_noupgrade_desc'])
							itembutton:SetItem()
							itembutton:SetDungeon()
							itembutton:SetAlpha(0.5)
							itembutton.scorediff = nil
						end
					else
						itembutton:SetText(ZGV.L['itemfinder_noitems'],ZGV.L['itemfinder_noitems_desc'])
					end

					itembutton.dirty = nil

				else
					itembutton:SetText("ERROR, wtf")
				end
			end
		end
	end

	if some_are_unknown then
		ZygorGearFinderFrame.BestDungButton:SetDungeon()
		ZygorGearFinderFrame.BestDungButton:SetHeight(35)
		ZygorGearFinderFrame.BestDungButton:SetText("...")
		ZygorGearFinderFrame.BestDungButton:Show()
	else

		-- find the best dungeon

		local bestdungs = {}
		local bestdungitems = {}

		for i,itembutton in ipairs(ZygorGearFinderFrame.Items) do
			if itembutton:IsShown() and itembutton.item then
				local data = self.items_in_guides[itembutton.item]
				bestdungs[data.dungeon] = (bestdungs[data.dungeon] or 0) + itembutton.scorediff
				if not bestdungitems[data.dungeon] then bestdungitems[data.dungeon]={} end
				tinsert(bestdungitems[data.dungeon],{id=itembutton.item,scorediff=itembutton.scorediff})
			end
		end

		local bestdung,bestn=nil,0
		for dung,dungn in pairs(bestdungs) do if dungn>bestn then bestdung,bestn=dung,dungn end end

		if bestdung then
			ZygorGearFinderFrame.BestDungButton.Slot:SetText("BEST DUNGEON:")
			ZygorGearFinderFrame.BestDungButton:SetDungeon(bestdung)
			ZygorGearFinderFrame.BestDungButton.bestitems = bestdungitems[bestdung]
			ZygorGearFinderFrame.BestDungButton:SetText(ZGV.Dungeons[bestdung]:GetName())
			ZygorGearFinderFrame.BestDungButton:SetHeight(35)
			ZygorGearFinderFrame.BestDungButton:Show()
		else
			ZygorGearFinderFrame.BestDungButton:SetHeight(0.001)
			ZygorGearFinderFrame.BestDungButton:Hide()
		end
	end


	-- update scroll height
	local totalHeight = 40
	for b,but in ipairs(ZygorGearFinderFrame.Items) do
		if but:IsShown() then
			totalHeight = totalHeight + but:GetHeight()
		end
	end
	ZygorGearFinderFrame.ScrollChild:SetHeight(totalHeight+10-(CharacterStatsPane.initialOffsetY or 0));
end

ItemScore.ItemFrameProto = {}
-- UI object script handlers and methods
function ItemScore.ItemFrameProto.OnLoad(self)
	self.SetItem = ItemScore.ItemFrameProto.SetItem
	self.SetText = ItemScore.ItemFrameProto.SetText
	self.SetDungeon = ItemScore.ItemFrameProto.SetDungeon
	self.SetSlot = ItemScore.ItemFrameProto.SetSlot
	self.Dungeon:SetScript("OnEnter",ItemScore.ItemFrameProto.Dungeon_OnEnter)
	self.Dungeon:SetScript("OnLeave",ItemScore.ItemFrameProto.Dungeon_OnLeave)
	self.Dungeon:SetScript("OnClick",ItemScore.ItemFrameProto.Dungeon_OnClick)
	self:RegisterForClicks("AnyUp")
end

function ItemScore.ItemFrameProto.SetItem(self,id)
	self.item = id
	if id then
		local stats = GetItemStatsWithTooltip(id)
		local name = stats and stats.info and stats.info.name or "?"
		self:SetText(stats and stats.info and (stats.info.link:gsub("[%[%]]","")) or "?")
	end
end
function ItemScore.ItemFrameProto.SetText(self,text,tip)
	self.Label.Text:SetText(text)
	self.tip = tip
end
function ItemScore.ItemFrameProto.SetDungeon(self,dungid,boss,quest)
	self.Dungeon:SetText(">")
	local dungeon = ZGV.Dungeons[dungid]
	if dungeon then
		self.dungeonName = dungeon:GetName()
		self.dungeonData = dungeon
	else
		self.dungeonName = "?"
		self.dungeonData = nil
	end
	self.heroic = heroic

	self.boss = boss
	self.quest = quest
end
function ItemScore.ItemFrameProto.SetSlot(self,slot)
	if slot=="INVTYPE_SHIELD" then slot="SHIELDSLOT" end
	self.Slot:SetText(_G[slot]:upper())
end

function ItemScore.ItemFrameProto.Dungeon_OnClick(self,but)
	local p=self:GetParent()
	local dmap = p.dungeonData and p.dungeonData.map
	if dmap then
		for g,guide in ipairs(ZGV.registeredguides) do
			if guide.dungeon==dmap then ZGV:SetGuide(guide) return end
		end
		ZGV:Error("How odd. We don't seem to have a guide for "..GetMapNameByID(dmap))
	end
end
function ItemScore.ItemFrameProto.Dungeon_OnLeave(self)
	local tip = GameTooltip
	tip:Hide()
end
function ItemScore.ItemFrameProto.Dungeon_OnEnter(self)
	local p=self:GetParent()
	local dung = p.dungeonData
	local tip = GameTooltip
	if dung then
		local L = ZygorGuidesViewer.L
		tip:SetOwner(self,"TOP")
		if p.boss or p.quest then
			-- normal item button
			tip:SetText(L['itemfinder_openguide_dung']:format(dung:GetName()))
			--[[
			if p.dungeonData and p.dungeonData.heroic then
				GameTooltip:SetText(L['itemfinder_openguide_dung_h']:format(dung:GetName()))
			else
				GameTooltip:SetText(L['itemfinder_openguide_dung']:format(dung:GetName()))
			end
			--]]

			if p.boss then
				tip:AddLine(L['itemfinder_openguide_boss']:format(ZGV.Localizers:GetTranslatedNPC(p.boss)))
			end
			if p.quest then
				if type(p.quest)=="table" then p.quest=p.quest[1] end
				local quest = ZGV.Localizers:GetQuestData(p.quest)
				if quest and quest.title then
					tip:AddLine(L['itemfinder_openguide_quest']:format(quest.title))
				else
					tip:AddLine(L['itemfinder_openguide_quest']:format("?"))
				end
			end
		end
		tip:AddLine(L['itemfinder_openguide_open'])
		tip:Show()
	end
end


-- TESTS --

function ItemScore:TestItem(itemid,class,spec,level)
	self:SetFilters(class,spec,level)
	local score,info = self:GetItemScore(itemid)
	print(("Spec: %s  Item: %d %s  Score: %s%s %s"):format(class..spec,itemid,GetItemInfo(itemid) or "?",(score>0 and "" or "|cffff8888"),score or "?", info or "?"))
end

function ItemScore:Test(...)
	self:TestItem(869,...) --Dazzling Longsword
	self:TestItem(9392,...) --Annealed Blade
	self:TestItem(65947,...) --Platinum Sword
	self:TestItem(1265,...) --Scorpion Sting
	self:TestItem(18310,...) --Fiendish Machete
	self:TestItem(9401,...) --Nordic Longshank
	self:TestItem(13034,...) --Speedsteel Rapier
	self:TestItem(9424,...) --Ginn-Su Sword
	self:TestItem(62201,...) --Kaartish's Sword
	self:TestItem(33270,...) --Mariner's Sword
	self:TestItem(33271,...) --Battlecaster's Edge
end

function ItemScore:TestItemForAll(itemid)
	local _
	if not itemid then local _,itemlink=GameTooltip:GetItem() itemid=itemlink and itemlink:match("item:(%d+)") end
	if not itemid then local typ,_,itemlink=GetCursorInfo() if typ=="item" then itemid=itemlink:match("item:(%d+)") end end
	if not itemid then print("Nothing to check.") return end
	for class,classrules in pairs(rules) do
		for spec,rule in pairs(classrules) do
			self:TestItem(itemid,class,spec)
		end
	end
end

function ItemScore:TestGetBestItems(class,count)
	local results,desc = GetBestItems(class,count, "verbose")
	if results==SC_NOTYET then print ("Caching, please retry.") return end
	if results==SC_NORULES then print ("ERROR: ",desc) return end

	if type(results)~="table" then print ("ERROR: ",results,desc) return end
	for i,res in ipairs(results) do
		local name,link,quality,iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(res.item)
		print(("%d. %s #%d [score: %.1f]"):format(i,link,res.item,res.score))
	end
end

function ItemScore:TestTip()
	local id = tonumber(select(2,GameTooltip:GetItem()):match(":(%d+)"))
	local info = GetItemStatsWithTooltip(id)
	if info then
		print (self:GetItemScore(id))
	end
end

function ItemScore:DumpItemsForSlot(slot)
	for i,id in ipairs(self.itembase[slot]) do
		local stats = GetItemStatsWithTooltip(id)
		local score = self:GetItemScore(id,slot,true)
		if score>-1 then print("==",score) end
	end
end

tinsert(ZGV.startups,function(self)
	if not ItemScore.Items then return end

	ItemScore.Frame = CreateFrame("FRAME","ZGVItemScoreFrame")
	ItemScore.Frame:SetScript("OnUpdate",ItemScoreFrameOnUpdate)

	local f = CharacterFrame:GetScript("OnShow")
	CharacterFrame:SetScript("OnShow",function(...) f(...)  CharacterFrame_OnShow_Hook(...) end )
	hooksecurefunc("CharacterFrame_Collapse",CharacterFrame_OnShow_Hook)
	hooksecurefunc("CharacterFrame_Expand",CharacterFrame_OnShow_Hook)

	-- dummy data, if missing
	ItemScore:CacheItems()
	ItemScore:SetFilters()

	-- test GetItemInSlot
	assert(ItemScore:GetItemInSlot("INVTYPE_WEAPON")==ItemScore:GetItemInSlot("INVTYPE_2HWEAPON"),"GetItemInSlot failed")

	--self:ScheduleRepeatingTimer("TryToDisplayCreature", 1)
end)