local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("AchievementsH") then return end
ZygorGuidesViewer:RegisterInclude("hearth",[[
'Hearth to the Valley of Strength |goto Orgrimmar |use Hearthstone##6948 |noway |c  
]])
ZygorGuidesViewer:RegisterInclude("darkportal",[[
goto Orgrimmar,45.9,66.9 |n
.' Follow the path down |goto Orgrimmar,45.9,66.9,0.5 |noway |c
step
goto Orgrimmar,45.0,66.4
.' Click the Portal to Blasted Lands |tip It's a blue swirling portal.
.' Teleport to the Blasted Lands |goto Blasted Lands |noway |c
step
goto Blasted Lands,55.0,54.1 |n
.' Enter the huge green portal 
.' Teleport to Hellfire Peninsula |goto Hellfire Peninsula |noway |c
]])
ZygorGuidesViewer:RegisterInclude("portal_hyjal",[[
goto Orgrimmar,51.1,38.3
.' Click the Portal to Hyjal |tip It looks like a big swirling portal in front of some huge tree roots.
.' Teleport to Mount Hyjal |goto Mount Hyjal |noway |c
]])
ZygorGuidesViewer:RegisterInclude("HyjalPortaltoOrg",[[
goto Mount Hyjal,63.5,24.4
.' Click the Portal to Orgrimmar |tip It looks like a big swirling orange portal next to a big building.
.' Teleport to Orgrimmar |goto Orgrimmar |noway |c
]])
ZygorGuidesViewer:RegisterInclude("portal_deepholm",[[
goto Orgrimmar,50.8,36.4 |n
.' Click the Portal to Deepholm |tip It looks like a purple swirling portal.
.' Teleport to Deepholm |goto Deepholm |noway |c
]])
ZygorGuidesViewer:RegisterInclude("portal_vashj'ir",[[
goto Orgrimmar,49.3,36.5
.' Click on the portal to Vashj'ir |tip It looks like a blue swirling portal.
.' Teleport to Vashj'ir |goto Abyssal Depths |noway |c
]])
ZygorGuidesViewer:RegisterInclude("OrgPortaltoUldum",[[
goto Orgrimmar,48.9,38.6
.' Click the Portal to Uldum |tip It looks like a big swirling portal in front of some big stone slabs.
.' Teleport to Uldum |goto Uldum |noway |c
]])
ZygorGuidesViewer:RegisterInclude("portal_twilight",[[
goto Orgrimmar,50.2,39.4
.' Click the Portal to Twilight Highlands |tip It looks like a big swirling portal in front of some big metal twisting spiral objects.
.' Teleport to Twilight Highlands |goto Twilight Highlands |noway |c
]])
ZygorGuidesViewer:RegisterInclude("TwilightHighlandsPortaltoOrg",[[
goto Twilight Highlands,73.6,53.5
.' Go into the Portal to Orgrimmar |tip It looks like a big swirling orange portal at the bottom of this tower.
.' Teleport to Orgrimmar |goto Orgrimmar |noway |c
]])
ZygorGuidesViewer:RegisterInclude("OrgFpath",[[
goto Orgrimmar 49.6,59.0
.talk 3310
]])
ZygorGuidesViewer:RegisterInclude("rideto_borean",[[
goto Orgrimmar,44.7,62.4 |n
.' Ride the zeppelin to Borean Tundra |goto Borean Tundra |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_tirisfal",[[
goto Orgrimmar,50.8,55.8 |n
.' Ride the zeppelin to Tirisfal Glades |goto Tirisfal Glades |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_stranglethorn",[[
goto Orgrimmar,52.5,53.2 |n
.' Ride the zeppelin to Stranglethorn Vale |goto Northern Stranglethorn |noway |c
]])
ZygorGuidesViewer:RegisterInclude("TirisfalHowlingShip",[[
step
goto Tirisfal Glades,59.1,59.0 |n
.' Ride the zeppelin to Howling Fjord |goto Howling Fjord |noway |c
]])
ZygorGuidesViewer:RegisterInclude("trainCooking",[[
goto Orgrimmar 56.3,61.5
.talk 46709
]])
ZygorGuidesViewer:RegisterInclude("trainFishing",[[
goto Orgrimmar 66.5,41.5
.talk 3332
]])
