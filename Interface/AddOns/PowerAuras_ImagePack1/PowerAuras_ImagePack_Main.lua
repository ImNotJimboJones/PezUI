PowaIP_X_Max = 6;
PowaIP_Y_Max = 6;

if not PowaIP_OnLoadFrame then	--only run one of these (if multiple Image packs are enabled)
	PowaIP_OnLoadFrame = CreateFrame("FRAME")
	PowaIP_OnLoadFrame:RegisterEvent("VARIABLES_LOADED");
	PowaIP_OnLoadFrame:SetScript("OnEvent", function() 
		PowaIP_OnLoad()
	end)
end

if not PowaIP_OnLoad then --only create one OnLoad function
	function PowaIP_OnLoad()
		PowaIP_SetupVariables();
		PowaIP_SetupImageFiles();
		PowaIP_SetupFrame();
		PowaIP_UpdatePreviews();
	end
end

if not PowaIP_SetupVariables then
	function PowaIP_SetupVariables()
		PowaIP_DB = PowaIP_DB or {};
		
		PowaIP_DB["Width"]  = PowaIP_DB["Width"]  or 400;
		PowaIP_DB["Height"] = PowaIP_DB["Height"] or 400;
	end
end

if not PowaIP_SetupImageFiles then
	function PowaIP_SetupImageFiles()
		PowerAuras_ImagePack_ImageInfo = {}; -- create an array to hold the list of Image packs		
		for i=1,20 do -- import from up to 20 Image packs (future proofing)
			if _G["PowerAuras_ImagePack" .. i .. "_ImageInfo"] then -- start adding Images from Image pack (if it exists)
				-- Create one long list of all the images
				local Path = _G["PowerAuras_ImagePack" .. i .. "_ImageInfo"]["Path"]
				table.foreach(_G["PowerAuras_ImagePack" .. i .. "_ImageInfo"]["FileList"], function(ArrayIDName, ArrayContents) 
					table.insert(PowerAuras_ImagePack_ImageInfo, Path .. ArrayContents)
				end)
			end
		end
	end
end


