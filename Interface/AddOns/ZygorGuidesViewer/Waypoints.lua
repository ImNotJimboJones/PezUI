local ZGV = ZygorGuidesViewer
if not ZGV then return end

local L = ZGV.L
local BZL = ZGV.BZL

local Astrolabe = DongleStub("Astrolabe-1.0")

local tinsert=tinsert

function ZGV:getXY(id)
	self:Debug("getXY "..id)
	return (id % 10001)/10000, math.floor(id / 10001)/10000
end

ZGV.Waypoints = {}
local Waypoints = ZGV.Waypoints

local addonnames = {"none","internal","cart2","carbonite","tomtom"}
local addonnum = {}
for i=1,#addonnames do addonnum[addonnames[i]]=i end


function ZGV:ConnectWaypointAddon(addon)
	if not addon then addon=self.db.profile.waypointaddon end
end

function ZGV:AutodetectWaypointAddon()
	self.autodetectingwaypointaddon = true
	self:Print(L["waypointaddon_detecting"])

	local checks = {"cart2","carbonite","tomtom","internal"}
	for i=1,#checks do
		if self:IsWaypointAddonReady(checks[i]) then
			return checks[i]
		end
	end

	-- else
	self:Print(L["waypointaddon_notdetected"])
end

function ZGV:GetWaypointAddon()
	return addonnum[self.db.profile.waypointaddon] or 0
end

function ZGV:SetWaypointAddon(info,addon)
	if not addon then addon=info end
	if type(addon)=="number" then addon=addonnames[addon] end
	if not addon then
		-- try to autodetect
		addon = self:AutodetectWaypointAddon()
		if not addon then addon="none" end
	end
	addon=addon:gsub("[0-9]-_","")

	self:Debug("Setting waypoint addon: "..addon)
	if addon~="none" and not self:IsWaypointAddonReady(addon) then
		self:Print(L["waypointaddon_fail"]:format(L["opt_group_addons_"..addon]))
		return
	end

	-- disconnect the current addon
	--if (addon~=self.db.profile.waypointaddon) then
	self:UnsetWaypointAddon()
	--end

	self.db.profile.waypointaddon = addon
	--self.iconsregistered = false
	--self.iconregistryretries = 0
	self.ConnectedWaypointer = self.WaypointFunctions[addon]

	self:Print(L["waypointaddon_set"]:format(L["opt_group_addons_"..addon]))

	self:SetWaypoint()
--[[
	if (self.db.profile.waypointaddon=="none") then
		self.optionsmap.args.minicons.disabled = true
	else
		self.optionsmap.args.minicons.disabled = false
	end
	LibStub("AceConfigRegistry-3.0"):NotifyChange("ZygorGuidesViewer")
]]--
end

-- Some small utilities which may be useful to several waypointing backends
-- Moved 'em out of Internal waypointer so that TomTom, for example, 
-- may equally enjoy the pleasures of nettles^W path-based navigation ~aprotas

local curve_spacing = 100
local function calc_catmull_rom(t,t2,t3,p0,p1,p2,p3)
	return 0.5 * ( (2*p1.x) + (-p0.x+p2.x)*t + (2*p0.x-5*p1.x+4*p2.x-p3.x) * t2 + (-p0.x+3*p1.x-3*p2.x+p3.x) * t3),
		   0.5 * ( (2*p1.y) + (-p0.y+p2.y)*t + (2*p0.y-5*p1.y+4*p2.y-p3.y) * t2 + (-p0.y+3*p1.y-3*p2.y+p3.y) * t3)
	-- kept separate just in case. Inlined below for optimization.
end

local function calc_angles(points,do_loop,recalc)
	local atan2=math.atan2
	for k,point in ipairs(points) do
		if recalc then point.angle=nil end
		if not point.angle then
			local nextpoint = points[k+1]
			if not nextpoint then
				if do_loop then nextpoint=points[1] else break end
			end
			if nextpoint then
				local angle = atan2(nextpoint.x-point.x,(point.y-nextpoint.y)*0.66)
				if angle>0 then angle=6.2831-angle else angle=-angle end
				point.angle = angle
			end
		end
	end
end

local function calc_angles_curved(points,do_loop,recalc)
	local atan2=math.atan2
	for i=1,#points do
		local point=points[i]
		if recalc then point.angle=nil end
		if not point.angle then
			local p0i,p1i,p2i,p3i = i-1,i,i+1,i+2
			if p0i<1 then p0i = do_loop and p0i+#points or 1 end
			if p2i>#points then p2i = do_loop and p2i-#points or #points end
			if p3i>#points then p3i = do_loop and p3i-#points or #points end
			local p0,p1,p2,p3=points[p0i],points[p1i],points[p2i],points[p3i]
			local x,y = calc_catmull_rom(0.2,0.04,0.008,p0,p1,p2,p3)
			if x then
				local angle = atan2(x-point.x,(point.y-y)*0.66)
				if angle>0 then angle=6.2831-angle else angle=-angle end
				point.angle = angle
			end
		end
	end
end

-- optimization madness: localize EVERYTHING 
-- Sinus, I'm sorry, but I guess Internal's not the only arrow needing those ~aprotas

local abs=math.abs
local ceil=math.ceil

