
local ALPHA = "ALPHA"
local RELEASE = "RELEASE"
local releaseString = nil
local addon = LibStub("AceAddon-3.0"):NewAddon("EveryQuest", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")
EveryQuest = addon
local QE = LibStub("LibQuestEvents-1.0")
local L = LibStub("AceLocale-3.0"):GetLocale("EveryQuest")
local BZ = LibStub("LibBabble-Zone-3.0"):GetUnstrictLookupTable()
local BF = LibStub("LibBabble-Faction-3.0"):GetUnstrictLookupTable()
local locale = GetLocale()
local releaseRevision = nil
do -- Borrowed from BigWigs :)
	-- START: MAGIC WOWACE VOODOO VERSION STUFF
	local releaseType = RELEASE
	--[===[@alpha@
	-- The following code will only be present in alpha ZIPs.
	releaseType = ALPHA
	--@end-alpha@]===]

	-- This will (in ZIPs), be replaced by the highest revision number in the source tree.
	releaseRevision = tonumber("216")

	-- If the releaseRevision ends up NOT being a number, it means we're running a SVN copy.
	if type(releaseRevision) ~= "number" then
		releaseRevision = -1
	end

	-- Then build the release string, which we can add to the interface option panel.
	local majorVersion = GetAddOnMetadata("EveryQuest", "Version") or "2.?"
	if releaseRevision == -1 then
		releaseString = L["You are running a source checkout of EveryQuest %s directly from the repository."]:format(majorVersion) -- Version message, %s = majorVersion
	-- elseif releaseType == RELEASE then
		--releaseString = L["You are running an official release of EveryQuest %s (revision %d)"]:format(majorVersion, releaseRevision) -- Version message, %s = majorVersion, %d = revision
	elseif releaseType == ALPHA then
		releaseString = L["You are running an ALPHA RELEASE of EveryQuest %s (revision %d). Please report any bugs @ http://www.wowace.com/addons/everyquest/tickets/"]:format(majorVersion, releaseRevision) -- Version message, %s = majorVersion, %d = revision
	end
	_G.EVERYQUEST_RELEASE_TYPE = releaseType
	_G.EVERYQUEST_RELEASE_REVISION = releaseRevision
	_G.EVERYQUEST_RELEASE_STRING = releaseString
	-- END:   MAGIC WOWACE VOODOO VERSION STUFF
end

local db, dbpc
local faction, clickedID, recentquest
addon.countShown, addon.countFailed, addon.countProgress, addon.countComplete, addon.countTurnedIn, addon.countUnknown, addon.countIgnored = 0,0,0,0,0,0,0
EveryQuestData = {}
EveryQuestListData = {}
local data = EveryQuestData
local lists = EveryQuestListData
local menu = EveryQuestZoneList
local factionMap = {
	[469] = BF["Alliance"], 
	[1037] = BF["Alliance Vanguard"], 
	[1106] = BF["Argent Crusade"], 
	[529] = BF["Argent Dawn"], 
	[1012] = BF["Ashtongue Deathsworn"], 
	[1177] = BF["Baradin's Wardens"], 
	[1133] = BF["Bilgewater Cartel"], 
	[87] = BF["Bloodsail Buccaneers"],
	[21] = BF["Booty Bay"], 
	[910] = BF["Brood of Nozdormu"], 
	[609] = BF["Cenarion Circle"], 
	[942] = BF["Cenarion Expedition"], 
	[909] = BF["Darkmoon Faire"], 
	[530] = BF["Darkspear Trolls"], 
	[69] = BF["Darnassus"], 
	[1172] = BF["Dragonmaw Clan"], 
	[577] = BF["Everlook"], 
	[930] = BF["Exodar"], 
	[1068] = BF["Explorers' League"], 
	[1104] = BF["Frenzyheart Tribe"], 
	[729] = BF["Frostwolf Clan"], 
	[369] = BF["Gadgetzan"], 
	[92] = BF["Gelkis Clan Centaur"], 
	[1134] = BF["Gilneas"], 
	[54] = BF["Gnomeregan"], 
	[1158] = BF["Guardians of Hyjal"], 
	[1168] = BF["Guild Reputation"], 
	[1178] = BF["Hellscream's Reach"], 
	[946] = BF["Honor Hold"], 
	[67] = BF["Horde"], 
	[1052] = BF["Horde Expedition"], 
	[749] = BF["Hydraxian Waterlords"], 
	[47] = BF["Ironforge"], 
	[989] = BF["Keepers of Time"], 
	[1090] = BF["Kirin Tor"], 
	[1098] = BF["Knights of the Ebon Blade"], 
	[978] = BF["Kurenai"], 
	[1011] = BF["Lower City"], 
	[93] = BF["Magram Clan Centaur"], 
	[1015] = BF["Netherwing"], 
	[1038] = BF["Ogri'la"], 
	[76] = BF["Orgrimmar"], 
	[1173] = BF["Ramkahen"], 
	[470] = BF["Ratchet"], 
	[349] = BF["Ravenholdt"], 
	[1031] = BF["Sha'tari Skyguard"], 
	[1077] = BF["Shattered Sun Offensive"], 
	[809] = BF["Shen'dralar"], 
	[911] = BF["Silvermoon City"], 
	[890] = BF["Silverwing Sentinels"], 
	[970] = BF["Sporeggar"], 
	[169] = L["Steamwheedle Cartel"],
	[730] = BF["Stormpike Guard"], 
	[72] = BF["Stormwind"], 
	[70] = BF["Syndicate"], 
	[932] = BF["The Aldor"], 
	[1156] = BF["The Ashen Verdict"], 
	[933] = BF["The Consortium"], 
	[510] = BF["The Defilers"], 
	[1135] = BF["The Earthen Ring"], 
	[1126] = BF["The Frostborn"], 
	[1067] = BF["The Hand of Vengeance"], 
	[1073] = BF["The Kalu'ak"], 
	[509] = BF["The League of Arathor"], 
	[941] = BF["The Mag'har"], 
	[1105] = BF["The Oracles"], 
	[990] = BF["The Scale of the Sands"], 
	[934] = BF["The Scryers"], 
	[935] = BF["The Sha'tar"], 
	[1094] = BF["The Silver Covenant"], 
	[1119] = BF["The Sons of Hodir"], 
	[1124] = BF["The Sunreavers"], 
	[1064] = BF["The Taunka"], 
	[967] = BF["The Violet Eye"], 
	[1091] = BF["The Wyrmrest Accord"], 
	[1171] = BF["Therazane"], 
	[59] = BF["Thorium Brotherhood"], 
	[947] = BF["Thrallmar"], 
	[81] = BF["Thunder Bluff"], 
	[576] = BF["Timbermaw Hold"], 
	[922] = BF["Tranquillien"], 
	[68] = BF["Undercity"], 
	[1050] = BF["Valiance Expedition"], 
	[1085] = BF["Warsong Offensive"], 
	[889] = BF["Warsong Outriders"], 
	[1174] = BF["Wildhammer Clan"], 
	[589] = BF["Wintersaber Trainers"], 
	[270] = BF["Zandalar Tribe"],
}
local Lclasses = {}
FillLocalizedClassList(Lclasses)
local questdisplay = {}
-- EQ_TextColors = {}
local format = string.format
-- EQ_TextColors["s-1"] = { r = 1.00, g = 0.00, b = 0.00, font = EQFont_Failed, hex = "ff0000" };
-- EQ_TextColors["s0"] = { r = 1.00, g = 1.00, b = 0, font = EQFont_Progress, hex = "ffff00" };
-- EQ_TextColors["s1"] = { r = 0.00, g = 1.00, b = 0.00, font = EQFont_Complete, hex = "00ff00" };
-- EQ_TextColors["s2"] = { r = 0.0, g = 0.807, b = 0.019, font = EQFont_TurnedIn, hex = "00cd04" };
-- EQ_TextColors["unknown"]	= { r = 1, g = 1, b = 1, font = EQFont_Unknown, hex = "ffffff" };
-- EQ_TextColors["ignored"] = { r = 0.733, g = 0.372, b = 1, font = EQFont_Ignored, hex = "BB5FFF" };

