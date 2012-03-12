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

local MAJOR = "buff"

local Addon = LibStub( "AceAddon-3.0"):GetAddon( "Bison")
local L     = LibStub( "AceLocale-3.0"):GetLocale( "Bison")

local MAX_BUTTON = 40 -- BUFF_ACTUAL_DISPLAY = 32

local Module = Addon:NewBarModule( MAJOR)
Module.filter  = "HELPFUL"
Module.color   = { r=0.2, g=0.8, b=0.2 }
Module.proName = "buff"

local args = {
	option = { 
		type = "group", order = 10, name = L.OptionName, inline = true, 
		args = {
			show     = { type = "toggle", order = 10, name = L.ShowName,     desc = L.ShowDesc, width = "full" },
			sort     = { type = "select", order = 20, name = L.SortName,     desc = L.SortDesc, get = "GetSortType", set = "SetSortType", values = "GetSortDesc" },
			timer    = { type = "select", order = 30, name = L.TimerName,    desc = L.TimerDesc, values = "GetTimerDesc" },
			flashing = { type = "toggle", order = 40, name = L.FlashingName, desc = L.FlashingDesc },
			spell    = { type = "toggle", order = 50, name = L.SpellName,    desc = L.SpellDesc },
		} 
	},
	layout = { 
		type = "group", order = 20, name = L.BarName, inline = true, 
		args = {
			horizontal = { type = "toggle", order = 10, name = L.HorizontalName, desc = L.HorizontalDesc, width = "full" },
			number     = { type = "range",  order = 30, name = L.NumberName,     desc = L.NumberDesc,   set = "SetNumber",   min = 1,    max = MAX_BUTTON, step = 1 },
			scale      = { type = "range",  order = 40, name = L.ScaleName,      desc = L.ScaleDesc,    set = "SetScale",    min = 0.01, max = 2,          step = 0.01, isPercent = true },
			cols       = { type = "range",  order = 50, name = L.ColsName,       desc = L.ColsDesc,     set = "SetCols",     min = 1,    max = MAX_BUTTON, step = 1 },
			xPadding   = { type = "range",  order = 60, name = L.XPaddingName,   desc = L.XPaddingDesc, set = "SetXPadding", min = -20,  max = 20,         step = 1 },
			rows       = { type = "range",  order = 70, name = L.RowsName,       desc = L.RowsDesc,     set = "SetRows",     min = 1,    max = MAX_BUTTON, step = 1 },
			yPadding   = { type = "range",  order = 80, name = L.YPaddingName,   desc = L.YPaddingDesc, set = "SetYPadding", min = -50,  max = 50,         step = 1 },
		} 
	}
}
local blizzOptions = {
	type = "group", order = 20, name = L.DescBuff, handler = Module, get = "GetProperty", set = "SetProperty", args = args
}
local dialogOptions = {
	type = "group", order = 20, name = L.BarBuff, handler = Module, get = "GetProperty", set = "SetProperty", args = args,
	plugins = {
		p1 = { 
			descr = { type = "description", order = 5, name = L.DescBuff, fontSize = "large" }
		}
	}
}

------------------------------------------------------------------------------------
-- Locale
------------------------------------------------------------------------------------
local function GetBuff( bar, id)
	if id < 1 then
		return ConsolidatedBuffs
	end
	if id <= BUFF_MAX_DISPLAY then
		return _G["BuffButton"..id]
	end
	return bar:GetUserBuff( "BuffUserButton", id)
end

------------------------------------------------------------------------------------
-- Main
------------------------------------------------------------------------------------
function Module:OnModuleInitialize()
	self:RegisterOptions( blizzOptions, L.BarBuff)
	self:CloneAura( "buff")
end

function Module:GetOptionTable()
	return dialogOptions
end

function Module:UpdateAnchors( sort)
	Addon:Debug( self, ":UpdateAnchors")
	if self.profile.show then
		self:SortAura()
		local cons = ConsolidatedBuffs:IsVisible()
		local spell = self.profile.spell
		for i,child in pairs( self.group.children) do
			local a = nil
			if not cons then
				a = self.aura[i]
			elseif i > 1 then
				a = self.aura[i - 1]
			end
			local buff = GetBuff( self, a and a.id or 0)
			self:UpdateLBF( buff)
			local hide = cons and a and a.consolidate
			if hide then
				buff = nil
			elseif a and a.id > BUFF_MAX_DISPLAY then
				if hide then
					self:HideUserBuff( buff)
				else
					self:UpdateUserBuff( buff, a)
				end
			end
			child:SetBuff( buff)
			child:SetSpell( spell and a and a.spellID)
		end
	end
end

function Module:UpdateBuffAnchors()
	self:UpdateAnchors()
end

function Module:MoveTo( offset)
	for i,child in pairs( self.group.children) do
		child:SetBuff( nil)
	end
	local count = 1
	local last, first
	if ConsolidatedBuffs:IsVisible() then
		ConsolidatedBuffs:ClearAllPoints()
		ConsolidatedBuffs:SetPoint( "TOPRIGHT", BuffFrame, "TOPRIGHT", 0, offset)
		count = 2
		last = ConsolidatedBuffs
		first = ConsolidatedBuffs
	end
	for id = 1,BUFF_ACTUAL_DISPLAY do
		local buff = GetBuff( self, id)
		if buff and not buff.consolidated then
			buff:ClearAllPoints()
			if last and first then
				buff:SetPoint( "TOPRIGHT", last, "TOPLEFT", -5, 0 )
			elseif first then
				buff:SetPoint( "TOPRIGHT", first, "BOTTOMRIGHT", 0, -BUFF_ROW_SPACING)
				first = buff
			else
				buff:SetPoint( "TOPRIGHT", BuffFrame, "TOPRIGHT", 0, offset)
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
	for id = BUFF_MAX_DISPLAY+1,#self.aura do
		local buff = GetBuff( self, id)
		buff:Hide()
		buff.duration:Hide()
		buff:SetScript( "OnUpdate", nil)
		buff.timeLeft = nil
	end
end

function Module:AdditionalSort( orig)
	return function( a, b) 
		local cons = ConsolidatedBuffs:IsVisible()
		local consA = cons and a.consolidate or false
		local consB = cons and b.consolidate or false
		if consA == consB then
			return orig( a, b)
		end
		return consB
	end
end
