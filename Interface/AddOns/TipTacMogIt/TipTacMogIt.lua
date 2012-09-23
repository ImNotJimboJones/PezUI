
-- The first time the MogIt tooltip is shown, register it with TipTac
local registered = false;
MogItTooltip:HookScript("OnShow", function()

	-- If no tooltip frame, or already registered, do nothing
	if (not MogItTooltip or registered) then
		return;
	end
	
	-- Register tooltip frame with TipTac
	TipTac:AddModifiedTip(MogItTooltip);
	
	-- Make sure we don't do this again
	registered = true;
end);