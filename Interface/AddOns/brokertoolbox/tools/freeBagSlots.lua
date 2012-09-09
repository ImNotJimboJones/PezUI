local tool
tool = BrokerToolBox:NewTool("freeBagSlots",{
	author="Sanori",
	version="1.1 (10. Sep. 2012)",
	defaultON=false,	
	freeSlotCount=0,
	slotCount=0,
	Update = function(self)
		self.freeSlotCount = 0
		self.slotCount = 0
		for i=0, NUM_BAG_SLOTS do
			self.freeSlotCount = self.freeSlotCount+GetContainerNumFreeSlots(i)
			self.slotCount = self.slotCount+GetContainerNumSlots(i)
		end
		self.broker.text = self.freeSlotCount
	end,
	events={
		["BAG_UPDATE"] = function(self, slot) self.Update(self) end
	},
	broker = {
		type = "data source",
		text = "?",
		icon = "Interface\\Icons\\INV_Misc_Bag_08",
		OnClick = function(self, button)
			ToggleAllBags()
		end,
		OnTooltipShow = function(self)
			GameTooltip:AddDoubleLine(tool:L("name"),tool.freeSlotCount.."|cffffffff ("..tool.slotCount..")|r")
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine("|TInterface\\Icons\\INV_Misc_Bag_08:12:12:0:0|t "..tool:L("backpack"),GetContainerNumFreeSlots(0).."|cffffffff ("..GetContainerNumSlots(0)..")|r",1,1,1)
			for i=1, NUM_BAG_SLOTS do
				local inventoryID = ContainerIDToInventoryID(i)
				local name, _, quality, _, _, _, _, _, _, texture = GetItemInfo(GetInventoryItemID("player",inventoryID))
				local r,g,b = GetItemQualityColor(quality)
				GameTooltip:AddDoubleLine("|T"..texture..":12:12:0:0|t "..name,GetContainerNumFreeSlots(i).."|cffffffff ("..GetContainerNumSlots(i)..")|r",r,g,b)
			end
		end
	},
	PreInit = function(self)
		self.Update(self)
	end,
})