local SECOND = 1
local MINUTE = 60
local HOUR = 3600
local DAY = 86400
local currentsort = {}
addon.listsorted = false


-- Short form quest types, used in quest names (Buttons)
local qtypes = {}

local new, del, deepDel
do
	addon.tableCache = setmetatable({},{__mode='k'})
	function new(...)
		local t = next(addon.tableCache)
		if t then
			addon.tableCache[t] = nil
			for i = 1, select('#', ...) do
				t[i] = select(i, ...)
			end
			-- EveryQuest:Debug("Returned recycled table")
			return t
		else
			-- EveryQuest:Debug("New table made")
			return { ... }
		end
	end
	function del(t)
		for k in pairs(t) do
			t[k] = nil
		end
		-- EveryQuest:Debug("Recycle table")
		addon.tableCache[t] = true
		return nil
	end
	
	function deepDel(t)
		if type(t) ~= "table" then
			return nil
		end
		-- EveryQuest:Debug("Deep recycle table")
		for k,v in pairs(t) do
			t[k] = deepDel(v)
		end
		return del(t)
	end
	addon.new, addon.del, addon.deepDel = new, del, deepDel
end

function addon:GetReleaseString()
	return releaseString
end

function addon:Error(string)
	self:Print("|cffFF3232", string, "|r")
end
function addon:Debug(string)
	if self.db.profile.debug then  
		self:Print(string)
	end
end
function addon:Colorize(hexColor, text)
	return "|cff" .. tostring(hexColor or 'ffffff') .. tostring(text) .. "|r"
end
function addon:RGB2Hex(r,g,b)
	-- addon:Debug(format("%02x%02x%02x",r*255,g*255,b*255))
	return format("%02x%02x%02x",r*255,g*255,b*255)
end

StaticPopupDialogs["EVERYQUEST_PURGEOLD"] = {
	text = L["EQ_PURGETXT"], -- Purge data Popup Dialog
	button1 = L["Purge"], -- Purge data Popup Dialog
	button2 = L["Cancel"], -- Purge data Popup Dialog
	OnShow = function(self)
		self.editBox:SetText("")
	end,
	OnAccept = function(self)
		addon:Debug("EVERYQUEST_PURGEOLD: OnAccept")
		local text = self.editBox:GetText()
		if text and text == "DELETE" then
			dbpc.QuestHistory = nil
			EveryQuestDBPC = nil
		else
			addon:Error(L["PURGE_ERROR"]) -- Purge data Popup Dialog
		end
	end,
	EditBoxOnTextChanged = function (self, data)   -- careful! 'self' here points to the editbox, not the dialog
		local text = self:GetText()
		if text and text == "DELETE" then
			self:GetParent().button1:Enable()-- self:GetParent() is the dialog
		else
			self:GetParent().button1:Disable()
		end      
	end,
	timeout = 0,
	whileDead = 1,
	hasEditBox = 1,
	hideOnEscape = 1
};
local function getfaction(side)
	if UnitFactionGroup("player") == side then return true else return false end
end

local PlayerRace = select(2, UnitRace("player"))
local PlayerClass = select(2, UnitClassBase("player"))

local function getRace(race)
	if PlayerRace == race then return true else return false end
end
local function getClass(class)
	if PlayerClass == class then return true else return false end
end

function addon:OnInitialize()
	local f = UnitFactionGroup("player")
	if f == "Alliance" then
		faction = 1
	else
		faction = 2
	end
	---------------------------------------------------------------------
	
	--- Setup Databases, Options
    self.db = LibStub("AceDB-3.0"):New("EQ2DB", {
			profile = {
				debug = false,
				colors = {
					Failed = {1, 0, 0},
					Progress = {1, 1, 0},
					Complete = {0, 1, 0},
					TurnedIn = {0, 0.807, 0.019},
					Unknown = {1, 1, 1},
					Ignored = {0.733, 0.372, 1},
					Repeat = {0.094, 0.627, 0.94},
				},
				localized = {
					["*"] = {},
				},
			},
		}, "global")
	db = self.db.profile
	self.dbpc = LibStub("AceDB-3.0"):New("EQ2DBPC", {
			profile = {
		        zoneid = nil,
				dbversion = 2,
				zonegroup = nil,
				history = {},
				ignored = {},
				enabledfilters = {
					Faction = true,
					Race = true,
					Class = true,
				},
				-- enabledsort = {
					-- ["*"] = true,
				-- },
				sort = {
					["d"] = {
						["Weight"] = 5,
						["Dir"] = 2,
					},
					["n"] = {
						["Weight"] = -10,
						["Dir"] = 1,
					},
					["l"] = {
						["Weight"] = -5,
						["Dir"] = 2,
					},
					["w"] = {
						["Weight"] = 10,
						["Dir"] = 2,
					},
					["t"] = {
						["Weight"] = 0,
						["Dir"] = 2,
					},
				},
				filters = {
					FailedAbandoned = true,
					TurnedIn = true,
					Ignored = true,
					Completed = true,
					Alliance = getfaction("Alliance"),
					Horde = getfaction("Horde"),
					SideBoth = true,
					SideNone = true,
					Unknown = true,
					InProgress = true,
					MinLevel = 1,
					MaxLevel = 80,
					NormalQuest = true,
					GroupQuest = true,
					DailyQuest = true,
					WeeklyQuest = true,
					HeroicQuest = true,
					DungeonQuest = true,
					RaidQuest = true,
					PvpQuest = true,
					
					Human = getRace("Human"),
					Dwarf = getRace("Dwarf"),
					NightElf = getRace("NightElf"),
					Gnome = getRace("Gnome"),
					Draenei = getRace("Draenei"),
					Worgen = getRace("Worgen"),
					Orc = getRace("Orc"),
					Undead = getRace("Undead"),
					Tauren = getRace("Tauren"),
					Troll = getRace("Troll"),
					BloodElf = getRace("BloodElf"),
					Goblin = getRace("Goblin"),
					
					PRIEST = getClass("PRIEST"),
					ROGUE = getClass("ROGUE"),
					WARRIOR = getClass("WARRIOR"),
					MAGE = getClass("MAGE"),
					DRUID = getClass("DRUID"),
					HUNTER = getClass("HUNTER"),
					WARLOCK = getClass("WARLOCK"),
					SHAMAN = getClass("SHAMAN"),
					PALADIN = getClass("PALADIN"),
					DEATHKNIGHT = getClass("DEATHKNIGHT"),
				},
		    },
		}, "global")
	dbpc = self.dbpc.profile
	
	self:SetupOptions()
	--self:UpgradeCheck()
	
	if dbpc.dbversion < 4 then
		self:SilentUpgrade()
	end
	
	
	
	self:SetupFrames()
	qtypes[1] = L["G"] -- Short for 'Group'
	qtypes[62] = L["R"] -- Short for 'Raid'
	qtypes[85] = L["H"] -- Short for 'Heroic'
	qtypes[81] = L["D"] -- Short for 'Dungeon'
	qtypes[41] = L["P"] -- Short for 'PvP'
	qtypes[84] = L["E"] -- Short for 'Escort'
	qtypes[82] = L["WE"] -- Short for 'World Event'
	addon:UpdateSortList()
	
	EveryQuest:SecureHook(GameTooltip, "SetHyperlink", "SetHyperlink")
	self:RegisterMessage("EveryQuestDisplayChanged", "UpdateFrame")
	
	if db.savezone then
		self:SendMessage("EveryQuestDisplayChanged", dbpc.zonegroup, dbpc.zoneid)
	end
