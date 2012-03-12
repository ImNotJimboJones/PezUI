-- GlobalOptions.lua : Options config
if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local _G = getfenv(0)
local PitBull4 = _G.PitBull4
local PitBull4_VisualHelpers= PitBull4:GetModule("VisualHelpers")
local L = PitBull4.L
local UpdateFrames = PitBull4.Options.UpdateFrames

local MULTISELECT_CONTROL = "Dropdown"

local CURRENT_HELPER
local AURAS_GROUP = {}


-- :::::::::::: LOCALS ::::::::::::: -------------------------------------------------------------------------
local function add_helper(new_helper_name) 
	local helpers = PitBull4_VisualHelpers.db.profile.global.helpers
	helpers[new_helper_name] = {
	   name = new_helper_name,
	   auras = {},
	}
end

local function helpers_count()
	local helpers = PitBull4_VisualHelpers.db.profile.global.helpers
	if not helpers then return 0 end
	local num = 0
	for name in pairs(helpers) do
		num = num + 1
	end
	return num
end

local function get_aura_index(aura_name)
   local auras = PitBull4_VisualHelpers.db.profile.global.helpers[CURRENT_HELPER].auras
   for i, v in ipairs(auras) do
      if v == aura_name then
         return i
      end
   end
   return nil
end

local function build_aura_list()
   local auras = PitBull4_VisualHelpers.db.profile.global.helpers[CURRENT_HELPER].auras
   
   for k in pairs(AURAS_GROUP) do
      AURAS_GROUP[k] = nil
   end
   
	if #auras < 1 then
		AURAS_GROUP['__DUMMY__'] = PitBull4_VisualHelpers:CreateNewAuraGlobalOptions(' ')
	else
   	for i, v in ipairs(auras) do
   		AURAS_GROUP[v] = PitBull4_VisualHelpers:CreateNewAuraGlobalOptions(v)
   	end
	end 
	LibStub("AceConfigRegistry-3.0"):NotifyChange("PitBull4")
end

-- :::::::::::: PitBull4_VisualHelpers ::::::::::::: -------------------------------------------------------------------------
function PitBull4_VisualHelpers:CreateDefaultGlobalHelpers()
	if (PitBull4_VisualHelpers.db.profile.global.helpers) then
	   wipe(helpers)
	end
	PitBull4_VisualHelpers.db.profile.global.helpers = {
	   ['Tank Cooldowns'] = {
	      name = 'Tank Cooldowns',
	      auras = {
	         'Last Stand',
	         'Shield Wall',
	         'Survival Instincts',
	         'Frenzied Regeneration',
	         'Divine Protection',
	      },
	   },
	   ['Beacon of Light'] = {
	      name = 'Beacon of Light',
	      auras = {
	         'Beacon of Light',
	      },
	   },
	}
	return PitBull4_VisualHelpers.db.profile.global.helpers
end

function PitBull4_VisualHelpers:GetHelpersNames() 
	local helpers = PitBull4_VisualHelpers.db.profile.global.helpers
	local t = {}
   for n in pairs(helpers) do
      t[n] = n
   end 
   return t
end

PitBull4_VisualHelpers:SetGlobalOptionsFunction(function(self)
	return 'helpers_editor', {
		type = 'group',
		childGroups = 'tab',
		name = L['Helpers editor'],
		desc = L['Configure the visual helpers you will want in your layout.'],
		args = PitBull4_VisualHelpers:GetHelpersEditor(),
	}
end)

function PitBull4_VisualHelpers:CreateNewAuraGlobalOptions(new_aura_name)
   return {
		type = 'group',
		name = new_aura_name,
		childGroups = 'tree',
		args = {
   		new_aura = {
   			type = 'input',
   			name = L['Add new aura'],
   			desc = L['Name of new new aura.'],
   			get = function(info,key)
   				return ''
   			end,
   			set = function(info,value)
               local auras = PitBull4_VisualHelpers.db.profile.global.helpers[CURRENT_HELPER].auras
               table.insert(auras, value)
               build_aura_list()
               PitBull4_VisualHelpers:UpdateIndicators()
               UpdateFrames()
   			end,
      		validate = function(info, value)
      			if GetSpellBookItemInfo(value) == nil then
      				return L["Not a valid spell name."]
      			end
      			return true
      		end,
   			order = 1,
   		},
			spacer = {
				type = 'description',
				name = '',
				desc = '',
				order = 2,
			},
			delete = {
				type = 'execute',
				name = L["Delete"],
				desc = L["Delete selected aura."],
				func = function(info)
				   local i = get_aura_index(new_aura_name)
				   if i then
                  local auras = PitBull4_VisualHelpers.db.profile.global.helpers[CURRENT_HELPER].auras
   				   table.remove(auras, i)
                  build_aura_list()
                  PitBull4_VisualHelpers:UpdateIndicators()
                  UpdateFrames()
   				end
				end,
				disabled = function(info)
					return (new_aura_name == ' ') or InCombatLockdown()
				end,
   			order = 3,
			},
		},
	}
