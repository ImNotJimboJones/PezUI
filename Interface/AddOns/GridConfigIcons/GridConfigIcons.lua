-- -------------------------------------------------------------------------- --
-- GridConfigIcons by kunda                                                   --
-- -------------------------------------------------------------------------- --
--                                                                            --
-- Adds icons to the configuration menu for all standard Grid indicators.     --
--                                                                            --
-- Easier visible indicator recognition (where an indicator is located and    --
-- what status can be assigned to it).                                        --
--                                                                            --
-- Icon Colors:                                                               --
--  Default border: Darkgrey                                                  --
--  Box : Blue (box indicator = single color = any expect icon/text only)     --
--  Icon: Yellow (icon indicator only)                                        --
--  Text: Lightgrey (text indicator only)                                     --
--                                                                            --
-- -------------------------------------------------------------------------- --

local GridFrame = Grid:GetModule("GridFrame")
if not GridFrame then return end
local GridConfigIcons = CreateFrame("Frame")

local function SetupIcons()
	if not GridFrame then return end
	if Grid.options.args.Indicators.args.corner1 then
		Grid.options.args.Indicators.args.corner1.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Box-Corner1"
	end
	if Grid.options.args.Indicators.args.corner2 then
		Grid.options.args.Indicators.args.corner2.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Box-Corner2"
	end
	if Grid.options.args.Indicators.args.corner3 then
		Grid.options.args.Indicators.args.corner3.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Box-Corner3"
	end
	if Grid.options.args.Indicators.args.corner4 then
		Grid.options.args.Indicators.args.corner4.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Box-Corner4"
	end

	if Grid.options.args.Indicators.args.border then
		Grid.options.args.Indicators.args.border.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Box-Border"
	end

	if Grid.options.args.Indicators.args.icon then
		Grid.options.args.Indicators.args.icon.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Icon-CenterIcon"
	end

	if Grid.options.args.Indicators.args.frameAlpha then
		Grid.options.args.Indicators.args.frameAlpha.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Box-FrameAlpha"
	end

	if Grid.options.args.Indicators.args.text then
		if not GridFrame.db.profile.enableText2 then
			if GridFrame.db.profile.textorientation == "VERTICAL" then
				Grid.options.args.Indicators.args.text.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Text-Text-center"
			else
				Grid.options.args.Indicators.args.text.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Text-Text-h"
			end
		else
			if GridFrame.db.profile.textorientation == "VERTICAL" then
				Grid.options.args.Indicators.args.text.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Text-Text-v"
			else
				Grid.options.args.Indicators.args.text.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Text-Text-h"
			end
		end
	end
	if Grid.options.args.Indicators.args.text2 then
		if GridFrame.db.profile.textorientation == "VERTICAL" then
			Grid.options.args.Indicators.args.text2.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Text-Text2-v"
		else
			Grid.options.args.Indicators.args.text2.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Text-Text2-h"
		end
	end

	if Grid.options.args.Indicators.args.barcolor then
		if GridFrame.db.profile.orientation == "VERTICAL" then
			Grid.options.args.Indicators.args.barcolor.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Box-Barcolor-v"
		else
			Grid.options.args.Indicators.args.barcolor.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Box-Barcolor-h"
		end
	end
	if Grid.options.args.Indicators.args.healingBar then
		if GridFrame.db.profile.orientation == "VERTICAL" then
			Grid.options.args.Indicators.args.healingBar.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Box-HealingBar-v"
		else
			Grid.options.args.Indicators.args.healingBar.icon = "Interface\\AddOns\\GridConfigIcons\\GridConfigIcons-icon-Box-HealingBar-h"
		end
	end
end

local function OnEvent(self, event)
	if event == "PLAYER_LOGIN" then
		SetupIcons()
		hooksecurefunc(GridFrame, "UpdateOptionsMenu", SetupIcons)
		hooksecurefunc(GridFrame, "WithAllFrames", SetupIcons)
		GridConfigIcons:UnregisterEvent("PLAYER_LOGIN")
	end
end

GridConfigIcons:RegisterEvent("PLAYER_LOGIN")
GridConfigIcons:SetScript("OnEvent", OnEvent)