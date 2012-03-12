-- ************************************************************************** --
-- * TitanSpec.lua                                                         
-- *                                                                        
-- * By: Rothpada                                                           
-- ************************************************************************** --

local TITAN_SPEC_ID = "TitanSpec";
local L = LibStub("AceLocale-3.0"):GetLocale("TitanSpec", true)
local AceTimer = LibStub("AceTimer-3.0"); 

local IS_DEBUGGING = ( false and GetRealmName() == "Shadow Council" )
                                or ( UnitName("player") == "Balther"
                                     and GetRealmName() == "Shadow Council" )
                                or ( UnitName("player") == "Rothpada"
                                    and GetRealmName() == "Broxigar" );

-- ************************************************************************** --
-- ******************************** Titan Functions ************************* --
-- ************************************************************************** --

function TitanPanelTitanSpecButton_OnLoad(self)
	self.registry = {
		id = TITAN_SPEC_ID,
		menuText = L["TITAN_SPEC_MENU_TEXT"],
		buttonTextFunction = "TitanPanelTitanSpecButton_GetButtonText",
		tooltipTitle = L["TITAN_SPEC_TOOLTIP_TITLE"],
		tooltipTextFunction = "TitanPanelTitanSpecButton_GetTooltipText",
		savedVariables = {
			ShowLabelText = 1,
			ShowNumbers = 1,
			ShowColours = 1,
			ShowGearSet = 0,
			CustomLabel = { "", "" },
			BuildName = { "", "" },
			BuildPts = { "", "" },
			EquipmentSet = {"", "" },
		}	
	};
	
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("CHARACTER_POINTS_CHANGED");
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("CHAT_MSG_SYSTEM");
	
	TitanSpec_output(TITAN_SPEC_ID.." by Rothpada (Shadow Council)");
	TitanSpec_refresh();
	TitanPanelPluginHandle_OnUpdate({TITAN_SPEC_ID, TITAN_PANEL_UPDATE_ALL});
	AceTimer.ScheduleTimer(TITAN_SPEC_ID, function() 
            TitanSpec_refresh();
            TitanPanelPluginHandle_OnUpdate({TITAN_SPEC_ID, TITAN_PANEL_UPDATE_ALL});
        end, 10);
end

function TitanPanelTitanSpecButton_OnClick(self, button)
	if ( button == "LeftButton" ) then
		if ( GetNumTalentGroups() > 1 ) then
                        local idx = mod(GetActiveTalentGroup(), GetNumTalentGroups()) + 1;
			SetActiveTalentGroup(idx);
                        if ( IsShiftKeyDown() ) then
                                AceTimer.ScheduleTimer(TITAN_SPEC_ID, function()
                                    if(GetActiveTalentGroup() == idx) then
                                        -- Ticket 5
                                        local eset = TitanGetVar(TITAN_SPEC_ID, "EquipmentSet");
                                        if ( eset ~= nil and eset[idx] ~= nil and strtrim(eset[idx]) ~= "" ) then
                                                UseEquipmentSet(eset[idx]);
                                        end
                                    end
                                end, 6);
                        end
		end
		
		TitanPanelPluginHandle_OnUpdate({TITAN_SPEC_ID, TITAN_PANEL_UPDATE_ALL});
	end
end

function TitanPanelTitanSpecButton_OnEvent(self, event, ...)
	TitanSpec_refresh();
	TitanPanelButton_UpdateButton(TITAN_SPEC_ID);
	TitanPanelPluginHandle_OnUpdate({TITAN_SPEC_ID, TITAN_PANEL_UPDATE_ALL});
end

function TitanSpec_refresh()	
	TitanSpec_debug("Refreshing...");
	local buildName = TitanGetVar(TITAN_SPEC_ID, "BuildName");
	if ( buildName ~= nil ) then
		buildName[GetActiveTalentGroup()] = TitanSpec_getCurrentBuildName();
		TitanSetVar(TITAN_SPEC_ID, "BuildName", buildName);
	end
	
	local buildPts = TitanGetVar(TITAN_SPEC_ID, "BuildPts");
	if ( buildPts ~= nil ) then	
		buildPts[GetActiveTalentGroup()] = TitanSpec_getCurrentBuild();	
		TitanSetVar(TITAN_SPEC_ID, "BuildPts", buildPts);
	end
end

function TitanSpec_getCurrentBuildName() 		
	local g = GetActiveTalentGroup(false, false);
        local _,b1,_,_,t1,_,_ = GetTalentTabInfo(1, false, false, g);
        local _,b2,_,_,t2,_,_ = GetTalentTabInfo(2, false, false, g);
        local _,b3,_,_,t3,_,_ = GetTalentTabInfo(3, false, false, g);
        if ( t1 > t2 and t1 > t3 ) then
                buildTree = b1;
        elseif ( t2 > t3 ) then
                buildTree = b2;
        elseif ( t3 > 0 ) then
                buildTree = b3;
        else
                buildTree = "n/a";
        end
	return buildTree;
