--[[
		Adds user-defined key bindings for secure actions in WoW 2.0
		Deathwing!quel
		qwarlock@gmail.com
		11/18/06 v1.6; 
		8/23/08 v3.0
		8/17/09 v30200
		11/29/09 v30200b
		2/25/10 v30300 - updated UK_MAX_INVENTORY
		10/13/2010 v40000
--]]

UK_VERS = "v40000h"

-- strings for localization (later)
UK_STRING_DATAERROR="UserKey has encountered an unrecoverable data error. All lists have been reset. Please visit your bank to reconstruct your inventory list.";
UK_STRING_STRINGS_DONT_MATCH="UserKey: data in UserKeySlotN does not match UserKeyBindings[n].text.";
UK_STRING_INVALID_SECTIONNAME="passed Invalid section_name.";
UK_STRING_INVALID_BUTTON_TABLE="passed Invalid button_table. Must contain actionname, action";
UK_STRING_MAXITEMS="A serious error has been found. UserKey believes you have more items than the game allows!"

UserKeyDebug=0;

UK_MAX_INVENTORY = 400;
UK_MAX_SLOT = 14;
UK_MAX_BINDS = 0;
UK_MAX_SPELL_BINDS=0;
UK_MAX_PET_BINDS=0;
UK_MAX_PETCOMMON_BINDS=0;
UK_MAX_INACTIVEPETCOMMON_BINDS=0;
UK_MAX_MACRO_BINDS=0;
UK_MAX_ITEM_BINDS=0;
UK_MAX_MACRO_BINDS = 0;
UK_MAX_USER_BINDS = 0;
UK_MACRO_TYPE = -1;
UK_CHARMACRO_OFFSET = 36	-- WoW 3.0: changed from 19 to 37.

UK_DATA_VALID=0;		-- if this item reaches 3, then UserKey will auto reset all data to attempt recovery.
local UKEvents_Registered = 0; -- attempt to throttle scans during initial startup

UserKeyBindings2 = {};
UserKeyBindings_spells ={};
UserKeyBindings_pet = {};
UserKeyBindings_petcommon = {};
UserKeyBindings_inactivepet = {};
UserKeyBindings_inactivepetcommon = {};
UserKeyBindings_macros = {};
UserKeyBindings_items = {};
UserKeyBindings_macros = {};
UserKeyBindings_user ={};

UserKeyPressedButton = "na";
UserKeyPressedButtonNum = -1;

UserKeyBindingsRecovery ={
	{text="No Spells or Abilities Known",	 bindtype="NA",	action="none",			k="|c00ffff00 Not Bound"},
	{text="Use Scan Button",				 bindtype="NA",	action="none",			k="|c00ffff00 Not Bound"},
};

UserKey_InventorySlots = {
		"Head",
		"Neck",
		"Shoulder",
		"Shirt",
		"Chest",
		"Waist",
		"Legs",
		"Feet",
		"Wrist",
		"Hands",
		"Finger0",
		"Finger1",
		"Trinket0",
		"Trinket1",
		"Back",
		"MainHand",
		"SecondaryHand",
		"Ranged",
		"Tabard",
};

UserKey_CompanionTypes = {
	"CRITTER",
	"MOUNT",
};

function UKDebug(fn,msg)
	if (UserKeyDebug == 1) then
		ChatFrame1:AddMessage("UserKey_" .. fn .. "(): " .. msg);
	end
end
-- ***************************************************************************
function UserKey_OnLoad()
	UKDebug("OnLoad","OnLoad() called.");	
--	UserKeyFrame:RegisterEvent("ADDON_LOADED");	 
	UserKeyFrame:RegisterEvent("PLAYER_ALIVE");	 
	UserKeyFrame:RegisterEvent("PLAYER_ENTERING_WORLD");	 
	UserKeyFrame:RegisterEvent("VARIABLES_LOADED");

	UserKeyUnBind:Disable();
--	getglobal(UserKeyFrameCheckButton:GetName() .. "Text"):SetText("Char Specific");


end

-- ***************************************************************************
function UserKey_OnEvent(self, event, ...)
	local arg1, arg2 = ...;
	if (arg1 ~= nil) then
		UKDebug("OnEvent","event = " .. event .. ", arg1 = " .. arg1);
	elseif (event ~= nil) then
		UKDebug("OnEvent","event = " .. event .. ", arg1 = nil");
	else
		UKDebug("OnEvent","event = nil, arg1 = nil");
	end

--[[
	if (event == "ADDON_LOADED" )then
		if (arg1 ~= "qUserKey" ) then
			return
		end
--]]

	if (event == "PLAYER_ENTERING_WORLD"  ) then
		-- this event fires on both full character login and /console reloadui. This seems to be a sign that the UI has
		-- settled down and stopped firing so many events. It's now safe to register the rest of our events we're
		-- interested in without causing 100 extra scans on startup.

		-- once the UI has settled down, watch for new pets that appear and auto-rescan abilities. Don't register 
		-- this event during OnLoad(). It fires 10 more extra times during initial character login. Also
		-- register events that are likely to mean new/removed spells or items so we can rescan.

		UserKeyFrame:RegisterEvent("PLAYER_BAR_UPDATE");
		UserKeyFrame:RegisterEvent("PLAYER_PET_CHANGED");	
		UserKeyFrame:RegisterEvent("UNIT_PET");		-- have to scan pets continuously since we can only collect their spells when the pet is active
		UserKeyFrame:RegisterEvent("UPDATE_BINDINGS");
		UserKeyFrame:RegisterEvent("BANKFRAME_OPENED");
		UserKeyFrame:RegisterEvent("BANKFRAME_CLOSED");
