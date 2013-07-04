-- Updated WarmUp by Cybeloras of Mal'Ganis. Uses debugprofile start/stop instead of GetTime because it seems that GetTime() is not updated during loading screens anymore.
-- Updated WarmUp again by Kuipo of Hyjal. Updated to work with WoW v5.0.5

collectgarbage("stop")
collectgarbage("collect")
local initmem = collectgarbage("count")
local longesttime, biggestmem, totalmem, totalgarbage, mostgarbage, gctime = 0, 0, 0, 0, 0, 0
local totaltime = 0
local eventcounts, combatframe = {}, ChatFrame2
local eventargs = {}
local threshtimes, threshmems = {1.0, 0.5, 0.1}, {1000, 500, 100}
local threshcolors = {"|cffff0000", "|cffff8000", "|cffffff80", "|cff80ff80"}
local outframe, sv, intransit, reloading, longestaddon, biggestaddon, varsloadtime, logging, mostgarbageaddon, leftworld
local memstack = {initmem}

local usecombatframe = false

local timerIsLocked
local function start()
	if timerIsLocked then
	--	outframe:AddMessage("ATTEMPTED TO START TIMER WHILE LOCKED")
	--	outframe:AddMessage(debugstack())
	end
	
	timerIsLocked = true
	debugprofilestart()
end

local function stop()
	if not timerIsLocked then
	--	outframe:AddMessage("ATTEMPTED TO STOP TIMER WHILE UNLOCKED")
	--	outframe:AddMessage(debugstack())
	end
	
	timerIsLocked = false
	return debugprofilestop()
end

start()

	--[[ (insert a space between the dashes and brackets)
	LoadAddOn("Blizzard_DebugTools")
	EventTraceFrame_HandleSlashCmd ("")
	EVENT_TRACE_MAX_ENTRIES = 10000
	--]]

local frame = CreateFrame("Frame", "WarmupFrame", UIParent)
Warmup = {}

frame:SetScript("OnEvent", function(self, event, ...)
	if eventcounts then
		eventcounts[event] = (eventcounts[event] or 0) + 1
		eventargs[event] = max(select("#", ...), eventargs[event] or 0)
	end
	if Warmup[event] then Warmup[event](Warmup, ...) end
end)


local function GetThreshColor(set, value)
	local t = set == "mem" and threshmems or threshtimes
	for i,v in pairs(t) do
		if value >= v then return threshcolors[i] end
	end
	return threshcolors[4]
end


local function PutOut(txt, color, time, mem, gc)
	local outstr = (time and string.format("%.3f sec | ", time) or "")..
		color.. txt.. (mem and string.format(" (%d KiB", mem) or "")..
		(gc and string.format(" - %d KiB)", gc) or mem and ")" or "")

	if usecombatframe then combatframe:AddMessage(outstr) end
	outframe:AddMessage(outstr)
end


local function PutOutAO(name, time, mem, garbage)
	outframe:AddMessage(string.format("%s%.3f sec|r | %s (%s%d KiB|r - %s%d KiB|r)", GetThreshColor("time", time), time,
		name, GetThreshColor("mem", mem), mem, GetThreshColor("mem", garbage), garbage))
	return string.format("%.3f sec | %s (%d KiB - %d KiB)", time, name, mem, garbage)
end



do
	local loadandpop = function(...)
		local newm, newt = table.remove(memstack)
		local oldm, oldt = table.remove(memstack)
		local origm, origt = table.remove(memstack)
		table.insert(memstack, origm + newm - oldm)
		return ...
	end
	local lao = LoadAddOn
	LoadAddOn = function (...)
		if timerIsLocked then
			stop() -- stop any runaway timers
		end
		
		start()
		collectgarbage("collect")
		gctime = gctime + stop()/1000
		
		local newmem = collectgarbage("count")
		table.insert(memstack, newmem)
		table.insert(memstack, newmem)
		start() -- start the timer for ADDON_LOADED to finish
		return loadandpop(lao(...))
	end
end


function Warmup:OnLoad()
	table.insert(UISpecialFrames, "WarmupOutputFrame")
	frame:RegisterAllEvents()
end

function Warmup:Init()
	if not WarmupSV then WarmupSV = {} end
	sv = WarmupSV
	sv.addoninfo = {}

	outframe = WarmupChatFrame

	do
		for i=1,GetNumAddOns() do
			if IsAddOnLoaded(i) then
				if GetAddOnInfo(i) ~= "!!Warmup" then
					if usecombatframe then combatframe:AddMessage("Addon loaded before Warmup: ".. GetAddOnInfo(i)) end
					outframe:AddMessage("Addon loaded before Warmup: ".. GetAddOnInfo(i))
				end
			end
		end
	end
