local ZGV=ZygorGuidesViewer
if not ZGV then return end

local Pointer = {}
ZGV.Pointer = Pointer

local _G,assert,table,string,tinsert,tonumber,tostring,type,ipairs,pairs,setmetatable,math,wipe = _G,assert,table,string,tinsert,tonumber,tostring,type,ipairs,pairs,setmetatable,math,wipe

local L=ZGV.L

Pointer.Debug = ZGV.Debug

Pointer.waypoints = {}

Pointer.antphase=0

Astrolabe = DongleStub("Astrolabe-1.0")

local unusedMarkers = {}


local last_distance=0
local speed=0
local last_speed=0

local initialdist=nil

local lastminimapdist=99999
local minimapcontrol_suspension=0
local minimap_lastset = 0

local cuedinged=nil

local profile={}

local inscale = 300
local MinimapSize = {
	indoor = {
		[0] = inscale, -- scale
		[1] = inscale*0.8, -- 1.25
		[2] = inscale*0.6, -- 5/3
		[3] = inscale*0.4, -- 2.5
		[4] = inscale*0.26666,  -- 3.75
		[5] = inscale*0.16666,  -- 6
	},
	outdoor = {
		[0] = 466 + 2/3, -- scale
		[1] = 400,       -- 7/6
		[2] = 333 + 1/3, -- 1.4
		[3] = 266 + 2/6, -- 1.75
		[4] = 200,       -- 7/3
		[5] = 133 + 1/3, -- 3.5
	},
}

local submap_cache = nil
		
local function AstrolabeFixZones(za,zb)
	if Astrolabe.WorldMapSize and Astrolabe.WorldMapSize[za].system==za then Astrolabe.WorldMapSize[za]=Astrolabe.WorldMapSize[zb] end
end


Pointer.MapFloors = {}  setmetatable(Pointer.MapFloors,{__index=function(self,id) return rawget(self,id) or 0 end})

function Pointer:CacheFloors()
	local mapfloors = self.MapFloors
	for id=1,1000 do
		if GetMapNameByID(id) then
			SetMapByID(id)
			local l = GetNumDungeonMapLevels()
			if l>0 then mapfloors[id] = l end
		end
	end
	SetMapToCurrentZone()
end

function Pointer:Startup()
	profile = ZGV.db.profile

	profile.arrowsmooth = true

	self:CacheFloors()  -- universal, used NOT only by the internal pointer.

	self:SetArrowSkin(profile.arrowskin)

	--[[
	self.EventFrame = CreateFrame("FRAME")
	self.EventFrame:Show()
	self.EventFrame:SetScript("OnEvent",PointerEventFrame_OnEvent)
	self.EventFrame:RegisterEvent("WORLD_MAP_UPDATE")
	--]]

	local overlay = CreateFrame("FRAME","ZygorGuidesViewerPointerOverlay",WorldMapButton)
	self.OverlayFrame = overlay
	overlay:SetAllPoints(true)
	overlay:SetWidth(1002)
	overlay:SetHeight(668)
	--overlay:SetFrameStrata("DIALOG")
	--overlay:SetFrameLevel(WorldMapButton:GetFrameLevel()+1)
	overlay:SetScript("OnEvent",self.Overlay_OnEvent)
	overlay:RegisterEvent("PLAYER_ENTERING_WORLD")
	overlay:RegisterEvent("PLAYER_ALIVE")
	overlay:RegisterEvent("PLAYER_UNGHOST")
	overlay:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	overlay:RegisterEvent("WORLD_MAP_UPDATE")
	ZGV:ScheduleRepeatingTimer(function()  if not WorldMapFrame:IsVisible() then SetMapToCurrentZone() end  end, 10.0)   -- to help the current zone cache

	--overlay:EnableMouse(true)
	--overlay:SetScript("OnMouseUp",self.Overlay_OnClick)
	overlay:SetScript("OnUpdate",self.Overlay_OnUpdate)
	--hooksecurefunc("WorldMapButton_OnClick",ZGV.Pointer.hook_WorldMapButton_OnClick)

	--[[
	local texture = overlay:CreateTexture("ZygorGuidesViewerPointerOverlayTexture","OVERLAY")
	texture:SetAllPoints(true)
	--texture:SetTexture(ZGV.DIR .. "\\Maps\\deadmines")
	texture:SetTexCoord(0,0.975,0,0.65)
	texture:Hide()
	overlay.texture = texture

	local youarehere = overlay:CreateTexture("ZygorGuidesViewerPointerOverlayYouarehere","OVERLAY")
	youarehere:SetTexture(ZGV.DIR .. "\\Skins\\minimaparrow-green-dot")
	overlay.youarehere = youarehere
	--]]

	self:UpdateArrowVisibility()

	--hooksecurefunc("WorldMapFrame_OnShow",ZGV.Pointer.hook_WorldMapFrame_OnShow)


	--WorldMapFrame.PlayerCoord = WorldMapFrame:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	--WorldMapFrame.CursorCoord = WorldMapFrame:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	
	--WorldMapFrame.PlayerCoord:SetText("Player")
	--WorldMapFrame.CursorCoord:SetText("Cursor")

	--ZGV.ScheduleRepeatingTimer(self,"FixMapLevel", 1.0)

	-- try to fix Astrolabe zoning problems...
	AstrolabeFixZones(770,700) --twilight
	AstrolabeFixZones(700,770)
	AstrolabeFixZones(539,545) --gilneas
	AstrolabeFixZones(545,539)
	AstrolabeFixZones(678,679)
	AstrolabeFixZones(679,678)
	AstrolabeFixZones(544,681)
	AstrolabeFixZones(682,681)
	AstrolabeFixZones(681,682)

	self:SetMinimapPlayerTexture()

	self.ready = true
end


Pointer.Icons = {
	greendot = { icon=ZGV.DIR.."\\Skins\\minimaparrow-green-dot", size=40, minisize=25, rotates=false, edgeicon=ZGV.DIR.."\\Skins\\minimaparrow-green-edge", edgesize=60, spinner=true },
	arrow = { icon=ZGV.DIR.."\\Skins\\minimaparrow-path", size=70, minisize=60, rotates=true, edgeicon=ZGV.DIR.."\\Skins\\minimaparrow-path", edgesize=50 },
	ant = { icon=ZGV.DIR.."\\Skins\\minimaparrow-ant", desat=true, alpha=0.8, size=30, minisize=25, rotates=false, edgeicon=nil, edgesize=1 }
}



--[[
local numlevels=0
local oldlevel=1
function Pointer.FixMapLevel()
	local x,y = GetPlayerMapPosition("player")
	if x<=0 and y<=0 then
		-- perhaps wrong floor indeed.
		numlevels = GetNumDungeonMapLevels()
		if numlevels>1 then
			oldlevel = GetCurrentMapDungeonLevel()
			for lev=1,numlevels do
				if lev~=oldlevel and GetPlayerMapPosition("player")>0 then
					GetCurrentMapDungeonLevel()
			end
		end
end
--]]

--[[
	data elements:
	title - guess
	type - 'way' 'poi' 'manual' 'corpse' 'path'
	icon - texture path
	onminimap - 'always' 'zone'
	overworld - show on world map
	persistent - don't hide when arrived at
--]]
local function add_default_data(data)
	if not data then data={} end
	if not data.title then data.title="Waypoint" end
	if not data.type then data.type="way" end
	if not data.icon then data.icon=Pointer.Icons.greendot end
	return data
end

local phasedBases={}
local phasedMaps = {
	[539]=1, -- Gilneas
	[545]=1,
	[678]=1,
	[679]=1,
	[606]=2, -- Mount Hyjal
	[683]=2,
	[544]=3, -- The Lost Isles
	[681]=3,
	[682]=3,
	[737]=4, -- The Maelstrom
	[751]=4,
	[700]=5, -- Twilight Highlands
	[770]=5,
	[720]=6, -- Uldum
	[748]=6,
	[697]=7, -- Zul'Gurub
	[793]=7
} -- TODO expand as per need

-- initialize phase bases with... something from the phase maps. This might suck, beware.
for map,num in pairs(phasedMaps) do phasedBases[num]=phasedBases[num] or map end

function Pointer:IsEnvironmentPhased(target_map)
	-- Assumption: if the player is/was in a map which is known to be phased, the best fit map is the current one
	-- WARNING Blizz works in mysterious ways. If something's broken with phased terrain corpse display, please look here
	-- keywords: worgen arrow not working qq 
	
	-- No no no! Such extensive setmapping seems to cause lag...
	--[[
	local _mm,_ff=GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
	SetMapToCurrentZone()
	local mm,ff=GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
	SetMapByID(_mm) SetDungeonMapLevel(_ff)
	--]]
	local mm=ZGV.CurrentMapID
	if mm then 
		return phasedMaps[mm] and phasedMaps[target_map]==phasedMaps[mm]
	end
end

-- Save this map as its group's base phase. Do it with map ids obtained fresh from GetCurrentMapAreaID() calls, NEVER from any ID you happen to think of.
function Pointer:SetBasePhase(map)
	local group = phasedMaps[map]
	if not group then return end
	phasedBases[group] = phasedBases[group] and map
