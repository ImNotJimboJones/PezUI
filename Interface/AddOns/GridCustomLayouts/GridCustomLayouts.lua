local L = setmetatable({}, {__index = function(t, k) t[k] = k return k end})
if GetLocale()=="zhCN" then
	L["Custom Layouts"] = "自定义布局"
	L["Add customed layouts using a simple grammer."] = "使用简写的格式增加自定义布局, 详见插件说明."
	L["Layout text format error, see above information."] = "布局字符串格式错误, 请看以上信息."
	L["Layout name is already used."] = "创建失败, 布局已经存在."
end
if GetLocale()=="zhTW" then
	L["Custom Layouts"] = "自定義佈局"
	L["Add customed layouts using a simple grammer."] = "使用簡寫的格式增加自定義佈局, 詳見插件說明."
	L["Layout text format error, see above information."] = "佈局字串格式錯誤, 請看以上資訊."
	L["Layout name is already used."] = "創建失敗, 布局已經存在."
end

--[[
List of the various configuration attributes
======================================================
showRaid = [BOOLEAN] -- true if the header should be shown while in a raid
showParty = [BOOLEAN] -- true if the header should be shown while in a party and not in a raid
showPlayer = [BOOLEAN] -- true if the header should show the player when not in a raid
showSolo = [BOOLEAN] -- true if the header should be shown while not in a group (implies showPlayer)
nameList = [STRING] -- a comma separated list of player names (not used if 'groupFilter' is set)
groupFilter = [1-8, STRING] -- a comma seperated list of raid group numbers and/or uppercase class names and/or uppercase roles
strictFiltering = [BOOLEAN] - if true, then characters must match both a group and a class from the groupFilter list
sortMethod = ["INDEX", "NAME"] -- defines how the group is sorted (Default: "INDEX")
sortDir = ["ASC", "DESC"] -- defines the sort order (Default: "ASC")
groupBy = [nil, "GROUP", "CLASS", "ROLE"] - specifies a "grouping" type to apply before regular sorting (Default: nil)
groupingOrder = [STRING] - specifies the order of the groupings (ie. "1,2,3,4,5,6,7,8")
maxColumns = [NUMBER] - maximum number of columns the header will create (Default: 1)
unitsPerColumn = [NUMBER or nil] - maximum units that will be displayed in a singe column, nil is infinate (Default: nil)
--]]


--local BC = LibStub:GetLibrary("LibBabble-Class-3.0"):GetLookupTable()
local BC = {}
FillLocalizedClassList(BC, false) for key, value in pairs(BC) do BC[key:upper()] = value end

local GridRoster = Grid:GetModule("GridRoster")
local GridLayout = Grid:GetModule("GridLayout")
local GridCustomLayouts = Grid:NewModule("GridCustomLayouts")
local lastLayout = nil; --for NO REPEAT parse;

GridCustomLayouts.defaultDB = {
	layouts = {
		["EXAMPLE1"] = "WARR,DK,PAL,HUN;CLASS\n\n;1,2,3,4,5;8/3;NR\n\nOneplayer",
		["EXAMPLE2"] = "WAR,DEATH,PAL;groupBy=CLASS;order=WAR,DEATH,PAL;NAME;DESC;showSolo=false;5/2;strictFiltering=false\n1",
	}
}

GridCustomLayouts.options = {
	type = "execute",
	name = L["Custom Layouts"],
	desc = L["Add customed layouts using a simple grammer."],
	order = 10,
	func = function()
		--GridLayout:SaveLayout("aa", { {groupFilter = "PALADIN",},{groupFilter = "SHAMAN",},{groupFilter = "MAGE",} });
		GridCustomLayoutsFrame:Show()
		local layoutName
		if GridLayout.db.profile.layouts.force and GridLayout.db.profile.layouts.force~= Grid.L["None"] then
			layoutName = GridLayout.db.profile.layouts.force
		else
			local party_type = GridRoster:GetPartyState()
			layoutName = GridLayout.db.profile.layouts[party_type]
		end

		if ( GridCustomLayouts.db.profile.layouts and GridCustomLayouts.db.profile.layouts[layoutName] ) then
			GridCustomLayouts_SelectLayout(layoutName)
		else
			GridCustomLayouts_SelectFirstLayout()
		end
		LibStub("AceConfigDialog-3.0"):Close("Grid");
		GridCustomLayouts_UpdateFrame()
		GameTooltip:Hide()
	end
}

