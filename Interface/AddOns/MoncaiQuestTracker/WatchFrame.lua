local ML = LibStub("MoncaiLib");
local MQT = LibStub("AceAddon-3.0"):GetAddon("MoncaiQuestTracker");

local WF = MQT:NewModule("MQT_WatchFrame");
WF.fun = {};
local fun = WF.fun;
_G["WF"] = WF

local function brightenColor(rgb)
	local rgbh = {};
	local d = 0.3;
	rgbh.r, rgbh.g, rgbh.b = rgb.r + d, rgb.g + d, rgb.b + d;
	if rgbh.r > 1.0 then rgbh.r = 1.0 end
	if rgbh.g > 1.0 then rgbh.g = 1.0 end
	if rgbh.b > 1.0 then rgbh.b = 1.0 end
	
	return rgbh;
end

--------------------------------------------------------------------------------------------------------
--
-- Almost useless replication here
--
--------------------------------------------------------------------------------------------------------

local DASH_NONE = 0;
local DASH_SHOW = 1;
local DASH_HIDE = 2;
local DASH_WIDTH;
local DASH_ICON_WIDTH = 20;
local IS_HEADER = true;

local WATCHFRAME_SETLINES = { };			-- buffer to hold lines for a quest/achievement that will be displayed only if there is room
local WATCHFRAME_SETLINES_NUMLINES = 0;		-- the number of visual lines to be rendered for the buffered data - used just for item wrapping right now 

local watchFrameTestLine;

MQT_Buttons = {}

local watchButtonIndex = 1;
local function WatchFrame_GetLinkButton ()
	local button = nil
	
	while button == nil do
		button = WATCHFRAME_LINKBUTTONS[watchButtonIndex]
		if ( not button ) then
			WATCHFRAME_LINKBUTTONS[watchButtonIndex] = WatchFrame.buttonCache:GetFrame();
			button = WATCHFRAME_LINKBUTTONS[watchButtonIndex];
		elseif ( not button.MQT ) then
			button = nil -- skip unowned buttons
			watchButtonIndex = watchButtonIndex + 1
		end
	end

	--MOD
	button.watchButtonIndex = watchButtonIndex		
	button.MQT = true; -- mark as locally known linkbutton
	-- EMOD

	watchButtonIndex = watchButtonIndex + 1;
	
	-- Debug
	MQT_Buttons[watchButtonIndex] = button
	-- scrub button here? maybe scrub all buttons in button cache...
	
	return button;
end

local function scrub(button, i)
	if button and not button.MQT then -- Release buttons we don't manage.
		--Print("Hiding unmanaged button " .. i);
		button.type = nil
		button.index = nil		
		button:Hide()
--		if i > 30 then -- allow up to 30 buttons at once
			--Print("Destroying unmanaged button #" .. i);
			button.frameCache:ReleaseFrame(button)
			return true
--		end
	end
	return false
end

local function WatchFrame_ResetLinkButtons ()
	watchButtonIndex = 1;

	--MOD
	--Print("Resetting link buttons...");
	for i, watchButton in pairs(WATCHFRAME_LINKBUTTONS) do
		if scrub(watchButton, i) then
			WATCHFRAME_LINKBUTTONS[i] = nil
		end
	end

--~ 	local i = 1;
--~ 	local button = _G["WatchFrameLinkButton" .. i];
--~ 	while button ~= nil do
--~ 		scrub(button, i)
--~ 		i = i + 1
--~ 		button = _G["WatchFrameLinkButton" .. i];
--~ 	end

	wipe(MQT_Buttons)
	--EMOD
	
end

local function WatchFrame_ReleaseUnusedLinkButtons ()
	local watchButton
	for i, watchButton in pairs(WATCHFRAME_LINKBUTTONS) do
		-- watchButton = WATCHFRAME_LINKBUTTONS[i];
		if watchButton and watchButton.MQT and i >= watchButtonIndex then
			watchButton.type = nil
			watchButton.index = nil;
			watchButton.MQT = nil;
			watchButton:Hide();
			watchButton.frameCache:ReleaseFrame(watchButton);
			WATCHFRAME_LINKBUTTONS[i] = nil;
		end
	end
end

