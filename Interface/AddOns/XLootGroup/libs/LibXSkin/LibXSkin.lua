local lib = LibStub:NewLibrary("X-Skin", "1.v1.4.1")
if not lib then return nil end
local wprint, print = print, print

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

--TODO: Move back to XLoot
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
