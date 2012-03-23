local lib = LibStub:NewLibrary("X-UI", "1.0")
if not lib then return nil end



local function trigger(target, method, ...)
	local func = target[method]
	if type(func) == 'function' then
		func(target, ...)
	end
end

-- Random name
if not lib.frame_key then
	lib.frame_key = 0
end
function lib:NewFrameName()
	lib.frame_key = lib.frame_key + 1
	return "XUIComponent"..lib.frame_key
end

-- Skinning
do 
	local base = {
		padding = 2,
		size = 16,
		layer = 'ARTWORK',
		mode = 'BLEND',
		r = 1,
		g = 1,
		b = 1,
		a = 1
	}
	local types = {
		highlight = {
			mode = 'ADD',
			layer = 'HIGHLIGHT',
			texture = [[Interface\Buttons\ButtonHilight-Square]],
			size = 8,
			padding = 0,
			r = .8,
			g = .8,
			b = .8,
			a = .8
		}
	}
	
	local mt = {
		__index = function(t, k)
			local ttype = rawget(t, 'type')
			if ttype and types[ttype] and types[ttype][k] then
				return types[ttype][k]
			end
			return base[k] or nil
		end
	}
	
	local function meta(t)
		return setmetatable(t, mt)
	end
	
	local function update_borders(frame, options, borders)
		local padding = options.padding
		for pos, tex in ipairs(borders) do
			-- Set texture options
			tex:SetDrawLayer(options.layer)
			tex:SetTexture(options.texture)
			tex:SetBlendMode(options.mode)
			tex:SetWidth(options.size)
			tex:SetHeight(options.size)
			tex:SetVertexColor(options.r, options.b, options.g, options.a)
			
			-- Position texture
			tex:ClearAllPoints()
			if pos == 1 then
				tex:SetTexCoord(0, 1/3, 0, 1/3)
				tex:SetPoint("TOPLEFT", frame, "TOPLEFT", -padding, padding)
			elseif pos == 2 then
				tex:SetTexCoord(2/3, 1, 0, 1/3)
				tex:SetPoint("TOPRIGHT", frame, "TOPRIGHT", padding, padding)
			elseif pos == 3 then
				tex:SetTexCoord(0, 1/3, 2/3, 1)
				tex:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -padding, -padding)
			elseif pos == 4 then
				tex:SetTexCoord(2/3, 1, 2/3, 1)
				tex:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", padding, -padding)
			elseif pos == 5 then
				tex:SetTexCoord(1/3, 2/3, 0, 1/3)
				tex:SetPoint("TOPLEFT", borders[1], "TOPRIGHT")
				tex:SetPoint("TOPRIGHT", borders[2], "TOPLEFT")
			elseif pos == 6 then
				tex:SetTexCoord(1/3, 2/3, 2/3, 1)
				tex:SetPoint("BOTTOMLEFT", borders[3], "BOTTOMRIGHT")
				tex:SetPoint("BOTTOMRIGHT", borders[4], "BOTTOMLEFT")
			elseif pos == 7 then
				tex:SetTexCoord(0, 1/3, 1/3, 2/3)
				tex:SetPoint("TOPLEFT", borders[1], "BOTTOMLEFT")
				tex:SetPoint("BOTTOMLEFT", borders[3], "TOPLEFT")
			elseif pos == 8 then
				tex:SetTexCoord(2/3, 1, 1/3, 2/3)
				tex:SetPoint("TOPRIGHT", borders[2], "BOTTOMRIGHT")
				tex:SetPoint("BOTTOMRIGHT", borders[4], "TOPRIGHT")
			end
		end
		return tex
	end

	local function create_borders(frame, options)
		local borders = { }
		for i = 1, 8 do
			borders[i] = frame:CreateTexture()
		end
		update_borders(frame, options, borders)
		return borders
	end

	local backdrop = {
		bgFile = [[Interface\ChatFrame\ChatFrameBackground]], tile = true, tileSize = 16,
		insets = {left = 3, right = 3, top = 3, bottom = 3},
	}

	local backdrop_empty = {
		bgFile = ''
	}

	local bd_color = { 0, 0, 0, .9 }
	local g_color = { .5, .5, .5, .6 }

	-- Frame methods
	local function SetBorderColor(self, r, g, b)
		for i, x in pairs(self._skin_borders) do
			x:SetVertexColor(r, g, b, 1)
		end
	end
	
	local function SetGradientColor(self, r, g, b, a)
		self.gradient:SetGradientAlpha('VERTICAL', .1, .1, .1, 0, r, g, b, a)
	end
	
	function lib:Gradient(frame)
		local g = frame:CreateTexture(nil, 'BORDER')
		frame.gradient = g
		g:SetTexture[[Interface\ChatFrame\ChatFrameBackground]]
		g:SetPoint('TOPLEFT', 3, -3)
		g:SetPoint('BOTTOMRIGHT', -3, 3)
		g:SetBlendMode'ADD'
		frame.SetGradientColor = SetGradientColor
		frame:SetGradientColor(unpack(g_color))		
	end
	
	function lib:Backdrop(frame)
		frame:SetBackdrop(frame.backdrop or backdrop)
		frame:SetBackdropColor(unpack(bd_color))
	end
	
	-- Lib methods
	-- Basic skin
	function lib:Skin(frame, options)
		-- Store options
		frame._skin_options = meta(options)
		
		-- Apply backdrop
		if options.backdrop ~= false or type(options.backdrop) == 'table' then
			self:Backdrop(frame)
		end
		
		-- Gradient
		if options.gradient ~= false then
			self:Gradient(frame)
		end
		
		-- Borders
		frame._skin_borders = create_borders(frame, options)
		frame.SetBorderColor = SetBorderColor
	end
	
	function lib:SkinRaw(frame, options)
		return create_borders(frame, meta(options)), SetBorderColor
	end
	
	function lib:UpdateSkin(frame, options)
		frame._skin_options = meta(options)
		update_borders(frame, options, frame._skin_borders)
	end
	
	-- Highlights
	local function ShowHighlight(self, status)
		for _, tex in ipairs(self._highlights) do
			tex:Show()
		end
	end
	
	local function HideHighlight(self)
		for _, tex in ipairs(self._highlights) do
			tex:Hide()
		end
	end

	local function SetHighlightColor(self, r, g, b, a)
		for _, tex in ipairs(self._highlights) do
			tex:SetVertexColor(r, g, b, a)
		end
	end
	
	local highlight = { type = 'highlight' }
	
	-- Add highlight borders to a frame
	function lib:Highlight(frame, options)
		-- Default options
		options = meta(options or highlight)
		
		frame._highlights = create_borders(frame, options)
		frame._higlight_options = options

		frame.ShowHighlight = ShowHighlight
		frame.HideHighlight = HideHighlight
		frame.SetHighlightColor = SetHighlightColor
		if options.layer ~= 'HIGHLIGHT' then
			frame:HideHighlight()
		end
	end
	
	function lib:UpdateHighlight(frame, options)
		frame._higlight_options = meta(options)
		update_borders(frame, options, frame._highlights)
	end
