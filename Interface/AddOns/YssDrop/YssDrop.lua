
YssDrop = CreateFrame("Frame")
local YssDrop = YssDrop
YssDrop:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
function YssDrop:Print(...) ChatFrame1:AddMessage(string.join(" ", "|cFF33FF99Broker: YssDrop|r:", ...)) end
YssDrop:RegisterEvent("ADDON_LOADED")

local LQT = LibStub('LibQTip-1.0')
local broker = LibStub("LibDataBroker-1.1")
local icon = LibStub("LibDBIcon-1.0")
local maxheight = floor(UIParent:GetHeight())

local dummyframe = CreateFrame('Frame')
dummyframe:Hide()
_G['YssDropFrame'] = dummyframe
tinsert(UISpecialFrames,"YssDropFrame")

local frameStrata = {"BACKGROUND", "LOW", "MEDIUM", "HIGH", "DIALOG", "FULLSCREEN", "FULLSCREEN_DIALOG", "TOOLTIP"}

-- Broker Tooltip handling
--we use our own tooltip so that other tooltipmods don't mess with our positioning
local YssTooltip =  CreateFrame("GameTooltip", "YssDropTooltip", UIParent, "GameTooltipTemplate")

local function GetAnchors(cell)
	local x, y = cell:GetCenter()
	local vertical
	if y < GetScreenHeight() / 2 then
		vertical = "BOTTOM"
	else
		vertical = "TOP"
	end
	if x < GetScreenWidth() / 2 then
		return vertical.."LEFT", vertical.."RIGHT"
	else

		return vertical.."RIGHT", vertical.."LEFT"
	end
end

local function GT_OnLeave(self)
	self:SetScript("OnLeave", self.YssDrop_OnLeave)
	self:Hide()
	YssTooltip:EnableMouse(false)
end

local function PrepareTooltip(frame, cell)
	if frame == YssTooltip then
		frame.YssDrop_OnLeave = frame:GetScript("OnLeave")
		frame:EnableMouse(true)
		frame:SetScript("OnLeave", GT_OnLeave)
		-- copy look and scale of GameTooltip to keep things consistent
		frame:SetBackdrop(GameTooltip:GetBackdrop())
		frame:SetBackdropBorderColor(GameTooltip:GetBackdropBorderColor())
		frame:SetBackdropColor(GameTooltip:GetBackdropColor())
		frame:SetScale(GameTooltip:GetScale())
	end
	frame:SetOwner(cell, "ANCHOR_NONE")
	frame:ClearAllPoints()
	local a1, a2 = GetAnchors(cell)
	frame:SetPoint(a1, cell, a2)
end

local cell_tooltip
local cell_tooltip_blacklist = {}
local function clamp_func(frame, ...)
	if frame._orig_OnHide then
		frame._orig_OnHide(frame, ...)
		frame:SetScript("OnHide", frame._orig_OnHide)
		frame._orig_OnHide = nil
	else
		frame:SetScript("OnHide", nil)
	end
	frame:SetClampedToScreen(false)
end

local function OnUpdate()
	local frame = EnumerateFrames()
	while frame do
		local _, relativeTo = frame:GetPoint()
		if not cell_tooltip_blacklist[cell_tooltip][frame] and relativeTo == cell_tooltip then
			local a1, a2 = GetAnchors(cell_tooltip)
			frame:ClearAllPoints()
			local clamp = frame:IsClampedToScreen()
			if not clamp then
				frame:SetClampedToScreen(true)
				local script = frame:GetScript('OnHide')
				if script ~= clamp_func then
					frame._orig_OnHide = script
					frame:SetScript('OnHide', clamp_func)
				end
			end
			frame:SetPoint(a1, cell_tooltip, a2)
		end
		frame = EnumerateFrames(frame)
	end
end

local function YssDrop_Click(cell, name, ...)
	local obj = broker:GetDataObjectByName(name)
	if obj.OnClick then
		obj.OnClick(cell, ...)
	end
end

local function YssDrop_Leave(cell, name, ...)
	YssDrop:SetScript('OnUpdate', nil)
	cell_tooltip = nil
	local obj = broker:GetDataObjectByName(name)
	if obj.OnLeave then
		obj.OnLeave(cell)
	end
	if MouseIsOver(YssTooltip) and (obj.tooltiptext or obj.OnTooltipShow) then return end

	if obj.tooltiptext or obj.OnTooltipShow then
		GT_OnLeave(YssTooltip)
	end
end

