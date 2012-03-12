-- ********************************************************************************
-- Easy Misdirection (EasyMD)
-- The easiest way to create/edit a misdirection macro.
-- By: Shenton
--
-- LDB.lua
-- ********************************************************************************

-- If EasyMD core is not loaded stop the script
if ( not EasyMD ) then return; end

local L = LibStub("AceLocale-3.0"):GetLocale("EasyMD");
local LDB = EasyMD:NewModule(L["MODULE_NAME_LDB"], "AceEvent-3.0");
LDB.libIcon = LibStub("LibDBIcon-1.0");

-- ********************************************************************************
-- Variables or "constants"
-- ********************************************************************************

-- Local LUA functions
local sformat, pairs, ipairs = string.format, pairs, ipairs;

-- Icon
if ( EasyMD.class == "HUNTER" ) then
    LDB.icon = "Interface\\ICONS\\Ability_Hunter_Misdirection";
else
    LDB.icon = "Interface\\ICONS\\Ability_Rogue_TricksOftheTrade";
end

-- ********************************************************************************
-- Dropdown menus
-- ********************************************************************************

--- The dropdown menu structure function
-- when the player is solo
-- @usage Called by ToggleDropDownMenu()
-- @param self Frame object
-- @param level Nesting level
local function SoloMenu(self, level)
    if ( not level ) then return; end

    wipe(self.info);

    if ( level == 1 ) then
        -- Menu title
        self.info.isTitle = true;
        self.info.text = L["SET_MACRO_TO"];
        self.info.notCheckable = true;
        UIDropDownMenu_AddButton(self.info, level);

        -- Set options
        self.info.keepShownOnClick = true;
        self.info.hasArrow = true;
        self.info.isTitle = nil;
        self.info.disabled = nil;

        -- Set pet
        if ( EasyMD.class == "HUNTER" ) then
            self.info.text = "   "..L["YOUR_PET"];
            self.info.value = L["YOUR_PET"];
            self.info.func = function() EasyMD:SetMacro(L["MACRO_PET"]); end;
            UIDropDownMenu_AddButton(self.info, level);
        end

        -- Set focus
        self.info.text = "   "..L["FOCUS"];
        self.info.value = L["FOCUS"];
        self.info.func = function() EasyMD:SetMacro(L["MACRO_FOCUS"]); end;
        UIDropDownMenu_AddButton(self.info, level);

        -- Set options
        self.info.keepShownOnClick = nil;
        self.info.hasArrow = nil;

        -- Close
        self.info.text = L["CLOSE"];
        self.info.func = function() CloseDropDownMenus(); end;
        UIDropDownMenu_AddButton(self.info, level);
    elseif ( level == 2 ) then
        wipe(self.info);

        -- Set options
        self.info.notCheckable = true;

        for k,v in pairs(EasyMD.instancesTypes) do
            if ( EasyMD:TemplateExists(v) ) then
                if ( UIDROPDOWNMENU_MENU_VALUE == L["YOUR_PET"] ) then
                    self.info.text = "   "..k;
                    self.info.func = function() EasyMD:SetMacro(L["MACRO_PET"], nil, nil, v); end;
                    UIDropDownMenu_AddButton(self.info, level);
                elseif ( UIDROPDOWNMENU_MENU_VALUE == L["FOCUS"] ) then
                    self.info.text = "   "..k;
                    self.info.func = function() EasyMD:SetMacro(L["MACRO_FOCUS"], nil, nil, v); end;
                    UIDropDownMenu_AddButton(self.info, level);
                end
            end
        end
    end
end

