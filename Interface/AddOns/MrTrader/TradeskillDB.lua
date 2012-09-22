-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):GetLocale("MrTrader", true);

-- Options for Configuration in the DB
local Options = {
	type = "group",
	get = function(item) return MrTrader.db.profile[item[#item]] end,
	set = function(item, value) MrTrader.db.profile[item[#item]] = value end,
	plugins = {},
	args = {
		menuOptions  = {
			type = "group",
			name = "Menu Options",
			order = 10,
			args = {
				showOppositeFaction = {
					type = "toggle",
					name = L["Show Opposing Faction Alts"],
					desc = L["Will show your alts from the opposing faction in the menu."],
					width = "full",
					order = 11,
				},
				showSecondarySkills = {
					type = "toggle",
					name = L["Show Minor Skills for Alts"],
					desc = L["Will show Cooking, Smelting, Runeforging, and First Aid on other characters."],
					width = "full",
					order = 12,
				},
			},
		},
		
		tradeskillOptions = {
			type = "group",
			name = "Tradeskill Window",
			order = 15,
			args = {
				useTradeskillWindow = {
					type = "toggle",
					name = L["Use Tradeskill Window"],
					desc = L["Will use MrTrader's tradeskill window in place of the default."],
					width = "full",
					order = 16,
				},
				movableTradeskillWindow = {
					type = "toggle",
					name = L["Undock Window"],
					desc = L["Will let the user place the Tradeskill Window anywhere."],
					width = full,
					order = 17,
				},
				rememberFilters = {
					type = "toggle",
					name = L["Remember Selected Category"],
					desc = L["Will remember the selected category for each tradeskill."],
					width = "full",
					order = 18,
				},
				shouldDisplayListTooltip = {
					type = "toggle",
					name = L["Display Tooltips in Skill List"],
					desc = L["Will display crafted item tooltips when hovering in the skill list."],
					width = "full",
					order = 19,
				},
			},
		},
		
		commandOptions = {
			type = "group",
			name = "Command Options",
			order = 20,
			args = {
				linkCommandType = {
					type = "group",
					name = "Listen to Commands From...",
					guiInline = true,
					order = 10,
					args = {
						respondToWhispers = {
							type = "toggle",
							name = "Whispers",
							desc = L["Will respond to whispers sent to you asking for skill links."],
							order = 21,
						},
						respondToGuild = {
							type = "toggle",
							name = "Guild Chat",
							desc = L["Will respond to guild messages asking for skill links."],
							order = 22,
						},
						respondToRaid = {
							type = "toggle",
							name = "Raid and Party Chat",
							desc = L["Will respond to raid and party messages asking for skill links."],
							order = 23,
						},
					},
				},

				linkPrivacyOptions = {
					type = "group",
					name = "Privacy Options",
					guiInline = true,
					order = 30,
					args = {
						whisperAltSkills = {
							type = "toggle",
							name = L["Whisper Skills for Alts"],
							desc = L["Will search your alts for skill links when responding to whisper commands."],
							width = "full",
							order = 31,
						},
						showAllFullLinks = {
							type = "toggle",
							name = "Show All Full Links",
							desc = "Will show all matching links in response to !link/!full, instead of the highest matching.",
							order = 32,
						},
						includePlayerNames = {
							type = "toggle",
							name = "Include Character Names",
							desc = "Will show the name of the character with the skill being linked in whispered responses.",
							width = "full",
							order = 33,
						},
					},
				},
			},
		},
	}
}

-- Defaults for options
local Defaults = {
	profile = {
		showOppositeFaction = true,
		showSecondarySkills = true,
		respondToWhispers = true,
		respondToGuild = false,
		respondToRaid = false,
		whisperAltSkills = false,
		includePlayerNames = false,
		showAllFullLinks = true,
		useTradeskillWindow = true,
		rememberFilters = true,
		shouldDisplayListTooltip = true,
		savedFilter = {},
		windowLocation = {},
	},
	realm = {
		skills = {},
	}
}

--local ConsoleOptions = {
--	type = "group",
--	handler = MrTrader,
--	args = {
--		config = {
--			type = "execute",
--			name = L["Configure"];
--			desc = L["Open configuration dialog"],
--			func = function()
--				InterfaceOptionsFrame_OpenToCategory(MrTrader.optionFrames.main);
--			end
--		},
--	},
--}

local ConsoleCmds = {
	"mrt",
	"mrtrader",
}

-- List of tradeskills
-- Key: Spell ID
-- Value: true if this skill has a tradeskill link you can share
local TradeSkills = {
	[2259] = { linkable = true, primary = true }, -- Alchemy
	[78670] = { linkable = false, primary = false },-- Archaeology 
	[2018] = { linkable = true, primary = true }, -- Blacksmithing
	[2550] = { linkable = true, primary = false }, -- Cooking
	[7411] = { linkable = true, primary = true }, -- Enchanting
	[4036] = { linkable = true, primary = true }, -- Engineering
	[3273] = { linkable = true, primary = false }, -- First Aid
	[45357] = { linkable = true, primary = true }, -- Inscription
	[25229] = { linkable = true, primary = true }, -- Jewelcrafting
	[2108] = { linkable = true, primary = true }, -- Leatherworking
	[53428] = { linkable = false, primary = false, classSkill = true }, -- Runeforging
	[2575] = { linkable = false, primary = false, alias = 2656 }, -- Mining, used for matching only
	[2656] = { linkable = false, primary = false }, -- Smelting
	[3908] = { linkable = true, primary = true }, -- Tailoring
}

function MrTrader:IsTradeskillSpell(spellName)
	for spellId, _ in pairs(TradeSkills) do
		if( GetSpellInfo(spellId) == spellName ) then
			return true;
		end
	end
	
	return false;
end

function MrTrader:AllTradeskills()
	return TradeSkills;
end

function MrTrader:ClassTradeskills()
	local result = {};
	
	for spellId, spellInfo in pairs(TradeSkills) do
		if( spellInfo.classSkill ) then
			tinsert(result, spellId);
		end
	end
	
	return result;
end

function MrTrader:Load()
	self.tradeskills = TradeSkills;
	self.db = LibStub("AceDB-3.0"):New("MrTraderDB", Defaults, "Default");

	-- Convert from v0.1 to v0.3 DBs
	if self.db.factionrealm.skills then
		if self.db.realm.skills then
			self.db.realm.skills = self:TableJoin(self.db.realm.skills, self.db.factionrealm.skills);
		else
			self.db.realm.skills = self.db.factionrealm.skills;
		end

		self.db.factionrealm.skills = nil;

		for name, skillTable in pairs(self.db.realm.skills) do
			skillTable["faction"] = UnitFactionGroup("player");
			self.db.realm.skills[name] = skillTable;
		end
	end
	
	-- Set a DB version for easier upgrading post v0.3
	if self.db.global.version == nil then
		self.db.global.version = 2;
	end
	
	self:RegisterOptions();
end

function MrTrader:RegisterOptions()
	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db);
	--Options.plugins["profiles"] = { profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db) };
	
	--local config = LibStub("AceConfig-3.0");
	--config:RegisterOptionsTable("MrTrader", ConsoleOptions, ConsoleCmds);
	for _, command in ipairs(ConsoleCmds) do
		self:RegisterChatCommand(command, "OnChatCommand");
	end
	
	local registry = LibStub("AceConfigRegistry-3.0");
	registry:RegisterOptionsTable("MrTrader Options", Options);
	registry:RegisterOptionsTable("MrTrader Profiles", profiles);
	
	local dialog = LibStub("AceConfigDialog-3.0");
	self.optionFrames = {
		main = dialog:AddToBlizOptions("MrTrader Options", L["MrTrader"]),
		profiles = dialog:AddToBlizOptions("MrTrader Profiles", L["Profiles"], L["MrTrader"]),
	};
end

function MrTrader:OnChatCommand()
	InterfaceOptionsFrame_OpenToCategory(MrTrader.optionFrames.main);
end

function MrTrader:QuerySkills()
	if(GetProfessions == nil) then
		-- Call the existing version for 3.x clients (for now)
		return MrTrader:QuerySkillsWrath();
	end

	local currentPlayer = UnitName("player");
	local currentFaction = UnitFactionGroup("player");	
	skillTable = {};
	local oldTable = {};
	local didGrabUpdate = true;
	
	if self.db.realm.skills[currentPlayer] then
		oldTable = self.db.realm.skills[currentPlayer];
	end
	
	local profTable = MrTrader:TablePack(GetProfessions());
	local profCount = getn(profTable);
	for i=1, profCount do
		name, icon, rank, maxrank, numspells, spelloffset, skillline = GetProfessionInfo(profTable[i]); 
		
		for k=1, numspells do
		  	local _, skillId = GetSpellBookItemInfo(spelloffset + k, "spell")
		  	local _, tradeLink = GetSpellLink(skillId);
		
			if(tradeLink ~= nil) then
				skillTable[skillId] = tradeLink;
			elseif(oldTable[skillId] ~= nil) then
				-- No link was found, but we have an old link for it... what?
				skillTable[skillId] = oldTable[skillId];
				didGrabUpdate = false;
			end
		end
	end
	
	if (self:TableSize(skillTable) > 0 and profCount > 0 )then
		skillTable["ignored"] = oldTable["ignored"];
		skillTable["faction"] = currentFaction;
		
		self.db.realm.skills[currentPlayer] = skillTable;
		return didGrabUpdate;
	elseif( profCount == 0 ) then
		self.db.realm.skills[currentPlayer] = nil;
		return true;
	else
		return false;
	end	
end

function MrTrader:QuerySkillsWrath()
	local currentPlayer = UnitName("player");
	local currentFaction = UnitFactionGroup("player");	
	local skillTable = {};
	local oldTable = {};
	local didGrabUpdate = true;
	
	if self.db.realm.skills[currentPlayer] then
		oldTable = self.db.realm.skills[currentPlayer];
	end

	for skillID, value in pairs(TradeSkills) do
		usesLink = value.linkable;
		skillName = GetSpellInfo(skillID);
		if skillName ~= nil then
			doesExist, tradeLink = GetSpellLink(skillName);
		
			if doesExist and tradeLink then
				skillTable[skillID] = tradeLink;
			elseif doesExist and oldTable[skillID] then
				skillTable[skillID] = oldTable[skillID];
				didGrabUpdate = false;
			elseif doesExist and value.alias == nil then
				skillTable[skillID] = false;
				if usesLink then
					didGrabUpdate = false;
				end
			end
		end
	end
	
	if self:TableSize(skillTable) > 0 then
		-- Saving the new table, copy over values that we want to keep
		skillTable["ignored"] = oldTable["ignored"];
		skillTable["faction"] = currentFaction;	

		self.db.realm.skills[currentPlayer] = skillTable;
		return didGrabUpdate;
	else
		self.db.realm.skills[currentPlayer] = nil;
		return true;
	end
end

function MrTrader:GetSkillRank(skillLink)
	local _, _, currentRank, maxRank = strsplit(':', skillLink, 4);
	
	return tonumber(currentRank), tonumber(maxRank);
end

function MrTrader:GetBestSkillLink(skillID)
	local currentFaction = UnitFactionGroup("player");	
	local currentPlayer = UnitName("player");
	local link = nil;
	local allMatches = {};
		
	local currentTable = self.db.realm.skills[currentPlayer];

	if self.db.realm.skills[currentPlayer] ~= nil then
		if self.db.realm.skills[currentPlayer][skillID] ~= nil then
			link = self.db.realm.skills[currentPlayer][skillID];
			tinsert(allMatches, { currentPlayer, link });
		end
	end
		
	if self.db.profile.whisperAltSkills then
		local currentLink = nil;
		local currentRank = 0;
	
		for playerName, skillList in pairs(self.db.realm.skills) do
			-- Find out if we need to search this character, and if it is in the same faction
			local sameFaction = true;
			if skillList["faction"] and skillList["faction"] ~= currentFaction then
				sameFaction = false;
			end
			
			if skillList ~= nil and currentPlayer ~= playerName then
				if sameFaction and skillList[skillID] and not self:CharacterIsIgnored(playerName) then
					local skillRank = MrTrader:GetSkillRank(skillList[skillID]);
					tinsert(allMatches, { playerName, skillList[skillID] });
					if skillRank > currentRank then
						currentLink = skillList[skillID];
						currentRank = skillRank;
					end
				end
			end
		end
		
		if( link == nil ) then
			link = currentLink;
		end
	end
	
	return link, allMatches;
end

function MrTrader:GetSkillTable()
	return self.db.realm.skills;
end

function MrTrader:RemoveCharacter(name)
	self.db.realm.skills[name] = nil;
end

function MrTrader:IgnoreCharacter(name)
	self.db.realm.skills[name]["ignored"] = true;
end

function MrTrader:UnignoreCharacter(name)
	self.db.realm.skills[name]["ignored"] = nil;
end

function MrTrader:CharacterIsIgnored(name)
	return self.db.realm.skills[name]["ignored"];
end

function MrTrader:ShouldUseCustomWindow()
	return self.db.profile.useTradeskillWindow;
end

function MrTrader:TradeskillWindowIsMovable()
	return self.db.profile.movableTradeskillWindow;
end

function MrTrader:ShouldDisplaySkillListTooltip(value)
	if( value ) then
		self.db.profile.shouldDisplayListTooltip = value;
	end

	return self.db.profile.shouldDisplayListTooltip;
end

-----
-- Methods for getting a tradeskill spellIDs
-----
function MrTrader:GetSpellIDForRecipe(recipeLink)
	local spellID = strmatch(recipeLink, "enchant:(%d+)|");

	return spellID;
end

function MrTrader:MatchPartialCraftSkillName(partialName, matchAny)
	local matchedSkillID = nil;
	local matchCount = 0;
	
	partialName = partialName:upper();

	for skillID, skillValue in pairs(TradeSkills) do
		skillCanCraft = skillValue.linkable;
		if skillCanCraft or matchAny then
			skillName = GetSpellInfo(skillID);
			if skillName ~= nil then
				skillName = skillName:upper();
				start = string.find( skillName , partialName , 1, true );
			
				if start then 
					matchCount = matchCount + 1;
					matchedSkillID = skillValue.alias or skillID;
				end
			end
		end
	end
	
	if matchCount > 1 then
		return "ambiguous";
	else
		return matchedSkillID;
	end
end

-----
-- Storing and Restoring A Filter
-----
function MrTrader:StoreFilter(skillID, category, skill, checkboxStates, isExpanded, sortFilter, sortAscending)
	if( self.db.profile.savedFilter == nil ) then
		self.db.profile.savedFilter = {};
	end
	
	if( skillID and self.db.profile.rememberFilters ) then
		self.db.profile.savedFilter[skillID] = {};
		self.db.profile.savedFilter[skillID].checkboxFilters = MRTUtils_CopyTable(checkboxStates);
		self.db.profile.savedFilter[skillID].category = MRTUtils_CopyTable(category);
		self.db.profile.savedFilter[skillID].isExpanded = (isExpanded == true);
		self.db.profile.savedFilter[skillID].sortFilter = sortFilter;
		self.db.profile.savedFilter[skillID].sortAscending = sortAscending;
		if( category ) then
			self.db.profile.savedFilter[skillID].category.subgroups = nil;
		end
		self.db.profile.savedFilter[skillID].skill = MRTUtils_CopyTable(skill);
	end
end

function MrTrader:RestoreFilter(skillID)
	local category = nil;
	local skill = nil;
	local checkboxFilters = {};
	local isExpanded = true;
	local sortFilter = nil;
	local sortAscending = true;
	
	if( self.db.profile.savedFilter and self.db.profile.savedFilter[skillID] and self.db.profile.rememberFilters ) then
		category = self.db.profile.savedFilter[skillID].category;
		skill = self.db.profile.savedFilter[skillID].skill;
		checkboxFilters = self.db.profile.savedFilter[skillID].checkboxFilters;
		if( self.db.profile.savedFilter[skillID].isExpanded ~= nil ) then
			isExpanded = self.db.profile.savedFilter[skillID].isExpanded;
		end
		if( self.db.profile.savedFilter[skillID].sortFilter ~= nil ) then
			sortFilter = self.db.profile.savedFilter[skillID].sortFilter;
			sortAscending = self.db.profile.savedFilter[skillID].sortAscending;
		end
		self.db.profile.savedFilter[skillID] = nil;
	end	
	
	return category, skill, (checkboxFilters or {}), isExpanded, sortFilter, sortAscending;
end

-----
-- Storing and Restoring Window Location
-----
function MrTrader:StoreLocation(frameName, frame)
	local point = {};
	
	point.point, point.relativeTo, point.relativePoint, point.xOfs, point.yOfs = frame:GetPoint();
	self.db.profile.windowLocation[frameName] = point;
end

function MrTrader:RestoreLocation(frameName, frame)
	if( self.db.profile.windowLocation[frameName] ~= nil ) then
		local point = self.db.profile.windowLocation[frameName];
		frame:ClearAllPoints();
		frame:SetPoint(point.point, point.relativeTo, point.relativePoint, point.xOfs, point.yOfs);
	end
end

-----
-- Methods for accessing/manipulating the favorites list in a profile for each skill
-----
function MrTrader:GateFavoritesAccess(skillID) 
	if( TradeSkills[skillID] == nil ) then
		return nil;
	end

	if( self.db.profile.favorites == nil ) then
		self.db.profile.favorites = {};
	end

	if( self.db.profile.favorites[skillID] == nil ) then
		self.db.profile.favorites[skillID] = {};
	end	
	
	return self.db.profile.favorites[skillID];
end

function MrTrader:GetFavoritesForSkill(skillID)
	local favorites = MrTrader:GateFavoritesAccess(skillID);
	
	if( favorites ) then
		return favorites;
	else
		return nil;
	end
end

function MrTrader:AddFavoriteCategoryToSkill(skillID, categoryName)
	local favorites = MrTrader:GetFavoritesForSkill(skillID);
	
	if( favorites ) then
		if( self.db.profile.favorites[skillID][categoryName] == nil ) then
			self.db.profile.favorites[skillID][categoryName] = {};
		end
	end
	
	return favorites;
end

function MrTrader:DelFavoriteCategoryFromSkill(skillID, categoryName)
	local favorites = MrTrader:GetFavoritesForSkill(skillID);

	if( favorites ) then
		if( self.db.profile.favorites[skillID][categoryName] ~= nil ) then
			self.db.profile.favorites[skillID][categoryName] = nil;
		end
	end

	return favorites;
end

function MrTrader:AddFavoriteToSkill(skillID, categoryName, spellID)
	local favorites = MrTrader:GetFavoritesForSkill(skillID);

	if( favorites ) then
		if( self.db.profile.favorites[skillID][categoryName] ~= nil ) then
			self.db.profile.favorites[skillID][categoryName][spellID] = true;
		end
	end

	return favorites;
end

function MrTrader:DelFavoriteFromSkill(skillID, categoryName, spellID)
	local favorites = MrTrader:GetFavoritesForSkill(skillID);
	local didDelete = false;
	
	if( favorites ) then
		if( self.db.profile.favorites[skillID][categoryName] ~= nil ) then
			self.db.profile.favorites[skillID][categoryName][spellID] = nil;
		end
	end

	return didDelete;
end