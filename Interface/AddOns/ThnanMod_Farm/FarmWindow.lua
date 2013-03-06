local _, FRM = ...;
local config = FRM.config;
local L = FRM.L;

--[[ variable forward declarations ]]--

-- right click planting

local rightClickButtons = {};
local rightClickSeed = nil;
local setRightClickSeed = nil;

--[[ NPC name parsing ]]--

local npcTooltip = CreateFrame("GameTooltip", "FRMnpcTooltip");
local tooltipText = npcTooltip:CreateFontString();
npcTooltip:AddFontStrings(tooltipText, npcTooltip:CreateFontString());

local function nameForNPC(npcID)
	npcTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	npcTooltip:SetHyperlink(("unit:0xF53%05X00000000"):format(npcID));
	return tooltipText:GetText();
end

--[[ create window ]]--

local farmWindow = CreateFrame("Frame", "farmWindow", UIParent, "BasicFrameTemplate");
farmWindow:SetPoint("CENTER");
farmWindow:SetWidth((7*36) + (8*5) + 2);
farmWindow:SetHeight((6*36) + (7*5) + 23);
farmWindow:SetToplevel(true);
farmWindow:SetMovable(true);
farmWindow:EnableMouse(true);
farmWindow:RegisterForDrag("LeftButton");
farmWindow:SetScript("OnDragStart", farmWindow.StartMoving);
farmWindow:SetScript("OnDragStop", farmWindow.StopMovingOrSizing);
farmWindow:SetScript("OnHide", farmWindow.StopMovingOrSizing);

local farmWindowLabel = farmWindow:CreateFontString("farmWindowLabel", "ARTWORK", "GameFontNormal");
farmWindowLabel:SetText(L.farmWindowLabelText);
farmWindowLabel:SetPoint("TOP", 0, -5);
farmWindow:Hide();

--[[ button creation ]]--

-- functions

local function farmButton_OnEnter(self)
	GameTooltip:SetOwner(farmWindow);
	if self.itemID2 and IsShiftKeyDown() then
		GameTooltip:SetItemByID(self.itemID2);
	elseif self.itemID then
		GameTooltip:SetItemByID(self.itemID);
	else
		GameTooltip:AddLine(L.portalButtonNoFactionText, 0, 1, 1, true);
	end
	GameTooltip:SetAnchorType("ANCHOR_TOPLEFT");
	GameTooltip:Show();
end
local function farmButton_OnLeave(self)
	GameTooltip:Hide();
end
local function farmButton_OnEvent(self, event)
	if event == "PLAYER_REGEN_ENABLED" or event == "NEUTRAL_FACTION_SELECT_RESULT" then
		self:UnregisterEvent(event);
		self:setAttributeValue();
	elseif event == "MODIFIER_STATE_CHANGED" then
		self:updateAppearance();
		if self:IsMouseOver() then
			farmButton_OnEnter(self);
		end
	elseif event == "BAG_UPDATE" or event == "GET_ITEM_INFO_RECEIVED" then
		self:updateAppearance();
	end
end
local function farmButton_OnClick(self)
	self:SetChecked(self.checkedState);
end

local tilledSoilName;
local tilledSoilCallbackButtons = {};
do
	local tilledSoilID = 58563;
	tilledSoilName = nameForNPC(tilledSoilID);
	if not tilledSoilName then
		local callbackFrame = CreateFrame("Frame");
		if GetSubZoneText() == L.sunsongRanchName then
			callbackFrame:Show();
		else
			callbackFrame:Hide();
		end
		callbackFrame:SetScript("OnEvent", function()
			if GetSubZoneText() == L.sunsongRanchName then
				callbackFrame:Show();
			else
				callbackFrame:Hide();
			end
		end);
		callbackFrame:RegisterEvent("ZONE_CHANGED");
		callbackFrame:SetScript("OnUpdate", function()
			tilledSoilName = nameForNPC(tilledSoilID);
			if tilledSoilName then
				for k, button in pairs(tilledSoilCallbackButtons) do
					button:setAttributeValue();
				end
				tilledSoilCallbackButtons = nil;
				callbackFrame:UnregisterEvent("ZONE_CHANGED");
				callbackFrame:SetScript("OnEvent", nil);
				callbackFrame:SetScript("OnUpdate", nil);
				callbackFrame:Hide();
			end
		end);
	end
end

