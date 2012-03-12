-- hack inspired by code from
-- http://www.lua.org/pil/16.3.html
-- this just checks in the subclass table first before
-- passing to the old metatable of the object
function Template_Class_Subclass( superclass, subclass )
    local metatable;
    
    metatable = getmetatable(superclass);
    return setmetatable( superclass, { __index = function (t,k) 
        return subclass[k] or metatable.__index[k]; 
    end } );
end


function Template_TableLength(table)
    if table == nil
    then
        return 0;
    end

    local count;
    
    count = 0;
    for _, _ in pairs(table)
    do
        count = count + 1;
    end
    
    return count;
end

-- This is the default action that is performed by clicking a checkbox
-- This should be performed by any function that overrides the default behaviour
function Template_DefaultCheckButtonFunction(frame)
    if ( frame:GetChecked() ) then
        PlaySound("igMainMenuOptionCheckBoxOn");
    else
        PlaySound("igMainMenuOptionCheckBoxOff");
    end
    BlizzardOptionsPanel_CheckButton_OnClick(frame);
end

-- This function provides sorted pairs in a manner similar to the pairs() function
-- This comes from http://www.wowwiki.com/API_sort
function Template_SortedPairs (t, f)
    local a = {}
        for n in pairs(t) do table.insert(a, n) end
        table.sort(a, f)
        local i = 0             -- iterator variable
        local iter = function() -- iterator function
            i = i + 1
            if a[i] == nil then return nil
            else return a[i], t[a[i]]
            end
        end
    return iter
end

-- Shows the addon tooltip, with the text selected.
-- This shows the text as the default blizzard gold.
-- The text is word wrapped.
-- The text variable must be a table.
function Template_ShowTooltip(frame, text)
    GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMRIGHT");
    
    for _, line in text
    do
        GameTooltip:AddLine(text, nil, nil, nil, nil, 1);
    end
    GameTooltip:Show();
end

-- Shows the addon tooltip, with the text selected.
-- This shows the text as the default blizzard gold.
-- The text is word wrapped.
-- The text variable must be a string.
function Template_ShowTooltip_OneLine(frame, text)
    GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMRIGHT");
    
    GameTooltip:SetText(text, nil, nil, nil, nil, 1);
    GameTooltip:Show();
end

function Template_HideTooltip()
    GameTooltip:Hide();
end
