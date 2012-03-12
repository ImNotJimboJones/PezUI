-- GridStatusRole.lua
--
-- Created By : Greltok

local _, ns = ...
if not ns.L then ns.L = {} end
local L = setmetatable(ns.L, {
	__index = function(t, k)
		t[k] = k
		return k
	end
})

--{{{ Libraries
local talentLib = LibStub:GetLibrary("LibGroupTalents-1.0")
local GridRoster = Grid:GetModule("GridRoster")
local GridStatus = Grid:GetModule("GridStatus")
--}}}

local GridStatusRole = GridStatus:NewModule("GridStatusRole")
GridStatusRole.menuName = L["Role"]

local rolestatus = {
	healer = {
		text = L["Healer"],
		icon = "Interface\\Icons\\Spell_Holy_Renew",
	},
	melee = {
		text = L["Melee"],
		icon = "Interface\\Icons\\Ability_DualWield",
	},
	ranged = {
		text = L["Ranged"],
		icon = "Interface\\Icons\\Spell_Fire_BlueFlameBolt",
	},
	tank = {
		text = L["Tank"],
		icon = "Interface\\Icons\\Ability_Warrior_ShieldMastery",
	},
}

--{{{ AceDB defaults
GridStatusRole.defaultDB = {
	debug = false,
	role = {
		text = L["Role"],
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		priority = 10,
		range = false,
		hideInCombat = false,
		colors = {
			healer = { r = 0, g = 1, b = 0, a = 1 },
			melee = { r = 1, g = 1, b = 0, a = 1 },
			ranged = { r = 0, g = 0, b = 1, a = 1 },
			tank = { r = 1, g = 0, b = 0, a = 1 },
		},
		filter = {
			healer = true,
			melee = true,
			ranged = true,
			tank = true,
		},
	},
}
--}}}

GridStatusRole.options = false

local function getrolecolor(role)
	local color = GridStatusRole.db.profile.role.colors[role]
	return color.r, color.g, color.b, color.a
end

local function setrolecolor(role, r, g, b, a)
	local color = GridStatusRole.db.profile.role.colors[role]
	color.r = r
	color.g = g
	color.b = b
	color.a = a or 1
	GridStatus:SendMessage("Grid_ColorsChanged")
end

local function getrolefilter(role)
	return GridStatusRole.db.profile.role.filter[role] ~= false
end

local function setrolefilter(role, v)
	GridStatusRole.db.profile.role.filter[role] = v
	GridStatusRole:RoleCheckAll()
end

--{{{ additional options
local roleOptions = {
	["role_color"] = {
		type = "group",
		dialogInline = true,
		name = L["Role colors"],
		desc = L["Colors for the roles."],
		order = 80,
		args = {
			["healer"] = {
				type = "color",
				name = L["Healer color"],
				desc = L["Color for Healers."],
				order = 100,
				hasAlpha = true,
				get = function () return getrolecolor("healer") end,
				set = function (_, r, g, b, a) setrolecolor("healer", r, g, b, a) end,
			},
			["melee"] = {
				type = "color",
				name = L["Melee color"],
				desc = L["Color for Melee."],
				order = 101,
				hasAlpha = true,
				get = function () return getrolecolor("melee") end,
				set = function (_, r, g, b, a) setrolecolor("melee", r, g, b, a) end,
			},
			["ranged"] = {
				type = "color",
				name = L["Ranged color"],
				desc = L["Color for Ranged."],
				order = 102,
				hasAlpha = true,
				get = function () return getrolecolor("ranged") end,
				set = function (_, r, g, b, a) setrolecolor("ranged", r, g, b, a) end,
			},
			["tank"] = {
				type = "color",
				name = L["Tank color"],
				desc = L["Color for Tanks."],
				order = 103,
				hasAlpha = true,
				get = function () return getrolecolor("tank") end,
				set = function (_, r, g, b, a) setrolecolor("tank", r, g, b, a) end,
			},
		},
	},
	["role_filter"] = {
		type = "group",
		dialogInline = true,
		name = L["Role filter"],
		desc = L["Show status for the selected roles."],
		order = 85,
		args = {
			["healer"] = {
				type = "toggle",
				name = L["Healer"],
				desc = L["Show on Healers."],
				order = 100,
				get = function () return getrolefilter("healer") end,
				set = function (_, v) setrolefilter("healer", v) end,
			},
			["melee"] = {
				type = "toggle",
				name = L["Melee"],
				desc = L["Show on Melee."],
				order = 101,
				get = function () return getrolefilter("melee") end,
				set = function (_, v) setrolefilter("melee", v) end,
			},
			["ranged"] = {
				type = "toggle",
				name = L["Ranged"],
				desc = L["Show on Ranged."],
				order = 102,
				get = function () return getrolefilter("ranged") end,
				set = function (_, v) setrolefilter("ranged", v) end,
			},
			["tank"] = {
				type = "toggle",
				name = L["Tank"],
				desc = L["Show on Tanks."],
				order = 103,
				get = function () return getrolefilter("tank") end,
				set = function (_, v) setrolefilter("tank", v) end,
			},
		},
	},
	["hideInCombat"] = {
		type = "toggle",
		name = L["Hide in combat"],
		desc = L["Hide roles while in combat."],
		order = 90,
		get = function() return GridStatusRole.db.profile.role.hideInCombat end,
		set = function()
			local settings = GridStatusRole.db.profile.role
			settings.hideInCombat = not settings.hideInCombat
			if settings.enable then
				if settings.hideInCombat then
					GridStatusRole:RegisterMessage("Grid_EnteringCombat")
					GridStatusRole:RegisterMessage("Grid_LeavingCombat")
				else
					GridStatusRole:UnregisterMessage("Grid_EnteringCombat")
					GridStatusRole:UnregisterMessage("Grid_LeavingCombat")
				end
				GridStatusRole:RoleCheckAll()
			end
		end,
	},

	["color"] = false,
}
--}}}

