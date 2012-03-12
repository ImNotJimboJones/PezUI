-----------------------
-- Hunter check - Only load this addon if the character is a hunter.
-----------------------
local _,gclass=UnitClass("player")
if gclass ~= "HUNTER" then
	return
end

--------------------
-- Addon Declaration
--------------------
local HunterHelper = LibStub("AceAddon-3.0"):NewAddon("HunterHelper", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "LibSink-2.0")
local L = LibStub("AceLocale-3.0"):GetLocale("HunterHelper", false)
local LSM = LibStub("LibSharedMedia-3.0")
HunterHelper.version = GetAddOnMetadata("HunterHelper", "Version")
HunterHelper.versionstring = "HunterHelper v"..GetAddOnMetadata("HunterHelper", "Version")
_G["HunterHelper"] = HunterHelper

------------------
-- Register Sounds
------------------
LSM:Register("sound", "Alarm Clock", [[Sound\Interface\AlarmClockWarning3.wav]])
LSM:Register("sound", "Raid Warning", [[Sound\Interface\RaidWarning.wav]])
LSM:Register("sound", "Shay's Bell", [[Sound\Spells\ShaysBell.wav]])
LSM:Register("sound", "Snake Aspect", [[Sound\Spells\AspectofTheSnake.wav]])
LSM:Register("sound", "Bonk 1", [[Sound\Spells\Bonk1.wav]])
LSM:Register("sound", "Bonk 3", [[Sound\Spells\Bonk3.wav]])
LSM:Register("sound", "Tribal Drum", [[Sound\Doodad\BellTollTribal.wav]])
LSM:Register("sound", "Troll Gong", [[Sound\Doodad\G_GongTroll01.wav]])
LSM:Register("sound", "Raid Boss Warning", [[Sound\Interface\RaidBossWarning.wav]])

HH_SoundsList = {
	["Alarm Clock"] = "Alarm Clock",
	["Raid Warning"] = "Raid Warning",
	["Shay's Bell"] = "Shay's Bell",
	["Snake Aspect"] = "Snake Aspect",
	["Bonk 1"] = "Bonk 1",
	["Bonk 3"] = "Bonk 3",
	["Tribal Drum"] = "Tribal Drum",
	["Troll Gong"] = "Troll Gong",
	["Raid Boss Warning"] = "Raid Boss Warning",
}


------------
-- Constants
------------

VNDISPLAY_NONE = 1;
VNDISPLAY_SCT = 2;
VNDISPLAY_RW = 3;

HunterHelper.DisplayValue = {L["None"], L["Combat Text"], L["Raid Warning"]};

HHGROWL_NOWARN = 1;		-- Don't warn
HHGROWL_WARNGROWL = 2;		-- Warn when growling
HHGROWL_WARNQUIET = 3;		-- Warn when NOT growling

HHSTANCE_NONE = 1;		-- No preferred pet stance
HHSTANCE_ASSIST = 2;	-- Prefer Assist
HHSTANCE_DEFENSIVE = 3;	-- Prefer Defensive
HHSTANCE_PASSIVE = 4;	-- Prefer Passive

HunterHelper.GrowlWarningValue = {L["Never"], L["When Growling"], L["When Not Growling"]};
HunterHelper.StanceWarningValue = {L["None"], L["Pet Assist"], L["Pet Defensive"], L["Pet Passive"]};

local partyTokens = { "party1", "party2", "party3", "party4" };
local slotTokens = {
	[1] = "head",
	[5] = "chest",
	[7] = "legs",
	[16] = "main hand",
	[18] = "ranged"
};

-- Lists all of the battle aspects.
-- HunterHelper can tell you when you're in combat without one of these selected.

-- Method: Since spell names are localized, use the SpellID of ANY rank of the desired spell.
-- On initialization, use GetSpellInfo() to get the localized name.

local spellIDs = {
	["Aspect of the Hawk"] = 13165,
	["Aspect of the Wild"] = 20043,
	["Aspect of the Fox"] = 82661,

	["Heart of the Phoenix"] = 54114,
	["Revive Pet"] = 982,
	["Growl"] = 2649,
	["Tame Beast"] = 13481,
	["Tame Beast2"] = 1515,
}

local battleAspects = {};
local hasBattleAspects = false;
local spellHeartofPhoenix;
local spellRevivePet;
local spellTameBeast;

local spellStanceSlot = {
	HHSTANCE_ASSIST = -1,
	HHSTANCE_DEFENSIVE = -1,
	HHSTANCE_PASSIVE = -1,
};

local stanceWarningNumbers = {
	HHSTANCE_NONE = HHSTANCE_NONE,
	HHSTANCE_ASSIST = HHSTANCE_ASSIST,
	HHSTANCE_DEFENSIVE = HHSTANCE_DEFENSIVE,
	HHSTANCE_PASSIVE = HHSTANCE_PASSIVE,
};

local spellAttackSlot;
local spellFollowSlot;

local snoozeTime = 0;
local snoozeMinutesLeft = 10000;


------------------
-- Local Variables
------------------
HHConfig = {}

local defaults = {
	profile = {
		SettingsVersion = 0.00,		-- Will be set in MigrateSettings block.
		SoundsEnabled = true,
		UpdateInterval = 5,
		MessageColor = {r=.2,g=.7,b=.9},
		DisplayMethod = VNDISPLAY_SCT,
		DisableWhenSolo = false,
		DisplayAllWarnings = false,
		MaxWarningCount = 0,

		Warning = {
			["noaspect"] = {
				Enabled = true,
				Message = L["Default No Aspect Message"],
				Sound = "Troll Gong",
				Priority = 1,
			},
			["nopet"] = {
				Enabled = true,
				Message = L["Default No Pet Message"],
				Sound = "Troll Gong",
				Priority = 3,
			},
			["pethealth"] = {
				Enabled = true,
				Message = L["Default Pet Health Message"],
				Sound = "Raid Boss Warning",
				Threshold = 0.40,
				Priority = 6,
			},
			["petdead"] = {
				Enabled = true,
				Message = L["Default Pet Dead Message"],
				Sound = "Troll Gong",
				Priority = 2,
			},
			["passive"] = {
				Enabled = true,
				Message = L["Default Pet Passive Message"],
				Sound = "Bonk 1",
				UnlessAttacking = true,
				Priority = 7,
			},
			["defensive"] = {
				Enabled = true,
				Message = L["Default Pet Defensive Message"],
				Sound = "Bonk 1",
				Priority = 4,
			},
			["assist"] = {
				Enabled = true,
				Message = L["Default Pet Assist Message"],
				Sound = "Bonk 1",
				Priority = 10,
			},
			["growling"] = {
				Message = L["Your pet is growling!"],
				Sound = "Raid Boss Warning",
				Priority = 5,
			},
			["notgrowling"] = {
				Message = L["Your pet is not growling!"],
				Sound = "Raid Boss Warning",
				Priority = 8,
			},
			["equipment"] = {
				Enabled = true,
				Message = L["Default Bad Equipment Message"],
				Sound = "Bonk 1",
				Priority = 9,
				MinItemLevel = 10,
			},
		},
		
		PetGroup = {
		    Growl = {
				solo = HHGROWL_WARNQUIET,
				smallparty = HHGROWL_WARNQUIET,
				largeparty = HHGROWL_WARNGROWL,
				raid = HHGROWL_WARNGROWL,
				battleground = HHGROWL_NOWARN,
			},
			
			Stance = {
				solo = HHSTANCE_ASSIST,
				smallparty = HHSTANCE_ASSIST,
				largeparty = HHSTANCE_ASSIST,
				raid = HHSTANCE_ASSIST,
				battleground = HHSTANCE_ASSIST,
			},

			SmallPartySize = 3,
			SmartParty = true,
		},
	},
}

