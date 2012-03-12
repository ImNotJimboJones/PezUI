local Step = {}
local ZGV = ZygorGuidesViewer
if not ZGV then return end
local L = ZGV.L
local LM = ZGV.LM

local table,string,tonumber,ipairs,pairs,setmetatable,min,max = table,string,tonumber,ipairs,pairs,setmetatable,min,max

ZGV.StepProto = Step
ZGV.StepProto_mt = { __index=Step }

function Step:New(data)
	setmetatable(data,ZGV.StepProto_mt)
	return data
end

---
-- @return complete, possible, manual
function Step:IsComplete()
	--self:Debug("Step complete check")
	--if not self.CurrentStep then return false end
	--if not self.CurrentStep.goals then return false end
	if not self:AreRequirementsMet() then return true end

	local completeable = false
	local complete = true
	local steppossible = false

	local allhidden = true

	local alloptional = true

	-- 'or' logic: one or-positive goal marks all or-positive goals as done. Will collect completed or's in here.
	--local orlist = {}
	local orneeded = 0
	local orcount = 0
	local orcomplete = false

	-- prepare statuseses
	for i,goal in ipairs(self.goals) do goal:UpdateStatus() end


	-- do LOGIC! omg.
	if self.logic_fun then
		self.logic_env:_Update()
		return self.logic_fun()
	end


	-- one click to complete them all
	for i,goal in ipairs(self.goals) do
		if goal.action=="confirm" and goal.status=="complete" then return true,true end
	end


	-- check for ORs!
	local status
	for i,goal in ipairs(self.goals) do
		status = goal.status
		if status~="hidden" then
			if goal.orlogic then
				--orlist[goal]=true
				orneeded = goal.orlogic
				if status=="complete" then
					-- count all completed or's
					orcount = orcount + 1
				end
			end
		end
	end
	orcomplete = (orneeded>0 and orcount>=orneeded)

	-- all hidden? die.
	for i,goal in ipairs(self.goals) do
		if (goal.status~="hidden" and goal.action) and not goal.temporary then allhidden=false end
	end
	if allhidden then return true,true end


	for i,goal in ipairs(self.goals) do
		status = goal.status
		if status=="complete" or status=="incomplete" then
			completeable = true
			local done,possible
			if goal.orlogic --[[and orlist[goal] --]] and orcomplete then
				status="complete" -- don't bother to check, force
			end
			if status~="complete" and not goal.optional  then  complete = false  end
			if not goal.optional then alloptional = false end
			if status=="incomplete" --[[possible and not done--]] then  steppossible = true  end
		end
	end
	return completeable and complete and not alloptional, steppossible
end

--[[
function Step:NeedsUpdating()
	if not self.goalsneedupdating then self.goalsneedupdating={} end
	local needs=false
	for i,goal in ipairs(self.goals) do
		local needup = self.goalsneedupdating[goal]
		if not needup then self.goalsneedupdating[goal]={} needup = self.goalsneedupdating[goal] end
		if goal:IsCompleteable() then
			local done,possible = goal:IsComplete()
			local text = goal:GetText(possible)
			if needup.done~=done or needup.possible~=possible or needup.text~=text then
				needs=true
				print(goal.num.." needs updating")
			end
			needup.done=done
			needup.possible=possible
			needup.text=text
		end
	end
	return needs
end
--]]

function Step:AreRequirementsMet()
	local raceclass=true
	if self.requirement then
		raceclass=false
		for i,v in pairs(self.requirement) do if ZGV:RaceClassMatch(v) then raceclass=true break end end
	end
	if not raceclass then return false end

	if self.condition_visible then
		ZGV.Parser.ConditionEnv._SetLocal(self.parentGuide,self,self.goals[1])
		if not self.condition_visible() then return false end
	end

	return true
	-- wrong
	--- wtf? why?
end

