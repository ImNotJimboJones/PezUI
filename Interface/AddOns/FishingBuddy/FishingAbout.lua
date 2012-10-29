-- Display some information about the people who helped
-- Some information about whom to thank

local credits = {};

-- Translation help
credits[FBConstants.ROLE_TRANSLATE_ZHTW] = {
	["machihchung"] = { "Version 0.9.9e4 (CurseForge)" },
	["Indra (Eastern.Stories)"] = { "Version 0.9.3", "Version 0.9.3i", "Version 0.9.4", "Version 0.9.4b", "Version 0.9.7d", },
	["Whocare"] = { "bahamut, an influential gamer forum in Taiwan 11/24/2007", },
	["smartdavislin"] = { "Version 1.0.2 (CurseForge)", },
	["Andyca"] = { "Version 1.0.7a (CurseForge)" },
	["zhTW"] = { "Version 1.0.9e (CurseForge)", },
	["titanium0107"] = { "Version 1.1e (CurseForge)", },
};

credits[FBConstants.ROLE_TRANSLATE_ITIT] = {
	["bER92"] = { "Version 1.0.9f (CurseForge)" },
	["Impaler"] = { "Version 1.0.9f (CurseForge)" },
};

credits[FBConstants.ROLE_TRANSLATE_ZHCN] = {
	["biAji"] = { "Version 0.9.3d" },
	["wowuicon"] = { "Version 0.9.9e4 (CurseForge)", "Version 1.0.2 (CurseForge)", },
	["yahooor"] = { "Version 0.9.9e4 (CurseForge)" },
	["foxdodo"] = { "Version 1.0.2 (CurseForge)" },
	["dh0000"] = { "Version 1.0.7a (CurseForge)", "Version 1.0.7e (CurseForge)", "Version 1.0.7h (CurseForge)", },
};

credits[FBConstants.ROLE_TRANSLATE_DEDE] = {
	["Leidbringer"] = { "Version 0.9.7d", },
	["Chinkuwaila"] = { "Version 0.8.9", },
	["blackrat"] = { "Version 0.8.1d", },
	["RustyXXL"] = { "Version 1.0.4 (CurseForge)", },
	["Ithilrandir"] = { "Version 1.0.5 (CurseForge)", },
	["DirtyHarryGermany"] = { "Version 1.0.7h (CurseForge)", "Version 1.0.9e (CurseForge)", "Version 1.1e (CurseForge)", },
	["Freydis88"] = { "Version 1.0.9e (CurseForge)", },
	["Frontiii"] = { "Version 1.0.9e (CurseForge)", },
};

credits[FBConstants.ROLE_TRANSLATE_FRFR] = {
	["krogh"] = { "Version  0.8.7", },
	["Corwin Whitehorn"] = { "Version  0.8.5", },
	["PierrotIV"] = { "Version 1.0.9e (CurseForge)", },
	["boidan01"] = { "Version 1.0.9e (CurseForge)", },
};

credits[FBConstants.ROLE_TRANSLATE_ESES] = {
	["Fili"] = { "Version 0.8.6b", "Version  0.9.7d", },
	["Valdesca"] = { "Version 0.9.9e6", },
	["Winderfind Drakkari"] = { "Version 1.0.7a" },
	["jmaister"] = { "Version 1.0.9e (CurseForge)", },
};

credits[FBConstants.ROLE_TRANSLATE_KOKR] = {
	["maknae"] = { "Version 0.9.9e4 (CurseForge)" },
	["post"] = { "Version 0.9.9e4 (CurseForge)" },
	["seashop"] = { "Version 1.0.2 (Curseforge)" },
};

credits[FBConstants.ROLE_TRANSLATE_RURU] = {
	["StingerSoft"] = { "Version 0.9.8l", "Version 0.9.9e4 (CurseForge)" },
	["hellquister"] = { "Version 0.9.9e4 (CurseForge)" },
	["D_Angel"] = { "Version 0.9.9e4 (CurseForge)", "Version 1.0.2 (CurseForge)", "Version 1.1c (CurseForge)" },
	["AlenaM"] = { "Version 1.0 (CurseForge)" },
	["KVVV"] = { "Version 1.0 (CurseForge)" },
	["frodo10"] = { "Version 1.0 (CurseForge)" },
	["DVK"] = { "Version 1.1f (CurseForge)" },
	["Ant1dotE"] = { "Version 1.0.1 (CurseForge)", "Version 1.0.2 (CurseForge)", "Version 1.0.4 (CurseForge)" },
};