local WarningPriority = {}
local WarningStatus = {}


-------------------
-- Helper functions
-------------------

local function isNumeric(a)
	return type(tonumber(a)) == "number"
end

local function isTable(a)
	return type(a) == "table"
end

local function tableSize(a)
	local count = 0;

	if isTable(a) then
		for key,value in pairs(a) do
			count = count + 1;
		end
	end

	return count;
end

-- Utility function, useful for debugging.
local function SafeString(arg)
	if (arg == nil) then
		return "nil";
	elseif (type(arg) == boolean) then
		return arg and "true" or "false";
	else
		return arg;
	end
end


-----------------
-- Initialization
-----------------
function HunterHelper:OnInitialize()
	self.currTime = 0;
	self.lastUpdateTime = 0;						-- Allow us to display a warning immediately.
	self.lastDismountTime = 0;
	self.lastCombatStartTime = 0;
	self.OnInitialize = nil;
	self.wasMounted = false;

	self:InitSpells();
end

function HunterHelper:OnEnable()
	-- Load our current settings, or defaults if we don't have any.
	self.db = LibStub("AceDB-3.0"):New("HHVars", defaults, true);
	HHConfig = self.db.profile;

	-- Future releases: Call migrate-settings functions here if needed.
	self:MigrateSettings_1922();
	self:MigrateSettings_196();
	self:MigrateSettings_197();
	HHConfig.SettingsVersion = tonumber(self.version);

	self:SetupOptions();
	self:InitWarningStatus();

	-- Register events
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	self:RegisterEvent("SPELLS_CHANGED");
	self:RegisterEvent("PET_BAR_UPDATE");

	-- Setup remaining stuff.
	self:UpdateGrowlSlot();
	self:UpdatePetStanceSlots();
	self:UpdateBattleAspects();

	self.UpdateTimer = self:ScheduleRepeatingTimer("ProcessCurrentState", 0.5)		-- Process every half-second.
end

function HunterHelper:isAtLeastVersion(currentVer)
    local savedVerNum = tonumber(HHConfig.SettingsVersion);
    
    if savedVerNum == nil then
		return false;
	elseif savedVerNum < currentVer then
	    return false;
	else
		return true;
	end
end

function HunterHelper:MigrateSettings_1922()
	if not self:isAtLeastVersion(1.922) and HHConfig.Growl ~= nil then
		if HHConfig.Growl.GrowlMessage ~= nil then
			HHConfig.Warning["growling"].Message = HHConfig.Growl.GrowlMessage;
			HHConfig.Growl.GrowlMessage = nil;
		end

		if HHConfig.Growl.GrowlSound ~= nil then
			HHConfig.Warning["growling"].Sound = HHConfig.Growl.GrowlSound;
			HHConfig.Growl.GrowlSound = nil;
		end

		if HHConfig.Growl.QuietMessage ~= nil then
			HHConfig.Warning["notgrowling"].Message = HHConfig.Growl.QuietMessage;
			HHConfig.Growl.QuietMessage = nil;
		end

		if HHConfig.Growl.QuietSound ~= nil then
			HHConfig.Warning["notgrowling"].Sound = HHConfig.Growl.QuietSound;
			HHConfig.Growl.QuietSound = nil;
		end
	end
end

function HunterHelper:MigrateSettings_196()
    -- Patch 4.1: Remove references to "happiness" warning
    if not self:isAtLeastVersion(1.96) then
    	if HHConfig.Warning["happiness"] ~= nil then
    		local happinessPri = HHConfig.Warning["happiness"].Priority;
    		HHConfig.Warning["happiness"] = nil;
    		
    		for name,v in pairs(HHConfig.Warning) do
    			if v.Priority > happinessPri then
    				v.Priority = v.Priority - 1;
    			end
    		end
    		
    		self:InitWarningStatus();
    	end
    end
end

function HunterHelper:MigrateSettings_197()
	-- Patch 4.2: Remove Pet Aggressive, add Pet Assist
	if not self:isAtLeastVersion(1.97) then
		if HHConfig.Growl ~= nil then
			for name,v in pairs(HHConfig.Growl.When) do
				HHConfig.PetGroup.Growl[name] = v;
			end
			
			HHConfig.PetGroup.SmallPartySize = HHConfig.Growl.SmallPartySize;
			HHConfig.PetGroup.SmartParty = HHConfig.Growl.SmartParty;
			
			HHConfig.Growl = nil;
		end
		
		if HHConfig.Warning["aggressive"] ~= nil then
			HHConfig.Warning["defensive"].Priority = HHConfig.Warning["aggressive"].Priority;
			
			HHConfig.Warning["aggressive"] = nil;
		end
	end
end

function HunterHelper:OnDisable()
	if self.UpdateTimer ~= nil then
		self:CancelTimer(self.UpdateTimer, true);
		self.UpdateTimer = nil;
	end

	self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	self:UnregisterEvent("SPELLS_CHANGED");
	self:UnregisterEvent("PET_BAR_UPDATE");
end

function HunterHelper:InitWarningStatus()
	for name,v in pairs(HHConfig.Warning) do
		WarningPriority[v.Priority] = name;
		
		WarningStatus[name] = {
			recentCallCount = 0,
			snoozing = false,
			active = false
		};
	end
end


function HunterHelper:InitSpells()
	-- Query the server for the localized names of our spells.
	-- Note: select(x, GetSpellInfo(y)) returns all items starting at x when used inside an array constructor.
	-- The more laborious method here is a workaround.

	local x;
	x = GetSpellInfo(spellIDs["Aspect of the Hawk"]);		battleAspects[1] = x;
	x = GetSpellInfo(spellIDs["Aspect of the Wild"]);		battleAspects[2] = x;
	x = GetSpellInfo(spellIDs["Aspect of the Fox"]);		battleAspects[3] = x;
	
	x = GetSpellInfo(spellIDs["Heart of the Phoenix"]);		spellHeartofPhoenix = x;
	x = GetSpellInfo(spellIDs["Revive Pet"]);			spellRevivePet = x;
	x = GetSpellInfo(spellIDs["Growl"]);				spellGrowl = x;
	x = GetSpellInfo(spellIDs["Tame Beast"]);			spellTameBeast = x;
end


------------------------
-- Process Current State
------------------------

function HunterHelper:SPELLS_CHANGED(eventID)
	self:UpdateGrowlSlot();
	self:UpdateBattleAspects();
end

function HunterHelper:PET_BAR_UPDATE(eventID)
	-- Unfortunately, this event fires whenever you do ANYTHING with the pet action bar.
	-- It means the addon will be scanning the bar much more frequently than would be
	-- strictly necessary, but the event doesn't give me any info on what the pet bar
	-- is actually doing in this update.  Therefore, we go with the safest option and
	-- tell it to scan the spell slots every time.

	self:UpdatePetStanceSlots();
end

function HunterHelper:UNIT_SPELLCAST_SUCCEEDED(eventID, unitID, SpellName, SpellRank)
	-- If we just cast Heart of the Phoenix to battle-rez pet, suspend pet warnings
	-- for a few seconds to avoid spurious "Pet missing!" warnings.

	if (unitID == "pet" and SpellName == spellHeartofPhoenix) then
		self.lastDismountTime = GetTime();
	end
end

function HunterHelper:UpdateBattleAspects()
	-- Check to see if the hunter has ANY of the Battle Aspects.
	hasBattleAspects = false;

	for i = 1, #battleAspects do
		if GetSpellInfo(battleAspects[i]) ~= nil then
			hasBattleAspects = true;
		end
	end
