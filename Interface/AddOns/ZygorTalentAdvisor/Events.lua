local ZTA=ZygorTalentAdvisor
if not ZTA then return end

function ZTA:RegisterEvents()
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("PLAYER_ALIVE")
	self:RegisterEvent("PLAYER_TALENT_UPDATE")
	self:RegisterEvent("UNIT_PET")
	self:RegisterEvent("PET_TALENT_UPDATE")
	self:RegisterEvent("UNIT_MODEL_CHANGED")
	self:RegisterEvent("CHARACTER_POINTS_CHANGED")
	self:RegisterEvent("PREVIEW_TALENT_PRIMARY_TREE_CHANGED")
	self:RegisterEvent("USE_GLYPH")
end

function ZTA:CHAT_MSG_SYSTEM(event,text)
	--[[
	if string.match(text,L['pattern_talentgained_pet']) then
		self:OnNewTalents(true)
	end
	--]]
	--[[
	if string.match(text,L['pattern_talentgained']) then
		self:OnNewTalents(false)
	end
	--]]
end

function ZTA:PLAYER_ALIVE()
	-- fires when talents are available
	self:Debug("PLAYER_ALIVE")
	self:LoadBuilds()
	--self:PruneRegisteredBuilds()
end

function ZTA:PLAYER_TALENT_UPDATE(_,a)
	self:Debug("PLAYER_TALENT_UPDATE")
	--self:OnNewTalents()
	self:LoadBuilds()
end

function ZTA:UNIT_PET(_,owner)
	if (owner~="player") then return end -- foreign pets ignored
	local id,_,_,_,_,pettype_en = GetTalentTabInfo(1,false,true)
	if pettype_en then local pettype_en2=pettype_en:upper():match("HUNTERPET(.+)") pettype_en=pettype_en2 or pettype_en end
	local talentsready = GetTalentInfo(1,1,false,true)
	self:DebugPush(("UNIT_PET %s (type %s, talents %s, points %d)"):format(tostring(owner), tostring(pettype_en), talentsready and "ready" or "not ready", GetUnspentTalentPoints(false,true)))
	if pettype_en~=self.oldpettype and not (pettype_en and not talentsready) then
		self.oldpettype=pettype_en
		self:LoadBuilds(true)
		--[[ -- we don't want to auto-fit new pets, now do we..?
		if self.currentBuild['pet'] and GetUnspentTalentPoints(false,true)>0 then
			self:OnNewTalents(true)
		end
		--]]
	end
	self:DebugPop()
end

function ZTA:PET_TALENT_UPDATE(_)
	local talentsready = GetTalentInfo(1,1,false,true)
	self:DebugPush(("PET_TALENT_UPDATE (points: %d, talents %s)"):format(GetUnspentTalentPoints(false,true), talentsready and "ready" or "not ready"))
	--local build = self.currentBuild.pet
	--if not build then self:DebugPop("No pet build") return nil end
	if talentsready then
		self:LoadBuilds(true)
		if self.currentBuild.pet and GetUnspentTalentPoints(false,true)>0 then
			self:OnNewTalents(true)
		end
		self:UpdateBuild(true)
		ZygorTalentAdvisorPopout_Update(false)
	end
	self:DebugPop()
end

function ZTA:UNIT_MODEL_CHANGED(_,unit)
	-- update pet suggestions when pet model changes. Just in case.
	if (unit~="pet") then return end
	self:UpdateBuild(true)
	ZygorTalentAdvisorPopout_Update()
end

function ZTA:CHARACTER_POINTS_CHANGED(_,delta)
	self:Debug("CHARACTER_POINTS_CHANGED "..tostring(delta))
	if (delta>0) then self:OnNewTalents() end
    
	-- process the bulklearning 'queue': learn the first talent from the start of the suggestion, and wait for the next point change event. Stop when suggestion empty.
	if self.bulklearning and delta<0 then
		local build = self.currentBuild['player']
		local suggestion = build and build.suggestion
		if build and suggestion then
			self:UpdateBuild(false)
			if #suggestion>0 then
				local name=GetTalentInfo(suggestion[1].tab,suggestion[1].talent,false,false)
				self:Print(L['msg_learned']:format(name))
				Old_LearnTalent(suggestion[1].tab,suggestion[1].talent,false,false)
			else
				self.bulklearning=nil
				self:Print("Learned all.")
			end
		end
	end
	self:UpdateBuild(false)
	ZygorTalentAdvisorPopout_Update()
end

function ZTA:PREVIEW_TALENT_PRIMARY_TREE_CHANGED()
	self:UpdateBuild(false)
	ZygorTalentAdvisorPopout_Update()
end

function ZTA:USE_GLYPH()
	self:UpdateBuild(false)
	ZygorTalentAdvisorPopout_Update()
end
