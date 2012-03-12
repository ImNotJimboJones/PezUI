-- GridStatusLineOfSight.lua
--
-- Created By : Pachelbel
-- Updated By : Cyprias (07/25/10)
-- Updated By : misterb1986 (09/29/11)

local L = LibStub("AceLocale-3.0"):GetLocale("GridStatusLineOfSight", silent)

local settings
local UnitGUID = UnitGUID
local SPELL_FAILED_LINE_OF_SIGHT = SPELL_FAILED_LINE_OF_SIGHT

-- Module
GridStatusLineOfSight = Grid:GetModule("GridStatus"):NewModule("GridStatusLineOfSight", "AceTimer-3.0")

local GridStatusLineOfSight = GridStatusLineOfSight
GridStatusLineOfSight.menuName = L["Line Of Sight"]
GridStatusLineOfSight.options = false
GridStatusLineOfSight.timers = {}

local GridRoster = Grid:GetModule("GridRoster")

GridStatusLineOfSight.defaultDB = {
    debug = false,
    enable = true,
    version = "1.4",

    lineofsight = {
        text = L["LoS"],
        enable = true,
        color = { r = 0.0, g = 0.0, b = 1.0, a = 1.0 },
        priority = 50,
        duration = 8.0,  -- how long they should get the LoS indicator for
        range = false,
    },
}

local lineofsightOptions = {
    ["duration"] = {
        type = 'range',
        name = L["LoS duration"],
        desc = L["Seconds LoS error indicator should remain on"],
        get = function() 
            return GridStatusLineOfSight.db.profile.lineofsight.duration 
        end,
        set = function(_,v)
            GridStatusLineOfSight.db.profile.lineofsight.duration = v
        end,
        min = 1.0,
        max = 10.0,
        step = 0.5,
        isPercent = false,
    },
	["text"] = {
	type = "input",
	name = L["Text"],
	desc = L["Text to display"],
	get = function () return GridStatusLineOfSight.db.profile.lineofsight.text end,
	set = function (_, v)
		GridStatusLineOfSight.db.profile.lineofsight.text = v
	end,
	},
}



-- variables for "transactioning" spell casts
local savedSpellName = ""
local savedSpellRank = ""
local savedTargetGUID = ""

function GridStatusLineOfSight:OnInitialize()
    self.super.OnInitialize(self)
    self:RegisterStatus("lineofsight", L["Line Of Sight"], lineofsightOptions, true)
	
	settings = GridStatusLineOfSight.db.profile.lineofsight
	
    -- init saved variables used for spell cast "transactioning"
    savedSpellName = ""
    savedSpellRank = ""
    savedTargetGUID = ""

    --!!! once enable is fixed remove below
    --self:RegisterEvent("UNIT_SPELLCAST_START", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UNIT_SPELLCAST_SENT", "UNIT_SPELLCAST_SENT")
    --self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "UNIT_SPELLCAST_SUCCEEDED")
    --self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UI_ERROR_MESSAGE")

    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:OnInitialize")
end

function GridStatusLineOfSight:OnEnable()
	self.super.OnEnable(self)
end

function GridStatusLineOfSight:Reset()
	self.super.Reset(self)
	self.core:SendStatusLostAllUnits(status)
	wipe(self.timers)
	self:UnregisterStatus("lineofsight")
	self:RegisterStatus("lineofsight", L["Line Of Sight"], lineofsightOptions, true)
end

function GridStatusLineOfSight:OnStatusEnable(status)
	self:RegisterMessage("Grid_UnitLeft")
	
    self:RegisterEvent("UNIT_SPELLCAST_START", "UNIT_SPELLCAST_clear")
    self:RegisterEvent("UNIT_SPELLCAST_SENT", "UNIT_SPELLCAST_SENT")
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "UNIT_SPELLCAST_SUCCEEDED")
    self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_clear")
    self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_clear")
    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UNIT_SPELLCAST_clear")

    self:RegisterEvent("UI_ERROR_MESSAGE")

    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:OnEnable")
end

function GridStatusLineOfSight:OnStatusDisable(status)
	self.core:SendStatusLostAllUnits(status)
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	wipe(self.timers)
end

-- Converts the full name (which is the name of the unit together with 
-- its realm) to the grid name ("Roster-2.1" name actually) which is 
-- simply the name of the unit
--function GridStatusLineOfSight:GetGridName(fullName)
--    return fullName:match("(.+)%-") or fullName
--end

