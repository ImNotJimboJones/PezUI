--[[local PlayerInNotComb = true
local profileName = tostring(GetRealmName().." "..UnitName("player"))

local function CheckFrameStat(arg1) --
	local frameName1 = tostring(arg1)
	
	local StanceButtonsMover1 = CreateFrame("Frame")
		StanceButtonsMover1:Hide()

	if MADB.characters[profileName] and MADB.characters[profileName].profile then
		if MADB.profiles[MADB.characters[profileName].profile].frames[frameName1] and MADB.profiles[MADB.characters[profileName].profile].frames[frameName1].hidden then
			StanceBarFrame:UnregisterAllEvents()
			StanceBarFrame:Hide()
			StanceBarFrame:SetParent(StanceButtonsMover1)
		else
			if arg1 ~= nil or arg1 ~= nil then
				StanceBarFrame:SetParent(arg1)
				StanceBarFrame:Show()
				arg1:Hide()
			end
		end
	else
		if MADB.profiles["default"].frames[frameName1] and MADB.profiles["default"].frames[frameName1].hidden then
			StanceBarFrame:UnregisterAllEvents()
			StanceBarFrame:Hide()
			StanceBarFrame:SetParent(StanceButtonsMover1)
		else
			if arg1 ~= nil or arg1 ~= nil then
				StanceBarFrame:SetParent(arg1)
				StanceBarFrame:Show()
				arg1:Hide()
			end
		end
	end
end

local updateEventStance = {
	["UPDATE_SHAPESHIFT_FORMS"] = true,
	["UPDATE_SHAPESHIFT_USABLE"] = true,
	["UPDATE_SHAPESHIFT_COOLDOWN"] = true,
	["UPDATE_SHAPESHIFT_FORM"] = true,
	["ACTIONBAR_PAGE_CHANGED"] = true,
	["PLAYER_REGEN_ENABLED"] = true,
	["PLAYER_REGEN_DISABLED"] = true,
	["PLAYER_LOGIN"] = true,
	}

local addon = CreateFrame("Frame")
addon:RegisterEvent("PLAYER_LOGIN")
addon:RegisterEvent("PLAYER_REGEN_DISABLED")
addon:RegisterEvent("PLAYER_REGEN_ENABLED")
addon:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
addon:RegisterEvent("UPDATE_SHAPESHIFT_USABLE")
addon:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
addon:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
addon:RegisterEvent("ACTIONBAR_PAGE_CHANGED")

addon:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		PlayerInNotComb = false
	end
	if event == "PLAYER_REGEN_ENABLED" then
		PlayerInNotComb = true
	end
	if updateEventStance[event] then
		if PlayerInNotComb then
			CheckFrameStat(StanceButtonsMover)
			CheckFrameStat(StanceButtonsVerticalMover)
		end
	end
end)

hooksecurefunc("StanceBar_UpdateState", function()
	if PlayerInNotComb then
		CheckFrameStat(StanceButtonsMover)
		CheckFrameStat(StanceButtonsVerticalMover)
	end
end)

hooksecurefunc("StanceBar_Update", function()
	if PlayerInNotComb then --StanceButtonsMover ~= nil
		CheckFrameStat(StanceButtonsMover)
		CheckFrameStat(StanceButtonsVerticalMover)
	end
end)]]