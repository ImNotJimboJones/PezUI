------------------------------------------------------------------------------
--	GridStatusDirectionArrows by Slaren
------------------------------------------------------------------------------

local GridStatus = Grid:GetModule("GridStatus")
local MapFiles = LibStub("LibMapData-1.0") 

GridStatusDirectionArrows = GridStatus:NewModule("GridStatusDirectionArrows")
GridStatusDirectionArrows.menuName = "Direction arrows"


-- upvalues
local GridRoster = Grid:GetModule("GridRoster")
local GridFrame = Grid:GetModule("GridFrame")
local GetPlayerMapPosition = GetPlayerMapPosition
local SetMapToCurrentZone = SetMapToCurrentZone
local GetCurrentMapDungeonLevel = GetCurrentMapDungeonLevel
local GetMapInfo = GetMapInfo
local GetPlayerFacing = GetPlayerFacing
local UnitIsUnit = UnitIsUnit
local math_atan2 = math.atan2
local math_floor = math.floor
local math_sqrt = math.sqrt
local math_pi = math.pi
local math_2pi = 2*math.pi

GridStatusDirectionArrows.defaultDB = {
	debug = false,
	cycle_time = 1/20,

	alert_direction = {
		enable = true,
        color = { r = 1, g = 1, b = 1, a = 1, ignore = true },
		priority = 99,
		min_distance = 30,
		filter_units = true,
		filter_target = true,
		filter_mouseover = true,
		filter_focus = true,
	}
}

-- local data
local settings
local settings_direction
local update_frame = CreateFrame("Frame")
local update_timer = 0
local min_distance_sq

local direction_options = {
	["range"] = false,
	["color"] = false,
	["opacity"] = {
		order = 100,
		type = "range",
		name = "Opacity",
		desc = "Icon opacity",
		get = function () return GridStatusDirectionArrows.db.profile.alert_direction.color.a end,
		set = function (_, v) GridStatusDirectionArrows.db.profile.alert_direction.color.a = v; GridStatusDirectionArrows.core:SendStatusLostAllUnits("alert_direction") end,
		min = 0,
		max = 1,
		step = 0.01,
	},
	["cycle"] = {
		order = 101,
		type = "range",
		name = "Refresh time (seconds)",
		desc = "Seconds between status refreshes",
		width = "full",
		get = function () return GridStatusDirectionArrows.db.profile.cycle_time end,
		set = function (_, v) GridStatusDirectionArrows.db.profile.cycle_time = v end,
		min = 0.01,
		max = 1,
		step = 0.01,
	},
	["mindist"] = {
		order = 102,
		type = "range",
		name = "Minimum distance (yards)",
		desc = "Directions arrows aren't shown on units closer than this",
		width = "full",
		max = 100,
		min = 0,
		step = 0.1,
		get = function () return GridStatusDirectionArrows.db.profile.alert_direction.min_distance end,
		set = function (_, v)
			GridStatusDirectionArrows.db.profile.alert_direction.min_distance = v
			min_distance_sq = v ^ 2
		end,
	},
	["filter"] = {
		order = 103,
		type = "toggle",
		name = "Filter units",
		desc = "Enable this to show the direction arrows only in the specified units",
		width = "full",
		get = function () return GridStatusDirectionArrows.db.profile.alert_direction.filter_units end,
		set = function (_, v) GridStatusDirectionArrows.db.profile.alert_direction.filter_units = v end,
	},
	["filters"] = {
		order = 104,
		type = "group",
		name = "Unit filters",
		disabled = function() return not GridStatusDirectionArrows.db.profile.alert_direction.filter_units end,
		inline = true,
		args = {
			["target"] = {
				order = 1,
				type = "toggle",
				name = "Target",
				desc = "Show on target",
				get = function () return GridStatusDirectionArrows.db.profile.alert_direction.filter_target end,
				set = function (_, v) GridStatusDirectionArrows.db.profile.alert_direction.filter_target = v end,
			},
			["mouseover"] = {
				order = 2,
				type = "toggle",
				name = "Mouseover",
				desc = "Show on mouseover",
				get = function () return GridStatusDirectionArrows.db.profile.alert_direction.filter_mouseover end,
				set = function (_, v) GridStatusDirectionArrows.db.profile.alert_direction.filter_mouseover = v end,
			},
			["focus"] = {
				order = 3,
				type = "toggle",
				name = "Focus",
				desc = "Show on focus",
				get = function () return GridStatusDirectionArrows.db.profile.alert_direction.filter_focus end,
				set = function (_, v) GridStatusDirectionArrows.db.profile.alert_direction.filter_focus = v end,
			},
		}
	}
}