--- The dropdown menu structure function
-- when the player is in party
-- @usage Called by ToggleDropDownMenu()
-- @param self Frame object
-- @param level Nesting level
local function PartyMenu(self, level)
    if ( not level ) then return; end

    local members = EasyMD:GetPartyMembers();

    if ( not members ) then return; end

    wipe(self.info);

    if ( level == 1 ) then
        -- Menu title
        self.info.isTitle = true;
        self.info.text = L["SET_MACRO_TO"];
        self.info.notCheckable = true;
        UIDropDownMenu_AddButton(self.info, level);

        -- Set options
        self.info.keepShownOnClick = true;
        self.info.hasArrow = true;
        self.info.isTitle = nil;
        self.info.disabled = nil;

        -- Party members
        for _,t in ipairs(members) do
            self.info.text = "   "..t.name;
            self.info.value = t.name;
            self.info.colorCode = EasyMD.color[t.class];
            self.info.func = function() EasyMD:SetMacro(t.name); end;
            --self.info.icon = "Interface\\AddOns\\EasyMD\\Graphics\\ROLE-"..t.role;
            UIDropDownMenu_AddButton(self.info, level);
        end

        -- Blank separator
        wipe(self.info);
        self.info.notCheckable = true;
        self.info.disabled = true;
        UIDropDownMenu_AddButton(self.info, level);

        -- Set options
        self.info.keepShownOnClick = true;
        self.info.hasArrow = true;
        self.info.disabled = nil;

        -- Set pet
        if ( EasyMD.class == "HUNTER" ) then
            self.info.text = "   "..L["YOUR_PET"];
            self.info.value = L["YOUR_PET"];
            self.info.func = function() EasyMD:SetMacro(L["MACRO_PET"]); end;
            UIDropDownMenu_AddButton(self.info, level);
        end

        -- Set focus
        self.info.text = "   "..L["FOCUS"];
        self.info.value = L["FOCUS"];
        self.info.func = function() EasyMD:SetMacro(L["MACRO_FOCUS"]); end;
        UIDropDownMenu_AddButton(self.info, level);

        -- Close
        self.info.text = L["CLOSE"];
        self.info.hasArrow = nil;
        self.info.func = function() CloseDropDownMenus(); end;
        UIDropDownMenu_AddButton(self.info, level);
    elseif ( level == 2 ) then
        wipe(self.info);

        -- Set options
        self.info.notCheckable = true;

        for k,v in pairs(EasyMD.instancesTypes) do
            if ( EasyMD:TemplateExists(v) ) then
                if ( UIDROPDOWNMENU_MENU_VALUE == L["YOUR_PET"] ) then
                    self.info.text = "   "..k;
                    self.info.func = function() EasyMD:SetMacro(L["MACRO_PET"], nil, nil, v); end;
                    UIDropDownMenu_AddButton(self.info, level);
                elseif ( UIDROPDOWNMENU_MENU_VALUE == L["FOCUS"] ) then
                    self.info.text = "   "..k;
                    self.info.func = function() EasyMD:SetMacro(L["MACRO_FOCUS"], nil, nil, v); end;
                    UIDropDownMenu_AddButton(self.info, level);
                end
            end
        end

        for _,t in ipairs(members) do
            for k,v in pairs(EasyMD.instancesTypes) do
                if ( EasyMD:TemplateExists(v) ) then
                    if ( UIDROPDOWNMENU_MENU_VALUE == t.name ) then
                        self.info.text = "   "..k;
                        self.info.func = function() EasyMD:SetMacro(t.name, nil, nil, v); end;
                        UIDropDownMenu_AddButton(self.info, level);
                    end
                end
            end
        end
    end
end