credits[FBConstants.ROLE_TRANSLATE_PTBR] = {
	["nomadbr"] = { "Version 1.0.7a (CurseForge)" },
};

-- Testers/bug fixers
credits[FBConstants.ROLE_HELP_BUGS] = {
	["Goose"] = { "Fishing skill-up help", },
	["Moleculor"] = { "Fishing skill-up help", },
	["Shadrin"] = { "Text cleanup and bug fixes", },
	["ZeroKnowledge"] = { "Automatic lure improvements", },
	["dwex"] = { "Bug fixes", },
	["Saur"] = { "Nat Pagle's Fishing Terminator", },
	["Draznar"] = { "for the Fishing FAQ and style!", },
	["bsmorgan"] = { "Minimap button radius improvements", "Auto-lure improvments", "Skill-up tabulation" },
	["Wildcard_25"] = { "Fish watcher displays days!", },
	["Bodar"] = { "GetProfessions change in 4.0.6", },
	["Exaid"] = { "Fix for uncertain gear manager set on login" },
	["x87bliss"] = { "Help with tracking down exit with pole crashes" },
	["oscarucb"] = { "Help with the fix for repeat lure bug" },
	["callumw"] = { "Typo identification in fishing lib" },
	["Ninmah"] = { "Beta tester", "Auto-loot reset bug" },
	["WildCard_25"] = { "Fish Watcher update bug" },
};

-- Ideas and suggestions
credits[FBConstants.ROLE_HELP_SUGGESTIONS] = {
	["secutanudu"] = { "Turn on sound in background while fishing", },
	["Lufunpsy"] = { "Turn up particle density when fishing", "Turn on sound if it's off", },
	["mysticalos"] = { "Turn off PvP while fishing", },
	["Lrdx"] = { "Count tastyfish in your bag instead of as you catch them",
				 "Only fish in schools during Extravaganza", },
	["Alcasius"] = { "multi-machine database merge", },
	["SBaL"] = { "Mute everything but bobber sounds", },
	["Xantandor"] = { "More summary information while fishing", },
	["zino"] = { "Remove quest items from the list of things caught", },
	["Daisyvondoom"] = { "Separate out Pygmy fish from counts", },
	["Dark Imakuni"] = { "Save the show fish/locations choice",
						"Force item slot empty in ODF",
						"Titan Panel support",
						"Only show counts -- no percentages", },
	["LBlaze"] = { "Display both lifetime and current fish info in the watcher", },
	["Valzic"] = { "Save helm/cloak settings per outfit", },
	["KayJayDK"] = { "Remember tastyfish pool locations", },
	["Bruntlief"] = { "Track cycle fish", },
	["Buio"] = { "Show current zone in watcher", },
	["Tarklash"] = { "Minimap icon", },
	["Anakar"] = { "Elapsed fishing time", },
	["Valzic"] = { "Show current skill level in watcher", },
	["Vreejack"] = { "Gatherer integration", },
	["truefreak"] = { "Display total fish caught all time and this session", },
	["Yeoman and RamahP"] = { "Save fishing level information", },
	["RamahP"] = { "Lost fish count", },
	["Ravynne"] = { "ZOMG *all* the pets!", },
	["El's Extreme Anglin'"] = { "Subzone fishing levels", "Fishing skill up table" },
};