end


function Pointer:SetWaypoint (m,f,x,y,data,arrow)
	data = add_default_data(data)
	
	-- Halt, Resetzeit!
	--[[
	local _mm,_ff=GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
	SetMapToCurrentZone()
	local mm,ff=GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
	SetMapByID(_mm) SetDungeonMapLevel(_ff)
	--]]
	
	-- Let's see if this is evil. If current map is phased, remember it and use it to de-phase other maps of the same group.
	local mapm,mapf = GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
	self:SetBasePhase(mapm)  -- Assuming nobody in their right mind is viewing a wrong-phase map.
	
	if not m then
		m,f=mapm,mapf  -- Use fresh values, NOT the cached crap. No map means put markers on CURRENTLY DISPLAYED map, not the player's current.
	else
		m=phasedBases[phasedMaps[m] or 0] or m  -- de-phase map!
	end

	--[[
	local phased=self:IsEnvironmentPhased(m)
	if not m or phased then
		if data.type~="ant" then
			ZGV:Debug("The player and the target are in the same phased environment, putting a marker on the current map instead.")
		end
		--m,f=mm,ff
	end
	--]]

	-- moved to Parser.lua
	--if self.MapFloors[m]>0 then f=max(1,f or 0) end  -- if there are floors, f>=1. Otherwise, f==0.

	local waypoint = self:CreateMapMarker (m,f or 0,x,y,data)

	--ZGV:Debug("Adding waypoint type "..data.type.." in "..c..","..z..","..x..","..y)

	if not waypoint then return end

	waypoint.t=data.title
	waypoint.type=data.type
	waypoint.angle=data.angle
	
	local icon = data.icon
	waypoint.minimapFrame.icon:SetTexture(icon.icon)
	waypoint.minimapFrame.icon:SetRotation(icon.rotates and data.angle or 0)
	waypoint.minimapFrame.icon:SetSize(icon.minisize,icon.minisize)
	waypoint.minimapFrame.icon:SetDesaturated(icon.desat)
	waypoint.minimapFrame.icon:SetAlpha(icon.alpha or 1)
	waypoint.minimapFrame.arrow:SetTexture(icon.edgeicon)
	waypoint.minimapFrame.arrow:SetSize(icon.edgesize,icon.edgesize)
	waypoint.worldmapFrame.icon:SetTexture(icon.icon)
	waypoint.worldmapFrame.icon:SetRotation(icon.rotates and data.angle or 0)
	waypoint.worldmapFrame.icon:SetSize(icon.size,icon.size)
	waypoint.worldmapFrame.icon:SetDesaturated(icon.desat)
	waypoint.worldmapFrame.icon:SetAlpha(icon.alpha or 1)
	--if icon.spinner then waypoint.worldmapFrame.spinner:Show() else waypoint.worldmapFrame.spinner:Hide() end
	waypoint.worldmapFrame.spinner:Hide()

	Pointer.MinimapButton_OnUpdate(waypoint.minimapFrame,1000)

	if arrow==nil then arrow=true end
	if arrow and (waypoint.type=="manual" or waypoint.type=="way" or waypoint.type=="corpse") then
		self:ShowArrow(waypoint)
	end



	tinsert(self.waypoints,waypoint)
	
	if waypoint and data.type~="ant" then ZGV:Debug("Waypoint set to map:"..waypoint.m.." floor:"..waypoint.f) end

	return waypoint
end

function Pointer:CreateMapMarker (m,f,x,y,data)
	--ZGV:Debug("Internal CreateMapMarker: "..tostring(c).." "..tostring(z).." "..tostring(x).." "..tostring(y).." "..tostring(title))
	if not m and not f then
		m,f = GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
	end
	--ZGV:Debug("Internal CreateMapMarker nums: "..tostring(c).." "..tostring(z).." "..tostring(x).." "..tostring(y).." "..tostring(title))

	if not m or not f or not x or x<0 or not y or y<0 then
		ZGV:Debug(("CreateMapMarker bailing out; m=%s f=%s x=%s y=%s"):format(tostring(m),tostring(f),tostring(x),tostring(y)))
		return
	end

	if x>1 or y>1 then
		x=x/100
		y=y/100
	end

	local waypoint = self:GetMarker()
	local c = self.ContinentsByID[m] or -1
	table.zygor_join(waypoint,{ m=m,f=f,x=x,y=y, c=c })
	table.zygor_join(waypoint,data)
	-- TODO: add callbacks for distance detection

	waypoint.minimapFrame.waypoint = waypoint
	waypoint.worldmapFrame.waypoint = waypoint

	waypoint.minimapFrame:EnableMouse(not data.passive)
	waypoint.worldmapFrame:EnableMouse(not data.passive)

	local lm,lf = GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
	waypoint:UpdateWorldMapIcon(lm,lf)
	waypoint:UpdateMiniMapIcon(lm,lf)

	--if lc==c and lz==z then Astrolabe:PlaceIconOnMinimap(waypoint.minimapFrame, c, z, x, y) end
	
	return waypoint
end

function Pointer:ClearWaypoints (waytype)
	local n=0
	local w=1
	while w<=#self.waypoints do
		if not waytype or self.waypoints[w].type==waytype then
			n=n+1
			self:RemoveWaypoint(w)
		else
			w=w+1
		end
	end
	return n
end

function Pointer:RemoveWaypoint(waypoint)
	local wayn
	if type(waypoint)=="number" then  wayn=waypoint  waypoint=self.waypoints[wayn]  end
	if not wayn then for w=1,#self.waypoints do if self.waypoints[w]==waypoint then wayn=w end end end
	assert(wayn,"No waypoint number")
	assert(waypoint,"Waypoint not found")
	Astrolabe:RemoveIconFromMinimap(waypoint.minimapFrame)
	waypoint.minimapFrame:Hide()
	waypoint.minimapFrame.waypoint=nil
	waypoint.worldmapFrame:Hide()
	waypoint.worldmapFrame.waypoint=nil

	if self.ArrowFrame.waypoint==waypoint then self:HideArrow() end
	for k,v in pairs(waypoint) do if k~="minimapFrame" and k~="worldmapFrame" then waypoint[k]=nil end end
	table.insert(unusedMarkers, waypoint)
	table.remove(self.waypoints,wayn)
end

function Pointer:HideArrow()
	self.ArrowFrame.waypoint = nil
	self:ResetMinimapZoom() -- to perhaps reset the zoom
	--self.ArrowFrame:Hide()
end

function Pointer:ShowArrow(waypoint)
	if not waypoint then return self:HideArrow() end
	--if waypoint.type~="manual" then self:ClearWaypoints("manual") end

	-- fix for "arrow stuck to cursor", probably
	ZygorGuidesViewerPointer_ArrowCtrl:StopMovingOrSizing()
	self.ArrowFrame.dragging=nil

	Astrolabe:PlaceIconOnMinimap(waypoint.minimapFrame, waypoint.m, waypoint.f, waypoint.x, waypoint.y) -- if it's not already there, place it

	self.ArrowFrame.waypoint = waypoint

	last_distance=0
	speed=0
	lastbeeptime=GetTime()+3
	cuedinged=nil

	initialdist = nil
	lastminimapdist=99999

	--self.ArrowFrame.temporarilyhidden = true
	--self.ArrowFrame:Show()
end

--[[
function Pointer:GetWaypointBearings(way)
	--local dx,dy = 
	if type(way)==number then way=self.waypoints[way] end

end
--]]

local markerproto = {}
local markermeta = {__index=markerproto}
local nummarkers=0

function Pointer:GetMarker()
	local marker = table.remove(unusedMarkers)
	if marker then return marker end

	-- create a new marker
	marker = {visible=true}
	setmetatable(marker,markermeta)

	nummarkers=nummarkers+1
	marker.minimapFrame = CreateFrame("Button", "ZGVMarker"..nummarkers.."Mini", Minimap, "ZygorGuidesViewerPointerMinimapMarker")
	marker.minimapFrame.isZygorWaypoint=true -- marking the marker to be protected by substituted Minimap:GetChildren() call. Pun intended.
	--marker.minimapFrame.icon:SetTexture(ZGV.DIR.."Arrows\\Cloqwerk\\minimaparrow-green-dot")
	--marker.minimapFrame.arrow:SetTexture(ZGV.DIR.."Arrows\\Cloqwerk\\minimaparrow-green-edge")
	marker.worldmapFrame = CreateFrame("Button", "ZGVMarker"..nummarkers.."World", self.OverlayFrame, "ZygorGuidesViewerPointerWorldMapMarker")
	--marker.worldmapFrame.icon:SetTexture(ZGV.DIR.."Arrows\\Cloqwerk\\minimaparrow-green-dot")

	return marker
end

function markerproto:Hide()
	self.minimapFrame:Hide()
	self.worldmapFrame:Hide()
	self.visible = false
end

function markerproto:Show()
	self.minimapFrame:Show()
	self.worldmapFrame:Show()
	self.visible = true
