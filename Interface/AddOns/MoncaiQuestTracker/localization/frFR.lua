local L = LibStub("AceLocale-3.0"):NewLocale("MoncaiQuestTracker", "frFR", false)
if L then
	L["[%d] %s"] = true
	L["(.*): (%d+) ?/ ?(%d+)"] = true
	L[".*: (%d+) ?/ ?%d+"] = true
	L["(.*): %d+ ?/ ?%d+"] = true
	L["Goodbye, "] = "Au revoir, "
	L["Welcome to the group, "] = "Bienvenue dans le groupe, "
	L["Could not add buddy, buffer full"] = "Impossible d'ajouter des amis, le tampon est plein"
	L["needs %1$d more %2$s "] = "besoin(s) %1$d plus de %2$s " -- needs <number> more [of] <person/object/action>
	L["is finished with %s "] = "est fini avec %s "
	L["needs"] = "besoin(s)" --he
	L["need"] = "avez besoin" -- you
	L["is finished"] = "est fini"
	L["are finished"] = "avez fini"
	L["You"] = "Vous"
	L["has "] = "a "
	L["Let's Party!"] = "Laissez-nous de groupe!"
	L["Command not found"] = "Direction ne trouvé pas"
	L["Moncaí's Quest Tracker loading, stand by..."] = "Moncaí's Traqueur de Quetes chargement, une moment s'il vous plaît..."
	L["PANIC!"] = "Panique!"
	L["Moncaí Questtracker"] = "Moncaí Traqueur de Quetes" -- short title
	L["rl"] = true -- shorthand for /console ReloadUI
	L["mqt"] = "mtq" -- slash command to open options panel
	L["Moncaí's Quest Tracker enabled"] = "Moncaí's Traqueur de Quetes activée"
	L["Moncaí's Quest Tracker disabled"] = "Moncaí's Traqueur de Quetes désactivé"
	L["(.*)(: ?.*)"] = true -- split text in two parts for FitLine
	L["([^ ]+)$"] = true -- for length of last word
	L["Hey, you're working on %s, I'll add it!"] = "Vous travaillez sur %s, je vais l'ajouter!"
	
	L["QuestHelper integration active"] = "QuestHelper function activée"
	L["QuestHelper integration disabled"] = "QuestHelper function désactivé"
	
end