local ML = LibStub("MoncaiLib");
local MQT = LibStub("AceAddon-3.0"):GetAddon("MoncaiQuestTracker");
local MQTW;

local QL = MQT:NewModule("MQT_QuestLogFrame");
QL.fun = {};
local fun = QL.fun;

-- uselessly duplicated local functions... sigh...

-- this function returns the amount needed to adjust the scroll bar in order to get the given quest index to appear in the
-- QuestLogScrollFrame's viewable area
local function _QuestLog_GetQuestScrollOffset(questIndex)
	local scrollBarOffset = 0;
	local buttons = QuestLogScrollFrame.buttons;
	local testButton = buttons[1];
	local testIndex = testButton:GetID();
	local buttonHeight = testButton:GetHeight();
	if ( questIndex <= testIndex ) then
		if ( questIndex < testIndex ) then
			-- selected quest comes before the first visible quest

			-- instead of just offsetting by the delta of the indexes, we offset by 1 more to get the line BEFORE the selected
			-- line to be at the top...if we don't do this, then the selected line would be at the top of the frame, which
			-- isn't bad, but it feels better if we have the previous element at the top
			scrollBarOffset = (testIndex - questIndex + 1) * buttonHeight;
		end
		-- make sure the visible area is aligned to the top of a button by adding the difference between the button's
		-- top and the scroll area's top
		scrollBarOffset = scrollBarOffset - (QuestLogScrollFrame:GetTop() - testButton:GetTop());
	else
		local numButtons = #buttons;
		testButton = buttons[numButtons];
		testIndex = max(testButton:GetID(), numButtons);	--If the buttons aren't initalized, this will default to the last button. The index of the last button should never be greater than it's ID otherwise
		if ( questIndex >= (testIndex - 1) ) then
			if ( questIndex > testIndex ) then
				-- selected quest comes after the last visible quest
				-- instead of just offsetting by the delta of the indexes, we offset by 1 more to get the line AFTER the selected
				-- line to be at the bottom...if we don't do this, then the selected line would be at the bottom of the frame, which
				-- isn't bad, but it feels better if we have the next element at the bottom
				scrollBarOffset = (testIndex - questIndex - 1) * buttonHeight;
			end
			-- make sure the visible area is aligned to the bottom of a button by adding the difference between the button's
			-- bottom and the scroll area's bottom
			if ( questIndex == (testIndex - 1) ) then
				testButton = buttons[numButtons - 1];
			end
			local testBottom = testButton:GetBottom();
			local scrollBottom = QuestLogScrollFrame:GetBottom();
			if ( scrollBottom > testBottom ) then
				-- don't add the offset unless the test button is actually lower than the scroll frame...it feels jumpy if you do
				scrollBarOffset = scrollBarOffset + (testBottom - scrollBottom);
			end
		end
	end
	return scrollBarOffset;
end

local function _QuestLog_HighlightQuest(questLogTitle)
	local prevParent = QuestLogHighlightFrame:GetParent();
	if ( prevParent and prevParent ~= questLogTitle ) then
		-- set prev quest's colors back to normal
		local prevName = prevParent:GetName();
		prevParent:UnlockHighlight();
		prevParent.tag:SetTextColor(prevParent.r, prevParent.g, prevParent.b);
		prevParent.groupMates:SetTextColor(prevParent.r, prevParent.g, prevParent.b);
	end
	if ( questLogTitle ) then
		local name = questLogTitle:GetName();
		-- highlight the quest's colors
		questLogTitle.tag:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		questLogTitle.groupMates:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		questLogTitle:LockHighlight();
		-- reposition highlight frames
		QuestLogHighlightFrame:SetParent(questLogTitle);
		QuestLogHighlightFrame:SetPoint("TOPLEFT", questLogTitle, "TOPLEFT", 0, 0);
		QuestLogHighlightFrame:SetPoint("BOTTOMRIGHT", questLogTitle, "BOTTOMRIGHT", 0, 0);
		QuestLogSkillHighlight:SetVertexColor(questLogTitle.r, questLogTitle.g, questLogTitle.b);
		QuestLogHighlightFrame:Show();
	else
		QuestLogHighlightFrame:Hide();
	end
