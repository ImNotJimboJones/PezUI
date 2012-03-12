local ZGV = ZygorGuidesViewer
if not ZGV then return end

local Pointer = ZGV.Pointer

local arrow = ZGV.Pointer:AddArrowSkin("midnight","Midnight")

local arrowframeproto = {}

arrow.features={colordist=false}

function arrow:CreateFrame()
	if not self.frame then
		self.frame = CreateFrame("FRAME","ZygorGuidesViewerPointerArrow_Midnight",ZGV.Pointer.ArrowFrameCtrl,"ZygorGuidesViewerFrame_Arrow_template_midnight")
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
local ar,ag,ab = 0.60,0.60,0.60
local br,bg,bb = 0.95,0.95,0.95
local cr,cg,cb = 1.00,1.00,1.00

local msin,mcos,mabs,mfloor=math.sin,math.cos,math.abs,math.floor

function arrowframeproto:OnLoad()
	local skindir = ZGV.DIR.."\\Arrows\\Midnight"
	self.arrow:SetTexture(true)
	self.arrow:SetTexture(skindir.."\\arrow",false)
	self.back:SetAlpha(0.8)
	self:Hide()
	self.here:SetTexture(skindir.."\\arrow-here",false)
	self.back:SetTexture(skindir.."\\arrow-back",false)
	self.precise:SetTexture(skindir.."\\arrow-precise",false)
end

function arrowframeproto:OnUpdate (elapsed)
end

function arrowframeproto:ShowArrived()
	self.arrow:Hide()
	self.precise:Hide()

	self.here:Show()
	self.here.zoomy:Play()
	self.back:SetTexCoord(0,0,0,1,1,0,1,1)

	self.arrow.upstairs:Stop()
	self.arrow.downstairs:Stop()
end

local precspan = 0.2

function arrowframeproto:ShowTraveling (elapsed,angle,dist)
	self.here:Hide()
	self.here.zoomy:Stop()

	self.arrow:Show()
	self.precise:Show()
	self.title:Show()

	self.arrow.upstairs:Stop()
	self.arrow.downstairs:Stop()

	local profile=ZGV.db.profile

	local perc,tier

	local spangood,spanperf=0.10,0.02
	--if dist<500 then local mul=1-(dist/500)  mul=mul*mul*mul*mul*mul  spangood,spanperf = spangood+spangood*mul,spanperf+spanperf*mul  end

	perc = mabs(1-angle*0.3183)  -- 1/pi  ;  0=target backwards, 1=target ahead
	perc,tier = Pointer.CalculateDirectionTiers(perc,1-spangood,1-spangood+0.02,1-spanperf,1)

	local r,g,b = ZGV.gradient3(perc, ar,ag,ab, br,bg,bb, cr,cg,cb, 1)
	self.arrow:SetVertexColor(r,g,b)


	------------ rotation of elements

	self.arrow.turn.anim:SetRadians(angle)
	self.arrow.turn:Play()

	if perc>0.5 and self.precise.turn then
		-- precision dot
		local precangle = angle
		if precangle>3.141592 then precangle=precangle-6.283185 end
		precangle = precangle * 8  -- precision!
		while precangle>6.283185 do precangle=precangle-6.283185 end
		while precangle<0 do precangle=precangle+6.283185 end

		self.precise:SetAlpha((perc-0.5)*4)
		self.precise.turn.anim:SetRadians(precangle)
		self.precise.turn:Play()
	else
		self.precise:SetAlpha(0)
	end

	--[[
	local msin,mcos,mabs=msin,mcos,mabs

	local sin,cos = msin(angle + 2.356194)*0.85, mcos(angle + 2.356194)*0.85
	self.arrow:SetTexCoord(0.5-sin, 0.5+cos, 0.5+cos, 0.5+sin, 0.5-cos, 0.5-sin, 0.5+sin, 0.5-cos)
	--]]

end

function arrowframeproto:ShowStairs(up)
	self.precise:Hide()
	self.here:Hide()
	self.arrow:Show()
	if up then
		self.arrow.downstairs:Stop()
		self.arrow.upstairs:Play()
	else
		self.arrow.upstairs:Stop()
		self.arrow.downstairs:Play()
	end
end

function arrowframeproto:ShowText (title,dist,eta)
	local etatxt = ""
	
	assert(self.waypoint,"Arrow with no waypoint")
	assert(self.waypoint.c,"Waypoint has no continent")
	assert(self.waypoint.m,"Waypoint has no map")

	self.stairs=false

	local disttxt
	if dist=="far" then disttxt = (self.waypoint.c>0 and (select(self.waypoint.c,GetMapContinents()) or "?")..", " or "") .. (GetMapNameByID(self.waypoint.m) or "(map "..self.waypoint.m..")")  eta=nil
	elseif type(dist)=="string" then disttxt = self.badfloortxt  eta=nil
	elseif dist>9999998 then disttxt = (self.waypoint.c>0 and (select(self.waypoint.c,GetMapContinents()) or "?")..", " or "") .. (GetMapNameByID(self.waypoint.m) or "(map "..self.waypoint.m..")")
	else  disttxt = ZGV.FormatDistance(dist)
	end
	

	if eta and eta<7200 and eta>0 then
		local time=GetTime()
		time=time-mfloor(time)
		local etacolor = (eta<10 and time>0.7) and "ffff7700" or "ffffbb00"
		etatxt = ("  |c"..etacolor.."%01d:%02d|r"):format(eta / 60, eta % 60)
	end

	local distcolor
	if type(dist)=="number" then
		if not Pointer.initialdist then Pointer.initialdist=dist end
		if Pointer.initialdist>500 then Pointer.initialdist=500 end
		if Pointer.initialdist<100 then Pointer.initialdist=100 end
		local perc=1-(dist/Pointer.initialdist)
		if perc<0 then perc=0 end
		local r,g,b = ZGV.gradient3(perc, 1.0,0.5,0.4, 1.0,0.9,0.5, 0.7,1.0,0.6, 0.7)
		distcolor = ("|cff%02x%02x%02x"):format(r*255,g*255,b*255)
	else
		distcolor = "|cffffff00"
	end

	self.title:SetText( (title and "|cffffffff"..title.."|r\n" or "") .. (disttxt and distcolor..disttxt.."|r" or "") .. etatxt )
end

function arrowframeproto:ShowWarning()
	UIFrameFlash(self.arrow,0.2,0.2,0.2, true,0,0)
end

function arrowframeproto:OnMouseWheel(delta)
	if IsControlKeyDown() then
		ZGV.db.profile.arrowscale = ZGV.db.profile.arrowscale + delta * 0.2
		if ZGV.db.profile.arrowscale<0.4 then ZGV.db.profile.arrowscale=0.4 end
		self:SetScale(ZGV.db.profile.arrowscale)
	end
end