--		UserKeyFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
--		UserKeyFrame:RegisterEvent("LEARNED_SPELL_IN_TAB");
--		UserKeyFrame:RegisterEvent("UPDATE_MACROS");
--		UserKeyFrame:RegisterEvent("BAG_UPDATE");
--		UserKeyFrame:RegisterEvent("COMPANION_UPDATE")

	elseif (event == "BANKFRAME_OPENED") then
		-- while the bank is open, we need to watch changes to the inventory very closely.
		-- But, conversely, we do not want to scan every time something pops into a bag since we always scan when the 
		-- bindings UI is shown, anyway. Scanning on every bag change causes unecessary lags.

		UserKeyFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
		UserKeyFrame:RegisterEvent("BAG_UPDATE");

	elseif (event == "BANKFRAME_CLOSED") then
		UserKeyFrame:UnregisterEvent("UNIT_INVENTORY_CHANGED");
		UserKeyFrame:UnregisterEvent("BAG_UPDATE");

	elseif (event == "PLAYER_ALIVE" ) then
		-- this event only fires on a full character login (not /console reloadui). after PLAYER_ENTERING_WORLD.
		-- We capture this event to check data corruption. if the data becomes corrupted, we can get stuck in a 
		-- loop loading bad data each time from saved variables, thus causing new errors. Each time we initialize 
		-- the add-on, increment this flag. Each time we complete a scan loop, decrement the flag. If the flag gets 
		-- to 3 (meaning 3 consecutive crashes, then auto reset the data.

		UK_DATA_VALID = UK_DATA_VALID +1;

		if (UK_DATA_VALID > 3) then
			UserKey_ResetAllData();
--			message(UK_STRING_DATAERROR);
			UK_DATA_VALID=0;
		end
		return;	 -- no need to scan again. It already happened at PLAYER_ENTERING_WORLD

	elseif (event == "VARIABLES_LOADED") then
		UserKey_SetupOptions();

	elseif (event == "UNIT_PET" ) then
		-- did our pet change, or someone elses?
		if (arg1 ~= "player") then
			return;	 -- no need to scan, not our pet.
		end
	else
	end 

		-- we have reason to expect something new (probably a new pet with additional spells or
		-- the user opened the bank and we check for new items). 

		--rescan the abilities and bindings to make sure we're current when they open the panel.
	
		-- We probably don't need to rescan here on updated bindings since we always rescan
		-- keybinds when the UserKeyFrame is shown.

	UKDebug("OnEvent","Rescanning due to event: " .. event);
	UserKey_ScanData();
	UserKeyUnBind:Disable();
	UserKeyCancelBind:Disable();
	UserKeyScrollBar_Update();	

end

-- ***************************************************************************
-- Configures the options dialog
function UserKey_SetupOptions()
	UKDebug("SetupOptions","SetupOptions() called.");	

	-- setup configuration panel
	local panel = CreateFrame("FRAME","UserKey_OptionsFrame");
	panel.name = "qUserKey";
	InterfaceOptions_AddCategory(panel);

	-- set the title text
	local ts = panel:CreateFontString("UserKey_OptionsTitle","ARTWORK","GameFontNormalLarge");
	ts:SetPoint("TOPLEFT",16,-16);
	ts:SetText("qUserKey Options " .. UK_VERS);

	-- set the first category title
	ts = panel:CreateFontString("UserKey_OptionsMacroGen","ARTWORK","GameFontHighlight");
	ts:SetPoint("TOPLEFT","UserKey_OptionsTitle","BOTTOMLEFT",-2,-8);
	ts:SetText("Auto Generate Macros for WoW3.0 Mounts/Pets:");

	-- display 3 checkboxes for controlling macro generation
	local cb1 = CreateFrame("CheckButton", "UserKey_OptionsMacroCheckBox1", panel,"OptionsCheckButtonTemplate")
	cb1:SetPoint("TOPLEFT",ts,"BOTTOMLEFT", 0, -4);
	getglobal(cb1:GetName() .. "Text"):SetText("Don't auto generate any mount/companion macros");
	if (UK_MACRO_TYPE == -1) then
		cb1:SetChecked(true);
	else
		cb1:SetChecked(false);
	end
	
	local cb2 = CreateFrame("CheckButton", "UserKey_OptionsMacroCheckBox2", panel,"OptionsCheckButtonTemplate")
	cb2:SetPoint("TOPLEFT","UserKey_OptionsMacroCheckBox1","BOTTOMLEFT", 0, 10);
	getglobal(cb2:GetName() .. "Text"):SetText("Auto generate mount/companion macros as account macros");
	if (UK_MACRO_TYPE == 0) then
		cb2:SetChecked(true);
	else
		cb2:SetChecked(false);
	end

	local cb3 = CreateFrame("CheckButton", "UserKey_OptionsMacroCheckBox3", panel,"OptionsCheckButtonTemplate")
	cb3:SetPoint("TOPLEFT","UserKey_OptionsMacroCheckBox2","BOTTOMLEFT", 0, 10);
	getglobal(cb3:GetName() .. "Text"):SetText("Auto generate mount/companion macros as character macros");
	if (UK_MACRO_TYPE == 1) then
		cb3:SetChecked(true);
	else
		cb3:SetChecked(false);
	end

	-- assign the OnClick handlers for the 3 functions to a) set the proper variable value and b) uncheck the other 2.
	-- prevent the user from unchecking a box. They can only change options by checking a different box. So, if the box
	-- is already checked, force it to stay checked if they click it again.

	cb1:SetScript("OnClick",
		function()
			if (not cb1:GetChecked() ) then
				cb1:SetChecked(true);
				return;
			end
			UK_MACRO_TYPE=-1;
			cb2:SetChecked(false);
			cb3:SetChecked(false);
			UserKey_GenerateMacro();
		end);
	
	cb2:SetScript("OnClick",
		function()
			if (not cb2:GetChecked() ) then
				cb2:SetChecked(true);
				return;
			end
			UK_MACRO_TYPE=0;
			cb1:SetChecked(false);
			cb3:SetChecked(false);
			UserKey_GenerateMacro();
		end);
	
	cb3:SetScript("OnClick",
		function()
			if (not cb3:GetChecked() ) then
				cb3:SetChecked(true);
				return;
			end
			UK_MACRO_TYPE=1;
			cb1:SetChecked(false);
			cb2:SetChecked(false);
			UserKey_GenerateMacro();
		end);

	-- set the debugging category title
	ts = panel:CreateFontString("UserKey_OptionsDebug","ARTWORK","GameFontHighlight");
	ts:SetPoint("TOPLEFT",cb3,"BOTTOMLEFT",-2,-8);
	ts:SetText("Debugging (USE WITH CAUTION):");

	-- enable or disable debugging traces
	local cb4 = CreateFrame("CheckButton", "UserKey_OptionsDebugCheckBox", panel,"OptionsCheckButtonTemplate")
	cb4:SetPoint("TOPLEFT",ts,"BOTTOMLEFT", 0, -4);
	getglobal(cb4:GetName() .. "Text"):SetText("Enable/disable debugging traces in the General chat window");
	if (UserKeyDebug == 1) then
		cb4:SetChecked(true);
	else
		cb4:SetChecked(false);
	end
	cb4:SetScript("OnClick",
		function()
			if (cb4:GetChecked() ) then
				UserKeyDebug = 1;
			else
				UserKeyDebug = 0;
			end
		end);

	local b1 = CreateFrame("Button","UserKey_OptionsResetButton",panel,"UIPanelButtonTemplate2")
	b1:SetPoint("TOPLEFT",cb4,"BOTTOMLEFT",0,-4);
	b1:SetText("Reset all data");
	b1:SetWidth(100);
	b1:SetHeight(20);
	b1:SetScript("OnClick",UserKey_ResetAllData);
end

-- ***************************************************************************
-- Opens the UserKey dialog window
function UserKey_ShowData()
	UKDebug("ShowData","ShowData() entered.");
	UserKey_ScanData();
	UserKeyFrame:Show();
	UserKeyGrabber:EnableKeyboard(0);
	UserKeyGrabber:Hide();
end

-- ****************************************************************************
-- Scans abilities and key bindings, builds internal UserKeyBindingsTable
function UserKey_ScanData()
		UKDebug("ScanData","ScanData() entered.");
		UserKey_OnScanSpells();
		UserKey_OnScanPets();
		UserKey_OnScanItems();
		UserKey_OnScanMacros();
		UserKey_AssembleBindingTable();
		UK_DATA_VALID = 0;	-- reset the data valid flag, everything is OK.
end

-- ****************************************************************************
-- This function populates the initial buttons/slots with the items from the UserKeyBindings table

function UserKey_PopulateData()
	UKDebug("PopulateData","PopulateData() entered.");
	local i,j, index, text, action, slot, button;
	
	i=1;
	for j, text, action,k,k2  in next,UserKeyBindings 	do
			if (i <= UK_MAX_SLOT) then
				slot = getglobal("UserKeySlot" .. i);
				button = getglobal("UserKeyButton" .. i);
				buttonb = getglobal("UserKeyButton" .. i .. "b");

				-- color codes are |c .. rr bb gg I have no idea what the .. represents at the start.
				if (UserKeyBindings[j]["action"] == "none") then
					-- This is a group heading, color it white and hide the clickable button
					slot:SetText("|c00ffffff "..UserKeyBindings[j].text);
					button:Hide();
					buttonb:Hide();
				else
					-- this is an action button label, color it yellow and show the clickable button also
					slot:SetText("|cffffff00 "..UserKeyBindings[j].text);
					button:SetText(UserKeyBindings[j].k);
					button:SetNormalFontObject("GameTooltipTextSmall");
					button:Show();

					buttonb:SetText(UserKeyBindings[j].k2);
					buttonb:SetNormalFontObject("GameTooltipTextSmall");
					buttonb:Show();

					-- safety check. Since we know we have been given a key binding, go ahead and
					-- confirm it's been made. This should be unnecessary and I may remove it later.

					if (UserKeyBindings[j].k ~= "Not Bound") then
						SetBindingSpell(UserKeyBindings[j].k, UserKeyBindings[j].action);
					end
				end
				
				i = i +1;
			else
				-- no point in continuing past the number of visible slots.
				break;
			end
	end
	UserKeyStatusBarText:SetText("");
end

-- ***************************************************************************
-- This function triggers when they click one of the binding buttons. When UserKeyGrabber is shown, we
-- wait for keyboard input, which is parsed by UserKey_OnKeyDown(), below

