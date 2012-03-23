-- May your brain not spontaneously explode from the reading of this disorganized mod.
local L = AceLibrary("AceLocale-2.2"):new("XLoot")

XLoot = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceHook-2.1", "AceModuleCore-2.0")-- Shhhhh

XLoot.revision  = tonumber((string.gsub("$Revision: 375 $", "^%$Revision: (%d+) %$$", "%1")))

XLoot:SetModuleMixins("AceEvent-2.0", "AceConsole-2.0", "AceHook-2.1")
XLoot.dewdrop = AceLibrary("Dewdrop-2.0")

local _G = _G

function XLoot:OnInitialize()
	self:RegisterDB("XLootDB")
	self.dbDefaults = {
		scale = 1.0,
		alpha = 1.0,
		cursor = true,
		debug = false,
		smartsnap = true,
		snapoffset = 0,
		altoptions = true,
		collapse = true,
		linkallvis = "always",
		linkallthreshold = 2,
		linkallchannels = { },
		dragborder = true,
		lootexpand = true,
		swiftloot = false,
		qualityborder = false,
		qualityframe = false,
		texcolor = true,
		lootqualityborder = true,
		loothighlightframe = true,
		loothighlightthreshold = 1,
		qualitytext = false,
		infotext = true,
		bindtext = true,
		lock = false,
		skipsolobop = true,
		pos = { x = (UIParent:GetWidth()/2), y = (UIParent:GetHeight()/2) },
		bgcolor = { 0, 0, 0, .7 },
		bordercolor = { .7, .7, .7, 1 },
		lootbgcolor = { 0, 0, 0, .9 },
		lootbordercolor = { .5, .5, .5, 1 },
		infocolor = { 1, .8, 0 },
		noscan = false
	}
	self:RegisterDefaults("profile", self.dbDefaults)
	self:DoOptions()
	
	--Initial session variables
	self.numButtons = 0 -- Buttons currently created
	self.buttons = {} -- Easy reference array by ID
	self.frames = {}
	self.currentloot = {}
	self.visible = false
	self.open = false
	self.loothasbeenexpanded = false
	self.containershift = false
	self.swiftlooting = false
	self.swifthooked = false
	self.classhexes = { }
	self.coinage = { { GOLD, 10000 }, { SILVER, 100 }, { COPPER, 1 } }
end

function XLoot:OpenMenu(frame)
	self.dewdrop:Open(frame,
		'children', function(level, value)
				self.dewdrop:FeedAceOptionsTable(self.opts)
			end,
		'cursorX', true,
		'cursorY', true
	)
end

function XLoot:OnEnable()
end

function XLoot:OnDisable()
end

function XLoot:Defaults()
	self:Print("Default values restored.")
	for k, v in pairs(self.dbDefaults) do
		self.db.profile[k] = v
	end
end

function XLoot:msg( text )
	if self.db.profile.debug then
		self:Print(text)
		--DEFAULT_CHAT_FRAME:AddMessage("|cff7fff7fXLoot|r: "..text);
	end
end

function XLoot:Clear()
	for slot, button in pairs(self.buttons) do
		SetItemButtonCount(button, 0)
		button:Hide()
		self.frames[slot]:Hide()
	end
	if GetNumLootItems() < 1 then
		self.visible = false
	end
	XLootFrame:Hide()
end

function XLoot:LinkToName(link)
	if not link then return nil end
	return string.gsub(link,"^.-%[(.*)%].*", "%1")
end

function XLoot:ClassHex(class, enclass)
	class = enclass or class
	if not self.classhexes[class] then
		local c = RAID_CLASS_COLORS[class]
		self.classhexes[class] = string.format("%2x%2x%2x", c.r*255, c.g*255, c.b*255)
	end
	return self.classhexes[class]
end

function XLoot:ParseCoinString(tstr)
	local tc
	local total = 0
	for k, v in pairs(self.coinage) do
		_, _, tc = string.find(tstr, "(%d+) "..v[1])
		if tc then
			total = total + (tc * v[2])
		end
	end
	return total
end


local coinage = { { GOLD_AMOUNT, 0, "ffd700" }, { SILVER_AMOUNT, 0, "c7c7cf" }, { COPPER_AMOUNT, 0, "eda55f" } }
local moneystr_tmp = {}
function XLoot:ParseMoney(total, short, nocolor)
	local coinage = coinage
	-- gold
	coinage[1][2] = floor(total / 10000)
	-- silver
	coinage[2][2] = mod(floor(total / 100), 100)
	-- copper
	coinage[3][2] = mod(total, 100)

	for i, v in ipairs(coinage) do
		-- do we have a usable value in this denomination?
		if v[2] and v[2] > 0 then
			if short then
				table.insert(moneystr_tmp,
					     ("|cFF%s%d"):format(v[3], v[2]))
			else
				if nocolor then
					table.insert(moneystr_tmp,
							v[1]:format(v[2]))
				else
					table.insert(moneystr_tmp,
							(("|cFF%s%s"):format(v[3], v[1])):format(v[2]))
				end
			end
		end
	end

	-- join the usable values with ", "
	local str = table.concat(moneystr_tmp, ", ")

	-- cleanup
	for i, v in ipairs(moneystr_tmp) do
		moneystr_tmp[i] = nil
	end

	return str, gold, silver, copper
end

local bop, boe, bou
function XLoot:SetBindText(bind, text)
	if not bop then
		bop, boe, bou = L["BoP"].." ", L["BoE"].." ", L["BoU"].." "
	end
	if bind == "pickup" then
		text:SetText(bop)
		text:SetVertexColor(1, .3, .1)
	elseif bind == "equip" then
		text:SetText(boe)
		text:SetVertexColor(.3, 1, .3)
	elseif bind == "BOU" then
		text:SetText(bou)
		text:SetVertexColor(.3, .5, 1)
	else text:SetText("")	end
end
