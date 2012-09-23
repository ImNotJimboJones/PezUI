
------------------------------------------------------
-- Define PezUI LoginScripts namespace
------------------------------------------------------
pez.scripts = {};

------------------------------------------------------
-- Define PezUI LoginScripts options
------------------------------------------------------
pez.scripts.options = {
	TOOLTIP_CLAMP_INSET_ADJUST_ENABLED = true,
	TOOLTIP_CLAMP_INSET_ADJUST = 20.0;
	VUHDO_AUTO_PROFILE_LOGIN_FIX = true
};



------------------------------------------------------
-- Functions
------------------------------------------------------

--**************************************************--
-- Tells VuhDo to auto-load the appropriate profile
-- based on the current group size.
-- @return		the name of the loaded profile
--**************************************************--
function pez.scripts.loadVuhDoProfile()
	local profile = VUHDO_getBestProfileAfterSizeChange();
	VUHDO_loadProfile(profile);
	return profile;
end


------------------------------------------------------
-- When the default game tooltip is shown for the first
-- time, adjust the top clamp inset so it never overlaps 
-- the Titan/LDB panel at the top of the screen.
------------------------------------------------------
if (pez.scripts.options.TOOLTIP_CLAMP_INSET_ADJUST_ENABLED) then
	local l,r,t,b = GameTooltip:GetClampRectInsets();
	t = (t + pez.scripts.options.TOOLTIP_CLAMP_INSET_ADJUST);
	GameTooltip:SetClampRectInsets(l,r,t,b);
end



------------------------------------------------------
-- Register an event to auto-load VuhDo profile when
-- player enters the world.
------------------------------------------------------
if(pez.scripts.options.VUHDO_AUTO_PROFILE_LOGIN_FIX) then
	local vuhDoAutoLoadEventFrame = CreateFrame("FRAME", "Pez_VuhDoAutoLoadFrame");
	vuhDoAutoLoadEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	local function vuhDoAutoLoadEventHandler(self, event, ...)
		if (event == "PLAYER_ENTERING_WORLD") then
			local profile = pez.scripts.loadVuhDoProfile();
			pez.log("Loaded VuhDo profile: " .. profile);
		end
	end
	vuhDoAutoLoadEventFrame:SetScript("OnEvent", vuhDoAutoLoadEventHandler);
end