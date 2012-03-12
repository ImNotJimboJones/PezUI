local ZGV = ZygorGuidesViewer
if not ZGV then return end

local L = ZGV.L

local table,string,tonumber,tostring,ipairs,pairs,setmetatable = table,string,tonumber,tostring,ipairs,pairs,setmetatable

--[[
local function tostr(val)
	if type(val)=="string" then
		return '"'..val..'"'
	elseif type(val)=="number" then
		return tostring(val)
	elseif not val then
		return "nil"
	elseif type(val)=="boolean" then
		return tostring(val).." ["..type(val).."]"
	end
end
--]]

local function superconcat(table,glue)
	local s=""
	for i=1,#table do
		if #s>0 then s=s..glue end
		s=s..tostring(table[i])
	end
	return s
end

-- misc:
local function CreateDumpFrame()
	local name = "ZygorGuidesViewer_DumpFrame"

	local frame = CreateFrame("Frame", name, UIParent)
	ZGV.dumpFrame = frame
	frame:SetBackdrop({
	bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
	edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 5, bottom = 3 }
	})
	frame:SetBackdropColor(0,0,0,1)
	frame:SetWidth(500)
	frame:SetHeight(400)
	frame:SetPoint("CENTER", UIParent, "CENTER")
	frame:Hide()
	frame:SetFrameStrata("DIALOG")
	tinsert(UISpecialFrames, name)
	
	local scrollArea = CreateFrame("ScrollFrame", name.."Scroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -50)
	scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)

	local editBox = CreateFrame("EditBox", nil, frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontSmall)
	editBox:SetWidth(400)
	editBox:SetHeight(270)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
	ZGV.dumpFrame.editBox = editBox
	
	scrollArea:SetScrollChild(editBox)
	
	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")

	local title = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	ZGV.dumpFrame.title = title
	title:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -10)
	title:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -30, -45)
	title:SetJustifyH("CENTER")
	title:SetJustifyV("TOP")

end


local function dumpquest(quest)
	local s = ("%d. \"%s\" ##%d (lv=%d%s):\n"):format(quest.index,quest.title,quest.id,quest.level,quest.complete and ", complete" or "")
	for i,goal in ipairs(quest.goals) do
		s = s .. ("... %d. \"%s\" (%s, %s/%s%s)\n"):format(i,goal.leaderboard,goal.type,goal.num,goal.needed,goal.complete and ", complete" or "")
	end
	return s
end

local function anytostring(s)
	if type(s)=="table" then
		return superconcat(s,",")
	else
		return tostring(s)
	end
end

local BugReportFlags = {guide=1,step=1,player=1,questlog=1,inventory=1}

