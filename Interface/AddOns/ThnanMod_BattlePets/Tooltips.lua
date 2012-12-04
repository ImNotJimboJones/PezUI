local _, WPT = ...;
local L = WPT.L;
local config = WPT.config;

-- tooltip line generation

local function petList()
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
		PetJournal:UnregisterEvent("PET_JOURNAL_LIST_UPDATE");
		-- this event will be spammed while we play with the filters... no need for
		-- the journal to update every time. We'll reregister it when we're done.
	end
	
	-- clear all filters
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, false);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, true);
	C_PetJournal.AddAllPetSourcesFilter();
	C_PetJournal.AddAllPetTypesFilter();
	C_PetJournal.ClearSearchFilter();
	
	-- search all pets for rarities
	local wildPets = {};
	for i = 1, C_PetJournal.GetNumPets(false) do
		local petID, _, isOwned, _, _, _, _, name, _, _, _, _, _, isWildPet = C_PetJournal.GetPetInfoByIndex(i, false);
		if isWildPet then
			local _, _, _, _, rarity = C_PetJournal.GetPetStats(petID);
			
			if (type(wildPets[name]) == "table") then
				if (rarity > wildPets[name].rarity) then
					wildPets[name].rarity = rarity;
				end
			else
				wildPets[name] = {};
				wildPets[name].owned = isOwned;
				wildPets[name].rarity = rarity;
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
	if PetJournal then
		PetJournal:RegisterEvent("PET_JOURNAL_LIST_UPDATE");
		-- Hey look! All fixed!
	end
	return wildPets;
end
local function tooltipLineForPet(name)
	local wildPets = petList();
	
	if (wildPets[name] ~= nil) then
		if (wildPets[name].owned) then
			local rarityColor = ITEM_QUALITY_COLORS[wildPets[name].rarity - 1].hex;
			local rarityName = _G["BATTLE_PET_BREED_QUALITY"..wildPets[name].rarity];
			
			return rarityColor..(L.caught:format(rarityName)).."|r";
		else
			return ITEM_QUALITY_COLORS[5].hex..L.notCaught.."|r";
		end
	else
		return "";
	end
end

-- world tooltips

local function mouseoverPet_World()
	if (config.enabled and UnitIsWildBattlePet("mouseover")) then
		local line = tooltipLineForPet(UnitName("mouseover"));
		if (line ~= "") then
			GameTooltip:AddLine(line);
			GameTooltip:Show();
		end
		collectgarbage();
	end
end
local mouseoverFrame = CreateFrame("Frame");
mouseoverFrame:SetScript("OnEvent", mouseoverPet_World);
mouseoverFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

-- minimap tooltips

local prevLeftText = "";
local prevRightText = "";
local function stripTextureFromString(string)
	local index = string:find("|t");
	if (index ~= nil) then
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
		rightText = tooltipLineForPet(stripTextureFromString(names[1]));
		if (rightText ~= "") then
			containsWildBattlePet = true;
		end
	end
	
	for i = 2, #names do
		local textForName = tooltipLineForPet(stripTextureFromString(names[i]));
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
		collectgarbage();
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
		local caughtRarity = tooltipLineForPet(speciesName);
		collectgarbage();
		local numOwned = C_PetJournal.GetNumCollectedInfo(speciesID);
		if numOwned > 0 then
			if not self.CollectedRarityText then
				self.CollectedRarityText = self:CreateFontString(nil, "ARTWORK", "GameFontNormal");
				self.CollectedRarityText:SetPoint("TOPLEFT", self.CollectedText, "BOTTOMLEFT", 0, -6);
			end
			self.CollectedRarityText:SetText(caughtRarity);
			self.CollectedRarityText:Show();
			self.HealthBorder:SetPoint("TOPLEFT", self.CollectedRarityText, "BOTTOMLEFT", -1, -6);
			self:SetHeight(self:GetHeight() + self.CollectedRarityText:GetHeight());
		else
			self.CollectedRarityText:Hide();
		end
	else
		if self.CollectedRarityText then
			self.CollectedRarityText:Hide();
		end
	end
end

hooksecurefunc(_G, "PetBattleUnitTooltip_UpdateForUnit", mouseoverPet_Battle);