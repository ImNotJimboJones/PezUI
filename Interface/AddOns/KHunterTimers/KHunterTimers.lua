--[[ 
Kharthus's Hunter Timers by Kharthus of Deathwing

]]

local fireTrapTimer = false;
local frostTrapTimer = false;
local natureTrapTimer = false;

local khtAutoShot = false;
local khtPetIntim = false;
local khtMulti = false;
local khtLockLoad = false;
local khtRapidFire = 0;
local khtImpSteady = 0;
local khtSerpent = 0;
local khtSniper = 0;
local khtFrenzy = 0;

local khtTimeLeft = nil;

local khtDebug = false;
local khtDebugBC = false;

function KHunterTimers_OnLoad(self)
	local playerClass, englishClass = UnitClass("player");
	if(englishClass ~= "HUNTER") then
		return;
	end
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("UNIT_INVENTORY_CHANGED");
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("CHARACTER_POINTS_CHANGED");
	self:RegisterEvent("UNIT_AURA");
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	self:RegisterEvent("START_AUTOREPEAT_SPELL");
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	self:RegisterEvent("PLAYER_REGEN_ENABLED");

	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");

	self:RegisterEvent("ADDON_ACTION_FORBIDDEN");
	self:RegisterEvent("ADDON_ACTION_BLOCKED");

