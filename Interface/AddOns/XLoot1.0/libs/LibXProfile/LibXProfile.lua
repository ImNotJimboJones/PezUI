local lib = LibStub:NewLibrary("X-Profile", "1.4")
if not lib then return nil end
local wprint, print = print, print

local function trigger(addon, callback, ...)
	local f = addon[callback]
	if type(f) == 'function' then
		f(addon, ...)
	end
end

-- Localization
local locales = {
	enUS = {
		default_profile = "Default",
		profile_copy = "Copy to new profile",
		profile_copy_name = "Enter name for new profile",
		profile_current = "Current Profile:",
		profile_header = "Manage profiles",
		profile_panel = "Profile",
		profile_remove = "Remove profile",
		profile_reset = "Reset profile",
	},
	zhTW = {
		default_profile = "預設",
		profile_copy = "複製到新設定檔",
		profile_copy_name = "為新設定檔輸入名稱",
		profile_current = "目前的設定檔",
		profile_header = "管理設定檔",
		profile_panel = "設定檔",
		profile_remove = "移除設定檔",
		profile_reset = "重置設定檔",
	}
}

local L = locales[GetLocale()] and locales[GetLocale()] or locales.enUS
if L ~= locales.enUS then
	setmetatable(L, { __index = locales.enUS })
end
lib.L = L

local function rcopy(from, to, soft)
	for k, v in pairs(from) do
		if type(v) == 'table' then
			to[k] = rcopy(v, to[k] or {}, soft)
		elseif not soft or to[k] == nil then
			to[k] = v
		end
	end
	return to
end

------------------------
--  Provided methods  --
------------------------
local embed = {}
function embed:SetProfile(which)
	self.active_profile = which
	local sv, defaults = self.sv, self.defaults
	sv.characters[self:ProfileKey()] = which
	
	-- Init profile
	if not sv.profiles[which] then
		sv.profiles[which] = {}
	end
	local profile = sv.profiles[which]
	
	-- Soft copy defaults
	self.opt = rcopy(defaults, profile, true)

	-- Link defaults
	-- opt = setmetatable(profile, { __index = function(t, k) 

	-- end})
	setmetatable(self.opt, { __index = defaults })
	-- for k, v in pairs(defaults) do
		-- if type(v) == 'table'  and type(defaults[k]) == 'table' then
			-- opt[k] = setmetatable(profile[k], { __index = defaults[k] })
		-- end
	-- end
	

	-- Callback
	trigger(self, 'OnProfileChanged', self.opt)
end

function embed:ResetProfile(which)
	which = which or self:GetActiveProfile()
	rcopy(self.defaults, self.sv.profiles[which])
end

function embed:RemoveProfile(which)
	which = which or self:GetActiveProfile()
	self.sv.profiles[which] = nil
end

function embed:CopyProfile(from, to)
	to = to or self:GetActiveProfile()
	rcopy(self.sv.profiles[from], wipe(self.sv.profiles[to]))
end

function embed:GetActiveProfile()
	return self.active_profile
end

function embed:GetProfiles()
	return self.sv.profiles
end

function embed:ProfileKey()
	return ('%s - %s'):format(UnitName('player'), GetRealmName())
end

-------------------
--  Event frame  --
-------------------

if not lib.addons then
	lib.addons = { }
end
if not lib.frame then
	lib.frame = CreateFrame('Frame')
end
lib.frame:SetScript("OnEvent", function(self, event, name)
	local addon = lib.addons[name]
	if addon then
		local savedvar = addon.__xp_sv
		-- Embed methods
		for k, v in pairs(embed) do
			addon[k] = v
		end	
		
		-- SV Init
		if not _G[savedvar] then
			_G[savedvar] = { }
		end
		local sv = _G[savedvar]
		if not sv.characters then
			sv.characters = { }
		end
		if not sv.profiles then
			sv.profiles = { }
		end
		addon.sv = sv
		
		-- Profiles init
		local profile_key, which_profile = addon:ProfileKey()
		if sv.characters[profile_key] then
			which_profile = sv.characters[profile_key]
			
			-- Invalid/removed profiles
			if type(sv.profiles[which_profile]) == nil then
				sv.characters[profile_key] = nil
				which_profile = nil
			end
		end
		which_profile = which_profile or lib.L.default_profile
		addon:SetProfile(which_profile)
		addon.xprofile = true
		trigger(addon, 'OnLoad')
		lib.addons[name] = nil
	end
end)
lib.frame:RegisterEvent('ADDON_LOADED')

-- Lib
function lib:Setup(addon, savedvar)
	assert(addon.defaults, "X-Profile requires a addon.defaults table")
	assert(addon.NAME, "X-Profile requires that addon.NAME contains requesting addon name")
	self.addons[addon.NAME] = addon
	addon.__xp_sv = savedvar
end