--- The dropdown menu structure function
-- when the player is in raid
-- @usage Called by ToggleDropDownMenu()
-- @param self Frame object
-- @param level Nesting level
local function RaidMenu(self, level)
    if ( not level ) then return; end

    local members = EasyMD:GetRaidMembers();
    local classes = EasyMD:GetRaidClasses(members);

    if ( not members ) then return; end

    wipe(self.info);

    if ( level == 1 ) then
        -- Menu title
        self.info.isTitle = true;
        self.info.text = L["SET_MACRO_TO"];
        self.info.notCheckable = true;
        UIDropDownMenu_AddButton(self.info, level);

        -- Set options
        self.info.keepShownOnClick = true;
        self.info.hasArrow = true;
        self.info.disabled = nil;
        self.info.isTitle = nil;

        -- Classes Submenu
        -- Death Knight
        if ( classes["DEATHKNIGHT"] ) then
            self.info.text = "   "..L["CLASS_DEATHKNIGHT"];
            self.info.value = "DEATHKNIGHT";
            self.info.colorCode = EasyMD.color["DEATHKNIGHT"];
            UIDropDownMenu_AddButton(self.info, level);
        end
        -- Druid
        if ( classes["DRUID"] ) then
            self.info.text = "   "..L["CLASS_DRUID"];
            self.info.value = "DRUID";
            self.info.colorCode = EasyMD.color["DRUID"];
            UIDropDownMenu_AddButton(self.info, level);
        end
        -- Hunter
        if ( classes["HUNTER"] ) then
            self.info.text = "   "..L["CLASS_HUNTER"];
            self.info.value = "HUNTER";
            self.info.colorCode = EasyMD.color["HUNTER"];
            UIDropDownMenu_AddButton(self.info, level);
        end
        -- Mage
        if ( classes["MAGE"] ) then
            self.info.text = "   "..L["CLASS_MAGE"];
            self.info.value = "MAGE";
            self.info.colorCode = EasyMD.color["MAGE"];
            UIDropDownMenu_AddButton(self.info, level);
        end
        -- Paladin
        if ( classes["PALADIN"] ) then
            self.info.text = "   "..L["CLASS_PALADIN"];
            self.info.value = "PALADIN";
            self.info.colorCode = EasyMD.color["PALADIN"];
            UIDropDownMenu_AddButton(self.info, level);
        end
        -- Priest
        if ( classes["PRIEST"] ) then
            self.info.text = "   "..L["CLASS_PRIEST"];
            self.info.value = "PRIEST";
            self.info.colorCode = EasyMD.color["PRIEST"];
            UIDropDownMenu_AddButton(self.info, level);
        end
        -- Rogue
        if ( classes["ROGUE"] ) then
            self.info.text = "   "..L["CLASS_ROGUE"];
            self.info.value = "ROGUE";
            self.info.colorCode = EasyMD.color["ROGUE"];
            UIDropDownMenu_AddButton(self.info, level);
        end
        -- Shaman
        if ( classes["SHAMAN"] ) then
            self.info.text = "   "..L["CLASS_SHAMAN"];
            self.info.value = "SHAMAN";
            self.info.colorCode = EasyMD.color["SHAMAN"];
            UIDropDownMenu_AddButton(self.info, level);
        end
        -- Warlock
        if ( classes["WARLOCK"] ) then
            self.info.text = "   "..L["CLASS_WARLOCK"];
            self.info.value = "WARLOCK";
            self.info.colorCode = EasyMD.color["WARLOCK"];
            UIDropDownMenu_AddButton(self.info, level);
        end
        -- Warrior
        if ( classes["WARRIOR"] ) then
            self.info.text = "   "..L["CLASS_WARRIOR"];
            self.info.value = "WARRIOR";
            self.info.colorCode = EasyMD.color["WARRIOR"];
            UIDropDownMenu_AddButton(self.info, level);
        end

        -- Blank separator
        wipe(self.info);
        self.info.disabled = true;
        self.info.notCheckable = true;
        UIDropDownMenu_AddButton(self.info, level);

        -- Set options
        self.info.keepShownOnClick = true;
        self.info.hasArrow = true;
        self.info.notCheckable = true;
        self.info.disabled = nil;

        -- Set pet
        if ( EasyMD.class == "HUNTER" ) then
            self.info.text = "   "..L["YOUR_PET"];
            self.info.value = L["YOUR_PET"];
            self.info.func = function() EasyMD:SetMacro(L["MACRO_PET"]); end;
            UIDropDownMenu_AddButton(self.info, level);
        end

        -- Set focus
        self.info.text = "   "..L["FOCUS"];
        self.info.value = L["FOCUS"];
        self.info.func = function() EasyMD:SetMacro(L["MACRO_FOCUS"]); end;
        UIDropDownMenu_AddButton(self.info, level);

        -- Close
        self.info.text = L["CLOSE"];
        self.info.func = function() CloseDropDownMenus(); end;
        UIDropDownMenu_AddButton(self.info, level);
    elseif ( level == 2 ) then
        wipe(self.info);

        -- Set options
        self.info.notCheckable = true;
        self.info.keepShownOnClick = true;
        self.info.hasArrow = true;

        for _, t in ipairs(members) do
            if ( UIDROPDOWNMENU_MENU_VALUE == t.class ) then
                self.info.text = "   "..t.name;
                self.info.value = t.name;
                self.info.func = function() EasyMD:SetMacro(t.name); end;
                UIDropDownMenu_AddButton(self.info, level);
            end
        end

        wipe(self.info);

        -- Set options
        self.info.notCheckable = true;

        for k,v in pairs(EasyMD.instancesTypes) do
            if ( EasyMD:TemplateExists(v) ) then
                if ( UIDROPDOWNMENU_MENU_VALUE == L["YOUR_PET"] ) then
                    self.info.text = "   "..k;
                    self.info.func = function() EasyMD:SetMacro(L["MACRO_PET"], nil, nil, v); end;
                    UIDropDownMenu_AddButton(self.info, level);
                elseif ( UIDROPDOWNMENU_MENU_VALUE == L["FOCUS"] ) then
                    self.info.text = "   "..k;
                    self.info.func = function() EasyMD:SetMacro(L["MACRO_FOCUS"], nil, nil, v); end;
                    UIDropDownMenu_AddButton(self.info, level);
                end
            end
        end
    elseif ( level == 3 ) then
        wipe(self.info);

        -- Set options
        self.info.notCheckable = true;

        for _,t in ipairs(members) do
            for k,v in pairs(EasyMD.instancesTypes) do
                if ( EasyMD:TemplateExists(v) ) then
                    if ( UIDROPDOWNMENU_MENU_VALUE == t.name ) then
                        self.info.text = "   "..k;
                        self.info.func = function() EasyMD:SetMacro(t.name, nil, nil, v); end;
                        UIDropDownMenu_AddButton(self.info, level);
                    end
                end
            end
        end
    end