--- Run before the step is displayed. May be called periodically to update.
function Step:PrepareCompletion(full)
	if full then self.prepared=nil end
	if self.prepared then return end

	-- prepare macros
	if not InCombatLockdown() then
		for i=1,99 do DeleteMacro("ZGVMacro"..i) end
	end

	-- repurposed: autoadjustment of get/kill/goal
	for i,goal in ipairs(self.goals) do
		goal:Prepare(true)
	end


	-- REMOVE non-matching goals
	--[[
	local i=1
	while i<#self.goals do
		print(i)
		if not self.goals[i]:IsFitting() then tremove(self.goals,i) else i=i+1 end
	end
	--]]

	if self.logic then
		self.logic_env = {
			_G = _G,
			step = self,
			goalcomplete = {},

			_Update = function(env)
				env.goalcomplete={}
				for i,goal in ipairs(env.step.goals) do
					env.goalcomplete[i]=goal:IsComplete()
				end
			end,
		}
		
		local code = step.logic:gsub("([0-9]+)","goalcomplete[%1]")
		local fun,err = loadstring("return not not "..code)

		if fun then
			setfenv(fun,self.logic_env)
			self.logic_fun = fun
		else
			ZGV:Print("Error in step logic: " .. self.logic .. "  error: " .. err)
		end
	end

	ZGV:Debug("step "..self.num.." prepared.")
	self.prepared=true
end

---  This is called with every step frame update, so around 1/sec or more often, depending on (also) its own returns.
-- @return changed,stilldirty
-- When this returns stilldirty, the next update is IMMEDIATE.
function Step:Translate()
	local changed=false
	local stilldirty=false
	local failure=false

	for i,goal in ipairs(self.goals) do
		if goal:NeedsTranslation() then
			if goal:AutoTranslate() then changed=true else stilldirty=true end
		end
		if goal.Lfail then  goal.L=nil  failure=true  end
	end

	if failure then return changed,false end  -- "we're as clean as we can get for now"

	if not self.L then
		if self.title then
			local name,id = nil --ZGV.Parser:ParseID(self.title)
			if id then
				local qt = ZGV.Localizers:GetQuestData(id)
				if qt then
					self.title=qt
					self.L = true
					changed=true
					if ZGV.CurrentStep==self then ZGV:SetWaypoint() end
				else
					stilldirty=true
				end
			else
				self.L = true
			end
		else
			self.L = true
		end
	end
			
	return changed,stilldirty
end

--- Auxiliary steps are only used to lead to quest-related steps.
-- A step is auxiliary if it contains only non-quest-related goals.
function Step:IsAuxiliary()
	--if self.isauxiliary~=nil then return self.isauxiliary end
	for i,goal in ipairs(self.goals) do
		if not goal:IsAuxiliary() then
			self.isauxiliary=false
			return false
		end
	end
	--else...
	--self.isauxiliary=true
	return true
end

function Step:IsObsolete()
	do return false end
	--if self.isobsolete then return self.isobsolete end
	local oneobsolete=false
	for i,goal in ipairs(self.goals) do
		if goal.action == "confirm" and goal.always == true then return false end
		local obsolete = goal:IsObsolete()
		local complete,possible = goal:IsComplete()
		if obsolete then oneobsolete=true end
		if not (obsolete or goal:IsAuxiliary() or complete or (not possible and ZGV.db.profile.skipimpossible)) then return false end
	end
	if not oneobsolete then return false end
	--else...
	--self.isobsolete=true  -- once obsolete, forever obsolete
	return true
end

--- Checks if the step has any use - if not, it can be safely skipped as long as it's followed by other skippable steps up to a completed step.
-- @return true if the step is useful, false if not.
function Step:IsAuxiliarySkippable()
	local i=self.num
	local guide = self.parentGuide
	local travelfor=self.travelfor
	local count=0
	local step=self
	--ZGV:Debug("Testing auxiliary "..i)
	while step do
		--ZGV:Debug("auxiliary "..i.."?")
		if step:IsAuxiliary() or not step:AreRequirementsMet() then
			--ZGV:Debug("skipping")
			-- keep skipping
		else
			if step==self then
				--ZGV:Debug("ret false")
				return false
			else
				local complete,possible = step:IsComplete()
				local wouldskip = (ZGV.db.profile.skipobsolete and step:IsObsolete())
					or complete
					or (ZGV.db.profile.skipimpossible and not possible)
				--ZGV:Debug("wouldskip "..tostring(wouldskip))
				--ZGV:Debug("travelfor "..tostring(travelfor))
				if wouldskip and travelfor then
					-- wait for more skippage
				else
					return wouldskip
				end
			end
		end

		i=i+1  -- jump over fellow auxiliaries
		step=guide.steps[i]
		if not step then
			-- next is not loaded! stop looking there, temporarily.
			--[[
			guide = ZGV:GetGuideByTitle(guide.next)
			if guide then  i=1  step=guide.steps[i]  end
			--]]
		end

		-- Check for multiple-step-ranging travel steps.
		if travelfor then
			count=count+1
			-- If we passed <travelfor> steps already and still found nothing to do, we can be skipped.
			if count>travelfor then return true end
		end
	end
	return false