end

function addon:ModGetDB()
	return db, dbpc
end

local continentmap = {
	[1] = "Kalimdor",
	[2] = "Eastern Kingdoms",
	[3] = "Outland",
	[4] = "Northrend",
}

function addon:GetListIdByName(category, continent)
	for k,li in pairs(menu) do -- for each top level category
		if li[1] == category then
			return nil, li[1]
		else
			if type(li) == "table" then
				for _,list in pairs(li[2]) do -- for each category
					if list[2] == category then
						if 8 <= k and k <= 11 then
							return list[1], "Dungeons"
						elseif 20 <= k and k <= 23 then
							return list[1], "Reputation"
						else
							return list[1], li[1]
						end
					end
				end
			end
		end
	end
end

function addon:GetModuleFromListID(list)
	for k,li in pairs(menu) do -- for each top level category
		if type(li) == "table" and type(li[2]) == "table" then
			for _,li in pairs(li[2]) do 
				if li[1] == list then
					if 8 <= k and k <= 11 then
						return "Dungeons"
					elseif 20 <= k and k <= 23 then
						return "Reputation"
					else
						return li[1]
					end
				end
			end
		end
	end
end

local function recursiveLoopTest(tbl, list)
	-- EveryQuest:Debug("local list, module")
	if type(tbl) == "table" then
		for _, li in pairs(tbl) do
			if type(li[2]) == "table" then
				-- EveryQuest:Debug(format("%s: %s", li[1], tostring(li[1] == module)))
				-- if li[1] == module then
					local text = recursiveLoopTest(li[2], list)
					if text ~= nil then
						return text
					end
				-- end
			elseif li[1] == list then
				return li[2]
			end
		end
	end
end

function addon:GetListName(list)
	addon:Debug(format("GetListName(%d)", list))
	return recursiveLoopTest(menu, list)
end

-- menu create function
do
	local info = {}
	local levelvalues = {}
	local curlist
	
	local function addMenuItem(module, item, key, level)
		wipe(info)
		levelvalues[level - 1] = UIDROPDOWNMENU_MENU_VALUE
		if type(item) == "string" then
			-- item is title
			info.text = BZ[item] ~= nil and BZ[item] or BF[item] ~= nil and BF[item] or L[item]
			info.isTitle = true
			info.notCheckable = true
		elseif type(item) == "table" then
			if type(item[1]) == "string" then
				-- item is submenu
				info.hasArrow = true
				info.text = BZ[item[1]] ~= nil and BZ[item[1]] or BF[item[1]] ~= nil and BF[item[1]] or L[item[1]]
				
				info.value = key
				info.keepShownOnClick = 1
				info.notCheckable = true
			else
				-- item is category
				if module == "Classes" then
					info.text = Lclasses[item[2]]
				else
					info.text = BZ[item[2]] ~= nil and BZ[item[2]] or BF[item[2]] ~= nil and BF[item[2]] or L[item[2]]
				end
				info.checked = function() if addon.list == item[1] then return true end end
				info.func = function()
					addon.list = item[1]
					-- Special case to group all the expansion dungeon lists
					-- print(levelvalues[1])
					if 8 <= levelvalues[1] and levelvalues[1] <= 11 then
						-- EveryQuest:Debug("is a dungeon")
						addon.module = "Dungeons"
					elseif 20 <= levelvalues[1] and levelvalues[1] <= 23 then
						addon.module = "Reputation"
					else
						addon.module = module
					end
					
					CloseDropDownMenus()
					addon.listsorted = false
					addon:SendMessage("EveryQuestDisplayChanged", addon.module, addon.list)
				end
				-- info.notCheckable = 1
			end
		end
		UIDropDownMenu_AddButton(info, level)
	end
	
	local EveryQuest_ZoneMenu = CreateFrame("Frame", "EveryQuest_ZoneMenu")
	EveryQuest_ZoneMenu.displayMode = "MENU"
	EveryQuest_ZoneMenu.point = "TOPRIGHT"
	--/run DropDownList1:SetPoint("TOPRIGHT", "EQ_MenuButton", "BOTTOMRIGHT",0,0)
	EveryQuest_ZoneMenu.relativeTo = "EQ_MenuButton"
	EveryQuest_ZoneMenu.relativePoint = "BOTTOMRIGHT"
	EveryQuest_ZoneMenu.initialize = function(self, level)
		if not level then return end
		
		-- print(UIDROPDOWNMENU_MENU_VALUE)
		if (level == 1) then
			-- List the Modules
			for key,value in pairs(menu) do
				addMenuItem(menu[1], value, key, level)
			end
		else
			if level == 2 then
				curlist = menu[UIDROPDOWNMENU_MENU_VALUE]
			elseif level == 3 then
				curlist = menu[levelvalues[1]][2][UIDROPDOWNMENU_MENU_VALUE]
			elseif level == 4 then
				curlist = menu[levelvalues[1]][2][levelvalues[2]][2][UIDROPDOWNMENU_MENU_VALUE]
			end
			-- Second level header (Module name)
			wipe(info)
			info.isTitle      = 1
			info.text         = BZ[curlist[1]] ~= nil and BZ[curlist[1]] or BF[curlist[1]] ~= nil and BF[curlist[1]] or L[curlist[1]]
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)
			
			-- List the zones
			for key, value in pairs(curlist[2]) do
				addMenuItem(curlist[1], value, key, level)
			end
		end
		-- Close menu item
		wipe(info)
		info.disabled = true
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		info.disabled = nil
		info.text         = CLOSE
		info.func         = function() CloseDropDownMenus() end
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		
		-- Spew("levelvalues", levelvalues)
	end
end