end

--- The dropdown menu structure function
-- manual input by staticpopup
-- @usage Called by ToggleDropDownMenu()
-- @param self Frame object
-- @param level Nesting level
local function StaticPopupMenu(self, level)
    if ( not level ) then return; end

    wipe(self.info);

    if ( level == 1 ) then
        -- Menu title
        self.info.isTitle = true;
        self.info.text = L["STATICPOPUP_TYPE"];
        self.info.notCheckable = true;
        UIDropDownMenu_AddButton(self.info, level);

        -- Set options
        self.info.disabled = nil;
        self.info.isTitle = nil;

        for k,v in pairs(EasyMD.instancesTypes) do
            if ( EasyMD:TemplateExists(v) ) then
                self.info.text = "   "..k;
                self.info.func = function(self)
                    local pop = StaticPopup_Show("EASYMD_MANUAL_ENTRY");
                    if (pop) then pop.instanceType = v ; end
                end;
                UIDropDownMenu_AddButton(self.info, level);
            end
        end

        -- Close
        self.info.text = L["CLOSE"];
        self.info.func = function() CloseDropDownMenus(); end;
        UIDropDownMenu_AddButton(self.info, level);
    end
end

-- ********************************************************************************
-- StaticPopup
-- ********************************************************************************

StaticPopupDialogs["EASYMD_MANUAL_ENTRY"] =
{
    text = L["STATICPOPUP_MESSSAGE"],
    button1 = L["STATICPOPUP_ACCEPT"],
    button2 = L["STATICPOPUP_CANCEL"],
    hasEditBox = true,
    timeout = 0,
    whileDead = false,
    hideOnEscape = true,
    enterClicksFirstButton = true,
    OnShow = function(self) self.button1:Disable(); end,
    EditBoxOnTextChanged = function (self) self:GetParent().button1:Enable(); end,
    EditBoxOnEnterPressed = function(self)
        EasyMD:SetMacro(self:GetText(), nil, nil, self:GetParent().instanceType);
        self:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide(); end,
    OnAccept = function(self) EasyMD:SetMacro(self.editBox:GetText(), nil, nil, self.instanceType); end
};

