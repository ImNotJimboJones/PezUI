--[[
----- Constants and initial data
----- Other locals
----- Ace3 framework
----- Misc
----- Data bridges (to easymenu, to treegroup)
----- Script execution
----- Initial scripts
----- Added Lua routines
]]
local nametag, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(nametag)
local LDB = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LibStub("LibDBIcon-1.0", true)
local AceCD = LibStub("AceConfigDialog-3.0", true)
local flib = LibStub("LibFarmbuyer")


----- Constants and initial data
addon.defaults = {
	profile = {
		enable = true,
		minimap = {    -- LibDBIcon looks inside here for 'minimapPos' and 'hide'
			--minimapPos = 225,
			locked = false,
		},
		verbose = true,
		commands = {},
	}
}

addon.static_script_tree = {
	{
		value = 'intro',
		text = L["Instructions"],
		children = {
			{
				value = 'editor',
				text = L["Editing scripts"],
			},
			{
				value = 'slash',
				text = L["Macro Commands"],
			},
			{
				value = 'lua',
				text = "Lua",
			},
			{
				value = 'morefuncs',
				text = L["Added Lua functions"],
			},
			{
				value = 'registercomm',
				text = "From other addons",  -- XXX add localization once a better label is chosen
			},
		},
	},
	{
		value = 'userscripts',
		text = L["Player Scripts"],
	},
}
if flib.author_debug then
	_G.AC = addon
	addon.static_script_tree[3] = {
		value = 'reloadui',
		text = "ReloadUI",
	}
end

local ldbicon_do_minimap_lock   -- forward decl used in options table
addon.options = {
	name = "Arbitrary Commands",
	type = 'group',
	childGroups = 'tab',
	handler = addon,    -- functions listed as strings called as addon:func
	get = "GetOption",
	set = "SetOption",
	args = {
		options = {
			name = GENERAL,
			desc = L["General options"],
			type = 'group',
			order = 100,
			args = {
				version = {
					--name = filled in during OnInit
					type = 'description',
					fontSize = "large",
					image = "Interface\\MacroFrame\\MacroFrame-Icon",
					cmdHidden = true,
					order = 1,
				},
				header1 = {
					name = GENERAL,
					type = 'header',
					cmdHidden = true,
					order = 2,
				},
				enable = {
					name = ENABLE,
					desc = L["Use this addon"],
					type = 'toggle',
					arg  = "ToggleEnable",
					order = 5,
				},
				verbose = {
					name = L["Verbose execution"],
					desc = L["Print the name/description of an entry when running it."],
					type = 'toggle',
					order = 5,
				},
				refresh = {
					name = L["Rebuild Dropdowns"],
					desc = L["Rebuilds the dropdown menu from current config. Shouldn't be needed most of the time."],
					type = 'execute',
					func = "RefreshConfig",
					order = 10,
				},
				header2 = {
					name = L["Specialized"],
					type = 'header',
					cmdHidden = true,
					order = 50,
				},
				minimap = {
					name = L["Show minimap icon"],
					desc = L["Leave this ON unless you have another LDB display and know what you're doing."],
					type = 'toggle',
					order = 55,
					get = function() return not addon.db.profile.minimap.hide end,
					set = function(info,val)
					          addon.db.profile.minimap.hide = not val
					          LDBIcon[val and "Show" or "Hide"](LDBIcon,nametag)
					      end,
					disabled = function() return (not LDBIcon) or (not addon.db.profile.enable) end,
				},
				minimaplock = {
					name = L["Lock minimap icon"],
					desc = L["Click and drag icon into place, then toggle this option."],
					type = 'toggle',
					order = 56,
					get = function() return addon.db.profile.minimap.locked end,
					set = function(info,val)
					          addon.db.profile.minimap.locked = val
					          ldbicon_do_minimap_lock (val)
					      end,
					disabled = function()
					               return addon.options.args.options.args.minimap.disabled()
								          or addon.db.profile.minimap.hide
					           end,
				},
			},
		},
		--profiles =   filled in OnInit
		--scripts =   filled in editor.lua
	}
}


-----------------------------------------------------------------------------
----- Other locals
local is_slash
local added_menu_name_map = {}
local ldbicon_ondragstart
function ldbicon_do_minimap_lock (locked)
	-- LibDBIcon doesn't provide an API for retrieving the button it creates
	ldbicon_ondragstart = ldbicon_ondragstart or LDBIcon.objects[nametag]:GetScript("OnDragStart")
	if locked then
		LDBIcon.objects[nametag]:SetScript("OnDragStart", nil)
	else
		LDBIcon.objects[nametag]:SetScript("OnDragStart", ldbicon_ondragstart)
	end
