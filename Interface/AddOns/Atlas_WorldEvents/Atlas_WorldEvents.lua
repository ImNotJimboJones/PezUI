--[[

	Atlas World Events, a World of Warcraft map browser for world events
	Copyright 2011 ~ 2012 Arith Hsu

	This file is a plugin of Atlas.

	"Atlas World Events" is free software; you can redistribute it and/or modify
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
local BF = Atlas_GetLocaleLibBabble("LibBabble-Faction-3.0");
local AL = LibStub("AceLocale-3.0"):GetLocale("Atlas_WorldEvents");

local BLUE = "|cff6666ff";
local GREY = "|cff999999";
local GREN = "|cff66cc33";
local YELL = "|cffcccc00";
local _RED = "|cffcc6666";
local ORNG = "|cffcc9933";
local PURP = "|cff9900ff";
local WHIT = "|cffffffff";
local CYAN = "|cff11cfff";
local INVIS = "|c00000000";
local INDENT = "    ";
local DASH = GREY.." - ";

local myCategory = AL["World Events Maps"];

local myData = {
	Lunar_Azeroth = {
		ZoneName = { AL["Lunar Festival"].." - "..BZ["Eastern Kingdoms"] };
		{ ORNG..AL["Lunar Festival"].." - "..AL["Jan. 23 ~ Feb. 13"] };
		{ "" };
		{ WHIT.." 1) "..AL["Elder Hammershout"]	..DASH..BLUE..BZ["Stormwind City"]..", "..BZ["Elwynn Forest"] };
		{ GREY..INDENT..AL["(Outside the city gate)"] };
		{ WHIT.." 2) "..AL["Elder Stormbrow"]	..DASH..BZ["Goldshire"]..", "..BZ["Elwynn Forest"] };
		{ WHIT.." 3) "..AL["Elder Skychaser"]	..DASH..BZ["Sentinel Hill"]..", "..BZ["Westfall"] };
		{ WHIT.." 4) "..AL["Elder Winterhoof"]	..DASH..BZ["Booty Bay"]..", "..BZ["The Cape of Stranglethorn"] };
		{ GREY..INDENT..AL["(On the roof of the bank)"] };
		{ WHIT.." 5) "..AL["Elder Starglade"]	..DASH..BZ["Zul'Gurub"]..", "..BZ["Northern Stranglethorn"] };
		{ GREY..INDENT..AL["(Outside the gate)"] };
		{ WHIT.." 6) "..AL["Elder Bellowrage"]	..DASH..BZ["The Dark Portal"]..", "..BZ["Blasted Lands"] };
		{ WHIT.." 7) "..AL["Elder Starsong"]	..DASH..ORNG..BZ["The Temple of Atal'Hakkar"]..", "..BZ["Swamp of Sorrows"] };
		{ WHIT.." 8) "..AL["Elder Rumblerock"]	..DASH..BZ["Dreadmaul Rock"]..", "..BZ["Burning Steppes"] };
		{ WHIT.." 9) "..AL["Elder Dawnstrider"]	..DASH..BZ["Flame Crest"]..", "..BZ["Burning Steppes"] };
		{ WHIT.."10) "..AL["Elder Stonefort"]	..DASH..ORNG..BZ["Blackrock Spire"].." ("..AL["Lower"].."), "..BZ["Burning Steppes"].." / "..BZ["Searing Gorge"] };
		{ GREY..INDENT.."("..BZ["Hordemar City"]..")" };
		{ WHIT.."11) "..AL["Elder Morndeep"]	..DASH..ORNG..BZ["Blackrock Depths"]..", "..BZ["Burning Steppes"].." / "..BZ["Searing Gorge"] };
		{ GREY..INDENT.."("..BZ["Ring of the Law"]..")" };
		{ WHIT.."12) "..AL["Elder Ironband"]	..DASH..BZ["Blackchar Cave"]..", "..BZ["Searing Gorge"] };
		{ WHIT.."13) "..AL["Elder Goldwell"] 	..DASH..BZ["Kharanos"]..", "..BZ["Dun Morogh"] };
		{ WHIT.."14) "..AL["Elder Bronzebeard"]	..DASH..BLUE..BZ["Ironforge"]..", "..BZ["Dun Morogh"] };
		{ GREY..INDENT.."("..BZ["The Mystic Ward"]..")" };
		{ WHIT.."15) "..AL["Elder Silvervein"]	..DASH..BZ["Thelsamar"]..", "..BZ["Loch Modan"] };
		{ WHIT.."16) "..AL["Elder Highpeak"]	..DASH..BZ["The Creeping Ruin"]..", "..BZ["The Hinterlands"] };
		{ WHIT.."17) "..AL["Elder Snowcrown"]	..DASH..BZ["Light's Hope Chapel"]..", "..BZ["Eastern Plaguelands"] };
		{ WHIT.."18) "..AL["Elder Windrun"]	..DASH..BZ["Crown Guard Tower"]..", "..BZ["Eastern Plaguelands"] };
		{ WHIT.."19) "..AL["Elder Farwhisper"]	..DASH..ORNG..BZ["Stratholme"]..DASH..BZ["Crusaders' Square"]..", "..BZ["Eastern Plaguelands"] };
		{ GREY..INDENT.."("..BZ["Festival Lane"]..")" };
		{ WHIT.."20) "..AL["Elder Moonstrike"]	..DASH..BZ["Scholomance"]..", "..BZ["Western Plaguelands"] };
		{ GREY..INDENT..AL["(The roof of Scholomance, outside the dungeon)"] };
		{ WHIT.."21) "..AL["Elder Meadowrun"]	..DASH..BZ["The Weeping Cave"]..", "..BZ["Western Plaguelands"] };
		{ WHIT.."22) "..AL["Elder Graveborn"]	..DASH..BZ["Brill"]..", "..BZ["Tirisfal Glades"] };
		{ WHIT.."23) "..AL["Elder Darkcore"]	..DASH..BLUE..BZ["Ruins of Lordaeron"]..", "..BZ["Undercity"]..", "..BZ["Tirisfal Glades"] };
		{ GREY..INDENT..AL["(On the ground)"] };
		{ WHIT.."24) "..AL["Elder Obsidian"]	..DASH..BZ["The Sepulcher"]..", "..BZ["Silverpine Forest"] };
	};
	Lunar_Kalimdor = {
		ZoneName = { AL["Lunar Festival"].." - "..BZ["Kalimdor"] };
		{ ORNG..AL["Lunar Festival"].." - "..AL["Jan. 23 ~ Feb. 13"] };
		{ "" };
		{ GREN.." 1') "..AL["Valadar Starsong"]..DASH..BZ["Nighthaven"]..", "..BZ["Moonglade"] };
		{ GREY..INDENT..AL["Quest: Elune's Blessing"] };
		{ GREN..INDENT..AL["Fariel Starsong"]..DASH..BZ["Nighthaven"]..", "..BZ["Moonglade"] };
		{ GREN.." 2') "..AL["Omen"]..DASH..AL["Southeast coast of the Lake Elune'ara"]..", "..BZ["Moonglade"] };
		{ "" };
		{ WHIT.." 1) "..AL["Elder Bladeleaf"]	..DASH..BZ["Dolanaar"]..", "..BZ["Teldrassil"] };
		{ WHIT.." 2) "..AL["Elder Bladeswift"]	..DASH..BLUE..BZ["Darnassus"]..", "..BZ["Teldrassil"] };
		{ GREY..INDENT.."("..BZ["Cenarion Enclave"]..")" };
		{ WHIT.." 3) "..AL["Elder Starweave"]	..DASH..BZ["Lor'danel"]..", "..BZ["Darkshore"] };
		{ WHIT.." 4) "..AL["Elder Riversong"]	..DASH..BZ["Astranaar"]..", "..BZ["Ashenvale"] };
		{ WHIT.." 5) "..AL["Elder Nightwind"]	..DASH..BZ["Jaedenar"]..", "..BZ["Felwood"] };
		{ WHIT.." 6) "..AL["Elder Brightspear"]	..DASH..BZ["The Ruins of Kel'Theril"]..", "..BZ["Winterspring"] };
		{ WHIT.." 7) "..AL["Elder Stonespire"]	..DASH..BZ["Everlook"]..", "..BZ["Winterspring"] };
		{ WHIT.." 8) "..AL["Elder Skygleam"]	..DASH..BZ["Ravencrest Monument"]..", "..BZ["Azshara"] };
		{ WHIT.." 9) "..AL["Elder Darkhorn"]	..DASH..BLUE..BZ["Orgrimmar"]..", "..BZ["Durotar"] };
		{ GREY..INDENT..AL["(Next to the flight master)"] };
		{ WHIT.."10) "..AL["Runetotem the Elder"]	..DASH..BZ["Razor Hill"]..", "..BZ["Durotar"] };
		{ WHIT.."11) "..AL["Elder Windtotem"]	..DASH..BZ["Ratchet"]..", "..BZ["Northern Barrens"] };
		{ WHIT.."12) "..AL["Elder Moonwarden"]	..DASH..BZ["The Crossroads"]..", "..BZ["Northern Barrens"] };
		{ WHIT.."13) "..AL["Elder High Mountain"]	..DASH..BZ["Vendetta Point"]..", "..BZ["Southern Barrens"] };
		{ WHIT.."14) "..AL["Elder Bloodhoof"]	..DASH..BZ["Bloodhoof Village"]..", "..BZ["Mulgore"] };
		{ WHIT.."15) "..AL["Elder Ezra Wheathoof"]	..DASH..BLUE..BZ["Thunder Bluff"]..", "..BZ["Mulgore"] };
		{ GREY..INDENT.."("..BZ["Elder Rise"]..")" };
		{ WHIT.."16) "..AL["Elder Skyseer"]	..DASH..BZ["Freewind Post"]..", "..BZ["Thousand Needles"] };
		{ WHIT.."17) "..AL["Elder Morningdew"]	..DASH..BZ["Fizzle & Pozzik's Speedbarge"]..", "..BZ["Thousand Needles"] };
		{ WHIT.."18) "..AL["Elder Dreamseer"]	..DASH..BZ["Gadgetzan"]..", "..BZ["Tanaris"] };
		{ WHIT.."19) "..AL["Elder Wildmane"]	..DASH..ORNG..BZ["Zul'Farrak"]..", "..BZ["Tanaris"] };
		{ WHIT.."20) "..AL["Elder Ragetotem"]	..DASH..BZ["Valley of the Watchers"]..", "..BZ["Tanaris"] };
		{ WHIT.."21) "..AL["Elder Thunderhorn"]	..DASH..BZ["The Slithering Scar"]..", "..BZ["Un'Goro Crater"] };
		{ WHIT.."22) "..AL["Elder Bladesing"]	..DASH..BZ["Cenarion Hold"]..", "..BZ["Silithus"] };
		{ WHIT.."23) "..AL["Elder Primestone"]	..DASH..BZ["The Crystal Vale"]..", "..BZ["Silithus"] };
		{ WHIT.."24) "..AL["Grimtotem Elder"]	..DASH..BZ["Lariss Pavilion"]..", "..BZ["Feralas"] };
		{ WHIT.."25) "..AL["Elder Mistwalker"]	..DASH..BZ["Dire Maul"]..", "..BZ["Feralas"] };
		{ GREY..INDENT.."("..BZ["The Maul"]..", "..BZ["Broken Commons"]..")" };
		{ WHIT.."26) "..AL["Elder Splitrock"]	..DASH..ORNG..BZ["Maraudon"]..", "..BZ["Desolace"] };
	};
	Lunar_Northrend = {
		ZoneName = { AL["Lunar Festival"].." - "..BZ["Northrend"] };
		{ ORNG..AL["Lunar Festival"].." - "..AL["Jan. 23 ~ Feb. 13"] };
		{ "" };
		{ WHIT.." 1) "..AL["Elder Sardis"]	..DASH..BZ["Valiance Keep"]..", "..BZ["Borean Tundra"] };
		{ WHIT.." 3) "..AL["Elder Pamuya"]	..DASH..BZ["Warsong Hold"]..", "..BZ["Borean Tundra"] };
		{ WHIT.." 4) "..AL["Elder Northal"]	..DASH..BZ["Transitus Shield"]..", "..BZ["Borean Tundra"] };
		{ WHIT.." 5) "..AL["Elder Igasho"]	..DASH..ORNG..BZ["The Nexus"]..", "..BZ["Borean Tundra"] };
		{ GREY..INDENT.."("..BZ["The Singing Grove"]..")" };
		{ WHIT.." 2) "..AL["Elder Arp"]	..DASH..BZ["D.E.H.T.A. Encampment"]..", "..BZ["Borean Tundra"] };
		{ WHIT.." 6) "..AL["Elder Sandrene"]	..DASH..BZ["Lakeside Landing"]..", "..BZ["Sholazar Basin"] };
		{ WHIT.." 7) "..AL["Elder Wanikaya"]	..DASH..BZ["Rainspeaker Rapids"]..", "..BZ["Sholazar Basin"] };
		{ WHIT.." 8) "..AL["Elder Bluewolf"]	..DASH.._RED..BZ["Wintergrasp Fortress"]..", "..BZ["Wintergrasp"] };
		{ GREY..INDENT..AL["(Inside the fortress)"] };
		{ WHIT.." 9) "..AL["Elder Nurgen"]	..DASH..ORNG..BZ["Azjol-Nerub"]..", "..BZ["Dragonblight"] };
		{ GREY..INDENT.."("..BZ["The Brood Pit"]..")" };
		{ WHIT.."10) "..AL["Elder Morthie"]	..DASH..BZ["Stars' Rest"]..", "..BZ["Dragonblight"] };
		{ WHIT.."11) "..AL["Elder Skywarden"]	..DASH..BZ["Agmar's Hammer"]..", "..BZ["Dragonblight"] };
		{ WHIT.."12) "..AL["Elder Thoim"]	..DASH..BZ["Moa'ki Harbor"]..", "..BZ["Dragonblight"] };
		{ WHIT.."13) "..AL["Elder Graymane"]	..DASH..BZ["K3"]..", "..BZ["The Storm Peaks"] };
		{ WHIT.."14) "..AL["Elder Fargal"]	..DASH..BZ["Frosthold"]..", "..BZ["The Storm Peaks"] };
		{ WHIT.."15) "..AL["Elder Stonebeard"]	..DASH..BZ["Bouldercrag's Refuge"]..", "..BZ["The Storm Peaks"] };
		{ WHIT.."16) "..AL["Elder Yurauk"]	..DASH..ORNG..BZ["Halls of Stone"]..", "..BZ["The Storm Peaks"] };
		{ GREY..INDENT.."("..BZ["Crystalline Quarry"]..")" };
		{ WHIT.."17) "..AL["Elder Muraco"]	..DASH..BZ["Camp Tunka'lo"]..", "..BZ["The Storm Peaks"] };
		{ WHIT.."18) "..AL["Elder Ohanzee"]	..DASH..ORNG..BZ["Gundrak"]..", "..BZ["Zul'Drak"] };
		{ GREY..INDENT.."("..BZ["Pool of Twisted Reflections"]..")" };
		{ WHIT.."19) "..AL["Elder Tauros"]	..DASH..BZ["Zim'Torga"]..", "..BZ["Zul'Drak"] };
		{ WHIT.."20) "..AL["Elder Kilias"]	..DASH..ORNG..BZ["Drak'Tharon Keep"]..", "..BZ["Zul'Drak"] };
		{ GREY..INDENT.."("..BZ["Raptor Pens"]..")" };
		{ WHIT.."21) "..AL["Elder Beldak"]	..DASH..BZ["Westfall Brigade Encampment"]..", "..BZ["Grizzly Hills"] };
		{ WHIT.."22) "..AL["Elder Whurain"]	..DASH..BZ["Camp Oneqwah"]..", "..BZ["Grizzly Hills"] };
		{ WHIT.."23) "..AL["Elder Lunaro"]	..DASH..BZ["Ruins of Tethys"]..", "..BZ["Grizzly Hills"] };
		{ WHIT.."24) "..AL["Elder Jarten"]	..DASH..ORNG..BZ["Utgarde Keep"]..", "..BZ["Howling Fjord"] };
		{ GREY..INDENT.."("..BZ["Njorn Stair"]..")" };
		{ WHIT.."25) "..AL["Elder Chogan'gada"]	..DASH..ORNG..BZ["Utgarde Pinnacle"]..", "..BZ["Howling Fjord"] };
	};
	MidSummer_Azeroth = {
		ZoneName = { AL["Midsummer Fire Festival"].." - "..BZ["Eastern Kingdoms"] };
		{ ORNG..AL["Midsummer Fire Festival"].." - "..AL["Jun. 21 ~ Jul. 4"] };
		{ "" };
		{ ORNG.." 1) "..BZ["Court of the Sun"].." (70, 43), "..BZ["Silvermoon City"] };
		{ _RED.." 2) "..BZ["North Sanctum"].." (46, 50), "..BZ["Eversong Woods"] };
		{ _RED.." 3) "..BZ["Tranquillien"].." (46, 26), "..BZ["Ghostlands"] };
		{ BLUE.." 4) "..BZ["Chillwind Camp"].." (43, 82), "..BZ["Western Plaguelands"] };
		{ _RED.." 5) "..BZ["The Bulwark"].." (29, 57), "..BZ["Western Plaguelands"] };
		{ _RED.." 6) "..BZ["Brill"].." (57, 52), "..BZ["Tirisfal Glades"] };
		{ ORNG.." 7) "..BZ["Ruins of Lordaeron"].." (68, 9), "..BZ["Tirisfal Glades"] };
		{ _RED.." 8) "..BZ["The Sepulcher"].." (49, 38), "..BZ["Silverpine Forest"] };
		{ _RED.." 9) "..BZ["Tarren Mill"].." (58, 25), "..BZ["Hillsbrad Foothills"] };
		{ BLUE.."10) "..BZ["Aerie Peak"].." (14, 50), "..BZ["The Hinterlands"] };
		{ _RED.."11) "..BZ["Revantusk Village"].." (76, 74), "..BZ["The Hinterlands"] };
		{ _RED.."12) "..BZ["Hammerfall"].." (74, 41), "..BZ["Arathi Highlands"] };
		{ BLUE.."13) "..BZ["Refuge Pointe"].." (50, 44), "..BZ["Arathi Highlands"] };
		{ BLUE.."14) "..BZ["Thundermar"].." (47, 28), "..BZ["Twilight Highlands"] };
		{ _RED.."15) "..BZ["Bloodgulch"].." (53, 46), "..BZ["Twilight Highlands"] };
		{ BLUE.."16) "..BZ["Menethil Harbor"].." (13, 47), "..BZ["Wetlands"] };
		{ ORNG.."17) "..BZ["Hall of Explorers"].." (64, 25), "..BZ["Ironforge"] };
		{ BLUE.."18) "..BZ["Kharanos"].." (46, 46), "..BZ["Dun Morogh"] };
		{ BLUE.."19) "..BZ["Thelsamar"].." (32, 40), "..BZ["Loch Modan"] };
		{ _RED.."20) "..BZ["New Kargath"].." (23, 37), "..BZ["Badlands"] };
		{ BLUE.."21) "..BZ["Dragon's Mouth"].." (18, 56), "..BZ["Badlands"] };
		{ _RED.."22) "..BZ["Flame Crest"].." (51, 29), "..BZ["Burning Steppes"] };
		{ BLUE.."23) "..BZ["Morgan's Vigil"].." (68, 60), "..BZ["Burning Steppes"] };
		{ BLUE.."24) "..BZ["Lakeshire"].." (25, 53), "..BZ["Redridge Mountains"] };
		{ BLUE.."25) "..BZ["Bogpaddle"].." (70, 15), "..BZ["Swamp of Sorrows"] };
		{ _RED.."26) "..BZ["Bogpaddle"].." (76, 13), "..BZ["Swamp of Sorrows"] };
		{ BLUE.."27) "..BZ["Nethergarde Supply Camps"].." (55, 15), "..BZ["Blasted Lands"] };
		{ _RED.."28) "..BZ["Dreadmaul Hold"].." (46, 14), "..BZ["Blasted Lands"] };
		{ BLUE.."29) "..BZ["Darkshire"].." (73, 55), "..BZ["Duskwood"] };
		{ BLUE.."30) "..BZ["Goldshire"].." (43, 65), "..BZ["Elwynn Forest"] };
		{ ORNG.."31) "..BZ["The Canals"].." (49, 72), "..BZ["Stormwind City"] };
		{ BLUE.."32) "..BZ["Moonbrook"].." (45, 62), "..BZ["Westfall"] };
		{ _RED.."33) "..BZ["Grom'gol Base Camp"].." (40, 51), "..BZ["Northern Stranglethorn"] };
		{ BLUE.."34) "..BZ["Fort Livingston"].." (51, 63), "..BZ["Northern Stranglethorn"] };
		{ BLUE.."35) "..BZ["Wild Shore"].." (51, 67), "..BZ["The Cape of Stranglethorn"] };
		{ _RED.."36) "..BZ["Wild Shore"].." (50, 70), "..BZ["The Cape of Stranglethorn"] };
		{ PURP.."37) "..BZ["Silver Tide Hollow"].."(49, 42), "..BZ["Shimmering Expanse"]..", "..BZ["Vashj'ir"] };
		{ "" };
		{ _RED..AL["Red: "]..BF["Horde"] };
		{ BLUE..AL["Blue: "]..BF["Alliance"] };
		{ ORNG..AL["Orange: "]..AL["Major Cities"] };
		{ PURP..AL["Purple: "]..BF["Neutral"] };
	
	};
	MidSummer_Kalimdor = {
		ZoneName = { AL["Midsummer Fire Festival"].." - "..BZ["Kalimdor"] };
		{ ORNG..AL["Midsummer Fire Festival"].." - "..AL["Jun. 21 ~ Jul. 4"] };
		{ "" };
		{ BLUE.." 1) "..BZ["Dolanaar"].." (54, 52), "..BZ["Teldrassil"] };
		{ ORNG.." 2) "..BZ["Warrior's Terrace"].." (62, 49), "..BZ["Darnassus"] };
		{ ORNG.." 3) "..BZ["The Crystal Hall"].." (41, 26), "..BZ["The Exodar"] };
		{ BLUE.." 4) "..BZ["Azure Watch"].." (44, 53), "..BZ["Azuremyst Isle"] };
		{ BLUE.." 5) "..BZ["Blood Watch"].." (55, 69), "..BZ["Bloodmyst Isle"] };
		{ BLUE.." 6) "..BZ["Lor'danel"].." (49, 23), "..BZ["Darkshore"] };
		{ _RED.." 7) "..BZ["Everlook"].." (58, 47), "..BZ["Winterspring"] };
		{ BLUE.." 8) "..BZ["Everlook"].." (61, 47), "..BZ["Winterspring"] };
		{ PURP.." 9) "..BZ["Nordrassil"].." (63, 23), "..BZ["Mount Hyjal"] };
		{ _RED.."10) "..BZ["Bilgewater Harbor"].." (60, 53), "..BZ["Azshara"] };
		{ ORNG.."11) "..BZ["Valley of Wisdom"].." (47, 38), "..BZ["Orgrimmar"] };
		{ _RED.."12) "..BZ["Razor Hill"].." (52, 47), "..BZ["Durotar"] };
		{ _RED.."13) "..BZ["The Crossroads"].." (50, 55), "..BZ["Northern Barrens"] };
		{ BLUE.."14) "..BZ["Forest Song"].." (87, 42), "..BZ["Ashenvale"] };
		{ _RED.."15) "..BZ["Silverwind Refuge"].." (51, 66), "..BZ["Ashenvale"] };
		{ _RED.."16) "..BZ["Sun Rock Retreat"].." (53, 62), "..BZ["Stonetalon Mountains"] };
		{ BLUE.."17) "..BZ["Mirkfallon Lake"].." (49, 51), "..BZ["Stonetalon Mountains"] };
		{ BLUE.."18) "..BZ["Nijel's Point"].." (65, 17), "..BZ["Desolace"] };
		{ _RED.."19) "..BZ["Shadowprey Village"].." (26, 76), "..BZ["Desolace"] };
		{ ORNG.."20) "..BZ["Spirit Rise"].." (21, 26), "..BZ["Thunder Bluff"] };
		{ _RED.."21) "..BZ["Bloodhoof Village"].." (51, 60), "..BZ["Mulgore"] };
		{ _RED.."22) "..BZ["Desolation Hold"].." (40, 67), "..BZ["Southern Barrens"] };
		{ BLUE.."23) "..BZ["Fort Triumph"].." (48, 72), "..BZ["Southern Barrens"] };
		{ _RED.."24) "..BZ["Brackenwall Village"].." (33, 30), "..BZ["Dustwallow Marsh"] };
		{ BLUE.."25) "..BZ["Theramore Isle"].." (62, 40), "..BZ["Dustwallow Marsh"] };
		{ BLUE.."26) "..BZ["Gadgetzan"].." (52, 30), "..BZ["Tanaris"] };
		{ _RED.."27) "..BZ["Gadgetzan"].." (49, 28), "..BZ["Tanaris"] };
		{ BLUE.."28) "..BZ["Vir'naal Oasis"].." (53, 32), "..BZ["Uldum"] };
		{ _RED.."29) "..BZ["Vir'naal Oasis"].." (53, 34), "..BZ["Uldum"] };
		{ _RED.."30) "..BZ["Marshal's Stand"].." (56, 66), "..BZ["Un'Goro Crater"] };
		{ _RED.."31) "..BZ["Marshal's Stand"].." (60, 63), "..BZ["Un'Goro Crater"] };
		{ BLUE.."32) "..BZ["Cenarion Hold"].." (60, 33), "..BZ["Silithus"] };
		{ _RED.."33) "..BZ["Cenarion Hold"].." (51, 41), "..BZ["Silithus"] };
		{ BLUE.."34) "..BZ["Feathermoon Stronghold"].." (47, 44), "..BZ["Feralas"] };
		{ _RED.."35) "..BZ["Camp Mojache"].." (72, 47), "..BZ["Feralas"] };
		{ "" };
		{ _RED..AL["Red: "]..BF["Horde"] };
		{ BLUE..AL["Blue: "]..BF["Alliance"] };
		{ ORNG..AL["Orange: "]..AL["Major Cities"] };
		{ PURP..AL["Purple: "]..BF["Neutral"] };
	};
	MidSummer_Outland = {
		ZoneName = { AL["Midsummer Fire Festival"].." - "..BZ["Outland"] };
		{ ORNG..AL["Midsummer Fire Festival"].." - "..AL["Jun. 21 ~ Jul. 4"] };
		{ "" };
		{ BLUE.." 1) "..BZ["Honor Hold"].." (62, 58), "..BZ["Hellfire Peninsula"] };
		{ _RED.." 2) "..BZ["Thrallmar"].." (55, 40), "..BZ["Hellfire Peninsula"] };
		{ BLUE.." 3) "..BZ["Telredor"].." (69, 52), "..BZ["Zangarmarsh"] };
		{ _RED.." 4) "..BZ["Zabra'jin"].." (36, 52), "..BZ["Zangarmarsh"] };
		{ BLUE.." 5) "..BZ["Sylvanaar"].." (42, 66), "..BZ["Blade's Edge Mountains"] };
		{ _RED.." 6) "..BZ["Thunderlord Stronghold"].." (50, 59), "..BZ["Blade's Edge Mountains"] };
		{ BLUE.." 7) "..BZ["Area 52"].." (31, 63), "..BZ["Netherstorm"] };
		{ _RED.." 8) "..BZ["Area 52"].." (32, 68), "..BZ["Netherstorm"] };
		{ BLUE.." 9) "..BZ["Telaar"].." (50, 70), "..BZ["Nagrand"] };
		{ _RED.."10) "..BZ["Garadar"].." (51, 34), "..BZ["Nagrand"] };
		{ _RED.."11) "..BZ["Stonebreaker Hold"].." (52, 43), "..BZ["Terokkar Forest"] };
		{ BLUE.."12) "..BZ["Allerian Stronghold"].." (55, 55), "..BZ["Terokkar Forest"] };
		{ _RED.."13) "..BZ["Shadowmoon Village"].." (33, 30), "..BZ["Shadowmoon Valley"] };
		{ BLUE.."14) "..BZ["Wildhammer Stronghold"].." (40, 55), "..BZ["Shadowmoon Valley"] };
		{ "" };
		{ _RED..AL["Red: "]..BF["Horde"] };
		{ BLUE..AL["Blue: "]..BF["Alliance"] };
		{ ORNG..AL["Orange: "]..AL["Major Cities"] };
	};
	MidSummer_Northrend = {
		ZoneName = { AL["Midsummer Fire Festival"].." - "..BZ["Northrend"] };
		{ ORNG..AL["Midsummer Fire Festival"].." - "..AL["Jun. 21 ~ Jul. 4"] };
		{ "" };
		{ BLUE.." 1) "..BZ["Fizzcrank Airstrip"].." (55, 20), "..BZ["Borean Tundra"] };
		{ _RED.." 2) "..BZ["Bor'gorok Outpost"].." (51, 12), "..BZ["Borean Tundra"] };
		{ BLUE.." 3) "..BZ["River's Heart"].." (47, 66), "..BZ["Sholazar Basin"] };
		{ _RED.." 4) "..BZ["River's Heart"].." (47, 62), "..BZ["Sholazar Basin"] };
		{ _RED.." 5) "..BZ["Agmar's Hammer"].." (39, 48), "..BZ["Dragonblight"] };
		{ BLUE.." 6) "..BZ["Wintergarde Keep"].." (75, 44), "..BZ["Dragonblight"] };
		{ BLUE.." 7) "..BZ["Windrunner's Overlook"].." (78, 75), "..BZ["Crystalsong Forest"] };
		{ _RED.." 8) "..BZ["Sunreaver's Command"].." (80, 53), "..BZ["Crystalsong Forest"] };
		{ _RED.." 9) "..BZ["K3"].." (40, 86), "..BZ["The Storm Peaks"] };
		{ BLUE.."10) "..BZ["K3"].." (42, 87), "..BZ["The Storm Peaks"] };
		{ BLUE.."11) "..BZ["The Argent Stand"].." (41, 61), "..BZ["Zul'Drak"] };
		{ _RED.."12) "..BZ["The Argent Stand"].." (43, 71), "..BZ["Zul'Drak"] };
		{ _RED.."13) "..BZ["Conquest Hold"].." (19, 61), "..BZ["Grizzly Hills"] };
		{ BLUE.."14) "..BZ["Amberpine Lodge"].." (34, 61), "..BZ["Grizzly Hills"] };
		{ _RED.."15) "..BZ["Camp Winterhoof"].." (48, 13), "..BZ["Howling Fjord"] };
		{ BLUE.."16) "..BZ["Fort Wildervar"].." (58, 16), "..BZ["Howling Fjord"] };
		{ "" };
		{ _RED..AL["Red: "]..BF["Horde"] };
		{ BLUE..AL["Blue: "]..BF["Alliance"] };
		{ ORNG..AL["Orange: "]..AL["Major Cities"] };
	};
	MidSummer_Azeroth_MajorCities = {
		ZoneName = { AL["Midsummer Fire Festival"].." - "..BZ["Eastern Kingdoms"].." ("..AL["Major Cities"]..")" };
		{ ORNG..AL["Midsummer Fire Festival"].." - "..AL["Jun. 21 ~ Jul. 4"] };
		{ "" };
		{ BLUE.." 1) "..BZ["Hall of Explorers"]..", "..BZ["Ironforge"] };
		{ BLUE.." 2) "..BZ["Mage Quarter"]..", "..BZ["Stormwind City"] };
		{ _RED.." 3) "..BZ["Court of the Sun"]..", "..BZ["Silvermoon City"] };
		{ _RED.." 4) "..BZ["Ruins of Lordaeron"]..", "..BZ["Undercity"] };
		{ "" };
		{ _RED..AL["Red: "]..BF["Horde"] };
		{ BLUE..AL["Blue: "]..BF["Alliance"] };
		{ ORNG..AL["Orange: "]..AL["Major Cities"] };
	};
	MidSummer_Kalimdor_MajorCities = {
		ZoneName = { AL["Midsummer Fire Festival"].." - "..BZ["Kalimdor"].." ("..AL["Major Cities"]..")" };
		{ ORNG..AL["Midsummer Fire Festival"].." - "..AL["Jun. 21 ~ Jul. 4"] };
		{ "" };
		{ BLUE.." 1) "..BZ["Warrior's Terrace"].." (63, 47), "..BZ["Darnassus"] };
		{ BLUE.." 2) "..BZ["The Crystal Hall"].." (41, 26), "..BZ["The Exodar"] };
		{ _RED.." 3) "..BZ["Valley of Wisdom"].." (47, 38), "..BZ["Orgrimmar"] };
		{ _RED.." 4) "..BZ["Spirit Rise"].." (21, 26), "..BZ["Thunder Bluff"] };
		{ "" };
		{ _RED..AL["Red: "]..BF["Horde"] };
		{ BLUE..AL["Blue: "]..BF["Alliance"] };
		{ ORNG..AL["Orange: "]..AL["Major Cities"] };
	};
	MidSummer_Deepholm = {
		ZoneName = { AL["Midsummer Fire Festival"].." - "..BZ["Deepholm"] };
		{ ORNG..AL["Midsummer Fire Festival"].." - "..AL["Jun. 21 ~ Jul. 4"] };
		{ "" };
		{ PURP.." 1) "..BZ["Temple of Earth"].." (49, 51)" };
		{ "" };
		{ PURP..AL["Purple: "]..BF["Neutral"] };
	};
	Hallow_End = {
		ZoneName = { AL["Hallow's End"] };
		{ ORNG..AL["Hallow's End"].." - "..AL["Oct. 18 ~ Oct. 31"] };
		{ "" };
		{ _RED..AL["Horde Questline"] };
		{ YELL.." 1) "..AL["Quest: "]..AL["Masked Orphan Matron"] };
		{ _RED..INDENT.." 1) "..AL["Start"]..": "..AL["Orc Commoner"].." (51, 74), " };
		{ GREY..INDENT..INDENT..BZ["Valley of Strength"]..", "..BZ["Orgrimmar"] };
		{ _RED..INDENT.." 2) "..AL["End"]..": "..AL["Masked Orphan Matron"].." (52, 41), " };
		{ GREY..INDENT..INDENT..BZ["Razor Hill"]..", "..BZ["Durotar"] };
		{ _RED..INDENT.." 2')"..AL["End"]..": "..AL["Masked Orphan Matron"].." (61, 54), " };
		{ GREY..INDENT..INDENT..BZ["Brill"]..", "..BZ["Tirisfal Glades"] };
		{ _RED..INDENT.." 2\")"..AL["End"]..": "..AL["Masked Orphan Matron"].." (47, 47), " };
		{ GREY..INDENT..INDENT..BZ["Falconwing Square"]..", "..BZ["Silvermoon City"] };
		{ YELL.." 2) "..AL["Quest: "]..AL["Fire Training"] };
		{ _RED..INDENT.." 2) "..AL["Start"].." / "..AL["End"]..": "..AL["Masked Orphan Matron"].." (52, 41), " };
		{ GREY..INDENT..INDENT..BZ["Razor Hill"]..", "..BZ["Durotar"] };
		{ _RED..INDENT.." 2') "..AL["Start"].." / "..AL["End"]..": "..AL["Masked Orphan Matron"].." (61, 54), " };
		{ GREY..INDENT..INDENT..BZ["Brill"]..", "..BZ["Tirisfal Glades"] };
		{ _RED..INDENT.." 2\") "..AL["Start"].." / "..AL["End"]..": "..AL["Masked Orphan Matron"].." (47, 47), " };
		{ GREY..INDENT..INDENT..BZ["Falconwing Square"]..", "..BZ["Silvermoon City"] };
		{ CYAN.." 3) "..AL["Quest: "]..AL["\"Let the Fires Come!\""].." / "..AL["Stop the Fires!"] };
		{ _RED..INDENT.." 2) "..AL["Start"].." / "..AL["End"]..": "..AL["Masked Orphan Matron"].." (52, 41), " };
		{ GREY..INDENT..INDENT..BZ["Razor Hill"]..", "..BZ["Durotar"] };
		{ _RED..INDENT.." 2') "..AL["Start"].." / "..AL["End"]..": "..AL["Masked Orphan Matron"].." (61, 54), " };
		{ GREY..INDENT..INDENT..BZ["Brill"]..", "..BZ["Tirisfal Glades"] };
		{ _RED..INDENT.." 2\") "..AL["Start"].." / "..AL["End"]..": "..AL["Masked Orphan Matron"].." (47, 47), " };
		{ GREY..INDENT..INDENT..BZ["Falconwing Square"]..", "..BZ["Silvermoon City"] };
		{ YELL.." 4) "..AL["Quest: "]..AL["Hallow's End Treats for Spoops!"] };
		{ _RED..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Spoops"].." (71, 23), " };
		{ GREY..INDENT..INDENT..BZ["Valley of Honor"]..", "..BZ["Orgrimmar"] };
		{ WHIT..INDENT..AL["Orgrimmar Nougat"]..": " };
		{ _RED..INDENT..INDENT.." 1) "..AL["Innkeeper Gryshka"].." (53, 78), "..AL["Trick: "].."/flex" };
		{ GREY..INDENT..INDENT..BZ["Valley of Strength"]..", "..BZ["Orgrimmar"] };
		{ WHIT..INDENT..AL["Darkspear Gumdrop"]..": " };
		{ _RED..INDENT..INDENT.." 1) "..AL["Kali Remik"].." (32, 65), "..AL["Trick: "].."/train" };
		{ GREY..INDENT..INDENT..BZ["Valley of Spirits"]..", "..BZ["Orgrimmar"] };
		{ WHIT..INDENT..AL["Thunder Bluff Marzipan"]..": " };
		{ _RED..INDENT..INDENT.." 3) "..AL["Innkeeper Pala"].." (45, 63), "..AL["Trick: "].."/dance" };
		{ GREY..INDENT..INDENT..BZ["Thunder Bluff"] };
		{ WHIT..INDENT..AL["Undercity Mint"]..": " };
		{ _RED..INDENT..INDENT.." 4) "..AL["Innkeeper Norman"].." (67, 38), "..AL["Trick: "].."/chicken" };
		{ GREY..INDENT..INDENT..BZ["Undercity"] };
		{ "" };
		{ BLUE..AL["Alliance Questline"] };
		{ YELL.." 1) "..AL["Quest: "]..AL["Costumed Orphan Matron"] };
		{ BLUE..INDENT.." 1) "..AL["Start"]..": "..AL["Human Commoner"] };
		{ GREY..INDENT..INDENT..BZ["Stormwind City"] };
		{ BLUE..INDENT.." 2)"..AL["End"]..": "..AL["Costumed Orphan Matron"].." (43, 64), " };
		{ GREY..INDENT..INDENT..BZ["Goldshire"]..", "..BZ["Elwynn Forest"] };
		{ BLUE..INDENT.." 2')"..AL["End"]..": "..AL["Costumed Orphan Matron"].." (46, 53), " };
		{ GREY..INDENT..INDENT..BZ["Kharanos"]..", "..BZ["Dun Morogh"] };
		{ BLUE..INDENT.." 2\")"..AL["End"]..": "..AL["Costumed Orphan Matron"].." (49, 51), " };
		{ GREY..INDENT..INDENT..BZ["Azure Watch"]..", "..BZ["Azuremyst Isle"] };
		{ YELL.." 2) "..AL["Quest: "]..AL["Fire Brigade Practice"] };
		{ BLUE..INDENT.." 2) "..AL["Start"].." / "..AL["End"]..": "..AL["Costumed Orphan Matron"].." (43, 64), " };
		{ GREY..INDENT..INDENT..BZ["Goldshire"]..", "..BZ["Elwynn Forest"] };
		{ BLUE..INDENT.." 2') "..AL["Start"].." / "..AL["End"]..": "..AL["Costumed Orphan Matron"].." (46, 53), " };
		{ GREY..INDENT..INDENT..BZ["Kharanos"]..", "..BZ["Dun Morogh"] };
		{ BLUE..INDENT.." 2\") "..AL["Start"].." / "..AL["End"]..": "..AL["Costumed Orphan Matron"].." (49, 51), " };
		{ GREY..INDENT..INDENT..BZ["Azure Watch"]..", "..BZ["Azuremyst Isle"] };
		{ CYAN.." 3) "..AL["Quest: "]..AL["\"Let the Fires Come!\""].." / "..AL["Stop the Fires!"] };
		{ BLUE..INDENT.." 2) "..AL["Start"].." / "..AL["End"]..": "..AL["Costumed Orphan Matron"].." (43, 64), " };
		{ GREY..INDENT..INDENT..BZ["Goldshire"]..", "..BZ["Elwynn Forest"] };
		{ BLUE..INDENT.." 2') "..AL["Start"].." / "..AL["End"]..": "..AL["Costumed Orphan Matron"].." (46, 53), " };
		{ GREY..INDENT..INDENT..BZ["Kharanos"]..", "..BZ["Dun Morogh"] };
		{ BLUE..INDENT.." 2\") "..AL["Start"].." / "..AL["End"]..": "..AL["Costumed Orphan Matron"].." (49, 51), " };
		{ GREY..INDENT..INDENT..BZ["Azure Watch"]..", "..BZ["Azuremyst Isle"] };
		{ YELL.." 4) "..AL["Quest: "]..AL["Hallow's End Treats for Jesper!"] };
		{ BLUE..INDENT..AL["Start"].." / "..AL["End"]..": "..AL["Jesper"].." (57, 52), " };
		{ GREY..INDENT..INDENT..BZ["Cathedral Square"]..", "..BZ["Stormwind City"] };
		{ WHIT..INDENT..AL["Stormwind Nougat"]..": " };
		{ BLUE..INDENT..INDENT.." 1) "..AL["Innkeeper Allison"].." (60, 74), "..AL["Trick: "].."/flex" };
		{ GREY..INDENT..INDENT..BZ["Trade District"]..", "..BZ["Stormwind City"] };
		{ WHIT..INDENT..AL["Gnomeregan Gumdrop"]..": " };
		{ BLUE..INDENT..INDENT.." 3) "..AL["Talvash del Kissel"].." (64, 19), "..AL["Trick: "].."/train" };
		{ GREY..INDENT..INDENT..BZ["Hall of Explorers"]..", "..BZ["Ironforge"] };
		{ WHIT..INDENT..AL["Ironforge Mint"]..": " };
		{ BLUE..INDENT..INDENT.." 3) "..AL["Innkeeper Firebrew"].." (18, 51), "..AL["Trick: "].."/chiken" };
		{ GREY..INDENT..INDENT..BZ["Ironforge"] };
		{ WHIT..INDENT..AL["Darnassus Marzipan"]..": " };
		{ BLUE..INDENT..INDENT.." 4) "..AL["Innkeeper Saelienne"].." (62, 32), "..AL["Trick: "].."/dance" };
		{ GREY..INDENT..INDENT..BZ["Craftsmen's Terrace"]..", "..BZ["Darnassus"] };
	};
	DarkmoonFaire_Island = {
		ZoneName = { BF["Darkmoon Faire"].." - "..BZ["Darkmoon Island"] };
		{ ORNG..AL["The first Sunday each month, last for a week"] };
		{ "" };
		{ BLUE.." A) "..AL["Entrance (Transported)"] };
		{ BLUE.." B) "..AL["Portals"] };
		{ BLUE.." 1) "..BZ["Deathmatch Pavilion"] };
		{ BLUE.." 2) "..AL["Petting Zoo"] };
		{ BLUE.." 3) "..AL["L90ETC Concert"] };
		{ "" };
		{ GREN.." 1) "..AL["Selina Dourman <Darkmoon Faire Information>"].." (56, 55)" };
		{ GREN.." 2) "..AL["Zina Sharpworth <Game Tokens>"].." (54, 53)" };
		{ GREN.." 3) "..AL["Mola <Whack-a-Mole>"].." (53, 55)" };
		{ INDENT..CYAN..AL["Quest: "]..AL["It's Hammer Time"] };
		{ GREN.." 4) "..AL["Maxima Blastenheimer <Darkmoon Faire Cannoneer>"].." (53, 56)" };
		{ INDENT..CYAN..AL["Quest: "]..AL["The Humanoid Cannonball"] };
		{ GREN.." 5) "..AL["Rinling"].." (49, 61)" };
		{ INDENT..CYAN..AL["Quest: "]..AL["He Shoots, He Scores!"] };
		{ GREN.." 6) "..AL["Sazz Coincatcher <Game Tokens>"].." (49, 62)" };
		{ GREN.." 7) "..AL["Gelvas Grimegate <Souvenir & Toy Prizes>"].." (48, 65)" };
		{ GREN.." 8) "..AL["Professor Thaddeus Paleo <Darkmoon Cards>"].." (52, 61)" };
		{ GREN.." 9) "..AL["Aimee <Pie, Pastry & Cakes>"].." (51, 63)" };
		{ GREN.."10) "..AL["Finlay Coolshot <Tonk Challenge>"].." (51, 65)" };
		{ INDENT..CYAN..AL["Quest: "]..AL["Tonk Commander"] };
		{ GREN.."11) "..AL["Stamp Thunderhorn <Food Vendor>"].." (53, 68)" };
		{ INDENT..AL["Quest: "]..AL["Putting the Crunch in the Frog"] };
		{ GREN.."12) "..AL["Chronos <He Who Never Forgets!>"].." (55, 71)" };
		{ INDENT..AL["Quest: "]..AL["Putting the Carnies Back Together Again"] };
		{ INDENT..AL["Quest: "]..AL["Keeping the Faire Sparkling"] };
		{ GREN.."13) "..AL["Sylannia <Drink Vendor>"].." (50, 69)" };
		{ GREN.."14) "..AL["Baruma <Replica Armor Prizes>"].." (48, 66)" };
		{ INDENT..GREN..AL["Barum <Replica Armor Prizes>"] };
		{ INDENT..GREN..AL["Daenrand Dawncrest <Heirloom Prizes>"] };
		{ INDENT..GREN..AL["Kerri Hicks <The Strongest Woman Alive!>"] };
		{ INDENT..AL["Quest: "]..AL["Test Your Strength"] };
		{ GREN.."15) "..AL["Lhara <Pet & Mount Prizes>"].." (48, 69)" };
		{ GREN.."16) "..AL["Boomie Sparks <Fireworks>"].." (48, 72)" };
		{ GREN.."17) "..AL["Trixi Sharpworth <Game Tokens>"].." (49, 76)" };
		{ GREN.."18) "..AL["Korgol Crushskull <The Pit Master>"].." (47, 79)" };
		{ GREN.."19) "..AL["Sayge"].." (53, 76)" };
		{ INDENT..AL["Quest: "]..AL["Putting Trash to Good Use"] };
		{ GREN.."20) "..AL["Jessica Rogers <Ring Toss>"].." (52, 78)" };
		{ INDENT..CYAN..AL["Quest: "]..AL["Target: Turtle"] };
		{ GREN.."21) "..AL["Tatia Brine <Fishing Supplies>"].." (53, 88)" };
		{ INDENT..GREN..AL["Steven Stagnaro <Fishing Trainer>"] };
		{ GREN.."22) "..AL["Teleportologist Fozlebub <Gone Fishin'>"].." (57, 90)" };
		{ GREN.."23) "..AL["Rona Greenteeth"].." (36, 58)" };
	};
	Brewfest_Alliance_MajorCities = {
		ZoneName = { AL["Brewfest"].." - "..BF["Alliance"].." ("..AL["Major Cities"]..")" };
		Location = { BZ["Ironforge"].." / "..BZ["Stormwind City"].." / "..BZ["Darnassus"].." / "..BZ["The Exodar"] };
		{ ORNG..AL["Brewfest"].." - "..AL["Sep. 28 ~ Oct. 13"] };
		{ "" };
		{ BLUE..AL["Alliance Questline"] };
		{ YELL.." 1) "..AL["Quest: "]..AL["Brewfest!"] };
		{ BLUE..INDENT.." 1) "..AL["Start"]..": "..AL["Dwarf Commoner"] };
		{ GREY..INDENT..INDENT.."(30, 62) "..BZ["Ironforge"] };
		{ BLUE..INDENT.." 2) "..AL["Start"]..": "..AL["Gnome Commoner"] };
		{ GREY..INDENT..INDENT.."(57, 49) "..BZ["Ironforge"] };
		{ BLUE..INDENT.." 3) "..AL["Start"]..": "..AL["Human Commoner"] };
		{ GREY..INDENT..INDENT.."(61, 74) "..BZ["Stormwind City"] };
		{ BLUE..INDENT.." 4) "..AL["Start"]..": "..AL["Night Elf Commoner"] };
		{ GREY..INDENT..INDENT.."(44, 52) "..BZ["Darnassus"] };
		{ BLUE..INDENT.." 5) "..AL["Start"]..": "..AL["Draenei Commoner"] };
		{ GREY..INDENT..INDENT.."(60, 48), (51, 42) "..BZ["The Exodar"] };
		{ YELL.." 2) "..AL["Quest: "]..AL["Brew of the Month Club"] };
		{ BLUE..INDENT.." 6) "..AL["End"]..": "..AL["Larkin Thunderbrew"] };
		{ GREY..INDENT..INDENT.."(19, 53) "..BZ["Ironforge"] };	};
	Brewfest_Alliance = {
		ZoneName = { AL["Brewfest"].." - "..BF["Alliance"] };
		Location = { BZ["Dun Morogh"] };
		{ ORNG..AL["Brewfest"].." - "..AL["Sep. 28 ~ Oct. 13"] };
		{ "" };
		{ BLUE..AL["Alliance Questline"] };
		{ YELL.." 1) "..AL["Quest: "]..AL["Brewfest!"] };
		{ BLUE..INDENT.." 1) "..AL["End"]..": "..AL["Ipfelkofer Ironkeg"] };
		{ GREY..INDENT..INDENT.."(55, 38) "..BZ["Dun Morogh"] };
		{ YELL.." 2) "..AL["Quest: "]..AL["Catch the Wild Wolpertinger!"] };
		{ YELL.." 3) "..AL["Quest: "]..AL["Pink Elekks On Parade"] };
		{ BLUE..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Goldark Snipehunter"] };
		{ GREY..INDENT..INDENT.."(55, 37) "..BZ["Dun Morogh"] };
		{ YELL.." 4) "..AL["Quest: "]..AL["Chug and Chuck!"] };
		{ BLUE..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Boxey Boltspinner"] };
		{ GREY..INDENT..INDENT.."(54, 38) "..BZ["Dun Morogh"] };
		{ YELL.." 5) "..AL["Quest: "]..AL["Now This is Ram Racing... Almost."] };
		{ BLUE..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Neill Ramstein"] };
		{ GREY..INDENT..INDENT.."(53, 38) "..BZ["Dun Morogh"] };
		{ YELL.." 6) "..AL["Quest: "]..AL["There and Back Again"] };
		{ BLUE..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Neill Ramstein"] };
		{ GREY..INDENT..INDENT.."(53, 38) "..BZ["Dun Morogh"] };
		{ BLUE..INDENT.." 2) "..AL["Flynn Firebrew"] };
		{ GREY..INDENT..INDENT.."(52, 51) "..BZ["Kharanos"]..", "..BZ["Dun Morogh"] };
		{ YELL.." 7) "..AL["Quest: "]..AL["A New Supplier of Souvenirs"] };
		{ BLUE..INDENT.." 1) "..AL["Start"]..": "..AL["Pol Amberstill"] };
		{ GREY..INDENT..INDENT.."(53, 38) "..BZ["Dun Morogh"] };
		{ BLUE..INDENT.." 1) "..AL["End"]..": "..AL["Belbi Quikswitch"] };
		{ GREY..INDENT..INDENT.."(56, 37) "..BZ["Dun Morogh"] };
		{ CYAN.." 8) "..AL["Quest: "]..AL["Bark for the Barleybrews!"] };
		{ BLUE..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Becan Barleybrew"] };
		{ GREY..INDENT..INDENT.."(56, 37) "..BZ["Dun Morogh"] };
		{ CYAN.." 9) "..AL["Quest: "]..AL["Bark for the Thunderbrews!"] };
		{ BLUE..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Daran Thunderbrew"] };
		{ GREY..INDENT..INDENT.."(56, 36) "..BZ["Dun Morogh"] };
		{ CYAN.."10) "..AL["Quest: "]..AL["Brew For Brewfest"] };
		{ BLUE..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Neill Ramstein"] };
		{ GREY..INDENT..INDENT.."(53, 38) "..BZ["Dun Morogh"] };
		{ CYAN.."11) "..AL["Quest: "]..AL["This One Time, When I Was Drunk..."] };
		{ BLUE..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Dark Iron Mole Machine Wreckage"] };
		{ GREY..INDENT..INDENT.."(56, 37) "..BZ["Dun Morogh"] };
		{ BLUE..INDENT.." 1) "..AL["End"].." / "..AL["End"]..": "..AL["Boxey Boltspinner"] };
		{ GREY..INDENT..INDENT.."(54, 38) "..BZ["Dun Morogh"] };
	};
	Brewfest_Horde_MajorCities = {
		ZoneName = { AL["Brewfest"].." - "..BF["Horde"].." ("..AL["Major Cities"]..")" };
		Location = { BZ["Orgrimmar"].." / "..BZ["Undercity"].." / "..BZ["Thunder Bluff"].." / "..BZ["Silvermoon City"] };
		{ ORNG..AL["Brewfest"].." - "..AL["Sep. 28 ~ Oct. 13"] };
		{ "" };
		{ BLUE..AL["Horde Questline"] };
		{ YELL.." 1) "..AL["Quest: "]..AL["Brewfest!"] };
		{ _RED..INDENT.." 1) "..AL["Start"]..": "..AL["Orc Commoner"] };
		{ GREY..INDENT..INDENT.."(51, 75) "..BZ["Orgrimmar"] };
		{ _RED..INDENT.." 2) "..AL["Start"]..": "..AL["Troll Commoner"] };
		{ GREY..INDENT..INDENT.."(49, 61) "..BZ["Orgrimmar"] };
		{ _RED..INDENT.." 3) "..AL["Start"]..": "..AL["Tauren Commoner"] };
		{ GREY..INDENT..INDENT.."(40, 48) "..BZ["Orgrimmar"] };
		{ _RED..INDENT.." 4) "..AL["Start"]..": "..AL["Forsaken Commoner"] };
		{ GREY..INDENT..INDENT.."(63, 48) "..BZ["Undercity"] };
		{ _RED..INDENT.." 5) "..AL["Start"]..": "..AL["Tauren Commoner"] };
		{ GREY..INDENT..INDENT.."(41, 55) "..BZ["Thunder Bluff"] };
		{ _RED..INDENT.." 6) "..AL["Start"]..": "..AL["Blood Elf Commoner"] };
		{ GREY..INDENT..INDENT.."(77, 57), (59, 60), (62, 73), (90, 57), "..BZ["Silvermoon City"] };
		{ YELL.." 2) "..AL["Quest: "]..AL["Brew of the Month Club"] };
		{ _RED..INDENT.." 7) "..AL["End"]..": "..AL["Ray'ma"] };
		{ GREY..INDENT..INDENT.."(50, 73) "..BZ["Orgrimmar"] };
	};
	Brewfest_Horde = {
		ZoneName = { AL["Brewfest"].." - "..BF["Horde"] };
		Location = { BZ["Durotar"] };
		{ ORNG..AL["Brewfest"].." - "..AL["Sep. 28 ~ Oct. 13"] };
		{ "" };
		{ _RED..AL["Horde Questline"] };
		{ YELL.." 1) "..AL["Quest: "]..AL["Brewfest!"] };
		{ _RED..INDENT.." 1) "..AL["End"]..": "..AL["Tapper Swindlekeg"] };
		{ GREY..INDENT..INDENT.."(41, 18) "..BZ["Durotar"] };
		{ YELL.." 2) "..AL["Quest: "]..AL["Catch the Wild Wolpertinger!"] };
		{ YELL.." 3) "..AL["Quest: "]..AL["Pink Elekks On Parade"] };
		{ _RED..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Glodrak Huntsniper"] };
		{ GREY..INDENT..INDENT.."(41, 18) "..BZ["Durotar"] };
		{ YELL.." 4) "..AL["Quest: "]..AL["Chug and Chuck!"] };
		{ _RED..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Bizzle Quicklift"] };
		{ GREY..INDENT..INDENT.."(41, 17) "..BZ["Durotar"] };
		{ YELL.." 5) "..AL["Quest: "]..AL["Now This is Ram Racing... Almost."] };
		{ _RED..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Ram Master Ray"] };
		{ GREY..INDENT..INDENT.."(42, 17) "..BZ["Durotar"] };
		{ YELL.." 6) "..AL["Quest: "]..AL["There and Back Again"] };
		{ _RED..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Ram Master Ray"] };
		{ GREY..INDENT..INDENT.."(42, 17) "..BZ["Durotar"] };
		{ _RED..INDENT.." 2) "..AL["Bok Dropcertain"] };
		{ GREY..INDENT..INDENT.."(50, 13) "..BZ["Skull Rock"]..", "..BZ["Durotar"] };
		{ YELL.." 7) "..AL["Quest: "]..AL["A New Supplier of Souvenirs"] };
		{ _RED..INDENT.." 1) "..AL["Start"]..": "..AL["Driz Tumblequick"] };
		{ GREY..INDENT..INDENT.."(42, 17) "..BZ["Durotar"] };
		{ _RED..INDENT.." 1) "..AL["End"]..": "..AL["Blix Fixwidget"] };
		{ GREY..INDENT..INDENT.."(40, 17) "..BZ["Durotar"] };
		{ CYAN.." 8) "..AL["Quest: "]..AL["Bark for Drohn's Distillery!"] };
		{ _RED..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Cort Gorestein"] };
		{ GREY..INDENT..INDENT.."(40, 18) "..BZ["Durotar"] };
		{ CYAN.." 9) "..AL["Quest: "]..AL["Bark for T'chali's Voodoo Brewery!"] };
		{ _RED..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Ja'ron"] };
		{ GREY..INDENT..INDENT.."(40, 17) "..BZ["Durotar"] };
		{ CYAN.."10) "..AL["Quest: "]..AL["Brew For Brewfest"] };
		{ _RED..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Ram Master Ray"] };
		{ GREY..INDENT..INDENT.."(42, 17) "..BZ["Durotar"] };
		{ CYAN.."11) "..AL["Quest: "]..AL["This One Time, When I Was Drunk..."] };
		{ _RED..INDENT.." 1) "..AL["Start"].." / "..AL["End"]..": "..AL["Dark Iron Mole Machine Wreckage"] };
		{ GREY..INDENT..INDENT.."(41, 17) "..BZ["Durotar"] };
		{ _RED..INDENT.." 1) "..AL["End"].." / "..AL["End"]..": "..AL["Bizzle Quicklift"] };
		{ GREY..INDENT..INDENT.."(41, 17) "..BZ["Durotar"] };
	};
};


Atlas_RegisterPlugin("Atlas_WorldEvents", myCategory, myData);