--	self:RegisterAllEvents(); 
	
	tinsert(UISpecialFrames,"KHunterTimersOptions");
	
	if(DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("Kharthus's Hunter Timers "..KHT_VERSION.." Loaded", 1, 0, 0 );
	end
	
	SlashCmdList["KHUNTERTIMERS"] = function (msg)
		KHunterTimers_SlashCmd(msg);
	end
	SLASH_KHUNTERTIMERS1 = "/khuntertimers";
	SLASH_KHUNTERTIMERS2 = "/kht";
	
end

function KHunterTimers_SlashCmd(msg)
	if( msg == "menu" ) then
		KHunterTimers_ShowOptions();
		return;
	elseif( msg == "reset" ) then
		for num = 1, 11, 1 do
			frame = _G["KHunterTimersStatus"..num];
			frame.endTime = 0;
		end
		KHunterTimers_ClearActiveSpells();
		return;
	elseif( msg == "clear all" ) then
		KHunterTimers_ResetOptions();
		DEFAULT_CHAT_FRAME:AddMessage("KHT options reset to defaults.", 1, 0, 0);
		for num = 1, 11, 1 do
			frame = _G["KHunterTimersStatus"..num];
			frame.endTime = 0;
		end
		KHunterTimers_ClearActiveSpells();
		return;
	elseif( msg == "debug" ) then
		if ( khtDebug ) then
			khtDebug = false;
			DEFAULT_CHAT_FRAME:AddMessage("KHT debugging mode disabled.", 1, 0, 0);
		else
			khtDebug = true;
			DEFAULT_CHAT_FRAME:AddMessage("KHT debugging mode enabled.", 1, 0, 0);
		end
		return;
	elseif( msg == "debugbc" ) then
		if ( khtDebugBC ) then
			khtDebugBC = false;
			DEFAULT_CHAT_FRAME:AddMessage("KHT Burning Crusade debugging mode disabled.", 1, 0, 0);
		else
			khtDebugBC = true;
			DEFAULT_CHAT_FRAME:AddMessage("KHT Burning Crusade debugging mode enabled.", 1, 0, 0);
		end
		return;
	elseif( msg == KHT_ON ) then
		if( KHTvars[KHT_ON] ) then
			DEFAULT_CHAT_FRAME:AddMessage("KHT already "..KHT_ON, 1, 0, 0);
			return;
		else
			KHTvars[KHT_ON] = true;
			DEFAULT_CHAT_FRAME:AddMessage("KHT "..KHT_ON, 1, 0, 0);
			return;
		end
	elseif( msg == KHT_OFF ) then
		if( KHTvars[KHT_ON] ) then
			KHTvars[KHT_ON] = false;
			DEFAULT_CHAT_FRAME:AddMessage("KHT "..KHT_OFF, 1, 0, 0);
			return;
		else
			DEFAULT_CHAT_FRAME:AddMessage("KHT not "..KHT_ON, 1, 0, 0);
			return;
		end
	elseif( string.find( msg, "setbgcolor" ) ) then
		for r, g, b, a in string.gmatch( msg, "setcolor (%d+) (%d+) (%d+) (%d+)" ) do
			KHTvars["bg"].r = r/10;
			KHTvars["bg"].g = g/10;
			KHTvars["bg"].b = b/10;
			KHTvars["bg"].a = a/10;
			KHunterTimersFrame:SetBackdropColor( r/10, g/10, b/10, a/10 );
		end
		return;
	elseif( string.find(msg, "delay" ) ) then
		for ms in string.gmatch(msg, "delay (%d+)") do
			KHTvars["shotdelay"] = ms;
			DEFAULT_CHAT_FRAME:AddMessage("Shot delay set to "..ms.."ms");
		end
	elseif( string.find(msg, "scale" ) ) then
		for scale in string.gmatch( msg, "scale (%d+)" ) do
			if( (scale/100) < 0.1 ) then
				scale = 10;
			end
			scale = scale * UIParent:GetScale();
			KHTvars["scale"] = scale/100;
		end
		KHunterTimersFrame:SetScale( KHTvars["scale"] );
		for i=1, 11 do
			_G["KHunterTimersStatus"..i]:SetScale( KHTvars["scale"] );
		end
	elseif( string.find(msg, "down") ) then
		KHTvars["down"] = true;
		KHunterTimers_SetSettings();
		DEFAULT_CHAT_FRAME:AddMessage("KHT: Growing down");
	elseif( string.find(msg, "up" ) ) then
		KHTvars["down"] = false;
		KHunterTimers_SetSettings();
		DEFAULT_CHAT_FRAME:AddMessage("KHT: Growing up");
	elseif( msg == "unlock" ) then
		KHTvars["locked"] = false;
		KHunterTimersAnchor:Show();
	elseif( msg == "lock" ) then
		KHTvars["locked"] = true;
		KHunterTimersAnchor:Hide();
	elseif( string.find(msg, "colorchange" ) ) then
		for on in string.gmatch(msg, "colorchange (%a+)") do
			if( on == KHT_ON ) then
				KHTvars["colorchange"] = true;
			elseif( on == KHT_OFF ) then
				KHTvars["colorchange"] = false;
			end
			if( on == KHT_ON) or ( on == KHT_OFF ) then
				DEFAULT_CHAT_FRAME:AddMessage( "KHT: Colorchange is: "..on);
			end
		end
	elseif( string.find( msg, "barcolor" ) ) then
		for r, g, b in string.gmatch(msg, "barcolor ([%d.]+) ([%d.]+) ([%d.]+)") do
			local red, green, blue = unpack( KHTvars["barstartcolor"] );
			KHTvars["barstartcolor"][1] = r;
			KHTvars["barstartcolor"][2] = g;
			KHTvars["barstartcolor"][3] = b;
			
			local rd, gd, bd = unpack( KHTvars["bardelta"] );
			red = rd + red;
			blue = bd + blue;
			green = gd + green;
			
			red = red - r;
			green = green - g;
			blue = blue - b;
			
			KHTvars["bardelta"][1] = red;
			KHTvars["bardelta"][2] = green;
			KHTvars["bardelta"][3] = blue;
			DEFAULT_CHAT_FRAME:AddMessage( "KHT: Barcolor set to: "..KHTColor(r, g, b)..r..", "..g..", "..b.."|r");
		end
	elseif( string.find( msg, "barendcolor" ) ) then
		for red, green, blue in string.gmatch(msg, "barendcolor ([%d.]+) ([%d.]+) ([%d.]+)") do
			local r, g, b = unpack( KHTvars["barstartcolor"] );
			
			r = red - r;
			g = green - g;
			b = blue - b;
			
			KHTvars["bardelta"][1] = r;
			KHTvars["bardelta"][2] = g;
			KHTvars["bardelta"][3] = b;
			DEFAULT_CHAT_FRAME:AddMessage( "KHT: Barendcolor set to: "..KHTColor(red, green, blue)..red..", "..green..", "..blue.."|r");
		end
	elseif( string.find( msg, "flash" ) ) then
		for flash in string.gmatch( msg, "flash (%d+)" ) do
			flash = flash * 1;
			KHTvars["flash"] = flash;
			if( flash == 0 ) then
				DEFAULT_CHAT_FRAME:AddMessage("KHT: Bar flash "..KHT_OFF);
			else
				DEFAULT_CHAT_FRAME:AddMessage("KHT: Bar flash set to: "..flash.." seconds");
			end
		end
	elseif( string.find( msg, "step" ) ) then
		for step in string.gmatch( msg, "step ([%d.]+)" ) do
			KHTvars["step"] = step
			DEFAULT_CHAT_FRAME:AddMessage("KHT: Step set to: "..step);
		end
	elseif( msg == "resetpos" ) then
		KHunterTimersAnchor:ClearAllPoints();
		KHunterTimersAnchor:SetPoint("CENTER", "UIParent", "CENTER", 0, 0 );
		KHunterTimers_SavePos( _G["KHunterTimersAnchor"] );
		KHunterTimersOptions:ClearAllPoints();
		KHunterTimersOptions:SetPoint("CENTER", "UIParent", "CENTER", 0, 0 );
		KHunterTimers_SavePos( _G["KHunterTimersOptions"] );
	elseif( string.find( msg, "(%a+) (%d+)" ) ) then
		for cmd1, cmd2 in string.gmatch( msg, "(%a+) (%d+)" ) do
			--DEFAULT_CHAT_FRAME:AddMessage(cmd1.."-"..cmd2, 1, 0, 0);
			KHunterTimersFrame_add( cmd2, cmd1 );
		end
	elseif( msg == "status" ) then

		local statusstring = "";
		local statusstring1 = "";
		local statusstring2 = "";
		
		if( KHTvars[KHT_ON] ) then
			statusstring1 = KHT_ON;
		else
			statusstring1 = KHT_OFF;
		end
		DEFAULT_CHAT_FRAME:AddMessage(KHT_STATUS_STRINGS[1]);
		DEFAULT_CHAT_FRAME:AddMessage(format(KHT_STATUS_STRINGS[2], statusstring1));
		DEFAULT_CHAT_FRAME:AddMessage(format(KHT_STATUS_STRINGS[3], KHTvars["shotdelay"]));
		DEFAULT_CHAT_FRAME:AddMessage(format(KHT_STATUS_STRINGS[4], KHTvars["flash"], KHTvars["step"]));

		local r, g, b = unpack( KHTvars["barstartcolor"] );
		local rd, gd, bd = unpack( KHTvars["bardelta"] );
		statusstring1 = KHTColor(r,g,b)..r..", "..g..", "..b.."|r";
		statusstring2 = KHTColor(r+rd, g+gd, b+bd)..(r+rd)..", "..(b+bd)..", "..(g+gd).."|r";
		DEFAULT_CHAT_FRAME:AddMessage(format(KHT_STATUS_STRINGS[5], statusstring1, statusstring2));
		
		if( KHTvars["colorchange"] ) then
			statusstring1 = KHT_ON;
		else
			statusstring1 = KHT_OFF;
		end
		if( KHTvars["down"] ) then
			statusstring2 = "down";
		else
			statusstring2 = "up";
		end
		DEFAULT_CHAT_FRAME:AddMessage(format(KHT_STATUS_STRINGS[6], statusstring1, statusstring2));
		DEFAULT_CHAT_FRAME:AddMessage(format(KHT_STATUS_STRINGS[7], (KHTvars["scale"]/UIParent:GetScale()*100) ) );
	else
		for key,val in ipairs(KHT_SLASH_HELP) do
			DEFAULT_CHAT_FRAME:AddMessage(val, 1, 1, 0);
		end
	end
	
end

function KHunterTimersFrame_add( spellDuration, spellName, spellId, target, GUID )
	if( KHTvars["numBars"] < 0 ) then
		KHTvars["numBars"] = 0;
	end
	
	local allReadyActive = false;
	local bar;
	
	if( KHT_sfind( spellName, KHT_STING ) and spellName ~= KHT_BLOOD_HUNT_4PC or string.find( spellName, KHT_CONC_SHOT ) ) then
		spellDuration = spellDuration + KHTvars["shotdelay"];
	end
	
	if( spellName == KHT_INTIM ) then
		--DEFAULT_CHAT_FRAME:AddMessage("Intim", 1, 1, 0 );
		if( khtPetIntim ) then
			--DEFAULT_CHAT_FRAME:AddMessage("Pet Intim", 1, 1, 0 );
			for num = 1, KHTvars["numBars"], 1 do
				local barframe = _G["KHunterTimersStatus"..num];
				--DEFAULT_CHAT_FRAME:AddMessage("Intim: "..textBar, 1, 1, 0 );
				if( string.find( barframe.spell, KHT_PET_INTIM ) ) then
					allReadyActive = true;
					bar = num;
					break;
				end
			end
		end
	elseif( spellName == KHT_FROST_TRAP.." "..KHT_PRIMED or spellName == KHT_FREEZING_TRAP.." "..KHT_PRIMED and frostTrapTimer ) then
		for num = 1, KHTvars["numBars"], 1 do
			local barframe = _G["KHunterTimersStatus"..num];
			if( barframe.spell == KHT_FROST_TRAP.." "..KHT_PRIMED or barframe.spell == KHT_FREEZING_TRAP.." "..KHT_PRIMED ) then
				allReadyActive = true;
				bar = num;
				break;
			end
		end
	elseif( spellName == KHT_EXPL_TRAP.." "..KHT_PRIMED or spellName == KHT_IMMO_TRAP.." "..KHT_PRIMED and fireTrapTimer ) then
		for num = 1, KHTvars["numBars"], 1 do
			local barframe = _G["KHunterTimersStatus"..num];
			if( barframe.spell == KHT_EXPL_TRAP.." "..KHT_PRIMED or barframe.spell == KHT_IMMO_TRAP.." "..KHT_PRIMED ) then
				allReadyActive = true;
				bar = num;
				break;
			end
		end
	elseif( spellName == KHT_SNAKE_TRAP.." "..KHT_PRIMED and natureTrapTimer ) then
		for num = 1, KHTvars["numBars"], 1 do
			local barframe = _G["KHunterTimersStatus"..num];
			if( barframe.spell == KHT_SNAKE_TRAP.." "..KHT_PRIMED ) then
				allReadyActive = true;
				bar = num;
				break;
			end
		end
	elseif( KHT_sfind( spellName, KHT_STING ) and spellName ~= KHT_BLOOD_HUNT_4PC ) then
		for num = 1, KHTvars["numBars"] do
			local barframe = _G["KHunterTimersStatus"..num];
			if( KHT_sfind( barframe.spell, KHT_STING ) and ( barframe.GUID == GUID ) ) then
				allReadyActive = true;
				bar = num;
				break;
			end
		end
	elseif( KHT_sfind( spellName, KHT_HUNTERS_MARK ) ) then
		for num = 1, KHTvars["numBars"] do
			local barframe = _G["KHunterTimersStatus"..num];
			if( KHT_sfind( barframe.spell, KHT_HUNTERS_MARK ) ) then
				allReadyActive = true;
				bar = num;
				break;
			end
		end
	elseif( spellName == KHT_AUTO_SHOT ) and KHTvars["sticky"]  then
		if( KHunterTimersStatus1.spell == KHT_AUTO_SHOT ) then
			allReadyActive = true;
			bar = 1;
		else
			KHunterTimers_shift(1);
			allReadyActive = true;
			if( KHTvars["numBars"] == 11 ) then
				return;
			end
			KHTvars["numBars"] = KHTvars["numBars"] + 1;
			bar = 1;
		end
	elseif( not string.find( spellName, KHT_FLARE ) ) then
		for num = 1, KHTvars["numBars"], 1 do
			local barframe = _G["KHunterTimersStatus"..num];
			if( barframe.spell == spellName ) and ( barframe.GUID == GUID ) and ( barframe.spellId == spellId ) then
				allReadyActive = true;
				bar = num;
				break;
			end
		end
	end
	
	local num = bar;
	if( allReadyActive ) then
		if( KHTvars["numBars"] == 0 ) then
			KHTvars["numBars"] = 1;
		end
	else
		if( KHTvars["numBars"] == 11 ) then
			return;
		end
		KHTvars["numBars"] = KHTvars["numBars"] + 1;
		num = KHTvars["numBars"];
	end
	
	local icon = _G["KHunterTimersStatus"..num.."Icon"];
	local barframe = _G["KHunterTimersStatus"..num];
	local bar = _G["KHunterTimersStatus"..num.."Bar"];
	local leftText = _G["KHunterTimersStatus"..num.."BarLeftText"];
	local rightText = _G["KHunterTimersStatus"..num.."BarRightText"];
	
	if( not barframe ) then
		--DEFAULT_CHAT_FRAME:AddMessage("WTFBBQ line 214");
		return;
	end
	local texture;
	if( string.find( spellName, KHT_FREEZING_TRAP ) )then
		texture = KHTvars["textures"][KHT_FREEZING_TRAP]
	elseif( string.find( spellName, KHT_IMMO_TRAP ) ) then
		texture = KHTvars["textures"][KHT_IMMO_TRAP]
	elseif( string.find( spellName, KHT_FROST_TRAP ) ) then
		texture = KHTvars["textures"][KHT_FROST_TRAP]
	elseif( string.find( spellName, KHT_EXPL_TRAP ) ) then
		texture = KHTvars["textures"][KHT_EXPL_TRAP]
	elseif( string.find( spellName, KHT_SNAKE_TRAP ) ) then
		texture = KHTvars["textures"][KHT_SNAKE_TRAP]
	elseif( string.find( spellName, KHT_PET_INTIM ) ) then
		texture = KHTvars["textures"][KHT_INTIM];
	elseif( spellName == KHT_WYVERN_TEXT ) then
		texture = KHTvars["textures"][KHT_WYVERN];
	elseif( spellName == KHT_SERPENT.." (AoE)" ) then
		texture = KHTvars["textures"][KHT_SERPENT];
	elseif( spellName == KHT_AUTO_SHOT ) then
		texture = GetInventoryItemTexture("player", 18);
	else
		texture = KHTvars["textures"][spellName];
	end
	icon:SetTexture(texture);
	barframe.spell = spellName;
	barframe.spellId = spellId;
	barframe.texture = texture;
	barframe.target = target;
	barframe.GUID = GUID;
	barframe.startTime = GetTime();
	barframe.duration = spellDuration / 1000;
	barframe.endTime = barframe.startTime + barframe.duration;
	bar:SetMinMaxValues(barframe.startTime, barframe.endTime);
	bar:SetValue( barframe.endTime );
	if( KHTvars["append"] ) and (barframe.target) then
		leftText:SetText(KHTColor(unpack(KHTvars["skillcolor"]))..spellName.."|r - "..KHTColor(unpack(KHTvars["targetcolor"]))..barframe.target);
	else
		leftText:SetText(KHTColor(unpack(KHTvars["skillcolor"]))..spellName);
	end
	if( KHTvars["mili"] == 0 ) then
		rightText:SetFormattedText(KHTColor(unpack(KHTvars["timecolor"])).."%ds", barframe.duration);
	else
		rightText:SetFormattedText(KHTColor(unpack(KHTvars["timecolor"])).."%."..KHTvars["mili"].."f", barframe.duration);
	end
	barframe.channeling = true;
	barframe.fadeOut = false;
	KHunterTimersFrame:SetAlpha(KHTvars["overallalpha"]);
	KHT_SetHeight();
	if( not KHunterTimersFrame:IsVisible() ) then
		KHunterTimersFrame:Show();
	end
	local r, g, b, a = unpack( KHTvars["barstartcolor"] );
	bar:SetStatusBarColor(r, g, b, a );
	barframe:SetAlpha(KHTvars["overallalpha"]);
	KHunterTimers_SetWidths();
	barframe:Show();
end

function KHunterTimers_SetWidths()	
	local largestwidth = 180;
	if( KHTvars["showtex"] ) then
		if( KHTvars["largetex"] ) and (KHTvars["barheight"] < 16 ) then
			largestwidth = largestwidth - 16;
		else
			largestwidth = largestwidth - KHTvars["barheight"];
		end
		if( KHTvars["gap"] ) then
			largestwidth = largestwidth - 5;
		end
	end
	local tarwidth = largestwidth;
	local extrawidth = 0;
	for i=1, KHTvars["numBars"] do
		local width = _G["KHunterTimersStatus"..i.."BarLeftText"]:GetWidth() + _G["KHunterTimersStatus"..i.."BarRightText"]:GetWidth();
		if( width > largestwidth ) then
			largestwidth = width;
		end
	end
	if( largestwidth > tarwidth ) and (not KHTvars["hidetext"]) then
		largestwidth = largestwidth + 40;
		if( KHTvars["showtex"] ) then
			extrawidth = KHTvars["barheight"];
			if( KHTvars["largetex"] ) and ( KHTvars["barheight"] < 16 ) then
				extrawidth = 16;
			end
			if( KHTvars["gap"] ) then
				extrawidth = extrawidth + 5;
			end
		end
		for i=1, KHTvars["numBars"] do
			_G["KHunterTimersStatus"..i]:SetWidth(largestwidth + extrawidth);
			_G["KHunterTimersStatus"..i.."Bar"]:SetWidth(largestwidth);
			_G["KHunterTimersStatus"..i.."BarTooltip"]:SetWidth(largestwidth);
		end
		if( KHTvars["padding"] ) then
			KHunterTimersFrame:SetWidth(largestwidth + extrawidth + 20);
		else
			KHunterTimersFrame:SetWidth(largestwidth + extrawidth + 10);
		end
	else
		if( KHTvars["padding"] ) then
			KHunterTimersFrame:SetWidth( 240 );
		else
			KHunterTimersFrame:SetWidth( 230 );
		end
		local width = 220;
		if( KHTvars["showtex"] ) then
			if( KHTvars["largetex"] ) and ( KHTvars["barheight"] < 16) then
				width = width - 16;
			else
				width = width - KHTvars["barheight"];
			end
			if( KHTvars["gap"] ) then
				width = width - 5;
			end
		end
		for i=1, KHTvars["numBars"] do
			_G["KHunterTimersStatus"..i]:SetWidth(220);
			_G["KHunterTimersStatus"..i.."Bar"]:SetWidth(width);
			_G["KHunterTimersStatus"..i.."BarTooltip"]:SetWidth(width);
		end
	end
end
			
			

function KHunterTimers_OnUpdateBar( id )
	if( not KHunterTimersFrame:IsVisible() ) then
		KHunterTimersFrame:Show();
	end

	if( IsControlKeyDown() ) then
		_G["KHunterTimersStatus"..id.."BarTooltip"]:Show();
	else
		_G["KHunterTimersStatus"..id.."BarTooltip"]:Hide();
	end

	local barframe = _G["KHunterTimersStatus"..id];
	if( barframe.channeling ) then
		local time = GetTime();
		local bartext = _G[ "KHunterTimersStatus"..id.."BarRightText"];
		local text = barframe.spell;

		if( time >= barframe.endTime ) then
			if( barframe.spell == KHT_AUTO_SHOT and khtAutoShot ) then
				return;
			end
			barframe.channeling = false;
			barframe.fadeOut = true;
			barframe.step = 0;
			barframe.target = nil;
			barframe.GUID = nil;
			barframe.spellId = nil;
			bartext:SetText( KHT_DONE );
			if( khtPetIntim ) and ( text == KHT_PET_INTIM ) then
				khtPetIntim = false;
			elseif( frostTrapTimer ) and ( text == KHT_FROST_TRAP.." "..KHT_PRIMED or 
                                              text == KHT_FREEZING_TRAP.." "..KHT_PRIMED ) then
				frostTrapTimer = false;
			elseif( fireTrapTimer ) and ( text == KHT_EXPL_TRAP.." "..KHT_PRIMED or 
                                             text == KHT_IMMO_TRAP.." "..KHT_PRIMED ) then
				fireTrapTimer = false;
			elseif( natureTrapTimer ) and ( text == KHT_SNAKE_TRAP.." "..KHT_PRIMED ) then
				natureTrapTimer = false;
			elseif( khtLockLoad ) and ( text == KHT_LOCK_LOAD ) then
				khtLockLoad = false;
			end
			return;
		end

		local bar = _G["KHunterTimersStatus"..id.."Bar"];
		local value = barframe.startTime + barframe.endTime - time;
		bar:SetValue( value );
		local timeleft = barframe.duration - (time - barframe.startTime);
		if( KHTvars["mili"] == 0 ) then
			_G["KHunterTimersStatus"..id.."BarRightText"]:SetFormattedText(KHTColor(unpack(KHTvars["timecolor"])).."%ds", timeleft);
		else
			_G["KHunterTimersStatus"..id.."BarRightText"]:SetFormattedText(KHTColor(unpack(KHTvars["timecolor"])).."%."..KHTvars["mili"].."f", timeleft);
		end
		if( KHTvars["colorchange"] ) then
			local percent = (time - barframe.startTime)/(barframe.endTime - barframe.startTime);
			local r, g, b, a = unpack( KHTvars["barstartcolor"] );
			local redd, greend, blued, alphad = unpack( KHTvars["bardelta"] );
			redd = r + redd*percent;
			greend = g + greend*percent;
			blued = b + blued*percent;
			alphad = a + alphad*percent;
			bar:SetStatusBarColor( redd, greend, blued, alphad );
		end
		
		if( timeleft < KHTvars["flash"] ) and ( barframe.spell ~= KHT_AUTO_SHOT ) then
			if( barframe.step == 0 ) then
				barframe.step = -KHTvars["step"];
			end
			
			local alpha = barframe:GetAlpha() + barframe.step;
			if( alpha < 0.2 ) then
				barframe.step = KHTvars["step"];
			elseif( alpha > KHTvars["overallalpha"] ) then
				barframe.step = -KHTvars["step"];
			end
			barframe:SetAlpha(alpha);
		end
			
			
	elseif( barframe.fadeOut ) then
		local alpha = barframe:GetAlpha() - 0.05;
		if( alpha > 0 ) then
			barframe:SetAlpha(alpha);
		else
			barframe.fadeOut = false;
			barframe:Hide();
			KHTvars["numBars"] = KHTvars["numBars"] - 1;
			KHunterTimers_AutoCascade( 1, false );
		end
	end
end

function KHunterTimersFrame_OnUpdate(self, elapsed)
	if( (elapsed - self.updateTime) > 1 ) then
		self.updateTime = elapsed;
		
		KHunterTimersFrame:SetScale( KHTvars["scale"] );
		for i=1, KHT_NUM_BARS do
			_G["KHunterTimersStatus"..i]:SetScale( KHTvars["scale"] );
		end
		KHT_SetHeight();
	end
	
	if ( KHTvars["numBars"] > 0 ) then
		KHunterTimersFrame:Show();
		KHunterTimersFrame:SetAlpha( KHTvars["overallalpha"] );
	else
		local alpha = KHunterTimersFrame:GetAlpha() - 0.05;
		if( alpha > 0 ) then
			KHunterTimersFrame:SetAlpha(alpha);
		else
			KHunterTimersFrame:Hide();
		end
	end
end

function KHunterTimersTab_OnClick(self)
	for i=1,6 do
		if ( self:GetID() == i ) then
			_G["KHunterTimersOptionsTimers"..i]:Show();
		else
			_G["KHunterTimersOptionsTimers"..i]:Hide();
		end
	end
	PlaySound("igCharacterInfoTab");
	PanelTemplates_SetTab(KHunterTimersOptionsTimers, self:GetID());
end

function KHunterTimers1ScrollBar_OnClick()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers1ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[1] then
			if( _G["KHunterTimersOptionsTimers1CheckButton"..line]:GetChecked() == 1 ) then
				KHTvars["skills"][KHT_OPTIONS_TIMERS[1][lineplusoffset]] = true;
			else
				KHTvars["skills"][KHT_OPTIONS_TIMERS[1][lineplusoffset]] = false;
			end
		end
	end
end

function KHunterTimers1ScrollBar_Update()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
--	FauxScrollFrame_Update(KHunterTimers1ScrollBar,KHT_NUM_TIMERS[1],13,32);
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers1ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[1] then
			_G["KHunterTimersOptionsTimers1CheckButton"..line.."Text"]:SetText(KHT_OPTIONS_TIMERS[1][lineplusoffset]);
			if( KHTvars["skills"][KHT_OPTIONS_TIMERS[1][lineplusoffset]] ) then
				_G["KHunterTimersOptionsTimers1CheckButton"..line]:SetChecked(1);
			else
				_G["KHunterTimersOptionsTimers1CheckButton"..line]:SetChecked(0);
			end
			_G["KHunterTimersOptionsTimers1CheckButton"..line]:Show();
		else
			_G["KHunterTimersOptionsTimers1CheckButton"..line]:Hide();
		end
	end
end

function KHunterTimers2ScrollBar_OnClick()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers2ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[2] then
			if( _G["KHunterTimersOptionsTimers2CheckButton"..line]:GetChecked() == 1 ) then
				KHTvars["skills"][KHT_OPTIONS_TIMERS[2][lineplusoffset]] = true;
			else
				KHTvars["skills"][KHT_OPTIONS_TIMERS[2][lineplusoffset]] = false;
			end
		end
	end
end

function KHunterTimers2ScrollBar_Update()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	FauxScrollFrame_Update(KHunterTimers2ScrollBar,KHT_NUM_TIMERS[2],13,32);
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers2ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[2] then
			_G["KHunterTimersOptionsTimers2CheckButton"..line.."Text"]:SetText(KHT_OPTIONS_TIMERS[2][lineplusoffset]);
			if( KHTvars["skills"][KHT_OPTIONS_TIMERS[2][lineplusoffset]] ) then
				_G["KHunterTimersOptionsTimers2CheckButton"..line]:SetChecked(1);
			else
				_G["KHunterTimersOptionsTimers2CheckButton"..line]:SetChecked(0);
			end
			_G["KHunterTimersOptionsTimers2CheckButton"..line]:Show();
		else
			_G["KHunterTimersOptionsTimers2CheckButton"..line]:Hide();
		end
	end
end

function KHunterTimers3ScrollBar_OnClick()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers3ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[3] then
			if( _G["KHunterTimersOptionsTimers3CheckButton"..line]:GetChecked() == 1 ) then
				KHTvars["skills"][KHT_OPTIONS_TIMERS[3][lineplusoffset]] = true;
			else
				KHTvars["skills"][KHT_OPTIONS_TIMERS[3][lineplusoffset]] = false;
			end
		end
	end
end

function KHunterTimers3ScrollBar_Update()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	FauxScrollFrame_Update(KHunterTimers3ScrollBar,KHT_NUM_TIMERS[3],13,32);
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers3ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[3] then
			_G["KHunterTimersOptionsTimers3CheckButton"..line.."Text"]:SetText(KHT_OPTIONS_TIMERS[3][lineplusoffset]);
			if( KHTvars["skills"][KHT_OPTIONS_TIMERS[3][lineplusoffset]] ) then
				_G["KHunterTimersOptionsTimers3CheckButton"..line]:SetChecked(1);
			else
				_G["KHunterTimersOptionsTimers3CheckButton"..line]:SetChecked(0);
			end
			_G["KHunterTimersOptionsTimers3CheckButton"..line]:Show();
		else
			_G["KHunterTimersOptionsTimers3CheckButton"..line]:Hide();
		end
	end
end

function KHunterTimers4ScrollBar_OnClick()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers4ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[4] then
			if( _G["KHunterTimersOptionsTimers4CheckButton"..line]:GetChecked() == 1 ) then
				KHTvars["skills"][KHT_OPTIONS_TIMERS[4][lineplusoffset]] = true;
			else
				KHTvars["skills"][KHT_OPTIONS_TIMERS[4][lineplusoffset]] = false;
			end
		end
	end
end

function KHunterTimers4ScrollBar_Update()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	FauxScrollFrame_Update(KHunterTimers4ScrollBar,KHT_NUM_TIMERS[4],13,32);
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers4ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[4] then
			_G["KHunterTimersOptionsTimers4CheckButton"..line.."Text"]:SetText(KHT_OPTIONS_TIMERS[4][lineplusoffset]);
			if( KHTvars["skills"][KHT_OPTIONS_TIMERS[4][lineplusoffset]] ) then
				_G["KHunterTimersOptionsTimers4CheckButton"..line]:SetChecked(1);
			else
				_G["KHunterTimersOptionsTimers4CheckButton"..line]:SetChecked(0);
			end
			_G["KHunterTimersOptionsTimers4CheckButton"..line]:Show();
		else
			_G["KHunterTimersOptionsTimers4CheckButton"..line]:Hide();
		end
	end
end

function KHunterTimers5ScrollBar_OnClick()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers5ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[5] then
			if( _G["KHunterTimersOptionsTimers5CheckButton"..line]:GetChecked() == 1 ) then
				KHTvars["skills"][KHT_OPTIONS_TIMERS[5][lineplusoffset]] = true;
			else
				KHTvars["skills"][KHT_OPTIONS_TIMERS[5][lineplusoffset]] = false;
			end
		end
	end
end

function KHunterTimers5ScrollBar_Update()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	FauxScrollFrame_Update(KHunterTimers5ScrollBar,KHT_NUM_TIMERS[5],13,32);
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers5ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[5] then
			_G["KHunterTimersOptionsTimers5CheckButton"..line.."Text"]:SetText(KHT_OPTIONS_TIMERS[5][lineplusoffset]);
			if( KHTvars["skills"][KHT_OPTIONS_TIMERS[5][lineplusoffset]] ) then
				_G["KHunterTimersOptionsTimers5CheckButton"..line]:SetChecked(1);
			else
				_G["KHunterTimersOptionsTimers5CheckButton"..line]:SetChecked(0);
			end
			_G["KHunterTimersOptionsTimers5CheckButton"..line]:Show();
		else
			_G["KHunterTimersOptionsTimers5CheckButton"..line]:Hide();
		end
	end
end

function KHunterTimers6ScrollBar_OnClick()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers6ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[6] then
			if( _G["KHunterTimersOptionsTimers6CheckButton"..line]:GetChecked() == 1 ) then
				KHTvars["skills"][KHT_OPTIONS_TIMERS[6][lineplusoffset]] = true;
			else
				KHTvars["skills"][KHT_OPTIONS_TIMERS[6][lineplusoffset]] = false;
			end
		end
	end
end

function KHunterTimers6ScrollBar_Update()
	local line; -- 1 through 13 of our window to scroll
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	FauxScrollFrame_Update(KHunterTimers6ScrollBar,KHT_NUM_TIMERS[6],13,32);
	for line=1,13 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(KHunterTimers6ScrollBar);
		if lineplusoffset <= KHT_NUM_TIMERS[6] then
			_G["KHunterTimersOptionsTimers6CheckButton"..line.."Text"]:SetText(KHT_OPTIONS_TIMERS[6][lineplusoffset]);
			if( KHTvars["skills"][KHT_OPTIONS_TIMERS[6][lineplusoffset]] ) then
				_G["KHunterTimersOptionsTimers6CheckButton"..line]:SetChecked(1);
			else
				_G["KHunterTimersOptionsTimers6CheckButton"..line]:SetChecked(0);
			end
			_G["KHunterTimersOptionsTimers6CheckButton"..line]:Show();
		else
			_G["KHunterTimersOptionsTimers6CheckButton"..line]:Hide();
		end
	end
end

function KHT_init()
	if( not KHTvars ) then
		KHTvars = {};
		KHTvars["bg"] = { r=0, g=0, b=0, a=7 };
	end
	if( KHTvars[KHT_ON] == nil ) then
		KHTvars[KHT_ON] = true;
	end
	if( not KHTvars["borderalpha"] ) then
		KHTvars["borderalpha"] = {
			[1] = 1;
			[2] = 1;
			[3] = 1;
			[4] = 1;
		};
	end
	KHunterTimersFrame:SetBackdropColor( KHTvars["bg"].r, KHTvars["bg"].g, KHTvars["bg"].b, KHTvars["bg"].a );
	KHunterTimersFrame:SetBackdropBorderColor( unpack(KHTvars["borderalpha"]) );
	KHTvars["numBars"] = 0;

	if( not KHTvars["skills"] ) then
		KHTvars["skills"] = {};
	end

	if( KHTvars["version"] == nil or KHTvars["version"] < 2.9 ) then
		KHTvars["skills"] = {};
		KHTvars["version"] = 3.0;
	end
	
	for i=1, 6 do
		for j=1, KHT_NUM_TIMERS[i] do
			if ( KHTvars["skills"][KHT_OPTIONS_TIMERS[i][j]] == nil ) then
				KHTvars["skills"][KHT_OPTIONS_TIMERS[i][j]] = true;
			end
		end
	end
	
	if( not KHTvars["shotdelay"] ) then
		KHTvars["shotdelay"] = 200;
	end

	if( not KHTvars["scale"] ) then
		KHTvars["scale"] = UIParent:GetScale();
	end
	
	if( KHTvars["locked"] == nil ) then
		KHTvars["locked"] = false;
	end
	
	if( not KHTvars["locked"] ) then
		KHunterTimersAnchor:Show();
	else
		KHunterTimersAnchor:Hide();
	end
	
	if( not KHTvars["mili"] ) then
		KHTvars["mili"] = 1;
	end
	
	if( KHTvars["flash"] == nil ) then
		KHTvars["flash"] = 5;
	end
	
	if( not KHTvars["skillcolor"] ) then
		local r, g, b = KHunterTimersStatus1BarLeftText:GetTextColor();
		--local a = KHunterTimersStatus1BarLeftText:GetAlpha();
		KHTvars["skillcolor"] = {
			[1] = r,
			[2] = g,
			[3] = b,
			[4] = 1
		};
	end
	
	if( not KHTvars["timecolor"] ) then
		local r, g, b = KHunterTimersStatus1BarRightText:GetTextColor();
		KHTvars["timecolor"] = {
			[1] = r,
			[2] = g,
			[3] = b,
			[4] = 1
		};
	end
	
	if( not KHTvars["targetcolor"] ) then
		local r, g, b = KHunterTimersStatus1BarLeftText:GetTextColor();
		KHTvars["targetcolor"] = {
			[1] = r,
			[2] = g,
			[3] = b,
			[4] = 1
		};
	end
	
	if( not KHTvars["barstartcolor"] ) then
		KHTvars["barstartcolor"] = {
			[1] = 0,
			[2] = 0.8,
			[3] = 0,
			[4] = 1 };
	end
	if( not KHTvars["barstartcolor"][4] ) then
		KHTvars["barstartcolor"][4] = 1;
	end
	if( not KHTvars["bardelta"] ) then
		KHTvars["bardelta"] = {
			[1] = 0.8,
			[2] = -0.8,
			[3] = 0,
			[4] = 0};
	end
	if( not KHTvars["bardelta"][4] ) then
		KHTvars["bardelta"][4] = 0;
	end
	if( KHTvars["step"] == nil ) then
		KHTvars["step"] = 0.03;
	end
	if( KHTvars["colorchange"] == nil ) then
		KHTvars["colorchange"] = false;
	end
	if( not KHTvars["bardistance"] ) then
		KHTvars["bardistance"] = 10;
	end
	
	if( KHTvars["down"] == nil ) then
		KHTvars["down"] = true;
	end
	
	if( KHTvars["append"] == nil ) then
		KHTvars["append"] = false;
	end
	
	if( not KHTvars["overallalpha"] ) then
		KHTvars["overallalpha"] = 1;
	end
	
	KHunterTimers_ClearActiveSpells();
	
	for i=1, KHT_NUM_OPTIONS do --Check boxes
		_G["KHunterTimersOptionsBarsCheckButton"..i.."Text"]:SetText(KHT_OPTIONS_BARS[i]);
	end
	
	for i=1, KHT_NUM_SLIDERS do  --Sliders
		_G["KHunterTimersOptionsBarsSlider"..i.."SliderTitle"]:SetText(KHT_OPTIONS_SLIDER[i]);
		_G["KHunterTimersOptionsBarsSlider"..i.."SliderLow"]:SetText(KHT_OPTIONS_SLIDER_ENDS[i][1])
		_G["KHunterTimersOptionsBarsSlider"..i.."SliderHigh"]:SetText(KHT_OPTIONS_SLIDER_ENDS[i][2]);
	end
	
	if( not KHTvars["textures"] ) then
		KHTvars["textures"] = {};
	end
	
	if( KHTvars["showtex"] == nil ) then
		KHTvars["showtex"] = true;
	end
	if( KHTvars["largetex"] == nil ) then
		KHTvars["largetex"] = true;
	end
	
	if( KHTvars["hidetext"] == nil ) then
		KHTvars["hidetext"] = false;
	end
	
	if( KHTvars["hidetime"] == nil ) then
		KHTvars["hidetime"] = false;
	end
	
	if( KHTvars["gap"] == nil ) then
		KHTvars["gap"] = true;
	end
	
	if( KHTvars["padding"] == nil ) then
		KHTvars["padding"] = true;
	end
	
	if( not KHTvars["barheight"] ) then
		KHTvars["barheight"] = 10;
	end
	
	if( KHTvars["sticky"] == nil ) then
		KHTvars["sticky"] = true;
	end
	
	if( KHTvars["traptimemult"] == nil ) then
		KHTvars["traptimemult"] = 1;
	end
	
	if( KHTvars["entrampentmult"] == nil ) then
		KHTvars["entrapmentmult"] = 0;
	end
	
	if( KHTvars["impconc"] == nil ) then
		KHTvars["impconc"] = 0;
	end
	
	if( KHTvars["bartexture"] == nil ) then
		KHTvars["bartexture"] = "Interface\\TargetingFrame\\UI-TargetingFrame-BarFill";
	end
	
	for i=1, KHT_NUM_LABELS do
		_G["KHunterTimersOptionsBarsLabel"..i.."Label"]:SetText(KHT_OPTIONS_LABELS[i]);
	end
	
	_G["KHunterTimersOptionsTitleString"]:SetText("Kharthus's Hunter Timers "..KHT_VERSION);
	
end

function KHunterTimersFrame_OnEvent(frame, event, ...)
	local firstArg, secondArg, thirdArg, fourthArg = ...;
	
	if( event == "ADDON_ACTION_BLOCKED" or event == "ADDON_ACTION_FORBIDDEN" ) then
		if ( firstArg == "ItemRack" or firstArg == "CT_RaidAssist" ) then
		elseif ( khtDebugBC ) then
			DEFAULT_CHAT_FRAME:AddMessage(event.." "..firstArg.." "..secondArg, 1, 0, 0 );
		end
		return;
	end
	
	if ( khtDebug ) then
		if ( event ~= "COMBAT_LOG_EVENT_UNFILTERED" ) then
			if ( fourthArg ) then
				DEFAULT_CHAT_FRAME:AddMessage(event.." "..firstArg.." "..secondArg.." "..thirdArg.." "..fourthArg, 1, 0, 0 );
			elseif ( thirdArg ) then
				DEFAULT_CHAT_FRAME:AddMessage(event.." "..firstArg.." "..secondArg.." "..thirdArg, 1, 0, 0 );
			elseif ( secondArg ) then
				DEFAULT_CHAT_FRAME:AddMessage(event.." "..firstArg.." "..secondArg, 1, 0, 0 );
			elseif ( firstArg ) then
				DEFAULT_CHAT_FRAME:AddMessage(event.." "..firstArg, 1, 0, 0 );
			else
				DEFAULT_CHAT_FRAME:AddMessage(event, 1, 0, 0 );
			end
		end
	end

	if( event == "ADDON_LOADED" and firstArg == "KHunterTimers" ) then
		KHT_init();
		return;
	end
	if( event == "PLAYER_LOGIN" ) then
		KHunterTimers_SetSettings();
		KHunterTimers_UpdateSpells();
		KHunterTimers_UpdateTalents();
		
		KHunterTimersOptions:SetScale(UIParent:GetScale());

		if( KHTvars["KHunterTimersAnchor"] == nil ) then
			KHTvars["KHunterTimersAnchor"] = {};
			KHunterTimers_SavePos( _G["KHunterTimersAnchor"] );
			KHTvars["version"] = 3.0;
		end

		KHunterTimers_ResetPos( _G["KHunterTimersAnchor"] );

		if( KHTvars["KHunterTimersOptions"] == nil ) then
			KHTvars["KHunterTimersOptions"] = {};
			KHunterTimers_SavePos( _G["KHunterTimersOptions"] );
			KHTvars["version"] = 3.0;
		end

		KHunterTimers_ResetPos( _G["KHunterTimersOptions"] );

		return;
	end
	if( event == "PLAYER_TALENT_UPDATE" or event == "UNIT_INVENTORY_CHANGED" ) then
--		DEFAULT_CHAT_FRAME:AddMessage(event.." spell update")
		KHunterTimers_UpdateSpells();
		KHunterTimers_UpdateTalents();
		return;
	end
	if( event == "CHARACTER_POINTS_CHANGED" ) then
--		DEFAULT_CHAT_FRAME:AddMessage(event.." talent update")
		KHunterTimers_UpdateTalents();
		return;
	end
	if( not KHTvars[KHT_ON] ) then
		return;
	end

	if( event == "START_AUTOREPEAT_SPELL" ) then
		khtAutoShot = true;
	elseif( event == "STOP_AUTOREPEAT_SPELL" ) then
		khtAutoShot = false;
	elseif( event == "PLAYER_REGEN_ENABLED" ) then
		khtAutoShot = false;
	end

	if ( event == "COMBAT_LOG_EVENT_UNFILTERED" ) then
		local _, combatEvent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, _, spellId, spellName = ...;

		local toPlayer, fromPlayer, toPet, fromPet, toTarget;
		if (sourceName and not CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_NONE) ) then
			fromPlayer = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE);
			fromPet = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_PET);
		end
		if (destName and not CombatLog_Object_IsA(destFlags, COMBATLOG_OBJECT_NONE) ) then
			toPlayer = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_MINE);
			toPet = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_MY_PET);
			toTarget = CombatLog_Object_IsA(destFlags, COMBATLOG_OBJECT_TARGET);
		end
	
		if ( khtDebugBC ) then
			if ( fromPlayer or fromPet or toPlayer or toPet or toTarget ) then
				if ( sourceName and destName and spellName ) then
					DEFAULT_CHAT_FRAME:AddMessage(combatEvent.." From: "..sourceName.." To: "..destName.." "..destGUID.." "..spellName.." "..spellId, 1, 0, 0 );
				elseif ( destName and spellName ) then
					DEFAULT_CHAT_FRAME:AddMessage(combatEvent.." To: "..destName.." "..spellName.." "..spellId, 1, 0, 0 );
				elseif ( sourceName and spellName ) then
					DEFAULT_CHAT_FRAME:AddMessage(combatEvent.." From: "..sourceName.." "..spellName.." "..spellId, 1, 0, 0 );
				end
			end

		end

		if( combatEvent == "PARTY_KILL" or combatEvent == "UNIT_DIED" or combatEvent == "UNIT_DESTROYED" ) then
			if( KHTvars["numBars"] > 0 ) then
				for num = 1, KHTvars["numBars"], 1 do
					local barframe = _G["KHunterTimersStatus"..num];
					if( barframe.GUID ~= nil ) then
						if ( barframe.GUID == destGUID ) then
							barframe.endTime = 0;
						end
					end
				end
			end
		elseif( combatEvent == "SPELL_CAST_SUCCESS" and fromPlayer ) then
			if( KHTvars["skills"][KHT_BEAST] ) then
				if( KHTvars["skills"][KHT_INTIM] and spellName == KHT_INTIM and spellId == 19577 ) then
					khtPetIntim = true;
					KHunterTimersFrame_add( 15000, KHT_PET_INTIM );
				elseif( KHTvars["skills"][KHT_BW] and spellName == KHT_BW ) then
					KHunterTimersFrame_add( 10000, spellName, spellId );
				elseif( KHTvars["skills"][KHT_FEED_PET] and spellName == KHT_FEED_PET ) then
					KHunterTimersFrame_add( 10000, spellName, spellId );
				elseif( KHTvars["skills"][KHT_MEND_PET] and spellName == KHT_MEND_PET ) then
					KHunterTimersFrame_add( 10000, spellName, spellId );
				end
			end
			if( KHTvars["skills"][KHT_MARKS] ) then
				if( KHTvars["skills"][KHT_CONC_SHOT] and spellName == KHT_CONC_SHOT ) then
					KHunterTimersFrame_add( 6000 + KHTvars["impconc"], spellName, spellId, destName, destGUID );
				elseif( KHTvars["skills"][KHT_SILENCE_SHOT] and spellName == KHT_SILENCE_SHOT ) then
					KHunterTimersFrame_add( 3000, spellName, spellId, destName, destGUID );
				elseif( KHTvars["skills"][KHT_HUNTERS_MARK] and spellName == KHT_HUNTERS_MARK ) then
					KHunterTimersFrame_add( 300000, spellName, spellId, destName, destGUID );
				elseif ( KHTvars["skills"][KHT_SERPENT] and spellName == KHT_SERPENT and spellId == 1978 ) then
					KHunterTimersFrame_add( 15000, spellName, spellId, destName, destGUID );
				elseif( KHTvars["skills"][KHT_FLARE] and spellName == KHT_FLARE ) then
					KHunterTimersFrame_add( 20000, spellName, spellId );
				end
			end
			if( KHTvars["skills"][KHT_SURV] ) then
				if( KHTvars["skills"][KHT_MISDIRECTION] and spellName == KHT_MISDIRECTION and spellId == 34477 ) then
					KHunterTimersFrame_add( 20000, spellName, spellId, destName, destGUID );
				elseif( KHTvars["skills"][KHT_SCATTER] and spellName == KHT_SCATTER ) then
					KHunterTimersFrame_add( 4000, spellName, spellId, destName, destGUID );
				elseif( KHTvars["skills"][KHT_COUNTER] and spellName == KHT_COUNTER ) then
					KHunterTimersFrame_add( 5000, spellName, spellId );
				elseif( KHTvars["skills"][KHT_DETERRENCE] and spellName == KHT_DETERRENCE ) then
					KHunterTimersFrame_add( 5000, spellName, spellId );
				end
			end
			if( KHTvars["skills"][KHT_MISC] ) then
				if( KHTvars["skills"][KHT_WAR_STOMP] and spellName == KHT_WAR_STOMP ) then
					KHunterTimersFrame_add( 2000, spellName, spellId );
				elseif( KHTvars["skills"][KHT_ARCANE] and spellName == KHT_ARCANE ) then
					KHunterTimersFrame_add( 2000, spellName, spellId );
				end
			end
			if( spellName == KHT_MULTI ) then
				khtMulti = true;
			end
		elseif( combatEvent == "SPELL_MISSED" and ( fromPlayer or fromPet ) ) then
			if( frostTrapTimer and string.find( spellName, KHT_FREEZING_TRAP ) ) then
				for i=1, KHTvars["numBars"] do
					local barframe = _G["KHunterTimersStatus"..i];
					if( string.find( barframe.spell, KHT_FREEZING_TRAP.." "..KHT_PRIMED ) ) then
						barframe.endTime = 0;
					end
				end
			elseif( fireTrapTimer and string.find( spellName, KHT_IMMO_TRAP ) ) then
				for i=1, KHTvars["numBars"] do
					local barframe = _G["KHunterTimersStatus"..i];
					if( string.find( barframe.spell, KHT_IMMO_TRAP.." "..KHT_PRIMED ) ) then
						barframe.endTime = 0;
					end
				end
			else
				for i=1, KHTvars["numBars"] do
					local barframe = _G["KHunterTimersStatus"..i];
					if( string.find( barframe.spell, spellName ) ) and ( barframe.GUID == destGUID or barframe.GUID == nil ) then
						barframe.endTime = 0;
					end
				end
			end
		elseif( combatEvent == "SPELL_AURA_APPLIED" ) then
			if( toPlayer or toPet ) then
				if( KHTvars["skills"][KHT_BEAST] ) then
					if( KHTvars["skills"][KHT_PET_FRENZY] and spellName == KHT_PET_FRENZY ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_COBRA_STRIKES] and spellName == KHT_COBRA_STRIKES ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_KILLING_STREAK] and spellName == KHT_KILLING_STREAK ) then
						KHunterTimersFrame_add( 8000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_FOCUS_FIRE] and spellName == KHT_FOCUS_FIRE ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					end
				end
				if( KHTvars["skills"][KHT_MARKS] ) then
					if( KHTvars["skills"][KHT_RAPID_KILLING] and spellName == KHT_RAPID_KILLING ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_MASTER_MARKS] and spellName == KHT_READY_SET ) then
						KHunterTimersFrame_add( 30000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_MASTER_MARKS] and spellName == KHT_FIRE ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					end
				end
				if( KHTvars["skills"][KHT_SURV] ) then
					if( KHTvars["skills"][KHT_MISDIRECTION] and spellName == KHT_MISDIRECTION and spellId == 35079 ) then
						KHunterTimersFrame_add( 4000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_CAMO] and spellName == KHT_CAMO ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					end
				end
				if( KHTvars["skills"][KHT_PETS] ) then
					if( KHTvars["skills"][KHT_CALL] and spellName == KHT_CALL ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_STAND] and spellName == KHT_STAND ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_RABID] and spellName == KHT_RABID ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_SERENITY] and spellName == KHT_SERENITY ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_BITE] and spellName == KHT_BITE_PROC ) then
						KHunterTimersFrame_add( 12000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DASH] and spellName == KHT_DASH ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_CARRION] and spellName == KHT_CARRION ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_FURIOUS] and spellName == KHT_FURIOUS ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_WARP] and spellName == KHT_WARP and spellId == 35346 ) then
						KHunterTimersFrame_add( 6000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_SHIELD] and spellName == KHT_SHIELD ) then
						KHunterTimersFrame_add( 12000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_CULLING] and spellName == KHT_CULLING ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_COWER] and spellName == KHT_COWER ) then
						KHunterTimersFrame_add( 6000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_ANKLE] and spellName == KHT_ANKLE ) then
						KHunterTimersFrame_add( 6000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_RECOVERY] and spellName == KHT_RECOVERY ) then
						KHunterTimersFrame_add( 9000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_COURAGE] and spellName == KHT_COURAGE ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					end
				end
				if( KHTvars["skills"][KHT_MISC] ) then
					if( KHTvars["skills"][KHT_BERSERKING] and spellName == KHT_BERSERKING ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_BLOOD_FURY] and spellName == KHT_BLOOD_FURY ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_STONEFORM] and spellName == KHT_STONEFORM ) then
						KHunterTimersFrame_add( 8000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_ZG] and spellName == KHT_PRIMAL ) then
						KHunterTimersFrame_add( 12000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DON_SANTOS] and spellName == KHT_SANTOS ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DESOLATION_4PC] and spellName == KHT_HEROIC ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_THUNDER] and spellName == KHT_SKYFIRE ) then
						KHunterTimersFrame_add( 6000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_BEAST_4PC] and spellName == KHT_BEASTLORD ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_CHAMPION] and spellName == KHT_CHAMPION ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_SCOURGE] and spellName == KHT_PRECISION ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_HEROISM] and spellName == KHT_HEROISM and spellId == 32182 ) then
						KHunterTimersFrame_add( 40000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_BLOODLUST] and spellName == KHT_BLOODLUST ) then
						KHunterTimersFrame_add( 40000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_ASHEN] and spellName == KHT_ASHEN_VERDICT ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_BLOOD_HUNTER] and spellName == KHT_BLOOD_HUNT_2PC ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_BLOOD_HUNTER] and spellName == KHT_BLOOD_HUNT_4PC ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_WINDRUNNER] and spellName == KHT_WINDRUNNER_4PC and spellId == 68130 ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_HYPER] and spellName == KHT_HYP_SPEED ) then
						KHunterTimersFrame_add( 12000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_FLAMEWAKER] and spellName == KHT_FLAMEWAKER_4PC and spellId == 99060 ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_TIME_WARP] and spellName == KHT_TIME_WARP and spellId == 80353 ) then
						KHunterTimersFrame_add( 40000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_WYRMSTALKER] and spellName == KHT_WYRMSTALKER_4PC ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					end
				end
				if( KHTvars["skills"][KHT_TRINKETS] ) then
					if( KHTvars["skills"][KHT_DEVIL_EYE] and spellName == KHT_DEVILSAUR ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_HERO_MEDALLION] and spellName == KHT_ZHM ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_EARTHSTRIKE] and spellName == KHT_EARTHSTRIKE ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_SWARMGUARD] and spellName == KHT_SWARMGUARD ) then
						KHunterTimersFrame_add( 30000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_JOM_GABBAR] and spellName == KHT_JOM_GABBAR ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_KISS_SPIDER] and spellName == KHT_KISS_SPIDER ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( ( KHTvars["skills"][KHT_ADWT] or KHTvars["skills"][KHT_BLADEFIST] ) and spellName == KHT_FEROCITY ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( ( KHTvars["skills"][KHT_OGRE] or KHTvars["skills"][KHT_UNITING] ) and spellName == KHT_BURNING_HATRED ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_ARKELOS] and spellName == KHT_ANCIENT_POWER ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_NIGHTSEYE] and spellName == KHT_NIGHTSEYE ) then
						KHunterTimersFrame_add( 12000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_HOURGLASS] and spellName == KHT_UNRAVELLER ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_BLOODLUST_BROOCH] and spellName == KHT_LUST ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_ABACUS] and spellName == KHT_ABACUS ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DST] and spellName == KHT_DRAGON ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_TTP] and spellName == KHT_HEROISM and spellId == 39200 ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_TSUNAMI_TALISMAN] and spellName == KHT_TSUNAMI ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_ATOS] and spellName == KHT_ASHTONGUE ) then
						KHunterTimersFrame_add( 8000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_WRATH] and spellName == KHT_WRATH ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_DELUSIONAL ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_KLEPTOMANIA ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_MANIC ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_MARTYR ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_NARCISSISM ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_PARANOIA ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_TALON_ALAR] and spellName == KHT_TALON ) then
						KHunterTimersFrame_add( 6000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_SKY_CROSS] and spellName == KHT_SKYGUARD ) then
						KHunterTimersFrame_add( 30000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_MOTB] and spellName == KHT_MADNESS ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_BERSERK_CALL] and spellName == KHT_BERSERKER ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_EMPTY_MUG] and spellName == KHT_DIREBREW ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_INCISOR] and spellName == KHT_INCISOR ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( ( KHTvars["skills"][KHT_ANVIL] or KHTvars["skills"][KHT_MIRROR] ) and spellName == KHT_TORMENT ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_GREAT] and spellName == KHT_GREATNESS and spellId == 60233 ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_LOATHEB] and spellName == KHT_LOATHEB ) then
						KHunterTimersFrame_add( 20000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_SIGNET_EDWARD] and spellName == KHT_EDWARD ) then
						KHunterTimersFrame_add( 13000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_METEORITE] and spellName == KHT_METEORITE ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_PYRITE_INFUSER] and spellName == KHT_PYRITE ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_VERDICT] and spellName == KHT_PARAGON and spellId == 67703 ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_VERDICT] and spellName == KHT_PARAGON and spellId == 67772 ) then
						KHunterTimersFrame_add( 15000, spellName.." (H)", spellId );
					elseif( KHTvars["skills"][KHT_MJOLNIR] and spellName == KHT_MJOLNIR ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_GRIM_TOLL] and spellName == KHT_GRIM_TOLL ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_NEEDLE] and spellName == KHT_NES ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DEATHBRINGER] and spellName == KHT_DEATH_AGI and spellId == 71485 ) then
						KHunterTimersFrame_add( 30000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DEATHBRINGER] and spellName == KHT_DEATH_AGI and spellId == 71556 ) then
						KHunterTimersFrame_add( 30000, spellName.." (H)", spellId );
					elseif( KHTvars["skills"][KHT_DEATHBRINGER] and spellName == KHT_DEATH_AP and spellId == 71486 ) then
						KHunterTimersFrame_add( 30000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DEATHBRINGER] and spellName == KHT_DEATH_AP and spellId == 71558 ) then
						KHunterTimersFrame_add( 30000, spellName.." (H)", spellId );
					elseif( KHTvars["skills"][KHT_DEATHBRINGER] and spellName == KHT_DEATH_CRIT and spellId == 71491 ) then
						KHunterTimersFrame_add( 30000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DEATHBRINGER] and spellName == KHT_DEATH_CRIT and spellId == 71559 ) then
						KHunterTimersFrame_add( 30000, spellName.." (H)", spellId );
					elseif( KHTvars["skills"][KHT_FANGED_SKULL] and spellName == KHT_FANGED and spellId == 71401 ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_FANGED_SKULL] and spellName == KHT_FANGED and spellId == 71541 ) then
						KHunterTimersFrame_add( 15000, spellName.." (H)", spellId );
					elseif( KHTvars["skills"][KHT_SHARP_SCALE] and spellName == KHT_STS and spellId == 75458 ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_SHARP_SCALE] and spellName == KHT_STS and spellId == 75456 ) then
						KHunterTimersFrame_add( 15000, spellName.." (H)", spellId );
					elseif( KHTvars["skills"][KHT_HUNGERER] and spellName == KHT_HUNGER and spellId == 96911 ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_HUNGERER] and spellName == KHT_HUNGER and spellId == 97125 ) then
						KHunterTimersFrame_add( 15000, spellName.." (H)", spellId );
					end
				end
			end
			if( fromPlayer or fromPet ) then
				if( KHTvars["skills"][KHT_BEAST] ) then
					if( KHTvars["skills"][KHT_SCARE_BEAST] and spellName == KHT_SCARE_BEAST ) then
						KHunterTimersFrame_add( 20000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_INTIM] and spellName == KHT_INTIM and spellId == 24394 ) then
						KHunterTimersFrame_add( 3000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_WIDOW_VENOM] and spellName == KHT_WIDOW_VENOM ) then
						KHunterTimersFrame_add( 30000, spellName, spellId, destName, destGUID );
					end
				end
				if( KHTvars["skills"][KHT_MARKS] ) then
					if( KHTvars["skills"][KHT_HUNTERS_MARK] and spellName == KHT_HUNTERS_MARK ) then
						KHunterTimersFrame_add( 300000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_SERPENT] and spellName == KHT_SERPENT and spellId == 1978 ) then
						KHunterTimersFrame_add( 15000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_SERPENT] and spellName == KHT_SERPENT and spellId == 88453 ) then
						KHunterTimersFrame_add( 6000, spellName.." (AoE)", spellId );
					elseif( KHTvars["skills"][KHT_SERPENT] and spellName == KHT_SERPENT and spellId == 88466 ) then
						KHunterTimersFrame_add( 9000, spellName.." (AoE)", spellId );
					elseif( KHTvars["skills"][KHT_CONC_BARRAGE] and spellName == KHT_CONC_BARRAGE ) then
						KHunterTimersFrame_add( 4000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_PIERCING] and spellName == KHT_PIERCING ) then
						KHunterTimersFrame_add( 8000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_MARKED] and spellName == KHT_MARKED ) then
						KHunterTimersFrame_add( 15000, spellName, spellId, destName, destGUID );
					end
				end
				if( KHTvars["skills"][KHT_SURV] ) then
					if( KHTvars["skills"][KHT_WYVERN] and spellName == KHT_WYVERN and spellId == 24131 ) then
						KHunterTimersFrame_add( 6000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_WYVERN] and spellName == KHT_WYVERN and spellId == 19386 ) then
						KHunterTimersFrame_add( 30000, KHT_WYVERN_TEXT, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_ENTRAPMENT] and spellName == KHT_ENTRAPMENT ) then
						KHunterTimersFrame_add( KHTvars["entrapmentmult"], spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_WING_CLIP] and spellName == KHT_WING_CLIP ) then
						KHunterTimersFrame_add( 10000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_BLACK_ARROW] and spellName == KHT_BLACK_ARROW ) then
						KHunterTimersFrame_add( 20000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_EXPL_SHOT] and spellName == KHT_EXPL_SHOT ) then
						KHunterTimersFrame_add( 2000, spellName, spellId, destName, destGUID );
			          elseif( string.find( spellName, KHT_FROST_TRAP ) or string.find( spellName, KHT_FREEZING_TRAP ) ) then
				          if( frostTrapTimer ) then
                                   for num = 1, KHTvars["numBars"] do
					               local barframe = _G[ "KHunterTimersStatus"..num];
					               if( barframe.spell == KHT_FROST_TRAP.." "..KHT_PRIMED or 
                                            barframe.spell == KHT_FREEZING_TRAP.." "..KHT_PRIMED ) then
						          	barframe.endTime = 0;
					               end
				               end
					     	if( KHTvars["skills"][KHT_FREEZING_TRAP] and string.find( spellName, KHT_FREEZING_TRAP ) ) then
						     	local duration = 60000*KHTvars["traptimemult"];
						     	KHunterTimersFrame_add( duration, KHT_FREEZING_TRAP, spellId, destName, destGUID );
					     	elseif( KHTvars["skills"][KHT_FROST_TRAP] and string.find( spellName, KHT_FROST_TRAP ) ) then
						     	KHunterTimersFrame_add( 30000*KHTvars["traptimemult"], KHT_FROST_TRAP.." "..KHT_AURA, spellId );
                              	end
                              end
			          elseif( string.find( spellName, KHT_EXPL_TRAP ) or string.find( spellName, KHT_IMMO_TRAP ) ) then
				          if( fireTrapTimer ) then
                                   for num = 1, KHTvars["numBars"] do
					               local barframe = _G[ "KHunterTimersStatus"..num];
					               if( barframe.spell == KHT_EXPL_TRAP.." "..KHT_PRIMED or 
                                            barframe.spell == KHT_IMMO_TRAP.." "..KHT_PRIMED ) then
						               barframe.endTime = 0;
					               end
				               end
					     	if( KHTvars["skills"][KHT_IMMO_TRAP] and string.find( spellName, KHT_IMMO_TRAP ) ) then
						     	KHunterTimersFrame_add( 15000, KHT_IMMO_TRAP, spellId, destName, destGUID );
					     	elseif( KHTvars["skills"][KHT_EXPL_TRAP] and string.find( spellName, KHT_EXPL_TRAP ) ) then
						     	KHunterTimersFrame_add( 20000, KHT_EXPL_TRAP.." "..KHT_AURA, spellId );
					     	end
                              end
					end
                    end
				if( KHTvars["skills"][KHT_PETS] ) then
					if( KHTvars["skills"][KHT_ROAR] and spellName == KHT_ROAR ) then
						KHunterTimersFrame_add( 12000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_TENDON] and spellName == KHT_TENDON ) then
						KHunterTimersFrame_add( 6000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_SPIRIT_MEND] and spellName == KHT_SPIRIT_MEND ) then
						KHunterTimersFrame_add( 10000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_WEB] and spellName == KHT_WEB ) then
						KHunterTimersFrame_add( 5000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_VENOM_WEB] and spellName == KHT_VENOM_WEB ) then
						KHunterTimersFrame_add( 5000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_WEB_WRAP] and spellName == KHT_WEB_WRAP ) then
						KHunterTimersFrame_add( 3000, spellName, spellId, destName, destGUID );
					end
				end
				if( KHTvars["skills"][KHT_MISC] ) then
					if( KHTvars["skills"][KHT_DRAGON_8PC] and spellName == KHT_EXPOSE_DS and spellId == 23577 ) then
						KHunterTimersFrame_add( 7000, spellName, spellId, destName, destGUID );
					end
				end
			end
		elseif( combatEvent == "SPELL_AURA_APPLIED_DOSE" ) then
			if( toPlayer or toPet ) then
				if( KHTvars["skills"][KHT_MARKS] ) then
					if( KHTvars["skills"][KHT_MASTER_MARKS] and spellName == KHT_READY_SET ) then
						KHunterTimersFrame_add( 30000, spellName, spellId );
					end
				end
				if( KHTvars["skills"][KHT_PETS] ) then
					if( KHTvars["skills"][KHT_BITE] and spellName == KHT_BITE_PROC ) then
							KHunterTimersFrame_add( 12000, spellName, spellId );
					end
				end
			end
		elseif( combatEvent == "SPELL_AURA_REFRESH" ) then
			if ( toPlayer or toPet ) then
				if( KHTvars["skills"][KHT_BEAST] ) then
					if( KHTvars["skills"][KHT_COBRA_STRIKES] and spellName == KHT_COBRA_STRIKES ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					end
				end
				if( KHTvars["skills"][KHT_PETS] ) then
					if( KHTvars["skills"][KHT_CULLING] and spellName == KHT_CULLING ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_COURAGE] and spellName == KHT_COURAGE ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					end
				end
				if( KHTvars["skills"][KHT_MISC] ) then
					if( KHTvars["skills"][KHT_ZG] and spellName == KHT_PRIMAL ) then
						KHunterTimersFrame_add( 12000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DON_SANTOS] and spellName == KHT_SANTOS ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DESOLATION_4PC] and spellName == KHT_HEROIC ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_THUNDER] and spellName == KHT_SKYFIRE ) then
						KHunterTimersFrame_add( 6000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_CHAMPION] and spellName == KHT_CHAMPION ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_BLOOD_HUNTER] and spellName == KHT_BLOOD_HUNT_2PC ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_BLOOD_HUNTER] and spellName == KHT_BLOOD_HUNT_4PC ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_FLAMEWAKER] and spellName == KHT_FLAMEWAKER_4PC and spellId == 99060 ) then
						KHunterTimersFrame_add( 15000, spellName, spellId );
					end
				end
				if( KHTvars["skills"][KHT_TRINKETS] ) then
					if( KHTvars["skills"][KHT_HOURGLASS] and spellName == KHT_UNRAVELLER ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DST] and spellName == KHT_DRAGON ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_TSUNAMI_TALISMAN] and spellName == KHT_TSUNAMI ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_ATOS] and spellName == KHT_ASHTONGUE ) then
						KHunterTimersFrame_add( 8000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_WRATH] and spellName == KHT_WRATH ) then
						KHunterTimersFrame_add( 10000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_DELUSIONAL ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_KLEPTOMANIA ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_MANIC ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_MARTYR ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_NARCISSISM ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_DARK_MAD] and spellName == KHT_PARANOIA ) then
						KHunterTimersFrame_add( 60000, spellName, spellId );
					elseif( KHTvars["skills"][KHT_SKY_CROSS] and spellName == KHT_SKYGUARD ) then
						KHunterTimersFrame_add( 30000, spellName, spellId );
					end
				end
			end
			if( fromPlayer or fromPet ) then
				if( KHTvars["skills"][KHT_MARKS] ) then
					if( KHTvars["skills"][KHT_SERPENT] and spellName == KHT_SERPENT and spellId == 88453 and khtMulti ) then
						KHunterTimersFrame_add( 6000, spellName.." (AoE)", spellId );
						khtMulti = false;
					elseif( KHTvars["skills"][KHT_SERPENT] and spellName == KHT_SERPENT and spellId == 88466 and khtMulti ) then
						KHunterTimersFrame_add( 9000, spellName.." (AoE)", spellId );
						khtMulti = false;
					elseif( KHTvars["skills"][KHT_CONC_BARRAGE] and spellName == KHT_CONC_BARRAGE ) then
						KHunterTimersFrame_add( 4000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_PIERCING] and spellName == KHT_PIERCING ) then
						KHunterTimersFrame_add( 8000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_WIDOW_VENOM] and spellName == KHT_WIDOW_VENOM ) then
						KHunterTimersFrame_add( 30000, spellName, spellId, destName, destGUID );
					elseif( KHTvars["skills"][KHT_MARKED] and spellName == KHT_MARKED ) then
						KHunterTimersFrame_add( 15000, spellName, spellId, destName, destGUID );
					end
				end
				if( KHTvars["skills"][KHT_SURV] ) then
					if( KHTvars["skills"][KHT_WING_CLIP] and spellName == KHT_WING_CLIP ) then
						KHunterTimersFrame_add( 10000, spellName, spellId, destName, destGUID );
			          elseif( string.find( spellName, KHT_FROST_TRAP ) or string.find( spellName, KHT_FREEZING_TRAP ) ) then
				          if( frostTrapTimer ) then
                                   for num = 1, KHTvars["numBars"] do
					               local barframe = _G[ "KHunterTimersStatus"..num];
					               if( barframe.spell == KHT_FROST_TRAP.." "..KHT_PRIMED or 
                                            barframe.spell == KHT_FREEZING_TRAP.." "..KHT_PRIMED ) then
						          	barframe.endTime = 0;
					               end
				               end
					     	if( KHTvars["skills"][KHT_FREEZING_TRAP] and string.find( spellName, KHT_FREEZING_TRAP ) ) then
						     	local duration = 60000*KHTvars["traptimemult"];
						     	KHunterTimersFrame_add( duration, KHT_FREEZING_TRAP, spellId, destName, destGUID );
					     	elseif( KHTvars["skills"][KHT_FROST_TRAP] and string.find( spellName, KHT_FROST_TRAP ) ) then
						     	KHunterTimersFrame_add( 30000*KHTvars["traptimemult"], KHT_FROST_TRAP.." "..KHT_AURA, spellId );
                              	end
                              end
			          elseif( string.find( spellName, KHT_EXPL_TRAP ) or string.find( spellName, KHT_IMMO_TRAP ) ) then
				          if( fireTrapTimer ) then
                                   for num = 1, KHTvars["numBars"] do
					               local barframe = _G[ "KHunterTimersStatus"..num];
					               if( barframe.spell == KHT_EXPL_TRAP.." "..KHT_PRIMED or 
                                            barframe.spell == KHT_IMMO_TRAP.." "..KHT_PRIMED ) then
						               barframe.endTime = 0;
					               end
				               end
					     	if( KHTvars["skills"][KHT_IMMO_TRAP] and string.find( spellName, KHT_IMMO_TRAP ) ) then
						     	KHunterTimersFrame_add( 15000, KHT_IMMO_TRAP, spellId, destName, destGUID );
					     	elseif( KHTvars["skills"][KHT_EXPL_TRAP] and string.find( spellName, KHT_EXPL_TRAP ) ) then
						     	KHunterTimersFrame_add( 20000, KHT_EXPL_TRAP.." "..KHT_AURA, spellId );
					     	end
                              end
					end
				end
				if( KHTvars["skills"][KHT_MISC] ) then
					if( KHTvars["skills"][KHT_DRAGON_8PC] and spellName == KHT_EXPOSE_DS and spellId == 23577 ) then
						KHunterTimersFrame_add( 7000, spellName, spellId, destName, destGUID );
					end
				end
			end
		elseif( combatEvent == "SWING_DAMAGE" and fromPet ) then
			if( sourceName == KHT_VENOMOUS and natureTrapTimer ) then
				for num = 1, KHTvars["numBars"] do
					local barframe = _G[ "KHunterTimersStatus"..num];
					if( barframe.spell == KHT_SNAKE_TRAP.." "..KHT_PRIMED ) then
						barframe.endTime = 0;
					end
				end
				if( KHTvars["skills"][KHT_SURV] and KHTvars["skills"][KHT_SNAKE_TRAP] ) then
					KHunterTimersFrame_add( 15000, KHT_SNAKE_TRAP.." "..KHT_AURA );
				end
			end
		elseif( combatEvent == "SPELL_AURA_REMOVED" and ( toPlayer or toPet ) ) then
			for i=1, KHTvars["numBars"] do
				local barframe = _G[ "KHunterTimersStatus"..i];
				if( string.find( barframe.spell, spellName ) and barframe.spellId == spellId ) then
					barframe.endTime = 0;
				end
			end
		elseif( combatEvent == "SPELL_AURA_REMOVED" and ( fromPlayer or fromPet ) ) then
			if( string.find( spellName, KHT_FREEZING_TRAP ) ) then
				spellName = KHT_FREEZING_TRAP;
			end
			for i=1, KHTvars["numBars"] do
				local barframe = _G[ "KHunterTimersStatus"..i];
				if( string.find( barframe.spell, spellName ) and barframe.spellId == spellId and barframe.GUID == destGUID )  then
					barframe.endTime = 0;
				end
			end
		end
	elseif( event == "UNIT_AURA" and firstArg == "player" ) then
		if( KHTvars["skills"][KHT_MARKS] ) then
			if( KHTvars["skills"][KHT_RAPID_FIRE] ) then
				local spellName, _, _, _, _, duration, timeLeft, _, _, _, spellId = UnitBuff("player", KHT_RAPID_FIRE, nil );
				if( spellName and timeLeft ~= khtRapidFire ) then
					KHunterTimersFrame_add( duration*1000, spellName, spellId );
					khtRapidFire = timeLeft;
				end
			end
			if( KHTvars["skills"][KHT_STEADY] ) then
				local spellName, _, _, _, _, duration, timeLeft, _, _, _, spellId = UnitBuff("player", KHT_STEADY, nil );
				if( spellName and timeLeft ~= khtImpSteady ) then
					KHunterTimersFrame_add( duration*1000, spellName, spellId );
					khtImpSteady = timeLeft;
				end
			end
			if( KHTvars["skills"][KHT_SNIPER] ) then
				local spellName, _, _, _, _, duration, timeLeft, _, _, _, spellId = UnitBuff("player", KHT_SNIPER, nil );
				if( spellName and timeLeft ~= khtSniper ) then
					KHunterTimersFrame_add( duration*1000, spellName, spellId );
					khtSniper = timeLeft;
				end
			end
		end
		if( KHTvars["skills"][KHT_SURV] ) then
			if( KHTvars["skills"][KHT_LOCK_LOAD] ) then
				local spellName, _, _, _, _, duration, timeLeft, _, _, _, spellId = UnitBuff("player", KHT_LOCK_LOAD, nil );
				if( spellName and not khtLockLoad ) then
					KHunterTimersFrame_add( duration*1000, spellName, spellId );
					khtLockLoad = true;
				end
			end
		end
	elseif( event == "UNIT_AURA" and firstArg == "pet" ) then
		if( KHTvars["skills"][KHT_BEAST] ) then
			if( KHTvars["skills"][KHT_PET_FRENZY] ) then
				local spellName, _, _, _, _, duration, timeLeft, _, _, _, spellId = UnitBuff("pet", KHT_PET_FRENZY, nil );
				if( spellName and timeLeft ~= khtFrenzy ) then
					KHunterTimersFrame_add( duration*1000, spellName, spellId );
					khtFrenzy = timeLeft;
				end
			end
		end
	elseif( event == "UNIT_AURA" and firstArg == "target" ) then
		if( KHTvars["skills"][KHT_MARKS] ) then
			if( KHTvars["skills"][KHT_SERPENT] ) then
				local spellName, _, _, _, _, duration, timeLeft, unitCaster, _, _, spellId = UnitDebuff("target", KHT_SERPENT, nil );
				if( spellName and unitCaster == "player" and timeLeft ~= khtSerpent ) then
					KHunterTimersFrame_add( duration*1000, spellName, spellId, UnitName("target"), UnitGUID("target") );
					khtSerpent = timeLeft;
				end
			end
		end
	elseif( event == "UNIT_SPELLCAST_SUCCEEDED" and firstArg == "player" ) then
		if( secondArg == KHT_FROST_TRAP or secondArg == KHT_FREEZING_TRAP ) then
			if( KHTvars["skills"][KHT_SURV] and KHTvars["skills"][secondArg] ) then
				frostTrapTimer = true;
				KHunterTimersFrame_add( 60000, secondArg.." "..KHT_PRIMED );
			end
		elseif( secondArg == KHT_EXPL_TRAP or secondArg == KHT_IMMO_TRAP ) then
			if( KHTvars["skills"][KHT_SURV] and KHTvars["skills"][secondArg] ) then
				fireTrapTimer = true;
				KHunterTimersFrame_add( 60000, secondArg.." "..KHT_PRIMED );
			end
		elseif( secondArg == KHT_SNAKE_TRAP ) then
			if( KHTvars["skills"][KHT_SURV] and KHTvars["skills"][secondArg] ) then
				natureTrapTimer = true;
				KHunterTimersFrame_add( 60000, secondArg.." "..KHT_PRIMED );
			end
		elseif( KHTvars["skills"][KHT_MARKS] and KHTvars["skills"][KHT_AUTO_SHOT] and secondArg == KHT_AUTO_SHOT ) then
			khtAutoShot = true;
			khtTimeLeft = UnitRangedDamage("player");
			KHunterTimersFrame_add( khtTimeLeft*1000, KHT_AUTO_SHOT );
		end
	end

