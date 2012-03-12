if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_HealthFlash requires PitBull4")
end

-- :::::::::::: LOCALS ::::::::::::: -------------------------------------------------------------------------

local L = PitBull4.L

local GetLayoutDB = PitBull4.Options.GetLayoutDB

local PitBull4_HealthFlash = PitBull4:NewModule("HealthFlash", "AceEvent-3.0", "AceTimer-3.0")
PitBull4_HealthFlash:SetModuleType("custom")
PitBull4_HealthFlash:SetName(L["Health flash"])
PitBull4_HealthFlash:SetDescription(L["Flashes health bar when life drops under a specified percent."])
PitBull4_HealthFlash:SetDefaults({
   enabled = true,
   threshold = 0.3,
   duration = 0.3,
   diff = 0.1,
   intensity = 0.7
},
{})

local updated_guids = {}

-- timer for OnUpdate execution control
local timerFrame = PitBull4.Controls.MakeFrame()
timerFrame:Hide()
local timer = 0
timerFrame:SetScript("OnUpdate",function(self, elapsed)
	timer = timer + elapsed
	if timer >= 0.2 then
		PitBull4_HealthFlash:OnUpdate()
		timer = 0
	end
end)
local timer = 0
                 
local function update_frame(frame, db)
   local current = UnitHealth(frame.unit) / UnitHealthMax(frame.unit)
   if PitBull4_HealthFlash:EnsureFlashFrame(frame, db) then 
      if (not frame.HealthFlash.anim:IsPlaying()) and current <= db.threshold and current - frame.HealthFlash.LastHealth < -db.diff then
         frame.HealthFlash.anim:Play()
      end
   end
   frame.HealthFlash.LastHealth = current;
end
                 
-- :::::::::::: PitBull4_HealthFlash ::::::::::::: -------------------------------------------------------------------------
function PitBull4_HealthFlash:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("UNIT_MAXHEALTH","UNIT_HEALTH")
end
                                
function PitBull4_HealthFlash:PLAYER_ENTERING_WORLD()
	timerFrame:Show()
end
                      
function PitBull4_HealthFlash:UNIT_HEALTH(event, unit)
	updated_guids[UnitGUID(unit)] = true
end

function PitBull4_HealthFlash:OnUpdate()
	if next(updated_guids) then
		for frame in PitBull4:IterateFrames() do
			if updated_guids[frame.guid] then
            local db = self:GetLayoutDB(frame)
            if db.enabled then 
			      update_frame(frame, db)
			   end
			end
		end
	end
	wipe(updated_guids)
end

function PitBull4_HealthFlash:OnDisable()
	timerFrame:Hide()
end

local index = 1

function PitBull4_HealthFlash:EnsureFlashFrame(frame, db)
   local f = frame.HealthBar
   if not f then return false end
   if not frame.HealthFlash then
      frame.HealthFlash = {}
      frame.HealthFlash = CreateFrame("Frame", "PItBull4_HealthFlash"..tostring(index), UIParent, "PitBull4_HealthFlash_TemplateFrame")
      frame.HealthFlash.healthbar = f
      frame.HealthFlash:SetParent(f)
      frame.HealthFlash.anim.step1:SetDuration(db.duration/6)
      frame.HealthFlash.anim.step2:SetDuration(db.duration - (db.duration/6))
      frame.HealthFlash.anim.step1:SetChange(db.intensity)
      frame.HealthFlash.anim.step2:SetChange(-db.intensity)

      frame.HealthFlash.HealthFlashAnimFinished = PitBull4_HealthFlash.HealthFlashAnimFinished
      frame.HealthFlash.LastHealth = UnitHealth(frame.unit) / UnitHealthMax(frame.unit)
      index = index + 1
   end
   return true
end

function PitBull4_HealthFlash:HealthFlashAnimFinished(animGroup)
   animGroup:GetParent():Hide();
end

PitBull4_HealthFlash:SetLayoutOptionsFunction(function(self)

	local function get_layout(info)
  	   local db = GetLayoutDB(self)
		local id = info[#info]
		return db[id]
	end
	local function set_layout(info, value)
  	   local db = GetLayoutDB(self)
		local id = info[#info]
		db[id] = value
		for frame in PitBull4:IterateFramesForLayout(PitBull4.Options:GetCurrentLayout(), true) do
         if frame.HealthFlash then
		      local db1 = self:GetLayoutDB(frame)
            frame.HealthFlash.anim.step1:SetDuration(db1.duration/6)
            frame.HealthFlash.anim.step2:SetDuration(db1.duration - (db.duration/6))
            frame.HealthFlash.anim.step1:SetChange(db1.intensity)
            frame.HealthFlash.anim.step2:SetChange(-db1.intensity)
         end
		end
	end                              
	
	return true,
   	'threshold', {
			type = 'range',
			name = L["Health threshold"],
			desc = L["Health percent threshold needed to trigger flashing."],
			get = get_layout, 
			set = set_layout,
			min = 0.1,
			max = 1,
			step = 0.01,
			bigStep = 0.05,
			isPercent = true,
			order = 2,
		},
		'duration', {
			type = 'range',
			name = L["Duration"],
			desc = L["Duration of flashing animation."],
			get = get_layout, 
			set = set_layout,
			min = 0.1,
			max = 1,
			step = 0.01,
			bigStep = 0.05,
			order = 3,
		},
   	'diff', {
			type = 'range',
			name = L["Minimun drop"],
			desc = L["Minimun percent of health dropped needed to trigger flashing (0 means flashing will occur every health drop below threshold)."],
			get = get_layout, 
			set = set_layout,
			min = 0,
			max = 0.9,
			step = 0.01,
			bigStep = 0.05,
			isPercent = true,
			order = 2,
		},
   	'intensity', {
			type = 'range',
			name = L["Intensity"],
			desc = L["Flash intensity."],
			get = get_layout, 
			set = set_layout,
			min = 0.3,
			max = 1,
			step = 0.01,
			bigStep = 0.05,                			isPercent = true,
			order = 2,
		}
end)
--[[
SLASH_ZZZ1 = "/zzz"
SlashCmdList["ZZZ"] = function(msg, editbox)
   if not InCombatLockdown() then
      PitBull4_HealthFlash:EnsureAnimation()
      if not PitBull4_HealthFlash.anim then return end
      if PitBull4_HealthFlash.anim.anim:IsPlaying() then 
         PitBull4_HealthFlash.anim.anim:Stop() 
      end 
      PitBull4_HealthFlash.anim.anim:Play(); 
   end
end
--]]