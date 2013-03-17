local tool
tool = BrokerToolBox:NewTool("experience",{
	--author="Sanori",
	version="1.2 (10. Sep. 2012)",
	defaultON=false,
	db={
		type = 1,
		ShowGuild = false,
	},
	Update = function(self)
		if (IsInGuild() and GetGuildLevel()<tool.GuildMaxLevel) then
			local CurXP, nextLevelXP = UnitGetGuildXP("player")
			if (CurXP==0 and nextLevelXP==0) then
				QueryGuildXP()
				return
			end
		end
		if (self.db.ShowGuild and IsInGuild()) then
			if GetGuildLevel()>=self.GuildMaxLevel then
				self.broker.text = "|cff00ff00"..self:L("OnMaxLevel").."|r"
				return
			end
			local CurXP, nextLevelXP = UnitGetGuildXP("player")
			local MaxXP = nextLevelXP + CurXP
			if self.db.type==1 then
				self.broker.text = format("|cff00ff00%.0fK/%.0fK (%.1f%s)|r",CurXP/1000,MaxXP/1000,(CurXP/MaxXP)*100,"%")
			elseif self.db.type==2 then
				self.broker.text = format("|cff00ff00%.0fK/%.0fK|r",CurXP/1000,MaxXP/1000)
			else
				self.broker.text = format("|cff00ff00%.1f%s|r",(CurXP/MaxXP)*100,"%")
			end
		else
			self.db.ShowGuild = false
			local CurXP, MaxXP, IsXPDisabled, RestState = UnitXP("player"), UnitXPMax("player"), IsXPUserDisabled(), GetRestState()
			local maxlevel, level = MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()], UnitLevel("player")
			if level >= maxlevel then
				self.broker.text = "|cff00ff00"..self:L("OnMaxLevel").."|r"
			elseif IsXPDisabled then
				self.broker.text = "|cffff0000"..self:L("XPdisabled").."|r"
			else
				local color="ffff00"
				if RestState == 1 then color="00ff00" end
				if self.db.type==1 then
					self.broker.text = format("|cff%s%s/%s (%.1f%s)|r",color,CurXP,MaxXP,(CurXP/MaxXP)*100,"%")
				elseif self.db.type==2 then
					self.broker.text = format("|cff%s%s/%s|r",color,CurXP,MaxXP)
				else
					self.broker.text = format("|cff%s%.1f%s|r",color,(CurXP/MaxXP)*100,"%")
				end
			end
		end
	end,
	events={
		["PLAYER_GUILD_UPDATE"] = function(self) self:Update() end,
		["GUILD_XP_UPDATE"]= function(self) self:Update() end,
		["PLAYER_XP_UPDATE"] = function(self, UnitID) if UnitID=="player" then self:Update() end end,
		["PLAYER_ENTERING_WORLD"] = function(self) self:Update() end,
	},
	broker = {
		type = "data source",
		text = "N/A",
		icon = "Interface\\Icons\\INV_Scroll_03",
		OnTooltipShow = function(self)
			local CurXP, MaxXP, IsXPDisabled, RestState = UnitXP("player"), UnitXPMax("player"), IsXPUserDisabled(), GetRestState()
			local maxlevel, level = MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()], UnitLevel("player")
			GameTooltip:AddDoubleLine(UnitName("player"),tool:L("lvl").." "..level,nil,nil,nil,1,1,1)
			if level < maxlevel then
				if IsXPDisabled then
					GameTooltip:AddLine(tool:L("XPdisabled"),1,0,0)
				else
					GameTooltip:AddDoubleLine(CurXP.."/"..MaxXP,format("%.1f%s",(CurXP/MaxXP)*100,"%"),1,1,1,1,1,1)
					if RestState==1 then
						GameTooltip:AddLine(tool:L("rested"),0,1,0)
					end
				end
			end
			--Pet
			local petName = UnitName("pet")
			local _, englishClass = UnitClass("player")
			if (petName and petName~="" and englishClass=="HUNTER") then
				local PetCurrXP, PetNextXP = GetPetExperience()
				maxlevel, level = MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()], UnitLevel("pet")
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(petName,tool:L("lvl").." "..level,nil,nil,nil,1,1,1)
				if level < maxlevel then
					local PetMaxXP = PetNextXP + PetCurrXP
					GameTooltip:AddDoubleLine(PetCurrXP.."/"..PetMaxXP,format("%.1f%s",(PetCurrXP/PetMaxXP)*100,"%"),1,1,1,1,1,1)
				end
			end
			--Guild
			local guildName, guildRankName, guildRankIndex = GetGuildInfo("player")
			if (IsInGuild() and guildName and guildName~="") then
				local currentXP, nextLevelXP, dailyXP, maxDailyXP, unitWeeklyXP, unitTotalXP, isUncapped = UnitGetGuildXP("player")
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(guildName,tool:L("lvl").." "..GetGuildLevel(),nil,nil,nil,1,1,1)
				if GetGuildLevel()<tool.GuildMaxLevel then
					local maxXP = nextLevelXP + currentXP
					GameTooltip:AddDoubleLine(format("%.0f K/%.0f K",currentXP/1000,maxXP/1000),format("%.1f%s",(currentXP/maxXP)*100,"%"),1,1,1,1,1,1)
					if (not isUncapped and maxDailyXP and maxDailyXP>0) then
						GameTooltip:AddDoubleLine(format("%s: %.0f K/%.0f K",tool:L("today"),dailyXP/1000,maxDailyXP/1000),format("%.1f%s",(dailyXP/maxDailyXP)*100,"%"),1,1,1,1,1,1)
					end
				end
			end
			GameTooltip:AddLine(" \n"..tool:L("click"))
		end,
		OnClick = function(self)
			GameTooltip:Hide()
			tool.menu:Open(self, 'children', function(level, value)
				tool.menu:AddTitle(tool:L("format"))
				tool.menu:AddSelection(tool.db.type, function(val) tool.db.type=val; tool:Update() end, {
					["<1>"..tool:L("value_percent")] = 1,
					["<2>"..tool:L("value")] = 2,
					["<3>"..tool:L("percent")] = 3,
				})
				tool.menu:AddLine()
				local disabled
				if not IsInGuild() then
					tool.db.ShowGuild = false
					disabled=true
				end
				tool.menu:AddToggle(tool:L("ShowGuildXP"), tool.db.ShowGuild, function(val) tool.db.ShowGuild=val; tool:Update() end, nil, 'disabled', disabled)
			end)
		end,
	},
	PostInit = function(self)
		self.TimeSinceLastUpdate = 0
		self.GuildMaxLevel = 25
		self:Update()
	end,
})