end

function KHunterTimers_cascadeBar( id )
	local barframefrom = _G["KHunterTimersStatus"..(id+1)];
	if( not barframefrom ) or not ( barframefrom:IsVisible() and (barframefrom.channeling or barframefrom.fadeOut) )then
		_G["KHunterTimersStatus"..id]:Hide();
		KHunterTimers_SetWidths();
		KHT_SetHeight();
		return;
	end
	
	local barframeto = _G["KHunterTimersStatus"..id];
	local barto = _G["KHunterTimersStatus"..id.."Bar"];
	local textLeftto = _G["KHunterTimersStatus"..id.."BarLeftText"];
	local textRightto = _G["KHunterTimersStatus"..id.."BarRightText"];
	local iconto = _G["KHunterTimersStatus"..id.."Icon"];
	
	id = id + 1;
	
	local barfrom = _G["KHunterTimersStatus"..id.."Bar"];
	local textLeftfrom = _G["KHunterTimersStatus"..id.."BarLeftText"];
	local textRightfrom = _G["KHunterTimersStatus"..id.."BarRightText"];
	
	barframeto.texture = barframefrom.texture;
	iconto:SetTexture(barframeto.texture);
	
	barframeto.startTime = barframefrom.startTime;
	barframeto.endTime = barframefrom.endTime;
	barframeto.duration = barframefrom.duration;
	barframeto.channeling = barframefrom.channeling;
	barframeto.fadeOut = barframefrom.fadeOut;
	barframeto.target = barframefrom.target;
	barframeto.GUID = barframefrom.GUID;
	barframeto.spell = barframefrom.spell;
	barframeto.spellId = barframefrom.spellId;
	barto:SetMinMaxValues(barframeto.startTime, barframeto.endTime);
	barto:SetValue(barfrom:GetValue());
	textLeftto:SetText(textLeftfrom:GetText());
	textRightto:SetText(textRightfrom:GetText());
	barframeto:SetAlpha(barframefrom:GetAlpha());
	barframeto:Show();
	KHunterTimers_cascadeBar( id );
