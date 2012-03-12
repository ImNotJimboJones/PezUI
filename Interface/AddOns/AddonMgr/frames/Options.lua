-- This is the options frame, which records
-- specific details which cannot be covered
-- by the general UI.
--
-- The settings for this are stored in the variable
-- Options
-- the AddonListOptions_Init(frame) method must be
-- called after the variables have been loaded

function AddonListOptions_Init(frame)
    if Options == nil
    then
        Options = {};
    end
    
    AddonListOptions_ReloadUI_SetChecked(frame, Options.reloadUI);
    AddonListOptions_ShowMemory_SetChecked(frame, Options.showMemory);
end

function AddonListOptions_SetTitle(frame, title)
    frame.title:SetText(title);
end

function AddonListOptions_ReloadUI_SetTitle(frame, title)
    frame.reloadUI.title:SetText(title);
end

function AddonListOptions_ReloadUI_GetChecked(frame, checked)
    return frame.reloadUI:GetChecked();
end

-- Sets the state of the checkbox and updates the associated
-- option
function AddonListOptions_ReloadUI_SetChecked(frame, checked)
    frame.reloadUI:SetChecked(checked);
end

-- This updates the saved options for the reload ui setting
-- The frame in this instance is the ReloadUI checkbox
function AddonListOptions_ReloadUI_OnClick(frame)
    Options.reloadUI = frame:GetChecked();
end

function AddonListOptions_ShowMemory_SetTitle(frame, title)
    frame.showMemory.title:SetText(title);
end

function AddonListOptions_ShowMemory_GetChecked(frame, checked)
    return frame.showMemory:GetChecked();
end

-- Sets the state of the checkbox and updates the associated
-- option
function AddonListOptions_ShowMemory_SetChecked(frame, checked)
    frame.showMemory:SetChecked(checked);
end

-- This updates the saved options for the reload ui setting
-- The frame in this instance is the ReloadUI checkbox
function AddonListOptions_ShowMemory_OnClick(frame)
    Options.showMemory = frame:GetChecked();
end

-- This will initialize the options settings
-- as well as adding it to the UI Panel
function Options_Initialize(frame)
    frame:RegisterEvent("ADDON_LOADED");
    frame:SetScript("OnEvent", function (self, event, ...) 
        if event == "ADDON_LOADED"
        then
            AddonListOptions_Init(frame);
        end
    end);
    
    frame.name = "Options";
    frame.parent = "Addon Manager";
    InterfaceOptions_AddCategory(frame);
end

-- This returns the saved state of the ReloadUI button
function Options_ReloadUI_GetChecked()
    return Options.reloadUI;
end

function Options_ShowMemory_GetChecked()
    return Options.showMemory;
end