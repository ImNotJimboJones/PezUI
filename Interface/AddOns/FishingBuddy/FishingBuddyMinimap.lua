-- Minimap Button Handling

FishingBuddy.Minimap = {};

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

local MinimapOptions = {
	["MinimapButtonVisible"] = {
		["text"] = FBConstants.CONFIG_MINIMAPBUTTON_ONOFF,
		["tooltip"] = FBConstants.CONFIG_MINIMAPBUTTON_INFO,
		["v"] = 1,
		["default"] = 1,
		["setup"] = function(button)
						local info = icon:GetMinimapButton(FBConstants.NAME);
						FishingBuddy.SetSetting("MinimapButtonVisible", info.hide and 1 or 0);
					end,
	},
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
	if (icon:IsRegistered(FBConstants.NAME)) then
		if (GSB("MinimapButtonVisible")) then
			icon:Show(FBConstants.NAME);
		else
			icon:Hide(FBConstants.NAME);
		end
	end
end

MinimapEvents["VARIABLES_LOADED"] = function()
	local _, info;
	
	local hide = not GSB("MinimapButtonVisible");
	FishingBuddy_Player["MinimapData"] = FishingBuddy_Player["MinimapData"] or { hide=hide };

	if ( not icon:IsRegistered(FBConstants.NAME) ) then
		local data = {
				icon = "Interface\\Icons\\Trade_Fishing",
				OnClick = Minimap_OnClick,
			};
		
		icon:Register(FBConstants.NAME, data, FishingBuddy_Player["MinimapData"]);
	end
end

FishingBuddy.OptionsFrame.HandleOptions(GENERAL, nil, MinimapOptions);
FishingBuddy.API.RegisterHandlers(MinimapEvents);
