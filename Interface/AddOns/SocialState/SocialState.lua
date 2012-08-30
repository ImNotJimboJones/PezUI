-------------------------------------------------------------------------------
-- Upvalued Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

local string = _G.string
local pairs = _G.pairs

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local LibQTip = LibStub('LibQTip-1.0')
local frame = CreateFrame("frame")

local tooltip
local LDB_ANCHOR

local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("SocialState",
{
	type	= "data source",
	icon	= "Interface\\Icons\\INV_Drink_08.png",
	label	= "SocialState",
	text	= "SocialState"
})

local update_Broker

-------------------------------------------------------------------------------
-- Font definitions.
-------------------------------------------------------------------------------
-- Setup the Title Font. 14
local ssTitleFont = CreateFont("ssTitleFont")
ssTitleFont:SetTextColor(1,0.823529,0)
ssTitleFont:SetFont(GameTooltipText:GetFont(), 14)

-- Setup the Header Font. 12
local ssHeaderFont = CreateFont("ssHeaderFont")
ssHeaderFont:SetTextColor(1,0.823529,0)
ssHeaderFont:SetFont(GameTooltipHeaderText:GetFont(), 12)

-- Setup the Regular Font. 12
local ssRegFont = CreateFont("ssRegFont")
ssRegFont:SetTextColor(1,0.823529,0)
ssRegFont:SetFont(GameTooltipText:GetFont(), 12)

local list_sort = {
	TOONNAME	=	function(a, b)
						return a["TOONNAME"] < b["TOONNAME"]
					end,
	LEVEL		=	function(a, b)
						if a["LEVEL"] < b["LEVEL"] then
							return true
						elseif a["LEVEL"] > b["LEVEL"] then
							return false
						else  -- TOONNAME
							return a["TOONNAME"] < b["TOONNAME"]
						end
					end,
	RANKINDEX	=	function(a, b)
						if a["RANKINDEX"] > b["RANKINDEX"] then
							return true
						elseif a["RANKINDEX"] < b["RANKINDEX"] then
							return false
						else -- TOONNAME
							return a["TOONNAME"] < b["TOONNAME"]
						end
					end,
	ZONENAME	=	function(a, b)
						if a["ZONENAME"] < b["ZONENAME"] then
							return true
						elseif a["ZONENAME"] > b["ZONENAME"] then
							return false
						else -- TOONNAME
							return a["TOONNAME"] < b["TOONNAME"]
						end
					end,
	REALMNAME	=	function(a, b)
						if a["REALMNAME"] < b["REALMNAME"] then
							return true
						elseif a["REALMNAME"] > b["REALMNAME"] then
							return false
						else -- TOONNAME
							return a["ZONENAME"] < b["ZONENAME"]
						end
					end,
	revTOONNAME	=	function(a, b)
						return a["TOONNAME"] > b["TOONNAME"]
					end,
	revLEVEL		=	function(a, b)
						if a["LEVEL"] > b["LEVEL"] then
							return true
						elseif a["LEVEL"] < b["LEVEL"] then
							return false
						else  -- TOONNAME
							return a["TOONNAME"] < b["TOONNAME"]
						end
					end,
	revRANKINDEX	=	function(a, b)
						if a["RANKINDEX"] < b["RANKINDEX"] then
							return true
						elseif a["RANKINDEX"] > b["RANKINDEX"] then
							return false
						else -- TOONNAME
							return a["TOONNAME"] < b["TOONNAME"]
						end
					end,
	revZONENAME	=	function(a, b)
						if a["ZONENAME"] > b["ZONENAME"] then
							return true
						elseif a["ZONENAME"] < b["ZONENAME"] then
							return false
						else -- TOONNAME
							return a["TOONNAME"] < b["TOONNAME"]
						end
					end,
	revREALMNAME	=	function(a, b)
						if a["REALMNAME"] > b["REALMNAME"] then
							return true
						elseif a["REALMNAME"] < b["REALMNAME"] then
							return false
						else -- TOONNAME
							return a["ZONENAME"] < b["ZONENAME"]
						end
					end
}

