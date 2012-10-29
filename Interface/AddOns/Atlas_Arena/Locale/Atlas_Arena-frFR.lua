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
local AL = AceLocale:NewLocale("Atlas_Arena", "frFR", false);

if AL then

	--Common
	AL["Arena Maps"] = "Arena Maps";
	AL["Quests"] = "Quêtes";
	
	-- Gurubashi Arena
	AL["Short John Mithril"] = "Court John Mithril";
	AL["Stone Guard Towhide"] = "Garde de pierre Chanvrepeau";

	-- Circle of Blood Arena
	AL["Frixee Brasstumbler <Arena Vendor>"] = "Frixee Briquedouille <Vendeuse de l'arène>";
	AL["Meminnie <Arena Vendor>"] = "Miminie <Vendeur de l'arène>";
	
	-- The Ring of Trials
	AL["Kelara <Keeper of Sha'tari Heirlooms>"] = "Kelara <Gardienne des héritages sha'tari>";
	AL["Grikkin Copperspring <Arena Vendor>"] = "Grikkin Cuivressort <Vendeur de l'arène>";
	
	-- The Ring of Blood
	AL["Mogor <Hero of the Warmaul>"] = "Mogor <Héros des Cogneguerre>"; -- 18069
	AL["Gurgthock"] = "Gurgthock"; -- 18471	
	
	-- The Rumble Cage
	AL["Dr. Dealwell"] = "Dr La Négoce";
	AL["Katrina Turner"] = "Katrina Turner";
	AL["Vixton Pinchwhistle <Legacy Arena Armor>"] = "Vixton Sifflepince <Armures d'arène héritage>";
	AL["Blazzek the Biter <Legacy Arena Weapons>"] = "Blazzek le Mordant <Armes d'arène héritage>";
	AL["Evee Copperspring <Arena Vendor>"] = "Evee Cuivressort <Vendeuse de l'arène>";
	AL["Ecton Brasstumbler <Arena Vendor>"] = "Ecton Briquedouille <Vendeur de l'arène>";
	
	-- Dalaran Sewers
	AL["Xazi Smolderpipe <Arena Vendor>"] = "Xazi Fumetuyère <Vendeuse de l'arène>";
	AL["Zom Bocom <Apprentice Arena Vendor>"] = "Zom Bocom <Apprenti vendeur de l'arène>";
	AL["Nargle Lashcord <Veteran Arena Vendor>"] = "Nargle Cinglecorde <Vendeur de l'arène vétéran>";
	AL["Trapjaw Rix <Exceptional Arena Weaponry>"] = "Dentos Rix <Armes d'arène exceptionnelles>";

	-- The Crucible of Carnage
	AL["Gurgthock <Fight Promoter>"] = "Gurgthock <Promoteur de combats>";
	AL["Wodin the Troll-Servant"] = "Wodin le Serviteur-troll";

	-- Valhalas
	AL["Geirrvif"] = "Geirrvif";
	AL["Gjonner the Merciless"] = "Gjonner le Sans-merci";
	
	-- Amphitheater of Anguish
	AL["Yggdras"] = "Yggdras";
	AL["Stinkbeard"] = "Barbapue";
	AL["Elemental Lord"] = "élémentaires";
	AL["Az'Barin, Prince of the Gust"] = "Az'Barin, Prince de la Bourrasque";
	AL["Duke Singen <The New Hotness>"] = "Duc Roussillin <La chaleur nouvelle>";
	AL["Erathius, King of Dirt"] = "Erathius, Roi de Poussière";
	AL["Gargoral the Water Lord"] = "Gargoral le seigneur de l'Eau";
	AL["Orinoko Tuskbreaker"] = "Orinoko Brise-défense";
	AL["Korrak the Bloodrager <Champion of the Winterax>"] = "Korrak le Ragesang <Champion des Haches-d'hiver>";
	AL["Vladof the Butcher"] = "Vladof le Boucher";
end
