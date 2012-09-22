-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

MRTSkillWindow = LibStub("AceAddon-3.0"):NewAddon("MrTrader_SkillWindow",
												  "AceBucket-3.0",
												  "AceEvent-3.0");

-- Constants
local MAX_TRADE_SKILL_REAGENTS = 8;
local TRADE_SKILL_TEXT_WIDTH = 275;
local TRADE_SKILL_MAX_BADGES = 3;
local TRADE_SKILL_LINKED_NAME_WIDTH = 120;
MRTRADER_TRADE_SKILL_HEIGHT = 42;
MRTRADER_TRADE_SKILL_FILTER_HEIGHT = 20;

local NUM_FILTERS_TO_DISPLAY = 22;
local TRADE_SKILLS_DISPLAYED = 10;

-- Coloring for trade skills
local TradeSkillTypeColor = { };
TradeSkillTypeColor["optimal"]	= { r = 1.00, g = 0.50, b = 0.25,	font = GameFontNormalLeftOrange };
TradeSkillTypeColor["medium"]	= { r = 1.00, g = 1.00, b = 0.00,	font = GameFontNormalLeftYellow };
TradeSkillTypeColor["easy"]		= { r = 0.25, g = 0.75, b = 0.25,	font = GameFontNormalLeftLightGreen };
TradeSkillTypeColor["trivial"]	= { r = 0.50, g = 0.50, b = 0.50,	font = GameFontNormalLeftGrey };
TradeSkillTypeColor["header"]	= { r = 1.00, g = 0.82, b = 0,		font = GameFontNormalLeft };

-- Colorblind Support
local TradeSkillTypePrefix = {
["optimal"] = " [+++] ",
["medium"] = " [++] ",
["easy"] = " [+] ",
["trivial"] = " ", 
["header"] = " ",
}

--UIPanelWindows["MRTSkillFrame"] =	{ area = "left", pushable = 3 };

local L = LibStub("AceLocale-3.0"):GetLocale("MrTrader", true);

-----
-- Functions
-----
function MRTSkillWindow:OnInitialize()
	-- Some structures that can be reused
	self:InitializeFilterTree();
	
	-- Tradeskill window events
	self:RegisterBucketEvent({"TRADE_SKILL_UPDATE"}, 0.01, "Update"); -- This needs to remain in a bucket, hangs client otherwise. (Why???)
	self:RegisterEvent("TRADE_SKILL_FILTER_UPDATE", "UpdateFilters");
	self:RegisterEvent("TRADE_SKILL_CLOSE", "Close");
	self:RegisterEvent("UPDATE_TRADESKILL_RECAST", "UpdateRecast");
	self:RegisterEvent("GUILD_RECIPE_KNOWN_BY_MEMBERS", "GuildQueryResult");
end

function MRTSkillWindow:Show()
	-- Make sure we dump the old tradeskill filter index.
	if( self.tradeskillID ) then
		self:StoreSettings();
	end
	
	-- Set the skillname, required to handle the original UI update.
	self.tradeskillName = GetTradeSkillLine();
	self.tradeskillID = MrTrader:MatchPartialCraftSkillName(self.tradeskillName, true);
	self.tradeskillHasLink = GetTradeSkillListLink() ~= nil;
	if( CURRENT_TRADESKILL ~= nil ) then
	    CURRENT_TRADESKILL = self.tradeskillName;
	end

	-- Handle some stuff that should only be done once on show
	self:HandleMovable();
	self:DrawHeaderOnShow();
	
	-- Set the portrait
	if ( IsTradeSkillGuild() ) then
		MRTSkillFramePortrait:Hide();
		MRTSkillFrameTabardBackground:Show();
		MRTSkillFrameTabardEmblem:Show();
		MRTSkillFrameTabardBorder:Show();
		SetLargeGuildTabardTextures("player", MRTSkillFrameTabardEmblem, MRTSkillFrameTabardBackground, MRTSkillFrameTabardBorder);
	else
		MRTSkillFrameTabardBackground:Hide();
		MRTSkillFrameTabardEmblem:Hide();
		MRTSkillFrameTabardBorder:Hide();
		MRTSkillFramePortrait:Show();
		SetPortraitToTexture(MRTSkillFramePortrait, GetTradeSkillTexture());
	end
		
	FauxScrollFrame_SetOffset(MRTSkillListScrollFrame, 0);
	MRTSkillListScrollFrameScrollBar:SetMinMaxValues(0, 0); 
	MRTSkillListScrollFrameScrollBar:SetValue(0);
	
	MRTSkillWindow:SetSkillSelection(nil, 0);	
		
	MRTSkillFrameSearchBox:SetText(SEARCH);
	MRTSkillWindow_OnSearchTextChange(MRTSkillFrameSearchBox);
	
	-- Setup the filters
	self:RestoreSettings();
	self:SetCheckboxFilters();
	self:UpdateFilters();
	self:AdjustWindow();
	
	ShowUIPanel(MRTSkillFrame);
	MRTSkillWindow:Update();
	MRTAPI:CallInterface("TradeSkillWindowOnShow", self);	
