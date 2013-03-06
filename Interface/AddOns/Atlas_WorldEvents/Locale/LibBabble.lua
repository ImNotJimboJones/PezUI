-- $Id: LibBabble.lua 52 2013-03-05 16:56:43Z arith $
--[[

	Atlas World Events, a World of Warcraft map browser for world events
	Copyright 2011 ~ 2013 Arith Hsu

	This file is a plugin of Atlas.

	Atlas World Events is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas World Events is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

--[[
Atlas_GetLocaleLibBabble(typ)
Get english translations for non translated things. (Combines located and english table)
Only useable with LibBabble
]]
function Atlas_GetLocaleLibBabble(typ)

	local rettab = {};
	local tab = LibStub(typ):GetBaseLookupTable();
	local loctab = LibStub(typ):GetUnstrictLookupTable();
	for k,v in pairs(loctab) do
		rettab[k] = v;
	end
	for k,v in pairs(tab) do
		if not rettab[k] then
			rettab[k] = v;
		end
	end
	return rettab;
end