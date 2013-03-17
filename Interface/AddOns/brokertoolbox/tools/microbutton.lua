local tool
tool = BrokerToolBox:NewTool("microbutton",{
	--author="Sanori",									--author of this tool
	version="1.5 (15. Mar. 2013)",				--tool version
	defaultON=false,									--default active?
	OnUpdate = function(self, elapsed)
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed
		if (self.TimeSinceLastUpdate > 1) then
			local down, up, lagHome, lagWorld = GetNetStats()
			if GameTooltip:IsVisible() and _G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText()==tool:L("LWorld") then
				_G["GameTooltipTextRight1"]:SetText(format("|cff%s%s ms",self:LagColor(lagWorld),lagWorld))
				_G["GameTooltipTextRight2"]:SetText(format("|cff%s%s ms",self:LagColor(lagHome),lagHome))
				_G["GameTooltipTextRight4"]:SetText(format("|cffffffff%.1f fps|r",GetFramerate()))
			end
			self.broker.text = format("|cff%s%sms|r %.1ffps",self:LagColor(lagWorld),lagWorld,GetFramerate())
			self.TimeSinceLastUpdate = 0
		end
	end,
	LagColor = function(self, ping)
		if ping<PERFORMANCEBAR_LOW_LATENCY then
			return "00ff00"
		elseif ping<PERFORMANCEBAR_MEDIUM_LATENCY then
			return "ffff00"
		else
			return "ff0000"
		end
	end,
	events = {
		["TIME_PLAYED_MSG"] = function(self, total, level)
			if GameTooltip:IsVisible() and _G["GameTooltipTextLeft1"] and _G["GameTooltipTextLeft1"]:GetText()==tool:L("LWorld") then
				_G["GameTooltipTextRight6"]:SetText(SecondsToTime(total))
				_G["GameTooltipTextRight7"]:SetText(SecondsToTime(level))
				GameTooltip:Show()
			end
			ChatFrame1:RegisterEvent("TIME_PLAYED_MSG")
		end,
	},
	broker = {
		type = "data source",
		text = "?",
		icon = "Interface\\Spellbook\\Spellbook-Icon",
		OnClick = function(self, button)
			GameTooltip:Hide()
			tool.menu:Open(self, 'children', function(level, value)
				local _, class = UnitClass("player")
				local coords =  CLASS_ICON_TCOORDS[class]
				tool.menu:AddFunc(MicroButtonTooltipText(CHARACTER_BUTTON, "TOGGLECHARACTER0"), function() ToggleCharacter("PaperDollFrame") end, "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes", nil, nil,
					'iconCoordLeft', coords[1],
					'iconCoordRight', coords[2],
					'iconCoordTop', coords[3],
					'iconCoordBottom', coords[4]
				)
				tool.menu:AddFunc(MicroButtonTooltipText(SPELLBOOK_ABILITIES_BUTTON, "TOGGLESPELLBOOK"), function() ToggleFrame(SpellBookFrame) end, "Interface\\Spellbook\\Spellbook-Icon")
				tool.menu:AddFunc(MicroButtonTooltipText(TALENTS_BUTTON, "TOGGLETALENTS"), function() ToggleTalentFrame() end, "Interface\\Icons\\Ability_Marksmanship")
				tool.menu:AddFunc(MicroButtonTooltipText(ACHIEVEMENT_BUTTON, "TOGGLEACHIEVEMENT"), function() ToggleAchievementFrame() end, "Interface\\ACHIEVEMENTFRAME\\UI-ACHIEVEMENT-SHIELDS", nil, nil,
					'iconCoordLeft', 0.015625,
					'iconCoordRight', 0.4765625,
					'iconCoordTop', 0.4921875,
					'iconCoordBottom', 0.9453125
				)
				tool.menu:AddFunc(MicroButtonTooltipText(QUESTLOG_BUTTON, "TOGGLEQUESTLOG"), function() ToggleFrame(QuestLogFrame) end, "Interface\\LFGFRAME\\LFGICON-QUEST")
				--if IsInGuild() then
					--tool.menu:AddFunc(MicroButtonTooltipText(GUILD, "TOGGLEGUILDTAB"), function() ToggleGuildFrame() end, nil)
				--end
				--tool.menu:AddFunc(MicroButtonTooltipText(LOOKINGFORGUILD, "TOGGLEGUILDTAB"), function() ToggleGuildFrame() end, "Interface\\Buttons\\UI-MicroButton-Socials-Up");
				tool.menu:AddFunc(MicroButtonTooltipText(GUILD, "TOGGLEGUILDTAB"), function() ToggleGuildFrame() end, "Interface\\Buttons\\UI-MicroButton-Socials-Up")
				tool.menu:AddFunc(MicroButtonTooltipText(PLAYER_V_PLAYER, "TOGGLECHARACTER4"), function() TogglePVPFrame() end, "Interface\\BattlefieldFrame\\Battleground-"..UnitFactionGroup("player"))
				tool.menu:AddFunc(MicroButtonTooltipText(DUNGEONS_BUTTON, "TOGGLELFGPARENT"), function() ToggleLFDParentFrame() end, "Interface\\LFGFRAME\\LFG-Eye", nil, nil,
					'iconCoordLeft', 0.0234375,
					'iconCoordRight', 0.099609375,
					'iconCoordTop', 0.046875,
					'iconCoordBottom', 0.19921875
				)
				tool.menu:AddFunc(MicroButtonTooltipText(MOUNTS_AND_PETS, "TOGGLEPETJOURNAL"),function() TogglePetJournal(); end,"Interface\\Icons\\Ability_Mount_RidingHorse");
				tool.menu:AddFunc(MicroButtonTooltipText(ENCOUNTER_JOURNAL, "TOGGLEENCOUNTERJOURNAL"),function() ToggleEncounterJournal(); end, "Interface\\EncounterJournal\\UI-EJ-PortraitIcon");
				tool.menu:AddFunc(MicroButtonTooltipText(MAINMENU_BUTTON, "TOGGLEGAMEMENU"), function()
					if ( not GameMenuFrame:IsShown() ) then
						ShowUIPanel(GameMenuFrame)
					else
						HideUIPanel(GameMenuFrame)
					end
				end)
				tool.menu:AddFunc(HELP_BUTTON, function() ToggleHelpFrame() end, "Interface\\Icons\\INV_Misc_QuestionMark")
				tool.menu:AddLine()
				tool.menu:AddFunc(BrokerToolBox:L("core","reloadui"), function() ReloadUI() end)
			end)
		end,
		OnTooltipShow = function(self) --after changing the tooltips line, pls also correct the OnUpdate function
			local down, up, lagHome, lagWorld = GetNetStats()
			GameTooltip:AddDoubleLine(tool:L("LWorld"),format("|cff%s%s ms",tool:LagColor(lagWorld),lagWorld))
			GameTooltip:AddDoubleLine(tool:L("LHome"),format("|cff%s%s ms",tool:LagColor(lagHome),lagHome))
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(tool:L("fps"),format("%.1f fps",GetFramerate()),nil,nil,nil,1,1,1)
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(tool:L("played"),"?",nil,nil,nil,1,1,1)
			GameTooltip:AddDoubleLine(tool:L("playedlvl"),"?",1,1,1,1,1,1)
			GameTooltip:AddLine(" ")
			UpdateAddOnMemoryUsage()
			local summemory=0
			local memorybyaddon={}
			for i=1, GetNumAddOns() do
				local memory = GetAddOnMemoryUsage(i)
				summemory=summemory+memory
				memorybyaddon[memory]=select(2,GetAddOnInfo(i))
			end
			GameTooltip:AddDoubleLine(tool:L("memoryusage"),format("%.2f MB",summemory/1000),nil,nil,nil,0,1,0)
			local i=0
			for memory,title in BrokerToolBox:pairsByKeys(memorybyaddon, function(a,b) return a>b end) do
				i=i+1
				if i>5 then break end
				GameTooltip:AddDoubleLine(title,format("%.2f MB",memory/1000),1,1,1,1,1,1)
			end
			ChatFrame1:UnregisterEvent("TIME_PLAYED_MSG")	--to hide chat message from RequestTimePlayed
			RequestTimePlayed()
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(tool:L("click"))
		end
	},
	PreInit = function(self)
		self.TimeSinceLastUpdate = 0
		--this is a dummy function to solve a Blizzard Bug (Blizzard_AchievementUI.lua:800: attempt to call global 'AchievementMicroButton_Update' (a nil value))
		function AchievementMicroButton_Update()
			return
		end
		--
	end,
})