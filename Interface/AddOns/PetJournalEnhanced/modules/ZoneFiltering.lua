local ZoneFiltering = PetJournalEnhanced:NewModule("ZoneFiltering")
local zoneIDs = PetJournalEnhanced:GetModule("ZoneIDs")

local ZoneGroupNames = {GetMapContinents()}
table.insert(ZoneGroupNames,"Instances")
ZoneFiltering.ZoneGroupNames = ZoneGroupNames


function ZoneFiltering:OnInitialize()
	local ZoneToSpecies = {}
	
	--create temporary mapping between zones and species to figure out which zones contain pets
	local SpeciesToZoneId = zoneIDs.SpeciesToZoneId
	for speciesID,zones in pairs(SpeciesToZoneId) do
		for zoneID,_ in pairs(zones) do
			if not ZoneToSpecies[zoneID] then ZoneToSpecies[zoneID] = true end
		end
	end
	
	--remove empty zones from zone groups
	local zoneGroups = zoneIDs.continents
	for i=1, #zoneGroups do
		for j=#zoneGroups[i], 1,-1  do
			local zoneID = zoneGroups[i][j]
			if not ZoneToSpecies[zoneID] then
				table.remove(zoneGroups[i],j)
			end
		end
	end
	
	--create a way to store which zones are being filtered
	self.zoneFilter = {}
	
	for zoneGroup = 1, #zoneGroups do
		for zoneIndex = 1, #zoneGroups[zoneGroup] do
			local zoneID = zoneGroups[zoneGroup][zoneIndex]
			self.zoneFilter[zoneID] = true
		end
	end
end

function ZoneFiltering:GetNumZoneGroups()
	return #ZoneGroupNames
end

function ZoneFiltering:GetZoneGroupNames(groupID)
	assert(type(groupID) == "number")
	return ZoneGroupNames[groupID]
end

function ZoneFiltering:GetZoneGroupMapping()
	return zoneIDs.continents
end

function ZoneFiltering:GetZoneGroup(groupID)
	return zoneIDs.continents[groupID]
end

function ZoneFiltering:GetZonesBySpeciesID(speciesID)
	return zoneIDs.SpeciesToZoneId[speciesID] 
end

function ZoneFiltering:SetFiltered(zoneID,enabled)
	self.zoneFilter[zoneID] = enabled
end

function ZoneFiltering:GetFiltered(zoneID)
	return self.zoneFilter[zoneID]
end

function ZoneFiltering:SetAllFiltered(enabled)
	for k,_ in pairs(self.zoneFilter) do
		self.zoneFilter[k]= enabled
	end
end

function ZoneFiltering:SetAllGroupFiltered(groupID,enabled)
	local zones = zoneIDs.continents[groupID]
	if not zones then return end
	
	for i=1, #zones do
		local zoneID = zones[i]
		self.zoneFilter[zoneID]= enabled
	end
end






