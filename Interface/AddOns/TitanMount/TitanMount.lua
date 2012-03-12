--[[
    Name:           Titan Mount
	Description:	Titan Panel plugin for mounting.
	Author:         Suddendeath2000
	Version:        4.0.0
    --]]

local MountID = "Mount"
local MountVersion = "4.0.0"
local MountC1 = "|cffffffff"
local MountC2 = "|cff993300"
local MountC3 = "|cff00ff00"
local MountC4 = "|cffffcc00"
local MountC5 = "|cff999999"
local MountAC = "A to C"
local MountDF = "D to F"
local MountGI = "G to I"
local MountJL = "J to L"
local MountMO = "M to O"
local MountPR = "P to R"
local MountSU = "S to U"
local MountVX = "V to X"
local MountYZ = "Y to Z"
local TPMountSFM = true
local mount = nil
local mountSpell = nil
local mountNumber = nil

function TitanPanelMountButton_OnLoad(self)
    DEFAULT_CHAT_FRAME:AddMessage(MountC1.."Titan Panel "..MountC2.."["..MountID.."] "..MountC1.."v"..MountC2..MountVersion.." "..MountC1.."by |cff999999Suddendeath2000")
    
    TitanPanelMountButton:RegisterEvent("ADDON_LOADED")
    TitanPanelMountButton:RegisterEvent("PLAYER_LOGOUT")
  
    self.registry = {
		id = MountID,
	    version = MountVersion,
        menuText = MountID,
        buttonTextFunction = "TitanPanelMountButton_GetButtonText",	
        category = "General",
        tooltipTitle = MountC4..MountID,
		tooltipTextFunction = "TitanPanelMountButton_GetTooltipText",
        iconButtonWidth = 16,
        iconWidth = 16,        
        savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,  
            ShowTooltipText = 1,
            ShowMenuOptions = 1,
            ShowAdvancedMenus = 1,                
            }}
end

local GetCurrentMount, GetMountInfo, GetFavoriteNumbers
do
    -- Helper functions for handling the information about mounts

    -- Return the name and icon of the currently summoned mount, in that order
    -- Returns nil for each if the player seems not to be mounted
    -- Also sets the mountNumber and mountSpell variables if found
    function GetCurrentMount()
        local summoned, name, icon, spell
        for i = 1, GetNumCompanions(MountID) do
            _, name, spell, icon, summoned = GetCompanionInfo(MountID,i)
            if summoned then
                mountNumber = i
                mountSpell = spell
                return name, icon
            end
        end
        return nil, nil
    end

    -- Returns the information for the current mountNumber and mountSpell
    -- Note that mountNumber is just a cache that usually prevents us from going through all the companions
    -- If mountNumber and mountSpell don't exist, mountNumber is updated to reflect the companion
    -- referenced in mountSpell, unless mountSpell is nil in which case that is updated.
    function GetMountInfo()
        local name, icon, spell
        if mountNumber == nil then
            return nil, nil
        end
        _, name, spell, icon = GetCompanionInfo(MountID, mountNumber)
        if spell ~= mountSpell then
            if mountSpell == nil then
                mountSpell = spell
            else
                for i = 1, GetNumCompanions(MountID) do
                    _, name, spell, icon = GetCompanionInfo(MountID, i)
                    if spell == mountSpell then
                        mountNumber = i
                        break
                    end
                end
            end
        end
        return name, icon
    end

    -- Returns the correct index and spell number for a favorite
    function GetFavoriteNumbers(favNumber, favSpell)
        if favNumber == nil then
            return nil, nil
        end

        local spell
        _, _, spell, _ = GetCompanionInfo(MountID, favNumber)
        if spell ~= favSpell then
            if favSpell == nil then
                return favNumber, spell
            else
                for i = 1, GetNumCompanions(MountID) do
                    _, _, spell, _ = GetCompanionInfo(MountID, i)
                    if spell == favSpell then
                        return i, favSpell
                    end
                end
            end
        end
        return favNumber, favSpell
    end
end

function TitanPanelMountButton_GetButtonText(event)
    local Button = TitanUtils_GetButton(MountID, true)
    local mountName, mountIcon, mountColor    
    -- No mounts found
    if GetCompanionInfo(MountID, 1) == nil then mountName = "No Mounts Found"
                               mountIcon = "Interface\\Icons\\INV_Misc_QuestionMark"
      -- Not mounted
      elseif IsMounted() ~= 1 then mountName = "None"
                                   mountIcon = "Interface\\minimap\\TRACKING\\StableMaster"
        -- On Taxi
        elseif UnitOnTaxi("player") then mountName = "On Taxi"
                                         mountIcon = "Interface\\CURSOR\\taxi"
          -- Mounted, and cached
          elseif mountNumber ~= nil then mountName, mountIcon = GetMountInfo()
            -- Mounted, but not cached
            else mountName, mountIcon = GetCurrentMount()
    end
    if IsOutdoors() == nil then
        mountColor = MountC5
    else
        mountColor = MountC3
    end
    Button.registry.icon = mountIcon
    return "Mount: "..mountColor..mountName
