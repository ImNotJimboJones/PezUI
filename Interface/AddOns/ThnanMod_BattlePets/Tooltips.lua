local _, WPT = ...;
local L = WPT.L;
local config = WPT.config;

-- maintain pet list

local petList = {};
local petListTainted = true;
local function taintPetList()
	petListTainted = true;
end
local taintFrame = CreateFrame("Frame");
taintFrame:SetScript("OnEvent", taintPetList);
taintFrame:RegisterEvent("PET_JOURNAL_LIST_UPDATE");
local function updatePetList()
	local registeredFrames = {GetFramesRegisteredForEvent("PET_JOURNAL_LIST_UPDATE")};
	for key, frame in pairs(registeredFrames) do
		frame:UnregisterEvent("PET_JOURNAL_LIST_UPDATE");
		-- this event will be spammed while we play with the filters... no need for
		-- other frames to update every time. We'll reregister them when we're done.
	end
	-- record current filter settings
	local collectedFlag = C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_COLLECTED);
	local favoritesFlag = C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_FAVORITES);
	local notCollectedFlag = C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_NOT_COLLECTED);
	local sourceFlags = {};
	for i = 1, C_PetJournal.GetNumPetSources() do
		sourceFlags[i] = C_PetJournal.IsPetSourceFiltered(i);
	end
	local typeFlags = {};
	for i = 1, C_PetJournal.GetNumPetTypes() do
		typeFlags[i] = C_PetJournal.IsPetTypeFiltered(i);
	end
	local searchText = nil;
	if PetJournal then
		searchText = PetJournal.searchBox:GetText();
	end
	
	-- clear all filters
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, false);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, true);
	C_PetJournal.AddAllPetSourcesFilter();
	C_PetJournal.AddAllPetTypesFilter();
	C_PetJournal.ClearSearchFilter();
	
	-- search all pets for rarities
	petList = {};
	for i = 1, C_PetJournal.GetNumPets(false) do
		local petID, _, isOwned, _, level, _, _, name, _, _, _, _, _, isWildPet = C_PetJournal.GetPetInfoByIndex(i, false);
		if isWildPet then
			local _, _, _, _, rarity = C_PetJournal.GetPetStats(petID);
			if not rarity then
				rarity = 0;
			end
			if not level then
				level = 0;
			end
			if (type(petList[name]) ~= "table") then
				petList[name] = {};
				petList[name].owned = isOwned;
				petList[name].rarity = 0;
				petList[name].level = 0;
			end
			local i = #petList[name] + 1;
			if isOwned then
				petList[name][i] = {};
				petList[name][i].rarity = rarity;
				petList[name][i].level = level;
			end
			if (rarity > petList[name].rarity) then
				petList[name].index = i;
				petList[name].rarity = rarity;
				petList[name].level = level;
			elseif (rarity == petList[name].rarity and level > petList[name].level) then
				petList[name].index = i;
				petList[name].level = level;
			end
		end
	end

	-- restore filter settings
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, not collectedFlag);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, not favoritesFlag);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, not notCollectedFlag);
	for i = 1, #sourceFlags do
		C_PetJournal.SetPetSourceFilter(i, not sourceFlags[i]);
	end
	for i = 1, #typeFlags do
		C_PetJournal.SetPetTypeFilter(i, not typeFlags[i]);
	end
	if searchText and (searchText ~= SEARCH) then
		C_PetJournal.SetSearchFilter(searchText);
	end
	for key, frame in pairs(registeredFrames) do
		frame:RegisterEvent("PET_JOURNAL_LIST_UPDATE");
		-- Hey look! All fixed!
	end
	petListTainted = false;
end

-- tooltip line generation

local tooltipLines = {};
local additionalLines = {};
for rarity = 1, 4 do
	local rarityColor = ITEM_QUALITY_COLORS[rarity - 1].hex;
	local rarityName = _G["BATTLE_PET_BREED_QUALITY"..rarity];
	tooltipLines[rarity] = rarityColor..(L.caught:format(rarityName)).."|r";
	additionalLines[rarity] = rarityColor..(L.alsoCaught:format(rarityName)).."|r";
