-- LayoutOptions.lua : Options config
if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local _G = getfenv(0)
local PitBull4 = _G.PitBull4
local PitBull4_VisualHelpers= PitBull4:GetModule("VisualHelpers")
local L = PitBull4.L

local MULTISELECT_CONTROL = "Dropdown"

-- tables of options for the selection options

-- :::::::::::: LOCALS ::::::::::::: -------------------------------------------------------------------------

local CURRENT_HELPER
local HELPER_OPTIONS

local LibSharedMedia = LibStub("LibSharedMedia-3.0", true)
LoadAddOn("AceGUI-3.0-SharedMediaWidgets")
local AceGUI = LibStub("AceGUI-3.0")

TOTO = {}
-- :::::::::::: PitBull4_VisualHelpers ::::::::::::: -------------------------------------------------------------------------
PitBull4_VisualHelpers:SetLayoutOptionsFunction(function(self)

	local UpdateFrames = PitBull4.Options.UpdateFrames
	local GetLayoutDB = PitBull4.Options.GetLayoutDB
	local root_locations = PitBull4.Options.root_locations
	local horizontal_bar_locations = PitBull4.Options.horizontal_bar_locations
	local vertical_bar_locations = PitBull4.Options.vertical_bar_locations
	local indicator_locations = PitBull4.Options.indicator_locations
                                                                   
   if not PitBull4_VisualHelpers.db.profile.global.helpers then
      PitBull4_VisualHelpers:CreateDefaulGlobalHelpers()
   end
	local helpers = PitBull4_VisualHelpers.db.profile.global.helpers
                                  
	if not CURRENT_HELPER then
		CURRENT_HELPER = next(helpers)
	end
	
	local db = GetLayoutDB(self)

   local function get_new_visual_helper_options()
      return {
         enabled = true,
         color = {0, 1, 1, 1},
         texture = nil,
         solid = true,
         attach_to = 'root',
         location = 'edge_top_left',
         position = 1,
         size = 1,
      }
   end
	local function ensure_layout_db()
		if not db.elements then
		   db.elements = {}
		end
		for n in pairs(helpers) do
			if not rawget(db.elements, n) then
				db.elements[n] = get_new_visual_helper_options()
			end
		end
	end
	local function get_layout(info)
		local id = info[#info]
		return db.elements[CURRENT_HELPER][id]
	end
	local function set_layout(info, value)
		local id = info[#info]
		db.elements[CURRENT_HELPER][id] = value
		UpdateFrames()
	end                              
	local function get_location_list()
		local attach_to
		attach_to = db.elements[CURRENT_HELPER].attach_to
		if attach_to == "root" then
			return root_locations
		else
			local element_id
			attach_to, element_id = (";"):split(attach_to, 2)
			local module = PitBull4.modules[attach_to]
			if module then
				if module.module_type == "indicator" then
					return indicator_locations
				end

				local db1 = GetLayoutDB(module)
				if element_id then
					db1 = rawget(db.elements, element_id)
				end
				local side = db1 and db1.side
				if not side or side == "center" then
					return horizontal_bar_locations
				else
					return vertical_bar_locations
				end
			end
			return horizontal_bar_locations
		end
	end
	
	ensure_layout_db()
   
	HELPER_OPTIONS = {
		type = 'group',
      name = L['Visual helper options'],
      inline = true,
		args = {
   	   enabled = {
      		type = 'toggle',
      		name = L['Enabled'],
      		desc = L['Sets if selected visual helper will be enabled for this layout.'],
      		get = get_layout,
      		set = set_layout,
				disabled = function(info)
					return not db.enabled
				end,
      		order = 1,
   	   },
      	h1 = {
      		type = 'header',
      		name = '',
      		desc = '',
				order = 2,
      	},
			color = {
				type = 'color',
				name = L['Color'],
				desc = L["Color for selected visual helper."],
      		get = function(info)
      		   return unpack(get_layout(info))
   			end,
      		set = function(info, r, g, b, a)
      		   set_layout(info, {r, g, b, a})
   			end,
				disabled = function(info)
					return not(db.elements[CURRENT_HELPER].enabled and db.enabled)
				end,
				order = 3,
			},
         texture = {
      		type = 'select',
      		name = L["Texture"],
      		desc = L["What texture for selected visual helper."] .. "\n" .. L["If you want more textures, you should install the addon 'SharedMedia'."],
      		get = get_layout,
      		set = set_layout,
      		values = function(info)
      			return LibSharedMedia:HashTable("statusbar")
      		end,
      		hidden = function(info)
      			return not LibSharedMedia or db.elements[CURRENT_HELPER].solid
      		end,
      		dialogControl = AceGUI.WidgetRegistry["LSM30_Statusbar"] and "LSM30_Statusbar" or nil,
				disabled = function(info)
					return not(db.elements[CURRENT_HELPER].enabled and db.enabled)
				end,
				order = 4,
      	},   	
   	   solid = {
      		type = 'toggle',
      		name = L['Solid Color'],
      		desc = L['Visual helper will be rendered as solid color.'],
      		get = get_layout,
      		set = set_layout,
				disabled = function(info)
					return not(db.elements[CURRENT_HELPER].enabled and db.enabled)
				end,
      		order = 5,
   	   },
			h2 = {
				type = 'header',
				name = '',
				order = 6,
			},
      	attach_to = {
      		type = 'select',
      		name = L["Attach to"],
      		desc = L["Which control to attach to."],
      		get = get_layout,
      		set = function(info, value)
      			set_layout(info, value)
      			-- If the current location isn't valid with the new attach_to
      			-- update it to one that is.
      			local locations = get_location_list()
      			if not locations[db.elements[CURRENT_HELPER].location] then
      				db.elements[CURRENT_HELPER].location = next(locations)
      			end
      			UpdateFrames()
      		end,
      		values = function(info)
      			local t = {}
      			
      			t["root"] = L["Unit frame"]
      			
      			for id, module in PitBull4:IterateModulesOfType("bar", "indicator") do
      				local db1 = GetLayoutDB(module)
      				if db1.enabled and db1.side then
      					t[id] = module.name
      				end
      			end
      			
      			for id, module in PitBull4:IterateModulesOfType("bar_provider") do
      				local db1 = GetLayoutDB(module)
      				if db1.enabled then
      					for name in pairs(db1.elements) do
      						t[id .. ";" .. name] = ("%s: %s"):format(module.name, name)
      					end
      				end
      			end
      			
      			return t
      		end,
				disabled = function(info)
					return not(db.elements[CURRENT_HELPER].enabled and db.enabled)
				end,
				order = 7,
      	},
      	location = {
      		type = 'select',
      		name = L["Location"],
      		desc = L["Where on the control to place the visual helper."],
      		order = 5,
      		get = get_layout,
      		set = set_layout,
      		values = get_location_list,
				disabled = function(info)
					return not(db.elements[CURRENT_HELPER].enabled and db.enabled)
				end,
				order = 8,
      	},
      	position = {
      		type = 'select',
      		name = L["Position"],
      		desc = L["Where to place the visual helper compared to other elements in the same location."],
      		get = get_layout,
      		set = function(info, new_position)
      			local id_to_position = {}
      			local elements = {}
      			
      			local old_position = db.elements[CURRENT_HELPER].position
      			
      			for other_id, other_module in PitBull4:IterateModulesOfType("indicator", "custom_text", true) do
      				id_to_position[other_id] = GetLayoutDB(other_id).position
      				elements[#elements+1] = other_id
      			end
      			
      			for other_id, other_module in PitBull4:IterateModulesOfType("custom", true) do
      			   if other_id == 'VisualHelpers' then
      			      local db1 = GetLayoutDB(other_id)
      			      for n, v in pairs(db1.elements) do
   			            local id = other_id..';'..n
         				   id_to_position[id] = v.position
         				   elements[#elements+1] = id
         				end
         				break;
      				end
      			end
      			
      			for other_id, other_module in PitBull4:IterateModulesOfType("text_provider", true) do
      				for element_id, element_db in pairs(GetLayoutDB(other_id).elements) do
      					local joined_id = other_id .. ";" .. element_id
      					id_to_position[joined_id] = element_db.position
      					elements[#elements+1] = joined_id
      				end
      			end
      			
      			for element_id, other_position in pairs(id_to_position) do
      				if element_id == 'VisualHelpers;'..CURRENT_HELPER then
      					id_to_position[element_id] = new_position
      				elseif other_position >= old_position and other_position <= new_position then
      					id_to_position[element_id] = other_position - 1
      				elseif other_position <= old_position and other_position >= new_position then
      					id_to_position[element_id] = other_position + 1
      				end
      			end
      			
      			table.sort(elements, function(alpha, bravo)
      				return id_to_position[alpha] < id_to_position[bravo]
      			end)
      			
      			for position, element_id in ipairs(elements) do
      				if element_id:match(";") then
      					local module_id, name = (";"):split(element_id, 2)
      					local element_db = rawget(GetLayoutDB(module_id).elements, name)
      					if element_db then
      						element_db.position = position
      					end
      				else
      					GetLayoutDB(element_id).position = position
      				end
      			end
      			
      			UpdateFrames()
      		end,
      		values = function(info)
      			local attach_to = db.elements[CURRENT_HELPER].attach_to
      			local location = db.elements[CURRENT_HELPER].location
      			local t = {}
      			local sort = {}
      			for other_id, other_module in PitBull4:IterateModulesOfType("indicator", "custom_text") do
      				local other_db = GetLayoutDB(other_id)
      				if attach_to == other_db.attach_to and location == other_db.location then
      					local position = other_db.position
      					while t[position] do
      						position = position + 1e-5
      						other_db.position = position
      					end
      					t[position] = other_module.name
      					sort[#sort+1] = position
      				end
      			end
      			for other_id, other_module in PitBull4:IterateModulesOfType("text_provider") do
      				for element_id, element_db in pairs(GetLayoutDB(other_id).elements) do
      					if attach_to == element_db.attach_to and location == element_db.location then
      						local position = element_db.position
      						while t[position] do
      							position = position + 1e-5
      							element_db.position = position
      						end
      						t[position] = element_id
      						sort[#sort+1] = position
      					end
      				end
      			end
      			for other_id, other_module in PitBull4:IterateModulesOfType("custom", true) do
      			   if other_id == 'VisualHelpers' then
      			      local db1 = GetLayoutDB(other_id)
        			      for n, v in pairs(db1.elements) do
      					   if attach_to == v.attach_to and location == v.location then
         			         if not v.position then
         			            v.position = 1e-6
         			         end
         						local position = v.position
         						while t[position] do
         							position = position + 1e-5
         							v.position = position
         						end
         						t[position] = 'VisualHelpers;' .. n
         						sort[#sort+1] = position
            				end
           				end
         				break;
      				end
      			end
      			table.sort(sort)
      			local sort_reverse = {}
      			for k, v in pairs(sort) do
      				sort_reverse[v] = k
      			end
      			for position, name in pairs(t) do
      				t[position] = ("%d. %s"):format(sort_reverse[position], name)
      			end
      			return t
      		end,
				disabled = function(info)
					return not(db.elements[CURRENT_HELPER].enabled and db.enabled)
				end,
      		order = 9,
      	},
      	size = {
      		type = 'range',
      		name = L["Size"],
      		desc = L["Size of the visual helper."],
      		get = get_layout,
      		set = set_layout,
      		min = 0.1,
      		max = 3,
      		step = 0.01,
      		bigStep = 0.05,
      		isPercent = true,
				disabled = function(info)
					return not(db.elements[CURRENT_HELPER].enabled and db.enabled)
				end,
				order = 10,
      	},
      },
	}
   return true, 
      'helper', {
         type = 'select',
   		name = L['Visual Helper'],
   		desc = L['Select visual helper to configure.'],
   		get = function(info,key)
   			if not rawget(helpers, CURRENT_HELPER) then
   				CURRENT_HELPER = next(helpers)
   			end
   			return CURRENT_HELPER
   		end,
   		set = function(info,value)
   			CURRENT_HELPER = value
   		end,
   		values = function(info)
   			return PitBull4_VisualHelpers:GetHelpersNames()
   		end,
   		order = 2,
      },
      'helper_options',
      HELPER_OPTIONS
end)
