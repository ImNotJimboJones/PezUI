--
function VUHDO_activateLayout(aName)
	local tCnt;
	VUHDO_SPELL_ASSIGNMENTS = VUHDO_decompressOrCopy(VUHDO_SPELL_LAYOUTS[aName]["MOUSE"]);
	if (VUHDO_SPELL_LAYOUTS[aName]["HOSTILE_MOUSE"] ~= nil) then
		VUHDO_HOSTILE_SPELL_ASSIGNMENTS = VUHDO_decompressOrCopy(VUHDO_SPELL_LAYOUTS[aName]["HOSTILE_MOUSE"]);
	end
	if (VUHDO_SPELL_LAYOUTS[aName]["HOTS"] ~= nil
		and VUHDO_SPELL_CONFIG["IS_LOAD_HOTS"]
		and VUHDO_SPELL_LAYOUTS[aName]["HOTS"][1] == nil) then
		VUHDO_PANEL_SETUP["HOTS"] = VUHDO_decompressOrCopy(VUHDO_SPELL_LAYOUTS[aName]["HOTS"]);
	end
	VUHDO_SPELLS_KEYBOARD = VUHDO_decompressOrCopy(VUHDO_SPELL_LAYOUTS[aName]["KEYS"]);

	VUHDO_SPEC_LAYOUTS["selected"] = aName;
	VUHDO_Msg("Key layout \"" .. aName .. "\" loaded.");

	VUHDO_loadVariables();
	VUHDO_initAllBurstCaches();
	--VUHDO_keySetupInitBurst();
	--VUHDO_macroFactoryInitBurst();
	VUHDO_initFromSpellbook();
	VUHDO_registerAllBouquets(false);
	VUHDO_initBuffs();
	VUHDO_initDebuffs();
	VUHDO_initKeyboardMacros();
	VUHDO_timeReloadUI(1);
end