-- ********************************************************************************
-- Functions
-- ********************************************************************************

--- Show/Hide the minimap
function LDB:ShowHideMinimap()
    if ( LDB.config.profile.icon.hide ) then
        LDB.libIcon:Hide("EasyMDLDBo");
    else
        LDB.libIcon:Show("EasyMDLDBo");
    end
end

--- Uptade the button text
-- @param name The name to display
function LDB:UpdateText(name)
    if ( name ) then
        local _, unitClass = UnitClass(name);

        if ( unitClass ) then
            LDB.obj.text = EasyMD.color[unitClass]..name;
        else
            LDB.obj.text = name;
        end
    end
end

--- Display the menu used to set manually the macro
function LDB:ButtonMenu(clickedFrame)
    local _, instanceType = IsInInstance();

    if ( GetNumRaidMembers() ~= 0 and instanceType ~= "arena" ) then
        CloseDropDownMenus();
        LDB.menuFrame.initialize = RaidMenu;
    elseif ( GetRealNumPartyMembers() ~= 0 ) then
        CloseDropDownMenus();
        LDB.menuFrame.initialize = PartyMenu;
    else
        CloseDropDownMenus();
        LDB.menuFrame.initialize = SoloMenu;
    end
    ToggleDropDownMenu(1, nil, LDB.menuFrame, clickedFrame:GetName(), 0, 0);
    GameTooltip:Hide();
end

--- Input name
function LDB:InputName(clickedFrame)
    if ( LDB.menuFrame.initialize ~= StaticPopupMenu ) then
        CloseDropDownMenus();
        LDB.menuFrame.initialize = StaticPopupMenu;
    end
    ToggleDropDownMenu(1, nil, LDB.menuFrame, clickedFrame:GetName(), 0, 0);
    GameTooltip:Hide();
end

--- Callback function for event PLAYER_LOGIN
function LDB:PLAYER_LOGIN()
    LDB:UpdateText(EasyMD:GetTarget(true));
end

-- ********************************************************************************
-- Configuration
-- ********************************************************************************

--- Default configuration table
local defaultDB =
{
    profile =
    {
        titan = false,
        enabled = true,
        icon =
        {
            hide = false
        }
    }
};

function LDB:Config()
    return
    {
        LDBHeader =
        {
            order = 0,
            name = L["MODULE_NAME_LDB"],
            type = "header"
        },
        icon =
        {
            order = 1,
            name = L["CONFIG_MINIMAP_NAME"],
            desc = L["CONFIG_MINIMAP_DESC"],
            type = "toggle",
            width ="full",
            set = function(info, val) 
                LDB.config.profile.icon.hide = not val;
                LDB:ShowHideMinimap();
            end,
            get = function(info) return not LDB.config.profile.icon.hide; end
        },
        titan =
        {
            order = 2,
            name = L["CONFIG_TITAN_NAME"],
            desc = L["CONFIG_TITAN_DESC"],
            type = "toggle",
            width ="full",
            set = function(info, val) LDB.config.profile.titan = val; end,
            get = function(info) return LDB.config.profile.titan; end
        }
    };
end

-- ********************************************************************************
-- Main
-- ********************************************************************************

--- AceAddon callback
-- Called after the addon is fully loaded
function LDB:OnInitialize()
    LDB.config = EasyMD.config:RegisterNamespace("LDB", defaultDB);
    if not LDB.config.profile.enabled then LDB:SetEnabledState(false); end
end

