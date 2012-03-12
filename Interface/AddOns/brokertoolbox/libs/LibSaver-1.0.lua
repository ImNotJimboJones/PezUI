--[[
Name: LibSaver-1.0
License: LGPL v2.1 (this file only)
Description: A library, witch provides a simple save table creation
Author: Sanori/Pathur @ EU Anetheron
Usage: call
		local mysave=LibStub("LibSaver-1.0"):NewSave("DATABASENAME", defaultstable)
		in PLAYER_LOGIN Event
Database will be save automatically on PLAYER_LOGOUT Event, so pls do no changes on database in this event
]]

assert(LibStub, "LibSaver-1.0 requires LibStub")

local LibSaver = LibStub:NewLibrary("LibSaver-1.0",1)

if not LibSaver then return end

if not LibSaver.frame then
	LibSaver.frame=CreateFrame("Frame")
end

local db = {}
local defaultdb = {}

LibSaver.frame:RegisterEvent("PLAYER_LOGOUT")

local function newsave(tbl, default)
	if (tbl==nil) then return default end		--if tbl is empty, then return default table/value
	if (next(default)==nil) then return tbl end	--if default is empty, then return tbl
	local result = {}
	for k,v in pairs(default) do
		if (tbl[k]==nil or type(v)=='table') then
			result[k] = newsave(tbl[k], v)	--recursive
		else
			result[k] = tbl[k]
		end
	end
	return result
end
local function comparesave(tbl, default)	--only save differences
	if (next(default)==nil and next(tbl)~=nil) then return tbl end	--if default is empty, then return tbl
	local result = {}
	for k,v in pairs(tbl) do
		if (v and type(v)=='table') then
			result[k] = comparesave(v, default[k])	--recursive
		elseif v~=default[k] then
			result[k] = v
		end
	end
	if (next(result)) then
		return result
	else
		return
	end
end

LibSaver.frame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGOUT" then
		for addondb,data in pairs(db) do
			_G[addondb][GetCVar("realmName")][UnitName("player")] = comparesave(data, defaultdb[addondb])
		end
	end
end)

function LibSaver:NewSave(addondb, defaults)
	local function tblcopy(tbl)	--creates a real copy
		local result={}
		for k,v in pairs(tbl) do
			if (v and type(v)=='table') then
				result[k] = tblcopy(v)
			else
				result[k] = v
			end
		end
		return result
	end
	_G[addondb] = _G[addondb] or {}
	_G[addondb][GetCVar("realmName")] = _G[addondb][GetCVar("realmName")] or {}
	db[addondb] = newsave(_G[addondb][GetCVar("realmName")][UnitName("player")] or {}, tblcopy(defaults))
	defaultdb[addondb] = defaults
	return db[addondb]
end