function UserKey_ButtonClick(self, button)
	-- if we're already in key capture mode, then we need to pass the mouse click to OnKeyDown().
	-- Otherwise, we process the button to figure out what they want to bind.

	local combat = UnitAffectingCombat("player");
	if (combat) then
		UserKeyStatusBarText:SetText("|c00ffff00 You are in combat, unable to change key bindings!");
		UserKey_CancelInput();
		return;
	end

	if (UserKeyUnBind:IsEnabled() == 1) then
		UserKey_OnKeyDown(self, button);
		return;
	end

	-- this is the only place where we know which button the user clicked, so we have to hold on to
	-- that information. First, find the number of the button that was pressed.

	UserKeyPressedButton = self:GetName();
	UserKeyPressedButtonNum = strsub(UserKeyPressedButton, 14); 
	UserKeyPressedButtonNumSuffix="";
	UserKeyPressedColumn=1;

	-- determine if the button pressed was in the first column or the second column of buttons
	if (string.find(UserKeyPressedButtonNum,"b") ~= nil) then
		UserKeyPressedButtonNum=strsub(UserKeyPressedButtonNum,1,(strlen(UserKeyPressedButtonNum) -1 ));
		UserKeyPressedButtonNumSuffix="b";
		UserKeyPressedColumn=2;
	end

	-- next, find the text in the associated FontString
	UserKeyPressedText = getglobal("UserKeySlot"..UserKeyPressedButtonNum):GetText();

	-- strip off the leading codes that set the FontString text color.
	UserKeyPressedText = strsub(UserKeyPressedText, 12 );

	-- Because the buttons scroll, UserKeyButtonNum does not correlate directly with the entry
	-- in UserKeyBindings table. We have to find which index in the table this button slot correlates to.
	UserKeyBindingIndex = -1;
	for index in next,UserKeyBindings do
		if (UserKeyBindings[index].text == UserKeyPressedText) then
			UserKeyBindingIndex = index;
			break;
		end
	end

	-- This shouldn't happen. There's no way we can get text from a button that doesn't match
	-- text in the table, since we use the table to populate the buttons. Still, just in case...

	if (UserKeyBindingIndex == -1) then
		message(UK_STRING_STRINGS_DONT_MATCH .. " " .. UserKeyPressedText .. "," .. UserKeyBindings[index].text);
		return;
	end

	UserKeyStatusBarText:SetText("Press a key to bind to this function -->" ..  
		UserKeyBindings[UserKeyBindingIndex].action);

	-- Now wait for the user to push a key, which will be processed by UserKey_OnKeyDown
	UserKeyGrabber:EnableKeyboard(1);
	UserKeyGrabber:Show();
	UserKeyUnBind:Enable();
	UserKeyCancelBind:Enable();

end

-- ***************************************************************************
-- Processes the incoming key. A substantial amount of this function was inspired by Blizzard_BindingUI.lua, but
-- I did some cleanup and condensation of some of the code.
function UserKey_OnKeyDown(self, button)
--	UKDebug("OnKeyDown","OnKeyDown() Entered with button = " .. button);
	local keypressed;
	local screenkey;
	local oldaction, newaction;
	local rc;
	local prefix;

	-- arg1 is passed in through the OnEvent processing and contains the UI's name for the Key/mouse 
	-- button that was pressed.

	-- if the user is in combat, they cannot modify keys.
	local combat = UnitAffectingCombat("player");
	if (combat) then
		UserKeyStatusBarText:SetText("|c00ffff00 You are in combat, unable to change key bindings!");
		UserKey_CancelInput();
		return;
	end

	-- escape aborts the keybind
	if (button == "ESCAPE") then
		UserKey_CancelInput();
		return;
	end

	-- The user may be trying to take a screenshot of this interface
	local screenkey = GetBindingKey("SCREENSHOT");
	if (screenkey and button == screenkey) then
		UserKey_CancelInput();
		Screenshot();
		return;
	end

	-- The UI returns different names for the mouse buttons than the UI expects when you 
	-- bind to a mouse button, so we have to translate the difference. 

	-- If they send us CTRL, SHIFT, or ALT then keep returning until they click a "final" button. 
	-- Then we check the IsxxxKeyDown() functions to capture the modifiers.
	if ( button == "LeftButton" ) then
		keypressed = "BUTTON1";
		return;	-- too much potential for user to dick themselves. Dont allow this key to be bound;

	elseif ( button == "RightButton" ) then
		keypressed = "BUTTON2";
		return;	-- too much potential for user to dick themselves. Dont allow this key to be bound;

	elseif ( button == "MiddleButton" ) then
		keypressed = "BUTTON3";

	elseif ( button == "Button4" ) then
		keypressed = "BUTTON4";

	elseif ( button == "Button5" ) then
		keypressed = "BUTTON5";

-- not needed, but left here as a reminder to myself that mouse up and down are not needed :)
--[[	elseif (button == "MOUSEWHEELUP") then
		keypressed = "MOUSEWHEELUP";

	elseif (button == "MOUSEWHEELDOWN") then
		keypressed = "MOUSEWHEELDOWN";
--]]
	elseif ( button == "UNKNOWN" or 
		button == "LSHIFT" or button == "RSHFT" or
		button == "LCTRL" or button == "RCTRL" or 
		button == "LALT" or button == "RALT" ) then
		-- if we get an unknown key or an incomplete sequence (ctrl+alt+x), return and let them retry
		return;
	else
		-- This wasn't a mouse button or modifier, so accept the key name they sent us without
		-- any additional processing.
		keypressed = button;
	end

	-- get themodifiers, if any. They must be processed in this order to match WoW's expected naming
	-- scheme. That is, SHFT-CTRL != CTRL-SHFT... only one is valid.

	if ( IsShiftKeyDown() ) then
		keypressed = "SHIFT-"..keypressed;
	end

	if ( IsControlKeyDown() ) then
		keypressed = "CTRL-"..keypressed;
	end

	if ( IsAltKeyDown() ) then
		keypressed = "ALT-"..keypressed;
	end

	UKDebug("OnKeyDown","keypressed = " .. keypressed);

	if (keypressed) then
		oldaction=GetBindingAction(keypressed);
		newaction = string.upper(UserKeyBindings[UserKeyBindingIndex].bindtype) .. " " ..
						UserKeyBindings[UserKeyBindingIndex].action;

		-- what key was already bound to this action? Clear it out. We rebind the oldkey values again later.
		local oldkey1, oldkey2;
		oldkey1, oldkey2 = GetBindingKey(newaction);

		if (oldkey1) then
			SetBinding(oldkey1);
		end
		if (oldkey2) then
			SetBinding(oldkey2);
		end

		-- For binding to spells, macros or items, we use teh new SetBindingXXX() functions in 2.0. For
		-- binding to pre-existing commands, like BONUSACTIONBUTTON1, we use the original SetBinding() command.

		prefix = "SetBinding";
		local BindFunction = getglobal(prefix .. UserKeyBindings[UserKeyBindingIndex].bindtype);
		UKDebug("OnKeyDown","OnKeyDown() BindFunction is " ..  prefix .. UserKeyBindings[UserKeyBindingIndex].bindtype);

		if (BindFunction == nil) then
			message("Bind Function: SetBinding" .. UserKeyBindings[UserKeyBindingIndex].bindtype .."() does not exist.");
			UserKey_CancelInput();
			return;
		else
			-- Did the user press a button in column1 or column2?
			if (UserKeyPressedColumn == 1) then
				UKDebug("OnkeyDown","OnKeyDown() Column1 button being processed");
				-- update column 1 with the newkey, restore column2 to any previously existing bind
				getglobal("UserKeyButton"..UserKeyPressedButtonNum):SetNormalFontObject("GameTooltipTextSmall");
	 			UserKeyBindings[UserKeyBindingIndex].k = keypressed;

				rc = BindFunction(keypressed, UserKeyBindings[UserKeyBindingIndex].action);

				if (oldkey2) then
					rc = BindFunction(oldkey2, UserKeyBindings[UserKeyBindingIndex].action);
				end
			else -- UserKeyPressedColumn == 2
				-- update column 2 with the newkey, restore column1 to any previously existing bind
				UKDebug("OnkeyDown","OnKeyDown() Column2 button being processed");
				getglobal("UserKeyButton"..UserKeyPressedButtonNum.."b"):SetNormalFontObject("GameTooltipTextSmall");
				UserKeyBindings[UserKeyBindingIndex].k2 = keypressed;

				if (oldkey1) then
					rc = BindFunction(oldkey1, UserKeyBindings[UserKeyBindingIndex].action);
				end	
				rc = BindFunction(keypressed, UserKeyBindings[UserKeyBindingIndex].action);
			end

			-- Once the bind function executes, the UPDATE_BINDINGS event fires and execute OnEvent(). 
			-- OnEvent() calls ScrollBarUpdate() which updates the text in the buttons.
		end

		-- find out if the key was assigned to anything before hand
		if (oldaction ~= "" and oldaction ~= newaction) then
			UserKeyStatusBarText:SetText("|c00ff0000 "..oldaction.." function is Now Unbound!");
		else
			UserKeyStatusBarText:SetText("|c00ffff00 Key Bound Successfully!");
		end

		UserKey_SaveBindings(2);

	end
	UserKey_CancelInput();
end

