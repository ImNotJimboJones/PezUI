-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):GetLocale("MrTrader", true);

-----
-- MRTSkillUps - Plugin to provide a badge for skill ups
--
-- Interfaces -
--   TradeSkillWindowInfoBadge - Provides a badge for the skill.
-----
MRTSkillUps = {
	id = "263178d0-dc0f-4748-9aea-0ac5a1195881",
	name = L["Skill Ups"],
	interfaces = {
		TradeSkillWindowInfoBadge = function(tradeskillInfo) return MRTSkillUps:TradeSkillWindowInfoBadge(tradeskillInfo) end,
 	}
};
MRTAPI:RegisterPlugin(MRTSkillUps);

function MRTSkillUps:TradeSkillWindowInfoBadge(tradeskillInfo)
	if( tradeskillInfo.numSkillUps ~= nil ) then
		if( tradeskillInfo.numSkillUps > 1 and tradeskillInfo.skillType=="optimal" ) then
			return "Interface\\TradeSkillFrame\\UI-TradeSkill-Multiskill", tradeskillInfo.numSkillUps, "Skill Ups", nil;
		end
	end
	
	return nil;
end

function MRTSkillUps:BadgeWasClicked(tradeskillIndex)
	print(GetTradeSkillInfo(tradeskillIndex));
end

-----
-- MRTToolsAndCooldown - Plugin to provide cooldown and tool information for skills in a single line
--
-- Interfaces:
--   TradeSkillWindowInfoLine - Provides a line of info text for a recipe
-----
MRTToolsAndCooldown = {
    id = "50ad4feb-60bd-447b-abfe-be5fbbf2c189",
    name = L["Tools and Cooldown"],
    interfaces = {
        TradeSkillWindowInfoLine = function(tradeskillInfo) return MRTToolsAndCooldown:TradeSkillWindowInfoLine(tradeskillInfo) end,
		TradeSkillWindowTooltipLines = function(tradeskillInfo, tooltip) return MRTToolsAndCooldown:TradeSkillWindowTooltipLines(tradeskillInfo, tooltip) end,
    },
};
MRTAPI:RegisterPlugin(MRTToolsAndCooldown);

function MRTToolsAndCooldown:TradeSkillWindowTooltipLines(tradeskillInfo, tooltip)
	tooltip:AddLine(self:BuildToolString(tradeskillInfo.skillTools, L["Tools"] .. ":", true), 1.0, 1.0, 1.0, 1);
end

function MRTToolsAndCooldown:TradeSkillWindowInfoLine(tradeskillInfo)
	local result = nil;

	if( tradeskillInfo.skillCooldown ~= nil ) then
		result = "|cffff0000" .. COOLDOWN_REMAINING .. " " .. SecondsToTime(tradeskillInfo.skillCooldown) .. "|r";
	end
	if( tradeskillInfo.skillCooldown == nil and tradeskillInfo.skillTools ~= nil and getn(tradeskillInfo.skillTools) > 0 ) then
		result = MRTToolsAndCooldown:BuildToolString(tradeskillInfo.skillTools, REQUIRES_LABEL);
	end
	
	return result;
end

function MRTToolsAndCooldown:BuildToolString(table, label, showall)
	local result = "";
	local overflow = 0;
	local overflowRed = false;

	local count = getn(table);
	for i=1,count,2 do
		local k = table[i];
		local v = table[i+1];
		local textAddition = "";
		local overflowIsRed = false;
		if( result ~= "" ) then textAddition = ", " end;
		local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(k);

		if( v ~= 1 ) then
			-- Missing
			textAddition = textAddition .. "|cffff0000" .. k .. "|r";
			overflowIsRed = true;
		else
			-- This is a type of object that you need, but can't carry
			if(texture == nil or showall) then
				textAddition = textAddition .. k;
			end
		end
		
		if(MRTUIUtils_GetInfoStringWidth(label .. " " .. result .. textAddition) > 200 and not showall) then
			overflow = overflow + 1;
			overflowRed = overflowRed or overflowIsRed;
		else
			result = result .. textAddition;
		end
	end
	
	if( overflow > 0 ) then
		if( result ~= "" ) then result = result .. ", " end ;
		if( overflowRed ) then result = result .. "|cffff0000" end;
		result = result .. string.format(L["%s more"], overflow);
		if( overflowRed ) then result = result .. "|r" end;
	end
	
	if( result ~= "" ) then
		result = label .. " " .. result;
		return result;
	end
	
	return nil;
end