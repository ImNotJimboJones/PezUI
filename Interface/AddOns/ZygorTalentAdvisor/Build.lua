local ZTA=ZygorTalentAdvisor
if not ZTA then return end

local L = ZTA.L

local Build = {}

local table,tinsert,string,tonumber,ipairs,pairs,setmetatable = table,tinsert,string,tonumber,ipairs,pairs,setmetatable

ZTA.BuildProto = Build
local BuildProto_mt = { __index=Build }


local function who(pet)  return pet and 'pet' or 'player'  end


function ZTA:RegisterBuild (class,title,build,glyphs)
	local build = self.BuildProto:New(class,title,build,glyphs)
	if build then self.registeredBuilds[build.key] = build end
end

--static
function Build:New (class,title,raw,glyphsraw)
	local build = {
		class=class,
		pet=nil, -- might 
		title=title,
		raw=raw,  -- "source code" that gets parsed
		glyphsraw=glyphsraw,  -- optional
		key=class .." ".. title,  -- kinda redundant here, but strings are internalized, so why not.

		ready=false,  -- parsed or not?
		status_real = {colorcode="?"},  -- 
		status_preview = {colorcode="?"},

		suggestion = {},
		--suggestion_preview = {}
	}
	setmetatable(build,BuildProto_mt)
	local pet = class:match("^PET (.+)")
	if pet then build.pet=pet:upper() build.class=nil end
	return build
end

--[[
Okay, here's how it works.

When a build is registered, it isn't even .parsed .
Upon build:Parse(), the build is definitely .parsed , but might become .broken . If that happens, it's never re-checked. Also, .error should indicate what's wrong.

When build:CheckIfUsable() is called, it first :Parse()s the build (just in case), and tries to see if the build can be used at all now (pet checks etc.). If not, the build is marked as not .usable .

If it's .usable , it can be used for suggestions.
--]]


-- input: blizzard build (00042130423029181092102120123010)
-- output: ready build.
local function ParseBlizzard(bliz,pet)
	ZTA:Debug("Parsing Blizzard build")
	local build = {}

	for tab,talent in ZTA_talentpairs(false,pet) do
		if #bliz==0 then break end
		local rank = tonumber(strsub(bliz,1,1))
		bliz = strsub(bliz,2)
		for i=1,rank do table.insert(build,{tab,talent}) end
	end

	return build,#build<1 and "badblizzard"
end