function GridStatusRole:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("role", L["Role"], roleOptions, true)
end

function GridStatusRole:OnStatusEnable(status)
	if status == "role" then
		talentLib.RegisterCallback(self, "LibGroupTalents_RoleChange")
		talentLib.RegisterCallback(self, "LibGroupTalents_Add")
		if self.db.profile.role.hideInCombat then
			self:RegisterMessage("Grid_EnteringCombat")
			self:RegisterMessage("Grid_LeavingCombat")
		end
		self:RoleCheckAll()
	end
end

function GridStatusRole:OnStatusDisable(status)
	if status == "role" then
		talentLib.UnregisterCallback(self, "LibGroupTalents_RoleChange")
		talentLib.UnregisterCallback(self, "LibGroupTalents_Add")
		if self.db.profile.role.hideInCombat then
			self:UnregisterMessage("Grid_EnteringCombat")
			self:UnregisterMessage("Grid_LeavingCombat")
		end
		self.core:SendStatusLostAllUnits("role")
	end
end

function GridStatusRole:Reset()
	self.super.Reset(self)
	self:RoleCheckAll()
	if self.db.profile.role.hideInCombat then
		GridStatusRole:RegisterMessage("Grid_EnteringCombat")
		GridStatusRole:RegisterMessage("Grid_LeavingCombat")
	else
		GridStatusRole:UnregisterMessage("Grid_EnteringCombat")
		GridStatusRole:UnregisterMessage("Grid_LeavingCombat")
	end
end

function GridStatusRole:Grid_EnteringCombat()
	local settings = self.db.profile.role
	if settings.enable and settings.hideInCombat then
		self.core:SendStatusLostAllUnits("role")
	end
end

function GridStatusRole:Grid_LeavingCombat()
	local settings = self.db.profile.role
	if settings.enable and settings.hideInCombat then
		self:RoleCheckAll()
	end
end

function GridStatusRole:RoleCheckAll()
	local settings = self.db.profile.role
	if settings.enable and (not settings.hideInCombat or not Grid.inCombat) then
		for guid, unit in GridRoster:IterateRoster() do
			self:RoleCheck(guid, unit)
		end
	else
		self.core:SendStatusLostAllUnits("role")
	end
end

function GridStatusRole:LibGroupTalents_RoleChange(event, guid, unit)
	self:RoleCheck(guid, unit)
end

function GridStatusRole:LibGroupTalents_Add(event, guid, unit)
	self:RoleCheck(guid, unit)
end

function GridStatusRole:RoleCheck(guid, unit)
	local gained
	local settings = self.db.profile.role
	if settings.enable and (not settings.hideInCombat or not Grid.inCombat) then
		local _, class = UnitClass(unit)
		local role = (class == "HUNTER" and "ranged") or talentLib:GetGUIDRole(guid)
		if role == "caster" then
			role = "ranged"
		end
		if role and settings.filter[role] then
			local status = rolestatus[role]
			self.core:SendStatusGained(guid,
										"role",
										settings.priority,
										(settings.range and 40),
										settings.colors[role],
										status.text,
										nil,
										nil,
										status.icon)
			gained = true
		end
	end
	if not gained then
		self.core:SendStatusLost(guid, "role")
	end
end