end

function KHunterTimers_shift( id, curr )

	if( id > KHTvars["numBars"] ) or ( KHTvars["numBars"] == 11 ) then
		return;
	end
	
	if( not curr ) then
		curr = KHTvars["numBars"] + 1;
	end
	
	if( curr == id ) then
		--DEFAULT_CHAT_FRAME:AddMessage("shiftend");
		return;
	end
	
	KHunterTimers_CopyBar( curr, curr-1 );
	KHunterTimers_shift( id, curr-1 );
	
end

function KHunterTimers_CopyBar(to, from)
	local barframeto = _G["KHunterTimersStatus"..to];
	local barto = _G["KHunterTimersStatus"..to.."Bar"];
	local textLeftto = _G["KHunterTimersStatus"..to.."BarLeftText"];
	local textRightto = _G["KHunterTimersStatus"..to.."BarRightText"];
	local iconto = _G["KHunterTimersStatus"..to.."Icon"];
	
	local barframefrom = _G["KHunterTimersStatus"..from];
	local barfrom = _G["KHunterTimersStatus"..from.."Bar"];
	local textLeftfrom = _G["KHunterTimersStatus"..from.."BarLeftText"];
	local textRightfrom = _G["KHunterTimersStatus"..from.."BarRightText"];
	
	barframeto.texture = barframefrom.texture;
	iconto:SetTexture(barframeto.texture);
	
	barframeto.startTime = barframefrom.startTime;
	barframeto.endTime = barframefrom.endTime;
	barframeto.duration = barframefrom.duration;
	barframeto.channeling = barframefrom.channeling;
	barframeto.fadeOut = barframefrom.fadeOut;
	barframeto.target = barframefrom.target;
	barframeto.GUID = barframefrom.GUID;
	barframeto.spell = barframefrom.spell;
	barframeto.spellId = barframefrom.spellId;
	barto:SetMinMaxValues(barframeto.startTime, barframeto.endTime);
	barto:SetValue(barfrom:GetValue());
	textLeftto:SetText(textLeftfrom:GetText());
	textRightto:SetText(textRightfrom:GetText());
	barframeto:SetAlpha(barframefrom:GetAlpha());
	barframeto:Show();