end

function MRTSkillWindow:UpdateRecast()
	MRTSkillInputBox:SetNumber(GetTradeskillRepeatCount());
end

function MRTSkillWindow:Close()
	self:StoreSettings();
	self.tradeskillID = nil;

	HideUIPanel(MRTSkillFrame);
end

function MRTSkillWindow:StoreSettings()
	local sortId, sortAscending = self:GetSortSelection();
	
	MrTrader:StoreFilter(self.tradeskillID, self.filterCategory, self.filterSelection, self.checkboxFilters, self.isExpanded, sortId, sortAscending);
end

function MRTSkillWindow:RestoreSettings()
	local sortId, sortAscending;
	
	self.filterCategory, self.filterSelection, self.checkboxFilters, self.isExpanded, sortId, sortAscending = MrTrader:RestoreFilter(self.tradeskillID);
	if( sortId == nil ) then
		self:SetSortSelection("4a311662-eefc-469d-8f45-807d69e59f5a", true); -- Select "Sort by Name (Ascending)" as the default	
	else
		self:SetSortSelection(sortId, sortAscending);
	end
end

function MRTSkillWindow:HandleMovable()
	if( MrTrader:TradeskillWindowIsMovable() ) then
		UIPanelWindows["MRTSkillFrame"] = nil;
		tinsert(UISpecialFrames, "MRTSkillFrame"); -- Should allow escape to work when "Undocked"
		MRTSkillFrame:SetAttribute("UIPanelLayout-enabled", false);
		MRTSkillFrame:SetMovable(true);
		MRTSkillFrame:SetClampedToScreen(true);
		MrTrader:RestoreLocation("MRTSkillFrame", MRTSkillFrame);
	else
		MRTSkillFrame:SetMovable(false);
		UIPanelWindows["MRTSkillFrame"] = { area = "left", pushable = 3 };
	end	
end

function MRTSkillWindow:DrawHeaderOnShow()
	local format = TRADE_SKILL_TITLE;
	
	if( IsTradeSkillGuild() ) then
		format = GUILD_TRADE_SKILL_TITLE;
	end
	
	-- Title	
	MRTSkillFrameTitleText:SetFormattedText(format, self.tradeskillName);
	MRTSkillFrameTitleText:ClearAllPoints();
	MRTSkillFrameTitleText:SetPoint("TOP", 0,  -4);		
end

function MRTSkillWindow:DrawHeader()
	local _, rank, maxRank = GetTradeSkillLine();
	local linked, linkedName = IsTradeSkillLinked();
	local isGuild = IsTradeSkillGuild();

	-- Link Button	
	MRTSkillLinkButton:Hide();
	if ( linked ) then
		MRTSkillFrameTitleText:ClearAllPoints();
		if( linkedName ) then
			local linkedText = "["..linkedName.."]";
			MRTSkillLinkNameButton.linkedName = linkedName;
			
			local linkedNameWidth = MRTUIUtils_GetNormalStringWidth(linkedText);
			if linkedNameWidth > TRADE_SKILL_LINKED_NAME_WIDTH then
				linkedNameWidth = TRADE_SKILL_LINKED_NAME_WIDTH;
			end
		
			MRTSkillLinkNameButtonTitleText:SetText(linkedText);
			MRTSkillLinkNameButton:SetWidth(linkedNameWidth);
			MRTSkillLinkNameButton:Show();
			MRTSkillFrameTitleText:SetPoint("TOP", -linkedNameWidth/2,  -4);
		else
			MRTSkillLinkNameButton:Hide();	
			MRTSkillFrameTitleText:SetPoint("TOP", 0,  -4);		
		end
	elseif( not isGuild ) then
		if(GetTradeSkillListLink()) then
			MRTSkillLinkButton:Show();
		end
		MRTSkillLinkNameButton:Hide();
	else
		MRTSkillLinkNameButton:Hide();
	end

	-- Rank Bar
	MRTSkillRankFrame:SetStatusBarColor(1.0, 0.84, 0.0, 0.5);
	MRTSkillRankFrameBackground:SetVertexColor(0.0, 0.0, 0.2, 0.5);
	MRTSkillRankFrame:SetMinMaxValues(0, maxRank);
	MRTSkillRankFrame:SetValue(rank);
	MRTSkillRankFrameSkillRank:SetText(rank.."/"..maxRank);
	
	-- Search Bar
	MRTSkillFrameSearchBox:Show();
	
	-- Sort Filter
	UIDropDownMenu_Initialize(MRTSkillFrameSortDropDown, function() self:InitializeSortingDropDown() end);
	UIDropDownMenu_SetText(MRTSkillFrameSortDropDown, self:GetSortSelectionString());
	UIDropDownMenu_SetWidth(MRTSkillFrameSortDropDown, 172);
