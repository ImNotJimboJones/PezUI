﻿local L = LibStub("AceLocale-3.0"):NewLocale("MoncaiQuestTracker", "zhTW", true)
if L then	
	L["(.*)(: ?.*)"] = "(.*)(: ?.*)"
	L["([^ ]+)$"] = "([^ ]+)$"
	L["are finished"] = "已經完成"
	L["Command not found"] = "找不到指令"
	L["Could not add buddy, buffer full"] = "Could not add buddy, buffer full" -- Requires localization
	L[".*: (%d+) ?/ ?%d+"] = ".*: (%d+) ?/ ?%d+"
	L["(.*): (%d+) ?/ ?(%d+)"] = "(.*): (%d+) ?/ ?(%d+)"
	L["(.*): %d+ ?/ ?%d+"] = "(.*): %d+ ?/ ?%d+"
	L["[%d] %s"] = "[%d] %s"
	L["Goodbye, "] = "再見，"
	L["has "] = "已經"
	L["Hey, you're working on %s, I'll add it!"] = "Hey, you're working on %s, I'll add it!" -- Requires localization
	L["is finished"] = "已經完成"
	L["is finished with %s "] = "用%s來完成"
	L["Let's Party!"] = "Let's Party!" -- Requires localization
	L["Moncaí Questtracker"] = "Moncaí Questtracker"
	L["Moncaí's Quest Tracker disabled"] = "Moncaí Questtracker禁用"
	L["Moncaí's Quest Tracker enabled"] = "Moncaí Questtracker啟用"
	L["Moncaí's Quest Tracker loading, stand by..."] = "Moncaí's Quest Tracker正在載入，請稍後..."
	L["mqt"] = "mqt" -- Requires localization
	L["need"] = "需要"
	L["needs"] = "需要"
	L["needs %1$d more %2$s "] = "needs %1$d more %2$s " -- Requires localization
	L["PANIC!"] = "PANIC!" -- Requires localization
	L["QuestHelper integration active"] = "QuestHelper integration active" -- Requires localization
	L["QuestHelper integration disabled"] = "QuestHelper integration disabled" -- Requires localization
	L["rl"] = "rl" -- Requires localization
	L["Welcome to the group, "] = "Welcome to the group, " -- Requires localization
	L["You"] = "你"
end