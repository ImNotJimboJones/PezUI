
-- The Groups.lua file uses the following variables
-- SavedGroupConfigurations
--      This is the persistent saved state of the groups
-- groupSavesMenu
--      This is a cached version of the SavedGroupConfigurations
--      which is used to populate the drop down menu
-- groupsAddonArray
--      This is the list of AddonListEntry checkboxes which
--      are used by the user

local groupsAddonArray, groupSavesMenu;
groupsAddonArray = {};
groupSavesMenu = {};

function Groups_Initialize(frame)
    local addonName, addonEntry;
    
    -- The groupSavesMenu can only be initialized
    -- from the SavedGroupConfigurations when the
    -- VARIABLES_LOADED event is fired
    frame:RegisterEvent("ADDON_LOADED");
    frame:SetScript("OnEvent", function (self, event, ...) 
        if event == "ADDON_LOADED"
        then
            Groups_Initialize_CreateMenuCache(frame);
        end
    end);
    groupsAddonArray = Groups_Initialize_CreateGroupsAddonArray(frame);
    
    -- update the addon frame so that it is appropriate for saving groups
    AddonListFrame_SetTitle(frame, "Addon Groups");
    AddonListFrame_Search_SetHandler(frame, function () Groups_Search_Handler(frame) end);
    AddonListFrame_DisableButton_SetTitle(frame, "Clear All");
    AddonListFrame_DisableButton_SetOnClick(frame, function () Groups_DisableButton_OnClick(frame) end);
    AddonListFrame_EnableButton_SetTitle(frame, "Select All");
    AddonListFrame_EnableButton_SetOnClick(frame, function () Groups_EnableButton_OnClick(frame) end);
    AddonListFrame_Save_EditBox_SetTitle(frame, "Group Name");
    AddonListFrame_Save_SelectButton_SetOnClick(frame, function ()
        Groups_ShowMenu(frame.saveFrame.selectButton, "BOTTOMRIGHT")
    end);
    AddonListFrame_Save_SaveButton_SetOnClick(frame, function ()
        Groups_MakeSave(frame, AddonListFrame_Save_EditBox_GetText(frame));
    end);
    AddonListFrame_Save_DeleteButton_SetOnClick(frame, function ()
        Groups_DeleteSave(frame, AddonListFrame_Save_EditBox_GetText(frame));
    end);
    AddonListFrame_Save_ReloadButton_SetVisible(frame, false)
    
    frame.name = "Group Manager";
    frame.parent = "Addon Manager";
    InterfaceOptions_AddCategory(frame);
end

-- create the addon entries for each addon
function Groups_Initialize_CreateGroupsAddonArray(frame)
    local addonName, addonEntry, groupsAddonArray;

    groupsAddonArray = {};
    for addonIndex = 1, GetNumAddOns()
    do
        addonName = GetAddOnInfo(addonIndex);
        addonEntry = MakeAddonListEntry(addonName);
        AddonListFrame_AddEntry(frame, addonEntry);
        groupsAddonArray[addonName] = addonEntry;
    end
    
    return groupsAddonArray;
end

-- This initialises the SavedGroupConfigurations variable
-- by creating entries for each of the saved groups
-- that were created in a previous session
function Groups_Initialize_CreateMenuCache(frame)
    local name;
    
    if SavedGroupConfigurations == nil
    then
        SavedGroupConfigurations = {};
    end
    
    for name, _ in pairs(SavedGroupConfigurations)
    do
        groupSavesMenu[name] = {};
        groupSavesMenu[name].text = name;
        groupSavesMenu[name].func = function ()
                AddonListFrame_Save_EditBox_SetText(frame, name);
                Groups_LoadSave(frame, SavedGroupConfigurations[name]);
	end
    end
    Groups_UpdateSelectButton(frame);
    Addons_UpdateGroups();
end

function Groups_Search_Handler(frame)
    local filter;
    
    if frame.entries == nil
    then
    	frame.entries = {};
    end
    
    
    filter = string.lower(AddonListFrame_Search_GetText(frame));
    for _, addonEntry in pairs(frame.entries)
    do
        addonEntry:DoFilter(filter);
    end
    AddonListFrame_UpdateLayout(frame);
    
    if filter == nil or filter == ""
    then
        AddonListFrame_DisableButton_SetTitle(frame, "Clear All");
        AddonListFrame_EnableButton_SetTitle(frame, "Select All");
    else
        AddonListFrame_DisableButton_SetTitle(frame, "Clear Filtered");
        AddonListFrame_EnableButton_SetTitle(frame, "Select Filtered");
    end
end

function Groups_DisableButton_OnClick(frame)
    local addonEntry;
    
    for _, addonEntry in pairs(groupsAddonArray)
    do
        if not addonEntry:IsFiltered()
        then
            addonEntry:SetChecked(false);
        end
    end
end

function Groups_EnableButton_OnClick(frame)
    local addonEntry;
    
    for _, addonEntry in pairs(groupsAddonArray)
    do
        if not addonEntry:IsFiltered()
        then
            addonEntry:SetChecked(true);
        end
    end
end

-- This converts the current groups addon array
-- into a name and checked status array
function Groups_MakeSave(frame, name)
    if name
    then
        local save;
        
        save = {};
        for addonName, addonEntry in pairs(groupsAddonArray)
        do
            save[addonName] = addonEntry:GetChecked();
        end
        
        SavedGroupConfigurations[name] = save;
        groupSavesMenu[name] = {};
        groupSavesMenu[name].text = name;
        groupSavesMenu[name].func = function ()
                AddonListFrame_Save_EditBox_SetText(frame, name);
                Groups_LoadSave(frame, SavedGroupConfigurations[name]);
	end
        Groups_UpdateSelectButton(frame);
        Addons_UpdateGroups();
    end
end

-- This loads the current groups addon array
-- from a name and checked status array
function Groups_LoadSave(frame, save)
    if save
    then
        for addonName, addonEntry in pairs(groupsAddonArray)
        do
            addonEntry:SetChecked(save[addonName]);
        end
    end
end

-- This deletes the current groups addon array
function Groups_DeleteSave(frame, name)
    if name
    then
        SavedGroupConfigurations[name] = nil;
        groupSavesMenu[name] = nil;
        AddonListFrame_Save_EditBox_SetText(frame, "");
        Groups_UpdateSelectButton(frame);
        Addons_UpdateGroups();
    end
end

function Groups_ShowMenu(anchor, anchorPoint)
    Template_ShowDropDownMenu(groupSavesMenu, anchor, anchorPoint)
end

function Groups_UpdateSelectButton(frame)
    local hasSaves;

    hasSaves = false;
    for _, _ in pairs(groupSavesMenu)
    do
        hasSaves = true;
        break;
    end
    
    AddonListFrame_Save_SelectButton_SetEnabled(frame, hasSaves);
end

local GroupsListFrameImpl, GroupsDropDownMenuImpl;

GroupsListFrameImpl = CreateFrame("Frame", nil, nil, "AddonListFrame");
Groups_Initialize(GroupsListFrameImpl);

GroupsDropDownMenuImpl = CreateFrame("Frame", "GroupsDropDownMenu", nil, "UIDropDownMenuTemplate");
UIDropDownMenu_Initialize(GroupsDropDownMenuImpl, Groups_MakeMenu);
