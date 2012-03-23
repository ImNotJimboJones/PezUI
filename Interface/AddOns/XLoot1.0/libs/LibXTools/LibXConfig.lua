local lib = LibStub:NewLibrary("X-Config", "1.0")
if not lib then return nil end
local XUI

local function trigger(target, method, ...)
	local func = target[method]
	if type(func) == 'function' then
		func(target, ...)
	end
end

local function math_round(number, dp)
	local mult = 10 ^ (dp or 0)
	return math.floor(number * mult + 0.5) / mult
end



-- Random name
if not lib.frame_key then
	lib.frame_key = 0
end
function lib:NewFrameName()
	lib.frame_key = lib.frame_key + 1
	return "XConfigComponent"..lib.frame_key
end

-- Helpers
local function Attach(frame, anchor, yoff)
	frame:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', 0, yoff)
	frame:SetPoint('TOPRIGHT', anchor, 'BOTTOMRIGHT', 0, yoff)
end

local function Stylize(frame)
	frame:SetBackdrop({
		bgFile = [[Interface\ChatFrame\ChatFrameBackground]], tile = true, tileSize = 16,
		insets = {left = 3, right = 3, top = 3, bottom = 3},
	})
	local r = math.random
	frame:SetBackdropColor(r(),r(),r(),.2)
end

-- Row components
local function FontString(frame, object)
	local fs = frame:CreateFontString(nil, 'OVERLAY')
	fs:SetFontObject(object or GameFontHighlight)
	fs:SetJustifyH('LEFT')
	fs:Show()
	fs.font = object
	return fs
end


-- Row methods
local function RowDisable(row)
	row.label:SetVertexColor(.6, .6, .6)
	
	local control = row.control
	if control then
		trigger(control, 'Disable')
		trigger(control, 'PostDisable')
	end
	
	trigger(row, 'disable')
end

local function RowEnable(row)
	if row.label.font then
		row.label:SetFontObject(row.label.font)
	else
		row.label:SetVertexColor(1, 1, 1)
	end
	
	local control = row.control
	if control then
		trigger(control, 'Enable')
		trigger(control, 'PostEnable')
	end
	
	trigger(row, 'enable')
end

local function RowChanged(row)
	local value = row:GetValue()
	
	-- Local callbacks
	local callbacks, items = row.owner.config.change_callbacks[row.key], row.owner.config.items
	if callbacks then
		for _, which in ipairs(callbacks) do
			items[which]:UpdateState()
		end
	end
	
	-- Addon callback
	trigger(row.owner, 'OnOptionModified', row.key, value)
end

local function RowUpdateState(row, is_refresh)
	local req = row.option.requires
	if req then
		local rel, value = row.owner.config.items[req]
		-- Get addon option value on panel refresh
		if is_refresh then
			value = row.owner:ConfigGet(req)
		-- Otherwise use panel value
		else
			value = rel:GetValue()
		end
		-- Inverse
		if row.option.requires_inverse then
			value = not (value)
		end
		if value then
			row:Enable()
		else
			row:Disable()
		end
	end
end

-- Factory
local function RowSetValue(self, value)
	return self.control:SetValue(value)
end

local function RowGetValue(self)
	return self.control:GetValue()
end

