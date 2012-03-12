--[[
    Name:           Titan Recount
	Description:	Titan Panel interface for Recount.
       Recount is authored by Elsia and Cryect.
	Author:         Suddendeath2000
	Version:        4.0.0
    --]]

local TPRID = "Recount"
local TPRVersion = "4.0.0"
local TPRC1 = "|cffffffff"
local TPRC2 = "|cff993300"
local TPRC3 = "|cff00ff00"
local TPRC4 = "|cffffcc00"
local TPRRealtime = "Realtime Graphs"
local TPRRaid = "Raid Graphs"
local TPRWindow = "Window Type"
local TPRDPS = "Damage Stats"
local TPRHealing = "Healing Stats"
local TPREnergy = "Energy Stats"
local TPROther = "Other Stats"

function TitanPanelRecountButton_OnLoad(self)
    DEFAULT_CHAT_FRAME:AddMessage(TPRC1.."Titan Panel "..TPRC2.."[Recount] "..TPRC1.."v"..TPRC2..TPRVersion.." "..TPRC1.."by |cff999999Suddendeath2000")
       
    self.registry = {
		id = TPRID,
	    version = TPRVersion,
        menuText = TPRID,       
        category = "Interface",
        tooltipTitle = TPRC4..TPRID,
		tooltipTextFunction = "TitanPanelRecountButton_GetTooltipText",
        icon = "Interface\\AddOns\\TitanRecount\\TitanRecount",
        iconButtonWidth = 16,        
        iconWidth = 16,        
        savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,  
            ShowTooltipText = 1,
            ShowMenuOptions = 1,
            ShowAdvancedMenus = 1, 
            DisplayOnRightSide = 1,
            }}
end

function TitanPanelRecountButton_GetTooltipText()
    return TPRC3.."Double Left-Click to Toggle Selected Main Window\n"..TPRC3.."Right-click to Open Options"
end

function TitanPanelRecountButton_OnDoubleClick(button)
    if button == "LeftButton" then
      if Recount.MainWindow:IsVisible() then Recount.MainWindow:Hide()
        else Recount.MainWindow:Show(); Recount:RefreshMainWindow()
    end  
  end
end