do
	local info = {}
	local statues = {
		{name = L["Turned In"],	status = 2}, -- Quest Right click menu, status change
		{name = L["Completed"], status = 1}, -- Quest Right click menu, status change
		{name = L["In Progress"], status = 0}, -- Quest Right click menu, status change
		{name = L["Abandoned"], status = -1,}, -- Quest Right click menu, status change
		{name = L["Failed"], status = -1}, -- Quest Right click menu, status change
	}
	local EveryQuest_QuestMenu = CreateFrame("Frame", "EveryQuest_QuestMenu")
	EveryQuest_QuestMenu.displayMode = "MENU"
	EveryQuest_QuestMenu.initialize = function(self, level)
		if not level then return end
		for k in pairs(info) do info[k] = nil end
		if (level == 1) then
			wipe(info)
			for key, value in pairs(statues) do
				info.checked = function() return addon:GetStatus(clickedID, value.status) end
				info.func = function() addon:UpdateStatus(clickedID, value.status) end
				info.text = value.name;
				UIDropDownMenu_AddButton(info, level);
			end -- for key, subarray
			wipe(info)
			info.checked = function() return addon:GetStatus(clickedID, "ignored", true) end
			info.func = function() addon:UpdateStatus(clickedID, "ignored", true) end
			info.isNotRadio = true
			info.text = L["Ignore"]; -- Quest Right click menu, status change
			UIDropDownMenu_AddButton(info, level);
			
			wipe(info)
			info.isNotRadio = nil
			info.notCheckable = true
			info.checked = function() return addon:GetStatus(clickedID, "forget", true) end
			info.func = function() addon:UpdateStatus(clickedID, "forget", true) end
			info.text = L["Forget"]; -- Quest Right click menu, status change
			UIDropDownMenu_AddButton(info, level);
			-- Close menu item
			wipe(info)
			info.disabled = true
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)
			wipe(info)
			info.text         = CLOSE
			info.func         = function() CloseDropDownMenus() end
			info.checked      = nil
			info.notCheckable = true
			UIDropDownMenu_AddButton(info, level)
		end -- if level 1
	end
end

do
	-- To fix Blizzard's bug caused by the new "self:SetFrameLevel(2);"
	local function FixFrameLevel(level, ...)
		for i = 1, select("#", ...) do
			local button = select(i, ...)
			button:SetFrameLevel(level)
		end
	end
	function addon.FixMenuFrameLevels()
		local f = DropDownList1
		local i = 1
		while f do
			FixFrameLevel(f:GetFrameLevel() + 2, f:GetChildren())
			i = i + 1
			f = _G["DropDownList"..i]
		end
	end

	-- To fix Blizzard's bug caused by the new "self:SetFrameLevel(2);"
	hooksecurefunc("UIDropDownMenu_CreateFrames", addon.FixMenuFrameLevels)
end

function addon:OnEnable()
	addon:EventsEnable()
end

function addon:OnDisable()
	addon:UnhookAll()
end

function addon:Toggle()
	if EveryQuestFrame:IsShown() then
		EveryQuestFrame:Hide()
	else
		EveryQuestFrame:Show()
		self:UpdateFrame()
	end
end
function addon:OnShow()
	if dbpc.posx and dbpc.posy then
		EveryQuestFrame:ClearAllPoints()
		EveryQuestFrame:SetPoint("TOPLEFT","UIParent", "BOTTOMLEFT", dbpc.posx, dbpc.posy)
	end
end

function addon:SavePosition()
	local Left = EveryQuestFrame:GetLeft()
	local Top = EveryQuestFrame:GetTop()
	if Left and Top then
		dbpc.posx = Left
		dbpc.posy = Top
	end
end

function addon:ResetPosition()
	dbpc.posx = nil
	dbpc.posy = nil
end

function addon:SilentUpgrade()
	local t = {}
	for zone, quests in pairs(dbpc.history) do
		if quests["status"] == nil then
			for uid, quest in pairs(quests) do
				if quest["status"] ~= nil then
					t[uid] = quest
				end
			end
		end
	end
	dbpc.history = t
	
	for uid, quest in pairs(dbpc.history) do
		dbpc.history[uid].id = nil
	end
	dbpc.dbversion = 4
end

-- function addon:ShowConfig()
	-- InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.Filters)
	-- InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.EveryQuest)
-- end

--- Add A Quest to the history
-- @name EveryQuest:AddQuest
-- @param uid Integer > 1: Unique Quest ID
-- @param completed Boolean
-- @return daily boolean, weekly boolean or false
function addon:AddQuest(questid, completed)
	-- self:Debug("AddQuest - questid:"..tostring(questid))
	if dbpc.history == nil then
		dbpc.history = {} 
	end
	if questid then
		local quest = self:GetQuestData(questid)
		if dbpc.history[questid] == nil then
			dbpc.history[questid] = {}
			if completed then
				dbpc.history[questid].status = 1
			else
				dbpc.history[questid].status = 0
			end
		end
		self:SendMessage("EveryQuestDisplayChanged")
		self:SendMessage("EveryQuestDataChanged")
		-- self:UpdateFrame()
		if quest ~= nil then
			return quest.d, quest.w, quest.rr
		end
	end
end

function addon:AddUnknown(uid, category, title)
	if uid and uid ~= nil then
		if db.unknowns == nil then
			db.unknowns = {}
		end
		if db.unknowns[uid] == nil then
			db.unknowns[uid] = EVERYQUEST_RELEASE_REVISION .. "||" .. date("%x") .. "||" .. tostring(title) .. "||" .. tostring(category)
		end
	end
end

local classes = {[1]="WARRIOR",[2]="PALADIN",[3]="HUNTER",[4]="ROGUE",[5]="PRIEST",[6]="DEATHKNIGHT",[7]="SHAMAN",[8]="MAGE",[9]="WARLOCK",[11]="DRUID"}
local races = {[23]="Human",[2]="Orc",[3]="Dwarf",[4]="NightElf",[5]="Undead",[6]="Tauren",[7]="Gnome",[8]="Troll",[9]="Goblin",[10]="BloodElf",[11]="Draenei",[22]="Worgen"}

