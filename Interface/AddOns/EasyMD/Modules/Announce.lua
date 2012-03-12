-- ********************************************************************************
-- Easy Misdirection (EasyMD)
-- The easiest way to create/edit a misdirection macro.
-- By: Shenton
--
-- Announce.lua
-- ********************************************************************************

-- If EasyMD core is not loaded stop the script
if ( not EasyMD ) then return; end

local L = LibStub("AceLocale-3.0"):GetLocale("EasyMD");
local ANN = EasyMD:NewModule(L["MODULE_NAME_ANNOUNCE"], "AceEvent-3.0");

-- ********************************************************************************
-- Variables or "constants"
-- ********************************************************************************

-- Local LUA functions
local sformat = string.format;

-- ********************************************************************************
-- Functions
-- ********************************************************************************

--- Will display the announce depending on location and options
-- @param name The misdirection target name
function ANN:Announce(name)
    local numRaid, numParty = GetNumRaidMembers(), GetNumPartyMembers();

    if ( ANN.config.profile.raid and numRaid > 0 ) then
        SendChatMessage(sformat(L["MODULE_ANNOUNCE_SENTENCE"], GetSpellLink(EasyMD.spellId), name), "RAID");
    elseif ( ANN.config.profile.party and numParty > 0 and numRaid == 0 ) then
        SendChatMessage(sformat(L["MODULE_ANNOUNCE_SENTENCE"], GetSpellLink(EasyMD.spellId), name), "PARTY");
    end

    if ( ANN.config.profile.whisper and UnitIsPlayer(name) ) then
        SendChatMessage(sformat(L["MODULE_ANNOUNCE_WHISPER"], GetSpellLink(EasyMD.spellId)), "WHISPER", nil, name);
    end

    if ( ANN.config.profile.say ) then
        SendChatMessage(sformat(L["MODULE_ANNOUNCE_SENTENCE"], GetSpellLink(EasyMD.spellId), name), "SAY");
    end

    if ( ANN.config.profile.yell ) then
        SendChatMessage(sformat(L["MODULE_ANNOUNCE_SENTENCE"], GetSpellLink(EasyMD.spellId), name), "YELL");
    end
end

--- Callback function for event COMBAT_LOG_EVENT_UNFILTERED
function ANN:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
    local _,type,_,_,sourceName,_,_,_,destName,_,_,spellId = ...;

    if ( type == "SPELL_CAST_SUCCESS" and spellId == EasyMD.spellId and sourceName == UnitName("player") ) then
        if ( UnitIsUnit(destName, "pet") or UnitIsUnit(destName, "focus") or UnitName(destName) == EasyMD:GetTarget() ) then
            ANN:Announce(UnitName(destName));
        end
    end
end

-- ********************************************************************************
-- Configuration
-- ********************************************************************************

--- Default configuration table
local defaultDB =
{
    profile =
    {
        party = true,
        raid = true,
        whisper = false,
        say = false,
        yell = false,
        enabled = true
    }
};

function ANN:Config()
    return
    {
        ANNHeader =
        {
            order = 0,
            name = L["MODULE_NAME_ANNOUNCE"],
            type = "header"
        },
        party =
        {
            order = 1,
            name = L["CONFIG_ANNOUNCE_PARTY"],
            desc = sformat(L["CONFIG_ANNOUNCE_PARTY_DESC"], EasyMD.spellName),
            type = "toggle",
            width ="full",
            set = function(info, val) ANN.config.profile.party = val; end,
            get = function(info) return ANN.config.profile.party; end
        },
        raid =
        {
            order = 2,
            name = L["CONFIG_ANNOUNCE_RAID"],
            desc = sformat(L["CONFIG_ANNOUNCE_RAID_DESC"], EasyMD.spellName),
            type = "toggle",
            width ="full",
            set = function(info, val) ANN.config.profile.raid = val; end,
            get = function(info) return ANN.config.profile.raid; end
        },
        whisper =
        {
            order = 3,
            name = L["CONFIG_ANNOUNCE_WHISPER"],
            desc = sformat(L["CONFIG_ANNOUNCE_WHISPER_DESC"], EasyMD.spellName),
            type = "toggle",
            width ="full",
            set = function(info, val) ANN.config.profile.whisper = val; end,
            get = function(info) return ANN.config.profile.whisper; end
        },
        say =
        {
            order = 4,
            name = L["CONFIG_ANNOUNCE_SAY"],
            desc = sformat(L["CONFIG_ANNOUNCE_SAY_DESC"], EasyMD.spellName),
            type = "toggle",
            width ="full",
            set = function(info, val) ANN.config.profile.say = val; end,
            get = function(info) return ANN.config.profile.say; end
        },
        yell =
        {
            order = 5,
            name = L["CONFIG_ANNOUNCE_YELL"],
            desc = sformat(L["CONFIG_ANNOUNCE_YELL_DESC"], EasyMD.spellName),
            type = "toggle",
            width ="full",
            set = function(info, val) ANN.config.profile.yell = val; end,
            get = function(info) return ANN.config.profile.yell; end
        }
    };
end

-- ********************************************************************************
-- Main
-- ********************************************************************************

--- AceAddon callback
-- Called after the addon is fully loaded
function ANN:OnInitialize()
    ANN.config = EasyMD.config:RegisterNamespace("ANN", defaultDB);
    if not ANN.config.profile.enabled then ANN:SetEnabledState(false); end
end

--- AceAddon callback
-- Called during the PLAYER_LOGIN event
function ANN:OnEnable()
    -- Events
    ANN:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
end

--- AceAddon callback
-- Called when the addon is manually disabled
function ANN:OnDisable()
    -- Events
    ANN:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
end
