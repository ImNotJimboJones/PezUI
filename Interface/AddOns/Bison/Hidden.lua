--[[
Bison - a framework for free positioning of buffs.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to:
	
Free Software Foundation, I.,
51 Franklin Street, Fifth Floor,
Boston, MA  02110-1301, USA.
--]]

local MAJOR = "hidden"

local Addon    = LibStub( "AceAddon-3.0"):GetAddon( "Bison")
local L        = LibStub( "AceLocale-3.0"):GetLocale( "Bison")
local AceGUI   = LibStub( "AceGUI-3.0")

local PANE_BACKDROP  = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 },
}
local MAX_BUTTON = 32

local Module = Addon:NewBarModule( MAJOR, "AceHook-3.0")
Module.filter  = "HELPFUL"
Module.color   = { r=0.4, g=0.4, b=0.2 }
Module.hideOnLock = true
Module.proName = "hidden"

local args = {
	option = { 
		type = "group", order = 10, name = L.OptionName, inline = true, 
		args = {
			show     = { type = "toggle", order = 10, name = L.ShowName,     desc = L.ShowDesc },
			sort     = { type = "select", order = 40, name = L.SortName,     desc = L.SortDesc, get = "GetSortType", set = "SetSortType", values = "GetSortDesc" },
		} 
	},
	layout = { 
		type = "group", order = 20, name = L.BarName, inline = true, 
		args = {
			horizontal = { type = "toggle", order = 10, name = L.HorizontalName, desc = L.HorizontalDesc },
			number     = { type = "range",  order = 20, name = L.NumberName,     desc = L.NumberDesc,   set = "SetNumber",   min = 1,    max = MAX_BUTTON, step = 1 },
			scale      = { type = "range",  order = 40, name = L.ScaleName,      desc = L.ScaleDesc,    set = "SetScale",    min = 0.01, max = 2,          step = 0.01, isPercent = true },
			cols       = { type = "range",  order = 50, name = L.ColsName,       desc = L.ColsDesc,     set = "SetCols",     min = 1,    max = MAX_BUTTON, step = 1 },
			xPadding   = { type = "range",  order = 60, name = L.XPaddingName,   desc = L.XPaddingDesc, set = "SetXPadding", min = -20,  max = 20,         step = 1 },
			rows       = { type = "range",  order = 70, name = L.RowsName,       desc = L.RowsDesc,     set = "SetRows",     min = 1,    max = MAX_BUTTON, step = 1 },
			yPadding   = { type = "range",  order = 80, name = L.YPaddingName,   desc = L.YPaddingDesc, set = "SetYPadding", min = -50,  max = 50,         step = 1 },
		} 
	}
}
local blizzOptions = {
	type = "group", order = 60, name = L.DescHidden, handler = Module, get = "GetProperty", set = "SetProperty", args = args
}
local dialogOptions = {
	type = "group", order = 20, name = L.BarHidden, handler = Module, get = "GetProperty", set = "SetProperty", args = args,
	plugins = {
		p1 = { 
			descr = { type = "description", order = 5, name = L.DescHidden, fontSize = "large" }
		}
	}
}

------------------------------------------------------------------------------------
-- Main
------------------------------------------------------------------------------------
function Module:OnModuleInitialize()
	self:RegisterOptions( blizzOptions, L.BarHidden)
	self:CloneAura( "buff")
end

function Module:OnModuleEnable()
	self:SetVisible( false)
end

function Module:GetOptionTable()
	return dialogOptions
end

function Module:UpdateAnchors( sort)
	self:MoveTo()
end

function Module:UpdateBuffAnchors()
	self:MoveTo()
end

function Module:MoveTo()
--	Addon:Debug( self, ":MoveTo")
	if ConsolidatedBuffs:IsVisible() then
		self:SortAura()
		local count = 1
		local last, first
		for i,child in pairs( self.group.children) do
			local a = self.aura[i]
			local buff = _G["BuffButton"..a.id]
			if buff and a.consolidate then
				buff:ClearAllPoints()
				if last and first then
					buff:SetPoint( "TOPRIGHT", last, "TOPLEFT", -5, 0 )
				elseif first then
					buff:SetPoint( "TOPRIGHT", first, "BOTTOMRIGHT", 0, -BUFF_ROW_SPACING)
					first = buff
				else
					buff:SetPoint( "TOPRIGHT", ConsolidatedBuffsContainer, "TOPRIGHT", 0, 0)
					first = buff
				end
				last = buff;
				count = count + 1
				if count > BUFFS_PER_ROW then
					count = 1
					last = nil
				end
			end
		end
	end
end

function Module:AdditionalSort( orig)
	return function( a, b) 
		local consA = a.consolidate or false
		local consB = b.consolidate or false
		if consA == consB then
			return orig( a, b)
		end
		return consA
	end
end