if not PowaIP_SetupFrame then
	function PowaIP_SetupFrame()
		PowaAuras.Orig_CustomTexPath = PowaAuras.CustomTexPath

		--Test: Interface\AddOns\RaidRoll\Images\Lich_King.tga

		function PowaAuras:CustomTexPath(customname)	
			local texpath;
			if string.find(customname,".", 1, true) then
				if string.find(string.lower(customname),"interface\\", 1, true) then
					texpath = customname;
				else
					texpath = PowaAuras:Orig_CustomTexPath(customname)
				end
			else
				texpath = PowaAuras:Orig_CustomTexPath(customname)
			end
			
			return texpath;
		end
		
		-- Show/Hide Button (child of PowaBarCustomTexName )
		PowaIP_ShowHideButton = CreateFrame("Button", "PowaIP_ShowHideButton", PowaBarCustomTexName, "UIPanelButtonTemplate")
		PowaIP_ShowHideButton:SetPoint("Left",PowaBarCustomTexName,"Right",0,0);
		PowaIP_ShowHideButton:SetSize(80, 20)
		PowaIP_ShowHideButton:SetText("Show >")
		PowaIP_ShowHideButton:SetScript("OnClick",	function() 
			if PowaIP_ImageContainer:IsShown() then
				PowaIP_ImageContainer:Hide();
				PowaIP_ShowHideButton:SetText("Show >")
			else
				PowaIP_ImageContainer:Show()
				PowaIP_ShowHideButton:SetText("Hide >")
			end
		end)
		
		-- Image container (main frame) (child of PowaBarCustomTexName )
		PowaIP_ImageContainer = CreateFrame("Frame", "PowaIP_ImageContainer", PowaBarCustomTexName);
		PowaIP_ImageContainer:SetPoint("TopLeft",PowaBarConfigFrame,"TopRight",0,0);
		PowaIP_ImageContainer:SetSize(PowaIP_DB["Width"], PowaIP_DB["Height"]);
		PowaIP_ImageContainer:SetBackdrop(PowaBarConfigFrame:GetBackdrop());
		PowaIP_ImageContainer:SetBackdropColor(PowaBarConfigFrame:GetBackdropColor());
		PowaIP_ImageContainer:SetBackdropBorderColor(PowaBarConfigFrame:GetBackdropBorderColor());
		PowaIP_ImageContainer:EnableMouseWheel(1)
		PowaIP_ImageContainer:SetScript("OnMouseWheel",function(self,delta)		
			PowaIP_ImageSlider:SetValue(PowaIP_ImageSlider:GetValue() - (delta * ceil(PowaIP_Y_Max/2)));
		end)
		PowaIP_ImageContainer:SetScript( "OnSizeChanged", function(self,w,h)
			PowaIP_UpdatePreviews(w,h);
		end);
		PowaIP_ImageContainer:Hide();
		
		-- square backdrop in the main frame
		PowaIP_ImageContainerBackground = CreateFrame("Frame", "PowaIP_ImageContainerBackground", PowaIP_ImageContainer);
		PowaIP_ImageContainerBackground:SetPoint("TopLeft",PowaIP_ImageContainer,"TopLeft",20,-25);
		PowaIP_ImageContainerBackground:SetPoint("BottomRight",PowaIP_ImageContainer,"BottomRight",-20,15);
		PowaIP_ImageContainerBackground:SetBackdrop(PowaBarConfigFrameEditor:GetBackdrop());
		PowaIP_ImageContainerBackground:SetBackdropColor(PowaBarConfigFrameEditor:GetBackdropColor());
		PowaIP_ImageContainerBackground:SetBackdropBorderColor(PowaBarConfigFrameEditor:GetBackdropBorderColor());
		
		-- draggable point in the main frame
		-- dragpoint from recount
		PowaIP_ImageContainerDragpoint = CreateFrame("Frame", "PowaIP_ImageContainerDragpoint", PowaIP_ImageContainer);
		PowaIP_ImageContainerDragpoint:SetSize(20, 20);
		PowaIP_ImageContainerDragpoint:SetPoint("BottomRight",PowaIP_ImageContainer,"BottomRight",-5,5);
		PowaIP_ImageContainerDragpoint:SetBackdrop(	{ bgFile = "Interface\\AddOns\\PowerAuras_ImagePack1\\AddonFiles\\ResizeGripRight.tga" });
		
		-- This allows the frame to be moved
		PowaIP_ImageContainer:SetResizable(true);
		PowaIP_ImageContainer:SetMaxResize(730, 715); -- Set the maximum dimensions this frame can be resized to. 
		PowaIP_ImageContainer:SetMinResize(175, 160);
		PowaIP_ImageContainerDragpoint:EnableMouse(true);
		PowaIP_ImageContainerDragpoint:SetScript("OnMouseDown",function()
			PowaIP_ImageContainer:StartSizing();
		end)
		PowaIP_ImageContainerDragpoint:SetScript("OnMouseUp",function()
			PowaIP_ImageContainer:StopMovingOrSizing();
			PowaIP_ImageContainer:ClearAllPoints();
			PowaIP_ImageContainer:SetPoint("TopLeft",PowaBarConfigFrame,"TopRight",0,0);
			
			PowaIP_DB["Width"] = floor(PowaIP_ImageContainer:GetWidth())
			PowaIP_DB["Height"] = floor(PowaIP_ImageContainer:GetHeight())
		end)
		
		-- Slider
		PowaIP_ImageSlider = CreateFrame("Slider", "PowaIP_ImageSlider", PowaIP_ImageContainer, "OptionsSliderTemplate")
		PowaIP_ImageSlider:SetWidth(15);
		PowaIP_ImageSlider:SetPoint("TopRight", PowaIP_ImageContainer, "TopRight",-25,-25);
		PowaIP_ImageSlider:SetPoint("BottomRight", PowaIP_ImageContainer, "BottomRight",-25,15);
		PowaIP_ImageSlider:SetOrientation("VERTICAL");
		PowaIP_ImageSlider:SetMinMaxValues(0, 10);
		PowaIP_ImageSlider:SetValueStep(1);
		PowaIP_ImageSlider:SetValue(0);
		_G["PowaIP_ImageSlider" .. "Low"]:SetText("");
		_G["PowaIP_ImageSlider" .. "High"]:SetText(""); 
		_G["PowaIP_ImageSlider" .. "Text"]:SetText("");
		PowaIP_ImageSlider:SetScript("OnValueChanged",function(self)			
			PowaIP_UpdatePreviews();
		end)
		
		-- The image previews
		local p = 0;
		for j=1,6 do	-- i = x, j = y
			for i=1,6 do
				p = p + 1;
				--PowaIP_ImagePreview_i_j = PowaIP_ImageContainerBackground:CreateTexture("PowaIP_ImagePreview:"..i..":"..j)
				PowaIP_ImagePreview_i_j = CreateFrame("Frame", "PowaIP_ImagePreview:" .. i .. ":" .. j, PowaIP_ImageContainerBackground)
				if i == 1 then
					if j == 1 then
						PowaIP_ImagePreview_i_j:SetPoint("TopLeft", PowaIP_ImageContainerBackground, "TopLeft", 10, -10) -- top left image
					else
						PowaIP_ImagePreview_i_j:SetPoint("TopLeft", _G["PowaIP_ImagePreview:".. i ..":".. j-1], "BottomLeft", 0, -10)
					end
				else
					PowaIP_ImagePreview_i_j:SetPoint("Left", _G["PowaIP_ImagePreview:".. i-1 ..":".. j], "Right", 10, 0)
				end
				
				PowaIP_ImagePreview_i_j:SetSize(100,100); 
				PowaIP_ImagePreview_i_j:SetBackdrop( { bgFile = PowerAuras_ImagePack_ImageInfo[p] });
				
				PowaIP_ImagePreview_i_j:SetScript("OnMouseUp", function(self)
					local _,i,j = strsplit(":", self:GetName())
					
					local Backdrop = self:GetBackdrop();
					PowaBarCustomTexName:SetText(Backdrop["bgFile"]);
					PowaAuras:CustomTextChanged();
					PowaAuras:CustomTexturesChecked();
				end)
				
				--PowaIP_ImagePreview_i_j:SetTexture( "Interface\\AddOns\\PowerAuras_ImagePack1\\AddonFiles\\Dummy.tga");
			end
		end
		PowaIP_UpdatePreviews(nil, nil);
		
