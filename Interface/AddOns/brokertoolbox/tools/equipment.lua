local tool, i
tool = BrokerToolBox:NewTool("equipment",{
	author="Sanori",
	version="1.4 (10. Sep. 2012)",
	defaultON=true,
	ScanEquipment = function(self, name)		--Borrowed from p3lim's Broker_Equipment
		for slot, location in pairs(GetEquipmentSetLocations(name)) do
			local located = true
			if(location == 0) then
				located = not GetInventoryItemLink('player', slot)
			elseif(location ~= 1) then
				local player, bank, bags = EquipmentManager_UnpackLocation(location)
				located = player and not bank and not bags
			end
			if(not located) then
				return
			end
		end
		return true
	end,
	UpdateLDB = function(self)						--Borrowed from p3lim's Broker_Equipment
		for i = 1, GetNumEquipmentSets() do
			local name, icon, activeTalentTree, activeTalentTreeIcon = GetEquipmentSetInfo(i)
			if(self:ScanEquipment(name)) then
				self.broker.text = name
				self.broker.icon = icon
				break
			else
				self.broker.text = "???"
				self.broker.icon = "Interface\\Icons\\INV_Misc_QuestionMark"
			end
		end
	end,
	--[[GetTextureIndex = function(self, texture)	-- Borrowed from tekkub's EquipSetUpdater
		RefreshEquipmentSetIconInfo()
		local numIcons = GetNumMacroIcons()
		for index = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
			if(GetInventoryItemTexture('player', index)) then
				numIcons = numIcons + 1
			end
		end
		for index = 1, numIcons do
			local icon, textureIndex = GetEquipmentSetIconInfo(index)
			if(icon == texture) then
				return textureIndex
			end
		end
	end,]]
	events={
		["UNIT_INVENTORY_CHANGED"] = function(self, unit)
			if unit == 'player' then
				self:UpdateLDB()
			end
		end,
		["EQUIPMENT_SETS_CHANGED"] = function(self) self:UpdateLDB() end,
	},
	broker = {											--Broker
		type = "data source",
		text = "???",
		icon = "Interface\\Icons\\INV_Misc_QuestionMark",
		OnClick = function(self, button)
			if InCombatLockdown() then return end
			if(button ~= 'RightButton' --[[and GetNumEquipmentSets() > 0]]) then
				GameTooltip:Hide()
				tool.menu:Open(self, 'children', function(level, value)
					for i = 1, GetNumEquipmentSets() do
						local name, icon = GetEquipmentSetInfo(i)
						local _name = name
						if tool.broker.text==name then
							_name = "|cff00ff00"..name.."|r"
						end
						tool.menu:AddFunc(_name, function(self)
							if IsShiftKeyDown() then
								local dialog = StaticPopup_Show('CONFIRM_OVERWRITE_EQUIPMENT_SET', name)
								dialog.data = name
								--dialog.selectedIcon = tool:GetTextureIndex(icon)
							elseif IsControlKeyDown() then
								local dialog = StaticPopup_Show('CONFIRM_DELETE_EQUIPMENT_SET', name)
								dialog.data = name
							else
								EquipmentManager_EquipSet(name)
							end
						end, icon, true)
					end
				end)
				return
			end
			if (UnitLevel('player')>=10 and GetNumSpecGroups()==2) then
				if (GetActiveSpecGroup()==1) then
					SetActiveSpecGroup(2)
				else
					SetActiveSpecGroup(1)
				end
			end
		end,
		OnTooltipShow = function(self)
			GameTooltip:AddLine(tool.name.." |cffffffff("..tool:L("Leftclick")..")|r")
			for i = 1, GetNumEquipmentSets() do
				local name, icon = GetEquipmentSetInfo(i)
				local count = 0
				for _, id in pairs(GetEquipmentSetLocations(name)) do
					if id>1 then count=count+1 end
				end
				local r, g, b = 1,1,1
				if tool.broker.text==name then r, g, b = 0,1,0 end
				GameTooltip:AddDoubleLine("|T"..icon..":12:12:0:0|t "..name,count.." "..ITEMS,r,g,b,r,g,b)
			end
			GameTooltip:AddLine(" ")
			if (UnitLevel('player')>=10) then
				GameTooltip:AddLine(TALENTS.." |cffffffff("..tool:L("Rightclick")..")|r")
				for i=1, GetNumSpecGroups() do
					local currentSpec = GetSpecialization(nil, nil, i)
					local id, name, description, icon, background, role = GetSpecializationInfo(currentSpec)
					local r, g, b = 1,1,1
					if (i==GetActiveSpecGroup()) then r, g, b = 0, 1, 0 end
					GameTooltip:AddLine("|T"..icon..":12:12:0:0|t "..i..". "..name,r,g,b)
				end
				GameTooltip:AddLine(" ")
			end
			GameTooltip:AddLine(tool:L("Shiftclick"))
			GameTooltip:AddLine(tool:L("Ctrlclick"))
		end,
	},
	PostInit = function(self)
		self:UpdateLDB()
	end,
})