do
	local filters
	local enabledfilters
	local side = false
	local status = false
	local level = false
	local qtype = false
	local daily = true
	local weekly = true
	local ignored = true
	local level = false
	local race = false
	local class = false
	function addon:Filterer(uid, quest, overrideStatus)
		filters = dbpc.filters
		enabledfilters = dbpc.enabledfilters
		side = false
		status = false
		level = false
		qtype = false
		daily = true
		weekly = true
		ignored = true
		level = false
		race = false
		class = false
		
		if enabledfilters.Faction then
			if quest.s == 1 and filters.Alliance then side = true end
			if quest.s == 2 and filters.Horde then side = true end
			if quest.s == 3 and filters.SideBoth then side = true end
			if (quest.s == 0 or quest.s == nil) and filters.SideNone then side = true end
		else
			side = true
		end
		
		if enabledfilters.Race and quest.rc ~= nil then
			for k, v in pairs(races) do
				if bit.band(quest.rc, bit.lshift(1, k - 1)) > 0 and filters[v] then
					race = true
				end
			end
		else
			race = true
		end
		
		if enabledfilters.Class and quest.cl ~= nil then
			for k, v in pairs(classes) do
				if bit.band(quest.cl, bit.lshift(1, k - 1)) > 0 and filters[v] then
					class = true
				end
			end
		else
			class = true
		end
		
		if enabledfilters.Status then
			if dbpc.ignored[uid] ~= nil and not filters.Ignored then
				ignored = false
			end
		else
			ignored = true
		end
		
		if enabledfilters.Type then
			if quest.t == 1 and filters.GroupQuest then
				qtype = true
			elseif quest.t == 62 and filters.RaidQuest then
				qtype = true
			elseif quest.t == 85 and filters.HeroicQuest then
				qtype = true
			elseif quest.t == 81 and filters.DungeonQuest then
				qtype = true
			elseif quest.t == 41 and filters.PvpQuest then
				qtype = true
			elseif quest.t == nil and filters.NormalQuest then
				qtype = true
			end
			
			if quest.w and not filters.WeeklyQuest then
				weekly = false
			else
				if quest.w and not filters.NormalQuest then
					qtype = true
				end
			end
			
			if quest.d and not filters.DailyQuest then
				daily = false
			else
				if quest.d and not filters.NormalQuest then
					qtype = true
				end
			end
		else
			qtype = true
			daily = true
			weekly = true
		end
		
		if enabledfilters.Status and not overrideStatus then
			local qstatus = nil
			if dbpc.history[uid] then
				qstatus = dbpc.history[uid].status
			end
			if qstatus == -1 and filters.FailedAbandoned then
				status = true
			elseif qstatus == 0 and filters.InProgress then
				status = true
			elseif qstatus == 1 and filters.Completed then
				status = true
			elseif qstatus == 2 and filters.TurnedIn then
				status = true
			elseif qstatus == nil and filters.Unknown then
				status = true
			elseif dbpc.ignored[uid] ~= nil and not filters.Ignored then
				status = true
			end
		else
			status = true
		end
		
		if enabledfilters.Level then
			local qlevel
			if quest.l == nil and quest.r == nil then
				qlevel = 0
			elseif quest.l == nil then
				qlevel = quest.r
			else
				qlevel = quest.l
			end
			if qlevel >= filters.MinLevel and qlevel <= filters.MaxLevel then
				level = true
			end
		else
			level = true
		end
		
		if side and status and ignored and qtype and daily and weekly and level and race and class then
			return true
		else 
			return false
		end
	end
end -- end filterer

local listname
local questlist
function addon:UpdateFrame(e, module, list)
	
	
	if list ~= nil then
		addon.list = list
	end
	if module ~= nil then
		addon.module = module
		listname = self:GetListName(addon.list)
		UIDropDownMenu_SetText(EQDropdown, listname)
	end
	
	if list ~= nil then
		addon:Debug(format("addon:UpdateFrame(%s, %s) %s", tostring(module), tostring(list), tostring(listname)))
	end
	
	addon.countFailed, addon.countProgress, addon.countComplete, addon.countTurnedIn, addon.countUnknown, addon.countIgnored, addon.countHidden = 0,0,0,0,0,0,0
	dbpc.zoneid = addon.list
	dbpc.zonegroup = addon.module
	
	
	if EveryQuestFrame:IsShown() then
		--[[if db.locallist then
			self:Debug("Localized quest list is on")
		end]]
		local buttonid = 1
		local controli = 0
		questlist = self:GetQuestList(addon.module, addon.list)
		-- Spew("questlist", questlist)
		local questcount = 0
		if questlist then
			for _,uid in pairs (questlist) do
					if addon:Filterer(uid, data[uid]) then
						if dbpc.history[uid] ~= nil then
							if dbpc.history[uid].status == -1 then
								addon.countFailed = addon.countFailed + 1
							elseif dbpc.history[uid].status == 0 then
								addon.countProgress = addon.countProgress + 1
							elseif dbpc.history[uid].status == 1 then
								addon.countComplete = addon.countComplete + 1
							elseif dbpc.history[uid].status == 2 then
								addon.countTurnedIn = addon.countTurnedIn + 1
							end
						else
							addon.countUnknown = addon.countUnknown +1
						end
						questcount = questcount +1
						--end
						if dbpc.ignored[uid] then
							addon.countIgnored = addon.countIgnored +1
						end
					else
						addon.countHidden = addon.countHidden +1
					end
				-- end
			end
		end
		-- return nil
		addon.countShown = questcount
		
		if questcount > 0 and not addon.listsorted then
			--self:Print("Sort the list")
			addon:Debug("Sorting Table")
			sort(questlist, function(a,b) return self:SortTable(a,b) end)
			addon.listsorted = true
		end
		FauxScrollFrame_Update(EveryQuestListScrollFrame,questcount,27,16)
		local scrolloffset = FauxScrollFrame_GetOffset(EveryQuestListScrollFrame)

		if questcount then
			if questlist then
				for _,uid in pairs (questlist) do
					if addon:Filterer(uid, data[uid]) then
						controli = controli + 1
						if controli > scrolloffset then
							if buttonid > 27 then 
								break 
							end
							self:UpdateButton(buttonid, data[uid], uid)
							buttonid = buttonid +1		
						end
					end
				end
			end
		end
		for j = buttonid, 27 ,1 do
			button = getglobal("EveryQuestTitle"..j)
			button:Hide()
		end
		addon.frames.Shown:SetText( format(L["%d Shown"], questcount) )  -- Main frame list count
	end
end
--- Get Quest History data for the specified Quest ID
-- @name EveryQuest:GetHistory
-- @param uid Integer > 1: Unique Quest ID
-- @return Table or nil Quest History, returns nil on unknown quest
-- @usage questhistory = EveryQuest:GetHistory(uid)
function addon:GetHistory(uid)
	if dbpc.history[uid] then
		return dbpc.history[uid]
	end
end
--- Get Quest status for the specified Quest ID
-- @name EveryQuest:GetHistoryStatus
-- @param uid Integer > 1: Unique Quest ID
-- @return Integer or nil Numerical Quest Status
-- -1: Failed or Abandoned
-- 0: In Progress
-- 1: Completed but still in the Quest Log
-- 2: Completed and turned in
-- nil: Unknown quest
-- @usage questhistory = EveryQuest:GetHistoryStatus(uid)
function addon:GetHistoryStatus(uid)
	if dbpc.history[uid] then
		return dbpc.history[uid].status or -2, dbpc.history[uid].count
	else
		return -2
	end
end