end


function Step:GetTitle()
	if self.title then return self.title end
	for i,goal in ipairs(self.goals) do
		if goal.title then return goal.title end
		if goal.quest then return goal.quest.title end
	end
end

function Step:GetWayTitle()
	for i,goal in ipairs(self.goals) do
		if goal.title then return goal.title end
		if goal.npcid then return ZGV.Localizers:GetTranslatedNPC(goal.npcid) end
		if goal.quest then return goal.quest.title end
	end
	if self.title then return self.title end
end

function Step:OnEnter()
	ZGV:Debug("Step ".. self.num .." OnEnter")

	-- last call to tamper with the goals!
	-- remove temporaries
	local i=1
	while i<=#self.goals do
		local goal=self.goals[i]
		goal.sub_goto=nil
		goal.sub_talk=nil
		if goal.temporary then
			tremove(self.goals,i)
			i=i-1
		end
		i=i+1
	end
	self.needsreload = false

	if ZGV.autopause or ZGV.LastSkip<0 then
		local autoscripts
		for i,goal in ipairs(self.goals) do if goal.autoscript then autoscripts=true end end
		if autoscripts then
			local goal = 
				ZGV.GoalProto:New {
					num=#self.goals+1,
					action="text",
					--clickfun=function() ZGV:ReloadStep() end,
					text="(this step is automated)",
					parentStep=self,
					temporary=1
				}
			tinsert(self.goals,goal)
			self.needsreload = true
		end
	end

	for i,goal in ipairs(self.goals) do if goal.action=="fly" then
		if not goal.sub_goto then -- TODO how about when continents differ?
			local g

			g = ZGV.GoalProto:New {
				action="goto",
				parentStep=self,
				temporary=1
			}
			goal.sub_goto=g
			tinsert(self.goals,i,g)

			g = ZGV.GoalProto:New {
				action="talk",
				parentStep=self,
				temporary=1
			}
			goal.sub_talk=g
			tinsert(self.goals,i+1,g)

			ZGV:Debug("fly expanded")
		end
	end end
	-- end tampering

	for i=1,#self.goals do self.goals[i].num=i end


	-- all-passives get a "click" action.
	--[[
	local allpassive = true
	if self.needsreload then allpassive=false end -- these
	for i,goal in ipairs(self.goals) do
		if not goal.temporary and goal:GetStatus()~="passive" and goal:GetStatus()~="hidden" then allpassive=nil end
	end
	if allpassive and not (self==self.parentGuide.steps[#self.parentGuide.steps]) then
		local goal = 
			ZGV.GoalProto:New {
				num=#self.goals+1,
				action="click",
				parentStep=self,
				temporary=1
			}
		tinsert(self.goals,goal)
	end
	--]]

	-- run autoscripts and whatnot
	for i,goal in ipairs(self.goals) do
		goal:OnEnter()
	end
end

function Step:GetNext()
	for i,goal in ipairs(self.goals) do
		if goal.next and goal:IsVisible() and (not goal:IsCompleteable() or goal:IsComplete()) then
			ZGV:Debug("Next: goal["..i.."] \""..goal:GetText().."\" says \""..tostring(goal.next).."\"")
			return goal.next
		end
	end
	ZGV:Debug("Step:GetNext - step says "..tostring(self.next))
	return self.next or "+1"
end

function Step:GetJumpStepNum(jump,jump2)
	if not jump then jump=self:GetNext() end
	assert(jump,"jump to nowhere!")
	if type(jump)=="number" or jump:match("^%d+$") then
		return tonumber(jump) -- 123
	else
		local sign=jump:sub(1,1)  if sign=="+" or sign=="-" then jump=jump:sub(2) end
		if jump:match("^%d+$") then
			-- NOW it's numeric! step number delta
			jump=tonumber(jump) or 0
			return self.num + jump * (sign=="-" and -1 or 1) -- "-7","+7"
		elseif jump:match("[/\\]") then
			-- "folder\guide",5
			return jump2,jump
		else
			-- "label","+label","-label"

			local labs = self.parentGuide.steplabels and self.parentGuide.steplabels[jump]

			if not labs then return end

			local closest_back,closest_fore
			for i,num in ipairs(labs) do
				if num<self.num then closest_back=num end
				if num>self.num then closest_fore=num break end
			end
			if sign=="+" then
				return closest_fore  -- may be nil, so what.
			elseif sign=="-" then
				return closest_back  -- likewise.
			elseif not closest_fore or (closest_back and closest_fore and self.num-closest_back < closest_fore-self.num) then
				return closest_back
			else
				return closest_fore
			end
		end
	end
end

do	-- test GetJumpStepNum
	-- steps: a,b,a,c,d,a
	local guide = { steplabels={a={1,3,6},b={2},c={4},d={5}}, steps={ {},{},{},{},{},{} } }
	for n,step in ipairs(guide.steps) do step.num=n step.parentGuide=guide setmetatable(step,ZGV.StepProto_mt) end
	assert(guide.steps[1]:GetJumpStepNum("+2")==3)	--delta fore
	assert(guide.steps[3]:GetJumpStepNum("-1")==2)	--delta back
	assert(guide.steps[3]:GetJumpStepNum("5")==5)	--absolute
	assert(guide.steps[3]:GetJumpStepNum("c")==4)	--unique
	assert(guide.steps[3]:GetJumpStepNum("z")==nil)	--label fail
	assert(guide.steps[4]:GetJumpStepNum("+a")==6)	--fore
	assert(guide.steps[4]:GetJumpStepNum("+b")==nil)	--fore fail
	assert(guide.steps[4]:GetJumpStepNum("-a")==3)	--back
	assert(guide.steps[3]:GetJumpStepNum("-c")==nil)	--back fail
	assert(guide.steps[4]:GetJumpStepNum("a")==3)	--closest, find back
	assert(guide.steps[5]:GetJumpStepNum("a")==6)	--closest, find fore
end

function Step:GetJumpStep(jump,jump2)
	local step,guide = self:GetJumpStepNum(jump,jump2)
	if guide then return step,guide end  -- stepnum,guidename in case of a cross-guide jump.

	-- step is not validated, validate now
	if not step or step<1 then
		ZGV:Print("|cffff4400ERROR!|r Cannot jump from step |cffffff88"..self.num.."|r to label '|cffffff88"..tostring(jump).."|r'. This is guide |cffffff88"..self.parentGuide.title_short.."|r. Please report this, providing a generated Bug Report.")
		ZGV:Print("Meanwhile, try to navigate to the next step manually, by holding |cff55ff00CTRL+ALT|r and skipping the step.")
		return self
	end
	local steps = self.parentGuide.steps
	--step=min(step,#steps)
	return steps[step]
end
Step.Find = Step.GetJumpStep  -- alias

-- Return next step, including 'next' tags.
-- returns a step and nothing more. No guide jumps allowed.
-- Only returns nil when there is NO next step.
function Step:GetNextStep()
	local guide=self.parentGuide
	local step,g
	local snext = self:GetNext()
	if snext then
		-- special next tag
		step,g = self:GetJumpStep(snext)  -- always returns valid step
		assert(not g,"Cross-guide 'next' jumps are not allowed!")
		--assert(step,"No valid step found! Step number was ".. self.num ..", next was "..tostring(snext))
		return step
	else
		-- regular next step
		return guide.steps[self.num+1]
	end

	--local prevnum=num
	-- whatever we have, it has to be inside the guide. Valid or not.
	--if prevnum~=num then ZGV:Print("Step adjusted! Tried "..prevnum..", settled for "..num) end

	-- ZGV:Debug("step:GetNextStep, current ".. self.num .." next ".. tostring(step.num))

end

-- Only returns nil when there is NO next valid step.
function Step:GetNextValidStep()
	local step=self
	local numskips=1
	repeat
		step = step:GetNextStep()
		numskips=numskips+1
		assert(numskips<1000,"1000 skips and no valid next step found!")
	until not step or step:AreRequirementsMet() or ZGV.db.profile.showwrongsteps
	return step
end