end

local function _QuestLog_ToggleQuestWatch(questIndex)
	if ( IsQuestWatched(questIndex) ) then
		RemoveQuestWatch(questIndex);
		WatchFrame_Update();
	else
		if ( GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS ) then -- Check this first though it's less likely, otherwise they could make the frame bigger and be disappointed
			UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, MAX_WATCHABLE_QUESTS), 1.0, 0.1, 0.1, 1.0);
			return;
		end
		AddQuestWatch(questIndex);
		WatchFrame_Update();
	end
end

-- QuestLogTitleButton_OnClick
-- from: FrameXML/QuestLogFrame.lua
-- why: Alter conditions
-- changed: removed condition checks
function fun.QuestLogTitleButton_OnClick(self, button)
	local questName = self:GetText();
	local questIndex = self:GetID();
	if ( IsModifiedClick() ) then
		-- If header then return
		if ( self.isHeader ) then
			QL.ToggleWatchesUnder(questIndex); return; --MOD
		end
		-- Otherwise try to track it or put it into chat
		if ( IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() ) then
			local questLink = GetQuestLink(questIndex);
			if ( questLink ) then
				ChatEdit_InsertLink(questLink);
			end
			QuestLog_SetSelection(questIndex);
		elseif ( IsModifiedClick("QUESTWATCHTOGGLE") ) then
			_QuestLog_ToggleQuestWatch(questIndex);
			QuestLog_SetSelection(questIndex);
			QuestLog_Update();
		end
	else
		QuestLog_SetSelection(questIndex);
	end
end