end

function TitanPanelMountButton_GetTooltipText()    
        if IsMounted() then
            if mountNumber == nil then
                GetCurrentMount()
            end
            return MountC3.."Right-click for Mount Menu\n"..MountC3.."Double Left-click to Dismount"
        else
            if mountNumber == nil then
                return MountC3.."Right-click for Mount Menu\n"..MountC3.."Double Left-click to Recall Last Mount"
            else
                local mountName
                mountName = GetMountInfo()
                return MountC3.."Right-click for Mount Menu\n"..MountC3.."Double Left-click to Recall "..MountC4..mountName
           
        end
    end
end

local PrepareMountSubMenu, ShowFavorite, ShowMenuButton
do
    -- Helper functions for building the menu

    -- Build the submenu for a selection of mount
    -- title if the title of the menu, lower and upper are the uppercase letters from which and to which
    -- the mounts are shown.
    function PrepareMountSubMenu(title, lower, upper)
        local MountTestName, MountTestChecked
        local StartChar
        local info = {}
        TitanPanelRightClickMenu_AddTitle(title, UIDROPDOWNMENU_MENU_LEVEL)

        for i = 1, GetNumCompanions(MountID) do
            _, MountTestName, _, _, MountTestChecked = GetCompanionInfo(MountID, i)
            StartChar = strupper(strsub(MountTestName, 1, 1))            
            if StartChar >= lower and StartChar <= upper then                
                info.text = MountTestName
                info.checked = MountTestChecked
                info.func = function() TitanPanelMountButton_MountToggle(MountID, i) end
                UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)               
                end           
            end             
        end
        

    -- Shows a single favorite line in the main drop down
    -- favorite is the index of the favorite mount, number the number of the favorite (1 for the first, 2 for the second, etc)
    -- modifier is the modifier key for setting that favorite
    function ShowFavorite(favorite, number, modifier)
        local info = {}
        if favorite == nil then
            info.text = MountC3.."Favorite #"..number
            info.checked = nil
            info.func = function() UIErrorsFrame:AddMessage("To set, hold down "..modifier.." and select mount.") end
        else
            local name, checked
            _, name, _, _, checked = GetCompanionInfo(MountID, favorite)
            info.text = MountC3..name
            info.checked = checked
            info.func = function() TitanPanelMountButton_MountToggle(MountID, favorite) end
        end
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    end

    -- Shows the menu button for a submenu with title title
    function ShowMenuButton(title)
        local info = {}
        info.text = title
        info.func = nil
        info.value = title
        info.checked = nil
        info.hasArrow = 1		
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    end
end