end

function KHunterTimers_AutoCascade(id, last)
	if( id == KHT_NUM_BARS ) then
		return;
	end
	if( id == 0 ) then
		id = 1;
	end
	local barframe = _G["KHunterTimersStatus"..id];
	if( barframe:IsVisible() ) then
		KHunterTimers_AutoCascade(id+1, false);
	else
		KHunterTimers_cascadeBar(id);
		local barframenext = _G["KHunterTimersStatus"..id+1];
		if( barframenext:IsVisible() ) then
			if( last ) then
				KHunterTimers_AutoCascade( id-1, true );
			else
				KHunterTimers_AutoCascade( id+1, false );
			end
		else
			KHunterTimers_AutoCascade(id+1, true);
		end
	end
end

function KHunterTimers_ShowOptions()

	if( KHTvars[KHT_ON] ) then
		KHunterTimersOptionsBarsCheckButtonOn:SetChecked(1);
	else
		KHunterTimersOptionsBarsCheckButtonOn:SetChecked(0);
	end
	
	if( KHTvars["locked"] ) then
		KHunterTimersOptionsBarsCheckButton1:SetChecked(1);
	else
		KHunterTimersOptionsBarsCheckButton1:SetChecked(0);
	end
	
	if( KHTvars["colorchange"] ) then
		KHunterTimersOptionsBarsCheckButton2:SetChecked(1);
	else
		KHunterTimersOptionsBarsCheckButton2:SetChecked(0);
	end
	
	if( KHTvars["showtex"] ) then
		KHunterTimersOptionsBarsCheckButton3:SetChecked(1);
	else
		KHunterTimersOptionsBarsCheckButton3:SetChecked(0);
	end
	
	if( KHTvars["largetex"] ) then
		KHunterTimersOptionsBarsCheckButton4:SetChecked(1);
	else
		KHunterTimersOptionsBarsCheckButton4:SetChecked(0);
	end
	
	if( KHTvars["gap"] ) then
		KHunterTimersOptionsBarsCheckButton5:SetChecked(0);
	else
		KHunterTimersOptionsBarsCheckButton5:SetChecked(1);
	end

	if( KHTvars["append"] ) then
		KHunterTimersOptionsBarsCheckButton6:SetChecked(1);
	else
		KHunterTimersOptionsBarsCheckButton6:SetChecked(0);
	end

	if( KHTvars["padding"] ) then
		KHunterTimersOptionsBarsCheckButton7:SetChecked(0);
	else
		KHunterTimersOptionsBarsCheckButton7:SetChecked(1);
	end
	
	if( KHTvars["hidetext"] ) then
		KHunterTimersOptionsBarsCheckButton8:SetChecked(1);
	else
		KHunterTimersOptionsBarsCheckButton8:SetChecked(0);
	end

	if( KHTvars["hidetime"] ) then
		KHunterTimersOptionsBarsCheckButton9:SetChecked(1);
	else
		KHunterTimersOptionsBarsCheckButton9:SetChecked(0);
	end

	if( KHTvars["sticky"] ) then
		KHunterTimersOptionsBarsCheckButton10:SetChecked(1);
	else
		KHunterTimersOptionsBarsCheckButton10:SetChecked(0);
	end

	if( KHTvars["down"] ) then
		KHunterTimersOptionsBarsCheckButton11:SetChecked(1);
	else
		KHunterTimersOptionsBarsCheckButton11:SetChecked(0);
	end

	KHunterTimersOptionsBarsEditBox1:SetText(KHTvars["shotdelay"]);
	
	KHunterTimersOptionsBarsEditBox2:SetText(KHTvars["bartexture"]);
	
	local r, g, b, a = unpack(KHTvars["barstartcolor"]);
	local rd, gd, bd, ad = unpack( KHTvars["bardelta"] );
	rd = rd + r;
	gd = gd + g;
	bd = bd + b;
	ad = ad + a;
	KHunterTimersOptionsBarsColor1Swatch:SetVertexColor(r, g, b);
	KHunterTimersOptionsBarsColor1Swatch.r = r;
	KHunterTimersOptionsBarsColor1Swatch.g = g;
	KHunterTimersOptionsBarsColor1Swatch.b = b;
	KHunterTimersOptionsBarsColor1Swatch.a = a;
	KHunterTimersOptionsBarsColor2Swatch:SetVertexColor(rd, gd, bd);
	KHunterTimersOptionsBarsColor2Swatch.r = rd;
	KHunterTimersOptionsBarsColor2Swatch.g = gd;
	KHunterTimersOptionsBarsColor2Swatch.b = bd;
	KHunterTimersOptionsBarsColor2Swatch.a = ad;
	KHunterTimersOptionsBarsColor3Swatch:SetVertexColor(KHTvars["bg"].r, KHTvars["bg"].g, KHTvars["bg"].b, KHTvars["bg"].a);
	KHunterTimersOptionsBarsColor3Swatch.r = KHTvars["bg"].r;
	KHunterTimersOptionsBarsColor3Swatch.g = KHTvars["bg"].g;
	KHunterTimersOptionsBarsColor3Swatch.b = KHTvars["bg"].b;
	KHunterTimersOptionsBarsColor3Swatch.a = KHTvars["bg"].a;
	KHunterTimersOptionsBarsColor4Swatch:SetVertexColor( unpack( KHTvars["borderalpha"]) );
	KHunterTimersOptionsBarsColor4Swatch.r, KHunterTimersOptionsBarsColor4Swatch.g, KHunterTimersOptionsBarsColor4Swatch.b, KHunterTimersOptionsBarsColor4Swatch.a = unpack( KHTvars["borderalpha"] );
	KHunterTimersOptionsBarsColor5Swatch:SetVertexColor(unpack(KHTvars["skillcolor"]));
	KHunterTimersOptionsBarsColor5Swatch.r, KHunterTimersOptionsBarsColor5Swatch.g, KHunterTimersOptionsBarsColor5Swatch.b, KHunterTimersOptionsBarsColor5Swatch.a = unpack( KHTvars["skillcolor"] );
	KHunterTimersOptionsBarsColor6Swatch:SetVertexColor(unpack(KHTvars["timecolor"]));
	KHunterTimersOptionsBarsColor6Swatch.r, KHunterTimersOptionsBarsColor6Swatch.g, KHunterTimersOptionsBarsColor6Swatch.b, KHunterTimersOptionsBarsColor6Swatch.a = unpack( KHTvars["timecolor"] );
	KHunterTimersOptionsBarsColor7Swatch:SetVertexColor(unpack(KHTvars["targetcolor"]));
	KHunterTimersOptionsBarsColor7Swatch.r, KHunterTimersOptionsBarsColor7Swatch.g, KHunterTimersOptionsBarsColor7Swatch.b, KHunterTimersOptionsBarsColor7Swatch.a = unpack( KHTvars["targetcolor"] );
	
	KHunterTimersOptionsBarsSlider1Slider:SetValue(KHTvars["bardistance"]);
	KHunterTimersOptionsBarsSlider2Slider:SetValue(KHTvars["scale"]/UIParent:GetScale());
	KHunterTimersOptionsBarsSlider3Slider:SetValue(KHTvars["mili"]);
	KHunterTimersOptionsBarsSlider4Slider:SetValue(KHTvars["flash"]);
	KHunterTimersOptionsBarsSlider5Slider:SetValue(KHTvars["step"]);
	KHunterTimersOptionsBarsSlider6Slider:SetValue(KHTvars["overallalpha"]);
	KHunterTimersOptionsBarsSlider7Slider:SetValue(KHTvars["barheight"]);
	
	KHunterTimersOptions:Show();
