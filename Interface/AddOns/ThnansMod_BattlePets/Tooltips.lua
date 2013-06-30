--[[--------------------------------------------------------------------
	Thnan's Mod - Battle Pets
	Copyright (c) 2013 Thnan

	This addon is freely available, and its source code freely viewable,
	but it is not "open source software" and you may not distribute it,
	with or without modifications, without permission from its author.

	See the included License file for more information!
----------------------------------------------------------------------]]
local addonName, addon = ...;

--[[ helper functions ]]--

local replaceLines = {
	[UNIT_CAPTURABLE] = true,
	[ITEM_PET_KNOWN:format(1, 3)] = true,
	[ITEM_PET_KNOWN:format(2, 3)] = true,
	[ITEM_PET_KNOWN:format(3, 3)] = true,
};
local textList = {};
local rList = {};
local gList = {};
local bList = {};
local function addDataToTooltip(tooltip, ...)
	local numLines = tooltip:NumLines();
	for i = 1, numLines do
		local fstring = _G[(tooltip:GetName()).."TextLeft"..i];
		textList[i] = fstring:GetText();
		rList[i], gList[i], bList[i] = fstring:GetTextColor();
	end
	tooltip:ClearLines();
	local found = false;
	local lines = addon:tooltipLineForPet(...);
	for i = 1, numLines do
		if not replaceLines[textList[i]] then
			if textList[i] ~= " " then	-- for some reason, sell price gets recorded as " "
										-- of course, sell price shouldn't show up at all...
				tooltip:AddLine(textList[i], rList[i], gList[i], bList[i], true);
			end
		else
			if not addon.db.profile.replaceDefaultLine then
				tooltip:AddLine(textList[i], rList[i], gList[i], bList[i], true);
			end
			for j = 1, #lines do
				tooltip:AddLine(lines[j]);
			end
			found = true;
		end
	end
	if not found then
		tooltip:AddLine(lines[1]);
	end
	tooltip:Show();
end

--[[ world tooltips ]]--

local function mouseoverPet_World()
	local config = addon.db.profile.worldTooltips;
	if UnitIsWildBattlePet("mouseover") and addon:dataForPet(UnitName("mouseover")) and config.enabled then
		addDataToTooltip(GameTooltip, UnitName("mouseover"), config.includeLevel, config.includeBreed);
		if addon.db.profile.showHighestZones then
			GameTooltip:AddLine(addon:zoneLineForPet(UnitName("mouseover")), 1, 1, 1, true);
		end
	end
end
GameTooltip:HookScript("OnTooltipSetUnit", mouseoverPet_World);

--[[ minimap tooltips ]]--

local prevLeftText = "";
local prevRightText = "";
local function stripTextureFromString(string)
	local index = string:find("|c");
	if index then
		return string:sub(index+10, -3);
	end
	index = string:find("|t");
	if index then
		return string:sub(index + 2);
	else
		return string;
	end
end
local function constructRightText(text)
	local config = addon.db.profile.minimapTooltips;
	local containsPet = false;
	local rightText = "";
	
	local startIdx = 0;
	local endIdx = text:find("\n");
	while endIdx do
		local curName = text:sub(startIdx + 1, endIdx - 1);
		local textForName = (addon:tooltipLineForPet(stripTextureFromString(curName), config.includeLevel, config.includeBreed))[1];
		rightText = rightText..textForName.."\n";
		if textForName ~= "" then
			containsPet = true;
		end
		startIdx = endIdx;
		endIdx = text:find("\n", startIdx + 1);
	end
	local curName = text:sub(startIdx + 1);
	local textForName = (addon:tooltipLineForPet(stripTextureFromString(curName), config.includeLevel, config.includeBreed))[1];
	rightText = rightText..textForName;
	if textForName ~= "" then
		containsPet = true;
	end
	
	local endChar = rightText:sub(-1);
	if endChar == "\n" then
		rightText = rightText.." ";
	end
		
	if containsPet then
		return rightText;
	else
		return "";
	end
end
local function mouseoverPet_Minimap()
	if addon.db.profile.minimapTooltips.enabled and GetMouseFocus() == Minimap then
		local text = _G["GameTooltipTextLeft1"]:GetText();
		
		if (text ~= prevLeftText) then
			prevLeftText = text;
			prevRightText = constructRightText(text);
		end

		if (prevRightText ~= "") then
			GameTooltip:ClearLines();
			GameTooltip:AddDoubleLine(text, prevRightText);
			GameTooltip:Show();
		end
	end
end
local function tooltipHide()
	prevLeftText = "";
	prevRightText = "";
end

GameTooltip:HookScript("OnUpdate", mouseoverPet_Minimap);
GameTooltip:HookScript("OnHide", tooltipHide);

--[[ battle tooltips ]]--

local petBattleZoneLine = PetBattlePrimaryUnitTooltip:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
petBattleZoneLine:SetPoint("TOPLEFT", PetBattlePrimaryUnitTooltip.CollectedText, "BOTTOMLEFT", 0, -2);
petBattleZoneLine:SetJustifyH("LEFT");
petBattleZoneLine:Hide();