end


-- Create a subset of skins to be applied
do
	local function Reskin(self)
		for i, frame in ipairs(self._skinned) do
			lib:UpdateSkin(frame, self._skins[frame._skin])
		end
		for i, frame in ipairs(self._highlighted) do
			lib:UpdateHighlight(frame, self._skins[frame._highlight])
		end
	end
	
	local tinsert = table.insert
	local function Skin(self, frame, name)
		local which = name or self._default_skin
		lib:Skin(frame, self._skins[which])
		frame._skin = which
		tinsert(self._skinned, frame)
	end
	
	local function Highlight(self, frame, name)
		local which = name or self._default_skin
		lib:Highlight(frame, self._skins[which])
		frame._highlight = which
		tinsert(self._highlighted, frame)
	end

	function lib:SetupSkins(owner, skins, default)
		owner._skins = skins
		owner._default_skin = default
		owner._skinned = { }
		owner._highlighted = { }
		
		owner.Reskin = Reskin
		owner.Skin = Skin
		owner.Highlight = Highlight
	end
end

function lib:SkinsFromMasque()
	local LBF = LibStub('LibButtonFacade', true)
	local MSQ = LibStub('Masque', true)
	if LBF or MSQ then
		if not MSQ then MSQ = LBF end
		
		if MSQ.GetSkins then
			-- Add available skins
			-- Failsafe
			local LBF_Skins = MSQ:GetSkins()
			if type(LBF_Skins) == 'table' then
				local out = { }
				for k, v in pairs(LBF_Skins) do
					if k ~= 'Blizzard' and v.Normal.Texture then
						local skin = { }
						-- Guess at dimensions
						if v.Icon.Height and v.Normal.Height then
							skin.padding = (v.Normal.Height - v.Icon.Height) / 4
							skin.row_spacing = v.Icon.Height / 16
							skin.size = v.Icon.Height / 2
						end
						skin.texture = v.Normal.Texture
						skin.name = ('|c22dddd22Masque:|r %s'):format(k)
						out[k] = skin
					end
				end
				return out
			end
		end
	end