function TitanPanelRightClickMenu_PrepareMountMenu()
          if UIDROPDOWNMENU_MENU_LEVEL == 2 then
            -- We're in a submenu, build it
            if UIDROPDOWNMENU_MENU_VALUE == MountAC then
                PrepareMountSubMenu(MountAC, "A", "C")
            elseif UIDROPDOWNMENU_MENU_VALUE == MountDF then
                PrepareMountSubMenu(MountDF, "D", "F")
            elseif UIDROPDOWNMENU_MENU_VALUE == MountGI then
                PrepareMountSubMenu(MountGI, "G", "I")
            elseif UIDROPDOWNMENU_MENU_VALUE == MountJL then
                PrepareMountSubMenu(MountJL, "J", "L")
            elseif UIDROPDOWNMENU_MENU_VALUE == MountMO then
                PrepareMountSubMenu(MountMO, "M", "O")
            elseif UIDROPDOWNMENU_MENU_VALUE == MountPR then
                PrepareMountSubMenu(MountPR, "P", "R")
            elseif UIDROPDOWNMENU_MENU_VALUE == MountSU then
                PrepareMountSubMenu(MountSU, "S", "U")
            elseif UIDROPDOWNMENU_MENU_VALUE == MountVX then
                PrepareMountSubMenu(MountVX, "V", "X")
            elseif UIDROPDOWNMENU_MENU_VALUE == MountYZ then
                PrepareMountSubMenu(MountYZ, "Y", "Z")
            end
        else
            -- Build the main menu
            TitanPanelRightClickMenu_AddTitle(MountID)    
            TitanPanelRightClickMenu_AddSpacer()
        
            -- The favourites, first call GetFavoriteNumbers to ensure the numbers are in sync again
            TitanMountFav1, TitanMountFavSpell1 = GetFavoriteNumbers(TitanMountFav1, TitanMountFavSpell1)
            ShowFavorite(TitanMountFav1, 1, "Alt")
            TitanMountFav2, TitanMountFavSpell2 = GetFavoriteNumbers(TitanMountFav2, TitanMountFavSpell2)
            ShowFavorite(TitanMountFav2, 2, "Control")
            TitanMountFav3, TitanMountFavSpell3 = GetFavoriteNumbers(TitanMountFav3, TitanMountFavSpell3)
            ShowFavorite(TitanMountFav3, 3, "Shift")
           
            TitanPanelRightClickMenu_AddSpacer()
            
            -- Add the buttons for the submenus 
            local MountTestSetName, ShowSet            
            for i = 1, GetNumCompanions(MountID) do
              _, MountTestSetName, _, _, _ = GetCompanionInfo(MountID, i)
              ShowSet = strupper(strsub(MountTestSetName, 1, 1))
            
            if ShowSet >= "A" and ShowSet <= "C" then ShowSetAC = true end
            if ShowSet >= "D" and ShowSet <= "F" then ShowSetDF = true end
            if ShowSet >= "G" and ShowSet <= "I" then ShowSetGI = true end
            if ShowSet >= "J" and ShowSet <= "L" then ShowSetJL = true end
            if ShowSet >= "M" and ShowSet <= "O" then ShowSetMO = true end
            if ShowSet >= "P" and ShowSet <= "R" then ShowSetPR = true end
            if ShowSet >= "S" and ShowSet <= "U" then ShowSetSU = true end
            if ShowSet >= "V" and ShowSet <= "X" then ShowSetVX = true end
            if ShowSet >= "Y" and ShowSet <= "Z" then ShowSetYZ = true end
            end
            
            if ShowSetAC == true then ShowMenuButton(MountAC) end
            if ShowSetDF == true then ShowMenuButton(MountDF) end
            if ShowSetGI == true then ShowMenuButton(MountGI) end
            if ShowSetJL == true then ShowMenuButton(MountJL) end
            if ShowSetMO == true then ShowMenuButton(MountMO) end
            if ShowSetPR == true then ShowMenuButton(MountPR) end
            if ShowSetSU == true then ShowMenuButton(MountSU) end
            if ShowSetVX == true then ShowMenuButton(MountVX) end
            if ShowSetYZ == true then ShowMenuButton(MountYZ) end   
      
            TitanPanelRightClickMenu_AddSpacer()
        
            -- The reset button
            if TitanMountFav3 ~= nil or TitanMountFav2 ~= nil or TitanMountFav1 ~= nil then
                local info = {}       
                info.text = "Reset Favorites"
                info.checked = nil
                info.value = nil
                info.hasArrow = nil
                info.func = function() TitanMountFav3 = nil; TitanMountFav2 = nil; TitanMountFav1 = nil; UIErrorsFrame:AddMessage(MountC3.."Titan Panel [Mount] Favorites Cleared") end
                UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
            end
          
            TitanPanelRightClickMenu_AddToggleIcon(MountID)
      
    end   
end
 
function TitanPanelMountButton_MountToggle(MountID, i)
    local name
    if IsAltKeyDown() then
        TitanMountFav1 = i
        _, _, TitanMountFavSpell1 = GetCompanionInfo(MountID,i)
        _, name, _, _, _ = GetCompanionInfo(MountID, TitanMountFav1)
        UIErrorsFrame:AddMessage(MountC3.."Favorite #1 set to "..name)
        TitanUtils_CloseRightClickMenu()
      elseif IsControlKeyDown() then
          TitanMountFav2 = i
          _, _, TitanMountFavSpell2 = GetCompanionInfo(MountID,i)
          _, name, _, _, _ = GetCompanionInfo(MountID, TitanMountFav2)
          UIErrorsFrame:AddMessage(MountC3.."Favorite #2 set to "..name)
          TitanUtils_CloseRightClickMenu()
        elseif IsShiftKeyDown() then
            TitanMountFav3 = i
            _, _, TitanMountFavSpell3 = GetCompanionInfo(MountID,i)
            _, name, _, _, _ = GetCompanionInfo(MountID, TitanMountFav3)
            UIErrorsFrame:AddMessage(MountC3.."Favorite #3 set to "..name)
            TitanUtils_CloseRightClickMenu()
    end
    if (not IsModifierKeyDown()) and IsMounted() then
        Dismount()
    end
    if (not IsModifierKeyDown()) then
        CallCompanion(MountID, i)
        TitanUtils_CloseRightClickMenu()
        _, _, mountSpell, _, _ = GetCompanionInfo(MountID, i)
        mountNumber = i
    end
end

function TitanPanelMountButton_OnDoubleClick(button)
    if IsMounted() then
        Dismount()
    elseif button == "LeftButton" and mountNumber ~= nil then
        -- Make sure mountNumber is in sync with mountSpell
        GetMountInfo()
        CallCompanion(MountID, mountNumber)
    end
end

function TitanPanelMountButton_OnEvent(event, arg1)
    if event == "ADDON_LOADED" then
        mountNumber = mountNumberOver
        mountSpell = mountSpellOver
    end    
    if event == "PLAYER_LOGOUT" then
        mountNumberOver = mountNumber
        mountSpellOver = mountSpell
    end
end

function TitanPanelMountButton_OnUpdate(self)         
    TitanPanelButton_UpdateButton(MountID)
end