local function YssDrop_Enter(cell, name, ...)
	local obj = broker:GetDataObjectByName(name)
	if obj.tooltip then
		PrepareTooltip(obj.tooltip, cell)
		if obj.tooltiptext then
			obj.tooltip:SetText(obj.tooltiptext)
		end
		obj.tooltip:Show()

	elseif obj.OnTooltipShow then
		PrepareTooltip(YssTooltip, cell)
		obj.OnTooltipShow(YssTooltip)
		YssTooltip:Show()

	elseif obj.tooltiptext then
		PrepareTooltip(YssTooltip, cell)
		YssTooltip:SetText(obj.tooltiptext)
		YssTooltip:Show()

	elseif obj.OnEnter then
		local frame = EnumerateFrames()
		if not cell_tooltip_blacklist[cell] then
			cell_tooltip_blacklist[cell] = {}
			while frame do
				local _, relativeTo = frame:GetPoint()
				if relativeTo == cell then
					cell_tooltip_blacklist[cell][frame] = true
				end
				frame = EnumerateFrames(frame)
			end
			frame = EnumerateFrames()
		end
		obj.OnEnter(cell)
		while frame do
			local _, relativeTo = frame:GetPoint()
			if not cell_tooltip_blacklist[cell][frame]and relativeTo == cell then
				local a1, a2 = GetAnchors(cell)
				frame:ClearAllPoints()
				local clamp = frame:IsClampedToScreen()
				if not clamp then
					frame:SetClampedToScreen(true)
					local script = frame:GetScript('OnHide')
					if script ~= clamp_func then
						frame._orig_OnHide = script
						frame:SetScript('OnHide', clamp_func)
					end
				end
				frame:SetPoint(a1, cell, a2)
				YssDrop:SetScript('OnUpdate', OnUpdate)
			end
			frame = EnumerateFrames(frame)
		end
		cell_tooltip = cell
	end
end

-- LQT hide function
local tooltip
function YssDrop:HideTooltip()
	broker.UnregisterCallback(YssDrop, "LibDataBroker_AttributeChanged")
	self:SetScript('OnUpdate', nil)
	wipe(cell_tooltip_blacklist)
	tooltip:SetScript('OnHide', nil)
	tooltip:SetFrameStrata("TOOLTIP")
	tooltip:SetScript( "OnLeave", nil )
	tooltip:Clear()
	tooltip:Hide()
	tooltip = LQT:Release( tooltip )
	_G['YssDropFrame'] = dummyframe
end

local Broker_Cells = {}
function YssDrop:ShowTooltip(anchorFrame)
	wipe(Broker_Cells)
	if tooltip then self:HideTooltip() end
	tooltip = LQT:Acquire("YssDropTT", 2, "LEFT", "LEFT") -- or YssTooltip
	tooltip:SetFrameStrata(frameStrata[self.db.profile.Strata])
	tooltip:SetScale(self.db.profile.Scale)
	tooltip:SetScript('OnHide', YssDrop.HideTooltip)

	tooltip:AddHeader("")
	tooltip:SetCell(1, 1, "|cFF33FF99YssDrop|r", nil, 'CENTER', 2)
	local count = 2
	local obj, state
	for i, name in ipairs(self.activebrokers) do
		obj = broker:GetDataObjectByName(name)
		if self.db.profile.Enabled[name] then
			tooltip:AddLine()
			self:SetCell(name, obj, count)
			Broker_Cells[name] = count
			count = count + 1
		end
	end
	tooltip:SmartAnchorTo(anchorFrame)
	tooltip:EnableMouse()
	tooltip:UpdateScrolling(self.db.profile.maxheight)
	tooltip:Show()
	broker.RegisterCallback(self, "LibDataBroker_AttributeChanged")
	_G['YssDropFrame'] = tooltip
end

-- hide YssDrop when you click the world frame (code adapted from Torhals Volumizer)
local old_x, old_y, click_time
WorldFrame:HookScript("OnMouseDown", function(frame, ...)
	if tooltip then
		old_x, old_y = GetCursorPosition()
		click_time = GetTime()
	end
end)
WorldFrame:HookScript("OnMouseUp", function(frame, ...)
	if tooltip then
		local x, y = GetCursorPosition()
		if not old_x or not old_y or not x or not y or not click_time then
			YssDrop:HideTooltip()
			if WorldFrame_OnMouseUp then WorldFrame_OnMouseUp(frame, ...) end
			return
		end
			if (math.abs(x - old_x) + math.abs(y - old_y)) <= 5 and GetTime() - click_time < .5 then
			YssDrop:HideTooltip()
		end
	end
end)

