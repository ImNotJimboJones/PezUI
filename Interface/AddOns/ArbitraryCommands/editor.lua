local nametag, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(nametag)
local GUI = LibStub("AceGUI-3.0")
local flib = LibStub("LibFarmbuyer")
local DoOnceNextUpdate = flib.DoOnceNextUpdate
local IndentationLib = IndentationLib

-- "Print the name [...] it.  Overrides global 'Verbose execution' setting."
local L_verbose = addon.options.args.options.args.verbose.desc .. "  " ..
	L["Overrides global '%s' setting."]:format(L["Verbose execution"])


-- Setting them to nil is obviously useless, but reminds me of their spelling.
local state = {
	lua_editor_widget       = nil,
	lua_editor_enabled      = true,
	editbox_widget          = nil,
	last_selected_menu      = nil,   -- only useable when can_create_p
	last_selected_tree      = { 'userscripts' },
	last_selected_is_script = nil,
}
local function pathprint(p)
	-- use debug tags for this
	--flib.safeprint("PATH:",table.concat(p,'.'))
end

local function SetStatusText (w)
	addon.mainframe:SetStatusText(w.arbitcomm_statustext)
end
local function ClearStatusText()
	addon.mainframe:SetStatusText("")
end

local function Create (wtype, text)
	local widget = GUI:Create(wtype)
	widget:SetFullWidth(true)
	widget:SetCallback("OnEnter", SetStatusText)
	widget:SetCallback("OnLeave", ClearStatusText)
	widget.arbitcomm_statustext = text
	return widget
end

do
	-- Giving a custom container to :Open prohibits :SelectGroup, :Close,
	-- and some other utility routines from working.  ><  We kludge around
	-- this by doing the exact same thing AceCD does and storing a frame
	-- pointer in its OpenFrames list.  (This gets a little tricky in places
	-- because normally the presence of an OpenFrames entry means that no
	-- custom containers were used.)
	--
	-- Side effect:  SelectGroup -> NotifyChange -> ConfigTableChange causes
	-- one RefreshOnUpdate to run.  That in turn causes the OnClose event
	-- to be overwritten with the shared FrameOnClose wrapper.  So instead
	-- of using an OnClose callback, we have to do cleanup elsehow.
	--
	-- FrameOnClose releases the widget, but the OnRelease callback gets
	-- overwritten (possibly multiple times) by InjectInfo.  The only option
	-- remaining is the OnRelease widget method.  This must be carefully
	-- hooked and unhooked on a per-framewidget basis.
	--
	-- If the player doesn't open via right-click, however, SelectGroup is
	-- never called and the above doesn't happen.  Ha!  So we leave an
	-- OnClose in place for that possibility too.
	--
	-- Is all this worth it?  The only other way is to generate all the
	-- UI elements on the fly using AceConfig "option" entries, similar to
	-- how sUF does its config window.
	--   Pro:  everything done by AceCD, no custom fiddling needed (in theory)
	--   Con:  no AceGUI control at any point, no custom fiddling permitted
	-- Not for now, but it will remain an option in future.
	local AceCD = LibStub("AceConfigDialog-3.0")
	local closing
	local function cleanup (framewidget)
		addon.mainframe = nil
		AceCD.OpenFrames[nametag] = nil
		if not closing then
			GUI:Release(framewidget)  -- force editor widget to be released (and editbox changes saved!)
		end
		addon:RefreshConfig()
	end
	local function hooked_OnRel (widget)
		closing = true
		cleanup(widget)

		widget.OnRelease = widget:GetUserData('AC hooked OnRelease')
		if widget.OnRelease then   -- always true for Frame, but be robust and all that
			return widget:OnRelease()
		end
	end

	function addon:build_main_window()
		closing = nil
		if self.mainframe then
			-- already open, don't rebuild the world
			self.mainframe:SetCallback("OnClose", cleanup)
			return self.mainframe
		end

		local f = GUI:Create("Frame")
		f:SetUserData('AC hooked OnRelease',f.OnRelease)
		f.OnRelease = hooked_OnRel
		f:SetCallback("OnClose", cleanup)
		AceCD.OpenFrames[nametag] = f
		self.mainframe = f
		return f
	end
	function addon:minimap_icon_right_click()
		if self.mainframe then
			PlaySound("gsTitleOptionExit")
			self.mainframe:Hide()
		else
			AceCD:Open (nametag, addon:build_main_window())
			AceCD:SelectGroup (nametag, "scripts")
		end
	end