end
-- END SKINNING


-- ANCHOR element
do
	local backdrop = { bgFile = [[Interface\Tooltips\UI-Tooltip-Background]] }

	local function OnDragStart(self)
		self:StartMoving()
	end
	
	local function OnDragStop(self)
		self:StopMovingOrSizing()
		self:OnMove(self:GetLeft(), self:GetTop())
	end
	
	local function OnMove(self, x, y)
		if self.sv then
			self.sv[self.key..'_anchor_x'] = x
			self.sv[self.key..'_anchor_y'] = y
		end
	end
	
	local function OnClick(self)
		self.parent:Hide()
	end
	
	local function Show(self)
		self:_Show()
		self:OnToggle(true)
		self:SetHeight(self.height or 20)
	end
	
	local function Hide(self)
		self:_Hide()
		self:OnToggle(false)
		self:SetHeight(1)
	end
	
	local function OnToggle(self, state)
		if self.sv then
			self.sv[self.key..'_anchor_visible'] = state
		end
	end
	
	local function Anchor(self, x, y)
		self:SetPoint('TOPLEFT', UIParent, 'BOTTOMLEFT', x, y)
	end
	
	function lib:CreateAnchor(text, sv, key)
		local anchor = CreateFrame('Button', nil, UIParent)
		anchor:SetBackdrop(backdrop)
		anchor:SetBackdropColor(0, 0, 0, 0.7)
		anchor:SetMovable(true)
		anchor:SetClampedToScreen(true)
		anchor:RegisterForDrag('LeftButton')
		anchor:SetScript('OnDragStart', OnDragStart)
		anchor:SetScript('OnDragStop', OnDragStop)
		anchor.Show, anchor._Show = Show, anchor.Show
		anchor.Hide, anchor._Hide = Hide, anchor.Hide
		anchor:SetAlpha(0.8)
		anchor.Anchor = Anchor
		anchor.OnMove = OnMove
		anchor.OnToggle = OnToggle
		
		local close = CreateFrame('Button', nil, anchor, 'UIPanelCloseButton')
		close:SetScript('OnClick', OnClick)
		close:SetPoint('RIGHT', 1, 0)
		close:SetHeight(20)
		close:SetWidth(20)
		close.parent = anchor
		anchor.close = close

		local label = anchor:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
		label:SetPoint('CENTER', -5, 0)
		label:SetJustifyH('MIDDLE')
		label:SetText(text)
		anchor.label = label
		
		anchor:SetHeight(20)
		anchor:SetWidth(label:GetStringWidth() + 100)
		
		-- Default options method
		if sv and key then
			anchor.sv = sv
			anchor.key = key
			anchor:Anchor(sv[key..'_anchor_x'], sv[key..'_anchor_y'])
			if not sv[key..'_anchor_visible'] then
				anchor:Hide()
			end
		end
		
		return anchor
	end
