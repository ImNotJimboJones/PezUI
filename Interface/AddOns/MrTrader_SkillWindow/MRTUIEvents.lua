-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

function MRTSkillWindow_OnSkillClick(self, button)
	if ( IsShiftKeyDown() ) then
		HandleModifiedItemClick(GetTradeSkillRecipeLink(self:GetID()));
	else
		MRTSkillWindow:SelectSkill(self, button);
	end
end

function MRTSkillWindow_OnFilterClick(self, button)
	if(button == "LeftButton") then
		MRTSkillWindow:SelectFilter(self.filterRef, self);
	elseif(button == "RightButton") then
		MRTSkillContext:DisplayFilterContext(self);
	end
end

function MRTSkillWindow_OnShow()
	-- Empty
end

function MRTSkillWindow_OnHide()
	CloseTradeSkill();
	MRTNewCategoryFrame:Hide();
end

function MRTSkillWindow_OnMouseDown()
	if( MRTSkillFrame:IsMovable() ) then
		MRTSkillFrame:StartMoving();
	end
end

function MRTSkillWindow_OnMouseUp()
	if( MRTSkillFrame:IsMovable() ) then
		MRTSkillFrame:StopMovingOrSizing();
		MrTrader:StoreLocation("MRTSkillFrame", MRTSkillFrame);
	end
end

function MRTSkillWindow_OnDecrementClick()
	if ( MRTSkillInputBox:GetNumber() > 0 ) then
		MRTSkillInputBox:SetNumber(MRTSkillInputBox:GetNumber() - 1);
	end
end

function MRTSkillWindow_OnIncrementClick()
	if ( MRTSkillInputBox:GetNumber() < 100 ) then
		MRTSkillInputBox:SetNumber(MRTSkillInputBox:GetNumber() + 1);
	end
end

function MRTSkillWindow_OnQueueToggle(checkbutton, button)
	if( checkbutton:GetChecked() ) then
		MRTQueueWindow:Show();
	else
		MRTQueueWindow:Close();
	end
end

function MRTSkillWindow_OnEnterSkillIcon(item)
	if(item:GetID() == nil) then
		return;
	end
	
	GameTooltip:SetOwner(MRTSkillFrame);

	if ( strmatch(item:GetName(), "MRTSkillButton(%d+)Reagent") ) then
		if( item:GetParent():GetID() == nil ) then return; end;		
		GameTooltip:SetTradeSkillItem(item:GetParent():GetID(), item:GetID());
	elseif ( strmatch(item:GetName(), "MRTSkillButton(%d+)Icon") ) then
		if( item:GetParent():GetID() == nil ) then return; end;
		GameTooltip:SetTradeSkillItem(item:GetParent():GetID());
	elseif ( strmatch(item:GetName(), "MRTSkillButton(%d+)") ) then
		if( MrTrader:ShouldDisplaySkillListTooltip() ) then
			local id = item:GetID();
			local skill = MRTSkillWindow:ReadCoreSkillItem(id);
			skill = MRTSkillWindow:ReadSkillItem(id, skill);
			skill = MRTSkillWindow:ReadSkillItemReagents(id, skill);
			
			GameTooltip:ClearLines();
			GameTooltip:AddLine(skill.skillName, GetItemQualityColor(skill.itemRarity or 1));
			GameTooltip:AddLine(GetTradeSkillDescription(id), YELLOW_FONT_COLOR.r * 0.8, YELLOW_FONT_COLOR.g * 0.8, YELLOW_FONT_COLOR.b * 0.8, 1);
			
			-- Run through the plugins here	
			local plugins = MRTAPI:PluginsForInterface("TradeSkillWindowTooltipLines");
			for _, plugin in ipairs(plugins) do
				local shouldPad = plugin.interfaces.TradeSkillWindowTooltipLines(skill, GameTooltip);
			end
				
			GameTooltip:AddLine("    ");
			GameTooltip:AddLine("Reagents:", 1.0, 1.0, 1.0);
			
			for j=1, #(skill.reagents), 1 do
				local reagent = skill.reagents[j];
				if(reagent.name and reagent.itemName) then
					local r, g, b = GetItemQualityColor(reagent.itemRarity or 0);
					local hasEnough = 0.0;
				
					if (reagent.playerCount >= reagent.count) then
						hasEnough = 1.0;
					end
			   		GameTooltip:AddDoubleLine(reagent.name, reagent.playerCount.."/"..reagent.count, r, g, b, 1.0, 1.0 * hasEnough, 1.0 * hasEnough);				
					GameTooltip:AddTexture(reagent.texture);
				else
					GameTooltip:AddLine("Retrieving", 1.0, 0.0, 0.0, 0.0);
				end
			end
			
			GameTooltip:Show();
		end
	end
	
	GameTooltip:ClearAllPoints();
	local rightOffset = MRTSkillFrame:GetRight();
	local tooltipWidth = GameTooltip:GetWidth();
	local screenRight = UIParent:GetWidth();
		
	if(rightOffset + tooltipWidth > screenRight) then
		GameTooltip:SetPoint("TOPRIGHT", MRTSkillFrame, "TOPLEFT", 0, -10);		
	else
		GameTooltip:SetPoint("TOPLEFT", MRTSkillFrame, "TOPRIGHT", 0, -10);
	end
	
	CursorUpdate(item);
