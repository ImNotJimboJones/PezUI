local addonName, addon = ...

addon.defaultSettings = {
	includeSocial	= false,
	latency			= 600,
	lock				= false,
	spacing			= 3,
	tooltip			= ""
}

local buttons, order = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 }, { 1, 2, 3, 4, 5, 7, 8, 9, 10, 11 }

--[[-----------------------------------------------------------------------------
Platform
-------------------------------------------------------------------------------]]
function addon:GetVersionInteger(version)
	local major, minor, revision = tostring(version):match("([0-9]+)%.([0-9]+)%.?([0-9]*)")
	return (tonumber(major) or 0) * 1000000 + (tonumber(minor) or 0) * 1000 + (tonumber(revision) or 0)
end

local frameName
if (GetAddOnMetadata(addonName, "X-AllowPlugin") or ""):lower() == "true" then
	if IsAddOnLoaded('Titan') and addon:GetVersionInteger(GetAddOnMetadata('Titan', 'Version')) >= 4003000 then
		addon.platform, frameName = 'Titan', 'TitanPanel' .. addonName .. 'Button'
	elseif IsAddOnLoaded('FuBar') and addon:GetVersionInteger(GetAddOnMetadata('FuBar', 'X-Curse-Project-Name')) >= 3006000 and LibStub('LibFuBarPlugin-3.0', true) then
		addon.platform = 'FuBar'
	end
end
if not addon.platform then
	frameName = addonName .. "Frame"
end

--[[-----------------------------------------------------------------------------
Plugin frame
-------------------------------------------------------------------------------]]
local frame = CreateFrame('Button', frameName, UIParent)
frame:EnableMouse(true)
frame:SetMovable(true)
frame:SetPoint('CENTER')
frame:SetHeight(1)
frame:SetWidth(1)
frame:Hide()

frame:SetScript('OnShow', function(self)
	self:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	self:RegisterForDrag('LeftButton')
	self:SetScript('OnClick', addon.OnClick)
	self:SetScript('OnDragStart', addon.OnDragStart)
	self:SetScript('OnDragStop', addon.OnDragStop)
	self:SetScript('OnEnter', addon.OnEnter)
	self:SetScript('OnLeave', addon.OnLeave)
	self:SetScript('OnShow', nil)
end)

--[[-----------------------------------------------------------------------------
Addon methods
-------------------------------------------------------------------------------]]
function addon:AdjustButtonOrder(id, new)
	local old = buttons[id].order
	local adj = old > new and -1 or 1
	for index = old, new - adj, adj do
		order[index] = order[index + adj]
	end
	order[new] = id
	self:CopyOrderToButtons()
	self:UpdatePlugin()
	return new ~= old
end

function addon:CopyOrderToButtons()
	for id = 1, #buttons do
		buttons[id].order = nil
	end
	for index = 1, #order do
		buttons[order[index]].order = index
	end
end

function addon.DoNothing()
end

function addon:GetAnchorInfo(frame)
	local _, y = frame:GetCenter()
	if y * 2 >= UIParent:GetHeight() then
		return 'TOP', frame, 'BOTTOM'
	end
	return 'BOTTOM', frame, 'TOP'
end

function addon.OnClick(_, button)
	if button == 'RightButton' and addon.config then
		addon.config()
	end
end

--[[-----------------------------------------------------------------------------
Initialize
-------------------------------------------------------------------------------]]
addon.buttons, addon.frame, addon.order = buttons, frame, order

local function UpdateProfile()
	local settings = addon.db.profile
	local settings_order = settings.order
	if type(settings_order) == 'table' and #settings_order <= #buttons then
		for index = 1, #settings_order do
			order[index] = settings_order[index]
		end
		for index = #order, #settings_order + 1, -1 do
			order[index] = nil
		end
	end
	settings.order = order
	addon:CopyOrderToButtons()
	addon:ApplyPluginSettings()
end

frame:SetScript('OnEvent', function(self, event, name)
	if name ~= addonName then return end
	self:UnregisterEvent(event)
	self:SetScript('OnEvent', nil)

	addon.db = LibStub('AceDB-3.0'):New(addonName .. "Settings", { profile = addon.defaultSettings }, 'Default')
	local settings = addon.db.profile
	if addon:GetVersionInteger(settings.version) < 1000003 then
		local order = settings.order
		if type(order) == 'table' then
			for index = 1, #order do
				if order[index] >= 6 then
					order[index] = order[index] + 1
				end
			end
		end
	end
	settings.version = GetAddOnMetadata(addonName, 'Version')

	addon.db.RegisterCallback(addon, 'OnProfileChanged', UpdateProfile)
	addon.db.RegisterCallback(addon, 'OnProfileCopied', UpdateProfile)
	addon.db.RegisterCallback(addon, 'OnProfileReset', UpdateProfile)
	UpdateProfile()
end)
frame:RegisterEvent('ADDON_LOADED')

-- Load on demand configuration
local LOA = LibStub('LibOptionsAssist-1.0', true)
if not (LOA and select(2, GetAddOnInfo(addonName .. '_Config'))) then return end	-- Make sure config support exists

addon.config = LOA:AddEntry(addonName, nil, function()
	addon.L = setmetatable({ }, { __index = function(self, key)
		self[key] = key
		return key
	end })

	local config = addonName .. '_Config'
	addon.addonName, _G[config] = addonName, addon
	LibStub('LibOptionsAssist-1.0'):LoadModule(config)
	addon.addonName, _G[config] = nil, nil
end)