local function spawn_curve_ants(points,loop,phase)
	if #points<3 then return end
	local curvepoints={}
	--print("curving!!")
	local abs=abs
	local ceil=ceil

	local np=#points
	for i=1,np do
		--tinsert(curvepoints,points[i])
		local p0i,p1i,p2i,p3i = i-1,i,i+1,i+2
		if p0i<1 then p0i = loop and p0i+#points or 1 end
		if p2i>#points then p2i = loop and p2i-#points or #points end
		if p3i>#points then p3i = loop and p3i-#points or #points end

		local p0,p1,p2,p3=points[p0i],points[p1i],points[p2i],points[p3i]

		local curve_accuracy = p1.curve_accuracy
		if not curve_accuracy then
			local dist = Astrolabe:ComputeDistance(p1.map,p1.floor,p1.x/100,p1.y/100,p2.map,p2.floor,p2.x/100,p2.y/100)   -- Astrolabe thinks x and y are 0..1, and they're 0..100 here. Results will be valid, though exaggerated.
			if not dist or dist<1 then dist=1 end
			curve_accuracy = ceil(dist/curve_spacing)
			if curve_accuracy>20 then curve_accuracy=20 end
			curve_accuracy = 1/curve_accuracy
			p1.curve_accuracy = curve_accuracy
		end

		--print("acc",curve_accuracy)
		for t=phase*curve_accuracy,1-(1-phase)*curve_accuracy,curve_accuracy*0.999 do
			local t2 = t*t
			local t3 = t*t*t

			-- Catmull-Rom
			local x = 0.5 * ( (2*p1.x) + (-p0.x+p2.x)*t + (2*p0.x-5*p1.x+4*p2.x-p3.x) * t2 + (-p0.x+3*p1.x-3*p2.x+p3.x) * t3)
			local y = 0.5 * ( (2*p1.y) + (-p0.y+p2.y)*t + (2*p0.y-5*p1.y+4*p2.y-p3.y) * t2 + (-p0.y+3*p1.y-3*p2.y+p3.y) * t3)

			--if (abs(x-p1.x)+abs(y-p1.y)>0.1) and (abs(x-p2.x)+abs(y-p2.y)>0.1) then
			tinsert(curvepoints,{map=p1.map,floor=p1.floor,x=x,y=y,sub=i+t,icon=ZGV.Pointer.Icons.ant})
			--print(("%d/%.2f: [%.1f,%.1f]->[%.1f,%.1f] = [%.1f,%.1f]"):format(i,t,p1.x,p1.y,p2.x,p2.y,x,y))
			--end
		end
	end
		--print("curved, ",#curvepoints)
	return curvepoints
end

function ZGV.Waypoints:SetAntSpacing(spacing)
	curve_spacing = spacing
end

local function spawn_straight_ants(points,loop,phase)
	if #points<2 then return end
	local antpoints={}
	--print("curving!!")
	local abs=abs
	local ceil=ceil

	local np=#points

	for i=1,np do
		local p1 = points[i]
		local p2 = points[i+1]
		if not p2 then
			if loop then p2=points[1] else break end
		end

		local curve_accuracy = p1.curve_accuracy
		if not curve_accuracy then
			local dist = Astrolabe:ComputeDistance(p1.map,p1.floor,p1.x/100,p1.y/100,p2.map,p2.floor,p2.x/100,p2.y/100)   -- Astrolabe thinks x and y are 0..1, and they're 0..100 here. Results will be valid, though exaggerated.
			if not dist or dist<1 then dist=1 end
			curve_accuracy = ceil(dist/curve_spacing)
			if curve_accuracy>20 then curve_accuracy=20 end
			curve_accuracy = 1/curve_accuracy
			p1.curve_accuracy = curve_accuracy
		end

		--print("acc",curve_accuracy)
		for t=phase*curve_accuracy,1-(1-phase)*curve_accuracy,curve_accuracy*0.999 do
			-- straight line
			local x = p1.x + t*(p2.x-p1.x)
			local y = p1.y + t*(p2.y-p1.y)
			tinsert(antpoints,{map=p1.map,floor=p1.floor,x=x,y=y,sub=i+t,icon=ZGV.Pointer.Icons.ant})
		end
	end
	return antpoints
end

-- Waypoint functions by addon

ZGV.WaypointFunctions = {}
--=========================================== TOMTOM =============================================
ZGV.WaypointFunctions['tomtom'] = {
	isready = function()
		-- make SURE we have TomTom and not Carbonite emulating it
		return not not (TomTom and IsAddOnLoaded("TomTom"))
	end,
	setwaypoint = function (self,goalnumORx,y,title)
		local waypath=self.CurrentStep and self.CurrentStep.waypath or nil
		if not (waypath and #waypath.coords>1) then
			self:ClearTomTomWaypoints() 
		end
		
		if goalnumORx==false then return end

		if y then
			self:CreateTomTomWaypointXY(goalnumORx,y,title,true)
		else
			local waypath=self.CurrentStep and self.CurrentStep.waypath or nil
			if waypath then 
				-- Copied from Internal one not to break things with scopes etc
				local antpoints
				if waypath.ants=="straight" or #waypath.coords<3 then
					antpoints = spawn_straight_ants(waypath.coords,waypath.loop,ZGV.Pointer.antphase)
				else
					antpoints = spawn_curve_ants(waypath.coords,waypath.loop,ZGV.Pointer.antphase)
				end

				--calc_angles(antpoints,waypath.loop)
				if antpoints then
					self.Pointer:ClearWaypoints("ant")
					self.Waypoints:SetAntSpacing(self.db.profile.antspacing)
					
					for k,point in ipairs(antpoints) do
						ZGV.Pointer:SetWaypoint (point.map,point.floor,point.x,point.y,
							{title=nil,
							onminimap="always",overworld=true,showonedge=false,
							icon=point.icon,
							angle=point.angle,
							passive=true,
							type="ant",
-- 							dist=dist, --WHOAH, HOW? ~aprotas
							num=k
							}, false)
					end
				end
				-- Cut here
				self:CreateTomTomWaypath(waypath)
			else 
				self:CreateTomTomWaypoints(goalnumORx)
			end
		end
	end,
	addmapnote = function (self,map,flr,x,y,data)
		self:CreateTomTomWaypointMFXY(map,flr,x,y,data.title,false)
	end,
	disconnect = function(self)
		-- TomTom can ask for clearing all waypoints; Carbonite should not.
		if StaticPopupDialogs["TOMTOM_REMOVE_ALL_CONFIRM"] then StaticPopupDialogs["TOMTOM_REMOVE_ALL_CONFIRM"]:OnAccept() end

		-- Carbonite doesn't do this, either
		if TomTomCrazyArrow then TomTomCrazyArrow:Hide() end
	end
}

do --=========================================== CARBONITE =============================================
	local mapid_to_cz={}
	for id=1,999 do
		SetMapByID(id)
		local c,z = GetCurrentMapContinent(),GetCurrentMapZone()
		if c and z then mapid_to_cz[id]={c,z} end
	end

	local lastwaypath -- Optimization trick, last waypath we were asked to display
	
	local function ClearCarboniteWaypoints()
		local map=Nx.Map:GeM(1)
		if map then wipe(map.Tar) end
	end
	
	-- TODO I really forgot what the last option does, need to lurk it up ~aprotas
	local function CreateCarboniteWaypointMXY(mapid,x,y,title,option)
		local map=Nx.Map:GeM(1) if not map then return end
		local mid=Nx.AITI[mapid] -- AITI → AreaID to Carbonite ID ~ aprotas
		if mid then
			-- TODO should we need to ever give floor id?
			map:STXY(mid,x,y,title,option)
			map:CTO(-1,1) -- TODO I have neither ability nor desire to find out what it does, but I'm just mimicking Nx.TTST behaviour here ~aprotas
		else
			self:Debug("Carbonite does not have an ID for map "..mapid.." please report")
		end
	end
	
	local function RecycleRouteCarbonite()
		-- WARNING we are being of evil by overriding user addon settings
		-- we could possibly restore it back but do we really have to?
		local map=Nx.Map:GeM(1)
		if map then
			if not map.GOp["RouteRecycle"] then
				ZGV:Debug("Forcing Carbonite setting: RouteRecycle")
				map.GOp["RouteRecycle"]=true
			end
		end
	end
	
	local function OptimizeRouteCarbonite()
		-- TODO make sure this does not reverse the direction when it's NOT needed
		-- TODO testing on multipoint "regular" waypoints
		-- TODO testing on acyclic waypaths
		local map=Nx.Map:GeM(1)
		if map then
			map:RoT()
		end
	end
	
	-- Makes the waypoints set clear out at long (60 yard) radius
	local function LongClearanceCarbonite()
		local map=Nx.Map:GeM(1)
		if map and map.Tar then
			-- Setting the distances
			local DIST=60 -- WARNING: hardcoded value 
			local sqrt=math.sqrt
			for k,v in ipairs(map.Tar) do
				v.Rad=DIST
				if #map.Tar>1 then -- Making sure we're giving enough space not to overlap the previous point
					local u=map.Tar[k==1 and #map.Tar or k-1]
					local dist=sqrt((v.TMX-u.TMX)^2+(v.TMY-u.TMY)^2)	-- Distance between the points
					-- Correcting the waypath distance to the next waypoint
					if v.Rad>=dist and dist>0 then 
						v.Rad=dist/2-1
						if v.Rad<1 then v.Rad=1 end
						ZGV:Debug("Waypoints ["..k.."→"..(k==1 and #map.Tar or k-1).."] are too packed, correcting clear distance to "..v.Rad)
					end
				end
			end
		end
	end
	
	-- Makes the waypoints not clear at all
	local function NoClearanceCarbonite()
		local map=Nx.Map:GeM(1)
		if map and map.Tar then
			for k,v in ipairs(map.Tar) do
				v.Rad=-1 -- Carbonite must be -very- astonished
			end
		end
	end
	
	ZGV.WaypointFunctions['carbonite'] = {
		isready = function()
			return not not (Nx and Nx.TTAW)
		end,
		setwaypoint = function (self,goalnumORx,y,title)
			local waypath=self.CurrentStep and self.CurrentStep.waypath or nil
			local map=Nx.Map:GeM(1)
			
			if not (waypath and #waypath.coords>1) then
				ClearCarboniteWaypoints() -- There may be a need to preserve current waypath points
			end

			if goalnumORx==false then return end
            
			if y then
				CreateCarboniteWaypointMXY(GetCurrentMapAreaID(),goalnumORx,y,title,false)
			else
				if not self.CurrentStep or not self.CurrentStep.goals then return end
			--	if self.CurrentStep.mapnote then

				local x,y,zone
				local waypointscount

				if waypath and #waypath.coords>1 then
					if waypath~=lastwaypath then
						ClearCarboniteWaypoints() -- Postponed wiping action, saving the waypath setting
						local cordcount=#waypath.coords
						lastwaypath=waypath -- Remembering the waypath not to update it every time
						-- TODO please optimize this ~aprotas
						
						self:Debug("New waypath available, installing the points")
						
						waypointscount=0
						-- Carbonite has a noice ant system by itself, let's make use of it
						for i=1,cordcount do -- TODO reverse iterator, cmon, there should be one
							v=waypath.coords[cordcount-i+1]
							CreateCarboniteWaypointMXY(v.map,v.x,v.y,k,true) -- TODO Where's the title?
							waypointscount=waypointscount+1
						end
						
						RecycleRouteCarbonite()
					end
				else
					lastwaypath=nil -- No waypath in this step, good
					-- "Simply" setting the waypoint 
					for i=#self.CurrentStep.goals,1,-1 do
						local goal = self.CurrentStep.goals[i]
						if goal.map and goal.x and not goal.force_noway then
							self:Debug("Placing Carbonite waypoint")
							CreateCarboniteWaypointMXY(goal.map,goal.x,goal.y,goal.title or self.CurrentStep.title or goal.autotitle or self.CurrentStep:GetWayTitle() or "Step "..self.CurrentStepNum,true)
							if not waypointscount then waypointscount=0 end
							waypointscount=waypointscount+1
						end
					end
				end
				
				-- Making use of Carbonite waypoint organizer whereas possible
				if waypointscount then
					if waypointscount>1 then
						OptimizeRouteCarbonite()
						LongClearanceCarbonite()
					else
						NoClearanceCarbonite()
					end
				end
			end

		end,
		clearmapnotes = function (self)
			local folders = Nx.Fav:FiF("Notes")
			for i,fol in ipairs(folders) do
				for j=1,#fol do
					if fol[j] and fol[j]:match("~#~.*%(ZG%)~") then
						tremove(fol,j)
						j=j-1
					end
				end
			end
			Nx.Fav:Upd()
		end,
		addmapnote = function (self,map,flr,x,y,data)  -- UNUSED
			--[[
			local folder=Nx.Fav:FiF("Zygor Guides")
			if not folder then
				folder=Nx.Fav:AdF1("Zygor Guides")
			end
			local fav = Nx.Fav:FiF1("Gold Guide","Name",folder)
			if not fav then
				fav=Nx.Fav:AdF2("Gold Guide",folder)
				fav["ID"]=maI
				sort(fav,function(a,b) return a["Name"]<-b["Name"] end)
			end

			local carbZone = map  --Nx.MNTI1[map] --zone IDs
			local fav = Nx.Fav:GNF(carbZone)
			local s=Nx.Fav:CrI("N",0,(data and data.title or "Gold Spot") .. " (ZG)",3,carbZone,x,y)
			Nx.Fav:AdI1(fav,nil,s)
			-- ...
			Nx.Fav:Upd()

			--]]
			--Nx:TTSTCZXY(contid,zoneid,x,y,data and data.title,false,true,true,nil)  -- cont,zone,x,y,name,persist,minimap,world,data
		end,
		disconnect = function(self)
			ClearCarboniteWaypoints()
		end
	}
end

ZGV.WaypointFunctions['cart2'] = {
	isready = function()
		return not not (Cartographer_Notes and Cartographer_Notes:IsActive() and Cartographer_Notes.externalDBs)
	end,

	clearmapnotes = function (self)
	end,
	addmapnote = function (self,map,flr,x,y,data)
	end,

	setwaypoint = function (self,goalnumORx,y,title)
		self:Debug("Setting cart2 waypoint")
		--self:Debug(self.CurrentStep.mapnote)
	--[[		
		if self.oldnote then
			Cartographer_Notes:DeleteNote(self.oldzone,self.oldnote)
		end
	--]]
		self:UpdateCartographerExport()
		self:ClearCartographerWaypoints()
		if goalnumORx==false then return end

		if y then
			self:CreateCartographerWaypointXY(goalnumORx,y,title)
		else
			self:CreateCartographerWaypoints(goalnumORx)
		end

		--[[
		local queue = Cartographer_Waypoints.Queue
		for i,v in ipairs(queue) do
			if v and v.Db=="ZygorGuides" then
				table.remove(queue,i)
			end
		end
		--]]

		--local note = Cartographer_Notes:SetNote(zone,x/100,y/100,"Circle","ZygorGuidesViewer",'manual',true,'title',)
	--		if mapnote and mapzone and Cartographer_Notes.externalDBs then
	--			Cartographer_Waypoints:SetNoteAsWaypoint(mapzone,mapnote)
	--		end
	--		self.oldzone = zone
	end,
	disconnect = function(self)
		self:ClearCartographerWaypoints()
		--if Cartographer_Notes and Cartographer_Notes.externalDBs and Cartographer_Notes.externalDBs["ZygorGuidesViewer"] then 
		Cartographer_Notes:UnregisterNotesDatabase("ZygorGuidesViewer")
	end
}

ZGV.WaypointFunctions['cart3'] = {
	isready = function()
		return not not (Cartographer3 and Cartographer3.db)
	end,
	disconnect = function(self)
		--[[
		if Cartographer3 and Cartographer3.db then
			self:Print("Cartographer3 disconnected.")
		else
			self:Print("Cartographer3 not connected.")
		end
		--]]
	end
}

ZGV.WaypointFunctions['metamap'] = {
	isready = function()
		return false
	end
}

--============================================= internal =============================================

ZGV.WaypointFunctions['internal'] = {
	isready = function(self)
		return not not self.Pointer.ready
	end,
	setwaypoint = function (self,goalnumORx,y,title,only_type)
		if self.Pointer.corpsearrow or self.Pointer:IsCorpseArrowNeeded() then
			return
		end
		
		if only_type then
			self.Pointer:ClearWaypoints(only_type)
		else
			self.Pointer:ClearWaypoints("way")
			self.Pointer:ClearWaypoints("path")
			self.Pointer:ClearWaypoints("ant")
			self.Pointer:ClearWaypoints("manual")
			self.Pointer:HideArrow()
		end

		if goalnumORx==false then return end

		if y then
			-- coords, plain as day
			return self.Pointer:SetWaypoint (nil,nil,goalnumORx,y,{title=title,persistent=true,overworld=true})
		end

		self.Waypoints:SetAntSpacing(self.db.profile.antspacing)

		local step = self.CurrentStep
		if not step then return end

		local arrowpoint

		local function set_waypoints(points,worldsize,minisize,type)
			local pathmode = (type=="path")
			local antmode = (type=="ant")
			for k,point in ipairs(points) do
				if not point.force_noway and point.x then
					local way = self.Pointer:SetWaypoint (point.map,point.floor,point.x,point.y,
						{title=not antmode and
							(title
							or point.waytitle or point.title
							or (pathmode and (step.waypath.title and step.waypath.title or "Path").." ("..k..")")
							or step:GetWayTitle()
							or (point.map and point.x and ("%s %d,%d"):format(GetMapNameByID(point.map),point.x,point.y))
							or L['waypoint_step']:format(self.CurrentStepNum)
							),
						onminimap="always",overworld=true,showonedge=not antmode and not pathmode,
						icon=point.icon,
						angle=point.angle,

						passive=antmode,
						
						type=type,
						dist=dist,
						num=k
						}, false)
					if way then
						if not antmode then
							arrowpoint = arrowpoint or way
						end
						-- or (step.waypath and step.waypath.current==point) 
					else
						self:Print("Unable to create waypoint: "..point.map.." "..point.x.." "..point.y)
					end
				end
			end
		end
		-- TODO we are updating this constantly. that's really inefficient ~aprotas
		
		local waypath = step.waypath
		if waypath and #waypath.coords>1 then
			self.Pointer.pathfollow = waypath.follow
			self.Pointer.pathloop = waypath.loop

			for wpi,wp in ipairs(waypath.coords) do wp.curve_accuracy=nil end  -- clear this cached value, we might change accuracy.

			if waypath.ants and curve_spacing>0 and only_type=="ant" then --and not step.waypath_curved 
				--step.waypath_curved = true
				local antpoints
				if waypath.ants=="straight" or #waypath.coords<3 then
					antpoints = spawn_straight_ants(waypath.coords,waypath.loop,ZGV.Pointer.antphase)
				else
					antpoints = spawn_curve_ants(waypath.coords,waypath.loop,ZGV.Pointer.antphase)
				end

				--calc_angles(antpoints,waypath.loop)
				if antpoints then
					set_waypoints(antpoints,35,30,"ant")
				end
			end

			if not only_type then
				if waypath.ants=="curve" then
					calc_angles_curved(waypath.coords,waypath.loop)
				else
					calc_angles(waypath.coords,waypath.loop)
				end

				for k,point in ipairs(waypath.coords) do
					if point.angle then point.icon = ZGV.Pointer.Icons.arrow else point.icon=ZGV.Pointer.Icons.dot end
				end
				set_waypoints(waypath.coords,nil,nil,"path")
			end
		else
			self.Pointer.pathfollow = nil
		end

		if only_type~="ant" and step.goals then
			if goalnumORx then
				points={step.goals[goalnumORx]}
			else
				points={}
				for i=1,#step.goals do
					if step.goals[i].x then tinsert(points,step.goals[i]) end
				end
			end
			if #points>0 then set_waypoints(points,35,30,"way") end
		end

		if arrowpoint and not UnitIsDeadOrGhost("player") and only_type~="ant" and not self.Pointer.ArrowFrame.waypoint then
			-- don't overwrite the stinking arrow
			self.Pointer:ShowArrow (arrowpoint)
		end
	end,
	addmapnote = function (self,map,flr,x,y,data)
		local way = self.Pointer:SetWaypoint (map,flr,x,y,{title=data.title or ("%s %d,%d"):format(zone,x,y),persistent=true,overworld=true})
	end,
	disconnect = function(self)
		self.Pointer:ClearWaypoints()
	end
}

ZGV.WaypointFunctions['none'] = {
	isready = function()
		return true
	end,
	setwaypoint = function (self)
		self:Debug("No waypointing addon connected.")
	end
}

-- call empty funcs under missing indices
local nilfuncs = {__index=function() end}
for k,v in pairs(ZGV.WaypointFunctions) do setmetatable (v,nilfuncs) end


function ZGV:SetWaypoint(...)
	if not self.ConnectedWaypointer then return end
	if ...~=false and self.db.profile.hidearrowwithguide and not ZGV.Frame:IsShown() then return end
	if not self:IsWaypointAddonReady() then
		self:Print("Waypoint addon '"..self.db.profile.waypointaddon.."' failed.")
		return
	end
	self.ConnectedWaypointer.setwaypoint(self,...)
end

function ZGV:UnsetWaypointAddon()
	if not self.ConnectedWaypointer then return end
	local addon = self.db.profile.waypointaddon
	if not addon or addon=="none" then return end

	if not self:IsWaypointAddonEnabled() then
		self:Debug("Not enabled, out.")
		return
	end --nothing to do here, move along

	if not self:IsWaypointAddonReady() then return end

	self.ConnectedWaypointer.disconnect(self)
	self.ConnectedWaypointer = nil

	self:Print(L["waypointaddon_disconnected"]:format(L["opt_group_addons_"..addon]))
end

function ZGV:IsWaypointAddonReady(addon)
	if not addon then addon = self.db.profile.waypointaddon end
	return self.WaypointFunctions[addon].isready(self)
end

function ZGV:IsWaypointAddonEnabled(addon)
	if not addon then addon = self.db.profile.waypointaddon end
	return self.db.profile.waypointaddon==addon and self:IsWaypointAddonReady(addon) -- and self.iconsregistered
end



function ZGV:qRegisterNotes()
	if not self.CurrentStep then return end
	-- use for pre-registering. Cartographer needs that, while TomTom does not.
	
	-- retrying 3 times
	if self.iconsregistered then return end
	if not self.iconregistryretries then self.iconregistryretries=0 end
	if self.iconregistryretries==3 then
		self:Print(L["waypointaddon_fail"]:format(L["opt_group_addons_"..self.db.profile.waypointaddon]))
		if not self.autodetectingwaypointaddon then
			self:AutodetectWaypointAddon()
		end

	end
	if self.iconregistryretries>3 then return end
	self.iconregistryretries = self.iconregistryretries + 1

	if not self:IsWaypointAddonReady() then return end

	--self:Print(L["waypointaddon_connecting"]:format(self.optionsmap.args.waypoints.values[self.db.profile.waypointaddon]))

	local addon = self.db.profile.waypointaddon

	if addon=="tomtom" then
		--[[
		if not self.db.profile.filternotes then
			self:Print("Creating all waypoints for TomTom. This may take a while.")
			local contid,zoneid
			for zone in pairs(self.MapNotes) do
				local zoneTr = BZL[zone]
				contid,zoneid = self:GetMapZoneNumbers(zoneTr)
				self:Debug("contid="..ns(contid).." zoneid="..ns(zoneid).." for "..ns(zoneTr))
				if contid and zoneid and (type(self.MapNotes[zone])=="table") then
					if (TomTom:GetMapFile(contid,zoneid)) then
						for note,mapnote in pairs(self.MapNotes[zone]) do
							x,y = self:getXY(note)
							--self:Debug("x="..ns(x).." y="..ns(y))
							if x and y then
								--self:Debug(GetCurrentMapContinent().." "..ns(note).." "..ns(zone).." x"..ns(x).." y"..tostring(y))
								self.TomTomWaypoints[#self.TomTomWaypoints+1] = TomTom:AddZWaypoint(
									contid,zoneid,x*100,y*100,
									self.MapNotes[zone][note].title, --desc
									false, --persistent
									true, true, --minimap,world
									nil,true, --callbacks,silent
									(zone==self.CurrentStep.mapzone and note==self.CurrentStep.mapnote) --arrow
								)
							end
						end
					else
						self:Print("No map data for continent id "..ns(contid)..", zone id "..ns(zoneid)..", zone "..ns(zone)..", please report.")
					end
				end
			end
		end
		--]]
	elseif addon=="cart2" then
		--[[
		self:Debug("registering database "..#self.MapNotes)
		Cartographer_Notes:RegisterNotesDatabase('ZygorGuides', self.MapNotes, self)
		self:Debug("registered database")

		self:Debug("registering icons")
		if not self.iconsregistered then
			for k,v in pairs(self.icons) do
				Cartographer_Notes:RegisterIcon(k, v)
			end
		end
		--]]
	elseif addon=="internal" then
	end

	self:Print(L["waypointaddon_connected"]:format(L["opt_group_addons_"..addon]))
	self:Debug("registered icons")
	self.iconsregistered = true
	self.iconregistryretries = 0

	self:SetWaypoint()
end





-- icon handlers:

function ZGV:GetNoteScaling(zone,id,data)
	return self.db.profile.iconScale
end

function ZGV:IsNoteHidden(zone,id,data)
	return self.db.profile.filternotes and (not self.CurrentStep or not self.CurrentStep.mapnote or (id~=self.CurrentStep.mapnote) or (zone~=self.CurrentStep.mapzone))
end

function ZGV:IsMiniNoteHidden(zone,id,data)
	return not self.db.profile.minicons or (self.db.profile.filternotes and ((id~=self.CurrentStep.mapnote) or (zone~=self.CurrentStep.mapzone)))
end

function ZGV:GetNoteTransparency(zone,id,data)
	return self.db.profile.iconAlpha
end

function ZGV:GetNoteIcon(zone,id,data)
--	return (not self.db.profile.filternotes and self.CurrentStep and (id==self.CurrentStep.mapnote) and (zone==self.CurrentStep.mapzone)) and "hilite" or data.icon
	return (self.CurrentStep and (id==self.CurrentStep.mapnote) and (zone==self.CurrentStep.mapzone)) and (data.icon=="Square" and "hilitesquare" or "hilite") or data.icon
end



-------------------------- Cartographer stuff

function ZGV:ClearCartographerWaypoints()
	if Cartographer_Waypoints then
		for i,v in ipairs(Cartographer_Waypoints.Queue) do
			v:Cancel()
			Cartographer_Waypoints.Queue[i]=nil
		end
	end
	if Cartographer_Notes and Cartographer_Notes.externalDBs["ZygorGuidesViewer"] then
		Cartographer_Notes:UnregisterNotesDatabase("ZygorGuidesViewer")
	end
end

function ZGV:CreateCartographerWaypoints(goalnum)
	if not self.CurrentStep or not self.CurrentStep.goals then return end

	local x,y,zone

	local db = {version=3}

	local waypoints = {}

	-- set mapnotes for all the coordinates found in step lines
	-- REVERSE direction to create proper waypoint queue
	for i=#self.CurrentStep.goals,1,-1 do
		local g = self.CurrentStep.goals[i]
		if g.x and not g.force_noway then
			zone = g.map
			if zone then
				if self.BZR[zone] then zone = self.BZR[zone] end
				local note = Cartographer_Notes.getID(g.x/100,g.y/100)
				if not db[zone] then db[zone]={} end
				db[zone][note]={icon="Circle",title=g.title or self.CurrentStep.title or g.autotitle or self.CurrentStep:GetWayTitle() or L['waypoint_step']:format(self.CurrentStepNum)}

				if (i==goalnum) or not goalnum then
					table.insert(waypoints,{zone=zone,note=note})
				end
			end
		end
	end

	Cartographer_Notes:RegisterNotesDatabase("ZygorGuidesViewer",db)

	for i,way in ipairs(waypoints) do
		Cartographer_Waypoints:SetNoteAsWaypoint(way.zone,way.note)
	end

	Cartographer_Notes:MINIMAP_UPDATE_ZOOM()
end

function ZGV:CreateCartographerWaypointXY(x,y,title)
	local zone = select(GetCurrentMapZone(), GetMapZones(GetCurrentMapContinent())) -- likely fails in Scarlet Enclave
	Cartographer_Waypoints:AddWaypoint(NotePoint:new(zone, x, y, title or "Waypoint"))
end


function ZGV:UpdateCartographerExport()
	if ((self.db.profile.waypointaddon~="cart2") and (self.db.profile.waypointaddon~="cart3")) then return end  -- or (not self.iconsregistered) 

	Cartographer_Notes:MINIMAP_UPDATE_ZOOM()
	Cartographer_Notes:UpdateMinimapIcons()
	Cartographer_Notes:RefreshMap()
end



-------------------------- TomTom stuff

do
	local lastwaypath 		-- Optimization: don't reset the path each time
	
	function ZGV:ClearTomTomWaypoints()
		--self:Debug("Clearing TomTom waypoints:")
		for i,p in ipairs(self.TomTomWaypoints) do
			--self:Debug(p)
			TomTom:RemoveWaypoint(p)
		end
		self.TomTomWaypoints = {}
		lastwaypath=nil
		self.Pointer:ClearWaypoints("ant") -- if anything
	end

	function ZGV:CreateTomTomWaypath(waypath)
		if waypath and #waypath.coords>1 and waypath~=lastwaypath then
			self:ClearTomTomWaypoints()
			lastwaypath=waypath
			self:Debug("New waypath available, installing the points")
			-- Table containing the next element in path for each point
			local waypathnavigation={} 
			local firstuid,prevuid,currentcrazy -- WARNING if the user manually adds a point, we're DOOOMED
			
			for k,v in ipairs(waypath.coords) do
				-- Creating waypoint, remembering its uid
				local uid=self:CreateTomTomWaypointMFXY(v.map,v.floor or 0,v.x/100,v.y/100,"Path("..k..")",--[[TODO this should be localized perhaps]]
				false,function(event,uid)
					if uid and uid==currentcrazy then
						if waypathnavigation and waypathnavigation[uid] then
							-- Strangely enough I see no way to ask TomTom which waypoint the Crazy Arrow is looking at
							-- hence this ugly hack. We should probably conctact him, because it's plainly silly. ~aprotas
							currentcrazy=waypathnavigation[uid]
							TomTom:SetCrazyArrow(waypathnavigation[uid], -- I guess I've learned lexical closure, Obi-Wan. ~aprotas
								TomTom.profile.arrow.arrival,waypathnavigation[uid].title)
						end
					end
				end
				)
				
				-- Setting the linkage 
				if firstuid then -- "if we're not the first waypoint"
					waypathnavigation[prevuid]=uid
				end
				
				-- Remembering the uid 
				prevuid=uid if not firstuid then firstuid = uid end
			end
			-- Connecting the last and the first
			-- TODO what about acyclic waypaths?
			waypathnavigation[prevuid]=firstuid
			
			-- CopyPasted from TomTom.lua, otherwise we'd be writing it either way
			local m,f,x,y = TomTom:GetCurrentPlayerPosition()
			local closest_waypoint = nil
			local closest_dist = nil
			if self.TomTomWaypoints then 
				for key, waypoint in pairs(self.TomTomWaypoints) do -- Only iterating through OUR waypoints unlike the original
					local dist, x, y = TomTom:GetDistanceToWaypoint(waypoint) 
					if (dist and closest_dist == nil) or (dist and dist < closest_dist) then
						closest_dist = dist
						closest_waypoint = waypoint
					end
				end
			end
			-- Important: we can't track CrazyArrow, so let's just remember
			currentcrazy=closest_waypoint
			TomTom:SetCrazyArrow(closest_waypoint,TomTom.profile.arrow.arrival,closest_waypoint.title)
		else
-- 			ZGV:CreateTomTomWaypointMFXY( TODO
		end
	end     -- TODO unify the logic with Carbonite and Internal waypointer
end

function ZGV:CreateTomTomWaypoints(goalnum)
	lastwaypath=nil -- Just in case

	--if not Astrolabe.ContinentList[101] then Astrolabe.ContinentList[101] = {[1]="ScarletEnclave"} end
	if not self.CurrentStep or not self.CurrentStep.goals then return end
	
	if (TomTom.profile and TomTom.profile.persistence) then
		TomTom.profile.persistence.cleardistance = 0
	end

--	if self.CurrentStep.mapnote then

	local x,y,zone

	for i=#self.CurrentStep.goals,1,-1 do
		local goal = self.CurrentStep.goals[i]
		if goal.x and not goal.force_noway then
			if goal.map then
				-- TODO should we need to ever give floor id?
				self:CreateTomTomWaypointMFXY(
					goal.map, goal.floor or 0,
					goal.x/100, goal.y/100,
					goal.title or self.CurrentStep.title or goal.autotitle or self.CurrentStep:GetWayTitle() or "Step "..self.CurrentStepNum,
					(i==goalnum or not goalnum)
				)
						
				--self:Debug("added to TomTom as:"..(way or 'nil'))
				if way then table.insert(self.TomTomWaypoints, way) end
			end
		end

	end

end

function ZGV:CreateTomTomWaypointXY(x,y,title,arrow,func)
	return self:CreateTomTomWaypointMFXY(GetCurrentMapAreaID(),GetCurrentMapDungeonLevel(),x/100,y/100,title,arrow,func)
end

function ZGV:CreateTomTomWaypointMXY(m,x,y,title,arrow,func)
	return self:CreateTomTomWaypointMFXY(m,0,x,y,title,arrow,func)
end

function ZGV:CreateTomTomWaypointMFXY(m,f,x,y,title,arrow,func)
	-- Sanity, sanity everywhere
	if ZGV and ZGV.Pointer and ZGV.Pointer:IsEnvironmentPhased(m) then
		ZGV:Debug("The player and the target are in the same phased environment, putting a marker on the current map instead.")
		m,f=GetCurrentMapAreaID(),GetCurrentMapDungeonLevel()
	end
	
	self:Debug("Setting TomTom waypoint: "..m..' '..f..' '..x..' '..y)
	-- Okay, if we accidently set the callback to arrivaldistance set in TomTom, he's gonna mercilessly overwrite us
	-- Let's pick some other number
	local procdistance=(max(TomTom.profile.arrow.arrival,TomTom.profile.arrow.arrival) or 15)*2 -- 30 if the option is nil for some reason

	-- This is an internal TomTom's function so it uses different syntax, table is correct here
	local way = TomTom:AddMFWaypoint(
		m, f,
		x, y,
		{ 
			title = title,
			persistent = false,
			minimap = true,
			world = true,
			callbacks = func and { distance = { [procdistance] = func} } or nil,
			silent = true,
			crazy = arrow,
		})

	if way then table.insert(self.TomTomWaypoints, way) end
	return way
end

--- Ah, who needs this crap anymore anyway... ~sinus 2011-08-15

--[[
function ZGV:CreateTomTomWaypointZXY(m,f,x,y,title,arrow)
	-- Can't find a mention of SpecialMapNames which are used by GetMapZoneNumbers
	-- using this stub implementation by now, should work every time the other one used to ~aprotas
end

-- TODO following implementations were mapzone-text dependent and used a contid,zoneid system
-- since TomTom natively supports mapid addressation I reworked this code to use mapid, and leave 
-- these originals in case it's not intended
-- Also, it should make the last lookup functions rudimentary as well. ~aprotas

-- function ZGV:CreateTomTomWaypointXY(x,y,title,arrow)
-- 	return self:CreateTomTomWaypointZXY(GetRealZoneText(),x,y,title,arrow)
-- end
-- 
-- function ZGV:CreateTomTomWaypointZXY(zone,x,y,title,arrow)
-- 	local contid,zoneid = self:GetMapZoneNumbers(zone)
-- 	return self:CreateTomTomWaypointCZXY(contid,zoneid,x,y,title,arrow)
-- end
-- 
-- function ZGV:CreateTomTomWaypointCZXY(contid,zoneid,x,y,title,arrow)
-- 	print(contid..' '..zoneid..' '..x..' '..y)
-- 	self:Debug(x..' '..y)
-- 	local way = TomTom:AddZWaypoint(
-- 		contid, zoneid,
-- 		x, y,
-- 		title or self.CurrentStep.title or "Step "..self.CurrentStepNum,
-- 		false, --persistent
-- 		true, --minimap
-- 		true, --world
-- 		nil, --custom_callbacks
-- 		true, --silent
-- 		arrow --arrow
-- 	)
-- 	if way then table.insert(self.TomTomWaypoints, way) end
-- end

local MapZoneCache={}
-- supply ENGLISH zone names please.
function ZGV:GetMapZoneNumbers(zonename)
	--local engzone = self.BZR[zonename]
	local cached = MapZoneCache[zonename]
	if cached then return cached[1],cached[2] end

	if Astrolabe.SpecialMapNames and Astrolabe.SpecialMapNames[zonename] then
		local data=Astrolabe.SpecialMaps[Astrolabe.SpecialMapNames[zonename] ]
		MapZoneCache[zonename]=data
		return data[1],data[2]
	end
	local loczone=self.BZL[zonename]
	for cont in pairs{GetMapContinents()} do
		for zone,name in pairs{GetMapZones(cont)} do
			if name==loczone then
				MapZoneCache[zonename]={cont,zone}
				return cont,zone
			end
		end
	end
	return 0
end

-- only for TomTom support, Astrolabe bundled
local MapFileCache={}
function ZGV:GetMapZoneFile(zonename)
	local cached = MapFileCache[zonename]
	if cached then return cached[1],cached[2] end

	local data = Astrolabe.SpecialMapNames[zonename]
	if data then
		return data
	end

	local loczone=self.BZL[zonename]
	for cont in pairs{GetMapContinents()} do
		for zone,name in pairs{GetMapZones(cont)} do
			if name==loczone then
				return Astrolabe.ContinentList[cont][zone]
			end
		end
	end
	return ""
end
--]]

--EVIL STUFF. Hacking the ORIGINAL GetMapContinents(). This is bad, bad, bad - but Blizzard broke the rules by creating an off-world zone first... ;P
--[[
local continentlist = { GetMapContinents() }
table.insert(continentlist,ZygorGuidesViewer.BZL["Plaguelands: The Scarlet Enclave"])
function GetMapContinents()
	return unpack(continentlist)
end
local _GetMapZones = GetMapZones
function GetMapZones(cont)
	if cont<5 then
		return _GetMapZones(cont)
	else
		return ZygorGuidesViewer.BZL["Plaguelands: The Scarlet Enclave"]
	end
end
--]]