function TitanPanelRightClickMenu_PrepareRecountMenu()
    local info = {}

    if  ( UIDROPDOWNMENU_MENU_LEVEL == 3 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPRDPS )then
      TitanPanelRightClickMenu_AddTitle(TPRDPS, UIDROPDOWNMENU_MENU_LEVEL)
      
    info.text = "Damage Done"
    info.checked = Recount.db.profile.MainWindowMode == 1    
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(1) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    info.text = "DPS"
    info.checked = Recount.db.profile.MainWindowMode == 2
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(2) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
    info.text = "Friendly Fire"
    info.checked = Recount.db.profile.MainWindowMode == 3
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(3) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)  
      
    info.text = "Damage Taken"
    info.checked = Recount.db.profile.MainWindowMode == 4
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(4) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 3 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPRHealing )then
      TitanPanelRightClickMenu_AddTitle(TPRHealing, UIDROPDOWNMENU_MENU_LEVEL)
    
    info.text = "Healing Done"
    info.checked = Recount.db.profile.MainWindowMode == 5
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(5) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    info.text = "Healing Taken"
    info.checked = Recount.db.profile.MainWindowMode == 6
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(6) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
    info.text = "Overhealing Done"
    info.checked = Recount.db.profile.MainWindowMode == 7
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(7) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)  
    
    elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 3 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPREnergy )then
      TitanPanelRightClickMenu_AddTitle(TPREnergy, UIDROPDOWNMENU_MENU_LEVEL) 
     
    info.text = "Mana Gained"
    info.checked = Recount.db.profile.MainWindowMode == 17
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(17) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    info.text = "Energy Gained"
    info.checked = Recount.db.profile.MainWindowMode == 18
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(18) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
    info.text = "Rage Gained"
    info.checked = Recount.db.profile.MainWindowMode == 19
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(19) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)  
      
    info.text = "Runic PowerGained"
    info.checked = Recount.db.profile.MainWindowMode == 20
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(20) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 3 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPROther )then
      TitanPanelRightClickMenu_AddTitle(TPROther, UIDROPDOWNMENU_MENU_LEVEL)
      
    info.text = "Deaths"
    info.checked = Recount.db.profile.MainWindowMode == 8
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(8) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    info.text = "DOT Uptime"
    info.checked = Recount.db.profile.MainWindowMode == 9
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(9) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    info.text = "HOT Uptime"
    info.checked = Recount.db.profile.MainWindowMode == 10
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(10) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
    info.text = "Activity"
    info.checked = Recount.db.profile.MainWindowMode == 11
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(11) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)  
      
    info.text = "Dispels"
    info.checked = Recount.db.profile.MainWindowMode == 12
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(12) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    info.text = "Dispelled"
    info.checked = Recount.db.profile.MainWindowMode == 13
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(13) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    info.text = "Interrupts"
    info.checked = Recount.db.profile.MainWindowMode == 14
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(14) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
    info.text = "Ressers"
    info.checked = Recount.db.profile.MainWindowMode == 15
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(15) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)  
      
    info.text = "CC Breakers"
    info.checked = Recount.db.profile.MainWindowMode == 16
    info.func =  function() Recount.MainWindow:Show() Recount:SetMainWindowMode(16) end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

    elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPRRealtime )then
      TitanPanelRightClickMenu_AddTitle(TPRRealtime, UIDROPDOWNMENU_MENU_LEVEL)
      
    info.text = "Realtime FPS"
    info.func =  function() Recount:CreateRealtimeWindow("FPS","FPS","") end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL) 
    
    info.text = "Realtime Latency"
    info.func =  function() Recount:CreateRealtimeWindow("Latency","LAG","") end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL) 
    
    info.text = "Upstream Traffic"
    info.func =  function() Recount:CreateRealtimeWindow("Upstream Traffic","UP_TRAFFIC","") end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    info.text = "Downstream Traffic"
    info.func =  function() Recount:CreateRealtimeWindow("Downstream Traffic","DOWN_TRAFFIC","") end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
    info.text = "Available Bandwidth"
    info.func =  function() Recount:CreateRealtimeWindow("Bandwidth Available","AVAILABLE_BANDWIDTH","") end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
    elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPRRaid )then
      TitanPanelRightClickMenu_AddTitle(TPRRaid, UIDROPDOWNMENU_MENU_LEVEL)
      
    info.text = "Raid Damage Per Second"
    info.func =  function() Recount:CreateRealtimeWindow("!RAID","DAMAGE","Raid DPS") end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

    info.text = "Raid Damage Taken Per Second"
    info.func =  function() Recount:CreateRealtimeWindow("!RAID","DAMAGETAKEN","Raid DTPS") end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
        
    info.text = "Raid Healing Per Second"
    info.func =  function() Recount:CreateRealtimeWindow("!RAID","HEALING","Raid HPS") end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)  
      
    info.text = "Raid Healing Taken Per Second"
    info.func =  function() Recount:CreateRealtimeWindow("!RAID","HEALINGTAKEN","Raid HTPS") end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)    
     
    elseif  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and ( UIDROPDOWNMENU_MENU_VALUE == TPRWindow )then
      TitanPanelRightClickMenu_AddTitle(TPRWindow, UIDROPDOWNMENU_MENU_LEVEL)
     
    info.text = "Damage Stats"
    info.value = TPRDPS
    info.hasArrow = 2
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL) 
    
    info.text = "Healing Stats"
    info.value = TPRHealing
    info.hasArrow = 2
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)      
    
    info.text = "Energy Stats"
    info.value = TPREnergy
    info.hasArrow = 2
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL) 
    
    info.text = "Other Stats"
    info.value = TPROther
    info.hasArrow = 2
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    else
    
    TitanPanelRightClickMenu_AddTitle(TPRID)
    TitanPanelRightClickMenu_AddSpacer()   
    
    info.text = "Realtime Graphs"
    info.value = TPRRealtime
    info.hasArrow = 1
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL) 
    
    info.text = "Raid Graphs"
    info.value = TPRRaid
    info.hasArrow = 1
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    info.text = "Window Type"
    info.value = TPRWindow
    info.hasArrow = 1
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    TitanPanelRightClickMenu_AddSpacer()
    
    info.text = "Report Window"
    info.value = nil
    info.hasArrow = nil
    info.func = function() Recount:ShowReport("Main",Recount.ReportData) end    
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)    
    
    info.text = "Config Window"
    info.value = nil
    info.hasArrow = nil
    info.func = function()  Recount:ShowConfig() end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

    info.text = "Reset Data"
    info.value = nil
    info.hasArrow = nil
    info.func = function() Recount:ShowReset() end
    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
  end 
end