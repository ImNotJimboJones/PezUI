--[[
Name: LibDebugLog-1.0
Revision: $Rev: 1 $
Author(s): sinus (sinus@sinpi.net)
Description: A library providing easy and informative debug logging.
Dependencies: None
License: MIT
]]

-- #AUTODOC_NAMESPACE prototype

do
	local MAJOR_VERSION = "LibDebugLog-1.0"
	local MINOR_VERSION = tonumber(("$Revision: 1 $"):match("%d+"))

	local LibDebugLog = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
	if LibDebugLog then

		local addon_dummy = {}

		local date,tinsert,tremove=date,tinsert,tremove

		function LibDebugLog:RegisterAddon(addon,configtable,color)
			for key,var in pairs(addon_dummy) do addon[key]=var end

			addon._DebugStack = 0
			addon._DebugLog = { entries={}, size=100, loud=false }  --loudness done another way, directly through _Debug
			addon._DebugConfigTable = configtable
			--addon._DebugColor = color or ""
		end


		local function _Debug(self,msg,stackop,stackoverhead)
			msg=msg or ""

			local deb=debugstack(2+(stackoverhead or 0),1,0)
			local file,line,fun = deb:match("([^\\]+):(%d+):.*`(.+)'")
			if not file then
				file,line,fun = deb:match("([^\\]+):(%d+):.*:(%d+)>")
				if file then
					fun = ("(local:%s)"):format(fun)
				end
			end

			if file then
				file = ("|cff55ff00%s|cffaaaaaa (%s:%s): |cffff88dd"):format(fun,file,line)
			else
				file = ("|cff55ff00%s: |cffff88dd"):format(deb)
			end

			local prefix
			if stackop==1 then
				prefix = strrep(" | ",self._DebugStack) .. "> "
				self._DebugStack = self._DebugStack + 1
			elseif stackop==-1 then
				self._DebugStack = self._DebugStack - 1
				prefix = strrep(" | ",self._DebugStack) .. "< "
			else
				prefix = strrep(" | ",self._DebugStack)
			end
			msg = prefix .. file .. msg .. "|r"
	
			self:DebugLogAdd(msg)

			if self._DebugConfigTable.debug then
				self._DebugCount = (self._DebugCount or 0) + 1
				self:Print('|cffff0088[|cffff00ee' .. self._DebugCount .. '|cffff0088]|cffaaaaaa ' .. msg)
			end
		end

		-- @param msg Message to put into the debug log.
		-- @param stackop (internally used by DebugPush and DebugPop) 1 to increase stack position, -1 to decrease
		-- @param stackoverhead (internally used by DebugPush and DebugPop) shifts the function stack, to properly skip other bug-handling routines on the stack
		function addon_dummy:Debug (msg)
			_Debug(self,msg,0,1)
		end

		function addon_dummy:DebugPush (msg)
			_Debug(self,msg,1,1)
		end

		function addon_dummy:DebugPop (msg)
			_Debug(self,msg,-1,1)
		end

		function addon_dummy:DebugSetLogSize(size)
			local log=self._DebugLog
			log.size = size
			self:DebugLogTrim()
		end

		function addon_dummy:DebugLogTrim()
			local log=self._DebugLog
			while #log.entries>log.size do tremove(log.entries,1) end
		end

		function addon_dummy:DebugLogAdd(msg)
			local log=self._DebugLog
			--msg = msg:gsub("|c[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]",""):gsub("|r","")
			tinsert(log.entries,date("%H:%M:%S").."> ".. msg )
			self:DebugLogTrim()
			if log.loud then
				ChatFrame1:AddMessage("|cff8888ff".. date("%H:%M:%S")..">|r |cffccccff".. msg .."|r")
			end
		end

		function addon_dummy:DebugLogPrint(n)
			local log=self._DebugLog
			local len = #log.entries
			if not n or n>len then n=len end
			for i=len-n+1,len,1 do
				ChatFrame1:AddMessage(log.entries[i])
			end
		end

		function addon_dummy:DebugLogDump(n)
			local log=self._DebugLog
			local s = ""
			local len = #log.entries
			if not n or n>len then n=len end
			for i=len-n+1,len,1 do
				s = s .. log.entries[i] .. "\n"
			end
			return s
		end

		
		
		
		
		
		
		
		local function warn(message)
			local _, ret = pcall(error, message, 3)
			geterrorhandler()(ret)
		end

	end
end
