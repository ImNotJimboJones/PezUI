local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LDB = LibStub("LibDataBroker-1.1")

local feeds = {}

local msgFormat = format("%s: %%s - %s: %%s", L["Normal"], L["Crit"])

for k, v in pairs(addon.trees) do
	feeds[k] = LDB:NewDataObject("Critline "..v.label, {
		type = "data source",
		label = v.title,
		icon = addon.trees[k].icon,
		OnClick = function()
			if IsShiftKeyDown() then
				local normalRecord, critRecord = addon:GetHighest(k)
				local normalSpell, critSpell
				local spells = addon:GetSpellArray(k)
				for i = 1, #spells do
					local v = spells[i]
					local normal = v.normal
					if normal and normal.amount == normalRecord then
						normalSpell = v.name
					end
					local crit = v.crit
					if crit and crit.amount == critRecord then
						critSpell = v.name
					end
					if (normalSpell or not normalRecord) and (critSpell or not normalRecord) then
						break
					end
				end
				local normal = normalSpell and format("%s (%s)", addon:ShortenNumber(normalRecord), normalSpell) or "-"
				local crit   = critSpell   and format("%s (%s)", addon:ShortenNumber(critRecord),   critSpell)   or "-"
				ChatFrame_OpenChat(format(msgFormat, normal, crit))
			else
				addon:OpenConfig()
			end
		end,
		OnTooltipShow = function()
			addon:ShowTooltip(k)
		end
	})
end

local function updateRecords(event, tree)
	if not tree then
		for k in pairs(feeds) do
			updateRecords(event, k)
		end
		return
	end
	
	if addon.percharDB.profile[tree] then
		local normal, crit = addon:GetHighest(tree)
		feeds[tree].text = format("%s/%s", addon:ShortenNumber(normal), addon:ShortenNumber(crit))
	end
end

local function onTreeStateChanged(event, tree, enabled)
	if enabled then
		updateRecords(event, tree)
	else
		feeds[tree].text = L["n/a"]
	end
end

local function addonLoaded()
	addon.RegisterCallback(feeds, "OnNewTopRecord", updateRecords)
	addon.RegisterCallback(feeds, "FormatChanged", updateRecords)
	addon.RegisterCallback(feeds, "OnTreeStateChanged", onTreeStateChanged)
end

addon.RegisterCallback(feeds, "AddonLoaded", addonLoaded)