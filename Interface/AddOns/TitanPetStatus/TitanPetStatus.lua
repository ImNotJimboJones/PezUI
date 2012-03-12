
function TitanPanelPetStatusButton_OnLoad(self)

	self.registry = { 
		id = TITAN_PETSTATUS_ID,
		version = "4.0a",												
		menuText = TITANPETSTATUS_TITLE,
		buttonTextFunction = "TitanPanelPetStatusButton_GetButtonText", 
		category = "Information",
		tooltipTitle = TITANPETSTATUS_TITLE, 
		tooltipTextFunction = "TitanPanelPetStatusButton_GetTooltipText", 
		icon = "Interface\\Icons\\Ability_Hunter_ThrilloftheHunt",		--	4.0a
		iconButtonWidth = 16,											--	4.0a
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowColoredText = 1,
			ShowLabelText = 1,
			ShowPetName = 1,
			ShowPetLevel = 1,
			ShowPetXP = 1,
			ShowFeeding = 0,
			ShowHappiness = 0,
		}
	};
	self:RegisterEvent("UNIT_HAPPINESS");
	self:RegisterEvent("UNIT_PET_EXPERIENCE");
	self:RegisterEvent("LOCALPLAYER_PET_RENAMED");
	self:RegisterEvent("PET_BAR_UPDATE");
	self:RegisterEvent("UNIT_AURA");
	self:RegisterEvent("UNIT_PET");										--	4.0a
end

function TitanPanelPetStatusButton_OnEvent()
	TitanPanelButton_UpdateButton(TITAN_PETSTATUS_ID);
end

function TitanPanelPetStatusButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true)
	local petStats = TitanPanelPetStatusButton_GetPetStats();
	local btnText = TITANPETSTATUS_UNKNOWN;

	if(petStats.exists) then
		if(TitanGetVar(TITAN_PETSTATUS_ID, "ShowPetName")) then
			btnText = petStats.name .. "  ";
		else
			btnText = "  ";
		end
		if(TitanGetVar(TITAN_PETSTATUS_ID, "ShowPetLevel")) then
			btnText =  btnText .. "L" .. petStats.level .. "  ";
		end
		if(TitanGetVar(TITAN_PETSTATUS_ID, "ShowPetXP")) then
			if(TitanGetVar(TITAN_PETSTATUS_ID, "ShowLabelText")) then		
				btnText = btnText .. TitanUtils_GetNormalText(TITANPETSTATUS_XP);
			end
			btnText = btnText .. " " .. petStats.xp .. "  ";
		end
		if(TitanGetVar(TITAN_PETSTATUS_ID, "ShowHappiness")) then
			btnText = btnText .. TitanUtils_GetNormalText("  (") .. petStats.happyLevel .. TitanUtils_GetNormalText(")");
		end
		if(TitanPanelPetStatus_CheckFeeding()) and TitanGetVar(TITAN_PETSTATUS_ID, "ShowFeeding") then
			btnText = btnText .. "  " .. "(" .. TitanUtils_GetHighlightText(TITANPETSTATUS_FEEDING) .. ")";
		end
		icon = petStats.icon;
	elseif IsMounted() then
		icon = "Interface\\Icons\\Ability_Hunter_ThrilloftheHunt";		--	4.0a
		btnText = "Mounted";											--	4.0a
	else
		icon = "Interface\\Icons\\Ability_Hunter_ThrilloftheHunt";		--	4.0a
		btnText = "None";												--	4.0a
	end
	return btnText;
end