end


function Warmup:DumpEvents()
	local sortt = {}
	for ev,val in pairs(eventcounts) do table.insert(sortt, ev) end

	table.sort(sortt)

	for i,ev in pairs(sortt) do
		outframe:AddMessage(string.format(threshcolors[1].."%d|r (%d) | %s%s|r", eventcounts[ev], eventargs[ev], threshcolors[4], ev))
	end
	outframe:AddMessage("------------")
end


function Warmup:ADDON_LOADED(addon)
	local addonmem = collectgarbage("count")
	local lastmem = table.remove(memstack)
	local lasttime = stop()/1000
	local diff = addonmem - lastmem
	
	totaltime = totaltime + lasttime
	
	start()
	collectgarbage("collect")
	gctime = gctime + stop()/1000
	
	local gcmem = collectgarbage("count")
	local garbage = addonmem - gcmem

	if not outframe or not sv then self:Init() end

	table.insert(sv.addoninfo, PutOutAO(addon, lasttime, diff - garbage, garbage))

	if lasttime > longesttime then
		longesttime = lasttime
		longestaddon = addon
	end
	if (diff - garbage) > biggestmem then
		biggestmem = diff - garbage
		biggestaddon = addon
	end
	if garbage > mostgarbage then
		mostgarbage = garbage
		mostgarbageaddon = addon
	end
	totalgarbage = totalgarbage + garbage
	totalmem = totalmem + diff
	table.insert(memstack, gcmem)
	start()
end


function Warmup:VARIABLES_LOADED()
	if varsloadtime then return end
	stop() -- stop the timer (it is still running from the last addon loaded
	
	start()
	collectgarbage("collect")
	gctime = gctime + stop()/1000

	local lastmem = collectgarbage("count")

	varsloadtime = GetTime()
	PutOut("Addon Loadup", threshcolors[4], totaltime, lastmem - initmem, totalgarbage)
	PutOut("Warmup's Garbage Collection", threshcolors[4], gctime)
	PutOut("Longest addon: ".. longestaddon, threshcolors[2], longesttime)
	PutOut("Biggest addon: ".. biggestaddon, threshcolors[2], nil, biggestmem)
	PutOut("Most Garbage: "..mostgarbageaddon, threshcolors[2], nil, mostgarbage)

	frame:RegisterEvent("PLAYER_LOGIN")

	SlashCmdList["RELOAD"] = ReloadUI
	SLASH_RELOAD1 = "/rl"

	SlashCmdList["RELOADNODISABLE"] = function()
		sv.time = GetTime()
		reloading = true
		EnableAddOn("!!Warmup")
		ReloadUI()
	end
	SLASH_RELOADNODISABLE1 = "/rlnd"

	SlashCmdList["WARMUP"] = function()
		if WarmupOutputFrame:IsVisible() then WarmupOutputFrame:Hide()
		else WarmupOutputFrame:Show() end
	end

	SLASH_WARMUP1 = "/wu"
	SLASH_WARMUP2 = "/warmup"

	collectgarbage("restart")
	-- DisableAddOn("!!Warmup")
	start()
end


function Warmup:PLAYER_LOGIN()
	logging = true
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
end


function Warmup:PLAYER_ENTERING_WORLD()
	if logging then
		local entrytime = stop()/1000

		PutOut("World entry", threshcolors[4], entrytime)

		PutOut("Total time", threshcolors[4], entrytime + totaltime + gctime)

		sv.time = nil
		varsloadtime = nil
	elseif leftworld then
		PutOut("Zoning", threshcolors[4], stop()/1000)
		leftworld = nil
	end
	
	logging = nil
	frame:RegisterAllEvents()
	frame:UnregisterEvent("PLAYER_LOGIN")
	frame:UnregisterEvent("PLAYER_LOGOUT")
	frame:UnregisterEvent("PLAYER_ENTERING_WORLD")

	self:DumpEvents()
	eventcounts = nil
end


function Warmup:PLAYER_LEAVING_WORLD()
	--sv.time = GetTime()
	frame:RegisterAllEvents()
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("PLAYER_LOGOUT")

	eventcounts = {}
	if timerIsLocked then
		stop() -- stop any runaway timers
	end
	start()
	leftworld = true
end


function Warmup:PLAYER_LOGOUT()
	if not reloading then sv.time = nil end
end


Warmup:OnLoad()