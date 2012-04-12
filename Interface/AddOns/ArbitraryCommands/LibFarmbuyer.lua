--[[
Not really meant for public use.  Stuff that I keep using everywhere and
got tired of reimplementing, or even copy-and-pasting.  The notes here are
reminders to myself.

Library contents:
- author_debug
  Evaluates to true if I'm hacking on something.

- tableprint(t)
  A single print() call to the contents of T, including nils; strings are
  cleaned up with respect to embedded '|'/control chars.  If there is a
  global LIBFARMPRINT function, it is called with the cleaned-up T instead
  of directly calling print.

- safeprint(...)
  Same as tableprint() on the argument list.

- safeiprint(...)
  Same as safeprint() but with index numbers inserted.  Ex:
  safeiprint(a,b,c)  -->  <1>,a,<2>,b,<3>,c

- CHAT(n)
  Returns a function suitable for assigning to LIBFARMPRINT, directing all
  output to builtin chat frame N.

- t = StaticPopup(t)
  Fills out "typical" settings inside T, especially if T contains any kind
  of editbox:
   + cannot accept an empty editbox
   + pressing Enter runs OnAccept
   + editbox grabs keyboard focus
   + OnAccept runs with editbox's text in dialog.usertext
  Returns T.

- nullfunc()
  Empty placeholder function.  Will be less useful if WoW ever moves to Lua 5.2.
  This is a fascinating and educational place to insert print calls...

- tabledump(t)/dumptable(t)
  If author_debug, this runs the builtin /dump command on T.  Otherwise nothing.

- DoOnceNextUpdate(f)
  Runs F on the next frame refresh cycle.  Multiple calls in one cycle will
  stack LIFO.  Calls *while* processing the stack are safe, and will be stacked
  up for the next cycle.

- safecall (func, ...)
  A modified copy of the xpcall wrapper duplicated in every Ace3 file in the
  whole damn library.

- new(...), del(t), copy(t), clear()
  Ditto for table recycling.
]]

local MAJOR, MINOR = "LibFarmbuyer", 9
assert(LibStub,MAJOR.." requires LibStub")
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

_G[MAJOR] = lib

----------------------------------------------------------------------
--[[
	Recycling functions yoinked from AceConfigDialog and tweaked
]]
local new, del, copy, clear
do
	local pool = setmetatable({},{__mode="k"})
	function clear()
		wipe(pool)
	end
	function new(...)  -- slightly modified variant, takes optional initializers
		local t = next(pool)
		if t then
			pool[t] = nil
			for i = 1, select('#',...) do
				t[i] = select(i,...)
			end
			return t
		else
			return {...}
		end
	end
	function copy(t)
		local c = new()
		for k, v in pairs(t) do
			c[k] = v
		end
		return c
	end
	function del(t)
		wipe(t)
		pool[t] = true
	end
end
lib.new, lib.del, lib.copy, lib.clear = new, del, copy, clear


----------------------------------------------------------------------
--[[
	safeprint
]]
local function undocontrol(c)
	return ("\\%.3d"):format(c:byte())
