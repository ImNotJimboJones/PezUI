--[[
Name: LibRover-1.0
Revision: $Rev: 1 $
Author(s): sinus (sinus@sinpi.net)
Description: A library calculating travel paths from point A to point B.
Dependencies: None
License: MIT
]]

-- BabbleZone or somesuch heavily suggested. This library uses English map names.

local MAJOR_VERSION = "LibRover-1.0"
local MINOR_VERSION = tonumber(("$Revision: 1 $"):match("%d+"))

local name,_L = ...
-- #AUTODOC_NAMESPACE prototype

local GAME_LOCALE = GetLocale()

do
	local LIB_MAJOR, LIB_MINOR = "LibRover-1.0", 1

	local Lib = LibStub:NewLibrary(LIB_MAJOR, LIB_MINOR)
	_L.Lib = Lib

	_G['LibRover'] = Lib

	LibR_L = _L

	if Lib then

		Lib.data = _L.data   _L.data = nil

		Lib.opennodes = { }
		Lib.closednodes = { }

		Lib.masternodes = {}

		Lib.knowntaxis = {}
	
		local TYPE_BORDER = 1
		local TYPE_TAXI = 3
		local TYPE_START = 4
		local TYPE_END = 5

		local WAY_GROUND = 1
		local WAY_SHIP = 2
		local WAY_TAXI = 3

		-- ONE WAY. Run twice to do two-way.
		-- Checks if n1 sees n2.
		local function DoNodeLinkage(n1,n2)
			for t,to in pairs(n1.to) do
				if (#to==2 and to[1]==n2.l[1] and to[2]==n2.l[2]) -- they see us using "see all zone"
				or ((type(to)==number or type(to)==string) and n2.id==to) -- direct link to us
				then
					n1.n[i]=WAY_GROUND
				end
			end
			for t,to in pairs(n1.taxi) do
				if (#to==2 and to[1]==n2.l[1] and to[2]==n2.l[2]) -- they see us using "see all zone"
				or ((type(to)==number or type(to)==string) and n2.id==to) -- direct link to us
				then
					n1.n[i]=WAY_TAXI
				end
			end
		end

		-- local
		function Lib:AddNode(node)
			--if not self.nodes[node.l[1]] then self.nodes[node.l[1]]={} end
			node.n={}
			table.insert(self.masternodes,node)
			local ni = #self.masternodes
			node['#']=ni

			local l=n.l

			-- connect to other nodes in the zone, by ground
			for i,v in pairs(self.masternodes) do
				if i~=ni then
					DoNodeLinkage(v,node)
					DoNodeLinkage(node,v)
				end
			end
		end

		do -- trim taxis by faction
			local myfac = UnitFactionGroup("player")=="Alliance" and "A" or "H"
			for c,cont in pairs(Lib.data.basenodes.taxis) do
				for z,zone in pairs(cont) do
					local n=1
					while n<=#zone do
						if zone[n].faction~="B" and zone[n].faction~=myfac then
							tremove(zone,n)
						else
							n=n+1
						end
					end
				end
			end
		end

		local Astrolabe
		function Lib:GetNearestTaxi()
			Astrolabe = Astrolabe or DongleStub("Astrolabe-1.0")
			if not Astrolabe then return end
			local mindist=999999
			local minnode
			local m,f,x,y = Astrolabe:GetCurrentPlayerPosition()
			for n,node in ipairs(Lib.data.taxis) do	
				if node.m and node.x and node.y then
					local dist = Astrolabe:ComputeDistance(m,f,x,y,node.m,node.f,node.x/100,node.y/100)
					if dist and dist<mindist then mindist,minnode=dist,node end
				end
			end
			return minnode,mindist
		end

		function Lib:GetNearestTaxiInZone()
			pmap = GetCurrentMapAreaID()
			Astrolabe = Astrolabe or DongleStub("Astrolabe-1.0")
			if not Astrolabe then return end
			local mindist=999999
			local minnode
			local m,f,x,y = Astrolabe:GetCurrentPlayerPosition()
			for n,node in ipairs(Lib.data.taxis) do	
				if node.m and node.x and node.y and node.m == pmap then
					local dist = Astrolabe:ComputeDistance(m,f,x,y,node.m,node.f,node.x/100,node.y/100)
					if dist and dist<mindist then mindist,minnode=dist,node end
				end
			end
			return minnode,mindist
		end

		--[=[

		function Lib:ImportTaxis(taxiset)
			local knownTaxis = self.LibTaxi.master
			for name,data in pairs(taxiset) do
				if type(data)~="number" then
					if knownTaxis[name] then
						if type(data[1]=="table") then -- new style, proper
							local loc=data[1]
							if type(loc[1])=="string" then -- lo
							--TODO everything
							end
						end
						if type(data[3])=="table" then
							-- table = faction-specific data
							if UnitFactionGroup("player")=="Alliance" then
								data[3],data[4] = data[3][1],data[3][2]
							else
								data[3],data[4] = data[4][1],data[4][2]
							end
						end

						self:AddNode({l={data[1],data[2],data[3],data[4]},taxi={"taxi"..data[1]},id="taxi"..data[1],t=TYPE_TAXI,t2=name})
					end
				end
			end
		end

		Lib.basenodes.borders = {
			-- kalimdor
			{ {118,36.00,54.50},{16,88.9,35.2},"Teldrassil","Darnassus"},
			{ {103,41.70,01.70},{14,65.0,95.0},"Azuremyst Isle","Bloodmyst Isle"},
			{ {105,44.20,96.00},{11,28.5,12.9},"Darkshore","Ashenvale"},
			{ {101,55.60,26.30},{110,55.5,92.4},"Ashenvale","Felwood"},
			{ {110,66.00,04.80},{112,35.1,76.1},"Felwood","Moonglade"},
			{ {110,66.00,04.80},{124,27.2,42.1},"Felwood","Winterspring"},
			{ {101,94.50,48.30},{12,9.7,74.4},"Ashenvale","Azshara"},
			{ {101,68.50,87.80},{119,48.8,4.3},"Ashenvale","The Barrens"},
			{ {101,41.60,74.70},{116,78.3,41.6},"Ashenvale","Stonetalon Peak"},
			{ {116,28.70,81.80},{17,53.9,3.4},"Stonetalon Peak","Desolace"},
			{ {116,83.50,96.70},{119,33.9,27.8},"Stonetalon Peak","The Barrens"},
			{ {119,63.00,18.90},{18,33.9,42.4},"The Barrens","Durotar"},
			{ {119,41.10,58.60},{113,71.0,59.8},"The Barrens","Mulgore"},
			{ {119,50.10,78.30},{19,28.8,47.2},"The Barrens","Dustwallow Marsh"},
			{ {119,44.20,90.90},{121},"The Barrens","Thousand Needles"},
			{ {121,04.60,12.90},{111},"Thousand Needles","Feralas"},
			{ {111,45.90,03.40},{17},"Feralas","Desolace"},
			{ {121,75.10,95.90},{117},"Thousand","Tanaris"},
			{ {117,26.10,55.00},{123},"Tanaris","Un'goro"},
			{ {123,27.20,20.10},{123,27.2,20.1},{1,15},"Un'goro","Silithus"},

			-- Eastern
		}

		function Lib:ImportBorders()
			for name,data in pairs(self.basenodes_borders) do
				self:AddNode({
					l={data[1][1],data[1][2],data[1][3],data[1][4]},
					to={{data[1][1],data[1][2]},{data[2][1],data[2][2]}},
					t=TYPE_BORDER,
					t2={data[3],data[4]},
					n={}
				})
			end
		end


		function Lib:ShowNodes()
			for k,n in pairs(Lib.masternodes) do ZGV.Pointer:SetWaypoint(n.l[1],n.l[2],n.l[3],n.l[4],"") end
		end


		local function addOpenNode(i)
			
		end

		--- Drop our special start/end nodes from the map
		function Lib:ClearPath()
			local removed,node,lastn
			while (Lib.masternodes[#Lib.masternodes].t==TYPE_START or Lib.masternodes[#Lib.masternodes].t==TYPE_END) do
				removed = table.remove(Lib.masternodes)
				for i,n in pairs(removed.n) do
					node=Lib.masternodes[n]
					while Lib.masternodes[node.n[#node.n]].t==TYPE_START or Lib.masternodes[node.n[#node.n]].t==TYPE_END do
						table.remove(node.n)
					end
				end
			end
		end

		function Lib:FindPath(ac,az,ax,ay,bc,bz,bx,by)
			self:ClearPath()

			self.startnode = {l={ac,az,ax,ay},t=TYPE_START}
			self.endnode = {l={bc,bz,bx,by},t=TYPE_END}
			self:AddNode(self.startnode)
			self:AddNode(self.endnode)
			self.opennodes = {{node=self.startnode,tcost=0,heur=0,cost=0}}
			self.closednodes = {}

			self.calculating = true
			self.calculation_step = 0

			-- calculation kicks off in frame updates
		end


		function Lib:NodeToString(node)
			if node.t==TYPE_BORDER then
				return ("[%d] %s x %s"):format(node['#'],node.t2[1],node.t2[2])
			elseif node.t==TYPE_TAXI then
				return ("[%d] %s taxi"):format(node['#'],node.t2)
			else
				return ("[%d] %d %d %d %d"):format(node['#'],node.l[1],node.l[2],node.l[3],node.l[4])
			end
		end

		--]=]

		-- one-step A*
		
		local closingnode,mintcost,current,currenti,found
		local cost,heur
		local cl,nl,el
		local neigh,neighwrap

		function Lib:StepPath()
			if not self.calculating then return end

			self.calculation_step = self.calculation_step + 1

			if #self.opennodes>0 then
				
				-- find cheapest open node
				
				mintcost=self.opennodes[1].tcost
				currenti=1
				for i,node in ipairs(self.opennodes) do
					if node.tcost<mintcost then mintcost=node.tcost currenti=i end
				end

				-- remove from open nodes

				current = table.remove(self.opennodes,currenti)
				if current.node == self.endnode then
					print("END")
					return self:ReportPath(current)
				end

				print (("Opening node: %s"):format(self:NodeToString(current.node)))

				-- insert into closed
				
				table.insert(self.closednodes,current)

				-- process neighbours:

				for neighi,neighmeta in pairs(current.node.n) do

					neigh = self.masternodes[neighi]

					-- is in closed list? if yes, bail out

					found=nil
					for i,wrap in ipairs(self.closednodes) do
						if wrap.node==neigh then found=true break end
					end

					if not found then

						-- we'll be handling this one, eh? okay, cost calculation

						if neighmeta.w == WAY_TAXI then
							cost = 0 -- until we have a taxi timetable
						elseif neighmeta.w == WAY_TELEPORT then
							cost = 0
						else
							cl = current.node.l
							nl = neigh.l
							el = self.endnode.l
							cost = current.cost + Astrolabe:ComputeDistance(cl[1],cl[2],cl[3],cl[4],nl[1],nl[2],nl[3],nl[4])
							heur = Astrolabe:ComputeDistance(nl[1],nl[2],nl[3],nl[4],el[1],el[2],el[3],el[4])
							-- divide by movement speed later
						end

						-- maybe it's in the open list?

						found=nil
						for i,wrap in ipairs(self.opennodes) do
							if wrap.node==neigh then neighwrap=wrap found=true break end
						end

						-- not in there? add it.

						if not found then
							neighwrap={node=neigh}
							table.insert(self.opennodes,neighwrap)
						end

						-- or perhaps just our path is better?

						if not found or neighwrap.tcost>cost+heur then
							neighwrap.cost,neighwrap.heur,neighwrap.tcost = cost,heur,cost+heur
							neighwrap.parent = current
						end

					end
				end

				print (("Step %d: %d open, %d closed, distance %d"):format(self.calculation_step,#self.opennodes,#self.closednodes,cost or 0))
			else
				return self:ReportFail()
			end
		end

		local n
		function Lib:ReportPath(endwrap)
			self.calculating = nil
			local results = {}
			while endwrap do
				table.insert(results,1,endwrap)
				endwrap = endwrap.parent
			end
			print ("Path:")
			for i,w in ipairs(results) do
				print (("%d. %s (cost %d)"):format(i,self:NodeToString(w.node),w.tcost))
			end
		end

		function Lib:ReportFail()
			self.calculating = nil
			print("No route found.")
		end





		function Lib:RebuildNodes()
			wipe(self.masternodes)

			self:ImportTaxis(self.basenodes_taxis_N)
			if UnitFactionGroup("player")~="Alliance" then
				self:ImportTaxis(self.basenodes_taxis_A)
			else
				self:ImportTaxis(self.basenodes_taxis_H)
			end

			self:ImportBorders()
		end

		local basespeed=20

		function Lib:GetMaxSpeeds()
			local function HasAchievement(id)
				return select(4,GetAchievementInfo(id))
			end

			local riding = (HasAchievement(892) and 300)
				    or (HasAchievement(890) and 225)
				    or (HasAchievement(889) and 150)
				    or (HasAchievement(891) and 75)
				    or 0 -- this is thanks to Maldivia, who is a fucking genius

			local cold = GetSpellInfo(GetSpellInfo(54197))

			local flightlicense = GetSpellInfo(GetSpellInfo(90267))
			
			-- areas:
			-- 1 = Azeroth (no flying)
			-- 2 = Outland (flying)
			-- 3 = Northrend (flying with cold)

			Lib.speeds = {
				[1] = 1.0 + ( flightlicense and ((riding>=300 and 2.8) or ((riding>=225 and 1.5))) or ((riding>=150 and 1.0) or (riding>=75 and 0.6) or 0) ),
				[2] = 1.0 + (                    (riding>=300 and 2.8) or  (riding>=225 and 1.5)   or  (riding>=150 and 1.0) or (riding>=75 and 0.6) or 0),
				[3] = 1.0 + ( cold          and ((riding>=300 and 2.8) or ((riding>=225 and 1.5))) or ((riding>=150 and 1.0) or (riding>=75 and 0.6) or 0) ),
			}
		end

		--[[
		function Lib:OnUpdate()
			if not self.importedTaxis then
				self:RebuildNodes()
				self.importedTaxis = true
			end
			Lib:StepPath()
		end
    
		local function warn(message)
			local _, ret = pcall(error, message, 3)
			geterrorhandler()(ret)
		end
		
		--]]

		local function onEvent(this, event, arg1)
			if event=="ADDON_LOADED" and not Lib.loaded then
				
				do -- add map IDs to taxis
					local flattaxis = {}
					setmetatable(flattaxis,{__mode='v'})

					for c,cont in pairs(Lib.data.basenodes.taxis) do
						for z,zone in pairs(cont) do
							local id=Lib.data.MapIDsByName[z]
							if type(id)=="table" then id=id[1] end
							for n,node in ipairs(zone) do
								node.m = id
								tinsert(flattaxis,node)
							end
						end
					end
					Lib.data.taxis = flattaxis
				end

				-- if available, try to glean known taxi routes. Otherwise assume they're not known.
				Lib.LibTaxi = LibStub("LibTaxi-1.0")
				if Lib.LibTaxi then
					Lib.LibTaxi:Startup(Lib.knowntaxis)
				end

				Lib:GetMaxSpeeds()

				Lib.loaded=true
			elseif event=="ACHIEVEMENT_EARNED" or event=="LEARNED_SPELL_IN_TAB" then
				Lib:GetMaxSpeeds()
			end
		end

		Lib.frame = CreateFrame("Frame", "LibRoverFrame")
		Lib.frame:RegisterEvent("ADDON_LOADED")
		Lib.frame:SetScript("OnEvent", onEvent)
		--Lib.frame:SetScript("OnUpdate", function() Lib:OnUpdate() end)

	end

end

local MapZoneCache={}
local cached
local function GetMapZoneNumbers(zonename)
	if zonename==self.BZL["Plaguelands: The Scarlet Enclave"] then return 5,1 end
	cached = MapZoneCache[zonename]
	if cached then return unpack(cached) end
	for cont in pairs{GetMapContinents()} do
		for zone,name in pairs{GetMapZones(cont)} do
			if name==zonename then
				MapZoneCache[zonename]={cont,zone}
				return cont,zone
			end
		end
	end
	return 0
end