end

function MRTSkillWindow_OnSearchTextChange(field)
	local text = field:GetText();
	
	if ( text == SEARCH or text == "" ) then
		SetTradeSkillItemNameFilter("");
		return;
	end

	local minLevel, maxLevel;
	local approxLevel = strmatch(text, "^~(%d+)");
	if ( approxLevel ) then
		minLevel = approxLevel - 2;
		maxLevel = approxLevel + 2;
	else
		minLevel, maxLevel = strmatch(text, "^(%d+)%s*-*%s*(%d*)$");
	end
	if ( minLevel ) then
		if ( maxLevel == "" or maxLevel < minLevel ) then
			maxLevel = minLevel;
		end
		SetTradeSkillItemNameFilter(nil);
		SetTradeSkillItemLevelFilter(minLevel, maxLevel);
	else
		SetTradeSkillItemLevelFilter(0, 0);
		SetTradeSkillItemNameFilter(text);
	end	
	
	MRTSkillFrameSearchBoxClearButton:Show();
	MRTSkillWindow_Update();
end

function MRTSkillWindow_Update()
	MRTSkillWindow:DrawSkillList();
end

function MRTSkillWindow_UpdateFilters()
	--MRTSkillWindow:UpdateFilters();
	MRTSkillWindow:DrawFilters();
end

function MRTSkillWindow_UpdateHeaders()
	MRTSkillWindow:DrawHeader();
end

function MRTSkillWindowViewGuildCraftersButton_OnClick()
	MRTSkillGuildFrame.queriedSkill = MRTSkillWindow.selectedSkill;
	QueryGuildMembersForRecipe();
end

-----
-- New Category Dialog
-----
function MRTNewCategoryFrame_Cancel()
	MRTNewCategoryFrame:Hide();
end

function MRTNewCategoryFrame_Okay()
	local categoryName = MRTNewCategoryFrameCategoryName:GetText();

	if( categoryName == "" or categoryName == nil ) then
		return;
	end

	local tradeskillSpellID = MrTrader:MatchPartialCraftSkillName(GetTradeSkillLine());
	local favorites = MrTrader:GetFavoritesForSkill(tradeskillSpellID);
	
	if( favorites ~= nil and favorites[categoryName] == nil ) then
		MrTrader:AddFavoriteCategoryToSkill(tradeskillSpellID, categoryName);

		if( MRTNewCategoryFrame.referenceSkill ) then
			-- Set the reference skill up in the new category			
			local skillSpellID = MrTrader:GetSpellIDForRecipe(GetTradeSkillRecipeLink(MRTNewCategoryFrame.referenceSkill));
			MrTrader:AddFavoriteToSkill(tradeskillSpellID, categoryName, skillSpellID);
		end
	end
	
	MRTSkillWindow:PopulateFavoritesFilters();
	MRTSkillWindow:Update();
	MRTNewCategoryFrame:Hide();
end