end

function markerproto:UpdateWorldMapIcon(m,f)
	local show=true

	if GetCurrentMapZone()==0 and GetCurrentMapContinent()>=0 then
		-- it's world map all right.
		if self.type=="ant" then
			show=false
		else
			self.worldmapFrame:EnableMouse(false)
			local halfsize = self.icon.size/2
			self.worldmapFrame.icon:SetSize(halfsize,halfsize)
		end
	else
		self.worldmapFrame:EnableMouse(not self.passive)
		local fullsize = self.icon.size
		self.worldmapFrame.icon:SetSize(fullsize,fullsize)
	end

	if not ZGV.Pointer.OverlayFrame:IsShown() or self.hidden then show=false end

	if not m then m,f=GetCurrentMapAreaID(),GetCurrentMapDungeonLevel() end

	if show and not self.overworld then
		if self.m~=m then show=false end
	end

	if show and self.m==m and self.f~=f then
		-- same map, wrong floor. HIDE it.
		show=false
	end
	
	if show then
		local x,y = Astrolabe:PlaceIconOnWorldMap(ZGV.Pointer.OverlayFrame, self.worldmapFrame, self.m, self.f, self.x, self.y)
		if not x or not y or x<0 or y<0 or x>1 or y>1 then
			show=false
		end
	end

	if show then
		self.worldmapFrame:Show()
		--self.worldmapFrame.icon:ClearAllPoints()
		--self.worldmapFrame.icon:SetAllPoints()
		--ZGV:Print("Showing "..way.title)
	else
		self.worldmapFrame:Hide()
	end
end

function markerproto:UpdateMiniMapIcon(m,f)
	if not m then m,f=GetCurrentMapAreaID(),GetCurrentMapDungeonLevel() end
	if profile.minicons and not self.hidden and 
	(
	 self.onminimap=="always" or 
	 ZGV.Pointer.ArrowFrame.waypoint==self or
	 ((self.onminimap=="zone" or self.onminimap=="zonedistance") and m==self.m)
	) then
		local r = Astrolabe:PlaceIconOnMinimap(self.minimapFrame, self.m, self.f, self.x, self.y)
	else
		Astrolabe:RemoveIconFromMinimap(self.minimapFrame)
	end
end



-----------------------------------------------------------------------
--[[
do
	local lastx,lasty
	local x,y,zone
	function Pointer:GetPlayerPosition()
		local x,y = GetPlayerMapPosition("player")
	end
end

function Pointer:GetDistFromPlayer(c,z,x,y)
	local pc,pz,px,py

	local px, py = GetPlayerMapPosition("player")
	px, py, pzone = self:GetCurrentPlayerPosition()
	if pzone then
		pzone = BZL[pzone]
	end

	if px == 0 or py == 0 or not px or not py then
		return nil
	end
	if pzone and BZH[pzone] then
		pzone = BZL[pzone]
	end
	if zone and BZH[zone] then
		zone = BZL[zone]
	end
	if not zone then
		zone = GetRealZoneText()
	end
	if not pzone then
		pzone = zone
	end
	local dist = Tourist:GetYardDistance(zone, x, y, pzone, px, py)
	return dist
end
--]]


-- Code taken from HandyNotes, thanks Xinhuan
---------------------------------------------------------
-- Public functions for plugins to convert between MapFile <-> C,Z
--

--[[
local continentMapFile = {
	[WORLDMAP_COSMIC_ID] = "Cosmic", -- That constant is -1
	[0] = "World",
	[1] = "Kalimdor",
	[2] = "Azeroth",
	[3] = "Expansion01",
	[scarlet_cont] = "ScarletEnclave",
}
local reverseMapFileC = {}
local reverseMapFileZ = {}
for C in pairs(Astrolabe.ContinentList) do
	for Z = 1, #Astrolabe.ContinentList[C] do
		local mapFile = Astrolabe.ContinentList[C][Z]
		reverseMapFileC[mapFile] = C
		reverseMapFileZ[mapFile] = Z
	end
end
for C = -1, 3 do
	local mapFile = continentMapFile[C]
	reverseMapFileC[mapFile] = C
	reverseMapFileZ[mapFile] = 0
end
--]]

--[[
function Pointer:GetMapFile(C, Z)
	if type(C)=="string" then return end
	if not C or not Z then return end
	if Z == 0 then
		return continentMapFile[C]
	elseif C > 0 then
		return Astrolabe.ContinentList[C][Z]
	end
end
function Pointer:GetCZ(mapFile)
	return reverseMapFileC[mapFile], reverseMapFileZ[mapFile]
end
--]]

local function FormatDistance(dist)
	if profile.arrowmeters then
		local mdist = dist * 0.9144
		if mdist>1000 then
			return ("%.1f km"):format(mdist/1000)
		else
			return ("%d m"):format(mdist)
		end
	else
		if dist>1760 then
			return ("%.1f mil"):format(dist/1760)
		else
			return ("%d yd"):format(dist)
		end
	end
end
ZGV.FormatDistance=FormatDistance

---------------
function Pointer:CreateArrowFrame()
	if not self.ArrowFrameCtrl then
		self.ArrowFrameCtrl = ZygorGuidesViewerPointer_ArrowCtrl
		self.ArrowFrameCtrl:SetScript("OnUpdate",self.ArrowFrameControl_OnUpdate)
		--self.ArrowFrameCtrl:SetPoint("CENTER",UIParent,"BOTTOMLEFT",ZGV.db.profile.arrowposx,ZGV.db.profile.arrowposy)
		--self.ArrowFrameCtrl:SetMovable(1)
		--self.ArrowFrameCtrl:Show()
	end

	if not self.CurrentArrowSkin then
		self:SetArrowSkin(ZGV.db.profile.arrowskin)
	end

	self:SetupArrow()
end

function Pointer:SetupArrow()
	self.ArrowFrame = self.CurrentArrowSkin:CreateFrame()

	self.ArrowFrame:SetScript("OnMouseUp",ZygorGuidesViewer.Pointer.ArrowFrame_OnMouseDown) -- messes with EnableMouse below! Do this first.
	self.ArrowFrame:SetScript("OnMouseDown",ZygorGuidesViewer.Pointer.ArrowFrame_OnMouseUp)

	-- freeze
	self.ArrowFrame:RegisterForDrag(not profile.arrowfreeze and "LeftButton")
	self.ArrowFrame:EnableMouseWheel(not profile.arrowfreeze)
	self.ArrowFrame:EnableMouse(not profile.arrowfreeze)

	-- scale
	local scale = profile.arrowscale
	if not scale then return end
	self.ArrowFrame:SetScale(scale)
	self.ArrowFrame:SetScale(scale)
	self.ArrowFrame:SetScale(scale)
	self.ArrowFrame:SetScale(scale)

	-- opacity
	self.ArrowFrame:SetAlpha(profile.arrowalpha)
end

function Pointer:UpdateWaypoints()
	-- worldmap updates only, so far
	local m,f=GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
	for w,way in ipairs(self.waypoints) do
		if way.m==m and way.f==f then
			Astrolabe:PlaceIconOnWorldMap(ZGV.Pointer.OverlayFrame, way.worldmapFrame, way.m, way.f, way.x, way.y )
			way:UpdateMiniMapIcon(m,f)
		end
	end
end

function Pointer:SetFontSize(size)
	local f=self.ArrowFrame.title:GetFont()
	self.ArrowFrame.title:SetFont(f,size)
	--[[
	self.ArrowFrame.dist:SetFont(f,size)
	self.ArrowFrame.eta:SetFont(f,size)

	self.ArrowFrame.title:SetHeight(size)
	self.ArrowFrame.dist:SetHeight(size)
	self.ArrowFrame.eta:SetHeight(size)
	--]]
end



function Pointer:MinimapZoomChanged()
	if profile.minimapzoom then
		--minimapcontrolled = true
	else
		--minimapcontrolled = false
		Minimap:SetZoom(0)
		MinimapZoomOut:Disable()
		MinimapZoomIn:Enable()
	end
end

function Pointer:ResetMinimapZoom()
	if profile.minimapzoom then
		Minimap:SetZoom(0)
		MinimapZoomOut:Disable()
		MinimapZoomIn:Enable()
	end
	--minimap_lastset = 0
end

local function ShowTooltip(button,tooltip)
	if not button.waypoint or not button.waypoint.t then return end
	tooltip:SetOwner(button,"ANCHOR_TOP")
	tooltip:ClearLines()
	tooltip:SetText(button.waypoint.t)
	if button.waypoint.OnEnter then
		local r = button.waypoint:OnEnter(tooltip)
		if r==false then return end
	end
	--GameTooltip:SetFrameStrata("TOOLTIP")
	tooltip:Show()
end

function Pointer.MinimapButton_OnEnter(self,arg)
	if self.waypoint and (self.icon:IsVisible() or self.arrow:IsVisible()) then
		ShowTooltip(self,GameTooltip)
		GameTooltip:AddLine(("Distance: %s"):format(FormatDistance(self.dist)))
		GameTooltip:Show()
		self.hastooltip=true
	end
