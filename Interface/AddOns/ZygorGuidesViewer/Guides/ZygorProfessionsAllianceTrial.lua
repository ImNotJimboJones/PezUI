local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("ProfessionsA") then return end
ZygorGuidesViewer:RegisterInclude("trainer_Alchemy",[[
goto Stormwind City,55.7,86.1
.talk 5499
]])
ZygorGuidesViewer:RegisterInclude("trainer_Archaeology",[[
goto Stormwind City,85.8,25.9
.talk 44238
]])
ZygorGuidesViewer:RegisterInclude("trainer_Blacksmithing",[[
goto 63.7,37.0
.talk 5511
]])
ZygorGuidesViewer:RegisterInclude("trainer_Blacksmithing_Shatt",[[
goto Shattrath City,69.4,43.3
.talk 20124
]])
ZygorGuidesViewer:RegisterInclude("trainer_Cooking",[[
goto Stormwind City,77.3,53.2
.talk 5482
]])
ZygorGuidesViewer:RegisterInclude("trainer_Enchanting",[[
goto Stormwind City,52.9,74.5
.talk 1317
]])
ZygorGuidesViewer:RegisterInclude("trainer_Engineering",[[
goto Stormwind City,62.8,32.0
.talk 5518
]])
ZygorGuidesViewer:RegisterInclude("trainer_FirstAid",[[
goto Stormwind City,52.2,45.4
.talk 2327
]])
ZygorGuidesViewer:RegisterInclude("trainer_Fishing",[[
goto Stormwind City,54.8,69.6
.talk 5493
]])
ZygorGuidesViewer:RegisterInclude("trainer_Herbalism",[[
goto Stormwind City,54.3,84.1
.talk 5566
]])
ZygorGuidesViewer:RegisterInclude("trainer_Inscription",[[
goto Stormwind City,49.8,74.8
.talk 30713
]])
ZygorGuidesViewer:RegisterInclude("trainer_Jewelcrafting",[[
goto Stormwind City,63.5,61.8
.talk 44582
]])
ZygorGuidesViewer:RegisterInclude("trainer_Mining",[[
goto Stormwind City,59.6,37.6 
.talk 5513
]])
ZygorGuidesViewer:RegisterInclude("trainer_Skinning",[[
goto Stormwind City,72.2,62.2
.talk 1292
]])
ZygorGuidesViewer:RegisterInclude("trainer_Skinning_IF",[[
goto Ironforge,39.9,32.6
.talk 6291
]])
ZygorGuidesViewer:RegisterInclude("trainer_Tailoring",[[
goto Stormwind City,53.1,81.3
.talk 1346
]])
ZygorGuidesViewer:RegisterInclude("trainer_Leatherworking",[[
goto Stormwind City,71.7,63.0
.talk 5564
]])
ZygorGuidesViewer:RegisterInclude("vendor_Alchemy",[[
goto 55.9,85.6
.talk 1313
]])
ZygorGuidesViewer:RegisterInclude("vendor_Blacksmithing",[[
goto Stormwind City,63.3,37.8
.talk 5512
]])
ZygorGuidesViewer:RegisterInclude("vendor_Cooking",[[
goto 77.6,53.1
.talk 5483
]])
ZygorGuidesViewer:RegisterInclude("vendor_Enchanting",[[
goto 52.8,74.3
.talk 1318
]])
ZygorGuidesViewer:RegisterInclude("vendor_Engineering",[[
goto 63.1,32.0
.talk 5519
]])
ZygorGuidesViewer:RegisterInclude("vendor_Fishing",[[
goto 55.0,69.7
.talk 5494
]])
ZygorGuidesViewer:RegisterInclude("vendor_Inscription",[[
goto 49.6,74.9
.talk 30730
]])
ZygorGuidesViewer:RegisterInclude("vendor_Jewelcrafting",[[
goto 63.2,61.7
.talk 44583
]])
ZygorGuidesViewer:RegisterInclude("vendor_Mining",[[
goto 59.2,37.5
.talk 5514
]])
ZygorGuidesViewer:RegisterInclude("vendor_Skinning",[[
goto 71.6,62.8
.talk 5565
]])
ZygorGuidesViewer:RegisterInclude("vendor_Tailoring",[[
goto 53.1,81.8
.talk 1347
]])
ZygorGuidesViewer:RegisterInclude("vendor_Leatherworking",[[
goto Stormwind City,71.6,62.8
.talk 5565	
]])
ZygorGuidesViewer:RegisterInclude("questgiver_SWCooking",[[
goto Stormwind City,50.6,71.9
.talk 42288
]])
ZygorGuidesViewer:RegisterInclude("auctioneer",[[
goto 61.1,70.6
.talk 8719
]])
ZygorGuidesViewer:RegisterInclude("auctioneer_dwarven",[[
goto Stormwind City,60.1,32.2
.talk 43841
]])
ZygorGuidesViewer:RegisterInclude("shatt_auctioneer",[[
]])
ZygorGuidesViewer:RegisterInclude("auctioneer_dwarven",[[
goto Stormwind City,60.1,32.2
.talk 43841
]])
ZygorGuidesViewer:RegisterInclude("goto_shatt_auctioneer",[[
goto Shattrath City,51.0,26.5 |only if rep ('The Aldor') >= Neutral
.talk 50143 |only if rep ('The Aldor') >= Neutral
goto Shattrath City,57.0,63.2 |only if rep ('The Scryers') >= Friendly
.talk 50139|only if rep ('The Scryers') >= Friendly
]])
ZygorGuidesViewer:RegisterInclude("go_farm",[[
'You have sufficient %skill% skill to gather these yourself. |only if skill("%skill%")>=%req% |confirm
'Click here if you want to go gathering. |confirm |next "%goto%"  |only if skill("%skill%")>=%req%
'You need %req% points in %skill% to gather these yourself. |only if skill("%skill%")>0 and skill("%skill%")<%req%
]])
ZygorGuidesViewer:RegisterInclude("go_farm_level",[[
'You can gather these yourself. Click here if you want to go gathering. |script ZGV:GotoStep("%goto%") |only if level>=%level%
'You need to be level %level% to gather these yourself. |only if level<%level%
]])
ZygorGuidesViewer:RegisterInclude("go_disenchant",[[
'You have sufficient %skill% skill to gather these yourself by disenchanting items. |only if skill("%skill%")>=%req%
'Click here if you want to go gathering. |confirm |next "%goto%"  |only if skill("%skill%")>=%req%
'You need %req% points in %skill% to gather these yourself. |only if skill("%skill%")>0 and skill("%skill%")<%req%
]])
ZygorGuidesViewer:RegisterInclude("innkeeper_dwarven",[[
goto Stormwind,64.9,31.9
.talk 44235
]])
ZygorGuidesViewer:RegisterInclude("home_TradeDistrict",[[
goto Stormwind City,60.4,75.3
.talk 6740
.home Trade District
]])
ZygorGuidesViewer:RegisterInclude("home_DwarvenDistrict",[[
goto Stormwind City,64.9,31.9
.talk 44235
.home Dwarven District
]])
ZygorGuidesViewer:RegisterInclude("home_OldTown",[[
goto Stormwind City,75.7,54.1
.talk 44237
.home Old Town
]])
ZygorGuidesViewer:RegisterInclude("hearth_hub",[[
'Hearth to the Trade District |goto Stormwind City |use Hearthstone##6948 |noway |c  //60.4,75.3
]])
ZygorGuidesViewer:RegisterInclude("hearth_oldtown",[[
'Hearth to Old Town, Stormwind  |goto Stormwind City |use Hearthstone##6948 |noway |c  //75.6,54.0
]])
ZygorGuidesViewer:RegisterInclude("hearth_dwarven",[[
'Hearth to Dwarven District  |goto Stormwind City |use Hearthstone##6948 |noway |c
]])
ZygorGuidesViewer:RegisterInclude("hearth_dalaran",[[
'Hearth to A Hero's Welcome, Dalaran  |goto Dalaran |use Hearthstone##6948 |noway |c  //44.4,62.7
]])
ZygorGuidesViewer:RegisterInclude("shatt_anvil",[[
goto Shattrath City,69.7,42.7
.' Stand next to this anvil
]])
ZygorGuidesViewer:RegisterInclude("hell_anvil",[[
goto Hellfire Peninsula,56.8,63.8
.' Stand next to this anvil
]])
ZygorGuidesViewer:RegisterInclude("twil_anvil",[[
goto Twilight Highlands,79.2,76.3
.' Stand next to this anvil
]])
ZygorGuidesViewer:RegisterInclude("maincity_anvil2",[[
]])
ZygorGuidesViewer:RegisterInclude("maincity_anvil",[[
goto Stormwind City,63.6,37.0
.' Stand next to this anvil
]])
ZygorGuidesViewer:RegisterInclude("port_blastedlands",[[
goto 49.0,87.3
.' Click the Portal to Blasted Lands |tip It's a blue and purple swirling portal.
.' Teleport to the Blasted Lands |goto Blasted Lands |noway |c
]])
ZygorGuidesViewer:RegisterInclude("darkportal",[[
goto 49.0,87.3
.' Click the Portal to Blasted Lands |tip It's a blue and purple swirling portal.
.' Teleport to the Blasted Lands |goto Blasted Lands |noway |c
step
goto Blasted Lands,55.0,54.1 |n
.' Enter the huge green portal
.' Teleport to Hellfire Peninsula |goto Hellfire Peninsula |noway |c
]])
ZygorGuidesViewer:RegisterInclude("port_hyjal",[[
goto Stormwind City,76.2,18.7
.' Click the Portal to Hyjal |tip It's a swirling blue and green portal.
.' Teleport to Mount Hyjal |goto Mount Hyjal |noway |c
]])
ZygorGuidesViewer:RegisterInclude("port_vashjir",[[
goto Stormwind City,73.3,16.8
.' Click the Portal to Vashj'ir |tip It's a big swirling portal.
.' Teleport to Vashj'ir |goto Kelp'thar Forest |noway |c
]])
ZygorGuidesViewer:RegisterInclude("port_deepholm",[[
goto Stormwind City,73.2,19.7
.' Click the Portal to Deepholm |tip It's a pink and purple swirling portal.
.' Teleport to Deepholm |goto Deepholm |noway |c
]])
ZygorGuidesViewer:RegisterInclude("port_twilight",[[
goto Stormwind City,75.3,16.4
.' Click the Portal to Twilight Highlands |tip It's a big swirling portal.
.' Teleport to Twilight Highlands |goto Twilight Highlands |noway |c
]])
ZygorGuidesViewer:RegisterInclude("shatport_sw",[[
goto Shattrath City,57.2,48.2
.' Click the Portal to Stormwind |goto Stormwind City,49.6,86.5,0.5 |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_ratchet",[[
|fly Booty Bay //Stranglethorn
step
goto The Cape of Stranglethorn,39.0,67.0 |n
.' Ride the boat to Ratchet, Northern Barrens |goto Northern Barrens |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_borean",[[
goto Stormwind City,18.2,25.5 |n
.' Ride the boat to Borean Tundra |goto Borean Tundra |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_howlingfjord",[[
|fly Menethil Harbor
step
goto Wetlands,5.1,55.8 |n
'Ride the boat to Howling Fjord|goto Howling Fjord |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_ruttheranvillage",[[
goto Stormwind City,22.6,56.0 |n
.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_theramoreisle",[[
|fly Menethil Harbor
step
goto Wetlands,6.5,62.1 |n
.' Ride the boat to Theramore Isle, Dustwallow Marsh |goto Dustwallow Marsh |noway |c
]])
ZygorGuidesViewer:RegisterInclude("cast_campfire",[[
'Create a basic campfire |cast Basic Campfire##818
]])
ZygorGuidesViewer:RegisterInclude("dalaran_enter_sewer",[[
Enter the Dalaran sewers |goto Dalaran/2 %q%
'|goto Dalaran/1 60.2,47.7 <0.3 "Sewer entrance" |n %q%
'|goto Dalaran/1 34.8,45.5 <0.3 "Sewer entrance" |n %q%
]])
ZygorGuidesViewer:RegisterInclude("dalaran_leave_sewer",[[
Leave the Dalaran sewers |goto Dalaran/1 %q%
'|goto Dalaran/2 60.2,47.7 <0.3 "Sewer entrance" |n %q%
'|goto Dalaran/2 34.8,45.5 <0.3 "Sewer entrance" |n %q%
]])

ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Professions Guides\\Skinning\\Skinning 1-525 Leveling Guide",[[
description This guide will walk you through leveling your Skinning skill from 1-525.
author support@zygorguides.com
completion skill,Skinning,525
#include "profession_single_start",prof1="Skinning"
step
'Redirecting to Skinning 1-55 |next "skn_1-60" |only if skill("Skinning")<60
'Redirecting to Skinning 55-130 |next "skn_60-130" |only if skill("Skinning")>=60 and skill("Skinning")<150
'Redirecting to Skinning 130-225 |next "skn_150-205" |only if skill("Skinning")>=150 and skill("Skinning")<205
'Redirecting to Skinning 205-275 |next "skn_205-300" |only if skill("Skinning")>=205 and skill("Skinning")<300
'Redirecting to Skinning 290-350 |next "skn_300-350" |only if skill("Skinning")>=300 and skill("Skinning")<350
'Redirecting to Skinning 350-425 |next "skn_350-425" |only if skill("Skinning")>=350 and skill("Skinning")<425
'Redirecting to Skinning 425-525 |next "skn_425-525" |only if skill("Skinning")>=425 and skill("Skinning")<525
'Redirecting to Skinning finale |next "skn_525" |only if default
next 100
step
title + Skinning 1-60
label	"skn_1-60"
#include "trainer_Skinning"
.skillmax Skinning,75
step
#include "vendor_Leatherworking"
.buy 1 Skinning Knife##7005
step
#include "home_TradeDistrict"
step
title + Skinning (1-60)
label	"skn_1-60_farm"
goto 66.4,34.9|n
'Ride the Deep Run Tram to Ironforge |goto Ironforge |noway |c
step
'Go outside to Dun Morogh |goto Dun Morogh |noway |c
step
'Follow the path in the following steps until your Skinning skill is level 60.
.' Kill any beasts you see and skin them.
|confirm
step
map Dun Morogh
path follow loose;loop;ants curved  // this stays until the end of the guide.
path	81.0,50.1	82.7,55.5	83.0,59.3
path	79.3,60.2	79.5,53.6	78.6,48.7
.' Kill any beasts you see and skin them.
skill Skinning,60
step
|fly Ironforge
step
title Skinning 60-130
label	"skn_60-130"
goto Ironforge,39.5,32.6
.talk 6291
.skillmax Skinning,150
step
'Skipping next part of farming |next "+farm2" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
label	"skn_60-130_farm"
|fly Thelsamar
step
'Follow the path in the following steps until your _Skinning_ skill is level 120.
.' Kill any beasts you see and skin them.
|confirm
step
label	"farming"
map Loch Modan
path	50.3,66.3	48.3,61.5	54.8,53.0
path	57.3,50.2	60.4,43.0	62.6,49.3
path	59.4,56.9	53.6,61.7
.' Kill any beasts you see and skin them.
skill Skinning,120
step
label	"farm2"
'Skipping next part of farming |next "+exit" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
|fly  Menethil Harbor
step
'Follow the path in the following steps until your Skinning skill is level 150.
.' Kill any beasts you see and skin them.
|confirm
step
label	"farming"
map Wetlands
path	20.2,50.8	22.8,45.6
path	29.4,42.2	30.0,44.6	
path	26.6,47.6	24.7,51.5	23.6,58.7	
.' Kill any beasts you see and skin them.
skill Skinning,150
step
label	"exit"
#include "hearth_hub"
step
title + Skinning 150-205
label	"skn_150-205"
#include "trainer_Skinning"
.skillmax Skinning,225 |tip You will need to be level 10 to train this.
step
'Skipping next part of farming |next "+farm2" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
label	"skn_150-205_farm"
goto 66.7,34.7 |n
'Ride the Deep Run Tram to Ironforge |goto Ironforge |noway |c
step
|fly Menethil Harbor
step
'Follow the path in the following steps until your Skinning skill is level 185.
.' Kill any beasts you see and skin them.
|confirm
step
label	"farming"
map Wetlands
path	66.8,45.4	79.0,47.2	76.8,43.2
path	69.0,36.4	64.3,28.6
.' Kill any beasts you see and skin them.
skill Skinning,185
step
'Skipping next part of farming |next "+exit" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
label	"farm2"
|fly Aerie Peak
step
'Follow the path in the following steps until your Skinning skill is level 205.
.' Kill any beasts you see and skin them.
|confirm
step
label	"farming"
map The Hinterlands
path	81.2,52.9	80.4,56.9	79.2,61.2
path	78.0,66.0	78.5,70.1	76.6,72.7
path	75.5,71.9	74.6,68.5	75.3,65.2
path	77.0,62.0	78.4,58.3
.' Kill any beasts you see and skin them.
skill Skinning,205
step
label	"exit"
#include "hearth_hub"
step
title + Skinning 205-300
label	"skn_205-300"
#include "trainer_Skinning"
.skillmax Skinning,300 |tip You need to be level 25 to learn this skill.
step
label	"farm"
#include "rideto_ratchet"
step
'Skipping 2nd part of farming |next "+farm2" |only if step:Find("+farming"):IsComplete()
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
path 73.0,48.0	69.8,49.1	67.2,46.2
path 64.7,43.9	61.1,43.4	56.9,43.4
path 57.2,56.1	54.3,59.9	61.1,63.8	
path 65.0,68.5	66.0,74.1	63.9,79.3	
path 64.2,85.3	66.5,92.7	70.1,94.5
.' Kill any beasts you see and skin them.
skill Skinning,265
step
'Skipping 2nd part of farming |next "+exit" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
'Go south to Tanaris |goto Tanaris |noway |c
step
label	"farm2"
|fly Marshal's Stand
step
label	"farming"
map Un'Goro Crater
path 73.0,48.0	69.8,49.1	67.2,46.2
path 64.7,43.9	63.0,52.9	61.1,63.8
path 65.0,68.5	66.0,74.1	63.9,79.3
path 68.6,73.3	71.0,62.6	72.4,52.1
.' Kill any beasts you see and skin them.
skill Skinning,300
step
label	"exit"
#include "hearth_hub"
step
title + Skinning 300-350
label	"skn_300-350"
#include "trainer_Skinning"
.skillmax Skinning,375 |tip You must be at least level 55 to learn this skill.
step
#include "darkportal"
step
|fly Honor Hold
step
label	"skn_300-350_farm"
'Skipping next part of farming |next "+farm2" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
label	"farming"
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
label	"farm2"
'Skipping next part of farming |next "+farm3" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
label	"farming"
map Hellfire Peninsula
path   40.7,85.6	37.6,86.1	34.9,88.8
path 32.7,91.5	33.6,92.4	35.9,91.2
path 37.8,89.9	39.2,88.5	40.7,86.6
.' Kill any beasts you see and skin them.
skill Skinning,330
step
label	"farm3"
'Skipping next part of farming |next "+exit" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
|fly Telaar
step
label	"farming"
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
label	"exit"
#include "hearth_hub"
step
title + Skinning 350-325
label	"skn_350-425"
#include "trainer_Skinning"
.skillmax Skinning,450 |tip You must be at least level 55 to learn this.
step
label	"skn_350-425_farm"
#include "rideto_borean"
step
'Skipping next part of farming |next "+farm2" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
label	"farming"
map Borean Tundra
path 51.5,68.8	49.8,67.7	46.9,70.7
path 44.2,71.0	41.1,70.7	38.5,71.8
path 41.9,74.4	45.3,74.9	48.1,74.4
path 49.6,72.3	51.6,69.1
.' Kill any rhinos you see and skin them.
skill Skinning,395
step
'Skipping next part of farming |next "+exit" |only if step:Find("+farming"):IsComplete()
'Proceeding to farm |next |only if default
step
label	"farm2"
|fly River's Heart
step
label	"farming"
map Sholazar Basin
path 28.8,55.9	29.7,51.6	31.1,46.4
path 32.2,40.4	28.6,42.9	25.6,47.9
path 23.5,52.3	22.6,58.7	22.6,65.3
path 22.3,70.2	26.4,72.7	28.9,69.1
path 29.6,64.4
.' Kill any beasts you see and skin them.
skill Skinning,450
step
label	"exit"
#include "hearth_hub"
step
title + Skinning 425-525
label	"skn_425-525"
#include "trainer_Skinning"
.skillmax Skinning,525 |tip You must be level 75 to learn this.
step
#include "port_vashjir"
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
