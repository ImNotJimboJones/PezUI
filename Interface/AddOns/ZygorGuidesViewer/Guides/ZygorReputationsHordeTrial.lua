local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("ReputationsH") then return end
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
ZygorGuidesViewer:RegisterInclude("port_vashj'ir",[[
goto Orgrimmar,49.2,36.5
.' Click the Portal to Vashj'ir |tip It's a big blue swirling portal.
.' Teleport to Vashj'ir |goto Vashj'ir |noway |c
]])

ZygorGuidesViewer:RegisterInclude("rideto_borean",[[
goto Orgrimmar,44.7,62.4 |n
.' Ride the zeppelin to Borean Tundra |goto Borean Tundra |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_tirisfal",[[
goto Orgrimmar,50.8,55.8 |n
.' Ride the zeppelin to Tirisfal Glades |goto Tirisfal Glades |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_bootybay",[[
goto Orgrimmar,52.5,53.2 |n
.' Ride the zeppelin to Stranglethorn Vale |goto Northern Stranglethorn |noway |c
step
|fly Booty Bay
]])
ZygorGuidesViewer:RegisterInclude("rideto_howlingfjord",[[ //this one goes from Org to Tirisfal Glades to Howling Fjord
goto Orgrimmar,50.8,55.8 |n
.' Ride the zeppelin to Tirisfal Glades |goto Tirisfal Glades |noway |c
step
goto Tirisfal Glades,59.1,59.0 |n
.' Ride the zeppelin to Howling Fjord |goto Howling Fjord |noway |c
]])
ZygorGuidesViewer:RegisterInclude("rideto_org",[[ //coming from UC
.' Go to Tirisfal |goto Tirisfal Glades |noway |c
step
goto Tirisfal Glades,60.7,58.8 |n
.' Ride the Zeppelin to Orgrimmar |goto Orgrimmar |noway |c
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Horde Reputations Guides\\Azeroth\\Timbermaw Hold Faction",[[
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
.from Chieftain Bloodmaw##9462+
.collect Drizle's Key##63695 |q 28364
step
goto 60.6,9.5
.talk 47556
.turnin 28364
step
goto 62.0,12.8
.kill 15 Deadwood Furbolg |q 28338/1
..get 7 Deadwood Weapons |q 28366/1 |tip They Look like a pile of weapons on the ground.
..collect Deadwood Ritual Totem##20741 |n
..accept 8470
.' You can find more around [Felwood,59.7,9.8].
step
goto 64.0,10.3
.talk 15395
..turnin 28338
..turnin 28366
..accept 28521 |tip You may not be able to accept this quest.
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
..kill 15 Winterfall Furbolg |q 28460/1
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
.from Winterfall Runner##10916+
.collect Winterfall Crate |q 28469/1
.' They walk along the road so some searching may be required.
step
goto 32.7,50.6
.from Scalding Springsurge##48767+,Boiling Springbubble##48768+
.collect 7 Suspicious Green Sludge |q 28530/1
step
goto 25.1,58.5
.talk 9298
..turnin 28469
..turnin 28530
..accept 28470
.' You should be honored with Timbermaw Hold at this point.
step
goto 37.0,55.6
..kill High Chief Winterfall |q 28470/1
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
.' Use Tanrir's Overcharged Totem to overload Winterfall Earth Totems. |use Tanrir's Overcharged Totem##64637
..goal 4 Winterfall Earth Totem overloaded |q 28615/1
step
goto 69.3,50.6
..kill Grolnar the Berserk |q 28614/1
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
.' More Beads for Salfa requires that you grind in Winterspring.  You collect 5 Winterfall Spirit Beads, which are worth 2,000 Reputation per turn in.  Click here to farm at the Winterspring location. |confirm always |next "winterfall"
.' or
.' Feathers for Nafien requires that you grind in Felwood. You collect 5 Deadwood Headdress Feathers, which are worth 2,000 Reputation per turn in.  Click here to farm at the Felwood location. |confirm always |next "deadwood" |tip         
.' Collecting 65 Beads/Feathers will get you from Honored to exalted.
step
label	"winterfall"
goto 67.5,49.8
.from Winterfall Shaman##7439+,Winterfall Ursa##7438+
..collect Winterfall Spirit Beads##21383 |n |tip You need to collect at least 5.
.' 5 Winterfall Spirit Beads = 2,000 Reputation. You're aiming for at least 60 to 65 Winterfall Spirit Beads in total.
.' More can be found at [Winterspring,35.6,56.3]
.' Click here to turn in your beads |confirm always
step
goto 21.1,46.2
.talk 11556
..accept 28523 |instant |repeatable        |tip                                          
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
.' Click here to turn in your feathers |confirm always |next "turnin"
step
label	"turnin"
goto 64.0,10.3
.talk 15395
 ..accept 28395 |instant |repeatable |tip 
.' Click here to go back to grinding. |confirm |next "the_grind" |or
.' Exalted with Timbermaw Hold |next "exalted" |condition rep('Timbermaw Hold')==Exalted 
step
label	"exalted"
.' Congratulations, you are now Exalted with Timbermaw Hold!
]])
