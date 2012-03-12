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

local MAJOR = "prog"

local Addon  = LibStub( "AceAddon-3.0"):GetAddon( "Bison")
local L      = LibStub( "AceLocale-3.0"):GetLocale( "Bison")
local AceGUI = LibStub( "AceGUI-3.0")

local NOTHING = {}
local UPDATE_TIME = 0.2
local MAX_BUTTON  = 16
local PROGTABLES = {
	["DEATHKNIGHT"] = {
		[51789] = true, --Blade Barrier Rank 1
		[64855] = true, --Blade Barrier Rank 2
		[64856] = true, --Blade Barrier Rank 3
		[81141] = true, --Crimson Scourge
		[55741] = true, --Desecration Rank 1
		[68766] = true, --Desecration Rank 2
		[51124] = true, --Killing Machine
		[81331] = true, --Might of the Frozen Wastes
		[59052] = true, --Freezing Fog
		[50421] = true, --Scent of Blood
		[91342] = true, --Shadow Infusion (max 5)
		[81340] = true, --Sudden Doom
	},
	["DRUID"] = {
		[16886] = true, --Nature"s Grace
		[22842] = true, --Frenzied Regen
		[48517] = true, --Eclipse (Solar)
		[48518] = true, --Eclipse (Lunar)
		[61336] = true, --Survival Instincts
		[69369] = true, --Predator"s Swiftness
		
		[60433] = true, --Earth and Moon
		[81006] = true, --Lunar Shower Rank 1
		[81191] = true, --Lunar Shower Rank 2
		[81192] = true, --Lunar Shower Rank 3
		[48391] = true, --Owlkin Frenzy
		[93400] = true, --Shooting Stars
		[97547] = true, --Solar Beam
		[50286] = true, --Starfall
		[61391] = true, --Typhoon
		[80863] = true, --Blood in the Water
		[45334] = true, --Feral Charge Effect
		[50259] = true, --Dazed
		[80861] = true, --Fury Swipes
		[58179] = true, --Infected Wounds Rank 1
		[58180] = true, --Infected Wounds Rank 2
		[57893] = true, --Natural Reaction Rank 1
		[59071] = true, --Natural Reaction Rank 2
		[16958] = true, --Primal Fury Rank 1
		[16961] = true, --Primal Fury Rank 2
		[16952] = true, --Blood Frenzy
		[81262] = true, --Efflorescence
		[81093] = true, --Fury of Stormrage
		[16870] = true, --Clearcasting
	},
	["HUNTER"] = {
		[ 3045] = true, --Rapid Fire
		[35098] = true, --Rapid Killing Rank 1
		[35099] = true, --Rapid Killing Rank 2
		[53220] = true, --Improved Steady Shot
		[56453] = true, --Lock and Load
		[64418] = true, --Sniper Training Rank 1
		[64419] = true, --Sniper Training Rank 2
		[64420] = true, --Sniper Training Rank 3
	},
	["MAGE"] = {
		[12042] = true, --Arcane Power
		[12472] = true, --Icy Veins
		[12536] = true, --Clearcasting
		[31643] = true, --Blazing Speed
		[36032] = true, --Arcane Blast
		[44544] = true, --Fingers of Frost
		[48108] = true, --Hot Streak
		[54741] = true, --Firestarter
		[57761] = true, --Brain Freeze
		[64343] = true, --Impact
	},
	["PALADIN"] = {
		[20050] = true, --Schuldspruch Rank 1 (Heilig)
		[20052] = true, --Schuldspruch Rank 2 (Heilig)
		[20053] = true, --Schuldspruch Rank 3 (Heilig)
		[20178] = true, --Abrechnung (Schutz)
		[20424] = true, --Siegel des Befehls (Vergelter)
		[26017] = true, --Rechtschaffene Schw�chung (Schutz)
--		[53651] = true, --Glaubensflamme (Heilig)
		[53655] = true, --Richturteile des Reinen Rank 1 (Heilig)
		[53656] = true, --Richturteile des Reinen Rank 2 (Heilig)
		[53657] = true, --Richturteile des Reinen Rank 3 (Heilig)
		[53672] = true, --Lichtenergie Rank 1 (Heilig)
		[54149] = true, --Lichtenergie Rank 2 (Heilig)
		[57319] = true, --Refugium Rank 1 (Schutz)
		[59578] = true, --Die Kunst des Krieges (Vergelter)
		[84626] = true, --Refugium Rank 2 (Schutz)
		[84627] = true, --Refugium Rank 3 (Schutz)
		[85416] = true, --Oberster Kreuzfahrer (Schutz)
		[85433] = true, --Heilige Pflicht (Schutz)
--		[85509] = true, --Denunzieren (Heilig)
		[87188] = true, --Erleuchtete Richturteile Rank 1 (Heilig)
		[87189] = true, --Erleuchtete Richturteile Rank 2 (Heilig)
		[88819] = true, --Tagesanbruch Rank 1 (Heilig)
		[88821] = true, --Tagesanbruch Rank 2 (Heilig)
		[88852] = true, --Turm der Strahlen (Heilig)
		[89023] = true, --Gesegnetes Leben (Heilig)
		[94286] = true, --Besch�tzer der Unschuldigen (Heilig)
		[96263] = true, --Geheiligter Schild (Vergelter)
	},
	["PRIEST"] = {
		[14751] = true, --Chakra
		[33151] = true, --Surge of Light
		[59887] = true, --Borrowed Time Rank 1
		[59888] = true, --Borrowed Time Rank 2
		[59889] = true, --Borrowed Time Rank 3
		[60062] = true, --Essence of Life
		[63731] = true, --Serendipity Rank 1
		[63735] = true, --Serendipity Rank 2
		[77487] = true, --Shadow Orb
		[81206] = true, --Chakra: Prayer of Healing
		[81207] = true, --Chakra: Renew
		[81208] = true, --Chakra: Heal
		[81292] = true, --Mind Melt
		[81660] = true, --Evangelism Rank 1
		[81661] = true, --Evangelism Rank 2
		[87117] = true, --Dark Evangelism Rank 1
		[87118] = true, --Dark Evangelism Rank 2
		[87152] = true, --Archangel
		[87153] = true, --Dark Archangel
		[88688] = true, --Surge of Light
	},
	["ROGUE"] = {
		[13750] = true, --Adrenline Rush
		[13877] = true, --Blade Flurry
		[14251] = true, --Riposte
		[51713] = true, --Shadow Dance
	},
	["SHAMAN"] = {
		[16246] = true, --Clearcasting
		[53390] = true, --Tital Waves
		[53817] = true, --Maelstrom Weapon
		[55198] = true, --Tidal Force
		[64701] = true, --Elemental Mastery
	},
	["WARLOCK"] = {
		[17941] = true, --Nightfall
		[34936] = true, --Backlash
		[47283] = true, --Empowered Imp
		[47383] = true, --Molten Core Rank 1
		[54274] = true, --Backdraft Rank 1
		[54276] = true, --Backdraft Rank 2
		[54277] = true, --Backdraft Rank 3
		[63165] = true, --Decimation Rank 1
		[63167] = true, --Decimation Rank 2
		[64368] = true, --Eradication Rank 1
		[64370] = true, --Eradication Rank 2
		[64371] = true, --Eradication Rank 3
		[71162] = true, --Molten Core Rank 2
		[71165] = true, --Molten Core Rank 3
	},
	["WARRIOR"] = {
		[12975] = true, --Last Stand
		[46916] = true, --Bloodsurge
		[50227] = true, --Sword and Board
		[52437] = true, --Sudden Death
		[60503] = true, --Taste for Blood
		[87095] = true, --Thunderstruck Rank 1
		[87096] = true, --Thunderstruck Rank 2
	},
}

