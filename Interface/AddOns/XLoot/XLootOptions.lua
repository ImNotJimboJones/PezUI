local L = AceLibrary("AceLocale-2.2"):new("XLoot")

local _G = _G

function XLoot:optGetKey(table, value)
	for k, v in pairs(table) do
		if value == v then 
			return k
		end
	end
end

function XLoot:DoOptions()
	self.opts_qualitykeys = {}
	self.opts_partyconditions = { always = ALWAYS, party = PARTY, raid = RAID, never = CAMERA_NEVER }
	for i = 0, 6 do
		self.opts_qualitykeys[i+1] = ITEM_QUALITY_COLORS[i].hex.._G["ITEM_QUALITY"..tostring(i).."_DESC"].."|r"
	end
		
	local db = self.db.profile
	local hcolor = "|cFF77BBFF"
	XLoot.opts = {
		type = "group",
		args = {
			header = {
				type = "header",
				name = hcolor.."Plugin support (No options)",
				icon = "Interface\\Buttons\\UI-GroupLoot-Dice-Up",
				iconHeight = 32,
				iconWidth = 32,
				order = 1
			}, 
			options = {
				type = "execute",
				name = L["optOptions"],
				desc = L["descOptions"],
				func = function() self:OpenMenu(UIParent) end,
				order = 100,
				guiHidden = true
			}
		}
	}

	self:RegisterChatCommand({ "/oldxloot" }, self.opts)
end