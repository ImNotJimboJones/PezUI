-- ********************************************************************************
-- Easy Misdirection (EasyMD)
-- The easiest way to create/edit a misdirection macro.
-- By: Shenton
--
-- Tanks.lua
-- ********************************************************************************

-- If EasyMD core is not loaded stop the script
if ( not EasyMD ) then return; end

local L = LibStub("AceLocale-3.0"):GetLocale("EasyMD");
local TANKS = EasyMD:NewModule(L["MODULE_NAME_TANKS"]);

-- ********************************************************************************
-- Variables or "constants"
-- ********************************************************************************

-- Local LUA functions
local sfind, ssub, type, ipairs = string.find, string.sub, type, ipairs;

-- ********************************************************************************
-- Functions
-- ********************************************************************************

--- Return the position of an item in a table
-- @param table The table
-- @param item The item
-- @return the item pos or false
function TANKS:ItemPos(table, item)
    local index = 1;

    while table[index] do
        if ( item == table[index] ) then
            return index;
        end

        index = index + 1;
   end

   return false;
end

--- Return the tanks list as a table
-- @return tanks list table
function TANKS:GetTanksList()
    local t, s, e, p, n = {}, 0, 0, 1, "";

    while true do
        s, e = sfind(TANKS.config.profile.tanks, "\n", p);
        if ( s ) then
            n = strtrim(ssub(TANKS.config.profile.tanks, p, s-1));
            if ( n ~= "" ) then t[#t+1] = n; end
            p = e+1;
        else
            break;
        end
    end

    if ( #t == 0 ) then EasyMD:Message(L["TANKS_ENABLED_NO_LIST"], 2, true); end

    return t;
end

--- Set the macro with the first tank found in the list
-- @param tanks The tanks list (optional)
function TANKS:SetTank(tanks)
    if ( not tanks ) then tanks = TANKS:GetTanksList(); end

    for _,v in ipairs(tanks) do
        if ( v ~= "" and UnitExists(v) ) then
            EasyMD:SetMacro(v);
            return;
        end
    end
end

--- Cicle through tanks and set the macro if the tank exists
-- It will use SetTank() if the macro is not set to a tank in the list
function TANKS:CicleTanks()
    local tank, tanks = EasyMD:GetTarget(), TANKS:GetTanksList();
    local pos = TANKS:ItemPos(tanks, tank);

    if ( pos ) then
        local index = 1;
        for i in ipairs(tanks) do
            if ( pos+i <= #tanks ) then
                if ( tanks[pos+i] ~= "" and UnitExists(tanks[pos+i]) ) then
                    EasyMD:SetMacro(tanks[pos+i]);
                    return;
                end
            else
                if ( tanks[index] ~= "" and UnitExists(tanks[index]) ) then
                    EasyMD:SetMacro(tanks[index]);
                    return;
                end

                index = index+1;
            end
        end
    else
        TANKS:SetTank(tanks);
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
        tanks = "",
        auto = true,
        enabled = true
    }
};

function TANKS:Config()
    return
    {
        Header =
        {
            order = 0,
            name = L["CONFIG_INSTRUCTIONS"],
            type = "header"
        },
        text =
        {
            order = 1,
            name = L["INSTRUCTIONS_TANKS"],
            type = "description",
            fontSize = "medium"
        },
        TanksHeader =
        {
            order = 2,
            name = L["MODULE_NAME_TANKS"],
            type = "header"
        },
        auto =
        {
            order = 3,
            name = L["CONFIG_AUTO_NAME"],
            desc = "",
            type = "toggle",
            width ="full",
            set = function(info, val) TANKS.config.profile.auto = val; end,
            get = function(info) return TANKS.config.profile.auto; end
        },
        tanks =
        {
            order = 4,
            name = L["CONFIG_TANKS_LIST"],
            desc = L["CONFIG_TANKS_LIST_DESC"],
            type = "input",
            multiline = true,
            width ="double",
            set = function(info, val) TANKS.config.profile.tanks = strtrim(val).."\n"; end,
            get = function(info) return TANKS.config.profile.tanks; end
        }
    };
end

-- ********************************************************************************
-- Main
-- ********************************************************************************

--- AceAddon callback
-- Called after the addon is fully loaded
function TANKS:OnInitialize()
    TANKS.config = EasyMD.config:RegisterNamespace("TANKS", defaultDB);
    if not TANKS.config.profile.enabled then TANKS:SetEnabledState(false); end
end
