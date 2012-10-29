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
local AL = AceLocale:NewLocale("Atlas_Arena", "zhTW", false);

if AL then

	--Common
	AL["Arena Maps"] = "競技場地圖";
	AL["Quests"] = "任務";
	
	-- Gurubashi Arena
	AL["Short John Mithril"] = "小個子約翰·米斯瑞爾";
	AL["Stone Guard Towhide"] = "石衛士曳革";

	-- Circle of Blood Arena
	AL["Frixee Brasstumbler <Arena Vendor>"] = "佛利基·銅杯 <競技場商人>";
	AL["Meminnie <Arena Vendor>"] = "蜜米妮 <競技場商人>";
	
	-- The Ring of Trials
	AL["Kelara <Keeper of Sha'tari Heirlooms>"] = "奇拉娜 <薩塔家傳物品保管人>";
	AL["Grikkin Copperspring <Arena Vendor>"] = "格利金·銅簧 <競技場商人>";
	
	-- The Ring of Blood
	AL["Mogor <Hero of the Warmaul>"] = "莫古 <戰槌英雄>"; -- 18069
	AL["Gurgthock"] = "葛爾薩克"; -- 18471	
	
	-- The Rumble Cage
	AL["Dr. Dealwell"] = "幹得好博士";
	AL["Katrina Turner"] = "卡崔娜·特呢";
	AL["Vixton Pinchwhistle <Legacy Arena Armor>"] = "維斯頓·急嘯 <傳奇競技場護甲>";
	AL["Blazzek the Biter <Legacy Arena Weapons>"] = "『詐欺者』布雷茲札克 <傳奇競技場武器>";
	AL["Evee Copperspring <Arena Vendor>"] = "伊薇·銅簧 <競技場商人>";
	AL["Ecton Brasstumbler <Arena Vendor>"] = "艾克頓·銅杯 <競技場商人>";

	-- Dalaran Sewers
	AL["Xazi Smolderpipe <Arena Vendor>"] = "札奇·燻管 <競技場商人>";
	AL["Zom Bocom <Apprentice Arena Vendor>"] = "扎姆·巴康 <見習競技場商人>";
	AL["Nargle Lashcord <Veteran Arena Vendor>"] = "納高·鞭索 <老練競技場商人>";
	AL["Trapjaw Rix <Exceptional Arena Weaponry>"] = "陷阱鉗瑞克斯 <卓越競技場武器商>";

	-- The Crucible of Carnage
	AL["Gurgthock <Fight Promoter>"] = "葛爾薩克 <戰鬥發起人>"; -- 46935
	AL["Wodin the Troll-Servant"] = "『食人妖僕從』烏丁"; -- 46936

	-- Valhalas
	AL["Geirrvif"] = "蓋爾維孚"; -- 31135
	AL["Gjonner the Merciless"] = "『殘酷』吉雍納"; -- 31154
	
	-- Amphitheater of Anguish
	AL["Yggdras"] = "伊格卓斯";
	AL["Stinkbeard"] = "臭鬚";
	AL["Elemental Lord"] = "元素領主";
	AL["Az'Barin, Prince of the Gust"] = "狂風王子，阿茲霸令";
	AL["Duke Singen <The New Hotness>"] = "辛桀公爵 <新焰>";
	AL["Erathius, King of Dirt"] = "塵泥之王，伊拉修斯";
	AL["Gargoral the Water Lord"] = "『水領主』賈苟洛";
	AL["Orinoko Tuskbreaker"] = "歐令諾寇·碎牙者";
	AL["Korrak the Bloodrager <Champion of the Winterax>"] = "『血怒者』科爾拉克 <冰斧勇士>";
	AL["Vladof the Butcher"] = "『屠夫』伏雷多弗";
end