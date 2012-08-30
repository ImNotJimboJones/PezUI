local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local format = format
local CombatLog_Object_IsA = CombatLog_Object_IsA
local IsPlayerSpell = IsPlayerSpell
local IsSpellKnown = IsSpellKnown
local GetSpellLink = GetSpellLink
local UnitAffectingCombat = UnitAffectingCombat
local UnitAura = UnitAura

local COMBATLOG_FILTER_ME = COMBATLOG_FILTER_ME

-- mobs whose received hits won't be tracked due to various vulnerabilities
local specialMobs = {
	[12460] = true,	-- Death Talon Wyrmguard
	[12461] = true,	-- Death Talon Overseer
	[14020] = true,	-- Chromaggus
	[15339] = true,	-- Ossirian the Unscarred
	[15928] = true,	-- Thaddius
	[16803] = true, -- Death Knight Understudy
	[22841] = true,	-- Shade of Akama
	[33329] = true, -- Heart of the Deconstructor
	[33670] = true, -- Aerial Command Unit
	[34496] = true, -- Eydis Darkbane
	[34497] = true, -- Fjola Lightbane
	[38567] = true, -- Phantom Hallucination
	[40484] = true, -- Erudax
	[42347] = true, -- Exposed Head of Magmaw ?
	[42803] = true, -- Drakeadon Mongrel
	[46083] = true, -- Drakeadon Mongrel
	[46273] = true, -- Debilitated Apexar
	[48270] = true, -- Exposed Head of Magmaw
	[52155] = true, -- High Priest Venoxis
	[54191] = true, -- Risen Ghoul (End Time)
}

