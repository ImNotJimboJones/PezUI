-- BURST CACHE ---------------------------------------------------
local VUHDO_PANEL_SETUP;
local VUHDO_getHeaderWidthHor;
local VUHDO_getHeaderWidthVer;
local VUHDO_getHeaderHeightHor;
local VUHDO_getHeaderHeightVer;
local VUHDO_getHeaderPosHor;
local VUHDO_getHeaderPosVer;
local VUHDO_getHealButtonPosHor;
local VUHDO_getHealButtonPosVer;

function VUHDO_sizeCalculatorInitBurst()
	VUHDO_PANEL_SETUP = _G["VUHDO_PANEL_SETUP"];
	VUHDO_sizeCalculatorInitBurstHor();
	VUHDO_sizeCalculatorInitBurstVer();

	VUHDO_getHeaderWidthHor = _G["VUHDO_getHeaderWidthHor"];
	VUHDO_getHeaderWidthVer = _G["VUHDO_getHeaderWidthVer"];
	VUHDO_getHeaderHeightHor = _G["VUHDO_getHeaderHeightHor"];
	VUHDO_getHeaderHeightVer = _G["VUHDO_getHeaderHeightVer"];
	VUHDO_getHeaderPosHor = _G["VUHDO_getHeaderPosHor"];
	VUHDO_getHeaderPosVer = _G["VUHDO_getHeaderPosVer"];
	VUHDO_getHealButtonPosHor = _G["VUHDO_getHealButtonPosHor"];
	VUHDO_getHealButtonPosVer = _G["VUHDO_getHealButtonPosVer"];
end

-- BURST CACHE ---------------------------------------------------


local sHealButtonWidthCache = { };
local sTopHeightCache = { };
local sBottomHeightCache = { };

function resetSizeCalcCaches()
	table.wipe(sHealButtonWidthCache);
	table.wipe(sTopHeightCache);
	table.wipe(sBottomHeightCache);
	VUHDO_resetSizeCalcCachesHor();
	VUHDO_resetSizeCalcCachesVer();
end




-- Returns the total height of optional threat bars
function VUHDO_getAdditionalTopHeight(aPanelNum)
	if (sTopHeightCache[aPanelNum] == nil) then
		local tTopSpace;

		if (VUHDO_INDICATOR_CONFIG["BOUQUETS"]["THREAT_BAR"] ~= "") then
			tTopSpace = VUHDO_INDICATOR_CONFIG["CUSTOM"]["THREAT_BAR"]["HEIGHT"];
		else
			tTopSpace = 0;
		end

		local tNamePos = VUHDO_splitString(VUHDO_PANEL_SETUP[aPanelNum]["ID_TEXT"]["position"], "+");
		if (strfind(tNamePos[1], "BOTTOM", 1, true) and strfind(tNamePos[2], "TOP", 1, true)) then
			local tNameHeight = VUHDO_PANEL_SETUP[aPanelNum]["ID_TEXT"]["_spacing"];
			if (tNameHeight ~= nil and tNameHeight > tTopSpace) then
				tTopSpace = tNameHeight;
			end
		end
		sTopHeightCache[aPanelNum] = tTopSpace;
	end

	return sTopHeightCache[aPanelNum];
end



--
function VUHDO_getAdditionalBottomHeight(aPanelNum)
	if (sBottomHeightCache[aPanelNum] == nil) then
		-- HoT icons
		local tHotCfg = VUHDO_PANEL_SETUP["HOTS"];
		local tBottomSpace;

		if  (tHotCfg["radioValue"] == 7 or tHotCfg["radioValue"] == 8) then
			tBottomSpace = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"]["barHeight"] * VUHDO_PANEL_SETUP[aPanelNum]["HOTS"]["size"] * 0.01;
		else
			tBottomSpace = 0;
		end

		local tNamePos = VUHDO_splitString(VUHDO_PANEL_SETUP[aPanelNum]["ID_TEXT"]["position"], "+");
		if (strfind(tNamePos[1], "TOP", 1, true) and strfind(tNamePos[2], "BOTTOM", 1, true)) then
			local tNameHeight = VUHDO_PANEL_SETUP[aPanelNum]["ID_TEXT"]["_spacing"];
			if (tNameHeight ~= nil and tNameHeight > tBottomSpace) then
				tBottomSpace = tNameHeight;
			end
		end

		sBottomHeightCache[aPanelNum] = tBottomSpace;
	end

	return sBottomHeightCache[aPanelNum];
end