local questLineIndex = 1;
local function WatchFrame_GetQuestLine ()
	local line = WATCHFRAME_QUESTLINES[questLineIndex];
	if ( not line ) then
		WATCHFRAME_QUESTLINES[questLineIndex] = WatchFrame.lineCache:GetFrame();
		line = WATCHFRAME_QUESTLINES[questLineIndex];
	end

	line:Reset();
	questLineIndex = questLineIndex + 1;
	return line;
end

local function WatchFrame_ResetQuestLines ()
	questLineIndex = 1;
end

local function WatchFrame_ReleaseUnusedQuestLines ()
	local line
	for i = questLineIndex, #WATCHFRAME_QUESTLINES do
		line = WATCHFRAME_QUESTLINES[i];
		if line then
			line:Hide();
			line.rgb = nil
			line.frameCache:ReleaseFrame(line);
			WATCHFRAME_QUESTLINES[i] = nil;
		end
	end
end

function WatchFrame_ReverseQuestObjective(text)
	local _, _, arg1, arg2 = string.find(text, "(.*):%s(.*)");
	if ( arg1 and arg2 ) then
		return arg2.." "..arg1;
	else
		return text;
	end
end


--------------------------------------------------------------------------------------------------------
--
-- Overridden functions
--
--------------------------------------------------------------------------------------------------------

function fun.WatchFrame_Collapse (self)
	self.collapsed = true;
	self:SetWidth(WATCHFRAME_COLLAPSEDWIDTH);
	WatchFrameLines:Hide();
	local button = WatchFrameCollapseExpandButton;
	local texture = button:GetNormalTexture();
	texture:SetTexCoord(0, 0.5, 0, 0.5);
	texture = button:GetPushedTexture();	
	texture:SetTexCoord(0.5, 1, 0, 0.5);
	
	if MQT.db.profile.float then -- MOD
		MQT.floater.wantedheight = 42
		self:SetHeight(42)
		MQT.floater:moved()
		--WatchFrame_Update(self)
	end -- EMOD
end

function fun.WatchFrameLinkButtonTemplate_Highlight(self, onEnter)
	local line;
	for index = self.startLine, self.lastLine do
		line = self.lines[index];
		if ( line ) then
			if ( index == self.startLine ) then
				-- header
				if line.rgb and MQT.db.profile.colortitle then
					if (onEnter) then
						line.text:SetTextColor(line.rgbh.r, line.rgbh.g, line.rgbh.b);						
					else
						line.text:SetTextColor(line.rgb.r, line.rgb.g, line.rgb.b);
					end
				else
					if ( onEnter ) then
						line.text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
					else
						line.text:SetTextColor(0.75, 0.61, 0);
					end
				end
			else
				if ( onEnter ) then
					if (line.text.eligible) then
						line.text:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
					else
						line.text:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
					end
					line.dash:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				else
					if (line.text.eligible) then
						line.text:SetTextColor(0.8, 0.8, 0.8);
					else
						line.text:SetTextColor(DIM_RED_FONT_COLOR.r, DIM_RED_FONT_COLOR.g, DIM_RED_FONT_COLOR.b);
					end
					line.dash:SetTextColor(0.8, 0.8, 0.8);
				end
			end
		end
	end
end


