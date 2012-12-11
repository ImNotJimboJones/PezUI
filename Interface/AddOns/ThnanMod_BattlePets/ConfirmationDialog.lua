local _, WPT = ...;
local L = WPT.L;
local config = WPT.config;

local releasePetDialog;

local function updateDialogs()
	if config.colorReleaseDialog then
		local _, _, level = C_PetJournal.GetPetInfoByPetID(PetJournal.menuPetID);
		local _, _, _, _, rarity = C_PetJournal.GetPetStats(PetJournal.menuPetID);
		local rarityColor = ITEM_QUALITY_COLORS[rarity - 1].hex;
		local rarityName = _G["BATTLE_PET_BREED_QUALITY"..rarity];
		local nameString = rarityColor..L.confirmationDialogPetInfoString:format("%s", rarityName, level);
		releasePetDialog.text = "\n\n"..PET_RELEASE_LABEL:format(nameString).."\n\n";
	end
end

function WPT:resetReleaseDialog()
	if releasePetDialog then
		releasePetDialog.text = "\n\n"..PET_RELEASE_LABEL.."\n\n";
	end
end

if PetJournal then
	hooksecurefunc(_G, "PetJournal_ShowPetDropdown", updateDialogs);
	releasePetDialog = StaticPopupDialogs["BATTLE_PET_RELEASE"];
else
	local frame = CreateFrame("Frame");
	frame:SetScript("OnEvent", function(self, evt, msg)
		if msg == "Blizzard_PetJournal" then
			hooksecurefunc(_G, "PetJournal_ShowPetDropdown", updateDialogs);
			releasePetDialog = StaticPopupDialogs["BATTLE_PET_RELEASE"];
			frame:UnregisterEvent("ADDON_LOADED");
			frame:SetScript("OnEvent", nil);
			frame = nil;
		end
	end);
	frame:RegisterEvent("ADDON_LOADED");
end