-- ************************************************************************
-- This function manages the scrolling window, show the appropriate subset of data in UserKeyBindings
-- table based on the position of the scrollbar.

function UserKeyScrollBar_Update()
	UKDebug("ScrollBar_Update","ScrollBar_Update Entered.");
	local line; -- line of the window
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	local button, button2, slot;
	local k, k2;

	-- Find out what keys are already bound to which buttons.
	for i=1,UK_MAX_BINDS do
		bindtype = string.upper(UserKeyBindings[i].bindtype);
		if (bindtype ~= "na" and strlen(bindtype) > 2 ) then
			-- shouldn't be possible for action to be nil here, but just in case...
			if (UserKeyBindings[i].action ~= nil) then
				k, k2 = GetBindingKey(bindtype .. " " .. UserKeyBindings[i].action);
			end
		else
			-- shouldn't be possible for action to be nil here, but just in case...
			if (UserKeyBindings[i].action ~= nil) then
				k, k2 = GetBindingKey(UserKeyBindings[i].action);
			end
		end
		
		if (k) then
			UserKeyBindings[i].k = k;
		else
			UserKeyBindings[i].k = "Not Bound";
		end

		if (k2) then
			UserKeyBindings[i].k2 = k2;
		else
			UserKeyBindings[i].k2 = "Not Bound";
		end

	end

	-- Check how much data we have to show. The fauxscrollframe seems to get confused and die
	-- if we give it less data than the window can fit. In that case, construct the display ourselves.

	if (UK_MAX_BINDS <= UK_MAX_SLOT) then
		-- no need for a scrolling window 
		for line=1,UK_MAX_BINDS do
			slot=getglobal("UserKeySlot"..line);
			button=getglobal("UserKeyButton"..line);
			button2=getglobal("UserKeyButton"..line.."b");

			if (UserKeyBindings[line].action == "none") then
				slot:SetText("|c00ffffff " .. UserKeyBindings[line].text);
				slot:Show();
				button:Hide();
				button2:Hide();
			else
				slot:SetText("|cffffff00 " .. UserKeyBindings[line].text);
				button:SetText(UserKeyBindings[line].k);
				button:SetNormalFontObject("GameTooltipTextSmall");
				button2:SetText(UserKeyBindings[line].k2);
				button2:SetNormalFontObject("GameTooltipTextSmall");

				slot:Show();
				button:Show();
				button2:Show();
			end
		end
		for line=UK_MAX_BINDS+1,UK_MAX_SLOT do
			getglobal("UserKeySlot"..line):Hide();
			getglobal("UserKeyButton"..line):Hide();
			getglobal("UserKeyButton"..line.."b"):Hide();
		end
		return;
	end

	-- if we get here, then we know we have more data to show than will fit in the window and
	-- a scroll bar is required.

	FauxScrollFrame_Update(UserKeyScrollFrame,UK_MAX_BINDS,UK_MAX_SLOT,16); -- last num is pixel height

	for line=1,UK_MAX_SLOT do
		lineplusoffset = line + FauxScrollFrame_GetOffset(UserKeyScrollFrame);
		slot=getglobal("UserKeySlot"..line);
		button=getglobal("UserKeyButton"..line);
		button2=getglobal("UserKeyButton"..line.."b");

		if lineplusoffset <= UK_MAX_BINDS then
--			slot=getglobal("UserKeySlot"..line);
--			button=getglobal("UserKeyButton"..line);

			if (UserKeyBindings[lineplusoffset].action == "none") then
				slot:SetText("|c00ffffff " .. UserKeyBindings[lineplusoffset].text);
				slot:Show();
				button:Hide();
				button2:Hide();
			else
-- got a nil error here once, complaining that "text" was nil
				slot:SetText("|cffffff00 " .. UserKeyBindings[lineplusoffset].text);
				button:SetText(UserKeyBindings[lineplusoffset].k);
				button:SetNormalFontObject("GameTooltipTextSmall");
				button2:SetText(UserKeyBindings[lineplusoffset].k2);
				button2:SetNormalFontObject("GameTooltipTextSmall");

				slot:Show();
				button:Show();
				button2:Show();
			end
		else
			slot:Hide();
			button:Hide();
			button2:Hide();
		end
	end

end

-- **********************************************************************
-- Temp code to reset all bindings to original defaults, used only during debugging/
--	UserKeyBindings = UserKeyBindingsDefaults;
function UserKey_ResetAllData()
	UKDebug("ResetAllData","ResetAllData Entered.");

	UserKeyBindings_spells ={};
	UserKeyBindings_pet = {};
	UserKeyBindings_petcommon = {};
	UserKeyBindings_macros = {};
	UserKeyBindings_items = {};
	UserKeyBindings_user = {};

	UserKeyBindings = UserKeyBindingsRecovery;
	UK_MAX_BINDS = 2;

	UK_MAX_SPELL_BINDS = 0;
	UK_MAX_PET_BINDS = 0;
	UK_MAX_MACRO_BINDS = 0;
	UK_MAX_ITEM_BINDS = 0;
	UK_MAX_PETCOMMON_BINDS = 0;
	UK_MAX_PETCOMMONINACTIVE_BINDS = 0;
	UK_MAX_USER_BINDS = 0;

	UK_DATA_VALID=0;

	UserKeyScrollBar_Update();
	UserKey_CancelInput();
end

-- **********************************************************************
-- unbinds all key from the specified action button (column 1 or column 2)
function UserKey_ButtonUnBind()
	UKDebug("ButtonUnBind","ButtonUnBind() Entered.");
	local k, k2, rc;

	local text = getglobal("UserKeySlot"..UserKeyPressedButtonNum):GetText();
	text = strsub(text,12,strlen(text) );

	local i;
	for i=1,UK_MAX_BINDS do
		UKDebug("ButtonUnBind","Comparing -"..text.."--"..UserKeyBindings[i].text.."-");
		if (text == UserKeyBindings[i].text) then

			bindtype = string.upper(UserKeyBindings[i].bindtype);
-- 1/22/11 seems you can't call GetBindingKey with a bindtype anymore. This leads to problems if a user named a macro
-- the same as a spell.

--			if (bindtype ~= "na" and strlen(bindtype) > 2) then
--				k, k2 = GetBindingKey(bindtype .. " " .. UserKeyBindings[i].action);
--			else
				k, k2 = GetBindingKey(UserKeyBindings[i].action);
--			end

			if (UserKeyPressedColumn == 1) then
				-- K might be nil if a user has named a macro the same as a spell
				if (k == nil) then
					UserKey_CancelInput();
					message("WoW reports no keys bound to " .. UserKeyBindings[i].action .. ". This usually happens when a macro is named the same as a spell");
					return
				end

				rc = SetBinding(k);	
				if (rc == 1) then
					-- unbind was successful
					UserKeyBindings[i].k = "Not Bound";
					getglobal("UserKeyButton"..UserKeyPressedButtonNum):SetText(UserKeyBindings[i].k);

					-- if there was a binding on k2, move it to k1.
					if (k2) then
						UserKeyBindings[i].k = UserKeyBindings[i].k2
						UserKeyBindings[i].k2 = "Not Bound";
						getglobal("UserKeyButton"..UserKeyPressedButtonNum):SetText(UserKeyBindings[i].k);
					end
				end
			else
				-- K2 might be nil if a user has named a macro the same as a spell
				if (k2 == nil) then
					UserKey_CancelInput();
					message("WoW reports no keys bound to " .. UserKeyBindings[i].action .. ". This usually happens when a macro is named the same as a spell");
					return
				end

				rc = SetBinding(k2);	
				if (rc == 1) then
					-- unbind was successful
					SetBindingSpell(UserKeyBindings[i].k2, "");
					UserKeyBindings[i].k2 = "Not Bound";
					getglobal("UserKeyButton"..UserKeyPressedButtonNum.."b"):SetText(UserKeyBindings[i].k2);
				end
			end
			
			if (rc == 1) then
				UserKey_SaveBindings(2); -- char-specific save
				UserKeyStatusBarText:SetText("|c00ff0000 " .. text  .. " is now unbound.");
			else
				UserKeyStatusBarText:SetText("|c00ff0000 " .. text  .. " failed to unbind. Are you in combat?");
			end

			UserKey_CancelInput();
			return;
		end
		i = i + 1;
	end

end

-- **********************************************************************
function UserKey_ButtonOK()
	UKDebug("ButtonOK","ButtonOK() Entered.");
	-- choose whether account or char specific
