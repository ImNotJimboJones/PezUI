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

local bestZones = addon.staticData.bestZones;
local function update(self)
	local _, _, _, _, tooltip = C_PetJournal.GetPetInfoBySpeciesID(PetJournalPetCard.speciesID);
	local zones = bestZones[PetJournalPetCard.speciesID];
	if tooltip and zones and addon.db.profile.showHighestZones then
		if tooltip:sub(-2) ~= "|n" then
			tooltip = tooltip.."|n";
		end
		tooltip = tooltip.."|n|cFF00FFFF"..L.highestZoneLabel.."|r";
		if type(zones) == "number" then
			tooltip = tooltip..GetMapNameByID(zones);
		else
			tooltip = tooltip..GetMapNameByID(zones[1]);
			for i = 2, #zones do
				tooltip = tooltip..L.highestZoneSeparator..GetMapNameByID(zones[i]);
			end
		end
	end
	self.PetInfo.sourceText = tooltip;
end
hooksecurefunc(_G, "PetJournal_UpdatePetCard", update);