--	--	--	--	--	--	--	--	--	--	--	
	function PowaIP_Strata_Dropdown_Initialize(self,level)
		level = 1;
		
		local PowaIP_StrataList = {
			"BACKGROUND",
			"LOW",
			"MEDIUM",
			"HIGH",
			"DIALOG",
			"FULLSCREEN",
			"FULLSCREEN_DIALOG",
			"TOOLTIP" 
		}
		
		for i=1,#PowaIP_StrataList do
			local info = UIDropDownMenu_CreateInfo();
			info.hasArrow = false;
			info.notCheckable = true;
			info.text = PowaIP_StrataList[i];
			info.func       = function(self)
				local ID = tonumber(self:GetID());
				local strata = PowaIP_StrataList[i]
				
				
				-- 
				-- PowaSet
				
				local AuraID = PowaAuras.CurrentAuraId;
				
				if PowaAuras.CurrentAuraId > 120 then
					PowaGlobalSet[AuraID]["strata"] = strata;
				end
				
				PowaSet[AuraID]["strata"] = strata

				PowaAuras:BarAuraCoordXSliderChanged();
			end; 
			
			UIDropDownMenu_AddButton(info, level);
		end
	end
	
	PowaIP_Strata_Dropdown = CreateFrame("Frame", "PowaIP_Strata_Dropdown", PowaBarConfigFrame, "UIDropDownMenuTemplate");
	PowaIP_Strata_Dropdown:SetPoint("TopRight",-70,-30);
	PowaIP_Strata_Dropdown:SetWidth(100);
	
	_G["PowaIP_Strata_Dropdown".."Text"]:SetText("Strata")	
	UIDropDownMenu_Initialize(PowaIP_Strata_Dropdown, PowaIP_Strata_Dropdown_Initialize);
--	--	--	--	--	--	--	--	--	--	--	
	end
end

-- PowaAuras.CurrentAuraId

-- PowaGlobalSet
-- PowaSet

function PowaIP_UpdatePreviews(w,h)
	local Width  = w or PowaIP_ImageContainer:GetWidth();
	local Height = h or PowaIP_ImageContainer:GetHeight();
	
	local P_Width  = PowaIP_ImagePreview_i_j:GetWidth();
	local P_Height = PowaIP_ImagePreview_i_j:GetHeight();
	
	PowaIP_X_Max = floor((Width  - 65)/(P_Width  + 10))
	PowaIP_Y_Max = floor((Height - 50)/(P_Height + 10))
	
	local Offset = PowaIP_ImageSlider:GetValue();
	
	local p = floor(0 + (Offset * PowaIP_X_Max));
	for j=1,6 do
		for i=1,6 do
			if i <= PowaIP_X_Max then
				if j <= PowaIP_Y_Max then
					_G["PowaIP_ImagePreview:"..i..":"..j]:Show();
					
					p = p + 1;					
					_G["PowaIP_ImagePreview:"..i..":"..j]:SetBackdrop( { bgFile = PowerAuras_ImagePack_ImageInfo[p] });
				else
					_G["PowaIP_ImagePreview:"..i..":"..j]:Hide();
				end
			else
				_G["PowaIP_ImagePreview:"..i..":"..j]:Hide();
			end
		end
	end
	
	
	PowaIP_ImageSlider:SetMinMaxValues(0, (#PowerAuras_ImagePack_ImageInfo/PowaIP_X_Max) - PowaIP_Y_Max);
	
	--print(Height)
	--print(X_Shown)
end