--- Get Quest Data from a LOD module and return the table and the Category
-- @name EveryQuest:GetQuestData
-- @param uid Integer > 1: Unique Quest ID
-- @return uid
-- @return quest data
-- @usage 
-- uid, quest = EveryQuest:GetQuestData(uid)
function addon:GetQuestData(questid, list)
	local module
	category = QE.quests[questid] and QE.quests[questid].zone or category
	if list == nil then
		list, module = self:GetListIdByName(category)
	end
	
	if data[questid] ~= nil then
		return data[questid], list
	end
	
	if module == nil and list ~= nil then
		module = self:GetModuleFromListID(list)
	end
	-- self:Debug("GetQuestData: uid:"..tostring(questid).." cat:"..tostring(category) .. " module:"..tostring(module).." list:"..tostring(list))
	if module ~= nil and list ~= nil then
		questlist = self:GetQuestList(module, list)
		if quests == false or quests == nil then
			-- self:Debug("GetQuestData: No quests, returning false")
			return nil
		end
		for _,uid in pairs(quests) do
			--for kt,vt in pairs(quest) do self:Print(kt .. " - " .. vt) end
			if uid == questid then
				-- self:Debug("GetQuestData: Found quest in data")
				return data[uid], list
			end
		end
	end
	-- self:Debug("GetQuestData: Search whole module")
	-- try an expanded search
	if module ~= nil then
		for k,part in pairs(lists[module]) do
			for _,uid in pairs(part) do
				--for kt,vt in pairs(quest) do self:Print(kt .. " - " .. vt) end
				if uid == questid then
					-- self:Debug("GetQuestData: Expanded search found quest from data (ID match)")
					return data[uid], k
				end
				if data[uid].n == questname then
					-- self:Debug("GetQuestData: Expanded search found quest from data (Name match)")
					return data[uid], k
				end
			end
		end
	end
	-- self:Debug("GetQuestData: Global Search all modules")
	local modnames = {"Miscellaneous", "Dungeons", "Raids", "Classes", "Professions", "Battlegrounds", "World Events", "Northrend", "Outland", "Eastern Kingdoms", "Kalimdor", "The Maelstrom"}
	for _,modname in pairs(modnames) do
		if self:LoadModule(modname) then
			for k,part in pairs(lists[modname]) do
				for _,uid in pairs(part) do
					--for kt,vt in pairs(quest) do self:Print(kt .. " - " .. vt) end
					if uid == questid then
						zid = k
						-- self:Debug("GetQuestData: Global search found quest from data (ID match)")
						return data[uid], k
					end
					if data[uid].n == questname then
						zid = k
						-- self:Debug("GetQuestData: Global search found quest from data (name match)")
						return data[uid], k
					end
				end
			end
		end
	end
		
	return nil
end

local que = {}
local doneList = {}
local tt = CreateFrame("GameTooltip", "EveryQuestScanningTooltip", UIParent, "GameTooltipTemplate")
local ttlt = EveryQuestScanningTooltipTextLeft1
local ttScanFrame = CreateFrame("frame")
ttScanFrame:Hide()
do
    tt:SetScript("OnTooltipSetQuest", function(self, ...)
		local uid = que[1]
		--print(uid)
		if (not uid) then
			--print("hide ttscanframe")
            ttScanFrame:Hide()
        end
        local questName = ttlt:GetText()
		db.localized[locale][uid] = questName
		addon:UpdateButtonTextByUID(uid)
	   table.remove(que, 1)
        local uid = que[1]
        if not uid then
            ttScanFrame:Hide()
            return
        end
        self.questId = uid
    end)

    local interval, delay = 1, 0
    ttScanFrame:SetScript("OnUpdate", function(self, elapsed)
        delay = delay + elapsed
        if delay > interval then
            tt:SetHyperlink("quest:"..tt.questId)
            delay = 0
        end
    end)
end
function addon:StartTTScan()
    local uid = que[1]
    tt.questId = uid
    ttScanFrame:Show()
    return tt:SetHyperlink( ("quest:%d"):format(uid) )
end
function addon:StopTTScan()
    ttScanFrame:Hide()
end

function addon:GetLocalizedQuestName(uid)
	if db.localized[locale][uid] then
		self:Debug(format("Found %s (%d) in the DB", tostring(db.localized[locale][uid]), uid))
		return db.localized[locale][uid]
	else
		local name = nil
		local inQue = false
		for _,v in pairs(que) do
			if v == uid then
				inQue = true
				break
			end
		end
		if not inQue then
			table.insert(que, uid)
		end
		if not ttScanFrame:IsShown() then
			self:StartTTScan()
		end
		return nil
	end
end

function addon:BuildButtonText(uid, quest)
	local qTag = ""
	local strLM = ""
	local level
	local text
	
	if quest.t then
		qTag = qtypes[quest.t]
	end
	if quest.d then
		qTag = qTag .. L["Y"] -- Short for 'Daily', ie Daily Quest
	end
	if quest.w then
		qTag = qTag .. L["W"] -- Short for 'Weekly', ie Weekly Quest
	end
	local level
	if quest.l then
		level = quest.l
	else 
		if quest.r then
			level = format(L["r%d"], quest.r) -- Short for 'required level'
		else
			level = "--"
		end
	end
	if Loremaster and Loremaster:GetBoolFromID(uid) then
		strLM = L[" [L]"]
	end
	--print("set text")
	local button_text
	if db.locallist then
		--self:Debug("Localized quest list is on")
		local name = addon:GetLocalizedQuestName(uid)
		if name then
			button_text = format("[%s%s] %s%s", level, qTag, name, strLM)
		else
			button_text = format("[%s%s] %s%s", level, qTag, quest.n, strLM)
		end
	else
		button_text = format("[%s%s] %s%s", level, qTag, quest.n, strLM)
	end
	local color
	local repeating = quest.d or quest.w or quest.rr
	if repeating then
		color = addon:RGB2Hex(unpack(db.colors.Repeat))
	end
	if dbpc.history[uid] then
		local his = dbpc.history[uid]
		if his.status ~= nil then
			if his.status == -1 then
				if not repeating then
					color = addon:RGB2Hex(unpack(db.colors.Failed))
				end
			elseif his.status == 0 then
				color = addon:RGB2Hex(unpack(db.colors.Progress))
			elseif his.status == 1 then
				color = addon:RGB2Hex(unpack(db.colors.Complete))
			elseif his.status == 2 then
				if not repeating or ((quest.d and his.completed ~= nil and his.completed > (time() - (86400 - GetQuestResetTime()))) or (quest.w and his.completed ~= nil and his.completed > (time() - (604800 - GetQuestResetTime())))) then
					color = addon:RGB2Hex(unpack(db.colors.TurnedIn))
				end
			end
		else
			if not repeating then
				color = addon:RGB2Hex(unpack(db.colors.Unknown))
			end
		end
	else
		if not repeating then
			color = addon:RGB2Hex(unpack(db.colors.Unknown))
		end
	end
	
	if dbpc.ignored[uid] then
		color = addon:RGB2Hex(unpack(db.colors.Ignored))
	end
	-- addon:Debug(button_text)
	return addon:Colorize(color, button_text)
end

function addon:UpdateButtonTextByUID(uid)
	for bid,duid in pairs(questdisplay) do
		if duid == uid then
			button:SetText(addon:BuildButtonText(uid, data[uid]))
			break
		end
	end
end

function addon:UpdateButton(buttonid, quest, uid)
	local button = getglobal("EveryQuestTitle"..buttonid)
	button:SetNormalTexture("")
	button:SetText("")
	if not questdisplay[buttonid] or questdisplay[buttonid] ~= uid then
		questdisplay[buttonid] = uid
	end
	
	button:SetText(addon:BuildButtonText(uid, quest))
	button:Show()
end

