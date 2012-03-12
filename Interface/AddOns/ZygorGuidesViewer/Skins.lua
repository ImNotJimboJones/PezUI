local ZGV = ZygorGuidesViewer
if not ZGV then return end

ZGV.Skins = {}

local function Skin_AddStyle(skin,id,name)
	if not id then id="style" end
	local style={id=id or "style",name=name or "default"}
	skin.styles[id]=style
	return style
end

local function _new_skin(id,name)
	local skin = {id=id or "skin", name=name or "unnamed skin",styles={}, AddStyle=Skin_AddStyle}
	return skin
end

function ZGV:AddSkin(id,name)
	local skin = _new_skin(id,name)
	self.Skins[id] = skin
	return skin
end

function ZGV:GetSkinPath(skin,style)
	if not skin then skin=self.db.options.skin end
	if not style then style=self.db.options.skinstyle end
	return ZGV.DIR .. "\\Skins\\" .. skin .. "\\" .. style .. "\\"
end

function ZGV:SetSkin(skin,style)
	-- no style? grab default
	if not skin then
		skin = next(self.Skins)
		assert(skin,"No skin to fall back to!")
		return self:SetSkin(skin)
	end
	local skindata = self.Skins[skin]
	if not skindata then
		ZGV:Print("Unknown skin '"..skin.."', falling back to default")
		return self:SetSkin()
	end
	-- skin,skindata accounted for
	if not style then
		style = next(skindata.styles)
		if not style then
			ZGV:Print("No styles in skin "..skin..", falling back to default skin")
			return self:SetSkin()
		end
	end
	local styledata=skindata.styles[style]
	if not styledata then
		ZGV:Print("Unknown style "..style.." in skin "..skin..", falling back to default style")
		return self:SetSkin(skin)
	end
	-- style,styledata accounted for. WHEW.
		
	self.db.profile.skin = skin
	self.db.profile.skinstyle = style

	self.CurrentSkin = skindata
	self.CurrentSkinStyle = styledata
	self.SkinDir = self:GetSkinPath(skin,style)

	skindata:CreateFrame()
end