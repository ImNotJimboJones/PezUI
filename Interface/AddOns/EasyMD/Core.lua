-- ********************************************************************************
-- Easy Misdirection (EasyMD)
-- The easiest way to create/edit a misdirection macro.
-- By: Shenton
--
-- Core.lua
-- ********************************************************************************

-- ###############################################################################################################################################################################################################
-- TODO
-- MultiTargets module
-- Refresh macro function - command line & LDB
-- Prevent tank left on new instance (seem to be a lag problem)
-- ###############################################################################################################################################################################################################

-- If not an hunter or a rogue stop the script
local _, unitClass = UnitClass("player");
if ( unitClass == "HUNTER" ) then
elseif ( unitClass == "ROGUE" ) then
else return; end

-- Ace libs (<3)
EasyMD = LibStub("AceAddon-3.0"):NewAddon("EasyMD", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0");
EasyMD.aceConfigDialog = LibStub("AceConfigDialog-3.0");
EasyMD.aceConfigRegistry = LibStub("AceConfigRegistry-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("EasyMD");

-- ********************************************************************************
-- Variables or "constants"
-- ********************************************************************************

-- Local LUA functions
local slen, sformat, sgsub, sfind, smatch, tsort, tinsert, pairs, ipairs = string.len, string.format, string.gsub, string.find, string.match, table.sort, table.insert, pairs, ipairs;

-- Player class
EasyMD.class = unitClass;

-- Misdirection spell id 34477 - Trick of the Trade spell id 57934
if ( EasyMD.class == "HUNTER" ) then
    EasyMD.spellId = 34477;
    EasyMD.spellName,_,_,_,_,_,_,_,_ = GetSpellInfo(EasyMD.spellId);
else
    EasyMD.spellId = 57934;
    EasyMD.spellName,_,_,_,_,_,_,_,_ = GetSpellInfo(EasyMD.spellId);
end

-- AddOn version
EasyMD.version = GetAddOnMetadata("EasyMD", "Version");

-- Text colors
EasyMD.color = {};
EasyMD.color["RED"] = "|cFFFF3333";
EasyMD.color["GREEN"] = "|cFF33FF99";
EasyMD.color["WHITE"] = "|cFFFFFFFF";
EasyMD.color["DEATHKNIGHT"] = "|cFFC41F3B";
EasyMD.color["DRUID"] = "|cFFFF7D0A";
EasyMD.color["HUNTER"] = "|cFFABD473";
EasyMD.color["MAGE"] = "|cFF69CCF0";
EasyMD.color["PALADIN"] = "|cFFF58CBA";
EasyMD.color["PRIEST"] = "|cFFFFFFFF";
EasyMD.color["ROGUE"] = "|cFFFFF569";
EasyMD.color["SHAMAN"] = "|cFF0070DE";
EasyMD.color["WARLOCK"] = "|cFF9482C9";
EasyMD.color["WARRIOR"] = "|cFFC79C6E";
EasyMD.color["RESET"] = "|r";

-- Login trick
EasyMD.isLogin = true;

-- Loading trick
EasyMD.enteringWorld = false;

-- Macro set in combat or while the macro frame is open
EasyMD.isDelayed = false;
EasyMD.delayedName = nil;
EasyMD.delayedCreate = nil;
EasyMD.delayedSilence = nil;
EasyMD.delayedType = nil;

-- Instances types table
EasyMD.instancesTypes = { [L["DEFAULT"]] = "default", [L["PARTY"]] = "party", [L["RAID"]] = "raid", [L["PVP"]] = "pvp", [L["ARENA"]] = "arena" };

-- Max macros
EasyMD.maxCharacterMacros = 18;
EasyMD.maxAccountMacros = 36;

-- Modules objects table
EasyMD.modules = {};

-- ********************************************************************************
-- Functions
-- ********************************************************************************

--- Send a message to the chat frame with the addon name colored
-- @param text The message to display
-- @param level Verbosity level (0 to 3)
-- @param color Bool, if true will color in red
function EasyMD:Message(text, level, color)
    if ( level <= EasyMD.config.profile.main.verbosity ) then
        if ( color ) then
            color = EasyMD.color["RED"];
        else
            color = EasyMD.color["GREEN"]
        end

        DEFAULT_CHAT_FRAME:AddMessage(color..L["ADDON_NAME"]..": "..EasyMD.color["RESET"]..text);
    end
end

--- Handle the slash command
-- @param input The string returned after the command
function EasyMD:SlashCommand(input)
    local arg1, arg2 = strsplit(" ", input);

    if ( arg1 == "" ) then
        EasyMD.aceConfigDialog:Open("Easy Misdirection Configuration");
    elseif ( arg1 == "help" or arg1 == "h" or arg1 == "?" ) then
        EasyMD:Message(L["COMMAND_USAGE_1"], 0);
        EasyMD:Message(L["COMMAND_USAGE_2"], 0);
        EasyMD:Message(L["COMMAND_USAGE_3"], 0);
        if ( EasyMD.modules[L["MODULE_NAME_TANKS"]] ) then EasyMD:Message(L["COMMAND_USAGE_4"], 0); end
    elseif ( arg1 == "cicle" ) then
        if ( EasyMD.modules[L["MODULE_NAME_TANKS"]] ) then
            EasyMD.modules[L["MODULE_NAME_TANKS"]]:CicleTanks();
        else
            EasyMD.aceConfigDialog:Open("Easy Misdirection Configuration");
        end
    elseif ( arg1 ~= "" and not arg2 ) then
        EasyMD:SetMacro(arg1);
    elseif ( arg1 ~= "" and arg2 ~= "" ) then
        if ( EasyMD:CheckInstanceType(arg2) ) then
            EasyMD:SetMacro(arg1, nil, nil, arg2);
        else
            EasyMD:Message(L["COMMAND_USAGE_1"], 1);
            EasyMD:Message(L["COMMAND_USAGE_2"], 1);
            EasyMD:Message(L["COMMAND_USAGE_3"], 1);
            if ( EasyMD.modules[L["MODULE_NAME_TANKS"]] ) then EasyMD:Message(L["COMMAND_USAGE_4"], 1); end
        end
    else
        EasyMD:Message(L["COMMAND_USAGE_1"], 1);
        EasyMD:Message(L["COMMAND_USAGE_2"], 1);
        EasyMD:Message(L["COMMAND_USAGE_3"], 1);
        if ( EasyMD.modules[L["MODULE_NAME_TANKS"]] ) then EasyMD:Message(L["COMMAND_USAGE_4"], 1); end
    end
end

--- Set the modules objects table
function EasyMD:ModulesTable()
    for n,m in EasyMD:IterateModules() do
        if ( m and m:IsEnabled() ) then
            EasyMD.modules[n] = m;
        else
            EasyMD.modules[n] = false;
        end
    end
end

--- Print a message if the string length is superior than 255
-- @param str the string to test
function EasyMD:MacroLen(str)
    local len = slen(str);

    if ( len > 255 ) then
        EasyMD:Message(sformat(L["MACRO_LENGTH_ERROR"], len), 1, true);
    end
end

--- Define if the given instance type in the current spec got a template
-- @param tpl The template
-- @return True or false
function EasyMD:TemplateExists(tpl)
    if ( EasyMD.config.profile.main.dualspec ) then
        local grp;

        if ( GetActiveTalentGroup(false, false) == 1 ) then
            grp = "primary";
        else
            grp = "secondary";
        end

        if ( EasyMD.config.profile.macros[grp][tpl] == "" ) then
            return false;
        else
            return true;
        end
    else
        if ( EasyMD.config.profile.macros[tpl] == "" ) then
            return false;
        else
            return true;
        end
    end
end

--- Get the player current zone or an error string
-- @return the player current zone
function EasyMD:GetZone()
    local zone = GetRealZoneText();

    if ( not zone or zone == "" ) then zone = L["NOT_AVAILABLE"]; end

    return zone;
end

--- Get party members
-- @return A table with names, classes and roles or false
function EasyMD:GetPartyMembers()
    local numUnits = GetNumPartyMembers();

    if ( numUnits == 0 ) then
        return false;
    else
        local t = {};

        for i=1,numUnits do
            local name,_ = UnitName("party"..i);
            local _, class = UnitClass("party"..i);

            t[i] = {};
            t[i]["name"] = name;
            t[i]["class"] = class;
            t[i]["role"] = UnitGroupRolesAssigned("party"..i);
        end

        return t;
    end
end

--- Get raid members
-- @return A talbe wih names, classes and roles or false
function EasyMD:GetRaidMembers()
    local numUnits = GetNumRaidMembers();

    if ( numUnits == 0 ) then
        return false;
    else
        local t = {};

        for i=1,numUnits do
            local name,_ = UnitName("raid"..i);
            local _, class = UnitClass("raid"..i);

            t[i] = {};
            t[i]["name"] = name;
            t[i]["class"] = class;
            t[i]["role"] = UnitGroupRolesAssigned("raid"..i);
        end

        return t;
    end
end

--- Get raid classes
-- @param members Members table provided by EasyMD:GetRaidMembers()
-- @return A table with a boolean value fo each class 
function EasyMD:GetRaidClasses(members)
    local classes =
    {
        ["DEATHKNIGHT"] = false,
        ["DRUID"] = false,
        ["HUNTER"] = false,
        ["MAGE"] = false,
        ["PALADIN"] = false,
        ["PRIEST"] = false,
        ["ROGUE"] = false,
        ["SHAMAN"] = false,
        ["WARLOCK"] = false,
        ["WARRIOR"] = false,
    };

    for i=1,#members do
        if ( not classes[members[i]["class"]] ) then classes[members[i]["class"]] = true; end
    end

    return classes;
end

--- Get tank by role in the party
-- @param members The table returned by GetRaidMembers() or GetPartyMembers()
-- @return the tank name or false
function EasyMD:GetTank(members)
    for _,t in ipairs(members) do
        if ( t["role"] == "TANK" ) then return t["name"]; end
    end

    return false;
end

--- Get the macro info
-- @return The macro body and if there is a macro slot or false
function EasyMD:GetMacroInfo()
    local body, slotFree = GetMacroBody(L["MACRO_NAME"]), false;
    local general, perCharacter = GetNumMacros();

    if ( EasyMD.config.profile.main.perCharacter == 1 ) then
        if ( perCharacter < EasyMD.maxCharacterMacros ) then slotFree = true; end
    else
        if ( general < EasyMD.maxAccountMacros ) then slotFree = true; end
    end

    return body, slotFree;
end

--- Get the macro target
-- @param ldb If ldb need it
-- @return The target name or na for ldb, pet for the macro
function EasyMD:GetTarget(ldb)
    local body = GetMacroBody(L["MACRO_NAME"]);
    local name;

    if ( body ) then
        name = smatch(body, "/.+@(.+),+.+"..EasyMD.spellName.."\n") or smatch(body, "/.+@(.+)%]+.+"..EasyMD.spellName.."\n")
            or smatch(body, "/.+@(.+),+.+"..EasyMD.spellName.."$") or smatch(body, "/.+@(.+)%]+.+"..EasyMD.spellName.."$")
            or smatch(body, "/.+target=(.+),+.+"..EasyMD.spellName.."\n") or smatch(body, "/.+target=(.+)%]+.+"..EasyMD.spellName.."\n")
            or smatch(body, "/.+target=(.+),+.+"..EasyMD.spellName.."$") or smatch(body, "/.+target=(.+)%]+.+"..EasyMD.spellName.."$");
        if ( not name and not ldb) then
            name = L["MACRO_PET"];
        elseif ( not name ) then
            name = L["NOT_AVAILABLE"];
        end
    else
        name = L["NOT_AVAILABLE"];
    end

    return strtrim(name);
end

--- Get informations about the given spec
-- @param group The spec group number (1 or 2), if nil the current spec
-- @return The spec name, the spec icon, the points spent
function EasyMD:GetSpecInfos(group)
    local spec, icon, talents = "", "", "";
    local name, tex, points;

    if ( not group ) then group = GetActiveTalentGroup(false, false); end

    for i=1,3 do
        _, name,_, tex, points,_,_,_ = GetTalentTabInfo(i, false, false, group);
        if ( points >= 31 ) then
            spec = name;
            icon = tex;
        end
        talents = talents.."/"..points;
    end

    talents = strtrim(talents, "/");

    return spec, icon, talents;
end

--- Get dual spec info
-- @return The current spec group or false, the current spec name and points
function EasyMD:GetDualSpecInfos()
    local dual = false;
    local spec,_, talents = EasyMD:GetSpecInfos();

    if ( GetNumTalentGroups(false, false) == 2 ) then dual = GetActiveTalentGroup(false, false); end

    return dual, spec, talents;
end

--- Check if the given instance type exists
-- @param instanceType The instance type to check
-- @return true or false
function EasyMD:CheckInstanceType(instanceType)
    for _,v in pairs(EasyMD.instancesTypes) do
        if ( instanceType == v ) then return true; end
    end

    return false;
end

--- Set the macro body to use depending on location and options
-- @param mType The macro type wanted
-- @return The macro body, the message to display
function EasyMD:SetMacroType(mType)
    local dual,_,_ = EasyMD:GetDualSpecInfos();

    if ( EasyMD.config.profile.main.dualspec and not dual ) then
        EasyMD:Message(L["NO_DUAL_SPEC"], 1, true);
    end

    if ( mType == "party" ) then
        if ( EasyMD.config.profile.main.dualspec and dual ) then
            if ( dual == 1 ) then
                if ( EasyMD.config.profile.macros.primary.party ~= "" ) then
                    return EasyMD.config.profile.macros.primary.party, L["TYPE_PRIMARY_PARTY"];
                elseif ( EasyMD.config.profile.macros.primary.raid ~= "" ) then
                    return EasyMD.config.profile.macros.primary.raid, L["TYPE_PRIMARY_RAID"];
                else
                    return EasyMD.config.profile.macros.primary.default, L["TYPE_PRIMARY_DEFAULT"];
                end
            else
                if ( EasyMD.config.profile.macros.secondary.party ~= "" ) then
                    return EasyMD.config.profile.macros.secondary.party, L["TYPE_SECONDARY_PARTY"];
                elseif ( EasyMD.config.profile.macros.secondary.raid ~= "" ) then
                    return EasyMD.config.profile.macros.secondary.raid, L["TYPE_SECONDARY_RAID"];
                else
                    return EasyMD.config.profile.macros.secondary.default, L["TYPE_SECONDARY_DEFAULT"];
                end
            end
        else
            if ( EasyMD.config.profile.macros.party ~= "" ) then
                return EasyMD.config.profile.macros.party, L["TYPE_PARTY"];
            elseif ( EasyMD.config.profile.macros.raid ~= "" ) then
                return EasyMD.config.profile.macros.raid, L["TYPE_RAID"];
            else
                return EasyMD.config.profile.macros.default, L["TYPE_DEFAULT"];
            end
        end
    elseif ( mType == "raid" ) then
        if ( EasyMD.config.profile.main.dualspec and dual ) then
            if ( dual == 1 ) then
                if ( EasyMD.config.profile.macros.primary.raid ~= "" ) then
                    return EasyMD.config.profile.macros.primary.raid, L["TYPE_PRIMARY_RAID"];
                elseif ( EasyMD.config.profile.macros.primary.party ~= "" ) then
                    return EasyMD.config.profile.macros.primary.party, L["TYPE_PRIMARY_PARTY"];
                else
                    return EasyMD.config.profile.macros.primary.default, L["TYPE_PRIMARY_DEFAULT"];
                end
            else
                if ( EasyMD.config.profile.macros.secondary.raid ~= "" ) then
                    return EasyMD.config.profile.macros.secondary.raid, L["TYPE_SECONDARY_RAID"];
                elseif ( EasyMD.config.profile.macros.secondary.party ~= "" ) then
                    return EasyMD.config.profile.macros.secondary.party, L["TYPE_SECONDARY_PARTY"];
                else
                    return EasyMD.config.profile.macros.secondary.default, L["TYPE_SECONDARY_DEFAULT"];
                end
            end
        else
            if ( EasyMD.config.profile.macros.raid ~= "" ) then
                return EasyMD.config.profile.macros.raid, L["TYPE_RAID"];
            elseif ( EasyMD.config.profile.macros.party ~= "" ) then
                return EasyMD.config.profile.macros.party, L["TYPE_PARTY"];
            else
                return EasyMD.config.profile.macros.default, L["TYPE_DEFAULT"];
            end
        end
    elseif ( mType == "pvp" ) then
        if ( EasyMD.config.profile.main.dualspec and dual ) then
            if ( dual == 1 ) then
                if ( EasyMD.config.profile.macros.primary.pvp ~= "" ) then
                    return EasyMD.config.profile.macros.primary.pvp, L["TYPE_PRIMARY_PVP"];
                elseif ( EasyMD.config.profile.macros.primary.arena ~= "" ) then
                    return EasyMD.config.profile.macros.primary.arena, L["TYPE_PRIMARY_ARENA"];
                else
                    return EasyMD.config.profile.macros.primary.default, L["TYPE_PRIMARY_DEFAULT"];
                end
            else
                if ( EasyMD.config.profile.macros.secondary.pvp ~= "" ) then
                    return EasyMD.config.profile.macros.secondary.pvp, L["TYPE_SECONDARY_PVP"];
                elseif ( EasyMD.config.profile.macros.secondary.arena ~= "" ) then
                    return EasyMD.config.profile.macros.secondary.arena, L["TYPE_SECONDARY_ARENA"];
                else
                    return EasyMD.config.profile.macros.secondary.default, L["TYPE_SECONDARY_DEFAULT"];
                end
            end
        else
            if ( EasyMD.config.profile.macros.pvp ~= "" ) then
                return EasyMD.config.profile.macros.pvp, L["TYPE_PVP"];
            elseif ( EasyMD.config.profile.macros.arena ~= "" ) then
                return EasyMD.config.profile.macros.arena, L["TYPE_ARENA"];
            else
                return EasyMD.config.profile.macros.default, L["TYPE_DEFAULT"];
            end
        end
    elseif ( mType == "arena" ) then
        if ( EasyMD.config.profile.main.dualspec and dual ) then
            if ( dual == 1 ) then
                if ( EasyMD.config.profile.macros.primary.arena ~= "" ) then
                    return EasyMD.config.profile.macros.primary.arena, L["TYPE_PRIMARY_ARENA"];
                elseif ( EasyMD.config.profile.macros.primary.pvp ~= "" ) then
                    return EasyMD.config.profile.macros.primary.pvp, L["TYPE_PRIMARY_PVP"];
                else
                    return EasyMD.config.profile.macros.primary.default, L["TYPE_PRIMARY_DEFAULT"];
                end
            else
                if ( EasyMD.config.profile.macros.secondary.arena ~= "" ) then
                    return EasyMD.config.profile.macros.secondary.arena, L["TYPE_SECONDARY_ARENA"];
                elseif ( EasyMD.config.profile.macros.secondary.pvp ~= "" ) then
                    return EasyMD.config.profile.macros.secondary.pvp, L["TYPE_SECONDARY_PVP"];
                else
                    return EasyMD.config.profile.macros.secondary.default, L["TYPE_SECONDARY_DEFAULT"];
                end
            end
        else
            if ( EasyMD.config.profile.macros.arena ~= "" ) then
                return EasyMD.config.profile.macros.arena, L["TYPE_ARENA"];
            elseif ( EasyMD.config.profile.macros.pvp ~= "" ) then
                return EasyMD.config.profile.macros.pvp, L["TYPE_PVP"];
            else
                return EasyMD.config.profile.macros.default, L["TYPE_DEFAULT"];
            end
        end
    else
        if ( EasyMD.config.profile.main.dualspec and dual ) then
            if ( dual == 1 ) then
                return EasyMD.config.profile.macros.primary.default, L["TYPE_PRIMARY_DEFAULT"];
            else
                return EasyMD.config.profile.macros.secondary.default, L["TYPE_SECONDARY_DEFAULT"];
            end
        else
            return EasyMD.config.profile.macros.default, L["TYPE_DEFAULT"];
        end
    end
end

--- Create or edit the macro body with the given target
-- @param name The macro taget name
-- @param create If true will create the macro
-- @param silent If true do not display messages
-- @param instanceType Forced instance type
-- @return true or false
function EasyMD:SetMacro(name, create, silent, instanceType)
    if ( EasyMD.isDelayed ) then silent = true; end

    if ( MacroFrame and MacroFrame:IsVisible() ) then
        EasyMD.isDelayed = true;
        EasyMD.delayedName = name;
        EasyMD.delayedCreate = create;
        EasyMD.delayedSilence = silence;
        EasyMD.delayedType = instanceType;
        if ( not silent ) then EasyMD:Message(L["MACRO_PANEL_OPEN"], 1, true); end

        return false;
    end

    if ( UnitAffectingCombat("player") ) then
        EasyMD.isDelayed = true;
        EasyMD.delayedName = name;
        EasyMD.delayedCreate = create;
        EasyMD.delayedSilence = silence;
        EasyMD.delayedType = instanceType;
        if ( not silent ) then EasyMD:Message(L["IN_COMBAT"], 1, true); end

        return false;
    end

    name = strtrim(name);
    if ( name == "" ) then
        if ( not silent ) then EasyMD:Message(L["NAME_IS_EMPTY"], 2, true); end

        return false;
    end

    if ( not instanceType ) then _, instanceType = IsInInstance(); end

    local template, message = EasyMD:SetMacroType(instanceType);

    if ( template == "" ) then
        if ( not silent ) then EasyMD:Message(L["TEMPLATE_IS_EMPTY"], 2, true); end

        return false;
    end

    local current, slot = EasyMD:GetMacroInfo();
    -- ###############################################################################################################################################################################################################
    -- TODO: Module multitarget -- Will need to create a function and use it here
    local body, done = sgsub(template, L["MACRO_TARGET"], name, 1);
    -- ###############################################################################################################################################################################################################

    if ( sfind(body, EasyMD.spellName) and done == 0 ) then
        if ( not silent ) then EasyMD:Message(sformat(L["ERROR_SETTING_MACRO"], EasyMD.spellName), 2, true); end

        return false;
    elseif ( not slot and create) then
        if ( not silent ) then EasyMD:Message(L["NO_SLOT_FREE"], 1, true); end

        return false;
    elseif ( not create and current == body ) then
        if ( not silent ) then EasyMD:Message(L["MACRO_ALREADY_SET"], 2, true); end

        return false;
    elseif ( create and not current ) then
        if ( not silent ) then EasyMD:Message(message, 2); end

        if ( EasyMD.config.profile.main.perCharacter == 1 ) then
            CreateMacro(L["MACRO_NAME"], 1, body, 1, 1);
        else
            CreateMacro(L["MACRO_NAME"], 1, body, nil, 1);
        end

        if ( done == 1 ) then            
            if ( not silent ) then EasyMD:Message(sformat(L["MACRO_CREATED_NAME"], name), 1); end
            if ( EasyMD.modules[L["MODULE_NAME_LDB"]] ) then EasyMD.modules[L["MODULE_NAME_LDB"]]:UpdateText(name); end
        else
            if ( not silent ) then EasyMD:Message(L["MACRO_CREATED"], 1); end
            if ( EasyMD.modules[L["MODULE_NAME_LDB"]] ) then EasyMD.modules[L["MODULE_NAME_LDB"]]:UpdateText(L["NOT_AVAILABLE"]); end
        end

        EasyMD.aceConfigRegistry:NotifyChange("Easy Misdirection Configuration");

        return true;
    elseif ( not create ) then
        if ( not silent ) then EasyMD:Message(message, 2); end

        EditMacro(L["MACRO_NAME"], nil, nil, body, 1);

        if ( done == 1 ) then
            if ( not silent ) then EasyMD:Message(sformat(L["MACRO_EDITED_NAME"], name), 1); end
            if ( EasyMD.modules[L["MODULE_NAME_LDB"]] ) then EasyMD.modules[L["MODULE_NAME_LDB"]]:UpdateText(name); end
        else
            if ( not silent ) then EasyMD:Message(L["MACRO_EDITED"], 1); end
            if ( EasyMD.modules[L["MODULE_NAME_LDB"]] ) then EasyMD.modules[L["MODULE_NAME_LDB"]]:UpdateText(L["NOT_AVAILABLE"]); end
        end

        return true;
    end
end

--- Callback function for hook to MacroFrameOnHide
-- Using a timer here, editing the macro too soon did not work
function EasyMD:MacroFrameOnHide()
    if ( EasyMD.isDelayed ) then
        EasyMD:ScheduleTimer("MacroFrameOnHideTimer", 1);
    end
end

--- Callbak function for timer MacroFrameOnHide
function EasyMD:MacroFrameOnHideTimer()
    EasyMD.isDelayed = false;
    EasyMD:SetMacro(EasyMD.delayedName, EasyMD.delayedCreate, EasyMD.delayedSilence, EasyMD.delayedType);
end

--- Callback function for event ZONE_CHANGED_NEW_AREA
function EasyMD:ZONE_CHANGED_NEW_AREA()
    if ( EasyMD.enteringWorld ) then
        if ( UnitIsDeadOrGhost("player") ) then return; end

        local inInstance, instanceType = IsInInstance();

        if ( inInstance and EasyMD.config.profile.main.auto ) then
            local members = EasyMD:GetPartyMembers();

            EasyMD:Message(L["ENTERING_INSTANCE"].." "..EasyMD:GetZone(), 3);

            if ( members ) then
                if ( instanceType == "party" ) then
                    local tank = EasyMD:GetTank(members);

                    if ( tank ) then
                        if ( tank ~= EasyMD:GetTarget() ) then
                            EasyMD:SetMacro(tank);
                            if ( EasyMD.modules[L["MODULE_NAME_PET"]] ) then EasyMD.modules[L["MODULE_NAME_PET"]]:DoCheck(1); end
                        end
                    else
                        EasyMD:Message(L["TANK_NOT_FOUND"], 1, true);
                    end
                elseif ( instanceType == "raid" ) then
                    if ( EasyMD.modules[L["MODULE_NAME_TANKS"]] and EasyMD.modules[L["MODULE_NAME_TANKS"]].config.profile.auto ) then
                        EasyMD.modules[L["MODULE_NAME_TANKS"]]:SetTank();
                    else
                        EasyMD:Message(L["IS_RAID"], 2);
                    end
                end
            end
        elseif ( not inInstance and EasyMD.config.profile.main.autopet ) then
            EasyMD:Message(L["ENTERING_WORLD"].." "..EasyMD:GetZone(), 3);

            if ( EasyMD:GetTarget() ~= L["MACRO_PET"] ) then
                EasyMD:SetMacro(L["MACRO_PET"]);

                if ( EasyMD.modules[L["MODULE_NAME_PET"]] ) then EasyMD.modules[L["MODULE_NAME_PET"]]:DoCheck(2); end
            end
        end

        EasyMD.enteringWorld = false;
    end
end

--- Callback function for event PLAYER_ENTERING_WORLD
-- This event fire every loading screen
-- We want to use this event but it fire too soon
-- Using ZONE_CHANGED_NEW_AREA instead
function EasyMD:PLAYER_ENTERING_WORLD()
    EasyMD.enteringWorld = true;
    if ( EasyMD.isLogin ) then EasyMD.isLogin = false; end
end

--- Callback function for event PARTY_MEMBERS_CHANGED
function EasyMD:PARTY_MEMBERS_CHANGED()
    if ( not EasyMD.enteringWorld ) then
        local inInstance, instanceType = IsInInstance();
        local members = EasyMD:GetPartyMembers();

        if ( inInstance and members and instanceType == ("party") ) then
            local tank = EasyMD:GetTank(members);
            local target = EasyMD:GetTarget();

            if ( tank and EasyMD.config.profile.main.auto ) then
                if ( tank ~= target and not UnitExists(target) ) then
                    EasyMD:Message(L["TANK_CHANGED"], 2);
                    EasyMD:SetMacro(tank);
                end
            elseif ( target ~= L["MACRO_PET"] and EasyMD.config.profile.main.autopet ) then
                EasyMD:Message(L["TANK_LEFT"], 2);
                EasyMD:SetMacro(L["MACRO_PET"]);
            end
        end
    end
end

--- Callback function for event PLAYER_REGEN_ENABLED
-- Fire when the player leave combat
function EasyMD:PLAYER_REGEN_ENABLED()
    if ( EasyMD.isDelayed ) then
        EasyMD.isDelayed = false;
        EasyMD:SetMacro(EasyMD.delayedName, EasyMD.delayedCreate, EasyMD.delayedSilence, EasyMD.delayedType);
    end
end

--- Callback function for event ACTIVE_TALENT_GROUP_CHANGED
-- It seems when login the player is in primary spec
-- if the secondary is the selected spec this event will fire
function EasyMD:ACTIVE_TALENT_GROUP_CHANGED()
    if ( EasyMD.config.profile.main.dualspec ) then
        if ( EasyMD.isLogin ) then
            EasyMD.isLogin = false;
            return;
        end

        local spec,_, talents = EasyMD:GetSpecInfos();
        local name = EasyMD:GetTarget();

        EasyMD:Message(sformat(L["SPEC_CHANGED"], spec, talents), 3);
        EasyMD:SetMacro(name, nil, true);
    end
end

-- Callback function for event UPDATE_MACROS
function EasyMD:UPDATE_MACROS()
    EasyMD.aceConfigRegistry:NotifyChange("Easy Misdirection Configuration");
end

-- Callback function for event ADDON_LOADED
function EasyMD:ADDON_LOADED(eventName, addonName)
    if ( addonName == "Blizzard_MacroUI" ) then EasyMD:HookScript(MacroFrame, "OnHide", "MacroFrameOnHide"); end
end

-- ********************************************************************************
-- Configuration
-- ********************************************************************************

--- Default configation table
local defaultDB =
{
    profile =
    {
        main =
        {
            auto = true,
            autopet = true,
            verbosity = 2,
            dualspec = false,
            perCharacter = 1
        },
        macros =
        {
            default = "#showtooltip\n"..L["MACRO_CAST_COMMAND"].." [@"..L["MACRO_TARGET"].."] "..EasyMD.spellName,
            party = "",
            raid = "",
            pvp = "",
            arena = "",
            primary =
            {
                default = "#showtooltip\n"..L["MACRO_CAST_COMMAND"].." [@"..L["MACRO_TARGET"].."] "..EasyMD.spellName,
                party = "",
                raid = "",
                pvp = "",
                arena = ""
            },
            secondary =
            {
                default = "#showtooltip\n"..L["MACRO_CAST_COMMAND"].." [@"..L["MACRO_TARGET"].."] "..EasyMD.spellName,
                party = "",
                raid = "",
                pvp = "",
                arena = ""
            }
        }
    }
};

--- AceConfig menu
function EasyMD:Config()
    local options =
    {
        type = "group",
        args =
        {
            instructions =
            {
                order = 0,
                name = L["CONFIG_INSTRUCTIONS"],
                type = "group",
                args =
                {
                    header =
                    {
                        order = 0,
                        name = L["ADDON_NAME"].." "..L["VERSION"].." "..EasyMD.color["GREEN"]..EasyMD.version,
                        type = "header"
                    },
                    text =
                    {
                        order = 1,
                        name = sformat(L["INSTRUCTIONS_PAGE"], L["MACRO_NAME"], L["MACRO_TARGET"], sformat(L["MACRO_EXAMPLE"], L["MACRO_CAST_COMMAND"], L["MACRO_TARGET"], EasyMD.spellName)),
                        type = "description",
                        fontSize = "medium"
                    }
                }
            },
            main =
            {
                order = 1,
                name = L["CONFIG_MAIN"],
                type = "group",
                args =
                {
                    headerMain =
                    {
                        order = 0,
                        name = L["CONFIG_MAIN"],
                        type = "header"
                    },
                    auto =
                    {
                        order = 1,
                        name = L["CONFIG_AUTO_NAME"],
                        desc = L["CONFIG_AUTO_DESC"],
                        type = "toggle",
                        width ="full",
                        set = function(info, val) EasyMD.config.profile.main.auto = val; end,
                        get = function(info) return EasyMD.config.profile.main.auto; end
                    },
                    autopet =
                    {
                        order = 2,
                        name = L["CONFIG_AUTOPET_NAME"],
                        desc = L["CONFIG_AUTOPET_DESC"],
                        type = "toggle",
                        width ="full",
                        disabled = function()
                            if ( EasyMD.class == "HUNTER" ) then
                                return false;
                            else
                                return true;
                            end
                        end,
                        set = function(info, val) EasyMD.config.profile.main.autopet = val; end,
                        get = function(info) return EasyMD.config.profile.main.autopet; end
                    },
                    dualspec =
                    {
                        order = 3,
                        name = L["CONFIG_DUALSPEC_NAME"],
                        desc = L["CONFIG_DUALSPEC_DESC"],
                        type = "toggle",
                        width ="full",
                        set = function(info, val) EasyMD.config.profile.main.dualspec = val; end,
                        get = function(info) return EasyMD.config.profile.main.dualspec; end
                    },
                    verbosity =
                    {
                        order = 6,
                        name = L["CONFIG_VERBOSITY_NAME"],
                        desc = L["CONFIG_VERBOSITY_DESC"],
                        type = "select",
                        values = { [0] = L["CONFIG_VERBOSITY_SELECT_0"], [1] = L["CONFIG_VERBOSITY_SELECT_1"], [2] = L["CONFIG_VERBOSITY_SELECT_2"], [3] = L["CONFIG_VERBOSITY_SELECT_3"] },
                        set = function(info, val) EasyMD.config.profile.main.verbosity = val; end,
                        get = function(info) return EasyMD.config.profile.main.verbosity; end
                    },
                    headerModules =
                    {
                        order = 7,
                        name = L["CONFIG_MODULES"],
                        type = "header"
                    }
                }
            }
        }
    };

    -- Modules toggles
    local reloadUI = false;
    local mOrder = { [L["MODULE_NAME_LDB"]] = 10, [L["MODULE_NAME_ANNOUNCE"]] = 8, [L["MODULE_NAME_PET"]] = 9, [L["MODULE_NAME_TANKS"]] = 11 };

    for n,m in EasyMD:IterateModules() do
        options["args"]["main"]["args"][n] =
        {
            order = mOrder[n],
            name = n,
            desc = L["CONFIG_MODULE_ENABLE_DISABLE"],
            type = "toggle",
            width = "full",
            set = function(info, val)
                m.config.profile.enabled = val

                if ( val ) then
                    m:Enable();
                else
                    m:Disable();
                end

                reloadUI = true;
                EasyMD:ModulesTable();
            end,
            get = function(info) return m.config.profile.enabled; end
        };
    end
    options["args"]["main"]["args"]["blankLine1"] =
    {
        order = 100,
        name = "\n",
        type = "description",
        disabled = true,
        width = "full"
    }
    options["args"]["main"]["args"]["reloadui"] =
    {
        order = 101,
        name = L["CONFIG_RELOADUI"],
        desc = L["CONFIG_RELOADUI_DESC"],
        type = "execute",
        hidden = function() return not reloadUI; end,
        func = function() ReloadUI(); end
    }
    options["args"]["main"]["args"]["headerMacro"] =
    {
        order = 102,
        name = L["CONFIG_MACRO"],
        type = "header"
    }
    options["args"]["main"]["args"]["noSlotFree"] =
    {
        order = 103,
        name = EasyMD.color["RED"]..L["NO_SLOT_FREE"].."\n",
        type = "description",
        hidden = function()
            local exists, slotFree = EasyMD:GetMacroInfo();

            if ( not slotFree and not exists) then
                return false;
            else
                return true;
            end
        end,
        fontSize = "medium",
        width = "full"
    }
    options["args"]["main"]["args"]["perCharacter"] =
    {
        order = 104,
        name = L["CONFIG_PERCHARACTER_NAME"],
        desc = L["CONFIG_PERCHARACTER_DESC"],
        type = "select",
        values = { [0] = L["CONFIG_PERCHARACTER_SELECT_0"], [1] = L["CONFIG_PERCHARACTER_SELECT_1"] },
        set = function(info, val)
            if ( MacroFrame and MacroFrame:IsVisible() ) then
                EasyMD:Message(L["MACRO_PANEL_OPEN"], 1, true);
                EasyMD.aceConfigRegistry:NotifyChange("Easy Misdirection Configuration");
            else
                EasyMD.config.profile.main.perCharacter = val;
                DeleteMacro(L["MACRO_NAME"]);

                if ( val == 1 ) then
                    EasyMD:Message(sformat(L["MACRO_CATEGORY_CHANGED"], L["CONFIG_PERCHARACTER_SELECT_1"]), 1);
                else
                    EasyMD:Message(sformat(L["MACRO_CATEGORY_CHANGED"], L["CONFIG_PERCHARACTER_SELECT_0"]), 1);
                end
            end
        end,
        get = function(info) return EasyMD.config.profile.main.perCharacter; end
    }
    options["args"]["main"]["args"]["blankLine2"] =
    {
        order = 105,
        name = "\n",
        type = "description",
        disabled = true,
        width = "full"
    }
    options["args"]["main"]["args"]["macroNotFound"] =
    {
        order = 106,
        name = EasyMD.color["RED"]..L["MACRO_NOT_FOUND"].."\n",
        type = "description",
        hidden = function()
            local exists,_ = EasyMD:GetMacroInfo();

            if ( exists ) then
                return true;
            else
                return false;
            end
        end,
        fontSize = "medium",
        width = "full"
    }
    options["args"]["main"]["args"]["create"] =
    {
        order = 107,
        name = L["CONFIG_CREATE_NAME"],
        desc = sformat(L["CONFIG_CREATE_DESC"], L["MACRO_NAME"]),
        type = "execute",
        func = function()
            if ( EasyMD.class == "HUNTER" ) then
                EasyMD:SetMacro(L["MACRO_PET"], true);
            else
                EasyMD:SetMacro(L["MACRO_FOCUS"], true);
            end
        end
    }
    options["args"]["macros"] =
    {
        order = 2,
        name = L["CONFIG_MACROS"],
        type = "group",
        args =
        {
            -- Macros whithout dualspec
            header =
            {
                order = 0,
                name = L["CONFIG_MACROS"],
                type = "header",
                hidden = function() return EasyMD.config.profile.main.dualspec; end,
            },
            default =
            {
                order = 1,
                name = L["DEFAULT"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.default = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.default; end
            },
            party =
            {
                order = 2,
                name = L["PARTY"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.party = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.party; end
            },
            raid =
            {
                order = 3,
                name = L["RAID"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.raid = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.raid; end
            },
            pvp =
            {
                order = 4,
                name = L["PVP"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.pvp = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.pvp; end
            },
            arena =
            {
                order = 5,
                name = L["ARENA"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.arena = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.arena; end
            },
            -- Macros with primary spec
            headerPrimary =
            {
                order = 100,
                name = L["PRIMARY"].." "..L["SPECIALISATION"],
                type = "header",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end
            },
            defaultPrimary =
            {
                order = 101,
                name = L["DEFAULT"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.primary.default = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.primary.default; end
            },
            partyPrimary =
            {
                order = 102,
                name = L["PARTY"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.primary.party = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.primary.party; end
            },
            raidPrimary =
            {
                order = 103,
                name = L["RAID"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.primary.raid = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.primary.raid; end
            },
            pvpPrimary =
            {
                order = 104,
                name = L["PVP"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.primary.pvp = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.primary.pvp; end
            },
            arenaPrimary =
            {
                order = 105,
                name = L["ARENA"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.primary.arena = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.primary.arena; end
            },
            -- Macros with secondary spec
            headerSecondary =
            {
                order = 200,
                name = L["SECONDARY"].." "..L["SPECIALISATION"],
                type = "header",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end
            },
            defaultSecondary =
            {
                order = 201,
                name = L["DEFAULT"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.secondary.default = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.secondary.default; end
            },
            partySecondary =
            {
                order = 202,
                name = L["PARTY"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.secondary.party = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.secondary.party; end
            },
            raidSecondary =
            {
                order = 203,
                name = L["RAID"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.secondary.raid = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.secondary.raid; end
            },
            pvpSecondary =
            {
                order = 204,
                name = L["PVP"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.secondary.pvp = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.secondary.pvp; end
            },
            arenaSecondary =
            {
                order = 205,
                name = L["ARENA"],
                desc = sformat(L["CONFIG_MACROBODY_DESC"], L["MACRO_TARGET"]),
                type = "input",
                multiline = true,
                width ="full",
                hidden = function() return not EasyMD.config.profile.main.dualspec; end,
                set = function(info, val)
                    EasyMD.config.profile.macros.secondary.arena = val;
                    EasyMD:MacroLen(val);
                end,
                get = function(info) return EasyMD.config.profile.macros.secondary.arena; end
            },
        }
    };

    -- Modules
    wipe(mOrder);
    local mOrder = { [L["MODULE_NAME_LDB"]] = 5, [L["MODULE_NAME_ANNOUNCE"]] = 3, [L["MODULE_NAME_PET"]] = 4, [L["MODULE_NAME_TANKS"]] = 6 };
    for n,m in EasyMD:IterateModules() do
        local t = m:Config();

        options["args"][n] =
        {
            order = mOrder[n],
            name = L["CONFIG_MODULES_PREFIX"]..n,
            disabled = function() return not m:IsEnabled(); end,
            type = "group"
        }
        options["args"][n]["args"] = {};

        for k,v in pairs(t) do
            options["args"][n]["args"][k] = v;
        end
    end

    -- Profiles
    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(EasyMD.config);

    return options;
end

-- ********************************************************************************
-- Main
-- ********************************************************************************

--- AceAddon callback
-- Called after the addon is fully loaded
function EasyMD:OnInitialize()
    -- Config db
    EasyMD.config = LibStub("AceDB-3.0"):New("easyMDConfig", defaultDB);

    -- Slash command
    EasyMD:RegisterChatCommand("easymd", "SlashCommand");
    EasyMD:RegisterChatCommand("md", "SlashCommand");
end

--- AceAddon callback
-- Called during the PLAYER_LOGIN event
function EasyMD:OnEnable()
    -- Config
    LibStub("AceConfig-3.0"):RegisterOptionsTable("Easy Misdirection Configuration", EasyMD:Config());
    EasyMD.aceConfigDialog:SetDefaultSize("Easy Misdirection Configuration", 800, 500);
    EasyMD.aceConfigDialog:AddToBlizOptions("Easy Misdirection Configuration", L["ADDON_NAME"]);

    -- Events
    EasyMD:RegisterEvent("PLAYER_ENTERING_WORLD");
    EasyMD:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    EasyMD:RegisterEvent("PARTY_MEMBERS_CHANGED");
    EasyMD:RegisterEvent("PLAYER_REGEN_ENABLED");
    EasyMD:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
    EasyMD:RegisterEvent("UPDATE_MACROS");
    EasyMD:RegisterEvent("ADDON_LOADED");

    -- Set modules objects table
    EasyMD:ModulesTable();

    -- Disable auto pet options in config
    if ( EasyMD.class ~= "HUNTER" ) then EasyMD.config.profile.main.autopet = false; end
end
