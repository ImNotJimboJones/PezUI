local ZGV = ZygorGuidesViewer
if not ZGV then return end

local CV = {}
ZGV.CreatureViewer = CV
ZGV.CV = CV

tinsert(ZGV.startups,function(self)
	-- dummy data, if missing
	ZGV.NPCModels = ZGV.NPCModels or {}
	ZGV.NPCModelsExtra = ZGV.NPCModelsExtra or {}
	ZGV.ObjectModels = ZGV.ObjectModels or {}
	ZGV.ObjectModelsExtra = ZGV.ObjectModelsExtra or {}

	CV:CreateFrame()
	CV.Frame:Hide()
	--self:ScheduleRepeatingTimer("TryToDisplayCreature", 1)
end)

local CHAIN = ZGV.ChainCall

CV.models = {}
CV.currentmodelnum=1

-- To prevent the overflood of the client we have a temporary model storage
-- Model displaying sets the busy flag for a period of time (0.5 s)
-- If the next model display event fires while the flag is set, the request
-- is placed in a queue and displayed after cooldown
local delayedModel = { cargo = nil, timerHandle=nil, timerDelay=0.3 } -- busy condition is a non-null timer handle ~aprotas

local master=ZygorGuidesViewerFrameMasterCreatureViewer

--local tcopy = function(tab) local t2={}  for k,v in pairs(tab) do t2[k]=v end return t2 end
local last_step_shown
function ZGV:TryToDisplayCreature(force)
    if not self.Frame:IsShown() then return end 

	if not self.db.profile.mv_enabled or not self.CurrentStep then last_step_shown=nil CV:Hide() return end
	if (last_step_shown ~= self.CurrentStep) or force then
		ZGV:Debug("CreatureViewer: trying to show models")
		local models={}
		for i,goal in ipairs(self.CurrentStep.goals) do
			if goal.nomodels then
				-- skip
			elseif goal.model then
				local model,crop,objid
				if type(goal.model)=="number" then model,crop,objid=ZGV.ObjectModels[goal.model],ZGV.ObjectModelsExtra[goal.model],goal.model end
				local modeldata = {model=model,name=goal.target or goal.npc or goal.modelname,crop=crop,objid=objid}
				tinsert(models,modeldata)
			elseif goal.action=="click" and goal.targetid then
				local model,crop=ZGV.ObjectModels[goal.targetid],ZGV.ObjectModelsExtra[goal.targetid]
				local modeldata = {model=model,name=goal.target or goal.npc or goal.modelname,crop=crop,objid=goal.targetid}
				tinsert(models,modeldata)
			elseif goal.mobs then
				for j,mob in ipairs(goal.mobs) do
					if mob.id then
						tinsert(models,{displayinfo=ZGV.NPCModels[mob.id],creature=mob.id,name=mob.name,crop=ZGV.NPCModelsExtra[mob.id]})
					end
				end
			else
				local creature,displayinfo,name,crop,model
				creature = goal.npcid or goal.modelnpc or (goal.action=="kill" and goal.targetid)
				displayinfo = goal.displayinfo or ZGV.NPCModels[creature]
				crop = ZGV.NPCModelsExtra[creature]
				if not displayinfo then
					local objid = goal.action=="click" and goal.targetid
					model = ZGV.ObjectModels[objid]
					crop = ZGV.ObjectModelsExtra[objid]
				end
				name = goal.modelname or (creature and self.Localizers:GetTranslatedNPC(creature)) or goal.target or goal.npc
				if creature or displayinfo or model then
					tinsert(models,{displayinfo=displayinfo,creature=creature,model=model,name=name,crop=crop})
				end
			end
		end
		if #models>0 then
			CV:ShowModels(models)
		else
			CV:Hide()
		end
	end
	last_step_shown = self.CurrentStep
end

local elaps = 0
local facing = 0


local function Model_OnUpdate_Rotate(self,elapsed)
	if not ZGV.db.profile.mv_rotation then return end
	elaps=elaps+elapsed  if elaps<0.02 then return end  elaps=0
	if not self.model then return end
	if not self.model.facing then
		self.model.curfacing=(self.model.curfacing or 0)+elapsed*0.3
	end
	self:SetFacing(self.model.curfacing)
end

