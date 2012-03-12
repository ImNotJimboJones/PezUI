-- ********************************************************************************
-- Easy Misdirection (EasyMD)
-- The easiest way to create/edit a misdirection macro.
-- By: Shenton
--
-- Pet.lua
-- ********************************************************************************

-- If EasyMD core is not loaded stop the script
if ( not EasyMD ) then return; end

-- If not an hunter stop the script
if ( EasyMD.class ~= "HUNTER" ) then return; end

local L = LibStub("AceLocale-3.0"):GetLocale("EasyMD");
local PET = EasyMD:NewModule(L["MODULE_NAME_PET"], "AceEvent-3.0", "AceTimer-3.0");

-- ********************************************************************************
-- Variables or "constants"
-- ********************************************************************************

-- Local LUA functions
local sformat = string.format;

-- Growl spell id 2649
PET.growl,_,_,_,_,_,_,_,_ = GetSpellInfo(2649);

-- Cower spell id 1742
PET.cower,_,_,_,_,_,_,_,_ = GetSpellInfo(1742);

-- Cooldown timer bool
PET.onCooldown = false;

-- ********************************************************************************
-- Functions
-- ********************************************************************************

--- Display the reminder message depending on options and auto cast state
-- @param emd If called from EasyMD, 1 setting macro to a tank, 2 to the pet
function PET:DoCheck(emd)
    -- Called from EasyMD
    if ( emd ) then
        if ( emd == 1 ) then
            local _, autoState = GetSpellAutocast(PET.growl, BOOKTYPE_PET);

            if ( autoState and PET.config.profile.growl == 3 ) then EasyMD:Message(L["DEACTIVATE_GROWL"], 0); end
            _, autoState = GetSpellAutocast(PET.cower, BOOKTYPE_PET);
            if ( not autoState and PET.config.profile.cower == 3 ) then EasyMD:Message(L["ACTIVATE_COWER"], 0); end
        else
            local _, autoState = GetSpellAutocast(PET.growl, BOOKTYPE_PET);

            if ( not autoState and PET.config.profile.growl == 3 ) then EasyMD:Message(L["ACTIVATE_GROWL"], 0); end
            _, autoState = GetSpellAutocast(PET.cower, BOOKTYPE_PET);
            if ( autoState and PET.config.profile.cower == 3 ) then EasyMD:Message(L["DEACTIVATE_COWER"], 0); end
        end

        return;
    end

    -- On cooldown
    if ( PET.onCooldown ) then return; end

    -- Growl
    if ( PET.config.profile.growl ~= 0 and PET.config.profile.growl ~= 3 ) then
        local _, autoState = GetSpellAutocast(PET.growl, BOOKTYPE_PET);

        if ( autoState and PET.config.profile.growl == 1 ) then
            EasyMD:Message(L["DEACTIVATE_GROWL"], 0);
            PET:ScheduleTimer("DoCheckTimer", PET.config.profile.timer);
            PET.onCooldown = true;
        elseif ( not autoState and PET.config.profile.growl == 2 ) then
            EasyMD:Message(L["ACTIVATE_GROWL"], 0);
            PET:ScheduleTimer("DoCheckTimer", PET.config.profile.timer);
            PET.onCooldown = true;
        end
    end

    -- Cower
    if ( PET.config.profile.cower ~= 0 and PET.config.profile.cower ~= 3 ) then
        local _, autoState = GetSpellAutocast(PET.cower, BOOKTYPE_PET);

        if ( autoState and PET.config.profile.cower == 1 ) then
            EasyMD:Message(L["DEACTIVATE_COWER"], 0);
            PET:ScheduleTimer("DoCheckTimer", PET.config.profile.timer);
            PET.onCooldown = true;
        elseif ( not autoState and PET.config.profile.cower == 2 ) then
            EasyMD:Message(L["ACTIVATE_COWER"], 0);
            PET:ScheduleTimer("DoCheckTimer", PET.config.profile.timer);
            PET.onCooldown = true;
        end
    end
end

--- Callback function for timer DoCheck
function PET:DoCheckTimer()
    PET.onCooldown = false;
end

--- Callback function for event UNIT_PET
function PET:UNIT_PET()
    PET:DoCheck();
end

-- ********************************************************************************
-- Configuration
-- ********************************************************************************

--- Default configuration table
local defaultDB =
{
    profile =
    {
        growl = 3,
        cower = 1,
        timer = 60,
        enabled = true,
    }
};

function PET:Config()
    return
    {
        PETHeader =
        {
            order = 0,
            name = L["MODULE_NAME_PET"],
            type = "header"
        },
        growl =
        {
            order = 1,
            name = L["CONFIG_GROWL_NAME"],
            desc = sformat(L["CONFIG_PET_DESC"], L["ADDON_NAME"], L["ADDON_NAME"]),
            type = "select",
            values = { [0] = L["CONFIG_PET_SELECT_0"], [1] = L["CONFIG_PET_SELECT_1"], [2] = L["CONFIG_PET_SELECT_2"], [3] = sformat(L["CONFIG_PET_SELECT_3"], L["ADDON_NAME"]) },
            set = function(info, val) PET.config.profile.growl = val; end,
            get = function(info) return PET.config.profile.growl; end
        },
        cower =
        {
            order = 2,
            name = L["CONFIG_COWER_NAME"],
            desc = sformat(L["CONFIG_PET_DESC"], L["ADDON_NAME"], L["ADDON_NAME"]),
            type = "select",
            values = { [0] = L["CONFIG_PET_SELECT_0"], [1] = L["CONFIG_PET_SELECT_1"], [2] = L["CONFIG_PET_SELECT_2"], [3] = sformat(L["CONFIG_PET_SELECT_3"], L["ADDON_NAME"]) },
            set = function(info, val) PET.config.profile.cower = val; end,
            get = function(info) return PET.config.profile.cower; end
        },
        timer =
        {
            order = 3,
            name = L["CONFIG_PET_TIMER_NAME"],
            desc = L["CONFIG_PET_TIMER_DESC"],
            type = "select",
            values = { [60] = L["CONFIG_PET_TIMER_0"], [300] = L["CONFIG_PET_TIMER_1"], [600] = L["CONFIG_PET_TIMER_2"] },
            set = function(info, val) PET.config.profile.timer = val; end,
            get = function(info) return PET.config.profile.timer; end
        }
    };
end

-- ********************************************************************************
-- Main
-- ********************************************************************************

--- AceAddon callback
-- Called after the addon is fully loaded
function PET:OnInitialize()
    PET.config = EasyMD.config:RegisterNamespace("PET", defaultDB);
    if not PET.config.profile.enabled then PET:SetEnabledState(false); end
end

--- AceAddon callback
-- Called during the PLAYER_LOGIN event
function PET:OnEnable()
    -- Events
    PET:RegisterEvent("UNIT_PET");
end

--- AceAddon callback
-- Called when the addon is manually disabled
function PET:OnDisable()
    -- Events
    PET:UnregisterEvent("UNIT_PET");
end