end

-- Working around this bug:
-- http://forums.wowace.com/showpost.php?p=295202&postcount=31
do
	local function FixFrameLevel (level, ...)
		for i = 1, select("#", ...) do
			local button = select(i, ...)
			button:SetFrameLevel(level)
		end
	end

	local function FixMenuFrameLevels()
		local f = DropDownList1
		local i = 1
		while f do
			FixFrameLevel (f:GetFrameLevel() + 2, f:GetChildren())
			i = i + 1
			f = _G["DropDownList"..i]
		end
	end

	-- To fix Blizzard's bug caused by the new "self:SetFrameLevel(2);"
	hooksecurefunc("UIDropDownMenu_CreateFrames", FixMenuFrameLevels)
end


-----------------------------------------------------------------------------
----- Ace3 framework
addon = LibStub("AceAddon-3.0"):NewAddon(addon, nametag,
                "AceConsole-3.0")

function addon:SetOption (info, value)--, ...)
	local option = info[#info]
	self.db.profile[option] = value
	local arg = info.arg
	if arg then self[arg](self) end
	--if arg then self[arg](self,value,...) end
end

function addon:GetOption (info)
	local option = info[#info]
	return self.db.profile[option]
end

function addon:OnInitialize()
	local noob = _G.ArbitCommDB == nil
	self.db = LibStub("AceDB-3.0"):New("ArbitCommDB", self.defaults, --[[Default=]]true)

	local function refreshconfig_and_minimap()
		CloseDropDownMenus()
		table.wipe(added_menu_name_map)
		self:BackRegister (self.db.profile.commands)
		self:RefreshConfig()
		if LDBIcon and LDBIcon:IsRegistered(nametag) then
			LDBIcon:Refresh (nametag, self.db.profile.minimap)
		end
	end
	self.db.RegisterCallback (self, "OnProfileChanged", refreshconfig_and_minimap)   -- textbook configs here
	self.db.RegisterCallback (self, "OnProfileCopied", refreshconfig_and_minimap)
	self.db.RegisterCallback (self, "OnProfileReset", function()
		StaticPopup_Show("ARBITCOMM_RESET_ALL").data = self
	end)

	self.options.args.options.args.version.name =
		"|cff30adffVersion " .. (GetAddOnMetadata(nametag, "Version") or "?") .. "|r"
	local AceDBOptions = LibStub("AceDBOptions-3.0", true)
	if AceDBOptions then
		self.options.args.profiles = AceDBOptions:GetOptionsTable(self.db)
		self.options.args.profiles.order = 200
	end

	LibStub("AceConfig-3.0"):RegisterOptionsTable(nametag, self.options)
	AceCD:SetDefaultSize (nametag, --[[width=]]820, --[[height=]]535)
	self.blizOptionsFrame = AceCD:AddToBlizOptions(nametag, "Arbitrary Commands")
	self:RegisterChatCommand("arbit", "OnChatCommand")

	if noob then
		self:Printf(L["If this is your first time using the addon, you may find it helpful to enable the Blizzard %s option (%s -> %s tab -> %s) during setup."],
			"|cff30adff" .. SHOW_NEWBIE_TIPS_TEXT .. "|r",
			UIOPTIONS_MENU,  -- Interface
			GAME,            -- Game (tab)
			HELP_LABEL       -- Help
			)
	end
	self:SetEnabledState(self.db.profile.enable)
	self.OnInitialize = nil
end

function addon:OnEnable()
	if not self.db.profile.enable then
		return self:Disable()
	end

	self.dropdownframe = self.dropdownframe
		or CreateFrame("Frame", "ArbitCommDropDownMenu", nil, "UIDropDownMenuTemplate")

	if LDB then
		local launcher = LDB:GetDataObjectByName(nametag) or LDB:NewDataObject(nametag, {
			type = "launcher",
			label = "Arbitrary Commands",
			icon = self.options.args.options.args.version.image,
			--[=[
			OnTooltipShow = function (tooltip)
				if not tooltip or not tooltip.AddLine then return end
				tooltip:AddLine(.....)
			end, ]=]
			OnClick = function (frame, button)
				if button == "LeftButton" then
					--if InCombatLockdown() then return end
					local f,x,y = self:GetMenuLocations()
					EasyMenu (self.top_menu, self.dropdownframe, f, x, y, "MENU")
				else
					self:minimap_icon_right_click()
				end
			end,
		})
		if LDBIcon and not LDBIcon:IsRegistered(nametag) then
			LDBIcon:Register (nametag, launcher, self.db.profile.minimap)
			if not self.db.profile.minimap.hide then
				ldbicon_do_minimap_lock (self.db.profile.minimap.locked)
			end
		end
	end

	self.commands = self.db.profile.commands
	if #self.commands == 0 then
		self:register_default_commands()
	else
		self:BackRegister (self.commands)
	end
	self.register_default_commands = nil

	self:RefreshConfig()
end

-- Enabling does not change the minimap setting.  Disabling turns the minimap
-- icon off.  Changing the minimap icon does not change enabled state.  This
-- sounds fragile, but is precisely the behavior we want in the presence of
-- possible other LDB launchers.
function addon:OnDisable()
	self.options.args.options.args.minimap.set(nil,false)   -- permanently hides
	self.commands = nil
	self.top_menu = nil
end

function addon:ToggleEnable()
	if self.db.profile.enable then
		self:Enable()
	else
		self:Disable()
	end
end


-----------------------------------------------------------------------------
----- Misc
-- This can be made more "interesting" in future; for now just pop it up
-- near the mouse cursor.
function addon:GetMenuLocations()
	local x,y = GetCursorPosition()
	local scale = UIParent:GetEffectiveScale()
	x, y = x/scale, y/scale
	return UIParent, x+5, y-15
end

function addon:OnChatCommand (input)
	--if not input or input:trim() == "" then
		AceCD:Open (nametag, self:build_main_window())
	--else
	--	LibStub("AceConfigCmd-3.0").HandleCommand(self, "arbit", nametag, input)
	--end
end

function addon:getparent (p, func_name_for_errors)
	local name, found
	local t = self.commands
	for word,dot in p:gmatch('([^%.]+)(.?)') do
		if dot == '.' then       -- not last segment
			found = false
			-- nested loop, oh well, it's called rarely
			for i,c in ipairs(t) do
				if c.sub and c.menulabel == word then
					t = c.sub
					found = true
					break
				end
			end
			assert(found, "Argument to "..func_name_for_errors.." tries to index a menu that doesn't exist yet")
		else                     -- last segment
			name = word
		end
	end
	return name, t
end

StaticPopupDialogs["ARBITCOMM_RESET_ALL"] = flib.StaticPopup{
	text = L["Are you sure you want to delete ALL your scripts and revert to the examples?  This will force a UI reload and cannot be undone."],
	button1 = ACCEPT,
	button2 = CANCEL,
	showAlert = true,
	OnAccept = function (dialog, addon)
		table.wipe(addon.commands)
		addon.commands = nil
		ReloadUI()
	end,
}


-----------------------------------------------------------------------------
----- Data bridges (to easymenu, to treegroup)
local KEYSEP = flib.author_debug and '<SEP>' or '\009'
addon.KEYSEP = KEYSEP
addon.added_menu_name_map = added_menu_name_map

-- Returns the index number of KEY's entry inside KEY's group menu.  Ex:
-- foo.bar                    -> 0
-- foo.bar.barbaz<keysep>1    -> 1
-- foo.bar.barbaz<keysep>4    -> 4
-- barbaz<keysep>4            -> 4
function addon:get_menu_offset (key)
	local o = key:match(KEYSEP .. "(%d+)")
	return tonumber(o) or 0
end

-- Fetch a subset of the commands array, using a menu path.  If SUB_P is
-- true, descends into sub-table.  Returns the table and its parent in the
-- ".commands" tree.  XXX no, just the table for now, need the parent later.
function addon:get_submenu (path, sub_p)
	local m = self.commands
	if type(path) == "string" and path ~= "" then
		m = added_menu_name_map[path]
		assert(m, ":get_submenu given a submenu name (" .. path .. ") not previously registered")
		if sub_p then
			m = m.sub
		end
	end
	return m
end

-- Given tree path, retrieve the command entry.  Returns P,G,X where P is
-- the path table, suitable for reselecting the current position.  The rest:
-- G(group)  X
-- nil       string: treepath was not to a user script; string is first element of path
-- group     true:  treepath was to the topmost "Player Scripts" label
-- group     table:  treepath was to a submenu or script; table is the entry
-- If G is non-nil, it is the menu pathname for/from RegisterMenu/RegisterCommand.
-- (This may be an empty string!)
do
	local seppat = "([%w_ ]+)" .. KEYSEP .. "(%d+)"
	--local seppat = "([%w_]+)" .. KEYSEP .. "([%w_]+)"
	local cache = {}
	local unpack = _G.unpack
	function addon:find (key)
--flib.safeprint("FIND ON", key)
		if key == cache[1] then return unpack(cache,2) end

		local path
		if type(key) == "table" then
			path = key
		elseif type(key) == "string" then
			path = { ('\001'):split(key) }
		else error"wtf" end
		cache[1], cache[2] = key, path

		if path[1] ~= 'userscripts' then
			cache[3], cache[4] = nil, path[1]
			return unpack(cache,2)
		end
		local last = path[#path]
		if last == 'userscripts' then
			cache[3], cache[4] = "", true  -- special case
			return unpack(cache,2)
		end

		-- KEYSEP not present at all:
		-- 		clicking on menu or submenu label
		-- leading KEYSEP:
		-- 		top-level script
		-- two elements containing KEYSEP:
		-- 		nested script
		local ss,se = last:find(KEYSEP,--[[initial=]]1,--[[plain=]]true)
		local p
		if not ss then
			-- submenu
			p = table.concat(path,".",2)
			cache[3] = p
			p = assert(added_menu_name_map[p], "key lookup(1) on submenu that was never added: " .. (p or 'nil'))
		else
			local ele1, ele2
			if ss == 1 then
				-- top script
				cache[3] = ""
				ele1 = self.commands
			else
				-- nested script
				ele1 = last:sub(1,ss-1)
				p = table.concat(path,".",2,#path-1)
				cache[3] = p
				p = assert(added_menu_name_map[p], "key lookup(2) on submenu that was never added: " .. (p or 'nil'))
				ele1 = p.sub
			end
			ele2 = tonumber(last:sub(se+1))
			p = assert(ele1[ele2], "key lookup on nonexistant entry: " .. (ele2 or 'nil'))
		end
		cache[4] = p
		return unpack(cache,2)
	end
end


-- Recursively traverse COMMNADS to generate (1) easymenu entries into EMT,
-- and (2) treegroup entries into TGT.
--
-- SEP breaks up key elements in auxiliary tables.
function addon:populate_data_tables (prefix, EMT, TGT, commands)
	for i = 1, #commands do
		local cmd = commands[i]
		local EMn, TGn = #EMT + 1, #TGT + 1
		local key = prefix .. i
		if cmd.sub then
			local subEMT, subTGT = {}, {}
			self:populate_data_tables (cmd.menulabel .. KEYSEP, subEMT, subTGT, cmd.sub)
			EMT[EMn], TGT[TGn] = self:gen_submenu (cmd, subEMT, subTGT)
		else
			local s = cmd.script:sub(1,1)
			is_slash[key] = (s == '/' or s == '#') and true or nil
			--print(cmd.tooltip or cmd.menulabel, ":", s, ":", is_slash[key])
			if not cmd.no_show then
				EMT[EMn] = self:gen_menu_entry (key, EMn, cmd)
			end
			TGT[TGn] = self:gen_tree_entry (key, TGn, cmd)
		end
	end
end

do
	local function dropdown_handler (ddbutton, lookup_key, cmd)
		CloseDropDownMenus()
		addon:RunScript (lookup_key, cmd)
	end
	function addon:gen_menu_entry (lookup_key, menu_index, cmd)
		return {
			text = cmd.menulabel,
			func = dropdown_handler,
			--value = commands_index,   -- value of UIDROPDOWNMENU_MENU_VALUE when clicked
			arg1 = lookup_key,
			arg2 = cmd,
			notCheckable = true,
			tooltipTitle = cmd.tooltip and cmd.menulabel or nil,
			tooltipText = cmd.tooltip,
		}
	end
	function addon:gen_tree_entry (lookup_key, menu_index, cmd)
		return {
			value = lookup_key,
			text = cmd.menulabel,
		}
	end
	function addon:gen_submenu (menu, subeasymenu, subtreegroup)
		local easymenu = {
			text = menu.menulabel,
			hasArrow = true,
			menuList = subeasymenu,
			notCheckable = true,
		}
		local treegroup = {
			value = menu.menulabel,
			text = menu.menulabel,
			children = subtreegroup,
		}
		return easymenu, treegroup
	end
end


-- This can and will be called multiple times, so must be (effectively,
-- behaviorally) idempotent.  Still going to generate a crapton of garbage.
-- Maybe rewrite this part.
function addon:RefreshConfig()
	self.commands = self.db.profile.commands
	is_slash = {}
	self.is_slash = is_slash

	-- Set up the dropdown menu
	local top = {}

	-- Set up the treegroup structure for the scripting window
	local script = {}

	self:populate_data_tables (KEYSEP, top, script, self.commands)

	-- Finish the dropdown menu
	top[#top + 1] = {
		text = "|cff30adff"..L["Main Menu"].."|r",
		func = function() AceCD:Open (nametag, self:build_main_window()) end,
		--hasArrow = true,
		notCheckable = true,
		tooltipTitle = "|cff30adffArbitrary Commands|r",
		tooltipText = L["Click to open the config menu.  Right-click the minimap icon to open directly to the script editor."],
		--menuList = submenu,
	}
	self.top_menu = top

	-- Finish the scripting window
	self.script_tree = {}
	for i,v in ipairs(self.static_script_tree) do
		if v.value == 'userscripts' then v.children = script end
		table.insert (self.script_tree, v)
	end
end


----- Script execution
do
	-- Only need an internal frame name here to make ChatEdit_HandleChatType not
	-- spew nil errors.  But once set, we can clean up the global reference.
	-- (ChatEdit_HandleChatType/_UpdateHeader needs to be made more robust...)
	local editbox = CreateFrame("EditBox", "ArbitCommEditBox")
	_G.ArbitCommEditBox = nil
	editbox:SetAttribute("chatType", DEFAULT_CHAT_FRAME.editBox:GetAttribute("chatType"))
	editbox:SetAttribute("tellTarget", DEFAULT_CHAT_FRAME.editBox:GetAttribute("tellTarget"))
	editbox:SetAttribute("channelTarget", DEFAULT_CHAT_FRAME.editBox:GetAttribute("channelTarget"))
	editbox.language = DEFAULT_CHAT_FRAME.language
	editbox:Hide()
	addon.macro_editbox = editbox
	-- If the player is using IM-style chatframes, then ChatEdit_SendText will
	-- eventually try to :Show/:Hide these members.  Sink those calls into one frame.
	local p = CreateFrame("Frame")
	editbox.header = p
	editbox.focusLeft = p
	editbox.focusRight = p
	editbox.focusMid = p

	function addon:RunScript (lookup_key, entry)
		local cmd = entry

		local verb = cmd.verbose
		if verb == nil then verb = self.db.profile.verbose end
		if verb then
			self:Printf("%s <<%s>>", L["running"], cmd.tooltip or cmd.menulabel)
		end

		local ok, err, errtag
		if is_slash[lookup_key] then
			errtag = '/'
			-- can't use RunMacroText, as it's protected and secure code is a fucking nightmare
			for line in cmd.script:gmatch("[^\n]+") do while true do
				if not line:match("^/") then break end
				editbox:SetText(line)
				ok, err = flib.safecall (ChatEdit_SendText, editbox, --[[addHistory=]]nil)
				break
			end end
		else
			errtag = 'L'
			-- Raw Lua script.  We could use RunScript here, except that any typos or
			-- other errors on the player's part will (a) unconditionally trigger an
			-- error popup of some kind, even if RunScript is xpcall'd, and (b) that
			-- traceback will start in Blizzard code and then move through here, looking
			-- to the player as if it's a bug in AC.  We want to catch those mistakes
			-- ourselves instead.

			-- Syntax and semantic testing
			ok, err = loadstring (cmd.script)
			if ok then
				-- Now call it
				ok, err = flib.safecall (ok)
			end
		end
		if not ok then
			self:Printf ("(%s)%s  %s:  %s",
			             errtag, ERROR_CAPS, cmd.tooltip or cmd.menulabel, tostring(err))
		end
	end
end


----- Initial player scripts

-- For external callers.
function addon:ClearCommands()
	table.wipe(self.commands)
end

-- These functions are called during OnEnable.  Be careful!
function addon:RegisterMenu (pathname, offset)
	--flib.safeprint("RM path:", pathname, "offset", offset)
	assert(type(pathname)=="string", "Argument to :RegisterMenu must be a string")
	if not self:IsEnabled() then
		return  -- is this error()-worthy?
	end

	pathname = strtrim(pathname)
	local name, t = self:getparent (pathname, ":RegisterMenu")

	local m = {
		menulabel = name,
		sub = {},
	}
	added_menu_name_map[pathname] = m

	offset = offset or #t
	assert(type(offset)=="number","offset to :RegisterMenu was not a number!")
	table.insert (t, offset+1, m)
end

-- PATHNAME may be nil or the empty string to register at the top level.
function addon:RegisterCommand (pathname, a1, a2, offset)
	if not self:IsEnabled() then
		return  -- is this error()-worthy?
	end

	local cmd
	if type(a1) == "table" then
		if type(a2) ~= "nil" then
			error(L["No secondary argument may be passed to :RegisterCommand when using a command table."])
		end
		cmd = a1
		assert(type(cmd.menulabel)=="string", L["Command argument to :RegisterCommand missing 'menulabel' field"])
		assert(type(cmd.script)=="string", L["Command argument to :RegisterCommand missing 'script' field"])
	elseif type(a1) == "string" then
		if type(a2) ~= "string" then
			error(L["Secondary argument to :RegisterCommand must be a string."])
		end
		cmd = {
			menulabel = a1,
			script = a2,
		}
	else
		error(L["Primary argument to :RegisterCommand must be a string or a table."])
	end

	local m = self.commands
	if type(pathname) == "string" and pathname ~= "" then
		m = added_menu_name_map[pathname]
		assert(m, ":RegisterCommand given a submenu name (" .. pathname .. ") not previously registered")
		m = m.sub
	end

	offset = offset or #m
	assert(type(offset)=="number",L["offset to :RegisterCommand was not a number!"])

	cmd.menulabel = strtrim(cmd.menulabel)
	--cmd.script = strtrim(cmd.script)
	if cmd.tooltip ~= nil then
		assert(type(cmd.tooltip)=="string")
		cmd.tooltip = strtrim(cmd.tooltip)
	end

	table.insert (m, offset+1, cmd)
end

-- Given TREE from a SV, build the map table that would have been used to create it.
function addon:BackRegister (tree, path)
	for i,cmd in ipairs(tree) do
		if cmd.sub then
			local prefix = path and (path .. '.') or ''
			--print("backregistering", cmd.menulabel, "into", prefix..cmd.menulabel)
			added_menu_name_map[prefix .. cmd.menulabel] = cmd
			self:BackRegister (cmd.sub, cmd.menulabel)
		end
	end
end


----- Added Lua routines
do
	local chanmap = {
		["s"] = "SAY", ["say"] = "SAY",
		["y"] = "YELL", ["yell"] = "YELL",
		["p"] = "PARTY", ["party"] = "PARTY",
		["ra"] = "RAID", ["raid"] = "RAID",
		["g"] = "GUILD", ["o"] = "OFFICER",
		["rw"] = "RAID_WARNING",
		["bg"] = "BATTLEGROUND",
	}
	for _,v in ipairs{
		"SAY", "YELL", "PARTY", "RAID", "GUILD", "OFFICER", "RAID_WARNING", "BATTLEGROUND"
	} do
		local l = _G["SLASH_"..v.."1"]:sub(2)
		--print("mapping",l,"to",v)
		chanmap[l] = v
	end
	function _G.CHAT (slash, msg)
		local chantype, channel
		local c = chanmap[slash]
		if c then
			chantype, channel = c, nil
		elseif slash == "r" then
			c = ChatEdit_GetLastTellTarget(DEFAULT_CHAT_FRAME.editBox)
			if c and #c > 0 then
				chantype, channel = "WHISPER", c
			else c = nil end
		else
			c = tonumber(slash)
			if c then
				chantype, channel = "CHANNEL", c
			end
		end
		if c then
			SendChatMessage (msg, chantype, nil, channel)
		else
			addon:Printf("%s  %s:  %s", ERROR_CAPS, CHAT_INVALID_NAME_NOTICE, slash)
		end
	end
	function _G.SLASH (text)
		--addon.macro_editbox:SetText(text)
		DEFAULT_CHAT_FRAME.editBox:SetText(text)
		ChatEdit_SendText (DEFAULT_CHAT_FRAME.editBox, --[[addHistory=]]nil)
	end
end

-- vim:noet
