-- LayoutOptions.lua : Options config
if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local _G = getfenv(0)
local PitBull4 = _G.PitBull4
local PitBull4_VisualHelpers= PitBull4:GetModule("VisualHelpers")
local L = PitBull4.L
local GetLayoutDB = PitBull4.Options.GetLayoutDB

function PitBull4_VisualHelpers:CreateVisualHelperIndicator(name)
                                                       
   local full_name = "VisualHelpers: ".. name
   local VisualHelperIndicator = PitBull4:NewModule(full_name)
   VisualHelperIndicator.full_name = full_name
   
   VisualHelperIndicator:SetModuleType("indicator")
   VisualHelperIndicator:SetName(L[full_name])
   VisualHelperIndicator:SetDescription(L["Visual Helper for '%s'."]:format(name))
   VisualHelperIndicator:SetDefaults({
   	attach_to = "root",
   	location = "in_top_right",
   	position = 1,
   	size = 1,
   	color = { 0, 1, 1, 1 },
   	texture = nil,
   	solid = true,
   	only_self = false,
   }, nil)
   
   -- :::::::::::: LOCALS ::::::::::::: -------------------------------------------------------------------------
   
   local LibSharedMedia = LibStub("LibSharedMedia-3.0", true)
   LoadAddOn("AceGUI-3.0-SharedMediaWidgets")
   local AceGUI = LibStub("AceGUI-3.0")
   
   -- :::::::::::: VisualHelperIndicator ::::::::::::: -------------------------------------------------------------------------
   
  	local db = GetLayoutDB(VisualHelperIndicator)
   
   function VisualHelperIndicator:ClearFrame(frame)
   	if not frame[full_name] then
   		return false
   	end
   	
   	local f = frame[full_name]
		f[1] = f[1]:Delete()
   	frame[full_name] = f:Delete()
   	
   	--print(full_name .. ' --> cleared')
   	return true
   end
         
   function VisualHelperIndicator:UpdateFrame(frame)
   	--print(full_name .. ' --> try update --> '.. frame.unit)
   	if not frame[full_name..'_show'] then
   	   --print(full_name .. ' --> clear')
   		return self:ClearFrame(frame)
   	end
   	
   	local f = frame[full_name]

   	if f then
   		f:Show()
   	   --print(full_name .. ' --> update')
   		return false
   	end
   	
		f = PitBull4.Controls.MakeFrame(frame)
		frame[full_name] = f
		f:SetFrameLevel(frame:GetFrameLevel() + 13)
   	
   	f:SetHeight(15)
   	f:SetWidth(15)
   	
   	local t = PitBull4.Controls.MakeTexture(f, "ARTWORK")
   	f[1] = t

      if db.solid then
    	   t:SetTexture([[Interface\Buttons\WHITE8X8]])
      else   
      	if LibSharedMedia then
      	   t:SetTexture(LibSharedMedia:Fetch("statusbar", db.texture or "Blizzard"))
      	else
      	   t:SetTexture([[Interface\TargetingFrame\UI-StatusBar]])
      	end
   	end
   		
   	t:SetVertexColor(unpack(db.color))
   	t:SetWidth(15)
   	t:SetHeight(15)
   	t:SetPoint("LEFT", f, "LEFT", 0, 0)
   	
   	f:Show()
   	--print(full_name .. ' --> create')
   
   	return true
   end
   
   VisualHelperIndicator:SetLayoutOptionsFunction(function(self)
   
      local function get_new_visual_helper_options()
         return {
            color = {0, 1, 1, 1},
            texture = nil,
            solid = true,
         }
      end
   	local function ensure_layout_db()
   		if not db then
   		   db = get_new_visual_helper_options()
   		end
   	end
   	local function get_layout(info)
   		local id = info[#info]
   		return db[id]
   	end
   	local function set_layout(info, value)
   		local id = info[#info]
   		db[id] = value
   		for frame in PitBull4:IterateFrames() do
   			self:Clear(frame)
   		end
   		PitBull4_VisualHelpers:UpdateIndicators()
   	end                              
   	
   	ensure_layout_db()
      
   	return 
			'h1', {
				type = 'header',
				name = '',
				order = 9,
			},
			'color', {
				type = 'color',
				name = L['Color'],
				desc = L["Color for this visual helper."],
      		get = function(info)
      		   return unpack(get_layout(info))
   			end,
      		set = function(info, r, g, b, a)
      		   set_layout(info, {r, g, b, a})
   			end,
				disabled = function(info)
					return self.enabled
				end,
				order = 10,
			},
         'texture', {
      		type = 'select',
      		name = L["Texture"],
      		desc = L["What texture to use for this visual helper."] .. "\n" .. L["If you want more textures, you should install the addon 'SharedMedia'."],
      		get = get_layout,
      		set = set_layout,
      		values = function(info)
      			return LibSharedMedia:HashTable("statusbar")
      		end,
      		hidden = function(info)
      			return not LibSharedMedia or db.solid
      		end,
      		dialogControl = AceGUI.WidgetRegistry["LSM30_Statusbar"] and "LSM30_Statusbar" or nil,
				disabled = function(info)
					return self.enabled
				end,
				order = 11,
      	},   	
   	   'solid', {
      		type = 'toggle',
      		name = L['Solid Color'],
      		desc = L['Visual helper will be rendered as solid color.'],
      		get = get_layout,
      		set = set_layout,
				disabled = function(info)
					return self.enabled
				end,
      		order = 12,
   	   },
			'h2', {
				type = 'header',
				name = '',
				order = 13,
			},
   	   'only_self', {
      		type = 'toggle',
      		name = L['Only casted by me'],
      		desc = L['Visual helper will be shown only if aura was casted by player.'],
      		get = get_layout,
      		set = set_layout,
				disabled = function(info)
					return self.enabled
				end,
      		order = 14,
   	   }
   end)

   return VisualHelperIndicator
      
end