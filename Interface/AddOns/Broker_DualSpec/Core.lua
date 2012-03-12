-- ********************************************************************************
-- Data Broker Dual Specilisation (Broker_DualSpec)
-- A dual specialisation switch for Data Broker.
-- By: Shenton
--
-- Core.lua
-- ********************************************************************************

-- Ace libs (<3)
Broker_DualSpec = LibStub("AceAddon-3.0"):NewAddon("Broker_DualSpec", "AceConsole-3.0", "AceEvent-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("Broker_DualSpec", false);

-- LibDBIcon
Broker_DualSpec.icon = LibStub("LibDBIcon-1.0");

-- ********************************************************************************
-- Variables
-- ********************************************************************************

-- AddOn version
Broker_DualSpec.version = GetAddOnMetadata("Broker_DualSpec", "Version");

-- Text colors
Broker_DualSpec.color = {};
Broker_DualSpec.color["RED"] = "|cFFFF3333";
Broker_DualSpec.color["GREEN"] = "|cFF33FF99";
Broker_DualSpec.color["WHITE"] = "|cFFFFFFFF";
Broker_DualSpec.color["WARRIOR"] = "|cFFC79C6E";
Broker_DualSpec.color["RESET"] = "|r";

-- Loading trick
Broker_DualSpec.isLoading = false;

-- ********************************************************************************
-- Dropdown Menu
-- ********************************************************************************

--- The dropdown menu structure function
-- @usage Called by ToggleDropDownMenu()
-- @param self Frame object
-- @param level Nesting level
local function DropdownMenu(self, level)
	if ( not level ) then return; end

	local info = self.info;
	local db = Broker_DualSpec.config.profile;
	local sets = Broker_DualSpec:GetGearSets();

	wipe(info);

	if ( level == 1 ) then
		-- Menu title
		info.isTitle = true;
		info.text = L["ADDON_NAME"];
		info.notCheckable = true;
		UIDropDownMenu_AddButton(info, level);

		-- Set options
		info.keepShownOnClick = true;
		info.hasArrow = true;
		info.disabled = nil;
		info.isTitle = nil;

		if ( sets ) then
			-- Primary spec gear set
			info.text = "   "..L["PRIMARY_SPEC"];
			info.value = "PRIMARY";
			UIDropDownMenu_AddButton(info, level);

			-- Secondary spec gear set
			info.text = "   "..L["SECONDARY_SPEC"];
			info.value = "SECONDARY";
			UIDropDownMenu_AddButton(info, level);

			-- Blank separator
			wipe(info);
			info.disabled = true;
			info.notCheckable = true;
			UIDropDownMenu_AddButton(info, level);

			-- Set options
			info.disabled = nil;
		end

		-- Gear set switch
		info.text = "   "..L["GEAR_SETS"];
		info.value = "GEARSETS";
		info.hasArrow = true;
		UIDropDownMenu_AddButton(info, level);

		-- Blank separator
		wipe(info);
		info.disabled = true;
		info.notCheckable = true;
		UIDropDownMenu_AddButton(info, level);

		-- Set options
		info.disabled = nil;
		
		-- Options
		info.text = "   "..L["OPTIONS"];
		info.value = "OPTIONS";
		info.hasArrow = true;
		UIDropDownMenu_AddButton(info, level);

		-- Set options
		info.keepShownOnClick = nil;
		info.hasArrow = nil;

		-- Close
		info.text = L["CLOSE"];
		info.func = function() CloseDropDownMenus(); end;
		UIDropDownMenu_AddButton(info, level);
	elseif ( level == 2 ) then
		if ( UIDROPDOWNMENU_MENU_VALUE == "PRIMARY" ) then -- Primary spec gear set
			wipe(info);

			if ( sets ) then
				for _,t in ipairs(sets) do
					info.text = t.name;
					info.icon = t.icon;
					info.checked = function()
						if ( t.name == db.primary ) then
							return true;
						else
							return false;
						end
					end;
					info.func = function() db.primary = t.name; end;
					UIDropDownMenu_AddButton(info, level);
				end
			end
		elseif ( UIDROPDOWNMENU_MENU_VALUE == "SECONDARY" ) then -- Secondary spec gear set
			wipe(info);

			if ( sets ) then
				for _,t in ipairs(sets) do
					info.text = t.name;
					info.icon = t.icon;
					info.checked = function()
						if ( t.name == db.secondary ) then
							return true;
						else
							return false;
						end
					end;
					info.func = function() db.secondary = t.name; end;
					UIDropDownMenu_AddButton(info, level);
				end
			end
		elseif ( UIDROPDOWNMENU_MENU_VALUE == "GEARSETS" ) then -- Gear sets switch
			wipe(info);

			if ( sets ) then
				for _,t in ipairs(sets) do
					info.text = "   "..t.name;
					info.icon = t.icon;
					info.notCheckable = true;
					info.func = function() UseEquipmentSet(t.name); end;
					UIDropDownMenu_AddButton(info, level);
				end
			end
		elseif ( UIDROPDOWNMENU_MENU_VALUE == "OPTIONS" ) then -- Options
			wipe(info);

			-- Set options
			info.keepShownOnClick = true;

			-- Display spec name
			info.text = L["DISPLAY_SPEC_NAME"];
			info.checked = db.specname;
			info.func = function()
				db.specname = not db.specname;
				Broker_DualSpec:UpdateBroker()
			end;
			UIDropDownMenu_AddButton(info, level);

			-- Display spec points
			info.text = L["DISPLAY_SPEC_POINTS"];
			info.checked = db.points;
			info.func = function()
				db.points = not db.points;
				Broker_DualSpec:UpdateBroker()
			end;
			UIDropDownMenu_AddButton(info, level);

			-- Display spec points
			info.text = L["SWITCH_GEAR_TOO"];
			info.checked = db.gear;
			info.func = function() db.gear = not db.gear; end;
			UIDropDownMenu_AddButton(info, level);

			-- Show/hide minimap icon
			info.text = L["SHOW_HIDE_MINIMAP"];
			info.checked = not db.minimap.hide;
			info.func = function()
				db.minimap.hide = not db.minimap.hide;
				Broker_DualSpec:ShowHideMinimap();
			end;
			UIDropDownMenu_AddButton(info, level);
		end
	end
end

-- ********************************************************************************
-- Functions
-- ********************************************************************************

--- Send a message to the chat frame with the addon name colored
-- @param text The message to display
-- @param color Bool, if true will color in red
function Broker_DualSpec:Message(text, color)
	if ( color ) then
		color = Broker_DualSpec.color["RED"];
	else
		color = Broker_DualSpec.color["GREEN"]
	end

	DEFAULT_CHAT_FRAME:AddMessage(color..L["ADDON_NAME"]..": "..Broker_DualSpec.color["RESET"]..text);
end

--- Update the button and icon
function Broker_DualSpec:UpdateBroker()
	local spec, icon, talents = Broker_DualSpec:GetSpecInfos();

    if ( spec and icon and talents ) then
        if ( Broker_DualSpec.config.profile.specname and Broker_DualSpec.config.profile.points ) then
            Broker_DualSpec.ldb.text = spec.." ("..talents..")";
        elseif ( Broker_DualSpec.config.profile.specname ) then
            Broker_DualSpec.ldb.text = spec;
        elseif ( Broker_DualSpec.config.profile.points ) then
            Broker_DualSpec.ldb.text = "("..talents..")";
        else
            Broker_DualSpec.ldb.text = "";
        end
        Broker_DualSpec.ldb.icon = icon;
    else
        Broker_DualSpec.ldb.text = L["NOT_AVAILABLE"];
    end
end

--- Show or hide the minimap icon
function Broker_DualSpec:ShowHideMinimap()
	if ( Broker_DualSpec.config.profile.minimap.hide ) then
		Broker_DualSpec:Message(L["HIDE_MINIMAP"], true);
		Broker_DualSpec.icon:Hide("Broker_DualSpecObject");
	else
		Broker_DualSpec.icon:Show("Broker_DualSpecObject");
	end
end

--- Handle the slash command
-- @param input The string returned after the command
function Broker_DualSpec:SlashCommand(input)
	local arg1, arg2 = string.match(input, "(%a*)%s?(.*)");

	if ( arg1 == "" ) then
		Broker_DualSpec:SwitchSpec();
	elseif ( arg1 == "show" ) then
		Broker_DualSpec.config.profile.minimap.hide = false;
		Broker_DualSpec:ShowHideMinimap();
	elseif ( arg1 == "list" ) then
		local sets = Broker_DualSpec:GetGearSets();

		if ( sets ) then
			local out = "";

			for _,t in ipairs(sets) do
				out = out..", "..out;
			end
			out = strtrim(out, " ,");
			Broker_DualSpec:Message(out);
		else
			Broker_DualSpec:Message(L["NO_GEAR_SETS"], true);
		end
	elseif ( arg1 == "primary" ) then
		if ( arg2 ) then
			local exists,_ = GetEquipmentSetInfoByName(arg2);

			if ( exists ) then
				Broker_DualSpec.config.profile.primary = arg2;
			else
				Broker_DualSpec:Message(L["GEAR_NOT_EXISTS"], true);
			end
		end
	elseif ( arg1 == "secondary" ) then
		if ( arg2 ) then
			local exists,_ = GetEquipmentSetInfoByName(arg2);

			if ( exists ) then
				Broker_DualSpec.config.profile.secondary = arg2;
			else
				Broker_DualSpec:Message(L["GEAR_NOT_EXISTS"], true);
			end
		end
	else
		Broker_DualSpec:Message(L["COMMAND_USAGE_1"]);
		Broker_DualSpec:Message(L["COMMAND_USAGE_2"]);
		Broker_DualSpec:Message(L["COMMAND_USAGE_3"]);
		Broker_DualSpec:Message(L["COMMAND_USAGE_4"]);
	end
end

--- Get informations about the given spec
-- @param group The spec group number (1 or 2)
-- @return The spec name, the spec icon, the points spent
function Broker_DualSpec:GetSpecInfos(group)
	local talents = "";
	local spec = L["NOT_AVAILABLE"];
	local icon = "Interface\\ICONS\\INV_Misc_QuestionMark";
    local compare;

	if ( not group ) then group = GetActiveTalentGroup(false, false); end

	for i=1,3 do
		local _, name,_, tex, points,_,_,_ = GetTalentTabInfo(i, false, false, group);

        if ( compare ) then
            if ( points > compare and points > 0 ) then
                compare = points;
                spec = name;
                icon = tex;
            end
        elseif ( points > 0 ) then
            compare = points;
            spec = name;
            icon = tex;
        end
		talents = talents.."/"..points;
	end
	talents = strtrim(talents, "/");

	return spec, icon, talents;
end

--- Get gear sets names and icons
-- @return A table with gear sets and icons
function Broker_DualSpec:GetGearSets()
	local num = GetNumEquipmentSets();

	if ( num == 0 ) then
		return false;
	else
		local sets = {};

		for i=1,GetNumEquipmentSets() do
			local name, icon,_ = GetEquipmentSetInfo(i);

			sets[i] = {};
			sets[i]["name"] = name;
			sets[i]["icon"] = icon;
		end

		return sets;
	end
end

--- Switch between spec
function Broker_DualSpec:SwitchSpec()
	if ( UnitAffectingCombat("player") ) then
		Broker_DualSpec:Message(L["IN_COMBAT"], true);
		return;
	end

	local current = GetActiveTalentGroup(false, false);

	if ( current == 1 ) then
		SetActiveTalentGroup(2);
	else
		SetActiveTalentGroup(1);
	end
end

--- Callback function for event ZONE_CHANGED_NEW_AREA
-- Used to update icon and text on login
function Broker_DualSpec:ZONE_CHANGED_NEW_AREA()
	if ( Broker_DualSpec.isLoading ) then
		Broker_DualSpec.isLoading = false;
		Broker_DualSpec:UpdateBroker();
	end
end

--- Callback function for event PLAYER_ENTERING_WORLD
-- Fire every time there is a loading screen
-- but too soon so we use ZONE_CHANGED_NEW_AREA
-- Added update function here in case of reloadui
function Broker_DualSpec:PLAYER_ENTERING_WORLD()
	Broker_DualSpec.isLoading = true;
	Broker_DualSpec:UpdateBroker();
end

--- Callback function for event ACTIVE_TALENT_GROUP_CHANGED
-- Set the gear set attached to the given spec
function Broker_DualSpec:ACTIVE_TALENT_GROUP_CHANGED()
	if ( Broker_DualSpec.config.profile.gear ) then
		local current = GetActiveTalentGroup(false, false);

		if ( current == 1 ) then
			if ( Broker_DualSpec.config.profile.primary ~= "" )then
				UseEquipmentSet(Broker_DualSpec.config.profile.primary);
			else
				Broker_DualSpec:Message(L["NO_GEAR_DEFINED"], true);
			end
		else
			if ( Broker_DualSpec.config.profile.secondary ~= "" )then
				UseEquipmentSet(Broker_DualSpec.config.profile.secondary);
			else
				Broker_DualSpec:Message(L["NO_GEAR_DEFINED"], true);
			end
		end
	end

	Broker_DualSpec:UpdateBroker();
end

--- Callback function for event CHARACTER_POINTS_CHANGED
function Broker_DualSpec:CHARACTER_POINTS_CHANGED()
    Broker_DualSpec:UpdateBroker();
end

-- ********************************************************************************
-- Configuration DB
-- ********************************************************************************

--- Default configuration table for AceDB
local defaults =
{
	profile =
	{
		primary = "",
		secondary = "",
		specname = true,
		points = true,
		gear = false,
		minimap =
		{
			hide = false
		}
	}
};

-- ********************************************************************************
-- Main
-- ********************************************************************************

--- AceAddon callback
-- Called after the addon is fully loaded
function Broker_DualSpec:OnInitialize()
	-- Config db
	Broker_DualSpec.config = LibStub("AceDB-3.0"):New("Broker_DualSpecDB", defaults);

	-- LDB
	Broker_DualSpec.ldb = LibStub("LibDataBroker-1.1"):NewDataObject("Broker_DualSpecObject",
	{
		type = "data source",
		text = L["NOT_AVAILABLE"],
		label = L["ADDON_NAME"],
		icon = "Interface\\ICONS\\INV_Misc_QuestionMark",
		tocname = "Broker_DualSpec",
		OnClick = function(self, button)
			if (button == "LeftButton") then
				Broker_DualSpec:SwitchSpec();
			elseif ( button == "RightButton" ) then
				if ( Broker_DualSpec.menuFrame.initialize ~= DropdownMenu ) then
					CloseDropDownMenus();
					Broker_DualSpec.menuFrame.initialize = DropdownMenu;
				end
				ToggleDropDownMenu(1, nil, Broker_DualSpec.menuFrame, self:GetName(), 0, 0);
				GameTooltip:Hide();
			end
		end,
		OnTooltipShow = function(tooltip)
			local spec, points, currentGroup, altGroup;
            local current = GetActiveTalentGroup(false, false);

            if ( current == 1 ) then
                currentGroup = L["PRIMARY_SPEC"];
                altGroup = L["SECONDARY_SPEC"];
            else
                altGroup = L["PRIMARY_SPEC"];
                currentGroup = L["SECONDARY_SPEC"];
            end

			tooltip:AddDoubleLine(Broker_DualSpec.color["WHITE"]..L["ADDON_NAME"], Broker_DualSpec.color["GREEN"].." v"..Broker_DualSpec.version);
			tooltip:AddLine(" ");

			spec,_, points = Broker_DualSpec:GetSpecInfos();
			tooltip:AddLine(L["CURRENT_SPEC"]..": "..spec.." ("..points..") ("..currentGroup..")");
			tooltip:AddLine(" ");

			if ( current == 1 ) then
				spec,_, points = Broker_DualSpec:GetSpecInfos(2);
			else
				spec,_, points = Broker_DualSpec:GetSpecInfos(1);
			end
			tooltip:AddLine(L["SWITCH_TO"]..": "..spec.." ("..points..") ("..altGroup..")");

			if ( Broker_DualSpec.config.profile.gear ) then
				if ( current == 1 ) then
					tooltip:AddLine(L["WITH_GEAR_SET"]..": "..Broker_DualSpec.config.profile.secondary);
				else
					tooltip:AddLine(L["WITH_GEAR_SET"]..": "..Broker_DualSpec.config.profile.primary);
				end
			end

			tooltip:AddLine(" ");
			tooltip:AddLine(string.format(L["TOOLTIP_TIPS"], Broker_DualSpec.color["WARRIOR"], Broker_DualSpec.color["GREEN"], Broker_DualSpec.color["WARRIOR"], Broker_DualSpec.color["GREEN"]));
		end,
	});

	-- LDBIcon
	Broker_DualSpec.icon:Register("Broker_DualSpecObject", Broker_DualSpec.ldb, Broker_DualSpec.config.profile.minimap);
	Broker_DualSpec.icon:IconCallback("ZONE_CHANGED_NEW_AREA", "Broker_DualSpecObject", nil, nil, Broker_DualSpec.ldb);
	Broker_DualSpec.icon:IconCallback("ACTIVE_TALENT_GROUP_CHANGED", "Broker_DualSpecObject", nil, nil, Broker_DualSpec.ldb);
	Broker_DualSpec.icon:IconCallback("PLAYER_ENTERING_WORLD", "Broker_DualSpecObject", nil, nil, Broker_DualSpec.ldb);
    Broker_DualSpec.icon:IconCallback("CHARACTER_POINTS_CHANGED", "Broker_DualSpecObject", nil, nil, Broker_DualSpec.ldb);

	-- Menu frame & table
	Broker_DualSpec.menuFrame = CreateFrame("Frame", "Broker_DualSpecMenuFrame");
	Broker_DualSpec.menuFrame.displayMode = "MENU";
	Broker_DualSpec.menuFrame.info = {};

	-- Events
	Broker_DualSpec:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	Broker_DualSpec:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
	Broker_DualSpec:RegisterEvent("PLAYER_ENTERING_WORLD");
    Broker_DualSpec:RegisterEvent("CHARACTER_POINTS_CHANGED");

	-- Slash command
	Broker_DualSpec:RegisterChatCommand("brokerdualspec", "SlashCommand");
	Broker_DualSpec:RegisterChatCommand("bds", "SlashCommand");
	Broker_DualSpec:RegisterChatCommand("ds", "SlashCommand");
end
