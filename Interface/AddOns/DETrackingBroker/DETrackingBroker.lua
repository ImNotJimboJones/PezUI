DETrackingBroker = LibStub("AceAddon-3.0"):NewAddon("DETrackingBroker","AceConsole-3.0","AceEvent-3.0")
local self = DETrackingBroker
local DETrackingBroker = DETrackingBroker
local L = LibStub("AceLocale-3.0"):GetLocale("DETrackingBroker")
local db
local Tracking = CreateFrame("Frame", nil, UIParent)
local minimapIcon = LibStub("LibDBIcon-1.0")
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local tipshown
local lastUp = 0
local toff = L["Tracking Off"]
local sformat = string.format
MiniMapTracking:UnregisterAllEvents()
MiniMapTracking:Hide()
local defaults = {
	profile = {
	minimap = {
    		  hide = false,
		    },	
	tipr = 1,
	tipg = 0.82,
	tipb = 0,
	tipa = 1,		
	textr = 1,
	textg = 0.82,
	textb = 0,
	texta = 1,
	}
}
local function getOptions()
local options = {
	type = "group",
	icon = "Interface\\Minimap\\Tracking\\None",
	name = GetAddOnMetadata("DETrackingBroker", "Title"),	
	args = {		
		detrackingdesc = {
				type = "description",
				order = 1,
				name = GetAddOnMetadata("DETrackingBroker", "Version").." "..GetAddOnMetadata("DETrackingBroker", "Author").."\n"..GetAddOnMetadata("DETrackingBroker", "Notes"),
				fontSize = "medium",
				image = "Interface\\Minimap\\Tracking\\None",
			},
		deheader = {
				type = "header",
				name = L["Options"],
				order = 5,
			},
		minimap = {
      			order = 10,
			type = "toggle",
			name = L["Show Minimap Tracking Icon"],
			desc = L["Show tracking menu minimap button"],
			width = "full",
			get = function(info) return not self.db.profile.minimap.hide end,
      			set = function(info,val) 
                  		self.db.profile.minimap.hide = not val
				DETrackingBroker:ToggleIcon()
            			end,
   			 },		
		textheader = {
				type = "header",
				name = L["Broker Text Color Options"],
				order = 50,
			},
		textreset = {
				type = "execute",
				name = L["Reset Color"],
				desc = L["Reset the color of the Broker text to default"],				
				order = 60,
				func = function()
					self.db.profile.textr = 1
					self.db.profile.textg = 0.82
					self.db.profile.textb = 0
					self.db.profile.texta = 1
				end,
			},			
		textcolor = {
				type = 'color',
				name = L["Color"],
				desc = L["Set the color of the Broker text"],
				order = 70,
				hasAlpha = false,		
				get = function()
					return self.db.profile.textr, self.db.profile.textg, self.db.profile.textb, self.db.profile.texta
					end,
				set = function(info, r, g, b, a)
					self.db.profile.textr = r
					self.db.profile.textg = g
					self.db.profile.textb = b
					self.db.profile.texta = a
				end,		
			},			
		tooltipheader = {
					type = "header",
					name = L["Tooltip Text Color Options"],
					order = 80,
			},		
		ttreset = {
				type = "execute",
				name = L["Reset Color"],
				desc = L["Reset the color of the tooltip text to default"],
				order = 90,
				func = function()
					self.db.profile.tipr = 1
					self.db.profile.tipg = 0.82
					self.db.profile.tipb = 0
					self.db.profile.tipa = 1
				end,
			},
		ttcolor = {
				type = 'color',
				name = L["Color"],
				desc = L["Set the color of the tooltip text"],
				order = 100,
				hasAlpha = false,
				get = function()
					return self.db.profile.tipr, self.db.profile.tipg, self.db.profile.tipb, self.db.profile.tipa
					end,
				set = function(info, r, g, b, a)
					self.db.profile.tipr = r
					self.db.profile.tipg = g
					self.db.profile.tipb = b
					self.db.profile.tipa = a
				end,		
			},		
	}
}
return options
end
function DETrackingBroker:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("DETrackingBrokerDB", defaults, 'Default')
	if not self.db then
		Print("Error: Database not loaded correctly.  Please exit out of WoW and delete DETrackingBroker.lua found in: \\World of Warcraft\\WTF\\Account\\<Account Name>>\\SavedVariables\\")
	end
	db = self.db.profile
	profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("DETrackingBroker", getOptions)	
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("DETrackingBroker", GetAddOnMetadata("DETrackingBroker", "Title"))
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("DETrackingBroker.profiles", profiles)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("DETrackingBroker.profiles", "Profiles", GetAddOnMetadata("DETrackingBroker", "Title"))	
	self:RegisterChatCommand("DETrackingBroker", function() InterfaceOptionsFrame_OpenToCategory(GetAddOnMetadata("DETrackingBroker", "Title")) end)
	self:RegisterChatCommand("detracker", function() InterfaceOptionsFrame_OpenToCategory(GetAddOnMetadata("DETrackingBroker", "Title")) end)
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileCopied")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileReset")
	self.db.RegisterCallback(self, "OnProfileDeleted", "OnProfileDeleted")		