-- input: pure text build, line by line.
-- output: table build, spec
local function ParseLinesToTable(text,multi)
	local table={}
	text = text .. "\n"
	local spec
	for line in text:gmatch("([^\n]+)\n") do
		line = line:gsub("%s*//.*$","")
		line = line:gsub("^%s+","")
		line = line:gsub("%s+$","")
		line = line:gsub("/%d","")

		-- we should have lines like "Talent" or "5 Talent" now

		if line:find("spec=") then
			spec=line:match("spec=(.+)")
		else
			local co,ln = line:match("(%d+)%s+(.-)$")
			local count=1
			if co then
				count=tonumber(co)
				line=ln
			end
			if (#line>0) then
				for i=1,count do tinsert(table,line) end
			end
		end
	end
	return table,spec,#table<1 and "badtable"
end

do --unittest
	local tab=ParseLinesToTable([[
		2/2   Test Talent   // qwe
	]],true)
	assert(type(tab)=="table","ParseLinesToTable fault 1")
	assert(#tab==2,"ParseLinesToTable fault 2")
	assert(type(tab[1])=="string","ParseLinesToTable fault 3")
	assert(tab[1]=="Test Talent","ParseLinesToTable fault 4")
	assert(tab[2]=="Test Talent","ParseLinesToTable fault 5")
end

local function ParseTableTalents(tabletalents,pet,class)
	-- ASSUMING we've got a good pet or good class here.

	-- lookup = Create a spell-to-talenttab lookup table, to be able to check if player/pet.
	-- Serves as a "DoesPlayerHaveTalent(id)". Needed, since pet talents change. Might do caching... some time.

	local lookup = {}
	local link,id
	local count=0
	for tab,talent in ZTA_talentpairs(false,not not pet) do
		link = GetTalentLink(tab,talent,false,not not pet)
		if link then
			id = tonumber(link:match("talent:(%d+):"))
			lookup[id]={tab,talent}
			count=count+1
		end
	end
	ZTA.LASTLOOKUP=lookup

	if count==0 then
		ZTA:Debug("errnotalents")
		return false,nil,"errnotalents",{"Unable to access talent info, wtf"}
	end

	ZTA:Debug(count.." talents cached for lookup. Pet=".. tostring(pet)..", class=".. tostring(class))

	-- Verify if player/pet has all the named talents.
	-- To do that, look up spell IDs gathered above and check if they have them or not.

	local talentset = ZTA.TalentsToNumbers[pet or class]
	if not talentset then
		ZTA:Debug("errbadclass "..(pet or class))
		return false,nil,"errbadclass",{"Unknown pet/class '"..(pet or class).."' in Build:Compile"}
	end

	local build = {}
	local spec

	local a,b
	for li,line in ipairs(tabletalents) do
		a=talentset[line]
		--b=b and talentset[b]

		-- now a,b contain talent numbers... or arrays, if talent names are ambiguous (like Mobility).
		if type(a)=="table" then a,b=unpack(a) end  -- problem solved.

		if not a and not b then
			ZTA:Debug("errbadtalent "..li..":"..line)
			return false,nil,"errbadtalent",{"Unknown talent(s): '"..line.."' at line "..li.."."}
		end

		local l = lookup[a] or lookup[b]
		if l then
			table.insert(build,{l[1],l[2]}) -- COPY lookup, don't reuse the same object ffs
			spec = spec or l[1]
		else
			ZTA:Debug("errbadtalent2 "..line..":"..tostring(a).." or "..tostring(b))
			return false,nil,"errbadtalent2",{"Unknown talent spell(s): '"..line.."' is "..tostring(a).." or "..tostring(b).." at line "..li.."."}
		end
	end
	ZTA:Debug("Parsed talents, OK")
	if pet then
		return build
	else
		return build,spec
	end
end



function Build:DoesClassPetMatch()
	if self.pet then
		local _,petloc,_,_,_,pettype = GetTalentTabInfo(1,false,true)
		if pettype then pettype=pettype:upper():match("HUNTERPET(.+)") end
		if not pettype then
			ZTA:Debug("nopet")
			return false,"nopet"
		elseif pettype~=self.pet then
			local petname = UnitName("pet") or "unnamed_pet"
			ZTA:Debug("badpet; current pet is ".. tostring(petname) .." (".. tostring(pettype) .."), wrong build pettype: ".. tostring(self.pet))
			return false,"badpet",{petname,petloc,self.pet}
		end
	else
		local _,class = UnitClass("player")
		if class~=self.class then
			ZTA:Debug("badclass, wtf??")
			return false,"badclass" --WTF? shouldn't happen, should've been pruned!
		end

		local talready = GetTalentInfo(1,1,false,false)
		if not talready then
			ZTA:Debug("notalents")
			return false,"notalents" -- not ready yet?
		end

		-- TODO: move this outta here.
		--[[
		if PlayerTalentFrame and PlayerTalentFrame.talentGroup~=GetActiveTalentGroup() then
			-- inactive spec!
			ZTA:Debug("inactivespec")
			return false,"inactivespec"
		end
		--]]

		-- works only if the spec has already been verified.
		local currentspec = GetPrimaryTalentTree() or GetPreviewPrimaryTalentTree()
		if self.spec and currentspec and currentspec~=self.spec then
			ZTA:Debug("badspec; expected "..select(2,GetTalentTabInfo(self.spec,false,false))..", got ".. select(2,GetTalentTabInfo(currentspec)))
			return false,"badspec",{select(2,GetTalentTabInfo(self.spec,false,false)),select(2,GetTalentTabInfo(currentspec))}
		end
	end
	ZTA:Debug("Matching ".. (self.pet or self.class))
	return true
end


function Build:Parse()
	-- start with pessimism
	self.ready = false

	TalentFrame_LoadUI()

	-- first, check class/pet. Wrong? Bail.
	local match
	match,self.errorcode,self.errordata = self:DoesClassPetMatch()
	if not match then return false end

	-- class/pet matches, talents are accessible. May be bad spec, though.

	ZTA:Debug("Parsing build '"..self.title.."', pet="..tostring(self.pet))

	if type(self.raw)=="string" then
		-- one string? blizzard (rare) or text (most common).
		if (self.raw:find("^%d+$")) then
			-- numbers; Blizzard format
			self.build,self.errorcode = ParseBlizzard(self.raw,self.pet)
			if not self.build then
				ZTA:Debug("Failed to parse Blizzard format. NOT ready.")
				return false
			end
		else
			-- text; text lines format
			tabletalents,self.spec,self.errorcode,self.errordata = ParseLinesToTable(self.raw,self.pet)
			if not tabletalents then
				ZTA:Debug("Failed to parse plain text format into a table. NOT ready.")
				return false
			end

			self.raw = tabletalents
		end
	end
	if type(self.raw)=="table" and type(self.raw[1])=="string" then  -- well not so raw anymore, but still juicy.
		self.build,self.spec,self.errorcode,self.errordata = ParseTableTalents(self.raw,self.pet,self.class)
		if not self.build then
			ZTA:Debug("Failed to parse table into talents. NOT ready.")
			return false
		end
	end

	if type(self.build)~="table" or type(self.build[1])~="table" then
		ZTA:Debug("WTF happened here..? How did this get through? NOT ready.")
		self.errorcode = "wtf1"
		return false
	end

	-- we have .build at this point, with proper talents in it.

	ZTA:Debug("Data OK, cool")

	local _,maxcounts = ZTA:CountBuildTalents(nil,self.build)
	for tab,talents in ipairs(maxcounts) do
		for talent,count in ipairs(talents) do
			local name,_,_,_,realrank,maxrank,available,rank = GetTalentInfo(tab,talent,false,pet)
			if name and maxrank<count then
				self.errorcode="builderror"
				self.errordata={count,name,maxrank}
				ZTA:Debug("Build error: talent "..name.." has max rank "..maxrank..", but "..count.." points requested. NOT ready.")
				return false
			end
		end
	end
	
-- 	local talentsspent = ZTA:GetTalentsSpent(not not self.pet)
-- 	local count = #self.build
-- 	if count<talentsspent then
-- 		-- oh bummer.
-- 		self.errorcode = "smallbuild"
-- 		self.errordata = {count,talentsspent}
-- 		ZTA:Debug("Build is too small")
-- 		return false
-- 	elseif count==talentsspent then
-- 		-- complete or altogether different
-- 		local alltaken=true
-- 		for i=1,#self.build do
-- 			if not self.build[i].taken then alltaken=false break end
-- 		end
-- 		if alltaken then
-- 			self.errorcode="complete"
-- 			self.errordata={count,talentsspent}
-- 			ZTA:Debug("Build is complete. NOT ready.")
-- 			return false
-- 		else
-- 			self.errorcode="different"
-- 			self.errordata={count,talentsspent}
-- 			ZTA:Debug("Build is complete, just different. NOT ready.")
-- 			return false
-- 		end
-- 	end

	-- Build is parsed, so we can check the spec.
	if self.spec then
		local currentspec = GetPrimaryTalentTree() or GetPreviewPrimaryTalentTree()
		if currentspec and currentspec~=self.spec then
			ZTA:Debug("badspec; expected "..select(2,GetTalentTabInfo(self.spec,false,false))..", got ".. select(2,GetTalentTabInfo(currentspec)))
			self.errorcode="badspec"
			self.errordata={select(2,GetTalentTabInfo(self.spec,false,false)),select(2,GetTalentTabInfo(currentspec))}
			return false
		end
	end



	-- yippee, talents counted and working fine!

	-- now, glyphs!
	if self.glyphsraw then
		self.glyphs = ParseLinesToTable(self.glyphsraw) --enough to have them stored in a table..? Nah.
		self:ParseGlyphs()  -- that's the spirit.
		if not self.glyphs or #self.glyphs==0 then
			ZTA:Debug("Failed to parse glyphs!")
		end
	end

	ZTA:Debug("Build seems properly parsed. READY.")
	self.ready = true

	return true
end


local glyphs_pruned=nil

-- Dump glyph ID numbers for GlyphsToNumbers. Run manually.
function ZTA:DumpGlyphIDs()
	local s = ""
	local _,myclass
	local glyphs={}
	_,myclass = UnitClass("player")

	s = "	[\"".. myclass:upper() .."\"]={\n"
	for i=1,60 do
		local name,gtype,avail,icon,glyphID,link = GetGlyphInfo(i)
		if name and name~="header" then
			--name = link:match("%[(.*)%]")
			s = s .. "		[\""..name.."\"]="..glyphID..",\n"
		end
	end
	s = s .. "	},\n"

	if ZGV and ZGV.ShowDump then
		ZGV:ShowDump(s,"Glyph data:")
	else
		print(s)
	end
end

-- Try to dump glyph item ID numbers
-- WARNING: Never use it at home, it will cache a big chunk of the database and probably kill your dog as well
-- Setting the second parameter to true requests immediate report
-- Also, make sure you're using an English client
function ZTA:DumpGlyphItemIDs(cache,report)
	local cache=cache or {}
	local FIRST=40000
	local LAST=80000 -- I suppose...
	
	-- Iterate over the region the glyph items are supposed to live in
	for i=FIRST,LAST do -- TODO quite a hardcode, also, hardcore
		if not cache[i] then
			local name,_,_,_,lev,tp,class=GetItemInfo(i)
			if name then
				if tp=="Glyph" then -- our client here
					cache[i]={name=name,lev=lev,tp=tp,class=class,itemid=i} -- TODO unlocalize
				else
					cache[i]=true -- it's cached, but not a glyph
				end
			end
		end
	end
	
	if not report then
		-- My logic is the following: the next frame will only be rendered when the client unfreezes, therefore
		-- all the items should be received by then.
		self:ScheduleTimer(function() self:DumpGlyphItemIDs(cache,true) end,1) 
	else
		-- TODO this is UGLY 
		-- Reverse class name lookup
		local classes = {}
		FillLocalizedClassList(classes)
		for k,v in pairs(classes) do
			classes[v]=k
		end
		
		local byclass = {} 
		
		-- Right, that's a report time now
		for k,v in pairs(cache) do
			if type(v)=="table" then
				if not byclass[classes[v.class]] then 
					byclass[classes[v.class]]={}
				end
				table.insert(byclass[classes[v.class]],v)
			end
		end
		
		s="ZTA.GlyphsToItemIDs = {\n"
		for k,v in pairs(byclass) do
			s=s.."	[\""..k.."\"]={\n"
			for kk,vv in pairs(v) do
				s=s.."		[\""..(vv.name:match("Glyph of the (.*)") or vv.name:match("Glyph of (.*)")).."\"]="..vv.itemid..",\n"
			end
			s=s.."	},\n"
		end
		s=s.."}\n"
		
		if ZGV and ZGV.ShowDump then
			ZGV:ShowDump(s,"Glyph data:")
		else
			print(s)
		end
	end
end

function Build:ParseGlyphs()
	-- prune glyph numbers, for starters.
	if not glyphs_pruned then
		_,myclass = UnitClass("player")
		ZTA.GlyphsToNumbers = ZTA.GlyphsToNumbers[myclass:upper()]
		glyphs_pruned=true
	end

	local names = self.glyphs
	self.glyphs={}
	for gi,gn in ipairs(names) do
		gn = gn:match("lyph of (.*)") or gn
		local gid = ZTA.GlyphsToNumbers[gn]
		if gid then
			tinsert(self.glyphs,gid)
		else
			ZTA:Print("Unknown glyph in build: "..gn)
		end
	end
end


---
-- Go through the build and mark off talents as taken and/or previewed.  (A build with all talents taken is "complete", of course.)
-- Fail (set .realfail or .previewfail) if 
-- @return nil
--
function Build:MarkTaken()
    
	local build = self.build
	for n=1,#build do build[n].taken=nil build[n].preview=nil end

	self.status_real.fail=nil
	self.status_preview.fail=nil

	-- Go through the talents in all tabs. For each talent, find its each
	for tab,talent in ZTA_talentpairs(false,not not self.pet) do
		local name,_,_,_,realrank,maxrank,available,previewrank = GetTalentInfo(tab,talent,false,not not self.pet)
		if name then
			for i=1,previewrank do  -- previewrank is always >= realrank, so going up to previewrank is like going to realrank AND extending to previewrank.
				local found
				for n=1,#build do
					if build[n][1]==tab and build[n][2]==talent and not build[n].taken and not build[n].preview then
						--ZTA:Debug(tab..","..talent.." ".."build#"..n.." "..((i>realrank)and"preview"or"taken"))
						if i>realrank then -- marking as prev-taken
							build[n].preview=true
							--ZTA:Debug(("build[%d] preview (rank %d, real %d)"):format(n,i,realrank))
						else
							build[n].taken=true
							--ZTA:Debug(("build[%d] taken (rank %d, real %d)"):format(n,i,realrank))
						end
						found=true
						break
					end
				end
				if not found then
					-- okay, we have a situation here: talent taken but missing in the build.
					-- Now, is it a real problem, or just a preview fuckup?
					if i<=realrank then
						self.status_real.fail=true
					else
						self.status_preview.fail=true
					end
					break
				end
			end
		end
		-- if self.status_real.fail then break end    -- does this break red builds?
        -- yeah it does, let the statistic be objective and mark all talents regardless of status. ~aprotas
	end

	self.status_real.last = 0
	self.status_preview.last = 0
	self.status_real.missed = 0
	self.status_preview.missed = 0

	-- find the index of the last taken talent in the build plan
	-- this helps both the real and preview checks

	for n=1,#build do
		if build[n].taken then self.status_real.last=n end
		if build[n].preview or build[n].taken then self.status_preview.last=n end
	end
    
	-- If there was a fail, then don't bother to calculate the misses; nobody cares.
	if self.status_real.fail then
		self.status_preview.fail=true
		ZTA:Debug("REAL FAIL. Preview FAIL obvious.")
		return
	end

	-- calculate missed talents. No point in pointing them out, a count is enough.
	for n=1,self.status_real.last do if not build[n].taken then self.status_real.missed=self.status_real.missed+1 end end
	if not self.status_preview.fail then
		for n=1,self.status_preview.last do if not build[n].taken and not build[n].preview then self.status_preview.missed=self.status_preview.missed+1 end end
	end
	
	-- Pet time
	-- If the user tries a BM build for a non-BM char, we should at least not say he's doing it right
	local MAX_NOT_BM_PET_TALENTS=17 -- WARNING: hardcode
	local tree = GetPrimaryTalentTree() or GetPreviewPrimaryTalentTree()
	local is_bm = tree and (select(6,GetTalentTabInfo(tree))=="HunterBeastMastery")
	local pet_bm = not not self.pet and #build>MAX_NOT_BM_PET_TALENTS
	if self.pet and not is_bm and pet_bm then
		self.status_real.missed=self.status_real.missed+4 -- No fun allowed
		self.status_preview.missed=self.status_preview.missed+4
	end

	ZTA:Debug(("REAL: %s, last %s, missed %s. PREVIEW: %s, last %s, missed %s."):format(self.status_real.fail and "FAIL" or "no fail",self.status_real.last,self.status_real.missed,self.status_preview.fail and "FAIL" or "no fail",self.status_preview.last,self.status_preview.missed))
end


function Build:UpdateStatus()
	-- first, a diagnosis: can this be done at all?
	-- GREEN: we can proceed safely; player's current build is a direct start-based subset of the target build.
	-- YELLOW: we can proceed carefully; player's current build is a subset of the target build, but not start-based, but can be fixed in the remaining points.
	-- ORANGE: minor fuckup; player's current build is a non-start-based subset of the target build and can not be fixed in the remaining points.
	-- RED: major fuckup; player's current build is NOT a subset of the target build.

	ZTA:Debug("Updating status of build")

	self.status_real = {colorcode = "???", pointsleft=0, missed=0}
	self.status_preview = {colorcode = "???", pointsleft=0, missed=0}

	-- ASSUMING the spec is correct, pet type is okay, etc.

	-- To glean that, we need to remove player's current talents from the start of the target build plan, and see what that gives us.
	-- Or at least mark them as taken.

	self:MarkTaken()  -- sets stuff in self.status_real and status_preview

	if not GetPreviewPrimaryTalentTree() and not GetPrimaryTalentTree() then
		ZTA:Debug("No spec yet; GREEN. Not bothering to check anything.")
		self.status_real.colorcode = "GREEN"
		self.status_preview.colorcode = "GREEN"
		return
	end

	self.forced = self.pet and ZTA.db.profile.forcepetbuild or ZTA.db.profile.forcebuild

	if self.status_real.fail then
		ZTA:Debug("Real failed; RED on both. Not bothering to check preview.")
		self.status_real.colorcode = "RED"
		self.status_preview.colorcode = "RED"
		return
	end

	if self.status_preview.fail then
		ZTA:Debug("Preview failed; RED on preview.")
		self.status_preview.colorcode = "RED"
		return
	end

	-- Whew, it's not all RED. Check for early GREEN, then.

	-- if that's equal to the number of the player's talents, we're GREEN. Unless we were RED already, screw it then.
	self.status_real.spent = ZTA:GetTalentsSpent(not not self.pet)
	self.status_preview.spent = self.status_real.spent + GetGroupPreviewTalentPointsSpent(not not self.pet)
	self.status_real.left = GetUnspentTalentPoints(false,not not self.pet)
	self.status_preview.left = self.status_real.left - GetGroupPreviewTalentPointsSpent(not not self.pet)

	ZTA:Debug("Calculating validity: real; spent talents: " .. tostring(self.status_real.spent) .. "  left: " .. tostring(self.status_real.left))
	ZTA:Debug("Calculating validity: preview; spent talents: " .. tostring(self.status_preview.spent) .. "  left: " .. tostring(self.status_preview.left))

	-- Here's how it goes. If what they spent so far is the number of the last talent taken, then they spent exactly how they should have. GREEN.
	-- If the number of the points they have left is more than the talents they missed, it's salvageable right now. YELLOW.
	-- If they missed more than they have left, it's not salvageable for now, but perhaps will be later (it didn't fail into RED, checked already, but we may be forcing this build). ORANGE.

	-- If it's either yellow or orange, we need to know in how many moves the player can reach the true path of enlightenment - that is, the proper build.
	-- Obviously they must've missed some talents and taken others - that's the number they must make up for. And that's just the "missed" value.

	for si,status in ipairs{self.status_real,self.status_preview} do
		if status.spent==status.last and status.missed==0 then
			status.colorcode="GREEN"
		elseif status.left>=status.missed then
			status.colorcode="YELLOW"  -- whew, safe.
		else
			status.colorcode="ORANGE"  -- oh, how sad
		end
	end

	ZTA:Debug("Status for real: ".. self.status_real.colorcode.."; preview: ".. self.status_preview.colorcode ..(self.forced and " (FORCED)" or ""))
end

-- returns REAL status in text form.
function Build:GetStatusMessage(glyphs)
	if glyphs then
		local text,code = ZTA:GetGlyphSuggestions()
		if code=="GREEN" then return L['statusglyph_green']
		elseif code=="YELLOW" then return L['statusglyph_yellow']
		elseif code=="ORANGE" then return L['statusglyph_orange']
		else return "wtf, report this"
		end
	end

	if not self.ready then  return L['status_black_'..(self.errorcode or "?")]:format(unpack(self.errordata or {}))  end

	local status = self.status_real
	if status.colorcode then
		if status.colorcode=="RED" then
		--local _,maxcounts = self:CountBuildTalents(nil,build)
		--local maxcount = maxcounts[tab] and maxcounts[tab][talent] or 0
			if self.forced then
				return L['status_red_forced']
			else
				return L['status_red']
			end
		-- ? L['status_red_forced']
		elseif status.colorcode=="GREEN" then
			local s = (not GetPreviewPrimaryTalentTree() and not GetPrimaryTalentTree()) and "_nospec" or ""
			return L['status_green'.. s .. (self.pet and '_pet' or '')]
		elseif status.colorcode=="YELLOW" then return L['status_yellow']:format(status.left-status.missed)
		elseif status.colorcode=="ORANGE" then return L['status_orange']:format(status.missed-status.left)
		end
	end
	return "???"
end


local function AddSuggestion (suggtable,tab,talent)
	suggtable[tab ..".".. talent] = (suggtable[tab ..".".. talent] or 0) + 1
	table.insert(suggtable,{tab=tab,talent=talent})
end

---
-- @return suggestion,status
-- This is the powerhorse.
function Build:MakeSuggestion()
    
	-- Assuming the spec is correct, pet type is okay, etc.

	-- clear any old suggestions, for starters
	self.suggestion={}
	--self.suggestion_preview={}
	
	if self.status_real.colorcode~="RED" or self.forced then
		if self.forced then ZTA:Debug("Forcing suggestion") end
		-- suggest away!
		local points = GetUnspentTalentPoints(false,not not self.pet)
		for ti,tal in ipairs(self.build) do
			if points==0 then break end
			if not tal.taken then
				points=points-1
				AddSuggestion(self.suggestion,tal[1],tal[2])
			end
		end
	end

	--[[
	-- why the hell would I calculate a "preview suggestion"???
	if self.status_preview.colorcode~="RED" or force then
		-- suggest away!
		local points = GetUnspentTalentPoints(false,not not self.pet) - GetGroupPreviewTalentPointsSpent(not not self.pet)
		for ti,tal in ipairs(self.build) do
			if points==0 then break end
			if not tal.taken and not tal.preview then
				points=points-1
				AddSuggestion(self.suggestion_preview,tal[1],tal[2])
			end
		end
	end
	--]]

	ZTA:Debug("Made a suggestion for "..(who(self.pet))..", count "..#self.suggestion)
end

function Build:Update()
	ZTA:DebugPush("Updating build ("..self.title..")")
	self:Parse()
    
	if not self.ready then return false,ZTA:DebugPop("NOT ready after parsing.") end

	self:UpdateStatus()
	if not self.ready then return false,ZTA:DebugPop("NOT good.") end

	self:MakeSuggestion()
	ZTA:DebugPop("Suggestion made.")
end


function Build:Dump()
	local s = ""
	for bi,b in ipairs(self.build) do
		local tab,talent = unpack(b)
		s = s .. ((#s>0) and "," or "") .. "{"..tab..","..talent.."}"
	end
	ZTA:Print("  ZygorTalentAdvisor:RegisterBuild(\""..(self.class or "PET ".. self.pettype).."\",\"".. self.title.."\",{"..s.."})")
end

-- Dump talent spell numbers for TalentsToNumbers. Run manually.
function ZTA:DumpTalentSpells(pet)
	pet=not not pet
	local s = ""
	local _,myclass
	if not pet then _,myclass = UnitClass("player") else _,myclass = GetTalentTabInfo(1,false,pet) end
	s = "	[\"".. myclass:upper() .."\"]={\n"
	if pet then s = s .. "		[\"pet\"]=1,\n" end
	for tab=1,GetNumTalentTabs(false,pet) do
		local id,tabname = GetTalentTabInfo(tab,false,pet)
		--s = s .. "	[\""..tabname.."\"]={\n"
		for talent=1,GetNumTalents(tab,false,pet) do
			local name = GetTalentInfo(tab,talent,false,pet)
			local link = GetTalentLink(tab,talent,false,pet)
			if link then
				local id = link:match("talent:(%d+):")
				s = s .. "		[\""..name.."\"]="..id..",\n"
			else
				s = s .. "		-- no link for "..tab..","..talent.."\n"
			end
		end
		if tab<GetNumTalentTabs(false,pet) then s = s .. "\n" end
	end
	s = s .. "	},\n"
	if ZGV and ZGV.ShowDump then
		ZGV:ShowDump(s,"Talent data:")
	else
		print(s)
	end
end

function Build:QuickDumpStatusAndSuggestion()
	local s=""
	s=s..(self.ready and "READY" or "NOT READY: "..self.errorcode)
	if self.colorcode=="YELLOW" or self.colorcode=="ORANGE" then s=s..(" (%d)"):format(self.pointsleft-self.missed) end
	s=s..": "
	if sug then
		for i=1,#sug do s=s..sug[i].tab..","..sug[i].talent.."; " end
	else
		s=s.."none"
	end
	return s
end
