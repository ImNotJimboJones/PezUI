-- albin
BINDING_NAME_UndressButtonName = "Dress up target";
BINDING_HEADER_UndressButtonHeader = "Undress Button";

function UndressButton_Load(self)
	if (not SideDressUpFrame) then  --4.3 changes (frame names have changed)
		self:RegisterEvent("ADDON_LOADED");
	end
end

function UndressButton_Event(self,event,...)
	local arg1 = ...;
	if (event == "ADDON_LOADED") then
		if (arg1 == "Blizzard_AuctionUI") then
			self:UnregisterEvent("ADDON_LOADED");
			SideDressUpFrameUndressButton:SetPoint("BOTTOM", "SideDressUpModelResetButton", "TOP", 0, 2); --4.3 api changes
			SideDressUpFrameUndressButton:SetParent("SideDressUpModel");
			SideDressUpFrameUndressButton:SetFrameLevel(SideDressUpModelResetButton:GetFrameLevel());
		end
	end
end

function UndressButton_Reset()
	SetPortraitTexture(DressUpFramePortrait, "player");
	SetDressUpBackground();
	DressUpModel:SetUnit("player");
end

function UndressButton_DressUpTarget(x)
	if (not DressUpFrame:IsVisible()) then
		ShowUIPanel(DressUpFrame);
	else
		PlaySound("gsTitleOptionOK");
	end
	if (x == "inspect") then
		if(UnitIsVisible("target")) then
			SetPortraitTexture(DressUpFramePortrait, "target");
			SetDressUpTargetBackground();
			DressUpModel:SetUnit("target");
		else
			UndressButton_Reset();
		end
	elseif (x == "dress") then
		if(UnitIsVisible("target") and UnitIsPlayer("target")) then
			DressUpModel:Undress();
			UndressButton_Inspect("target");
		else
			-- UndressButton_Reset();
			UndressButton_Inspect("player");
		end
	end
end

function UndressButton_Inspect(unit)
	local slots = {
		"HeadSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot",
		"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "MainHandSlot", "SecondaryHandSlot"
	}; -- "NeckSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot", "RangedSlot" left out for obvious reasons
	for _, slot in ipairs(slots) do
		NotifyInspect(unit);
		DressUpItemLink(GetInventoryItemLink(unit, GetInventorySlotInfo(slot)));
	end
end

local function DressUpTargetTexturePath()
	local race, fileName = UnitRace("target");

	if ( not fileName ) then
		fileName = "Orc";
	end

	return "Interface\\DressUpFrame\\DressUpBackground-"..fileName;
end

function SetDressUpTargetBackground()
	local texture = DressUpTargetTexturePath();
	DressUpBackgroundTopLeft:SetTexture(texture..1);
	DressUpBackgroundTopRight:SetTexture(texture..2);
	DressUpBackgroundBotLeft:SetTexture(texture..3);
	DressUpBackgroundBotRight:SetTexture(texture..4);
end

local function DressUpPlayerTexturePath()
	local race, fileName = UnitRace("player");

	if ( not fileName ) then
		fileName = "Orc";
	end

	return "Interface\\DressUpFrame\\DressUpBackground-"..fileName;
end