-------------------------------------------------------------------------------
-- Ace config table
-------------------------------------------------------------------------------
local options = {
	name = "SocialState",
	type = "group",
	args = {
		confdesc = {
			order = 1,
			type = "description",
			name = "LDB plugin that shows friends and guild list.\n",
			cmdHidden = true
		},
		displayheader = {
			order = 2,
			type = "header",
			name = "Tooltip Options",
		},
		hide_guildname = {
			type = "toggle", width = "normal",
			name = "Hide Guild name",
			desc = "Show or hide the guild name.",
			order = 3,
			get = function() return SocialStateDB.hide_guildname end,
			set = function(_, v) SocialStateDB.hide_guildname = v end,
		},
		hide_hintline = {
			type = "toggle", width = "normal",
			name = "Hide the Hint line",
			desc = "Show or hide the hint line under tooltip.",
			order = 4,
			get = function() return SocialStateDB.hide_hintline end,
			set = function(_, v) SocialStateDB.hide_hintline = v end,
		},
		hide_motd = {
			type = "toggle", width = "normal",
			name = "Hide the MotD",
			desc = "Hide the guild MotD under the tooltip.",
			order = 5,
			get = function() return SocialStateDB.hide_gmotd end,
			set = function(_, v) SocialStateDB.hide_gmotd = v end,
		},
		expand_realID = {
			order = 6,
			type = "toggle", width = "normal",
			name = "RealID 2 lines",
			desc = "Expand RealID to 2 lines in the tooltip for extended info.",
			get = function() return SocialStateDB.expand_realID end,
			set = function(_, v) SocialStateDB.expand_realID = v end,
		},
		tooltip_autohide = {
			order = 7,
			type = "input", width = "half",
			name = "Autohide Delay:",
			desc = "The tooltip will hide when not hovered over for this (default: 0.25)",
			get = function() return SocialStateDB.tooltip_autohide end,
			set = function(_, v) SocialStateDB.tooltip_autohide = v end,
		},
		displayheader2 = {
			order = 8,
			type = "header",
			name = "LDB Display Options",
		},
		hide_ldb_labels = {
			order = 9,
			type = "toggle", width = "double",
			name = "Hide Friends/Guild Labels",
			desc = "Hide the Friends and Guild labels from the LDB",
			get = function() return SocialStateDB.hide_LDB_labels end,
			set = function(_, v) SocialStateDB.hide_LDB_labels = v update_Broker() end
		},
		hide_ldb_totals = {
			order = 10,
			type = "toggle", width = "normal",
			name = "Hide Totals",
			desc = "Hide the Totals field from the LDB",
			get = function() return SocialStateDB.hide_LDB_totals end,
			set = function(_, v) SocialStateDB.hide_LDB_totals = v update_Broker() end
		}
	}
}

LibStub("AceConfig-3.0"):RegisterOptionsTable("SocialState", options)
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SocialState")

-- MoP Fix <3 Chinchilla
local MISTS_OF_PANDARIA = GetBuildInfo():match("5") and true or false
local GetNumPartyMembers = MISTS_OF_PANDARIA and GetNumSubgroupMembers or GetNumPartyMembers
local GetNumRaidMembers = MISTS_OF_PANDARIA and GetNumGroupMembers or GetNumRaidMembers

-------------------------------------------------------------------------------
-- Helper Routines
-------------------------------------------------------------------------------
local function inGroup(name)
	if GetNumPartyMembers() > 0 and UnitInParty(name) then
		return true
	elseif GetNumRaidMembers() > 0 and UnitInRaid(name) then
		return true
	end

	return false
end

local function player_name_to_index(name)
	local lookupname

	for i = 1, GetNumFriends() do
		lookupname = GetFriendInfo(i)

		if lookupname == name then
			return i
		end
	end
end

local function guild_name_to_index(name)
	local lookupname

	for i = 1, GetNumGuildMembers() do
		lookupname = GetGuildRosterInfo(i)

		if lookupname == name then
			return i
		end
	end
end

local function ColoredLevel(level)
	if level ~= "" then
		local color = GetQuestDifficultyColor(level)
		return string.format("|cff%02x%02x%02x%d|r", color.r * 255, color.g * 255, color.b * 255, level)
	end
end

local CLASS_COLORS, color = {}
local classes_female, classes_male = {}, {}

FillLocalizedClassList(classes_female, true)
FillLocalizedClassList(classes_male, false)

