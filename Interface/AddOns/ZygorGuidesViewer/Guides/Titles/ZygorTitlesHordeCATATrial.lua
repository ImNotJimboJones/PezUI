local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("TitlesH") then return end
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Titles\\Miscellaneous Titles\\The Diplomat\\Timbermaw Hold Faction",[[
author support@zygorguides.com
step
|fly Whisperwind Grove
step
goto Felwood,64.0,10.3
.talk 15395
..accept 28338
..accept 28366
step
goto 64.1,10.3
.talk 48461
..accept 28362
step
goto 60.6,9.5
.talk 47556
.turnin 28362
.accept 28364
step
goto 62.1,9.9
.from Chieftain Bloodmaw##9462
.get Drizle's Key##63695 |q 28364/1
step
goto 60.6,9.5
.talk 47556
.turnin 28364
step
goto 62.0,12.8
.from Deadwood Den Watcher##7156+, Deadwood Avenger##7157+, Deadwood Shaman##7158+
.'Kill 15 Deadwood Furbolg |q 28338/1
.click Deadwood Weapon Pile##10202
.get 7 Deadwood Weapons |q 28366/1
..collect 1 Deadwood Ritual Totem##20741 |n
..accept 8470
.' You can find more around [Felwood,59.7,9.8].
step
goto 64.0,10.3
.talk 15395
..turnin 28338
..turnin 28366
..accept 28521
.' You should be able to turn in Feathers for Nafien, a repeatable reputation quest.
step
goto 64.7,5.7
.talk 11558
.turnin 8470
.' You should be friendly with Timbermaw after completing this quest.
only if rep('Timbermaw Hold')>=Neutral
step
goto 64.9,5.2
.talk 11557
.accept 6031
only if rep ('Timbermaw Hold')>=Friendly
step
goto Winterspring,21.1,46.2
.talk 11556
..turnin 28521
..accept 28524
..accept 28522
step
goto 25.1,58.5
.talk 9298
..turnin 28524
..accept 28460
..accept 28464
step
goto 24.5,47.6
.' Click the Winterfall Cauldron.
..turnin 28464
..accept 28467
step
goto 24.5,47.6
.from Winterfall Totemic##7441+, Winterfall Den Watcher##7440+, Winterfall Runner##10916+
.'Kill 15 Winterfall Furbolg |q 28460/1
..get 10 Winterfall Spirit Beads |q 28522/1
.' You can find more mobs around [Winterspring,27.3,49.3].
step
goto 25.1,58.5
.talk 9298
..turnin 28467
..turnin 28460
..accept 28469
..accept 28530
step
goto 29.3,54.8
.from Winterfall Runner##10916
.get Winterfall Crate |q 28469/1
.' They walk along the road so some searching may be required.
step
goto 32.7,50.6
.from Scalding Springsurge##48767+,Boiling Springbubble##48768+
.get 7 Suspicious Green Sludge |q 28530/1
step
goto 25.1,58.5
.talk 9298
..turnin 28469
..turnin 28530
..accept 28470
.' You should be honored with Timbermaw Hold at this point.
step
goto 37.0,55.6
.kill High Chief Winterfall##10738 |q 28470/1
step
goto 25.1,58.5
.talk 9298
..turnin 28470
step
goto 21.1,46.2
.talk 11556
..turnin 28522
.' You should now be able to do the quest More Beads for Salfa.
step
goto 65.3,46.2
.talk 48722
.accept 28614
step
goto 65.4,46.2
.talk 48723
..accept 28615
step
goto 67.0,47.7
' Use Tanrir's Overcharged Totem to overload Winterfall Earth Totems. |use Tanrir's Overcharged Totem##64637
.' Overload 4 Winterfall Earth Totems |q 28615/1
|modelnpc Winterfall Earth Totem##49177
step
goto 69.3,50.6
..kill Grolnar the Berserk##49178 |q 28614/1
step
goto Winterspring,65.4,46.2
.talk 48723
..turnin 28615
step
goto 65.3,46.2
.talk 48722
..turnin 28614
step
label	"the_grind"
.' At this point, you can do two repeatable quests, as well as grind to earn rep.
.' More Beads for Salfa requires that you grind in Winterspring.  You collect 5 Winterfall Spirit Beads, which are worth 2,000 Reputation per turn in.  Click here to farm at the Winterspring location. |confirm |next "winterfall"
.' or
.' Feathers for Nafien requires that you grind in Felwood. You collect 5 Deadwood Headdress Feathers, which are worth 2,000 Reputation per turn in.  Click here to farm at the Felwood location. |confirm |next "deadwood"
.' Collecting 65 Beads/Feathers will get you from Honored to Exalted.
step
label	"winterfall"
goto 67.5,49.8
.from Winterfall Shaman##7439+,Winterfall Ursa##7438+
..collect Winterfall Spirit Beads##21383 |n |tip You need to collect at least 5.
.' 5 Winterfall Spirit Beads = 2,000 Reputation. You're aiming for at least 60 to 65 Winterfall Spirit Beads in total.
.' More can be found at [Winterspring,35.6,56.3]
.' Click here to turn in your beads |confirm
step
goto 21.1,46.2
.talk 11556
..accept 28523 |n
.' Click here to go back to grinding. |next "the_grind" |only if rep('Timbermaw Hold')<=Revered |confirm
.' or
.' Exalted with Timbermaw Hold |next "exalted" |condition rep('Timbermaw Hold')==Exalted
step
label	"deadwood"
goto Felwood,61.9,12.3
.from Deadwood Avenger##7157+,Deadwood Den Watcher##7156+,Deadwood Shaman##7158+
..collect Deadwood Headdress Feather##21377 |n |tip You need to collect at least 5.
.' 5 Feather Headresses = 2,000 Reputation.  You're aiming for at least 60 to 65 Feather Headresses in total.
.' More can be found at [Felwood,59.6,8.9]
.' Click here to turn in your feathers |confirm |next "turnin"
step
label	"turnin"
goto 64.0,10.3
.talk 15395
..accept 28395 |n
.' Click here to go back to grinding. |next "the_grind" |only if rep('Timbermaw Hold')<=Revered |confirm
.' or
.' Exalted with Timbermaw Hold |next "exalted" |condition rep('Timbermaw Hold')==Exalted
step
label	"exalted"
.' Congratulations, you are now Exalted with Timbermaw Hold!
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Titles\\Explorer Achievement\\Kalimdor",[[
description This guide section will walk you through completing
description the Explorer achievement.
author support@zygorguides.com
step
' This guide assumes you have a flying mount and can fly in Azeroth as well. You can do this
.' without having a flying mount but it will be much more efficient with one.
|confirm always
step
label	"start"
' Explore Durotar |achieve 728
' Explore Northern Barrens |achieve 750
' Explore Southern Barrens |achieve 4996
' Explore Dustwallow Marsh |achieve 850
' Explore Thousand Needles |achieve 846
' Explore Tanaris |achieve 851
' Explore Un'Goro Crater |achieve 854
' Explore Uldum |achieve 4865
' Explore Silithus |achieve 856
' Explore Feralas |achieve 849
' Explore Desolace |achieve 848
' Explore Mulgore |achieve 736
' Explore Stonetalon Mountains |achieve 847
' Explore Ashenvale |achieve 845
' Explore Mount Hyjal |achieve 4863
' Explore Winterspring |achieve 857
' Explore Azshara |achieve 852
' Explore Moonglade |achieve 855
' Explore Felwood |achieve 853
' Explore Darkshore |achieve 844
' Explore Teldrassil |achieve 842
' Explore Azuremyst Isle |achieve 860
' Explore Bloodmyst Isle |achieve 861
|confirm always
step
'Skipping next part of guide |next "+n_barrens" |only if step:Find("+durotar"):IsComplete()
'Proceeding next step |next |only if default
step
goto Orgrimmar,45.4,8.5
.' Discover Orgrimmar |achieve 728/12
step
goto Durotar,54.0,9.0
.' Discover Skull Rock |achieve 728/11
step
goto 52.4,24.2
.' Discover Drygulch Ravine |achieve 728/10
step
goto 53.5,43.4
.' Discover Razor Hill |achieve 728/7
step
goto 58.1,60.2
.' Discover Tiragarde Keep |achieve 728/6
step
goto 66.6,82.9
.' Discover Echo Isles |achieve 728/5
step
goto 56.1,75.8
.' Discover Sen'jin Village |achieve 728/4
step
goto 48.5,79.1
.' Discover Northwatch Foothold |achieve 728/2
step
goto 44.5,62.2
.' Discover Valley of Trials |achieve 728/1
step
goto 44.6,50.6
.' Discover Razormane Grounds |achieve 728/8
step
goto 40.5,40.0
.' Discover Southfury Watershed |achieve 728/3
step
goto 40.3,24.7
.' Discover Thunder Ridge |achieve 728/9
step
label	"durotar"
'Explore Durotar |achieve 728
step
label	"n_barrens"
'Skipping next part of guide |next "+s_barrens" |only if step:Find("+n_barrens1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Northern Barrens,67.2,12.1
.' Discover Boulder Lode Mine |achieve 750/1
step
goto 55.7,18.5
.' Discover The Sludge Fen |achieve 750/4
step
goto 39.6,14.1
.' Discover The Mor'shan Rampart |achieve 750/3
step
goto 25.5,31.7
.' Discover The Dry Hills |achieve 750/6
step
goto 36.8,45.9
.' Discover The Forgotten Pools |achieve 750/7
step
goto 43.1,35.4
.' Discover Dreadmist Peak |achieve 750/5
step
goto 54.9,41.1
.' Discover Grol'dom Farm |achieve 750/8
step
goto 67.0,41.3
.' Discover Far Watch Post |achieve 750/9
step
goto 58.8,50.0
.' Discover Thorn Hill |achieve 750/10
step
goto 50.2,57.3
.' Discover The Crossroads |achieve 750/11
step
goto 40.3,73.9
.' Discover Lushwater Oasis |achieve 750/2
step
goto 55.7,78.6
.' Discover The Stagnant Oasis |achieve 750/12
step
goto 70.3,84.1
.' Discover The Merchant Coast |achieve 750/14
step
label	"n_barrens1"
'Explore Northern Barrens |achieve 750
step
label	"s_barrens"
'Skipping next part of guide |next "+dustwallow" |only if step:Find("+s_barrens1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Southern Barrens,68.8,49.1
.' Discover Northwatch Hold |achieve 4996/7
step
goto 52.2,48.6
.' Discover Forward Command |achieve 4996/3
step
goto 47.8,33.68
.' Discover The Overgrowth |achieve 4996/10
step
goto 39.3,22.3
.' Discover Hunter's Hill |achieve 4996/6
step
goto 36.5,11.1
.' Discover Honor's Stand |achieve 4996/5
step
goto 42.4,44.0
.' Discover Vendetta Point |achieve 4996/11
step
goto 44.9,54.3
.' Discover Ruins of Taurajo |achieve 4996/9
step
goto 41.0,78.2
.' Discover Frazzlecraz Motherlode |achieve 4996/4
step
goto 50.7,84.0
.' Discover Bael Modan |achieve 4996/1
step
label	"s_barrens1"
'Explore Southern Barrens |achieve 4996
step
label	"dustwallow"
'Skipping next part of guide |next "+thousand" |only if step:Find("+dustwallow1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Dustwallow Marsh,29.7,49.0
.' Discover Shady Rest Inn |achieve 850/5
step
goto 36.3,30.4
.' Discover Brackenwall Village |achieve 850/7
step
goto 41.4,12.4
.' Discover Blackhoof Village |achieve 850/2
step
goto 76.0,17.5
.' Discover Alcaz Island |achieve 850/9
step
goto 61.5,30.2
.' Discover Dreadmurk Shore |achieve 850/6
step
goto 67.1,49.8
.' Discover Theramore Isle |achieve 850/1
step
goto 46.6,46.1
.' Discover Direhorn Post |achieve 850/3
step
goto 41.4,75.1
.' Discover Mudsprocket |achieve 850/4
step
goto 43.4,75.5
.' Discover Wyrmbog |achieve 850/8
step
label	"dustwallow1"
' Explore Dustwallow Marsh |achieve 850
step
label	"thousand"
'Skipping next part of guide |next "+tanaris" |only if step:Find("+thousand1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Thousand Needles,88.4,47.8
.' Discover Splithoof Heights |achieve 846/10
step
goto 51.7,30.0
.' Discover Razorfen Downs |achieve 846/2
step
goto 33.6,38.6
.' Discover Darkcloud Pinnacle |achieve 846/8
step
goto 32.1,18.3
.' Discover The Great Lift |achieve 846/1
step
goto 13.4,10.3
.' Discover Westreach Summit |achieve 846/7
step
goto 13.1,37.5
.' Discover Highperch |achieve 846/12
step
goto 31.1,58.8
.' Discover Twilight Bulwark |achieve 846/6
step
goto 47.0,50.7
.' Discover Freewind Post |achieve 846/9
step
goto 54.9,63.2
.' Discover The Twilight Withering |achieve 846/5
step
goto 67.1,85.7
.' Discover Sunken Dig Site |achieve 846/3
step
goto 92.4,78.8
.' Discover Southsea Holdfast |achieve 846/4
step
label	"thousand1"
' Explore Thousand Needles |achieve 846
step
label	"tanaris"
'Skipping next part of guide |next "+ungoro" |only if step:Find("+tanaris1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Tanaris,37.3,14.3
.' Discover Zul'Farrak |achieve 851/15
step
goto 40.9,27.3
.' Discover Sandsorrow Watch |achieve 851/2
step
goto 52.3,45.4
.' Discover Broken Pillar |achieve 851/6
step
goto 55.1,40.9
.' Discover Abyssal Sands |achieve 851/5
step
goto 64.2,50.0
.' Discover Caverns of Time |achieve 851/16
step
goto 71.6,49.4
.' Discover Lost Rigger Cove |achieve 851/4
step
goto 63.0,59.2
.' Discover Southbreak Shore |achieve 851/9
step
goto 53.7,67.6
.' Discover The Gaping Chasm |achieve 851/10
step
goto 53.6,91.7
.' Discover Land's End Beach |achieve 851/12
step
goto 37.8,77.7
.' Discover Valley of the Watchers |achieve 851/3
step
goto 40.8,70.6
.' Discover  Southmoon Ruins |achieve 851/13
step
goto 47.2,64.9
.' Discover Eastmoon Ruins |achieve 851/11
step
goto 30.4,66.4
.' Discover Thistleshrub Valley |achieve 851/14
step
goto 41.0,55.5
.' Discover Dunemaul Compound |achieve 851/8
step
goto 34.3,45.3
.' Discover The Noxious Lair |achieve 851/7
step
label	"tanaris1"
' Explore Tanaris |achieve 851
step
label	"ungoro"
'Skipping next part of guide |next "+uldum" |only if step:Find("+ungoro1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Un'Goro Crater,77.1,39.2
.' Discover Ironstone Plateau |achieve 854/11
step
goto 39.2,34.3
.' Discover The Roiling Gardens |achieve 854/5
step
goto 65.7,14.3
.' Discover Fungal Rock |achieve 854/2
step
goto 51.4,25.6
.' Discover Lakkari Tar Pits |achieve 854/12
step
goto 42.2,41.7
.' Discover Mossy Pile |achieve 854/4
step
goto 29.0,35.8
.' Discover The Screaming Reaches |achieve 854/6
step
goto 34.4,54.0
.' Discover Golakka Hot Springs |achieve 854/7
step
goto 33.2,70.7
.' Discover Terror Run |achieve 854/8
step
goto 54.5,48.0
.' Discover Fire Plume Ridge |achieve 854/1
step
goto 54.0,60.9
.' Discover Marshal's Stand |achieve 854/3
step
goto 67.9,54.8
.' Discover The Marshlands |achieve 854/10
step
goto 51.1,77.5
.' Discover The Slithering Scar |achieve 854/9
step
label	"ungoro1"
' Explore Un'Goro Crater |achieve 854
step
label	"uldum"
'Skipping next part of guide |next "+silithus" |only if step:Find("+uldum1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Uldum,64.5,16.1
.' Discover Khartut's Tomb |achieve 4865/3
step
goto 69.0,21.8
.' Discover The Gate of Unending Cycles |achieve 4865/19
step
goto 64.6,31.8
.' Discover Obelisk of the Stars |achieve 4865/9
step
goto 67.1,40.9
.' Discover Nahorn |achieve 4865/6
step
goto 84.7,52.8
.' Discover The Cursed Landing |achieve 4865/18
step
goto 80.3,60.0
.' Discover The Trail of Devastation |achieve 4865/21
step
goto 63.9,73.3
.' Discover Lost City of the Tol'vir |achieve 4865/4
step
goto 51.2,82.0
.' Discover Neferset City |achieve 4865/7
step
goto 43.7,70.4
.' Discover Cradle of the Ancients |achieve 4865/2
step
goto 45.6,56.2
.' Discover Obelisk of the Sun |achieve 4865/10
step
goto 54.3,52.2
.' Discover Akhenet Fields |achieve 4865/1
step
goto 58.3,40.9
.' Discover Vir'naal Dam |achieve 4865/22
step
goto 60.5,39.2
.' Discover Tahret Grounds |achieve 4865/16
step
goto 54.8,32.4
.' Discover Ramkahen |achieve 4865/12
step
goto 49.0,38.4
.' Discover Mar'at |achieve 4865/5
step
goto 46.1,15.5
.' Discover Ruins of Ahmtul |achieve 4865/13
step
goto 40.8,22.9
.' Discover Obelisk of the Moon |achieve 4865/8
step
goto 33.7,30.9
.' Discover Temple of Uldum |achieve 4865/17
step
goto 40.5,39.9
.' Discover Orsis |achieve 4865/11
step
goto 32.1,65.5
.' Discover Ruins of Ammon |achieve 4865/14
step
goto 20.8,61.8
.' Discover Schnottz's Landing |achieve 4865/15
step
label	"uldum1"
' Explore Uldum |achieve 4865
step
label	"silithus"
'Skipping next part of guide |next "+feralas" |only if step:Find("+silithus1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Silithus,60.0,71.7
.' Discover Hive'Regal |achieve 856/5
step
goto 32.0,78.9
.' Discover The Scarab Wall |achieve 856/6
step
goto 31.4,53.8
.' Discover Hive'Zora |achieve 856/4
step
goto 30.9,16.0
.' Discover The Crystal Vale |achieve 856/1
step
goto 49.4,22.4
.' Discover Hive'Ashi |achieve 856/7
step
goto 54.4,34.2
.' Discover Cenarion Hold |achieve 856/3
step
goto 65.3,47.4
.' Discover Southwind Village |achieve 856/2
step
goto 81.3,17.8
.' Discover Valor's Rest |achieve 856/8
step
label	"silithus1"
' Explore Silithus |achieve 856
step
label	"feralas"
'Skipping next part of guide |next "+desolace" |only if step:Find("+feralas1"):IsComplete()
'Proceeding next step |next |only if default
step
goto  Feralas,75.9,62.4
.' Discover The Writhing Deep |achieve 849/8
step
goto 83.0,40.9
.' Discover Lower Wilds |achieve 849/1
step
goto 76.5,44.4
.' Discover Camp Mojache |achieve 849/9
step
goto 75.6,29.8
.' Discover Gordunni Outpost |achieve 849/11
step
goto 68.7,40.3
.' Discover Grimtotem Compound |achieve 849/10
step
goto 60.4,35.6
.' Discover Dire Maul |achieve 849/5
step
goto 67.7,58.5
.' Discover Darkmist Ruins |achieve 849/12
step
goto 58.6,73.0
.' Discover Ruins of Isildien |achieve 849/7
step
goto 55.4,56.2
.' Discover Feral Scar Vale |achieve 849/6
step
goto 49.7,49.2
.' Discover The Forgotten Coast |achieve 849/4
step
goto 45.8,49.6
.' Discover Feathermoon Stronghold |achieve 849/13
step
goto 28.5,49.1
.' Discover Ruins of Feathermoon |achieve 849/2
step
goto 46.3,17.9
.' Discover The Twin Colossals |achieve 849/3
step
label	"feralas1"
' Explore Ferals |achieve 849
step
label	"desolace"
'Skipping next part of guide |next "+mulgore" |only if step:Find("+desolace1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Desolace,36.1,88.6
.' Discover Gelkis Village |achieve 848/12
step
goto 51.3,78.5
.' Discover Mannoroc Coven |achieve 848/13
step
goto 36.5,69.9
.' Discover Thargad's Camp |achieve 848/2
step
goto 24.2,70.9
.' Discover Shadowprey Village |achieve 848/11
step
goto 35.34,57.2
.' Discover Valley of Spears |achieve 848/9
step
goto 29.9,29.4
.' Discover Slitherblade Shore |achieve 848/16
step
goto 28.7,9.01
.' Discover Ranazjar Isle |achieve 848/8
step
goto 51.5,10.0
.' Discover Tethris Aran |achieve 848/1
step
goto 54.5,25.2
.' Discover Thunder Axe Fortress |achieve 848/5
step
goto 66.7,8.7
.' Discover Nijel's Point |achieve 848/3
step
goto 78.2,21.6
.' Discover Sargeron |achieve 848/4
step
goto 74.7,45.6
.' Discover Magram Territory |achieve 848/7
step
goto 56.1,47.3
.' Discover Cenarion Wildlands |achieve 848/6
step
goto 50.7,59.0
.' Discover Kodo Graveyard |achieve 848/10
step
goto 70.6,74.8
.' Discover Shok'Thokar |achieve 848/14
step
goto 80.3,79.3
.' Discover Shadowbreak Ravine |achieve 848/15
step
label	"desolace1"
' Explore Desolace |achieve 848
step
label	"mulgore"
'Skipping next part of guide |next "+stonetalon" |only if step:Find("+mulgore1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Mulgore,32.3,50.6
.' Discover Bael'dun Digsite |achieve 736/10
step
goto 35.5,61.3
.' Discover Palemane Rock |achieve 736/2
step
goto 53.8,85.8
.' Discover Red Cloud Mesa |achieve 736/1
step
goto 53.7,66.7
.' Discover Winterhoof Water Well |achieve 736/4
step
goto 47.8,58.4
.' Discover Bloodhoof Village |achieve 736/3
step
goto 61.1,60.5
.' Discover The Rolling Plains |achieve 736/5
step
goto 62.7,42.6
.' Discover The Venture Co. Mine |achieve 736/6
step
goto 54.2,47.9
.' Discover Ravaged Caravan |achieve 736/7
step
goto 44.9,43.5
.' Discover Thunderhorn Water Well |achieve 736/9
step
goto 59.82,19.9
.' Discover Red Rocks |achieve 736/11
step
goto 54.2,20.9
.' Discover The Golden Plains |achieve 736/8
step
goto 43.1,14.2
.' Discover Wildmane Water Well |achieve 736/13
step
label	"mulgore1"
' Explore Mulgore |achieve 736
step
label "stonetalon"
'Skipping next part of guide |next "+ashenvale" |only if step:Find("+stonetalon1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Stonetalon Mountains,72.6,92.4
.' Discover Malaka'jin |achieve 847/9
step
goto 76.7,75.8
.' Discover Unearthed Grounds |achieve 847/5
step
goto 69.6,85.1
.' Discover Greatwood Vale |achieve 847/12
step
goto 63.4,88.7
.' Discover Boulderslide Ravine |achieve 847/11
step
goto 59.6,78.9
.' Discover Webwinder Path |achieve 847/10
step
goto 57.2,72.7
.' Discover Webwinder Hollow |achieve 847/6
step
goto 48.8,76.3
.' Discover Ruins of Eldre'thar |achieve 847/3
step
goto 49.3,63.4
.' Discover Sun Rock Retreat |achieve 847/12
step
goto 31.6,71.5
.' Discover The Charred Vale |achieve 847/15
step
goto 37.0,54.3
.' Discover Battlescar Valley |achieve 847/1
step
goto 35.8,31.5
.' Discover Thal'darah Overlook |achieve 847/4
step
goto 40.9,19.9
.' Discover Stonetalon Peak |achieve 847/17
step
goto 45.1,30.2
.' Discover Cliffwalker Post |achieve 847/8
step
goto 51.6,47.3
.' Discover Mirkfallon Lake |achieve 847/16
step
goto 59.1,57.7
.' Discover Windshear Hold |achieve 847/7
step
goto 66.9,66.2
.' Discover Krom'gar Fortress |achieve 847/2
step
goto 66.9,49.3
.' Discover Windshear Crag |achieve 847/13
step
label	"stonetalon1"
' Explore Stonetalon Mountains |achieve 847
step
label	"ashenvale"
'Skipping next part of guide |next "+hyjal" |only if step:Find("+ashenvale1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Ashenvale,32.6,65.6
.' Discover The Ruins of Stardust |achieve 845/10
step
goto 35.9,50.2
.' Discover Astranaar |achieve 845/9
step
goto 21.4,55.3
.' Discover The Shrine of Aessina |achieve 845/8
step
goto 20.2,41.1
.' Discover Lake Falathim |achieve 845/5
step
goto 27.5,37.7
.' Discover Maestra's Post |achieve 845/6
step
goto 26.0,19.7
.' Discover Orendil's Retreat |achieve 845/2
step
goto 37.0,32.9
.' Discover Thistlefur Village |achieve 845/7
step
goto 48.9,46.4
.' Discover Thunder Peak |achieve 845/4
step
goto 53.2,32.6
.' Discover The Howling Vale |achieve 845/11
step
goto 59.7,50.0
.' Discover Raynewood Retreat |achieve 845/12
step
goto 68.2,47.9
.' Discover Splintertree Post |achieve 845/14
step
goto 80.4,49.7
.' Discover Satyrnaar |achieve 845/15
step
goto 83.1,65.3
.' Discover Felfire Hill |achieve 845/18
step
goto 87.4,58.6
.' Discover Warsong Lumber Camp |achieve 845/17
step
goto 93.4,39.2
.' Discover Bough Shadow |achieve 845/16
step
label	"ashenvale1"
' Explore Ashenvale |achieve 845
step
label "hyjal"
'Skipping next part of guide |next "+winter" |only if step:Find("+hyjal1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Mount Hyjal,72.5,76.7
.' Discover Gates of Sothann |achieve 4863/5
step
goto 76.0,64.9
.' Discover Darkwhisper Gorge |achieve 4863/4
step
goto 53.4,55.1
.' Discover The Scorched Plain |achieve 4863/10
step
goto 45.3,80.5
.' Discover The Throne of Flame |achieve 4863/11
step
goto 31.4,84.9
.' Discover Sethria's Roost |achieve 4863/7
step
goto 25.5,64.5
.' Discover Rim of the World |achieve 4863/1
step
goto 31.8,53.5
.' Discover Ashen Lake |achieve 4863/3
step
goto 32.9,51.2
.' Discover The Flamewake |achieve 4863/9
step
goto 28.5,27.5
.' Discover Shrine of Goldrinn |achieve 4863/8
step
goto 45.1,26.0
.' Discover The Circle of Cinders |achieve 4863/2
step
goto 63.4,21.0
.' Discover Nordrassil |achieve 4863/6
step
label	"hyjal1"
' Explore Mount Hyjal |achieve 4863
step
label	"winter"
'Skipping next part of guide |next "+azshara" |only if step:Find("+winter1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Winterspring,59.8,85.5
.' Discover Frostwhisper Gorge |achieve 857/12
step
goto 64.5,77.2
.' Discover Owl Wing Thicket |achieve 857/9
step
goto 67.8,64.4
.' Discover Ice Thistle Hills |achieve 857/8
step
goto 68.1,48.5
.' Discover Winterfall Village |achieve 857/9
step
goto 59.9,48.9
.' Discover Everlook |achieve 857/6
step
goto 62.7,24.7
.' Discover The Hidden Grove |achieve 857/10
step
goto 45.3,15.4
.' Discover Frostsaber Rock |achieve 857/11
step
goto 47.7,39.1
.' Discover Starfall Village |achieve 857/4
step
goto 51.1,55.1
.' Discover Lake Kel'Theril |achieve 857/3
step
goto 54.8,62.9
.' Discover Mazthoril |achieve 857/5
step
goto 36.4,56.7
.' Discover Timbermaw Post |achieve 857/2
step
goto 31.9,49.3
.' Discover Frostfire Hot Springs |achieve 857/1
step
label	"winter1"
' Explore Winterspring |achieve 857
step
label	"azshara"
'Skipping next part of guide |next "+moon" |only if step:Find("+azshara1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Azshara,52.25,26.95
.' Discover Darnassian Base Camp |achieve 852/4
step
goto 73.69,20.98
.' Discover Bitter Reaches |achieve 852/11
step
goto 80.90,32.34
.' Discover Tower of Eldara |achieve 852/3
step
goto 69.89,34.83
.' Discover Ruins of Arkkoran |achieve 852/12
step
goto 58.29,51.00
.' Discover Bilgewater Harbor |achieve 852/2
step
goto 68.41,75.62
.' Discover Southridge Beach |achieve 852/7
step
goto 64.65,79.31
.' Discover Ravencrest Monument |achieve 852/16
step
goto 56.99,76.50
.' Discover Storm Cliffs |achieve 852/9
step
goto 46.54,76.25
.' Discover The Secret Lab |achieve 852/13
step
goto 39.83,84.67
.' Discover The Ruined Reaches |achieve 852/17
step
goto 35.72,73.99
.' Discover Lake Mennar |achieve 852/8
step
goto 26.75,77.96
.' Discover Orgrimmar Rear Gate |achieve 852/6
step
goto 21.04,57.1
.' Discover Gallywix Pleasure Palace |achieve 852/1
step
goto 39.21,55.46
.' Discover The Shattered Strand |achieve 852/10
step
goto 31.95,50.02
.' Discover Ruins of Eldarath |achieve 852/15
step
goto 25.47,38.00
.' Discover Bear's Head |achieve 852/5
step
goto 33.06,32.76
.' Discover Blackmaw Hold |achieve 852/14
step
label	"azshara1"
' Explore Azshara |achieve 852
step
label	"moon"
'Skipping next part of guide |next "+felwood" |only if step:Find("+moon1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Moonglade,67.8,53.8
.' Discover Stormrage Barrow Dens |achieve 855/4
step
goto 52.5,55.4
.' Discover Lake Elune'ara |achieve 855/1
step
goto 48.2,37.9
.' Discover Nighthaven |achieve 855/2
step
goto 36.3,38.8
.' Discover Shrine of Remulos |achieve 855/3
step
label	"moon1"
' Explore Moonglade |achieve 855
step
label	"felwood"
'Skipping next part of guide |next "+darkshore" |only if step:Find("+felwood1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Felwood,61.2,11.5
.' Discover Felpaw Village |achieve 853/1
step
goto 62.6,26.7
.' Discover Talonbranch Glade |achieve 853/2
step
goto 50.3,26.0
.' Discover Irontree Woods |achieve 853/3
step
goto 43.6,18.6
.' Discover Jadefire Run |achieve 853/4
step
goto 43.1,41.9
.' Discover Shatter Scar Vale |achieve 853/5
step
goto 52.2,78.2
.' Discover Emerald Sanctuary |achieve 853/10
step
goto 56.6,86.8
.' Discover Morlos'Aran |achieve 853/12
step
goto 48.0,89.2
.' Discover Deadwood Village |achieve 853/11
step
goto 41.8,85.4
.' Discover Jadefire Glen |achieve 853/9
step
goto 38.0,72.3
.' Discover Ruins of Constellas |achieve 853/8
step
goto 37.0,59.1
.' Discover Jaedenar |achieve 853/7
step
label	"felwood1"
' Explore Felwood |achieve 853
step
label	"darkshore"
'Skipping next part of guide |next "+teldrassil" |only if step:Find("+darkshore1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Darkshore,40.3,86.2
.' Discover The Master's Glaive |achieve 844/11
step
goto 32.0,84.0
.' Discover Nazj'vel |achieve 844/10
step
goto 42.5,69.5
.' Discover Wildbend River |achieve 844/4
step
goto 43.7,60.5
.' Discover Ameth'Aran |achieve 844/8
step
goto 42.9,54.9
.' Discover The Eye of the Vortex |achieve 844/7
step
goto 37.9,44.1
.' Discover Ruins of Auberdine |achieve 844/1
step
goto 51.2,19.2
.' Discover Lor'danel |achieve 844/9
step
goto 63.9,21.9
.' Discover Ruins of Mathystra |achieve 844/6
step
goto 72.5,17.3
.' Discover Shatterspear Vale |achieve 844/2
step
goto 65.9,7.0
.' Discover Shatterspear War Camp |achieve 844/3
step
label	"darkshore1"
' Explore Darkshore |achieve 844
step
label	"teldrassil"
'Skipping next part of guide |next "+azure" |only if step:Find("+teldrassil1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Teldrassil,55.0,61.0
.' Discover Lake Al'Ameth |achieve 842/6
step
goto 55.6,51.2
.' Discover Dolanaar |achieve 842/3
step
goto 64.7,49.1
.' Discover Starbreeze Village |achieve 842/8
step
goto 58.4,33.0
.' Discover Shadowglen |achieve 842/1
step
goto 50.7,38.0
.' Discover The Cleft |achieve 842/2
step
goto 44.4,34.4
.' Discover Wellspring Lake |achieve 842/10
step
goto 40.0,26.7
.' Discover The Oracle Glade |achieve 842/9
step
goto 30.4,50.1
.' Discover Darnassus |achieve 842/11
step
goto 41.9,56.9
.' Discover Pools of Arlithrien |achieve 842/7
step
goto 44.8,67.4
.' Discover Gnarlpine Hold |achieve 842/5
step
label	"teldrassil1"
' Explore Teldrassil |achieve 842
step
label	"azure"
'Skipping next part of guide |next "+blood" |only if step:Find("+azure1"):IsComplete()
'Proceeding next step |next |only if default
step
goto 52.4,89.3
.' Ride the boat to Azuremyst Isle |tip Make sure to avoid Alliance Guards as best you can
.' Ride to Azuremyst Isle |goto Azuremyst Isle |noway |c
step
goto Azuremyst Isle,23.7,54.0
.' Discover Valaar's Berth |achieve 860/16
step
goto 26.5,65.1
.' Discover Bristlelimb Village |achieve 860/4
step
goto 12.7,78.6
.' Discover Silvermyst Isle |achieve 860/13
step
goto 32.0,79.3
.' Discover Wrathscale Point |achieve 860/17
step
goto 37.0,58.4
.' Discover Pod Cluster |achieve 860/10
step
goto 49.3,50.7
.' Discover Azure Watch |achieve 860/3
step
goto 46.6,72.4
.' Discover Odesyus' Landing |achieve 860/9
step
goto 52.7,61.3
.' Discover Pod Wreckage |achieve 860/11
step
goto 58.3,67.0
.' Discover Geezle's Camp |achieve 860/7
step
goto 61.3,53.6
.' Discover Ammen Ford |achieve 860/2
step
goto 77.6,43.7
.' Discover Ammen Vale |achieve 860/1
step
goto 52.7,41.8
.' Discover Moongraze Woods |achieve 860/8
step
goto 29.2,35.1
.' Discover The Exodar |achieve 860/15
step
goto 35.3,12.4
.' Discover Silting Shore |achieve 860/12
step
goto 46.0,20.0
.' Discover Stillpine Hold |achieve 860/14
step
goto 58.8,17.6
.' Discover Emberglade |achieve 860/5
step
goto 47.7,6.6
.' Discover Fairbridge Strand |achieve 860/6
step
label	"azure1"
' Explore Azuremyst Isle |achieve 860
step
label	"blood"
'Skipping next part of guide |next "+end" |only if step:Find("+blood1"):IsComplete()
'Proceeding next step |next |only if default
step
goto Bloodmyst Isle,61.9,90.0 |kessel's crossing
step
goto 57.4,81.0
.' Discover The Lost Fold |achieve 861/22
step
goto 67.0,78.2
.' Discover Bristlelimb Enclave |achieve 861/7
step
goto 69.0,66.6
.' Discover Wrathscale Lair |achieve 861/27
step
goto 85.4,52.8
.' Discover Bloodcurse Isle |achieve 861/5
step
goto 72.0,29.6
.' Discover Wyrmscar Island |achieve 861/28
step
goto 73.4,20.9
.' Discover Talon Stand |achieve 861/14
step
goto 81.0,20.1
.' Discover The Bloodcursed Reef |achieve 861/16
step
goto 74.4,7.5
.' Discover Veridian Point |achieve 861/25
step
goto 62.6,25.4
.' Discover The Crimson Reach |achieve 861/16
step
goto 54.2,17.1
.' Discover The Warp Piston |achieve 861/24
step
goto 56.1,34.9
.' Discover Ragefeather Ridge |achieve 861/12
step
goto 61.6,45.2
.' Discover Ruins of Loreth'Aran |achieve 861/13
step
goto 54.6,55.4
.' Discover Blood Watch |achieve 861/6
step
goto 51.7,76.6
.' Discover Middenvale |achieve 861/9
step
goto 43.9,84.7
.' Discover Mystwood |achieve 861/10
step
goto 33.2,90.3
.' Discover Blacksilt Shore |achieve 861/3
step
goto 37.9,75.7
.' Discover Nazzivian |achieve 861/11
step
goto 38.5,59.5
.' Discover The Cryo-Core |achieve 861/19
step
goto 45.9,45.1
.' Discover Bladewood |achieve 861/4
step
goto 40.8,33.0
.' Discover Axxarien |achieve 861/2
step
goto 38.7,21.9
.' Discover The Bloodwash |achieve 861/17
step
goto 32.7,19.8
.' Discover The Hidden Reef |achieve 861/21
step
goto 29.2,36.8
.' Discover The Foul Pool |achieve 861/20
step
goto 30.2,46.2
.' Discover Vindicator's Rest |achieve 861/26
step
goto 24.4,41.2
.' Discover Tel'athion's Camp |achieve 861/15
step
goto 18.8,30.9
.' Discover Amberweb Pass |achieve 861/1
step
goto 18.0,53.4
.' Discover The Vector Coil |achieve 861/23
step
label	"blood1"
' Explore Bloodmyst Isle |achieve 861
step
label "end"
' Congratulations! You have Explored Kalimdor |achieve 43 |only if achieved(43)
' Congratulations! You have Explored Cataclysm |achieve 4868 |only if achieved(4868)
' Congratulations! You have Earned the Achievement World Explorer! |achieve 46 |only if achieved(46)
.' You have not fully explored Kalimdor |only if not achieved(43)
|confirm |next "start" |only if not achieved(43)
]])