end

function MRTSkillWindow:UpdateFilters()
	self:PopulateCoreFilterTree();
	self:PopulateFavoritesFilters();
	
	if( MRTSkillWindow.filterCategory ~= nil ) then
		local filterCategory = nil;
		local filterSelection = nil;
	
		for i=1, #(self.filterTree) do
			if( self.filterCategory.title == self.filterTree[i].title and
				self.filterCategory.filterIndex == self.filterTree[i].filterIndex ) then
				filterCategory = self.filterTree[i];
				if( filterCategory.filterType ~= nil ) then
					filterSelection = self.filterTree[i];
				end
				
				if( self.filterSelection ~= nil ) then
					for j=1, getn(filterCategory.subgroups) do
						if( filterCategory.subgroups[j].title == self.filterSelection.title and
							filterCategory.subgroups[j].filterIndex == self.filterSelection.filterIndex ) then
							filterSelection = filterCategory.subgroups[j];
							break;
						end
					end
				end
				break;
			end
		end
		
		self.filterCategory = filterCategory;
		self.filterSelection = filterSelection;
	end
	
	if( self.filterCategory == nil ) then 
		self.filterCategory = self.defaultFilter;
		self.filterSelection = self.defaultFilter;
	end
	
	self:DrawFilters(); -- Should be self:DrawFilters();	
	self:UpdateFilter(); -- Should be self:SelectFilter()?
end