-- QuestLog_Update
-- from: FrameXML/QuestLogFrame.lua
-- why: Alter appearance, make item list persistent
-- changed: misc
function fun.QuestLog_Update()
	if ( not QuestLogFrame:IsShown() ) then
		return;
	end
	
	local numEntries, numQuests = GetNumQuestLogEntries();
	if ( numEntries == 0 ) then
		HideUIPanel(QuestLogDetailFrame);
		QuestLogDetailFrame.timeLeft = nil;
		EmptyQuestLogFrame:Show();
		QuestLog_SetSelection(0);
	else
		EmptyQuestLogFrame:Hide();
	end

	QuestLog_UpdateMapButton();
	
	-- Update Quest Count
	QuestLog_UpdateQuestCount(numQuests);

	-- If no selection then set it to the first available quest
	local questLogSelection = GetQuestLogSelection();
	local haveSelection = questLogSelection ~= 0;
	if ( numQuests > 0 and not haveSelection ) then
		if ( QuestLogFrame.selectedIndex ) then
			QuestLog_SetNearestValidSelection();
		else
			QuestLog_SetFirstValidSelection();
		end
		questLogSelection = GetQuestLogSelection();
	end
	QuestLogFrame.selectedIndex = questLogSelection;
    
    --The counts may have changed with SetNearestValidSelection expanding quest headers.
    --Bug ID 170644
    numEntries, numQuests = GetNumQuestLogEntries();

	-- hide the details if we don't have a selected quest
	if ( not haveSelection ) then
		HideUIPanel(QuestLogDetailFrame);
	end

	-- update the group timer
	local haveGroup = GetNumSubgroupMembers() > 0 ; --or GetNumRaidMembers() > 1;
	if ( haveGroup ) then
		QuestLogFrame.groupUpdateTimer = 0;
	else
		QuestLogFrame.groupUpdateTimer = nil;
	end

	-- hide the highlight frame initially, it may be shown when we loop through the quest listing if a quest is selected
	QuestLogHighlightFrame:Hide();

	-- Update the quest listing
	local buttons = QuestLogScrollFrame.buttons;
	local numButtons = #buttons;
	local scrollOffset = HybridScrollFrame_GetOffset(QuestLogScrollFrame);
	local buttonHeight = buttons[1]:GetHeight();
	local displayedHeight = 0;

	local numPartyMembers = GetNumSubgroupMembers();
	local questIndex, questLogTitle, questTitleTag, questNumGroupMates, questNormalText, questCheck;
	local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, displayQuestID;
	local color;
	local partyMembersOnQuest, tempWidth, textWidth;
	for i=1, numButtons do
		questLogTitle = buttons[i];
		questIndex = i + scrollOffset;
		questLogTitle:SetID(questIndex);
		questTitleTag = questLogTitle.tag;
		questNumGroupMates = questLogTitle.groupMates;
		questCheck = questLogTitle.check;
		questNormalText = questLogTitle.normalText;
		if ( questIndex <= numEntries ) then
			title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID, displayQuestID = GetQuestLogTitle(questIndex);

			if ( isHeader ) then
				-- set the title
				if ( title ) then
					questLogTitle:SetText(title);
				else
					questLogTitle:SetText("");
				end

				-- set the normal texture based on the header's collapsed state
				if ( isCollapsed ) then
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
				else
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
				end
				questLogTitle:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight");

				questNumGroupMates:Hide();
				questTitleTag:Hide();
				questCheck:Hide();
				questLogTitle.QuestionMark:Hide();
			else
				displayQuestID = MQT.db.profile.displayqid -- debug MOD
				-- set the title
				if ( ENABLE_COLORBLIND_MODE == "1" or MQT.db.profile.showlevel) then --MOD
					title = "["..level.."] " .. title;
				end
				if (questID and displayQuestID) then
					questLogTitle:SetText("  "..questID.." - "..title);
				else
					questLogTitle:SetText("  "..title);
				end

				-- this isn't a header, hide the header textures
				questLogTitle:SetNormalTexture("");
				questLogTitle:SetHighlightTexture("");

				-- If not a header see if any nearby group mates are on this quest
				partyMembersOnQuest = 0;
				for j=1, numPartyMembers do
					if ( IsUnitOnQuest(questIndex, "party"..j) ) then
						partyMembersOnQuest = partyMembersOnQuest + 1;
					end
				end
				if ( partyMembersOnQuest > 0 ) then
					questNumGroupMates:SetText("["..partyMembersOnQuest.."]");
					questNumGroupMates:Show();
				else
					questNumGroupMates:Hide();
				end

				-- figure out which tag to show, if any
				if ( isComplete and isComplete < 0 ) then
					questTag = FAILED;
				elseif ( isComplete and isComplete > 0 ) then
					questTag = COMPLETE;
				elseif ( isDaily ) then
					if ( questTag ) then
						questTag = format(DAILY_QUEST_TAG_TEMPLATE, questTag);
					else
						questTag = DAILY;
					end
				end
				if ( questTag ) then
					questTitleTag:SetText("("..questTag..")");
					questTitleTag:Show();
				else
					questTitleTag:Hide();
				end

				-- show the quest check if the quest is being watched
				if ( IsQuestWatched(questIndex) ) then
					questCheck:Show();
				else
					questCheck:Hide();
				end
				
				-- Show the question mark icon for auto-complete quests
				if (isComplete and isComplete>0 and GetQuestLogIsAutoComplete(questIndex)) then
					questLogTitle.QuestionMark:Show();
				else
					questLogTitle.QuestionMark:Hide();
				end
			end

			-- Save if its a header or not
			questLogTitle.isHeader = isHeader;

			-- resize the title button so everything fits where it's supposed to
			QuestLogTitleButton_Resize(questLogTitle);

			-- Color the quest title and highlight according to the difficulty level
			if ( isHeader ) then
				color = QuestDifficultyColors["header"];
			else
				color = GetQuestDifficultyColor(level);
			end
			questTitleTag:SetTextColor(color.r, color.g, color.b);
			questLogTitle:SetNormalFontObject(color.font);
			questNumGroupMates:SetTextColor(color.r, color.g, color.b);
			questLogTitle.r = color.r;
			questLogTitle.g = color.g;
			questLogTitle.b = color.b;
			questLogTitle:Show();

			-- Place the highlight and lock the highlight state
			if ( questLogSelection == questIndex ) then
				_QuestLog_HighlightQuest(questLogTitle);
			else
				questLogTitle:UnlockHighlight();
			end
		else
			questLogTitle:Hide();
		end
		displayedHeight = displayedHeight + buttonHeight;
	end
	HybridScrollFrame_Update(QuestLogScrollFrame, numEntries * buttonHeight, displayedHeight);

	local selectedIsComplete = select(7, GetQuestLogTitle(questLogSelection));
	if (selectedIsComplete and GetQuestLogIsAutoComplete()) then
		QuestLogFrameCompleteButton:Show();
	else
		QuestLogFrameCompleteButton:Hide();
	end
	
	-- update the control panel
	QuestLogControlPanel_UpdateState();
