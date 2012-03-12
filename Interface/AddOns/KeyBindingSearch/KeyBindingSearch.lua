KeyBindingSearch = {
	index = 1,
	results = {}
}

local editbox,button,rightarrow,leftarrow,loaded

function KeyBindingSearchUpdate()
	if #KeyBindingSearch["results"] > 0 then
			if KeyBindingSearch["index"] <= 0 then
				KeyBindingSearch["index"] = #KeyBindingSearch["results"]
			end
			if KeyBindingSearch["index"] > #KeyBindingSearch["results"] then
				KeyBindingSearch["index"] = 1
			end
			local newscroll =
				KEY_BINDING_HEIGHT*(KeyBindingSearch["results"][KeyBindingSearch["index"]])
				+ (KEY_BINDINGS_DISPLAYED-1)*2
			KeyBindingFrameScrollFrame:SetVerticalScroll(newscroll)
		end
end

function KeyBindingSearch_Search()
	editbox:ClearFocus()
	KeyBindingSearch["index"] = 1
	wipe(KeyBindingSearch["results"])
	for i=0,GetNumBindings() do
		local name
		local command = GetBinding(i)
		local isHeader = string.find(command, "HEADER_" , 1, true)
		if isHeader ~= nil and isHeader == 1 then
		
			name = _G["BINDING_"..command]
		else
			name = GetBindingText(command, "BINDING_NAME_")
		end
		if name == nil then
			name = command
		end
		name = strlower(name)
		local searchtext = strlower(editbox:GetText());
		if strlen(searchtext) > 0 and strfind(name,searchtext) then 
			tinsert(KeyBindingSearch["results"],i-2)
		end
	end
	KeyBindingSearchUpdate()
end

hooksecurefunc("KeyBindingFrame_LoadUI",function()
	if loaded then return end
	loaded = true
	editbox = CreateFrame("EditBox","KeyBindingSearchEditBox",KeyBindingFrame,"InputBoxTemplate")
	leftarrow = CreateFrame("Button","KeyBindingLastResultButton",KeyBindingFrame);
	rightarrow = CreateFrame("Button","KeyBindingNextResultButton",KeyBindingFrame);
	button = CreateFrame("Button","KeyBindingSearchButton",KeyBindingFrame,"UIPanelButtonTemplate")

	hooksecurefunc("KeyBindingFrame_UpdateUnbindKey",function()
		if KeyBindingFrameUnbindButton:IsEnabled() == 1 then
			editbox:Hide()
			button:Hide()
			rightarrow:Hide()
			leftarrow:Hide()
		else
			editbox:Show()
			button:Show()
			rightarrow:Show()
			leftarrow:Show()
		end
	end)
	
	editbox:SetPoint("TOPLEFT","KeyBindingFrame","BOTTOMLEFT",20,10);
	editbox:SetPoint("RIGHT","KeyBindingFrame","RIGHT",-235,0);
	editbox:SetHeight(20)
	editbox:SetAutoFocus(false)
	editbox:SetScript("OnEscapePressed",function()
		this:ClearFocus()
	end)
	editbox:SetScript("OnEnterPressed",KeyBindingSearch_Search)
	
	--50
	
	local t = leftarrow:CreateTexture(nil,"OVERLAY")
	t:SetTexture("Interface\\MoneyFrame\\Arrow-Left-Up.blp")
	t:SetAllPoints(leftarrow)
	leftarrow.texture = t
	
	leftarrow:SetPoint("TOPLEFT","KeyBindingSearchEditBox","TOPRIGHT",0,0);
	leftarrow:SetWidth(16)
	leftarrow:SetHeight(20)
	leftarrow:SetScript("OnClick",function()
		KeyBindingSearch["index"] = KeyBindingSearch["index"] - 1
		KeyBindingSearchUpdate()
	end)
	
	t = rightarrow:CreateTexture(nil,"OVERLAY")
	t:SetTexture("Interface\\MoneyFrame\\Arrow-Right-Up.blp")
	t:SetAllPoints(rightarrow)
	rightarrow.texture = t
	
	rightarrow:SetPoint("TOPLEFT","KeyBindingLastResultButton","TOPRIGHT",0,0);
	rightarrow:SetWidth(16)
	rightarrow:SetHeight(20)
	rightarrow:SetScript("OnClick",function()
		KeyBindingSearch["index"] = KeyBindingSearch["index"] + 1
		KeyBindingSearchUpdate()
	end)
	
	button:SetText("Search")
	button:SetPoint("TOPLEFT","KeyBindingNextResultButton","TOPRIGHT",0,0);
	button:SetWidth(130)
	button:SetHeight(20)
	button:SetScript("OnClick",KeyBindingSearch_Search)
end)