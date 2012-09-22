-------------------------------------------------------
-- ************************************************* --
-- **********  GIMPLIST ADDON by DRKAZZA  ********** --
-- ************************************************* --
-------------------------------------------------------


-- ---------------------
-- Declare the addons and libraries
-- ---------------------
local Gimplist = LibStub("AceAddon-3.0"):NewAddon("Gimplist", "AceHook-3.0", "AceEvent-3.0", "AceConsole-3.0", "AceComm-3.0", "AceSerializer-3.0")
local GUI = LibStub("AceGUI-3.0")
local icon = LibStub("LibDBIcon-1.0", true)
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local L = LibStub("AceLocale-3.0"):GetLocale("Gimplist")
local VERSION = 410

-- ---------------------
-- This is the Lib Data Broker stuff
-- ---------------------
GimplistFrame = CreateFrame("Frame", "GimplistFrame")
GimplistFrame.obj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("Gimplist", {
	type = "data source",
	text = "Gimplist",
	icon = "Interface\\Icons\\Inv_valentinepinkrocket", -- supposed to look like a bellend!
	OnClick = function(clickedframe, button)
		if button == "LeftButton" then
			Gimplist:BuildGimpBrowser() 
		elseif button == "RightButton" then
			Gimplist:AddGimp()			
		end
	end,
})
 
-- ---------------------
-- Declare defaults which include the structure of the gimp list in the database
-- ---------------------
local defaults = {
	profile = {
		gimps = { },
		minimap = {
			hide = false,
		},
		chatenable = true,
		tooltipenable = true,
		recentlistsize = 10,
		partysilence = false,
		battlegroundsilence = true,
		chatmenus = true,
		partypopup = false, 
		partysound = true, 
	},

} -- Syntax will be profile.gimps.realm.name = {note, title}

-- ---------------------
-- Declare the options menu stuff
-- ---------------------
local options = {
	type = "group", 
	name = "Gimplist",
	args = {
		minimapIcon = {
			type = "toggle",
			width = "full",
			name = L["minimap text"],
			desc = L["minimap desc"],
			order = 10, 
			get = function() return not Gimplist.db.profile.minimap.hide end,
			set = function(info, value) Gimplist:ToggleMinimap(value) end,
		},
		chatTitles = {
			type = "toggle",
			width = "full",
			name = L["chat text"],
			desc = L["chat desc"],
			order = 20, 
			get = function() return Gimplist.db.profile.chatenable end,
			set = function(info, value) Gimplist.db.profile.chatenable = value end,				
		},
		tooltipTitles = {
			type = "toggle",
			width = "full",
			name = L["tooltip text"],
			desc = L["tooltip desc"],
			order = 30, 
			get = function() return Gimplist.db.profile.tooltipenable end,
			set = function(info, value) Gimplist.db.profile.tooltipenable = value end,				
		},
		partyJoinSilence = {
			type = "toggle",
			width = "full",
			name = L["party text"],
			desc = L["party desc"],
			order = 41, 
			get = function() return Gimplist.db.profile.partysilence end,
			set = function(info, value) Gimplist.db.profile.partysilence = value end,				
		},
		battlegroundSilence = {
			type = "toggle",
			width = "full",
			name = L["battleground text"],
			desc = L["battleground desc"],
			order = 42, 
			disabled = function(info) return Gimplist.db.profile.partysilence end,
			get = function() return Gimplist.db.profile.battlegroundsilence end,
			set = function(info, value) Gimplist.db.profile.battlegroundsilence = value end,				
		},
		partyJoinPopup = {
			type = "toggle",
			width = "full",
			name = L["party popup text"],
			desc = L["party popup desc"],
			order = 43, 
			disabled = function(info) return Gimplist.db.profile.partysilence end,
			get = function() return Gimplist.db.profile.partypopup end,
			set = function(info, value) Gimplist.db.profile.partypopup = value end,				
		},
		partyJoinSound = {
			type = "toggle",
			width = "full",
			name = L["party sound text"],
			desc = L["party sound desc"],
			order = 44, 
			disabled = function(info) return Gimplist.db.profile.partysilence end,
			get = function() return Gimplist.db.profile.partysound end,
			set = function(info, value) Gimplist.db.profile.partysound = value end,				
		},
		recentGimpSet = {
			type = "range",
			min = 0, 
			max = 50, 
			step = 1,
			name = L["recent number text"],
			desc = L["recent number desc"],
			order = 50, 
			get = function() return Gimplist.db.profile.recentlistsize end,
			set = function(info, value) Gimplist.db.profile.recentlistsize = value end,				
		},
		chatMenus = {
			type = "toggle",
			width = "full",
			name = L["chatmenu text"],
			desc = L["chatmenu desc"],
			order = 60, 
			get = function() return Gimplist.db.profile.chatmenus end,
			set = function(info, value) 
				Gimplist:Print(L["Reload"])
				Gimplist.db.profile.chatmenus = value
				end,				
		},
	}
}
 
-- ---------------------
-- Declare variables needed for the main code
-- ---------------------
player = UnitName("player")
realm = GetRealmName()
local warnedthissession = {}
local recentgimps = {}
allgimps = {}
selectgimps = {}
sortedselectgimps = {}
acceptgimps = {}
sortedacceptgimps = {}
gimpsender = ""
local PlayerInBattlegrounds = false
Gimplist.commPrefix = "Gimplist"
Gimplist.commPriority = "BULK"
local sublist = {}
local chatmenuAdded = false
warncontraction = 0
local soundpath = "Interface\\Addons\\Gimplist\\Sounds\\"
local sound = "Bell.mp3"
local partypopupshown = false
local delimiter = "\a"

local GUIDs = {}
local seenGUIDs = {}

-- ---------------------
-- Declare variables needed for the browser
-- ---------------------
local gldisplay
local glselector
local glacceptor
local editwidth = 75 -- this is the width of the edit button
local serverwidth = 75 -- this is the width of the Server name
local namewidth = 100 -- this is the width of the Gimps name
local titlewidth = 75 -- this is the width of the Gimps title, if the title is too long, tough shit
local notewidth = 300 -- this is the width of the Gimps note, if the note is too long, tough shit
local deletewidth = 75 -- this is the width of the delete button
local buttonwidth = 150 -- this is the width of the buttons at the bottom
local cbwidth = 75 -- this is the width of the checkbox
-- the total width needs to be about 700

-- Variables to handle for the popups:
local GIMPREALM_POPUP_LABEL = L["Edit Realm"]	--this always says Edit Realm
local GIMPREALM_POPUP_DEFAULT = ""	--Should be the pre-edited name
local GimpRealmValue = ""		--this is the value from the Enter realm popup text
local GIMPNAME_POPUP_DEFAULT = ""	--For a new name use blanknametext otherwise it should be the pre-edited name
local GimpNameValue = ""		--this is the value from the Enter name popup text
local blanknametext = ""
local GIMPTITLE_POPUP_DEFAULT = ""	--For a new title use blanktitletext otherwise it should be the pre-edited title
local GimpTitleValue = ""		--this is the value from the Enter title popup text
local blanktitletext = L["Gimp"]
local GIMPNOTE_POPUP_DEFAULT = ""	--For a new/empty Note use blanknotetext otherwise it should be the pre-edited note
local GimpNoteValue = ""		--this is the value from the Enter note popup text
local blanknotetext = ""
local EditingGimp = ""			--this is the gimp that we're editing, the pre-edit value
local EditingRealm = ""			--this is the realm that we're editing, the pre-edit value
local EditNotNew = true			--this flags true if we're editing something and false if it's a new entry
local SendTargetValue = ""		--this is the name of someone to whom we're going to send our list of gimps

-- ---------------------
-- Declare variables needed for the Forumname2 functionality
-- ---------------------
local chatEvents = {
	["CHAT_MSG_BATTLEGROUND"]	= true,
	["CHAT_MSG_CHANNEL"]		= true,
	["CHAT_MSG_CHANNEL_LEAVE"]		= true,
	["CHAT_MSG_CHANNEL_JOIN"]		= true,
	["CHAT_MSG_GUILD"]		= true,
	["CHAT_MSG_OFFICER"]		= true,
	["CHAT_MSG_PARTY"]		= true,
	["CHAT_MSG_PARTY_LEADER"]		= true,
	["CHAT_MSG_RAID"]			= true,
	["CHAT_MSG_RAID_LEADER"]	= true,
	["CHAT_MSG_RAID_WARNING"]	= true,
	["CHAT_MSG_SAY"]			= true,
	["CHAT_MSG_WHISPER"]		= true,
	["CHAT_MSG_WHISPER_INFORM"]	= true,
	["CHAT_MSG_YELL"]			= true,
	["CHAT_MSG_BATTLEGROUND_LEADER"]			= true,
}
local systemMessageInfo = {
	{formatString = ERR_FRIEND_ONLINE_SS},
	{formatString = ERR_FRIEND_OFFLINE_S},
	{formatString = ERR_DECLINE_GROUP_S},
	{formatString = ERR_GUILD_DEMOTE_SSS},
	{formatString = ERR_GUILD_DISBAND_S},
	{formatString = ERR_GUILD_LEADER_CHANGED_SS},
	{formatString = ERR_GUILD_LEADER_S},
	{formatString = ERR_GUILD_LEAVE_S},
	{formatString = ERR_GUILD_PROMOTE_SSS},
	{formatString = ERR_GUILD_REMOVE_SS},
	{formatString = ERR_INVITED_TO_GROUP_SS},
	{formatString = ERR_INVITE_PLAYER_S},
	{formatString = ERR_JOINED_GROUP_S},
	{formatString = ERR_LEFT_GROUP_S},
	{formatString = ERR_NEW_LEADER_S},
	{formatString = ERR_NEW_LOOT_MASTER_S},
	{formatString = ERR_PLAYER_DIED_S},
	{formatString = ERR_RAID_MEMBER_ADDED_S},
	{formatString = ERR_RAID_MEMBER_REMOVED_S},
	{formatString = ERR_TRADE_BLOCKED_S},
	{formatString = ERR_TRADE_REQUEST_S}
}
local flags = {
	[1]  = {false, true},
	[4]  = {true, true, false},
	[6]  = {true, true},
	[9]  = {true, true, false},
	[10] = {true, true},
	[11] = {true, true}
}
local fillerTable = {true}