local function BuildColumn(addon, panel, groups)
	local L, LG = addon.L.config, addon.L.config_groups
	local items, change_callbacks = addon.config.items, addon.config.change_callbacks
	local column = CreateFrame('Frame', nil, panel)

	-- Groups
	local anchor = column
	for ig, g in ipairs(groups) do
		local group = table.remove(g, 1)
		local group_label = FontString(column, GameFontNormalLarge)
		group_label:SetText(LG[group])
		if anchor == column then
			group_label:SetPoint('TOPLEFT', anchor, 'TOPLEFT', 5, -5)
			group_label:SetPoint('TOPRIGHT', anchor, 'TOPRIGHT', -5, -5)
		else
			Attach(group_label, anchor, -10)
		end
		anchor = group_label
		
		-- Rows
		for ie, entry in ipairs(g) do
			local option = addon.config.options[entry]
			local row = CreateFrame('Frame', nil, column)
			local label
			
			-- Toggle
			if option.type == 'toggle' then
				row:SetHeight(20)
				label = FontString(row)
				
				-- Checkbox
				local check = XUI:CreateCheckbox(row)
				check.invert = option.invert
				check:SetPoint('LEFT')
				label:SetPoint('LEFT', check, 'RIGHT', 0, 1)
				label:SetPoint('RIGHT', row, 'RIGHT')
				
				row.control = check
			
			-- Numbers
			elseif option.type == 'number' then
				row:SetHeight(24)
				label = FontString(row)
				
				-- Editbox
				local edit = XUI:CreateEditbox(row)
				local len = option.length or 4
				edit:SetMaxLetters(len)
				edit:SetPoint('LEFT', 8, 0)
				edit:SetWidth(20 + (len*5))
				
				label:SetPoint('LEFT', edit, 'RIGHT', 4, 0)
				label:SetPoint('RIGHT', row, 'RIGHT')
				
				row.control = edit
			
			-- Range
			elseif option.type == 'range' then
				row:SetHeight(40)
				
				-- Slider
				local slider = XUI:CreateRange(row, L[entry..'_low'], L[entry..'_high'], option.min, option.max, option.step)
				label = slider.label
				slider:SetPoint('LEFT', 8, 0)
				
				row.control = slider
				
			-- Select
			elseif option.type == 'select' then
				row:SetHeight(45)
				
				-- Select
				local select = XUI:CreateSelect(row, option.items)
				label = select.label
				select:SetAllPoints()
				select:Enable()
				
				row.control = select
				label = select.label
			
			-- Color picker
			elseif option.type == 'color' then
				row:SetHeight(20)
				label = FontString(row)
				
				-- Swatch
				local swatch = XUI:CreateColorSwatch(row)
				swatch:SetPoint('LEFT', 5, 0)
				swatch.hasOpacity = option.opacity
				swatch:SetHitRectInsets(0, -100, 0, 0)
				
				label:SetPoint('LEFT', swatch, 'RIGHT', 5, 0)
				label:SetPoint('RIGHT')
				
				row.control = swatch

			end
			
			label:SetText(L[entry])
			
			-- Setters/Getters
			if row.control.GetValue and not row.GetValue then
				row.GetValue = RowGetValue
			end
			if row.control.SetValue and not row.SetValue then
				row.SetValue = RowSetValue
			end
			
			-- Request change callback
			if option.requires then
				if not change_callbacks[option.requires] then
					change_callbacks[option.requires] = { entry }
				else
					table.insert(change_callbacks[option.requires], entry)
				end
			end
			
			-- Methods
			row.label = label
			row.Disable = RowDisable
			row.Enable = RowEnable
			row.Changed = RowChanged
			row.UpdateState = RowUpdateState
			
			-- Data
			row.owner = addon
			row.key = entry
			row.option = option
			
			
			-- Cache
			items[entry] = row
			
			Attach(row, anchor, anchor == group_label and -5 or 0)
			anchor = row
		end
	end
	return column
end	


-- Gracefully handle options panel size changes
local function Resize(panel)
	if panel.left and panel.right then
		local width = InterfaceOptionsFramePanelContainer:GetWidth()/2 -10
		panel.left:SetWidth(width)
		panel.right:SetWidth(width)
	end
end

