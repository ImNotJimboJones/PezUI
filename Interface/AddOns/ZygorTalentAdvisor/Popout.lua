local ZTA = ZygorTalentAdvisor
if not ZTA then return end

local popout = {}
local L = ZTA.L

local function who(pet)
	return pet and 'pet' or 'player'
end

function ZygorTalentAdvisorPopout_OnShow(self)
	if not ZTA then return end

	TalentFrame_LoadUI()
	if ZTA.db.profile.windowdocked then
		if not PlayerTalentFrame:IsShown() then ToggleTalentFrame() end
	end

	ZygorTalentAdvisorPopout_Reparent()
	ZygorTalentAdvisorPopout_UpdateDocking()
	ZygorTalentAdvisorPopout_Update()
	if PlayerTalentFrame.advisorbutton then
		PlayerTalentFrame.advisorbutton:SetButtonState("PUSHED",1)
	end
	PlaySound("igCharacterInfoTab");
end

function ZygorTalentAdvisorPopout_OnHide(self)
	ZygorTalentAdvisorPopout_UpdateDocking()
	if PlayerTalentFrame.advisorbutton then
		PlayerTalentFrame.advisorbutton:SetButtonState("NORMAL")
	end
	PlaySound("igCharacterInfoTab");
end

function ZygorTalentAdvisorPopout_OnUpdate(self)
	--if self.needsResizing>0 then self.needsResizing=self.needsResizing-1 end

	if self.needsResizing and self.needsResizing>0 then
		ZTA:Debug("resizing")
		if self.scroll.child.group1:GetTop() and not self.glyphmode then 
			local height = self.scroll.child.group1:GetTop() - self.scroll.child.talents3:GetBottom()
			local maxheight=100
			local minheight=50
			if height>maxheight then height=maxheight end
			if height<minheight then height=minheight end
			self.scroll.child:SetHeight(height)

			self:SetHeight(height+145)
		else
			self.suggestionLabel:SetSize(230,0)
			self:SetHeight(self.suggestionLabel:GetHeight()+100)
		end

		self.needsResizing=self.needsResizing-1
		ZygorTalentAdvisorPopout_UpdateDocking()
	end
end

function ZygorTalentAdvisorPopout_OnLoad(self)
	self:RegisterForDrag("LeftButton")
	--[[
	ZygorTalentAdvisorPopoutScroll:SetScript("OnScrollRangeChanged",function(self,xrange,yrange)
		ScrollFrame_OnScrollRangeChanged(self, xrange, yrange)
		print(xrange)
		print(yrange)
		local scrollbar = _G[self:GetName().."ScrollBar"];
		local min,max = scrollbar:GetMinMaxValues()
		if max>0 then
			scrollbar:Show()
		else
			scrollbar:Hide()
		end
		print("scrollrangechanged")
	end)
	--]]
end

function ZygorTalentAdvisorPopout_OnDragStart(self)
	ZTA.db.profile.windowdocked = false
	--ZygorTalentAdvisorPopout_Reparent()
	ZygorTalentAdvisorPopout_UpdateDocking(false)
	self:ClearAllPoints()
	self:StartMoving()
	self.moving=true
	--print("dragstart")
end

