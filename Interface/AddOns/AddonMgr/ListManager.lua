-- This holds the code that relates to managing the lists of addons and addon groups

-- This must be able to update the current addon list frame to a state that has
-- been provided, without creating excess frames

-- This must be able to provide a list of the states of the addon entries
-- suitable for saving

-- It must be possible to ensure that all addon entries for a given addon
-- are in the same state

-- It must be possible to ensure that add addon groups are in a state reflecting
-- their content

-- These lists contain all entries and groups created
-- The entries are keyed by the addon folder name
-- The groups are keyed by insert order
local addonListEntries, addonListGroups;

-- These lists contain the entries and groups that have been created
-- but are currently unused
-- The entries are keyed by the addon folder name
-- The groups are keyed by insert order
local unusedAddonListEntries, unusedAddonListGroups;

addonListEntries       = {};
addonListGroups        = {};
unusedAddonListEntries = {};
unusedAddonListGroups  = {};

-- This 'makes' an addon entry for the specified
-- addon folder name. This may return a previously
-- unused addon. This is intended only to be used
-- by ListManager_Make_AddonListGroup
function ListManager_Make_AddonListEntry(name)
    local entry;
    
    if addonListEntries[name] == nil
    then
        addonListEntries[name] = {};
    end
    if #unusedAddonListEntries ~= 0
    then
        entry = table.remove(unusedAddonListEntries);
        
        UpdateAddonListEntry(entry, name, ListManager_AddonListEntry_SelectorOnClick);
        entry:Show();
    else
        entry = MakeAddonListEntry(name, ListManager_AddonListEntry_SelectorOnClick);
    end
    
    entry:SetChecked(ListManager_GetIndividualEntryState(name));
    table.insert(addonListEntries[name], entry);
    
    return entry;
end

-- This 'makes' a new addon list group with the entries
-- specified by addon folder name in a list
function ListManager_Make_AddonListGroup(name, entries)
    local group;
    
    -- Get the group frame to use
    if #unusedAddonListGroups ~= 0
    then
        group = table.remove(unusedAddonListGroups);
        group:Show();
    else
        -- need to sort out onUpdate
        group = MakeAddonListGroup(name);
        table.insert(addonListGroups, group);
    end
    
    -- This puts the addon entries into a table that
    -- has an index of the DISPLAYED name
    -- Then, when they are sorted, the result is as expected
    local addonArray = {};
    for name, _ in pairs(entries)
    do
        entry = ListManager_Make_AddonListEntry(name);
        addonArray[entry:GetTitle()] = entry;
    end
    
    -- finally, add the sorted entries to the group frame
    for _, entry in Template_SortedPairs(addonArray)
    do
        group:AddEntry(entry);
    end
    
    -- Setting the title here means that the title can include
    -- the correct number of group elements
    group:SetTitle(name);
    
    return group;
end

-- This prepares the addon list entry for reuse.
-- Primarily by removing it from the synchronization list
-- which prevents future reassignment from causing synchronization
-- errors.
function ListManager_Delete_AddonListEntry(entry)
    for index, comparison in pairs(addonListEntries[entry:GetName()])
    do
        if comparison == entry
        then
            table.remove(addonListEntries[entry:GetName()], index);
            break;
        end
    end
    
    table.insert(unusedAddonListEntries, entry);
    
    entry:Hide();
    entry:ClearFilter();
end

-- This prepares the addon list group and contained entries
-- for reuse
function ListManager_Delete_AddonListGroup(group)
    for _, entry in group:GetEntries()
    do
        ListManager_Delete_AddonListEntry(entry);
    end
    
    table.insert(unusedAddonListGroups, group);
    group:Hide();
    group:ClearEntries();
    group:DoCollapse();
    group:ClearFilter();
end

-- This clears all of the groups associated with the addon list frame
-- preparing them for reuse
function ListManager_Delete_AddonListFrame(addonListFrame)
    if addonListFrame.entries == nil
    then
        return;
    end
    
    for _, addonGroupEntry in pairs(addonListFrame.entries)
    do
        ListManager_Delete_AddonListGroup(addonGroupEntry);
    end
    AddonListFrame_ClearEntries(addonListFrame);
end

-- This provides a list of the states of the addon entries
-- the keys for the list is the folder name of the addon
function ListManager_GetEntryState()
    local state;
    
    state = {};
    
    for name, list in pairs(addonListEntries)
    do
        state[name] = list[1]:GetChecked();
    end
    
    return state;
end

-- This updates all addon list entries to reflect
-- the state provided
function ListManager_SetEntryState(state)
    for name, _ in pairs(addonListEntries)
    do
        for _, addonEntry in pairs(addonListEntries[name])
        do
            addonEntry:SetChecked(state[name]);
        end
    end
end

function ListManager_GetIndividualEntryState(name)
    if addonListEntries[name] == nil or #addonListEntries[name] == 0
    then
        local _, _, _, state = GetAddOnInfo(name);
        
        return state;
    end
    
    return addonListEntries[name][1]:GetChecked();
end

-- This updates the state of all addon entries for
-- a specific name
function ListManager_UpdateEntryState(name, state)
    for _, entry in pairs(addonListEntries[name])
    do
        entry:SetChecked(state);
    end
end

-- This sets all of the entries to the checked state
function ListManager_CheckAllEntries()
    for _, list in pairs(addonListEntries)
    do
        for _, entry in pairs(list)
        do
            entry:SetChecked(0);
        end
    end
end

-- This sets all of the entries to the unchecked state
function ListManager_ClearAllEntries()
    for _, list in pairs(addonListEntries)
    do
        for _, entry in pairs(list)
        do
            entry:SetChecked(0);
        end
    end
end

function ListManager_AddonListEntry_SelectorOnClick(name, checked)
    ListManager_UpdateEntryState(name, checked); 
    ListManager_UpdateGroupStates();
end

-- This updates the state of all of the addon groups
-- to reflect the state of the contained addons
function ListManager_UpdateGroupStates()
    for _, group in pairs(addonListGroups)
    do
        group:UpdateChecked();
    end
end