-- Profile panel
local BuildProfilePanel
do
	local items = { }
	local tinsert = table.insert
	local function Items(select)
		wipe(items)
		for k, v in pairs(select.addon:GetProfiles()) do
			tinsert(items, k)
		end
		return items
	end
	
	local function Selected(select, which)
		select.addon:SetProfile(which)
		for _, panel in pairs(select.addon.config.panels) do
			panel:refresh()
		end
	end
	
	local function CopyAccept(self)
		local select, text = self.select, self.editBox:GetText()
		if text and text ~= '' then
			local source = select.addon:GetActiveProfile()
			select.addon:SetProfile(text)
			select.addon:CopyProfile(source)
			select:SetValue(text)
		end
	end
	
	local function CopyClick(self, button)
		local popup = StaticPopup_Show('XCONFIG_COPYPROFILE')
		popup.select = self.select
	end
	
	local function ResetClick(self, button)
		self.addon:ResetProfile()
	end
	
	local function DeleteClick(self, button)
		local L = LibStub('X-Profile').L
		self.addon:RemoveProfile()
		self.addon:SetProfile(L.default_profile)
		self.select:SetValue(L.default_profile)
	end
	
	function BuildProfilePanel(addon)
		local L = LibStub('X-Profile').L
		if not StaticPopupDialogs['XCONFIG_COPYPROFILE'] then
			StaticPopupDialogs['XCONFIG_COPYPROFILE'] = {
				text = L.profile_copy_name,
				button1 = ACCEPT,
				button2 = CANCEL,
				OnAccept = CopyAccept,
				exclusive = true,
				hasEditBox = true,
				timeout = 0,
				whileDead = true,
				hideOnEscape = true,
				enterClicksFirstButton = true
			}
		end

		local panel = CreateFrame('Frame', lib:NewFrameName(), UIParent)
		panel.parent = addon.NAME
		panel.name = L.profile_panel
		panel.owner = addon
		panel:SetScript('OnSizeChanged', Resize)
		addon.config.profile_panel = panel
		
		InterfaceOptions_AddCategory(panel)
		
		local header = FontString(panel, GameFontNormalLarge)
		header:SetHeight(24)
		header:SetPoint('TOPLEFT', 25, -20)
		header:SetPoint('RIGHT')
		header:SetText(L.profile_header)
		-- local header_text = FontString(p, GameFontHighlightSmall)
		-- header_text:SetPoint('TOPLEFT', header, 'BOTTOMLEFT', -5, 5)
		-- header_text:SetPoint('RIGHT', p, 'RIGHT')
		-- header_text:SetHeight(20)
		-- header_text:SetText(L.profile_header_text)
		
		local profiles = XUI:CreateSelect(panel, Items)
		profiles.addon = addon
		profiles.callback = Selected
		profiles:SetValue(addon:GetActiveProfile())

		profiles.label:SetFontObject(GameFontNormal)
		profiles.label:SetText(L.profile_current)
		profiles:SetPoint('TOPLEFT', header, 'BOTTOMLEFT', 20, -40)
		profiles:SetWidth(200)
		profiles:SetHeight(45)
		
		local copy = XUI:CreateUIButton(panel)
		copy.select = profiles
		copy:SetText(L.profile_copy)
		copy:SetPoint('TOPLEFT', profiles, 'BOTTOMLEFT', 0, -25)
		copy:FitToText()
		copy:SetScript('OnClick', CopyClick)
		
		local reset = XUI:CreateUIButton(panel)
		reset.addon = addon
		reset:SetText(L.profile_reset)
		reset:SetPoint('LEFT', copy, 'RIGHT', 10, 0)
		reset:SetScript('OnClick', ResetClick)
		reset:FitToText()
		
		local delete = XUI:CreateUIButton(panel)
		delete.addon = addon
		delete.select = profiles
		delete:SetText(L.profile_remove)
		delete:SetPoint('LEFT', reset, 'RIGHT', 10, 0)
		delete:SetScript('OnClick', DeleteClick)
		delete:FitToText()
	end
end