end

function HunterHelper:UpdateGrowlSlot()
	-- Iterate through the spells in the pet spellbook, if we have one.
	local i = 1;
	spellGrowlSlot = -1;

	while true do
		local spellType, spellID = GetSpellBookItemInfo(i, BOOKTYPE_PET);
		if not spellID then
			do break end
		end

		if spellID == spellIDs["Growl"] then
			spellGrowlSlot = i;
			do break end
		end

		i=i+1;
	end
end

function HunterHelper:UpdatePetStanceSlots()

	-- This is somewhat of a kludge and may not work for everyone.
	-- Blizzard apparently doesn't give much in the way of API help for the pet
	-- action bar, and the standard pet actions and stances are not queryable
	-- via the pet spell book (GetSpellBookItemInfo) for some reason.

	i = 1;
	spellStanceSlot.HHSTANCE_ASSIST = -1;
	spellStanceSlot.HHSTANCE_DEFENSIVE = -1;
	spellStanceSlot.HHSTANCE_PASSIVE = -1;

	spellAttackSlot = -1;
	spellFollowSlot = -1;

	while i < 11 do
		local spellName, spellText = GetPetActionInfo(i);
		
		if( spellName == "PET_MODE_ASSIST" ) then
			spellStanceSlot.HHSTANCE_ASSIST = i;
			
		elseif( spellName == "PET_MODE_DEFENSIVE" ) then
			spellStanceSlot.HHSTANCE_DEFENSIVE = i;

		elseif( spellName == "PET_MODE_PASSIVE" ) then
			spellStanceSlot.HHSTANCE_PASSIVE = i;
			
		elseif( spellName == "PET_ACTION_ATTACK" ) then
			spellAttackSlot = i;
			
		elseif( spellName == "PET_ACTION_FOLLOW" ) then
			spellFollowSlot = i;
			
		end
		i=i+1;
	end
end

function HunterHelper:PetIsGrowling(groupType)
	if spellGrowlSlot == -1 then
		return HHGROWL_NOWARN;
	else
		local isGrowling = select(2, GetSpellAutocast(spellGrowlSlot, "pet")) == 1 and true or false
		
		-- Determine if the current growl state is appropriate for our settings.
		local growlWarningType = HHConfig.PetGroup.Growl[groupType];

		if (growlWarningType == HHGROWL_WARNGROWL and not isGrowling)
		or (growlWarningType == HHGROWL_WARNQUIET and isGrowling) then
			growlWarningType = HHGROWL_NOWARN;
		end

		return growlWarningType;
	end
end

function HunterHelper:GetPetStanceWarning(groupType)
	-- What's our preferred stance for this group type?
	local preferredStance = HHConfig.PetGroup.Stance[groupType];
	
	if preferredStance ~= HHSTANCE_NONE then
		-- Check to see if the preferred stance is the active one.
		for name,v in pairs(spellStanceSlot) do
			if spellStanceSlot[name] ~= -1 and (select(5, GetPetActionInfo(spellStanceSlot[name]))) == 1 then
				if stanceWarningNumbers[name] ~= preferredStance then
					return stanceWarningNumbers[name];
				end
			end
		end
	end
	
	return HHSTANCE_NONE;
end

function HunterHelper:ScanForBadEquipment()
	for slot,name in pairs(slotTokens) do
		local itemId = GetInventoryItemID("player", slot);
		
		if itemId == nil then
			-- Nothing equipped in critical slot.
			return true;
		else
			local iLevel = select(4, GetItemInfo(itemId));
			
			-- Item is too low level or is broken (or about to be)
			if (iLevel < HHConfig.Warning["equipment"].MinItemLevel) or GetInventoryAlertStatus(slot) >= 1 then
				return true;
			end
		end
	end
	
	return false;
end


function HunterHelper:SmartPartyMembers()
	-- Return the number of party members who are
	-- connected, visible (nearby and in the same phase), and alive.
	local count = 0;
	local isLFG = UnitGroupRolesAssigned("player") ~= nil;
	local tankInParty = false;
	local tankUp = true;
	
	-- Iterate over the people in my party
	for i,v in ipairs(partyTokens) do
		if UnitExists(v) then
			if UnitGroupRolesAssigned(v) == "TANK" then
				tankInParty = true;
			end
			
			if UnitIsVisible(v) and UnitIsConnected(v) and not UnitIsDeadOrGhost(v) then
				count = count + 1;
			elseif UnitGroupRolesAssigned(v) == "TANK" then
				tankIsUp = false;
			end
		end
	end
	
	if isLFG and tankInParty and tankUp then
		return 5;		-- Always make it a large party when the tank is up.
	else
		return count;
	end
end

function HunterHelper:GetGroupType()
	local partyMembers = GetNumPartyMembers() + 1;
	local raidMembers = GetNumRaidMembers() + 1;
	local groupType = "solo";

	if raidMembers > 1 then
		groupType = "raid";
		local maxBF = GetMaxBattlefieldID();

		local status, mapName, instanceID, minlevel, maxlevel;
		for i=1, maxBF do
			status, mapName, instanceID, minlevel, maxlevel, teamSize = GetBattlefieldStatus(i);
			if status == "active" then
				groupType = "battleground";
				break;
			end
		end

	elseif partyMembers > 1 then
		groupType = "smallparty";
		if HHConfig.PetGroup.SmartParty then
			if self:SmartPartyMembers() + 1 > HHConfig.PetGroup.SmallPartySize then
				groupType = "largeparty";
			end
		else
			if partyMembers > HHConfig.PetGroup.SmallPartySize then
				groupType = "largeparty";
			end
		end
	end

	return groupType;
end

function HunterHelper:isEnabled(warning)
	return HHConfig.Warning[warning] == nil and false or HHConfig.Warning[warning].Enabled;
end

function HunterHelper:UpdateSnoozeTimer()
	if snoozeTime > 0 then
		if self.currTime >= snoozeTime then
			snoozeTime = 0;
			snoozeMinutesLeft = 10000;
			self:Print(L["SnoozeTimer Finished"]);
	
			-- Clear snooze warning table.
			for i,v in pairs(WarningStatus) do
				v.snoozing = false;
			end
		else
			local timeLeft = math.floor((snoozeTime - self.currTime) / 60);
			
			-- Display a message:
			-- - First time we hit this block after starting the snooze timer
			-- - Every 5 minutes (15, 10, 5 left)
			-- - At 1 minute
			
			if (timeLeft < snoozeMinutesLeft and (snoozeMinutesLeft == 10000 or (timeLeft+1) % 5 == 0 or timeLeft == 1)) then
				snoozeMinutesLeft = timeLeft;
	
				-- This might seem like more work than it's worth, but it's mainly to support
				-- localization, where the sentence structures for "in 1 minute" and
				-- "in 5 minutes" might be different than in English.
	
				if( timeLeft > 1 ) then
					self:Print(string.format(L["SnoozeTimer Update Plural"], timeLeft+1));
				else
					self:Print(L["SnoozeTimer Update Single"]);
				end
			end
		end
	end
end


