local ZTA=ZygorTalentAdvisor
if not ZTA then return end

local L = ZTA.L

function ZTA:RequestGlyphReqLevel(glyph)
	-- If the glyph data already has a level, skip
	if not glyph.level then
		local _,uc=UnitClass("player")
		local itemid=ZTA.GlyphsToItemIDs[uc][glyph.name]
		if not itemid then
			if ZGV then
				ZGV:Debug("Database incomplete, missing item id for "..glyph.name)
			end
			return
		end
		local _,_,_,_,lev=GetItemInfo(itemid)
		if lev then -- Hooray, we've found it	
			glyph.level=lev
		else -- No data yet, let's wait 2 second
			self:ScheduleTimer(function() self:RequestGlyphReqLevel(glyph) end, 2)
		end
	end 
end

function ZTA:CacheGlyphData()
	self.glyphData={}
	if not GlyphFrame then return end

	-- save available glyphs in self.glyphData

	for i=1,50 do
		local name,gtype,avail,icon,glyphID,link = GetGlyphInfo(i)
		if name and name~="header" then
			local fullname = link:match("%[(.*)%]")
			local glyph = {name=name,fullname=fullname,gtype=gtype,avail=avail,icon=icon,glyphID=glyphID}
			self.glyphData[glyphID] = glyph   -- for build-to-available matching
			self.glyphData[fullname] = glyph	-- for current-to-available matching
			-- Well, that's noice, but let's ask the game the level requirement of this glyph
			self:RequestGlyphReqLevel(glyph)
		end
	end

	-- cross-check with glyph slots, mark as inscribed.

	for socket=1,NUM_GLYPH_SLOTS do
		local enabled, glyphType, glyphTooltip, glyphSpell, icon = GetGlyphSocketInfo(socket)
		if glyphSpell then
			local spellname = GetSpellInfo(glyphSpell)	assert(spellname,"Glyph "..glyphSpell.." has bad spell??")
			local glyph = self.glyphData[spellname]  -- fullname, indexed above.
			if glyph then
				glyph.inscribed = socket
				--glyph.spellID = glyphSpell
				self.glyphData[glyphSpell] = glyph  -- yet another index. Fun!
			end
		end
	end
end

local socketinfo_to_glyphinfo = {2,3,1}
function ZTA:GetGlyphSuggestions()
	local glyphs = self.currentBuild.player and self.currentBuild.player.glyphs

	if not glyphs or #glyphs==0 then return FALSE,"BLACK" end

	local numOK=0
	local numEmpty=0
	local numLocked=0
	local sug=L['glyphsug_title']

	self:CacheGlyphData()

	local gtsuf = { [1]="("..L.glyphtype_0..")",
		        [2]="("..L.glyphtype_1..")",
		        [3]="("..L.glyphtype_2..")" }

	--local level = UnitLevel("player")
	--local numunlocks = (level>=75 and 2 or level>=50 and 2 or 1)

	for _,gid in ipairs(glyphs) do
		local glyph = self.glyphData[gid]

		if glyph then
			glyph.suggested = true
		else
			sug=sug.."\n|cffff0088ERROR: Unknown glyph id '"..gid.."' in build!|r"
		end
	end
	
	-- calculate free/freeable sockets

	local sockets = {0,0,0}
	for socket=1,NUM_GLYPH_SLOTS do
		local enabled, glyphType, glyphTooltip, glyphSpell, icon = GetGlyphSocketInfo(socket)
		glyphType=socketinfo_to_glyphinfo[glyphType]
		if enabled then sockets[glyphType]=sockets[glyphType]+1 end
		if glyphSpell then
			if self.glyphData[glyphSpell] and self.glyphData[glyphSpell].suggested then
				numOK = numOK + 1
				sockets[glyphType]=sockets[glyphType]-1
			end  -- ignore the socket, it's good already
		else
			if enabled then numEmpty=numEmpty+1 else numLocked=numLocked+1 end
		end
	end
	ZTA:Debug("sockets available: "..sockets[1]..","..sockets[2]..","..sockets[3])


	-- multiple passes, to have everything in proper order

	local futuresug=""
	local futuresug2=""

	for name,glyph in pairs(self.glyphData) do if type(name)=="string" then
		if not glyph.avail and glyph.suggested then
			local s="\n|cffff8800Learn and inscribe: ".. glyph.name .." ".. gtsuf[glyph.gtype] .."|r"
			if sockets[glyph.gtype]>0 then
				if UnitLevel("player")>=(glyph.level or 1) then
					sug=sug..s
					sockets[glyph.gtype]=sockets[glyph.gtype]-1
				else
					futuresug2=futuresug2..s
				end
			else
				futuresug=futuresug..s
			end
		end
	end end
	for name,glyph in pairs(self.glyphData) do if type(name)=="string" then
		if glyph.inscribed and not glyph.suggested then
			sug=sug.."\n|cffff0000Clear: "..glyph.name.." "..gtsuf[glyph.gtype].."|r"
		end
	end end
	for name,glyph in pairs(self.glyphData) do if type(name)=="string" then
		if glyph.suggested and glyph.avail and not glyph.inscribed then
			local s="\n|cffffff00Inscribe: "..glyph.name.." "..gtsuf[glyph.gtype].."|r"
			if sockets[glyph.gtype]>0 then
				if UnitLevel("player")>=(glyph.level or 1) then
					sug=sug..s
					sockets[glyph.gtype]=sockets[glyph.gtype]-1
				else
					futuresug2=futuresug2..s
				end
			else
				futuresug=futuresug..s
			end
		end
	end end
	for name,glyph in pairs(self.glyphData) do if type(name)=="string" then
		if glyph.suggested and glyph.inscribed then
			sug=sug.."\n|cff00ff00Good: "..glyph.name.." "..gtsuf[glyph.gtype].."|r"
		end
	end end

	if #futuresug>0 then
		sug = sug.."\n\nWhen you unlock more sockets:"..futuresug
	end
	if #futuresug2>0 then
		sug = sug.."\n\nWhen you advance enough levels:"..futuresug2
	end

	-- count empties/locks

	local missing=#glyphs-numOK
	local code
	
	self:Debug(("missing %s, numEmpty %s, numLocked %s"):format(missing,numEmpty,numLocked))

	if numOK==#glyphs then code="GOLD"  -- all OK
	 elseif missing<=numEmpty then code="GREEN"  -- just inscribe
	 elseif missing<=numEmpty+numLocked then code="YELLOW"  -- cool, just need to level more
	 else code="ORANGE"  -- needs wiping
	end

	return sug,code
end