end
-- END ANCHOR element
-- BUTTON element
do
	local function FitToText(self)
		self:SetWidth(self.label:GetStringWidth() + 30)
	end
	
	function lib:CreateUIButton(frame)
		local name = lib:NewFrameName()
		local button = CreateFrame('Button', name, frame, 'UIPanelButtonTemplate')
		button:SetHeight(24)
		button.label = _G[name..'Text']
		button.FitToText = FitToText
		return button
	end
end
-- END BUTTON element


-- EDITBOX form element
do
	local function Disable(self)
		self:_Disable()
		self:SetTextColor(.6, .6, .6)
	end
	
	local function Enable(self)
		self:_Enable()
		self:SetTextColor(1, 1, 1)
	end
	
	local function GetValue(self)
		return self:GetText()
	end
	
	local function SetValue(self, value)
		self:SetText(value)
	end
	
	local function ClearFocus(self, ...)
		EditBox_ClearFocus(self, ...)
		trigger(self:GetParent(), 'Changed')
	end
	
	function lib:CreateEditbox(frame)
		local edit = CreateFrame('EditBox', lib:NewFrameName(), frame, 'InputBoxTemplate')
		edit:SetScript('OnEnterPressed', ClearFocus)
		edit:SetScript('OnEscapePressed', ClearFocus)
		edit:SetScript('OnEditFocusGained', EditBox_HighlightText)
		edit:SetAutoFocus(false)
		edit:SetHeight(20)
		edit._Disable, edit.Disable = edit.Disable, Disable
		edit._Enable, edit.Enable = edit.Enable, Enable
		edit.GetValue = GetValue
		edit.SetValue = SetValue
		return edit
	end
end
-- END EDITBOX form element


-- RANGE form element
do
	local function Disable(self)
		self:_Disable()
		self.edit:Disable()
	end
	
	local function Enable(self)
		self:_Enable()
		self.label:SetVertexColor(1, .82, 0)
		self.edit:Enable()
	end
	
	local function OnValueChanged(self, value)
		self.edit:SetText(self:GetValue())
		trigger(self:GetParent(), 'Changed')
	end
	
	local function OnEditFocusLost(self)
		self.owner:SetValue(tonumber(self:GetText()))
		trigger(self:GetParent(), 'Changed')
	end
	
	local function GetValue(self)
		return math.floor(self:_GetValue() * 10 + 0.5) / 10
	end
	
	local function SetValue(self, value)
		value = math.max(self.min, math.min(self.max, value))
		self:_SetValue(value)
		self.edit:SetText(value)
	end
	
	function lib:CreateRange(frame, l_low, l_high, v_min, v_max, v_step, e_len)
		local sname = self:NewFrameName()
		local slider = CreateFrame('Slider', sname, frame, 'OptionsSliderTemplate')
		slider:SetPoint('LEFT', 8, 0)
		if v_min and v_max then
			slider:SetMinMaxValues(v_min, v_max)
		end
		if v_step then
			slider:SetValueStep(v_step)
		end
		
		-- Raw entry
		local edit = self:CreateEditbox(frame)
		local len = e_len or 6
		edit:SetPoint('LEFT', slider, 'RIGHT', 15, 0)
		edit:SetWidth(20 + (len*5))
		edit.owner = slider
		
		-- Labels
		local low, high = _G[sname..'Low'], _G[sname..'High']
		label = _G[sname..'Text']
		label.font = GameFontNormal
		label:SetFontObject(label.font)
		low:SetText(l_low)
		high:SetText(l_high)
		
		-- Events
		slider:SetScript('OnValueChanged', OnValueChanged)
		edit:SetScript('OnEditFocusLost', OnEditFocuslost)
		
		slider.edit = edit
		slider.label = label
		slider.label_low = low
		slider.label_high = high
		slider._GetValue, slider.GetValue = slider.GetValue, GetValue
		slider._SetValue, slider.SetValue = slider.SetValue, SetValue
		slider._Disable, slider.Disable = slider.Disable, Disable
		slider._Enable, slider.Enable = slider.Enable, Enable
		slider.min = v_min
		slider.max = v_max
		slider.step = v_step
		
		return slider, label
	end