function ZGV:BugReport(maint)
	local s = ""
	s = ("Zygor Guides Viewer v%s\n"):format(self.version)
	s = s .. ("Guide: %s\nStep: %d\n"):format(self.CurrentGuideName or "no guide",self.CurrentStepNum or 0)
	s = s .. "\n"
	s = s .. "ENTER BUG DESCRIPTION HERE: ......................................................................\n\n"
	
	if maint then
		s = s .. "\nMAINTENANCE OPTIONS THAT WERE ENABLED PROPERLY: ______________\nMAINTENANCE OPTION THAT CAUSED DISCONNECTION: _______________\n\n"
	end

	if BugReportFlags.guide then
		s = s .. "--- GUIDE ---\n"
		if self.CurrentGuide then
			s = s .. ("Guide: %s\n"):format(tostring(self.CurrentGuide.title_short))
			local g = self.CurrentGuide
			s = s .. ("Type: %s  Parsed: %s  Fully: %s\n"):format(tostring(g.type),g.parsed and "yes" or "no", g.fully_parsed and "yes" or "no")
			s = s .. ("Startlevel: %s  Endlevel: %s\n"):format(tostring(g.startlevel),tostring(g.endlevel))
			s = s .. ("Next: %s \n"):format(tostring(g.next))
			local labels = ""
			for label,steps in pairs(g.steplabels) do
				labels = labels .. " " .. label .. "="
				for i,step in ipairs(steps) do
					labels = labels .. tostring(step) .. ","
				end
			end
			s = s .. ("Steps: %d  Labels: %s\n"):format(#g.steps,labels)
		else
			s = s .. "(no guide loaded)\n"
		end
		s = s .. "\n"
	end

	if BugReportFlags.step then
		local step = self.CurrentStep
		s = s .. "--- STEP ---\n"
		if step then
			for k,v in pairs(step) do
				local f

				if k=="map" then
					f=(GetMapNameByID(step.map) or '') .. '#'..tostring(step.map) .. " /"..tostring(step.floor)
				elseif k=="waypath" then
					f=(#v.coords).." points"
				elseif k~="goals" and k~="num" and k~="L"
				 and k~="isobsolete" and k~="isauxiliary"
				 and k~="parentGuide"
				 and k~="prepared"
				 and type(v)~="function" then
					f = anytostring(v)
				end
				if f then
					s = s .. ("  %s: %s\n"):format(k,f)
				end
			end
			local complete,possible = step:IsComplete()
			s = s .. ("  (complete: %s, auxiliary: %s, possible: %s)\n"):format(complete and "YES" or "NO", step:IsAuxiliary() and "YES" or "NO", possible and "YES" or "NO")

			s = s .. "Goals: \n"

			for i,goal in ipairs(step.goals) do
				s = s .. ("%d. %s %s\n"):format(i,(". "):rep(goal.indent),goal.text and "\""..goal.text.."\"" or "<"..goal:GetText()..">")
				for k,v in pairs(goal) do
					local f
					-- hide these completely
					if k~="map" and k~="mapL" and k~="x" and k~="y" and k~="dist"
					and k~="L"
					and k~="indent" and k~="text" and k~="parentStep" and k~="num" and k~="status"
					-- these get their own display
					and k~="item" and k~="itemid"
					and k~="castspell" and k~="castspellid"
					and k~="quest" and k~="questid" and k~="questreqs"
					and k~="lasttext" and k~="lastbrief" and k~="lastshowcompleteness"
					and k~="mobs"
					and k~="target" and k~="targetid" and k~="objnum"
					and k~="condition_visible_raw" and k~="condition_complete_raw" 
					and type(v)~="function" then
						f = anytostring(v)
					end
					if f then
						s = s .. ("    %s: %s\n"):format(k,f)
					end
				end
				if goal.x or goal.y or goal.action=="goto" then
					local map
					if goal.map then
						map = (GetMapNameByID(goal.map) or '') .. '#'..tostring(goal.map) .. "/"..tostring(goal.floor)
					else
						map = "unknown"
					end
					s = s .. ("    map: %s %s,%s"):format(map,goal.x or "nil",goal.y or "nil")
					if goal.dist then s = s .. (" %s%s"):format(goal.dist>0 and ">" or "<",math.abs(goal.dist)) end
					s = s .. "\n"
				end
				if goal.itemid or goal.item then
					s = s .. ("   item: \"%s\"  ##%s"):format(tostring(goal.item),tostring(goal.itemid))
					if goal.itemid then
						local a={GetItemInfo(goal.itemid)}
						s = s .. ("  GetItemInfo(%d) == %s\n"):format(goal.itemid,superconcat(a,","))
					elseif goal.item then
						local a={GetItemInfo(goal.item)}
						s = s .. ("  GetItemInfo(\"%s\") == %s\n"):format(goal.item,superconcat(a,","))
					end
				end
				if goal.castspellid or goal.castspell then
					s = s .. ("   castspell: \"%s\"  ##%s"):format(tostring(goal.castspell),tostring(goal.castspellid))
					if goal.castspellid then
						local a={GetSpellInfo(goal.castspellid)}
						s = s .. ("  GetSpellInfo(%d) == %s\n"):format(goal.castspellid,superconcat(a,","))
					elseif goal.castspell then
						local a={GetSpellInfo(goal.castspell)}
						s = s .. ("  GetSpellInfo(\"%s\") == %s\n"):format(goal.castspell,superconcat(a,","))
					end
				end
				if goal.questid and goal.quest then
					local questdata,inlog = ZGV.Localizers:GetQuestData(goal.questid)
					s = s .. ("    quest: \"%s\" ##%s"):format(questdata and questdata.title or "?",tostring(goal.questid))
					if goal.questid then
						if goal.objnum then
							if questdata and questdata.goals then
								local goaltext = questdata.goals[goal.objnum].item
								if not goaltext then goaltext="???" end
								s = s .. (" goal %d: \"%s\""):format(goal.objnum,goaltext)
							else
								s = s .. (" goal %d"):format(goal.objnum)
							end
						else
							s = s .. (" (no goal)")
						end
						if inlog then
							s = s .. "  - quest in log "
						else
							s = s .. "  - quest not in log "
						end
						if self.completedQuests[goal.questid] then
							s = s .. "(id: completed)"
						else
							s = s .. "(id: not completed)"

							-- deprecating title storing totally, since GetQuestID is here.
							--[[
							if self.completedQuestTitles[goal.quest] then
								s = s .. " (title: completed)"
							else
								s = s .. " (title: not completed)"
							end
							--]]
						end
					end
					s = s .. "\n"
				end
				if goal.target then
					s = s .. ("    target: \"%s\""):format(goal.target)
					if goal.targetid then
						s = s .. (" ##%d\n"):format(goal.targetid)
					end
					s = s .. "\n"
				end
				if goal.mobs then
					s = s .. "    mobs: "
					for k,v in ipairs(goal.mobs) do
						s = s .. v.name .. "  "
					end
					s = s .. "\n"
				end
				if goal.questreqs and #goal.questreqs>0 then
					s = s .. "    questreqs: "..superconcat(goal.questreqs,",").."\n"
				end
				if goal.condition_visible then
					s = s .. "    visibility condition: "..goal.condition_visible_raw.."\n"
				end
				if goal.condition_complete then
					s = s .. "    completion condition: "..goal.condition_complete_raw.."\n"
				end

				s = s .. "    Status: "..goal:GetStatus()

				if goal:IsCompleteable() then
					local comp,poss,prog = goal:IsComplete()
					s = s .. (" (completable: complete? %s, possible? %s, progress %s, auxiliary? %s)\n"):format(comp and "YES" or "no", poss and "YES" or "no", tostring(prog), step:IsAuxiliary() and "YES" or "no")
				else
					s = s .. "  (not completable)\n"
				end
			end
			s = s .. "\n"
		else
			s = s .. "No current step loaded.\n\n"
		end
	end

	if BugReportFlags.player then
		s = s .. "--- Player information ---\n"
		s = s .. ("Race: %s  Class: %s  Level: %.2f\n"):format(select(2,UnitRace("player")),select(2,UnitClass("player")),self:GetPlayerPreciseLevel())
		SetMapToCurrentZone()
		local x,y = GetPlayerMapPosition("player")
		s = s .. ("Position: %s #%s /%s [%g,%g] (zone:'%s', realzone:'%s', subzone:'%s', minimapzone:'%s')\n"):format(GetMapNameByID(ZGV.CurrentMapID or 0) or "?",ZGV.CurrentMapID or "?", ZGV.CurrentMapFloor or "?", x*100,y*100,GetZoneText(),GetRealZoneText(),GetSubZoneText(),GetMinimapZoneText())
		if GetLocale()~="enUS" then
			--s = s .. ("    enUS: realzone:'%s' zone:'%s' subzone:'%s' minimapzone:'%s')\n"):format(tostring(BZR[GetRealZoneText()]),tostring(BZR[GetZoneText()]),BZR[GetSubZoneText()] or "("..GetSubZoneText()..")",BZR[GetMinimapZoneText()] or "("..GetMinimapZoneText()..")")
			s = s .. ("Locale: %s\n"):format(GetLocale())
		end
		if UnitClass("target") then
			s = s .. ("Target: %s ##%s\n"):format(UnitName("target"),ZGV.GetTargetId())
		end
		s = s .. "\n"
	end

	if BugReportFlags.questlog then
		s = s .. "--- Cached quest log ---\n"
		if self.quests then
			for index,quest in pairs(self.quests) do
				s = s .. dumpquest(quest)
			end
		else
			s = s .. "(no quest log)"
		end
		s = s .. "\n"

		s = s .. "--- Cached quests, by ID ---\n"
		if self.questsbyid then
			for id,quest in pairs(self.questsbyid) do
				s = s .. ("#%d: %s\n"):format(id,quest.title)
			end
		else
			s = s .. "(no quest log)"
		end
		s = s .. "\n"
	end

	if BugReportFlags.inventory then
		s = s .. "--- Inventory ---\n"
		local inventory={}
		for bag=-2,4 do
			for slot=1,GetContainerNumSlots(bag) do
				local item = GetContainerItemLink(bag,slot)
				if item then
					local id,name = string.match(item,"item:(.-):.-|h%[(.-)%]")
					local tex,count = GetContainerItemInfo(bag,slot)
					tinsert(inventory,("    %s ##%d x%d\n"):format(name,id,count))
				end
			end
		end
		table.sort(inventory)
		s = s .. table.concat(inventory,"")
		s = s .. "\n"
	end

	s = s .. "-- Buffs/debuffs --\n"
	for i=1,30 do
		local name,_,tex = UnitBuff("player",i)
		if name then s=s..("%s (\"%s\")\n"):format(name,tex) end
	end
	for i=1,30 do
		local name,_,tex = UnitDebuff("player",i)
		if name then s=s..("%s (\"%s\")\n"):format(name,tex) end
	end
	s = s .. "\n"

	s = s .. "-- Pet action bar --\n"
	for i=1,12 do
		local name,_,tex = GetPetActionInfo(i)
		if name then s=s..("%d. %s (\"%s\")\n"):format(i,name,tex) end
	end
	s = s .. "\n"

	s = s .. "-- Flight Paths --\n"
	if self.LibTaxi then
		s = s .. table.concat(TableKeys(self.db.char.taxis)," , ")
	end
	s = s .. "\n\n"

	s = s .. "-- Options --\n"
	s = s .. "Profile:\n"
	for k,v in pairs(self.db.profile) do s = s .. "  "..k.." = "..anytostring(v)..",  " end
	s = s .. "\n"

	--s = s .. self:DumpVal(self.quests,0,4,true)
	--self:Print(s)
	if self.ErrorLogger_GetErrors then
		local errors = self:ErrorLogger_GetErrors()
		if #errors>0 then
			s = s .. "-- Errors --\n"
			for ei,err in ipairs(errors) do s = s .. "----------------\nTime: "..(err.time or "?").."\nCount: "..(err.count or 1).."\nError: \n"..tostring(err.message).."\n----------------\n" end
		end
	end

	s = s .. "-- Log --\n"
	s = s .. self.Log:Dump(100)

	local title = maint and "Zygor Guides Viewer" or (self.CurrentGuideName or L["report_notitle"])
	local author = maint and "zygor@zygorguides.com" or (self.CurrentGuide and self.CurrentGuide.author or L["report_noauthor"])

	title = L["report_title"]:format(title,author)

	self:ShowDump(s,title,true)

end



function ZGV:ShowDump(text,title,editable)
	if not self.dumpFrame then CreateDumpFrame() end

	HideUIPanel(InterfaceOptionsFrame)
	HideUIPanel(ZygorGuidesViewerMaintenanceFrame)

	self.dumpFrame.editBox:SetText(text)
	self.dumpFrame.title:SetText(title or "Generic dump:")
	ShowUIPanel(self.dumpFrame)
	if editable then
		self.dumpFrame.editBox:HighlightText(0)
		self.dumpFrame.editBox:SetFocus(true)
	else -- TODO it's not really readonly is it?
		--self.dumpFrame.editBox:Enable(false)
	end
end

function ZGV:DumpVal(val,lev,maxlev,nofun)
	if not lev then lev=1 end
	if not maxlev then maxlev=1 end

	if lev>maxlev then return ("...") end
	local s = ""
	if type(val)=="string" then
		s = ('"%s"'):format(val)
	elseif type(val)=="number" then
		s = ("%s"):format(tostring(val))
	elseif type(val)=="function" then
		s = ("")
	elseif type(val)=="table" then
		s = "\n"
		for k,v in pairs(val) do
			if type(k)~="string" or not k:find("^parent")
			then
				if type(v)~="function" then
					s = s .. ("   "):rep(lev) .. ("%s=%s"):format(k,self:DumpVal(v,lev+1,maxlev,nofun))
				elseif not nofun then
					s = s .. ("   "):rep(lev) .. ("%s(function)\n"):format(k)
				end
			end
		end
	end

	return s.."\n"
end