-- Constructor
local MainPanel
do
	-- Options filling/saving
	local function Refresh(panel)
		local addon = panel.owner
		-- Update
		for k, v in pairs(addon.config.items) do
			if v.SetValue then
				v:SetValue(addon:ConfigGet(k, true))
				v:UpdateState(true)
			end
		end
		trigger(panel.owner, 'ConfigPanelRefresh', panel)
	end

	local function Save(panel)
		local addon = panel.owner
		for k, v in pairs(addon.config.items) do
			if v.GetValue then
				addon:ConfigSet(k, v:GetValue())
			end
		end
		trigger(panel.owner, 'ConfigSave')
	end
	
	local function Show(panel)
		trigger(panel.owner, 'ConfigPanelShow', panel)
	end

	local function Default(panel)
		trigger(panel.owner, 'ConfigDefault')
	end
	
	-- Construct and/or show panels
	function MainPanel(bootstrap)
		if not bootstrap.done then
			bootstrap.done = true
			
			local addon = bootstrap.addon
			addon.config.items = { }
			addon.config.change_callbacks = { }
			addon.config.panels = { }
			XUI = LibStub('X-UI')
			
			for i, which in ipairs(addon.config.panel_index) do
				local structure = addon.config.panel_structure[which]
				local panel = CreateFrame('Frame', lib:NewFrameName(), UIParent)
				
				panel.name = addon.L.config_panels[which]
				panel.parent = addon.NAME
				panel.okay = Save
				panel.cancel = Refresh
				panel.refresh = Refresh
				panel.default = Default
				panel.owner = addon
				
				
				local left = BuildColumn(addon, panel, structure.left)
				local right = BuildColumn(addon, panel, structure.right)
				left:SetPoint('TOPLEFT', 10, -10)
				left:SetPoint('BOTTOMLEFT', 10, 10)
				right:SetPoint('TOPRIGHT', -10, -10)
				right:SetPoint('BOTTOMRIGHT', 10, 10)
				
				
				panel.left = left
				panel.right = right
				
				panel:SetScript('OnSizeChanged', Resize)
				
				InterfaceOptions_AddCategory(panel)
				
				Resize(panel)
				Refresh(panel)
				
				addon.config.panels[which] = panel
				if i == 1 then
					bootstrap.first_panel = panel
				end
				
				panel:HookScript('OnShow', Show)
			end
			
			-- Profiles panel
			if addon.xprofile then
				BuildProfilePanel(addon)
			end
			
			-- Trigger callback
			trigger(addon, 'ConfigBuilt')
		end
		InterfaceOptionsFrame_OpenToCategory(bootstrap.first_panel)
		bootstrap:Hide()
	end
end
	


do
	-- Slash commands
	-- TODO: Slash commands: Handle type='select'
	-- TODO: Slash commands: Handle profiles
	local function SlashHandler(addon, msg)
		local what, arg, data = string.split(' ', msg, 3)
		local opt, defaults = addon.opt, addon.defaults
		-- Defaults
		if msg == 'defaults' and addon.ConfigDefaults then
			trigger(addon, 'ConfigDefaults')
		
		-- Options
		elseif what == 'set' or what == 'get' or what == 'default' then
			if arg and defaults[arg] ~= nil then
				local option = addon.config.options[arg]
				if what == 'set' then
					if option.type == 'range' then
						opt[arg] = math.min(option.max, math.max(option.min, tonumber(data)))
					elseif option.type == 'number' then
						opt[arg] = tonumber(data)
					elseif option.type == 'toggle' then
						opt[arg] = (data == 'on' or data == '1' or data == 'yes' or data == 'true')
					end
				elseif what == 'get' then
					print(opt[arg])
				else
					opt[arg] = nil
				end
			elseif what == 'get' then
				local options = addon.config.options
				for k, v in pairs(defaults) do
					local option = options[k] 
					if not option or option.type == 'range' or option.type == 'number' or option.type == 'toggle' then
						if rawget(opt, k) == v then
							wprint(('|c2244dd22%s|r (%s): |c22dd4422[%s]|r (default: [%s])'):format(k, addon.L.config[k] or '', tostring(opt[k]), tostring(v)))
						else
							wprint(('|c2244dd22%s|r (%s): |c22dd4422[%s]|r'):format(k, addon.L.config[k] or '', tostring(opt[k])))

						end
					end
				end
			end
		else
			return false
		end
		return true
	end
	
	local function ShowOptions(addon)
		InterfaceOptionsFrame_OpenToCategory(addon.config.bootstrap)	
	end
	
	-- Initialization
	function lib:Setup(addon, frame_name)
		-- Bootstrap
		local bootstrap = CreateFrame('Frame', lib:NewFrameName(), UIParent)
		bootstrap.addon = addon
		bootstrap.name = addon.NAME
		bootstrap:Hide() -- Otherwise UIParent:Show() will trigger us
		InterfaceOptions_AddCategory(bootstrap)
		bootstrap:SetScript('OnShow', MainPanel)
		addon.config.bootstrap = bootstrap
		
		-- Embed methods
		addon.SlashHandler = SlashHandler
		addon.ShowOptions = ShowOptions
	end
end