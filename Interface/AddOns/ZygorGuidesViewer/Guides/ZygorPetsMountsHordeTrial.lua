local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("PetsMountsH") then return end
ZygorGuidesViewer:RegisterInclude("hearth_hub",[[
'_Hearth_ to the _Valley of Strength_ |goto Orgrimmar |use Hearthstone##6948 |noway |c  
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
ZygorGuidesViewer:RegisterInclude("trainEngineering",[[
goto Orgrimmar 56.9,56.4
.talk 11017
]])
ZygorGuidesViewer:RegisterInclude("EngSupplies",[[
goto Orgrimmar,56.8,56.4
.talk 3413
]])
ZygorGuidesViewer:RegisterInclude("vendor_Enchanting",[[
]])
ZygorGuidesViewer:RegisterInclude("DarkPortalOrg",[[
goto Orgrimmar,45.9,66.9 |n
.' Follow the path down |goto Orgrimmar,45.9,66.9,0.5 |noway |c
step
goto Orgrimmar,45.0,66.4
.' Click the _Portal_ to _Blasted Lands_ |tip It's a blue swirling portal.
.' _Teleport_ to the _Blasted Lands_ |goto Blasted Lands |noway |c
step
goto Blasted Lands,55.0,54.1 |n
.' Enter the _huge green portal_
.' Teleport to _Hellfire Peninsula_ |goto Hellfire Peninsula |noway |c
]])
ZygorGuidesViewer:RegisterInclude("OrgPortaltoHyjal",[[
goto Orgrimmar,51.1,38.3
.' Click the _Portal_ to _Mount Hyjal_ |tip It looks like a big swirling portal in front of some huge tree roots.
.' Teleport to _Mount Hyjal_ |goto Mount Hyjal |noway |c
]])
ZygorGuidesViewer:RegisterInclude("HyjalPortaltoOrg",[[
goto Mount Hyjal,63.5,24.4
.' Click the _Portal_ to _Orgrimmar_ |tip It looks like a big swirling orange portal next to a big building.
.' Teleport to _Orgrimmar_ |goto Orgrimmar |noway |c
]])
ZygorGuidesViewer:RegisterInclude("OrgPortaltoUldum",[[
goto Orgrimmar,48.9,38.6
.' Click the _Portal_ to _Uldum_ |tip It looks like a big swirling portal in front of some big stone slabs.
.' Teleport to _Uldum_ |goto Uldum |noway |c
]])
ZygorGuidesViewer:RegisterInclude("OrgPortaltoTwilightHighlands",[[
goto Orgrimmar,50.2,39.4
.' Click the _Portal_ to _Twilight Highlands_ |tip It looks like a big swirling portal in front of some big metal twisting spiral objects.
.' Teleport to _Twilight Highlands_ |goto Twilight Highlands |noway |c
]])
ZygorGuidesViewer:RegisterInclude("TwilightHighlandsPortaltoOrg",[[
goto Twilight Highlands,73.6,53.5
.' Go into the _Portal_ to _Orgrimmar_ |tip It looks like a big swirling orange portal at the bottom of this tower.
.' Teleport to Orgrimmar |goto Orgrimmar |noway |c
]])
ZygorGuidesViewer:RegisterInclude("BoreanZep",[[
goto Orgrimmar,44.7,62.4 |n
.' Ride the zeppelin to _Borean Tundra_ |goto Borean Tundra |noway |c
]])
ZygorGuidesViewer:RegisterInclude("TirisfalZep",[[
goto Orgrimmar,50.8,55.8 |n
.' Ride the zeppelin to _Tirisfal Glades_ |goto Tirisfal Glades |noway |c
]])
ZygorGuidesViewer:RegisterInclude("StranglethornZep",[[
goto Orgrimmar,52.5,53.2 |n
.' Ride the zeppelin to _Stranglethorn Vale_ |goto Northern Stranglethorn |noway |c
]])
ZygorGuidesViewer:RegisterInclude("HowlingZep",[[ //this one goes from Org to Tirisfal Glades to Howling Fjord
goto Orgrimmar,50.8,55.8 |n
.' Ride the zeppelin to _Tirisfal Glades_ |goto Tirisfal Glades |noway |c
step
goto Tirisfal Glades,59.1,59.0 |n
.' Ride the zeppelin to _Howling Fjord_ |goto Howling Fjord |noway |c
]])
ZygorGuidesViewer:RegisterInclude("TirisfalHowlingZep",[[
step
goto Tirisfal Glades,59.1,59.0 |n
.' Ride the zeppelin to _Howling Fjord_ |goto Howling Fjord |noway |c
]])
ZygorGuidesViewer:RegisterInclude("OrgTabard",[[
goto Orgrimmar 50.2,58.3 |only if rep("Orgrimmar")<Exalted
.talk 50488 |only if rep("Orgrimmar")<Exalted 
.buy 1 Orgrimmar Tabard##45581 |only if rep("Orgrimmar")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("BilgeTabard",[[
goto Orgrimmar,50.2,58.3 |only if rep("Bilgewater Cartel")<Exalted
.talk 50323 |only if rep("Bilgewater Cartel")<Exalted
.buy 1 Bilgewater Cartel Tabard##64884 |only if rep("Bilgewater Cartel")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("TBTabard",[[
goto Thunder Bluff,46.8,50.0 |only if rep("Thunder Bluff")<Exalted
.talk 50483 |only if rep("Thunder Bluff")<Exalted
.buy 1 Thunder Bluff Tabard##45584 |only if rep("Thunder Bluff")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("DSTabard",[[
goto Orgrimmar,50.2,58.3 |only if rep("Darkspear Trolls")<Exalted
.talk 50477 |only if rep("Darkspear Trolls")<Exalted
.buy 1 Darkspear Tabard##45582 |only if rep("Darkspear Trolls")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("SCTabard",[[
goto Eversong Woods,54.2,50.8 |only if rep("Silvermoon City")<Exalted
.talk 50484 |only if rep("Silvermoon City")<Exalted
.buy 1 Silvermoon City Tabard##45585 |only if rep("Silvermoon City")<Exalted
]])
ZygorGuidesViewer:RegisterInclude("UCTabard",[[
goto Undercity,50.2,58.3 |only if rep("Undercity")<Exalted
.talk 50304 |only if rep("Undercity")<Exalted
.buy 1 Undercity Tabard##45583 |only if rep("Undercity")<Exalted
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
ZygorGuidesViewer:RegisterInclude("dailies_rep_mount",[[
'This will require you to be _exalted_ with _%rep%_
.' Use the _%rep%_ Dailies section of this guide to become _exalted_ with _%rep%_ |only if rep("%rep%")<Exalted
.' _Exalted_ with _%rep%_ |condition rep("%rep%")>=Exalted
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Pets & Mounts Guide\\Mounts\\Ground Mounts\\Dungeon Mounts\\Rivendare's Deathcharger",[[
description This guide will walk you through obtaining
description the ground mounts that can be obtained 
description through dungeon farming.
condition end hasmount(30542)
model 16937
step
#include TirisfalZep
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
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Pets & Mounts Guide\\Mounts\\Ground Mounts\\Gold Only Mounts\\Armored Brown Bear",[[ 
description This guide will walk you through obtaining
description the ground mounts that can be obtained 
description through gold farming.
condition end hasmount(32207)
model 27821
step
'This _mount_ costs _750_ gold.
|confirm
step
#include BoreanZep
step
|fly Dalaran
step
goto Dalaran,58.1,42.1
.talk 32216
.buy 1 Reins of the Armored Brown Bear##44226
'|modeldisplay 27821
step
.learnmount Armored Brown Bear##60116 |use Reins of the Armored Brown Bear##44226 
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Pets & Mounts Guide\\Mounts\\Ground Mounts\\Player vs. Player Mounts\\Black War Wolf",[[
description This guide will walk you through obtaining
description the ground mounts that require player vs. player to
description purchase.
condition end hasmount(14329)
model 21241
step
'Push the _[H]_ key on your keyboard to open your _Player vs. Player_ interface 
.' Click on _Random Battleground_ and then click on the _Join Battle_ button on the _lower left-hand corner_ of the _Player vs. Player_ interface |tip You can choose any battleground, if you want, but you will not recieve extra rewards for winning or losing
..' Complete these _Random Battlegrounds_ to recieve _Honor Points_
.earn 2000 Honor Point##392
step
goto Orgrimmar,41.8,73.6
.talk 12796
.buy 1 Horn of the Black War Wolf##29469
'|modelnpc 14329
step
.learnmount Black War Wolf##22724 |use Horn of the Black War Wolf##29469
]])

ZygorGuidesViewer:RegisterGuide("Zygor's Horde Pets & Mounts Guide\\Mounts\\Flying Mounts\\Achievement Mounts\\Violet Proto-Drake\\Brewfest Quests",[[
author support@zygorguides.com
description This guide section will walk you through completing the quests for the Brewfest event.
step
goto Orgrimmar,51.6,75.2
.talk 19175
..accept 11446
step
'Go outside to Durotar |goto Durotar |noway |c
step
goto Durotar,42.6,17.8
.talk 24497
..accept 11409
step
'As you run around on the ram:
.' Use your Ram Racing Reins |use Ram Racing Reins##33306 |tip The ram runs slow by default.  You have to use the Ram Racing Reins to make it run at certain speeds for 8 seconds.  The make the ram Trot for 8 seconds, use the Ram Racing Reins every 2 seconds or so to keep the ram running at the speed just above the slow default speed.  To make the Ram Canter for 8 seconds, use the Ram Racing Reins a little more often than when you made the Ram Trot.  To make the Ram Gallop, just spam use the Ram Racing Reins.
.' Maintain a Trot for 8 seconds |q 11409/1
.' Maintain a Canter for 8 seconds |q 11409/2
.' Maintain a Gallop for 8 seconds |q 11409/3
step
goto Durotar,42.6,17.9
.talk 24497
..turnin 11409
..accept 11412
step
goto 50.6,13.5
.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Run as fast as you can without making your Ram stop from being too tired.  Stop at every bucket of apples you see on the side of the road to refresh your Ram's fatigue level, allowing the Ram to run faster for longer.
.' Bok Dropcertain will throw you a keg when you get close
.' Once you have a keg, run back and turn it in to Driz Tumblequick at [42.6,17.7] |tip Just get near him and you will throw the keg to him.
.' Deliver 3 Kegs in Under 4 Minutes|q 11412/1
step
goto Durotar,42.6,17.8
.talk 24497
..turnin 11412
step
goto Durotar,42.7,17.7
.talk 24510
..accept 29396 |or
..accept 13931 |or
step
goto Durotar,41.6,18.4
.talk 24711
..turnin 11446
step
goto Durotar,41.5,17.6
.talk 27216
..accept 12191
step
goto Durotar,41.5,17.5
.' Click the Complimentary Brewfest Samplers |tip They looks like mugs of beer on the small tables on either side of you.
.' Use your Complimentary Brewfest Samplers |use Complimentary Brewfest Sampler##33096
.' Hit S.T.O.U.T. 5 Times |q 12191/1
step
goto 41.5,17.5
.talk 27216
..turnin 12191
step
goto 41.2,18.5
.' NOTE: If you are on an EU server, you will be unable to accept these 2 quests. |tip So, just skip them, and also skip the guide steps where you complete the quest goals for these quests.
.talk 24657
..accept 11431
..accept 11120
step
goto 41.3,17.9
.talk 24657
..' Ask him if there's another way you can help out if you don't like drinking, then ask for a pair of Synthebrew Goggles
.collect Synthebrew Goggles##46735 |q 11431
step
goto 40.3,17.9
.talk 24495
..turnin 29396 |or
..turnin 13931 |or
step
'Use your Synthebrew Goggles |use Synthebrew Goggles##46735
.' Equip the Synthebrew Goggles |havebuff Interface\Icons\Spell_Holy_SpiritualGuidence |q 11431
step
goto Durotar,41.2,18.1
.' Use your Wolpertinger Net on Wild Wolpertingers |use Wolpertinger Net##32907 |tip They look like rabbits with antlers and wings running around on the ground around this area.
.get 5 Stunned Wolpertinger |q 11431/1
step
goto Durotar,41.2,18.5
.talk 24657
..turnin 11431
.' Earn Does Your Wolpertinger Linger? achievement |achieve 1683/6
step
.' Go Northeast to Orgrimmar |goto Orgrimmar |noway|c
step
goto Orgrimmar,50.9,55.7 |n
.' Ride the zepplin to Tirisfal Glades |goto Tirisfal Glades |noway|c
step
'Go south into Undercity |goto Undercity |noway |c
step
goto Undercity,70.5,12.0
.' Use your Elekk Dispersion Ray on Tirisfal Pink Elekks |use Elekk Dispersion Ray##32960
.kill 3 Tirisfal Pink Elekk |q 11120/3
step
goto 54.9,11.3 |n
.' Click the Orb of Translocation |tip It looks like a red glowing orb in a gold spinning stand.
.' Teleport to Silvermoon City |goto Silvermoon City |noway |c
step
'Go outside to Eversong Woods |goto Eversong Woods |noway |c
step
goto Eversong Woods,57.0,53.1
.' Use your Elekk Dispersion Ray on Eversong Pink Elekks |use Elekk Dispersion Ray##32960
.kill 3 Eversong Pink Elekk |q 11120/1
step
'Go inside Silvermoon City |goto Silvermoon City |noway |c
step
goto Silvermoon City,49.5,14.8 |n
.' Click the Orb of Translocation |tip It looks like a red glowing orb in a gold spinning stand.
.' Teleport to Undercity |goto Undercity |noway |c
step
'Go outside to Tirisfal Glades |goto Tirisfal Glades |noway |c	
step
goto Tirisfal Glades,60.7,58.7 |n
.' Ride the zeppelin to Orgrimmar |goto Orgrimmar |noway |c
step
|fly Thunder Bluff
step
goto Thunder Bluff,34.7,74.7
.' Go down the lifts
.' Use your Elekk Dispersion Ray on Mulgore Pink Elekks |use Elekk Dispersion Ray##32960
.kill 3 Mulgore Pink Elekk |q 11120/2
step
|fly Orgrimmar
step
'Go outside to Durotar |goto Durotar |noway |c
step
goto Durotar,41.2,18.5
.talk 24657
..turnin 11120
step
'Use the Dungeon Finder (press I) to queue for Coren Direbrew |tip You must be level 80 do complete this quest.
.' You will fight Coren Direbrew
.from Coren Direbrew##23872
.collect Direbrew's Dire Brew##38281 |n
.' Click Direbrew's Dire Brew in your bags |use Direbrew's Dire Brew##38281
..accept 12492
.' Kill Coren  Direbrew |achieve 1683/3
step
'Click the green eye on the edge of your minimap
.' Teleport Out of the Dungeon |goto Durotar |noway |c
step
goto Durotar,41.6,18.5
.talk 24711
..turnin 12492
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Pets & Mounts Guide\\Mounts\\Flying Mounts\\Achievement Mounts\\Violet Proto-Drake\\Brewfest Dailies",[[
author support@zygorguides.com
description This guide section will walk you through completing the daily quests for the Brewfest event.
daily
step
goto Durotar,40.6,18.2
.talk 24498
..accept 11407 |daily |or
.' Go to [Durotar,40.2,17.1]
.talk 24499
..accept 11408 |daily |or
.' You will only be able to accept one of these quests per day.
step
'Ride your ram into Orgrimmar |goto Orgrimmar |noway |c |q 11407
.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
step
'Ride your ram into Orgrimmar |goto Orgrimmar |noway |c |q 11294
.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
step
goto Orgrimmar,52.1,75.0
.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
.' Go to this spot
.' Bark Outside the Auction House |q 11407/1
step
goto 67.0,48.2
.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
.' Go to this spot
.' Bark in the Valley of Honor |q 11407/2
step
goto 44.3,49.1
.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
.' Go to this spot
.' Bark in the Valley of Wisdom |q 11407/3
step
goto 38.0,75.6
.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
.' Go to this spot
.' Bark in the Valley of Spirits |q 11407/4
step
goto Orgrimmar,52.9,66.5 
.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
.' Go to this spot
.' Bark Outside the Auction House |q 11408/1
step
goto 71.5,34.8 
.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
.' Go to this spot
.' Bark in the Valley of Honor |q 11408/2
step
goto 43.8,36.5 
.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
.' Go to this spot
.' Bark in the Valley of Wisdom |q 11408/3
step
goto 37.0,74.3 
.' Use your Ram Racing Reins as you run |use Ram Racing Reins##33306 |tip Just keep a Trot pace most of the time, and only sometimes keep a Canter pace.  If you go too much faster than that, your ram will get tired and you will run out of time.
.' Go to this spot
.' Bark in the Valley of Spirits |q 11408/4
step
'Go outside to Durotar |goto Durotar |noway |c
step
goto Durotar,40.6,18.2
.talk 24498
..turnin 11407
step
goto Durotar,43.6,17.6
.talk 24499
..turnin 11408
step
goto 40.4,18.0
.' Click the Dark Iron Mole Machine Wreckage |tip You have to defend the three kegs at these locations in order for it to show up.
.' Click the Complimentary Brewfest Sampler here [40.2,17.4]
.' Click the Complimentary Brewfest Sampler here [40.4,16.8]
.' Thow the Sampler's at the Dark Iron Dwarves and the Mole Machines. |use Complimentary Brewfest Sampler##33096
..accept 12192 |daily
step
goto 41.5,17.6
.talk 27216
..turnin 12192
.' Earn the Down With the Dark Iron achievement |achieve 1683/4
step
goto 42.7,17.6
.talk 24497
..accept 29393 |instant |daily
.' On your Ram, run to Bok Dropcertain at [50.6,13.5] |tip Bok Dropcertain will throw you a keg when you get close.
.' Deliver as many kegs as you can within 4 minutes |tip You get 2 Brewfest Prize Tokens for each keg you deliver, so this is a good way to get some Brewfest Prize Tokens to join the Brew of the Month Club.
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Pets & Mounts Guide\\Mounts\\Flying Mounts\\Achievement Mounts\\Violet Proto-Drake\\Brewfest Achievements",[[
author support@zygorguides.com
description This guide section will walk you through completing the achievements for the Brewfest event.
step
goto Durotar,41.0,18.3
.talk 23603
.buy The Essential Brewfest Pretzel##33043 |achieve 1185
step
'Click The Essential Brewfest Pretzels in your bags |use The Essential Brewfest Pretzel##33043
.' Eat The Essential Brewfest Pretzels |achieve 1185/7
step
goto 40.2,17.7
.talk 23604
.buy Spiced Onion Cheese##34065 |achieve 1185
step
'Click the Spiced Onion Cheese in your bags |use Spiced Onion Cheese##34065
.' Eat the Spiced Onion Cheese |achieve 1185/4
step
goto 41.2,17.3
.talk 23605
.buy Dried Sausage##34063 |achieve 1185
.buy Succulent Sausage##34064 |achieve 1185
.buy Savory Sausage##33023 |achieve 1185
.buy Pickled Sausage##33024 |achieve 1185
.buy Spicy Smoked Sausage##33025 |achieve 1185
.buy The Golden Link##33026 |achieve 1185
step
'Do the following:
.' Click the Dried Sausage in your bags |use Dried Sausage##34063
.' Eat the Dried Sausage |achieve 1185/1
.' Click the Succulent Sausage in your bags |use Succulent Sausage##34064
.' Eat the Succulent Sausage |achieve 1185/6
.' Click the Savory Sausage in your bags |use Savory Sausage##33023
.' Eat the Savory Sausage |achieve 1185/3
.' Click the Pickled Sausage in your bags |use Pickled Sausage##33024
.' Eat the Pickled Sausage |achieve 1185/2
.' Click the Spicy Smoked Sausage in your bags |use Spicy Smoked Sausage##33025
.' Eat Spicy Smoked Sausage |achieve 1185/5
.' Click the The Golden Link in your bags |use The Golden Link##33026
.' Eat The Golden Link |achieve 1185/8
.' Earn The Brewfest Diet |achieve 1683/1
step
goto 40.3,17.9
.talk 24495
.buy Fresh Brewfest Hops##37750 |achieve 303 |tip You must be at least level 20 to buy these.
step
'Use your Fresh Brewfest Hops |use Fresh Brewfest Hops##37750
.' Make your Mount Festive for Brewfest! |achieve 303
.' Earn Have Keg, Will Travel |achieve 1683/5
step
'Complete the Brewfest daily quests each day until you have 200 Brewfest Prize Tokens
.collect 200 Brewfest Prize Token##37829 |achieve 2796
step
goto 40.3,17.9
.talk 24495
.buy "Brew of the Month" Club Membership Form##37599 |n
.' Click the "Brew of the Month" Club Membership Form in your bags |use "Brew of the Month" Club Membership Form##37599
..accept 12306
.' Buy the Wolpertinger's Tankard and click it to.learnpet it. |achieve 1683/6
step
'Go inside Orgrimmar |goto Orgrimmar |noway |c
step
goto Orgrimmar,50.4,73.5
.talk 27489
..turnin 12306
.' Earn the Brew of the Month achievement |achieve 1683/2
step
'Congratulations, you are a Brewmaster! |achieve 1683
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Pets & Mounts Guide\\Pets\\Mammals\\Feline Pets\\Black Tabby Cat",[[
description This guide will walk you through obtaining
description feline vanity pets 
condition end haspet(7383)
model 5448
step
'Go to _Hillsbrad Foothills_ |goto Hillsbrad Foothills |noway |c
step
'_Kill_ any and all mobs in _Hillsbrad Foothills_ |tip Every mob here has a chance to drop the Black Tabby Cat's carrier
.collect 1 Cat Carrier (Black Tabby)##8491
'|modeldisplay 5448
step
.learnpet Black Tabby Cat##7383 |use Cat Carrier (Black Tabby)##8491
]])
