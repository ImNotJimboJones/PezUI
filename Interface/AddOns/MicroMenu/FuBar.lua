local addonName, addon = ...

if addon.platform ~= 'FuBar' then return end

addon.defaultSettings.fubarPosition = 'CENTER'
addon.defaultSettings.fubarTooltip = true

local buttonSize, buttonSizeMax = 8, 16														-- Automatically updated later

local buttons, frame, order = addon.buttons, addon.frame, addon.order

local plugin = {
	category = GetAddOnMetadata(addonName, 'X-Category'),
	frame = frame,
	name = addonName
}

--[[-----------------------------------------------------------------------------
Script abstraction
-------------------------------------------------------------------------------]]
function addon.OnDragStart()
	addon.isMoving = true
	FuBar:Plugin_StartDrag(plugin)
	GameTooltip:Hide()
end

function addon.OnDragStop()
	FuBar:Plugin_StopDrag(plugin)
	addon.isMoving = nil
end

function addon.OnEnter()
	if addon.isMoving then return end
	FuBar:Panel_OnEnter(plugin)
end

function addon.OnLeave()
	if addon.isMoving then return end
	FuBar:Panel_OnLeave(plugin)
end

--[[-----------------------------------------------------------------------------
Addon methods
-------------------------------------------------------------------------------]]
function addon:ApplyPluginSettings()
	local panel = plugin:GetPanel()
	if panel then
		panel:SetPluginSide(plugin, self.db.profile.fubarPosition)
		self:UpdatePlugin()
	end
end

function addon:IsTooltipAllowed()
	local settings = self.db.profile
	if settings.fubarTooltip then
		return not (FuBar:IsHidingTooltipsInCombat() and InCombatLockdown())
	end
	return SecureCmdOptionParse(settings.tooltip) ~= "Hide"
end

function addon.UpdatePlugin()
	local spacing = addon.db.profile.spacing
	local baseOffset, button = buttonSize + spacing
	for id = 1, #buttons do
		button = buttons[id]
		if button.order then
			button:SetHeight(buttonSize)
			button:SetWidth(buttonSize)
			button:ClearAllPoints()
			button:SetPoint('LEFT', frame, baseOffset * (button.order - 1), 0)
			button:Show()
		else
			button:Hide()
		end
	end
	frame:SetHeight(buttonSizeMax)
	frame:SetWidth(baseOffset * #order - spacing)
	local panel = plugin:GetPanel()
	if panel and panel:GetPluginSide(plugin) == 'CENTER' then
		panel:UpdateCenteredPosition()
	end
end

--[[-----------------------------------------------------------------------------
Helper functions
-------------------------------------------------------------------------------]]
local function OnSizeChanged()
	buttonSizeMax = FuBar:GetFontSize() + FuBar:GetThickness()
	buttonSize = buttonSizeMax * 0.8
	if addon.db then
		addon:UpdatePlugin()
	end
end

--[[-----------------------------------------------------------------------------
Initialize
-------------------------------------------------------------------------------]]
LibStub('LibFuBarPlugin-3.0'):Embed(plugin)

plugin:SetFuBarOption('cannotDetachTooltip', true)
plugin:SetFuBarOption('configType', 'None')
plugin:SetFuBarOption('clickableTooltip', true)
plugin:SetFuBarOption('defaultPosition', addon.defaultSettings.fubarPosition)
plugin:SetFuBarOption('hasNoColor', true)
plugin:SetFuBarOption('hasNoText', true)
plugin:SetFuBarOption('independentProfile', true)
plugin:SetFuBarOption('overrideMenu', true)
plugin:SetFuBarOption('tooltipType', 'Custom')

plugin.CheckWidth = OnSizeChanged
plugin.SetFontSize = OnSizeChanged
plugin.UpdateFuBarPlugin = addon.UpdatePlugin

frame:SetFrameStrata('HIGH')
frame:SetFrameLevel(7)
frame.self = plugin

LibStub('LibFuBarPlugin-3.0'):OnEmbedInitialize(plugin)

frame:SetScript('OnDoubleClick', nil)
frame:SetScript('OnMouseDown', nil)
frame:SetScript('OnMouseUp', nil)
frame:SetScript('OnReceiveDrag', nil)

LibStub('LibFuBarPlugin-3.0'):OnEmbedEnable(plugin)