end

function KHunterTimers_SaveOptions()

	if( KHunterTimersOptionsBarsCheckButtonOn:GetChecked() == 1 ) then
		KHTvars[KHT_ON] = true;
	else
		KHTvars[KHT_ON] = false;
	end
	
	if( KHunterTimersOptionsBarsCheckButton1:GetChecked() == 1 ) then
		KHTvars["locked"] = true;
		KHunterTimersAnchor:Hide();
	else
		KHTvars["locked"] = false;
		KHunterTimersAnchor:Show();
	end
	
	if( KHunterTimersOptionsBarsCheckButton2:GetChecked() == 1 ) then
		KHTvars["colorchange"] = true;
	else
		KHTvars["colorchange"] = false;
	end
	
	if( KHunterTimersOptionsBarsCheckButton3:GetChecked() == 1 ) then
		KHTvars["showtex"] = true;
	else
		KHTvars["showtex"] = false;
	end

	if( KHunterTimersOptionsBarsCheckButton4:GetChecked() == 1 ) then
		KHTvars["largetex"] = true;
	else
		KHTvars["largetex"] = false;
	end

	if( KHunterTimersOptionsBarsCheckButton5:GetChecked() == 1 ) then
		KHTvars["gap"] = false;
	else
		KHTvars["gap"] = true;
	end

	if( KHunterTimersOptionsBarsCheckButton6:GetChecked() == 1 ) then
		KHTvars["append"] = true;
	else
		KHTvars["append"] = false;
	end

	if( KHunterTimersOptionsBarsCheckButton7:GetChecked() == 1 ) then
		KHTvars["padding"] = false;
	else
		KHTvars["padding"] = true;
	end
	
	if( KHunterTimersOptionsBarsCheckButton8:GetChecked() == 1 ) then
		KHTvars["hidetext"] = true;
	else
		KHTvars["hidetext"] = false;
	end

	if( KHunterTimersOptionsBarsCheckButton9:GetChecked() == 1 ) then
		KHTvars["hidetime"] = true;
	else
		KHTvars["hidetime"] = false;
	end

	if( KHunterTimersOptionsBarsCheckButton10:GetChecked() == 1 ) then
		KHTvars["sticky"] = true;
	else
		KHTvars["sticky"] = false;
	end

	if( KHunterTimersOptionsBarsCheckButton11:GetChecked() == 1 ) then
		KHTvars["down"] = true;
	else
		KHTvars["down"] = false;
	end

	KHTvars["shotdelay"] = 1*KHunterTimersOptionsBarsEditBox1:GetText();
	
	local texture = KHunterTimersOptionsBarsEditBox2:GetText();
	if( texture == "" ) then
		texture = "Interface\\TargetingFrame\\UI-TargetingFrame-BarFill";
	end
	KHTvars["bartexture"] = texture;
	KHunterTimersOptionsBarsEditBox2:SetText(KHTvars["bartexture"]);
	
	KHTvars["barstartcolor"][1] = KHunterTimersOptionsBarsColor1Swatch.r; 
	KHTvars["barstartcolor"][2] = KHunterTimersOptionsBarsColor1Swatch.g; 
	KHTvars["barstartcolor"][3] = KHunterTimersOptionsBarsColor1Swatch.b;
	KHTvars["barstartcolor"][4] = KHunterTimersOptionsBarsColor1Swatch.a;
	KHTvars["bardelta"][1] = KHunterTimersOptionsBarsColor2Swatch.r - KHunterTimersOptionsBarsColor1Swatch.r;
	KHTvars["bardelta"][2] = KHunterTimersOptionsBarsColor2Swatch.g - KHunterTimersOptionsBarsColor1Swatch.g;
	KHTvars["bardelta"][3] = KHunterTimersOptionsBarsColor2Swatch.b - KHunterTimersOptionsBarsColor1Swatch.b;
	KHTvars["bardelta"][4] = KHunterTimersOptionsBarsColor2Swatch.a - KHunterTimersOptionsBarsColor1Swatch.a;
	KHTvars["borderalpha"][1] = KHunterTimersOptionsBarsColor4Swatch.r;
	KHTvars["borderalpha"][2] = KHunterTimersOptionsBarsColor4Swatch.g;
	KHTvars["borderalpha"][3] = KHunterTimersOptionsBarsColor4Swatch.b;
	KHTvars["borderalpha"][4] = KHunterTimersOptionsBarsColor4Swatch.a;
	KHTvars["skillcolor"][1] = KHunterTimersOptionsBarsColor5Swatch.r;
	KHTvars["skillcolor"][2] = KHunterTimersOptionsBarsColor5Swatch.g;
	KHTvars["skillcolor"][3] = KHunterTimersOptionsBarsColor5Swatch.b;
	KHTvars["skillcolor"][4] = KHunterTimersOptionsBarsColor5Swatch.a;
	KHTvars["timecolor"][1] = KHunterTimersOptionsBarsColor6Swatch.r;
	KHTvars["timecolor"][2] = KHunterTimersOptionsBarsColor6Swatch.g;
	KHTvars["timecolor"][3] = KHunterTimersOptionsBarsColor6Swatch.b;
	KHTvars["timecolor"][4] = KHunterTimersOptionsBarsColor6Swatch.a;
	KHTvars["targetcolor"][1] = KHunterTimersOptionsBarsColor7Swatch.r;
	KHTvars["targetcolor"][2] = KHunterTimersOptionsBarsColor7Swatch.g;
	KHTvars["targetcolor"][3] = KHunterTimersOptionsBarsColor7Swatch.b;
	KHTvars["targetcolor"][4] = KHunterTimersOptionsBarsColor7Swatch.a;
	
	KHTvars["bg"].r = KHunterTimersOptionsBarsColor3Swatch.r;
	KHTvars["bg"].g = KHunterTimersOptionsBarsColor3Swatch.g;
	KHTvars["bg"].b = KHunterTimersOptionsBarsColor3Swatch.b;
	KHTvars["bg"].a = KHunterTimersOptionsBarsColor3Swatch.a;
	
	KHTvars["bardistance"] = KHunterTimersOptionsBarsSlider1Slider:GetValue();
	KHTvars["scale"] = KHunterTimersOptionsBarsSlider2Slider:GetValue()*UIParent:GetScale();
	KHTvars["mili"] = KHunterTimersOptionsBarsSlider3Slider:GetValue();
	KHTvars["flash"] = KHunterTimersOptionsBarsSlider4Slider:GetValue();
	KHTvars["step"] = KHunterTimersOptionsBarsSlider5Slider:GetValue();
	KHTvars["overallalpha"] = KHunterTimersOptionsBarsSlider6Slider:GetValue();
	KHTvars["barheight"] = KHunterTimersOptionsBarsSlider7Slider:GetValue();
	
	KHunterTimers_SetSettings();
	
