if (select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING") then return end

local PitBull4 = PitBull4
if (not PitBull4) then
	error("PitBull4_PetTTLBar requires PitBull4")
end

-- cache
local GetPetTimeRemaining = GetPetTimeRemaining

local L = LibStub("AceLocale-3.0"):GetLocale("PitBull4_PetTTLBar")
local PtrScale = 1000
local MaxPtr = 30 * 60 * PtrScale
local maxValue = 0

local PitBull4_PetTTLBar = PitBull4:NewModule("PetTimeToLiveBar", "AceEvent-3.0")

PitBull4_PetTTLBar:SetModuleType("bar")
PitBull4_PetTTLBar:SetName(L["Pet Lifetime bar"])
PitBull4_PetTTLBar:SetDescription(L["Show a bar indicating the remaining lifetime of your temporary pet"])
PitBull4_PetTTLBar:SetDefaults({
	size = 1,
	position = 3,
})

local function getPetTTL()
    local ptr = GetPetTimeRemaining()
    if (not ptr or ptr >= MaxPtr or ptr <= 0) then
        -- ptr gets HUGE just before despawning the pet, probably a bug
        -- might need to change this logic if we want to support pets with longer than 10 min lifetime
        return nil
    end
    return ptr / PtrScale
end

local function updateAll()
    for frame in PitBull4:IterateFramesForUnitID("pet") do
        PitBull4_PetTTLBar:Update(frame)
    end
end

local timerFrame = CreateFrame("Frame")
timerFrame:Hide()
timerFrame:SetScript("OnUpdate", updateAll)

function PitBull4_PetTTLBar:OnEnable()
    self:RegisterEvent("UNIT_PET")
end

function PitBull4_PetTTLBar:OnDisable()
    timerFrame:Hide()
    self:UnregisterAllEvents()
end

function PitBull4_PetTTLBar:UNIT_PET(event, unitId)
    if (unitId ~= "player") then
         return
    end
    updateAll()
    if (getPetTTL()) then
        timerFrame:Show()
    else
        timerFrame:Hide()
    end
end

function PitBull4_PetTTLBar:GetPetTTL()
    return getPetTTL()
end

function PitBull4_PetTTLBar:GetValue(frame)
    if (frame.unit ~= "pet") then
        return nil
    end
    local pttl = getPetTTL()
    if (not pttl) then
        maxValue = 0
        return nil
    end
    if (pttl >= maxValue) then
        maxValue = pttl
        return 1
    end
    return pttl / maxValue
end

function PitBull4_PetTTLBar:GetExampleValue(frame)
	return 0.42
end

function PitBull4_PetTTLBar:GetColor(frame, value)
    local color = PitBull4.PowerColors.FUEL
    if (color) then
        return color[1], color[2], color[3]
    end
end