function TitanPanelPetStatusButton_GetTooltipText()
	local button, id = TitanUtils_GetButton(id, true);
	local petStats = TitanPanelPetStatusButton_GetPetStats();
	local toolText = TITANPETSTATUS_UNKNOWN;

	if(petStats.exists) then
		toolText = "\r" .. petStats.name .. "  " .. "L" .. petStats.level .. "\r\r";
		toolText = toolText .. titanPetStatusCyanFont .. TITANPETSTATUS_EXP .. " " .. petStats.exp .. "\r\r";
		toolText = toolText .. petStats.happyLevel .. "\r\r";
		if(TitanGetVar(TITAN_PETSTATUS_ID, "ShowColoredText")) then
			toolText = toolText .. titanPetStatusCyanFont .. TITANPETSTATUS_FOOD .. "\r"
		else
			toolText = toolText .. TITANPETSTATUS_FOOD .. "\r"
		end
		if(petStats.foodList[1] ~= nil)then
			local index, j;
			for index, j in pairs(petStats.foodList) do
				if (petStats.foodList[index] ~= nil) then
					toolText = toolText .. "* " .. petStats.foodList[index] .. "\r";
				end
			end
		end
	elseif IsMounted() then												--	4.0a
		toolText = "Mounted";											--	4.0a
	else
		toolText = "None";												--	4.0a
	end
	return toolText;
end

function TitanPanelPetStatusButton_GetPetStats()
	local happiness, dmgPercent = GetPetHappiness();
	local currXP, nextXP = GetPetExperience();
	local happyLevel = {TITANPETSTATUS_UNHAPPY, TITANPETSTATUS_CONTENT, TITANPETSTATUS_HAPPY};
	local petStats = { };
	if IsMounted() then
		petStats.exists = false;
		petStats.mounted = true;
	elseif (happiness) then
			petStats.exists = true;
			petStats.icon = GetPetIcon();
			if(TitanGetVar(TITAN_PETSTATUS_ID, "ShowColoredText")) then
				petStats.name = titanPetStatusCyanFont .. UnitName("pet");
				petStats.level = titanPetStatusLevelFont .. UnitLevel("pet");
				petStats.happyLevel = TITAN_PETSTATUS_HAPPINESS_TABLE[happiness] .. happyLevel[happiness];
				if(nextXP) then
					local percentXP = (currXP/nextXP)*100 + 0.5;
					local wholeXP, decimalXP = strsplit(",", percentXP, 2);
					if(not wholeXP) or (not decimalXP) then
						wholeXP, decimalXP = strsplit(".", percentXP, 2);
					end
					local xpColorIndex = 5;
					if(percentXP < 21) then
						xpColorIndex = 1;
					elseif(percentXP < 41) then
						xpColorIndex = 2;
					elseif(percentXP < 61) then
						xpColorIndex = 3;
					elseif(percentXP < 81) then
						xpColorIndex = 4;
					end
					if(percentXP > 50) then
						petStats.xp = TitanUtils_GetGreenText(wholeXP .. "%");
					else
						petStats.xp = TitanUtils_GetRedText(wholeXP .. "%");
					end
					petStats.exp = TITAN_PETSTATUS_EXP_TABLE[xpColorIndex] .. " " .. currXP;
					petStats.exp = petStats.exp .. TitanUtils_GetHighlightText("/");
					petStats.exp = petStats.exp .. TitanUtils_GetGreenText(nextXP);
				else
					petStats.xp = TitanUtils_GetGreenText(TITANPETSTATUS_MAX);
					petStats.exp = TitanUtils_GetGreenText(TITANPETSTATUS_MAXLEVEL);
				end
			else
				petStats.name = UnitName("pet");
				petStats.level = UnitLevel("pet");
				petStats.happyLevel = happyLevel[happiness];
				if(nextXP) then
					local percentXP = (currXP/nextXP)*100 + 0.5;
					local wholeXP, decimalXP = strsplit(".", percentXP, 2);
					petStats.xp = wholeXP .. "%";
					petStats.exp = currXP .. "/" .. nextXP;
				else
					petStats.xp = TITANPETSTATUS_MAX;
					petStats.exp = TITANPETSTATUS_MAXLEVEL;
				end
			end
			petStats.foodList = {GetPetFoodTypes()};
	end
	return petStats;
end