--[[
	if (UserKeyFrameCheckButton:GetChecked() == 1) then
		-- Character-specific bindings
		UserKey_SaveBindings(2);
	else
		-- account-wide bindings
		UserKey_SaveBindings(1);
	end
--]]
	-- force all saves to be per-character
	UserKey_SaveBindings(2);

	UserKey_CancelInput();
	UserKeyFrame:Hide();
end


-- **********************************************************************
-- simple wrapper to make sure we avoid an infinite loop of savebind -> event -> rescan -> resavebind
function UserKey_SaveBindings(mode)
	UserKeyFrame:UnregisterEvent("UPDATE_BINDINGS");
	SaveBindings(mode);
	UserKeyFrame:RegisterEvent("UPDATE_BINDINGS");
end

-- **********************************************************************
-- scan functions are initiated by the user clicking the scan button. The xml <SCRIPT> for teh scan button
-- then calls OnScanSpells, OnScanPets, OnScanMacros, and OnScanItems then AssembeBindingTable().
function UserKey_OnScanSpells()
	UKDebug("OnScanSpells","OnScanSpells() entered.");
	local loopindex, tabindex;
	local booktype;
	local spelltext, spellName, spellRank;
	local creatureID, creatureName, spellID, icon, active, creatureType;
	local name, texture, offset, numspells, numtabs;

	booktype = BOOKTYPE_SPELL;
	bindtype = "Spell";
	UserKeyBindings_spells = {};
	UK_MAX_SPELL_BINDS=0;

	table.insert(UserKeyBindings_spells,1,{text="************************ Abilities and Spells ****************************************",bindtype="na",action="none", k="Not Bound"});
	
	-- You can't directly tell which spell belongs in which tab (destruction, affliction, etc). You can only find out 
	-- how many spells each tab contains. So, we have to count the iterations through the loop and display a 
	-- new tab label at the appropriate times.

	numtabs = GetNumSpellTabs();
	name, texture, offset, numspells = GetSpellTabInfo(1);
	loopindex = 1; tabindex=1;

	while true do
		spellName, spellSubName = GetSpellBookItemName(loopindex, booktype);
		if (not spellName) then
			-- no more spells, exit the loop (or no pet active)
			break;
		end

		-- If the loopindex (number of spell that we're reading) is greater than the offset (num of spells) where 
		-- the new spell tab starts, then we add the next spell tab into the list as a section heading. 

		-- new for wow4.0: the 2 professions and 3 secondary professions are treated as tabs, and names are reported by GetSpellTabInfo().
		-- however, they're not counted by GetNumSpellTabs(), so we manually have to account for 5 extra tabs. I'm sure Blizzard will
		-- someday, without warning, fix GetNumSpellTabs(), thus breaking this code.

		if (loopindex > offset and tabindex <= numtabs + 5) then
			if (name ~= nil) then
				table.insert(UserKeyBindings_spells, {text = "     -----" .. name .. "-----", bindtype="na", action="none", k="Not Bound"});
				UKDebug("OnScanSpells",
					"numtabs = " .. numtabs .. ", tabindex = " .. tabindex .. ", loopindex = " .. loopindex .. ", offset= " .. offset .. ", numspells = " .. numspells .. ", " .. name);
	
				tabindex = tabindex +1;
				name, texture, offset, numspells = GetSpellTabInfo(tabindex);
			end
		end

		if (IsPassiveSpell(loopindex, booktype) == nil) then
			-- Not a passive ability, we can bind a key to this item
			table.insert(UserKeyBindings_spells, {text=spellName, bindtype=bindtype, action=spellName, k="" });
		end 
		
		loopindex = loopindex +1;
	end -- while read spell
	
	--new for WoW 3.0 8/23/08: Mounts and Companion pets are now spells instead of inventory items
	-- OK, so they haven't given us a SetBindingCompanion function yet, forcing a call to CallCompanion().
	-- With no way to bind a key directly to CallCompanion. So, for the near term I'm moving this functionality
	-- to the Macro scan. I'll scan for non-combat pets and add macros for CallCompanion(). If they ever give us
	-- SetBindingCompanion(), then this code should work (may have to modify the action field)

--[[
	bindtype = "Companion";
	for loopindex = 1, table.getn(UserKey_CompanionTypes) do
		-- get a creature type
		creatureType =UserKey_CompanionTypes[loopindex];
	
		if (creatureType ~= nil) then
				-- determine how many companions exist for this creature type
			table.insert(UserKeyBindings_spells, {text = creatureType, bindtype="na", action="none", k="Not Bound"});
			numspells = GetNumCompanions(creatureType);

			for tabindex = 1, numspells do
				-- loop through all the companions in this type
				creatureID, creatureName, spellID, icon, active = GetCompanionInfo(creatureType, tabindex);
		
				if (creatureID ~= nil) then
					table.insert(UserKeyBindings_spells, {text=creatureName, bindtype=bindtype, action=creatureName, k="" });
				end
			end
		end
	end
--]]

	UK_MAX_SPELL_BINDS = table.getn(UserKeyBindings_spells);
end

-- **********************************************************************
-- scan functions are initiated by the user clicking the scan button. The xml <SCRIPT> for the scan button
-- then calls OnScanSpells, OnScanPets, OnScanMacros, and OnScanItems then AssembeBindingTable().
function UserKey_OnScanPets()
	UKDebug("OnScanPets","OnScanPets() Entered.");
	local loopindex, insindex;
	local booktype;
	local spelltext, spellaction;
	local loopname;
	local pettexture, pettype, petfamily;
	local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled

	UserKeyBindings_pet = {};
	UserKeyBindings_petcommon ={};
	UK_MAX_PET_BINDS = 0;
	UK_MAX_PETCOMMON_BINDS=0;

	-- Does this player have any pet active?
	petfamily = UnitCreatureFamily("pet");
	if (petfamily == nil) then
		-- we don't seem to have a pet
		return;
	end

	-- Does this pet have any spells?
	num, pettype = HasPetSpells();	-- nil = no pet out, zero = no pet abilities
	if (num == nil or num == 0 ) then
		-- no pet to scan, bail out now
		return;
	end

	booktype = BOOKTYPE_PET;
	bindtype = "";

	-- have we already set up the pet header before? Once set up, petcommon is saved in WTF until the user clicks "reset"
	-- First, build a header of functions common to all pets

	table.insert(UserKeyBindings_petcommon,{text="********************* Pets ***************************************************",
		bindtype="na",action="none",k=""});
	table.insert(UserKeyBindings_petcommon,{text="Pet Abilities and Spells (Common)",bindtype="na",action="none",k=""});

	UK_MAX_PETCOMMON_BINDS = 1;
	
	-- scan the 10 pet ability slots
	for index = 1, 10, 1 do
		name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(index);
		if (name ~= nil) then
			-- look for abilities that are common to all pets. The names always follow the format of PET_MODE_xxx
			-- or PET_ACTION_xxx for the common abilities (attack, follow, etc).
			if (string.find(name,"PET_") ) then
				-- this is an ability common to all pets. Need to parse the name for better display.
				spelltext = "Pet " .. strsub(name, (string.find(name, "_", -1* strlen(name) + 5 ) +1 ) );

				-- The pet buttons are actually mapped the "Secondary Action Button(s)" which are aliased as the
				-- BONUSACTIONBUTTONs
				spellaction = "BONUSACTIONBUTTON"..index;
				table.insert(UserKeyBindings_petcommon,{text=spelltext, bindtype=bindtype, action=spellaction, k=""});
			end
		end
--		index =index + 1;
--		name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(index);
	end

	UK_MAX_PETCOMMON_BINDS = table.getn(UserKeyBindings_petcommon);

	-- now we start building a table just for this pet.
	table.insert(UserKeyBindings_pet,1,{text=petfamily .. ":: Abilities and Spells", bindtype="na", action="none", k=""});

	bindtype="Spell";
	insindex = 2;
	loopindex = 1;
	while true do
		local spellName, spellRank = GetSpellInfo(loopindex, booktype)
		if (not spellName) then
			-- no more spells, exit the loop (or no pet active)
			break;
		end -- if no more spells

		if (IsPassiveSpell(loopindex, booktype) == nil) then
			-- Not a passive ability, we can bind a key to this item
			spelltext = petfamily .. ":: " .. spellName .. " " .. spellRank;
			table.insert(UserKeyBindings_pet, insindex, {text=spelltext, bindtype=bindtype, action=spellName, k="" });
			
			insindex = insindex + 1;
		end 
		loopindex = loopindex +1;
	end -- while read spell

	UK_MAX_PET_BINDS = table.getn(UserKeyBindings_pet);
end

-- **********************************************************************
-- scan functions are initiated by the user clicking the scan button. The xml <SCRIPT> for teh scan button
-- then calls OnScanSpells, OnScanPets, OnScanMacros, and OnScanItems then AssembeBindingTable().
function UserKey_OnScanItems()
	UKDebug("OnScanItems","OnScanItems() Entered.");

	UK_MAX_ITEM_BINDS = 0;
	UK_MAX_ITEM_INACTIVE_BINDS = 0;
	UserKeyBindings_items = {};
	UserKeyBindings_itemsinactive = {};
	bindtype = "Item";

	table.insert(UserKeyBindings_items,1,{text="************************ Usable Equipment******************************************",
		bindtype="na", action="none", k=""});

	local i, j,bag, slot, slotname, olditemlink, itemlink, itemname, bagstring;
	UserKeyTooltip:SetOwner(UIParent, "ANCHOR_NONE");

	-- since the bank isn't always visible, we have to preseve buttons for items that are banked but
	-- not accessible right now. If the bank is visible, then we have access to the character's entire
	-- inventory and don't have to worry about preserving anything. When the bank is not visible, we
	-- will keep a copy of bindtype=Items from the previous scan. After collecting the new active inventory
	-- (carried/worn items) then we will examine the kept list. Duplicates will be deleted, unique entries
	-- will be added into the overall list as "bank(?)" items. These may be banked or they may be deleted.
	-- They will remain in the overall list until the user opens the bank view and we rebuild the entire list.

	if (BankFrame:IsVisible() ) then
		-- we have the bank open. we have full access to the character's inventory. We'll rebuild all
		-- buttons based on what we can see they are wearing, carrying and storing.
		UserKeyBindings_itemsinactive ={};
		UK_MAX_ITEM_INACTIVE_BINDS = 0;

		-- the main bank slots are bag "-1"
		olditemlink = " ";
		for slot=1,GetContainerNumSlots(-1) do
			itemlink = GetContainerItemLink(-1,slot);
			if (itemlink) then
				-- for any item, populate it's tooltip text in our private tooltip, then scan our tooltip
				-- for the "Use:" flag to see if this is a usable item we can bind a key to.

				-- don't call SetHyperLink() twice in a row with the same link, it kills the tooltip. So,
				-- check for duplicate items next to each other in the bank and don't update the tip
				-- unless really necessary.
				if (itemlink ~= olditemlink) then
					UserKeyTooltip:SetHyperlink(itemlink); 
					olditemlink = itemlink;

					itemname = UserKey_ReadTooltip() 
					if (itemname ~= 0) then
						-- we know this a bind-able item with a "Use:" tag in the tooltip. 
						table.insert(UserKeyBindings_items,{text=itemname .. "|c00404040 Bank(-1,"..slot ..")",
									bindtype=bindtype, action=itemname, k=""});
					end 
				end -- if (itemlink ~= olditemlink)
			end -- if(itemlink)
		end -- for(slot)

		-- The rest of the bank bag slots are 5 through 12.
		olditemlink = " ";
		for bag=5,12,1 do
			for slot=1,GetContainerNumSlots(bag) do
				itemlink = GetContainerItemLink(bag,slot);
				if (itemlink) then
					-- for any item, populate it's tooltip text in our private tooltip, then scan our tooltip
					-- for the "Use:" flag to see if this is a usable item we can bind a key to.

					-- don't create duplicate entries when the user has multiple copies of the same item.
					if (itemlink ~= olditemlink) then
						olditemlink = itemlink;
						UserKeyTooltip:SetBagItem(bag,slot); 
						itemname = UserKey_ReadTooltip() ;
						if (itemname ~= 0) then
							-- we know this a bind-able item with a "Use:" tag in the tooltip. 
							table.insert(UserKeyBindings_items,{text=itemname .."|c00404040 Bank(" ..bag..","..slot..")",
										bindtype=bindtype, action=itemname, k=""});
						end
					end -- if (itemlink ~= olditemlink)
				end -- if (itemlink)
			end -- for slot
		end -- for bag
	else
		-- we can't see what's in the bank. So, we rebuild with what we can see they are wearing and
		-- carrying. We'll have to preserve items that we can't see. Start with a copy of Items in the 
		-- previous UserKeyBindings data.

		for slot=1,UK_MAX_BINDS,1 do
			if (UserKeyBindings[slot].bindtype == "Item" ) then

			-- this is an item we have to hold on to.
				table.insert(UserKeyBindings_itemsinactive, {text=UserKeyBindings[slot].text,
																	bindtype=UserKeyBindings[slot].bindtype,
																	action=UserKeyBindings[slot].action,
																	k=UserKeyBindings[slot].k});
				UK_MAX_ITEM_INACTIVE_BINDS = table.getn(UserKeyBindings_itemsinactive);
				-- it's possible there were no items found. In that case, table.getn "wisely" returns
				-- nil instead of zero.
				if (UK_MAX_ITEM_INACTIVE_BINDS == nil) then
					UK_MAX_ITEM_INACTIVE_BINDS = 0;
				end
			end
		end
	end

	-- search all character bag slots for items. Countdown backwards in the inventory so we can always insert items at
	-- slot 2, ensuring Equipped items show before the banked items, even though we have to scan the bank first.

	for bag=4,0,-1 do
		for slot=GetContainerNumSlots(bag),1,-1 do
			itemlink = GetContainerItemLink(bag,slot);
			if (itemlink) then
				-- for any item, populate it's tooltip text in our private tooltip, then scan our tooltip
				-- for the "Use:" flag to see if this is a usable item we can bind a key to.
				UserKeyTooltip:SetBagItem(bag,slot); 
				itemname = UserKey_ReadTooltip() 
				if (itemname ~= 0) then
					-- we know this a bind-able item with a "Use:" tag in the tooltip. 
					table.insert(UserKeyBindings_items,2,{text=itemname .. "|c00a0a0a0 Bag(" .. bag .."," ..slot .. ")",
								bindtype=bindtype, action=itemname, k=""});			
				end
			end
		end
	end

	-- what are you wearing? Huh huh hu hu huh
	-- loop through the 19 wearable slots for bindable items. Loop backwards so we can insert them at the start of 
	-- of the table and make them appear before the bank items, even though the bank items have to be scanned
	-- first.
	olditemlink = " ";
	for slot=19,1,-1 do
		itemlink = GetInventoryItemLink("player", slot );
		if (itemlink) then
			if (itemlink ~= olditemlink ) then
				UserKeyTooltip:SetHyperlink(itemlink); 
				olditemlink = itemlink;
			end
			itemname = UserKey_ReadTooltip() ;
			if (itemname ~= 0) then
				-- we know this a bind-able item with a "Use:" tag in the tooltip. 
				table.insert(UserKeyBindings_items,2,{text=itemname .. "|c00ffffff ("..UserKey_InventorySlots[slot] ..")",
							bindtype=bindtype, action=itemname, k=""});
			end
		end
	end

	UK_MAX_ITEM_BINDS = table.getn(UserKeyBindings_items);

	-- Now the annoying part. If the bank wasn't visible, then we search for items in the carry/worn 
	-- inventory and delete them from the inactive inventory so they don't show up twice.
	for i=1,UK_MAX_ITEM_INACTIVE_BINDS,1 do
		for j=1,UK_MAX_ITEM_BINDS,1 do
			sub = 0;
			if (UserKeyBindings_itemsinactive[i].action == UserKeyBindings_items[j].action) then
				-- this item is in the current inventory, so we can stop searching and ignore it.
				sub = 1;
				break;	
			end -- if (UserKey)
		end -- for j
		
		if ( sub == 0) then
		-- if we got here  then this item is not in the active inventory
		-- and we have to assume it's still in the bank. Therefore, add it back into the current list.

			if (string.find(UserKeyBindings_itemsinactive[i].text, "Bank" ) ) then
				-- item was previously in the bank. Retain that slot information
				bagstring = UserKeyBindings_itemsinactive[i].text;
			else
				-- item was previously in the active inventory. Assume it's in the bank now.
				bagstring = UserKeyBindings_itemsinactive[i].text .. "|c00ff4040 Bank?"
			end

			table.insert(UserKeyBindings_items, {text=bagstring,
													bindtype=UserKeyBindings_itemsinactive[i].bindtype,
													action=UserKeyBindings_itemsinactive[i].action,
													k=UserKeyBindings_itemsinactive[i].k});
		end -- if (sub)
	end -- for i


	UK_MAX_ITEM_BINDS = table.getn(UserKeyBindings_items);
	if (UK_MAX_ITEM_BINDS == nil ) then
		UK_MAX_ITEM_BINDS = 0;
	end

	-- make sure we don't have duplicate items in the bindings table.
	-- step through each item, compare to all items that were before it. Delete the last dup found
	i = 1;
	while (i <= UK_MAX_ITEM_BINDS) do
		j = i -1;
		while (j > 0) do
			if (UserKeyBindings_items[i].action == UserKeyBindings_items[j].action) then
				table.remove(UserKeyBindings_items, i);
				UK_MAX_ITEM_BINDS = UK_MAX_ITEM_BINDS -1;
				j = -1;	-- terminate the inside loop and move on to the next item
			else
				j = j -1;
			end
		end -- while (j)

		-- if we deleted an item, then the next item in the list has moved forward to position "i".
		-- if we didn't delete an item, then increment i to point to the next item in the list.
		if (j == 0) then	 
			i = i+1;
		end
	end -- while (i)

	UK_MAX_ITEM_BINDS = table.getn(UserKeyBindings_items);
	if (UK_MAX_ITEM_BINDS > UK_MAX_INVENTORY) then
		--something has gone horribly wrong. UserKey thinks we have more inventory items than the
		-- game possibly allows.
		message(UK_STRINGS_MAXITEMS);
		UserKeyBindings_items = {};
		UK_MAX_ITEM_BINDS = 0;
	end
end

-- **********************************************************************
-- Wow 3.0 workaround: generate macros for non-bindable pets/mounts
function UserKey_GenerateMacro()
	UKDebug("GenerateMacro","GenerateMacro() Entered.")

	-- 8/23/08 For WoW3.0, pets and mounts have become spells and should be covered in the Spell scan function.
	-- Unfotunately, blizzard didn't give us a SetBindingCompanion function, so the only alternative is to create
	-- macros that call CallCompanion, then bind keys to those macros. Hopefully, this is a temporary situation.

	local creatureType, numspells, tabindex, loopindex, creatureID, creatureName, spellID, icon, active;

	for loopindex = 1, table.getn(UserKey_CompanionTypes) do
		-- get a companion type
		creatureType =UserKey_CompanionTypes[loopindex];
		if (creatureType ~= nil) then
			-- determine how many companions of this type exist
			numspells = GetNumCompanions(creatureType);
			for tabindex = 1, numspells do
				-- loop through all the companions of this type
				creatureID, creatureName, spellID, icon, active = GetCompanionInfo(creatureType, tabindex);
				if (creatureID ~= nil) then
					-- if we haven't created a macro yet, create the macro
					local macro_exists = GetMacroIndexByName(creatureName);

					-- has the user tried to move this from character to account (or vice versa)? Delete it if they've
					-- changed categories or disabled macro generation.
					if ( (macro_exists > 36 and UK_MACRO_TYPE == 0) or
					     (macro_exists < 37 and UK_MACRO_TYPE == 1) or
					     (macro_exists and UK_MACRO_TYPE == -1) ) then
						DeleteMacro(macro_exists);
						macro_exists = 0;
					end
					
					-- create (or maybe re-create) the macro based on the new MACRO_TYPE
					if (macro_exists == 0 and UK_MACRO_TYPE ~= -1) then	
						CreateMacro(creatureName, 1, 
							"/script CallCompanion('"..creatureType.."',"..tabindex..")", UK_MACRO_TYPE,nil); 
--						CreateMacro(creatureName, 1, 
--							"/cast [nomounted] "..creatureName.." /dismount [mounted]", UK_MACRO_TYPE,nil); 
						
					end
				end --if (creatuer ~= nil)
			end -- for tabindex
		end	-- if (type ~= nil)
	end -- for loopindex
end
-- **********************************************************************
-- scan functions are initiated by the user clicking the scan button. The xml <SCRIPT> for teh scan button
-- then calls OnScanSpells, OnScanPets, OnScanMacros, and OnScanItems then AssembeBindingTable().
function UserKey_OnScanMacros()
	UKDebug("OnScanMacros","OnScanMacros() Entered.");
	local i, glob_macronum, char_macronum, name, texture, body, junk, bindtype;



	UserKeyBindings_macros = {};
	UK_MAX_MACRO_BINDS = 0;
	bindtype="Macro";

	glob_macronum, char_macronum = GetNumMacros();

	table.insert(UserKeyBindings_macros, {text = "*********************** Macros ************************************************", 
		bindtype="na", action="none", k=""});

	for i=1,glob_macronum do
		name, texture, body, junk = GetMacroInfo(i);
			-- protection added due to bugs in wow3.0 beta
			if (name ~= nil and body ~=nil) then
				table.insert(UserKeyBindings_macros, {text=name, bindtype=bindtype, action=name, k=""});
			else
				message("qUserKey has encountered a bug in WoW. WoW reports " ..glob_macronum.." global macros, but returns nil for macro "..i);
			end
	end

	for i=UK_CHARMACRO_OFFSET+1, UK_CHARMACRO_OFFSET+char_macronum, 1 do
		name, texture, body, junk = GetMacroInfo(i);
			-- protection added due to bugs in wow3.0 beta
			if (name ~= nil and body ~=nil) then
				table.insert(UserKeyBindings_macros, {text=name, bindtype=bindtype, action=name, k=""});
			else
				message("qUserKey has encountered a bug in WoW. WoW reports " ..char_macronum.." char macros, but returns nil for macro "..i);
			end
	end

	UK_MAX_MACRO_BINDS = table.getn(UserKeyBindings_macros);

end

-- **********************************************************************
-- This function is called at the end of the series of OnScan*() functions. It rebuilds the UserKeyBindings
-- table with the results of the scans.
function UserKey_AssembleBindingTable()
	UKDebug("AssembleBindingTable","AssembleBindingTable() Entered");
	local i, j;
	local addedPetType, storedPetType;

	UserKeyBindings_inactivepet = {};
	UserKeyBindings_inactivepetcommon = {};
	UK_MAX_INACTIVEPET_BINDS = 0;
	UK_MAX_INACTIVEPETCOMMON_BINDS = 0;

	-- If there was a new pet found on this scan, then get it's name. Otherwise, set the addedPetType to
	-- a default value for comparisons later.

	if (UK_MAX_PET_BINDS ~= 0) then
		addedPetType = strsub(UserKeyBindings_pet[1].text, 1, string.find (UserKeyBindings_pet[1].text, "::") );
	else
		addedPetType = "No Pet Type Added Today";
	end

	-- Since we can only scan information about one pet at a time, we have to search the existing
	-- UserKeyBindings table for any prior pets that were added.

	for i=1,UK_MAX_BINDS do
		-- pet entries all have <petname>:<ability> format, so look for the colon in the string to find 
		-- which entries in UserKeyBindings are pet spells

		if (UserKeyBindings[i].text == nil) then
			-- this should be impossible to occur; however, there seems to be some weird first-time init
			-- situation where this string is nil when you get here.

		elseif (string.find(UserKeyBindings[i].text,"::") ) then
			-- this is a pet ability.

			storedPetType = strsub(UserKeyBindings[i].text, 1, string.find(UserKeyBindings[i].text, "::"));
			if ( storedPetType ~= addedPetType ) then
			-- this entry is for an inactive pet. Keep it around.
				table.insert(UserKeyBindings_inactivepet, { text = UserKeyBindings[i].text,
														bindtype=UserKeyBindings[i].bindtype,
														action=UserKeyBindings[i].action,
														k=UserKeyBindings[i].k } );
			end

		-- all common pet items have "Pet " in the string. Search to find which items in the table are
		-- already listed.
		elseif (string.find(UserKeyBindings[i].text,"Pet ") ) then
			-- this is part of the block of common pet abilities
			table.insert(UserKeyBindings_inactivepetcommon,{text = UserKeyBindings[i].text,
														bindtype=UserKeyBindings[i].bindtype,
														action=UserKeyBindings[i].action,
														k=UserKeyBindings[i].k } );
		end
		i = 1+1
	end
	UK_MAX_INACTIVEPET_BINDS=table.getn(UserKeyBindings_inactivepet);
	UK_MAX_INACTIVEPETCOMMON_BINDS=table.getn(UserKeyBindings_inactivepetcommon);

	-- compare the entries in petcommon[] with inactivepetcommon[] so we don't add duplicates below
	for i=1,UK_MAX_INACTIVEPETCOMMON_BINDS do
		for j=1,UK_MAX_PETCOMMON_BINDS do
			if (UserKeyBindings_petcommon[j].text ~= UserKeyBindings_inactivepetcommon[i].text) then
				table.insert(UserKeyBindings_petcommon,{text = UserKeyBindings_inactivepetcommon[i].text,
														bindtype=UserKeyBindings_inactivepetcommon[i].bindtype,
														action=UserKeyBindings_inactivepetcommon[i].action,
														k=UserKeyBindings_inactivepetcommon[i].k } );	
				break;
			end
			j = j+1;
		end
		i = i + 1;
	end

	-- blank out the binding table and reassemble it from the piece parts.
	UserKeyBindings = {};

	for i=1,UK_MAX_SPELL_BINDS,1 do
		table.insert(UserKeyBindings, {text = UserKeyBindings_spells[i].text,
											bindtype=UserKeyBindings_spells[i].bindtype,
											action=UserKeyBindings_spells[i].action,
											k=UserKeyBindings_spells[i].k });
	end
	
	for i=1,UK_MAX_PETCOMMON_BINDS,1 do
		table.insert(UserKeyBindings,  {text = UserKeyBindings_petcommon[i].text,
											bindtype=UserKeyBindings_petcommon[i].bindtype,
											action=UserKeyBindings_petcommon[i].action,
											k=UserKeyBindings_petcommon[i].k});
	end

	for i=1,UK_MAX_INACTIVEPET_BINDS,1 do
		table.insert(UserKeyBindings,  {text = UserKeyBindings_inactivepet[i].text,
											bindtype=UserKeyBindings_inactivepet[i].bindtype,
											action=UserKeyBindings_inactivepet[i].action,
											k=UserKeyBindings_inactivepet[i].k});
	end

	for i=1,UK_MAX_PET_BINDS,1 do
		table.insert(UserKeyBindings,  {text = UserKeyBindings_pet[i].text,
											bindtype=UserKeyBindings_pet[i].bindtype,
											action=UserKeyBindings_pet[i].action,
											k=UserKeyBindings_pet[i].k});
	end

	for i=1,UK_MAX_MACRO_BINDS,1 do
		table.insert(UserKeyBindings,  {text = UserKeyBindings_macros[i].text,
											bindtype=UserKeyBindings_macros[i].bindtype,
											action=UserKeyBindings_macros[i].action,
											k=UserKeyBindings_macros[i].k});
	end

	for i=1,UK_MAX_ITEM_BINDS,1 do
		table.insert(UserKeyBindings,  {text = UserKeyBindings_items[i].text,
											bindtype=UserKeyBindings_items[i].bindtype,
											action=UserKeyBindings_items[i].action,
											k=UserKeyBindings_items[i].k});
	end

	for i=1,UK_MAX_USER_BINDS,1 do
		table.insert(UserKeyBindings,  {text = UserKeyBindings_user[i].text,
											bindtype=UserKeyBindings_user[i].bindtype,
											action=UserKeyBindings_user[i].action,
											k=UserKeyBindings_user[i].k,
											addon=UserKeyBindings_user[i].addon});
	end

	UserKeyBindings_user = {};
	UK_MAX_USER_BINDS = 0;

	UK_MAX_BINDS = table.getn(UserKeyBindings);

end

-- **************************************************************************
-- Adds new menu button to the main game menu
function UserKey_AddGameMenuButton(button)
	UKDebug("AddGameMenuButton","AddGameMenuButton() Entered.");
	-- button names found in FrameXML/GameMenuFrame.xml
	GameMenu_InsertAfter = GameMenuButtonKeybindings;
	GameMenu_InsertBefore = GameMenuButtonMacros;
	
	-- has someone else tried to take our slot?
	local point, relativeTo, relativePoint, x, y ;
	point, relativeTo, relativePoint, x, y= GameMenu_InsertBefore:GetPoint(1);
	if (relativeTo:GetName() ~= GameMenu_InsertAfter:GetName() ) then
		GameMenu_InsertBefore = relativeTo;
	end

	button:ClearAllPoints();
	button:SetPoint( "TOP", GameMenu_InsertAfter:GetName(), "BOTTOM", 0, -1 );
	GameMenu_InsertBefore:SetPoint( "TOP", button:GetName(), "BOTTOM", 0, -1 );
	
	GameMenu_InsertAfter = button;

	GameMenuFrame:SetHeight( GameMenuFrame:GetHeight() + button:GetHeight() + 2 );
end

-- ****************************************************************************
-- Shuts down the keyboard input mode.
function UserKey_CancelInput()
	UKDebug("CancelInput","CancelInput() Entered.");
	UserKeyGrabber:Hide();
	UserKeyGrabber:EnableKeyboard(0);
	UserKeyUnBind:Disable();
	UserKeyCancelBind:Disable();
	UserKeyPressedButtonNum = -1;
end

-- **********************************************************************
-- Reads our custom tooltip and searches for "Use: " attributes.
function UserKey_ReadTooltip()
--	UKDebug("ReadTooltip","ReadTooltip() Entered.");
	local maxlines, line, i, linetext, itemname;

	maxlines = UserKeyTooltip:NumLines();				-- size of the tooltip
	itemname = UserKeyTooltipTextLeft1:GetText();		-- get the name of the item

	for i=2, maxlines, 1 do									-- start searching after the item name
		line = getglobal("UserKeyTooltipTextLeft"..i);		-- each line of text has this naming scheme
		linetext = line:GetText();							-- read the text on each line
		if (linetext ) then
			if (string.find(linetext,"Use: ") ) then		-- look for the "Use:" label
--			if (string.find(linetext, UK_USESTRING) ) then		-- look for the "Use:" label

				return (itemname);						-- report that this is a bind-able item by returning the name
			end
		end
	end
	return(0);			-- report that this is not a usable item
end


-- **********************************************************************
-- **********************************************************************
-- API function to let other add-ons easily add new functions to our table for their own defined buttons.
-- This function requires a section name plus a table of actionname and action. Bindtype will always be "Click"
-- for user-created buttons.
--
-- Usage: Call this function each time your addon loads. This will add binding buttons to the UserKey interface
-- allowing you to bind keys. If your addon ever fails to load, then your buttons will not be visible to the user in
-- the UserKey interface.
--
--		addon = name of calling add-on
--		section_name = "Jojo's Clever Buttons"
--		button_table = { {"name1", "action1"}, {"name2", "action2"} };

function UserKey_AddButton(addon, section_name, button_table)
	local i, numbuttons, actionname, action;

	if (section_name == nil) then
		message("UserKey_AddButton(): " .. addon .. " " .. UK_STRING_INVALID_SECTIONNAME);
		return 1;
	end

	numbuttons = table.getn(button_table);
	if (numbuttons < 1 or type (button_table) ~= "table" ) then
		message("UserKey_AddButton(): " .. addon .. " " .. UK_STRING_INVALID_BUTTON_TABLE);
		return 1;
	end

	table.insert(UserKeyBindings_user, {text=section_name, bindtype="na", action="none", addon=addon} );
	for i=1, numbuttons, 1 do
		table.insert(UserKeyBindings_user, {text = button_table[i][1], bindtype="Click", action=button_table[i][2], addon=addon});
	end
	UK_MAX_USER_BINDS = table.getn(UserKeyBindings_user);
	return 0;
end

-- **********************************************************************
-- This Function probably isn't necessary. It lets users remove a key binding they've added in this session. 
--		addon = name of calling add-on
--		section_name = "Jojo's Clever Buttons"
--		button_table = { {"name1", "action1"}, {"name2", "action2"} };

function UserKey_RemoveButton(addon, section_name, button_table)
	local i, numbuttons
	
	if (section_name == nil) then
		message("UserKey_RemoveButton(): " .. addon .. " " .. UK_STRING_INVALID_SECTIONNAME);
		return 1;
	end

	numbuttons = table.getn(button_table);
	if (numbuttons < 1 or type(button_table) ~="table" ) then
		message("UserKey_RemoveButton(): " .. addon .. " " .. UK_STRING_INVALID_BUTTON_TABLE);
		return 1;
	end

	for i=1,numbuttons,1 do
		if (UserKeyBindings_user.addon == addon) then
			if (UserKeyBindings_user.action == button_table[i][2]) then
				table.remove(UserKeyBindings_user,i);
			end
		end
	end
	UK_MAX_USER_BINDS = table.getn(UserKeyBindings_user);
	return 0;
end