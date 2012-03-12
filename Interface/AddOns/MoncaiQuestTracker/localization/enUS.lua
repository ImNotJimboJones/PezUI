local L = LibStub("AceLocale-3.0"):NewLocale("MoncaiQuestTracker", "enUS", true)
if L then	
	L["[%d] %s"] = true
	L["(.*): (%d+) ?/ ?(%d+)"] = true
	L[".*: (%d+) ?/ ?%d+"] = true
	L["(.*): %d+ ?/ ?%d+"] = true
	L["Goodbye, "] = true
	L["Welcome to the group, "] = true
	L["Could not add buddy, buffer full"] = true
	L["needs %1$d more %2$s "] = true -- needs <number> more [of] <person/object/action>
	L["is finished with %s "] = true
	L["needs"] = true --he
	L["need"] = true -- you
	L["is finished"] = true
	L["are finished"] = true
	L["You"] = true
	L["has "] = true
	L["Let's Party!"] = true
	L["Command not found"] = true
	L["Moncaí's Quest Tracker loading, stand by..."] = true
	L["PANIC!"] = true
	L["Moncaí Questtracker"] = true -- short title
	L["rl"] = true -- shorthand for /console ReloadUI
	L["mqt"] = true -- slash command to open options panel
	L["Moncaí's Quest Tracker enabled"] = true
	L["Moncaí's Quest Tracker disabled"] = true
	L["(.*)(: ?.*)"] = true -- split text in two parts for FitLine
	L["([^ ]+)$"] = true -- for length of last word
	L["Hey, you're working on %s, I'll add it!"] = true

	L["QuestHelper integration active"] = true
	L["QuestHelper integration disabled"] = true
end