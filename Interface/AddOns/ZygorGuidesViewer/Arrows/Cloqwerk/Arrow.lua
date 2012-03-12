local ZGV = ZygorGuidesViewer
if not ZGV then return end
local Pointer = ZGV.Pointer

local arrow = ZGV.Pointer:AddArrowSkin("cloqwerk","Cloqwerk")

local arrowframeproto = {}

arrow.features={colordist=true}

arrow.CreateFrame = function(self)
	if not self.frame then
		self.frame = CreateFrame("FRAME","ZygorGuidesViewerPointerArrow_Cloqwerk",ZGV.Pointer.ArrowFrameCtrl,"ZygorGuidesViewerFrame_Arrow_template_cloqwerk")
		self.frame.style = self.id

		for f,fu in pairs(arrowframeproto) do self.frame[f] = fu end

		self.frame:OnLoad()
	end
	return self.frame
end

-- set textures in a button that has its normal/pushed/hilite textures named ntx,ptx,htx  - this was more useful some time ago...
local function SetNPHtx(but,n,p,h)
	assert(but,"How am I to set textures in a nil!?")
	but.ntx:SetTexture(n)
	but.ptx:SetTexture(p or n)
	but.htx:SetTexture(h or n)
end

local function BetterTexCoord(obj,x,w,y,h)
	obj:SetTexCoord((x-1)/w,x/w,(y-1)/h,y/h)
end

local function CreateTexWithCoordsNum(obj,tx,x,w,y,h)
	return CreateTextureWithCoords(obj,tx,(x-1)/w,x/w-(w/h)*0.0004,(y-1)/h,y/h-(w/h)*0.0004)
end


------------ color
local ar,ag,ab = 0.8,0.0,0.0
local br,bg,bb = 0.7,0.6,0.0
local cr,cg,cb = 0.0,1.0,0.3

local msin,mcos,mabs=math.sin,math.cos,math.abs

function arrowframeproto:OnLoad()
	self.arrow:SetTexture(true)
	self.arrow:SetTexture(ZGV.DIR.."\\Arrows\\Cloqwerk\\arrow",false)
	self:Hide()
	self.here:SetTexture(ZGV.DIR.."\\Arrows\\Cloqwerk\\arrow-here",false)
	self.back:SetTexture(ZGV.DIR.."\\Arrows\\Cloqwerk\\arrow-back",false)
	self.gem:SetTexture(ZGV.DIR.."\\Arrows\\Cloqwerk\\arrow-gem",false)
	self.gemhl:SetTexture(ZGV.DIR.."\\Arrows\\Cloqwerk\\arrow-gemhl",false)
end

function arrowframeproto:OnUpdate (elapsed)
end

function arrowframeproto:ShowArrived()
	self.arrow:Hide()
	self.gem:Hide()
	self.gemhl:Hide()

	self.here:Show()
	self.here.zoomy:Play()
	--self.back.turny:Play()
	self.back:SetTexCoord(0,0,0,1,1,0,1,1)
end

function arrowframeproto:ShowTraveling (elapsed,angle,dist)
	self.here:Hide()
	self.back.turny:Stop()
	self.here.zoomy:Stop()

	self.arrow:Show()
	self.gem:Show()
	self.gemhl:Show()
	self.title:Show()

	local profile=ZGV.db.profile

	local perc,tier

	if profile.arrowcolordist then
		if not initialdist then initialdist=dist end
		if initialdist>500 then initialdist=500 end
		if initialdist<100 then initialdist=100 end
		perc=1-(dist/initialdist)
		if perc<0 then perc=0 end
	else
		perc = mabs(1-angle*0.3183)  -- 1/pi  ;  0=target backwards, 1=target ahead
		perc,tier = Pointer.CalculateDirectionTiers(perc,0.0,0.75,0.95,1.0)
	end
	local r,g,b = ZGV.gradient3(perc, ar,ag,ab, br,bg,bb, cr,cg,cb, 0.8)
	self.gem:SetVertexColor(r,g,b)


	------------ rotation of elements

	local msin,mcos,mabs=msin,mcos,mabs

	local sin,cos = msin(angle + 2.356194)*0.85, mcos(angle + 2.356194)*0.85
	self.arrow:SetTexCoord(0.5-sin, 0.5+cos, 0.5+cos, 0.5+sin, 0.5-cos, 0.5-sin, 0.5+sin, 0.5-cos)
	self.gem:SetTexCoord(0.5-sin, 0.5+cos, 0.5+cos, 0.5+sin, 0.5-cos, 0.5-sin, 0.5+sin, 0.5-cos)
	self.gemhl:SetTexCoord(0.5-sin, 0.5+cos, 0.5+cos, 0.5+sin, 0.5-cos, 0.5-sin, 0.5+sin, 0.5-cos)

	------------- background

	local wheelangle = angle*16
	sin,cos = msin(wheelangle + 2.356194)*0.71, mcos(wheelangle + 2.356194)*0.71
	self.back:SetTexCoord(0.5-sin, 0.5+cos, 0.5+cos, 0.5+sin, 0.5-cos, 0.5-sin, 0.5+sin, 0.5-cos)
end

function arrowframeproto:ShowText (title,dist,eta)
	local etatxt = eta and ("%01d:%02d"):format(eta / 60, eta % 60)

	local disttxt
	if dist=="far" then disttxt = (self.waypoint.c>0 and select(self.waypoint.c,GetMapContinents())..", " or "") .. GetMapNameByID(self.waypoint.m)
	elseif type(dist)=="string" then disttxt = self.badfloortxt  eta=nil
	elseif dist>9999998 then disttxt = (self.waypoint.c>0 and select(self.waypoint.c,GetMapContinents())..", " or "") .. GetMapNameByID(self.waypoint.m)
	else  disttxt = ZGV.FormatDistance(dist)
	end

	if eta and eta<7200 and eta>0 then
		etatxt=("%01d:%02d"):format(eta / 60, eta % 60)
	else
		etatxt=nil
	end

	self.title:SetText( (title and "|cffffffff"..title.."|r\n" or "") .. (disttxt and "|cffffcc00"..disttxt.."|r" or "") .. (etatxt and "  |cffff7700"..etatxt.."|r" or "") )
end

function arrowframeproto:ShowWarning()
	UIFrameFlash(self.gem,0.2,0.2,0.2, true,0,0)
end

function arrowframeproto:OnMouseWheel(delta)
	if IsControlKeyDown() then
		ZGV.db.profile.arrowscale = ZGV.db.profile.arrowscale + delta * 0.2
		if ZGV.db.profile.arrowscale<0.4 then ZGV.db.profile.arrowscale=0.4 end
		self:SetScale(ZGV.db.profile.arrowscale)
	end
end
