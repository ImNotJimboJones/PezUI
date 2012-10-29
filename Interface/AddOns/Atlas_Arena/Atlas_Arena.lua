--[[

	Atlas Arena, a World of Warcraft instance map browser
	Copyright 2010 - 2012 Arith Hsu

	This file is a plugin of Atlas.

	Atlas Arena is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]
local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0");
local AL = LibStub("AceLocale-3.0"):GetLocale("Atlas_Arena");

local BLUE = "|cff6666ff";
local GREY = "|cff999999";
local GREN = "|cff66cc33";
local YELL = "|cffcccc00";
local _RED = "|cffcc6666";
local ORNG = "|cffcc9933";
local PURP = "|cff9900ff";
local WHIT = "|cffffffff";
local CYAN = "|cff008888";
local INVIS = "|c00000000";
local INDENT = "   ";

local myCategory = AL["Arena Maps"];

local myData = {
	-- Blade's Edge Arena
	CircleOfBlood_Arena = {
		ZoneName = { BZ["Blade's Edge Arena"] };
		Location = { BZ["Circle of Blood Arena"]..", "..BZ["Blade's Edge Mountains"]..", "..BZ["Outland"] };
		LevelRange = "10-85 (PvP)";
		PlayerLimit = "2v2, 3v3, 5v5";
		{ BLUE..BZ["Circle of Blood Arena"] };
		{ "" };
		{ WHIT.."1) "..AL["Frixee Brasstumbler <Arena Vendor>"] };
		{ WHIT.."2) "..AL["Meminnie <Arena Vendor>"] };
	};
	-- Dalaran Arena
	Dalaran_Sewers_Arena = {
		ZoneName = { BZ["Dalaran Arena"] };
		Location = { BZ["Dalaran Sewers"]..", "..BZ["Dalaran"]..", "..BZ["Northrend"] };
		LevelRange = "10-85 (PvP)";
		PlayerLimit = "2v2, 3v3, 5v5";
		{ BLUE..BZ["Dalaran Arena"] };
		{ "" };
		{ WHIT.."1) "..AL["Xazi Smolderpipe <Arena Vendor>"] };
		{ WHIT.."2) "..AL["Zom Bocom <Apprentice Arena Vendor>"] };
		{ WHIT.."3) "..AL["Nargle Lashcord <Veteran Arena Vendor>"] };
		{ WHIT.."4) "..AL["Trapjaw Rix <Exceptional Arena Weaponry>"] };
	};
	-- Nagrand Arena
	RingOfTrials_Arena = {
		ZoneName = { BZ["Nagrand Arena"] };
		Location = { BZ["The Ring of Trials"]..", "..BZ["Nagrand"]..", "..BZ["Outland"] };
		LevelRange = "10-85 (PvP)";
		PlayerLimit = "2v2, 3v3, 5v5";
		{ BLUE..BZ["Nagrand Arena"] };
		{ "" };
		{ WHIT.."1) "..AL["Kelara <Keeper of Sha'tari Heirlooms>"] };
		{ WHIT.."2) "..AL["Grikkin Copperspring <Arena Vendor>"] };
	};
	-- The Ring of Blood
	RingofBlood_Arena = {
		ZoneName = { BZ["The Ring of Blood"] };
		Location = { BZ["Laughing Skull Ruins"]..", "..BZ["Nagrand"]..", "..BZ["Outland"] };
		LevelRange = "65-70 ("..AL["Quests"]..")";
		PlayerLimit = "5";
		{ BLUE..BZ["The Ring of Blood"] };
		{ "" };
		{ WHIT.."1) "..AL["Mogor <Hero of the Warmaul>"] }; -- 18069
		{ WHIT.."2) "..AL["Wodin the Troll-Servant"] }; -- 22893
		{ WHIT.."3) "..AL["Gurgthock"] }; -- 18471
	};
	
	-- The Ring of Valor
	RingOfValor_Arena = {
		ZoneName = { BZ["The Ring of Valor"] };
		Location = { BZ["Orgrimmar"]..", "..BZ["Kalimdor"] };
		LevelRange = "10-85 (PvP)";
		PlayerLimit = "2v2, 3v3, 5v5";
		{ BLUE..BZ["The Ring of Valor"] };
	};
	-- Ruins of Lordaeron
	RuinsOfLordaeron_Arena = {
		ZoneName = { BZ["Ruins of Lordaeron"] };
		Location = { BZ["Ruins of Lordaeron"]..", "..BZ["Eastern Kingdoms"] };
		LevelRange = "10-85 (PvP)";
		PlayerLimit = "2v2, 3v3, 5v5";
		{ BLUE..BZ["Ruins of Lordaeron"] };
	};
	-- Gurubashi Arena
	Gurubashi_Arena = {
		ZoneName = { BZ["Gurubashi Arena"] };
		Location = { BZ["The Cape of Stranglethorn"]..", "..BZ["Eastern Kingdoms"] };
		LevelRange = "30-45 (PvP)";
		--PlayerLimit = "N/A";
		{ BLUE..BZ["Gurubashi Arena"] };
		{ "" };
		{ WHIT.."1) "..AL["Short John Mithril"] };
		{ WHIT.."2) "..AL["Stone Guard Towhide"] };
	};
	-- The Rumble Cage
	RumbleCage_Arena = {
		ZoneName = { BZ["The Rumble Cage"] };
		Location = { BZ["Gadgetzan"]..", "..BZ["Tanaris"]..", "..BZ["Kalimdor"] };
		LevelRange = "47-50 ("..AL["Quests"]..")";
		{ BLUE..BZ["The Rumble Cage"] };
		{ "" };
		{ WHIT.."1) "..AL["Dr. Dealwell"] };
		{ WHIT.."2) "..AL["Katrina Turner"] };
		{ WHIT.."3) "..AL["Vixton Pinchwhistle <Legacy Arena Armor>"] }; 
		{ WHIT.."4) "..AL["Blazzek the Biter <Legacy Arena Weapons>"] };
		{ WHIT.."5) "..AL["Evee Copperspring <Arena Vendor>"] };
		{ WHIT.."6) "..AL["Ecton Brasstumbler <Arena Vendor>"] };
	};
	-- The Crucible of Carnage
	CrucibleofCarnage_Arena = {
		ZoneName = { BZ["Crucible of Carnage"] };
		Location = { BZ["Twilight Highlands"]..", "..BZ["Eastern Kingdoms"] };
		LevelRange = "84-85 ("..AL["Quests"]..")";
		PlayerLimit = "5";
		{ BLUE..BZ["Crucible of Carnage"] };
		{ "" };
		{ WHIT.."1) "..AL["Gurgthock <Fight Promoter>"] };
		{ WHIT.."2) "..AL["Wodin the Troll-Servant"] };
	};
	-- Valhalas
	Valhalas_Arena = {
		ZoneName = { BZ["Valhalas"] };
		Location = { BZ["Icecrown"]..", "..BZ["Northrend"] };
		LevelRange = "77-80 ("..AL["Quests"]..")";
		PlayerLimit = "5";
		{ BLUE..BZ["Valhalas"] };
		{ "" };
		{ WHIT.."1) "..AL["Geirrvif"] };
		{ WHIT.."2) "..AL["Gjonner the Merciless"] };
	};
	-- Amphitheater of Anguish
	AmphitheaterofAnguish_Arena = {
		ZoneName = { BZ["Amphitheater of Anguish"] };
		Location = { BZ["Zul'Drak"]..", "..BZ["Outland"] };
		LevelRange = "75-80 ("..AL["Quests"]..")";
		PlayerLimit = "5";
		{ BLUE..BZ["Amphitheater of Anguish"] };
		{ "" };
		{ GREN.."1) "..AL["Gurgthock <Fight Promoter>"] };
		{ GREN.."2) "..AL["Wodin the Troll-Servant"] };
		{ "" };
		{ WHIT.."1) "..AL["Yggdras"] };
		{ WHIT..INDENT..AL["Stinkbeard"] };
		{ WHIT..INDENT..AL["Elemental Lord"] };
		{ WHIT..INDENT..INDENT..AL["Az'Barin, Prince of the Gust"] };
		{ WHIT..INDENT..INDENT..AL["Duke Singen <The New Hotness>"] };
		{ WHIT..INDENT..INDENT..AL["Erathius, King of Dirt"] };
		{ WHIT..INDENT..INDENT..AL["Gargoral the Water Lord"] };
		{ WHIT..INDENT..AL["Orinoko Tuskbreaker"] };
		{ WHIT..INDENT..AL["Korrak the Bloodrager <Champion of the Winterax>"] };
		{ WHIT..INDENT..AL["Vladof the Butcher"] };
	};
	-- Tol'Viron Arena
	--[[
	TolViron_Arena = {
		ZoneName = { BZ["Tol'viron Arena"] };
		Location = { BZ["Uldum"]..", "..BZ["Kalimdor"] };
		LevelRange = "75-80 ("..AL["Quests"]..")";
		PlayerLimit = "5";
		{ BLUE..BZ["Tol'Viron Arena"] };

	};]]
};


Atlas_RegisterPlugin("Atlas_Arena", myCategory, myData);