-- animation controller: modelviewer_main comes IN from the BACK. modelviewer_other slides AWAY from the FRONT.
local function Model_Cycle_OnPlay(self)
	CV.modelviewer_main:SetAlpha(0)
	CV.modelviewer_other:SetAlpha(CV.modelviewer_other.model and 1 or 0)
end

local function Model_Cycle_OnUpdate(self)
	local prog = self:GetSmoothProgress()*0.999 + 0.001
	local pror = 1-prog
	local progdir  = (prog-1) * CV.lastcycledir
	local progdir2 = prog * CV.lastcycledir
	local vm = CV.modelviewer_main
	local vo = CV.modelviewer_other
	if vm.model then
		vm:SetAlpha(prog<0.3 and 0 or prog)
		vm:SetPosition(vm.model.cx or 0,(vm.model.cy or 0) - progdir * 0.4,(vm.model.cz or 0)-0.1)
		vm:SetModelScale((vm.model.scale or 1)*(0.9+prog*0.1))-- * (vm.model and vm.model.scale or 1))
		if vm.model.cam then vm:SetCamera(vm.model.cam) end
	else
		vm:SetAlpha(0)
	end
	if vo.model then
		vo:SetAlpha((not vo.model or pror<0.3) and 0 or pror)
		vo:SetPosition(vo.model.cx or 0,(vo.model.cy or 0) - progdir2 * 0.4,(vo.model.cz or 0)-0.1)
		vo:SetModelScale((vo.model.scale or 1)*(0.9+pror*0.1))-- * (vo.model and vo.model.scale or 1))
		if vo.model.cam then vo:SetCamera(vo.model.cam) end
	else
		vo:SetAlpha(0)
	end
end

local function Model_Cycle_OnFinish(self)
	local vm = CV.modelviewer_main
	local vo = CV.modelviewer_other
end

local timer = 0
local function Slideshow_Timer()
	if not ZGV.db.profile.mv_slideshow then return end
	timer = timer + 1
	if timer<5 then return end
	timer=0
	if #CV.models>1 then
		CV:CycleCreature(1)
	end
end

local do_update_on_next_frame = nil
local faded_controls = {}
do
	local freq=1/10
	local elaps=0
	local mouseover=0
	local mouseout=0
	local mouseover_poptime=0.5
	local mouseout_poptime=0.5
	local mouse_is_over
	function CV.Frame_OnUpdate(frame,elapsed)
		if do_update_on_next_frame then
			CV.lastcycledir = ZGV.lastskip_rec or 1
			CV.Frame.model.cycle:Stop()
			CV.Frame.model.cycle:Play()
			CV:Update()
			do_update_on_next_frame = nil
		end
		elaps=elaps+elapsed
		if elaps>freq then
			local fin = function(fr)  UIFrameFadeIn(fr,0.1,fr:GetAlpha(), 1) end
			local fout = function(fr)  UIFrameFadeOut(fr,0.1,fr:GetAlpha(), 0) end

			if frame:IsMouseOver() then
				mouseover=mouseover+elaps
				if mouseover>=mouseover_poptime and not mouse_is_over then
					for f,fr in pairs(faded_controls) do fin(fr) end
					--frame.titlemover:Show()
					mouse_is_over=true
				end
				mouseout=0
			elseif not master.ismoving then
				mouseout=mouseout+elaps
				if mouseout>=mouseout_poptime and mouse_is_over then
					for f,fr in pairs(faded_controls) do fout(fr) end
					--frame.titlemover:Hide()
					--frame.sizer_sw:Hide()
					--frame.sizer_se:Hide()
					mouse_is_over=false
				end
				mouseover=0
			end
			elaps=0
		end
	end
end