end
-- END RANGE form element


-- CHECKBOX form element
-- set self.owner to have self.owner:Changed() called on change
do
	local function GetValue(self)
		local checked = self:GetChecked()
		if (checked and not self.invert) or (not checked and self.invert) then
			return true
		end
		return false
	end
	
	local function SetValue(self, value)
		self:SetChecked(self.invert and not value or value)
	end
	
	local function OnClick(self)
		if self:GetChecked() then
			PlaySound('igMainMenuOptionCheckBoxOn');
		else
			PlaySound('igMainMenuOptionCheckBoxOff');
		end
		trigger(self:GetParent(), 'Changed')
	end
	
	function lib:CreateCheckbox(frame, inverted)
		local check = CreateFrame('CheckButton', self:NewFrameName(), frame, 'OptionsBaseCheckButtonTemplate')
		check:SetPoint'LEFT'
		check:SetScript('OnClick', OnClick)
		
		check.GetValue = GetValue
		check.SetValue = SetValue
		return check
	end
end
-- END CHECKBOX form element


-- SELECT form element
do 
	local function Disable(self)
		UIDropDownMenu_DisableDropDown(self.widget)
	end

	local function Enable(self)
		UIDropDownMenu_EnableDropDown(self.widget)
	end

	local function Resize(self)
		local w = self:GetWidth() - 50
		self.middle:SetWidth(w)
		self.button:SetHitRectInsets((w - 15) * -1, 0, 0, 0)
	end
	
	local function get(item)
		if type(item) == 'table' then
			return item.text, item.value
		end
		return item, item
	end
	
	-- Generate cache, and for dynamic menus, items
	local empty = {}
	local function ItemsIndex(widget)
		local items, index = widget.items, widget.index
		if type(items) == 'function' then
			items = items(widget:GetParent())
			wipe(index)
		end
		if items == nil then return empty, index end
		if #index < 1 then
			for i, v in ipairs(items) do
				local _, value = get(v)
				index[value] = i
			end	
		end
		return items, index
	end
	
	local function SetValue(self, value)
		local items, index = ItemsIndex(self.widget)
		if index[value] then
			local text = get(items[index[value]])
			self.text:SetText(text)
		end
		self.value = value
	end
	
	local function GetValue(self)
		return self.value
	end
	
	local function Selected(self, value, owner)
		owner:SetValue(value)
		if owner.callback then
			owner:callback(value)
		end
		trigger(owner:GetParent(), 'Changed')
	end
	
	local info = {}
	local function initialize(self, level)
		local wrapper = self:GetParent()
		local items, index = ItemsIndex(self)
		-- Build menu
		for k, v in ipairs(items) do
			wipe(info)
			local text, value = get(v)
			info.text = text
			info.arg1 = value
			info.arg2 = wrapper
			info.func = Selected
			info.checked = wrapper.value == value
			UIDropDownMenu_AddButton(info, 1)
		end
	end

	
	function lib:CreateSelect(frame, items)
		local wrapper = CreateFrame('frame', nil, frame)
		
		local sname = lib:NewFrameName()
		local widget = CreateFrame('Frame', sname, wrapper, 'UIDropDownMenuTemplate')
		widget:SetPoint('TOPLEFT', wrapper, 'TOPLEFT', -15, -15)
		widget:SetPoint('BOTTOMRIGHT', wrapper, 'BOTTOMRIGHT')
		
		local button, text, middle = _G[sname..'Button'], _G[sname..'Text'], _G[sname..'Middle']
		
		-- Resize widget properly (wtf blizzard, you have the 'RIGHT' point for this)
		widget.middle = middle
		widget.button = button
		widget:SetScript('OnSizeChanged', Resize)
		
		-- Initial cache
		widget.items, widget.index = items, {}
		widget.initialize = initialize
		
		local label = widget:CreateFontString()
		label.font = GameFontNormal
		label:SetFontObject(label.font)
		label:SetPoint('BOTTOMLEFT', widget, 'TOPLEFT', 25, 0)
		label:SetPoint('BOTTOMRIGHT', widget, 'TOPRIGHT')
		label:SetJustifyH'LEFT'
		
		text:SetJustifyH'LEFT'
		text:SetPoint('LEFT', widget, 'LEFT', 26, 0)
		
		wrapper.Disable = Disable
		wrapper.Enable = Enable
		wrapper.SetValue = SetValue
		wrapper.GetValue = GetValue
		wrapper.widget = widget
		wrapper.button = button
		wrapper.label = label
		wrapper.text = text
		
		return wrapper, widget
	end
