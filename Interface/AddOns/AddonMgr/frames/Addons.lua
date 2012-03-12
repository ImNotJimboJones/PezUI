
-- The Addons.lua file uses the following variables
-- SavedAddonConfigurations
--      This is the persistent saved state of the addons
-- addonSavesMenu
--      This is a cached version of the SavedGroupConfigurations
--      which is used to populate the drop down menu
-- addonManagerFrame
--      The frame of the addon manager.
--      used to update it with new group information.

local addonSavesMenu, addonManagerFrame;
addonSavesMenu = {};
 
function Addons_Initialize(frame)
    local addonName, addonEntry;
    
    addonManagerFrame = frame;
    
    if SavedAddonConfigurations == nil
    then
        SavedAddonConfigurations = {};
    end
    if SavedGroupConfigurations == nil
    then
        SavedGroupConfigurations = {};
    end
    
    -- The addonSavesMenu can only be initialized
    -- from the SavedGroupConfigurations when the
    -- VARIABLES_LOADED event is fired
    frame:RegisterEvent("ADDON_LOADED");
    frame:SetScript("OnEvent", function (self, event, ...) 
        if event == "ADDON_LOADED"
        then
            Addons_Initialize_CreateMenuCache(frame);
            Addons_MakeGroups(frame);
            Addons_ResetAddonStatus();
            ListManager_UpdateGroupStates();
        end
    end);
    
    -- update the addon frame
    AddonListFrame_Search_SetHandler(frame, function() Addon_Search_Handler(frame) end);
    AddonListFrame_DisableButton_SetOnClick(frame, function() Addon_DisableButton_OnClick(frame) end);
    AddonListFrame_EnableButton_SetOnClick(frame, function() Addon_EnableButton_OnClick(frame) end);
    AddonListFrame_Save_SelectButton_SetOnClick(frame, function ()
        Addons_ShowMenu(frame.saveFrame.selectButton, "BOTTOMRIGHT")
    end);
    AddonListFrame_Save_SaveButton_SetOnClick(frame, function ()
        Addons_MakeSave(frame, AddonListFrame_Save_EditBox_GetText(frame));
    end);
    AddonListFrame_Save_DeleteButton_SetOnClick(frame, function ()
        Addons_DeleteSave(frame, AddonListFrame_Save_EditBox_GetText(frame));
    end);
    AddonListFrame_Save_ReloadButton_SetOnClick(frame, function ()
        StaticPopupDialogs["ADDONMANAGER"] = {
            text = "Do you want to Reload the UI to apply the changes?",
            button1 = "Yes",
            button2 = "No",
            OnAccept = function()
		Addons_ApplyAddonStatus()
                ReloadUI()
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
        }
        StaticPopup_Show ("ADDONMANAGER")
    end);
    
    frame.name = "Addon Manager";
    frame.okay = function () 
	if Addons_ApplyAddonStatus()
	then
            if Options_ReloadUI_GetChecked()
            then
                ReloadUI();
            else
                DEFAULT_CHAT_FRAME:AddMessage("use /console reloadui to load changed addons");
            end
	end
    end
    frame.cancel = Addons_ResetAddonStatus;
    frame.default = Addons_ResetAddonStatus;
    InterfaceOptions_AddCategory(frame);
    
    -- Add the LDB Launcher
    LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("AddonMgr", {
        type = "launcher",
        icon = "Interface\\Icons\\Ability_Vehicle_ShellShieldGenerator",
        OnClick = function(clickedframe, button)
            InterfaceOptionsFrame_OpenToCategory(frame)
        end,
    })
end

-- This initialises the SavedAddonConfigurations variable
-- by creating entries for each of the saved groups
-- that were created in a previous session
function Addons_Initialize_CreateMenuCache(frame)
    local name;
    
    if SavedAddonConfigurations == nil
    then
        SavedAddonConfigurations = {};
    end
    
    for name, _ in pairs(SavedAddonConfigurations)
    do
        addonSavesMenu[name] = {};
        addonSavesMenu[name].text = name;
        addonSavesMenu[name].func = function ()
                AddonListFrame_Save_EditBox_SetText(frame, name);
                Addons_LoadSave(frame, SavedAddonConfigurations[name]);
	end
    end
    Addons_UpdateSelectButton(frame);
end