local function mouseoverPet_Battle(self, petOwner, petIndex)
	local config = addon.db.profile.battleTooltips;
	if config.enabled and petOwner == LE_BATTLE_PET_ENEMY and C_PetBattles.IsWildBattle() then
		local speciesID = C_PetBattles.GetPetSpeciesID(LE_BATTLE_PET_ENEMY, petIndex);
		local speciesName, _, _, _, _, _, _, _, _, _, obtainable = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
		if obtainable then
			local oldHeight = self.CollectedText:GetHeight();
			local lines = addon:tooltipLineForPet(speciesName, config.includeLevel, config.includeBreed);
			local text = self.CollectedText:GetText();
			if addon.db.profile.replaceDefaultLine then
				text = lines[1];
			elseif C_PetJournal.GetNumCollectedInfo(speciesID) > 0 then
				text = text.."\n"..lines[1];
			end
			for i = 2, #lines do
				text = text.."\n"..lines[i];
			end
			self.CollectedText:SetText(text);
			self.CollectedText:SetWidth(230);
			local newHeight = self.CollectedText:GetHeight();
			self:SetHeight(self:GetHeight() + newHeight - oldHeight);
			if addon.db.profile.showHighestZones then
				petBattleZoneLine:SetText(addon:zoneLineForPet(speciesName));
				petBattleZoneLine:Show();
				self.HealthBorder:SetPoint("TOPLEFT", petBattleZoneLine, "BOTTOMLEFT", -1, -6);
				petBattleZoneLine:SetWidth(230);
				self:SetHeight(self:GetHeight() + petBattleZoneLine:GetHeight() + 2);
			else
				petBattleZoneLine:Hide();
			end
		else
			petBattleZoneLine:Hide();
		end
	else
		petBattleZoneLine:Hide();
	end
end
hooksecurefunc(_G, "PetBattleUnitTooltip_UpdateForUnit", mouseoverPet_Battle);

--[[ item tooltips ]]--

local speciesIDFromItemID = addon.staticData.speciesIDFromItemID;
local function addLinesToItemTooltip(tooltip, link)
	local config = addon.db.profile.itemTooltips;
	if config.enabled and link then
		local idx = link:find("item:");
		if idx then
			link = link:sub(idx + 5);
			idx = link:find(":");
			if idx then
				local itemID = tonumber(link:sub(1, idx - 1));
				if speciesIDFromItemID[itemID] then
					local speciesName = C_PetJournal.GetPetInfoBySpeciesID(addon.staticData.speciesIDFromItemID[itemID]);
					addDataToTooltip(tooltip, speciesName, config.includeLevel, config.includeBreed);
				end
			end
		end
	end
end
local function mouseoverPet_Item()
	local _, link = GameTooltip:GetItem()
	addLinesToItemTooltip(GameTooltip, link);
end
GameTooltip:HookScript("OnTooltipSetItem", mouseoverPet_Item);
hooksecurefunc(ItemRefTooltip, "SetHyperlink", addLinesToItemTooltip);

--[[ cage tooltips ]]--

local cageTooltipFontStrings = {};
cageTooltipFontStrings[1] = BattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
cageTooltipFontStrings[2] = BattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
cageTooltipFontStrings[3] = BattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
cageTooltipFontStrings[1]:SetPoint("TOPLEFT", BattlePetTooltip.Owned, "BOTTOMLEFT", 0, -2);
cageTooltipFontStrings[2]:SetPoint("TOPLEFT", cageTooltipFontStrings[1], "BOTTOMLEFT", 0, -2);
cageTooltipFontStrings[3]:SetPoint("TOPLEFT", cageTooltipFontStrings[2], "BOTTOMLEFT", 0, -2);
local cageTooltipBreedString = BattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
cageTooltipBreedString:SetPoint("TOPLEFT", BattlePetTooltip.Level, "BOTTOMLEFT", 0, -2);
local function mouseoverPet_Cage(speciesID, level, rarity, health, power, speed)
	local config = addon.db.profile.itemTooltips;
	if config.enabled and speciesID then
		local name = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
		local lines = addon:tooltipLineForPet(name, config.includeLevel, config.includeBreed);
		local offset = 0;
		if C_PetJournal.GetNumCollectedInfo(speciesID) == 0 or addon.db.profile.replaceDefaultLine then
			BattlePetTooltip.Owned:SetText(lines[1]);
			offset = 1;
		end
		if C_PetJournal.GetNumCollectedInfo(speciesID) == 0 then
			BattlePetTooltip:SetHeight(BattlePetTooltip:GetHeight() + BattlePetTooltip.Owned:GetHeight() + 2);
		end
		for i = 1, #cageTooltipFontStrings do
			if lines[i + offset] then
				cageTooltipFontStrings[i]:SetText(lines[i + offset]);
				BattlePetTooltip:SetHeight(BattlePetTooltip:GetHeight() + cageTooltipFontStrings[i]:GetHeight() + 2);
				cageTooltipFontStrings[i]:Show();
			else
				cageTooltipFontStrings[i]:Hide();
			end
		end
	else
		for i = 1, #cageTooltipFontStrings do
			cageTooltipFontStrings[i]:Hide();
		end
	end
	if addon.db.profile.showBreedOnCages then
		cageTooltipBreedString:SetText("|cFFFFFFFF"..addon:textForBreeds(addon:breedsForPet(speciesID, level, rarity, health, power, speed)).."|r");
		cageTooltipBreedString:Show();
		BattlePetTooltip:SetHeight(BattlePetTooltip:GetHeight() + cageTooltipBreedString:GetHeight() + 2);
		BattlePetTooltip.HealthTexture:SetPoint("TOPLEFT", cageTooltipBreedString, "BOTTOMLEFT", 0, -2);
	else
		cageTooltipBreedString:Hide();
		BattlePetTooltip.HealthTexture:SetPoint("TOPLEFT", BattlePetTooltip.Level, "BOTTOMLEFT", 0, -2);
	end