end

function KHunterTimers_SaveCloseOptions()
	
	KHunterTimers_SaveOptions();
	KHunterTimersOptions:Hide();

end

function KHunterTimers_ResetOptions()

	KHTvars = {};
	
	KHTvars["version"] = 3.0;

	KHTvars["bg"] = { r=0, g=0, b=0, a=7 };

	KHTvars[KHT_ON] = true;

	KHTvars["borderalpha"] = {
		[1] = 1;
		[2] = 1;
		[3] = 1;
		[4] = 1;
	};

	KHunterTimersFrame:SetBackdropColor( KHTvars["bg"].r, KHTvars["bg"].g, KHTvars["bg"].b, KHTvars["bg"].a );
	KHunterTimersFrame:SetBackdropBorderColor( unpack(KHTvars["borderalpha"]) );
	KHTvars["numBars"] = 0;

	KHTvars["skills"] = {};

	for i=1, 6 do
		for j=1, KHT_NUM_TIMERS[i] do
			if ( KHTvars["skills"][KHT_OPTIONS_TIMERS[i][j]] == nil ) then
				KHTvars["skills"][KHT_OPTIONS_TIMERS[i][j]] = true;
			end
		end
	end
	
	KHTvars["shotdelay"] = 200;

	KHTvars["scale"] = UIParent:GetScale();

	KHTvars["locked"] = false;
	KHunterTimersAnchor:Show();

	KHTvars["bardistance"] = 10;

	KHTvars["down"] = true;

	KHTvars["mili"] = 1;

	KHTvars["flash"] = 5;
	
	local r, g, b = KHunterTimersStatus1BarLeftText:GetTextColor();
	KHTvars["skillcolor"] = {
		[1] = r,
		[2] = g,
		[3] = b,
		[4] = 1
	};

	local r, g, b = KHunterTimersStatus1BarRightText:GetTextColor();
	KHTvars["timecolor"] = {
		[1] = r,
		[2] = g,
		[3] = b,
		[4] = 1
	};

	local r, g, b = KHunterTimersStatus1BarLeftText:GetTextColor();
	KHTvars["targetcolor"] = {
		[1] = r,
		[2] = g,
		[3] = b,
		[4] = 1
	};

	KHTvars["barstartcolor"] = {
		[1] = 0,
		[2] = 0.8,
		[3] = 0,
		[4] = 1
	};

	KHTvars["bardelta"] = {
		[1] = 0.8,
		[2] = -0.8,
		[3] = 0,
		[4] = 0};

	KHTvars["step"] = 0.03;

	KHTvars["colorchange"] = false;

	KHTvars["append"] = false;

	KHTvars["overallalpha"] = 1;
	
	KHunterTimers_ClearActiveSpells();
	
	for i=1, KHT_NUM_OPTIONS do --Check boxes
		_G["KHunterTimersOptionsBarsCheckButton"..i.."Text"]:SetText(KHT_OPTIONS_BARS[i]);
	end
	
	for i=1, KHT_NUM_SLIDERS do  --Sliders
		_G["KHunterTimersOptionsBarsSlider"..i.."SliderTitle"]:SetText(KHT_OPTIONS_SLIDER[i]);
		_G["KHunterTimersOptionsBarsSlider"..i.."SliderLow"]:SetText(KHT_OPTIONS_SLIDER_ENDS[i][1])
		_G["KHunterTimersOptionsBarsSlider"..i.."SliderHigh"]:SetText(KHT_OPTIONS_SLIDER_ENDS[i][2]);
	end
	
	KHTvars["textures"] = {};
	KHunterTimers_UpdateSpells();
	
	KHTvars["showtex"] = true;

	KHTvars["largetex"] = true;

	KHTvars["hidetext"] = false;

	KHTvars["hidetime"] = false;

	KHTvars["gap"] = true;

	KHTvars["padding"] = true;

	KHTvars["barheight"] = 10;

	KHTvars["sticky"] = true;
	
	KHTvars["bartexture"] = "Interface\\TargetingFrame\\UI-TargetingFrame-BarFill";

	KHunterTimers_UpdateTalents();

	for i=1, KHT_NUM_LABELS do
		_G["KHunterTimersOptionsBarsLabel"..i.."Label"]:SetText(KHT_OPTIONS_LABELS[i]);
	end
	
	_G["KHunterTimersOptionsTitleString"]:SetText("Kharthus's Hunter Timers "..KHT_VERSION);
	
	KHunterTimers_SetSettings();
	
end

function KHunterTimers_SetSettings()
	
	KHunterTimersFrame:SetBackdropColor(KHTvars["bg"].r, KHTvars["bg"].g, KHTvars["bg"].b, KHTvars["bg"].a);
	KHunterTimersFrame:SetBackdropBorderColor(unpack(KHTvars["borderalpha"] ) );
	
	for i=1, KHT_NUM_BARS do
		local barframe = _G["KHunterTimersStatus"..i];
		local bar = _G["KHunterTimersStatus"..i.."Bar"];
		local bartexture = _G["KHunterTimersStatus"..i.."BarTexture"];
		local tt = _G["KHunterTimersStatus"..i.."BarTooltip"];
		local barwidth = 220;
		
		
		barframe:SetHeight( KHTvars["barheight"] );
		bar:SetHeight( KHTvars["barheight"] );
		tt:SetHeight( KHTvars["barheight"] );
		
		local texture = bartexture:SetTexture( KHTvars["bartexture"] );
		if( texture == nil ) then
			KHTvars["bartexture"] = "Interface\\TargetingFrame\\UI-TargetingFrame-BarFill";
			bartexture:SetTexture( KHTvars["bartexture"] );
			KHunterTimersOptionsBarsEditBox2:SetText(KHTvars["bartexture"]);
		end

		local icon = _G["KHunterTimersStatus"..i.."Icon"];
		if( KHTvars["showtex"] ) then
			
			icon:Show();
			if( KHTvars["gap"] ) then
				barwidth = barwidth - 5;
			end
			if( KHTvars["largetex"] ) and ( KHTvars["barheight"] < 16) then
				barframe:SetHeight(16);
				icon:SetHeight(16);
				icon:SetWidth(16);
				barwidth = barwidth - 16;
			else
				icon:SetHeight( KHTvars["barheight"] );
				icon:SetWidth( KHTvars["barheight"] );
				barwidth = barwidth - KHTvars["barheight"];
			end
			
			bar:ClearAllPoints();
			if( KHTvars["gap"] ) then
				bar:SetPoint("LEFT", "KHunterTimersStatus"..i.."Icon", "RIGHT", 5, 0 );
			else
				bar:SetPoint("LEFT", "KHunterTimersStatus"..i.."Icon", "RIGHT", 0, 0 );
			end
			tt:ClearAllPoints();
			if( KHTvars["gap"] ) then
				tt:SetPoint("LEFT", "KHunterTimersStatus"..i.."Icon", "RIGHT", 5, 0 );
			else
				tt:SetPoint("LEFT", "KHunterTimersStatus"..i.."Icon", "RIGHT", 0, 0 );
			end
		else
			icon:Hide();
			bar:SetPoint("LEFT", "KHunterTimersStatus"..i, "LEFT", 0, 0 );
			tt:SetPoint("LEFT", "KHunterTimersStatus"..i, "LEFT", 0, 0 );
		end
		barframe:SetWidth(220);
		bar:SetWidth(barwidth);
		tt:SetWidth(barwidth);
		if( KHTvars["hidetext"] ) then
			_G["KHunterTimersStatus"..i.."BarLeftText"]:Hide();
		else
			_G["KHunterTimersStatus"..i.."BarLeftText"]:Show();
		end
		if( KHTvars["hidetime"] ) then
			_G["KHunterTimersStatus"..i.."BarRightText"]:Hide();
		else
			_G["KHunterTimersStatus"..i.."BarRightText"]:Show();
		end
	end
	
	
	local height;
	local padding;
	if( not KHTvars["largetex"] ) or ( KHTvars["barheight"] >= 16 ) then
		height = KHTvars["numBars"] * (KHTvars["barheight"] + KHTvars["bardistance"]) - KHTvars["bardistance"] + 10;
	else
		height = KHTvars["numBars"] * (16 + KHTvars["bardistance"]) - KHTvars["bardistance"] + 10;
	end
	
	if( KHTvars["padding"] ) then
		KHunterTimersFrame:SetWidth( 240 );
		padding = 10;
		height = height + 10;
	else
		KHunterTimersFrame:SetWidth( 230 );
		padding = 5;
	end
	
	KHunterTimersFrame:SetHeight(height);
	
	if( KHTvars["down"] ) then
		KHunterTimersFrame:ClearAllPoints();
		KHunterTimersFrame:SetPoint( "TOPLEFT", "KHunterTimersAnchor", "BOTTOMLEFT" );
		KHunterTimersStatus1:ClearAllPoints();
		KHunterTimersStatus1:SetPoint( "TOPLEFT", "KHunterTimersFrame", "TOPLEFT", padding, -padding );
		for i=2, KHT_NUM_BARS do
			_G["KHunterTimersStatus"..i]:ClearAllPoints();
			_G["KHunterTimersStatus"..i]:SetPoint( "TOP", "KHunterTimersStatus"..(i-1), "BOTTOM", 0, -KHTvars["bardistance"] );
		end
	else
		KHunterTimersFrame:ClearAllPoints();
		KHunterTimersFrame:SetPoint( "BOTTOMLEFT", "KHunterTimersAnchor", "TOPLEFT" );
		KHunterTimersStatus1:ClearAllPoints();
		KHunterTimersStatus1:SetPoint( "BOTTOMLEFT", "KHunterTimersFrame", "BOTTOMLEFT", padding, padding );
		for i=2, KHT_NUM_BARS do
			_G["KHunterTimersStatus"..i]:ClearAllPoints();
			_G["KHunterTimersStatus"..i]:SetPoint( "BOTTOM", "KHunterTimersStatus"..(i-1), "TOP", 0, KHTvars["bardistance"] );
		end
	end

	KHunterTimersFrame:SetScale( KHTvars["scale"] );
	KHunterTimersFrame:SetAlpha( KHTvars["overallalpha"] );
	for i=1, KHT_NUM_BARS do
		_G["KHunterTimersStatus"..i]:SetScale( KHTvars["scale"] );
		_G["KHunterTimersStatus"..i]:SetAlpha( KHTvars["overallalpha"] );
	end

end

function KHT_SetHeight()
	local height; 
	if( not KHTvars["largetex"] ) or ( KHTvars["barheight"] >= 16 ) then
		height = KHTvars["numBars"] * (KHTvars["barheight"] + KHTvars["bardistance"]) - KHTvars["bardistance"] + 10;
	else
		height = KHTvars["numBars"] * (16 + KHTvars["bardistance"]) - KHTvars["bardistance"] + 10;
	end
	
	if( KHTvars["padding"] ) then
		height = height + 10;
	end
	
	KHunterTimersFrame:SetHeight(height);
	KHunterTimers_SetWidths();