--
local tBarScaling;
local tTargetWidth;
local function VUHDO_getTargetBarWidth(aPanelNum)
	tBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];

	tTargetWidth = 0;
	if (tBarScaling["showTarget"]) then
		tTargetWidth = tTargetWidth + tBarScaling["targetSpacing"] + tBarScaling["targetWidth"];
	end

	if (tBarScaling["showTot"]) then
		tTargetWidth = tTargetWidth + tBarScaling["totSpacing"] + tBarScaling["totWidth"];
	end

	return tTargetWidth;
end



--
function VUHDO_getNumHotSlots(aPanelNum)
	if (VUHDO_PANEL_SETUP["HOTS"]["SLOTS"][10] ~= nil) then
		return 7;
	elseif (VUHDO_PANEL_SETUP["HOTS"]["SLOTS"][9] ~= nil) then
		return 6;
	else
		for tCnt = 5, 1, -1 do
			if (VUHDO_PANEL_SETUP["HOTS"]["SLOTS"][tCnt] ~= nil) then
				return tCnt;
			end
		end
		return 0;
	end
end
local VUHDO_getNumHotSlots = VUHDO_getNumHotSlots;



--
local tHotCfg;
local tHotSlots;
local function VUHDO_getHotIconWidth(aPanelNum)
	tHotCfg = VUHDO_PANEL_SETUP["HOTS"];

	if (tHotCfg["radioValue"] == 1 or tHotCfg["radioValue"] == 4) then
		tHotSlots = VUHDO_getNumHotSlots(aPanelNum);
		return VUHDO_PANEL_SETUP[aPanelNum]["SCALING"]["barHeight"] * VUHDO_PANEL_SETUP[aPanelNum]["HOTS"]["size"] * tHotSlots * 0.01;
	else
		return 0;
	end
end



--
function VUHDO_getHealButtonWidth(aPanelNum)
	if (VUHDO_IS_PANEL_CONFIG and not VUHDO_CONFIG_SHOW_RAID) then
		return VUHDO_PANEL_SETUP[aPanelNum]["SCALING"]["barWidth"];
	elseif (sHealButtonWidthCache[aPanelNum] == nil) then
		sHealButtonWidthCache[aPanelNum] = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"]["barWidth"] + VUHDO_getTargetBarWidth(aPanelNum) + VUHDO_getHotIconWidth(aPanelNum);
	end
	return sHealButtonWidthCache[aPanelNum];
end



--
local function VUHDO_isPanelHorizontal(aPanelNum)
	return VUHDO_PANEL_SETUP[aPanelNum]["SCALING"]["arrangeHorizontal"] and (not VUHDO_IS_PANEL_CONFIG or VUHDO_CONFIG_SHOW_RAID);
end



-- Returns total header width
function VUHDO_getHeaderWidth(aPanelNum)
	return VUHDO_isPanelHorizontal(aPanelNum)
		and VUHDO_getHeaderWidthHor(aPanelNum) or VUHDO_getHeaderWidthVer(aPanelNum);
end



-- Returns total header height
function VUHDO_getHeaderHeight(aPanelNum)
	return VUHDO_isPanelHorizontal(aPanelNum)
		and VUHDO_getHeaderHeightHor(aPanelNum) or VUHDO_getHeaderHeightVer(aPanelNum);
end



--
function VUHDO_getHeaderPos(aHeaderPlace, aPanelNum)
	if (VUHDO_isPanelHorizontal(aPanelNum)) then
		return VUHDO_getHeaderPosHor(aHeaderPlace, aPanelNum);
	else
		return VUHDO_getHeaderPosVer(aHeaderPlace, aPanelNum);
	end
end



--
function VUHDO_getHealButtonPos(aPlaceNum, aRowNo, aPanelNum)
	-- Achtung: Positionen nicht cachen, da z.T. von dynamischen Models abh�ngig
	if (VUHDO_isPanelHorizontal(aPanelNum)) then
		return VUHDO_getHealButtonPosHor(aPlaceNum, aRowNo, aPanelNum);
	else
		return VUHDO_getHealButtonPosVer(aPlaceNum, aRowNo, aPanelNum);
	end
end



--
function VUHDO_getHealPanelWidth(aPanelNum)
	return VUHDO_isPanelHorizontal(aPanelNum)
		and VUHDO_getHealPanelWidthHor(aPanelNum) or VUHDO_getHealPanelWidthVer(aPanelNum);
end



--
function VUHDO_getHealPanelHeight(aPanelNum)
	return VUHDO_isPanelHorizontal(aPanelNum)
		and VUHDO_getHealPanelHeightHor(aPanelNum) or VUHDO_getHealPanelHeightVer(aPanelNum);
end

