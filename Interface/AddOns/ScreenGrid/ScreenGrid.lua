local bs = 0
local CSG = CreateFrame('Frame', nil, UIParent)
local CSG_bs

SLASH_SCREENGRID1 = "/screengrid"
SlashCmdList["SCREENGRID"] = function(arg)
	if arg == '' then
		bs = 0
	else
        bs = (math.ceil((tonumber(arg) or bs) / 4) * 4)
		if bs > 512 then
			bs = 512
		end
	end
		if CSG_bs ~= bs then
			CSG:Hide(self)
			CSG_doDraw(self)
			CSG:Show(self)
		end
end

function CSG_doDraw(self)

	CSG_bs = bs
	CSG = CreateFrame('Frame', nil, UIParent)
	CSG:SetAllPoints(UIParent)
	local w = GetScreenWidth()
	local r = w/GetScreenHeight()
	local h = GetScreenHeight()
	local wI = w/bs
	local hI = h*r/bs

	if bs > 0 then
		for i = 0, bs do
			local line = CSG:CreateTexture(nil, 'BACKGROUND')
			line:SetTexture(0, 0, 0, 0.5)
			line:SetPoint("TOPLEFT", CSG, "TOPLEFT", i*wI - 1, 0)
			line:SetPoint('BOTTOMRIGHT', CSG, 'BOTTOMLEFT', i*wI + 1, 0)
		end

		for i = 0, math.floor((h/2)/hI) do
			local line = CSG:CreateTexture(nil, 'BACKGROUND')
			line:SetTexture(0, 0, 0, 0.5)
			line:SetPoint("TOPLEFT", CSG, "TOPLEFT", 0, -(h/2+i*hI) + 1)
			line:SetPoint('BOTTOMRIGHT', CSG, 'TOPRIGHT', 0, -(h/2+i*hI + 1))
			local line = CSG:CreateTexture(nil, 'BACKGROUND')
			line:SetTexture(0, 0, 0, 0.5)
			line:SetPoint("TOPLEFT", CSG, "TOPLEFT", 0, -(h/2-i*hI) + 1)
			line:SetPoint('BOTTOMRIGHT', CSG, 'TOPRIGHT', 0, -(h/2-i*hI + 1))
		end
	end
end
