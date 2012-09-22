-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

MRT_GUILD_CRAFTERS_DISPLAYED = 10;
MRT_GUILD_SKILL_HEIGHT = 16;

function MRTSkillGuildFrame_OnShow()
	MRTSkillGuildCraftersFrameScrollBar:SetValue(0);
	MRTSkillGuildCraftersFrame_Update();
end

function MRTSkillGuildCraftersFrame_Update()
	local skillLineID, recipeID, numMembers = GetGuildRecipeInfoPostQuery();
	local offset = FauxScrollFrame_GetOffset(MRTSkillGuildCraftersFrame);
	local index, button, name, online;
	
	for i = 1, MRT_GUILD_CRAFTERS_DISPLAYED, 1 do
		index = i + offset;
		button = _G["MRTSkillGuildCrafter"..i];
		if ( index > numMembers ) then
			button:Hide();
		else
			name, online = GetGuildRecipeMember(index);
			button:SetText(name);
			if ( online ) then
				button:Enable();
			else
				button:Disable();
			end
			button:Show();
			button.name = name;
		end
	end
	FauxScrollFrame_Update(MRTSkillGuildCraftersFrame, numMembers, MRT_GUILD_CRAFTERS_DISPLAYED, MRT_GUILD_SKILL_HEIGHT);
end