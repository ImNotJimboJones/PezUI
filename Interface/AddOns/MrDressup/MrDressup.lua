MrDressup = {};
local MrDressup = MrDressup;

function MrDressup.Options_SlashCmdHandler(command)
	if string.lower(command) == "show" then
		MrDressupFrame:Show();
		MrDressup_SV.hide = false;
	elseif string.lower(command) == "hide" then
		MrDressupFrame:Hide();
		MrDressup_SV.hide = true;
	elseif string.lower(command) == "right" then
		MrDressup_SV.right = true;
		MrDressupFrameShowHelm:ClearAllPoints();
		MrDressupFrameShowHelm:SetPoint("BOTTOMLEFT", CharacterModelFrame, "TOPLEFT", 140, -302);
	elseif string.lower(command) == "left" then
		MrDressup_SV.right = false;
		MrDressupFrameShowHelm:ClearAllPoints();
		MrDressupFrameShowHelm:SetPoint("BOTTOMLEFT", CharacterModelFrame, "TOPLEFT", 2, -302);
	else 
		print("MrDressup commands: show, hide, left, right");
	end
end

function MrDressup.OnLoad()
	SlashCmdList["MRDRESSUP_OPTIONS"] = MrDressup.Options_SlashCmdHandler;
	SLASH_MRDRESSUP_OPTIONS1 = "/mrdressup";
end

function MrDressup.OnEvent(self, event, ...)
	local arg1 = ...;
	if event == "ADDON_LOADED" and arg1 == "MrDressup" then
		DEFAULT_CHAT_FRAME:AddMessage("MrDressup v" .. GetAddOnMetadata("MrDressup", "Version") .. " loaded. /mrdressup for Options.");
		if not MrDressup_SV then MrDressup_SV = {} end
		if MrDressup_SV.hide then MrDressupFrame:Hide(); else MrDressupFrame:Show(); end
		if MrDressup_SV.right then
			MrDressupFrameShowHelm:ClearAllPoints();
			MrDressupFrameShowHelm:SetPoint("BOTTOMLEFT", CharacterModelFrame, "TOPLEFT", 140, -302);
		end
	end
end