for token, localizedName in pairs(classes_female) do
	color = RAID_CLASS_COLORS[token]
	CLASS_COLORS[localizedName] = string.format("%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255) 
end

for token, localizedName in pairs(classes_male) do
	color = RAID_CLASS_COLORS[token]
	CLASS_COLORS[localizedName] = string.format("%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255) 
end

---------------------
--  Update button  --
---------------------

function update_Broker()
	ShowFriends()

	local displayline = ""

	local NumFriends, online = GetNumFriends()
	local realidTotal, realidOnline = BNGetNumFriends()

	displayline = online + realidOnline

	if not SocialStateDB.hide_LDB_totals then
		displayline = displayline .. "/" .. NumFriends + realidTotal
	end

	if not SocialStateDB.hide_LDB_labels then
		displayline = "Friends " .. displayline
	end

	if IsInGuild() then
		GuildRoster()
		local guildTotal, online = GetNumGuildMembers()
		displayline = displayline .. "|r : |cff00ff00"
		if not SocialStateDB.hide_LDB_labels then
			displayline = displayline .. "Guild "
		end

		displayline = displayline .. online

		if not SocialStateDB.hide_LDB_totals then
			displayline = displayline .. "/" .. guildTotal
		end
	end

	LDB.text = "|cff82c5ff" .. displayline .. "|r"
end



----------------------------
--  If names are clicked  --
----------------------------

local function Entry_OnMouseUp(frame, info, button)
	local i_type, toon_name, full_name, presence_id = string.split(":", info)

	if button == "LeftButton" then
		-- Invite to group/raid
		if IsAltKeyDown() then
			if i_type == "realid" then
				local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID = BNGetFriendInfo(BNGetFriendIndex(presence_id))
				BNInviteFriend(toonID)
				return
			else
				InviteUnit(toon_name)
				return
			end
		end

		-- Lookup player via /who
		if IsShiftKeyDown() then
			SetItemRef("player:"..toon_name, "|Hplayer:"..toon_name.."|h["..toon_name.."|h", "LeftButton")
			return
		end

		-- Edit Player Note
		if IsControlKeyDown() then
			if i_type == "guild" and CanEditPublicNote() then
				SetGuildRosterSelection(guild_name_to_index(toon_name))
				StaticPopup_Show("SET_GUILDPLAYERNOTE")
				return
			end

			if i_type == "friends" then
				FriendsFrame.NotesID = player_name_to_index(toon_name)
 				StaticPopup_Show("SET_FRIENDNOTE", GetFriendInfo(FriendsFrame.NotesID))
 				return
			end

			if i_type == "realid" then
				FriendsFrame.NotesID = presence_id
				StaticPopup_Show("SET_BNFRIENDNOTE", full_name)
				return
			end
		end
		-- Send a tell to player
			local edit_box = _G.ChatEdit_ChooseBoxForSend()
			_G.ChatEdit_ActivateChat(edit_box)
			edit_box:Insert("/w "..full_name.." ")
	elseif button == "RightButton" then
		-- Edit Guild Officer Notes
		if IsControlKeyDown() then
			if i_type == "guild" and CanEditOfficerNote() then
				SetGuildRosterSelection(guild_name_to_index(toon_name))
				StaticPopup_Show("SET_GUILDOFFICERNOTE")
			end
		end
	elseif button == "MiddleButton" then
		-- Expand RealID Broadcast
		SocialStateDB.expand_realID = not SocialStateDB.expand_realID
		LDB.OnEnter(LDB_ANCHOR)
	end
end

local function HideOnMouseUp(cell, section)
	SocialStateDB[section] = not SocialStateDB[section]
	LDB.OnEnter(LDB_ANCHOR)
end

local function SetGuildSort(cell, sortsection)
	if SocialStateDB["GuildSort"] == sortsection then
		SocialStateDB["GuildSort"] = "rev" .. sortsection
	else
		SocialStateDB["GuildSort"] = sortsection
	end
	LDB.OnEnter(LDB_ANCHOR)
end

local function SetRealIDSort(cell, sortsection)
	if SocialStateDB["RealIDSort"] == sortsection then
		SocialStateDB["RealIDSort"] = "rev" .. sortsection
	else
		SocialStateDB["RealIDSort"] = sortsection
	end
	LDB.OnEnter(LDB_ANCHOR)
end

------------------------------------------
--  Click to open friend / guild panel  --
------------------------------------------

function LDB:OnClick(button)
	if button == "LeftButton" then
		if IsAltKeyDown() then
			ToggleGuildFrame(1) -- guild toggle
		else
			ToggleFriendsFrame(1) -- friends toggle
		end
	end

	if button == "RightButton" then
		LibStub("AceConfigDialog-3.0"):Open("SocialState")
	end
end

---------------------
--  Event Section  --
---------------------

function LDB.OnLeave() end

------------------------
--      Tooltip!      --
------------------------
local GROUP_CHECKMARK	= "|TInterface\\Buttons\\UI-CheckBox-Check:0|t"
local AWAY_ICON		= "|TInterface\\FriendsFrame\\StatusIcon-Away:18|t"
local BUSY_ICON		= "|TInterface\\FriendsFrame\\StatusIcon-DnD:18|t"
local MOBILE_ICON	= "|TInterface\\ChatFrame\\UI-ChatIcon-ArmoryChat:18|t"
local MINIMIZE		= "|TInterface\\BUTTONS\\UI-PlusButton-Up:0|t"
local BROADCAST_ICON = "|TInterface\\FriendsFrame\\BroadcastIcon:0|t"

local FACTION_COLOR_HORDE = RED_FONT_COLOR_CODE
local FACTION_COLOR_ALLIANCE = "|cff0070dd"

function LDB.OnEnter(self)
	LDB_ANCHOR = self

	if LibQTip:IsAcquired("SocialState") then
		tooltip:Clear()
	else
		tooltip = LibQTip:Acquire("SocialState", 8, "RIGHT", "RIGHT", "LEFT", "LEFT", "CENTER", "CENTER", "RIGHT")

		tooltip:SetBackdropColor(0,0,0,1)

		tooltip:SetHeaderFont(ssHeaderFont)
		tooltip:SetFont(ssRegFont)

		tooltip:SmartAnchorTo(self)
		tooltip:SetAutoHideDelay(SocialStateDB.tooltip_autohide, self)
	end

	local line = tooltip:AddLine()
	tooltip:SetCell(line, 1, "SocialState", ssTitleFont, "CENTER", 0)
	tooltip:AddLine(" ")

	-------------------------
	--  Begin RealID list  --
	-------------------------
	local _, numBNOnline = BNGetNumFriends()
	local _, numFriendsOnline = GetNumFriends()

	if (numBNOnline > 0) or (numFriendsOnline > 0) then
		-- Header for Friends
		line = tooltip:AddLine()
		if not SocialStateDB.hide_friendsection then
			tooltip:SetCell(line, 1, "|cffffffff" .. _G.FRIENDS .. "|r", "LEFT", 3)
		else
			tooltip:SetCell(line, 1, "|cffffffff" .. MINIMIZE .. _G.FRIENDS .. "|r", "LEFT", 3)
		end
		tooltip:SetCellScript(line, 1, "OnMouseUp", HideOnMouseUp, "hide_friendsection")

		if not SocialStateDB.hide_friendsection then
			line = tooltip:AddHeader()
			line = tooltip:SetCell(line, 1, "  ")
			tooltip:SetCellScript(line, 1, "OnMouseUp", SetRealIDSort, "LEVEL")
			line = tooltip:SetCell(line, 3, _G.NAME)
			tooltip:SetCellScript(line, 3, "OnMouseUp", SetRealIDSort, "TOONNAME")
			line = tooltip:SetCell(line, 4, _G.BATTLENET_FRIEND)
			tooltip:SetCellScript(line, 4, "OnMouseUp", SetRealIDSort, "REALID")
			line = tooltip:SetCell(line, 5, _G.LOCATION_COLON)
			tooltip:SetCellScript(line, 5, "OnMouseUp", SetRealIDSort, "ZONENAME")
			line = tooltip:SetCell(line, 6, _G.FRIENDS_LIST_REALM)
			tooltip:SetCellScript(line, 6, "OnMouseUp", SetRealIDSort, "REALMNAME")
			if not SocialStateDB.hide_friend_notes then
				line = tooltip:SetCell(line, 7, _G.NOTE_COLON)
			else
				line = tooltip:SetCell(line, 7, MINIMIZE .. _G.NOTE_COLON)
			end
			tooltip:SetCellScript(line, 7, "OnMouseUp", HideOnMouseUp, "hide_friend_notes")

			tooltip:AddSeparator()

			if numBNOnline > 0 then
				local realid_table = {}
				for i = 1, numBNOnline do
					local presenceID, givenName, surname = BNGetFriendInfo(i)
					for toonidx = 1, BNGetNumFriendToons(i) do
						local fcolor
						local status = ""

						local _, _, _, _, _, _, _, isOnline, lastOnline, isAFK, isDND, broadcast, note = BNGetFriendInfoByID(presenceID)
						local _, toonName, client, realmName, realmID, faction, race, class, guild, zoneName, level, gameText = BNGetFriendToonInfo(i, toonidx)

						if faction then
							if faction == "Horde" then
								fcolor = FACTION_COLOR_HORDE
							else
								fcolor = FACTION_COLOR_ALLIANCE
							end
						end

						if isAFK then
							status = AWAY_ICON
						end

						if isDND then
							status = BUSY_ICON
						end

						if note and note ~= "" then note = "|cffff8800{"..note.."}|r" end
						
						table.insert(realid_table, {
							GIVENNAME = givenName,
							SURNAME = surname or "",
							LEVEL = level,
							CLASS = class,
							FCOLOR = fcolor,
							STATUS = status,
							BROADCAST_TEXT = broadcast or "",
							TOONNAME = toonName,
							CLIENT = client,
							ZONENAME = zoneName,
							REALMNAME = realmName,
							GAMETEXT = gameText,
							NOTE = note,
							PRESENCEID = presenceID
							})
					end
				end

				if (SocialStateDB["RealIDSort"] ~= "REALID") and (SocialStateDB["RealIDSort"] ~= "revREALID") then
					table.sort(realid_table, list_sort[SocialStateDB["RealIDSort"]])

				end

				for _, player in ipairs(realid_table) do
					local broadcast_flag
					if not SocialStateDB.expand_realID and player["BROADCAST_TEXT"] ~= "" then
						broadcast_flag = " " .. BROADCAST_ICON
					else
						broadcast_flag = ""
					end

					line = tooltip:AddLine()
					line = tooltip:SetCell(line, 1, ColoredLevel(player["LEVEL"]))
					line = tooltip:SetCell(line, 2, player["STATUS"])
					line = tooltip:SetCell(line, 3,
						string.format("|cff%s%s",CLASS_COLORS[player["CLASS"]] or "B8B8B8", player["TOONNAME"] .. "|r")..
						(inGroup(player["TOONNAME"]) and GROUP_CHECKMARK or ""))
					line = tooltip:SetCell(line, 4,
						"|cff82c5ff" .. player["GIVENNAME"] .. "|r" .. broadcast_flag)

					if player["CLIENT"] == "WoW" then
						line = tooltip:SetCell(line, 5, player["ZONENAME"])
						line = tooltip:SetCell(line, 6, player["FCOLOR"] .. player["REALMNAME"] .. "|r")
					else
						line = tooltip:SetCell(line, 5, player["GAMETEXT"])
						if player["CLIENT"] == "S2" then
							line = tooltip:SetCell(line, 6, "|cff82c5ffStarCraft 2|r")
						end

						if player["CLIENT"] == "D3" then
							line = tooltip:SetCell(line, 6, "|cff82c5ffDiablo 3|r")
						end
					end

					if not SocialStateDB.hide_friend_notes then
						line = tooltip:SetCell(line, 7, player["NOTE"])
					end

					tooltip:SetLineScript(line, "OnMouseUp", Entry_OnMouseUp, string.format("realid:%s:%s:%d", player["TOONNAME"], player["GIVENNAME"], player["PRESENCEID"]))

					if SocialStateDB.expand_realID and player["BROADCAST_TEXT"] ~= "" then
						line = tooltip:AddLine()
						line = tooltip:SetCell(line, 1, BROADCAST_ICON .. " |cff7b8489" .. player["BROADCAST_TEXT"] .. "|r", "LEFT", 0)
						tooltip:SetLineScript(line, "OnMouseUp", Entry_OnMouseUp, string.format("realid:%s:%s:%d", player["TOONNAME"], player["GIVENNAME"], player["PRESENCEID"]))
					end
				end
				tooltip:AddLine(" ")
			end

			if numFriendsOnline > 0 then
				local friend_table = {}
				for i = 1,numFriendsOnline do
					local toonName, level, class, zoneName, connected, status, note = GetFriendInfo(i)

					note = note and "|cffff8800{"..note.."}|r" or ""

					if status == CHAT_FLAG_AFK then
						status = AWAY_ICON
					elseif status == CHAT_FLAG_DND then
						status = BUSY_ICON
					end

					table.insert(friend_table, {
						TOONNAME = toonName,
						LEVEL = level,
						CLASS = class,
						ZONENAME = zoneName,
						REALMNAME = "",
						STATUS = status,
						NOTE = note
						})
				end

				if (SocialStateDB["RealIDSort"] ~= "REALID") and (SocialStateDB["RealIDSort"] ~= "revREALID") then
					table.sort(friend_table, list_sort[SocialStateDB["RealIDSort"]])
				else
					table.sort(friend_table, list_sort["TOONNAME"])
				end

				for _, player in ipairs(friend_table) do
					line = tooltip:AddLine()
					line = tooltip:SetCell(line, 1, ColoredLevel(player["LEVEL"]))
					line = tooltip:SetCell(line, 2, player["STATUS"])
					line = tooltip:SetCell(line, 3,
						string.format("|cff%s%s", CLASS_COLORS[player["CLASS"]] or "ffffff", player["TOONNAME"] .. "|r") .. (inGroup(player["TOONNAME"]) and GROUP_CHECKMARK or ""));
					line = tooltip:SetCell(line, 5, player["ZONENAME"])
					if not SocialStateDB.hide_friend_notes then
						line = tooltip:SetCell(line, 7, player["NOTE"])
					end

					tooltip:SetLineScript(line, "OnMouseUp", Entry_OnMouseUp, string.format("friends:%s:%s", player["TOONNAME"], player["TOONNAME"]))
				end
			end
		end
		tooltip:AddLine(" ")
	end

	------------------------
	--  Begin guild list  --
	------------------------

	if IsInGuild() then
		local guild_table = {}
		if not SocialStateDB.hide_gmotd then
			line = tooltip:AddLine()
			if not SocialStateDB.minimize_gmotd then
				tooltip:SetCell(line, 1, "|cffffffff" .. _G.CHAT_GUILD_MOTD_SEND .. "|r", "LEFT", 3)
			else
				tooltip:SetCell(line, 1, "|cffffffff".. MINIMIZE .. _G.CHAT_GUILD_MOTD_SEND .. "|r", "LEFT", 3)
			end
			tooltip:SetCellScript(line, 1, "OnMouseUp", HideOnMouseUp, "minimize_gmotd")

			if not SocialStateDB.minimize_gmotd then
				line = tooltip:AddLine()
				tooltip:SetCell(line, 1, "|cff00ff00"..GetGuildRosterMOTD().."|r", "LEFT", 0, nil, nil, nil, 100)
			end

			tooltip:AddLine(" ")
		end

		local ssGuildName
		if not SocialStateDB.hide_guildname then
			ssGuildName = GetGuildInfo("player")
		else
			ssGuildName = _G.GUILD
		end

		-- Header for Guild
		line = tooltip:AddLine()
		if not SocialStateDB.hide_guildsection then
			tooltip:SetCell(line, 1, "|cffffffff" .. ssGuildName .."|r", "LEFT", 3)
		else
			line = tooltip:SetCell(line, 1, MINIMIZE .. "|cffffffff" .. ssGuildName .. "|r", "LEFT", 3)
		end
		tooltip:SetCellScript(line, 1, "OnMouseUp", HideOnMouseUp, "hide_guildsection")

		if not SocialStateDB.hide_guildsection then
			line = tooltip:AddHeader()
			line = tooltip:SetCell(line, 1, "  ")
			tooltip:SetCellScript(line, 1, "OnMouseUp", SetGuildSort, "LEVEL")
			line = tooltip:SetCell(line, 3, _G.NAME)
			tooltip:SetCellScript(line, 3, "OnMouseUp", SetGuildSort, "TOONNAME")
			line = tooltip:SetCell(line, 5, _G.ZONE)
			tooltip:SetCellScript(line, 5, "OnMouseUp", SetGuildSort, "ZONENAME")
			line = tooltip:SetCell(line, 6, _G.RANK)
			tooltip:SetCellScript(line, 6, "OnMouseUp", SetGuildSort, "RANKINDEX")

			if not SocialStateDB.hide_guild_onotes then
				line = tooltip:SetCell(line, 7, _G.NOTE_COLON)
			else
				line = tooltip:SetCell(line, 7, MINIMIZE .. _G.NOTE_COLON)
			end
			tooltip:SetCellScript(line, 7, "OnMouseUp", HideOnMouseUp, "hide_guild_onotes")

			tooltip:AddSeparator()

			for i = 1, GetNumGuildMembers() do
				local toonName, rank, rankindex, level, class, zoneName, note, onote, connected, status, classFileName, achievementPoints, achievementRank, isMobile = GetGuildRosterInfo(i)

				if connected then
					if note and note ~= '' then note="|cff00ff00["..note.."]|r" end
					if onote and onote ~= '' then onote = "|cff00ffff["..onote.."]|r" end

					if status == 1 then
						status = AWAY_ICON
					elseif status == 2 then
						status = BUSY_ICON
					elseif status == 0 then
						status = ''
					end

					if isMobile then
						status = MOBILE_ICON
						zoneName = "Remote Chat"
					end

					table.insert(guild_table, {
						TOONNAME = toonName,
						RANK = rank,
						RANKINDEX = rankindex,
						LEVEL = level,
						CLASS = class,
						ZONENAME = zoneName,
						NOTE = note,
						ONOTE = onote,
						STATUS = status
						})
				end
			end

			table.sort(guild_table, list_sort[SocialStateDB["GuildSort"]])

			for _, player in ipairs(guild_table) do
					line = tooltip:AddLine()
					line = tooltip:SetCell(line, 1, ColoredLevel(player["LEVEL"]))
					line = tooltip:SetCell(line, 2, player["STATUS"])
					line = tooltip:SetCell(line, 3,
						string.format("|cff%s%s", CLASS_COLORS[player["CLASS"]] or "ffffff", player["TOONNAME"] .. "|r") .. (inGroup(player["TOONNAME"]) and GROUP_CHECKMARK or ""))
					line = tooltip:SetCell(line, 5, player["ZONENAME"] or "???")
					line = tooltip:SetCell(line, 6, player["RANK"])
					if not SocialStateDB.hide_guild_onotes then
						line = tooltip:SetCell(line, 7, player["NOTE"] .. player["ONOTE"])
					end

					tooltip:SetLineScript(line, "OnMouseUp", Entry_OnMouseUp, string.format("guild:%s:%s", player["TOONNAME"], player["TOONNAME"]))
			end
		end
		tooltip:AddLine(" ")
	end

	if not SocialStateDB.hide_hintline then
		line = tooltip:AddLine()
		if not SocialStateDB.minimize_hintline then
			tooltip:SetCell(line, 1, "Hint:", "LEFT", 3)
		else
			tooltip:SetCell(line, 1, MINIMIZE .. "Hint:", "LEFT", 3)
		end
		tooltip:SetCellScript(line, 1, "OnMouseUp", HideOnMouseUp, "minimize_hintline")

		if not SocialStateDB.minimize_hintline then
			line = tooltip:AddLine()
			tooltip:SetCell(line, 1, "|cffeda55fClick|r to open the friends panel.  |cffeda55fAlt-Click|r to open the guild panel.", "LEFT", 0)

			line = tooltip:AddLine()
			tooltip:SetCell(line, 1, "|cffeda55fClick|r a line to whisper a player.  |cffeda55fShift-Click|r a line to lookup a player.", "LEFT", 0)

			line = tooltip:AddLine()
			tooltip:SetCell(line, 1, "|cffeda55fCtrl-Click|r a line to edit a note.    |cffeda55fCtrl-RightClick|r a line to edit an officer note.", "LEFT", 0)

			line = tooltip:AddLine()
			tooltip:SetCell(line, 1, "|cffeda55fAlt-Click|r a line to invite.               |cffeda55fMiddleClick|r a line to expand RealID.", "LEFT", 0)

			line = tooltip:AddLine()
			tooltip:SetCell(line, 1, "|cffeda55fClick|r a Header to hide it or sort it.", "LEFT", 0)
		end
	end

		tooltip:UpdateScrolling()
		tooltip:Show()
end

frame:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

local DELAY = 15  --  Update every 15 seconds
local elapsed = DELAY - 5

frame:SetScript("OnUpdate",
	function (self, el)
		elapsed = elapsed + el

		if elapsed >= DELAY then
			elapsed = 0
			update_Broker()
		end
	end
)

function frame:PLAYER_LOGIN()
	if not SocialStateDB then
		-- Initialize default configuration
		SocialStateDB = {}
	end

	if not SocialStateDB.tooltip_autohide then
		SocialStateDB.tooltip_autohide = "0.25"
	end

	if not SocialStateDB["RealIDSort"] then
		SocialStateDB["RealIDSort"] = "REALID"
	end

	if not SocialStateDB["GuildSort"] then
		SocialStateDB["GuildSort"] = "RANKINDEX"
	end
end

frame:RegisterEvent("PLAYER_LOGIN")