function GridLayout:SaveLayout(layoutName, layout)
	if(self.layoutSettings[layoutName]) then
		self.layoutSettings[layoutName] = layout
	else
		self:AddLayout(layoutName, layout)
	end

	if self.db.profile.layouts.force then
		self.db.profile.layouts.force = layoutName
		DEFAULT_CHAT_FRAME:AddMessage("GridCustomLayouts: FORCE LAYOUT set and loaded.", 1, 1, 0);
		self:ReloadLayout()
	else
		local party_type = GridRoster:GetPartyState()
		self.db.profile.layouts[party_type] = layoutName
		DEFAULT_CHAT_FRAME:AddMessage("GridCustomLayouts: Layout "..party_type.." set and loaded.", 1, 1, 0);
		self:ReloadLayout()
	end
end

function GridLayout:RemoveLayoutValidate(party_type, layoutName)
	local options = self.options.args[party_type .. "layout"]
	if options then
		self.options.args[party_type .. "layout"].values[layoutName]=nil
	end
end

function GridLayout:DeleteLayout(layoutName)
	self.layoutSettings[layoutName] = false
	local party_states = {}

	for _, party_type in ipairs(GridRoster.party_states) do
		self:RemoveLayoutValidate(party_type, layoutName)
	end

	self:RemoveLayoutValidate("force", layoutName)

	if self.db.profile.layouts.force and self.db.profile.layouts.force==layoutName  then
		self.db.profile.layouts.force = Grid.L["None"]
	else
		local party_type = GridRoster:GetPartyState()
		if self.db.profile.layouts[party_type] == layoutName then
			self.db.profile.layouts[party_type] = Grid.L["None"]
		end
	end

	self:ReloadLayout();
end

--Hook
GridLayout.OnEnableOrigin = GridLayout.OnEnable
function GridLayout:OnEnable()
	if GridCustomLayouts and GridCustomLayouts.db then
		for k, v in pairs( GridCustomLayouts.db.profile.layouts ) do
			local layout = GridCustomLayouts_ConvertLayout(v)
			GridLayout:AddLayout(k, layout)
		end
	end
	GridLayout:OnEnableOrigin()
	GridLayout:UnregisterEvent("Grid_RosterUpdated")
	GridLayout:RegisterEvent("Grid_RosterUpdated", "LayoutUpdateWhenRosterUpdated")
	GridLayout:RegisterEvent("PLAYER_ROLES_ASSIGNED", "LayoutUpdateWhenRosterUpdated")
end