end
function lib.CHAT(n)
	local cf = _G["ChatFrame"..n]
	return function(t)
		local msg = table.concat(t,' ', i, tonumber(t.n) or #t)
		cf:AddMessage(msg)
	end
end
function lib.safeprint(...)
	local args = { n=select('#',...), ... }
	lib.tableprint(args)
end
function lib.safeiprint(...)
	local args = { n=select('#',...), ... }
	local last = args.n
	while last > 0 do
		table.insert (args, last, "<"..last..">")
		last = last - 1
	end
	args.n = 2 * args.n
	lib.tableprint(args)
end
function lib.tableprint(t)
	for i = 1, (tonumber(t.n) or #t) do
		t[i] = tostring(t[i]):gsub('\124','\124\124')
		                     :gsub('(%c)', undocontrol)
	end
	if type(_G.LIBFARMPRINT) == 'function' then
		return _G.LIBFARMPRINT(t)
	else
		return print(unpack(t))
	end
end

-- See below for global versions.


----------------------------------------------------------------------
local StaticPopupDialogs = _G.StaticPopupDialogs

local function EditBoxOnTextChanged_notempty (editbox) -- this is also called when first shown
	if editbox:GetText() ~= "" then
		editbox:GetParent().button1:Enable()
	else
		editbox:GetParent().button1:Disable()
	end
end
local function EditBoxOnEnterPressed_accept (editbox)
    local dialog = editbox:GetParent()
    StaticPopupDialogs[dialog.which].OnAccept (dialog, dialog.data, dialog.data2)
    dialog:Hide()
end
local function OnShow_witheditbox (dialog, data)
	local info = StaticPopupDialogs[dialog.which]
	dialog[info.hasWideEditBox and "wideEditBox" or "editBox"]:SetFocus()
    if info.farm_OnShow then
        return info.farm_OnShow (dialog, data)
    end
end
local function OnAccept_witheditbox (dialog, data, data2)
	local info = StaticPopupDialogs[dialog.which]
	dialog.usertext = dialog[info.hasWideEditBox and "wideEditBox" or "editBox"]:GetText():trim()
    if info.farm_OnAccept then
        return info.farm_OnAccept (dialog, data, data2)
    end
end

--[[
	StaticPopup
]]
function lib.StaticPopup (t)
    if t.hasEditBox then
        t.EditBoxOnTextChanged = EditBoxOnTextChanged_notempty
        t.EditBoxOnEnterPressed = EditBoxOnEnterPressed_accept
		if t.OnShow then
			t.farm_OnShow = t.OnShow
		end
        t.OnShow = OnShow_witheditbox
		if t.OnAccept then
			t.farm_OnAccept = t.OnAccept
		end
        t.OnAccept = OnAccept_witheditbox
		-- this calls OnCancel with "clicked", unless noCancelOnEscape is set
        t.EditBoxOnEscapePressed = StaticPopup_EscapePressed
    end

    t.timeout = 0
    t.whileDead = true
    t.hideOnEscape = true
	t.enterClicksFirstButton = true

    return t
end


----------------------------------------------------------------------
--[[
This is ugly, but at least it all gets GC'd almost immediately.
]]
function lib.nullfunc() end

if ({
	["Bandwagon"] = true, ["Kilvin"] = true, ["Waterfaucet"] = true,
	["Farmbuyer"] = true, ["Oxdeadbeef"] = true, ["Pointystick"] = true,
	["Angryhobbit"] = true, ["Malrubius"] = true, ["Hemogoblin"] = true,
})[UnitName("player")] then
	lib.author_debug = true
	_G.safeprint = lib.safeprint
	_G.safeiprint = lib.safeiprint
	function lib.tabledump(t)
		_G.UIParentLoadAddOn("Blizzard_DebugTools")
		_G.LibF_DEBUG = t
		_G.SlashCmdList.DUMP("LibF_DEBUG")
	end
else
	lib.tabledump = lib.nullfunc
end
lib.dumptable = lib.tabledump


----------------------------------------------------------------------
--[[
	DoOnceNextUpdate
]]
do
	local frame = CreateFrame("Frame", "LibFarmbuyerDONUFrame")
	frame:Hide()
	frame:SetScript("OnUpdate", function()
		frame:Hide()
		local q = frame.nexttime
		local tmp
		frame.nexttime = nil
		while q do
			tmp = q
			q.f(frame)
			q = q.n
			del(tmp)
		end
	end)

	function lib.DoOnceNextUpdate (func)
		local nextt = new()
		nextt.f = func
		nextt.n = frame.nexttime
		frame.nexttime = nextt
		frame:Show()
	end
end


----------------------------------------------------------------------
--[[
	safecall
]]
do
	local xpcall = xpcall

	local function errorhandler(err)
		--return geterrorhandler()(err)
		--print("in error handler", err)
		return err
	end

	local template = ([[
		local xpcall, eh = ...
		local method, ARGS
		local function call() return method(ARGS) end

		local function dispatch (func, ...)
			 method = func
			 if not method then return end
			 ARGS = ...
			 return xpcall (call, eh)
		end

		return dispatch
	]]):gsub('\t','  ')

	local function CreateDispatcher(argCount)
		local ARGS = {}
		for i = 1, argCount do ARGS[i] = "arg"..i end
		local code = template:gsub("ARGS", table.concat(ARGS, ", "))
		return assert(loadstring(code, "LibF/safecall Dispatcher["..argCount.."]"))(xpcall, errorhandler)
	end

	local Dispatchers = setmetatable({
		[0] = function(func)
			return xpcall (func, errorhandler)
		end
	}, {
		__index = function (Ds, argCount)
			local dispatcher = CreateDispatcher(argCount)
			Ds[argCount] = dispatcher
			return dispatcher
		end
	})

	function lib.safecall (func, ...)
		if type(func) == 'function' then
			return Dispatchers[select('#', ...)](func, ...)
		end
	end
end


----------------------------------------------------------------------

-- vim: noet
