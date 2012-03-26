
------------------------------------------------------
-- Define PezUI LoginScripts namespace
------------------------------------------------------
pez.scripts = {};

------------------------------------------------------
-- Define PezUI LoginScripts options
------------------------------------------------------
pez.scripts.options = {}
pez.scripts.options.MOGIT_SCALE = .8;



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
			pez.scripts.mogItFixed = pez.scripts.copyGameTooltipStyle(self);
			
			-- scale frame
			self:SetScale(pez.scripts.options.MOGIT_SCALE);
		end
	end);
else
	pez.log("No MogItTooltip frame");
end


------------------------------------------------------
-- When a LibExtraTip tooltip frame is created, fix
-- the styling to match the default tooltip.
------------------------------------------------------
hooksecurefunc("CreateFrame", 
	function(type, name, parent, template) 
		if strfind(tostring(name), "LibExtraTip") then
			pez.scripts.copyGameTooltipStyle(_G[name]);
		end
	end
);