end

local hyperlinkTooltipFontStrings = {};
hyperlinkTooltipFontStrings[1] = FloatingBattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
hyperlinkTooltipFontStrings[2] = FloatingBattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
hyperlinkTooltipFontStrings[3] = FloatingBattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
hyperlinkTooltipFontStrings[1]:SetPoint("TOPLEFT", FloatingBattlePetTooltip.Owned, "BOTTOMLEFT", 0, -2);
hyperlinkTooltipFontStrings[2]:SetPoint("TOPLEFT", hyperlinkTooltipFontStrings[1], "BOTTOMLEFT", 0, -2);
hyperlinkTooltipFontStrings[3]:SetPoint("TOPLEFT", hyperlinkTooltipFontStrings[2], "BOTTOMLEFT", 0, -2);
local hyperlinkTooltipBreedString = FloatingBattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
hyperlinkTooltipBreedString:SetPoint("TOPLEFT", FloatingBattlePetTooltip.Level, "BOTTOMLEFT", 0, -2);
local function hyperlinkPet_Cage(speciesID, level, rarity, health, power, speed)
	local config = addon.db.profile.itemTooltips;
	if config.enabled and speciesID then
		local name = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
		local lines = addon:tooltipLineForPet(name, config.includeLevel, config.includeBreed);
		local offset = 0;
		local lastItem = FloatingBattlePetTooltip.Owned;
		if C_PetJournal.GetNumCollectedInfo(speciesID) == 0 or addon.db.profile.replaceDefaultLine then
			FloatingBattlePetTooltip.Owned:SetText(lines[1]);
			offset = 1;
		end
		if C_PetJournal.GetNumCollectedInfo(speciesID) == 0 then
			FloatingBattlePetTooltip:SetHeight(FloatingBattlePetTooltip:GetHeight() + FloatingBattlePetTooltip.Owned:GetHeight());
		end
		for i = 1, #hyperlinkTooltipFontStrings do
			if lines[i + offset] then
				hyperlinkTooltipFontStrings[i]:SetText(lines[i + offset]);
				FloatingBattlePetTooltip:SetHeight(FloatingBattlePetTooltip:GetHeight() + hyperlinkTooltipFontStrings[i]:GetHeight() + 2);
				hyperlinkTooltipFontStrings[i]:Show();
				lastItem = hyperlinkTooltipFontStrings[i];
			else
				hyperlinkTooltipFontStrings[i]:Hide();
			end
		end
		FloatingBattlePetTooltip.Delimiter:SetPoint("TOPLEFT", lastItem, "BOTTOMLEFT", -6, -5);
	else
		for i = 1, #hyperlinkTooltipFontStrings do
			hyperlinkTooltipFontStrings[i]:Hide();
		end
	end
	if addon.db.profile.showBreedOnCages then
		hyperlinkTooltipBreedString:SetText("|cFFFFFFFF"..addon:textForBreeds(addon:breedsForPet(speciesID, level, rarity, health, power, speed)).."|r");
		hyperlinkTooltipBreedString:Show();
		FloatingBattlePetTooltip:SetHeight(FloatingBattlePetTooltip:GetHeight() + hyperlinkTooltipBreedString:GetHeight() + 2);
		FloatingBattlePetTooltip.HealthTexture:SetPoint("TOPLEFT", hyperlinkTooltipBreedString, "BOTTOMLEFT", 0, -2);
	else
		cageTooltipBreedString:Hide();
		FloatingBattlePetTooltip.HealthTexture:SetPoint("TOPLEFT", FloatingBattlePetTooltip.Level, "BOTTOMLEFT", 0, -2);
	end
end

hooksecurefunc(_G, "BattlePetToolTip_Show", mouseoverPet_Cage);
hooksecurefunc(_G, "FloatingBattlePet_Show", hyperlinkPet_Cage);
