--ForteXorcist v1.980.6 by Xus 13-09-2012 for 5.0

if FW.CLASS == "WARRIOR" then
	local FW = FW;
	local FWL = FW.L;
	local WR = FW:ClassModule("Warrior");
	
	local ST = FW:Module("Timer");
	local CA = FW:Module("Casting");
	local CD = FW:Module("Cooldown");
	
	if ST then
		local F = ST.F;
		ST:SetDefaultHasted(0) -- set abilities to not use haste in their durations by default
		
		:AddSpell( 7386,  30,"Default"):SetStacks(3)-- Sunder Armor
		:AddSpell(  355,   3,"Crowd") -- Taunt
		:AddSpell(21008,   6,"Crowd") -- Mocking Blow
		:AddSpell(  676,  10,"Crowd") -- Disarm
		:AddSpell(12294,  10,"Default") -- Mortal Strike
		:AddSpell(12834,   6,"Default",	F.TICKS):SetTickSpeed(1) -- Deep Wounds
		:AddSpell(  772,  15,"Default",	F.TICKS):SetSpellModGlph(58399,6) -- Rend
		:AddSpell( 1715,  15,"Default") -- Hamstring
		:AddSpell( 1160,  30,"Crowd",	F.AOE):SetSpellModGlph(58345,15) -- Demoralizing Shout 
		:AddSpell( 5246,   8,"Crowd",	F.AOE) -- Intimidating Shout
		:AddSpell( 6343,  30,"Crowd",	F.AOE) -- Thunder Clap
		:AddSpell(12323,   6,"Crowd",	F.AOE) -- Piercing Howl	 
		:AddSpell(50720,1800,"Buff",	F.BUFF) -- Vigilance
		:AddSpell(86346,   6,"Default") -- Colossus Smash
		:AddSpell(85388,   5,"Default") -- Throwdown
		
		--buffname,duration
		:AddBuff(29131) -- Bloodrage
		:AddBuff(469) -- Commanding Shout
		:AddBuff(12880) -- Enrage
		:AddBuff(29801) -- Rampage
		:AddBuff(12328) -- Sweeping Strikes
		:AddBuff(12292)	-- Death Wish
		
		:AddBuff(6673) -- Battle Shout
		:AddBuff(18499) -- Berserker Rage
		:AddBuff(1719) -- Recklessness
		
		:AddBuff(56636) -- Taste for Blood
	
		-- Slam!
		:AddBuff(46916)	
		
		:AddBuff(85730) -- Deadly Calm
		:AddBuff(1134) -- Inner Rage
		:AddBuff(50685) -- Incite
		:AddBuff(84584) -- Slaughter
		
		--debuffs
		:AddDebuff(12294) -- Mortal Strike
		:AddDebuff(1715) -- Hamstring
		:AddDebuff(6343) -- Thunder Clap
		:AddDebuff(1160) -- Demoralizing Shout    
		:AddDebuff(20511) -- Intimidating Shout
		:AddDebuff(12323) -- Piercing Howl
		
		:AddDebuff(86346) -- Colossus Smash
		:AddDebuff(85388) -- Throwdown
		
		:AddMeleeBuffs()
	end
	if CD then
		CD:AddCooldownBuff(6673); -- Battle Shout
		CD:AddHiddenCooldown(nil,60503,6); -- Taste for Blood
		CD:AddMeleePowerupCooldowns();
	end
	if CA then
	
		local sw = FW:SpellName(871);
		local ls = FW:SpellName(12975);
		local rc = FW:SpellName(97462);
		local er = FW:SpellName(55694);
		
		local intervene = FW:SpellName(3411);
		local vigilance = FW:SpellName(50720);
		local recklessness = FW:SpellName(1719);
		local retaliation = FW:SpellName(20230);
		local challengingshout = FW:SpellName(1161);
		
		CA:RegisterOnSelfCastSuccess(
			function(s, t)
				if s == sw then
					CA:CastShow("SWStart");
				elseif s == ls then
					CA:CastShow("LSStart");
				elseif s == rc then
					CA:CastShow("RCStart");
				elseif s == er then
					CA:CastShow("ERStart");
				elseif s == intervene then
					CA:CastShow("InterveneStart" , t);
				elseif s == vigilance then
					CA:CastShow("VigilanceStart" , t);
				elseif s == recklessness then
					CA:CastShow("RecklessnessStart");
				elseif s == retaliation then
					CA:CastShow("RetaliationStart");
				elseif s == challengingshout then
					CA:CastShow("ChallengingShoutStart");
				end
			end
		);

		FW:SetMainCategory(FWL.RAID_MESSAGES);
			FW:SetSubCategory("Raid Damage Reduction",FW.ICON.SPECIFIC,2);
				FW:AddOption("MS2",rc,	 		"","RCStart"); 
				FW:AddOption("MS2",intervene,	"","InterveneStart"); 
				
			FW:SetSubCategory("Self Damage Reduction",FW.ICON.SPECIFIC,2);
				FW:AddOption("MS2",sw,"","SWStart"); 
				FW:AddOption("MS2",ls,"","LSStart"); 
				FW:AddOption("MS2",er,"","ERStart"); 
				
			FW:SetSubCategory("Other",FW.ICON.SPECIFIC,2);
				FW:AddOption("MS2",vigilance,		"","VigilanceStart"); 
				FW:AddOption("MS2",recklessness,	"","RecklessnessStart"); 
				FW:AddOption("MS2",retaliation,		"","RetaliationStart"); 
				FW:AddOption("MS2",challengingshout,"","ChallengingShoutStart"); 
		
		FW.Default.RCStart = 				{[0]=1,"+++ Rallying Cry (10 sec) +++"};		
		FW.Default.InterveneStart = 		{[0]=1,"+++ Intervene on %s (10 sec) +++"};				
		FW.Default.SWStart = 				{[0]=1,"+++ Shield Wall (12 sec) +++"};				
		FW.Default.LSStart = 				{[0]=1,"+++ Last Stand (20 sec) +++"};		
		FW.Default.ERStart = 				{[0]=1,"+++ Enraged Regeneration (10 sec) +++"};
		FW.Default.VigilanceStart = 		{[0]=0,">>> Vigilance on %s (30 Minutes) <<<"};
		FW.Default.RecklessnessStart = 		{[0]=1,">>> Taking 20% more damage with Recklessness (12 sec) <<<"};	
		FW.Default.ChallengingShoutStart = 	{[0]=1,">>> Challenging Shout (6 sec) <<<"};
		FW.Default.RetaliationStart = 		{[0]=1,">>> Retaliation (12 sec) <<<"};
	end
	
end
