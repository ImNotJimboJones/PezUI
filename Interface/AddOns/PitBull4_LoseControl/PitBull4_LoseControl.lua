
--============================================================================--
-- Initialization
--============================================================================--

-- Get reference to PitBull4
local PitBull4 = _G.PitBull4

-- No PitBull4?
if (not PitBull4) then
	error("PitBull4_LoseControl requires Pitbull4");
end


-- Create PitBull4 module
local PBLC = PitBull4:NewModule("LoseControl", "AceHook-3.0");
PBLC:SetModuleType("custom");
PBLC:SetName("LoseControl");
PBLC:SetDescription("Integrates LoseControl indicators into PitBull4 frames");
PBLC:SetDefaults(nil);



--============================================================================--
-- Private Fields
--============================================================================--

-- Strata and level of LoseControl frames
local FRAME_STRATA = "HIGH";
local FRAME_LEVEL = 20;

-- PitBull4/LoseControl frame association
local loseControlFrameNames = {
	PitBull4_Frames_player = 	"LoseControlplayer",			-- player
	PitBull4_Frames_target = 	"LoseControltarget",			-- target
	PitBull4_Frames_pet = 		"LoseControlpet",				-- pet
	PitBull4_Frames_focus = 	"LoseControlfocus",				-- focus
	PitBull4_Groups_PartyUnitButton1 = "LoseControlparty1",		-- party 1
	PitBull4_Groups_PartyUnitButton2 = "LoseControlparty2",		-- party 2
	PitBull4_Groups_PartyUnitButton3 = "LoseControlparty3",		-- party 3
	PitBull4_Groups_PartyUnitButton4 = "LoseControlparty4"		-- party 4
}
local pitBullFrameNames = {
	LoseControlplayer =	"PitBull4_Frames_player",				-- player
	LoseControltarget =	"PitBull4_Frames_target",				-- target
	LoseControlpet =	"PitBull4_Frames_pet",					-- pet
	LoseControlfocus =	"PitBull4_Frames_focus",				-- focus
	LoseControlparty1 =	"PitBull4_Groups_PartyUnitButton1",		-- party 1
	LoseControlparty2 =	"PitBull4_Groups_PartyUnitButton2",		-- party 2
	LoseControlparty3 =	"PitBull4_Groups_PartyUnitButton3",		-- party 3
	LoseControlparty4 =	"PitBull4_Groups_PartyUnitButton4"		-- party 4
}


--============================================================================--
-- Functions
--============================================================================--

function PBLC.MoveFrameToTarget(frame, target)
		if (frame == nil or target == nil) then
			return
		end

		frame:ClearAllPoints();
		frame:SetPoint("CENTER", target);
		frame:SetFrameStrata(FRAME_STRATA);
		frame:SetFrameLevel(FRAME_LEVEL);
end

function PBLC.MoveLoseControlFrameToPitBullFrame(loseControlFrame)
	-- Get PitBull4 frame name
	local pitBullFrameName = pitBullFrameNames[loseControlFrame:GetName()];
	
	-- If no frame name found (no association), just return
	if (pitBullFrameName == nil) then
		return;
	end
	
	-- Get PitBull4 frame
	local pitBullFrame = _G[pitBullFrameName];
	
	-- Update PitBull4 frame
	PBLC.MoveFrameToTarget(loseControlFrame, pitBullFrame);
end


--============================================================================--
-- Callbacks
--============================================================================--

function PBLC:OnEnable()
	-- When a LoseControl frame is shown, 
	-- move it to its associated PitBull4 frame
	for lcFrameName, pbFrameName in pairs(pitBullFrameNames) do
		-- Get LoseControl Frame
		lcFrame = _G[lcFrameName];
		
		-- Hook "OnShow" script
		PBLC:SecureHookScript(lcFrame, "OnShow", PBLC.MoveLoseControlFrameToPitBullFrame);
	end
end

function PBLC:OnDisable()
	for lcFrameName, pbFrameName in pairs(pitBullFrameNames) do
		-- Get LoseControl Frame
		lcFrame = _G[lcFrameName];
		
		-- Unhook "OnShow" script
		PBLC:Unhook(lcFrame, "OnShow");
	end
end

function PBLC:OnInitialize()
end

function PBLC:UpdateFrame(pitBullFrame)
	-- Get PitBull4 frame name
	local pitBullFrameName = pitBullFrame:GetName();
	
	-- Get LoseControl frame name
	loseControlFrameName = loseControlFrameNames[pitBullFrameName];
	
	-- If no frame name found (no association), just return
	if (loseControlFrameName == nil) then
		return;
	end
		
	-- Get LoseControl frame
	local loseControlFrame = _G[loseControlFrameName];
	
	-- Place LoseControlFrame;
	PBLC.MoveFrameToTarget(loseControlFrame, pitBullFrame);
end