--function TitanPanelPetStatus_WheresMyPet()
--	local petList = { };
--	petList.dismissed = { };
--	petList.stabled = { };
--	for i = 0,GetNumStablePets(),1 do
--		local petIcon, petName, petLevel, petType = GetStablePetInfo(i);
--		if(petName) then
--			if(i == 0) then
--				petList.dismissed.name = petName;
--				petList.dismissed.level = petLevel;
--			else
--				petList.stabled[i] = { };
--				petList.stabled[i].name = petName;
--				petList.stabled[i].level = petLevel;
--			end
--		end
--	end
--	return petList;
--end

function TitanPanelPetStatus_ChatMsg(msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

function TitanPanelPetStatus_CheckFeeding()
	local i = 1;
	local buffName = UnitBuff("pet", i);
	local feeding = false;
	while buffName do
		if(buffName == "Feed Pet Effect") then
			feeding = true;
		end
		i = i + 1;
		buffName = UnitBuff("pet", i);
	end
	return feeding;
end

function TitanPanelPetStatus_ChatMsg(msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

function TitanPanelRightClickMenu_PreparePetStatusMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_PETSTATUS_ID].menuText);

	TitanPanelRightClickMenu_AddSpacer();

	local info = {};
	info.text = TITANPETSTATUS_SHOWPETNAME;
	info.func = TitanPanelPetStatusButton_TogglePetName;
	info.checked = TitanGetVar(TITAN_PETSTATUS_ID, "ShowPetName");
	UIDropDownMenu_AddButton(info);
	
	local info = {};
	info.text = TITANPETSTATUS_SHOWPETLEVEL;
	info.func = TitanPanelPetStatusButton_TogglePetLevel;
	info.checked = TitanGetVar(TITAN_PETSTATUS_ID, "ShowPetLevel");
	UIDropDownMenu_AddButton(info);	
	
	local info = {};
	info.text = TITANPETSTATUS_SHOWPETXP;
	info.func = TitanPanelPetStatusButton_TogglePetXP;
	info.checked = TitanGetVar(TITAN_PETSTATUS_ID, "ShowPetXP");
	UIDropDownMenu_AddButton(info);
	
	local info = {};
	info.text = TITANPETSTATUS_SHOWHAPPINESS;
	info.func = TitanPanelPetStatusButton_ToggleHappiness;
	info.checked = TitanGetVar(TITAN_PETSTATUS_ID, "ShowHappiness");
	UIDropDownMenu_AddButton(info);

	local info = {};
	info.text = TITANPETSTATUS_SHOWFEEDING;
	info.func = TitanPanelPetStatusButton_ToggleFeeding;
	info.checked = TitanGetVar(TITAN_PETSTATUS_ID, "ShowFeeding");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_PETSTATUS_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_PETSTATUS_ID);
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_PETSTATUS_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_PETSTATUS_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelPetStatusButton_TogglePetName()
	TitanToggleVar(TITAN_PETSTATUS_ID, "ShowPetName");
	TitanPanelButton_UpdateButton(TITAN_PETSTATUS_ID);
end

function TitanPanelPetStatusButton_TogglePetLevel()
	TitanToggleVar(TITAN_PETSTATUS_ID, "ShowPetLevel");
	TitanPanelButton_UpdateButton(TITAN_PETSTATUS_ID);
end

function TitanPanelPetStatusButton_TogglePetXP()
	TitanToggleVar(TITAN_PETSTATUS_ID, "ShowPetXP");
	TitanPanelButton_UpdateButton(TITAN_PETSTATUS_ID);
end

function TitanPanelPetStatusButton_ToggleHappiness()
	TitanToggleVar(TITAN_PETSTATUS_ID, "ShowHappiness");
	TitanPanelButton_UpdateButton(TITAN_PETSTATUS_ID);
end

function TitanPanelPetStatusButton_ToggleFeeding()
	TitanToggleVar(TITAN_PETSTATUS_ID, "ShowFeeding");
	TitanPanelButton_UpdateButton(TITAN_PETSTATUS_ID);
end