end

function Pointer.WorldmapButton_OnEnter(self,arg)
	if self.waypoint and (self.icon:IsVisible() or self.arrow:IsVisible()) then
		WorldMapPOIFrame.old_allowBlobTooltip = WorldMapPOIFrame.allowBlobTooltip
		WorldMapPOIFrame.allowBlobTooltip = false

		ShowTooltip(self,WorldMapTooltip)
	end
end

function Pointer.MinimapButton_OnLeave(self)
	GameTooltip:Hide()
	self.hastooltip=false
end

function Pointer.WorldmapButton_OnLeave(self)
	WorldMapTooltip:Hide()

	WorldMapPOIFrame.allowBlobTooltip = WorldMapPOIFrame.old_allowBlobTooltip
	WorldMapPOIFrame.old_allowBlobTooltip = nil
end

local oldfacing=-1
function Pointer.MinimapButton_OnUpdate(self,elapsed)
	local c = self.minimap_count
	if not c then c=0 end
	c = c + elapsed
	if c < 0.1 then
		self.minimap_count = c
		return
	end
	elapsed = c
	self.minimap_count = 0

	if not profile.minicons then self.icon:Hide() self.arrow:Hide() return end

	local dist,x,y = Astrolabe:GetDistanceToIcon(self)

	if not dist --[[or IsInInstance()--]] then self.icon:Hide() self.arrow:Hide() return end

	self.lastdist=self.dist
	self.dist = dist
	if self.waypoint.OnUpdate then self.waypoint:OnUpdate() end

	if self.waypoint.hidden or self.waypoint.hideminimap then
		self.icon:Hide()
		self.arrow:Hide()
		return
	end

	local edge = Astrolabe:IsIconOnEdge(self)

	local facing = GetPlayerFacing()
	local rotate_minimap = GetCVar("rotateMinimap")=="1"

	if edge then
		if self.showonedge or ZGV.Pointer.ArrowFrame.waypoint==self.waypoint then
			self.icon:Hide()
			self.arrow:Show()

			local angle = Astrolabe:GetDirectionToIcon(self)
			--angle = angle + 2.356194  -- rad(135)

			if rotate_minimap then
				angle = angle - GetPlayerFacing()
			end

			--local sin,cos = math.sin(angle)*0.71, math.cos(angle) * 0.71
			--self.arrow:SetTexCoord(0.5-sin, 0.5+cos, 0.5+cos, 0.5+sin, 0.5-cos, 0.5-sin, 0.5+sin, 0.5-cos)
			self.arrow:SetRotation(angle)
		else
			self.icon:Hide()
			self.arrow:Hide()
		end
	else
		self.icon:Show()
		self.arrow:Hide()
		if self.waypoint.angle and self.waypoint.icon.rotates then
			self.icon:SetRotation(self.waypoint.angle - (rotate_minimap and facing or 0))
		end
	end
	--oldfacing=facing

	-- handle tooltip distance updates
	if self.lastdist~=self.dist and self.hastooltip then
		ZGV.Pointer.MinimapButton_OnEnter(self)
	end

	-- minimap autozoom
	if profile.minimapzoom then
		local Minimap = Minimap
		local getzoom = Minimap:GetZoom()
		if getzoom~=minimap_lastset then
			-- user playing with minimap; suspend our activities for a while
			minimapcontrol_suspension = 5.0
			minimap_lastset = getzoom
		end

		-- are we pointed to?
		if Pointer.ArrowFrame.waypoint==self.waypoint then
			if minimapcontrol_suspension>0 then
				minimapcontrol_suspension = minimapcontrol_suspension - elapsed
			else
				local old_minimap_lastset=minimap_lastset
				local dist = dist*2
				if dist~=lastminimapdist then
					local mapsizes = MinimapSize[Astrolabe.minimapOutside and 'outdoor' or 'indoor']

					minimap_lastset=0
					for i=1,Minimap:GetZoomLevels()-1 do
						if dist<mapsizes[i]*0.7 then minimap_lastset=i end
					end

					if old_minimap_lastset~=minimap_lastset then
						-- sanitise buttons
						if(minimap_lastset == (Minimap:GetZoomLevels() - 1)) then MinimapZoomIn:Disable() else MinimapZoomIn:Enable() end
						if(minimap_lastset == 0) then MinimapZoomOut:Disable() else MinimapZoomOut:Enable() end

						Minimap:SetZoom(minimap_lastset) 
					end
				end
				lastminimapdist=dist
			end
		end
	end
end

function Pointer.MinimapButton_OnClick(self,button)
	if button=="RightButton" then
		if ZGV.Pointer.ArrowFrame.waypoint==self.waypoint then ZGV.Pointer:HideArrow() end
		if self.waypoint.type=="manual" then ZGV.Pointer:RemoveWaypoint(self.waypoint) end
		ZGV:SetWaypoint()
	else
		ZGV.Pointer:ShowArrow(self.waypoint)
	end
end

function Pointer.MinimapButton_OnEvent(self,event,...)
	-- temporarily unused
	ZGV:Print("MINIMAP ONEVENT "..event)
	if not self.waypoint then self:Hide() return end
	
	if event == "PLAYER_ENTERING_WORLD" then
		local way = self.waypoint

		if way then
			way:UpdateMiniMapIcon()
		end
	end
end

function Pointer.WorldMapButton_OnEvent(self,event,...)
	local way = self.waypoint
	
	--ZGV:Print("WORLDMAP ONEVENT "..event)
	if event == "WORLD_MAP_UPDATE" then
		--[[
		local show=true
		if not way.showinallzones then
			local m,f = GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
			if way.m~=m or way.f~=f then show=false end
		end

		if way and way.OnEvent then way:OnEvent(event,...) end
		if not way or way.hidden then self:Hide() return end
		
		local x,y = Astrolabe:PlaceIconOnWorldMap(ZGV.Pointer.OverlayFrame, self, self.waypoint.m, self.waypoint.f, self.waypoint.x, self.waypoint.y)
		if (x and y and (0 < x and x <= 1) and (0 < y and y <= 1)) then
			self:Show()
		else
			self:Hide()
		end

		self.icon:ClearAllPoints()
		self.icon:SetAllPoints()
		--]]

		--[[
		if GetCurrentMapZone()==0 then
			self:SetWidth(10)
			self:SetHeight(10)
		else
		end
		--]]

		--[[
		self:SetWidth(25)
		self:SetHeight(25)
		--]]

	elseif event == "PLAYER_ENTERING_WORLD" or event=="ZONE_CHANGED_NEW_AREA" then
		if way then way:UpdateMiniMapIcon() end
	end
end

function Pointer:IsCorpseArrowNeeded() -- small utility against bulky ifs, NB: waypointer-independent
	return ZGV.db.profile.corpsearrow and UnitIsDeadOrGhost("player") and select(2, IsInInstance()) ~= "pvp" and not IsActiveBattlefieldArena()
end

function Pointer.Overlay_OnEvent(self,event,...)
	if event == "WORLD_MAP_UPDATE" then
	 --[[
		if not WorldMapFrame:IsVisible() then
			return

		elseif IsInInstance() and GetPlayerMapPosition("player")==0 then
			--magic!
			local inst = instancemaps[GetZoneText()]
			if inst then
				ZGV.Pointer.OverlayFrame.texture:SetTexture(ZGV.DIR .. "\\Maps\\" ..inst.map)
				ZGV.Pointer.OverlayFrame.texture:Show()
				ZGV.Pointer.OverlayFrame:EnableMouse(true)

				local room = inst.rooms and inst.rooms[GetMinimapZoneText()]
				if room then
					--ZGV:Print("room")
					self.youarehere:SetPoint("CENTER",self,"TOPLEFT",room.x*self:GetWidth(),-room.y*self:GetHeight())
					self.youarehere:Show()
				else
					self.youarehere:Hide()
				end

				WorldMapFrameTitle:SetText(GetZoneText())
				WorldMapFrameAreaLabel:SetAlpha(0)
			end

			for way,w in pairs(ZGV.Pointer.waypoints) do
				way:Hide()
			end

		else
			--magic!
			-- hide instance overlay
			ZGV.Pointer.OverlayFrame.texture:Hide()
			ZGV.Pointer.OverlayFrame:EnableMouse(false)
			WorldMapFrameAreaLabel:SetAlpha(1)

			--ZGV:Print("showing...")
		end
	 --]]
		local m,f = GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
		local count=0
		for w,way in ipairs(ZGV.Pointer.waypoints) do
			way:UpdateWorldMapIcon(m,f)
			if way.worldmapFrame:IsShown() and way.OnEvent then way:OnEvent(event,...) end
		end
	elseif (event=="PLAYER_ALIVE" or event=="PLAYER_ENTERING_WORLD" or event=="ZONE_CHANGED_NEW_AREA") 
			and ZGV.db.profile.waypointaddon=="internal" then
		if ZGV.Pointer:IsCorpseArrowNeeded() then
			ZGV:Debug(event.." (dead)")
			-- corpse arrow
			if not ZGV.Pointer.corpsearrow then ZGV.Pointer:SetCorpseArrow() end
		else
			ZGV:Debug(event.." (not dead)")
			ZGV.Pointer.corpsearrow = nil
			local n=ZGV.Pointer:ClearWaypoints("corpse")
			if n>0 then ZGV:SetWaypoint() end
		end

		--[[
		for way,w in pairs(ZGV.Pointer.waypoints) do
			way:UpdateMinimapIcon()
		end
		--]]

	elseif event=="PLAYER_UNGHOST" then
		ZGV:Debug("Player unghosted!")
		ZGV.Pointer:ClearWaypoints("corpse")
		ZGV.Pointer.corpsearrow = nil
		ZGV:SetWaypoint()
	end