end

function TitanSpec_getCurrentBuild()
	local g = GetActiveTalentGroup(false, false);
        local _,_,_,_,t1,_,_ = GetTalentTabInfo(1, false, false, g);
        local _,_,_,_,t2,_,_ = GetTalentTabInfo(2, false, false, g);
        local _,_,_,_,t3,_,_ = GetTalentTabInfo(3, false, false, g);
		
	return format("%d/%d/%d",t1,t2,t3);
end

function TitanPanelTitanSpecButton_GetButtonText(id)
	local specNum = GetActiveTalentGroup();
	local label = L["TITAN_SPEC_SPEC"].." "..specNum..": ";

	-- Build the button text	
	local customLabel = TitanGetVar(TITAN_SPEC_ID, "CustomLabel");
	-- Fix for ticket 7
	if ( customLabel[specNum] == nil or type(customLabel[specNum]) == "boolean" ) then
	        customLabel[specNum] = "";
	        TitanSetVar(TITAN_SPEC_ID, "CustomLabel", customLabel);
	end
	
	local buildText;
	if ( customLabel == nil or strtrim(customLabel[specNum]) == "" ) then
		buildText = TitanSpec_getCurrentBuildName();
	else
		buildText = customLabel[specNum];
	end
	
	local ret = buildText;
	if ( TitanGetVar(TITAN_SPEC_ID, "ShowNumbers") ) then
	        ret = format("%s (%s)", ret, TitanSpec_getCurrentBuild());
		--return label, TitanSpec_getColouredText(
		    --format("%s (%s)", buildText, TitanSpec_getCurrentBuild()), "white");
	end
	if ( TitanGetVar(TITAN_SPEC_ID, "ShowGearSet") ) then
                local sets = TitanGetVar(TITAN_SPEC_ID, "EquipmentSet");
                local set = sets[GetActiveTalentGroup()];
                if ( set ~= nil and set ~= "" ) then
	                ret = format("%s [%s]", ret, set);
                end
	end
	return label, TitanSpec_getColouredText(ret, "white");
end

function TitanPanelTitanSpecButton_GetTooltipText(self)
	local CustomLabel = TitanGetVar(TITAN_SPEC_ID, "CustomLabel");
	local BuildName = TitanGetVar(TITAN_SPEC_ID, "BuildName");
	local BuildPts = TitanGetVar(TITAN_SPEC_ID, "BuildPts");
	local EquipmentSet = TitanGetVar(TITAN_SPEC_ID, "EquipmentSet");
	
	local t1 = L["TITAN_SPEC_PRIMARY_SPEC"];
	local t2 = "\r"..L["TITAN_SPEC_SECONDARY_SPEC"];
	
	if ( CustomLabel[1] ~= nil and strtrim(CustomLabel[1]) ~= "" ) then
		t1 = t1..CustomLabel[1].." - ";
        else -- Fix for Ticket 8
                CustomLabel[1] = "";
                TitanSetVar(TITAN_SPEC_ID, "CustomLabel", CustomLabel);
	end
	if ( BuildName[1] ~= nil and strtrim(BuildName[1]) ~= "" ) then
		t1 = t1..BuildName[1];
	else
		t1 = t1.."?";
	end
	if ( BuildPts[1] ~= nil and strtrim(BuildPts[1]) ~= "" ) then
		t1 = t1.." ("..BuildPts[1]..")";
	else
		t1 = t1.." (?)";
	end
	if ( EquipmentSet[1] ~= nil and strtrim(EquipmentSet[1]) ~= "" ) then
	        t1 = t1.."\n     "..TitanSpec_getColouredText(L["TITAN_SPEC_GEAR_SET"]..": "..EquipmentSet[1], "white");
	end

	if ( GetNumTalentGroups() == 2 ) then
                -- Fix for ticket 7
                if ( CustomLabel[2] == nil or type(CustomLabel[2]) == "boolean" ) then
                        CustomLabel[2] = "";
                        TitanSetVar(TITAN_SPEC_ID, "CustomLabel", CustomLabel);
                end
                if ( BuildName[2] == nil or type(BuildName[2]) == "boolean" ) then
                        BuildName[2] = "";
                        TitanSetVar(TITAN_SPEC_ID, "BuildName", BuildName);
                end
                if ( BuildPts[2] == nil or type(BuildPts[2]) == "boolean" ) then
                        BuildPts[2] = "";
                        TitanSetVar(TITAN_SPEC_ID, "BuildPts", BuildPts);
                end
                --
                
		if ( strtrim(CustomLabel[2]) ~= "" ) then
			t2 = t2..CustomLabel[2].." - ";
		end
		if ( strtrim(BuildName[2]) ~= "" ) then
			t2 = t2..BuildName[2];
		else
			t2 = t2.."?";
		end
		if ( strtrim(BuildPts[2]) ~= "" ) then
			t2 = t2.." ("..BuildPts[2]..")";
		else
			t2 = t2.." (?)";
		end
                if ( strtrim(EquipmentSet[2]) ~= "" ) then
                        t2 = t2.."\n     "..TitanSpec_getColouredText(L["TITAN_SPEC_GEAR_SET"]..": "..EquipmentSet[2], "white");
                end
		
		if ( TitanGetVar(TITAN_SPEC_ID, "ShowColours") ) then
			if ( GetActiveTalentGroup() == 1 ) then
				t1 = TitanSpec_getColouredText(t1, "green");
				t2 = TitanSpec_getColouredText(t2, "yellow");
			else
				t1 = TitanSpec_getColouredText(t1, "yellow");
				t2 = TitanSpec_getColouredText(t2, "green");
			end
		end
	else
		t2 = t2..L["TITAN_SPEC_NONE"];
		if ( TitanGetVar(TITAN_SPEC_ID, "ShowColours") ) then
			t1 = TitanSpec_getColouredText(t1, "green");
			t2 = TitanSpec_getColouredText(t2, "red");
		end
	end
	return "\r"..t1.."\r"..t2.."\r".."\r"..L["TITAN_SPEC_HINT"];		