end

-- Sadly, there's no sane way to tell the treegroup to refresh its display
-- without jumping through idiotic hoops.  This turns out to be most robust.
-- Rare enough that it's not worth premaking the small callback.
local function CloseAndReopen()
	addon.mainframe:Hide()
	DoOnceNextUpdate(function() addon:minimap_icon_right_click() end)
end


local function NewScript_OnAccept (dialog)
	local label = dialog.usertext
	local last = state.last_selected_tree[#state.last_selected_tree]
	local offset = addon:get_menu_offset(last)

	addon:RegisterCommand (state.last_selected_menu, label, "", offset)
	addon:RefreshConfig()

	--[[
	if offset > 0 then
		-- The 'or' branch here takes care of insertion at the top level
		print("removed:",table.remove(state.last_selected_tree))
		last = last:match("([%w_]+)" .. addon.KEYSEP) or ''
	end
	table.insert(state.last_selected_tree, last .. addon.KEYSEP .. offset+1)
	]]

	addon:minimap_icon_right_click()
end

local function NewMenu_OnAccept (dialog)
	local label = dialog.usertext
	local last = state.last_selected_tree[#state.last_selected_tree]
	local offset = addon:get_menu_offset(last)

	local menu = state.last_selected_menu
	if menu and menu ~= "" then
		menu = menu .. '.' .. label
	else
		menu = label
	end
	addon:RegisterMenu (menu, offset)
	addon:RefreshConfig()

	--[[
	if offset > 0 then
		print("removed:",table.remove(state.last_selected_tree))
		last = last:match("([%w_]+)" .. addon.KEYSEP) or ''
	end
	table.insert(state.last_selected_tree, last .. addon.KEYSEP .. offset+1)
	]]

	addon:minimap_icon_right_click()
end

local function RemoveCurrentSelection()
	local last = state.last_selected_tree[#state.last_selected_tree]
	local offset = addon:get_menu_offset(last)

	--[[
	flib.safeprint(":calling remove on", offset, "inside", state.last_selected_menu)
	nonzero inside ''                --> script at top level
	0       inside name              --> empty menu at top level (no .) or submenu (name has .)
	nonzero inside name              --> script inside submenu
	]]

	local t = addon:get_submenu(state.last_selected_menu, offset>0)
	if offset > 0 then
		table.remove(t,offset)
	else
		addon.added_menu_name_map[state.last_selected_menu] = nil
		local last2, parent = addon:getparent (state.last_selected_menu, "Remove")
		assert(last==last2,"Remove badly messed up: "..(last or 'nil').."!="..(last2 or 'nil'))
		for i,v in ipairs(parent) do
			if v.menulabel == last2 then
				table.remove(parent,i)
				break
			end
		end
	end
	addon:RefreshConfig()

	CloseAndReopen()
end

local function MoveCurrentDown()
	local last = state.last_selected_tree[#state.last_selected_tree]
	local offset = addon:get_menu_offset(last)





	CloseAndReopen()
end

local function SaveCurrent (cmd)
	cmd.script = state.editbox_widget:GetText():trim()
	local s = cmd.script:sub(1,1)
	--print("saving script", cmd.script, "with is_slash", (s == '/' or s == '#') and true or nil)
	addon.is_slash[state.last_selected_tree[#state.last_selected_tree]] =
		(s == '/' or s == '#') and true or nil
end


-- Builds the control panel at the top of the right-hand side.
local function BuildCP (can_create_p, can_delete_p, script_p, cmd)
	can_delete_p = can_create_p and can_delete_p

	local relw_buttons, relw_globalopts, relw_cmdopts = 0.32, 0.32, 0.32
	local ret = {}
	local group, w

	group = GUI:Create("SimpleGroup"); table.insert(ret,group)
	group:SetLayout("Flow")
	group:SetRelativeWidth(relw_buttons)

	w = Create("Button",
		L["Creates a new command script, inserted after the current selection in the menu list."])
	w:SetText(L["New Script"])
	w:SetDisabled(not can_create_p)
	w:SetCallback("OnClick", function(_w)
		StaticPopup_Show("ARBITCOMM_NEW_SCRIPT")
		addon.mainframe:Hide()
	end)
	group:AddChild(w)

	w = Create("Button",
		L["Creates a new nested menu, inserted after the current selection in the menu list."])
	w:SetText(L["New Menu"])
	w:SetDisabled(not can_create_p)
	w:SetCallback("OnClick", function(_w)
		StaticPopup_Show("ARBITCOMM_NEW_MENU")
		addon.mainframe:Hide()
	end)
	group:AddChild(w)

	w = Create("Button",
		L["Deletes current script or (empty) menu."])
	w:SetText(REMOVE)
	w:SetDisabled(not can_delete_p)
	--w:SetCallback("OnClick", function(_w)
	--	RemoveCurrentSelection()
	--end)
	w:SetCallback("OnClick", RemoveCurrentSelection)
	group:AddChild(w)

	--[[
	w = Create("Button",
		L["Moves current selection up one position."])
	w:SetText(L["Up"])
	w:SetRelativeWidth(0.49)
	w:SetDisabled(not can_delete_p)
	w:SetCallback("OnClick", )
	group:AddChild(w)

	w = Create("Button",
		L["Moves current selection down one position."])
	w:SetText(L["Down"])
	w:SetRelativeWidth(0.49)
	w:SetDisabled(not can_delete_p)
	w:SetCallback("OnClick", MoveCurrentDown)
	group:AddChild(w)
	]]

	group = GUI:Create("InlineGroup"); table.insert(ret,group)
	group:SetLayout("List")
	group:SetTitle(L["Editor Options"])
	group:SetRelativeWidth(relw_globalopts)

	w = Create("CheckBox",
		L["Assumes text is Lua rather than slash commands, for indenting and coloring."])
	w:SetLabel(L["Use Lua editor"])
	w:SetValue(state.lua_editor_enabled)
	w:SetDisabled(not script_p)
	state.lua_editor_widget = w
	w:SetCallback("OnValueChanged", function(_w,_,value)
		if not state.editbox_widget then return end  -- still building
		state.lua_editor_enabled = value
		if value then
			IndentationLib.enable (state.editbox_widget.editBox, --[[color=]]nil, --[[tabwidth=]]4)
		else
			IndentationLib.disable (state.editbox_widget.editBox)
		end
	end)
	group:AddChild(w)

	group = GUI:Create("InlineGroup"); table.insert(ret,group)
	group:SetLayout("List")
	group:SetTitle(L["Selected Script Options"])
	group:SetRelativeWidth(relw_cmdopts)

	w = Create("CheckBox", L_verbose)
	w:SetType("radio")
	w:SetTriState(true)
	w:SetLabel(addon.options.args.options.args.verbose.name)
	if script_p then
		w:SetValue(cmd.verbose)
	else
		w:SetValue(nil)
	end
	w:SetDisabled(not (script_p and can_delete_p))
	w:SetCallback("OnValueChanged", function(_w,_,value)
		if value == nil then
			_w:SetDescription(("|cff9d9d9d%s: %s|r"):format(L["Global option"],
				addon.db.profile.verbose and L["On"] or L["Off"]))
		elseif value == false then
			_w:SetDescription(("|cffff0505%s: %s|r"):format(L["Override option"], L["Off"]))
		elseif value == true then
			_w:SetDescription(("|cff00ff00%s: %s|r"):format(L["Override option"], L["On"]))
		else error "how the hell did you manage that?" end
		if script_p then cmd.verbose = value end
	end)
	w:Fire("OnValueChanged", w:GetValue())
	group:AddChild(w)

	w = Create("CheckBox",
		L["If checked, do not show this script in the dropdown menu (think of it as cold storage)."])
	w:SetLabel(L["No Show"])
	if script_p then
		w:SetValue(cmd.no_show)
	else
		w:SetValue(nil)
	end
	w:SetDisabled(not (script_p and can_delete_p))
	w:SetCallback("OnValueChanged", function(_w,_,value)
		if not state.editbox_widget then return end  -- still building
		if script_p then cmd.no_show = value and true or nil end
	end)
	group:AddChild(w)

	w = Create("Button",
		L["Runs this script right now, as if you had clicked on it in the menu."])
	w:SetText(L["Run Now"])
	--if state.editbox_widget then
		w:SetDisabled(not (script_p and can_delete_p))
		--w:SetDisabled(not state.editbox_widget.editBox:IsMouseEnabled())
	--else
		--w:SetDisabled(true)
	--end
	w:SetCallback("OnClick", function(_w)
		if script_p then
			SaveCurrent(cmd)
		end
		addon:RunScript (state.last_selected_tree[#state.last_selected_tree], cmd)
	end)
	group:AddChild(w)

	return unpack(ret)
end

local function BuildIntro (subkey)
	local txt = GUI:Create("Label")
	txt:SetFullWidth(true)
	txt:SetFontObject(GameFontNormal)
	txt:SetText(addon.helptext[subkey or ""] or "?")

	return txt
end


-- Everything is assembled now, and we can take advantage of AceGUI parent
-- relationships.  The widget pedigree looks like this:
-- Frame -> TabGroup -> ScrollFrame -> TGFI
local function tree_value_selected (treegroup,_,treelabel)
	if addon.blizOptionsFrame:IsVisible() then
		local x = GUI:Create("InteractiveLabel")
		x:SetFullWidth(true)
		x:SetImage([[Interface\DialogFrame\DialogAlertIcon]])
		x:SetImageSize(50,50)
		x:SetText(L["Blizzard's Interface Options panel is way too tiny to do anything with the editor.  Click this warning label to reopen the scripts editor as if you had clicked the minimap icon."])
		x:SetCallback("OnClick", function (_x)
			InterfaceOptionsFrameCancel:Click()
			HideUIPanel(GameMenuFrame)
			addon:minimap_icon_right_click()
		end)
		treegroup:AddChild(x)
		return
	end

	--flib.safeprint("treelabel is:",treelabel)
	local treepath,menupath,result = addon:find(treelabel)
	local resulttype = type(result)   -- clumsy
	local is_script = resulttype == "table" and result.script ~= nil   -- force to boolean
	state.last_selected_is_script = is_script
	if resulttype ~= "string" then
		pathprint(treepath)
	end

	treegroup:ReleaseChildren()
	treegroup:SetLayout("List")
	treegroup:SetFullHeight(true)  -- still not enough

	local top_panel = GUI:Create("SimpleGroup")
	top_panel:SetLayout("Flow")
	top_panel:SetFullWidth(true)
	--top_panel:SetCallback("OnRelease", function() end)  -- potential place for cleanup code
	top_panel:AddChildren(BuildCP (
		--[[can_create_p=]] resulttype~="string",
		--[[also can_delete_p=]] resulttype=="table" and (result.sub == nil or #result.sub == 0),
		is_script, result))
	treegroup:AddChild(top_panel)

	if result == "intro" then
		treegroup:AddChildren(BuildIntro(treepath[2]) or "")
		return
	end

	if result == "reloadui" then ReloadUI() end

	-- Only update these if displaying a userscript, else we stumble over acegui
	-- silliness.  (Displaying helptext, then clicking another tab, then clicking
	-- back here means that the left-hand tree display is only as high as the
	-- displayed helptext label.)  This means that clicking the userscripts tab
	-- will always initially display one of the user scripts, which lets us make
	-- some safer assumptions.
	state.last_selected_menu = menupath
	state.last_selected_tree = treepath

	local bottom_editbox = GUI:Create("MultiLineEditBox"); local b = bottom_editbox
	state.editbox_widget = bottom_editbox
	-- Fake a click on that checkbox, but without actually changing state.
	state.lua_editor_widget:Fire("OnValueChanged", state.lua_editor_enabled)
	b:SetFullWidth(true)
	b:SetNumLines(17)  -- hack, see BuildEditorPanel FIXME
	b:SetLabel(L["Pressing the Escape key while typing will return keystroke control to the usual chat window."])
	b:DisableButton(true)
	b:SetDisabled(resulttype~="table" or result.sub)
	if is_script then
		b:SetText(result.script)
	else
		b:SetText((resulttype=="boolean" and result) and
		          L["For new users, click the word 'Instructions' at the top left side."] or "")
	end
	--b.editBox:SetScript("OnShow", b.editBox.SetFocus)   -- no, don't grab focus without some kind of save/undo
	b:SetCallback("OnRelease", function(_b)
		_b.editBox:ClearFocus()
		-- Very carefully using state-at-time-of-building, not "current" state.
		if is_script then
			SaveCurrent(result)
		end
		state.editbox_widget = nil
	end)
	treegroup:AddChild(bottom_editbox)
end


do
	-- At the time this is called, the TGFI widget has not yet been added to
	-- any container.  We do not actually receive the tab group's "selected tab"
	-- container event at any time.
	local tgfi_status
	local function BuildEditorPanel (tgfi)

		tgfi:SetStatusTable(tgfi_status or {
			groups = { intro=true, userscripts=true },   -- expand that topic by default
			--treewidth = 145,
		})
		tgfi_status = tgfi.status  -- really want to delay this somehow

		-- This is not enough to make the treegroup height expand if the main
		-- frame is vertically expanded.  FIXME
		tgfi:SetFullWidth(true)
		tgfi:SetFullHeight(true)
		tgfi:EnableButtonTooltips(false)

		tgfi:SetTree(addon.script_tree)
		-- OnRelease is overwritten by AceConfigDialog, can't use it.
		tgfi:SetCallback("OnGroupSelected", tree_value_selected)
		tgfi:SelectByPath(unpack(state.last_selected_tree))
	end

	addon.options.args.scripts = {
		name = L["Player Scripts"],
		desc = L["Manage menu entries"],
		type = 'group',
		order = 300,
		args = {
			tg = {
				type = 'input',
				dialogControl = "TreeGroupFakeInput",
				-- This gets called early, before the TGFI is created, so it must
				-- be safe.  Returns a function F eventually called as F(tgfi).
				name = function() return BuildEditorPanel end,
				get = false,
				set = false,
				cmdHidden = true,
			},
		},
	}
end


do
	local function EditBoxOnTextChanged_sane (editbox) -- this is also called when first shown
		local sanity = editbox:GetText()
		if sanity ~= "" and not sanity:find("[^%w_]") then
			editbox:GetParent().button1:Enable()
		else
			editbox:GetParent().button1:Disable()
		end
	end

	StaticPopupDialogs["ARBITCOMM_NEW_SCRIPT"] = flib.StaticPopup{
		text = L["Enter the menu label for the new script:"],
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = true,
		maxLetters = 50,
		OnAccept = NewScript_OnAccept,
		EditBoxOnTextChanged = EditBoxOnTextChanged_sane,
	}

	StaticPopupDialogs["ARBITCOMM_NEW_MENU"] = flib.StaticPopup{
		text = L["Enter the menu label for the new nested menu:"],
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = true,
		maxLetters = 50,
		OnAccept = NewMenu_OnAccept,
		EditBoxOnTextChanged = EditBoxOnTextChanged_sane,
	}
end

-- vim:noet