function YssDrop:LibDataBroker_AttributeChanged(event, name, attr, value, obj)
	if Broker_Cells[name] then
		self:SetCell(name, obj, Broker_Cells[name])
	end
end

function YssDrop:SetCell(name, obj, row)
	tooltip:SetCell(row, 1, string.format("|T%s:0|t", obj.icon or ''))
	if self.db.profile.Text[name] and self.db.profile.Label[name] then
		tooltip:SetCell(row, 2, string.format("%s: %s", obj.label or name, obj.text or ''))
	elseif self.db.profile.Text[name] then
		tooltip:SetCell(row, 2, string.format("%s", obj.text or ''))
	else
		tooltip:SetCell(row, 2, string.format("%s", obj.label or name))
	end
	tooltip:SetLineScript(row, 'OnEnter', YssDrop_Enter, name)
	tooltip:SetLineScript(row, 'OnLeave', YssDrop_Leave, name)
	tooltip:SetLineScript(row, 'OnMouseUp', YssDrop_Click, name)
end

function YssDrop:Getter(info)
	return self.db.profile[info[#info]][info[#info-1]]
end

function YssDrop:Setter(info, val)
	self.db.profile[info[#info]][info[#info-1]] = val
end

 YssDrop.BrokerOptionTable = {
		type="group",
		dialogInline = true,
		name = function(info)
			local name = info[#info]
			local btype = broker:GetDataObjectByName(name)["type"]
			if string.lower(tostring(btype)) == 'launcher' then
				return name.." |cFF33FF99("..btype..")|r"
			elseif btype then
				return name.." |cFFFF3399("..btype..")|r"
			else
				return name
			end
		end,
		order = function(info) return YssDrop.activebrokersRL[info[#info]]+100 end,
		args = {
			Enabled = {
				type = "toggle",
				name = 'Enable',
				order = 1,
				get = 'Getter',
				set = 'Setter',
				width = 'half',
			},
			Text = {
				type = "toggle",
				name = 'Text',
				order = 2,
				get = 'Getter',
				set = 'Setter',
				width = 'half',
			},
			Label = {
				type = "toggle",
				name = 'Label',
				order = 3,
				get = 'Getter',
				set = 'Setter',
				width = 'half',
			},
		}
	}

YssDrop.activebrokers = {}
YssDrop.activebrokersRL = {}
local slower = string.lower
local function SortComp(a,b)
	return slower(a) < slower(b)
end

function YssDrop:LibDataBroker_DataObjectCreated(event, name, obj)
	if name == 'YssDrop' or self.activebrokersRL[name] then return end -- do not alowe self to be displayed form self (causes all types of bad)
	self.activebrokers[#self.activebrokers+1] = name
	table.sort(self.activebrokers, SortComp)
	for i, name in ipairs(self.activebrokers) do
		if not self.MainOption.args[name] then
			self.MainOption.args[name] = self.BrokerOptionTable
		end
	end
	if not (self.db.profile.Enabled[name] ==  true or self.db.profile.Enabled[name] ==  false) then
		if obj.type and (string.lower(obj.type) == 'launcher') then
			self.db.profile.Enabled[name] = true
			self.db.profile.Text[name] = false
			self.db.profile.Label[name] = true
		else
			self.db.profile.Enabled[name] = false
			self.db.profile.Text[name] = true
			self.db.profile.Label[name] = true
		end
	end
	for i, name in ipairs(self.activebrokers) do
		self.activebrokersRL[name] = i
	end
end

function YssDrop:ADDON_LOADED(event, addon)
	if addon == "YssDrop" then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		if IsLoggedIn() then self:PLAYER_LOGIN() else self:RegisterEvent("PLAYER_LOGIN") end
	end
end

function YssDrop:PLAYER_LOGIN(event, addon)
	local defaults = {
		["profile"] = {
			['Enabled'] = {},
			['Text'] = {},
			['Label'] = {},
			['Scale'] = 1,
			['Strata'] = 7,
			['maxheight'] = maxheight,
			['LibDBIcon'] = {
				['hide'] = true,
			},
		},
	}
	self.db = LibStub("AceDB-3.0"):New("YssDrop_DB", defaults, "Default")
	self.db:RegisterCallback("OnProfileChanged", function() YssDrop:ReloadOptions() end)
	self.db:RegisterCallback("OnProfileCopied", function() YssDrop:ReloadOptions() end)
	self.db:RegisterCallback("OnProfileReset", function() YssDrop:ReloadOptions() end)
	self:RegisterModuleOptions('profile', LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db), 'Profile')

	local hovertip
	self.obj = LibStub("LibDataBroker-1.1"):NewDataObject("YssDrop", {
		icon = "Interface\\AddOns\\YssDrop\\icon",
		label = "|cFF33FF99YssDrop|r",
		type = "data source",
		text  = "YssDrop",
		OnClick = function(clickedFrame, button)
			if button == "RightButton" then
				InterfaceOptionsFrame_OpenToCategory(YssDrop.optframe.YssDrop)
			else
				if tooltip then
					YssDrop:HideTooltip()
				else
					YssDrop:ShowTooltip(clickedFrame)
				end
			end
			if hovertip and hovertip.Hide then
				hovertip:Hide()
			end
		end,
		OnTooltipShow = function(tt)
			tt:AddLine('YssDrop')
			tt:AddLine("|cffffff00Click|r to toggle YssDrop")
			tt:AddLine("|cffffff00Right-click|r to open the options menu")
			hovertip = tt
		end,
	})
	icon:Register("YssDrop", YssDrop.obj, YssDrop.db.profile.LibDBIcon)

	broker.RegisterCallback(YssDrop, "LibDataBroker_DataObjectCreated")

	self:ReloadOptions()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

function YssDrop:ReloadOptions()
	wipe(self.activebrokers)
	wipe(self.activebrokersRL)
	for name, obj in broker:DataObjectIterator() do
		self:LibDataBroker_DataObjectCreated(nil, name, obj)
	end
end

YssDrop.MainOption = {
	type="group",
	childGroups = 'select',
	handler = YssDrop,
	args = {
		scale = {
			name = 'Scale',
			order = 1,
			type = "range",
			min = .5,
			max = 2,
			step = .01,
			get = function(info)
				return YssDrop.db.profile.Scale
			end,
			set = function(info, val)
				YssDrop.db.profile.Scale = val
			end,
		},
		maxheight = {
			name = 'Max Height',
			order = 2,
			type = "range",
			min = 75,
			max = maxheight,
			step = 1,
			get = function(info)
				return YssDrop.db.profile.maxheight
			end,
			set = function(info, val)
				YssDrop.db.profile.maxheight = val
			end,
		},
		Strata = {
			type = "select",
			name = 'Tooltip Strata',
			order = 3,
			values = frameStrata,
			get = function() return  YssDrop.db.profile.Strata end,
			set = function(info, val)
				YssDrop.db.profile.Strata = val
			end,
		},
		LibDBIcon = {
			type = "toggle",
			name = 'Minimap Icon',
			order = 5,
			get = function() return not YssDrop.db.profile.LibDBIcon.hide end,
			set = function(info, val)
				YssDrop.db.profile.LibDBIcon.hide = not val
				if val then
					icon:Show("YssDrop")
				else
					icon:Hide("YssDrop")
				end
			end,
		},
	},
}


YssDrop.optframe = {}
LibStub("AceConfig-3.0"):RegisterOptionsTable('YssDropConfig', YssDrop.MainOption)
YssDrop.optframe.YssDrop = LibStub("AceConfigDialog-3.0"):AddToBlizOptions('YssDropConfig', 'YssDrop')
-- function addapted from the RegisterModuleOptions function in Mapster
function YssDrop:RegisterModuleOptions(name, optionTbl, displayName)
	local cname = "YssDropConfig_"..name
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(cname, optionTbl)
	self.optframe[name] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(cname, displayName, "YssDrop")
end

--[==[
-- Test Code Follows
-- /script YssDrop:Test()
function YssDrop:Test()
	local testframe = CreateFrame('frame')
	testframe:SetHeight(700)
	testframe:SetWidth(120)
	--testframe:SetClampedToScreen(true)
	testframe:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                                            tile = true, tileSize = 16, edgeSize = 16,
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }})
	self.testobj = LibStub("LibDataBroker-1.1"):NewDataObject("YssDrop Test", {
		icon = "Interface\\AddOns\\YssDrop\\icon",
		label = "|cFF33FF99YssDrop Test|r",
		type = "launcher",
		text  = "YssDrop Test",
		OnEnter = function(clickedFrame)
			testframe:ClearAllPoints()
			testframe:SetPoint('TOP', clickedFrame, 'BOTTOM')
			testframe:Show()
		end,
		OnLeave = function(clickedFrame)
			testframe:Hide()
		end,
	})

end
]==]--