function HunterHelper:ProcessCurrentState()
	self.currTime = GetTime();

	-- Update the SnoozeTimer (if applicable)
	self:UpdateSnoozeTimer();

	local isMounted = ((IsMounted() or UnitUsingVehicle("player") or UnitOnTaxi("player")) == 1) and true or false;
	
	local groupType = self:GetGroupType();

	-- Check to see if the current mounted state is different than the previous.

	-- NOTE: I track the state of whether a player is mounted, using a vehicle or on a taxi
	-- because Blizzard doesn't provide a simple, consistent way to do this through events.
	-- You can use UNIT_EXITING_VEHICLE, but for taxis and mounts, there doesn't appear to be
	-- a useful event that fires and gives you enough information to tell what happened and
	-- who it affected.  Since I don't actually care EXACTLY when the dismount occurs - I only
	-- need the info when the HH timer fires - I can just look for a change in the state and
	-- treat that as an event.

	if isMounted ~= self.wasMounted then
		if self.wasMounted then				-- Mount state changed from true to false (dismount/exit occurred since the previous update).
			self.lastDismountTime = self.currTime;	-- Mark when the state changed so we give the hunter pet time to respawn.
		end
		self.wasMounted = isMounted;
	end

	-- Skip processing if not enough time has elapsed since the last notification.
	if (self.currTime - self.lastUpdateTime < HHConfig.UpdateInterval) then
		return;

	-- Don't warn if dead or running back to corpse
	elseif UnitIsDead("player") or UnitIsGhost("player") then
		return;

	-- Don't bother me while I'm eating/drinking
	elseif (UnitBuff("player","Food") ~= nil) or (UnitBuff("player","Drink") ~= nil) then
		return;

	-- Don't warn if mounted, or on a vehicle or taxi
	elseif isMounted then
		return;

	-- Don't warn if solo (option)
	elseif HHConfig.DisableWhenSolo and groupType == "solo" then
		return;
	end

	-- If we got here, then figure out what's going on.
	-- First, reset our "active" status.
	for i,v in pairs(WarningStatus) do
		v.active = false;
	end
	
	local hasPet = false;
	local petIsAlive = true;
	local petHealthPct = 100.0;

	-- Check to see if we have a pet.
	if select(2, HasPetUI()) then		-- Checking second return value to see if pet is a hunter pet.
		petIsAlive = not UnitIsDead("pet");
		hasPet = true;

		if petIsAlive then
			petHealthPct = UnitHealth("pet") / UnitHealthMax("pet");
		end
	end


	-- Notifications while in combat.
	if InCombatLockdown() then
	
		if self.lastCombatStartTime == 0 then
			self.lastCombatStartTime = self.currTime;
		end

		local inBattleAspect = true;
		local petIsGrowling = HHGROWL_NOWARN;
		local petIsAttacking = false;
		local petStance = false;

		-- No-Aspect warning
		if self:isEnabled("noaspect") and hasBattleAspects then
			-- Determine if our buffs include any of the battle aspects.
			-- If so, turn off the notification again and exit the loop.

			inBattleAspect = false;
				for n = 1,#battleAspects do
				if UnitBuff("player",battleAspects[n]) ~= nil then
					inBattleAspect = true;
					n = #battleAspects;
				end
			end
		end
		

		if hasPet and petIsAlive then
			-- Check to see if the pet's Growl ability is turned on.
			-- This function returns one of the HHGROWL_* constants.
			petIsGrowling = self:PetIsGrowling(groupType);

			-- Check to see if the pet is in the correct stance for this group type.
			-- This function returns one of the HHSTANE_* constants.
			petStance = self:GetPetStanceWarning(groupType);
		end


		-- Logic tree for in-combat notifications, in order of priority.

		-- No-Aspect warning
		if self:isEnabled("noaspect") and not inBattleAspect then
			WarningStatus["noaspect"].active = true;
		end
		
		-- Bad equipment warning
		if self:isEnabled("equipment") and UnitLevel("player") >= 20 and self:ScanForBadEquipment() then
			WarningStatus["equipment"].active = true;
		end

		if hasPet then
			-- Only warn about pet state if the pet is alive and we didn't just dismount.
			if (self.currTime - self.lastDismountTime >= HHConfig.UpdateInterval) then
				if petIsAlive then
	
					if self:isEnabled("pethealth") and petHealthPct <= HHConfig.Warning["pethealth"].Threshold then
						WarningStatus["pethealth"].active = true;
					end
	
					-- Is pet in the correct stance?
					if petStance == HHSTANCE_ASSIST and self:isEnabled("assist") then
						WarningStatus["assist"].active = true;
					elseif petStance == HHSTANCE_DEFENSIVE and self:isEnabled("defensive") then
						WarningStatus["defensive"].active = true;

					-- Special processing for Passive stance
					elseif petStance == HHSTANCE_PASSIVE and self:isEnabled("passive") then
						-- Passive and not attacking?
						if HHConfig.Warning["passive"].UnlessAttacking then

							-- Attack button available?
							if spellAttackSlot > 0 then
								petIsAttacking = select(5, GetPetActionInfo(spellAttackSlot)) == 1 and true or false;

							-- Alternate method: UnitAffectingCombat (might not be as reliable)
							else
								petIsAttacking = UnitAffectingCombat("pet") == 1 and true or false;
							end
						
							-- If not attacking AND a few seconds have passed (so we bypass this warning in trivial combat situations)...
							
							if not petIsAttacking and (self.currTime >= self.lastCombatStartTime + HHConfig.UpdateInterval) then
								-- Check to see if the pet is following the hunter.
								-- If the "Follow" action is off, the hunter has probably asked the pet to move to a specific spot
								-- or to "Stay", and thus deliberately has chosen not to put the pet in combat.
								
								if spellFollowSlot > 0 then
									if select(5, GetPetActionInfo(spellFollowSlot)) == 1 then
										WarningStatus["passive"].active = true;
									end
								else
									-- If the follow button isn't on the action bar, we'll have to assume the hunter is using it.
									WarningStatus["passive"].active = true;
								end
								
							elseif petIsAttacking then
								self.lastCombatStartTime = self.currTime;
							end
						else
							WarningStatus["passive"].active = true;
						end
					end
					
					if petIsGrowling == HHGROWL_WARNQUIET then
						WarningStatus["notgrowling"].active = true;
	
					elseif petIsGrowling == HHGROWL_WARNGROWL then
						WarningStatus["growling"].active = true;
					end
		
				else
					if self:isEnabled("petdead") then
						WarningStatus["petdead"].active = true;
					end
				end
			end

		-- This code branch means no pet was detected.  (Don't notify if the player is in a vehicle or on a taxi.)
		-- Also: Only notify if we haven't just dismounted - bit of a lag time between dismount and pet spawn.
		elseif self:isEnabled("nopet") and (self.currTime - self.lastDismountTime >= HHConfig.UpdateInterval) then
			local castInfo = UnitCastingInfo("player");
			local chanInfo = UnitChannelInfo("player");

			-- One more check: Don't notify if the player is currently reviving his/her pet or is taming a beast.
			if (castInfo ~= spellRevivePet and chanInfo ~= spellTameBeast) then
				WarningStatus["nopet"].active = true;
			end
		end

	-- Pet is dead out of combat	
	else
		self.lastCombatStartTime = 0;
	
		if self:isEnabled("petdead") and hasPet and not petIsAlive then
			WarningStatus["petdead"].active = true;
		end
	end
	
	self:NotifyHighestWarning();
end


---------------------------
-- Notification and Display
---------------------------

function HunterHelper:NotifyHighestWarning()
	local hasNotified = false;
	
	for i,name in ipairs(WarningPriority) do
		v = WarningStatus[name];
		
		if v.active then
			if not v.snoozing then
				if HHConfig.DisplayAllWarnings then
					hasNotified = self:Notify(name, not hasNotified);
				elseif not hasNotified then
					hasNotified = self:Notify(name, true);
				end
			end
		else
			v.recentCallCount = 0;		-- Reset non-active warnings to 0 call count.
		end
	end
end

function HunterHelper:Notify(warning, playSound)
	local msg = nil;
	local sound = nil;

	if HHConfig.Warning[warning] == nil then
		-- Requested a bad notification.
		self:Print(L["Unrecognized Warnings"].." "..warning);
		return false;

	else
		msg = HHConfig.Warning[warning].Message;
		sound = HHConfig.Warning[warning].Sound;
		
		WarningStatus[warning].recentCallCount = WarningStatus[warning].recentCallCount + 1;

		-- Max warning count logic - only notify up to X times.
		if HHConfig.MaxWarningCount > 0 then
			if WarningStatus[warning].recentCallCount == HHConfig.MaxWarningCount + 1 then
				self:Print(msg);
				return false;
			elseif WarningStatus[warning].recentCallCount > HHConfig.MaxWarningCount + 1 then
				return false;
			end
		end
	end

	self.lastUpdateTime = GetTime();

	if HHConfig.DisplayMethod==VNDISPLAY_SCT then
		if SCT_Display then		--send via SCT if it exists
			SCT_Display(msg, HHConfig.MessageColor);
		elseif MikSBT then		--send via MSBT
			--kinda inefficient redoing the calc every time, but it's only once every few seconds so quick fix wins
			MikSBT.DisplayMessage(msg, nil, nil, HHConfig.MessageColor.r * 255, HHConfig.MessageColor.g * 255, HHConfig.MessageColor.b * 255);
		elseif SHOW_COMBAT_TEXT=="1" then		--otherwise default UI's SCT
			CombatText_AddMessage(msg, CombatText_StandardScroll, HHConfig.MessageColor.r, HHConfig.MessageColor.g, HHConfig.MessageColor.b);
		else
			RaidNotice_AddMessage(RaidWarningFrame, msg, HHConfig.MessageColor);
		end
		
	elseif HHConfig.DisplayMethod==VNDISPLAY_RW then		--raid warning frame
		RaidNotice_AddMessage(RaidWarningFrame, msg, HHConfig.MessageColor);
	end
	
	if HHConfig.SoundsEnabled and playSound then
		self:PlaySound(sound);
	end
	
	return true;
end

function HunterHelper:PlaySound(sound)
	PlaySoundFile(LSM:Fetch("sound", sound))
end

function HunterHelper:Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cff8ed6f0[HunterHelper] "..msg);
end

function HunterHelper:PrintVar(varname, value)
	self:Print(varname.." = "..value);
end

function HunterHelper:PrintBool(varname, value)
	self:PrintVar(varname, L[value and "ON" or "OFF"]);
end


--------------------------
-- Console option handling
--------------------------

function HunterHelper:ParseWarningList(warnings, recognizeOff, expandAll)
	local num = 5;
	local isClean = true;
	local numSet = false;
	local warningList = {};
	local unrecognized = "";

	if warnings ~= nil and warnings ~= "" then
		warnings = string.lower(warnings);
		local tokens = { string.split(" ,", warnings) };

		for index,item in ipairs(tokens) do
			if item ~= nil or item ~= "" then
				if not numSet and isNumeric(item) then
					num = tonumber(item);
					numSet = true;

				elseif item == "all" then
					if expandAll then
						warningList = {};
						for warning in pairs(HHConfig.Warning) do
							warningList[warning] = warning;
						end
					else
						warningList = { "all" };
					end
					break;

				elseif item == "off" and recognizeOff then
					warningList = { "off" };
					num = 0;
					break;
					
				elseif HHConfig.Warning[item] ~= nil then
					warningList[item] = item;

				else
					unrecognized = unrecognized.." "..item;
				end
			end
		end
	end

	if unrecognized ~= "" then
		self:Print(L["Unrecognized Warnings"]..unrecognized);
		isClean = false;
	end

	return num, isClean, warningList;
end	

function HunterHelper:ListWarnings()
	local warningList = " all";

	for key in pairs(HHConfig.Warning) do
		warningList = warningList..", "..key
	end

	return warningList;
end

function HunterHelper:EnableWarning(warnings, setting)
	-- First check to see that the specified warnings exist.
	local num, clean, warningList = self:ParseWarningList(warnings, false, true);
	local toggle = (setting == "toggle");

	if tableSize(warningList) > 0 then
		for i,warning in pairs(warningList) do
			if toggle then
				HHConfig.Warning[warning].Enabled = not HHConfig.Warning[warning].Enabled;
			else
				HHConfig.Warning[warning].Enabled = setting;
			end
			self:PrintBool(warning, HHConfig.Warning[warning].Enabled);
		end
	else
		self:Print(L["Available Warnings"]..self:ListWarnings());
	end
end


function HunterHelper:SetSnoozeTimer(command)
	local minutes, isClean, warningList = self:ParseWarningList(command, true, false);
	local size = tableSize(warningList);
	local strWarnings = "";
	local numWarnings = 0;

	-- Don't do anything if we sent nothing but garbage.
	if size == 0 and not isClean then
		return;

	else
		for i,v in pairs(WarningStatus) do
			v.snoozing = false;
		end
		
		if minutes > 0 then
			if size == 0 or size == tableSize(HHConfig.Warning) then
				for i,v in pairs(WarningStatus) do
					v.snoozing = true;
					numWarnings = numWarnings + 1;
				end

			else
				for i,warning in pairs(warningList) do
					WarningStatus[warning].snoozing = true;
					numWarnings = numWarnings + 1;
					strWarnings = strWarnings.." "..warning;
				end
			end
		else
			minutes = 0;
		end
	end


	-- Finally: If we either have at least one warning in the list, or we're cancelling the timer,
	-- then go ahead and set it.  (0 minutes = cancel.)
	if numWarnings > 0 or minutes == 0 then
		snoozeMinutesLeft = 10000;
		snoozeTime = self.currTime + 60 * minutes;
		if minutes > 0 then
			if numWarnings == tableSize(WarningStatus) then
				self:Print(L["SnoozeTimer Start All"]);
			else
				self:Print(L["SnoozeTimer Start Some"]..strWarnings);
			end
		end
	end
end


----------------------
-- Configuration Panel
----------------------

function HunterHelper:SetupOptions()
	self:InitOptionsStructures();
	self:PopulateWarningPriorityOptions();

	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("HunterHelper", self.GenerateOptions)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("HunterHelperSlashCommand", self.OptionsSlash, "hh")

	local ACD3 = LibStub("AceConfigDialog-3.0")
	self.OptionsFrames = {}
	self.OptionsFrames.HunterHelper = ACD3:AddToBlizOptions("HunterHelper", self.versionstring, nil, "General")
	self.OptionsFrames.PetOptions = ACD3:AddToBlizOptions("HunterHelper", L["General Warnings"], self.versionstring, "Warning")
	self.OptionsFrames.PetGrowlOptions = ACD3:AddToBlizOptions("HunterHelper", L["Pet Group Behavior"], self.versionstring, "PetGroup")
	self.OptionsFrames.WarningPriority = ACD3:AddToBlizOptions("HunterHelper", L["Warning Priority"], self.versionstring, "WarningPriority")

	self.SetupOptions = nil
end

function HunterHelper:RegisterModuleOptions(name, optionTbl, displayName)
	if moduleOptions then
		moduleOptions[name] = optionTbl
	else
		self.Options.args[name] = (type(optionTbl) == "function") and optionTbl() or optionTbl
	end
	self.OptionsFrames[name] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("HunterHelper", displayName, self.versionstring, name)
end

function HunterHelper:ShowConfig(location)
	if location ~= nil then location = self.OptionsFrames.HunterHelper end;
	InterfaceOptionsFrame_OpenToCategory(location)
end

function HunterHelper:GenerateOptions()
	if HunterHelper.noconfig then assert(false, HunterHelper.noconfig) end
	if not HunterHelper.Options then
		HunterHelper.GenerateOptionsInternal()
		HunterHelper.GenerateOptionsInternal = nil;
		moduleOptions = nil;
	end
	return HunterHelper.Options
end


----------------------------
-- HunterHelper Config Tables
----------------------------

function HunterHelper:InitOptionsStructures()
	HunterHelper.OptionsSlash = {
		type = "group",
		name = L["Slash Command"],
		order = -3,
		args = {
			intro = {
				order = 1,
				type = "description",
				name = L["HH_SLASH_DESC"],
				cmdHidden = true,
			},
			interval = {
				order = 2,
				type = "range",
				name = L["Update Interval"],
				desc = L["Update Interval"].." (0.5 - 20.0)",
				min = 0.5,
				max = 20.0,
				step = 0.1,
				get = function(info) return HHConfig.UpdateInterval end,
				set = function(info, value)
					HHConfig.UpdateInterval = value;
					HunterHelper:PrintVar(L["Update Interval"], HHConfig.UpdateInterval);
				end,
			},
			displaycombat = {
				order = 3,
				type = "execute",
				name = L["Display as Combat Text"],
				desc = L["Display as Combat Text"],
				func = function()
					HHConfig.DisplayMethod = VNDISPLAY_SCT;
					HunterHelper:PrintVar(L["Display Method"], L["Combat Text"]);
				end,
			},
			displayraid = {
				order = 4,
				type = "execute",
				name = L["Display as Raid Warning"],
				desc = L["Display as Raid Warning"],
				func = function()
					HHConfig.DisplayMethod = VNDISPLAY_RW;
					HunterHelper:PrintVar(L["Display Method"], L["Raid Warning"]);
				end,
			},
			displaynone = {
				order = 5,
				type = "execute",
				name = L["Disable Messages"],
				desc = L["Disable Messages"],
				func = function()
					HHConfig.DisplayMethod = VNDISPLAY_NONE;
					HunterHelper:PrintVar(L["Display Method"], L["None"]);
				end,
			},
			sounds = {
				order = 6,
				type = "toggle",
				name = L["Toggle Sounds"],
				desc = L["Toggle Sounds"],
				get = function(info) return HHConfig.SoundsEnabled end,
				set = function(info, value)
					HHConfig.SoundsEnabled = value;
					HunterHelper:PrintBool(L["Enable Sounds"], HHConfig.SoundsEnabled);
				end,
			},
			solo = {
				order = 7,
				type = "toggle",
				name = L["Toggle Disable When Solo"],
				desc = L["Toggle Disable When Solo"],
				get = function(info) return HHConfig.DisableWhenSolo end,
				set = function(info, value) 
					HHConfig.DisableWhenSolo = value;
					HunterHelper:PrintBool(L["Disable When Solo"], HHConfig.DisableWhenSolo);
				end,
			},
	
			toggle = {
				order = 10,
				type = "input",
				name = L["Toggle"],
				desc = L["Toggle Desc"],
				get = function(info) return L["Available Warnings"]..HunterHelper:ListWarnings() end,
				set = function(info, value)
					HunterHelper:EnableWarning(value, "toggle");
				end,
			},
			enable = {
				order = 11,
				type = "input",
				name = L["Enable"],
				desc = L["Enable Desc"],
				set = function(info, value)
					HunterHelper:EnableWarning(value, true);
				end,
			},
			disable = {
				order = 12,
				type = "input",
				name = L["Disable"],
				desc = L["Disable Desc"],
				set = function(info, value)
					HunterHelper:EnableWarning(value, false);
				end,
			},
			snooze = {
				order = 13,
				type = "input",
				name = L["Snooze"],
				desc = L["Snooze Desc"],
				set = function(info, value)
					HunterHelper:SetSnoozeTimer(value);
				end,
			},
			warnings = {
				order = 20,
				type = "description",
				name = L["Available Warnings"]..HunterHelper:ListWarnings(),
				cmdHidden = false,
			},
		}
	}
	
	-- This is to provide better error reporting feedback, and stop loading the rest of the file.
	if not AceGUIWidgetLSMlists then
		HunterHelper.noconfig = 'Cannot find a library instance of "AceGUI-3.0-SharedMediaWidgets". HunterHelper configuration will not be available.'
		assert(AceGUIWidgetLSMlists, HunterHelper.noconfig)
	end
	
	HunterHelper.Options = {
		type = "group",
		name = "HunterHelper",
		get = function(info) return HHConfig[ info[#info] ] end,
		set = function(info, value) HHConfig[ info[#info] ] = value end,
		args = {
			General = {
				order = 1,
				type = "group",
				name = L["General Settings"],
				desc = L["General Settings"],
				args = {
					SoundsEnabled = {
						order = 1,
						type = "toggle",
						name = L["Enable Sounds"],
					},
					UpdateInterval = {
						order = 2,
						type = "range",
						name = L["Update Interval"],
						desc = L["Update Interval Desc"],
						min = 0.5,
						max = 20.0,
						step = 0.5,
					},
					DisableWhenSolo = {
						order = 3,
						type = "toggle",
						name = L["Disable When Solo"],
					},
					MessageColor = {
						order = 4,
						type = "color",
						name = L["Message Color"],
						width="normal",
						hasAlpha = false,
						get = function(info)
							local t = HHConfig.MessageColor
							return t.r, t.g, t.b, 1.0
						end,
						set = function(info, r, g, b, a)
							local t = HHConfig.MessageColor
							t.r, t.g, t.b = r, g, b
						end,
					},
					DisplayMethod = {
						order = 5,
						type = "select",
						name = L["Display Method"],
						desc = L["Display Method Desc"],
						values = {
							[VNDISPLAY_NONE] = L["None"],
							[VNDISPLAY_SCT] = L["Combat Text"],
							[VNDISPLAY_RW] = L["Raid Warning"],
						},
					},
					blank = {
						order = 6,
						type = "description",
						name = " ",
					},
					MaxWarningCount = {
						order = 7,
						type = "range",
						name = L["Maximum Unique Warning Count"],
						desc = L["Maximum Unique Warning Count Desc"],
						min = 0,
						max = 30,
						step = 1,
					},
					DisplayAllWarnings = {
						order = 8,
						type = "toggle",
						name = L["Show All Active Warnings"],
						desc = L["Show All Active Warnings Desc"],
						width = "full",
					},
				}, -- End General Settings args
			}, -- End General Settings Group
	
			Warning = {
				order = 2,
				type = "group",
				name = L["General Warnings"],
	
				get = function(info) return HHConfig.Warning[info[#info-1]][info[#info]] end,
				set = function(info, value)
					local leaf = info[#info];
					local branch = info[#info-1];
					HHConfig.Warning[branch][leaf] = value
					if leaf == "Sound" then
						HunterHelper:PlaySound(value);
					end
				end,
	
				args = {
					noaspect = {
						order = 1,
						type = "group",
						name = L["No Aspect"],
						width = "full",
						args = {
							Enabled = {
								order = 1,
								type = "toggle",
								name = L["No Aspect Warning"],
								desc = L["No Aspect Warning Desc"],
								width = "full",
							},
							Sound = {
								order = 2,
								type = "select",
								name = L["Sound"],
								values = HH_SoundsList,
								width = "full",
							},
							Message = {
								order = 3,
								type = "input",
								name = L["Message"],
								width = "full",
							},
						},
					},
	
					nopet = {
						order = 2,
						type = "group",
						name = L["No Pet"],
						width = "full",
						args = {
							Enabled = {
								order = 1,
								type = "toggle",
								name = L["No Pet Warning"],
								desc = L["No Pet Warning Desc"],
								width = "full",
							},
							Sound = {
								order = 2,
								type = "select",
								name = L["Sound"],
								values = HH_SoundsList,
								width = "full",
							},
							Message = {
								order = 4,
								type = "input",
								name = L["Message"],
								width = "full",
							},
						},
					},

					pethealth = {
						order = 3,
						type = "group",
						name = L["Pet Health"],
						width = "full",
						args = {
							Enabled = {
								order = 1,
								type = "toggle",
								name = L["Pet Health Warning"],
								desc = L["Pet Health Warning Desc"],
								width = "full",
							},
							Threshold = {
								order = 2,
								type = "range",
								min = 0,
								max = 1,
								isPercent = true,
								step = 0.05,
								name = L["Health Threshold"],
								desc = L["Health Threshold Desc"],
								width = "full",
							},
							Sound = {
								order = 4,
								type = "select",
								name = L["Sound"],
								values = HH_SoundsList,
								width = "full",
							},
							Message = {
								order = 5,
								type = "input",
								name = L["Low Health Message"],
								width = "full",
							},
							sep = {
								order = 6,
								type = "description",
								name = " ",
								width = "full",
							},
							DeadEnabled = {
								order = 7,
								type = "toggle",
								name = L["Dead Warning"],
								desc = L["Dead Warning Desc"],
								width = "full",
								get = function(info) return HHConfig.Warning["petdead"].Enabled end,
								set = function(info, value)	HHConfig.Warning["petdead"].Enabled = value end,
							},								
							DeadSound = {
								order = 8,
								type = "select",
								name = L["Dead Sound"],
								values = HH_SoundsList,
								width = "full",
								get = function(info) return HHConfig.Warning["petdead"].Sound end,
								set = function(info, value)
									HHConfig.Warning["petdead"].Sound = value;
									self:PlaySound(value);
								end,
							},
							DeadMessage = {
								order = 9,
								type = "input",
								name = L["Dead Message"],
								width = "full",
								get = function(info) return HHConfig.Warning["petdead"].Message end,
								set = function(info, value)	HHConfig.Warning["petdead"].Message = value end,
							},
						},
					},
	
					passive = {
						order = 5,
						type = "group",
						name = L["Pet Passive"],
						width = "full",
						args = {
							Enabled = {
								order = 1,
								type = "toggle",
								name = L["Pet Passive Warning"],
								desc = L["Pet Passive Warning Desc"],
								width = "full",
							},
							UnlessAttacking = {
								order = 2,
								type = "toggle",
								name = L["Unless Attacking"],
								desc = L["Unless Attacking Desc"],
								width = "full",
							},
							Sound = {
								order = 3,
								type = "select",
								name = L["Sound"],
								values = HH_SoundsList,
								width = "full",
							},
							Message = {
								order = 4,
								type = "input",
								name = L["Message"],
								width = "full",
							},
						},
					},
	
					defensive = {
						order = 6,
						type = "group",
						name = L["Pet Defensive"],
						width = "full",
						args = {
							Enabled = {
								order = 1,
								type = "toggle",
								name = L["Pet Defensive Warning"],
								desc = L["Pet Defensive Warning Desc"],
								width = "full",
							},
							Sound = {
								order = 2,
								type = "select",
								name = L["Sound"],
								values = HH_SoundsList,
								width = "full",
							},
							Message = {
								order = 3,
								type = "input",
								name = L["Message"],
								width = "full",
							},
						},
					},

					assist = {
						order = 7,
						type = "group",
						name = L["Pet Assist"],
						width = "full",
						args = {
							Enabled = {
								order = 1,
								type = "toggle",
								name = L["Pet Assist Warning"],
								desc = L["Pet Assist Warning Desc"],
								width = "full",
							},
							Sound = {
								order = 2,
								type = "select",
								name = L["Sound"],
								values = HH_SoundsList,
								width = "full",
							},
							Message = {
								order = 3,
								type = "input",
								name = L["Message"],
								width = "full",
							},
						},
					},

					equipment = {
						order = 8,
						type = "group",
						name = L["Bad Equipment"],
						width = "full",
						args = {
							Enabled = {
								order = 1,
								type = "toggle",
								name = L["Bad Equipment Warning"],
								desc = L["Bad Equipment Warning Desc"],
								width = "full",
							},
							Sound = {
								order = 2,
								type = "select",
								name = L["Sound"],
								values = HH_SoundsList,
								width = "full",
							},
							Message = {
								order = 4,
								type = "input",
								name = L["Message"],
								width = "full",
							},
							MinItemLevel = {
								order = 5,
								type = "range",
								name = L["Minimum Item Level"],
								desc = L["Minimum Item Level Desc"],
								min = 0,
								max = 200,
								step = 10,
								width = "full",
							},
						},
					},

				}, -- End Warning args
			}, -- End Warning Group
	
			PetGroup = {
				order = 3,
				type = "group",
				name = L["Pet Group Behavior"],
				desc = L["Pet Group Behavior Desc"],
	
				args = {
					solo = {
						order = 1,
						type = "group",
						name = L["Solo"],
						width = "full",
						args = {
							growl = {
								order = 1,
								type = "select",
								name = L["Preferred Growl"],
								values = HunterHelper.GrowlWarningValue,
								width = "full",
								get = function(info) return HHConfig.PetGroup.Growl.solo end,
								set = function(info,value) HHConfig.PetGroup.Growl.solo = value end
							},
							stance = {
								order = 2,
								type = "select",
								name = L["Preferred Pet Stance"],
								values = HunterHelper.StanceWarningValue,
								width = "full",
								get = function(info) return HHConfig.PetGroup.Stance.solo end,
								set = function(info,value) HHConfig.PetGroup.Stance.solo = value end
							},
						},
					},
	
					smallparty = {
						order = 2,
						type = "group",
						name = L["Small Party"],
						width = "full",
						args = {
							growl = {
								order = 1,
								type = "select",
								name = L["Preferred Growl"],
								values = HunterHelper.GrowlWarningValue,
								width = "full",
								get = function(info) return HHConfig.PetGroup.Growl.smallparty end,
								set = function(info,value) HHConfig.PetGroup.Growl.smallparty = value end
							},
							stance = {
								order = 2,
								type = "select",
								name = L["Preferred Pet Stance"],
								values = HunterHelper.StanceWarningValue,
								width = "full",
								get = function(info) return HHConfig.PetGroup.Stance.smallparty end,
								set = function(info,value) HHConfig.PetGroup.Stance.smallparty = value end
							},
	
							partysize = {
								order = 4,
								type = "select",
								name = L["Small Party Size"],
								desc = L["Small Party Size Desc"],
								values = {
									[1] = "1 "..L["always large"]..")",
									[2] = "2",
									[3] = "3",
									[4] = "4",
									[5] = "5 "..L["always small"]..")",
								},
								get = function(info) return HHConfig.PetGroup.SmallPartySize end,
								set = function(info, value) HHConfig.PetGroup.SmallPartySize = value end,
								width = "full",
							},
							
							smartparty = {
								order = 5,
								type = "toggle",
								name = L["Smart Party Detection"],
								desc = L["Smart Party Desc"],
								get = function(info) return HHConfig.PetGroup.SmartParty end,
								set = function(info, value) HHConfig.PetGroup.SmartParty = value end,
								width = "full",
							},
						},
					},

					largeparty = {
						order = 3,
						type = "group",
						name = L["Large Party"],
						width = "full",
						args = {
							growl = {
								order = 1,
								type = "select",
								name = L["Preferred Growl"],
								values = HunterHelper.GrowlWarningValue,
								width = "full",
								get = function(info) return HHConfig.PetGroup.Growl.largeparty end,
								set = function(info,value) HHConfig.PetGroup.Growl.largeparty = value end
							},
							stance = {
								order = 2,
								type = "select",
								name = L["Preferred Pet Stance"],
								values = HunterHelper.StanceWarningValue,
								width = "full",
								get = function(info) return HHConfig.PetGroup.Stance.largeparty end,
								set = function(info,value) HHConfig.PetGroup.Stance.largeparty = value end
							},
						},
					},
	
					raid = {
						order = 4,
						type = "group",
						name = L["Raid"],
						width = "full",
						args = {
							growl = {
								order = 1,
								type = "select",
								name = L["Preferred Growl"],
								values = HunterHelper.GrowlWarningValue,
								width = "full",
								get = function(info) return HHConfig.PetGroup.Growl.raid end,
								set = function(info,value) HHConfig.PetGroup.Growl.raid = value end
							},
							stance = {
								order = 2,
								type = "select",
								name = L["Preferred Pet Stance"],
								values = HunterHelper.StanceWarningValue,
								width = "full",
								get = function(info) return HHConfig.PetGroup.Stance.raid end,
								set = function(info,value) HHConfig.PetGroup.Stance.raid = value end
							},
						},
					},
	
					battleground = {
						order = 5,
						type = "group",
						name = L["Battleground"],
						width = "full",
						args = {
							growl = {
								order = 1,
								type = "select",
								name = L["Preferred Growl"],
								values = HunterHelper.GrowlWarningValue,
								width = "full",
								get = function(info) return HHConfig.PetGroup.Growl.battleground end,
								set = function(info,value) HHConfig.PetGroup.Growl.battleground = value end
							},
							stance = {
								order = 2,
								type = "select",
								name = L["Preferred Pet Stance"],
								values = HunterHelper.StanceWarningValue,
								width = "full",
								get = function(info) return HHConfig.PetGroup.Stance.battleground end,
								set = function(info,value) HHConfig.PetGroup.Stance.battleground = value end
							},
						},
					},
	
					GrowlMessage = {
						order = 6,
						type = "group",
						name = L["Growling Message"],
						width = "full",
						args = {
							Message = {
								order = 1,
								type = "input",
								name = L["Message"],
								desc = L["Growling Message Desc"],
								get = function(info) return HHConfig.Warning["growling"].Message end,
								set = function(info, value) HHConfig.Warning["growling"].Message = value end,
								width = "full",
							},
							Sound = {
								order = 2,
								type = "select",
								name = L["Sound"],
								values = HH_SoundsList,
								get = function(info) return HHConfig.Warning["growling"].Sound end,
								set = function(info, value)
									HHConfig.Warning["growling"].Sound = value;
									HunterHelper:PlaySound(value);
								end,
								width = "full",
							},
						},
					},
	
					QuietMessage = {
						order = 7,
						type = "group",
						name = L["Not Growling Message"],
						width = "full",
						args = {
							Message = {
								order = 1,
								type = "input",
								name = L["Message"],
								desc = L["Not Growling Message Desc"],
								get = function(info) return HHConfig.Warning["notgrowling"].Message end,
								set = function(info, value) HHConfig.Warning["notgrowling"].Message = value end,
								width = "full",
							},
							Sound = {
								order = 2,
								type = "select",
								name = L["Sound"],
								values = HH_SoundsList,
								get = function(info) return HHConfig.Warning["notgrowling"].Sound end,
								set = function(info, value)
									HHConfig.Warning["notgrowling"].Sound = value;
									HunterHelper:PlaySound(value);
								end,
								width = "full",
							},
						},
					},
				},	-- end Pet Group Behavior group args
			}, -- end Pet Group Behavior group
			
			WarningPriority = {
				order = 3,
				type = "group",
				name = L["Warning Priority"],

				args = {
					desc = {
						order = 0,
						type = "description",
						width = "full",
						name = L["Warning Priority Desc"].."\n",
					},
					
					-- This section to be populated during initialization
				},
			}, -- end WarningPriority args
		},	-- end Options args
	};	-- end Options
end	-- end InitOptionsStructures()

----------------------------
-- Warning Priority Handling
----------------------------
function HunterHelper:PopulateWarningPriorityOptions()
	local wpo = HunterHelper.Options.args.WarningPriority.args;
	
	for wName,value in pairs(HHConfig.Warning) do
		local opt = {
			order = value.Priority,
			type = "group",
			name = wName,
			desc = HHConfig.Warning[wName].Message,
			width = "full",
			args = {
				MoveToTop = {
					order = 1,
					type = "execute",
					name = L["Move to Top"],
					func = function(info) HunterHelper:MakeTopPriority(wName) end,
				},
				MoveUp = {
					order = 2,
					type = "execute",
					name = L["Move Up"],
					func = function(info) HunterHelper:MakeHigherPriority(wName) end,
				},
				MoveDown = {
					order = 3,
					type = "execute",
					name = L["Move Down"],
					func = function(info) HunterHelper:MakeLowerPriority(wName) end,
				},
				MoveToBottom = {
					order = 4,
					type = "execute",
					name = L["Move to Bottom"],
					func = function(info) HunterHelper:MakeBottomPriority(wName) end,
				},
			},
		};

		wpo[wName] = opt;
	end
end

function HunterHelper:SetPriority(name, pri)
	HHConfig.Warning[name].Priority = pri;
	HunterHelper.Options.args.WarningPriority.args[name].order = pri;
	WarningPriority[pri] = name;
end

function HunterHelper:MakeTopPriority(warningName)
	local curPri = HHConfig.Warning[warningName].Priority;

	if curPri > 1 then
		for name,value in pairs(HHConfig.Warning) do
			if value.Priority < curPri then
				self:SetPriority(name, value.Priority + 1);
			end
		end
		
		self:SetPriority(warningName, 1);	
	end
end

function HunterHelper:MakeHigherPriority(warningName)
	local curPri = HHConfig.Warning[warningName].Priority;

	if curPri > 1 then
		for name,value in pairs(HHConfig.Warning) do
			if value.Priority == curPri - 1 then
				self:SetPriority(name, curPri);
				self:SetPriority(warningName, curPri - 1);
				break;
			end
		end
	end
end

function HunterHelper:MakeLowerPriority(warningName)
	local curPri = HHConfig.Warning[warningName].Priority;
	local maxPri = tableSize(HHConfig.Warning);

	if curPri < maxPri then
		for name,value in pairs(HHConfig.Warning) do
			if value.Priority == curPri + 1 then
				self:SetPriority(name, curPri);
				self:SetPriority(warningName, curPri + 1);
				break;
			end
		end
	end
end

function HunterHelper:MakeBottomPriority(warningName)
	local curPri = HHConfig.Warning[warningName].Priority;
	local maxPri = tableSize(HHConfig.Warning);

	if curPri < maxPri then
		for name,value in pairs(HHConfig.Warning) do
			if value.Priority > curPri then
				self:SetPriority(name, value.Priority - 1);
			end
		end
		
		self:SetPriority(warningName, maxPri);
	end
end

function HunterHelper:ResetPriorities()
	for name,val in pairs(defaults.profile.Warning) do
		self:SetPriority(name,val.Priority);
	end
end

-- /script HunterHelper:ResetPriorities();
-- /script for name,val in pairs(HHConfig.Warning) do print(name.." = "..val.Priority) end