end

function KHunterTimers_UpdateTalents()

	local _, _, _, _, rank = GetTalentInfo( 3, 5 ); --Trap Mastery
	KHTvars["traptimemult"] = 1 + (rank * 0.10);
	
	local _, _, _, _, rank = GetTalentInfo( 3, 6 ); --Entrapment
	KHTvars["entrapmentmult"] = rank * 2000;
	
	KHTvars["impconc"] = 0;
--	local _, _, _, _, rank = GetTalentInfo( 2, 1 ); --Improved Concussive Shot
--	KHTvars["impconc"] = rank * 1000;

end

function KHunterTimers_UpdateSpells()

	for key,val in pairs(KHTvars["skills"]) do
		local i = 1;
		while( GetSpellBookItemTexture(i, BOOKTYPE_SPELL) ) do
			local spellName = GetSpellBookItemName(i, BOOKTYPE_SPELL);
			if( spellName == key ) then
				KHTvars["textures"][key] = GetSpellBookItemTexture(i, BOOKTYPE_SPELL);
				break;
			end
			i = i + 1;
		end
	end

	for key,val in pairs(KHTvars["skills"]) do
		local i = 1;
		while( GetSpellBookItemTexture(i, BOOKTYPE_PET) ) do
			local spellName = GetSpellBookItemName(i, BOOKTYPE_PET);
			if( spellName == key ) then
				KHTvars["textures"][key] = GetSpellBookItemTexture(i, BOOKTYPE_PET);
				break;
			end
			i = i + 1;
		end
	end

	-- Support for glyphs
--[[	for i = 1, 6 do
		local enabled, glyphType, glyphSpellID, icon = GetGlyphSocketInfo(i);
		if ( enabled and glyphSpellID == 56832 ) then
			KHTvars["serpentglyph"] = 6000;
		end
	end]]

	-- Set/Item Procs
	KHTvars["textures"][KHT_CHAMPION]			= KHT_CHAMPION_ICON;
	KHTvars["textures"][KHT_BEASTLORD]			= KHT_BEASTLORD_ICON;
	KHTvars["textures"][KHT_EXPOSE_DS]			= KHT_EXPOSE_DS_ICON;
	KHTvars["textures"][KHT_HEROIC]			= KHT_HEROIC_ICON;
	KHTvars["textures"][KHT_PRIMAL]			= KHT_PRIMAL_ICON;
	KHTvars["textures"][KHT_SANTOS]			= KHT_SANTOS_ICON;
	KHTvars["textures"][KHT_SKYFIRE]			= KHT_SKYFIRE_ICON;
	KHTvars["textures"][KHT_PRECISION]			= KHT_PRECISION_ICON;
	KHTvars["textures"][KHT_ASHEN_VERDICT]		= KHT_ASHEN_VERDICT_ICON;
	KHTvars["textures"][KHT_BLOOD_HUNT_2PC]		= KHT_BLOOD_HUNT_2PC_ICON;
	KHTvars["textures"][KHT_BLOOD_HUNT_4PC]		= KHT_BLOOD_HUNT_4PC_ICON;
	KHTvars["textures"][KHT_WINDRUNNER_4PC]		= KHT_WINDRUNNER_4PC_ICON;
	KHTvars["textures"][KHT_HYP_SPEED]			= KHT_HYP_SPEED_ICON;
	KHTvars["textures"][KHT_FLAMEWAKER_4PC]		= KHT_FLAMEWAKER_4PC_ICON;
	KHTvars["textures"][KHT_WYRMSTALKER_4PC]	= KHT_WYRMSTALKER_4PC_ICON;

	-- Talent Procs
	KHTvars["textures"][KHT_COBRA_STRIKES]		= KHT_COBRA_STRIKES_ICON;
	KHTvars["textures"][KHT_CONC_BARRAGE]		= KHT_CONC_BARRAGE_ICON;
	KHTvars["textures"][KHT_PET_FRENZY]		= KHT_PET_FRENZY_ICON;
	KHTvars["textures"][KHT_STEADY]			= KHT_STEADY_ICON;
	KHTvars["textures"][KHT_LOCK_LOAD]			= KHT_LOCK_LOAD_ICON;
	KHTvars["textures"][KHT_RAPID_KILLING]		= KHT_RAPID_KILLING_ICON;
	KHTvars["textures"][KHT_PIERCING]			= KHT_PIERCING_ICON;
	KHTvars["textures"][KHT_READY_SET]			= KHT_READY_SET_ICON;
	KHTvars["textures"][KHT_FIRE]				= KHT_FIRE_ICON;
	KHTvars["textures"][KHT_KILLING_STREAK]		= KHT_KILLING_ICON;
	KHTvars["textures"][KHT_SNIPER]			= KHT_SNIPER_ICON;
	KHTvars["textures"][KHT_MARKED]			= KHT_MARKED_ICON;
	
	-- Trinkets
	KHTvars["textures"][KHT_ABACUS]			= KHT_ABACUS_ICON;
	KHTvars["textures"][KHT_FEROCITY]			= KHT_FEROCITY_ICON;
	KHTvars["textures"][KHT_TORMENT]			= KHT_TORMENT_ICON;
	KHTvars["textures"][KHT_ASHTONGUE]			= KHT_ASHTONGUE_ICON;
	KHTvars["textures"][KHT_SWARMGUARD]		= KHT_SWARMGUARD_ICON;
	KHTvars["textures"][KHT_BERSERKER]			= KHT_BERSERKER_ICON;
	KHTvars["textures"][KHT_LUST]				= KHT_LUST_ICON;
	KHTvars["textures"][KHT_ANCIENT_POWER]		= KHT_ANCIENT_POWER_ICON;
	KHTvars["textures"][KHT_GREATNESS]			= KHT_GREATNESS_ICON;
	KHTvars["textures"][KHT_DELUSIONAL]		= KHT_DELUSIONAL_ICON;
	KHTvars["textures"][KHT_KLEPTOMANIA]		= KHT_KLEPTOMANIA_ICON;
	KHTvars["textures"][KHT_MANIC]			= KHT_MANIC_ICON;
	KHTvars["textures"][KHT_MARTYR]			= KHT_MARTYR_ICON;
	KHTvars["textures"][KHT_NARCISSISM]		= KHT_NARCISSISM_ICON;
	KHTvars["textures"][KHT_PARANOIA]			= KHT_PARANOIA_ICON;
	KHTvars["textures"][KHT_WRATH]			= KHT_WRATH_ICON;
	KHTvars["textures"][KHT_DEVILSAUR]			= KHT_DEVILSAUR_ICON;
	KHTvars["textures"][KHT_DRAGON]			= KHT_DRAGON_ICON;
	KHTvars["textures"][KHT_EARTHSTRIKE]		= KHT_EARTHSTRIKE_ICON;
	KHTvars["textures"][KHT_DIREBREW]			= KHT_DIREBREW_ICON;
	KHTvars["textures"][KHT_UNRAVELLER]		= KHT_UNRAVELLER_ICON;
	KHTvars["textures"][KHT_INCISOR]			= KHT_INCISOR_ICON;
	KHTvars["textures"][KHT_JOM_GABBAR]		= KHT_JOM_GABBAR_ICON;
	KHTvars["textures"][KHT_KISS_SPIDER]		= KHT_KISS_SPIDER_ICON;
	KHTvars["textures"][KHT_LOATHEB]			= KHT_LOATHEB_ICON;
	KHTvars["textures"][KHT_MADNESS]			= KHT_MADNESS_ICON;
	KHTvars["textures"][KHT_METEORITE]			= KHT_METEORITE_ICON;
	KHTvars["textures"][KHT_NIGHTSEYE]			= KHT_NIGHTSEYE_ICON;
	KHTvars["textures"][KHT_BURNING_HATRED]		= KHT_BURNING_HATRED_ICON;
	KHTvars["textures"][KHT_PYRITE]			= KHT_PYRITE_ICON;
	KHTvars["textures"][KHT_EDWARD]			= KHT_EDWARD_ICON;
	KHTvars["textures"][KHT_SKYGUARD]			= KHT_SKYGUARD_ICON;
	KHTvars["textures"][KHT_TALON]			= KHT_TALON_ICON;
	KHTvars["textures"][KHT_HEROISM]			= KHT_HEROISM_ICON;
	KHTvars["textures"][KHT_TSUNAMI]			= KHT_TSUNAMI_ICON;
	KHTvars["textures"][KHT_ZHM]				= KHT_ZHM_ICON;
	KHTvars["textures"][KHT_PARAGON]			= KHT_PARAGON_ICON;
	KHTvars["textures"][KHT_PARAGON.." (H)"]	= KHT_PARAGON_ICON;
	KHTvars["textures"][KHT_MJOLNIR]			= KHT_MJOLNIR_ICON;
	KHTvars["textures"][KHT_GRIM_TOLL]			= KHT_GRIM_TOLL_ICON;
	KHTvars["textures"][KHT_NES]				= KHT_NES_ICON;
	KHTvars["textures"][KHT_DEATH_AGI]			= KHT_DEATH_AGI_ICON;
	KHTvars["textures"][KHT_DEATH_AGI.." (H)"]	= KHT_DEATH_AGI_ICON;
	KHTvars["textures"][KHT_DEATH_AP]			= KHT_DEATH_AP_ICON;
	KHTvars["textures"][KHT_DEATH_AP.." (H)"]	= KHT_DEATH_AP_ICON;
	KHTvars["textures"][KHT_DEATH_CRIT]		= KHT_DEATH_CRIT_ICON;
	KHTvars["textures"][KHT_DEATH_CRIT.." (H)"]	= KHT_DEATH_CRIT_ICON;
	KHTvars["textures"][KHT_FANGED]			= KHT_FANGED_ICON;
	KHTvars["textures"][KHT_FANGED.." (H)"]		= KHT_FANGED_ICON;
	KHTvars["textures"][KHT_STS]				= KHT_STS_ICON;
	KHTvars["textures"][KHT_STS.." (H)"]		= KHT_STS_ICON;
	KHTvars["textures"][KHT_HUNGER]			= KHT_HUNGER_ICON;
	KHTvars["textures"][KHT_HUNGER.." (H)"]		= KHT_HUNGER_ICON;

	-- Other
	KHTvars["textures"][KHT_ENTRAPMENT]		= KHT_ENTRAPMENT_ICON;
	KHTvars["textures"][KHT_BLOODLUST]			= KHT_BLOODLUST_ICON;
	KHTvars["textures"][KHT_TIME_WARP]			= KHT_TIME_WARP_ICON;
	
end

function KHunterTimers_ClearActiveSpells()

	khtAutoShot = false;
	khtPetIntim = false;
	khtMulti = false;
	fireTrapTimer = false;
	frostTrapTimer = false;
	natureTrapTimer = false;
	khtLockLoad = false;
	khtRapidFire = 0;
	khtImpSteady = 0;
	khtSerpent = 0;
	khtSniper = 0;
	khtFrenzy = 0;

end

local KHTSetColorFunc = {
	[1] = function() KHTSetColor(1) end,
	[2] = function() KHTSetColor(2) end,
	[3] = function() KHTSetColor(3) end,
	[4] = function() KHTSetColor(4) end,
	[5] = function() KHTSetColor(5) end,
	[6] = function() KHTSetColor(6) end,
	[7] = function() KHTSetColor(7) end
};

local KHTSetOpacityFunc = {
	[1] = function() KHTSetOpacity(1) end,
	[2] = function() KHTSetOpacity(2) end,
	[3] = function() KHTSetOpacity(3) end,
	[4] = function() KHTSetOpacity(4) end,
	[5] = function() KHTSetOpacity(5) end,
	[6] = function() KHTSetOpacity(6) end,
	[7] = function() KHTSetOpacity(7) end
};

local KHTCancelFunc = {
	[1] = function(x) KHTCancelColor(1, x) end,
	[2] = function(x) KHTCancelColor(2, x) end,
	[3] = function(x) KHTCancelColor(3, x) end,
	[4] = function(x) KHTCancelColor(4, x) end,
	[5] = function(x) KHTCancelColor(5, x) end,
	[6] = function(x) KHTCancelColor(6, x) end,
	[7] = function(x) KHTCancelColor(7, x) end
};

function KHT_ColorPicker(id)
	CloseMenus();
	local texture = _G["KHunterTimersOptionsBarsColor"..id.."Swatch"];
	ColorPickerFrame.func = KHTSetColorFunc[id];
	ColorPickerFrame:SetColorRGB(texture.r, texture.g, texture.b);
	ColorPickerFrame.previousValues = {r = texture.r, g = texture.g, b = texture.b, opacity =texture.a};
	ColorPickerFrame.cancelFunc = KHTCancelFunc[id];
	if( id < 5 ) then
		ColorPickerFrame.hasOpacity = true;
		ColorPickerFrame.opacity = 1 - texture.a;
		ColorPickerFrame.opacityFunc = KHTSetOpacityFunc[id];
	else
		ColorPickerFrame.hasOpacity = false;
	end
	
	
	--OpacityFrame.opacityFunc = KHTSetOpacityFunc[id];
	
	ColorPickerFrame:Show();
end

function KHTSetOpacity(id)
	local a = 1 - OpacitySliderFrame:GetValue();
	local texture = _G["KHunterTimersOptionsBarsColor"..id.."Swatch"];
	--DEFAULT_CHAT_FRAME:AddMessage(id);
	texture:SetAlpha(a);
	texture.a = a;
end

function KHTSetColor(id)
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local texture = _G["KHunterTimersOptionsBarsColor"..id.."Swatch"];
	--KHTSetOpacity(id);
	texture:SetVertexColor(r, g, b);
	texture.r = r;
	texture.g = g;
	texture.b = b;
end

function KHTCancelColor(id, prev)
	local texture = _G["KHunterTimersOptionsBarsColor"..id.."Swatch"];
	local r = prev.r;
	local g = prev.g;
	local b = prev.b;
	local a = prev.opacity;
	texture:SetVertexColor(r, g, b);
	texture:SetAlpha( a );
	texture.r = r;
	texture.g = g;
	texture.b = b;
	texture.a = a;
end

function KHTColor(r, g, b, a)
	if( not a ) then
		a = 1;
	end
	return string.format("|c%02x%02x%02x%02x", (a*255), (r*255), (g*255), (b*255));
end

function KHunterTimers_Tooltip( barframe )
	--DEFAULT_CHAT_FRAME:AddMessage(barframe:GetName());
	if( barframe.target ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, barframe);
		GameTooltip:ClearLines();
		GameTooltip:AddLine( barframe.target );
		GameTooltip:Show();
	end
end

function KHT_sfind( s, pattern )
	for p in string.gmatch( pattern, "([^|]+)" ) do
		if( string.find( s, p ) )then
			return string.find( s, p );
		end
	end
	return false;
end

function KHunterTimers_SavePos( frame )
	local window, point, relativePoint, xOffset, yOffset;
	window = frame:GetName();
	point, _, relativePoint, xOffset, yOffset = frame:GetPoint();
	KHTvars[window]["point"] = point;
	KHTvars[window]["relativePoint"] = relativePoint;
	KHTvars[window]["xOffset"] = xOffset;
	KHTvars[window]["yOffset"] = yOffset;
end

function KHunterTimers_ResetPos( frame )
	local window, point, relativePoint, xOffset, yOffset;
	window = frame:GetName();
	point = KHTvars[window]["point"];
	relativePoint = KHTvars[window]["relativePoint"];
	xOffset = KHTvars[window]["xOffset"];
	yOffset = KHTvars[window]["yOffset"];
	frame:ClearAllPoints();
	frame:SetPoint(point, "UIParent", relativePoint, xOffset, yOffset);
end