function fun.WatchFrame_Update (self, twice)
	self = self or WatchFrame; -- Speeds things up if we pass in this reference when we can conveniently.
	-- Display things in this order: quest timers, achievements, quests, addon subscriptions.
	if ( self.updating ) then
		return;
	end
	
	self.updating = true;
	self.watchMoney = false;
	
	local nextAnchor = nil;
	local lineFrame = WatchFrameLines;
	
	if MQT.db.profile.float then -- MOD
		-- Print(twice and "2nd" or "1st")
		WatchFrame:SetHeight(twice and MQT.floater.wantedsize or UIParent:GetHeight())
	end -- MOD

	local maxHeight = (WatchFrame:GetTop() - WatchFrame:GetBottom()); -- Can't use lineFrame:GetHeight() because it could be an invalid rectangle (width of 0)
	
	local maxFrameWidth = WATCHFRAME_MAXLINEWIDTH;
	local maxWidth = 0;
	local maxLineWidth, numObjectives, numPopUps;
	local totalObjectives = 0;
	WATCHFRAME_NUM_POPUPS = 0;

	--MOD
	if MQT.db.profile.fixedwidth then
		maxFrameWidth = MQT.db.profile.widthwhenfixed
	else
		maxFrameWidth = 1024; -- Effectively meaningless number -- FUTURE MOD
	end
	--EMOD
	
	WatchFrame_ResetLinkButtons();
	for i = 1, #WATCHFRAME_OBJECTIVEHANDLERS do
		nextAnchor, maxLineWidth, numObjectives, numPopUps = WATCHFRAME_OBJECTIVEHANDLERS[i](lineFrame, nextAnchor, maxHeight, maxFrameWidth);
		--Print(i .. " -> " .. (nextAnchor and "ok" or "bad"))
		maxWidth = max(maxLineWidth, maxWidth);
		totalObjectives = totalObjectives + numObjectives;
		WATCHFRAME_NUM_POPUPS = WATCHFRAME_NUM_POPUPS + numPopUps;
	end
	
	--disabled for now, might make it an option
	--lineFrame:SetWidth(min(maxWidth, maxFrameWidth));
	
	-- shadow
	if ( WATCHFRAME_NUM_POPUPS > 0) then
		if (not lineFrame.Shadow:IsShown()) then
			lineFrame.Shadow:Show();
			lineFrame.Shadow.FadeIn:Play();
		end
	else
		lineFrame.Shadow:Hide();
	end
	
	if ( totalObjectives > 0 ) then
		WatchFrameHeader:Show();
		WatchFrameCollapseExpandButton:Show();
		WatchFrameTitle:SetText(OBJECTIVES_TRACKER_LABEL.." ("..totalObjectives..")");
		WatchFrameHeader:SetWidth(WatchFrameTitle:GetWidth() + 4);
		-- visible objectives?
		if ( nextAnchor ) then
			if ( self.collapsed and not self.userCollapsed ) then
				WatchFrame_Expand(self);
			end
			WatchFrameCollapseExpandButton:Enable();
		else
			if ( not self.collapsed ) then
				WatchFrame_Collapse(self);
			end
			--WatchFrameCollapseExpandButton:Disable();		
		end		
	else
		WatchFrameHeader:Hide();
		WatchFrameCollapseExpandButton:Hide();
	end
	
	WatchFrame_ReleaseUnusedLinkButtons();
	
	self.updating = nil;

	if MQT.db.profile.float --[[and MQT.floater.up ]] and (totalObjectives > 0) then -- MOD
		if self.userCollapsed then
			MQT.floater.wantedsize = 42
		elseif nextAnchor and type(nextAnchor:GetBottom()) == "number" then
			--Print(WatchFrame:GetTop() .. " - " .. nextAnchor:GetBottom() );
			MQT.floater.wantedsize = ( WatchFrame:GetTop() - nextAnchor:GetBottom() ) + 24
		else
			MQT.floater.wantedsize = 42
			--Print("NextAnchor should not be nil") Why is it nil? Find out why later.
		end
		if not twice then
			return WatchFrame_Update(self, true)
		else
			MQT.floater:moved()
		end
	end

end

