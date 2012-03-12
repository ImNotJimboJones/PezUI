if not PowaSP_OnLoadFrame then	--only run one of these (if multiple sound packs are enabled)
	PowaSP_OnLoadFrame = CreateFrame("FRAME")
	PowaSP_OnLoadFrame:RegisterEvent("VARIABLES_LOADED");
	PowaSP_OnLoadFrame:SetScript("OnEvent", function() 
		PowaSP_OnLoad()
	end)
end

if not PowaSP_OnLoad then --only create one OnLoad function
	function PowaSP_OnLoad()
		PowaSP_SetupSoundFiles()
		PowaSP_SetupFrame()
	end
end

if not PowaSP_SetupSoundFiles then
	function PowaSP_SetupSoundFiles()
		PowerAuras_SoundPack_SoundInfo = {}; -- create an array to hold the list of sound packs
		local PowerAuras_SoundPack_SoundInfo_i = 0;	-- set the index to 0 (reset)
		
		for i=1,20 do -- import from up to 20 sound packs (future proofing)
			for j=1,10 do
				if _G["PowerAuras_SoundPack" .. i .. "_" .. j ..  "_SoundInfo"] then -- start adding sounds from sound pack (if it exists)
					PowerAuras_SoundPack_SoundInfo_i = PowerAuras_SoundPack_SoundInfo_i + 1;	--increment the index
					local k = PowerAuras_SoundPack_SoundInfo_i;	-- using k to make it easier to follow what is happening
					PowerAuras_SoundPack_SoundInfo[k] = {	-- import data from the sound pack
						["Name"] = _G["PowerAuras_SoundPack" .. i .. "_" .. j ..  "_SoundInfo"]["Name"],
						["Path"] = _G["PowerAuras_SoundPack" .. i .. "_" .. j ..  "_SoundInfo"]["Path"],
						["Info"] = _G["PowerAuras_SoundPack" .. i .. "_" .. j ..  "_SoundInfo"],
						
					}
				end
			end
		end
	end
end


