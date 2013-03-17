local tool
tool = BrokerToolBox:NewTool("location",{
	--author="Sanori",
	version="1.1 (10. Sep. 2012)",
	defaultON=true,
	db={
		showsubzone=true,
		showcords=true,
		accuracy="0",
	},
	events={
		["ZONE_CHANGED"] = function(self) self:Update() end,
		["ZONE_CHANGED_INDOORS"] = function(self) self:Update() end,
		["ZONE_CHANGED_NEW_AREA"] = function(self) self:Update() end,
		["PLAYER_ENTERING_WORLD"] = function(self) self:Update() end,
		--["WORLD_MAP_UPDATE"] = function(self) SetMapToCurrentZone(); self:Update() end,
	},
	OnUpdate = function(self, elapsed)
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed
		if (self.TimeSinceLastUpdate > 0.25) then
			if self.db.showcords then
				local x, y = GetPlayerMapPosition("player")
				if (x==0 and y==0) then
					self.broker.text = self.text.." (?, ?)"
				else
					self.broker.text = format("%s (%."..self.db.accuracy.."f, %."..self.db.accuracy.."f)",self.text,x*100,y*100)
				end
			else
				self.broker.text = self.text
			end
			self.TimeSinceLastUpdate = 0
		end
	end,
	broker = {
		type = "data source",
		text = "???",
		icon = "Interface\\Icons\\INV_Misc_Map07.png",
		OnClick = function(self, button)
			if button=="RightButton" then
				GameTooltip:Hide()
				tool.menu:Open(self, 'children', function(level, value)
					local val
					if tool.db.accuracy=="1" then
						val=true
					end
					tool.menu:AddToggle(tool:L("showsubzone"), tool.db.showsubzone, function(var)
						tool.db.showsubzone=var
						tool:Update()
					end)
					tool.menu:AddToggle(tool:L("showcords"), tool.db.showcords, function(var) tool.db.showcords=var end)
					tool.menu:AddToggle(tool:L("highaccuracy"), val, function(var) if var then tool.db.accuracy="1" else tool.db.accuracy="0" end end)
				end)
				return
			end
			ToggleFrame(WorldMapFrame)
		end,
		OnTooltipShow = function(self)
			GameTooltip:AddLine(tool:L("leftclick"))
			GameTooltip:AddLine(tool:L("rightclick"))
		end,
	},
	colors = {
		arena = "ff0000",
		friendly = "00ff00",
		contested = "ffb300", --Tol Barad
		hostile = "ff0000",
		sanctuary = "69ccf0",
		combat = "ff0000",
		["nil"] = "ffff00",	--default yellow
	},
	Update = function(self)
		SetMapToCurrentZone()
		local zone = GetRealZoneText()
		if not zone or zone=="" then 
			self.text = "???"
			return
		end
		local subzone = GetSubZoneText()
		local pvpType = GetZonePVPInfo()
		--MinimapZoneText:GetTextColor
		local color = self.colors["nil"]
		if pvpType and self.colors[pvpType] then
			color = self.colors[pvpType]
		end
		if (subzone and subzone~="" and self.db.showsubzone) then
			self.text = format("|cff%s%s:|r %s",color,zone,subzone)
		else
			self.text = format("|cff%s%s|r",color,zone)
		end
	end,
	PreInit = function(self)
		self.text = "???"
		self.TimeSinceLastUpdate = 0
	end,
})