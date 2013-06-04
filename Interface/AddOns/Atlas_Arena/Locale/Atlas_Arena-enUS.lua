--[[

	Atlas Arena, a World of Warcraft instance map browser
	Copyright 2010 - 2013 Arith Hsu

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
--if ( GetLocale() ==	"enUS" ) then
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local AL = AceLocale:NewLocale("Atlas_Arena", "enUS", true);

if AL then

	--Common
	AL["Arena Maps"] = "Arena Maps";
	AL["Quests"] = "Quests";
	AL["Start"] = "Start";
	
	-- Gurubashi Arena
	AL["Short John Mithril"] = "Short John Mithril";
	AL["Stone Guard Towhide"] = "Stone Guard Towhide";

	-- Circle of Blood Arena
	AL["Frixee Brasstumbler <Arena Vendor>"] = "Frixee Brasstumbler <Arena Vendor>";
	AL["Meminnie <Arena Vendor>"] = "Meminnie <Arena Vendor>";
	
	-- The Ring of Trials
	AL["Kelara <Keeper of Sha'tari Heirlooms>"] = "Kelara <Keeper of Sha'tari Heirlooms>";
	AL["Grikkin Copperspring <Arena Vendor>"] = "Grikkin Copperspring <Arena Vendor>";
	
	-- The Ring of Blood
	AL["Mogor <Hero of the Warmaul>"] = "Mogor <Hero of the Warmaul>"; -- 18069
	AL["Gurgthock"] = "Gurgthock"; -- 18471	
	
	-- The Rumble Cage
	AL["Dr. Dealwell"] = "Dr. Dealwell";
	AL["Katrina Turner"] = "Katrina Turner";
	AL["Vixton Pinchwhistle <Legacy Arena Armor>"] = "Vixton Pinchwhistle <Legacy Arena Armor>"; -- 20278
	AL["Blazzek the Biter <Legacy Arena Weapons>"] = "Blazzek the Biter <Legacy Arena Weapons>"; -- 40216
	AL["Evee Copperspring <Arena Vendor>"] = "Evee Copperspring <Arena Vendor>";
	AL["Ecton Brasstumbler <Arena Vendor>"] = "Ecton Brasstumbler <Arena Vendor>";
	
	-- Dalaran Sewers
	AL["Xazi Smolderpipe <Arena Vendor>"] = "Xazi Smolderpipe <Arena Vendor>";
	AL["Zom Bocom <Apprentice Arena Vendor>"] = "Zom Bocom <Apprentice Arena Vendor>";
	AL["Nargle Lashcord <Veteran Arena Vendor>"] = "Nargle Lashcord <Veteran Arena Vendor>";
	AL["Trapjaw Rix <Exceptional Arena Weaponry>"] = "Trapjaw Rix <Exceptional Arena Weaponry>";

	-- The Crucible of Carnage
	AL["Gurgthock <Fight Promoter>"] = "Gurgthock <Fight Promoter>"; -- 46935
	AL["Wodin the Troll-Servant"] = "Wodin the Troll-Servant"; -- 46936

	-- Valhalas
	AL["Geirrvif"] = "Geirrvif"; -- 31135
	AL["Gjonner the Merciless"] = "Gjonner the Merciless"; -- 31154
	
	-- Amphitheater of Anguish
	AL["Yggdras"] = "Yggdras";
	AL["Stinkbeard"] = "Stinkbeard";
	AL["Elemental Lord"] = "Elemental Lord";
	AL["Az'Barin, Prince of the Gust"] = "Az'Barin, Prince of the Gust";
	AL["Duke Singen <The New Hotness>"] = "Duke Singen <The New Hotness>";
	AL["Erathius, King of Dirt"] = "Erathius, King of Dirt";
	AL["Gargoral the Water Lord"] = "Gargoral the Water Lord";
	AL["Orinoko Tuskbreaker"] = "Orinoko Tuskbreaker";
	AL["Korrak the Bloodrager <Champion of the Winterax>"] = "Korrak the Bloodrager <Champion of the Winterax>";
	AL["Vladof the Butcher"] = "Vladof the Butcher";
end