function CV:CreateFrame()
	if CV.Frame then return end
	local name = "ZygorGuidesViewer_CreatureViewer"

	master:SetMinResize(80,100)

	CV.Frame = CHAIN(CreateFrame("FRAME",name,master))
		:SetSize(100,150)
		:SetBackdrop({bgFile=ZGV.DIR.."\\Skins\\white",edgeFile=ZGV.SkinDir.."border",tile = true, edgeSize=20, tileSize = 20, insets = { left = 20, right = 20, top = 20, bottom = 20 }})
		:SetBackdropColor(0,0,0,0.50)
		:SetBackdropBorderColor(0,0,0,1)
		:SetResizable(true)
		:SetMovable(true)
		:SetScript("OnUpdate",self.Frame_OnUpdate)
		:SetAllPoints()
		.__END

	CV.Frame.sizer_sw = CHAIN(CreateFrame("Button",name.."_SizerSW",CV.Frame))
		:SetSize(20,20)
		:EnableMouse(true)
		:SetPoint("BOTTOMLEFT",CV.Frame,"BOTTOMLEFT",3,3)
		 :RegisterForDrag("LeftButton")
		 :SetScript("OnDragStart",function() master.ismoving=true master:StartSizing("BOTTOMLEFT") end)
		 :SetScript("OnDragStop",function() master.ismoving=nil master:StopMovingOrSizing() end)
		:SetBackdrop({bgFile = ZGV.SkinDir.."corner",edgeSize = 0,tileSize=20,tile=false})
		:SetBackdropColor(0,0,0,1)
		:SetAlpha(0)
		.__END

	CV.Frame.sizer_se = CHAIN(CreateFrame("Button",name.."_SizerSE",CV.Frame))
		:SetSize(20,20)
		:EnableMouse(true)
		:SetPoint("BOTTOMRIGHT",CV.Frame,"BOTTOMRIGHT",-3,3)
		 :RegisterForDrag("LeftButton")
		 :SetScript("OnDragStart",function() master.ismoving=true master:StartSizing("BOTTOMRIGHT") end)
		 :SetScript("OnDragStop",function() master.ismoving=nil master:StopMovingOrSizing() end)
		:SetBackdrop({bgFile = ZGV.SkinDir.."corner",edgeSize = 0,tileSize=20,tile=false})
		:SetBackdropColor(0,0,0,1)
		:SetAlpha(0)
		.__END
	CV.Frame.sizer_se:GetRegions():SetTexCoord(1,0,0,1)

	--[[
	CV.Frame.sizer_se:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",edgeSize = 0,tileSize=128,tile=true,insets={top=upsideup and 20 or 0,right=0,left=0,bottom=upsideup and 0 or 0}})
	CV.Frame.sizer_se:SetBackdropColor(1,1,1,1)
	CV.Frame.sizer_sw:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",edgeSize = 0,tileSize=128,tile=true,insets={top=upsideup and 20 or 0,right=0,left=0,bottom=upsideup and 0 or 0}})
	CV.Frame.sizer_sw:SetBackdropColor(1,1,1,1)
	--]]
	--CV.Frame:EnableMouse(true)


	CV.Frame.model = CHAIN(CreateFrame("PlayerModel",name.."_model",CV.Frame))
		:SetPoint("TOPLEFT",CV.Frame,"TOPLEFT",3,-3)
		:SetPoint("BOTTOMRIGHT",CV.Frame,"BOTTOMRIGHT",-3,3)
		:SetScript("OnUpdate",Model_OnUpdate_Rotate)
		--:SetFrameLevel(12)
		.__END
	CV.Frame.model.cycle = CV.Frame.model:CreateAnimationGroup()
	CHAIN(CV.Frame.model.cycle:CreateAnimation("ANIMATION")) :SetSmoothing("OUT") :SetDuration(0.3)
		:SetScript("OnPlay",Model_Cycle_OnPlay)
		:SetScript("OnUpdate",Model_Cycle_OnUpdate)
	
	CV.Frame.model2 = CHAIN(CreateFrame("PlayerModel",name.."_model2",CV.Frame))
		:SetPoint("TOPLEFT",CV.Frame,"TOPLEFT",3,-3)
		:SetPoint("BOTTOMRIGHT",CV.Frame,"BOTTOMRIGHT",-3,3)
		:SetScript("OnUpdate",Model_OnUpdate_Rotate)
		--:SetFrameLevel(13)
		.__END

	self.modelviewer_main,self.modelviewer_other = self.Frame.model,self.Frame.model2
	
	CV.Frame.close = CHAIN(CreateFrame("Button",name.."_Close",CV.Frame,"UIPanelCloseButton"))
		:SetSize(20,20)
		:SetPoint("TOPRIGHT",CV.Frame,"TOPRIGHT",-5,-5)
		:SetScript("OnClick",function() ZGV:SetOption("ModelViewer","mv_enabled") end)
		:SetAlpha(0) :Hide()
		.__END

	CV.Frame.boo = CHAIN(CreateFrame("Frame",nil,CV.Frame))
		--:SetFrameStrata("HIGH")
		:SetAllPoints()
		.__END

	CV.Frame.title = CHAIN(CV.Frame.boo:CreateFontString(CV.Frame:GetName().."_Title","ARTWORK","GameFontNormalSmall"))
		:SetSize(300,30)
		:SetPoint("BOTTOMLEFT",CV.Frame.boo,"BOTTOMLEFT",4,4)
		:SetPoint("BOTTOMRIGHT",CV.Frame.boo,"BOTTOMRIGHT",-4,4)
		:SetWordWrap(true)
		:SetJustifyH("CENTER") :SetJustifyV("BOTTOM")
		:SetDrawLayer("OVERLAY")
		.__END

	CV.Frame.nofn = CHAIN(CreateFrame("Frame",nil,CV.Frame.boo))
		:SetSize(1,15)
		:SetPoint("BOTTOMLEFT",CV.Frame,"BOTTOMLEFT",5,CV.Frame.title:GetHeight())
		:SetPoint("BOTTOMRIGHT",CV.Frame,"BOTTOMRIGHT",-5,CV.Frame.title:GetHeight())
		.__END

	CV.Frame.nofn.label = CHAIN(CV.Frame.nofn:CreateFontString(CV.Frame:GetName().."_Title","ARTWORK","GameFontNormalSmall"))
		:SetSize(0,15)
		:SetPoint("TOPLEFT",CV.Frame.nofn,"TOPLEFT",15,0)
		:SetPoint("BOTTOMRIGHT",CV.Frame.nofn,"BOTTOMRIGHT",-15,0)
		:SetJustifyH("CENTER") :SetJustifyV("BOTTOM")
		.__END

	--[[
	CV.Frame.nofn.prev = CHAIN(CreateFrame("Button",name.."_Prev",CV.Frame.nofn,"UIPanelButtonTemplate"))
		:SetSize(15,15)
		:SetPoint("LEFT",CV.Frame.nofn,"LEFT")
		:SetScript("OnClick",function() CV:CycleCreature(-1) end)
		:SetAlpha(0)
		--:SetText("<")
		.__END

	CV.Frame.nofn.next = CHAIN(CreateFrame("Button",name.."_Next",CV.Frame.nofn,"UIPanelButtonTemplate"))
		:SetSize(15,15)
		:SetPoint("RIGHT",CV.Frame.nofn,"RIGHT")
		:SetScript("OnClick",function() CV:CycleCreature(1) end)
		:SetAlpha(0)
		--:SetText(">")
		.__END
	--]]

	CV.Frame.nofn.prev = CHAIN(CreateFrame("Button",name.."_Prev",CV.Frame.nofn))
		:SetSize(50,50)
		:SetPoint("LEFT",CV.Frame,"LEFT",5,0)
		:SetScript("OnClick",function() CV:CycleCreature(-1) end)
		:SetAlpha(0)
		:SetNormalTexture(ZGV.SkinDir.."mv-arrow")
		--:SetText("<")
		.__END

	CV.Frame.nofn.next = CHAIN(CreateFrame("Button",name.."_Next",CV.Frame.nofn))
		:SetSize(50,50)
		:SetPoint("RIGHT",CV.Frame,"RIGHT",-5,0)
		:SetScript("OnClick",function() CV:CycleCreature(1) end)
		:SetAlpha(0)
		:SetNormalTexture(ZGV.SkinDir.."mv-arrow")
		--:SetText(">")
		.__END
	CV.Frame.nofn.next:GetNormalTexture():SetTexCoord(1,0,0,1)

	--AssignButtonTexture(CV.Frame.nofn.prev,ZGV.SkinDir.."titlebuttons",9,16)
	--AssignButtonTexture(CV.Frame.nofn.next,ZGV.SkinDir.."titlebuttons",10,16)

	if ZGV.db.profile.debug then
		-- create model adjustment buttons
		local DoCrop = function()
			ZGV.CV.currentmodel.crop=ZGV.CV.currentmodel.crop or {}  
		end
		CV.Frame.cx = CHAIN(CreateFrame("Button",name.."_d_cx",CV.Frame,"UIPanelButtonTemplate"))
			:SetPoint("TOPLEFT",CV.Frame,"BOTTOMLEFT")  :SetSize(15,15)  :SetText("x")
			--:RegisterForClicks("AnyDown")
			--:SetScript("OnClick",		function(self,but) ZGV.CV.currentmodel.crop.cx = (ZGV.CV.currentmodel.crop.cx or 0) + (but=="LeftButton" and -0.2 or 0.2) * (IsShiftKeyDown() and 0.2 or 1) ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			:SetScript("OnMousewheel",	function(self,del) DoCrop()  ZGV.CV.currentmodel.crop.cx = (ZGV.CV.currentmodel.crop.cx or 0) + del*0.2 * (IsShiftKeyDown() and 0.05 or 1) ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			.__END
		CV.Frame.cy = CHAIN(CreateFrame("Button",name.."_d_cy",CV.Frame,"UIPanelButtonTemplate"))
			:SetPoint("TOPLEFT",CV.Frame.cx,"TOPRIGHT")  :SetSize(15,15)  :SetText("y")
			--:RegisterForClicks("AnyDown")
			--:SetScript("OnClick",		function(self,but) ZGV.CV.currentmodel.crop.cy = (ZGV.CV.currentmodel.crop.cy or 0) + (but=="LeftButton" and -0.2 or 0.2) * (IsShiftKeyDown() and 0.2 or 1) ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			:SetScript("OnMousewheel",	function(self,del) DoCrop()  ZGV.CV.currentmodel.crop.cy = (ZGV.CV.currentmodel.crop.cy or 0) + del*0.2 * (IsShiftKeyDown() and 0.05 or 1) ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			.__END
		CV.Frame.cz = CHAIN(CreateFrame("Button",name.."_d_cz",CV.Frame,"UIPanelButtonTemplate"))
			:SetPoint("TOPLEFT",CV.Frame.cy,"TOPRIGHT")  :SetSize(15,15)  :SetText("z")
			--:RegisterForClicks("AnyDown")
			--:SetScript("OnClick",		function(self,but) ZGV.CV.currentmodel.crop.cz = (ZGV.CV.currentmodel.crop.cz or 0) + (but=="LeftButton" and -0.2 or 0.2) * (IsShiftKeyDown() and 0.2 or 1) ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			:SetScript("OnMousewheel",	function(self,del) DoCrop()  ZGV.CV.currentmodel.crop.cz = (ZGV.CV.currentmodel.crop.cz or 0) + del*0.2 * (IsShiftKeyDown() and 0.05 or 1) ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			.__END
		CV.Frame.cs = CHAIN(CreateFrame("Button",name.."_d_cs",CV.Frame,"UIPanelButtonTemplate"))
			:SetPoint("TOPLEFT",CV.Frame.cz,"TOPRIGHT")  :SetSize(15,15)  :SetText("s")
			--:RegisterForClicks("AnyDown")
			--:SetScript("OnClick",		function(self,but) ZGV.CV.currentmodel.crop.scale = (ZGV.CV.currentmodel.crop.scale or 0) + (but=="LeftButton" and -0.1 or 0.1) ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			:SetScript("OnMousewheel",	function(self,del) DoCrop()  ZGV.CV.currentmodel.crop.camscale = (ZGV.CV.currentmodel.crop.camscale or 1) + del*0.1*(IsShiftKeyDown() and 0.05 or 1)   ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			.__END
		CV.Frame.cS = CHAIN(CreateFrame("Button",name.."_d_cS",CV.Frame,"UIPanelButtonTemplate"))
			:SetPoint("TOPLEFT",CV.Frame.cs,"TOPRIGHT")  :SetSize(15,15)  :SetText("S")
			--:RegisterForClicks("AnyDown")
			--:SetScript("OnClick",		function(self,but) ZGV.CV.currentmodel.crop.scale = (ZGV.CV.currentmodel.crop.scale or 0) + (but=="LeftButton" and -0.1 or 0.1) ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			:SetScript("OnMousewheel",	function(self,del) DoCrop()  ZGV.CV.currentmodel.crop.scale = (ZGV.CV.currentmodel.crop.scale or 1) + del*0.1*(IsShiftKeyDown() and 0.05 or 1)   ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			.__END
		CV.Frame.cr = CHAIN(CreateFrame("Button",name.."_d_cr",CV.Frame,"UIPanelButtonTemplate"))
			:SetPoint("TOPLEFT",CV.Frame.cS,"TOPRIGHT")  :SetSize(15,15)  :SetText("r")
			--:RegisterForClicks("AnyDown")
			--:SetScript("OnClick",		function(self,but) ZGV.CV.currentmodel.crop.facing = (ZGV.CV.currentmodel.crop.facing or 0) + (but=="LeftButton" and -5 or 5) ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			:SetScript("OnMousewheel",	function(self,del) DoCrop()  ZGV.CV.currentmodel.crop.facing = (ZGV.CV.currentmodel.crop.facing or 0) + del*5  ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			.__END
		CV.Frame.cc = CHAIN(CreateFrame("Button",name.."_d_cc",CV.Frame,"UIPanelButtonTemplate"))
			:SetPoint("TOPLEFT",CV.Frame.cr,"TOPRIGHT")  :SetSize(15,15)  :SetText("c")
			--:RegisterForClicks("AnyDown")
			--:SetScript("OnClick",		function(self,but) ZGV.CV.currentmodel.crop.facing = (ZGV.CV.currentmodel.crop.facing or 0) + (but=="LeftButton" and -5 or 5) ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			:SetScript("OnMousewheel",	function(self,del) DoCrop()  ZGV.CV.currentmodel.crop.cam = (ZGV.CV.currentmodel.crop.cam or 0) + del*1  if ZGV.CV.currentmodel.crop.cam==-1 then ZGV.CV.currentmodel.crop.cam=nil end  ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			.__END
		CV.Frame.cZ = CHAIN(CreateFrame("Button",name.."_d_cZ",CV.Frame,"UIPanelButtonTemplate"))
			:SetPoint("TOPLEFT",CV.Frame.cc,"TOPRIGHT")  :SetSize(15,15)  :SetText("Z")
			--:RegisterForClicks("AnyDown")
			--:SetScript("OnClick",		function(self,but) ZGV.CV.currentmodel.crop.facing = (ZGV.CV.currentmodel.crop.facing or 0) + (but=="LeftButton" and -5 or 5) ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			:SetScript("OnMousewheel",	function(self,del) DoCrop()  ZGV.CV.currentmodel.crop.portrait = (ZGV.CV.currentmodel.crop.portrait or 0) + del*0.1  ZGV.CV:Update() ZGV.CV:DumpModelSettings() end)
			.__END
	end

	--CV.Frame.titleregion = CHAIN(CV.Frame:CreateTitleRegion()) :RegisterForDrag("LeftButton") :SetScript("OnDragStart",function() CV.Frame:StartDragging() end) :SetScript("OnDragStop",function() CV.Frame:StopMovingOrSizing() end) .__END
	CV.Frame.titlemover = CHAIN(CreateFrame("Frame",nil,CV.Frame))
		:EnableMouse(true)
		:SetPoint("TOPLEFT",CV.Frame) :SetPoint("TOPRIGHT",CV.Frame,"TOPRIGHT",-25,0) :SetHeight(40)
		:Show()
		 :RegisterForDrag("LeftButton")
		 :SetScript("OnDragStart",function(self) master.ismoving=true master:StartMoving() end)
		 :SetScript("OnDragStop",function(self) master.ismoving=nil master:StopMovingOrSizing() end)
		:SetAlpha(0)
		.__END

	faded_controls = {CV.Frame.close,CV.Frame.sizer_sw,CV.Frame.sizer_se,CV.Frame.nofn.next,CV.Frame.nofn.prev}

	--master:SetScript("OnDragStop",function() print("m_ondragstop") master:SetFrameStrata("MEDIUM") master:StopMovingOrSizing() end)


	

	AssignButtonTexture(CV.Frame.close,ZGV.SkinDir.."titlebuttons",6,16)

	self.slideshowtimer = ZGV:ScheduleRepeatingTimer(Slideshow_Timer, 1)

	--CV:AlignFrame()
end

function CV:DumpModelSettings()
	local m=ZGV.CV.currentmodel
	if not m then return end
	m.crop = m.crop or {}
	--DEFAULT_CHAT_FRAME:AddMessage(("cx=%.1f,cy=%.1f,cz=%.1f,scale=%.1f,facing=%d"):format(m.cx,m.cy,m.cz,m.scale,m.facing))
	local s
	if m.creature then
		s=("[%05d]={"):format(m.creature)
		ChatFrame1:AddMessage("Put in NPCModelsExtra.lua:")
	elseif m.model and m.objid then
		s=("[%05d]={"):format(m.objid)
		ChatFrame1:AddMessage("Put in ObjectModelsExtra.lua:")
	else
		ChatFrame1:AddMessage("No creature and no model/objid known, wtf?")
	end
	if m.crop.cx and m.crop.cx~=0 then s=s..("cx=%.2f,"):format(m.crop.cx) end
	if m.crop.cy and m.crop.cy~=0 then s=s..("cy=%.2f,"):format(m.crop.cy) end
	if m.crop.cz and m.crop.cz~=0 then s=s..("cz=%.2f,"):format(m.crop.cz) end
	if m.crop.facing then s=s..("facing=%d,"):format(m.crop.facing) end
	if m.crop.cam then s=s..("cam=%d,"):format(m.crop.cam) end
	if m.crop.camscale and m.crop.camscale~=1 then s=s..("camscale=%.2f,"):format(m.crop.camscale) end
	if m.crop.scale and m.crop.scale~=1 then s=s..("scale=%.2f,"):format(m.crop.scale) end
	if m.crop.portrait and m.crop.portrait>0 then s=s..("portrait=%.2f,"):format(m.crop.portrait) end
	s=s:sub(1,-2).."},"
	ChatFrame1:AddMessage(s)
	ChatFrame1EditBox:SetText(s)
	ChatFrame1EditBox:Show()
	ChatFrame1EditBox:SetFocus()
	ChatFrame1EditBox:HighlightText()
	timer=-10
end

function CV:AlignFrame()
	do return end
	if ZGV.Frame.Border:GetAlpha()>0.01 then
		CV.Frame:SetPoint("TOPRIGHT",ZGV.Frame,"TOPLEFT")
	else
		CV.Frame:SetPoint("TOPRIGHT",ZGV.Frame.Border.Guides,"TOPLEFT",4,-22)
	end
end

function CV:ShowCreature(id,name)
	self:ShowModels({{creature=id,name=name}})
end

local function RefreshModelOverflowTimer()
	-- If we have a previous timer running, then stop it
	if delayedModel.timerHandle then
		ZGV:CancelTimer(delayedModel.timerHandle,true)
		delayedModel.timerHandle=nil
	end
	-- Setting a timer to clear the flag and put a next model if applicable
	delayedModel.timerHandle=ZGV:ScheduleTimer(function()
		delayedModel.timerHandle=nil
		if delayedModel.cargo then
			CV:ShowModels(delayedModel.cargo)
			delayedModel.cargo = nil
			ZGV:Debug("Burst model load end, it's safe to display the last delayed model.")
		end
	end,delayedModel.timerDelay)
end

function CV:Hide(domestic) -- the option is only set for a call inside ShowModels not to fall into recursion
	if not self.Frame then return end
	self.Frame:Hide()
	self.Frame.model.cycle:Stop()
	self.modelviewer_main.model=nil
	self.modelviewer_other.model=nil
	self.current_creature=nil
	self.models = {}
	self.last_step_shown = nil
	delayedModel.cargo = nil
	-- If this is called inside a timer proc, we "queue" a null model,
	-- However we don't refresh the timer, there's no need at all to do this
	if delayedModel.timerHandle and not domestic then
		ZGV:Debug("Somebody's trying to hide the viewer while the display is on cooldown, queuing null model")
		delayedModel.cargo={}
		RefreshModelOverflowTimer()
	end
end

function CV:ShowModels(models)
	if not delayedModel.timerHandle then
		if models and #models>0 then
			self.Frame:Show()
			self.models = models
			self.currentmodelnum = 1
			timer=0
			--self.modelviewer_main,self.modelviewer_other = self.Frame.model,self.Frame.model2
			--self.modelviewer_other:Hide()

			self.modelviewer_main,self.modelviewer_other = self.modelviewer_other,self.modelviewer_main  -- swappity swap

			-- Here comes the crazy part. If the models were JUST shown, they might... ignore their SetModels in the Update. So, retry in the next frame!
			do_update_on_next_frame = true
		else
			self:Hide(true)
		end
		-- Timer is set outside of this block as long as else branch refreshes it as well
	else
		delayedModel.cargo=models -- Any previous model pack is overwritten
		ZGV:Debug("ShowModels called inside a cooldown, delaying model load, refreshing the timer.")
	end
	RefreshModelOverflowTimer()
end

function CV:Test()
	self:ShowModels({
		{model="World\\Expansion03\\doodads\\worgen\\items\\worgen_door_01.m2",scale=0.6,cx=0,cy=1.5,cz=1.2,facing=0,name="Door"},
		{creature=43258,name="Lava Dude"},
		{displayinfo=400,name="Whelp"}
	})
end

function CV:CycleCreature(delta)
	self.prevmodelnum = self.currentmodelnum
	self.currentmodelnum = self.currentmodelnum + delta
	if self.currentmodelnum>#self.models then self.currentmodelnum=1 end
	if self.currentmodelnum<1 then self.currentmodelnum=#self.models end
	
	self.lastcycledir = delta

	if #self.models>1 then
		self.modelviewer_main,self.modelviewer_other = self.modelviewer_other,self.modelviewer_main  -- swappity swap
		self.Frame.model.cycle:Stop()
		self.Frame.model.cycle:Play()
	end

	timer = GetMouseButtonClicked() and -5 or 0  -- on click, set timer to negative to force a longer delay.

	self:Update()

end

function CV:Update()
	-- Well, sometimes we're trying to be being shown while the main window is hidden
	-- Sample case: startup with profile.visible set to false. Let's not show the window itself
	-- but still do the load and stuff

	-- How about NOT doing that? Let's load when showing, and re-load when re-showing.
	--[[
	if ZGV.db.profile.visible then
		self.Frame:Show()
	else
		self.Frame:Hide()
	end
	--]]
	if not ZGV.Frame:IsShown() then ZGV:Debug("CV:Update skipped") return end

	local viewer = self.modelviewer_main

	local model = self.models[self.currentmodelnum]

	--ZGV:Debug("CV:Update - model " .. (model and (model.model or model.displayinfo or model.creature or "?") or "nil"))

	if not model then
		viewer:Hide()
		self.modelviewer_other:Hide()
		print("!! no model, hiding")
		return
	end

	viewer:Show()
	viewer:ClearModel()

	viewer.model = model
	self.currentmodel = model

	if model.crop then  for md,mdv in pairs(model.crop) do model[md]=mdv end  end

	if model.model then
		-- safe to set, model will load always
		if type(model.model)=="number" then model.model=ZGV.ObjectModels[model.model] end
		viewer:SetModel(model.model)
		self.current_creature = nil
		viewer.failed=false
		ZGV:Debug("showing MODEL "..model.model)
	elseif model.displayinfo then 
		-- also safe, displayinfo mobs always load
		viewer:SetDisplayInfo(model.displayinfo)
		self.current_creature = nil
		viewer.failed=false
		ZGV:Debug("showing DINFO "..model.displayinfo.." in "..viewer:GetName())
	elseif model.creature then
		-- uh-oh, this one is nasty; creature might not be in cache!
		if (self.current_creature~=model.creature) then
			--viewer:ClearModel()
			viewer:SetCreature(model.creature)
			ZGV:Debug("showing CREATURE "..model.creature.." - why don't we have its MODEL?")
		end
		local model_check = viewer:GetModel()
		if type(model_check)=="string" then
			-- yay, it's visible!
			self.current_creature = model.creature
			viewer.failed=false
		else
			--viewer:ClearModel()
			viewer.failed=true
			ZGV:Debug("showing CREATURE failed.")
		end
	end
	viewer:SetModelScale(model.scale and max(model.scale,0.01) or 1.01)
	viewer:SetPosition(model.cx or 0,model.cy or 0,(model.cz or 0)-0.1)
	model.curfacing = (model.facing or 0) / 57.30

	if model.cam then viewer:SetCamera(model.cam) else 	viewer:RefreshCamera() end
	viewer:SetCamDistanceScale(model.camscale and max(model.camscale,0.01) or 1.01)
	if model.portrait and model.portrait>0 then viewer:SetPortraitZoom(model.portrait) end

	self.Frame.title:SetText(model.name)

	self:AlignFrame()

	if #self.models>1 then
		self.Frame.nofn:Show()
		self.Frame.nofn.label:SetText(("|cff998866%d/%d"):format(self.currentmodelnum,#self.models))
	else
		self.Frame.nofn:Hide()
	end
end