function Addon_Search_Handler(frame)
    local filter;
    
    if frame.entries == nil
    then
    	frame.entries = {};
    end
    
    filter = string.lower(AddonListFrame_Search_GetText(frame));
    for _, group in pairs(frame.entries)
    do
        group:DoFilter(filter);
    end
    AddonListFrame_UpdateLayout(frame);
    
    if filter == nil or filter == ""
    then
        AddonListFrame_DisableButton_SetTitle(frame, "Disable All");
        AddonListFrame_EnableButton_SetTitle(frame, "Enable All");
    else
        AddonListFrame_DisableButton_SetTitle(frame, "Disable Filtered");
        AddonListFrame_EnableButton_SetTitle(frame, "Enable Filtered");
    end
end

function Addon_DisableButton_OnClick(frame)
    for _, group in pairs(frame.entries)
    do
        for _, entry in group:GetEntries()
        do
            if not entry:IsFiltered()
            then
                entry:SetChecked(false);
            end
        end
    end
    ListManager_UpdateGroupStates();
end

function Addon_EnableButton_OnClick(frame)
    for _, group in pairs(frame.entries)
    do
        for _, entry in group:GetEntries()
        do
            if not entry:IsFiltered()
            then
                entry:SetChecked(true);
            end
        end
    end
    ListManager_UpdateGroupStates();
end

-- This converts the current groups addon array
-- into a name and checked status array
function Addons_MakeSave(frame, name)
    if name
    then
        local save;
        
        save = ListManager_GetEntryState();
        
        SavedAddonConfigurations[name] = save;
        addonSavesMenu[name] = {};
        addonSavesMenu[name].text = name;
        addonSavesMenu[name].func = function ()
                AddonListFrame_Save_EditBox_SetText(frame, name);
                Addons_LoadSave(frame, SavedAddonConfigurations[name]);
	end
        Addons_UpdateSelectButton(frame);
    end
end

-- This loads the current groups addon array
-- from a name and checked status array
function Addons_LoadSave(frame, save)
    if save
    then
        ListManager_SetEntryState(save);
        ListManager_UpdateGroupStates();
    end
end

-- This provides a slash command interface to the load command
-- /am [save name]
-- /addonmanager [save name]

SLASH_ADDONMANAGER1, SLASH_ADDONMANAGER2 = "/am", "/addonmanager"
SlashCmdList["ADDONMANAGER"] = function (msg, editbox)
    msg = string.trim(msg)
    
    local save = string.match(msg, "load (.*)")
    
    if save
    then
        save = string.trim(save)
        if save ~= ""
        then
            if SavedAddonConfigurations[save]
            then
                ListManager_SetEntryState(SavedAddonConfigurations[save]);
                ListManager_UpdateGroupStates();
                
                DEFAULT_CHAT_FRAME:AddMessage(string.format("AddonManager: Loaded save %s", save))
            else
                DEFAULT_CHAT_FRAME:AddMessage("AddonManager: No save by that name found")
            end
        else
            DEFAULT_CHAT_FRAME:AddMessage("AddonManager: Need to specify a save to load")
        end
    elseif msg == "show"
    then
        InterfaceOptionsFrame_OpenToCategory(addonManagerFrame)
    elseif msg == "reload"
    then
        ReloadUI()
    elseif msg ~= ""
    then
        DEFAULT_CHAT_FRAME:AddMessage(string.format("AddonManager: Unrecognized command %s", msg))
    else
        DEFAULT_CHAT_FRAME:AddMessage("AddonManager: You must supply an action")
        DEFAULT_CHAT_FRAME:AddMessage("load [save name]")
        DEFAULT_CHAT_FRAME:AddMessage("    loads the save specified")
        DEFAULT_CHAT_FRAME:AddMessage("show")
        DEFAULT_CHAT_FRAME:AddMessage("    shows the addon manager")
        DEFAULT_CHAT_FRAME:AddMessage("reload")
        DEFAULT_CHAT_FRAME:AddMessage("    reloads the ui")
    end
end

-- This deletes the current groups addon array
function Addons_DeleteSave(frame, name)
    if name
    then
        SavedAddonConfigurations[name] = nil;
        addonSavesMenu[name] = nil;
        AddonListFrame_Save_EditBox_SetText(frame, "");
        Addons_UpdateSelectButton(frame);
    end
end

