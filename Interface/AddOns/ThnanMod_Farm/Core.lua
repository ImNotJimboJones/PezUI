--[[ Plugin Variables ]]--

local _, FRM = ...;
FRM.pluginName = "Farm";
FRM.slashCommandTag = FRM.L.slashCmdTag;
FRM.config = {};
FRM.data = {};
local config = FRM.config;
local data = FRM.data;

--[[ Default Config Values ]]--

config.showAutomatically = true;
config.hideInCombat = true;
config.hideWhenEmpty = true;
config.hideInVehicle = true;
config.hideWhenMounted = true;
config.dropOnRightClick = true;
config.dropOnLeavingFarm = false;

--[[ Saved Variable Handlers ]]--

local currentDataVersion = 2;

--[[ version nil
(C) global.hideInCombat
(C) character.showAutomatically
]]--
--[[ version 1 changes
(C) global.hideWhenEmpty
(C) global.hideInVehicle
(C) global.dropOnRightClick
(D) realm.today
(D) realm.todayForecast
(D) realm.yesterday
(D) realm.yesterdayForecast
(C) character.dropOnLeavingFarm
]]--
--[[ version 2 changes
(C) global.hideWhenMounted
]]--

function FRM:loadSavedVars(global, realm, character)
	if (type(global) == "table") then
		config.hideInCombat = global.hideInCombat;
		if global.dataVersion >= 1 then
			config.hideWhenEmpty = global.hideWhenEmpty;
			config.hideInVehicle = global.hideInVehicle;
			config.dropOnRightClick = global.dropOnRightClick;
		end
		if global.dataVersion >= 2 then
			config.hideWhenMounted = global.hideWhenMounted;
		end
	end
	if (type(realm) == "table") then
		data.today = realm.today;
		data.todayForecast = realm.todayForecast;
		data.yesterday = realm.yesterday;
		data.yesterdayForecast = realm.yesterdayForecast;
	end
	if (type(character) == "table") then
		config.showAutomatically = character.showAutomatically;
		if character.dataVersion >= 1 then
			config.dropOnLeavingFarm = character.dropOnLeavingFarm;
		end
	end
end

function FRM:storeSavedVars()
	local global = {};
	global.dataVersion = currentDataVersion;
	global.hideInCombat = config.hideInCombat;
	global.hideWhenEmpty = config.hideWhenEmpty;
	global.hideInVehicle = config.hideInVehicle;
	global.hideWhenMounted = config.hideWhenMounted;
	global.dropOnRightClick = config.dropOnRightClick;
	local realm = {};
	realm.today = data.today;
	realm.todayForecast = data.todayForecast;
	realm.yesterday = data.yesterday;
	realm.yesterdayForecast = data.yesterdayForecast;
	local character = {};
	character.dataVersion = currentDataVersion;
	character.showAutomatically = config.showAutomatically;
	character.dropOnLeavingFarm = config.dropOnLeavingFarm;
	
	return global, realm, character;
end

--[[ Register With Framework ]]--

ThnanMod:registerPlugin(FRM);

--[[ Slash Command Handler ]]--

function FRM:slashCommandCalled(msg)
	if msg:lower() == FRM.L.slashCmdShow:lower() then
		FRM:showFarmFrame();
	else
		InterfaceOptionsFrame_OpenToCategory(FRM.configPanel);
	end
end