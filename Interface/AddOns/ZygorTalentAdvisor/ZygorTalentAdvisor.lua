--[[
Rule: on every talent purchase, figure out in how many talents the player can get back on track
by comparing his prospective build to subbuilds of order 1..n

Don't warn if the distance is less than their REMAINING talents after the purchase-to-be
--]]

SAFEMODE=false

local addonName,ZygorTalentAdvisor = ...

ZygorTalentAdvisor = LibStub("AceAddon-3.0"):NewAddon(ZygorTalentAdvisor,addonName, "AceConsole-3.0","AceEvent-3.0","AceTimer-3.0")
ZTA = ZygorTalentAdvisor
local ZTA=ZTA

-- export globals
_G.ZygorTalentAdvisor = ZygorTalentAdvisor
_G.ZTA = ZTA

--me.revision = tonumber(string.sub("$Revision: 309 $", 12, -3))
--me.version = "3.2." .. ZTA.revision
--ZTA.date = string.sub("$Date: 2009-07-29 23:26:27 +0200 (Śr, 29 lip 2009) $", 8, 17)


ZTA.registeredBuilds = {}

ZTA.L = ZygorTalentAdvisor_L("main")
local L = ZTA.L

local framename = "ZygorTalentAdvisorFrame"

--local LibTutorial = LibStub("LibTutorial-1.0")
local LibDebugLog = LibStub("LibDebugLog-1.0")

BINDING_HEADER_ZYGORTALENTADVISOR = L["name_plain"]
BINDING_NAME_ZYGORTALENTADVISOR_OPENPOPUP = L["binding_popout"]

ZTA.currentBuild = {}

SetCVar("previewTalentsOption",1)

local MAX_NOT_BM_PET_TALENTS = 17

function ZTA:OnInitialize()
	self:SetupConfig()

	LibDebugLog:RegisterAddon(self,self.db.profile)
end

function ZTA:OnEnable()
	-- force loading of talent UI. Otherwise talents won't be available.
	TalentFrame_LoadUI()
	PlayerTalentFrame:Show()
	PlayerTalentFrame:Hide()

--	hooksecurefunc("TalentFrame_Load",MrRipley_LinkToTalentsFrame)
	hooksecurefunc("ToggleTalentFrame",function()
		--if not PlayerTalentFrame:IsShown() then return end
		self:Debug("ToggleTalentFrame hook called")
		self:UpdateAllBuilds()
		self:PlayTalented()
		ZygorTalentAdvisorPopout_Update()
	end)
	TalentMicroButton:HookScript("OnClick",function()
		--if not PlayerTalentFrame:IsShown() then return end
		self:Debug("TalentMicroButton hook called")
		self:UpdateAllBuilds()
		self:PlayTalented()
		ZygorTalentAdvisorPopout_Update()
	end)

	hooksecurefunc("ResetGroupPreviewTalentPoints",function()
		if PlayerTalentFrame then
			--self:UpdateSuggestions(PlayerTalentFrame.pet)
			self:UpdateAllBuilds()
			self:PlayTalented()
			ZygorTalentAdvisorPopout_Update()
		end
	end)

	--[[
	if GetTalentInfo(1,1) then
		self:DelayedRegisteredBuilds()
	end
	--]]

	self:RegisterEvents()

	do ------------ create static popups for warnings
	 StaticPopupDialogs['ZYGORTALENTADVISOR_WARNING'] = {
		text = "",
		button1 = YES,
		button2 = NO,
		OnAccept = function (self) if SAFEMODE then self:Debug("learning "..data.tab..","..data.talent) return nil end  Old_LearnTalent(self.data.tab,self.data.talent,self.data.pet) end,
		OnCancel = function (self) end,
		OnHide = function (self) self.data = nil; self.selectedIcon = nil; end,
		hideOnEscape = 1,
		timeout = 0,
		whileDead = 1,
	 }

	 StaticPopupDialogs['ZYGORTALENTADVISOR_PREVIEWWARNING'] = {
		text = "",
		button1 = YES,
		button2 = NO,
		OnAccept = function (self) if SAFEMODE then self:Debug("learning previewed") return nil end  LearnPreviewTalents(self.data.pet) end,
		OnCancel = function (self) end,
		OnHide = function (self) self.data = nil; self.selectedIcon = nil; end,
		hideOnEscape = 1,
		timeout = 0,
		whileDead = 1,
	 }
	 --[[
	 StaticPopupDialogs['ZYGORTALENTADVISOR_CONFIRM_LEARN_PREVIEW_TALENTS'] = {
		text = CONFIRM_LEARN_PREVIEW_TALENTS,
		button1 = YES,
		button2 = NO,
		OnAccept = function (self)
			LearnPreviewTalents(ZygorTalentAdvisor.Window.pet)
		end,
		OnCancel = function (self) end,
		hideOnEscape = 1,
		timeout = 0,
		exclusive = 1,
	 }
	 StaticPopupDialogs['ZYGORTALENTADVISOR_CONFIRMBULKLEARNING'] = {
		text = "...",
		button1 = YES,
		button2 = NO,
		OnAccept = function (self)
			ZTA:LearnSuggestedTalents(self.data.pet)
		end,
		OnCancel = function (self) end,
		hideOnEscape = 1,
		timeout = 0,
		exclusive = 1,
	 }
	 --]]
	end

	if LibTutorial then
		LibTutorial:AddTutorial("ZTA1",L['tutorial_ZTA1_title'],L['tutorial_ZTA1_text'],self.db.global.tutorialflags)
		LibTutorial:AddTutorial("ZTA2",L['tutorial_ZTA2_title'],L['tutorial_ZTA2_text'],self.db.global.tutorialflags)
		LibTutorial:AddTutorial("ZTA3",L['tutorial_ZTA3_title'],L['tutorial_ZTA3_text'],self.db.global.tutorialflags)

		if UnitLevel("player")>10 then LibTutorial:ShowTutorial("ZTA1") end
	end

	self._DebugLog.entries = self.db.char.debuglog
	self:DebugLogAdd("Viewer started. ---------------------------")

	self.popout = ZygorTalentAdvisorPopout

	--if PlayerTalentFrame and not PlayerTalentFrame.selectedPlayerSpec then PlayerTalentFrame.selectedPlayerSpec="spec1" end -- FIX BLIZZARD CRAP
	--if PlayerTalentFrame and not PlayerTalentFrame.selectedPlayerSpec then PlayerTalentFrame.selectedPlayerSpec="spec1" end -- FIX BLIZZARD CRAP
end

-- Checks if player's pet is newly tamed. Such pets need to be respawned to get a proper ID.
function ZTA:IsPetNew()
	return (UnitGUID("pet") or "_"):sub(5,5)=="3"
end

-- Generate a unique pet build ID - combined from the pet's own ID and the player's spec number.
function ZTA:GetPetID()
	if self:IsPetNew() then return "_" end
	return (UnitGUID("pet") or "_"):sub(6,12) .. "_".. GetActiveTalentGroup()
end

