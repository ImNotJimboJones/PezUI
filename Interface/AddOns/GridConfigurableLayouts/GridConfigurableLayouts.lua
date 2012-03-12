-- Project: GridConfigurableLayouts 0.4.3b
-- File: GridConfigurableLayouts.lua
-- Last Modified: 2011-07-01T16:13:05Z
-- Author: msaint
-- Project desc: Allows in-game creation of highly customized layouts in Grid
-- File desc: All core functionality and GUI options 

local FILE_VERSION = tonumber("78") or 5001
local OUR_VERSION = tonumber("0.4.3b") or 5001

-- **Tagged for removal when Grid anchorpoint bug fix syndicates
local _, _, GRID_IS_OLD = string.find(GetAddOnMetadata("Grid", "Version"), "[%.r](%d+)[%-%a]*$")
GRID_IS_OLD = (tonumber(GRID_OLD) or 0) < 1435


--{{{ Create the module
local gcl = Grid:GetModule("GridConfigurableLayouts", true) or Grid:NewModule("GridConfigurableLayouts", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0")
gcl.Versions = gcl.Versions or {} 
if (gcl.Versions.Base and gcl.Versions.Base >= FILE_VERSION) then return end
gcl.Versions.Base = FILE_VERSION
gcl.menuName = "GCLayouts"
gcl.Debug = Grid.Debug
gcl.gcldb = nil -- mentioned here so that we know how we will access our db from other files
---}}}


--{{{ Libraries                 
local Grid = Grid
local GridRoster = Grid:GetModule("GridRoster")
local GridLayout = Grid:GetModule("GridLayout")
local GridFrame = Grid:GetModule("GridFrame")
local media = LibStub("LibSharedMedia-3.0")
--}}}


--{{{ Hack the localization function for easy implementation later
gcl.L = gcl.L or {} 
local L = gcl.L 
setmetatable(L,{ __index = function(l, text) return text end})
---}}}


---{{{ Make everything local that we can
   --Lua library:
local ipairs, pairs, type, tinsert, tremove, table, string, math, tonumber, tostring, gmatch = ipairs, pairs, type, tinsert, tremove, table, string, math, tonumber, tostring, gmatch
local tContains = tContains -- not standard lua
   --WoW api:
local GetRealZoneText, GetRaidRosterInfo, GetNumPartyMembers = GetRealZoneText, GetRaidRosterInfo, GetNumPartyMembers 
local GetUnitName, UnitName, UnitIsInMyGuild, UnitInRaid, UnitInParty, UnitIsUnit, UnitName, UnitClass = GetUnitName, UnitName, UnitIsInMyGuild, UnitInRaid, UnitInParty, UnitIsUnit, UnitName, UnitClass
local InCombatLockdown = InCombatLockdown
local CreateFrame = CreateFrame
---}}}     


--{{{ make debug function local for convenience
local function debug(...)
   gcl:Debug("[GCL]", ...)
end 
--}}}


---{{{ File scope
-- Variables
local _
local combatLockdown = false
local redoGroupsQueued = false
local redoScheduled = nil
local isRegistered = false
local defaultLayout = nil
--local currentLayout = nil --stopped using this to avoid sync issues on asyncronously called functions
-- Tables
local gcldb -- Local reference to our DB. Will be set later.
local layoutNames = {}
local rosterZoneList = {} 
local outerFrames = {}
local outerPetFrames = {}
local emptyLayout = {
   defaults = {
  	   unitsPerColumn = 5,
	   maxColumns = 1,
	},
	[1] = {
		nameList = "",
	},
}
local filters = { --This is the order in which filters will appear in the GUI
   "tank",        --and must match the order of filterLabels defined 
   "blizztank",   --in the options section!
   "healer",
   "melee",
   "ranged",
   "damage",
   "guild",
   "ooz",
   "everyone",
   "rg1",
   "rg2",
   "rg3",
   "rg4",
   "rg5",
   "rg6",
   "rg7",
   "rg8",
   "pets",
   "empty",
}
---}}}


---{{{ Member variables
gcl.oozTimer = nil
gcl.newLayoutName = ""


---{{{ Utility functions
local function hasVisibleUnitFrame(f)
   -- Returns true if any child (recursively) contains a visible unit frame
   -- This function borrowed from GridLayout.lua with a small modification
	if f:IsVisible() and f:GetAttribute("unit") then
		return true
	end
   for _, f in ipairs({f:GetChildren()}) do
		if hasVisibleUnitFrame(f) then
			return true
		end
	end
end

-- Returns the maximum units allowed for partyState
local maxPartyUnits = {
   solo = 5,
	party = 5,
	raid_10 = 10,
   raid_25 = 25,
	bg = 40,
	arena = 5,
}
local function getMaxUnits(partyState)
   return maxPartyUnits[partyState]
end

local function tFind(t, val)
   -- Returns a member of t, if any, whose value is val.  Otherwise nil.
   if (t and val) then
      for member, value in pairs(t) do
         if (val == value) then
            return member
         end
      end
   end
end

local function tInsertT(t1, pos, t2)
   -- Inserts the entire contents of array t2 into array t1 at position pos
   if (type(pos) == "table") then
      t2 = pos
      pos = nil
   end 
   if (type(t1) == "table") and (type(t2) == "table") then
      local val
      pos = pos or #t1 + 1
      for i = #t2, 1, -1 do
         val = t2[i]
         if (not tContains(t1, val)) then
            tinsert(t1, pos, val)
         end
      end
   end
end

local function tCount(t)
   -- Counts the top level keys in table t
   local count = 0
   if (type(t) == "table") and next(t) then
      for k in pairs(t) do
         count = count + 1
      end
   end
   return count
end

local function tCopy(t, dest)
   -- Returns a copy of t, placing it in dest if present.
   -- If dest is not empty, leaves from t will replace entries in dest
   -- (think of copying a file tree with 'replace all'). 
   -- WARNING: If the table contains backward references to itself (or has
   -- subtables that do) this function will make your client die, since it will
   -- try to make infinite copies within copies. Caveat Emptor.
   if type(t) ~= "table" then error("tCopy : first argument must be a table") end
   dest = ((type(dest) == "table") and dest) or {}
	for k, v in pairs(t) do
		if type(v) == "table" then
			dest[k] = tCopy(v, dest[k])
		else
         dest[k] = v
      end
	end
   return dest
end

local function groupSort(t, primaryKey)
   -- For 'index' or 'name', just sorts on those.  For 'class' and 'role', first
   -- sorts on 'name', then sorts on 'class' or 'role'
   if (t and primaryKey) then
      local currentLayout = gcldb.layouts[GridLayout.db.profile.layouts[GridRoster:GetPartyState()]]
      if not currentLayout then return end
      local secondaryKey = (primaryKey ~= "name" and primaryKey ~= "index" and "name") or nil
      local key = secondaryKey or primaryKey
      local comp = function (t1, t2)
         
         return (t1[key] and t2[key] and t1[key] < t2[key])
      end
      table.sort(t, comp)
      if secondaryKey then
         key = primaryKey
         local order = currentLayout.sortOptions.sortOrder[key]
         local default = tCount(order) + 1
         setmetatable(order, { __index = function(t, k) return default end})
         debug("We are sorting on " .. key)
         local comp = function (t1, t2)
            debug("We are sorting " .. t1.name .. " and " .. t2.name)
            debug("The " .. key .. " for t1 is " .. t1[key])
            debug("The order for t1[key] is " .. tostring(order[t1[key]]))
            return (t1[key] and t2[key] and order[t1[key]] < order[t2[key]])
         end
         table.sort(t, comp)
      end
   end
end

local function UnitIndex(unit)
   -- Gets the unit index regardless of party type
   local index = UnitInRaid(unit) 
   if (not index) then
      if UnitIsUnit("player", unit) then 
         index = 0
      else 
         for i=0, GetNumPartyMembers() do  
            if UnitIsUnit(unit, "party"..tostring(i+1)) then
               index = i + 1
               break
            end
         end
      end
   end
   return index
end
---}}}


--{{{ DB defaults
local defaultDB = {
   debug = false,
   checkOOZFrequency = 3,
   useBlizzRoles = true,
   blizzRolesRule = false,
   configLayout = "GCL Default",
   filterToColor = "tank",
   filterColors = {
      tank = {r = 0.99, g = 0.30, b = 0.30, a = 0.85},
      blizztank = {r = 0.99, g = 0.30, b = 0.30, a = 0.85},
      melee = {r = 0.9, g = 0.85, b = 0.35, a = 0.85},
      healer = {r = 0.35, g = 0.99, b = 0.35, a = 0.85},
      ranged = {r = 0.35, g = 0.35, b = 0.99, a = 0.85},
      damage = {r = 0.75, g = 0.30, b = 0.90, a = 0.85},
      ooz = {r = 0.45, g = 0.45, b = 0.45, a = 0.65},
      rg1 = {r = 0.75, g = 0.75, b = 0.75, a = 0.80},
      rg2 = {r = 0.75, g = 0.75, b = 0.75, a = 0.80},
      rg3 = {r = 0.75, g = 0.75, b = 0.75, a = 0.80},
      rg4 = {r = 0.75, g = 0.75, b = 0.75, a = 0.80}, 
      rg5 = {r = 0.75, g = 0.75, b = 0.75, a = 0.80},
      rg6 = {r = 0.75, g = 0.75, b = 0.75, a = 0.80}, 
      rg7 = {r = 0.75, g = 0.75, b = 0.75, a = 0.80}, 
      rg8 = {r = 0.75, g = 0.75, b = 0.75, a = 0.80}, 
      pets = {r = 0.35, g = 0.50, b = 0.35, a = 0.90},
      empty = {r = 0.60, g = 0.60, b = 0.60, a = 0.80},
      guild = {r = 0.20, g = 0.90, b = 0.65, a = 0.80},
      everyone = {r = 0.75, g = 0.75, b = 0.75, a = 0.80},
   },
   layouts = {
      ["GCL Default"] = {
         unitsPerColumn = 5,
         createBorders = true,
         allowRepeats = false,
         numGroups = 6,
         groupType = {"tank", "melee", "healer", "ranged", "pets", "ooz", "none", "none", "none", "none", "none" },
         nameList = {"", "", "", "", "", "", "", "", "", "", "" },
         petOptions = {
            ["allPets"] = false,
            ["HUNTER"] = true,
            ["WARLOCK"] = true,
            ["DEATHKNIGHT"] = true,
         },
         sortOptions = {
            sortMethod = "name",
            sortOrder = {
               role = {"tank", "healer", "melee", "ranged"},
               class = {"deathknight", "druid", "hunter", "mage", "paladin", "priest", "rogue", "shaman", "warlock", "warrior"},
            },
         },
      },
      ["GCL Group 10"] = {
         unitsPerColumn = 5,
         createBorders = false,
         allowRepeats = false,
         numGroups = 5,
         groupType = {"tank", "rg1", "rg2", "pets", "ooz", "none", "none", "none", "none", "none", "none" },
         nameList = {"", "", "", "", "", "", "", "", "", "", "" },
         petOptions = {
            ["allPets"] = true,
            ["HUNTER"] = true,
            ["WARLOCK"] = true,
            ["DEATHKNIGHT"] = true,
         },
         sortOptions = {
            sortMethod = "role",
            sortOrder = {
               role = {"tank", "healer", "melee", "ranged"},
               class = {"deathknight", "druid", "hunter", "mage", "paladin", "priest", "rogue", "shaman", "warlock", "warrior"},
            },
         },
      },
      ["GCL Group 25"] = {
         unitsPerColumn = 5,
         createBorders = false,
         allowRepeats = false,
         numGroups = 8,
         groupType = {"tank", "rg1", "rg2", "rg3", "rg4", "rg5", "pets", "ooz", "none", "none", "none" },
         nameList = {"", "", "", "", "", "", "", "", "", "", "" },
         petOptions = {
            ["allPets"] = true,
            ["HUNTER"] = true,
            ["WARLOCK"] = true,
            ["DEATHKNIGHT"] = true,
         },
         sortOptions = {
            sortMethod = "name",
            sortOrder = {
               role = {"tank", "healer", "melee", "ranged"},
               class = {"deathknight", "druid", "hunter", "mage", "paladin", "priest", "rogue", "shaman", "warlock", "warrior"},
            },
         },
      }, 
   },
}
gcldb = defaultDB -- This is temporary, just to prevent errors from anything that happens before initialization is called
local defaultLayout = tCopy(defaultDB.layouts["GCL Default"])
mso_debug_info = {}
--}}}


---{{{ Other local functions
local function getDB()
   -- Gets our db table.  Will copy over any old Grid db (pre r74) if 
   -- GridConfigurableLayoutsDB is not present.
   local newdb = {}
   local root = Grid.db.children.GridConfigurableLayouts.sv or {}
   table.insert(mso_debug_info, "Reached getDB")
   if not (GridConfigurableLayoutsDB and GridConfigurableLayoutsDB.layouts) then
      table.insert(mso_debug_info, "getDB found no new style DB")
      if (root.profiles and next(root.profiles) and (next(root.profiles)).layouts)
         or (root.global and next(root.global) and (next(root.global)).layouts) then
         debug("Attempting to import old database to new format.")
         table.insert(mso_debug_info, "getDB found an old style DB")
         for k, v in pairs(root.global) do
            if rawget(root.global, k) then
               -- Since we are going to nil the original, there is no point in making a copy
               newdb[k] = v
               root.global[k] = nil
            end
         end
         -- This will also pick up the old defaults that some of the profiles rely on. (defaults is a profile in AceDB) 
         for profileName, profile in pairs(root.profiles) do 
            if profile and next(profile) then
               for k, v in pairs(profile) do
                  if rawget(profile, k) then
                     -- Since we are going to nil the original, there is no point in making a copy
                     newdb[k] = v
                     profile[k] = nil
                  end
               end
            end
         end
         -- Just in case, let's fill any missing keys with the defaults.
         for k, v in pairs(defaultDB) do
            if not newdb[k] then
               newdb[k] = tCopy(v)
            end
         end
         -- And, for good measure, make sure all of the default profiles are there.
         for k, v in pairs(defaultDB.layouts) do
            -- Note that we are NOT adding back in any elements withing the profiles
            -- that might have been intentionally removed.
            if not newdb.layouts[k] then
               newdb.layouts[k] = tCopy(v)
            end
         end
      else
         table.insert(mso_debug_info, "getDB found no DB at all.  Setting newdb to defaults")
         -- Not really necessary to make a copy here, since the rest of the code
         -- doesn't use the defaultDB table.
         newdb = defaultDB
      end
   else
      table.insert(mso_debug_info, "getDB found a new style DB")
      newdb = GridConfigurableLayoutsDB
   end
   table.insert(mso_debug_info, newdb)
   return newdb
end
--}}}


--{{{ Options Structure
do 
   local filterLabels = {   --This is the order in which filters will appear in
      L["Tanks"],           --the GUI and must match the order of filters      
      L["Blizzard Tanks"],  --defined above in the file scope variables section!                               
      L["Healers"],
      L["Melee"],
      L["Ranged"],
      L["Damage"],
      L["Guild"],
      L["Out Of Zone"],
      L["Everyone"],
      L["Raid Group 1"],
      L["Raid Group 2"],
      L["Raid Group 3"],
      L["Raid Group 4"],
      L["Raid Group 5"],
      L["Raid Group 6"],
      L["Raid Group 7"],
      L["Raid Group 8"],
      L["Pets"],
      L["Namelist (or Empty)"],
   }

   local function filterLabel(filter)
      -- Returns the label for a filter based on the internal GCL name for it. 
      -- Makes some of the handlers in the options more readable, but I wish
      -- we had inline functions.
      return filterLabels[tFind(filters, filter)]
   end

   local options = {
      ["layoutOptions"] = {
         type = "group",
         name = L["Layout Options"],
         desc = L["Options that apply to a specific layout."],
         order = 25,
         disabled = InCombatLockdown,
         handler = {
            ["hidden"] = function (self, info)
               local _, _, iT = string.find(info[#info], "(%d+)")
               return (iT and tonumber(iT) > gcldb.layouts[gcldb.configLayout].numGroups) 
            end,
         },
         args = {
            ["layoutHeader"] = {
               type = "description",
               fontSize = "medium",
               name = function () return "[" .. gcldb.configLayout .. "]\n" end, 
               order = 0,
            },
            ["layoutSelectGroup"] = {
               type = "group",
               name = "Select Layout",
               inline = true,
               order = 2,
               args = {
         	      ["configLayout"] = {
                     type = "select",
                 	   name = L["Select layout to configure:"],
                 	   desc = L["Sets which layout configuration changes apply to."],
                 	   order = 2,
                 	   width = "double",
                     disabled = InCombatLockdown,
                 	   get = function () return gcldb.configLayout end,
                 	   set = function (_, v) gcl:loadNewConfig(v) end,
                 	   values = function() return layoutNames end,
                  },
                  ["configLayoutExplanation"] = {
                     type = "description",
                     name = L["\n* All changes made in the 'General', 'Group Filters', 'Name Lists', and 'Sorting' sub-pages will apply to the layout selected above.\n"],
                     order = 3,
                     width = "full",
                  },
               },
            },
            ["createRemoveGroup"] = { 
         	   type = "group",
         	   inline = true,
               name = L["Create or Remove Layout"],
         	   order = 8,
         	   args = {
               	["newLayoutName"] = {
                     type = "input",
                     name = L["Name to create or remove:"],
                     desc = L["Name of layout to create or remove (hint: type name then press <enter>)."],
                     width = "full",
                     order = 9,
                     disabled = InCombatLockdown,
                     get = function () return gcl.newLayoutName end,
                     set = function (_, v) 
                        gcl.newLayoutName = v
                     end, 
                  },
                  ["createNewLayout"] = {
                     type = "execute",
                     name = L["Create New Layout"],
                     desc = L["Create a new layout."],
                     order = 11,
                     disabled = function () return InCombatLockdown() or (not gcl.newLayoutName or gcl.newLayoutName == "" or GridLayout.layoutSettings[gcl.newLayoutName]) end,
                     func = function () gcl:createLayout(gcl.newLayoutName) end,
                  },
                  ["removeLayout"] = {
                     type = "execute",
                     name = L["Remove Layout"],
                     desc = L["Remove a layout."],
                     order = 12,
                     disabled = function () return InCombatLockdown() or (not gcldb.layouts[gcl.newLayoutName] or gcl.newLayoutName == "GCL Default") end,
                     func = function () gcl:removeLayout(gcl.newLayoutName) end,
                  },
               },
            },
            ["generalOptions"] = {
               type = "group",
               name = L["General"],
               desc = L["Options that apply to this layout."],
               order = 25,
               disabled = InCombatLockdown,
               args = {
                  ["layoutHeader"] = {
                     type = "description",
                     fontSize = "medium",
                     name = function () return "[" .. gcldb.configLayout .. "]\n" end, 
                     order = 0,
                  },
                  ["otherOptions"] = {
                     type = "group",
                     inline = true,
                     name = "Player Group Options",
                     order = 10,
                     args = {
                        ["unitsPerColumn"] = {
                     	   type = "range",
                      		name = L["Maximum units per column (or row)"],
                       	   desc = L["Maximum number of units to display in each column or row."],
                           width = "double",
                           order = 21,
                           disabled = InCombatLockdown,
                           max = 40,
                           min = 1,
                           step = 1,
                           get = function ()	return gcldb.layouts[gcldb.configLayout].unitsPerColumn end,
                     	   set = function (_, v)
                        		gcldb.layouts[gcldb.configLayout].unitsPerColumn = v
                        	   gcl:checkUpdateCurrent()
                     	   end,
                        },
                        ["allowRepeats"] = {
                       	   type = "toggle",
                          	name = L["Allow repeats"],
                          	desc = L["Show raid members in all groups that apply, instead of only once"],
                          	order = 16,
                           width = "full",
                          	disabled = InCombatLockdown,
                          	get = function () return gcldb.layouts[gcldb.configLayout].allowRepeats end,
                          	set = function (_, v)
                              gcldb.layouts[gcldb.configLayout].allowRepeats =
                                 not gcldb.layouts[gcldb.configLayout].allowRepeats
                              gcl:checkUpdateCurrent()
                           end, 
                        },
                        ["offlineIsOOZ"] = {
                       	   type = "toggle",
                          	name = L["Treat offline as out of zone"],
                          	desc = L["Put raid members that are offline in out of zone group, if present."],
                          	width = "full",
                           order = 19,
                          	disabled = InCombatLockdown,
                          	get = function () return gcldb.layouts[gcldb.configLayout].offlineIsOOZ end,
                          	set = function (_, v)
                              gcldb.layouts[gcldb.configLayout].offlineIsOOZ =
                                 not gcldb.layouts[gcldb.configLayout].offlineIsOOZ
                              gcl:checkUpdateCurrent()
                           end, 
                        },
                     	["createBorders"] = {
                           type = "toggle",
                           name = L["Replace Grid Border with Group Borders"],
                           desc = L["Enable creation of colored borders around groups. Uses GridLayout border texture.\nHint: play with your padding under Layout."],
                           width = "full",
                           order = 20,
                           disabled = InCombatLockdown,
                           get = function () return gcldb.layouts[gcldb.configLayout].createBorders end,
                           set = function ()
                              gcldb.layouts[gcldb.configLayout].createBorders = 
                                 not gcldb.layouts[gcldb.configLayout].createBorders
                              gcl:checkUpdateCurrent()
                           end, 
                        },
                     },
                  },                  
                  ["petOptions"] = {
                     type = "group",
                     inline = true,
                     name = L["Pet Group Options"],
                     order = 20,
                     args = {
                        ["petOptionsHeader"] = { 
                           type = "header",
                           name = L["Pet Group Options"],
                           order = 3,
                           width = "full",
               	      },
                        ["enableAllPets"] = {
                           type = "toggle",
                           name = L["Display all raid pets"],
                           desc = L["Display raid pets for all pet classes."],
                           width = "double",
                           order = 4,
                           disabled = InCombatLockdown,
                           get = function () return gcldb.layouts[gcldb.configLayout].petOptions["allPets"] end,
                           set = function ()
                              gcldb.layouts[gcldb.configLayout].petOptions["allPets"] =
                                 not gcldb.layouts[gcldb.configLayout].petOptions["allPets"]
                              gcl:checkUpdateCurrent()
                           end, 
                        },
                        ["enableHunterPets"] = {
                           type = "toggle",
                           name = L["Display hunter pets"],
                           desc = L["Display raid pets for hunters."],
                           width = "double",
                           disabled = function () return InCombatLockdown() or gcldb.layouts[gcldb.configLayout].petOptions["allPets"] end, 
                           order = 5,
                           get = function () return gcldb.layouts[gcldb.configLayout].petOptions["HUNTER"] end,
                           set = function ()
                              gcldb.layouts[gcldb.configLayout].petOptions["HUNTER"] =
                                 not gcldb.layouts[gcldb.configLayout].petOptions["HUNTER"]
                              gcl:checkUpdateCurrent()
                           end, 
                        },
                        ["enableWarlockPets"] = {
                           type = "toggle",
                           name = L["Display warlock pets"],
                           desc = L["Display raid pets for warlocks."],
                           width = "double",
                           disabled = function () return InCombatLockdown() or gcldb.layouts[gcldb.configLayout].petOptions["allPets"] end,
                           order = 6,
                           get = function () return gcldb.layouts[gcldb.configLayout].petOptions["WARLOCK"] end,
                           set = function ()
                              gcldb.layouts[gcldb.configLayout].petOptions["WARLOCK"] =
                                 not gcldb.layouts[gcldb.configLayout].petOptions["WARLOCK"]
                              gcl:checkUpdateCurrent()
                           end, 
                        },
                        ["enableDeathknighPets"] = {
                           type = "toggle",
                           name = L["Display deathknight pets"],
                           desc = L["Display raid pets for deathknights."],
                           width = "double",
                           disabled = function () return InCombatLockdown() or gcldb.layouts[gcldb.configLayout].petOptions["allPets"] end,
                           order = 7,
                           get = function () return gcldb.layouts[gcldb.configLayout].petOptions["DEATHKNIGHT"] end,
                           set = function ()
                              gcldb.layouts[gcldb.configLayout].petOptions["DEATHKNIGHT"] =
                                 not gcldb.layouts[gcldb.configLayout].petOptions["DEATHKNIGHT"]
                              gcl:checkUpdateCurrent()
                           end, 
                        },
                     },
                  },
               },
            },
            ["editGroupFilters"] = {
               type = "group",
               name = L["Group Filters"],
               desc = L["Select filters to apply to groups in the current layout."],
               order = 27,
               disabled = InCombatLockdown,
               args = {
                  ["layoutHeader"] = {
                     type = "description",
                     fontSize = "medium",
                     name = function () return "[" .. gcldb.configLayout .. "]\n" end, 
                     order = 0,
                  },
                  ["groupType1"] = {
                     type = "select",
                     name = L["Group 1:"],
                 	   desc = L["Sets contents of the first grid group."],
                     order = 2,
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                 	   get = function () return tFind(filters, gcldb.layouts[gcldb.configLayout].groupType[1]) end,
                 	   set = function (_, v)
                        gcldb.layouts[gcldb.configLayout].groupType[1]= filters[v]
                        gcl:checkUpdateCurrent()
                     end,
                 	   values = filterLabels,
                  },
                  ["groupType2"] = {
                     type = "select",
                 	   name = L["Group 2:"],
                 	   desc = L["Sets contents of the second grid group."],
                 	   order = 3,
                 	   disabled = InCombatLockdown,
                 	   hidden = "hidden",
                 	   get = function () return tFind(filters, gcldb.layouts[gcldb.configLayout].groupType[2]) end,
                 	   set = function (_, v)
                        gcldb.layouts[gcldb.configLayout].groupType[2]= filters[v]
                        gcl:checkUpdateCurrent()
                     end,
                 	   values = filterLabels,
                  },
                  ["groupType3"] = {
                     type = "select",
                 	   name = L["Group 3:"],
                 	   desc = L["Sets contents of the third grid group."],
                 	   order = 5,
                 	   disabled = InCombatLockdown,
                 	   hidden = "hidden",
                     get = function () return tFind(filters, gcldb.layouts[gcldb.configLayout].groupType[3]) end,
                 	   set = function (_, v)
                        gcldb.layouts[gcldb.configLayout].groupType[3]= filters[v]
                        gcl:checkUpdateCurrent()
                     end,
                    	values = filterLabels,
                  },
                  ["groupType4"] = {
                     type = "select",
                 	   name = L["Group 4:"],
                 	   desc = L["Sets contents of the fourth grid group."],
                 	   order = 6,
                 	   disabled = InCombatLockdown,
                 	   hidden = "hidden",
                     get = function () return tFind(filters, gcldb.layouts[gcldb.configLayout].groupType[4]) end,
                 	   set = function (_, v)
                        gcldb.layouts[gcldb.configLayout].groupType[4]= filters[v]
                        gcl:checkUpdateCurrent()
                     end,
                    	values = filterLabels,
                  },
                  ["groupType5"] = {
                     type = "select",
                 	   name = L["Group 5:"],
                 	   desc = L["Sets contents of the fifth grid group."],
                 	   order = 7,
                 	   disabled = InCombatLockdown,
                 	   hidden = "hidden",
                 	   get = function () return tFind(filters, gcldb.layouts[gcldb.configLayout].groupType[5]) end,
                 	   set = function (_, v)
                        gcldb.layouts[gcldb.configLayout].groupType[5]= filters[v]
                        gcl:checkUpdateCurrent()
                     end,
                    	values = filterLabels,
                  },
                  ["groupType6"] = {
                     type = "select",
                 	   name = L["Group 6:"],
                 	   desc = L["Sets contents of the sixth grid group."],
                 	   order = 8,
                 	   disabled = InCombatLockdown,
                 	   hidden = "hidden",
                 	   get = function () return tFind(filters, gcldb.layouts[gcldb.configLayout].groupType[6]) end,
                 	   set = function (_, v)
                        gcldb.layouts[gcldb.configLayout].groupType[6]= filters[v]
                        gcl:checkUpdateCurrent()
                     end,
                    	values = filterLabels,
                  },
                  ["groupType7"] = {
                     type = "select",
                 	   name = L["Group 7:"],
                 	   desc = L["Sets contents of the seventh grid group."],
                 	   order = 9,
                 	   disabled = InCombatLockdown,
                 	   hidden = "hidden",
                 	   get = function () return tFind(filters, gcldb.layouts[gcldb.configLayout].groupType[7]) end,
                 	   set = function (_, v)
                        gcldb.layouts[gcldb.configLayout].groupType[7]= filters[v]
                        gcl:checkUpdateCurrent()
                     end,
                    	values = filterLabels,
                  },
                  ["groupType8"] = {
                     type = "select",
                 	   name = L["Group 8:"],
                    	desc = L["Sets contents of the eighth grid group."],
                 	   order = 10,
                 	   disabled = InCombatLockdown,
                 	   hidden = "hidden",
                    	get = function () return tFind(filters, gcldb.layouts[gcldb.configLayout].groupType[8]) end,
                    	set = function (_, v)
                        gcldb.layouts[gcldb.configLayout].groupType[8]= filters[v]
                        gcl:checkUpdateCurrent()
                     end,
                    	values = filterLabels,
                  },
                  ["groupType9"] = {
                     type = "select",
                 	   name = L["Group 9:"],
                 	   desc = L["Sets contents of the ninth grid group."],
                 	   order = 11,
                 	   disabled = InCombatLockdown,
                 	   hidden = "hidden",
                 	   get = function () return tFind(filters, gcldb.layouts[gcldb.configLayout].groupType[9]) end,
                 	   set = function (_, v)
                        gcldb.layouts[gcldb.configLayout].groupType[9]= filters[v]
                        gcl:checkUpdateCurrent()
                     end,
                 	   values = filterLabels,
                  },
                  ["groupType10"] = {
                     type = "select",
                 	   name = L["Group 10:"],
                 	   desc = L["Sets contents of the tenth grid group."],
                 	   order = 12,
                 	   disabled = InCombatLockdown,
                 	   hidden = "hidden",
                 	   get = function () return tFind(filters, gcldb.layouts[gcldb.configLayout].groupType[10]) end,
                 	   set = function (_, v)
                        gcldb.layouts[gcldb.configLayout].groupType[10]= filters[v]
                        gcl:checkUpdateCurrent()
                     end,
                    	values = filterLabels,
                  },
                  ["groupType11"] = {
                     type = "select",
                 	   name = L["Group 11:"],
                 	   desc = L["Sets contents of the eleventh grid group."],
                 	   order = 13,
                 	   disabled = InCombatLockdown,
                 	   hidden = "hidden",
                 	   get = function () return tFind(filters, gcldb.layouts[gcldb.configLayout].groupType[11]) end,
                 	   set = function (_, v)
                        gcldb.layouts[gcldb.configLayout].groupType[11]= filters[v]
                        gcl:checkUpdateCurrent()
                     end,
                 	   values = filterLabels,
                  },
                  ["softSpacer"] = { 
                     type = "description",
                     name = "\n",
                     order = 14,
                     width = "full",
         	      },
                  ["addGroup"] = {
                     type = "execute",
                     name = L["Add a Group"],
                     desc = L["Add a group."],
                     order = 15,
                     disabled = function () return InCombatLockdown() or (gcldb.layouts[gcldb.configLayout].numGroups > 10) end,
                     func = function ()
                        local num = gcldb.layouts[gcldb.configLayout].numGroups + 1
                        gcldb.layouts[gcldb.configLayout].groupType[num] = "empty"
                        gcldb.layouts[gcldb.configLayout].numGroups = num
                        gcl:checkUpdateCurrent()
                     end,
                  },
                  ["removeGroup"] = {
                     type = "execute",
                     name = L["Remove a Group"],
                     desc = L["Remove a group."],
                     order = 16,
                     disabled = function () return InCombatLockdown() or (gcldb.layouts[gcldb.configLayout].numGroups < 2) end,
                     func = function ()
                        local num = gcldb.layouts[gcldb.configLayout].numGroups
                        gcldb.layouts[gcldb.configLayout].groupType[num] = "none"
                        gcldb.layouts[gcldb.configLayout].numGroups = num - 1
                        gcl:checkUpdateCurrent()
                     end,
                  },    
               },
            },
            ["editNameLists"] = {
               type = "group",
               name = L["Name Lists"],
               desc = L["Edit name lists to apply to groups in the current layout."],
               order = 29,
               disabled = InCombatLockdown,
               args = {
                  ["layoutHeader"] = {
                     type = "description",
                     fontSize = "medium",
                     name = function () return "[" .. gcldb.configLayout .. "]\n" end, 
                     order = 0,
                  },
                  ["nameList1"] = {
                     type = "input",
           	         name = L["Group 1:"],
           	         desc = L["Sets name list for the first grid group (comma separated list)."],
                     usage = "",
           	         order = 1,
                     width = "double",
           	         disabled = InCombatLockdown,
                     hidden = "hidden",
           	         get = function () return gcldb.layouts[gcldb.configLayout].nameList[1] end,
           	         set = function (_, v)
                        v = v:gsub("(%a)(%a+)", function (a,b) return a:upper() .. b:lower() end)
                        gcldb.layouts[gcldb.configLayout].nameList[1] = v
                        gcl:checkUpdateCurrent()
                     end,
                  },
                  ["addTarget1"] = {
                     type = "execute",
                     name = L["+Target"],
                     desc = L["Add your target to the name list for group 1."],
                     order = 2,
                     width = "half",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     func = function ()
                        local name = GetUnitName("target")
                        if name and (UnitInParty("target") or UnitInRaid("target")) then
                           if gcldb.layouts[gcldb.configLayout].nameList[1] ~= "" then
                              name = ", " .. name
                           end
                           gcldb.layouts[gcldb.configLayout].nameList[1] =
                              gcldb.layouts[gcldb.configLayout].nameList[1] .. name
                           gcl:checkUpdateCurrent()
                        end
                     end,
                  },
                  ["nameList2"] = {
                     type = "input",
             	      name = L["Group 2:"],
             	      desc = L["Sets name list for the second grid group (comma separated list)."],
             	      usage = "",
                     order = 3,
                     width = "double",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
             	      get = function () return gcldb.layouts[gcldb.configLayout].nameList[2] end,
             	      set = function (_, v)
                         v = v:gsub("([^%s%p])([^%s%p]+)", function (a,b) return a:upper() .. b:lower() end)
                         gcldb.layouts[gcldb.configLayout].nameList[2] = v
                         gcl:checkUpdateCurrent()
                     end,
                  },
                  ["addTarget2"] = {
                     type = "execute",
                     name = L["+Target"],
                     desc = L["Add your target to the name list for group 2."],
                     order = 4,
                     width = "half",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     func = function ()
                        local name = GetUnitName("target")
                        if name and (UnitInParty("target") or UnitInRaid("target")) then
                           if gcldb.layouts[gcldb.configLayout].nameList[2] ~= "" then
                              name = ", " .. name
                           end
                           gcldb.layouts[gcldb.configLayout].nameList[2] =
                              gcldb.layouts[gcldb.configLayout].nameList[2] .. name
                           gcl:checkUpdateCurrent()
                        end
                     end,
                  },
                  ["nameList3"] = {
                     type = "input",
                     name = L["Group 3:"],
                     desc = L["Sets name list for the third grid group (comma separated list)."],
                     usage = "",
                     order = 5,
                     width = "double",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     get = function () return gcldb.layouts[gcldb.configLayout].nameList[3] end,
                     set = function (_, v)
                        v = v:gsub("([^%s%p])([^%s%p]+)", function (a,b) return a:upper() .. b:lower() end)
                        gcldb.layouts[gcldb.configLayout].nameList[3] = v
                        gcl:checkUpdateCurrent()
                     end,
                  },
                  ["addTarget3"] = {
                     type = "execute",
                     name = L["+Target"],
                     desc = L["Add your target to the name list for group 3."],
                     order = 6,
                     width = "half",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     func = function ()
                        local name = GetUnitName("target")
                        if name and (UnitInParty("target") or UnitInRaid("target")) then
                           if gcldb.layouts[gcldb.configLayout].nameList[3] ~= "" then
                              name = ", " .. name
                           end
                           gcldb.layouts[gcldb.configLayout].nameList[3] =
                              gcldb.layouts[gcldb.configLayout].nameList[3] .. name
                           gcl:checkUpdateCurrent()
                        end
                     end,
                  },
                  ["nameList4"] = {
                      type = "input",
                      name = L["Group 4:"],
                      desc = L["Sets name list for the fourth grid group (comma separated list)."],
                      usage = "",
                      order = 7,
                      width = "double",
                      disabled = InCombatLockdown,
                     hidden = "hidden",
                      get = function () return gcldb.layouts[gcldb.configLayout].nameList[4] end,
                      set = function (_, v)
                         v = v:gsub("([^%s%p])([^%s%p]+)", function (a,b) return a:upper() .. b:lower() end)
                         gcldb.layouts[gcldb.configLayout].nameList[4] = v
                         gcl:checkUpdateCurrent()
                      end,
                  },
                  ["addTarget4"] = {
                     type = "execute",
                     name = L["+Target"],
                     desc = L["Add your target to the name list for group 4."],
                     order = 8,
                     width = "half",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     func = function ()
                        local name = GetUnitName("target")
                        if name and (UnitInParty("target") or UnitInRaid("target")) then
                           if gcldb.layouts[gcldb.configLayout].nameList[4] ~= "" then
                              name = ", " .. name
                           end
                           gcldb.layouts[gcldb.configLayout].nameList[4] =
                              gcldb.layouts[gcldb.configLayout].nameList[4] .. name
                           gcl:checkUpdateCurrent()
                        end
                     end,
                  },
                  ["nameList5"] = {
                      type = "input",
                      name = L["Group 5:"],
                      desc = L["Sets name list for the fifth grid group (comma separated list)."],
                      usage = "",
                      order = 9,
                      width = "double",
                      disabled = InCombatLockdown,
                     hidden = "hidden",
                      get = function () return gcldb.layouts[gcldb.configLayout].nameList[5] end,
                      set = function (_, v)
                         v = v:gsub("([^%s%p])([^%s%p]+)", function (a,b) return a:upper() .. b:lower() end)
                         gcldb.layouts[gcldb.configLayout].nameList[5] = v
                         gcl:checkUpdateCurrent()
                      end,
                  },
                  ["addTarget5"] = {
                     type = "execute",
                     name = L["+Target"],
                     desc = L["Add your target to the name list for group 5."],
                     order = 10,
                     width = "half",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     func = function ()
                        local name = GetUnitName("target")
                        if name and (UnitInParty("target") or UnitInRaid("target")) then
                           if gcldb.layouts[gcldb.configLayout].nameList[5] ~= "" then
                              name = ", " .. name
                           end
                           gcldb.layouts[gcldb.configLayout].nameList[5] =
                              gcldb.layouts[gcldb.configLayout].nameList[5] .. name
                           gcl:checkUpdateCurrent()
                        end
                     end,
                  },
                  ["nameList6"] = {
                      type = "input",
                      name = L["Group 6:"],
                      desc = L["Sets name list for the sixth grid group (comma separated list)."],
                      usage = "",
                      order = 11,
                      width = "double",
                      disabled = InCombatLockdown,
                     hidden = "hidden",
                      get = function () return gcldb.layouts[gcldb.configLayout].nameList[6] end,
                      set = function (_, v)
                         v = v:gsub("([^%s%p])([^%s%p]+)", function (a,b) return a:upper() .. b:lower() end)
                         gcldb.layouts[gcldb.configLayout].nameList[6] = v
                         gcl:checkUpdateCurrent()
                      end,
                  },
                  ["addTarget6"] = {
                     type = "execute",
                     name = L["+Target"],
                     desc = L["Add your target to the name list for group 6."],
                     order = 12,
                     width = "half",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     func = function ()
                        local name = GetUnitName("target")
                        if name and (UnitInParty("target") or UnitInRaid("target")) then
                           if gcldb.layouts[gcldb.configLayout].nameList[6] ~= "" then
                              name = ", " .. name
                           end
                           gcldb.layouts[gcldb.configLayout].nameList[6] =
                              gcldb.layouts[gcldb.configLayout].nameList[6] .. name
                           gcl:checkUpdateCurrent()
                        end
                     end,
                  },
                  ["nameList7"] = {
                      type = "input",
                      name = L["Group 7:"],
                      desc = L["Sets name list for the seventh grid group (comma separated list)."],
                      usage = "",
                      order = 13,
                      width = "double",
                      disabled = InCombatLockdown,
                     hidden = "hidden",
                      get = function () return gcldb.layouts[gcldb.configLayout].nameList[7] end,
                      set = function (_, v)
                         v = v:gsub("([^%s%p])([^%s%p]+)", function (a,b) return a:upper() .. b:lower() end)
                         gcldb.layouts[gcldb.configLayout].nameList[7] = v
                         gcl:checkUpdateCurrent()
                      end,
                  },
                  ["addTarget7"] = {
                     type = "execute",
                     name = L["+Target"],
                     desc = L["Add your target to the name list for group 7."],
                     order = 14,
                     width = "half",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     func = function ()
                        local name = GetUnitName("target")
                        if name and (UnitInParty("target") or UnitInRaid("target")) then
                           if gcldb.layouts[gcldb.configLayout].nameList[7] ~= "" then
                              name = ", " .. name
                           end
                           gcldb.layouts[gcldb.configLayout].nameList[7] =
                              gcldb.layouts[gcldb.configLayout].nameList[7] .. name
                           gcl:checkUpdateCurrent()
                        end
                     end,
                  },
                  ["nameList8"] = {
                      type = "input",
                      name = L["Group 8:"],
                      desc = L["Sets name list for the eighth grid group (comma separated list)."],
                      usage = "",
                      order = 15,
                      width = "double",
                      disabled = InCombatLockdown,
                     hidden = "hidden",
                      get = function () return gcldb.layouts[gcldb.configLayout].nameList[8] end,
                      set = function (_, v)
                         v = v:gsub("([^%s%p])([^%s%p]+)", function (a,b) return a:upper() .. b:lower() end)
                         gcldb.layouts[gcldb.configLayout].nameList[8] = v
                         gcl:checkUpdateCurrent()
                      end,
                  },
                  ["addTarget8"] = {
                     type = "execute",
                     name = L["+Target"],
                     desc = L["Add your target to the name list for group 8."],
                     order = 16,
                     width = "half",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     func = function ()
                        local name = GetUnitName("target")
                        if name and (UnitInParty("target") or UnitInRaid("target")) then
                           if gcldb.layouts[gcldb.configLayout].nameList[8] ~= "" then
                              name = ", " .. name
                           end
                           gcldb.layouts[gcldb.configLayout].nameList[8] =
                              gcldb.layouts[gcldb.configLayout].nameList[8] .. name
                           gcl:checkUpdateCurrent()
                        end
                     end,
                  },
                  ["nameList9"] = {
                      type = "input",
                      name = L["Group 9:"],
                      desc = L["Sets name list for the ninth grid group (comma separated list)."],
                      usage = "",
                      order = 17,
                      width = "double",
                      disabled = InCombatLockdown,
                     hidden = "hidden",
                      get = function () return gcldb.layouts[gcldb.configLayout].nameList[9] end,
                      set = function (_, v)
                         v = v:gsub("([^%s%p])([^%s%p]+)", function (a,b) return a:upper() .. b:lower() end)
                         gcldb.layouts[gcldb.configLayout].nameList[9] = v
                         gcl:checkUpdateCurrent()
                      end,
                  },
                  ["addTarget9"] = {
                     type = "execute",
                     name = L["+Target"],
                     desc = L["Add your target to the name list for group 9."],
                     order = 18,
                     width = "half",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     func = function ()
                        local name = GetUnitName("target")
                        if name and (UnitInParty("target") or UnitInRaid("target")) then
                           if gcldb.layouts[gcldb.configLayout].nameList[9] ~= "" then
                              name = ", " .. name
                           end
                           gcldb.layouts[gcldb.configLayout].nameList[9] =
                              gcldb.layouts[gcldb.configLayout].nameList[9] .. name
                           gcl:checkUpdateCurrent()
                        end
                     end,
                  },
                  ["nameList10"] = {
                      type = "input",
                      name = L["Group 10:"],
                      desc = L["Sets name list for the tenth grid group (comma separated list)."],
                      usage = "",
                      order = 19,
                      width = "double",
                      disabled = InCombatLockdown,
                      hidden = "hidden",
                      get = function () return gcldb.layouts[gcldb.configLayout].nameList[10] end,
                      set = function (_, v)
                         v = v:gsub("([^%s%p])([^%s%p]+)", function (a,b) return a:upper() .. b:lower() end)
                         gcldb.layouts[gcldb.configLayout].nameList[10] = v
                         gcl:checkUpdateCurrent()
                      end,
                  },
                  ["addTarget10"] = {
                     type = "execute",
                     name = L["+Target"],
                     desc = L["Add your target to the name list for group 10."],
                     order = 20,
                     width = "half",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     func = function ()
                        local name = GetUnitName("target")
                        if name and (UnitInParty("target") or UnitInRaid("target")) then
                           if gcldb.layouts[gcldb.configLayout].nameList[10] ~= "" then
                              name = ", " .. name
                           end
                           gcldb.layouts[gcldb.configLayout].nameList[10] =
                              gcldb.layouts[gcldb.configLayout].nameList[10] .. name
                           gcl:checkUpdateCurrent()
                        end
                     end,
                  },
                  ["nameList11"] = {
                      type = "input",
                      name = L["Group 11:"],
                      desc = L["Sets name list for the eleventh grid group (comma separated list)."],
                      usage = "",
                      order = 21,
                      width = "double",
                      disabled = InCombatLockdown,
                     hidden = "hidden",
                      get = function () return gcldb.layouts[gcldb.configLayout].nameList[11] end,
                      set = function (_, v)
                           v = v:gsub("([^%s%p])([^%s%p]+)", function (a,b) return a:upper() .. b:lower() end)
                           gcldb.layouts[gcldb.configLayout].nameList[11] = v
                           gcl:checkUpdateCurrent()
                      end,
                  },
                  ["addTarget11"] = {
                     type = "execute",
                     name = L["+Target"],
                     desc = L["Add your target to the name list for group 11."],
                     order = 22,
                     width = "half",
                     disabled = InCombatLockdown,
                     hidden = "hidden",
                     func = function ()
                        local name = GetUnitName("target")
                        if name and (UnitInParty("target") or UnitInRaid("target")) then
                           if gcldb.layouts[gcldb.configLayout].nameList[11] ~= "" then
                              name = ", " .. name
                           end
                           gcldb.layouts[gcldb.configLayout].nameList[11] =
                              gcldb.layouts[gcldb.configLayout].nameList[11] .. name
                           gcl:checkUpdateCurrent()
                        end
                     end,
                  },
                  ["softSpacer"] = {
         		      type = "description",
                     name = "\n",
                     order = 50,
                     width = "full"
         	      },
                  ["addGroup"] = {
                     type = "execute",
                     name = L["Add a Group"],
                     desc = L["Add a group."],
                     order = 52,
                     disabled = function () return InCombatLockdown() or (gcldb.layouts[gcldb.configLayout].numGroups > 10) end,
                     func = function ()
                        local num = gcldb.layouts[gcldb.configLayout].numGroups + 1
                        gcldb.layouts[gcldb.configLayout].groupType[num] = "none"
                        gcldb.layouts[gcldb.configLayout].nameList[num] = ""
                        gcl:checkUpdateCurrent()
                     end,
                  },
                  ["removeGroup"] = {
                     type = "execute",
                     name = L["Remove a Group"],
                     desc = L["Remove a group."],
                     order = 53,
                     disabled = function () return InCombatLockdown() or (gcldb.layouts[gcldb.configLayout].numGroups < 2) end,
                     func = function ()
                        local num = gcldb.layouts[gcldb.configLayout].numGroups
                        gcldb.layouts[gcldb.configLayout].groupType[num] = "none"
                        gcldb.layouts[gcldb.configLayout].nameList[num] = ""
                        gcldb.layouts[gcldb.configLayout].numGroups = num - 1
                        gcl:checkUpdateCurrent()
                     end,
                  },
               },
            },
         },
      },
      ["globalOptions"] = {
         type = "group",
         name = L["Global Options"],
         desc = L["Set options that apply to all layouts created with this module."],
         order = 31,
         disabled = InCombatLockdown,
         args = {
            ["roleOptions"] = {
               type = "group",
               inline = true,
               name = L["Role Options"],
               order = 10,
               args = {
                  ["useBlizzRole"] = {
                 	   type = "toggle",
                    	name = L["Use blizzard role if inspect is unavailable"],
                    	desc = L["When inspected role is unavailable, use any available blizzard roles"],
                    	width = "full",
                     order = 17,
                    	disabled = InCombatLockdown,
                    	get = function () return gcldb.useBlizzRoles end,
                    	set = function (_, v)
                        gcldb.useBlizzRoles =
                           not gcldb.useBlizzRoles
                        gcl:wipeRoles()
                        gcl:checkUpdateCurrent()
                     end, 
                  },
                  ["blizzRoleRules"] = {
                 	   type = "toggle",
                    	name = L["Blizzard role overrides inspected role"],
                    	desc = L["If Blizzard role is set, override inspected role."],
                    	width = "full",
                     order = 18,
                    	disabled = InCombatLockdown,
                    	get = function () return gcldb.blizzRolesRule end,
                    	set = function (_, v)
                        gcldb.blizzRolesRule =
                           not gcldb.blizzRolesRule
                        gcl:wipeRoles()
                        gcl:checkUpdateCurrent()
                     end, 
                  },
               },
            },
            ["borderColorOptions"] = {
               type = "group",
               inline = true,
               name = L["Border Colors"],
               order = 20,
               args = {
                  ["borderColor"] = {
               		type = "color",
               		name = function() return L["Border Color for "] .. filterLabel(gcldb.filterToColor) end,
               		desc = L["Adjust border color and alpha."],
               		order = 62,
               		disabled = InCombatLockdown,
               		hasAlpha = true,
               		get = function ()
                 			local filter = gcldb.filterToColor
                        local settings = gcldb
                        return settings.filterColors[filter]["r"], settings.filterColors[filter]["g"], settings.filterColors[filter]["b"], settings.filterColors[filter]["a"]
               		end,
               		set = function (_, r, g, b, a)
               			local filter = gcldb.filterToColor
                        local settings = gcldb
               			settings.filterColors[filter]["r"], settings.filterColors[filter]["g"],settings.filterColors[filter]["b"],settings.filterColors[filter]["a"] = r, g, b, a
                        gcl:UpdateSize()
                     end,
                     hasAlpha = true
               	},
                  ["borderFilterSelection"] = {
                     type = "select",
                     name = L["Filter to apply border too:"],
                     desc = L["Choose filter for which to set color."],
                     order = 63,
                     disabled = InCombatLockdown,
                     get = function () return tFind(filters, gcldb.filterToColor) end,
                     set = function (_, v)
                        gcldb.filterToColor = filters[v]
                     end,
                     values = filterLabels,
                  },
               },
            },
            ["frequencyOptions"] = {
               type = "group",
               inline = true,
               name = "Update Frequency",
               order = 30,
               args = {
                  ["checkOOZFrequency"] = {
               	   type = "range",
                		name = L["Zone check frequency"],
                 	   desc = L["Frequency with which to check for raidmember zone changes."],
                     order = 69,
                     disabled = InCombatLockdown,
                     max = 20,
                     min = 0.2,
                     step = 0.1,
                     get = function ()	return gcldb.checkOOZFrequency end,
               	   set = function (_, v)
                  		gcldb.checkOOZFrequency = v
                  	   gcl:checkUpdateCurrent()
               	   end,
                  },
               },
            },
            ["spacer"] = {
         		type = "header",
         		name = "",
         		order = 70,
         		width = "full"
         	},
            ["resetToDefaults"] = {
               type = "execute",
               name = L["Reset all Options"],
               desc = L["Reset all settings and layouts. This will delete any new layouts you have created."],
               order = 72,
               disabled = InCombatLockdown,
               func = function () gcl:resetAllOptions() end,
            },
         },
      },
   }
   
   ---{{{ Sorting Options
   local sortMethods = {
      ["role"] = L["Role"],
      ["class"] = L["Class"],
      ["name"] = L["Name"],
      ["index"] = L["UnitID"],
   }
   local sortTypes = {
      ["class"] = {
         ["druid"] = L["Druid"],
         ["priest"] = L["Priest"],
         ["paladin"] = L["Paladin"],
         ["shaman"] = L["Shaman"],
         ["warrior"] = L["Warrior"],
         ["deathknight"] = L["Deathknight"],
         ["rogue"] = L["Rogue"],
         ["hunter"] = L["Hunter"],
         ["mage"] = L["Mage"],
         ["warlock"] = L["Warlock"],
      },
      ["role"] = {
         ["tank"] = L["Tank"],
         ["healer"] = L["Healer"],
         ["melee"] = L["Melee"],
         ["ranged"] = L["Ranged"],
      },
   }
   local sortOrderList = {}  
   local sortOptions = {
      type = "group",
      name = L["Sorting"],
      desc = L["Select how GCL sorts names within groups."],
      order = 39,
      disabled = InCombatLockdown,
      args = {
         ["layoutHeader"] = {
            type = "description",
            fontSize = "medium",
            name = function () return "[" .. gcldb.configLayout .. "]\n" end, 
            order = 0,
         },
         ["playerFirst"] = {
            type = "toggle",
            name = L["Player First"],
            desc = L["Always show the player as the first member of the group they are in."],
            width = "normal",
            order = 4,
            disabled = InCombatLockdown,
            get = function () return gcldb.layouts[gcldb.configLayout].sortOptions.playerFirst end,
            set = function ()
               gcldb.layouts[gcldb.configLayout].sortOptions.playerFirst =
                  not gcldb.layouts[gcldb.configLayout].sortOptions.playerFirst
               gcl:checkUpdateCurrent()
            end, 
         },
         ["nameListFirst"] = {
            type = "toggle",
            name = function()
                  local place = gcldb.layouts[gcldb.configLayout].sortOptions.playerFirst and L["Second"] or L["First"]
                  return L["Namelist"] .. " " .. place
               end, 
            desc = L["Don not sort the namelist, put it ahead of the rest of the group."],
            width = "normal",
            disabled = InCombatLockdown,  
            order = 6,
            get = function () return gcldb.layouts[gcldb.configLayout].nameListFirst end,
            set = function ()
               gcldb.layouts[gcldb.configLayout].nameListFirst =
                  not gcldb.layouts[gcldb.configLayout].nameListFirst
               gcl:checkUpdateCurrent()
            end, 
         },
         ["newLine"] = {
            type = "description",
            name = "",
            width = "full",
            order = 8,
         },
         ["sortMethod"] = {
            type = "select",
            name = L["Order Players By:"],
            desc = L["Select which method should be used to order units within each group."],
            width = "normal",
            order = 10,
            get = function () return gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod end,
        	   set = function (_, v)
               gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod = v
               sortOrderList = {}
               gcl:checkUpdateCurrent()
            end,
        	   values = sortMethods,
         },
         ["sortOrderIntro"] = {
            type = "description",
            fontSize = "medium",
            hidden = function ()
               local method = gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               return (method ~= "class") and (method ~= "role")
            end,
            name = function ()
               local methodT = sortMethods[gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod]
               return "\n" .. L["Current"] .. " " .. methodT .. " " .. L["Order:"]
            end,
            width = "full",
            order = 20,
         },
         ["sortOrder"] = {
            type = "description",
            order = 22,
            width = "full",
            hidden = function ()
               local method = gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               return (method ~= "class") and (method ~= "role")
            end,  
            name = function ()
               local orderT, method = "", gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               if (method == "class" or method == "role") then 
                  local order = gcldb.layouts[gcldb.configLayout].sortOptions.sortOrder[method] 
                  debug("First element in existing order is " .. (next(order) or "nil"))
                  if not next(order) then
                     defOrder = defaultLayout.sortOptions.sortOrder  
                     for k, v in pairs(defOrder) do
                        order[k] = v
                     end
                  end 
                  for i = 1, tCount(order) do
                     orderT =  orderT .. (sortTypes[method][tFind(order, i)] or "nil") .. ", "
                  end
               end   
               debug("Order string is : \"" .. orderT .. "\"")
               return string.gsub(orderT, ", $", "") .. "\n"
            end,
         },
         ["bSortOrderIntro"] = {
            type = "description",
            fontSize = "medium",
            hidden = function ()
               local method = gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               return (method ~= "class") and (method ~= "role")
            end,
            name = function ()
               local methodT = sortMethods[gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod]
               return "\n" .. L["New"] .. " " .. methodT .. " " .. L["Order:"]
            end,
            width = "full",
            order = 24,
         },
         ["buildSortOrder"] = {
            type = "input",
            name = "",
            order = 26,
            width = "full", 
            disabled = true,
            hidden = function ()
               local method = gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               return (method ~= "role") and (method ~= "class")
            end,  
            get = function ()
               local text, method = "", gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               if (method == "class" or method == "role") then
                  for _, sType in ipairs(sortOrderList) do
                     text = text .. sortTypes[method][sType] .. ", " 
                  end
               end
               return string.gsub(text, ", $", "") 
            end,
            set = function (_, v)
               sortOrderList = {}
            end,
         },
         ["buildSortOrderButtons"] = {
            type = "multiselect",
            name = "",
            order = 28,
            width = "half",
            hidden = function ()
               local method = gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               return (method ~= "role") and (method ~= "class")
            end,
            get = function (_, key)
               return tContains(sortOrderList, key)
            end,
            set = function (_, key, state)
               local method = gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               local i = tFind(sortOrderList, key)
               if (state and (not i)) then
                  tinsert(sortOrderList, key)
               elseif (not state and i) then
                  tremove(sortOrderList, i)
               end
            end,
            values = function ()
               local method = gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               if (method == "role" or method == "class") then
                  return sortTypes[method]
               else
                  return {}
               end
            end, 
         },
         ["buildSortOrderCommit"] = {
            type = "execute",
            name = "Save List",
            order = 30,
            hidden = function ()
               local method = gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               return (method ~= "role") and (method ~= "class")
            end,
            disabled = function ()
               local method = gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               return (not next(sortOrderList))
            end,
            func = function ()
               local uiorder = sortOrderList or {}
               local method = gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               if (#uiorder > 0) and ((method == "role") or (method == "class")) then                        
                  local order = {}
                  for i, v in ipairs(uiorder) do
                     debug("sort key is " .. v)
                     order[v] = i
                  end
                  gcldb.layouts[gcldb.configLayout].sortOptions.sortOrder[method] = order                           
                  sortOrderList = {}
                  return true
               else
                  return L["You must include at least one"] .. " " .. sortMethods[method] .. " " .. L["in the sort order."]
               end
            end,
         },
         ["buildSortOrderIntro"] = {
            type = "description",
            fontSize = "small",
            hidden = function ()
               local method = gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod
               return (method ~= "role") and (method ~= "class")
            end,
            name = function ()
               local methodT = sortMethods[gcldb.layouts[gcldb.configLayout].sortOptions.sortMethod] 
               local instructions = L["Use the checkboxes above to add each %s in the order you wish it to appear in the groups.  If you do not incled a %s, remaining units will be sorted by name, e.g. if you select %s, %s, all damagers will appear alphabetically after the %s and %s."]  
               return string.format(instructions, methodT, methodT, L["Tanks"], L["Healers"], L["Tanks"], L["Healers"]) 
            end,
            width = "full",
            order = 34,
         },

      },
   }
   options["layoutOptions"]["args"]["sortOptions"] = sortOptions
   ---}}}
   
   gcl.options = {
      type = "group",
      childGroups = "tree",
      name = L["GCLayouts"],
      desc = L["Options for GridConfigurableLayouts"],
      order = -1,
      args = options,
   }
end
---}}}


---{{{ Initialization, reset, etc., . . .
function gcl:OnInitialize()
   -- Makes sure our saved variables, if any, are loaded. Sets some defaults
   -- if needed.
   --
   -- The way Grid handles modules (as opposed to GridStatus, e.g.), it doesn't
   -- always register us (this is problem with the order in which addons are
   -- loaded and the timing of initialization).
   if not self.db then
      Grid:RegisterModule("GridConfigurableLayouts", gcl)
   end
   
   GridConfigurableLayoutsDB = getDB()
   gcl.gcldb = GridConfigurableLayoutsDB -- so we can get to it from other files
   gcldb = GridConfigurableLayoutsDB -- our local reference
   
   -- in case the user edits the savedvariables file and deletes the configLayout ... 
   if (not gcldb.layouts[gcldb.configLayout]) then
      gcldb.configLayout = "GCL Default"
   end

   self.debugFrame = GridLayout.debugFrame
	self.debugging = self.db.profile.debug
end


function gcl:OnEnable()
   -- Usually only called when addons are first loaded.  Fills some variables
   -- with saved data from the db.
   self:loadNewConfig(gcldb.configLayout)
   for layoutName, _ in pairs(gcldb.layouts) do
      layoutNames[layoutName] = layoutName
   end
   self:addLayouts()
   self:Hook(GridLayout, "ReloadLayout")
   -- To correct the anchor point bug, we are going to hook GridFrame's InitializeFrame
   -- (see the explanation in the comments for the hook function)
   -- It will be important to remove this when the Grid bug is fixed
   if GRID_IS_OLD then -- **Tagged for removal when Grid anchorpoint bug fixed
      self:Hook(GridFrame, "InitializeFrame") 
   end
   GridLayout:ReloadLayout()
end


function gcl:OnDisable()
   -- A little cleanup if the addon is disabled
    -- we can't unhook in the next line because we now are responsible for the anchorpoint bug
   if not GRID_IS_OLD then -- **Tagged for un-if when Grid anchorpoint bug fixed
      self:Unhook(GridLayout, "ReloadLayout") 
   end
   self:doUnregister()
   self:setCreateBorders(false)
end


function gcl:Reset()
   GridLayout:ReloadLayout()
end
---}}}


---{{{ Registrations and Callback functions
function gcl:doRegister()
   -- Called by IsaActive() when the layout is set to one that is ours
   self:RegisterMessage("Grid_EnteringCombat", "setCombatLockdown")
   self:RegisterMessage("Grid_LeavingCombat", "removeCombatLockdown")
   self:RegisterMessage("Grid_RosterUpdated", "RedoGroups")
   self:RegisterRoleEvents()
   if not combatLockdown and self:checkUsingOOZ() then
      self.oozTimer = self:ScheduleRepeatingTimer(gcl.OOZCheck, gcldb.checkOOZFrequency )
   end                                        
   isRegistered = true
end

         
function gcl:doUnregister()
   -- Called by IsActive() when the current layout changes to one that is not
   -- ours.  Also called if the addon is disabled.
   self:UnregisterMessage("Grid_EnteringCombat")
   self:UnregisterMessage("Grid_LeavingCombat")
   self:UnregisterMessage("Grid_RosterUpdated")
   self:UnregisterRoleEvents()
   self:CancelTimer(self.oozTimer, true)
   isRegistered = false
end


function gcl:setCombatLockdown()
   -- Sets the combout lockdown flag.  All updates will be queued until
   -- combat ends.
   combatLockdown = true
   gcl:CancelTimer(self.oozTimer, true)
end


function gcl:removeCombatLockdown()
   -- Puts this module back in action after combat ends, initiates updates
   -- that were postponed due to combat  
   combatLockdown = false
   if gcl:isActive() and gcl:checkUsingOOZ() then
      gcl:ScheduleRepeatingTimer("OOZCheck", gcldb.checkOOZFrequency )
   end
   if redoGroupsQueued then
      gcl:RedoGroups()
   end
end    
   
    
function gcl:ReloadLayout()
   -- Hook on the GridLayout method (set in OnEnable)
   if not combatLockdown then -- we don't need to reschedule : GridLayout will call again
      if GRID_IS_OLD then -- **Tagged for removal when Grid anchorpoint bug fixed
         gcl:clearHeaderPoints() 
      end
      if gcl:isActive() then
         if redoScheduled then
            gcl:CancelTimer(redoScheduled, true)
            redoScheduled = nil
         end
         gcl:updateLayout()
      end                                           
	end
end


function gcl:InitializeFrame(callerobj, frame) -- **Tagged for removal when Grid anchorpoint bug fixed
   -- To correct the anchor point bug, we are going to jump in ahead of
   -- GridFrame's hook on Setpoint to set GridFrame.clearedPoints, preventing
   -- GridFrame's hook from clearing anchor points on the frame . . . which is
   -- a dodgy thing to do, but the bug is killing us at the moment.  We then
   -- correct the anchor point bug in a better way by clearing points only when
   -- a layout is going to be loaded (see the hook on ReloadLayout above).
	hooksecurefunc(frame, "SetPoint", function(self, ...) self.clearedPoints = true end) 
end

function gcl:RedoGroups()
   -- Our own function, similar to ReloadLayout, but only rebuilds groups
   -- without recreating the layout
   if combatLockdown then
      redoGroupsQueued = true
   else
      if gcl:isActive() then
         redoGroupsQueued = false
         if (not redoScheduled or gcl:TimeLeft(redoScheduled) <= 0) then
            redoScheduled = gcl:ScheduleTimer("redoGroups", 0.11) 
         end
      end                                           
	end
end


function gcl:UpdateSize()
   -- Hook on the GridLayout method, used to place group borders whenever
   -- GridLayout refreshes it's own outer border (hook set by setCreateBorders)
   if gcl:isActive() and gcldb.layouts[GridLayout.db.profile.layouts[GridRoster:GetPartyState()]].createBorders then
      gcl:makeBorders()
	end
end   


function gcl:PlaceGroup(context, layoutGroup, groupNumber)
   -- Hook on the GridLayout method, used when we need to adjust group placement
   -- to make room for group borders (hook set by setCreateBorders)
   if gcl:isActive() and gcldb.layouts[GridLayout.db.profile.layouts[GridRoster:GetPartyState()]].createBorders then
      gcl:adjustGroup(layoutGroup, groupNumber)
	end
end   


function gcl:OOZCheck()
   -- Periodically checks if any raid member has changed zones
   local currentLayout = gcldb.layouts[GridLayout.db.profile.layouts[GridRoster:GetPartyState()]]
   if not currentLayout then return end
   local pstate = GridRoster:GetPartyState()
   if not combatLockdown and pstate ~= "solo" and pstate ~= "party"  then
      if gcl:isActive() then
         for guid, unit in GridRoster:IterateRoster() do
            if (string.sub(unit, 1, 7) ~= "raidpet") then
               local zone = GetRealZoneText()
               if (string.sub(unit, 1, 4) == "raid") then
                  local raidIndex = string.sub(unit, 5)
                  local _, _, _, _, _, _, temp_zone = GetRaidRosterInfo(raidIndex)
                  zone = temp_zone or zone
      	         if rosterZoneList[guid] ~= zone and (zone ~= "Offline" or currentLayout.offlineIsOOZ) then
                     gcl:RedoGroups()
                     return
                  end
               end
            end
         end
      end
   end
end   
---}}}


---{{{ Core functions
function gcl:createLayout(name)
   -- Occurs when "Create New Layout" button is pressed, creates a copy of
   -- GCL_Default with a new name
   if name and name ~= "" and GridLayout.layoutSettings[name] == nil then
      GridLayout:AddLayout(name, emptyLayout)
      gcldb.layouts[name] = defaultLayout
      layoutNames[name] = name
      self:loadNewConfig(name)
      self.newLayoutName = ""
      self:checkUpdateCurrent()
   end
end


function gcl:removeLayout(name)
   -- Occurs when "Remove Layout" button is pressed
   if gcldb.layouts[name] and name ~= "GCL Default" then
      GridLayout.layoutSettings[name] = nil
    	for _, party_type in ipairs(GridRoster.party_states) do
    		for _, layoutName in pairs(GridLayout.options.args[party_type .. "layout"].values) do
    		   if name == layoutName then
               GridLayout.options.args[party_type .. "layout"].values[layoutName] = nil
            end
    		end
    	end
      gcldb.layouts[name] = nil
      layoutNames[name] = nil
      if gcldb.configLayout == name then
         self:loadNewConfig("GCL Default")
      end
      self.newLayoutName = ""
      self:checkUpdateCurrent()
   end
end   
   

function gcl:setCreateBorders(doCreate)
   -- Called when creation of group borders is enabled or disabled
   if doCreate then
      if not self:IsHooked(GridLayout, "UpdateSize") then
         self:SecureHook(GridLayout, "UpdateSize")
      end
      if not self:IsHooked(GridLayout, "PlaceGroup") then
         self:SecureHook(GridLayout, "PlaceGroup")
      end
      GridLayout.frame:DisableDrawLayer("BORDER")
      GridLayout.frame:DisableDrawLayer("BACKGROUND")
   else
      if not self:IsHooked(GridLayout, "PlaceGroup") then
         self:SecureHook(GridLayout, "PlaceGroup")
      end
      if self:IsHooked(GridLayout, "UpdateSize") then
         self:Unhook(GridLayout, "UpdateSize")
      end
      for _, f in pairs(outerFrames) do
         f:Hide()
      end
      for _, f in pairs(outerPetFrames) do
         f:Hide()
      end
      GridLayout.frame:EnableDrawLayer("BORDER")
      GridLayout.frame:EnableDrawLayer("BACKGROUND")
   end
end


function gcl:resetAllOptions()
   --Returns the whole module to factory settings
   for layoutName, _ in pairs(gcldb.layouts) do
      self:removeLayout(layoutName)
   end
   self:doUnregister()
   self.db:ResetProfile()
   layoutNames = {}
   for layoutName, _ in pairs(gcldb.layouts) do
      layoutNames[layoutName] = layoutName
   end
   self:loadNewConfig("GCL Default")
   self:addLayouts()
   GridLayout:ReloadLayout()
end


function gcl:redoGroups()
   -- The core function of this module: processes the roster and builds the
   -- groups, which it feeds to GridLayout
   if redoScheduled then
      gcl:CancelTimer(redoScheduled, true)
      redoScheduled = nil
   end
   local currentLayout = gcldb.layouts[GridLayout.db.profile.layouts[GridRoster:GetPartyState()]]
   if not currentLayout then return end
   local groupList = {{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {} }
   local nameLists = {}
   local oozList = {}
   local usingooz = self:checkUsingOOZ()
   local revisedNameList = {}
   local nameListed = {}
   local playerGroup
   
   
   -- make a clean copy of namelists with no bogus names
   -- (because names that are not in raid can block legit names from appearing)
   for i = 1, currentLayout.numGroups do
      local nlT = string.gsub(currentLayout.nameList[i], ",", " ")
      local tempnl = {}
      for name in gmatch(nlT, "([^%s%p]+)") do
         local guid = GridRoster:GetGUIDByFullName(name)
         if (guid and not nameListed[name]) then
            local unit = GridRoster:GetUnitidByGUID(guid)
            local role = self:GetRole(guid, unit)
            local index = UnitIndex(unit)
            local class =  UnitClass(unit)
            class = string.lower(class)
            nameListed[name] = true
            tinsert(tempnl, {name = name, class = class, role = role, index = index})
            debug("namelist " .. tostring(i) .. ":  ", name, class, role, index)
         end
      end
      revisedNameList[i] = tempnl
   end
   -- iterate thru the roster and place units in groups
   debug("*** Iterating Roster ***")
   for guid, unit in GridRoster:IterateRoster() do
      if (not string.find(unit, "pet")) and ((not nameListed[name]) or currentLayout.allowRepeats) then 
        local name, raidgroup, isMT, zone, index = self:getUnitInfo(unit, guid)
        local role = self:GetRole(guid, unit)
        local _, class = UnitClass(unit)
        class = class and string.lower(class) or "" -- on initial load we sometimes get nil
        debug("Are we getting the class?  " .. class)
        debug("Unit " .. unit .. ":  ", name, class, role, index)
        -- first check if this unit belongs in an ooz group
        if usingooz then 
           if zone ~= "Offline" then
              rosterZoneList[guid] = zone
           elseif not currentLayout.offlineIsOOZ then
              zone =  rosterZoneList[guid]
           end
           if zone ~= GetRealZoneText() and (currentLayout.allowRepeats or not nameListed[name]) then
              tinsert(oozList, {name = name, class = class, role = role, index = index})
              nameListed[name] = true
              debug("--Added " .. unit .. " to OOZ list.")
           end
        end
        -- then fill the groups in order
        for i = 1, currentLayout.numGroups do
           if currentLayout.allowRepeats or not nameListed[name] then
             if (currentLayout.groupType[i] == "everyone") or 
                   (role == currentLayout.groupType[i]) or
                   ((currentLayout.groupType[i] == "damage") and (role == "ranged" or role == "melee")) or
                   ((currentLayout.groupType[i] == "blizztank") and isMT) or
                   (currentLayout.groupType[i] == raidgroup) or
                   ((currentLayout.groupType[i] == "guild") and UnitIsInMyGuild(unit))
                   then
                if (currentLayout.sortOptions.playerFirst and UnitIsUnit(unit, "player")) then
                   playerGroup = i -- it will be inserted later
                else
                   tinsert(groupList[i], {name = name, class = class, role = role, index = index})
                   debug("--Added " .. unit .. " to Group " .. tostring(i))
                end
                nameListed[name] = true
             end
           end
        end
      end
   end
   -- if there is an ooz group, fill it
   if usingooz then
      for i = 1, currentLayout.numGroups, 1 do
         if currentLayout.groupType[i] == "ooz" then
            tInsertT(groupList[i], oozList)
         end
      end
   end
   -- add namelists to the groups (if they are supposed to be sorted)
   if (not currentLayout.sortOptions.nameListFirst) then
      for i = 1, currentLayout.numGroups do
         if revisedNameList[i] ~= {} then
            tInsertT(groupList[i], revisedNameList[i])
         end
      end
   end
   -- sort the groups
   for i = 1, currentLayout.numGroups do
      if (#groupList[i] > 0) then
         groupSort(groupList[i], currentLayout.sortOptions.sortMethod)
      end
   end
   -- Add the namelists now if they are not to be sorted
   if currentLayout.sortOptions.nameListFirst then
      for i = 1, currentLayout.numGroups do
         if revisedNameList[i] ~= {} then
            tInsertT(groupList[i], 1, revisedNameList[i])
         end
      end
   end
   -- If the player is to be first in her group, add her now
   if currentLayout.sortOptions.playerFirst and playerGroup then
      tinsert(groupList[playerGroup], 1, {name = UnitName("player")})
   end
   -- create the namelist strings
   debug("*** Creating nameList strings ***")
   for i = 1, currentLayout.numGroups do
      nameLists[i] = ""
      for _, entry in ipairs(groupList[i]) do
         nameLists[i] = nameLists[i] .. "," .. entry.name
      end
      debug("Group " .. tostring(i) .. " : " .. nameLists[i])
   end
   -- update the nameLists in the actual GridLayout headers
   do
      local oldNL, changed
      local i = 1
      for j = 1, currentLayout.numGroups do
         if currentLayout.groupType[j] ~= "pets" then
            local header = GridLayout.layoutGroups[i]
            if header then
               oldNL = header:GetAttribute("nameList") or ""
               if oldNL ~= nameLists[j] then
                  debug("Existing NL:  " .. oldNL)
                  debug("New NL:  " .. nameLists[j])
                  header:SetAttribute("nameList", nameLists[j])
                  changed = true
               end
               i = i + 1
            end   
         end
      end
      if changed then
         GridLayout:UpdateSize()
      end   
   end
end
   
function gcl:updateLayout()
   -- Rebuilds the current layout and inserts it into GridLayout
   local partyState = GridRoster:GetPartyState() 
   local layoutName = GridLayout.db.profile.layouts[partyState]
   local currentLayout = gcldb.layouts[layoutName]
   if not currentLayout then return end
   
   -- If options frame is not currently open, set the config layout to the new layout
   local dialog = LibStub("AceConfigDialog-3.0")
	if (not dialog.OpenFrames["Grid"]) then
	   gcldb.configLayout = layoutName
	end
   
   local unitsPerColumn = currentLayout.unitsPerColumn
   local maxColumns = math.ceil(getMaxUnits(partyState) / unitsPerColumn) 
   local petGroupFilter = ""
   
   -- create groupFilter for pet group
   if not currentLayout.petOptions["allPets"] then
      for class, enabled in pairs(currentLayout.petOptions) do
         if class ~= "allPets" and enabled == true then
            petGroupFilter = petGroupFilter .. "," .. class
         end
      end
   end
   
   -- pass the updated layout to GridLayout
   local realIndex = 1
   for i = 1, 11, 1 do
      GridLayout.layoutSettings[layoutName][i] = nil
   end
   for i = 1, currentLayout.numGroups, 1 do
      if currentLayout.groupType[i] ~= "none" then
         GridLayout.layoutSettings[layoutName][realIndex] = {}
         GridLayout.layoutSettings[layoutName][realIndex]["unitsPerColumn"] = unitsPerColumn
         GridLayout.layoutSettings[layoutName][realIndex]["maxColumns"] = maxColumns
         if currentLayout.groupType[i] == "pets" then
            GridLayout.layoutSettings[layoutName][realIndex]["isPetGroup"] = true
            GridLayout.layoutSettings[layoutName][realIndex]["groupFilter"] = "1,2,3,4,5,6,7,8"
            GridLayout.layoutSettings[layoutName][realIndex]["nameList"] = ""
            if not currentLayout.petOptions["allPets"] then
               GridLayout.layoutSettings[layoutName][realIndex]["groupFilter"] = petGroupFilter
            end
         else
            GridLayout.layoutSettings[layoutName][realIndex]["isPetGroup"] = false
            GridLayout.layoutSettings[layoutName][realIndex]["groupFilter"] = nil
            GridLayout.layoutSettings[layoutName][realIndex]["sortMethod"] = "NAMELIST"
            GridLayout.layoutSettings[layoutName][realIndex]["nameList"] = ""
         end
         realIndex = realIndex + 1
      end
   end
   -- schedule update of namelists
   self:RedoGroups()
end


function gcl:makeBorders()
   -- Implements group borders around existing groups
   local groupCount = 1
   local groupColors, petGroupColors, totalGroups = self:getGroupColors()
   local borderTexture = media:Fetch(media.MediaType.BORDER, GridLayout.db.profile.borderTexture)
   
   for _, f in pairs(outerFrames) do
      f:Hide()
   end
   
   for _, f in pairs(outerPetFrames) do
      f:Hide()
   end
   
   for i, layoutGroup in ipairs(GridLayout.layoutGroups) do
		if layoutGroup:IsVisible() and hasVisibleUnitFrame(layoutGroup) then
         local f = outerFrames[i] or CreateFrame("Frame", "GCLOuterFrame" .. i, GridLayout.frame)
         local x, y = layoutGroup:GetLeft() - GridLayout.frame:GetLeft(), layoutGroup:GetTop() - GridLayout.frame:GetTop()
         local width, height = layoutGroup:GetWidth(), layoutGroup:GetHeight()
         x = x - 5
         y = y + 5
         width = width + 10
         height = height + 10
         f:SetWidth( width)
         f:SetHeight( height)
         f:SetPoint("TOPLEFT", x, y)
         f:SetBackdrop({
				bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
				edgeFile = borderTexture, edgeSize = 16,
				insets = {left = 4, right = 4, top = 4, bottom = 4},
			})
         local color = groupColors[i]
         f:SetBackdropBorderColor(color.r, color.g, color.b, color.a)
			f:SetBackdropColor(0, 0, 0, 0)
			f:Show()
			outerFrames[i] = f
		end
	end
   for i, layoutGroup in ipairs(GridLayout.layoutPetGroups) do
		if layoutGroup:IsVisible() and hasVisibleUnitFrame(layoutGroup) then
         local f = outerPetFrames[i] or CreateFrame("Frame", "GCLOuterPetFrame" .. i, GridLayout.frame)
         local x, y = layoutGroup:GetLeft() - GridLayout.frame:GetLeft(), layoutGroup:GetTop() - GridLayout.frame:GetTop()
         local width, height = layoutGroup:GetWidth(), layoutGroup:GetHeight()
         x = x - 5
         y = y + 5
         width = width + 10
         height = height + 10
         f:SetWidth( width)
         f:SetHeight( height)
         f:SetPoint("TOPLEFT", x, y)
         f:SetBackdrop({
				bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
				edgeFile = borderTexture, edgeSize = 16,
				insets = {left = 4, right = 4, top = 4, bottom = 4},
			})
         local color = petGroupColors[i]
         f:SetBackdropBorderColor(color.r, color.g, color.b, color.a)
			f:SetBackdropColor(0, 0, 0, 0)
			f:Show()
			outerPetFrames[i] = f
		end
	end
end


function gcl:adjustGroup(layoutGroup, groupNumber)
   -- For when group borders are active: Adjusts the placement of the group frames
   -- created by GridLayout to make room for our group borders
   local f = layoutGroup
   local GLSettings = GridLayout.db.profile
   local horizontal = GLSettings.horizontal
   local groupAnchor = GLSettings.groupAnchor
   
   local adjustX, adjustY = 0, 0
   
   if horizontal then
      adjustX = 0
      if groupAnchor == "TOPLEFT" or groupAnchor == "TOPRIGHT" then
         adjustY = -10
      else
         adjustY = 10 
      end
   else
      adjustY = 0
      if groupAnchor == "TOPLEFT" or groupAnchor == "BOTTOMLEFT" then
         adjustX = 10
      else
         adjustX = -10
      end
   end
          
   local p, rT, rP, x, y = f:GetPoint(1)
   f:SetPoint(p, rT, rP, x + adjustX, y + adjustY) 
end
---}}}


---{{{ other functions
function gcl:isActive()
   -- Checks if the active layout is one of ours, and if so, makes sure we are
   -- registered to react to everything we need to track
   local currentLayout = gcldb.layouts[GridLayout.db.profile.layouts[GridRoster:GetPartyState()]]
   self:setCreateBorders(currentLayout and currentLayout.createBorders)
   if currentLayout and not isRegistered then
      self:doRegister()
   elseif not currentLayout and isRegistered then
      self:doUnregister()
   end
   return (not (not currentLayout))
end


function gcl:checkUpdateCurrent()
   -- When a layout is modified in options, check if the config layout is the
   -- currently active layout and, if so, reload it with the modified settings
   local party_type = GridRoster:GetPartyState()
   if GridLayout.db.profile.layouts[party_type] == gcldb.configLayout then
      self:CancelTimer(self.oozTimer, true)
      if not combatLockdown and self:checkUsingOOZ() then
         self.oozTimer = self:ScheduleRepeatingTimer(gcl.OOZCheck, gcldb.checkOOZFrequency )                                                                                                                                                                       
      end
      GridLayout:ReloadLayout()
   end
end            


function gcl:getUnitInfo(unit, guid)
   -- Returns unit info used by redoGroups
   local raidIndex, name = UnitIndex(unit), GridRoster:GetFullNameByGUID(guid) 
   local raidgroup, isMT = "rg1", false
   local zone = GetRealZoneText() -- note: we can't get zone info for party members
   if UnitInRaid(unit) then
      local temp_zone, blizzRole
      _, _, raidgroup, _, _, _, temp_zone, _, _, blizzRole = GetRaidRosterInfo(raidIndex)
      zone = temp_zone or zone -- this deals with a Blizz bug where reloading ui causes GetRaidRosterInfo to return empty zone info for player
      isMT = (blizzRole == "MAINTANK")
      raidgroup = "rg" .. raidgroup
   end
   return name, raidgroup, isMT, zone, raidIndex
end


function gcl:checkUsingOOZ()
   -- Checks if there is an "Out of zone" group in the current layout
   local currentLayout = gcldb.layouts[GridLayout.db.profile.layouts[GridRoster:GetPartyState()]]
   if not currentLayout then return end
   for _, groupType in ipairs(currentLayout.groupType) do
      if groupType == "ooz" then
         return true
      end
   end
   return false
end


function gcl:getGroupColors()
   -- Used by MakeBorders, this creates tables of group colors that match
   -- the group borders and pet group borders in order of their creation 
   local settings = gcldb
   local currentLayout = gcldb.layouts[GridLayout.db.profile.layouts[GridRoster:GetPartyState()]]
   if not currentLayout then return end -- This would be bad
   local i, j, k = 0, 0, 0
   local groupColors = {}
   local petGroupColors = {}
   for _, groupType in pairs(currentLayout.groupType) do
      if groupType == "pets" then
         j = j + 1
         k = k + 1
         local gc = settings.filterColors["pets"] 
         petGroupColors[j] =  {r = gc.r, g = gc.g, b = gc.b, a = gc.a}
         petGroupColors[j]["realIndex"] = k
      elseif groupType == "none" then
         break
      else
         i = i + 1
         k = k + 1
         local gc = settings.filterColors[groupType] 
         groupColors[i] =  {r = gc.r, g = gc.g, b = gc.b, a = gc.a}
         groupColors[i]["realIndex"] = k
      end
   end
   return groupColors, petGroupColors, i + j
end


function gcl:addLayouts()
   -- Adds placeholders for all our layouts, so that they are visible to GridLayout
   for _, name in pairs(layoutNames) do
      if GridLayout.layoutSettings[name] == nil then
         GridLayout:AddLayout(name, emptyLayout)
      end
   end
end


function gcl:loadNewConfig(layoutName)
   -- When we choose a new layout to configure, we have a few things to do
   gcldb.configLayout = layoutName
   if not gcldb.layouts[layoutName].numGroups then
      for i = 11, 1, -1 do
         if gcldb.layouts[layoutName].groupType[i] ~= "none" then
            gcldb.layouts[layoutName].numGroups = i
            break
         end
      end
   end
end

function gcl:clearHeaderPoints() -- **Tagged for removal when Grid anchorpoint bug fixed
   debug("clearHeaderPoints") 
   local headers = GridLayout.layoutGroups 
   for _, header in ipairs(headers) do
      local count = 1
   	local uframe = header:GetAttribute("child" .. count) 
      while uframe do
         -- debug("   Clearing points for " .. uframe:GetName())
   		uframe:ClearAllPoints()
   		count = count + 1
   		uframe = header:GetAttribute("child" .. count)
   	end
   end
   headers = GridLayout.layoutPetGroups 
   for _, header in ipairs(headers) do
      local count = 1
   	local uframe = header:GetAttribute("child" .. count) 
      while uframe do
         -- debug("   Clearing points for " .. uframe:GetName())
   		uframe:ClearAllPoints()
   		count = count + 1
   		uframe = header:GetAttribute("child" .. count)
   	end
   end
end
---}}}