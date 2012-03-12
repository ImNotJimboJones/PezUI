local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("PetsMountsA") then return end
ZygorGuidesViewer:RegisterInclude("hearth_hub",[[
'Hearth to the Trade District |goto Stormwind City |use Hearthstone##6948 |noway |c  //60.4,75.3
]])
ZygorGuidesViewer:RegisterInclude("hearth2_hub",[[
'_Hearth_ to the _Valley of Honor_ |goto Orgrimmar,70.6,49.2,0.5 |use Hearthstone##6948 |noway |c
]])
ZygorGuidesViewer:RegisterInclude("hearth_dalaran",[[
'_Hearth_ to _A Hero's Welcome, Dalaran_  |goto Dalaran |use Hearthstone##6948 |noway |c  //44.4,62.7
]])
ZygorGuidesViewer:RegisterInclude("trainTailoring",[[
goto Orgrimmar,60.8,59.1
.talk 3363
]])
ZygorGuidesViewer:RegisterInclude("TailorSupplies",[[
goto 53.1,81.8
.talk 1347
]])
ZygorGuidesViewer:RegisterInclude("trainEngineering",[[
goto Stormwind City,62.8,32.0
.talk 5518
]])
ZygorGuidesViewer:RegisterInclude("EngSupplies",[[
goto Stormwind City 63.1,32.0
.talk 5519
]])
ZygorGuidesViewer:RegisterInclude("vendor_Enchanting",[[
goto 52.8,74.3
.talk 1318
]])
ZygorGuidesViewer:RegisterInclude("SWDP",[[
goto Stormwind City,49.0,87.3
.' Click the Portal to Blasted Lands |tip It's a blue and purple swirling portal.
.' Teleport to the Blasted Lands |goto Blasted Lands |noway |c
step
goto Blasted Lands,55.0,54.1 |n
.' Enter the huge green portal
.' Teleport to Hellfire Peninsula |goto Hellfire Peninsula |noway |c
]])
ZygorGuidesViewer:RegisterInclude("hyjal",[[
step
goto Stormwind City,76.2,18.7
.' Click the Portal to Hyjal |tip It's a swirling blue and green portal.
.' Teleport to Mount Hyjal |goto Mount Hyjal |noway |c
]])
ZygorGuidesViewer:RegisterInclude("vashjir",[[
step
goto Stormwind City,73.3,16.8
.' Click the Portal to Vashj'ir |tip It's a big swirling portal.
.' Teleport to Vashj'ir |goto Kelp'thar Forest |noway |c
]])
ZygorGuidesViewer:RegisterInclude("deepholm",[[
step
goto Stormwind City,73.2,19.7
.' Click the Portal to Deepholm |tip It's a pink and purple swirling portal.
.' Teleport to Deepholm |goto Deepholm |noway |c
]])
ZygorGuidesViewer:RegisterInclude("twilight",[[
step
goto Stormwind City,75.3,16.4
.' Click the Portal to Twilight Highlands |tip It's a big swirling portal.
.' Teleport to Twilight Highlands |goto Twilight Highlands |noway |c
]])
ZygorGuidesViewer:RegisterInclude("shatport_sw",[[
step
goto Shattrath City,57.2,48.2
.' Click the Portal to Stormwind |goto Stormwind City,49.6,86.5,0.5 |noway |c
]])
ZygorGuidesViewer:RegisterInclude("darkportal",[[
goto Stormwind City,49.0,87.3
.' Click the Portal to Blasted Lands |tip It's a blue and purple swirling portal.
.' Teleport to the Blasted Lands |goto Blasted Lands |noway |c
step
goto Blasted Lands,55.0,54.1 |n
.' Enter the huge green portal
.' Teleport to Hellfire Peninsula |goto Hellfire Peninsula |noway |c
]])
ZygorGuidesViewer:RegisterInclude("ratchet",[[
|fly Booty Bay //Stranglethorn
step
goto The Cape of Stranglethorn,39.0,67.0 |n
.' Ride the boat to Ratchet, Northern Barrens |goto Northern Barrens |noway |c
]])
ZygorGuidesViewer:RegisterInclude("borean",[[
goto Stormwind City,18.2,25.5 |n
.' Ride the boat to Borean Tundra |goto Borean Tundra |noway |c
]])
ZygorGuidesViewer:RegisterInclude("howlingfjord",[[
|fly Menethil Harbor
step
goto Wetlands,5.1,55.8 |n
'Ride the boat to Howling Fjord|goto Howling Fjord |noway |c
]])
ZygorGuidesViewer:RegisterInclude("ruttheranvillage",[[
goto Stormwind City,22.6,56.0 |n
.' Ride the boat to Rut'theran Village |goto Teldrassil |noway |c
]])
ZygorGuidesViewer:RegisterInclude("theramoreisle",[[
goto Wetlands,6.5,62.1 |n
.' Ride the boat to Theramore Isle, Dustwallow Marsh |goto Dustwallow Marsh |noway |c
]])
ZygorGuidesViewer:RegisterInclude("SWTabard",[[
goto Stormwind City,67.6,72.8  |only if rep("Stormwind")<Exalted
.talk 49877 |only if rep("Stormwind")<Exalted 
.buy 1 Stormwind Tabard##45574 |only if rep("Stormwind")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("DarnTabard",[[
goto Darnassus,36.6,49.0 |only if rep("Darnassus")<Exalted
.talk 50305 |only if rep("Darnassus")<Exalted
.buy 1 Darnassus Tabard##45579 |only if rep("Darnassus")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("ExTabard",[[
goto The Exodar,54.6,36.8 |only if rep("Exodar")<Exalted
.talk 50306 |only if rep("Exodar")<Exalted
.buy 1 Exodar Tabard##45580 |only if rep("Exodar")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("GnomTabard",[[
goto Ironforge,56.2,49.0 |only if rep("Gnomeregan")<Exalted
.talk 50308 |only if rep("Gnomeregan")<Exalted
.buy 1 Gnomeregan Tabard##45578 |only if rep("Gnomeregan")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("IFTabard",[[
goto Ironforge,55.8,47.8 |only if rep("Ironforge")<Exalted
.talk 50309 |only if rep("Ironforge")<Exalted
.buy 1 Ironforge Tabard##45577 |only if rep("Ironforge")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("GilTabard",[[
goto Darnassus,37.0,47.8 |only if rep("Gilneas")<Exalted
.talk 50307 |only if rep("Gilneas")<Exalted
.buy 1 Gilneas Tabard##64882 |only if rep("Gilneas")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("WATabard",[[
goto Dragonblight,59.8,53.0 |only if rep("The Wyrmrest Accord")<Exalted
.talk 32533 |only if rep("The Wyrmrest Accord")<Exalted
.buy 1 Tabard of the Wyrmrest Accord##43156 |only if rep("The Wyrmrest Accord")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("RamkahenTabard",[[
goto Uldum,54.1,33.3 |only if rep("Ramkahen")<Exalted
.talk 48617 |only if rep("Ramkahen")<Exalted 
.buy 1 Tabard of Ramkahen##65904 |only if rep("Ramkahen")<Exalted 
]])
ZygorGuidesViewer:RegisterInclude("main_rep_mount",[[
'This will require you to be _exalted_ with _%rep%_
#include %tabard%
.' Use this _tabard_ and _complete dungeons_ with _friends_ or in the _random dungeon finder_ to get to _exalted_ |only if rep("%rep%")<Exalted 
.' _Exalted_ with _%rep%_ |condition rep("%rep%")>=Exalted	
]])
ZygorGuidesViewer:RegisterInclude("misc_rep_mount",[[
'This will require you to be _exalted_ with _%rep%_
.' _Exalted_ with _%rep%_ |condition rep("%rep%")>=Exalted	
]])
ZygorGuidesViewer:RegisterInclude("rep_mount",[[
'This will require you to be _exalted_ with _%rep%_
]])
ZygorGuidesViewer:RegisterInclude("dailies_rep_mount",[[
'This will require you to be _exalted_ with _%rep%_
.' Use the _%rep%_ Dailies section of this guide to become _exalted_ with _%rep%_ |only if rep("%rep%")<Exalted
.' _Exalted_ with _%rep%_ |condition rep("%rep%")>=Exalted
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Mounts\\Ground Mounts\\Dungeon Mounts\\Rivendare's Deathcharger",[[
description This guide will walk you through obtaining
description the ground mounts that can be obtained 
description through dungeon farming.
condition end hasmount(30542)
model 16937
step
|fly Northpass Tower
step
goto Eastern Plaguelands,43.4,19.5 |n
.' _Click_ on this _gate_, then, run in further to enter _Stratholme_ |goto Stratholme |noway |c
step
'_Traverse_ though the _Stratholme_ instance
goto Stratholme,37.1,19.9 |tip To get to this point you must kill all the bosses and all of the mobs inside the buildings behind the bosses to get to the Slaughterhouse.
.from Lord Aurius Rivendare##45412
.collect 1 Deathcharger's Reins##13335 |tip This has a .8% drop rate, do this everyday to have a higher chance of obtaining it!
|tip If you want, you can go outside the instance and reset it. To reset an instance, right click your portrait and click "Reset all instances". You can then kill this boss again for another chance at the mount.
'|modeldisplay 16937
step
.learnmount Rivendare's Deathcharger##17481 |use Deathcharger's Reins##13335
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Mounts\\Ground Mounts\\Gold Only Mounts\\Armored Brown Bear",[[ 
description This guide will walk you through obtaining
description the ground mounts that can be obtained 
description through gold farming.
condition end hasmount(32206)
model 27821
step
'This _mount_ costs _750_ gold.
|confirm
step
#include borean
step
|fly Dalaran
step
goto Dalaran,58.1,42.1
.talk 32216
.buy 1 Reins of the Armored Brown Bear##44225
'|modeldisplay 27821
step
.learnmount Armored Brown Bear##60116 |use Reins of the Armored Brown Bear##44225 
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Mounts\\Ground Mounts\\Player vs. Player Mounts\\Black War Steed",[[
description This guide will walk you through obtaining
description the ground mounts that require player vs. player to
description purchase.
condition end hasmount(14332)
model 14337
step
'Push the _[H]_ key on your keyboard to open your _Player vs. Player_ interface 
.' Click on _Random Battleground_ and then click on the _Join Battle_ button on the _lower left-hand corner_ of the _Player vs. Player_ interface |tip You can choose any battleground, if you want, but you will not recieve extra rewards for winning or losing
..' Complete these _Random Battlegrounds_ to recieve _Honor Points_
.earn 2000 Honor Point##392
step
goto Stormwind City,76.2,65.6
.talk 12783
.buy 1 Black War Steed Bridle##29468
'|modeldisplay 14337
step
.learnmount Black War Steed##22717 |use Black War Steed Bridle##29468
]])

ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Mammals\\Feline Pets\\Cat Carriers",[[
description This guide will walk you through obtaining
description feline vanity pets 
condition end haspet(7385) and haspet(7384) and haspet(7382) and haspet(7381)
model 5556,5586,5554,5555
step
goto Elwynn Forest,44.2,53.2
.talk 6367 
.buy 1 Cat Carrier (Bombay)##8485 //5556
.buy 1 Cat Carrier (Cornish Rex)##8486 //5586
.buy 1 Cat Carrier (Orange Tabby)##8487 //5554
.buy 1 Cat Carrier (Silver Tabby)##8488 //5555
'|modeldisplay 5556
'|modeldisplay 5586
'|modeldisplay 5554
'|modeldisplay 5555
step
.learnpet Bombay Cat##7385 |use Cat Carrier (Bombay)##8485
.learnpet Cornish Rex Cat##7384 |use Cat Carrier (Cornish Rex)##8486
.learnpet Orange Tabby Cat##7382 |use Cat Carrier (Orange Tabby)##8487
.learnpet Silver Tabby Cat##7381 |use Cat Carrier (Silver Tabby)##8488
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Pets & Mounts Guide\\Pets\\Mammals\\Rabbit Pets\\Snowshoe Rabbit",[[
description This guide will walk you through obtaining 
description rabbit vanity pets 
condition end haspet(7560)
model 16191
step
'Go to _Dun Morogh_ |goto Dun Morogh |noway |c
step
goto 70.6,49.0
.talk 1263
.buy 1 Rabbit Crate (Snowshoe)##8497
'|modeldisplay 16191
step
.learnpet Snowshoe Rabbit##7560 |use Rabbit Crate (Snowshoe)##8497
]])