local function WatchFrame_SetLine(line, anchor, verticalOffset, isHeader, text, dash, hasItem, fullHeight, eligible, usedWidth)
	-- anchor
	if ( anchor ) then
		line:SetPoint("RIGHT", anchor, "RIGHT", 0, 0);
		line:SetPoint("LEFT", anchor, "LEFT", 0, 0);
		line:SetPoint("TOP", anchor, "BOTTOM", 0, verticalOffset);
	end
	-- text
	line.text:SetText(text);
	if ( isHeader ) then
		WATCHFRAME_SETLINES_NUMLINES = 0;
		if line.rgb and MQT.db.profile.colortitle then --MOD
			line.text:SetTextColor(line.rgb.r, line.rgb.g, line.rgb.b);
		else
			line.text:SetTextColor(0.75, 0.61, 0);
		end
	else
		--this should be the default, set in WatchFrameLineTemplate_Reset
		if ( eligible ~= nil and eligible == false) then
			line.text.eligible = eligible;
			line.text:SetTextColor(DIM_RED_FONT_COLOR.r, DIM_RED_FONT_COLOR.g, DIM_RED_FONT_COLOR.b);
		else
			line.text.eligible = true;
			line.text:SetTextColor(0.8, 0.8, 0.8);
		end
	end
	-- dash
	local usedWidth = usedWidth or 0;
	if ( dash == DASH_SHOW ) then
		line.dash:SetText(QUEST_DASH);
		usedWidth = DASH_WIDTH;
	elseif ( dash == DASH_HIDE ) then
		line.dash:SetText(QUEST_DASH);
		line.dash:Hide();
		usedWidth = DASH_WIDTH;
	elseif ( dash == DASH_ICON ) then
		line.dash:SetWidth(DASH_ICON_WIDTH);
		usedWidth = DASH_ICON_WIDTH;
	end	
	-- multiple lines
	if ( hasItem and WATCHFRAME_SETLINES_NUMLINES < 2 ) then
		usedWidth = usedWidth + WATCHFRAME_ITEM_WIDTH;
	end
	line.text:SetWidth(WATCHFRAME_MAXLINEWIDTH - usedWidth);
	if ( line.text:GetHeight() > WATCHFRAME_LINEHEIGHT ) then
		if ( fullHeight ) then
			line:SetHeight(line.text:GetHeight() + 4);
		else
			line:SetHeight(WATCHFRAME_MULTIPLE_LINEHEIGHT);
			line.text:SetHeight(WATCHFRAME_MULTIPLE_LINEHEIGHT);
		end
		WATCHFRAME_SETLINES_NUMLINES = WATCHFRAME_SETLINES_NUMLINES + 2;
	else
		WATCHFRAME_SETLINES_NUMLINES = WATCHFRAME_SETLINES_NUMLINES + 1;
	end
	tinsert(WATCHFRAME_SETLINES, line);	
end


