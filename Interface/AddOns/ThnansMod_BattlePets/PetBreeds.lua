--[[--------------------------------------------------------------------
	Thnan's Mod - Battle Pets
	Copyright (c) 2013 Thnan

	This addon is freely available, and its source code freely viewable,
	but it is not "open source software" and you may not distribute it,
	with or without modifications, without permission from its author.

	See the included License file for more information!
----------------------------------------------------------------------]]
local addonName, addon = ...;

local AceEvent = LibStub("AceEvent-3.0");

local L = LibStub("AceLocale-3.0"):GetLocale(addonName);

--[[ breed calculation ]]--

-- 1 = health, 2 = power, 3 = speed
local breedStats = addon.staticData.breedStats;
local baseStats = addon.staticData.baseStats;

local breedsForSpecies = addon.staticData.breedsForSpecies;

local rarityMultipliers = {
	1.0,
	1.1,
	1.2,
	1.29999,
};
function addon:breedsForPet(speciesID, level, rarity, health, power, speed, table, tolerateHealth)
	local possibles = breedsForSpecies[speciesID];
	local base = baseStats[speciesID];
	if not possibles then
		return nil;
	end
	table = (table and wipe(table)) or {};
	if type(possibles) == "number" then
		table[1] = possibles;
		return table;
	end
	local LR = level*rarityMultipliers[rarity];
	for i = 1, #possibles do
		local breed = breedStats[possibles[i]];
		
		local testHealth = floor((base[1] + breed[1])*5*LR + 0.5) + 100;
		local testPower = floor((base[2] + breed[2])*LR + 0.5);
		local testSpeed = floor((base[3] + breed[3])*LR + 0.5);
		
		local healthCheck = testHealth == health;
		if tolerateHealth then
			healthCheck = (abs(testHealth - health) <= 1);
		end
		if healthCheck and testPower == power and testSpeed == speed then
			table[#table + 1] = possibles[i];
		end
	end
	return table;
end

local breedStrings = {
	[3] = L.breedText3,
	[4] = L.breedText4,
	[5] = L.breedText5,
	[6] = L.breedText6,
	[7] = L.breedText7,
	[8] = L.breedText8,
	[9] = L.breedText9,
	[10] = L.breedText10,
	[11] = L.breedText11,
	[12] = L.breedText12,
};
function addon:textForBreeds(breeds)
	if not breeds or #breeds == 0 then
		return L.cantCalculateBreed;
	end
	if type(breeds) == "string" then
		return breeds;
	end
	local useLetters = addon.db.profile.useBreedLetterCodes;
	local text = breeds[1].."/"..(breeds[1] + 10);
	if useLetters then
		text = breedStrings[breeds[1]];
	end
	for i = 2, #breeds do
		if useLetters then
			text = text..L.multipleBreedSeparator..breedStrings[breeds[i]];
		else
			text = text..L.multipleBreedSeparator..breeds[i].."/"..(breeds[i] + 10)
		end
	end
	return text;
end

--[[ pet journal integration ]]--

local breedString = PetJournalPetCardQualityFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
breedString:SetPoint("TOPLEFT", PetJournalPetCardQualityFrame.quality, "TOPRIGHT", 5, 0);

local function updatePetJournalBreed(self)
	if self.petID and addon.db.profile.showBreedInJournal then
		local speciesID, _, level, _, _, _, _, _, _, _, _, _, _, _, canBattle = C_PetJournal.GetPetInfoByPetID(self.petID);
		local _, health, power, speed, rarity = C_PetJournal.GetPetStats(self.petID);
		if canBattle then
			breedString:SetText(addon:textForBreeds(addon:breedsForPet(speciesID, level, rarity, health, power, speed)));
			breedString:Show();
		else
			breedString:Hide();
		end
	else
		breedString:Hide();
	end
end
hooksecurefunc(_G, "PetJournal_UpdatePetCard", updatePetJournalBreed);

--[[ battle integration ]]--

local battleBreeds = {};
battleBreeds[LE_BATTLE_PET_ALLY] = {
	L.noBreedInfo,
	L.noBreedInfo,
	L.noBreedInfo,
};
battleBreeds[LE_BATTLE_PET_ENEMY] = {
	L.noBreedInfo,
	L.noBreedInfo,
	L.noBreedInfo,
};
function battleBreeds:parseBattleBreeds()
	for owner = 1, 2 do
		for pet = 1, C_PetBattles.GetNumPets(owner) do
			local speciesID = C_PetBattles.GetPetSpeciesID(owner, pet);
			local level = C_PetBattles.GetLevel(owner, pet);
			local rarity = C_PetBattles.GetBreedQuality(owner, pet);
			local health = C_PetBattles.GetMaxHealth(owner, pet);
			local power = C_PetBattles.GetPower(owner, pet);
			local speed = C_PetBattles.GetSpeed(owner, pet);
		
			local type = C_PetBattles.GetPetType(owner, pet);
			if type == 3 then
				local curHealth = C_PetBattles.GetHealth(owner, pet);
				if curHealth > (health/2) then
					speed = floor(speed/1.5 + 0.5);
				end
			end
			
			local tolerateHealth = false;
			if owner == 2 and C_PetBattles.IsWildBattle() then
				health = floor(health*1.2 + 0.5);
				tolerateHealth = true;
			end
			battleBreeds[owner][pet] = addon:breedsForPet(speciesID, level, rarity, health, power, speed, nil, tolerateHealth);
		end
	end
end
AceEvent.RegisterEvent(battleBreeds, "PET_BATTLE_OPENING_START", "parseBattleBreeds");

local tooltipBreedString = PetBattlePrimaryUnitTooltip:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
tooltipBreedString:SetPoint("TOPLEFT", PetBattlePrimaryUnitTooltip.Icon, "BOTTOMLEFT", 0, -4);
local function addBreedToBattleTooltip(self, owner, pet)
	if addon.db.profile.showBreedInBattle then
		tooltipBreedString:Show();
		tooltipBreedString:SetText(addon:textForBreeds(battleBreeds[owner][pet]));
		local nextItem, x, y = self.HealthBorder, -1, -6;
		if owner == LE_BATTLE_PET_ENEMY and C_PetBattles.IsWildBattle() then
			local speciesID = C_PetBattles.GetPetSpeciesID(owner, pet);
			local _, _, _, _, _, _, _, _, _, _, obtainable = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
			if obtainable then
				nextItem, x, y = self.CollectedText, 0, -2;
			end
		end
		nextItem:SetPoint("TOPLEFT", tooltipBreedString, "BOTTOMLEFT", x, y);
		self:SetHeight(self:GetHeight() + tooltipBreedString:GetHeight() + 2);
	else
		tooltipBreedString:Hide();
	end
end
hooksecurefunc(_G, "PetBattleUnitTooltip_UpdateForUnit", addBreedToBattleTooltip);
