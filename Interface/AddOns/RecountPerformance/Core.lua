--[[
  Name: Recount Performance Module
  Author: Epy
]]

if not Recount then return end --  Forget about this if no Recount is present

local Recount = Recount

local Rhga = LibStub("AceAddon-3.0"):NewAddon("RecountPerformance", "AceEvent-3.0", "AceTimer-3.0","AceConsole-3.0")
Rhga.Version = tonumber(string.sub("$Revision: 17 $", 12, -3))

local RL = LibStub("AceLocale-3.0"):GetLocale("Recount")
local L = LibStub("AceLocale-3.0"):GetLocale("RecountPerformance")
local DetailTitles={}
DetailTitles.GuessedAbsorbed={
	TopNames = RL["Ability Name"],
	TopCount = RL["Count"],
	TopAmount = RL["Absorbed"],
	BotNames = "",
	BotMin = RL["Min"],
	BotAvg = RL["Avg"],
	BotMax = RL["Max"],
	BotAmount = RL["Count"]
}

DetailTitles.ShieldedWho={
	TopNames = RL["Player/Mob Name"],
	TopCount = "",
	TopAmount = RL["Count"],
	BotNames = RL["Ability Name"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = RL["Count"]
}

function Rhga:OnEnable()

	if not Recount then return end -- No recount found

end

function Rhga:OnDisable()
	Recount:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

-- The data on the panel
function Rhga:DataModesPerformance(data, num)
	if not data then return 0, 0 end
	if num==1 then
	
		 -- DPS : (((data.Fights[Recount.db.profile.CurDataSet].Damage or 0)+(data.Fights[Recount.db.profile.CurDataSet].Healing or 0)+(data.Fights[Recount.db.profile.CurDataSet].Absorbs or 0))/(data.Fights[Recount.db.profile.CurDataSet].ActiveTime or 1))
		   -- Somme décurse et contresorts : (data.Fights[Recount.db.profile.CurDataSet].Interrupts or 0)+(data.Fights[Recount.db.profile.CurDataSet].Dispels or 0)
		   
      if (data.Fights[Recount.db.profile.CurDataSet].DamageTaken or 1)==0 then
        -- Cas où l'on n'a pas pris de Heal 
        return (((data.Fights[Recount.db.profile.CurDataSet].Interrupts or 0)+(data.Fights[Recount.db.profile.CurDataSet].Dispels or 0)*2*(((data.Fights[Recount.db.profile.CurDataSet].Damage or 0)+(data.Fights[Recount.db.profile.CurDataSet].Healing or 0)+(data.Fights[Recount.db.profile.CurDataSet].Absorbs or 0))/(data.Fights[Recount.db.profile.CurDataSet].ActiveTime or 1))+((data.Fights[Recount.db.profile.CurDataSet].Damage or 0)+(data.Fights[Recount.db.profile.CurDataSet].Healing or 0)+(data.Fights[Recount.db.profile.CurDataSet].Absorbs or 0)-0))),((((data.Fights[Recount.db.profile.CurDataSet].Damage or 0)+(data.Fights[Recount.db.profile.CurDataSet].Healing or 0)+(data.Fights[Recount.db.profile.CurDataSet].Absorbs or 0))/(data.Fights[Recount.db.profile.CurDataSet].ActiveTime or 1)))
        else
        -- Pondération si l'on a pris du heal
        return (((data.Fights[Recount.db.profile.CurDataSet].Interrupts or 0)+(data.Fights[Recount.db.profile.CurDataSet].Dispels or 0)*2*(((data.Fights[Recount.db.profile.CurDataSet].Damage or 0)+(data.Fights[Recount.db.profile.CurDataSet].Healing or 0)+(data.Fights[Recount.db.profile.CurDataSet].Absorbs or 0))/(data.Fights[Recount.db.profile.CurDataSet].ActiveTime or 1))+((data.Fights[Recount.db.profile.CurDataSet].Damage or 0)+(data.Fights[Recount.db.profile.CurDataSet].Healing or 0)+(data.Fights[Recount.db.profile.CurDataSet].Absorbs or 0)-2*(data.Fights[Recount.db.profile.CurDataSet].DamageTaken or 0)))),((((data.Fights[Recount.db.profile.CurDataSet].Damage or 0)+(data.Fights[Recount.db.profile.CurDataSet].Healing or 0)+(data.Fights[Recount.db.profile.CurDataSet].Absorbs or 0))/(data.Fights[Recount.db.profile.CurDataSet].ActiveTime or 1)))
      end
		  
     -- data.Fights[Recount.db.profile.CurDataSet].X or Z / commande de librairie pour aller chercher l'info X dans la Bdd de combat et retourne Z si vide
     -- .Damage / total des dégâts
     -- .Healing / total soins produits
     -- .Absorbs / Total boucliers posés
     -- .DamageTaken / Dégâts reçus
     -- .Interrupts / Interruptions faites à l'ennemi
     -- .Dispels / Guerrison de maladies, malédictions etc...
     -- .ActiveTime / Temps total (heal et dps confondu) 
	else
		return (nil)
	end
end

-- On over function
function Rhga:TooltipFuncsPerformance(name,data)
	-- local SortedData,total
    -- local test;
	
  GameTooltip:ClearLines()
  GameTooltip:AddLine(L["Damage"].."+"..L["Healing"].."+"..L["Guessed Absorbs"].."-2*"..L["DamageTaken"].."+Dps*2s*("..L["Dispels"].."+"..L["Interrupts"]..")")

end

-- Add the panel to recount
Recount:AddModeTooltip(L["Performance"],Rhga.DataModesPerformance,Rhga.TooltipFuncsPerformance,nil,nil,nil,nil)