local quest
function addon:SetHyperlink(self, value)
	-- Spew("sethyperlink", value)
	-- print(string.match(value, "^quest:(%d+)"))
	if string.find(value, "^quest:") then
		local uid = tonumber(string.match(value, "^quest:(%d+)"))
		-- Spew("uid", uid)
		local history = dbpc.history[uid]
		-- Spew("quest", quest)
		local queststatus = L["Unknown"] -- Quest Status
		local status = -2
		if history ~= nil then
			if history.status == -1 then
				queststatus = L["Failed or Abandoned"] -- Quest Status
			elseif history.status == 0 then
				queststatus = L["In Progress"] -- Quest Status
			elseif history.status == 1 then
				queststatus = L["Completed"] -- Quest Status
			elseif history.status == 2 then
				queststatus = L["Turned In"] -- Quest Status
			end
		end
		GameTooltip:AddLine(" ", addon:GetColor("FFFFFF"))
		GameTooltip:AddLine( addon:Colorize(addon:GetColor(history and history.status or status), L["Status: %s"]:format(queststatus)) ) -- Tooltip quest status, %s = localized quest status
		
		-- if db.tooltipShowRep and data[uid] ~= nil and data[uid].rep ~= nil then
		if data[uid] ~= nil and data[uid].rep ~= nil then
			for rep,amount in pairs(data[uid].rep) do
				if amount > 0 then
					GameTooltip:AddLine( L["Increases: %s by |cff00ff00%d|r"]:format(factionMap[rep] or L["Unknown"], amount), addon:GetColor("FFFFFF"))
				else
					GameTooltip:AddLine( L["Decreases: %s by |cffff7979%d|r"]:format(factionMap[rep] or L["Unknown"], amount), addon:GetColor("FFFFFF"))
				end
			end
		end
		
		if history ~= nil then
			if history.completed then
				completedline = L["Completed%s: %s"] -- Tooltip, %s = daily/weekly quest complete count, %s = timediff string
				local repeatcount = ""
				if history.count then
					repeatcount = L[" (%d Times)"]:format(history.count) -- Tooltip, %d = number of times completed
				end
				completedline = (completedline):format(repeatcount, addon:timeDiff(history.completed))
			end
			if tostring(history.completed, true) > tostring(history.failed, true) and tostring(history.completed, true) > tostring(history.abandoned, true) then
				GameTooltip:AddLine(completedline,addon:GetColor("FFFFFF"))
			else
				if history.completed then
					GameTooltip:AddLine(completedline,addon:GetColor("FFFFFF"))
				end
				if history.failed then
					GameTooltip:AddLine( L["Failed: %s"]:format(addon:timeDiff(history.failed)), addon:GetColor("FFFFFF")) -- Tooltip, %s = timediff string
				end
				if history.abandoned then
					GameTooltip:AddLine( L["Abandoned: %s"]:format(addon:timeDiff(history.abandoned)), addon:GetColor("FFFFFF")) -- Tooltip, %s = timediff string
				end
			end
			
			if history.imported then
				local importedfrom
				if history.imported == 1 then
					importedfrom = L["QuestGuru"] -- Tooltip, import line
				elseif history.imported == 2 then
					importedfrom = L["QuestHistory"] -- Tooltip, import line
				elseif history.imported == 3 then
					importedfrom = L["Server Query"] -- Tooltip, import line
				else
					importedfrom = CALENDAR_TYPE_OTHER -- Tooltip, import line
				end
				GameTooltip:AddLine( L["Imported From: %s"]:format(importedfrom), addon:GetColor("FFFFFF")) -- Tooltip, %s = localized origin name
			end
		end
	end
end

function addon:ButtonEnter(self)
	local index = self:GetID()
	GameTooltip_SetDefaultAnchor(GameTooltip, self)
	GameTooltip:SetHyperlink("quest:"..questdisplay[index])
	GameTooltip:Show()
end

function addon:ButtonClick(self, button)
	local uid = questdisplay[self:GetID()]
	-- Spew("uid", uid)
	clickedID = uid
	if button == "LeftButton" then
		if ( IsModifiedClick() ) then
			if ( IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow():IsVisible() ) then
				local quest = data[uid]
				local questLink = EveryQuest:CreateQuestLink(uid, quest.n or L["Unknown"], quest.l or -1);
				if ( questLink ) then
					ChatEdit_InsertLink(questLink);
				end
			end
		else
			local history = dbpc.history[uid]
			-- open lightheaded if enabled
			if IsAddOnLoaded("Lightheaded") then
				
				QuestLogFrame:Show()
				LightHeaded:UpdateFrame(uid, LightHeaded:GetQIDOffsets(uid))
				-- QuestLogFrame:ClearAllPoints()
				-- QuestLogFrame:SetPoint("TOPLEFT",EveryQuestFrame, "TOPLEFT", 360, 0)
			end
			if history and (history.status == 0 or history.status == 1) then
				index = GetQuestLogIndexByID(uid)
				if index then
					SelectQuestLogEntry(index)
				end
				ShowUIPanel(QuestLogFrame)
				-- QuestLogFrame:ClearAllPoints()
				-- QuestLogFrame:SetPoint("TOPLEFT",EveryQuestFrame, "TOPLEFT", 360, 0)
			end
		end
	elseif button == "RightButton" then
		-- open quest menu
		ToggleDropDownMenu(1, nil, EveryQuest_QuestMenu, self:GetName(), 0, 0)
	end
end

function addon:GetStatus(uid, status, ignored)
	--self:Debug("GetStatus - did:"..tostring(displayid)..", status:"..tostring(queststatus))
	if ignored and status == "ignored" then
		if dbpc.ignored[uid] then
			return true
		else
			return false
		end
	else
		if dbpc.history[uid] and dbpc.history[uid].status and dbpc.history[uid].status == status then
			return true
		else
			return false
		end
	end
end

function addon:UpdateStatus(uid, queststatus, ignored, questid)
	-- local uid = questdisplay[displayid]

	if ignored and queststatus == "ignored" then
		if dbpc.ignored[uid] == nil then
			dbpc.ignored[uid] = true
		else
			dbpc.ignored[uid] = nil
		end
	elseif ignored and queststatus == "forget" then
		if dbpc.history[uid] then
			dbpc.history[uid]["status"] = nil
		end
	else
		if dbpc.history[uid] == nil then
			dbpc.history[uid] = {}
		end
		dbpc.history[uid].status = queststatus
	end
	if dbpc.history[uid] ~= nil then
		dbpc.history[uid]["imported"] = nil
	end
	self:SendMessage("EveryQuestDisplayChanged")
	self:SendMessage("EveryQuestDataChanged")
end

local function pairsByKeys (t, f)
      local a = {}
      for n in pairs(t) do table.insert(a, n) end
      table.sort(a, f)
      local i = 0      -- iterator variable
      local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
      end
      return iter
    end

