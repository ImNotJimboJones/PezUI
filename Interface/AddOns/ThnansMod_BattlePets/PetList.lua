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

-- detect changes to pets

local petListTainted = true;
local function taintPetList()
	petListTainted = true;
end
AceEvent:RegisterEvent("PET_JOURNAL_LIST_UPDATE", taintPetList);

--[[ pet journal filter management ]]--

-- filter settings
local collectedFlag, favoritesFlag, notCollectedFlag, searchText, registeredFrames;
local sourceFlags = {};
local typeFlags = {};

local function clearFilters()
	registeredFrames = {GetFramesRegisteredForEvent("PET_JOURNAL_LIST_UPDATE")};
	for key, frame in pairs(registeredFrames) do
		frame:UnregisterEvent("PET_JOURNAL_LIST_UPDATE");
		-- this event will be spammed while we play with the filters... no need for
		-- other frames to update every time. We'll reregister them when we're done.
	end
	collectedFlag = C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_COLLECTED);
	favoritesFlag = C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_FAVORITES);
	notCollectedFlag = C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_NOT_COLLECTED);
	for i = 1, C_PetJournal.GetNumPetSources() do
		sourceFlags[i] = C_PetJournal.IsPetSourceFiltered(i);
	end
	for i = 1, C_PetJournal.GetNumPetTypes() do
		typeFlags[i] = C_PetJournal.IsPetTypeFiltered(i);
	end
	searchText = nil;
	if PetJournal then
		searchText = PetJournal.searchBox:GetText();
	end
	
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, false);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, true);
	C_PetJournal.AddAllPetSourcesFilter();
	C_PetJournal.AddAllPetTypesFilter();
	C_PetJournal.ClearSearchFilter();
end

local function resetFilters()
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, not collectedFlag);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, not favoritesFlag);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, not notCollectedFlag);
	for i = 1, C_PetJournal.GetNumPetSources() do
		C_PetJournal.SetPetSourceFilter(i, not sourceFlags[i]);
	end
	for i = 1, C_PetJournal.GetNumPetTypes() do
		C_PetJournal.SetPetTypeFilter(i, not typeFlags[i]);
	end
	if searchText and (searchText ~= SEARCH) then
		C_PetJournal.SetSearchFilter(searchText);
	end
	for key, frame in pairs(registeredFrames) do
		frame:RegisterEvent("PET_JOURNAL_LIST_UPDATE");
		-- Hey look! All fixed!
	end
end

--[[ pet list ]]--

local petList = {};

clearFilters();

for i = 1, C_PetJournal.GetNumPets() do
	local _, speciesID, _, _, _, _, _, name, _, _, _, _, _, _, canBattle = C_PetJournal.GetPetInfoByIndex(i);
	petList[name] = {};
	petList[name].canBattle = canBattle;
	petList[name].bestZones = addon.staticData.bestZones[speciesID];
end

resetFilters();

local function updatePetList()
	clearFilters();
	
	-- clear old data from list
	for name, data in pairs(petList) do
		data.ownedCount = 0;
	end
	
	-- search all pets for rarities
	for i = 1, C_PetJournal.GetNumPets() do
		local petID, speciesID, isOwned, _, level, _, _, name = C_PetJournal.GetPetInfoByIndex(i);
		if isOwned then
			local speciesData = petList[name];
			local _, health, power, speed, rarity = C_PetJournal.GetPetStats(petID);
			local j = speciesData.ownedCount + 1;
			speciesData.ownedCount = j;
			speciesData[j] = speciesData[j] or {};
			speciesData[j].level = level;
			speciesData[j].rarity = rarity;
			if speciesData.canBattle then
				speciesData[j].breeds = addon:breedsForPet(speciesID, level, rarity, health, power, speed, speciesData[j].breeds);
			end
			while j > 1 do
				if speciesData[j].rarity > speciesData[j-1].rarity or (speciesData[j].rarity == speciesData[j-1].rarity and speciesData[j].level > speciesData[j-1].level) then
					speciesData[j], speciesData[j-1] = speciesData[j-1], speciesData[j];
				end
				j = j - 1;
			end
		end
	end
	
	resetFilters();
	
	petListTainted = false;
end

--[[ generate tooltip lines ]]--

local tooltipLines = {};
local extraLines = {};
for rarity = 1, 4 do
	local rarityColor = ITEM_QUALITY_COLORS[rarity - 1].hex;
	local rarityName = _G["BATTLE_PET_BREED_QUALITY"..rarity];
	tooltipLines[rarity] = rarityColor..(L.caught:format(rarityName)).."|r";
	extraLines[rarity] = rarityColor..(L.alsoCollected:format(rarityName)).."|r";
end
local notCaughtLine = ITEM_QUALITY_COLORS[5].hex..L.notCollected.."|r";

local retTbl = {};
function addon:tooltipLineForPet(name, includeLevel, includeBreed)
	if petListTainted then
		updatePetList();
	end
	
	retTbl[1], retTbl[2], retTbl[3] = nil, nil, nil;
	
	local data = petList[name];
	if not data then
		retTbl[1] = "";
		return retTbl;
	end
	
	if data.ownedCount >= 1 then
		retTbl[1] = tooltipLines[data[1].rarity];
		if includeBreed then
			retTbl[1] = retTbl[1].." |cFFFFFFFF"..addon:textForBreeds(data[1].breeds).."|r";
		end
		if includeLevel then
			retTbl[1] = retTbl[1].." |cFFFFFFFF"..L.caughtLevel:format(data[1].level).."|r";
		end
	end
	
	if addon.db.profile.showAllPets then
		local i = 2;
		while i <= data.ownedCount do
			retTbl[i] = extraLines[data[i].rarity];
			if includeBreed then
				retTbl[i] = retTbl[i].." |cFFFFFFFF"..addon:textForBreeds(data[i].breeds).."|r";
			end
			if includeLevel then
				retTbl[i] = retTbl[i].." |cFFFFFFFF"..L.caughtLevel:format(data[i].level).."|r";
			end
			i = i + 1;
		end
	end
	
	retTbl[1] = retTbl[1] or notCaughtLine;
	
	return retTbl;
end

function addon:zoneLineForPet(name)
	local data = petList[name] and petList[name].bestZones;
	SetMapToCurrentZone();
	local curZone = GetCurrentMapAreaID();
	local inBest = (data == curZone);
	if type(data) == "table" then
		for i = 1, #data do
			if data[i] == curZone then
				inBest = true;
			end
		end
	end
	local line = "|cFF00FFFF"..L.inBestZoneLabel.."|r";
	if data and not inBest then
		line = "|cFF00FFFF"..L.highestZoneLabel.."|r";
		if type(data) == "number" then
			line = line..GetMapNameByID(data);
		else
			line = line..GetMapNameByID(data[1]);
			for i = 2, #data do
				line = line..L.highestZoneSeparator..GetMapNameByID(data[i]);
			end
		end
	end
	return line;
end

function addon:dataForPet(name)
	return petList[name];
end
