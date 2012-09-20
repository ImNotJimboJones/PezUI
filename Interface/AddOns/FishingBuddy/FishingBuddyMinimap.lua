-- Minimap Button Handling

FishingBuddy.Minimap = {};

local FBMINIMAP = "FBMinimap";
local icon = LibStub("LibDBIcon-1.0");
local broker = LibStub:GetLibrary("LibDataBroker-1.1")

local GSB = FishingBuddy.GetSettingBool;

local function Minimap_OnClick(self, button, down)
	if ( button == "RightButton" ) then
		ToggleFishingBuddyFrame("FishingOptionsFrame");
	elseif ( FishingBuddy.IsSwitchClick("MinimapClickToSwitch") ) then
		FishingBuddy.Command(FBConstants.SWITCH);
	else
		ToggleFishingBuddyFrame("FishingLocationsFrame");
	end
end

local function Minimap_MoveButton()
	local position = FishingBuddy.GetSetting("MinimapButtonPosition");
	local hide = not GSB("MinimapButtonVisible");
	local data = { minimapPos = position, hide = hide };
	icon:Refresh(FBMINIMAP, data);
end

local MinimapOptions = {
	["MinimapButtonVisible"] = {
		["text"] = FBConstants.CONFIG_MINIMAPBUTTON_ONOFF,
		["tooltip"] = FBConstants.CONFIG_MINIMAPBUTTON_INFO,
		["v"] = 1,
		["default"] = 1, },
	["MinimapClickToSwitch"] = {
		["text"] = FBConstants.CLICKTOSWITCH_ONOFF,
		["tooltip"] = FBConstants.CLICKTOSWITCH_INFO,
		["v"] = 1,
		["default"] = 0,
		["deps"] = { ["MinimapButtonVisible"] = "d", },
	},
};

local MinimapEvents = {};
MinimapEvents[FBConstants.OPT_UPDATE_EVT] = function()
	if (icon:IsRegistered(FBMINIMAP)) then
		if (GSB("MinimapButtonVisible")) then
			icon:Show(FBMINIMAP);
		else
			icon:Hide(FBMINIMAP);
		end
	end
end

MinimapEvents["VARIABLES_LOADED"] = function()
	local _, info;
	
	local hide = not GSB("MinimapButtonVisible");
	FishingBuddy_Player["MinimapData"] = FishingBuddy_Player["MinimapData"] or { hide=hide };

	if ( not icon:IsRegistered(FBMINIMAP)) then
		local data = {
				icon = "Interface\\Icons\\INV_FishingPole_01",
				OnClick = Minimap_OnClick,
			};
		
		icon:Register(FBMINIMAP, data, FishingBuddy_Player["MinimapData"]);
	end
end

FishingBuddy.OptionsFrame.HandleOptions(GENERAL, nil, MinimapOptions);
FishingBuddy.API.RegisterHandlers(MinimapEvents);
