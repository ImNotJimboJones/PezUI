local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("DungeonAMOP") then return end
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Dungeon Guides\\Classic Dungeons\\Ragefire Chasm (RFC) 15-18",[[
dungeon 680
description This guide will walk you through the Ragefire Chasm dungeon.
author support@zygorguides.com
step
'How do you want to enter this dungeon:
.' Take me to the dungeon entrance |confirm |next
.' I will use the Dungeon Finder |confirm |next "start"
step
goto Orgrimmar/2 70.2,48.8 |n
.' Enter Ragefire Chasm here. |goto Ragefire Chasm |c
step
label	"start"
goto Ragefire Chasm 69.4,11.0
.talk 61823
..accept 30998
..accept 30996
step
goto 68.3,12.8
.talk 61822
..accept 30997
..accept 30995
step
'Follow this path down, but look out for rising lava. If you see lava rising up, wait for it to go back down before crossing |goto 65.9,21.6 <5
step
'_As you go through this Dungeon:_
.from Corrupted Houndmaster##61666+, Corrupted Flamecaller##61705+, Dark Shaman Acolyte##61672+, Corrupted Reaver##61678+
.get 5 Corrupted Insignia |q 30998/1 |n
|confirm
|only if not completedq(30998)
step
goto 68.7,64.2
.from Adarogg##61408 |only if not havequest(30997)
.kill Adarogg##61408 |q 30997/1 |only if havequest(30997)
|confirm |only if not havequest(30997)
step
goto 65.0,70.8
.talk 61780
.' Tell him:
.' <It's Safe to come out now.>
|confirm
|only if not completedq(30995)
step
'Follow this path up, but look out for rising lava. If you see lava rising up, wait for it to go back down before crossing. |goto 61.5,69.1 <5
step
goto 53.0,26.1
.talk 61790
.' Tell him:
.' <It's Safe to come out now.>
|confirm
|only if not completedq(30995)
step
goto 51.8,31.7
.from Dark Shaman Koranthal##61412 |only if not havequest(30996)
.kill Dark Shaman Koranthal##61412 |q 30996/1 |only if havequest(30996)
|confirm |only if not havequest(30996)
step
goto 38.6,58.6
.from Slagmaw##61463 |only if not havequest(30997)
.kill Slagmaw##61463 |q 30997/2 |only if havequest(30997)
|confirm |only if not havequest(30997)
step
goto 42.8,66.5
.clicknpc SI:7 Ranger##61788
|confirm
|only if not completedq(30995)
step
goto 33.7,81.4
.from Lava Guard Gordoth##61528 |only if not havequest(30996)
.kill Lava Guard Gordoth##61528 |q 30996/2 |only if havequest(30996)
|confirm |only if not havequest(30996)
step
goto 36.1,84.3
.click Scout Cages
.' Rescue 5 SI:7 Rangers |q 30995/1
|modelnpc SI:7 Ranger##61788
|only if havequest(30995)
step
'_Make sure you have:_
.from Corrupted Houndmaster##61666+, Corrupted Flamecaller##61705+, Dark Shaman Acolyte##61672+, Corrupted Reaver##61678+
.get 5 Corrupted Insignia |q 30998/1
|only if havequest(30998)
step
goto 33.5,80.6
.talk 61823
..turnin 30998
..turnin 30996
step
goto 31.7,76.5
.talk 61822
..turnin 30997
..turnin 30995
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Dungeon Guides\\Classic Dungeons\\Deadmines (DM) 15-18",[[
dungeon 756
description This guide will walk you through the Deadmines dungeon.
step
'How do you want to enter this dungeon:
.' Take me to the dungeon entrance |confirm |next "entrance"
.' I will use the Dungeon Finder |confirm |next "start"
step
label "entrance"
goto Westfall,42.5,71.7 |n
.' Enter the Defias Hideout here. |goto Westfall 42.5,71.7 <5 |noway |c
step
.' Follow the stairs up. |goto 43.4,71.9 <5 |c
step
.' Follow the path down and around.
.' Go straight here. |goto 42.5,75.4 <5 |noway |c
step
goto 41.1,76.5 |n
.' Keep follwing this path straight. |goto 41.1,76.5 <5 |noway |c
step
goto 41.8,78.5 |n
.' Follow the path to the right. |goto 41.8,78.5 <5 |noway |c
step
goto 38.3,77.5 |n
.' Enter the Deadmines here. |goto The Deadmines |noway |c
step
label "start"
goto The Deadmines 30.3,28.6
.talk 46612
..accept 27756
step
goto 37.7,61.2
.from Glubtok##47162 |only if not havequest(27756)
.kill Glubtok##47162 |q 27756/1 |only if havequest(27756)
|confirm |only if not havequest(27756)
|only if not heroic_dung()
step
goto 37.7,61.2
.' _Glubtok_
.' Phase 1:
.' He will _Blink_ occasionally, dropping threat of all enemies. The tank will need to provoke immediately after.
.' Phase 2:
.' When he casts _Fire Blossom_, Fire Blossom creatures spawn and need to be picked up by the tank.
.' When he casts _Frost Blossom_. Frost Blossom Creatures spawn and need to be picked up by the tank.
.from Glubtok##47162 |only if not havequest(27756)
.kill Glubtok |q 27756/1 |only if havequest(27756)
|confirm |only if not havequest(27756)
|only if heroic_dung()
step
.' Click the Quest Completion Box that pops up.
..turnin 27756
step
goto 43.8,79.6
.click Heavy Door##400
|confirm
step
.' Once inside, click the Quest Discovered Box that pops up.
..accept 27758
step
goto 49.0,87.4 |n
.from Lumbering Oaf##47297
.from Helix Gearbreaker##47296 |only if not havequest(27758)
..kill Helix Gearbreaker##47296 |q 27758/1 |only if havequest(27758)
|confirm |only if not havequest(27758)
|only if not heroic_dung()
step
goto 49.0,87.4 |n
.from Lumbering Oaf##47297
.' Phase 1 (Lumbering Oaf):
.' Avoid _Sticky Bombs_ on the ground.
.' The Lumbering Oaf will periodically use _Oaf Smash_, picking up a player and slamming them, dealing 100% of the players health as damage.
.' The Lumbering Oaf will use _Throw Helix_ onto a player for 10 seconds,
.' After Throw Helix, there will be a _Chest Bomb_ on the player, dealing 46k-57k fire damage.
.' _Helix' Crew_ throws bombs at random players throughout the entire fight.
.' Phase 2:
.' Helix will use _Leap_ to random players, attacking for 10 seconds before moving to the next.
.' After Throw Helix, there will be a _Chest Bomb_ on the player, dealing 46k-57k fire damage.
.from Helix Gearbreaker##47296 |only if not havequest(27758)
..kill Helix Gearbreaker##47296 |q 27758/1 |only if havequest(27758)
|confirm |only if not havequest(27758)
|only if heroic_dung()
step
.' Click the Quest Completion Box that pops up.
..turnin 27758
step
goto 61.0,75.0
.click Heavy Door##400
|confirm
step
.' Click the Quest Completion Box that pops up.
..accept 27781
step
.' Clear the Goblin Foundry of Defias Watchers.
.from Defias Watcher##47404+
|confirm
step
goto The Deadmines/2 10.0,82.7
.from Foe Reaper 5000##43778 |only if not havequest(27781)
..kill Foe Reaper 5000##43778 |q 27781/1 |only if havequest(27781)
|confirm |only if not havequest(27781)
|only if not heroic_dung()
step
goto The Deadmines/2 10.0,82.7
.' _Foe Reaper 5000_
.' If you're the _Prototype Reaper_ pilot, click here. |confirm |next "Proto_Reap"
.' The Foe Reaper 5000 will use _Overdrive_ which will cause it to move around randomly, attacking anyone near him as well as knocking them back.
.' It will also use _Harvest_ which targets a random player, the move to where they are. It attacks anyone in front of him within a 60 degree cone. Once at the target location, it will preform a sweep attack, dealing damage to anyone within 10 yards.
.' At 30% of his total health, he will use _Safety Restrictions Off-line_ which increases his damage by 100% for the duration of the fight.
.' Avoid being in it's path when it uses it's abilities and you should be fine.
.from Foe Reaper 5000##43778 |only if not havequest(27781)
..kill Foe Reaper 5000##43778 |q 27781/1 |only if havequest(27781)
|confirm |next "canon_blast" |only if not havequest(27781)
|only if heroic_dung()
step
label "Proto_Reap"
.' You will spend your time at the bottom of the ramp, waiting for _Molten Slag_ to spawn.
.' You will have 2 abilities to use to control the adds.
.' Use _Reaper Strike_ twice in a row, then use _Reaper Charge_ to stun them.
.' Repeat this until they are defeated.
.from Molten Slag##49229+
|confirm
|only if heroic_dung()
step
label "canon_blast"
.' Click the Quest Completion Box that pops up.
..turnin 27781
step
goto The Deadmines/2 27.9,52.7
.click Defias Cannon##245
|confirm
step
.' Click the Quest Completion Box that pops up.
..accept 27785
step
.' Proceed along the docks avoiding the cannonballs that are being shot at the ground. |goto 53.0,20.7 <5 |noway|c
step
'Follow the ramp up to the top of the ship. |goto 57.8,33.4 <5 |c
step
goto 63.9,39.5
.' _Admiral Ripsnarl_
.' Has a _Swipe_ ability, so attack him from behind.
.' Has the _Thirst for Blood_ ability, moving faster and gaining attack speed each time he hits, stacking up to 20 times) |only if heroic_dung()
.' He will use _Go For the Throat_ through the entire fight. It damages then stuns targets for 2 seconds. |only if heroic_dung()
.' At 75%, 50% and 25% He will summon a fog.
.' During the fog, he will _Summon Vapors_ which need to be killed as soon as possible. They will grow larger before they explode, potentially killing anyone nearby. |only if heroic_dung()
.from Admiral Ripsnarl##47626 |only if not havequest(27785)
.kill Admiral Ripsnarl##47626 |q 27785/1 |only if havequest(27785)
|confirm |only if not havequest(27785)
step
.' Click the Quest Completion Box that pops up.
..turnin 27785 |only if havequest(27785)
..accept 27790
step
goto 60.6,44.5
.' _"Captain" Cookie_
.' He will throw food on the ground. If it does not say _Rotten_ then it's safe to click. You will get a haste buff each time you consume food.
..from "Captain" Cookie##47739 |only if not havequest(27790)
..kill "Captain" Cookie##47739 |q 27790/1 |only if havequest(27790)
|confirm |only if not havequest(27790)
step
.' A note will appear on the ground
.' Don't click it until your group is ready, it will start the _Vanessa VanCleef_ event.
.' Once you click it, Vanessa will come out and poison you.
.' When you awaken you'll be suspended above a lava pool. |goto 12.7,80.1 <8 |c
|only if heroic_dung()
step
goto 12.4,71.8
.' Click the _Vent Lever_ to avoid being lowered into the Lava. There will be green arrows indicating where the levers are.
.' Once you click it, you will land at the top of the spiral stairs.
.' You will be dazed and fires will appear. _Avoid the fires at all cost_ they deal out massive damage.
.' Make your way down the ramp. |goto 12.4,71.8 <5 |c
|only if heroic_dung()
step
.from Glubtok##47162
.' After you defeat Glubtok, _Helix Gearbreaker_  will appear at the door.
.' The group needs to collapse at the door, as spiders will spawn and fill the room.
.' Avoid aggroing the spiders if possible.
.from Helix Gearbreaker##47296
|confirm
|only if heroic_dung()
step
goto 29.5,50.2
.' Once the doors open there will be several rotating chains of sparks that you have to avoid as you progress.
.' Most of the time, if you touch them you will be killed, so avoid them while making your way to the coordinates.
.from Foe Reaper 5000##43778
.' Note that you should let your tank go first, since the boss will aggro.
|confirm
|only if heroic_dung()
step
goto 51.6,44.7
.' Follow the deck onto the ship.
.' You will need to save _Emma Harrington_, _Erik Harrington_ and _Calissa Harrington_ from the worgen.
.' Kill any packs of Worgen that you see.
.' Once you're at _Calissa Harrington_, burn down _Admiral Ripsnarl_ fast.
|confirm
|only if heroic_dung()
step
goto 58.9,38.7
.' Make your way back up to the main part of the ship. |goto 58.9,38.7 <5 |noway|c
|only if heroic_dung()
step
.' _Vanessa VanCleef_
.' She will use _Deflection_, which deflects all ranged, melee and spell attacks for 10 seconds. She will use the ability when her health is higher than 25%.
.' She will use _Deadly Blades_, randomly attack party members.
.' She will use _Backslash_ dealing 9k to 10k damage.
.' At 50%, she will use _Fiery Blaze_ which deals 46k to 53k fire damage every second. When this happens, ropes will appear at the end of the deck. Click them to avoid the damage.
.' There will also be adds that need to be picked up by the tank.
.' When Vanessa is at 1% of her total health, she will use _Powder Explosion_, Move as far away from her as possible to avoid death.
.from Vanessa VanCleef##49541
|confirm
|only if heroic_dung()
step
goto 60.9,38.8
.talk 46612
..turnin 27790
]])
ZygorGuidesViewer:RegisterGuide("Zygor's Alliance Dungeon Guides\\Classic Dungeons\\Wailing Caverns (WC) 18-23",[[
dungeon 749
description This guide will walk you through the Wailing Caverns dungeon.
step
'How do you want to enter this dungeon:
.' Take me to the dungeon entrance |confirm |next
.' I will use the Dungeon Finder |confirm |next "start"
step
map Northern Barrens
path loop off
path	39.0,69.3	39.5,66.8	39.1,65.1
path	38.8,63.3	39.9,62.3	41.3,63.0
path	41.7,65.2	42.1,66.5
.' Follow this path and enter Wailing Caverns. |goto Wailing Caverns |noway |c
step
label "start"
goto Wailing Caverns 46.6,59.2
.talk 5768
..accept 26870
step
goto 46.6,58.4
.talk 5767
..accept 26872
..accept 26873
step
' Do the following as you move through the instance
.from Deviate Ravager##3636+, Deviate Guardian##3637+, Deviate Crocolisk##5053+
..get 10 Deviate Hide |q 26872/1
.click Serpentbloom##390+
..get 5 Serpentbloom |q 26873/1
|confirm
step
goto 29.7,43.9
.from Lady Anacondra##3671 |only if not havequest(26870)
.kill Lady Anacondra##3671 |q 26870/2 |only if havequest(26870)
|confirm |only if not havequest(26870)
step
map Wailing Caverns
path loop off; strict
path	28.2,40.1	19.6,45.2	9.2,33.5
path	13.7,33.9	19.8,41.6
.' Jump in the water and follow this path
.from Lord Pythas##3670 |only if not havequest(26870)
..kill Lord Pythas##3670 |q 26870/3 |only if havequest(26870)
|confirm |only if not havequest(26870)
step
map Wailing Caverns
path loop off; strict
path	17.4,28.3	15.4,24.1	5.7,27.8
path	15.6,58.4
.' Follow this path and kill Lord Cobrahn.
.from Lord Cobrahn##3669 |only if not havequest(26870)
..kill Lord Cobrahn##3669 |q 26870/1 |only if havequest(26870)
|confirm |only if not havequest(26870)
step
goto 15.8,51.8 |n
.' Jump down here and follow the path to the right. |goto 15.8,51.8 <5 |noway |c
step
.' If you haven't already killed Kresh, then you will find him walking in this little river.
.from Kresh##3653
|confirm
step
goto 60.7,72.1
.from Skum##3674
|confirm
step
goto 55.0,87.6 |n
.' Follow this path up and around. |goto 55.0,87.6 <5 |noway |c
step
map Wailing Caverns
path follow strict; loop off
path	54.8,83.1	55.2,71.7	50.7,61.8
path	72.8,67.7	69.2,82.9	54.4,76.3
path	54.6,60.4	62.2,53.8
.from Lord Serpentis##3673 |only if not havequest(26870)
.kill Lord Serpentis##3673 |q 26870/4 |only if havequest(26870)
|confirm |only if not havequest(26870)
step
goto 56.4,47.5
.from Verdan the Everliving##5775
|confirm
step
goto 54.5,39.5 |n
.' Jump down this hole. |goto 54.5,39.5 <5 |noway |c
step
goto Wailing Caverns,46.6,59.2
.talk 5768
..turnin 26870
step
goto 46.6,58.4
.talk 5767
..turnin 26872
..turnin 26873
step
goto 46.5,56.0
.talk 3678
.' Tell him
.' <Let the event begin!>
|confirm
step
goto 37.1,20.9 |n
.' Escort and Protect Muyoh until you get to the boss. |goto 37.1,20.9 <5 |noway |c
step
goto 34.0,15.6 |n
.' Protect Muyoh
.' There will be 2 waves of mobs that attack him, then the boss will appear.
.from Mutanus the Devourer##3654
]])
ZygorGuidesViewer:RegisterGuideSorting({
"Classic Dungeons",
"Outland Dungeons",
"Northrend Dungeons",
"Cataclysm Dungeons"})