credits[FBConstants.ROLE_ADDON_AUTHORS] = {
	["x87bliss"] = { "FishWarden", },
	["Mundocani"] = { "Outfitter", },
	["The Cosmos Team"] = { "TackleBox", },
	["Impp"] = { "Impp's Fishing DB", },
	["Iriel"] = { "QuickWeaponSwap", "DevTools", },
	["Esamynn"] = { "Astrolabe", },
	["ckknight"] = { "LibTourist-3.0", "LibBabble-Zone-3.0", "LibCrayon-3.0", },
	["Arrowmaster"] = { "LibTourist-3.0", },
	["Odica"] = { "LibTourist-3.0", },
	["Ackis"] = { "LibBabble-Zone-3.0", },
	["Nevcairiel"] = { "LibBabble-Zone-3.0", "LibStub", "LibBabble-SubZone-3.0", "CallbackHandler-1.0", },
	["Kaelten"] = { "LibStub", },
	["Ammo"] = { "LibStub", },
	["Cladhaire"] = { "LibStub", },
	["mikk"] = { "LibStub", "CallbackHandler-1.0", },
	["arith"] = { "LibBabble-SubZone-3.0", },
	["Dynaletik"] = { "LibBabble-SubZone-3.0", },
	["Tekkub"] = { "LibDataBroker-1.1", },
	["Cryect (cryect@gmail.com)"] = { "LibGraph-2.0", },
	["Xinhuan"] = { "LibGraph-2.0", },
	["KarlKFI"] = { "MobileMinimapButtons" },
};

FishingBuddy.About = {};

local AboutOptions = {
	["AboutFrame"] = {
		["button"] = "FishingAboutFrame",
		["setup"] =
			function()
				FishingAboutFrame:SetAllPoints();
			end,
	},
};

local CREDITSKIP = 7;

