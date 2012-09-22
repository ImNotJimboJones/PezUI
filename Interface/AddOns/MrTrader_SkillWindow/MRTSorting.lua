-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):GetLocale("MrTrader", true);

-----
-- MRTSortByName - Plugin to provide a sort by name function
--
-- Interfaces -
--   TradeSkillWindowSort - Provides a sorting option for the window
-----
MRTSortByName = {
	id = "4a311662-eefc-469d-8f45-807d69e59f5a",
	name = L["Name"],
	interfaces = {
		TradeSkillWindowSort = function(a,b,ascending) 
			return (a.skillName < b.skillName and ascending)
			    or (a.skillName > b.skillName and not ascending);
		end,
	}
}
MRTAPI:RegisterPlugin(MRTSortByName);

-----
-- MRTSortByRequiredLevel - Plugin to provide a sort by required level function
--
-- Interfaces -
--   TradeSkillWindowSort - Provides a sorting option for the window
-----
MRTSortByRequiredLevel = {
	id = "cc72efdf-1ecc-46fc-996a-2f0e9868dc52",
	name = L["Required Level"],
	interfaces = {
		TradeSkillWindowSort = function(a,b,ascending) 
			return ((a.itemMinLevel or -1) < (b.itemMinLevel or -1) and ascending)
			    or ((a.itemMinLevel or -1) > (b.itemMinLevel or -1) and not ascending);
		end,
	}
}
MRTAPI:RegisterPlugin(MRTSortByRequiredLevel);

-----
-- MRTSortByItemLevel - Plugin to provide a sort by required level function
--
-- Interfaces -
--   TradeSkillWindowSort - Provides a sorting option for the window
-----
MRTSortByItemLevel = {
	id = "7f98dbd5-09a9-4bba-9075-7b6e2c6256a0",
	name = L["Item Level"],
	interfaces = {
		TradeSkillWindowSort = function(a,b,ascending) 
			return ((a.itemLevel or -1) < (b.itemLevel or -1) and ascending)
			    or ((a.itemLevel or -1) > (b.itemLevel or -1) and not ascending);
		end,
	}
}
MRTAPI:RegisterPlugin(MRTSortByItemLevel);

-----
-- MRTSortByDifficulty - Plugin to provide a sort by difficulty
--
-- Interfaces -
--   TradeSkillWindowSort - Provides a sorting option for the window
-----
local TradeSkillTypeImportance = { };
TradeSkillTypeImportance["optimal"]	= 4;
TradeSkillTypeImportance["medium"]	= 3;
TradeSkillTypeImportance["easy"] = 2;
TradeSkillTypeImportance["trivial"]	= 1;
TradeSkillTypeImportance["header"]	= 0;

MRTSortByDifficulty = {
	id = "0f0d213e-4302-4fc4-8c5a-147173028554",
	name = L["Difficulty"],
	interfaces = {
		TradeSkillWindowSort = function(a,b,ascending)
			local aRank = TradeSkillTypeImportance[a.skillType];
			local bRank = TradeSkillTypeImportance[b.skillType];
			return ((aRank < bRank) and ascending)
			    or ((aRank > bRank) and not ascending);
		end,
	}
}
MRTAPI:RegisterPlugin(MRTSortByDifficulty);


function MRTSkillWindow:InitializeSortingDropDown()
	local itemsTable = {};
	local plugins = MRTAPI:PluginsForInterface("TradeSkillWindowSort");
	
	for _, plugin in pairs(plugins) do
		local pluginTable = {};
		
		pluginTable.name = plugin.name;
		pluginTable.id = plugin.id;
		pluginTable.plugin = plugin;
		
		itemsTable[#itemsTable+1] = pluginTable;
	end
	
	table.sort(itemsTable, function(a,b) return a.name < b.name end);
	local info = UIDropDownMenu_CreateInfo();
	
	for _, pluginTable in ipairs(itemsTable) do
		info.text = pluginTable.name;
		info.icon = "Interface\\Addons\\MrTrader_SkillWindow\\ArrowUp";
		info.func = function() MRTSkillWindow:SetSortSelection(pluginTable.id, true); MRTSkillWindow:Update(); end;
		info.isNotRadio = true;
		info.notCheckable = true;
		info.keepShownOnClick = false;
		UIDropDownMenu_AddButton(info);
		
		info.text = pluginTable.name;
		info.icon = "Interface\\Addons\\MrTrader_SkillWindow\\ArrowDown";
		info.func = function() MRTSkillWindow:SetSortSelection(pluginTable.id, false); MRTSkillWindow:Update(); end;
		info.isNotRadio = true;
		info.notCheckable = true;
		info.keepShownOnClick = false;
		UIDropDownMenu_AddButton(info);
	end
end

function MRTSkillWindow:GetSortSelectionString()
	local plugins = MRTAPI:PluginsForInterface("TradeSkillWindowSort");

	for _, plugin in pairs(plugins) do
		if(plugin.interfaces.TradeSkillWindowSort == self.skillWindowSort) then
			local ascendingString = "|TInterface\\Addons\\MrTrader_SkillWindow\\ArrowUp:12:12:2:0|t";
			if( not self.skillWindowSortAscending ) then ascendingString = "|TInterface\\Addons\\MrTrader_SkillWindow\\ArrowDown:12:12:2:0|t" end;
			
			return string.format(L["Sort By: %1$s %2$s"], plugin.name, ascendingString);
		end
	end
	
	return 
end

function MRTSkillWindow:SetSortSelection(pluginId, ascending)
	local plugins = MRTAPI:PluginsForInterface("TradeSkillWindowSort");
		
	for _, plugin in pairs(plugins) do
		if(plugin.id == pluginId) then
			self.skillWindowSortId = plugin.id;
			self.skillWindowSort = plugin.interfaces.TradeSkillWindowSort;
			self.skillWindowSortAscending = ascending;
			return;
		end
	end
end

function MRTSkillWindow:GetSortSelection()
	return self.skillWindowSortId, self.skillWindowSortAscending;
end