local CompanionFilter = LibStub("AceAddon-3.0"):NewAddon("CompanionFilter", "AceHook-3.0", "AceEvent-3.0")

local searchbox, searchcount, searchtext
	
function CompanionFilter:OnInitialize()
	-- create our search text box
	searchbox = CreateFrame("EditBox", "CompanionFilterSearchBox", SpellBookCompanionsFrame, "InputBoxTemplate")
	searchbox:SetPoint("CENTER", 0, 210)
	searchbox:SetWidth(150)
	searchbox:SetHeight(22)
	searchbox:SetFontObject("ChatFontSmall")
	searchbox:SetAutoFocus(false)
	searchbox:ClearFocus()
	-- when we press enter on our search box, clear the focus as well as updating the list
	searchbox:SetScript("OnEnterPressed", function() searchbox:ClearFocus() CompanionFilter:UpdateCompanionList() end)
	-- when we're just typing in the box, update the list
	searchbox:SetScript("OnTextChanged", CompanionFilter.UpdateCompanionList)
	-- create the label that holdes the search result count
	searchcount = searchbox:CreateFontString("CompanionFilterSearchCount", nil, "GameFontNormal")
	searchcount:SetTextColor(1, 0.82, 0, 1)
	searchcount:SetPoint("LEFT", searchbox, "RIGHT", 5, 0)
	-- create a nice label with the text Filter:
	searchtext = searchbox:CreateFontString("CompanionFilterSearchText", nil, "GameFontNormal")
	searchtext:SetTextColor(1, 0.82, 0, 1)
	searchtext:SetPoint("RIGHT", searchbox, "LEFT", -10, 0)
	searchtext:SetText("Filter:")
end

function CompanionFilter:OnEnable()
	-- when something else updates the page, update the list
	self:SecureHook("SpellBook_UpdateCompanionsFrame", "UpdateCompanionList")
	searchbox:Show()
	searchcount:Show()
	searchtext:Show()
end

function CompanionFilter:OnDisable()
	-- remove the aforementioned hooks
	self:UnhookAll()
	searchbox:Hide()
	searchcount:Hide()
	searchtext:Hide()
end

function CompanionFilter:UpdateCompanionList()
	-- if we can't even see the companions frame, don't bother
	if not SpellBookCompanionsFrame or not SpellBookCompanionsFrame.mode or not SpellBookCompanionsFrame:IsVisible() then
		return
	end
	local button
	local selected = false
	-- counts
	local total = 0
	local count = 1
	-- grab the current page
	local currentPage = SPELLBOOK_PAGENUMBERS[SpellBookFrame.bookType]
	-- page offset for pet indices
	local offset = (currentPage and currentPage - 1 or 0)*NUM_COMPANIONS_PER_PAGE
	-- iterate through all of our companions for a text match
	for i = 1, GetNumCompanions(SpellBookCompanionsFrame.mode) do
		local creatureID, creatureName, spellID, icon, active = GetCompanionInfo(SpellBookCompanionsFrame.mode, i)
		if string.find(strlower(creatureName), strlower(searchbox:GetText())) then
			-- and increase the search total
			total = total + 1
			-- if we're within range to update a button
			if total >= count + (offset or 0) and count <= 12 then
				button = _G["SpellBookCompanionButton"..count]
				count = count + 1
				button.creatureID = creatureID
				button.spellID = spellID
				button.active = active
				if ( creatureID ) then
					--change the id so it has the correct pet
					button:SetID(i - offset)
					button.IconTexture:SetTexture(icon)
					button.IconTexture:Show()
					button.SpellName:SetText(creatureName)
					button.SpellName:Show()
					button:Enable()
				else
					button:Disable()
					button.IconTexture:Hide()
					button.SpellName:Hide()
				end
				if ( creatureID and ( creatureID == SpellBookCompanionsFrame.idCritter or creatureID == SpellBookCompanionsFrame.idMount ) ) then
					button:SetChecked(true)
					selected = true
				else
					button:SetChecked(false)
				end
				if ( active ) then
					button.ActiveTexture:Show()
				else
					button.ActiveTexture:Hide()
				end
				if (SpellBookCompanionsFrame.mode == "CRITTER") then
					button.Background:SetTexCoord(0.71093750, 0.79492188, 0.00390625, 0.17187500)
				else
					button.Background:SetTexCoord(0.62304688, 0.70703125, 0.00390625, 0.17187500)
				end
			end
		end
	end
	
	--nothing shown because too far, change page and go again
	if count == 1 and total > 0 then
		SPELLBOOK_PAGENUMBERS[SpellBookFrame.bookType] = ceil(total/NUM_COMPANIONS_PER_PAGE)
		CompanionFilter:UpdateCompanionList()
		return
	end
	
	--select first displayed companion if we haven't already
	if not selected then
		SpellBookCompanionButton1:SetChecked(true)
		if ( SpellBookCompanionsFrame.mode == "CRITTER" ) then
			SpellBookCompanionsFrame.idCritter = SpellBookCompanionButton1.creatureID;
		elseif ( SpellBookCompanionsFrame.mode == "MOUNT" ) then
			SpellBookCompanionsFrame.idMount = SpellBookCompanionButton1.creatureID;
		end
	end
	
	-- hide remaining buttons
	for i = count, 12 do
		button = _G["SpellBookCompanionButton"..i]
		button.creatureID = nil
		button:Disable()
		button.IconTexture:Hide()
		button.SpellName:Hide()
		button:SetChecked(false)
		button.ActiveTexture:Hide()
		local cooldown = _G[button:GetName().."Cooldown"]
		cooldown:Hide()
	end
	-- update the count label with the totals
	searchcount:SetText(total .. " / " .. GetNumCompanions(SpellBookCompanionsFrame.mode))
	-- update the max pages for the search results
	local maxPages = ceil(total/NUM_COMPANIONS_PER_PAGE)
	-- bug fix so wow doesn't think we have 0 pages and spazzes out
	if maxPages < 1 then
		maxPages = 1
	end
	-- show/hide the next/back page buttons as appropriate
	if ( currentPage > maxPages ) then
		SPELLBOOK_PAGENUMBERS[SpellBookFrame.bookType] = maxPages
		currentPage = maxPages
		if ( currentPage == 1 ) then
			SpellBookPrevPageButton:Disable();
		else
			SpellBookPrevPageButton:Enable();
		end
		if ( currentPage == maxPages ) then
			SpellBookNextPageButton:Disable();
		else
			SpellBookNextPageButton:Enable();
		end
	end
	if ( currentPage == 1 ) then
		SpellBookPrevPageButton:Disable();
	else
		SpellBookPrevPageButton:Enable();
	end
	if ( currentPage == maxPages ) then
		SpellBookNextPageButton:Disable();
	else
		SpellBookNextPageButton:Enable();
	end
	SpellBookPageText:SetFormattedText(PAGE_NUMBER, currentPage);
	SpellBookCompanionsFrame_UpdateCompanionPreview()
	SpellBook_UpdateCompanionCooldowns()
end