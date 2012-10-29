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
local AL = AceLocale:NewLocale("Atlas_Arena", "ruRU", false);

if AL then

	--Common
	AL["Arena Maps"] = "Арена карты";
	AL["Quests"] = "Задания";
	
	-- Gurubashi Arena
	AL["Short John Mithril"] = "Коротышка Джон Мифрил";
	AL["Stone Guard Towhide"] = "Каменный cтраж Кудлатая Шкура";

	-- Circle of Blood Arena
	AL["Frixee Brasstumbler <Arena Vendor>"] = "Фрикси Меднотумблер <Продавец экипировки арены>";
	AL["Meminnie <Arena Vendor>"] = "Мимыни <Продавец экипировки арены>";
	
	-- The Ring of Trials
	AL["Kelara <Keeper of Sha'tari Heirlooms>"] = "Келара <Хранитель наследия Ша'тар>";
	AL["Grikkin Copperspring <Arena Vendor>"] = "Гриккин Медипрыг <Продавец экипировки арены>";
	
	-- The Ring of Blood
	AL["Mogor <Hero of the Warmaul>"] = "Могор <Герой Боевого Молота>"; -- 18069
	AL["Gurgthock"] = "Гаргток"; -- 18471	
	
	-- The Rumble Cage
	AL["Dr. Dealwell"] = "Доктор Верняк";
	AL["Katrina Turner"] = "Катрина Тернер";
	AL["Vixton Pinchwhistle <Legacy Arena Armor>"] = "Викстон Паросвист <Старинная экипировка арены>";
	AL["Blazzek the Biter <Legacy Arena Weapons>"] = "Блаззек Кусака <Старинная оружие арены>";
	AL["Evee Copperspring <Arena Vendor>"] = "Иви Медипрыг <Продавец экипировки арены>"; 
	AL["Ecton Brasstumbler <Arena Vendor>"] = "Эктон Меднотумблер <Продавец экипировки арены>";
	
	-- Dalaran Sewers
	AL["Xazi Smolderpipe <Arena Vendor>"] = "Ксази Смолилка <Продавец экипировки арены>";
	AL["Zom Bocom <Apprentice Arena Vendor>"] = "Зом Боком <Младший продавец экипировки арены>";
	AL["Nargle Lashcord <Veteran Arena Vendor>"] = "Наргл Гибкошнур <Опытный продавец экипировки арены>";
	AL["Trapjaw Rix <Exceptional Arena Weaponry>"] = "Чуднокусь Рикс <Исключительное оружие для арены>";

	-- The Crucible of Carnage
	AL["Gurgthock <Fight Promoter>"] = "Гаргток <Организатор боев>";
	AL["Wodin the Troll-Servant"] = "Тролль-прислужник Водин";

	-- Valhalas
	AL["Geirrvif"] = "Джейрвиф";
	AL["Gjonner the Merciless"] = "Гьоннер Безжалостный";
	
	-- Amphitheater of Anguish
	AL["Yggdras"] = "Иггдрас";
	AL["Stinkbeard"] = "Смрадобород";
	AL["Elemental Lord"] = "Элементалей";
	AL["Az'Barin, Prince of the Gust"] = "Аз'Барин, Принц Мерзости";
	AL["Duke Singen <The New Hotness>"] = "Герцог Синген <Новая сверхновая>";
	AL["Erathius, King of Dirt"] = "Эратиус, Король Грязи";
	AL["Gargoral the Water Lord"] = "Гаргорал Повелитель Воды";
	AL["Orinoko Tuskbreaker"] = "Ориноко Клыколом";
	AL["Korrak the Bloodrager <Champion of the Winterax>"] = "Коррак Кровопуск <Герой Секиры Зимы>";
	AL["Vladof the Butcher"] = "Владоф Мясник";
end