-------------------------------------------------------
-- ************************************************* --
-- ****************  STARTUP STUFF  **************** --
-- ************************************************* --
-------------------------------------------------------

-- ---------------------
function Gimplist:ADDON_LOADED(self, ...)
-- ---------------------
--    Gimplist:Print("Addon Loaded")
end

-- ---------------------
function Gimplist:OnInitialize()
-- Slash command registry
-- ---------------------
	self.db = LibStub("AceDB-3.0"):New("GLDB", defaults, true)
	self:RegisterChatCommand("gimplist", "SlashCommand")
	icon:Register("Gimplist", GimplistFrame.obj, Gimplist.db.profile.minimap)
	self:RegisterComm(self.commPrefix)
end

-- ---------------------
function Gimplist:ToggleMinimap(value)
-- ---------------------
	Gimplist.db.profile.minimap.hide = not value
	if value then
		icon:Show("Gimplist")
	else
		icon:Hide("Gimplist")
	end
end
 
-- ---------------------
function Gimplist:OnEnable()
-- Options for Addon Options menu
-- ---------------------
	Gimplist:IntegrityTest()

	if select(4, GetBuildInfo()) == 40100 then
		extraargs = False
	else
		extraargs = true
	end


	if Gimplist.db.profile.gimps[realm] then
		-- a database entry for this realm already exists
	else
		Gimplist.db.profile.gimps[realm] = {}
	end

	if Gimplist.db.profile.lastupdate then
		if Gimplist.db.profile.lastupdate == VERSION then
			-- addon is up to date structurally
		else
			-- perform a check to see if a major update is needed
		end
	else
		-- need to clear all the guids because it's an old version
		Gimplist:GUIDWIPE()
		Gimplist.db.profile.lastupdate = VERSION
	end

--	for index, info in pairs(systemMessageInfo) do
--		info.pattern = string.gsub(info.formatString, "%%s", "(%%a+)")
--		info.pattern = string.gsub(info.pattern, "([%[%]])", "%%%1")
--		info.replacementFlags = flags[index] or fillerTable
--	end
--	for i = 1, NUM_CHAT_WINDOWS do
--		self:RawHook(_G["ChatFrame" .. i], "AddMessage", "AddMessage", true)
--	end


	GameTooltip:HookScript("OnTooltipSetUnit", Gimplist.UnitTooltip);
	self:RegisterEvent("ADDON_LOADED", "ADDON_LOADED")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("RAID_ROSTER_UPDATE", "RAID_ROSTER_UPDATE")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "COMBAT_LOG_EVENT_UNFILTERED")
	if Gimplist.db.profile.chatmenus then
		self:RegisterEvent("UNIT_TARGET", "UNIT_TARGET")
		if not chatmenuAdded then
			tinsert(UnitPopupMenus["FRIEND"],#UnitPopupMenus["FRIEND"]-1,"ADDGIMP")
			chatmenuAdded = true
		end
	end
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Gimplist", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Gimplist", "Gimplist")	
end

-- ---------------------
function Gimplist:IntegrityTest()
-- Checks that all gimps have a title and populate the guid object holder
-- ---------------------
	for r in pairs(Gimplist.db.profile.gimps) do
		for n in pairs(Gimplist.db.profile.gimps[r]) do
			if Gimplist.db.profile.gimps[r][n].title == nil or Gimplist.db.profile.gimps[r][n].title == "" then
				replacetitle = L["Gimp"]
				Gimplist.db.profile.gimps[r][n].title = replacetitle
				Gimplist:Print((L["Fix Title"]):format(n, repalcetitle))
			end
			if Gimplist.db.profile.gimps[r][n].title == delimiter then
				replacetitle = L["Gimp"]
				Gimplist.db.profile.gimps[r][n].title = replacetitle
			end
			if Gimplist.db.profile.gimps[r][n].guid then
				tempguid = Gimplist.db.profile.gimps[r][n].guid
				GUIDs[tempguid] = {}
				GUIDs[tempguid].realm = r
				GUIDs[tempguid].name = n
			end
		end 
	end
end

-- ---------------------
function Gimplist:GUIDWIPE()
-- Wipes all stored guids following possible 4.1 patch errors
-- ---------------------
	for r in pairs(Gimplist.db.profile.gimps) do
		for n in pairs(Gimplist.db.profile.gimps[r]) do
			if Gimplist.db.profile.gimps[r][n].guid then
				Gimplist.db.profile.gimps[r][n].guid = nil
			end
			
		end
	end
end

-- ---------------------
function Gimplist:SlashCommand(msg)
-- deal with slashcommands
-- ---------------------
	local words = {}
	wipe(words)
	if msg then
		local cmd = string.lower(string.sub(msg, 1, 1))
			for w in string.gmatch(msg, "%a+") do
				table.insert(words, w)
			end
		if (cmd=="a") then
			Gimplist:AddGimp()
		elseif (cmd=="b") then
			Gimplist:RefreshBrowser()
		elseif (cmd=="h") then
			Gimplist:ListRecent()  -- hopefully can kill this
		elseif (cmd=="o") then
			InterfaceOptionsFrame_OpenToCategory(Gimplist.optionsFrame)
		else
			Gimplist.Usage()		     
		end
	else
		Gimplist.Usage()
	end
end
 
-- ---------------------
function Gimplist:Usage()
-- ---------------------
	Gimplist:Print(L["Usage"])
	Gimplist:Print("/gimplist h  (lists recent gimps)")
end

-------------------------------------------------------
-- ************************************************* --
-- **************  GENERAL FUNCTIONS  ************** --
-- ************************************************* --
-------------------------------------------------------
 
-- ---------------------
function Gimplist:GetInfo(gname, grealm, infotype)
-- ---------------------
	if Gimplist.db.profile.gimps[grealm] then
		if Gimplist.db.profile.gimps[grealm][gname] then
		-- So the player and realm exist...
			infodata = Gimplist.db.profile.gimps[grealm][gname][infotype]
			return infodata
		else
		-- No data for this player
			return 
		end
	else
	-- No Realm Data for this realm
		return 
	end
end

local results = {}
-- ---------------------
function Gimplist:SystemMessageHelper(msg, info, ...)
-- ---------------------
-- this digs out the title if the message is a system message
-- most system messages are from your own realm so don't need any splitting here
-- if you're grouped with an off-realm player with the same name as a gimp on your realm and they want to trade with you
-- then tough shit, it's not the end of the world! ;)

	local eventFound, noteFound
	wipe(results)
	for i=1, select("#", ...) do
		eventFound = true
		local charName = select(i, ...)
		if(info.replacementFlags[i]) then
			if Gimplist.db.profile.chatenable then
				local note = Gimplist:GetInfo(charName, realm, "title")
			end
			if(note) then
				tinsert(results, string.format("%s <%s>", charName, note))
				noteFound = true
				Gimplist:AddToRecent(charName..delimiter..realm)
			else
				tinsert(results, charName)
			end
		else
			tinsert(results, charName)
		end
	end
	if(noteFound) then
		return string.format(info.formatString, unpack(results))
	elseif(eventFound) then
		return msg
	end
end

function addGimpTitle(self, event, msg, auth, ...)
	local _, _, _, _, _, _, _, _, _, arg12 = ...
	if(event == "CHAT_MSG_SYSTEM") then
		for i, info in pairs(systemMessageInfo) do
			local output = Gimplist:SystemMessageHelper(msg, info, string.match(msg, info.pattern))
			if(output) then
				msg = output
				break
			end
		end
	elseif(chatEvents[event]) then
		-- adding a check to see if it's an alert like "Southshore is under attack" or a real chat message
		if auth then
			-- This part will try to create 2 variables from arg2 that hopefully will come in the form of
			-- Arthaaas-Shendra'la... plr = Arthaaas and svr = Shendra'la
			-- if there's no argument for svr then it's clearly someone from your own realm
			local plr, svr = strsplit("-", auth, 2)
			if svr and strlen(svr) > 0 then
				gsvr = svr
			else
				gsvr = realm
			end
			if arg12 then
				chatGUID = tonumber(string.sub(arg12, 13, 18), 16)
				if seenGUIDs[chatGUID] == nil then
					-- this is the first time we've seen this guid today
					if chatGUID then
						seenGUIDs[chatGUID] = true
						Gimplist:StoreGUID(chatGUID, plr, gsvr)
					end
				end
			end
			if Gimplist.db.profile.chatenable then
				local note = Gimplist:GetInfo(plr, gsvr, "title")
				if note then
					msg = "<"..note.."> "..msg
					Gimplist:AddToRecent(plr..delimiter..gsvr)
				end
			end
		end
	end
	return false, msg, auth, ...