end

function TitanPanelRightClickMenu_PrepareTitanSpecMenu()
	
	local info = {};
	
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		if ( UIDROPDOWNMENU_MENU_VALUE == "TITAN_SPEC_ASSIGN_EQUIPMENT_SET" ) then
                        info = {};
                        info.text = "<"..L["TITAN_SPEC_NONE"]..">";
                        info.func = function()
                            local sets = TitanGetVar(TITAN_SPEC_ID, "EquipmentSet");
                            sets[GetActiveTalentGroup()] = "";
                            TitanSetVar(TITAN_SPEC_ID, "EquipmentSet", sets);
                            TitanPanelButton_UpdateButton(TITAN_SPEC_ID);
                        end
                        UIDropDownMenu_AddButton(info, 2);
                        
                        local allSets = TitanGetVar(TITAN_SPEC_ID, "EquipmentSet");
		        local numSets = GetNumEquipmentSets();
		        for i=1,numSets do
		                local setName, _, _ = GetEquipmentSetInfo(i);
		                info = {};
                                info.text = setName;
                                if ( allSets[GetActiveTalentGroup()] == setName ) then
                                        info.text = "|cff00ff00"..info.text..FONT_COLOR_CODE_CLOSE;
                                end
		                info.func = function()
                                    local sets = TitanGetVar(TITAN_SPEC_ID, "EquipmentSet");
                                    sets[GetActiveTalentGroup()] = setName;
                                    TitanSpec_debug("Selected gear set: "..setName);
                                    TitanSetVar(TITAN_SPEC_ID, "EquipmentSet", sets);
                                    TitanPanelButton_UpdateButton(TITAN_SPEC_ID);
		                end
		                UIDropDownMenu_AddButton(info, 2);
		        end
                    elseif ( UIDROPDOWNMENU_MENU_VALUE == "TITAN_SPEC_EQUIP_EQUIPMENT_SET" ) then
                        info = {};
                        
                        local allSets = TitanGetVar(TITAN_SPEC_ID, "EquipmentSet");
		        local numSets = GetNumEquipmentSets();
		        for i=1,numSets do
		                local setName, _, _ = GetEquipmentSetInfo(i);
		                info = {};
                                info.text = setName;
		                info.func = function()
                                    TitanSpec_debug("Equipping gear set: "..setName);
                                    UseEquipmentSet(setName);
		                end
		                UIDropDownMenu_AddButton(info, 2);
		        end
                end
	else	
            TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_SPEC_ID].menuText);
            TitanPanelRightClickMenu_AddSpacer();
            info.text = L["TITAN_SPEC_RENAME"];
            info.func = function(self)
                    StaticPopupDialogs["TITAN_SPEC_RENAME_DIALOG"] = {
                      text = L["TITAN_SPEC_RENAME_TEXT"],
                      button1 = L["TITAN_SPEC_ACCEPT"],
                      button2 = L["TITAN_SPEC_CANCEL"],
                      OnAccept = function (self, ...)
                            local newName = self.editBox:GetText();
                            local labels = TitanGetVar(TITAN_SPEC_ID, "CustomLabel");
                            labels[GetActiveTalentGroup()] = newName;
                            TitanSetVar(TITAN_SPEC_ID, "CustomLabel", labels);
                            TitanPanelButton_UpdateButton(TITAN_SPEC_ID);
                      end,
                      timeout = 0,
                      whileDead = 1,
                      hideOnEscape = 1,
                      hasEditBox = 1,
                      enterClicksFirstButton = 1
                    };
                    StaticPopup_Show("TITAN_SPEC_RENAME_DIALOG");
            end
            UIDropDownMenu_AddButton(info);
            
            if ( GetNumEquipmentSets() > 0 ) then
                TitanPanelRightClickMenu_AddTitle(L["TITAN_SPEC_ASSIGN_EQUIPMENT_SET"], 2);
                info = {};
                info.text = L["TITAN_SPEC_ASSIGN_EQUIPMENT_SET"];
                info.value = "TITAN_SPEC_ASSIGN_EQUIPMENT_SET";
                info.hasArrow = 1;
                UIDropDownMenu_AddButton(info);
                
                TitanPanelRightClickMenu_AddTitle(L["TITAN_SPEC_EQUIP_EQUIPMENT_SET"], 2);
                info = {};
                info.text = L["TITAN_SPEC_EQUIP_EQUIPMENT_SET"];
                info.value = "TITAN_SPEC_EQUIP_EQUIPMENT_SET";
                info.hasArrow = 1;
                UIDropDownMenu_AddButton(info);
                TitanPanelRightClickMenu_AddSpacer();
            end
            
            TitanPanelRightClickMenu_AddToggleVar(L["TITAN_SPEC_SHOW_COLOURS"], TITAN_SPEC_ID, "ShowColours");
            TitanPanelRightClickMenu_AddToggleVar(L["TITAN_SPEC_SHOW_BUILD"], TITAN_SPEC_ID, "ShowNumbers");
            TitanPanelRightClickMenu_AddToggleVar(L["TITAN_SPEC_SHOW_GEAR_SET"], TITAN_SPEC_ID, "ShowGearSet");
            TitanPanelRightClickMenu_AddToggleLabelText(TITAN_SPEC_ID);
                    
            TitanPanelRightClickMenu_AddSpacer();
            
            info = {};
            info.text = L["TITAN_SPEC_RESET"];	
            info.func = function()
                    TitanSetVar(TITAN_SPEC_ID, "ShowLabelText", 1);
                    TitanSetVar(TITAN_SPEC_ID, "ShowNumbers", 1);
                    TitanSetVar(TITAN_SPEC_ID, "ShowColours", 1);
                    TitanSetVar(TITAN_SPEC_ID, "ShowGearSet", 0);
                    TitanSetVar(TITAN_SPEC_ID, "CustomLabel", { "", "" });
                    TitanSetVar(TITAN_SPEC_ID, "BuildPts", { "", "" });
                    TitanSetVar(TITAN_SPEC_ID, "BuildName", { "", "" });
                    TitanSetVar(TITAN_SPEC_ID, "EquipmentSet", { "", "" });
                    TitanSpec_refresh();
                    TitanPanelButton_UpdateButton(TITAN_SPEC_ID);
            end
            UIDropDownMenu_AddButton(info);
            TitanPanelRightClickMenu_AddSpacer();
            TitanPanelRightClickMenu_AddCommand(L["TITAN_SPEC_HIDE"], TITAN_SPEC_ID, TITAN_PANEL_MENU_FUNC_HIDE);
        end
end

-- ************************************************************************** --
-- ******************************** User Functions ************************** --
-- ************************************************************************** --

function TitanSpec_debug(msg)
	if ( msg == nil ) then
		msg = "<nil>";
	end
	if IS_DEBUGGING then
		TitanDebug("TitanSpec> "..msg);
	end
end

function TitanSpec_output(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 1, 1);
end


function TitanSpec_getColouredText(msg, colour)
	local colourCode = "";
	
	if ( colour == nil or colour == "default" ) then
		return msg;
	elseif ( colour == "red" ) then
		colourCode = "|cffff0000";
	elseif ( colour == "green" ) then
		colourCode = "|cff00ff00";
	elseif ( colour == "blue" ) then
		colourCode = "|cff0000ff";
	elseif ( colour == "yellow" ) then
		colourCode = "|cffffff00";
	elseif ( colour == "white" ) then
		colourCode = "|cffffffff";
	elseif ( colour == "black" ) then
		colourCode = "|cff000000";
	else
		colourCode = "|cff"..colour;
	end
        
	return colourCode..msg..FONT_COLOR_CODE_CLOSE;
end

