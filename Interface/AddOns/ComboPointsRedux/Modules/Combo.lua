--[[
Author: Starinnia
CPR is a combo points display addon based on Funkydude's BasicComboPoints
Combo.lua - A module for tracking combo points
$Date: 2011-03-20 01:46:30 +0000 (Sun, 20 Mar 2011) $
$Revision: 230 $
Project Version: 2.2.4
contact: codemaster2010 AT gmail DOT com

Copyright (c) 2007-2011 Michael J. Murray aka Lyte of Lothar(US)
All rights reserved unless otherwise explicitly stated.
]]

local cpr = LibStub("AceAddon-3.0"):GetAddon("ComboPointsRedux")
local modName = "Combo Points"
local mod = cpr:NewModule(modName)

function mod:OnInitialize()
	self.abbrev = "CP"
	self.MAX_POINTS = 5
	self.displayName = COMBAT_TEXT_SHOW_COMBO_POINTS_TEXT
	self.events = { "UNIT_COMBO_POINTS", ["PLAYER_TARGET_CHANGED"] = "UNIT_COMBO_POINTS" }
end

local oldPoints = 0
function mod:UNIT_COMBO_POINTS()
	local points = GetComboPoints(UnitHasVehicleUI("player") and "vehicle" or "player", "target")
	local r, g, b = cpr:GetColorByPoints(modName, points)
	
	if points > 0 then
		if self.graphics then
			for i = points, 1, -1 do
				self.graphics.points[i].icon:SetVertexColor(r, g, b)
				self.graphics.points[i]:Show()
			end
		end
		
		--should prevent spamming issues if a generator ability is used
		--when the player is at 5 points and has the threshold at 5
		if oldPoints ~= points then
			oldPoints = points
			cpr:DoFlash(modName, points)
		end
	else
		if self.graphics then
			for i = 1, self.MAX_POINTS do
				self.graphics.points[i]:Hide()
			end
		end
		points = ""
		oldPoints = 0
	end
	if self.text then self.text:SetNumPoints(points) end
end