-- WatchFrame_DisplayTrackedQuests
-- from: FrameXML/WatchFrame.lua
-- why: Alter appearance
-- changed: some things here and there
function fun.WatchFrame_DisplayTrackedQuests (lineFrame, nextAnchor, maxHeight, frameWidth)
	local _;
	local questTitle, bs, mytitle, color; --MOD	
	local questIndex;	
	local line;
	local lastLine;
	local linkButton;
	local watchItemIndex = 0;
	local numVisible = 0;
	
	local numPOINumeric = 0;
	local numPOICompleteIn = 0;
	local numPOICompleteOut = 0;
	
	local text, finished, objectiveType;
	local numQuestWatches = GetNumQuestWatches();
	local numObjectives;
	local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, startEvent;
	local numValidQuests = 0;

	local maxWidth = 0;
	local lineWidth = 0;
	local topEdge = 0;

	local playerMoney = GetMoney(); local bl = MQT.BuddyList; --MOD
	local selectedQuestId = WORLDMAP_SETTINGS.selectedQuestId; --Remove?
	if ( not WorldMapFrame or not WorldMapFrame:IsShown() ) then
		-- For the filter REMOTE ZONES: when it's unchecked we need to display local POIs only. Unfortunately all the POI
		-- code uses the current map so the tracker would not display the right quests if the world map was windowed and
		-- open to a different zone.
		table.wipe(LOCAL_MAP_QUESTS);
		LOCAL_MAP_QUESTS["zone"] = GetCurrentMapZone();
		for id in pairs(CURRENT_MAP_QUESTS) do
			LOCAL_MAP_QUESTS[id] = true;
		end	
	end
	
	table.wipe(VISIBLE_WATCHES);
	WatchFrame_ResetQuestLines();

	-- if supertracked quest is not in the quest log anymore, stop supertracking it
	if ( GetQuestLogIndexByID(GetSuperTrackedQuestID()) == 0 ) then
		SetSuperTrackedQuestID(0);
	end
	
	local inScenario = C_Scenario.IsInScenario();
	
	for i = 1, numQuestWatches do
		local validQuest = false;
		WATCHFRAME_SETLINES = table.wipe(WATCHFRAME_SETLINES or { });
		questIndex = GetQuestIndexForWatch(i);
		if ( questIndex ) then
			-- don't show non-scenario quests in scenarios
			if ( not inScenario or GetQuestLogQuestType(questIndex) == QUEST_TYPE_SCENARIO ) then
				validQuest = true;
			end
		end
		if ( validQuest ) then
			numValidQuests = numValidQuests + 1;
			title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, startEvent = GetQuestLogTitle(questIndex);

			if (GetSuperTrackedQuestID() == 0) then
				SetSuperTrackedQuestID(questID);
			end
			
			local questFailed = false;
			local requiredMoney = GetQuestLogRequiredMoney(questIndex);			
			numObjectives = GetNumQuestLeaderBoards(questIndex);
			if ( isComplete and isComplete < 0 ) then
				isComplete = false;
				questFailed = true; 
				mytitle = (title or "nil") .. " (" .. FAILED .. ")"; -- MOD
			elseif ( numObjectives == 0 and playerMoney >= requiredMoney and not startEvent  ) then
				isComplete = true; 
				mytitle = (title or "nil") .. " (" .. COMPLETE .. ")"; -- MOD
			else -- MOD
				mytitle = title -- MOD
			end			
			-- check filters
			local filterOK = true;
			if ( isComplete and bit.band(WATCHFRAME_FILTER_TYPE, WATCHFRAME_FILTER_COMPLETED_QUESTS) ~= WATCHFRAME_FILTER_COMPLETED_QUESTS ) then
				filterOK = false;
			elseif ( bit.band(WATCHFRAME_FILTER_TYPE, WATCHFRAME_FILTER_REMOTE_ZONES) ~= WATCHFRAME_FILTER_REMOTE_ZONES and not LOCAL_MAP_QUESTS[questID] ) then
				filterOK = false;
			end			
			
			if ( filterOK ) then
				local link, item, charges, showItemWhenComplete  = GetQuestLogSpecialItemInfo(questIndex);
				if ( requiredMoney > 0 ) then
					WatchFrame.watchMoney = true;	-- for update event			
				end
				questTitle = WatchFrame_GetQuestLine();

				-- BEGIN MOD
				if (MQT.db.profile.showlevel) then mytitle = string.format(MQT.LEVEL_FORMAT, level, mytitle); end
				-- Color title
				if (MQT.db.profile.colortitle) then
					if (isDaily) then
						questTitle.rgb = {r=0.3, g=0.5, b=0.9};
					else
						questTitle.rgb = GetQuestDifficultyColor(level);
					end
					questTitle.rgbh = brightenColor(questTitle.rgb);
				end
				-- END MOD				
				
				WatchFrame_SetLine(questTitle, lastLine, -WATCHFRAME_QUEST_OFFSET, IS_HEADER, mytitle, DASH_NONE, item); -- MOD
				if ( not lastLine ) then -- First line
					questTitle:SetPoint("RIGHT", lineFrame, "RIGHT", 0, 0);
					questTitle:SetPoint("LEFT", lineFrame, "LEFT", 0, 0);
					if (nextAnchor) then
						questTitle:SetPoint("TOP", nextAnchor, "BOTTOM", 0, -WATCHFRAME_TYPE_OFFSET);
					else
						questTitle:SetPoint("TOP", lineFrame, "TOP", 0, -WATCHFRAME_INITIAL_OFFSET);
					end
					topEdge = questTitle:GetTop();
				end
				lastLine = questTitle;

				local fauxComplete = false
				if ( isComplete ) then -- MOD Check if all buddies are complete too
					local buddyComplete = bl:getBuddyComplete(questID)
					if not buddyComplete then
						isComplete = false
						fauxComplete = true
					end
				end
				
				if ( isComplete or (numObjectives == 0 and fauxComplete) ) then --MOD
					local showItem = item and showItemWhenComplete;
					if (GetQuestLogIsAutoComplete(questIndex)) then
						line = WatchFrame_GetQuestLine();
						WatchFrame_SetLine(line, lastLine, WATCHFRAMELINES_FONTSPACING, not IS_HEADER, QUEST_WATCH_QUEST_COMPLETE, DASH_HIDE, showItem, true);
						lastLine = line;
						line = WatchFrame_GetQuestLine();
						WatchFrame_SetLine(line, lastLine, WATCHFRAMELINES_FONTSPACING, not IS_HEADER, QUEST_WATCH_CLICK_TO_COMPLETE, DASH_HIDE, showItem, true);
						lastLine = line;
					else
						line = WatchFrame_GetQuestLine();
						WatchFrame_SetLine(line, lastLine, WATCHFRAMELINES_FONTSPACING, not IS_HEADER, GetQuestLogCompletionText(questIndex), DASH_SHOW, showItem, true);
						lastLine = line;
					end
				elseif ( questFailed ) then
					line = WatchFrame_GetQuestLine();
					WatchFrame_SetLine(line, lastLine, WATCHFRAMELINES_FONTSPACING, not IS_HEADER, FAILED, DASH_HIDE, nil, nil, false);
					lastLine = line;
				else
					for j = 1, numObjectives do
						text, objectiveType, finished = GetQuestLogLeaderBoard(j, questIndex);						
						
						bs = bl:getBuddyWatch(questID, j) -- MODIFIED
						
						if bs and finished then finished = bl:getBuddyFinished(questID, j) end -- MOD

						if ( (not finished) and text ) then 
							text = ReverseQuestObjective(text, objectiveType);
							--Print("going ".. text)
							
							if bs then
								local x,y,w = string.gmatch(text, MQT.MATCHLEADERBOARD3)();
								if w and x and y then
									text = string.format("%s%s/%d %s", x,bs,y,w)
								end
							end -- END MOD
							
							line = WatchFrame_GetQuestLine();
							WatchFrame_SetLine(line, lastLine, WATCHFRAMELINES_FONTSPACING, not IS_HEADER, text, DASH_SHOW, item);
							lastLine = line;
						end
					end
					if ( requiredMoney > playerMoney ) then
						text = GetMoneyString(playerMoney).." / "..GetMoneyString(requiredMoney);
						line = WatchFrame_GetQuestLine();
						WatchFrame_SetLine(line, lastLine, WATCHFRAMELINES_FONTSPACING, not IS_HEADER, text, DASH_SHOW, item);
						lastLine = line;
					end
				end

				if (not isComplete) and fauxComplete then isComplete = true end --MOD
				
				-- stop processing if there's no room to fit the quest
				local numLines = #WATCHFRAME_SETLINES;
				local lastBottom = lastLine:GetBottom();
				if ( lastBottom and lastBottom < WatchFrame:GetBottom() ) then
					questLineIndex = questLineIndex - numLines;
					table.wipe(WATCHFRAME_SETLINES);
					break;
				end
				
				numVisible = numVisible + 1;
				table.insert(VISIBLE_WATCHES, numVisible, questIndex);		-- save the quest log index because watch order can change after dropdown is opened
				-- turn on quest item
				local itemButton;
				if ( item and (not isComplete or showItemWhenComplete) ) then
					watchItemIndex = watchItemIndex + 1;
					itemButton = _G["WatchFrameItem"..watchItemIndex];
					if ( not itemButton ) then
						WATCHFRAME_NUM_ITEMS = watchItemIndex;
						itemButton = CreateFrame("BUTTON", "WatchFrameItem" .. watchItemIndex, lineFrame, "WatchFrameItemButtonTemplate");
					end
					itemButton:Show();
					itemButton:ClearAllPoints();
					itemButton:SetID(questIndex);
					SetItemButtonTexture(itemButton, item);
					SetItemButtonCount(itemButton, charges);
					itemButton.charges = charges;
					WatchFrameItem_UpdateCooldown(itemButton);
					itemButton.rangeTimer = -1;
					-- MOD
					if MQT.db.profile.itemleft then
						itemButton:SetPoint("TOPRIGHT", questTitle, "TOPLEFT", -25, -2);
					else
						itemButton:SetPoint("TOPRIGHT", questTitle, "TOPRIGHT", 10, -2);
					end
					-- EMOD
				end			
				-- turn on all lines
				for _, line in pairs(WATCHFRAME_SETLINES) do
					line:Show();
					lineWidth = line.text:GetWidth() + line.dash:GetWidth();
					maxWidth = max(maxWidth, lineWidth);
				end
				-- turn on link button
				linkButton = WatchFrame_GetLinkButton();
				linkButton:SetPoint("TOPLEFT", questTitle);
				linkButton:SetPoint("BOTTOMLEFT", questTitle);
				linkButton:SetPoint("RIGHT", questTitle.text);
				linkButton.type = "QUEST"
				linkButton.index = i; -- We want the Watch index, we'll get the quest index later with GetQuestIndexForWatch(i);
				linkButton.lines = WATCHFRAME_QUESTLINES;
				linkButton.startLine = questLineIndex - numLines;
				linkButton.lastLine = questLineIndex - 1;
				linkButton.isComplete = isComplete;
				linkButton:Show();				
				-- quest POI icon
				if ( WatchFrame.showObjectives ) then
					local poiButton;
					if ( CURRENT_MAP_QUESTS[questID] ) then
						if ( isComplete ) then
							numPOICompleteIn = numPOICompleteIn + 1;
							poiButton = QuestPOI_DisplayButton("WatchFrameLines", QUEST_POI_COMPLETE_IN, numPOICompleteIn, questID);
						else
							numPOINumeric = numPOINumeric + 1;
							poiButton = QuestPOI_DisplayButton("WatchFrameLines", QUEST_POI_NUMERIC, numPOINumeric, questID);
						end
					elseif ( isComplete ) then 
						numPOICompleteOut = numPOICompleteOut + 1;
						poiButton = QuestPOI_DisplayButton("WatchFrameLines", QUEST_POI_COMPLETE_OUT, numPOICompleteOut, questID);
					end
					if ( poiButton ) then
						poiButton:SetPoint("TOPRIGHT", questTitle, "TOPLEFT", 0, 5);
					end				
				end
				
				if ( lastBottom ) then
					heightUsed = topEdge - lastLine:GetBottom();
				else
					heightUsed = 1;
				end
			end
		end
	end

	for i = watchItemIndex + 1, WATCHFRAME_NUM_ITEMS do
		_G["WatchFrameItem" .. i]:Hide();
	end
	QuestPOI_HideButtons("WatchFrameLines", QUEST_POI_NUMERIC, numPOINumeric + 1);
	QuestPOI_HideButtons("WatchFrameLines", QUEST_POI_COMPLETE_IN, numPOICompleteIn + 1);
	QuestPOI_HideButtons("WatchFrameLines", QUEST_POI_COMPLETE_OUT, numPOICompleteOut + 1);
	
	WatchFrame_ReleaseUnusedQuestLines();

	local trackedQuestID = GetSuperTrackedQuestID();
	if ( trackedQuestID ) then
		QuestPOIUpdateIcons();
		QuestPOI_SelectButtonByQuestId("WatchFrameLines", trackedQuestID, true);	
	end
	
	return lastLine or nextAnchor, maxWidth, numValidQuests, 0;	