if not PowaSP_SetupFrame then
	function PowaSP_SetupFrame()
	-- Sound Select Box (top) (begin) ------------------------------------------------------------------------------------------------------
			PowaSP_CustomSounds_DescriptionText=PowaBarConfigFrameEditor5:CreateFontString("PowaSP_CustomSounds_DescriptionText","ARTWORK","GameFontNormal");	--create the top text
			PowaSP_CustomSounds_DescriptionText:SetPoint("TopLeft",PowaBarConfigFrameEditor5,"TopLeft",280,-30);	-- position it
			PowaSP_CustomSounds_DescriptionText:SetText("Sound Pack");	-- set the text
			
			function PowaSP_SoundSelect_Dropdown_Initialize(self,level)	-- initialize function (called on menu creation)
				level = level or 1;
				
				if level == 1 then
					for i=1,#PowerAuras_SoundPack_SoundInfo do	-- create a list of files
						local info = UIDropDownMenu_CreateInfo();
						info.hasArrow = true;	-- no arrow (for sub menus)
						info.notCheckable = true;	-- not checkable (dot)
						info.keepShownOnClick = true;	-- keep showing the menu when this is clicked
						info.text = PowerAuras_SoundPack_SoundInfo[i]["Name"];	-- set the text (name of the file)
						info.value = {["Level1_Key"] = i;};	-- set an ID value (so we know what sub layer we are on)
						UIDropDownMenu_AddButton(info, level);	-- add that button to the menu
					end
				else
					local ID = UIDROPDOWNMENU_MENU_VALUE["Level1_Key"];
					local SoundInfo =  PowerAuras_SoundPack_SoundInfo[ID]["Info"];
					local SoundPath = PowerAuras_SoundPack_SoundInfo[ID]["Path"];
					
					for i=1,#SoundInfo do	-- create a list of files
						local info = UIDropDownMenu_CreateInfo();
						info.hasArrow = false;	-- no arrow (for sub menus)
						info.notCheckable = true;	-- not checkable (dot)
						info.keepShownOnClick = true;	-- keep showing the menu when this is clicked
						info.text = SoundInfo[i]["Name"];	-- set the text (name of the file)
						info.func       = function(self)	--function called on click
							local ID = self:GetID();	-- find out which file was picked
							local Sound = SoundInfo[ID];	-- the data (file and path) of the file is now stored in "Sound" (to make it easier to follow)
							local File = Sound["File"];	-- the file name (e.g. "bam.ogg")
							local Path = SoundPath;	-- the file path (e.g. "Interface\\AddOns\\PowerAuras_SoundPack1\\Sounds\\")
							
							PowaBarCustomSound:SetText(Path .. File)	-- set the custom text to the path
						end; 
						
						UIDropDownMenu_AddButton(info, level);	-- add that button to the menu
					end
				end
			end
			
			PowaSP_SoundSelect_Dropdown = CreateFrame("Frame", "PowaSP_SoundSelect_Dropdown", PowaBarConfigFrameEditor5, "UIDropDownMenuTemplate");	-- dropdown menu creation
			PowaSP_SoundSelect_Dropdown:SetPoint("TopLeft",PowaSP_CustomSounds_DescriptionText,"BottomLeft",-20,0);	-- place it below the text
			PowaSP_SoundSelect_Dropdown:SetWidth(100);	-- set its width
			_G["PowaSP_SoundSelect_Dropdown".."Text"]:SetText("Select Sound")	-- set its text
			
			UIDropDownMenu_Initialize(PowaSP_SoundSelect_Dropdown, PowaSP_SoundSelect_Dropdown_Initialize);	-- initialize the menu
		-- Sound Select Box (top) (end) ------------------------------------------------------------------------------------------------------	
		
	-- Sound Select Box (bottom) (begin) ------------------------------------------------------------------------------------------------------
			PowaSP_CustomSounds_DescriptionText=PowaBarConfigFrameEditor5:CreateFontString("PowaSP_CustomSounds_DescriptionText","ARTWORK","GameFontNormal");	--create the top text
			PowaSP_CustomSounds_DescriptionText:SetPoint("TopLeft",PowaBarConfigFrameEditor5,"TopLeft",280,-185);	-- position it
			PowaSP_CustomSounds_DescriptionText:SetText("Sound Pack");	-- set the text
			
			function PowaSP_SoundSelect_Dropdown_Initialize_End(self,level)	-- initialize function (called on menu creation)
				level = level or 1;
				
				if level == 1 then
					for i=1,#PowerAuras_SoundPack_SoundInfo do	-- create a list of files
						local info = UIDropDownMenu_CreateInfo();
						info.hasArrow = true;	-- no arrow (for sub menus)
						info.notCheckable = true;	-- not checkable (dot)
						info.keepShownOnClick = true;	-- keep showing the menu when this is clicked
						info.text = PowerAuras_SoundPack_SoundInfo[i]["Name"];	-- set the text (name of the file)
						info.value = {["Level1_Key"] = i;};	-- set an ID value (so we know what sub layer we are on)
						UIDropDownMenu_AddButton(info, level);	-- add that button to the menu
					end
				else
					local ID = UIDROPDOWNMENU_MENU_VALUE["Level1_Key"];
					local SoundInfo =  PowerAuras_SoundPack_SoundInfo[ID]["Info"];
					local SoundPath = PowerAuras_SoundPack_SoundInfo[ID]["Path"];
					
					for i=1,#SoundInfo do	-- create a list of files
						local info = UIDropDownMenu_CreateInfo();
						info.hasArrow = false;	-- no arrow (for sub menus)
						info.notCheckable = true;	-- not checkable (dot)
						info.keepShownOnClick = true;	-- keep showing the menu when this is clicked
						info.text = SoundInfo[i]["Name"];	-- set the text (name of the file)
						info.func       = function(self)	--function called on click
							local ID = self:GetID();	-- find out which file was picked
							local Sound = SoundInfo[ID];	-- the data (file and path) of the file is now stored in "Sound" (to make it easier to follow)
							local File = Sound["File"];	-- the file name (e.g. "bam.ogg")
							local Path = SoundPath;	-- the file path (e.g. "Interface\\AddOns\\PowerAuras_SoundPack1\\Sounds\\")
							
							PowaBarCustomSoundEnd:SetText(Path .. File)	-- set the custom text to the path
						end; 
						
						UIDropDownMenu_AddButton(info, level);	-- add that button to the menu
					end
				end
			end
			
			PowaSP_SoundSelect_Dropdown_End = CreateFrame("Frame", "PowaSP_SoundSelect_Dropdown_End", PowaBarConfigFrameEditor5, "UIDropDownMenuTemplate");	-- dropdown menu creation
			PowaSP_SoundSelect_Dropdown_End:SetPoint("TopLeft",PowaSP_CustomSounds_DescriptionText,"BottomLeft",-20,0);	-- place it below the text
			PowaSP_SoundSelect_Dropdown_End:SetWidth(100);	-- set its width
			_G["PowaSP_SoundSelect_Dropdown_End".."Text"]:SetText("Select Sound")	-- set its text
			
			UIDropDownMenu_Initialize(PowaSP_SoundSelect_Dropdown_End, PowaSP_SoundSelect_Dropdown_Initialize_End);	-- initialize the menu
		-- Sound Select Box (bottom) (end) ------------------------------------------------------------------------------------------------------	
	end
end