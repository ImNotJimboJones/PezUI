function AddonListFrame_SetTitle(frame, title)
    frame.title:SetText(title);
end

function AddonListFrame_Search_GetText(frame)
    return frame.searchFrame.editBox:GetText();
end

function AddonListFrame_Search_SetHandler(frame, handler)
    frame.searchFrame.editBox:SetScript("OnTextChanged", handler);
end

--

function AddonListFrame_GetScrollChild(frame)
    return frame.scrollFrameBorder.scrollFrame.scrollChild;
end

--

function AddonListFrame_DisableButton_SetTitle(frame, title)
    frame.buttonFrame.disableAll:SetText(title);
    frame.buttonFrame.disableAll:SetWidth(frame.buttonFrame.disableAll.text:GetWidth() + 10);
end

function AddonListFrame_DisableButton_SetOnClick(frame, onClick)
    frame.buttonFrame.disableAll:SetScript("OnClick", onClick);
end

--

function AddonListFrame_EnableButton_SetTitle(frame, title)
    frame.buttonFrame.enableAll:SetText(title);
    frame.buttonFrame.enableAll:SetWidth(frame.buttonFrame.enableAll.text:GetWidth() + 10);
end

function AddonListFrame_EnableButton_SetOnClick(frame, onClick)
    frame.buttonFrame.enableAll:SetScript("OnClick", onClick);
end

--

function AddonListFrame_Save_EditBox_SetTitle(frame, title)
    frame.saveFrame.editBox.title:SetText(title);
end

function AddonListFrame_Save_EditBox_SetText(frame, text)
    frame.saveFrame.editBox:SetText(text);
end

-- This now returns the trimmed version of the text.
-- This should help prevent people entering names that
-- cannot be loaded via the slash command.
function AddonListFrame_Save_EditBox_GetText(frame)
    return string.trim(frame.saveFrame.editBox:GetText());
end

--

function AddonListFrame_Save_SelectButton_SetTitle(frame, title)
    frame.saveFrame.selectButton:SetText(title);
end

function AddonListFrame_Save_SelectButton_SetOnClick(frame, onClick)
    frame.saveFrame.selectButton:SetScript("OnClick", onClick);
end

function AddonListFrame_Save_SelectButton_SetEnabled(frame, enabled)
    if enabled
    then
        frame.saveFrame.selectButton:Enable();
    else
        frame.saveFrame.selectButton:Disable();
    end
end

function AddonListFrame_Save_SelectButton_ToggleMenu(frame, menu)
    ToggleDropDownMenu(1, nil, menu, frame.saveFrame.selectButton, 0, 0);
end

--

function AddonListFrame_Save_SaveButton_SetTitle(frame, title)
    frame.saveFrame.saveButton:SetText(title);
end

function AddonListFrame_Save_SaveButton_SetOnClick(frame, onClick)
    frame.saveFrame.saveButton:SetScript("OnClick", onClick);
end

--

function AddonListFrame_Save_ReloadButton_SetVisible(frame, show)
    if show
    then
	frame.saveFrame.reloadButton:Show()
    else
	frame.saveFrame.reloadButton:Hide()
    end
    frame.saveFrame.reloadButton:SetText(title);
end

function AddonListFrame_Save_ReloadButton_SetTitle(frame, title)
    frame.saveFrame.reloadButton:SetText(title);
end

function AddonListFrame_Save_ReloadButton_SetOnClick(frame, onClick)
    frame.saveFrame.reloadButton:SetScript("OnClick", onClick);
end

--

function AddonListFrame_Save_DeleteButton_SetTitle(frame, title)
    frame.saveFrame.deleteButton:SetText(title);
end

function AddonListFrame_Save_DeleteButton_SetOnClick(frame, onClick)
    frame.saveFrame.deleteButton:SetScript("OnClick", onClick);
end

--

local addonListFrameScrollChild;

-- This adds an AddonListGroup or an AddonListentry 
-- to this frame.  It is recommended that this be 
-- used to populate these objects so that the group 
-- correctly knows its content
function AddonListFrame_AddEntry(frame, entry)
    addonListFrameScrollChild = AddonListFrame_GetScrollChild(frame);
    
    if frame.entries == nil
    then
        frame.entries = {};
    end

    if #frame.entries == 0
    then
        entry:SetPoint("TOPLEFT", addonListFrameScrollChild, "TOPLEFT", 0, 0);
    else
        entry:SetPoint("TOPLEFT", frame.entries[#frame.entries], "BOTTOMLEFT", 0, 0);
    end
    entry:SetParent(addonListFrameScrollChild);
    table.insert(frame.entries, entry);
end

-- This runs through all of the entries in the frame
-- and sets the points based on the visible entries.
-- This is meant to be used as part of the filtering
-- process, since the hidden entries do not collapse.
function AddonListFrame_UpdateLayout(frame)
    addonListFrameScrollChild = AddonListFrame_GetScrollChild(frame);
    local lastEntry, contentFrameHeight;
    
    contentFrameHeight = 0;
    for _, entry in pairs(frame.entries)
    do
        if entry:IsShown()
        then
            if lastEntry == nil
            then
                entry:SetPoint("TOPLEFT", addonListFrameScrollChild, "TOPLEFT", 0, 0);
            else
                entry:SetPoint("TOPLEFT", lastEntry, "BOTTOMLEFT", 0, 0);
            end
            
            contentFrameHeight = contentFrameHeight + entry:GetHeight();
            lastEntry = entry;
        else
            entry:ClearAllPoints();
        end
    end
    
    addonListFrameScrollChild:SetHeight(contentFrameHeight);
end

-- Clears the list associated with this frame
-- The table of contained entries is wiped so
-- be sure you have copied the entries
function AddonListFrame_ClearEntries(frame)
    for _, addonGroup in pairs(frame.entries)
    do
        addonGroup:ClearAllPoints();
    end
    table.wipe(frame.entries);
end