end
tooltipLines[0] = ITEM_QUALITY_COLORS[5].hex..L.notCaught.."|r";
local function tooltipLineForPet(name, includeLevel)
	if petListTainted then
		updatePetList();
	end
	if petList[name] then
		local ret1, ret2, ret3 = nil, nil, nil;
		if (includeLevel and petList[name].level > 0) then
			ret1 = tooltipLines[petList[name].rarity].." |cFFFFFFFF"..L.caughtLevel:format(petList[name].level).."|r";
		else
			ret1 = tooltipLines[petList[name].rarity];
		end
		if petList[name].owned and config.showAdditionalPets then
			for i = 1, #petList[name] do
				if i ~= petList[name].index then
					if ret2 then
						if (includeLevel and petList[name].level > 0) then
							ret3 = additionalLines[petList[name][i].rarity].." |cFFFFFFFF"..L.caughtLevel:format(petList[name][i].level).."|r";
						else
							ret3 = additionalLines[petList[name][i].rarity];
						end
					else
						if (includeLevel and petList[name].level > 0) then
							ret2 = additionalLines[petList[name][i].rarity].." |cFFFFFFFF"..L.caughtLevel:format(petList[name][i].level).."|r";
						else
							ret2 = additionalLines[petList[name][i].rarity];
						end
					end
				end
			end
		end
		
		return ret1, ret2, ret3;
	else
		return "";
	end
end

-- world tooltips

local function mouseoverPet_World()
	if (config.enabled and UnitIsWildBattlePet("mouseover")) then
		local lines = {tooltipLineForPet(UnitName("mouseover"), config.showLevelInWorld)};
		for i = 1, #lines do
			if (lines[i] ~= "") then
				GameTooltip:AddLine(lines[i]);
			end
		end
		GameTooltip:Show();
	end
end
local mouseoverFrame = CreateFrame("Frame");
mouseoverFrame:SetScript("OnEvent", mouseoverPet_World);
mouseoverFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

-- minimap tooltips

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
	local names = {strsplit("\n", text)};
	
	local containsWildBattlePet = false;

	local rightText = "";
	
	if (#names > 0) then
		rightText = tooltipLineForPet(stripTextureFromString(names[1]), config.showLevelInMinimap);
		if (rightText ~= "") then
			containsWildBattlePet = true;
		end
	end
	
	for i = 2, #names do
		local textForName = tooltipLineForPet(stripTextureFromString(names[i]), config.showLevelInMinimap);
		rightText = rightText.."\n"..textForName;
		if (textForName ~= "") then
			containsWildBattlePet = true;
		end
	end
	
	if containsWildBattlePet then
		return rightText;
	else
		return "";
	end
end
local function mouseoverPet_Minimap()
	if (config.enabled and GetMouseFocus() == Minimap) then
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

-- battle tooltips

local function mouseoverPet_Battle(self, petOwner, petIndex)
	if (config.enabled and petOwner == LE_BATTLE_PET_ENEMY and C_PetBattles.IsWildBattle()) then
		local speciesID = C_PetBattles.GetPetSpeciesID(LE_BATTLE_PET_ENEMY, petIndex);
		local speciesName = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
		local caughtLines = {tooltipLineForPet(speciesName, config.showLevelInBattle)};
		local caughtRarity = caughtLines[1];
		for i = 2, #caughtLines do
			caughtRarity = caughtRarity.."\n"..caughtLines[i];
		end
		local numOwned = C_PetJournal.GetNumCollectedInfo(speciesID);
		if numOwned > 0 then
			if not self.CollectedRarityText then
				self.CollectedRarityText = self:CreateFontString(nil, "ARTWORK", "GameFontNormal");
				self.CollectedRarityText:SetPoint("TOPLEFT", self.CollectedText, "BOTTOMLEFT", 0, -6);
				self.CollectedRarityText:SetJustifyH("LEFT");
			end
			self.CollectedRarityText:SetText(caughtRarity);
			self.CollectedRarityText:Show();
			self.HealthBorder:SetPoint("TOPLEFT", self.CollectedRarityText, "BOTTOMLEFT", -1, -6);
			self:SetHeight(self:GetHeight() + self.CollectedRarityText:GetHeight());
		else
			if self.CollectedRarityText then
				self.CollectedRarityText:Hide();
			end
		end
	else
		if self.CollectedRarityText then
			self.CollectedRarityText:Hide();
		end
	end
end
hooksecurefunc(_G, "PetBattleUnitTooltip_UpdateForUnit", mouseoverPet_Battle);