--edited by shUI--
--NOTE: I used tekkub coding for this mod, I added on a bunch of my code to his code to create the two new databrokers!

--[[----------------CONFIG---------------------
NOTE: databrokers will always update in real time, this is just configuring the tooltip

wantAlphaSorting
	false: sorts addon list by usage (descending) 
	true: sorts addon list in alphabetical order
	
wantColoring
	true: colors addon names AND memusage 
	false: just colors memusage and applies them to colors labeled in toc
	
UPDATEPERIOD
	number (seconds) that your data broker AND tooltip will be updated IMPORTANT!!!! ANYTHING UNDER 2 will likely effect performance!

MEMTHRESH
	number (kb) that will limit addon visibility, anything less than this number will NOT show in tooltip
	
colorgradient
	number that corresponds to the top "red" value of your addon usage..used for gradience and Tekkub color gradient function

maxaddons	
	max number of addons that will be displayed in tooltip. NOTE: if you are using alphabetical sorting it will NOT display all addons and will 
	cut off based on this number.  Keep default value of 100 if you do not want that to happen	
]]
local wantAlphaSorting = true 
local wantColoring = true 
local UPDATEPERIOD = 2 
local MEMTHRESH = 60
local colorgradient = 50 
local maxaddons = 100 
------------------END of CONFIG---------------

if not LibStub then error("sh:Performance requires LibStub") end

local dev = (UnitName("player") == "Shaikh" or "Elshaikh" or "Shaykh" or "Drbootymd") --> for development purposes only, keep false 
local prevmem, tipshownMem, tipshownLatency = collectgarbage("count")
local format, modf, floor, GetNetStats, GetFramerate, collectgarbage, lower = format, math.modf, floor, GetNetStats, GetFramerate, collectgarbage, lower
local UpdateAddOnMemoryUsage, GetAddOnMemoryUsage, GetAddOnInfo, select, gcinfo, sort = UpdateAddOnMemoryUsage, GetAddOnMemoryUsage, GetAddOnInfo, select, gcinfo, sort

if collectgarbage then collectgarbage('collect') end

local fpsIcon = "Interface\\AddOns\\shPerformance\\media\\fpsicon"
local memIcon = "Interface\\AddOns\\shPerformance\\media\\memicon"
local msIcon = "Interface\\AddOns\\shPerformance\\media\\msicon" 

---------------------
--> FUNCTIONS
---------------------

-->sort based on usage (will check to see what usage in tooltip updater)
local function usageSort (a,b) 
	return GetAddOnMemoryUsage(a) > GetAddOnMemoryUsage(b)
end

-->main table
local addons = {} 
for i=1,GetNumAddOns(), 1 do
	local tester = select(4,GetAddOnInfo(i))
	if  tester == 1 then -->check to see if addon is even enabled 
		local name = select(1,GetAddOnInfo(i))
		table.insert(addons, name)
	end 
end
sort(addons, function(a,b) return a and b and a:lower() < b:lower() end)

--[[>my memory updater
local totalMemory, memText, i 
local function UpdateMemory(self)
	totalMemory = 0
	UpdateAddOnMemoryUsage()
	
	for i,v in ipairs(addons) do
		if IsAddOnLoaded(v) then
			memory = GetAddOnMemoryUsage(v)
			totalMemory = totalMemory + memory 
		end
	end		
end]]

-->Format Mem with stylez
local function formatMem(mem)
	--local out = 0
	if mem > 1024 then return format("%.2f mb", mem/1024)
	else return format("%.1f kb", mem) end
	--return out
end

-->Used to format the dataobj.text display with the correct coloring
local function formatMem2(mem)
	--local out = 0
	if mem > 1024 then return format("%.2f |cffE8D200mb|r", mem/1024)
	else return format("%.1f |cffE8D200kb|r", mem) end
	--return out
end

-->TEKKUB created function for color gradience, awesome!--
local function ColorGradient(perc, r1, g1, b1, r2, g2, b2, r3, g3, b3)
	if perc >= 1 then return r3, g3, b3 elseif perc <= 0 then return r1, g1, b1 end
	local segment, relperc = modf(perc*2)
	if segment == 1 then r1, g1, b1, r2, g2, b2 = r2, g2, b2, r3, g3, b3 end
	return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

