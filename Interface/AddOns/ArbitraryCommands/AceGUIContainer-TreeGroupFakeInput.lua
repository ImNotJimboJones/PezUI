local AceGUI = LibStub("AceGUI-3.0")
local flib = LibStub("LibFarmbuyer", true)

local function wrapsetup (tgfi, setup_function)
	if type(setup_function) == 'function' then setup_function(tgfi) end
end

local null = flib and flib.nullfunc or (function() end)

AceGUI:RegisterWidgetType ("TreeGroupFakeInput", function()
	local tg = AceGUI:Create("TreeGroup")

    -- Here's what's needed to pretend to be an input field.
    tg.SetDisabled = null    -- ignored, always on
    tg.SetText = null        -- ignored, nothing to set

    -- This is the ugly kludge.  The options table can use the 'name' field
    -- to return a setup function, and that function is where the user (me!)
    -- gets back normal AceGUI control.
    tg.SetLabel = wrapsetup

    return tg  -- RegisterAsContainer already done, nothing there needed to redo
end, --[[version=]]1)