function MRTSkillWindow:InitializeFilterTree()
	self.filterTree = {};
	self.checkboxFilters = {};
	
	-- Checkbox Items (Unselectable)
	self.filterTree[#self.filterTree+1] = {
		title = CRAFT_IS_MAKEABLE,
		filterType = "checkbox",
		filterIndex = "TradeSkillOnlyShowMakeable",
		filterHandler = function(newState) TradeSkillOnlyShowMakeable(newState) end,
		subgroups = {},
	};
	
	self.filterTree[#self.filterTree+1] = {
		title = TRADESKILL_FILTER_HAS_SKILL_UP,
		filterType = "checkbox",
		filterIndex = "TradeSkillOnlyShowSkillUps",
		filterHandler = function(newState) TradeSkillOnlyShowSkillUps(newState) end,
		subgroups = {},
	};
	
	-- Core Items
	self.filterTree[#self.filterTree+1] = {
		title = MRTLoc["All Items"],
		filterType = "all",
		subgroups = {},
	};
	self.defaultFilter = self.filterTree[#self.filterTree];
	self.filterTree[#self.filterTree+1] = {
		title = MRTLoc["Categories"],
		subgroups = {},		
	};
	self.categoryFilterTree = self.filterTree[#self.filterTree];
	self.filterTree[#self.filterTree+1] = {
		title = MRTLoc["Inventory Slots"],
		subgroups = {},		
	};
	self.inventoryFilterTree = self.filterTree[#self.filterTree];
	
	-- Difficulty
	self.filterTree[#self.filterTree+1] = {
		title = MRTLoc["Difficulty"],
		subgroups = {},		
	};
	local parent = self.filterTree[#self.filterTree];
	parent.subgroups[#parent.subgroups+1] = {
			title = MRTLoc["Optimal"],
			filterType = "difficulty",
			filterIndex = "optimal",
		};
	parent.subgroups[#parent.subgroups+1] = {
			title = MRTLoc["Medium"],
			filterType = "difficulty",
			filterIndex = "medium",
		};
	parent.subgroups[#parent.subgroups+1] = {
			title = MRTLoc["Easy"],
			filterType = "difficulty",
			filterIndex = "easy",
		};
	parent.subgroups[#parent.subgroups+1] = {
			title = MRTLoc["Trivial"],
			filterType = "difficulty",
			filterIndex = "trivial",
		};
	
	-- Filters
	self.filterTree[#self.filterTree+1] = {
		title = MRTLoc["Favorites"],
		filterType = "favorite",
		filterIndex = "__all",
		subgroups = {},
	};
	self.favoriteFilterTree = self.filterTree[#self.filterTree];
	
	self.filterTree[#self.filterTree+1] = {
		title = MRTLoc["New Favorite Group"],
		filterType = "command",
		filterIcon = "Interface\\BUTTONS\\UI-PlusButton-Up",
		filterHandler = function() MRTNewCategoryFrame.referenceSkill = nil; MRTNewCategoryFrame:Show(); end,
	};
end

function MRTSkillWindow:PopulateCoreFilterTree()
	wipe(self.categoryFilterTree.subgroups);
	wipe(self.inventoryFilterTree.subgroups);
	
	local groups = {GetTradeSkillSubClasses()};
	local i = 1;
	for index,group in pairs(groups) do
		self.categoryFilterTree.subgroups[i] = {
			title = group,
			filterType = "category",
			filterIndex = index,
		};
		i = i + 1;
	end
	
	if(#groups == 0) then
		self.categoryFilterTree.title = MRTLoc["Categories"] .. " [" .. MRTLoc["Loading"] .. "]";
	else
		self.categoryFilterTree.title = MRTLoc["Categories"];
	end
	
	groups = {GetTradeSkillInvSlots()};
	numGroups = #groups;
	for i=1, numGroups do
		self.inventoryFilterTree.subgroups[i] = {
			title = groups[i],
			filterType = "invslot",
			filterIndex = i,
		};
	end
	
	if(numGroups == 0) then
		self.inventoryFilterTree.title = MRTLoc["Inventory Slots"] .. " [" .. MRTLoc["Loading"] .. "]";
	else
		self.inventoryFilterTree.title = MRTLoc["Inventory Slots"];
	end
end

function MRTSkillWindow:PopulateFavoritesFilters()	
	wipe(self.favoriteFilterTree.subgroups);
	
	local favorites = MrTrader:GetFavoritesForSkill(self.tradeskillID);
	if( favorites and MrTrader:TableSize(favorites) > 0 ) then
		for categoryName, _ in pairs(favorites) do
			self.favoriteFilterTree.subgroups[#self.favoriteFilterTree.subgroups+1] = {
				title = categoryName,
				filterType = "favorite",
				filterIndex = categoryName,
			};
		end
	end
end

function MRTSkillWindow:SetCheckboxFilters()
	for _, filter in pairs(self.filterTree) do
		if( filter.filterType == "checkbox" ) then
			filter.filterHandler(self.checkboxFilters[filter.filterIndex] or false);
		end
	end
end

function MRTSkillWindow:SelectFilter(filter, filterButton)
	if( filter == nil ) then
		return;
	end
	
	if( filter.filterType == "command" ) then
		filter.filterHandler();
	elseif( filter.filterType == "checkbox" ) then
		local checkbox = _G[filterButton:GetName() .. "Checkbox"];
		local isChecked = checkbox:GetChecked(); -- Checkbox is flipped for us.

		self.checkboxFilters[filter.filterIndex] = isChecked;
		filter.filterHandler(isChecked);
		checkbox:SetChecked(isChecked);
		return;
	end
	
	self.filterSelection = nil;
	-- Close everything up if they clicked on the filter category.
	if( filter == self.filterCategory ) then
		self.filterCategory = nil;
	else
		if( filter.subgroups ~= nil ) then
			self.filterCategory = filter;
		end

		if( filter.filterType ~= nil ) then
			self.filterSelection = filter;
		end

		MRTSkillWindow:UpdateFilter();
	end
		
	MRTSkillWindow:SetSkillSelection(nil, 0);
	MRTSkillWindow:DrawFilters();
	MRTSkillWindow:Update();
end

function MRTSkillWindow:SelectSkill(skill, button)
	-- Do something here... maybe
	if ( button == "LeftButton" ) then
		MRTSkillWindow:SetSkillSelection(skill, skill:GetID());
		MRTSkillWindow:Update();
	elseif ( button == "RightButton" ) then
		MRTSkillContext:DisplaySkillContext(MRTSkillItemDropDown, skill:GetID());
	end
end

function MRTSkillWindow:SetSkillSelection(skillButton, skillID)
	MRTSkillWindow.selectedSkillButton = skillButton;
	MRTSkillWindow.selectedSkill = skillID;
	
	if ( MRTSkillWindow.selectedSkill > GetNumTradeSkills() ) then
		return;
	end

	-- Hide inappropriate controls when no skill is selected
	if ( MRTSkillWindow.selectedSkill == 0 ) then
		MRTSkillCreateButton:Hide();
		MRTSkillCreateAllButton:Hide();
		MRTSkillDecrementButton:Hide();
		MRTSkillInputBox:Hide();
		MRTSkillIncrementButton:Hide();
		MRTSkillViewCraftersButton:Hide();
		return;
	end
	
	SelectTradeSkill(skillID);
	local skillName, skillType, numAvailable, isExpanded, altVerb = GetTradeSkillInfo(skillID);
	local craftable = 1;
	if( not skillName ) then
		craftable = nil;
	end
	
	local color = TradeSkillTypeColor[skillType];
	if ( color ) then
		MRTSkillHighlight:SetVertexColor(color.r, color.g, color.b);
	end
	
	-- Reset the number of items to be created
	MRTSkillInputBox:SetNumber(GetTradeskillRepeatCount());
	
	--Hide inapplicable buttons if we are inspecting. Otherwise show them
	if ( IsTradeSkillGuild() ) then
		MRTSkillCreateButton:Hide();
		MRTSkillCreateAllButton:Hide();
		MRTSkillDecrementButton:Hide();
		MRTSkillInputBox:Hide();
		MRTSkillIncrementButton:Hide();
		MRTSkillViewCraftersButton:Show();
	elseif ( IsTradeSkillLinked() ) then
		MRTSkillCreateButton:Hide();
		MRTSkillCreateAllButton:Hide();
		MRTSkillDecrementButton:Hide();
		MRTSkillInputBox:Hide();
		MRTSkillIncrementButton:Hide();
		MRTSkillViewCraftersButton:Hide();
	else
		--Change button names and show/hide them depending on if this tradeskill creates an item or casts something
		if ( not altVerb ) then
			--Its an item with 'Create'
			MRTSkillCreateAllButton:Show();
			MRTSkillDecrementButton:Show();
			MRTSkillInputBox:Show();
			MRTSkillIncrementButton:Show();
		else
			--Its something else
			MRTSkillCreateAllButton:Hide();
			MRTSkillDecrementButton:Hide();
			MRTSkillInputBox:Hide();
			MRTSkillIncrementButton:Hide();
		end
		
		MRTSkillViewCraftersButton:Hide();
		MRTSkillCreateButton:SetText(altVerb or CREATE_PROFESSION);
		MRTSkillCreateButton:Show();
    end

	MRTSkillWindow.numAvailable = numAvailable;
end

function MRTSkillWindow:Update()		
	if( not MrTrader:ShouldUseCustomWindow() ) then
		return;
	end
	
	-- Update Display
	MRTSkillWindow:UpdateFilters();
	MRTSkillWindow:DrawHeader();
	MRTSkillWindow:DrawSkillList();
	MRTSkillWindow:SetSkillSelection(MRTSkillWindow.selectedSkillButton, MRTSkillWindow.selectedSkill or 0);
end

function MRTSkillWindow:UpdateFilter() 
	local subclassFilter = 0;
	local invslotFilter = 0;

	if( self.filterSelection ~= nil ) then
		if( self.filterSelection.filterType == "invslot" ) then
			invslotFilter = MRTSkillWindow.filterSelection.filterIndex;
		elseif( self.filterSelection.filterType == "category" ) then
			subclassFilter = MRTSkillWindow.filterSelection.filterIndex;
		end
	end

	SetTradeSkillCategoryFilter(subclassFilter, 0);
	SetTradeSkillInvSlotFilter(invslotFilter, 1, 1);
end

function MRTSkillWindow:DrawFilters()
	if(MRTSkillWindow.filterTree == nil) then
		return;
	end
	
	-- Initialize the list of open filters
	OPEN_FILTER_LIST = {};

	local numGroups = #(self.filterTree);
	for i=1, numGroups do
		local item = MRTSkillWindow.filterTree[i];
		if( MRTSkillWindow.filterCategory == item ) then
			tinsert(OPEN_FILTER_LIST, {item.title, "class", item, true});
			local numSubgroups = #(item.subgroups);
			for j=1, numSubgroups do
				local subgroup = item.subgroups[j];
				if( MRTSkillWindow.filterSelection == subgroup ) then
					tinsert(OPEN_FILTER_LIST, {subgroup.title, "subclass", subgroup, true});			
				else
					tinsert(OPEN_FILTER_LIST, {subgroup.title, "subclass", subgroup, nil});							
				end
			end
		else
			if ( item.filterType == "checkbox" ) then
				tinsert(OPEN_FILTER_LIST, {item.title, "checkbox", item, nil, item.filterIndex});
			elseif ( item.filterType == "command" ) then
				tinsert(OPEN_FILTER_LIST, {item.title, "command", item, nil});			
			else
				tinsert(OPEN_FILTER_LIST, {item.title, "class", item, nil});			
			end
		end
	end
	
	-- ScrollFrame update
	FauxScrollFrame_Update(MRTSkillFilterScrollFrame, getn(OPEN_FILTER_LIST), NUM_FILTERS_TO_DISPLAY, MRTRADER_TRADE_SKILL_FILTER_HEIGHT);
	local filterIndex = FauxScrollFrame_GetOffset(MRTSkillFilterScrollFrame) ;
	
	-- Display the list of open filters
	local button, index, info, isLast;
	index = FauxScrollFrame_GetOffset(MRTSkillFilterScrollFrame);
	for i=1, NUM_FILTERS_TO_DISPLAY do
		button = _G["MRTSkillFilterButton"..i];
		if ( getn(OPEN_FILTER_LIST) > NUM_FILTERS_TO_DISPLAY ) then
			button:SetWidth(134);
		else
			button:SetWidth(156);
		end

		index = index + 1;
		if ( index <= getn(OPEN_FILTER_LIST) ) then
			info = OPEN_FILTER_LIST[index];
			if ( info ) then
				MRTUIUtils_FilterButton_SetType(button, info[2], info[1], self.checkboxFilters[info[5]], info[3].filterHandler, info[3].filterIcon);
				button.filterRef = info[3];
				if ( info[4] ) then
					button:LockHighlight();
				else
					button:UnlockHighlight();
				end
				button:Show();
			end
		else
			button:Hide();
		end
	end
end

function MRTSkillWindow:SkillIsInFavorite(favorites, favoriteIndex, skill)
	for categoryName, categorySkills in pairs(favorites) do
		if( favorites[categoryName][skill.skillSpell] and
			(favoriteIndex == "__all" or categoryName == favoriteIndex) ) then
			return true;
		end
	end
end

function MRTSkillWindow:GuildQueryResult()
	if ( MRTSkillGuildFrame.queriedSkill == self.selectedSkill ) then
		MRTSkillGuildFrame:Show();
	end
end

function MRTSkillWindow:ReadSkillList()
	local result = {};
	local favorites = MrTrader:GetFavoritesForSkill(self.tradeskillID);

	-- Iterate through the filtered list and sort
	local serverCount = GetNumTradeSkills();
	for i=1, serverCount do
		local skill = self:ReadCoreSkillItem(i, nil);
		if( skill.skillType ~= "header" and skill.skillType ~= "subheader" ) then
			if( self.filterSelection ~= nil ) then
				if( self.filterSelection.filterType == "difficulty" and
					self.filterSelection.filterIndex ~= skill.skillType ) then
					skill = nil;
				elseif( self.filterSelection.filterType == "favorite" and
						not self:SkillIsInFavorite(favorites, self.filterSelection.filterIndex, skill) ) then
					skill = nil;
				end
			end
			
			if(skill ~= nil) then
				skill = self:ReadSkillItem(skill.id, skill);
				result[#result+1] = skill;
			end
		end
	end

	return result;
end

function MRTSkillWindow:ReadCoreSkillItem(skillIndex, table)
	local result = table;
	if( result == nil ) then
		result = {};
	end
	
	-- Basic Information
	result.id = skillIndex;
	result.skillName, result.skillType, result.numAvailable, result.isExpanded, result.altVerb, result.numSkillUps = GetTradeSkillInfo(skillIndex);
	if( result.skillType ~= "header" and result.skillType ~= "subheader" ) then
		result.skillLink = GetTradeSkillRecipeLink(skillIndex);
		result.skillSpell = MrTrader:GetSpellIDForRecipe(result.skillLink or "");
	end
	
	return result;
end

function MRTSkillWindow:ReadSkillItem(skillIndex, table)
	local result = table;
	if( result == nil ) then
		result = {};
	end
	
	-- Icon
	result.skillTexture = GetTradeSkillIcon(skillIndex);
	
	-- Tools and Cooldown
	result.skillCooldown = GetTradeSkillCooldown(skillIndex);
	result.skillTools = MrTrader:TablePairPack(GetTradeSkillTools(skillIndex));
	
	-- Number Made
	result.minMade, result.maxMade = GetTradeSkillNumMade(skillIndex);
	
	-- Item Information
	result.itemLink = GetTradeSkillItemLink(skillIndex);
	result.itemName, result.itemLink, result.itemRarity, result.itemLevel, result.itemMinLevel, _, _, result.itemStackCount, _, _, result.itemSellPrice = GetItemInfo(result.itemLink);
	
	return result;
end

function MRTSkillWindow:ReadSkillItemReagents(skillIndex, table)
	local result = table;
	if( result == nil ) then
		result = {};
	end
	
	-- Reagents
	local reagentCount = GetTradeSkillNumReagents(skillIndex);
	result.reagents = {};
	for i=1, reagentCount do
		local reagent = {};
		
		reagent.name, reagent.texture, reagent.count, reagent.playerCount = GetTradeSkillReagentInfo(skillIndex, i);
		local itemLink = GetTradeSkillReagentItemLink(skillIndex, i);
		if( itemLink ~= nil ) then
		    reagent.itemName, reagent.itemLink, reagent.itemRarity, _, _, _, _, reagent.itemStackCount, _, _, reagent.itemSellPrice = GetItemInfo(GetTradeSkillReagentItemLink(skillIndex, i));
		end
		
		if( reagent.name ~= nil ) then
			result.reagents[#result.reagents+1] = reagent;
		end
	end
	
	return result;
end

function MRTSkillWindow:UpdateInfoLines(infoLines, plugins, skillObj)
	local lineCount = #(infoLines);
	local pluginCount = #(plugins);

	local itemStrings = {};
	for i=1,pluginCount do
		local result = plugins[i].interfaces.TradeSkillWindowInfoLine(skillObj);
		if(result ~= nil) then
			tinsert(itemStrings, result);
		end
	end
	
	for i=1,lineCount do
		if(itemStrings[i] ~= nil) then
			infoLines[i]:SetText(itemStrings[i]);
		else
			infoLines[i]:SetText("");
		end
	end
end

function MRTSkillWindow:DrawBadges(badges, relativeObject, skillObj)
	local plugins = MRTAPI:PluginsForInterface("TradeSkillWindowInfoBadge");
	local badgeCount = 1;

	badges[1]:ClearAllPoints();
	if( relativeObject == nil ) then
		badges[1]:SetPoint("TOPRIGHT", badges[1]:GetParent(), "TOPRIGHT", -1, -6);
	else
		badges[1]:SetPoint("TOPRIGHT", relativeObject, "TOPLEFT", -1, 0);
	end

	for _, plugin in ipairs(plugins) do
		if( badgeCount > TRADE_SKILL_MAX_BADGES ) then break; end;
		local textureName, count, clickHandler = plugin.interfaces.TradeSkillWindowInfoBadge(skillObj);
		local badgeName = badges[badgeCount]:GetName();
		
		if( textureName ~= nil ) then 
			badges[badgeCount]:Show(); 
			badgeCount = badgeCount + 1;
			badges[badgeCount]:SetID(skillObj.id);
			_G[badgeName.."Icon"]:SetTexture(textureName);
			if( count ~= nil ) then  
				_G[badgeName.."Count"]:SetText(count);
			else
				_G[badgeName.."Count"]:SetText("");
			end
			if( clickHandler ~= nil ) then
				-- Do something here...
			else
				-- Do something here...
			end
		end
	end
	
	for i=badgeCount,TRADE_SKILL_MAX_BADGES do
		badges[badgeCount]:Hide();
		badgeCount = badgeCount + 1;
	end
end

function MRTSkillWindow:DrawSkillList()
	local skillList = self:ReadSkillList();
	if( skillList == nil ) then
		return;
	end
	
	table.sort(skillList, function(a,b) return MRTSkillWindow.skillWindowSort(a,b,MRTSkillWindow.skillWindowSortAscending); end);
	-- table.sort(skillList, MRTSorting.sorts[self.skillWindowSort].handler);
	
	local numTradeSkills = #(skillList);

	-- If we have no filter of any kind, then we need to empty the skill list
	if( MRTSkillWindow.filterSelection == nil ) then
		numTradeSkills = 0;
	end

	-- ScrollFrame update
	FauxScrollFrame_Update(MRTSkillListScrollFrame, numTradeSkills, TRADE_SKILLS_DISPLAYED, MRTRADER_TRADE_SKILL_HEIGHT, nil, nil, nil, MRTSkillHighlightFrame, 293, 316 );
	local skillIndex = FauxScrollFrame_GetOffset(MRTSkillListScrollFrame);
	local skillHighlighted = false;
	
	for i=1, TRADE_SKILLS_DISPLAYED do
		skillIndex = skillIndex + 1;
			
		skillButton = _G["MRTSkillButton"..i];
		skillButtonText = _G["MRTSkillButton"..i.."NameText"];

		if( skillIndex <= numTradeSkills ) then
		    local skillObj = MRTSkillWindow:ReadSkillItemReagents(skillList[skillIndex].id, skillList[skillIndex]);
			skillButton:SetID(skillObj.id);
					
			if ( numTradeSkills > TRADE_SKILLS_DISPLAYED ) then	
				skillButton:SetWidth(440);
			else
				skillButton:SetWidth(464);
			end
			
			-- Icon and Number Made
			skillButtonIcon = _G["MRTSkillButton"..i.."Icon"];
			skillButtonIconCount = _G["MRTSkillButton"..i.."IconCount"];
			skillButtonIcon:SetNormalTexture(GetTradeSkillIcon(skillObj.id));
			skillButtonIcon:GetNormalTexture():SetTexCoord( 0.075, 0.925, 0.075, 0.925 );
			skillButtonIcon:SetID(skillObj.id);
			if ( skillObj.maxMade > 1 ) then
				if ( skillObj.minMade == skillObj.maxMade ) then
					skillButtonIconCount:SetText(skillObj.minMade);
				else
					skillButtonIconCount:SetText(skillObj.minMade .. "-" .. skillObj.maxMade);
				end
				if ( skillButtonIconCount:GetWidth() > 39 ) then
					skillButtonIconCount:SetText("~"..floor((skillObj.minMade + skillObj.maxMade)/2));
				end
			else
				skillButtonIconCount:SetText("");
			end
			
			_G["MRTSkillButton"..i.."Border"]:SetBackdropBorderColor(0.5, 0.5, 0.5);
			_G["MRTSkillButton"..i.."IconBorder"]:SetBackdropBorderColor(GetItemQualityColor(skillObj.itemRarity or 0));
			
			-- Information Lines
			local infoLines = { _G["MRTSkillButton"..i.."InfoLine1"], _G["MRTSkillButton"..i.."InfoLine2"] };
			local badges = { _G["MRTSkillButton"..i.."Badge1"], _G["MRTSkillButton"..i.."Badge2"], _G["MRTSkillButton"..i.."Badge3"], };
			local plugins = MRTAPI:PluginsForInterface("TradeSkillWindowInfoLine"); -- { MRTToolsAndCooldown, MRTProfit };
			
			MRTSkillWindow:UpdateInfoLines(infoLines, plugins, skillObj);
			
			-- Reagents
			for j=1, 4, 1 do
				_G["MRTSkillButton"..i.."ReagentLrg"..j]:Hide();
			end
			for j=1, 8, 1 do
				_G["MRTSkillButton"..i.."ReagentSml"..j]:Hide();
			end
			
			local numReagents = getn(skillObj.reagents);
			local numSlots, slotName, startIndex;
			if ( numReagents > 4 ) then
				numSlots = 8;
				slotName = "ReagentSml";
				startIndex = 1;
			else
				numSlots = 4;
				slotName = "ReagentLrg";
				startIndex = (numSlots - numReagents) + 1;
			end
			
			self:DrawBadges(badges, _G["MRTSkillButton"..i..slotName..startIndex], skillObj);
			
			for j=startIndex, numSlots, 1 do
				local idNum = (j - startIndex) + 1;
				local reagentInfo = skillObj.reagents[idNum];
				local reagent = _G["MRTSkillButton"..i..slotName..j];
				local reagentIcon = _G["MRTSkillButton"..i..slotName..j.."IconTexture"];
				local count = _G["MRTSkillButton"..i..slotName..j.."Count"];
				
				if ( not reagentInfo or not reagentInfo.name or not reagentInfo.texture ) then
					reagent:Hide();
				else
					reagent:Show();
					reagent:SetID(idNum);
					reagentIcon:SetTexture(reagentInfo.texture);
					reagentIcon:SetTexCoord( 0.075, 0.925, 0.075, 0.925 );
					-- Grayout items
					if ( reagentInfo.playerCount < reagentInfo.count ) then
						SetItemButtonTextureVertexColor(reagent, 0.5, 0.5, 0.5);
					else
						SetItemButtonTextureVertexColor(reagent, 1.0, 1.0, 1.0);
					end
					if ( reagentInfo.playerCount >= 100 ) then
						playerReagentCount = "*";
					end
					if( slotName == "ReagentSml" ) then
						count:SetText(reagentInfo.count);
					else
						count:SetText(reagentInfo.playerCount.." /"..reagentInfo.count);
						reagent:SetBackdropBorderColor(GetItemQualityColor(reagentInfo.itemRarity or 0));
					end
				end
			end
			
			local color = TradeSkillTypeColor[skillObj.skillType];
			if( color ) then
				skillButtonText:SetTextColor(color.r, color.g, color.b);
			end
			
			local skillNamePrefix = "";
			local skillNameSuffix = "";
			if ( ENABLE_COLORBLIND_MODE == "1" ) then
				skillNamePrefix = TradeSkillTypePrefix[skillObj.skillType] or " ";
			end
			
			skillButton:Show();
			skillButton:SetNormalTexture("");
			
			local skillText = skillNamePrefix..skillObj.skillName..skillNameSuffix;
			if( skillObj.numAvailable > 0 ) then
				skillText = skillText .." ["..skillObj.numAvailable.."]";
			end
			skillButtonText:SetText(skillText);
			
			-- Place the highlight and lock the highlight state
			if ( MRTSkillWindow.selectedSkill == skillObj.id ) then
				MRTSkillHighlightFrame:SetPoint("TOPLEFT", "MRTSkillButton"..i.."Border", "TOPLEFT", 2, -1);
				MRTSkillHighlightFrame:SetWidth(_G["MRTSkillButton"..i.."Border"]:GetWidth() - 3);
				MRTSkillHighlightFrame:SetHeight(_G["MRTSkillButton"..i.."Border"]:GetHeight() - 2);
				MRTSkillHighlightFrame:Show();
				skillButtonText:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				skillButton:LockHighlight();
				skillButton.isHighlighted = true;
				skillHighlighted = true;
			else
				skillButton:UnlockHighlight();
				skillButton.isHighlighted = false;
			end
		else
			skillButton:Hide();
		end
	end
	
	if( skillHighlighted == false ) then
		MRTSkillHighlightFrame:Hide();
	end
end

function MRTSkillWindow:ToggleExpanded()
	self.isExpanded = not self.isExpanded;

	self:AdjustWindow();
end

function MRTSkillWindow:AdjustWindow()
	local maxWidth = 648;
	local minWidth = maxWidth - 164;
	local iconName = "PrevPage";
	local width = minWidth;
	
	if(self.isExpanded) then
		iconName = "NextPage";
		width = maxWidth;
		MRTSkillFilterButtons:Show();
	else
		MRTSkillFilterButtons:Hide();
	end
	
	MRTSkillFrame:SetWidth(width);
	MRTSkillFrameFilterExpandButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-" .. iconName .. "-Up");
	MRTSkillFrameFilterExpandButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-" .. iconName .. "-Down");
	MRTSkillFrameFilterExpandButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-" .. iconName .. "-Disabled");	
end