local function seedButton_setMacroText(self)
	if not tilledSoilName then
		tilledSoilCallbackButtons[#tilledSoilCallbackButtons + 1] = self;
		return;
	end
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED");
		return;
	end
	
	local text = "/targetexact "..tilledSoilName.."\n/use ";
	if self.itemID2 then
		text = text.."[modifier:shift] item:"..self.itemID2.."; [nomodifier] item:"..self.itemID;
	else
		text = text.."item:"..self.itemID;
	end
	text = text.."\n/targetlasttarget";
	self:SetAttribute("macrotext", text);
end
local function seedButton_setRightClickSeed(self)
	if self.itemID then
		setRightClickSeed(self.itemID);
	end
end
local function seedButton_updateAppearance(self)
	if not self.itemTexture then
		local _, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(self.itemID);
		self.itemTexture = itemTexture;
	end
	if self.itemID2 and not self.itemTexture2 then
		local _, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(self.itemID2);
		self.itemTexture2 = itemTexture;
	end
	if not self.itemTexture or (self.itemID2 and not self.itemTexture2) then
		self:RegisterEvent("GET_ITEM_INFO_RECEIVED");
	else
		self:UnregisterEvent("GET_ITEM_INFO_RECEIVED");
	end
	
	local count = GetItemCount(self.itemID, false, false);
	if self.itemID2 and IsShiftKeyDown() then
		self.icon:SetTexture(self.itemTexture2);
		count = GetItemCount(self.itemID2, false, true);
	else
		self.icon:SetTexture(self.itemTexture);
	end
	
	local countText = _G[self:GetName().."Count"];
	if (count > 99) then
		countText:SetText("*");
	else
		countText:SetText(count);
	end
	if (count > 0) then
		self.icon:SetVertexColor(1.0, 1.0, 1.0);
	else
		self.icon:SetVertexColor(0.4, 0.4, 0.4);
	end
	
	if self.checkedState then
		self.FlyoutBorder:Show();
		self.FlyoutBorderShadow:Show();
	else
		self.FlyoutBorder:Hide();
		self.FlyoutBorderShadow:Hide();
	end
	self:SetChecked(self.checkedState);
end

local function toolButton_dropTool(self)
	if config.dropOnRightClick then
		for bag = 0, NUM_BAG_SLOTS do
			for slot = 1, GetContainerNumSlots(bag) do
				if GetContainerItemID(bag, slot) == self.itemID then
					PickupContainerItem(bag, slot);
					DeleteCursorItem();
					return;
				end
			end
		end
	end
end
local function toolButton_updateAppearance(self)
	if not self.itemTexture then
		local _, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(self.itemID);
		self.itemTexture = itemTexture;
		if not self.itemTexture then
			self:RegisterEvent("GET_ITEM_INFO_RECEIVED");
		else
			self:UnregisterEvent("GET_ITEM_INFO_RECEIVED");
			self.icon:SetTexture(self.itemTexture);
		end
	end

	local count = GetItemCount(self.itemID, false, false);
	if (count > 0) then
		self.icon:SetVertexColor(1.0, 1.0, 1.0);
	else
		self.icon:SetVertexColor(0.4, 0.4, 0.4);
	end
end

local noInfoTexture = "Interface\\BUTTONS\\UI-GroupLoot-Pass-Down";

local function portalButton_setItem(self)
	local faction = UnitFactionGroup("player");
	if faction == "Alliance" then
		self.itemID = self.allianceID;
	elseif faction == "Horde" then
		self.itemID = self.hordeID;
	end
	
	if not self.itemID then
		self:RegisterEvent("NEUTRAL_FACTION_SELECT_RESULT");
		return;
	end
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED");
		return;
	end
	
	self:SetAttribute("item", "item:"..self.itemID);
end
local function portalButton_updateAppearance(self)
	if self.itemID then
		seedButton_updateAppearance(self);
	else
		self.icon:SetTexture(noInfoTexture);
		self.icon:SetVertexColor(1.0, 1.0, 1.0);
	end
end

local buttonCount = 0;
local function createFarmButton(itemID, itemID2, buttonType)
	local button = CreateFrame("CheckButton", "FRMButton"..buttonCount, farmWindow, "ActionButtonTemplate,SecureActionButtonTemplate");
	buttonCount = buttonCount + 1;
	
	button:SetScript("OnEnter", farmButton_OnEnter);
	button:SetScript("OnLeave", farmButton_OnLeave);
	button:SetScript("OnEvent", farmButton_OnEvent);
	button:HookScript("OnClick", farmButton_OnClick);
	
	button.checkedState = false;
	
	button:RegisterEvent("BAG_UPDATE");
	
	if buttonType == "seed" then
		button.itemID = itemID
		if itemID2 then
			button:RegisterEvent("MODIFIER_STATE_CHANGED");
			button.itemID2 = itemID2;
		end
		button:RegisterForClicks("LeftButtonDown", "RightButtonDown");
		button:SetAttribute("*type1", "macro");
		button:SetAttribute("*type2", "setRightClickSeed");
		button.setAttributeValue = seedButton_setMacroText;
		seedButton_setMacroText(button);
		button.setRightClickSeed = seedButton_setRightClickSeed;
		rightClickButtons[#rightClickButtons + 1] = button;
		button.updateAppearance = seedButton_updateAppearance;
	elseif buttonType == "tool" then
		button.itemID = itemID;
		button:RegisterForClicks("LeftButtonDown", "RightButtonDown");
		button:SetAttribute("*type1", "item");
		button:SetAttribute("*type2", "dropTool");
		button:SetAttribute("item", "item:"..itemID);
		button.dropTool = toolButton_dropTool;
		button.updateAppearance = toolButton_updateAppearance;
	elseif buttonType == "portal" then
		button.allianceID = itemID;
		button.hordeID= itemID2;
		button:SetAttribute("type", "item");
		button.setAttributeValue = portalButton_setItem;
		portalButton_setItem(button);
		button.updateAppearance = portalButton_updateAppearance;
	end
	
	button:updateAppearance();
	
	return button;
end

-- create seed buttons

local greenCabbageButton = createFarmButton(79102, 95434, "seed");
local scallionButton = createFarmButton(80591, 95441, "seed");
local redBlossomLeekButton = createFarmButton(80593, 95440, "seed");
local whiteTurnipButton = createFarmButton(80595, 95443, "seed");
local witchberryButton = createFarmButton(89326, 95444, "seed");
local juicycrunchCarrotButton = createFarmButton(80590, 95436, "seed");
local moguPumpkinButton = createFarmButton(80592, 95438, "seed");
local pinkTurnipButton = createFarmButton(80594, 95439, "seed");
local jadeSquashButton = createFarmButton(89328, 95437, "seed");
local stripedMelonButton = createFarmButton(89329, 95442, "seed");

local magebulbButton = createFarmButton(85217, 95452, "seed");
local snakerootButton = createFarmButton(85215, 95448, "seed");
local songbellButton = createFarmButton(89233, 95446, "seed");
local enigmaButton = createFarmButton(85216, 95450, "seed");
local raptorleafButton = createFarmButton(89202, 95458, "seed");
local windshearCactusButton = createFarmButton(89197, 95456, "seed");

local autumnBlossomButton = createFarmButton(85267, nil, "seed");
local springBlossomButton = createFarmButton(85268, nil, "seed");
local winterBlossomButton = createFarmButton(85269, nil, "seed");

local ominousSeedButton = createFarmButton(85219, nil, "seed");
local unstableShardButton = createFarmButton(91806, nil, "seed");

-- create tool buttons

local wateringCanButton = createFarmButton(79104, nil, "tool");
local bugSprayerButton = createFarmButton(80513, nil, "tool");
local shovelButton = createFarmButton(89880, nil, "tool");
local plowButton = createFarmButton(89815, nil, "tool");

-- create portal buttons

local stormgrimmarButton = createFarmButton(91860, 91850, "portal");
local ironbluffButton = createFarmButton(91864, 91861, "portal");
local darnacityButton = createFarmButton(91865, 91862, "portal");
local exomoonButton = createFarmButton(91866, 91863, "portal");

--[[ button placement ]]--

-- define row and column values for TOPLEFT corners

local col1, col2, col3, col4, col5, col6, col7 = 5, 46, 87, 128, 169, 210, 251;
local halfCol = 20;
local row1, row2, row3, row4, row5, row6 = -28, -69, -110, -151, -192, -233;

-- place seed buttons

greenCabbageButton:SetPoint("TOPLEFT", col1, row1);
scallionButton:SetPoint("TOPLEFT", col1, row2);
redBlossomLeekButton:SetPoint("TOPLEFT", col1, row3);
whiteTurnipButton:SetPoint("TOPLEFT", col1, row4);
witchberryButton:SetPoint("TOPLEFT", col1, row5);
unstableShardButton:SetPoint("TOPLEFT", col1, row6);

juicycrunchCarrotButton:SetPoint("TOPLEFT", col2, row1);
moguPumpkinButton:SetPoint("TOPLEFT", col2, row2);
pinkTurnipButton:SetPoint("TOPLEFT", col2, row3);
jadeSquashButton:SetPoint("TOPLEFT", col2, row4);
stripedMelonButton:SetPoint("TOPLEFT", col2, row5);

magebulbButton:SetPoint("TOPLEFT", col6, row1);
snakerootButton:SetPoint("TOPLEFT", col6, row2);
songbellButton:SetPoint("TOPLEFT", col6, row3);
autumnBlossomButton:SetPoint("TOPLEFT", col6 + halfCol, row4);
winterBlossomButton:SetPoint("TOPLEFT", col6, row5);

enigmaButton:SetPoint("TOPLEFT", col7, row1);
raptorleafButton:SetPoint("TOPLEFT", col7, row2);
windshearCactusButton:SetPoint("TOPLEFT", col7, row3);
springBlossomButton:SetPoint("TOPLEFT", col7, row5);
ominousSeedButton:SetPoint("TOPLEFT", col7, row6);

-- place tool buttons

wateringCanButton:SetPoint("TOPLEFT", col3 + halfCol, row1);
bugSprayerButton:SetPoint("TOPLEFT", col4 + halfCol, row1);
shovelButton:SetPoint("TOPLEFT", col3 + halfCol, row2);
plowButton:SetPoint("TOPLEFT", col4 + halfCol, row2);

-- place portal buttons

stormgrimmarButton:SetPoint("TOPLEFT", col2 + halfCol, row6);
ironbluffButton:SetPoint("TOPLEFT", col3 + halfCol, row6);
darnacityButton:SetPoint("TOPLEFT", col4 + halfCol, row6);
exomoonButton:SetPoint("TOPLEFT", col5 + halfCol, row6);

--[[ grow check ]]--

local growCheckIDs = {
	-- Green Cabbage
	60070, -- Alluring
	63157, -- Bursting
	60026, -- Infested
	58565, -- Parched
	60113, -- Plump
	58567, -- Ripe
	60218, -- Runty
	60181, -- Smothered
	60270, -- Tangled
	60029, -- Wiggling
	60207, -- Wild
	-- Scallions
	63159, -- Alluring
	63160, -- Bursting
	63162, -- Infested
	63163, -- Parched
	63164, -- Plump
	63165, -- Ripe
	63166, -- Runty
	63167, -- Smothered
	63168, -- Tangled
	63169, -- Wiggling
	63170, -- Wild
	-- Red Blossom Leek
	63222, -- Alluring
	63223, -- Bursting
	63226, -- Infested
	63227, -- Parched
	63228, -- Plump
	63229, -- Ripe
	63230, -- Runty
	63231, -- Smothered
	63232, -- Tangled
	63233, -- Wiggling
	63234, -- Wild
	-- White Turnip
	63259, -- Alluring
	63260, -- Bursting
	63262, -- Infested
	63263, -- Parched
	63264, -- Plump
	63265, -- Ripe
	63267, -- Runty
	63268, -- Smothered
	63269, -- Tangled
	63270, -- Wiggling
	63271, -- Wild
	-- Witchberries
	66079, -- Alluring
	66080, -- Bursting
	66082, -- Infested
	66083, -- Parched
	66084, -- Plump
	66085, -- Ripe
	66086, -- Runty
	66087, -- Smothered
	66088, -- Tangled
	66089, -- Wiggling
	66090, -- Wild
	-- Juicycrunch Carrot
	63147, -- Alluring
	63158, -- Bursting
	63145, -- Infested
	63144, -- Parched
	63156, -- Plump
	63154, -- Ripe
	63150, -- Runty
	63148, -- Smothered
	63151, -- Tangled
	63146, -- Wiggling
	63149, -- Wild
	-- Mogu Pumpkin
	63178, -- Alluring
	63180, -- Bursting
	63182, -- Infested
	63183, -- Parched
	63184, -- Plump
	63185, -- Ripe
	63186, -- Runty
	63187, -- Smothered
	63188, -- Tangled
	63189, -- Wiggling
	63190, -- Wild
	-- Pink Turnip
	63243, -- Alluring
	63245, -- Bursting
	63247, -- Infested
	63248, -- Parched
	63249, -- Plump
	63250, -- Ripe
	63251, -- Runty
	63252, -- Smothered
	63253, -- Tangled
	63254, -- Wiggling
	63255, -- Wild
	-- Jade Squash
	66107, -- Alluring
	66108, -- Bursting
	66110, -- Infested
	66111, -- Parched
	66112, -- Plump
	66113, -- Ripe
	66114, -- Runty
	66115, -- Smothered
	66116, -- Tangled
	66117, -- Wiggling
	66118, -- Wild
	-- Striped Melon
	66122, -- Alluring
	66123, -- Bursting
	66125, -- Infested
	66127, -- Parched
	66128, -- Plump
	66129, -- Ripe
	66130, -- Runty
	66131, -- Smothered
	66132, -- Tangled
	66133, -- Wiggling
	66134, -- Wild
	-- Magebulb
	65985, -- Alluring
	65987, -- Infested
	65988, -- Parched
	65989, -- Magebulb
	65990, -- Runty
	65991, -- Smothered
	65992, -- Tangled
	65993, -- Wiggling
	65994, -- Wild
	-- Snakeroot
	65964, -- Alluring
	65966, -- Infested
	65967, -- Parched
	65973, -- Snakeroot
	65968, -- Runty
	65969, -- Smothered
	65970, -- Tangled
	65971, -- Wiggling
	65972, -- Wild
	-- Songbell
	66039, -- Alluring
	66041, -- Infested
	66042, -- Parched
	66043, -- Songbell
	66044, -- Runty
	66045, -- Smothered
	66046, -- Tangled
	66047, -- Wiggling
	66048, -- Wild
	-- Enigma
	65913, -- Alluring
	65918, -- Infested
	65919, -- Parched
	65920, -- Runty
	65921, -- Smothered
	65922, -- Tangled
	65924, -- Wiggling
	65925, -- Wild
	-- Enigma Herbs
	65933, -- Green Tea Leaf
	65932, -- Silkweed
	65938, -- Rain Poppy
	65930, -- Fool's Cap
	65931, -- Snow Lily
	65929, -- Golden Lotus
	-- Raptorleaf
	66012, -- Alluring
	66014, -- Infested
	66015, -- Parched
	66016, -- Raptorleaf
	66017, -- Runty
	66018, -- Smothered
	66019, -- Tangled
	66020, -- Wiggling
	66021, -- Wild
	-- Windshear Cactus
	66002, -- Alluring
	66004, -- Infested
	66005, -- Parched
	66006, -- Windshear Cactus
	66007, -- Runty
	66008, -- Smothered
	66009, -- Tangled
	66010, -- Wiggling
	66011, -- Wild
	-- Autumn Blossom
	66175, -- Tree
	-- Spring Blossom
	66192, -- Tree
	-- Winter Blossom
	66173, -- Tree
	-- Terrible Turnip
	66161, -- Turnip
	-- Portal Shard
	67446, -- Unstable
	67486, -- Stable
	-- Soil
	58563, -- Tilled
	58562, -- Untilled
};
local extraGrowCheckButtons = {};
local function getGrowCheckButton(index)
	if not extraGrowCheckButtons[index] then
		extraGrowCheckButtons[index] = CreateFrame("Button", ("FRMGC%02d"):format(index), nil, "SecureActionButtonTemplate");
		extraGrowCheckButtons[index]:SetAttribute("type", "macro");
		extraGrowCheckButtons[index]:Hide();
	end
	
	return extraGrowCheckButtons[index];
end
local function growCheckButton_OnEnter(self)
	GameTooltip:SetOwner(farmWindow);
	GameTooltip:ClearLines();
	GameTooltip:AddLine(L.growCheckTitle, false);
	GameTooltip:AddLine(L.growCheckDescription, 1, 1, 1, true);
	GameTooltip:SetAnchorType("ANCHOR_TOPLEFT");
	GameTooltip:Show();
	if not InCombatLockdown() then
		local macroLines = {};
		for i = 1, #growCheckIDs do
			local name = nameForNPC(growCheckIDs[i]);
			if name then
				macroLines[#macroLines + 1] = "/targetexact "..name.."\n";
			end
		end
		
		local macroText = "";
		local currentButton = self;
		local nextButtonIndex = 1;
		local clickNextLine = "/click FRMGC01";
		
		for i = 1, #macroLines do
			if (macroText:len() + macroLines[i]:len() + clickNextLine:len()) <= 1023 then
				macroText = macroText..macroLines[i];
			else
				macroText = macroText..clickNextLine;
				currentButton:SetAttribute("macrotext", macroText);
				macroText = macroLines[i];
				currentButton = getGrowCheckButton(nextButtonIndex);
				nextButtonIndex = nextButtonIndex + 1;
				clickNextLine = ("/click FRMGC%02d"):format(nextButtonIndex);
			end
		end
		
		currentButton:SetAttribute("macrotext", macroText);
	end
end

local growCheckButton = CreateFrame("Button", "growCheckFRMButton", farmWindow, "ActionButtonTemplate,SecureActionButtonTemplate");
growCheckButton:SetScript("OnEnter", growCheckButton_OnEnter);
growCheckButton:SetScript("OnLeave", farmButton_OnLeave);
growCheckButton:SetAttribute("type", "macro");
growCheckButton:SetPoint("TOPLEFT", col3 + halfCol, row3);
growCheckButton.icon:SetTexture("Interface\\ICONS\\Ability_Druid_TreeofLife");

--[[ showing and hiding ]]--

-- automatic show/hide checking

local function onFarm()
	return ((GetSubZoneText() == L.sunsongRanchName) and config.showAutomatically);
end
local inventoryIDs = {
	-- seeds
	79102, -- green cabbage
	80591, -- scallion
	80593, -- red blossom leek
	80595, -- white turnip
	89326, -- witchberry
	80590, -- juicycrunch carrot
	80592, -- mogu pumpkin
	80594, -- pink turnip
	89328, -- jade squash
	89329, -- striped melon
	85217, -- magebulb
	85215, -- snakeroot
	89233, -- songbell
	85216, -- enigma
	89202, -- raptorleaf
	89197, -- windshear cactus
	85267, -- autumn blossom
	85268, -- spring blossom
	85269, -- winter blossom
	85219, -- omminous seed
	91806, -- unstable portal shard
	-- bags
	95434, -- green cabbage
	95441, -- scallion
	95440, -- red blossom leek
	95443, -- white turnip
	95444, -- witchberry
	95436, -- juicycrunch carrot
	95438, -- mogu pumpkin
	95439, -- pink turnip
	95437, -- jade squash
	95442, -- striped melon
	-- tools
	79104, -- watering can
	80513, -- bug sprayer
	89880, -- shovel
	89815, -- plow
	-- portals
	91860, -- Stormwind
	91864, -- Ironforge
	91865, -- Darnassus
	91866, -- Exodar
	91850, -- Orgrimmar
	91861, -- Thunder Bluff
	91862, -- Undercity
	91863, -- Silvermoon
};
local function hasItems()
	if not config.hideWhenEmpty then
		return true
	end
	for i = 1, #inventoryIDs do
		if GetItemCount(inventoryIDs[i], false, false) > 0 then
			return true;
		end
	end
	return false;
end
local isInCombat = false;
local function notInCombat()
	return not (isInCombat and config.hideInCombat);
end
local function notInVehicle()
	return not (UnitUsingVehicle("player") and config.hideInVehicle);
end
local function notMounted()
	return not (IsMounted() and config.hideWhenMounted);
end

local autoShowOverride = false;
local autoShowOverrideHide = false;
function FRM:farmWindowAutoShowEvent(event)
	if event == "PLAYER_REGEN_DISABLED" then
		isInCombat = true;
	elseif event == "PLAYER_REGEN_ENABLED" then
		isInCombat = false;
	end

	if event == "ZONE_CHANGED" then
		autoShowOverrideHide = false;
	end

	if autoShowOverride or autoShowOverrideHide or InCombatLockdown() then
		return;
	end
	
	if onFarm() and hasItems() and notInCombat() and notInVehicle() and notMounted() then
		farmWindow:Show();
	else
		farmWindow:Hide();
	end
end

local autoShowFrame = CreateFrame("Frame");
autoShowFrame:SetScript("OnEvent", FRM.farmWindowAutoShowEvent);
autoShowFrame:RegisterEvent("ZONE_CHANGED");
autoShowFrame:RegisterEvent("PLAYER_LOGIN");
autoShowFrame:RegisterEvent("BAG_UPDATE");
autoShowFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
autoShowFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
autoShowFrame:RegisterEvent("UNIT_ENTERED_VEHICLE");
autoShowFrame:RegisterEvent("UNIT_EXITED_VEHICLE");
autoShowFrame:RegisterEvent("UNIT_AURA");

-- manual show/hide

function FRM:showFarmFrame()
	if not InCombatLockdown() then
		farmWindow:Show();
		autoShowOverride = true;
	else
		ThnanMod:output(L.farmWindowShowInCombatError);
	end
end

local function farmWindowCloseButtonClicked()
	autoShowOverride = false;
	autoShowOverrideHide = true;
end
farmWindow.CloseButton:HookScript("OnClick", farmWindowCloseButtonClicked);

--[[ forecast ]]--

-- labels

local forecastLabel = farmWindow:CreateFontString("farmWindowForecastLabel", "ARTWORK", "GameFontNormal");
forecastLabel:SetText(L.farmWindowForecastLabel);
forecastLabel:SetPoint("CENTER", -1, -29);

local forecastChangeLabel = farmWindow:CreateFontString("farmWindowForecastChangeLabel", "ARTWORK", "GameFontNormalSmall");
forecastChangeLabel:SetText("|cFFFFFFFF"..L.farmWindowForecastChange.."|r");
forecastChangeLabel:SetPoint("TOP", forecastLabel, "BOTTOM", 0, -2);

-- buttons

local function forecastButton_OnEnter(self)
	GameTooltip:SetOwner(farmWindow);
	if self.itemID2 and IsShiftKeyDown() then
		GameTooltip:SetItemByID(self.itemID2);
		GameTooltip:AddLine(self.itemTooltipLine, 0, 1, 1, true);
	elseif self.itemID then
		GameTooltip:SetItemByID(self.itemID);
		GameTooltip:AddLine(self.itemTooltipLine, 0, 1, 1, true);
	else
		GameTooltip:ClearLines();
		GameTooltip:AddLine(self.noInfoTooltip, 0, 1, 1, true);
	end
	GameTooltip:SetAnchorType("ANCHOR_TOPLEFT");
	GameTooltip:Show();
end
local function forecastSeedButton_setMacroText(self)
	if self.itemID then
		seedButton_setMacroText(self);
	else
		if InCombatLockdown() then
			self:RegisterEvent("PLAYER_REGEN_ENABLED");
		else
			self:UnregisterEvent("PLAYER_REGEN_ENABLED");
			self:SetAttribute("macrotext", nil);
		end
	end
end
local function forecastSeedButton_updateAppearance(self)
	if self.itemID then
		seedButton_updateAppearance(self);
	else
		self.icon:SetTexture(noInfoTexture);
		self.icon:SetVertexColor(1.0, 1.0, 1.0);
		local countText = _G[self:GetName().."Count"];
		countText:SetText("");
	end
end
local function forecastCropButton_updateAppearance(self)
	if self.itemID then
		if not self.itemTexture then
			local _, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(self.itemID);
			self.itemTexture = itemTexture;
		end
		if self.itemTexture then
			self:UnregisterEvent("GET_ITEM_INFO_RECEIVED");
			self.icon:SetTexture(self.itemTexture);
		else
			self:RegisterEvent("GET_ITEM_INFO_RECEIVED");
		end
	else
		self.icon:SetTexture(noInfoTexture);
	end
end

local forecastSeedButton = CreateFrame("CheckButton", "FRMForecastSeedButton", farmWindow, "ActionButtonTemplate,SecureActionButtonTemplate");
forecastSeedButton:SetPoint("TOPLEFT", col3 + halfCol, row5);
forecastSeedButton:RegisterForClicks("LeftButtonDown", "RightButtonDown");
forecastSeedButton:SetAttribute("*type1", "macro");
forecastSeedButton:SetAttribute("*type2", "setRightClickSeed");
forecastSeedButton.itemTooltipLine = L.forecastSeedButtonTooltip;
forecastSeedButton.noInfoTooltip = L.forecastSeedNoInfoTooltip;
forecastSeedButton:SetScript("OnEnter", forecastButton_OnEnter);
forecastSeedButton:SetScript("OnLeave", farmButton_OnLeave);
forecastSeedButton:SetScript("OnEvent", farmButton_OnEvent);
forecastSeedButton:HookScript("OnClick", farmButton_OnClick);
forecastSeedButton.checkedState = false;
rightClickButtons[#rightClickButtons + 1] = forecastSeedButton;
forecastSeedButton.setAttributeValue = forecastSeedButton_setMacroText;
forecastSeedButton.setRightClickSeed = seedButton_setRightClickSeed;
forecastSeedButton.updateAppearance = forecastSeedButton_updateAppearance;

local forecastCropButton = CreateFrame("Button", "FRMForecastCropButton", farmWindow, "ActionbuttonTemplate");
forecastCropButton:SetPoint("TOPLEFT", col4 + halfCol, row5);
forecastCropButton.itemTooltipLine = L.forecastCropButtonTooltip;
forecastCropButton.noInfoTooltip = L.forecastCropNoInfoTooltip;
forecastCropButton:SetScript("OnEnter", forecastButton_OnEnter);
forecastCropButton:SetScript("OnLeave", farmButton_OnLeave);
forecastCropButton:SetScript("OnEvent", farmButton_OnEvent);
forecastCropButton.updateAppearance = forecastCropButton_updateAppearance;

-- updates

local data = FRM.data;
local time = ThnanMod.Time;
local function updateData(newSeed)
	local day, month, year = time:currentDailyDate();
	local today = ("%d-%d-%d"):format(day, month, year);
	local yesterday = ("%d-%d-%d"):format(time:rectifyDate(day - 1, month, year));
	if data.today ~= today then
		if data.today then
			data.yesterday = data.today;
			data.yesterdayForecast = data.todayForecast;
		end
		if newSeed then
			data.today = today;
			data.todayForecast = newSeed;
		else
			data.today = nil;
			data.todayForecast = nil;
		end
	elseif newSeed then
		data.todayForecast = newSeed;
	end
	if data.yesterday ~= yesterday then
		data.yesterday = nil;
		data.yesterdayForecast = nil;
	end
end

local cropIDFromSeedID = {
	[79102] = 74840, -- green cabbage
	[80591] = 74843, -- scallion
	[80593] = 74844, -- red blossom leek
	[80595] = 74850, -- white turnip
	[89326] = 74846, -- witchberry
	[80590] = 74841, -- juicycrunch carrot
	[80592] = 74842, -- mogu pumpkin
	[80594] = 74849, -- pink turnip
	[89328] = 74847, -- jade squash
	[89329] = 74848, -- striped melon
};
local bagIDFromSeedID = {
	[79102] = 95434, -- green cabbage
	[80591] = 95441, -- scallion
	[80593] = 95440, -- red blossom leek
	[80595] = 95443, -- white turnip
	[89326] = 95444, -- witchberry
	[80590] = 95436, -- juicycrunch carrot
	[80592] = 95438, -- mogu pumpkin
	[80594] = 95439, -- pink turnip
	[89328] = 95437, -- jade squash
	[89329] = 95442, -- striped melon
};
local previousToday = "";
local previousTodaySeed = 0;
local previousYesterdaySeed = 0;
local function farmWindow_OnUpdate(self)
	forecastChangeLabel:SetText("|cFFFFFFFF"..L.farmWindowForecastChange:format(time:timeUntilDailyReset()).."|r");
	
	local today = ("%d-%d-%d"):format(time:currentDailyDate());
	if today ~= previousToday then
		previousToday = today;
		updateData(nil);
	end
	
	if previousTodaySeed ~= data.todayForecast then
		previousTodaySeed = data.todayForecast;
		forecastSeedButton.itemID = data.todayForecast;
		if forecastSeedButton.itemID then
			forecastSeedButton.itemID2 = bagIDFromSeedID[data.todayForecast];
			forecastSeedButton:RegisterEvent("BAG_UPDATE");
			forecastSeedButton:RegisterEvent("MODIFIER_STATE_CHANGED");
		else
			forecastSeedButton.itemID2 = nil;
			forecastSeedButton:UnregisterEvent("BAG_UPDATE");
			forecastSeedButton:UnregisterEvent("MODIFIER_STATE_CHANGED");
		end
		forecastSeedButton.itemTexture = nil;
		forecastSeedButton.itemTexture2 = nil;
		forecastSeedButton:setAttributeValue();
		if forecastSeedButton.itemID and forecastSeedButton.itemID == rightClickSeed then
			forecastSeedButton.checkedState = true;
		else
			forecastSeedButton.checkedState = false;
		end
		forecastSeedButton:updateAppearance();
	end
	
	if previousYesterdaySeed ~= data.yesterdayForecast then
		previousYesterdaySeed = data.yesterdayForecast;
		forecastCropButton.itemID = cropIDFromSeedID[data.yesterdayForecast];
		forecastCropButton.itemTexture = nil;
		forecastCropButton:updateAppearance();
	end
end
farmWindow:SetScript("OnUpdate", farmWindow_OnUpdate);

local seedIDFromForecastText = {
	[L.joguPredictsGreenCabbage] = 79102,
	[L.joguPredictsScallion] = 80591,
	[L.joguPredictsRedBlossomLeek] = 80593,
	[L.joguPredictsWhiteTurnip] = 80595,
	[L.joguPredictsWitchberry] = 89326,
	[L.joguPredictsJuicycrunchCarrot] = 80590,
	[L.joguPredictsMoguPumpkin] = 80592,
	[L.joguPredictsPinkTurnip] = 80594,
	[L.joguPredictsJadeSquash] = 89328,
	[L.joguPredictsStripedMelon] = 89329,
};
local function gossipUpdate(self)
	local seedID = seedIDFromForecastText[GetGossipText()];
	if seedID then
		updateData(seedID);
		farmWindow_OnUpdate(farmWindow);
	end
end
farmWindow:SetScript("OnEvent", gossipUpdate);
farmWindow:RegisterEvent("GOSSIP_SHOW");

--[[ tool drop ]]--

local function dropButton_OnEnter(self)
	GameTooltip:SetOwner(farmWindow);
	GameTooltip:ClearLines();
	GameTooltip:AddLine(L.dropToolsTitle, false);
	GameTooltip:AddLine(L.dropToolsDescription, 1, 1, 1, true);
	GameTooltip:SetAnchorType("ANCHOR_TOPLEFT");
	GameTooltip:Show();
end
local toolIDs = {
	79104, -- watering can
	80513, -- bug sprayer
	89880, -- shovel
	89815, -- master plow
};
local function dropButton_OnClick()
	for i = 1, #toolIDs do
		local found = false;
		for bag = 0, NUM_BAG_SLOTS do
			for slot = 1, GetContainerNumSlots(bag) do
				if GetContainerItemID(bag, slot) == toolIDs[i] then
					PickupContainerItem(bag, slot);
					DeleteCursorItem();
					found = true;
					break;
				end
			end
			if found then
				break;
			end
		end
	end
end

local dropToolsButton = CreateFrame("Button", "dropToolsFRMButton", farmWindow, "ActionButtonTemplate");
dropToolsButton:SetPoint("TOPLEFT", col4 + halfCol, row3);
dropToolsButton.icon:SetTexture("Interface\\ICONS\\misc_arrowdown");
dropToolsButton:SetScript("OnClick", dropButton_OnClick);
dropToolsButton:SetScript("OnEnter", dropButton_OnEnter);
dropToolsButton:SetScript("OnLeave", farmButton_OnLeave);

local function exitFrame_OnEvent()
	if (GetSubZoneText() ~= L.sunsongRanchName) and config.dropOnLeavingFarm then
		dropButton_OnClick();
	end
end
local exitFrame = CreateFrame("Frame");
exitFrame:SetScript("OnEvent", exitFrame_OnEvent);
exitFrame:RegisterEvent("ZONE_CHANGED");

--[[ right click planting ]]--

-- seed setting

setRightClickSeed = function(seedID)
	if rightClickSeed == seedID then
		rightClickSeed = nil;
	else
		rightClickSeed = seedID;
	end
	for k, button in pairs(rightClickButtons) do
		if rightClickSeed and (button.itemID == rightClickSeed) then
			button.checkedState = true;
		else
			button.checkedState = false;
		end
		button:updateAppearance();
	end
end

-- click detection and binding

local isBound = false;
local clickNumber = 1;
local firstClickTime = 0;
local rightClickFrame = CreateFrame("Frame");
rightClickFrame:SetScript("OnUpdate", function(self)
	if (GetTime() - firstClickTime) > 0.5 then
		clickNumber = 1;
		rightClickFrame:Hide();
	end
	if isBound then
		ClearOverrideBindings(rightClickFrame);
		isBound = false;
	end
end);
rightClickFrame:Hide();

local function worldFrame_OnMouseUp(self, button)
	if GetSubZoneText() == L.sunsongRanchName and button == "RightButton" then
		if clickNumber == 1 then
			clickNumber = 2;
			firstClickTime = GetTime();
			rightClickFrame:Show();
		elseif clickNumber == 2 and rightClickSeed and not InCombatLockdown() and GetUnitName("target") == tilledSoilName then
			SetOverrideBindingItem(rightClickFrame, false, "BUTTON2", "item:"..rightClickSeed);
			isBound = true;
			MouselookStop();
		end
	end
end
WorldFrame:HookScript("OnMouseUp", worldFrame_OnMouseUp);