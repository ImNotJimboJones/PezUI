function GetNitroboosted_OnLoad()
	GetNitroboostedFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	-- Slash Commands
	SlashCmdList["GetNitroboosted"] = GetNitroboosted_SlashCommands
	SLASH_GetNitroboosted1 = "/gn"
	SLASH_GetNitroboosted2 = "/getnitroboosted"
end

-- Default Settings
if GN_Solo == nil then
	GN_Solo = true
end
if GN_Party == nil then
	GN_Party = true
end
if GN_Raid == nil then
	GN_Raid = true
end
if GN_PartyInstance == nil then
	GN_PartyInstance = true
end
if GN_RaidInstance == nil then
	GN_RaidInstance = true
end
if GN_Battleground == nil then
	GN_Battleground = true
end

local CurrentZoneId
local MyZone

-- Message Format
local MessageFormat = "%s %s!"

-- Channels
local BattlegroundChannel		= "INSTANCE_CHAT"
local RaidInstanceChannel		= "INSTANCE_CHAT"
local PartyInstanceChannel		= "INSTANCE_CHAT"
local RaidChannel				= "RAID"
local PartyChannel				= "PARTY"
local SoloChannel				= "SAY"

function GetNitroboosted_OnEvent(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local eventType, destGUID, id
		if select(4, GetBuildInfo()) >= 50100 then
			BattlegroundChannel = "INSTANCE_CHAT"
			RaidInstanceChannel = "INSTANCE_CHAT"
			PartyInstanceChannel = "INSTANCE_CHAT"
			eventType, destGUID, id = select(2, ...), select(8, ...), select(12, ...)
		elseif select(4, GetBuildInfo()) >= 40200 then
			BattlegroundChannel = "BATTLEGROUND"
			RaidInstanceChannel = "RAID"
			PartyInstanceChannel = "PARTY"
			eventType, destGUID, id = select(2, ...), select(8, ...), select(12, ...)
		elseif select(4, GetBuildInfo()) >= 40100 then
			BattlegroundChannel = "BATTLEGROUND"
			RaidInstanceChannel = "RAID"
			PartyInstanceChannel = "PARTY"
			eventType, destGUID, id = select(2, ...), select(7, ...), select(10, ...)
		elseif select(4, GetBuildInfo()) >= 40000 then
			BattlegroundChannel = "BATTLEGROUND"
			RaidInstanceChannel = "RAID"
			PartyInstanceChannel = "PARTY"
			eventType, destGUID, id = select(2, ...), select(6, ...), select(9, ...)
		elseif select(4, GetBuildInfo()) >= 20400 then
			BattlegroundChannel = "BATTLEGROUND"
			RaidInstanceChannel = "RAID"
			PartyInstanceChannel = "PARTY"
			eventType, destGUID, id = select(2, ...), select(6, ...), select(9, ...)
		end

		if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then
			if select(2, IsInInstance()) == "pvp" then
				if GN_Battleground == true then
					if eventType == "SPELL_AURA_APPLIED" then
						if id == 94794 and destGUID == UnitGUID("player") then
							local Message = format(MessageFormat, GetSpellLink(id), GN_OnMe)
							SendChatMessage(Message, BattlegroundChannel)
						end
					end
				end
			elseif select(2, IsInInstance()) == "raid" then
				if GN_RaidInstance == true then
					if eventType == "SPELL_AURA_APPLIED" then
						if id == 94794 and destGUID == UnitGUID("player") then
							local Message = format(MessageFormat, GetSpellLink(id), GN_OnMe)
							SendChatMessage(Message, RaidInstanceChannel)
						end
					end
				end
			elseif select(2, IsInInstance()) == "party" then
				if GN_PartyInstance == true then
					if eventType == "SPELL_AURA_APPLIED" then
						if id == 94794 and destGUID == UnitGUID("player") then
							local Message = format(MessageFormat, GetSpellLink(id), GN_OnMe)
							SendChatMessage(Message, PartyInstanceChannel)
						end
					end
				end
			elseif select(2, IsInInstance()) == nil then
				if GN_PartyInstance == true then
					if eventType == "SPELL_AURA_APPLIED" then
						if id == 94794 and destGUID == UnitGUID("player") then
							local Message = format(MessageFormat, GetSpellLink(id), GN_OnMe)
							SendChatMessage(Message, PartyInstanceChannel)
						end
					end
				end
			end
		else
			if IsInRaid() == true then
				if GN_Raid == true then
					if eventType == "SPELL_AURA_APPLIED" then
						if id == 94794 and destGUID == UnitGUID("player") then
							local Message = format(MessageFormat, GetSpellLink(id), GN_OnMe)
							SendChatMessage(Message, RaidChannel)
						end
					end
				end
			elseif GetNumSubgroupMembers() ~= nil and GetNumSubgroupMembers() > 0 then
				if GN_Party == true then
					if eventType == "SPELL_AURA_APPLIED" then
						if id == 94794 and destGUID == UnitGUID("player") then
							local Message = format(MessageFormat, GetSpellLink(id), GN_OnMe)
							SendChatMessage(Message, PartyChannel)
						end
					end
				end
			elseif select(2, IsInInstance()) == "none" then
				if GN_Solo == true then
					if eventType == "SPELL_AURA_APPLIED" then
						if id == 94794 and destGUID == UnitGUID("player") then
							local Message = format(MessageFormat, GetSpellLink(id), GN_OnMe)
							SendChatMessage(Message, SoloChannel)
						end
					end
				end
			end
		end
	end
end

function GetNitroboosted_SlashCommands(arg1)
	local arg1 = string.lower(arg1)
	if arg1 == "" then
		GetNitroboosted_PrintSlashMenu()
	elseif arg1 == "party" then
		GN_Party = not GN_Party
		if GN_Party == true then
			print("|cFF50C0FF"..GN_Opt_Party..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
		else
			print("|cFF50C0FF"..GN_Opt_Party..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
		end
	elseif arg1 == "raid" then
		GN_Raid = not GN_Raid
		if GN_Raid == true then
			print("|cFF50C0FF"..GN_Opt_Raid..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
		else
			print("|cFF50C0FF"..GN_Opt_Raid..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
		end
	elseif arg1 == "partyinstance" or arg1 == "party instance" or arg1 == "partyi" then
		GN_PartyInstance = not GN_PartyInstance
		if GN_PartyInstance == true then
			print("|cFF50C0FF"..GN_Opt_PartyInstance..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
		else
			print("|cFF50C0FF"..GN_Opt_PartyInstance..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
		end
	elseif arg1 == "raidinstance" or arg1 == "raid instance" or arg1 == "raidi" then
		GN_RaidInstance = not GN_RaidInstance
		if GN_RaidInstance == true then
			print("|cFF50C0FF"..GN_Opt_RaidInstance..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
		else
			print("|cFF50C0FF"..GN_Opt_RaidInstance..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
		end
	elseif arg1 == "battleground" or arg1 == "bg" then
		GN_Battleground = not GN_Battleground
		if GN_Battleground == true then
			print("|cFF50C0FF"..GN_Opt_Battleground..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
		else
			print("|cFF50C0FF"..GN_Opt_Battleground..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
		end
	elseif arg1 == "solo" then
		GN_Solo = not GS_Solo
		if GN_Solo == true then
			print("|cFF50C0FF"..GN_Opt_Solo..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
		else
			print("|cFF50C0FF"..GN_Opt_Solo..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
		end
	else
		GetNitroboosted_PrintSlashHelp()
	end
end

function GetNitroboosted_PrintSlashHelp()
	print("|cFFFFA500GetNitroboosted "..GetAddOnMetadata("GetNitroboosted", "Version").." "..GN_Opt_CmdList.."|cFFFFFFFF")
	print("|cFF50C0FF/gn - |cFFFFFFA0"..GN_Opt_HelpStatus.."|cFFFFFFFF")
	print("|cFF50C0FF/gn solo - |cFFFFFFA0"..GN_Opt_HelpSolo.."|cFFFFFFFF")
	print("|cFF50C0FF/gn party - |cFFFFFFA0"..GN_Opt_HelpParty.."|cFFFFFFFF")
	print("|cFF50C0FF/gn raid - |cFFFFFFA0"..GN_Opt_HelpRaid.."|cFFFFFFFF")
	print("|cFF50C0FF/gn partyi - |cFFFFFFA0"..GN_Opt_HelpPartyInstance.."|cFFFFFFFF")
	print("|cFF50C0FF/gn raidi - |cFFFFFFA0"..GN_Opt_HelpRaidInstance.."|cFFFFFFFF")
	print("|cFF50C0FF/gn bg - |cFFFFFFA0"..GN_Opt_HelpBattleground.."|cFFFFFFFF")
end

function GetNitroboosted_PrintSlashMenu()
	print("|cFFFFA500GetNitroboosted "..GetAddOnMetadata("GetNitroboosted", "Version").." "..GN_Opt_HelpInput.."|cFFFFFFFF")
	if GN_Solo == true then
		print("|cFF50C0FF"..GN_Opt_Solo..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
	else
		print("|cFF50C0FF"..GN_Opt_Solo..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
	end
	if GN_Party == true then
		print("|cFF50C0FF"..GN_Opt_Party..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
	else
		print("|cFF50C0FF"..GN_Opt_Party..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
	end
	if GN_Raid == true then
		print("|cFF50C0FF"..GN_Opt_Raid..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
	else
		print("|cFF50C0FF"..GN_Opt_Raid..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
	end
	if GN_PartyInstance == true then
		print("|cFF50C0FF"..GN_Opt_PartyInstance..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
	else
		print("|cFF50C0FF"..GN_Opt_PartyInstance..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
	end
	if GN_RaidInstance == true then
		print("|cFF50C0FF"..GN_Opt_RaidInstance..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
	else
		print("|cFF50C0FF"..GN_Opt_RaidInstance..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
	end
	if GN_Battleground == true then
		print("|cFF50C0FF"..GN_Opt_Battleground..": |cFFADFF2F"..GN_Opt_Enable.."|cFFFFFFFF")
	else
		print("|cFF50C0FF"..GN_Opt_Battleground..": |cFFFF4500"..GN_Opt_Disable.."|cFFFFFFFF")
	end
end