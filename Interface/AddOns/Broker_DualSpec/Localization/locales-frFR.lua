-- ********************************************************************************
-- Data Broker Dual Specilisation (Broker_DualSpec)
-- A dual specialisation switch for Data Broker.
-- By: Shenton
--
-- Locales-frFR.lua
-- ********************************************************************************

local L = LibStub("AceLocale-3.0"):NewLocale("Broker_DualSpec", "frFR");

if L then
L["NOT_AVAILABLE"] = "Indisponible";
L["ADDON_NAME"] = "DualSpec";
L["CLOSE"] = "Fermer";
L["PRIMARY_SPEC"] = "Sp\195\169 pincipale";
L["SECONDARY_SPEC"] = "Sp\195\169 secondaire";
L["GEAR_SETS"] = "Sets d'\195\169quipement";
L["OPTIONS"] = "Options";
L["DISPLAY_SPEC_NAME"] = "Afficher le nom";
L["DISPLAY_SPEC_POINTS"] = "Afficher les points";
L["SWITCH_GEAR_TOO"] = "Changer aussi l'\195\169quipement";
L["NO_GEAR_SETS"] = "Vous n'avez aucun jeu d'\195\169quipement de d\195\169fini";
L["IN_COMBAT"] = "Vous \195\170tes en combat, impossible de changer de sp\195\169cialisation";
L["NO_GEAR_DEFINED"] = "Le changement d'\195\169quipement est activ\195\169, mais aucun jeu d'\195\169quipement n'est d\195\169fini";
L["SHOW_HIDE_MINIMAP"] = "Afficher/Masquer l'icone de la minimap";
L["HIDE_MINIMAP"] = "Icone de la minimap cach\195\169, pour l'afficher utilisez: \"/ds show\" (ou /bds /brokerdualspec)";
L["CURRENT_SPEC"] = "Sp\195\169 actuelle";
L["SWITCH_TO"] = "Changer pour";
L["WITH_GEAR_SET"] = "Avec le jeu";
L["GEAR_NOT_EXISTS"] = "Ce jeu d'\195\169quipement n'existe pas, utilisez \"/ds list\" pour une liste";
L["COMMAND_USAGE_1"] = "Utilisation de la commande, \"/ds\", \"/bds\", \"/brokerdualspec\"";
L["COMMAND_USAGE_2"] = "Sans aucun argument ça changera de sp\195\169cialisation";
L["COMMAND_USAGE_3"] = "\"/ds show\", affiche l'icone de la minimap, \"/ds list\", fait une liste de vos jeux d'\195\169quipement";
L["COMMAND_USAGE_4"] = "\"/ds <primary|secondary> <jeu d'\195\169quipement>\", assigne le jeu d'\195\169quipement \195\160 la sp\195\169cialisation";
L["TOOLTIP_TIPS"] = "%sClique-Gauche:%s Change votre sp\195\169cialisation et votre jeu d'\195\169quipement si activ\195\169\n%sClique-Droit:%s Affiche le menu de configuration"; -- 1st %s warrior color, 2nd green color, etc
end