end
-- END SELECT form element


-- SWATCH form element
do
	local function Color()
		local swatch = ColorPickerFrame.extraInfo
		local r, g, b = ColorPickerFrame:GetColorRGB()
		ColorPickerFrame.extraInfo:SetValue(nil, r, g, b)
		trigger(ColorPickerFrame.extraInfo:GetParent(), 'Changed')
	end
	
	local function Opacity()
		ColorPickerFrame.extraInfo:SetValue(nil, nil, nil, nil, 1 - OpacitySliderFrame:GetValue())
	end
	
	local function Cancel(old)
		ColorPickerFrame.extraInfo:SetValue(old)
		trigger(ColorPickerFrame.extraInfo:GetParent(), 'Changed')
	end
	
	local function OnClick(self, button)
		local cpf = ColorPickerFrame
		cpf:Hide()
		cpf.previousValues = { unpack(self.value) } -- Copy table
		cpf.func = Color
		cpf.cancelFunc = Cancel
		if self.hasOpacity then
			cpf.hasOpacity = true
			cpf.opacityFunc = Opacity
			cpf.opacity = 1 - self.value[4]
		end
		cpf.extraInfo = self
		cpf:SetColorRGB(unpack(self.value))
		cpf:Show() 
	end
	
	local function SetValue(self, value, r, g, b, a)
		local tex = self:GetNormalTexture()
		-- Manual update to eliminate table spam
		if value then
			self.value = value
		else
			if not self.value then self.value = { } end
			if r then
				self.value[1] = r
				self.value[2] = g
				self.value[3] = b
			end
			if self.hasOpacity and a then
				self.value[4] = a
			end
		end
		tex:SetVertexColor(unpack(self.value))
	end
	
	local function GetValue(self)
		return self.value
	end
	
	local function OnEnter(self)
		self.border:SetVertexColor(1, 0.82, 0)
	end
	
	local function OnLeave(self)
		self.border:SetVertexColor(1, 1, 1)
	end
	
	local function Enable(self)
		self:_Enable()
		self.border:SetVertexColor(1, 1, 1)
	end
	
	local function Disable(self)
		self:_Disable()
		self.border:SetVertexColor(.6, .6, .6)
	end
	
	function lib:CreateColorSwatch(frame)
		local swatch = CreateFrame('Button', nil, frame)
		swatch:SetNormalTexture([[Interface\ChatFrame\ChatFrameColorSwatch]])
		swatch:SetWidth(16)
		swatch:SetHeight(16)
		
		local bg = swatch:CreateTexture(nil, 'BACKGROUND')
		bg:SetAllPoints()
		bg:SetTexture([[Interface\ChatFrame\ChatFrameColorSwatch]])
		bg:SetVertexColor(0, 0, 0)
		
		local border = swatch:CreateTexture(nil, 'BACKGROUND')
		border:SetPoint('CENTER')
		border:SetWidth(15)
		border:SetHeight(15)
		border:SetTexture(1, 1, 1)
		
		swatch:SetScript('OnClick', OnClick)
		swatch:SetScript('OnEnter', OnEnter)
		swatch:SetScript('OnLeave', OnLeave)
		swatch._Enable, swatch.Enable = swatch.Enable, Enable
		swatch._Disable, swatch.Disable = swatch.Disable, Disable
		swatch.SetValue = SetValue
		swatch.GetValue = GetValue
		swatch.border = border
		return swatch
	end
end
-- END SWATCH form element
