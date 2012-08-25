BetterExtraActionBarDB = BetterExtraActionBarDB or {}

--masque shenanigans, may look terrible with background texture enabled! (the button border is part of the texture)
local MSQ = LibStub and LibStub("Masque", true)
if MSQ then
	MSQ:Group("BetterExtraActionButton"):AddButton(_G["ExtraActionButton1"])
end

--decouple from MainMenuBar
ExtraActionBarFrame:SetParent(UIParent)
ExtraActionBarFrame.SetParent = function() end ---noooo bt, noooo
ExtraActionBarFrame:SetMovable(true)

--Don't manage the frame for me, thanks, and don't adjust other frames to account for it
UIPARENT_MANAGED_FRAME_POSITIONS["ExtraActionBarFrame"] = nil
for k, v in next, UIPARENT_MANAGED_FRAME_POSITIONS do
	v.extraActionBarFrame = nil
end

local locked = true
local moving = nil

local overlay = CreateFrame("Frame", nil, ExtraActionBarFrame)
overlay:SetAllPoints()

overlay:EnableMouse()
overlay:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" and not locked then
		local frame = self:GetParent()
		frame:ClearAllPoints()
		frame:StartMoving()
		moving = true
	end
end)

local function UpdateState()
	local frame = ExtraActionBarFrame

	--show the bg and use the full texture for clicks just to make it easier to move
	frame.button.style:SetAlpha(1)
	frame:SetWidth(frame.button.style:GetWidth())

	if locked then
		frame.button.style:SetDesaturated(false)
		frame:EnableMouseWheel(false)
		if BetterExtraActionBarDB.hidebg then
			--hide the art and make the clickable area just outside the button
			frame.button.style:SetAlpha(0)
			frame:SetWidth(64)
		end
	else
		frame.button.style:SetDesaturated(true)
		frame:EnableMouseWheel(true)
	end
end

overlay:SetScript("OnMouseUp", function(self, button)
	if button == "RightButton" then
		locked = not locked
		UpdateState()

	elseif button == "MiddleButton" then
		if not locked then
			self:GetParent():SetScale(1)
			BetterExtraActionBarDB.scale = nil
		end

	elseif moving then
		moving = nil
		local frame = self:GetParent()
		frame:StopMovingOrSizing()
		frame:SetUserPlaced(false)

		local point, _, _, x, y = frame:GetPoint(1)
		BetterExtraActionBarDB.point = point
		BetterExtraActionBarDB.x = x
		BetterExtraActionBarDB.y = y
	end
end)

overlay:SetScript("OnMouseWheel", function(self, delta)
	local frame = self:GetParent()
	local scale = frame:GetScale() + (0.1 * delta)
	frame:SetScale(scale)
	BetterExtraActionBarDB.scale = scale
end)

local function OnShow(self)
	local frame = self:GetParent()

	if BetterExtraActionBarDB.point then
		frame:ClearAllPoints()
		frame:SetPoint(BetterExtraActionBarDB.point, BetterExtraActionBarDB.x, BetterExtraActionBarDB.y)
	--else --default placement?
		--frame:SetPoint("BOTTOM", MainMenuBar, "BOTTOM", 0, 160)
	end

	if BetterExtraActionBarDB.scale then
		frame:SetScale(BetterExtraActionBarDB.scale)
	end

	--make sure the background is doing what it should be doing
	UpdateState()

	if MSQ then
		MSQ:Group("BetterExtraActionButton"):ReSkin() --do i need this? mystery!
	end
end
overlay:SetScript("OnShow", OnShow)

--ExtraActionBar_OnLoad can show the frame before we get to it
overlay:SetScript("OnEvent", function(self)
	if self:GetParent():IsShown() then
		OnShow(self)
	end
end)
overlay:RegisterEvent("PLAYER_ENTERING_WORLD")

_G["SLASH_BETTEREXTRABUTTONBAR1"] = "/beab"
_G.SlashCmdList["BETTEREXTRABUTTONBAR"] = function(input)
	local frame = ExtraActionBarFrame

	if input == "reset" then
		--in case the frame is under the ui or offscreen
		wipe(BetterExtraActionBarDB)
		frame:ClearAllPoints()
		frame:SetPoint("CENTER")

	elseif input == "toggle" then
		--show/hide the frame
		if HasExtraActionBar() and frame:IsShown() then
			--don't mess with it if its up for a fight
			return
		elseif frame:IsShown() then
			frame.intro:Stop()
			frame.outro:Play()
		else
			frame.button:Show()
			frame:Show()
			frame.outro:Stop()
			frame.intro:Play()
		end

	elseif input == "togglebg" then
		--show/hide the fancy background texture
		BetterExtraActionBarDB.hidebg = not BetterExtraActionBarDB.hidebg
		UpdateState()
	end
end