--HOOK the GridLayout:LoadLayout
GridLayout.LoadLayoutOrigin = GridLayout.LoadLayout
function GridLayout:LoadLayout(layoutName)
	lastLayout = nil;
	local oldLayout = GridLayout.layoutSettings[layoutName]
	if type(oldLayout) ~= "table" or not next(oldLayout) then
		GridLayout:LoadLayoutOrigin(layoutName)
	else
		GridLayout.layoutSettings[layoutName] = GridCustomLayouts_ParseNoRepeatLayout(oldLayout)
		lastLayout = GridLayout.layoutSettings[layoutName];
		--DEFAULT_CHAT_FRAME:AddMessage("loaded size="..#lastLayout)
		GridLayout:LoadLayoutOrigin(layoutName)
		GridLayout.layoutSettings[layoutName] = oldLayout
	end
end

--Hook, Grid_RosterUpdated,  check if need parse NO REPEAT;
function GridLayout:LayoutUpdateWhenRosterUpdated()
	local layoutName
	if self.db.profile.layouts.force and self.db.profile.layouts.force~= Grid.L["None"] then
		layoutName = self.db.profile.layouts.force
	else
		local party_type = GridRoster:GetPartyState()
		layoutName = self.db.profile.layouts[party_type]
	end
	

	local layout = layoutName and GridLayout.layoutSettings[layoutName]
	if(layout and lastLayout) then
		--check lastLayout, which was set on last LoadLayout. 
		--RosterUpdated event dosen't load new layout, so the layout must be the same as last one.
		local idx, header;
		local needParse = false;
		for _, header in pairs(layout) do
			if header.noRepeat then needParse = true; end
		end
		if(needParse) then
			--DEFAULT_CHAT_FRAME:AddMessage("parsing layout...");
			local parsedLayout = GridCustomLayouts_ParseNoRepeatLayout(layout);
			local needUpdate = false;
			if(#lastLayout~=#parsedLayout) then
				--DEFAULT_CHAT_FRAME:AddMessage("cols not match, ");
				needUpdate = true;
			else
				for idx, header in pairs(parsedLayout) do
					if(parsedLayout[idx].nameList ~= lastLayout[idx].nameList) then
						needUpdate = true;
						break;
					end
				end
			end

			if( needUpdate ) then
				--DEFAULT_CHAT_FRAME:AddMessage("layout need update...");
				GridLayout:PartyTypeChanged()
				return
			end
		end
	end

	GridLayout:PartyMembersChanged()
end

local GROUP_FILTER_ABBR = {
	[BC.WARRIOR] = "WARRIOR",["WARRIOR"] = "WARRIOR",["ZS"] = "WARRIOR",
	[BC.PRIEST] = "PRIEST",["PRIEST"] = "PRIEST",["MS"] = "PRIEST",
	[BC.DRUID] = "DRUID",["DRUID"] = "DRUID",["DD"] = "DRUID",["XD"] = "DRUID",
	[BC.PALADIN] = "PALADIN",["PALADIN"] = "PALADIN",["QS"] = "PALADIN",["SQ"] = "PALADIN",
	[BC.SHAMAN] = "SHAMAN",["SHAMAN"] = "SHAMAN",["SM"] = "SHAMAN",
	[BC.MAGE] = "MAGE",["MAGE"] = "MAGE",["FS"] = "MAGE",
	[BC.WARLOCK] = "WARLOCK",["WARLOCK"] = "WARLOCK",["WL"] = "WARLOCK",["WARLOCK"] = "WARLOCK",["SS"] = "WARLOCK",
	[BC.HUNTER] = "HUNTER",	["HUNTER"] = "HUNTER",["LR"] = "HUNTER",
	[BC.ROGUE] = "ROGUE",["ROGUE"] = "ROGUE",["DZ"] = "ROGUE",
	[BC.DEATHKNIGHT] = "DEATHKNIGHT",["DEATHKNIGHT"] = "DEATHKNIGHT",["DK"] = "DEATHKNIGHT",
	["MAINTANK"] = "MAINTANK",["MT"] = "MAINTANK",
	["MAINASSIST"] = "MAINASSIST",["MA"] = "MAINASSIST",
	["1"] = "1",["2"] = "2",["3"] = "3",["4"] = "4",["5"] = "5",["6"] = "6",["7"] = "7",["8"] = "8",
}

function GridCustomLayouts_ConvertOneHeader(line)
	local header = {
		["showPlayer"] = true,
		["showSolo"] = true,
		["showParty"] = true,
		["showRaid"] = true,
	}
	local attrs = {strsplit(";", line)}
	local haveGroupFilter = false
	for i=1, #attrs do
		local attr = strtrim(attrs[i])
		if(attr=="") then
			--do nothing
		elseif(string.find(attr, "=")) then --attribute=value;
			local t = {strsplit("=", attr)}
			if(#t~=2) then 
				DEFAULT_CHAT_FRAME:AddMessage("Illegal Element: "..attr, 1, 0, 0)
				return nil
			end
			t[1]=strtrim(t[1])
			t[2]=string.gsub(strtrim(t[2]), "\"", "")
			if(strlower(t[1])=="order" or t[1]=="groupingOrder") then
				local t = {strsplit(",", t[2])}
				local j, abbr, av
				for j = 1, #t do
					local v = strtrim(t[j])
					for abbr, av in pairs(GROUP_FILTER_ABBR) do
						if strsub(abbr, 1, #v)==v then --strsub("德鲁伊", 1, #"德")=="德" 
							t[j] = av
							break
						end
					end
				end
				header.groupingOrder = strjoin(",", unpack(t))
			elseif t[1]=="showParty" or t[1]=="showRaid" or t[1]=="showSolo" or t[1]=="showPlayer" or t[1]=="strictFiltering" then
				header[t[1]]= (strlower(t[2]) == "true")  and true or false
			else
				header[t[1]] = t[2]
			end
		elseif(string.find(attr,"/")) then --unitsPerColumn/maxColumns;
			local t = {strsplit("/", attr)}
			if(#t~=2) then 
				DEFAULT_CHAT_FRAME:AddMessage("Illegal Element: "..attr, 1, 0, 0)
				return nil
			end
			header.unitsPerColumn = tonumber(strtrim(t[1]))
			header.maxColumns = tonumber(strtrim(t[2]))
		elseif(attr=="PET") then
			header.isPetGroup = true
		elseif(attr=="INDEX" or attr=="NAME") then
			header.sortMethod = attr
		elseif(attr=="ASC" or attr=="DESC") then
			header.sortDir = attr
		elseif(attr=="STRICT") then
			header.strictFiltering = true
		elseif(attr=="GROUP" or attr=="CLASS" or attr=="ROLE") then
			header.groupBy = attr
		elseif(attr=="NOREPEAT" or attr=="NOREP" or attr=="NOR" or attr=="NR") then
			header.noRepeat = true
		else
			--groupFilter or nameList
			if haveGroupFilter then 
				DEFAULT_CHAT_FRAME:AddMessage("Illegal Element(more than one filter): "..attr, 1,0,0)
				return nil 
			end
			haveGroupFilter = true;
			local t = {strsplit(",", attr)}
			local i, abbr, av, isGroup
			for i = 1, #t do
				local v = strtrim(t[i])
				local thisIsGroup = false
				for abbr, av in pairs(GROUP_FILTER_ABBR) do
					if strsub(abbr, 1, #v)==v then --strsub("德鲁伊", 1, #"德")=="德" 
						thisIsGroup = true
						t[i] = av
						break
					end
				end
				if i==1 then
					isGroup = thisIsGroup
				end

				if isGroup and not thisIsGroup then
					DEFAULT_CHAT_FRAME:AddMessage("Illegal Element(group and name in same filter): "..attr, 1, 0, 0)
					return nil
				end
			end

			if isGroup then
				header.groupFilter = strjoin(",", unpack(t))
				header.groupingOrder = strjoin(",", unpack(t))
			else
				header.nameList = strjoin(",", unpack(t))
			end
		end
	end

	return header
end

--将缩写的格式字符串转换为GridLayoutLayouts的格式
function GridCustomLayouts_ConvertLayout(text)
	text = string.gsub(text,"，", ",")
	text = string.gsub(text,"；", ";")
	text = string.gsub(text,"＝", "=")
	local lines = {strsplit("\n", strtrim(text))}
	local layout = {}
	local count = 1
	for i=1, #lines do
		lines[i] = strtrim(lines[i])
		if strsub(lines[i],1,2)~="--" then
			if(lines[i]=="") then
				if(i>1 and i<#lines and lines[i-1]~="" and lines[i+1]=="") then
					layout[count] = { groupFilter="", } --a double empty line stands for a spacer
					count = count + 1
				end
			else
				layout[count] = GridCustomLayouts_ConvertOneHeader(lines[i])
				if layout[count] == nil then return nil end
				count = count + 1
			end
		end
	end

	return layout
end

function GridCustomLayouts_ParseNoRepeatLayout(layout) --处理标记为NOREPEAT的layout, PetGroup can't use NO REPEAT
	local header, newLayout, usedName, needParse = nil, {}, {}, false;

	for _, header in pairs(layout) do
		if header.noRepeat then needParse = true break end
	end
	if not needParse then --no headers are defined as noRepeat
		return layout
	end

	--Get non-NOREPEAT headers nameList.
	for _, header in pairs(layout) do
		if not header.isPetGroup and not header.noRepeat then
			if not header.GetAttribute then
				header.GetAttribute = function(self, attr) return self[attr] end
			end

			local sortingTable = SecureGroupHeader_UpdateCopy(header)
			--[[ [1]="raid1", [2]="raid2", "raid1"="name1", "raid2"="name2" ]]

			for i=1,#sortingTable do
				usedName[sortingTable[sortingTable[i]]] = true
			end
		end
	end

	for _, header in pairs(layout) do
		if header.isPetGroup then 
			table.insert(newLayout, header)
		else
			if not header.GetAttribute then
				header.GetAttribute = function(self, attr) return self[attr] end
			end

			if not header.noRepeat then
				table.insert(newLayout, header)
			else
				local nameList = {}
				local sortingTable = SecureGroupHeader_UpdateCopy(header)
				for i=1, #sortingTable do
					if not usedName[sortingTable[sortingTable[i]]] then 
						table.insert(nameList, sortingTable[sortingTable[i]])
						usedName[sortingTable[sortingTable[i]]] = true
					end
				end
				if #nameList > 0 then
					local newHeader = {}
					for k, v in pairs(header) do
						newHeader[k] = v
					end
					newHeader.nameList = table.concat(nameList, ",")
					newHeader.groupFilter = nil
					newHeader.groupingOrder = nil
					table.insert(newLayout, newHeader)
				end
			end
		end
	end
	
	--DevTools_Dump(newLayout)
	return newLayout
end

function GridCustomLayouts_NewLayout(name)
	if(GridCustomLayouts.db.profile.layouts[name]) then
		DEFAULT_CHAT_FRAME:AddMessage(L["Layout name is already used."], 1, 1, 0)
	else
		GridCustomLayouts.db.profile.layouts[name] = ""
		UIDropDownMenu_Initialize(GridCustomLayoutsFrameDropDown, GridCustomLayouts_DropDown_Initialize)
		GridCustomLayouts_SelectLayout(name)
	end
end

function GridCustomLayouts_SelectLayout(name)
	UIDropDownMenu_Initialize(GridCustomLayoutsFrameDropDown, GridCustomLayouts_DropDown_Initialize)
	UIDropDownMenu_SetSelectedValue(GridCustomLayoutsFrameDropDown, name);
	GridCustomLayoutsFrameArg:SetText(GridCustomLayouts.db.profile.layouts[name] or "")
	GridCustomLayouts_UpdateFrame()
end

function GridCustomLayouts_SelectFirstLayout()
	local name = next(GridCustomLayouts.db.profile.layouts)
	if name then 
		GridCustomLayouts_SelectLayout(name)
	else
		UIDropDownMenu_SetSelectedValue(GridCustomLayoutsFrameDropDown, nil);
	end
	GridCustomLayouts_UpdateFrame()
end
	

function GridCustomLayouts_DeleteLayout()
	local name = UIDropDownMenu_GetSelectedValue(GridCustomLayoutsFrameDropDown)
	if(name) then
		GridCustomLayouts.db.profile.layouts[name] = nil;
		GridLayout:DeleteLayout(name);
		GridCustomLayouts_SelectFirstLayout()
	end
end
		

--=========================================================================
-- FRAME CODE
--=========================================================================
function GridCustomLayoutsFrame_OnLoad(self)
	local frame = self;
	local mover = _G[frame:GetName() .. "Mover"] or CreateFrame("Frame", frame:GetName() .. "Mover", frame)
	mover:EnableMouse(true)
	mover:SetPoint("TOP", frame, "TOP", 0, 10)
	mover:SetWidth(160)
	mover:SetHeight(40)
	mover:SetScript("OnMouseDown", function(self)
		self:GetParent():StartMoving()
	end)
	mover:SetScript("OnMouseUp", function(self)
		self:GetParent():StopMovingOrSizing()
	end)
	frame:SetMovable(true)

	_G[self:GetName().."HeaderText"]:SetText(L["Custom Layouts"])
end

function GridCustomLayoutsFrame_NewOnClick()
	StaticPopup_Show("GRID_NEW_LAYOUT")
end

function GridCustomLayoutsFrame_SaveOnClick()
	local layout = GridCustomLayouts_ConvertLayout(GridCustomLayoutsFrameArg:GetText())
	if layout then
		local layoutName = UIDropDownMenu_GetSelectedValue(GridCustomLayoutsFrameDropDown)
		GridCustomLayouts.db.profile.layouts[layoutName] = GridCustomLayoutsFrameArg:GetText()
		GridLayout:SaveLayout(layoutName, layout)
		GridCustomLayoutsFrameArg:ClearFocus()
	else
		DEFAULT_CHAT_FRAME:AddMessage(L["Layout text format error, see above information."], 1, 0, 0)
	end
end

function GridCustomLayoutsFrame_DeleteOnClick()
	StaticPopup_Show("GRID_LAYOUT_DELETE")
end

function GridCustomLayouts_DropDown_Initialize()
	local info;
	local k,v;
	if GridCustomLayouts and GridCustomLayouts.db then
		for k, _ in pairs( GridCustomLayouts.db.profile.layouts ) do
			info = {};
			info.text = k
			info.func = GridCustomLayouts_DropDown_OnClick;
			info.value = k
			UIDropDownMenu_AddButton(info);
		end
	end
end

function GridCustomLayouts_DropDown_OnClick(self)
	GridCustomLayouts_SelectLayout(self.value)
end

function GridCustomLayouts_UpdateFrame()
	if next(GridCustomLayouts.db.profile.layouts) then
		GridCustomLayoutsFrameSave:Enable()
		GridCustomLayoutsFrameDelete:Enable()
		UIDropDownMenu_EnableDropDown(GridCustomLayoutsFrameDropDown)
	else
		GridCustomLayoutsFrameSave:Disable()
		GridCustomLayoutsFrameDelete:Disable()
		GridCustomLayoutsFrameArg:SetText("")
		UIDropDownMenu_DisableDropDown(GridCustomLayoutsFrameDropDown)
		GridCustomLayoutsFrameDropDownText:SetText("")
	end
	local v = UIDropDownMenu_GetSelectedValue(GridCustomLayoutsFrameDropDown)
	if( not v or GridCustomLayouts.defaultDB.layouts[v]) then
		GridCustomLayoutsFrameDelete:Disable()
	else
		GridCustomLayoutsFrameDelete:Enable()
	end
end

StaticPopupDialogs["GRID_NEW_LAYOUT"] = {
	text = NAME,
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	maxLetters = 24,
	OnAccept = function(self)
		GridCustomLayouts_NewLayout(self.editBox:GetText());
	end,
	OnShow = function(self)
		self.editBox:SetFocus();
	end,
	OnHide = function(self)
		self.editBox:SetText("");
	end,
	EditBoxOnEnterPressed = function(self)
		local parent = self:GetParent();
		GridCustomLayouts_NewLayout(parent.editBox:GetText());
		parent:Hide();
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["GRID_LAYOUT_DELETE"] = {
	text = CALENDAR_DELETE_EVENT_CONFIRM,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		GridCustomLayouts_DeleteLayout();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};