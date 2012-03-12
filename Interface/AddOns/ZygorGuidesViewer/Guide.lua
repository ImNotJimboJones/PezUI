local Guide = { }

local ZGV = ZygorGuidesViewer
if not ZGV then return end

local L = ZGV.L

local table,string,tonumber,ipairs,pairs,setmetatable = table,string,tonumber,ipairs,pairs,setmetatable

ZGV.GuideProto = Guide
local GuideProto_mt = { __index=Guide }

function Guide:New(tit,title,data,extra)
	local guide = {['title']=title,['title_short']=tit or title,['rawdata']=data,['extra']=extra, num=#ZGV.registeredguides+1, parsed=nil, fully_parsed=nil}
	setmetatable(guide,GuideProto_mt)
	return guide
end

function Guide:DoCond(which,...)
	if which=="valid" and not self.condition_valid then
		-- Check class/spec compatiblity
		if self.class then
			local lclass,kclass=UnitClass("player")
			if kclass~=self.class then
				local classeslocalized={}
				FillLocalizedClassList(classeslocalized,UnitSex("player")==3)
				return false,classeslocalized[self.class].." class is required." -- TODO localize
			elseif self.spec then
				if not self.spec[GetPrimaryTalentTree()] then
					local specnames,multiple
					for k,v in pairs(self.spec) do
						local _,specname=GetTalentTabInfo(k)
						if specnames then specnames=specnames..", " multiple=true else specnames="" end
						specnames=specnames..specname
					end
					return false,"Only the following spec"..(multiple and "s are" or " is").." eligible: "..specnames
				end
			end
		end
		
		if self.startlevel then
			return ZGV:GetPlayerPreciseLevel()>=self.startlevel,"Level "..ZGV.FormatLevel(self.startlevel).." or higher is required."
		end
		-- If above is ok
		return true
	end
		
	if which=="suggested" and not self.condition_suggested and self.startlevel then return ZGV:GetPlayerPreciseLevel()>=self.startlevel end
	if which=="end" and not self.condition_end and self.endlevel then return ZGV:GetPlayerPreciseLevel()>=self.endlevel,"Level "..ZGV.FormatLevel(self.endlevel).." reached." end
	if which and self['condition_'..which] then
		return self['condition_'..which](self,...),self['condition_'..which..'_msg']
	end
end

function Guide:GetStatus()
	local ret,msg

	ret,msg = self:DoCond("invalid")
	if ret then return "INVALID",msg end

	ret,msg = self:DoCond("valid")
	if ret then
		ret,msg = self:DoCond("end")
		if ret then return "COMPLETE",msg end
		msg="" -- TODO it's a bug, we ask the end condition and we're reusing its value even if the guide isnt complete

		if self.type=="leveling" then
			ret,msg = self:DoCond("suggested")
			if ret then return "SUGGESTED" end
		end

		return "VALID",msg
	else
		return "INVALID",msg
	end
end

function Guide:GetCompletion()
	self.completionmode = self.completionmode
		or (self.title:find("Loremaster") and "quests")
		or (self.title:find("Leveling") and "level")
		or "steps"
	local mode = self.completionmode
	
	if mode=="macro" then
		local acc=self.macro:MacroExists("account")
		local char=self.macro:MacroExists("character")
		return (acc or char) and 1 or 0,acc,char
	end 

	if self.parse_failed then return "error","parsing failed" end

	if mode=="quests" or mode=="steps" then
		-- request full parsing for those
		if not self.fully_parsed then
			self.need_to_parse=true
			ZGV:Debug("Guide:GetCompletion : '"..self.title.."' needs parsing for completion type '"..mode.."'")
			return "loading"
		end
	end

	if mode=="none" then
		return "none"
	elseif mode=="level" then
		if not self.startlevel or not self.endlevel then return "error","no starting/ending level set" end
		return min(1,max(0,(ZGV:GetPlayerPreciseLevel()-self.startlevel)/(self.endlevel-self.startlevel)))
	elseif mode=="quests" then
		if not next(ZGV.completedQuests) then return "loading","waiting for quest data to arrive from server" end
		local quests = self:GetQuests()
		local count,comp = 0,0
		for qid,step in pairs(quests) do
			count=count+1
			if ZGV.completedQuests[qid] then comp=comp+1 end
		end
		return count>0 and comp/count or 0, comp,count
	elseif mode=="steps" then
		local count,comp = 0,0
		for si,step in ipairs(self.steps) do
			if not step:IsAuxiliary() then
				count=count+1
				if step:IsComplete() then comp=comp+1 end
			end
		end
		return count>0 and comp/count or 0, comp,count
	elseif mode=="skill" then
		local skill = ZGV:GetSkill(self.completionparams[1])
		return skill.level/self.completionparams[2] or 525, skill.level, self.completionparams[2] or 525
	end
	-- other completions might not need a full parse.
	return "error","we don't know if this guide completes or not"
end

function Guide:GetCompletionText()
	local comp,a,b,c,d = self:GetCompletion()
	assert(comp) -- Sanity!
	if comp=="loading" then return "...","(loading)" end
	if comp=="error" or type(comp)~="number" then return "?",("(an error occurred: %s)"):format(a or "black magic") end
	
	if self.completionmode=="none" then
		return "-", "This guide does not complete."
	elseif self.completionmode=="skill" then
		local skill = ZGV:GetSkill(self.completionparams[1])
		--return ("%d/%d"):format(a,b), ("%s skill: %d/%d"):format(ZGV.LocaleSkills[self.completionparams[1]],a,b)
		return math.floor(comp*100).."%", ("%s skill: %d/%d"):format(ZGV.LocaleSkills[self.completionparams[1]],a,b)
	elseif self.completionmode=="quests" then
		return math.floor(comp*100).."%", ("Quests completed: %d/%d"):format(a,b)
	elseif self.completionmode=="level" then
		return math.floor(comp*100).."%", ("Level %2d (+%d bars) reached: %d%%"):format(self.endlevel,(self.endlevel-math.floor(self.endlevel))*20,math.floor(comp*100))
	elseif self.completionmode=="steps" then
		return math.floor(comp*100).."%", ("Steps completed: %d/%d"):format(a,b)
	elseif self.completionmode=="macro" then
		return comp~=0 and "+" or "—",comp~=0 and L["macro_status_yes"]:format((a and b) and L["macro_both"] or (a and L["macro_acc"] or L["macro_char"])) or L["macro_status_no"]
	else
		return math.floor(comp*100).."%", ""
	end
end

function Guide:Load(step)
	ZGV:SetGuide(self,step)
end

function Guide:Unload()
	self.steps=nil
	self.fully_parsed=nil
	collectgarbage("step",100)
end

function Guide:Parse(fully)
	if self.rawdata and (not self.parsed or not self.fully_parsed) then

		if self.parse_failed then return end
		
		if fully then ZGV:Debug("Parsing guide: "..self.title) end

		local lastparsed = {linenum=-2,linedata="-?-"}
		local success,parsed,err,line,stepnum,linedata = coroutine_safe_pcall(function() return ZGV.Parser:ParseEntry(self,fully,lastparsed) end)

		if not success then
			local err = parsed
			ZGV:Error(L["message_errorloading_critical"]:format(self.title,err,lastparsed.linenum,lastparsed.linedata))
			self.parse_failed = true
			return nil

		elseif not parsed then
			if err then
				ZGV:Error(L["message_errorloading_full"]:format(self.title,line or 0,stepnum or "?",linedata or "???",err))
			else
				ZGV:Error(L["message_errorloading_brief"]:format(self.title))
			end
			self.parse_failed = true
			return nil

		else

			self.parsed = true

			-- parsed!
			for k,v in pairs(parsed) do self[k]=v end

			if self.steps and (#self.steps>0) then
				self.fully_parsed = true

				-- cap it with a finisher step
				if (self.steps[#self.steps].condition_valid or self.steps[#self.steps].requirement) then
					tinsert(self.steps,
						ZGV.StepProto:New {
							num=#self.steps+1,
							parentGuide=self,
							finish=true,
							goals = {
								[1] = ZGV.GoalProto:New {
									num=1,
									action="",
									text="This guide is now complete.",
									parentStep=step
								}
							}
						}
					)
				end

				-- gather all step labels, round'em up and brand'em
				self.steplabels={}
				for si,step in ipairs(self.steps) do
					local label=step.label
					if label then
						if not self.steplabels[label] then self.steplabels[label]={} end
						tinsert(self.steplabels[label],si)
					end
				end

				return true
			end

		end
		--if full_load then self.rawdata=nil end
		--self:Debug("Parsed: "..guide.title)
	end
end

function Guide:GetQuests()
	self:Parse(true)
	if not self.parsed then return end
	local tab={}
	for si,step in ipairs(self.steps) do
		for gi,goal in ipairs(step.goals) do
			if goal.questid then tab[goal.questid]=si end
		end
	end
	return tab
end

------- hello popup

StaticPopupDialogs['ZYGORGUIDESVIEWER_NEXTGUIDE'] = {
	text = L['static_caption']..L['static_nextguide'],
	button1 = ACCEPT,
	button2 = CANCEL,
	hideOnEscape = 1,
	timeout = 0,
	whileDead = 1,
	OnAccept = function(self) ZGV:SetGuide(self.guide) end,
	OnCancel = function(self) ZGV.db.char.ignoredguides[self.guide.title]=true  end,
}

StaticPopupDialogs['ZYGORGUIDESVIEWER_BADGUIDE'] = {
	text = L['static_caption']..L['static_badguide'],
	button1 = YES,
	button2 = NO,
	hideOnEscape = 1,
	timeout = 0,
	whileDead = 1,
	OnAccept = function(self)  ZGV.db.char.goodbadguides[self.guide.title]=true  ZGV:SetGuide(self.guide,self.step)  end,
	OnCancel = function(self)  ZGV.GP:Show(self.guide)  end,
}

function Guide:AdvertiseWithPopup(nodelay)
	local delay = true
	if nodelay then delay=false end
	if delay and ZGV:IsPlayerInCombat() then
		ZGV.call_after_combat = function() self:AdvertiseWithPopup(true) end
		ZGV:Print("Next guide is ready. Just finish your combat.")
	else
		local dialog = StaticPopup_Show('ZYGORGUIDESVIEWER_NEXTGUIDE',self.title_short)
		dialog.guide=self
	end
end

function Guide:GetFirstValidStep(start)
	if not self.fully_parsed then return end
	local first = self.steps[start or 1]
	assert(first,"no steps?? what the hell?")
	if first:AreRequirementsMet() or ZGV.db.profile.showwrongsteps then return first end
	local firstvalid = first:GetNextValidStep()
	if not firstvalid then
		-- uh-oh! Either we started on an invalid step and there are only invalids to the end... or something went very wrong.
		assert(start>1,"The guide has NO valid steps!")
		first = self.steps[1]
		if first:AreRequirementsMet() then return first end
		firstvalid = first:GetNextValidStep()
		assert(firstvalid,"The guide has NO valid steps! (after retry at start)")
		ZGV:Print("No valid steps past "..start.." found. Restarting guide at step 1.")
	end
	return firstvalid  -- always returns something, or breaks.
end
