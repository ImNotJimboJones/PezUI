--[[

	Atlas Arena, a World of Warcraft instance map browser
	Copyright 2010 - 2011 Arith Hsu

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
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local AL = AceLocale:NewLocale("Atlas_Arena", "deDE", false);

if AL then

	--Common
	AL["Arena Maps"] = "Arena Maps";
	AL["Quests"] = "Quests";
	
	-- Gurubashi Arena
	AL["Short John Mithril"] = "Störtebrecher";
	AL["Stone Guard Towhide"] = "Steingardist Werghaut";

	-- Circle of Blood Arena
	AL["Frixee Brasstumbler <Arena Vendor>"] = "Frixee Messingkipper <Arenaverkäufer>";
	AL["Meminnie <Arena Vendor>"] = "Meminnie <Arenaverkäufer>";
	
	-- The Ring of Trials
	AL["Kelara <Keeper of Sha'tari Heirlooms>"] = "Kelara <Bewahrerin des Erbes der Sha'tari>";
	AL["Grikkin Copperspring <Arena Vendor>"] = "Grikkin Kupferspule <Arenaverkäufer>";
	
	-- The Ring of Blood
	AL["Mogor <Hero of the Warmaul>"] = "Mogor <Held der Totschläger>"; -- 18069
	AL["Gurgthock"] = "Gurgthock"; -- 18471	
	
	-- The Rumble Cage
	AL["Dr. Dealwell"] = "Dr. Haudenlukas";
	AL["Katrina Turner"] = "Katrina Turner";
	AL["Vixton Pinchwhistle <Legacy Arena Armor>"] = "Vixton Quetschpfeife <Überholte Arenarüstungen>";
	AL["Blazzek the Biter <Legacy Arena Weapons>"] = "Blazzek der Beißer <Überholte Arenawaffen>";
	AL["Evee Copperspring <Arena Vendor>"] = "Ivi Kupferspule <Arenaverkäufer>";
	AL["Ecton Brasstumbler <Arena Vendor>"] = "Ecton Messingkipper <Arenaverkäufer>";
	
	-- Dalaran Sewers
	AL["Xazi Smolderpipe <Arena Vendor>"] = "Xazi Rauchpfeife <Arenaverkäuferin>";
	AL["Zom Bocom <Apprentice Arena Vendor>"] = "Zom Bocom <Arenaverkäuferlehrling>";
	AL["Nargle Lashcord <Veteran Arena Vendor>"] = "Nargel Peitschleine <Arenaverkäuferveteran>";
	AL["Trapjaw Rix <Exceptional Arena Weaponry>"] = "Eisenfang Rix <Außergewöhnliche Arenawaffen>";

	-- The Crucible of Carnage
	AL["Gurgthock <Fight Promoter>"] = "Gurgthock <Kampfveranstalter>";
	AL["Wodin the Troll-Servant"] = "Wodin der Trolldiener";

	-- Valhalas
	AL["Geirrvif"] = "Geirrvif";
	AL["Gjonner the Merciless"] = "Gjonner der Erbarmungslose";

	-- Amphitheater of Anguish
	AL["Yggdras"] = "Yggdras";
	AL["Stinkbeard"] = "Stinkebart";
	AL["Elemental Lord"] = "Elementarfürsten";
	AL["Az'Barin, Prince of the Gust"] = "Az'Barin, Prinz der Böe";
	AL["Duke Singen <The New Hotness>"] = "Herzog Singen <Neu und Heiß>";
	AL["Erathius, King of Dirt"] = "Erathius, König des Schmutzes";
	AL["Gargoral the Water Lord"] = "Gargoral";
	AL["Orinoko Tuskbreaker"] = "Orinoko Hauerbrecher";
	AL["Korrak the Bloodrager <Champion of the Winterax>"] = "Korrak der Blutrünstige <Held der Winterax>";
	AL["Vladof the Butcher"] = "Vladof der Metzger";
end
