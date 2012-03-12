local L = LibStub("AceLocale-3.0"):NewLocale("MoncaiQuestTracker", "deDE", false)
if L then
	L["[%d] %s"] = true
	L["(.*): (%d+) ?/ ?(%d+)"] = true
	L[".*: (%d+) ?/ ?%d+"] = true
	L["(.*): %d+ ?/ ?%d+"] = true
	L["Goodbye, "] = "Tschuss, "
	L["Welcome to the group, "] = "Wilkommen in die Gruppe, "
	L["Could not add buddy, buffer full"] = "Könnte der Buddy nicht hinzufügen, Buffer ist voll"
	L["needs %1$d more %2$s "] = "braucht noch %1$d %2$s " -- needs <number> more [of] <person/object/action>
	L["is finished with %s "] = "ist fertig mit %s "
	L["needs"] = "braucht" --he
	L["need"] = "brauchst" -- you
	L["is finished"] = "ist fertig"
	L["are finished"] = "sind fertig"
	L["You"] = "Sie"
	L["has "] = "hat "
	L["Let's Party!"] = "Machen wir 'ne Gruppe!"
	L["Command not found"] = "Befehl nicht gefunden"
	L["Moncaí's Quest Tracker loading, stand by..."] = "Moncaí's Quest Tracker loading, einen Moment bitte..."
	L["PANIC!"] = "Hilfe!"
	L["Moncaí Questtracker"] = "Moncaí Questtracker" -- short title
	L["rl"] = true -- shorthand for /console ReloadUI
	L["mqt"] = true -- slash command to open options panel
	L["Moncaí's Quest Tracker enabled"] = "Moncaí's Quest Tracker aktiviert"
	L["Moncaí's Quest Tracker disabled"] = "Moncaí's Quest Tracker deaktiviert"
	L["(.*)(: ?.*)"] = true -- split text in two parts for FitLine
	L["([^ ]+)$"] = true -- for length of last word
	L["Hey, you're working on %s, I'll add it!"] = "Sie sind beschäftigt mit %s, ich fuge es hinzu!"
	
	L["QuestHelper integration active"] = "QuestHelper Function Activiert"
	L["QuestHelper integration disabled"] = "QuestHelper Function Deactiviert"
	
end