end
function DETrackingBroker:OnProfileChanged()
	db = self.db.profile
	Print("DETrackingBroker Options Changed!")
	DETrackingBroker:UpdateText()
end
function DETrackingBroker:OnProfileCopied()
	db = self.db.profile
	Print("DETrackingBroker Options Copied!")
	DETrackingBroker:UpdateText()
end
function DETrackingBroker:OnProfileReset()
	db = self.db.profile
	Print("DETrackingBroker Options Reset!")
	DETrackingBroker:UpdateText()
end
function DETrackingBroker:OnProfileDeleted()
	db = self.db.profile
	Print("DETrackingBroker Options Deleted!")
	DETrackingBroker:UpdateText()
end
local function GetTipAnchor(frame)
	local x,y = frame:GetCenter()
	if not x or not y then return "TOPLEFT", "BOTTOMLEFT" end
	local hhalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or (x < UIParent:GetWidth()/3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end

local Object = ldb:NewDataObject("DETrackingBroker", {
	type = "data source",
	icon = "Interface\\Minimap\\Tracking\\None",
	text = L["Tracking Off"],
	label = "|cffff0000DE|cff0062ffTracking|cffffffffBroker|r",
	OnClick = function(frame, button)
	GameTooltip:Hide()
	if button == "RightButton" then
			LibStub("AceConfigDialog-3.0"):Open("DETrackingBroker")			
			PlaySound("BAGMENUBUTTONPRESS")
	else
			ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, frame)
			PlaySound("igMainMenuOptionCheckBoxOn")
	end
	DETrackingBroker:UpdateText()
	end,
	OnEnter = function(self)

	tipshown = self
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint(GetTipAnchor(self))
	GameTooltip:ClearLines()
	GameTooltip:AddLine(GetAddOnMetadata("DETrackingBroker", "Title").." "..GetAddOnMetadata("DETrackingBroker", "Version").." "..GetAddOnMetadata("DETrackingBroker", "Author"))
	DETrackingBroker:UpdateTooltipText()	
	GameTooltip:AddLine(" ")	
	GameTooltip:AddLine(L["Hint: Left-Click to toggle Tracking Menu"], 0, 1, 0)
	GameTooltip:AddTexture("Interface\\Minimap\\Tracking\\None")	
	GameTooltip:AddLine(L["Hint: Right-Click to open Options"], 0, 1, 0)
	GameTooltip:AddTexture("Interface\\Minimap\\Tracking\\None")	
	GameTooltip:Show()
	end,

	OnLeave = function()

	GameTooltip:Hide()
	tipshown = nil	
	end,
})

function DETrackingBroker:OnEnable()
	self.db.profile.minimap = self.db.profile.minimap or {}
	minimapIcon:Register("DETrackingBroker", Object, self.db.profile.minimap)
	DETrackingBroker:ToggleIcon()
	Tracking:SetScript("OnUpdate", DETrackingBroker.OnUpdate)
	DETrackingBroker:UpdateText()
end

Tracking:RegisterEvent("MINIMAP_UPDATE_TRACKING")
Tracking:RegisterEvent("PLAYER_LOGIN")
Tracking:RegisterEvent("PLAYER_ENTERING_WORLD")

Tracking:SetScript("OnEvent", function()
	DETrackingBroker:ToggleIcon()
	DETrackingBroker:UpdateText()
	if tipshown then Object.OnEnter(tipshown) end
end)

function DETrackingBroker:UpdateTooltipText()
	local DE3 = 0
	local r = self.db.profile.tipr
 	local g = self.db.profile.tipg
 	local b = self.db.profile.tipb
	for Index = 1, GetNumTrackingTypes() do
		if select(3,GetTrackingInfo(Index)) then
			DE3 = DE3 + 1
			local name, texture, active, category = GetTrackingInfo(Index)				
			GameTooltip:AddLine("\124T"..texture..":16\124t "..name, r, g, b)
		end
	end
	if DE3 == 0 then			
		GameTooltip:AddLine(toff, r, g, b)
		GameTooltip:AddTexture("Interface\\Minimap\\Tracking\\None")
	end
end

function DETrackingBroker:UpdateText()
	local r = self.db.profile.textr * 255
	local g = self.db.profile.textg * 255
	local b = self.db.profile.textb * 255
	Object.icon = "Interface\\Minimap\\Tracking\\None"
	Object.text = sformat("|CFF%02x%02x%02x%s|r", r, g, b, toff)
	for Index = 1, GetNumTrackingTypes() do
	local name, texture, active, category  = GetTrackingInfo(Index)
		if active then	
			Object.icon = texture
			Object.text = sformat("|CFF%02x%02x%02x%s|r", r, g, b, name)
		return
		end
	end
end

function DETrackingBroker:ToggleIcon()
	if self.db.profile.minimap.hide then
    	minimapIcon:Hide("DETrackingBroker")
  	else
   	minimapIcon:Show("DETrackingBroker")
 	end
end

function DETrackingBroker:OnUpdate(elapsed)
	lastUp = lastUp + elapsed
	if lastUp > 1 then
	DETrackingBroker:UpdateText()	
	if tipshown then Object.OnEnter(tipshown) end
	lastUp = 0
	end
end