function ZygorTalentAdvisorPopout_OnDragStop(self)
	--print("dragstop")
	self:StopMovingOrSizing()
	self.moving=nil
	--	((self:GetLeft()>PlayerTalentFrame:GetLeft() and self:GetLeft()-PlayerTalentFrame:GetRight()+42<20 and abs(self:GetTop()-PlayerTalentFrame:GetTop()+10)<20 then
	if PlayerTalentFrame and PlayerTalentFrame:IsShown()
	and abs(self:GetLeft()-PlayerTalentFrame:GetRight()+6)<20
	and self:GetTop()-PlayerTalentFrame:GetTop()<20
	and self:GetTop()-PlayerTalentFrame:GetTop()>-200
	then
		ZTA.db.profile.windowdocked = true
	else
		ZTA.db.profile.windowdocked = false
	end
	ZygorTalentAdvisorPopout_Reparent()
	ZygorTalentAdvisorPopout_UpdateDocking()
end

function ZygorTalentAdvisorPopout_Update()
	local self=ZygorTalentAdvisorPopout

	if not self:IsShown() then
		ZygorTalentAdvisor:Debug("popout hidden, not updating")
		return
	end

	ZygorTalentAdvisor:Debug("about to update")

	-- Prepare basic data: are we handling glyphs? are we viewing the pet?
	
	self.glyphmode = GlyphFrame and GlyphFrame:IsShown()
	self.pet = PlayerTalentFrame and PlayerTalentFrame.pet
	local pet = self.pet

	local who=who(pet)

	self.buildLabel:SetText(L['window_header_buildlabel'])  -- "Build: "


	-- Obtain suggestion status code

	local build = ZTA.currentBuild[who]
	local buildtitle = build and build.title
	local suggestion = build and build.suggestion

	local glyphtext
	local code
	if self.glyphmode then
		glyphtext,code = ZTA:GetGlyphSuggestions()
	else
		code = (build and build.ready and build.colorcode) or "BLACK"
	end

	-- Use the code (no matter what we're handling).
	local codecolors = {GREEN={0,1,1},YELLOW={0.8,1,1},ORANGE={1,0.6,0},RED={1,0,0},BLACK={0,0.5,0}}
	if codecolors[code] then
		self.warning:Show()
		self.warning:GetRegions():SetVertexColor(unpack(codecolors[code]))
	else
		self.warning:Hide()
	end


	local tabn = 1
	if not build then
		--s=L['error_bulklearn_nobuild']
		self.build:SetText(L['window_header_buildnone'])
		if pet and ZTA:IsPetNew() then
			self.suggestionLabel:SetText(L['opt_pet_new'])
		else
			self.suggestionLabel:SetText(L['window_suggestion_nobuild'])
		end
		self.scroll:Hide()
		self.preview:Hide()
		self.accept:Hide()
		--if ZTA.status[who].code then self.warning:Show() else self.warning:Hide() end
	else
		--build:Update()

		self.build:SetText(L['window_header_build']:format(buildtitle))

		if not pet and PlayerTalentFrame.talentGroup~=GetActiveTalentGroup() then
			-- inactive spec!
			self.suggestionLabel:SetText(L["window_suggestion_inactivespec"])
			self.scroll:Hide()  self.preview:Hide()  self.accept:Hide()  self.warning:Hide()

		-- Displaying suggestion (if any).
		elseif self.glyphmode then
			-- Suggestion for: GLYPHS
			if build.glyphs then
				self.suggestionLabel:SetText(glyphtext)
			else
				self.suggestionLabel:SetText("This build makes no glyph suggestions.")
			end
			self.scroll:Hide()  self.preview:Hide()  self.accept:Hide()  self.warning:Hide()
		elseif not suggestion or #suggestion==0 then
			if code=="BLACK" then
				self.suggestionLabel:SetText(build:GetStatusMessage())
			elseif code=="RED" then
				self.suggestionLabel:SetText(L['window_suggestion_none'])
			else
				self.suggestionLabel:SetText(L['window_suggestion_nopoints'])
			end
			self.scroll:Hide()
			self.preview:Hide()
			self.accept:Hide()
		else
			self.suggestionLabel:SetText(L['window_suggestion_normal'])

			local sugformatted = ZTA:GetSuggestionFormatted(pet)
			
			self.sugheight = 0
			for tab,talents in pairs(sugformatted) do
				if pet then
					self.scroll.child['group'..tabn]:Hide()
					self.scroll.child['group'..tabn]:SetHeight(1)
				else
					self.scroll.child['group'..tabn]:SetText(tab)
					self.scroll.child['group'..tabn]:SetHeight(20)
					self.scroll.child['group'..tabn]:Show()
				end
				local s = ""
				for n,levels in ipairs(talents) do
					talent = "|T"..levels.tex..":0:0:0:0|t "..(levels.name or "?")
					if #s>0 then s=s.."\n" end
					if levels[1]==0 then
						s=s..talent
					else
						s=s..talent.." |cff997700("
						if #levels<3 then s=s..table.concat(levels,",") else s=s..levels[1].."-"..levels[#levels] end
						s=s..")|r"
					end
				end
				self.scroll.child['talents'..tabn]:SetText(s)
				tabn=tabn+1
				if tabn>3 then break end
			end

			self.accept:Show()
			self.accept:SetText(ACCEPT)

			self.preview:SetText(L['preview_button'])

			self.scroll:Show()
			self.preview:Show()
		end
	end

	-- clear remaining suggestion group headers and talents
	while tabn<=3 do
		self.scroll.child['group'..tabn]:SetText("")
		self.scroll.child['group'..tabn]:SetHeight(0)
		self.scroll.child['talents'..tabn]:SetText("")
		self.scroll.child['talents'..tabn]:SetHeight(0)
		tabn=tabn+1
	end

	self.configure:SetText(L['configure_button'])
	self.needsResizing=2
end

function ZygorTalentAdvisorPopout_Hook()
	ZygorTalentAdvisorPopout_UpdateDocking()
end

function ZygorTalentAdvisorPopout_UndockWhenTalentsHide()
	local self=ZygorTalentAdvisorPopout

	-- Make sure popout undocks when dragged AND docked when talent frame closes.
	if self.moving and self:GetParent()==PlayerTalentFrame then
		ZTA.db.profile.windowdocked = false
		ZygorTalentAdvisorPopout_Reparent()
		ZygorTalentAdvisorPopout_UpdateDocking()
		self.moving=false
		self:StopMovingOrSizing()
		self:Show()
	end

	--[[
	if self.popout:IsShown() then
		PlayerTalentFrame.advisorbutton:SetButtonState("PUSHED",1)
	else
		PlayerTalentFrame.advisorbutton:SetButtonState("NORMAL")
	end
	--]]

	--[[
	for i=1,MAX_NUM_TALENTS do
		_G['PlayerTalentFrameTalent'..i]:SetScript("OnClick",ZygorTalentAdvisor_PlayerTalentFrameTalent_OnClick)
	end
	--]]

	--[[
	if not self.hookedreset then
		self.hookedreset=true
		--self:Debug("hooked")
	end
	if PlayerTalentFrame and PlayerTalentFrame:IsVisible() then
		self:UpdateSuggestions(PlayerTalentFrame.pet)
	end
	--]]
end

function ZygorTalentAdvisorPopout_UpdateDocking()
	local self=ZygorTalentAdvisorPopout

	if PlayerTalentFrame.advisorbutton then
		if ZTA.db.profile.windowdocked and self:IsShown() then
			--PlayerSpecTab1:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPRIGHT",ZygorTalentAdvisorPopout:GetWidth()-8,-36)
			PlayerTalentFrame.advisorbutton:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPRIGHT",ZygorTalentAdvisorPopout:GetWidth()-10,-140)
		else
			--PlayerSpecTab1:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPRIGHT",0,-36)
			PlayerTalentFrame.advisorbutton:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPRIGHT",-2,-140)
		end
	end

	if ZTA.db.profile.windowdocked then
		self.TopRight:SetTexture([[Interface\Addons\ZygorTalentAdvisor\Skin\popout-noclose]])
		self.TopRight:SetTexCoord(0,1,0,1)
		self.CloseButton:Hide()
	else
		self.TopRight:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
		self.TopRight:SetTexCoord(0.625,0.75,0,1)
		self.CloseButton:Show()
	end
end

function ZygorTalentAdvisorPopout_Reparent()
	local self=ZygorTalentAdvisorPopout
	if ZTA.db.profile.windowdocked then
		self:SetParent(PlayerTalentFrame)
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPRIGHT",-6,-130)
	else
		self:SetParent(UIParent)
	end
end

function ZygorTalentAdvisorPopout_Popout()
	TalentFrame_LoadUI()
	if not PlayerTalentFrame:IsShown() and ZygorTalentAdvisor.db.profile.windowdocked then
		ShowUIPanel(PlayerTalentFrame)
	end
	ZygorTalentAdvisorPopout:Show()
end