end

for evnt, flag in pairs(chatEvents) do
	ChatFrame_AddMessageEventFilter(evnt, addGimpTitle)
end

-- ---------------------
function Gimplist:ListGimps()
-- Debug only
-- ---------------------
	local unitdata = {}
	wipe(unitdata)
	for name,_ in pairs(Gimplist.db.profile.gimps[realm]) do
		unittitle = Gimplist.db.profile.gimps[realm][name].title or ""
		unitnote = Gimplist.db.profile.gimps[realm][name].note or L["No Notes"]
		Gimplist:Print(name.."("..unittitle.."): "..unitnote)
	end
end
 
-- ---------------------
function Gimplist:FixName(name)
-- Thanks to ignoremore
-- ---------------------
	if string.match(name, "^[a-z]") then
		fixedname = string.upper(string.sub(name,1,1))..string.sub(name,2);
		return fixedname
	end
	return name;
end
 
-- ----------------------------------------------------
function Gimplist:PARTY_MEMBERS_CHANGED(self, ...)
-- ----------------------------------------------------
	if (not UnitInParty("PLAYER")) then
		return;
	end  
	Gimplist:PartyUpdate()
end
 
-- ----------------------------------------------------
function Gimplist:RAID_ROSTER_UPDATE(self, ...)
-- ----------------------------------------------------
	if (not UnitInRaid("PLAYER")) then
		PlayerInBattlegrounds = false
		return
	end
	Gimplist:RaidUpdate()
end
 
-- ----------------------------------------------------
function Gimplist:PartyUpdate()
-- ----------------------------------------------------
	if ( GetNumRaidMembers()>0) then
	-- Party has changed but we're in a raid
		Gimplist:RaidUpdate();
		return;
	end
 
	for n=1, GetNumPartyMembers() do
		if (GetPartyMember(n) ~=nil) then
			local pname, prealm  = UnitName("Party"..n);
			if prealm == nil then
				prealm = realm
			end
 
			if warnedthissession[pname..delimiter..prealm] then
			else
				if not Gimplist.db.profile.partysilence then
					Gimplist:CheckGimp(pname, prealm)
				end
			end
		end
	end
end
 
-- ----------------------------------------------------
function Gimplist:RaidUpdate()
-- ----------------------------------------------------
	if (UnitInBattleground("PLAYER") or GetRealZoneText() == BZ["Wintergrasp"]) then
		PlayerInBattlegrounds = true
	end
	
	for n=1, GetNumRaidMembers() do
		if (GetRaidRosterInfo(n) ~=nil) then
			local pname, prealm  = UnitName("Raid"..n);
			if prealm == nil then 
				prealm = realm
			end
 
			if warnedthissession[pname..delimiter..prealm] then
				-- Gimplist:Print("Already warned about "..pname)
			else
				if PlayerInBattlegrounds == true and Gimplist.db.profile.battlegroundsilence == true then
					-- nothing to do!
				else
					if not Gimplist.db.profile.partysilence then
						Gimplist:CheckGimp(pname, prealm)
					end
				end
			end
		end
	end
end
 
-- ----------------------------------------------------
function Gimplist:CheckGimp(gname, grealm)
-- ----------------------------------------------------
	if gname ~= player then
-- don't want to warn about you joining a group... you know you're a gimp!!!!
		gtitle = Gimplist:GetInfo(gname, grealm, "title")
		gnote = Gimplist:GetInfo(gname, grealm, "note")
		if gtitle then
			if gnote == nil then
				gnote = L["No Notes"]
			end
			Gimplist:Print((L["Gimp Detected"]):format(gname, gtitle, gnote))
			Gimplist:AddToRecent(gname..delimiter..grealm)
			if Gimplist.db.profile.partysound then
				PlaySoundFile(soundpath..sound)
			end
			if Gimplist.db.profile.partypopup and not partypopupshown then
				partypopupshown = true
				StaticPopup_Show("PARTY_POPUP")
			end
		end
		warnedthissession[gname..delimiter..grealm] = true
	end
end

-- ---------------------------------
function Gimplist:WipeSession()
-- wipe the already warned table so that alerts will re-appear
-- ---------------------------------
	wipe(warnedthissession)
	Gimplist:Print(L["Wipe Session"])
end

-- ---------------------------------
function Gimplist:WipeAllGimps(wipetype)
-- completely wipe all gimps and notes... needs to be done twice to confirm.
-- ---------------------------------
	if wipetype == "all" then
			wipe(Gimplist.db.profile.gimps)
			Gimplist:Print(L["Delete All"])
			Gimplist.db.profile.gimps[realm]= { }
			-- need at least one realm or it will error
	else
			if Gimplist.db.profile.gimps[wipetype] then
				wipe(Gimplist.db.profile.gimps[wipetype])
				Gimplist:Print((L["Delete Realm"]):format(wipetype))
			else
				Gimplist:Print(L["Realm Not Found"])
			end
	end
end

-- ---------------------------------
function Gimplist:AddToRecent(gnameandrealm)
-- keep a list of the most recent n gimp names
-- ---------------------------------
	if Gimplist.db.profile.recentlistsize == 0 then
	else
		local alreadylisted = 0
		for _,recentgimpnames in pairs(recentgimps) do
			if recentgimpnames == gnameandrealm then
				alreadylisted = 1
