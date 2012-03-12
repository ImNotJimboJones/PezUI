--------------------------------------------------------------------------------
-- BrokerToolBox                                                              --
-- Author: Sanori/Pathur                                                      --
--------------------------------------------------------------------------------
local _, me=...
BrokerToolBox = me											--extern addons can use this, but functions NewL and NewTool must be called in ADDON_LOADED event
me.version="1.3.5 (core: 1.3)"

me.broker = LibStub:GetLibrary("LibDataBroker-1.1")	--Data Broker
me.dropdown = LibStub('ArkDewdrop-3.0')					--Dropdownmenu

me.tools={}
me.locale={}
me.OnUpdate={}
me.toollist={}

me.frame = CreateFrame("FRAME")
me.frame:RegisterEvent("PLAYER_LOGIN")
me.frame:RegisterEvent("PLAYER_LEAVING_WORLD")

--Table Alphabetical Sort Function
function me:pairsByKeys(t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0                                    --iterator variable
		local iter = function ()                       --iterator function
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	return iter
end



--Events
me.frame:SetScript("OnEvent", function(self, event, ...)
	local arg1, arg2 = ...
	if event == "PLAYER_LOGIN" then
		self:UnregisterEvent("PLAYER_LOGIN")
		--Create Save
		local db={
			enabled={},
			tools={},
		}
		for name,data in pairs(me.tools) do
			db.enabled[name]=data.defaultON
			db.tools[name]=data.db
		end
		me.save=LibStub('LibSaver-1.0'):NewSave("BrokerToolBoxDB",db)
		--create list of tools
		for name,data in pairs(me.tools) do
			local toolname = data.name or name
			if me.locale[name] and me.locale[name].name then toolname = me.locale[name].name end
			local tooldesc = data.description
			if me.locale[name] and me.locale[name].description then tooldesc = me.locale[name].description end
			me.toollist[name]={
				name=toolname,
				desc=tooldesc,
				author=data.author,
				version=data.version,
				requires=data.requires,
			}
			if data.broker then me.toollist[name].icon=data.broker.icon end
			me.tools[name].name = toolname
			me.tools[name].description = description
		end
		--cleare disabled tools to save memory
		for name,data in pairs(me.toollist) do
			if ((not me.save.enabled[name]) or (data.requires  and (not IsAddOnLoaded(data.requires)))) then
				me.tools[name] = nil
				me.locale[name] = nil
			else
				me.tools[name].db=me.save.tools[name]
			end
		end
		--create broker
		me.dataobj = me.broker:NewDataObject("BrokerToolBox", {
			type = "launcher",
			text = "BrokerToolBox",
			icon = "Interface\\Icons\\Trade_BlackSmithing",
			OnTooltipShow = function(self)
				GameTooltip:AddLine("BrokerToolBox")
				GameTooltip:AddLine(me.locale.core.click)
			end,
			OnClick = function(self)
				me.menu:Open(self, 'children', function(level, value)
					GameTooltip:Hide()
					me.menu:AddTitle("BrokerToolBox")
					me.menu:AddTitle("|cffffffff"..me.locale.core.version..": "..me.version.."|r")
					me.menu:AddLine()
					for name,data in me:pairsByKeys(me.toollist) do
						local icon="|TInterface\\Icons\\INV_Misc_QuestionMark:22:22:0:0|t "
						if (me.tools[name] and me.tools[name].broker and me.tools[name].broker.icon) then
							icon="|T"..me.tools[name].broker.icon..":22:22:0:0|t "
						elseif data.icon then
							icon="|T"..data.icon..":22:22:0:0|t "
						end
						if (data.requires and not IsAddOnLoaded(data.requires)) then data.name="|cffff0000"..data.name.."|r" end
						me.menu:AddToggle(icon..data.name, me.save.enabled[name], function(var) me.save.enabled[name]=var; UIErrorsFrame:AddMessage(me.locale.core.reloadrequired,1.0,0,0,100,3); end, function()
							if data.desc then GameTooltip:AddLine(data.desc) end
							if data.requires then
								if IsAddOnLoaded(data.requires) then
									GameTooltip:AddLine(me.locale.core.requires..": "..data.requires,0,1,0)
								else
									GameTooltip:AddLine(me.locale.core.requires..": "..data.requires,1,0,0)
								end
							end
							if data.author then GameTooltip:AddLine(me.locale.core.author..": "..data.author,1,1,1) end
							if data.version then GameTooltip:AddLine(me.locale.core.version..": "..data.version,1,1,1) end
						end)
					end
					me.menu:AddLine()
					me.menu:AddFunc(me.locale.core.reloadui, function() ReloadUI() end)
				end)
			end,
		})
		--events
		for name,data in pairs(me.tools) do
			if data.PreInit then data:PreInit(data) end
			if data.events then
				for event,_ in pairs(data.events) do
					self:RegisterEvent(event)
				end
			end
			--OnUpdate Handler
			if data.OnUpdate then
				me.OnUpdate[name] = data.OnUpdate
				self:SetScript("OnUpdate",function(self, elapsed)		--Register script if not registert
					for k,v in pairs(me.OnUpdate) do
						v(me.tools[k], elapsed)
					end
				end)
			end
			--
			if data.broker then
				me.tools[name].broker=me.broker:NewDataObject("BrokerToolBox - "..data.name, data.broker)
			end
			if data.PostInit then data:PostInit(data) end
		end
	elseif event == "PLAYER_LEAVING_WORLD" then
		for name,data in pairs(me.tools) do
			if data.PlayerLeavingWorld then data:PlayerLeavingWorld(data) end
			me.save.tools[name]=data.db
		end
	else
		for name,data in pairs(me.tools) do
			if (data.events and data.events[event]) then
				data.events[event](data, ...)
			end
		end
	end
end)



--adds a new tool
function me:NewTool(name, table)
	me.tools[name] = table
	me.tools[name].L = function(self, locale)
		if (me.locale[name] and me.locale[name][locale]) then
			return me.locale[name][locale]
		else
			return "["..locale.."]"
		end
	end
	me.tools[name].menu = me.menu
	return me.tools[name]
end
--add new locale
function me:AddLocalization(table, locale)
	if (locale and locale~=GetLocale()) then return end
	for k,v in pairs(table) do
		local tool, _ = strsplit("_",k)
		local index = strjoin("_",select(2,strsplit("_",k)))
		if (not tool or tool=="" or not index or index=="") then return end
		if not me.locale[tool] then me.locale[tool]={} end
		if (locale or (not locale and not me.locale[tool][k])) then
			me.locale[tool][index] = v
		end
	end
	wipe(table)
end



--dropdown wrapper functions
me.menu = {}
function me.menu:Open(...)
	me.dropdown:Open(...)
end
function me.menu:AddLine(...)
	me.dropdown:AddLine(...)
end
--create a toggle (use func(var) to save you var)
function me.menu:AddToggle(name, var, func, tooltipfunc, ...)
	local lfunc = function()
		var = not var
		if func then func(var) end
	end
	local checked = false
 	if var then checked=true end
 	if not tooltipfunc then tooltipfunc=function() return end end
	me.dropdown:AddLine('text',name,'func',lfunc,'checked',checked,'tooltipFunc',tooltipfunc,...)
end
--create a button
function me.menu:AddFunc(name, func, icon, closewhenclicked, tooltipfunc, ...)
	if closewhenclicked==nil then closewhenclicked=false end
	if not tooltipfunc then tooltipfunc=function() return end end
	me.dropdown:AddLine('text',name,'icon',icon,'func',func,'tooltipFunc',tooltipfunc,'closeWhenClicked',closewhenclicked,...)
end
function me.menu:AddSpell(name, spell, icon, closewhenclicked, tooltipfunc, ...)
	if closewhenclicked==nil then closewhenclicked=false end
	if not tooltipfunc then tooltipfunc=function() return end end
	me.dropdown:AddLine('text',name,'icon',icon,'secure',{type1='spell',spell=spell},'tooltipFunc',tooltipfunc,'closeWhenClicked',closewhenclicked,...)
end
--create a submenu
function me.menu:AddArrow(name,value,icon,tooltipfunc, ...)
	if not tooltipfunc then tooltipfunc=function() return end end
	me.dropdown:AddLine('hasArrow',true,'text',name,'icon',icon,'value',value,'tooltipFunc',tooltipfunc,...)
end
--add title line
function me.menu:AddTitle(name, icon, ...)
	me.dropdown:AddLine('isTitle',true,'text',name,'icon',icon,...)
end
--create a alphabetical sorted selection: format of data={["TEXT1"]=VAR1,["TEXT2"]=VAR2,...}
--if you like a custom sorting, add <001>, <002>, ... to the beginning of the TEXT
function me.menu:AddSelection(var, func, data, ...)
	local checked
	for text,_var in me:pairsByKeys(data) do
		if var==_var then checked=true else checked=nil end
		text = gsub(text,"^<.+>", "")	--use <xxx> to custom sort the list
		me.dropdown:AddLine('text',text,'func',function() if func then func(_var) end end, 'checked',checked,'tooltipFunc',function() return end,...)
	end
end
--creates a slider (use func(var) to save you var)
function me.menu:AddSlider(name, var, minval, maxval, step, func, tooltipfunc, ...)
	local lfunc = function(val)
		if func then func(val) end
	end
	if not tooltipfunc then tooltipfunc=function() return end end
	me.dropdown:AddLine('text',name,'hasArrow',true,'hasSlider',true,'sliderMin',minval,'sliderMax',maxval,'sliderStep',step,'sliderValue',var,'sliderFunc',lfunc,'tooltipFunc',tooltipfunc,...)
end