--- AceAddon callback
-- Called during the PLAYER_LOGIN event
function LDB:OnEnable()
    -- LDB
    if ( LibStub("LibDataBroker-1.1"):GetDataObjectByName("EasyMDLDBo") ) then
        LDB.obj = LibStub("LibDataBroker-1.1"):GetDataObjectByName("EasyMDLDBo");
    else
        LDB.obj = LibStub("LibDataBroker-1.1"):NewDataObject("EasyMDLDBo", {
            type = "data source",
            text = L["NOT_AVAILABLE"],
            label = L["ADDON_NAME"],
            icon = LDB.icon,
            tocname = "EasyMD",
            OnClick = function(self, button)
                if ( LDB.config.profile.titan ) then -- Titan
                    if ( EasyMD.modules[L["MODULE_NAME_TANKS"]] ) then
                        if ( button == "LeftButton" ) then
                            if ( IsShiftKeyDown() ) then
                                EasyMD.modules[L["MODULE_NAME_TANKS"]]:CicleTanks();
                            elseif ( IsControlKeyDown() ) then
                                LDB:InputName(self);
                            else
                                LDB:ButtonMenu(self);
                            end
                        elseif ( button == "MiddleButton" ) then
                            EasyMD.aceConfigDialog:Open("Easy Misdirection Configuration");
                        end
                    else
                        if ( button == "LeftButton" ) then
                            if ( IsShiftKeyDown() ) then
                                LDB:InputName(self);
                            else
                                LDB:ButtonMenu(self);
                            end
                        elseif ( button == "MiddleButton" ) then
                            EasyMD.aceConfigDialog:Open("Easy Misdirection Configuration");
                        end
                    end
                else -- Data Broker & Minimap button
                    if ( EasyMD.modules[L["MODULE_NAME_TANKS"]] ) then
                        if (button == "LeftButton") then
                            if ( IsShiftKeyDown() ) then
                                LDB:InputName(self);
                            else
                                EasyMD.modules[L["MODULE_NAME_TANKS"]]:CicleTanks();
                            end
                        elseif ( button == "RightButton" ) then
                            LDB:ButtonMenu(self);
                        elseif ( button == "MiddleButton" ) then
                            EasyMD.aceConfigDialog:Open("Easy Misdirection Configuration");
                        end
                    else
                        if (button == "LeftButton") then
                            LDB:InputName(self);
                        elseif ( button == "RightButton" ) then
                            LDB:ButtonMenu(self);
                        elseif ( button == "MiddleButton" ) then
                            EasyMD.aceConfigDialog:Open("Easy Misdirection Configuration");
                        end
                    end
                end
            end,
            OnTooltipShow = function(tooltip)
                local name = EasyMD:GetTarget(true);
                local unitClass;

                if ( UnitExists(name) ) then
                    _, unitClass = UnitClass(name);
                else
                    unitClass = false;
                end

                tooltip:AddDoubleLine(EasyMD.color["WHITE"]..L["ADDON_NAME"], EasyMD.color["GREEN"].."v"..EasyMD.version);
                tooltip:AddLine(" ");
                if ( unitClass ) then
                    tooltip:AddLine(sformat(L["MACRO_SET_TO"], EasyMD.color[unitClass]..name));
                else
                    tooltip:AddLine(sformat(L["MACRO_SET_TO"], EasyMD.color["WHITE"]..name));
                end

                tooltip:AddLine(" ");

                if ( LDB.config.profile.titan ) then
                    if ( EasyMD.modules[L["MODULE_NAME_TANKS"]] ) then
                        tooltip:AddLine(L["TOOLTIP_TITAN_TANKS_TIPS"]);
                    else
                        tooltip:AddLine(L["TOOLTIP_TITAN_TIPS"]);
                    end
                else
                    if ( EasyMD.modules[L["MODULE_NAME_TANKS"]] ) then
                        tooltip:AddLine(L["TOOLTIP_TANKS_TIPS"]);
                    else
                        tooltip:AddLine(L["TOOLTIP_TIPS"]);
                    end
                end
            end,
        });
    end

    -- LDBIcon
    if ( not LDB.libIcon:IsRegistered("EasyMDLDBo") ) then LDB.libIcon:Register("EasyMDLDBo", LDB.obj, LDB.config.profile.icon); end

    -- Menu frame & table
    LDB.menuFrame = CreateFrame("Frame", "EasyMDMenuFrame");
    LDB.menuFrame.displayMode = "MENU";
    LDB.menuFrame.info = {};

    -- Events
    LDB:RegisterEvent("PLAYER_LOGIN");
end

--- AceAddon callback
-- Called when the addon is manually disabled
function LDB:OnDisable()
    LDB:UnregisterEvent("PLAYER_LOGIN");
end