local function UpdateCreditPanel(self, elapsed)
	if ( not self.started ) then
		self.started = true;
		self.fadestate = 5;
		self.fadevalue = 0;
		self.whatidx = 1;
		self.currenttime = math.random()*2.5 + elapsed + 0.5;
	end
	self.currenttime = self.currenttime - elapsed;
	if (self.currenttime > 0) then
		return;
	end

	if (self.fadestate == 0) then
		-- pick a new thing to display, and fade it in
		self.data = self.credits[self.idx]
		self.lines[1]:SetText(self.categories[self.data.title])
		self.lines[2]:SetText(self.data.who)
		self.lines[3]:SetText(self.data.what[self.whatidx])
		self:SetHeight(self.lines[1]:GetHeight()*4)
		self:SetPoint("TOP", self.parent.Thanks, "BOTTOM", 0, -(self.offset-1)*self:GetHeight()-self.lines[1]:GetHeight());
		-- Fade in everything
		for _,line in ipairs(self.lines) do
			line:SetAlpha(self.fadevalue)
		end
		if ( self.fadevalue < 1.0) then
			self.fadevalue = self.fadevalue + 0.05
			self.currenttime = 0.1
		else
			self.fadestate = 1
			self.currenttime = 5.0 + math.random()*1.0;
			self.fadevalue = 1.0
		end
	elseif (self.fadestate == 1) then
		-- Pause for display
		-- check for detail change
		self.whatidx = self.whatidx + 1
		if ( self.data.what[self.whatidx] ) then
			self.fadestate = 2
		else
			self.idx = self.idx + CREDITSKIP
			if ( self.idx > #self.credits ) then
				self.idx = self.idx % CREDITSKIP
			end
			if ( self.idx == 0 ) then
				self.idx = 1
			end
			self.whatidx = 1
			self.fadestate = 4
		end
	elseif (self.fadestate == 2) then
		-- Fade out detail
		self.lines[3]:SetAlpha(self.fadevalue);
		if ( self.fadevalue > 0.0) then
			self.fadevalue = self.fadevalue - 0.05
			self.currenttime = 0.1
		else
			self.fadestate = 3
			self.fadevalue = 0.0
		end
	elseif (self.fadestate == 3) then
		-- Fade in detail
		self.lines[3]:SetText(self.data.what[self.whatidx])
		self.lines[3]:SetAlpha(self.fadevalue);
		if ( self.fadevalue < 1.0) then
			self.fadevalue = self.fadevalue + 0.05
			self.currenttime = 0.1
		else
			self.fadestate = 1
			self.currenttime = 5.0 + math.random()*1.0;
			self.fadevalue = 1.0
		end
	elseif (self.fadestate == 4) then
		-- Fade out everything
		for _,line in pairs(self.lines) do
			line:SetAlpha(self.fadevalue)
		end
		if ( self.fadevalue > 0.0) then
			self.fadevalue = self.fadevalue - 0.05
			self.currenttime = 0.1
		else
			self.fadestate = 5
			self.fadevalue = 0.0
		end
	elseif (self.fadestate == 5) then
		-- Pause after fading out
		self.fadestate = 0
		self.currenttime = math.random()*0.15;
	end
	-- all the reset times are offset
	self.currenttime = self.currenttime + elapsed;
end

local function MakeCreditPanel(parent, alignment, offset)
	local panel = CreateFrame("FRAME", nil, parent)
	panel.lines = {};
	local point = panel
	local where = "TOP"
	for idx=1,3 do
		local line = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		line:SetPoint("TOPLEFT", point, where.."LEFT", 0, 0)
		line:SetPoint("TOPRIGHT", point, where.."RIGHT", 0, 0)
		tinsert(panel.lines, line)
		point = line
		where = "BOTTOM"
	end
	panel.display = {}
	panel.started = false
	panel.parent = parent
	panel:SetScript("OnUpdate", UpdateCreditPanel);
	panel:ClearAllPoints()
	panel.offset = offset
	panel:SetPoint("LEFT", alignment, "LEFT", 0, 0);
	panel:SetPoint("RIGHT", alignment, "RIGHT", 0, 0);
	return panel
end

local function OnEvent(self, event)
	self.Author = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	self.Author:SetPoint("TOP", self, "TOP", -4, 0)
	self.Author:SetPoint("LEFT", self, "LEFT", 0, 0)
	self.Author:SetPoint("RIGHT", self, "RIGHT", -48, 0)
	self.Author:SetText(FBConstants.AUTHOR)
	self.Author:Show()
	
	self.Copyright = self:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	self.Copyright:SetPoint("TOP", self.Author, "BOTTOM", 0, -10)
	self.Copyright:SetPoint("LEFT", self, "LEFT", 0, 0)
	self.Copyright:SetPoint("RIGHT", self, "RIGHT", -48, 0)
	self.Copyright:SetJustifyH("CENTER")
	self.Copyright:SetText(FBConstants.COPYRIGHT)
	self.Copyright:Show()

	self.Thanks = self:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	self.Thanks:SetPoint("TOP", self.Copyright, "BOTTOM", 0, -10)
	self.Thanks:SetPoint("LEFT", self, "LEFT", 0, 0)
	self.Thanks:SetPoint("RIGHT", self, "RIGHT", -48, 0)
	self.Thanks:SetJustifyH("CENTER")
	self.Thanks:SetText(FBConstants.THANKS)
	self.Thanks:Show()
	self.Thanks.idx = -1;

	self.categories = {}
	for what,_ in pairs(credits) do
		tinsert(self.categories, what)
	end
	self.credits = {}
	for idx,shownext in ipairs(self.categories) do
		for who,what in pairs(credits[shownext]) do
			tinsert(self.credits, { title=idx, who=who, what=what, sort=math.random() })
		end
	end

	self.Panels = {};
	for idx=1,5 do
		local panel = MakeCreditPanel(self, self.Thanks, idx)
		panel.idx = idx
		panel.credits = self.credits
		panel.categories = self.categories
		tinsert(self.Panels, panel)
	end
	
	-- Dump the storage, now that we have a better table
	credits = nil;
	table.sort(self.credits, function (a, b) return a.sort < b.sort; end)

	FishingBuddy.OptionsFrame.HandleOptions(FBConstants.ABOUT_TAB, "Interface\\Icons\\Inv_Misc_Questionmark", AboutOptions, nil, nil, true);
	self:UnregisterEvent("VARIABLES_LOADED");
end

local frame = CreateFrame("FRAME", "FishingAboutFrame")
frame:SetScript("OnEvent", OnEvent)
frame:RegisterEvent("VARIABLES_LOADED")
frame:Hide()