local _, WPT = ...;
local L = WPT.L;
local config = WPT.config;

--[[ maintain pet list ]]--

local petList = {};
local petListTainted = true;
local function taintPetList()
	petListTainted = true;
end
local taintFrame = CreateFrame("Frame");
taintFrame:SetScript("OnEvent", taintPetList);
taintFrame:RegisterEvent("PET_JOURNAL_LIST_UPDATE");
local function updatePetList()
	local registeredFrames = {GetFramesRegisteredForEvent("PET_JOURNAL_LIST_UPDATE")};
	for key, frame in pairs(registeredFrames) do
		frame:UnregisterEvent("PET_JOURNAL_LIST_UPDATE");
		-- this event will be spammed while we play with the filters... no need for
		-- other frames to update every time. We'll reregister them when we're done.
	end
	-- record current filter settings
	local collectedFlag = C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_COLLECTED);
	local favoritesFlag = C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_FAVORITES);
	local notCollectedFlag = C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_NOT_COLLECTED);
	local sourceFlags = {};
	for i = 1, C_PetJournal.GetNumPetSources() do
		sourceFlags[i] = C_PetJournal.IsPetSourceFiltered(i);
	end
	local typeFlags = {};
	for i = 1, C_PetJournal.GetNumPetTypes() do
		typeFlags[i] = C_PetJournal.IsPetTypeFiltered(i);
	end
	local searchText = nil;
	if PetJournal then
		searchText = PetJournal.searchBox:GetText();
	end
	
	-- clear all filters
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, false);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, true);
	C_PetJournal.AddAllPetSourcesFilter();
	C_PetJournal.AddAllPetTypesFilter();
	C_PetJournal.ClearSearchFilter();
	
	-- search all pets for rarities
	petList = {};
	for i = 1, C_PetJournal.GetNumPets(false) do
		local petID, _, isOwned, _, level, _, _, name = C_PetJournal.GetPetInfoByIndex(i, false);
		local rarity =  nil;
		if petID then
			_, _, _, _, rarity = C_PetJournal.GetPetStats(petID);
		end
		if not rarity then
			rarity = 0;
		end
		if not level then
			level = 0;
		end
		if (type(petList[name]) ~= "table") then
			petList[name] = {};
			petList[name].owned = isOwned;
			petList[name].rarity = 0;
			petList[name].level = 0;
		end
		local i = #petList[name] + 1;
		if isOwned then
			petList[name][i] = {};
			petList[name][i].rarity = rarity;
			petList[name][i].level = level;
		end
		if (rarity > petList[name].rarity) then
			petList[name].index = i;
			petList[name].rarity = rarity;
			petList[name].level = level;
		elseif (rarity == petList[name].rarity and level > petList[name].level) then
			petList[name].index = i;
			petList[name].level = level;
		end
	end

	-- restore filter settings
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, not collectedFlag);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, not favoritesFlag);
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, not notCollectedFlag);
	for i = 1, #sourceFlags do
		C_PetJournal.SetPetSourceFilter(i, not sourceFlags[i]);
	end
	for i = 1, #typeFlags do
		C_PetJournal.SetPetTypeFilter(i, not typeFlags[i]);
	end
	if searchText and (searchText ~= SEARCH) then
		C_PetJournal.SetSearchFilter(searchText);
	end
	for key, frame in pairs(registeredFrames) do
		frame:RegisterEvent("PET_JOURNAL_LIST_UPDATE");
		-- Hey look! All fixed!
	end
	petListTainted = false;
end

--[[ tooltip line generation ]]--

local wildTooltipLines = {};
local itemTooltipLines = {};
local wildExtraLines = {};
local itemExtraLines = {};
for rarity = 1, 4 do
	local rarityColor = ITEM_QUALITY_COLORS[rarity - 1].hex;
	local rarityName = _G["BATTLE_PET_BREED_QUALITY"..rarity];
	wildTooltipLines[rarity] = rarityColor..(L.caught:format(rarityName)).."|r";
	itemTooltipLines[rarity] = rarityColor..(L.caught:format(rarityName)).."|r";
	wildExtraLines[rarity] = rarityColor..(L.alsoCaught:format(rarityName)).."|r";
	itemExtraLines[rarity] = rarityColor..(L.alsoCollected:format(rarityName)).."|r";