end
------------------------------------------- ARROW -----------------


--[[
function Pointer.ArrowFrame_OnEvent(self,event,...)
	if event=="WORLD_MAP_UPDATE" then
		ZGV.Pointer:UpdateWaypoints()
	end
end
--]]



local arrowctrl_elapsed=0
local arrowfps = 1/30
local forceupdate_elapsed = 0
function Pointer.ArrowFrameControl_OnUpdate(self,elapsed)
	arrowctrl_elapsed = arrowctrl_elapsed + elapsed
	if arrowctrl_elapsed >= arrowfps then   -- 20fps MAX
		-- update skin IF WE HAVE ONE ON only, dammit
		if Pointer.ArrowFrame then Pointer.ArrowFrame_OnUpdate_Common(Pointer.ArrowFrame,arrowctrl_elapsed) end
		arrowctrl_elapsed = 0
	end
	
	-- update waypoints periodically, in case some get stuck on player-out-of-map,-go-away state
	forceupdate_elapsed = forceupdate_elapsed + elapsed
	if forceupdate_elapsed > 3 then
		Pointer:UpdateWaypoints()
		forceupdate_elapsed = 0
	end
end

-- And we have an onupdating frame even if hidden. Yay!

function Pointer.CalculateDirectionTiers(perc,t1,t2,t3,t4)
	if perc<t1 then return 0 , 1
	elseif perc<t2 then return (perc-t1)/(t2-t1)*0.5 , 2
	elseif perc<t3 then return 0.5 , 3
	elseif perc<t4 then return ((perc-t3)/(t4-t3)*0.5) + 0.5 , 4
	else return 1.0 , 5 end
end

local oldangle = 0

local title,disttxt,etatxt

local speeds={}
local stoptime=0
local avgspeed=0

local eta_elapsed=0
local etadisp_elapsed=0

local lastbeeptime=GetTime()
local lastturntime=lastbeeptime
local laststoptime=lastbeeptime
local lastmovetime=lastbeeptime

local msin,mcos,mabs=math.sin,math.cos,math.abs

local eta

local DEFAULT_STEP_DIST = 30

local function TableFind(table,val)  -- unused, yeah
	for k,v in pairs(table) do if v==val then return k end end
end

--- Find 2 values in a table
-- @return key1,key2
local function TableFind2(table,val1,val2)
	local k1,k2
	for k,v in pairs(table) do  if v==val1 then k1=k end  if v==val2 then k2=k end  end
	return k1 or -1,k2 or -1
end

-- Floor orderings:
-- 1 = "floors" (higher number is above lower)
-- -1 = "dungeons" (higher number is below lower)
-- table - order your floors from TOP to BOTTOM.
local FloorUpDowns = {
	[721] = 1, --Blackrock Spire
}

function FloorOrder(map,a,b)
	local order = FloorUpDowns[map]
	if not order then return b-a end
	if type(order)=="number" then return order*(b-a) end
	if type(order)=="table" then
		if order[1] then
			-- plain ordering
			a,b=TableFind2(order,a,b)
			return a-b
		end
		-- "2_3" ordering
		return order[a.."_"..b] or 0
	end
	return 0
end

