local _, FRM = ...;
local config = FRM.config;
local L = FRM.L;

-- NPC name parsing

local npcTooltip = CreateFrame("GameTooltip", "FRMnpcTooltip");
local tooltipText = npcTooltip:CreateFontString();
npcTooltip:AddFontStrings(tooltipText, npcTooltip:CreateFontString());

local function nameForNPC(npcID)
	npcTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	npcTooltip:SetHyperlink(("unit:0xF53%05X00000000"):format(npcID));
	return tooltipText:GetText();
end

-- create window

local farmWindow = CreateFrame("Frame", "farmWindow", UIParent, "BasicFrameTemplate");
farmWindow:SetPoint("CENTER");
farmWindow:SetWidth((7*36) + (5*8) + 2);
farmWindow:SetHeight((5*36) + (6*5) + 23);
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

-- button creation functions

local function farmButton_OnEnter(self)
	GameTooltip:SetOwner(farmWindow);
	GameTooltip:SetItemByID(self.itemID);
	GameTooltip:SetAnchorType("ANCHOR_TOPLEFT");
	GameTooltip:Show();
end
local function farmButton_OnLeave(self)
	GameTooltip:Hide();
end
local function farmButton_OnEvent(self, evt)
	self:updateCount();
end
local function farmButton_OnEvent_unloaded(self, evt)
	if evt == "BAG_UPDATE" then
		self:updateCount();
	elseif evt == "GET_ITEM_INFO_RECEIVED" then
		if self:loadItem() then
			self:UnregisterEvent("GET_ITEM_INFO_RECEIVED");
			self:SetScript("OnEvent", farmButton_OnEvent);
		end
	end
end

local tilledSoilID = 58563;
local tilledSoilName = nameForNPC(tilledSoilID);

local function seedButton_OnEnter_load(self)
	farmButton_OnEnter(self);
	if not tilledSoilName then
		tilledSoilName = nameForNPC(tilledSoilID);
	end
	if tilledSoilName then
		self:setMacroText();
		self:SetScript("OnEnter", farmButton_OnEnter);
	end
end
local function seedButton_setMacroText(self)
	if tilledSoilName and self.itemName then
		self:SetAttribute("macrotext", "/tar "..tilledSoilName.."\n/use "..self.itemName.."\n/targetlasttarget");
	end
end
local function seedButton_loadItem(self)
	local itemName, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(self.itemID);
	
	if itemName and itemTexture then
		self.itemName = itemName;
		self:setMacroText();
		self.icon:SetTexture(itemTexture);
		return true;
	else
		return false;
	end
end
local function seedButton_updateCount(self)
	local countText = _G[self:GetName().."Count"];
	local count = GetItemCount(self.itemID, false, false);
	if (count > 99) then
		countText:SetText("*");
	else
		countText:SetText(count);
	end
	
	local icon = _G[self:GetName().."Icon"];
	if (count > 0) then
		icon:SetVertexColor(1.0, 1.0, 1.0);
	else
		icon:SetVertexColor(0.4, 0.4, 0.4);
	end
end

local function toolButton_loadItem(self)
	local itemName, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(self.itemID);
	
	if itemName and itemTexture then
		self:SetAttribute("item", itemName);
		self.icon:SetTexture(itemTexture);
		return true;
	else
		return false;
	end
end
local function toolButton_updateCount(self)
	local count = GetItemCount(self.itemID, false, false);
	local icon = _G[self:GetName().."Icon"];
	if (count > 0) then
		icon:SetVertexColor(1.0, 1.0, 1.0);
	else
		icon:SetVertexColor(0.4, 0.4, 0.4);
	end
end

local function createFarmButton(itemID, buttonType)
	local button = CreateFrame("Button", itemID.."FRMButton", farmWindow, "ActionButtonTemplate,SecureActionButtonTemplate");
	
	button.itemID = itemID;
	button:SetScript("OnEnter", farmButton_OnEnter);
	button:SetScript("OnLeave", farmButton_OnLeave);
	button:SetScript("OnEvent", farmButton_OnEvent);
	
	if buttonType == "seed" then
		button:SetAttribute("type", "macro");
		button.setMacroText = seedButton_setMacroText;
		button.loadItem = seedButton_loadItem;
		button.updateCount = seedButton_updateCount;
		if not tilledSoilName then
			button:SetScript("OnEnter", seedButton_OnEnter_load);
		end
	elseif buttonType == "tool" then
		button:SetAttribute("type", "item");
		button.loadItem = toolButton_loadItem;
		button.updateCount = toolButton_updateCount;
	end
	
	if not button:loadItem() then
		button:SetScript("OnEvent", farmButton_OnEvent_unloaded);
		button:RegisterEvent("GET_ITEM_INFO_RECEIVED");
	end
	button:RegisterEvent("BAG_UPDATE");
	
	return button;
end

-- create seed buttons

local greenCabbageButton = createFarmButton(79102, "seed");
local scallionButton = createFarmButton(80591, "seed");
local redBlossomLeekButton = createFarmButton(80593, "seed");
local whiteTurnipButton = createFarmButton(80595, "seed");
local witchberryButton = createFarmButton(89326, "seed");
local juicycrunchCarrotButton = createFarmButton(80590, "seed");
local moguPumpkinButton = createFarmButton(80592, "seed");
local pinkTurnipButton = createFarmButton(80594, "seed");
local jadeSquashButton = createFarmButton(89328, "seed");
local stripedMelonButton = createFarmButton(89329, "seed");