end
wildTooltipLines[0] = ITEM_QUALITY_COLORS[5].hex..L.notCaught.."|r";
itemTooltipLines[0] = ITEM_QUALITY_COLORS[5].hex..L.notCollected.."|r";
local function tooltipLineForPet(name, includeLevel, useCollected)
	if petListTainted then
		updatePetList();
	end
	if petList[name] then
		local tooltipLines = wildTooltipLines;
		if useCollected then
			tooltipLines = itemTooltipLines;
		end
		local ret1, ret2, ret3 = nil, nil, nil;
		if (includeLevel and petList[name].level > 0) then
			ret1 = tooltipLines[petList[name].rarity].." |cFFFFFFFF"..L.caughtLevel:format(petList[name].level).."|r";
		else
			ret1 = tooltipLines[petList[name].rarity];
		end
		if petList[name].owned and config.showAdditionalPets then
			local extraLines = wildExtraLines;
			if useCollected then
				extraLines = itemExtraLines;
			end
			for i = 1, #petList[name] do
				if i ~= petList[name].index then
					if ret2 then
						if (includeLevel and petList[name].level > 0) then
							ret3 = extraLines[petList[name][i].rarity].." |cFFFFFFFF"..L.caughtLevel:format(petList[name][i].level).."|r";
						else
							ret3 = extraLines[petList[name][i].rarity];
						end
					else
						if (includeLevel and petList[name].level > 0) then
							ret2 = extraLines[petList[name][i].rarity].." |cFFFFFFFF"..L.caughtLevel:format(petList[name][i].level).."|r";
						else
							ret2 = extraLines[petList[name][i].rarity];
						end
					end
				end
			end
		end
		
		return ret1, ret2, ret3;
	else
		return "";
	end
end

--[[ world tooltips ]]--

local function mouseoverPet_World()
	if (config.enabled and UnitIsWildBattlePet("mouseover")) then
		local lines = {tooltipLineForPet(UnitName("mouseover"), config.showLevelInWorld, false)};
		for i = 1, #lines do
			if (lines[i] ~= "") then
				GameTooltip:AddLine(lines[i]);
			end
		end
		GameTooltip:Show();
	end
end
GameTooltip:HookScript("OnTooltipSetUnit", mouseoverPet_World);

--[[ minimap tooltips ]]--

local prevLeftText = "";
local prevRightText = "";
local function stripTextureFromString(string)
	local index = string:find("|c");
	if index then
		return string:sub(index+10, -3);
	end
	index = string:find("|t");
	if index then
		return string:sub(index + 2);
	else
		return string;
	end
