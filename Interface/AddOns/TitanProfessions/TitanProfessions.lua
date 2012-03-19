--[[
    Name:           Titan Professions
	Description:	Titan Panel plugin for professions.
	Author:         Suddendeath2000
	Version:        4.0.2
    --]]

local TPProVersion = "4.0.2"
local TPProC1 = "|cffffffff"  -- White
local TPProC2 = "|cff993300"  -- Brown
local TPProC3 = "|cff00ff00"  -- Green
local TPProC4 = "|cffffcc00"  -- Gold

function TitanPanelProfessionsButton_OnLoad(self)
    DEFAULT_CHAT_FRAME:AddMessage(TPProC1.."Titan Panel " ..TPProC2.."[Professions] "..TPProC1.."v"..TPProC2..TPProVersion.." "..TPProC1.."by |cff999999Suddendeath2000")
       
    self.registry = {
		id = "Professions",
	    version = TPProVersion,
        menuText = TRADE_SKILLS,    
        category = "Profession",
        tooltipTitle = TPProC4..TRADE_SKILLS,
		tooltipTextFunction = "TitanPanelProfessionsButton_GetTooltipText",
        icon = "Interface\\minimap\\TRACKING\\Profession",
        iconButtonWidth = 16,        
        iconWidth = 16,        
        savedVariables = {
            ShowIcon = 1,
            DisplayOnRightSide = 1,                
            }}     
end

function TitanPanelProfessionsButton_GetButtonText()   
    return TRADE_SKILLS
end

function TitanPanelProfessionsButton_GetTooltipText()
    if GetLocale == "deDE" then return TPProC3.."Rechts-Klick zum Öffnen"                        
      elseif GetLocale == "esES" then return TPProC3.."Haga clic para abrir"
        elseif GetLocale == "frFR" then return TPProC3.."Faites un clic droit pour ouvrir"
          elseif GetLocale == "krKR" then return TPProC3.."마우스 오른쪽 단추로 열기를 클릭"        
            elseif GetLocale == "ruRU" then return TPProC3.."Щелкните правой кнопкой мыши, чтобы открыто"
              elseif GetLocale == "zhCN" then return TPProC3.."右键点击打开"
                elseif GetLocale == "zhTW" then return TPProC3.."右鍵點擊打開"
                  else return TPProC3.."Right-Click to Open"
  end
end

