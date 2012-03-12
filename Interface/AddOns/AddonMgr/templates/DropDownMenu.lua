local dropDownMenu

dropDownMenu = CreateFrame("Frame", nil, nil, "AddonManagerDropDownMenu")
dropDownMenu:Hide()

dropDownMenu.shown = {} -- holds the shown entries
dropDownMenu.hidden = {} -- holds the entries that have been created but not used

-- This adds a clickable entry to the drop down menu
-- name - the displayed name
-- func - the method that will be called, with no arguments, on click
function dropDownMenu:AddEntry (name, func)
    local entry
    
    -- Recycle if possible
    if #self.hidden == 0
    then
        entry = CreateFrame("Button", nil, self.scrollFrame.scrollChild, "AddonManagerDropDownMenuButton")
    else
        entry = table.remove(self.hidden)
    end
    
    entry.OnClick = func
    entry.title:SetText(name)
    
    if #self.shown == 0
    then
        entry:SetPoint("TOPLEFT", self.scrollFrame.scrollChild, "TOPLEFT", 2, 2)
    else
        entry:SetPoint("TOPLEFT", self.shown[#self.shown], "BOTTOMLEFT", 0, 2)
    end
    entry:Show()
    table.insert(self.shown, entry)
end

-- This clears the content of the drop down menu
-- All created buttons are cached for future use
function dropDownMenu:Clear ()
    for _, entry in pairs(self.shown)
    do
        entry:Hide()
        table.insert(self.hidden, entry)
    end
    table.wipe(self.shown)
end

-- This calculates if the scroll bar needs to be shown
-- This can shrink the height of the menu if there are
-- not enough entries
function dropDownMenu:Update ()
    local height
    
    height = ( #dropDownMenu.shown - 1 ) * 14
    
    if height < 160
    then
        dropDownMenu:SetHeight(height + 40)
        dropDownMenu.scrollFrame.scrollBar:Hide()
    else
        dropDownMenu:SetHeight(200)
        dropDownMenu.scrollFrame.scrollBar:Show()
    end
end

-- This displays a drop down menu containing the entries in the table content
-- The entries in the table content are expected to have the following entries:
--    name
--    func
-- The entries are sorted according to the keys of the content table
-- The anchor is used to place the drop down menu
-- The anchor point is the location that the top left of this frame will attach to
function Template_ShowDropDownMenu(content, anchor, anchorPoint)
    
    
    if dropDownMenu:IsShown() and dropDownMenu:GetParent() == anchor
    then
        dropDownMenu:Hide()
    else
        dropDownMenu:SetPoint("TOPRIGHT", anchor, anchorPoint)
        dropDownMenu:SetParent(anchor)
        
        dropDownMenu:Clear()
        for _, entry in Template_SortedPairs(content)
        do
            dropDownMenu:AddEntry(entry.text, entry.func)
        end
        
        dropDownMenu:Update()
        dropDownMenu:Show()
    end
end