-->tooltip anchor
local function GetTipAnchor(frame)
	local x,y = frame:GetCenter()
	if not x or not y then return "TOPLEFT", "BOTTOMLEFT" end
	local hhalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or (x < UIParent:GetWidth()/3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end

----------------------
--> MODULES AND FRAMES
----------------------
local ffps = CreateFrame("frame")
local flatency = CreateFrame("frame")
--local fmem = CreateFrame("frame")

local lib = LibStub:GetLibrary("LibDataBroker-1.1")
local datafps = lib:NewDataObject("shFps", {	type = "data source", text = "Calculating...fps", icon = memIcon }) 
local datalatency = lib:NewDataObject("shLatency", { type = "data source", text = "Checking...ms", icon = msIcon }) 
--local datamem = lib:NewDataObject("shMem", { type = "data source", text = "Calculating... mB/kB", icon = memIcon }) 

-->shMemory OnUpdate script to reduce memory usage and stop the jittering
--[[local elapsedMemoryController = 0
local throttle = 0
local rmem, gmem, bmem
fmem:SetScript("OnUpdate", function(self,t)
	elapsedMemoryController = elapsedMemoryController - t
	throttle = throttle - t

	--> throttle UpdateMemory to reduce memory usage
	if throttle < 0 then 
		UpdateMemory(self)
		memText = formatMem2(totalMemory)
		throttle = 10
	end	

	if elapsedMemoryController < 0 then
		rmem, gmem, bmem = ColorGradient(totalMemory/colorgradient, 1,0,0, 1,1,0, 0,1,0)
		datamem.text = format("|cff%02x%02x%02x%s", rmem*255, gmem*255, bmem*255, memText)
		 
		elapsedMemoryController = UPDATEPERIOD
	end
end)
-->end of new throttled onupdate function]]

----------------------
--> ONUPDATE HANDLERS
----------------------

-->shFps OnUpdate script
local elapsedFpsController = 0
ffps:SetScript("OnUpdate", function(self, t)
	elapsedFpsController = elapsedFpsController - t
	if elapsedFpsController < 0 then 
		if tipshownMem then datafps.OnEnter(tipshownMem) end
		local fps = floor(GetFramerate())
		local r, g, b = ColorGradient(fps/75, 1,0,0, 1,1,0, 0,1,0)
		datafps.text = format("|cff%02x%02x%02x%.0f|r |cffE8D200fps|r", r*255, g*255, b*255, fps)
		elapsedFpsController = UPDATEPERIOD
	end
end)

-->shLatency OnUpdate script
local elapsedLatencyController = 0
flatency:SetScript("OnUpdate", function(self, t)
	elapsedLatencyController = elapsedLatencyController - t
	if elapsedLatencyController < 0 then
		if tipshownLatency then datalatency.OnEnter(tipshownLatency) end
		local latency = select(3,GetNetStats())
		local r, g, b = ColorGradient(latency/1000, 0,1,0, 1,1,0, 1,0,0)
		datalatency.text = format("|cff%02x%02x%02x%.0f|r |cffE8D200ms|r", r*255, g*255, b*255, latency)
		elapsedLatencyController = UPDATEPERIOD
	end
end)

----------------------
--> ONLEAVE FUNCTIONS
----------------------

function datafps.OnLeave()
	GameTooltip:SetClampedToScreen(true)
	GameTooltip:Hide()
	tipshownMem = nil
end

function datalatency.OnLeave() 
	GameTooltip:SetClampedToScreen(true)
	GameTooltip:Hide()
	tipshownLatency = nil
end

----------------------
--> ONENTER FUNCTIONS
----------------------

function datalatency.OnEnter(self)
	tipshownLatency = self
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint(GetTipAnchor(self))
	GameTooltip:ClearLines()
	
	GameTooltip:AddLine("|cff0062ffsh|r|cff0DEB11Latency|r")
	GameTooltip:AddLine(format("|cffc3771aDataBroker|r based addon to show your network latency (ms)\nupdated every |cff06DDFA%s second(s)|r!\n", UPDATEPERIOD))
	
	local binz, boutz, _ = GetNetStats()
	local rin, gin, bins = ColorGradient(binz/20, 0,1,0, 1,1,0, 1,0,0)
	local rout, gout, bout = ColorGradient(boutz/5, 0,1,0, 1,1,0, 1,0,0)
	
	GameTooltip:AddDoubleLine("|cff06ddfaIncoming bandwidth|r |cff0deb11(download)|r usage:", format("%.2f kb/sec", binz), nil, nil, nil, rin, gin, bins)
	GameTooltip:AddDoubleLine("|cff06ddfaOutgoing bandwidth|r |cff0deb11(upload)|r usage:", format("%.2f kb/sec", boutz), nil, nil, nil, rout, gout, bout)	
	GameTooltip:AddLine("\n|cffC3771ALatency|r |cff06ddfa(def)|r: Latency (or delay) is an expression of how long it\ntakes for a packet of data to get from one point to another")
	GameTooltip:Show()
end

function datafps.OnEnter(self)
	tipshownMem = self
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint(GetTipAnchor(self))
	GameTooltip:ClearLines()
	
	GameTooltip:AddLine("|cff0062ffsh|r|cff0DEB11Performance|r")
	
	GameTooltip:AddLine(format("|cffc3771aDataBroker|r based addon to show your |cff06ddfaaddon|r memory\nand |cff0deb11fps|r updated every |cff06DDFA%s second(s)|r!\n", UPDATEPERIOD))
	
	GameTooltip:AddDoubleLine("# | |cffC3771AAddon|r |cff06ddfaName|r", format("|cffC3771AMemory|r above (|cff06ddfa%s kb|r)", MEMTHRESH))
	GameTooltip:AddDoubleLine("|cffffffff------------|r", "|cffffffff------------|r")
	
	local counter = 0 -- for numbering (listing) and coloring
	local addonmem = 0
	local hidden, hiddenmem, shownmem = 0, 0, 0
	
	if wantAlphaSorting == false then
		sort(addons, usageSort) -->sort numerically by usage (descending) if desired
	end
	
	UpdateAddOnMemoryUsage()
	for i, v in ipairs(addons) do
		if IsAddOnLoaded(v) then
			local mem = GetAddOnMemoryUsage(v)
			local r, g, b = ColorGradient((mem - MEMTHRESH)/1024, 0,1,0, 1,1,0, 1,0,0)
			addonmem = addonmem + mem
			if mem > MEMTHRESH  and maxaddons > counter then
				counter = counter + 1
				hidden = #addons - counter
				shownmem = shownmem + mem
				newname = select(2,GetAddOnInfo(v))
				local memstr = formatMem(mem) 
				if wantColoring then
					if counter < 10 then GameTooltip:AddDoubleLine(format("  |cffDAB024%.0f)|r %s", counter, newname), memstr, r, g, b, r, g, b)  
					else GameTooltip:AddDoubleLine(format("|cffDAB024%.0f)|r %s", counter, newname), memstr, r, g, b, r, g, b) end
				else
					if counter < 10 then GameTooltip:AddDoubleLine(format("  |cffDAB024%.0f)|r %s", counter, newname), memstr, 1, 1, 1, r, g, b)  
					else GameTooltip:AddDoubleLine(format("|cffDAB024%.0f)|r %s", counter, newname), memstr, 1, 1, 1, r, g, b) end
				end 
			end
		end
	end
	
	GameTooltip:AddDoubleLine("|cffffffff------------|r", " ")
	
	hiddenmem = addonmem - shownmem
	local r, g, b = ColorGradient(addonmem/(colorgradient*1024), 0,1,0, 1,1,0, 1,0,0)
	GameTooltip:AddDoubleLine(format("|cff06DDFA[%d] hidden addons|r |cff0deb11(memory < %d kb)|r:", hidden, MEMTHRESH), formatMem(hiddenmem), nil, nil, nil, r, g, b)
	
	--> for development purposes only (to see my addon memory usage for testing)
	if dev then 
		local shmem = GetAddOnMemoryUsage("shPerformance")
		local r, g, b = ColorGradient((shmem - MEMTHRESH)/1024, 0,1,0, 1,1,0, 1,0,0)
		GameTooltip:AddDoubleLine("|cff0062ffsh|r|cff0DEB11Performance|r", format("%.1f kB", shmem), 1, 1, 1, r, g, b)
	end 
	--> end
	
	GameTooltip:AddDoubleLine(" ", "|cffffffff------------|r")
	
	local r, g, b = ColorGradient(addonmem/(colorgradient*1024), 0,1,0, 1,1,0, 1,0,0)
	local memstr = formatMem(addonmem) 
	GameTooltip:AddDoubleLine(" ", format("|cffC3771ATOTAL USER ADDON|r |cffffffffmemory usage:|r  %s", memstr), nil, nil, nil, r,g,b)
	GameTooltip:AddDoubleLine(" ", " ")		
		
	local mem = collectgarbage("count")
	local deltamem = mem - prevmem
	prevmem = mem
	local r, g, b = ColorGradient(mem/((colorgradient+20)*1024), 0,1,0, 1,1,0, 1,0,0)
	GameTooltip:AddDoubleLine("|cffC3771ADefault Blizzard UI|r memory usage:", format("%s", formatMem(mem-addonmem)), nil, nil, nil, r,g,b)
		
	local r, g, b = ColorGradient(mem/((colorgradient+40)*1024), 0,1,0, 1,1,0, 1,0,0)
	GameTooltip:AddDoubleLine("|cff06DDFATOTAL UI|r memory usage:", format("%s", formatMem(mem)), nil,nil,nil, r,g,b)
		
	GameTooltip:AddDoubleLine("|cffffffff------------|r", "|cffffffff------------|r")
	
	local r, g, b = ColorGradient(deltamem/15, 0,1,0, 1,1,0, 1,0,0)
	GameTooltip:AddDoubleLine("|cffc3771aGarbage|r |cff06ddfachurn:|r", format("%.2f kb/sec", deltamem), nil,nil,nil, r,g,b)
	
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("|cff0deb11Click|r to force |cffc3771agarbage collection|r and to |cff06ddfaupdate|r tooltip!")
	
	GameTooltip:Show()	
end

function datafps.OnClick(self)
	local collected, deltamem = 0, 0
	collected = collectgarbage('count')
	collectgarbage("collect")
	
	UpdateAddOnMemoryUsage()
	datafps.OnEnter(self)
	deltamem = collected - collectgarbage('count')
			
	print(format("|cff0DEB11shPerformance|r - |cffC3771AGarbage|r Collected: |cff06ddfa%s|r", formatMem(deltamem)))
end

print("|cff0062ffsh|r|cff0deb11Performance:|r Loaded! - (Please check out |cffc3771ashPerformance.lua|r for options and configuration)")