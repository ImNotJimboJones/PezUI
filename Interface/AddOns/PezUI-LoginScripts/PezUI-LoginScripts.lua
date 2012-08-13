
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
	LIB_EXTRA_TIP_STYLE_COPY_ENABLED = true,
	MOGIT_STYLE_COPY_ENABLED = true,
	MOGIT_SCALE_ENABLED = true,
	MOGIT_SCALE = 0.8,
	VUHDO_AUTO_PROFILE_LOGIN_FIX = true
};



------------------------------------------------------
-- Functions
------------------------------------------------------

--**************************************************--
-- Copies the style of the default tooltip to a given
-- tooltip frame.
-- @param tooltip	A tooltip frame
-- @return		true on success; false otherwise
--**************************************************--
function pez.scripts.copyGameTooltipStyle(tooltip)
	-- validate argument is a tooltip
	if (not tooltip) 
		or (type(tooltip) ~= "table") 
		or (type(tooltip.GetObjectType) ~= "function") 
		or (tooltip:GetObjectType() ~= "GameTooltip" and tooltip:GetObjectType() ~= "Frame") then
		return false;
	end

	-- copy styling from default tooltip to given tooltip
	pez.log("Copying tooltip to "..tooltip:GetName());
	tooltip:SetBackdrop(GameTooltip:GetBackdrop());
	tooltip:SetBackdropColor(GameTooltip:GetBackdropColor());
	tooltip:SetBackdropBorderColor(GameTooltip:GetBackdropBorderColor());
	return true;
end

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
-- The first time the MogIt model tooltip is shown, 
-- fix the styling to match the default tooltip, 
-- and scale the frame down.
------------------------------------------------------

pez.scripts.mogItFixed = false;
if (MogItTooltip) then
	MogItTooltip:HookScript("OnShow", function(self)
		if (not pez.scripts.mogItFixed) then
			-- fix styling
			if (pez.scripts.options.MOGIT_STYLE_COPY_ENABLED) then
				pez.scripts.mogItFixed = pez.scripts.copyGameTooltipStyle(self);
			else
				pez.scripts.mogItFixed = true;
			end
			
			-- scale frame
			if (pez.scripts.options.MOGIT_SCALE_ENABLED) then
				self:SetScale(pez.scripts.options.MOGIT_SCALE);
			end
		end
	end);
else
	pez.log("No MogItTooltip frame");
end


------------------------------------------------------
-- When a LibExtraTip tooltip frame is created, fix
-- the styling to match the default tooltip.
------------------------------------------------------
if (LIB_EXTRA_TIP_STYLE_COPY_ENABLED) then
	hooksecurefunc("CreateFrame", 
		function(type, name, parent, template) 
			if strfind(tostring(name), "LibExtraTip") then
				pez.scripts.copyGameTooltipStyle(_G[name]);
			end
		end
	);
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