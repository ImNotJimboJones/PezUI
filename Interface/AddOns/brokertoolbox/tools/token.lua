local tool
tool = BrokerToolBox:NewTool("token",{
	author="Sanori",									--author of this tool
	version="1.4",										--tool version
	defaultON=true,									--default active?
	db={													--tool database
		currency={},
	},
	events={												--Game Events
		["HONOR_CURRENCY_UPDATE"] = function(self) self:Update() end,
		["CURRENCY_DISPLAY_UPDATE"] = function(self) self:Update() end,
	},
	broker = {											--Broker
		type = "data source",
		text = "???",
		icon = "Interface\\Icons\\INV_Misc_QuestionMark",
		OnClick = function(self, button)
			GameTooltip:Hide()
			tool.menu:Open(self, 'children', function(level, value)
				for k,v in pairs(tool.currencyids) do
					for i,id in pairs(v) do
						if i==1 then
							header=id
						else
							if header then
								if found then GameTooltip:AddLine(" ") end
								tool.menu:AddTitle(header)
								header=nil
							end
							local name,_ = GetCurrencyInfo(id)
							if name and name~="" then
								tool.menu:AddToggle(name, tool.db.currency[id], function(var)
									tool.db.currency[id]=nil
									if var then
										tool.db.currency[id]=true
									end
									tool:Update()
								end)
							end
						end
					end
				end
			end)
		end,
		OnTooltipShow = function()
			local header, found
			for k,v in pairs(tool.currencyids) do
				for i,id in pairs(v) do
					if i==1 then
						header=id
					else
						local name, amount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(id)
						if (name and name~="" and texture and texture~="" and isDiscovered) then
							if header then
								if found then GameTooltip:AddLine(" ") end
								GameTooltip:AddLine(header)
								header=nil
							end
							found=true
							name = "|TInterface\\Icons\\"..texture..":12:12:0:0|t "..name
							--Workaround, because sometimes weeklyMax and totalMax have a factor of 100
							if (totalMax>10000) then totalMax=totalMax/100 end
							if (weeklyMax>10000) then weeklyMax=weeklyMax/100 end
							--
							if (totalMax>0) then amount=amount.."/"..totalMax end
							if (weeklyMax>0) then amount=amount.." ("..earnedThisWeek.."/"..weeklyMax..")" end
							if tool.db.currency[id] then
								GameTooltip:AddDoubleLine(name,amount,0,1,0,0,1,0)
							else
								GameTooltip:AddDoubleLine(name,amount,1,1,1,1,1,1)
							end
						end
					end
				end
			end
			if not found then GameTooltip:AddLine(tool:L("notoken")) end
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(tool:L("click"))
		end,
	},
	PreInit = function(self)	--Init Vars
		self.currencyids={
			{self:L("PVE"),396,395},
			{self:L("PVP"),390,392,391},        --Archaeology
			{self:L("PROFESSION"),402,361,61,81--[[,384,385,393,394,397,398,399,400,401]]},
			{OTHER,416,241,515},
		}
		self.defaultxt=self.name
	end,
	Update = function(self)
		self.broker.text = self.defaultxt
		self.broker.icon = "Interface\\Icons\\INV_Misc_QuestionMark"
		for id,_ in BrokerToolBox:pairsByKeys(self.db.currency) do
			local name, amount, texture, _ = GetCurrencyInfo(id)
			if (name and name~="" and texture and texture~="" and amount and type(amount)=="number") then
				if self.broker.text==self.defaultxt then
					self.broker.icon="Interface\\Icons\\"..texture
					self.broker.text=amount
				else
					self.broker.text=self.broker.text.."  |TInterface\\Icons\\"..texture..":16:16:0:0|t"..amount
				end
			end
		end
	end,
	PostInit = function(self)
		self:Update()
	end,
})