function Pointer.ArrowFrame_OnUpdate_Common(self,elapsed)

	local msin,mcos,mabs=msin,mcos,mabs

	--[[
	arrow_throttle = arrow_throttle + elapsed
	if arrow_throttle < 0.05 then return end
	elapsed = arrow_throttle
	arrow_throttle = 0
	--]]

	if not self.waypoint or not ZGV.db.profile.arrowshow then self:Hide() return end
	if profile.hidearrowwithguide and self.waypoint.type=="way" and not ZGV.Frame:IsVisible() then self:Hide() return end
	--if GetCurrentMapContinentAndZone()~=self.waypoint.c then end

	
	
	ZGV:CacheCurrentMapID()
	
	local dist,x,y
	local badfloor,badcont,badfloortxt
	local cm,cf,cc = ZGV.CurrentMapID,ZGV.CurrentMapFloor,ZGV.Pointer.ContinentsByID[ZGV.CurrentMapID]
	
	if IsInInstance() and cm~=self.waypoint.m then self:Hide() return end

	--ZGV:Debug("Waypoint Map: "..self.waypoint.m.." Current: "..cm.." Waypoint Floor:"..self.waypoint.f)

	-- If the Minimap is shown, then there is no need for overhead, just take what Astrolabe calculated for us this frame
	if Minimap:IsShown() then
		dist,x,y = Astrolabe:GetDistanceToIcon(self.waypoint.minimapFrame)
	else
		-- When Minimap is hidden, Astrolabe ceases updating, so let us force calculation
		local _x, _y=GetPlayerMapPosition("player")
		local wp=self.waypoint.minimapFrame.waypoint
		dist, x, y = Astrolabe:ComputeDistance(ZGV.CurrentMapID, ZGV.CurrentMapFloor, _x, _y, wp.m, wp.f, wp.x, wp.y)
		-- Since Astrolabe does not update it when the minimap is hidden, let's do it on our own instead
		self.waypoint.minimapFrame.dist=dist
	end
	
	if ((self.waypoint.c==cc and cc~=-1) or ((self.waypoint.c==-1 or cc==-1) and self.waypoint.m==cm)) and dist then 
		-- same map, or at least same (sane) continent.
		-- can point, but might be wrong map or floor.
		if self.waypoint.m==cm and self.waypoint.f~=cf then
			badfloor=FloorOrder(cm,cf,self.waypoint.f)
			--print(cm,cf,self.waypoint.f,badfloor)
			local function L_or_nil(id)
				local l = L[id]
				if l==id then return nil else return l end
			end
			badfloortxt = L_or_nil('pointer_floors_'..cm..'_'..cf..'_'..self.waypoint.f)
					or L_or_nil('pointer_floors_'..cm..'_'..cf..'_*')
					or L_or_nil('pointer_floors_'..cm..'_*_'..self.waypoint.f)
					or L_or_nil('pointer_floors_'..cm)
					or (badfloor>0 and L['pointer_floors_up'] or L['pointer_floors_down'])
			-- diff floor? prepare to do floor warnings.
		end
		-- Otherwise just point. No funny stuff here.
	else
		badcont=true
	end
    
    -- Safety measure, make sure self.badfloortxt is updated to reflect current surroundings
    self.badfloortxt = badfloortxt

	if not dist then dist=9999999 end

	-- okay, we're live. 3, 2, 1, action!

	self:Show()

	local playerangle = GetPlayerFacing()
	local angle=0

	if self.badfloortxt then

		-- wrong floor, omg

		if self.ShowStairs then
			self:ShowStairs(badfloor>0)
		end

	elseif dist <= 10.0 then

		self:ShowArrived()
		
		--self.eta:Hide()
		--self.dist:Hide()


		-- remove waypoint when standing on the destination for a bit

		if not self.heretime then self.heretime=0 end
		self.heretime = self.heretime + elapsed
		if self.heretime>1 and self.waypoint.clearonarrival then
			ZGV.Pointer:RemoveWaypoint(self.waypoint)
			ZGV:SetWaypoint()
			return
		elseif (self.waypoint.type=="path" and ZGV.Pointer.pathfollow=="strict") then
			local nextway = ZGV.Pointer:GetNextInPath()
			if nextway and nextway~=self.waypoint then ZGV.Pointer:ShowArrow(nextway) end
		end

		--[[
			oldangle = oldangle + elapsed * 3
			while oldangle>6.28319 do oldangle = oldangle - 6.28319 end
			local sin,cos = msin(oldangle + 2.356194)*0.71, mcos(oldangle + 2.356194)*0.71
			self.back:SetTexCoord(0.5-sin, 0.5+cos, 0.5+cos, 0.5+sin, 0.5-cos, 0.5-sin, 0.5+sin, 0.5-cos)
			--]]

			--[[
			count = count + 1
			if count >= 55 then
				count = 0
			end

			cell = count
			local column = cell % 9
			local row = floor(cell / 9)

			local xstart = (column * 53) / 512
			local ystart = (row * 70) / 512
			local xend = ((column + 1) * 53) / 512
			local yend = ((row + 1) * 70) / 512
			arrow:SetTexCoord(xstart,xend,ystart,yend)
		--]]
	else

		self.heretime=0

		--self.eta:Show()
		--self.dist:Show()

		
		--[[ angle ]]--

		angle = Astrolabe:GetDirectionToIcon(self.waypoint.minimapFrame)
		if not angle or badcont then
			angle=3.1415
		else
			--local player = profile.arrowcam and cam_yaw - (is_moving and GetPlayerFacing() or 0) or GetPlayerFacing()
			angle = angle - playerangle
		end
		while angle<0 do angle=angle+6.28319 end

		--angle = angle + 2.356194  -- rad(135)

		if profile.arrowsmooth then
			local dif = angle-oldangle
			if dif>0.001 or dif<0.001 then
				while dif>3.14159 do dif=dif-6.28319 end
				while dif<-3.14159 do dif=dif+6.28319 end

				angle = angle-dif/(1+elapsed*20) --speed!

				--local newdif = newangle-oldangle
				--while newdif>3.14159 do newdif=newdif-6.28319 end
				--while newdif<-3.14159 do newdif=newdif+6.28319 end

				--if newdif*dif>0 then  -- no jittering
				--	angle=newangle
				while angle>6.28319 do angle=angle-6.28319 end
				while angle<0 do angle=angle+6.28319 end
				--end
			end
			oldangle=angle
		end

		--


		------------- 
		
		local perc = mabs(1-angle*0.3183)  -- 1/pi  ;  0=target backwards, 1=target ahead
		local t1,t2,t3,t4,t5 = 0.7,0.75,0.95,1.0
		if perc<t1 then perc=0
		elseif perc<t2 then perc=(t2-perc)/(t2-t1)*0.5
		elseif perc<t3 then perc=0.5
		elseif perc<t4 then perc=(t4-perc)/(t4-t3)*0.5 + 0.5
		else perc=1.0 end

		
		self:ShowTraveling(elapsed,angle,dist)

	
		--[[
		local cell

		local perc = math.abs((math.pi - math.abs(angle)) / math.pi)

		local gr,gg,gb = unpack(TomTom.db.profile.arrow.goodcolor)
		local mr,mg,mb = unpack(TomTom.db.profile.arrow.middlecolor)
		local br,bg,bb = unpack(TomTom.db.profile.arrow.badcolor)
		local r,g,b = ColorGradient(perc, br, bg, bb, mr, mg, mb, gr, gg, gb)		
		arrow:SetVertexColor(r,g,b)

		cell = floor(angle / twopi * 108 + 0.5) % 108
		local column = cell % 9
		local row = floor(cell / 9)

		local xstart = (column * 56) / 512
		local ystart = (row * 42) / 512
		local xend = ((column + 1) * 56) / 512
		local yend = ((row + 1) * 42) / 512
		arrow:SetTexCoord(xstart,xend,ystart,yend)
		--]]
	end


	-- labels

	--ZGV:Debug(("dist %.2f  chg %.2f  speed %.2f  ela %.2f"):format(dist,last_distance-dist,speed,eta_elapsed))
	
	local limit,minlimit=30,5

	eta_elapsed = eta_elapsed + elapsed
	if eta_elapsed >= 0.2 then

		if (ZGV.Pointer.pathfollow=="smart" or ZGV.Pointer.pathfollow=="loose" or ZGV.Pointer.pathfollow=="smart2")
		and (not self.waypoint or self.waypoint.type=="path") then
			local nextway = ZGV.Pointer:GetNextInPath()
			if nextway and nextway~=self.waypoint then ZGV.Pointer:ShowArrow(nextway) end
		end

		speed = (last_distance-dist) / eta_elapsed
		if last_distance == 0 then speed = 0 end
		if last_distance==dist then stoptime=stoptime+eta_elapsed else stoptime=0 end

		--speed=tonumber(("%.2f"):format(speed))
		--ZGV:Print(("dist %.2f  chg %.2f  speed %.2f  thr %.2f"):format(dist,last_distance-dist,speed,eta_elapsed))


		--ZGV:Debug(stoptime)

		if speed>=0 and stoptime<2 then
			table.insert(speeds,1,speed)
			if #speeds>limit then table.remove(speeds) end
		else
			--if stoptime>=10 then
			speed=0
			wipe(speeds)
			--end
		end

		-- Speed meter. Perhaps one day.
		--[[
		profile.arrowshowspeed = true
		if profile.arrowshowspeed then
			local spd
			if profile.arrowmeters then
				spd=("%.02f km/h"):format(speed) --*3.6
			else
				spd=("%.02f mph"):format(speed) --*2.0454
			end
			print(spd)
			self.eta:SetText(spd)
		end
		--]]
		--ZGV:Print(eta_elapsed)
		
		--ZGV:Print(("elapsed %.2f  mov %.2f  speed %.2f  thr %.2f"):format(elapsed,last_distance-dist,speed,eta_elapsed))

		--ZGV:Debug(("%d stops, %.2f straight"):format(stoptime,t-lastturntime))
		if ZGV.db.profile.audiocues and IsFlying() then
			local t=GetTime()
			if lastplayerangle~=playerangle then lastturntime=t end
			if last_distance==dist then laststoptime=t else lastmovetime=t end
			if t-lastmovetime<=1 and t-laststoptime>3 and t-lastturntime>5 then
				-- if flying, basically.
				-- and beelining for the last 3 seconds.

				-- ZGV:Debug(("will cue; dist=%d initial=%d lastbeep=%d"):format(dist,initialdist,GetTime()-lastbeeptime))
				if dist<=100 and not cuedinged then
					PlaySoundFile("Sound\\Doodad\\BoatDockedWarning.wav")
					-- lastwayding=self.waypoint  -- DO NOT COMPARE WAYPOINTS. They come from a POOL and are REUSED!
					cuedinged=true
					--ZGV:Debug("dinging")
				else
					--ZGV:Debug("not dinging, dist="..dist..", lastway="..(lastwayding and lastwayding.t or "nil"))
				end
				--ZGV:Debug("cuedinged "..tostring(cuedinged))

				-- warning beeps
				if self.arrow:IsVisible()  then
					local perc = mabs(1-angle*0.3183)  -- 1/pi
					if perc<=0.9 then
						if t-lastbeeptime>2 then
							PlaySoundFile( [[Sound\Item\Weapons\Ethereal\Ethereal2H3.wav]] )

							if self.ShowWarning then self:ShowWarning() end

							lastbeeptime=t
						end
					end
				end
			end
			lastplayerangle=playerangle
		end



		last_distance = dist
		eta_elapsed = 0
	end

	--ZGV:Print(table.concat(speeds,"  "))

	etadisp_elapsed = etadisp_elapsed + elapsed
	if etadisp_elapsed >= 0.9 then

		local avg=speed
		for i=2,#speeds do avg=avg+speeds[i] end
		avg=avg/max(#speeds,1)

		--ZGV:Debug("eta: #speeds="..#speeds)
		if #speeds>=minlimit and avg>0 then
			eta = math.abs(dist / avg)
		else
			eta = nil
		end
		etadisp_elapsed = 0
	end

	local dist2
	if badcont then
		dist2="far"
	elseif badfloor then
		dist2=badfloortxt
	end

	self:ShowText(self.waypoint.t,dist2 or dist,eta)


	-- spew it out.

end

function Pointer.ArrowFrame_OnShow(frame)
	lastturntime=GetTime()
end

function Pointer.ArrowFrame_OnMouseDown(frame,button)
	--if button=="RightButton" then
	--	ZGV.Pointer.prev_cameraYawMoveSpeed = GetCVar("cameraYawMoveSpeed")
	--end
end

function Pointer.ArrowFrame_OnMouseUp(frame,button)
	if button=="RightButton" then Pointer.ArrowFrame_ShowMenu() end
end

function Pointer.ArrowFrame_ShowMenu()
	local self=ZGV.Pointer.ArrowFrame
	if not self.menu then self.menu = CreateFrame("FRAME",self:GetName().."Menu",self,"UIDropDownMenuTemplate") end

	UIDropDownMenu_SetAnchor(self.menu, 0, 0, "TOP", self, "BOTTOM")
	--local backdrop = DropDownList1:GetBackdrop()
	--backdrop.edgeSize=16
	--DropDownList1:SetBackdrop(backdrop)
	local menu = {
		{
			text = self.waypoint.t,
			isTitle = true,
			notCheckable=true,
		}
	}
	
	local cont = self.waypoint.c>0 and select(self.waypoint.c,GetMapContinents())
	if cont then tinsert(menu,{
			text = ("%s, %s/%d %.1f;%.1f"):format(cont,GetMapNameByID(self.waypoint.m),self.waypoint.f,self.waypoint.x*100,self.waypoint.y*100),
			isTitle = true,
			notCheckable=true,
	}) else tinsert(menu,{
			text = ("%.1f;%.1f"):format(self.waypoint.x*100,self.waypoint.y*100),
			isTitle = true,
			notCheckable=true,
	}) end
	tinsert(menu,{
			text = L['pointer_arrowmenu_removeway'],
			func = function() ZGV.Pointer:RemoveWaypoint(self.waypoint) end,
			--notCheckable=true,
		})
	tinsert(menu,{
			text = L['pointer_arrowmenu_arrowheader'],
			isTitle = true,
			notCheckable=true,
		})
	tinsert(menu,{
			text = L['pointer_arrowmenu_hide'],
			tooltipTitle = L['pointer_arrowmenu_hide'],
			tooltipText = L['pointer_arrowmenu_hide_desc'],
			tooltipOnButton=1,
			func = function() ZGV:SetOption("Map","arrowshow off") end,
		})
	tinsert(menu,{
			text = L['pointer_arrowmenu_freeze'],
			tooltipTitle = L['pointer_arrowmenu_freeze'],
			tooltipText = L['pointer_arrowmenu_freeze_desc'],
			tooltipOnButton=1,
			checked = function() return ZGV.db.profile.arrowfreeze end,
			func = function()  ZGV:SetOption("Map","arrowfreeze "..(profile.arrowfreeze and "off" or "on"))  end,
		})
	tinsert(menu,{
			text = L['pointer_arrowmenu_opacity'],
			hasArrow = true,
			menuList = {
				{ text = "100%", checked = function() return (profile.arrowalpha>0.95) end, func = ZGV.Pointer.ArrowFrame_SetAlpha, arg1=1 },
				{ text = "75%",  checked = function() return (profile.arrowalpha>0.70 and profile.arrowalpha<0.80) end, func = ZGV.Pointer.ArrowFrame_SetAlpha, arg1=0.75 },
				{ text = "50%",  checked = function() return (profile.arrowalpha>0.45 and profile.arrowalpha<0.55) end, func = ZGV.Pointer.ArrowFrame_SetAlpha, arg1=0.5 },
			},
		})
	tinsert(menu,{
			text = L['pointer_arrowmenu_scale'],
			hasArrow = true,
			menuList = {
				{ text = "200%", checked = function() return (profile.arrowscale>1.90) end, func = ZGV.Pointer.ArrowFrame_SetScale, arg1=2 },
				{ text = "175%", checked = function() return (profile.arrowscale>1.65 and profile.arrowscale<1.85) end, func = ZGV.Pointer.ArrowFrame_SetScale, arg1=1.75 },
				{ text = "150%", checked = function() return (profile.arrowscale>1.40 and profile.arrowscale<1.60) end, func = ZGV.Pointer.ArrowFrame_SetScale, arg1=1.50 },
				{ text = "125%", checked = function() return (profile.arrowscale>1.15 and profile.arrowscale<1.35) end, func = ZGV.Pointer.ArrowFrame_SetScale, arg1=1.25 },
				{ text = "100%", checked = function() return (profile.arrowscale>0.90 and profile.arrowscale<1.10) end, func = ZGV.Pointer.ArrowFrame_SetScale, arg1=1.00 },
				{ text = "80%",  checked = function() return (profile.arrowscale>0.75 and profile.arrowscale<0.85) end, func = ZGV.Pointer.ArrowFrame_SetScale, arg1=0.80 },
				{ text = "60%",  checked = function() return (profile.arrowscale>0.55 and profile.arrowscale<0.65) end, func = ZGV.Pointer.ArrowFrame_SetScale, arg1=0.60 },
			},
		})
	tinsert(menu,{
			text = L['pointer_arrowmenu_options'],
			func = function() InterfaceOptionsFrame_OpenToCategory(ZGV.optionpanels['map']) end,
		})
	EasyMenu(menu,self.menu,nil,0,0,"MENU",3)
	UIDropDownMenu_SetWidth(self.menu, 300)
end

function Pointer.ArrowFrame_SetAlpha(but,v)
	ZGV:SetOption("Map","arrowalpha "..v)
end

function Pointer.ArrowFrame_SetScale(but,v)
	ZGV:SetOption("Map","arrowscale "..v)
end

local leftbutdown
local rightbutdown
local old_c,old_z
local zonechangecount=0

local oldzone,zone
function Pointer.Overlay_OnUpdate(frame,but,...)
	-- zone change behaviour is out

	--[[
	local c,z = GetCurrentMapContinentAndZone()
	local zonechanged
	if c~=old_c or z~=old_z then zonechangecount=1 end
	old_c,old_z=c,z
	if zonechangecount>0 then
		if not IsMouseButtonDown("LeftButton") then leftbutdown=false end
		if not IsMouseButtonDown("RightButton") then rightbutdown=false end
		zonechangecount=zonechangecount-1
		return
	end
	--]]



	-- set waypoints by shift-leftclicking the world map

	if IsMouseButtonDown("LeftButton") and IsShiftKeyDown() then
		leftbutdown=true
		oldzone=GetCurrentMapAreaID()
	else
		if leftbutdown then
			leftbutdown=nil
			-- left click

			if GetCurrentMapAreaID()~=oldzone then
				-- map changed with the click! Don't put any notes here.
				return
			end

			-- these are processed AFTER click procs. Necessary to IGNORE (not DELAY) clicks.
			local foc,foundWF=GetMouseFocus(),nil
			while foc do if foc==WorldMapButton then foundWF=true end foc=foc:GetParent() end
			if not foundWF then return end
			
			local mapframe = frame:GetParent()

			local x,y=GetCursorPosition()
			--ZGV:Print(x.." "..y)
			x=(x-(frame:GetLeft()*frame:GetEffectiveScale()))/(frame:GetWidth()*frame:GetEffectiveScale())
			y=(y-(frame:GetBottom()*frame:GetEffectiveScale()))/(frame:GetHeight()*frame:GetEffectiveScale())
			y=1-y
			--ZGV:Print(x.." "..y)
			if (x>0 and x<1 and y>0 and y<1) then
				ZGV.Pointer:ClearWaypoints("manual")
				ZGV.Pointer:SetWaypoint(nil,nil,x*100,y*100,{title=WorldMapFrameAreaLabel:GetText(),type="manual",clearonarrival=true,overworld=true,onminimap="always"})
			end
		end
	end
end

local function GenerateSubmapCache()
	if not submap_cache then submap_cache={} end
	local system
	-- FIXME that's ugly
	for i=0,999 do
		system=Astrolabe:GetMapInfo(i,0)
		if system then -- make Astrolabe do the research if such a map exists
			if not submap_cache[system] then submap_cache[system]={} end
			table.insert(submap_cache[system],i)
		end
	end
end

local function RestartCorpseSearch() -- made it a func not to duplicate code
	-- WTF, no corpse?
	ZGV:Debug("SetCorpseArrow, corpse not found anywhere, will retry")
	ZGV:ScheduleTimer(function() ZGV.Pointer:SetCorpseArrow() end,0.2)
end 

function Pointer:SetCorpseArrow(reset)

	if self.corpsearrow and not reset then return end
	if not UnitIsDeadOrGhost("player") then ZGV:Debug("Pointer.SetCorpseArrow: not dead!") return end

	local x=0
	local y=0

	local mm,mf = GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
	-- some magic here...
	local c,z=0,0
	local m,f=0,0

	ZGV:Debug("SetCorpseArrow, mm/mf="..mm.."/"..mf)
	
	-- If submap cache is not ready, recreate it
	if not submap_cache then 
		GenerateSubmapCache()
		RestartCorpseSearch() return -- FIXME temporary workaround the bug giving the body in Dalaran Crater
	end
	
	-- We probably want to put a dot on all maps where the corpse is seen, just to look consistent
	local mapcandidates = {} 

	-- Locating the player on the parent level map
	local system,_,_,_,_,_=Astrolabe:GetMapInfo(mm,mf)
	SetMapByID(system)
	SetDungeonMapLevel(0) -- sanity
	x,y=GetCorpseMapPosition()
	m,f=system,0
	if x>0 and y>0 then
		ZGV:Debug("SetCorpseArrow, Corpse found in system "..system)
		ZGV:Debug("SetCorpseArrow, Searching the best fit among "..#submap_cache[system].." maps")
        
		-- Right, so what our criteries are in the order of descending importance
		-- • The body is seen within the map
		-- • Map is small(for example Darnassus in Teldrassil)
		local smallestarea,bestmap
		for i,id in ipairs(submap_cache[system]) do -- Also each map includes self in the list
			SetMapByID(id)
			local _x, _y
			local levels = GetNumDungeonMapLevels()
			for l=levels>0 and 1 or 0,levels do -- perusing the current map dungeon levels  --sinus: 1..max   or just 0
				SetDungeonMapLevel(l)
				_x,_y = GetCorpseMapPosition()
				if _x>0 and _y>0 then -- aha, we can see the body on that map, let's note it
					table.insert(mapcandidates,{mapid=id,floor=l,x=_x,y=_y})
					local _,_,_w,_h,_,_=Astrolabe:GetMapInfo(id,l)
					if not bestmap or smallestarea>_w then -- alex: little overhead here is okay, we don't get more that 4 maps anyway
						smallestarea=_w
						bestmap={mapid=id,floor=l} -- this whole thing is excessive for phased maps, but they aren't numerous in a system set
					end -- TODO if somebody wishes to it can be removed for them with some checks
					break
				end
			end
		end
   
		
		if #mapcandidates==0 then   -- -- sinus>alex: #table can't be <0, can it..?
			RestartCorpseSearch()
		else
			-- Now we have a list of maps where the body is seen and the id of the smallest one
			ZGV:Debug("SetCorpseArrow, Body found on "..#mapcandidates.." map/floor combinations")
			ZGV:Debug("SetCorpseArrow, best fit map/floor: "..bestmap.mapid.."/"..bestmap.floor)
			self:ClearWaypoints("corpse")
			
			for key,map in pairs(mapcandidates) do
				if map.mapid==bestmap.mapid and map.floor==bestmap.floor then
					self:SetWaypoint(map.mapid,map.floor,map.x*100,map.y*100,{title= ZGV.db.profile.corpsearrowjokes and L["pointer_corpselabel"..math.random(L["pointer_corpselabel#"])] or L["pointer_corpselabel"],type="corpse"})
					self.corpsearrow=true
-- 				else -- this does not work yet but the client put a dot anyway
-- 					self:CreateMapMarker(v.mapid,v.floor,v.x*100,v.y*100,{title= ZGV.db.profile.corpsearrowjokes and L["pointer_corpselabel"..math.random(L["pointer_corpselabel#"])] or L["pointer_corpselabel"],type="corpse"})
				end
			end
		end
	else
		RestartCorpseSearch()
	end
		--[[
		if not m then
			-- failed! set a flag
			self.corpsewait=true
		end
		--]]
	
	-- Clean up
	SetMapByID(mm)
	SetDungeonMapLevel(mf)
end


Pointer.ArrowSkins = {}

local function _new_skin(id,name)
	local skin = {id=id or "skin", name=name or "unnamed skin",styles={} }
	return skin
end

function Pointer:AddArrowSkin(id,name)
	local skin = _new_skin(id,name)
	self.ArrowSkins[id] = skin
	return skin
end

function Pointer:GetSkinPath(skin)
	if not skin then skin=ZGV.db.options.arrowskin end
	return ZGV.DIR .. "\\Arrows\\" .. skin .. "\\"
end

function Pointer:SetArrowSkin(skin)
	-- no style? grab default
	if not skin then
		skin = next(self.ArrowSkins)
		assert(skin,"No arrow skin to fall back to!")
		return self:SetArrowSkin(skin)
	end
	local skindata = self.ArrowSkins[skin]
	if not skindata then
		ZGV:Print("Unknown arrow skin '"..skin.."', falling back to default")
		return self:SetArrowSkin()
	end

	local way
	if self.CurrentArrowSkin then
		way = self.ArrowFrame.waypoint
		self.ArrowFrame:Hide()
	end
		
	ZGV.db.profile.arrowskin = skin

	self.CurrentArrowSkin = skindata
	self.ArrowSkinDir = self:GetSkinPath(skin,style)

	self:CreateArrowFrame()

	self.ArrowFrame.waypoint = way
end

function Pointer:UpdateArrowVisibility()
	if not self.ArrowFrame then return end
	if ZGV.db.profile.arrowshow then self.ArrowFrame:Show() else self.ArrowFrame:Hide() end
end

function Pointer:SetMinimapPlayerTexture()
	Minimap:SetPlayerTexture(ZGV.DIR.."\\skins\\minimaparrow-player")
end

function Pointer:GetNextInPath()
	if self.pathfollow == "smart" then
		-- broken with ants
		local neardist=9999999999
		local nearnum
		for w,way in ipairs(self.waypoints) do  if way.type=="path" then
			if way.minimapFrame and way.minimapFrame.dist<neardist then
				neardist=way.minimapFrame.dist
				nearnum=w
			end
		end  end
		local nearway=self.waypoints[nearnum]

		local nextnum=nearnum+1
		if nextnum>#self.waypoints then
			if self.pathloop then nextnum=1 else return self.waypoints[nearnum] end
		end
		local nextway=self.waypoints[nextnum]

		if neardist<50 then return nextway end

		local nextdist = nextway.minimapFrame.dist
		local nearnextdist = Astrolabe:ComputeDistance(nearway.m,nearway.f,nearway.x,nearway.y,nextway.m,nextway.f,nextway.x,nextway.y)
		if not nearnextdist then
			return nearway
		else
			-- fun part.
			if neardist+nextdist < nearnextdist*1.2 then return nextway else return nearway end
		end
		return self.waypoints[nextnum]
	elseif self.pathfollow == "smart2" then
		-- broken with ants
		local neardist=9999999999
		local nears={}
		local nearnum
		for w,way in ipairs(self.waypoints) do  if way.minimapFrame and way.minimapFrame.dist<neardist then  neardist=way.minimapFrame.dist  nearnum=w  end  end
		tinsert(nears,nearnum)
		repeat
			local neardistmin=neardist
			neardist=neardist*1.1
			for w,way in ipairs(self.waypoints) do  if way.minimapFrame and way.minimapFrame.dist>=neardistmin and way.minimapFrame.dist<neardist then  tinsert(nears,w)  end  end
		until #nears>=3
		print("nears",unpack(nears))

		local minnum = min(unpack(nears))
		local maxnum = max(unpack(nears))
		local size = #self.waypoints
		local halfway = floor(size/2)
		if maxnum-minnum>halfway then -- first and last choice span more than half the path?
			--for i in ipairs(nears) do  if way.minimapFrame and way.minimapFrame.dist<neardist then  neardist=way.minimapFrame.dist  nearnum=w  end  end
			for i=1,#nears do nears[i]=nears[i]-halfway  if nears[i]<0 then nears[i]=nears[i]+size end  end
			maxnum = max(unpack(nears))
			print("nears fix",unpack(nears))
		end
		print("maxnum",maxnum)

		return self.waypoints[maxnum]
	elseif self.pathfollow == "strict"  then
		local nextnum=self.ArrowFrame.waypoint and (self.ArrowFrame.waypoint.num+1) or 1
		if nextnum>#self.waypoints or self.waypoints[nextnum].type=="ant" then
			if self.pathloop then
				for w,way in ipairs(self.waypoints) do if way.type=="path" then nextnum=w break end end
			else
				return
			end
		end
		return self.waypoints[nextnum]
	else --if self.pathfollow == "loose" then
		local curnum
		for w,way in ipairs(self.waypoints) do
			if way.type=="path" then
				local mf = way.minimapFrame
				local dist = mf and mf.dist or 9999
				if dist<=(way.dist or DEFAULT_STEP_DIST) then
					curnum=w
				end
			end
		end
		if not curnum then return self.ArrowFrame.waypoint end  -- current stays.

		local nextnum = curnum+1
		if nextnum>#self.waypoints or self.waypoints[nextnum].type~="path" then
			if self.pathloop then
				for w,way in ipairs(self.waypoints) do if way.type=="path" then nextnum=w break end end
			else
				return
			end
		end
		return self.waypoints[nextnum]
	end
end

--[[
function Pointer.GetMapName(id)
	local map,floor = Pointer.UnwrapMapFloor(mapfloor)
	local mapname = GetMapNameByID(map)
end
-- TODO later.
--]]

-- store continent numbers, for zone continent comparison later.
ZGV.Pointer.ContinentsByID = {}
for id=1,1000 do
	if GetMapNameByID(id) then
		SetMapByID(id)
		ZGV.Pointer.ContinentsByID[id]=GetCurrentMapContinent()
	end
end


local flash_delay=0
local flash=nil
do
	local F = CreateFrame("FRAME","ZGVPointerExtraFrame")
	local ela=0
	local ant_interval = 0.1
	local ant_speed = 0.3
	F:SetScript("OnUpdate",function(self,elapsed)
		ela=ela+elapsed
		if ela>=ant_interval then
			if ZGV.CurrentStep and ZGV.CurrentStep.waypath then
				local phase = Pointer.antphase or 0
				phase = phase + ela*ant_speed
				while phase>=1 do phase = phase - 1.0 end
				Pointer.antphase = phase
				ZGV:SetWaypoint(nil,nil,nil,"ant")
			end
			repeat  ela=ela-ant_interval  until ela<=ant_interval
		end
		-- Flashing node dots. Prettier than the standard, too. And slightly bigger.
		--[[
		flash_delay=flash_delay+elapsed
		if flash_delay>0.25 then
			flash=not flash
			Minimap:SetBlipTexture(ZGV.DIR.."\\Skins\\Dot"..(flash and "On" or "Off"))
			flash_delay=0
		end
		--]]

	end)
	
	--[[
	local CHAIN = ZGV.ChainCall
	F:SetPoint("CENTER",UIParent)
	F:Show()
	CHAIN(F:CreateTexture()) :SetTexture(ZGV.DIR.."\\Skins\\DotOn") :SetSize(50,50) :SetNonBlocking(true) :Show()
	CHAIN(F:CreateTexture()) :SetTexture(ZGV.DIR.."\\Skins\\DotOff") :SetSize(50,50) :SetNonBlocking(true) :Show()
	--]]
end