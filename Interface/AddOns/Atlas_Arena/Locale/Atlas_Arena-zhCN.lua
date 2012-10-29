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
local AL = AceLocale:NewLocale("Atlas_Arena", "zhCN", false);

if AL then

	--Common
	AL["Arena Maps"] = "竞技场地图";
	AL["Quests"] = "任务";

	-- Gurubashi Arena
	AL["Short John Mithril"] = "小个子约翰·米斯瑞尔";
	AL["Stone Guard Towhide"] = "石头守卫韧皮";

	-- Circle of Blood Arena
	AL["Frixee Brasstumbler <Arena Vendor>"] = "弗里克希·布拉斯塔 <竞技场商人>";
	AL["Meminnie <Arena Vendor>"] = "梅米尼 <竞技场商人>";
	
	-- The Ring of Trials
	AL["Kelara <Keeper of Sha'tari Heirlooms>"] = "克尔拉兰 <沙塔尔宝物管理者>";
	AL["Grikkin Copperspring <Arena Vendor>"] = "格里金·考伯斯宾 <竞技场商人>";
	
	-- The Ring of Blood
	AL["Mogor <Hero of the Warmaul>"] = "穆戈尔 <战槌英雄>"; -- 18069
	AL["Gurgthock"] = "古尔戈索克"; -- 18471	
	
	-- The Rumble Cage
	AL["Dr. Dealwell"] = "狄奥维奥博士";
	AL["Katrina Turner"] = "卡崔娜·特纳尔 ";
	AL["Vixton Pinchwhistle <Legacy Arena Armor>"] = "维克斯顿 <优质竞技场护甲>";
	AL["Blazzek the Biter <Legacy Arena Weapons>"] = "骗子布拉兹克 <优质竞技场装备>";
	AL["Evee Copperspring <Arena Vendor>"] = "伊维·考伯斯宾 <竞技场商人>";
	AL["Ecton Brasstumbler <Arena Vendor>"] = "埃克顿·布拉斯塔 <竞技场商人>";
	
	-- Dalaran Sewers
	AL["Xazi Smolderpipe <Arena Vendor>"] = "夏尔兹·斯莫德普 <竞技场商人>";
	AL["Zom Bocom <Apprentice Arena Vendor>"] = "佐姆·波克  <见习竞技场商人>";
	AL["Nargle Lashcord <Veteran Arena Vendor>"] = "纳格尔·拉斯克德 <精锐竞技场商人>";
	AL["Trapjaw Rix <Exceptional Arena Weaponry>"] = "利齿里克斯 <优质竞技场装备>";

	-- The Crucible of Carnage
	AL["Gurgthock <Fight Promoter>"] = "古尔戈索克"; -- 46935
	AL["Wodin the Troll-Servant"] = "巨魔仆从伍迪"; -- 46936

	-- Valhalas
	AL["Geirrvif"] = "基尔莉芙"; -- 31135
	AL["Gjonner the Merciless"] = "残忍的亚纳尔"; -- 31154
	
	-- Amphitheater of Anguish
	AL["Yggdras"] = "伊戈达斯";
	AL["Stinkbeard"] = "恶臭之须";
	AL["Elemental Lord"] = "元素领主";
	AL["Az'Barin, Prince of the Gust"] = "狂风王子阿兹巴林";
	AL["Duke Singen <The New Hotness>"] = "辛格恩公爵";
	AL["Erathius, King of Dirt"] = "泥土之王伊拉修斯";
	AL["Gargoral the Water Lord"] = "水之领主加格拉尔";
	AL["Orinoko Tuskbreaker"] = "奥里努克·碎牙";
	AL["Korrak the Bloodrager <Champion of the Winterax>"] = "血怒者科尔拉克";
	AL["Vladof the Butcher"] = "屠夫乌拉多弗";
end
