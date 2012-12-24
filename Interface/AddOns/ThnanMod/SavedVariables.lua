local tocName, TMPrivate = ...;
local L = TMPrivate.L;

local playerName = GetUnitName("Player", false);
local realmName = GetRealmName();
local currentDataVersion = 1;
local savedVarsFrame = CreateFrame("Frame");

-- Core Config values

TMPrivate.configValues = {};
local configValues = TMPrivate.configValues;

configValues.dailyResetTime = 11;

-- variable storage/loading functions

local function checkData()
	if (type(ThnanMod_Saved) ~= "table") then
		ThnanMod_Saved = {};
		ThnanMod_Saved.dataVersion = currentDataVersion;
		ThnanMod_Saved.global = {};
	end

	-- if before version 1, update to version 1
	if (ThnanMod_Saved.dataVersion == nil) then
		ThnanMod_Saved.dataVersion = 1;
		ThnanMod_Saved.global = {};
		ThnanMod_Saved.global.BattlePets = {};
		ThnanMod_Saved.global.BattlePets.enabled = ThnanMod_Saved.WildPetTooltip.enabled;
		ThnanMod_Saved.WildPetTooltip = nil;
	end -- updated to version 1
	
	-- updated to current version

	-- if new server, create server
	if (type(ThnanMod_Saved[realmName]) ~= "table") then
		ThnanMod_Saved[realmName] = {};
		ThnanMod_Saved[realmName].realm = {};
	end
	-- if new character, create character
	if (type(ThnanMod_Saved[realmName][playerName]) ~= "table") then
		ThnanMod_Saved[realmName][playerName] = {};
	end
end
local function playerLogout(self, event)
	for pluginName, plugin in pairs(TMPrivate.plugins) do
		local global, realm, character = plugin:storeSavedVars();
		ThnanMod_Saved.global[pluginName] = global;
		ThnanMod_Saved[realmName].realm[pluginName] = realm;
		ThnanMod_Saved[realmName][playerName][pluginName] = character;
	end
	-- framework values
	ThnanMod_Saved[realmName].realm.Core = {};
	ThnanMod_Saved[realmName].realm.Core.dailyResetTime = configValues.dailyResetTime;
end
local function enteringWorld(self, event)
	for pluginName, plugin in pairs(TMPrivate.plugins) do
		local globalRef = ThnanMod_Saved.global[pluginName];
		local realmRef = ThnanMod_Saved[realmName].realm[pluginName];
		local charRef = ThnanMod_Saved[realmName][playerName][pluginName];
		plugin:loadSavedVars(globalRef, realmRef, charRef);
	end
	
	if type(ThnanMod_Saved[realmName].realm.Core) == "table" then
		configValues.dailyResetTime = ThnanMod_Saved[realmName].realm.Core.dailyResetTime;
	end
	
	savedVarsFrame:UnregisterEvent("PLAYER_LOGIN");
	savedVarsFrame:SetScript("OnEvent", playerLogout);
	savedVarsFrame:RegisterEvent("PLAYER_LOGOUT");
	ThnanMod:output(L.loaded:format(L.slashCommand));
end
local function addonLoaded(self, event, addonName)
	if addonName == tocName then
		checkData();
		savedVarsFrame:UnregisterEvent("ADDON_LOADED");
		savedVarsFrame:SetScript("OnEvent", enteringWorld);
		savedVarsFrame:RegisterEvent("PLAYER_LOGIN");
	end
end

savedVarsFrame:SetScript("OnEvent", addonLoaded);
savedVarsFrame:RegisterEvent("ADDON_LOADED");