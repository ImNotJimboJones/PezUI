local tool
tool = BrokerToolBox:NewTool("reputation",{
	author="Sanori",									--author of this tool
	version="1.1 (10. Sep. 2012)",				--tool version
	defaultON=false,									--default active?
	db = {
		type = 1,
	},
	events={												--Game Events
		["UPDATE_FACTION"] = function(self)
			local name, standing, min, max, value = GetWatchedFactionInfo()  --(returns nil 0 0 0 0 if no watched faction)
			if (not name or not _G["FACTION_STANDING_LABEL"..standing]) then
				self.broker.text=self.name
				self.factionName=nil
				self.standingName=nil
			else
				self.factionName = name
				self.standingName = _G["FACTION_STANDING_LABEL"..standing]
				self.standingColor = FACTION_BAR_COLORS[standing]
				self.curVal = value-min
				self.MaxVal = max-min
				if self.db.type==1 then
					self.broker.text = format("|cff%02x%02x%02x%s/%s (%.1f%s)|r",self.standingColor.r*255,self.standingColor.g*255,self.standingColor.b*255,self.curVal,self.MaxVal,(self.curVal/self.MaxVal)*100,"%")
				elseif self.db.type==2 then
					self.broker.text = format("|cff%02x%02x%02x%s/%s|r",self.standingColor.r*255,self.standingColor.g*255,self.standingColor.b*255,self.curVal,self.MaxVal)
				else
					self.broker.text = format("|cff%02x%02x%02x%.1f%s|r",self.standingColor.r*255,self.standingColor.g*255,self.standingColor.b*255,(self.curVal/self.MaxVal)*100,"%")
				end
			end
		end,
		["PLAYER_ENTERING_WORLD"] = function(self) self.events.UPDATE_FACTION(self) end,
	},
	broker = {											--Broker
		type = "data source",
		text = "N/A",
		icon = "Interface\\Icons\\INV_Banner_02",
		OnTooltipShow = function()
			if tool.factionName then
				GameTooltip:AddDoubleLine(tool.factionName,tool.standingName,nil,nil,nil,tool.standingColor.r,tool.standingColor.g,tool.standingColor.b)
				GameTooltip:AddDoubleLine(tool.curVal.."/"..tool.MaxVal,format("%.1f%s",(tool.curVal/tool.MaxVal)*100,"%"),1,1,1,1,1,1)
			end
			name, description, standing, barMin, barMax, barValue, _, _, _, _, _, _, _, repToCap, weeklyCap = GetGuildFactionInfo()
			if name then
				local standingName=_G["FACTION_STANDING_LABEL"..standing]
				local standingColor = FACTION_BAR_COLORS[standing]
				local curVal = barValue-barMin
				local MaxVal = barMax-barMin
				if tool.factionName then GameTooltip:AddLine(" ") end
				GameTooltip:AddDoubleLine(name,standingName,nil,nil,nil,standingColor.r,standingColor.g,standingColor.b)
				GameTooltip:AddDoubleLine(GUILD_REPUTATION..": "..curVal.."/"..MaxVal,format("%.1f%s",(curVal/MaxVal)*100,"%"),1,1,1,1,1,1)
				if weeklyCap and weeklyCap>0 then
					curVal=weeklyCap-repToCap
					GameTooltip:AddDoubleLine(tool:L("thisweek")..": "..curVal.."/"..weeklyCap,format("%.1f%s",(curVal/weeklyCap)*100,"%"),1,1,1,1,1,1)
				end
			end
			if (tool.factionName or name) then GameTooltip:AddLine(" ") end
			GameTooltip:AddLine(tool:L("leftclick"))
			GameTooltip:AddLine(tool:L("rightclick"))
		end,
		OnClick = function(self, button)
			if button == 'RightButton' then
				GameTooltip:Hide()
				tool.menu:Open(self, 'children', function(level, value)
					tool.menu:AddTitle(tool:L("format"))
					tool.menu:AddSelection(tool.db.type, function(val) tool.db.type=val; tool.events.UPDATE_FACTION(tool) end, {
						["<1>"..tool:L("value_percent")] = 1,
						["<2>"..tool:L("value")] = 2,
						["<3>"..tool:L("percent")] = 3,
					})
				end)
				return
			end
			ToggleCharacter('ReputationFrame')
		end,
	},
})