-- auras that when gained will suppress record tracking
local specialAuras = {
	[23768] = true, -- Sayge's Dark Fortune of Damage
	[24378] = true, -- Berserking (battlegrounds)
	[53642] = true,	-- Might of Mograine (Light's Hope Chapel)
	[56330] = true,	-- Iron's Bane (Storm Peaks quest)
	[57524] = true, -- Metanoia (Valkyrion Aspirant)
	[58026] = true,	-- Blessing of the Crusade (Icecrown quest)
	[58361] = true,	-- Might of Mograine (Patchwerk)
	[58549] = true,	-- Tenacity (Lake Wintergrasp)
	[59641] = true,	-- Warchief's Blessing (The Battle For The Undercity)
	[60964] = true,	-- Strength of Wrynn (The Battle For The Undercity)
	[81096] = true, -- Red Mist (Red Mist)
	[84719] = true, -- Beach Head Control (Twilight Shore - Alliance)
	[84720] = true, -- Beach Head Control (Twilight Shore - Horde)
	[86872] = true, -- Frothing Rage (Thundermar Ale)
	[93777] = true, -- Invocation of Flame (Skullcrusher the Mountain)
	[93778] = true, -- Invocation of Flame (Elemental Bonds: Fury)
	
	-- The Deadmines
	[90932] = true, -- Ragezone (Defias Blood Wizard)
	[90933] = true, -- Ragezone (Defias Blood Wizard heroic)
	
	-- Blackwing Lair
	[18173] = true,	-- Burning Adrenaline (Vaelastrasz the Corrupt)
	
	-- Magister's Terrace
	[44335] = true,	-- Energy Feedback (Vexallus)
	[44406] = true,	-- Energy Infusion (Vexallus)
	
	-- Karazhan
	[30402] = true, -- Nether Beam - Dominance (Netherspite)
	-- Black Temple
	[40604] = true, -- Fel Rage (Gurtogg Bloodboil)
	[40880] = true, -- Prismatic Aura: Shadow (Mother Shahraz)
	[40882] = true, -- Prismatic Aura: Fire (Mother Shahraz)
	[40883] = true, -- Prismatic Aura: Nature (Mother Shahraz)
	[40891] = true, -- Prismatic Aura: Arcane (Mother Shahraz)
	[40896] = true, -- Prismatic Aura: Frost (Mother Shahraz)
	[40897] = true, -- Prismatic Aura: Holy (Mother Shahraz)
	[41337] = true,	-- Aura of Anger (Reliquary of Souls)
	[41350] = true,	-- Aura of Desire (Reliquary of Souls)
	[41406] = true, -- Dementia (Priestess of Dementia)
	
	-- Ahn'kahet: The Old Kingdom
	[56648] = true,	-- Potent Fungus (Amanitar)
	-- The Eye of Eternity
	[55849] = true,	-- Power Spark (Malygos)
	-- Ulduar
	[61888] = true, -- Overwhelming Power (Assembly of Iron 25)
	[62243] = true, -- Unstable Sun Beam (Elder Brightleaf)
	[62650] = true, -- Fortitude of Frost (Yogg-Saron)
	[62670] = true, -- Resilience of Nature (Yogg-Saron)
	[62671] = true, -- Speed of Invention (Yogg-Saron)
	[62702] = true, -- Fury of the Storm (Yogg-Saron)
	[63138] = true, -- Sara's Fervor (Yogg-Saron)
	[63277] = true, -- Shadow Crash (General Vezax)
	[63711] = true, -- Storm Power (Hodir 10)
	[64320] = true, -- Rune of Power (Assembly of Iron)
	[64321] = true, -- Potent Pheromones (Freya)
	[64637] = true, -- Overwhelming Power (Assembly of Iron 10)
	[65134] = true, -- Storm Power (Hodir 25)
	-- Icecrown Citadel
	[70227] = true, -- Empowered Blood (Empowered Orb)
	[70867] = true, -- Essence of the Blood Queen (Blood Queen Lana'thel)
	[70879] = true, -- Essence of the Blood Queen (Blood Queen Lana'thel, bitten by a player)
	[71532] = true, -- Essence of the Blood Queen (Blood Queen Lana'thel heroic)
	[72219] = true, -- Gastric Bloat (Festergut)
	[73822] = true, -- Hellscream's Warsong (Icecrown Citadel)
	[73828] = true, -- Strength of Wrynn (Icecrown Citadel) 
	
	-- Throne of the Tides
	[76133] = true, -- Tidal Surge (Neptulon)
	[76155] = true, -- Tidal Surge (Neptulon)
	-- Grim Batol
	[76693] = true, -- Empowering Twilight (Crimsonborne Warlord)
	[90707] = true, -- Empowering Twilight 
	-- Halls of Origination
	[76159] = true, -- Pyrogenics (Sun-Touched Spriteling)
	[76355] = true, -- Blessing of the Sun (Rajh)
	[89879] = true, -- Blessing of the Sun (Rajh heroic)
	-- Lost City of the Tol'vir
	[91871] = true, -- Lightning Charge (Siamat)
	-- Zul'Gurub
	[96493] = true, -- Spirit's Vengeance (Bloodlord Mandokir)
	[96494] = true, -- Spirit's Vengeance (Bloodlord Mandokir)
	[96802] = true, -- Bethekk's Blessing (Lesser Priest of Bethekk)
	-- Hour of Twilight
	[103744] = true, -- Water Shell (Thrall)
	[103817] = true, -- Rising Fire
	-- Well of Eternity
	[102994] = true, -- Shadow Walk (Illidan Stormrage)
	[103018] = true, -- Shadow Ambusher (Illidan Stormrage)
	[103020] = true, -- Shadow Walk (Illidan Stormrage)
	
	-- Bastion of Twilight
	[82170] = true, -- Corruption: Absolute (Cho'gall)
	[86622] = true, -- Engulfing Magic (Theralion) ?
	[95639] = true, -- Engulfing Magic (Theralion) ?
	[95640] = true, -- Engulfing Magic (Theralion) ?
	[95641] = true, -- Engulfing Magic (Theralion) ?
	-- Blackwing Descent
	[79624] = true, -- Power Generator (Arcanotron) ?
	[79629] = true, -- Power Generator (Arcanotron 10)
	[80718] = true, -- Burden of the Crown (Spirit of Corehammer)
	[91555] = true, -- Power Generator (Arcanotron 25)
	[91556] = true, -- Power Generator (Arcanotron 10 heroic)
	-- Firelands
	[98245] = true, -- Legendary Concentration (Majordomo Staghelm)
	[98252] = true, -- Epic Concentration (Majordomo Staghelm)
	[98253] = true, -- Rare Concentration (Majordomo Staghelm)
	[98254] = true, -- Uncommon Concentration (Majordomo Staghelm)
	[99389] = true, -- Imprinted (Voracious Hatchling)
	[99762] = true, -- Flames of the Firehawk (Inferno Firehawk)
	[100359] = true, -- Imprinted (Voracious Hatchling)
	-- Dragon Soul
	[106029] = true, -- Kalecgos' Presence (no event)
	[107770] = true, -- Pure Water
	[109457] = true, -- Ysera's Presence (no event) ?
	[109606] = true, -- Kalecgos' Presence (LFR - no event)
	[109640] = true, -- Ysera's Presence (LFR - no event)
}

-- these are auras that increases the target's damage or healing received
local targetAuras = {
	[82840] = true, -- Vulnerable (Deepstone Elemental)
	[95723] = true, -- Storm's Fury (Ragnaros - Mount Hyjal) ?
	[96960] = true, -- Antlers of Malorne (Galenges)
	
	-- Sunwell Plateau
	[46287] = true, -- Infernal Defense (Apocalypse Guard)
	[46474] = true, -- Sacrifice of Anveena (Kil'jaeden)
	-- Ulduar
	[64436] = true, -- Magnetic Core (Aerial Command Unit) -- no event
	[65280] = true, -- Singed (Hodir)
	-- Trial of the Crusader
	[66758] = true, -- Staggered Daze (Icehowl) ?
	
	-- Blackrock Caverns
	[75846] = true, -- Superheated Quicksilver Armor (Karsh Steelbender) ?
	[76015] = true, -- Superheated Quicksilver Armor (Karsh Steelbender) ?
	[76232] = true, -- Storm's Fury (Ragnaros - Mount Hyjal) ?
	[93567] = true, -- Superheated Quicksilver Armor (Karsh Steelbender) ?
	-- Grim Batol
	[75664] = true, -- Shadow Gale (Erudax) ?
	[76415] = true, -- Dizzy (Twilight Enforcer - normal)
	-- [91086] = true, -- Shadow Gale (Erudax heroic) -- no event
	[90666] = true, -- Dizzy (Twilight Enforcer - heroic)
	-- Zul'Gurub
	[97320] = true, -- Sunder Rift (Jin'do the Godbreaker)
	-- End Time
	[101602] = true, -- Throw Totem (Echo of Baine)
	
	-- Bastion of Twilight
	[87683] = true, -- Dragon's Vengeance (Halfus Wyrmbreaker)
	-- Blackwing Descent
	[77615] = true, -- Debilitating Slime (Maloriak)
	[77717] = true, -- Vertigo (Atramedes 10)
	[80164] = true, -- Chemical Cloud (Toxitron)
	[91478] = true, -- Chemical Cloud (Toxitron 25) ?
	[91479] = true, -- Chemical Cloud (Toxitron 10 heroic)
	[92389] = true, -- Vertigo (Atramedes 25) ?
	[92390] = true, -- Vertigo (Atramedes 10 heroic)
	[92910] = true, -- Debilitating Slime (Maloriak) ?
	-- Throne of the Four Winds
	[87904] = true, -- Feedback (Al'Akir)
	[101458] = true, -- Feedback (Al'Akir 25) ?
	[101460] = true, -- Feedback (Al'Akir 25 heroic)
	-- Firelands
	[98596] = true, -- Infernal Rage (Spark of Rhyolith)
	[99432] = true, -- Burnout (Alysrazor)
	-- Dragon Soul
	[104031] = true, -- Void Diffusion (Warlord Zon'ozz)
	[106588] = true, -- Expose Weakness (Deathwing)
	[106600] = true, -- Expose Weakness (Deathwing)
	[106613] = true, -- Expose Weakness (Deathwing)
	[106624] = true, -- Expose Weakness (Deathwing)
	[108934] = true, -- Feedback (Hagara the Stormbinder)
	[109582] = true, -- Expose Weakness (Deathwing, Alexstrasza - LFR)
	[109619] = true, -- Expose Weakness (Deathwing, Nozdormu - LFR)
	[109637] = true, -- Expose Weakness (Deathwing, Ysera - LFR)
	[109728] = true, -- Expose Weakness (Deathwing, Kalecgos - LFR)
}

local mt = {
	__index = function(tbl, key)
		local newTbl = {}
		tbl[key] = newTbl
		return newTbl
	end
}

local ignoreEncounter
local isEmpowered = {
	player = false,
	pet = false,
}
local corruptSpells = {
	player = setmetatable({}, mt),
	pet = setmetatable({}, mt),
}

local corruptTargets = setmetatable({}, mt)
local ignoredTargets = {}

-- user added filter rules
local customPlayerSpells, excludedSpells, customFilteredAuras, customFilteredMobs


local defaults = {
	profile = {
		filterNew = false,
		onlyKnown = false,
		ignoreMobFilter = false,
		ignoreAuraFilter = false,
		suppressMC = true,
		dontFilterMagic = false,
		levelFilter = -1,
	},
	global = {
		include = {},
		exclude = {},
		auras = {},
		mobs = {},
	},
}

local filters = CreateFrame("Frame")
filters:SetScript("OnEvent", function(self, event, ...)
	return self[event] and self[event](self, ...)
end)
addon.filters = filters

function filters:AddonLoaded()
	self.db = addon.db:RegisterNamespace("filters", defaults)
	addon.RegisterCallback(self, "SettingsLoaded", "LoadSettings")
	
	self:RegisterUnitEvent("UNIT_AURA", "player", "pet")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("UNIT_NAME_UPDATE")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_CONTROL_LOST")
	self:RegisterEvent("PLAYER_CONTROL_GAINED")
	
	local global = self.db.global
	
	-- convert from < 4.5.0 arrays
	if type(global.auras[1]) == "string" or type(global.mobs[1]) == "string" then
		local auras = {}
		for i, aura in ipairs(global.auras) do
			auras[aura] = true
		end
		global.auras = auras
		
		local mobs = {}
		for i, mob in ipairs(global.mobs) do
			mobs[mob] = true
		end
		global.mobs = mobs
	end

	customPlayerSpells = global.include
	excludedSpells = global.exclude
	customFilteredAuras = global.auras
	customFilteredMobs = global.mobs
	
	self.AddonLoaded = nil
end

addon.RegisterCallback(filters, "AddonLoaded")

function filters:LoadSettings()
	self.profile = self.db.profile
	self:LoadOptions()
end

function filters:COMBAT_LOG_EVENT_UNFILTERED(timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, spellID, spellName)
	if (eventType == "SPELL_AURA_REMOVED" or eventType == "SPELL_AURA_BROKEN" or eventType == "SPELL_AURA_BROKEN_SPELL" or eventType == "SPELL_AURA_STOLEN") then
		if targetAuras[spellID] and rawget(corruptTargets, destGUID)[spellID] then
			corruptTargets[destGUID][spellID] = nil
			addon:Debug(format("Filtered aura (%s) faded from %s.", spellName, destName))
		end
	end
	
	if eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_AURA_APPLIED_DOSE" or eventType == "SPELL_AURA_REFRESH" then
		-- if this is one of the damage-taken-increased auras, we flag this target - along with the aura in question - as corrupt
		if targetAuras[spellID] then
			corruptTargets[destGUID][spellID] = true
			ignoredTargets[destGUID] = true
			addon:Debug(format("Target (%s) gained filtered aura. (%s) Ignore received damage.", destName, spellName))
		end
		
		-- auras applied by self
		local sourceUnit = self:GetUnit(sourceFlags, sourceGUID)
		if sourceUnit then
			corruptSpells[sourceUnit][spellID][destGUID] = self:IsEmpowered(sourceUnit) or self:IsVulnerableTarget(destGUID)
		end
	end
end

function filters:UNIT_AURA(unit)
	if (unit == "player" or unit == "pet") and not (isEmpowered[unit] and UnitAffectingCombat(unit)) then
		if self:ScanAuras(unit) then
			addon:Debug("Filtered aura detected. Disabling combat log tracking.")
		end
	end
end

function filters:PLAYER_LOGIN()
	self:ScanAuras()
	self:CheckPlayerControl()
end

-- first reliable event where unit aura API works on login
function filters:UNIT_NAME_UPDATE()
	self:ScanAuras()
	self:CheckPlayerControl()
	self:UnregisterEvent("UNIT_NAME_UPDATE")
end

function filters:PLAYER_REGEN_ENABLED()
	if not self:ScanAuras() then
		addon:Debug("Encounter ended and no filtered auras detected. Resuming record tracking.")
	end
end

function filters:PLAYER_REGEN_DISABLED()
	if self:ScanAuras() then
		addon:Debug("Encounter started and filtered auras detected. Suppressing new records for this encounter.")
	end
	for unit, v in pairs(ignoredTargets) do
		if not self:IsVulnerableTarget(unit) then
			ignoredTargets[unit] = nil
			corruptTargets[unit] = nil
		end
	end
end

function filters:PLAYER_CONTROL_LOST()
	self.inControl = false
	addon:Debug("Lost control. Disabling combat log tracking.")
end

function filters:PLAYER_CONTROL_GAINED()
	self.inControl = true
	addon:Debug("Regained control. Resuming combat log tracking.")
end

local auraTypes = {
	BUFF = "HELPFUL",
	DEBUFF = "HARMFUL",
}

function filters:ScanAuras(unit)
	if not unit then
		self:ScanAuras("player")
		self:ScanAuras("pet")
		return
	end
	
	if self.profile.ignoreAuraFilter then
		return
	end
	
	for auraType, filter in pairs(auraTypes) do
		for i = 1, 40 do
			local spellName, _, _, _, _, _, _, source, _, _, spellID = UnitAura(unit, i, filter)
			if not spellID then break end
			self:UnregisterEvent("UNIT_NAME_UPDATE")
			if self:IsFilteredAura(spellID) then
				isEmpowered[unit] = true
				return true
			end
		end
	end
	
	isEmpowered[unit] = false
end

function filters:CheckPlayerControl()
	self.inControl = HasFullControl()
	if not self.inControl then
		addon:Debug("Lost control. Disabling combat log tracking.")
	end
end

local function debugSpell(spellID, reason)
	addon:Debug(format("Skipped %s (%d). %s.", GetSpellLink(spellID), spellID, reason))
end

local function debugTarget(guid, name, reason)
	addon:Debug(format("Skipped target |cffffd200|Hunit:%s:%s|h[%s]|h|r. %s.", guid, name, name, reason))
end

-- check if a spell passes the filter settings
function filters:SpellPassesFilters(tree, spellName, spellID, isPeriodic, destGUID, destName, school, targetLevel, rawID)
	local isPet = tree == "pet"
	
	if excludedSpells[rawID] or excludedSpells[spellName] then
		debugSpell(rawID, "Is excluded")
		return
	end
	
	if self.profile.onlyKnown and not (customPlayerSpells[spellID] or customPlayerSpells[spellName]) then
		if isPet then
			if not (IsSpellKnown(spellID, isPet) or spellID == 6603) then
				debugSpell(spellID, "Not in pet's spell book")
				return
			end
		elseif not IsPlayerSpell(spellID) then
			debugSpell(spellID, "Not in spell book")
			return
		end
	end
	
	local unit = isPet and "pet" or "player"
	if ((rawget(corruptSpells[unit], spellID) and corruptSpells[unit][spellID][destGUID]) or self:IsEmpowered(unit)) and not self.profile.ignoreAuraFilter then
		debugSpell(spellID, "Filtered auras are active")
		return
	end
	
	if self:IsIgnoredTarget(destGUID) and not self.profile.ignoreAuraFilter then
		debugTarget(destGUID, destName, "Affected by filtered auras")
		return
	end
	
	local levelDiff = 0
	if (targetLevel > 0) and (targetLevel < UnitLevel("player")) then
		levelDiff = (UnitLevel("player") - targetLevel)
	end
	
	-- ignore level adjustment if magic damage and the setting is enabled
	if not isHeal and (self.profile.levelFilter >= 0) and (self.profile.levelFilter < levelDiff) and (school == 1 or not self.profile.dontFilterMagic) then
		-- target level is too low to pass level filter
		debugTarget(destGUID, destName, format("Too low level (%d) and damage school is filtered", targetLevel))
		return
	end
	
	if self:IsFilteredTarget(destName, destGUID) then
		debugTarget(destGUID, destName, "In mob filter")
		return
	end
	
	return true, self:IsFilteredSpell(tree, spellID, isPeriodic and 2 or 1)
end

function filters:FilterSpell(filter, tree, data)
	data.filtered = filter
	addon:GetSpellInfo(tree, data.id, data.periodic).filtered = filter
	addon:UpdateTopRecords(tree)
	addon:UpdateRecords(tree)
end

-- adds an aura to the aura filter
function filters:AddAura()
	-- after we add an aura to the filter; check if we have it
	if self:ScanAuras() then
		addon:Debug("Filtered aura detected. Disabling combat log tracking.")
	end
end

function filters:RemoveAura()
	if not self:ScanAuras("player") then
		addon:Debug("No filtered aura detected on player. Resuming record tracking.")
	end
	if not self:ScanAuras("pet") then
		addon:Debug("No filtered aura detected on pet. Resuming record tracking.")
	end
end

local filterTypes = {
	include = {
		name = L["included spells"],
	},
	exclude = {
		name = L["excluded spells"],
	},
	auras = {
		name = L["aura filter"],
		check = "IsFilteredAura",
		add = "AddAura",
		remove = "RemoveAura",
	},
	mobs = {
		name = L["mob filter"],
		check = "IsFilteredTarget",
	}
}

function filters:AddFilterEntry(type, value)
	local filter = self.db.global[type]
	local filterData = filterTypes[type]
	local check = filters[filterData.check]
	if (check and check(filters, value)) or filter[value] then
		addon:Message(L["%s is already in %s."]:format(value, filterData.name))
		return
	end
	filter[value] = true
	self.scrollFrame:Update()
	addon:Message(L["%s added to %s."]:format(value, filterData.name))
	local func = filters[filterData.add]
	if func then
		func(filters)
	end
end

function filters:RemoveFilterEntry(type, value)
	self.db.global[type][value] = nil
	local func = filters[filterTypes[type].remove]
	if func then
		func(filters)
	end
end

-- check if a spell will be filtered out
function filters:IsFilteredSpell(tree, spellID, periodic)
	local spell = addon:GetSpellInfo(tree, spellID, periodic)
	return (not spell and self.db.profile.filterNew) or (spell and spell.filtered)
end

function filters:ResetEmpowered()
	isEmpowered.player = false
	isEmpowered.pet = false
end

-- scan for filtered auras from the specialAuras table
function filters:IsEmpowered(unit)
	if isEmpowered[unit] or (unit == "player" and not self.inControl) then
		return true
	end
end

-- checks if a target will be ignored based on current or recent vulnerability
function filters:IsIgnoredTarget(guid)
	return ignoredTargets[guid]
end

-- checks if a target is affected by any vulnerability auras
function filters:IsVulnerableTarget(guid)
	if next(corruptTargets[guid]) then
		return true
	end
end

function filters:IsFilteredTarget(targetName, guid)
	-- GUID is provided if the function was called from the combat event handler
	return (guid and not self.profile.ignoreMobFilter and specialMobs[tonumber(guid:sub(7, 10), 16)]) or customFilteredMobs[targetName]
end

function filters:IsFilteredAura(spellID)
	return specialAuras[spellID] or customFilteredAuras[spellID]
end

function filters:GetUnit(unitFlags, unitGUID)
	if CombatLog_Object_IsA(unitFlags, COMBATLOG_FILTER_ME) then
		return "player"
	elseif addon:IsMyPet(unitFlags, unitGUID) then
		return "pet"
	end
end