end
local function constructRightText(text)
	local names = {strsplit("\n", text)};
	local containsWildBattlePet = false;
	local rightText = "";
	
	if (#names > 0) then
		rightText = tooltipLineForPet(stripTextureFromString(names[1]), config.showLevelInMinimap, false);
		if (rightText ~= "") then
			containsWildBattlePet = true;
		end
	end
	
	for i = 2, #names do
		local textForName = tooltipLineForPet(stripTextureFromString(names[i]), config.showLevelInMinimap, false);
		rightText = rightText.."\n"..textForName;
		if (textForName ~= "") then
			containsWildBattlePet = true;
		end
	end
	
	if containsWildBattlePet then
		return rightText;
	else
		return "";
	end
end
local function mouseoverPet_Minimap()
	if (config.enabled and GetMouseFocus() == Minimap) then
		local text = _G["GameTooltipTextLeft1"]:GetText();
		
		if (text ~= prevLeftText) then
			prevLeftText = text;
			prevRightText = constructRightText(text);
		end

		if (prevRightText ~= "") then
			GameTooltip:ClearLines();
			GameTooltip:AddDoubleLine(text, prevRightText);
			GameTooltip:Show();
		end
	end
end
local function tooltipHide()
	prevLeftText = "";
	prevRightText = "";
end

GameTooltip:HookScript("OnUpdate", mouseoverPet_Minimap);
GameTooltip:HookScript("OnHide", tooltipHide);

--[[ battle tooltips ]]--

local battleTooltipFontStrings = {};
battleTooltipFontStrings[1] = PetBattlePrimaryUnitTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
battleTooltipFontStrings[2] = PetBattlePrimaryUnitTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
battleTooltipFontStrings[3] = PetBattlePrimaryUnitTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
battleTooltipFontStrings[1]:SetPoint("TOPLEFT", PetBattlePrimaryUnitTooltip.CollectedText, "BOTTOMLEFT", 0, -2);
battleTooltipFontStrings[2]:SetPoint("TOPLEFT", battleTooltipFontStrings[1], "BOTTOMLEFT", 0, -2);
battleTooltipFontStrings[3]:SetPoint("TOPLEFT", battleTooltipFontStrings[2], "BOTTOMLEFT", 0, -2);
local function mouseoverPet_Battle(self, petOwner, petIndex)
	if (config.enabled and petOwner == LE_BATTLE_PET_ENEMY and C_PetBattles.IsWildBattle()) then
		local speciesID = C_PetBattles.GetPetSpeciesID(LE_BATTLE_PET_ENEMY, petIndex);
		local speciesName = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
		local lines = {tooltipLineForPet(speciesName, config.showLevelInBattle, false)};
		
		if C_PetJournal.GetNumCollectedInfo(speciesID) > 0 then
			local lastItem = self.CollectedText;
			for i = 1, #battleTooltipFontStrings do
				if lines[i] then
					battleTooltipFontStrings[i]:SetText(lines[i]);
					self:SetHeight(self:GetHeight() + battleTooltipFontStrings[i]:GetHeight() + 2);
					battleTooltipFontStrings[i]:Show();
					lastItem = battleTooltipFontStrings[i];
				else
					battleTooltipFontStrings[i]:Hide();
				end
			end
			self.HealthBorder:SetPoint("TOPLEFT", lastItem, "BOTTOMLEFT", -1, -6);
		else
			for i = 1, #battleTooltipFontStrings do
				battleTooltipFontStrings[i]:Hide();
			end
		end
	else
		for i = 1, #battleTooltipFontStrings do
			battleTooltipFontStrings[i]:Hide();
		end
	end
end
hooksecurefunc(_G, "PetBattleUnitTooltip_UpdateForUnit", mouseoverPet_Battle);

--[[ item tooltips ]]--

local speciesIDFromItemID = {
	[44822]	= 74,	-- Albino Snake
	[72042]	= 331,	-- Alliance Balloon
	[44984]	= 212,	-- Ammen Vale Lashling
	[11023]	= 52,	-- Ancona Chicken
	[93040]	= 1155,	-- Anubisath Idol
	[86563]	= 836,	-- Aqua Strider
	[45022]	= 216,	-- Argent Gruntling
	[44998]	= 214,	-- Argent Squire
	[63398]	= 272,	-- Armadillo Pup
	[93035]	= 1150,	-- Ashstone Core
	[34535]	= 57,	-- Azure Whelpling
	[44819]	= 202,	-- Baby Blizzard Bear
	[32588]	= 156,	-- Bananas
	[90177]	= 903,	-- Baneling
	[10360]	= 75,	-- Black Kingsnake
	[8491]	= 42,	-- Black Tabby Cat
	[54436]	= 254,	-- Blue Clockwork Rocket Bot
	[29958]	= 145,	-- Blue Dragonhawk Hatchling
	[65661]	= 259,	-- Blue Mini Jouster
	[29901]	= 138,	-- Blue Moth
	[8485]	= 40,	-- Bombay Cat
	[71387]	= 325,	-- Brilliant Kaliri
	[10394]	= 70,	-- Brown Prairie Dog
	[29364]	= 137,	-- Brown Rabbit
	[10361]	= 77,	-- Brown Snake
	[46398]	= 224,	-- Calico Cat
	[54810]	= 255,	-- Celestial Dragon
	[70099]	= 316,	-- Cenarion Hatchling
	[89368]	= 849,	-- Chi-ji Kite
	[93038]	= 1152,	-- Chrominius
	[35350]	= 174,	-- Chuck
	[92707]	= 1117,	-- Cinder Kitten
	[93025]	= 1142,	-- Clock'em
	[64372]	= 277,	-- Clockwork Gnome
	[34425]	= 191,	-- Clockwork Rocket Bot
	[39898]	= 197,	-- Cobra Hatchling
	[8496]	= 47,	-- Cockatiel
	[49646]	= 244,	-- Core Houd Pup
	[93034]	= 1149,	-- Corefire Imp
	[8486]	= 41,	-- Cornish Rex Cat
	[60847]	= 264,	-- Crawling Claw
	[71076]	= 321,	-- Creepy Crate
	[70160]	= 318,	-- Crimson Lasher
	[10392]	= 78,	-- Crimson Snake
	[8499]	= 58,	-- Crimson Whelpling
	[46545]	= 225,	-- Curious Oracle Hatchling
	[46544]	= 226,	-- Curious Wolvar Pup
	[63138]	= 270,	-- Dark Phoenix Hatchling
	[10822]	= 56,	-- Dark Whelpling
	[73762]	= 336,	-- Darkmoon Balloon
	[74981]	= 343,	-- Darkmoon Cub
	[91040]	= 1063,	-- Darkmoon Eye
	[91031]	= 1062,	-- Darkmoon Glowfly
	[91003]	= 1061,	-- Darkmoon Hatchling
	[73764]	= 330,	-- Darkmoon Monkey
	[80008]	= 848,	-- Darkmoon Rabbit
	[73903]	= 338,	-- Darkmoon Tonk
	[73765]	= 335,	-- Darkmoon Turtle
	[73905]	= 339,	-- Darkmoon Zeppelin
	[48112]	= 232,	-- Darting Hatchling
	[60216]	= 262,	-- De-Weaponized Mechanical Companion
	[93037]	= 1153,	-- Death Talon Whelpguard
	[67418]	= 294,	-- Deathy
	[48114]	= 233,	-- Deviate Hatchling
	[20769]	= 114,	-- Disgusting Oozeling
	[34493]	= 169,	-- Dragon Kite
	[44970]	= 205,	-- Dun Morogh Cub
	[44973]	= 207,	-- Durotar Scorpion
	[32616]	= 158,	-- Egbert
	[67282]	= 293,	-- Elementium Geode
	[44974]	= 209,	-- Elwynn Lamb
	[8498]	= 59,	-- Emerald Whelpling
	[44982]	= 213,	-- Enchanted Broom
	[67274]	= 267,	-- Enchanted Lantern
	[37298]	= 180,	-- Essence of Competition
	[38050]	= 183,	-- Ethereal Soul-Trader
	[79744]	= 348,	-- Eye of the Legion
	[21301]	= 119,	-- Father Winter's Helper
	[70908]	= 319,	-- Feline Familiar
	[85578]	= 821,	-- Feral Vermling
	[74611]	= 342,	-- Festival Lantern
	[76062]	= 346,	-- Fetish Shaman
	[29960]	= 146,	-- Firefly
	[84105]	= 847,	-- Fishy
	[60955]	= 266,	-- Fossilized Hatchling
	[90898]	= 278,	-- Fox Kit (horde)
	[90897]	= 278,	-- Fox Kit (alliance)
	[64403]	= 278,	-- Fox Kit (drop)
	[53641]	= 253,	-- Frigid Frostling
	[39286]	= 188,	-- Frosty
	[93032]	= 1144,	-- Fungal Abomination
	[39973]	= 190,	-- Ghostly Skull
	[93030]	= 1143,	-- Giant Bone Spider
	[43698]	= 193,	-- Giant Sewer Rat
	[65662]	= 260,	-- Gold Mini Jouster
	[29953]	= 142,	-- Golden Dragonhawk Hatchling
	[34518]	= 170,	-- Golden Pig
	[8500]	= 68,	-- Great Horned Owl
	[8492]	= 50,	-- Green Wing Macaw
	[72134]	= 333,	-- Gregarious Grell
	[86564]	= 834,	-- Grinder
	[46802]	= 228,	-- Grunty
	[49662]	= 245,	-- Gryphon Hatchling
	[72068]	= 311,	-- Guardian Cub (unbound)
	[69847]	= 311,	-- Guardian Cub (bound)
	[65363]	= 283,	-- Guild Herald (alliance)
	[65364]	= 283,	-- Guild Herald (horde)
	[65361]	= 281,	-- Guild Page (alliance)
	[65362]	= 281,	-- Guild Page (horde)
	[48116]	= 234,	-- Gundrak Hatchling
	[22114]	= 121,	-- Gurky
	[93033]	= 1147,	-- Harbinger of Flame
	[8501]	= 67,	-- Hawk Owl
	[23713]	= 130,	-- Hippogryph Hatchling
	[86562]	= 835,	-- Hopling
	[72045]	= 332,	-- Horde Balloon
	[8494]	= 49,	-- Hyacinth Macaw
	[70140]	= 317,	-- Hyjal Bear Cub
	[90900]	= 1039,	-- Imperial Moth
	[90902]	= 1040,	-- Imperial Silkworm
	[88148]	= 792,	-- Jade Crane Chick
	[82774]	= 845,	-- Jade Owl
	[89686]	= 856,	-- Jade Tentacle
	[19450]	= 106,	-- Jubling
	[44738]	= 199,	-- Kirin Tor Familiar
	[68840]	= 302,	-- Landro's Lichling
	[67128]	= 285,	-- Landro's Lil' XT
	[69251]	= 307,	-- Lashtail Hatchling
	[48118]	= 235,	-- Leaping Hatchling
	[69648]	= 308,	-- Legs
	[15996]	= 95,	-- Lifelike Toad
	[62540]	= 268,	-- Lil' Deathwing
	[49693]	= 249,	-- Lil' K.T.
	[68385]	= 297,	-- Lil' Ragnaros
	[11826]	= 86,	-- Lil' Smokey
	[71033]	= 320,	-- Lil' Tarecgosa
	[54847]	= 256,	-- Lil' XT
	[44841]	= 203,	-- Little Fawn
	[32498]	= 155,	-- Lucky
	[85871]	= 671,	-- Lucky Quillien Cub
	[73797]	= 337,	-- Lumpy
	[74610]	= 341,	-- Lunar Lantern
	[30360]	= 111,	-- Lurky
	[67275]	= 292,	-- Magic Lamp
	[27445]	= 132,	-- Magical Crawdad
	[29363]	= 136,	-- Mana Wyrmling
	[10398]	= 83,	-- Mechanical Chicken
	[87526]	= 844,	-- Mechanical Pandaren Dragonling
	[4401]	= 39,	-- Mechanical Squirrel
	[45002]	= 215,	-- Mechanopeep
	[13584]	= 93,	-- Mini Diablo
	[93041]	= 1156,	-- Mini Mindslayer
	[56806]	= 258,	-- Mini Thor
	[39656]	= 189,	-- Mini Tyrael
	[31760]	= 149,	-- Miniwing
	[33993]	= 165,	-- Mojo
	[68618]	= 296,	-- Moonkin Hatchling (alliance)
	[68619]	= 296,	-- Moonkin Hatchling (horde)
	[93031]	= 1145,	-- Mr. Bigglesworth
	[41133]	= 192,	-- Mr. Chilly
	[66076]	= 286,	-- Mr. Grubbs
	[23007]	= 126,	-- Mr. Wiggles
	[33818]	= 164,	-- Muckbreath
	[44980]	= 210,	-- Mulgore Hatchling
	[71726]	= 329,	-- Murkablo
	[46892]	= 217,	-- Murkimus the Gladiator (tiny spear)
	[45180]	= 217,	-- Murkimus the Gladiator (little spear)
	[20371]	= 107,	-- Murky
	[38628]	= 186,	-- Nether Ray Fry
	[25535]	= 131,	-- Netherwhelp
	[68841]	= 303,	-- Nightsaber Cub
	[71140]	= 323,	-- Nuts
	[48120]	= 236,	-- Obsidian Hatchling
	[48527]	= 240,	-- Onyx Panther
	[49362]	= 243,	-- Onyxian Whelpling
	[8487]	= 43,	-- Orange Tabby Cat
	[13583]	= 92,	-- Panda Cub
	[92799]	= 1125,	-- Pandaren Air Spirit
	[92800]	= 1126,	-- Pandaren Earth Spirit
	[92798]	= 1124,	-- Pandaren Fire Spirit
	[49665]	= 248,	-- Pandaren Monk
	[90173]	= 868,	-- Pandaren Water Spirit
	[68833]	= 301,	-- Panther Cub
	[32622]	= 159,	-- Peanut
	[60869]	= 265,	-- Pebble
	[22235]	= 122,	-- Peddlefeet
	[44723]	= 198,	-- Pengu
	[49912]	= 250,	-- Perky Pug
	[59597]	= 261,	-- Personal World Destroyer
	[11825]	= 85,	-- Pet Bombling
	[35504]	= 175,	-- Phoenix Hatchling
	[46707]	= 166,	-- Pint-Sized Pink Pachyderm
	[44810]	= 201,	-- Plump Turkey
	[22781]	= 124,	-- Poley
	[89587]	= 381,	-- Porcupette
	[44721]	= 196,	-- Proto-Drake Whelp
	[69821]	= 309,	-- Pterrordax Hatchling
	[71624]	= 328,	-- Purple Puffer
	[48122]	= 237,	-- Ravasaur Hatchling
	[48124]	= 238,	-- Razormaw Hatchling
	[48126]	= 239,	-- Razzashi Hatchling
	[85222]	= 1042,	-- Red Cricket
	[29956]	= 143,	-- Red Dragonhawk Hatchling
	[29902]	= 139,	-- Red Moth
	[34492]	= 168,	-- Rocket Chicken
	[64996]	= 271,	-- Rustberg Gull (horde)
	[63355]	= 271,	-- Rustberg Gull (alliance)
	[72153]	= 665,	-- Sand Scarab
	[82775]	= 846,	-- Sapphire Cub
	[66073]	= 289,	-- Scooter the Snail
	[73953]	= 340,	-- Sea Pony
	[34955]	= 172,	-- Searing Scorchling
	[45606]	= 218,	-- Sen'jin Fetish
	[8495]	= 51,	-- Senegal
	[69992]	= 229,	-- Shimmering Wyrmling (drop)
	[46821]	= 229,	-- Shimmering Wyrmling (horde)
	[46820]	= 229,	-- Shimmering Wyrmling (alliance)
	[8490]	= 44,	-- Siamese Cat
	[29957]	= 144,	-- Silver Dragonhawk Hatchling
	[34519]	= 171,	-- Silver Pig
	[8488]	= 45,	-- Silver Tabby
	[88147]	= 820,	-- Singing Cricket
	[66067]	= 291,	-- Singing Songflower
	[33154]	= 162,	-- Sinister Squashling
	[68673]	= 90,	-- Smolderweb Hatchling (egg)
	[12529]	= 90,	-- Smolderweb Hatchling (carrier)
	[35349]	= 173,	-- Snarly
	[8497]	= 72,	-- Snowshoe Rabbit
	[78916]	= 347,	-- Soul of the Aspects
	[90953]	= 1127,	-- Spectral Cub
	[49343]	= 242,	-- Spectral Tiger Cub
	[23002]	= 125,	-- Speedy
	[37297]	= 179,	-- Spirit of Competition
	[23083]	= 128,	-- Spirit of Summer
	[44794]	= 200,	-- Spring Rabbit
	[11474]	= 87,	-- Sprite Darter Hatchling
	[40653]	= 160,	-- Stinker
	[93029]	= 1146,	-- Stitched Pup
	[44983]	= 211,	-- Strand Crawler
	[44965]	= 204,	-- Teldrassil Sapling
	[85220]	= 650,	-- Terrible Turnip
	[85513]	= 802,	-- Thundering Serpent Hatchling
	[39896]	= 194,	-- Tickbird Hatchling
	[66080]	= 287,	-- Tiny Flamefly
	[85447]	= 652,	-- Tiny Goldfish
	[19055]	= 757,	-- Tiny Green Dragon
	[19054]	= 758,	-- Tiny Red Dragon
	[64494]	= 279,	-- Tiny Shale Spider
	[21309]	= 117,	-- Tiny Snowman
	[69991]	= 167,	-- Tiny Sporebat (drop)
	[34478]	= 167,	-- Tiny Sporebat (vendor)
	[44971]	= 206,	-- Tirisfal Batling
	[33816]	= 163,	-- Toothy
	[50446]	= 251,	-- Toxic Wasteling
	[21277]	= 116,	-- Tranquil Mechanical Yeti
	[11026]	= 65,	-- Tree Frog
	[49287]	= 241,	-- Tuskarr Kite
	[10393]	= 55,	-- Undercity Cockroach
	[93036]	= 1151,	-- Untamed Hatchling
	[38658]	= 187,	-- Vampiric Batling
	[89736]	= 855,	-- Venus
	[93039]	= 1154,	-- Viscidus Globule
	[69824]	= 310,	-- Voodoo Figurine
	[46767]	= 227,	-- Warbot (old)
	[11110]	= 84,	-- Westfall Chicken
	[23015]	= 127,	-- Whiskers the Rat
	[8489]	= 46,	-- White Kitten
	[29904]	= 141,	-- White Moth
	[39899]	= 195,	-- White Tickbird Hatchling
	[32617]	= 157,	-- Willy
	[49663]	= 246,	-- Wind Rider Cub
	[21308]	= 118,	-- Winter Reindeer
	[21305]	= 120,	-- Winter's Little Helper
	[69239]	= 306,	-- Winterspring Cub
	[46325]	= 220,	-- Withers
	[32233]	= 153,	-- Wolpertinger
	[11027]	= 64,	-- Wood Frog
	[12264]	= 89,	-- Worg Pup
	[29903]	= 140,	-- Yellow Moth
	[89367]	= 850,	-- Yu'lon Kite
	[13582]	= 94,	-- Zergling
	[49664]	= 247,	-- Zipao Tiger
	-- added in patch 5.2
	[93669]	= 1174,	--	Gusting Grimoire
	[94025]	= 1176,	--	Red Panda
	[94124]	= 1178,	--	Sunreaver Micro-Sentry
	[94125]	= 1177,	--	Living Sandling
	[94126]	= 1180,	--	Zandalari Kneebiter
	[94152]	= 1183,	--	Son of Animus
	[94190]	= 1185,	--	Spectral Porcupette
	[94191]	= nil,	--	Stunted Direhorn
	[94208]	= 1196,	--	Sunfur Panda
	[94209]	= 1197,	--	Snowy Panda
	[94210]	= 1198,	--	Mountain Panda
	[94573]	= nil,	--	Direhorn Runt
	[94574]	= nil,	--	Pygmy Direhorn
	[94595]	= 1201,	--	Spawn of G'nathus
	[94835]	= 1202,	--	Ji-Kun Hatchling
	[95422]	= 1211,	--	Zandalari Anklerender
	[95423]	= 1212,	--	Zandalari Footslasher
	[95424]	= 1213,	--	Zandalari Toenibbler
	[95621]	= 227,	--	Warbot (new)
	[94903]	= 1204,	--	Pierre
	[94932]	= 1206,	--	Tiny Red Carp
	[94933]	= 1207,	--	Tiny Blue Carp
	[94934]	= 1208,	--	Tiny Green Carp
	[94935]	= 1209,	--	Tiny White Carp
};
local function addLinesToItemTooltip(tooltip, link)
	if config.enabled and link then
		local idx = link:find("item:");
		link = link:sub(idx + 5);
		idx = link:find(":");
		local itemID = tonumber(link:sub(1, idx - 1));
		if speciesIDFromItemID[itemID] then
			local speciesName = C_PetJournal.GetPetInfoBySpeciesID(speciesIDFromItemID[itemID]);
			local lines = {tooltipLineForPet(speciesName, config.showLevelInItems, true)};
			for i = 1, #lines do
				if (lines[i] ~= "") then
					tooltip:AddLine(lines[i]);
				end
			end
			tooltip:Show();
		end
	end
end
local function mouseoverPet_Item()
	local _, link = GameTooltip:GetItem()
	addLinesToItemTooltip(GameTooltip, link);
end

GameTooltip:HookScript("OnTooltipSetItem", mouseoverPet_Item);
hooksecurefunc(ItemRefTooltip, "SetHyperlink", addLinesToItemTooltip);

--[[ cage tooltips ]]--

local cageTooltipFontStrings = {};
cageTooltipFontStrings[1] = BattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
cageTooltipFontStrings[2] = BattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
cageTooltipFontStrings[3] = BattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
cageTooltipFontStrings[1]:SetPoint("TOPLEFT", BattlePetTooltip.Owned, "BOTTOMLEFT", 0, -2);
cageTooltipFontStrings[2]:SetPoint("TOPLEFT", cageTooltipFontStrings[1], "BOTTOMLEFT", 0, -2);
cageTooltipFontStrings[3]:SetPoint("TOPLEFT", cageTooltipFontStrings[2], "BOTTOMLEFT", 0, -2);
local function mouseoverPet_Cage(speciesID)
	if config.enabled then
		local name = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
		local lines = {tooltipLineForPet(name, config.showLevelInItems, true)};
		if C_PetJournal.GetNumCollectedInfo(speciesID) > 0 then
			cageTooltipFontStrings[1]:SetPoint("TOPLEFT", BattlePetTooltip.Owned, "BOTTOMLEFT", 0, -2);
		else
			cageTooltipFontStrings[1]:SetPoint("TOPLEFT", BattlePetTooltip.SpeedTexture, "BOTTOMLEFT", 0, -2);
		end
		for i = 1, #cageTooltipFontStrings do
			if lines[i] then
				cageTooltipFontStrings[i]:SetText(lines[i]);
				BattlePetTooltip:SetHeight(BattlePetTooltip:GetHeight() + cageTooltipFontStrings[i]:GetHeight() + 2);
				cageTooltipFontStrings[i]:Show();
			else
				cageTooltipFontStrings[i]:Hide();
			end
		end
	else
		for i = 1, #cageTooltipFontStrings do
			cageTooltipFontStrings[i]:Hide();
		end
	end
end

local hyperlinkTooltipFontStrings = {};
hyperlinkTooltipFontStrings[1] = FloatingBattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
hyperlinkTooltipFontStrings[2] = FloatingBattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
hyperlinkTooltipFontStrings[3] = FloatingBattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal");
hyperlinkTooltipFontStrings[1]:SetPoint("TOPLEFT", FloatingBattlePetTooltip.Owned, "BOTTOMLEFT", 0, -2);
hyperlinkTooltipFontStrings[2]:SetPoint("TOPLEFT", hyperlinkTooltipFontStrings[1], "BOTTOMLEFT", 0, -2);
hyperlinkTooltipFontStrings[3]:SetPoint("TOPLEFT", hyperlinkTooltipFontStrings[2], "BOTTOMLEFT", 0, -2);
local function hyperlinkPet_Cage(speciesID)
	if config.enabled then
		local name = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
		local lines = {tooltipLineForPet(name, config.showLevelInItems, true)};
		local lastItem = FloatingBattlePetTooltip.SpeedTexture;
		if C_PetJournal.GetNumCollectedInfo(speciesID) > 0 then
			hyperlinkTooltipFontStrings[1]:SetPoint("TOPLEFT", FloatingBattlePetTooltip.Owned, "BOTTOMLEFT", 0, -2);
			lastItem = FloatingBattlePetTooltip.Owned;
		else
			hyperlinkTooltipFontStrings[1]:SetPoint("TOPLEFT", FloatingBattlePetTooltip.SpeedTexture, "BOTTOMLEFT", 0, -2);
		end
		for i = 1, #hyperlinkTooltipFontStrings do
			if lines[i] then
				hyperlinkTooltipFontStrings[i]:SetText(lines[i]);
				FloatingBattlePetTooltip:SetHeight(FloatingBattlePetTooltip:GetHeight() + hyperlinkTooltipFontStrings[i]:GetHeight() + 2);
				hyperlinkTooltipFontStrings[i]:Show();
				lastItem = hyperlinkTooltipFontStrings[i];
			else
				hyperlinkTooltipFontStrings[i]:Hide();
			end
		end
		FloatingBattlePetTooltip.Delimiter:SetPoint("TOPLEFT", lastItem ,"BOTTOMLEFT", -6, -5);
	else
		for i = 1, #hyperlinkTooltipFontStrings do
			hyperlinkTooltipFontStrings[i]:Hide();
		end
	end
end

hooksecurefunc(_G, "BattlePetToolTip_Show", mouseoverPet_Cage);
hooksecurefunc(_G, "FloatingBattlePet_Show", hyperlinkPet_Cage);