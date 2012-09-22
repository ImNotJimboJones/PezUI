-------------------------------------------------------------------------------
-- MrTrader
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

local MenuSpacer = {
	text = "",
	notCheckable = true,
	isTitle = true,
}

local CloseButton = {
	text = MRTLoc["Close"],
	notCheckable = true,
	func = function() CloseDropDownMenus() end,
}

function MrTrader:InitializeMenu()
	local LDB = LibStub("LibDataBroker-1.1", true);
	if LDB then
		self.dropdown = CreateFrame("Frame", "MrTraderMenu", UIParent, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(self.dropdown, 140);
	
		self.launcherobj = LDB:NewDataObject("MrTrader", {
	    	type = "launcher",
			label = "MrTrader",
	    	icon = "Interface\\Addons\\MrTrader\\MrTrader",
	    	OnClick = function(clickedframe, button)
	        	MrTrader:OpenMenu(clickedframe, button);
	    	end,
			OnTooltipShow = function(tip)
				if not tip or not tip.AddLine then return end
				tip:AddLine(MRTLoc["MrTrader"])
				tip:AddLine(MRTLoc["Click to open menu."], 1, 1, 1)
			end,
		})
	end
end

function MrTrader:OpenMenu(frame, button)
	if button == "LeftButton" then
		local func = function(menu, level) MrTrader:InitializeMenuContent(menu, level) end;
		UIDropDownMenu_Initialize(self.dropdown, func, "MENU");
		-- UIDropDownMenu_SetAnchor(self.dropdown, 0, 0, "TOPRIGHT", frame, "TOPLEFT"); 
		ToggleDropDownMenu(1, nil, self.dropdown, frame, 0, 0);
		-- Menu:Open(frame, "children", function() MrTrader:UpdateMenu() end);
	end
end

function MrTrader:InitializeMenuContent(menu, level)
	MrTrader:QuerySkills();
	local skillTable = MrTrader:GetSkillTable();
	local characterCount = MrTrader:TableSize(skillTable);
	local currentPlayer = UnitName("player");
	local currentFaction = UnitFactionGroup("player");
	local info = {};
	
	QueryGuildRecipes();
	
	if( level == 1 ) then
		if( skillTable[currentPlayer] ) then
			characterCount = characterCount - 1;
			
			info.text = MRTLoc["Tradeskills"];
			info.isTitle = 1;
			info.notCheckable = true;
			UIDropDownMenu_AddButton(info, level);
		
			wipe(info);
			if(GetProfessions == nil) then
				-- Wrath version
				for skillID, skillLink in pairs(skillTable[currentPlayer]) do
					local skillName, _, skillIcon = GetSpellInfo(skillID);
					if( skillName ) then
						local tooltip = MRTLoc["Click to open tradeskill window."];
						if skillLink then
							tooltip = MRTLoc["Click to open tradeskill window. Shift-click to link tradeskill."];
						end
			
						info.text = skillName;
						info.icon = skillIcon;
						info.tooltipTitle = skillName .. "     ";
						info.tooltipText = tooltip;
						info.notCheckable = true;
						info.func = function() MrTrader:OpenLink(skillName, skillLink, true); end;
						UIDropDownMenu_AddButton(info, level);
					end
				end
			else
				-- Cata version, can get the profession list live.
				for _, spellId in pairs(MrTrader:ClassTradeskills()) do
					if FindSpellBookSlotBySpellID(spellId) then
						local spellName, _, spellIcon = GetSpellInfo(spellId);
						local _, tradeLink = GetSpellLink(spellId);
						
						local tooltip = MRTLoc["Click to open tradeskill window."];
						if tradeLink then
							tooltip = MRTLoc["Click to open tradeskill window. Shift-click to link tradeskill."];
						end
						
						info.text = spellName .. "     ";
						info.icon = spellIcon;
						info.tooltipTitle = skillName;
						info.tooltipText = tooltip;
						info.notCheckable = true;
						info.func = function() MrTrader:OpenLink(spellName, tradeLink, true); end;
						UIDropDownMenu_AddButton(info, level);
					end
				end
				
				local profTable = MrTrader:TablePack(GetProfessions());
				local profCount = getn(profTable);
				for i=1, profCount do
					name, icon, rank, maxrank, numspells, spelloffset, skillline = GetProfessionInfo(profTable[i]); 
					
					for i=1,numspells do
						local _, skillId = GetSpellBookItemInfo(spelloffset + i, "spell");
						local spellName, _, spellIcon = GetSpellInfo(spelloffset + i, "spell");
						local _, tradeLink = GetSpellLink(skillId);

						local tooltip = MRTLoc["Click to open tradeskill window."];
						if tradeLink then
							tooltip = MRTLoc["Click to open tradeskill window. Shift-click to link tradeskill."];
						end
					
						if(MrTrader:IsTradeskillSpell(spellName)) then
							info.text = spellName .. "     ";
							info.icon = spellIcon;
							info.tooltipTitle = skillName;
							info.tooltipText = tooltip;
							info.notCheckable = true;
							info.func = function() MrTrader:OpenLink(spellName, tradeLink, true); end;
							UIDropDownMenu_AddButton(info, level);
						end
					end
				end
			end
		
			UIDropDownMenu_AddButton(MenuSpacer, level);
			if MrTrader:CharacterIsIgnored(currentPlayer) then
				wipe(info);
				info.text = MRTLoc["Unignore"];
				info.tooltipTitle = MRTLoc["Unignore"];
				info.tooltipText = MRTLoc["Unignore this character and show on all other characters."];
				info.notCheckable = true;
				info.func = function() MrTrader:UnignoreCharacter(currentPlayer); end;
				UIDropDownMenu_AddButton(info, level);
					
				UIDropDownMenu_AddButton(MenuSpacer, level);	
			end
			
			if(IsInGuild()) then
				wipe(info);
				info.text = MRTLoc["Guild"];
				info.tooltipTitle = MRTLoc["Guild"];
				info.tooltipText = MRTLoc["View Guild Professions."];
				info.notCheckable = true;
				info.hasArrow = true;
				info.value = "guildroster";
				UIDropDownMenu_AddButton(info, level);
				UIDropDownMenu_AddButton(MenuSpacer, level);
			end
		end
		
		if( characterCount > 0 ) then
			wipe(info);
			info.text = MRTLoc["Tradeskills"];
			info.notCheckable = true;
			info.isTitle = 1;
			UIDropDownMenu_AddButton(info, level);
			
			wipe(info);
			for playerName, skillList in pairs(skillTable) do
				-- Find out if we need to display this character, and if it is in the same faction
				local sameFaction = true;
				if skillList["faction"] and skillList["faction"] ~= currentFaction then
					sameFaction = false;
				end
				local shouldDisplay = sameFaction or self.db.profile.showOppositeFaction;
				local shouldDisplay = shouldDisplay and not MrTrader:CharacterIsIgnored(playerName);
				local shouldDisplay = shouldDisplay and (playerName ~= currentPlayer);

				if( shouldDisplay ) then
					info.text = playerName;
					info.value = playerName;
					info.hasArrow = true;
					info.notCheckable = true;
					if( not sameFaction ) then
						info.colorCode = "|cFFFF6666";
					else
						info.colorCode = nil;
					end
					UIDropDownMenu_AddButton(info, level);
				end
			end
			
			UIDropDownMenu_AddButton(MenuSpacer, level);
		end

		UIDropDownMenu_AddButton(CloseButton, level);
	elseif( level == 2 ) then
		local playerName = UIDROPDOWNMENU_MENU_VALUE;
		
		if(playerName == "guildroster") then
			local numTradeskill = GetNumGuildTradeSkill();
			for i = 1, numTradeskill do
				local skillID, _, skillIcon, skillName, _, _, skillPlayer = GetGuildTradeSkillInfo(i);
				if skillName ~= nil and CanViewGuildRecipes(skillID) then
					wipe(info);
					info.text = skillName;
					info.tooltipTitle = skillName;
					info.tooltipText = MRTLoc["Click to open tradeskill window. Shift-click to link tradeskill."];
					info.icon = skillIcon;
					info.notCheckable = true;
					info.func = function()
									ViewGuildRecipes(skillID);
				                end;
				    UIDropDownMenu_AddButton(info, level);
				end
			end
		else
			for skillID, skillLink in pairs(skillTable[playerName]) do
				local showSkill = false;
				local skillName, _, skillIcon = GetSpellInfo(skillID);
				local tooltip = MRTLoc["Tradeskill cannot be linked, and is unavailable."];
				if skillLink then
					tooltip = MRTLoc["Click to open tradeskill window. Shift-click to link tradeskill."];
				end
				if skillName then
					showSkill = skillLink or self.db.profile.showSecondarySkills;
				end
				if skillName and showSkill then
					info.text = skillName;
					info.tooltipTitle = skillName;
					info.tooltipText = tooltip;
					info.icon = skillIcon;
					info.disabled = not skillLink;
					info.notCheckable = true;
					info.func = function() 
									MrTrader:OpenLink(skillName, skillLink, false); 
									CloseDropDownMenus();
								end;
					UIDropDownMenu_AddButton(info, level);
				end
			end

			UIDropDownMenu_AddButton(MenuSpacer, level);

			wipe(info);
			info.text = MRTLoc["Remove"];
			info.tooltipTitle = MRTLoc["Remove"];
			info.tooltipText = MRTLoc["Click to remove from the list, shift-click to ignore this character permanently."];
			info.notCheckable = true;
			info.func = function()
					if IsShiftKeyDown() then
						MrTrader:IgnoreCharacter(playerName);
						CloseDropDownMenus();
					else
						MrTrader:RemoveCharacter(playerName);
						CloseDropDownMenus();
					end
				end;
			UIDropDownMenu_AddButton(info, level);
		end
	end
end

function MrTrader:OpenLink(name, link, isCurrentPlayer)
	if IsShiftKeyDown() then
		if (not ChatEdit_InsertLink(link)) then
			ChatEdit_ActivateChat(ChatEdit_GetLastActiveWindow());
		    ChatEdit_InsertLink(link);
		end
	else
		if isCurrentPlayer then
			CastSpellByName(name);
		else
			-- Open link via chat window
			local chatLink = string.gsub(link, "|", ":");
			local _, startIndex = string.find(chatLink, ":H");
			local endIndex = string.find(chatLink, ":h");
			chatLink = string.sub(chatLink, startIndex + 1, endIndex - 1);
			ChatFrame_OnHyperlinkShow(nil, chatLink, link, "LeftButton");
		end
	end
end