-- ********************************************************************************
-- Easy Misdirection (EasyMD)
-- The easiest way to create/edit a misdirection macro.
-- By: Shenton
--
-- Localization-enUS.lua
-- ********************************************************************************

local L = LibStub("AceLocale-3.0"):NewLocale("EasyMD", "enUS", true);

if L then
-- General
L["ADDON_NAME"] = "EasyMD";
L["NOT_AVAILABLE"] = "Not available";
L["MACRO_SET_TO"] = "Macro set to: %s" -- %s Is the name of the macro target
L["SET_MACRO_TO"] = "Set macro to:"
L["YOUR_PET"] = "Your pet";
L["FOCUS"] = "Focus";
L["CLOSE"] = "Close";
L["VERSION"] = "Version";
L["PRIMARY"] = "Primary";
L["SECONDARY"] = "Secondary";
L["SPECIALISATION"] = "Specialisation";
L["DEFAULT"] = "Default";
L["PARTY"] = "Party";
L["RAID"] = "Raid";
L["PVP"] = "Battleground";
L["ARENA"] = "Arena";
L["ENABLED"] = "Enabled";
L["DISABLED"] = "Disabled";
-- Macro
L["MACRO_NAME"] = "EasyMD"; -- Macro names got a limitation of 16 char
L["MACRO_CAST_COMMAND"] = "/cast"; -- Macro command to cast a spell
L["MACRO_PET"] = "pet"; -- Macro target pet
L["MACRO_FOCUS"] = "focus"; -- Macro target focus
L["MACRO_TARGET"] = "{TARGET}"; -- The replacement string
-- Configuration
L["CONFIG_INSTRUCTIONS"] = "Instructions";
L["CONFIG_MAIN"] = "Main";
L["CONFIG_MACRO"] = "Macro";
L["CONFIG_MACROS"] = "Macros";
L["CONFIG_MACROBODY_NAME"] = "Macro text";
L["CONFIG_MACROBODY_DESC"] = "The macro text, use %s in place of the target in the macro."; -- %s = replacement string
L["CONFIG_AUTO_NAME"] = "Auto";
L["CONFIG_AUTO_DESC"] = "Automaticaly set the macro with the tank name when entering instance and when the tank change.";
L["CONFIG_AUTOPET_NAME"] = "Auto Pet";
L["CONFIG_AUTOPET_DESC"] = "Automaticaly set the macro with your pet when leaving instance and when a tank leave.";
L["CONFIG_DUALSPEC_NAME"] = "Dual Specialisation";
L["CONFIG_DUALSPEC_DESC"] = "Activate macro switch depending on specialisation.";
L["CONFIG_MINIMAP_NAME"] = "Minimap icon";
L["CONFIG_MINIMAP_DESC"] = "Show/hide the minimap icon.";
L["CONFIG_TITAN_NAME"] = "Titan compatibility";
L["CONFIG_TITAN_DESC"] = "For Titan users, modifies the behavior of the icon clicks.";
L["CONFIG_VERBOSITY_NAME"] = "Verbosity";
L["CONFIG_VERBOSITY_DESC"] = "|cFFC79C6ELow:|r Display a message only when the macro is edited.\n|cFFC79C6ENormal:|r Also display a message when important events occur.\n|cFFC79C6EMax:|r Display every messages.";
L["CONFIG_VERBOSITY_SELECT_0"] = "Disabled";
L["CONFIG_VERBOSITY_SELECT_1"] = "Low";
L["CONFIG_VERBOSITY_SELECT_2"] = "Normal";
L["CONFIG_VERBOSITY_SELECT_3"] = "Max";
L["CONFIG_CREATE_NAME"] = "Create macro";
L["CONFIG_CREATE_DESC"] = "Create the %s macro with your pet(Hunter) or focus(rogue) as target, if it do not exists."; -- %s is the macro name defined by L["MACRO_NAME"]
L["CONFIG_PERCHARACTER_NAME"] = "Macro category";
L["CONFIG_PERCHARACTER_DESC"] = "Select in which category the macro should be created, when changing this the macro is deleted.";
L["CONFIG_PERCHARACTER_SELECT_0"] = "General";
L["CONFIG_PERCHARACTER_SELECT_1"] = "Character specific";
L["MACRO_NOT_FOUND"] = "The macro has not been created.";
L["CONFIG_MODULES"] = "Modules";
L["CONFIG_MODULE_ENABLE_DISABLE"] = "Enable or disable this module."
L["CONFIG_RELOADUI"] = "Reload UI";
L["CONFIG_RELOADUI_DESC"] = "Reload the user interface to ensure the module is fully loaded/unloaded."
L["CONFIG_ANNOUNCE_PARTY"] = "Announce to party";
L["CONFIG_ANNOUNCE_PARTY_DESC"] = "Announce to your party when you cast %s and on who."; -- %s is localised MD/TotT
L["CONFIG_ANNOUNCE_RAID"] = "Announce to raid";
L["CONFIG_ANNOUNCE_RAID_DESC"] = "Announce to your raid when you cast %s and on who."; -- %s is localised MD/TotT
L["CONFIG_ANNOUNCE_SAY"] = "Say anytime";
L["CONFIG_ANNOUNCE_SAY_DESC"] = "Say on who you cast %s at anytime."; -- %s is localised MD/TotT
L["CONFIG_ANNOUNCE_YELL"] = "Yell anytime";
L["CONFIG_ANNOUNCE_YELL_DESC"] = "Yell on who you cast %s at anytime."; -- %s is localised MD/TotT
L["CONFIG_ANNOUNCE_WHISPER"] = "Whisper target";
L["CONFIG_ANNOUNCE_WHISPER_DESC"] = "Whisper your %s target when you cast it."; -- %s is localised MD/TotT
L["CONFIG_GROWL_NAME"] = "Growl";
L["CONFIG_COWER_NAME"] = "Cower";
L["CONFIG_PET_DESC"] = "|cFFC79C6ENever:|r Will tell you to deactivate autocast every summon/dismount/loading screen.\n|cFFC79C6EAlways:|r Will tell you to activate autocast every summon/dismount/loading screen.\n|cFFC79C6EWith %s:|r Will tell you to activate or deactivate autocast when %s set your macro."; -- 1st & 2ns %s = L["ADDON_NAME"]
L["CONFIG_PET_SELECT_0"] = "Disabled";
L["CONFIG_PET_SELECT_1"] = "Never";
L["CONFIG_PET_SELECT_2"] = "Always";
L["CONFIG_PET_SELECT_3"] = "With %s"; -- %s = L["ADDON_NAME"]
L["CONFIG_PET_TIMER_NAME"] = "Cooldown";
L["CONFIG_PET_TIMER_DESC"] = "Time before allowing another message.";
L["CONFIG_PET_TIMER_0"] = "One minute";
L["CONFIG_PET_TIMER_1"] = "Five minutes";
L["CONFIG_PET_TIMER_2"] = "Ten minutes";
L["CONFIG_MODULES_PREFIX"] = "M:";
L["CONFIG_TANKS_LIST"] = "Tanks list";
L["CONFIG_TANKS_LIST_DESC"] = "The tanks list, one name per line.";
-- Modules
L["MODULE_NAME_LDB"] = "Data Broker";
L["MODULE_NAME_ANNOUNCE"] = "Announce";
L["MODULE_ANNOUNCE_SENTENCE"] = "Casting %s on %s"; -- 1st %s MD/TotT spell link, 2nd the MD/TotT target
L["MODULE_ANNOUNCE_WHISPER"] = "Casting %s on you"; -- 1st %s MD/TotT spell link
L["MODULE_NAME_PET"] = "Pet";
L["DEACTIVATE_GROWL"] = "Growl autocast is activated.";
L["ACTIVATE_GROWL"] = "Growl autocast is deactivated.";
L["DEACTIVATE_COWER"] = "Cower autocast is activated.";
L["ACTIVATE_COWER"] = "Cower autocast is deactivated.";
L["MODULE_NAME_TANKS"] = "Tanks";
-- Messages
L["ENTERING_WORLD"] = "Entering world";
L["ENTERING_INSTANCE"] = "Entering instance";
L["MACRO_CREATED"] = "Macro created.";
L["MACRO_EDITED"] = "Macro edited.";
L["MACRO_CREATED_NAME"] = "Macro created and set to %s."; -- %s = name of the unit tageted by MD/TotT
L["MACRO_EDITED_NAME"] = "Macro edited and set to %s."; -- %s = name of the unit tageted by MD/TotT
L["TANK_CHANGED"] = "It looks like the tank changed.";
L["TANK_LEFT"] = "It looks like the tank left.";
L["TYPE_DEFAULT"] = "Using default macro.";
L["TYPE_PARTY"] = "Using party macro.";
L["TYPE_RAID"] = "Using raid macro.";
L["TYPE_PVP"] = "Using battleground macro.";
L["TYPE_ARENA"] = "Using arena macro.";
L["TYPE_PRIMARY_DEFAULT"] = "Using primary specialisation default macro.";
L["TYPE_PRIMARY_PARTY"] = "Using primary specialisation party macro.";
L["TYPE_PRIMARY_RAID"] = "Using primary specialisation raid macro.";
L["TYPE_PRIMARY_PVP"] = "Using primary specialisation battleground macro.";
L["TYPE_PRIMARY_ARENA"] = "Using primary specialisation arena macro.";
L["TYPE_SECONDARY_DEFAULT"] = "Using secondary specialisation default macro.";
L["TYPE_SECONDARY_PARTY"] = "Using secondary specialisation party macro.";
L["TYPE_SECONDARY_RAID"] = "Using secondary specialisation raid macro.";
L["TYPE_SECONDARY_PVP"] = "Using secondary specialisation battleground macro.";
L["TYPE_SECONDARY_ARENA"] = "Using secondary specialisation arena macro.";
L["SPEC_CHANGED"] = "Specialisation switch to %s (%s)."; -- 1st %s = Specialisation name, 2nd = talents points (xx/xx/xx)
L["COMMAND_USAGE_1"] = "Command usage, |cFFC79C6E/md|r, |cFFC79C6E/easymd|r.";
L["COMMAND_USAGE_2"] = "With no argument it will display the configuration dialog.";
L["COMMAND_USAGE_3"] = "|cFFC79C6E/md <target> [raid|party|pvp|arena|default]|r, will set the macro to the given target with the optional forced instance type.";
L["COMMAND_USAGE_4"] = "|cFFC79C6E/md cicle|r, cicle through tanks from module Tanks.";
L["MACRO_CATEGORY_CHANGED"] = "Macro category set to \"%s\", the macro have been deleted."; -- %s = L["CONFIG_PERCHARACTER_SELECT_0"] or L["CONFIG_PERCHARACTER_SELECT_1"]
-- Error messages
L["NO_SLOT_FREE"] = "There is no macro slot free in that category.";
L["ERROR_SETTING_MACRO"] = "%s was find in the macro body, but not the replacement string. Check your spelling in the configuration menu and remember it is case sensitive."; -- %s is localised MD/TotT
L["IS_RAID"] = "You are in a raid, cannot determine wich name tank to set, use the data broker icon or the Tanks module please.";
L["IN_COMBAT"] = "You are in combat, macro will be set when you will be out of combat.";
L["MACRO_ALREADY_SET"] = "That macro is already set."
L["NO_DUAL_SPEC"] = "Dual specialisation is activated but you did not have it, using global macros instead.";
L["MACRO_LENGTH_ERROR"] = "The macro length is superior than 255 characters (%d), macro code other that point will not be used."; -- %d is the length
L["MACRO_PANEL_OPEN"] = "The macros creation panel is open, please close it to set the macro.";
L["NAME_IS_EMPTY"] = "No name provided or Blizzard target, nothing to do here.";
L["TANK_NOT_FOUND"] = "Tank not found, use the data broker icon instead please.";
L["TEMPLATE_IS_EMPTY"] = "No macro template found, please set at least the default one and both defaults ones if using dualspec.";
L["TANKS_ENABLED_NO_LIST"] = "Tanks module is activated but none tank's name are provided.";
-- StaticPopup
L["STATICPOPUP_MESSSAGE"] = "Enter a name or a Blizzard target";
L["STATICPOPUP_ACCEPT"] = "Accept";
L["STATICPOPUP_CANCEL"] = "Cancel";
L["STATICPOPUP_TYPE"] = "Location type";
-- Tooltip
L["TOOLTIP_TIPS"] = "|cFFC79C6ELeft-Click: |cFF33FF99Show the input target dialog\n|cFFC79C6ERight-Click: |cFF33FF99Display the names selection menu\n|cFFC79C6EMiddle-Click: |cFF33FF99Display the configuration dialog";
L["TOOLTIP_TANKS_TIPS"] = "|cFFC79C6ELeft-Click: |cFF33FF99Cicle through prefered tanks\n|cFFC79C6EShift + Left-Click: |cFF33FF99Show the input target dialog\n|cFFC79C6ERight-Click: |cFF33FF99Display the names selection menu\n|cFFC79C6EMiddle-Click: |cFF33FF99Display the configuration dialog";
L["TOOLTIP_TITAN_TIPS"] = "|cFFC79C6EShift + Left-Click: |cFF33FF99Show the input target dialog\n|cFFC79C6ELeft-Click: |cFF33FF99Display the names selection menu\n|cFFC79C6EMiddle-Click: |cFF33FF99Display the configuration dialog";
L["TOOLTIP_TITAN_TANKS_TIPS"] = "|cFFC79C6EShift + Left-Click: |cFF33FF99Cicle through prefered tanks\n|cFFC79C6EControl + Left-Click: |cFF33FF99Show the input target dialog\n|cFFC79C6ELeft-Click: |cFF33FF99Display the names selection menu\n|cFFC79C6EMiddle-Click: |cFF33FF99Display the configuration dialog";
-- Class
L["CLASS_DEATHKNIGHT"] = "Death Knight";
L["CLASS_DRUID"] = "Druid";
L["CLASS_HUNTER"] = "Hunter";
L["CLASS_MAGE"] = "Mage";
L["CLASS_PALADIN"] = "Paladin";
L["CLASS_PRIEST"] = "Priest";
L["CLASS_ROGUE"] = "Rogue";
L["CLASS_SHAMAN"] = "Shaman";
L["CLASS_WARLOCK"] = "Warlock";
L["CLASS_WARRIOR"] = "Warrior";
-- Instructions pages
L["MACRO_EXAMPLE"] = "    #showtooltip\n    /petattack\n    %s [@%s,nodead] %s" -- 1st %s = L["MACRO_CAST_COMMAND"], 2nd = L["MACRO_TARGET"], 3rd = MD/TotT localized
-- 1st %s = L["MACRO_NAME"], 2nd = L["MACRO_TARGET"], 3rd = L["MACRO_EXAMPLE"]
L["INSTRUCTIONS_PAGE"] = "|cFF33FF99Usage|r\n\n- With a Data Broker display, I use ChocolateBar\n- With the minimap icon\n- With Titan Panel\n- With the command line\n\nThe macro |cFFFF3333need|r to be named |cFFFF3333%s|r, the replacement string |cFFFF3333need|r to be |cFFFF3333%s|r and is |cFFFF3333case sensitive|r. You can set differents macros depending on your location (5-man, raid, battleground, arena) and your current specialisation if activated. You can also set it manualy with the menu or the command line, below you will find the order behavior. When your are not using a macro location type the input box |cFFFF3333need to be empty|r or the addon will consider it activated.\n\nYou can drag and drop a spell from the spellbook to the input boxes.\n\nMacro example:\n%s\n\nIf activated when you will enter a 5-man instance and roles are defined the macro will be automaticaly set to the tank, if the tank left and auto pet is activated the macro will switch to your pet, and if a new tank join it will set it automaticaly. If activated when you will leave the instance the macro will be automaticaly set to your pet.\n\nYou can create the macro easily in the configuration dialog.\n\n|cFF33FF99Locations behavior|r\n\n- |cFFC79C6EParty|r: Party => Raid => Default\n- |cFFC79C6ERaid|r: Raid => Party => Default\n- |cFFC79C6EBattleground|r: Battleground => Arena => Default\n- |cFFC79C6EArena|r: Arena => Battleground => Default\n\n|cFF33FF99Commands|r\n\n|cFFC79C6E/md|r or |cFFC79C6E/easymd|r\n\n- With no argument it will display the configuration dialog.\n- |cFFC79C6E/md help|r Commands help.\n- |cFFC79C6E/md <target> [raid|party|pvp|arena|default]|r, Will set the macro to the given target with the optional forced instance type.\n- |cFFC79C6E/md cicle|r, Cicle through tanks if the Tanks module is activated\n\n|cFF33FF99Notes|r\n\nIf you find an error or have a suggestion please use the tickets page on WowAce, you can also help with localization."
L["INSTRUCTIONS_TANKS"] = "|cFF33FF99Usage|r\n\nThe purpose of this module is to set a list of your prefered tanks, one tank name per line.\n\nIf auto is activated it will choose the first tank and set the macro with him when entering a raid instance.\n\nYou can also |cFFC79C6ELeft-Click|r on the icon to cicle through tanks.";
end
