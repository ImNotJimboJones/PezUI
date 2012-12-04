local tocName, TMPrivate = ...;
local L = TMPrivate.L;

local playerName = GetUnitName("Player", false);
local realmName = GetRealmName();
local currentDataVersion = 1;
local savedVarsFrame = CreateFrame("Frame");

local Event_loaded = "ADDON_LOADED";
local Event_enterWorld = "PLAYER_LOGIN";
local Event_logout = "PLAYER_LOGOUT";

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
end
local function enteringWorld(self, event)
	for pluginName, plugin in pairs(TMPrivate.plugins) do
		local globalRef = ThnanMod_Saved.global[pluginName];
		local realmRef = ThnanMod_Saved[realmName].realm[pluginName];
		local charRef = ThnanMod_Saved[realmName][playerName][pluginName];
		plugin:loadSavedVars(globalRef, realmRef, charRef);
	end
	savedVarsFrame:UnregisterEvent(Event_enterWorld);
	savedVarsFrame:SetScript("OnEvent", playerLogout);
	savedVarsFrame:RegisterEvent(Event_logout);
	ThnanMod:output(L.loaded:format(L.slashCommand));
end
local function addonLoaded(self, event, addonName)
	if addonName == tocName then
		checkData();
		savedVarsFrame:UnregisterEvent(Event_loaded);
		savedVarsFrame:SetScript("OnEvent", enteringWorld);
		savedVarsFrame:RegisterEvent(Event_enterWorld);
	end
end

savedVarsFrame:SetScript("OnEvent", addonLoaded);
savedVarsFrame:RegisterEvent(Event_loaded);