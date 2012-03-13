local L = LibStub("AceLocale-3.0"):NewLocale("Broker_XPTracker","enUS",true)
if not L then return end

L["Total time played:"] = true
L["Time on this level:"] = true
L["Time this session:"] = true
L["XP Status:"] = true
L["Rest XP:"] = true
L["XP/hour this level:"] = true
L["XP/hour this session:"] = true
L["Time to level for this level:"] = true
L["Time to level for this session:"] = true
L["RemXP: "] = true
L["Rest: "] = true
L["XP/h: "] = true
L["Etl: "] = true
L["Party"] = true
L["Character"] = true
L["Lvl"] = true
L["XP-Status"] = true
L["Rest bonus"] = true
L["XP/h"] = true
L["Guild"] = true
L["Ding! Name has leveled to Level time ago"] = function ( name, classcolor, level, timeLevelUp) return "|cffffff00Ding!" .. classcolor .. name .."|cffffffff has leveled to |cff90ff90"..level.."|cffffffff "..timeLevelUp.." ago" end
L["LDB Text"]= true
L["Remaining XP"]= true
L["if checked the remaining XP for this level is shown in LDB text"]= true
L["if checked the rest bonus is shown if there is any"]= true
L["XP per Hour"]= true
L["if checked the XP per hour rate is shown"]= true
L["Expected time to level up"]= true
L["if checked the expected time to level based on session is shown"]= true
L["Sync"]= true
L["Show Party Progress"]= true
L["Show Guild Progress"]= true
L["Send to guild"]= true
L["Send to party"]= true
L["List Fadeout"]= true
L["Notify on level up"]= true
L["notifies if someone has a level up"]= true
L["Levelup Fadeout"]= true
L["Levelup Notify Sound"] = true
L["GuildXP"] = true
L["leveling disabled"] = true
L["maxLevel reached"] = true
