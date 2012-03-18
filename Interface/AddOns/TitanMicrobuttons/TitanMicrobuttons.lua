--[[
    Name:           Titan Microbuttons
	Description:	Titan Panel plugin for WOW Microbuttons
    Author:         Suddendeath2000
    Version:        4.0.1
    ]]--
    
TPMicVersion = "4.0.1"
TPMicC1 = "|cffffffff"
TPMicC2 = "|cffff9933"
TPMicC3 = "|cff00ff00"
TPMicC4 = "|cffffcc00"
TPMicC5 = "|cff666666"
TPMicID = "Microbuttons"
TPMicCF = "Character Info"
TPMicSBF = "Spellbook and Abilities"
TPMicSocial = "Social"
TPMicGame = "Game Menu"
TPMicUI = "Reset Options"
TPMicTP = "Titan Panel "
TPMicBY = "by "
TPMicOW = "Original WOW"
TPMicBC = "Burning Crusade"
TPMicWLK = "Wrath of the Lich King"
TPMicCata = "Cataclysm"
TPMicLinux = "Linux"
TPMicWin = "Windows"
TPMicMac = "Mac OS"
TPMicUnknown = "Unknown"
TPMicCurrent = "Current: "
TPMicGameS = "Game Build: "
TPMicClientS = "ClientOS: "
TPMicLocaleS = "Locale: "
TPMicRealmS = "Realm: "
TPMicFrameS = "Framerate: "
TPMicLatencyS = "Latency: "
TPMicRC = "Right-click to Open Menu\n"
TPMicDLC = "Double Left-click to Take Screenshot"
TPMicSDLC = "Shift/Double Left-click to Follow Target"
TPMicCharacter = "Character"
TPMicPets = "Pets"
TPMicRep = "Reputation"
TPMicSkill = "Skills"
TPMicCur = "Currency"
TPMicFriend = "Friends"
TPMicWho = "Who"
TPMicGuild = "Guild"
TPMicChat = "Chat"
TPMicRaid = "Raid"
TPMicVideo = "Video"
TPMicSV = "Sound & Voice"
TPMicInterface = "Interface"
TPMicMacOp = "Mac Options"
TPMicKeys = "Key Bindings"
TPMicMacro = "Macros"
TPMicACP = "AddOns"
TPMicKRM = "Ratings Menu"
TPMicRUI = "ReloadUI"
TPMicGraphics = "Reload Graphics"
TPMicSpellAbil = "Spellbook and Abilities"
TPMicTalent = "Talents"
TPMicAchieve = "Achievements"
TPMicQuest = "Quest Log"
TPMicPVP = "Player vs. Player"
TPMicDF = "Dungeon Finder"
TPMicHR = "Help Request"
TPMicLogout = "Logout"
TPMicQuit = "Quit"
TPMicTotAddon = 0

function TitanPanelMicrobuttonsButton_OnLoad(self)
    DEFAULT_CHAT_FRAME:AddMessage(TPMicC1.."Titan Panel"..TPMicC2.." [Microbuttons] "..TPMicC1.."v"..TPMicC2..TPMicVersion.." "..TPMicC1.."by |cff999999Suddendeath2000")
          
    self.registry = {
		id = "Microbuttons",
	    version = TPMicVersion,
        menuText = "Microbuttons",        
        category = "Information",
        tooltipTitle = TPMicC4.."Microbuttons",
        tooltipTextFunction = "TitanPanelMicrobuttonsButton_GetTooltipText",
	    icon = "Interface\\Addons\\TitanMicrobuttons\\TitanMicrobuttons",
        iconButtonWidth = 16,
        iconWidth = 16,        
        savedVariables = {
			ShowIcon = 1,
            DisplayOnRightSide = 1,
	}}
    
    TPMicBuild = GetBuildInfo()
    TPMicRealm = GetRealmName()
    TPMicLocale = GetLocale()

   if GetAccountExpansionLevel() == 0 then TPMicExSet = TPMicOW
      elseif GetAccountExpansionLevel() == 1 then TPMicExSet = TPMicBC
        elseif GetAccountExpansionLevel() == 2 then TPMicExSet = TPMicWLK
          elseif GetAccountExpansionLevel() == 3 then TPMicExSet = TPMicCata
  end
    if IsLinuxClient() then TPMicClient = TPMicLinux
       elseif IsMacClient() then TPMicClient = TPMicMac
         elseif IsWindowsClient() then TPMicClient = TPMicWin
           else TPMicClient = TPMicUnknown
  end  