end

--PitBull4_Aura.OnProfileChanged_funcs[#PitBull4_Aura.OnProfileChanged_funcs+1] = 
--function(self)
	-- Recalculate the filter options on a profile change
--	self.SetHighlightOptions(self, HIGHLIGHT_FILTER_OPTIONS)
--end
-- Generates the options for the helpers editor.
function PitBull4_VisualHelpers:GetHelpersEditor()
	local helpers = PitBull4_VisualHelpers.db.profile.global.helpers
	if not CURRENT_HELPER then
	   if not helpers then
	      helpers = PitBull4_VisualHelpers:CreateDefaultGlobalHelpers()
	   end
		CURRENT_HELPER = next(helpers)
	end
	
	build_aura_list()

	return {
		warning = {
			type = 'description',
			name = L['Need to restart interface so new helpers takes place.'],
			order = 1,
		},
		helper = {
			type = 'select',
			dialogControl = MULTISELECT_CONTROL, 
			name = L['Visual Helper'],
			desc = L['Select visual helper to configure.'],
			get = function(info,key)
				if not rawget(helpers, CURRENT_HELPER) then
					CURRENT_HELPER = next(helpers)
					build_aura_list()
				end
				return CURRENT_HELPER
			end,
			set = function(info,value)
				CURRENT_HELPER = value
				build_aura_list()
			end,
			values = function(info)
				return PitBull4_VisualHelpers:GetHelpersNames()
			end,
			order = 2,
		},
		new_helper = {
			type = 'input',
			name = L['Add new visual helper'],
			desc = L['Name of new visual helper.'],
			get = function(info,key)
				return ''
			end,
			set = function(info,key,value)
			   add_helper(key)
			   CURRENT_HELPER = key
				build_aura_list()
            PitBull4_VisualHelpers:UpdateIndicators()
            UpdateFrames()
			end,
   		validate = function(info, value)
   			if value:len() < 3 then
   				return L["Must be at least 3 characters long."]
   			end
   			if rawget(helpers, value) then
   				return L["Must be unique."]
   			end
   			return true
   		end,
			order = 3,
		},
		delete = {
			type = 'execute',
			name = L["Delete"],
			desc = L["Delete this visual helper."],
			confirm = function(info)
	         LibStub("AceConfigRegistry-3.0"):NotifyChange("PitBull4")
				return L["Are you sure you want to delete the '%s' visual helper? This is irreversible."]:format(CURRENT_HELPER)
			end,
			func = function(info)
				PitBull4_VisualHelpers.db.profile.global.helpers[CURRENT_HELPER] = nil
				local h = "VisualHelpers: ".. CURRENT_HELPER
				
				for id, module in PitBull4:IterateModules() do
					if module.db and module.db.profile.global.helpers then
						module.db.profile.global.helpers[CURRENT_HELPER] = nil
					end
					if module.full_name == h then
					   PitBull4:DisableModule(module)
					   module.db.profile.global = nil
				      PitBull4.db.sv.namespaces[h] = nil
					end
				end
				
				for name, layout in pairs(PitBull4.db.profile.layouts) do
					if layout.helpers then
					   layout.helpers[CURRENT_HELPER] = nil
					end
				end
				
				if PitBull4.modules[h] then
				   PitBull4.modules[h] = nil
				   PitBull4_VisualHelpers.VH_INDICATORS[CURRENT_HELPER] = nil
				end
            PitBull4_VisualHelpers:UpdateIndicators()
            UpdateFrames()
      		CURRENT_HELPER = next(helpers)
      		build_aura_list()

			end,
			disabled = function(info)
				return helpers_count() <= 1 or InCombatLockdown()
			end,
			order = 4,
		},
		auras = {
			type = 'group',
         name = L['Auras'],
			desc = L['Auras selected visual helper will show.'],
			args = AURAS_GROUP,
			order = 5,
		},
	}
end
