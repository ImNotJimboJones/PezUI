local tool
tool = BrokerToolBox:NewTool("money",{
	author="Sanori",
	version="1.2 (10. Sep. 2012)",
	defaultON=true,
	db={
		money=0,
		UnitFactionGroup="",
		ignoreOtherFaction=false,
		showtotal=false,
		round=false,
	},
	Round = function(self, money)
		if self.db.round then
			return floor(money/10000+0.5)
		else
			return GetCoinTextureString(money)
		end
	end,
	UpdateMoney = function(self)
		local money = GetMoney()
		if money then
			self.db.money=money
			self.db.UnitFactionGroup = UnitFactionGroup("player")
			if self.db.showtotal then
				local sum=0
				for player,data in BrokerToolBox:pairsByKeys(BrokerToolBoxDB[GetCVar("realmName")]) do
					if (data.tools.money and data.tools.money.money) then
						if (not self.db.ignoreOtherFaction or data.tools.money.UnitFactionGroup==UnitFactionGroup("player")) then
							if(player==UnitName("player")) then data.tools.money.money=self.db.money end	-- The money from the actual character isn't refreshed
							sum = sum + data.tools.money.money
						end
					end
				end
				money = sum
			end
			self.broker.text = self:Round(money)
		end
	end,
	events={											--events
		["CURRENCY_DISPLAY_UPDATE"] = function(self) self:UpdateMoney() end,
		["PLAYER_MONEY"] = function(self) self:UpdateMoney() end,
		["PLAYER_TRADE_MONEY"] = function(self) self:UpdateMoney() end,
		["SEND_MAIL_MONEY_CHANGED"] = function(self) self:UpdateMoney() end,
		["SEND_MAIL_COD_CHANGED"] = function(self) self:UpdateMoney() end,
		["PLAYER_ENTERING_WORLD"] = function(self) self:UpdateMoney() end,
	},
	broker = {
		type = "data source",
		text = GetCoinTextureString(0),
		icon = "Interface\\Icons\\INV_Misc_Coin_02",
		OnClick = function(self, button)
			GameTooltip:Hide()
			tool.menu:Open(self, 'children', function(level, value)
				if level==1 then
					tool.menu:AddToggle(tool:L("showtotal"), tool.db.showtotal, function(var) tool.db.showtotal=var; tool:UpdateMoney() end)
					tool.menu:AddToggle(tool:L("ignoreOtherFaction"), tool.db.ignoreOtherFaction, function(var) tool.db.ignoreOtherFaction=var; tool:UpdateMoney(); end)
					tool.menu:AddToggle(tool:L("round"), tool.db.round, function(var) tool.db.round=var; tool:UpdateMoney(); end)
					tool.menu:AddArrow(DELETE,"X")
				else
					for player,data in pairs(BrokerToolBoxDB[GetCVar("realmName")]) do
						if ((UnitName("player") ~= player) and data.tools.money) then
							tool.menu:AddFunc(player, function()
								BrokerToolBoxDB[GetCVar("realmName")][player].tools.money=nil
							end, nil, true)
						end
					end
				end
			end)
		end,
		OnTooltipShow = function(self)
			local sum = 0
			local gbank = GetGuildBankMoney()
			local g = GetGuildInfo("player")
			local gbankwithdraw = GetGuildBankWithdrawMoney()
			GameTooltip:AddLine(tool:L("mymoney"))
			for player,data in BrokerToolBox:pairsByKeys(BrokerToolBoxDB[GetCVar("realmName")]) do
				if (data.tools.money and data.tools.money.money) then
					if (not tool.db.ignoreOtherFaction or data.tools.money.UnitFactionGroup==UnitFactionGroup("player")) then
						local r,g,b = 1,1,1
						if(player==UnitName("player")) then data.tools.money.money=tool.db.money; r=0; b=0; end
						sum = sum + data.tools.money.money
						local faction = ""
						if (data.tools.money.UnitFactionGroup and data.tools.money.UnitFactionGroup~=UnitFactionGroup("player")) then
							if data.tools.money.UnitFactionGroup=="Alliance" then faction=FACTION_ALLIANCE else faction=FACTION_HORDE end
							faction=" |cff707070("..faction..")|r"
						end
						GameTooltip:AddDoubleLine(player..faction,tool:Round(data.tools.money.money),r,g,b,r,g,b)
					end
				end
			end
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(tool:L("sum"),tool:Round(sum))
			if g and gbank and gbank>=0 then
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(g,tool:Round(gbank))
				if gbankwithdraw then
					if gbankwithdraw==-1 then
						GameTooltip:AddDoubleLine(tool:L("RepairMoney"),tool:L("unlimited"),1,1,1)
					elseif gbankwithdraw>0 then
						GameTooltip:AddDoubleLine(tool:L("RepairMoney"),tool:Round(gbankwithdraw),1,1,1,1,1,1)
					end
				end
			end
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(tool:L("click"))
		end,
	},
	PreInit = function(self)
		self.db.UnitFactionGroup = UnitFactionGroup("player")
	end,
})