--				Gimplist:Print("Already listed "..recentgimpnames)
			end
		end
		if alreadylisted == 0 then
			if Gimplist.db.profile.recentlistsize > 1 then
				local endoflist = min(Gimplist.db.profile.recentlistsize - 1, #recentgimps)
				for i=endoflist, 1, -1 do
					recentgimps[i+1] = recentgimps[i]
				end
				recentgimps[1] = gnameandrealm
			end
		end
	end
end 

-- ---------------------------------
function Gimplist:RemoveFromRecent(gnameandrealm)
-- ---------------------------------
	for k, v in pairs(recentgimps) do
		if v == gnameandrealm then
			table.remove(recentgimps, k)
		end
	end
end


-- ------------------------------------
function Gimplist:ListRecent()
-- lists the array recentgimps 
-- Debug Only
-- ------------------------------------
	for _,names in pairs(recentgimps) do
		Gimplist:Print(names)
	end
end

-- ------------------------------------
function Gimplist:StoreGUID(guid, plr, svr)
-- ------------------------------------
	if Gimplist.db.profile.gimps[svr] then
		if Gimplist.db.profile.gimps[svr][plr] then
			if Gimplist.db.profile.gimps[svr][plr].guid == nil then
				Gimplist.db.profile.gimps[svr][plr].guid = guid
				GUIDs[guid] = {}
				GUIDs[guid].name = plr
				GUIDs[guid].realm = svr
			else
				savedGUID = Gimplist.db.profile.gimps[svr][plr].guid
				if savedGUID ~= guid then
					Gimplist:Print((L["GUID Changed"]):format(plr))
				end
			end
		end
	end
	if GUIDs[guid] ~= nil then
		storedplr = GUIDs[guid].name
		storedsvr = GUIDs[guid].realm
		if storedsvr == svr then
			if plr ~= storedplr then
				if Gimplist.db.profile[storedsvr] then
					if Gimplist.db.profile[storedsvr][storedplr] then
						Gimplist:Print((L["GUID Name Changed"]):format(plr, storedplr))
					end
				end
			end
		end
	end
	return
end

-- ------------------------------------
function Gimplist:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
-- ------------------------------------
	if extraargs then
		_, _, _, sourceGUID, sourceName, _, _, destGUID, destName, _ = select(1, ...)
	else
		_, _, _, sourceGUID, sourceName, _, destGUID, destName, _ = select(1, ...)
	end
	local sourceID = tonumber(string.sub(sourceGUID, 13, 18), 16)
	local destID = tonumber(string.sub(destGUID, 13, 18), 16)
	if sourceName and string.sub(sourceGUID, 5, 5) == "0" and not seenGUIDs[sourceID] then
		seenGUIDs[sourceID] = true
		local plr, svr = strsplit("-", sourceName, 2)
		if svr and strlen(svr) > 0 then
			gsvr = svr
		else
			gsvr = realm
		end
		Gimplist:StoreGUID(sourceID, plr, gsvr)	
	end
	if destName and string.sub(destGUID, 5, 5) == "0" and not seenGUIDs[destID] then
		seenGUIDs[destID] = true
		local plr, svr = strsplit("-", destName, 2)
		if svr and strlen(svr) > 0 then
			gsvr = svr
		else
			gsvr = realm
		end
		Gimplist:StoreGUID(destID, plr, gsvr)			
	end
end

---------------------------------------------------
-- ********************************************* --
-- *****************  TOOLTIP  ***************** --
-- ********************************************* --
---------------------------------------------------

-- ---------------------
function Gimplist:UnitTooltip(arg1, arg2)
-- ---------------------
	local pname, punitid=GameTooltip:GetUnit();
	if (punitid==nil or pname==nil) then
		return;
	end
	if UnitIsPlayer(punitid) then
		local x,prealm=UnitName(punitid);
		Gimplist:AppendTooltip(prealm, pname);
	end
end
	
-- ---------------------
function Gimplist:AppendTooltip(prealm, pname)	
-- ---------------------
	prealm = prealm or realm
	if Gimplist.db.profile.tooltipenable then
		gtitle = Gimplist:GetInfo(pname, prealm, "title")
		if gtitle then
			GameTooltip:AddLine("|cff00ffff<"..gtitle..">");
			Gimplist:AddToRecent(pname..delimiter..prealm)
		end
	end
end

-- ---------------------
function GimplistFrame.obj.OnTooltipShow(tip)
-- on the Broker tooltip show the most recent gimps and their notes
-- ---------------------
	tip:AddLine("|cffffffff"..L["Recent Gimps Seen"].."|r")
	if ((recentgimps == nil) or (#recentgimps == 0)) then
		tip:AddLine(L["No Gimps Seen"])
	else
		for i = 1, #recentgimps do

			gname, grealm = strsplit(delimiter, recentgimps[i])
			
			gtitle = Gimplist:GetInfo(gname, grealm, "title")
			gnote = Gimplist:GetInfo(gname, grealm, "note")
			if gnote == nil then
				gnote = L["No Notes"]
			end
			if gtitle == nil then
				gtitle = L["Gimp"]
				Gimplist:Print((L["Fix Title"]):format(gname, gtitle))
				Gimplist.db.profile.gimps[grealm][gname].title = gtitle
			end
			tip:AddDoubleLine("|cff00ffff"..gname.." <"..gtitle.."> "..gnote )
		end
	end
	tip:AddLine(" ")
	tip:AddLine("|cffffffff "..L["Left Click"].."|r")
	tip:AddLine("|cffffffff "..L["Right Click"].."|r")
end

--------------------------------------------------------
-- ************************************************** --
-- **************  ADDING AND EDITING  ************** --
-- ************************************************** --
--------------------------------------------------------

-- ---------------------
function Gimplist:UNIT_TARGET(unitid)
-- ---------------------
	if ((UnitIsPlayer("target")) and (UnitName("target") ~= player)) then
		for i = 1, #UnitPopupMenus["PLAYER"] do
			if UnitPopupMenus["PLAYER"][i] == "ADDGIMP" then
				tremove(UnitPopupMenus["PLAYER"], i)
			end
		end
 		tinsert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["PLAYER"] - 1, "ADDGIMP")
		for i = 1, #UnitPopupMenus["RAID"] do
			if UnitPopupMenus["RAID"][i] == "ADDGIMP" then
				tremove(UnitPopupMenus["RAID"], i)
			end
		end
 		tinsert(UnitPopupMenus["RAID"], #UnitPopupMenus["RAID"] - 1, "ADDGIMP")
		for i = 1, #UnitPopupMenus["RAID_PLAYER"] do
			if UnitPopupMenus["RAID_PLAYER"][i] == "ADDGIMP" then
				tremove(UnitPopupMenus["RAID_PLAYER"], i)
			end
		end
 		tinsert(UnitPopupMenus["RAID_PLAYER"], #UnitPopupMenus["RAID_PLAYER"] - 1, "ADDGIMP")
		for i = 1, #UnitPopupMenus["PARTY"] do
			if UnitPopupMenus["PARTY"][i] == "ADDGIMP" then
				tremove(UnitPopupMenus["PARTY"], i)
			end
		end
 		tinsert(UnitPopupMenus["PARTY"], #UnitPopupMenus["PARTY"] - 1, "ADDGIMP")
	end
end

UnitPopupButtons["ADDGIMP"] = { 
	text = L["Add To Gimps"], 
	dist = 0, 
	func = function(self) Gimplist:RightClickUnit() end,
}

-- ---------------------
function Gimplist:RightClickUnit()
-- ---------------------
	local dropdownframe = UIDROPDOWNMENU_INIT_MENU
	tarname = dropdownframe.name
	tarsvr =dropdownframe.server or realm
	Gimplist:RightClickAdd(tarname, tarsvr)
end

-- ---------------------
function Assignfunchook(dropdownMenu, which, unit, name, userData, ...)
-- ---------------------
	for i=1, UIDROPDOWNMENU_MAXBUTTONS do
		local button = _G["DropDownList"..UIDROPDOWNMENU_MENU_LEVEL.."Button"..i];
		if button.value == "ADDGIMP" then
			button.func = UnitPopupButtons["ADDGIMP"].func
		end
	end
end

hooksecurefunc("UnitPopup_ShowMenu", Assignfunchook)

-- ---------------------
function Gimplist:RightClickAdd(gname, gsvr)
-- ---------------------
		EditNotNew = false
		GimpNameValue = gname
		GimpRealmValue = gsvr
		if GimpRealmValue == nil or GimpRealmValue == "" then
			GimpRealmValue = realm
		end
		Gimplist:EditTitlePopup()
end

-- ---------------------------------
function Gimplist:EditRealmPopup(grealm, gname)
-- ---------------------------------
	EditNotNew = true
	EditingGimp = gname
	EditingRealm = grealm
	GIMPREALM_POPUP_DEFAULT = grealm
	StaticPopup_Show("GIMP_REALM_POPUP")
end

-- ---------------------------------
function Gimplist:EditNamePopup()
-- ---------------------------------
	if EditNotNew then
		GIMPNAME_POPUP_DEFAULT = EditingGimp
	else
		GIMPNAME_POPUP_DEFAULT = blanknametext
	end
	StaticPopup_Show("GIMP_NAME_POPUP")
end

-- ---------------------------------
function Gimplist:EditTitlePopup()
-- ---------------------------------
	if EditNotNew then
		GIMPTITLE_POPUP_DEFAULT = Gimplist.db.profile.gimps[EditingRealm][EditingGimp].title
	else
		GIMPTITLE_POPUP_DEFAULT = blanktitletext
	end
	StaticPopup_Show("GIMP_TITLE_POPUP")
end

-- ---------------------------------
function Gimplist:EditNotePopup()
-- ---------------------------------
	if EditNotNew then
		GIMPNOTE_POPUP_DEFAULT = Gimplist:GetInfo(EditingGimp, EditingRealm, "note")
		if GIMPNOTE_POPUP_DEFAULT == nil then
			GIMPNOTE_POPUP_DEFAULT = ""
		end
	else
		GIMPNOTE_POPUP_DEFAULT = blanknotetext
	end
	StaticPopup_Show("GIMP_NOTE_POPUP")
end

-- ---------------------------------
function Gimplist:AddGimpFromPopups()
-- ---------------------------------
	if Gimplist.db.profile.gimps[GimpRealmValue] == nil then
		Gimplist.db.profile.gimps[GimpRealmValue] = {}
		-- just in case the change was to create a new realm!
	end
	if Gimplist.db.profile.gimps[GimpRealmValue][GimpNameValue] == nil then
		Gimplist.db.profile.gimps[GimpRealmValue][GimpNameValue] = {}
	end
	if GimpTitleValue == nil then
		GimpTitleValue = "Gimp"
	end
	if GimpNoteValue == nil then
		GimpNoteValue = ""
	end
	if EditNotNew then
		-- edited data... need to delete old data and store new stuff then refresh the browser
		EditingTitle = Gimplist:GetInfo(EditingGimp, EditingRealm, "title") or ""
		EditingNote = Gimplist:GetInfo(EditingGimp, EditingRealm, "note") or ""
		Gimplist:Print((L["Change From"]):format(EditingGimp, EditingTitle, EditingRealm, EditingNote))
		Gimplist:Print((L["Change To"]):format(GimpNameValue, GimpTitleValue, GimpRealmValue, GimpNoteValue))
		Gimplist.db.profile.gimps[EditingRealm][EditingGimp] = nil
		Gimplist.db.profile.gimps[GimpRealmValue][GimpNameValue] = {}
		Gimplist.db.profile.gimps[GimpRealmValue][GimpNameValue].title = GimpTitleValue
		Gimplist.db.profile.gimps[GimpRealmValue][GimpNameValue].note = GimpNoteValue
		Gimplist:RefreshBrowser()
	else
 		Gimplist:Print((L["Add Gimp"]):format(GimpNameValue, GimpRealmValue, GimpTitleValue, GimpNoteValue))
		Gimplist.db.profile.gimps[GimpRealmValue][GimpNameValue] = {}
		Gimplist.db.profile.gimps[GimpRealmValue][GimpNameValue].title = GimpTitleValue
		Gimplist.db.profile.gimps[GimpRealmValue][GimpNameValue].note = GimpNoteValue
	end
end

-- ---------------------------------
function Gimplist:AddGimp()
-- ---------------------------------
	if ((UnitIsPlayer("target")) and (UnitName("target") ~= player)) then
		-- Already have the gimp, just need the title and notes
		EditNotNew = false
		GimpNameValue, GimpRealmValue = UnitName("target")
		if GimpRealmValue == nil or GimpRealmValue == "" then
			GimpRealmValue = realm
		end
		Gimplist:EditTitlePopup()
	else
		-- No valid unit is selected, need another way of getting the gimps name!
		EditNotNew = false
		GimpRealmValue = realm
		Gimplist:EditNamePopup()
	end
end

-------------------------------------------------------
-- ************************************************* --
-- ************ EDIT AND DELETE BROWSER ************ --
-- ************************************************* --
-------------------------------------------------------

-- ---------------------
function Gimplist:RefreshBrowser()
-- ---------------------
	Gimplist:BuildGimpBrowser()
end

-- ---------------------
function Gimplist:BuildGimpBrowser()
-- ---------------------
	if gldisplay and gldisplay:IsVisible() then
		gldisplay:Hide()
		return
	end
	Gimplist:BuildAllGimps("browser", Gimplist.db.profile.gimps)

	gldisplay = GUI:Create("Frame");
	-- set global name
	_G["GL_display"] = gldisplay
	-- use escape to close
	tinsert(UISpecialFrames, "GL_display")

	local glscroll = GUI:Create("ScrollFrame")
	gldisplay:SetTitle(L["Browser Title"])
	gldisplay:SetLayout("Flow")
	gldisplay:SetStatusTable{width=800}

	gldisplay:SetCallback("OnClose", function(_gldisplay) 
		GUI:Release(_gldisplay) 
	end)

	-- Build the title group:
	local titlesg = GUI:Create("SimpleGroup") 
		titlesg:SetLayout("Flow")
		titlesg:SetHeight(100)
		titlesg:SetFullWidth(true)
	local titleeditgap = GUI:Create("Label")
		titleeditgap:SetWidth(editwidth)
		titleeditgap:SetText(" ")
	local titleserver = GUI:Create("Label")
		titleserver:SetWidth(serverwidth)
		titleserver:SetText(L["Realm"])
	local titlename = GUI:Create("Label")
		titlename:SetWidth(namewidth)
		titlename:SetText(L["Gimp name"])
	local titletitle = GUI:Create("Label")
		titletitle:SetWidth(titlewidth)
		titletitle:SetText(L["Title"])
	local titlenote = GUI:Create("Label")
		titlenote:SetWidth(notewidth)
		titlenote:SetText(L["Note"])
	local titledeletegap = GUI:Create("Label")
		titledeletegap:SetWidth(deletewidth)
		titledeletegap:SetText(" ")
	titlesg:AddChildren(titleeditgap, titleserver, titlename, titletitle, titlenote, titledeletegap)

	-- Build the bottom 4 buttons...
	local footsg = GUI:Create("SimpleGroup") 
		footsg:SetLayout("Flow")
		footsg:SetHeight(100)
		footsg:SetFullWidth(true)

	local bsend = GUI:Create("Button")
		bsend:SetText(L["Send Gimps"])
		bsend:SetWidth(buttonwidth)
		bsend:SetCallback("OnClick", function()
			gldisplay:Hide()
			Gimplist:SendRequest()
		end)

	local bclear = GUI:Create("Button")
		bclear:SetText(L["Clear Session"])
		bclear:SetWidth(buttonwidth)
		bclear:SetCallback("OnClick", function()
			--CLEAR SESSION DATA
			Gimplist:WipeSession()
			gldisplay:Hide()
			Gimplist:RefreshBrowser()
			return
		end)
	local bdelrealm = GUI:Create("Button")
		bdelrealm:SetText(L["Delete Realm Button"])
		bdelrealm:SetWidth(buttonwidth)
		bdelrealm:SetCallback("OnClick", function()
			gldisplay:Hide()
			StaticPopup_Show("CONFIRM_REALM_DELETION")
		end)
	local bdelall = GUI:Create("Button")
		bdelall:SetText(L["Delete All Button"])
		bdelall:SetWidth(buttonwidth)
		bdelall:SetCallback("OnClick", function()
			gldisplay:Hide()
			StaticPopup_Show("CONFIRM_DELETION")
		end)
	footsg:AddChildren(bsend, bclear, bdelrealm, bdelall)

	-- build the main scroll frame listing all the gimps
	local mainsg = GUI:Create("SimpleGroup")
		mainsg:SetLayout("Fill")
		mainsg:SetFullWidth(true)
		mainsg:SetHeight(370)
	local sf = GUI:Create("ScrollFrame")
		sf:SetLayout("List")

	-- each entry line needs 2 buttons (edit & delete)and 4 labels (server, name, title, notes)
	local entryline, editbutton, deletebutton, serverlabel, namelabel, titlelabel, notelabel, nogimplabel, allgimpsrealm, allgimpsname
	if (allgimps == nil or #allgimps == 0) then
		entryline = GUI:Create("SimpleGroup")
		entryline:SetRelativeWidth(0.99)
		entryline:SetHeight(35)
		entryline:SetLayout("Flow")
		nogimplabel = GUI:Create("Label")
		nogimplabel:SetFullWidth(true)
		nogimplabel:SetText(L["No Gimps Found"])
		entryline:AddChild(nogimplabel)
		sf:AddChild(entryline)
	else
		for i = 1, #allgimps do
			allgimpsrealm, allgimpsname = strsplit(delimiter, allgimps[i])
		if Gimplist.db.profile.gimps[allgimpsrealm] ~= nil then
		if Gimplist.db.profile.gimps[allgimpsrealm][allgimpsname] ~= nil then
-- these two if statements are annoying but we need to do this check to make sure that you don't get errors from bad data
			entryline = GUI:Create("SimpleGroup")
				entryline:SetRelativeWidth(0.99)
				entryline:SetHeight(15)
				entryline:SetLayout("Flow")
			editbutton = GUI:Create("Button")
				editbutton:SetWidth(editwidth)
				editbutton:SetText(L["Edit"])
					Gimplist:EditButtonDef(editbutton, allgimpsrealm, allgimpsname)
				entryline:AddChild(editbutton)
			serverlabel = GUI:Create("Label")	
				serverlabel:SetWidth(serverwidth)
				serverlabel:SetText(allgimpsrealm)
				entryline:AddChild(serverlabel)
			namelabel = GUI:Create("Label")
				namelabel:SetWidth(namewidth)
				namelabel:SetText(allgimpsname)
				entryline:AddChild(namelabel)
			titlelabel = GUI:Create("Label")
				titlelabel:SetWidth(titlewidth)
				titlelabel:SetText(Gimplist.db.profile.gimps[allgimpsrealm][allgimpsname].title)
				entryline:AddChild(titlelabel)
			notelabel = GUI:Create("Label")
				notelabel:SetWidth(notewidth)
				notetext = Gimplist.db.profile.gimps[allgimpsrealm][allgimpsname].note
				if notetext == nil then
					notetext = ""
				end
				notelabel:SetText(notetext)
				entryline:AddChild(notelabel)
			deletebutton = GUI:Create("Button")
				deletebutton:SetWidth(deletewidth)
				deletebutton:SetText(L["Delete"])
					Gimplist:DeleteButtonDef(deletebutton, allgimpsrealm, allgimpsname)
				entryline:AddChild(deletebutton)
			sf:AddChild(entryline)
		end
		end
		end
	end

	-- stick the subsections together
	mainsg:AddChild(sf)

	gldisplay:AddChildren(titlesg, mainsg, footsg)
	sf:ResumeLayout()
	gldisplay:ResumeLayout()
	gldisplay:ApplyStatus()
	return gldisplay
end

-- -------------------------------------------------------
-- Button function allocation
-- -------------------------------------------------------
function Gimplist:EditButtonDef(edbtn, grealm, gname)
   edbtn:SetCallback("OnClick", function()
		gldisplay:Hide()
		Gimplist:EditRealmPopup(grealm, gname);
      end)
end

function Gimplist:DeleteButtonDef(delbtn, grealm, gname)
	delbtn:SetCallback("OnClick", function()
		gldisplay:Hide()
		Gimplist.db.profile.gimps[grealm][gname] = nil;
		Gimplist:RemoveFromRecent(gname..delimiter..grealm)
		Gimplist:Print((L["Name Deleted"]):format(gname, grealm));
		Gimplist:RefreshBrowser();
	end)
end

-- -------------------------------
function Gimplist:BuildAllGimps(arrayselect, inputlist)
-- Create the sorted allgimps array sorted alphabetically by realm with current realm at the top
-- -------------------------------
	local resultarray = {}
	local tempallrealms = {}
	local tempnamearray = {}
	local realmnamepair = ""
	wipe(resultarray)
	wipe(tempallrealms)
	for n in pairs(inputlist) do
		if n ~= realm then
			table.insert(tempallrealms, n)
		end
	end
	table.sort(tempallrealms)
	
	if inputlist[realm] then
		table.insert(tempallrealms, 1, realm)
	end

	for _,m in pairs(tempallrealms) do
		wipe(tempnamearray)
		for k,_ in pairs(inputlist[m]) do
			table.insert(tempnamearray, k)
		end
		table.sort(tempnamearray)
		for _,j in pairs(tempnamearray) do
			realmnamepair = m..delimiter..j
			table.insert(resultarray, realmnamepair)
		end
	end	
	if arrayselect == "browser" then
		wipe(allgimps)
		allgimps = resultarray
	elseif arrayselect == "selector" then
		wipe(sortedselectgimps)
		sortedselectgimps = resultarray
	end
end

-------------------------------------------------------
-- ************************************************* --
-- *********  SENDING AND RECEIVING GIMPS  ********* --
-- ************************************************* --
-------------------------------------------------------

-- ---------------------
function Gimplist:SendRequest()
-- ---------------------
	selectgimps = Gimplist.db.profile.gimps
	for r in pairs(selectgimps) do
		for n in pairs(selectgimps[r]) do
			selectgimps[r][n].tosend = false
		end
	end
	Gimplist:BuildAllGimps("selector", selectgimps)
	StaticPopup_Show("SEND_TO_WHOM")
end

-- ---------------------
function Gimplist:RefreshSelector()
-- ---------------------
	Gimplist:BuildGimpSelector()
end

-- ---------------------
function Gimplist:BuildGimpSelector()
-- ---------------------
	if glselector and glselector:IsVisible() then
		glselector:Hide()
		return
	end

	glselector = GUI:Create("Frame");
	-- set global name
	_G["GL_selector"] = glselector
	-- use escape to close
	tinsert(UISpecialFrames, "GL_selector")

	local glscroll2 = GUI:Create("ScrollFrame")
	glselector:SetTitle(L["Selector Title"])

	glselector:SetLayout("Flow")
	glselector:SetStatusTable{width=800}

	glselector:SetCallback("OnClose", function(_glselector) 
		GUI:Release(_glselector) 
	end)

	-- Build the title group:
	local titlesg = GUI:Create("SimpleGroup") 
		titlesg:SetLayout("Flow")
		titlesg:SetHeight(100)
		titlesg:SetFullWidth(true)
	local titleeditgap = GUI:Create("Label")
		titleeditgap:SetWidth(editwidth)
		titleeditgap:SetText(" ")
	local titleserver = GUI:Create("Label")
		titleserver:SetWidth(serverwidth)
		titleserver:SetText(L["Realm"])
	local titlename = GUI:Create("Label")
		titlename:SetWidth(namewidth)
		titlename:SetText(L["Gimp name"])
	local titletitle = GUI:Create("Label")
		titletitle:SetWidth(titlewidth)
		titletitle:SetText(L["Title"])
	local titlenote = GUI:Create("Label")
		titlenote:SetWidth(notewidth)
		titlenote:SetText(L["Note"])
	local titledeletegap = GUI:Create("Label")
		titledeletegap:SetWidth(deletewidth)
		titledeletegap:SetText(" ")
	titlesg:AddChildren(titleeditgap, titleserver, titlename, titletitle, titlenote, titledeletegap)

	-- Build the bottom 4 buttons...
	local footsg = GUI:Create("SimpleGroup") 
		footsg:SetLayout("Flow")
		footsg:SetHeight(100)
		footsg:SetFullWidth(true)

	local bsend = GUI:Create("Button")
		bsend:SetText(L["Send"])
		bsend:SetWidth(buttonwidth)
		bsend:SetCallback("OnClick", function()
			glselector:Hide()
			Gimplist:SendGimps(selectgimps, SendTargetValue)
		end)

	local bselectnone = GUI:Create("Button")
		bselectnone:SetText(L["Select None"])
		bselectnone:SetWidth(buttonwidth)
		bselectnone:SetCallback("OnClick", function()
			glselector:Hide()
			Gimplist:BulkSelection("all", false)
		end)
	local bselectall = GUI:Create("Button")
		bselectall:SetText(L["Select All"])
		bselectall:SetWidth(buttonwidth)
		bselectall:SetCallback("OnClick", function()
			glselector:Hide()
			Gimplist:BulkSelection("all", true)
		end)
	local brealmonly = GUI:Create("Button")
		brealmonly:SetText(L["This Realm Only"])
		brealmonly:SetWidth(buttonwidth)
		brealmonly:SetCallback("OnClick", function()
			glselector:Hide()
			Gimplist:BulkSelection(realm, true)
		end)
	footsg:AddChildren(bsend, bselectnone, bselectall, brealmonly)

	-- build the main scroll frame listing all the gimps
	local mainsg = GUI:Create("SimpleGroup")
		mainsg:SetLayout("Fill")
		mainsg:SetFullWidth(true)
		mainsg:SetHeight(370)
	local sf = GUI:Create("ScrollFrame")
		sf:SetLayout("List")

	-- each entry line 1 checkbox and 4 labels (server, name, title, notes)
	local entryline, checkbx, serverlabel, namelabel, titlelabel, notelabel, nogimplabel, selectgimpsrealm, selectgimpsname
	if (sortedselectgimps == nil or #sortedselectgimps == 0) then
		entryline = GUI:Create("SimpleGroup")
		entryline:SetRelativeWidth(0.99)
		entryline:SetHeight(35)
		entryline:SetLayout("Flow")
		nogimplabel = GUI:Create("Label")
		nogimplabel:SetFullWidth(true)
		nogimplabel:SetText(L["No Gimps to send"])
		entryline:AddChild(nogimplabel)
		sf:AddChild(entryline)
	else
		for i = 1, #sortedselectgimps do
			selectgimpsrealm, selectgimpsname = strsplit(delimiter, sortedselectgimps[i])
			entryline = GUI:Create("SimpleGroup")
				entryline:SetRelativeWidth(0.99)
				entryline:SetHeight(15)
				entryline:SetLayout("Flow")
			checkbx = GUI:Create("CheckBox")
				checkbx:SetType("checkbox")
				checkbx:SetWidth(cbwidth)
				searchbool = Gimplist.db.profile.gimps[selectgimpsrealm][selectgimpsname].tosend

				checkbx:SetValue(searchbool)
				Gimplist:CBSelectDefinition(checkbx, selectgimpsrealm, selectgimpsname)
				entryline:AddChild(checkbx)
			serverlabel = GUI:Create("Label")	
				serverlabel:SetWidth(serverwidth)
				serverlabel:SetText(selectgimpsrealm)
				entryline:AddChild(serverlabel)
			namelabel = GUI:Create("Label")
				namelabel:SetWidth(namewidth)
				namelabel:SetText(selectgimpsname)
				entryline:AddChild(namelabel)
			titlelabel = GUI:Create("Label")
				titlelabel:SetWidth(titlewidth)
				titlelabel:SetText(selectgimps[selectgimpsrealm][selectgimpsname].title)
				entryline:AddChild(titlelabel)
			notelabel = GUI:Create("Label")
				notelabel:SetWidth(notewidth)
				notetext = selectgimps[selectgimpsrealm][selectgimpsname].note
				if notetext == nil then
					notetext = ""
				end
				notelabel:SetText(notetext)
				entryline:AddChild(notelabel)
			sf:AddChild(entryline)
		end
	end

	-- stick the subsections together
	mainsg:AddChild(sf)

	glselector:AddChildren(titlesg, mainsg, footsg)
	sf:ResumeLayout()
	glselector:ResumeLayout()
	glselector:ApplyStatus()
	return glselector
end


-- ---------------------
function Gimplist:BulkSelection(selection, flag)
-- ---------------------
	for r in pairs(selectgimps) do
		if selection == "all" then
			for n in pairs(selectgimps[r]) do
				selectgimps[r][n].tosend = flag
			end
		elseif r == selection then
			for n in pairs(selectgimps[r]) do
				selectgimps[r][n].tosend = flag
			end
		end
	end
	Gimplist:RefreshSelector()
end

-- ---------------------
function Gimplist:CBSelectDefinition(chkbx, sgrealm, sgname)
-- ---------------------
	chkbx:SetCallback("OnValueChanged", function(cb, event, value)
		selectgimps[sgrealm][sgname].tosend = value
		end)
end

-- ---------------------
function Gimplist:SendGimps(sendlist, target)
-- Send Data, can only send to people in the same realm.
-- ---------------------
	wipe(sublist)
	for r in pairs(sendlist) do
		for n in pairs(sendlist[r]) do
			if sendlist[r][n].tosend then
				if sublist[r] == nil then
					sublist[r] = {}
				end
				sublist[r][n] = {}
				sublist[r][n].title = sendlist[r][n].title
				if sendlist[r][n].note == nil then
					sendlist[r][n].note = ""
				else
					sublist[r][n].note = sendlist[r][n].note
				end
			end
		end
	end	
	local mashedsublist = {}
	wipe(mashedsublist)
	for r in pairs(sublist) do
		for n in pairs(sublist[r]) do
			local title = sublist[r][n].title
			local note = sublist[r][n].note or ""
			mashedname = r..delimiter..n..delimiter..title..delimiter..note
			table.insert(mashedsublist, mashedname)
		end
	end



	gimpstosend = Gimplist:Serialize(mashedsublist)
	if target == nil or target == "" then
		Gimplist:Print("No target")
		-- debug only, this should be caught elsewhere
	else
		Gimplist:SendCommMessage(Gimplist.commPrefix, gimpstosend, "WHISPER", target, Gimplist.commPriority)
	end
end

-- ---------------------
function Gimplist:ListSendees(sendeelist)
-- Debug Only
-- ---------------------
	for r in pairs(sendeelist) do
		for n in pairs(sendeelist[r]) do
			ltitle = sendeelist[r][n].title
			lnote = sendeelist[r][n].note
			if sendeelist[r][n].tosend then
				Gimplist:Print(n.." of "..r.." <"..ltitle..">: "..lnote.." TRUE")
			else
				Gimplist:Print(n.." of "..r.." <"..ltitle..">: "..lnote.." FALSE")
			end
		end
	end
end

-- ---------------------
function Gimplist:OnCommReceived(prefix, message, distribution, sender)
-- Receive Data
-- ---------------------
	if prefix ~= self.commPrefix then return end
	wipe(acceptgimps)
	success, acceptlist = Gimplist:Deserialize(message)
	Gimplist:Print((L["Message Received"]):format(sender))
	if success then 
		if acceptlist == nil or acceptlist == "" then return end

		for _,v in pairs(acceptlist) do
			rlm, nme, ttl, nte = strsplit(delimiter, v, 4)
			
			if acceptgimps[rlm] == nil then
				acceptgimps[rlm] = {}
			end
			acceptgimps[rlm][nme] = {}
			acceptgimps[rlm][nme].title = ttl 
			acceptgimps[rlm][nme].note = nte		
		end
		gimpsender = sender
		local dialog = StaticPopup_Show("INCOMING_GIMPS")
	end
end

-- ---------------------------------
function Gimplist:AcceptIncoming()
-- ---------------------------------
	for r in pairs(acceptgimps) do
		for n in pairs(acceptgimps[r]) do
			acceptgimps[r][n].toaccept = false
			if Gimplist.db.profile.gimps[r] then
				if Gimplist.db.profile.gimps[r][n] then
					acceptgimps[r][n].isdupe = true				
				else
					acceptgimps[r][n].isdupe = false				
				end
			else
				acceptgimps[r][n].isdupe = false				
			end
		end
	end
-- sort by dupes, then this realm then alphabetical realm, then alphabetical name
	local resultarray = {}
	local tempallrealms = {}
	local tempnamearray = {}
	local realmnamepair = ""
	wipe(resultarray)
	wipe(tempallrealms)
	for n in pairs(acceptgimps) do
		if n ~= realm then
			table.insert(tempallrealms, n)
		end
	end
	table.sort(tempallrealms)
	if acceptgimps[realm] then
		table.insert(tempallrealms, 1, realm)
	end
-- doing dupes first
	for _,m in pairs(tempallrealms) do
		wipe(tempnamearray)
		for k,_ in pairs(acceptgimps[m]) do
			if acceptgimps[m][k].isdupe then
				table.insert(tempnamearray, k)
			end
		end
		table.sort(tempnamearray)
		for _,j in pairs(tempnamearray) do
			realmnamepair = m..delimiter..j
			table.insert(resultarray, realmnamepair)
		end
	end	
-- doing uniques next
	for _,m in pairs(tempallrealms) do
		wipe(tempnamearray)
		for k,_ in pairs(acceptgimps[m]) do
			if acceptgimps[m][k].isdupe == false then
				table.insert(tempnamearray, k)
			end
		end
		table.sort(tempnamearray)
		for _,j in pairs(tempnamearray) do
			realmnamepair = m..delimiter..j
			table.insert(resultarray, realmnamepair)
		end
	end	
	sortedacceptgimps = resultarray
	Gimplist:BuildGimpAcceptor()
end

-- ---------------------
function Gimplist:RefreshAcceptor()
-- ---------------------
	Gimplist:BuildGimpAcceptor()
end

-- ---------------------
function Gimplist:BuildGimpAcceptor()
-- ---------------------
	if glacceptor and glacceptor:IsVisible() then
		glacceptor:Hide()
		return
	end

	glacceptor = GUI:Create("Frame");
	-- set global name
	_G["GL_acceptor"] = glacceptor
	-- use escape to close
	tinsert(UISpecialFrames, "GL_acceptor")

	local glscroll3 = GUI:Create("ScrollFrame")
	glacceptor:SetTitle(L["Accept Title"])
	glacceptor:SetLayout("Flow")
	glacceptor:SetStatusTable{width=800}

	glacceptor:SetCallback("OnClose", function(_glacceptor) 
		GUI:Release(_glacceptor) 
	end)

	-- Build the title group:
	local titlesg = GUI:Create("SimpleGroup") 
		titlesg:SetLayout("Flow")
		titlesg:SetHeight(100)
		titlesg:SetFullWidth(true)
	local titleeditgap = GUI:Create("Label")
		titleeditgap:SetWidth(editwidth)
		titleeditgap:SetText(" ")
	local titleserver = GUI:Create("Label")
		titleserver:SetWidth(serverwidth)
		titleserver:SetText(L["Realm"])
	local titlename = GUI:Create("Label")
		titlename:SetWidth(namewidth)
		titlename:SetText(L["Gimp name"])
	local titletitle = GUI:Create("Label")
		titletitle:SetWidth(titlewidth)
		titletitle:SetText(L["Title"])
	local titlenote = GUI:Create("Label")
		titlenote:SetWidth(notewidth)
		titlenote:SetText(L["Note"])
	local titledeletegap = GUI:Create("Label")
		titledeletegap:SetWidth(deletewidth)
		titledeletegap:SetText(" ")
	titlesg:AddChildren(titleeditgap, titleserver, titlename, titletitle, titlenote, titledeletegap)

	-- Build the bottom 4 buttons...
	local footsg = GUI:Create("SimpleGroup") 
		footsg:SetLayout("Flow")
		footsg:SetHeight(100)
		footsg:SetFullWidth(true)

	local bsend = GUI:Create("Button")
		bsend:SetText(L["Add"])
		bsend:SetWidth(buttonwidth)
		bsend:SetCallback("OnClick", function()
			glacceptor:Hide()
			Gimplist:ImportGimps()
		end)

	local bselectnone = GUI:Create("Button")
		bselectnone:SetText(L["Select None"])
		bselectnone:SetWidth(buttonwidth)
		bselectnone:SetCallback("OnClick", function()
			glacceptor:Hide()
			Gimplist:BulkAcception("all", false)
		end)
	local bselectall = GUI:Create("Button")
		bselectall:SetText(L["Select All"])
		bselectall:SetWidth(buttonwidth)
		bselectall:SetCallback("OnClick", function()
			glacceptor:Hide()
			Gimplist:BulkAcception("all", true)
		end)
	local brealmonly = GUI:Create("Button")
		brealmonly:SetText(L["This Realm Only"])
		brealmonly:SetWidth(buttonwidth)
		brealmonly:SetCallback("OnClick", function()
			glacceptor:Hide()
			Gimplist:BulkAcception("all", true)
		end)
	footsg:AddChildren(bsend, bselectnone, bselectall, brealmonly)

	-- build the main scroll frame listing all the gimps
	local mainsg = GUI:Create("SimpleGroup")
		mainsg:SetLayout("Fill")
		mainsg:SetFullWidth(true)
		mainsg:SetHeight(370)
	local sf = GUI:Create("ScrollFrame")
		sf:SetLayout("List")

	-- each entry line 1 checkbox and 4 labels (server, name, title, notes)
	local entryline, checkbx, serverlabel, namelabel, titlelabel, notelabel, nogimplabel, acceptgimpsrealm, acceptgimpsname
	local dupenote, dupetitle, dupeline, dupelabel, spacerline
	if (sortedacceptgimps == nil or #sortedacceptgimps == 0) then
		entryline = GUI:Create("SimpleGroup")
		entryline:SetRelativeWidth(0.99)
		entryline:SetHeight(35)
		entryline:SetLayout("Flow")
		nogimplabel = GUI:Create("Label")
		nogimplabel:SetFullWidth(true)
		nogimplabel:SetText(L["No Gimps Found"])
		entryline:AddChild(nogimplabel)
		sf:AddChild(entryline)
	else
		for i = 1, #sortedacceptgimps do
			acceptgimpsrealm, acceptgimpsname = strsplit(delimiter, sortedacceptgimps[i])
			entryline = GUI:Create("SimpleGroup")
				entryline:SetRelativeWidth(0.99)
				entryline:SetHeight(15)
				entryline:SetLayout("Flow")
			checkbx = GUI:Create("CheckBox")
				checkbx:SetType("checkbox")
				checkbx:SetWidth(cbwidth)
				searchbool = acceptgimps[acceptgimpsrealm][acceptgimpsname].toaccept
				checkbx:SetValue(searchbool)
				Gimplist:CBAcceptDefinition(checkbx, acceptgimpsrealm, acceptgimpsname)
				entryline:AddChild(checkbx)
			serverlabel = GUI:Create("Label")	
				serverlabel:SetWidth(serverwidth)
				serverlabel:SetText(acceptgimpsrealm)
				entryline:AddChild(serverlabel)
			namelabel = GUI:Create("Label")
				namelabel:SetWidth(namewidth)
				namelabel:SetText(acceptgimpsname)
				entryline:AddChild(namelabel)
			titlelabel = GUI:Create("Label")
				titlelabel:SetWidth(titlewidth)
				titlelabel:SetText(acceptgimps[acceptgimpsrealm][acceptgimpsname].title)
				entryline:AddChild(titlelabel)
			notelabel = GUI:Create("Label")
				notelabel:SetWidth(notewidth)
				notetext = acceptgimps[acceptgimpsrealm][acceptgimpsname].note
				if notetext == nil then
					notetext = ""
				end
				notelabel:SetText(notetext)
				entryline:AddChild(notelabel)
			sf:AddChild(entryline)

			if acceptgimps[acceptgimpsrealm][acceptgimpsname].isdupe then
				dupetitle = Gimplist.db.profile.gimps[acceptgimpsrealm][acceptgimpsname].title or ""
				dupenote = Gimplist.db.profile.gimps[acceptgimpsrealm][acceptgimpsname].note or L["No Notes"]
				dupeline = GUI:Create("SimpleGroup")
					dupeline:SetRelativeWidth(0.99)
					dupeline:SetHeight(15)
					dupeline:SetLayout("Flow")
				dupelabel = GUI:Create("Label")	
					dupelabel:SetText((L["Duplicate"]):format(dupetitle, dupenote))
					dupeline:AddChild(dupelabel)
				spacerline = GUI:Create("SimpleGroup")
					spacerline:SetRelativeWidth(0.99)
					spacerline:SetHeight(15)
					spacerline:SetLayout("Flow")
				sf:AddChild(dupeline)
				sf:AddChild(spacerline)
			end
		end
	end

	-- stick the subsections together
	mainsg:AddChild(sf)

	glacceptor:AddChildren(titlesg, mainsg, footsg)
	sf:ResumeLayout()
	glacceptor:ResumeLayout()
	glacceptor:ApplyStatus()
	return glacceptor
end

-- ---------------------
function Gimplist:BulkAcception(selection, flag)
-- ---------------------
	for r in pairs(acceptgimps) do
		if selection == "all" then
			for n in pairs(acceptgimps[r]) do
				acceptgimps[r][n].toaccept = flag
			end
		elseif r == selection then
			for n in pairs(acceptgimps[r]) do
				acceptgimps[r][n].toaccept = flag
			end
		end
	end
	Gimplist:RefreshAcceptor()
end

-- ---------------------
function Gimplist:CBAcceptDefinition(chkbx, sgrealm, sgname)
-- ---------------------
	chkbx:SetCallback("OnValueChanged", function(cb, event, value)
		acceptgimps[sgrealm][sgname].toaccept = value
		end)
end

-- ---------------------
function Gimplist:ImportGimps()
-- ---------------------
	local imported = 0
	local modified = 0
	for r in pairs(acceptgimps) do
		for n in pairs(acceptgimps[r]) do
			if acceptgimps[r][n].toaccept then
				if acceptgimps[r][n].isdupe then
					modified = modified + 1
				else
					if Gimplist.db.profile.gimps[r] == nil then
						Gimplist.db.profile.gimps[r] = {}
					end
					if Gimplist.db.profile.gimps[r][n] == nil then
						Gimplist.db.profile.gimps[r][n] = {}
					end
					imported = imported + 1
				end 
				Gimplist.db.profile.gimps[r][n].title = acceptgimps[r][n].title or L["Gimp"]
				Gimplist.db.profile.gimps[r][n].note = acceptgimps[r][n].note or ""
			end
		end
	end
	Gimplist:Print((L["Added"]):format(imported,modified))
	Gimplist:RefreshBrowser()
end


--------------------------------------------------------
-- ************************************************** --
-- *****************  POPUPS BELOW  ***************** --
-- ************************************************** --
--------------------------------------------------------

-- ---------------------------------
-- Popup for Gimp's Note
-- ---------------------------------
local noteentry = {}
for k,v in pairs(StaticPopupDialogs["SET_FRIENDNOTE"]) do
	noteentry[k] = v
end
noteentry.text = L["Input Note"]
noteentry.maxLetters = 256
noteentry.OnShow = function(self)
	self.editBox:SetText(GIMPNOTE_POPUP_DEFAULT)
	self.editBox:SetFocus()
end
noteentry.OnAccept = function(self)
	GimpNoteValue = self.editBox:GetText()
	Gimplist:AddGimpFromPopups()
end
noteentry.EditBoxOnEnterPressed = function(self)
	local parent = self:GetParent()
	noteentry.OnAccept(parent)
	parent:Hide()
end
noteentry.OnHide = function(self)
-- do nothing
end

StaticPopupDialogs["GIMP_NOTE_POPUP"] = noteentry

-- ---------------------------------
-- This is to delete all the gimps
-- ---------------------------------
StaticPopupDialogs["CONFIRM_DELETION"] = {
	text = L["Confirm Delete"],
	button1 = L["Delete"],	
	OnAccept = function(self)
		Gimplist:WipeAllGimps("all")
	end,
	OnHide = function(self)
		Gimplist:RefreshBrowser()
	end,
	button2 = L["Back"],	
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
}

-- ---------------------------------
-- Popup for Gimp's realm
-- ---------------------------------
local realmentry = {}
for k,v in pairs(StaticPopupDialogs["ADD_FRIEND"]) do
	realmentry[k] = v
end
realmentry.text = GIMPREALM_POPUP_LABEL
realmentry.OnShow = function(self)
	self.editBox:SetText(GIMPREALM_POPUP_DEFAULT)
	self.editBox:SetFocus()
end
realmentry.OnAccept = function(self)
	GimpRealmValue = Gimplist:FixName(self.editBox:GetText())
	if GimpRealmValue == "" or GimpRealmValue == nil then
		GimpRealmValue = realm
	end
	Gimplist:EditNamePopup();
-- press OK or Enter and you go to the next part
end
realmentry.EditBoxOnEnterPressed = function(self)
	local parent = self:GetParent()
	realmentry.OnAccept(parent)
--	parent:Hide()
end
realmentry.OnHide = function(self)
-- do nothing
end

StaticPopupDialogs["GIMP_REALM_POPUP"] = realmentry

-- ---------------------------------
-- Popup for Gimp's name
-- ---------------------------------
local nameentry = {}
for k,v in pairs(StaticPopupDialogs["ADD_FRIEND"]) do
	nameentry[k] = v
end
nameentry.text = L["Input Name"]
nameentry.OnShow = function(self)
	self.editBox:SetText(GIMPNAME_POPUP_DEFAULT)
	self.editBox:SetFocus()
end
nameentry.OnAccept = function(self)
	GimpNameValue = Gimplist:FixName(self.editBox:GetText())
	if GimpNameValue then
		Gimplist:EditTitlePopup()
	end
end
nameentry.EditBoxOnEnterPressed = function(self)
	local parent = self:GetParent()
	nameentry.OnAccept(parent)
--	parent:Hide()
end
nameentry.OnHide = function(self)
-- do nothing
end

StaticPopupDialogs["GIMP_NAME_POPUP"] = nameentry

-- ---------------------------------
-- Popup for Gimp's title
-- ---------------------------------
local titleentry = {}
for k,v in pairs(StaticPopupDialogs["ADD_FRIEND"]) do
	titleentry[k] = v
end
titleentry.text = L["Input Title"]
titleentry.OnShow = function(self)
	self.editBox:SetText(GIMPTITLE_POPUP_DEFAULT)
	self.editBox:SetFocus()
end
titleentry.OnAccept = function(self)
	GimpTitleValue = self.editBox:GetText()
	Gimplist:EditNotePopup()
end
titleentry.EditBoxOnEnterPressed = function(self)
	local parent = self:GetParent()
	titleentry.OnAccept(parent)
--	parent:Hide()
end
titleentry.OnHide = function(self)
-- do nothing
end

StaticPopupDialogs["GIMP_TITLE_POPUP"] = titleentry


-- ---------------------------------
-- This is to prompt to delete the gimps from just one realm
-- ---------------------------------

local realmdelete = {}
for k,v in pairs(StaticPopupDialogs["ADD_FRIEND"]) do
	realmdelete[k] = v
end
realmdelete.text = L["Realm Delete"]
realmdelete.OnShow = function(self)
	self.editBox:SetText(realm)
	self.editBox:SetFocus()
end
realmdelete.OnAccept = function(self)
	if self.editBox:GetText() then
		Gimplist:WipeAllGimps(self.editBox:GetText())
	end
end
realmdelete.EditBoxOnEnterPressed = function(self)
	local parent = self:GetParent()
	realmdelete.OnAccept(parent)
end
realmdelete.OnHide = function(self)
	Gimplist:RefreshBrowser()
end

StaticPopupDialogs["CONFIRM_REALM_DELETION"] = realmdelete

-- ---------------------------------
-- Popup for Friend's name to send to
-- ---------------------------------
local sendtarget = {}
for k,v in pairs(StaticPopupDialogs["ADD_FRIEND"]) do
	sendtarget[k] = v
end
sendtarget.text = L["Send Gimp list to"]
sendtarget.OnShow = function(self)
	self.editBox:SetText("")
	self.editBox:SetFocus()
end
sendtarget.OnAccept = function(self)
	SendTargetValue = Gimplist:FixName(self.editBox:GetText())
	if SendTargetValue then
		if SendTargetValue ~= "" then
			Gimplist:BuildGimpSelector()
		end
	end
--	parent:Hide()
end
sendtarget.EditBoxOnEnterPressed = function(self)
	local parent = self:GetParent()
	sendtarget.OnAccept(parent)
	parent:Hide()
end
sendtarget.OnHide = function(self)
-- do nothing
end

StaticPopupDialogs["SEND_TO_WHOM"] = sendtarget

-- ---------------------------------
-- This is to ask if you want to accept the gimps being sent to you
-- ---------------------------------
StaticPopupDialogs["INCOMING_GIMPS"] = {
	button1 = L["Yes"],	
	button2 = L["No"],
	text = L["Incoming"],	
	OnAccept = function(self)
		Gimplist:AcceptIncoming()
	end,
	OnCancel = function(self)
	end,
	OnHide = function(self)
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
}

-- ---------------------------------
-- This is to ask if you want to accept the gimps being sent to you
-- ---------------------------------
StaticPopupDialogs["PARTY_POPUP"] = {
	button1 = L["OK"],	
	text = L["Gimp Joined"],	
	OnAccept = function(self)
	end,
	OnHide = function(self)
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
}