end

function TitanPanelMicrobuttonsButton_GetTooltipText()   
    TPMicFR = GetFramerate()   
    _, _, TPMicLag = GetNetStats()
    return TPMicC4..TPMicCurrent..TPMicC1..TPMicExSet.."\n"..TPMicC4..TPMicGameS..TPMicC1..TPMicBuild.."\n"..TPMicC4..TPMicClientS..TPMicC1..TPMicClient.."\n"..TPMicC4..TPMicLocaleS..TPMicC1..TPMicLocale.."\n"..TPMicC4..TPMicRealmS..TPMicC1..TPMicRealm.."\n"..TPMicC4..TPMicFrameS..TPMicC1..floor(TPMicFR).." fps\n"..TPMicC4..TPMicLatencyS..TPMicC1..TPMicLag.." ms\n"..TPMicC4..TPMicRC..TPMicC3..TPMicDLC.."\n"..TPMicC3..TPMicSDLC
end   

function TitanPanelRightClickMenu_PrepareMicrobuttonsMenu(button)         
    local info = {}  
    
    if  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPMicCF )then
  TitanPanelRightClickMenu_AddTitle(TPMicCF, UIDROPDOWNMENU_MENU_LEVEL)
  
        info.text = "Character"
		info.func = function () PlaySound("igMainMenuOption") ToggleCharacter("PaperDollFrame") end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        info.text = "Reputation"
		info.func = function () PlaySound("igMainMenuOption") ToggleCharacter("ReputationFrame") end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        if HasPetSpells() then
          info.text = "Pet"
		  info.func = function () PlaySound("igMainMenuOption") ToggleCharacter("PetPaperDollFrame") end
  	      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
   end
        local _, JWamount, _ = GetCurrencyInfo(61)
        local _, CKamount, _ = GetCurrencyInfo(81)        
        local _, Camount, _ = GetCurrencyInfo(390)
        local _, Hamount, _ = GetCurrencyInfo(392)
        local _, Jamount, _ = GetCurrencyInfo(395)
        if Camount  ~= 0 or Hamount ~= 0 or Jamount ~= 0 or JWamount ~= 0 or CKamount ~= 0 then
          info.text = "Currency"
		  info.func = function () PlaySound("igMainMenuOption") ToggleCharacter("TokenFrame") end
		  UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL) 
  end
        
    elseif ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPMicSBF )then
  TitanPanelRightClickMenu_AddTitle(TPMicSBF, UIDROPDOWNMENU_MENU_LEVEL)
  
        info.text = "Spellbook"
		info.func = function () PlaySound("igMainMenuOption") ToggleSpellBook(BOOKTYPE_SPELL) end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
       
		info.text = "Professions"
		info.func = function () PlaySound("igMainMenuOption") ToggleSpellBook(BOOKTYPE_PROFESSION) end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        if HasPetSpells() then
          info.text = "Pets"
		  info.func = function () PlaySound("igMainMenuOption") ToggleSpellBook(BOOKTYPE_PET) end
  	      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
  end
        
        if GetNumCompanions("MOUNT") > 0 then
          info.text = "Mounts"
		  info.func = function () PlaySound("igMainMenuOption") ToggleSpellBook(BOOKTYPE_MOUNT) end
  	      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
  end
        
        if GetNumCompanions("CRITTER") > 0 then
          info.text = "Companions"
		  info.func = function () PlaySound("igMainMenuOption") ToggleSpellBook(BOOKTYPE_COMPANION) end
  	      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
  end      
        
    elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPMicTalent )then
  TitanPanelRightClickMenu_AddTitle(TPMicTalent, UIDROPDOWNMENU_MENU_LEVEL)
  
        info.text = "Talents"
		info.func = function () PlaySound("igMainMenuOption") ToggleTalentFrame() end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        if HasPetSpells() then
          info.text = "Pet Talents"
		  info.func = function () PlaySound("igMainMenuOption") TogglePetTalentFrame() end
  	      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
  end
       
		info.text = "Glyphs"
		info.func = function () PlaySound("igMainMenuOption") ToggleGlyphFrame() end        
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
    elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPMicAchieve )then
  TitanPanelRightClickMenu_AddTitle(TPMicAchieve, UIDROPDOWNMENU_MENU_LEVEL)    
  
  
        info.text = "Acheivements"
		info.func = function () PlaySound("igMainMenuOption") ToggleAchievementFrame() end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
       
		info.text = "Statistics"
		info.func = function () PlaySound("igMainMenuOption") ToggleAchievementFrame(2) end        
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL) 
  
   elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPMicGuild )then
  TitanPanelRightClickMenu_AddTitle(TPMicGame, UIDROPDOWNMENU_MENU_LEVEL)
  
        info.text = "Roster"
		info.func = function () PlaySound("igMainMenuOption") ToggleGuildFrame() GuildFrame_TabClicked(GuildFrameTab2) end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
       
		info.text = "Info"
		info.func = function () PlaySound("igMainMenuOption") ToggleGuildFrame() GuildFrame_TabClicked(GuildFrameTab5) end        
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL) 
        
    elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPMicPVP )then
  TitanPanelRightClickMenu_AddTitle(TPMicPVP, UIDROPDOWNMENU_MENU_LEVEL)    
  
        info.text = "Honor"
		info.func = function () PlaySound("igMainMenuOption") ToggleFrame(PVPFrame) PVPFrame_TabClicked(PVPFrameTab1) end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
       
		info.text = "Conquest"
		info.func = function () PlaySound("igMainMenuOption") ToggleFrame(PVPFrame) PVPFrame_TabClicked(PVPFrameTab2) end        
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        info.text = "Arena Teams"
		info.func = function () PlaySound("igMainMenuOption") ToggleFrame(PVPFrame) PVPFrame_TabClicked(PVPFrameTab3) end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
    elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPMicGame )then
  TitanPanelRightClickMenu_AddTitle(TPMicGame, UIDROPDOWNMENU_MENU_LEVEL)        
        
        info.text = TPMicVideo
		info.func = function () PlaySound("igMainMenuOption") VideoOptionsFrame:Show() end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
       
		info.text = TPMicSV
		info.func = function () PlaySound("igMainMenuOption") AudioOptionsFrame:Show() end        
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)        
        
        info.text = TPMicInterface
		info.func = function () PlaySound("igMainMenuOption") InterfaceOptionsFrame:Show()end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        if (IsMacClient()) then
          info.text = TPMicMacOp
		  info.func = function () PlaySound("igMainMenuOption") HideUIPanel(GameMenuFrame) ShowUIPanel(MacOptionsFrame) end
  	      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
  end        
       
		info.text = TPMicKeys
		info.func = function ()  PlaySound("igMainMenuOption") KeyBindingFrame_LoadUI() KeyBindingFrame.mode = 1 ShowUIPanel(KeyBindingFrame) GameMenuButtonContinue:Click() end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        info.text = TPMicMacro
		info.func = function () PlaySound("igMainMenuOption") ShowMacroFrame() end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        if IsAddOnLoaded("ACP") then
          info.text = TPMicACP
          info.func = function () ACP_AddonList:Show() end
          UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
  end
        
        if (GetLocale() == "koKR") then
          info.text = TPMicKRM
		  info.func = function () PlaySound("igMainMenuOption") HideUIPanel(GameMenuFrame) ShowUIPanel(RatingMenuFrame) end
		  UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
  end      
        
    elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPMicUI )then
  TitanPanelRightClickMenu_AddTitle(TPMicUI, UIDROPDOWNMENU_MENU_LEVEL)

		info.text = TPMicRUI
		info.func = function () ReloadUI() end
  	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
       
		info.text = TPMicGraphics
		info.func = function () RestartGx() end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)    

        
    else   
    
        TitanPanelRightClickMenu_AddTitle(TPMicID)
        TitanPanelRightClickMenu_AddSpacer()        
        info = {}
        
        info.text = TPMicCF
        info.value = TPMicCF
        info.func = nil
        info.hasArrow = 1        
	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

        info.text = TPMicSBF
        info.value = TPMicSBF
        info.func = nil
        info.hasArrow = 1        
	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        if (UnitLevel("player") >= 10) then
          info.text = TPMicTalent
          info.value = TPMicTalent
          info.func = nil
          info.hasArrow = 1
          UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)   
          
          else
          
          info.text = TPMicC5..TPMicTalent
          info.hasArrow = nil
          info.func = function () UIErrorsFrame:AddMessage("Must Be Level 10 to Access Talents") end
          UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL) 
  end
          
          if ( ( HasCompletedAnyAchievement() or IsInGuild() ) and CanShowAchievementUI() ) then 
          info.text = TPMicAchieve
          info.value = TPMicAchieve
          info.func = nil
          info.hasArrow = 1          
          UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL) 
                    
          else
          
          info.text = TPMicC5..TPMicAchieve
          info.hasArrow = nil
          info.func = function () UIErrorsFrame:AddMessage("Must Be Level 10 or Have Completed An Achievement to Access Achievements") end
          UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL) 
  end
        
        info.text = TPMicQuest
        info.hasArrow = nil
        info.func = function () PlaySound("igMainMenuOption") QuestLogFrame:Show() end
	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        if IsInGuild() then
          info.text = TPMicGuild
          info.value = TPMicGuild
          info.func = nil
          info.hasArrow = 1        
	      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
          
          else
          
          info.text = TPMicC5..TPMicGuild
          info.hasArrow = nil
          info.func = function () UIErrorsFrame:AddMessage("Must Be In a Guild to Access Guild Functions") end
          UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)          
  end
        
        if (UnitLevel("player") >= 10) then
          info.text = TPMicPVP
          info.value = TPMicPVP
          info.func = nil
          info.hasArrow = 1        
	      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)          
          
          else
        
          info.text = TPMicC5..TPMicPVP
          info.hasArrow = nil
          info.func = function () UIErrorsFrame:AddMessage("Must Be Level 10 to Access Player vs. Player") end
          UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
  end
        
        if (UnitLevel("player") >= 15) then
          info.text = TPMicDF
          info.hasArrow = nil
          info.func = function () PlaySound("igMainMenuOption") ToggleLFDParentFrame() end
	      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
          
          else
        
          info.text = TPMicC5..TPMicDF
          info.hasArrow = nil
          info.func = function () UIErrorsFrame:AddMessage("Must Be Level 15 to Access Dungeon Finder")
          end
          UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
  end        
        
        info.text = TPMicGame
        info.value = TPMicGame
        info.func = nil
        info.hasArrow = 1        
	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        info.text = TPMicHR
        info.hasArrow = nil   
        info.func = function () PlaySound("igMainMenuOption") ToggleHelpFrame() end        
	    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
        TitanPanelRightClickMenu_AddSpacer()
     
        info.text = TPMicLogout
        info.func = function () PlaySound("igMainMenuOption") Logout() end
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
		info.text = TPMicQuit
		info.func = function () PlaySound("igMainMenuOption") ForceQuit() end
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)		
        
        TitanPanelRightClickMenu_AddSpacer()
        
        info = {}
        info.text = TPMicUI
        info.value = TPMicUI
        info.hasArrow = 1
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
  end
end

function TitanPanelMicrobuttonsButton_OnDoubleClick(button)    
    if button == "LeftButton" then 
      if IsShiftKeyDown() then FollowUnit("target")        
            else Screenshot()
    end     
  end
end

function TitanPanelMicrobuttonsButton_OnUpdate()      
    TitanPanelButton_UpdateButton(TPMicID)   
end