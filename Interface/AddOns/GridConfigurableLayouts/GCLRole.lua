-- Project: GridConfigurableLayouts 0.4.3b
-- File: GCLRole.lua
-- Last Modified: 2011-05-03T18:29:01Z
-- Author: msaint
-- Project desc: Allows in-game creation of highly customized layouts in Grid
-- File desc: Determines unit roles for use in group filters and sorting 

local FILE_VERSION = tonumber("74") or 5000

--{{{ Get or Create the module
local gcl = Grid:GetModule("GridConfigurableLayouts", true) or Grid:NewModule("GridConfigurableLayouts", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0")
gcl.Versions = gcl.Versions or {} 
if (gcl.Versions.Role and gcl.Versions.Role >= FILE_VERSION) then return end
gcl.Versions.Role = FILE_VERSION
---}}}


--{{{ Libraries and modules
local talentLib = LibStub:GetLibrary("LibGroupTalents-1.0")
local GridRoster = Grid:GetModule("GridRoster")
--}}}


--{{{ Hack the localization function for easy implementation later
gcl.L = gcl.L or {} 
local L = gcl.L 
setmetatable(L,{ __index = function(l, text) return text end})
---}}}


---{{{ Make everthing local that we can
   --Lua library:
local  table, string, tostring = table, string, tostring 
local wipe = wipe -- not standard lua 
   --WoW api:
local UnitClass, UnitGroupRolesAssigned = UnitClass, UnitGroupRolesAssigned
---}}}


--{{{ make debug function local for convenience
local function debug(...)
   gcl:Debug("[GCL-Role]", ...)
end
--}}}


---{{{ local variables and tables
local _
local Role = {}
local guidsToUpdate = {}
local fixedRole = {
   ROGUE = "melee",
   HUNTER = "ranged",
   MAGE = "ranged",
   WARLOCK = "ranged",
}
local isBlizzDamageTypeAmbig = {
   SHAMAN = true,
   DRUID = true,
}
local defaultDamageRole = {
   WARRIOR = "melee",
   DEATHKNIGHT = "melee",
   PALADIN = "melee",
}
setmetatable(defaultDamageRole,{ __index = function(l, class) return fixedRole[class] or "ranged" end})
-- I only include fixedRole in meta table return for completeness: as written
-- this will never be used because fixedRole checking always precedes
-- defaultDamageRole use in this module
---}}}


---{{{ local functions
local function getTalentRole(guid, unit, class, forceRefresh)
   -- Returns the talent spec based role for a guid by calling LGT
   local role = talentLib:GetGUIDRole(guid, forceRefresh)
   role = role and role:gsub("caster", "ranged") -- the caller must deal with the strange treatment of hunters (preferably by using fixedRole[class] to override)
   debug("Talentlib role for", unit, "is", role) 
   return role or nil
end


local function getBlizzRole(unit, class)
   -- Returns a role based on what role was assigned in the Bliz UI, but only
   -- if the role is unambiguous, otherwise nil.  I.e. if Bliz reports 'damager'
   -- for a class that can be both ranged and melee, it returns nil.
   local role = UnitGroupRolesAssigned(unit)
   role = role and role:lower()
   role = (role ~= "none"  and role ~= "damager" and role) or (role == "damager" and not isBlizzDamageTypeAmbig[class] and defaultDamageRole[class]) or nil
   debug("Blizzrole for", unit, "is", role)
   return role
end
---}}}


---{{{ methods
function gcl:GetRole(guid, unit, class, forceRefresh)   -- only first is mandatory
   -- Returns a role for the guid.  Depending on options, it tries Bliz or
   -- talent based roles first, uses the other to disambiguate, and guesses
   -- if neither method can determine the role.
   unit = unit or GridRoster:GetUnitidByGUID(guid)
   if not class then
      _, class = UnitClass(unit)
   else
      class = string.upper(class)
   end
   local useBlizz = gcl.gcldb.useBlizzRoles
   local blizzRules = gcl.gcldb.blizzRolesRule
   local role = Role[guid]
   debug("GetRole is processing", unit, "with existing role", role)
   if not role or forceRefresh then
      role = useBlizz and getBlizzRole(unit, class)
      role = fixedRole[class] or (blizzRules and role) or getTalentRole(guid, unit, class, forceRefresh) or role or defaultDamageRole[class]
      Role[guid] = role
      debug("GetRole has set", unit, "to", role)
   end
   return role
end


function gcl:wipeRoles()
   -- Wipes the role roster if there is one.
   Role = Role and wipe(Role)
end


function gcl:updateRoles()
   -- Processes any guids that have changed Bliz role.  This is a timer
   -- callback, because there is, unfortunately, a delay between when the
   -- ROLE_CHANGED_INFORM event fires, and when the new role can be successfuly
   -- queried. 
   if guidsToUpdate then
      local updateneeded
      for i = table.getn(guidsToUpdate), 1, -1 do
         local guid = guidsToUpdate[i]
         table.remove(guidsToUpdate, i)
         local oldrole, newrole = Role[guid], gcl:GetRole(guid, nil, nil, true)   
         updateneeded = updateneeded or oldrole ~= newrole
      end
      if updateneeded then
         gcl:RedoGroups()
      end
   end
end
---}}}


---{{{ Event Handling
function gcl:RegisterRoleEvents()
   self:RegisterEvent("ROLE_CHANGED_INFORM")
   talentLib.RegisterCallback(gcl, 'LibGroupTalents_RoleChange')
end


function gcl:UnregisterRoleEvents()
   self:UnregisterMessage("ROLE_CHANGED_INFORM")
   talentLib.UnregisterCallback(gcl, 'LibGroupTalents_RoleChange')
end


function gcl:LibGroupTalents_RoleChange(event, guid, unit)
   debug("Talent rolechange event for", unit)
   local _, class = UnitClass(unit)
   local oldrole, newrole = Role[guid], gcl:GetRole(guid, unit, class, true)
   if oldrole ~= newrole then
      gcl:RedoGroups()
   end
end


function gcl:ROLE_CHANGED_INFORM(event, name, oldname, oldrole, role)
   name = name and name:gsub("(%a)(%a+)", function (a,b) return a:upper() .. b:lower() end)
   oldname = oldname and oldname:gsub("(%a)(%a+)", function (a,b) return a:upper() .. b:lower() end)
   debug("Blizzard rolechange event for", name, ": new unconverted blizzrole is", role)
   -- if we check blizzrole in this thread, it hasn't changed yet, so we need to schedule an update (and, from experience, it can't be very soon)
   if name then
      local guid = GridRoster:GetGUIDByFullName(name)
      if guid then
         table.insert(guidsToUpdate, guid)
      end
   end
   if oldname and oldname ~= name then
      local guid = GridRoster:GetGUIDByFullName(oldname)
      if guid then
         table.insert(guidsToUpdate, guid)
      end
   end
   if guidsToUpdate then
      self:CancelTimer(gcl.roleUpdateTimer, true)
      gcl.roleUpdateTimer = self:ScheduleTimer(gcl.updateRoles, 1)      
   end
end
---}}}
