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
local AL = AceLocale:NewLocale("Atlas_Arena", "koKR", false);

if AL then

	--Common
	AL["Arena Maps"] = "Arena Maps";
	AL["Quests"] = "Quests";
	
	-- Gurubashi Arena
	AL["Short John Mithril"] = "땅딸보 존 미스릴";
	AL["Stone Guard Towhide"] = "Stone Guard Towhide";

	-- Circle of Blood Arena
	AL["Frixee Brasstumbler <Arena Vendor>"] = "프릭시 브래스텀블러 <투기장 상인>";
	AL["Meminnie <Arena Vendor>"] = "메미니 <투기장 상인>";
	
	-- The Ring of Trials
	AL["Kelara <Keeper of Sha'tari Heirlooms>"] = "켈라라 <샤타리 가보의 수호자>";
	AL["Grikkin Copperspring <Arena Vendor>"] = "그리킨 코퍼스프링 <투기장 상인>";
	
	-- The Ring of Blood
	AL["Mogor <Hero of the Warmaul>"] = "Mogor <Hero of the Warmaul>"; -- 18069
	AL["Gurgthock"] = "Gurgthock"; -- 18471	
	
	-- The Rumble Cage
	AL["Dr. Dealwell"] = "Dr. Dealwell";
	AL["Katrina Turner"] = "Katrina Turner";
	AL["Vixton Pinchwhistle <Legacy Arena Armor>"] = "빅스톤 핀치휘슬";
	AL["Blazzek the Biter <Legacy Arena Weapons>"] = "Blazzek the Biter <Legacy Arena Weapons>";
	AL["Evee Copperspring <Arena Vendor>"] = "에비 코퍼스프링 <투기장 상인>";
	AL["Ecton Brasstumbler <Arena Vendor>"] = "엑튼 브래스텀블러 <투기장 상인>";

	-- Dalaran Sewers
	AL["Xazi Smolderpipe <Arena Vendor>"] = "자즈 스몰더파이프 <투기장 상인>";
	AL["Zom Bocom <Apprentice Arena Vendor>"] = "좀 보콤 <투기장 상인>";
	AL["Nargle Lashcord <Veteran Arena Vendor>"] = "나르글 래쉬코드 <전문 투기장 상인>";
	AL["Trapjaw Rix <Exceptional Arena Weaponry>"] = "트랩조 릭스 <특급 투기장 무기 상인>";

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