function GridStatusLineOfSight:LoseStatus(GUID)
--~     local gridName = self:GetGridName(name) -- strip realm if present

	--local GUID = UnitGUID(name)--If they're in our group, we can use UnitGUID on their name.
	if GUID then
	--~ 	print("LoseStatus", name)

		-- cancel any previous events to clear LoS indicator
		self:CancelTimer(self.timers[GUID], true)
		self.core:SendStatusLost(GUID, "lineofsight")
	end
	
    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:LoseStatus " .. name)
end

function GridStatusLineOfSight:GainStatus(GUID)
--~     local gridName = self:GetGridName(name) -- strip realm if present
	if GUID then
		-- cancel any previous events to clear LoS indicator
		self:CancelTimer(self.timers[GUID], true)
	
		self.core:SendStatusGained(GUID,
									"lineofsight",
									settings.priority,
									nil,
									settings.color,
									settings.text,
									nil,
									nil,
									nil)
	
		-- add event to remove LoS indicator in duration seconds
		self.timers[GUID] = self:ScheduleTimer("LoseStatus", settings.duration, GUID)
	end
	
    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:GainStatus " .. name)
end

function GridStatusLineOfSight:Grid_UnitLeft(event, GUID)
	--cancel and nil out timers from units that are no longer in the group so they can be GC'd
	self:CancelTimer(self.timers[GUID], true)
	self.timers[GUID] = nil
end

function GridStatusLineOfSight:UI_ERROR_MESSAGE(event, message, r, g, b)
    
    if (not settings.enable) then return end  -- only run if enabled
--~ 	print("UI_ERROR_MESSAGE", message, "++", SPELL_FAILED_LINE_OF_SIGHT, message == SPELL_FAILED_LINE_OF_SIGHT, tostring(savedTargetGUID))
    -- if LoS was cause of error...
    if (message == SPELL_FAILED_LINE_OF_SIGHT) then
        -- if we have a saved target from spell cast sent event...
        if (savedTargetGUID ~= "") then
            -- gain status for target
            self:GainStatus(savedTargetGUID)
        end
        
        -- clear saved variables
        savedSpellName = ""
        savedSpellRank = ""
        savedTargetGUID = ""

        -- trace out event
        --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:UI_ERROR_MESSAGE " .. ":" .. message)
    end

end

function GridStatusLineOfSight:UNIT_SPELLCAST_clear(event, unit)

    if (not settings.enable) then return end  -- only run if enabled
    if (unit ~= 'player') then return end  -- look for our own casts

--~ 	print("UNIT_SPELLCAST_clear", unit)
	
    -- clear saved variables (target will be gotten in sent event)
    savedSpellName = ""
    savedSpellRank = ""
    savedTargetGUID = ""

    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:UNIT_SPELLCAST_clear " .. unit)
end

function GridStatusLineOfSight:UNIT_SPELLCAST_SENT(event, unit, spellName, spellRank, targetName)
	
    if (not settings.enable) then return end  -- only run if enabled
    if (unit ~= 'player') then return end  -- look for our own casts
	local GUID = UnitGUID(targetName) --If they're in our group, we can use UnitGUID on their name.
--~ 	print("UNIT_SPELLCAST_SENT A", unit, spellName, spellRank, targetName)
    -- save spellName, spellRank, and targetName for "transactioning" of 
    -- spell cast succeed, interrupt and failed events
    savedSpellName = spellName;
    savedSpellRank = spellRank;
    savedTargetGUID = GUID;
    
    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:UNIT_SPELLCAST_SENT " .. unit .. ":" .. spellName .. ":" .. savedTargetGUID)
end

function GridStatusLineOfSight:UNIT_SPELLCAST_SUCCEEDED(event, unit, spellName, spellRank)

    if (not settings.enable) then return end  -- only run if enabled
    if (unit ~= 'player') then return end  -- look for our own casts

--~ 	print("UNIT_SPELLCAST_SUCCEEDED B", unit, spellName)
	
    -- if same spell name and rank, assume same target
    if ((spellName == savedSpellName) and (spellRank == savedSpellRank)) then
        -- if spell cast succeeded, then must be in LoS, so lose status (if they had it)
        self:LoseStatus(savedTargetGUID)
    end
    
    -- clear saved variables (even if not match)
    savedSpellName = ""
    savedSpellRank = ""
    savedTargetGUID = ""
    
    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:UNIT_SPELLCAST_SUCCEEDED " .. unit .. ":" .. spellName)
end

