local Group = {};
local GROUP_UNEXPANDED_HEIGHT = 26;
local GROUP_EXPANDED_ADDITIONAL_HEIGHT = 0;

function Group:SetTitle(title)
    self.data.title = title;
    self:UpdateTitle();
end

function Group:UpdateTitle(size)
    self.title:SetText(string.format("%s (%s)", self.data.title, size or Template_TableLength(self.data.entries)));
end

function Group:SetChecked(checked)
    self:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
    self.selector:SetChecked(checked);
end

function Group:GetChecked(checked)
    self.selector:GetChecked();
end

function Group:SetCheckedTexture(texture)
    self.selector:SetCheckedTexture(texture);
end

-- This makes the selector contain a greyed out
-- check mark
function Group:SetDimCheck()
    self:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled");
    self.selector:SetChecked(true);
end

-- This updates the selector check state based
-- on the state of the contained entries
function Group:UpdateChecked()
    if #self.data.entries == 0
    then
        self:SetChecked(false);
        return;
    end
    
    local last;
    
    _, last = next(self.data.entries, nil);
    last = last:GetChecked();
    
    for _, entry in pairs(self.data.entries)
    do
        if entry:GetChecked() ~= last
        then
            self:SetDimCheck();
            return;
        end
    end
    self:SetChecked(last);
end

function Group:SetExpanded(expanded)
    self.expander:SetChecked(expanded);
end

function Group:GetExpanded()
    self.expander:GetChecked();
end

-- Adds an entry to the end of the group
function Group:AddEntry(entry)
    if #self.data.entries == 0
    then
        entry:SetPoint("TOPLEFT", self.content);
    else
        entry:SetPoint("TOPLEFT", self.data.entries[#self.data.entries], "BOTTOMLEFT");
    end
    
    entry:SetParent(self.content);
    table.insert(self.data.entries, entry);
    
    self.content:SetHeight(self.content:GetHeight() + entry:GetHeight());
end

-- Removes all entries from the group
function Group:ClearEntries()
    for _, entry in pairs(self.data.entries)
    do
        entry:ClearAllPoints();
    end
    table.wipe(self.data.entries);
    self.content:SetHeight(0);
    self:SetHeight(GROUP_UNEXPANDED_HEIGHT);
end

-- This returns an iterator for the entries that this contains
function Group:GetEntries()
    return pairs(self.data.entries);
end

-- Updates the layout of the internal contents
-- so that the gaps produced by filtering
-- are removed.
function Group:UpdateLayout()
    local last, height;
    
    height = 0;
    for _, entry in pairs(self.data.entries)
    do
        if not entry:IsFiltered()
        then
            if last == nil
            then
                entry:SetPoint("TOPLEFT", self.content);
            else
                entry:SetPoint("TOPLEFT", last, "BOTTOMLEFT");
            end
            
            height = height + entry:GetHeight();
            last = entry;
        else
            entry:ClearAllPoints();
        end
    end
    
    self.content:SetHeight(height);
    if self.content:IsShown()
    then
        self:SetHeight(height + GROUP_UNEXPANDED_HEIGHT + GROUP_EXPANDED_ADDITIONAL_HEIGHT);
    end
end

function Group:DoFilter(filter)
    local count;
    
    count = 0;
    for _, entry in pairs(self.data.entries)
    do
        if not entry:DoFilter(filter)
        then
            count = count + 1;
        end
    end
    
    self:UpdateTitle(count);
    self:UpdateLayout();
    
    self.data.filtered = count == 0 and #self.data.entries ~= 0;
    if self.data.filtered
    then
        self:Hide();
    else
        self:Show();
    end
    
    return self.data.filtered;
end

function Group:IsFiltered()
    return self.data.filtered;
end

function Group:ClearFilter()
    self.data.filtered = false;
    self:Show();
end

function Group:DoExpand()
    self.content:Show();
    self:SetExpanded(true);
    self:UpdateLayout();
end

function Group:DoCollapse()
    self.content:Hide();
    self:SetHeight(GROUP_UNEXPANDED_HEIGHT);
    self:SetExpanded(false);
end

function Group:DoCheck()
    for _, entry in pairs(self.data.entries)
    do
        ListManager_UpdateEntryState(entry:GetName(), true);
    end
    ListManager_UpdateGroupStates();
end

function Group:DoUncheck()
    for _, entry in pairs(self.data.entries)
    do
        ListManager_UpdateEntryState(entry:GetName(), false);
    end
    ListManager_UpdateGroupStates();
end

function MakeAddonListGroup(title)
    local group;
    
    group = CreateFrame("Frame", nil, nil, "AddonListGroup");
    
    group.data = {};
    
    group.data.title    = title;
    group.data.entries  = {};
    group.data.filtered = false;
    
    Template_Class_Subclass(group, Group);
    
    return group;
end