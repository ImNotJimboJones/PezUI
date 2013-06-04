--[[--------------------------------------------------------------------
	Thnan's Mod - Battle Pets
	Copyright (c) 2013 Thnan

	This addon is freely available, and its source code freely viewable,
	but it is not "open source software" and you may not distribute it,
	with or without modifications, without permission from its author.

	See the included License file for more information!
----------------------------------------------------------------------]]
local addonName, addon = ...;

local L = LibStub("AceLocale-3.0"):GetLocale(addonName);

local releasePetDialog = StaticPopupDialogs["BATTLE_PET_RELEASE"];

local function updateDialogs(level, value, dropDownFrame, anchorName, xOffset, yOffset)
	if dropDownFrame == PetJournal.petOptionsMenu then
		if addon.db.profile.colorReleaseText then
			local speciesID, _, level = C_PetJournal.GetPetInfoByPetID(PetJournal.menuPetID);
			local _, health, power, speed, rarity = C_PetJournal.GetPetStats(PetJournal.menuPetID);
			local rarityColor = ITEM_QUALITY_COLORS[rarity - 1].hex;
			local rarityName = _G["BATTLE_PET_BREED_QUALITY"..rarity];
			local breedText = addon:textForBreeds(addon:breedsForPet(speciesID, level, rarity, health, power, speed));
			local nameString = L.confirmationDialogPetInfo:format("%s", rarityColor, rarityName, breedText, level);
			releasePetDialog.text = "\n\n"..PET_RELEASE_LABEL:format(nameString).."\n\n";
		else
			releasePetDialog.text = "\n\n"..PET_RELEASE_LABEL.."\n\n";
		end
	end
end
hooksecurefunc(_G, "ToggleDropDownMenu", updateDialogs);