function Addons_ShowMenu(anchor, anchorPoint)
    Template_ShowDropDownMenu(addonSavesMenu, anchor, anchorPoint)
end

function Addons_InitGroups(frame)
    if SavedGroupConfigurations == nil
    then
        SavedGroupConfigurations = {};
    end
    
    Addons_MakeGroups(frame);
end

-- This creates all of the groups based upon the saved group configurations
function Addons_MakeGroups(frame)
    local groupArray, allAddons, allGroup, addonIndex, name, group;
    
    -- the group array is used so that the addon groups
    -- can be sorted before they are displayed
    groupArray = {};
    
    allAddons = {};
    for addonIndex = 1, GetNumAddOns()
    do
        addonName = GetAddOnInfo(addonIndex);
        allAddons[addonName] = 1;
    end
    allGroup = ListManager_Make_AddonListGroup("All", allAddons);
    groupArray["All"] = allGroup;

    for name, group in pairs(SavedGroupConfigurations)
    do
        groupArray[name] = Addons_MakeGroup(frame, name, group);
    end
    
    for name, group in Template_SortedPairs(groupArray)
    do
        AddonListFrame_AddEntry(frame, group);
    end
    
    ListManager_UpdateGroupStates();
end

-- This makes a group and adds it to the AddonListFrame
-- provided.
function Addons_MakeGroup(frame, name, addons)
    local group;
    
    group = ListManager_Make_AddonListGroup(name, addons);
    group:SetParent(frame);
    
    return group;
end

function Addons_UpdateGroups()
    ListManager_Delete_AddonListFrame(addonManagerFrame);
    Addons_MakeGroups(addonManagerFrame);
end

function Addons_UpdateSelectButton(frame)
    local hasSaves;

    hasSaves = false;
    for _, _ in pairs(addonSavesMenu)
    do
        hasSaves = true;
        break;
    end
    
    AddonListFrame_Save_SelectButton_SetEnabled(frame, hasSaves);
end

-- This updates the addons that will be loaded for the next session
-- This takes the settings that the user has updated through this
-- addon and applies them.
function Addons_ApplyAddonStatus()
    local name, title, updateState, currentState, stateArray, enabledAddons, disabledAddons;
    
    stateArray = ListManager_GetEntryState();
    
    for addonIndex = 1, GetNumAddOns()
    do
        name, title, _, currentState = GetAddOnInfo(addonIndex);
        updateState = stateArray[name];
        
        if currentState ~= updateState
        then
            if updateState
            then
                EnableAddOn(name);
                
                if enabledAddons
                then
                    enabledAddons = enabledAddons .. ", " .. title;
                else
                    enabledAddons = title;
                end
            else
                DisableAddOn(name);
                
                if disabledAddons
                then
                    disabledAddons = disabledAddons .. ", " .. title;
                else
                    disabledAddons = title;
                end
            end
        end
    end
    
    if enabledAddons or disabledAddons
    then
        if enabledAddons
        then
            DEFAULT_CHAT_FRAME:AddMessage("Enabled " .. enabledAddons);
        end
        if disabledAddons
        then
            DEFAULT_CHAT_FRAME:AddMessage("Disabled " .. disabledAddons);
        end

	return true
    end
    return false
end

-- This updates the interface with the addons that are flagged to be loaded next session
-- This takes the current state of WoW and updates the interface to match it
function Addons_ResetAddonStatus()
    local name, state, stateArray;
    
    stateArray = {};
    for addonIndex = 1, GetNumAddOns()
    do
        name, _, _, state = GetAddOnInfo(addonIndex);
        
        -- state could be nil which would mean that
        -- stateArray would not set it properly
        if state
        then
            stateArray[name] = true;
        else
            stateArray[name] = false;
        end
    end
    
    ListManager_SetEntryState(stateArray);
    ListManager_UpdateGroupStates();
end



local AddonsDropDownMenuImpl, AddonListFrameImpl;

AddonListFrameImpl = CreateFrame("Frame", nil, nil, "AddonListFrame");
Addons_Initialize(AddonListFrameImpl);

AddonsDropDownMenuImpl = CreateFrame("Frame", "AddonsDropDownMenu", nil, "UIDropDownMenuTemplate");
UIDropDownMenu_Initialize(AddonsDropDownMenuImpl, Addons_MakeMenu);
