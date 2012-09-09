local tool
tool = BrokerToolBox:NewTool("repair",{
	author="Sanori",									--author of this tool
	version="1.0 (31. Mar. 2011)",				--tool version
	defaultON=true,									--default active?
	db={													--tool database
		autorepair=false,
		autoguildrepair=false,
		autojunksell=false,
		BrokenWarning=false,
		BrokenWarningThreshold=10,
		BrokenWarningSound=false,
	},
	events={												--Game Events
		["UPDATE_INVENTORY_DURABILITY"] = function(self) self:UpdateDurability(true) end,
		["UPDATE_INVENTORY_ALERTS"] = function(self) self:UpdateDurability()end,
		["UNIT_INVENTORY_CHANGED"] = function(self) self:UpdateDurability() end,
		["EQUIPMENT_SWAP_FINISHED"] = function(self) self:UpdateDurability() end,
		["PLAYER_DEAD"] = function(self) self:UpdateDurability(true) end,
		["PLAYER_UNGHOST"] = function(self) self:UpdateDurability(true) end,
		--["MERCHANT_CLOSED"] = 
		["MERCHANT_SHOW"] = function(self)
			--auto junk sell
			if self.db.autojunksell then
				if InRepairMode() then HideRepairCursor() end
				local sellMoney=0
				for i=0, 4 do
					for j=1, GetContainerNumSlots(i) do
						local _, itemCount, _, quality, _ = GetContainerItemInfo(i, j)
						if (quality and (quality==0 or (quality==-1 and strmatch(GetContainerItemLink(i, j),select(4,GetItemQualityColor(0)))))) then
							local item = GetContainerItemLink(i, j)
							local sellPrice = select(11,GetItemInfo(item))
							sellMoney = sellMoney + (sellPrice*itemCount)
							UseContainerItem(i, j)
						end
					end
				end
				if sellMoney>0 then
					DEFAULT_CHAT_FRAME:AddMessage(format(self:L("SellFor"),GetCoinTextureString(sellMoney)),1,1,0)
				end
			end
			--repair
			local repairAllCost, canRepair = GetRepairAllCost()
			if CanMerchantRepair() and canRepair and repairAllCost>0 then
				if (self.db.autoguildrepair and CanGuildBankRepair() and GetGuildBankMoney()>=repairAllCost and (GetGuildBankWithdrawMoney()==-1 or GetGuildBankWithdrawMoney()>=repairAllCost)) then
					RepairAllItems(1)
					DEFAULT_CHAT_FRAME:AddMessage(format(self:L("RepairedFromGuild"),GetCoinTextureString(repairAllCost)),1,1,0)
				elseif (self.db.autorepair and GetMoney()>=repairAllCost) then
					RepairAllItems()
					DEFAULT_CHAT_FRAME:AddMessage(format(self:L("Repaired"),GetCoinTextureString(repairAllCost)),1,1,0)
				end
			end
			--
		end
	},
	Percent = function(self, val, maxval)
		if (type(val)=="number" and type(maxval)=="number") then
			local result = (val/maxval)*100
			return floor(result+0.5)
		end
	end,
	GetDuraColor = function(self, dura)
		local r, g = 1,1
		if dura<=50 then g=dura/50 end
		if dura>=50 then r=(100-dura)/50 end
		return r,g,0
	end,
	UpdateDurability = function(self, warn)
		local durability=100
		for i=1, 18 do
			local help = tool:Percent(GetInventoryItemDurability(i))
			if (help and durability>help) then durability=help end
		end
		local r,g,b = tool:GetDuraColor(durability)
		self.broker.text = format("|cff%02x%02x%02x%s", r*255, g*255, b*255, durability).."%|r"
		if (warn and self.db.BrokenWarning and durability<=self.db.BrokenWarningThreshold) then
			UIErrorsFrame:AddMessage(format(self:L("BrokenWarningMsg"),durability.."%"),1,0,0);
			DEFAULT_CHAT_FRAME:AddMessage(format(self:L("BrokenWarningMsg"),durability.."%"),1,0,0)
			if self.db.BrokenWarningSound then PlaySound("RaidWarning") end
		end
	end,
	GetSwitchState = function(self, var)
		if var==true then
			return "|cff00ff00"..self:L("ON").."|r"
		else
			return "|cffff0000"..self:L("OFF").."|r"
		end
	end,
	broker = {											--Broker
		type = "data source",
		text = "??%",
		icon = "Interface\\Icons\\Trade_BlackSmithing",
		OnTooltipShow=function(self)
			GameTooltip:AddLine(tool:L("durability"))
			local found
			for i=1, 18 do
				local durability = tool:Percent(GetInventoryItemDurability(i))
				if (durability and durability<100) then
					local itemName, _, itemRarity, _, _, _, _, _, _, itemTexture, _ = GetItemInfo(GetInventoryItemID("player",i))
					if itemName then
						found = true
						local r,g,b=GetItemQualityColor(itemRarity)
						GameTooltip:AddDoubleLine(format("|T%s:16:16:0:0|t  %s",itemTexture,itemName),durability.."%",r,g,b,tool:GetDuraColor(durability))
					end
				end
			end
			if not found then
				GameTooltip:AddLine("|cff00ff00"..tool:L("AllItemsGood").."|r",0,1,0)
			end
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(tool:L("BrokenWarning"),tool:GetSwitchState(tool.db.BrokenWarning))
			GameTooltip:AddDoubleLine(tool:L("autojunksell"),tool:GetSwitchState(tool.db.autojunksell))
			GameTooltip:AddDoubleLine(tool:L("autorepair"),tool:GetSwitchState(tool.db.autorepair))
			GameTooltip:AddDoubleLine(tool:L("autoguildrepair"),tool:GetSwitchState(tool.db.autoguildrepair))
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(tool:L("click"))
		end,
		OnClick=function(self)
			GameTooltip:Hide()
			tool.menu:Open(self, 'children', function(level, value)
				tool.menu:AddToggle(tool:L("BrokenWarning"), tool.db.BrokenWarning, function(val) tool.db.BrokenWarning=val end)
				tool.menu:AddSlider("  "..format(tool:L("BrokenWarningThreshold"),tool.db.BrokenWarningThreshold.."%"), tool.db.BrokenWarningThreshold, 0, 40, 1, function(val) tool.db.BrokenWarningThreshold=val end, nil, 'disabled', not tool.db.BrokenWarning)
				tool.menu:AddFunc("  "..format(tool:L("BrokenWarningSound"),tool:GetSwitchState(tool.db.BrokenWarningSound)), function() tool.db.BrokenWarningSound = not tool.db.BrokenWarningSound end, nil, nil, nil, 'disabled', not tool.db.BrokenWarning)
				tool.menu:AddToggle(tool:L("autojunksell"), tool.db.autojunksell, function(val) tool.db.autojunksell=val end)
				tool.menu:AddToggle(tool:L("autorepair"), tool.db.autorepair, function(val) tool.db.autorepair=val end)
				tool.menu:AddToggle(tool:L("autoguildrepair"), tool.db.autoguildrepair, function(val) tool.db.autoguildrepair=val end)
			end)
		end,
	},
	PostInit = function(self)
		self:UpdateDurability()
	end,
})