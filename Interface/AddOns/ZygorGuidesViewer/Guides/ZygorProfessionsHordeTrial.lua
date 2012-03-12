local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("ProfessionsH") then return end
ZygorGuidesViewer:RegisterInclude("trainer_Alchemy",[[
goto Orgrimmar,55.7,45.7
.talk 3347
]])
ZygorGuidesViewer:RegisterInclude("trainer_Archaeology",[[
goto Orgrimmar 49.0,70.7
.talk 47571
]])
ZygorGuidesViewer:RegisterInclude("trainer_Blacksmithing",[[
goto Orgrimmar,44.4,77.3
.talk 37072
]])
ZygorGuidesViewer:RegisterInclude("trainer_Blacksmithing_Shatt",[[
goto Hellfire Peninsula,53.1,38.2
.talk 16583
]])
ZygorGuidesViewer:RegisterInclude("trainer_Mining",[[
goto Orgrimmar 44.6,78.4
.talk 46357
]])
ZygorGuidesViewer:RegisterInclude("trainer_Herbalism",[[
goto Orgrimmar,54.7,50.5
.talk 46741
]])
ZygorGuidesViewer:RegisterInclude("trainer_Inscription",[[
goto Orgrimmar 55.2,55.7
.talk 46716
]])
ZygorGuidesViewer:RegisterInclude("trainer_Engineering",[[
goto Orgrimmar 56.9,56.4
.talk 11017
]])
ZygorGuidesViewer:RegisterInclude("trainer_Cooking",[[
goto Orgrimmar 56.3,61.5
.talk 46709
]])
ZygorGuidesViewer:RegisterInclude("trainer_Tailoring",[[
goto Orgrimmar,60.8,59.1
.talk 3363
]])
ZygorGuidesViewer:RegisterInclude("trainer_FirstAid",[[
goto Orgrimmar 37.1,87.2
.talk 45540
]])
ZygorGuidesViewer:RegisterInclude("trainer_Fishing",[[
goto Orgrimmar 66.5,41.5
.talk 3332
]])
ZygorGuidesViewer:RegisterInclude("trainer_Enchanting",[[
goto  Orgrimmar 53.4,49.3
.talk 3345
]])
ZygorGuidesViewer:RegisterInclude("trainer_Skinning",[[
goto Orgrimmar,61.1,54.8
.talk 7088
]])
ZygorGuidesViewer:RegisterInclude("trainer_Leatherworking",[[
goto Orgrimmar,60.9,54.9
.talk 3365
]])
ZygorGuidesViewer:RegisterInclude("trainer_Mining",[[
goto Orgrimmar,72.3,35.0
.talk 3357
]])
ZygorGuidesViewer:RegisterInclude("trainer_Jewelcrafting",[[
goto 72.5,34.5
.talk 46675
]])
ZygorGuidesViewer:RegisterInclude("trainer_HerbalismUC",[[
goto Undercity,54.0,49.6
.talk 4614
]])
ZygorGuidesViewer:RegisterInclude("vendor_Alchemy",[[
]])
ZygorGuidesViewer:RegisterInclude("vendor_Archaeology",[[
]])
ZygorGuidesViewer:RegisterInclude("vendor_Blacksmithing",[[
goto 45.0,77.1
.talk 46359
]])
ZygorGuidesViewer:RegisterInclude("vendor_Mining",[[
goto Orgrimmar,72.7,34.8
.talk 3358
]])
ZygorGuidesViewer:RegisterInclude("vendor_Herbalism",[[
]])
ZygorGuidesViewer:RegisterInclude("vendor_Inscription",[[
goto Orgrimmar,55.4,56.0
.talk 46718
]])
ZygorGuidesViewer:RegisterInclude("vendor_Engineering",[[
goto Orgrimmar,56.8,56.4
.talk 3413
]])
ZygorGuidesViewer:RegisterInclude("vendor_Cooking",[[
goto 56.4,61.3
.talk 46708
]])
ZygorGuidesViewer:RegisterInclude("vendor_Tailoring",[[
goto Orgrimmar,60.7,58.7
.talk 3364
]])
ZygorGuidesViewer:RegisterInclude("vendor_FirstAid",[[
]])
ZygorGuidesViewer:RegisterInclude("vendor_Fishing",[[
]])
ZygorGuidesViewer:RegisterInclude("vendor_Enchanting",[[
]])
ZygorGuidesViewer:RegisterInclude("vendor_Skinning",[[
]])
ZygorGuidesViewer:RegisterInclude("vendor_Leatherworking",[[
goto Orgrimmar,60.3,54.3
.talk 3366
]])
ZygorGuidesViewer:RegisterInclude("vendor_Jewelcrafting",[[
]])
ZygorGuidesViewer:RegisterInclude("auctioneer",[[
goto Orgrimmar,54.1,73.3
.talk 44866
]])
ZygorGuidesViewer:RegisterInclude("auctioneer_dalaran",[[
goto Dalaran,38.8,25.1
.talk 35594
]])
ZygorGuidesViewer:RegisterInclude("home_ValleyofStrength",[[
goto Orgrimmar,53.6,78.8
.talk 6929
.home Valley of Strength
]])
ZygorGuidesViewer:RegisterInclude("home_ValleyofHonor",[[
goto Orgrimmar,70.5,49.2
.talk 46642
.home Valley of Honor
]])
ZygorGuidesViewer:RegisterInclude("home_UC",[[
goto Undercity,67.7,37.9
.talk 6741
.home Trade Quarter
]])	
ZygorGuidesViewer:RegisterInclude("hearth_hub",[[
'Hearth to the Valley of Strength |goto Orgrimmar |use Hearthstone##6948 |noway |c  
]])
ZygorGuidesViewer:RegisterInclude("hearth_ValleyofHonor",[[
'Hearth to the Valley of Honor |goto Orgrimmar,70.6,49.2,0.5 |use Hearthstone##6948 |noway |c
]])
ZygorGuidesViewer:RegisterInclude("uctrade_hub",[[
'Hearth to the Trade Quarter |goto Undercity,67.7,37.9,0.5 |use Hearthstone##6948 |noway |c
]])
ZygorGuidesViewer:RegisterInclude("hearth_dalaran",[[
'Hearth to A Hero's Welcome, Dalaran  |goto Dalaran |use Hearthstone##6948 |noway |c  //44.4,62.7
]])
ZygorGuidesViewer:RegisterInclude("maincity_forge",[[
goto Orgrimmar 75.9,37.3
.' Stand at this forge
]])
ZygorGuidesViewer:RegisterInclude("maincity_anvil",[[
goto Orgrimmar 44.7,78.0
 .' Stand at this Anvil
]])
ZygorGuidesViewer:RegisterInclude("maincity_forge2",[[
goto Orgrimmar 44.7,78.0
.' Stand at this forge
]])
ZygorGuidesViewer:RegisterInclude("hellanvil",[[
goto Hellfire Peninsula,53.3,38.3
.' Stand in this spot
]])
ZygorGuidesViewer:RegisterInclude("twil_anvil",[[
goto Twilight Highlands,79.2,76.3
.' Stand next to this anvil
]])
ZygorGuidesViewer:RegisterInclude("shatt_anvil",[[
goto 53.0,38.0
.' Stand next to this Anvil
]])
ZygorGuidesViewer:RegisterInclude("darkportal",[[
 goto Orgrimmar,45.0,66.4
.' Click the Portal to Blasted Lands |tip It's a blue swirling portal.
.' Teleport to the Blasted Lands |goto Blasted Lands |noway |c
step
goto Blasted Lands,55.0,54.1 |n
.' Enter the huge green portal 
.' Teleport to Hellfire Peninsula |goto Hellfire Peninsula |noway |c
]])
ZygorGuidesViewer:RegisterInclude("port_blastedlands",[[
goto Orgrimmar,35.5,69.1
.' Click the Portal to Blasted Lands |tip It looks like a blue swirling portal.
.' Teleport to the Blasted Lands |goto Blasted Lands,53.9,46.1,0.5 |noway |c
]])
ZygorGuidesViewer:RegisterInclude("port_deepholm",[[
goto Orgrimmar,50.8,36.3
.' Click the Portal to Deepholm |tip It looks like a blue swirling portal.
.' Teleport to Deepholm |goto Deepholm |noway |c
]])
ZygorGuidesViewer:RegisterInclude("port_hyjal",[[
goto Orgrimmar,51.1,38.3
.' Click on the Portal to Hyjal |tip It looks like a white and blue swirling portal
.' Teleport to Mount Hyjal |goto Mount Hyjal |c
]])
ZygorGuidesViewer:RegisterInclude("port_twilight",[[
goto Orgrimmar,50.2,39.4
.' Click on the Portal to Twilight Highlands |tip It looks like a light blue swirling portal
.' Teleport to Twilight Highlands| goto Twilight Highlands |noway |c
]])
ZygorGuidesViewer:RegisterInclude("port_uldum",[[
goto Orgrimmar,48.8,38.6
.' Click the Portal to Uldum |tip It looks like a blue swirling portal.
.' Teleport to Uldum |goto Uldum |noway |c
]])
ZygorGuidesViewer:RegisterInclude("port_vashj'ir",[[
goto Orgrimmar,49.2,36.5
.' Click the Portal to Vashj'ir |tip It's a big blue swirling portal.
.' Teleport to Vashj'ir |goto Vashj'ir |noway |c
]])
ZygorGuidesViewer:RegisterInclude("shatport_org",[[
goto Shattrath City,56.7,48.7 |n
.' Click the Portal to Orgrimmar |goto Orgrimmar,48.3,64.5,0.5 |noway |c
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
ZygorGuidesViewer:RegisterInclude("rideto_howlingfjord",[[ //this one goes from Org to Tirisfal Glades to Howling Fjord
goto Orgrimmar,50.8,55.8 |n
.' Ride the zeppelin to Tirisfal Glades |goto Tirisfal Glades |noway |c
step
goto Tirisfal Glades,59.1,59.0 |n
.' Ride the zeppelin to Howling Fjord |goto Howling Fjord |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_org",[[ //coming from UC
goto Tirisfal Glades,60.7,58.8 |n
.' Ride the Zeppelin to Orgrimmar |goto Orgrimmar |noway |c
]])
ZygorGuidesViewer:RegisterInclude("cast_campfire",[[
'Create a basic campfire |cast Basic Campfire##818
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Profession Guides\\Skinning\\Skinning 1-525 Leveling Guide",[[
description This guide will walk you through leveling your Skinning skill from 1-525.
author support@zygorguides.com
completion skill,Skinning,525
#include "profession_single_start",prof1="Skinning"
step
'Redirecting to Skinning 1-60 |next "skn_1-60" |only if skill("Skinning")<60
'Redirecting to Skinning 60-150 |next "skn_60-150" |only if skill("Skinning")>=60 and skill("Skinning")<150
'Redirecting to Skinning 150-205 |next "skn_150-205" |only if skill("Skinning")>=150 and skill("Skinning")<205
'Redirecting to Skinning 205-300 |next "skn_205-300" |only if skill("Skinning")>=205 and skill("Skinning")<300
'Redirecting to Skinning 300-350 |next "skn_300-350" |only if skill("Skinning")>=300 and skill("Skinning")<350
'Redirecting to Skinning 350-450 |next "skn_350-450" |only if skill("Skinning")>=350 and skill("Skinning")<450
'Redirecting to Skinning 450-525 |next "skn_450-525" |only if skill("Skinning")>=450 and skill("Skinning")<525
'Redirecting to Skinning finale |next "skn_525" |only if default
next 100
step
tTitle + Skinning 1-60
label	"skn_1-60"
#include "trainer_Skinning"
.skillmax Skinning,75
step
#include "vendor_Leatherworking"
.buy 1 Skinning Knife##7005
step
#include "home_ValleyofHonor"
step
'Go south to Durotar |goto Durotar
step
'Follow the path in the following steps until your Skinning skill is level 60.
.' Kill any beasts you see and skin them.
|confirm
step
map Durotar
path follow loose;loop  // this stays until the end of the guide.
path	56.2,31.4	58.1,23.9	56.3,15.5
path	52.8,10.7	51.3,14.0	48.9,16.0
path	49.7,17.9		53.8,18.6
.' Kill any beasts you see and skin them.
skill Skinning,60
step
#include hearth_ValleyofHonor
step
label	"skn_60-150"
#include trainer_Skinning
.skillmax Skinning,150
step
'Skipping next part of farming |next "+farm1" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
|fly Ratchet
step
'Follow the path in the following steps until your Skinning skill is level 120.
.' Kill any beasts you see and skin them.
|confirm
step
label	"farming"
map Northern Barrens
path	65.2,57.4	67.8,63.9	63.9,67.0
path	61.1,71.2	62.3,77.1	58.9,75.7
path	55.7,71.1	57.9,65.2	62.2,63.1
path	64.0,58.1
.' Kill any beasts you see and skin them.
skill Skinning,120
step
|fly Orgrimmar
step
label	"farm1"
goto Orgrimmar,52.5,53.1 |n
.' Ride the Zeppelin to Northern Stranglethorn |goto Northern Stranglethorn |noway |c
step
map Northern Stranglethorn
path	25.3,32.3	31.3,35.0	33.5,30.6
path	35.4,23.1	36.4,19.7	32.0,21.0
path	31.2,27.4	26.0,29.6
.' Kill any beasts you see and skin them.
skill Skinning,150
step
#include hearth_ValleyofHonor
step
label	"skn_150-205"
#include trainer_Skinning
.skillmax Skinning,225
step
goto Orgrimmar,52.5,53.2 |n
'Ride the Zeppelin to Stranglethorn |goto Northern Stranglethorn |noway |c
step
'Skipping next part of farming |next "+farm1" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
|fly Hardwrench Hideaway
step
'Follow the path in the following steps until your Skinning skill is level 185.
.' Kill any beasts you see and skin them.
|confirm
step
label	"farming"
map The Cape of Stranglethorn
path	58.0,26.6	61.0,25.7	64.7,29.8
path	68.2,27.7	67.0,22.6	64.8,26.4
path	66.0,28.7	62.1,32.6	58.3,29.0
.' Kill any beasts you see and skin them.
skill Skinning,185
step
label	"farm1"
|fly Revantusk Village
step
'Follow the path in the following steps until your Skinning skill is level 205.
.' Kill any beasts you see and skin them.
|confirm
step
map The Hinterlands
path	81.2,52.9	80.4,56.9	79.2,61.2
path	78.0,66.0	78.5,70.1	76.6,72.7
path	75.5,71.9	74.6,68.5	75.3,65.2
path	77.0,62.0	78.4,58.3
.' Kill any beasts you see and skin them.
skill Skinning,205
step
#include hearth_ValleyofHonor
step
label	"skn_205-300"
#include trainer_Skinning
.skillmax Skinning,300
step
'Skipping next part of farming |next "+farm1" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
|fly Gadgetzan
step
'Go north to Thousand Needles |goto Thousand Needles |noway |c
step
'Follow the path in the following steps until your Skinning skill is level 265.
.' Kill any beasts you see and skin them.
|confirm
step
label	"farming"
map Thousand Needles
path   73.0,48.0	69.8,49.1	67.2,46.2
path 64.7,43.9	61.1,43.4	56.9,43.4
path 55.0,56.9	61.1,63.8	65.0,68.5
path 66.0,74.1	63.9,79.3	64.2,85.3
path 66.5,92.7	70.1,94.5
.' Kill any beasts you see and skin them.
skill Skinning,265
step
label	"farm1"
|fly Marshal's Stand
step
map Un'Goro Crater
path   73.0,48.0	69.8,49.1	67.2,46.2
path 64.7,43.9	63.0,52.9	61.1,63.8
path 65.0,68.5	66.0,74.1	63.9,79.3
path 68.6,73.3	71.0,62.6	72.4,52.1
.' Kill any beasts you see and skin them.
skill Skinning,300
step
#include hearth_ValleyofHonor
step
label	"skn_300-350"
#include trainer_Skinning
.skillmax Skinning,375
step
#include "darkportal"
step
'Skipping next part of farming |next "+farm1" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
|fly Thrallmar
step
map Hellfire Peninsula
path 62.0,56.6	60.6,56.8	58.9,56.1
path 57.2,56.0	56.2,54.3	58.2,54.2
path 59.9,54.6	66.6,61.4	69.1,61.6
path 70.3,63.7	70.6,66.4	69.3,66.5
path 68.0,65.2	66.5,62.5	65.3,61.0
path 64.0,60.1	62.4,57.4
.' Kill any beasts you see and skin them.
skill Skinning,305
step
map Hellfire Peninsula
path 54.9,70.9	53.1,71.5	51.7,72.7
path 50.7,74.9	48.9,75.4	48.1,73.0
path 48.0,71.1	46.4,69.9	46.5,67.8
path 48.1,64.9	47.4,63.0	49.3,62.8
path 51.4,65.9	52.9,68.8	54.9,70.1
.' Kill any beasts you see and skin them.
skill Skinning,310
step
label	"farming"
map Hellfire Peninsula
path   40.7,85.6	37.6,86.1	34.9,88.8
path 32.7,91.5	33.6,92.4	35.9,91.2
path 37.8,89.9	39.2,88.5	40.7,86.6
.' Kill any beasts you see and skin them.
skill Skinning,330
step
label	"farm1"
|fly Garadar
step
map Nagrand
path 56.2,21.2	55.2,23.2	53.7,24.3
path 52.7,26.0	52.5,28.4	52.8,31.3
path 50.4,37.1	51.7,39.9	53.1,42.2
path 51.3,45.3	48.8,45.1	48.0,42.0
path 47.9,38.5	48.0,32.4	48.0,29.1
path 50.8,27.4	51.8,23.8	54.8,21.5
path 56.4,20.0i
.' Kill any beasts you see and skin them.
skill Skinning,350
step
#include hearth_ValleyofHonor
step
label	"skn_350-450"
#include trainer_Skinning
.skillmax Skinning,450
step
#include "rideto_borean"
step
map Borean Tundra
path 51.5,68.8	49.8,67.7	46.9,70.7
path 44.2,71.0	41.1,70.7	38.5,71.8
path 41.9,74.4	45.3,74.9	48.1,74.4
path 49.6,72.3	51.6,69.1
.' Kill any rhinos you see and skin them.
skill Skinning,395
step
|fly Nesingwary Base Camp
step
map Sholazar Basin
path 28.8,55.9	29.7,51.6	31.1,46.4
path 32.2,40.4	28.6,42.9	25.6,47.9
path 23.5,52.3	22.6,58.7	22.6,65.3
path 22.3,70.2	26.4,72.7	28.9,69.1
path 29.6,64.4
.' Kill any beast you see and skin them.
skill Skinning,450
step
#include hearth_ValleyofHonor
step
label	"skn_450-525"
#include trainer_Skinning
.skillmax Skinning,525
step
#include "port_vashj'ir" 
step
map Kelp'thar Forest
path 56.0,36.5	57.8,39.4	59.1,39.7
path 59.4,36.9	57.6,34.9
.' Kill any crabs and serpents in the area.
skill Skinning,525
step
label	"skn_525"
'Congratulations, you are now a level 525 Skinner!	
]])
