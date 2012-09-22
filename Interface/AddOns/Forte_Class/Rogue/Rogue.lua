--ForteXorcist v1.980.6 by Xus 13-09-2012 for 5.0

if FW.CLASS == "ROGUE" then
	local FW = FW;
	local FWL = FW.L;
	local PR = FW:ClassModule("Rogue");
	
	local ST = FW:Module("Timer");
	local CA = FW:Module("Casting");
	local CD = FW:Module("Cooldown");
	
	FW:SetCustomName(89775,FWL.HEMORRHAGE_GLYPH);
	
	if ST then
		local F = ST.F;
		ST:SetDefaultHasted(0) -- set abilities to not use haste in their durations by default
		
		-- Abilities
		:AddSpell(  408, 000,"Crowd",	F.UNIQUE) -- Kidney Shot
		:AddSpell( 2094, 000,"Crowd",	F.UNIQUE) -- Blind
		:AddSpell( 6770, 000,"Crowd",	F.UNIQUE) -- Sap
		:AddSpell(18425, 000,"Crowd",	F.UNIQUE) -- Kick silence
		:AddSpell(32748, 000,"Crowd",	F.UNIQUE) -- Deadly Throw interrupt
		:AddSpell( 1330, 000,"Crowd",	F.UNIQUE) -- Garrote silence	
		:AddSpell( 1833, 000,"Crowd",	F.UNIQUE) -- Cheap Shot
		:AddSpell( 1776, 000,"Crowd",	F.UNIQUE) -- Gouge
		:AddSpell(51722, 000,"Crowd",	F.UNIQUE) -- Dismantle

		:AddSpell(84617, 000,"Crowd",	F.UNIQUE) -- Revealing Strike
		:AddSpell(31126, 000,"Crowd",	F.UNIQUE) -- Blade Twisting
		:AddSpell(  703, 000,"Default",	F.TICKS) -- Garrote
		:AddSpell( 1943, 000,"Default",	F.TICKS):SetTickSpeed(2) -- Rupture
		--:AddSpell(16511, 000,"Default",F.TICKS) -- Hemorrhage, target debuff in Forte_Timer
		:AddSpell(89775, 000,"Default",	F.TICKS) -- Hemorrhage (Glyph), dot
				
		-- Poisons
		:AddSpell(30981, 000,"Crowd",	F.UNIQUE) -- Crippling Poison
		:AddSpell( 5760, 000,"Crowd",	F.UNIQUE) -- Mind-numbing Poison
		:AddSpell(13218, 000,"Crowd",	F.UNIQUE) -- Wound Poison
		:AddSpell( 2818, 000,"Default",	F.TICKS) -- Deadly Poison
	
		-- Self buffs
		:AddBuff(13750) -- Adrenaline Rush
		:AddBuff(13877) -- Blade Flurry
		:AddBuff(14177) -- Cold Blood
		:AddBuff(5277) -- Evasion
		:AddBuff(2983) -- Sprint
		:AddBuff(31224) -- Cloak of Shadows
		:AddBuff(1856) -- Vanish
		:AddBuff(1966) -- Feint
		:AddBuff(60177) -- Hunger for Blood
		:AddBuff(57934) -- Tricks of the Trade
		:AddBuff(5171) -- Slice and Dice
		:AddBuff(32645) -- Envenom
		:AddBuff(73651) -- Recuperate
		
		:AddBuff(84745) -- Shallow Insight
		:AddBuff(84746) -- Moderate Insight
		:AddBuff(84747) -- Deep Insight
		
		:AddMeleeBuffs()

		local sap = FW:SpellName(6770);
		ST:RegisterOnTimerBreak(function(unit,mark,spell)
			if spell == sap then
				if mark~=0 then unit=FW.RaidIcons[mark]..unit;end
				CA:CastShow("SapBreak",unit);
			end
		end);
		ST:RegisterOnTimerFade(sap,"SapFade");		
	end
	if CD then
		CD:AddMeleePowerupCooldowns();
	end

	if ST then
	FW:SetMainCategory(FWL.RAID_MESSAGES):SetSubCategory(FWL.BREAK_FADE,FW.ICON.SPECIFIC,2)
		:AddOption("INF",FWL.BREAK_FADE_HINT1)
		:AddOption("MS2",FWL.SAP_BREAK,"","SapBreak")
		:AddOption("MS2",FWL.SAP_FADE,"","SapFade")
	end

	FW.Default.SapBreak = 	{[0]=0,">> Sap on %s Broke Early! <<"};
	FW.Default.SapFade = 	{[0]=0,">> Sap on %s Fading in 3 seconds! <<"};
	
end
