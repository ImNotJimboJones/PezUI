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
local AL = AceLocale:NewLocale("Atlas_Arena", "esES", false);

if AL then

	--Common
	AL["Arena Maps"] = "Arena Maps";
	AL["Quests"] = "Misiones";
	
	-- Gurubashi Arena
	AL["Short John Mithril"] = "Corto John Mitril";
	AL["Stone Guard Towhide"] = "Guardia de piedra Sirga Oculta";

	-- Circle of Blood Arena
	AL["Frixee Brasstumbler <Arena Vendor>"] = "Frixee Cabriolatón <Vendedora de arena>";
	AL["Meminnie <Arena Vendor>"] = "Meminnie <Vendedora de arena>";
	
	-- The Ring of Trials
	AL["Kelara <Keeper of Sha'tari Heirlooms>"] = "Kelara <Vigilante de reliquias Sha'tari>";
	AL["Grikkin Copperspring <Arena Vendor>"] = "Grikkin Pococobre <Vendedor de arena>";
	
	-- The Ring of Blood
	AL["Mogor <Hero of the Warmaul>"] = "Mogor <Héroe de los Mazo de Guerra>"; -- 18069
	AL["Gurgthock"] = "Gurgthock"; -- 18471	
	
	-- The Rumble Cage
	AL["Dr. Dealwell"] = "Dr. Tratabién";
	AL["Katrina Turner"] = "Katrina Turner";
	AL["Vixton Pinchwhistle <Legacy Arena Armor>"] = "Vixton Silbapellizco <Armadura de arena de legado>";
	AL["Blazzek the Biter <Legacy Arena Weapons>"] = "Blazzek el Dentellada <Armas de arena de legado>";
	AL["Evee Copperspring <Arena Vendor>"] = "Evee Pococobre <Vendedora de arena>";
	AL["Ecton Brasstumbler <Arena Vendor>"] = "Ecton Brasstumbler Ecton Cabriolatón <Vendedor de arena>";
	
	-- Dalaran Sewers
	AL["Xazi Smolderpipe <Arena Vendor>"] = "Xazi Pipa Humillo <Vendedor de arena>";
	AL["Zom Bocom <Apprentice Arena Vendor>"] = "Zom Bocom <Aprendiz de vendedor de arena>";
	AL["Nargle Lashcord <Veteran Arena Vendor>"] = "Nargle Trallacable <Vendedor de arena experto>";
	AL["Trapjaw Rix <Exceptional Arena Weaponry>"] = "Rix Quijatrampa <Armas de combates de arena excepcionales>";

	-- The Crucible of Carnage
	AL["Gurgthock <Fight Promoter>"] = "Gurgthock <Promotor de lucha>";
	AL["Wodin the Troll-Servant"] = "Wodin el sirviente trol";

	-- Valhalas
	AL["Geirrvif"] = "Geirrvif";
	AL["Gjonner the Merciless"] = "Gjonner el Desalmado";
	
	-- Amphitheater of Anguish
	AL["Yggdras"] = "Yggdras";
	AL["Stinkbeard"] = "Barbahedionda";
	AL["Elemental Lord"] = "Elementales";
	AL["Az'Barin, Prince of the Gust"] = "Az'Barin, príncipe de las Ráfagas";
	AL["Duke Singen <The New Hotness>"] = "Duque Singen <La Nueva Fogosidad>";
	AL["Erathius, King of Dirt"] = "Erathius, Rey del barro";
	AL["Gargoral the Water Lord"] = "Gargoral el Señor del agua";
	AL["Orinoko Tuskbreaker"] = "Orinoko Rompecolmillos";
	AL["Korrak the Bloodrager <Champion of the Winterax>"] = "Korrak el Sanguinario <Campeón de los Hacha Invernal>";
	AL["Vladof the Butcher"] = "Vladof el Carnicero";
end