function addon:UpdateSortList()
	--wipe(currentsort)
	--self:Print("UpdateSortList")
	local list = {}
	local list2 = {}
	for k,v in pairs(dbpc.sort) do
		-- if dbpc.enabledsort[k] then
			if list[v["Weight"]] == nil then
				list[v["Weight"]] = k
			else
				list[v["Weight"] +1] = k
			end
			--self:Print(k)
		-- end
	end
	for k,v in pairsByKeys(list) do
		list2[#list2 + 1] = v
		--self:Print(v)
	end
	--Spew("list", list)
	currentsort = list2
	addon.listsorted = false
	--Spew("list2", list2)
end

--[[function addon:SortTable(a,b)
	if (a.d or 0) == (b.d or 0) then
		if (a.t or 0) == (b.t or 0) then
			if (a.l or a.r or 0) == (b.l or b.r or 0) then
				if a.n == b.n then
					return false
				else
					return a.n > b.n
				end
			else
				return (a.l or a.r or 0) > (b.l or b.r or 0)
			end
		else 
			return (a.t or 0) > (b.t or 0)
		end
	else 
		return (a.d or 0) > (b.d or 0)
	end
end]]

local a, b = {}, {}
function addon:SortTable(uid1,uid2)
	local f = currentsort
	-- local a = new()
	-- local b = new()
	wipe(a)
	wipe(b)
	a.l = (data[uid1].l ~= nil and data[uid1].l) or (data[uid1].r ~= nil and data[uid1].r) or 0
	b.l = (data[uid2].l ~= nil and data[uid2].l) or (data[uid2].r ~= nil and data[uid2].r) or 0
	a.d = data[uid1].d
	b.d = data[uid2].d
	a.w = data[uid1].w
	b.w = data[uid2].w
	a.n = db.localized[locale][uid1] ~= nil and db.localized[locale][uid1] or data[uid1].n
	b.n = db.localized[locale][uid2] ~= nil and db.localized[locale][uid2] or data[uid2].n
	a.t = data[uid1].t
	b.t = data[uid2].t
	if a["l"] == nil then if a["r"] == nil then a["l"] = 0 else a["l"] = a["r"] end end
	if b["l"] == nil then if b["r"] == nil then b["l"] = 0 else b["l"] = b["r"] end end
	if (a[f[5]] or 0) == (b[f[5]] or 0) then
		if (a[f[4]] or 0) == (b[f[4]] or 0) then
			if (a[f[3]] or 0) == (b[f[3]] or 0) then
				if (a[f[2]] or 0) == (b[f[2]] or 0) then
					if (a[f[1]] or 0) == (b[f[1]] or 0) then
						return false
					else
						if dbpc.sort[f[1]].Dir == 2 then
							return (a[f[1]] or 0) > (b[f[1]] or 0)
						else
							return (a[f[1]] or 0) < (b[f[1]] or 0)
						end
					end
				else
					if dbpc.sort[f[2]].Dir == 2 then
						return (a[f[2]] or 0) > (b[f[2]] or 0)
					else
						return (a[f[2]] or 0) < (b[f[2]] or 0)
					end
				end
			else
				if dbpc.sort[f[3]].Dir == 2 then
					return (a[f[3]] or 0) > (b[f[3]] or 0)
				else
					return (a[f[3]] or 0) < (b[f[3]] or 0)
				end
			end
		else 
			if dbpc.sort[f[4]].Dir == 2 then
				return (a[f[4]] or 0) > (b[f[4]] or 0)
			else
				return (a[f[4]] or 0) < (b[f[4]] or 0)
			end
		end
	else 
		if dbpc.sort[f[5]].Dir == 2 then
			return (a[f[5]] or 0) > (b[f[5]] or 0)
		else
			return (a[f[5]] or 0) < (b[f[5]] or 0)
		end
	end
	-- del(a)
	-- del(b)
end

function addon:GetQuestList(module, list)
	if self:LoadModule(module) then
		return lists[module][list]
	else
		return false
	end
end

function addon:LoadModule(module)
	if module ~= nil then
		local modname = "EveryQuest_"..gsub(module, " ", "_")
		if not lists[module] then
			local _, _, _, enabled = GetAddOnInfo(modname)
			if enabled then
				-- self:Print( format(L["Loading %s Quest Data"], module) ) -- LOD status, %s = localized module name
				local succ,reason = LoadAddOn(modname)
				if succ ~= 1 then
					self:Print( format(L["Could not load %s Quest Data because of %s"], module, reason) ) -- LOD status, %s = localized module name, %s = failure reason from WoW API
					return false
				end
				collectgarbage("collect")
			else
				self:Print( format(L["Requires LOD Module: %s"], modname) ) -- LOD status, %s = localized module name
				return false
			end
		end
		-- self:Debug(format("LoadModule: %s lists exists", module))
		return true
	end
	return false
end


function addon:GetColor(hex)
	if hex == 1 then
		return addon:RGB2Hex(unpack(db.colors.Complete))
	elseif hex == -1 then
		return addon:RGB2Hex(unpack(db.colors.Failed))
	elseif hex == 2 then
		return addon:RGB2Hex(unpack(db.colors.TurnedIn))
	elseif hex == 0 then
		return addon:RGB2Hex(unpack(db.colors.Progress))
	elseif hex == -2 then -- Unknown
		return addon:RGB2Hex(unpack(db.colors.Unknown))
	end
	local rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)
	return tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255
end

function addon:CreateQuestLink(questid, questname, questlevel)
	if questlevel == nil then questlevel = -1 end
	self:Debug("CreateQuestLink - quest:"..tostring(questid)..":"..tostring(questlevel))
	return "\124cffffff00\124Hquest:"..questid..":"..questlevel.."\124h["..questname.."]\124h\124r"
end

function EveryQuest_ScrollFrame_Update()
	addon:UpdateFrame()
end


function addon:timeDiff(timestamp)
	--[["""
		Returns a string representing the amount of time that has passed since timestamp
	"""]]
    local now = time()
	local amount = now - timestamp
	local value
	local seconds, minutes, hours, days
    --If the difference is positive "ago" - negative "away"

	--amount = amount + DAY + HOUR*5
	
	if amount >= (DAY * 10) then
		return date("%Y/%m/%d %I%p", timestamp) -- timeDiff string, date() format for times over 10 days old
	end
	
	if (amount >= DAY) and (amount < (DAY * 10)) then
		-- between one day and 30 days
		days = math.floor(amount/DAY)
		hours = amount%DAY
		hours = math.floor(hours/HOUR)
		if days ~= 1 then
			if hours ~= 0 then
				return format(L["%d days %d hr ago"], days, hours) -- timeDiff string, %d = digit, %d = digit
			else
				return format(L["%d days ago"], days) -- timeDiff string, %d = digit
			end
		else
			if hours ~= 0 then
				return format(L["1 day %d hr ago"], days, hours) -- timeDiff string, %d = digit
			else
				return L["1 day ago"] -- timeDiff string
			end
		end
	end
  
	if (amount < DAY) and (amount >= HOUR) then
		-- between one hour and one day
		--value = format("%H hr %M min ago", amount)
		hours = math.floor(amount/HOUR)
		minutes = amount%HOUR
		minutes = math.floor(minutes/MINUTE +.5)
		--return  .. " between one hour and one day"
		if minutes ~= 0 then
			return format(L["%d hr %d min ago"], hours, minutes) -- timeDiff string, %d = digit, %d = digit
		else
			return format(L["%d hr ago"], hours) -- timeDiff string, %d = digit
		end
	end
	
	if (amount < HOUR and amount >= MINUTE) then
		-- between one minute and one hour
		if self:round(amount / MINUTE) > 1 then
			return format(L["%d minutes ago"], self:round(amount / MINUTE)) -- timeDiff string, %d = digit
		else
			return L["1 minute ago"] -- timeDiff string
		end
	end
	
	if amount > 1 then
		return format(L["%d seconds ago"], amount) -- timeDiff string
	else
		return L["1 second ago"] -- timeDiff string
	end
end

function addon:round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

--- EOF ---