end



--------------------------------------------------------------------------------------------------------
--
-- Initialize
--
--------------------------------------------------------------------------------------------------------

function WF.OnInitialize(self)	
	local hooks = ML.api.hooking:new(self);
	self.hooks = hooks;
	hooks:HookGlobals(self.fun);
	
	watchFrameTestLine = WatchFrame.lineCache:GetFrame();
	-- WATCHFRAME_COLLAPSEDWIDTH = WatchFrameTitle:GetWidth() + 70;
	local _, fontHeight = watchFrameTestLine.text:GetFont();
	watchFrameTestLine.dash:SetText(QUEST_DASH);
	DASH_WIDTH = watchFrameTestLine.dash:GetWidth();
	WATCHFRAMELINES_FONTHEIGHT = fontHeight;
	WATCHFRAMELINES_FONTSPACING = (WATCHFRAME_LINEHEIGHT - WATCHFRAMELINES_FONTHEIGHT) / 2
end

function WF.OnEnable(self)
	WatchFrame_RemoveObjectiveHandler(WatchFrame_DisplayTrackedQuests)
	self.hooks:enable();
	WatchFrame_AddObjectiveHandler(WatchFrame_DisplayTrackedQuests);
	WatchFrameCollapseExpandButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	WF.WFCEBOC = WatchFrameCollapseExpandButton:GetScript("OnClick")
	WatchFrameCollapseExpandButton:SetScript("OnClick", WF.CEBOC)
end

function WF.CEBOC(self, button)
	if button == "RightButton" and MQT.db.profile.float then
		MQT.db.profile.floatfixed = not MQT.db.profile.floatfixed
		LibStub("AceConfigRegistry-3.0"):NotifyChange("MoncaiQuestTracker")
		MQT:Refresh()
	else
		WF.WFCEBOC(self)
	end
end

function WF.OnDisable(self)
	WatchFrame_RemoveObjectiveHandler(WatchFrame_DisplayTrackedQuests)
	self.hooks:disable();
	WatchFrame_AddObjectiveHandler(WatchFrame_DisplayTrackedQuests);
	
	WatchFrameCollapseExpandButton:SetScript("OnClick", WF.WFCEBOC)	
end