function GridStatusDirectionArrows:OnInitialize()
	self.super.OnInitialize(self)
	--
    WorldMapFrame:Show()
    WorldMapFrame:Hide()

	settings = self.db.profile
	settings_direction = settings.alert_direction
	
	min_distance_sq = settings_direction.min_distance ^ 2

	self:RegisterStatus("alert_direction", "Direction arrows", direction_options, true)
end

function GridStatusDirectionArrows:OnStatusEnable(status)
	if status == "alert_direction" then
		update_frame:SetScript("OnUpdate", function(_, elapsed) return self:OnUpdate(elapsed) end)
	end
end

function GridStatusDirectionArrows:OnStatusDisable(status)
	if status == "alert_direction" then
		self.core:SendStatusLostAllUnits(status)
		update_frame:SetScript("OnUpdate", nil)
	end
end


function GridStatusDirectionArrows:OnUpdate(elapsed)
	update_timer = update_timer + elapsed

	if update_timer >= settings.cycle_time then
		update_timer = 0
		GridStatusDirectionArrows:RefreshAll()
	end
end

local player_x, player_y
local map_width, map_height

function GridStatusDirectionArrows:RefreshMapData()
	-- check player position
	player_x, player_y = GetPlayerMapPosition("player")
	if player_x <= 0 and player_y <= 0 then
		if WorldMapFrame:IsVisible() then
			return false
		end
		-- carbonite blinking map workaround
		local f = GetMouseFocus()
		while f do
			if f:GetName() == "NxMap1" then
				return false
			end
			f = f:GetParent()
		end

		SetMapToCurrentZone()
		player_x, player_y = GetPlayerMapPosition("player") 
	end
 	
	-- continue only if map supported
	if (player_x > 0 or player_y > 0) then
		local fileName = GetMapInfo()
		local currentLevel = GetCurrentMapDungeonLevel()
		map_width, map_height = MapFiles:MapArea(fileName, currentLevel) 
		if map_width ~= 0 and map_height ~= 0 then
			return true
		end
	end
	
	return false
end

function GridStatusDirectionArrows:DistanceSq(unit_x, unit_y)
	local x = (unit_x - player_x) * map_width
	local y = (unit_y - player_y) * map_height

	return x * x + y * y
end

local mousefocusunit

function GridStatusDirectionArrows:IsUnitValid(unitid)
	if UnitIsUnit(unitid, "player") then
		return false
	end
	
	if not settings_direction.filter_units then
		return true
	elseif not settings_direction.filter_mouseover and not settings_direction.filter_target and not settings_direction.filter_focus then
		return true
	end
	
	-- mouseover
	if settings_direction.filter_mouseover and (UnitIsUnit(unitid, "mouseover") or (mousefocusunit and UnitIsUnit(unitid, mousefocusunit))) then
		return true
	end
	
	-- target
	if settings_direction.filter_target and UnitIsUnit(unitid, "target") then
		return true
	end
	
	-- focus
	if settings_direction.filter_focus and UnitIsUnit(unitid, "focus") then
		return true
	end

	return false
end
				
function GridStatusDirectionArrows:RefreshAll()
	if not self:RefreshMapData() then
		self.core:SendStatusLostAllUnits("alert_direction")
    else
		local player_facing = GetPlayerFacing()
		
		if settings_direction.filter_units and settings_direction.filter_mouseover then
			local mousefocus = GetMouseFocus()
			if mousefocus then
				mousefocusunit = mousefocus:GetAttribute("unit")
			else
				mousefocusunit = nil
			end
		end
		
		for guid, unitid in GridRoster:IterateRoster() do
			local unit_x, unit_y = GetPlayerMapPosition(unitid)
			local distancesq = self:DistanceSq(unit_x, unit_y)
			
			if (unit_x == 0 and unit_y == 0) or not self:IsUnitValid(unitid) or (min_distance_sq > 0 and distancesq < min_distance_sq) then
				self.core:SendStatusLost(guid, "alert_direction")
			else			
				local angle = math_pi - math_atan2(player_x - unit_x, unit_y - player_y) - player_facing
				local img = math_floor(angle / (math_2pi) * 108 + 0.5) % 108 + 1				

				self.core:SendStatusGained(guid, 
					"alert_direction",
					settings_direction.priority,
					nil,
					settings_direction.color,
					string.format("%0.1f", math_sqrt(distancesq)),
					1, 
					nil,
					"Interface\\AddOns\\GridStatusDirectionArrows\\Images\\Arrow_" .. tostring(img) .. ".tga")
			end
		end
	end
end
