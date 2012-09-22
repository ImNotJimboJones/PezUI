-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------
-- Public APIs go here
-----

MRTAPI = {
    version = 1,
    plugins = {},
};

-----
-- Interfaces available:
--
-- TradeSkillWindowOnShow( addon ): Called when the tradeskill window is shown, the addon is passed in 
--
-- TradeSkillWindowSort( item1, item2, ascending ): Called during a table.sort. Item1 and Item2 are tables with tradeskill
--     information. Ascending is a boolean. Returns true if the items should be swapped.
--
-- TradeSkillWindowInfoLine( tradeskillInfo ): Called when the tradeskill window wants your plugin to present information
--     in an info line. Takes a table with information on the tradeskill. Returns a string. 
--
-- TradeSkillWindowInfoBadge( tradeskillInfo ): Called when the tradeskill window wants your plugin to present information
--     in a badge similar to the multiple skill-ups badge in Cataclysm. Returns:
--   textureName - Texture to display, if nil, no badge will be displayed.
--   count - Optional count to be displayed.
--   mouseOverTitle - Optional text to be displayed on mouse over.
--   clickHandler - Optional function to call if the badge is clicked.
-----

-----
-- Registers a plugin with MrTrader
--
-- A plugin is a table with the following format:
--
-- plugin = {
--     (This is a non-localized string that can be used to uniquely identify your plugin)
--     id = "myGreatPlugin",           
--
--     (This is a localized string for use in interfaces)
--     name = L["My Great Plugin"],    
--
--     (This is a table of interfaces your plugin supports and cares about)
--     interfaces = {
--
--          (The interface name is a string, and takes a handler function)
--          "WindowOnShow" = function(window) ... end, 
--     },
-- };
-----
function MRTAPI:RegisterPlugin(plugin)
    for interface, _ in pairs(plugin.interfaces) do
        if( self.plugins[interface] == nil ) then
            self.plugins[interface] = {};
        end
        
        tinsert(self.plugins[interface], plugin);
    end
end

-----
-- Registers a method handler
-- Convenience method for things like TradeSkillWindowOnShow
--
-- It still generates a plugin underneath, and is not recommended for interfaces that show up in the UI, or
-- take more than one argument.
-----
function MRTAPI:RegisterHandler(interface, handler)
    plugin = {
        id = "handlerPlugin_" .. interface,
        name = "Handler Plugin: " .. interface,
        interfaces = {},
    }
    plugin.interfaces[interface] = handler;
    
    self:RegisterPlugin(plugin);
end

-----
-- Retrieves the list of plugins for a given interface we wish to call.
-----
function MRTAPI:PluginsForInterface(interface)
    return self.plugins[interface];
end

-----
-- Call all plugins with a specific interface, with the same arguments.
--
-- Mostly useful for fire and forget interfaces (e.g. TradeSkillWindowOnShow)
-----
function MRTAPI:CallInterface(interface, ...)
    if( self.plugins[interface] ~= nil ) then
        for index, plugin in pairs(self.plugins[interface]) do
            plugin.interfaces[interface](...);
        end
    end
end

------
-- Pushes the current filter selection.
--
-- example:
-- if MRTAPI then MRTAPI:PushFilterSelection() end;
-- ... Do some scanning of tradeskills here ...
-- if MRTAPI then MRTAPI:PopFilterSelection() end;
------
function MRTAPI:PushFilterSelection()
	local handled = false;

	if( MRTSkillFrame and MRTSkillFrame:IsVisible() ) then
		MRTSkillWindow.didPushFilter = true;
		MRTSkillWindow.savedFilterSelection = MRTSkillWindow.filterSelection;
		MRTSkillWindow.savedFilterCategory = MRTSkillWindow.filterCategory;
		MRTSkillWindow.savedCheckboxFilters = MRTSkillWindow.checkboxFilters;
		MRTSkillWindow.filterSelection = nil;
		MRTSkillWindow.filterCategory = nil;
		MRTSkillWindow.checkboxFilters = {};
	
		MRTSkillWindow:SetCheckboxFilters();
		MRTSkillWindow:UpdateFilters();	
		MRTSkillWindow:Update();
		handled = true;
	end
	
	return handled;
end

------
-- Pops the current filter selection.
------
function MRTAPI:PopFilterSelection()
	local handled = (MRTSkillFrame and MRTSkillFrame:IsVisible()); -- Automatically handle it if we are visible now.
	
	if( MRTSkillWindow and MRTSkillWindow.didPushFilter ) then
		MRTSkillWindow.didPushFilter = nil;
		MRTSkillWindow.filterSelection = MRTSkillWindow.savedFilterSelection;
		MRTSkillWindow.filterCategory = MRTSkillWindow.savedFilterCategory;
		MRTSkillWindow.checkboxFilters = MRTSkillWindow.savedCheckboxFilters;
	
		MRTSkillWindow:SetCheckboxFilters();
		MRTSkillWindow:UpdateFilters();	
		MRTSkillWindow:Update();
		handled = true;
	end
	
	return handled;
end

------
-- Deprecated methods, rendered obsolete with v0.6, may be removed at any time.
------

-- DEPRECATED! Use MRTAPI:PushFilterSelection() instead
function MRTUIUtils_PushFilterSelection()
    return MRTAPI:PushFilterSelection();
end

-- DEPRECATED! Use MRTAPI:PopFilterSelection() instead
function MRTUIUtils_PopFilterSelection()
    return MRTAPI:PopFilterSelection();
end

-- DEPRECATED! Use MRTAPI:RegisterHandler() instead
function MRTUIUtils_RegisterWindowOnShow(handler)
    MRTAPI:RegisterHandler("TradeSkillWindowOnShow", handler);
end