local magebulbButton = createFarmButton(85217, "seed");
local snakerootButton = createFarmButton(85215, "seed");
local songbellButton = createFarmButton(89233, "seed");
local enigmaButton = createFarmButton(85216, "seed");
local raptorleafButton = createFarmButton(89202, "seed");
local windshearCactusButton = createFarmButton(89197, "seed");

local autumnBlossomButton = createFarmButton(85267, "seed");
local springBlossomButton = createFarmButton(85268, "seed");
local winterBlossomButton = createFarmButton(85269, "seed");

local ominousSeedButton = createFarmButton(85219, "seed");

-- create tool buttons

local wateringCanButton = createFarmButton(79104, "tool");
local bugSprayerButton = createFarmButton(80513, "tool");
local shovelButton = createFarmButton(89880, "tool");
local plowButton = createFarmButton(89815, "tool");

-- define row and column values for TOPLEFT corners

local col1, col2, col3, col4, col5, col6, col7 = 5, 46, 87, 128, 169, 210, 251;
local halfCol = 20;
local row1, row2, row3, row4, row5 = -28, -69, -110, -151, -192;

-- place seed buttons

greenCabbageButton:SetPoint("TOPLEFT", col1, row1);
scallionButton:SetPoint("TOPLEFT", col1, row2);
redBlossomLeekButton:SetPoint("TOPLEFT", col1, row3);
whiteTurnipButton:SetPoint("TOPLEFT", col1, row4);
witchberryButton:SetPoint("TOPLEFT", col1, row5);

juicycrunchCarrotButton:SetPoint("TOPLEFT", col2, row1);
moguPumpkinButton:SetPoint("TOPLEFT", col2, row2);
pinkTurnipButton:SetPoint("TOPLEFT", col2, row3);
jadeSquashButton:SetPoint("TOPLEFT", col2, row4);
stripedMelonButton:SetPoint("TOPLEFT", col2, row5);

magebulbButton:SetPoint("TOPLEFT", col6, row1);
snakerootButton:SetPoint("TOPLEFT", col6, row2);
songbellButton:SetPoint("TOPLEFT", col6, row3);
autumnBlossomButton:SetPoint("TOPLEFT", col6, row4);
winterBlossomButton:SetPoint("TOPLEFT", col6, row5);

enigmaButton:SetPoint("TOPLEFT", col7, row1);
raptorleafButton:SetPoint("TOPLEFT", col7, row2);
windshearCactusButton:SetPoint("TOPLEFT", col7, row3);
springBlossomButton:SetPoint("TOPLEFT", col7, row4);
ominousSeedButton:SetPoint("TOPLEFT", col7, row5);

-- place tool buttons

wateringCanButton:SetPoint("TOPLEFT", col3 + halfCol, row1);
bugSprayerButton:SetPoint("TOPLEFT", col4 + halfCol, row1);
shovelButton:SetPoint("TOPLEFT", col3 + halfCol, row2);
plowButton:SetPoint("TOPLEFT", col4 + halfCol, row2);

-- grow check

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
};

local function growCheckButton_OnEnter(self)
	GameTooltip:SetOwner(farmWindow);
	GameTooltip:ClearLines();
	GameTooltip:AddLine(L.growCheckTitle, false);
	GameTooltip:AddLine("|cFFFFFFFF"..L.growCheckDescription.."|r", true);
	GameTooltip:SetAnchorType("ANCHOR_TOPLEFT");
	GameTooltip:Show();
	if not InCombatLockdown() then
		local macrotext = "";
		for i = 1, #growCheckIDs do
			local name = nameForNPC(growCheckIDs[i]);
			if name then
				macrotext = macrotext.."/tar "..name.."\n";
			end
		end
		self:SetAttribute("macrotext", macrotext);
	end
end

local growCheckButton = CreateFrame("Button", "growCheckFRMButton", farmWindow, "ActionButtonTemplate,SecureActionButtonTemplate");
growCheckButton:SetScript("OnEnter", growCheckButton_OnEnter);
growCheckButton:SetScript("OnLeave", farmButton_OnLeave);
growCheckButton:SetAttribute("type", "macro");
growCheckButton:SetPoint("TOPLEFT", col4, row3);
growCheckButton.icon:SetTexture("Interface\\ICONS\\Ability_Druid_TreeofLife");

-- zone change detection

local prevZone = "";

local function subZoneChanged()
	local subzone = GetSubZoneText();
	
	if ((subzone == L.sunsongRanchName) and config.showAutomatically) then
		farmWindow:Show();
	elseif ((prevZone == L.sunsongRanchName) and config.showAutomatically) then
		farmWindow:Hide();
	end
	
	prevZone = subzone;
end

local zoneFrame = CreateFrame("Frame");
zoneFrame:RegisterEvent("ZONE_CHANGED");
zoneFrame:SetScript("OnEvent", subZoneChanged);

subZoneChanged();

-- plugin function to show frame so slash command can access it

function FRM:showFarmFrame()
	farmWindow:Show();
end