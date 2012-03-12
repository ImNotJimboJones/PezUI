---------
function GoGoPet_OnLoad()
---------
	SlashCmdList["GOGOPET"] = function(msg) GoGoPet_OnSlash(msg) end
	SLASH_GOGOPET1 = "/gogopet"
	GoGoPetFrame:RegisterEvent("VARIABLES_LOADED")
	GoGoPetFrame:RegisterEvent("UPDATE_BINDINGS")
	GoGoPetFrame:RegisterEvent("CHAT_MSG_ADDON");
	GoGoPetFrame:RegisterEvent("CHAT_MSG_SYSTEM");
end --function

---------
function GoGoPet_OnEvent(event)
---------
	if event == "VARIABLES_LOADED" then
		if not GoGoPet_Prefs then
			GoGoPet_Prefs = {useconsume = true,}
		end --if
		if not GoGoPet_Prefs.version or GoGoPet_Prefs.version ~= GetAddOnMetadata("GoGoPet", "Version") then
			GoGoPet_Prefs.version = GetAddOnMetadata("GoGoPet", "Version")
			GoGoPet_Prefs.useconsume = true
		end --if
		GoGoPet_Variables = {}
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		SetMapToCurrentZone()
	elseif event == "UPDATE_BINDINGS" then
		if not InCombatLockdown() then  -- ticket 213
			GoGoPet_CheckBindings()
		end --if
	elseif (event == "CHAT_MSG_ADDON") and (arg1 == "GoGoPetVER") and not GoGoPet_Variables.ShownUpdate then
		local major, minor, build = tonumber(arg2)
		if major > GoGoPet_Variables.VerMajor then
			GoGoPet_Variables.ShownUpdate = true
		elseif (major == GoGoPet_Variables.VerMajor) and (minor > GoGoPet_Variables.VerMinor) then
			GoGoPet_Variables.ShownUpdate = true
		elseif (major == GoGoPet_Variables.VerMajor) and (minor > GoGoPet_Variables.VerMinor) and (build > GoGoPet_Variables.VerBuild) then
			GoGoPet_Variables.ShownUpdate = true
		end --if
		
		if GoGoPet_Variables.ShownUpdate then
			GoGoPet_Msg("** GoGoPet update is available and is being used by "..arg4)
		end --if
	end --if
end --function

---------
function GoGoPet_OnSlash(msg)
---------
	if GoGoPet_COMMANDS[string.lower(msg)] then
		GoGoPet_COMMANDS[string.lower(msg)]()
	elseif string.find(msg, "spell:%d+") then
		if GoGoPet_InCompanions(msg) then
			GoGoPet_AddPrefPet(GoGoPet_InCompanions(msg))
			GoGoPet_Msg("pref")
		else
			GoGoPet_Msg("pref")
		end --if
	else
		GoGoPet_Msg("pref")
	end --if
end --function

---------
function GoGoPet_PreClick(button)
---------
	if not InCombatLockdown() then
		GoGoPet_FillButton(button, GoGoPet_ChoosePet())
	end --if

	if ( IsInGuild() ) then
		SendAddonMessage("GoGoPetVER", GetAddOnMetadata("GoGoPet", "Version"), "GUILD")
	end --if
--		SendAddonMessage("GoGoPetVER", GetAddOnMetadata("GoGoPet", "Version"), "BATTLEGROUND")
--		SendAddonMessage("GoGoPetVER", GetAddOnMetadata("GoGoPet", "Version"), "RAID")

end --function

---------
function GoGoPet_ChoosePet(some_pets)
---------
	local pets = GoGoPet_FindPets()
	if pets then
		return pets[math.random(table.getn(pets))]
	end --if
end --function

---------
function GoGoPet_FindPets()
---------
	local loc = GetRealZoneText()

	if GoGoPet_Prefs[loc] then
		return GoGoPet_Prefs[loc]
	end --if

	return GoGoPet_Petlist()
	
end --function

---------
function GoGoPet_AddPrefPet(item)
---------
	local loc = GetRealZoneText()
	if not GoGoPet_Prefs[loc] then GoGoPet_Prefs[loc] = {} end
	table.insert(GoGoPet_Prefs[loc], item)
	if table.getn(GoGoPet_Prefs[loc]) > 1 then
		local i = 2
		repeat
			if GoGoPet_Prefs[loc][i] == GoGoPet_Prefs[loc][i - 1] then
				table.remove(GoGoPet_Prefs[loc], i)
			else
				i = i + 1
			end --if
		until i > table.getn(GoGoPet_Prefs[loc])
	end --if
end --function

---------
function GoGoPet_FillButton(button, pet)
---------
	if pet then
		button:SetAttribute("macrotext", "/cast "..pet)
	else
		button:SetAttribute("macrotext", nil)
	end --if
end --function

---------
function GoGoPet_CheckBindings()
---------
	for binding, button in pairs({GOGOPETBINDING = GoGoPetButton}) do
		ClearOverrideBindings(button)
		local key1, key2 = GetBindingKey(binding)
		if key1 then
			SetOverrideBindingClick(button, true, key1, button:GetName())
		end --if
		if key2 then
			SetOverrideBindingClick(button, true, key2, button:GetName())
		end --if
	end --if
end --function

---------
function GoGoPet_Msg(msg)
---------
	if msg then
		if GoGoPet_MESSAGES[msg] then
			GoGoPet_Msg(GoGoPet_MESSAGES[msg]())
		else
			msg = string.gsub(msg, "<", LIGHTYELLOW_FONT_COLOR_CODE)
			msg = string.gsub(msg, ">", "|r")
			DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE.."GoGo: |r"..msg)
		end --if
	end --if
end --function

---------
function GoGoPet_InCompanions(item)
---------
	for slot = 1, GetNumCompanions("CRITTER") do
		local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("CRITTER", slot)
		if spellID and string.find(item, spellID) then
			return GetSpellInfo(spellID)
		end --if
	end --for
end --function

---------
function GoGoPet_Petlist()
---------
	GOGOPET_PETS = {}
	if (GetNumCompanions("CRITTER") == 0) then
		DEFAULT_CHAT_FRAME:AddMessage(GoGoPet_Msg("No pets found."))
	else
		for slot = 1, GetNumCompanions("CRITTER"),1 do
			local _, _, SpellID, _, Active = GetCompanionInfo("CRITTER", slot)
--			GoGoPet_Prefs[creatureName] = true
			if not active then
				name = GetSpellInfo(SpellID)
				table.insert(GOGOPET_PETS, name)
			end --if
		end --for
		return GOGOPET_PETS
	end --if
end

GoGoPet_COMMANDS = {
	["clear"] = function()
		GoGoPet_Prefs[GetRealZoneText()] = nil
		if not InCombatLockdown() then
			for i, button in ipairs({GoGoPetButton}) do
				GoGoPet_FillButton(button)
			end --for
		end --if
		GoGoPet_Msg("pref")
	end, --function
}

GoGoPet_MESSAGES = {
	["pref"] = function()
		local loc = GetRealZoneText()
		local list = ""
		if GoGoPet_Prefs[loc] then
			list = list..table.concat(GoGoPet_Prefs[loc], ", ")
			return loc..": "..list.." - </gogopet clear> to clear"
		else
			return loc..": ?".." - </gogopet ItemLink> to add"
		end --if
	end, --function
}