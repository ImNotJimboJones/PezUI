local Entry = {};

function Entry:GetName()
    return self.data.name;
end

function Entry:GetEnabled()
    return self.data.enabled;
end

-- This returns true if the addon could be loaded without a ui restart.
-- This will return false if the addon is already enabled.
function Entry:GetLoadable()
    return self.data.loadOnDemand;
end

function Entry:GetTitle()
    return self.title:GetText();
end

-- Sets the displayed text next to the checkbox.
function Entry:SetTitle(title)
    self.title:SetText(title);
end

-- Displays the combination of the addon notes and the dependencies.
-- in the game tooltip.
function Entry:ShowTooltip()
    if self.data.notes or self.data.dependencies or ( self.data.enabled and Options_ShowMemory_GetChecked() )
    then
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
        GameTooltip:ClearLines();
        
        if self.data.notes
        then
            GameTooltip:AddLine(self.data.notes, nil, nil, nil, 1);
            
            if self.data.dependencies or ( self.data.enabled and Options_ShowMemory_GetChecked() )
            then
                GameTooltip:AddLine(" ");
            end
        end
        
        if self.data.enabled and Options_ShowMemory_GetChecked()
        then
            UpdateAddOnMemoryUsage();
            local memory = GetAddOnMemoryUsage(self.data.name)
            
            GameTooltip:AddLine("Memory Use:", 0, 1, 1, 1);
            if memory > 1024
            then
                GameTooltip:AddLine(string.format("%.2fMb", memory / 1024));
            elseif memory > 1
            then
                GameTooltip:AddLine(string.format("%.2fkb", memory));
            elseif memory > 0
            then
                GameTooltip:AddLine(string.format("%.0fb", memory * 1024));
            else
                GameTooltip:AddLine("None!");
            end
        end
        
        if self.data.dependencies
        then
            GameTooltip:AddLine("Dependencies:", 0, 1, 1, 1);
            GameTooltip:AddLine(self.data.dependencies, nil, nil, nil, 1);
        end
        GameTooltip:Show();
    end
end

-- This is called when the checkbox is selected or deselected.
-- This allows synchronization of entry states.
function Entry:OnClick()
    if self.data.update
    then
        self.data.update(self.data.name, self:GetChecked());
    end
end

function Entry:DoFilter(filter)
    if filter == nil
    then
        return true;
    end
    
    self.data.filtered = filter == nil and false or not string.find(string.lower(self:GetTitle()), filter);
    
    if self.data.filtered
    then
        self:Hide();
    else
        self:Show();
    end
    return self.data.filtered;
end

-- This returns true if the entry has been hidden due to the filter method
function Entry:IsFiltered()
    return self.data.filtered;
end

function Entry:ClearFilter()
    self.data.filtered = false;
    self:Show();
end

-- This collects the required information to create the addon list entry
local function _AddonListEntry_CollectInformation(name)
    local title, notes, dependencies, enabled, loadable, loadOnDemand, reason;
    
    _, title, notes, enabled, loadable, reason = GetAddOnInfo(name);
    loadOnDemand = ( not enabled ) and loadable;
    dependencies = { };
    for _, dependency in pairs( { GetAddOnDependencies(name) } )
    do
        local _, dependencyTitle = GetAddOnInfo(dependency)
        table.insert(dependencies, dependencyTitle or dependency)
    end
    if #dependencies == 0
    then
        dependencies = nil;
    else
        dependencies = table.concat(dependencies, ", ");
    end
    
    return title, notes, dependencies, enabled, loadOnDemand;
end

-- This creates a new addon list entry
-- This takes the name of the folder of the addon
-- and the update method to call when the entry is selected.
--
-- The update method takes two parameters: The addon name, and the state after update
function MakeAddonListEntry(name, update)
    
    entry = CreateFrame("CheckButton", nil, nil, "AddonListEntry");
    entry = Template_Class_Subclass(entry, Entry);
    
    entry.data = {};
    
    UpdateAddonListEntry(entry, name, update);
    
    return entry;
end

-- This collects information on the given addon name and updates the entry to match it
function UpdateAddonListEntry(entry, name, update)
    local title, notes, dependencies, enabled, loadOnDemand;
    
    title, notes, dependencies, enabled, loadOnDemand = _AddonListEntry_CollectInformation(name);
    
    entry.data.name         = name;
    entry.data.notes        = notes;
    entry.data.dependencies = dependencies;
    entry.data.enabled      = enabled;
    entry.data.loadOnDemand = loadOnDemand;
    entry.data.update       = update;
    
    entry.data.filtered     = false;
    
    entry:SetTitle(title or name);
end