local Module = Addon:NewBarModule( MAJOR)
Module.filter  = "HELPFUL"
Module.color   = { r=0.2, g=0.4, b=0.2 }
Module.proName = "prog"

local progTable = NOTHING
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
	type = "group", order = 50, name = L.DescProgs, handler = Module, get = "GetProperty", set = "SetProperty", args = args
}
local dialogOptions = {
	type = "group", order = 20, name = L.BarProg, handler = Module, get = "GetProperty", set = "SetProperty", args = args,
	plugins = {
		p1 = { 
			descr = { type = "description", order = 5, name = L.DescProgs, fontSize = "large" }
		}
	}
}

------------------------------------------------------------------------------------
-- Main
------------------------------------------------------------------------------------
function Module:OnModuleInitialize()
	self:RegisterOptions( blizzOptions, L.BarProg)
	self:CloneAura( "buff")
	local _, class = UnitClass( "player")
	progTable = PROGTABLES[class] or NOTHING
end

function Module:GetOptionTable()
	return dialogOptions
end

function Module:UpdateAnchors( sort)
	Addon:Debug( self, ":UpdateAnchors")
	if self.profile.show then
		if sort then
			self:SortAura()
		end
		local spell = self.profile.spell
		for i,a in pairs( self.aura) do
			local buff = self:GetUserBuff( "BuffProgButton", a.id)
			self:UpdateLBF( buff)
			local child = self.group.children[i]
			if child and progTable[a.spellID] then
				self:UpdateUserBuff( buff, a)
				child:SetBuff( buff)
				child:SetSpell( spell and a.spellID)
			elseif child then
				self:HideUserBuff( buff)
				child:SetBuff( nil)
				child:SetSpell( nil)
			else
				self:HideUserBuff( buff)
			end
		end
	end
end

function Module:UpdateBuffAnchors()
	self:UpdateAnchors( true)
end

--function Module:UpdateEnchantAnchors()
--	self:UpdateAnchors()
--end

function Module:MoveTo( offset)
	for i,child in pairs( self.group.children) do
		child:SetBuff( nil)
	end
	for id = 1,#self.aura do
		local buff = self:GetUserBuff( "BuffProgButton", id)
		buff:Hide()
		buff.duration:Hide()
		buff:SetScript( "OnUpdate", nil)
--		buff.timeLeft = nil
	end
end

function Module:AdditionalSort( orig)
	return function( a, b) 
		local progA = a.spellID and progTable[a.spellID] or false
		local progB = b.spellID and progTable[b.spellID] or false
		if progA == progB then
			return orig( a, b)
		end
		return progA
	end
end