function TitanPanelRightClickMenu_PrepareProfessionsMenu()
  local info = {}
  local i, name, icon, skillLevel, maxSkillLevel, _, TPProGath  
  local Alchemy = GetSpellInfo(2259)
  local Blacksmithing = GetSpellInfo(2018)
  local Enchanting = GetSpellInfo(7411)
  local Disenchanting = GetSpellInfo(13262)
  local Engineering = GetSpellInfo(4036)
  local Inscription = GetSpellInfo(45357)
  local Milling = GetSpellInfo(51005)
  local Jewelcrafting = GetSpellInfo(25229)
  local Prospecting = GetSpellInfo(31252)
  local Smelting = GetSpellInfo(2656)
  local Mining = GetSpellInfo(2575)
  local Leatherworking = GetSpellInfo(2108)
  local Tailoring = GetSpellInfo(3908)
  local Archaeology = GetSpellInfo(78670)
  local Survey = GetSpellInfo(80451)
  local Cooking = GetSpellInfo(2550)
  local FirstAid = GetSpellInfo(3273)
  local Fishing = GetSpellInfo(7620)
  local Herbalism = GetSpellInfo(2366)
  local Skinning = GetSpellInfo(8613)
  
     if GetLocale == "deDE" then TPProGath = TPProC4.."Sammelberufe:"                        
      elseif GetLocale == "esES" then TPProGath = TPProC4.."Recopilación de Habilidades:"
        elseif GetLocale == "frFR" then TPProGath = TPProC4.."Rassembler des compétences:"
          elseif GetLocale == "krKR" then TPProGath = TPProC4.."수집 기술:"        
            elseif GetLocale == "ruRU" then TPProGath = TPProC4.."Сбор Навыки:"
              elseif GetLocale == "zhCN" then TPProGath = TPProC4.."采访技巧:"
                elseif GetLocale == "zhTW" then TPProGath = TPProC4.."採訪技巧:"
                  else TPProGath = TPProC4.."Gathering Skills:"
  end
  
  for i = 1, 40 do
    name, icon, skillLevel, maxSkillLevel, _, _, _, _ = GetProfessionInfo(i)
    
    if name == "Kräuterkunde" then name = TPProC4.."Kraut-Versammlung"                        
      elseif name == "Herboristería" then name = TPProC4.."Reunión de la hierba"
        elseif name == "Herboristerie" then name = TPProC4.."Rassemblement d'herbe"
          elseif name == "한국어" then name = TPProC4.."나물 집결"        
            elseif name == "По-русски" then name = TPProC4.."Сход травы"
              elseif name == "草药医术学" then name = TPProC4.."草本汇聚"
                elseif name == "草藥醫術學" then name = TPProC4.."草本彙聚"
                  elseif name == "Herbalism" then name = "Herb Gathering"
  end
    
   if name == Alchemy then TPProfAlchemy = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Alchemy
  end
      
   if name == Blacksmithing then TPProfBlacksmithing = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Blacksmithing
  end

   if name == Enchanting then TPProfEnchanting = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Enchanting
                              TPProfDisenchant = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Disenchanting
  end
   
   if name == Engineering then TPProfEngineering = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Engineering
  end

   if name == Inscription then TPProfInscription = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Inscription
                               TPProfMilling = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Milling
  end
  
   if name == Jewelcrafting then TPProfJewelcrafting = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Jewelcrafting
                                 TPProfProspecting = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Prospecting
  end
  
   if name == Mining then TPProfSmelting = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Smelting
                          TPProfMining = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Mining
  end
  
   if name == Leatherworking then TPProfLeatherworking = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Leatherworking
  end
  
   if name == Tailoring then TPProfTailoring = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Tailoring
  end
  
   if name == Archaeology then TPProfArchaeology = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Archaeology
                               TPProfSurvey = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Survey
  end
 
   if name == Cooking then TPProfCooking = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Cooking
  end
  
   if name == FirstAid then TPProfFirstAid = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..FirstAid
  end
  
   if name == Fishing then TPProfFishing = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Fishing
  end
  
   if name == Herbalism then TPProfHerbalism = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Herbalism
  end
  
   if name == Skinning then TPProfSkinning = TPProC3..skillLevel..TPProC4.."/"..TPProC2..maxSkillLevel..TPProC1.."   "..Skinning
    end
  end
  
    if TPProfAlchemy or TPProfBlacksmithing or TPProfEnchanting or TPProfEngineering or TPProfLeatherworking or TPProfTailoring or TPProfJewelcrafting or TPProfInscription or TPProfSmelting then TitanPanelRightClickMenu_AddSpacer() 
                                                                                                                                                                                                   TitanPanelRightClickMenu_AddTitle(TPProC4..TRADESKILLS..":") 
  end
    
    if TPProfAlchemy then
      info.text = TPProfAlchemy
      info.icon = "Interface\\Icons\\Trade_Alchemy"      
      info.func = function ()CastSpellByName(Alchemy) end      
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)      
  end

    if TPProfBlacksmithing then
      info.text = TPProfBlacksmithing
      info.icon = "Interface\\Icons\\Trade_Blacksmithing" 
      info.func = function ()CastSpellByName(Blacksmithing) end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)     
  end  

    if TPProfDisenchant then
      info.text = TPProfDisenchant
      info.icon = "Interface\\Icons\\Inv_enchant_disenchant" 
      info.func = function () DisenchantButton:Show() end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)     
  end  


    if TPProfEnchanting then
      info.text = TPProfEnchanting
      info.icon = "Interface\\Icons\\Trade_Engraving" 
      info.func = function ()CastSpellByName(Enchanting) end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)     
  end

    if TPProfEngineering then
      info.text = TPProfEngineering
      info.icon = "Interface\\Icons\\Trade_Engineering" 
      info.func = function ()CastSpellByName(Engineering) end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)     
  end

    if TPProfInscription then
      info.text = TPProfInscription
      info.icon = "Interface\\Icons\\INV_Inscription_Tradeskill01"
      info.func = function ()CastSpellByName(Inscription) end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)     
  end

    if TPProfJewelcrafting then
      info.text = TPProfJewelcrafting
      info.icon = "Interface\\Icons\\INV_Misc_Gem_02" 
      info.func = function ()CastSpellByName(Jewelcrafting) end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)    
  end

    if TPProfLeatherworking then
      info.text = TPProfLeatherworking
      info.icon = "Interface\\Icons\\Trade_LeatherWorking" 
      info.func = function ()CastSpellByName(Leatherworking) end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)     
  end 
  
    if TPProfMilling then
      info.text = TPProfMilling
      info.icon = "Interface\\Icons\\Ability_miling" 
      info.func = function () MillingButton:Show() end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)     
  end 
  
    if TPProfProspecting then
      info.text = TPProfProspecting
      info.icon = "Interface\\Icons\\Inv_misc_gem_bloodgem_01" 
      info.func = function () ProspectingButton:Show() end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)     
  end 
  
    if TPProfSmelting then
      info.text = TPProfSmelting
      info.icon = "Interface\\Icons\\Spell_Fire_FlameBlades" 
      info.func = function ()CastSpellByName(Smelting) end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)    
  end  

    if TPProfTailoring then
      info.text = TPProfTailoring
      info.icon = "Interface\\Icons\\Trade_Tailoring" 
      info.func = function ()CastSpellByName(Tailoring) end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)     
  end  
    
    if TPProfCooking or TPProfFirstAid or TPProfFishing or TPProfArchaeology then TitanPanelRightClickMenu_AddSpacer() 
                                                                                  TitanPanelRightClickMenu_AddTitle(TPProC4..SECONDARY_SKILLS) 
  end
    
    if TPProfArchaeology then
      info.text = TPProfArchaeology
      info.icon = "Interface\\Icons\\trade_archaeology"
      info.func = function ()CastSpellByName(Archaeology) end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)      
  end
     
    if TPProfSurvey then
      info.text = TPProfSurvey
      info.icon = "Interface\\Icons\\inv_misc_shovel_01" 
      info.func = function () SurveyButton:Show() end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)     
  end 
    
    if TPProfCooking then
      info.text = TPProfCooking
      info.icon = "Interface\\Icons\\INV_Misc_Food_15"
      info.func = function ()CastSpellByName(Cooking) end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)      
  end
  
    if TPProfFirstAid then
      info.text = TPProfFirstAid
      info.icon = "Interface\\Icons\\Spell_Holy_SealOfSacrifice"
      info.func = function ()CastSpellByName(FirstAid) end
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)      
  end

    if TPProfFishing then
      info.text = TPProfFishing
      info.icon = "Interface\\Icons\\Trade_Fishing"
      info.func = nil
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)    
  end  
     
    if TPProfHerbalism or TPProfMining or TPProfSkinning then TitanPanelRightClickMenu_AddSpacer() 
                                                              TitanPanelRightClickMenu_AddTitle(TPProC4..TPProGath)   
  end  
    
    if TPProfHerbalism then
      info.text = TPProfHerbalism
      info.icon = "Interface\\Icons\\Trade_Herbalism"
      info.func = nil
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)      
  end
      
    if TPProfMining then
      info.text = TPProfMining
      info.icon = "Interface\\Icons\\Trade_Mining"
      info.func = nil
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)      
  end
      
    if TPProfSkinning then
      info.text = TPProfSkinning
      info.icon = "Interface\\Icons\\INV_Misc_Pelt_Wolf_01"
      info.func = nil
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)      
  end
  
    TitanPanelRightClickMenu_AddSpacer() 
    TitanPanelRightClickMenu_AddToggleIcon("Professions")
    
end