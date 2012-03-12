--This file is copied from Blizzard SecureGroupHeaders.lua (SecureTemplates.lua before 4.0)
--The goal is copy the method SecureGroupHeader_Update to return a sortingTable
--So all relating local functions should be copied 
-- and change SecureGroupHeader_Update to SecureGroupHeader_UpdateCopy
-- and make SecureGroupHeader_UpdateCopy return the sortingTable

local function GetGroupHeaderType(self)
    local type, start, stop;

    local nRaid = GetNumRaidMembers();
    local nParty = GetNumPartyMembers();
    if ( nRaid > 0 and self:GetAttribute("showRaid") ) then
        type = "RAID";
    elseif ( (nRaid > 0 or nParty > 0) and self:GetAttribute("showParty") ) then
        type = "PARTY";
    elseif ( self:GetAttribute("showSolo") ) then
        type = "SOLO";
    end
    if ( type ) then
        if ( type == "RAID" ) then
            start = 1;
            stop = nRaid;
        else
            if ( type == "SOLO" or self:GetAttribute("showPlayer") ) then
                start = 0;
            else
                start = 1;
            end
            stop = nParty;
        end
    end
    return type, start, stop;
end

local function GetGroupRosterInfo(type, index)
    local _, unit, name, subgroup, className, role, server;
    if ( type == "RAID" ) then
        unit = "raid"..index;
        name, _, subgroup, _, _, className, _, _, _, role = GetRaidRosterInfo(index);
    else
        if ( index > 0 ) then
            unit = "party"..index;
        else
            unit = "player";
        end
        if ( UnitExists(unit) ) then
            name, server = UnitName(unit);
            if (server and server ~= "") then
                name = name.."-"..server
            end
            _, className = UnitClass(unit);
            if ( GetPartyAssignment("MAINTANK", unit) ) then
                role = "MAINTANK";
            elseif ( GetPartyAssignment("MAINASSIST", unit) ) then
                role = "MAINASSIST";
            end
        end
        subgroup = 1;
    end
    return unit, name, subgroup, className, role;
end

local pairs = pairs;
local ipairs = ipairs;
local strtrim = string.trim;

-- empties tbl and assigns the value true to each key passed as part of ...
local function fillTable( tbl, ... )
    for i = 1, select("#", ...), 1 do
        local key = select(i, ...);
        key = tonumber(key) or strtrim(key);
        tbl[key] = i;
    end
end

-- same as fillTable() except that each key is also stored in
-- the array portion of the table in order
local function doubleFillTable( tbl, ... )
    fillTable(tbl, ...);
    for i = 1, select("#", ...), 1 do
        tbl[i] = strtrim(select(i, ...));
    end
end

--working tables
local tokenTable = {};
local sortingTable = {};
local groupingTable = {};
local tempTable = {};
local function sortOnGroupWithNames(a, b)
    local order1 = tokenTable[ groupingTable[a] ];
    local order2 = tokenTable[ groupingTable[b] ];
    if ( order1 ) then
        if ( not order2 ) then
            return true;
        else
            if ( order1 == order2 ) then
                return sortingTable[a] < sortingTable[b];
            else
                return order1 < order2;
            end
        end
    else
        if ( order2 ) then
            return false;
        else
            return sortingTable[a] < sortingTable[b];
        end
    end
end
local function sortOnGroupWithIDs(a, b)
    local order1 = tokenTable[ groupingTable[a] ];
    local order2 = tokenTable[ groupingTable[b] ];
    if ( order1 ) then
        if ( not order2 ) then
            return true;
        else
            if ( order1 == order2 ) then
                return tonumber(a:match("%d+") or -1) < tonumber(b:match("%d+") or -1);
            else
                return order1 < order2;
            end
        end
    else
        if ( order2 ) then
            return false;
        else
            return tonumber(a:match("%d+") or -1) < tonumber(b:match("%d+") or -1);
        end
    end
end
local function sortOnNames(a, b)
    return sortingTable[a] < sortingTable[b];
end
function SecureGroupHeader_UpdateCopy(self)
    local nameList = self:GetAttribute("nameList");
    local groupFilter = self:GetAttribute("groupFilter");
    local sortMethod = self:GetAttribute("sortMethod");
    local groupBy = self:GetAttribute("groupBy");

    wipe(sortingTable);

    -- See if this header should be shown
    local type, start, stop = GetGroupHeaderType(self);
    if ( not type ) then
        configureChildren(self, sortingTable);
        return;
    end

    if ( not groupFilter and not nameList ) then
        groupFilter = "1,2,3,4,5,6,7,8";
    end

    if ( groupFilter ) then
        -- filtering by a list of group numbers and/or classes
        fillTable(wipe(tokenTable), strsplit(",", groupFilter));
        local strictFiltering = self:GetAttribute("strictFiltering"); -- non-strict by default
        for i = start, stop, 1 do
            local unit, name, subgroup, className, role = GetGroupRosterInfo(type, i);
            if ( name and
                ((not strictFiltering) and
                 (tokenTable[subgroup] or tokenTable[className] or (role and tokenTable[role])) -- non-strict filtering
             ) or
                (tokenTable[subgroup] and tokenTable[className]) -- strict filtering
            ) then
                tinsert(sortingTable, unit);
                sortingTable[unit] = name;
                if ( groupBy == "GROUP" ) then
                    groupingTable[unit] = subgroup;

                elseif ( groupBy == "CLASS" ) then
                    groupingTable[unit] = className;

                elseif ( groupBy == "ROLE" ) then
                    groupingTable[unit] = role;

                end
            end
        end

        if ( groupBy ) then
            local groupingOrder = self:GetAttribute("groupingOrder");
            doubleFillTable(wipe(tokenTable), strsplit(",", groupingOrder:gsub("%s+", "")));
            if ( sortMethod == "NAME" ) then
                table.sort(sortingTable, sortOnGroupWithNames);
            else
                table.sort(sortingTable, sortOnGroupWithIDs);
            end
        elseif ( sortMethod == "NAME" ) then -- sort by ID by default
            table.sort(sortingTable, sortOnNames);
        end            

    else
        -- filtering via a list of names
        doubleFillTable(wipe(tokenTable), strsplit(",", nameList));
        for i = start, stop, 1 do
            local unit, name = GetGroupRosterInfo(type, i);
            if ( tokenTable[name] ) then
                tinsert(sortingTable, unit);
                sortingTable[unit] = name;
            end
        end
        if ( sortMethod == "NAME" ) then
            table.sort(sortingTable, sortOnNames);
        end

    end

    return sortingTable;
end