end



--------------------------------------------------------------------------------------------------------
--
-- Own functions
--
--------------------------------------------------------------------------------------------------------

function QL.ToggleWatchesUnder(questIndex)
	--Printf("ToggleWatchesUnder(%d)", questIndex);
	local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(questIndex);
	local wasCollapsed, header = false, questIndex;
	if isCollapsed then
		--Print("expanding header");
		ExpandQuestHeader(questIndex);
		wasCollapsed = true;
	end;
	local numEntries, numQuests = GetNumQuestLogEntries();
	
	questIndex = questIndex + 1;
	questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(questIndex);
	local onoff = IsQuestWatched(questIndex) -- toggle all based on state of first one
	while questLogTitleText and not isHeader and questIndex <= numEntries do
		--Printf("Looking at quest '%s' %d", questLogTitleText, questIndex);
		if ( onoff ) then
			RemoveQuestWatch(questIndex);
		else
			AddQuestWatch(questIndex);
		end
		questIndex = questIndex + 1;
		questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(questIndex);
	end
	if wasCollapsed then 
		CollapseQuestHeader(header);
	end
	WatchFrame_Update();
	QuestLog_Update();
end

--------------------------------------------------------------------------------------------------------
--
-- Initialize
--
--------------------------------------------------------------------------------------------------------

function QL.OnInitialize(self)
	MQTW = MQT.workspace;
	
	local hooks = ML.api.hooking:new(self);
	self.hooks = hooks;
	hooks:HookGlobals(self.fun);
	hooks:HookMethod(QuestLogScrollFrame, "update", fun.QuestLog_Update);
end

function QL.OnEnable(self)
	if QUESTGURU_VERSION ~= nil then
		Print("Moncaí Quest Tracker yielding QuestLogFrame to |cffffff00QuestGuru|r and engaging |cffff0000 compatibility mode|r.", 0.6,0.6, 1)
		
		QuestLog_OpenToQuest = function (questIndex, keepOpen)
			--Print("Clicky clicky!", 1, 0.8, 0.8)
			local selectedIndex = GetQuestLogSelection();
			if ( selectedIndex ~= 0 and questIndex == selectedIndex and QuestLogFrame:IsShown() and
				 _QuestLog_GetQuestScrollOffset(questIndex) == 0 ) then
				-- if the current quest is selected and is visible, then treat this as a toggle
				HideUIPanel(QuestLogFrame);
				return;
			end

			local numEntries, numQuests = GetNumQuestLogEntries();
			if ( questIndex < 1 or questIndex > numEntries ) then
				return;
			end

			ExpandQuestHeader(0);
			ShowUIPanel(QuestLogFrame);
			QuestLog_SetSelection(questIndex);
		end

		--[[QuestLog_OpenToQuest = function (questIndex, keepOpen)
			Print("Clicky clicky! Hehehe...", 0.6, 1, 0.6)
			local selectedIndex = GetQuestLogSelection();
			if ( not keepOpen and selectedIndex ~= 0 and questIndex == selectedIndex and QuestLogDetailFrame:IsShown() ) then
				-- if the current quest is selected and is visible, then treat this as a toggle
				HideUIPanel(QuestLogDetailFrame);
				return;
			end

			local numEntries, numQuests = GetNumQuestLogEntries();
			if ( questIndex < 1 or questIndex > numEntries ) then
				return;
			end
			HideUIPanel(QuestFrame);
			QuestLog_SetSelection(questIndex);
		end]]

	else	
		self.hooks:enable();
	end
end

function QL.OnDisable(self)
	if not (QUESTGURU_VERSION ~= nil) then
		self.hooks:disable();
	end
end