--- (Re)Load selected builds.
function ZTA:LoadBuilds(pet)
	self:DebugPush("Loading builds: "..((pet==true and "PET") or (pet==false and "PLAYER") or "BOTH"))
	self:PruneRegisteredBuilds()
	if (pet==false or pet==nil) then self:SetCurrentBuild(self.db.char.currentBuildKey[GetActiveTalentGroup()],false) end
	if (pet==true or pet==nil) then self:SetCurrentBuild(self.db.char.currentPetBuildKey[self:GetPetID()],true) end
	self:DebugPop()
end




local function who(pet)  return pet and 'pet' or 'player'  end



function ZTA:SetupConfig()
	self.db = LibStub("AceDB-3.0"):New("ZygorTalentAdvisorSettings")

	--InterfaceOptionsFrame:GetRegions():SetTexture(0,0,0,0.9)

	self.db:RegisterDefaults({
		char = {
			debuglog = {},
			-- KW
			currentBuildKey = {
				[1] = "_",
				[2] = "_",
			},
			currentPetBuildKey = {
			},
			-- KW
		},
		global = {
			tutorialflags = {}
		},
		profile = {
			debug = false,
			forcebuild = false,
			forcepetbuild = false,
			hints = true,
			preview = true,
			popup = 1,
			windowdocked = true,
		}
	})

	-- convert
	if (type(self.db.char.currentBuildKey) == "string") then
		local _key = self.db.char.currentBuildKey
		self.db.char.currentBuildKey = {
			[1] = GetActiveTalentGroup()==1 and _key or "_",
			[2] = GetActiveTalentGroup()==2 and _key or "_",
		}
	end
	if (type(self.db.char.currentPetBuildKey) == "string") then
		self.db.char.currentPetBuildKey = {}
	end
	self.db.char.currentPetBuildKey["_"]="_"  -- for unknown/new pets

	-- rig builds to return "_" for unknown entries
	setmetatable(self.db.char.currentBuildKey,{__index=function(k) return "_" end })
	setmetatable(self.db.char.currentPetBuildKey,{__index=function(k) return "_" end })

	local Getter_Simple = function(info)
		return self.db.profile[info[#info]]
	end
	local Setter_Simple = function(info,value)
		self.db.profile[info[#info]] = value
	end

	self.optiontables = {}
	self.optiontables.main = {
		name = L['name'],
		desc = L['desc'],
		type = "group",
		order = 1,
		--hidden = true,
		handler = self,
		get = Getter_Simple,
		set = Setter_Simple,
		args = {
			desc = {
				order = 1,
				type = "description",
				name = L['desc'],
			},
			desc01 = {
				type = "header",
				name = function() return ((GetNumTalentGroups(false,false)==1) and L['opt_build_header'])
						      or (GetActiveTalentGroup(false,false)==1 and L['opt_build_header_pri'])
						      or (GetActiveTalentGroup(false,false)==2 and L['opt_build_header_sec'])
						      or L['opt_build_header'] end,
				order = 1.01,
			},
			build = { ------------------- BUILD --------------------
				name = L['opt_build'],
				desc = L['opt_build_desc'],
				type = "select",
				values = function()
					   local t={["_"]=L['opt_build_none']}
					   if not next(self.registeredBuilds) then return t end
					   local k,v
					   local _,playerclass=UnitClass("player")
					   for k,v in pairs(self.registeredBuilds) do if v.class and v.class==playerclass then t[k]=v.title end end
					   return t
					 end,
				width = "double",
				-- KW
				get = function()
					local _active = GetActiveTalentGroup() or 1
					self:DebugLogAdd("Setup Config ==> self.optiontables.main.args.build.get")
					self:DebugLogAdd("_active: " .. _active)
					self:DebugLogAdd("self.db.char.currentBuildKey[_active]: " .. self.db.char.currentBuildKey[_active])
					return self.db.char.currentBuildKey[_active]
				end,
				-- KW
				set = function(_,k) self:SetCurrentBuild(k,false) end,
				order = 1.1,
			},
			forcebuild = {
				name = L['opt_force'],
				desc = L['opt_force_desc'],
				type = "toggle",
				width = "single",
				--get simple
				set = function(i,v) Setter_Simple(i,v)  self:UpdateBuild(false)  self:PlayTalented()  ZygorTalentAdvisorPopout_Update()  end,
				hidden = function() return not self.currentBuild['player'] or self.currentBuild['player'].status_real.colorcode~="RED" end,
				order = 1.2,
			},
			desc1 = { order = 1.21,	type = "description",	name = "", },
			buildstatus = {
				type = "description",
				name = function() return self.currentBuild['player'] and self.currentBuild['player']:GetStatusMessage() end,
				width = "full",
				order = 1.3,
			},
			--[[
			dualspecdesc = {
				type = "description",
				name = function() return (GetActiveTalentGroup(false,false)==1 and L['opt_dualspec_pri'] or L['opt_dualspec_sec']):format(select(2,GetTalentTabInfo(GetPrimaryTalentTree() or GetPreviewPrimaryTalentTree()))) end,
				width = "full",
				hidden = function() return GetNumTalentGroups(false,false)==1 end,
				order = 1.5,
			},
			--]]
			desc12 = { order = 1.91,	type = "description",	name = "|n", },
			descp = { ---------------- PET BUILD ------------------
				type = "header",
				name = L['opt_petbuild_header'],
				order = 2.01,
				hidden = function() return (select(2,UnitClass("player"))~="HUNTER") end,
			},
			petbuild = {
				name = L['opt_petbuild'],
				desc = L['opt_petbuild_desc'],
				type = "select",
				values = function()
					   local t={["_"]=L['opt_build_none']}
					   if not next(self.registeredBuilds) then return t end
					   local k,v
					   for k,v in pairs(self.registeredBuilds) do
						if v.pet then
							local mypettype = select(6,GetTalentTabInfo(1,false,true))
							mypettype = mypettype and mypettype:upper():match("HUNTERPET(.+)")
							local color = (mypettype==v.pet and "" or "|cffbbbbbb")
							t[k]=L['opt_petbuild_'..string.lower(v.pet)]..": "..color..v.title
						end
						
					   end
					   return t
					 end,
				width = "double",
				-- KW
				get = function()  return self.db.char.currentPetBuildKey[self:GetPetID()]  end,
				-- KW
				set = function(_,k) self:SetCurrentBuild(k,true) end,
				hidden = function() return (select(2,UnitClass("player"))~="HUNTER") end,
				--disabled = function() return not GetTalentTabInfo(1,false,true) or not GetTalentInfo(1,1,false,true) end,
				order = 2.1,
			},
			forcepetbuild = {
				name = L['opt_force'],
				desc = L['opt_force_desc'],
				type = "toggle",
				width = "single",
				--get simple
				set = function(i,v) Setter_Simple(i,v)  self:UpdateBuild(true)  self:PlayTalented()  ZygorTalentAdvisorPopout_Update()  end,
				hidden = function() return not self.currentBuild['pet'] or self.currentBuild['pet'].status_real.colorcode~="RED" end,
				order = 2.2,
			},
			desc21 = { order = 2.21,	type = "description",	name = "", },
			petbuildstatus = {
				type = "description",
				name = function() return self.currentBuild['pet'] and self.currentBuild['pet']:GetStatusMessage() end,
				width = "full",
				order = 2.3,
				hidden = function() return (select(2,UnitClass("player"))~="HUNTER") end,
			},
			petnewstatus = {
				type = "description",
				name = L['opt_pet_new'],
				width = "full",
				order = 2.3,
				hidden = function() return (select(2,UnitClass("player"))~="HUNTER") or not self:IsPetNew() end,
			},
			petbuildbmstatus = {
				type = "description",
				name = function()
					local petbuild = self.currentBuild.pet
					if not petbuild or not petbuild.build then return end
					local tree = GetPrimaryTalentTree() or GetPreviewPrimaryTalentTree()
					local is_bm = tree and (select(6,GetTalentTabInfo(tree))=="HunterBeastMastery")
					local pet_bm = #petbuild.build>MAX_NOT_BM_PET_TALENTS
					if not tree then
						return L['opt_petbmstatus_nospec']
					elseif is_bm and not pet_bm then
						return L['opt_petbmstatus_bm']
					elseif pet_bm and not is_bm then
						local myspec = select(2,GetTalentTabInfo(tree))
						return L['opt_petbmstatus_notbm']:format(myspec)
					end
				end,
				width = "full",
				hidden = function() return not self.currentBuild['pet'] end,
				order = 2.4,
			},

			desc22 = { order = 2.9,	type = "description",	name = "|n", },
			talentframe = {
				name = L['opt_talentframe'],
				type = "header",
				--inline = true,
				order = 7,
				--args = {
			},
			hints = {
				name = L['opt_hints'],
				desc = L['opt_hints_desc'],
				type = "toggle",
				width = "full",
				--get inherited simple
				set = function(i,v) Setter_Simple(i,v)  self:PlayTalented()  end,
				order = 7.1,
			},
			preview = {
				name = L['opt_preview'],
				desc = L['opt_preview_desc'],
				type = "toggle",
				width = "full",
				--get inherited simple
				set = function(i,v) Setter_Simple(i,v)  self:PlayTalented()  end,
				order = 7.2,
			},
			popup = {
				name = L['opt_popup'],
				desc = L['opt_popup_desc'],
				type = "select",
				style = "radio",
				width = "double",
				--get inherited simple
				--set inherited simple
				values = {[0]=L['opt_popup_0'],L['opt_popup_1'],L['opt_popup_2'],L['opt_popup_3']},
				order = 8,
			},
			windowdocked = {
				name = L['opt_popup_dock'],
				desc = L['opt_popup_dock_desc'],
				type = "toggle",
				width = "full",
				--get inherited simple
				set = function(i,v)
					Setter_Simple(i,v)
					ZygorTalentAdvisorPopout_Reparent()
					if (v==false) then ZygorTalentAdvisorPopout:ClearAllPoints()  ZygorTalentAdvisorPopout:SetPoint("CENTER",0,200) end
					ZygorTalentAdvisorPopout_UpdateDocking()
				      end,
				order = 9,
			},
			sep1 = {
				type="description", name=" |n |n |n", order=98
			},
			debug = {
				hidden = true,
				name = L["opt_debug"],
				desc = L["opt_debug_desc"],
				type = 'toggle',
				order=-10,
			},
			report = {
				name = L["opt_report"],
				desc = L["opt_report_desc"],
				type = 'execute',
				func = "DumpTalents",
				order = 99,
			},
		}
	}
	
	self.optiontables.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

	local AceConfig = LibStub("AceConfig-3.0")
	AceConfig:RegisterOptionsTable(self.name, self.optiontables.main, "zta")
	AceConfig:RegisterOptionsTable(self.name.."-Profile", self.optiontables.profile, "ztaprofile");
	local AceConfigDialog=LibStub("AceConfigDialog-3.0")
	AceConfigDialog:AddToBlizOptions(self.name, self.optiontables.main.name, nil)
	AceConfigDialog:AddToBlizOptions(self.name.."-Profile", self.optiontables.profile.name, self.optiontables.main.name)
end

function ZTA:OnNewTalents(pet)
	--local lasttalents = pet and self.lastUnspentPetTalents or self.lastUnspentTalents
	-- no selected build? bail.
	self:Debug("On New Talents "..tostring(pet))

	if not self.currentBuild[who(pet)] and GetUnspentTalentPoints(false,pet)>0 then
		if LibTutorial then LibTutorial:ShowTutorial("ZTA2") end
		return nil
	end

	--if self.alreadyProcessingNewTalents[toboolean(pet)] then return end

	--self.alreadyProcessingNewTalents[toboolean(pet)]=true

	-- no talents? bail.
	--if GetUnspentTalentPoints(false,pet)==0 then return end
	-- or not! handle clearing, too.

	self:LoadBuilds(pet)

	--if not self:GetSuggestion(pet) then return nil end
	-- oh, do pop up, just with a warning

	local switchToPet = function()
		-- try to activate the pet talent frame
		for i=1,5 do
			local tab = _G["PlayerSpecTab"..i]
			if tab and string.find(tab.specIndex,"^petspec") then
				tab:Click()
				break
			end
		end
	end

	local popup = self.db.profile.popup or 0
	if popup==1 then
		TalentFrame_LoadUI()
		PlayerTalentFrame_Open(pet, pet and 1 or GetActiveTalentGroup())

		if pet then switchToPet() end
	end
	
	if popup==2 then
		ZygorTalentAdvisorPopout_Popout()
		if pet then switchToPet() end
		ZygorTalentAdvisorPopout_Update()
	end

	if popup==3 then
		self:LearnSuggestedTalents(pet,true)
	end

	self:PlayTalented()
end

local panels={"Panel1","Panel2","Panel3","PetPanel"}
function ZTA:CleanupTalentFrame()
	local hint,bor
	for p,panel in ipairs(panels) do
		for talent=1,100 do
			bor = _G["PlayerTalentFrame"..panel.."Talent"..talent.."RankBorder"]
			if bor then
				bor:SetWidth(32)
				bor:SetHeight(32)
			end

			hint = _G["PlayerTalentFrame"..panel.."Talent"..talent.."Hint"]
			if hint then hint:Hide() end
		end
	end

	self.cleaning=true
	--pcall(function() PlayerTalentFrame_Update(PlayerTalentFrame) end) -- something breaks here... screw it?
	PlayerTalentFrame_Update()
	self.cleaning=false
end

local function Find(tab,field,data)
	for gi,g in pairs(tab) do
		if g[field]==data then return g end
	end
end

local function ZTA_SelectTree_Flash(self,elapsed)
	self.time=self.time+elapsed
	if self.time>0.5 then
		PlayerTalentFramePanel1SelectTreeButton:UnlockHighlight()
		PlayerTalentFramePanel2SelectTreeButton:UnlockHighlight()
		PlayerTalentFramePanel3SelectTreeButton:UnlockHighlight()
		if ZTA.currentBuild.player and ZTA.currentBuild.player.spec and PlayerTalentFrame.talentGroup==GetActiveTalentGroup() then
			local specbutton = _G['PlayerTalentFramePanel'..ZTA.currentBuild.player.spec..'SelectTreeButton']
			if specbutton.flash then specbutton:LockHighlight() else specbutton:UnlockHighlight() end
			specbutton.flash = not specbutton.flash
		end
		self.time=0
	end
end

function ZTA:HookIntoTalentWindow()
	self:Debug("zta hooking 1st time")
	PlayerTalentFrameLearnButton:SetScript("OnClick",ZygorTalentAdvisor_PlayerTalentFrameLearnButton_OnClick)

	ZygorTalentAdvisorPopout_Hook()

	hooksecurefunc("PlayerTalentFrame_OnHide",ZygorTalentAdvisorPopout_UndockWhenTalentsHide)
	hooksecurefunc("PlayerTalentFrame_Refresh",function()
		self:Debug("PlayerTalentFrame_Refresh, pet="..tostring(PlayerTalentFrame.pet))
		self:UpdateBuild(PlayerTalentFrame.pet)
		self:PlayTalented()
		ZygorTalentAdvisorPopout_Update()
	end)
	hooksecurefunc("PlayerTalentFrame_UpdateControls",function()
		self:Debug("PlayerTalentFrame_UpdateControls, pet="..tostring(PlayerTalentFrame.pet))
		self:UpdateBuild(PlayerTalentFrame.pet)
		self:PlayTalented()
		ZygorTalentAdvisorPopout_Update()
	end)
	
	self.hooked=true
end

function ZTA:PlayTalented()
	if self.cleaning then return end
	if not PlayerTalentFrame or not PlayerTalentFrame:IsShown() then return end

	-- hook in deeper.
	if not self.hooked then
		self:HookIntoTalentWindow()
	end

	
	if not PlayerTalentFrame.advisorbutton then
		ZygorTalentAdvisorPopoutButton:SetParent(PlayerTalentFrame)
		PlayerTalentFrame.advisorbutton = ZygorTalentAdvisorPopoutButton
		PlayerTalentFrame.advisorbutton:ClearAllPoints()
		PlayerTalentFrame.advisorbutton:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPRIGHT",-2,-140)

		--[[ -- advisor button moved to "tab"
		--PlayerTalentFrame.advisorbutton:SetFrameLevel(120)
		--PlayerTalentFrameActivateButton:SetPoint("TOPRIGHT",PlayerTalentFrame,"TOPRIGHT",-40,-30)
		--]]

		--[[
		CreateFrame("Button",nil,PlayerTalentFrame,"UIPanelButtonTemplate")
		PlayerTalentFrame.advisorbutton:ClearAllPoints()
		PlayerTalentFrame.advisorbutton:SetPoint("TOPRIGHT",-40,-40)
		PlayerTalentFrame.advisorbutton:SetHeight(30)
		PlayerTalentFrame.advisorbutton:SetWidth(30)
		PlayerTalentFrame.advisorbutton:SetText("ZTA>")
		PlayerTalentFrame.advisorbutton:SetScript("OnClick",function() if ZygorTalentAdvisorPopout_Popup:IsShown() then ZygorTalentAdvisorPopout_Popup:Hide() else ZygorTalentAdvisorPopout_Popup() end end)
		--PlayerTalentFrame.advisorbutton:SetScript("OnEnter",function(self) GameTooltip_SetDefaultAnchor(GameTooltip,self)  GameTooltip:SetText(L['name']) GameTooltip:AddLine(L['popout_button_tip']) GameTooltip:Show() end)
		PlayerTalentFrame.advisorbutton:SetScript("OnEnter",function(self) GameTooltip_AddNewbieTip(self, L['name'], 1,1,1, L['popout_button_tip']) end)
		PlayerTalentFrame.advisorbutton:SetScript("OnLeave",GameTooltip_Hide)
		--]]
	end
	PlayerTalentFrame.advisorbutton:Show()

	local pet = PlayerTalentFrame.pet
	local who=who(pet)
	local build = self.currentBuild[who]

	-- no build? clean up, bail out.
	if not build or not build.ready then
		self:Debug("Cleaning up and bailing.")
		self:CleanupTalentFrame()
		ZygorTalentAdvisorPopout_Update()
		--ZygorTalentAdvisorPopout_UpdateDocking()
		return
	end

	--self:Debug("playtalented "..who)
	-- first the spec buttons
	if not PlayerTalentFrame.scriptedtoflash then
		PlayerTalentFrame:HookScript("OnUpdate",ZTA_SelectTree_Flash)
		PlayerTalentFrame.time=0
		PlayerTalentFrame.scriptedtoflash = true
		ZTA_SelectTree_Flash(PlayerTalentFrame,99)  --force
	end
	if PlayerTalentFramePanel1SelectTreeButton:IsShown() and build.spec then
		PlayerTalentFrameHeaderHelpBoxArrow1:Hide()
		PlayerTalentFrameHeaderHelpBoxArrow2:Hide()
		PlayerTalentFrameHeaderHelpBoxArrow3:Hide()
		_G['PlayerTalentFrameHeaderHelpBoxArrow'..build.spec]:Show()
	end

	--PlayerTalentFrameHeaderFrame.HeaderText:SetText(self.currentBuildTitle[who])
	--PlayerTalentFrameHeaderFrame.SubHeaderText:SetText("One-liner description could go here.")

	self:Debug("Displaying talent build and suggestions.")

	local suggestion = build.suggestion

	local counts,maxcounts = self:CountBuildTalents(self:GetTalentsSpent(pet),build.build,pet)

	local button
	local txt,bor,hint

	local panels = pet and {"PetPanel"} or {"Panel1","Panel2","Panel3"}
	for tab,panel in ipairs(panels) do
		local talents = GetNumTalents(tab,false,pet)
		for talent=1,talents do
			--[[
			txt = _G["PlayerTalentFrameTalent"..talent.."_MrRipleyTxt"]
			bor = _G["PlayerTalentFrameTalent"..talent.."_MrRipleyBor"]
			if not txt then
				button = _G["PlayerTalentFrameTalent"..talent]
				txt = button:CreateFontString("PlayerTalentFrameTalent"..talent.."_MrRipleyTxt")
				txt:SetPoint("TOPRIGHT",button,"TOPRIGHT",3,3)
				txt:SetWidth(8)
				txt:SetJustifyV("TOP")
				txt:SetJustifyH("CENTER")
				txt:SetFontObject(GameFontNormalSmall)
				bor = button:CreateTexture("PlayerTalentFrameTalent"..talent.."_MrRipleyBor")
				bor:SetPoint("CENTER",txt)
				bor:SetTexture("Interface\\TalentFrame\\TalentFrame-RankBorder")
				bor:SetWidth(32)
				bor:SetHeight(32)
			end
			--]]

			local prefix = "PlayerTalentFrame"..panel.."Talent"..talent
			button = _G[prefix]
			txt = _G[prefix.."Rank"]
			bor = _G[prefix.."RankBorder"]
			borg = _G[prefix.."RankBorderGreen"]
			hint = _G[prefix.."Hint"]

			-- prepare the hint balloon
			if not hint then
				hint = button:CreateTexture(prefix.."Hint")
				--hint:SetTexture("Interface\\Buttons\\CheckButtonHilight")
				hint:SetPoint("LEFT",_G[prefix.."IconTexture"],"RIGHT",-14,5)
				hint:SetSize(32,32)
				hint:SetTexture("Interface\\Addons\\ZygorTalentAdvisor\\Skin\\MrRipley_Hints")
				hint:SetDrawLayer("OVERLAY")
			end

			local name,_,_,_,realrank,maxrank,available,rank = GetTalentInfo(tab,talent,false,pet)
			local desired = maxcounts[tab] and maxcounts[tab][talent] or 0

			local color_up_notfull = "|cff00ff00"
			local color_up_full = "|cffffff00"

			-- textual build preview
			if self.db.profile.preview and build.ready and (build.status_real.colorcode~="RED" or build.forced) then
				if desired>0 and rank<desired then
					if not txt:IsVisible() then
						txt:SetText("|cffaaaaaa"..rank.."/|r|cff00aaff"..desired.."|r")
						txt:Show()
						bor:Show()
					else
						txt:SetText(rank.."|cffaaaaaa/|r|cff00aaff"..desired.."|r")
					end

					bor:SetSize(36,18)
					borg:SetSize(36,18)

				elseif desired>0 and rank==desired then

					txt:SetText(rank.."/"..desired)
					bor:SetSize(36,18)
					borg:SetSize(36,18)

				elseif rank>desired then
					
					txt:SetText(rank.."|cffaaaaaa/|r|cffff0000"..desired.."|r")
					bor:SetSize(36,18)
					borg:SetSize(36,18)

				else
					bor:SetSize(18,18)
					borg:SetSize(18,18)
					--if GetUnspentTalentPoints(false,pet) preview 
				end
			else
				bor:SetSize(18,18)
				borg:SetSize(18,18)
				txt:SetText(rank)
				--if rank<maxrank then txt:SetTextColor(0,1,0) else txt:SetTextColor
			end

			-- hint balloons

			if suggestion and #suggestion>0 and self.db.profile.hints then

				local suggested

				-- consider all suggestions in preview/ooo mode; only the first suggestion in strict/inorder mode
				--self:IsOutOfOrder(pet) or 

				-- actually, no. Let's try to get out of OOO mode somehow.
				--[[
				if preview or (suggestion[1][1]==tab and suggestion[1][2]==talent) then
					suggested = suggestion and suggestion[tab.."."..talent]
				end
				--]]
				suggested = suggestion[tab.."."..talent]

				local mindesired = counts[tab] and counts[tab][talent] or 0

				-- hint balloon display
				if suggested then -- suggested this turn
					local hintpoints = suggested - (rank-realrank)  -- suggested minus previewed
					if hintpoints>0 then
						hint:SetTexCoord(0.125*hintpoints,0.125*(hintpoints+1),0,1)
					elseif hintpoints==0 then
						hint:SetTexCoord(0.125*6,0.125*7,0,1)
					else
						hint:SetTexCoord(0.875,1.000,0,1)  -- X
						--self:Debug("X1"..name.." : hints="..hintpoints.." for rank "..rank)
					end
					hint:SetDesaturated(_G[prefix.."IconTexture"]:IsDesaturated())
					hint:Show()
				elseif rank>mindesired and rank>realrank and realrank<=mindesired then -- overinvested! oh shit. But warn only if it matters anymore.
					hint:SetTexCoord(0.875,1.000,0,1)
					hint:SetDesaturated(_G[prefix.."IconTexture"]:IsDesaturated())
					hint:Show()
					--self:Debug("X2 "..name)
				else
					hint:Hide()
				end
			else
				hint:Hide()
			end
		end
	end
end

function ZTA:GetSuggestionTooltip()
	self:Debug("GetSuggestionTooltip")
	return L['suggest_button_tooltip']:format(self.currentBuild[who(PlayerTalentFrame.pet)].title)
end

--[[	Get suggestion in the following format:
	{
		['Spec'] = {
			{
				[1]=3, [2]=4, [3]=5,
				name="Get This 3,4,5",
				tab=1, talent=3,
				tex="...texture"
			},
			{
				... another talent ...
			}
		},
		['another spec'] = {
			...
		}
	}
--]]
function ZTA:GetSuggestionFormatted(pet)
	TalentFrame_LoadUI()
	local sugformatted={}
	local who=who(pet)
	for si,sug in ipairs(self.currentBuild[who].suggestion) do
		local tab,talent = sug.tab,sug.talent
		local id,tabname = GetTalentTabInfo(tab,false,pet)
		local name,tex,_,_,realrank,maxrank=GetTalentInfo(tab,talent,false,pet,GetActiveTalentGroup())
		if not sugformatted[tabname] then sugformatted[tabname]={} end
		local inserted=false
		for fi,sugf in ipairs(sugformatted[tabname]) do
			if sugf.name==name then
				if maxrank>1 then
					table.insert(sugf,realrank+#sugf+1)
				else
					table.insert(sugf,0)
				end
				inserted=true
				break
			end
		end
		if not inserted then -- new talent
			table.insert(sugformatted[tabname],{tex=tex,tab=tab,name=name,talent=talent,[1]=realrank+1})
		end
	end
	return sugformatted
end

function ZTA:LearnSuggestedTalents(pet,loud)
	TalentFrame_LoadUI()
	local who=who(pet)
	
	-- KW
	self:Debug("who: " .. tostring(who))
	
	local build = self.currentBuild[who]
	if not build then
		self:Print(L['error_bulklearn_nobuild'])
		return
	end

	local suggestion = build.suggestion
	if not suggestion or #suggestion==0 then
		self:Print(L['error_bulklearn_nosuggestion'])
		return
	end

	
	-- KW
	self:Debug("suggestion: " .. tostring(suggestion))

	if loud then
		local sugformatted = self:GetSuggestionFormatted(pet)
		local s=""

		self:Print(L['msg_learned_verbose'])

		for tab,talents in pairs(sugformatted) do
			self:Print("|cffffffff"..tab.."|r:")
			local s
			for n,levels in ipairs(talents) do
				talent = "|T"..levels.tex..":0:0:0:0|t |cffffdd00"..GetTalentLink(levels.tab,levels.talent,false,pet,GetActiveTalentGroup())
				if levels[1]==0 then
					s=talent
				else
					s=talent.." |cff997700("
					if #levels<3 then s=s..table.concat(levels,",") else s=s..levels[1].."-"..levels[#levels] end
					s=s..")|r"
				end
				self:Print(L['msg_learned_verbose_talent']:format(s))
			end
		end
	else
		self:Print(L['msg_learned'])
	end

	-- KW
	self:Debug("#suggestion: " .. tostring(#suggestion))
	
	if #suggestion>1 then
		self:PreviewSuggestions(pet,true)
		self:ScheduleTimer(function()
			LearnPreviewTalents(pet)
		end, 0.1)
	else
		-- KW
		self:Debug("suggestion[1].tab: " .. tostring(suggestion[1].tab))
		self:Debug("suggestion[1].talent: " .. tostring(suggestion[1].talent))
		self:Debug("pet: " .. tostring(pet))
		
		Old_LearnTalent(suggestion[1].tab,suggestion[1].talent,pet)
	end

	if not self.db.profile.windowdocked then
		ZygorTalentAdvisorPopout:Hide()
	else
		ZygorTalentAdvisorPopout_Update()
	end

	--[[
	else
		self.bulklearning=true -- starts processing the queue, driven by CHARACTER_POINTS_CHANGED -1
		local name=GetTalentInfo(self.suggestion[who][1].tab,self.suggestion[who][1].talent,false,pet)
		self:Print(L['msg_learned']:format(name))
		Old_LearnTalent(self.suggestion[who][1].tab,self.suggestion[who][1].talent,pet)
	end
	--]]
end

function ZTA:PreviewSuggestions(pet,quiet)
	SetCVar("previewTalentsOption",1)
	--local preview = GetCVarBool(
	--if not preview then return end

	self.cleaning = true

	if pet==nil then pet = PlayerTalentFrame.pet end

	local build = self.currentBuild[who(pet)]   	if not build then return end
	local suggestion = build.suggestion   	if not suggestion then return end

	ResetGroupPreviewTalentPoints(pet)

	if not pet then
		SetPreviewPrimaryTalentTree(self.currentBuild.player.spec,GetActiveTalentGroup())
	end
	
	-- this may look out of order, but is fine for applying ALL suggestions

	-- not any longer?

	local pts
	--[[
	local sug
	for tab,talent in ZTA_talentpairs(false,pet) do
		sug = suggestion[tab.."."..talent]
		if sug then 
			pts = GetGroupPreviewTalentPointsSpent(pet)
			AddPreviewTalentPoints(tab,talent,sug,pet)
			if pts==GetGroupPreviewTalentPointsSpent(pet) then
				local name=GetTalentInfo(tab,talent,false,pet)
				self:Print("|cffff0000Error!|r Talent "..name.." suggested but unavailable!")
			end
		end
	end
	--]]
	for i,sug in ipairs(suggestion) do
		-- TODO: suspend updates!
		pts = GetGroupPreviewTalentPointsSpent(pet)
		AddPreviewTalentPoints(sug.tab,sug.talent,1,pet)
		if pts==GetGroupPreviewTalentPointsSpent(pet) then
			local name=GetTalentInfo(sug.tab,sug.talent,false,pet)
			self:Print("|cffff0000Error!|r Talent "..name.." suggested but unavailable!")
		end
	end

	self.cleaning = false
	self:PlayTalented()
	ZygorTalentAdvisorPopout_Update()


	if not quiet and not PlayerTalentFrame:IsVisible() then
		TalentFrame_LoadUI()
		ToggleTalentFrame()
	end
end

function ZTA_talentpairs(inspect,pet)
	local tab,tal=1,0
	return function()
		tal=tal+1
		if tal>GetNumTalents(tab,inspect,pet) then
			tal=1
			tab=tab+1
		end
		if tab<=GetNumTalentTabs(inspect,pet) then
			return tab,tal
		end
	end
end



Old_LearnTalent = LearnTalent
function LearnTalent(tab,talent,pet,group)
	-- need to double-check if the user hasn't clicked an inaccessible talent, otherwise we're barking up the wrong tree
	if GetUnspentTalentPoints(false,pet)==0 then return nil end

	local id, name, desc, iconTexture, tabPointsSpent = GetTalentTabInfo(tab,false,pet,group)
	local name, iconTexture, tier, column, rank, maxRank, meetsPrereq, previewRank, meetsPreviewPrereq = GetTalentInfo(tab, talent, false, pet, group);

	if ( ((tier - 1) * (pet and PET_TALENTS_PER_TIER or PLAYER_TALENTS_PER_TIER) > tabPointsSpent) ) then
		-- tier locked! bail.
		return nil
	end
	local reqtab,reqtal,learnable = GetTalentPrereqs(tab,talent,false,pet)
	if reqtab and not learnable then
		return nil
	end

	local ZTA = ZygorTalentAdvisor
	local who=who(pet)
	local build=ZTA and ZTA.currentBuild[who]
	local suggestion = build and build.suggestion
	if build and suggestion and #suggestion>0 then
		local found,s
		for i=1,#suggestion do if suggestion[i].tab==tab and suggestion[i].talent==talent then found = i end end
		if not found then
			-- RED!
			local counts,maxcounts = ZTA:CountBuildTalents(ZTA:GetTalentsSpent(pet),build)
			if not maxcounts[tab] or maxcounts[tab][talent]==0 then
				-- never taken at all
				StaticPopupDialogs['ZYGORTALENTADVISOR_WARNING'].text = L['warning_learn1_red0']:format(build.title)
			elseif rank+1>maxcounts[tab][talent] then
				-- taken, but not this far
				StaticPopupDialogs['ZYGORTALENTADVISOR_WARNING'].text = L['warning_learn1_red']:format(build.title,maxcounts[tab][talent],GetTalentInfo(tab,talent,false,pet))
			else
				-- Warning, ORANGE zone: not in suggestion, so too far
				local stab = suggestion[1].tab
				local stalent = suggestion[1].talent
				StaticPopupDialogs['ZYGORTALENTADVISOR_WARNING'].text = L['warning_learn1_orange']:format(build.title,select(2,GetTalentTabInfo(stab,false,pet)),GetTalentInfo(stab,stalent,false,pet),GetTalentInfo(tab,talent,false,pet))
			end
			local dialog = StaticPopup_Show("ZYGORTALENTADVISOR_WARNING")
			if dialog then
				dialog.data = {tab=tab,talent=talent,pet=pet}
			else
				ZTA:Print("ERROR: Cannot show dialog.\n"..StaticPopupDialogs['ZYGORTALENTADVISOR_WARNING'].text)
			end
			return
		else
			-- YELLOW.
		end
	end

	if SAFEMODE then
		self:Debug("Learning\n"..name)
	else
		Old_LearnTalent(tab,talent,pet)
	end
end

-- OVERRIDE
function ZygorTalentAdvisor_PlayerTalentFrameLearnButton_OnClick(self)
	local TalentFrame = PlayerTalentFrame

	local ZTA = ZygorTalentAdvisor

	local pet = TalentFrame.pet
	local who=who(pet)

	ZTA:UpdateBuild(pet)
	local build = ZTA.currentBuild[who]
	local status = build and build.status_preview

	if build then
		if not build.ready then
			StaticPopupDialogs['ZYGORTALENTADVISOR_PREVIEWWARNING'].text=L["warning_preview_black"]:format(build:GetStatusMessage())
		elseif status.colorcode then
			if status.colorcode=="GREEN" or status.colorcode=="YELLOW" then
				StaticPopupDialogs['ZYGORTALENTADVISOR_PREVIEWWARNING'].text=L["warning_preview_green"]:format(build.title)
			elseif status.colorcode=="ORANGE" then
				StaticPopupDialogs['ZYGORTALENTADVISOR_PREVIEWWARNING'].text=L["warning_preview_orange"]:format(build.title,status.missed-status.left) --GetUnspentTalentPoints(false,pet)+GetGroupPreviewTalentPointsSpent(pet) ??
			elseif status.colorcode=="RED" then
				StaticPopupDialogs['ZYGORTALENTADVISOR_PREVIEWWARNING'].text=L["warning_preview_red"]:format(build.title)
			end
		end
		local dialog = StaticPopup_Show("ZYGORTALENTADVISOR_PREVIEWWARNING")
		if dialog then
			dialog.data = {pet=TalentFrame.pet}
		else
			ZTA:Print("ERROR: Cannot show dialog.\n"..StaticPopupDialogs['ZYGORTALENTADVISOR_PREVIEWWARNING'].text)
		end
		return nil
	else
		PlayerTalentFrameLearnButton_OnClick(self)
		--StaticPopup_Show("CONFIRM_LEARN_PREVIEW_TALENTS")
	end
end


--[[
function ZygorTalentAdvisor_PlayerTalentFrameTalent_OnClick(self, button)
	--debug("click in zta? "..tostring(self.isZTA))
	if ( IsModifiedClick("CHATLINK") ) then
		local link = GetTalentLink(PanelTemplates_GetSelectedTab(PlayerTalentFrame), self:GetID(),
			PlayerTalentFrame.inspect, PlayerTalentFrame.pet, PlayerTalentFrame.talentGroup, GetCVarBool("previewTalents"));
		if ( link ) then
			ChatEdit_InsertLink(link);
		end
	elseif not PlayerTalentFrame.inspect and (PlayerTalentFrame.pet or GetActiveTalentGroup(false,PlayerTalentFrame.pet)==PlayerTalentFrame.talentGroup) then
		-- only allow functionality if an active spec is selected
		if ( button == "LeftButton" ) then
			if ( GetCVarBool("previewTalents") ) then
				AddPreviewTalentPoints(PanelTemplates_GetSelectedTab(PlayerTalentFrame), self:GetID(), 1, PlayerTalentFrame.pet, PlayerTalentFrame.talentGroup);
			else
				LearnTalent(PanelTemplates_GetSelectedTab(PlayerTalentFrame), self:GetID(), PlayerTalentFrame.pet, PlayerTalentFrame.talentGroup);
			end
		elseif ( button == "RightButton" ) then
			if ( GetCVarBool("previewTalents") ) then
				if IsTalentRemovable(PanelTemplates_GetSelectedTab(PlayerTalentFrame), self:GetID(), PlayerTalentFrame.pet, PlayerTalentFrame.talentGroup) then
					AddPreviewTalentPoints(PanelTemplates_GetSelectedTab(PlayerTalentFrame), self:GetID(), -1, PlayerTalentFrame.pet, PlayerTalentFrame.talentGroup);
				end
			end
		end
	end

	if self.isZTA then
		self:GetScript("OnLeave")(self)
		self:GetScript("OnEnter")(self)
	end
end

function ZygorTalentAdvisor_PlayerTalentFrameTalent_OnEvent(self, event, ...)
	if self:GetID() then
		-- whoa, original button! handle carefully.
		PlayerTalentFrameTalent_OnEvent(self, button)
		return
	end
	if ( GameTooltip:IsOwned(self) ) then
		GameTooltip:SetTalent(self.tab, self.talent, false, false, 1, GetCVarBool("previewTalents"))
	end
end

function ZygorTalentAdvisor_PlayerTalentFrameTalent_OnEnter(self)
	if self:GetID() and self:GetID()>0 then
		-- whoa, original button! handle carefully.
		PlayerTalentFrameTalent_OnEnter(self, button)
		return
	end
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:SetTalent(self.tab, self.talent, false, false, 1, GetCVarBool("previewTalents"))
end
--]]


-- Our powerhorse. Update suggestions, update display.
function ZTA:UpdateAllBuilds()
	self:UpdateBuild(false)
	self:UpdateBuild(true)
end

function ZTA:UpdateBuild(pet)
	local who=who(pet)
	local build = self.currentBuild[who]
	if not build then return end

	self:DebugPush(who)

	build:Update()
	self:Debug(who.."suggestion: ".. build:QuickDumpStatusAndSuggestion())

	if build.suggestion and #build.suggestion>0 then
		if LibTutorial then LibTutorial:ShowTutorial("ZTA3") end
	end

	local AceConfigRegistry=LibStub("AceConfigRegistry-3.0")
	AceConfigRegistry:NotifyChange(self.name)

	self:DebugPop()
end

function ZTA:IsOutOfOrder(pet)
	return pet and self.petOutOfOrder or self.outOfOrder
end

function ZTA:Hint(tab,talent,pet)
	local id,tabname = GetTalentTabInfo(tab,false,pet)
	local name,_,_,_,rank = GetTalentInfo(tab,talent,false,pet)
	
	self:Print("Suggestion: Upgrade your "..(pet and "pet's " or "")..tabname.." talent '"..name.."'.")
end

function ZTA:GetTalentsSpent(pet)
	-- KW
	-- Apparently even tho you can pass a nil to GetTalentTabInfo for the TalentGroup, it's a bit bugged.
	-- This way we force it to use the active talent spec
	local active = GetActiveTalentGroup(false,pet)
	local tabs = GetNumTalentTabs(false,pet)
	local talentsSpent = 0
	for i=1, tabs do
		local id, name, desc, iconTexture, pointsSpent = GetTalentTabInfo(i,false,pet,active)
		talentsSpent = talentsSpent + pointsSpent
	end
	return talentsSpent
end


--- select a build. Determine if it's a pet build from the build itself.
function ZTA:SetCurrentBuild(key,pet)
	self:DebugPush("Activating build '"..tostring(key).."' for: ".. who(pet))

	-- KW
	if pet then
		self.db.char.currentPetBuildKey[self:GetPetID()] = key
	else
		self.db.char.currentBuildKey[GetActiveTalentGroup() or 1] = key
	end
	--local _talent = GetActiveTalentGroup() or 1
	--if pet then  self.db.char.currentPetBuildKey[_talent] = key  else  self.db.char.currentBuildKey[_talent] = key  end
	-- KW

	local build = self.registeredBuilds[key]

	-- we have the build, let's check it.
	-- we could trust pruning for classes, but pet types change often.

	-- ugly, but better play safe and assume the build knows it's current before it does something silly.
	if build then pet = build.pet end
	self.currentBuild[who(pet)] = build
	if build then build:Update() end

	self:PlayTalented()
	ZygorTalentAdvisorPopout_Update();

	self:DebugPop()
end

-- find max talent counts - up to some point, and total.
function ZTA:CountBuildTalents(num,build)
	local counts = {}
	local maxcounts = {}
	local zeroer = {__index = function(tab,key) return 0 end}

	if not build then error("Error: no build to CountBuildTalents") end
	if num and num>#build then num=#build end

	if num then
		for i=1,num do
			local tab,talent = build[i][1],build[i][2]
			if not counts[tab] then counts[tab]={} setmetatable(counts[tab],zeroer) end
			counts[tab][talent]=counts[tab][talent]+1
		end
	end
	for i=1,#build do
		local tab,talent = build[i][1],build[i][2]
		if not maxcounts[tab] then maxcounts[tab]={} setmetatable(maxcounts[tab],zeroer) end
		maxcounts[tab][talent]=maxcounts[tab][talent]+1
	end

	return counts,maxcounts
end

function ZTA:OpenOptions()
	--self:OpenConfigMenu()
	InterfaceOptionsFrame_OpenToCategory(L['name'])
end

function ZTA:SetOption(cmd)
	LibStub("AceConfigCmd-3.0").HandleCommand(self, "zta", "ZygorTalentAdvisor", cmd)
end

function ZTA:GetStatusMessage(pet,glyphs)
	pet=who(pet)
	if self.currentBuild[who] then return self.currentBuild[who]:GetStatusMessage(glyphs) else return "? no msg ?" end
end



function ZTA:DumpTalents()
	if not self.dumpFrame then self:CreateDumpFrame() end

	HideUIPanel(InterfaceOptionsFrame)

	local tostr = function(val)
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
	local s = ""

	s = "Zygor Talent Advisor v"..self.version.."\n"

	local dumpTalents = function(pet)
		for tab=1,GetNumTalentTabs(false,pet) do
			s=s..("%d. %s:\n"):format(tab,tostring(select(2,GetTalentTabInfo(tab,false,pet))))
			for talent=1,GetNumTalents(tab,false,pet) do
				local name,_,_,_,realrank,maxrank,available,rank = GetTalentInfo(tab,talent,false,pet)
				if rank>0 then
					s=s..("  %d.%d: %s (%d/%d)"):format(tab,talent,name,realrank,maxrank)
					if rank~=realrank then s=s..(" +%d"):format(rank) end
					s=s.."\n"
				end
			end
		end
	end

	local dumpBuild = function(build,pet)
		if not build then return end
		for i=1,#build do
			local name = GetTalentInfo(build[i][1],build[i][2],false,pet)
			s=s..("%d: %d.%d [%s] %s %s|n"):format(i,build[i][1],build[i][2],name or "?",build[i].taken and " (taken)" or "",build[i].preview and " (previewed)" or "")
		end
	end

	local dumpSuggestion = function(sug,pet)
		if not sug then return end
		for i=1,#sug do
			local name = GetTalentInfo(sug[i].tab,sug[i].talent,false,pet)
			s=s..("%d: %d.%d [%s] (total:%d)|n"):format(i, sug[i].tab,sug[i].talent, name or "?", sug[sug[i].tab.."."..sug[i].talent])
		end
	end

	local DoDump = function (pet)
		local who=who(pet)
		s=s.."\nCurrent talents: \n"
		dumpTalents(pet)

		local build = self.currentBuild[who]

		if build then
			s=s.."\nCurrent build: "..(build.title).."|n"
			dumpBuild(build)
			s=s.."Ready: "..(build.ready and "YES" or "no").."\n"
			s=s.."\n"

			s=s.."\nStatus_real: \n"
			for k,v in pairs(build.status_real) do
				s=s.."\n   "..k.." = "..tostring(v)
			end

			s=s.."\nStatus_preview: \n"
			for k,v in pairs(build.status_preview) do
				s=s.."\n   "..k.." = "..tostring(v)
			end
			s=s.."\n"

			s=s.."\nSuggestion: \n"
			dumpSuggestion(self.currentBuild[who].suggestion)
		end


		s=s..("\nTalents left: %d\n"):format(GetUnspentTalentPoints(pet))
	end
	
	DoDump(false)
	
	if select(2,UnitClass("player"))=="HUNTER" then
		s=s.."\n--- PET ---\n"
		DoDump(true)
	end

	s = s .. "\nLog:\n"
	s = s .. self:DebugLogDump(100)

	self.dumpFrame.editBox:SetText(s)
	--local title = self.CurrentGuideName or L["report_notitle"]
	--local author = self.CurrentGuide.author or L["report_noauthor"]
	--self.dumpFrame.title:SetText(L["report_title"]:format(title,author))
	ShowUIPanel(self.dumpFrame)
	self.dumpFrame.editBox:HighlightText(0)
	self.dumpFrame.editBox:SetFocus(true)
end

function ZTA:DumpVal(val,lev,maxlev,nofun)
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
			if k~="parentStep"
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

function ZTA:CreateDumpFrame()
	local name = "ZygorTalentAdvisor_DumpFrame"

	local frame = CreateFrame("Frame", name, UIParent)
	self.dumpFrame = frame
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
	self.dumpFrame.editBox = editBox
	
	scrollArea:SetScrollChild(editBox)
	
	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")

	local title = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	self.dumpFrame.title = title
	title:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -10)
	title:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -30, -45)
	title:SetJustifyH("CENTER")
	title:SetJustifyV("TOP")

end

local GameTooltipSetTalent = GameTooltip.SetTalent
function ZygorTalentAdvisor_GameTooltipSetTalent(self,tab,talent,inspect,pet,group,preview)
	GameTooltipSetTalent(self,tab,talent,inspect,pet,group,preview)
	if not inspect then
		local ZTA=ZygorTalentAdvisor
		local who=who(pet)
		local build=ZTA.currentBuild[who]
		if build and build.ready then
			local count,maxcount = ZTA:CountBuildTalents(nil,build.build,pet)
			local rank = (maxcount and maxcount[tab]) and tonumber(maxcount[tab][talent]) or 0
			local color=""
			if maxcount[tab] and tonumber(maxcount[tab][talent])>0 then color="|cff00ff00" else color="|cffff0000" end
			GameTooltip:AddLine(L['talenttooltip']:format(build.title,color..(tonumber(maxcount[tab] and maxcount[tab][talent]) or 0)),1,1,1)
			GameTooltip:Show()
		end
	end
end
GameTooltip.SetTalent = ZygorTalentAdvisor_GameTooltipSetTalent



--- remove class-specific builds or any pets for non-hunters
--static
function ZTA:PruneRegisteredBuilds()
	--self:Print("Pruning!")
	if self.registeredBuildsPruned then return end

	local _,myclass = UnitClass("player")
	if not myclass then return end  -- sometimes it's too early for class to be available

	-- remove builds for other classes
	for bk,build in pairs(self.registeredBuilds) do
		if (build.class and build.class~=myclass)
		or (build.pet and myclass~="HUNTER")
		or (build.title:find("debug") and not self.db.profile.debug)
		then
			self.registeredBuilds[bk]=nil
		end
	end

	-- remove talent data for other classes
	for class,talents in pairs(self.TalentsToNumbers) do
		if (not talents.pet and class~=myclass)
		or (talents.pet and myclass~="HUNTER")
		then
			self.TalentsToNumbers[class]=nil
		end
	end

	self.registeredBuildsPruned = true

	self:Debug("Pruned.")
end
